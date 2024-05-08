Return-Path: <linux-kernel+bounces-172819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5558BF727
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1564A2848F8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912042BD00;
	Wed,  8 May 2024 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S935Zaqs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562FF17C8D
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715153868; cv=none; b=D2Tp4zXx7z4w1GB+WjsJPPtM/ycXVel3DW/Fr/hnC1kxmYXK5aIAcPPDTCY+r2RrRKlOfgutt8FGDxcvV9ap3tmqrShhcTbiWv0FbHncWxO9W0lvXmWPVbvoieCknsNkKkFPvbQL0p8G9n8RSsr4u/Soz29snhFPlYuDVpIooCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715153868; c=relaxed/simple;
	bh=7kK1OGyMIdX7Apf6Ja0H+cg76QDS3Hw4FvN28t5kLy8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pyoxv+7leCIWKQwFFU39ssyzsK5kcA2BH0CWA76q7KIaPIS0PdHxC/Ns+5a+x084Co769B4Fg2UFyXgGOXUkjaCpqXhe+HzMchzO/wPyCdoFgbuY4Dy4ZEh0GwLkiw0qERDWDxwpOwz+heizewQt/6mp7o+aB+ppCpAXguJ5oo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S935Zaqs; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715153868; x=1746689868;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=7kK1OGyMIdX7Apf6Ja0H+cg76QDS3Hw4FvN28t5kLy8=;
  b=S935ZaqsqNemhCHZ8d6YU352XHL4vihvFFiAauLXaugLi1svXZKRqT9g
   i1NCs5oRSLHLBgaCkl7aTPiWhCPXmV0RkUaQq82LsR9CzhjEJmvRfTRSh
   A+RgyPKXqsXWeP1pQVZWSn2y1wYaKktk8dh8jZnkSxYWiiK/HbBhBIPaB
   V6VoMH40vN1h088mr1WQCJvoshBnZVmomGLH3MchaiFGl14HujlTrERvq
   UOrAMNYKaTF2xNcR3wWa/p7CIikx0NUDdEZEzW5Szql3Lnx08G6gaQA43
   23Pgys6MGcytpmkUwVPc3WOkdFsM1ngnPKTthYJhY+4/yKhEWyvQbacMf
   Q==;
X-CSE-ConnectionGUID: Y+5p9PJHREeni57i/1jLvw==
X-CSE-MsgGUID: nq6uwVa1Rg24j7hPW5IYPA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="21596327"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="21596327"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 00:37:47 -0700
X-CSE-ConnectionGUID: wPLR2/CiQuaJotSJBX2cMw==
X-CSE-MsgGUID: Zebk5gcESHmin/TaV87uCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="59651920"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 00:37:42 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,
  baolin.wang@linux.alibaba.com,  chrisl@kernel.org,  david@redhat.com,
  hanchuanhua@oppo.com,  hannes@cmpxchg.org,  hughd@google.com,
  kasong@tencent.com,  linux-kernel@vger.kernel.org,  ryan.roberts@arm.com,
  surenb@google.com,  v-songbaohua@oppo.com,  willy@infradead.org,
  xiang@kernel.org,  yosryahmed@google.com,  yuzhao@google.com,
  ziy@nvidia.com
Subject: Re: [PATCH v3 1/6] mm: swap: introduce swap_free_nr() for batched
 swap_free()
In-Reply-To: <20240503005023.174597-2-21cnbao@gmail.com> (Barry Song's message
	of "Fri, 3 May 2024 12:50:18 +1200")
References: <20240503005023.174597-1-21cnbao@gmail.com>
	<20240503005023.174597-2-21cnbao@gmail.com>
Date: Wed, 08 May 2024 15:35:49 +0800
Message-ID: <8734qskb6y.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Barry Song <21cnbao@gmail.com> writes:

> From: Chuanhua Han <hanchuanhua@oppo.com>
>
> While swapping in a large folio, we need to free swaps related to the whole
> folio. To avoid frequently acquiring and releasing swap locks, it is better
> to introduce an API for batched free.
> Furthermore, this new function, swap_free_nr(), is designed to efficiently
> handle various scenarios for releasing a specified number, nr, of swap
> entries.
>
> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  include/linux/swap.h |  5 +++++
>  mm/swapfile.c        | 47 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 11c53692f65f..d1d35e92d7e9 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -483,6 +483,7 @@ extern void swap_shmem_alloc(swp_entry_t);
>  extern int swap_duplicate(swp_entry_t);
>  extern int swapcache_prepare(swp_entry_t);
>  extern void swap_free(swp_entry_t);
> +extern void swap_free_nr(swp_entry_t entry, int nr_pages);
>  extern void swapcache_free_entries(swp_entry_t *entries, int n);
>  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
>  int swap_type_of(dev_t device, sector_t offset);
> @@ -564,6 +565,10 @@ static inline void swap_free(swp_entry_t swp)
>  {
>  }
>  
> +static inline void swap_free_nr(swp_entry_t entry, int nr_pages)
> +{
> +}
> +
>  static inline void put_swap_folio(struct folio *folio, swp_entry_t swp)
>  {
>  }
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index f6ca215fb92f..ec12f2b9d229 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1356,6 +1356,53 @@ void swap_free(swp_entry_t entry)
>  		__swap_entry_free(p, entry);
>  }
>  
> +static void cluster_swap_free_nr(struct swap_info_struct *sis,
> +		unsigned long offset, int nr_pages)
> +{
> +	struct swap_cluster_info *ci;
> +	DECLARE_BITMAP(to_free, BITS_PER_LONG) = { 0 };
> +	int i, nr;
> +
> +	ci = lock_cluster_or_swap_info(sis, offset);
> +	while (nr_pages) {
> +		nr = min(BITS_PER_LONG, nr_pages);
> +		for (i = 0; i < nr; i++) {
> +			if (!__swap_entry_free_locked(sis, offset + i, 1))
> +				bitmap_set(to_free, i, 1);
> +		}
> +		if (!bitmap_empty(to_free, BITS_PER_LONG)) {
> +			unlock_cluster_or_swap_info(sis, ci);
> +			for_each_set_bit(i, to_free, BITS_PER_LONG)
> +				free_swap_slot(swp_entry(sis->type, offset + i));
> +			if (nr == nr_pages)
> +				return;
> +			bitmap_clear(to_free, 0, BITS_PER_LONG);
> +			ci = lock_cluster_or_swap_info(sis, offset);
> +		}
> +		offset += nr;
> +		nr_pages -= nr;
> +	}
> +	unlock_cluster_or_swap_info(sis, ci);
> +}
> +
> +void swap_free_nr(swp_entry_t entry, int nr_pages)
> +{
> +	int nr;
> +	struct swap_info_struct *sis;
> +	unsigned long offset = swp_offset(entry);
> +
> +	sis = _swap_info_get(entry);
> +	if (!sis)
> +		return;
> +
> +	while (nr_pages) {
> +		nr = min_t(int, nr_pages, SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
> +		cluster_swap_free_nr(sis, offset, nr);
> +		offset += nr;
> +		nr_pages -= nr;
> +	}
> +}
> +
>  /*
>   * Called after dropping swapcache to decrease refcnt to swap entries.
>   */

