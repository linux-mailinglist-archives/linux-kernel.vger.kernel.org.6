Return-Path: <linux-kernel+bounces-211826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823B290577F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B3328C234
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B71180A82;
	Wed, 12 Jun 2024 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ8JzIro"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C056916D4F6;
	Wed, 12 Jun 2024 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207750; cv=none; b=FXhLmkJbgfskhDWe4dDMoxkMcv5tdVrzGAgv8t7Eb3UCSaurcb+OS6H3S7D/vD0HQEwN36ZtlnET/WJwvK5AKWTSmVWLYdO3IJSx2Kv6uotOMFkELl1lJnc/9hBLqkUdllsPNdHqu4FZg7RwSmw9KQv/QAmW+swUQRIoRh0+NEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207750; c=relaxed/simple;
	bh=3AN54UJBTM6fui/ws4t28ck6nhTDvVemhsxYV9D4HzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtKcKI4u1um55sTrEP4xthYSFgVPmNOrn0dDppVbIdQy/F2BlqW89+zedZ+kPFB5NlH4/C+Dz2UsgIf7w6ctFYgxRUUKBxsUvXeFSVNTqjWISQl4ncJM7qDfOTrUbuMvxNWA1m0gA0UL/g9sjYUP5fuc2CHl/lodsO7nQvUXbus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQ8JzIro; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70413de08c7so1975275b3a.0;
        Wed, 12 Jun 2024 08:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718207748; x=1718812548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0kIyzFstLGE90DCKmV0K+mtFPsEhsKG2072ae1DrjxM=;
        b=PQ8JzIrovEJDcqfskMb2vTc+8Dy/gZtRf0XMAe0rqvU/Mxop6C+alkZBiVeSWkSgPx
         BWPSGWy+uR3KE+lDXaU5EvL4LccRUlUsQ+X6nb5D0aPDK9r2M36+ohMcDpXbOHs/eXrj
         iqJ1J8jC6Jdi9KgUkb6+0MmIKOebvupePyXi/IugNBnROW6FziELPsw1N8asVxktPco5
         EbenfMQZUKO87hd2tfwJRyxSohVbE0geYDEc3npVCs1TafZONbl4kjDrDBP/8uTbeEns
         Y1IK9K0Fju2brwZ+o7AaL3Ayef1A72wQjE6xCFKzuVToMj7rIRGclHKHgN3yVyQFXgTT
         6dXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718207748; x=1718812548;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kIyzFstLGE90DCKmV0K+mtFPsEhsKG2072ae1DrjxM=;
        b=vlsBEU0ozZE4UkhfZwcOZrhWon43aSONwNJuqHqc9e2z4U/7oTY3UMFte45vr1ZM5t
         KL37bMp3yzUJB+qwm9GsTwEJRIOggBlBnxeFZy4QLPAZ6pztRKAJUZ2CytugVrCblmO0
         IrApeYPibhhd7RThJ7Q8O+g1eFLmAT4SSuJqrphGgU3uHV6m7cstfdXXPs4FJU98swUy
         u74E6TAyX4osbAIJxCAkAbHWfbGr7lcUIwCj8YL8/s50DQwXhObU12mEYk1JIjY6aPS+
         hlK3Hz2wnsy5O0/2/eTiQenMWunlLtKa+ZpYbMMYooVhZtaKjDVi1K/ph/ER6DWp7DL9
         RzzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMwfCWIZrBEyLcU8yKkqMUlQzF29ph0ZHoOYEKUTrW6TWD1mkoRHF0ACgdApyefD4M+VXByWxXYFyYRUYr7Z0hJfn6Q+OrRaZQXtek
X-Gm-Message-State: AOJu0YxLpVqZ5I7ZsvKXBdohrH1ob2vIZbhhpydxs9PltTf6AJlwyt4z
	FosQzpGu/dXPC4z2QhHl0A3DmoU0uMBsBtvoCK+qcARuiRQ3VL5L
X-Google-Smtp-Source: AGHT+IESR5fLeB+44aXd6oO481kCIJYTRrg9U7Q7jXM+xKrwo6Ms3s52a9+iBkBuo0pn5XK3sLzjow==
X-Received: by 2002:a05:6a00:2e1a:b0:705:c310:60be with SMTP id d2e1a72fcca58-705c3106251mr1338855b3a.13.1718207747847;
        Wed, 12 Jun 2024 08:55:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de212bdbf9sm8896238a12.28.2024.06.12.08.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 08:55:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3bd9a52e-bfca-4ac2-af48-59772de8b61e@roeck-us.net>
Date: Wed, 12 Jun 2024 08:55:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] hwmon: (max6639) : Add hwmon attributes for fan
 and pwm
To: Naresh Solanki <naresh.solanki@9elements.com>,
 Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240604124742.4093334-1-naresh.solanki@9elements.com>
 <20240604124742.4093334-2-naresh.solanki@9elements.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240604124742.4093334-2-naresh.solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/24 05:47, Naresh Solanki wrote:
> Add attribute for fan & pwm i.e.,
> fanY_pulse
> pwmY_freq
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
>   drivers/hwmon/max6639.c | 74 ++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 70 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> index e2a5210f9f95..6c7eaeeb2a80 100644
> --- a/drivers/hwmon/max6639.c
> +++ b/drivers/hwmon/max6639.c
> @@ -235,6 +235,9 @@ static int max6639_read_fan(struct device *dev, u32 attr, int channel,
>   			return res;
>   		*fan_val = !!(val & BIT(1 - channel));
>   		return 0;
> +	case hwmon_fan_pulses:
> +		*fan_val = data->ppr[channel];
> +		return 0;
>   	default:
>   		return -EOPNOTSUPP;
>   	}
> @@ -246,6 +249,32 @@ static int max6639_set_ppr(struct max6639_data *data, int channel, u8 ppr)
>   	return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), ppr-- << 6);
>   }
>   
> +static int max6639_write_fan(struct device *dev, u32 attr, int channel,
> +			     long val)
> +{
> +	struct max6639_data *data = dev_get_drvdata(dev);
> +	int err;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +

Unnecessary check.

> +	switch (attr) {
> +	case hwmon_fan_pulses:
> +		if (val <= 0 || val > 5)
> +			return -EINVAL;
> +
> +		/* Set Fan pulse per revolution */
> +		err = max6639_set_ppr(data, channel, val);
> +		if (err < 0)
> +			return err;
> +
> +		data->ppr[channel] = val;

Needs mutex protection to avoid inconsistencies due to concurrent writes.

> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
>   static umode_t max6639_fan_is_visible(const void *_data, u32 attr, int channel)
>   {
>   	struct max6639_data *data = (struct max6639_data *)_data;
> @@ -270,6 +299,7 @@ static int max6639_read_pwm(struct device *dev, u32 attr, int channel,
>   	struct max6639_data *data = dev_get_drvdata(dev);
>   	unsigned int val;
>   	int res;
> +	u8 i;
>   
>   	if (IS_ERR(data))
>   		return PTR_ERR(data);
> @@ -281,6 +311,21 @@ static int max6639_read_pwm(struct device *dev, u32 attr, int channel,
>   			return res;
>   		*pwm_val = val * 255 / 120;
>   		return 0;
> +	case hwmon_pwm_freq:
> +		res = regmap_read(data->regmap, MAX6639_REG_FAN_CONFIG3(channel), &val);
> +		if (res < 0)
> +			return res;
> +		i = val & MAX6639_FAN_CONFIG3_FREQ_MASK;
> +
> +		res = regmap_read(data->regmap, MAX6639_REG_GCONFIG, &val);
> +		if (res < 0)
> +			return res;
> +
> +		if (val & MAX6639_GCONFIG_PWM_FREQ_HI)
> +			i |= 0x4;

This sequence will need to be mutex protected to avoid consistency errors if
a write happens at the same time.


> +		i &= 0x7;
> +		*pwm_val = freq_table[i];
> +		return 0;
>   	default:
>   		return -EOPNOTSUPP;
>   	}
> @@ -291,6 +336,7 @@ static int max6639_write_pwm(struct device *dev, u32 attr, int channel,
>   {
>   	struct max6639_data *data = dev_get_drvdata(dev);
>   	int err;
> +	u8 i;
>   
>   	if (IS_ERR(data))
>   		return PTR_ERR(data);
> @@ -301,6 +347,23 @@ static int max6639_write_pwm(struct device *dev, u32 attr, int channel,
>   		err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(channel),
>   				   val * 120 / 255);
>   		return err;
> +	case hwmon_pwm_freq:
> +		val = clamp_val(val, 0, 25000);
> +
> +		i = find_closest(val, freq_table, ARRAY_SIZE(freq_table));
> +
> +		err = regmap_update_bits(data->regmap, MAX6639_REG_FAN_CONFIG3(channel),
> +					 MAX6639_FAN_CONFIG3_FREQ_MASK, i);
> +		if (err < 0)
> +			return err;
> +
> +		if (i >> 2)
> +			err = regmap_set_bits(data->regmap, MAX6639_REG_GCONFIG,
> +					      MAX6639_GCONFIG_PWM_FREQ_HI);
> +		else
> +			err = regmap_clear_bits(data->regmap, MAX6639_REG_GCONFIG,
> +						MAX6639_GCONFIG_PWM_FREQ_HI);

Same as above. In general, every operation with more than a single element
needs to be mutex protected.

> +		return err;
>   	default:
>   		return -EOPNOTSUPP;
>   	}
> @@ -310,6 +373,7 @@ static umode_t max6639_pwm_is_visible(const void *_data, u32 attr, int channel)
>   {
>   	switch (attr) {
>   	case hwmon_pwm_input:
> +	case hwmon_pwm_freq:
>   		return 0644;
>   	default:
>   		return 0;
> @@ -415,6 +479,8 @@ static int max6639_write(struct device *dev, enum hwmon_sensor_types type,
>   			 u32 attr, int channel, long val)
>   {
>   	switch (type) {
> +	case hwmon_fan:
> +		return max6639_write_fan(dev, attr, channel, val);
>   	case hwmon_pwm:
>   		return max6639_write_pwm(dev, attr, channel, val);
>   	case hwmon_temp:
> @@ -442,11 +508,11 @@ static umode_t max6639_is_visible(const void *data,
>   
>   static const struct hwmon_channel_info * const max6639_info[] = {
>   	HWMON_CHANNEL_INFO(fan,
> -			   HWMON_F_INPUT | HWMON_F_FAULT,
> -			   HWMON_F_INPUT | HWMON_F_FAULT),
> +			   HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_PULSES,
> +			   HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_PULSES),
>   	HWMON_CHANNEL_INFO(pwm,
> -			   HWMON_PWM_INPUT,
> -			   HWMON_PWM_INPUT),
> +			   HWMON_PWM_INPUT | HWMON_PWM_FREQ,
> +			   HWMON_PWM_INPUT | HWMON_PWM_FREQ),
>   	HWMON_CHANNEL_INFO(temp,
>   			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_MAX | HWMON_T_MAX_ALARM |
>   			   HWMON_T_CRIT | HWMON_T_CRIT_ALARM | HWMON_T_EMERGENCY |


