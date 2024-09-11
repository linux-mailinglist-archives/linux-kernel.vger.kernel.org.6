Return-Path: <linux-kernel+bounces-325237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3E49756A9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FC96B28022
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C951E1AB505;
	Wed, 11 Sep 2024 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbGb500z"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8A819E987;
	Wed, 11 Sep 2024 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067728; cv=none; b=l8Np5oF3vQAEL7Z4WxECwyBbLUFRkl4Ew9hhwU+Q4BJJyFmFdBTrUQPkiSzAu4Vr26GwCUvtBWNHjeyhqM8d+mJyQQ88hpk1PUIBEA9aaBu5EY0VLkn4SAoe4ulwneentP2JqebAUktl2BAn+VFa/Mf1FERy6cu+ndkSZ0Iuwrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067728; c=relaxed/simple;
	bh=1ikkZrP0DFGqqqfwyIqYV+Rv0RtBLxjjAzyjpmSXqHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A/PwMjgxWbcEQjGQ+LkBddef6w5CAJKFj/wIY+jBq6pO5a+Gvg4wyJXNAHrHSWAYS99PN7+eU1lADFZ+juz7oafA8AWRg99YZ1tIDjlC62ZVdA9CdR0OhmO+ob0DO4KR+bCBX7Hd68G7PrpU7ko0K/XL8bBIjLFi+1GTrnQvgTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbGb500z; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2059112f0a7so63346145ad.3;
        Wed, 11 Sep 2024 08:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726067726; x=1726672526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UFDkOpbLdXwPPpB0RaMmYe4++qY3nRZUewhQiCS2CvE=;
        b=hbGb500z38W8TzKGjpn8KDIFgcJMj66G95wGLhSpEjEW5RDHk/kJJgYPoltycDZiHJ
         NSckbkc68ibZEnSD5HZXfH6j0NNHGbcdyae4ad36oyFbzcCW4zF4xV1PRoQGFzbwZZxJ
         VZ/ViD5BgaLj99Ngqb8mWTSs8YLn/yw9+YcZuoP9JNWFU53ntn/1ypi7f3zelCcO8z4f
         YYsMp14Ux0i+OOKu4Q5f72jex3cEqVcxng+WorNG0JAUt4fK9UWNrYH0jBIfBbNDZHR+
         f9hdmtTy+tOEC00g/KNuiQEO4GLHg4u/RLZQHAv82Q7HLTakJTgP63//+G/YiO7bk8KV
         4gMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726067726; x=1726672526;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFDkOpbLdXwPPpB0RaMmYe4++qY3nRZUewhQiCS2CvE=;
        b=WkZBftL0Zyd2Xtl/Jc2Qi3qoTUTySy1Dp3BaPF9perS2lKBxbCbKgrYpA+Z0mX0P8m
         9zYBZe/M4Cltz15MOFV5RoAB16sD/PL8eatRkJF50Xe9u8sDImO9KJMrpzM+xg+0HbK5
         9TE13GlHQMGPsQ7BkEBb6eXGMwxjK+QLHdCJ4hFRdJCp+wyG96BiC0PwCCzL8E8NsQ61
         YvhvTJZ42IpMVBufMchILXJqAzHeCNzSK3sL7MJhiMrhA8PIEiHV+q8wOb11+RY1Kp9y
         OTPwK9dKhXAXhb9FSS7vlKUi90ixIX/39HF5Dg7p8TtQByRPGWXUkR/IGzHRCM+VXy0g
         AQ5w==
X-Forwarded-Encrypted: i=1; AJvYcCUcHMSPlMPBwkSs4CiiQtL5eEOJDZlg6dDLs6UY4FhgMGxyh3I0YnxtSuKTlSQgUGRr8M8O6vbAjPGPDtzI@vger.kernel.org, AJvYcCVWpMp4uXryKBoYOMz8vHcMVeFNqG3VhNP/YY4rnFHpFcHsqe426ilcd+J73OCGo6uizNBMVkNb9ZFFxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLs2Wxo5CAszs/CUiJYYb+L42EQZwdBZu50bNY8kQRP+x3dFVO
	NAs405Ku3qmUGvbrCjPfkJxUp71t4ijxlttAG9VVujjf3zECNhRi
X-Google-Smtp-Source: AGHT+IETHXrgxgD+t2Z+Vew6MuqqOk0Sf/rBSzyRo7G3Xb82yZYwTE2vOcqXr+Fp0OSaBDVrpLdRzw==
X-Received: by 2002:a17:902:db09:b0:205:866d:174f with SMTP id d9443c01a7336-2074c69c103mr63108965ad.44.1726067725717;
        Wed, 11 Sep 2024 08:15:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af47145sm886245ad.70.2024.09.11.08.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 08:15:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f7653d58-9cee-4496-91b8-55dda44289bc@roeck-us.net>
Date: Wed, 11 Sep 2024 08:15:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux dev-6.11 1/2] hwmon: modified ina2xx to match
 SY24655(SQ52205)
To: Wenliang <wenliang202407@163.com>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <7c155638-8c33-4873-9534-17a9454c83e6@roeck-us.net>
 <20240911122518.41393-1-wenliang202407@163.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240911122518.41393-1-wenliang202407@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 05:25, Wenliang wrote:
> After listening to your advice, I have adapted SQ52205 by rewriting the
> ina2xx driver.At the same time, I would like to clarify that SY24655 and
> SQ52205 are different partnumber of the same chip. Therefore, you can
> refer to SY24655FBP. I have also changed the naming within the driver to
> SY24655, and I hope to receive your response.
> 

This is not an appropriate patch description. The information is useful,
but should be after '---'. Also, this is the second version of your
patch and should be versioned.

Please read and follow Documentation/process/submitting-patches.rst

You did not use the updated version of the ina2xx driver for this patch.
The updated version is now available in linux-next and will be sent upstream
in the next commit window. Consequently your patch is outdated.

Additional comments inline.

> Signed-off-by: Wenliang <wenliang202407@163.com>
> ---
>   Documentation/hwmon/ina2xx.rst |  24 ++++++++
>   drivers/hwmon/Kconfig          |   2 +-
>   drivers/hwmon/ina2xx.c         | 106 +++++++++++++++++++++++++++++++--
>   3 files changed, 126 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/hwmon/ina2xx.rst b/Documentation/hwmon/ina2xx.rst
> index 27d2e39bc8ac..0bd16a0104a7 100644
> --- a/Documentation/hwmon/ina2xx.rst
> +++ b/Documentation/hwmon/ina2xx.rst
> @@ -53,6 +53,16 @@ Supported chips:
>   
>   	       https://www.ti.com/
>   
> +  * Silergy SY24655
> +
> +
> +    Prefix: 'sy24655'
> +    Addresses: I2C 0x40 - 0x4f
> +
> +    Datasheet: Publicly available at the Silergy website
> +
> +	       https://us1.silergy.com/
> +
>   Author: Lothar Felten <lothar.felten@gmail.com>
>   
>   Description
> @@ -72,6 +82,11 @@ INA230 and INA231 are high or low side current shunt and power monitors
>   with an I2C interface. The chips monitor both a shunt voltage drop and
>   bus supply voltage.
>   
> +The SY24655 is a high- and low-side current shunt and power monitor with an I2C
> +interface. The SY24655 both shunt drop and supply voltage, with programmable
> +calibration value and conversion times. The SY24655 can also calculate average
> +power for use in energy conversion.
> +
>   The shunt value in micro-ohms can be set via platform data or device tree at
>   compile-time or via the shunt_resistor attribute in sysfs at run-time. Please
>   refer to the Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml for bindings
> @@ -113,6 +128,15 @@ update_interval		data conversion time; affects number of samples used
>   			to average results for shunt and bus voltages.
>   ======================= ====================================================
>   
> +Sysfs entries for sy24655 only
> +------------------------------------------------
> +
> +======================= ====================================================
> +update_interval		data conversion time; affects number of samples used
> +			to average results for shunt and bus voltages.

The above is not for sy24655 only; it also applies to ina226 and compatible chips.

> +calculate_avg_power	calculate average power from last reading to the present.

Why not the standard power1_average ? I don't see a reason to introduce a non-standard
attribute.

> +======================= ====================================================
> +
>   .. note::
>   
>      - Configure `shunt_resistor` before configure `power1_crit`, because power
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index b60fe2e58ad6..1f9752689ae8 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2138,7 +2138,7 @@ config SENSORS_INA2XX
>   	select REGMAP_I2C
>   	help
>   	  If you say yes here you get support for INA219, INA220, INA226,
> -	  INA230, and INA231 power monitor chips.
> +	  INA230, INA231, and Silergy SY24655 power monitor chips.
>   
>   	  The INA2xx driver is configured for the default configuration of
>   	  the part as described in the datasheet.
> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
> index 9ab4205622e2..34d474ac0b66 100644
> --- a/drivers/hwmon/ina2xx.c
> +++ b/drivers/hwmon/ina2xx.c
> @@ -18,6 +18,10 @@
>    * Bi-directional Current/Power Monitor with I2C Interface
>    * Datasheet: https://www.ti.com/product/ina230
>    *
> + * SY24655:
> + * Bi-directional Current/Power Monitor with I2C Interface
> + * Datasheet: https://us1.silergy.com/productsview/SY24655FBP
> + *
>    * Copyright (C) 2012 Lothar Felten <lothar.felten@gmail.com>
>    * Thanks to Jan Volkering
>    */
> @@ -51,15 +55,23 @@
>   #define INA226_ALERT_LIMIT		0x07
>   #define INA226_DIE_ID			0xFF
>   
> +/* SY24655 register definitions */
> +#define SY24655_EIN				0x0A
> +#define SY24655_ACCUM_CONFIG	0x0D
> +
>   /* register count */
>   #define INA219_REGISTERS		6
>   #define INA226_REGISTERS		8
> +#define SY24655_REGISTERS		0x0D
>   
> -#define INA2XX_MAX_REGISTERS		8
> +#define INA2XX_MAX_REGISTERS		0x0D
>   
>   /* settings - depend on use case */
>   #define INA219_CONFIG_DEFAULT		0x399F	/* PGA=8 */
>   #define INA226_CONFIG_DEFAULT		0x4527	/* averages=16 */
> +#define SY24655_CONFIG_DEFAULT		0x4527	/* averages=16 */
> +/* (only for sy24655) */
> +#define SY24655_ACCUM_CONFIG_DEFAULT	0x044C
>   
>   /* worst case is 68.10 ms (~14.6Hz, ina219) */
>   #define INA2XX_CONVERSION_RATE		15
> @@ -103,7 +115,7 @@ static struct regmap_config ina2xx_regmap_config = {
>   	.val_bits = 16,
>   };
>   
> -enum ina2xx_ids { ina219, ina226 };
> +enum ina2xx_ids { ina219, ina226, sy24655};
>   
>   struct ina2xx_config {
>   	u16 config_default;
> @@ -117,12 +129,13 @@ struct ina2xx_config {
>   
>   struct ina2xx_data {
>   	const struct ina2xx_config *config;
> -
> +
>   	long rshunt;
>   	long current_lsb_uA;
>   	long power_lsb_uW;
>   	struct mutex config_lock;
>   	struct regmap *regmap;
> +	struct i2c_client *client;
>   
>   	const struct attribute_group *groups[INA2XX_MAX_ATTRIBUTE_GROUPS];
>   };
> @@ -146,6 +159,15 @@ static const struct ina2xx_config ina2xx_config[] = {
>   		.bus_voltage_lsb = 1250,
>   		.power_lsb_factor = 25,
>   	},
> +	[sy24655] = {
> +		.config_default = SY24655_CONFIG_DEFAULT,
> +		.calibration_value = 2048,
> +		.registers = SY24655_REGISTERS,
> +		.shunt_div = 400,
> +		.bus_voltage_shift = 0,
> +		.bus_voltage_lsb = 1250,
> +		.power_lsb_factor = 25,
> +	},
>   };
>   
>   /*
> @@ -216,6 +238,12 @@ static int ina2xx_init(struct ina2xx_data *data)
>   	return ina2xx_calibrate(data);
>   }
>   
> +static int sy24655_init(struct ina2xx_data *data)
> +{
> +	return regmap_write(data->regmap, SY24655_ACCUM_CONFIG,
> +				SY24655_ACCUM_CONFIG_DEFAULT);
> +}
> +
>   static int ina2xx_read_reg(struct device *dev, int reg, unsigned int *regval)
>   {
>   	struct ina2xx_data *data = dev_get_drvdata(dev);
> @@ -551,6 +579,48 @@ static ssize_t ina226_interval_show(struct device *dev,
>   	return sysfs_emit(buf, "%d\n", ina226_reg_to_interval(regval));
>   }
>   
> +static int sy24655_read_reg48(const struct i2c_client *client, u8 reg,
> +					long *accumulator_24, long *sample_count)
> +{
> +	u8 data[6];
> +	int err;
> +	*accumulator_24 = 0;
> +	*sample_count = 0;
> +
> +	/* 48-bit register read */
> +	err = i2c_smbus_read_i2c_block_data(client, reg, 6, data);
> +	if (err < 0)
> +		return err;
> +	if (err != 6)
> +		return -EIO;
> +	*accumulator_24 = ((data[3] << 16) |
> +				(data[4] << 8) |
> +				data[5]);
> +	*sample_count = ((data[0] << 16) |
> +				(data[1] << 8) |
> +				data[2]);
> +
> +	return 0;
> +}
> +
> +static ssize_t sy24655_avg_power_show(struct device *dev,
> +					struct device_attribute *da, char *buf)
> +{
> +	struct ina2xx_data *data = dev_get_drvdata(dev);
> +	long sample_count, accumulator_24, regval;
> +	int status;
> +
> +	status = sy24655_read_reg48(data->client, SY24655_EIN,
> +						&accumulator_24, &sample_count);
> +	if (status)
> +		return status;
> +	regval = DIV_ROUND_CLOSEST(accumulator_24, sample_count);

Since the sample count is not used anywhere else, it would make sense
to just read and return the average power in a single function. Also
make sure that sample_count isn't 0.

Note that this does not return the "average power from last reading
to the present" as claimed above unless bit 1 of ACCUM_CONFIG is set
to 0. Actually I am not sure what exactly it reports since the sample
count and the accumulator values will overflow at different times.
As far as I can see it returns a more or less random value after an
overflow.

Are you sure this provides any value as implemented ? I really don't see
what that value would be, especially since there is no means to account
for overflows.

> +	regval = regval * data->power_lsb_uW;
> +
> +
> +	return sysfs_emit(buf, "%li\n", regval);
> +}
> +
>   /* shunt voltage */
>   static SENSOR_DEVICE_ATTR_RO(in0_input, ina2xx_value, INA2XX_SHUNT_VOLTAGE);
>   /* shunt voltage over/under voltage alert setting and alarm */
> @@ -589,9 +659,13 @@ static SENSOR_DEVICE_ATTR_RO(power1_crit_alarm, ina226_alarm,
>   /* shunt resistance */
>   static SENSOR_DEVICE_ATTR_RW(shunt_resistor, ina2xx_shunt, INA2XX_CALIBRATION);
>   
> -/* update interval (ina226 only) */
> +/* update interval (ina226 and sy24655) */
>   static SENSOR_DEVICE_ATTR_RW(update_interval, ina226_interval, 0);
>   
> +/* calculate_avg_power (sy24655 only) */
> +static SENSOR_DEVICE_ATTR_RO(calculate_avg_power, sy24655_avg_power, 0);
> +
> +
>   /* pointers to created device attributes */
>   static struct attribute *ina2xx_attrs[] = {
>   	&sensor_dev_attr_in0_input.dev_attr.attr,
> @@ -624,6 +698,15 @@ static struct attribute *ina226_attrs[] = {
>   static const struct attribute_group ina226_group = {
>   	.attrs = ina226_attrs,
>   };
> +static struct attribute *sy24655_attrs[] = {
> +	&sensor_dev_attr_update_interval.dev_attr.attr,
> +	&sensor_dev_attr_calculate_avg_power.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group sy24655_group = {
> +	.attrs = sy24655_attrs,
> +};
>   
>   static int ina2xx_probe(struct i2c_client *client)
>   {
> @@ -641,6 +724,7 @@ static int ina2xx_probe(struct i2c_client *client)
>   		return -ENOMEM;
>   
>   	/* set the device type */
> +	data->client = client;
>   	data->config = &ina2xx_config[chip];
>   	mutex_init(&data->config_lock);
>   
> @@ -691,10 +775,17 @@ static int ina2xx_probe(struct i2c_client *client)
>   		dev_err(dev, "error configuring the device: %d\n", ret);
>   		return -ENODEV;
>   	}
> -
> +	if (chip == sy24655)
> +		ret = sy24655_init(data);
> +	if (ret < 0) {
> +		dev_err(dev, "error configuring the accum_reg: %d\n", ret);
> +		return -ENODEV;
> +	}
>   	data->groups[group++] = &ina2xx_group;
>   	if (chip == ina226)
>   		data->groups[group++] = &ina226_group;
> +	else if (chip == sy24655)
> +		data->groups[group++] = &sy24655_group;
>   
>   	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
>   							   data, data->groups);
> @@ -713,6 +804,7 @@ static const struct i2c_device_id ina2xx_id[] = {
>   	{ "ina226", ina226 },
>   	{ "ina230", ina226 },
>   	{ "ina231", ina226 },
> +	{ "sy24655", sy24655},
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(i2c, ina2xx_id);
> @@ -738,6 +830,10 @@ static const struct of_device_id __maybe_unused ina2xx_of_match[] = {
>   		.compatible = "ti,ina231",
>   		.data = (void *)ina226
>   	},
> +	{
> +		.compatible = "silergy,sy24655",
> +		.data = (void *)sy24655
> +	},
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(of, ina2xx_of_match);


