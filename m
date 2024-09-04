Return-Path: <linux-kernel+bounces-314593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F6A96B57C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B238F286D00
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FF81CCB41;
	Wed,  4 Sep 2024 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPtSs7/C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647541CC16B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439862; cv=none; b=n56k1PazIb8zfdqphutmlwSUSTuGMr39WuAArGGmGUVvG9cbC4mcP6Gt/+3YSDI+haX9iGnmTejjUj0Z5SfRSu/09aLwPHe7etng9MAZbkufyI0Uw3PLswFWVId18X8xiNEmCAe6X1fnIybYb2VZl6usjN7QzNORQHTikzR/RHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439862; c=relaxed/simple;
	bh=UEz3Sn43jNMrmKx2pZRqHeGRzNqwnwiZkXgh4TyIc94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERYYcdjTvCF0bdJdSXENKtYwyWXoy1j6dpPSpD79xdg52Uamh+Ln5OyfMK0vFW8p7yuMNGYuwSlXafcSCxtHBVpUzEUhwXaoMfH8hq9aaF/srq81R0sReuSLU96MkfMLX54PtFoOR0P5HUvlFfUHtco8b+rxTFoowBORZwoJ3ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPtSs7/C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725439859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0rtjLuwJxb3htjFIiBlRIFz9uTaoRL8IZyIpbGsQF2I=;
	b=iPtSs7/CQsjt6Hspaqo/QXTOvn5RFsCcskRi+2n1esDCjrIb6Fn12H8BrKh/jePVKOK2w+
	dt7ZecApjaxiq75IC4aEFUWQyOBM57zBnYQm/eMqM+wSk+PzzNnDVptHqG0EicQ+Mk/i0u
	r4YQK6763ZInuSq9wvK2dI+qw78peTQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-sxGTevqYND29G-KJWdbBFw-1; Wed, 04 Sep 2024 04:50:58 -0400
X-MC-Unique: sxGTevqYND29G-KJWdbBFw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374c3a31ebcso2212321f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 01:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725439856; x=1726044656;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0rtjLuwJxb3htjFIiBlRIFz9uTaoRL8IZyIpbGsQF2I=;
        b=N+i5yWvcAONCSis1PCwjMFKE5Nx7yKANQvznv3aGoU5xvYbgt+JobonJCearvAuou7
         XS5G+wYvEYfpDiHy5JMpTxn3L48YCBHzf09ydM8sMKHYtNX1zWXZPQAnxGFyd+5x3F/c
         azv7ryDi+Z2YSAlTa5xLSR3vrpun3DgXqjcPIOdBsEDsV6SRg5hsbVISJx8b6dYZ+837
         hSvfJ+8aiiUXpoBT8C9qe5z1Ftj2vdCyrm/DWMq0QtC3/wPCR9daLtCnwKs6fu7T/8SG
         AtHbjNqouuboErrpLmJ/4IsRvsUERSxQgG/kQppCvfMYQPyyD7k9l8YLq9mHZrLMDVZs
         Kxrg==
X-Forwarded-Encrypted: i=1; AJvYcCXMtwrEBvKodbT2eDenck7D8Gbl9T3b7Yn47l2DZ3mABEI/65idluE9xsSAzfwm/pxL2UvEvaYEFt69VdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRAHFMfYzWFuWKxpnmeyXnyOyaFqgFPRk+0VIn9O5P9Iipdh0j
	mAkUhbORNKrp9/SF+hzPSxaGzOIFnx0SWnT+GoUPJj0+gplCe4QzPqkzvggyEGoqjaO+CQMOlws
	uacw2r3GS28UECz65QFPwD8Be9zMy7ZqPS8vw46DnMPLEI0lMW2zI70hZ7mulZw==
X-Received: by 2002:adf:fc0f:0:b0:374:b300:c4d5 with SMTP id ffacd0b85a97d-376dd71a859mr2088088f8f.28.1725439855781;
        Wed, 04 Sep 2024 01:50:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAXhOS8DBgnk2EEFBKrG7rMpCXxanJmU2ThVKIcTEUHBgZSEUFyTefuoTn1b6I1QXY0CwSwQ==
X-Received: by 2002:adf:fc0f:0:b0:374:b300:c4d5 with SMTP id ffacd0b85a97d-376dd71a859mr2088055f8f.28.1725439854808;
        Wed, 04 Sep 2024 01:50:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:d00:e9a5:ae4b:9bdb:d992? (p200300cbc7150d00e9a5ae4b9bdbd992.dip0.t-ipconnect.de. [2003:cb:c715:d00:e9a5:ae4b:9bdb:d992])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374b61494bcsm13415735f8f.95.2024.09.04.01.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 01:50:54 -0700 (PDT)
Message-ID: <1c33a814-db9b-49c4-b465-5b94b04531a7@redhat.com>
Date: Wed, 4 Sep 2024 10:50:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] mm/page_isolation: remove migratetype parameter
 from more functions.
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>,
 Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
References: <20240828202240.2809740-1-ziy@nvidia.com>
 <20240828202240.2809740-5-ziy@nvidia.com>
 <a43c866f-b281-49d3-b503-f5f86dadd306@redhat.com>
 <E48CFE6F-05A8-4D12-84D0-2B6F7484974E@nvidia.com>
 <dff8fa34-9099-46f9-b39a-1a986af2b022@redhat.com>
 <BDD48C59-0C42-4B1E-A4F3-FF97744FCF6D@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <BDD48C59-0C42-4B1E-A4F3-FF97744FCF6D@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.09.24 04:02, Zi Yan wrote:
> On 2 Sep 2024, at 12:42, David Hildenbrand wrote:
> 
>> On 02.09.24 17:34, Zi Yan wrote:
>>> On 2 Sep 2024, at 5:06, David Hildenbrand wrote:
>>>
>>>> On 28.08.24 22:22, Zi Yan wrote:
>>>>> migratetype is no longer overwritten during pageblock isolation,
>>>>> start_isolate_page_range(), has_unmovable_pages(), and
>>>>> set_migratetype_isolate() no longer need which migratetype to restore
>>>>> during isolation failure. For has_unmoable_pages(), it needs to know if
>>>>> the isolation is for CMA allocation, so adding CMA_ALLOCATION to isolation
>>>>> flags to provide the information.
>>>>>
>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>> ---
>>>>>     include/linux/page-isolation.h |  3 ++-
>>>>>     mm/memory_hotplug.c            |  1 -
>>>>>     mm/page_alloc.c                |  4 +++-
>>>>>     mm/page_isolation.c            | 27 +++++++++++----------------
>>>>>     4 files changed, 16 insertions(+), 19 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
>>>>> index c2a1bd621561..e94117101b6c 100644
>>>>> --- a/include/linux/page-isolation.h
>>>>> +++ b/include/linux/page-isolation.h
>>>>> @@ -32,13 +32,14 @@ static inline bool is_migrate_isolate(int migratetype)
>>>>>      #define MEMORY_OFFLINE	0x1
>>>>>     #define REPORT_FAILURE	0x2
>>>>> +#define CMA_ALLOCATION	0x4
>>>>>      void set_pageblock_migratetype(struct page *page, int migratetype);
>>>>>      bool move_freepages_block_isolate(struct zone *zone, struct page *page);
>>>>>      int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>>>>> -			     int migratetype, int flags, gfp_t gfp_flags);
>>>>> +			     int flags, gfp_t gfp_flags);
>>>>>      void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn);
>>>>>    diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>>>> index 4265272faf4c..fe0b71e0f307 100644
>>>>> --- a/mm/memory_hotplug.c
>>>>> +++ b/mm/memory_hotplug.c
>>>>> @@ -1993,7 +1993,6 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>>>>>      	/* set above range as isolated */
>>>>>     	ret = start_isolate_page_range(start_pfn, end_pfn,
>>>>> -				       MIGRATE_MOVABLE,
>>>>>     				       MEMORY_OFFLINE | REPORT_FAILURE,
>>>>>     				       GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL);
>>>>>     	if (ret) {
>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>> index 4d06932ba69a..c60bb95d7e65 100644
>>>>> --- a/mm/page_alloc.c
>>>>> +++ b/mm/page_alloc.c
>>>>> @@ -6607,7 +6607,9 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
>>>>>     	 * put back to page allocator so that buddy can use them.
>>>>>     	 */
>>>>>    -	ret = start_isolate_page_range(start, end, migratetype, 0, gfp_mask);
>>>>> +	ret = start_isolate_page_range(start, end,
>>>>> +			migratetype == MIGRATE_CMA ? CMA_ALLOCATION : 0,
>>>>
>>>> Can we have flags for alloc_contig_range() instead of passing in a (weird) migratetype?
>>>>
>>>> Then, we should make sure that we warn if we try a CMA allocation on any pageblock that is not of type CMA.
>>>
>>> Sure. I will expose the existing isolation flags (MEMORY_OFFLINE, REPORT_FAILURE,
>>> and CMA_ALLOCATION) as alloc_contig_range() parameter to replace migratetype one.
>>>
>>
>> Maybe we want some proper, distinct alloc_contig_range() falgs "acr_flags_t". Might be cleanest, to express anything that doesn't fall into the gfp_t flag category.
>>
>> Exposing MEMORY_OFFLINE feels wrong, for example.
> 
> OK, it seems that I mixed up of start_isolate_page_range() flags with
> alloc_contig_range() flags. Let me clarify them below.
> 
> For start_isolate_page_range(), memory offline calls it separately and
> needs MEMORY_OFFLINE and REPORT_FAILURE; CMA allocation uses it via
> alloc_contig_range() and needs a flag (like CMA_ALLOCATION) for its
> own checks.
> 
> BTW, it seems to me that MEMORY_OFFLINE and REPORT_FAILURE can be merged,
> since they are always used together. Let me know if you disagree.

I think there was a discussion about possibly using REPORT_FAILURE in 
other cases, but I agree that we might just merge them at this point.

> 
> For alloc_contig_range(), migratetype parameter is what you are talking about
> above. There are two callers: cma_alloc() and alloc_contig_pages().
> The acr_flags_t is basically a caller id. Something like?
> enum acr_flags_t {
> 	ACR_CMA_ALLOC,
> 	ACR_CONTIG_PAGES,
> };

I'd do something like:

typedef unsigned int __bitwise acr_flags_t;

#define ACR_CMA		((__force acr_flags_t)BIT(0))

No need for "ACR_CONTIG_PAGES", it's implicit if the CMA flag is not set.


> 
> And ACR_CMA_ALLOC needs to be translated to CMA_ALLOCATION when
> start_isolate_page_range() is called.

Yes.

> 
> BTW, after removing migratetype parameter from alloc_contig_range(),
> the tracepoint in __alloc_contig_migrate_range() needs to be changed to
> use acr_flags_t, since I do not think we want to convert acr_flags_t
> back to migratetype.

Sure, feel free to modify these tracepoints as it suits you.

-- 
Cheers,

David / dhildenb


