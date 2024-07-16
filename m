Return-Path: <linux-kernel+bounces-253262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC2C931ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87491B218F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A5579E0;
	Tue, 16 Jul 2024 02:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7EgFWI4"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341E2AD24;
	Tue, 16 Jul 2024 02:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721096586; cv=none; b=EBSCn4R9CngNEtLqTujMEs/JViYMPI0UNHFev8I8oAfb4yS8K170AbuMyc8vg+Mwm1Cx+qGE8usjRcLR20j1Lb5/brxKHIL0o06hM3UCetBpYjRs9YKvP1D/1e+dnFbuj9b/QnkwrA7+wd5R5F+13rHvwzRNZTIlKSqwIiihf98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721096586; c=relaxed/simple;
	bh=szvP/ZammT9Bdm7xWuDoBaWuwi+bVR7iMdq3Lj/DJq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dsz+HsAZ1uxbA6BGP9UVJdGIg8gEZXAbOuKQaWdKd+o9Uzd6dlJnUXEhYsSxyZ4H/kVqNFaHh3IC0sk6zBQ/GzRF8hGecHsQcf5GcFrnQ9utHIYjgfbXdgOTmU1bV80TqHXCCLzp3isH7jCtnNQVC3lgze6qVeHCzblLvQgVb68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7EgFWI4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fbc3a9d23bso35036965ad.1;
        Mon, 15 Jul 2024 19:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721096583; x=1721701383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Nk9o31w13WrHum1mzimiqzqxtNTbngMXtgySQBpQkQI=;
        b=K7EgFWI4bXwG+gLpQLZ6l9lgRTgamKj9iZq3KYAjfkEnsfIMMr76ZWU8mHHyZZhjDk
         gjXzPinO7E0ABezwx62yCilkgwi+exmZTFEEHzgiF5Hzr/YooIy6+AIScARVfDo/5hsh
         Crk0F2pwSeuXHtpHNIWMyohQhCNwFhnqF34/TdZnF47sYAazFVosHqcK32HduNy+iuGL
         Zl/64bMOl5urRFfaS5LlrV2xX/JPaxL9Eos8vEmkHco0APEmcrtarq/y3tF2Vu85g5Hc
         yy7HBLmXwXV+Mru0kz+LAzDbkFCVqnnsXtrijE1OA8RkhSAN72bRKDfm9ina+BjAiorJ
         AP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721096583; x=1721701383;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk9o31w13WrHum1mzimiqzqxtNTbngMXtgySQBpQkQI=;
        b=whOkviQH7YAPCOn526nmBcuXEqPGMCj9wOm7qzm5ykHD1s/M4PZJg629cB7x49Mc76
         AhYu80LX2nvrOVAAo+fbzD3M1AaoxkXmBkhdmG+kH74gt7IRAoRhYcncckXGwIc9WDCF
         mrzy8BX7NA3Ec4PvJcFlXQ4bTDstXBMXE6xzgSZXj1ZftsP23MeVE0PTd70Bae+JOLa1
         r+7rPbkXNvTPl16RGRPCyT+saw1IMPSYqgmy4sL49YrvfZM6Na6NeukQSZc3KtOypEnN
         fBkeCxQkT0f5jXaVOCdIaey4XOsClGEumJEHQo45D2J3IIK7jlqaIzaQvaUvi7vwTvn/
         2VBg==
X-Forwarded-Encrypted: i=1; AJvYcCUKbKtKWZNBTEDqA01lO7XJff68jXKCLc7B5hb9QK6TJfn5ZYf8P+IABRDb9xEGfCCdOa7KRzP8fWU778L0Uu/qTTXNcAv84/r4HxZMt4ppHOGmseLe+peHBrAFW6Av7lbW5b+RFPOLUPM=
X-Gm-Message-State: AOJu0YxW4U6MXJX/9k+oiJDZYNXdnEjBppJ5SxSQIB5N9hQftdwqVx77
	IuLkuE4+eLLfOYjUWsYf//4rffMuu6jIdKXbT7YlaDEe9QFjZZ6x
X-Google-Smtp-Source: AGHT+IHkLykjohz3Iph/scVS9rontdt9AV3QZ4N90YQkawwDwF1I7e7z5/uJ/dJTiahpv5Euamz2aA==
X-Received: by 2002:a17:903:2311:b0:1fb:5d9e:22ab with SMTP id d9443c01a7336-1fc3caeeddemr10782635ad.22.1721096583348;
        Mon, 15 Jul 2024 19:23:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb6f46csm47732735ad.44.2024.07.15.19.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 19:23:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <114e3fd3-d7d7-41bb-a6b8-babd05ef4eab@roeck-us.net>
Date: Mon, 15 Jul 2024 19:22:58 -0700
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
 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
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

I'd suggest to name the function either pmbus_access_wait() or even simply pmbus_wait().

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

I am not too happy with this one; the delay can get large.
I'd suggest to use fsleep().

> +	} else if (info->write_delay) {
> +		delta = ktime_us_delta(ktime_get(), data->write_time);
> +
> +		if (delta < info->write_delay)
> +			udelay(info->write_delay - delta);

Same here.

Thanks,
Guenter


