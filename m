Return-Path: <linux-kernel+bounces-240133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DC4926973
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29CC289EF1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF41918E74A;
	Wed,  3 Jul 2024 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ih5z7wB5"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6814413775C;
	Wed,  3 Jul 2024 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720037873; cv=none; b=fl7cDLPmL9+kKZaSmyiXl7/fMzHYpV1J9htAsJtMgKVM+ckmGTX6tgEOkqkUT8uqRBuuDHxMK+aCAtDP/nShZdBeyL8U4gyleLj57tajlDHRhl00HQD+ukTjEx3YHAP4QcJPfnYEkNdm95i/aEI8JbdWUixBGIB8V3VM059JgrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720037873; c=relaxed/simple;
	bh=8vom6xS4MzT054ZjiS65907xRz/GeCH/z4+IQqfpy/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkhpAiLiOJ1rSqEu6EEmnHANhDBRuZynUuU42fbL9txqMzim9g6TQoa0Dg1Qa+2f3azwVSFSyRtMj0LxilqcXk9YqYCGMK+iKGHnWvHTojh4S4NDIZcQSwuW40F9dT93NJ0ec4Hvcbx7AFDYsLnO1n1rAErbEC0SMvcaLiF9DWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ih5z7wB5; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7067435d376so849116b3a.0;
        Wed, 03 Jul 2024 13:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720037870; x=1720642670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LHdLMaftuIrXzImRA+8BpkKAeTrRxf+osQHtTC8XYc4=;
        b=Ih5z7wB5HE5/Y3bsCFa84RCG0LlLCPZ2BmHKJtV+VRvxeuobxZCdiIL1qxE0+oIyuI
         MWA7OqrUN6IBp+vApJEZLCV4UKIiFBWX8N5NRP3qz0bv4/SkTLwXVDl++nIQWkLek0jS
         +DlQiK87EZncLKO46ijGDOolSASf7oxruADskWwgC8qr/i0ZqJ8UZw3qL8wVB0/FADuU
         Tp92HJoflmacjLr9NlQwTJHEjkJ2e49s2b41Lbdp6rECQkOFQeSXHxUKCj1wDSKEjg0H
         LKkRgXokpj8hds0ncXMz21zzOUvrX5xC+QwsF/xFHZtwT3wA0xwkjyHyn8V6AiWQjybu
         UCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720037870; x=1720642670;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHdLMaftuIrXzImRA+8BpkKAeTrRxf+osQHtTC8XYc4=;
        b=M7cFUkTvEcdS1j9qotbvNw2L/zGVuNjnIlkZpI63y7uEu/dgRedC/i3l6+uuviYpGS
         7uWmx53rf+QVAfJqOAr3qUD9phmwJQG6CEyrnutMbBv6/DuRSSMxaZp9d86tAfhMu/I8
         MVnEGmHF21UhDBo6SVBol+eLapGGLN1x3a9Cxih0pZTRBPKW2vszgOC27No+A7Kjci9q
         1dRI0pfKKdIbiHUf7MhS4KUdexQ+UiPlSO6pOlBTpgRp+JTzn+pm0KpD/pQRFHyv3rwT
         /kkRgvbeQEsHbYwwYTNXoAkKySw1Ya2d4lm5AKZhQzPhriz984rR4NtJ8EryAxyvoBxg
         ILhw==
X-Forwarded-Encrypted: i=1; AJvYcCVK+H4AR34Cb/6bMgRjsF3G3ATUlVQLvJZ0zKTRMiER6EAw/IokyJmFGUp66D2odSEoq+KJr8Xk7M8cM3favtDvTLhBlpIm6u4OgRs=
X-Gm-Message-State: AOJu0YzhgO9TaRnqA1HzYFrmsYlcNAyOc9KY7eX+8VRvqXyeBoNw2Sos
	aJvOUSurSMBtzgOKI1NoFYmmrS/VbV1+p6CaI+GGKJ2/VnReaLL2
X-Google-Smtp-Source: AGHT+IFbz7zaZ62TQmvLWrYHSEVNTdaGIQCII9B2QuFjQFDkr/I/0aTQePsfY3WZvaTpgfBRtaTGKA==
X-Received: by 2002:a62:ab11:0:b0:706:1bfd:4e8e with SMTP id d2e1a72fcca58-70aeb3ebce8mr3574375b3a.0.1720037870338;
        Wed, 03 Jul 2024 13:17:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801f57d38sm10867948b3a.25.2024.07.03.13.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 13:17:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <846630f6-64a2-412d-8436-c71c21618461@roeck-us.net>
Date: Wed, 3 Jul 2024 13:17:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] hwmon: (amc6821) Stop accepting invalid pwm
 values
To: Quentin Schulz <quentin.schulz@cherry.de>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240701212348.1670617-1-linux@roeck-us.net>
 <20240701212348.1670617-2-linux@roeck-us.net>
 <42ab8d15-a195-42d4-a191-a25da00f4c8d@cherry.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <42ab8d15-a195-42d4-a191-a25da00f4c8d@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/3/24 07:29, Quentin Schulz wrote:
> Hi Guenter,
> 
> On 7/1/24 11:23 PM, Guenter Roeck wrote:
>> The pwm value range is well defined from 0..255. Don't accept
>> any values outside this range.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2: Use kstrtou8() instead of kstrtol() where possible.
>>      Limit range of pwm1_auto_point_pwm to 0..254 in patch 1
>>      instead of limiting it later, and do not accept invalid
>>      values for the attribute.
>>
>>   drivers/hwmon/amc6821.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
>> index 9b02b304c2f5..eb2d5592a41a 100644
>> --- a/drivers/hwmon/amc6821.c
>> +++ b/drivers/hwmon/amc6821.c
>> @@ -355,13 +355,13 @@ static ssize_t pwm1_store(struct device *dev,
>>   {
>>       struct amc6821_data *data = dev_get_drvdata(dev);
>>       struct i2c_client *client = data->client;
>> -    long val;
>> -    int ret = kstrtol(buf, 10, &val);
>> +    u8 val;
>> +    int ret = kstrtou8(buf, 10, &val);
>>       if (ret)
>>           return ret;
>>       mutex_lock(&data->update_lock);
>> -    data->pwm1 = clamp_val(val , 0, 255);
>> +    data->pwm1 = val;
>>       i2c_smbus_write_byte_data(client, AMC6821_REG_DCY, data->pwm1);
>>       mutex_unlock(&data->update_lock);
>>       return count;
>> @@ -558,13 +558,16 @@ static ssize_t pwm1_auto_point_pwm_store(struct device *dev,
>>       struct amc6821_data *data = dev_get_drvdata(dev);
>>       struct i2c_client *client = data->client;
>>       int dpwm;
>> -    long val;
>> -    int ret = kstrtol(buf, 10, &val);
>> +    u8 val;
>> +    int ret = kstrtou8(buf, 10, &val);
>>       if (ret)
>>           return ret;
>>
>> +    if (val > 254)
> 
> Would have appreciated a comment as to why it's 254. My understanding is that the subsystem requires no overlap between multiple pwm_auto_points? 0 being 0 and 2 being 255, we need 1 to be 255?
> 

No idea, really, I just took it from the original code. I don't find a hint
in the code suggesting why 255 would be worse than 0.

> Actually, that doesn't explain why we allow 0 here, so maybe I'm just clueless :)
> 
Yes, agreed, that doesn't really make sense. I'll change the upper limit to 255.

> The change itself though:
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
... but I'll also keep that tag unless you start screaming.

Thanks,
Guenter


