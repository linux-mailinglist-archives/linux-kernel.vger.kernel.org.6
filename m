Return-Path: <linux-kernel+bounces-282744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAA494E813
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9911C21BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99B415C150;
	Mon, 12 Aug 2024 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KsrbiMGZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1063513E40F;
	Mon, 12 Aug 2024 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448961; cv=none; b=rIyFBwUZUat33u0LXP7+xGwSpyztM6dGE6NXD2KjaGc3uTMGVVgoTWfymPV+034LXgZF7gonzgRDepMYUusaYD+8VCp9XZI2DZE5gy3ves0FQWd+8zt7caYT4KLl/lG2ag4H5y6ILR94Earsn3RG9U4s0A4iWOrkVQpHdOGmHSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448961; c=relaxed/simple;
	bh=hBbWq0pUcJsqyBWdRORYpfohprEsOoWjIkv9bSIYT6U=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=S6411FMpP1p2owNZT3ptdJ8TP3oqV+Fdz3h6D+Q+56XDpkJxJr0akJJjtF3r5Xjca2dcJvT0zpfohbkRvJV91OqxyffpSQsSIVs5EC4PvWGn/tNEHJw+6wS1xqD0eSjgrHw9XktEqcih9zzUnz/s0j8qsHwYV7r2TwaMVSnzqy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KsrbiMGZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723448959; x=1754984959;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hBbWq0pUcJsqyBWdRORYpfohprEsOoWjIkv9bSIYT6U=;
  b=KsrbiMGZ3hUBcDd1g/C0vNNAPA4dtiX8x4qoVIOuFOip2Lf8v3rIk9uL
   WmYqqQLnxN9HXwrUUjAgxJVX/gG5jcMgBLViXCyv50L8ZPHpGjoOojGuv
   7Ep0fRYMZwMo0auDnueuLi8qQIPX47dZM9cX6NKTQcPKDJbLVLnyvrX8S
   57TmtyO3OxCc6J/iLc7O4CLQwVUgZ1zouJnEl5tSQfflkPEXVPqPvMSes
   2EDz8ZTmfZvTmL9/3xIHt9ATVsthWZaoj+sno5MI/CvWHczoynBlxi2Jj
   oEojRslz6rKF3fLJkuQdMA8SrO6FN/uGLovOIBN4bvmc3GFwNfYRqhrvL
   g==;
X-CSE-ConnectionGUID: lBK2H0LJTNWs1RwPGMYdeg==
X-CSE-MsgGUID: Gy7EBzTPSN6q0MTsXrAZpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="32936592"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="32936592"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 00:49:18 -0700
X-CSE-ConnectionGUID: 6h5a9p3OSy6M1BHHLeEuhg==
X-CSE-MsgGUID: ADFjhJZ6QbGDQ8Ow6YbrLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="89019703"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.25])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 00:49:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 12 Aug 2024 10:49:13 +0300 (EEST)
To: Marek Maslanka <mmaslanka@google.com>
cc: LKML <linux-kernel@vger.kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Thomas Gleixner <tglx@linutronix.de>, 
    Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, 
    David E Box <david.e.box@intel.com>, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 2/2] platform/x86:intel/pmc: Enable the ACPI PM Timer
 to be turned off when suspended
In-Reply-To: <20240812044028.3439329-1-mmaslanka@google.com>
Message-ID: <f5f758f9-bf6f-57dd-179e-475a6b65e903@linux.intel.com>
References: <87h6bttzzh.ffs@tglx> <20240812044028.3439329-1-mmaslanka@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 12 Aug 2024, Marek Maslanka wrote:

> Allow to disable ACPI PM Timer on suspend and enable on resume. A
> disabled timer helps optimise power consumption when the system is
> suspended. On resume the timer is only reactivated if it was activated
> prior to suspend, so unless the ACPI PM timer is enabled in the BIOS,
> this won't change anything.
> 
> The ACPI PM timer is used by Intel's iTCO/wdat_wdt watchdog to drive the
> watchdog, so it doesn't need to run during suspend.
> 
> Signed-off-by: Marek Maslanka <mmaslanka@google.com>
> 
> ---
> Changes in v5:
> - Use renamed acpi_pmtmr_register_suspend_resume_callback instead of
>   acpi_pm_register_suspend_resume_callback
> - Link to v4: https://lore.kernel.org/lkml/20240809131343.1173369-2-mmaslanka@google.com/
> ---
> ---
>  drivers/platform/x86/intel/pmc/adl.c  |  2 ++
>  drivers/platform/x86/intel/pmc/cnp.c  |  2 ++
>  drivers/platform/x86/intel/pmc/core.c | 49 +++++++++++++++++++++++++++
>  drivers/platform/x86/intel/pmc/core.h |  8 +++++
>  drivers/platform/x86/intel/pmc/icl.c  |  2 ++
>  drivers/platform/x86/intel/pmc/mtl.c  |  2 ++
>  drivers/platform/x86/intel/pmc/spt.c  |  2 ++
>  drivers/platform/x86/intel/pmc/tgl.c  |  2 ++
>  8 files changed, 69 insertions(+)
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
> index 10c96c1a850af..d65e3e77ec2ca 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -11,6 +11,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/acpi_pmtmr.h>
>  #include <linux/bitfield.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
> @@ -1171,6 +1172,42 @@ static bool pmc_core_is_pson_residency_enabled(struct pmc_dev *pmcdev)
>  	return val == 1;
>  }
>  
> +/**
> + * Enable or disable ACPI PM Timer
> + *
> + * This function is intended to be a callback for ACPI PM suspend/resume event.
> + * The ACPI PM Timer is enabled on resume only if it was enabled during suspend.
> + */
> +static void pmc_core_acpi_pm_timer_suspend_resume(void *data, bool suspend)
> +{
> +	struct pmc_dev *pmcdev = data;
> +	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
> +	const struct pmc_reg_map *map = pmc->map;
> +	bool enabled;
> +	u32 reg;
> +
> +	if (!map->acpi_pm_tmr_ctl_offset)
> +		return;
> +
> +	mutex_lock(&pmcdev->lock);
> +
> +	if (!suspend && !pmcdev->enable_acpi_pm_timer_on_resume) {
> +		mutex_unlock(&pmcdev->lock);

Use guard() in this function so you don't need to manually unlock.

-- 
 i.


> +		return;
> +	}
> +
> +	reg = pmc_core_reg_read(pmc, map->acpi_pm_tmr_ctl_offset);
> +	enabled = !(reg & map->acpi_pm_tmr_disable_bit);
> +	if (suspend)
> +		reg |= map->acpi_pm_tmr_disable_bit;
> +	else
> +		reg &= ~map->acpi_pm_tmr_disable_bit;
> +	pmc_core_reg_write(pmc, map->acpi_pm_tmr_ctl_offset, reg);
> +
> +	pmcdev->enable_acpi_pm_timer_on_resume = suspend && enabled;
> +
> +	mutex_unlock(&pmcdev->lock);
> +}

