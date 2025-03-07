Return-Path: <linux-kernel+bounces-550333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12629A55E0C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE11174666
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3320C188735;
	Fri,  7 Mar 2025 03:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AgCqIWpL"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FFC18DB28
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 03:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741316940; cv=none; b=bv3zx3dyFJhnkKh9YEu6UnX3nM/NvyaorCmTkZiPaxSty3fb8Cblahe9ssT+reARK+MS8GYlJJgBEf8WLptt36Q+0uZtmXPbwtPaDFoDKwLF43AQoHkj7cfSBbwc6+09EUrL/WQt1UpqyaLV5Uj1fpwN+h7DAlBPP+X7YHsuDRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741316940; c=relaxed/simple;
	bh=rPDAhQ4EB4WVZsDyVheJXmGujkFALoq3IqVcIAPgSjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPojYjC5KP6mTFmAg8PUODtkIdlwtBNBptyFtYmVhz2zQehUXwvZA3N3IWD6nIeG2ZbiiuYFE36hLBBdUmLmZHR0s88etbv5P9/9PbiBbzDyAJEDE3xyJbhdQzuue3dtW/K61ABqO6eH6cg4FdaIcqyCKk4Xvcwu186shEWErv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AgCqIWpL; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2de2e9d7-fed0-4b12-ad46-c1c929536841@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741316936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lFHnQoDhULwBo+CizMvo9bJ3CI3mV8Yol5FFqQgvhg8=;
	b=AgCqIWpLqopIjfBIzvb8zoIdqTIuMUyHVEg/d3veDP1kpHAsTKM7ZuYJt/zZI6X/k2i6ax
	OB9ONF9K8VoT4r00lRoMaF/j0ACfzGniRF/RAtmX+uDC4uz2lEZlzQCM1kAz6ciLkl//jm
	uK/zOVFO1DuXa6h91YWAgYVLecruIFc=
Date: Fri, 7 Mar 2025 11:08:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] page_io: return proper error codes for
 swap_read_folio_zeromap()
To: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, yosryahmed@google.com, yosry.ahmed@linux.dev,
 linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
References: <20250306230015.1456794-1-nphamcs@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20250306230015.1456794-1-nphamcs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/3/7 07:00, Nhat Pham wrote:
> Similar to zswap_load(), also return proper error codes for
> swap_read_folio_zeromap():
> 
> * 0 on success. The folio is unlocked and marked up-to-date.
> * -ENOENT, if the folio is entirely not zeromapped.
> * -EINVAL (with the follio unlocked but not marked to date), if the
>    folio is partially zeromapped. This is not supported, and will SIGBUS
>    the faulting process.
> 
> This patch is purely a clean-up, and should not have any behavioral
> change. It is based on (and should be applied on top of) [1].
> 
> [1]: https://lore.kernel.org/linux-mm/20250306205011.784787-1-nphamcs@gmail.com/
> 
> Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks!

> ---
>   mm/page_io.c | 35 ++++++++++++++++++++++++++---------
>   1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 4bce19df557b..48ed1e810392 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -511,7 +511,23 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
>   	mempool_free(sio, sio_pool);
>   }
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
> + */
> +static int swap_read_folio_zeromap(struct folio *folio)
>   {
>   	int nr_pages = folio_nr_pages(folio);
>   	struct obj_cgroup *objcg;
> @@ -519,15 +535,17 @@ static bool swap_read_folio_zeromap(struct folio *folio)
>   
>   	/*
>   	 * Swapping in a large folio that is partially in the zeromap is not
> -	 * currently handled. Return true without marking the folio uptodate so
> +	 * currently handled. Return -EINVAL without marking the folio uptodate so
>   	 * that an IO error is emitted (e.g. do_swap_page() will sigbus).
>   	 */
>   	if (WARN_ON_ONCE(swap_zeromap_batch(folio->swap, nr_pages,
> -			&is_zeromap) != nr_pages))
> -		return true;
> +			&is_zeromap) != nr_pages)) {
> +		folio_unlock(folio);
> +		return -EINVAL;
> +	}
>   
>   	if (!is_zeromap)
> -		return false;
> +		return -ENOENT;
>   
>   	objcg = get_obj_cgroup_from_folio(folio);
>   	count_vm_events(SWPIN_ZERO, nr_pages);
> @@ -538,7 +556,8 @@ static bool swap_read_folio_zeromap(struct folio *folio)
>   
>   	folio_zero_range(folio, 0, folio_size(folio));
>   	folio_mark_uptodate(folio);
> -	return true;
> +	folio_unlock(folio);
> +	return 0;
>   }
>   
>   static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
> @@ -635,10 +654,8 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
>   	}
>   	delayacct_swapin_start();
>   
> -	if (swap_read_folio_zeromap(folio)) {
> -		folio_unlock(folio);
> +	if (swap_read_folio_zeromap(folio) != -ENOENT)
>   		goto finish;
> -	}
>   
>   	if (zswap_load(folio) != -ENOENT)
>   		goto finish;

