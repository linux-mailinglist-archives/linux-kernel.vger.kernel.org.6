Return-Path: <linux-kernel+bounces-235799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C5391D9CB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB500282507
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCD281AC6;
	Mon,  1 Jul 2024 08:18:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58FBF9E6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719821896; cv=none; b=nvgSpoHNcvZvQxpY/ex/4YA3wJuCJheOGCJ0UBf5UkUD0Iw6jaib08f9wx+nd3fUK+X4MTBLhFdjzXS2Y+LkrgeEVGS8xe8SwZFpKi4u6maqCVhVyN2RDyaeIWa4A3fdeTfjc61z3QXjwvPQZnthZS9YPf72H3GNk9tiH2hdr6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719821896; c=relaxed/simple;
	bh=b3UDwcDEu2LvlS8QtfJ25eHsFFyZTqOr+BJXZTmzyDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWJsO8poGuAh7poDmEpLW+Sv2ftgSYWvJgVMFrcV7FJpaMJ57Oamy4SAKPwur7vpiJAa/IdPNjqyEvcGlx0q2mpvDVJqhb8hE2wsjZkKHXeJIVXjDXTxK2roprEVifvkpHz+DCd6bjdOfik9jTdc5O1F426OKqcEHAopPcN5Ixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1A6A339;
	Mon,  1 Jul 2024 01:18:38 -0700 (PDT)
Received: from [10.57.72.41] (unknown [10.57.72.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2F703F766;
	Mon,  1 Jul 2024 01:18:11 -0700 (PDT)
Message-ID: <4516ebbe-5d88-423a-bc45-dfb1eb6adc2d@arm.com>
Date: Mon, 1 Jul 2024 09:18:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: add per-order mTHP split counters
Content-Language: en-GB
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: dj456119@gmail.com, 21cnbao@gmail.com, david@redhat.com,
 shy828301@gmail.com, ziy@nvidia.com, libang.li@antgroup.com,
 baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Mingzhe Yang <mingzhe.yang@ly.com>
References: <20240628130750.73097-1-ioworker0@gmail.com>
 <20240628130750.73097-2-ioworker0@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240628130750.73097-2-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/06/2024 14:07, Lance Yang wrote:
> Currently, the split counters in THP statistics no longer include
> PTE-mapped mTHP. Therefore, we propose introducing per-order mTHP split
> counters to monitor the frequency of mTHP splits. This will help developers
> better analyze and optimize system performance.
> 
> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
>         split
>         split_failed
>         split_deferred
> 
> Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>

LGTM!

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  include/linux/huge_mm.h |  3 +++
>  mm/huge_memory.c        | 19 ++++++++++++++-----
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 212cca384d7e..cee3c5da8f0e 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -284,6 +284,9 @@ enum mthp_stat_item {
>  	MTHP_STAT_FILE_ALLOC,
>  	MTHP_STAT_FILE_FALLBACK,
>  	MTHP_STAT_FILE_FALLBACK_CHARGE,
> +	MTHP_STAT_SPLIT,
> +	MTHP_STAT_SPLIT_FAILED,
> +	MTHP_STAT_SPLIT_DEFERRED,
>  	__MTHP_STAT_COUNT
>  };
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c7ce28f6b7f3..a633206375af 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -559,6 +559,9 @@ DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
>  DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CHARGE);
> +DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
> +DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
> +DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
>  
>  static struct attribute *stats_attrs[] = {
>  	&anon_fault_alloc_attr.attr,
> @@ -569,6 +572,9 @@ static struct attribute *stats_attrs[] = {
>  	&file_alloc_attr.attr,
>  	&file_fallback_attr.attr,
>  	&file_fallback_charge_attr.attr,
> +	&split_attr.attr,
> +	&split_failed_attr.attr,
> +	&split_deferred_attr.attr,
>  	NULL,
>  };
>  
> @@ -3068,7 +3074,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
>  	struct anon_vma *anon_vma = NULL;
>  	struct address_space *mapping = NULL;
> -	bool is_thp = folio_test_pmd_mappable(folio);
> +	int order = folio_order(folio);
>  	int extra_pins, ret;
>  	pgoff_t end;
>  	bool is_hzp;
> @@ -3076,7 +3082,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>  	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>  
> -	if (new_order >= folio_order(folio))
> +	if (new_order >= order)
>  		return -EINVAL;
>  
>  	if (folio_test_anon(folio)) {
> @@ -3253,8 +3259,9 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  		i_mmap_unlock_read(mapping);
>  out:
>  	xas_destroy(&xas);
> -	if (is_thp)
> +	if (order >= HPAGE_PMD_ORDER)
>  		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
> +	count_mthp_stat(order, !ret ? MTHP_STAT_SPLIT : MTHP_STAT_SPLIT_FAILED);
>  	return ret;
>  }
>  
> @@ -3278,13 +3285,14 @@ void deferred_split_folio(struct folio *folio)
>  #ifdef CONFIG_MEMCG
>  	struct mem_cgroup *memcg = folio_memcg(folio);
>  #endif
> +	int order = folio_order(folio);
>  	unsigned long flags;
>  
>  	/*
>  	 * Order 1 folios have no space for a deferred list, but we also
>  	 * won't waste much memory by not adding them to the deferred list.
>  	 */
> -	if (folio_order(folio) <= 1)
> +	if (order <= 1)
>  		return;
>  
>  	/*
> @@ -3305,8 +3313,9 @@ void deferred_split_folio(struct folio *folio)
>  
>  	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>  	if (list_empty(&folio->_deferred_list)) {
> -		if (folio_test_pmd_mappable(folio))
> +		if (order >= HPAGE_PMD_ORDER)
>  			count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> +		count_mthp_stat(order, MTHP_STAT_SPLIT_DEFERRED);
>  		list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
>  		ds_queue->split_queue_len++;
>  #ifdef CONFIG_MEMCG


