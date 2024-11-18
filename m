Return-Path: <linux-kernel+bounces-412843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333FB9D0FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87DE1F22FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1891990B7;
	Mon, 18 Nov 2024 11:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYZE7b+p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997E418B47E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731930145; cv=none; b=d7qw1XeoIBhkmAAvEtD91n9YLTNMiWdwE/I1oGoSMycaLsuPCZjVzzaQAsPJ1z5j10Di6KZtqSjXjeAc9exnU5Mu1M35MTnTrjaIABRo3eslE181duBbHo84XzZ42Kiczd7AkXwHHKLEpjYpldk0ojI3XhNEN689tFRCZw4ygNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731930145; c=relaxed/simple;
	bh=kL4MpeslyfRBmV9g6AXI4hbJACY+sew4nuH8qpho+YY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUN7h/GtUyo45rVfkH7KNwtpe+uVod8VHkD8hm8fgd3I+RkGhKvFYyxvtOS06scwFoGRxJAs1fiOBhaxaSP5u/E8GuHxkQyU95NaksT+9ZhEqBBXyTNazO5pONqKgiFdXmDF6dDhm9QNcrJ7CuZopkstgCxxtvcbKzOoFLKajYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYZE7b+p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731930142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8tRwaz3uCy/0UHZCgRGVP4q4rbq4bK4vCd+Vx/V32K4=;
	b=cYZE7b+pm/dwARVaLxdI5F5S7AJOs0WrqWS8mHMLgE6MUeUagEBrzDNw8Y7kjg+YdA+m4e
	q5iSiE7vqtn/vxInF1+ApmZLx8E7BKu+kfGbwKIWZeLpAlYHynnaf7avTg83tDcded6qz0
	AjHQMt24kQzXMQPX6H4OzaJ/9si0a5o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-C4Y7nzDUO2OC7ybuIsYvdg-1; Mon, 18 Nov 2024 06:42:21 -0500
X-MC-Unique: C4Y7nzDUO2OC7ybuIsYvdg-1
X-Mimecast-MFC-AGG-ID: C4Y7nzDUO2OC7ybuIsYvdg
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a0710ca24so360328866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 03:42:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731930139; x=1732534939;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tRwaz3uCy/0UHZCgRGVP4q4rbq4bK4vCd+Vx/V32K4=;
        b=JyS81B3H6fHi4dS2/CnUMZT/beoFEgKhsbFG6qFCQdQuhhyAzC4rAkFCJ8P9PzNNKY
         Hp07sNFqfV/T45tyABVZ9ZeSLhyZP4lpNTHoxkKL1Bdi1YCm+fvHai5okRIM8VeDsJT7
         dls63AZNVfB1lD0blgguwK2pOapxP0YN9ej1WO3J8kwhHyeT+/28bvzBSdK57+RXimTl
         IG7OBSZZgUiRMZlGNLkLh6fbxetaQVTPZIUoA/1tq+xshw0Oh5ap2Nkzgrq6c0U7ddGM
         9GWCxD8BTJqk55hfGhQzZMugZjk3wViRPX7NDpezNbM3NMbU6A5owZNR1qn9UqruqYGJ
         Ag3g==
X-Forwarded-Encrypted: i=1; AJvYcCX/Bk7TANMitQ5otSKP+VNLsaDNkU46nNMbzQw+soCWgcPxCquT/B0U/EVXkSUqmzne4gnVtY4Ie5GJqhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0eiQ0rgtq83JSJEJtWmwoiKH7ydeLqXWtENs+QZ8HqAbdXXmR
	HdI6XkUyz2eof0gCux0zBHttQjfVM6Mbcqvf/Giv99tCF98Lc6JGnrAQ12XoM+KoeitbqKG9luZ
	rQPO/m0LfSkBlXpfdFAe/W0YpNSRe1OpavBQVLDFLbfrQOtsbs30XH1QXWdNv2hQ3oIuwgw==
X-Received: by 2002:a17:907:3684:b0:a9a:7f87:904b with SMTP id a640c23a62f3a-aa48344e747mr1241317766b.29.1731930139533;
        Mon, 18 Nov 2024 03:42:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsAa8f7C+HMJk2c6G72yhM0IUTGmcRgmGtHrgaEPPxEV1YCcaU9M5+v2k7a4+bbwZLWLRk2A==
X-Received: by 2002:a17:907:3684:b0:a9a:7f87:904b with SMTP id a640c23a62f3a-aa48344e747mr1241315466b.29.1731930139202;
        Mon, 18 Nov 2024 03:42:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df7e177sm530497266b.84.2024.11.18.03.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 03:42:18 -0800 (PST)
Message-ID: <afdb6114-07ef-4e25-91f0-9fb9be192153@redhat.com>
Date: Mon, 18 Nov 2024 12:42:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <5qjbimedzeertdham2smgktt54gzdc7yg4dwgiz7eezt2tf5a2@szhhpvzo3uhj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shinichiro,

On 18-Nov-24 12:30 PM, Shinichiro Kawasaki wrote:
> On Nov 15, 2024 / 14:57, Daniel Walker (danielwa) wrote:
>> On Fri, Nov 15, 2024 at 11:35:46AM +0000, Shinichiro Kawasaki wrote:
>>> On Nov 13, 2024 / 19:34, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 13-Nov-24 6:41 PM, Daniel Walker (danielwa) wrote:
>>>>> On Wed, Nov 13, 2024 at 06:04:44PM +0100, Hans de Goede wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 13-Nov-24 5:33 PM, Hans de Goede wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 13-Nov-24 5:24 PM, Hans de Goede wrote:
>>> [...]
>>>>>>> It probably has something to do with these 2 messages:
>>>>>>>
>>>>>>> pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]: can't claim; no compatible bridge window
>>>>>>> pci 0000:00:1f.1: BAR 0 [mem 0x280000000-0x280ffffff 64bit]: assigned
>>>>>>>
>>>>>>> I'm guessing that this re-assignment is messing up
>>>>>>> the p2sb BAR caching, after which things go wrong.
>>>>>>
>>>>>> Hmm, but that should be fixed by 2c6370e66076 ("platform/x86: p2sb: Don't init until unassigned resources have been assigned")
>>>>>>
>>>>>> and you are seeing this with 6.12, which has that.
>>>>>>
>>>>>> Can you try adding a pr_info() to the top of p2sb_cache_resources()
>>>>>> with 6.12 and then collec a new dmesg ?
>>>>>>
>>>>>> If that pr_info() is done after the:
>>>>>>
>>>>>> pci 0000:00:1f.1: BAR 0 [mem 0x280000000-0x280ffffff 64bit]: assigned
>>>>>>
>>>>>> message then that does not explain things.
>>>>>>
>>>>>
>>>>> I haven't testing adding a pr_info() but the messages seem to happen in the same
>>>>> order in both working and non-working cases.
>>>>>
>>>>> Does that matter?
>>>>
>>>> The working case does not do the bar caching, we want to know if the
>>>> bar caching in the non working case happens before or after the assignment:
>>>>
>>>> pci 0000:00:1f.1: BAR 0 [mem 0x280000000-0x280ffffff 64bit]: assigned
>>>>
>>>> It should happen after the assignment.
>>>
>>> Hello Daniel,
>>>
>>> It's my sorrow that the change cause this trouble. I have created a debug patch
>>> for the kernel and attached to this e-mail. It adds some pr_info() to answer
>>> the question from Hans. It will also show us a bit more things. Could you try it
>>> on your system? It should apply to v6.12-rcX kernels without conflicts.
>>>
>>
>> Ok.. The dmesg with the patch applied is attached.
> 
> Thank you. Here I quote the relevant part of the debug log.
> 
> --------------------------------------------------------------------------------
> ...
> pci 0000:00:1f.0: [8086:19dc] type 00 class 0x060100 conventional PCI endpoint
> pci 0000:00:1f.1: [8086:19dd] type 00 class 0x058000 conventional PCI endpoint ... [A]
> pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]
> pci 0000:00:1f.2: [8086:19de] type 00 class 0x058000 conventional PCI endpoint
> pci 0000:00:1f.2: BAR 0 [mem 0x88c00000-0x88c03fff]
> ...
> PCI: Using ACPI for IRQ routing
> pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]: can't claim; no compatible bridge window ... [B]
> hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> ...
> NET: Registered PF_XDP protocol family
> pci 0000:00:1f.1: BAR 0 [mem 0x280000000-0x280ffffff 64bit]: assigned ... [C]
> pci 0000:00:09.0: PCI bridge to [bus 01-06]
> ...
> PCI: CLS 64 bytes, default 64
> p2sb_cache_resources
> p2sb_cache_resources: P2SBC_HIDE=0  ... [D]
> p2sb_scan_and_cache_devfn: devfn=1f.1
> p2sb_scan_and_cache_devfn: 280000000-280ffffff: 140204 ... [E]
> PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> ...
> --------------------------------------------------------------------------------
> 
> Also, here I list my observations.
> 
> [A] The P2SB device was detected with DEVFN 1f.1, and device id 8086:19dd
> [B] Failed to claim its resource
> [C] Assigned new resource
> [D] p2sb_cache_resource() was called after the new resource assignment.
>     P2SBC_HIDE bit is not set.
> [E] The new resource was cached. IORESOURCE flags: MEM_64,SIZE_ALIGN,MEM.
> 
> So it was confirmed that the p2sb_cache_resource() was called after the new
> resource assignment, but Hans and Andy discuss that this order is not the
> problem cause, probably.
> 
> One thing I noticed is that p2sb_bar() call is not recorded in the log. My
> understanding is that all device drivers which use P2SB resource shouled call
> p2sb_bar(). Daniel, you noted that "a custom gpio device" disappeared. Does its
> device driver call p2sb_bar()?
> 
> On the other hand, Daniel noted that,
> 
>   "The vendor and device details for the pci device are 8086:19dd."
> 
> I think 8086:19dd is the P2SB device itself. When p2sb_cache_resource() is
> called, pci_stop_and_remove_bus_device() is called for it, so I guess it is
> expected the device 8086:19dd disappears. Before applying the commit
> 5913320eb0b3, this pci_stop_and_remove_bus_device() call happened when
> p2sb_bar() was called. So, my mere guess is that Daniel's system's drivers do
> not call p2sb_bar() during the boot process, then the 8086:19dd P2SB device was
> still visible after boot.

Thank you that is a great analysis.

It sounds to me like calling pci_stop_and_remove_bus_device() on an unhidden
PCI device is the real problem here. And that we were not hitting that before
was more or less luck.

I wonder if we can cache the bar in some other way, or even delay retrieving
it till p2sb_bar() call time in the case when it is not hidden ?

Regards,

Hans



