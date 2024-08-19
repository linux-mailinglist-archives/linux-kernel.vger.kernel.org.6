Return-Path: <linux-kernel+bounces-291956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E42D956956
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D6A1F225D9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B24F166F07;
	Mon, 19 Aug 2024 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9BPeXIb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3F0165EFB
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067123; cv=none; b=kJYPRvhEsriVWZSFgAn6vpH3GygRb/Fh/agD045mF4H22mdoj3W7n0In+pAoNxLPDR+4zRyE9c+HLZZNNLIILu7074T/Joj3RyXq25w1iMAP4zFiCP1FEFsZLIICDRVSFnluebZ+YYtqqQk+kCDlDDsphuIZ7XpuCHQmTxfFN14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067123; c=relaxed/simple;
	bh=6rgcGwUUybJKRz3xVJeRQHraSlHZg2qQMu+RKpLbfLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nbbbDvA7Iy719QpfYvXiNNULO3f0WvIho7KSM9CX3x8zWDPJN8BjfPN9opo/ownHM4v4b5fCw249ls2pJTzulevA1gn89ccFKGwC8hXv6Smo33q3JeVpEc7rvE4X7FgQH0aaTreiRBWkKHhBkeosk7IKIkkQo+ltEJtUNP9/WAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9BPeXIb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724067120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OpoZ2uaAP/x527SFfgPTaAj7fQVOIjN/iyYAAwIX5A=;
	b=H9BPeXIbonyoentjDe04HcaRppuR/ANiHp3Zk9bYh/wY8mjaSRq8pPnPdPAQf8zIemHFqY
	KokZCjGJ4h3q6URZpulNVbyO553JlAxuIRK1unO3i8EzM2s65upVT3ewplcesfXBoEBqGJ
	a7f/5w2dCWwFdzyyRkXztp+FuPmqjzU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-h5lygEULO9S7ZcDp5RPzHw-1; Mon, 19 Aug 2024 07:31:58 -0400
X-MC-Unique: h5lygEULO9S7ZcDp5RPzHw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7d6a72ad99so293438766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 04:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724067117; x=1724671917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OpoZ2uaAP/x527SFfgPTaAj7fQVOIjN/iyYAAwIX5A=;
        b=O9n2seSH5bbHFnSgR0Gy7RxbEOuo/v+v26YucBuMVuekE9WAHVH/kTcYIgwQFkQeXx
         dRFejeiNwrKuxxULGmcPP8buSDTHNFydmGhe6mvaWDWRG9f69L0VsWMqbhUgdwUMJsci
         49lPI10r3gJF1KWgdrsDPt1C7s0pBinAYzG3jogAe9PWaJtJcauQTvrWss7cm0wRv6nH
         v/5E4nD5qS2AV83sTgQy6D8XQoeO9x4xLyBi0OrZsiMSzjsbcaMLvadFoZ/Tf2MQd65C
         9Ws+CddE0QfE9RzS5KyeK2+RhU5TcdK1UbPYP/0P5/E/wFwYGD54m9G5sjXWFU02o62u
         b/fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu03tI+pvJdJWgG+s8FPkFHgXsAwRSqPfMW9wglLDKlUXFVj43HnY4TH15BlaBQohZwBFh+O+1ierlXTKRzYb5dnMSqg8iCAfJN2w7
X-Gm-Message-State: AOJu0YyXAdnkF2/6V0aJb325wOBG+SY0hzPiP30LAU+NclK18bK211SG
	Qj9cbnaSY8s1kT33/WEIc136p/jEKjI5b9l+fjsJUq8B5UcUNLfN9U8fIVL4BQYEsQVgQIgGoFR
	6NlDq4N9YxTwyI13pGZYjOZ2sns0PtEq6/caBEhTUMa2lOTG2VRJtZGf86J6fQw==
X-Received: by 2002:a17:907:7f12:b0:a7a:b9dd:7757 with SMTP id a640c23a62f3a-a83928a1c6amr782037366b.12.1724067117555;
        Mon, 19 Aug 2024 04:31:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ1VfXiB8AMT0+Cz1fYd9GS+ES9g1eIucB4FUz49wdbR8STGlLz4HdH80GjjSPvJW6koISJQ==
X-Received: by 2002:a17:907:7f12:b0:a7a:b9dd:7757 with SMTP id a640c23a62f3a-a83928a1c6amr782034866b.12.1724067117062;
        Mon, 19 Aug 2024 04:31:57 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6be6sm624737266b.34.2024.08.19.04.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 04:31:56 -0700 (PDT)
Message-ID: <9ca10fff-b0a5-4d86-94e8-06ddfa4df980@redhat.com>
Date: Mon, 19 Aug 2024 13:31:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] platform/x86:intel/pmc: Enable the ACPI PM Timer
 to be turned off when suspended
To: Marek Maslanka <mmaslanka@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
References: <f5f758f9-bf6f-57dd-179e-475a6b65e903@linux.intel.com>
 <20240812184208.1080710-1-mmaslanka@google.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240812184208.1080710-1-mmaslanka@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/12/24 8:42 PM, Marek Maslanka wrote:
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

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> 
> ---
> Changes in v6:
> - Use guard() to manage the mutex instead of mutex_lock/mutex_unlock
> - Use newly added acpi_pmtmr_unregister_suspend_resume_callback to remove callback
> - Link to v5: https://lore.kernel.org/lkml/20240812044028.3439329-1-mmaslanka@google.com/
> ---
> ---
>  drivers/platform/x86/intel/pmc/adl.c  |  2 ++
>  drivers/platform/x86/intel/pmc/cnp.c  |  2 ++
>  drivers/platform/x86/intel/pmc/core.c | 45 +++++++++++++++++++++++++++
>  drivers/platform/x86/intel/pmc/core.h |  8 +++++
>  drivers/platform/x86/intel/pmc/icl.c  |  2 ++
>  drivers/platform/x86/intel/pmc/mtl.c  |  2 ++
>  drivers/platform/x86/intel/pmc/spt.c  |  2 ++
>  drivers/platform/x86/intel/pmc/tgl.c  |  2 ++
>  8 files changed, 65 insertions(+)
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
> index 10c96c1a850af..d8fa9bed4cd3c 100644
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
> @@ -1171,6 +1172,38 @@ static bool pmc_core_is_pson_residency_enabled(struct pmc_dev *pmcdev)
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
> +	guard(mutex)(&pmcdev->lock);
> +
> +	if (!suspend && !pmcdev->enable_acpi_pm_timer_on_resume)
> +		return;
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
> +}
>  
>  static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
>  {
> @@ -1362,6 +1395,7 @@ static int pmc_core_probe(struct platform_device *pdev)
>  	struct pmc_dev *pmcdev;
>  	const struct x86_cpu_id *cpu_id;
>  	int (*core_init)(struct pmc_dev *pmcdev);
> +	const struct pmc_reg_map *map;
>  	struct pmc *primary_pmc;
>  	int ret;
>  
> @@ -1420,6 +1454,11 @@ static int pmc_core_probe(struct platform_device *pdev)
>  	pm_report_max_hw_sleep(FIELD_MAX(SLP_S0_RES_COUNTER_MASK) *
>  			       pmc_core_adjust_slp_s0_step(primary_pmc, 1));
>  
> +	map = primary_pmc->map;
> +	if (map->acpi_pm_tmr_ctl_offset)
> +		acpi_pmtmr_register_suspend_resume_callback(pmc_core_acpi_pm_timer_suspend_resume,
> +							 pmcdev);
> +
>  	device_initialized = true;
>  	dev_info(&pdev->dev, " initialized\n");
>  
> @@ -1429,6 +1468,12 @@ static int pmc_core_probe(struct platform_device *pdev)
>  static void pmc_core_remove(struct platform_device *pdev)
>  {
>  	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
> +	const struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
> +	const struct pmc_reg_map *map = pmc->map;
> +
> +	if (map->acpi_pm_tmr_ctl_offset)
> +		acpi_pmtmr_unregister_suspend_resume_callback();
> +
>  	pmc_core_dbgfs_unregister(pmcdev);
>  	pmc_core_clean_structure(pdev);
>  }
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


