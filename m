Return-Path: <linux-kernel+bounces-198350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D4C8D7710
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 18:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24A5DB221D1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 16:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FCB4EB23;
	Sun,  2 Jun 2024 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKQf+8O2"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443083C2D;
	Sun,  2 Jun 2024 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717344369; cv=none; b=uRWbDGzKX5GcVFnq59QCkdZOWqScc1aSK64mKCmJZlr4o4nDNOhMuW4g10Yj6OeWwdlq7EnOvoD2C/9pFeUVPl+vtSwh+daTZw41VYMqaCHwqeqO0aBxkPwsvIL/6DB4tnjzFTmRItVwO7Q6cxG63O0DaGVaNipwl60Kb6A7TaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717344369; c=relaxed/simple;
	bh=vcRXzR+hQZspE7Eo44qlrvpNyMmPMpBFZIkJXZxD39k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOl1EfkMinZk1zk+VcWbIQcjxV5Y1+Bhf0B6TDSaekrpxOaxlKDbGBmqsBtsoCVqnyTIiNcp5HmpNvqoMrcIaHFzxuqSm0RF0Vv2FIJZcDTAiB/FgCdH7QheUupJJmACuYCP0G3e+6tgayQuCqoEpWjTQGZr7OTpYx5sLy40tBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKQf+8O2; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6c3b5c5e32cso1585292a12.1;
        Sun, 02 Jun 2024 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717344367; x=1717949167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sTT9rooxfo7hNxiMFndbLgwYj+ljHsqv0xSULcIN+n0=;
        b=HKQf+8O2Tuj/H6jOw1TjkZ3a/Ok69G7zcSaLZFBDyo7K/tOT6ZzbIt+EtTThojKVOq
         kFPy/oR2ywB/GSKiOUNqXu/87gJFz9sbtuMAvfkLKL00nFS3SeuhW8Abho2FDf3TJXT1
         0Dh8MKPaGWRk3pI2VBFFtj0wN8gWJO6WvTjZXm7CCW1h9Hb02M6ValVFPSgHLFZ0hFND
         RxiMea+GfA59E1aZcJa0q08KQtjnQ3Lutpv6CYElOTujooWRJQHBQbQogJru1JxCuS1E
         BaxSlDCKSawQQ6iaMrmI6qb6L7wPPdMkqhfEM0ugEdoPt9gLvqnAbvfyIilXyOHQqVFT
         SWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717344367; x=1717949167;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTT9rooxfo7hNxiMFndbLgwYj+ljHsqv0xSULcIN+n0=;
        b=uZikkwTLHO+FsZoRNAqpEaJa9hKNMjQZTTl0JqIfMOOcaVyERMYxF1czenyg8kbiPH
         fBzGewEeT1IiiSjuU54pF6nA93gzf3L0xKKd3c+qVqYTNqg8yJuxbIHR1aD15DCANWCV
         PB1dxOnh9FKUehmT+bVUSvROvU0ZEnBKBFBvrhMTseRW/jN9xT0FCOEu313zVRSZFR0T
         sEZd2kQLJpAiXZ318V2cXoFT6m6RsJuIAY/WeqyXcHi+oyasN+ZjivC/IJ1Q2rjXCAyn
         9s0ZKL6Me0+EQUJEYQrmnrt2PF7mfQsSv04LfajKmMeFEtf1+0fvSPdQv0s8p9z2+doV
         FWLg==
X-Forwarded-Encrypted: i=1; AJvYcCV3K6zJfPLfgCQ2uDRPQv+kRSisWREhnB9SJcppqpRSTeL5FZTLP+VC8TFk5KJ5+kAV24zPNANsLRJSgha9fmTc6l7FNnu67cU3sEaDdIfjE9qH1zrDD5WbZWzKXXvHUG+oGRgno2LMcw==
X-Gm-Message-State: AOJu0YyQtobUgeh/4mClOL/w1KkaRA0M5EpOnINUODW7DcKTh0r0OgMe
	RexXyo8F7QGmRJFLn65PT2r3nMhvJOXyFpMPsSUKsj5pdNiFnodV
X-Google-Smtp-Source: AGHT+IHFZlFssgi3WakgI7YZQBH5RkfpY0NftG8NI+275JmZe23nyfqOrxLzKLEV8KwkBmPIez2y/w==
X-Received: by 2002:a17:902:ec88:b0:1f6:6440:ca33 with SMTP id d9443c01a7336-1f66440d036mr30019295ad.40.1717344367322;
        Sun, 02 Jun 2024 09:06:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a775d68dsm6398516a91.6.2024.06.02.09.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 09:06:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <db92b513-47af-4665-9f31-04065e0d7de6@roeck-us.net>
Date: Sun, 2 Jun 2024 09:06:04 -0700
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

Agreed, but that doesn't mean that there must only be 8 DIMMs in the system.
It only means that there can only be up to 8 DIMMs on a single I2C bus.

i2c_register_spd() only exists if CONFIG_DMI is enabled. While that is supported
for multiple architectures, it is not supported on, for example, powerpc.
DDR5 support is not limited to systems supporting DMI, and/or to systems where
DMI is enabled. The ee1004 driver explicitly supports more than one i2c bus, and
I don't think it would be a good idea to limit DDR5 support to a single bus.

Ultimately that means that we can not rely on i2c_register_spd() for
auto-instantiation, even after adding DDR5 support to it.

Thanks,
Guenter


