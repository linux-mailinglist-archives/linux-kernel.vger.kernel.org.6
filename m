Return-Path: <linux-kernel+bounces-212197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A96B905C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B31D1C20F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F8D84A56;
	Wed, 12 Jun 2024 20:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HB47RhW9"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80CA1C14
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 20:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718223236; cv=none; b=QrHFFNWujEg4JS0FsUFrRRyoGfRFvfNLf9Hr9dyFUiPXowCl0esqDGUz/iyAugaLn25MQUt/HoWXyyFUIKw24Se29qldZiVvjawOZVJ7sFjKjHAdFtIHjqpOdTmg8JXobNc1Ef/VwdyimfR3j3FAO0qw4//DsR7ESAZH0jnsi3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718223236; c=relaxed/simple;
	bh=kW1dxW51GaYyyWp20DsVGQeuR5dDkh/w/wWhucfPaCQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S6/a1sgVVWBILFVYUfr6Hz+cv1MWtfgs3l9b21iG02noySpWCrlZStkBRYIub2aRI5TtLAta+PPWjKildUo4oiK0Lm4S2Gw2O0UO4O35PECyfzR99EG2frCOZXkbPXkp/v00RpDwuubNHT8GIIWjCtamxuzh6lS8iGfjuCQ0jCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HB47RhW9; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62fb36d7f5fso4864997b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718223234; x=1718828034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7l8GJ6R2kHtx5DSQAl7/KC57GQXLkZcZ8Z71qeTWAAo=;
        b=HB47RhW9MU8plYDHJQhtqwK1dlIP//2GG5a8+nIGwweNbnz0DTSN2AGcgk7kFPaC/r
         I05lVAdYupazyk2rI7LEQKIIhrI93elhkg6X9ENWGG1rH7iKfW8Rf9Ex53jw8CkBRE7i
         Iihm9O8+EwkH9W6ew8IhlC219a494Dvpmn4XNIAYZT2B6c7UFHFM1hsmQVqbaAthsEbu
         PD7I5OXZ7a0HEQmO0F03vi5ukB9yPrMp80xiLNGKhgPEqbUbmAKQs7Fgry+4qN7kQgTe
         7Hj2qP+YWSnSBtPXxn+kYfSIUMeupykbEIIpqVH0RkQwmTMFyLHkCWv8or1GcmoiKbPe
         yesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718223234; x=1718828034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7l8GJ6R2kHtx5DSQAl7/KC57GQXLkZcZ8Z71qeTWAAo=;
        b=dph++BUG1mlyLzJgbUqjQq9QSvD95J34mNPLPWM7q8nDs4SB3JoccYSlsb79Yfn8DZ
         SzwR5zMKQQ0G2JuMieXlMvoTyw+7esRfjMHTY41Aqn2XjKfAbJAw956QUMeUNLEvo6fI
         hmMUQTZMwE44dPfTiieE7KUBBNGTpx0KSxzUmuSXpkhSFUPTVng6U4CgZfv1lJ28MOi3
         2cyN/cdT1iwjg5zT6EKfZJO+Df+IzYI/vqnXbDW+JKnwDY5a5IgQ9RQpL4uKfu44Z3D5
         QSG5cPBTreqPMJMU5BLvUySkYTPINHXyQMlA8NSO5CwfeRzcjzt4ZH35Jn8Yf1+1nxVQ
         /cbg==
X-Forwarded-Encrypted: i=1; AJvYcCVlsV8dqQNWgMF5ZkuLQTecNqaHpm3L7tiI2Heat/5asK0h2KCFw8wPNlASLCEuwPQts9gO9XDqtJtMQstjODtIwa3tPjmo5oAgo0dT
X-Gm-Message-State: AOJu0YwLov81YM3q2JBKZjr922cLN5hbuabdlyKaa6sk2OEwGibY3N5P
	ZD+tSsHE3jdcxren0Xg3q6AS9UKEqXLO8vJYZkh44ffX5M1j4mADnc7+Gx5LvFwIsNPhWicppbi
	FUEde0b1DpzJecHELdA==
X-Google-Smtp-Source: AGHT+IH8KWyAAkjBcfZl37fA/0hnyv+0fL7wgnV6WguWeXXvnDHg/BTFvwBxK0TQINZieXcuPdnJg3ACRNrLy3cx
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:4c88:0:b0:615:32e1:d82c with SMTP
 id 00721157ae682-62fb9db0cd4mr4992337b3.6.1718223233686; Wed, 12 Jun 2024
 13:13:53 -0700 (PDT)
Date: Wed, 12 Jun 2024 20:13:51 +0000
In-Reply-To: <20240612124750.2220726-2-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240612124750.2220726-1-usamaarif642@gmail.com> <20240612124750.2220726-2-usamaarif642@gmail.com>
Message-ID: <ZmoBf6RPJzC2RaqM@google.com>
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
From: Yosry Ahmed <yosryahmed@google.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	david@redhat.com, ying.huang@intel.com, hughd@google.com, willy@infradead.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 12, 2024 at 01:43:35PM +0100, Usama Arif wrote:
[..]

Hi Usama,

A few more comments/questions, sorry for not looking closely earlier.

> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index f1e559e216bd..48d8dca0b94b 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -453,6 +453,8 @@ static unsigned int cluster_list_del_first(struct swap_cluster_list *list,
>  static void swap_cluster_schedule_discard(struct swap_info_struct *si,
>  		unsigned int idx)
>  {
> +	unsigned int i;
> +
>  	/*
>  	 * If scan_swap_map_slots() can't find a free cluster, it will check
>  	 * si->swap_map directly. To make sure the discarding cluster isn't
> @@ -461,6 +463,13 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
>  	 */
>  	memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>  			SWAP_MAP_BAD, SWAPFILE_CLUSTER);
> +	/*
> +	 * zeromap can see updates from concurrent swap_writepage() and swap_read_folio()
> +	 * call on other slots, hence use atomic clear_bit for zeromap instead of the
> +	 * non-atomic bitmap_clear.
> +	 */

I don't think this is accurate. swap_read_folio() does not update the
zeromap. I think the need for an atomic operation here is because we may
be updating adjacent bits simulatenously, so we may cause lost updates
otherwise (i.e. corrupting adjacent bits).

> +	for (i = 0; i < SWAPFILE_CLUSTER; i++)
> +		clear_bit(idx * SWAPFILE_CLUSTER + i, si->zeromap);

Could you explain why we need to clear the zeromap here?

swap_cluster_schedule_discard() is called from:
- swap_free_cluster() -> free_cluster()

This is already covered below.

- swap_entry_free() -> dec_cluster_info_page() -> free_cluster()

Each entry in the cluster should have its zeromap bit cleared in
swap_entry_free() before the entire cluster is free and we call
free_cluster().

Am I missing something?

>  
>  	cluster_list_add_tail(&si->discard_clusters, si->cluster_info, idx);
>  
> @@ -482,7 +491,7 @@ static void __free_cluster(struct swap_info_struct *si, unsigned long idx)
>  static void swap_do_scheduled_discard(struct swap_info_struct *si)
>  {
>  	struct swap_cluster_info *info, *ci;
> -	unsigned int idx;
> +	unsigned int idx, i;
>  
>  	info = si->cluster_info;
>  
> @@ -498,6 +507,8 @@ static void swap_do_scheduled_discard(struct swap_info_struct *si)
>  		__free_cluster(si, idx);
>  		memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>  				0, SWAPFILE_CLUSTER);
> +		for (i = 0; i < SWAPFILE_CLUSTER; i++)
> +			clear_bit(idx * SWAPFILE_CLUSTER + i, si->zeromap);

Same here. I didn't look into the specific code paths, but shouldn't the
cluster be unused (and hence its zeromap bits already cleared?).

>  		unlock_cluster(ci);
>  	}
>  }
> @@ -1059,9 +1070,12 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
>  {
>  	unsigned long offset = idx * SWAPFILE_CLUSTER;
>  	struct swap_cluster_info *ci;
> +	unsigned int i;
>  
>  	ci = lock_cluster(si, offset);
>  	memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
> +	for (i = 0; i < SWAPFILE_CLUSTER; i++)
> +		clear_bit(offset + i, si->zeromap);
>  	cluster_set_count_flag(ci, 0, 0);
>  	free_cluster(si, idx);
>  	unlock_cluster(ci);
> @@ -1336,6 +1350,7 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
>  	count = p->swap_map[offset];
>  	VM_BUG_ON(count != SWAP_HAS_CACHE);
>  	p->swap_map[offset] = 0;
> +	clear_bit(offset, p->zeromap);

I think instead of clearing the zeromap in swap_free_cluster() and here
separately, we can just do it in swap_range_free(). I suspect this may
be the only place we really need to clear the zero in the swapfile code.

>  	dec_cluster_info_page(p, p->cluster_info, offset);
>  	unlock_cluster(ci);
>  
> @@ -2597,6 +2612,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  	free_percpu(p->cluster_next_cpu);
>  	p->cluster_next_cpu = NULL;
>  	vfree(swap_map);
> +	bitmap_free(p->zeromap);
>  	kvfree(cluster_info);
>  	/* Destroy swap account information */
>  	swap_cgroup_swapoff(p->type);
> @@ -3123,6 +3139,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
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
> 

