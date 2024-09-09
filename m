Return-Path: <linux-kernel+bounces-321287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7DA97172C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278A5282570
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1111B5EA0;
	Mon,  9 Sep 2024 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tmdbun1a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B9C13B28D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881827; cv=none; b=lphSmbkCnYHhRrK2sb9tjrVYLX8dg78f2aljJo15PVNlfH/Ry3d0uGDZ88Q3PQCxZRcD/fcABaS8jJ2ZgBFb9n2il/zzA+seg4PtlOuLp1etSzDybmNO5tGFFB/2rk09lcBTdrMGXjC2f2syye5xFQCqNshnNHxZFn5HghvD1DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881827; c=relaxed/simple;
	bh=IURwqxE1BypkMuGeKI5mgAWiVHV1/ZFxFb9JlLfJGk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7dP9tUe4ByzveOJXAne2nUdHwzqbe9h0b0OEtWaURKQESUorOJjccLweAeCkIjqZcCkgI6rK9+EfBlP2nqjyFSBhBTy09LKhpsRq9jI5BQkrZORh8p0IOql4MyN55FpxRnvXZ6vlMmu44NZx0dE4Wp7KZIif95Th78ThWPC2YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tmdbun1a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725881825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUrDuwJzCiGMYllHyT64UIxu+Lz8F5k8yxB9wzXcv/U=;
	b=Tmdbun1azU/liVAATKfIAfCVM4yL6eDNKVXBB/VWaHCikbPbMfVhcgTW02W4Luxkq5U+a/
	TCjqkdyCXltCPUdSwy1n59gIiGpvywesieXuRY/VKeg0QIN1q4VTNjXU5ojkGhk21kpGgx
	F9mPOJDEZ2t1VahpGITTDVqH5vo1Nv8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-d0NWbxTDPmOAEitioZrA2Q-1; Mon, 09 Sep 2024 07:37:04 -0400
X-MC-Unique: d0NWbxTDPmOAEitioZrA2Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a868b6d6882so487035466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 04:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725881823; x=1726486623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xUrDuwJzCiGMYllHyT64UIxu+Lz8F5k8yxB9wzXcv/U=;
        b=im01//HjS3dbLr6fn5TofeaeBkjbq4/DTgHmz0N4xZ6Mt9eiS/FBzV/xpeXIi+8uiH
         nMpUuRUy4LhnEtr9RNjmeOApCYIzgQEOaEqddwJ+AQJhjI5/2WtjBbcvrhRJ6RWyke4l
         xoT0up6n1UzS12dNDZTxMhxJUvJ0zE/bboaT+njsIg3dPxh1B+Vs2vZBVl/vz1YKnOMW
         noYQweV9/dXEsq08io2+yx6q7QOsmcHi9aCJUwkpL7ZUKm5VLNBIpSzlVTxQKa2zSAyr
         7NMgaP2ug5yxcdckBHy7bQF6QSZqrzGrXEgrM7xzzyx8gk54ZGUka13jOp9Yk9lCYw1y
         Cfaw==
X-Forwarded-Encrypted: i=1; AJvYcCXV67eNLrgGi3hpSQXZKcx9pXRgxIn1h/7NExE73gOoSA4mJnGaZeLwvGaIAWkr9K0q0C1NYvg+JuUy5ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAKBIy3Mkayrm67Q8QRw+qN/yZPs5FoMUWd5JbzQ9VI8JN70Uz
	vF4vU9BRelbnA/T6yAaB0KLhQAfEQ6W07zcCvbIrdqljcxQcEgBxNAegUhjiLFD2SF3S7gixEb5
	/AFmO0oQ7YyhzOojBS7kSBNZfFBc7d0zeL+7fW72TjdAaSnjum0I1Sr37oXq0pA==
X-Received: by 2002:a17:907:7f22:b0:a8a:cc5a:7f30 with SMTP id a640c23a62f3a-a8acc5a8261mr1003261466b.25.1725881822956;
        Mon, 09 Sep 2024 04:37:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn8LIXFgJqQu8fsNhvtpzfYGm47GNNcRK44avfkvcEfA00i2ZIEtkJeKcbJTZ5RQtsoe4z9Q==
X-Received: by 2002:a17:907:7f22:b0:a8a:cc5a:7f30 with SMTP id a640c23a62f3a-a8acc5a8261mr1003259466b.25.1725881822441;
        Mon, 09 Sep 2024 04:37:02 -0700 (PDT)
Received: from [192.168.171.203] ([109.38.234.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d5dc74sm327094766b.208.2024.09.09.04.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 04:37:01 -0700 (PDT)
Message-ID: <43cd3e8e-4c99-4641-b55b-4b54a42b8e53@redhat.com>
Date: Mon, 9 Sep 2024 13:36:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86:intel/pmc: fix build regression with pmtimer
 turned off
To: Arnd Bergmann <arnd@kernel.org>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Xi Pardee <xi.pardee@linux.intel.com>,
 Rajvi Jingar <rajvi.jingar@linux.intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>, Kane Chen
 <kane.chen@intel.com>, Marek Maslanka <mmaslanka@google.com>,
 Tony Luck <tony.luck@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240909111644.248756-1-arnd@kernel.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240909111644.248756-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/9/24 1:16 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The acpi_pmtmr_{un,}register_suspend_resume_callback() declarations
> got added into an #ifdef section without an alternative inline
> stub, which now causes a build failure:
> 
> drivers/platform/x86/intel/pmc/core.c: In function 'pmc_core_probe':
> drivers/platform/x86/intel/pmc/core.c:1507:17: error: implicit declaration of function 'acpi_pmtmr_register_suspend_resume_callback' [-Wimplicit-function-declaration]
>  1507 |                 acpi_pmtmr_register_suspend_resume_callback(pmc_core_acpi_pm_timer_suspend_resume,
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/platform/x86/intel/pmc/core.c: In function 'pmc_core_remove':
> drivers/platform/x86/intel/pmc/core.c:1523:17: error: implicit declaration of function 'acpi_pmtmr_unregister_suspend_resume_callback' [-Wimplicit-function-declaration]
>  1523 |                 acpi_pmtmr_unregister_suspend_resume_callback();
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Remove the unnecessary #ifdef and use IS_ENABLED() checks in the
> respective callers.
> 
> Fixes: e774696b1f95 ("platform/x86:intel/pmc: Enable the ACPI PM Timer to be turned off when suspended")
> Fixes: fe323dcb12fd ("clocksource: acpi_pm: Add external callback for suspend/resume")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/platform/x86/intel/pmc/core.c |  6 ++++--
>  include/linux/acpi_pmtmr.h            | 13 +------------
>  2 files changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 695804ca8de4..bbe90b1f56e2 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1503,7 +1503,8 @@ static int pmc_core_probe(struct platform_device *pdev)
>  			       pmc_core_adjust_slp_s0_step(primary_pmc, 1));
>  
>  	map = primary_pmc->map;
> -	if (map->acpi_pm_tmr_ctl_offset)
> +	if (IS_ENABLED(CONFIG_CONFIG_X86_PM_TIMER) &&
> +	    map->acpi_pm_tmr_ctl_offset)
>  		acpi_pmtmr_register_suspend_resume_callback(pmc_core_acpi_pm_timer_suspend_resume,
>  							 pmcdev);
>  
> @@ -1519,7 +1520,8 @@ static void pmc_core_remove(struct platform_device *pdev)
>  	const struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
>  	const struct pmc_reg_map *map = pmc->map;
>  
> -	if (map->acpi_pm_tmr_ctl_offset)
> +	if (IS_ENABLED(CONFIG_CONFIG_X86_PM_TIMER) &&
> +	    map->acpi_pm_tmr_ctl_offset)
>  		acpi_pmtmr_unregister_suspend_resume_callback();
>  
>  	pmc_core_dbgfs_unregister(pmcdev);
> diff --git a/include/linux/acpi_pmtmr.h b/include/linux/acpi_pmtmr.h
> index 0ded9220d379..0846f90ce179 100644
> --- a/include/linux/acpi_pmtmr.h
> +++ b/include/linux/acpi_pmtmr.h
> @@ -13,14 +13,12 @@
>  /* Overrun value */
>  #define ACPI_PM_OVRRUN	(1<<24)
>  
> -#ifdef CONFIG_X86_PM_TIMER
> -
>  extern u32 acpi_pm_read_verified(void);
>  extern u32 pmtmr_ioport;
>  
>  static inline u32 acpi_pm_read_early(void)
>  {
> -	if (!pmtmr_ioport)
> +	if (!IS_ENABLED(CONFIG_X86_PM_TIMER) || !pmtmr_ioport)
>  		return 0;
>  	/* mask the output to 24 bits */
>  	return acpi_pm_read_verified() & ACPI_PM_MASK;
> @@ -39,14 +37,5 @@ void acpi_pmtmr_register_suspend_resume_callback(void (*cb)(void *data, bool sus
>   */
>  void acpi_pmtmr_unregister_suspend_resume_callback(void);
>  
> -#else
> -
> -static inline u32 acpi_pm_read_early(void)
> -{
> -	return 0;
> -}
> -
> -#endif
> -
>  #endif
>  


Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Daniel, can you pick this one up?

Regards,

Hans



