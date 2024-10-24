Return-Path: <linux-kernel+bounces-379045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C170A9AD8FF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 02:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1698B224C9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959C38468;
	Thu, 24 Oct 2024 00:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZV6Z7dh"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D0B2C9A;
	Thu, 24 Oct 2024 00:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729730826; cv=none; b=iFNtFzbWbzhWK9Rqu02reBrJXLQbHyity79llUKXoWotyJuCkYhxvWNxNdewnXdVaj3Bckwknce0nHZt+vbSXdt9abmKLPCxQ4Io/L1mIaqyn886x8Y0wnMaT8euLwsSJaEaxOOZumD1GeE+7DZ6yk1AKd7FGDZSYoZyjY3205c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729730826; c=relaxed/simple;
	bh=k3lia007kYUdte+PEY7ZxbfcB+yuJrWay+kurHQZAgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V+hB9A2ncRQz60NQyFxzZfIa9NLuhsK9aJKzY3xgzny3bSChNCprTm5RQmeXp4YkBvQtxlo2nVQWXDDx/52M6/NQW1HUF3DNXeEw5K155F8KezeYU/N+mvylTky52nw9MVwxgqYW/3VgvKGNVFepCc8zx298zuL5nsP50aojrYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZV6Z7dh; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7e6ed072cdaso266532a12.0;
        Wed, 23 Oct 2024 17:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729730824; x=1730335624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DwNzJfcEJaV4qofKPCzWwpFuKsi4g1RhJv3U9jP5hlw=;
        b=mZV6Z7dhll3XGi/Z+w2s7kpDWY/6V5q2YIG6Iw4BUeJ/wQ0lD8gCY9VLj0qqy4EPH/
         oE9unXaOvF6mSdTdWn+IAD6Qs/DuT0W/Ef1v66YjAjyzj8oddiXX/zr9yWzSFVdhIG/k
         fiCKul/EBPl+/fJ+dsf0nQ98CK6Jcc6QfW7BrpzMeLEfc9m8NNpTQhqq1/QUr0RiVo4A
         dx3e2L+ESCf9I4bB9t8fdmCaaoyOAjTCu88L3WtgZstqxtMYVk+srkw6TIWU83JpS4UA
         qS3+MvygRpitVZufQGxvzwt9yYMhu1oGBNUL+xujyzD6rXMvZuEFAdIR60+27FopJewh
         KDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729730824; x=1730335624;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwNzJfcEJaV4qofKPCzWwpFuKsi4g1RhJv3U9jP5hlw=;
        b=weomCqgNHTNMI+9slnbna3BNBAdlmk2TWYjd8ydLQSBwLeysWm3gJKkwBm8uAXHPf8
         yQc8DTj/OHATW9DTISVN/i023NtlJH72wTnG0GehRGEA4tRsElJDnCkpeT6fbQV3Nw8Y
         NHMnLWLg6qS2jE7rORyGSW319q3mqd4xihSvgoNPzhcmOFH3fIPJuP/HzpPWb4mOIws4
         5MNvrfrJVX/k1VL4Ft83wpTmd1jrjjzaXfwjy3l7mYPqN1yBtjZbCs4lWpS+YZoy9iTO
         nUHWtSM8BU00Q4d1f2ATW/SQiPQaDVQaw4Q6xFm3g0i8kTHpELJS19XPI1G7Yp5aqGy8
         NYlw==
X-Forwarded-Encrypted: i=1; AJvYcCXIuUtKzG3OwiyOMoNDyBSz7OHtYYGuzTkCvk6F1LPi23zD19aUxR5McJy3/ucaSEFyJIQR1SmF20XNvdz3@vger.kernel.org, AJvYcCXPyc6Rwtsf4ZIt26nHnTin3gJMRRhJ/LaVQjXuaPy6HoZD6SSgUIDqLxcG1khuN5Mrc/dBTjy9QJueLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YydbAyIflVVpc1+HguTKbYBB+dHjnjGTFFXPMJIZhJXB/VtnrE8
	bu/+IjNmbpOfqK0uY3HvN2+AdOYVpxAZU1tugalXlVZOuctE1zat42vMyw==
X-Google-Smtp-Source: AGHT+IFG2pPRRKQXlYZxdt05SCnP07Y/7/3NMvv4ZE26+0mT2za7kuBQ6xY5OJUDuH9p+I9isAxD4Q==
X-Received: by 2002:a05:6a20:e607:b0:1d9:1045:3ed5 with SMTP id adf61e73a8af0-1d978b1306cmr4778020637.11.1729730823805;
        Wed, 23 Oct 2024 17:47:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d774fsm6942091b3a.106.2024.10.23.17.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 17:47:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <241fb55a-17ef-414a-ba8f-eef5307e9013@roeck-us.net>
Date: Wed, 23 Oct 2024 17:47:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: (it87) Add support for IT8625E
To: Ahmad Khalifa <ahmad@khalifa.ws>,
 Frank Crawford <frank@crawford.emu.id.au>, Ai Chao <aichao@kylinos.cn>,
 jdelvare@suse.com, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241022091319.82503-1-aichao@kylinos.cn>
 <6cab565f05820eb2e1a1c55644be057427ecdf2e.camel@crawford.emu.id.au>
 <300383ee-3ead-439e-893e-895f3ed49805@roeck-us.net>
 <103a68d6-d0b8-4e6f-ac8f-c6186b340f81@khalifa.ws>
 <b6c2731b-8fac-4e7a-ab0c-2f36e8a64a69@roeck-us.net>
 <0a79c3f1-6fb0-4abf-8ebf-08ecdd0a15c2@khalifa.ws>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <0a79c3f1-6fb0-4abf-8ebf-08ecdd0a15c2@khalifa.ws>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/23/24 15:19, Ahmad Khalifa wrote:
> On 23/10/2024 16:42, Guenter Roeck wrote:
>> On 10/23/24 05:41, Ahmad Khalifa wrote:
>>> On 22/10/2024 14:40, Guenter Roeck wrote:
>>>> On 10/22/24 03:13, Frank Crawford wrote:
>>>>> On Tue, 2024-10-22 at 17:13 +0800, Ai Chao wrote:
>>>>>> Add support for IT8625E on Centerm P410.
>>> ...
>>>>> Can I just add that it isn't a good idea to use the same type for
>>>>> different chips.  There are some specific differences between the
>>>>> chips, which mean that it should have its own entry in
>>>>>
>>>>> static const struct it87_devices it87_devices[]
>>>>>
>>>>> even if currently they are very similar.
>>>>
>>>> According to the information I have, the ADC voltage is different,
>>>> and 8628 supports PECI but 8625 doesn't. Most importantly, 8625
>>>> has multiple register banks. There are also some differences in
>>>> fan control; 8628 can explicitly turn fans off using register bits.
>>>>
>>>> Just mapping the chip to it8628 may be convenient, but it is not
>>>> acceptable.
>>>
>>> Side question here. The standard for an acceptable chip driver is pretty
>>> high (and rightfully so). But a common use case centres around readonly
>>> display of information: temp/fan/in readings. Even just 2-3 readings are
>>> better than nothing.
>>>
>>> Example, I still have to use Frank's out of tree it87 for my IT8688.
>>> It works perfectly fine for me, but still not possible to merge that
>>> device into hwmon's it87.
>>> This IT8625 is another example. The NCT6701D-R will be one more shortly.
>>>
>>
>> For the most part you can use the kernel driver with force_id parameter.
>> That is no different than your suggested patch.
>>
>> Nuvoton is usually very supportive, so I don't see a problem adding
>> support for NCT6701D-R if someone is willing to spend the time to write
>> a driver (or adding support to an existing driver if the chip is similar).
> 
> It's on my radar when they release the mini-ITX X870 board over here.
> Will need to find the datasheet then.
> 

Nuvoton usually makes those available if asked nicely.

>>> A readonly driver that is configurable from userspace would help in that
>>> use case. It can be configured for known devices without datasheets or
>>> for testing new devices. Wouldn't even need to access superio config
>>> space.
>>>
>>> Filesystem has fuse, i2c has i2c-dev, input has evdev, ...
>>> Would something similar be acceptable for hwmon?
>>>
>>
>> I would have to details of a proposal, but It seems unlikely.
>> After all, chip details have to be sufficiently known to provide
>> any driver, even a userspace one. Also, the hwmon ABI (i.s., its set
>> of sysfs entries) isn't that special that it would warrant such a
>> kernel infrastructure. If at all, it might make more sense to add
>> support for this, for example, to libsensors.
> 
> Why not libsensors?
> Access to ACPI and IO ports (without special file capabilities).
> Access to the hwmon sysfs ABI in place of libsensors (as libsensors has
> no movement at all - not the best reason, I know)
> 
> Maybe access to WMI too, but didn't need it in my tests with gigabyte
> WMI, as through ACPI you get fan access in addition to temp
> 

Sorry, you lost me somewhere. Unless I misunderstood your request,
you were asking for a means to support userspace hwmon drivers. Well,
yes, those would somehow need access to the hardware they support.
A userspace hwmon driver for IT8625 will still need to access the hardware.
If those userspace drivers interface with libsensors or with the kernel
does not make a difference. I didn't suggest that this should be implemented
as part of libsensors, but one could define an API which lets userspace
drivers and libsensors communicate with each other.

The lack of a maintainer for libsensors is not an argument to make here.
Anyone can feel free to pick it up.

Guenter


