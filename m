Return-Path: <linux-kernel+bounces-267548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C08229412AD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9641F234BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC1719F47A;
	Tue, 30 Jul 2024 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5NY66Gh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C157B442C;
	Tue, 30 Jul 2024 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722344259; cv=none; b=ZMQbQN7+0MBxH4groaLihUNK8hPAD9WEllRylUANC4iOOxL83pLIHo3z6VqfTQLED3XGBD2+Ld9JR/YKUw7vm7pDtssxmZNl5lhLPWb0nbYpYSDTfRi7pH33tg7+UErofN3bs85YKnX3hxQ8T/ohN8qAUrdAQK7A2XWVgljbvR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722344259; c=relaxed/simple;
	bh=qNcjHuUxpauK9Zh02FSiYWYCk0i6eJZaMfcCj8Svtlw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uNZM2gfsaYP/ZvGzBF1tB3ipTOHyEE6qcMMbN8WlJ/ZugvUsSCS9fTcfntQjCBoK4q+luelhjMWN+jbkJlbviaIPpNS/3/BXNPF/1lcGIVWsnL+4qJxr7LBGQAr4vlgXojThN7Vlk31zLRR9MZoS2e0OXxZPBP8PDLwgfeGQjr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5NY66Gh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722344257; x=1753880257;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qNcjHuUxpauK9Zh02FSiYWYCk0i6eJZaMfcCj8Svtlw=;
  b=P5NY66Gh5sqmt9WdG85E4m+8Lof4kDEVB3FELYgLAdhS7IeCfBsYawKI
   szjsr7rEav75vFaSrKpF5YnLFl9Khd5sMO8vTRocKu69GV1VQyyT7URUg
   o4sja8eHqNKMeMpc6P9U7kbR02k9rsHx+J5bRWcgWVqGo0PBSC3DAzh3I
   JdW4+AiXXK/cxi9C1AHPW8FqqhvF5N1MBNd1bVJV+l5Mg50iw0w0Z0jQK
   R2tiHm03Ksjh6xLAVpfy0Tv3G5EhPquX3Ihwz5iHZROknDOG4SSHUv/K/
   jUbPjI7mNnF4sM8brPg0G3N1JPY4FxwA/ckYfeJdAV1izw5VoQcVpmIsX
   Q==;
X-CSE-ConnectionGUID: xakpdEH2S0Wf8N8ITAMeyQ==
X-CSE-MsgGUID: q4RSWc/eSlya4L7X9KZLNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20313707"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="20313707"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 05:57:37 -0700
X-CSE-ConnectionGUID: 3lmCCAUGTWSNZz4fhx0tUw==
X-CSE-MsgGUID: KLJ70NkWSQmfUg8meokv5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="77561991"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.25])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 05:57:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 30 Jul 2024 15:57:28 +0300 (EEST)
To: Marek Maslanka <mmaslanka@google.com>
cc: LKML <linux-kernel@vger.kernel.org>, 
    Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, 
    David E Box <david.e.box@intel.com>, Hans de Goede <hdegoede@redhat.com>, 
    John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
    Stephen Boyd <sboyd@kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3] platform/x86:intel/pmc: Enable the ACPI PM Timer to
 be turned off when suspended
In-Reply-To: <20240730120546.1042515-1-mmaslanka@google.com>
Message-ID: <cf652dd1-9c0f-66cc-9dc1-c900b055dc98@linux.intel.com>
References: <CAGcaFA2sQNRo9UThN-C1NOLtGUJ3sKzc=pEC9wdDWMi501iLsA@mail.gmail.com> <20240730120546.1042515-1-mmaslanka@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 30 Jul 2024, Marek Maslanka wrote:

> Allow to disable ACPI PM Timer on suspend and enable on resume. A
> disabled timer helps optimise power consumption when the system is
> suspended. On resume the timer is only reactivated if it was activated
> prior to suspend, so unless the ACPI PM timer is enabled in the BIOS,
> this won't change anything.
> 
> Signed-off-by: Marek Maslanka <mmaslanka@google.com>
> 
> ---
> Changes in v3:
> - Add the clocksource_current_cs_name and clocksource_suspend_cs_name to the clocksource.c
> - Do not disable the ACPI PM timer if it's selected as the clocksource
> - Link to v2: https://lore.kernel.org/lkml/20240703113850.2726539-1-mmaslanka@google.com/
> ---
> ---
>  drivers/platform/x86/intel/pmc/adl.c  |  2 ++
>  drivers/platform/x86/intel/pmc/cnp.c  |  2 ++
>  drivers/platform/x86/intel/pmc/core.c | 47 +++++++++++++++++++++++++++
>  drivers/platform/x86/intel/pmc/core.h |  8 +++++
>  drivers/platform/x86/intel/pmc/icl.c  |  2 ++
>  drivers/platform/x86/intel/pmc/mtl.c  |  2 ++
>  drivers/platform/x86/intel/pmc/spt.c  |  2 ++
>  drivers/platform/x86/intel/pmc/tgl.c  |  2 ++
>  include/linux/clocksource.h           |  2 ++
>  kernel/time/clocksource.c             | 22 +++++++++++++
>  10 files changed, 91 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/intel/pmc/adl.c
> index e7878558fd909..9d9c07f44ff61 100644
> --- a/drivers/platform/x86/intel/pmc/adl.c
> +++ b/drivers/platform/x86/intel/pmc/adl.c
> @@ -295,6 +295,8 @@ const struct pmc_reg_map adl_reg_map = {
>  	.ppfear_buckets = CNP_PPFEAR_NUM_ENTRIES,
>  	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
>  	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
> +	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> +	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
>  	.ltr_ignore_max = ADL_NUM_IP_IGN_ALLOWED,
>  	.lpm_num_modes = ADL_LPM_NUM_MODES,
>  	.lpm_num_maps = ADL_LPM_NUM_MAPS,
> diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
> index dd72974bf71e2..513c02670c5aa 100644
> --- a/drivers/platform/x86/intel/pmc/cnp.c
> +++ b/drivers/platform/x86/intel/pmc/cnp.c
> @@ -200,6 +200,8 @@ const struct pmc_reg_map cnp_reg_map = {
>  	.ppfear_buckets = CNP_PPFEAR_NUM_ENTRIES,
>  	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
>  	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
> +	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> +	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
>  	.ltr_ignore_max = CNP_NUM_IP_IGN_ALLOWED,
>  	.etr3_offset = ETR3_OFFSET,
>  };
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 10c96c1a850af..1a435f5ca08c5 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -12,6 +12,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/bitfield.h>
> +#include <linux/clocksource.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/dmi.h>
> @@ -1171,6 +1172,44 @@ static bool pmc_core_is_pson_residency_enabled(struct pmc_dev *pmcdev)
>  	return val == 1;
>  }
>  
> +/*
> + * Enable or disable APCI PM Timer
> + *
> + * @return: Previous APCI PM Timer enabled state
> + */
> +static bool pmc_core_enable_apci_pm_timer(struct pmc_dev *pmcdev, bool enable)
> +{
> +	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
> +	const struct pmc_reg_map *map = pmc->map;
> +	char cs_name[32];
> +	bool state;
> +	u32 reg;
> +
> +	if (!map->acpi_pm_tmr_ctl_offset)
> +		return false;
> +
> +	clocksource_current_cs_name(cs_name, sizeof(cs_name));
> +	if (strncmp(cs_name, "acpi_pm", sizeof(cs_name)) == 0)

If you want to do a prefix check, there's str_has_prefix() for that.
Otherwise, I don't understand why you need the n variant?

> +		return false;
> +
> +	clocksource_suspend_cs_name(cs_name, sizeof(cs_name));
> +	if (strncmp(cs_name, "acpi_pm", sizeof(cs_name)) == 0)
> +		return false;
> +
> +	mutex_lock(&pmcdev->lock);
> +
> +	reg = pmc_core_reg_read(pmc, map->acpi_pm_tmr_ctl_offset);
> +	state = !(reg & map->acpi_pm_tmr_disable_bit);
> +	if (enable)
> +		reg &= ~map->acpi_pm_tmr_disable_bit;
> +	else
> +		reg |= map->acpi_pm_tmr_disable_bit;
> +	pmc_core_reg_write(pmc, map->acpi_pm_tmr_ctl_offset, reg);
> +
> +	mutex_unlock(&pmcdev->lock);
> +
> +	return state;
> +}
>  
>  static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
>  {
> @@ -1446,6 +1485,10 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
>  	if (pmcdev->suspend)
>  		pmcdev->suspend(pmcdev);
>  
> +	/* Disable APCI PM Timer */
> +	pmcdev->enable_acpi_pm_timer_on_resume =
> +		pmc_core_enable_apci_pm_timer(pmcdev, false);
> +
>  	/* Check if the syspend will actually use S0ix */
>  	if (pm_suspend_via_firmware())
>  		return 0;
> @@ -1500,6 +1543,10 @@ int pmc_core_resume_common(struct pmc_dev *pmcdev)
>  	int offset = pmc->map->lpm_status_offset;
>  	int i;
>  
> +	/* Enable APCI PM Timer */
> +	if (pmcdev->enable_acpi_pm_timer_on_resume)
> +		pmc_core_enable_apci_pm_timer(pmcdev, true);
> +
>  	/* Check if the syspend used S0ix */
>  	if (pm_suspend_via_firmware())
>  		return 0;
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index 83504c49a0e31..fe1a94f693b63 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -67,6 +67,8 @@ struct telem_endpoint;
>  #define SPT_PMC_LTR_SCC				0x3A0
>  #define SPT_PMC_LTR_ISH				0x3A4
>  
> +#define SPT_PMC_ACPI_PM_TMR_CTL_OFFSET		0x18FC
> +
>  /* Sunrise Point: PGD PFET Enable Ack Status Registers */
>  enum ppfear_regs {
>  	SPT_PMC_XRAM_PPFEAR0A = 0x590,
> @@ -147,6 +149,8 @@ enum ppfear_regs {
>  #define SPT_PMC_VRIC1_SLPS0LVEN			BIT(13)
>  #define SPT_PMC_VRIC1_XTALSDQDIS		BIT(22)
>  
> +#define SPT_PMC_BIT_ACPI_PM_TMR_DISABLE		BIT(1)
> +
>  /* Cannonlake Power Management Controller register offsets */
>  #define CNP_PMC_SLPS0_DBG_OFFSET		0x10B4
>  #define CNP_PMC_PM_CFG_OFFSET			0x1818
> @@ -344,6 +348,8 @@ struct pmc_reg_map {
>  	const u8  *lpm_reg_index;
>  	const u32 pson_residency_offset;
>  	const u32 pson_residency_counter_step;
> +	const u32 acpi_pm_tmr_ctl_offset;
> +	const u32 acpi_pm_tmr_disable_bit;
>  };
>  
>  /**
> @@ -417,6 +423,8 @@ struct pmc_dev {
>  	u32 die_c6_offset;
>  	struct telem_endpoint *punit_ep;
>  	struct pmc_info *regmap_list;
> +
> +	bool enable_acpi_pm_timer_on_resume;
>  };
>  
>  enum pmc_index {
> diff --git a/drivers/platform/x86/intel/pmc/icl.c b/drivers/platform/x86/intel/pmc/icl.c
> index 71b0fd6cb7d84..cbbd440544688 100644
> --- a/drivers/platform/x86/intel/pmc/icl.c
> +++ b/drivers/platform/x86/intel/pmc/icl.c
> @@ -46,6 +46,8 @@ const struct pmc_reg_map icl_reg_map = {
>  	.ppfear_buckets = ICL_PPFEAR_NUM_ENTRIES,
>  	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
>  	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
> +	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> +	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
>  	.ltr_ignore_max = ICL_NUM_IP_IGN_ALLOWED,
>  	.etr3_offset = ETR3_OFFSET,
>  };
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
> index c7d15d864039d..91f2fa728f5c8 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -462,6 +462,8 @@ const struct pmc_reg_map mtl_socm_reg_map = {
>  	.ppfear_buckets = MTL_SOCM_PPFEAR_NUM_ENTRIES,
>  	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
>  	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
> +	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> +	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
>  	.lpm_num_maps = ADL_LPM_NUM_MAPS,
>  	.ltr_ignore_max = MTL_SOCM_NUM_IP_IGN_ALLOWED,
>  	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
> diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/intel/pmc/spt.c
> index ab993a69e33ee..2cd2b3c68e468 100644
> --- a/drivers/platform/x86/intel/pmc/spt.c
> +++ b/drivers/platform/x86/intel/pmc/spt.c
> @@ -130,6 +130,8 @@ const struct pmc_reg_map spt_reg_map = {
>  	.ppfear_buckets = SPT_PPFEAR_NUM_ENTRIES,
>  	.pm_cfg_offset = SPT_PMC_PM_CFG_OFFSET,
>  	.pm_read_disable_bit = SPT_PMC_READ_DISABLE_BIT,
> +	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> +	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
>  	.ltr_ignore_max = SPT_NUM_IP_IGN_ALLOWED,
>  	.pm_vric1_offset = SPT_PMC_VRIC1_OFFSET,
>  };
> diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
> index e0580de180773..371b4e30f1426 100644
> --- a/drivers/platform/x86/intel/pmc/tgl.c
> +++ b/drivers/platform/x86/intel/pmc/tgl.c
> @@ -197,6 +197,8 @@ const struct pmc_reg_map tgl_reg_map = {
>  	.ppfear_buckets = ICL_PPFEAR_NUM_ENTRIES,
>  	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
>  	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
> +	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> +	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
>  	.ltr_ignore_max = TGL_NUM_IP_IGN_ALLOWED,
>  	.lpm_num_maps = TGL_LPM_NUM_MAPS,
>  	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index 0ad8b550bb4b4..f1953c5687683 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -305,5 +305,7 @@ static inline unsigned int clocksource_get_max_watchdog_retry(void)
>  }
>  
>  void clocksource_verify_percpu(struct clocksource *cs);
> +void clocksource_current_cs_name(char *buf, size_t buf_size);
> +void clocksource_suspend_cs_name(char *buf, size_t buf_size);
>  
>  #endif /* _LINUX_CLOCKSOURCE_H */
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index e5b260aa0e02c..e2e2609f7f4b2 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -1320,6 +1320,28 @@ int clocksource_unregister(struct clocksource *cs)
>  }
>  EXPORT_SYMBOL(clocksource_unregister);
>  
> +void clocksource_suspend_cs_name(char *buf, size_t buf_size)
> +{
> +	mutex_lock(&clocksource_mutex);
> +
> +	buf[0] = '\0';
> +	if (suspend_clocksource)
> +		strscpy(buf, suspend_clocksource->name, buf_size);
> +
> +	mutex_unlock(&clocksource_mutex);
> +}
> +
> +void clocksource_current_cs_name(char *buf, size_t buf_size)
> +{
> +	mutex_lock(&clocksource_mutex);
> +
> +	buf[0] = '\0';
> +	if (curr_clocksource)
> +		strscpy(buf, curr_clocksource->name, buf_size);
> +
> +	mutex_unlock(&clocksource_mutex);
> +}

Have you tested allmodconfig build? These functions are not exported so
I'd expect it to fail...

One could use guard() for the mutex.

-- 
 i.


