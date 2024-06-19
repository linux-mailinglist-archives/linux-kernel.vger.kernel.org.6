Return-Path: <linux-kernel+bounces-220394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FE290E117
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 03:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA042850B2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D998763D0;
	Wed, 19 Jun 2024 01:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYr1tMf1"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6590C1C20;
	Wed, 19 Jun 2024 01:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718758977; cv=none; b=UdPoz1f+AJpoOywcPueQ0Xn4GIoTWat3L4IqC6pTqa55u+Nsyh7jzPkpJ1Hod0yrouv7L0fdBLdcrzPlAyrqoiTdc1RnLjoPXd8sR5IlZQ+sA3NXd+Sb62WTdtvIGSWYZ9H8y8/tY8IdHn9cFP+2m0kupBwa+BNJJX8Z9X/85Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718758977; c=relaxed/simple;
	bh=N7YGPXnhSZhn97NXtwz2gQi3NQ5BSaEY4l48p6wknOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EdHLl2J2IRcjWb9QMgc49taAX8ytSxRGu3LlXlIesrlvS+ybXGl56UqBN15jvTAgxZS48zkI8zRhu3Y0ddYAEUIQoHvJIcq+Jnyv3AbRyo59tKv9KPc8LCBF+SXjKu7NzSFz381Oges8CtPh3JoOe3UDp4Faq8qo44UZUT5jF4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYr1tMf1; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c2d25b5432so4727921a91.2;
        Tue, 18 Jun 2024 18:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718758975; x=1719363775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fbfJGoyAL7xrlfBR7yhnG1RX36GOV2vXpR2qQ6fna/4=;
        b=GYr1tMf1QvD3Zt2yI17C4eyeIdLtwQ+xhbjjwqhs9Pbci2IAOnR+tVZlAkGhOlJ5k+
         9PxbD6gwndGucToQx9rQFaMlUtBCfhh7Y/LEgdvPPtBfK4KRHjCNVT2Q3uhAzn+Du/ao
         e5UiMB01VRx/NONekfx5oK1gLD4jYxivu4/bmFS8Gnn4A9xqO9Y8gfIs4KSDjkU6LwEH
         Y0a8aPO1+ffmHfn2cDpkQBc9ZOS2jEVDaTuPvOVsDKj7JVqFnmB84Bt1jHGmh/y2vf1f
         thWuDPYbtwvHI63LCHDwwZuProdF4G1voDsm7toLJZRW8wvvJiWPy5zFyhK93BmnBRAs
         jjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718758975; x=1719363775;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbfJGoyAL7xrlfBR7yhnG1RX36GOV2vXpR2qQ6fna/4=;
        b=romexZBwb6fKi6YA0NU1mkUHfGthm1aRdqmebD43aE4cpyMGdE2aB4BCJh4FVjpM9V
         8fEFRXmsctyQH7RQ/fIwMS/Gc1GW2D4/0Y94xl5/WA8i4MVOsTzrjZOrO6QY405BKjmW
         SEZWHVRsC1J4zEaGRjnpWcIcHao1jTWvtwOzlqNEuYWRLPw9RtPXFGg4EeekEs7+b7jR
         YlFMwo/eFPXow/jT8Q9mj5a6OrCgo6cEv2gpFe+qzBNAI6cNzndykQ5EgYJn46+AUzNZ
         C16zHk+VecaeAqjxphRUWP03mnCNmTOFHZEAjN+mGFUntOH5vWyXG1H4jezgKeizu5/H
         2OFg==
X-Forwarded-Encrypted: i=1; AJvYcCXTBK0LomKbZGAs5q60FPekRcBmc/GyMvZRQytz4wA8vB4jaJqTBO4qtD43avylqzNpvUssreKAbAiO/ZqIUxYDn1qwIQXRPc0OBzCVsF6XTL7sKHC58XUg3Ut9msJEhWDf+wgWOvy+nL0=
X-Gm-Message-State: AOJu0YzmMSB/F58jSyhOIP952jFiVwBttuZn+2dJwQAm4PYOWA0sLTv5
	/oxMvGvQo6152KQMIXegsR8x/8PqWYk/IR0ItuHfxNQQznH3VZi1
X-Google-Smtp-Source: AGHT+IGEEWzAUBuKvfLPe/9jEsZV30FzzT8QWIM+v2OSv/MD+nPusqSe4pI1Zex4+5zTFaeA9W33Jw==
X-Received: by 2002:a17:90b:3688:b0:2c4:e000:f811 with SMTP id 98e67ed59e1d1-2c7b5d98300mr1251936a91.49.1718758974392;
        Tue, 18 Jun 2024 18:02:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4ac192848sm13468960a91.56.2024.06.18.18.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 18:02:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a682ab44-d623-40fe-8fee-af2a3ae5590a@roeck-us.net>
Date: Tue, 18 Jun 2024 18:02:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH v2 2/3] hwmon: (spd5118) Use spd5118 specific
 read/write operations
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Armin Wolf <W_Armin@gmx.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Rebe?=
 <rene@exactcode.de>, Stephen Horvath <s.horvath@outlook.com.au>,
 Sasha Kozachuk <skozachuk@google.com>, John Hamrick <johnham@google.com>,
 Chris Sarra <chrissarra@google.com>, linux-hwmon@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, Heiner Kallweit <hkallweit1@gmail.com>
References: <20240618195348.1670547-1-linux@roeck-us.net>
 <20240618195348.1670547-3-linux@roeck-us.net>
 <a7f208df-4c9e-4fa2-9d17-80895db51182@molgen.mpg.de>
 <661def21-b0a9-49c1-937e-8526008f529c@roeck-us.net>
 <omsjeb6zbkcdhh4a3urjdrdeyj2kczb734tbhxwdcvngzlm7pe@dzdphvmm6asq>
 <4755d088-7eab-47ca-923c-db1fdf3611ab@gmx.de>
 <6845cc2d-c50b-415b-af49-bf57333ee939@molgen.mpg.de>
 <f437519f-97c3-4811-ac04-0695a27d9b37@roeck-us.net>
 <0b8ae7fa-e3d3-4d31-9b4b-657b15c2d19c@t-8ch.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <0b8ae7fa-e3d3-4d31-9b4b-657b15c2d19c@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/18/24 17:50, Thomas Weißschuh wrote:
> On 2024-06-18 17:23:44+0000, Guenter Roeck wrote:
>> On 6/18/24 16:39, Paul Menzel wrote:
>>> [Cc: +Heiner]
>>>
>>>
>>> Dear Armin,
>>>
>>>
>>> Am 19.06.24 um 01:28 schrieb Armin Wolf:
>>>> Am 19.06.24 um 00:28 schrieb Wolfram Sang:
>>>>
>>>>>> to 86 degrees C. If that doesn't work, we'll be really out of luck
>>>>>> with that controller (or at least I don't have an idea what else to try).
>>>>>
>>>>> Try CCing Heiner Kallweit for ideas about the i801 controller.
>>>
>>>> i am not Heiner Kallweit, but i found something interesting in
>>>> commit ba9ad2af7019 ("i2c: i801: Fix I2C Block Read on 8-Series/C220 and later").
>>>>
>>>> Basically, it seems that the i802 i2c controller indeed features a SPD write disable bit which blocks all writes for slave addresses 0x50-0x57.
>>>>
>>>> Does the i801 i2c controller driver print something like "SPD Write Disable is set" during boot?
>>>
>>> Nice find. Yes, it does:
>>>
>>
>> Yes, definitely. I didn't have any recent datasheets, so I missed that flag.
>> Oh well :-(.
>>
>>>       [    5.462605] i801_smbus 0000:00:1f.4: SPD Write Disable is set
>>>       [    5.468399] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
>>>
>>
>> Bummer. That explains the problem. It means that the BIOS effectively
>> blocks reading the eeprom on your system (because that would require writing
>> the page register), as well as changing temperature limits. That is really
>> annoying, but there is nothing we can do about it. Maybe the BIOS has a
>> configuration flag to enable or disable write protect, but I doubt it.
> 
> What about using 16bit addressing mode?
> 
>      Alternatively, at initial power on, the host can set the Table 112, “MR11” [3] = ‘1’ to address the entire 1024 bytes of
>      non-volatile memory with 2 bytes of address and hence not required to go through page selection to address entire
>      non-volatile memory.
> 
> regmap-i2c allows 16bit addresses when I2C_FUNC_SMBUS_I2C_BLOCK is supported,
> which to me looks like it should be the case on i801 for ICH5.
> 

Good idea, but it doesn't work. I can get write operations with
16-bit register addresses to work even on piix4, but read operations
require writing a 16-bit register address followed by byte reads (see
regmap_i2c_smbus_i2c_read_reg16). Unfortunately, spd5118 devices
don't auto-increment the address on byte read operations, meaning
each byte read returns data from address 0x00 (i.e., it returns
0x51). Try "i2cdump -y -f 0 0x50 c" and you'll see what I mean.
Maybe there is a way around it, but I have not found it.

On top of that, configuring 16-bit mode requires a write operation
into the page register, and that is blocked.

Thanks,
Guenter


