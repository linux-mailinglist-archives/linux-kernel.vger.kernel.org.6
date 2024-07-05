Return-Path: <linux-kernel+bounces-242634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37234928AAD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7B4282D84
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BD216848F;
	Fri,  5 Jul 2024 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cy61sMY6"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1481581E3;
	Fri,  5 Jul 2024 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720189694; cv=none; b=gjbK97d2KMlpW8s3cQHXjQQKa3uFGMZc3KeQmoNANhWQrnDeQsS6Pe1VWvPqKv2/+9qSt8MV8ODH/LNLO202zO21nQcJ5wt4OpCcIeQPPRp6A86Ig4nLTe5K9Ia2Wg0QdxF64+E7zQ6GQC1rD6K0u0oEMeaXXxbWzRbuE5bxWag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720189694; c=relaxed/simple;
	bh=GWJTzrnc5dxJB/XfFLQi7Vj6y8KXDRSFYOGgsZH70LU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RUvr+QISEK9mL6yBw9UdjlIrDXlfzQKneUL2gpDCDgRN8vwWX+vp/fNvbLZSfY27NAHexF98crYjyknxdsHHPnilJFfEWccc58SlhgJ+t/LNnC/693KmudpdQtCVLJDGgOm/72v4dLtvR0nh6D7kESJlNWiWH7nhCQndYsHcOmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cy61sMY6; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70b1207bc22so397757b3a.3;
        Fri, 05 Jul 2024 07:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720189692; x=1720794492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=wyfYVKD9xtxSHAXdztHJ99V3RCNC5chxeVnRJQXUl2Y=;
        b=cy61sMY6gyOZmZkki2xXP+epgB/S8ua6N8BYqKI/5/CanfsxWam0AtYX6V9eKOCYXz
         ar36lP0qsafHbxeXGMbEeS7/ObbvZ2IpH9HcTzwOjTb7eMW3IgOg+/PnZ7mMGRrvhA95
         AgIFME4CM+UtQmZO+BzMKrxMR9qhNsne5UeGQC+uuzg1HcFC/DmMQB39U+PMkKxufZqs
         T1jzgafGXDIc6kvTSw0mcjVkVhPsN2/h81bZIyCO/zI5l98MKQGENG5vfKLUOihYhI4D
         SToE3ajDB+WPfwCUGllxbQ6RlfTtOMDIcFE810HSPYyzTeV2dAB42v+LSDkjWsOIf+oD
         IQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720189692; x=1720794492;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyfYVKD9xtxSHAXdztHJ99V3RCNC5chxeVnRJQXUl2Y=;
        b=XnmyiR5gjVo5+ytufAb2xhgrz0SMi2yjtbEgn+MLIve4ochoEZj3yZBxvQzIWPzFiX
         X/j/foYgNNGacYtHD+JE08gocllgE3rt+xZfgiWXOZkn6+rj0xKH6RlEipbU7rA+BOAX
         +4Bt/HfJkKmBk/FGfNmWH0h7UddWcWKX1GUClAmUEtc9BrCAi3jLebdqz47HAx3RFtDu
         67vi7plGelZZrzhBQ14rTCpF72JfXEFUpS+cGoPMh1miC9ljyIn4RnCxelqoVHL0MZbq
         Fx4cVlOh8Zl9pN9Qw26vuaRFEtOpfhYwhOw9WGq6n071V78pxaCwtxdo3yhsXBAHZ1r2
         ET0w==
X-Forwarded-Encrypted: i=1; AJvYcCUOHSk4lajv89nd8gxEM/Z3R0LkBeZhFFVGKlGef545HBaVUyDSZdXK3PXBeXpE37eUdutCo0nlwFZb1HU31vBXm2MqEnHapYLh2ls=
X-Gm-Message-State: AOJu0Yzgiqti/z6kc8Q++35imxBBybQECeixLTTKxRGR0/zOCy5oVwpE
	KQdIRCAQ45D+2TFKcfepda9iDl9oE9XiWsTfI6r1cBbP8ZlLQ1DpOAMLfA==
X-Google-Smtp-Source: AGHT+IFXjyereFMVHqpNRQvIERW82t+53cM2+U1LrRmpk254CTjl22TUIGokR+agzzdqyS75C3bXwg==
X-Received: by 2002:a05:6a00:3d0b:b0:706:6af8:e08a with SMTP id d2e1a72fcca58-70b00a642bbmr6010310b3a.2.1720189691579;
        Fri, 05 Jul 2024 07:28:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b13a79f23sm715491b3a.155.2024.07.05.07.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 07:28:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <949d9c32-7722-4afe-a8ae-b2ef57d1cf01@roeck-us.net>
Date: Fri, 5 Jul 2024 07:28:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/11] hwmon: (amc6821) Convert to use regmap
To: Quentin Schulz <quentin.schulz@cherry.de>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240704175207.2684012-1-linux@roeck-us.net>
 <20240704175207.2684012-10-linux@roeck-us.net>
 <773d8bea-7ddb-4138-b75c-219a52c82fc6@cherry.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <773d8bea-7ddb-4138-b75c-219a52c82fc6@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/5/24 03:59, Quentin Schulz wrote:
> Hi Guenter,
> 
> On 7/4/24 7:52 PM, Guenter Roeck wrote:
>> Use regmap for register accesses and caching.
>>
>> While at it, use sysfs_emit() instead of sprintf() to write sysfs
>> attribute data, and remove spurious debug messages which would only
>> be seen as result of a bug in the code. Also make sure that error
>> codes are propagated and not replaced with -EIO.
>>
>> While at it, introduce rounding of written temperature values and for
>> internal calculations to reduce deviation from written values and as
>> much as possible.
>>
>> No functional change intended except for differences introduced by
>> rounding.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v3: Add more details to patch description
>>      Cache all attributes
>>      Introduce rounding when writing attributes and for some calculations
>>      Always return error codes from regmap operations; never replace with
>>      -EIO
>>
>> v2: Drop another spurious debug message in this patch instead of patch 10
>>      Add missing "select REGMAP_I2C" to Kconfig
>>      Change misleading variable name from 'mask' to 'mode'.
>>      Use sysfs_emit instead of sprintf everywhere
>>
>>
>>   drivers/hwmon/Kconfig   |   1 +
>>   drivers/hwmon/amc6821.c | 812 ++++++++++++++++++----------------------
>>   2 files changed, 373 insertions(+), 440 deletions(-)
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
>> index 295a9148779d..a5abd36a1430 100644
>> --- a/drivers/hwmon/amc6821.c
>> +++ b/drivers/hwmon/amc6821.c
>> @@ -8,15 +8,18 @@
>>    * Copyright (C) 2007 Hans J. Koch <hjk@hansjkoch.de>
>>    */
>> +#include <linux/bitfield.h>
>> +#include <linux/bitops.h>
>>   #include <linux/bits.h>
>>   #include <linux/err.h>
>>   #include <linux/hwmon.h>
>>   #include <linux/hwmon-sysfs.h>
>>   #include <linux/i2c.h>
>>   #include <linux/init.h>
>> -#include <linux/jiffies.h>
>> +#include <linux/minmax.h>
>>   #include <linux/module.h>
>>   #include <linux/mutex.h>
>> +#include <linux/regmap.h>
>>   #include <linux/slab.h>
>>   /*
>> @@ -44,6 +47,7 @@ module_param(init, int, 0444);
>>   #define AMC6821_REG_CONF4        0x04
>>   #define AMC6821_REG_STAT1        0x02
>>   #define AMC6821_REG_STAT2        0x03
>> +#define AMC6821_REG_TEMP_LO        0x06
>>   #define AMC6821_REG_TDATA_LOW        0x08
>>   #define AMC6821_REG_TDATA_HI        0x09
>>   #define AMC6821_REG_LTEMP_HI        0x0A
>> @@ -61,11 +65,8 @@ module_param(init, int, 0444);
>>   #define AMC6821_REG_DCY_LOW_TEMP    0x21
>>   #define AMC6821_REG_TACH_LLIMITL    0x10
>> -#define AMC6821_REG_TACH_LLIMITH    0x11
>>   #define AMC6821_REG_TACH_HLIMITL    0x12
>> -#define AMC6821_REG_TACH_HLIMITH    0x13
>>   #define AMC6821_REG_TACH_SETTINGL    0x1e
>> -#define AMC6821_REG_TACH_SETTINGH    0x1f
>>   #define AMC6821_CONF1_START        BIT(0)
>>   #define AMC6821_CONF1_FAN_INT_EN    BIT(1)
>> @@ -108,6 +109,9 @@ module_param(init, int, 0444);
>>   #define AMC6821_STAT2_L_THERM        BIT(6)
>>   #define AMC6821_STAT2_THERM_IN        BIT(7)
>> +#define AMC6821_TEMP_SLOPE_MASK        GENMASK(2, 0)
>> +#define AMC6821_TEMP_LIMIT_MASK        GENMASK(7, 3)
>> +
>>   enum {IDX_TEMP1_INPUT = 0, IDX_TEMP1_MIN, IDX_TEMP1_MAX,
>>       IDX_TEMP1_CRIT, IDX_TEMP2_INPUT, IDX_TEMP2_MIN,
>>       IDX_TEMP2_MAX, IDX_TEMP2_CRIT,
>> @@ -130,224 +134,155 @@ static const u8 fan_reg_low[] = {AMC6821_REG_TDATA_LOW,
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
>> -
>> -    /* register values */
>> -    int temp[TEMP_IDX_LEN];
>> -
>> -    u16 fan[FAN1_IDX_LEN];
>> -    u8 fan1_pulses;
>> -
>> -    u8 pwm1;
>> -    u8 temp1_auto_point_temp[3];
>> -    u8 temp2_auto_point_temp[3];
>> -    u8 pwm1_auto_point_pwm[3];
>> -    u8 pwm1_enable;
>> -    u8 pwm1_auto_channels_temp;
>> -
>> -    u8 stat1;
>> -    u8 stat2;
>>   };
>> -static struct amc6821_data *amc6821_update_device(struct device *dev)
>> +/*
>> + * Return set of three temperatures:
> 
> It actually returns 0 if successful, negative errno otherwise (matches regmap_* return values).
> 
I'll rephrase.

> But it does write to temps array with those values.
> 
> Would be nice to say what we're expecting in channel, i.e. 0 for Remote and 1 for Local.
> 

1 for remote

>> + * temps[0]: Passive cooling temperature, applies to both channels
>> + * temps[1]: Low temperature, start slope calculations
>> + * temps[2]: High temperature
>> + */
> 
> IIUC, we have different units there, >> 3 (/4) °C for 0 and 2, but °C for temps[1] ? If I didn't misunderstand, I think it's worth making it explicit in the docs (or make them have the same unit).
> 

It should be all in °C.

>> +static int amc6821_get_auto_point_temps(struct regmap *regmap, int channel, u8 *temps)
>>   {
>> -    struct amc6821_data *data = dev_get_drvdata(dev);
>> -    struct i2c_client *client = data->client;
>> -    int timeout = HZ;
>> -    u8 reg;
>> -    int i;
>> +    u32 pwm, regval;
>> +    int err;
>> -    mutex_lock(&data->update_lock);
>> +    err = regmap_read(regmap, AMC6821_REG_DCY_LOW_TEMP, &pwm);
>> +    if (err)
>> +        return err;
>> -    if (time_after(jiffies, data->last_updated + timeout) ||
>> -            !data->valid) {
>> +    err = regmap_read(regmap, AMC6821_REG_PSV_TEMP, &regval);
>> +    if (err)
>> +        return err;
>> +    temps[0] = regval;
>> -        for (i = 0; i < TEMP_IDX_LEN; i++)
>> -            data->temp[i] = (int8_t)i2c_smbus_read_byte_data(
>> -                client, temp_reg[i]);
>> +    err = regmap_read(regmap,
>> +              channel ? AMC6821_REG_RTEMP_FAN_CTRL : AMC6821_REG_LTEMP_FAN_CTRL,
>> +              &regval);
>> +    if (err)
>> +      return err;
>> +    temps[1] = (regval & 0xF8) >> 1;
> 
> I think we want to use AMC6821_TEMP_LIMIT_MASK here instead of 0xF8?
> 
> I guess we could also use FIELD_GET?
> 

Yes. The value in the register is in °C * 4, so that is going to be
	temps[1] = FIELD_GET(regval, AMC6821_TEMP_LIMIT_MASK) * 4;
which improves readability and should also clarify the units a bit
better.

Note hat
	(regval & 0xF8) >> 1;
resulted in the temperature in °C (shift right 1 instead of 3).

>> -        data->stat1 = i2c_smbus_read_byte_data(client,
>> -            AMC6821_REG_STAT1);
>> -        data->stat2 = i2c_smbus_read_byte_data(client,
>> -            AMC6821_REG_STAT2);
>> +    regval &= 0x07;
> 
> I think we want to use AMC6821_TEMP_SLOPE_MASK instead of 0x07 here?
> 
> I guess we could also use FIELD_GET?
> 
Done, making it
	regval = BIT(5) >> FIELD_GET(regval, AMC6821_TEMP_SLOPE_MASK);

> [...]
> 
>>   static ssize_t temp_auto_point_temp_store(struct device *dev,
>>                         struct device_attribute *attr,
>>                         const char *buf, size_t count)
>>   {
>> -    struct amc6821_data *data = amc6821_update_device(dev);
>> -    struct i2c_client *client = data->client;
>> +    struct amc6821_data *data = dev_get_drvdata(dev);
>>       int ix = to_sensor_dev_attr_2(attr)->index;
>>       int nr = to_sensor_dev_attr_2(attr)->nr;
>> -    u8 *ptemp;
>> -    u8 reg;
>> -    int dpwm;
>> +    struct regmap *regmap = data->regmap;
>> +    u8 temps[3], otemps[3];
>>       long val;
>> -    int ret = kstrtol(buf, 10, &val);
>> +    int ret;
>> +
>> +    ret = kstrtol(buf, 10, &val);
>>       if (ret)
>>           return ret;
>> -    switch (nr) {
>> -    case 1:
>> -        ptemp = data->temp1_auto_point_temp;
>> -        reg = AMC6821_REG_LTEMP_FAN_CTRL;
>> -        break;
>> -    case 2:
>> -        ptemp = data->temp2_auto_point_temp;
>> -        reg = AMC6821_REG_RTEMP_FAN_CTRL;
>> -        break;
>> -    default:
>> -        dev_dbg(dev, "Unknown attr->nr (%d).\n", nr);
>> -        return -EINVAL;
>> -    }
>> -
>>       mutex_lock(&data->update_lock);
>> -    data->valid = false;
>> +
>> +    ret = amc6821_get_auto_point_temps(data->regmap, nr, temps);
>> +    if (ret)
>> +        goto unlock;
>> +    ret = amc6821_get_auto_point_temps(data->regmap, 1 - nr, otemps);
>> +    if (ret)
>> +        goto unlock;
> 
> We could reduce the scope of otemps since it's only used in the ix==0 case below.
> 
Done.

>>       switch (ix) {
>>       case 0:
>> -        ptemp[0] = clamp_val(val / 1000, 0,
>> -                     data->temp1_auto_point_temp[1]);
>> -        ptemp[0] = clamp_val(ptemp[0], 0,
>> -                     data->temp2_auto_point_temp[1]);
>> -        ptemp[0] = clamp_val(ptemp[0], 0, 63);
>> -        if (i2c_smbus_write_byte_data(
>> -                    client,
>> -                    AMC6821_REG_PSV_TEMP,
>> -                    ptemp[0])) {
>> -                dev_err(&client->dev,
>> -                    "Register write error, aborting.\n");
>> -                count = -EIO;
>> -        }
>> -        goto EXIT;
>> +        /*
>> +         * Passive cooling temperature. Range limit against low limit
>> +         * of both channels.
>> +         */
>> +        val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 63000), 1000);
> 
> This was already in the original code, but I think 64°C should be doable as well? The datasheet says:
> 
> """
> The PSV ranges from 0°C to +64°C.
> """
> 

Yes, but I am sure the datasheet is wrong here. The register has 6 active bits,
which means the highest possible value is 0x3f or 63.

> And there's a PSV8 bit we can write, meaning we can do (1 << 8) with a step of 4°C which gives us 64°C? In a separate commit though, to not mix too many fixes into one, making it easier for people to identify and possibly revert them if necessary.
> 
Not sure I understand. Can you clarify ?

Temperature bit assignments in the datasheet are confusing. PSV3
means full degrees C, PSV8 means 32 degrees C. That is all in one register.
On the other side, L-TEMP0 reflects _4_ degrees C.

Am I missing something ?

>> +        val = clamp_val(val, 0, min(temps[1], otemps[1]));
>> +        ret = regmap_write(regmap, AMC6821_REG_PSV_TEMP, val);
>> +        break;
>>       case 1:
>> -        ptemp[1] = clamp_val(val / 1000, (ptemp[0] & 0x7C) + 4, 124);
>> -        ptemp[1] &= 0x7C;
>> -        ptemp[2] = clamp_val(ptemp[2], ptemp[1] + 1, 255);
>> +        /*
>> +         * Low limit; must be between passive and high limit,
>> +         * and not exceed 124. Step size is 4 degrees C.
>> +         */
>> +        val = clamp_val(val, DIV_ROUND_UP(temps[0], 4) * 4000, 124000);
> 
> Oof. I think the issue is that we have different units for temps[0], temps[1] and temps[2]?
> 
> temps[1] is in °C, while temps[0] is in °C >> 3 (so / 4) because we read from PSV-Temp register directly, which only exposes PSV[8:3] and PSV[2:0] are 0. I'm wondering if we shouldn't just have the same unit when filled by amc6821_get_auto_point_temps?
> 
No, they are all in °C. I think the confusion arises from L-TEMP[0..4] which is in multiples
of 4 °C. Since L-TEMP needs to be in multiples of 4 degrees C, and temps[0] is in degrees C,
the above sets the lower limit to the next multiple of 4 °C at or above temps[0].
The upper limit is 124 degrees C per datasheet.

> temps[2] is also °C >> 3 (4°C step in the register). I think we would benefit from having the same unit here to make it easier to do maths with temps[1] and temps[0/2]. What do you think?
> 
> If we didn't have this °C >> 3 formula, we could simply divide by 1000 to get the value and then do the same maths for writing to the registers (except a different offset for temps[0] than temps[1/2]).
> 
> 
>> +        temps[1] = DIV_ROUND_CLOSEST(val, 4000) * 4;

The DIV_ROUND_CLOSEST() here is to improve rounding to 4 degrees C. The resulting value
in temp[1] is {0, 4, 8, ... 124}.

>> +        val = temps[1] / 4;

This is the register value to be written.

>> +        /* Auto-adjust high limit if necessary */
>> +        temps[2] = clamp_val(temps[2], temps[1] + 1, 255);
> 
> Is this why we didn't want 255 for temps[1]? Because then we could have 256 here?
> 

The highest possible value for temps[1] is 124, so the lower clamp value
would never be 256. The above only ensures that temps[2] is > temps[1].

>> +        ret = regmap_update_bits(regmap,
>> +                     nr ? AMC6821_REG_RTEMP_FAN_CTRL
>> +                        : AMC6821_REG_LTEMP_FAN_CTRL,
>> +                     AMC6821_TEMP_LIMIT_MASK,
>> +                     FIELD_PREP(AMC6821_TEMP_LIMIT_MASK, val));
>> +        if (ret)
>> +            break;
>> +        ret = set_slope_register(regmap, nr, temps);
> 
> I'm wondering if we shouldn't put the writes to the TEMP_LIMIT_MASK and AMC6821_TEMP_SLOPE_MASK into the same regmap write, otherwise there's a small timeframe during which the slope is not matching the TEMP_LIMIT. I guess it's probably not that big of a deal but still bringing this up.
> 

Hmm, you mean to let set_slope_register() also update the low temperature limit
based on temps[1] ? Excellent idea. I'll do that; it will save a register write
to the chip.

Thanks,
Guenter


