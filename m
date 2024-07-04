Return-Path: <linux-kernel+bounces-241554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FDA927C82
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619E02841BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4F950A63;
	Thu,  4 Jul 2024 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4cE2MG7"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5960739FC1;
	Thu,  4 Jul 2024 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115407; cv=none; b=coQYTuXqNCL+TUQD0+Dcsx/cCIIWoaHjmN0D+AyQAc05nfmFhuvZXOEoFQJ/Y6wAajhYNd3/yQdRJYdz45lbOlRXPcMObAQzYo3Qpit+lT+bFpLHfciwTXm85RkaiDC8kyjVR8qtd2/Uquv//FXUOP+ZJCTZtz5ChzP7Scqyfnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115407; c=relaxed/simple;
	bh=HVgcWe0qTyiaehe+NbUAH2Ic7vUQvKGqeeo0q+/fh4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDA50GWVEl7ExDZWdzOck7D0WNUIwLzC7Ok4nk8EcHREhifHFgRDm4dqQsBJoQCuvbuzrG1I91IShV8C5tkzWEaqN73VjmgvxEpYsDK5Cr1OBaRmdfVXdyEBEln4NsgCsdgwpnWle29hYQ6FBgmYGk5b+QNSPUH3HblaoWVrL7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4cE2MG7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fafc9e07f8so5558465ad.0;
        Thu, 04 Jul 2024 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720115404; x=1720720204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DdhqWX65Yn1Fxl0pNOiGXktgdN2Ej4vHP2xLPm1fR8k=;
        b=Y4cE2MG7y5Irk7V5ax2zvd6c/Ii2+wL09Lpz4HTTEjFkQiS3gw6xfJKwTc9Ih822wq
         JFtpyamHcGgeI1xYb4bUC2iyQ2w7cLziXy5LZT/jsxORvt4jP5v6xwHdEjYPgbY4M2i8
         NYxweQKxudnFfFuw5T78d8B4ImNjhw1vJ9R/TuX4GU+jvaOL5mPOGbBZjOS07HthfsF+
         ehCFgHmXWvM1pF4GigMRwYkji+asCMwrkHCFsR/UFkeEamgTIuDzL4tVMb5LuYfKNCk5
         f3wTV5LQawERhavbg085HS0txkIQHPoEvZt8iq1cJRBcZjAPj9HvUvDRK8FBj2JVJe+y
         yNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720115404; x=1720720204;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdhqWX65Yn1Fxl0pNOiGXktgdN2Ej4vHP2xLPm1fR8k=;
        b=P8GOU/i/3tJrD5gycapSj+8Ld2O6O4fVcdpuEWD6GoZK3LgLKS5vlivoHkJBYCJB/Q
         8ufnTYiRnms5nVnn8dI9tPMB58BFOi5IDib4UYECsxkbw7y22kFJ6xBDNl0uPxMGTGjS
         W+V9YNfqYwcV9tjQMfUYctUP/6MnQu+gtOT42JKKIMs5uqaxRvrNRwOBJwtfjxi9Ja6+
         hDMKfzgZYqIeqZUnmEVqS9nHwtMWBoehgFq+Rycwfu7zXEoCg8OSn12j0wE9l+iK+nLA
         bJAMXSla3FS6ASaK+sjiAbL/UmlJ+w6Uv9z2TfwdZM9Sr3IpDUU2//TExusqgj/QUYy8
         YZqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAhckNjldJT2n4kExtbutMUp7/bmv1E1i0q5yQTw9m97TA4gok904PVokPWNnsUBm+v01hfoKgnJ4IN+YMsHcT+k5ul2kE2neJirQ=
X-Gm-Message-State: AOJu0YxfRyydAmQNWAIzvJKZtJJVTR6uROfEhDBkqc6uLn6ocrlD+VT+
	w9BehsvguFSyW1kNWvzOANIJzLf3r5bQrHLK8hcxmMViZj0+b8c3
X-Google-Smtp-Source: AGHT+IGQvaca3khDAdN+47geUA+yvPBXhdtS/XZ288uqkPrAZBusHsX6cVrI4/55QMs235g9hafDiQ==
X-Received: by 2002:a17:902:f682:b0:1fb:39cf:fe6d with SMTP id d9443c01a7336-1fb39d00203mr15266935ad.32.1720115404349;
        Thu, 04 Jul 2024 10:50:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb438a7890sm3713395ad.185.2024.07.04.10.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 10:50:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b556e39d-93f4-42e6-a702-715f5498d3d9@roeck-us.net>
Date: Thu, 4 Jul 2024 10:50:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] hwmon: (amc6821) Make reading and writing fan
 speed limits consistent
To: Quentin Schulz <quentin.schulz@cherry.de>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240701212348.1670617-1-linux@roeck-us.net>
 <20240701212348.1670617-3-linux@roeck-us.net>
 <750d28c7-4d90-4bd6-a910-4d5e73828e55@cherry.de>
 <8cb9dc38-499e-4f10-93a4-c07898a776b4@roeck-us.net>
 <56ed417c-1dc2-474b-a2bc-5f17e1d2bd60@cherry.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <56ed417c-1dc2-474b-a2bc-5f17e1d2bd60@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/4/24 00:52, Quentin Schulz wrote:
> Hi Guenter,
> 
> On 7/3/24 11:48 PM, Guenter Roeck wrote:
>> On 7/3/24 07:35, Quentin Schulz wrote:
>>> Hi Guenter,
>>>
>>> On 7/1/24 11:23 PM, Guenter Roeck wrote:
>>>> The default value of the maximum fan speed limit register is 0,
>>>> essentially translating to an unlimited fan speed. When reading
>>>> the limit, a value of 0 is reported in this case. However, writing
>>>> a value of 0 results in writing a value of 0xffff into the register,
>>>> which is inconsistent.
>>>>
>>>> To solve the problem, permit writing a limit of 0 for the maximim fan
>>>> speed, effectively translating to "no limit". Write 0 into the register
>>>> if a limit value of 0 is written. Otherwise limit the range to
>>>> <1..6000000> and write 1..0xffff into the register. This ensures that
>>>> reading and writing from and to a limit register return the same value
>>>> while at the same time not changing reported values when reading the
>>>> speed or limits.
>>>>
>>>> While at it, restrict fan limit writes to non-negative numbers; writing
>>>> a negative limit does not make sense and should be reported instead of
>>>> being corrected.
>>>>
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> ---
>>>> v2: Do not accept negative fan speed values
>>>>      Display fan speed and speed limit as 0 if register value is 0
>>>>      (instead of 6000000), as in original code.
>>>>      Only permit writing 0 (unlimited) for the maximum fan speed.
>>>>
>>>>   drivers/hwmon/amc6821.c | 13 +++++++++----
>>>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
>>>> index eb2d5592a41a..9c19d4d278ec 100644
>>>> --- a/drivers/hwmon/amc6821.c
>>>> +++ b/drivers/hwmon/amc6821.c
>>>> @@ -617,15 +617,20 @@ static ssize_t fan_store(struct device *dev, struct device_attribute *attr,
>>>>   {
>>>>       struct amc6821_data *data = dev_get_drvdata(dev);
>>>>       struct i2c_client *client = data->client;
>>>> -    long val;
>>>> +    unsigned long val;
>>>>       int ix = to_sensor_dev_attr(attr)->index;
>>>> -    int ret = kstrtol(buf, 10, &val);
>>>> +    int ret = kstrtoul(buf, 10, &val);
>>>>       if (ret)
>>>>           return ret;
>>>> -    val = 1 > val ? 0xFFFF : 6000000/val;
>>>> +
>>>> +    /* The minimum fan speed must not be unlimited (0) */
>>>> +    if (ix == IDX_FAN1_MIN && !val)
>>>> +        return -EINVAL;
>>>> +
>>>> +    val = val > 0 ? 6000000 / clamp_val(val, 1, 6000000) : 0;
>>>
>>> I'm wondering if we shouldn't check !val for min after this line instead? Otherwise we allow 6000001+RPM speeds... which is technically unlimited.
>>>
>>
>> If ix == IDX_FAN1_MIN, val must be positive because of the check above.
>> The expression "6000000 / clamp_val(val, 1, 6000000)" is therefore always
>> positive as well because val is clamped. Its minimum result would be
>> 6000000/6000000 = 1. The alternate case of the ternary expression would
>> never hit because it is guaranteed that val > 0. Am I missing something ?
>>
> 
> No, I misread the code and I didn't see the clamp_val, which means we cannot have the denominator be > 6000000, meaning val cannot be 0 after that line (well, except if it is 0 **before** already).
> 
> So no, just brain fart.
> 
> Also, we probably could swap clamp_val(val, 1, 6000000) for min(val, 6000000) as val > 0 because of the ternary operator condition. But that's nothing important nor interesting.
> 

Good point. I may do that if I have to send v4 (if I remember), but for now the
existing code should be good enough.

Thanks,
Guenter


