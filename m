Return-Path: <linux-kernel+bounces-236362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAB791E11F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71AF1F240CB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B52715ECC4;
	Mon,  1 Jul 2024 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5++ewdG"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1CE14B942;
	Mon,  1 Jul 2024 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841670; cv=none; b=cFtL1cDq2bWSYqcvX//MtvJdwoJR+biYvK0/yLz4ylGjW5+SU+kpErySKc06QDcrUQv2i+MWnsYbXWLFhqkoSbsGF/ILXIQvYKkjQt1XfUzMCqioO+rNl1gcMPGjmedlOxbz4B8l5u7kGjs72pY84D2DO+mxkZoQS0Q1sjIwC4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841670; c=relaxed/simple;
	bh=qniCEPeeRZE74TUxcCnyjxkMzqzF8D/uUdzbcOQf278=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlpWNpmUiazIZcCmBjhZpzW2IqEs+lOzL+XnazVVWvI1OYrJiPnf2xrDeDTpXbIDUJlaGyMkuA0tZZUrDZfpjz9p9ZCHlgeUqhxpDFr32+sia2lnHU6W9+yDjEakoGSqZGV8+F7w3TVaiKPmxnzUiH1tJScmo4lTC/m+50wQsW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5++ewdG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6fabe9da3so16521195ad.0;
        Mon, 01 Jul 2024 06:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719841668; x=1720446468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=w3JfYtaCzmtOFuO3EInBe1VgQ5x2M+77zdvc/HRL9Ok=;
        b=m5++ewdGrQHmyPyyRDPCD5Gbg+45pT8CfiHAFOgGfyuotCB9gjwTWy33edhQ/hZofQ
         CJ1QhqOkbKGYVYpb+q557+H/U1sTeGenLv7XPeWtYEe5dytMwtap49R2tY/IvLzUccXl
         kqdPdIvS8MNkTKndLnmil9bV16t/C6eJqcH94HnNOFlvdIGBNUxpmNWPAMxqxFHfyMkB
         pmoGjnEHHT0YGVna7LcqCBHpwTZKXJ3FpbgVzglNrFxIBWmmv0LPBZFwe9KE1g7GDQaU
         wvTJZNqQx4pj1rraYiqRxq2wxVrimtTEw4rGrcrjtDHO23+aozaBRJmBUU5Rz63AbTML
         jV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719841668; x=1720446468;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3JfYtaCzmtOFuO3EInBe1VgQ5x2M+77zdvc/HRL9Ok=;
        b=grgeQGnXG5y4wguX/V3ZWbeKZpcsn/QVLPLKAVmHHa2t+PBvuMjOtlZbGlLjJVME+b
         qly7h7igJTXGDKowKjuLxiqy998Zhp2pXkOlZuMSgMyFbpJff9NqQ7Ws5lRzYi4YcXQp
         r2rqLGtmdE5A6mggIzLrI2pqwBsdna90oZT8k89ahr9qltjGW8QQmeexzxl7ENwNB6FZ
         w8jKJV1XZhehmhYTd7MuZwcq4JQzynL1jbzDxYVRmv91PmVd714hq/fOTPmh+E0WnwSR
         WTPi5XGg0K1hc6bpHrI92r1yibIeujBRtaOxG50X/1cq1WUbHcVj0qvVwTUt7BD7Agir
         A7wA==
X-Forwarded-Encrypted: i=1; AJvYcCUoxfpHFKzrSBr/8nUXzceySJXxG45F+6YXwBRDTVFedGKzAm81dysIre7GGDgv3xDoLF7lS+SGLhJGEQfXj7xeg6piCLbwcz+VlOI=
X-Gm-Message-State: AOJu0YxIAqo3Hw/DFha7OqwjUWifRDugBIfLl6EmjnCe4P5TTbgmAHGL
	a/iiUWAJGPMLS1pUj05h9jHYZznJeCFkejsKdcuXCObm+GYZR0Dr0CHwSQ==
X-Google-Smtp-Source: AGHT+IE145GLdtd0X9G5WxWA+WVkBOM9++M4ET8unXX1qpvOGnJs4eI/+EKoOcs2ZIjk/vts1oqyjg==
X-Received: by 2002:a17:902:d4cd:b0:1fa:18c3:2796 with SMTP id d9443c01a7336-1fadbc9ead4mr36328325ad.25.1719841668356;
        Mon, 01 Jul 2024 06:47:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15966b1sm64809755ad.262.2024.07.01.06.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 06:47:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <13b73e86-fed0-4ef0-9815-eda765f2a70c@roeck-us.net>
Date: Mon, 1 Jul 2024 06:47:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] hwmon: (amc6821) Convert to use regmap
To: Quentin Schulz <quentin.schulz@cherry.de>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-10-linux@roeck-us.net>
 <7a829bf2-c5f6-4234-a224-52328045f581@cherry.de>
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
In-Reply-To: <7a829bf2-c5f6-4234-a224-52328045f581@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/1/24 06:01, Quentin Schulz wrote:

>> -#define AMC6821_CONF1_FDRC1        BIT(7)
>> +#define AMC6821_CONF1_FDRC1        BIT(6)
> 
> This should have been squashed with a previous commit.
> 

Yes. I had found the bug but then fixed it in the wrong patch of the series.

...
>>   static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
>>                char *buf)
>>   {
>> -    struct amc6821_data *data = amc6821_update_device(dev);
>> +    struct amc6821_data *data = dev_get_drvdata(dev);
>>       int ix = to_sensor_dev_attr(devattr)->index;
>> +    u32 regval;
> 
> Why not a u8 directly here? We know single reads are going to return a u8 so no need to store more?
> 

The parameter of regmap_read is a pointer to unsigned int.

> I'm not too fluent in type conversion, but maybe even an s8 since this is actually what's stored in the register?
> 
>> +    int err;
>> -    return sprintf(buf, "%d\n", data->temp[ix] * 1000);
>> +    err = regmap_read(data->regmap, temp_reg[ix], &regval);
>> +    if (err)
>> +        return err;
>> +
>> +    return sysfs_emit(buf, "%d\n", (int8_t)regval * 1000);
> 
> The type casting choice is odd here. Considering we'll be printing an int and that 1000 cannot be stored in an int8_t, maybe just cast it to an int directly?
> 

This is a trick which actually originates from the original code, only
there it is hidden in amc6821_update_device(). This is equivalent to
sign_extend32(regval, 7) which is more expensive, so I decided to stick
with it. On the other side, you are correct, it makes the code more
difficult to understand. I'll change it to use sign_extend32().


>>   static ssize_t temp_alarm_show(struct device *dev,
>>                      struct device_attribute *devattr, char *buf)
>>   {
>> -    struct amc6821_data *data = amc6821_update_device(dev);
>> +    struct amc6821_data *data = dev_get_drvdata(dev);
>>       int ix = to_sensor_dev_attr(devattr)->index;
>> -    u8 flag;
>> +    u32 regval, mask, reg;
> 
> Why not u8 for regval?
> 

Same as above. regmap() expects a pointer to unsigned int.


>>   static ssize_t temp2_fault_show(struct device *dev,
>>                   struct device_attribute *devattr, char *buf)
>>   {
>> -    struct amc6821_data *data = amc6821_update_device(dev);
>> -    if (data->stat1 & AMC6821_STAT1_RTF)
>> -        return sprintf(buf, "1");
>> -    else
>> -        return sprintf(buf, "0");
>> +    struct amc6821_data *data = dev_get_drvdata(dev);
>> +    u32 regval;
> 
> Ditto.
> 

Same here and everywhere else.

>>   static ssize_t pwm1_enable_store(struct device *dev,
>> @@ -383,49 +346,37 @@ static ssize_t pwm1_enable_store(struct device *dev,
>>                    const char *buf, size_t count)
>>   {
>>       struct amc6821_data *data = dev_get_drvdata(dev);
>> -    struct i2c_client *client = data->client;
>>       long val;
>> -    int config = kstrtol(buf, 10, &val);
>> -    if (config)
>> -        return config;
>> +    u32 mask;
> 
> Please rename to something else, e.g. val, as this is NOT used as a mask but rather the value to write in the masked bitfield (which is hardcoded to AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1.
> 

I'll rename it to mode.

>> +
>> +    err = regmap_update_bits(data->regmap, AMC6821_REG_CONF1,
>> +                 AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1,
>> +                 mask);
>> +    if (err < 0)
> 
> Shouldn't we check for err != 0 (so err) instead to be consistent with the rest of the code base in the driver?
> 

Ok.

>> @@ -564,38 +544,37 @@ static ssize_t pwm1_auto_point_pwm_store(struct device *dev,
>>                        const char *buf, size_t count)
>>   {
>>       struct amc6821_data *data = dev_get_drvdata(dev);
>> -    struct i2c_client *client = data->client;
>> -    int dpwm;
>> -    unsigned long val;
>> -    int ret = kstrtoul(buf, 10, &val);
>> +    struct regmap *regmap = data->regmap;
>> +    long val;
>> +    int ret;
>> +
>> +    ret = kstrtoul(buf, 10, &val);
>>       if (ret)
>>           return ret;
>> -    if (val > 255)
>> +    if (val > 254)
> 
> I think this should have been squashed with an earlier commit?
> 
Yes, another fix applied to the wrong patch.

>> @@ -603,58 +582,72 @@ static ssize_t pwm1_auto_point_pwm_store(struct device *dev,
>>   static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
>>               char *buf)
>>   {
>> -    struct amc6821_data *data = amc6821_update_device(dev);
>> +    struct amc6821_data *data = dev_get_drvdata(dev);
>>       int ix = to_sensor_dev_attr(devattr)->index;
>> -    if (0 == data->fan[ix])
>> -        return sprintf(buf, "6000000");
>> -    return sprintf(buf, "%d\n", (int)(6000000 / data->fan[ix]));
>> +    u32 regval;
>> +    u8 regs[2];
> 
> Can't this be a u16 directly.......
> 
>> +    int err;
>> +
>> +    err = regmap_bulk_read(data->regmap, fan_reg_low[ix], regs, 2);
>> +    if (err)
>> +        return err;
>> +    regval = (regs[1] << 8) | regs[0];
>> +
> 
> 
> ..... to avoid doing this here?
> 

Then it would need an endianness conversion instead. That might save a couple
of cycles, but I think it would make the code more difficult to read.

>> +    return sysfs_emit(buf, "%d\n", 6000000 / (regval ? : 1));
>>   }
>>   static ssize_t fan1_fault_show(struct device *dev,
>>                      struct device_attribute *devattr, char *buf)
>>   {
>> -    struct amc6821_data *data = amc6821_update_device(dev);
>> -    if (data->stat1 & AMC6821_STAT1_FANS)
>> -        return sprintf(buf, "1");
>> -    else
>> -        return sprintf(buf, "0");
>> +    struct amc6821_data *data = dev_get_drvdata(dev);
>> +    u32 regval;
>> +    int err;
>> +
>> +    err = regmap_read(data->regmap, AMC6821_REG_STAT1, &regval);
>> +    if (err)
>> +        return err;
>> +
>> +    return sysfs_emit(buf, "%d\n", !!(regval & AMC6821_STAT1_FANS));
>>   }
>>   static ssize_t fan_store(struct device *dev, struct device_attribute *attr,
>>                const char *buf, size_t count)
>>   {
>>       struct amc6821_data *data = dev_get_drvdata(dev);
>> -    struct i2c_client *client = data->client;
>> -    long val;
>>       int ix = to_sensor_dev_attr(attr)->index;
>> -    int ret = kstrtol(buf, 10, &val);
>> -    if (ret)
>> -        return ret;
>> -    val = val < 1 ? 0xFFFF : 6000000 / val;
>> +    u8 regs[2];
> 
> Ditto.
> 
>> +    long val;
>> +    int err;
>> +
>> +    err = kstrtol(buf, 10, &val);
>> +    if (err)
>> +        return err;
>> +
>> +    val = val < 1 ? 0xFFFF : 6000000 / val;
>> +    val = clamp_val(val, 0, 0xFFFF);
>> +
>> +    regs[0] = val & 0xff;
>> +    regs[1] = val >> 8;
>> +
> 
> to avoid this here.
> Again, this would require an endianness conversion. Sure, that would save a couple
of cycles, but it would make the code more difficult to read.

>>   static int amc6821_probe(struct i2c_client *client)
>>   {
>>       struct device *dev = &client->dev;
>>       struct amc6821_data *data;
>>       struct device *hwmon_dev;
>> +    struct regmap *regmap;
> 
> Save this variable by using data->client directly?
> 

Then I'd have to dereference it twice to check for error.
In such situations I prefer to use a separate variable.

Thanks,
Guenter


