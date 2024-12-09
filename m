Return-Path: <linux-kernel+bounces-438432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BDC9EA148
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88F8282888
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C90B19C54A;
	Mon,  9 Dec 2024 21:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpFjKrvC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E9846B8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733780133; cv=none; b=HragpqekVnwey9IsLj6/aIxEfOFWW6+b41uc4nvVtQ8vukWSv8KKYJ78hDJy+F6hF8aJHFuw5Xyj9m0vW3lnus03uDslkzVLN7T4SOVYJMg5IL/fRHrq+qhQRINPENycAyX0SGpfPhM07slbTqPRTOaewVHYdvg21eSbaN/qCnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733780133; c=relaxed/simple;
	bh=Ur8mB59paoe0fWuu808yYLLVrha1nH4CxuFXuQwAGR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFnFNLYKx/vgFfL7Dts7hnG8CoEGLldrBBOEdvmLaGO5f7C7fOcbI24/AWhy3Goj1H9wU5bg5xj/+nrhwcGNoSiqxm+xy3X8ZEBwvMj4VFjIxlhE/J4LKh1Zu4QkWZdeS/9EsJKPhlbkwl3zdjMtTRriXaacvcdL1rAXCLHce6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UpFjKrvC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733780130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=70n3xdSaZgXZO2ROhuJrTZaqwaJdkTElowkjJvLcak0=;
	b=UpFjKrvCc/C9dUWLMqlm74Q3I65qLq26AoMu4q5teeTulMEEbia28Q0Q9NjnM8aYh6eZHn
	Vc+oMfCp06/0CZTbwPeBRMsOy+8PMi0mRRIPu2+IW1oWm9raJQG3ODO8LNRsSW+6vLcDmb
	SJdsmBkU5Fd6EHCSU9cgsbCHt0wttOg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-5jxv8TjjMoyJtDZn8xAecQ-1; Mon, 09 Dec 2024 16:35:29 -0500
X-MC-Unique: 5jxv8TjjMoyJtDZn8xAecQ-1
X-Mimecast-MFC-AGG-ID: 5jxv8TjjMoyJtDZn8xAecQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434f3398326so8125225e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 13:35:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733780128; x=1734384928;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=70n3xdSaZgXZO2ROhuJrTZaqwaJdkTElowkjJvLcak0=;
        b=f3FyhnEC8xMOKuHcn1VnKM74ocBxbKAD5c4Ug6wDJ7c4GhXCwr2sSt9Ex6X8P6ECSl
         wbNB5lA5PhQNKQPTSjpV8iqye1yifQn5wPHPsuhqMMVOb5tOnk+QLwW4ptOWAaETLh+T
         TGdeE08A1WdN0jrrgHecov2+/rj6Gc3dPFHVsoyy+2g6l8vX9AubSrJeD+B6FTu0Htsq
         +QSX0NQQjptN9siVMG5he//0oyjblTyNah6OCO6Kkm0BHoVXsrsjo6nqAKtBqNCNM9ko
         blv3zt6VMXYo+iV5Mbr+h0gzpp9snMJRyaLJShragOQy7aqpX+1QJmgG2S56RcrHkwtV
         jcLA==
X-Gm-Message-State: AOJu0YxZIGTnkubDOwD/5t8hiKYgk2+SguxdpWfMtLZvtA+u7z6WwOS7
	7I5AB4dPa53P/ezh7qEFEz88PlXqgFY6MRQcWphjwmhQQvKv18jSXA/uEj0a402ZMRN889+0QJa
	twYvvdzZQnk1/x/MvjAiouvu4eEEt7wqZT/5y372CHHm33ZjI68rK2aBQiVO3l4xlMiI2iw==
X-Gm-Gg: ASbGnctT//5V+54UqHx6c2OrmwM2cL8mcKaW+PsCiZRkBYfd+BVbMzgPlY0Vbt/ZV9n
	ulG9uf7EMPGqYoE2NGYjR+S+JcxXz/OFHjbNdbzfpCjFPBqMM0B96ovVZwrYeDm9QEyKUGz9nAC
	lcEezSTbg7StkfKVJ8UE2VfH20Dtf7bdogRvnbKiPSt4HTPL+WQcj+ZGpM3tl2vqAbZZXWOJKIT
	SMvJfAg8ciXmLdo+HshcrpJamHr7liy8GQMG1sdqNHKVYXf8Kvdjk9+dekI8gxj1Dk2CeGfxGgg
	xDMZarpLCdHH91Z9H4qiSbZR5VcJ8ek+xVuPxntQOkDGGNxE796cgKH1wL0EUvQ5whPOAnVVz+r
	F9Jqg3A==
X-Received: by 2002:a05:600c:1791:b0:431:15f1:421d with SMTP id 5b1f17b1804b1-435021e916emr6443895e9.16.1733780128154;
        Mon, 09 Dec 2024 13:35:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG40vlopO3K0D70apQhM15wsvzbvmNktiJfG0OC439H7arNAniPqnPN6AKEeuu1AiCMWIZTDw==
X-Received: by 2002:a05:600c:1791:b0:431:15f1:421d with SMTP id 5b1f17b1804b1-435021e916emr6443765e9.16.1733780127803;
        Mon, 09 Dec 2024 13:35:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c71b:2c00:7bfb:29fe:9e6f:2e65? (p200300cbc71b2c007bfb29fe9e6f2e65.dip0.t-ipconnect.de. [2003:cb:c71b:2c00:7bfb:29fe:9e6f:2e65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4350159f6a4sm12209525e9.21.2024.12.09.13.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 13:35:26 -0800 (PST)
Message-ID: <db1815b1-fd24-4b8f-ab64-32b0c4df6cd6@redhat.com>
Date: Mon, 9 Dec 2024 22:35:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm/page_alloc: conditionally split >
 pageblock_order pages in free_one_page() and move_freepages_block_isolate()
To: Zi Yan <ziy@nvidia.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Yu Zhao <yuzhao@google.com>
References: <20241206095951.98007-1-david@redhat.com>
 <20241206095951.98007-2-david@redhat.com>
 <e1a898ba-a717-4d20-9144-29df1a6c8813@suse.cz>
 <37B7A92E-B58F-442D-8501-B07A507F0451@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <37B7A92E-B58F-442D-8501-B07A507F0451@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.12.24 20:23, Zi Yan wrote:
> On 9 Dec 2024, at 14:01, Vlastimil Babka wrote:
> 
>> On 12/6/24 10:59, David Hildenbrand wrote:
>>> Let's special-case for the common scenarios that:
>>>
>>> (a) We are freeing pages <= pageblock_order
>>> (b) We are freeing a page <= MAX_PAGE_ORDER and all pageblocks match
>>>      (especially, no mixture of isolated and non-isolated pageblocks)
>>
>> Well in many of those cases we could also just adjust the pageblocks... But
>> perhaps they indeed shouldn't differ in the first place, unless there's an
>> isolation attempt.
>>
>>> When we encounter a > MAX_PAGE_ORDER page, it can only come from
>>> alloc_contig_range(), and we can process MAX_PAGE_ORDER chunks.
>>>
>>> When we encounter a >pageblock_order <= MAX_PAGE_ORDER page,
>>> check whether all pageblocks match, and if so (common case), don't
>>> split them up just for the buddy to merge them back.
>>>
>>> This makes sure that when we free MAX_PAGE_ORDER chunks to the buddy,
>>> for example during system startups, memory onlining, or when isolating
>>> consecutive pageblocks via alloc_contig_range()/memory offlining, that
>>> we don't unnecessarily split up what we'll immediately merge again,
>>> because the migratetypes match.
>>>
>>> Rename split_large_buddy() to __free_one_page_maybe_split(), to make it
>>> clearer what's happening, and handle in it only natural buddy orders,
>>> not the alloc_contig_range(__GFP_COMP) special case: handle that in
>>> free_one_page() only.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>
>> Acked-by: Vlastimil Babka <vbabka@suse.cz
>>
>> Hm but noticed something:
>>
>>> +static void __free_one_page_maybe_split(struct zone *zone, struct page *page,
>>> +		unsigned long pfn, int order, fpi_t fpi_flags)
>>> +{
>>> +	const unsigned long end_pfn = pfn + (1 << order);
>>> +	int mt = get_pfnblock_migratetype(page, pfn);
>>> +
>>> +	VM_WARN_ON_ONCE(order > MAX_PAGE_ORDER);
>>>   	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
>>>   	/* Caller removed page from freelist, buddy info cleared! */
>>>   	VM_WARN_ON_ONCE(PageBuddy(page));
>>>
>>> -	if (order > pageblock_order)
>>> -		order = pageblock_order;
>>> -
>>> -	while (pfn != end) {
>>> -		int mt = get_pfnblock_migratetype(page, pfn);
>>> +	/*
>>> +	 * With CONFIG_MEMORY_ISOLATION, we might be freeing MAX_ORDER_NR_PAGES
>>> +	 * pages that cover pageblocks with different migratetypes; for example
>>> +	 * only some migratetypes might be MIGRATE_ISOLATE. In that (unlikely)
>>> +	 * case, fallback to freeing individual pageblocks so they get put
>>> +	 * onto the right lists.
>>> +	 */
>>> +	if (!IS_ENABLED(CONFIG_MEMORY_ISOLATION) ||
>>> +	    likely(order <= pageblock_order) ||
>>> +	    pfnblock_migratetype_equal(pfn + pageblock_nr_pages, end_pfn, mt)) {
>>> +		__free_one_page(page, pfn, zone, order, mt, fpi_flags);
>>> +		return;
>>> +	}
>>>
>>> -		__free_one_page(page, pfn, zone, order, mt, fpi);
>>> -		pfn += 1 << order;
>>> +	while (pfn != end_pfn) {
>>> +		mt = get_pfnblock_migratetype(page, pfn);
>>> +		__free_one_page(page, pfn, zone, pageblock_order, mt, fpi_flags);
>>> +		pfn += pageblock_nr_pages;
>>>   		page = pfn_to_page(pfn);
>>
>> This predates your patch, but seems potentially dangerous to attempt
>> pfn_to_page(end_pfn) with SPARSEMEM and no vmemmap and the end_pfn perhaps
>> being just outside of the valid range? Should we change that?
>>
>> But seems this code was initially introduced as part of Johannes'
>> migratetype hygiene series.
> 
> It starts as split_free_page() from commit b2c9e2fbba32 ("mm: make
> alloc_contig_range work at pageblock granularity”), but harmless since
> it is only used to split a buddy page. Then commit fd919a85cd55 ("mm:
> page_isolation: prepare for hygienic freelists") refactored it, which
> should be fine, since it is still used for the same purpose in page
> isolation. Then commit e98337d11bbd ("mm/contig_alloc: support __GFP_COMP")
> used it for gigantic hugetlb.
> 
> For SPARSEMEM && !SPARSEMEM_VMEMMAP, PFNs are contiguous, vmemmap might not
> be. The code above using pfn in the loop might be fine. And since order
> is provided, unless the caller is providing a falsely large order, pfn
> should be valid. Or am I missing anything?

I think the question is, what happens when we call pfn_to_page() on a 
PFN that falls into a memory section that is either offline, doesn't 
have a memmap, or does not exist.

With CONFIG_SPARSEMEM, we do a

struct mem_section *__sec = __pfn_to_section(__pfn)
__section_mem_map_addr(__sec) + __pfn;

__pfn_to_section() can return NULL, in which case 
__section_mem_map_addr() would dereference NULL.

I assume it ould happen in corner cases, if we'd exceed 
NR_SECTION_ROOTS. (IOW, large memory, and we free a page that is at the 
very end of physical memory).

Likely, we should do the pfn_to_page() before the __free_one_page() call.

-- 
Cheers,

David / dhildenb


