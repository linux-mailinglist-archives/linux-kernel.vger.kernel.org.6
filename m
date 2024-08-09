Return-Path: <linux-kernel+bounces-280555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E67B94CC1A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811EE1C21AC7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021C118DF7B;
	Fri,  9 Aug 2024 08:23:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF2518F2D4
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723191827; cv=none; b=dzPlUNHYZvQ4K4PWdFGR6heMzxSBTi3AdRyvnJO1LGyhsTbha/UAyCqxFNaJjeKxFVmppmSB5KxoqA944AjMWiVNEhaUvuFgNslIAQucEf+i6BXKstNDZWQuxc3wRJG8Hx5EBbxAZtH2z3jbehUHM6gkhyfSEPro9Kxv17e3ymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723191827; c=relaxed/simple;
	bh=YiKK/fkhtOyBpdl2CDuKOKSV5Px8/D7d26CSCyU9bo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVcMCFLSK3fHH/zckqgriiIFiZTnaS891gfZ6T10Cj5Xx7523aThxSsrKRFNJOJguR+pP7KseOyOq3j9b81VnEdEb2yHkZQdflTD0PiyKRfQTXvrr3pJo3lOqDuiWOu7VocQPrK+q0NzTh51k5fsesJa6/oufmdY48228cwSGls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 275A5FEC;
	Fri,  9 Aug 2024 01:24:10 -0700 (PDT)
Received: from [10.57.95.64] (unknown [10.57.95.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 490C03F6A8;
	Fri,  9 Aug 2024 01:23:42 -0700 (PDT)
Message-ID: <36e8f1be-868d-4bce-8f32-e2d96b8b7af3@arm.com>
Date: Fri, 9 Aug 2024 09:23:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] mm: collect the number of anon large folios
 partially unmapped
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: chrisl@kernel.org, david@redhat.com, kaleshsingh@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, ioworker0@gmail.com,
 baolin.wang@linux.alibaba.com, ziy@nvidia.com, hanchuanhua@oppo.com,
 Barry Song <v-songbaohua@oppo.com>
References: <20240808010457.228753-1-21cnbao@gmail.com>
 <20240808010457.228753-3-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240808010457.228753-3-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/08/2024 02:04, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> When an mTHP is added to the deferred_list, its partial pages
> are unused, leading to wasted memory and potentially increasing
> memory reclamation pressure. Tracking this number indicates
> the extent to which userspace is partially unmapping mTHPs.
> 
> Detailing the specifics of how unmapping occurs is quite difficult
> and not that useful, so we adopt a simple approach: each time an
> mTHP enters the deferred_list, we increment the count by 1; whenever
> it leaves for any reason, we decrement the count by 1.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 5 +++++
>  include/linux/huge_mm.h                    | 1 +
>  mm/huge_memory.c                           | 6 ++++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 715f181543f6..5028d61cbe0c 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -532,6 +532,11 @@ anon_num
>         These huge pages could be still entirely mapped and have partially
>         unmapped and unused subpages.
>  
> +anon_num_partial_unused

Why is the user-exposed name completely different to the internal
(MTHP_STAT_NR_ANON_SPLIT_DEFERRED) name?

> +       the number of anon huge pages which have been partially unmapped
> +       we have in the whole system. These unmapped subpages are also
> +       unused and temporarily wasting memory.
> +
>  As the system ages, allocating huge pages may be expensive as the
>  system uses memory compaction to copy data around memory to free a
>  huge page for use. There are some counters in ``/proc/vmstat`` to help
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 294c348fe3cc..4b27a9797150 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -282,6 +282,7 @@ enum mthp_stat_item {
>  	MTHP_STAT_SPLIT_FAILED,
>  	MTHP_STAT_SPLIT_DEFERRED,
>  	MTHP_STAT_NR_ANON,
> +	MTHP_STAT_NR_ANON_SPLIT_DEFERRED,

So the existing MTHP_STAT_SPLIT_DEFERRED is counting all folios that were ever
put on the list, and the new MTHP_STAT_NR_ANON_SPLIT_DEFERRED is counting the
number of folios that are currently on the list?

In which case, do we need the "ANON" in the name? It's implicit for the existing
split counters that they are anon-only. That would relate it more clearly to the
existing MTHP_STAT_SPLIT_DEFERRED too?

>  	__MTHP_STAT_COUNT
>  };
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b6bc2a3791e3..6083144f9fa0 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -579,6 +579,7 @@ DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
>  DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
>  DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
>  DEFINE_MTHP_STAT_ATTR(anon_num, MTHP_STAT_NR_ANON);
> +DEFINE_MTHP_STAT_ATTR(anon_num_partial_unused, MTHP_STAT_NR_ANON_SPLIT_DEFERRED);
>  
>  static struct attribute *stats_attrs[] = {
>  	&anon_fault_alloc_attr.attr,
> @@ -593,6 +594,7 @@ static struct attribute *stats_attrs[] = {
>  	&split_failed_attr.attr,
>  	&split_deferred_attr.attr,
>  	&anon_num_attr.attr,
> +	&anon_num_partial_unused_attr.attr,
>  	NULL,
>  };
>  
> @@ -3229,6 +3231,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  		if (folio_order(folio) > 1 &&
>  		    !list_empty(&folio->_deferred_list)) {
>  			ds_queue->split_queue_len--;
> +			mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_SPLIT_DEFERRED, -1);
>  			/*
>  			 * Reinitialize page_deferred_list after removing the
>  			 * page from the split_queue, otherwise a subsequent
> @@ -3291,6 +3294,7 @@ void __folio_undo_large_rmappable(struct folio *folio)
>  	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>  	if (!list_empty(&folio->_deferred_list)) {
>  		ds_queue->split_queue_len--;
> +		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_SPLIT_DEFERRED, -1);
>  		list_del_init(&folio->_deferred_list);
>  	}
>  	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> @@ -3332,6 +3336,7 @@ void deferred_split_folio(struct folio *folio)
>  		if (folio_test_pmd_mappable(folio))
>  			count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>  		count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
> +		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_SPLIT_DEFERRED, 1);
>  		list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
>  		ds_queue->split_queue_len++;
>  #ifdef CONFIG_MEMCG
> @@ -3379,6 +3384,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  			list_move(&folio->_deferred_list, &list);
>  		} else {
>  			/* We lost race with folio_put() */
> +			mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_SPLIT_DEFERRED, -1);
>  			list_del_init(&folio->_deferred_list);
>  			ds_queue->split_queue_len--;
>  		}


