Return-Path: <linux-kernel+bounces-440345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 748C89EBBF8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749D3285714
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51684239780;
	Tue, 10 Dec 2024 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zet/jLE1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F46237A57
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866824; cv=none; b=Ad8syoy1xhgaz7CrUkUeBvZPUe9128msrxEFjxyCJh6ItJwClerHfg2HqHDXs9bubHZOCSQhfss1m38FvQXDpqAnnTzp8txDTM8R97Mc6fc75yh4+DA2hyNyRbaZ1iwTnghOaU3gG79UtcSu5pvwwfkNQYdH39OLomRt7PJ1q1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866824; c=relaxed/simple;
	bh=vvcF0D/NC7Ynf2V/eBwyAkR6hkCW0ZYH/yAZI2Kh5SQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVMPDkgQEURrAi9m2u3DsS3S/6L0M//vuCImlXJGFz1lIer8WpoQqOyW8kMILbFH4A6BQx2FO8cN08D7evkRUL1jjqHM24sWeXAgEvdFUcDuTM/SoYVzrRGZzk8SMO3C1wP7AfD0JLBW68wVjjtRh3WWi4I6eVrJk2aQ5JohkeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zet/jLE1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733866821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m/tF51eXbb5jrkuUIZarKQ2cXR84PajfTI8ZKBMgFzo=;
	b=Zet/jLE1o/66YAtctkpDbYdf9Av1hfv/VVEXZGc4bMfEiARvztRpPbQx9bdpza9mZO3rV0
	3dypE0mjm5ilXraTfic+4i5IM6mc66mlIZZZY39yEqfYCnapQwOmcGEd8gEGrMNxpvafAE
	BE5PV/2+WQGhFKMR7xOjYuduayFBbQ4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-_LRVr9fhP3mNQAVKycZ6mQ-1; Tue, 10 Dec 2024 16:40:19 -0500
X-MC-Unique: _LRVr9fhP3mNQAVKycZ6mQ-1
X-Mimecast-MFC-AGG-ID: _LRVr9fhP3mNQAVKycZ6mQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385dfa9b758so2419455f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733866818; x=1734471618;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m/tF51eXbb5jrkuUIZarKQ2cXR84PajfTI8ZKBMgFzo=;
        b=xFIcyJfbw7uR6NRH1afFcRdACoSbkESbnRzBDbthM1yLIwoxEAoQ6BoxXkw3XwDEDl
         i8m3bx8oOEfcWplZAjfNd2Y+GF3iurVOF+7HovsQl6O/d4e+g0UHimRhDuDIvJ64UAbX
         sBY/i9V+UlEL8TqpbSeIENNFzzxB3CNHXV+j2TofSCtitLdBQ4WnZuo4VejtFxYDWxiJ
         XS15IfLvAzQqDwUQicm+PXLRUX2ImCz/acm46NGL77qton3v//37U7amDiVcqyIFIEbL
         BAByq2ce3rm6ES3W6kfm2NPAll+f6AKcGWvLJY8QcytYf9NHtWLHuHlFMnI7HYfeK8PS
         xXFg==
X-Gm-Message-State: AOJu0YyZM7hltwI6uTvmvF5cFpuwcBswe3mveC5eO6YigpVHFfQKJF3n
	wbSnLbpvaPPa4zZW/sRLmy5x+iYWL5/NgFvUXJjkK9u1FdNE/sazG85a8tl0Q4kOwCB9Rbt4v8i
	k5+m18KTGfbS+1YLRXGI9r30x/Yy93pqMilbwcsJHQxNJpfTeoPuWXFr5OlTTXg==
X-Gm-Gg: ASbGncumSU0R0NHcWmaouYNN38vSbCtCKYPDcwvmuOjWzK6Df7uIKOB8HtFPY3R3n9H
	OyLpug2CN4WDEYgBVUfwwCuH+DBWdLQNh/wl5cFYLMtGpH1q8xLN9M7UzEMbNjCLbreifVPSldc
	dcTLLN9s8Aa8X8BMIfVIZ57LxMZGVGqU+ugXRsw2IHu2rqUTiCHNI/CF7v9cF2bt552ni5zfsv4
	60yxl9o3t60A3ScenHPhorXlHixOFez+H0X/B+X9XjLrWDMNBjpxcVt7B4o2JfeUcB2GdP3iK0a
	tpc9Gig=
X-Received: by 2002:a05:6000:186b:b0:385:fa2e:a354 with SMTP id ffacd0b85a97d-3864cec5a37mr492068f8f.47.1733866818508;
        Tue, 10 Dec 2024 13:40:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqTINoip0c57ha4zf1Bq/7M87ePT7gVjq3i20nCGv67CIscyoqQFcWasYGOOy1v37ekxP3Ag==
X-Received: by 2002:a05:6000:186b:b0:385:fa2e:a354 with SMTP id ffacd0b85a97d-3864cec5a37mr492054f8f.47.1733866818114;
        Tue, 10 Dec 2024 13:40:18 -0800 (PST)
Received: from [192.168.3.141] (p5b0c61ad.dip0.t-ipconnect.de. [91.12.97.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386220b071dsm16609345f8f.101.2024.12.10.13.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 13:40:16 -0800 (PST)
Message-ID: <d6a79fa6-dcc1-4181-9946-940a91c0b1f2@redhat.com>
Date: Tue, 10 Dec 2024 22:40:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/page_alloc: conditionally split >
 pageblock_order pages in free_one_page() and move_freepages_block_isolate()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>
References: <20241210102953.218122-1-david@redhat.com>
 <20241210102953.218122-2-david@redhat.com>
 <20241210211613.GC2508492@cmpxchg.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241210211613.GC2508492@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.12.24 22:16, Johannes Weiner wrote:
> On Tue, Dec 10, 2024 at 11:29:52AM +0100, David Hildenbrand wrote:
>> @@ -1225,27 +1225,53 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>>   	spin_unlock_irqrestore(&zone->lock, flags);
>>   }
>>   
>> -/* Split a multi-block free page into its individual pageblocks. */
>> -static void split_large_buddy(struct zone *zone, struct page *page,
>> -			      unsigned long pfn, int order, fpi_t fpi)
>> +static bool pfnblock_migratetype_equal(unsigned long pfn,
>> +		unsigned long end_pfn, int mt)
>>   {
>> -	unsigned long end = pfn + (1 << order);
>> +	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | end_pfn, pageblock_nr_pages));
>>   
>> +	while (pfn != end_pfn) {
>> +		struct page *page = pfn_to_page(pfn);
>> +
>> +		if (unlikely(mt != get_pfnblock_migratetype(page, pfn)))
>> +			return false;
>> +		pfn += pageblock_nr_pages;
>> +	}
>> +	return true;
>> +}
>> +
>> +static void __free_one_page_maybe_split(struct zone *zone, struct page *page,
>> +		unsigned long pfn, int order, fpi_t fpi_flags)
>> +{
>> +	const unsigned long end_pfn = pfn + (1 << order);
>> +	int mt = get_pfnblock_migratetype(page, pfn);
>> +
>> +	VM_WARN_ON_ONCE(order > MAX_PAGE_ORDER);
>>   	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
>>   	/* Caller removed page from freelist, buddy info cleared! */
>>   	VM_WARN_ON_ONCE(PageBuddy(page));
>>   
>> -	if (order > pageblock_order)
>> -		order = pageblock_order;
>> +	/*
>> +	 * With CONFIG_MEMORY_ISOLATION, we might be freeing MAX_ORDER_NR_PAGES
>> +	 * pages that cover pageblocks with different migratetypes; for example
>> +	 * only some migratetypes might be MIGRATE_ISOLATE. In that (unlikely)
>> +	 * case, fallback to freeing individual pageblocks so they get put
>> +	 * onto the right lists.
>> +	 */
>> +	if (!IS_ENABLED(CONFIG_MEMORY_ISOLATION) ||
>> +	    likely(order <= pageblock_order) ||
>> +	    pfnblock_migratetype_equal(pfn + pageblock_nr_pages, end_pfn, mt)) {
>> +		__free_one_page(page, pfn, zone, order, mt, fpi_flags);
>> +		return;
>> +	}

Hi Johannes,

> 
> Ok, if memory isolation is disabled, we know the migratetypes are all
> matching up, and we can skip the check. However, if memory isolation
> is enabled, but this isn't move_freepages_block_isolate() calling, we
> still do the check unnecessarily and slow down the boot, no?

Yes, although it's on most machines one additional pageblock check 
(x86), on some a bit more (e.g., 3 on s390x).

As mentioned:

"
In the future, we might want to assume that all pageblocks are equal if
zone->nr_isolate_pageblock  == 0; however, that will require some
zone->nr_isolate_pageblock accounting changes, such that we are
guaranteed to see zone->nr_isolate_pageblock != 0 when there is an
isolated pageblock.
"

With that boot time wouldn't suffer in any significant way.

> 
> Having a function guess the caller is a bit of an anti-pattern. The
> resulting code is hard to follow, and it's very easy to
> unintentionally burden some cases with unnecessary stuff. It's better
> to unshare paths until you don't need conditionals like this.
 > > In addition to the fastpath, I think you're also punishing the
> move_freepages_block_isolate() case. We *know* we just changed the
> type of one of the buddy's blocks, and yet you're still checking the
> the range again to decide whether to split.

Yes, that's not ideal, and it would be easy to unshare that case (call 
the "split" function instead of a "maybe_split" function).

I am not 100% sure though, if move_freepages_block_isolate() can always 
decide "I really have a mixture", but that code is simply quite advanced :)

> 
> All of this to accomodate hugetlb, which might not even be compiled
> in? Grrrr.

Jup. But at the same time, it's frequently compiled in but never used 
(or barely used; I mean, how often do people actually free 1Gig hugetlb 
pages compared to ordinary pages).

> 
> Like you, I was quite surprised to see that GFP_COMP patch in the
> buddy hotpath splitting *everything* into blocks - on the offchance
> that somebody might free a hugetlb page. Even if !CONFIG_HUGETLB. Just
> - what the hell. We shouldn't merge "I only care about my niche
> usecase at the expense of literally everybody else" patches like this.

After talking to Willy, the whole _GFP_COMP stuff might get removed 
sooner or later again once we hand out frozen refcount in 
alloc_contig_range(). It might take a while, though.

> 
> My vote is NAK on this patch, and a retro-NAK on the GFP_COMP patch.

I won't fight for this patch *if* the GFP_COMP patch gets reverted. It 
improves the situation, which can be improved further.

But if it doesn't get reverted, we have to think about something else.

> 
> The buddy allocator operates on the assumption of MAX_PAGE_ORDER. If
> we support folios of a larger size sourced from other allocators, then
> it should be the folio layer discriminating. So if folio_put() detects
> this is a massive alloc_contig chunk, then it should take a different
> freeing path. Do the splitting in there, then pass valid chunks back
> to the buddy. That would keep the layering cleaner and the cornercase
> overhead out of the allocator fastpath.

That might be better, although not that completely trivial I assume.

How to handle the "MAX_PAGE_ORDER page is getting freed but one 
pageblock is isolated" case cleanly is a bit of a head scratcher, at 
least to me. But I suspect we had it fullt working before the GFF_COMP 
patch.

-- 
Cheers,

David / dhildenb


