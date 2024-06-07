Return-Path: <linux-kernel+bounces-205233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 525018FF9BB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 03:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0141C20F1B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3585711718;
	Fri,  7 Jun 2024 01:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJIpfIqO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB3E12B77
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717724938; cv=none; b=f9IA26FIonuCwyD1K7V2paH2JI3Yz/RAeQds4LRtNORnsyuKVSGJ0cWsOQVsT8jZ6mxBa9jRU4c1LYDk+82YsT2jStXTv8DioztFzp99vbbK/PZliKBprsQgZeEInlXBN7lr/VfhmsvxFxG+9mAvm/eTW5IweteeypWU13+ZKGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717724938; c=relaxed/simple;
	bh=K1l9HlDunVzBW8oFuxB1m1ebZj63wgNnQ1cUX/5PTi4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lc8HpjI6CXzk5UEGuwOdwZVn2hjPugJaYROvEVbJSjoD2+D+DXDKzvGuOMLVnElFTvxMhOO2sCJf5msZsmmbzV5e/NmRkImDTbYplaq6uvWe9YBpCRr9dXDkPgc4Lp7DsdAX6Gzk0RBDqq9XFp6I8yZpIQ/uyVfOpIMo/YnPDSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJIpfIqO; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717724937; x=1749260937;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=K1l9HlDunVzBW8oFuxB1m1ebZj63wgNnQ1cUX/5PTi4=;
  b=WJIpfIqOHhcfDFkLogLCmf0cp7ZenIO83azUYpkOg25bp8qqMDf3cNw+
   QyIGhFG7XUIpnVujcZn+NbJynqqfwAnrlqaf9wfmaPylFuZNNPWt7AbcZ
   mWuMhV8yBbzmuIyLyo613xu5ZTwjFpgSnf9eGOdCFWnRNLSRGHWUfSmV1
   TgjzaJ5gCdvcL9XlMzAfPYU1Avc+Kq3AhAjrXpu1YWhHI4hbe5OBc+bm5
   iGwChIXNyEa14r40Umfcq1r8JrtikLDFQ69g/gyiwROJQgdK4fQVRMHQA
   2ReTXaeap2JB4QNaeOGxx1iKRtjbaPE4Ol5h4OLIK+Nti4+4Cji7Q8pOx
   A==;
X-CSE-ConnectionGUID: nf5zpNbJQRWY/BeHHPhP9g==
X-CSE-MsgGUID: AoE6XwlpTfKy3vc1m3L4TA==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14263399"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14263399"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 18:48:56 -0700
X-CSE-ConnectionGUID: AJDDoL3CSsmiLqmGJ3s57g==
X-CSE-MsgGUID: i2QhtHPaR5Cxya9kThcn2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38735158"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 18:48:55 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: swap: remove 'synchronous' argument to
 swap_read_folio()
In-Reply-To: <20240606210840.1650341-1-yosryahmed@google.com> (Yosry Ahmed's
	message of "Thu, 6 Jun 2024 21:08:40 +0000")
References: <20240606210840.1650341-1-yosryahmed@google.com>
Date: Fri, 07 Jun 2024 09:47:03 +0800
Message-ID: <871q598qy0.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Yosry Ahmed <yosryahmed@google.com> writes:

> swap_read_folio() reads the folio synchronously if synchronous is passed
> as true or if SWP_SYNCHRONOUS_IO is set in swap_info_struct. The only
> caller that passes synchronous=true is in do_swap_page() in the
> SWP_SYNCHRONOUS_IO case.
>
> Hence, the argument is redundant, it is only set to true when the swap
> read would have been synchronous anyway. Remove it.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

And, there's some history information in commit b243dcbf2f13 ("swap:
remove remnants of polling from read_swap_cache_async").

"
    Commit [1] introduced IO polling support duding swapin to reduce swap read
    latency for block devices that can be polled.  However later commit [2]
    removed polling support.  Therefore it seems safe to remove do_poll
    parameter in read_swap_cache_async and always call swap_readpage with
    synchronous=false waiting for IO completion in folio_lock_or_retry.
    
    [1] commit 23955622ff8d ("swap: add block io poll in swapin path")
    [2] commit 9650b453a3d4 ("block: ignore RWF_HIPRI hint for sync dio")
"

IMO, it will help people to understand the code change to add some
history information as above, or refer to the commit.

--
Best Regards,
Huang, Ying

> ---
>  mm/memory.c     |  2 +-
>  mm/page_io.c    |  6 +++---
>  mm/swap.h       |  6 ++----
>  mm/swap_state.c | 10 +++++-----
>  4 files changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index db91304882312..2b3ef08e8bb7d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4113,7 +4113,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  
>  				/* To provide entry to swap_read_folio() */
>  				folio->swap = entry;
> -				swap_read_folio(folio, true, NULL);
> +				swap_read_folio(folio, NULL);
>  				folio->private = NULL;
>  			}
>  		} else {
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 41e8d738c6d28..f1a9cfab6e748 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -493,10 +493,10 @@ static void swap_read_folio_bdev_async(struct folio *folio,
>  	submit_bio(bio);
>  }
>  
> -void swap_read_folio(struct folio *folio, bool synchronous,
> -		struct swap_iocb **plug)
> +void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
>  {
>  	struct swap_info_struct *sis = swp_swap_info(folio->swap);
> +	bool synchronous = sis->flags & SWP_SYNCHRONOUS_IO;
>  	bool workingset = folio_test_workingset(folio);
>  	unsigned long pflags;
>  	bool in_thrashing;
> @@ -521,7 +521,7 @@ void swap_read_folio(struct folio *folio, bool synchronous,
>  		folio_unlock(folio);
>  	} else if (data_race(sis->flags & SWP_FS_OPS)) {
>  		swap_read_folio_fs(folio, plug);
> -	} else if (synchronous || (sis->flags & SWP_SYNCHRONOUS_IO)) {
> +	} else if (synchronous) {
>  		swap_read_folio_bdev_sync(folio, sis);
>  	} else {
>  		swap_read_folio_bdev_async(folio, sis);
> diff --git a/mm/swap.h b/mm/swap.h
> index 2c0e96272d498..baa1fa946b347 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -11,8 +11,7 @@ struct mempolicy;
>  /* linux/mm/page_io.c */
>  int sio_pool_init(void);
>  struct swap_iocb;
> -void swap_read_folio(struct folio *folio, bool do_poll,
> -		struct swap_iocb **plug);
> +void swap_read_folio(struct folio *folio, struct swap_iocb **plug);
>  void __swap_read_unplug(struct swap_iocb *plug);
>  static inline void swap_read_unplug(struct swap_iocb *plug)
>  {
> @@ -83,8 +82,7 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
>  }
>  #else /* CONFIG_SWAP */
>  struct swap_iocb;
> -static inline void swap_read_folio(struct folio *folio, bool do_poll,
> -		struct swap_iocb **plug)
> +static inline void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
>  {
>  }
>  static inline void swap_write_unplug(struct swap_iocb *sio)
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 0803eedeabe3d..994723cef8217 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -567,7 +567,7 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  	mpol_cond_put(mpol);
>  
>  	if (page_allocated)
> -		swap_read_folio(folio, false, plug);
> +		swap_read_folio(folio, plug);
>  	return folio;
>  }
>  
> @@ -684,7 +684,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  		if (!folio)
>  			continue;
>  		if (page_allocated) {
> -			swap_read_folio(folio, false, &splug);
> +			swap_read_folio(folio, &splug);
>  			if (offset != entry_offset) {
>  				folio_set_readahead(folio);
>  				count_vm_event(SWAP_RA);
> @@ -701,7 +701,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  					&page_allocated, false);
>  	if (unlikely(page_allocated)) {
>  		zswap_folio_swapin(folio);
> -		swap_read_folio(folio, false, NULL);
> +		swap_read_folio(folio, NULL);
>  	}
>  	return folio;
>  }
> @@ -834,7 +834,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
>  		if (!folio)
>  			continue;
>  		if (page_allocated) {
> -			swap_read_folio(folio, false, &splug);
> +			swap_read_folio(folio, &splug);
>  			if (addr != vmf->address) {
>  				folio_set_readahead(folio);
>  				count_vm_event(SWAP_RA);
> @@ -853,7 +853,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
>  					&page_allocated, false);
>  	if (unlikely(page_allocated)) {
>  		zswap_folio_swapin(folio);
> -		swap_read_folio(folio, false, NULL);
> +		swap_read_folio(folio, NULL);
>  	}
>  	return folio;
>  }

