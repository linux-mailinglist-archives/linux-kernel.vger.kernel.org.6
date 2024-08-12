Return-Path: <linux-kernel+bounces-282562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2055F94E5D6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BE31F22227
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 04:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D8C14A601;
	Mon, 12 Aug 2024 04:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/aiaaba"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70291494BA
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 04:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723437645; cv=none; b=s5J7I+mchm1CT4MqE0cd+o3kmvrBGMCF0HH8Itvuc0mE4cTjcSUNuwR5LjdP6IVWSW4wLM4zZD64ZU0ZjkEGF0qwLffjtZzH6AmcqrK5CrIC8zcEHnBiTlQ5+Qo8k1/4OGS1yeuBhjIn+kCwzE/uxDsm18/peQGSg5kTdlLbl3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723437645; c=relaxed/simple;
	bh=QNHPrpxL+0sgE/AyG37tJ3Bz2m+41t/dYw/Gsq55ehM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dQbnceFyTDAY/vfSjYj2BIpL4B9Lk4n9dTg0UgG/4i4+x7dVxFaXCr2mcBICj26H9fGpLJXtGa4XtN032+8fin3E0RMQ3xKTSZYrCUZKjrWkSc+5UF75WFq6/nqpNp2VJGJ6TGu/87GA57d2YDQqoVicURwjAs2SDJXYLs9M7S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaslanka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/aiaaba; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaslanka.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-68f95e37bbfso100125947b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 21:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723437643; x=1724042443; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7zTpz2DMvimTNNLr+qMsA7Dd9v4fiwi/bdtdNpJM3k=;
        b=q/aiaabapIHc5IlVnVTjW+4nglAXnVdTqjLKD/3kSSEcKbWA2T+9FywW+XIzVkv8eM
         fRKY5t0azn0N7Xpa1acLsVwIVNxtTm68NEv93yNQwxm2xvtWjeGWw5jMQtGeBDfMI37w
         gpDvcn2Q/1B4TCAPFGvk4WGYX6yzzKk2tp8PFgwsaoO6b385MtIgnMb5MNRXv/PmQlcn
         iqBcg22eGBwdKjYD0xggaZNycLV617J7zuCEuP471phDbmbVomc8MUVBpaxQuEVT3oO0
         oLCrPjXSDJN64ntZuEfshZJpYWQuk2vRuZCPg4o8TFOS17/BeQap5zNBwD9yDOWQGVJN
         TFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723437643; x=1724042443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7zTpz2DMvimTNNLr+qMsA7Dd9v4fiwi/bdtdNpJM3k=;
        b=iv7OKPrktNM1XTk8siljIqOAOH3MLo3VFWGDCvv3JxFJtV0ZfvAIi1onZ6tLyCdQxx
         2d5wjXG7CXAgkXJ7vOaj9RTpVts6SlaE978itIVjDIf0sUjLRDMPKuI2g6wr3lfPhoNq
         6I0Hj7I6V/s6eM7gGkWuL7H0w3/xxofLpaJHvz+2pRsgd2bOPVmg0dEM1H51RF9acqCR
         S11Sak/3rZowIdZf8FukAAIehCm4/6ZedELwMXUZgRx+VFSNmQYV7IWOgwYAK9jS4a52
         6vVPs6T3HlpY4SwaleBUvMLBlrahuzO5N6y4QQEdjmpw7YzhBIVGch+wPEpI8ToHqUiv
         jS4w==
X-Gm-Message-State: AOJu0Ywa9GrS0kD0ZDa5rko+tYu5MD5p/5LdsatPSyn9PffYw5Kxnoip
	q96UPhcNWonJYSYhxWngKRrQyZGISQk16dnDh7vkcM+PRuUGmCJX8eNRzgzLC+xJjLQ1ZwFHPVq
	KCq8TnZqItyiKTF2uP0baRO3O9cFrYBsmjWRjWfNRMGFfXlA1a5RZrSy23v3i4B+aEWS++tH4gE
	BRS2k1SohqNomthwtMDVieFeACoLXXyRij0GH1TbUJl1ur0y25dHLepO3n
X-Google-Smtp-Source: AGHT+IF/SFG1go6c+EX5iNA+YPCcacRoHMoHjkk2tzq7SuIw188amey35LllQMrreFvbpA3jmWcZqONK3c0AdEg=
X-Received: from mmaslanka2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:b8d])
 (user=mmaslanka job=sendgmr) by 2002:a81:be0d:0:b0:622:cd7d:fec4 with SMTP id
 00721157ae682-69ec9a11e0dmr6654427b3.9.1723437642380; Sun, 11 Aug 2024
 21:40:42 -0700 (PDT)
Date: Mon, 12 Aug 2024 04:40:20 +0000
In-Reply-To: <87h6bttzzh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <87h6bttzzh.ffs@tglx>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240812044028.3439329-1-mmaslanka@google.com>
Subject: [PATCH v5 2/2] platform/x86:intel/pmc: Enable the ACPI PM Timer to be
 turned off when suspended
From: Marek Maslanka <mmaslanka@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marek Maslanka <mmaslanka@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, 
	David E Box <david.e.box@intel.com>, Hans de Goede <hdegoede@redhat.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow to disable ACPI PM Timer on suspend and enable on resume. A
disabled timer helps optimise power consumption when the system is
suspended. On resume the timer is only reactivated if it was activated
prior to suspend, so unless the ACPI PM timer is enabled in the BIOS,
this won't change anything.

The ACPI PM timer is used by Intel's iTCO/wdat_wdt watchdog to drive the
watchdog, so it doesn't need to run during suspend.

Signed-off-by: Marek Maslanka <mmaslanka@google.com>

---
Changes in v5:
- Use renamed acpi_pmtmr_register_suspend_resume_callback instead of
  acpi_pm_register_suspend_resume_callback
- Link to v4: https://lore.kernel.org/lkml/20240809131343.1173369-2-mmaslanka@google.com/
---
---
 drivers/platform/x86/intel/pmc/adl.c  |  2 ++
 drivers/platform/x86/intel/pmc/cnp.c  |  2 ++
 drivers/platform/x86/intel/pmc/core.c | 49 +++++++++++++++++++++++++++
 drivers/platform/x86/intel/pmc/core.h |  8 +++++
 drivers/platform/x86/intel/pmc/icl.c  |  2 ++
 drivers/platform/x86/intel/pmc/mtl.c  |  2 ++
 drivers/platform/x86/intel/pmc/spt.c  |  2 ++
 drivers/platform/x86/intel/pmc/tgl.c  |  2 ++
 8 files changed, 69 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/intel/pmc/adl.c
index e7878558fd909..9d9c07f44ff61 100644
--- a/drivers/platform/x86/intel/pmc/adl.c
+++ b/drivers/platform/x86/intel/pmc/adl.c
@@ -295,6 +295,8 @@ const struct pmc_reg_map adl_reg_map = {
 	.ppfear_buckets = CNP_PPFEAR_NUM_ENTRIES,
 	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
+	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
+	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
 	.ltr_ignore_max = ADL_NUM_IP_IGN_ALLOWED,
 	.lpm_num_modes = ADL_LPM_NUM_MODES,
 	.lpm_num_maps = ADL_LPM_NUM_MAPS,
diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
index dd72974bf71e2..513c02670c5aa 100644
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -200,6 +200,8 @@ const struct pmc_reg_map cnp_reg_map = {
 	.ppfear_buckets = CNP_PPFEAR_NUM_ENTRIES,
 	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
+	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
+	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
 	.ltr_ignore_max = CNP_NUM_IP_IGN_ALLOWED,
 	.etr3_offset = ETR3_OFFSET,
 };
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 10c96c1a850af..d65e3e77ec2ca 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -11,6 +11,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/acpi_pmtmr.h>
 #include <linux/bitfield.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -1171,6 +1172,42 @@ static bool pmc_core_is_pson_residency_enabled(struct pmc_dev *pmcdev)
 	return val == 1;
 }
 
+/**
+ * Enable or disable ACPI PM Timer
+ *
+ * This function is intended to be a callback for ACPI PM suspend/resume event.
+ * The ACPI PM Timer is enabled on resume only if it was enabled during suspend.
+ */
+static void pmc_core_acpi_pm_timer_suspend_resume(void *data, bool suspend)
+{
+	struct pmc_dev *pmcdev = data;
+	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
+	const struct pmc_reg_map *map = pmc->map;
+	bool enabled;
+	u32 reg;
+
+	if (!map->acpi_pm_tmr_ctl_offset)
+		return;
+
+	mutex_lock(&pmcdev->lock);
+
+	if (!suspend && !pmcdev->enable_acpi_pm_timer_on_resume) {
+		mutex_unlock(&pmcdev->lock);
+		return;
+	}
+
+	reg = pmc_core_reg_read(pmc, map->acpi_pm_tmr_ctl_offset);
+	enabled = !(reg & map->acpi_pm_tmr_disable_bit);
+	if (suspend)
+		reg |= map->acpi_pm_tmr_disable_bit;
+	else
+		reg &= ~map->acpi_pm_tmr_disable_bit;
+	pmc_core_reg_write(pmc, map->acpi_pm_tmr_ctl_offset, reg);
+
+	pmcdev->enable_acpi_pm_timer_on_resume = suspend && enabled;
+
+	mutex_unlock(&pmcdev->lock);
+}
 
 static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
 {
@@ -1362,6 +1399,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 	struct pmc_dev *pmcdev;
 	const struct x86_cpu_id *cpu_id;
 	int (*core_init)(struct pmc_dev *pmcdev);
+	const struct pmc_reg_map *map;
 	struct pmc *primary_pmc;
 	int ret;
 
@@ -1420,6 +1458,11 @@ static int pmc_core_probe(struct platform_device *pdev)
 	pm_report_max_hw_sleep(FIELD_MAX(SLP_S0_RES_COUNTER_MASK) *
 			       pmc_core_adjust_slp_s0_step(primary_pmc, 1));
 
+	map = primary_pmc->map;
+	if (map->acpi_pm_tmr_ctl_offset)
+		acpi_pmtmr_register_suspend_resume_callback(pmc_core_acpi_pm_timer_suspend_resume,
+							 pmcdev);
+
 	device_initialized = true;
 	dev_info(&pdev->dev, " initialized\n");
 
@@ -1429,6 +1472,12 @@ static int pmc_core_probe(struct platform_device *pdev)
 static void pmc_core_remove(struct platform_device *pdev)
 {
 	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
+	const struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
+	const struct pmc_reg_map *map = pmc->map;
+
+	if (map->acpi_pm_tmr_ctl_offset)
+		acpi_pmtmr_register_suspend_resume_callback(NULL, NULL);
+
 	pmc_core_dbgfs_unregister(pmcdev);
 	pmc_core_clean_structure(pdev);
 }
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 83504c49a0e31..fe1a94f693b63 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -67,6 +67,8 @@ struct telem_endpoint;
 #define SPT_PMC_LTR_SCC				0x3A0
 #define SPT_PMC_LTR_ISH				0x3A4
 
+#define SPT_PMC_ACPI_PM_TMR_CTL_OFFSET		0x18FC
+
 /* Sunrise Point: PGD PFET Enable Ack Status Registers */
 enum ppfear_regs {
 	SPT_PMC_XRAM_PPFEAR0A = 0x590,
@@ -147,6 +149,8 @@ enum ppfear_regs {
 #define SPT_PMC_VRIC1_SLPS0LVEN			BIT(13)
 #define SPT_PMC_VRIC1_XTALSDQDIS		BIT(22)
 
+#define SPT_PMC_BIT_ACPI_PM_TMR_DISABLE		BIT(1)
+
 /* Cannonlake Power Management Controller register offsets */
 #define CNP_PMC_SLPS0_DBG_OFFSET		0x10B4
 #define CNP_PMC_PM_CFG_OFFSET			0x1818
@@ -344,6 +348,8 @@ struct pmc_reg_map {
 	const u8  *lpm_reg_index;
 	const u32 pson_residency_offset;
 	const u32 pson_residency_counter_step;
+	const u32 acpi_pm_tmr_ctl_offset;
+	const u32 acpi_pm_tmr_disable_bit;
 };
 
 /**
@@ -417,6 +423,8 @@ struct pmc_dev {
 	u32 die_c6_offset;
 	struct telem_endpoint *punit_ep;
 	struct pmc_info *regmap_list;
+
+	bool enable_acpi_pm_timer_on_resume;
 };
 
 enum pmc_index {
diff --git a/drivers/platform/x86/intel/pmc/icl.c b/drivers/platform/x86/intel/pmc/icl.c
index 71b0fd6cb7d84..cbbd440544688 100644
--- a/drivers/platform/x86/intel/pmc/icl.c
+++ b/drivers/platform/x86/intel/pmc/icl.c
@@ -46,6 +46,8 @@ const struct pmc_reg_map icl_reg_map = {
 	.ppfear_buckets = ICL_PPFEAR_NUM_ENTRIES,
 	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
+	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
+	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
 	.ltr_ignore_max = ICL_NUM_IP_IGN_ALLOWED,
 	.etr3_offset = ETR3_OFFSET,
 };
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index c7d15d864039d..91f2fa728f5c8 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -462,6 +462,8 @@ const struct pmc_reg_map mtl_socm_reg_map = {
 	.ppfear_buckets = MTL_SOCM_PPFEAR_NUM_ENTRIES,
 	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
+	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
+	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
 	.lpm_num_maps = ADL_LPM_NUM_MAPS,
 	.ltr_ignore_max = MTL_SOCM_NUM_IP_IGN_ALLOWED,
 	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/intel/pmc/spt.c
index ab993a69e33ee..2cd2b3c68e468 100644
--- a/drivers/platform/x86/intel/pmc/spt.c
+++ b/drivers/platform/x86/intel/pmc/spt.c
@@ -130,6 +130,8 @@ const struct pmc_reg_map spt_reg_map = {
 	.ppfear_buckets = SPT_PPFEAR_NUM_ENTRIES,
 	.pm_cfg_offset = SPT_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit = SPT_PMC_READ_DISABLE_BIT,
+	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
+	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
 	.ltr_ignore_max = SPT_NUM_IP_IGN_ALLOWED,
 	.pm_vric1_offset = SPT_PMC_VRIC1_OFFSET,
 };
diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
index e0580de180773..371b4e30f1426 100644
--- a/drivers/platform/x86/intel/pmc/tgl.c
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@ -197,6 +197,8 @@ const struct pmc_reg_map tgl_reg_map = {
 	.ppfear_buckets = ICL_PPFEAR_NUM_ENTRIES,
 	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
+	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
+	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
 	.ltr_ignore_max = TGL_NUM_IP_IGN_ALLOWED,
 	.lpm_num_maps = TGL_LPM_NUM_MAPS,
 	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
-- 
2.46.0.76.ge559c4bf1a-goog


