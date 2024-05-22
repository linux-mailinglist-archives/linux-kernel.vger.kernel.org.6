Return-Path: <linux-kernel+bounces-186329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16228CC2CE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED638281B26
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C220D13E3F4;
	Wed, 22 May 2024 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlTMNWHF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5702594
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386990; cv=none; b=fr4No0qHjtRdfRCdAKOG7ABwgAYssVSD7/LPpqqKnhkVgbtLeCBo1S7T2ZCRxu3b5aWjYRe/YvxCSNb2psoGqI1GZzlvew61L60t217xuttPTa+nTEv2Ox7cgLdkAKd2VvtgXg/OzTv8c1pk/tFtiPRElGJzHYnXpVg6NXecock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386990; c=relaxed/simple;
	bh=2uySHVU14kAyWUabLcZOAYz4UM8LnsqYK2O0tWSaVUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZedARTt2J1jnsFYnJwkfxarWAehyYhC1sRSL8KyVtrOU0fRQmfNkiK9V/Jf54Lt5WN52r7gLzRQEs02WPjzBIH9/DsB7Er4+hTHdvn9GwBMZlqzdKH8CQrYwkz/6M9EbFyLMWVrl3vrmo5Z8qnI7pPTLGzm8nsSZukSAexLQUaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlTMNWHF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716386987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZQN+UU0zMMYv5OqmbUyrKSduO0lgg1+31koqXHcCe/w=;
	b=MlTMNWHFM35zzj5OC+7Dpp4Z3PyHK9jQGOj7FLOPIzMCyubJiQcv85sd7rHxR30McdBkyY
	L52X/h4xYPqLR4fgGFO31jdm4prhJdrp7QKVHhL0d6x5oo/6fQy315tht6XCGUFv0couAj
	fndpuFnEftSLZMqOR4sjpbajfjlfEMY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-IJTO_Y-JONiFHW0cX2kB-Q-1; Wed, 22 May 2024 10:09:46 -0400
X-MC-Unique: IJTO_Y-JONiFHW0cX2kB-Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4201248bcd4so57202555e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716386985; x=1716991785;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZQN+UU0zMMYv5OqmbUyrKSduO0lgg1+31koqXHcCe/w=;
        b=S8/o+BiyMgo0S8df+8prkAWjl6x8JVk/iaCmiBw+qqibSJfkV146VV5qb9FPlUuqZz
         GoSwBHl/Wc9XY+7aiaXcbLmd7s72ESHwPEKJinPcZpktYVBlxKPQgvo7lvmboQ/aB9FN
         IrQXICpl3MwIauqq3rt9ZG3PhT1mReyj/EyU7060xKDgYdqozVyTJs7KfXrpUtGi5daJ
         /y2I/vzQAIwx1K2fFhpfeNmIMO4c5MOVqz/phnbBLKxyiF+QhEhj2tccuKIjfmgZy5mx
         yU8We1Lpzpd6lSjgHNDXz2+/b/Ft614wcAi5fFp3V2+HqhbkjAeotN79oIMmOX3uNulq
         fUZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN4XI2nAzE6sL2PwMIDca/CNH+3K8j/cIKg5ejeSUGFd9tvrDx5ifmoYgmANs1JprjbMxsiDIbbwlKyI1MDvvhMEDs1St6Fm+vJ1oh
X-Gm-Message-State: AOJu0Yy5D08py7j8zw/XhlxgXZLkcrri3mg+tTBerqXSz9YlwdktjmEa
	R7An65mmOAShISi9fvGW53qjTuBFLF3FnpGSeZE22yij+Hh738RpT43aXeEjX0ZwCBxtSQkuAl3
	+8MEaODTlOsr3p1jzewVT/R1+T11mnh0jGmnK6QWm0VBW1lj6j96fWtzeOy8+Pg==
X-Received: by 2002:a05:600c:6546:b0:41a:3868:d222 with SMTP id 5b1f17b1804b1-420fd2237b1mr19193375e9.0.1716386984787;
        Wed, 22 May 2024 07:09:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc+LTyPyxjnsDanUM70ErqH08hs0tNPvf7OxlT6Zf9PcCSZ9hu6sl7goLjfKDj9IINlfgHqg==
X-Received: by 2002:a05:600c:6546:b0:41a:3868:d222 with SMTP id 5b1f17b1804b1-420fd2237b1mr19193115e9.0.1716386984327;
        Wed, 22 May 2024 07:09:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:d500:4044:6d4c:f060:f677? (p200300cbc709d50040446d4cf060f677.dip0.t-ipconnect.de. [2003:cb:c709:d500:4044:6d4c:f060:f677])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee934csm502447885e9.38.2024.05.22.07.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 07:09:42 -0700 (PDT)
Message-ID: <78e646af-e8b5-4596-8fbf-17b139cfdddd@redhat.com>
Date: Wed, 22 May 2024 16:09:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm,memory_hotplug: Remove un-taken lock
To: Brendan Jackman <jackmanb@google.com>, Oscar Salvador
 <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Vlastimil Babka <vbabka@suse.cz>, Pavel Tatashin
 <pasha.tatashin@soleen.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240521-mm-hotplug-sync-v1-0-6d53706c1ba8@google.com>
 <20240521-mm-hotplug-sync-v1-1-6d53706c1ba8@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240521-mm-hotplug-sync-v1-1-6d53706c1ba8@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.05.24 14:57, Brendan Jackman wrote:
> It seems that [1] was acked, and the a v2 was written[2] which improved
> upon it, but got bogged down in discussion of other topics, so the
> improvements were not included. Then [1] got merged as commit
> 27cacaad16c5 ("mm,memory_hotplug: drop unneeded locking") and we ended
> up with locks that get taken for read but never for write.
> 
> So, let's remove the read locking.
> 
> Compared to Oscar's original v2[2], I have added a READ_ONCE in
> page_outside_zone_boundaries; this is a substitute for the compiler
> barrier that was implied by read_seqretry(). I believe this is necessary
> to insure against UB, although the value being read here is only used
> for a printk so the stakes seem very low (and this is all debug code
> anyway). I believe a compiler barrier is also needed in zone_spans_pfn,
> but I'll address that in a separate patch.
> 
> That read_seqretry() also impleied a CPU-level memory barrier, which I
> don't think needs replacing: page_outside_zone_boundaries() is used in
> the alloc and free paths, but you can't allocate or free pages from
> the span that is in the middle of being added/removed by hotplug.
> 
> In other words, page_outside_zone_boundaries() doesn't require a
> strictly up-to-date view of spanned_pages, but I think it does require
> a value that was once/will eventually be correct, hence READ_ONCE.
> 
> [1] https://lore.kernel.org/all/20210531093958.15021-1-osalvador@suse.de/T/#u
> [2] https://lore.kernel.org/linux-mm/20210602091457.17772-3-osalvador@suse.de/#t
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Co-developed-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>   include/linux/memory_hotplug.h | 35 -----------------------------------
>   include/linux/mmzone.h         | 23 +++++------------------
>   mm/mm_init.c                   |  1 -
>   mm/page_alloc.c                | 10 +++-------
>   4 files changed, 8 insertions(+), 61 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 7a9ff464608d..f9577e67e5ee 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -141,31 +141,7 @@ bool mhp_supports_memmap_on_memory(void);
>   
>   /*
>    * Zone resizing functions
> - *
> - * Note: any attempt to resize a zone should has pgdat_resize_lock()
> - * zone_span_writelock() both held. This ensure the size of a zone
> - * can't be changed while pgdat_resize_lock() held.
>    */
> -static inline unsigned zone_span_seqbegin(struct zone *zone)
> -{
> -	return read_seqbegin(&zone->span_seqlock);
> -}
> -static inline int zone_span_seqretry(struct zone *zone, unsigned iv)
> -{
> -	return read_seqretry(&zone->span_seqlock, iv);
> -}
> -static inline void zone_span_writelock(struct zone *zone)
> -{
> -	write_seqlock(&zone->span_seqlock);
> -}
> -static inline void zone_span_writeunlock(struct zone *zone)
> -{
> -	write_sequnlock(&zone->span_seqlock);
> -}
> -static inline void zone_seqlock_init(struct zone *zone)
> -{
> -	seqlock_init(&zone->span_seqlock);
> -}
>   extern void adjust_present_page_count(struct page *page,
>   				      struct memory_group *group,
>   				      long nr_pages);
> @@ -251,17 +227,6 @@ static inline void pgdat_kswapd_lock_init(pg_data_t *pgdat)
>   	___page;				\
>    })
>   
> -static inline unsigned zone_span_seqbegin(struct zone *zone)
> -{
> -	return 0;
> -}
> -static inline int zone_span_seqretry(struct zone *zone, unsigned iv)
> -{
> -	return 0;
> -}
> -static inline void zone_span_writelock(struct zone *zone) {}
> -static inline void zone_span_writeunlock(struct zone *zone) {}
> -static inline void zone_seqlock_init(struct zone *zone) {}
>   
>   static inline int try_online_node(int nid)
>   {
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 8f9c9590a42c..194ef7fed9d6 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -14,7 +14,6 @@
>   #include <linux/threads.h>
>   #include <linux/numa.h>
>   #include <linux/init.h>
> -#include <linux/seqlock.h>
>   #include <linux/nodemask.h>
>   #include <linux/pageblock-flags.h>
>   #include <linux/page-flags-layout.h>
> @@ -896,18 +895,11 @@ struct zone {
>   	 *
>   	 * Locking rules:
>   	 *
> -	 * zone_start_pfn and spanned_pages are protected by span_seqlock.
> -	 * It is a seqlock because it has to be read outside of zone->lock,
> -	 * and it is done in the main allocator path.  But, it is written
> -	 * quite infrequently.
> -	 *
> -	 * The span_seq lock is declared along with zone->lock because it is
> -	 * frequently read in proximity to zone->lock.  It's good to
> -	 * give them a chance of being in the same cacheline.
> -	 *
> -	 * Write access to present_pages at runtime should be protected by
> -	 * mem_hotplug_begin/done(). Any reader who can't tolerant drift of
> -	 * present_pages should use get_online_mems() to get a stable value.
> +	 * Besides system initialization functions, memory-hotplug is the only
> +	 * user that can change zone's {spanned,present} pages at runtime, and
> +	 * it does so by holding the mem_hotplug_lock lock. Any readers who
> +	 * can't tolerate drift values should use {get,put}_online_mems to get
> +	 * a stable value.
>   	 */
>   	atomic_long_t		managed_pages;
>   	unsigned long		spanned_pages;
> @@ -930,11 +922,6 @@ struct zone {
>   	unsigned long		nr_isolate_pageblock;
>   #endif
>   
> -#ifdef CONFIG_MEMORY_HOTPLUG
> -	/* see spanned/present_pages for more description */
> -	seqlock_t		span_seqlock;
> -#endif
> -
>   	int initialized;
>   
>   	/* Write-intensive fields used from the page allocator */
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index f72b852bd5b8..c725618aeb58 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1383,7 +1383,6 @@ static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx,
>   	zone->name = zone_names[idx];
>   	zone->zone_pgdat = NODE_DATA(nid);
>   	spin_lock_init(&zone->lock);
> -	zone_seqlock_init(zone);
>   	zone_pcp_init(zone);
>   }
>   
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2e22ce5675ca..5116a2b9ea6e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -426,16 +426,12 @@ void set_pageblock_migratetype(struct page *page, int migratetype)
>   static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
>   {
>   	int ret;
> -	unsigned seq;
>   	unsigned long pfn = page_to_pfn(page);
>   	unsigned long sp, start_pfn;
>   
> -	do {
> -		seq = zone_span_seqbegin(zone);
> -		start_pfn = zone->zone_start_pfn;
> -		sp = zone->spanned_pages;
> -		ret = !zone_spans_pfn(zone, pfn);
> -	} while (zone_span_seqretry(zone, seq));
> +	start_pfn = zone->zone_start_pfn;
> +	sp = READ_ONCE(zone->spanned_pages);
> +	ret = !zone_spans_pfn(zone, pfn);


The old seqlock guaranteed that we would have obtained consistent values 
here. start + spanned_pages defines a range. For example, growing a zone 
to the beginning implies that both ranges must be changed.

I do wonder if it might be better to instead have zone->zone_start_pfn 
and zone->zone_end_pfn. That way, both can be changed individually, not 
requiring adjustment of both to grow/shrink a zone at the beginning.

Then, using READ_ONCE() on both might actually make sense ...

-- 
Cheers,

David / dhildenb


