Return-Path: <linux-kernel+bounces-300589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6783B95E58E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 00:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D249A1F21A28
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 22:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C176F2F6;
	Sun, 25 Aug 2024 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pM0CN0Nx"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE2A2D60C
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724625086; cv=none; b=Ee4mmxz1AOQpHYIDbS6sNehw7AC4olqFOI/M8D4KcfSD2diink7jl7ebfIcf3jfHIhs0u86rkGE1oqv4gRhmC0lf6XqDud30AuX/gUIvDs9Jh1g9AhKzMEXUeThXtTyI8YBmHHEuT8maNNQZsqcBjALET6ksa/KGocBYnOEb/wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724625086; c=relaxed/simple;
	bh=NqdUDSuoSGEyW8PlbEjgO3613/3wU7vdde+k72E5Mdg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jg7rfxOQxx6rjudN9+PPBhgKg9MIicYY/tk9NrI39JTC6jYjtidZnKVHJ2BOTBEnJMLHWT6DpNTqOaGaBvE96Gu2TMSanxG2kjGLMUymMKSisitL7vaDjk/4mMFxa2z9tiLJb8Gwl6UA0a2c/HpZu4K5Hg7UBUK4Y2iwUbJ8bkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pM0CN0Nx; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d3d0b06a2dso3068954a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 15:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724625084; x=1725229884; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ECFxXZzfg6EPp6aDhVxPSP7HkNB1gx8gs++eUuEcwi8=;
        b=pM0CN0NxEkkwl5rq/X6azfasGqTreqFs2lFLY8Ic6sHFDjV5DRHvo0URcLB65Nswhe
         xxNL0KmNmOXP156vjtFxFTvp1wvMooLXKEKiCYqt2AtFQjt044uW4aYDmjVty66k9Kmk
         iVu5sDJ9H6ovUYauJrxPOvrY42XwRgXrb3N+ZmZN2YGmnApJ+tNyMjRbv/Eq/flTZ+xG
         45hPnHOCQFA6WsAu6VPxYs4JUDhOrxT75rxgWZcd0LS/SE83hlCZlSIeWqN/E6+/4nty
         DKHC/rYt105zJXKMFLW1bzmnIXbJ0fhzvNZnxAbM/OmTjbKHfKHba+XqmHXUjwlH+uw+
         7CJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724625084; x=1725229884;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECFxXZzfg6EPp6aDhVxPSP7HkNB1gx8gs++eUuEcwi8=;
        b=aLX7WyO4dVQ1CYpXVRH1vl4o7WT3L1LLHKs4bQXeGZaQmEWNNKOPcI/2T1NIACTiY1
         EyJsa78+Q7aOGEyWEmM9f10QVZX8zBGrhJExtCPebgnhsd9wXAfsw7U/ztXdgdjMNIgP
         LfJK7DiGSs3b53MidnAKj4gFciL/JTq+vS02FjRLnVVZBZw5nphBxZct8aRCzhSg/p/e
         jziafoXO59utZLlnrPsPEcjQvP01o2S7ihZTQ+fcxJnLz9C5T73N5FUXEfjcFaUPzMEH
         qblV6X4K4uxpvQvYpH37sIQWgfoI3P0MEBoWKAZA3n9J0HmA5b55W+SspursvTKpxXjK
         OcAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtprM6RSp8C02coMLGCDcXh0ZQloPt2HHu+rAml3Royy+E2QkqzFukfZro/HxHhlNEIpBIYvmQmSFSKts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1SQEVECx9FMZaWwNuIovs6DdQIKXVYX/R6TKZoCD7HYaHVjVm
	VU7sLYHbEHJj4SurIck+wU0Ep4u4BvNea4IGa+qBpAuq+2gMxGpyHtJKhe4ZeQ==
X-Google-Smtp-Source: AGHT+IHq68YcCaPHf9f3PRa5veAqAEtfR93oiNTqOsLsh1yukVHogc8EsDEc1R6HvEXe/KboacvKwQ==
X-Received: by 2002:a17:90a:e393:b0:2d3:b1d1:b62d with SMTP id 98e67ed59e1d1-2d646c232e6mr9907105a91.24.1724625083723;
        Sun, 25 Aug 2024 15:31:23 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d61392009bsm8477539a91.16.2024.08.25.15.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 15:31:22 -0700 (PDT)
Date: Sun, 25 Aug 2024 15:31:21 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>
cc: hughd@google.com, willy@infradead.org, david@redhat.com, 
    wangkefeng.wang@huawei.com, chrisl@kernel.org, ying.huang@intel.com, 
    21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com, 
    ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com, 
    p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 8/9] mm: shmem: split large entry if the swapin folio
 is not large
In-Reply-To: <4a0f12f27c54a62eb4d9ca1265fed3a62531a63e.1723434324.git.baolin.wang@linux.alibaba.com>
Message-ID: <e2a2ba5d-864c-50aa-7579-97cba1c7dd0c@google.com>
References: <cover.1723434324.git.baolin.wang@linux.alibaba.com> <4a0f12f27c54a62eb4d9ca1265fed3a62531a63e.1723434324.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 12 Aug 2024, Baolin Wang wrote:

> Now the swap device can only swap-in order 0 folio, even though a large
> folio is swapped out. This requires us to split the large entry previously
> saved in the shmem pagecache to support the swap in of small folios.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/shmem.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 345e25425e37..996062dc196b 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1990,6 +1990,81 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
>  	swap_free_nr(swap, nr_pages);
>  }
>  
> +static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
> +				   swp_entry_t swap, int new_order, gfp_t gfp)
> +{
> +	struct address_space *mapping = inode->i_mapping;
> +	XA_STATE_ORDER(xas, &mapping->i_pages, index, new_order);
> +	void *alloced_shadow = NULL;
> +	int alloced_order = 0, i;

gfp needs to be adjusted: see fix patch below.

> +
> +	for (;;) {
> +		int order = -1, split_order = 0;
> +		void *old = NULL;
> +
> +		xas_lock_irq(&xas);
> +		old = xas_load(&xas);
> +		if (!xa_is_value(old) || swp_to_radix_entry(swap) != old) {
> +			xas_set_err(&xas, -EEXIST);
> +			goto unlock;
> +		}
> +
> +		order = xas_get_order(&xas);
> +
> +		/* Swap entry may have changed before we re-acquire the lock */
> +		if (alloced_order &&
> +		    (old != alloced_shadow || order != alloced_order)) {
> +			xas_destroy(&xas);
> +			alloced_order = 0;
> +		}
> +
> +		/* Try to split large swap entry in pagecache */
> +		if (order > 0 && order > new_order) {

I have not even attempted to understand all the manipulations of order and
new_order and alloced_order and split_order.  And further down it turns out
that this is only ever called with new_order 0.

You may be wanting to cater for more generality in future, but for now
please cut this down to the new_order 0 case, and omit that parameter.
It will be easier for us to think about the xa_get_order() races if
the possibilities are more limited.

> +			if (!alloced_order) {
> +				split_order = order;
> +				goto unlock;
> +			}
> +			xas_split(&xas, old, order);
> +
> +			/*
> +			 * Re-set the swap entry after splitting, and the swap
> +			 * offset of the original large entry must be continuous.
> +			 */
> +			for (i = 0; i < 1 << order; i += (1 << new_order)) {
> +				pgoff_t aligned_index = round_down(index, 1 << order);
> +				swp_entry_t tmp;
> +
> +				tmp = swp_entry(swp_type(swap), swp_offset(swap) + i);
> +				__xa_store(&mapping->i_pages, aligned_index + i,
> +					   swp_to_radix_entry(tmp), 0);
> +			}

So that is done under xas lock: good. But is the intermediate state
visible to RCU readers, and could that be a problem?

> +		}
> +
> +unlock:
> +		xas_unlock_irq(&xas);
> +
> +		/* split needed, alloc here and retry. */
> +		if (split_order) {
> +			xas_split_alloc(&xas, old, split_order, gfp);
> +			if (xas_error(&xas))
> +				goto error;
> +			alloced_shadow = old;
> +			alloced_order = split_order;
> +			xas_reset(&xas);
> +			continue;
> +		}
> +
> +		if (!xas_nomem(&xas, gfp))
> +			break;
> +	}
> +
> +error:
> +	if (xas_error(&xas))
> +		return xas_error(&xas);
> +
> +	return alloced_order;
> +}
> +
>  /*
>   * Swap in the folio pointed to by *foliop.
>   * Caller has to make sure that *foliop contains a valid swapped folio.
> @@ -2026,12 +2101,37 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  	/* Look it up and read it in.. */
>  	folio = swap_cache_get_folio(swap, NULL, 0);
>  	if (!folio) {
> +		int split_order;
> +
>  		/* Or update major stats only when swapin succeeds?? */
>  		if (fault_type) {
>  			*fault_type |= VM_FAULT_MAJOR;
>  			count_vm_event(PGMAJFAULT);
>  			count_memcg_event_mm(fault_mm, PGMAJFAULT);
>  		}
> +
> +		/*
> +		 * Now swap device can only swap in order 0 folio, then we
> +		 * should split the large swap entry stored in the pagecache
> +		 * if necessary.
> +		 */
> +		split_order = shmem_split_large_entry(inode, index, swap, 0, gfp);
> +		if (split_order < 0) {
> +			error = split_order;
> +			goto failed;
> +		}
> +
> +		/*
> +		 * If the large swap entry has already been split, it is
> +		 * necessary to recalculate the new swap entry based on
> +		 * the old order alignment.
> +		 */
> +		if (split_order > 0) {
> +			pgoff_t offset = index - round_down(index, 1 << split_order);
> +
> +			swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
> +		}
> +
>  		/* Here we actually start the io */
>  		folio = shmem_swapin_cluster(swap, gfp, info, index);
>  		if (!folio) {
> -- 

[PATCH] mm: shmem: split large entry if the swapin folio is not large fix

Fix all the
Unexpected gfp: 0x2 (__GFP_HIGHMEM). Fixing up to gfp: 0x1120d0
(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_HARDWALL|__GFP_RECLAIMABLE).
Fix your code!
warnings from kmalloc_fix_flags() from xas_split_alloc() from
shmem_split_large_entry().

Fixes: a960844d5ac9 ("mm: shmem: split large entry if the swapin folio is not large")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index ae2245dce8ae..85e3bd3e709e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1999,6 +1999,9 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
 	void *alloced_shadow = NULL;
 	int alloced_order = 0, i;
 
+	/* Convert user data gfp flags to xarray node gfp flags */
+	gfp &= GFP_RECLAIM_MASK;
+
 	for (;;) {
 		int order = -1, split_order = 0;
 		void *old = NULL;
-- 
2.35.3

