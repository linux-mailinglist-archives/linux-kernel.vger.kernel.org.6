Return-Path: <linux-kernel+bounces-431257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C5B9E3B2C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BC9168DBC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2781BE86E;
	Wed,  4 Dec 2024 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxRZEABA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25FC1B3939
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318380; cv=none; b=t/4pSNmDJyaGMRNnFpsQpH3jgCmgJ7wmWyZ0i9TzwcYP/HUOW+mtgoN9TQA+mJ4c3eE0j9TXg0aEU2U4OZ7xSKvZQS4iSz0Zqjj11vzjEFfU+1NXVXJk+1WOl8JuU4zqlFtS1J9kM8cqHsSXmZEaE9iHYx1ApLd8s70kqx6KSZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318380; c=relaxed/simple;
	bh=X6VJksb3Co/8r+7HnSfYaiwXYyLcZSRTBftTOo7GcGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iak9qQgFdmQ8XBmk0NLrBKFg/Q/bv2281Hb9btqV5LyqASmqnFx38NlWlGn6fXHKYtB6Ur0sMgyXI5iTJkdnC+ahUW94t1bevhllSJIMSn3b41oe3bOVPtkbxBxuRRb2BvtqC8xidSo1l+AndNvulBMq0yga4/0SGH3QQmipTUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hxRZEABA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733318377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aflk7KcI1FKNdunouCjLBd6UrShNW8Pib6fl21i980U=;
	b=hxRZEABAPjS7pocvzoBxoajDym6u1zo0NTEh5SzE15KzhIMAhzxDmhyG+hmBHNy+utFpLI
	ZJ+kZEJtE+6D2Tzij0zYxdEmwN5wvprQ+RPg9Ah60zw2jnchBGod2QjUXL7+5RsAA1F/wX
	EFc75RHUATKLpc1XMjg2hv0BGSmCsaw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-37jYFo-PN9e0GWiffOyRig-1; Wed, 04 Dec 2024 08:19:36 -0500
X-MC-Unique: 37jYFo-PN9e0GWiffOyRig-1
X-Mimecast-MFC-AGG-ID: 37jYFo-PN9e0GWiffOyRig
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa53914509eso445264666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 05:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733318374; x=1733923174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aflk7KcI1FKNdunouCjLBd6UrShNW8Pib6fl21i980U=;
        b=BYwqUEGuRF3VNJANpJIVqR+tsBhdRI0AZwyDm19+7icBWrYfV795AqpLqgy5nt1QUR
         /XKUIlCSVtJWQ9MZUnYtMvU2ZgFn+48QnlAyI1NF5lR751m0AEI7mFoGUTA028U+4EnV
         BojNeY4JQBAirbRIKkWwp60NlfrS6RctJGuBimjVbzzwxxMFAUrplKBm8zeQDsLHDq6A
         vVc/2UYhQpcr8Ee728CrP9E7TLHGQAWranvmbpurQoOyy1thrSQcyGBFKuOsVLpBPmpO
         KLMpcLTbOuTbW+9oaDh1ePtF8G4/PYnnaR399nBr1A9Sge81Wm5JZV0hp3XmpblhusLu
         v3IA==
X-Forwarded-Encrypted: i=1; AJvYcCV86k2AYRua2KdDX0sx5IJiNlqh7JwQPIUir6vn7JhBeAgzeps3C1elMa3kcJJ0+rpondVBT6wfUirdxG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMeurxHSAl9ofNSDxuD2xycNisdD24alomk1s+/E7ncPUgKmKp
	KbreyohxdmAtkx7WT1LaCzqx0k2/dK+MTzkznJ1Drk6zd76IhfmH4bdy1Fc4R67rrXincNvpg4J
	0r6d3WCg9WHB43OkY0DZ/mKQQXtiq7Dk9MkHozzdmpvMgOGCqGhHZlf2QfrUq/yxA1S+mgw==
X-Gm-Gg: ASbGnctlAbJ/9U+1ND92ZDpJdg0/SmDRlmP8sN+Ch++I2xD9bsaDWL7hU0ipgPCEsOx
	V+JL9OMw6xHLd/CtAbNTQUL1a/EGCl/XHZ83e/526yO/DzTy+v9M8lOxp8+rxWnb05RKiKurhMa
	XQ+n6XFBIzH3NLeW8m9Kwc7ZDXkLfQYiscACAeEuMK2BnAGpwQpP1JhtVT5R5VlLvocM+3GboHM
	3s5oh0y0wIa9pS/xbTih1DaFFbiIhJfrvygxImUO1l7mEpo/vJEGE09sUSFq+rDuIGf9sp3Dta+
	43IE8/ewf5F8eJ7fqy7cusE4z063XnqZ73ipjbnenNFIeJ9xjgzSrqbMz9sdL+E5jN9LMbn/fPD
	bDQy41fkAhhYhqbItjLm4CfyA
X-Received: by 2002:a17:907:270f:b0:a9e:b5d0:e5c with SMTP id a640c23a62f3a-aa5f7f6f2f8mr447313466b.61.1733318374280;
        Wed, 04 Dec 2024 05:19:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPusTDYqJAvgkava+BJPuvnHbBuW29s5Y3nopYcUqtApT9uIE6YL2yxsD7aJVqucrPnAU0vA==
X-Received: by 2002:a17:907:270f:b0:a9e:b5d0:e5c with SMTP id a640c23a62f3a-aa5f7f6f2f8mr447311866b.61.1733318373906;
        Wed, 04 Dec 2024 05:19:33 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996c19d9sm737913566b.37.2024.12.04.05.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 05:19:33 -0800 (PST)
Message-ID: <87f9c6ae-e409-4ef5-a2ad-319cdebdf577@redhat.com>
Date: Wed, 4 Dec 2024 14:19:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: intel: int0002_vgpio: use gpiochip_get_data
To: Rosen Penev <rosenp@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20241203233505.184612-1-rosenp@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241203233505.184612-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Rosen,

Thank you for your patch.

On 4-Dec-24 12:35 AM, Rosen Penev wrote:
> Instead of using container_of, we can pass the pointer to
> gpiochip_add_data and use it.

Yes that is possible, but why? What is the advantage
of doing this?

Given that the struct gpio_chip is the first member
of struct int0002_data it is actually free as it
turns into a no-op.

Where as gpiochip_get_data() is a non inline helper,
so your replacing a no-op with a function call here
I don't see how this makes things better?

Regards,

Hans



> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>



> ---
>  drivers/platform/x86/intel/int0002_vgpio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/int0002_vgpio.c b/drivers/platform/x86/intel/int0002_vgpio.c
> index 0cc80603a8a9..7ce0774b3896 100644
> --- a/drivers/platform/x86/intel/int0002_vgpio.c
> +++ b/drivers/platform/x86/intel/int0002_vgpio.c
> @@ -102,7 +102,7 @@ static void int0002_irq_mask(struct irq_data *data)
>  static int int0002_irq_set_wake(struct irq_data *data, unsigned int on)
>  {
>  	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
> -	struct int0002_data *int0002 = container_of(chip, struct int0002_data, chip);
> +	struct int0002_data *int0002 = gpiochip_get_data(chip);
>  
>  	/*
>  	 * Applying of the wakeup flag to our parent IRQ is delayed till system
> @@ -211,7 +211,7 @@ static int int0002_probe(struct platform_device *pdev)
>  	girq->default_type = IRQ_TYPE_NONE;
>  	girq->handler = handle_edge_irq;
>  
> -	ret = devm_gpiochip_add_data(dev, chip, NULL);
> +	ret = devm_gpiochip_add_data(dev, chip, int0002);
>  	if (ret) {
>  		dev_err(dev, "Error adding gpio chip: %d\n", ret);
>  		return ret;


