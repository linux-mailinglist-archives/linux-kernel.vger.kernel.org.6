Return-Path: <linux-kernel+bounces-421849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0152D9D90E6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 05:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B73AB22235
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 04:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC9F86250;
	Tue, 26 Nov 2024 04:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzCsohWO"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E8346B5;
	Tue, 26 Nov 2024 04:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732593859; cv=none; b=Ho/8qmwyLDB4HslLcs9XGCrRKBcYcwrXucCZc+CBc0f764bNs4KWhw5Xe3ya3Er2SaN1/lnzfbaCUoV/v7n/17uAy1d7QQ+26a6OlDyHm6C0AUjESffZ68B5YO6TUNfGv9v0dcjUe1u8y/iDBzj7T9T4orECuV32dm/NaUz7xII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732593859; c=relaxed/simple;
	bh=d+K+qtXcTXEqQE1oOOF6MIeMwjieRNM+VPRpJQ1wxZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFQwCCij8sdhbiOEdMjM2Cbe5nCG8hyInwvM/LczX1G2M0L1PhZT9ErIH5mgaKBlcv/NHxw1rhZ8z93NIcMvUlHIv48HDbV5167jet/7Jo1TDrxoO793YrdTMIjwl+X4ySaoSluwrv0PtKkDYf8zlJ+WuUHfMVMKChFspBaHQ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzCsohWO; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fbd9be84bdso2941561a12.1;
        Mon, 25 Nov 2024 20:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732593857; x=1733198657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4vOWrKrcAhNKnti3UibrPmpJSl+luv6b804Oj61CoB8=;
        b=AzCsohWOXNkjGptJv3JpfOyoZX75Q+WZiqXs7KY6O4BxAeRBU3Wc46PjuLDrby/aqy
         JMoNVdfqo3IoSAAehPejin6s/NaCQjpnOy1168crl+Y1eTjdWhbMFOGXwta0qcLMmS+D
         zAfMoOAf7I6/33FtyuVn8oSKyRHaXWMPRNcm4gEPpHyWZn7hyng+b3KqZ8SuSKAQ54ex
         H3K7dUDeRSeQJ68vs0BmQ9UpHFM/0+hTqn+zjbL9R4CzQK80YSlD2njJu28qQs7HmWcL
         NZup1gzycoszIC4AzLptWOBQjnhGs3BIwPKKW6Ns7YelHbV00HsqmDNcTf1vwK5KuH+C
         eTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732593857; x=1733198657;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vOWrKrcAhNKnti3UibrPmpJSl+luv6b804Oj61CoB8=;
        b=tw++ky7dcc81tptz07aY+LbUtMpnDKoslUtXKleic9Ksd8PISvdUoz2mDpG1YD83vU
         Ed19ZS5e1WIbTbB2/aCcquuLs52PgVHaWRmGjCOoBTz+zbzv6KGnoq+k7rJWkWaeof17
         Ue/l3TjboTGdku+RGhkerCjt+NUlNVd6l7j3PlY8DeDZKONGHLumdPD1T4xAuwHRom9N
         bGNeMJTCFSMFNdeTlA/U95j1UULJ/lKKOothpb/dRdKUyjPKd1mnocvWhxlNEJcG5FHK
         WMTY+yBUnSaqb+i1QAhRJb1EMCxJDSuyCGklK5fk+tn1etuKDr79ojQfQBJ/aS1tQGRI
         +6VA==
X-Forwarded-Encrypted: i=1; AJvYcCVsThcZywaIIyYsLZpjuFR4ARFYzb/PiLaRKLugRCvA1i7GgxYAPomhQH88Xr/C7/D/iQnjwCHb08FUPQ==@vger.kernel.org, AJvYcCVvgYceJ86rXIdRsJ9FqrVSQThMNi9oacvd5ZbDD8iHmDVHWY5gD9//0utWT1qGrXRfNC5w4hQByF9UZ06Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+oQVgGCuElfATIgsQAX2ccE+eCKfs611RklxYp/qma11ocFLK
	MpHfqd9husxNDPOGeQP4Yi+pBTUU0hiMQbqGIG8gvSgY+o8GSs/E
X-Gm-Gg: ASbGncsC4Cnfhl/HWeKcNcwTmTtZWjBMWMIcYF/F+TRP8EIyiUjPHO6/HPAPxuhdNAq
	8N9bM0MtEruZsZYW+veZUGcGOZNZH/d62cY/TO45S02p/HKTaimG/uOhhmxgg/UpWhiBwwuL61D
	PyUOEEK40iCdkbXda89LP78Z6+I4P8JbL9p/7GHoZ2z5GR5ANPywJRupgwEf1aJAfZX9+M2kiSn
	tULn9c7c5Kngxrts9kUF7rhdTygS6CGslR61QtsbxxQMQy5izK13aA70zPtdVdIQOCd1/2gcddT
	gUl4FDiyR8SW/6TlIe5eJ9s=
X-Google-Smtp-Source: AGHT+IHzj3fnDR8Nr6DiROL5nrzOdsv0aZKvH0MqXikLbdmnsdPh4TY6y5iueiIp6Jza7PGizibAEw==
X-Received: by 2002:a05:6a20:3d85:b0:1db:e501:682d with SMTP id adf61e73a8af0-1e09e6316e7mr21554072637.33.1732593856758;
        Mon, 25 Nov 2024 20:04:16 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de454be0sm7355112b3a.12.2024.11.25.20.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 20:04:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f9fc4989-f416-4d88-bc3e-ab7b9fddb4d9@roeck-us.net>
Date: Mon, 25 Nov 2024 20:04:14 -0800
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <b801388b-6bc7-5e96-dd29-e68ed8c970df@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/25/24 17:56, lihuisong (C) wrote:
> Hi Guente,
> 
> Thanks for your timely review.
> 
> 在 2024/11/26 0:03, Guenter Roeck 写道:
>> On 11/25/24 01:34, Huisong Li wrote:
>>> The 'power1_alarm' attribute uses the 'power' and 'cap' in the
>>> acpi_power_meter_resource structure. However, these two fields are just
>>> updated when user query 'power' and 'cap' attribute, or hardware enforced
>>> limit. If user directly query the 'power1_alarm' attribute without queryng
>>> above two attributes, driver will use the uninitialized variables to judge.
>>> In addition, the 'power1_alarm' attribute needs to update power and cap to
>>> show the real state.
>>>
>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>> ---
>>>   drivers/hwmon/acpi_power_meter.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
>>> index 2f1c9d97ad21..4c3314e35d30 100644
>>> --- a/drivers/hwmon/acpi_power_meter.c
>>> +++ b/drivers/hwmon/acpi_power_meter.c
>>> @@ -396,6 +396,9 @@ static ssize_t show_val(struct device *dev,
>>>       struct acpi_device *acpi_dev = to_acpi_device(dev);
>>>       struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
>>>       u64 val = 0;
>>> +    int ret;
>>> +
>>> +    guard(mutex)(&resource->lock);
>>>         switch (attr->index) {
>>>       case 0:
>>> @@ -423,6 +426,13 @@ static ssize_t show_val(struct device *dev,
>>>               val = 0;
>>>           break;
>>>       case 6:
>>> +        ret = update_meter(resource);
>>> +        if (ret)
>>> +            return ret;
>>> +        ret = update_cap(resource);
>>> +        if (ret)
>>> +            return ret;
>>> +
>>>           if (resource->power > resource->cap)
>>>               val = 1;
>>>           else
>>
>>
>> While technically correct, the implementation of this attribute defeats its
>> purpose. It is supposed to reflect the current status as reported by the
>> hardware. A real fix would be to use the associated notification to set or
>> reset a status flag, and to report the current value of that flag as reported
>> by the hardware.
> I know what you mean.
> The Notify(power_meter, 0x83) is supposed to meet your proposal IIUC.
> It's good, but it depands on hardware support notification.
>>
>> If there is no notification support, the attribute should not even exist,
>> unless there is a means to retrieve its value from ACPI (the status itself,
>> not by comparing temperature values).
> Currently, the 'power1_alarm' attribute is created just when platform support the power meter meassurement(bit0 of the supported capabilities in _PMC).
> And it doesn't see if the platform support notifications.
>  From the current implementation of this driver, this sysfs can also reflect the status by comparing power and cap,
> which is good to the platform that support hardware limit from some out-of-band mechanism but doesn't support any notification.
> 

The point is that this can also be done from userspace. Hardware monitoring drivers
are supposed to provide hardware attributes, not software attributes derived from it.

Guenter


