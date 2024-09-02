Return-Path: <linux-kernel+bounces-310905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD069682AD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567452836A1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58431186E4A;
	Mon,  2 Sep 2024 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFEo6NNa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCA612EBEA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268010; cv=none; b=l1KghoPgZ0B5qfjq5GAFml6Pl01KXQnXjqYIjFGqGoqr5ejor1niYxBft3thqWNa2B2ahVnwDN2DMHw/uo3d7I9KIxuCLIfzjnIle8/LQrVQPJICtZzV2jfiA1K2qMY9rHlauh5mPuiUCNRB7PAOzWodGRYwn167tPGIKC2PvEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268010; c=relaxed/simple;
	bh=K+3kjo9TRvrA/vne2CgVMWOSwM0hkIyHGpN6aN58TWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxQAl91UEGk9sKBYKuMCDN3JLKxiuaggRMb4JPYWs0lfc8RGx41CM8e+evsMw9dDQ1hE6RpUayhtrfYtYqSDOxBkJDi2URda94ibT6OdEOifyh+zNvBqeinGAv8TEQiZaaN2cIvOCGXK2fySnJXJUi+Nzik0SdQPmBHYFNAfkYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TFEo6NNa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725268007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=erTWAWvBD42Ui51I9I1W98Q+PawCGs6ApXaV5CHdeYA=;
	b=TFEo6NNasgigIlRA2R2QVPBTkjDNWZHFVqNXxDixsRyyc9dmIO7qeeBnSrWf0418GzFSEr
	YBmbpCwMY3XhveW+x51vmknFYm4V0IHqxrp8asfc4dmlsg2w+fg94pjcXQ6iKST2KqyZLt
	bEE4yFp0PK7RpbkGbZa3Lu+9GS+/4ko=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-ZR4NNlTxOjC-DRXK3nPxLQ-1; Mon, 02 Sep 2024 05:06:44 -0400
X-MC-Unique: ZR4NNlTxOjC-DRXK3nPxLQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374b35856aeso1848767f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 02:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725268003; x=1725872803;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=erTWAWvBD42Ui51I9I1W98Q+PawCGs6ApXaV5CHdeYA=;
        b=Ewrd6FP/ztEPKHZUieWQ/BsFFo5pRL2XWxcuaqHNQtFys/qxOojXqrpUe+fVulYqu9
         6SEF9KXOmU3BjqSWhZneE/nyRpRqKs0of9GqX8zLqjnZLydvPrHldlG1DePgZ9WUf2QH
         w4rNGMNQBlqjuI18aqcN3NFcmHhOkkbTQVrWo6LlUWVvKBxWkP2u5OXeCxX/t7dULRoW
         8AXaFyNrcOWuxyZqkPnH7XAtCaufHBku+pFQeZSAcOVEKxIuu03XwOanHB43iDysAKKS
         9BqGaJEm5fdLu5f59rJjUqgfHGAX9xDtG7AdwxSjCkqEZK416NsQpFlrQC/pY3H+hDlT
         5ncA==
X-Forwarded-Encrypted: i=1; AJvYcCUKWZNxAHyenb1m0ke8XbkUVRoiD1x4czv9Ep/cYf+/YB5wQVO5ouYtQ4W0/Ue+KCHD7NQROZl+Hj65AUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp9CFM4D4q5YfSES54HNivkuT+lZ6b81gIoQu0Ri631pc5Ht4M
	dPXgrsOSaiUMx7QpzTTtccBOrrc+rCyKHLOW0GeTloVwc0EorpJZ6XeY0E8lDQASyHVp0kxsx0B
	p0pPYy1nEEjBasA6ghqZLaJfp71meLu83QOWIXT6D8ag6JJR1hgI6XxJRyaCpjQ==
X-Received: by 2002:a5d:4fcb:0:b0:374:bcdc:625f with SMTP id ffacd0b85a97d-374bcdc63bamr4404793f8f.51.1725268003195;
        Mon, 02 Sep 2024 02:06:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPcikM1+8NbFnmE62X9EbEUfsfrldaU4ny3SfZ3riP351/VviEtFWwxcERC/0pY102h3tglw==
X-Received: by 2002:a5d:4fcb:0:b0:374:bcdc:625f with SMTP id ffacd0b85a97d-374bcdc63bamr4404744f8f.51.1725268002239;
        Mon, 02 Sep 2024 02:06:42 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df936dsm130351285e9.28.2024.09.02.02.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 02:06:41 -0700 (PDT)
Message-ID: <a43c866f-b281-49d3-b503-f5f86dadd306@redhat.com>
Date: Mon, 2 Sep 2024 11:06:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] mm/page_isolation: remove migratetype parameter
 from more functions.
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc: Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
References: <20240828202240.2809740-1-ziy@nvidia.com>
 <20240828202240.2809740-5-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240828202240.2809740-5-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.08.24 22:22, Zi Yan wrote:
> migratetype is no longer overwritten during pageblock isolation,
> start_isolate_page_range(), has_unmovable_pages(), and
> set_migratetype_isolate() no longer need which migratetype to restore
> during isolation failure. For has_unmoable_pages(), it needs to know if
> the isolation is for CMA allocation, so adding CMA_ALLOCATION to isolation
> flags to provide the information.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   include/linux/page-isolation.h |  3 ++-
>   mm/memory_hotplug.c            |  1 -
>   mm/page_alloc.c                |  4 +++-
>   mm/page_isolation.c            | 27 +++++++++++----------------
>   4 files changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
> index c2a1bd621561..e94117101b6c 100644
> --- a/include/linux/page-isolation.h
> +++ b/include/linux/page-isolation.h
> @@ -32,13 +32,14 @@ static inline bool is_migrate_isolate(int migratetype)
>   
>   #define MEMORY_OFFLINE	0x1
>   #define REPORT_FAILURE	0x2
> +#define CMA_ALLOCATION	0x4
>   
>   void set_pageblock_migratetype(struct page *page, int migratetype);
>   
>   bool move_freepages_block_isolate(struct zone *zone, struct page *page);
>   
>   int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
> -			     int migratetype, int flags, gfp_t gfp_flags);
> +			     int flags, gfp_t gfp_flags);
>   
>   void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn);
>   
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 4265272faf4c..fe0b71e0f307 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1993,7 +1993,6 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>   
>   	/* set above range as isolated */
>   	ret = start_isolate_page_range(start_pfn, end_pfn,
> -				       MIGRATE_MOVABLE,
>   				       MEMORY_OFFLINE | REPORT_FAILURE,
>   				       GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL);
>   	if (ret) {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4d06932ba69a..c60bb95d7e65 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6607,7 +6607,9 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
>   	 * put back to page allocator so that buddy can use them.
>   	 */
>   
> -	ret = start_isolate_page_range(start, end, migratetype, 0, gfp_mask);
> +	ret = start_isolate_page_range(start, end,
> +			migratetype == MIGRATE_CMA ? CMA_ALLOCATION : 0,

Can we have flags for alloc_contig_range() instead of passing in a 
(weird) migratetype?

Then, we should make sure that we warn if we try a CMA allocation on any 
pageblock that is not of type CMA.

I'm trying to remember what happens if we try offlining a memory region 
that is of type MIGRATE_CMA right now ... I remember that we fail it. We 
should make sure that is still the case, otherwise we could seriously 
break something.

-- 
Cheers,

David / dhildenb


