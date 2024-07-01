Return-Path: <linux-kernel+bounces-236467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C635191E2B3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421961F21B63
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A828316C6A6;
	Mon,  1 Jul 2024 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbXGq2ax"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFA1137E;
	Mon,  1 Jul 2024 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845228; cv=none; b=SB+CfR0YzYDCxxenNyoWNNc4OdQC5AEaXhLChycJuwdIcyLqLf+5owqgUsSLSYD92OvXXgrkJypQdI9BiW7XmS1miPcfqKNfebo8/oDcPwrhbJWBh4MtjRxhSqG6G9Q4x9Qqgj2iv/shsl4y8jlHe9y/hihxuTZv8tSndLtQqp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845228; c=relaxed/simple;
	bh=IOpOeq/apq9NMfohJySlJTNoOxb5yTQ4ueXxyPg/O/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ow3GrxkS7Ikr4NT7alFyR6MsivXFly4lQudussZJeRiMjt2lzkan1s5TbCg1oqeOquv2YVx+JOGvU5Md4frLOsRQhSZwZ7vgXHZyRBuS42tq9ZXm8EsIKo9VqWn+/Vb5F10i+oY0vnOKg3a/yQri7YgQGqmX/hav7IhN7uHQP8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbXGq2ax; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fa07e4f44eso19936285ad.2;
        Mon, 01 Jul 2024 07:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719845227; x=1720450027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=AK0hCuXAYwD/v/5DkxVcOfPtao36VdBojNvzM07HuK8=;
        b=ZbXGq2axFLMHbfgbrHm4MsZjfHim7bE4vIzVRZwdlOVXPp+4dedSsfuAXhOEpkJOqz
         +6ZoOazR9w0aT1PNtVDaEjfCC+wUM4Uuh1M6ZrzZzOQTLF/opMxEanJjnbIK1kjTSpB6
         vg/OWuqvat1nglJRDjb/nzz/xJgd+biSxpLnwWf2Fsd0DDkbxJnI6QmW+KEAwhpTyjM0
         l0OEe2wQQmdmjFFMzI9X9fYuz1cLqxpnBb51+tIo9TSTNa7EOWYc48z/F8wJ1K6ILsuL
         e478ayZlPRpZcsHpqVS9v9rNiv8lvRchQ5oRvoBbBUDM/BvzJz5hudU4eTQpmFKh3JRV
         jPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719845227; x=1720450027;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AK0hCuXAYwD/v/5DkxVcOfPtao36VdBojNvzM07HuK8=;
        b=dSJHA+fM708TJo3StPfFZCp+4VS1WHxJNqaFMmqNbt2PWC3ce1GO+YvpnKKV8Sfw3+
         Fw8HEL/cWgEks4LLrT2hAHsPFLu0FHFxApUM0ZNQE2LEt/hpfgQXr6X0vuCV1jM1Zbfq
         mgLgpBiGtS+YII3Saeu9vx7i4pfdVSKQaWiOkZsMRI4YNlE+ZgJr62illNpaGkYZBplw
         Z6NQjOPj0fPTmdCYpaq5ZsZcWCFUPGK0x+y0c75FYeK52ko5YicCdX0QdMxq7IXRKSBg
         rRsDjfjibfmyvDGL/dRXD9n3JxKpShOvovUVryGk68lP0vCshxo8y8bkA9orPMrp1V/v
         DcsA==
X-Forwarded-Encrypted: i=1; AJvYcCUi+EAALT3tlyVzddVPg5jB3a5OKB0Lu+2wXF5XzMM02YXWeG368MYdPb13Rlp67YUx0QZELZLRUQ6wvsSUz6W9ueFiwQJGEu3BNjM=
X-Gm-Message-State: AOJu0Yzi0329pH0OZPYD6WVj7BQOYOdu92XcbCrtFNXS+gGj5zdsyZ/n
	rRrPGtY9RLF7aOz71QLromx3Tn8hd6Aw0k+FKa9Y+yzvWjTfduBA
X-Google-Smtp-Source: AGHT+IHvELqW6jsrflenH2VfTKma0cpHpdiqh38xFQaXb/Kfl3/SfFAQdt7NLzyGDUiFBulJQG+2zg==
X-Received: by 2002:a17:902:c409:b0:1fa:292f:cb20 with SMTP id d9443c01a7336-1fadbcfb91cmr60514265ad.58.1719845226703;
        Mon, 01 Jul 2024 07:47:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d2282sm65609135ad.44.2024.07.01.07.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 07:47:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cdcedb9a-3619-4448-9047-c250e7df1a81@roeck-us.net>
Date: Mon, 1 Jul 2024 07:47:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] hwmon: (amc6821) Drop unnecessary enum chips
To: Quentin Schulz <quentin.schulz@cherry.de>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-9-linux@roeck-us.net>
 <3108c6e2-c865-4170-bf23-f45dba429e80@cherry.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <3108c6e2-c865-4170-bf23-f45dba429e80@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/1/24 04:36, Quentin Schulz wrote:
> Hi Guenter,
> 
> On 6/28/24 5:13 PM, Guenter Roeck wrote:
>> The driver only supports a single chip, so an enum
>> to determine the chip type is unnecessary. Drop it.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/amc6821.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
>> index 042e2044de7b..ebffc9393c3d 100644
>> --- a/drivers/hwmon/amc6821.c
>> +++ b/drivers/hwmon/amc6821.c
>> @@ -36,8 +36,6 @@ module_param(pwminv, int, 0444);
>>   static int init = 1; /*Power-on initialization.*/
>>   module_param(init, int, 0444);
>> -enum chips { amc6821 };
>> -
>>   #define AMC6821_REG_DEV_ID        0x3D
>>   #define AMC6821_REG_COMP_ID        0x3E
>>   #define AMC6821_REG_CONF1        0x00
>> @@ -943,7 +941,7 @@ static int amc6821_probe(struct i2c_client *client)
>>   }
>>   static const struct i2c_device_id amc6821_id[] = {
>> -    { "amc6821", amc6821 },
>> +    { "amc6821", 0 },
> 
> amc6821_id being a global variable, its content should be initialized by the compiler if omitted, and the default value of kernel_ulong_t (aka unsigned long) is 0. So I think we could just remove the second parameter there.
> 
> Doesn't hurt to keep it though and it seems there's a mix of implicit and explicit initialization among the i2c kernel drivers, so with that said:
> 

I may use that inconsistently myself. I am never sure if I want to say
"keep default" or "explicitly state that the value is 0". I'll keep
it as-is.

> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 

Thanks,
Guenter


