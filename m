Return-Path: <linux-kernel+bounces-561152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387EAA60E1D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB2E17EBC4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7B21F4723;
	Fri, 14 Mar 2025 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DcTMC4z0"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F97C1F4170
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946487; cv=none; b=Zqw3CvICbA0PPM2C4aFtnWeADvfJom8WosP4sLpykpEBqN+VWAeY7xeeMVAR4tnHIfxzTv5gzJua1WSnBFT3ozeqyRH6fA2+37d399B90S0ksn5LhyAzjvaaC9ryQptzdJ3rmwhM4o0TPyv4j3EZbL5AE6wr2f9Im8zYzkp2h5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946487; c=relaxed/simple;
	bh=ku7eBoH8HGNNqu6WgR7epnSx7DurvY3KB0R4PNQ8EGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qk3qsOQ/pVGJpKSw16TfmrNL3weiMVadAjw9o0lhrT7elO7OHMUYBa9ODjxZfw2XDhZMW1Tjsocs/6NxIlnFzNcIXnr5MsQKh9uMHfqBsGbLGvdEi8crgOsNbGE8m7oFpzPpE2/SnMruRbKRyslmUDj6APV/6WN9W9GmaNFNPZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DcTMC4z0; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30761be8fa8so20827621fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741946483; x=1742551283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QggTlpxLWEC50ONNabSeYB6RhPieGr2Z8I7fdFvhr8=;
        b=DcTMC4z0e7embT0ZS37lE5r2pp3Acr3idH6UThu+6J9MYC5jxkC+ylaSX+VaVCmby3
         oInTXj7WoA3QOj60xf55SPz/S7igMRwRQefqab0Zhqr4ZNRutVJcgWCH/haDona/Nw1c
         uQV7km+wUOYntCNMJnOvxRQJLEgNIdYgH4CW7tiuHyuDF7m9Q5TgOM8KrXQwqAu4RKcj
         h2ysZ4TBe6lP1OUd2X+CyWQ1t8cE63gs3sWdjEThR7Z6JpIfzwqISSmlZ9cCqXDDSKm8
         I4FBvbd24jJW9BY5IxVQR9juwTmB1cPGitGTJ0fnIq+ib07NaKy+x9b8u6UKMl9vttLv
         GSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946483; x=1742551283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QggTlpxLWEC50ONNabSeYB6RhPieGr2Z8I7fdFvhr8=;
        b=eIzPeZg0q/E+bMHOByPwUTfgYY1VtPG4MA15D8F8Ct2JrOh+HcaLRSyjxEuVJpXmTf
         hvYwU0Xz+mN8BdciOw14UCjoqP4SirYEFnHFloXZ0Ai8RgCLkQ7dlcgltQJDG3EURjK5
         WR9/kH5PJmCu3S23WN7Z64NzJc5SdfsyczCcMwZNeWnj3uX6AqB4dD927kol57t6GEvd
         8a371viWpmwUYDrxXX3uVTnIvAnW8Kgf05ROMSYb0/CjVCtackHlqt8rMIHAMfhLelaK
         wG/qDIKN/DCMVOLifMzLNkVt3GrlLhpy9B/2D/GScbCN3/WIANeGLCmlolYXZ2Noawr3
         Tj4g==
X-Forwarded-Encrypted: i=1; AJvYcCU99H6eKnANpxzpUCkXNwTwenx4ecWVDaGear9mWCyrF1MKoQJSeDYQ24HFa2PzYl+l5grdH15NHrAer4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCj7jdb3YZQxPzBvcYUpU0VlY639PX0gLAxpi0S1ZLBXIkfuLC
	MrouAuQs2hLI9NgpozIOodFdaR/HGtMVGzpmWbLPG+azuUHB6zUQBG/Pgr3RFxo=
X-Gm-Gg: ASbGnctR5W8stsVDv5HQO6lmqmi6UvITIWs2EFYFZrXsJ5ht9vurDnauL3DXY79kBcg
	a/ujvRpuxGwsu3ljv8vMd9Ha1NjBAUJCcl4IWZqkNZNsiVC2IRhozpzn5ThyebO1a20fzPVO8t+
	KhRLs1I7HmsL1JLn95Dc1mH4RKyql8dyNi7qArYomDgxMvggf1Cq5KnyN4SOhwL5Rudmr+m0ibd
	BD7xxg1d2JtgW5ZgfGjVr+1pzNt02BnzyAtePOtA5PSclBdZbz9N6EoUly8Cl2KZCaMXo4xZ+6o
	zdQROx5pAwNWCA4o0h+N8a9dxZ3KKx5pj85ssgoiVha1aDf5XC18hy4xueQ6cIfi0BbrKMcqJ9+
	jI3sPtrmeNibiC7fwweA=
X-Google-Smtp-Source: AGHT+IF3JWP6a57uvsfs3rKVvgBqgJHjNxLdTktMEECCgzMKQtOboYvvcrBZ2wGvWzv5dk6aRgujQw==
X-Received: by 2002:a2e:88c9:0:b0:30b:8e06:86a3 with SMTP id 38308e7fff4ca-30c4a8665c1mr5313131fa.16.1741946483423;
        Fri, 14 Mar 2025 03:01:23 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0ea468sm5168221fa.41.2025.03.14.03.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:01:22 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] pmdomain: core: Add residency reflection for domain-idlestates to debugfs
Date: Fri, 14 Mar 2025 11:00:58 +0100
Message-ID: <20250314100103.1294715-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314100103.1294715-1-ulf.hansson@linaro.org>
References: <20250314100103.1294715-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For regular cpuidle states we are reflecting over the selected/entered
state to see if the sleep-duration meets the residency for the state. The
output from the reflection is an "above" value to indicate the number of
times the state was too deep and a "below" value for the number of times it
was too shallow.

Let's implement the similar thing for genpd's domain-idlestates along with
genpd's governor and put the information in the genpd's debugfs.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c     | 40 ++++++++++++++++++++++++++++++++++---
 drivers/pmdomain/governor.c |  2 ++
 include/linux/pm_domain.h   |  4 ++++
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index c79ef6e3ab85..3327de2f9ed2 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -304,10 +304,40 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
 
 	genpd->accounting_time = now;
 }
+
+static void genpd_reflect_residency(struct generic_pm_domain *genpd)
+{
+	struct genpd_governor_data *gd = genpd->gd;
+	struct genpd_power_state *state, *next_state;
+	unsigned int state_idx;
+	s64 sleep_ns, target_ns;
+
+	if (!gd || !gd->reflect_residency)
+		return;
+
+	sleep_ns = ktime_to_ns(ktime_sub(ktime_get(), gd->last_enter));
+	state_idx = genpd->state_idx;
+	state = &genpd->states[state_idx];
+	target_ns = state->power_off_latency_ns + state->residency_ns;
+
+	if (sleep_ns < target_ns) {
+		state->above++;
+	} else if (state_idx < (genpd->state_count -1)) {
+		next_state = &genpd->states[state_idx + 1];
+		target_ns = next_state->power_off_latency_ns +
+			next_state->residency_ns;
+
+		if (sleep_ns >= target_ns)
+			state->below++;
+	}
+
+	gd->reflect_residency = false;
+}
 #else
 static inline void genpd_debug_add(struct generic_pm_domain *genpd) {}
 static inline void genpd_debug_remove(struct generic_pm_domain *genpd) {}
 static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
+static inline void genpd_reflect_residency(struct generic_pm_domain *genpd) {}
 #endif
 
 static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
@@ -982,6 +1012,9 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 	if (genpd_status_on(genpd))
 		return 0;
 
+	/* Reflect over the entered idle-states residency for debugfs. */
+	genpd_reflect_residency(genpd);
+
 	/*
 	 * The list is guaranteed not to change while the loop below is being
 	 * executed, unless one of the parents' .power_on() callbacks fiddles
@@ -3517,7 +3550,7 @@ static int idle_states_show(struct seq_file *s, void *data)
 	if (ret)
 		return -ERESTARTSYS;
 
-	seq_puts(s, "State          Time Spent(ms) Usage          Rejected\n");
+	seq_puts(s, "State          Time Spent(ms) Usage      Rejected   Above      Below\n");
 
 	for (i = 0; i < genpd->state_count; i++) {
 		struct genpd_power_state *state = &genpd->states[i];
@@ -3537,9 +3570,10 @@ static int idle_states_show(struct seq_file *s, void *data)
 			snprintf(state_name, ARRAY_SIZE(state_name), "S%-13d", i);
 
 		do_div(idle_time, NSEC_PER_MSEC);
-		seq_printf(s, "%-14s %-14llu %-14llu %llu\n",
+		seq_printf(s, "%-14s %-14llu %-10llu %-10llu %-10llu %llu\n",
 			   state->name ?: state_name, idle_time,
-			   state->usage, state->rejected);
+			   state->usage, state->rejected, state->above,
+			   state->below);
 	}
 
 	genpd_unlock(genpd);
diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
index d1a10eeebd16..c1e148657c87 100644
--- a/drivers/pmdomain/governor.c
+++ b/drivers/pmdomain/governor.c
@@ -392,6 +392,8 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 		if (idle_duration_ns >= (genpd->states[i].residency_ns +
 		    genpd->states[i].power_off_latency_ns)) {
 			genpd->state_idx = i;
+			genpd->gd->last_enter = now;
+			genpd->gd->reflect_residency = true;
 			return true;
 		}
 	} while (--i >= 0);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 6e808aeecbcb..0b18160901a2 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -142,6 +142,8 @@ struct genpd_governor_data {
 	bool max_off_time_changed;
 	ktime_t next_wakeup;
 	ktime_t next_hrtimer;
+	ktime_t last_enter;
+	bool reflect_residency;
 	bool cached_power_down_ok;
 	bool cached_power_down_state_idx;
 };
@@ -153,6 +155,8 @@ struct genpd_power_state {
 	s64 residency_ns;
 	u64 usage;
 	u64 rejected;
+	u64 above;
+	u64 below;
 	struct fwnode_handle *fwnode;
 	u64 idle_time;
 	void *data;
-- 
2.43.0


