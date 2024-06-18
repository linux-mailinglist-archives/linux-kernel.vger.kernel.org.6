Return-Path: <linux-kernel+bounces-219856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 937B690D8EC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170271F2719C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6995113DB8C;
	Tue, 18 Jun 2024 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCWXOKWN"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D011813D8A3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727301; cv=none; b=PIud0UbeRPMGsbW3MBcq4D+P4HzAE8La7/4LlhR5Zr6sDL8/zsskooOmZWe1vbTJ9pCPjeddCDSAf1B/Wfsp7NAc374L7Kwxbn/6i89v6Iu/CiwS8hy/dq7gDH/T4Llu1f/wu2brGrv9AbO2RoqExMNuxkTRiaMJQJ/4vi+tkDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727301; c=relaxed/simple;
	bh=MpXza9CQNdXbJqKuIPp1VltzMmXmeMhSnSfG3Bk7Xd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcevqYHc86C2cfGeRXImdTypUdx53x5hoROwzFpgdgUxudq54w2iD2eG+yAYrYZ/NE795dGBkLV4SDAs2sXGz8KZbs/2fKVJS4rl0ev8ap09HL/UPrbuPlY4I9JweGImvMQ9gRS2fTpK3TiKgVAqtJnYqxtXT9h2JI3+wauJXM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCWXOKWN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f44b441b08so41754515ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718727299; x=1719332099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=E28bOP3KN4gJ9Vzs3OF5FNLIRJZRsggcbehhigPLIDk=;
        b=bCWXOKWNEakRk0M9hNwedzz1lRoytVf4kUEqTQYsKcS8+CqpJ+JCk2D2XHJf3mnLyr
         vtk5uoCxNSTiX4NgztEm+nlSIOU4eHjrojWO8QrnUg7IlnigceLYZYQ9AO8C4hepLEKv
         ZZyosNZH5z3lNnStwHUZXNyWB0jX4Wzy+t2NVZA7IJIKG9AaZHzv95k0h4uccdMGv6Bc
         L9sR93P+z6p8+RFXpId0zIWrm6bovPDXR9pSW+RKvvM4SeaKxbCL3wdCVQv5SdRPzhl0
         B/0BDRycowy0ZuGeFx4MFCbe6fr4LbCtubhTqMuMjIbq9dr5W25wwVXZHSk8XOjZmDut
         d3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718727299; x=1719332099;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E28bOP3KN4gJ9Vzs3OF5FNLIRJZRsggcbehhigPLIDk=;
        b=mlRJfII1ycKMa7JwYxV5Staa4JcMddv9m3003XJOOle0pf+v7ghhD2fIaaTwuwM0Ci
         2LAhXVRUShuCyjNh9xCr815aQoGZfUHL+fOScYZWb4ajex0GHu3Cri+eG7SJaP44DSZR
         uBvo251CGl61AUmXIGPdWSPb1KcDG5HiCG7r/MRkWfGNPlmfXDpGicRUd1rt1r5gUuk2
         Iv2VkW/iuhAVBygJyJUftKoi9JULleT0rEOgsHRQCQ+YzX9yz5CKvmeAjxO7Q8Bi451n
         UcZerr6MPgO5cDi4RFKtkS7WqsCkppAOteYffne6/SUjBXP6QxdQOTaGAqDMvT3juHTM
         lCVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK2m4PHl9lX12b6L2HI8Hm/t+ccJWVy0f0cOqKxl7Oxsg0CY28NfWND/R0EgH9qgINQAZrlYI6aWAo5DiRInCakQsKi8we9bArQ/zx
X-Gm-Message-State: AOJu0Yzkd9t1QHboK1FVh4eUgh8k02Zz7Jw6FBaHH+7Tob8+JVVgoLhs
	6prZfpO4YL5WG3jlLyi3XMZOyN6So4PPmaX8JXHI73EMeQJAOdus
X-Google-Smtp-Source: AGHT+IFBNCbpdi3j3mPmdtEbe+18/Ex18PFuDEYVDqGaAqWDjkh8BoSnboq+02MJtrHluT1RMgHiuA==
X-Received: by 2002:a17:902:ec8a:b0:1f7:2dca:ea42 with SMTP id d9443c01a7336-1f9aa486cc6mr605835ad.60.1718727298847;
        Tue, 18 Jun 2024 09:14:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9aa0589a7sm833255ad.159.2024.06.18.09.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 09:14:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0287c32d-0b63-4873-9f71-0094a912f8bb@roeck-us.net>
Date: Tue, 18 Jun 2024 09:14:56 -0700
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
References: <e3e11724-794d-423e-9326-ffe8eed5119c@roeck-us.net>
 <4b22e04f-3142-4a5a-a8d1-366c4b8bbb73@sirena.org.uk>
 <78c93d6b-af0e-4d96-b213-e1e402524361@roeck-us.net>
 <adcd5997-84ee-4c72-aa37-2940afdc83bd@sirena.org.uk>
 <c4a5fb5c-90b4-488b-8875-a0b819e24bcd@roeck-us.net>
 <19893519-20a6-47cf-bb3b-c61dada627bc@sirena.org.uk>
 <e6733f56-014e-4ea0-aaf8-059334f2b27f@roeck-us.net>
 <1a62fc39-355c-4885-b5f6-b66f01a1328a@sirena.org.uk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <1a62fc39-355c-4885-b5f6-b66f01a1328a@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/24 04:35, Mark Brown wrote:
> On Mon, Jun 17, 2024 at 04:15:33PM -0700, Guenter Roeck wrote:
>> On 6/17/24 15:47, Mark Brown wrote:
>>> On Mon, Jun 17, 2024 at 02:55:09PM -0700, Guenter Roeck wrote:
>>>> On 6/17/24 10:22, Mark Brown wrote:
> 
>>>> each register address and then accessing, say, the revision register
>>>> not as register 0x02 but as register 0x102. I would then define the matching
>>>> range from 0x100 .. 0x17f and the window from 0x00..0x7f.
> 
>>> That would make the range exactly the same size as the window so there'd
>>> be no paging going on and the registers could be accessed directly?  I
>>> guess that's another check that should be added...
> 
>> I tried to explain this before. The registers in address range 00..0x7f
>> are physical, but they are only accessible from page 0 with the exception
>> of the page select register. So, sure, the registers are not actually paged,
>> but page 0 must be selected to access them. That is the one and only reason
>> for specifying that first range and window. It ensures that page 0 is
>> selected when accessing the registers. If that wasn't the case, I could
>> define a single range for the actually paged addresses in the 0x80..0xff
>> window and be done with it.
> 
> So surely this means that the entire register map is one window and
> there's no point in defining two ranges?  Those registers are paged with
> the same selector as the other registers.  At which point you can just
> sidestep the issue and be like the other current problematic drivers.
> 

Just define a single range covering the entire window ? That might actually
work if I manipulate the nvmem addresses such that they always point to the
upper 64 bytes. I'll give that a try.

>> The non-regmap access all happens in the probe function before regmap is
>> initialized. It is needed for basic chip identification, to prevent someone
>> from instantiating the driver on a random nvram/eeprom and messing it up
>> with attempts to write the page select register. I would not want to be
>> held responsible for someone with, say, DDR4 DIMMs force-instantiating
>> the spd5118 driver and then complaining about bricked DIMMs.
> 
> What some devices do for enumeration if the fully specified regmap won't
> work for all is create a trivial regmap used for enumeration, then throw
> that away and instantiate a new regmap based on the results of initial
> identification, though that wouldn't really work for letting you skip
> paging.  I don't see how you avoid handling paging in the probe theough,
> unless you just assume that the chip is left on page 0 by whatever came
> before.

Since it is known that other registers return 0 if they are on a page
other than 0, I can check if the page register is not 0 and valid, and
if the other registers do all return 0. That is not perfect either,
but if that passes I can select page 0 and check if those other registers
now return valid data. If that is not the case I write the old value back
into the page register and abort. Yes, I know, that isn't perfect.

Anyway, this may be all irrelevant in respect to regmap support.
It turns out that at least some i801 controllers don't work with the
access mechanism used by regmap, or maybe the spd5118 chips don't support
I2C_FUNC_SMBUS_I2C_BLOCK. I already found that those chips don't support
auto-incrementing the register address and actually reset the address on byte
reads (i.e., subsequent calls to i2c_smbus_read_byte() always return the data
from the first register). Since regmap doesn't have a means for me to say
"don't use I2C_FUNC_SMBUS_I2C_BLOCK even if the controller supports it",
I may have to drop regmap support entirely anyway. That would be annoying,
but right now I have no idea how to work around that problem.

Thanks,
Guenter


