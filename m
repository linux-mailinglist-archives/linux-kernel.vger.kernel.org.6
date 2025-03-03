Return-Path: <linux-kernel+bounces-541848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C73A4C258
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BF03A6C15
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA732116EE;
	Mon,  3 Mar 2025 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dK+EbV5x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF3386347
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009721; cv=none; b=a6viwNi8dloQc7qDcQIO/A2J0h+W7sfkfIXr0icbqdc7TqR6XqTG4CB75EdEU2rqUJUHu1xpbHztWmVlzpvH0kUjGPDcb9wpBKRlzZ0bpSqmVLeDnsw4SDliybxTjG8mHLHyqlmrYE15uxYc760gZBCkSlyWk04xqpcCiagb3o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009721; c=relaxed/simple;
	bh=9k8kfmXbty2g+zkGIx13eHI7HVzj/PQjdYXaZ0KjHFc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DfJepY5kvrQBhOkp/g0kSmBLCHYV6Y9hXD0nIlcJO2ztPvLpS4a6wtWg7nej1Q+qowDvzEt2umVmeBvPqBJKKusEFjW97VIPFO3mqOYcpjKvEol9Lf9EYhIAGOFuzCAQEY6MKbVM6vsv03qISwgGh/wb/KXFAHm16z1nD5sYcLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dK+EbV5x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741009718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GKsU49671q4SKyRi2ZaD3Akld1QPUJnrevJ34/MB4U0=;
	b=dK+EbV5xS7J4j5VoRdIYcrXfGQBq//j0Fq4i8JVjEemexL0Uh6dWWpDBN21r42LqkjZVAn
	eQAagM0de10ErZlHUngN5x3sjFxosD7B/mmk7mLI3FopFszF8fR8leYEFlF+KTzcaELUkQ
	C29QhW07qpuf5/GW5cxHUL5/22YQog4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-BjaGv475MwSOvSwWqO29Dw-1; Mon, 03 Mar 2025 08:48:37 -0500
X-MC-Unique: BjaGv475MwSOvSwWqO29Dw-1
X-Mimecast-MFC-AGG-ID: BjaGv475MwSOvSwWqO29Dw_1741009716
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43988b9ecfbso20445395e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 05:48:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741009716; x=1741614516;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GKsU49671q4SKyRi2ZaD3Akld1QPUJnrevJ34/MB4U0=;
        b=YIYZI0Vf0VCZ2L28gA85tVl0PPRFjopC82jDzTzDtxS4jjyBEuUdmOioAcQXLdpFli
         loZj7Md5hUtCbvJ3wPHFRgLiuD9O2D3Gtzf0p4OQrEESisDvWo6ODiUQAR117e5fvUSZ
         yDnIGzrdF4JLi8QZMqnK8ceneStW+tyA+t+RSvLATruwZbHokDMEpcQR6eLTBjpuyrol
         AE9R7EWDRJ9KrTD5yAz4dwt/y0wIjwmxpceuLXnngZ7zX1Z+RadPjPyZ6j1T1iLWwsjl
         HYdV7MGyNibxk9zIHeWTHoX322m7LBleDJmbRhr06nqXOPJV6EDnMXcUpAXjT5GNnbUb
         t0Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWyBFJvJ6YRuGj2/Y/8iu6kEfBIsAESu55lL4gtVNmRlxP+5qFiUVY6f1RBA2+p4Fps25xOnv+CSfAzFDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ6+xTqYPinySKiNosBh3T/baDBrmNgD63ILHkB7rLfA982Hss
	gaV+Z31qpVhbHqxTRAdVucZoRKa5MM+tdDbplAfCZPnldFTuJqEnkCOHZZNUxBpaiY4JSU2/86P
	ztxNO8cCuh0T1uuEVQ2wod7dpUcK20kjIexy9geCDrCvGOfU3sOdmnqGQt7UwXA==
X-Gm-Gg: ASbGncsClvvV6zhApPB/dox1nGToKpkQHDmDxJUsuUbvl+VYARYIkfYIUjBqSXS0NFW
	KIR3CHUqa/nYTKhRykMDv3ONACpCTu8FJquATdmn+kE3aOq6r2SmblP4wJ/jq5KJ5kig2WcWlOc
	PNFkTwwphHS7lOh1JGrolxQNpisSLKnZFQpKBkima4xi3OFQQxswPLsljKQUX5qtcWhgBwx/kMB
	0K9QpDQUiX4erdtHrktb59+il5AkFwk4HwJ1srERBeyM77HbRX/xUyUAMqTen8CAwbfSFe4JzdU
	Au9XG2V48T2quebRelrUx1CXnJVWcr1GB+tG/IwX7ONYruFOVqqqIo2dqXVItbzjG3Y8YgaMs8g
	878V9MGjltHnt15pSQfXy8sqUTYnOe234DSETk4wnNiY=
X-Received: by 2002:a05:600c:4687:b0:439:7b5e:820a with SMTP id 5b1f17b1804b1-43ba66e1baamr123585395e9.11.1741009716215;
        Mon, 03 Mar 2025 05:48:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEy2B46IodzeN85QJEJr6oKn8O5/2gGcOPMa5rRLYHzWgGHFA606oRrul3IQBuFprygxAlWog==
X-Received: by 2002:a05:600c:4687:b0:439:7b5e:820a with SMTP id 5b1f17b1804b1-43ba66e1baamr123585135e9.11.1741009715874;
        Mon, 03 Mar 2025 05:48:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb? (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73703f83sm162538005e9.13.2025.03.03.05.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 05:48:35 -0800 (PST)
Message-ID: <6bcf390b-3a10-4622-b573-de88e69ed1a6@redhat.com>
Date: Mon, 3 Mar 2025 14:48:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/page_alloc: Add lockdep assertion for pageblock
 type change
From: David Hildenbrand <david@redhat.com>
To: Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250303-pageblock-lockdep-v2-1-3fc0c37e9532@google.com>
 <4d0f0bca-3096-4fb4-9e8b-d4dcdf7eeb92@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4d0f0bca-3096-4fb4-9e8b-d4dcdf7eeb92@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.03.25 14:11, David Hildenbrand wrote:
> On 03.03.25 13:13, Brendan Jackman wrote:
>> Since the migratetype hygiene patches [0], the locking here is
>> a bit more formalised.
>>
>> For other stuff, it's pretty obvious that it would be protected by the
>> zone lock. But it didn't seem totally self-evident that it should
>> protect the pageblock type. So it seems particularly helpful to have it
>> written in the code.
> 
> [...]
> 
>> +
>>    u64 max_mem_size = U64_MAX;
>>    
>>    /* add this memory to iomem resource */
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 579789600a3c7bfb7b0d847d51af702a9d4b139a..1ed21179676d05c66f77f9dbebf88e36bbe402e9 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -417,6 +417,10 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
>>    
>>    void set_pageblock_migratetype(struct page *page, int migratetype)
>>    {
>> +	lockdep_assert_once(system_state == SYSTEM_BOOTING ||
>> +		in_mem_hotplug() ||
>> +		lockdep_is_held(&page_zone(page)->lock));
>> +
> 
> I assume the call chain on the memory hotplug path is mostly
> 
> move_pfn_range_to_zone()->memmap_init_range()->set_pageblock_migratetype()
> 
> either when onlining a memory block, or from pagemap_range() while
> holding the hotplug lock.
> 
> But there is also the
> memmap_init_zone_device()->memmap_init_compound()->__init_zone_device_page()->set_pageblock_migratetype()
> one, called from pagemap_range() *without* holding the hotplug lock, and
> you assertion would be missing that.

Heh, and I even ran into that right now by accident during boot:

[    9.790696][    T1] WARNING: CPU: 3 PID: 1 at mm/page_alloc.c:420 set_pageblock_migratetype+0xb3/0xf0
[    9.792672][    T1] Modules linked in:
[    9.793496][    T1] CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc3-00349-geaddff2b220c #164
[    9.795511][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
[    9.797471][    T1] RIP: 0010:set_pageblock_migratetype+0xb3/0xf0
[    9.798794][    T1] Code: 2c c5 c0 0b 6d 91 73 43 4d 69 e4 40 07 00 00 be ff ff ff ff 4b 8d bc 25 18 06 00 00 e8 46 09 1b 04 85 c0 0f 85 71 ff ff ff 90 <0f> 0b 90 e9 68 ff ff ff 31 db e9 74 ff ff ff 48 c7 c6 58 4a f7 86
[    9.802906][    T1] RSP: 0018:ffffc9000013bcc0 EFLAGS: 00010246
[    9.804198][    T1] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000001
[    9.805860][    T1] RDX: 0000000000000046 RSI: ffffffff8725b542 RDI: ffffffff872bd087
[    9.807528][    T1] RBP: ffffeaffffc00000 R08: 0000000000000005 R09: 0000000000000000
[    9.809186][    T1] R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000001d00
[    9.810871][    T1] R13: ffff88847fffa540 R14: 0000000000000000 R15: 0000000000000000
[    9.812526][    T1] FS:  0000000000000000(0000) GS:ffff88846fcc0000(0000) knlGS:0000000000000000
[    9.814388][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.815751][    T1] CR2: 0000000000000000 CR3: 00000000076d8000 CR4: 0000000000750ef0
[    9.817410][    T1] PKRU: 55555554
[    9.818143][    T1] Call Trace:
[    9.818821][    T1]  <TASK>
[    9.819428][    T1]  ? set_pageblock_migratetype+0xb3/0xf0
[    9.820639][    T1]  ? __warn.cold+0x110/0x210
[    9.821618][    T1]  ? set_pageblock_migratetype+0xb3/0xf0
[    9.822809][    T1]  ? report_bug+0x1b9/0x320
[    9.823762][    T1]  ? handle_bug+0x54/0x90
[    9.824675][    T1]  ? exc_invalid_op+0x17/0x50
[    9.825659][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    9.826727][    T1]  ? set_pageblock_migratetype+0xb3/0xf0
[    9.827914][    T1]  __init_zone_device_page.constprop.0+0x20c/0x240
[    9.829293][    T1]  memmap_init_zone_device+0x191/0x330
[    9.830478][    T1]  memremap_pages+0x4b7/0xc80
[    9.831485][    T1]  dmirror_allocate_chunk+0x12b/0x400
[    9.832628][    T1]  hmm_dmirror_init+0x18f/0x260
[    9.833657][    T1]  ? __pfx_hmm_dmirror_init+0x10/0x10
[    9.834798][    T1]  do_one_initcall+0xa5/0x490
[    9.835789][    T1]  kernel_init_freeable+0x3b4/0x410
[    9.836897][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.837938][    T1]  kernel_init+0x1b/0x1d0
[    9.838856][    T1]  ret_from_fork+0x48/0x60
[    9.839796][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.840864][    T1]  ret_from_fork_asm+0x1a/0x30
[    9.841878][    T1]  </TASK>


-- 
Cheers,

David / dhildenb


