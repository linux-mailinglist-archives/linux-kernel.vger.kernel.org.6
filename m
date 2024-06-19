Return-Path: <linux-kernel+bounces-220444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E64F90E1D8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 05:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0ED828529C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 03:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4359F54278;
	Wed, 19 Jun 2024 03:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esLXs5GA"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB14A52F7A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718766718; cv=none; b=RGbcBjDkNWk4G4SKOtoip4+q3h8vMNyDOAIKrZIvTZEH5Yfnah8vtIAYEz6g2nqtrxIqo2QeIXWmpxXCrCZjQJjVU8JhJC1Nn33L1s6BLfTgnT8VDvl0ktxQClV4BbhPP+nhgvzGVXmKYNmqP5WHBgExVgZGE27fHlTItpkqaac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718766718; c=relaxed/simple;
	bh=x+1lDeAY/6jdsKQoJKuVfc83IJNrm+/XUW42FqNTpzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZGJ9NALPaerDCTUVGnSkzPuok1ovdD25k2iGj3DaugJ1QsYHMn0EfKcZO2hoBwhoBGDA7LhjFe4A9+DY4uBy5HSrcVLuJhu8mckiCpDn4rbaHfbl76E7UUXj3fnraQabaxcEMIC762ups/J1Ee1+AskN+gPVxhL3LUEc9Xw2YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esLXs5GA; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-704313fa830so4799130b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718766716; x=1719371516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xVNpDqWj86RfPLeUMbzBjOKbGG/Tv9IJWyQgHIAQQCM=;
        b=esLXs5GAg/DJHU2qFaFNqyD2qve7z1i6oosZPKHrund5hBsygWsXmMqW2wemimKwsI
         KKXTolcWpiwJKAEnL3cTIxtwmbBdrd7t/PfE3NNPUBfFGFSKZtQC05IYOQP+W3ag6cc+
         N0kl8naD7BKp5EJWXPv3z3cJVF1KjmJrQcWUKfI/SdeVbzePGtj+NboGsNwVRf5N/wNx
         YscMyu37wSA9KWiEH8QcEXzyadNk5OizL9irckD0ajyZTaN7lT9KTIZP50ZfWMNjX74Z
         X3LYnnkPdI4sPe8X0N/PNex7cK4aoFDpv6QhYYNeY4WqZb0aF6U6wbf+UBLTyxMBDk+N
         sOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718766716; x=1719371516;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVNpDqWj86RfPLeUMbzBjOKbGG/Tv9IJWyQgHIAQQCM=;
        b=nJw1ovJ3oLlFoHkv9oprAKa1jFLKXodh6UJ6vTfNasa2R/jE4hzw7DCFUeSLhANvDp
         stHJzZX7q8HWPM7ak31rOlhicFk5Nj218EX2Na9XKReM0DzmbTtJI02NF60+KNJl2NpN
         Z6Q9hdj/LI6LDABpieW/5s9X3Wuqq6D6zxEOjKprkOQghzzxm8FAa57ffoRZYZ0imz7n
         zkHQxlDA6+hjGMHDpvjVQ2rXPETWK9/Lq5ONRroKEPUb1Bro5HEmMjXeoi2Phd3sATjC
         D6titpJUFsxiS54brjY8Ya+ILP3d8255aBWVROv5tXuTYZGnwd2/k9HdwELf/r9GhP+3
         fZgw==
X-Forwarded-Encrypted: i=1; AJvYcCULRuxT6D145T5HQ2jwlpY+mskMomoFnp759xtxa8hgyUA7Zv++sJpGgH9TKVU8jghuxEGrRPIc+FV96vRFlZhGnos3q9JYD0BcLqU+
X-Gm-Message-State: AOJu0Yz3fh5xr3hECoER+7FmCf+m5CcnC91mn/Kuf8+AGrmyMzrVjPv9
	ER7JATEq5CoLA2Q9J6r4HtsqjpktUNnKyqaIspLHkC44Gvyba9Bd
X-Google-Smtp-Source: AGHT+IGrybyHeTlTNak2eqYgNH3MjvmaGAv8VoKg0cZ9atTcWALGV1kk5mZxErV4eVU9bnY1GJrLhw==
X-Received: by 2002:a05:6a00:3c96:b0:704:3491:d735 with SMTP id d2e1a72fcca58-70629cc0a71mr1813776b3a.21.1718766715931;
        Tue, 18 Jun 2024 20:11:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc9744ddsm9687902b3a.71.2024.06.18.20.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 20:11:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2b3d76b8-11a1-4235-9a62-85d6e7917147@roeck-us.net>
Date: Tue, 18 Jun 2024 20:11:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Page select register restrictions in regmap core
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
References: <4b22e04f-3142-4a5a-a8d1-366c4b8bbb73@sirena.org.uk>
 <78c93d6b-af0e-4d96-b213-e1e402524361@roeck-us.net>
 <adcd5997-84ee-4c72-aa37-2940afdc83bd@sirena.org.uk>
 <c4a5fb5c-90b4-488b-8875-a0b819e24bcd@roeck-us.net>
 <19893519-20a6-47cf-bb3b-c61dada627bc@sirena.org.uk>
 <e6733f56-014e-4ea0-aaf8-059334f2b27f@roeck-us.net>
 <1a62fc39-355c-4885-b5f6-b66f01a1328a@sirena.org.uk>
 <0287c32d-0b63-4873-9f71-0094a912f8bb@roeck-us.net>
 <44d4fce5-2ec9-4f62-b7ac-a317c7d843db@sirena.org.uk>
 <3b47b5e3-4eb2-43f9-8f4f-c021d203305e@roeck-us.net>
 <17890e6b-cf00-43cd-9d99-2383b5fbef64@sirena.org.uk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <17890e6b-cf00-43cd-9d99-2383b5fbef64@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/24 13:46, Mark Brown wrote:
> On Tue, Jun 18, 2024 at 12:33:40PM -0700, Guenter Roeck wrote:
>> On 6/18/24 10:45, Mark Brown wrote:
>>> On Tue, Jun 18, 2024 at 09:14:56AM -0700, Guenter Roeck wrote:
> 
>>>> It turns out that at least some i801 controllers don't work with the
>>>> access mechanism used by regmap, or maybe the spd5118 chips don't support
>>>> I2C_FUNC_SMBUS_I2C_BLOCK. I already found that those chips don't support
>>>> auto-incrementing the register address and actually reset the address on byte
>>>> reads (i.e., subsequent calls to i2c_smbus_read_byte() always return the data
>>>> from the first register). Since regmap doesn't have a means for me to say
>>>> "don't use I2C_FUNC_SMBUS_I2C_BLOCK even if the controller supports it",
>>>> I may have to drop regmap support entirely anyway. That would be annoying,
>>>> but right now I have no idea how to work around that problem.
> 
>>> You can set the use_single_read and use_single_write flags in the config
>>> to ensure registers are accessed one at a time, that restriction is
>>> moderately common.
> 
>> That doesn't help, unfortunately. Thinking about it, that is not really
>> surprising. The failing write is to the page register, and that was
>> a single write anyway.
> 
> Oh, that's interesting - I'm kind of surprised the wire protocols differ
> but it's been a while since I looked.  We should probably add this to

Magic solved: As it turns out, recent i801 controllers have a write protect
bit which can be set by the BIOS and prevents writes in the 0x50..0x57 i2c
address range. Apparently this is what happened here. Side effect is that
it is impossible to read the spd5118 eeprom from the operating system
if the write protect bit is set since doing that requires a write to set
the page register.

Sorry for the noise.

Thanks,
Guenter


