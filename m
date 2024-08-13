Return-Path: <linux-kernel+bounces-285357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B5F950C76
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796E4282328
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F4B1A3BA8;
	Tue, 13 Aug 2024 18:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFcmo6lT"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7061317E8EA;
	Tue, 13 Aug 2024 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723574627; cv=none; b=Suc/4E3v/kIiv2qdan7vrjTqoOn8NVzvQA5O1SnCFvTYPKhnBlKSXtooaCbQMaYuC1QSE4eUcDuRZPlC+rIGGm+i4ZpQwwgxgQMDIzYT6JXLf7JjI/LtsfLBpXYI3YQGC1RNg30LrgoZ+F4V89Lcud2/6T/MAoVprUaCfZDCvig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723574627; c=relaxed/simple;
	bh=v/4/ExDEMVxaShKSRYrGg01MqXd0Urhg4o8Onty+r5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tP6eY3OWztdkBw5oMf8wVZjmFwcVRC5xDo6anfkJ53UWmAf0sCNiNx7vGOuKnGRkj/MFzpG24iW3Q/BDuXtBk3PTWbu9fSr1AQ0Vc1xuXG4KcvXpdOa7JV3y/ZtaWnqjLeaz0n2Fk6zSJnFxec8yN+CLDBNvVIU/Sd4huMkBM5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFcmo6lT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so43570465e9.3;
        Tue, 13 Aug 2024 11:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723574624; x=1724179424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qz/Yyw0OTE1YQiF2rKw+64GCde443sgt4oa5jF1x0Kg=;
        b=FFcmo6lTQx/Zeq3Jiix4mDJZ9VxXMBuemD5oUoIBKtTMeKmc1FVBE/Y8rw28dPJc4E
         lObu8JSRju4IwI8eGbSe62AlwCl83b9zMz3zPV5qtJ6wLldKlYKn7RCuCcOmsFiacDzI
         VFhtLmSA4eSUS5aZ4u5XCuAhXbaCV/Pb3hUCDJDroNSjNTxkYYC+IMH7+KZw3cPc45uV
         HziKdKs6mwp635E4kiHfNc4et5x3jrDUQ4yR4v97VZ1QNFvKQgIjsr1vSsCtvTXoZIKA
         RmvIBnvZNdVFvImgYir5ehVl7Y03RKIbu+lMiIPPf1RPUPEbitv3dts41YMUewUyky+c
         9+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723574624; x=1724179424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qz/Yyw0OTE1YQiF2rKw+64GCde443sgt4oa5jF1x0Kg=;
        b=FpfxQJFYa4lX01pYdHo3/YKE8Gv6q5CDv6U74dpST5u28yupRup1jA4FY3LajdAdOU
         MUqxSUI7NRFzkhE3/oAjAYRVakZIgQuqkApX6VwA7Ck1hxVpR3I1I704morpENbBb5PR
         aRrOE6VzWrATAEWJjPx5DUmQWa0mx+KJnLfzaVehbqj44SQDmBWA4wKOP52INttSfIC3
         HH6Ipzka3l7//bnpCk1HuqnLx/ZiYPyqi3+uLVpnWs6LczNZzS+9ai7vopCBvcmMseEY
         X7Jdx5I813YW8q1IcA5tENFu/7969BtwdtbxiWGSUK8idz5h5pvJFM8iVcjXHkXvvS9j
         2V9g==
X-Forwarded-Encrypted: i=1; AJvYcCVq8iyydm2jfTvBmcaTvEG6WiLNVKo7bg65ZdzNrDdimGqbZuzi7sJ5Bg6x+yegg9Q+DG/wSpEonZNWl8Rgg6zCQ+U3Is4pZWGhFUnaujd2HS5jCVg5N3OKofF6EiEWO2cF+GGpzbOTetE=
X-Gm-Message-State: AOJu0YyZXkYIngwIP/8kopXpAT9iq5oAWP83HZHA+97dcQNkMG0GEPQr
	VfEKJoAu8fa0kZ53lDUvB/cuRWnNbaJenMkSylFKpbKGbyCtDeEf
X-Google-Smtp-Source: AGHT+IF6iSPxAwa6LBbQRjq4iy5sc6KVkpOTKR3k3/k643p6ZlGS13e871eo392o9zODICjlN92jsw==
X-Received: by 2002:a05:600c:1e0c:b0:426:6e95:78d6 with SMTP id 5b1f17b1804b1-429dd22fe6dmr3220735e9.4.1723574623649;
        Tue, 13 Aug 2024 11:43:43 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c77372b9sm149493435e9.35.2024.08.13.11.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 11:43:43 -0700 (PDT)
Message-ID: <70b83fe7-102c-41ea-9d9a-36f1d99b5f4e@gmail.com>
Date: Tue, 13 Aug 2024 20:43:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (surface_fan) Change dependency on
 SURFACE_AGGREGATOR_BUS to 'select'
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240810214709.425095-1-luzmaximilian@gmail.com>
 <0d8bc971-7780-42a2-8617-aeb3bb9bbfd1@gmail.com>
 <4f048dcb-876f-4900-9ab9-3df03aedff9b@roeck-us.net>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <4f048dcb-876f-4900-9ab9-3df03aedff9b@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/12/24 6:44 AM, Guenter Roeck wrote:
> On 8/10/24 16:20, Maximilian Luz wrote:
>> On 8/10/24 11:47 PM, Maximilian Luz wrote:
>>> The SURFACE_AGGREGATOR_BUS option specifies whether SAM bus support is
>>> build into the SAM controller driver or not. The surface_fan module
>>> requires this, due to which it has a dependency on the option.
>>>
>>> However, from an end-user perspective, it makes more sense to
>>> automatically enable the option when choosing to include the fan driver,
>>> rather than requiring the user to know that they have to enable bus
>>> support first before they get shown the option for the fan driver.
>>>
>>> Therefore change the 'depends on' to 'select'.
>>>
>>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>>> ---
>>>   drivers/hwmon/Kconfig | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>>> index b60fe2e58ad6..e4d9a035a57a 100644
>>> --- a/drivers/hwmon/Kconfig
>>> +++ b/drivers/hwmon/Kconfig
>>> @@ -2069,7 +2069,7 @@ config SENSORS_SFCTEMP
>>>   config SENSORS_SURFACE_FAN
>>>       tristate "Surface Fan Driver"
>>>       depends on SURFACE_AGGREGATOR
>>> -    depends on SURFACE_AGGREGATOR_BUS
>>> +    select SURFACE_AGGREGATOR_BUS
>>>       help
>>>         Driver that provides monitoring of the fan on Surface Pro devices that
>>>         have a fan, like the Surface Pro 9.
>>
>> I should have properly build-tested this, sorry. It seems that it
>> creates a recursion in Kconfig. So please disregard this, and let's
>> stick to "depends on" until I have figured this out.
>>
> 
> You'd probably have to change all of them at the same time.

Right, I'll see if I can give that a try on the weekend.

Best regards,
Max

