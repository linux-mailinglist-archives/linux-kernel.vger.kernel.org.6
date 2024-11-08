Return-Path: <linux-kernel+bounces-401828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C06B9C1FCE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27E4D1C211E5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AD71F4FA1;
	Fri,  8 Nov 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCBZUrCf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720331F5833
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731077882; cv=none; b=BN3MZYY1xv3OK91NhUnH7r6Ggs+tN4mRqD8WD4SrpfLvxlM39EIiE+AaVPS1ODdo/8970TPUc53Vht3MJbZ8gFqb2i7//I3jIDhQshoIrZR/MbBJ37PqWR2rrZqCDV0dtF+KvSx4iqiKk9F7sN6JtmdXrIpIM6OpNUwAe5O78Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731077882; c=relaxed/simple;
	bh=dgsccprguIeSmF5hmwv+xiy3hnds5QZ1BPKAJQngRwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1rIysaq8YoxMcOQCoEacAKdg/QshLhgBclQalH3b6sjAIpn4u0/q9jZBvd6urNGucy0o5ix5jAIv2KQrQqEnyrXR2zWsOUKwnq4uNIU/l+nJrtGsK0WjMqb35+5HAcqsdJGGWOJGCsx5Tm44xQerj7wUhCWoACRUzZs8K7z1RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCBZUrCf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731077878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eES8xxr1yI/38pTpRKNgpuyAW4X2vEoW+igVHSYhfkc=;
	b=TCBZUrCfsh7WlHOi15SbAGFgMOHC8wHqFAMpnYS3TeoeZE0mkK6GQXv0vb9HjjoPx6E6sm
	TAj9NFPamFfGUsyyJJzcJPsYe28ivn9S8Bn00doUDwOXHfIR6Vw3/t3x+UF1DM/d/rbDk8
	oyRXo1b0Wg9tjxZNuqwMgi3lUVj2OV0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-Ntf0UOq8Mv-00cvnR_ia8Q-1; Fri, 08 Nov 2024 09:57:56 -0500
X-MC-Unique: Ntf0UOq8Mv-00cvnR_ia8Q-1
X-Mimecast-MFC-AGG-ID: Ntf0UOq8Mv-00cvnR_ia8Q
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5cbad9b3ca2so1628794a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 06:57:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731077876; x=1731682676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eES8xxr1yI/38pTpRKNgpuyAW4X2vEoW+igVHSYhfkc=;
        b=G7KQPjvfcW6CCPhXIDRajSN+qKwbE3KXolMj3EilCGHAtsnmrIpoHrSk8EvTzJDTm0
         sFi5AKPjx677EadsjcAuI8q6aGsehiq5/4Vn4aPs3yVpX2ErOatxei9zL2zlUnHGH30k
         Ykvg0ujRwyorhhJKexDyMmHC3ELkoN4PHkuPz0D2qEZxlGbagBMBauUXs9K/wLTIMc7s
         MtsmB+j3MmwidiU32+yXIsschFPP0rNIQ6PJIFKiI6ScDkpEh4z+iKKWsKUADLgX5xXe
         XSciCgziEPJjB8Va/OD28mp+7QxYYbaJ5Mdndok77g7D5FZm/rHh1nzAggCiuARjCis6
         EHjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCGBVlBGxmjHtmzdMEt6UHJi/80XfPQqRzQtqtJhNtPk55A717jiDdV8BHl8nWsj3jyak1DDYoWlCN68Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwStgCiJGmHDgcTSQiFI+Adc0PIytDwvAlJiRIlzgb7gZJ5Jdmm
	TraDY43fmfC8nOZ9IxnW0ZYv5Dt3YF+Js532RQZORBUGLA2ks5WwjvaJJoEwsFqU7y+e2BO234o
	+P8SUiPO32MZE34dH+ZON1o04eY3GOZPWzqtma1vmN4kkLRcG+k7LzMbFwuHvGw==
X-Received: by 2002:a17:907:9411:b0:a99:f466:a87a with SMTP id a640c23a62f3a-a9eefebd146mr297452266b.3.1731077875690;
        Fri, 08 Nov 2024 06:57:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvBXQhtDwH/CFids4IrbUXtGYo9kv3TMx3xBV08edr1Zk34ClzQTNqBs25yREVsRQhm496Xw==
X-Received: by 2002:a17:907:9411:b0:a99:f466:a87a with SMTP id a640c23a62f3a-a9eefebd146mr297450566b.3.1731077875280;
        Fri, 08 Nov 2024 06:57:55 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a176cbsm246637766b.23.2024.11.08.06.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 06:57:54 -0800 (PST)
Message-ID: <51e77fdd-7d37-4748-a416-2f204a707f95@redhat.com>
Date: Fri, 8 Nov 2024 15:57:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] media: ov7251: Remap "reset" to "enable" for
 OV7251
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20241108145024.1490536-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241108145024.1490536-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8-Nov-24 3:50 PM, Andy Shevchenko wrote:
> The driver of OmniVision OV7251 expects "enable" pin instead of "reset".
> Remap "reset" to "enable" and update polarity.
> 
> In particular, the Linux kernel can't load the camera sensor
> driver on Microsoft Surface Book without this change:
> 
>  ov7251 i2c-INT347E:00: supply vdddo not found, using dummy regulator
>  ov7251 i2c-INT347E:00: supply vddd not found, using dummy regulator
>  ov7251 i2c-INT347E:00: supply vdda not found, using dummy regulator
>  ov7251 i2c-INT347E:00: cannot get enable gpio
>  ov7251 i2c-INT347E:00: probe with driver ov7251 failed with error -2
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/media/i2c/ov7251.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/media/i2c/ov7251.c b/drivers/media/i2c/ov7251.c
> index 30f61e04ecaf..7b35add1e0ed 100644
> --- a/drivers/media/i2c/ov7251.c
> +++ b/drivers/media/i2c/ov7251.c
> @@ -1696,7 +1696,21 @@ static int ov7251_probe(struct i2c_client *client)
>  		return PTR_ERR(ov7251->analog_regulator);
>  	}
>  
> +	/*
> +	 * The device-tree bindings call this pin "enable", but the
> +	 * datasheet describes the pin as "reset (active low with internal
> +	 * pull down resistor)". The ACPI tables describing this sensor
> +	 * on, e.g., the Microsoft Surface Book use the ACPI equivalent of
> +	 * "reset" as pin name, which ACPI glue code then maps to "reset".
> +	 * Check for a "reset" pin if there is no "enable" pin.
> +	 */
>  	ov7251->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
> +	if (IS_ERR(ov7251->enable_gpio) &&
> +	    PTR_ERR(ov7251->enable_gpio) != -EPROBE_DEFER) {
> +		ov7251->enable_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +		if (!IS_ERR(ov7251->enable_gpio))
> +			gpiod_toggle_active_low(ov7251->enable_gpio);
> +	}
>  	if (IS_ERR(ov7251->enable_gpio)) {
>  		dev_err(dev, "cannot get enable gpio\n");
>  		return PTR_ERR(ov7251->enable_gpio);


