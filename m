Return-Path: <linux-kernel+bounces-267439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A85F4941181
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57FCB283A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B2219DF78;
	Tue, 30 Jul 2024 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NXoCrKng"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDA3194C8D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722341153; cv=none; b=u5ml4s2uO1XOJDvTP5S+8u0Xu+sUa/Q84bcrRtkCQhRAUQ3r2llhnYo+vloufUCLCUBUK60TM9oHEp2NtUxA9C8Jao6tvVhdEBoO/o9TN8EWo9cOtDd0GvpDObYXyeaZGv9JkfFSqd8Ezxj/2boSMCiEGsuyk+svWYwfO5LAYUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722341153; c=relaxed/simple;
	bh=JD2cBdu9k/WO1pOJepobDhQwaeQ1SW6evxBKp1GZePY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uBhi0EUCDZYNaZyvS/jkMrphSnM56aWVna18bm52SQswHoSyUSYeBxxouCLiVeE+q9SH/ckWlWr/mMBw9lEDF14nC5bHUuFKHsiuqCkJhGY2/BHDKaIlo82kO+nGcGj2m+tY5Akg3sU0rB1KyNA/gMg7Rh0nARTEDZovEfMuBD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaslanka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NXoCrKng; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaslanka.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6698f11853aso76180717b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722341151; x=1722945951; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G4GPJTNACJVmyvK8yCIcXTVNooYietpPwpeg6FVIOno=;
        b=NXoCrKngyKrYgAyWjEUWD6WRAWHrNuq7SGSDLZzyHN19d1TB57DquwnWs31Yh3MXI9
         UqrMWSN1gI2BXT6JZjy+gxJGxHIA+YVzGpmS3dE3mT2TqjX7UUHHrmnhKNRyNPFPUFtt
         8aUIK9PBEnvkfhCgmWTpXt+T/e6XKuRDJKLJ1HsgEiHzJHaJl6NAZ1Dumk/ZM9wJqQ2w
         e/p9FnUafCsTJ5bq9Y/RluohMaDYwsFAKl9gYUJfNA16ZZTmgj1aAfl/V5v9u4GZi8dB
         VxKeB+K0Bcv6xFR5R0vDQQbk9oiF2yFxytGWT75iGklA+P7qhjuOwvkZy/KcIskMa7Ft
         lAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722341151; x=1722945951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G4GPJTNACJVmyvK8yCIcXTVNooYietpPwpeg6FVIOno=;
        b=bTK9oeW2xoSc7XZhN7fyxJVAWECJP+I2rjp9Z+IZNcB9DIvOWwaNnkuUn0BX+n2/x9
         ZWTOyRhW8XKsFyeGOl3tdDwYw4t4U1vdLFvds43dehsENosN2V9IfvbNetTplBUrftsF
         MoDKmT2Nq19On1gv+G9mUSE59FoM3HptqfpV54YSgUkV+5tFGw5wbjVaYqNKbv4FhaYc
         +ovypTI5EII7Ub0+SsbwFadYaO3MFpzJKUOaLZwD2ZS5S01i5z1VzIhQxCOyTlHhcwO7
         q+32MvMAdstQWJ0lvP9ECr8vu5161FxW/r30hIQIW6DeZpxRuW821dTH6rBT7RsZbCj6
         Zlwg==
X-Gm-Message-State: AOJu0YxSJJStRzRn5+maL+0VpQj6Z/kEYkdrOfZ/vGX0Ns3ZlfUMtsdm
	pm8ahCrDOIJ39yVmxYvMQpfHrYeVO6xomA54o6sxxd1CQrlqkRF2DA+NTIMdiBFRYUJpAhHU4Q0
	RE6Cr1JFMIbEURnKpsbMTG9m6ZVVJJ/5xsSBKDIJAqUxW26hCjN5W8RVQ0yaplBGElrI7A/4lnq
	VymLknxziekxbiey5oR+7TX9EaV2Kw+Cy6Vz/uPbAfrlI1/Tm5B+3rD1/P
X-Google-Smtp-Source: AGHT+IEd32rqD5qWvdku11FoYZwTC33fpk2BKn6/V45gNAyY7zwU0OV3kL4PpCOUNj473K3R4DS0dSVUGA6SI54=
X-Received: from mmaslanka2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:b8d])
 (user=mmaslanka job=sendgmr) by 2002:a05:690c:ecd:b0:650:93e3:fe73 with SMTP
 id 00721157ae682-67a09784099mr1320817b3.5.1722341150640; Tue, 30 Jul 2024
 05:05:50 -0700 (PDT)
Date: Tue, 30 Jul 2024 12:05:44 +0000
In-Reply-To: <CAGcaFA2sQNRo9UThN-C1NOLtGUJ3sKzc=pEC9wdDWMi501iLsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAGcaFA2sQNRo9UThN-C1NOLtGUJ3sKzc=pEC9wdDWMi501iLsA@mail.gmail.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240730120546.1042515-1-mmaslanka@google.com>
Subject: [PATCH v3] platform/x86:intel/pmc: Enable the ACPI PM Timer to be
 turned off when suspended
From: Marek Maslanka <mmaslanka@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marek Maslanka <mmaslanka@google.com>, Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, 
	David E Box <david.e.box@intel.com>, Hans de Goede <hdegoede@redhat.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow to disable ACPI PM Timer on suspend and enable on resume. A
disabled timer helps optimise power consumption when the system is
suspended. On resume the timer is only reactivated if it was activated
prior to suspend, so unless the ACPI PM timer is enabled in the BIOS,
this won't change anything.

Signed-off-by: Marek Maslanka <mmaslanka@google.com>

---
Changes in v3:
- Add the clocksource_current_cs_name and clocksource_suspend_cs_name to the clocksource.c
- Do not disable the ACPI PM timer if it's selected as the clocksource
- Link to v2: https://lore.kernel.org/lkml/20240703113850.2726539-1-mmaslanka@google.com/
---
---
 drivers/platform/x86/intel/pmc/adl.c  |  2 ++
 drivers/platform/x86/intel/pmc/cnp.c  |  2 ++
 drivers/platform/x86/intel/pmc/core.c | 47 +++++++++++++++++++++++++++
 drivers/platform/x86/intel/pmc/core.h |  8 +++++
 drivers/platform/x86/intel/pmc/icl.c  |  2 ++
 drivers/platform/x86/intel/pmc/mtl.c  |  2 ++
 drivers/platform/x86/intel/pmc/spt.c  |  2 ++
 drivers/platform/x86/intel/pmc/tgl.c  |  2 ++
 include/linux/clocksource.h           |  2 ++
 kernel/time/clocksource.c             | 22 +++++++++++++
 10 files changed, 91 insertions(+)

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
index 10c96c1a850af..1a435f5ca08c5 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/bitfield.h>
+#include <linux/clocksource.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
@@ -1171,6 +1172,44 @@ static bool pmc_core_is_pson_residency_enabled(struct pmc_dev *pmcdev)
 	return val == 1;
 }
 
+/*
+ * Enable or disable APCI PM Timer
+ *
+ * @return: Previous APCI PM Timer enabled state
+ */
+static bool pmc_core_enable_apci_pm_timer(struct pmc_dev *pmcdev, bool enable)
+{
+	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
+	const struct pmc_reg_map *map = pmc->map;
+	char cs_name[32];
+	bool state;
+	u32 reg;
+
+	if (!map->acpi_pm_tmr_ctl_offset)
+		return false;
+
+	clocksource_current_cs_name(cs_name, sizeof(cs_name));
+	if (strncmp(cs_name, "acpi_pm", sizeof(cs_name)) == 0)
+		return false;
+
+	clocksource_suspend_cs_name(cs_name, sizeof(cs_name));
+	if (strncmp(cs_name, "acpi_pm", sizeof(cs_name)) == 0)
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
 
 static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
 {
@@ -1446,6 +1485,10 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
 	if (pmcdev->suspend)
 		pmcdev->suspend(pmcdev);
 
+	/* Disable APCI PM Timer */
+	pmcdev->enable_acpi_pm_timer_on_resume =
+		pmc_core_enable_apci_pm_timer(pmcdev, false);
+
 	/* Check if the syspend will actually use S0ix */
 	if (pm_suspend_via_firmware())
 		return 0;
@@ -1500,6 +1543,10 @@ int pmc_core_resume_common(struct pmc_dev *pmcdev)
 	int offset = pmc->map->lpm_status_offset;
 	int i;
 
+	/* Enable APCI PM Timer */
+	if (pmcdev->enable_acpi_pm_timer_on_resume)
+		pmc_core_enable_apci_pm_timer(pmcdev, true);
+
 	/* Check if the syspend used S0ix */
 	if (pm_suspend_via_firmware())
 		return 0;
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
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 0ad8b550bb4b4..f1953c5687683 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -305,5 +305,7 @@ static inline unsigned int clocksource_get_max_watchdog_retry(void)
 }
 
 void clocksource_verify_percpu(struct clocksource *cs);
+void clocksource_current_cs_name(char *buf, size_t buf_size);
+void clocksource_suspend_cs_name(char *buf, size_t buf_size);
 
 #endif /* _LINUX_CLOCKSOURCE_H */
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index e5b260aa0e02c..e2e2609f7f4b2 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -1320,6 +1320,28 @@ int clocksource_unregister(struct clocksource *cs)
 }
 EXPORT_SYMBOL(clocksource_unregister);
 
+void clocksource_suspend_cs_name(char *buf, size_t buf_size)
+{
+	mutex_lock(&clocksource_mutex);
+
+	buf[0] = '\0';
+	if (suspend_clocksource)
+		strscpy(buf, suspend_clocksource->name, buf_size);
+
+	mutex_unlock(&clocksource_mutex);
+}
+
+void clocksource_current_cs_name(char *buf, size_t buf_size)
+{
+	mutex_lock(&clocksource_mutex);
+
+	buf[0] = '\0';
+	if (curr_clocksource)
+		strscpy(buf, curr_clocksource->name, buf_size);
+
+	mutex_unlock(&clocksource_mutex);
+}
+
 #ifdef CONFIG_SYSFS
 /**
  * current_clocksource_show - sysfs interface for current clocksource
-- 
2.46.0.rc2.264.g509ed76dc8-goog


