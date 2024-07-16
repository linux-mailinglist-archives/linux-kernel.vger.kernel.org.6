Return-Path: <linux-kernel+bounces-253263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7E5931ECC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837E41C21251
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05878814;
	Tue, 16 Jul 2024 02:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D52IViGD"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AD86FB8;
	Tue, 16 Jul 2024 02:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721096718; cv=none; b=VnHqMpB1uBHl+lbPDnISEML74JLtpfZgExLMw1mh9eV/6J/0aTI/VWVDOVNB6F9P3+aTt/ma72t3LYCdG9wgKkunZ8uwxCj/ULg5J8D+cXNM3gcW3Tu0JTCB4KbjWJFDZ1O73jKDYyoG9vXTDBgyDGmNkVrGVvfPXdpLCcNH7lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721096718; c=relaxed/simple;
	bh=GKnKYLa+DE2NlVgtcy8pzU6V8LQ3hzGs0ZGuh8Bao2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TMk9FOBedAaoaeAfFWEPEBIDfylHJ3J452szdT/DnN21/6CAK2RgnYBgdxZy74buKkGACfjfOWYRMDBx6cF14W7FfasL5+PB3j3rJ/jfzngiCM6MrqW6mPGM28y3S88+ArqapTjNmdKvt+h9o04n5F5LHe5jwz32QoqBX4eeecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D52IViGD; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-765590154b4so2936012a12.0;
        Mon, 15 Jul 2024 19:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721096716; x=1721701516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pC6VGOzZrexQd1bwg3uHzhS7HotZy2k172Ta/hi+Z/A=;
        b=D52IViGDTPc/bJTk0GwK5dY+Qi+3ar5lgilZTzlx9EtSKnScOZ3Pij5ptNUibrz7oA
         Tk3R1LI6h4T76A34cQO4/aaCBTXSqUYg2IBwk9CzdifqbqIYLwX4j6AfF25EiR+9uEgo
         2NDJd5q8krUGcepL9GevSxWfa4SzY0FG5Vgubr2taJuyQbYKZHReCduCAZ+APBuHQdr7
         xgJbF9lq/7oIKNQSt6tLgqEgMjzOkEX9CHEUad9QYN/8TO59PpWABuszhQ4mhQHBFgtR
         NlelPo7qA6s3L0dTIRSx4S3bjQl+KnaC71qXegPKKd8Ahl0gcYeM2ElwoskjCwpTKYFz
         j+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721096716; x=1721701516;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pC6VGOzZrexQd1bwg3uHzhS7HotZy2k172Ta/hi+Z/A=;
        b=pu746UqtTg3v4lNu8XTVMIIIZ5EpwuXrewmBgBK3WzNXoDlb2tFnMEf051/2z5tP3O
         /aQx/TA8QfX8gHNiJhwvlVe8QZePOdhcK14YOMaTdblPaiFYGdPejKdN9r5uUcjhU7dp
         zdf1L2I9lwppWPnYrIlqla6TamM2goGVhocg0Z4XRlhIl6CeEvjSRhZcaexwNFmZI1nf
         xhck6LH+OFdprzoIV0ht6lMWOHOFltEmBXCo9DjkUaE9SdQMrJZqiao4Zgcs/ihMDzP0
         vV9IxR5H3t26pQsxA5K1zzl1Zq4mIcHJcvTrH0Omiw081jhJ+pb92W5G7H04bfqL7CZO
         5aEA==
X-Forwarded-Encrypted: i=1; AJvYcCXF/3Nylb34FH4XWpbbTlSxvWX7lccHl32hjr7c4kiNnWrau94V4KkV5qbstDCQ2tg1hJyQUl9sOzERqFTKNzcVeeX/OiOxlS7Hg4kUsC4V527WJaMWSZIFkOOT81f+mXLdMDsbLcJGZFI=
X-Gm-Message-State: AOJu0Yyxe12FY1JY2OtCDSb5y2m760n6S+YvWFK2X9BkPgB3oHhoB6+v
	L2hXlk1uT4t73hWjjfCxxRTjDazsll1fuQn4YuI1xbpFS68unMxdsm0yTA==
X-Google-Smtp-Source: AGHT+IGrGTJfsLDC/rddJm9PgxcTma9Pi3I//sDl6F7ZaWOBXaXN9lBrNQ1vRtjipoJkSoR4nYT0lw==
X-Received: by 2002:a05:6a20:d502:b0:1c2:94ad:1c5d with SMTP id adf61e73a8af0-1c3f11fead3mr801206637.2.1721096716033;
        Mon, 15 Jul 2024 19:25:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd3e5a87sm7163531a91.14.2024.07.15.19.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 19:25:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c3d89f68-80e6-4282-b6b1-c757a2bea775@roeck-us.net>
Date: Mon, 15 Jul 2024 19:25:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hwmon: pmbus: Implement generic bus access delay
To: Patrick Rudolph <patrick.rudolph@9elements.com>,
 linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
References: <20240715073105.594221-1-patrick.rudolph@9elements.com>
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
In-Reply-To: <20240715073105.594221-1-patrick.rudolph@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/24 00:30, Patrick Rudolph wrote:
> Some drivers, like the max15301 or zl6100, are intentionally delaying
> SMBus communications, to prevent transmission errors. As this is necessary
> on additional PMBus compatible devices, implement a generic delay mechanism
> in the pmbus core.
> 
> Introduces two delay settings in the pmbus_driver_info struct, one applies
> to every SMBus transaction and the other is for write transaction only.
> Once set by the driver the SMBus traffic, using the generic pmbus access
> helpers, is automatically delayed when necessary.
> 
> The two settings are:
> access_delay:
>    - Unit in microseconds
>    - Stores the accessed timestamp after every SMBus access
>    - Delays when necessary before the next SMBus access
> 
> write_delay:
>    - Unit in microseconds
>    - Stores the written timestamp after a write SMBus access
>    - Delays when necessary before the next SMBus access
> 
> This allows to drop the custom delay code from the drivers and easily
> introduce this feature in additional pmbus drivers.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>   drivers/hwmon/pmbus/pmbus.h      | 10 ++++
>   drivers/hwmon/pmbus/pmbus_core.c | 92 +++++++++++++++++++++++++++++---
>   2 files changed, 96 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
> index fb442fae7b3e..5d5dc774187b 100644
> --- a/drivers/hwmon/pmbus/pmbus.h
> +++ b/drivers/hwmon/pmbus/pmbus.h
> @@ -466,6 +466,16 @@ struct pmbus_driver_info {
>   
>   	/* custom attributes */
>   	const struct attribute_group **groups;
> +
> +	/*
> +	 * Some chips need a little delay between SMBus communication. When
> +	 * set, the generic PMBus helper functions will wait if necessary
> +	 * to meet this requirement. The access delay is honored after
> +	 * every SMBus operation. The write delay is only honored after
> +	 * SMBus write operations.
> +	 */
> +	int access_delay;		/* in microseconds */
> +	int write_delay;		/* in microseconds */
>   };
>   
>   /* Regulator ops */
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index cb4c65a7f288..5cb093c898a1 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -7,6 +7,7 @@
>    */
>   
>   #include <linux/debugfs.h>
> +#include <linux/delay.h>
>   #include <linux/kernel.h>
>   #include <linux/math64.h>
>   #include <linux/module.h>
> @@ -108,6 +109,8 @@ struct pmbus_data {
>   
>   	int vout_low[PMBUS_PAGES];	/* voltage low margin */
>   	int vout_high[PMBUS_PAGES];	/* voltage high margin */
> +	ktime_t write_time;		/* Last SMBUS write timestamp */
> +	ktime_t access_time;		/* Last SMBUS access timestamp */
>   };
>   
>   struct pmbus_debugfs_entry {
> @@ -158,6 +161,39 @@ void pmbus_set_update(struct i2c_client *client, u8 reg, bool update)
>   }
>   EXPORT_SYMBOL_NS_GPL(pmbus_set_update, PMBUS);
>   
> +/* Some chips need a delay between accesses. */
> +static inline void pmbus_optional_wait(struct i2c_client *client)

Also, please drop the inline here and below to let the compiler decide
if it wants to inline or not.

Thanks,
Guenter

> +{
> +	struct pmbus_data *data = i2c_get_clientdata(client);
> +	const struct pmbus_driver_info *info = data->info;
> +	s64 delta;
> +
> +	if (info->access_delay) {
> +		delta = ktime_us_delta(ktime_get(), data->access_time);
> +
> +		if (delta < info->access_delay)
> +			udelay(info->access_delay - delta);
> +	} else if (info->write_delay) {
> +		delta = ktime_us_delta(ktime_get(), data->write_time);
> +
> +		if (delta < info->write_delay)
> +			udelay(info->write_delay - delta);
> +	}
> +}
> +
> +/* Sets the last accessed timestamp for pmbus_optional_wait */
> +static inline void pmbus_update_ts(struct i2c_client *client, bool write_op)
> +{
> +	struct pmbus_data *data = i2c_get_clientdata(client);
> +	const struct pmbus_driver_info *info = data->info;
> +
> +	if (info->access_delay) {
> +		data->access_time = ktime_get();
> +	} else if (info->write_delay && write_op) {
> +		data->write_time = ktime_get();
> +	}
> +}
> +
>   int pmbus_set_page(struct i2c_client *client, int page, int phase)
>   {
>   	struct pmbus_data *data = i2c_get_clientdata(client);
> @@ -168,11 +204,15 @@ int pmbus_set_page(struct i2c_client *client, int page, int phase)
>   
>   	if (!(data->info->func[page] & PMBUS_PAGE_VIRTUAL) &&
>   	    data->info->pages > 1 && page != data->currpage) {
> +		pmbus_optional_wait(client);
>   		rv = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
> +		pmbus_update_ts(client, true);
>   		if (rv < 0)
>   			return rv;
>   
> +		pmbus_optional_wait(client);
>   		rv = i2c_smbus_read_byte_data(client, PMBUS_PAGE);
> +		pmbus_update_ts(client, false);
>   		if (rv < 0)
>   			return rv;
>   
> @@ -183,8 +223,10 @@ int pmbus_set_page(struct i2c_client *client, int page, int phase)
>   
>   	if (data->info->phases[page] && data->currphase != phase &&
>   	    !(data->info->func[page] & PMBUS_PHASE_VIRTUAL)) {
> +		pmbus_optional_wait(client);
>   		rv = i2c_smbus_write_byte_data(client, PMBUS_PHASE,
>   					       phase);
> +		pmbus_update_ts(client, true);
>   		if (rv)
>   			return rv;
>   	}
> @@ -202,7 +244,11 @@ int pmbus_write_byte(struct i2c_client *client, int page, u8 value)
>   	if (rv < 0)
>   		return rv;
>   
> -	return i2c_smbus_write_byte(client, value);
> +	pmbus_optional_wait(client);
> +	rv = i2c_smbus_write_byte(client, value);
> +	pmbus_update_ts(client, true);
> +
> +	return rv;
>   }
>   EXPORT_SYMBOL_NS_GPL(pmbus_write_byte, PMBUS);
>   
> @@ -233,7 +279,11 @@ int pmbus_write_word_data(struct i2c_client *client, int page, u8 reg,
>   	if (rv < 0)
>   		return rv;
>   
> -	return i2c_smbus_write_word_data(client, reg, word);
> +	pmbus_optional_wait(client);
> +	rv = i2c_smbus_write_word_data(client, reg, word);
> +	pmbus_update_ts(client, true);
> +
> +	return rv;
>   }
>   EXPORT_SYMBOL_NS_GPL(pmbus_write_word_data, PMBUS);
>   
> @@ -351,7 +401,11 @@ int pmbus_read_word_data(struct i2c_client *client, int page, int phase, u8 reg)
>   	if (rv < 0)
>   		return rv;
>   
> -	return i2c_smbus_read_word_data(client, reg);
> +	pmbus_optional_wait(client);
> +	rv = i2c_smbus_read_word_data(client, reg);
> +	pmbus_update_ts(client, false);
> +
> +	return rv;
>   }
>   EXPORT_SYMBOL_NS_GPL(pmbus_read_word_data, PMBUS);
>   
> @@ -410,7 +464,11 @@ int pmbus_read_byte_data(struct i2c_client *client, int page, u8 reg)
>   	if (rv < 0)
>   		return rv;
>   
> -	return i2c_smbus_read_byte_data(client, reg);
> +	pmbus_optional_wait(client);
> +	rv = i2c_smbus_read_byte_data(client, reg);
> +	pmbus_update_ts(client, false);
> +
> +	return rv;
>   }
>   EXPORT_SYMBOL_NS_GPL(pmbus_read_byte_data, PMBUS);
>   
> @@ -422,7 +480,11 @@ int pmbus_write_byte_data(struct i2c_client *client, int page, u8 reg, u8 value)
>   	if (rv < 0)
>   		return rv;
>   
> -	return i2c_smbus_write_byte_data(client, reg, value);
> +	pmbus_optional_wait(client);
> +	rv = i2c_smbus_write_byte_data(client, reg, value);
> +	pmbus_update_ts(client, true);
> +
> +	return rv;
>   }
>   EXPORT_SYMBOL_NS_GPL(pmbus_write_byte_data, PMBUS);
>   
> @@ -454,7 +516,11 @@ static int pmbus_read_block_data(struct i2c_client *client, int page, u8 reg,
>   	if (rv < 0)
>   		return rv;
>   
> -	return i2c_smbus_read_block_data(client, reg, data_buf);
> +	pmbus_optional_wait(client);
> +	rv = i2c_smbus_read_block_data(client, reg, data_buf);
> +	pmbus_update_ts(client, false);
> +
> +	return rv;
>   }
>   
>   static struct pmbus_sensor *pmbus_find_sensor(struct pmbus_data *data, int page,
> @@ -2450,9 +2516,11 @@ static int pmbus_read_coefficients(struct i2c_client *client,
>   	data.block[1] = attr->reg;
>   	data.block[2] = 0x01;
>   
> +	pmbus_optional_wait(client);
>   	rv = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
>   			    I2C_SMBUS_WRITE, PMBUS_COEFFICIENTS,
>   			    I2C_SMBUS_BLOCK_PROC_CALL, &data);
> +	pmbus_update_ts(client, false);
>   
>   	if (rv < 0)
>   		return rv;
> @@ -2604,7 +2672,10 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
>   
>   	/* Enable PEC if the controller and bus supports it */
>   	if (!(data->flags & PMBUS_NO_CAPABILITY)) {
> +		pmbus_optional_wait(client);
>   		ret = i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
> +		pmbus_update_ts(client, false);
> +
>   		if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK)) {
>   			if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_PEC))
>   				client->flags |= I2C_CLIENT_PEC;
> @@ -2617,10 +2688,16 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
>   	 * Bail out if both registers are not supported.
>   	 */
>   	data->read_status = pmbus_read_status_word;
> +	pmbus_optional_wait(client);
>   	ret = i2c_smbus_read_word_data(client, PMBUS_STATUS_WORD);
> +	pmbus_update_ts(client, false);
> +
>   	if (ret < 0 || ret == 0xffff) {
>   		data->read_status = pmbus_read_status_byte;
> +		pmbus_optional_wait(client);
>   		ret = i2c_smbus_read_byte_data(client, PMBUS_STATUS_BYTE);
> +		pmbus_update_ts(client, false);
> +
>   		if (ret < 0 || ret == 0xff) {
>   			dev_err(dev, "PMBus status register not found\n");
>   			return -ENODEV;
> @@ -2635,7 +2712,10 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
>   	 * limit registers need to be disabled.
>   	 */
>   	if (!(data->flags & PMBUS_NO_WRITE_PROTECT)) {
> +		pmbus_optional_wait(client);
>   		ret = i2c_smbus_read_byte_data(client, PMBUS_WRITE_PROTECT);
> +		pmbus_update_ts(client, false);
> +
>   		if (ret > 0 && (ret & PB_WP_ANY))
>   			data->flags |= PMBUS_WRITE_PROTECTED | PMBUS_SKIP_STATUS_CHECK;
>   	}


