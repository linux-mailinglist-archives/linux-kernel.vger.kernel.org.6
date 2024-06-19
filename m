Return-Path: <linux-kernel+bounces-221201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F67790F02B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF89F2861B4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423561BF37;
	Wed, 19 Jun 2024 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApBt96rQ"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844F81CF8D;
	Wed, 19 Jun 2024 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806688; cv=none; b=Kszq8J13LUC+Tx+cU+/hcfS5Ms0bmZCQOkhnl8HNb6Yoc69IhEkO6wolKTeOAUGGjg7cO9FSevJNu0Hljfx4fCJeY6erzcg+uhgYUqxpxusxsSaGe/oZaTkuMLKCNo/dwilmUTRae8AY4jJ7wGOLd0VuPy+VxWcxEPXxEBK8o2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806688; c=relaxed/simple;
	bh=RGSHa7sfaiEy5D4a/j1wrv+LOR9Q1Itk+/bpvv3EMrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TlAVWiHN94tBjJuDVdmjZfQlvViSUPvNTso6JmJiTtMExc8iRpmClV1Dp2/cFKaHJqgjbUTE8EEJVigkbTBJ5xVgaW5C4IwNkQXud3QQMarxEN+PL1HEbGRT8uLVwoKf8lJpbNs+mFFmlIWC9W5bp3KUaKUhXwHXDZMewaSYb54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApBt96rQ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-70a365a4532so2876849a12.1;
        Wed, 19 Jun 2024 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718806686; x=1719411486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=logi2V8osBzXhzd35gF5npZIF3ONa+VvHKEUDyy2HCQ=;
        b=ApBt96rQqEvbqton4MbNvsCGZXNaGHeaBKI/EpmaN258rLVSJbOK4ks5uq+ajaZPmg
         RaFeS7he4I/lyZ4SzCV+WlnVx0UIlgjVJg2KGAeObMmnPQlHr//r5zom17SeYu8dpIze
         LpezjzSnZhegBs9QEv7UCq+0DtDZT4opQQBkllYZcNLZXCFI6ESn9BzHgoq2NWdgvido
         gmb8dnmayjoijHdlDRWSiQcit0i5hNAxC7zw9MB4BibR6EpqdNcQjMmv5dAkW2/6aXUs
         orRnB1fQg/XmIIilGAdxlqzQCYqKqjllKtUeEPR+j6he3RGdngKDjN6qpttHUWaCKhJ+
         FnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806686; x=1719411486;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=logi2V8osBzXhzd35gF5npZIF3ONa+VvHKEUDyy2HCQ=;
        b=koPqU8TkCUc12g84gUwJj/vyyC1jTHlnAy4P54s70v9tWC3NLFFgdWt03niXMcMYNS
         pTQWF9vjTfec1JqPK0W8sD9voKT5c4ZK3co/BEmFEoO/0LZ70pZnnfTyGH/PVExGTbth
         VnMfuQXuT7WdQNJbNEB/jRIlphbtQ1pL6o0qHyi0+FjMKrliHSdwtFpLIIR5WBSMM+tN
         39XqzdlgEE1Sk1pwD05HA3u7xrscdDDStcL4cFmD22WSATPrmunjfqlHC/yZUPJWIc87
         ivenGwjsdrj+Yyk1s9IiWuqz2K2XCyKbWjzembnGe5NtDHJiZhg/OpGUOee6tMzQrdV5
         8hOw==
X-Forwarded-Encrypted: i=1; AJvYcCV+rc2GAi3hPyabHadgtJ5iP6eNM45nJssgv+oCvquzgiM/Dfe68vTkQTj1h9WcnXyZ0Mfo5G9P/M8cSzGRSiV20rLTz/Cno5R38odSQlGERqLyr0CP0TiN9Y/I+6doxvoqbxln9Ow1zGQ=
X-Gm-Message-State: AOJu0YzdlAQw0YpOlyNRtlJxGoDxQjb5Ox6v09Cd0w6bOHJlkfoThkp9
	wLZXfpqMbOPtN4spiurvwERGAZkralBCRT+KP0NQqzWcfwHwnd+C
X-Google-Smtp-Source: AGHT+IEWg9UInkYQIxfsa4v520A/FhV/0j9YrrqxpE2GgK7xvcCxFUZIcPus6ZaDoqLvMHsbspm+9Q==
X-Received: by 2002:a17:90b:a44:b0:2c3:40b6:293b with SMTP id 98e67ed59e1d1-2c7b5da95d0mr2617806a91.39.1718806685579;
        Wed, 19 Jun 2024 07:18:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c77ba5b202sm3120071a91.36.2024.06.19.07.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 07:18:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <52d9ec36-2ac8-427a-8631-c7730c979bd0@roeck-us.net>
Date: Wed, 19 Jun 2024 07:18:02 -0700
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
 <a682ab44-d623-40fe-8fee-af2a3ae5590a@roeck-us.net>
 <879b15c1-d924-41d9-a41d-da785b943d26@t-8ch.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <879b15c1-d924-41d9-a41d-da785b943d26@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/19/24 02:13, Thomas Weißschuh wrote:
> On 2024-06-18 18:02:51+0000, Guenter Roeck wrote:
>> On 6/18/24 17:50, Thomas Weißschuh wrote:
>>> On 2024-06-18 17:23:44+0000, Guenter Roeck wrote:
>>>> On 6/18/24 16:39, Paul Menzel wrote:
>>>>> [Cc: +Heiner]
>>>>>
>>>>>
>>>>> Dear Armin,
>>>>>
>>>>>
>>>>> Am 19.06.24 um 01:28 schrieb Armin Wolf:
>>>>>> Am 19.06.24 um 00:28 schrieb Wolfram Sang:
>>>>>>
>>>>>>>> to 86 degrees C. If that doesn't work, we'll be really out of luck
>>>>>>>> with that controller (or at least I don't have an idea what else to try).
>>>>>>>
>>>>>>> Try CCing Heiner Kallweit for ideas about the i801 controller.
>>>>>
>>>>>> i am not Heiner Kallweit, but i found something interesting in
>>>>>> commit ba9ad2af7019 ("i2c: i801: Fix I2C Block Read on 8-Series/C220 and later").
>>>>>>
>>>>>> Basically, it seems that the i802 i2c controller indeed features a SPD write disable bit which blocks all writes for slave addresses 0x50-0x57.
>>>>>>
>>>>>> Does the i801 i2c controller driver print something like "SPD Write Disable is set" during boot?
>>>>>
>>>>> Nice find. Yes, it does:
>>>>>
>>>>
>>>> Yes, definitely. I didn't have any recent datasheets, so I missed that flag.
>>>> Oh well :-(.
>>>>
>>>>>        [    5.462605] i801_smbus 0000:00:1f.4: SPD Write Disable is set
>>>>>        [    5.468399] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
>>>>>
>>>>
>>>> Bummer. That explains the problem. It means that the BIOS effectively
>>>> blocks reading the eeprom on your system (because that would require writing
>>>> the page register), as well as changing temperature limits. That is really
>>>> annoying, but there is nothing we can do about it. Maybe the BIOS has a
>>>> configuration flag to enable or disable write protect, but I doubt it.
>>>
>>> What about using 16bit addressing mode?
>>>
>>>       Alternatively, at initial power on, the host can set the Table 112, “MR11” [3] = ‘1’ to address the entire 1024 bytes of
>>>       non-volatile memory with 2 bytes of address and hence not required to go through page selection to address entire
>>>       non-volatile memory.
>>>
>>> regmap-i2c allows 16bit addresses when I2C_FUNC_SMBUS_I2C_BLOCK is supported,
>>> which to me looks like it should be the case on i801 for ICH5.
>>>
>>
>> Good idea, but it doesn't work. I can get write operations with
>> 16-bit register addresses to work even on piix4, but read operations
>> require writing a 16-bit register address followed by byte reads (see
>> regmap_i2c_smbus_i2c_read_reg16). Unfortunately, spd5118 devices
>> don't auto-increment the address on byte read operations, meaning
>> each byte read returns data from address 0x00 (i.e., it returns
>> 0x51). Try "i2cdump -y -f 0 0x50 c" and you'll see what I mean.
>> Maybe there is a way around it, but I have not found it.
> 
> Thanks for the pointer to regmap_i2c_smbus_i2c_read_reg16().
> I'm not really familiar with I2C/SMBUS ...
> 
> Did you look into "2.6.8.3 Default Read Address Pointer Mode"?
> 
Yes, I did, and, yes, setting that for each planned read operation
might do the trick, but even that would not work here since writes
are blocked. On top of that, it would be extremely expensive (one
would have to write the address into the default address registers
before starting a read). The reason to use 16-bit access mode would
be to simplify access, not to make it more expensive.

> I am failing to understand how that address pointer mode would ever make
> sense without address auto-increment.

Oh, it kind of does, as long as each access is a single i2c operation.
One would have to use a SMBus read word operation to read two bytes
with a single SMBus command. I guess one could also use something similar
to an i2c block operation - start a read with no command byte and just
keep going.

> 
>> On top of that, configuring 16-bit mode requires a write operation
>> into the page register, and that is blocked.
> 
> ... this one on the other hand is really obvious.
> 

There is actually another problem: When I tried enabling 16-bit mode
in my system, I initially had trouble clearing it. When I rebooted,
I got a BIOS error telling me that the configuration changed, and
it gave me the option to either enter setup or continue. A soft
reset did not clear the bit. Power cycle did, but I got the
"configuration changed" message again.

So even if we would get 16-bit mode to work, it would not be a good idea
because it would expose people to the "configuration changed" BIOS
message. Resetting the bit on shutdown and when unloading the driver
would not help because that would not happen when the system crashes.

So, in summary, 16-bit mode is just not usable. If some BIOS actually
enables it, we might have to disable it or figure out how to use it
without depending on "Default Read Address Pointer Mode".

Thanks,
Guenter


