Return-Path: <linux-kernel+bounces-315878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CF996C80C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E18F1C218B4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD721E764C;
	Wed,  4 Sep 2024 19:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VruHG0n0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5A31E6DE8
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479836; cv=none; b=MjgIbdW/BmvOV7vDqfFaFFkO215hefFywxKGbhiH89IZkCGO2kq8X8+6QL2H4KYNgyXsnBgPQS8V9/1umTNyr/lBbdDk/RwES55OAHn2bDSJlV6Ti+eORlRfHMzX3dttGd/Wfstse7wVo8akfP5BMB8MjIgE5BZYBWksoZU6Puk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479836; c=relaxed/simple;
	bh=2JKbg4yAomSa2lCLAxvDK8rug+J90DosygVA/s5G7c0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0TGkb/VVR5NRhgZ/54o3AceVCMiR+0MyCzoKmBAQo+8VsdAg1VeE3z3+keSeYIp1GdZvIuicUwh6zQQtfcgjM25KvAU9Eb9SGzE2jyopUw+qV6jct8fRnbPhDcwkFzUz9vQfPDyDLEfN39v4tiFOtrhexjOXFlhuz1nrV0gCoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VruHG0n0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725479833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R68qYfGkW/a8842ERb0qGpkAxJP/22WSWV3GhDUBb/A=;
	b=VruHG0n0FwCrwyapHxiPJ2UHq9GktRk2/vn4pjmWC3vAhb4R5g+O2iCZySK+2AXorhWzoL
	9PZ38qXGmdMAuzdRHIKn60BJrsDm1M9nW09nPLp/fQ/wmQhhfC2ZbM5hWLk0ZczMkrLtmU
	+zyDoLfcPMxR2xSng2GQPOf8lsSsszU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-44NK37DhNVqntLsA2KFkJg-1; Wed, 04 Sep 2024 15:57:12 -0400
X-MC-Unique: 44NK37DhNVqntLsA2KFkJg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c3c245a8easo732428a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 12:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725479830; x=1726084630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R68qYfGkW/a8842ERb0qGpkAxJP/22WSWV3GhDUBb/A=;
        b=Xc53yQwVU1HOv7ASvp8Kw5JVk1+YJLVuFkASQaeTCvkwRH+E8HeiELl74GiNSRw6wC
         u7W6wHO+uTQcxpFyM4NX8N2JlFJa8DY9zhrIAndAOfoCDnjq7Sd91YW03xCc5diPSc/5
         B45L5oH4r0Fb2kUf7jv0+RzpvBLU5G4pO/2o4Lav94BBZOOtwbIKlm4CXeCadwmNNWo2
         GWu+UY9wKinzu6ruhNVZc7z3BntU+/Y1uere1Ruo0tUpFaeNCy1ewRQ/+3TuXQhxDzSP
         9veBt8XbT1PqPMnHEUtd0zMKGM9VcOyrBa74UpVTRxDkFkIk/8vDZFfpdH95D+se3fVR
         U8lw==
X-Forwarded-Encrypted: i=1; AJvYcCUxzNv3Xi6mYMC7vMXieB/WicLLJi86sSj+EmBGY1lr68Nqb+Xmw6ixT4UK94HsUqVnmdo8+D0oGZk4sR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEYbIQhct2RHIPIzYUIXolgTobhmfouCsce0Vw/DTInMperm9k
	PPmsJF3JgCXqMwBYfVn7GstM9mXYIvUdQ69K5AUrB168tepxVrlRomp0flU3xHaCRcNXCeEfLp4
	Je7oOhlPs9/HE/qNiXHd442xbMi9V7YDfX9pUYQTWHmyN+pO+aNZ7s4yHtYBnBg==
X-Received: by 2002:a17:907:9729:b0:a7a:a0c2:8be9 with SMTP id a640c23a62f3a-a897f84d369mr1923727066b.18.1725479830464;
        Wed, 04 Sep 2024 12:57:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5cP4vNqhH3jpIoCKOZgGubwlCRWIPRfbFu++5wMJojKJgyj8OkkCJRV1sqLqUjTTsO6JC4A==
X-Received: by 2002:a17:907:9729:b0:a7a:a0c2:8be9 with SMTP id a640c23a62f3a-a897f84d369mr1923724366b.18.1725479829873;
        Wed, 04 Sep 2024 12:57:09 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc6a5cfasm273014a12.92.2024.09.04.12.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 12:57:09 -0700 (PDT)
Message-ID: <6c161ffb-93bb-44f5-a47d-b93561da7cb4@redhat.com>
Date: Wed, 4 Sep 2024 21:57:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 3/9] power: supply: hwmon: register battery
 properties
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
 <20240904-power-supply-extensions-v3-3-62efeb93f8ec@weissschuh.net>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240904-power-supply-extensions-v3-3-62efeb93f8ec@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 9/4/24 9:25 PM, Thomas Weißschuh wrote:
> Instead of only registering properties from the psy_desc itself,
> also register the ones from the battery.
> Use power_supply_has_property() for this test which makes the logic also
> easier to read.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/power/supply/power_supply_hwmon.c | 52 +++++++++++++++----------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
> index baacefbdf768..1c1ad3e1d81f 100644
> --- a/drivers/power/supply/power_supply_hwmon.c
> +++ b/drivers/power/supply/power_supply_hwmon.c
> @@ -8,6 +8,8 @@
>  #include <linux/power_supply.h>
>  #include <linux/slab.h>
>  
> +#include "power_supply.h"
> +
>  struct power_supply_hwmon {
>  	struct power_supply *psy;
>  	unsigned long *props;
> @@ -347,9 +349,28 @@ static const struct hwmon_chip_info power_supply_hwmon_chip_info = {
>  	.info = power_supply_hwmon_info,
>  };
>  
> +static const enum power_supply_property power_supply_hwmon_props[] = {
> +	POWER_SUPPLY_PROP_CURRENT_AVG,
> +	POWER_SUPPLY_PROP_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_POWER_AVG,
> +	POWER_SUPPLY_PROP_POWER_NOW,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_TEMP_MAX,
> +	POWER_SUPPLY_PROP_TEMP_MIN,
> +	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
> +	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
> +	POWER_SUPPLY_PROP_TEMP_AMBIENT,
> +	POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN,
> +	POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX,
> +	POWER_SUPPLY_PROP_VOLTAGE_AVG,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +};
> +
>  int power_supply_add_hwmon_sysfs(struct power_supply *psy)
>  {
> -	const struct power_supply_desc *desc = psy->desc;
>  	struct power_supply_hwmon *psyhw;
>  	struct device *dev = &psy->dev;
>  	struct device *hwmon;
> @@ -375,32 +396,11 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
>  		goto error;
>  	}
>  
> -	for (i = 0; i < desc->num_properties; i++) {
> -		const enum power_supply_property prop = desc->properties[i];
> -
> -		switch (prop) {
> -		case POWER_SUPPLY_PROP_CURRENT_AVG:
> -		case POWER_SUPPLY_PROP_CURRENT_MAX:
> -		case POWER_SUPPLY_PROP_CURRENT_NOW:
> -		case POWER_SUPPLY_PROP_POWER_AVG:
> -		case POWER_SUPPLY_PROP_POWER_NOW:
> -		case POWER_SUPPLY_PROP_TEMP:
> -		case POWER_SUPPLY_PROP_TEMP_MAX:
> -		case POWER_SUPPLY_PROP_TEMP_MIN:
> -		case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> -		case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> -		case POWER_SUPPLY_PROP_TEMP_AMBIENT:
> -		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
> -		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
> -		case POWER_SUPPLY_PROP_VOLTAGE_AVG:
> -		case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> -		case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> -		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +	for (i = 0; i < ARRAY_SIZE(power_supply_hwmon_props); i++) {
> +		const enum power_supply_property prop = power_supply_hwmon_props[i];
> +
> +		if (power_supply_has_property(psy, prop))
>  			set_bit(prop, psyhw->props);
> -			break;
> -		default:
> -			break;
> -		}
>  	}
>  
>  	name = psy->desc->name;
> 


