Return-Path: <linux-kernel+bounces-347493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F9098D366
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4FB1F21134
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5921CFED0;
	Wed,  2 Oct 2024 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVez/dF5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E448E1CFECB
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872522; cv=none; b=LeF4XglBX22R5z98yOKn5s4Rqqn9wYoAHIEZjtJMrvMfbnbcQoMW6LPyQdSJgio4CqpvQn/P8NGCs2LuIydfE1Zkvg2k8z8px+O0yLNXIW/XaHrw7x+wa42/p7PFK5j1w5QL8LfNf1pbKkrYSpJx77jBNQi9nqb2OaMj3spHMk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872522; c=relaxed/simple;
	bh=/w0+6cd+hbeMW+ipGN774Tj4cMLGVHebRzaAYr+UC/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJE6we7+oJO357UkIrEbPg/DnQCDHMaFtIWC8lFIHmxwn+1lfqtNJ8OCUunZkvFqBZtfj2Xfl+Pkgi6gBNt/wklLWIbCVDB6eGie/sSDsG9QXiY9FpCB6j7R9thtaqCo+hHl2HrP3YLhK0YGkGv5nHbggoHgkJDZbiYyXcy5e5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cVez/dF5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727872519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PSEsK0rh/QeUS/t8G2KMmdNRmVd+6fD0oOLOmeE69U0=;
	b=cVez/dF57vXH/Nr0rxzqSxsF1XTlEtMJayFw6B7XZWnop7YxV178grtMjHoiphqHRX8aBJ
	WKsguXSmnYG56qyhyE0wurs7V3/cntUP8CICVDER01Py3Hhu7ojt8YbZSufyXfPFY9WEKc
	7uV3tP8dY1OdKAU0peoo5zYEbfAe298=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-qse5tBWwM_a5PXYgYKbrfQ-1; Wed, 02 Oct 2024 08:35:16 -0400
X-MC-Unique: qse5tBWwM_a5PXYgYKbrfQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8d10954458so509879766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 05:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727872515; x=1728477315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSEsK0rh/QeUS/t8G2KMmdNRmVd+6fD0oOLOmeE69U0=;
        b=pScBhDBsWcSjiLCMKPhOU1j4KyAb37nT6v/XUFk4E0BwNckneATHIc3v0K+RHLa4CN
         QOzg3Cf3In3ooIbrvrOt4EZb9CCy9G1SqMOaURFXmu9fuhIgKHmJoafzIpezF1gZnGSl
         /RW+BA5hMiNx33yQMmYMGrsBQVCj3gCE8cXdyEifZYByr1Dr0aHxym/6b9HwsEU7KBv4
         lrVlvWrcxBUebNrfUWwamJhayRiRo4Nd2Q8kZuK54OpvN810k+cS5KoMGiNsw+V1aiuV
         WB1TYRSKtvIMbCpL/3qu2crUeIlvw7fi6bHaqD9QgOQgNOmzIG6+03WdenHoIW7meBbK
         kjEg==
X-Forwarded-Encrypted: i=1; AJvYcCXQkscQE9D2tubSNQ0d5EgmiwFGYC4cHh79OI1Rz2GpDNxj7hRFBQK2dIXyaeChIjnodgGwi/ZsId3bGuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPWRFvxd4cIRNQhAya+q3sn86uu1lOthopyzcj3kpCEOqElKAS
	P8jXtAM/XZmOzRoe16D2JVKcAbENDHM0t36wh3Adc64hnXYpGPZ1J7K1NSPjASt3INHPdj9QmvZ
	0Fi5oYcZsU4tLp2ItxjIddMqW8QfdN9hZ2xkYXQcRLuf28gsxCzL/Warfz2NoVg==
X-Received: by 2002:a17:907:1ca0:b0:a8d:35cf:85f6 with SMTP id a640c23a62f3a-a98f838bdf4mr271741966b.57.1727872515334;
        Wed, 02 Oct 2024 05:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAcDBl8oud/YVHjO5L2jwtH7Aoi6ik2xgh7z9rYEDo73FiEesYboUK8tdayUNjiZIFRJpwow==
X-Received: by 2002:a17:907:1ca0:b0:a8d:35cf:85f6 with SMTP id a640c23a62f3a-a98f838bdf4mr271738166b.57.1727872514888;
        Wed, 02 Oct 2024 05:35:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27da39bsm859892066b.90.2024.10.02.05.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 05:35:13 -0700 (PDT)
Message-ID: <ab75a39e-94e2-4b1a-9406-e05ebc816b03@redhat.com>
Date: Wed, 2 Oct 2024 14:35:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 2/3] ACPI: battery: Fix possible crash when
 unregistering a battery hook
To: "Rafael J. Wysocki" <rafael@kernel.org>, Armin Wolf <W_Armin@gmx.de>
Cc: pali@kernel.org, dilinger@queued.net, lenb@kernel.org,
 ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241001212835.341788-1-W_Armin@gmx.de>
 <20241001212835.341788-3-W_Armin@gmx.de>
 <CAJZ5v0gSYp5Umo-wsKvQ2Nff7YZ=_3-4bzG3TnKqMpHvxCmR5g@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0gSYp5Umo-wsKvQ2Nff7YZ=_3-4bzG3TnKqMpHvxCmR5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 2-Oct-24 2:08 PM, Rafael J. Wysocki wrote:
> On Tue, Oct 1, 2024 at 11:28 PM Armin Wolf <W_Armin@gmx.de> wrote:
>>
>> When a battery hook returns an error when adding a new battery, then
>> the battery hook is automatically unregistered.
>> However the battery hook provider cannot know that, so it will later
>> call battery_hook_unregister() on the already unregistered battery
>> hook, resulting in a crash.
>>
>> Fix this by using the list head to mark already unregistered battery
>> hooks as already being unregistered so that they can be ignored by
>> battery_hook_unregister().
>>
>> Fixes: fa93854f7a7e ("battery: Add the battery hooking API")
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Hans, are you going to take this series or should I apply it?

AFAICT the patches don't really depend on each other, so my plan
was that you take patches 1-2 and I take patch 3 as a fix for
6.12-rc# .

Does that work for you ?

Regards,

Hans




> 
>> ---
>>  drivers/acpi/battery.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>> index dda59ee5a11e..1c45ff6dbb83 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -715,7 +715,7 @@ static void battery_hook_unregister_unlocked(struct acpi_battery_hook *hook)
>>                 if (!hook->remove_battery(battery->bat, hook))
>>                         power_supply_changed(battery->bat);
>>         }
>> -       list_del(&hook->list);
>> +       list_del_init(&hook->list);
>>
>>         pr_info("extension unregistered: %s\n", hook->name);
>>  }
>> @@ -723,7 +723,14 @@ static void battery_hook_unregister_unlocked(struct acpi_battery_hook *hook)
>>  void battery_hook_unregister(struct acpi_battery_hook *hook)
>>  {
>>         mutex_lock(&hook_mutex);
>> -       battery_hook_unregister_unlocked(hook);
>> +       /*
>> +        * Ignore already unregistered battery hooks. This might happen
>> +        * if a battery hook was previously unloaded due to an error when
>> +        * adding a new battery.
>> +        */
>> +       if (!list_empty(&hook->list))
>> +               battery_hook_unregister_unlocked(hook);
>> +
>>         mutex_unlock(&hook_mutex);
>>  }
>>  EXPORT_SYMBOL_GPL(battery_hook_unregister);
>> @@ -733,7 +740,6 @@ void battery_hook_register(struct acpi_battery_hook *hook)
>>         struct acpi_battery *battery;
>>
>>         mutex_lock(&hook_mutex);
>> -       INIT_LIST_HEAD(&hook->list);
>>         list_add(&hook->list, &battery_hook_list);
>>         /*
>>          * Now that the driver is registered, we need
>> --
>> 2.39.5
>>
> 


