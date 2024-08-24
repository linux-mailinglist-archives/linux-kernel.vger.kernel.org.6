Return-Path: <linux-kernel+bounces-300032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FC095DDD7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 14:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6EE51F22343
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 12:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7C71662FB;
	Sat, 24 Aug 2024 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrBjyHnU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D42F3B78D
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724502961; cv=none; b=C8D2KPg6EGAHUnrCiX3FxD4ulPkC61QT87Mn6UvGhplm6f13Zw4gQ1IC4IwoyROxqdJt+oWoPNeKqaLF0EVoa1EJ8RsxYuldVwFpT+QD3vUCZtB99+Pr62g7BFnCxr1TBmpJymXPvlDoW25Sdzo0Q4H3YjFUnZobB9vO8STRHzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724502961; c=relaxed/simple;
	bh=h/AVwOOa+wkeVq5NBCCr+y97h8AqsG42xd78HYAsD1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTSsylS10uWl7L9Z7DvYIxBITkwhfZtcWMPnocY9duxQh9BaYc4GsoXDJ/Ae20dsOSsTeGmw+SE/vhHIw04MkGVXXXegy/EnbFZKhAiPkJc8Gf6mzMf7R4Upk+HQWizFoPBd52KyQAQJO9zlColsATnIWttF11X+tzlStvTBbiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hrBjyHnU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724502959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BzkYZKxJlvXKPDic4xVBRA/G3kUgKQQg73HVuDm1tk=;
	b=hrBjyHnU765JCig0+aqrvPHydLSkoBaOLQ5lemIjv9n6hub8QrUj9b3bwuaBal7mZC5QxA
	/4tgI1qxbRAFpfE6v0j30qen0M9C6xR0OCefBeSVBQn5h+uLM0M4ZMkgJTdrJyF7XNz61w
	RXo0/gI3m7go/0Vb6o6NlOh7XiWEnQc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-dJPygNdGP9mQrfppgvohLw-1; Sat, 24 Aug 2024 08:35:57 -0400
X-MC-Unique: dJPygNdGP9mQrfppgvohLw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-53351fe4b2dso2402400e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 05:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724502956; x=1725107756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8BzkYZKxJlvXKPDic4xVBRA/G3kUgKQQg73HVuDm1tk=;
        b=S6/7ttWhnyeYSoIMf2YxpYCkW78T8KCp8MbjE6/h1VvMqtcT0K4NMksetMLDOZF9Gl
         IBYlnoAjC1FdHM9xu4ntxP80rmUxFt5ep40M3K5OcwlOVWSGVigHkaD7Qo5GnE38B03O
         HJy+yThHiWzMd1hpim40x+Hy07niDkl/TRYZlWIrkTWfyhrdNNkzT56kDv7+i2C/6Uf3
         qxXqWiajdrcviAOk+hXB8GmD2lIMEqcOr4qkhjrFzGicVXIFBYVx63LOkRGl7MVTa07F
         N6ojdnCjhus/2rQBU90UUBMaLSe4jk3hFwnrnM6jZcECO6sfBr+DODz70I71fwA1qJOl
         VJog==
X-Gm-Message-State: AOJu0YygJus3PI1m0+vOKamk8eoRlDu73dpAVxYdyNgr1+ef9VCOHlDw
	4N/3I94sbN1hHrE5EThE4xP4J/R7/7IrKbF7eidzravYx9tgjTgsrD2XBx/3xJB5wnlkIXAAmXL
	u2SIdP/heq0fpT3T86lRJW6LDmM0Oy8rvhvTD1oeMbvsPfZJMjp62aaS0xee+Og==
X-Received: by 2002:a05:6512:318e:b0:52e:9f43:c13f with SMTP id 2adb3069b0e04-534387554dcmr3626170e87.7.1724502955732;
        Sat, 24 Aug 2024 05:35:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnB2bemwTk8sAAKQN97TpDbkTFLx1A7SDbpco/o9kpBl2yZITr7eAI1fDeUg6Mm5V4Mu8KiA==
X-Received: by 2002:a05:6512:318e:b0:52e:9f43:c13f with SMTP id 2adb3069b0e04-534387554dcmr3626161e87.7.1724502955142;
        Sat, 24 Aug 2024 05:35:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f436b97sm397224266b.101.2024.08.24.05.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 05:35:54 -0700 (PDT)
Message-ID: <6ff3c319-2b8d-43a7-9cc1-2ad1e142cb2b@redhat.com>
Date: Sat, 24 Aug 2024 14:35:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
To: Andres Salomon <dilinger@queued.net>
Cc: linux-kernel@vger.kernel.org, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, platform-driver-x86@vger.kernel.org,
 Matthew Garrett <mjg59@srcf.ucam.org>, Sebastian Reichel <sre@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
References: <20240815192848.3489d3e1@5400>
 <380016cc-6ccc-463f-8c66-f2989cd6ef42@redhat.com>
 <20240823223950.7f952489@5400>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240823223950.7f952489@5400>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8/24/24 4:39 AM, Andres Salomon wrote:
> On Mon, 19 Aug 2024 15:59:45 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Hi,
>>
>> On 8/16/24 1:28 AM, Andres Salomon wrote:
> [...]
>>
>>> ---
>>> Changes in v3:
>>>     - switch tokenid and class types
>>>     - be stricter with results from both userspace and BIOS
>>>     - no longer allow failed BIOS reads
>>>     - rename/move dell_send_request_by_token_loc, and add helper function
>>>     - only allow registration for BAT0
>>>     - rename charge_type modes to match power_supply names
>>> Changes in v2, based on extensive feedback from Pali Rohár <pali@kernel.org>:
>>>     - code style changes
>>>     - change battery write API to use token->value instead of passed value
>>>     - stop caching current mode, instead querying SMBIOS as needed
>>>     - drop the separate list of charging modes enum
>>>     - rework the list of charging mode strings
>>>     - query SMBIOS for supported charging modes
>>>     - split dell_battery_custom_set() up
>>> ---
>>>  .../ABI/testing/sysfs-class-power-dell        |  33 ++
>>>  drivers/platform/x86/dell/Kconfig             |   1 +
>>>  drivers/platform/x86/dell/dell-laptop.c       | 316 ++++++++++++++++++
>>>  drivers/platform/x86/dell/dell-smbios.h       |   7 +
>>>  4 files changed, 357 insertions(+)
>>>  create mode 100644 Documentation/ABI/testing/sysfs-class-power-dell
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-class-power-dell b/Documentation/ABI/testing/sysfs-class-power-dell
>>> new file mode 100644
>>> index 000000000000..d8c542177558
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-class-power-dell
>>> @@ -0,0 +1,33 @@
>>> +What:		/sys/class/power_supply/<supply_name>/charge_type
>>> +Date:		August 2024
>>> +KernelVersion:	6.12
>>> +Contact:	linux-pm@vger.kernel.org
>>> +Description:
>>> +		Select the charging algorithm to use for the (primary)
>>> +		battery.
>>> +
>>> +		Standard:
>>> +			Fully charge the battery at a moderate rate.
>>> +		Fast:
>>> +			Quickly charge the battery using fast-charge
>>> +			technology. This is harder on the battery than
>>> +			standard charging and may lower its lifespan.
>>> +			The Dell BIOS calls this ExpressCharge™.
>>> +		Trickle:
>>> +			Users who primarily operate the system while
>>> +			plugged into an external power source can extend
>>> +			battery life with this mode. The Dell BIOS calls
>>> +			this "Primarily AC Use".
>>> +		Adaptive:
>>> +			Automatically optimize battery charge rate based
>>> +			on typical usage pattern.
>>> +		Custom:
>>> +			Use the charge_control_* properties to determine
>>> +			when to start and stop charging. Advanced users
>>> +			can use this to drastically extend battery life.
>>> +
>>> +		Access: Read, Write
>>> +		Valid values:
>>> +			      "Standard", "Fast", "Trickle",
>>> +			      "Adaptive", "Custom"
>>> +  
>>
>> As the kernel test robot reports:
>>
>> Warning: /sys/class/power_supply/<supply_name>/charge_type is defined 2 times:  ./Documentation/ABI/testing/sysfs-class-power-dell:0  ./Documentation/ABI/testing/sysfs-class-power:375
>>
>> So please drop this. What you could do is instead submit (as a separate) patch
>> an update to Documentation/ABI/testing/sysfs-class-power:375 to use your IMHO
>> more readable version.
>>
>> And when doing so I think it would best to replace "The Dell BIOS calls this ..."
>> with "In vendor tooling this may also be called ...".
>>
>>
> 
> Is this what you had in mind? I don't see many users of charge_type, and
> I'm not sure whether the assumptions I'm making there are correct.
> 
> https://lore.kernel.org/lkml/20240820041942.30ed42f3@5400/

Yes that is what I head in mind, thank you for doing this.

I'll try to review that patch soon-ish.

I'll review and likely merge your new v4 "Add knobs" patch on Monday.

Regards,

Hans




