Return-Path: <linux-kernel+bounces-427161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95519DFD69
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DDFDB23F65
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A137C1FAC51;
	Mon,  2 Dec 2024 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2/721aG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8D51FA14B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132447; cv=none; b=S5gq5/w3MHSUP7bnPeFhM0FbIkYrOY0IsAWo4a/iZIAsQZZQH1xyYiCA/lsfvViLhDhdAPp8uAuLS+m3TXA874xrWPdQfiRP6aN3jdP+qI+u/Q7nkqTQ6GAzit/TcYu9jl1tTR4teyWzCZnBHiRGc4MI5XcJ+GWLrrRJN+dTl+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132447; c=relaxed/simple;
	bh=zqz61M45A7gJ4prsFzTmL267Hipha0009SgSTSwQY7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvvPjizW/fa1EQNedVmbxio5F416/gk3mFjQXRxzwDDXCbh3fttIRpyKlvPS4fE3mbEYfroiRHu535r0UJo0PxHbzzGEROri7klXMmKJuCgcmEFv48FOfe9GnX1/bA4eHS7Z2KH/uP3+hwJSepR8NM3jkky8fehzBRDfaCPu//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2/721aG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733132444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TL+1X3lhNLJB8JkYdiOTJBHGuuFg1gQPlFzr1aSRstY=;
	b=d2/721aGKj2AjDqCf8KY4ydA9rhgmrz9VTM/FkVzo/ojAUDrguRu6TIkz84hpMSDeGy+qj
	dnUac9KR16hnm1F5KgT2grcOtzEq1l5mxAXho33oavn/9O0h0OasUj78HbHAyU/7JV0DhG
	bQJyL8nw8cXsELTFd45cWGU8OpfqZIE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-UKKda0m2M_OjkZRsLozxgA-1; Mon, 02 Dec 2024 04:40:41 -0500
X-MC-Unique: UKKda0m2M_OjkZRsLozxgA-1
X-Mimecast-MFC-AGG-ID: UKKda0m2M_OjkZRsLozxgA
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d0d2fa9e61so1505490a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:40:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733132440; x=1733737240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TL+1X3lhNLJB8JkYdiOTJBHGuuFg1gQPlFzr1aSRstY=;
        b=HJY05BilskOlfpyTSnihTtUfoMlucvqOjo4Z/HeY8W4rocHR6RR+sGGlwXryfYbnXY
         HBSG1jym7jbMazZ0PEhS6buuAX4/NvkEQYQAXzhciVvXujtilfjABGYX6Q7IdnI/bgnP
         rOtAtXifOLh5GTo8jcbwn+BhxzHcM9d24Xppko1wo1TtuhQfFFffLzVd2QhCs64lnkdJ
         memAi9konNjh+RBCfnWsIXWTZ6eUSxbLXcNEzzS6/KYhHLJS1y6w0xke+eOAyNNzSTEj
         LuLVHGpnzRKQAlSwM9p03Fum6XTXIOjdhO3quNhaj+Hq0LMQ6o6fkBdWfgap6MyJg7xi
         0UmA==
X-Gm-Message-State: AOJu0YzhTRCB86dhskISHT48OhBnkiu5n68u2ROE24U1G15A8078lpgL
	RHemHf+402seur7UZuzSOQflCtaBZ6meYRQfdgucJY1gP2E+PeG8u0ccmrLKUvUG0SZgnQ0g8Gz
	XJMZLdCOv9TetQLs2O7Y8v6kh32/PT2OUm1ZyiX+daGzosWFudPahkil9doLfaQ==
X-Gm-Gg: ASbGncu1Iala93rqhZXFW/lNK+kNfE9pzqaj+Hn1xehJHo6ok0ovwQiHYfVcPKYwrYt
	t7fW8l+bPFh37QGAriCqzCJlD3qVm8ekjrBlNUzuPHeKQ+cxH/nH25LRGEt6GNxAGKIPHKR7qBE
	6as+JvdqsSmIqcxpNOUCr7pCJsxbXyisxYTg4XZUQDuVNse0R3jvF9H90TrN96tD1bjvHWYl1RN
	U2X5uLcEXJWFafRt42tbZNujfCBUM+O4fCHRV0c3rW8Fyf741IZGw==
X-Received: by 2002:a05:6402:5209:b0:5d0:d0c5:f258 with SMTP id 4fb4d7f45d1cf-5d0d0c5f515mr9405087a12.0.1733132439867;
        Mon, 02 Dec 2024 01:40:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQsChcHplO856FuAGHtEWDJBtb13zNFCjqr795yx2Ac7FWF1IGRUkRNYTrkEZTbSBeQU/SgQ==
X-Received: by 2002:a05:6402:5209:b0:5d0:d0c5:f258 with SMTP id 4fb4d7f45d1cf-5d0d0c5f515mr9405061a12.0.1733132439498;
        Mon, 02 Dec 2024 01:40:39 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0e75a2315sm1298934a12.39.2024.12.02.01.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 01:40:39 -0800 (PST)
Message-ID: <faf77fbd-ac09-4736-a31f-57f44800e067@redhat.com>
Date: Mon, 2 Dec 2024 10:40:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] platform: x86: tuxi: Implement TUXEDO TUXI ACPI
 TFAN as thermal subsystem
To: Armin Wolf <W_Armin@gmx.de>, Werner Sembach <wse@tuxedocomputers.com>,
 ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20241127112141.42920-1-wse@tuxedocomputers.com>
 <3530748f-4819-4a02-ae6c-c459952ba82f@gmx.de>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <3530748f-4819-4a02-ae6c-c459952ba82f@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Armin, Werner,

On 1-Dec-24 6:58 PM, Armin Wolf wrote:
> Am 27.11.24 um 12:21 schrieb Werner Sembach:
> 
>> Hi,
>>
>> Following up to https://lore.kernel.org/all/172b7acd-4313-4924-bcbc-41b73b39ada0@tuxedocomputers.com/ and https://lore.kernel.org/all/f26d867e-f247-43bb-a78b-be0bce35c973@roeck-us.net/ I experimented with the thermal subsystem and these are my results so far, but I'm hitting a bit of a wall:
>>
>> As far as I can tell to implement "2. As long as GTMP is > 80°C fan speed must be at least 30%." I would need to add a new gevenor, lets call it "user_space_with_safeguards". I would be nice when the temp <-> fanspeed relation could be passed via the thermal_trip structure. And safeguarding the hardware from userspace only works when I can restrict userspace from just selecting the preexisting "user_space" govenor.
>>
>> So my ideas/questions:
>> - Add a field "min_fanspeed_percent" to the thermal_trip struct that will only be used by the "user_space_with_safeguards" govenor
>> - Add a "user_space_with_safeguards" govenor that is the same as the "user_space" govenor, but on trip, a minimum speed is applied
>> - How can i ensure that on further speed updates the min speed is applied to? I could just implement it directly in the cdev, but that would be spagetti coding around the govenor.
>> - Can I somehow restrict userspace from using certain govenors?
>> - I'm a litte bit confused about the thermal zone "mode" sysfs switch, here it says deactivate for userspace control: https://elixir.bootlin.com/linux/v6.12/source/Documentation/ABI/testing/sysfs-class-thermal#L20, but what about the user_space govenor then?
> 
> Hi,
> 
> i am having little experience with the thermal subsystem, but i suggest that policy decisions like "min_fanspeed_percent" should either:
> 
> - come from the hardware/firmware itself
> - come from userspace
> 
> Effectively this driver tries to enforce a Tuxedo-specific policy that is not directly based on hardware limits. The book "Linux Device Drivers"
> says:
> 
>     "the role of a device driver is providing///mechanism/, not/policy/."
> 
> Furthermore:
> 
>     "When/writing/ drivers, a programmer should pay particular attention to this fundamental concept: write kernel code to access the hardware,
>      but don't force particular policies on the user, since different users have different needs. The driver should deal with making the hardware
>      available, leaving all the issues about/how/ to use the hardware to the applications. A driver, then, is flexible if it offers access to the
>      hardware capabilities without adding constraints."
> 
> The issue is that the Tuxedo-specific policy is not directly connected with the hardware. Some hardware might need a bigger minimum fan speed than
> other hardware for example.
> 
> The hardware (or rather firmware in this case) should communicate those constraints to the linux driver so that we do not need to rely on random
> temperatures for hardware protection.
> 
> This ACPI interface however basically provides us with a hwmon interface and Tuxedo now wants the kernel to enforce their policy on it. I suspect that
> happens for warranty reasons, right?
> 
> Maybe there is a way to enforce this policy through userspace applications?

An important role of device-drivers is also to avoid driving hardware outside
its valid specifications. E.g. charger drivers in the power_supply subsystem
have constant_charge_current and constant_charge_voltage settings which
give a max charging speed in Amperes and a max charging Voltage (typically
4.2V for single Li-xxx cell batteries).

Setting these too high can be very dangerous leading to batteries catching
fire / exploding. so naturally the drivers also have and enforce
constant_charge_current_max and constant_charge_voltage_max sysfs attributes
and the values there do not reflect the maximum what the charger-chip can
handle, but the maximum which the manufacturer has specified for the battery.

This info can e.g. come from devicetree but if not present then the values
applied by the firmware at boot should be read back and used not only
as active, but also as max values.

I believe what Werner wants is pretty much the same thing, allow userspace
to provide its own fan management, but have the kernel monitor the temperature
and if the temperature goes say above 80° Celsius, enforce a min fan-speed of
30% and at 90° enforce a fan-speed of say 70%.

Yes the exact values are a for of policy, but this is a policy to protect
hw from getting damaged and as such is fine to have in the kernel.

As for how to implement this with the thermal subsystem (which indeed looks
like it might be the way to go) I'm not familiar enough with the thermal
subsystem either.

Werner, I suggest that you send an email to the thermal subsystem maintainers
and ask them about this. It would be good to start with explaining your
problem before asking the questions. I would leave out details about the ACPI
interface. Just say you have a temp-sensor + pwm to control fan speed combination
where you want to allow userspace control while having the kernel monitor
things and have the kernel overriding userspace's fan speed setting when
things get too hot, to deal with e.g. the userspace process crashing at
a low fan speed setting.

Regards,

Hans


