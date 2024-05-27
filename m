Return-Path: <linux-kernel+bounces-190964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 876638D05C8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 811DFB2ABB2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE81F171E60;
	Mon, 27 May 2024 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lgof/2C2"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A68171081
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819980; cv=none; b=ApkTjMlcpqpDCNcuisTRUN5YF1KErkvdPMAP/cgqZJNosdn2v/gA+lkS9eQHrZ6/dANHELDjT6mDJ6d3NiuQ/1tSkMAR3yC8+YUafowATCq9VwEQSo7Bovjd9SwDQVddSTq/CuOyo4usJDOb2WpW7vFmUF38Y7/DuwQb3jjYtPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819980; c=relaxed/simple;
	bh=Dqf4iQmXp0zK19p1+7qhaTomO3Kpy2CqPOAV3dW0uXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SUdi0t7qGdPCYbtaJnhvGxxlmWJyJkKyKf06xK8+OJhfvn70+u9RfTKzwJAqNFfNg/Hrg2EmPRGQjNJ9UNk4/ZzkzJRt18GLreV+LkixPoFuGPM9TC1V+PkL4AbBr3L3UPKB7RPVZqnMK0C7v7+loPpV6YOMTOoj/mmOM0Scz5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lgof/2C2; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5295dadce7fso4184388e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716819976; x=1717424776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LljiSusVSLaQvLa3fMIpBprCm3Nn7mYz+K0yIBAx5Q8=;
        b=lgof/2C2IrfR8Y7zaAeMVr/gRnZfYETQoJbmAMIUJr7dMRqU2LYgvCZXIhZPlBjUa1
         3zQCaUH+XHmrSeJucMiZMkl6VB0R8iizmztVAjC7tiTvAkUhEHqQmkRzTGWvHriQspoM
         Nihi758/77c1m3UbQ+AUVxMPtBn6DkvuMmp9C5BjkOi/Ec3qvYx4yWmpvUU7jPRk0BvG
         VZyyyBabHeYoNy54D9qeFgaabyJvLJLKwY9+qgpt7EhvYrXF5wG0rws9teCn056jF7bC
         tmtFABRIJLXJExFJ1M+9vRCykropcRBGpokUiZ9eOT56oCtZszfml9pkHfQIfKgMOMBj
         +QNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819976; x=1717424776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LljiSusVSLaQvLa3fMIpBprCm3Nn7mYz+K0yIBAx5Q8=;
        b=Pz+WYg9fVAPV5Tvqf+TgydqHRR4QQ/tQZ+NR2sRElENll3/c57Q8x2yK0EYA6heNZe
         Oh1zn0e7Nd1pNsNcxH8aAdoZ0vZthd/+ZLfMWG/WRnSKoPQy9El4ilkYk1hffd9DQVZD
         FeoB/sZp8UeYh60/QcCBYxL2swhawWbKnRBCtWXYOa7wwpy77z3fCbIAQ/SibAIDQuzZ
         xnpVgHieKEeODo9I0QAw/sdeOPPq7d52TDuwoSxtWp32Gnn/qz/jZWMSTcvFDCI0d6fS
         kZlaQSXJIyyeBsjrHv1C7BwfAkZ1YNYEXNPFAAzU2mSbvjvjxNvzXeeAZoVQQGeH+Aio
         LowQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYLsbEFcP+Y17lR+CXlr7D5p6jjbrin8S8flK4IZ4j6XGVmTPHNiG0+66csAX0z04sHeBojzn7J6wLnW9OKgwkAIITCOZNqTUpow1N
X-Gm-Message-State: AOJu0YxyoYVDNQ4/xmaSs8W/FI8blUeX9Mz78b5ok98P/754Enx1OAHt
	Ln+MEaPSGo/xBpBc10yTJwmTU+96GqhOTp41PfQr2dX/Cp3SfA/lteo0HAHLvR8=
X-Google-Smtp-Source: AGHT+IHda/pxt1Ko7UnJfUcRRPdZ4toQLHtsmBjmcxqQ5f4apt+9Z4qbCKGMZXNL6CMfnbUjmtCv8g==
X-Received: by 2002:a19:ee0b:0:b0:518:a9bf:73ec with SMTP id 2adb3069b0e04-5296519899emr5678201e87.35.1716819976367;
        Mon, 27 May 2024 07:26:16 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529711fa7f3sm562002e87.258.2024.05.27.07.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:15 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] cpuidle: psci: Enable the hierarchical topology for s2ram on PREEMPT_RT
Date: Mon, 27 May 2024 16:25:56 +0200
Message-Id: <20240527142557.321610-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527142557.321610-1-ulf.hansson@linaro.org>
References: <20240527142557.321610-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hierarchical PM domain topology are currently disabled on a PREEMPT_RT
based configuration. As a first step to enable it to be used, let's try to
attach the CPU devices to their PM domains on PREEMPT_RT. In this way the
syscore ops becomes available, allowing the PM domain topology to be
managed during s2ram.

For the moment let's leave the support for CPU hotplug outside PREEMPT_RT,
as it's depending on using runtime PM. For s2ram, this isn't a problem as
all CPUs are managed via the syscore ops.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
Changes in v2:
	- None.
---
 drivers/cpuidle/cpuidle-psci.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index d82a8bc1b194..ad6ce9fe12b4 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -37,6 +37,7 @@ struct psci_cpuidle_data {
 
 static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
 static DEFINE_PER_CPU(u32, domain_state);
+static bool psci_cpuidle_use_syscore;
 static bool psci_cpuidle_use_cpuhp;
 
 void psci_set_domain_state(u32 state)
@@ -166,6 +167,12 @@ static struct syscore_ops psci_idle_syscore_ops = {
 	.resume = psci_idle_syscore_resume,
 };
 
+static void psci_idle_init_syscore(void)
+{
+	if (psci_cpuidle_use_syscore)
+		register_syscore_ops(&psci_idle_syscore_ops);
+}
+
 static void psci_idle_init_cpuhp(void)
 {
 	int err;
@@ -173,8 +180,6 @@ static void psci_idle_init_cpuhp(void)
 	if (!psci_cpuidle_use_cpuhp)
 		return;
 
-	register_syscore_ops(&psci_idle_syscore_ops);
-
 	err = cpuhp_setup_state_nocalls(CPUHP_AP_CPU_PM_STARTING,
 					"cpuidle/psci:online",
 					psci_idle_cpuhp_up,
@@ -222,13 +227,16 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 	if (!psci_has_osi_support())
 		return 0;
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		return 0;
-
 	data->dev = dt_idle_attach_cpu(cpu, "psci");
 	if (IS_ERR_OR_NULL(data->dev))
 		return PTR_ERR_OR_ZERO(data->dev);
 
+	psci_cpuidle_use_syscore = true;
+
+	/* The hierarchical topology is limited to s2ram on PREEMPT_RT. */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		return 0;
+
 	/*
 	 * Using the deepest state for the CPU to trigger a potential selection
 	 * of a shared state for the domain, assumes the domain states are all
@@ -312,6 +320,7 @@ static void psci_cpu_deinit_idle(int cpu)
 	struct psci_cpuidle_data *data = per_cpu_ptr(&psci_cpuidle_data, cpu);
 
 	dt_idle_detach_cpu(data->dev);
+	psci_cpuidle_use_syscore = false;
 	psci_cpuidle_use_cpuhp = false;
 }
 
@@ -408,6 +417,7 @@ static int psci_cpuidle_probe(struct platform_device *pdev)
 			goto out_fail;
 	}
 
+	psci_idle_init_syscore();
 	psci_idle_init_cpuhp();
 	return 0;
 
-- 
2.34.1


