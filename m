Return-Path: <linux-kernel+bounces-234083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 261D391C1FB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10A2285EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D051C233D;
	Fri, 28 Jun 2024 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzLg2rvs"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875C73FD4;
	Fri, 28 Jun 2024 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586846; cv=none; b=SJ/eaHeVtpS/r5H+VPe+aRdrcIOcUj6ZjjXSTaNmdR3drKB8Bp8H0On+GkHsgPW3dynoM8xyfbTREz7D+PIqpCrKONU2gmbtpi9NefmJUQF7wzqIfD+mIW3z1+Ir5+wZvtqFInzKLrt7MGKMP9KCJEEXGlBRAHBy57dptxF9/dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586846; c=relaxed/simple;
	bh=TQ29WTOlgVz9lpnINbsm/k1ZvlJhZEBQuQgp385o7b0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNIN9hjEEtneCGCP0w7mndyg09ehS8Mjtnky5GLBuuWMtlg91WGd1EC4cGm0z1Z+PC2Abgm2NvXxb4l/5pPJex5grY935w/DGyot8ChmebLd07zBgCtHilN1b9xlWIKwIDaWJ+TFnL7LulTrLCJssjrzu4tp5YulS9PMe3BYIAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzLg2rvs; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70a078edb8aso43135b3a.1;
        Fri, 28 Jun 2024 08:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719586844; x=1720191644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=N0tTR9/3hvy36cl92DWUqcfr4tyVmjebr+2/8fWtMBw=;
        b=DzLg2rvsIJGg3b546pRMOeUESKRIWeIdjuYgaTgzKvLbeNjSDbXVWEBedjOfCVGRSg
         ePdD/87lf46FDgxyE7Shv1NBFDTFf6mwjoLZb/W5A56vR3hwNETV9gVf3yEbEglWMqTd
         0dYJckkG8lQOXjt+ALibx5XJhFeeyw5lHL8ScNxXkU03RnO7EkXRuxpEEolCTyCbkHdi
         5j9YzR0EyseEUvC7BRKrhM3BNJK/H0IcermD8Xubn7uIgmYMVe6ylvRi96XJdYLkr+vc
         ebcxC2L7tfv0MsmCwqVHdBJpf9rQD200xYKJiPMByRCC2EkxTtD0cvo5GTRxz9YVF/qb
         uqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586844; x=1720191644;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0tTR9/3hvy36cl92DWUqcfr4tyVmjebr+2/8fWtMBw=;
        b=a+KgznfAPNUp8buPqqt/dwZsTaSBrcc3bhTLHbvNHi2n5P5hrWnwIVAKMXY/q5OiXF
         sxTlnbk3NNLD6GIuy6jSCGmXo6ajPNeQfZQu4KCYughfKif0lcmZWZEIGnNe5PSh0dLD
         C4p0bmNHSz5cJEZLiy5xXPMPvsEB45AbIYpLisqKphX9FiHXeX7oAxSeqKfc33DuCVxB
         TZpPip3uxj0hIbr5y6I2tQmWimUs424ntr2L5fiVmARb1ApZtTsXKRZF7bbSN2Ooa2vg
         dojeOFDacDWrSHNe2W3P8DlfXEtcBxC/7Tudu+Dus5LBvJkGgoy3/qZKyGoNfTk12917
         pwCw==
X-Forwarded-Encrypted: i=1; AJvYcCWp0d4iN15xbhzdjM1b4SgGXzqwDOeWZSZp3b6ZiZCii+9wqb7x47C+t4/RcK2/TD79Iy7Yfq0DCPoAJ88WWW54Zf5N19kblwU4zc4=
X-Gm-Message-State: AOJu0Ywr0gVvrSNiyF5A0iBlbOmtn8h6w50ePSqEWlaoC3poYpg8XK/7
	eavengNqx9aKDVfYMHLL+Ta9RxlpOV0af+wbLpcJ7jzD7c1KqRyz
X-Google-Smtp-Source: AGHT+IH8xws64ncsO0bkCL4GLzc9PnU7m4nQ8NgeCFWicy8gEFvZtU0q1eMX6E6DZsYC3gJe4tun7A==
X-Received: by 2002:a05:6a00:3a97:b0:706:a97d:ca1c with SMTP id d2e1a72fcca58-70851875a26mr2720877b3a.6.1719586843567;
        Fri, 28 Jun 2024 08:00:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802464b18sm1703993b3a.45.2024.06.28.08.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 08:00:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <349543e5-21b2-4725-9b33-1fcb4ae124f6@roeck-us.net>
Date: Fri, 28 Jun 2024 08:00:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (max6639) : Add DT support
To: Naresh Solanki <naresh.solanki@9elements.com>,
 Jean Delvare <jdelvare@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20240628115451.4169902-1-naresh.solanki@9elements.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240628115451.4169902-1-naresh.solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/28/24 04:54, Naresh Solanki wrote:
> Remove platform data & add devicetree support.
> 

Unless I am missing something, this doesn't just add devicetree support,
it actually _mandates_ devicetree support. There are no defaults.
That is not acceptable.

More comments inline.

> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
>   drivers/hwmon/max6639.c               | 99 ++++++++++++++++++++-------
>   include/linux/platform_data/max6639.h | 15 ----
>   2 files changed, 73 insertions(+), 41 deletions(-)
>   delete mode 100644 include/linux/platform_data/max6639.h
> 
> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> index f54720d3d2ce..9ae7aecb0737 100644
> --- a/drivers/hwmon/max6639.c
> +++ b/drivers/hwmon/max6639.c
> @@ -19,7 +19,6 @@
>   #include <linux/hwmon-sysfs.h>
>   #include <linux/err.h>
>   #include <linux/mutex.h>
> -#include <linux/platform_data/max6639.h>
>   #include <linux/regmap.h>
>   #include <linux/util_macros.h>
>   
> @@ -81,6 +80,7 @@ struct max6639_data {
>   	/* Register values initialized only once */
>   	u8 ppr[MAX6639_NUM_CHANNELS];	/* Pulses per rotation 0..3 for 1..4 ppr */
>   	u8 rpm_range[MAX6639_NUM_CHANNELS]; /* Index in above rpm_ranges table */
> +	bool fan_enable[MAX6639_NUM_CHANNELS];
>   
>   	/* Optional regulator for FAN supply */
>   	struct regulator *reg;
> @@ -276,6 +276,11 @@ static int max6639_write_fan(struct device *dev, u32 attr, int channel,
>   
>   static umode_t max6639_fan_is_visible(const void *_data, u32 attr, int channel)
>   {
> +	struct max6639_data *data = (struct max6639_data *)_data;
> +
> +	if (!data->fan_enable[channel])
> +		return 0;
> +
>   	switch (attr) {
>   	case hwmon_fan_input:
>   	case hwmon_fan_fault:
> @@ -372,6 +377,11 @@ static int max6639_write_pwm(struct device *dev, u32 attr, int channel,
>   
>   static umode_t max6639_pwm_is_visible(const void *_data, u32 attr, int channel)
>   {
> +	struct max6639_data *data = (struct max6639_data *)_data;
> +
> +	if (!data->fan_enable[channel])
> +		return 0;
> +
>   	switch (attr) {
>   	case hwmon_pwm_input:
>   	case hwmon_pwm_freq:
> @@ -544,43 +554,85 @@ static int rpm_range_to_reg(int range)
>   	int i;
>   
>   	for (i = 0; i < ARRAY_SIZE(rpm_ranges); i++) {
> -		if (rpm_ranges[i] == range)
> +		if (range <= rpm_ranges[i])

What does this change have to do with adding devicetree support,
why is it done, and what is its impact ?

So far the assumption was that only valid values would be accepted by
the function, returning a default if there was no match. The incoming
data is from devicetree, where the range should be well defined and
accurate. With that in mind, I don't see the point of accepting values
outside the supported ranges.

Flexible data makes sense for sysfs attributes, where we can not
expect users to know acceptable values. For those, it is acceptable
and even desirable to find a closest match. However, that does not apply
to data obtained from devicetree.

>   			return i;
>   	}
>   
>   	return 1; /* default: 4000 RPM */
>   }
>   
> +static int max6639_probe_child_from_dt(struct i2c_client *client,
> +				       struct device_node *child,
> +				       struct max6639_data *data)
> +
> +{
> +	struct device *dev = &client->dev;
> +	u32 i, val;
> +	int err;
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
> +	data->fan_enable[i] = true;
> +
> +	err = of_property_read_u32(child, "pulses-per-revolution", &val);
> +
> +	if (!err) {
> +		if (val < 0 || val > 5) {

Accepting 0 seems wrong. Also, val is u32 and will never be < 0.

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
>   static int max6639_init_client(struct i2c_client *client,
>   			       struct max6639_data *data)
>   {
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
>   	/* Reset chip to default values, see below for GCONFIG setup */
>   	err = regmap_write(data->regmap, MAX6639_REG_GCONFIG, MAX6639_GCONFIG_POR);
>   	if (err)
>   		return err;
>   
> -	/* Fans pulse per revolution is 2 by default */
> -	if (max6639_info && max6639_info->ppr > 0 &&
> -			max6639_info->ppr < 5)
> -		ppr = max6639_info->ppr;
> -	else
> -		ppr = 2;
> -
> -	data->ppr[0] = ppr;
> -	data->ppr[1] = ppr;

As mentioned above, this may work for your use case, but it won't work
for existing users of this driver.

> +	for_each_child_of_node(np, child) {
> +		if (strcmp(child->name, "fan"))
> +			continue;
>   
> -	if (max6639_info)
> -		rpm_range = rpm_range_to_reg(max6639_info->rpm_range);
> -	data->rpm_range[0] = rpm_range;
> -	data->rpm_range[1] = rpm_range;
> +		err = max6639_probe_child_from_dt(client, child, data);
> +		if (err) {
> +			of_node_put(child);
> +			return err;
> +		}
> +	}
>   
>   	for (i = 0; i < MAX6639_NUM_CHANNELS; i++) {
> +		if (!data->fan_enable[i])
> +			err = regmap_set_bits(data->regmap, MAX6639_REG_OUTPUT_MASK, BIT(1 - i));
> +		else
> +			err = regmap_clear_bits(data->regmap, MAX6639_REG_OUTPUT_MASK, BIT(1 - i));
> +		if (err)
> +			return err;
> +
>   		/* Set Fan pulse per revolution */
>   		err = max6639_set_ppr(data, i, data->ppr[i]);
>   		if (err)
> @@ -593,12 +645,7 @@ static int max6639_init_client(struct i2c_client *client,
>   			return err;
>   
>   		/* Fans PWM polarity high by default */
> -		if (max6639_info) {
> -			if (max6639_info->pwm_polarity == 0)
> -				err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x00);
> -			else
> -				err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x02);
> -		}
> +		err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x00);
>   		if (err)
>   			return err;
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
> 
> base-commit: 52c1e818d66bfed276bd371f9e7947be4055af87


