Return-Path: <linux-kernel+bounces-422561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B029D9BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED650B2349D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4710A1D86D6;
	Tue, 26 Nov 2024 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pw4egsMB"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB1BE46;
	Tue, 26 Nov 2024 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732637997; cv=none; b=p0bmFaylLAm4AtrJ5pgF1sOCWp/e+YLLjcT2hEio5VjCG0QmsyVizMEdm9F8u/SZFzlu5N9K17/Q7oIuCmfAE7hoPvlW19vY6mkYFdN4IWb8O5jmCAv3amwP8bC7UxCNf6W+LcjFHe8TPJaXqrSAGl22uo1AsD9rRM0Nz7taM88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732637997; c=relaxed/simple;
	bh=FhiPRm/U6mq0BfMnKIL/iYiMhkKJ4lXc+LV/dcjiXBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+QBlplXq9DNiuXxv/58ufTp+8ZdBviKagoEJSl9MFtSbdRMrqr/OMTz0XEWzgQokUCvFHgbowQSdqkPaz59eatobdQR0JD5Gj49bbxG1EH1lliibrTDCQzpu/To+s6Ium7OvOO7ruJL2/OmtdkkGY5KdXS5GOoz1/A6IIHMrLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pw4egsMB; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7251731d2b9so1363553b3a.1;
        Tue, 26 Nov 2024 08:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732637995; x=1733242795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=V29hR0InWxdFFR/+tHYnRHDZBZNTr7BCIRpsm0CfoiM=;
        b=Pw4egsMBHBXO10dG0h8xBlRkGr1VGzr888XaOB/KQyPMYgYoDfdfO8oqmaDihqKuV8
         6oZnbgdNte3sWoZwFtXNLnCnybZkGK7Y89nazN/T7X7iiV7HG/X0UrLrwZ5tkDhAhtRD
         cCerur2yd8JBAaVvG74T1goeE1k8VXeoMgZgt44Re5UUisZLZh5mhT9c7tWMksQPCMbo
         t+vwwdORxzXcoJHKektTL71bk8aek++9+EAkhbtcNmIOv3SLVJQr497NrcY+dBx5brE7
         gOC9dxk+vHA1Kjy0sDtbtj9TQGZazsVv+tcO8IPUIxNXBF19k0oz0j2hC1q4+Zb6U5Rm
         /aBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732637995; x=1733242795;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V29hR0InWxdFFR/+tHYnRHDZBZNTr7BCIRpsm0CfoiM=;
        b=lXwzrf/J/ho+oSqUUmQgSZmd2DauApBjZZJV/V3qMfSJ3ext1lRosw2+OfgC/CqGK1
         SaqY6OZxIqZOCtvF+n7Va1T5amxa6JgftOBcyVnlbuD5RrpE141wyoMVwwanIdSTmfkH
         iY1Xplk+rtAL/7XLKUXzWfwEswMhc1hP1A8TtrCoaN2T+vtV0ecFFRn773qaRsvlwCE1
         km/8BQI5P8L0Pw2XlkjeOPZ52YcrE+P6fFxJS0vWTg3xh6K6ct74MrhOrQC1kVuHUUG2
         9H8aYu9SWX5/LT0zQ0WRNEKaHV4YGQbLUOertfD+3kGIQdD+f+Iz8ckIDU3zpr85Clsc
         ZArg==
X-Forwarded-Encrypted: i=1; AJvYcCUp4o8kaScfA/aDhuRaz6h5pml2yuWIgK0ZwZe1hj1pFUj4jA4vwFaBDImdggX827/iueGa9WCDpM/3tw==@vger.kernel.org, AJvYcCXQGrnxb5CsthyGvT3ipgBX7q4+ANI1/FjpAOFRBXyM59ByRDKRzJMKf3aAD9Uh5as0eS9u3HDoVh6DyL+y@vger.kernel.org
X-Gm-Message-State: AOJu0YzoQn28EfUZ6uUiHzvzlIfroJ76nYON9tL/IIzNjQBKLlZtnNk5
	76ydQeB/zTcCB7iA2TW9C51ReqUyt2ul8F3c8rClf3lBLnJLgzEg
X-Gm-Gg: ASbGncv82n+tbWjfa6wSfsa13aPAJhqaXM8hdSPI5q01CthCSb3YhKj8SHqeDXS+YMK
	AztB6J73XTIgG2CCMngqL8goISjAaQHCcm+InYlQqadGiLwtcWUt1Yek52bURuGEDbF/kWy7gO8
	oSlc7a5qRLlHu/AFRGQlPgJQUzO24sl/J8LnYjUQgNel4h1W3dFJmSV0u5Vm/uRlbLBZ3Af0PDD
	lKtJMa+ETF9KZCmF233SS877F1mcfkM85fpj93BGxu2zyb4nr0naZjiwZqxpfhnG75QXrE3MVs5
	8tGk/jxfJdlCkQi/MR8rtI0=
X-Google-Smtp-Source: AGHT+IGz+kzVvhxh/ALOmY/pu6TM2fqtfvEAw1rr3JjVyp8eOvj8p9tU2keSBKslbJmGbcKLtz6wSQ==
X-Received: by 2002:a17:902:db09:b0:211:f10e:2dc1 with SMTP id d9443c01a7336-214e6e5af27mr68814095ad.3.1732637994105;
        Tue, 26 Nov 2024 08:19:54 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de532db3sm8547081b3a.93.2024.11.26.08.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 08:19:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <77fce1aa-96eb-4c3c-ab0a-a33de46b333b@roeck-us.net>
Date: Tue, 26 Nov 2024 08:19:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] hwmon: (acpi_power_meter) Fix using uninitialized
 variables
To: "lihuisong (C)" <lihuisong@huawei.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jdelvare@suse.com, liuyonglong@huawei.com, zhanjie9@hisilicon.com,
 zhenglifeng1@huawei.com
References: <20241125093415.21719-1-lihuisong@huawei.com>
 <20241125093415.21719-2-lihuisong@huawei.com>
 <aa6e1c02-b8bf-4d25-ad21-2018af72e16f@roeck-us.net>
 <b801388b-6bc7-5e96-dd29-e68ed8c970df@huawei.com>
 <f9fc4989-f416-4d88-bc3e-ab7b9fddb4d9@roeck-us.net>
 <c66d312a-098a-84d3-0895-02d78ae3ecc9@huawei.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <c66d312a-098a-84d3-0895-02d78ae3ecc9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/25/24 23:03, lihuisong (C) wrote:
> 
> 在 2024/11/26 12:04, Guenter Roeck 写道:
>> On 11/25/24 17:56, lihuisong (C) wrote:
>>> Hi Guente,
>>>
>>> Thanks for your timely review.
>>>
>>> 在 2024/11/26 0:03, Guenter Roeck 写道:
>>>> On 11/25/24 01:34, Huisong Li wrote:
>>>>> The 'power1_alarm' attribute uses the 'power' and 'cap' in the
>>>>> acpi_power_meter_resource structure. However, these two fields are just
>>>>> updated when user query 'power' and 'cap' attribute, or hardware enforced
>>>>> limit. If user directly query the 'power1_alarm' attribute without queryng
>>>>> above two attributes, driver will use the uninitialized variables to judge.
>>>>> In addition, the 'power1_alarm' attribute needs to update power and cap to
>>>>> show the real state.
>>>>>
>>>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>>>> ---
>>>>>   drivers/hwmon/acpi_power_meter.c | 10 ++++++++++
>>>>>   1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
>>>>> index 2f1c9d97ad21..4c3314e35d30 100644
>>>>> --- a/drivers/hwmon/acpi_power_meter.c
>>>>> +++ b/drivers/hwmon/acpi_power_meter.c
>>>>> @@ -396,6 +396,9 @@ static ssize_t show_val(struct device *dev,
>>>>>       struct acpi_device *acpi_dev = to_acpi_device(dev);
>>>>>       struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
>>>>>       u64 val = 0;
>>>>> +    int ret;
>>>>> +
>>>>> +    guard(mutex)(&resource->lock);
>>>>>         switch (attr->index) {
>>>>>       case 0:
>>>>> @@ -423,6 +426,13 @@ static ssize_t show_val(struct device *dev,
>>>>>               val = 0;
>>>>>           break;
>>>>>       case 6:
>>>>> +        ret = update_meter(resource);
>>>>> +        if (ret)
>>>>> +            return ret;
>>>>> +        ret = update_cap(resource);
>>>>> +        if (ret)
>>>>> +            return ret;
>>>>> +
>>>>>           if (resource->power > resource->cap)
>>>>>               val = 1;
>>>>>           else
>>>>
>>>>
>>>> While technically correct, the implementation of this attribute defeats its
>>>> purpose. It is supposed to reflect the current status as reported by the
>>>> hardware. A real fix would be to use the associated notification to set or
>>>> reset a status flag, and to report the current value of that flag as reported
>>>> by the hardware.
>>> I know what you mean.
>>> The Notify(power_meter, 0x83) is supposed to meet your proposal IIUC.
>>> It's good, but it depands on hardware support notification.
>>>>
>>>> If there is no notification support, the attribute should not even exist,
>>>> unless there is a means to retrieve its value from ACPI (the status itself,
>>>> not by comparing temperature values).
>>> Currently, the 'power1_alarm' attribute is created just when platform support the power meter meassurement(bit0 of the supported capabilities in _PMC).
>>> And it doesn't see if the platform support notifications.
>>>  From the current implementation of this driver, this sysfs can also reflect the status by comparing power and cap,
>>> which is good to the platform that support hardware limit from some out-of-band mechanism but doesn't support any notification.
>>>
>>
>> The point is that this can also be done from userspace. Hardware monitoring drivers
>> are supposed to provide hardware attributes, not software attributes derived from it.
>>
> So this 'power1_alarm' attribute can be exposed when platform supports hardware enforced limit and notifcations when the hardware limit is enforced, right?
> If so, we have to change the condition that driver creates this sysfs interface.

This isn't about enforcing anything, it is about reporting an alarm
if the power consumed exceeds the maximum configured.

Guenter


