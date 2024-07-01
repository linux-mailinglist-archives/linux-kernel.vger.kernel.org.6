Return-Path: <linux-kernel+bounces-236368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E304091E13E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4933C286664
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D794315ECE1;
	Mon,  1 Jul 2024 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbX9ADzP"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E9014B942;
	Mon,  1 Jul 2024 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841857; cv=none; b=ly3Qg4Q1tgnEybJt2Wo+scSorprS0514bFhW9tkthOgL32QnvCFOGJGeF2Kjp0uRGsY9/+jjPDhek3b0vhUBmBrTx69xetuumFg5pLOHt8YMihwtnMY00+zCWAnKpTcWwu4UAPBK8Y1S10b1Nobpd7WVcKVKeWb88Aea0K8xuaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841857; c=relaxed/simple;
	bh=eZlVUf2pjdJ7wx8/EG4tWngAQTnZAt+whrzVz6Q+dR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2b0eMKpgTSjSxIxjMcs28a4L/e7TWaYYnVmrFIvItz3XPoXBbJU/3Lkjy2WM4ZcLGoUj0dKymGpW2jEuScdYQBBmdzYYX/qDF328MZgiQdYc2ElExrWLmH8p4Un0e5H2gIJqntATn7+iTLSjZNWLYSabTyo8XUdcuYe2Lz8KnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbX9ADzP; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7449fbfeb6bso634012a12.2;
        Mon, 01 Jul 2024 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719841855; x=1720446655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jTqiwRiaKohs7x2y2156eaaN3UtZLenGwNHGHhqV/do=;
        b=NbX9ADzPKvtz1TJ0d9hDTgqMOk77mASWV1WmHARlnXOpeu/wX3q//bqx5Lm+k49JNc
         plTJvsoVfSNoz5d+0T/3OOcAF5ZKPDwIrSgWfHkmSAhYUuxLxiK1bK5nrS6HYTe6zjQe
         K50Kn64HheSD7vOp5MltKytFxEsi2Hl+TK9lALTAOaon3i1l9HGw/xi7M43zWpP/zC2C
         OQTa3H8crkF87U1eOC0oo7IdV2BXr4G4BnqI3UM2X9rBNDHvu2gtgddbZ3zCuF8a0+ir
         NomQVRqo8G6lQt8AdSWStwVgDTAbmmvO6d2ZRzIDBf4ec7y3YBFh/SDQLWuD5AAd2esf
         UKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719841855; x=1720446655;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTqiwRiaKohs7x2y2156eaaN3UtZLenGwNHGHhqV/do=;
        b=CPrIRRS2TXFjkYJd136bnpo4y0k/vtNIZDIx4Iam1T0kj8YXEo0bybiEONjYVp5jDE
         V++1coe6R5vD7/dX2iHHwXC4C/MAyznOd44qdIzueeQaDy9zvGqnYHf+XTYQBRTiWssK
         tFWoZKcEIVqbtvQACI2f6YBpuEJ1coOSHysvo74gZV4skQIyDQMYSWwAJUD7YnrTSqJn
         K/gTpWTv1/02Nks8eoEwpFF46px0c+qtrggNLNdkDMJabQOytG5KHOTj6WR6EZqI2AUZ
         oOPWIjWrJ2Qnla4CqisUPQ/g16sxzB7CGBKkxItmh+YBQ/uTsPzKnRtdwjAj88ShTysN
         cA+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0GUY4ouvH1QdH7wC4JNS59o0gaeP/wj+He2L3pO3faqVJGZpHIifxaxy9CaC4Hl/w3YjC79XRx7giOWmM7t0L5/u7XHciYo+q880=
X-Gm-Message-State: AOJu0Yy1FJiEBqcZmAJA5qG0fkMgtID8/IfvvvUAL07gqIVkzcxripHt
	aKPh/ChEfYPo1uD1Sq068D59zf7WBd1VG9dkNJpywmmm1uRLXIad2/H6Zw==
X-Google-Smtp-Source: AGHT+IF+/mUbUdrbWKrvyObFtgWx0zvvT2LG547+atIB2hSsurp0PtZbL4o2SDYVaxO3QRyvJ3h0jw==
X-Received: by 2002:a05:6a20:2591:b0:1b4:2f6:62b3 with SMTP id adf61e73a8af0-1bef613f539mr5085815637.26.1719841854469;
        Mon, 01 Jul 2024 06:50:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1569f83sm64570355ad.204.2024.07.01.06.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 06:50:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2569cc23-9ab8-45c8-8188-6d4547e49ecc@roeck-us.net>
Date: Mon, 1 Jul 2024 06:50:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] hwmon: (amc6821) Stop accepting invalid pwm values
To: Quentin Schulz <quentin.schulz@cherry.de>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-2-linux@roeck-us.net>
 <8fdb07b6-ef80-4faa-80cf-ea16839e9e98@cherry.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <8fdb07b6-ef80-4faa-80cf-ea16839e9e98@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/1/24 03:19, Quentin Schulz wrote:
> Hi Guenter,
> 
> On 6/28/24 5:13 PM, Guenter Roeck wrote:
>> The pwm value range is well defined from 0..255. Don't accept
>> any values outside this range.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/amc6821.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
>> index 9b02b304c2f5..3c614a0bd192 100644
>> --- a/drivers/hwmon/amc6821.c
>> +++ b/drivers/hwmon/amc6821.c
>> @@ -360,8 +360,11 @@ static ssize_t pwm1_store(struct device *dev,
>>       if (ret)
>>           return ret;
>> +    if (val < 0 || val > 255)
>> +        return -EINVAL;
>> +
> 
> Why not use kstrtoul to avoid having to check for negative val? The same way that is done just below in this patch?
> 
> Additionally, why not using kstrtou8 so we don't have to do this check ourselves in the driver?
> 

Following my desire to minimize changes, but you have a point. I'll use kstrtou8().

>>       mutex_lock(&data->update_lock);
>> -    data->pwm1 = clamp_val(val , 0, 255);
>> +    data->pwm1 = val;
>>       i2c_smbus_write_byte_data(client, AMC6821_REG_DCY, data->pwm1);
>>       mutex_unlock(&data->update_lock);
>>       return count;
>> @@ -558,13 +561,16 @@ static ssize_t pwm1_auto_point_pwm_store(struct device *dev,
>>       struct amc6821_data *data = dev_get_drvdata(dev);
>>       struct i2c_client *client = data->client;
>>       int dpwm;
>> -    long val;
>> -    int ret = kstrtol(buf, 10, &val);
>> +    unsigned long val;
>> +    int ret = kstrtoul(buf, 10, &val);
> 
> Same remark concerning kstrtou8 use.
> 
I'll use kstrtou8().

>>       if (ret)
>>           return ret;
>> +    if (val > 255)
>> +        return -EINVAL;
>> +
>>       mutex_lock(&data->update_lock);
>> -    data->pwm1_auto_point_pwm[1] = clamp_val(val, 0, 254);
> 
> We're suddenly allowing 255 as a valid value.
> 
> I don't see 255 triggering an obvious divide-by-0 issue in the code, nor any limitation from a quick look at the datasheet. 254 was introduced in the introducing commit, as well as the other 255... so probably an oversight by the original author? In any case, I would make this a separate commit or at the very least make this explicit in the commit log to show this isn't an oversight **right now** and that this change was desired.
> 

No, this is on purpose. pwm1_auto_point_pwm[2] is set to a constant
255, and pwm1_auto_point_pwm[1] has to be lower than that. As you had
noticed, I fixed this in a later commit, but I should have fixed it
here.

Thanks,
Guenter


