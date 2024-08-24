Return-Path: <linux-kernel+bounces-300208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B3495E062
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 01:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62CA1C20D0B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 23:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031E71442EA;
	Sat, 24 Aug 2024 23:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYGerqxc"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270B038DD8;
	Sat, 24 Aug 2024 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724541847; cv=none; b=lv/DuFLn/ghZgLr25uiCvvg6MZRmJviYttkY56RFI3sW/SqxmBVErVcnyjGSnJhWSujt+Uoal9YfOrdBZma3phbd6r4Y7yTwCI1oPoxoE5RtAJIkt2n99pcjXIK8K9mwq/+/+AhSBml8m3Rr66IA4eT1PT4m9/k4+eWNaSiAyWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724541847; c=relaxed/simple;
	bh=60pceDVDvK1LJFGaz7UCrnKXBcxkBusi4ep2jsY1obo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPVsK7IPTJ1O+Hr0Pe64hWc18zkWfWfMps4XsticvgupewfQT1rFvNP3oj0PZIf9eRIJeDXxF6XZnThwWHyunAdHxHwgTAKUZum+3CWZzH3+Yj/0U2q9pI4v6+/TlbOpxWOgYKvh7+Uslr/5R97I+46mkVWKz9TrGvNlJzfyfuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYGerqxc; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d3eda6603cso2489765a91.3;
        Sat, 24 Aug 2024 16:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724541844; x=1725146644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIQQtVZHLnMJCN9ZepNI7ks6kSWQ5ud8me89K4ApQSc=;
        b=FYGerqxckFVUvZxz0JcWC2K3QsaXx/sqPl9hksNbj+B0Otw3BoKHE4zyvMI9vi+OSH
         AoqEZ4ClwV6+zH4n+4M0tp+irJ8a4yQmbFKKuDNe0earPbFrQgGCTPzNERlj3BM3Id2Q
         M22h4AyauGM7wsMSNEaYpxG1b5E165elmNaaZ3H8ZeQsyobpWqjAE4qW7SfEtfAP3ujm
         GR20a8hhIhIBq3c1saCDtFgtC4a/u6JcFUBoFCHu2YntQyr7aPKFCeYOtDM+3ht7wEoG
         bkVdgLIrwzGPtjp6xLxpjQs2A3b30+rcXt4xCM74ZWPRuMt/sNQuuVkxY+ThYipsO9lE
         D89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724541844; x=1725146644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIQQtVZHLnMJCN9ZepNI7ks6kSWQ5ud8me89K4ApQSc=;
        b=VPJ5hhgxbZm2F13p8f4m4Kfw41Qm8owjgfg1MFNwmYT7/TRX2eQvO70ctyDiw4N8V8
         BpwrzKosV6PbRafLK40mCBeIN7a/1M/jI3XG9kFCB1v2mi7tCczBat5y/nTt4Q+GxbkG
         1+BrZ6Xjey0dQEiyGmV5y+JYPNmPqwBwu9zPjBD9bFpNm+MDK9TCDClUIfFbfqoUKNEk
         n1iEDodriO4EYbhEG268IE/NXtLvOBqY16MGANwCF+wXsTj307Nfjltxhmm4t3SIWbl5
         7oGfBwE30usuMwdHbIDbFlzbZTCz26qjFIkB7S34G32/aQvCYTBI2KM8O3eGoOzBaaoR
         3j2g==
X-Forwarded-Encrypted: i=1; AJvYcCXErXwIlQCtO3z+5RAsiycPgKm8v8coKL2oHKzEvpuWV0pxbgi8DEwTNNv1peI3oBZ8yBiCUVCA5ebqlw==@vger.kernel.org, AJvYcCXIJ6enkjRkFvgfGK8AK4b9zimRogqWI+yDbXlo/oDyhSnFQpaKxx10rqxDA0ZijQaiV8MNnRXg/qMjL7A0@vger.kernel.org
X-Gm-Message-State: AOJu0YwkQ7F0bV/HvYgI+aWTdYREoqG4A7cWvYHWPIZLAefiYtPF5Bvx
	OGkwu+9q+kUVRm/onWc+tFnbvfp8NVQjE0y0rLKHm6rTwR6h4SyW56Arcg==
X-Google-Smtp-Source: AGHT+IHnCTQYSJOALZ7nIxTp3WgibNKyTs7sss9Sa7JcJj0mMxTQ/PZXGvQkZg7Djs/MjDKfwgzbGQ==
X-Received: by 2002:a17:90b:1c03:b0:2d1:b37e:94b2 with SMTP id 98e67ed59e1d1-2d646bbb1e5mr7150356a91.7.1724541844092;
        Sat, 24 Aug 2024 16:24:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eba2199dsm9001432a91.27.2024.08.24.16.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 16:24:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 24 Aug 2024 16:24:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jdelvare@suse.com, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: (sht4x): add heater support
Message-ID: <bfc87b14-177c-4898-8a62-f6002793f8d6@roeck-us.net>
References: <20240823122139.12698-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823122139.12698-1-apokusinski01@gmail.com>

On Fri, Aug 23, 2024 at 02:21:39PM +0200, Antoni Pokusinski wrote:
> Add support for manipulating the internal heater of sht4x devices.
> 
> The heater can operate at three heating levels (20, 110 or 200
> milliwatts). Also, two heating durations may be selected (0.1 or 1s).
> Once the heating time elapses the heater is automatically switched off.

This doesn't explain why this set of attributes is necessary. What is the use
that makes this necessary now when it wasn't needed before ?

For non-standard attributes you need to explain why they are necessary,
I do n't accept such attributes without rationale and an actual use case.

> ---
>  Documentation/hwmon/sht4x.rst |  10 +++
>  drivers/hwmon/sht4x.c         | 137 +++++++++++++++++++++++++++++++++-
>  2 files changed, 146 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/sht4x.rst b/Documentation/hwmon/sht4x.rst
> index daf21e763425..e7414a623a52 100644
> --- a/Documentation/hwmon/sht4x.rst
> +++ b/Documentation/hwmon/sht4x.rst
> @@ -42,4 +42,14 @@ humidity1_input Measured humidity in %H
>  update_interval The minimum interval for polling the sensor,
>                  in milliseconds. Writable. Must be at least
>                  2000.
> +heater_power	The requested heater power, in milliwatts.
> +		Available values: 20, 110, 200 (default: 200).
> +heater_time	The requested operating time of the heater,
> +		in milliseconds.
> +		Available values: 100, 1000 (default 1000).
> +heater_enable	Enable the heater with the selected power
> +		and for the selected time. Write-only.
> +
> +			- 0: turn off
> +			- 1: turn on
>  =============== ============================================
> diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
> index b8916d2735b5..34214fe08a9e 100644
> --- a/drivers/hwmon/sht4x.c
> +++ b/drivers/hwmon/sht4x.c
> @@ -11,6 +11,7 @@
>  #include <linux/crc8.h>
>  #include <linux/delay.h>
>  #include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
>  #include <linux/i2c.h>
>  #include <linux/jiffies.h>
>  #include <linux/module.h>
> @@ -31,6 +32,12 @@
>   */
>  #define SHT4X_CMD_MEASURE_HPM	0b11111101
>  #define SHT4X_CMD_RESET		0b10010100
> +#define SHT4X_CMD_HEATER_20_1	0b00011110
> +#define SHT4X_CMD_HEATER_20_01	0b00010101
> +#define SHT4X_CMD_HEATER_110_1	0b00101111
> +#define SHT4X_CMD_HEATER_110_01	0b00100100
> +#define SHT4X_CMD_HEATER_200_1	0b00111001
> +#define SHT4X_CMD_HEATER_200_01 0b00110010
>  
>  #define SHT4X_CMD_LEN		1
>  #define SHT4X_CRC8_LEN		1
> @@ -54,6 +61,8 @@ DECLARE_CRC8_TABLE(sht4x_crc8_table);
>   * @last_updated: the previous time that the SHT4X was polled
>   * @temperature: the latest temperature value received from the SHT4X
>   * @humidity: the latest humidity value received from the SHT4X
> + * @heater_power: the power at which the heater will be started
> + * @heater_time: the time for which the heater will remain turned on
>   */
>  struct sht4x_data {
>  	struct i2c_client	*client;
> @@ -63,6 +72,8 @@ struct sht4x_data {
>  	long			last_updated;	/* in jiffies */
>  	s32			temperature;
>  	s32			humidity;
> +	u32			heater_power;	/* in milli-watts */
> +	u32			heater_time;	/* in milli-seconds */
>  };
>  
>  /**
> @@ -215,6 +226,128 @@ static int sht4x_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
>  	}
>  }
>  
> +static ssize_t heater_enable_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	return -EOPNOTSUPP;
> +}

Why mark the attribute as readable when it isn't ?

> +
> +static ssize_t heater_enable_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf,
> +				   size_t count)
> +{
> +	struct sht4x_data *data = dev_get_drvdata(dev);
> +	bool status;
> +	ssize_t ret;
> +	u8 cmd[SHT4X_CMD_LEN];

What is the point of making this a single-byte array ?

> +
> +	ret = kstrtobool(buf, &status);
> +	if (ret)
> +		return ret;
> +
> +	if (status) {
> +		if (data->heater_power == 20) {
> +			if (data->heater_time == 100)
> +				*cmd = SHT4X_CMD_HEATER_20_01;
> +			else /* data->heater_time == 1000 */
> +				*cmd = SHT4X_CMD_HEATER_20_1;
> +		} else if (data->heater_power == 110) {
> +			if (data->heater_time == 100)
> +				*cmd = SHT4X_CMD_HEATER_110_01;
> +			else /* data->heater_time == 1000 */
> +				*cmd = SHT4X_CMD_HEATER_110_1;
> +		} else if (data->heater_power == 200) {
> +			if (data->heater_time == 100)
> +				*cmd = SHT4X_CMD_HEATER_200_01;
> +			else /* data->heater_time == 1000 */
> +				*cmd = SHT4X_CMD_HEATER_200_1;
> +		} else {
> +			return -EINVAL;

This data path is never reached.

> +		}
> +	}
> +
> +	mutex_lock(&data->lock);
> +	ret = i2c_master_send(data->client, cmd, SHT4X_CMD_LEN);

If status==false this sends a random byte to the chip because 'cmd'
is not initialized. What is the point of doing that ?

> +	mutex_unlock(&data->lock);

This lock doesn't protect anything.

> +
> +	return ret;
> +}
> +
> +static ssize_t heater_power_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct sht4x_data *data = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%u\n", data->heater_power);
> +}
> +
> +static ssize_t heater_power_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf,
> +				  size_t count)
> +{
> +	struct sht4x_data *data = dev_get_drvdata(dev);
> +	u32 power;
> +	ssize_t ret;
> +
> +	ret = kstrtou32(buf, 10, &power);
> +	if (ret)
> +		return ret;
> +
> +	if (power != 20 && power != 110 && power != 200)
> +		return -EINVAL;
> +
> +	data->heater_power = power;
> +
> +	return count;
> +}
> +
> +static ssize_t heater_time_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct sht4x_data *data = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%u\n", data->heater_time);
> +}
> +
> +static ssize_t heater_time_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf,
> +				 size_t count)
> +{
> +	struct sht4x_data *data = dev_get_drvdata(dev);
> +	u32 time;
> +	ssize_t ret;
> +
> +	ret = kstrtou32(buf, 10, &time);
> +	if (ret)
> +		return ret;
> +
> +	if (time != 100 && time != 1000)
> +		return -EINVAL;
> +
> +	data->heater_time = time;
> +
> +	return count;
> +}
> +
> +static SENSOR_DEVICE_ATTR_RW(heater_enable, heater_enable, 0);
> +static SENSOR_DEVICE_ATTR_RW(heater_power, heater_power, 0);
> +static SENSOR_DEVICE_ATTR_RW(heater_time, heater_time, 0);

Why SENSOR_DEVICE_ATTR and not just DEVICE_ATTR ?

> +
> +static struct attribute *sht4x_attrs[] = {
> +	&sensor_dev_attr_heater_enable.dev_attr.attr,
> +	&sensor_dev_attr_heater_power.dev_attr.attr,
> +	&sensor_dev_attr_heater_time.dev_attr.attr,
> +	NULL
> +};
> +
> +ATTRIBUTE_GROUPS(sht4x);
> +
>  static const struct hwmon_channel_info * const sht4x_info[] = {
>  	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
>  	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> @@ -255,6 +388,8 @@ static int sht4x_probe(struct i2c_client *client)
>  
>  	data->update_interval = SHT4X_MIN_POLL_INTERVAL;
>  	data->client = client;
> +	data->heater_power = 200;
> +	data->heater_time = 1000;
>  
>  	mutex_init(&data->lock);
>  
> @@ -270,7 +405,7 @@ static int sht4x_probe(struct i2c_client *client)
>  							 client->name,
>  							 data,
>  							 &sht4x_chip_info,
> -							 NULL);
> +							 sht4x_groups);
>  
>  	return PTR_ERR_OR_ZERO(hwmon_dev);
>  }
> -- 
> 2.25.1
> 

