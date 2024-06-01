Return-Path: <linux-kernel+bounces-197878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ED58D7049
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B221F22AAB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 13:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C5015216D;
	Sat,  1 Jun 2024 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJdUat70"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2F114267;
	Sat,  1 Jun 2024 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717249714; cv=none; b=F3Ieb+BpIL2ydy+VTBGGdRyn9a3zziJnKdTCOsYcIVl7iQPnYxvh0ODhMfFPjE5/YKySYnSM8krA73FHRZjDsQ1r1RxBqW8zd2K1FutBxoHaDdMsDW9eo9kUZ2G7wda5yM4tfprFlWj6JroIMaMFbZzKrPbkYW+NlHQ9CiPn5Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717249714; c=relaxed/simple;
	bh=YHM4E/Qtjr3WJltOS928HYUCDOSCEdmRJxSslboKT4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fW/I8CBZIL6tTTYlPXdZa4DoiHvud8R0Qqe8StwgTYVsDaBJtAJrE9KdJbstLzSaT9nhte6bfyxXZL/MhlzCY5y64mHN5kKz1VZVlFPXPcp/oLZoVRR1tzuN1SxPuZQ2UoLeDsrOcP8ZpBHPiV+oBJQi4+/N6DPiETowj/I2wOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJdUat70; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6c9e8c0a15bso96749a12.3;
        Sat, 01 Jun 2024 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717249712; x=1717854512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QoCW09jr3jVeTddViA4yageOc6j/1e0Ds9tGi/4QtGQ=;
        b=PJdUat70fC6VL7G5Fl4Pl38Rb1FCHfiZf8L9jy/hM4GTqoem8P7tAbGk2sAYuBWy+k
         WjLxxuAZ+bb17zPsGi1q/LJwlejsWAz1lJ4+gsaptXVeO6v49yjsU3xprMn91v85jpSO
         FIpc0FrxDuBZdSvTBxC8P7/8GwKPFJGPWZciJ3UDaBulTXpyYAO/hhUfErJfKRrgi41v
         NYDSXJcX0Huyyu9ABxV65AJ1iONi2wdfI6FdkQ/nk8yusYF8tyny/P1GL+1Onxjtagl6
         GK3IPCVsZSFIy5IIAnXQ7xV2mcUEUivoTfTZ+cjqyGL5YDkDMtbB3GH1liR8m1yzrBh2
         Mi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717249712; x=1717854512;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoCW09jr3jVeTddViA4yageOc6j/1e0Ds9tGi/4QtGQ=;
        b=oeMbEUVUqZ4Po1hH1dO7o27w//qQ0nEg/0wqQUlhynOgE8QciHGl2GymdMGe3lf5Tv
         T2ZvOBH5EEWBJfD0sBsh+nqqoorQavLS5/dUJzSF5s5lxVn84r1XypA1H5qoRBN2FBMZ
         hclhNiBrvNnKIzh0y4wekq5gYpQVC2vwo2e58zbx05oBmbgicPfETMIPgg4eiJgG5tg1
         C7b4uO3V1WzckxEoM95OnbuTiiUPZR/phaNCloZX8g8e93GvXwtA7rQmUbGrrSO/HlDW
         2U9RzkhsWTMvhE3/UsEJ1nshRU0a1vH8LlWAYwvHbtjuV4P7Aw6AkfYfpOHBmkoq0L4W
         3X8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/3uZDu0zFFKAYLAiBh7hcE+ElbhHaxgKLmSHxQu80DDISn5nzGR0UHeEGC9bDHtfARJbyBxdQBZAnWoq8Zw2EScspKTaU/lzutp0VmgwSVXP2iJYpOYetmxF6uw5Z7kgBMQiznUvhJg==
X-Gm-Message-State: AOJu0Ywk0k+Tx90hXjuemtpSSPkUqQNF+pbEmqmbCPrcKa37dViKEIbk
	KZHgU6iR9bpIc8V8jYivL5rM35Pk1Ypu8KmYetQdR7wAvfteFpSbee7rBw==
X-Google-Smtp-Source: AGHT+IGf5LeGcy0bARZWH+MBk+uU3Ig/G+IItEr+TD1tZ+UFFyUNmN+kRulD2hPTy8Ce7jPQN7hVJg==
X-Received: by 2002:a05:6a20:7f89:b0:1b0:25b6:a749 with SMTP id adf61e73a8af0-1b26f275972mr4762950637.48.1717249712133;
        Sat, 01 Jun 2024 06:48:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c6482dc7sm3082846a91.44.2024.06.01.06.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jun 2024 06:48:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f5f28ef1-53ef-4f82-abb3-2b60dc468793@roeck-us.net>
Date: Sat, 1 Jun 2024 06:48:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v3 4/4] hwmon: (spd5118) Add support for reading SPD
 data
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Armin Wolf <W_Armin@gmx.de>, =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20240531230556.1409532-1-linux@roeck-us.net>
 <20240531230556.1409532-5-linux@roeck-us.net>
 <4cc979c3-3ce0-4f31-b5d0-508e1af5fdf4@roeck-us.net>
 <cf9d752e-0137-4a6d-85d3-fbe69293a43e@t-8ch.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <cf9d752e-0137-4a6d-85d3-fbe69293a43e@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/1/24 03:41, Thomas Weißschuh wrote:
> On 2024-05-31 22:42:24+0000, Guenter Roeck wrote:
>> On 5/31/24 16:05, Guenter Roeck wrote:
>>> Add support for reading SPD NVRAM data from SPD5118 (Jedec JESD300)
>>> compliant memory modules. NVRAM write operation is not supported.
>>>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>> v3: New patch
>>>
>>> RFT: I'd like to get some more test coverage before moving forward
>>>        with this patch. decode-dimms doesn't recognize the 'spd5118'
>>>        driver.
>>>
> 
> Looks good to me.
> 
> Spot-checking against JSED400-5B and the embedded CRC are as expected.
> 
>>
>> Looking for feedback:
>>
>> [ ... ]
>>
>>> +
>>> +	nvmem = devm_nvmem_register(dev, &nvmem_config);
>>
>> This returns ERR_PTR(-EOPNOTSUPP) if CONFIG_NVRAM=n. We have two options:
>>
>> - Ignore -EOPNOTSUPP and continue registering the hwmon device
>>
>> or
>>
>> - Add
>> 	select NVRAM
>> 	select NVRAM_SYSFS
>>    to the driver's Kconfig entry.
> 
> s/NVRAM/NVMEM/g
> 
>> Any preferences ?
> 
> It seems reasonable to support the module without the eeprom logic.
> When used in a fixed, embedded environment, the eeprom is of limited
> value as it's known beforehand, while the hwmon functionality is still
> useful.
> 

Makes sense. Another question:

This:

+        struct nvmem_config nvmem_config = {
+               .type = NVMEM_TYPE_EEPROM,
+               .name = dev_name(dev),
+               .id = NVMEM_DEVID_AUTO,

results in:

$ ls /sys/bus/nvmem/devices
0-00501  0-00512  0-00523  0-00534  cmos_nvram0
^^^^^^^  ^^^^^^^  ^^^^^^^  ^^^^^^^

which really doesn't look good. My current plan is to go with NVMEM_DEVID_NONE,
which results in

$ ls /sys/bus/nvmem/devices
0-0050	0-0051	0-0052	0-0053	cmos_nvram0

We could also used fixed strings, but "spd" results in "spd[1-4]" which
I think would be a bit misleading since the DDR3/4 SPD data format is
different, and "spd5118" would result in "spd5118[1-4]" which again would
look odd. Any suggestions ?

Thanks,
Guenter


