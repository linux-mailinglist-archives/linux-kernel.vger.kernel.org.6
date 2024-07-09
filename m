Return-Path: <linux-kernel+bounces-245373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F6A92B1C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98EA1C20E2F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E64615216A;
	Tue,  9 Jul 2024 08:06:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13EF1D556
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720512373; cv=none; b=beZmTdBB/Mc1b9qPK9ZeSFl7rSadnb/5ZAsM+OSxwlqC0gSj5JpYdKqdKiNKn/ycBb8eThaRVRHmrUmZE1nlQJiizRsQrbxDN1U5Y5VWfXTEQbEm/LBaFeaBJvHX/2gwLC1qeYeR2LfOpX8eMFmWwX5u+/b3iI2KSyYqka27fww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720512373; c=relaxed/simple;
	bh=VScqoB9awx4ARuy4dChXfW3btF+0/+KUXj+Mpuq/a9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpmbbJYW2P4ZN67usr+gZ+k/bv0XbjN+dbyh1U65yPudmruK4ze/+8+uIzrDUNQNI2pYXJUSxiOmGrf2EJz+znxgzbWJhgXJ9YLblUedZwIWZzc20HknzkdxkHRHZ42wFvD6/mJREFnarNdeC2maQQR//HZ/zS0ukjYCqRO/l4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EA8E139F;
	Tue,  9 Jul 2024 01:06:36 -0700 (PDT)
Received: from [10.57.76.194] (unknown [10.57.76.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50F033F762;
	Tue,  9 Jul 2024 01:06:09 -0700 (PDT)
Message-ID: <5dcfd3e6-ce76-4243-8a37-ad83f8335eda@arm.com>
Date: Tue, 9 Jul 2024 09:06:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: Extend 'usage' parameter so that
 cluster_swap_free_nr() can be reused
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: chrisl@kernel.org, david@redhat.com, hanchuanhua@oppo.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, v-songbaohua@oppo.com,
 ying.huang@intel.com
References: <20240709012122.16994-1-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240709012122.16994-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/07/2024 02:21, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Extend a usage parameter so that cluster_swap_free_nr() can be reused by
> both swapcache_clear() and swap_free().
> __swap_entry_free() is quite similar but more tricky as it requires the
> return value of __swap_entry_free_locked() which cluster_swap_free_nr()
> doesn't support.
> 
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Chuanhua Han <hanchuanhua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

LGTM!

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  mm/swapfile.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index f7224bc1320c..c097c513db02 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1352,7 +1352,8 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
>  }
>  
>  static void cluster_swap_free_nr(struct swap_info_struct *sis,
> -		unsigned long offset, int nr_pages)
> +		unsigned long offset, int nr_pages,
> +		unsigned char usage)
>  {
>  	struct swap_cluster_info *ci;
>  	DECLARE_BITMAP(to_free, BITS_PER_LONG) = { 0 };
> @@ -1362,7 +1363,7 @@ static void cluster_swap_free_nr(struct swap_info_struct *sis,
>  	while (nr_pages) {
>  		nr = min(BITS_PER_LONG, nr_pages);
>  		for (i = 0; i < nr; i++) {
> -			if (!__swap_entry_free_locked(sis, offset + i, 1))
> +			if (!__swap_entry_free_locked(sis, offset + i, usage))
>  				bitmap_set(to_free, i, 1);
>  		}
>  		if (!bitmap_empty(to_free, BITS_PER_LONG)) {
> @@ -1396,7 +1397,7 @@ void swap_free_nr(swp_entry_t entry, int nr_pages)
>  
>  	while (nr_pages) {
>  		nr = min_t(int, nr_pages, SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
> -		cluster_swap_free_nr(sis, offset, nr);
> +		cluster_swap_free_nr(sis, offset, nr, 1);
>  		offset += nr;
>  		nr_pages -= nr;
>  	}
> @@ -3492,15 +3493,9 @@ int swapcache_prepare(swp_entry_t entry)
>  
>  void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
>  {
> -	struct swap_cluster_info *ci;
>  	unsigned long offset = swp_offset(entry);
> -	unsigned char usage;
>  
> -	ci = lock_cluster_or_swap_info(si, offset);
> -	usage = __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
> -	unlock_cluster_or_swap_info(si, ci);
> -	if (!usage)
> -		free_swap_slot(entry);
> +	cluster_swap_free_nr(si, offset, 1, SWAP_HAS_CACHE);
>  }
>  
>  struct swap_info_struct *swp_swap_info(swp_entry_t entry)


