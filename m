Return-Path: <linux-kernel+bounces-533960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F2BA460DE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FD4F7ABA7E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37D821D3D9;
	Wed, 26 Feb 2025 13:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Git2Jmjn"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E82A214A7D;
	Wed, 26 Feb 2025 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576398; cv=none; b=naLaE2/A4wI+8OIMyKX7ALVYOoFCxVkqKpyiL+MIiF7KH7MJGGWe7914WIe69nGpR8Cq5ASHicRSzb+FCJ7RMhQn6s1rYi1LJWmcfoImgj2urFG4U+bmx8mTdGg7bCtt+DA/+qKZpOVp4CLgx/T4hmjKx5CXuB3Y568F2i9Sd70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576398; c=relaxed/simple;
	bh=zuke7r2NTBGMWMBeCqFJdmWZgvAKZ3JyeBnY/McItcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GkhySCg7k3UE4QWQEXzg/k7P2QqvksqrUtH4CQfMFpVxbdIlXwLfvKK4X7A7F4DHxBMnbtFjhYT1nuItRghN7wzlTJ1G1xY1WeqPsX/iXlF8qLLog/ww8J6GXWz5H+eOYZQ3/hejBfhjCkgxzY6VkA0/5BS/Aol3RIIMUazPAdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Git2Jmjn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22104c4de96so117663145ad.3;
        Wed, 26 Feb 2025 05:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740576395; x=1741181195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=T3GMzjU+oih8BF4TlXvdazcwBXtPPEYvnOi41Ctkp3g=;
        b=Git2JmjnvS/tbli6SpibEpsfv7CXLsB2tHSq68OSkrJMSCHmso92l8Hj6cZuiCK5QK
         Mfudse/QIKhUi+PvNVKqxuQmGueGG6/U4XOj8II41YpN5OHk/ZtpMtO30BGOnmNuaiJI
         VYbmzfPJw0H1naxn5NMOANqS+NIKE4/RswFcL8pgYpujok2EY2eriffWK/WBw03S6YmH
         d47jH8bd80mmJkCpMHaas9lqV81oZscw0VaO5Sf9/0j3xYDCIw2F8d+u+dpT2ZQCbBaG
         tObHioij3tDe693AKl90Sj0X0gy5ykw1TGYILK6bCn6TWTEZ/pimcYeTkbAl3Hux1tFV
         0WRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740576395; x=1741181195;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3GMzjU+oih8BF4TlXvdazcwBXtPPEYvnOi41Ctkp3g=;
        b=Ysjb7VZCX8DFpsgaXiezOTT5ng+gpFUpSN+Dom0+bU+MADlujunevDMNHAy8Q9NaSj
         Q11U7sHSFvSgGW2bhK8eP7N5im8Jqag/jP1nBNUsDzAyc6YZBh92Bt+jzJhef+Dr5SB4
         e0zJIo9sRrOpXAUSZfxVa+3imD/F0GSWR4uiujW0Iv+kzLPYfURAZ1eBAqiNSdBOb0xz
         0jBOXs+69axXlKNzlvIpFxJQe7zIvav670J5W69+X+gE2Sq51Up9AAbYuq+suIvQEnSa
         EpEAM1W/F4yz1fTnZItHDfBrl8tcq666p8y6aeuO+e+O/HyoO2Jm0HfB3gSs0jVKngZr
         la/A==
X-Forwarded-Encrypted: i=1; AJvYcCVqMpHnN1BF2Ynu8gYpWeMAyE9Tt2EKaUAR8giK1H//eY5TqLPzwGPJO1H7vO9KTGVxyz5YRTJf2hDLT+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjB3E3p6ygJHnYG43OsFLbm/YBRsoEea7IW8CBDYR3fAHo57v5
	vo4xevgPRh7zNZ+AU2jnWR0UX5yBlbSCYXXzI8+5c8+zNwqxSS6ZqIU0CA==
X-Gm-Gg: ASbGncuxn0fr+Kwvjt5tefUQJurlvt9bsEbkZaBCpkAIhhE7ePhDXZWRsXfb/R6Vgge
	wOzo1XTKEFwBDXg7n2++W3EF5HcbJmE+2xOT0YKLdx+U4nnt4i8TaAQVM4HZtOEhrgs1qPbTLgt
	xJy0iTNkcUJjkyss0Gpa9Ps+599iXREPCF5jB1SNUJfGvGn3RXkMpy5TNaihGNVb3SWPQlsRo+4
	Jux29RmVMPiOhqSwmkamnWTEPbxkpcWE7O7QKtnhim6NHOUrbeJNYidw6VKUeuX79BHT9AC4jq7
	5GqV1wFjAn12SF4knrHNLGpkCZ0qZ7Dk2OTRYVoh90tzBzareF+VN1sQsS6WF3cAbZYegLBgVPr
	IXrfz8Lc7rlkFc7I0+g==
X-Google-Smtp-Source: AGHT+IFLFX32uv0xQ9D9arpvZ6fM8Z4cI05rTofdJK5u6DiJWz9YmDCUWfdUyWOYlc33vGKTyXM06Q==
X-Received: by 2002:a05:6a00:22d6:b0:725:b201:2362 with SMTP id d2e1a72fcca58-734790ff768mr11245091b3a.11.1740576395461;
        Wed, 26 Feb 2025 05:26:35 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a72f131sm3383287b3a.76.2025.02.26.05.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 05:26:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d765aeb3-3ca6-44a1-9337-2706621df903@roeck-us.net>
Date: Wed, 26 Feb 2025 05:26:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] hwmon: (acpi_power_meter) Replace hwmon_device_register
To: "lihuisong (C)" <lihuisong@huawei.com>, jdelvare@suse.com
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, liuyonglong@huawei.com
References: <20250225085158.6989-1-lihuisong@huawei.com>
 <8b59c8d0-4710-48ab-ad70-b2eddc74fa9e@roeck-us.net>
 <05bb1583-13c7-25f6-48fb-dc415b3206f9@huawei.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <05bb1583-13c7-25f6-48fb-dc415b3206f9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/26/25 02:19, lihuisong (C) wrote:
> Hi Guenter,
> 
> 在 2025/2/25 21:01, Guenter Roeck 写道:
>> On 2/25/25 00:51, Huisong Li wrote:
>>> When load this mode, we can see the following log:
>>> "power_meter ACPI000D:00: hwmon_device_register() is deprecated. Please
>>>   convert the driver to use hwmon_device_register_with_info()."
>>>
>>> So replace hwmon_device_register with hwmon_device_register_with_info.
>>>
>>> To avoid any changes in the display of some sysfs interfaces, some of
>>> necessary changes in hwmon.c must be made:
>>> 1> For 'power1_average_interval_max/min' interface, insert 'average' to the
>>>     string corresponding to hwmon_power_average_interval_max/max in
>>>     hwmon_power_attr_templates[]. I guess that is what's missing.
>>> 2> Add some string attributes in power sensor type because of below items:
>>>     a) power1_accuracy  --> display like '90.0%'
>>>     b) power1_cap_hyst  --> display 'unknown' when its value is 0xFFFFFFFF
>>>     c) power1_average_min/max --> display 'unknown' when its value is
>>>                                   negative.
>>> Note: All the attributes modified above in hwmon core are not used by other
>>> drivers.
>>>
>>
>> That is not a reason to change the ABI, much less so hiding the change
>> in a driver patch.
>>
>>
> I am trying to replace the deprecated hwmon_device_register with hwmon_device_register_with_info for acpi power meter driver.
> 
> To avoid any changes in the display of some sysfs interfaces, there are two modifications in hwmon core as follows:

The only reason to change the hwmon core would be if it is wrong or if it needs to
be amended. Matching driver expectations is not a valid reason.

> (1) The first modification in hwmon is as follows:
> -->
> @@ -646,8 +653,8 @@ static const char * const hwmon_power_attr_templates[] = {
>       [hwmon_power_enable] = "power%d_enable",
>       [hwmon_power_average] = "power%d_average",
>       [hwmon_power_average_interval] = "power%d_average_interval",
> -    [hwmon_power_average_interval_max] = "power%d_interval_max",
> -    [hwmon_power_average_interval_min] = "power%d_interval_min",
> +    [hwmon_power_average_interval_max] = "power%d_average_interval_max",
> +    [hwmon_power_average_interval_min] = "power%d_average_interval_min",
>       [hwmon_power_average_highest] = "power%d_average_highest",
> 
That is indeed a bug and should be fixed, but in a separate patch.

> The string names, "power%d_interval_max/min", are missing 'average'.
> I think the meaning of these attributes are unclear If no this word. It can be regarded as a fault.
> And power attribute name in acpi power meter is "power1_average_interval_min/max".
> 
> (2)The second modification changes the attribute of 'power_accuracy', 'power_cap_hyst', 'power_average_min' and 'power_average_max' from data to string.
> It is appropriate to assign 'power_accuracy' to string attribute.

No. The ABI states that this is the accuracy in %. We don't append "mV"
to voltages, or "mA" to currents either. The unit is determined by the ABI,
which states that the expected value is a number reflecting %. If a driver
adds "%", it is a driver oddity, but not a hwmon bug. The whole point of
providing numeric values is to simplify parsing from userspace. Adding units
to the displayed value would not only be pointless (since the unit is defined
by the ABI) but also make parsing more difficult.

> Because it can be displayed as '%' and also include decimal point like acpi power meter driver, which is more in line with the meaning of this attribute.

Why ? Are you suggesting that all other attributes should provide units as well
"to be more in line with the meaning of those attributes" ?

It is absolutely not common to add units to sysfs attributes. We are not going
to do that, period.

> It might be better to keep other attributes as data types. But it breaks the cornor display of these attributes in acpi power meter driver as said below.
>     a) power1_cap_hyst  --> display 'unknown' when its value is 0xFFFFFFFF
>     b) power1_average_min/max --> display 'unknown' when its value is negative.

That is a driver problem, not a subsystem problem. If it is so important to retain
that (i.e., if for some reason some userspace program depends on it), just
implement the attributes in the driver.

On a practical note, I do wonder what it means if ACPI reports those values.
It might simply mean that they are not supported. If so, the attributes
should not be instantiated in the first place.

> 
> I want to say that all the attributes modified above in hwmon core are not used by other drivers, so don't break ABI of some driver.

That is not a valid argument. Especially displaying values such as "unknown" or
starting to display units as part of an attributes _is_ an API break since that
is completely unexpected.

> These can't be solved in this driver side.

That is incorrect.

> 
> AFAICS, acpi power meter driver can't replace the deprecated API because their sysfs interfaces will be broken if there's no any modification in hwmon core.
> 

That is simply wrong. The _with_info API supports non-standard attributes
with the extra_groups parameter. Just use that and implement the non-standard
attributes in the driver and explain why you are doing it in a comment.

Guenter


