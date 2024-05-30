Return-Path: <linux-kernel+bounces-195369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0688D4BAC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472F11F247CA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C05C18306A;
	Thu, 30 May 2024 12:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="TMO/WNGJ"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B706D183065
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717072047; cv=none; b=UjFXHtzFDmS7I4/LQi84c+PlwAl+i/Hx4e229cxrJfx8ctObPYcMpTJj/3OPMGpdYag74QrdDvf/3q0K0qLUZPL0qXULWCx044ssWPqIDSZNbiXE0bH155YlY7jAODxH7ESRfnTO0HflcyFiaEyktJBjcudFN7DQjM3Al5g5l3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717072047; c=relaxed/simple;
	bh=s2MzHpnhok7C0WmPbB7z2wtnx8hS5za797cfGItdUaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IH7yeLQ9+c2BmhYARH7VlLZqeaaKNThW7w39uETJMPLreL1tMKcflHRO4ABcKl4QDn3s3OqkKzv3Hv1la3vQf+8jCTOU5pE2gNbU+xAjWJmPSrib+2phIhT4pzF5AFQgC8gktM6vido4A6KioixrjLGsDAzfjJ1liNK84/iKkvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=TMO/WNGJ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-794ab12341aso84756185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 05:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1717072041; x=1717676841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VgMssebry1DXQ8EKvNTlkNQ+MlNGgogW9+pAb9Ernn0=;
        b=TMO/WNGJCFJ/Hg+4WY+a9/PrVSa38E6riBJ3VWglgaXXHjQcX66rLL6ysM8sLOPRs8
         B9byfDY30DsZXrIy3Iff/Zgtr5DgMRmgTR/nOkot+14wSIbujB7AXSdBhEy6ut5EKigY
         TQrabJsLyChtFixY7JyU14K17rf5aGvzHW7rxr3oMx13eWNiSy4I3PiYBOJb9VgGRNos
         TdxpVxmcxuYBmuP09gbc0AA3NIQfE65kAyaMgKnGH4jOwHA9V6Fc+Hwy/HmAfFDs4XEj
         nsXBkYPPPltnJ46l7qRWLwqUsFM/GHRFE1fNCQiUghUSv/4cKeCA7g7adIHmLEw6F7J/
         EiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717072041; x=1717676841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgMssebry1DXQ8EKvNTlkNQ+MlNGgogW9+pAb9Ernn0=;
        b=RTtQpwGWiiAwy23PB3Jl7sSCV8I+TazVQ6KCcSdC3xszI4jC/24ofox1TiLrTNV8QT
         5BN2gWHEx1cko8JfRTOLbcvgyWYwmbWiA2YGZoXu+ZFEYMU06Pw9xrRhavdYzruRuQCd
         y930rLFsVLj/8ng7en2D9ERFA56c7ahx7+u8TxvemSf6lKmcITIXZVAOt389BmzCu40l
         58hVPkYP/7LN7IKERj7k/bG9ej8vOEUwXNly/GMY+u1TJz4TUh3pIbs0tALTBqCD3lW2
         RKT7anSI6Z8VryYDgZS2SQnXqWEE8f4KN0tg+Ndj2BSvrGpghYgxDCyOMmG/7DABK99T
         Sr/w==
X-Forwarded-Encrypted: i=1; AJvYcCWGyUmIqiiSRj9Ee1Fd/uz2HJAp44utT2PET/CZdIpV41LzQicYRA3joVBUWUu+wlGsJ2Snt7x+hd+sjpKl+7T0AQmOpPCu3sU0Z0zJ
X-Gm-Message-State: AOJu0YwHzFw34u5Gu9jgFWvA0SG0nvyDuEREc8mtn3nOc3vXnREic58V
	64YdP0N0Yk/OZWu7ZCMMdyUg8EO858WC9/ptM2gWzhpZbSaW8UmAbKVOk/H1H/0=
X-Google-Smtp-Source: AGHT+IElFZU6HnNo29DXJa73bSHcFab+k0X03IXmJRIDhZYMeYhrS2+Gs/TA2o7ZAoHJXOgA1i+7Vw==
X-Received: by 2002:a05:620a:4586:b0:790:efef:af55 with SMTP id af79cd13be357-794eaeb13bfmr294600185a.3.1717072041303;
        Thu, 30 May 2024 05:27:21 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd303c1sm550977685a.101.2024.05.30.05.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 05:27:20 -0700 (PDT)
Date: Thu, 30 May 2024 08:27:15 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, yosryahmed@google.com, nphamcs@gmail.com,
	chengming.zhou@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Hugh Dickins <hughd@google.com>, Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 1/2] mm: store zero pages to be swapped out in a bitmap
Message-ID: <20240530122715.GB1222079@cmpxchg.org>
References: <20240530102126.357438-1-usamaarif642@gmail.com>
 <20240530102126.357438-2-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530102126.357438-2-usamaarif642@gmail.com>

On Thu, May 30, 2024 at 11:19:07AM +0100, Usama Arif wrote:
> Approximately 10-20% of pages to be swapped out are zero pages [1].
> Rather than reading/writing these pages to flash resulting
> in increased I/O and flash wear, a bitmap can be used to mark these
> pages as zero at write time, and the pages can be filled at
> read time if the bit corresponding to the page is set.
> With this patch, NVMe writes in Meta server fleet decreased
> by almost 10% with conventional swap setup (zswap disabled).
> 
> [1]https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

This is awesome.

> ---
>  include/linux/swap.h |  1 +
>  mm/page_io.c         | 86 ++++++++++++++++++++++++++++++++++++++++++--
>  mm/swapfile.c        | 10 ++++++
>  3 files changed, 95 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index a11c75e897ec..e88563978441 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -299,6 +299,7 @@ struct swap_info_struct {
>  	signed char	type;		/* strange name for an index */
>  	unsigned int	max;		/* extent of the swap_map */
>  	unsigned char *swap_map;	/* vmalloc'ed array of usage counts */
> +	unsigned long *zeromap;		/* vmalloc'ed bitmap to track zero pages */

One bit per swap slot, so 1 / (4096 * 8) = 0.003% static memory
overhead for configured swap space. That seems reasonable for what
appears to be a fairly universal 10% reduction in swap IO.

An alternative implementation would be to reserve a bit in
swap_map. This would be no overhead at idle, but would force
continuation counts earlier on heavily shared page tables, and AFAICS
would get complicated in terms of locking, whereas this one is pretty
simple (atomic ops protect the map, swapcache lock protects the bit).

So I prefer this version. But a few comments below:

>  	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
>  	struct swap_cluster_list free_clusters; /* free clusters list */
>  	unsigned int lowest_bit;	/* index of first free in swap_map */
> diff --git a/mm/page_io.c b/mm/page_io.c
> index a360857cf75d..ab043b4ad577 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -172,6 +172,77 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
>  	goto out;
>  }
>  
> +static bool is_folio_page_zero_filled(struct folio *folio, int i)
> +{
> +	unsigned long *page;
> +	unsigned int pos;
> +	bool ret = false;
> +
> +	page = kmap_local_folio(folio, i * PAGE_SIZE);
> +	for (pos = 0; pos < PAGE_SIZE / sizeof(*page); pos++) {
> +		if (page[pos] != 0)
> +			goto out;
> +	}
> +	ret = true;
> +out:
> +	kunmap_local(page);
> +	return ret;
> +}
> +
> +static bool is_folio_zero_filled(struct folio *folio)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < folio_nr_pages(folio); i++) {
> +		if (!is_folio_page_zero_filled(folio, i))
> +			return false;
> +	}
> +	return true;
> +}
> +
> +static void folio_page_zero_fill(struct folio *folio, int i)
> +{
> +	unsigned long *page;
> +
> +	page = kmap_local_folio(folio, i * PAGE_SIZE);
> +	memset_l(page, 0, PAGE_SIZE / sizeof(unsigned long));
> +	kunmap_local(page);
> +}
> +
> +static void folio_zero_fill(struct folio *folio)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < folio_nr_pages(folio); i++)
> +		folio_page_zero_fill(folio, i);
> +}
> +
> +static void swap_zeromap_folio_set(struct folio *folio)
> +{
> +	struct swap_info_struct *sis = swp_swap_info(folio->swap);
> +	swp_entry_t entry;
> +	unsigned int i;
> +
> +	for (i = 0; i < folio_nr_pages(folio); i++) {
> +		entry = page_swap_entry(folio_page(folio, i));
> +		bitmap_set(sis->zeromap, swp_offset(entry), 1);

This should be set_bit(). bitmap_set() isn't atomic, so it would
corrupt the map on concurrent swapping of other zero pages. And you
don't need a range op here anyway.

> +	}
> +}
> +
> +static bool swap_zeromap_folio_test(struct folio *folio)
> +{
> +	struct swap_info_struct *sis = swp_swap_info(folio->swap);
> +	swp_entry_t entry;
> +	unsigned int i;
> +
> +	for (i = 0; i < folio_nr_pages(folio); i++) {
> +		entry = page_swap_entry(folio_page(folio, i));
> +		if (!test_bit(swp_offset(entry), sis->zeromap))
> +			return false;
> +	}
> +	return true;
> +}
> +
>  /*
>   * We may have stale swap cache pages in memory: notice
>   * them here and get rid of the unnecessary final write.
> @@ -195,6 +266,14 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
>  		folio_unlock(folio);
>  		return ret;
>  	}
> +
> +	if (is_folio_zero_filled(folio)) {
> +		swap_zeromap_folio_set(folio);
> +		folio_start_writeback(folio);
> +		folio_unlock(folio);
> +		folio_end_writeback(folio);
> +		return 0;
> +	}

You need to clear the zeromap bit in the else branch.

Userspace can change the contents of a swapcached page, which
redirties the page and forces an overwrite of the slot when the page
is reclaimed again.

So if the page goes from zeroes to something else and then gets
reclaimed again, a subsequent swapin would read the stale zeroes.

>  	if (zswap_store(folio)) {
>  		folio_start_writeback(folio);
>  		folio_unlock(folio);
> @@ -515,8 +594,11 @@ void swap_read_folio(struct folio *folio, bool synchronous,
>  		psi_memstall_enter(&pflags);
>  	}
>  	delayacct_swapin_start();
> -
> -	if (zswap_load(folio)) {
> +	if (swap_zeromap_folio_test(folio)) {
> +		folio_zero_fill(folio);
> +		folio_mark_uptodate(folio);
> +		folio_unlock(folio);
> +	} else if (zswap_load(folio)) {
>  		folio_mark_uptodate(folio);
>  		folio_unlock(folio);
>  	} else if (data_race(sis->flags & SWP_FS_OPS)) {
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index f1e559e216bd..3f00a1cce5ba 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -461,6 +461,7 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
>  	 */
>  	memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>  			SWAP_MAP_BAD, SWAPFILE_CLUSTER);
> +	bitmap_clear(si->zeromap, idx * SWAPFILE_CLUSTER, SWAPFILE_CLUSTER);

AFAICS this needs to be atomic as well. The swap_info and cluster are
locked, which stabilizes si->swap_map, but zeromap can see updates
from concurrent swap_writepage() and swap_read_folio() on other slots.

I think you need to use a loop over clear_bit(). Please also add a
comment with the above.

>  
>  	cluster_list_add_tail(&si->discard_clusters, si->cluster_info, idx);
>  
> @@ -498,6 +499,7 @@ static void swap_do_scheduled_discard(struct swap_info_struct *si)
>  		__free_cluster(si, idx);
>  		memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>  				0, SWAPFILE_CLUSTER);
> +		bitmap_clear(si->zeromap, idx * SWAPFILE_CLUSTER, SWAPFILE_CLUSTER);

Same.

>  		unlock_cluster(ci);
>  	}
>  }
> @@ -1336,6 +1338,7 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
>  	count = p->swap_map[offset];
>  	VM_BUG_ON(count != SWAP_HAS_CACHE);
>  	p->swap_map[offset] = 0;
> +	bitmap_clear(p->zeromap, offset, 1);

This too needs to be atomic, IOW clear_bit().

Otherwise this looks good to me.

>  	dec_cluster_info_page(p, p->cluster_info, offset);
>  	unlock_cluster(ci);
>  
> @@ -2597,6 +2600,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  	free_percpu(p->cluster_next_cpu);
>  	p->cluster_next_cpu = NULL;
>  	vfree(swap_map);
> +	bitmap_free(p->zeromap);
>  	kvfree(cluster_info);
>  	/* Destroy swap account information */
>  	swap_cgroup_swapoff(p->type);
> @@ -3123,6 +3127,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  		goto bad_swap_unlock_inode;
>  	}
>  
> +	p->zeromap = bitmap_zalloc(maxpages, GFP_KERNEL);
> +	if (!p->zeromap) {
> +		error = -ENOMEM;
> +		goto bad_swap_unlock_inode;
> +	}
> +
>  	if (p->bdev && bdev_stable_writes(p->bdev))
>  		p->flags |= SWP_STABLE_WRITES;
>  
> -- 
> 2.43.0

