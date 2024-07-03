Return-Path: <linux-kernel+bounces-240159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABE99269C1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72C92838B3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E0B191F8E;
	Wed,  3 Jul 2024 20:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU2NF67X"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3CB191F7C;
	Wed,  3 Jul 2024 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040140; cv=none; b=XjKvqehY19Paq7w7aQvscLL32rNHP4W5a5A0iRdaL+mOHMlTrzb3N2o6ujf5sJnfAnn9sk9PHlqOEgGSb73SmbAaAOaXtLHgTT0q37H9eGvvqi3ItvjbhWBKf19C81U68iEjvZNrGKtFOCgSHYzMaglC8m1hj6qotTtk2ZtIvOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040140; c=relaxed/simple;
	bh=GJRl0LWEIkZNtEFRfdreR1gE7v+oVSxEwSQRZH+4hpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RF7ZPI8KGzajsZHE6YN3IoL8edtCgR/zZwoePlJqjFmGGOB0cxvVNl7yBuCUMo+oWln9fufkW3TZv0/UhJW+P3t16qZUz2PXrdp6lxebl0AsI6gnO6Ug2kcCp0LdwTUNQ13h9bx/K+DY2uTonZSd9qlg+EHVB+RFNjbg7Cvug38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DU2NF67X; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-706b539fcaeso874274b3a.0;
        Wed, 03 Jul 2024 13:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720040137; x=1720644937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uQB2N3uOdGSMm95fBQpuHrjgogDhh1zsUzME7/IbVmw=;
        b=DU2NF67XhkUvVV4ypdlMiiDMKzF95cx7wu9JAKUOOAt9f/AxlXA3RKxsYZkQN17sUi
         Llk5MU63CJWM39naZES2V2leKJSKdw8KI8YdhlPTFR06x8YCBuU9dzEPSCkHpJ8tW+8l
         fl640u/KcqxKAYu2K6ppMXtrJR8kBsEJmiju29bQOlkSaseIcuioGBZUTnidWdYhaton
         OlZqnb2LqPrYDiQCLquMbECHBRbyFl4HOT4xtV3jAr62t00fnYPWKxyOxmWa5sVLGvje
         xLRo/6v2P4E2a9Hsf9mvYPWKIzLXN1GKHvOfyaEDr8L2nKD75D+7ARCuyBI7+iRyiWAI
         D2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720040137; x=1720644937;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQB2N3uOdGSMm95fBQpuHrjgogDhh1zsUzME7/IbVmw=;
        b=KNggCHU3/AzVLQ+z0S4QQQ7ZfFj6YRwt6OPWrR0+yyOlxNMptVxnOOe5MgOUpPdzif
         EPsFhgFONQ/BFP7fR+8hBpVSfBUYKqG9t8B0217m8S9dzT+sVR/4ocau6NSRgfBOplYv
         raj+UD2ZxZ1m8u74pmIFUE4v0GocEEwPnSkbbtIqICazzPKnu94/SEU08YDLDNCFyhCW
         2kHZogFjzsSa3zDg+ZTPrpsEhBqknYdY6oSGki6TBYinwIlPrMNcT4yKsUwKtCF6qw8t
         qhP9e7JbJrsa0pMxlSPNglH8biZFwhr1f137A3iHZJNiniACdFr3+kPaMxnoPuKtHSun
         +dwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLvTxYzm4DErQZSmjxqiVuVF9p4IK3bgzysONepBerVIpzD8CZZjqgvF3w8RZxo5kVE1a4hNkUFvkyBw97DV0DySZAavfd6D3QRDM=
X-Gm-Message-State: AOJu0Yxe6sB1FDPT0YZlU+CnYA7963pj1dLapNUKUmwJnZwsy/c0Oqha
	1QpbQmK8JFGUThU1dv/FPdGBQ9pvbKu2ZSgVxSk/FaZFHY5UL0u+Lcjytg==
X-Google-Smtp-Source: AGHT+IHMgY/3CHcRbCQK5DewKI8lVdMbM0r8AD3szNYyGV7fnAAxC04b4wks4R1NlVGjEXVR061zow==
X-Received: by 2002:a05:6a20:1585:b0:1bd:27da:5f20 with SMTP id adf61e73a8af0-1c0bfe8c4c0mr4543786637.6.1720040137347;
        Wed, 03 Jul 2024 13:55:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e57aa0sm10877596b3a.28.2024.07.03.13.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 13:55:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <744ba422-b683-4b87-abdc-abb5d662eed5@roeck-us.net>
Date: Wed, 3 Jul 2024 13:55:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] hwmon: (amc6821) Convert to use regmap
To: Quentin Schulz <quentin.schulz@cherry.de>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240701212348.1670617-1-linux@roeck-us.net>
 <20240701212348.1670617-10-linux@roeck-us.net>
 <015776ca-a9e0-470f-bbf5-39cec4147c6b@cherry.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <015776ca-a9e0-470f-bbf5-39cec4147c6b@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/3/24 09:19, Quentin Schulz wrote:
> Hi Guenter,
> 
> On 7/1/24 11:23 PM, Guenter Roeck wrote:
>> Use regmap for register accesses and for most caching.
>>
>> While at it, use sysfs_emit() instead of sprintf() to write sysfs
>> attribute data, and remove spurious debug messages which would
>> only be seen as result of a bug in the code.
>>
>> No functional change intended.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2: Drop another spurious debug message in this patch instead of patch 10
>>      Add missing "select REGMAP_I2C" to Kconfig
>>      Change misleading variable name from 'mask' to 'mode'.
>>      Use sysfs_emit instead of sprintf everywhere
>>
>>   drivers/hwmon/Kconfig   |   1 +
>>   drivers/hwmon/amc6821.c | 713 ++++++++++++++++++----------------------
>>   2 files changed, 329 insertions(+), 385 deletions(-)
>>
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index e14ae18a973b..a8fa87a96e8f 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -2127,6 +2127,7 @@ config SENSORS_ADS7871
>>   config SENSORS_AMC6821
>>       tristate "Texas Instruments AMC6821"
>>       depends on I2C
>> +    select REGMAP_I2C
>>       help
>>         If you say yes here you get support for the Texas Instruments
>>         AMC6821 hardware monitoring chips.
>> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
>> index 028998d3bedf..3fe0bfeac843 100644
>> --- a/drivers/hwmon/amc6821.c
>> +++ b/drivers/hwmon/amc6821.c
>> @@ -8,15 +8,16 @@
>>    * Copyright (C) 2007 Hans J. Koch <hjk@hansjkoch.de>
>>    */
>> +#include <linux/bitops.h>
>>   #include <linux/bits.h>
>>   #include <linux/err.h>
>>   #include <linux/hwmon.h>
>>   #include <linux/hwmon-sysfs.h>
>>   #include <linux/i2c.h>
>>   #include <linux/init.h>
>> -#include <linux/jiffies.h>
>>   #include <linux/module.h>
>>   #include <linux/mutex.h>
>> +#include <linux/regmap.h>
>>   #include <linux/slab.h>
>>   /*
>> @@ -44,6 +45,7 @@ module_param(init, int, 0444);
>>   #define AMC6821_REG_CONF4        0x04
>>   #define AMC6821_REG_STAT1        0x02
>>   #define AMC6821_REG_STAT2        0x03
>> +#define AMC6821_REG_TEMP_LO        0x06
>>   #define AMC6821_REG_TDATA_LOW        0x08
>>   #define AMC6821_REG_TDATA_HI        0x09
>>   #define AMC6821_REG_LTEMP_HI        0x0A
>> @@ -61,11 +63,8 @@ module_param(init, int, 0444);
>>   #define AMC6821_REG_DCY_LOW_TEMP    0x21
>>   #define AMC6821_REG_TACH_LLIMITL    0x10
>> -#define AMC6821_REG_TACH_LLIMITH    0x11
>>   #define AMC6821_REG_TACH_HLIMITL    0x12
>> -#define AMC6821_REG_TACH_HLIMITH    0x13
>>   #define AMC6821_REG_TACH_SETTINGL    0x1e
>> -#define AMC6821_REG_TACH_SETTINGH    0x1f
>>   #define AMC6821_CONF1_START        BIT(0)
>>   #define AMC6821_CONF1_FAN_INT_EN    BIT(1)
>> @@ -130,224 +129,169 @@ static const u8 fan_reg_low[] = {AMC6821_REG_TDATA_LOW,
>>               AMC6821_REG_TACH_HLIMITL,
>>               AMC6821_REG_TACH_SETTINGL, };
>> -static const u8 fan_reg_hi[] = {AMC6821_REG_TDATA_HI,
>> -            AMC6821_REG_TACH_LLIMITH,
>> -            AMC6821_REG_TACH_HLIMITH,
>> -            AMC6821_REG_TACH_SETTINGH, };
>> -
>>   /*
>>    * Client data (each client gets its own)
>>    */
>>   struct amc6821_data {
>> -    struct i2c_client *client;
>> +    struct regmap *regmap;
>>       struct mutex update_lock;
>> -    bool valid; /* false until following fields are valid */
>> -    unsigned long last_updated; /* in jiffies */
>> -    /* register values */
>> -    int temp[TEMP_IDX_LEN];
>> -
>> -    u16 fan[FAN1_IDX_LEN];
>> -    u8 fan1_pulses;
>> -
>> -    u8 pwm1;
>>       u8 temp1_auto_point_temp[3];
>>       u8 temp2_auto_point_temp[3];
>> -    u8 pwm1_auto_point_pwm[3];
>> -    u8 pwm1_enable;
>> -    u8 pwm1_auto_channels_temp;
>> -
>> -    u8 stat1;
>> -    u8 stat2;
>>   };
>> -static struct amc6821_data *amc6821_update_device(struct device *dev)
>> +static int amc6821_init_auto_point_data(struct amc6821_data *data)
>>   {
>> -    struct amc6821_data *data = dev_get_drvdata(dev);
>> -    struct i2c_client *client = data->client;
>> -    int timeout = HZ;
>> -    u8 reg;
>> -    int i;
>> +    struct regmap *regmap = data->regmap;
>> +    u32 pwm, regval;
>> +    int err;
>> -    mutex_lock(&data->update_lock);
>> +    err = regmap_read(regmap, AMC6821_REG_DCY_LOW_TEMP, &pwm);
> 
> I think this is incorrect logic.
> 
> amc6821_init_auto_point_data is only called once in init_client, in probe. While we currently do not write to AMC6821_REG_DCY_LOW_TEMP, we could in the future. But writing to it would desynchronise the auto_point_temp values for the new value of the register.
> 

We do write the register, in pwm1_auto_point_pwm_store().

> I suggest we put the logic into a function and return the value for a given temp_auto_point (1/2 currently) so that we are calling this function instead of a member in the struct so that we are never caching it unknowingly (regmap would do it for us in any case). It's a bit odd anyway to have only **those** values be cached in the struct as members and migrating everything else.

Yes, I know, that is a bit odd. Essentially I was too lazy to clean that up.
But, yes, you are correct, that results in the cached values being wrong
after AMC6821_REG_DCY_LOW_TEMP is updated. Back to the drawing board,
and thanks for finding this.

[ ... ]

>>       default:
>> -        dev_dbg(dev, "Unknown attr->index (%d).\n", ix);
> 
> Was this an intended removal? I think we can afford keeping it in?

Yes, it is intentional. It (and the others below) indicate a coding
error, which would have been found during development. While it does make
sense to keep the default: case to make the compiler happy, it doesn't
make sense to keep the pointless message in the code.

>> @@ -561,10 +538,11 @@ static ssize_t pwm1_auto_point_pwm_store(struct device *dev,
>>                        const char *buf, size_t count)
>>   {
>>       struct amc6821_data *data = dev_get_drvdata(dev);
>> -    struct i2c_client *client = data->client;
>> -    int dpwm;
>> +    struct regmap *regmap = data->regmap;
>>       u8 val;
>> -    int ret = kstrtou8(buf, 10, &val);
>> +    int ret;
>> +
>> +    ret = kstrtou8(buf, 10, &val);
> 
> Not sure this cosmetic change is worth it? Or maybe squash with an earlier commit?
> 

That slipped in, I think from the first patch of the series. I'll move it there.

>>       if (ret)
>>           return ret;
>> @@ -572,27 +550,24 @@ static ssize_t pwm1_auto_point_pwm_store(struct device *dev,
>>           return -EINVAL;
>>       mutex_lock(&data->update_lock);
>> -    data->pwm1_auto_point_pwm[1] = val;
>> -    if (i2c_smbus_write_byte_data(client, AMC6821_REG_DCY_LOW_TEMP,
>> -            data->pwm1_auto_point_pwm[1])) {
>> -        dev_err(&client->dev, "Register write error, aborting.\n");
>> -        count = -EIO;
>> -        goto EXIT;
>> +    ret = regmap_write(regmap, AMC6821_REG_DCY_LOW_TEMP, val);
>> +    if (ret)
> 
> I think we're missing a count = something here?
> 
Yes.

>> +        goto unlock;
>> +
>> +    ret = set_slope_register(regmap, AMC6821_REG_LTEMP_FAN_CTRL,
>> +                 data->temp1_auto_point_temp);
>> +    if (ret) {
>> +        count = ret;
> 
> In some places, we replace set_slope_register return code with -EIO (like it was) and sometimes we propagate it, like here. Is there some reason for this or can we have some kind of consistency across the code base here?
> 
Thanks for noticing. The code should be consistent and always propagate the error code.
I'll fix it.

Thanks,
Guenter


