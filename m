Return-Path: <linux-kernel+bounces-198321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E70C8D76B2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 17:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5200D1C21264
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 15:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD142481A7;
	Sun,  2 Jun 2024 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipho9KgC"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0C0433D8;
	Sun,  2 Jun 2024 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717341956; cv=none; b=iUKXxqCa1Vu0zXqgZvpVd0vrqYEAD2gV+TLsg8P8ou/EPSXdSbnPaHM+dGwoRE5M/cquGApb37Owd1c3j/WSVGWidwELOlxVnxmB3uJYShlY8ZgBHjizUx9gSkBJMvWBBvWtRFQ4wQho4HE7jlBL3I/b8xA7Z/V6oFlMNWnRJt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717341956; c=relaxed/simple;
	bh=lpZusebmPPOM2E+bgMGI8hFwQqWLWhfREgwS2GZgn1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKF/W8aqNv0DSPDw6oT7XcPiIDUE0TK2YdlcCa0gBEmgznld6KueLfQXH2tU7aoAHqhZjX1GJO1ZEDMuWHbz1jaUNSh8tVyPi/ZmvhVhF+xY5mJx8WSoUKlw7jLVUyC3ULwMk1lYgsfnPQ1nfSQ/qxQpII9To0Ln3Bo9he4ndUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipho9KgC; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2bfffa3c748so2787841a91.3;
        Sun, 02 Jun 2024 08:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717341954; x=1717946754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7EvfgY6PKPV319I7n7pojRWg9bK+qmS6AU4WZVV7aVM=;
        b=ipho9KgC1tbZVt7ZI2gRG0k/ufUPyNhVDOpVw6Fx6ESIBV9Xqs/mztFkF6za9SoQUG
         VnR+lF0BbisG38WFjSF4bxx+0Q3Ml8pFZeqBvYtOG/7Ks74GZscbt7Q0afDpBRMGb3vS
         fIr1rKgyhU503NmpjOZfp+K31BJq4FJEyi/YaVOP0soT8GbuqcG8NOGcSZHGjpCmpC50
         KxFVdcSWoA0jrD3TSIrC4fZUvHTMdtF+3acaO9RS4lLsZ1vz9hOxTsXzjSBJGjeogm5d
         RYWa4QEL/VCoPu9q6QI/W/U46e668wXNNZ3xROFo/B2ZYoFr8IlZLjTFNhTWbg5eXYyF
         QrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717341954; x=1717946754;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EvfgY6PKPV319I7n7pojRWg9bK+qmS6AU4WZVV7aVM=;
        b=Yx8KsYki8s/F0XvPRJI03gzhcaXYsO+3II3mdt2zijH1Gdb0CM7HQ87wHG5FAQ46Xa
         f/6spyNEmZl9kv/UpoxvuRJqzi9/YnRCsP80X2xhC4TFAqMejwqZrpl5rstkuevGl+EB
         RSeJt/UWXrZSRgQaqaw+GmWNLuYDVp7lkFPvT1jxELXqKVmonlMFwm3SNbOmQaYgvkNV
         ZBPOVDOSJdlY5PRG9UNYXBAM1jpk20DHcWFgx/ruLZnZsXfxnxfWOn7DSx2SMKA7BeMZ
         yo6ZdA7hWRIhUEvBw95reuUG9pxRAB9bvPi2wh5MkHF8RGBXj/U/+SwHQjSkqBM3TMOf
         kyfA==
X-Forwarded-Encrypted: i=1; AJvYcCV6wDAQDrF4/ZN1AZO99ScA8t7ml3inLrfA0jfKv3oVR7vwa0UN+IHGjL53wYh4M/VO2gTWtTTgnIllkSEC0YV90/s8wsarBYvyMcjwhvYebbvqZ3OFn+xPXEzuBys1ZJbeM8JwSvzcVw==
X-Gm-Message-State: AOJu0Yw3az1RoVyUQZWSTZrmfZqdP2y4civ9K4w/yehsuQqrS3mUUcLX
	DU7CH/GE2fltAhd09Bio2smQKhpE7tR26LdPT37Nw9DDEnvby+0y
X-Google-Smtp-Source: AGHT+IFNFERJLu6/bVivQr8BqWc1QDkhDhgUlQXy0ugJKAZkmgT90HOsXC1orsEYDfVCS4y9r8/D/A==
X-Received: by 2002:a17:903:187:b0:1f6:7f37:c116 with SMTP id d9443c01a7336-1f67f37c64cmr1603585ad.63.1717341954080;
        Sun, 02 Jun 2024 08:25:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dda6esm48118785ad.141.2024.06.02.08.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 08:25:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5baf4a58-0926-4d7c-bd4b-c755aced6d50@roeck-us.net>
Date: Sun, 2 Jun 2024 08:25:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v3 4/4] hwmon: (spd5118) Add support for reading SPD
 data
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Armin Wolf <W_Armin@gmx.de>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20240531230556.1409532-1-linux@roeck-us.net>
 <20240531230556.1409532-5-linux@roeck-us.net>
 <4cc979c3-3ce0-4f31-b5d0-508e1af5fdf4@roeck-us.net>
 <cf9d752e-0137-4a6d-85d3-fbe69293a43e@t-8ch.de>
 <f5f28ef1-53ef-4f82-abb3-2b60dc468793@roeck-us.net>
 <4e4341e4-2165-40d4-909c-9d5164e97942@t-8ch.de>
 <b3109c26-dde1-44cf-b431-80957c97de5f@gmx.de>
 <04d55009-c4a7-49e6-b098-545f20719f83@t-8ch.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <04d55009-c4a7-49e6-b098-545f20719f83@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/2/24 00:55, Thomas Weißschuh wrote:
> On 2024-06-01 21:23:24+0000, Armin Wolf wrote:
>> Am 01.06.24 um 16:08 schrieb Thomas Weißschuh:
>>
>>> On 2024-06-01 06:48:29+0000, Guenter Roeck wrote:
>>>
>>> <snip>
>>>
>>>> Makes sense. Another question:
>>>>
>>>> This:
>>>>
>>>> +        struct nvmem_config nvmem_config = {
>>>> +               .type = NVMEM_TYPE_EEPROM,
>>>> +               .name = dev_name(dev),
>>>> +               .id = NVMEM_DEVID_AUTO,
>>>>
>>>> results in:
>>>>
>>>> $ ls /sys/bus/nvmem/devices
>>>> 0-00501  0-00512  0-00523  0-00534  cmos_nvram0
>>>> ^^^^^^^  ^^^^^^^  ^^^^^^^  ^^^^^^^
>>>>
>>>> which really doesn't look good. My current plan is to go with NVMEM_DEVID_NONE,
>>>> which results in
>>>>
>>>> $ ls /sys/bus/nvmem/devices
>>>> 0-0050	0-0051	0-0052	0-0053	cmos_nvram0
>>>>
>>>> We could also used fixed strings, but "spd" results in "spd[1-4]" which
>>>> I think would be a bit misleading since the DDR3/4 SPD data format is
>>>> different, and "spd5118" would result in "spd5118[1-4]" which again would
>>>> look odd. Any suggestions ?
>>> In order of descending, personal preference:
>>>
>>> * spd-ddr5-[0-3] (.id = client->address - 0x50)
>>
>> Hi,
>>
>> this will break as soon as more than 8 DDR5 DIMMs are installed.
> 
> i2c_register_spd() only handles 8 DIMMs, too.
> JESD 300-5B.01 (section 2.6.5) also defines i2c addresses for 8 DIMMS only.
> 
> Outside of that range we could fall back to something else.
> 
>>> * spd-ddr5-[0-3] (NVMEM_DEVID_AUTO)
>>> * Same with only "ddr5-"
>>> * spd5118-[0-3]
>>> * Your proposal from above
>>> * nvmem[0-3] (default handling)
>>> * 0-0050-[0-3]
>>>
>>> Also can't a user of the eeprom already figure out which kind of module
>>> it is by looking at the eeprom contents?
>>> The first few bytes used for that seem to be compatible between at least
>>> DDR4 and DDR5.
>>>
>>> So using plain spd[1-4] could be enough.
>>
>> This could cause problems when DDR6 arrives.
>> Personally i would prefer the spd5118-X (NVMEM_DEVID_AUTO) format.
> 
> I have the impression that the eeprom layouts are designed to be
> forward and backward compatible.
> 
> If a non-DDR5-aware parser reads the contents of a DDR5 eeprom it will
> fail the CRC check, so there can be no accidental misinterpretation.
> (Because the CRC'ed area is larger and the CRC is at another location)
> 
> On the other hand the first bytes of DDR4 and DDR5 are compatible, so
> even an unaware parser can recognize that a SPD eeprom is being read and
> which DIMM type and specification revision it is.
> 
> This seems intentional and therefore should also hold true for DDR5 to DDR6.
>

Looking into how this is handled by other drivers:

- at24 generates directories named {bus}-005{0-7}X, where X is from NVMEM_DEVID_AUTO.
   Alternatively, it uses the 'label' devicetree property. In that case, the name
   will be <label>X, with X again determined by NVMEM_DEVID_AUTO.
   It does that to prevent duplicate file names due to duplicate labels.

- ee1004 does not use the nvmem subsystem, and thus there will be no
   entries in /sys/bus/nvmem/devices/.

NVMEM_DEVID_AUTO counts up from 0, and affects every nvmem device. That means
the assigned ID is not fixed but simply reflects the n-th device using it,
in the order of registration. Effectively this means that any fixed name
plus NVMEM_DEVID_AUTO can not be associated with the originating device,
and there would be no guarantee that it was static (meaning it could change
from boot to boot). spd5118-X would not mean the Xth DIMM, it would be the
Xth device registering with the nvmem subsystem.

At the same time, something like spd5118-X, with X derived only from the
i2c address, would not work large systems because there could be DIMMs on
multiple I2C busses. X would have to derived from the bus number plus
the I2C address, such as '(bus << 3) | (address & 7)'. Even that would
not be static since the bus number could change from boot to boot
depending on the i2c bus instantiation order. It would also require extra
code since the name would have to be generated in the driver.

In the context of at24.c not really caring and ee1004.c not even using
the nvmem subsystem, I think it doesn't really matter how the nvmem device
subdirectories are named as long as they are unique. decode-dimms won't
use it, and I guess no one else really cares because, after all, ee1004
doesn't even support /sys/bus/nvmem/ in the first place and at24 uses the
odd/unusual form of {bus}-005{0-7}X.

Given all that, I'll just stick with the simple dev_name(dev) and
NVMEM_DEVID_NONE. That creates a clear association to i2c bus and address
without requiring extra code or a lengthy explanation how the index is
generated while at the same time guaranteeing uniqueness. I _could_ add
code to use the devicetree label if provided, but that would require using
the same mechanism as used by at24, i.e., we'd end up with {bus}-005{0-7}X
default names (after all, someone could provide duplicate labels or labels
such as "0-0050"). If that is deemed useful it could be added later.

Thanks,
Guenter


