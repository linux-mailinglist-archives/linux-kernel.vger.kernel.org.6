Return-Path: <linux-kernel+bounces-544712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44381A4E44A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236B4425126
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7684C294EF1;
	Tue,  4 Mar 2025 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CY+my+G0"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF703269B0B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102229; cv=pass; b=fC0VemyazPvw6qhllkFg0aKP1uB2lVh0/dHYQ6ZpW0ZHhKc2aOCFcJhm4ucgM2Z6RLCsNmv8JDs0WOjQbDAl94Au1SyOLFezAMGNypJYegYhnvNuDDOoEe3uPcbjFqac4ycjOkQtJBr3RZ8Oh8EcCkMSuv0lgkJlWAmJ1MJXUt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102229; c=relaxed/simple;
	bh=bAX4nJtptqzVGzhMVWEvU2Vo1a4TfNKeNSRZoHICbTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZD1FaDzzclOZOpNloAWq5XuNPMyDC6fiDAD1x30VoIPjKD0TdugVToZlfLHdqqdQ4GYIkYogU0JiFQH7wRxo5wWf9NAcGwivvzXZLv8XQ+w5XMedQQ40NT/LIOZarVl15fTYQ0BFwk0thh705SzZEwb0BEaVRks5P/+ybDm5V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CY+my+G0; arc=none smtp.client-ip=170.10.133.124; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 1C012408B641
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:30:26 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CY+my+G0
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fjj5ryPzG0PZ
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:29:13 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 1C8F842722; Tue,  4 Mar 2025 18:29:12 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CY+my+G0
X-Envelope-From: <linux-kernel+bounces-541879-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CY+my+G0
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 75EBD41A49
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 17:07:23 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 6E7A33063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 17:07:22 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41CFE7A4DD6
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EE12139CE;
	Mon,  3 Mar 2025 14:07:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F924212B0A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010821; cv=none; b=CXtUIIwxritPDlNJiRvPDmwSR/gW4uP2SHBtUEinpMGZC/T6TZJ1pEqybW/EBNbESpMIgdeoKIIx041OkLfl9O/hLUekujKWCfe0yfP/vCXTzGtca2jPOUXb8vFMbzwQ4iov1nz2DUKhg2lz9xw5cV7hl4xHQc0BPdZ10QM8cIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010821; c=relaxed/simple;
	bh=bAX4nJtptqzVGzhMVWEvU2Vo1a4TfNKeNSRZoHICbTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIIdxWLviHKSlKNVo8UwOqGd+EeilqylzSM4+m5R2h87r8NrqNUW+CbCQKf+ZwG4MKUziZIo0MxcbB3B+05sANVnS+1wDbwJ35XMgNoRNjPaZ0lUUFBqsbQX6x0VyzRPwtl7QAx6gZ8r+8KH9nfDKbP6R5qSHvskDj9uUqWWmGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CY+my+G0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741010818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZbNj59zjmhBNc1+Y3UiFD4MOycUDZRwg2fQUZMSseuI=;
	b=CY+my+G0NPfXP6AVPl13K+f0ez6BPr7+Tg+mPR4ic3DH+Cs90xKBzaweefQDNbbB+DsfVL
	qcSeryRv0gLnbv7qUsrLpP7JguPWk4hpFZOpsdVLPnTxDHPSoHjMnEzKm1QFHeHFroQ693
	tJH8Gw+aE13OvTOizfETa9UVZGGhE8M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-b2FJO2HaPDeAjLFh487bXQ-1; Mon, 03 Mar 2025 09:06:57 -0500
X-MC-Unique: b2FJO2HaPDeAjLFh487bXQ-1
X-Mimecast-MFC-AGG-ID: b2FJO2HaPDeAjLFh487bXQ_1741010816
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so19923085e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 06:06:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741010816; x=1741615616;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZbNj59zjmhBNc1+Y3UiFD4MOycUDZRwg2fQUZMSseuI=;
        b=QyTnKX5k6pYt5XyLt5uHHL/cWhg9ean4gV/eUc991NZqYExgPZLRzsAcIRYfVGlDvm
         ox2h0HmimFOdK3LP9H/Oh7cothj+l1TvM8IMa5KHDXuFFXTSU6xPJIMPGslU2uiZMTOR
         lKNOK6PUVVsJcVl5sh+7Qe6UiY6S+8wgPt0YdHC3QIZSzjmRgD1W8ZCFLAml0kV3BrHQ
         VykyyrUvWA+tUC+PNdrbnLzZzvvVuUwmllEKWO6DrL03DngQdk9Wo7IrvQavkU1ylvjb
         pCy0R5WAJHUPshr83tUKGTPa37hSqZ44orxT6baOvqoJqCyYY04CO7JXirIwualvLgqK
         oQfA==
X-Forwarded-Encrypted: i=1; AJvYcCVB/6RBH1VE4BTcHmmtGEhgo/ayo3qsFeER9xTn3+rbjGCtSpWCIT03F/D+RE9EZWRv6yddQ5YXjwpyd3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDaQLAmPk3fq6VvZGzbZhkl1/cQyX/TGplVbzrO6HMYR16WXcO
	pga6S32G8ZT94II6rGABLqMFHu1UO513l0A/c48tJRKm0dZX45MTxaMUVXeWSdUIBNs3ixhb3sR
	TkcN3oSriw3VuupDJzW4Hc3C4IoabHUnaDywa2lizFXOyUSG05ADrJJM0dUkD7A==
X-Gm-Gg: ASbGnct1cEUGmdpv5b2KXB6cGwy3AQArZvE11x+P/bgmIcORMbVhRNPLCoefa9Dz4sO
	Hkx+Ql7dAKbwDxtZR0hOHLEESQa1av9zGbpaLSoXtderXsUAXJQBcOVfuT7q1pZ3ruKFHfBCr3r
	lVBwNLAdfkTeCiq0uiXSgt/665vn++IVh9SU9YI41ntNKos2Cn0J4X0v+mg/54stadnGdEK0bCE
	JI38O4F2/j7F3TaZPprErQ9a7j+o6tFJF4HKVVbkRoZDgbUmiI9Aro16PWSFqNMCjkx426Fl6mK
	GtAY7Z8wqD20kR7165az8rv4oVbcPFlwNasWeiq5u4Xh6Bp/Z+p+fEvpMfqvBHVpnALFnMi8lKG
	msD1htl+aeXQM4pIa66fLgFWGS//hsv+mgXHN68XBywk=
X-Received: by 2002:a05:6000:2a1:b0:391:865:5aa8 with SMTP id ffacd0b85a97d-39108655d1amr4255876f8f.54.1741010816040;
        Mon, 03 Mar 2025 06:06:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMe6rYNOM1qtAY4H/zcbfK2YO8wdVNhdC2+hSh24NYQSxkXER6ttJ97UQPoaWhG2iYJrqOiw==
X-Received: by 2002:a05:6000:2a1:b0:391:865:5aa8 with SMTP id ffacd0b85a97d-39108655d1amr4255809f8f.54.1741010815529;
        Mon, 03 Mar 2025 06:06:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb? (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a5b96sm14521806f8f.29.2025.03.03.06.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 06:06:55 -0800 (PST)
Message-ID: <3e66875e-a4d5-4802-85b3-f873b0aa3b06@redhat.com>
Date: Mon, 3 Mar 2025 15:06:54 +0100
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/page_alloc: Add lockdep assertion for pageblock
 type change
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250303-pageblock-lockdep-v2-1-3fc0c37e9532@google.com>
 <4d0f0bca-3096-4fb4-9e8b-d4dcdf7eeb92@redhat.com>
 <Z8W0v0LjuyH8ztTQ@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z8W0v0LjuyH8ztTQ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fjj5ryPzG0PZ
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741706955.44911@0A+6PmCLu6ggwd3YWP2WBg
X-ITU-MailScanner-SpamCheck: not spam

On 03.03.25 14:55, Brendan Jackman wrote:
> On Mon, Mar 03, 2025 at 02:11:23PM +0100, David Hildenbrand wrote:
>> On 03.03.25 13:13, Brendan Jackman wrote:
>>> Since the migratetype hygiene patches [0], the locking here is
>>> a bit more formalised.
>>>
>>> For other stuff, it's pretty obvious that it would be protected by the
>>> zone lock. But it didn't seem totally self-evident that it should
>>> protect the pageblock type. So it seems particularly helpful to have it
>>> written in the code.
>>
>> [...]
>>
>>> +
>>>    u64 max_mem_size = U64_MAX;
>>>    /* add this memory to iomem resource */
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 579789600a3c7bfb7b0d847d51af702a9d4b139a..1ed21179676d05c66f77f9dbebf88e36bbe402e9 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -417,6 +417,10 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
>>>    void set_pageblock_migratetype(struct page *page, int migratetype)
>>>    {
>>> +	lockdep_assert_once(system_state == SYSTEM_BOOTING ||
>>> +		in_mem_hotplug() ||
>>> +		lockdep_is_held(&page_zone(page)->lock));
>>> +
>>
>> I assume the call chain on the memory hotplug path is mostly
>>
>> move_pfn_range_to_zone()->memmap_init_range()->set_pageblock_migratetype()
>>
>> either when onlining a memory block, or from pagemap_range() while holding
>> the hotplug lock.
>>
>> But there is also the memmap_init_zone_device()->memmap_init_compound()->__init_zone_device_page()->set_pageblock_migratetype()
>> one, called from pagemap_range() *without* holding the hotplug lock, and you
>> assertion would be missing that.
>>
>> I'm not too happy about that assertion in general.
> 
> Hmm, thanks for pointing that out.
> 
> I guess if we really wanted the assertion the approach would be to
> replace in_mem_hotplug() with some more fine-grained logic about the
> state of the pageblock? But that seems like it would require rework
> that isn't really justified.

I was wondering if we could just grab the zone lock while initializing, then
assert that we either hold that or are in boot.

In move_pfn_range_to_zone() it should likely not cause too much harm, and we
could just grab it around all zone modification stuff.

memmap_init_zone_device() might take longer and be more problematic.

But I am not sure why memmap_init_zone_device() would have to set the
migratetype at all? Because migratetype is a buddy concept, and
ZONE_DEVICE does not interact with the buddy to that degree.

The comment in __init_zone_device_page states:

"Mark the block movable so that blocks are reserved for movable at
startup. This will force kernel allocations to reserve their blocks
rather than leaking throughout the address space during boot when
many long-lived kernel allocations are made."

But that just dates back to 966cf44f637e where we copy-pasted that code.


So I wonder if we could just

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 57933683ed0d1..b95f545846e6e 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1002,19 +1002,11 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
         page->zone_device_data = NULL;
  
         /*
-        * Mark the block movable so that blocks are reserved for
-        * movable at startup. This will force kernel allocations
-        * to reserve their blocks rather than leaking throughout
-        * the address space during boot when many long-lived
-        * kernel allocations are made.
-        *
-        * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
-        * because this is done early in section_activate()
+        * Note that we leave pageblock migratetypes uninitialized, because
+        * they don't apply to ZONE_DEVICE.
          */
-       if (pageblock_aligned(pfn)) {
-               set_pageblock_migratetype(page, MIGRATE_MOVABLE);
+       if (pageblock_aligned(pfn))
                 cond_resched();
-       }
  
         /*
          * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released


-- 
Cheers,

David / dhildenb



