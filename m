Return-Path: <linux-kernel+bounces-190965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD5F8D059B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94075B2A432
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AFD171E4B;
	Mon, 27 May 2024 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b0mg4Z0x"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E9C171660
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819982; cv=none; b=Doqj3pbpgA5ouabeOTfXhvXpJ/oIb8UWncBJjI85rf4XXHlg6sWEqhayL3Vxm99PPr2xgieC67mM5wl1L6CGfyuBg2UDsa4WL3xxQHAhgLe24XENNU+b+bldEx0EouJc7WD1hITdYSREdwkILIIo0DHmtXwtdhaA6tDIv/sSbpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819982; c=relaxed/simple;
	bh=sz5by33IERLM5zwiJFy9mJ1MJ8cDhLszCDyK9tAyqqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=An7ngLZydzwCpVfpDe5dVZ8GUavfFQIkT7JKLedI5kHPXdESZxng13JPtszHAYpH4D4RlIH+GKEX3kHVOsXvUz2CXbbj4OTz+ktqDNdQibhpnf8NozqMPZ58ZxSKCx5UZRoyZy6Qa5RjIqEL3nbMWJDegr38QJmGr9nDVMCdT9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b0mg4Z0x; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-529644ec0ebso4381240e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716819977; x=1717424777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GR2SPI55DeqkFqYqinmHi2Z3WjfSQZFZ8NPV3Q+VMg=;
        b=b0mg4Z0xdl7v29H92uBbvl0HkpfgAKp1wdAFy3MO13XRMb9IrbXEu1DIavjcc2LFoT
         DSSSXD5tl3gXxZhdv/jOH32h2YTG1JrfAZ3lddtLHDGnPDrk8cwXqxK+L2uB9kgfZWIz
         NDEr7TPFg1+fYRfpGkCasrGmLH5O1vWSibYXPzf3OP8R7m8T6OAuQUJ9QF2XeH6jV5p4
         gfC71z1SUgTE2/WdPCXgA8qR8vmOKslCqrZ3f7l0b/HEQLqwy2aWmFkOBSqPlZ2FAL9N
         h7HYmlIwkDP3/Ed8M57vTCSf8HK6quVp3cJOxTq5ElKCjujVH7hR/X6Qhf7JOzmpvsX3
         wydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819977; x=1717424777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GR2SPI55DeqkFqYqinmHi2Z3WjfSQZFZ8NPV3Q+VMg=;
        b=GgbXXAcVtTe6zeAbVqR071Oi1An6rFY20OSURgWwPJFAuz9jj7d9CGKvY3OTB82wBv
         7V8oqA2gcOP7rp5ObQPGvFQFvU6JedcevPZLeN9MoVuCdd1ZMqWe0MQ2XRTxhM1f3aog
         ti69/IVU7wHhnnqAblNtUU9Y9n4PI2qPso5JLFq5sFsbUEn4MGncIsCTuyzYy6hstwpU
         p7NQT+Eog9ZOszr65DBw5/PHWCoX/TFLOoR8+gsTlDN3v/DVKtxwSOzB2JUQ4fhJbwNd
         I9hH7n1E5FirkRWcwCuhbyEPxgzAYYGhLsW+r3sLZ6c/45NTqv2J54LPmzjY1UM8WlaJ
         WeKA==
X-Forwarded-Encrypted: i=1; AJvYcCWCAco28qml6zFhRpsUpjX7GAhTpwn3zq7Au+QUIcBrsQHtdZ6NpiTT+cywmvJwl+SUrfQ5tKaNaXb+2m5BNC2sMlMzbVMmnL91mqj6
X-Gm-Message-State: AOJu0YwK/gHwZRwcWMYLXvK4fk8tX6ZzFYEm73h03ytapjwoH78d2HcQ
	unut5P9dLxQeP8GRfzrIQEZE0OXuMBoWNaAGWUGtaT1huNZMesTtOpAn5spO/18=
X-Google-Smtp-Source: AGHT+IGA/P2FW8XpPqzZeELvPdtjcyg+OYc+xsv0HaG5JN5DSLqw1uWa/8UhB3bobcPBPC4oZ82dnw==
X-Received: by 2002:a05:6512:3107:b0:51b:528e:ce7d with SMTP id 2adb3069b0e04-52966005b6emr7056095e87.34.1716819977519;
        Mon, 27 May 2024 07:26:17 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529711fa7f3sm562002e87.258.2024.05.27.07.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:17 -0700 (PDT)
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
Subject: [PATCH v2 7/7] cpuidle: psci: Enable the hierarchical topology for s2idle on PREEMPT_RT
Date: Mon, 27 May 2024 16:25:57 +0200
Message-Id: <20240527142557.321610-8-ulf.hansson@linaro.org>
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

To enable the domain-idle-states to be used during s2idle on a PREEMPT_RT
based configuration, let's allow the re-assignment of the ->enter_s2idle()
callback to psci_enter_s2idle_domain_idle_state().

Similar to s2ram, let's leave the support for CPU hotplug outside
PREEMPT_RT, as it's depending on using runtime PM. For s2idle, this means
that an offline CPU's PM domain will remain powered-on. In practise this
may lead to that a shallower idle-state than necessary gets selected, which
shouldn't be an issue (besides wasting power).

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
Changes in v2:
	- None.
---
 drivers/cpuidle/cpuidle-psci.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index ad6ce9fe12b4..2562dc001fc1 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -233,18 +233,17 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 
 	psci_cpuidle_use_syscore = true;
 
-	/* The hierarchical topology is limited to s2ram on PREEMPT_RT. */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		return 0;
-
 	/*
 	 * Using the deepest state for the CPU to trigger a potential selection
 	 * of a shared state for the domain, assumes the domain states are all
-	 * deeper states.
+	 * deeper states. On PREEMPT_RT the hierarchical topology is limited to
+	 * s2ram and s2idle.
 	 */
-	drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
 	drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
-	psci_cpuidle_use_cpuhp = true;
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
+		psci_cpuidle_use_cpuhp = true;
+	}
 
 	return 0;
 }
-- 
2.34.1


