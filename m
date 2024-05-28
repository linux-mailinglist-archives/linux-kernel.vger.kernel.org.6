Return-Path: <linux-kernel+bounces-192545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFB78D1EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1FE1C22640
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCE416FF29;
	Tue, 28 May 2024 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrLm5S24"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9BC16F27E;
	Tue, 28 May 2024 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906891; cv=none; b=hMj5eLLDNw9E1hRSTY8wiTGkjuYLF8o30SwmQZXTl5E9jVIfXLBoVCWlZsbFyHFnAhBKrGN1QFEmBGyKmXjMqCLb1BnuSRq4poS2K7y0DCajMTkKV8VJ8oHtAai25iXzFAZmNjKW58scKr9/fNfXHiDfgO9n109KQSBe5Qp9PS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906891; c=relaxed/simple;
	bh=kKIH+1fmY3Q16vrWVECYq6vJOwUzw3R7Et7M5JTgK6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPH4ZGAyD1gj/2GOq8bolBJHDXwmg/xhpUSW1Rfnem7XPai8/geEPEaVOkg2A+rMJbutMfFleSk4JNQOYv0QoJWfKA34O4EphptRA4/ET3tPBkPrnl3pQRtHcHKRsgfvBe9BVYSEPqbVVs/hfj6qUWfrsH8eMnhOgi4BRvCTDzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrLm5S24; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-681bee6bb13so2695338a12.1;
        Tue, 28 May 2024 07:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716906888; x=1717511688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jecoQKusyKPvpK2n5tbKJlOIZe3UBWbH2RhEs4u6N+I=;
        b=VrLm5S242BnCC1Vjxde7aPwJcx+GYB0QogZCkMUbKlE3C+MtDhA+yt8e66j9IeOO8j
         QdGzx6Rfh4Y6BYVp+6KziCGtrcMAQvCUiXVfbJGEyymzEP/EopTJGzYh8OY6EQX4+PUG
         9Zi2fIKVhfxBwd5qlN3ulDRInn7ox+xU1OgscEcK7e3FqkZxk1h8OkT5RCVuCY9KKQBi
         tXdPUyq4iYL7qhPms5rHfY1MrzQfObuDaaMbrnDC8XPMujCQUpo7rQl8QDfK8FsYBeq0
         meEOJzpxiAjup5YuxZ9iKTxgFaQV4mmgiLRFCouku7+mZbx9iBwbqezqxcxeIRVltlaS
         /fPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716906888; x=1717511688;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jecoQKusyKPvpK2n5tbKJlOIZe3UBWbH2RhEs4u6N+I=;
        b=MRrwCP000sgij8czQgmAAdz+56nsCsKl3e7tEGfcM3O/5mUS8qsAmvKADSgsRgZSm4
         bNcHiYcWkFKC5G7q3Q1OOagFQDC3AvdUkL7eHvRH4f2sBcwQ7N9qWT/KKX/O+UhYIwmJ
         /34HyOEUh31GE3DzNcKEdwsPdHAlZrsALym0fdGafYbmjGjHBi4FO9ePmFvLbd6fxXVL
         e5MPYDRQTPOV+mahwW/XysPGVMJHsXqII/BctEKzs4OMfn9iNeT0MNQ3fhvA89qJAmqU
         2Z/hy9eNCac2u07ZvhUJawPRG3e1gocYO3GGn2OfKEYK4HwPhlDVVSh3FNHhisBZu4bR
         +STg==
X-Forwarded-Encrypted: i=1; AJvYcCWnoP9qcGTq+6LV9UL/+HPy7e5moXSaQB9DA+/fsR0OWPzbcUCusAkn8D2AaKGGlxlRKOor5r009Sv/aWxHwxs/wmq22NsfitlVEfLs
X-Gm-Message-State: AOJu0YynYAVeoDh3eKIoxQGDeltGz9TXyxsJdNrJijg1ECoGbZldg68O
	9+0e35lGy3glMUjplv9I1lQiH8IuxGyNLP3ES4X1MkMPiMFYu7RFLWz2Fg==
X-Google-Smtp-Source: AGHT+IH2xKQvughtCse+68R67w2X5WS8RdvhdvWNg1TPTg9eZxTICyAEEml3XZDGgRWhG50/DAHJuw==
X-Received: by 2002:a17:90a:3d01:b0:2b0:763b:370e with SMTP id 98e67ed59e1d1-2bddcf04389mr21250363a91.18.1716906888046;
        Tue, 28 May 2024 07:34:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf9ca967f9sm5611688a91.9.2024.05.28.07.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 07:34:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4d4946d6-58f9-4f64-b860-a60dd08a2d62@roeck-us.net>
Date: Tue, 28 May 2024 07:34:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: (max6639) : Update hwmon init using info
To: Naresh Solanki <naresh.solanki@9elements.com>,
 Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240528091808.863702-1-naresh.solanki@9elements.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240528091808.863702-1-naresh.solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/24 02:18, Naresh Solanki wrote:
> Update hwmon init with info instead of group.

A more detailed description which doesn't require insider knowledge
would be helpful.

> Also added additional attribute for fan i.e.,
> fanY_pulse
> pwmY_freq

Separate patches for additional attributes, please.

> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
>   drivers/hwmon/max6639.c | 536 ++++++++++++++++++++++++++--------------
>   1 file changed, 357 insertions(+), 179 deletions(-)
> 
> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> index cbb595fe47aa..b757a85837e8 100644
> --- a/drivers/hwmon/max6639.c
> +++ b/drivers/hwmon/max6639.c
> @@ -55,13 +55,17 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
>   #define MAX6639_GCONFIG_PWM_FREQ_HI		0x08
>   
>   #define MAX6639_FAN_CONFIG1_PWM			0x80
> -
> +#define MAX6639_FAN_CONFIG3_FREQ_MASK		0x03
>   #define MAX6639_FAN_CONFIG3_THERM_FULL_SPEED	0x40
>   
>   #define MAX6639_NUM_CHANNELS			2
>   
>   static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
>   
> +/* Supported PWM frequency */
> +static const unsigned int freq_table[] = { 20, 33, 50, 100, 5000, 8333, 12500,
> +					   25000 };
> +
>   #define FAN_FROM_REG(val, rpm_range)	((val) == 0 || (val) == 255 ? \
>   				0 : (rpm_ranges[rpm_range] * 30) / (val))
>   #define TEMP_LIMIT_TO_REG(val)	clamp_val((val) / 1000, 0, 255)
> @@ -73,19 +77,16 @@ struct max6639_data {
>   	struct regmap *regmap;
>   
>   	/* Register values initialized only once */
> -	u8 ppr;			/* Pulses per rotation 0..3 for 1..4 ppr */
> -	u8 rpm_range;		/* Index in above rpm_ranges table */
> +	u8 ppr[MAX6639_NUM_CHANNELS];	/* Pulses per rotation 0..3 for 1..4 ppr */
> +	u8 rpm_range[MAX6639_NUM_CHANNELS]; /* Index in above rpm_ranges table */
>   
>   	/* Optional regulator for FAN supply */
>   	struct regulator *reg;
>   };
>   
> -static ssize_t temp_input_show(struct device *dev,
> -			       struct device_attribute *dev_attr, char *buf)
> +static int max6639_temp_read_input(struct device *dev, int channel, long *temp)
>   {
> -	long temp;
>   	struct max6639_data *data = dev_get_drvdata(dev);
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
>   	unsigned int val;
>   	int res;
>   
> @@ -93,251 +94,425 @@ static ssize_t temp_input_show(struct device *dev,
>   	 * Lock isn't needed as MAX6639_REG_TEMP wpnt change for at least 250ms after reading
>   	 * MAX6639_REG_TEMP_EXT
>   	 */
> -	res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(attr->index), &val);
> +	res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(channel), &val);
>   	if (res < 0)
>   		return res;
>   
> -	temp = val >> 5;
> -	res = regmap_read(data->regmap, MAX6639_REG_TEMP(attr->index), &val);
> +	*temp = val >> 5;
> +	res = regmap_read(data->regmap, MAX6639_REG_TEMP(channel), &val);
>   	if (res < 0)
>   		return res;
>   
> -	temp |= val << 3;
> -	temp *= 125;
> +	*temp |= val << 3;
> +	*temp *= 125;
>   
> -	return sprintf(buf, "%ld\n", temp);
> +	return res;

	return 0;

because res is known to be 0 here.

>   }
>   
> -static ssize_t temp_fault_show(struct device *dev,
> -			       struct device_attribute *dev_attr, char *buf)
> +static int max6639_temp_read_fault(struct device *dev, int channel, long *fault)
>   {
>   	struct max6639_data *data = dev_get_drvdata(dev);
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
>   	unsigned int val;
>   	int res;
>   
> -	res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(attr->index), &val);
> -	if (res < 0)
> -		return res;
> +	res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(channel), &val);

Please always handle errors first before assigning results, as implemented in
max6639_temp_read_input().

	if (res < 0)
		return res;

	*fault = val & 1;

	return 0;

> +	*fault = val & 1;
>   
> -	return sprintf(buf, "%d\n", val & 1);
> +	return res;
>   }
>   
> -static ssize_t temp_max_show(struct device *dev,
> -			     struct device_attribute *dev_attr, char *buf)
> +static int max6639_temp_read_max(struct device *dev, int channel, long *max)
>   {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
>   	struct max6639_data *data = dev_get_drvdata(dev);
>   	unsigned int val;
>   	int res;
>   
> -	res = regmap_read(data->regmap, MAX6639_REG_THERM_LIMIT(attr->index), &val);
> -	if (res < 0)
> -		return res;
> +	res = regmap_read(data->regmap, MAX6639_REG_THERM_LIMIT(channel), &val);
> +	*max = val * 1000;
>   
> -	return sprintf(buf, "%d\n", (val * 1000));
> +	return res;
>   }
>   
> -static ssize_t temp_max_store(struct device *dev,
> -			      struct device_attribute *dev_attr,
> -			      const char *buf, size_t count)
> +static int max6639_temp_read_crit(struct device *dev, int channel, long *crit)
>   {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
>   	struct max6639_data *data = dev_get_drvdata(dev);
> -	unsigned long val;
> +	unsigned int val;
>   	int res;
>   
> -	res = kstrtoul(buf, 10, &val);
> -	if (res)
> -		return res;
> +	res = regmap_read(data->regmap, MAX6639_REG_ALERT_LIMIT(channel), &val);
> +	*crit = val * 1000;
>   
> -	regmap_write(data->regmap, MAX6639_REG_THERM_LIMIT(attr->index),
> -		     TEMP_LIMIT_TO_REG(val));
> -	return count;
> +	return res;
>   }
>   
> -static ssize_t temp_crit_show(struct device *dev,
> -			      struct device_attribute *dev_attr, char *buf)
> +static int max6639_temp_read_emergency(struct device *dev, int channel, long *emerg)
>   {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
>   	struct max6639_data *data = dev_get_drvdata(dev);
>   	unsigned int val;
>   	int res;
>   
> -	res = regmap_read(data->regmap, MAX6639_REG_ALERT_LIMIT(attr->index), &val);
> -	if (res < 0)
> -		return res;
> +	res = regmap_read(data->regmap, MAX6639_REG_OT_LIMIT(channel), &val);
> +	*emerg = val * 1000;
>   
> -	return sprintf(buf, "%d\n", (val * 1000));
> +	return res;
>   }
>   
> -static ssize_t temp_crit_store(struct device *dev,
> -			       struct device_attribute *dev_attr,
> -			       const char *buf, size_t count)
> +static int max6639_get_status(struct device *dev, unsigned int *status)
>   {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
>   	struct max6639_data *data = dev_get_drvdata(dev);
> -	unsigned long val;
> +	unsigned int val;
>   	int res;
>   
> -	res = kstrtoul(buf, 10, &val);
> -	if (res)
> -		return res;
> +	res = regmap_read(data->regmap, MAX6639_REG_STATUS, &val);
> +	*status = val;
>   
> -	regmap_write(data->regmap, MAX6639_REG_ALERT_LIMIT(attr->index),
> -		     TEMP_LIMIT_TO_REG(val));
> -	return count;
> +	return res;
>   }
>   
> -static ssize_t temp_emergency_show(struct device *dev,
> -				   struct device_attribute *dev_attr,
> -				   char *buf)
> +static int max6639_temp_set_max(struct max6639_data *data, int channel, unsigned long val)
>   {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> -	struct max6639_data *data = dev_get_drvdata(dev);
> -	unsigned int val;
>   	int res;
>   
> -	res = regmap_read(data->regmap, MAX6639_REG_OT_LIMIT(attr->index), &val);
> -	if (res < 0)
> -		return res;
> -
> -	return sprintf(buf, "%d\n", (val * 1000));
> +	res = regmap_write(data->regmap, MAX6639_REG_THERM_LIMIT(channel),
> +			   TEMP_LIMIT_TO_REG(val));
> +	return res;
>   }
>   
> -static ssize_t temp_emergency_store(struct device *dev,
> -				    struct device_attribute *dev_attr,
> -				    const char *buf, size_t count)
> +static int max6639_temp_set_crit(struct max6639_data *data, int channel, unsigned long val)
>   {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> -	struct max6639_data *data = dev_get_drvdata(dev);
> -	unsigned long val;
>   	int res;
>   
> -	res = kstrtoul(buf, 10, &val);
> -	if (res)
> -		return res;
> +	res = regmap_write(data->regmap, MAX6639_REG_ALERT_LIMIT(channel), TEMP_LIMIT_TO_REG(val));
> +
> +	return res;
> +}
> +
> +static int max6639_temp_set_emergency(struct max6639_data *data, int channel, unsigned long val)
> +{
> +	int res;
>   
> -	regmap_write(data->regmap, MAX6639_REG_OT_LIMIT(attr->index), TEMP_LIMIT_TO_REG(val));
> +	res = regmap_write(data->regmap, MAX6639_REG_OT_LIMIT(channel), TEMP_LIMIT_TO_REG(val));
>   
> -	return count;
> +	return res;
>   }
>   
> -static ssize_t pwm_show(struct device *dev, struct device_attribute *dev_attr,
> -			char *buf)
> +static int max6639_read_fan(struct device *dev, u32 attr, int channel,
> +			    long *fan_val)
>   {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
>   	struct max6639_data *data = dev_get_drvdata(dev);
> -	unsigned int val;
> -	int res;
> +	unsigned int val, res;
>   
> -	res = regmap_read(data->regmap, MAX6639_REG_TARGTDUTY(attr->index), &val);
> -	if (res < 0)
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	switch (attr) {
> +	case hwmon_fan_input:
> +		res = regmap_read(data->regmap, MAX6639_REG_FAN_CNT(channel), &val);
> +		*fan_val = FAN_FROM_REG(val, data->rpm_range[channel]);
> +		return res;
> +	case hwmon_fan_fault:
> +		res = max6639_get_status(dev, &val);
> +		*fan_val = !!(val & (2 >> channel));

				!!BIT(1 - channel)

in these cases might be easier to read than the shifts.

>   		return res;
> +	case hwmon_fan_pulses:
> +		*fan_val = data->ppr[channel];
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
>   
> -	return sprintf(buf, "%d\n", val * 255 / 120);
> +static int max6639_set_ppr(struct max6639_data *data, int channel, u8 ppr)
> +{
> +	return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), ppr-- << 6);

The -- here is confusing. I thoink it would be better to handle it in the calling code.

>   }
>   
> -static ssize_t pwm_store(struct device *dev,
> -			 struct device_attribute *dev_attr, const char *buf,
> -			 size_t count)
> +static int max6639_write_fan(struct device *dev, u32 attr, int channel,
> +			     long val)
>   {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
>   	struct max6639_data *data = dev_get_drvdata(dev);
> -	unsigned long val;
> -	int res;
> +	int err;
>   
> -	res = kstrtoul(buf, 10, &val);
> -	if (res)
> -		return res;
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	switch (attr) {
> +	case hwmon_fan_pulses:
> +		if (val <= 0 || val > 5) {
> +			dev_err(dev, "invalid pulses-per-revolution %ld. Valid range id 1 - 4.",
> +				val);

No such error messages as result to user input, please.

> +			return -EINVAL;
> +		}
> +		/* Set Fan pulse per revolution */
> +		err = max6639_set_ppr(data, channel, val);
> +		if (err)
> +			dev_err(dev, "Failed to set pulses-per-revolution");

If this is an error, return it.

> +		else
> +			data->ppr[channel] = val;
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
>   
> -	val = clamp_val(val, 0, 255);
> +static umode_t max6639_fan_is_visible(const void *_data, u32 attr, int channel)
> +{
> +	struct max6639_data *data = (struct max6639_data *)_data;
>   
> -	regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(attr->index), val * 120 / 255);
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
>   
> -	return count;
> +	switch (attr) {
> +	case hwmon_fan_input:
> +	case hwmon_fan_fault:
> +		return 0444;
> +	case hwmon_fan_pulses:
> +		return 0644;
> +	default:
> +		return 0;
> +	}
>   }
>   
> -static ssize_t fan_input_show(struct device *dev,
> -			      struct device_attribute *dev_attr, char *buf)
> +static int max6639_read_pwm(struct device *dev, u32 attr, int channel,
> +			    long *pwm_val)
>   {
>   	struct max6639_data *data = dev_get_drvdata(dev);
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> -	unsigned int val;
> -	int res;
> -
> -	res = regmap_read(data->regmap, MAX6639_REG_FAN_CNT(attr->index), &val);
> -	if (res < 0)
> +	unsigned int val, res;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	switch (attr) {
> +	case hwmon_pwm_input:
> +		res = regmap_read(data->regmap, MAX6639_REG_TARGTDUTY(channel), &val);
> +		*pwm_val = val * 255 / 120;
> +		return 0;
> +	case hwmon_pwm_freq:
> +		u8 x;
> +

Please avoid.

> +		res = regmap_read(data->regmap, MAX6639_REG_FAN_CONFIG3(channel), &val);
> +		if (res < 0)
> +			return res;
> +		x = val & MAX6639_FAN_CONFIG3_FREQ_MASK;
> +
> +		res = regmap_read(data->regmap, MAX6639_REG_GCONFIG, &val);
> +		if (res < 0)
> +			return res;
> +
> +		if (val & MAX6639_GCONFIG_PWM_FREQ_HI)
> +			x |= 0x4;
> +		x &= 0x7;
> +		*pwm_val = freq_table[x];
>   		return res;
> -
> -	return sprintf(buf, "%d\n", FAN_FROM_REG(val, data->rpm_range));
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>   }
>   
> -static ssize_t alarm_show(struct device *dev,
> -			  struct device_attribute *dev_attr, char *buf)
> +static int max6639_write_pwm(struct device *dev, u32 attr, int channel,
> +			     long val)
>   {
>   	struct max6639_data *data = dev_get_drvdata(dev);
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> -	unsigned int val;
> +	int err;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	switch (attr) {
> +	case hwmon_pwm_input:
> +		val = clamp_val(val, 0, 255);
> +		err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(channel),
> +				   val * 120 / 255);
> +		return err;
> +	case hwmon_pwm_freq:
> +		u8 x;
> +
> +		val = clamp_val(val, 0, 25000);
> +		/* Chip supports limited number of frequency */

frequencies, but the comment is really not necessary.

> +		for (x = 0; x < sizeof(freq_table); x++)
> +			if (val <= freq_table[x])
> +				break;
> +

Use find_closest()

> +		err = regmap_update_bits(data->regmap, MAX6639_REG_FAN_CONFIG3(channel),
> +					 MAX6639_FAN_CONFIG3_FREQ_MASK, x);
> +		if (err < 0)
> +			return err;
> +
> +		if (x >> 2)
> +			err = regmap_set_bits(data->regmap, MAX6639_REG_GCONFIG,
> +					      MAX6639_GCONFIG_PWM_FREQ_HI);
> +		else
> +			err = regmap_clear_bits(data->regmap, MAX6639_REG_GCONFIG,
> +						MAX6639_GCONFIG_PWM_FREQ_HI);
> +		return err;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static umode_t max6639_pwm_is_visible(const void *_data, u32 attr, int channel)
> +{
> +	struct max6639_data *data = (struct max6639_data *)_data;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);

Pointless assignment and check. The parameter isn't used.

> +
> +	switch (attr) {
> +	case hwmon_pwm_input:
> +	case hwmon_pwm_freq:
> +		return 0644;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int max6639_read_temp(struct device *dev, u32 attr, int channel,
> +			     long *val)
> +{
> +	unsigned int status;
>   	int res;
>   
> -	res = regmap_read(data->regmap, MAX6639_REG_STATUS, &val);
> -	if (res < 0)
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		res = max6639_temp_read_input(dev, channel, val);
> +		return res;
> +	case hwmon_temp_fault:
> +		res = max6639_temp_read_fault(dev, channel, val);
>   		return res;
> +	case hwmon_temp_max:
> +		res = max6639_temp_read_max(dev, channel, val);
> +		return res;
> +	case hwmon_temp_crit:
> +		res = max6639_temp_read_crit(dev, channel, val);
> +		return res;
> +	case hwmon_temp_emergency:
> +		res = max6639_temp_read_emergency(dev, channel, val);
> +		return res;
> +	case hwmon_temp_max_alarm:
> +		res = max6639_get_status(dev, &status);
> +		*val = !!(status & (0x08 >> channel));

					BIT(3 - channel) ?

> +		return res;
> +	case hwmon_temp_crit_alarm:
> +		res = max6639_get_status(dev, &status);
> +		*val = !!(status & (0x80 >> channel));
> +		return res;
> +	case hwmon_temp_emergency_alarm:
> +		res = max6639_get_status(dev, &status);
> +		*val = !!(status & (0x20 >> channel));
> +		return res;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int max6639_write_temp(struct device *dev, u32 attr, int channel,
> +			      long val)
> +{
> +	struct max6639_data *data = dev_get_drvdata(dev);
> +
> +	switch (attr) {
> +	case hwmon_temp_max:
> +		return max6639_temp_set_max(data, channel, val);
> +	case hwmon_temp_crit:
> +		return max6639_temp_set_crit(data, channel, val);
> +	case hwmon_temp_emergency:
> +		return max6639_temp_set_emergency(data, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static umode_t max6639_temp_is_visible(const void *_data, u32 attr, int channel)
> +{
> +	switch (attr) {
> +	case hwmon_temp_input:
> +	case hwmon_temp_fault:
> +	case hwmon_temp_max_alarm:
> +	case hwmon_temp_crit_alarm:
> +	case hwmon_temp_emergency_alarm:
> +		return 0444;
> +	case hwmon_temp_max:
> +	case hwmon_temp_crit:
> +	case hwmon_temp_emergency:
> +		return 0644;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int max6639_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *val)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		return max6639_read_fan(dev, attr, channel, val);
> +	case hwmon_pwm:
> +		return max6639_read_pwm(dev, attr, channel, val);
> +	case hwmon_temp:
> +		return max6639_read_temp(dev, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
>   
> -	return sprintf(buf, "%d\n", !!(val & (1 << attr->index)));
> +static int max6639_write(struct device *dev, enum hwmon_sensor_types type,
> +			 u32 attr, int channel, long val)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		return max6639_write_fan(dev, attr, channel, val);
> +	case hwmon_pwm:
> +		return max6639_write_pwm(dev, attr, channel, val);
> +	case hwmon_temp:
> +		return max6639_write_temp(dev, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>   }
>   
> -static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
> -static SENSOR_DEVICE_ATTR_RO(temp2_input, temp_input, 1);
> -static SENSOR_DEVICE_ATTR_RO(temp1_fault, temp_fault, 0);
> -static SENSOR_DEVICE_ATTR_RO(temp2_fault, temp_fault, 1);
> -static SENSOR_DEVICE_ATTR_RW(temp1_max, temp_max, 0);
> -static SENSOR_DEVICE_ATTR_RW(temp2_max, temp_max, 1);
> -static SENSOR_DEVICE_ATTR_RW(temp1_crit, temp_crit, 0);
> -static SENSOR_DEVICE_ATTR_RW(temp2_crit, temp_crit, 1);
> -static SENSOR_DEVICE_ATTR_RW(temp1_emergency, temp_emergency, 0);
> -static SENSOR_DEVICE_ATTR_RW(temp2_emergency, temp_emergency, 1);
> -static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
> -static SENSOR_DEVICE_ATTR_RW(pwm2, pwm, 1);
> -static SENSOR_DEVICE_ATTR_RO(fan1_input, fan_input, 0);
> -static SENSOR_DEVICE_ATTR_RO(fan2_input, fan_input, 1);
> -static SENSOR_DEVICE_ATTR_RO(fan1_fault, alarm, 1);
> -static SENSOR_DEVICE_ATTR_RO(fan2_fault, alarm, 0);
> -static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, alarm, 3);
> -static SENSOR_DEVICE_ATTR_RO(temp2_max_alarm, alarm, 2);
> -static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, alarm, 7);
> -static SENSOR_DEVICE_ATTR_RO(temp2_crit_alarm, alarm, 6);
> -static SENSOR_DEVICE_ATTR_RO(temp1_emergency_alarm, alarm, 5);
> -static SENSOR_DEVICE_ATTR_RO(temp2_emergency_alarm, alarm, 4);
> -
> -
> -static struct attribute *max6639_attrs[] = {
> -	&sensor_dev_attr_temp1_input.dev_attr.attr,
> -	&sensor_dev_attr_temp2_input.dev_attr.attr,
> -	&sensor_dev_attr_temp1_fault.dev_attr.attr,
> -	&sensor_dev_attr_temp2_fault.dev_attr.attr,
> -	&sensor_dev_attr_temp1_max.dev_attr.attr,
> -	&sensor_dev_attr_temp2_max.dev_attr.attr,
> -	&sensor_dev_attr_temp1_crit.dev_attr.attr,
> -	&sensor_dev_attr_temp2_crit.dev_attr.attr,
> -	&sensor_dev_attr_temp1_emergency.dev_attr.attr,
> -	&sensor_dev_attr_temp2_emergency.dev_attr.attr,
> -	&sensor_dev_attr_pwm1.dev_attr.attr,
> -	&sensor_dev_attr_pwm2.dev_attr.attr,
> -	&sensor_dev_attr_fan1_input.dev_attr.attr,
> -	&sensor_dev_attr_fan2_input.dev_attr.attr,
> -	&sensor_dev_attr_fan1_fault.dev_attr.attr,
> -	&sensor_dev_attr_fan2_fault.dev_attr.attr,
> -	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp1_emergency_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp2_emergency_alarm.dev_attr.attr,
> +static umode_t max6639_is_visible(const void *data,
> +				  enum hwmon_sensor_types type,
> +				  u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		return max6639_fan_is_visible(data, attr, channel);
> +	case hwmon_pwm:
> +		return max6639_pwm_is_visible(data, attr, channel);
> +	case hwmon_temp:
> +		return max6639_temp_is_visible(data, attr, channel);
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static const struct hwmon_channel_info * const max6639_info[] = {
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_PULSES,
> +			   HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_PULSES),
> +	HWMON_CHANNEL_INFO(pwm,
> +			   HWMON_PWM_INPUT | HWMON_PWM_FREQ,
> +			   HWMON_PWM_INPUT | HWMON_PWM_FREQ),
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_MAX | HWMON_T_MAX_ALARM |
> +			   HWMON_T_CRIT | HWMON_T_CRIT_ALARM | HWMON_T_EMERGENCY |
> +			   HWMON_T_EMERGENCY_ALARM,
> +			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_MAX | HWMON_T_MAX_ALARM |
> +			   HWMON_T_CRIT | HWMON_T_CRIT_ALARM | HWMON_T_EMERGENCY |
> +			   HWMON_T_EMERGENCY_ALARM),
>   	NULL
>   };
> -ATTRIBUTE_GROUPS(max6639);
> +
> +static const struct hwmon_ops max6639_hwmon_ops = {
> +	.is_visible = max6639_is_visible,
> +	.read = max6639_read,
> +	.write = max6639_write,
> +};
> +
> +static const struct hwmon_chip_info max6639_chip_info = {
> +	.ops = &max6639_hwmon_ops,
> +	.info = max6639_info,
> +};
>   
>   /*
>    *  returns respective index in rpm_ranges table
> @@ -355,11 +530,6 @@ static int rpm_range_to_reg(int range)
>   	return 1; /* default: 4000 RPM */
>   }
>   
> -static int max6639_set_ppr(struct max6639_data *data, u8 channel, u8 ppr)
> -{
> -	return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), ppr << 6);
> -}
> -
>   static int max6639_init_client(struct i2c_client *client,
>   			       struct max6639_data *data)
>   {
> @@ -380,14 +550,16 @@ static int max6639_init_client(struct i2c_client *client,
>   		ppr = max6639_info->ppr;
>   	else
>   		ppr = 2;
> -	ppr -= 1;
> +
> +	data->ppr[0] = ppr;
> +	data->ppr[1] = ppr;
>   

I think we should drop support for max6639_platform_data entirely.
It isn't used anywhere in the kernel and obviously incomplete.

>   	if (max6639_info)
>   		rpm_range = rpm_range_to_reg(max6639_info->rpm_range);
> -	data->rpm_range = rpm_range;
> +	data->rpm_range[0] = rpm_range;
> +	data->rpm_range[1] = rpm_range;
>   
>   	for (i = 0; i < MAX6639_NUM_CHANNELS; i++) {
> -
>   		/* Set Fan pulse per revolution */
>   		err = max6639_set_ppr(data, i, ppr);
>   		if (err)
> @@ -395,15 +567,17 @@ static int max6639_init_client(struct i2c_client *client,
>   
>   		/* Fans config PWM, RPM */
>   		err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG1(i),
> -				   MAX6639_FAN_CONFIG1_PWM | rpm_range);
> +				   MAX6639_FAN_CONFIG1_PWM | data->rpm_range[i]);
>   		if (err)
>   			return err;
>   
>   		/* Fans PWM polarity high by default */
> -		if (max6639_info && max6639_info->pwm_polarity == 0)
> -			err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x00);
> -		else
> -			err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x02);
> +		if (max6639_info) {
> +			if (max6639_info->pwm_polarity == 0)
> +				err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x00);
> +			else
> +				err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x02);
> +		}
>   		if (err)
>   			return err;
>   
> @@ -534,9 +708,13 @@ static int max6639_probe(struct i2c_client *client)
>   	if (err < 0)
>   		return err;
>   
> -	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
> -							   data,
> -							   max6639_groups);
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
> +							 data, &max6639_chip_info,
> +							 NULL);
> +
> +	if (IS_ERR(hwmon_dev))
> +		return dev_err_probe(dev, PTR_ERR(hwmon_dev),
> +				     "unable to register hwmon device\n");

This is a functional change unrelated to the conversion, and I am not
in favor of it. Please refrain from making such changes.

Thanks,
Guenter


