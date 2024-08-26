Return-Path: <linux-kernel+bounces-300608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC4C95E5F5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 02:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52120B20BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 00:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81715A59;
	Mon, 26 Aug 2024 00:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jR/hCTCc"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D5639B;
	Mon, 26 Aug 2024 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724631346; cv=none; b=oMDLhEpYn0EfxhdUTcf459FePUNFq5i5vScGax+iRxj+y63w7Ngt6tMfcFPiEKQu+FG03LND50JUqUoKxrsWrFJNxV2++/ebMgL0zqxk7UwtRFqvXi2L1N9v7cALJan1JuCgrrQGP8kTjkTtJbcs9cfA7dpPDshAk7lJHUKl+/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724631346; c=relaxed/simple;
	bh=SUygiDlXacK/hGkl/Lvf1/gNmZcbN7lIP/Z8w44ubyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mU2WimMlDD1spFEauLUh3kD17lSF1NMzxgccy0e+SYVUoOEKo83UA8jXqjIbR6oQH4uXxZUCeU7LIPKSrwCZWXn9hfwVg9EmBeIBVLVgc8hAgCHeNC9+Ki/mRKkCBwamwmEcMrSj0W789hYig6xT+ErBcdSkQM/laFnI3EHVy64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jR/hCTCc; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7cd9d408040so2538877a12.0;
        Sun, 25 Aug 2024 17:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724631344; x=1725236144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=t2U1P9W99OcIUC6HPPl/yk5OuVO/t9mtjIpeajcSxlc=;
        b=jR/hCTCcMRiTJUPdJQ8R4V10yBH9aXKOCoLUfYG63mAYdlt6SSbapQvmFtwBTSFWYb
         ST1RDo7AJu4BXM9CNqU8PR6hwrsp/85JYIq3SOsnqAj4dppG6A6eTe5BmASbN1yS5hbK
         A6Gs0sJf3lwEkcR+3lLuH5wdY3CROfhmAytWw7W4bPhQvPEPxM6AWrg3fcMLuxaCIkTq
         XKHlqSjuRZM9Wq7pBWMIL0mjXjcsjnHEfglojjm3zzR5iQpbRol4W5M1FkhtGEdDJjO8
         wMwyHSagR4ci31IEH2vW3i/lFaPDpygmveaqfVWk8hPMLVm7A/rrPjlQXrdn8SlUPQZG
         oXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724631344; x=1725236144;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2U1P9W99OcIUC6HPPl/yk5OuVO/t9mtjIpeajcSxlc=;
        b=nxJo9cVrG775xPJPW+L9XL7CtVDDkFhwiaumQ5pri5WMuMm3WHLNE+47z5eu0bpCLs
         Z2xC3uK7CYksPIlw3+uYfzvqvwXMkWU45QsvARfH/GsZloBI/LP9r/raymMLY6eK3u3A
         wZTR5W33ufRen8xE7bE1vvNToisbTtIWW8rdfxO32WXRAlmK46zsafN8XWb3YdoHEgxx
         m3KKDtQneVds2vmTUEB5ZV31sxgMZmoQ3YlDW3iXP6qq0/CuHzsrMgicwvuWmC6aE8YQ
         a9EjxbldOPE7H5TaZPDeCSTuxwuR4c72CPqbzbKwfGE2V+NhM4bg1/qDgQeeQm00kKgU
         zYzA==
X-Forwarded-Encrypted: i=1; AJvYcCXM62ciQ6okztYnSr/XrBeZaEkbqGz3O4VghhButJnqcfc/iHnIQi2nTSXZlQPRU/8TfxNQkEgFhNuocg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw91wMhU6fBZyPapT1/kJCfZPCLSn+tEOxIMrGqsGN3IQvDu4uY
	XSTaTWqFHMcD4aWWY5+NF+YqJxWJvLuwLqE93Pde6P6BicpN95nP
X-Google-Smtp-Source: AGHT+IF3uLmoPgw4XRnXY1ftBGxq1MuOJri4AsYzkaZLKo7nzmWd6Ky0PGqMahnlOtEitHrbxU9fkg==
X-Received: by 2002:a17:902:e84f:b0:202:3a75:ec89 with SMTP id d9443c01a7336-2039e4cf0d7mr100617655ad.31.1724631343658;
        Sun, 25 Aug 2024 17:15:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855816dcsm58617985ad.112.2024.08.25.17.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 17:15:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8e45875a-8af2-4409-8ea8-255281f97e68@roeck-us.net>
Date: Sun, 25 Aug 2024 17:15:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: (sht4x): add heater support
To: Antoni Pokusinski <apokusinski01@gmail.com>, jdelvare@suse.com
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20240825100930.205670-1-apokusinski01@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240825100930.205670-1-apokusinski01@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/24 03:09, Antoni Pokusinski wrote:
> Add support for manipulating the internal heater of sht4x devices.
> The heater may be used to remove condensed water on the sensor surface
> which disturbs the relative humidity measurements.
> 

Where is this seen in practice ? "may be" does not mean that the problem
is actively seen.

> The heater can operate at three heating levels (20, 110 or 200
> milliwatts). Also, two heating durations may be selected (0.1 or 1s).
> Once the heating time elapses the heater is automatically switched off.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
> Changes since v1:
> * explain the use case of the new attributes set
> * heater_enable attr: make it write-only
> * heater_enable_store: define cmd as u8 instead of u8*
> * heater_enable_store: remove unreachable data path
> * heater_enable_store: remove unnecessary lock
> * heater_enable_store: call i2c_master_send only if status==true
> * define attributes as DEVICE_ATTR_* instead of SENSOR_DEVICE_ATTR_*
> ---
>   Documentation/hwmon/sht4x.rst |  11 +++
>   drivers/hwmon/sht4x.c         | 126 +++++++++++++++++++++++++++++++++-
>   2 files changed, 136 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/sht4x.rst b/Documentation/hwmon/sht4x.rst
> index daf21e763425..3ff6c08d8267 100644
> --- a/Documentation/hwmon/sht4x.rst
> +++ b/Documentation/hwmon/sht4x.rst
> @@ -42,4 +42,15 @@ humidity1_input Measured humidity in %H
>   update_interval The minimum interval for polling the sensor,
>                   in milliseconds. Writable. Must be at least
>                   2000.
> +heater_power	The requested heater power, in milliwatts.
> +		Available values: 20, 110, 200 (default: 200).
> +heater_time	The requested operating time of the heater,
> +		in milliseconds.
> +		Available values: 100, 1000 (default 1000).
> +heater_enable	Enable the heater with the selected power
> +		and for the selected time in order to remove
> +		condensed water from the sensor surface. Write-only.
> +
> +			- 0: turn off

Not really. As implemented, this does not turn off the heater, it does nothing.
If that is what you want' you'd have to send a command "turn off heater immediately"
if such a command exists.

> +			- 1: turn on
>   =============== ============================================
> diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
> index b8916d2735b5..75e092f9b80e 100644
> --- a/drivers/hwmon/sht4x.c
> +++ b/drivers/hwmon/sht4x.c
> @@ -11,6 +11,7 @@
>   #include <linux/crc8.h>
>   #include <linux/delay.h>
>   #include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
>   #include <linux/i2c.h>
>   #include <linux/jiffies.h>
>   #include <linux/module.h>
> @@ -31,6 +32,12 @@
>    */
>   #define SHT4X_CMD_MEASURE_HPM	0b11111101
>   #define SHT4X_CMD_RESET		0b10010100
> +#define SHT4X_CMD_HEATER_20_1	0b00011110
> +#define SHT4X_CMD_HEATER_20_01	0b00010101
> +#define SHT4X_CMD_HEATER_110_1	0b00101111
> +#define SHT4X_CMD_HEATER_110_01	0b00100100
> +#define SHT4X_CMD_HEATER_200_1	0b00111001
> +#define SHT4X_CMD_HEATER_200_01 0b00110010
>   
>   #define SHT4X_CMD_LEN		1
>   #define SHT4X_CRC8_LEN		1
> @@ -54,6 +61,8 @@ DECLARE_CRC8_TABLE(sht4x_crc8_table);
>    * @last_updated: the previous time that the SHT4X was polled
>    * @temperature: the latest temperature value received from the SHT4X
>    * @humidity: the latest humidity value received from the SHT4X
> + * @heater_power: the power at which the heater will be started
> + * @heater_time: the time for which the heater will remain turned on
>    */
>   struct sht4x_data {
>   	struct i2c_client	*client;
> @@ -63,6 +72,8 @@ struct sht4x_data {
>   	long			last_updated;	/* in jiffies */
>   	s32			temperature;
>   	s32			humidity;
> +	u32			heater_power;	/* in milli-watts */
> +	u32			heater_time;	/* in milli-seconds */
>   };
>   
>   /**
> @@ -215,6 +226,117 @@ static int sht4x_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
>   	}
>   }
>   
> +static ssize_t heater_enable_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf,
> +				   size_t count)
> +{
> +	struct sht4x_data *data = dev_get_drvdata(dev);
> +	bool status;
> +	ssize_t ret;
> +	u8 cmd;
> +
> +	ret = kstrtobool(buf, &status);
> +	if (ret)
> +		return ret;
> +
> +	if (status) {
> +		if (data->heater_power == 20) {
> +			if (data->heater_time == 100)
> +				cmd = SHT4X_CMD_HEATER_20_01;
> +			else /* data->heater_time == 1000 */
> +				cmd = SHT4X_CMD_HEATER_20_1;
> +		} else if (data->heater_power == 110) {
> +			if (data->heater_time == 100)
> +				cmd = SHT4X_CMD_HEATER_110_01;
> +			else /* data->heater_time == 1000 */
> +				cmd = SHT4X_CMD_HEATER_110_1;
> +		} else if (data->heater_power == 200) {

Unnecessary "if". Due to the limitations of static checkers, those
may wrongly conclude that "cmd" is not initialized when passed to
i2c_master_send().

> +			if (data->heater_time == 100)
> +				cmd = SHT4X_CMD_HEATER_200_01;
> +			else /* data->heater_time == 1000 */
> +				cmd = SHT4X_CMD_HEATER_200_1;
> +		}
> +
> +		ret = i2c_master_send(data->client, &cmd, SHT4X_CMD_LEN);
> +	}
> +
> +	return ret; > +}
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
> +static DEVICE_ATTR_WO(heater_enable);
> +static DEVICE_ATTR_RW(heater_power);
> +static DEVICE_ATTR_RW(heater_time);
> +
> +static struct attribute *sht4x_attrs[] = {
> +	&dev_attr_heater_enable.attr,
> +	&dev_attr_heater_power.attr,
> +	&dev_attr_heater_time.attr,
> +	NULL
> +};
> +
> +ATTRIBUTE_GROUPS(sht4x);
> +
>   static const struct hwmon_channel_info * const sht4x_info[] = {
>   	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
>   	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> @@ -255,6 +377,8 @@ static int sht4x_probe(struct i2c_client *client)
>   
>   	data->update_interval = SHT4X_MIN_POLL_INTERVAL;
>   	data->client = client;
> +	data->heater_power = 200;
> +	data->heater_time = 1000;
>   
>   	mutex_init(&data->lock);
>   
> @@ -270,7 +394,7 @@ static int sht4x_probe(struct i2c_client *client)
>   							 client->name,
>   							 data,
>   							 &sht4x_chip_info,
> -							 NULL);
> +							 sht4x_groups);
>   
>   	return PTR_ERR_OR_ZERO(hwmon_dev);
>   }


