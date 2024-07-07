Return-Path: <linux-kernel+bounces-243449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 864D4929641
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 03:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A077281D84
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 01:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9038C3FD4;
	Sun,  7 Jul 2024 01:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8/QM8f9"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E8F1860;
	Sun,  7 Jul 2024 01:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720315199; cv=none; b=nT6DSlaEnRkCcAwJ3ooPROI7M91nZQdhBxtsqt5UlvPG7RSbjC2MIz5+I5/NbcfgndlgZ/WXs1v6UskdpWVaoHCNnJxCM172/4JXOGFLDG5WqQSWTRfGj8a8ywtEk9iF5rrY5cPfk6MTqvAFeWWXCsY8XZmL0NqSoYj1PUUUj3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720315199; c=relaxed/simple;
	bh=S7X53TUg4iqX9kXJsIyxhLmw+AeZ2SwhDT/TVx1aWdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0Y6McVVAyL83EPTacTG019XyD9lORIWgnckGz5m1MBcWsDFiUHucGHeoZwhhlMQOhhi3/Von6yQpCz1DxBYJcV/C/rQqwWUrMbOa5y8C5J4mcahU9Ptd6HYLhs+OKSe4PiGBK6PHnS3RgRb4mjkmRzC+biukyzLFEBsZcu8SkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8/QM8f9; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7f70a708f54so45473339f.3;
        Sat, 06 Jul 2024 18:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720315197; x=1720919997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=19gER6V+PqCJdOhe6PBnQmpdkeHIDtXlX82EoX9sdBE=;
        b=f8/QM8f9Gk5/15J/uPgFGgWx8iC5vsCcm8kAeRiTmvqK9O60Fpl0n/f7MTH7Qd4oh5
         JtFqND1iFWMoff+yAPX5pj9P84Jc4pLCN1tdzIMdy66clDglPR++u6qalcJ+zGyudQFf
         K96NJIcSZ+ycUXSJ6FhXSDauO9bVbgsJYiUv4X4WOMKWwFggWjOpoSonNzc8niPak4Za
         eNqTg9pUVfv7slwnKUc2xH2ukw2LLlFOVOdKqdjUWFdkIL3+65hGtMwE23k+uQrMrT/n
         utXIW7r9Ce/J5L2dZ0f9lR6WE+sP1AbL7RTVwpCMGuwnvV6hwfD5XczsxihLK7tglok8
         D1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720315197; x=1720919997;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19gER6V+PqCJdOhe6PBnQmpdkeHIDtXlX82EoX9sdBE=;
        b=fbn53ZybOkyiK1/td5p+fsWsqEbIViUg8QlYyUNNoVxWiIReX+aNYWZt52EktAgTw9
         JcWW6SedPIOddFOyF7myICthva8xfL+Z+gUpU4u4t4OEB8D2TOhv+XsLHX7bbKsqquVH
         5vtMTgSrH/oR4eh9SyDwXx/18paMaUlBq+3VBk4hLtYmraO6zBNcNzNchEu4656BkWFP
         bMRDRU2WXPJ/ec1R5941eBz6TeuIOWGRzi9uw6ldh3dVMwip6ij1Q+0HTOiiJ37qqENQ
         tBy6Qwp6hI7I7l/REZklNAGtq03QMcb5rxtElEbL40boeXsWJPvPZJsJeiKFtk90UxGn
         AAWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWllnsYIs0JCrqSghU9jOdjGgW3S9h05Ug1M9xm1ko1nwWRtuRFjTv1ghXDezAwfJzrV54AHFz9VOjwjMy4P5ak212aZJCQDxRp51+HsAlZjakb797Ye/EN9xMfg1EbjvI3xCwla9fsUgZTk5dYez6JqSiBKaEgwk6stiF5Y+9XMlnmvQ==
X-Gm-Message-State: AOJu0Yx7Qb2QISWG2y8fRaAnA7S+oXrQvbu/MD4DyVjPu+kCsWar5SQE
	1SHQzS2YTYnsd/pjG8FQGIhq9rwpaAu+y7Wa+GIRma9ZbzTU10dK
X-Google-Smtp-Source: AGHT+IFdPMX5bNItqfSSiKUjXNcAyssN26A7ZPrBymkFLpbUN7wyo0MScBAdZlc4nQfMuhr5NQXW2w==
X-Received: by 2002:a05:6e02:1c27:b0:376:4aa0:1a99 with SMTP id e9e14a558f8ab-383991c0096mr111538605ab.8.1720315197166;
        Sat, 06 Jul 2024 18:19:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb7794f91bsm9512465ad.191.2024.07.06.18.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jul 2024 18:19:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7747c4f1-7ef1-407c-a155-99fa0b77de50@roeck-us.net>
Date: Sat, 6 Jul 2024 18:19:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
To: Inochi Amaoto <inochiama@outlook.com>, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <IA1PR20MB4953967EA6AF3A6EFAE6AB10BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953EC4C486B8D4B186BB848BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <d2ecc9fd-93cf-4175-8074-b44c06b58313@roeck-us.net>
 <IA1PR20MB4953A4C47F52EBB2F200C50DBBD92@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <IA1PR20MB4953A4C47F52EBB2F200C50DBBD92@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/6/24 17:31, Inochi Amaoto wrote:
> On Sat, Jul 06, 2024 at 07:52:47AM GMT, Guenter Roeck wrote:
>> On 7/2/24 19:30, Inochi Amaoto wrote:
>>> SG2042 use an external MCU to provide basic hardware information
>>> and thermal sensors.
>>>
>>> Add driver support for the onboard MCU of SG2042.
>>>
>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>> ---
>>>    Documentation/hwmon/index.rst |   1 +
>>>    Documentation/hwmon/sgmcu.rst |  44 +++
>>>    drivers/hwmon/Kconfig         |  11 +
>>>    drivers/hwmon/Makefile        |   1 +
>>>    drivers/hwmon/sgmcu.c         | 585 ++++++++++++++++++++++++++++++++++
>>>    5 files changed, 642 insertions(+)
>>>    create mode 100644 Documentation/hwmon/sgmcu.rst
>>>    create mode 100644 drivers/hwmon/sgmcu.c
>>>
...
>>> +
>>> +static int sg2042_mcu_read_temp(struct device *dev,
>>> +				u32 attr, int channel,
>>> +				long *val)
>>> +{
>>> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
>>> +	long tmp;
>>
>> Why long ?
>>
> 
> just use to calculate the value.
> 

That is not a valid reason. There won't be any overflows, so int would
be good enough.

Guenter


