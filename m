Return-Path: <linux-kernel+bounces-542415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B851FA4C96D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A6617A259
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B721DA61B;
	Mon,  3 Mar 2025 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QScpy0P+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2139018991E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 17:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021584; cv=none; b=LVgLrseDot3N80meZH9aBwjURniVQqtqV/3I96bXvY8wNqNliby2fVarJl0OmQL9qqkX2idM9Oft8YnxvyYI3XWadQuzrdYOQorByMPWsIcKqN8cNYLZZRrrZwwm8rFIciyqJqblOESyrpcipIKLp/MsWaVM18ZWuV+/nwAzBRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021584; c=relaxed/simple;
	bh=1V+h/kRrYoy9qfdHX9yGBWSnDW6pePW9z0w52RcN5tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kV12LUD+qxeD3STYmRc7jy2aOeTzAUKYcIz1xu7POzmwoNlyNUCRx6m9rzgF83nWCxjIQE31p0S1vqpePnTGcEfTPhHY+FcpdUAd5/o804E8ysEymqkCmoeRL6FYSxPWe81HwHcMDl1c3WtYAZfjPtwkfAwmD1XKo1gAk9eUcro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QScpy0P+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741021581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gsS4uQGU3Fy152pH6WRF0p0WuZMpxXSqYsWQZibR72E=;
	b=QScpy0P+6sLlqMAYRmocFj8sB7jG1zd3SHqH+irtvpd6wCnTMjwtmkjG2p8CqG4j/pvpZS
	Sjwgv+3rk9rTlEx2SQiD9wNFFSQKn3Y8hEwYh+LgP7ntjdhRqrgxSvEz5ePQfmUADBvdAQ
	3ZiiK2aQ+KhHT11ZgHtoX+pURu6fQeU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-6BZn_EFFPPO8Lsj744wtng-1; Mon, 03 Mar 2025 12:06:15 -0500
X-MC-Unique: 6BZn_EFFPPO8Lsj744wtng-1
X-Mimecast-MFC-AGG-ID: 6BZn_EFFPPO8Lsj744wtng_1741021574
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394c489babso26229745e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 09:06:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741021574; x=1741626374;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gsS4uQGU3Fy152pH6WRF0p0WuZMpxXSqYsWQZibR72E=;
        b=Divw29rQcVMyvWRJm+zYvaavUPZmW9QacgIbtA2dAsRTBimyGbV/Zi+SPlBFnYb5/K
         vCM1dh6otyQvg6V+opFsh6P/vJ96OPYg/vGcB9qG4pLG9hxZcdP8GRUDcrZrbiTc2b6D
         iQOmXblBhOBFqCiAQcj8At2FpdbVhbAkDHgemlGXuABj6vLQKSxxG5F7zkC1i1B9KkF1
         mBMi4Rc7k0tFfZBCsl/aAcDnNPaRjY0XmH/en4xgIKTJqBctG4dCCovuGrcCHlIgNwOP
         aKhGG3TL4drqI1ndRBzd/m6hW75Ok0qda1AQlTPKZSPt769QnJOgfSIRWAm8dJDl1FYN
         RYkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcgd0B4TCKgL8jxLC5JqCW8yD56hXxyv8sXDIjEQnq5xkd2kJHADQN5tG86yLU27bYBGIeia7PRt1204c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI0PVy9UJWpXBmaeHfBF+FOtZED0D1RUkc7nxmK3vBe5rc/gx+
	mA7wqrcZmX9YcP2of7WDufSMAVGZ6LTq8Pa9yyk+uglJVycKntQ18BOso7CyrCVABkecbjS/HkP
	2et6URo5Wes/AFnBWRPthSPTgoS6ym7AqGkQJFNTUqWk7CTmLAm87OHquSvI2Tw==
X-Gm-Gg: ASbGncuducgBpGZ3fGfenljyWrOS0gpG/rtzxDm1JPMm6ke5vENl01F/u2yVMlgUFl2
	Yu/4VYuepERtUNfuXaZuHiaAWbKvqENp0SMF24aSooqldjHSOL2ifHytPGmpO0iCz9UV7gfv7Zh
	QlaSHii/7DC/FmIjLQRlFz6d4rHFqG9iMIGZnf3Nd7IP6joTSJOEFBxxNrS37TecbmGuvqQsyne
	pd69HKFqtOaHHy1HM/ZXOy+Poh8uwfrrksauOBALoc71HLzRbAvVQoliLr5bKpcXPkCQnLS7UJw
	lcnN9V5NRlLqZhB8qo3scHCXo8ljZTfomlSZNq/SHBMLkdPD3/uGR6HJTQs+mjWIVNgxbpKcyVM
	4sd16TlsOCTtrTAkq+s9XYDs+6NSlgm7IM2sSJKwKhWM=
X-Received: by 2002:a05:600c:1c25:b0:439:8340:637 with SMTP id 5b1f17b1804b1-43ba6774ba2mr129021655e9.30.1741021574156;
        Mon, 03 Mar 2025 09:06:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYKD9yl9YKCpImv3triscGudcEtqinsDcILauuZwD8gm0vEC6r2GYlBRImMLzOgn3spwnAMw==
X-Received: by 2002:a05:600c:1c25:b0:439:8340:637 with SMTP id 5b1f17b1804b1-43ba6774ba2mr129021215e9.30.1741021573727;
        Mon, 03 Mar 2025 09:06:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb? (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d17sm14822253f8f.28.2025.03.03.09.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 09:06:13 -0800 (PST)
Message-ID: <0f120624-3ae9-4273-b349-b10d813a4e65@redhat.com>
Date: Mon, 3 Mar 2025 18:06:12 +0100
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
 <3e66875e-a4d5-4802-85b3-f873b0aa3b06@redhat.com>
 <Z8XSCE8goWnEzRSY@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z8XSCE8goWnEzRSY@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.03.25 17:00, Brendan Jackman wrote:
> On Mon, Mar 03, 2025 at 03:06:54PM +0100, David Hildenbrand wrote:
>> On 03.03.25 14:55, Brendan Jackman wrote:
>>> On Mon, Mar 03, 2025 at 02:11:23PM +0100, David Hildenbrand wrote:
>>>> On 03.03.25 13:13, Brendan Jackman wrote:
>>>>> Since the migratetype hygiene patches [0], the locking here is
>>>>> a bit more formalised.
>>>>>
>>>>> For other stuff, it's pretty obvious that it would be protected by the
>>>>> zone lock. But it didn't seem totally self-evident that it should
>>>>> protect the pageblock type. So it seems particularly helpful to have it
>>>>> written in the code.
>>>>
>>>> [...]
>>>>
>>>>> +
>>>>>     u64 max_mem_size = U64_MAX;
>>>>>     /* add this memory to iomem resource */
>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>> index 579789600a3c7bfb7b0d847d51af702a9d4b139a..1ed21179676d05c66f77f9dbebf88e36bbe402e9 100644
>>>>> --- a/mm/page_alloc.c
>>>>> +++ b/mm/page_alloc.c
>>>>> @@ -417,6 +417,10 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
>>>>>     void set_pageblock_migratetype(struct page *page, int migratetype)
>>>>>     {
>>>>> +	lockdep_assert_once(system_state == SYSTEM_BOOTING ||
>>>>> +		in_mem_hotplug() ||
>>>>> +		lockdep_is_held(&page_zone(page)->lock));
>>>>> +
>>>>
>>>> I assume the call chain on the memory hotplug path is mostly
>>>>
>>>> move_pfn_range_to_zone()->memmap_init_range()->set_pageblock_migratetype()
>>>>
>>>> either when onlining a memory block, or from pagemap_range() while holding
>>>> the hotplug lock.
>>>>
>>>> But there is also the memmap_init_zone_device()->memmap_init_compound()->__init_zone_device_page()->set_pageblock_migratetype()
>>>> one, called from pagemap_range() *without* holding the hotplug lock, and you
>>>> assertion would be missing that.
>>>>
>>>> I'm not too happy about that assertion in general.
>>>
>>> Hmm, thanks for pointing that out.
>>>
>>> I guess if we really wanted the assertion the approach would be to
>>> replace in_mem_hotplug() with some more fine-grained logic about the
>>> state of the pageblock? But that seems like it would require rework
>>> that isn't really justified.
>>
>> I was wondering if we could just grab the zone lock while initializing, then
>> assert that we either hold that or are in boot.
> 
> Would that be because you want to avoid creating in_mem_hotplug()? Or
> is it more about just simplifying the synchronization in general?

A little bit of both. The question is if lockless resizing of the zone 
range today is a bug or a feature :)

I'm not aware of any known side-effects of that, but if we could add 
locking without causing noticeable overheads, that would certainly be 
easiest ...

> 
> FWIW I don't think the in_mem_hotplug() is really that bad in the
> assertion, it feels natural to me that memory hotplug would be an
> exception to the locking rules in the same way that startup would be.
 > >> In move_pfn_range_to_zone() it should likely not cause too much 
harm, and we
>> could just grab it around all zone modification stuff.
>>
>> memmap_init_zone_device() might take longer and be more problematic.
>>
>> But I am not sure why memmap_init_zone_device() would have to set the
>> migratetype at all? Because migratetype is a buddy concept, and
>> ZONE_DEVICE does not interact with the buddy to that degree.
>>
>> The comment in __init_zone_device_page states:
>>
>> "Mark the block movable so that blocks are reserved for movable at
>> startup. This will force kernel allocations to reserve their blocks
>> rather than leaking throughout the address space during boot when
>> many long-lived kernel allocations are made."
> 
> Uh, yeah I was pretty mystified by that. It would certainly be nice if
> we can just get rid of this modification path.
> 
>> But that just dates back to 966cf44f637e where we copy-pasted that code.
>>
>> So I wonder if we could just
>>
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index 57933683ed0d1..b95f545846e6e 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -1002,19 +1002,11 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
>>          page->zone_device_data = NULL;
>>          /*
>> -        * Mark the block movable so that blocks are reserved for
>> -        * movable at startup. This will force kernel allocations
>> -        * to reserve their blocks rather than leaking throughout
>> -        * the address space during boot when many long-lived
>> -        * kernel allocations are made.
>> -        *
>> -        * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
>> -        * because this is done early in section_activate()
>> +        * Note that we leave pageblock migratetypes uninitialized, because
>> +        * they don't apply to ZONE_DEVICE.
>>           */
>> -       if (pageblock_aligned(pfn)) {
>> -               set_pageblock_migratetype(page, MIGRATE_MOVABLE);
>> +       if (pageblock_aligned(pfn))
>>                  cond_resched();
>> -       }
>>          /*
>>           * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
> 
> memory-model.rst says:
> 
>> Since the
>> page reference count never drops below 1 the page is never tracked as
>> free memory and the page's `struct list_head lru` space is repurposed
>> for back referencing to the host device / driver that mapped the memory.

That comment will be stale soon. In general, ZONE_DEVICE refcounts can 
drop to 0, but they will never go to the buddy, but will get intercepted 
on the freeing path.

> 
> And this code seems to assume that the whole pageblock is part of the
> ZONE_DEVICE dance, it would certainly make sense to me...

Sorry, I didn't get your final conclusion: do you thing we don't have to 
initialize the migratetype, or do you think there is reason to still do it?

-- 
Cheers,

David / dhildenb


