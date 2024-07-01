Return-Path: <linux-kernel+bounces-237077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D180591EAD1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 00:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881CA2831B3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EB1171658;
	Mon,  1 Jul 2024 22:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g6s4g3r8"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE64153835
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 22:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719872818; cv=none; b=UZUhPf1glrPde2l+eiqXOWa33vHrBYVyuujn1eZgG1PV7M/d1Sgca8F2PgfhGrScpb98Vf92R0nIGhP58+ZQ/Ka4AfW5N4Aw2edM9RAz6XO4L0+0z5oT4vnFc4ZTVaicUrt1/rhHR3iYA0wyNn81NMroW9XsFNOi14s+jPp2tns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719872818; c=relaxed/simple;
	bh=X4fU4jJhuutoKrbHWp/vR/sx7mSrhQQclqNYjphnL9U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DEMUdXXsDmJN5atC7wyZ5bWyt0iMw/vZCrb+IRRyk1L44KesveJJa6TzbTbKKi9TcwciodGuKoyc/ThLqH8Bq9cBqwhx/RwHzDGWLVdBxnLIl1jo7QUP+qBpdQt39AIK5irDoHSqH/Y7VjwZvtYnv9veBxpCPTuzYDX1VN54ANA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaslanka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g6s4g3r8; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaslanka.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e034f972e8bso5996625276.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 15:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719872815; x=1720477615; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5trD/scqVKhMYOlYiGg8D8SgzaZrrv+skpQvukGH0vA=;
        b=g6s4g3r8tv+AaaxdTrChQ3ogJyMyUEZpnrQId4phQJyDL36eytsTDM1CfDoBJc+nWt
         UO1QPpMppN/UN8e3QxK0t8xXLYZ186Vj2eNsSSb5U0y0LGOYusrpgMxxK7UA3qTpY7Qg
         1r4hmqr1PwlSgSpZw6zXR6NQ1hXbT7O1/UaHuTUrB/wzKIk1BhszDBGyjHzU2tKzN9VA
         QtOlvT75Gvyuhm+swdsvAxTCpazXs5lGpLyyOJkNZ7rVu2P0Cexb1N5RWyC7/drxr2mN
         fmSw9uEkYd/8dYR51+a06SfjbXKIPgKkZt1nf3SgCR21SMDU2CLwSq5E7K69fUhY/305
         S/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719872815; x=1720477615;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5trD/scqVKhMYOlYiGg8D8SgzaZrrv+skpQvukGH0vA=;
        b=WvogXVu4ayuPesrvl7bmVkIBwfzS5JNLnIXa3KULQxt+mNT+hmi8Zy35W/hZaboXU8
         Y9fK5AMyV4SwoTl+zGp3BFyuhVGsxaQj66VgCoFjdoCwlK5Au7cOsjpSl513EpxhZnQL
         YdHv8sh26gxife+TKTHSpb9S79FnOj9PxwlZPn3coezd7fZciEglTmdEw4O1shqGZdp2
         i0FEtIMPrOEqfFGdSxfBzVNXZgTuw3FAu464F2DpfnaA0VF0NPax+zHTSiYAi/+A+9gw
         AMON2hYH9fh0Zye+yEd+gbxqBoMcmjnNc+nxiJeh/GJrlv3NwPjwoA+kPTe0eu1V0mem
         Lh0Q==
X-Gm-Message-State: AOJu0YwTRFNr8o6hpSMrUrSTFWEwVfj71SRrfaKKwnUhgGfXQTXQumqg
	AT8xuR3dOM9AtcbGzJCkT53Ik4k71aCsozXc2veTVAyU/uXleXWGy839QVSVvrTEnNcLi4mrgp8
	jJR4FVHMLlZm7e1QkAZw0bRKmc+s6p2z/yAOlB7B37zJgpdwnm0Gk1sC+vhi61xRioTyzYwHmKg
	UBD9DvpiIs+1LjgQpHv5haeRDi/Fg+Nwed6Fm+x99moMkhWN7aElR4sHM4
X-Google-Smtp-Source: AGHT+IEqxxekV1PvR444SOwh3pWOrp1CoA4nls0Y/iOA2UhypmDktxGu48mVAjQWnTzkzruMrpyTyAvD6VVsSNk=
X-Received: from mmaslanka2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:b8d])
 (user=mmaslanka job=sendgmr) by 2002:a05:6902:c03:b0:e03:2f90:e81d with SMTP
 id 3f1490d57ef6-e036ec6eaa0mr715551276.11.1719872815295; Mon, 01 Jul 2024
 15:26:55 -0700 (PDT)
Date: Mon,  1 Jul 2024 22:25:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701222508.1.I872f9412fdb7cdc20d7c6e98b93daa014f3616dc@changeid>
Subject: [PATCH] platform/x86:intel/pmc: Enable the ACPI PM Timer to be turned
 off when suspended
From: Marek Maslanka <mmaslanka@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marek Maslanka <mmaslanka@google.com>, David E Box <david.e.box@intel.com>, 
	Hans de Goede <hdegoede@redhat.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow to disable ACPI PM Timer on suspend and enable on resume. A
disabled timer helps optimise power consumption when the system is
suspended. On resume the timer is only reactivated if it was activated
prior to suspend, so unless the ACPI PM timer is enabled in the BIOS,
this won't change anything.

Signed-off-by: Marek Maslanka <mmaslanka@google.com>
---

 drivers/platform/x86/intel/pmc/Kconfig | 13 ++++++++
 drivers/platform/x86/intel/pmc/adl.c   |  4 +++
 drivers/platform/x86/intel/pmc/cnp.c   |  4 +++
 drivers/platform/x86/intel/pmc/core.c  | 43 ++++++++++++++++++++++++++
 drivers/platform/x86/intel/pmc/core.h  | 14 +++++++++
 drivers/platform/x86/intel/pmc/icl.c   |  4 +++
 drivers/platform/x86/intel/pmc/mtl.c   |  4 +++
 drivers/platform/x86/intel/pmc/spt.c   |  4 +++
 drivers/platform/x86/intel/pmc/tgl.c   |  4 +++
 9 files changed, 94 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/Kconfig b/drivers/platform/x86/intel/pmc/Kconfig
index d2f651fbec2cf..3a563db8eba6a 100644
--- a/drivers/platform/x86/intel/pmc/Kconfig
+++ b/drivers/platform/x86/intel/pmc/Kconfig
@@ -24,3 +24,16 @@ config INTEL_PMC_CORE
 		- SLPS0 Debug registers (Cannonlake/Icelake PCH)
 		- Low Power Mode registers (Tigerlake and beyond)
 		- PMC quirks as needed to enable SLPS0/S0ix
+
+config DISABLE_ACPI_PM_TIMER_ON_SUSPEND
+	bool "Disable ACPI PM Timer on suspend"
+	default n
+	depends on INTEL_PMC_CORE
+	help
+	  Disable ACPI Power Management Timer on entering to suspend and enable it
+	  on resume. This helps optimize energy consumption while the system is
+	  suspend.
+
+	  This is only applicable if the ACPI PM timer is enabled by the BIOS.
+
+	  Say N if unsure.
diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/intel/pmc/adl.c
index e7878558fd909..8859e0d275288 100644
--- a/drivers/platform/x86/intel/pmc/adl.c
+++ b/drivers/platform/x86/intel/pmc/adl.c
@@ -295,6 +295,10 @@ const struct pmc_reg_map adl_reg_map = {
 	.ppfear_buckets = CNP_PPFEAR_NUM_ENTRIES,
 	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
+#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
+	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
+	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
+#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
 	.ltr_ignore_max = ADL_NUM_IP_IGN_ALLOWED,
 	.lpm_num_modes = ADL_LPM_NUM_MODES,
 	.lpm_num_maps = ADL_LPM_NUM_MAPS,
diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
index dd72974bf71e2..e92157aa3c9f1 100644
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -200,6 +200,10 @@ const struct pmc_reg_map cnp_reg_map = {
 	.ppfear_buckets = CNP_PPFEAR_NUM_ENTRIES,
 	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
+#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
+	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
+	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
+#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
 	.ltr_ignore_max = CNP_NUM_IP_IGN_ALLOWED,
 	.etr3_offset = ETR3_OFFSET,
 };
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 10c96c1a850af..a3e56c524308f 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1171,6 +1171,37 @@ static bool pmc_core_is_pson_residency_enabled(struct pmc_dev *pmcdev)
 	return val == 1;
 }
 
+#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
+/*
+ * Enable or disable APCI PM Timer
+ *
+ * @return: Previous APCI PM Timer enabled state
+ */
+static bool pmc_core_enable_apci_pm_timer(struct pmc_dev *pmcdev, bool enable)
+{
+	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
+	const struct pmc_reg_map *map = pmc->map;
+	bool state;
+	u32 reg;
+
+	if (!map->acpi_pm_tmr_ctl_offset)
+		return false;
+
+	mutex_lock(&pmcdev->lock);
+
+	reg = pmc_core_reg_read(pmc, map->acpi_pm_tmr_ctl_offset);
+	state = !(reg & map->acpi_pm_tmr_disable_bit);
+	if (enable)
+		reg &= ~map->acpi_pm_tmr_disable_bit;
+	else
+		reg |= map->acpi_pm_tmr_disable_bit;
+	pmc_core_reg_write(pmc, map->acpi_pm_tmr_ctl_offset, reg);
+
+	mutex_unlock(&pmcdev->lock);
+
+	return state;
+}
+#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
 
 static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
 {
@@ -1446,6 +1477,12 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
 	if (pmcdev->suspend)
 		pmcdev->suspend(pmcdev);
 
+#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
+	/* Disable APCI PM Timer */
+	pmcdev->enable_acpi_pm_timer_on_resume =
+		pmc_core_enable_apci_pm_timer(pmcdev, false);
+#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
+
 	/* Check if the syspend will actually use S0ix */
 	if (pm_suspend_via_firmware())
 		return 0;
@@ -1500,6 +1537,12 @@ int pmc_core_resume_common(struct pmc_dev *pmcdev)
 	int offset = pmc->map->lpm_status_offset;
 	int i;
 
+#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
+	/* Enable APCI PM Timer */
+	if (pmcdev->enable_acpi_pm_timer_on_resume)
+		pmc_core_enable_apci_pm_timer(pmcdev, true);
+#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
+
 	/* Check if the syspend used S0ix */
 	if (pm_suspend_via_firmware())
 		return 0;
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 83504c49a0e31..4d5983d741433 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -67,6 +67,10 @@ struct telem_endpoint;
 #define SPT_PMC_LTR_SCC				0x3A0
 #define SPT_PMC_LTR_ISH				0x3A4
 
+#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
+#define SPT_PMC_ACPI_PM_TMR_CTL_OFFSET		0x18FC
+#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
+
 /* Sunrise Point: PGD PFET Enable Ack Status Registers */
 enum ppfear_regs {
 	SPT_PMC_XRAM_PPFEAR0A = 0x590,
@@ -147,6 +151,10 @@ enum ppfear_regs {
 #define SPT_PMC_VRIC1_SLPS0LVEN			BIT(13)
 #define SPT_PMC_VRIC1_XTALSDQDIS		BIT(22)
 
+#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
+#define SPT_PMC_BIT_ACPI_PM_TMR_DISABLE		BIT(1)
+#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
+
 /* Cannonlake Power Management Controller register offsets */
 #define CNP_PMC_SLPS0_DBG_OFFSET		0x10B4
 #define CNP_PMC_PM_CFG_OFFSET			0x1818
@@ -344,6 +352,8 @@ struct pmc_reg_map {
 	const u8  *lpm_reg_index;
 	const u32 pson_residency_offset;
 	const u32 pson_residency_counter_step;
+	const u32 acpi_pm_tmr_ctl_offset;
+	const u32 acpi_pm_tmr_disable_bit;
 };
 
 /**
@@ -417,6 +427,10 @@ struct pmc_dev {
 	u32 die_c6_offset;
 	struct telem_endpoint *punit_ep;
 	struct pmc_info *regmap_list;
+
+#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
+	bool enable_acpi_pm_timer_on_resume;
+#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
 };
 
 enum pmc_index {
diff --git a/drivers/platform/x86/intel/pmc/icl.c b/drivers/platform/x86/intel/pmc/icl.c
index 71b0fd6cb7d84..8b5c782e71ebd 100644
--- a/drivers/platform/x86/intel/pmc/icl.c
+++ b/drivers/platform/x86/intel/pmc/icl.c
@@ -46,6 +46,10 @@ const struct pmc_reg_map icl_reg_map = {
 	.ppfear_buckets = ICL_PPFEAR_NUM_ENTRIES,
 	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
+#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
+	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
+	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
+#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
 	.ltr_ignore_max = ICL_NUM_IP_IGN_ALLOWED,
 	.etr3_offset = ETR3_OFFSET,
 };
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index c7d15d864039d..c726ef8f1d5a9 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -462,6 +462,10 @@ const struct pmc_reg_map mtl_socm_reg_map = {
 	.ppfear_buckets = MTL_SOCM_PPFEAR_NUM_ENTRIES,
 	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
+#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
+	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
+	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
+#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
 	.lpm_num_maps = ADL_LPM_NUM_MAPS,
 	.ltr_ignore_max = MTL_SOCM_NUM_IP_IGN_ALLOWED,
 	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/intel/pmc/spt.c
index ab993a69e33ee..4832e953d0403 100644
--- a/drivers/platform/x86/intel/pmc/spt.c
+++ b/drivers/platform/x86/intel/pmc/spt.c
@@ -130,6 +130,10 @@ const struct pmc_reg_map spt_reg_map = {
 	.ppfear_buckets = SPT_PPFEAR_NUM_ENTRIES,
 	.pm_cfg_offset = SPT_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit = SPT_PMC_READ_DISABLE_BIT,
+#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
+	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
+	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
+#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
 	.ltr_ignore_max = SPT_NUM_IP_IGN_ALLOWED,
 	.pm_vric1_offset = SPT_PMC_VRIC1_OFFSET,
 };
diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
index e0580de180773..4742b84fe226e 100644
--- a/drivers/platform/x86/intel/pmc/tgl.c
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@ -197,6 +197,10 @@ const struct pmc_reg_map tgl_reg_map = {
 	.ppfear_buckets = ICL_PPFEAR_NUM_ENTRIES,
 	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
+#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
+	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
+	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
+#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
 	.ltr_ignore_max = TGL_NUM_IP_IGN_ALLOWED,
 	.lpm_num_maps = TGL_LPM_NUM_MAPS,
 	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
-- 
2.45.2.803.g4e1b14247a-goog


