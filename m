Return-Path: <linux-kernel+bounces-197694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71698D6E23
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 07:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDEB285F0F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 05:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FE710A14;
	Sat,  1 Jun 2024 05:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2k/0D/d"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2A0AD58;
	Sat,  1 Jun 2024 05:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717220549; cv=none; b=c83qaojhdJ3yloSy7+x5zbdK1IdMc3eKvOi+Kv1P8jxaknFQuCdR2IqE0nqOLvyWSfkXWIdk6BYTCMfRucjwYF7+ruyJ1CihdCa3ouBV1ubZzLDnMkoQRSCLBhYIDbqEt48PlfjOFXde/QN2aLBLZ1BBcj5dYD3APL2K1WtYJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717220549; c=relaxed/simple;
	bh=yjuDfddDC7JTFnetf1bGE6P7K3C2gfUsS56QzBWctok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLsIVL4Tisf5Nz/r8tYgUb2p6kC7UOwtaQO8BRtyOKhoQFUVbY1Ky0IkmavmTDH1kjSnzxvG1WO57RUZWPrIdRIpwPQLQCvMyAeyXhP9wHMsO5ze5pIKCzQgDUSNwWejFJhBqDgJ1V5XMrAx0p3wXnvRz65HkUk3DACpuHUSYMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2k/0D/d; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6c4f3e0e3d2so905323a12.1;
        Fri, 31 May 2024 22:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717220547; x=1717825347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jrraCNuXD26zSLabfLklSY8vxDEbWSHlAupYO0xbewI=;
        b=H2k/0D/dbBW8i6xP2aYY9Vbm5G3BGdbDjZxlYnv9dmvPy/a+MS+qMPVjcE380vcay0
         SDhE4qK+KOep4g74NVp2c8lHDF4mjrEcMW1sZjvdAlWcobuYSf7fJji+EPzjUyO88ZxG
         jSzSrAo1KXBjSHIhjti/olANzWK6iO/KGV4fQSe9QZlTo7PZqnQJISATG/1q3ioQUNMk
         NVPf90v/ANmB2m7HVlobsJ+eBZyUcBKs90IA7aRC/QxzONSUW6F9Qhma1sxcuaFNZy3/
         3XmiiHlMphR0GUWMWcIrXlipjTMbDG+Pmj2ZNEzGhwRxAjljUIX97SIKq1GQEZ1eM4Ui
         wDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717220547; x=1717825347;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrraCNuXD26zSLabfLklSY8vxDEbWSHlAupYO0xbewI=;
        b=bbQ9dcu+A0JPgH5xmqma1Hc5pIXz7j91ZgBFQFaNP7Lhl4u3ZdTxi3C63LRJUwCOF1
         Obmi9cnmR3jZXcAPNdtMUH0Fsk68aZxSJ96jt4r8kbAsgNT7BIAnV7LJsh6vj1x4Lrq3
         LbKOWZRUo/oBXpGeF4Khr6rDAp2T3Q/0IrhET7HkNvsQ+Sp4UTtEi03yd6i3Ls5KuW1J
         BALrIjrIFlXxLk93FVCCQGS3ykpyZ9vkeIR7++4aj6pNO/jKjj8FkTzRDR3LXm/dl9/s
         ySzQEHX5ywu3mXjIToEv81Mh3EBTFYQy/VNvWdeSI6dOgiwTupuSrHPDAE2w/JSNFyuo
         hQrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQGzHc1TbOy8Zj/B0cYDe5IOxYVy36IHXU6sTlLwDQRxeat3FfOHeVvLTmxXwTkO/m+WVqlyp4v7bdTOJXatwqWda4z67pejLJVML4
X-Gm-Message-State: AOJu0YwVe5gxc75sHUFdJT1a0Wy8jAquNwNsvfU37IlYvaAwtxwPgSVM
	Qh2rf57FTi8YNn5QW+Nw9NpaSKQyVv5OJvB3ie2BQrl3kzFaIVHT6dOgOA==
X-Google-Smtp-Source: AGHT+IEOxm2fF1ZwFMRPEBoD0WKTFOZ7AdlY8dV1jar+rzc54w54FnzJfgoCarfex30gaG0cE31EDw==
X-Received: by 2002:a05:6a21:9984:b0:1af:d228:ca5b with SMTP id adf61e73a8af0-1b26f117b47mr4869671637.21.1717220546992;
        Fri, 31 May 2024 22:42:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a77bb500sm4425340a91.49.2024.05.31.22.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 22:42:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4cc979c3-3ce0-4f31-b5d0-508e1af5fdf4@roeck-us.net>
Date: Fri, 31 May 2024 22:42:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v3 4/4] hwmon: (spd5118) Add support for reading SPD
 data
To: linux-hwmon@vger.kernel.org
Cc: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Armin Wolf <W_Armin@gmx.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20240531230556.1409532-1-linux@roeck-us.net>
 <20240531230556.1409532-5-linux@roeck-us.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240531230556.1409532-5-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/31/24 16:05, Guenter Roeck wrote:
> Add support for reading SPD NVRAM data from SPD5118 (Jedec JESD300)
> compliant memory modules. NVRAM write operation is not supported.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3: New patch
> 
> RFT: I'd like to get some more test coverage before moving forward
>       with this patch. decode-dimms doesn't recognize the 'spd5118'
>       driver.
> 

Looking for feedback:

[ ... ]

> +
> +	nvmem = devm_nvmem_register(dev, &nvmem_config);

This returns ERR_PTR(-EOPNOTSUPP) if CONFIG_NVRAM=n. We have two options:

- Ignore -EOPNOTSUPP and continue registering the hwmon device

or

- Add
	select NVRAM
	select NVRAM_SYSFS
   to the driver's Kconfig entry.

Any preferences ?
	
Thanks,
Guenter


