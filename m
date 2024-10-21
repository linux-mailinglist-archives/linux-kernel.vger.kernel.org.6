Return-Path: <linux-kernel+bounces-374543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F749A6BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A981F22544
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1241F4FB1;
	Mon, 21 Oct 2024 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpbWGYdX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138C51EB9FC
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519866; cv=none; b=U3aPM9/YMIYAKtKIjJO3a8UIpcH3dbpsx3WbVuU9RCEIPl8BVrZMokQNwTgnswXGqcLhN6Rv6qMZIkvlthuz1YNysUorfMXVFuN2m+VrD8Vg2Gb2zr0n5uHJXsTr6xDtkoErqSrcNiwu4yXCYAKOQOVNwwMMXjnjw4rwhG4UbZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519866; c=relaxed/simple;
	bh=y2WQ6KtuDB8NK0WtIkgOFvxHoDWTIGrAmd8Miiu+9OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ic+K+4YIn/pmKnwaieWwMttAiA9nuUFof+40DTzvYBvmjmbJUlYETjYId1aae3shLYS2t22X7ofxk8xeuZ1bhUu4GeJzk00E79eQJztjdXNdJas8fPAhp9BHBIG4/VX4RezdeTNzpN6xwnwZhgzBeB03ZpT1TCHk9PMhFHi3CkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HpbWGYdX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729519862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XgpBBX2ng8CuomM/dXM1PH4uti3FqeAmtyry7br7VUw=;
	b=HpbWGYdXAtM/PxvZpULBieSy40jXC4Xi+GjYj/7BItO16PzNw8KPiKe4kUP0OLFTgfTUK7
	+mpxo5WLuQCdwcHBmdufirK2Wn0NQS6kSNITUIvJv6TdjLfHd7Igcw5628oyldF3qbHXn0
	8Ai/QqFg+N4Ve5lpgCA1FgQkSc1ylVs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-Fj7_XU2aOU2TArKask-Nsw-1; Mon, 21 Oct 2024 10:11:00 -0400
X-MC-Unique: Fj7_XU2aOU2TArKask-Nsw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2fb5cdaba8aso33584771fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729519859; x=1730124659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XgpBBX2ng8CuomM/dXM1PH4uti3FqeAmtyry7br7VUw=;
        b=YhgmesgSeJG6//59nzNS9c6of8+DZD2LQeMOFrl9lX36X2pNmuTQ+aGpAv6rjxhpmU
         io+TU9KfAM/XVwSUfGujIjntyNsZOK9XgIpkhH3HepKZj1BWnnRKHlNpz7pbMiiuLaXy
         hCU6iUZ+K7tsQvK79n/O3TO8/6PrcGImd6SVvZoq589n1K+YAPZizUrqsOsqDhfbRbAG
         fngYy0WXuZCm/aCiawklVKqjsOPQMIAkcmxHu74yeC+evlb+uXE/4QsuOcCJ61dqCKwF
         xihonlTkg+TXmnFMpxr03CwhZzMUirPzM3wQPequL9uUz5m71TFEA3HQjrREe54uQwv5
         pT9w==
X-Forwarded-Encrypted: i=1; AJvYcCWVQOQZ7s/vtbk/tsgCK4v49YRJtBFlevTe+guSgoD6CaDXH2dfGufc7xqj23U2DMF7ezUg218WOHJzyws=@vger.kernel.org
X-Gm-Message-State: AOJu0YytAM6SV2GrJhtnGJ813IhjIhPOiiek2gM9cWYgVBBtYkUMt3lT
	SLlAhWOJCwq0YvZ4EXvXMdukGCYqQhpfMjU9OfKSCkAqrq1/BPgnQ2vW0PCO32A/0pOfYEXm7+D
	CGD/Ttn/clunLcP5SvFE3rR/1KvSXgtllH3O9ibkU8wgh7Gsph1HOKL4Mu7A93g==
X-Received: by 2002:a2e:be0f:0:b0:2fb:357a:be4d with SMTP id 38308e7fff4ca-2fb8320f940mr83525451fa.43.1729519858835;
        Mon, 21 Oct 2024 07:10:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMOfQKWnwXo9RDoBb4qK+qtYb1Jg0ojZarnFAAE5/ehl6jU3p001A/NsyTrh9QXtvkNZ2F4g==
X-Received: by 2002:a2e:be0f:0:b0:2fb:357a:be4d with SMTP id 38308e7fff4ca-2fb8320f940mr83525161fa.43.1729519858285;
        Mon, 21 Oct 2024 07:10:58 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d62fasm207257066b.28.2024.10.21.07.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 07:10:57 -0700 (PDT)
Message-ID: <2a725608-4057-4f28-b087-7aa2715488b0@redhat.com>
Date: Mon, 21 Oct 2024 16:10:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "platform/x86:intel/pmc: Enable the ACPI PM Timer
 to be turned off when suspended"
To: Marek Maslanka <mmaslanka@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
References: <d5e6a9b4-f9e2-4c6a-ac2d-bba1b12d7675@redhat.com>
 <20241012182656.2107178-1-mmaslanka@google.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241012182656.2107178-1-mmaslanka@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12-Oct-24 8:26 PM, Marek Maslanka wrote:
> This reverts commit e86c8186d03a6ba018e881ed45f0962ad553e861.
> 
> This can cause the suspend process to hang as the pmcdev->lock in the
> pmc_core_acpi_pm_timer_suspend_resume might already be held by the
> pmc_core_mphy_pg_show or pmc_core_pll_show if the userspace gets frozen
> when these functions are being executed.
> Also, pmc_core_acpi_pm_timer_suspend_resume must not sleep, as this
> function is called indirectly by the tick_freeze function in
> kernel/time/tick-common.c, which holds the spinlock.
> 
> Signed-off-by: Marek Maslanka <mmaslanka@google.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



> ---
>  drivers/platform/x86/intel/pmc/adl.c  |  2 --
>  drivers/platform/x86/intel/pmc/cnp.c  |  2 --
>  drivers/platform/x86/intel/pmc/core.c | 46 ---------------------------
>  drivers/platform/x86/intel/pmc/core.h |  8 -----
>  drivers/platform/x86/intel/pmc/icl.c  |  2 --
>  drivers/platform/x86/intel/pmc/mtl.c  |  2 --
>  drivers/platform/x86/intel/pmc/spt.c  |  2 --
>  drivers/platform/x86/intel/pmc/tgl.c  |  2 --
>  8 files changed, 66 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/intel/pmc/adl.c
> index 9d9c07f44ff6..e7878558fd90 100644
> --- a/drivers/platform/x86/intel/pmc/adl.c
> +++ b/drivers/platform/x86/intel/pmc/adl.c
> @@ -295,8 +295,6 @@ const struct pmc_reg_map adl_reg_map = {
>  	.ppfear_buckets = CNP_PPFEAR_NUM_ENTRIES,
>  	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
>  	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
> -	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> -	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
>  	.ltr_ignore_max = ADL_NUM_IP_IGN_ALLOWED,
>  	.lpm_num_modes = ADL_LPM_NUM_MODES,
>  	.lpm_num_maps = ADL_LPM_NUM_MAPS,
> diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
> index 513c02670c5a..dd72974bf71e 100644
> --- a/drivers/platform/x86/intel/pmc/cnp.c
> +++ b/drivers/platform/x86/intel/pmc/cnp.c
> @@ -200,8 +200,6 @@ const struct pmc_reg_map cnp_reg_map = {
>  	.ppfear_buckets = CNP_PPFEAR_NUM_ENTRIES,
>  	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
>  	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
> -	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> -	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
>  	.ltr_ignore_max = CNP_NUM_IP_IGN_ALLOWED,
>  	.etr3_offset = ETR3_OFFSET,
>  };
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index ecb47f8b4f83..4e9c8c96c8cc 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -11,7 +11,6 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> -#include <linux/acpi_pmtmr.h>
>  #include <linux/bitfield.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
> @@ -1258,39 +1257,6 @@ static bool pmc_core_is_pson_residency_enabled(struct pmc_dev *pmcdev)
>  	return val == 1;
>  }
>  
> -/*
> - * Enable or disable ACPI PM Timer
> - *
> - * This function is intended to be a callback for ACPI PM suspend/resume event.
> - * The ACPI PM Timer is enabled on resume only if it was enabled during suspend.
> - */
> -static void pmc_core_acpi_pm_timer_suspend_resume(void *data, bool suspend)
> -{
> -	struct pmc_dev *pmcdev = data;
> -	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
> -	const struct pmc_reg_map *map = pmc->map;
> -	bool enabled;
> -	u32 reg;
> -
> -	if (!map->acpi_pm_tmr_ctl_offset)
> -		return;
> -
> -	guard(mutex)(&pmcdev->lock);
> -
> -	if (!suspend && !pmcdev->enable_acpi_pm_timer_on_resume)
> -		return;
> -
> -	reg = pmc_core_reg_read(pmc, map->acpi_pm_tmr_ctl_offset);
> -	enabled = !(reg & map->acpi_pm_tmr_disable_bit);
> -	if (suspend)
> -		reg |= map->acpi_pm_tmr_disable_bit;
> -	else
> -		reg &= ~map->acpi_pm_tmr_disable_bit;
> -	pmc_core_reg_write(pmc, map->acpi_pm_tmr_ctl_offset, reg);
> -
> -	pmcdev->enable_acpi_pm_timer_on_resume = suspend && enabled;
> -}
> -
>  static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
>  {
>  	debugfs_remove_recursive(pmcdev->dbgfs_dir);
> @@ -1486,7 +1452,6 @@ static int pmc_core_probe(struct platform_device *pdev)
>  	struct pmc_dev *pmcdev;
>  	const struct x86_cpu_id *cpu_id;
>  	int (*core_init)(struct pmc_dev *pmcdev);
> -	const struct pmc_reg_map *map;
>  	struct pmc *primary_pmc;
>  	int ret;
>  
> @@ -1545,11 +1510,6 @@ static int pmc_core_probe(struct platform_device *pdev)
>  	pm_report_max_hw_sleep(FIELD_MAX(SLP_S0_RES_COUNTER_MASK) *
>  			       pmc_core_adjust_slp_s0_step(primary_pmc, 1));
>  
> -	map = primary_pmc->map;
> -	if (map->acpi_pm_tmr_ctl_offset)
> -		acpi_pmtmr_register_suspend_resume_callback(pmc_core_acpi_pm_timer_suspend_resume,
> -							 pmcdev);
> -
>  	device_initialized = true;
>  	dev_info(&pdev->dev, " initialized\n");
>  
> @@ -1559,12 +1519,6 @@ static int pmc_core_probe(struct platform_device *pdev)
>  static void pmc_core_remove(struct platform_device *pdev)
>  {
>  	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
> -	const struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
> -	const struct pmc_reg_map *map = pmc->map;
> -
> -	if (map->acpi_pm_tmr_ctl_offset)
> -		acpi_pmtmr_unregister_suspend_resume_callback();
> -
>  	pmc_core_dbgfs_unregister(pmcdev);
>  	pmc_core_clean_structure(pdev);
>  }
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index 75fd593a7b0f..b9d3291d0bf2 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -68,8 +68,6 @@ struct telem_endpoint;
>  #define SPT_PMC_LTR_SCC				0x3A0
>  #define SPT_PMC_LTR_ISH				0x3A4
>  
> -#define SPT_PMC_ACPI_PM_TMR_CTL_OFFSET		0x18FC
> -
>  /* Sunrise Point: PGD PFET Enable Ack Status Registers */
>  enum ppfear_regs {
>  	SPT_PMC_XRAM_PPFEAR0A = 0x590,
> @@ -150,8 +148,6 @@ enum ppfear_regs {
>  #define SPT_PMC_VRIC1_SLPS0LVEN			BIT(13)
>  #define SPT_PMC_VRIC1_XTALSDQDIS		BIT(22)
>  
> -#define SPT_PMC_BIT_ACPI_PM_TMR_DISABLE		BIT(1)
> -
>  /* Cannonlake Power Management Controller register offsets */
>  #define CNP_PMC_SLPS0_DBG_OFFSET		0x10B4
>  #define CNP_PMC_PM_CFG_OFFSET			0x1818
> @@ -355,8 +351,6 @@ struct pmc_reg_map {
>  	const u8  *lpm_reg_index;
>  	const u32 pson_residency_offset;
>  	const u32 pson_residency_counter_step;
> -	const u32 acpi_pm_tmr_ctl_offset;
> -	const u32 acpi_pm_tmr_disable_bit;
>  };
>  
>  /**
> @@ -432,8 +426,6 @@ struct pmc_dev {
>  	u32 die_c6_offset;
>  	struct telem_endpoint *punit_ep;
>  	struct pmc_info *regmap_list;
> -
> -	bool enable_acpi_pm_timer_on_resume;
>  };
>  
>  enum pmc_index {
> diff --git a/drivers/platform/x86/intel/pmc/icl.c b/drivers/platform/x86/intel/pmc/icl.c
> index cbbd44054468..71b0fd6cb7d8 100644
> --- a/drivers/platform/x86/intel/pmc/icl.c
> +++ b/drivers/platform/x86/intel/pmc/icl.c
> @@ -46,8 +46,6 @@ const struct pmc_reg_map icl_reg_map = {
>  	.ppfear_buckets = ICL_PPFEAR_NUM_ENTRIES,
>  	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
>  	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
> -	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> -	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
>  	.ltr_ignore_max = ICL_NUM_IP_IGN_ALLOWED,
>  	.etr3_offset = ETR3_OFFSET,
>  };
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
> index 91f2fa728f5c..c7d15d864039 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -462,8 +462,6 @@ const struct pmc_reg_map mtl_socm_reg_map = {
>  	.ppfear_buckets = MTL_SOCM_PPFEAR_NUM_ENTRIES,
>  	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
>  	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
> -	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> -	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
>  	.lpm_num_maps = ADL_LPM_NUM_MAPS,
>  	.ltr_ignore_max = MTL_SOCM_NUM_IP_IGN_ALLOWED,
>  	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
> diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/intel/pmc/spt.c
> index 2cd2b3c68e46..ab993a69e33e 100644
> --- a/drivers/platform/x86/intel/pmc/spt.c
> +++ b/drivers/platform/x86/intel/pmc/spt.c
> @@ -130,8 +130,6 @@ const struct pmc_reg_map spt_reg_map = {
>  	.ppfear_buckets = SPT_PPFEAR_NUM_ENTRIES,
>  	.pm_cfg_offset = SPT_PMC_PM_CFG_OFFSET,
>  	.pm_read_disable_bit = SPT_PMC_READ_DISABLE_BIT,
> -	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> -	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
>  	.ltr_ignore_max = SPT_NUM_IP_IGN_ALLOWED,
>  	.pm_vric1_offset = SPT_PMC_VRIC1_OFFSET,
>  };
> diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
> index 371b4e30f142..e0580de18077 100644
> --- a/drivers/platform/x86/intel/pmc/tgl.c
> +++ b/drivers/platform/x86/intel/pmc/tgl.c
> @@ -197,8 +197,6 @@ const struct pmc_reg_map tgl_reg_map = {
>  	.ppfear_buckets = ICL_PPFEAR_NUM_ENTRIES,
>  	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
>  	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
> -	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> -	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
>  	.ltr_ignore_max = TGL_NUM_IP_IGN_ALLOWED,
>  	.lpm_num_maps = TGL_LPM_NUM_MAPS,
>  	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,


