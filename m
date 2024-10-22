Return-Path: <linux-kernel+bounces-376334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F079AA366
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570F4283E68
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F067E19EEB4;
	Tue, 22 Oct 2024 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEei8IEg"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CD919DF8B;
	Tue, 22 Oct 2024 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604463; cv=none; b=l/miD0NaQE9ObFK0al/leYByYoeCclBoKDzUzvbhb9qoRY9B18oAwDxBXbuCUCQBV/8I9G7rfz6cXQaMeXr0f2iUgxH4+Cf7DoXLPCIBs4c+oPT1k50+gOma2nx5jfVbvIgkKlpITeylF/UpK9Dhl5m/Fp1ELrw61+EftUl+7Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604463; c=relaxed/simple;
	bh=4O/7KDxMFjOWDBpuAEtR0doNNDjMTMvF+Fwhzdn5MFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KGZZrcPPVK3/Wxe44Uod5zCjGxyZy/zaF/64AMjT9tEk7Ylf35Pp45cxxAhoiiUGcexdtNlFjX+LlCZQqx0AXkjy2VeZcgJwqW1SVFJB4WnbaO9v5RpDShcuFPDwva+2eSolT/gfJat1DAnnnpA2frPKiYmVFG1/+qJdv4bDfkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEei8IEg; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7163489149eso4296446a12.1;
        Tue, 22 Oct 2024 06:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729604460; x=1730209260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SfKItWQUZx73+PacVcMxGJfBO/K3tCWg/hGLlJ6Cx/E=;
        b=AEei8IEghpHSBteTG+VFyEE7ZDEWkVOqCx3e8s2HipNwJF706ABuRgecz0wlvAsvM1
         9kbManEo9Fyzy32ghoKrrc050rLzxSj3/6hvchTRmTSOSuIMfKAntIiWEfxnVodQd4O2
         MtmHtdFoSrnEGJ3x5TUicq7A5g1qkNEbk7DKBHRXaL52oRF1Cd8pvKl8WT/1zwpHkCog
         2dnhhNWA2/wGjlC4u08vgtP3E+FRPEqZHP8W9cAy2W4wdwwvPrrKqfHzihiehGtZYBuI
         dozPaoMZHVcCQJjy17PglrcmN4fioba/UuFjupqV69twLrFWRr5zUv0K3VAi2x+lXbFy
         bkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729604460; x=1730209260;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfKItWQUZx73+PacVcMxGJfBO/K3tCWg/hGLlJ6Cx/E=;
        b=MJ269YCp6IUytpv95BeW196zRN6mnfBPoYE03gjDkE4ze+++fF9C+csmhlo5vJkWKG
         UDVXTPAtFX8JAHMCjpEav7bo9uMHBe389x2v6jRiiJL563mIO1/UoV3GRFJyiI7RdoHx
         Uk+F3jHGDNV5wGSII/kdr0ZZFYhBGRqLT2ieB3r1XU+bcbznecP+fbZ7FuaZdGp+Kb2T
         KaqIhG77nmRJaGHeiPMblNW5KNw0vDjetPRygZhAUZueMpYfFjiDnAWihDFpzrxiS2E6
         h0Qt8J8yG6VgccfzMy1SBaH1WZDx0PYsih7tHO5xph2WgmT0B/+kd6fkHdBrKhXBXJgR
         9Enw==
X-Forwarded-Encrypted: i=1; AJvYcCU3YKqRnnvUSkQTSfcqWKcW5abNNda6T40/WaF0gD+2ZxlbtEqQVCQDwJqJCritHrYwlhRHteIsVtYZyD/t@vger.kernel.org, AJvYcCUxUSKwnUyy8vaHL05QITuT/UEJ33zVNo3qbKkuF1008uX+lG1yGbm1AN3Bw0VLUoczQUEYMy3mI07xjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf3GdHRUIv0dRB1HykvvqV7yx2z56zX+ta4BAQDWIJD8N9a25U
	qKM6OY/8yMfIE5qkxjm6wiQVZDbCZBE9E5AUWMNZ3I16CEjWjfeH1x0Tew==
X-Google-Smtp-Source: AGHT+IGkwA982N++bVwNeezp1PgWJoM9VWLHxnVhoatXhk75PGwXZ3DQBAHbwC8dPkp9X7vV0vZrLg==
X-Received: by 2002:a05:6a21:3a94:b0:1d9:21c7:5af7 with SMTP id adf61e73a8af0-1d92c4e0698mr21643709637.15.1729604460347;
        Tue, 22 Oct 2024 06:41:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1407f3csm4705988b3a.211.2024.10.22.06.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 06:40:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <300383ee-3ead-439e-893e-895f3ed49805@roeck-us.net>
Date: Tue, 22 Oct 2024 06:40:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: (it87) Add support for IT8625E
To: Frank Crawford <frank@crawford.emu.id.au>, Ai Chao <aichao@kylinos.cn>,
 jdelvare@suse.com, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241022091319.82503-1-aichao@kylinos.cn>
 <6cab565f05820eb2e1a1c55644be057427ecdf2e.camel@crawford.emu.id.au>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <6cab565f05820eb2e1a1c55644be057427ecdf2e.camel@crawford.emu.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/22/24 03:13, Frank Crawford wrote:
> On Tue, 2024-10-22 at 17:13 +0800, Ai Chao wrote:
>> Add support for IT8625E on Centerm P410.
>>
>> Signed-off-by: Ai Chao <aichao@kylinos.cn>
>> ---
>> change for v2
>>   - Move IT8625E_DEVID after IT8623E_DEVID
>> ---
>>   drivers/hwmon/it87.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
>> index e233aafa8856..4aeb09f3bfdf 100644
>> --- a/drivers/hwmon/it87.c
>> +++ b/drivers/hwmon/it87.c
>> @@ -15,6 +15,7 @@
>>    *            IT8620E  Super I/O chip w/LPC interface
>>    *            IT8622E  Super I/O chip w/LPC interface
>>    *            IT8623E  Super I/O chip w/LPC interface
>> + *            IT8625E  Super I/O chip w/LPC interface
>>    *            IT8628E  Super I/O chip w/LPC interface
>>    *            IT8705F  Super I/O chip w/LPC interface
>>    *            IT8712F  Super I/O chip w/LPC interface
>> @@ -161,6 +162,7 @@ static inline void superio_exit(int ioreg, bool noexit)
>>   #define IT8620E_DEVID 0x8620
>>   #define IT8622E_DEVID 0x8622
>>   #define IT8623E_DEVID 0x8623
>> +#define IT8625E_DEVID 0x8625
>>   #define IT8628E_DEVID 0x8628
>>   #define IT87952E_DEVID 0x8695
>>   
>> @@ -2782,6 +2784,7 @@ static int __init it87_find(int sioaddr, unsigned short *address,
>>    case IT8622E_DEVID:
>>    sio_data->type = it8622;
>>    break;
>> + case IT8625E_DEVID:
>>    case IT8628E_DEVID:
>>    sio_data->type = it8628;
>>    break;
> 
> Can I just add that it isn't a good idea to use the same type for
> different chips.  There are some specific differences between the
> chips, which mean that it should have its own entry in
> 
> static const struct it87_devices it87_devices[]
> 
> even if currently they are very similar.
> 

According to the information I have, the ADC voltage is different,
and 8628 supports PECI but 8625 doesn't. Most importantly, 8625
has multiple register banks. There are also some differences in
fan control; 8628 can explicitly turn fans off using register bits.

Just mapping the chip to it8628 may be convenient, but it is not
acceptable.

Guenter


