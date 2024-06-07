Return-Path: <linux-kernel+bounces-206801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9ECF900DEB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208831F23E27
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8874515531C;
	Fri,  7 Jun 2024 22:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNCTEW0B"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445A413E05F;
	Fri,  7 Jun 2024 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717798269; cv=none; b=cHXIKv5Y/UNCBvLUCEnBhbF7wHKOuSkf23UfdRMTBW39yoEWEJD8hpqox6ExhIJVFUhvY32Ntz5n3MlkR5nOPqptuaXlFA5GhbVdsxbOS5sl+z2SWND0xePhwbM+bGY219udoBzm+HdC2m4S3Wy2vKX1EvOwBim/pkmTJfN+rkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717798269; c=relaxed/simple;
	bh=xXQD812e0rrbLJLSVwjBuwd5GZVf1+ITwmT/FKpZNPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdUr2swwwV2JBOHD8/H2P+A5A4Q4u0r8hCHufqUYlAfpYVoTIO3U7TX5oou96/gXga8i0YnqMHimT0E/tdPbb7N0+WiCExO5+E4SFPokkeR+8UH0wWD9wnIt2LeG/XIqQl9sJr38FYlw7Mr8QjktOANnGXSBc1ZwXZiV2C/8xCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNCTEW0B; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f6342c5faaso22677525ad.2;
        Fri, 07 Jun 2024 15:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717798268; x=1718403068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NmpeYjQIxS6BadEqp5Kz1zTj/W5Ob73rrO2utvvpa1I=;
        b=jNCTEW0Boh0+sdgRmSzz5lihCoHSAQHBuMytHcnq4OsFwvKX4zqEB2Ab/mF5MogDpJ
         pCXpMicI9MyRP3PMmD1Yh2hN//92JMs+6ECmhFh38xXYq52aNxFBWFC6Gw4ckTNlNr3g
         fiHYbOuw22LWCnn5Gs59STkzUhaCs/AzM32GFmSsGx7Z+WXSj00RwklT9jtuK98aWyBc
         f98+XiY8UoAAdOzBTQhssr4GXpcwPfWrcKxRl59WsBxzRAtTIDaGkgO9UdWj644Jnc/j
         LTvDlkkIYEnkkFsdPDRELmkLUMLjOXYakHfb0n5QzsOisN+UEAkQ0AzvZNbp/4OU8afj
         hejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717798268; x=1718403068;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmpeYjQIxS6BadEqp5Kz1zTj/W5Ob73rrO2utvvpa1I=;
        b=qy1q8Fkmonmo4+RipmnhOdRP764u9f0xe2uvE5FfXLNdSVaTQMy8m+C+VJGqpyktjF
         xd9JY4443xm/hMJwhwROZZUdCYkpekTu0nHs4Il1AeHUDbZrc9t88rfAy86GrapHo54j
         rGqIYrMwnA5N6zWRuo5P1d/H+WOR8yFYsL//Dano2dBb6G+1irEmQfsXpP5PADk+V9JT
         uh8KWDPa9zT769Mw3Le9p8vGpsGaNT5DF2T5pNmFXpR7u29do0wGM6aCwEJsrQ1JctCY
         3BjPrrByMzt+d8q9v1JFAClWompyqP4NuWqOckw5biBSx0jOEU96DsP90QVA0/S9FfhX
         SwdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY0mnl5QUfz5qslhb1PHfc+CAczWcA9zn/7nLZj4zCfDq8AQyYkjAP/bGErbzWHJOLwQQr/7vzhzrYfbUFHto2vF4UpRl5VZGhNayk
X-Gm-Message-State: AOJu0Yw/zp3wddxpooUfUhgOOkgYI/CpPi7LRxDz+DwO0BmIBzQC8kiu
	NiuZLEQzueH+zlPiZn6iZWVbGQ+hqijQ4g6BXkT6GKPHkQoZDedX
X-Google-Smtp-Source: AGHT+IEpxpW/kctd4G38XvR/ZsboJUJWoWbFMp/cXYx7kHjwyCBrf+JVrt8WXIMu744y8dJfjoFl0Q==
X-Received: by 2002:a17:902:dac9:b0:1f2:fb89:1d3e with SMTP id d9443c01a7336-1f6d02d206bmr41370465ad.7.1717798267551;
        Fri, 07 Jun 2024 15:11:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76b206sm39322885ad.65.2024.06.07.15.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 15:11:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ce8bb150-0a16-4e16-ac1f-b2e793355e06@roeck-us.net>
Date: Fri, 7 Jun 2024 15:11:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hwmon: use device_for_each_child_node_scoped()
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jean Delvare <jdelvare@suse.com>, Tim Harvey <tharvey@gateworks.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240404-hwmon_device_for_each_child_node_scoped-v1-0-53997abde43c@gmail.com>
 <0e0d9d44-d7f2-4dc0-9851-06b1f7290976@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <0e0d9d44-d7f2-4dc0-9851-06b1f7290976@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/7/24 14:00, Javier Carrasco wrote:
> On 04/04/2024 13:13, Javier Carrasco wrote:
>> Switch to the _scoped() version introduced in commit 365130fd47af
>> ("device property: Introduce device_for_each_child_node_scoped()")
>> to remove the need for manual calling of fwnode_handle_put() in the
>> paths where the code exits the loop early.
>>
>> There are only two users of the non scoped version in the hwmon
>> subsystem:
>>
>> - ltc2991
>> - gsc-hwmon
>>
>> All calls of fwnode_handle_put() were in error paths.
>>
>> This series is based on the master branch of linux-next (next-20240404)
>> to profif from the scoped version of device_for_each_child_node().
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>> Javier Carrasco (2):
>>        hwmon: (ltc2991) use device_for_each_child_node_scoped()
>>        hwmon: (gsc-hwmon) use device_for_each_child_node_scoped()
>>
>>   drivers/hwmon/gsc-hwmon.c |  7 +------
>>   drivers/hwmon/ltc2991.c   | 11 +++--------
>>   2 files changed, 4 insertions(+), 14 deletions(-)
>> ---
>> base-commit: 2b3d5988ae2cb5cd945ddbc653f0a71706231fdd
>> change-id: 20240404-hwmon_device_for_each_child_node_scoped-6e581c1d8a31
>>
>> Best regards,
> 
> 
> Hi, this patch appears as "superseded" in the patchwork, but I could not
> find what series actually superseded it.
> 
> I just noticed that the cleanup in ltc2991.c turns out to be a bug fix
> as well because there is an error path if "shunt-resistor-micro-ohms" is
> zero that misses the required fwnode_handle_put().
> 
> This is something similar like the recently applied fix for the ltc2992
> [1], but in this case the _scoped() macro already exists and is in use
> in the mainline kernel, and no explicit call to fwnode_handle_put() is
> required unless the fix is to be ported to old kernels that don't have
> the device_for_each_child_node_scoped() macro.
> 
> Link:
> https://lore.kernel.org/linux-hwmon/20240523-fwnode_for_each_available_child_node_scoped-v2-0-701f3a03f2fb@gmail.com/
> [1]
> 

I strongly suspect I confused it with the other series introducing
fwnode_for_each_available_child_node_scoped(). Sorry for the confusion.

Guenter


