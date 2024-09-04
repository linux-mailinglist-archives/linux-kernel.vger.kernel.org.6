Return-Path: <linux-kernel+bounces-315876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B866196C808
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08330B239C8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FC01E764F;
	Wed,  4 Sep 2024 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hF20nqou"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D8D146D53
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479799; cv=none; b=mGsWmM0M3QyWMV6SJQAGtn0rWkLfO9LiIvT1uylv5tB1+/lmB50LLFGARe15QOiGWRdx+6tr9+BhkeV+ZnvJ01zf7qa0w+f62rSGdCf+VIj5jBR02XZ8nZgWJCnuTmeU8jsvwdd8U3g3BCrZSPP5YUFGLhFSNx7FceJFEFeK1I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479799; c=relaxed/simple;
	bh=zYOLZTFPvvYSOSc2fv3IguP/FYXkl249MfKJPWCA7kA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CAL7v8AosculfMFwreYhFXUkUbkCs7viUQIRnETKADe0DDlq3vW0b6D7WQPV54YFnG1iMctbWFVwNZHSSAykm+rWb9oPoC88qQXCGNccXn1330f8bL09ppgmBLh/+jtWJ4wRHkI4SdwtbLdCgezSrjvDDgJO2Tu56b/gCY9Lt1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hF20nqou; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725479795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EyMgDp0oQpk8xs0d2Wu+7QfF1fZAU5as65r2vHepi88=;
	b=hF20nqoulFzmpwYhj6YGl7nlgZlnjy88LrSVh5EF5ICjedKRoK5bUbYAL7FYSo6HCtJASy
	isNeS+vDMNoQqBCyKRYD70J5sEkr8YWd8c1GlWKVzFAbI2D45J5rLNbAsRi81R8AIAge0J
	8dWmCdbCMkRIZJHGTK16cD9Tc6h7TYE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-geMAvFv_Pouv8cg0mTONbw-1; Wed, 04 Sep 2024 15:56:33 -0400
X-MC-Unique: geMAvFv_Pouv8cg0mTONbw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c251bcb728so3144317a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 12:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725479792; x=1726084592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EyMgDp0oQpk8xs0d2Wu+7QfF1fZAU5as65r2vHepi88=;
        b=SzqcL1dIJrfQBmjGvm7koJwUw75lJkx8jpxX60n6OTr9x5viq1gJpuj4md5CCF6QW+
         /0gle/ZQbo/pc6em15/h16jy8UtQ+xnetejYsbiU5vA+TXKYHQ3dJjxbfhEmqebTXgYL
         Dii7RFk03+qYz8Q+C/9jM0yB+8n6Nx2XZC1mddezAvCGJEgh6ZZoQOkcw2To+hCMdB0c
         /lxF2iKSjBF31jMVxZQLh68SVfMSrbw43UTdAQiSoaosva57Zsg6iwKSEaTdOV86FHqK
         dBI29ZCnHWcSDYnuagpO89ddL9SG0t+Tl6EJ5LxBARyqPJPSzyFWrTa75wSR2rkFchUi
         JeWg==
X-Forwarded-Encrypted: i=1; AJvYcCV4OwDbv616rgIeu03T3VhlmVQfWP8vLqpbByrm6jjF9pqBsI5MG/M7oSWgGXpAnP0ofzfMrgjgHmQ+LZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ7PrT2+AdvH01u4wpCjDwRnATsJGgUQDVoGaO8XW8BECWAX2P
	zYH6QQd7rslUA/IDbS7VR4rr+GJYxVif+27f3ueGxQUSXnIR1+VoP7A36qH5czqTRwhrSrvWksj
	RFyoz7jmFyJyPCl3+jkdQzAUnF5lS9/VqCp5yQ86eKFo113gw1ZPwZVLj+zORlQ==
X-Received: by 2002:a17:907:7d94:b0:a8a:445f:ac4d with SMTP id a640c23a62f3a-a8a445faeefmr194777766b.18.1725479792492;
        Wed, 04 Sep 2024 12:56:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUYaXXQh+1CG8qYzIjIH9BH0plEBZg36QtqdYDfY9l1zWcwlr4QsXieG1LGJdh51ODPYq/jw==
X-Received: by 2002:a17:907:7d94:b0:a8a:445f:ac4d with SMTP id a640c23a62f3a-a8a445faeefmr194775666b.18.1725479791991;
        Wed, 04 Sep 2024 12:56:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a62037380sm31371666b.47.2024.09.04.12.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 12:56:31 -0700 (PDT)
Message-ID: <23d4b0c9-d344-49fe-a10c-e63f1f6fd83f@redhat.com>
Date: Wed, 4 Sep 2024 21:56:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 1/9] power: supply: core: rename psy_has_property()
 to psy_desc_has_property()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
 <20240904-power-supply-extensions-v3-1-62efeb93f8ec@weissschuh.net>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240904-power-supply-extensions-v3-1-62efeb93f8ec@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 9/4/24 9:25 PM, Thomas Weißschuh wrote:
> The function only takes a desc as parameter, align the naming.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/power/supply/power_supply_core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 8f6025acd10a..cff68c4fd63c 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1183,8 +1183,8 @@ bool power_supply_battery_bti_in_range(struct power_supply_battery_info *info,
>  }
>  EXPORT_SYMBOL_GPL(power_supply_battery_bti_in_range);
>  
> -static bool psy_has_property(const struct power_supply_desc *psy_desc,
> -			     enum power_supply_property psp)
> +static bool psy_desc_has_property(const struct power_supply_desc *psy_desc,
> +				  enum power_supply_property psp)
>  {
>  	bool found = false;
>  	int i;
> @@ -1209,7 +1209,7 @@ int power_supply_get_property(struct power_supply *psy,
>  		return -ENODEV;
>  	}
>  
> -	if (psy_has_property(psy->desc, psp))
> +	if (psy_desc_has_property(psy->desc, psp))
>  		return psy->desc->get_property(psy, psp, val);
>  	else if (power_supply_battery_info_has_prop(psy->battery_info, psp))
>  		return power_supply_battery_info_get_prop(psy->battery_info, psp, val);
> @@ -1308,7 +1308,7 @@ static int psy_register_thermal(struct power_supply *psy)
>  		return 0;
>  
>  	/* Register battery zone device psy reports temperature */
> -	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
> +	if (psy_desc_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
>  		/* Prefer our hwmon device and avoid duplicates */
>  		struct thermal_zone_params tzp = {
>  			.no_hwmon = IS_ENABLED(CONFIG_POWER_SUPPLY_HWMON)
> @@ -1361,7 +1361,7 @@ __power_supply_register(struct device *parent,
>  		pr_warn("%s: Expected proper parent device for '%s'\n",
>  			__func__, desc->name);
>  
> -	if (psy_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
> +	if (psy_desc_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
>  	    (!desc->usb_types || !desc->num_usb_types))
>  		return ERR_PTR(-EINVAL);
>  
> 


