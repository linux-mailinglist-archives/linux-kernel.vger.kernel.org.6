Return-Path: <linux-kernel+bounces-385169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DC19B3367
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B591D28358C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3591DDC05;
	Mon, 28 Oct 2024 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mffzb+IZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1D21DE4FF;
	Mon, 28 Oct 2024 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125396; cv=none; b=XvJTpYYJndRyf8NsvAz76r/ycgGKtq7JQ0vF9isMCAWg/IswUAMYXjiJ4mVo9sC83FwIO/NaqEr6LM0byfkWl8XGxbzkRuJMmsIKFdb38o+g86YwDvHoLA08MXHDGFSjQ8PdsFV/mZ26zqdlxdKyVipyblTPHBg+rm3LeHyDTwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125396; c=relaxed/simple;
	bh=yl7Mfs856g30vpNRTxQo0XG82uyk/8hEkmCtSRgI5BE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IfnCXTkfyQkDPbqtVodjM/VTJHuquKW9J5ZD7YJ/NZt7H1k65tqLLcL4CphNM39+mPZUvJLN8hXjEFXv6LW2jOcv31/0Hw/MjDJLop+yh9fVJFBaHYy6iwSRgV4PHl6xq0//l7PvRJJcgEPpcIJGeCb/Z29EygmwUXBz7xg3DIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mffzb+IZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E12C4CEE7;
	Mon, 28 Oct 2024 14:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730125396;
	bh=yl7Mfs856g30vpNRTxQo0XG82uyk/8hEkmCtSRgI5BE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Mffzb+IZ/0b3uzci/Q0aZsGlREKdAflGhK9yFluzbPp8ILpQeFqZJV4CKWQQGMrgR
	 NyxCydIX83gVfMkZMPYQWFWG2I8ndKIvBI7qiSNo9VgdKlTMA6rtAV6SoX0Uy1OVWj
	 VuKuaH6lnzLvE6T5rC29dD0NgdxQ6alkw++42ZfhGUJn6JdKgNd1ElrcxGpTj8trd0
	 FkgNAM1zS0vjT3bF9g9RW0AsMWWvKka85fcAK2KFGRgKXtNQVabkyuYNaBEv8Pos5m
	 dx6HuPQnKUUap8JUH07gFuhmBGtiOrvlCDdkZIlGDWWahkxj/BQsprRgdwsrrVGZS7
	 jHZtTG1POO0Fg==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Oct 2024 15:22:59 +0100
Subject: [PATCH 3/3] firmware/psci: Allow specifying an S2RAM state through
 CPU_SUSPEND
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-topic-cpu_suspend_s2ram-v1-3-9fdd9a04b75c@oss.qualcomm.com>
References: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>
In-Reply-To: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730125380; l=3714;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=Bf2hbCxvBem19Ny5a2acnQioUv9USzkxEe/DauTX7oc=;
 b=FlN28QeiFZU8O2MvaHh0SMZln2dKNtdGQHi7Hs7jxj9PC3ah05CBwHvJH95lZGaASdtMNjQLk
 1fNmg0+xUfyDeRqvE0W40TGGMjzDjMITQEIDQ9a0cduZox0+iTIK7WH
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Certain firmware implementations (such as the ones found on Qualcomm
SoCs between roughly 2015 and 2023) expose an S3-like S2RAM state
through the CPU_SUSPEND call.

This works exactly like SYSTEM_SUSPEND. The PSCI spec describes that
call as optional (and only introduced in PSCIv1.0), so not all
platforms expose it.

Marking a DT-described "domain-idle-state" as such isn't currently
well accounted for in the PSCI idle topology infrastructure: the
cpuidle and genpd framework are deeply intertwined, and trying to
separate them would cause more havoc than good.

Instead, allow the specifying of a single CPU_SUSPEND sleep param
under the /psci node that shall be treated exactly like SYSTEM_SUSPEND
from Linux's POV. As a bonus, this way we also don't have to fight
with the genpd idle governor to avoid taking the S3-like state into
consideration.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/firmware/psci/psci.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 0e622aa5ad58bbe69dfc3a71bced597618e73f15..20ae6a6d59a9f276db75260b6ca1a5827e443782 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -78,6 +78,7 @@ struct psci_0_1_function_ids get_psci_0_1_function_ids(void)
 
 static u32 psci_cpu_suspend_feature;
 static bool psci_system_reset2_supported;
+static u32 psci_s2ram_suspend_param;
 
 static inline bool psci_has_ext_power_state(void)
 {
@@ -519,10 +520,10 @@ static int psci_system_suspend_begin(suspend_state_t state)
 	return 0;
 }
 
-static const struct platform_suspend_ops psci_suspend_ops = {
-	.valid          = suspend_valid_only_mem,
-	.enter          = psci_system_suspend_enter,
-	.begin          = psci_system_suspend_begin,
+static const struct platform_suspend_ops psci_system_suspend_ops = {
+	.valid = suspend_valid_only_mem,
+	.enter = psci_system_suspend_enter,
+	.begin = psci_system_suspend_begin,
 };
 
 static void __init psci_init_system_reset2(void)
@@ -545,7 +546,7 @@ static void __init psci_init_system_suspend(void)
 	ret = psci_features(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND));
 
 	if (ret != PSCI_RET_NOT_SUPPORTED)
-		suspend_set_ops(&psci_suspend_ops);
+		suspend_set_ops(&psci_system_suspend_ops);
 }
 
 static void __init psci_init_cpu_suspend(void)
@@ -673,6 +674,17 @@ static int __init psci_probe(void)
 
 typedef int (*psci_initcall_t)(const struct device_node *);
 
+static int psci_cpu_suspend_s2ram_enter(suspend_state_t state)
+{
+	return psci_cpu_suspend_enter(psci_s2ram_suspend_param);
+}
+
+static const struct platform_suspend_ops psci_cpu_suspend_s2ram_ops = {
+	.valid = suspend_valid_only_mem,
+	.enter = psci_cpu_suspend_s2ram_enter,
+	.begin = psci_system_suspend_begin,
+};
+
 /*
  * PSCI init function for PSCI versions >=0.2
  *
@@ -686,6 +698,20 @@ static int __init psci_0_2_init(const struct device_node *np)
 	if (err)
 		return err;
 
+	/*
+	 * Some firmwares expose S2RAM entry through a custom suspend param.
+	 *
+	 * If found, register a suspend handler instead of registering the
+	 * idle state with cpuidle.
+	 */
+	err = of_property_read_u32(np, "arm,psci-s2ram-param", &psci_s2ram_suspend_param);
+	if (!err) {
+		suspend_set_ops(&psci_cpu_suspend_s2ram_ops);
+	} else if (err != -EINVAL) {
+		pr_err("Couldn't read the S2RAM PSCI suspend param: %d\n",
+		       psci_s2ram_suspend_param);
+	}
+
 	/*
 	 * Starting with v0.2, the PSCI specification introduced a call
 	 * (PSCI_VERSION) that allows probing the firmware version, so

-- 
2.47.0


