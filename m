Return-Path: <linux-kernel+bounces-361816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE18299AD56
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4848E1F29D7E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E941D0DC0;
	Fri, 11 Oct 2024 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9hkqi+M"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286FB1D0E11;
	Fri, 11 Oct 2024 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676976; cv=none; b=q+rZHeQTXW7x+CBf30Keu8LJgeU8Ue/G8kByskjaxReQZ/DY7o+Kh8WNuO48ZnesVErlJ+o4ArMElP47bbXrOIDBfgrz7eViArbvh1BwDjDe//Qq9SVXIhWJzcBJiutZTUI2Kf+5zIDckC6t4NtN5aJ8vEOxla7bQI9ZC/KN0J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676976; c=relaxed/simple;
	bh=+Df3m8TdleK5AYYYaLI3RlfLUK6nDjWw9UfG2Ld8Fv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yvy8F5PHuS6SJ3JUe2AEKQFk4DCeplxsRAPCbYwL0WJAU/4Fx58XTyXl7wIjyVnN6AC15CoBnWK9FsWVNaR5mFeF+vSZ8Fq+GTZh+8M+67/3FRkv3obvzTGylzWjqL5+jeUaZEe+8ytbPkJQhVjdRzQKJCk0Blv+JU5VQknXm8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9hkqi+M; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e4c2e36daso160863b3a.0;
        Fri, 11 Oct 2024 13:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728676974; x=1729281774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TR3k9NWi+zlMzB6/oEcDEVkon2/CBpRQmbiky0WUW1s=;
        b=d9hkqi+M7bL6NR1Wb/PmNmTRLgF1W8S+IMP+A0nzYggUTrX2z4J0r7WSlSMctLKAiB
         HqvLvhsPSXqPG/hbd8N6yAOy55RaHziE6VoVyNpM+TeyLFTRKldJN7iaeqbSRc8lTgRi
         CGB0H0LzLEfr/SsbvqGPrhdUtQZK1vuQsi1QzSwSj/3w3G3alOrCGTUtywujj+mR6zNr
         VIwfnuVQ8f5GCzEX3xDEc4+S9agE45N+EMBMr8+Aq5Gi11YGupCAFyDU0eXFRmDhUo1j
         YwXEaGY9sIiYi9AyXJxihpPVP4AE3sP1oc7SbgLInthboVydiam1K3G9ebskA9W/er/8
         Z7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676974; x=1729281774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TR3k9NWi+zlMzB6/oEcDEVkon2/CBpRQmbiky0WUW1s=;
        b=IEwhTa+GTl4UkRLdeH13d0EIJZoLKiUSmS9nfhDFkylq1WchErsQXMW4jaZiMZIE/g
         7icKydf70jq6J5T6CFwqrh7dcwEqlKRa44ft8EtZwAPjjMDhuK5INqS9oafg/n4xowYL
         H5dJai7JXDM1lmR7T4RvWO5YENjlCBaFAoref/oz0MoAm7kWE5SkrMUu1jvwKtlm+b6P
         OjZHfb+dLRVC9iKz8ahatmbcuZfu9tczVk/0GIJf5i3A0gQJaKv1rpVGvtxb5wf3ouh5
         0+IuTLGtoE7fKQm6QsmVpfDxi5RAaASg5vySmG5e2hOXyzYKezpYeG/SBmadv7u8q2fY
         wndw==
X-Forwarded-Encrypted: i=1; AJvYcCUPM/aM7mhv6esoRsc7/zybkDs6w1LMuz/i7bSAMeJO2EqK2HeeaNYaskvWL1PKHTHK3p3w5YrF0Zl4pA==@vger.kernel.org, AJvYcCUgK+egA0cEimH6oJjusWjwgytwvM3GXQifJGRzi1Rj4YBjFCKjpmQ/SOBdormp7eD2MyJ0RNf4x4e6ND7z@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm4rQp/sUcRjEHFE+kmZHSDj/D14eZVYf4uYF4pLmGJ3//0PPM
	k6576xGNmyht/5M8kHP0n3RzbHapqn6kZJOt+2RGrRvLUfq8d9VK+mn+4Q==
X-Google-Smtp-Source: AGHT+IEr8gByrw5G/koadkeR5jYTBeJFnmsYTVgRfcWVw8kr47Rmqpr20r0/Z6LjJQbbLTyKMOucng==
X-Received: by 2002:a05:6a21:a4c2:b0:1d5:143d:5197 with SMTP id adf61e73a8af0-1d8bc8066e8mr5123281637.6.1728676974183;
        Fri, 11 Oct 2024 13:02:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e4a0f4e99sm477710b3a.151.2024.10.11.13.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 13:02:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 11 Oct 2024 13:02:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [RESEND PATCH v2] hwmon: (max6639) : Configure based on DT
 property
Message-ID: <7ef01e93-f714-4704-85da-1a06940d56b6@roeck-us.net>
References: <20241007090426.811736-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007090426.811736-1-naresh.solanki@9elements.com>

On Mon, Oct 07, 2024 at 02:34:24PM +0530, Naresh Solanki wrote:
> Remove platform data & initialize with defaults
> configuration & overwrite based on DT properties.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

Applied, with minor changes. See below.

Thanks,
Guenter

> ---
> Changes in V2:
> - Allow initializing the driver with defaults & overrid based on DT
>   properties if specified.
> - Remove unrelated changes.
> - Optimise ppr check to remove unacceptable range.
> ---
>  drivers/hwmon/max6639.c               | 85 +++++++++++++++++++--------
>  include/linux/platform_data/max6639.h | 15 -----
>  2 files changed, 62 insertions(+), 38 deletions(-)
>  delete mode 100644 include/linux/platform_data/max6639.h
> 
> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> index c955b0f3a8d3..6eacb5aed96d 100644
> --- a/drivers/hwmon/max6639.c
> +++ b/drivers/hwmon/max6639.c
> @@ -19,7 +19,6 @@
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/err.h>
>  #include <linux/mutex.h>
> -#include <linux/platform_data/max6639.h>
>  #include <linux/regmap.h>
>  #include <linux/util_macros.h>
>  
> @@ -531,14 +530,51 @@ static int rpm_range_to_reg(int range)
>  	return 1; /* default: 4000 RPM */
>  }
>  
> +static int max6639_probe_child_from_dt(struct i2c_client *client,
> +				       struct device_node *child,
> +				       struct max6639_data *data)
> +
> +{
> +	struct device *dev = &client->dev;
> +	u32 i;
> +	int err, val;
> +
> +	err = of_property_read_u32(child, "reg", &i);
> +	if (err) {
> +		dev_err(dev, "missing reg property of %pOFn\n", child);
> +		return err;
> +	}
> +
> +	if (i > 1) {
> +		dev_err(dev, "Invalid fan index reg %d\n", i);
> +		return -EINVAL;
> +	}
> +
> +	err = of_property_read_u32(child, "pulses-per-revolution", &val);
> +

Dropped such empty lines for consistency.

> +	if (!err) {
> +		if (val < 1 || val > 5) {
> +			dev_err(dev, "invalid pulses-per-revolution %d of %pOFn\n", val, child);
> +			return -EINVAL;
> +		}
> +		data->ppr[i] = val;
> +	}
> +
> +	err = of_property_read_u32(child, "max-rpm", &val);
> +
> +	if (!err)
> +		data->rpm_range[i] = rpm_range_to_reg(val);
> +
> +	return 0;
> +}
> +
>  static int max6639_init_client(struct i2c_client *client,
>  			       struct max6639_data *data)
>  {
> -	struct max6639_platform_data *max6639_info =
> -		dev_get_platdata(&client->dev);
> -	int i;
> -	int rpm_range = 1; /* default: 4000 RPM */
> -	int err, ppr;
> +	struct device *dev = &client->dev;
> +	const struct device_node *np = dev->of_node;
> +	struct device_node *child;
> +	int i, err;
>  
>  	/* Reset chip to default values, see below for GCONFIG setup */
>  	err = regmap_write(data->regmap, MAX6639_REG_GCONFIG, MAX6639_GCONFIG_POR);
> @@ -546,21 +582,29 @@ static int max6639_init_client(struct i2c_client *client,
>  		return err;
>  
>  	/* Fans pulse per revolution is 2 by default */
> -	if (max6639_info && max6639_info->ppr > 0 &&
> -			max6639_info->ppr < 5)
> -		ppr = max6639_info->ppr;
> -	else
> -		ppr = 2;
> +	data->ppr[0] = 2;
> +	data->ppr[1] = 2;
>  
> -	data->ppr[0] = ppr;
> -	data->ppr[1] = ppr;
> +	/* default: 4000 RPM */
> +	data->rpm_range[0] = 1;
> +	data->rpm_range[1] = 1;
>  
> -	if (max6639_info)
> -		rpm_range = rpm_range_to_reg(max6639_info->rpm_range);
> -	data->rpm_range[0] = rpm_range;
> -	data->rpm_range[1] = rpm_range;
> +	for_each_child_of_node(np, child) {
> +		if (strcmp(child->name, "fan"))
> +			continue;
> +
> +		err = max6639_probe_child_from_dt(client, child, data);
> +		if (err) {
> +			of_node_put(child);
> +			return err;
> +		}
> +	}
>  
>  	for (i = 0; i < MAX6639_NUM_CHANNELS; i++) {
> +		err = regmap_set_bits(data->regmap, MAX6639_REG_OUTPUT_MASK, BIT(1 - i));
> +		if (err)
> +			return err;
> +
>  		/* Set Fan pulse per revolution */
>  		err = max6639_set_ppr(data, i, data->ppr[i]);
>  		if (err)
> @@ -573,12 +617,7 @@ static int max6639_init_client(struct i2c_client *client,
>  			return err;
>  
>  		/* Fans PWM polarity high by default */
> -		if (max6639_info) {
> -			if (max6639_info->pwm_polarity == 0)
> -				err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x00);
> -			else
> -				err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x02);
> -		}
> +		err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x00);
>  		if (err)
>  			return err;
>  
> diff --git a/include/linux/platform_data/max6639.h b/include/linux/platform_data/max6639.h
> deleted file mode 100644
> index 65bfdb4fdc15..000000000000
> --- a/include/linux/platform_data/max6639.h
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _LINUX_MAX6639_H
> -#define _LINUX_MAX6639_H
> -
> -#include <linux/types.h>
> -
> -/* platform data for the MAX6639 temperature sensor and fan control */
> -
> -struct max6639_platform_data {
> -	bool pwm_polarity;	/* Polarity low (0) or high (1, default) */
> -	int ppr;		/* Pulses per rotation 1..4 (default == 2) */
> -	int rpm_range;		/* 2000, 4000 (default), 8000 or 16000 */
> -};
> -
> -#endif /* _LINUX_MAX6639_H */

