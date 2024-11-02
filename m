Return-Path: <linux-kernel+bounces-393399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBDE9BA00B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 13:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57185B21342
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 12:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A2A170A3A;
	Sat,  2 Nov 2024 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ1BXAY4"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17EC23CB
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730550759; cv=none; b=fgyfZCkHThS6dr6e7X9O7SPSg0ltsx35KT39MuZn7MkeT4ullvDA8ogcJP5kCpwDs0UppykYmgEu2c2CuDuf+EugUj7ZFEW9usxLKVUo//pPEoR1mY+YExeiL/DYY4zzEm8vJPLV1/fH02Ch/OarLjsfWD7KqooeZ/cBvkOW9XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730550759; c=relaxed/simple;
	bh=U9H86pNX2QEFpLAdxbTOVuHZ8uuBebFVCVLotZm24po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XfsSJWoya8I8O5gYHCW1ww8UxRSq1mebEhICsQZQprciR6KSp5JwbNaJKXQffFVat3Irn/sjuCVEB2wI7dvdtCkBtANQGBYEKC3REvmtpEqe5LYhOd9vgzLiq/D6r3KUDr2s7nGOaJqIbU4B6VJDEWUIU1jPH/IAxxCfNYGM+Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZ1BXAY4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so22625385e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 05:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730550756; x=1731155556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0cK9TQVWg7I+wIQ6YLPwhG/jCCQaaWlOYJF5K81kq2s=;
        b=eZ1BXAY4+sC1dp0Dpj6PY3PRsjhHnYnpMIOhUyCY5NnEmZV8ebwRswuLR535lFLIwb
         HThoTvTNHNbLIK61YLIGoraTCWpRp3xcHSFy39UfQJunymEClhA36qIllgv8i+S2s6GK
         dqpZZ4CJvlexlCg4v/+6AkOLnllrRI8TMGpfOBjijdtSfrD4T9VGK/oXw0lZdzLh5fE8
         q9VUEvJzvcIXFTCQQCiVeaMD/cRbqWZDEK0DjHie1cVs04nTaQ5wXZSTQOCnXM0rYDJc
         HZay0LeaJTS2d2dlwgFk7S1cKEV9d4AHG9ql3hVFi0K4orlXIa9Lo/33hdln19uyTSgJ
         zm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730550756; x=1731155556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cK9TQVWg7I+wIQ6YLPwhG/jCCQaaWlOYJF5K81kq2s=;
        b=LAPSNQyYYs+fZvLVJRucJfvBYoIc28zUbcmTaG8DQNMj/7mdpFLacC4+kn+8E+eqoF
         sEaGrk4gLkMhoGOiheff4j+rkCvMqurgZcywMX/CtEtlKfprJblBPq37f4spoMEzac9D
         +7JJfWy8op8KnoBLTHMlZ3Oil0Nc8M8/vwsqvp01m+htCwGyhuvLsw+HN118QYLP9hR6
         jQ36+nwcLFLGSJTexTcGljEFstGWOC/bej1vw/45tnex0+sQRouK3do8idmIACgTTQfP
         eBL/GGTB8kLdiR4ftzV+fQetd/xqWqLgNvSnPRXQWKV43t6WW1ocUJdld7YFbcRsJDr8
         7nIA==
X-Gm-Message-State: AOJu0YyRutPtTo5F3DEEurdGif29+lcf1eKd8W+lTLHwmtz7PA1C/29E
	izROjmaCACC5ikSGbM/zwpxcuixyPoGCac43aP4b3RGXezJbExNy
X-Google-Smtp-Source: AGHT+IGkR2VlUBwhCZn8s/GdFQOSJrDGvhIE67MupKLsaLdsl5BO7ONzPYLUC7I8OnMc4kGAROOyVw==
X-Received: by 2002:a05:600c:16ca:b0:431:5847:f63f with SMTP id 5b1f17b1804b1-43283246cb4mr54800135e9.13.1730550755887;
        Sat, 02 Nov 2024 05:32:35 -0700 (PDT)
Received: from ?IPV6:2a02:6b67:d751:7400:c2b:f323:d172:e42a? ([2a02:6b67:d751:7400:c2b:f323:d172:e42a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d685278sm93123145e9.36.2024.11.02.05.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 05:32:35 -0700 (PDT)
Message-ID: <6c14ab2c-7917-489b-b51e-401d208067f3@gmail.com>
Date: Sat, 2 Nov 2024 12:32:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: count zeromap read and set for swapout and swapin
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>,
 Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Andi Kleen <ak@linux.intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>,
 "Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20241102101240.35072-1-21cnbao@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20241102101240.35072-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 02/11/2024 10:12, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> When the proportion of folios from the zero map is small, missing their
> accounting may not significantly impact profiling. However, it’s easy
> to construct a scenario where this becomes an issue—for example,
> allocating 1 GB of memory, writing zeros from userspace, followed by
> MADV_PAGEOUT, and then swapping it back in. In this case, the swap-out
> and swap-in counts seem to vanish into a black hole, potentially
> causing semantic ambiguity.
> 
> We have two ways to address this:
> 
> 1. Add a separate counter specifically for the zero map.
> 2. Continue using the current accounting, treating the zero map like
> a normal backend. (This aligns with the current behavior of zRAM
> when supporting same-page fills at the device level.)
> 
> This patch adopts option 1 as pswpin/pswpout counters are that they
> only apply to IO done directly to the backend device (as noted by
> Nhat Pham).
> 
> We can find these counters from /proc/vmstat (counters for the whole
> system) and memcg's memory.stat (counters for the interested memcg).
> 
> For example:
> 
> $ grep -E 'swpin_zero|swpout_zero' /proc/vmstat
> swpin_zero 1648
> swpout_zero 33536
> 
> $ grep -E 'swpin_zero|swpout_zero' /sys/fs/cgroup/system.slice/memory.stat
> swpin_zero 3905
> swpout_zero 3985
> 
> Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap")
I don't think its a hotfix (or even a fix). It was discussed in the initial
series to add these as a follow up and Joshua was going to do this soon.
Its not fixing any bug in the initial series.

> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  -v2:
>  * add separate counters rather than using pswpin/out; thanks
>  for the comments from Usama, David, Yosry and Nhat;
>  * Usama also suggested a new counter like swapped_zero, I
>  prefer that one be separated as an enhancement patch not
>  a hotfix. will probably handle it later on.
> 
I dont think either of them would be a hotfix.

>  Documentation/admin-guide/cgroup-v2.rst | 10 ++++++++++
>  include/linux/vm_event_item.h           |  2 ++
>  mm/memcontrol.c                         |  4 ++++
>  mm/page_io.c                            | 16 ++++++++++++++++
>  mm/vmstat.c                             |  2 ++
>  5 files changed, 34 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index db3799f1483e..984eb3c9d05b 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1599,6 +1599,16 @@ The following nested keys are defined.
>  	  pglazyfreed (npn)
>  		Amount of reclaimed lazyfree pages
>  
> +	  swpin_zero
> +		Number of pages moved into memory with zero content, meaning no
> +		copy exists in the backend swapfile, allowing swap-in to avoid
> +		I/O read overhead.
> +
> +	  swpout_zero
> +		Number of pages moved out of memory with zero content, meaning no
> +		copy is needed in the backend swapfile, allowing swap-out to avoid
> +		I/O write overhead.
> +

Maybe zero-filled pages might be a better term in both. 

>  	  zswpin
>  		Number of pages moved in to memory from zswap.
>  
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index aed952d04132..f70d0958095c 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -134,6 +134,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  #ifdef CONFIG_SWAP
>  		SWAP_RA,
>  		SWAP_RA_HIT,
> +		SWPIN_ZERO,
> +		SWPOUT_ZERO,
>  #ifdef CONFIG_KSM
>  		KSM_SWPIN_COPY,
>  #endif
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5e44d6e7591e..7b3503d12aaf 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -441,6 +441,10 @@ static const unsigned int memcg_vm_event_stat[] = {
>  	PGDEACTIVATE,
>  	PGLAZYFREE,
>  	PGLAZYFREED,
> +#ifdef CONFIG_SWAP
> +	SWPIN_ZERO,
> +	SWPOUT_ZERO,
> +#endif
>  #ifdef CONFIG_ZSWAP
>  	ZSWPIN,
>  	ZSWPOUT,
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 5d9b6e6cf96c..4b4ea8e49cf6 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -204,7 +204,9 @@ static bool is_folio_zero_filled(struct folio *folio)
>  
>  static void swap_zeromap_folio_set(struct folio *folio)
>  {
> +	struct obj_cgroup *objcg = get_obj_cgroup_from_folio(folio);
>  	struct swap_info_struct *sis = swp_swap_info(folio->swap);
> +	int nr_pages = folio_nr_pages(folio);
>  	swp_entry_t entry;
>  	unsigned int i;
>  
> @@ -212,6 +214,12 @@ static void swap_zeromap_folio_set(struct folio *folio)
>  		entry = page_swap_entry(folio_page(folio, i));
>  		set_bit(swp_offset(entry), sis->zeromap);
>  	}
> +
> +	count_vm_events(SWPOUT_ZERO, nr_pages);
> +	if (objcg) {
> +		count_objcg_events(objcg, SWPOUT_ZERO, nr_pages);
> +		obj_cgroup_put(objcg);
> +	}
>  }
>  
>  static void swap_zeromap_folio_clear(struct folio *folio)
> @@ -507,6 +515,7 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
>  static bool swap_read_folio_zeromap(struct folio *folio)
>  {
>  	int nr_pages = folio_nr_pages(folio);
> +	struct obj_cgroup *objcg;
>  	bool is_zeromap;
>  
>  	/*
> @@ -521,6 +530,13 @@ static bool swap_read_folio_zeromap(struct folio *folio)
>  	if (!is_zeromap)
>  		return false;
>  
> +	objcg = get_obj_cgroup_from_folio(folio);
> +	count_vm_events(SWPIN_ZERO, nr_pages);
> +	if (objcg) {
> +		count_objcg_events(objcg, SWPIN_ZERO, nr_pages);
> +		obj_cgroup_put(objcg);
> +	}
> +
>  	folio_zero_range(folio, 0, folio_size(folio));
>  	folio_mark_uptodate(folio);
>  	return true;
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 22a294556b58..c8ef7352f9ed 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1418,6 +1418,8 @@ const char * const vmstat_text[] = {
>  #ifdef CONFIG_SWAP
>  	"swap_ra",
>  	"swap_ra_hit",
> +	"swpin_zero",
> +	"swpout_zero",
>  #ifdef CONFIG_KSM
>  	"ksm_swpin_copy",
>  #endif


