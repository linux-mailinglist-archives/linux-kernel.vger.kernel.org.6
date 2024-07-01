Return-Path: <linux-kernel+bounces-236814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 381BE91E762
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296BD1C21AA0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2155116EC05;
	Mon,  1 Jul 2024 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYRlcQKb"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7FA16EB67;
	Mon,  1 Jul 2024 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858293; cv=none; b=WJNO8GaGuI9b3JC4X1ptzJ7crM0nlZ1dM9stoe5zKl9wjvIldP6T8gMfOCpO3jfuEShJG4/AwxMcYKL6NUH74Nj7+XvaYqac7XGK4DMhbSHDuv5ZQtD1T6FtjbhJnO3S5FhElw+R7KSJAU3raxX39PH5LuIsiHkBzU+4wRq3QaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858293; c=relaxed/simple;
	bh=jdQfrgOBYpndc4Fsctw4MkLVRC3/MTWv/FVWdX3Wfds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zv3QgL1NkRgoEtZaz985UC4N9uM2Qd99ZNvqI1vjQmZL1mChmIGn4rvT9a54wV5m+75OSzFZJh7hDu+ilC7Pw4MpcjjHmpCow6D59ieVZU56Q2W6BKZZDkZhQjM4/jWI7OoA31I5+hF75c/XwTH+Z5UVyyFBOx26mtqlfsVfAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYRlcQKb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f9b364faddso19046385ad.3;
        Mon, 01 Jul 2024 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719858291; x=1720463091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PkycmGNpNqpvxDu5dyJREuyztlzeKmepvD0aPuk8y+A=;
        b=dYRlcQKboH1dJQGzl8mboalWfnPhytZwSQ6Zh9LCy0e37gx8x1jXuHUS6BYWsnuQbx
         7gHqPmkIsXiJaz03FIMFQ6LqJLfRqroC5k+QGKfhCy08gBc7s+9uuozhpWdAmfi1JcVy
         pOT3r3qReAmEDptV94WG7ObQnhTEMADn0CyA8+xBRTH0YjbnBSN0Vaai2FbXGE8FlEz2
         wUKXFQefh1e5BqhF/iYkWu4PO1bqjBMZYoxeqT7NFIbd4xiSvSOL2jFYmdtoRnKtVugn
         CLEd8USVMZQSTmNb1NttlBpjuHxumJ7L+KrthBiBjbx0YRII0tb+4WCSezleoPGqnoq9
         /PXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719858291; x=1720463091;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkycmGNpNqpvxDu5dyJREuyztlzeKmepvD0aPuk8y+A=;
        b=tosogN+ApajKuc0R4Q6dtO79xe0jJPcbT/PFmP8/tVR6z0AEdERqNiUZEMvwdkLxRF
         f1qX4M4HksN1njLAqD2kXhGBTO6Em9sz8W4dy2Ih8qBt4IwXxeozrB69JCrr4XRsZRXo
         He+QiZRVH9JXXGjIq7feNajD4XMO1lMqO+8TaAbabR7syLwmpo59c/TT/QoeYMIKGHYb
         nR+nlIbcf0DU8WkJeEKLrHQbhq8w2EBZarh0W0nIb5EpFICSlC4+kMBw4bFi6tyDIr7a
         nW3o65pdkxioHFv+sGbbGB3lPrVZYufBhSykb5P02+vm/mDsGjNjQCwxOAwwe5F8J4s1
         yGGw==
X-Forwarded-Encrypted: i=1; AJvYcCUbzFdZehHR5md3Xv/95SMM0VauBdFWjgFVN6IxR7itJmJPav1KCcV2/fy4vG24RNtglVyUR0nSRV7KqNktfYFAKBqtOn75ymUw3m4=
X-Gm-Message-State: AOJu0YxiDSd9Oxuli6qDVjtZk2SWKc0tmBUdbHR1hptthYi2TnGCEDCl
	ljttfvuvBAfOpEvr2qxY5uHD9e2h3tEB2uPTpWyfEb4VF28W8/tN
X-Google-Smtp-Source: AGHT+IFb6snvZ+z2O23pZwZ6pvjYySm7UzN9xwUmSq3fbLFdKqe7ywiX7w1E/YUxY8WeDIW2nJzl3A==
X-Received: by 2002:a17:902:eb89:b0:1f7:2bfe:87a2 with SMTP id d9443c01a7336-1fadbd02041mr34513455ad.62.1719858290691;
        Mon, 01 Jul 2024 11:24:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac159686csm68112045ad.266.2024.07.01.11.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 11:24:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8ac6b3f9-7e08-470f-ad46-982a88623ba3@roeck-us.net>
Date: Mon, 1 Jul 2024 11:24:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] hwmon: (amc6821) Convert to with_info API
To: Quentin Schulz <quentin.schulz@cherry.de>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-11-linux@roeck-us.net>
 <b59cbabc-eef1-4697-8f33-276ee1967829@cherry.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <b59cbabc-eef1-4697-8f33-276ee1967829@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi uentin,

On 7/1/24 10:46, Quentin Schulz wrote:

>>           return err;
>> -    return sysfs_emit(buf, "%d\n", !!(regval & mask));
>> +    *val = (int8_t)regval * 1000;
> 
> The discussed signed_extended32() in another patch would need to make it here too.
> 
Yes. Thanks for the reminder, I had missed that one.

>> -    return sprintf(buf, "%d\n", val);
>> +    err = regmap_bulk_read(regmap, reg, regs, 2);
>> +    if (err)
>> +        return err;
>> +
>> +    regval = (regs[1] << 8) | regs[0];
>> +    *val = 6000000 / (regval ? : 1);
>> +
> 
> Just putting a "bookmark" here since we're having a discussion about this logic in another thread for another patch.
> 
> Also... missing 0 here between the question mark and the colon?
> 
It translates to
	 *val = 6000000 / (regval ? regval : 1);
which is what I had wanted (divide by regval if regval != 0,
otherwise divide by 1 [i.e., return 6000000]).

I have it now as
	*val = regval ? 6000000 / regval : 0;

>> +static int amc6821_fan_write(struct device *dev, u32 attr, long val)
>> +{
>> +    struct amc6821_data *data = dev_get_drvdata(dev);
>> +    struct regmap *regmap = data->regmap;
>> +    u8 regs[2];
>> +    int reg;
>> +
>> +    if (attr == hwmon_fan_pulses) {
>> +        if (val != 2 && val != 4)
>> +            return -EINVAL;
>> +        return regmap_update_bits(regmap, AMC6821_REG_CONF4,
>> +                     AMC6821_CONF4_PSPR,
>> +                     val == 4 ? AMC6821_CONF4_PSPR : 0);
>> +    }
>> +
>> +    if (val < 0)
>> +        return -EINVAL;
>> +
>> +    val = clamp_val(6000000 / (val ? : 1), 0, 0xffff);
>> +
> 
> And another "bookmark" here.
> 

That is now
	val = val ? 6000000 / clamp_val(val, 1, 6000000) : 0;
         val = clamp_val(val, 0, 0xffff);

'val' is checked earlier and must be > 0 for the minimum
and target fan speed.
	
>> +    switch (attr) {
>> +    case hwmon_fan_min:
>> +        reg = AMC6821_REG_TACH_LLIMITL;
>> +        break;
>> +    case hwmon_fan_max:
>> +        reg = AMC6821_REG_TACH_HLIMITL;
>> +        break;
>> +    case hwmon_fan_target:
>> +        reg = AMC6821_REG_TACH_SETTINGL;
>> +        break;
>> +    default:
>> +        return -EOPNOTSUPP;
>> +    }
>> +
>> +    regs[0] = val & 0xff;
>> +    regs[1] = val >> 8;
>> +
>> +    return regmap_bulk_write(data->regmap, reg, regs, 2);
>>   }
>>   static ssize_t temp_auto_point_temp_show(struct device *dev,
>>                        struct device_attribute *devattr,
>>                        char *buf)
>>   {
>> +    struct amc6821_data *data = dev_get_drvdata(dev);
>>       int ix = to_sensor_dev_attr_2(devattr)->index;
>>       int nr = to_sensor_dev_attr_2(devattr)->nr;
>> -    struct amc6821_data *data = dev_get_drvdata(dev);
> 
> Should be squashed with the appropriate commit?
> 

Yes, the previous one.

>>       switch (nr) {
>>       case 1:
>> @@ -423,7 +495,6 @@ static ssize_t temp_auto_point_temp_show(struct device *dev,
>>           return sprintf(buf, "%d\n",
>>               data->temp2_auto_point_temp[ix] * 1000);
>>       default:
>> -        dev_dbg(dev, "Unknown attr->nr (%d).\n", nr);
> 
> Not sure this is related? Maybe a separate commit?
> 

It should have been part of the previous commit, where it is explained ("remove
spurious debug messages which would only be seen as result of a bug in the code")

>> @@ -872,7 +902,6 @@ static int amc6821_probe(struct i2c_client *client)
>>       if (!data)
>>           return -ENOMEM;
>> -
> 
> Should be squashed with the previous commit.
> 
Ok.

> Nice clean-up albeit very difficult to review in patch form, not sure there's anything we can do about it though. Maybe migrating one attribute at a time, but I would myself not be very happy if I was asked to do it :)
> 

Yes, that is always the problem with the conversion to the with_info API.
I don't think it would make much sense to try to split it further.

Thanks a lot for the detailed review!

Guenter


