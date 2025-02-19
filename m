Return-Path: <linux-kernel+bounces-520850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92360A3B00F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 04:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628A21897C63
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B3A19D8A9;
	Wed, 19 Feb 2025 03:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hN9otfxU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9489B136A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739936162; cv=none; b=dA833Fkl5DqwO5DL3kFUsuo2OpCAEyMLt1ic8NPWEyvfwomXekOlichj1H2PXTkxyPmxwZY3BACYZwf9+sIxq5OBCwNrceec8H25FvG7iRMtitcnoq3ZH6MYTZ00n7P/YvHioZblMo3w6AhUogi9du0FCWwUw2J8tLNwi1FLxqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739936162; c=relaxed/simple;
	bh=BKZwT6I5R9lILPQ4dfwXpfQnF1ovOee/VsccUkO/J2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptOpN4Qob20O24lEHmLR9/1XGpdNGG2oueI4lDjJB9Lh4x57Q46czPPIEdgwZcWFdDJ8OojGR+QMC7fQz+EqiOcWSgHqO92yW7DZ4hx9DIfkBC/ZqhZbpiGhQ+7bE+mQuju95F8u8zou/SZ+SPsbwM84/uZRZ8xP0vvC4+0Gv+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hN9otfxU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739936159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BdVdlhrmb81BZP25WO0Xn6nuCh4nUjdpP2d/2975ELI=;
	b=hN9otfxUqtrGFGcO3xb/ddqmyaNL7zgxFqtFXlQdSJZSEpkq6ZfPl58vLTH8bEUzywRtUs
	iKRXXnE/GHYEIvNdd1JDn1XKdT0BDoOZjEzIKxnDsxvS2YzL06Hoi9zShx0MxCp0WgHAQ5
	K0u+KeBYvUAwkA+v9U+NjyKA1Vj3zNQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-U_QZBFe5OUKPyV0XMEpg5A-1; Tue,
 18 Feb 2025 22:35:54 -0500
X-MC-Unique: U_QZBFe5OUKPyV0XMEpg5A-1
X-Mimecast-MFC-AGG-ID: U_QZBFe5OUKPyV0XMEpg5A_1739936153
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A9D71800877;
	Wed, 19 Feb 2025 03:35:52 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F4081800359;
	Wed, 19 Feb 2025 03:35:50 +0000 (UTC)
Date: Wed, 19 Feb 2025 11:35:46 +0800
From: Baoquan He <bhe@redhat.com>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] mm, swap: avoid redundant swap device pinning
Message-ID: <Z7VRkvj+WRh0FNfg@MiWiFi-R3L-srv>
References: <20250214175709.76029-1-ryncsn@gmail.com>
 <20250214175709.76029-4-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214175709.76029-4-ryncsn@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 02/15/25 at 01:57am, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> There are only two callers of __read_swap_cache_async not holding a swap
> device reference, so make them hold a reference instead, and drop the
> get/put_swap_device calls in __read_swap_cache_async. This should reduce
> the overhead for swap in during page fault slightly.

This looks good to me, while the log makes me take a little longer time
to understand. Maybe rephrasing them a little bit can facilitate the log
reading. Not sure if my understanding is correct.

=======
Currently, __read_swap_cache_async() has get/put_swap_device() calls to
increase/decrease a swap device reference. While some of its callers
have held the swap  device reference, e.g in do_swap_page() and
shmem_swapin_folio() where __read_swap_cache_async() will finally
called. Now there are only two excpetional callers not holding a swap
device reference, so make them hold a reference instead. And drop the
get/put_swap_device calls in __read_swap_cache_async. This should reduce
the overhead for swap in during page fault slightly.
========

Other than the nit in log, this looks good to me.

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap_state.c | 14 ++++++++------
>  mm/zswap.c      |  6 ++++++
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index a54b035d6a6c..50840a2887a5 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -426,17 +426,13 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  		struct mempolicy *mpol, pgoff_t ilx, bool *new_page_allocated,
>  		bool skip_if_exists)
>  {
> -	struct swap_info_struct *si;
> +	struct swap_info_struct *si = swp_swap_info(entry);
>  	struct folio *folio;
>  	struct folio *new_folio = NULL;
>  	struct folio *result = NULL;
>  	void *shadow = NULL;
>  
>  	*new_page_allocated = false;
> -	si = get_swap_device(entry);
> -	if (!si)
> -		return NULL;
> -
>  	for (;;) {
>  		int err;
>  		/*
> @@ -532,7 +528,6 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  	put_swap_folio(new_folio, entry);
>  	folio_unlock(new_folio);
>  put_and_return:
> -	put_swap_device(si);
>  	if (!(*new_page_allocated) && new_folio)
>  		folio_put(new_folio);
>  	return result;
> @@ -552,11 +547,16 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  		struct vm_area_struct *vma, unsigned long addr,
>  		struct swap_iocb **plug)
>  {
> +	struct swap_info_struct *si;
>  	bool page_allocated;
>  	struct mempolicy *mpol;
>  	pgoff_t ilx;
>  	struct folio *folio;
>  
> +	si = get_swap_device(entry);
> +	if (!si)
> +		return NULL;
> +
>  	mpol = get_vma_policy(vma, addr, 0, &ilx);
>  	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
>  					&page_allocated, false);
> @@ -564,6 +564,8 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  
>  	if (page_allocated)
>  		swap_read_folio(folio, plug);
> +
> +	put_swap_device(si);
>  	return folio;
>  }
>  
> diff --git a/mm/zswap.c b/mm/zswap.c
> index ac9d299e7d0c..83dfa1f9e689 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1051,14 +1051,20 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  	struct folio *folio;
>  	struct mempolicy *mpol;
>  	bool folio_was_allocated;
> +	struct swap_info_struct *si;
>  	struct writeback_control wbc = {
>  		.sync_mode = WB_SYNC_NONE,
>  	};
>  
>  	/* try to allocate swap cache folio */
> +	si = get_swap_device(swpentry);
> +	if (!si)
> +		return -EEXIST;
> +
>  	mpol = get_task_policy(current);
>  	folio = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
>  				NO_INTERLEAVE_INDEX, &folio_was_allocated, true);
> +	put_swap_device(si);
>  	if (!folio)
>  		return -ENOMEM;
>  
> -- 
> 2.48.1
> 


