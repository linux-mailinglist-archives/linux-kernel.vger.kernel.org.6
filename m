Return-Path: <linux-kernel+bounces-187519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 122F68CD2D9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6662284DA1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CB814A4DF;
	Thu, 23 May 2024 12:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6022w9o"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44A214A4C1
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468824; cv=none; b=Yc801d8cboPdUVzawGkLE2q1yyT1Ya8eB2LyvQAkBmaAHzMdMOivvfG5MkcwVaGZUOVKUqmWKSYNM6it4+9V4ysEEKyRdzLbTbV7nQJiGtqRfRetxpz2p+f/bvCtlJ4NJfnoQnsfGPkA9BmxVf0xkhDJk46/z6LaaKwny1Sw6eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468824; c=relaxed/simple;
	bh=w6GRQtmcLjUUDL9NaPfGBSSX1C9A900lkb2FmWQSt+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAH8xh+RJyDFhRjxttlf8LamEBxDxdOsiBkMFjyrlOMeTo2JiA8lNlzYtchDPkkVDpb+qNjYJ3mhichCD6fvv/97JnawkqSNqru9PxGK2NCK1vT+9XmhOdZJl0ZLKhmzHcwKGsOrmUc9f1h2wfu3jsAMppgtGWLsKJo01U+DbdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6022w9o; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41fec6d4d84so630865e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716468821; x=1717073621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=flAPbWWp57MeHbRK65Hsnt53rZwtZFKtBqvKOTNtyE0=;
        b=f6022w9o1izlf6b9jDbwn4BdIvVBCUoHbqYvOvSXwJxe6yc3Wf7T5OpO9D+uyt1lgn
         DxlN2hJL21paY0oxSrJzURrxDbjEakNp48B6rnOnfNzDvNhCDRwCyPe3mNshSHXV8VHd
         7HpWs6yKdan0n5FPpRyCoatPnWxRCMcfDTLrXjth7truLZGO1oUAgy4hpTlQxDonQpga
         UGGgU7NX0eZpnEAL6OZJxFGPuLPNqiybaIjN3ozp2PhfF/gUWcN7t3y//T/+BkiVfdQf
         ep+c0Tzr+05T8oj2Tn5LeKqUHvynwKqZqY0kApdB4YUO3zNSQjra3buq2pz04KL1aK9E
         nCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716468821; x=1717073621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flAPbWWp57MeHbRK65Hsnt53rZwtZFKtBqvKOTNtyE0=;
        b=j2yN0lALm1qVlBFMEWBQ4qlU+W27l6veIk6dsbpDmwiDqa+LHtw7jKJwfSRU1GFCKA
         ypA/gy4RJYNmD/0lGtHQbsEaGWngWpklFD+FmczgMUUpPTHoRB+c8pibTTkZJFIbSr1C
         67EeLehefSBENJWTvzRqwFSwYdXeTkENT0Q3nvRW6bCzlgboPSGN1MpgbNXcYfjOQS6z
         PMDYscLrRqwFVXbxIaOE5wI98PObDxaQbn5alIgSB4y8fuZKswdKaK7XKTD7c1MRklGV
         BmuOwmbR3ckCT6t4TqmKV2hdcTxbB9uy1k0wEbjkHPISxsGjNDXUQbvIRm9tlbihDTuJ
         xXQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAOat/r4AgaFZGJfFaGX4Ld8Ee/ghfJsSbVXT0j9N2wooR3c0KqwNmAAcJaJrZOlLBuotq9DdFQIjQcJn48fDziIYQibbgxpvfdI+J
X-Gm-Message-State: AOJu0Yzgy0lfYyeprc3m+sriWzDeaxD0gBm2JRYKlb2y+ic6VqPojxAp
	Yqt8lUvo2Dqz3kOHhWWeqhgZF3aIuGOW5xO1H//kQIdV2yvadjrM9b20NA==
X-Google-Smtp-Source: AGHT+IFoyyEXfrC0CEdfkh832ZQvtrzOUvHU1PdopnkCbxR7Kmx7ulyApp2//xru1xch/2xRt60S9g==
X-Received: by 2002:a05:600c:4f90:b0:420:29dd:84e2 with SMTP id 5b1f17b1804b1-420fd372a13mr35500365e9.2.1716468820775;
        Thu, 23 May 2024 05:53:40 -0700 (PDT)
Received: from localhost.localdomain ([2001:630:3c1:90:1614:6de0:61c7:40b0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f7b7f9sm24535195e9.27.2024.05.23.05.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:53:40 -0700 (PDT)
Date: Thu, 23 May 2024 13:53:37 +0100
From: Karim Manaouil <kmanaouil.dev@gmail.com>
To: Byungchul Park <byungchul@sk.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com
Subject: Re: [PATCH] mm: let kswapd work again for node that used to be
 hopeless but may not now
Message-ID: <Zk88UTrNIAMWdLMs@localhost.localdomain>
References: <20240523051406.81053-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523051406.81053-1-byungchul@sk.com>

On Thu, May 23, 2024 at 02:14:06PM +0900, Byungchul Park wrote:
> I suffered from kswapd stopped in the following scenario:
> 
>    CONFIG_NUMA_BALANCING enabled
>    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
>    numa node0 (500GB local DRAM, 128 CPUs)
>    numa node1 (100GB CXL memory, no CPUs)
>    swap off
> 
>    1) Run any workload using a lot of anon pages e.g. mmap(200GB).
>    2) Keep adding another workload using a lot of anon pages.
>    3) The DRAM becomes filled with only anon pages through promotion.
>    4) Demotion barely works due to severe memory pressure.
>    5) kswapd for node0 stops because of the unreclaimable anon pages.

It's not very clear to me, but if I understand correctly, if you have
free memory on CXL, kswapd0 should not stop as long as demotion is
successfully migrating the pages from DRAM to CXL and returns that as
nr_reclaimed in shrink_folio_list()? 

If that's the case, kswapd0 is making progress and shouldn't give up.

If CXL memory is also filled and migration fails, then it doesn't make
sense to me to wake up kswapd0 as it obvisoly won't help with anything,
because, you guessed it, you have no memory in the first place!!

>    6) Manually kill the memory hoggers.
>    7) kswapd is still stopped even though the system got back to normal.
> 
> From now on, the system should run without reclaim service in background
> served by kswapd until direct reclaim will do for that.  Even worse,
> tiering mechanism is no longer able to work because kswapd has stopped
> that the mechanism relies on.
> 
> However, after 6), the DRAM will be filled with pages that might or
> might not be reclaimable, that depends on how those are going to be used.
> Since those are potentially reclaimable anyway, it's worth hopefully
> trying reclaim by allowing kswapd to work again if needed.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/linux/mmzone.h |  4 ++++
>  mm/page_alloc.c        | 12 ++++++++++++
>  mm/vmscan.c            | 21 ++++++++++++++++-----
>  3 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index c11b7cde81ef..7c0ba90ea7b4 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1331,6 +1331,10 @@ typedef struct pglist_data {
>  	enum zone_type kswapd_highest_zoneidx;
>  
>  	int kswapd_failures;		/* Number of 'reclaimed == 0' runs */
> +	int nr_may_reclaimable;		/* Number of pages that have been
> +					   allocated since considered the
> +					   node is hopeless due to too many
> +					   kswapd_failures. */
>  
>  #ifdef CONFIG_COMPACTION
>  	int kcompactd_max_order;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 14d39f34d336..1dd2daede014 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1538,8 +1538,20 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>  static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
>  							unsigned int alloc_flags)
>  {
> +	pg_data_t *pgdat = page_pgdat(page);
> +
>  	post_alloc_hook(page, order, gfp_flags);
>  
> +	/*
> +	 * New pages might or might not be reclaimable depending on how
> +	 * these pages are going to be used.  However, since these are
> +	 * potentially reclaimable, it's worth hopefully trying reclaim
> +	 * by allowing kswapd to work again even if there have been too
> +	 * many ->kswapd_failures, if ->nr_may_reclaimable is big enough.
> +	 */
> +	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES)
> +		pgdat->nr_may_reclaimable += 1 << order;
> +
>  	if (order && (gfp_flags & __GFP_COMP))
>  		prep_compound_page(page, order);
>  
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 3ef654addd44..5b39090c4ef1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4943,6 +4943,7 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
>  done:
>  	/* kswapd should never fail */
>  	pgdat->kswapd_failures = 0;
> +	pgdat->nr_may_reclaimable = 0;
>  }
>  
>  /******************************************************************************
> @@ -5991,9 +5992,10 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  	 * sleep. On reclaim progress, reset the failure counter. A
>  	 * successful direct reclaim run will revive a dormant kswapd.
>  	 */
> -	if (reclaimable)
> +	if (reclaimable) {
>  		pgdat->kswapd_failures = 0;
> -	else if (sc->cache_trim_mode)
> +		pgdat->nr_may_reclaimable = 0;
> +	} else if (sc->cache_trim_mode)
>  		sc->cache_trim_mode_failed = 1;
>  }
>  
> @@ -6636,6 +6638,11 @@ static void clear_pgdat_congested(pg_data_t *pgdat)
>  	clear_bit(PGDAT_WRITEBACK, &pgdat->flags);
>  }
>  
> +static bool may_recaimable(pg_data_t *pgdat, int order)
> +{
> +	return pgdat->nr_may_reclaimable >= 1 << order;
> +}
> +
>  /*
>   * Prepare kswapd for sleeping. This verifies that there are no processes
>   * waiting in throttle_direct_reclaim() and that watermarks have been met.
> @@ -6662,7 +6669,8 @@ static bool prepare_kswapd_sleep(pg_data_t *pgdat, int order,
>  		wake_up_all(&pgdat->pfmemalloc_wait);
>  
>  	/* Hopeless node, leave it to direct reclaim */
> -	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES)
> +	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES &&
> +	    !may_recaimable(pgdat, order))
>  		return true;
>  
>  	if (pgdat_balanced(pgdat, order, highest_zoneidx)) {
> @@ -6940,8 +6948,10 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
>  		goto restart;
>  	}
>  
> -	if (!sc.nr_reclaimed)
> +	if (!sc.nr_reclaimed) {
>  		pgdat->kswapd_failures++;
> +		pgdat->nr_may_reclaimable = 0;
> +	}
>  
>  out:
>  	clear_reclaim_active(pgdat, highest_zoneidx);
> @@ -7204,7 +7214,8 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
>  		return;
>  
>  	/* Hopeless node, leave it to direct reclaim if possible */
> -	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ||
> +	if ((pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES &&
> +	     !may_recaimable(pgdat, order)) ||
>  	    (pgdat_balanced(pgdat, order, highest_zoneidx) &&
>  	     !pgdat_watermark_boosted(pgdat, highest_zoneidx))) {
>  		/*
> -- 
> 2.17.1
> 
> 

