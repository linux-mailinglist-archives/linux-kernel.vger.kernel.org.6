Return-Path: <linux-kernel+bounces-416071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 306809D3FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F8B280D31
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCC813AA31;
	Wed, 20 Nov 2024 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoSmQeuq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72124B28
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732119208; cv=none; b=pxblatb2SmEluAU6pkoC26DbvRC9IY5ChVkWPpvVs8nFJq4TkKn8CDILlHGsILyihRD6nqZpkXeLnvVNgFUkJnc/fDdU4ocNTkaxFSRuxjuSfC9CktumOIouHC3C6VndPYasgOzxLytgKk3VNqKW1qJY6PTKuuFw4UyaPzuGYnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732119208; c=relaxed/simple;
	bh=gfTcZqa6HetNiuIjvliwM6oy6cFPpL2mwixnK7MdM28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJ1QyvXSFYCUDUisn6bn+ablsQFOkUPjsi4MKeJ9vp3AF6hTEN9critpiqZDIRAJ0rAC4PNSn2poVTSvFEVbl73GlKizp7+7XJMdZv0S5oZpgGxtLmWRfdmbM+rDwNClGZfK/YU+eEF/3Cv6wVcZrpu5YTWRUtq55PIAgnrlvLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XoSmQeuq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732119204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IuKo2/wE6ky7AcTDqpk2Ya7QnJhEftSlfEdPnzPCyMY=;
	b=XoSmQeuqt8n8TMIh+vxSdGJC9ZMxXbbvy7IYJM4nYIe5KcQ7lE1t7vcf6evTnK1KmJJ2nv
	OfAoDKgH0vCYcmbxAvcFv/ocBmAVyJSEvxEFLN7SJBcCHsfbldIgwpDhrv8BNCFnahvF6I
	Evrj8CuHeMaHZO9GfPHBh8FT8E0C+kE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-C9EuqbKFOAmN3a-Z9a5i4Q-1; Wed, 20 Nov 2024 11:13:23 -0500
X-MC-Unique: C9EuqbKFOAmN3a-Z9a5i4Q-1
X-Mimecast-MFC-AGG-ID: C9EuqbKFOAmN3a-Z9a5i4Q
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4314a22ed8bso37408155e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:13:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732119201; x=1732724001;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IuKo2/wE6ky7AcTDqpk2Ya7QnJhEftSlfEdPnzPCyMY=;
        b=XkA7e/c+AIUY13gnC7RgV7XPQw2iFcqlz5bLAJJdq1T4WzK3TILJYh6lZJ5sJjhFYD
         oKFmxpKxlsEINp6dGf1iMnfLSFqldRluvX/9eEezU1VfWzXtngCGYvKzOB/f6zl5nmSS
         hyU5i6MMPx8gmFZpOFKu/7JdBudziVafijXZ2Qr7lulh5ryRQ0p1hzFuD+3FsIDUQPiH
         /ubILudORiCofQbBr64KwOYN+SgLcIrQOiWvGVMIVCo9R0GpTgFUvi2yvRZ5D+BwlnFd
         p43UDDCsSHu/FlYJ/30EoiwE+tt63lI3KWhkhm9ms7OCDNKoNoCUoNf85lTMZWng3Naa
         cyiw==
X-Forwarded-Encrypted: i=1; AJvYcCXUjdB5hoaOPvyIiDHVa3gzBMmjqP2pXNa05k6sbD2OOLSMyLqEgF3gr0e1uPejTE4uctfv+qvQKiG3xeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiRqGtZoShJqONzTq9Kh9DFCW7nyoqCBaU3KIKOGFe06u0NvPy
	6Ecn2Cy2UothVaTjKV78F+mHAPur4igRZ0PYS89iQeI3+vzXeQSONW/5ShpWIBV+cVRnKuy92PO
	Wa/LlE4kYU+52ivVMJQC13MghCMMJ63hx98/RYerxeytmL7Uz3t6Wxb2twKTuOQ==
X-Received: by 2002:a05:600d:9:b0:42c:c401:6d67 with SMTP id 5b1f17b1804b1-433a4caad5amr24619785e9.6.1732119201687;
        Wed, 20 Nov 2024 08:13:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEg0ULa6BQNy4dsHvG6/UjKkLny03r20/5fYf0KBHnQG/F8Y/mycAAusCfb+a6mVvgWop+uaw==
X-Received: by 2002:a05:600d:9:b0:42c:c401:6d67 with SMTP id 5b1f17b1804b1-433a4caad5amr24619595e9.6.1732119201315;
        Wed, 20 Nov 2024 08:13:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:4200:ce79:acf6:d832:60df? (p200300cbc7054200ce79acf6d83260df.dip0.t-ipconnect.de. [2003:cb:c705:4200:ce79:acf6:d832:60df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45d4c68sm23573665e9.22.2024.11.20.08.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 08:13:20 -0800 (PST)
Message-ID: <393367d3-eb69-4255-a7aa-dcbcbe7a403e@redhat.com>
Date: Wed, 20 Nov 2024 17:13:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v2 1/3] mm/contig_alloc: support __GFP_COMP
To: Zi Yan <ziy@nvidia.com>
Cc: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240814035451.773331-1-yuzhao@google.com>
 <20240814035451.773331-2-yuzhao@google.com>
 <402ff3e5-4fca-4452-97ba-5b1ec4a6eeb1@redhat.com>
 <00721702-78FF-4690-8EAA-31C367FA9FC0@nvidia.com>
 <1a77f16b-d637-40b4-bf47-a8236729a0ca@redhat.com>
 <57A6BDB9-119B-4C1F-8715-2584046A5EA8@nvidia.com>
 <833078e4-3661-451a-bc11-3cb60a302946@redhat.com>
 <e46ab5c6-8b95-4d2f-b820-14659c615e81@redhat.com>
 <16391A0B-4E3C-4F3E-8904-9034DC87DC52@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <16391A0B-4E3C-4F3E-8904-9034DC87DC52@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.11.24 16:55, Zi Yan wrote:
> On 19 Nov 2024, at 11:52, David Hildenbrand wrote:
> 
>> On 19.11.24 17:49, David Hildenbrand wrote:
>>> On 19.11.24 17:41, Zi Yan wrote:
>>>> On 19 Nov 2024, at 11:31, David Hildenbrand wrote:
>>>>
>>>>> On 19.11.24 17:12, Zi Yan wrote:
>>>>>> On 19 Nov 2024, at 10:29, David Hildenbrand wrote:
>>>>>>
>>>>>>>> +/* Split a multi-block free page into its individual pageblocks. */
>>>>>>>> +static void split_large_buddy(struct zone *zone, struct page *page,
>>>>>>>> +			      unsigned long pfn, int order, fpi_t fpi)
>>>>>>>> +{
>>>>>>>> +	unsigned long end = pfn + (1 << order);
>>>>>>>> +
>>>>>>>> +	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
>>>>>>>> +	/* Caller removed page from freelist, buddy info cleared! */
>>>>>>>> +	VM_WARN_ON_ONCE(PageBuddy(page));
>>>>>>>> +
>>>>>>>> +	if (order > pageblock_order)
>>>>>>>> +		order = pageblock_order;
>>>>>>>> +
>>>>>>>> +	while (pfn != end) {
>>>>>>>> +		int mt = get_pfnblock_migratetype(page, pfn);
>>>>>>>> +
>>>>>>>> +		__free_one_page(page, pfn, zone, order, mt, fpi);
>>>>>>>> +		pfn += 1 << order;
>>>>>>>> +		page = pfn_to_page(pfn);
>>>>>>>> +	}
>>>>>>>> +}
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> stumbling over this while digging through the code ....
>>>>>>>
>>>>>>>> +
>>>>>>>>       static void free_one_page(struct zone *zone, struct page *page,
>>>>>>>>       			  unsigned long pfn, unsigned int order,
>>>>>>>>       			  fpi_t fpi_flags)
>>>>>>>>       {
>>>>>>>>       	unsigned long flags;
>>>>>>>> -	int migratetype;
>>>>>>>>        	spin_lock_irqsave(&zone->lock, flags);
>>>>>>>> -	migratetype = get_pfnblock_migratetype(page, pfn);
>>>>>>>> -	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
>>>>>>>
>>>>>>> This change is rather undesired:
>>>>>>>
>>>>>>> via __free_pages_core()->__free_pages_ok() we can easily end up here with order=MAX_PAGE_ORDER.
>>>>>>
>>>>>> Do you have a concrete example? PMD THP on x86_64 is pageblock_order.
>>>>>> We do not have PMD level mTHP yet. Any other possible source?
>>>>>>
>>>>>>>
>>>>>>> What your new code will do is split this perfectly reasonable MAX_PAGE_ORDER chunk via split_large_buddy() into pageblock-sized chunks, and let the buddy merging logic undo our unnecessary splitting.
>>>>>>>
>>>>>>> Is there a way to avoid this and just process the whole MAX_PAGE_ORDER chunk like we used to?
>>>>>>
>>>>>> Probably split_large_buddy() can check the migratetypes of the to-be-freed
>>>>>> page, if order > pageblock_order. If all migratetypes are the same, the page
>>>>>> can be freed at MAX_PAGE_ORDER, otherwise pageblock_order.
>>>>>
>>>>> Thinking about this: why do we care about the migratetype?
>>>>>
>>>>> We only have to fallback to pageblocks if any pageblock is "MIGRATE_ISOLATE" (and maybe MIGRATE_CMA), but not all. Otherwise, we can just ignore the migratetype (or rather overwrite it)
>>>>
>>>> There are VM_WARN_ONCEs around *_free_list() operations to make sure
>>>> page migratetype matches the migratetype of the list it is on. Ignoring
>>>> migratetype would trigger these WARNs. Overwriting it would work but
>>>> free page migratetype accounting needs to be taken care of.
>>>>
>>>> An implicit reason is that __free_one_page() does not support >MAX_PAGE_ORDER
>>>> and gigantic hugetlb folios are freed via free_one_page(), where
>>>> split_large_buddy() is used to work around the limitation.
>>>
>>> Yes, I saw that change. But that can be easily identified cased by
>>> unlikely(order > MAX_PAGE_ORDER) to handle that rare case in a special way.
>>>
>>>    > > For the two memory init cases you mentioned in the other email,
>>> maybe a new
>>>> fpi flag to make free_one_page() use __free_one_page() for them,
>>>> since migratetypes should be the same across MAX_PAGE_ORDER range there, right?
>>>
>>> In the context of alloc_frozen_range()/free_frozen_range() I want to
>>> free MAX_PAGE_ORDER chunks when possible, and not have some odd logic in
>>> the freeing path undo some of that effort.
>>
>> Adding a pointer to that discussion:
>>
>> https://lkml.kernel.org/r/ZzZdnuZBf-xgiwD2@casper.infradead.org
> 
> Thanks.
> 
> So you are thinking about something like this:
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b6958333054d..3d3341dc1ad1 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1254,7 +1254,12 @@ static void free_one_page(struct zone *zone, struct page *page,
>   	unsigned long flags;
> 
>   	spin_lock_irqsave(&zone->lock, flags);
> -	split_large_buddy(zone, page, pfn, order, fpi_flags);
> +	if (unlikely(order > MAX_PAGE_ORDER))
> +		split_large_buddy(zone, page, pfn, order, fpi_flags);> +	else {
> +		int migratetype = get_pfnblock_migratetype(page, pfn);
> +		__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
> +	}
>   	spin_unlock_irqrestore(&zone->lock, flags);
> 
>   	__count_vm_events(PGFREE, 1 << order);
> 

Something in that direction, but likely something like:

if (likely(order <= pageblock_order)) {
	int migratetype = get_pfnblock_migratetype(page, pfn);
	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
} else if (order <= MAX_PAGE_ORDER) {
	/* We might have to split when some pageblocks differ. */
	maybe_split_large_buddy(zone, page, pfn, order, fpi_flags);
} else {
	/* The buddy works in max MAX_PAGE_ORDER chunks. */
	for /* each MAX_PAGE_ORDER chunk */
		maybe_split_large_buddy(zone, page, pfn, MAX_PAGE_ORDER, fpi_flags);
		pfn += MAX_ORDER_NR_PAGES;
		page = ...
	}	
}

Whereby maybe_split_large_buddy would check if it has to do anything with the
pageblocks, or whether it can just call __free_one_page(order). It would only
accept order <=

In the future with free_frozen_pages(), the last else case would vanish.

> 
> Is it possible to have a MAX_PAGE_ORDER hugetlb folio? If no, we are good.

Hm, I wouldn't rule it out. To be future proof, we'd likely should add a
way to handle it. Shouldn't be too hard and expensive: simply read all
pageblock migratetypes.

I wonder if there are configs (no page isolation?) where we don't have to
check anything.

> If yes, alloc_contig_range() can change the migratetype of one of half that folio
> and during migration phase, that folio will be freed via __free_one_page()
> and causing migratetype mismatch.

Can you remind me how that happens?

Likely, we isolate a single pageblock, and shortly after we free a larger
page that covers multiple pageblocks? So this could affect other
alloc_contig_range() users as well, I assume?

Thanks!

-- 
Cheers,

David / dhildenb


