Return-Path: <linux-kernel+bounces-561151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE2EA60E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31E61B606F1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4541F17E9;
	Fri, 14 Mar 2025 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DcE4pEPm"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4188F1F3D55
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946486; cv=none; b=ZQiik970hQmel5FxiYPBBbw/xA96WqscvOaSnqSI9iXsPe8PGpklh8UmrG6/RkzU4TlHs/qFhkRrA9oD9H5y0ae7xYd71ZvnyxlT4VJIUu0MsvEgRug8dibcjrzlcw7+zplOKedEmMlXhWHc230uwHtWb3y22/pnVT7sVfzyA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946486; c=relaxed/simple;
	bh=kmzppo3sBM/QV1rz6m712RRfo3KqArFiDhfB5PEpOUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvncVnIyusx+urD6ybzoRYil5ByIR3dEZYQ0szfzHRBxETWQTQWms/Vq69HQC8mJqPeiyO5dFO5oX1Ci0nt6J1Cpi46gu2FXNSB8OdR9h6N+z/3YREjv9paqWMzkecgFc+0MOtRBXNphYRduOh5RW61WVW7fedK5EWE2mohCGr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DcE4pEPm; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bd11bfec6so19049931fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741946482; x=1742551282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Suz7cKLNuXGtB0nBu0oVhma/Td/1dTahkXdO6vQ+7gU=;
        b=DcE4pEPm/EGg3J7fiN1SHZM6XiO9zO0YcIUR9hy8zZfp1Co/oZjb4mKjHZUgYqrYqK
         465tqUBoHmtP03c/FSt3hXRZmxPSGRip62zUhY81O3gV2OCDNf0F1MGMOziDSY11Uyz0
         WqyCW6EUb2wI+PF1pF9DgPyhFOKenxQly0fbrbF5cHUiA8QhssQ4mHKNraPJJZJo76/v
         28u8RE+MCIgscgoAdCV2lMbmzzSuWXi6Vbdf71GQmPM7NRho4zAo864EIPdPOqe50No2
         kBBmgGtMvmDu5/Q4njC3GNvw1/M1c5OVjet+fFFpRClnu5rsKduNt8O8N6h2l9XcTlV8
         /IhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946482; x=1742551282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Suz7cKLNuXGtB0nBu0oVhma/Td/1dTahkXdO6vQ+7gU=;
        b=MuaI9th2HiF3oeoI04Gx5760sALtG+LBjv4G7yCI26tkWU6TCuyeAEA0llWl95lZQB
         5KrVQgGnAcp9nE0yBAdJrsy5Rf6I3vJ3I434y3l19cUPsam349ISNXA7ddY5MatI8df6
         yOOaHYnvNJvnkDadWNZ2soVggqjZJaQrsAUoZXpEmckXv32Tbf4MAJ1Ug/i3HM57rIug
         X6VBiU727Mrv1r7GktQ64OhlvoVQt5APs+O6TDpqzADe/OMPcsgXQFcC5GJH6i/4bMSt
         qVhLIZQIQ78ny6QXQQoOzx1VqeE/GnmfECAKtN3ZIQnIXWlaLw3nCpfWruO1gisvMPOV
         0OQg==
X-Forwarded-Encrypted: i=1; AJvYcCWTkSqsj/DkOebVe6oUt4MchrR2I5WWIIcxpJX2k/L9GsZD/BBEHzpG/VnPsxl92RE1tA9lQy21+k/6KKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpyR4k9anBcFZp6lXm6DMj7uAzUONTzLJrCmxm9of0BwRuMPJn
	ttXVrA4VPIU31RQuBxNj3KKa8vsTZnrqYWTckj+dN0iyVUKzlQyDYvRyt+aoV70=
X-Gm-Gg: ASbGncs4Kfy9IFWoIYJK3PHr2X2vhy+x0fT+xl8jCj8nZEqPvdmlKw+vRi0KpsCTzLd
	r12v//si47HQ5jHw3+71Wl9Cue9Yofff02/zfEr917LrQAqaArO+1erXEXsDI1tubFvtDUKgxKN
	zXopnatYKJ7N0H+3fu7TtIb1A2DZ/eH0zoUUGemU4MwukOlOx9BBCvYswKi0znNJURzUTbUGFNV
	o6zbHaSk9RfeySDnh1j42kdFTrq4XByuBMgYZ9fifFZmyCJ81Kiblg2Trf0NqM3wnTsBdPa+Nii
	9X2WwYdIB0Fp0QZYYVBBaStMro2iP4p3E1U9X7b/oLzzEZ6N24MHja2n4Wtnoy+pyd4r+Ckj+ey
	LB4dH0bbcxr5uRJQzaktZ9WaPy9fexw==
X-Google-Smtp-Source: AGHT+IEY83oFunB8w4RCdXC7/PTR7yqMmBEg98GVtkrv9yV920cpuM7Rd10omcbDGDOuiGclAjQbOw==
X-Received: by 2002:a05:651c:2101:b0:309:26e8:cb1a with SMTP id 38308e7fff4ca-30c4a8dcaaemr6886561fa.30.1741946482339;
        Fri, 14 Mar 2025 03:01:22 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0ea468sm5168221fa.41.2025.03.14.03.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:01:21 -0700 (PDT)
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
Subject: [PATCH 3/4] cpuidle: psci: Correct the domain-idlestate statistics in debugfs
Date: Fri, 14 Mar 2025 11:00:57 +0100
Message-ID: <20250314100103.1294715-4-ulf.hansson@linaro.org>
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

When trying to enter a domain-idlestate, we may occasionally fail to enter
the state, which is informed to us by psci_cpu_suspend_enter() returning an
error-code. In these cases, our corresponding genpd->power_off() callback
has already returned zero to indicate success, leading to getting
in-correct domain-idlestate statistics in debugfs for the genpd in
question.

Let's fix this by making use of the new pm_genpd_inc_rejected() helper, as
it allows us to correct the domain-idlestate statistics for this type of
scenario.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c |  2 +-
 drivers/cpuidle/cpuidle-psci.c        | 27 +++++++++++++++++----------
 drivers/cpuidle/cpuidle-psci.h        |  4 +++-
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index 5fb5228f6bf1..2041f59116ce 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -43,7 +43,7 @@ static int psci_pd_power_off(struct generic_pm_domain *pd)
 
 	/* OSI mode is enabled, set the corresponding domain state. */
 	pd_state = state->data;
-	psci_set_domain_state(*pd_state);
+	psci_set_domain_state(pd, pd->state_idx, *pd_state);
 
 	return 0;
 }
diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 1aff1ec555d5..26a0885444c4 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -37,6 +37,8 @@ struct psci_cpuidle_data {
 };
 
 struct psci_cpuidle_domain_state {
+	struct generic_pm_domain *pd;
+	unsigned int state_idx;
 	u32 state;
 };
 
@@ -45,14 +47,14 @@ static DEFINE_PER_CPU(struct psci_cpuidle_domain_state, psci_domain_state);
 static bool psci_cpuidle_use_syscore;
 static bool psci_cpuidle_use_cpuhp;
 
-void psci_set_domain_state(u32 state)
+void psci_set_domain_state(struct generic_pm_domain *pd, unsigned int state_idx,
+			   u32 state)
 {
-	__this_cpu_write(psci_domain_state.state, state);
-}
+	struct psci_cpuidle_domain_state *ds = this_cpu_ptr(&psci_domain_state);
 
-static inline u32 psci_get_domain_state(void)
-{
-	return __this_cpu_read(psci_domain_state.state);
+	ds->pd = pd;
+	ds->state_idx = state_idx;
+	ds->state = state;
 }
 
 static inline void psci_clear_domain_state(void)
@@ -67,7 +69,8 @@ static __cpuidle int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
 	struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
 	u32 *states = data->psci_states;
 	struct device *pd_dev = data->dev;
-	u32 state;
+	struct psci_cpuidle_domain_state *ds;
+	u32 state = states[idx];
 	int ret;
 
 	ret = cpu_pm_enter();
@@ -80,9 +83,9 @@ static __cpuidle int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
 	else
 		pm_runtime_put_sync_suspend(pd_dev);
 
-	state = psci_get_domain_state();
-	if (!state)
-		state = states[idx];
+	ds = this_cpu_ptr(&psci_domain_state);
+	if (ds->state)
+		state = ds->state;
 
 	trace_psci_domain_idle_enter(dev->cpu, state, s2idle);
 	ret = psci_cpu_suspend_enter(state) ? -1 : idx;
@@ -95,6 +98,10 @@ static __cpuidle int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
 
 	cpu_pm_exit();
 
+	/* Correct domain-idlestate statistics if we failed to enter. */
+	if (ret == -1 && ds->state)
+		pm_genpd_inc_rejected(ds->pd, ds->state_idx);
+
 	/* Clear the domain state to start fresh when back from idle. */
 	psci_clear_domain_state();
 	return ret;
diff --git a/drivers/cpuidle/cpuidle-psci.h b/drivers/cpuidle/cpuidle-psci.h
index ef004ec7a7c5..d29cbd796cd5 100644
--- a/drivers/cpuidle/cpuidle-psci.h
+++ b/drivers/cpuidle/cpuidle-psci.h
@@ -4,8 +4,10 @@
 #define __CPUIDLE_PSCI_H
 
 struct device_node;
+struct generic_pm_domain;
 
-void psci_set_domain_state(u32 state);
+void psci_set_domain_state(struct generic_pm_domain *pd, unsigned int state_idx,
+			   u32 state);
 int psci_dt_parse_state_node(struct device_node *np, u32 *state);
 
 #endif /* __CPUIDLE_PSCI_H */
-- 
2.43.0


