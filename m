Return-Path: <linux-kernel+bounces-278474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C856594B0AA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11D78B20E57
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85937144D39;
	Wed,  7 Aug 2024 19:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhcHFpkI"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41723C08A;
	Wed,  7 Aug 2024 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723060235; cv=none; b=g2pbrRCxIKJh83Zxv5sKxfifnkpIP3hdDhfvAmQUZpAcWijwJh/NOExQL7JegCe/OBy1kKrvZ2J2ZNB90O+9MLthz+fIu+anNMy+RAvyxwDNrUkOiLMXAynp4Sk/YN2/jswUgrErBQ/rpWBCprqcT8cGGeF9lKNdf1Agm8afYCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723060235; c=relaxed/simple;
	bh=kfpf/KbwnxWanPwG/dWjoKII0tngvEh9kMCkhVwGW1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=devPIRbEQA1cGcGUlbaDd7tMZKNrBCoNFLj0wahmPKz8Ebzk3NPcCFYTvr/TLXydyh8iC0XPEVMB4qdzTWkE7vX5+x2tXi43awkkT11D8tgHv8GRSRDrAJUsY2qvZxs5Yk3LUZohGzpybBvZTiwHAuU/nOBJzgj5P/I/sgDV76Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhcHFpkI; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cb5789297eso210887a91.3;
        Wed, 07 Aug 2024 12:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723060233; x=1723665033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SrnM4z1aMog3WyFfpcH8S6uN+gugvwxYiHzVZ8HUpMU=;
        b=KhcHFpkILq9jtpsCanCGLFBWBygg9Etct9u1XkiCB5d/meeV8QXlxowjrzfPP6DIgh
         u5knbv0zrr/6u+53cDyuRcstlit1/oqfm+194I7HgUDTcjwN98OqacexteTjtOF6fnWs
         MUMZF+Voe0H4/X7DHvHjbaFs8EWrXrlZMSbSCyFC3Z029uoK2RGW2QfckCMjOOyTXY5w
         Q8E01sNkGldif3c29OILh2HNCnidpWAkbh/aChFnV/b27+hlfOyg72/+/18loSZBuNi+
         T4osce/yfRtZBPWMLbeulqSVK8/Y1uRqGNP18efIzW/CSEXSv+gojm/vxYVV0sq6OFLn
         a/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723060233; x=1723665033;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrnM4z1aMog3WyFfpcH8S6uN+gugvwxYiHzVZ8HUpMU=;
        b=PyambIZTKs8Rn5+JTmO2jAs+iaQ2JHnxVuBWL6q+yXl38+57ToSZw8nlF6th6habaX
         vnRvKuNIdABASB0UOgYdJrL0SkHfzlE0/HTPXdzbjPbz5Dxatrb3Wwd8Op+jg+EdYPKE
         4kaJb/FMwYYPtN0+h538LHh8DvpIemuHDSm24uVmnSCOqaNsMnmoO8U1gNCepu7o1u0o
         MLmBB8mKnqArU/tD5lczZsLKwaLW0HkUbU8EvGjyLxFe8IzyOhsPKfj4Zka7RHD8FrEs
         vDMDj41wl+12h1a8Lvfarx8yT+EZlVs1l2LAhXwkzT5awBbKelpGaLnEYlxdUTz9Ioj9
         0z3A==
X-Forwarded-Encrypted: i=1; AJvYcCUjKrGJII17EVu68sTZlfkS+RWwr5xX/3kFMawPyB3Hguj1bQ2ZW4ZXKwo0DwDpyq2atUNw9mWfDK5z2x1rci3LLVet4wdbVxT1xjwqr6FXT2Rh8fB8fhs5h2staA1gPraaBXonssbqqmg=
X-Gm-Message-State: AOJu0YzyPALQdI5MPSbM+LO72Kg/D2T9z9AtkM3H4+scDcEwk9qhX5A+
	RY3H/ILR7/ERNmTNovf9NhVyjNCajiCT9+0so4HgwW2xK+EiylA6
X-Google-Smtp-Source: AGHT+IEmXFmGlWKiVi96Ru8hszJAYvMXhIdaevfqMp3zN7njg5R7cr/zi+s72phWmJaDNkTHirmO8g==
X-Received: by 2002:a17:90a:c68c:b0:2c9:99e4:51bd with SMTP id 98e67ed59e1d1-2cff9526dbemr18833349a91.29.1723060232967;
        Wed, 07 Aug 2024 12:50:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b36d82e1sm2007783a91.30.2024.08.07.12.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 12:50:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5208afb1-92dc-43d3-b6ed-36a2fdd40ec7@roeck-us.net>
Date: Wed, 7 Aug 2024 12:50:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: Add thermal sensor driver for Surface
 Aggregator Module
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Hans de Goede <hdegoede@redhat.com>,
 Ivor Wanders <ivor@iwanders.net>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240804230832.247852-1-luzmaximilian@gmail.com>
 <2419e2ab-25e2-483b-a163-6b4fbfef6866@roeck-us.net>
 <5d11350f-71b0-44fc-8631-01e1740581d6@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <5d11350f-71b0-44fc-8631-01e1740581d6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/24 12:25, Maximilian Luz wrote:
> On 8/7/24 2:32 AM, Guenter Roeck wrote:
>> On 8/4/24 16:08, Maximilian Luz wrote:
> 
> [...]
> 
>>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>>> index b60fe2e58ad6..70c6385f0ed6 100644
>>> --- a/drivers/hwmon/Kconfig
>>> +++ b/drivers/hwmon/Kconfig
>>> @@ -2080,6 +2080,16 @@ config SENSORS_SURFACE_FAN
>>>         Select M or Y here, if you want to be able to read the fan's speed.
>>> +config SENSORS_SURFACE_TEMP
>>> +    tristate "Microsoft Surface Thermal Sensor Driver"
>>> +    depends on SURFACE_AGGREGATOR
>>
>> As the kernel test robot points out, this dependency is wrong.
>> __ssam_device_driver_register() is only available
>> if SURFACE_AGGREGATOR_BUS is enabled.
> 
> Right, I should have spotted this before submission, sorry. This should
> be
> 
>    depends on SURFACE_AGGREGATOR
>    depends on SURFACE_AGGREGATOR_BUS
> 

SURFACE_AGGREGATOR_BUS already depends on SURFACE_AGGREGATOR, so the extra
dependency is not needed.

> I'll fix that for v3 and likely re-spin this weekend. Anything else I
> should address for that?
> 

I didn't notice anything, but then I didn't try to build the code myself,
or try to run checkpatch. My tools run checkpatch --strict, as necessary
for hwmon submissions, so you might want to make sure that it passes.

Guenter


