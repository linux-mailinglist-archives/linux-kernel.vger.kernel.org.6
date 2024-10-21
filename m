Return-Path: <linux-kernel+bounces-374552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7370F9A6BE4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64D44B232A3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84BB17BA5;
	Mon, 21 Oct 2024 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCYHqI4d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798AE1F4731
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520114; cv=none; b=Bg067v8bwYz05jHhhqA3GBxwSKtpPzH4+oKMyi7R9ptHmrtzHLe7vF1VH1ovPVKkoapRPwiSqX+lB+5Epl44YW9b46YDBlJmInAcmzUu0YZm5HBLA5pl41rjVl6gdbNT2ohUqToTDCQeKORviNPG3jx+Z+Sgmz353zFCEV8ixOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520114; c=relaxed/simple;
	bh=dah3JuK6Qj6IQal1Ny+jb8WrCPXjvhvSomfNkrDZ96s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jE4q40OZ8ezK1KKK2ty2xC+An+IbJqcdkS0Tadxx8oj+YDO9AzxmTnMuZ6vFs9QBZs7chgqQi7P5/XYSHm5sAXEJV2eIkOpjmJPCT4KD13PoA9Dyjd0DAhLAviWz6k/NBN4wcqho/0YplzTF8NDoE9f8307yh26tg74fzl3KNH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCYHqI4d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729520110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8PfOG8qztLmjgi5lvFTsWGzlDXgKb6KxReuT7wFO8Gg=;
	b=hCYHqI4dYjXoehHoGEO+qWRuf/9/xTeiqO+leIti/H28zpw433goRAc5AEQWIWceA61aue
	KXwqhmRJ1r2CnGymBhkdKqWdkEfKTiNgUCNhMr7H2NMI6WiN1j//cKAiU2hWrwxf058PMr
	ck5L4BF36qOMVlhZ/NrjjRM8ujNAwMQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-3oi57NKyOTSxU_xMWZwE7A-1; Mon, 21 Oct 2024 10:15:09 -0400
X-MC-Unique: 3oi57NKyOTSxU_xMWZwE7A-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c95ec24f1bso1258634a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729520108; x=1730124908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8PfOG8qztLmjgi5lvFTsWGzlDXgKb6KxReuT7wFO8Gg=;
        b=fOOvGnry7bNJ1yAUGtAlz1QMvrq5wqcl00g6sCT5X7SoVPqpA4hGvqEukKpBEWe7CB
         41K35qyw7uy8WEmj9vfJsZ5xzdYHvia25cWcGHA8H6oVWhAy65/XjMjyPyQ3GdExvROW
         InA+RmfP0LiUNU8EDLstBBBGK658sBUhdgt6cODg2fE9QYLlwUQRusbk0RRLvbjSv0sz
         mDAld+Gd4js7sAA6KfcuZUfBoSPjqi0V+DbIOIV9hu6R2Wrh65HwHgZ+iDNkjafw51vb
         yuFR8/l5K6x5KmUXEa6QSGg9FHdU+O38NwJLJZtjlQobeQvLFyBAICktVCdzr6Wq++H8
         LYOw==
X-Forwarded-Encrypted: i=1; AJvYcCVSqbhuSIzovhFE7fI5CycN7XP34FcFLCeLqeQKsY/H7FFTtYm8WYrpliT7t/RaVjBRQCwFu4H8qAx9dNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvBCzDHr4JcIvnV7uHbbNmDKtW2tOJ8K0yZrnUDd+g1jbyyCgF
	JRsFGiKTftnpU5T4MuvV/fzRObQ/cAvJAY5pzLIUNU6SLglFpvjWbRxJtkLRR5mUinT33SCkFA/
	Lfo1IR5SZdPsy8qJQR1DWPmB92azyjQ3F6RtTTyZL/AUdvSBepRw4blFkl4lbSw==
X-Received: by 2002:a05:6402:34d2:b0:5c9:34b4:69a8 with SMTP id 4fb4d7f45d1cf-5ca0ac43878mr13644516a12.6.1729520107973;
        Mon, 21 Oct 2024 07:15:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpHf1ZB3J/KEvQafvB1tnTT7FwOJUSP1MV6sNMAiA03xnWJxYSnp9+2nbFOJpBxlvs1EdTqw==
X-Received: by 2002:a05:6402:34d2:b0:5c9:34b4:69a8 with SMTP id 4fb4d7f45d1cf-5ca0ac43878mr13644472a12.6.1729520107505;
        Mon, 21 Oct 2024 07:15:07 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b1adsm1981914a12.69.2024.10.21.07.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 07:15:07 -0700 (PDT)
Message-ID: <c75fbe0f-f4b6-4003-8dea-2c9ddbab0f1a@redhat.com>
Date: Mon, 21 Oct 2024 16:15:06 +0200
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
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240924084056.48447-1-lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

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

Note the code this modified is being reverted in the pdx86/fixes branch now, see:

https://patchwork.kernel.org/project/platform-driver-x86/patch/20241012182656.2107178-1-mmaslanka@google.com/

which I have just applied to my review-hans branch and will be in my next pdx86 fixes
PR to Linus.

Daniel, this means that once the next pdx86 fixes PR is merged there will be a conflict
with commit d7a87891e2f5 ("platform/x86:intel/pmc: fix build regression with
pmtimer turned off") from timers/drivers/next. The correct conflict resolution is
to just drop the changes since the code which this patches is removed by the revert.

Since this will now no longer apply I'm dropping this from the pdx86 patch queue.

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


