Return-Path: <linux-kernel+bounces-195403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 781928D4C42
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D631F218C0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6F3183065;
	Thu, 30 May 2024 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bs4nvmNv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FFB17FACF
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717074384; cv=none; b=CFkoXGFKEEHglBaDUeO7qF+DdVWlmRCAM1Zo+Rld774h/Keg/YBEJECqFA8sXOpT2/iEb1PH+kG8A9Rc5EtQzSe4BjCNsBLGP6OG4w7qxuhoStBaj9QxumH00T8Zbu0mc9ha8R4tDTsoXXlTWhMgtTxZOT0lMv1x/SjAzYTlQe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717074384; c=relaxed/simple;
	bh=9ClmaagelsVL0EN9hfbNdsOe4rCK0jF6VJvnl24H9iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=beOrJAlxp6LKlrEI4ANZI2PmG6rbrYTZ2O+3lzagvL/ezWUE15pMqriBCIzypSM0kW56diUck9YjQmDHzd/AeHCrYFa0iuW/X3Kcly9lv/cGV+/ftIhS0/7NZPf04kz6HvBbRqyEyo3iosSaQPJvlizHvfSVpLKuxL2LG/kFMvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bs4nvmNv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717074382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvA0ryzzUt3roYMRqzP5tcnOVKXZ+dglyNSsf/+sPrc=;
	b=Bs4nvmNvxB1oG2AnvigdRHHBgr4ktDs3f14WgHdQeTn4Y7QjsK5QAmtE7yX/VhcXa+NjxS
	NXYlYrOnapuFRUsuu6r5bESIMzsBCRhRfQ8q7B9iLOPecszpWG228rW+k1gfSyAdgS5CDE
	ujDIyN5DkxcRj52ko5VuAGZyxOy4q8M=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-7BNzUJs5OoWjOvYo-WkqMg-1; Thu, 30 May 2024 09:06:20 -0400
X-MC-Unique: 7BNzUJs5OoWjOvYo-WkqMg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6ad75327e0cso7936466d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 06:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717074380; x=1717679180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvA0ryzzUt3roYMRqzP5tcnOVKXZ+dglyNSsf/+sPrc=;
        b=id2iPOhBaU84RaEixKcIWIlHvRQ0Rn++J8+6rQIW4sXewHhnnEqvcSV/jw/OKdASv1
         fPoGYtITx2+jSDMgXCcGUjBYRY93yqQuKxYJe/gx1EJERq8A7Q2+Y6IZKTXy+gRPpqvT
         E9DYTZOe9Wf4j8ehciFvGt7YwC6lbarJpW1WjlqJnAqs3dp++AYucAnSae43czU1Ygrs
         yMfn9AkhxI1LSSDvK0XUX4KTMm0M4Y/8hqm/j+6z2P6wuw6As/SvZhSOtQKIcCa29Qw9
         GADl62PExWa1XQhX11gTC8kZSaSVIYktIG/VO1Efq2c1LPLjqlEgRnjJec+61z0RDS20
         wvHg==
X-Forwarded-Encrypted: i=1; AJvYcCUVH0zihzPfEM2HhDzprjHzQ3NMPSmAQaN4VvT4F+App6igca+InU5as/VGvGBlUVhcEAZ5bJWDxqSX2c6xPkwAGmD0CTuEbeFtbtKm
X-Gm-Message-State: AOJu0YzHUWa673fQqyaunKU52L+dyWUPX3m4jIgg2gEHqqFeIrAssUje
	o7Od2h+SydgfYr3lq3jo4q6djT0wYP+7YUR5axueJOOYJduV7wDrvF5PQLqPKadDWY2RfRj576+
	u9/Dtx565gn5Crksxn8tr3plY18mXz4xUMxCGbjG7FIId3i2lysrKS1iVHCngsw==
X-Received: by 2002:a05:6214:328e:b0:6ae:aa5:7f6b with SMTP id 6a1803df08f44-6ae0cb37645mr22842556d6.34.1717074379965;
        Thu, 30 May 2024 06:06:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgjLeINZAgLWz2gTTl6s/+ViKd4/Ddlih3N/x2boBgxfykUZQvC57xL0+8+w6vA4N0jLzi3w==
X-Received: by 2002:a05:6214:328e:b0:6ae:aa5:7f6b with SMTP id 6a1803df08f44-6ae0cb37645mr22842176d6.34.1717074379443;
        Thu, 30 May 2024 06:06:19 -0700 (PDT)
Received: from [10.26.1.93] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac16308238sm63418416d6.119.2024.05.30.06.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 06:06:18 -0700 (PDT)
Message-ID: <cb4c5fd0-9629-4362-918a-cb044eb9e558@redhat.com>
Date: Thu, 30 May 2024 09:06:17 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: Do not enable ACPI SPCR console by default on arm64
To: Liu Wei <liuwei09@cestc.cn>, catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 liuwei09.cestc.cn@cecloud.com
References: <20240530015332.7305-1-liuwei09@cestc.cn>
Content-Language: en-US
From: Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <20240530015332.7305-1-liuwei09@cestc.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/24 21:53, Liu Wei wrote:
> Consistency with x86 and loongarch, don't enable ACPI SPCR console
> by default on arm64
> 
> Signed-off-by: Liu Wei <liuwei09@cestc.cn>
> ---
>   arch/arm64/kernel/acpi.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index dba8fcec7f33..1deda3e5a0d2 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -227,7 +227,8 @@ void __init acpi_boot_table_init(void)
>   		if (earlycon_acpi_spcr_enable)
>   			early_init_dt_scan_chosen_stdout();
>   	} else {
> -		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
> +		/* Do not enable ACPI SPCR console by default */
> +		acpi_parse_spcr(earlycon_acpi_spcr_enable, false);
>   		if (IS_ENABLED(CONFIG_ACPI_BGRT))
>   			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
>   	}

It's been a while, and the status of arm hardware may have changed. 
IIRC the choice to force enable this is that most arm hardware is 
headless and this was a _required_ option for booting.

I'm not sure if that's still the case as it's been a long time.

Can anyone from the ARM community provide an approval here?

P.


