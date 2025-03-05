Return-Path: <linux-kernel+bounces-547314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADF3A505C9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C173A91AE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BA01A5BB2;
	Wed,  5 Mar 2025 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpZIAwj2"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A732E3362;
	Wed,  5 Mar 2025 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741193673; cv=none; b=hYxJheKsINMzVPMrM8ueWFfajvG6piA1goTgoQoW2ukYMeLWuXhXA4/y1l519cynnsPEv8K67L8dDT7MAw7OPRedoljHqIcxWj4yFy+pci4XR30l6yw+dMa6WVgocNadysYhO2CfrmO9m/lxbCTMull37JWF7CGLYxhW3jRdgUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741193673; c=relaxed/simple;
	bh=mNYCIaC/TiQFcye4zOvTyd+zkhijqrF9hc5gPlQ6OiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZb0bWhK29BpnvlBPV+aNPtdftwByQjZE1/UeNalnkw8LN1ydc3yvB5i8SbRXRoevAQoghuV2qRSUoR6IvotL6nykpFC5j6yRcTVaGg07QYdR5p/ZzxPvCjwErgQqXsiLifFtKWfO5OffE+5KE9R5E9Qd1oqkZe3dXA52MxDlS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpZIAwj2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22359001f1aso162709735ad.3;
        Wed, 05 Mar 2025 08:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741193670; x=1741798470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qjVsQnSqRQBd2D93xCfGrKX4ZhGOSg4lpjeYRuVrhMg=;
        b=WpZIAwj2oMp4qeNElOjErGp/80j4B66U3Rm18FJBPm0+DXWCmKVmpgUmCB1FB/WOy6
         l+x1dEtQvssuaMOKHXHGiDR+0ojqlMn9NWMbliw/ius7j9IMRZZLWJo9wEmg4MqLL0Ml
         J+P7XvDrevLefyGl1W4h//s1hoIIxSSU8YRtWhfxXWuv5MINKFawMNLIwBVNmqGS8UFA
         VtgG2Em2JOpGn2ivGXnhSCV5MB56aOElvs9AQYwFtpHO8cNnQ+NXARahdGplynm0PYIn
         HKqj1hujX30gJUjQ0KwTJfwy+N1UqUPSnoYp6LpbTN9WlBSh7S7NXqE6QjWV5cg1bm6H
         EONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741193670; x=1741798470;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjVsQnSqRQBd2D93xCfGrKX4ZhGOSg4lpjeYRuVrhMg=;
        b=FZtZJDcC1WyJKoOpUJWmDJk8pNOLzuwHEuZesfMpQcFtu4q+yag2NnZcEQPv4g5PC3
         fNh0JbFH5j7lRtbpgROv+pLlMJorPzQB3aRhzX2oQ5GXvREQozZRtK+epKsNxE4fw0eV
         FORaqGNz1h0X/xLABtnWJqGfkqU9VQ1uuXHKSlwAyrKItSjxTW/IyVWBORbl7NbPhzd8
         ycKBekCNMraQg1XYFk8daCCWAAIz+ObRij4+T3nfvUW8Ofgssv4vIGdeHj9olfL2+BnT
         63glM9/jrCCyKQR2ZE4B/UM1OQvP+uCIBlYdxGUdD2qsFvFSpnX+A5f8ILkEfzbrTkzH
         JehQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBYtaR4ASIM1D4PBqXaWVFuFWhakcToRZrrH4MnUlSEUUjnY7TYOWpyZayO6Dqg+2ED1yTNI91JotcT1EZ@vger.kernel.org, AJvYcCXk+HTkGowRX/Es0kdHxF3Fd7g5oF6dYGtEkYzixy0NXbqnDpUukkrk2L1Ta/OFlfXssV6aSLeSJumW@vger.kernel.org, AJvYcCXtCNvpsbHS1bFu12CMQdaX46d2XhI0Shslh6bxamXz+Q9ch50NU/FoHMllKbCNrYwd0vupIt+QjzcXa9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2nE+G/iSsy/bdMVrDHONs4ZZ8AuGzwnti9mK0sD4O+TvkhmVG
	GQ9BfWWrjAeX5EMytFNyoZTkvOSp45Iq/zf742nO0AvEfrT9xh5B
X-Gm-Gg: ASbGnctTzafu8u2iJtVefHIGwX5hO6xZL0o2rbLgjUfQ/LjAsy0EUU2Wkv+xtpk4QNm
	VT27EjemGEfyskEz3lZal9g7GGpTd1p8S07iTGvgUTlE6b+1PYT5spnDifGMJw7qtV93jz/pECB
	WszXeqGmmQd4s0sz/ZXF9kDpbGHOCxTZn/tXZ7VgeCpFgfxebZl5xR7swDmpE2oB8Cr2VV3V9rF
	Y/eyhrDmoNjCeRGkG5X8EOGHw3lrrJqvHQsoabA8pCLDbU2q6TtXi6JQJCjEMGh7YJpjFBZJgfF
	PiLKsXrN8tjpZlHDp04lsmvBLkU3dmHz+pNzr8QvRcJwjAe6IGUPrFL512205o9/iBhn9nc2MBz
	YO27ph0o2rKt23J+9bA==
X-Google-Smtp-Source: AGHT+IELUYOiv9nEvMo6emFh85nrbdMhcJOVKHgtRdU/NVg8mbP4tsGNtdZVd7IcFJrPh5kmFt3Caw==
X-Received: by 2002:a17:902:f693:b0:223:6455:8752 with SMTP id d9443c01a7336-223f1d39301mr66361165ad.43.1741193669541;
        Wed, 05 Mar 2025 08:54:29 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f9e46sm115772545ad.53.2025.03.05.08.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 08:54:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <23608097-f226-471b-b070-d3834e5c129b@roeck-us.net>
Date: Wed, 5 Mar 2025 08:54:27 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] hwmon: emc2305: Use
 devm_thermal_of_cooling_device_register
To: florin.leotescu@oss.nxp.com, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Shych <michaelsh@nvidia.com>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: viorel.suman@nxp.com, carlos.song@nxp.com,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 festevam@gmail.com, Florin Leotescu <florin.leotescu@nxp.com>
References: <20250304162136.1963384-1-florin.leotescu@oss.nxp.com>
 <20250304162136.1963384-4-florin.leotescu@oss.nxp.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250304162136.1963384-4-florin.leotescu@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/25 08:21, florin.leotescu@oss.nxp.com wrote:
> From: Florin Leotescu <florin.leotescu@nxp.com>
> 
> This prepares emc2305 driver to use configuration from Device Tree nodes.
> Using devm_thermal_of_cooling_device_register also simplifies cleanup
> procedure, so we are able to remove the emc2305_unset_tz and emc2305_remove
> functions which are no longer used.
> 
> Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
> ---
>   drivers/hwmon/emc2305.c | 28 +++-------------------------
>   1 file changed, 3 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
> index a236f27c75bc..5f3f06308826 100644
> --- a/drivers/hwmon/emc2305.c
> +++ b/drivers/hwmon/emc2305.c
> @@ -112,8 +112,6 @@ static char *emc2305_fan_name[] = {
>   	"emc2305_fan5",
>   };
>   
> -static void emc2305_unset_tz(struct device *dev);
> -
>   static int emc2305_get_max_channel(const struct emc2305_data *data)
>   {
>   	return data->pwm_num;
> @@ -293,8 +291,9 @@ static int emc2305_set_single_tz(struct device *dev, int idx)
>   	pwm = data->pwm_min[cdev_idx];
>   
>   	data->cdev_data[cdev_idx].cdev =
> -		thermal_cooling_device_register(emc2305_fan_name[idx], data,
> -						&emc2305_cooling_ops);
> +		devm_thermal_of_cooling_device_register(dev, dev->of_node,
> +							emc2305_fan_name[idx], data,
> +							&emc2305_cooling_ops);
>   
>   	if (IS_ERR(data->cdev_data[cdev_idx].cdev)) {
>   		dev_err(dev, "Failed to register cooling device %s\n", emc2305_fan_name[idx]);
> @@ -337,21 +336,9 @@ static int emc2305_set_tz(struct device *dev)
>   	return 0;
>   
>   thermal_cooling_device_register_fail:

This label is no longer necessary. Instead, any goto can be replaced with
an immediate return statement.

> -	emc2305_unset_tz(dev);
>   	return ret;
>   }
>   
> -static void emc2305_unset_tz(struct device *dev)
> -{
> -	struct emc2305_data *data = dev_get_drvdata(dev);
> -	int i;
> -
> -	/* Unregister cooling device. */
> -	for (i = 0; i < EMC2305_PWM_MAX; i++)
> -		if (data->cdev_data[i].cdev)
> -			thermal_cooling_device_unregister(data->cdev_data[i].cdev);
> -}
> -
>   static umode_t
>   emc2305_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr, int channel)
>   {
> @@ -599,14 +586,6 @@ static int emc2305_probe(struct i2c_client *client)
>   	return 0;
>   }
>   
> -static void emc2305_remove(struct i2c_client *client)
> -{
> -	struct device *dev = &client->dev;
> -
> -	if (IS_REACHABLE(CONFIG_THERMAL))
> -		emc2305_unset_tz(dev);
> -}
> -
>   static const struct of_device_id of_emc2305_match_table[] = {
>   	{ .compatible = "microchip,emc2301", },
>   	{ .compatible = "microchip,emc2302", },
> @@ -622,7 +601,6 @@ static struct i2c_driver emc2305_driver = {
>   		.of_match_table = of_emc2305_match_table,
>   	},
>   	.probe = emc2305_probe,
> -	.remove	  = emc2305_remove,
>   	.id_table = emc2305_ids,
>   };
>   


