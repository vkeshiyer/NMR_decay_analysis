%% Initialization.

clear
clc
close all hidden

%% Path to subroutines.

addpath('relaxation_semiparametric');

%% Random stream.

random_seed = round( sum( 1e6 * clock() ) );
s = RandStream('mt19937ar', 'Seed', random_seed);
RandStream.setGlobalStream(s);

%% Simulate data set.

t = linspace(0, 1e2, 64);
t = t(:);

I = signal(t, {{'lognormal'}}, [-0.75, 0.5, 1e-2, 1, 1]);

sigma_error = 0.0;
I = I + sigma_error * randn(size(I));

%% Model and fit parameters.

% Number of fits (with random initializations).
number_of_fits = 3;

% Number of Monte Carlo repetitions (0 = no error analysis).
number_of_mc_fits = 0;

% Type of model (combine exponential, stretched exponential, lognormal, and
% gamma freely)
% model = {{'inversegamma'}, {'exponential'}};
% model = {{'lognormal'}};
model = {{'inversegamma'}};

% Baseline toggle.
baseline = true;

%% Fit model and estimate parameters.

fit = analyze(t, I, model, baseline, number_of_fits, number_of_mc_fits);

%% Print results.

print_results(fit);

%% Plot fit and residuals.

plot_fit_and_residuals(t, I, fit);

%% Plot distribution of T.

plot_distribution(fit);