Return-Path: <linux-kernel+bounces-550069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E29AA55B03
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8B5189421B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B086427D77A;
	Thu,  6 Mar 2025 23:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bSNq+nD1"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A7A27811E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304542; cv=none; b=PVPQVRMg5RcqQZHcSHnD2w0UcXOK7LQGmC7iv3NO2hYvIlmcAgbzDHFsbYuS8nNMqRo99ZGU7tYtirCetXZys4qXvZ+IFUev0+2wWksC1FO5NM3GRP7YyEm6VNKbmbgXZKLKaRufAAkiOHCKIY2tCUv+VYS56Ud0PUllFBZUiK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304542; c=relaxed/simple;
	bh=LtCL5Wa78a/OLv3g+IY7kOW6zY+LdenxnBgMM/9q5fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/E9nUWKsm3vtPkI9SLqP+Yddw+ppND+R2hGnpJwoNV5+QgsMoXb0ShBaCPGr6SKfg9ixluR9dmiVBPziASYztWeHQhtFdy1P7YU65dkfJem1WUClQSIlKzYwBFhadFW1xve7hc29atcNGz22hNNyH7IW52GA7jr/uVystLJzuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bSNq+nD1; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 6 Mar 2025 23:42:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741304534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fU6cPBemXEC5vkZEvT/CCIy/jzWhHpo6npFWGn/8iRI=;
	b=bSNq+nD1O3vZsgkjn7awJJ37l2cfr7+cFXTCbKGFr854zjuC25z94Ey3ogM7Nwvj5hnuB+
	wa1rA4qoXjZTxqL1Eadkf1PdzqrSQn2LWuqUt3o6koSmCVbSG/9j4SOhLOo5mpL92/BFHQ
	8AOOM2y3mFvAYh0rOi217HSy2TSW/Lw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, chengming.zhou@linux.dev,
	linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] page_io: return proper error codes for
 swap_read_folio_zeromap()
Message-ID: <Z8oy0A-vBbGI6ux9@google.com>
References: <20250306230015.1456794-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306230015.1456794-1-nphamcs@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 06, 2025 at 03:00:15PM -0800, Nhat Pham wrote:
> Similar to zswap_load(), also return proper error codes for
> swap_read_folio_zeromap():
> 
> * 0 on success. The folio is unlocked and marked up-to-date.
> * -ENOENT, if the folio is entirely not zeromapped.
> * -EINVAL (with the follio unlocked but not marked to date), if the
>   folio is partially zeromapped. This is not supported, and will SIGBUS
>   the faulting process.
> 
> This patch is purely a clean-up, and should not have any behavioral
> change. It is based on (and should be applied on top of) [1].
> 
> [1]: https://lore.kernel.org/linux-mm/20250306205011.784787-1-nphamcs@gmail.com/
> 
> Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/page_io.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 4bce19df557b..48ed1e810392 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -511,7 +511,23 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
>  	mempool_free(sio, sio_pool);
>  }
>  
> -static bool swap_read_folio_zeromap(struct folio *folio)
> +/**
> + * swap_read_folio_zeromap - check if the folio was zeromapped, and if so,
> + *                           zero-fill it.
> + * @folio: the folio.
> + *
> + * Return: 0 on success, with the folio zero-filled, unlocked, and marked
> + * up-to-date, or one of the following error codes:
> + *
> + *  -ENOENT: the folio is entirely not zeromapped. The folio remains locked.
> + *
> + *  -EINVAL: some of the subpages in the folio are zeromaped, but not all of
> + *  them. This is an error because we don't currently support a large folio
> + *  that is partially in the zeromap. The folio is unlocked, but NOT marked
> + *  up-to-date, so that an IO error is emitted (e.g. do_swap_page() will
> + *  sigbus).

This is a bit repetitive. Maybe:

 *  -EINVAL: The folio is partially in the zeromap, which is not
 *  currently supported. The folio is unlocked, but NOT marked
 *  up-to-date, so that an IO error is emitted (e.g. do_swap_page() will
 *  sigbus).


> + */
> +static int swap_read_folio_zeromap(struct folio *folio)
>  {
>  	int nr_pages = folio_nr_pages(folio);
>  	struct obj_cgroup *objcg;
> @@ -519,15 +535,17 @@ static bool swap_read_folio_zeromap(struct folio *folio)
>  
>  	/*
>  	 * Swapping in a large folio that is partially in the zeromap is not
> -	 * currently handled. Return true without marking the folio uptodate so
> +	 * currently handled. Return -EINVAL without marking the folio uptodate so
>  	 * that an IO error is emitted (e.g. do_swap_page() will sigbus).
>  	 */

I would drop this whole comment now because it's mostly repeating what's
now documneted above.

With the comments fixed up:

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>

>  	if (WARN_ON_ONCE(swap_zeromap_batch(folio->swap, nr_pages,
> -			&is_zeromap) != nr_pages))
> -		return true;
> +			&is_zeromap) != nr_pages)) {
> +		folio_unlock(folio);
> +		return -EINVAL;
> +	}
>  
>  	if (!is_zeromap)
> -		return false;
> +		return -ENOENT;
>  
>  	objcg = get_obj_cgroup_from_folio(folio);
>  	count_vm_events(SWPIN_ZERO, nr_pages);
> @@ -538,7 +556,8 @@ static bool swap_read_folio_zeromap(struct folio *folio)
>  
>  	folio_zero_range(folio, 0, folio_size(folio));
>  	folio_mark_uptodate(folio);
> -	return true;
> +	folio_unlock(folio);
> +	return 0;
>  }
>  
>  static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
> @@ -635,10 +654,8 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
>  	}
>  	delayacct_swapin_start();
>  
> -	if (swap_read_folio_zeromap(folio)) {
> -		folio_unlock(folio);
> +	if (swap_read_folio_zeromap(folio) != -ENOENT)
>  		goto finish;
> -	}
>  
>  	if (zswap_load(folio) != -ENOENT)
>  		goto finish;
> -- 
> 2.43.5
> 

