Return-Path: <linux-kernel+bounces-421852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD20A9D90ED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 05:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A951693A7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 04:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E67A12FB0A;
	Tue, 26 Nov 2024 04:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/goHHPq"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD84546B5;
	Tue, 26 Nov 2024 04:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732593976; cv=none; b=UCPfaXBUPDYWzPuOo2P/WV6pHTWC8ZPVz7SEnPLmtXEA1TFJ7peIx/nlYV/tc7cPKTSobeUNlOFMmgb3mZj0boYJ54ODx43EOBk9IQc+dKFJttc3AnHtGK2Fb7QHIfVMlZJjkF6j/JuHv/EoXyj2h8OgPQoZigtL/O/ARw/v6p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732593976; c=relaxed/simple;
	bh=RA6rUnWsEwgrh7BUeVccoPkZzdyTA3D1/N8afcy9hrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EmS5OPbj23IikSPuXSFOood/BuVAGkeHJIwvqLDOIMLrngMNpEY26P8o1z40Ei3ghIc4PlUdKMxSpglj2MtN3dFGa3s+BqNuhcn7wfw9F/RemWtpo3P9hnp4+Hxlp/u/r5LxhrXcr48X5zB2LriHGVFEHJS0oWsw0L2CdipDoXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/goHHPq; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fc2dbee20fso1430744a12.3;
        Mon, 25 Nov 2024 20:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732593974; x=1733198774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dW1Rv3w48Y8Z9cV3beXhONty7hGXxNph9QDAsWOmJ+8=;
        b=I/goHHPqVffQz/npcUn8j08m+r5XGJYJsFyRD2m2UpN9CavyU7tste9kg/KylhbnvW
         E9GPJAAwdpNoLwQNFvkLfqgG+RhFTbus+AUCVcUqQpVUxr7JWpzgPMS6w8r5A+L7S8P+
         2kDqm/M02ybd9av53CsOseowFMyRC4tY+kj9bxt5YyRNwCFMhrwOuciq4s2UL/34HMrN
         yzzc5wDJ3dtImISVPCN8rEtzY4LXyJsBTlTQETyrrpLqqpqLeyGBq9jatwTgNIl18GFk
         dJGvyID/CPI2Co/YY2n0QxfeLgDE1GgLB4lnAIyqIicN0iieey/Ef6PhEYje0iIg4dAZ
         4Umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732593974; x=1733198774;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dW1Rv3w48Y8Z9cV3beXhONty7hGXxNph9QDAsWOmJ+8=;
        b=At7H4qGjf5qZNbwgZ8HVJn3sM+Twkn4FvMEWDwIQu0P+BB0b8x0ULWfPO01lEtyiRO
         Rvwjuy1f9o2Ei/u8kS1bnml3GX306FvXZHSpKiWoWJgjcH7d06YxpZqqkMQAWO1+U5gr
         fRnPYpt+poRMWK6sjxqUFxIKNhzBtaszUIrDaOrasqPu3749Vk0c1SaftSSod/p163jR
         ONcLHokTyCd5mXepvRER3MtVCdzOfSAQQPz8SlUnEZqs8rFi/JShVWYNOnf7ZqqZQwPX
         4jBYMso8UaBt9nTxL0iPssYRshxSM8Knc/XdygRKXpYZiNfxPzQ2VnlCY5fgaGj7ZxId
         z4Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUgQNiRutULfajq5uCRfZ92RUgQRqosM4mRS3JF1duEdM+WrUvH5T9rkFhGce3sMChRUMGlO0+wT0O6Mw==@vger.kernel.org, AJvYcCXOgK5vdEU6toJt2H+6HW9kVwLbDm8KpD1LKaoNhCqwPknAEzWmNMM2PRJsWUJDTRDBBasJfT5GDuPYFeVO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ox0gzOruRCA3EtbDqfyF65DQUSn30GhmjM6PveVnO55fGWte
	5pjPUrlcMfChoy2u4UeUGtCc/ij2Ty+u+5BFIv8qOEs/0Tx65/Hx
X-Gm-Gg: ASbGnct7b2PT9I/O/vEjiuschPYEdZDtCnL0NYeGyGamX1J1Z8e87fHasuoJqlS5rLz
	0j5V9QK3rwcPkf4niv1e3SHtxV3obkyQ12AYzQAwZDf6IBt8jE/jpvwSomrolMvthXkF/SL2Qo2
	tW+dQSX0PKPyW1gh/Z/xmT+0lenj4EVr8a9FrMv7H4kZq1rkjJhQLmG3e3WumojTA97j5CI+Plk
	yJVMeD3ms0UzElACrwNOyFtue/Kntsa0tiwZCLBDYjk95vpF2BSGBBtDx1TkPb9loGFjJwWglI/
	QlYV8pW3gaLVPfHKSanlLZQ=
X-Google-Smtp-Source: AGHT+IGC1KxKZrk1W4ydHqVFF0q6jyg/etJOGeyTxr2n7y7+eWF/9NUNr1Nf9fDnBXVJI83eykn/CA==
X-Received: by 2002:a17:903:283:b0:20e:57c8:6ab3 with SMTP id d9443c01a7336-2129f7300c2mr225378215ad.4.1732593973901;
        Mon, 25 Nov 2024 20:06:13 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc147c9sm74000715ad.211.2024.11.25.20.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 20:06:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9d835642-0059-44aa-93ed-8b8f2a636b9b@roeck-us.net>
Date: Mon, 25 Nov 2024 20:06:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] hwmon: (acpi_power_meter) Add the print of no
 notification that hardware limit is enforced
To: "lihuisong (C)" <lihuisong@huawei.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jdelvare@suse.com, liuyonglong@huawei.com, zhanjie9@hisilicon.com,
 zhenglifeng1@huawei.com
References: <20241125093415.21719-1-lihuisong@huawei.com>
 <20241125093415.21719-5-lihuisong@huawei.com>
 <f7274b8d-cb91-4975-be94-69f041e9c4ee@roeck-us.net>
 <1e7e5737-8dd8-172f-f5f7-9cc7967e129e@huawei.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <1e7e5737-8dd8-172f-f5f7-9cc7967e129e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/25/24 19:15, lihuisong (C) wrote:
> 
> 在 2024/11/26 0:13, Guenter Roeck 写道:
>> On 11/25/24 01:34, Huisong Li wrote:
>>> As ACPI spec said, the bit3 of the supported capabilities in _PMC indicates
>>> that the power meter supports notifications when the hardware limit is
>>> enforced. If one platform doesn't report this bit, but support hardware
>>> forced limit through some out-of-band mechanism. Driver wouldn't receive
>>> the related notifications to notify the OSPM to re-read the hardware limit.
>>> So add the print of no notifcation that hardware limit is enforced.
>>>
>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>> ---
>>>   drivers/hwmon/acpi_power_meter.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
>>> index 3500859ff0bf..d3f144986fae 100644
>>> --- a/drivers/hwmon/acpi_power_meter.c
>>> +++ b/drivers/hwmon/acpi_power_meter.c
>>> @@ -712,6 +712,10 @@ static int setup_attrs(struct acpi_power_meter_resource *resource)
>>>               goto skip_unsafe_cap;
>>>           }
>>>   +        if (resource->caps.flags & POWER_METER_CAN_NOTIFY == 0)
>>
>> == has higher precedence than &, so this expression will never be true.
> Indeed.
>>
>> And, indeed:
>>
>> drivers/hwmon/acpi_power_meter.c: In function ‘setup_attrs’:
>> drivers/hwmon/acpi_power_meter.c:701:42: error: suggest parentheses around comparison in operand of ‘&’
> What compilation parameters did you use to intercept this?😁

Nothing special.

make allmodconfig; make drivers/hwmon/acpi_power_meter.o

Guenter

>>
>>> + dev_info(&resource->acpi_dev->dev,
>>> +                 "no notifcation when the hardware limit is enforced.\n");
>>> +
>>>           if (resource->caps.configurable_cap)
>>>               res = register_attrs(resource, rw_cap_attrs);
>>>           else
>>
>> On top of that, I don't see the value in this patch.
>  From the current implement, the value of this patch is little. It's just telling the user that he won't be notified. Notifications are not available.
> 
> Actually, I'd like to add some necessary updates in the notification handler when OSPM receive some notifications, like 0x82, 0x83 event.
> These updates are necessary for this driver, which more follow ACPI spec.
> But I don't know how do handle the notify 0x81 to fix the trip points, so I don't modify it yet.
>>
>> Overall, really, this driver could benefit from a complete overhaul.
>> Its use of the deprecated hwmon_device_register() should tell it all.
> Yes, I also found it.
> But I don't know how to handle struct hwmon_chip_info and if it is appropriate to this driver yet.
> It will be a big modification if it is ok.
>> There is lots of questionable code, such as the unprotected calls to
>> remove_attrs() followed by setup_attrs() in the notification handler.
> Agreed.
> In addition, using struct sensor_template  to create sysfs interface is hard to maintain and not good to me.
> The show_val and show_str are to display based on the index in struct sensor_template.
>> Any updates should be limited to bug fixes and not try to make minor
>> improvements for little if any gain.
>>
> Yes
>>
>> .
> 


