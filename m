Return-Path: <linux-kernel+bounces-378937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2819AD771
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1A0284F83
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6391FE108;
	Wed, 23 Oct 2024 22:19:38 +0000 (UTC)
Received: from doubleyoutf.uk (doubleyoutf.uk [109.228.47.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C668E1FAC50;
	Wed, 23 Oct 2024 22:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.228.47.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729721978; cv=none; b=IgLiDYa/kWKTBBBTqOxETsbKZRIbkHdzhIgS6jtuTLH/19yIJZFbPSWtlngwqXzSbix925+wSRsmun6Cw1YCogvQ9PHfECrcI0AEJuFK/0WoLAKua6aUqp8gLyTggRonIAyeyV3NqevlUu1Sfxa8XGqBtrardTpO53RJYnjadno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729721978; c=relaxed/simple;
	bh=C6wLkHk6H0zcO0bClaL7yVkeZ8tNDG9XqbPg4t5Twsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mlcnbuujbEkZ2/eIdhF6r7ZbpqIHoFayW5joaiqU0Yjw2CBl7oqBE7ig+temNL8Uf1SDmAvoOjQkwbVfEo7rGCmYJLyj+eicV2xrbG9UCihm6GokoTnmBJNBO9AKUqWux6BPMvtCQ65CNkBd4mRKh2Mt486MGUjtlYAASh6tbKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khalifa.ws; spf=pass smtp.mailfrom=khalifa.ws; arc=none smtp.client-ip=109.228.47.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khalifa.ws
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khalifa.ws
Received: from [2a00:23cc:d220:b33::b56]
	by doubleyoutf.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ahmad@khalifa.ws>)
	id 1t3jhF-00B5Tw-6U; Wed, 23 Oct 2024 22:19:17 +0000
Message-ID: <0a79c3f1-6fb0-4abf-8ebf-08ecdd0a15c2@khalifa.ws>
Date: Wed, 23 Oct 2024 23:19:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: (it87) Add support for IT8625E
To: Guenter Roeck <linux@roeck-us.net>,
 Frank Crawford <frank@crawford.emu.id.au>, Ai Chao <aichao@kylinos.cn>,
 jdelvare@suse.com, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241022091319.82503-1-aichao@kylinos.cn>
 <6cab565f05820eb2e1a1c55644be057427ecdf2e.camel@crawford.emu.id.au>
 <300383ee-3ead-439e-893e-895f3ed49805@roeck-us.net>
 <103a68d6-d0b8-4e6f-ac8f-c6186b340f81@khalifa.ws>
 <b6c2731b-8fac-4e7a-ab0c-2f36e8a64a69@roeck-us.net>
Content-Language: en-GB
From: Ahmad Khalifa <ahmad@khalifa.ws>
In-Reply-To: <b6c2731b-8fac-4e7a-ab0c-2f36e8a64a69@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/10/2024 16:42, Guenter Roeck wrote:
> On 10/23/24 05:41, Ahmad Khalifa wrote:
>> On 22/10/2024 14:40, Guenter Roeck wrote:
>>> On 10/22/24 03:13, Frank Crawford wrote:
>>>> On Tue, 2024-10-22 at 17:13 +0800, Ai Chao wrote:
>>>>> Add support for IT8625E on Centerm P410.
>> ...
>>>> Can I just add that it isn't a good idea to use the same type for
>>>> different chips.  There are some specific differences between the
>>>> chips, which mean that it should have its own entry in
>>>>
>>>> static const struct it87_devices it87_devices[]
>>>>
>>>> even if currently they are very similar.
>>>
>>> According to the information I have, the ADC voltage is different,
>>> and 8628 supports PECI but 8625 doesn't. Most importantly, 8625
>>> has multiple register banks. There are also some differences in
>>> fan control; 8628 can explicitly turn fans off using register bits.
>>>
>>> Just mapping the chip to it8628 may be convenient, but it is not
>>> acceptable.
>>
>> Side question here. The standard for an acceptable chip driver is pretty
>> high (and rightfully so). But a common use case centres around readonly
>> display of information: temp/fan/in readings. Even just 2-3 readings are
>> better than nothing.
>>
>> Example, I still have to use Frank's out of tree it87 for my IT8688.
>> It works perfectly fine for me, but still not possible to merge that
>> device into hwmon's it87.
>> This IT8625 is another example. The NCT6701D-R will be one more shortly.
>>
> 
> For the most part you can use the kernel driver with force_id parameter.
> That is no different than your suggested patch.
> 
> Nuvoton is usually very supportive, so I don't see a problem adding
> support for NCT6701D-R if someone is willing to spend the time to write
> a driver (or adding support to an existing driver if the chip is similar).

It's on my radar when they release the mini-ITX X870 board over here.
Will need to find the datasheet then.

>> A readonly driver that is configurable from userspace would help in that
>> use case. It can be configured for known devices without datasheets or
>> for testing new devices. Wouldn't even need to access superio config
>> space.
>>
>> Filesystem has fuse, i2c has i2c-dev, input has evdev, ...
>> Would something similar be acceptable for hwmon?
>>
> 
> I would have to details of a proposal, but It seems unlikely.
> After all, chip details have to be sufficiently known to provide
> any driver, even a userspace one. Also, the hwmon ABI (i.s., its set
> of sysfs entries) isn't that special that it would warrant such a
> kernel infrastructure. If at all, it might make more sense to add
> support for this, for example, to libsensors.

Why not libsensors?
Access to ACPI and IO ports (without special file capabilities).
Access to the hwmon sysfs ABI in place of libsensors (as libsensors has
no movement at all - not the best reason, I know)

Maybe access to WMI too, but didn't need it in my tests with gigabyte
WMI, as through ACPI you get fan access in addition to temp

I'll clean up something I used in the past and send an RFC for it.


-- 
Regards,
Ahmad

