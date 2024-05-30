Return-Path: <linux-kernel+bounces-195736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77698D5113
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75F57B2396A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E1E46556;
	Thu, 30 May 2024 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB2JEQHH"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D6317F5;
	Thu, 30 May 2024 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090441; cv=none; b=nLzFYD5+8lM1+/AgJm3VE1dQujihSyFN+OjElWXzewI+tuEeAxfv4tX8reD14Zz9mFuID5SeD5sj/f2vulqiQ0G1TsHMCLyHAFUBGH4VWIm0oUcP95DM9BgSwmcb4AtYaKaiSCZtoA+EdbsJEt8xU4h1ZcDBGyq6UVfsvsLd5s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090441; c=relaxed/simple;
	bh=o2WA8Dt+5T27wsfAT64ZKn7et1NXfcL6ZG1iOLp5Kgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FH4GOX6wRp4gLlXEt2E+obrYxlkdFGMFl4Hanq1PldXKka03QZVVi9nRIFeBbL4F7qofPZcwRbbyZK3G2BeaKYbqW3WFInYZhu6E1shQSZBGkaQCOlfJvRLq0Lgg3wRdyyj6Eb4eNT6dzyGYD0Bmf8c+G0a8D0/jJbcTGdLBnug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YB2JEQHH; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70109d34a16so1061540b3a.2;
        Thu, 30 May 2024 10:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717090439; x=1717695239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8cQQIq4Vk18SQ+o1x8PKCLBm75kv15P7l74WYPsGX94=;
        b=YB2JEQHHHow0Lwia4061krdK4Dz1OTbvDLWwH4kyNsZm+bWmjAHn8nAfDFfCE7QRwF
         sI9ypf6/48ajSnHN5D4FwDmK32Tiy+/ohd7V7GcZV3Q3L28B76jlbVWJ6uuGR+cUvKE5
         jbBKseLoHp4JIsz+Y3l0qF2hBANP8PZFZ+cwGonenCfvW/ZP9lQN8a8JMUEIOunb3ITB
         WR3NRYEIFTcVE+76WvME+xpiMRyMe4C0yqViDexYO6np2tb37PSisi3D3MkBpu8cwSW/
         d6+JmaIYD2XjGoQ8HotSux8cGqErdVTjQJ4CXwluKts34/ZBebGqzGa1bytOQ+FvFhNV
         nqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717090439; x=1717695239;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cQQIq4Vk18SQ+o1x8PKCLBm75kv15P7l74WYPsGX94=;
        b=qxK1CfMwVPbON8eqAVIZ+p0e3hQofgi9b/JeweTmkLqoFM93MoweEuU6EkHUNqEvqU
         FocEo6M6OesyMndaTeHp9K4N5V8BQhLlS9/0vKdHzurJ5DWsHW2I/r/sizjQpkJMZbvb
         WxNsGPHy+/j738WqMkc9DiMe0bdZGYhFC1irpkWZWBwa6UdgXNgG9aUVb8N4Lp1m4gK3
         tBAkoTziqe116glAs5n5cmrSa385IfsFxwRsFEa8ntXKy9cZhrDemvxkXnEAGyYUEFuy
         xS7xncAwamHrPjNsRW0i4ofUPs3A6JZsSPujKwq3SyAcBruxtW62wcUbwmoxS/69njHk
         QehA==
X-Forwarded-Encrypted: i=1; AJvYcCV4hwxqJPmAwgGyUvlPK2Puwcz8/bLCE/tlZjMS74hO588IjsM0DUJoejv//N9iLlwV3Bh+yn2fflepWClfvUyAoBY0ooo+mV9KhI6Zm4lMVotHa8v302//4IAzyy8lQ1p5KMnSts6j4IIcqo7Pp5Y9V9eH2ix+e6ksZpUrs0CUqghVaB02
X-Gm-Message-State: AOJu0YzZmMvMJg23tH4qXViKHrwIj0hUexgtISTW7tTZi4tgT0RqGGXS
	WYVnhb0g3aVMErBSAdsY+qTzzypCmNWJFnd7xB7cZRjmfuo0AzDe
X-Google-Smtp-Source: AGHT+IFqJNzMpPTpe6YHSEF/XNZRQetUgRSR1utlDaXVPvHKwE3l7uRpCPKsUh1fNZwkfHXOk+Cb4w==
X-Received: by 2002:a17:902:f2cb:b0:1f4:ac10:3ede with SMTP id d9443c01a7336-1f6195f4a9bmr19639955ad.21.1717090438497;
        Thu, 30 May 2024 10:33:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323feaa0sm404355ad.230.2024.05.30.10.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 10:33:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b8aa563a-5ca1-4624-a1c7-25744f15cfa9@roeck-us.net>
Date: Thu, 30 May 2024 10:33:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwmon: Add support for SPD5118 compliant temperature
 sensors
To: Armin Wolf <W_Armin@gmx.de>, linux-hwmon@vger.kernel.org
Cc: Hristo Venev <hristo@venev.name>, =?UTF-8?Q?Ren=C3=A9_Rebe?=
 <rene@exactcode.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
References: <20240529205204.81208-1-linux@roeck-us.net>
 <20240529205204.81208-3-linux@roeck-us.net>
 <6f1ffb83-a64f-469d-b981-f0da0d2f02ac@gmx.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <6f1ffb83-a64f-469d-b981-f0da0d2f02ac@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/30/24 10:03, Armin Wolf wrote:
> Am 29.05.24 um 22:52 schrieb Guenter Roeck:
> 
[ ... ]

>> +
>> +temp1_lcrit_alarm    Temperature low critical alarm
>> +temp1_min_alarm        Temperature low alarm
>> +temp1_max_alarm        Temperature high alarm
>> +temp1_crit_alarm    Temperature critical alarm
> 
> Maybe it would be a good idea to tell users that the alarm attributes are sticky.
> 

The driver auto-clears them after read, so they are only sticky in the sense
that they will remain active until read. This is quite common for hardware
monitoring devices. However, sure, I'll add a note.

[ ... ]

>> +static int spd5118_write_enable(struct regmap *regmap, u32 attr, long val)
>> +{
>> +    if (val && val != 1)
>> +        return -EINVAL;
>> +
>> +    return regmap_update_bits(regmap, SPD5118_REG_TEMP_CONFIG,
>> +                  SPD5118_TS_DISABLE,
>> +                  val ? 0 : SPD5118_TS_DISABLE);
> 
> The spd5118 spec says that we have to wait 10ms after enabling the sensors before
> we start reading temperature values, maybe we need a delay + locking here?
> 

I don't think that would add much if any value but a lot of complexity
for little gain. I find it acceptable that the sensor returns 0 for a few ms
after enabling it. Pretty much all chips have the same problem, so I am
really not concerned about it.

>> +
>> +static struct i2c_driver spd5118_driver = {
>> +    .class        = I2C_CLASS_HWMON,
>> +    .driver = {
>> +        .name    = "spd5118",
>> +        .of_match_table = spd5118_of_ids,
> 
> The driver is missing suspend support, without it hibernation/S4 sleep will cause the
> limit and config registers to be out of sync with the regmap cache.
> 

Good point. Do you have a means to test this if I add suspend support ?
I have not been able to figure out how to put my system into suspend.

Thanks,
Guenter


