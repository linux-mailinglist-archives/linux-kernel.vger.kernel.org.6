Return-Path: <linux-kernel+bounces-302043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC2995F912
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6627B224E8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA2C19538D;
	Mon, 26 Aug 2024 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/hOvenj"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584482C1AC;
	Mon, 26 Aug 2024 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697457; cv=none; b=LnitN6m1lfqiLsmLdrUtHY82iOTEoNr46ea9AmIN1XDEZOlz0XTDIVeSip72dAaVhpZ3txfdN5UMl46I3nlisfFGDOLmezqQzEaanhwD+q8994PsM1bH0hrS8vH+bsBIVwaE/r15Hw56zE0HZdcde1ivOFCum4NEwwW0WLUh7Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697457; c=relaxed/simple;
	bh=e5WsJ9SveDMx1GjU3BfJ1oX05BQajfs88sYA8RMKnBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPJw/UemdCGHIO7lvY6ek3d66K4i1OODl7hdNwJWzFXfxXx+QfoXStgqA9LdAQifF5IuxM+VqJEWMPJWrhol9BmhMVUiTVyW6P3oj5cariwcZwxcdi8dfOxg7MYRJfcHb4rAYxZsiEEF1gQUfDMvpRcTPngDFLrU2b5vepUTxGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/hOvenj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2021c03c13aso34605485ad.1;
        Mon, 26 Aug 2024 11:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724697454; x=1725302254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7FfGnllErnCJMhQQS8mSV7mT663rh6zbGx5snnhHvo0=;
        b=f/hOvenjiMcoG85XjUXKzDjRWok+fxDLYdQo4/7SfbeBa0JmPYTX3pmZOr3/t7RhUT
         HaG7TjKx1BT+LU3bKslSTvwI7dOuxE1f+4hgPj+ij01K1GSjyaVhTc7uzvrKgozue1xb
         2CUJnQWddRn3JU3HkoEuEshN+YIQXr0NuCKoDUAWanRWEiZSA3mhz5pEHT9WFlGG0MA+
         g0ROnZSM+pZY4cZ99hoFHkzBs8+pMBuEIpbXlZNWB4Amen6Ct9fpwOewU47DOEBqZA0v
         4nqS+MtnGj5xHP7ZWg2P3LeXactHJ3Eckw2+CDklceNHUAoHQdkFMIAHlNZhvEJwvagD
         BPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724697454; x=1725302254;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FfGnllErnCJMhQQS8mSV7mT663rh6zbGx5snnhHvo0=;
        b=jgjhLDxu7vjUPl7EIm11C8IaN3yJExNrh+hOK4diPL7EkRipT2JQLq9LfEnmh7sOdF
         fuGTZlXMLSSkK/NQnJR/MIpda6U6bYGSlCK/cGImpA6PtZDSwU0NDyPiFHCaltnD0/2Q
         2QFNxEYU8Zx3M2NENM44ylXIXMIlpkCHlFzd01FP8Fk/erRU7mLYTSFHG886hFsUgCoe
         1ssVL2VmUs0bhtRa+Qw/a7LtQ9hUv+Kei8gsP48FBIbdd8yFSzEdHVv+dkOpXEzDV43n
         FRAy8Oy/DOJHczMSVJqTAnYN/xadz1QCxtmzL9xv16/VDYoxdeuLbXFCDxfqD6XekryA
         GIAg==
X-Forwarded-Encrypted: i=1; AJvYcCUaOYjhzQVpgOO4X32BYCehyNS+jVpKiQ4ua8WjCbNiv/DgMmo9wuBqLM+PwUJAkEU8CbeC/3X3aclduQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkZaWLUz5HFSS20T0JAv6hyJ3JOFb/+C9hVjMffVotYdPDp3ZG
	DHs5VMM4CyIaa7moLJJYPnOD90KwHI5A1Al/WcvQPSjaNRpnvFaC
X-Google-Smtp-Source: AGHT+IHQW8B1+ShrZqD//notznG/ecwoKpFLELILDUUEOFUPyGNB0oOZdUJrz3Y56cGYvVWvI+hw7Q==
X-Received: by 2002:a17:903:120d:b0:1fb:a38b:c5b7 with SMTP id d9443c01a7336-204ddcba3c2mr9099955ad.1.1724697454321;
        Mon, 26 Aug 2024 11:37:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560e3e8sm69940645ad.219.2024.08.26.11.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 11:37:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <790f67c3-84f4-441b-bd80-0c11f002af5b@roeck-us.net>
Date: Mon, 26 Aug 2024 11:37:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hwmon: (sht4x): add heater support
To: Antoni Pokusinski <apokusinski01@gmail.com>, jdelvare@suse.com
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20240826125803.71970-1-apokusinski01@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240826125803.71970-1-apokusinski01@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/24 05:58, Antoni Pokusinski wrote:
> Add support for manipulating the internal heater of sht4x devices.
> Enabling the heater removes condensed water from the sensor surface
> which disturbs the relative humidity measurements.
> 
> The heater can operate at three heating levels (20, 110 or 200
> milliwatts). Also, two heating durations may be selected (0.1 or 1s).
> Once the heating time elapses the heater is automatically switched off.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
> Hello Guenter,
> 
> Thanks for the review.
> I'm not sure if this short patch description above is now ok or shall I
> be even more detailed.
> The problem that I was facing was that when I was using the sensor for
> relative humidity measurements the results were always ~100% even though
> the correct value should be ~60%. Enabling the heater in periodic pulses
> to remove the condensation fixed the issue and the measurements were
> correct after that.
> Thus, I'm not sure if I should include that detailed arguments in the
> patch description or leave it as it is right now.
> 
> Regards,
> Antoni Pokusinski
> 
> --
> Changes since v2:
> * heater_enable_store: remove unnecessary if
> * Documentation: remove incorrect info about turning off the heater
> * be more specific in the patch description
> 
> Changes since v1:
> * explain the use case of the new attributes set
> * heater_enable attr: make it write-only
> * heater_enable_store: define cmd as u8 instead of u8*
> * heater_enable_store: remove unreachable data path
> * heater_enable_store: remove unnecessary lock
> * heater_enable_store: call i2c_master_send only if status==true
> * define attributes as DEVICE_ATTR_* instead of SENSOR_DEVICE_ATTR_*
> ---
>   Documentation/hwmon/sht4x.rst |  10 +++
>   drivers/hwmon/sht4x.c         | 126 +++++++++++++++++++++++++++++++++-
>   2 files changed, 135 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/sht4x.rst b/Documentation/hwmon/sht4x.rst
> index daf21e763425..0b17f89fa1ab 100644
> --- a/Documentation/hwmon/sht4x.rst
> +++ b/Documentation/hwmon/sht4x.rst
> @@ -42,4 +42,14 @@ humidity1_input Measured humidity in %H
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
> +			- 1: turn on
>   =============== ============================================
> diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
> index b8916d2735b5..20b50f7feac0 100644
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
> +		} else { /* data->heater_power == 200 */
> +			if (data->heater_time == 100)
> +				cmd = SHT4X_CMD_HEATER_200_01;
> +			else /* data->heater_time == 1000 */
> +				cmd = SHT4X_CMD_HEATER_200_1;
> +		}
> +
> +		ret = i2c_master_send(data->client, &cmd, SHT4X_CMD_LEN);
> +	}

This still accepts (and ignores) writing "0" or "false".

On top of that, unless I misunderstand the chip documentation, attempts
to read the humidity before the "turn on heater" command completes will
result in a NACK from the chip. This is not currently handled by the driver.

Also, the datasheet states that a high precision measurement is done
before the heater is turned off. That measurement is currently ignored.

I am not entirely sure how to handle all this, but based on the information
in the datasheet I can not accept your current solution. At the very least,
you'll need to make sure that an attempt to read the humidity immediately after
turning on the heater does not result in an error message.

Thanks,
Guenter


