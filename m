Return-Path: <linux-kernel+bounces-243841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1BA929B63
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B2D4B20BCA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 04:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC06CB662;
	Mon,  8 Jul 2024 04:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jrkI4T9J"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23EDAD2C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 04:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720414466; cv=none; b=hQmdUh1giw6pJqdk2NlCKNl+pkoHoqBOa2iPIFty6UlO79AeocqmA3MK76wQYktrSDkA+YEGg/n04C1ILeO4DmphDYZ4nmBypIOsFIM0e7vGZGu3c6PRhpRwNkjtL7HEPuBWjfLVjDSIq06z6NMcztAzP/D8k2arLv7FNtnKGko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720414466; c=relaxed/simple;
	bh=kVBcAvCsxaytSilJDWdLok1HIaNJpM+krqj/IX3mqCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgFFpjzDgqLFdRvJFtP6osHCqspWJ2ZA1pgtThqbtpbQFaHXPXJsZHv1WGZ5ypP9VDNsRNdu5dDupWtur8NPkmdeQPCmQBirt6i9lZP8odb0K8uvwWws4XaLpPIJDujVDwRcGqypmXxWWjQEsRwjCDw8OhNrTJ8U+BHkXsysWcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jrkI4T9J; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: flintglass@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720414461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c8VB2k+22kNRa5tSGO9soknpb8V7NY0s9flzhhUjA1E=;
	b=jrkI4T9JAAC0EaOGUXqEtlyRdfleKVup21oCRIxI45rjcv9zDWrzAcJcBJ53971i9WoIAe
	a5mKFSKGX6DRpa/VRRd8eRL7dAq2TmwV8OuckX9oulNX0psbR7+wSsbqRkgrRw0MYai8nc
	1dA1OrJsqN9uvbN4KweoLBDtfrvZg3E=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: corbet@lwn.net
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: cerasuolodomenico@gmail.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-doc@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <58163ead-b0b2-444b-adab-ced887210b83@linux.dev>
Date: Mon, 8 Jul 2024 12:54:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/6] mm: zswap: fix global shrinker memcg iteration
To: Takero Funaki <flintglass@gmail.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Nhat Pham <nphamcs@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240706022523.1104080-1-flintglass@gmail.com>
 <20240706022523.1104080-2-flintglass@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240706022523.1104080-2-flintglass@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/7/6 10:25, Takero Funaki wrote:
> This patch fixes an issue where the zswap global shrinker stopped
> iterating through the memcg tree.
> 
> The problem was that shrink_worker() would stop iterating when a memcg
> was being offlined and restart from the tree root.  Now, it properly
> handles the offlie memcg and continues shrinking with the next memcg.

	      ^offline

> 
> Note that, to avoid a refcount leak of offline memcg encountered during
> the memcg tree walking, shrink_worker() must continue iterating to find
> the next online memcg.

Yeah, mem_cgroup_tryget_online() ensures that we get an online memcg to 
shrink.

> 
> The following minor issues in the existing code are also resolved by the
> change in the iteration logic:
> 
> - A rare temporary refcount leak in the offline memcg cleaner, where the
>    next memcg of the offlined memcg is also offline.  The leaked memcg
>    cannot be freed until the next shrink_worker() releases the reference.

Is this a problem encountered in real life? I'm a little confused, since
we move cursor under the lock protection, and any offlining memcg will 
come here to move cursor to the next one. I don't get how refcount leak
happens?

> 
> - One memcg was skipped from shrinking when the offline memcg cleaner
>    advanced the cursor of memcg tree. It is addressed by a flag to
>    indicate that the cursor has already been advanced.

Sorry, I also don't get this. Obviously, we should skip offline memcg to
shrink, the reason is that offline memcg would reparent its LRU and 
objcg, so moving cursor to the next online one is fine? Maybe I missed 
something?

Thanks.

> 
> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> Signed-off-by: Takero Funaki <flintglass@gmail.com>
> ---
>   mm/zswap.c | 94 ++++++++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 73 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index a50e2986cd2f..29944d8145af 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -171,6 +171,7 @@ static struct list_lru zswap_list_lru;
>   /* The lock protects zswap_next_shrink updates. */
>   static DEFINE_SPINLOCK(zswap_shrink_lock);
>   static struct mem_cgroup *zswap_next_shrink;
> +static bool zswap_next_shrink_changed;
>   static struct work_struct zswap_shrink_work;
>   static struct shrinker *zswap_shrinker;
>   
> @@ -775,12 +776,39 @@ void zswap_folio_swapin(struct folio *folio)
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
> +		/*
> +		 * We advances the cursor to put back the offlined memcg.
> +		 * shrink_worker() should not advance the cursor again.
> +		 */
> +		zswap_next_shrink_changed = true;
> +
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
> @@ -1319,18 +1347,42 @@ static void shrink_worker(struct work_struct *w)
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
> +	 * If we get an offline memcg, we cannot determine the cleaner has
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
> +		 * To not skip a memcg, do not advance the cursor when it has
> +		 * already been advanced by the offline cleaner.
> +		 */
> +		do {
> +			if (zswap_next_shrink_changed) {
> +				/* cleaner advanced the cursor */
> +				zswap_next_shrink_changed = false;
> +			} else {
> +				zswap_next_shrink = mem_cgroup_iter(NULL,
> +						zswap_next_shrink, NULL);
> +			}
> +			memcg = zswap_next_shrink;
> +		} while (memcg && !mem_cgroup_tryget_online(memcg));
> +
> +		/*
>   		 * Note that if we got an online memcg, we will keep the extra
>   		 * reference in case the original reference obtained by mem_cgroup_iter
>   		 * is dropped by the zswap memcg offlining callback, ensuring that the
> @@ -1344,17 +1396,11 @@ static void shrink_worker(struct work_struct *w)
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
> @@ -1368,6 +1414,12 @@ static void shrink_worker(struct work_struct *w)
>   resched:
>   		cond_resched();
>   	} while (zswap_total_pages() > thr);
> +
> +	/*
> +	 * We can still hold the original memcg reference.
> +	 * The reference is stored in zswap_next_shrink, and then reused
> +	 * by the next shrink_worker().
> +	 */
>   }
>   
>   /*********************************

