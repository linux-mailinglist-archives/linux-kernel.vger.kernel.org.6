Return-Path: <linux-kernel+bounces-232657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9DA91AC6F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA391F2274E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19646199391;
	Thu, 27 Jun 2024 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="X+kfsUQR"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1CE197A65
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505142; cv=none; b=boVhUPTxcELPLLsBYYw3OSRGK5u6NtA5/NhPr8L3GEncOpgAZkOpB6iLkMka1MUZn51huIMF2ZNg2VHqxbuFHzSkyKT0hHp6AZeSxmO6LpD32I1pZ8d5ewm5WCUBQ9SmkfScQ4/xCZYCMAXm9dK0GymZVgowhKGNcXFoLYAvgNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505142; c=relaxed/simple;
	bh=pLp9NErnxrcz8imxGj6YMLJ55opv8kQ5D7YmgzbdigE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oh4h+tNz2ad8V+1b7LStsetYmS3y37hCQ3udmNdFsPmk0IpAJ3jtekSiSmiZZ7jlkhHelLOZ4eA67QyAuPXIYwcbDXu8NbAeI1qhi3cRtPNQ/9hp7nElmkwOfhbip93WFzt6H9QGOvaHjCzKIazJbmNCoo5C1LQ6MYCSM5cdKtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=X+kfsUQR; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79d5d14fa8bso69492085a.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1719505138; x=1720109938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O7FVo5HpSfwEv2hYMANEqIL76iocT4x+eD/q02M8eV4=;
        b=X+kfsUQRvA4pg6KWEym2K+6/kJGYnDSr5LFnm8gAZTWhM5d/dswhmrVW19XIUOQC83
         YF7fCbTw7EgPbcwszk3oJr07usE8WDZgKq+W2vQbZ0+ibTvDnM8xxbahKML+ygmH0OuX
         EhEQVgnfBMIRg8bB0dMY2fooCHmUMntO9cZWJmdnw3P+QmJc2SsP1sRnwrlwV33YPUbU
         n+FbuKw0HauPk0yH+eq2k6KcTWXrV4b6VabU75Oliz1LzuUda6NT9xVUjqBsqvxaQtRc
         f6y5jtI18XZdjCBdz2G/SFmmtUX4srzwT8wErzmNc2+BiHZ0UVcLe1CcNSt6z4vLyyR4
         9PyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719505138; x=1720109938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7FVo5HpSfwEv2hYMANEqIL76iocT4x+eD/q02M8eV4=;
        b=V/R8wVBlLCYTocTfpd7SdaTlVAfpFcT3HddFdhpjWhoDQwPKtkEoE1SaxUdg0X4Gah
         SaOikIeHfgfmD0IA7WPN1Ij8S0iLI+c3FramQQnTHArIshKD4AJpsBnpaMKVXy6u+BYN
         TcAbBkVoPkvqa0YOxMdi2aUrkG98mjDei0T6U4O68eEJwaLx1GVuT1ZVBfkN5zcLTOPJ
         hlnLk4oQbGKgnq0UY1gjlDeNEq6Wjyc5QluHwHiQc1Ty8Fn1E1HqrmwWf6EDlZQdAyIL
         s3mUta87swwArVLqxxnUXpdSV3s3QlseY+hdlPweMPrS69odsN4eS9BVCk+9KyVJvPKY
         rQVA==
X-Forwarded-Encrypted: i=1; AJvYcCXbZAZnZ0L1v6bSAA+atzbXuGTCDw/GyWNgB9/3qd+nD1xdbXufyq6T6xG8B0yC14Mr5QSB3BalgFR9cVePSno7k1luKHn/Md09eKjH
X-Gm-Message-State: AOJu0YzsygrGINDDTvGKseL1ulhidkV/qmcxm2FV4P0fPgftnDjAVqxJ
	DheqXcQgpU8z+d6SK1nyOp5L72ahmcY9DP5uA/WjaxD95IDs3wxmp8JK61Cgwa4=
X-Google-Smtp-Source: AGHT+IEt2rugRoeVt7UaZce69jY4aS+O51iQgv/urf5rviUlkJZXNrtVZ33N0ME4mRKC9LlnAsT1XA==
X-Received: by 2002:a05:620a:22c:b0:79b:a8df:7829 with SMTP id af79cd13be357-79d5cffa5f2mr330503185a.14.1719505137718;
        Thu, 27 Jun 2024 09:18:57 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d5c8baca1sm67991585a.113.2024.06.27.09.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 09:18:57 -0700 (PDT)
Date: Thu, 27 Jun 2024 12:18:52 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, shakeel.butt@linux.dev, david@redhat.com,
	ying.huang@intel.com, hughd@google.com, willy@infradead.org,
	yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v7 1/2] mm: store zero pages to be swapped out in a bitmap
Message-ID: <20240627161852.GA469122@cmpxchg.org>
References: <20240627105730.3110705-1-usamaarif642@gmail.com>
 <20240627105730.3110705-2-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627105730.3110705-2-usamaarif642@gmail.com>

Hi Usama,

On Thu, Jun 27, 2024 at 11:55:29AM +0100, Usama Arif wrote:
> Approximately 10-20% of pages to be swapped out are zero pages [1].
> Rather than reading/writing these pages to flash resulting
> in increased I/O and flash wear, a bitmap can be used to mark these
> pages as zero at write time, and the pages can be filled at
> read time if the bit corresponding to the page is set.
> With this patch, NVMe writes in Meta server fleet decreased
> by almost 10% with conventional swap setup (zswap disabled).
> 
> [1] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

This looks great to me, and the numbers speak for themselves. A few
minor comments below:

> ---
>  include/linux/swap.h |   1 +
>  mm/page_io.c         | 113 ++++++++++++++++++++++++++++++++++++++++++-
>  mm/swapfile.c        |  20 ++++++++
>  3 files changed, 133 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 3df75d62a835..ed03d421febd 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -299,6 +299,7 @@ struct swap_info_struct {
>  	signed char	type;		/* strange name for an index */
>  	unsigned int	max;		/* extent of the swap_map */
>  	unsigned char *swap_map;	/* vmalloc'ed array of usage counts */
> +	unsigned long *zeromap;		/* vmalloc'ed bitmap to track zero pages */
>  	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
>  	struct swap_cluster_list free_clusters; /* free clusters list */
>  	unsigned int lowest_bit;	/* index of first free in swap_map */
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 6c1c1828bb88..480b8f221d90 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -172,6 +172,88 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
>  	goto out;
>  }
>  

It might be good to have a short comment that gives 1) an overview,
that we're using a bitmap to avoid doing IO for zero-filled pages and
2) the locking, that the bits are protected by the locked swapcache
folio and atomic updates are used to protect against RMW corruption
due to other zero swap entries seeing concurrent updates.

> +static bool is_folio_page_zero_filled(struct folio *folio, int i)
> +{
> +	unsigned long *data;
> +	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*data) - 1;
> +	bool ret = false;
> +
> +	data = kmap_local_folio(folio, i * PAGE_SIZE);
> +	if (data[last_pos])
> +		goto out;

This shortcut is interesting. It's what zswap does, for which git
blame finds a commit with test results:

commit 62bf1258ec90554c3c0925951149cfe4b67a3e98
Author: Taejoon Song <taejoon.song@lge.com>
Date:   Mon Feb 6 04:00:36 2023 +0900

    mm/zswap: try to avoid worst-case scenario on same element pages
    
    The worst-case scenario on finding same element pages is that almost all
    elements are same at the first glance but only last few elements are
    different.
    
    Since the same element tends to be grouped from the beginning of the
    pages, if we check the first element with the last element before looping
    through all elements, we might have some chances to quickly detect
    non-same element pages.
    
    1. Test is done under LG webOS TV (64-bit arch)
    2. Dump the swap-out pages (~819200 pages)
    3. Analyze the pages with simple test script which counts the iteration
       number and measures the speed at off-line
    
    Under 64-bit arch, the worst iteration count is PAGE_SIZE / 8 bytes = 512.
    The speed is based on the time to consume page_same_filled() function
    only.  The result, on average, is listed as below:
    
                                       Num of Iter    Speed(MB/s)
    Looping-Forward (Orig)                 38            99265
    Looping-Backward                       36           102725
    Last-element-check (This Patch)        33           125072
    
    The result shows that the average iteration count decreases by 13% and the
    speed increases by 25% with this patch.  This patch does not increase the
    overall time complexity, though.
    
    I also ran simpler version which uses backward loop.  Just looping
    backward also makes some improvement, but less than this patch.
    
    A similar change has already been made to zram in 90f82cbfe502 ("zram: try
    to avoid worst-case scenario on same element pages").

Since you add it here, and then delete the zswap code in the next
patch, this link to the justification will be lost.

Can you please add a short comment that explains that this is a
measure to avoid worst-case behavior for tail-filled pages, which are
common in real life workloads?

> +	for (pos = 0; pos < PAGE_SIZE / sizeof(*data); pos++) {
> +		if (data[pos])
> +			goto out;
> +	}
> +	ret = true;
> +out:
> +	kunmap_local(data);
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

I think these two functions can be merged. It's less code and fewer
similar-sounding names in the namespace.

> +static void folio_zero_fill(struct folio *folio)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < folio_nr_pages(folio); i++)
> +		clear_highpage(folio_page(folio, i));
> +}

Should this be in highmem.h next to the other folio_zero_* functions?

> +static void swap_zeromap_folio_set(struct folio *folio)
> +{
> +	struct swap_info_struct *sis = swp_swap_info(folio->swap);
> +	swp_entry_t entry;
> +	unsigned int i;
> +
> +	for (i = 0; i < folio_nr_pages(folio); i++) {
> +		entry = page_swap_entry(folio_page(folio, i));
> +		set_bit(swp_offset(entry), sis->zeromap);
> +	}
> +}
> +
> +static void swap_zeromap_folio_clear(struct folio *folio)
> +{
> +	struct swap_info_struct *sis = swp_swap_info(folio->swap);
> +	swp_entry_t entry;
> +	unsigned int i;
> +
> +	for (i = 0; i < folio_nr_pages(folio); i++) {
> +		entry = page_swap_entry(folio_page(folio, i));
> +		clear_bit(swp_offset(entry), sis->zeromap);
> +	}
> +}
> +
> +/*
> + * Return the index of the first subpage which is not zero-filled
> + * according to swap_info_struct->zeromap.
> + * If all pages are zero-filled according to zeromap, it will return
> + * folio_nr_pages(folio).
> + */
> +static unsigned int swap_zeromap_folio_test(struct folio *folio)
> +{
> +	struct swap_info_struct *sis = swp_swap_info(folio->swap);
> +	swp_entry_t entry;
> +	unsigned int i;
> +
> +	for (i = 0; i < folio_nr_pages(folio); i++) {
> +		entry = page_swap_entry(folio_page(folio, i));
> +		if (!test_bit(swp_offset(entry), sis->zeromap))
> +			return i;
> +	}
> +	return i;
> +}
> +
>  /*
>   * We may have stale swap cache pages in memory: notice
>   * them here and get rid of the unnecessary final write.
> @@ -195,6 +277,13 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
>  		folio_unlock(folio);
>  		return ret;
>  	}
> +
> +	if (is_folio_zero_filled(folio)) {
> +		swap_zeromap_folio_set(folio);
> +		folio_unlock(folio);
> +		return 0;
> +	}
> +	swap_zeromap_folio_clear(folio);

Just for clarity, it would be good to put this into an else branch and
add a comment about overwrites due to changes in the in-memory data.

Losing this would cause nasty data corruption, so let's make sure the
reason for why it's there is spelled out, and stands out.

>  	if (zswap_store(folio)) {
>  		folio_unlock(folio);
>  		return 0;

> @@ -3161,6 +3170,17 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  		goto bad_swap_unlock_inode;
>  	}
>  
> +	/*
> +	 * Use kvmalloc_array instead of bitmap_zalloc as the allocation order might
> +	 * be above MAX_PAGE_ORDER incase of a large swap file.
> +	 */
> +	p->zeromap = kvmalloc_array(BITS_TO_LONGS(maxpages), sizeof(unsigned long),
> +				    GFP_KERNEL | __GFP_ZERO);

sizeof(long) would get this below 80 characters ;)

> +	if (!p->zeromap) {
> +		error = -ENOMEM;
> +		goto bad_swap_unlock_inode;
> +	}
> +

With that,

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

