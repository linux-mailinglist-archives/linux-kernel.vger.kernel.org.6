Return-Path: <linux-kernel+bounces-262791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 315C793CCC9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 04:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C6C1C21A16
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 02:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3264A1BF53;
	Fri, 26 Jul 2024 02:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oF9yBUp6"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF60819470
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 02:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721962086; cv=none; b=NiX38c6+ZhfAUwsXt8NGlO2YHVvN8vFhQkVn33ApCiJn6ivD8QqYIMAdV+jJrnW1O/5fmDjDFBCc9pig/YgF4x6gqRvCVXaEPsYND8nUxruW8ao0pVDqypjl7jLTEF+n4zEaBvclNXQS+T/bO/W+couaPxXXVwo5ugfWCkfwyrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721962086; c=relaxed/simple;
	bh=AqL9XCRE0kAGLnSD7hqko1pJV6LV2WhbMGvRyq+/3LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBXuiwapvhOqKnL/kKH0HcS6DgYw3UWPQl6Hxf4rlHu7rqKv+aaVFjTj2ZUvfmGZB9GNDNJHTNdV/6y15efnWAjEiVy0ChCl56gB3x3zfFRUELhCpTq3meFD0LH7zTeRbTwwzQzEMoRfawg8krMU8Krogzf7XtwqnIFWU47q3ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oF9yBUp6; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <19b6a0ab-d408-4239-ad30-34a474b34a8f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721962080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LIQEBI1t67ThZTPmVwWyA85Ri+bycAvzIyXFhMw+wQ=;
	b=oF9yBUp6aNQslS2JQYYo+Bucj7qrTdu87hmYH6U34SEjBw63HlCXF6HepYTg3rF/ZFtQ/0
	n/m9CimfJoqLsPk/z79g5HdWjLgCDeI65VC43E2Yz8IegRCe6VPXAXXHz/7K+cCfj3k+ep
	F5nEPAqMXrWDgfP+wl0k67C0G1P/l2w=
Date: Fri, 26 Jul 2024 10:47:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/2] mm: zswap: fix global shrinker memcg iteration
To: Takero Funaki <flintglass@gmail.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Nhat Pham <nphamcs@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240720044127.508042-1-flintglass@gmail.com>
 <20240720044127.508042-2-flintglass@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240720044127.508042-2-flintglass@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/7/20 12:41, Takero Funaki wrote:
> This patch fixes an issue where the zswap global shrinker stopped
> iterating through the memcg tree.
> 
> The problem was that shrink_worker() would stop iterating when a memcg
> was being offlined and restart from the tree root.  Now, it properly
> handles the offline memcg and continues shrinking with the next memcg.
> 
> To avoid holding refcount of offline memcg encountered during the memcg
> tree walking, shrink_worker() must continue iterating to release the
> offline memcg to ensure the next memcg stored in the cursor is online.
> 
> The offline memcg cleaner has also been changed to avoid the same issue.
> When the next memcg of the offlined memcg is also offline, the refcount
> stored in the iteration cursor was held until the next shrink_worker()
> run. The cleaner must release the offline memcg recursively.
> 
> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> Signed-off-by: Takero Funaki <flintglass@gmail.com>

Looks good to me! With other comments addressed:

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
>   mm/zswap.c | 77 +++++++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 56 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index a50e2986cd2f..6528668c9af3 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -775,12 +775,33 @@ void zswap_folio_swapin(struct folio *folio)
>   	}
>   }
>   
> +/*
> + * This function should be called when a memcg is being offlined.
> + *
> + * Since the global shrinker shrink_worker() may hold a reference
> + * of the memcg, we must check and release the reference in
> + * zswap_next_shrink.
> + *
> + * shrink_worker() must handle the case where this function releases
> + * the reference of memcg being shrunk.
> + */
>   void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
>   {
>   	/* lock out zswap shrinker walking memcg tree */
>   	spin_lock(&zswap_shrink_lock);
> -	if (zswap_next_shrink == memcg)
> -		zswap_next_shrink = mem_cgroup_iter(NULL, zswap_next_shrink, NULL);
> +	if (zswap_next_shrink == memcg) {
> +		do {
> +			zswap_next_shrink = mem_cgroup_iter(NULL,
> +					zswap_next_shrink, NULL);
> +		} while (zswap_next_shrink &&
> +				!mem_cgroup_online(zswap_next_shrink));
> +		/*
> +		 * We verified the next memcg is online.  Even if the next
> +		 * memcg is being offlined here, another cleaner must be
> +		 * waiting for our lock.  We can leave the online memcg
> +		 * reference.
> +		 */
> +	}
>   	spin_unlock(&zswap_shrink_lock);
>   }
>   
> @@ -1319,18 +1340,38 @@ static void shrink_worker(struct work_struct *w)
>   	/* Reclaim down to the accept threshold */
>   	thr = zswap_accept_thr_pages();
>   
> -	/* global reclaim will select cgroup in a round-robin fashion. */
> +	/* global reclaim will select cgroup in a round-robin fashion.
> +	 *
> +	 * We save iteration cursor memcg into zswap_next_shrink,
> +	 * which can be modified by the offline memcg cleaner
> +	 * zswap_memcg_offline_cleanup().
> +	 *
> +	 * Since the offline cleaner is called only once, we cannot leave an
> +	 * offline memcg reference in zswap_next_shrink.
> +	 * We can rely on the cleaner only if we get online memcg under lock.
> +	 *
> +	 * If we get an offline memcg, we cannot determine if the cleaner has
> +	 * already been called or will be called later. We must put back the
> +	 * reference before returning from this function. Otherwise, the
> +	 * offline memcg left in zswap_next_shrink will hold the reference
> +	 * until the next run of shrink_worker().
> +	 */
>   	do {
>   		spin_lock(&zswap_shrink_lock);
> -		zswap_next_shrink = mem_cgroup_iter(NULL, zswap_next_shrink, NULL);
> -		memcg = zswap_next_shrink;
>   
>   		/*
> -		 * We need to retry if we have gone through a full round trip, or if we
> -		 * got an offline memcg (or else we risk undoing the effect of the
> -		 * zswap memcg offlining cleanup callback). This is not catastrophic
> -		 * per se, but it will keep the now offlined memcg hostage for a while.
> -		 *
> +		 * Start shrinking from the next memcg after zswap_next_shrink.
> +		 * When the offline cleaner has already advanced the cursor,
> +		 * advancing the cursor here overlooks one memcg, but this
> +		 * should be negligibly rare.
> +		 */
> +		do {
> +			zswap_next_shrink = mem_cgroup_iter(NULL,
> +						zswap_next_shrink, NULL);
> +			memcg = zswap_next_shrink;
> +		} while (memcg && !mem_cgroup_tryget_online(memcg));
> +
> +		/*
>   		 * Note that if we got an online memcg, we will keep the extra
>   		 * reference in case the original reference obtained by mem_cgroup_iter
>   		 * is dropped by the zswap memcg offlining callback, ensuring that the
> @@ -1344,17 +1385,11 @@ static void shrink_worker(struct work_struct *w)
>   			goto resched;
>   		}
>   
> -		if (!mem_cgroup_tryget_online(memcg)) {
> -			/* drop the reference from mem_cgroup_iter() */
> -			mem_cgroup_iter_break(NULL, memcg);
> -			zswap_next_shrink = NULL;
> -			spin_unlock(&zswap_shrink_lock);
> -
> -			if (++failures == MAX_RECLAIM_RETRIES)
> -				break;
> -
> -			goto resched;
> -		}
> +		/*
> +		 * We verified the memcg is online and got an extra memcg
> +		 * reference.  Our memcg might be offlined concurrently but the
> +		 * respective offline cleaner must be waiting for our lock.
> +		 */
>   		spin_unlock(&zswap_shrink_lock);
>   
>   		ret = shrink_memcg(memcg);

