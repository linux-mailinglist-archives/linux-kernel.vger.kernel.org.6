Return-Path: <linux-kernel+bounces-311696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF1C968C52
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A01A1F2496E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEA81A3036;
	Mon,  2 Sep 2024 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcaI6T0n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B69B1A3026
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725295334; cv=none; b=hzXAzp4mXQHOhsV1/3tjhhC5e2kRigBMqbE9Xni3vfX/uw8N/mLL/bkLb19nBmPTxjccntTDKLX2JLzRWeB1u4Wsl8u0PWygvvE3733WAIyETzFJUvp0q8ZclFUAK4EKf7xd0o3vnvbE7pOc20nsOln6ewKeXCP2MrHDAK9wnRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725295334; c=relaxed/simple;
	bh=w5bGhFBw8Yfz8xeQfuTWnJ38Q6f1fej5dW2bU+k+IZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4cY/0AKrskuj6+GHbvoAIeAsnkxuPCBclUzb2W0PVPZPYGCL112r4JeNKSVRMpUiFgCne0A1iRB2kaZjPJz/qpejnO+9bx89N55Jx8QcOqZ2fOo7bnU7n34I/YZqOvMdls4geb3CQRb0ZbFTIX3iBF/Dvi+wrWAO8Rdd/cQ0G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YcaI6T0n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725295331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BsaDWSNqvHEeCgBl3B73WAMkUNUinopK1UT9iTVGNWo=;
	b=YcaI6T0nwBWWJ8Ah9RsY3Xpi6sGu3vhq1BvQ9e3FrO74y01pJ3Zms41hE5A1IhtLCec8tm
	+VO34sWizC/R9fYmsSF7bhB7ahrxSl8RNoYaQuwpQ1Ebt5+FuiJDEqv28+ZMu8Pp1Ry1o2
	oQmm95aaRkOdk70XU74QAMGqNsSgQB0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-Yo42ClOhNDiCKRyVwBmenw-1; Mon, 02 Sep 2024 12:42:09 -0400
X-MC-Unique: Yo42ClOhNDiCKRyVwBmenw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280b119a74so38935905e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 09:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725295329; x=1725900129;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BsaDWSNqvHEeCgBl3B73WAMkUNUinopK1UT9iTVGNWo=;
        b=nTp89NCirXQw9UgRghy985PKoVN9msxwhHLCPKNiEXCj7UOjpHbwL1S9asj3J+gxjv
         kExQhGVq/b+3LNYz/cTIiHrR/+6BflKdZs83hi1KtGr+ALXiyhREXP/NswqRyapEu+nq
         DwRD5TXf6vGkXHHlJRO1ZUFLDp5AokgIRt7Dqq6wEs+TllxrYiA9mPTAoFJnPwRLthVG
         Lwf964seunAetf6anzImcZdyThWcL2rs5bkiR7/9kyCw8ZqAGbIpKxpvU7saxyA1Fueb
         tJKDw6KOC+NUKDQew/cuZyceRG5JeJWCdJkKUlEdoaJIvaIO3//G+qASPNXaI7e7pBhi
         TihA==
X-Forwarded-Encrypted: i=1; AJvYcCUazzKwg2wh1NmiiPrpkdw2O5rU/+Q/3bLFMJr0O3uKzgdZVKOkccB4tzRJT0iDMu7fW1r384xqxhlkazc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2TGRGQwxsExtmtVOjaUrpTpmoYr22iNFd1AX6D0FSNAgM3Xi0
	ac9nZdv+ZWJ5iOcuiMAHvymHoSWw8JqFYFLr6bATOFsdXQuzOI6DU0aRgH6h9LVf9uNHl6q1fE2
	zCYbOZ/3TYH96oOZMRcbpAR2QlymqSN2uagQxsEHKnXP9scaIte0D7ENVyUKDBg==
X-Received: by 2002:a5d:4109:0:b0:374:c0c9:d171 with SMTP id ffacd0b85a97d-374c0c9d29emr3905359f8f.1.1725295328604;
        Mon, 02 Sep 2024 09:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHQQ6reJoWwkAsiplZoocDyZfSU2JPMsc2wWLCsiLR6OL+3SUAWe2350r1bl/+XvSBGot+QA==
X-Received: by 2002:a5d:4109:0:b0:374:c0c9:d171 with SMTP id ffacd0b85a97d-374c0c9d29emr3905334f8f.1.1725295327718;
        Mon, 02 Sep 2024 09:42:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72d:6500:849a:c1af:a5bb:ba9d? (p200300cbc72d6500849ac1afa5bbba9d.dip0.t-ipconnect.de. [2003:cb:c72d:6500:849a:c1af:a5bb:ba9d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c610d437sm4954602f8f.97.2024.09.02.09.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 09:42:07 -0700 (PDT)
Message-ID: <dff8fa34-9099-46f9-b39a-1a986af2b022@redhat.com>
Date: Mon, 2 Sep 2024 18:42:06 +0200
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <E48CFE6F-05A8-4D12-84D0-2B6F7484974E@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.09.24 17:34, Zi Yan wrote:
> On 2 Sep 2024, at 5:06, David Hildenbrand wrote:
> 
>> On 28.08.24 22:22, Zi Yan wrote:
>>> migratetype is no longer overwritten during pageblock isolation,
>>> start_isolate_page_range(), has_unmovable_pages(), and
>>> set_migratetype_isolate() no longer need which migratetype to restore
>>> during isolation failure. For has_unmoable_pages(), it needs to know if
>>> the isolation is for CMA allocation, so adding CMA_ALLOCATION to isolation
>>> flags to provide the information.
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>    include/linux/page-isolation.h |  3 ++-
>>>    mm/memory_hotplug.c            |  1 -
>>>    mm/page_alloc.c                |  4 +++-
>>>    mm/page_isolation.c            | 27 +++++++++++----------------
>>>    4 files changed, 16 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
>>> index c2a1bd621561..e94117101b6c 100644
>>> --- a/include/linux/page-isolation.h
>>> +++ b/include/linux/page-isolation.h
>>> @@ -32,13 +32,14 @@ static inline bool is_migrate_isolate(int migratetype)
>>>     #define MEMORY_OFFLINE	0x1
>>>    #define REPORT_FAILURE	0x2
>>> +#define CMA_ALLOCATION	0x4
>>>     void set_pageblock_migratetype(struct page *page, int migratetype);
>>>     bool move_freepages_block_isolate(struct zone *zone, struct page *page);
>>>     int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>>> -			     int migratetype, int flags, gfp_t gfp_flags);
>>> +			     int flags, gfp_t gfp_flags);
>>>     void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn);
>>>   diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>> index 4265272faf4c..fe0b71e0f307 100644
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -1993,7 +1993,6 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>>>     	/* set above range as isolated */
>>>    	ret = start_isolate_page_range(start_pfn, end_pfn,
>>> -				       MIGRATE_MOVABLE,
>>>    				       MEMORY_OFFLINE | REPORT_FAILURE,
>>>    				       GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL);
>>>    	if (ret) {
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 4d06932ba69a..c60bb95d7e65 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -6607,7 +6607,9 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
>>>    	 * put back to page allocator so that buddy can use them.
>>>    	 */
>>>   -	ret = start_isolate_page_range(start, end, migratetype, 0, gfp_mask);
>>> +	ret = start_isolate_page_range(start, end,
>>> +			migratetype == MIGRATE_CMA ? CMA_ALLOCATION : 0,
>>
>> Can we have flags for alloc_contig_range() instead of passing in a (weird) migratetype?
>>
>> Then, we should make sure that we warn if we try a CMA allocation on any pageblock that is not of type CMA.
> 
> Sure. I will expose the existing isolation flags (MEMORY_OFFLINE, REPORT_FAILURE,
> and CMA_ALLOCATION) as alloc_contig_range() parameter to replace migratetype one.
> 

Maybe we want some proper, distinct alloc_contig_range() falgs 
"acr_flags_t". Might be cleanest, to express anything that doesn't fall 
into the gfp_t flag category.

Exposing MEMORY_OFFLINE feels wrong, for example.

>>
>> I'm trying to remember what happens if we try offlining a memory region that is of type MIGRATE_CMA right now ... I remember that we fail it. We should make sure that is still the case, otherwise we could seriously break something.
> 
> Yes, that fails. That is why I added CMA_ALLOCATION, which is used in
> has_unmovable_pages() for this situation.


Ah, okay I stumbled over that but wasn't sure if it gets the job done.

thanks!

-- 
Cheers,

David / dhildenb


