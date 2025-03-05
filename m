Return-Path: <linux-kernel+bounces-547024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D736EA501E9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89CDC18997CB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C912451F3;
	Wed,  5 Mar 2025 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVW0j2Hh"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E060A24CEF0;
	Wed,  5 Mar 2025 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184701; cv=none; b=SBy7LW/cj2m0MLfgrrpwzgfrtTWnGGbICcN/WCdvVEME9LmhdVpqfxS+Ryzz9xFQxTkmp40Qt+WbSMq7q+Un+SDVzXQyCwA/e3Z6xiW3vKE0yf71rOWunvWN64d49q7OsqmqAxFNKTbw2FwMMOsSmjvVguGSH3VWvf6ZSMp1vZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184701; c=relaxed/simple;
	bh=s0zr6D2ckNiUotkJ2P1ifgRjgGFgxiTm2Ts7TKPwu60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnDMpbIkKtWPrxviHQEs0ZjWyhp3/EqDkelHIsISCYytC0uG+RVnnU6BgclZhuG0MEai+BM/TeTU/UWlPIACA2zJHfkITCP/ztvNnWipvBrZG8pRetxfjgzcu1BLCWt+GxxagnQ7ZmVUsuA/iMdS4sprjsjfwmTOTywb882mgx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVW0j2Hh; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fe9759e5c1so11066216a91.0;
        Wed, 05 Mar 2025 06:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741184697; x=1741789497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=AXWef6IdEB5JGRcvEtExho3N/ocbhsBLUWnv1h9Bq7U=;
        b=mVW0j2Hh1xQaySBZ2l+OxHcl623i9tJxS4+Efi02SCK0q6sk9ty8v2LnxSWfAT0vCR
         HSdsJqvZfufsPCqVASzmI8MV0a8CluoS1/Kh0ofYhj5JKKu+UzmBww1+HcRn9BEsKj59
         csnzfWGgBncOeeCCGmDT6Rh6QRWJi/9OB+rG3+xr9oJOHle9H9P0CKG4zbTYUU5kvs9a
         bAQqKrl1PFgMjUCwPi+1yNGdI0Uw8Uq6lnPj2jhM5RHFiP3zhKvFCVCQvYxgd7aBPvTy
         MewLI3RRraFIi1dEb3ATT+4IWHkR5oW2CWiKOHR+KRIFLsrjqv9gxEBD5Jyn+Eu8Gr1b
         JE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741184697; x=1741789497;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXWef6IdEB5JGRcvEtExho3N/ocbhsBLUWnv1h9Bq7U=;
        b=JMeDP5NU4r9a6WcE+FKRHlZpZKy9fvyxm5CRBQ/HA6Xh+OQNvdgu7a3WLwQMyyXcdC
         XpBgvj0upkSC504/uNWnxYDj/v4uyn/DLNiSWERXm1bqCPyXSBgTN9lKtTSRlJ+sIE3P
         2e+qyfq49m0W4APxvceVrMe8USJOoIl8bitBmitKCnZ9grQR1f1zgRk5BRjKif/lkxTA
         xBlQtMPc+2106OHwwraXy/+hyBMmPabIueOr9U5ZFVQWUTlOnBZay6+Dh7tDgK9YfQYk
         aAA1OdNeS38AF6cGepmk99Cngm7SRD1xIYDM13u9h91tyQS+m7REciWCxybR2cPTKB5I
         Vyjg==
X-Forwarded-Encrypted: i=1; AJvYcCU1TzvhXuJpUUA3sNxsEQyfrgTy6ot/6BxjWY0BHKBv5+tewoIof/LmMfZTcx/oSVSW2Y3xQHxagRaqE8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4t6bL3m+5gmyMsH+zUtHQKPU9OD8Dse4PfwSvalXGvCz7tzzS
	BSAYAdDSL0lRMCco0rfuUGZgiH8TpPkYgIZpkIosMpmHYDTAjUt/
X-Gm-Gg: ASbGnct4yo82qCMUXirfRDxuGzgau+EfwtfS3UkCZOT0tvmIKznFzrkC7DL71nGQ5gU
	uLNA2EtPGcjqWj9Aaq8BglKfBa8TXeknm0Z157UQq/U5k+/AAl4bcPjlC7vyiY5re3LnQEVB0Eh
	1PH4p7t9+Dd5MezYZoCGjYBywNd0PxdN6EgOqpXxBBO+d5sAhNGEGYp9w0oKLTamd+B0KkDVu28
	q/Ni4+vUOWe2vhd4XUCTKExvxFba3IiU9DgRB2TA/VX4uJQnIg62/Hs5H2uyC5122FfscII0ZH+
	3FObdHbKZD7mRgNA36xka435gpTUwtkq+rLGLH13dskZZu32CeZW0MCZjFMo6rPQJuIMWG4+Kan
	ptLUl3ouEOYvYk0tk9w==
X-Google-Smtp-Source: AGHT+IGXMMAmeRUeAiYWcM4WdCCGVwf/LOYsa8qswCh/WqGHBoSLToIGh91RJjkwGUAy9W/0rOmVeA==
X-Received: by 2002:a17:90a:c108:b0:2ff:58e1:2bc9 with SMTP id 98e67ed59e1d1-2ff58f07017mr1403089a91.25.1741184697058;
        Wed, 05 Mar 2025 06:24:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e776410sm1516357a91.14.2025.03.05.06.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 06:24:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7b7fe0a5-22bf-45bd-8ad9-ada80714228c@roeck-us.net>
Date: Wed, 5 Mar 2025 06:24:55 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] hwmon: (gpio-fan) Add regulator support
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250305105314.2009637-1-alexander.stein@ew.tq-group.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250305105314.2009637-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/25 02:53, Alexander Stein wrote:
> FANs might be supplied by a regulator which needs to be enabled as well.
> This is implemented using runtime PM. Every time speed_index changes from
> 0 to non-zero and vise versa RPM is resumed or suspended.
> Intitial RPM state is determined by initial value of speed_index.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Patch 1 & 2 from v1 [1] have already been applied, although number 2 [2] is not
> yet showing in next-20250305. Patches 3 & 4 (just removing comments) from v1
> have been dropped, so only this patch remains.
> 
> Changes in v2:
> * Make regulator non-optional
> 
> [1] https://lore.kernel.org/all/20250210145934.761280-1-alexander.stein@ew.tq-group.com/
> [2] https://web.git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git/commit/?h=hwmon-next&id=9fee7d19bab635f89223cc40dfd2c8797fdc4988
> ---
>   drivers/hwmon/gpio-fan.c | 81 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 77 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
> index cee3fa146d69a..db918d6858325 100644
> --- a/drivers/hwmon/gpio-fan.c
> +++ b/drivers/hwmon/gpio-fan.c
> @@ -20,6 +20,9 @@
>   #include <linux/gpio/consumer.h>
>   #include <linux/of.h>
>   #include <linux/of_platform.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
>   #include <linux/thermal.h>
>   
>   struct gpio_fan_speed {
> @@ -42,6 +45,7 @@ struct gpio_fan_data {
>   	bool			pwm_enable;
>   	struct gpio_desc	*alarm_gpio;
>   	struct work_struct	alarm_work;
> +	struct regulator	*supply;
>   };
>   
>   /*
> @@ -125,13 +129,38 @@ static int __get_fan_ctrl(struct gpio_fan_data *fan_data)
>   }
>   
>   /* Must be called with fan_data->lock held, except during initialization. */
> -static void set_fan_speed(struct gpio_fan_data *fan_data, int speed_index)
> +static int set_fan_speed(struct gpio_fan_data *fan_data, int speed_index)

What is the point of changing this function to return an error,
but not checking for that error in the calling code ?

>   {
>   	if (fan_data->speed_index == speed_index)
> -		return;
> +		return 0;
> +
> +	if (fan_data->speed_index == 0 && speed_index > 0) {
> +		int ret;
> +
> +		ret = pm_runtime_resume_and_get(fan_data->dev);
> +		if (ret < 0) {
> +			dev_err(fan_data->dev,
> +				"Failed to runtime_get device: %d\n", ret);

Please drop that noise. If you think you need the messages,
make it debug messages.

> +			return ret;
> +		}
> +	}
>   
>   	__set_fan_ctrl(fan_data, fan_data->speed[speed_index].ctrl_val);
> +
> +	if (fan_data->speed_index > 0 && speed_index == 0) {
> +		int ret;
> +
> +		ret = pm_runtime_put_sync(fan_data->dev);
> +		if (ret < 0) {
> +			dev_err(fan_data->dev,
> +				"Failed to runtime_put device: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>   	fan_data->speed_index = speed_index;
> +
> +	return 0;
>   }
>   
>   static int get_fan_speed_index(struct gpio_fan_data *fan_data)
> @@ -499,6 +528,8 @@ static void gpio_fan_stop(void *data)
>   	mutex_lock(&fan_data->lock);
>   	set_fan_speed(data, 0);
>   	mutex_unlock(&fan_data->lock);
> +
> +	pm_runtime_disable(fan_data->dev);
>   }
>   
>   static int gpio_fan_probe(struct platform_device *pdev)
> @@ -521,6 +552,11 @@ static int gpio_fan_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, fan_data);
>   	mutex_init(&fan_data->lock);
>   
> +	fan_data->supply = devm_regulator_get(dev, "fan");
> +	if (IS_ERR(fan_data->supply))
> +		return dev_err_probe(dev, PTR_ERR(fan_data->supply),
> +				     "Failed to get fan-supply");
> +
>   	/* Configure control GPIOs if available. */
>   	if (fan_data->gpios && fan_data->num_gpios > 0) {
>   		if (!fan_data->speed || fan_data->num_speed <= 1)
> @@ -548,6 +584,17 @@ static int gpio_fan_probe(struct platform_device *pdev)
>   			return err;
>   	}
>   
> +	pm_runtime_set_suspended(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	/* If current GPIO state is active, mark RPM as active as well */
> +	if (fan_data->speed_index > 0) {
> +		int ret;
> +
> +		ret = pm_runtime_resume_and_get(&pdev->dev);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	/* Optional cooling device register for Device tree platforms */
>   	fan_data->cdev = devm_thermal_of_cooling_device_register(dev, np,
>   				"gpio-fan", fan_data, &gpio_fan_cool_ops);
> @@ -568,6 +615,28 @@ static void gpio_fan_shutdown(struct platform_device *pdev)
>   	}
>   }
>   
> +static int gpio_fan_runtime_suspend(struct device *dev)
> +{
> +	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	if (fan_data->supply)
> +		ret = regulator_disable(fan_data->supply);
> +
> +	return ret;
> +}
> +
> +static int gpio_fan_runtime_resume(struct device *dev)
> +{
> +	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	if (fan_data->supply)
> +		ret = regulator_enable(fan_data->supply);
> +
> +	return ret;
> +}
> +
>   static int gpio_fan_suspend(struct device *dev)
>   {
>   	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
> @@ -595,14 +664,18 @@ static int gpio_fan_resume(struct device *dev)
>   	return 0;
>   }
>   
> -static DEFINE_SIMPLE_DEV_PM_OPS(gpio_fan_pm, gpio_fan_suspend, gpio_fan_resume);
> +static const struct dev_pm_ops gpio_fan_pm = {
> +	RUNTIME_PM_OPS(gpio_fan_runtime_suspend,
> +		       gpio_fan_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(gpio_fan_suspend, gpio_fan_resume)
> +};
>   
>   static struct platform_driver gpio_fan_driver = {
>   	.probe		= gpio_fan_probe,
>   	.shutdown	= gpio_fan_shutdown,
>   	.driver	= {
>   		.name	= "gpio-fan",
> -		.pm	= pm_sleep_ptr(&gpio_fan_pm),
> +		.pm	= pm_ptr(&gpio_fan_pm),
>   		.of_match_table = of_gpio_fan_match,
>   	},
>   };


