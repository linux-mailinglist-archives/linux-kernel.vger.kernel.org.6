Return-Path: <linux-kernel+bounces-412974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B2C9D11EA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747641F21E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F191B6D08;
	Mon, 18 Nov 2024 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnTouaDS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EF41A0AF7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936590; cv=none; b=sk/Qd5UB6FCmzsncLjuw0rJreMsNxzuoE6rMRGilWX/O8QmpXrxoa6Arkbx7qVkLowKCSB+qGyZa8z35ShvwpGDxO7KsCyy5NZS1miaFbnx1kXrBkZDS3lPYby4P+twtIBjFX9YBJanxRu/7eLlcq4Rg4imC7M6xwWbY/S0hR+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936590; c=relaxed/simple;
	bh=+ATc25nTcRqQWvIHi4WrHNVE1qE+wYtYKwroAeMW0vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gcq4ldGRX3G7hlH7Q6q1PQ+6IjvuKKmMMQNnMHhOf3fTRWUMjcgQ+PQLJ1zUd78H1KFEumdb+dT6zs2F4Fb+vaIdYU9VMVPHq8+sCCwpo89HhVhFxy/MRzgy3mU2e+P6tJ9If8Q84DRKdjlLcVrrVqOz0VrqbQ/F1eog3FTqJYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dnTouaDS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731936587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YgTfhkWInfo7BA9Bk1mOwX2I6nR7aQ4KuB/2jbVMMvk=;
	b=dnTouaDSB7FYJaAwFfnC6/f0Y2LSR57kjX0hYUZdidEbxhkj1HGzvX7QOnvB9yRll502TN
	TALYjXr4YXaIe7HP+wyu2zdKkTMF44nrQabAPYcZOjgUvgUPjRGOfzOKrcjyXQnNDaJVXf
	BLwzi63GRaw9yt0YL9wyF4JK24p8iHM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-ffnhoUj9N4y_q1ZJCLZUDw-1; Mon, 18 Nov 2024 08:29:45 -0500
X-MC-Unique: ffnhoUj9N4y_q1ZJCLZUDw-1
X-Mimecast-MFC-AGG-ID: ffnhoUj9N4y_q1ZJCLZUDw
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2fb652f40f1so7597401fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731936584; x=1732541384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgTfhkWInfo7BA9Bk1mOwX2I6nR7aQ4KuB/2jbVMMvk=;
        b=sRzXhecvoKVZAtNjVfO18u/EbZeZE5rWguwyLdrx0krmUq+Q0olspfdEMzm4NcDEg4
         S/IbHbKd01JgtUkfYWpu9dqkn9H4dHUrUjuPnLb1yWWhuS/eCpNj60l3qpJjlC6bGYgi
         CwyL8p7M0D+4V9cB1bwG7OvMEJ66NNzvst711uVB6RuqxjK+MurNdMV+bH/+a/Z/8aWy
         OtSdhItYqcJvbHI4CRZcgtAvVB7zeaYEWSyWc3b1/sCRotEF4tpxIuHt6q3GXMSs6xlh
         lJ616/2p+xj0hjOHImf42xhr/i6Pnb2xyJGB+XT8NL//OOk4vYcSHU3zZuklp+yKYwDP
         VKtw==
X-Forwarded-Encrypted: i=1; AJvYcCX9S3EQFcqX1G/vYxBqnjqFIunCQEQ0KSS5UbJxZN+RSZqGb3lLwKtmwtGF3n/nuaED0VIXzczgRTH06Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6dB4qmx78mUIfBDYC124Rovc1tP1lyQcAJ1Kpd165mwz4PaYM
	vAti2/v51SEwqyutHYGPZc6pvYWWeTNzfRcm9MxGthQbK9sT2mz73Gd8lzN42tpbZJXhdTVsT8D
	ALiYZaJwsUdvdEWZ2Lpb2aSzu6n6QFxo/+n8grCSpKHe8PBQXZXt+lTfBgPP5eQ==
X-Received: by 2002:a2e:a984:0:b0:2fa:cac0:2a14 with SMTP id 38308e7fff4ca-2ff6064e137mr46558441fa.11.1731936583833;
        Mon, 18 Nov 2024 05:29:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGa+34wsHAFBsJZzfxM2Wh06XmyiSBcuGma8CjQc7vbKKZzuRy4QbLnz8JDDIxPxw5gxyewkw==
X-Received: by 2002:a2e:a984:0:b0:2fa:cac0:2a14 with SMTP id 38308e7fff4ca-2ff6064e137mr46558311fa.11.1731936583268;
        Mon, 18 Nov 2024 05:29:43 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfaa333720sm2518195a12.61.2024.11.18.05.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 05:29:42 -0800 (PST)
Message-ID: <13e47dee-848f-44b5-bcea-2216685069c7@redhat.com>
Date: Mon, 18 Nov 2024 14:29:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?B?SWxwbyBK77+9cnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 Klara Modin <klarasmodin@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danil Rybakov <danilrybakov249@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
References: <ZzTI+biIUTvFT6NC@goliath>
 <cd1cedcc-c9b8-4f3c-ac83-4b0c0ba52a82@redhat.com>
 <82ab3d06-40e6-41dd-bb43-9179d4497313@redhat.com>
 <2c828592-dbdd-4cd4-b366-70797d63329d@redhat.com> <ZzTk5kyPa5kUxA+f@goliath>
 <a5bafe87-e8f6-40d9-a5d8-34cf6aa576a4@redhat.com>
 <wxb4hmju5jknxr2bclxlu5gujgmb3vvqwub7jrt4wofllqp7li@pdvthto4jf47>
 <ZzdhTsuRNk1YWg8p@goliath>
 <5qjbimedzeertdham2smgktt54gzdc7yg4dwgiz7eezt2tf5a2@szhhpvzo3uhj>
 <Zzs1rw1YcoEEeW7+@goliath> <ZztABO3TyJBekZRs@smile.fi.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZztABO3TyJBekZRs@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 18-Nov-24 2:24 PM, Andy Shevchenko wrote:
> On Mon, Nov 18, 2024 at 12:40:16PM +0000, Daniel Walker (danielwa) wrote:
>> On Mon, Nov 18, 2024 at 11:30:59AM +0000, Shinichiro Kawasaki wrote:
>>>
>>> Thank you. Here I quote the relevant part of the debug log.
>>>
>>> --------------------------------------------------------------------------------
>>> ...
>>> pci 0000:00:1f.0: [8086:19dc] type 00 class 0x060100 conventional PCI endpoint
>>> pci 0000:00:1f.1: [8086:19dd] type 00 class 0x058000 conventional PCI endpoint ... [A]
>>> pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]
>>> pci 0000:00:1f.2: [8086:19de] type 00 class 0x058000 conventional PCI endpoint
>>> pci 0000:00:1f.2: BAR 0 [mem 0x88c00000-0x88c03fff]
>>> ...
>>> PCI: Using ACPI for IRQ routing
>>> pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]: can't claim; no compatible bridge window ... [B]
>>> hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
>>> ...
>>> NET: Registered PF_XDP protocol family
>>> pci 0000:00:1f.1: BAR 0 [mem 0x280000000-0x280ffffff 64bit]: assigned ... [C]
>>> pci 0000:00:09.0: PCI bridge to [bus 01-06]
>>> ...
>>> PCI: CLS 64 bytes, default 64
>>> p2sb_cache_resources
>>> p2sb_cache_resources: P2SBC_HIDE=0  ... [D]
>>> p2sb_scan_and_cache_devfn: devfn=1f.1
>>> p2sb_scan_and_cache_devfn: 280000000-280ffffff: 140204 ... [E]
>>> PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
>>> ...
>>> --------------------------------------------------------------------------------
>>>
>>> Also, here I list my observations.
>>>
>>> [A] The P2SB device was detected with DEVFN 1f.1, and device id 8086:19dd
>>> [B] Failed to claim its resource
>>> [C] Assigned new resource
>>> [D] p2sb_cache_resource() was called after the new resource assignment.
>>>     P2SBC_HIDE bit is not set.
>>> [E] The new resource was cached. IORESOURCE flags: MEM_64,SIZE_ALIGN,MEM.
>>>
>>> So it was confirmed that the p2sb_cache_resource() was called after the new
>>> resource assignment, but Hans and Andy discuss that this order is not the
>>> problem cause, probably.
>>>
>>> One thing I noticed is that p2sb_bar() call is not recorded in the log. My
>>> understanding is that all device drivers which use P2SB resource shouled call
>>> p2sb_bar(). Daniel, you noted that "a custom gpio device" disappeared. Does its
>>> device driver call p2sb_bar()?
>>
>> No calls to p2sb_bar(). It maybe an Intel GPIO device actually. 0x8086 is Intel's vendor code.
>> I suspect it's something standard on Denverton.
> 
> Are you referring to LPC GPIO?
> 
>>> On the other hand, Daniel noted that,
>>>
>>>   "The vendor and device details for the pci device are 8086:19dd."
>>>
>>> I think 8086:19dd is the P2SB device itself. When p2sb_cache_resource() is
>>> called, pci_stop_and_remove_bus_device() is called for it, so I guess it is
>>> expected the device 8086:19dd disappears. Before applying the commit
>>> 5913320eb0b3, this pci_stop_and_remove_bus_device() call happened when
>>> p2sb_bar() was called. So, my mere guess is that Daniel's system's drivers do
>>> not call p2sb_bar() during the boot process, then the 8086:19dd P2SB device was
>>> still visible after boot.
>>
>> The method I used for the bisect was to check lspci for 19dd. I find it odd that
>> the device which does exist was not in lspci. Also pci_get_device() fails for
>> this device and gpio operations can't happen.
> 
> So, it seems like we have avoid removing PCI devices if the P2SB has been
> unhidden during the cache call. Still wondering if we simply unhide it early
> (if it was hidden) and assume the p2sb device is always present. In this case
> p2sb_bar() will become almost an equivalent to the pci_resource_start().

That would basically open it up for normal PCI drivers to bind to. Which is not
necessarily a problem, but I wonder if we already have such drivers which then
all of a sudden will start binding to it ?

Note that e.g. the GPIO code in lpc_ich.c checks if the GPIO controller is not
ACPI enumerated before calling p2sb_bar(). Unconditionally unhiding the P2SB
would not mean that at least the GPIO part will be enumerated twice, once
through ACPI and once through PCI. I'm not sure if that is a good idea.

My vote would go to fix the problem of the PCI device being removed by
the p2sb.c code when it was not hidden.

Regards,

Hans



