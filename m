Return-Path: <linux-kernel+bounces-351858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB2F9916F5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 15:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13052835DE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 13:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F358B1534EC;
	Sat,  5 Oct 2024 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYLI82jO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BBE149DE8
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728134170; cv=none; b=kRWeOJihMAqehDGFyjALxMhbfOv9KKiSUVjI3it+kMl3uWFt2lczI7TeTpr7fZiuZU6yaJOyoXsP+dEwVsAnacZB9aXHVRsbNMHQIuSQkaep7YXAAzvdcJdtFxmy0JGxmkcPuNIo2x6urg2W5QqpLpWkLPKSGnga1VzqV52J5BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728134170; c=relaxed/simple;
	bh=SnCouw/0CAfr+j4atpTs6tFU262mQXs1o9AF4aVWNIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stzfSwLGf7OojWkjWZOC8vZlGSMVNsmuZEUzSyG7AC/6iRMWN8voiEwneZcqVvXJ5d5NC9gY/U1YvO1g/2aPxxrRGPuNRIAocSMpd28ct+UgYS6NnrVmqc7eLNJxJgBp7YfYuTbfdgoXhpS1yOhXUaz1NnGtex9btLRaAsBLP2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dYLI82jO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728134167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NtXWlJU5HafQ0O79u3ZV8qo7ew1Goc3SkHZ1tqX1xb0=;
	b=dYLI82jOQcziQ/YISSuliT2GbcFo1AgKOYlb/yJhS02vlJs6pcfvRt80FOcYZOFO+12UN+
	9REQECMmFnOrz6ccWoG32sAGNDK1/78nxOT9EDetoCVoLny1Ti4my07ylRWSdjKjjiO+h1
	2jrhapT7zE/yMe1oxkhE4UnA/HxEEcY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-ak3AJldpNdmbOsYwI-XhuA-1; Sat, 05 Oct 2024 09:16:05 -0400
X-MC-Unique: ak3AJldpNdmbOsYwI-XhuA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb940cd67so30892125e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 06:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728134165; x=1728738965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NtXWlJU5HafQ0O79u3ZV8qo7ew1Goc3SkHZ1tqX1xb0=;
        b=PHgv0tKK1clBY5PLAdjDXi7Du0AGKvSaQLop17K22BqSK6idYqDGSZ9fuECk2UHELk
         IkIEZNz2IBQooVOvUQKTS9cgyYtGCjw4FNZeVpVX/5qlHBBk3u1Q+kVc+HUdUwNDJXpR
         uOAeZ0fpe6o08ww+82KD1Vo9PM1faMNH9kfrh4dvggQStpG64C86EU7QXNmHgJrgi+Gx
         z470cfZB4rgqVFsMsvrR/kwIRnQcodmMdxGglbBlI9benf6uJCSPzjHkSonR5bj/FcW4
         +0DLcA8CcVvyz/f0kNhE1Odc2494yMH1LRCo8MvbwMdTg3qjY42A/dN7pe83o+JkVYAD
         LTmw==
X-Forwarded-Encrypted: i=1; AJvYcCXm5X5Phi3Jiesl80MKMKiSm/KhmTpHMYrNzEvLMFZBNAAU9rOZmsDaYeWduNpvbaGlL5eBSDn7FywHTZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvOmEiMVH2cleipQHfbv8B0xFzUnZOMWwVnl18a0UYChjh5MCf
	nS5r12BfUs/fwT1GN/+0Dgcoru5yKPAyZInbu36OrJ76GRkAsAmv+M+3RXUHyBjWnOgp7u1F1KE
	ihn62AnlMs60+XwrADG5MpyVh2f2PmxMtRGJhApp/QMgIbMGfiA+gmF+CYunpXw==
X-Received: by 2002:a05:6000:400d:b0:37c:cea2:826f with SMTP id ffacd0b85a97d-37d0e6ea949mr6837618f8f.2.1728134164627;
        Sat, 05 Oct 2024 06:16:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHIVFOTI5XI6jlg/ZTrlk/dkgYkJ/jdRmq2oxhmffIjVYZZkCgnpltydn6NVaGkYR5Aejtig==
X-Received: by 2002:a05:6000:400d:b0:37c:cea2:826f with SMTP id ffacd0b85a97d-37d0e6ea949mr6837593f8f.2.1728134164290;
        Sat, 05 Oct 2024 06:16:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e784666sm131559566b.100.2024.10.05.06.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 06:16:03 -0700 (PDT)
Message-ID: <a2170a4a-d994-4729-9ade-aa20de4fefa1@redhat.com>
Date: Sat, 5 Oct 2024 15:16:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86:intel/pmc: fix IS_ENABLED() check
To: Lukas Bulwahn <lbulwahn@redhat.com>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 platform-driver-x86@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
References: <20240924084056.48447-1-lukas.bulwahn@redhat.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240924084056.48447-1-lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Lukas, thank you for your patch.

On 24-Sep-24 10:40 AM, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit d7a87891e2f5 ("platform/x86:intel/pmc: fix build regression with
> pmtimer turned off") accidentally slips in some CONFIG_CONFIG_X86_PM_TIMER
> (note the duplicated CONFIG prefix) in the IS_ENABLED() check.
> 
> Fortunately, ./scripts/checkkconfigsymbols.py notices this accident. Fix up
> the IS_ENABLED() check with the intended config name.
> 
> Fixes: d7a87891e2f5 ("platform/x86:intel/pmc: fix build regression with pmtimer turned off")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

I see that d7a87891e2f5 ("platform/x86:intel/pmc: fix build
regression with pmtimer turned off") does not exist in
Torvald's tree yet.

This comes from http://git.linaro.org/people/daniel.lezcano/linux.git/log/?h=timers/drivers/next

Daniel, I appreciate you picking this up, but now that everything
has been merged together again in v6.12-rc1 I would prefer to
handle any further changes limited to drivers/platform/x86/intel/
through the pdx86 tree.

Also since this is a build fix it really should be send as a fix
fro the 6.12 cycle.

Daniel judging by the timers/drivers/next branch name I guess these
are not fixes targeting 6.12, right ?

In that case can you please drop d7a87891e2f5 ("platform/x86:intel/pmc:
fix build regression with pmtimer turned off") ?  Then I'll pick that
up and squash in this typo fix.

Or if you do plan to send things out as fixes to Linus, then please
add this patch too.

Regards,

Hans





> ---
>  drivers/platform/x86/intel/pmc/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 0431a599ba26..4387b5103701 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1546,7 +1546,7 @@ static int pmc_core_probe(struct platform_device *pdev)
>  			       pmc_core_adjust_slp_s0_step(primary_pmc, 1));
>  
>  	map = primary_pmc->map;
> -	if (IS_ENABLED(CONFIG_CONFIG_X86_PM_TIMER) &&
> +	if (IS_ENABLED(CONFIG_X86_PM_TIMER) &&
>  	    map->acpi_pm_tmr_ctl_offset)
>  		acpi_pmtmr_register_suspend_resume_callback(pmc_core_acpi_pm_timer_suspend_resume,
>  							 pmcdev);
> @@ -1563,7 +1563,7 @@ static void pmc_core_remove(struct platform_device *pdev)
>  	const struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
>  	const struct pmc_reg_map *map = pmc->map;
>  
> -	if (IS_ENABLED(CONFIG_CONFIG_X86_PM_TIMER) &&
> +	if (IS_ENABLED(CONFIG_X86_PM_TIMER) &&
>  	    map->acpi_pm_tmr_ctl_offset)
>  		acpi_pmtmr_unregister_suspend_resume_callback();
>  


