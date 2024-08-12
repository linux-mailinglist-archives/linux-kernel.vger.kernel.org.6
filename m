Return-Path: <linux-kernel+bounces-282564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F063494E5DA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC8DB2154A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 04:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE11114A4E0;
	Mon, 12 Aug 2024 04:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmD6rkDp"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416A313D538;
	Mon, 12 Aug 2024 04:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723437861; cv=none; b=rSyPR0PMRzKQsbk2QijK/lnjlPzEWRwQMFUYs8175xs9nLFbWTDhC+8Aw1AwUB/VMcfDuwCJ4WU1s/y1xBczB5fwVRtbuCL/WEgNJlQAod7GJ8TRyZRSTfrgrRGFz62ykwnHVIenLEOuk0qVjFlcd9DeS2+m4zgvQrWTnjGmK6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723437861; c=relaxed/simple;
	bh=wrbx1SzRRFuWcAtQDnoJrPSjA99s2GTtk6K1U4SARf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdG/Esi2qMZaNbjGjkAFWACao47R+m8LAAjslcXgSkl0AYTIfgEVIHvURFPVcKEbZGVX5r713TT4JBj4Oltd88GNoKvau0TpfvM5z6Fmgr/I6TRsRndu9WeVHAmTRlXCUm6/WHhZVwK4dg7BmyySDzhneNiv8FxKPyV/tMgv2/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmD6rkDp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc60c3ead4so24859965ad.0;
        Sun, 11 Aug 2024 21:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723437858; x=1724042658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/SAfjgx6H3vtUAMqTlzmnBXJCeiJOJ+9rB56wFJ3GdI=;
        b=NmD6rkDpQik4ylQ1UfkSrF0wTbL0nlMTIh4xxlQ5GhmFJslE9FFSVsj7fJHZv5grD1
         E6huP/ITLxTcES1bdQiYqcIozaybNm1ACY3+CgEVZ5myPmMXruv230V8fULn3/IkWMEu
         Luqf53AaKE1MPAoPLelv2YF1h+NgMn0t6lNLbmD76yo5OYXsPhaqGm5ZgdRZoHOOt8bt
         vCpu+x9lQ9Kvsa7kPTCMIR3NQeTUsPvtwNacyjA5IzZsba7PdXoVVk72M2qNa8Xa7pDz
         zHOcKqCxQcKjIS0qQLJIt5KYxO2ahv1EuRsHFNSBoPJBgGyy4dDNu7sgGFa0jnfPdAtU
         vq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723437858; x=1724042658;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SAfjgx6H3vtUAMqTlzmnBXJCeiJOJ+9rB56wFJ3GdI=;
        b=OKe89aGTBvw9o3mSzuif9NVvh3SwKIjF3U/lJyDf2P+7+1fi8E4LILMBDb7Cgd7SGp
         cQEM/QXW+GNXWzXvEbXuFMPUVWnerilFTAyACDOiyavluvbKneqWQKLXZipylQcaWjRK
         sJBe4FCinA4S5Dl1qGjIJUGkAn/EoZX8Oeb2pbe2xEtaxpYjktC/uisf2k7z6EDBG3qZ
         4wA8Wy/CwqQkJSbcIdag8te8kFO+tyxJboZEFZaXh1VrERYdi5zkfeOXLChHpzZyXDl0
         OiFRRNC1A2kSh2BHZ8q2FW0NtoHksFLDnlA6WUID/8c+6ZpPl5Oh0aebv4Qmxv7t/FrU
         8PfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmO2mTIptE5osIx6NLuoRu8RZngur4hBuAiXSKpf8heezYsSR9AH7/Zsw7hiOyvptN6cQ/eEzzgv5DfxPJlT9AImxFC8bWzuF9HokFVY4bEbLFb9dBZRfN0fzG4xEEsN999eyt02/kSUs=
X-Gm-Message-State: AOJu0Yx6fHM1Emlvaz2lOumAFz+y3l0icSKRsqIjR76+KxZmhRHr+b2J
	UR7vDmkxVbM+AZ9EEj/khi02408ItoiIMBMpJE7nfUHp4ZJkLYo323FFPA==
X-Google-Smtp-Source: AGHT+IHDbc7ts9ORmAnYxrXh4AnDjXnPcmHsSDt8D3ZlNz4E1o0SwWGypb3AUshHnZPQu0NudqOoug==
X-Received: by 2002:a17:902:db10:b0:1fb:bd7:f232 with SMTP id d9443c01a7336-200ae545a6amr71891535ad.23.1723437858270;
        Sun, 11 Aug 2024 21:44:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb900c2esm29296565ad.112.2024.08.11.21.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 21:44:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4f048dcb-876f-4900-9ab9-3df03aedff9b@roeck-us.net>
Date: Sun, 11 Aug 2024 21:44:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (surface_fan) Change dependency on
 SURFACE_AGGREGATOR_BUS to 'select'
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240810214709.425095-1-luzmaximilian@gmail.com>
 <0d8bc971-7780-42a2-8617-aeb3bb9bbfd1@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <0d8bc971-7780-42a2-8617-aeb3bb9bbfd1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/10/24 16:20, Maximilian Luz wrote:
> On 8/10/24 11:47 PM, Maximilian Luz wrote:
>> The SURFACE_AGGREGATOR_BUS option specifies whether SAM bus support is
>> build into the SAM controller driver or not. The surface_fan module
>> requires this, due to which it has a dependency on the option.
>>
>> However, from an end-user perspective, it makes more sense to
>> automatically enable the option when choosing to include the fan driver,
>> rather than requiring the user to know that they have to enable bus
>> support first before they get shown the option for the fan driver.
>>
>> Therefore change the 'depends on' to 'select'.
>>
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>> ---
>>   drivers/hwmon/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index b60fe2e58ad6..e4d9a035a57a 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -2069,7 +2069,7 @@ config SENSORS_SFCTEMP
>>   config SENSORS_SURFACE_FAN
>>       tristate "Surface Fan Driver"
>>       depends on SURFACE_AGGREGATOR
>> -    depends on SURFACE_AGGREGATOR_BUS
>> +    select SURFACE_AGGREGATOR_BUS
>>       help
>>         Driver that provides monitoring of the fan on Surface Pro devices that
>>         have a fan, like the Surface Pro 9.
> 
> I should have properly build-tested this, sorry. It seems that it
> creates a recursion in Kconfig. So please disregard this, and let's
> stick to "depends on" until I have figured this out.
> 

You'd probably have to change all of them at the same time.

Guenter



