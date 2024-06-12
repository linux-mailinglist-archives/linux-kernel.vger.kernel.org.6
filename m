Return-Path: <linux-kernel+bounces-211327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A70C905013
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A626C1F2157A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF08C16E893;
	Wed, 12 Jun 2024 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+WKDUgC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06A16E875
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718186936; cv=none; b=DWKgny3+v9fJ04YbRDOJT5nCUzm3oOJ8iqI6fGQPCxvQg/kOXXOXM+ixfBf3jphYl5erPxLVZAQ00jB0jPFRsNAXW5YftA6Y3Jga2nFnIauYq/o1RTgoQDIZ2idRTg3iz8P1bD/GxLmS/GQKnYJ0jUJ6pL52oi+NJQAs6RUmMBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718186936; c=relaxed/simple;
	bh=pw7HgWQK4sD0qp5qxOO2K9LVDQueOS/Y695OIEk7J9I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MPyv0hVq/6J1rNgh13aOzQZ2+/geLnvI2QJo/THCndo6B1FKqTQeOrzlBmDq8rAj5fBhYsJi+7vraUrVsypj6XPpINyUKWYxzTd5lSNtX3R3DPZxkT6Sod3sz41j2pe2pjtm+e8kXVOdTQe/yara/JeyrDHSqUqgYBe3kIgh9ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+WKDUgC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718186933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LLOfKzS9Is4M6RNWbUE4sMUvQ49ghZMG/yPmnPnTpYY=;
	b=Q+WKDUgCEpp/RquVuRoyz0/6JOUDYAWAzL5wLxB+KfLtbz/nwT4nCC6j0jGG910JIXe8Un
	eowQ89H0gDLzLyatVXBeC0WhQmVGPv4X4xp3ZXlxeCHXRPBHqFneLMlqxlN1NpiSppC4Nf
	AG9MyVb7zyycuVPi3Bs+nQhGsDW71cc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-XWPdUpqyMYWa_xP0kxbH1A-1; Wed, 12 Jun 2024 06:08:52 -0400
X-MC-Unique: XWPdUpqyMYWa_xP0kxbH1A-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6def6e9ef2so55534466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718186931; x=1718791731;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLOfKzS9Is4M6RNWbUE4sMUvQ49ghZMG/yPmnPnTpYY=;
        b=ePh9MEHX1hevmpZ1lB0Nbu6i1DaD6Gblc9a27vcudO0EogExKlcJmszW461DVKb9R3
         bk0uvhX9X50XDGpcGzPa3+zaTE6NN10vrW6zWr8mrF8I6XKpEiFw++YfDXs58Ly0Xwos
         uKRynjsorI3Qit5aoIVo67fI4gT9HsrBeWaQrFCz87i1FgFYZAWvvNEUQByt7ndBZ+XA
         7+iQIn5GsYNBQvxbFZ3IGxThl1MHbe4dHslIxxFIzSTXWZqG7MgITgm9XUQH0kP2/lxj
         7Sfemy4929l2upv/ess6LrcwKoeW3Kfn7RgKTk1OlpnMdPvy5pA808ZxG5GdsuBskUnX
         0PUA==
X-Gm-Message-State: AOJu0YxwafWl0tkt+Pl4WOm0AuH51W7HNn8UalTvKMqIotBWIj32KDPz
	rLqy0XezTN/Qz6sVTPtV2Rmpizo9kFg7JpieVYDDIfnxMUGFr/O+TIj9DOO4ULznzYomQhY9OGW
	oB5STQkCJvrgDhg9IoQa7gWg414u+KEf19iv1A5ruI4f7niWWZrHeh1pTE4/W7g==
X-Received: by 2002:a17:906:64d:b0:a6e:4e0:8a56 with SMTP id a640c23a62f3a-a6f34dddf97mr345486666b.32.1718186931110;
        Wed, 12 Jun 2024 03:08:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDhKNb1woactSSXmyEjuzW+ovpxvmll3Rtvi6rex9IVe/7mfN7yKK6wLzv4CqXyzqlxcF2eg==
X-Received: by 2002:a17:906:64d:b0:a6e:4e0:8a56 with SMTP id a640c23a62f3a-a6f34dddf97mr345485466b.32.1718186930674;
        Wed, 12 Jun 2024 03:08:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0369399csm568681366b.3.2024.06.12.03.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 03:08:50 -0700 (PDT)
Message-ID: <4b387b4d-f778-4891-9f07-df5fc0a093cd@redhat.com>
Date: Wed, 12 Jun 2024 12:08:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port
 nodes
From: Hans de Goede <hdegoede@redhat.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
 Genes Lists <lists@sapience.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, mchehab@kernel.org,
 hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
 wentong.wu@intel.com, linux-media@vger.kernel.org,
 linux-acpi@vger.kernel.org,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <988e48090982c89ce0c906954832fdfb09a1ce34.camel@sapience.com>
 <20240528084413.2624435-1-sakari.ailus@linux.intel.com>
 <a05df025-a0be-49cd-84a9-7d7fb2eeb33e@redhat.com>
 <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/6/24 8:12 PM, Hans de Goede wrote:
> Hi,
> 
> +To: Rafael since this was Cc-ed to linux-acpi but never send
> to Rafael directly.
> 
> Rafael this fixes a crash in 6.10-rc1 for some users and is necessary
> to make the cameras work on the Dell XPS 13 plus 9320 .
> 
> On 5/28/24 7:09 PM, Hans de Goede wrote:
>> Hi Sakari,
>>
>> On 5/28/24 10:44 AM, Sakari Ailus wrote:
>>> Ignore camera related graph port nodes on Dell XPS 9320. They data in BIOS
>>> is buggy, just like it is for Dell XPS 9315. The corresponding software
>>> nodes are created by the ipu-bridge.
>>>
>>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>>> ---
>>> Hi,
>>>
>>> Could you test this and see whether it fixes the warning?
>>>
>>> The camera might work with this change, too.
>>
>> Thank you I just received a Dell XPS 13 plus 9320 myself to use
>> for VSC testing and I can confirm that with this patch 6.10.0-rc1
>> works, including giving a picture with the libcamera software ISP +
>> 3 small libcamera patches.
> 
> I forgot to add:
> 
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I just hit the same problem on another Dell laptop. It seems that
all Dell laptops with IPU6 camera from the Tiger Lake, Alder Lake
and Raptor Lake generations suffer from this problem.

So instead of playing whack a mole with DMI matches we should
simply disable ACPI MIPI DISCO support on all Dell laptops
with those CPUs. I'm preparing a fix for this to replace
the DMI matching now.

Rafael, please drop this patch, my more generic fix will replace it
and backporting will be easier without having the intermediate fix
in the middle.

Regards,

Hans




>>>  drivers/acpi/mipi-disco-img.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
>>> index d05413a0672a..bf9a5cee32ac 100644
>>> --- a/drivers/acpi/mipi-disco-img.c
>>> +++ b/drivers/acpi/mipi-disco-img.c
>>> @@ -732,6 +732,12 @@ static const struct dmi_system_id dmi_ignore_port_nodes[] = {
>>>  			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),
>>>  		},
>>>  	},
>>> +	{
>>> +		.matches = {
>>> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>>> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9320"),
>>> +		},
>>> +	},
>>>  	{ }
>>>  };
>>>  
> 


