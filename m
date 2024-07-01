Return-Path: <linux-kernel+bounces-236743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0278D91E691
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF490B28444
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E079916EC12;
	Mon,  1 Jul 2024 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUPJWQ8R"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430BC16EB42;
	Mon,  1 Jul 2024 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854499; cv=none; b=VQgDLDHOHfE3PY5nXr/7pKmdQIAFLS2Dk/3awAdkONfB2SKprnKFGPSKhKw+Kx9iIWI9BxM7n9BuIDfHDFAOEOqc5yKQG8Eilq2WTMEYaeNd83cUTMkXuhZEGCaX6oX962iuqHFuEdD1BgnPaG348/AzfWi5ydT+wNSkaX7Ahho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854499; c=relaxed/simple;
	bh=fvBEfGxbvDeEkU0LVBzjvJi5HlU9aIH0/n0fuO5drKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoulyzF3SggAFt95MXtalRSZnHbnTlmdZKilrZYTkptJqcbsugQwo3ac5qNWjjebAlUX+Gb4IizVS0IwtlzMK9NyZC5c8rNH0/fnJC5KyJqhWwZp3qdpNSI5rCs8QVaFfatyQLDDQMLRzAlb5mfesBiquYbi4CV8Awk56loX/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUPJWQ8R; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1faad409ca7so27675155ad.1;
        Mon, 01 Jul 2024 10:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719854497; x=1720459297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYQt7sYYBgSS64WhWoChx0BvR4r70GpcMKF/p+V/L5M=;
        b=fUPJWQ8RCFjHwGUz4Iz6IHYzZ+riObRTHSw+1U6uBYBTtdr3uQsmLkQaCn8wkKAzbx
         CzqDaD2IFxS6E+FYP5YmPXGtNCqExW4KK05zUNI9ysNqfB+yZzcPlNiIGtszFE/zxiUf
         e5Q0Y2FFv7gQ8ol2Rwq+R382aqIHoVBH+Oun4KTf7rM0bF82MlOta0ZiaSf0ydISeru9
         gvF11qbrwPCjdcLQk1N9r/akkJ9j8MnSmFGYIp+qF3eTkPa4JoOLPUeuT6ZsHcJIsXNI
         sHdpjXdS0Qd5hUAFg9UtZj06dWjaUEDY+pMQv21frLN8Mrc604Vx7RNd/XM3387akKcJ
         nkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719854497; x=1720459297;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYQt7sYYBgSS64WhWoChx0BvR4r70GpcMKF/p+V/L5M=;
        b=fBAYubGNu9s31zn9bnVpOh+9aCNqbC3pwPpVw8Fcksois/onBJZ08htHitp4M6XFa5
         XOWFgWPIahKRHx6DlLf9Rm7JIHPgdo+JkRduh9KxWJIdGd6x65aE/hwSmjwZkRZsMshs
         s6rttEuuC7YNxrQ1RB3XnQUU1mi59IGKhQwfsm3YF2BMstuRGh7RZk/T5Jax7h/1jPpZ
         8NuihJgEPZ+2FtHW6NFj/9gkBjpZKactCOo1BhB7iU95oo5SUZvyosh4ybeg5+xI77Me
         cnEWi6ionbByRgZQ+XV7EBo2HpZCr3ElDDZW/eHrBaMqWzTLumXk+BeYSud8XjmHFpTO
         CBbg==
X-Forwarded-Encrypted: i=1; AJvYcCWUaYIkQxPeXCGr/hRrsKEhgXuuW7/2q7ImflBJT4k6iZeXMIYWjlw2I7Z5m9RR2Q9NcbSiZAakGx0agMYL8JR5QA3qaqwOnn0JL+M=
X-Gm-Message-State: AOJu0Yw+eogu4Pk5unFBNI7y4Kt/BnXigriEyRwxMMLiFbyVQhibed8b
	PoU2JgIZNK6gyoqcaGfgG31Hx7w+e6aXy3srj/lSfvhHzN0wy80G
X-Google-Smtp-Source: AGHT+IG2PfCBqiORMjEjplvDGDyOYcE/oXWnNp363oaTbcSp/L+ycEu+RBnaqs9eMlYK1ejyaCdIlg==
X-Received: by 2002:a17:902:da89:b0:1f9:c52f:d9a6 with SMTP id d9443c01a7336-1fac7e27ea6mr162721145ad.2.1719854497471;
        Mon, 01 Jul 2024 10:21:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac156957fsm67709075ad.228.2024.07.01.10.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 10:21:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8a86272c-933d-45c2-b229-ed10e65d9053@roeck-us.net>
Date: Mon, 1 Jul 2024 10:21:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] hwmon: (amc6821) Make reading and writing fan speed
 limits consistent
To: Quentin Schulz <quentin.schulz@cherry.de>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-3-linux@roeck-us.net>
 <615377cf-99bb-4159-b072-7992ccddf09d@cherry.de>
 <9fce6789-edc8-4c44-89c0-ae4ca3ec3315@roeck-us.net>
 <80a7f733-655e-4b00-a802-825d3acaafcb@roeck-us.net>
 <535f3381-2fa9-41a3-896a-8d5879546ac9@cherry.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <535f3381-2fa9-41a3-896a-8d5879546ac9@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/1/24 09:13, Quentin Schulz wrote:
> Hi Guenter,
> 
> On 7/1/24 4:37 PM, Guenter Roeck wrote:
>> On 7/1/24 07:11, Guenter Roeck wrote:
>>> On 7/1/24 04:05, Quentin Schulz wrote:
>>>> Hi Guenter,
>>>>
>>>> On 6/28/24 5:13 PM, Guenter Roeck wrote:
>>>>> The default value of the maximum fan speed limit register is 0,
>>>>> essentially translating to an unlimited fan speed. When reading
>>>>> the limit, a value of 0 is reported in this case. However, writing
>>>>> a value of 0 results in writing a value of 0xffff into the register,
>>>>> which is inconsistent.
>>>>>  > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>>> ---
>>>>>   drivers/hwmon/amc6821.c | 6 +++---
>>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
>>>>> index 3c614a0bd192..e37257ae1a6b 100644
>>>>> --- a/drivers/hwmon/amc6821.c
>>>>> +++ b/drivers/hwmon/amc6821.c
>>>>> @@ -601,7 +601,7 @@ static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
>>>>>       struct amc6821_data *data = amc6821_update_device(dev);
>>>>>       int ix = to_sensor_dev_attr(devattr)->index;
>>>>>       if (0 == data->fan[ix])
>>>>> -        return sprintf(buf, "0");
>>>>> +        return sprintf(buf, "6000000");
>>>>>       return sprintf(buf, "%d\n", (int)(6000000 / data->fan[ix]));
>>>>>   }
>>>>> @@ -625,10 +625,10 @@ static ssize_t fan_store(struct device *dev, struct device_attribute *attr,
>>>>>       int ret = kstrtol(buf, 10, &val);
>>>>>       if (ret)
>>>>>           return ret;
>>>>> -    val = 1 > val ? 0xFFFF : 6000000/val;
>>>>> +    val = val < 1 ? 0xFFFF : 6000000 / val;
>>>>>       mutex_lock(&data->update_lock);
>>>>> -    data->fan[ix] = (u16) clamp_val(val, 1, 0xFFFF);
>>>>> +    data->fan[ix] = (u16)clamp_val(val, 0, 0xFFFF);
>>>>
>>>> This is an unrelated change I believe and I would therefore have this in its own commit with proper documentation in the commit log. Indeed:
>>>>
>>>> 1- Change in fan_show handles the default 0x0 register value (which can only currently be achieved via the default value of the registers)
>>>> 2- Allow (re-)setting unlimited fan speed by allowing the user to pass 6000001+ instead of clamping it to 6000000 RPM.
>>>>
>>>
>>> Both changes are related.
>>>
>>> The whole point of this commit is to report and permit consistent values when
>>> the register value is 0. But you do have a point - reading it after my changes
>>> returns 6000000, but writing the same value sets the register to 1. So I think
>>> the proper change would be to display 6000001 as speed if the register value is
>>> 0, and provide a more detailed explanation. Would that address your concerns ?
>>>
>>
>> Ah, never  mind, I'll do it differently:
>>
>> - If the register value is 0, keep reporting 0.
> 
> Or...... maybe UINT_MAX?
> 

Problem with that is that disconnected fans would report that value as fan speed.
Traditionally drivers report a fan speed of 0 in that case.

On the other side I agree that reporting "0" as "maximum fan speed" doesn't
make much sense either because the real limit _is_ unlimited. But reporting
4294967295 in that case isn't really any better.

>> - If the value written is 0, write 0, otherwise limit the range to 1..6000000
>>    and write clamp_val(6000000 / val, 1, 0xffff)
>>
> 
> Mmmm... I'm a bit worried about the implication of writing 0 in TACH-Low-Limit, what is actually going to happen in that scenario? I assume **every** possible RPM returned by TACH-DATA will be deemed invalid/below the limit then? Reading `Fan Spin-Up` section, if FSPD bit from register 0x20 (which we don't write to yet I think?) is set to 0, a spin-up is started whenever the fan is detected to be running at too low speed. And we would also be getting an interrupt for that too-low event.
> 
> Basically, wondering if we shouldn't gate the writing of 0 to only the MAX setting?
> 

Hmm, good point, and make sense.

>> This minimizes user visibility of the changes, and also ensures that
>> the reported fan speed is 0 if the register value is 0 when reading the fan
>> speed.
>>
> 
> But didn't you say this means the fan is running at unknown 60 000 000+ RPMs? Do we really want to return 0 even if the fan is actually running? In which case max < current (possibly) but with no event happening (which I would expect, reading the datasheet).
> 

Did I say that ? If so, I must have meant something different. The register counts the
pulse period, so, yes, it would be 0 if rpm is above 6,000,000. But that is really not
realistic. In practice I don't know what the controller reports in the register if no
fan is connected - that would require real hardware which obviously I don't have.

Overall I think I'll stick with the minimum, at least for now: Permit writing 0
into the high limit register only, and otherwise keep the currently permitted ranges.

Thanks,
Guenter


