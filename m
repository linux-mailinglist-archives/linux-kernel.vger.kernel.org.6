Return-Path: <linux-kernel+bounces-270817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CBB9445AF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE54C2844EE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D7516DC26;
	Thu,  1 Aug 2024 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a3Y8tU0A"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3F316E873
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722498028; cv=none; b=fn8OWMBfMrE/IprtrtYdeQiYa9s6Hkkbe498DDWb3PKUt8LdEh1ttKlqSvXVdzU8BRB6JJtOxRoV7ADbdmMGmm6Jsq+bR207X/OkgRroBoc8FoPX2OQSpmuqfD3zHygr4usj7McBMo1zhIQu2ZTulwsRRzfdqJdFCFs8yP+qLfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722498028; c=relaxed/simple;
	bh=1Mo170MEqWYE8iXq7EtIicNW3KDkr58Uq1oHYaKH8CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpigLiX2JxkKQwOCPkLIZEWN1NixqWmZdDef9TFrk/Cthj7pz2aUXMQvpCfouH2EkQWe4tJd9Lmq6vhGin5sEJVeJwplxGiMkjpMH7RHrOkA4oJ7iLZxvq1b10+abp346cMwQSdfFvQm7TdAbAinwSj0lMGxJTADxpQuug7XB68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a3Y8tU0A; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1f6b254f-9cb9-412e-b249-8efe1d4157d3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722498023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/u+SH4i1Z7tjJAmzXcks2waJHC8XQ7VaoTerFrtHEN0=;
	b=a3Y8tU0AFKNAPurAuJwvW1gPaQoLKgF4o5a3ubZhr6ExwgDRneIMW/p8t815nAVbWP2oPB
	CvLQBA2YyuExTus+UPHw1EVawPqCXOWZ07o1n3MwLg3MjcP4TlpVK2z9EFeV6tCMgosJIa
	VBhzrY02K8sN4mJEzi3MomWKS5V+cD0=
Date: Thu, 1 Aug 2024 15:40:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 2/2] mm: zswap: fix global shrinker error handling
 logic
To: Takero Funaki <flintglass@gmail.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Nhat Pham <nphamcs@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240731004918.33182-1-flintglass@gmail.com>
 <20240731004918.33182-3-flintglass@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240731004918.33182-3-flintglass@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/7/31 08:49, Takero Funaki wrote:
> This patch fixes the zswap global shrinker, which did not shrink the
> zpool as expected.
> 
> The issue addressed is that shrink_worker() did not distinguish between
> unexpected errors and expected errors, such as failed writeback from an
> empty memcg. The shrinker would stop shrinking after iterating through
> the memcg tree 16 times, even if there was only one empty memcg.
> 
> With this patch, the shrinker no longer considers encountering an empty
> memcg, encountering a memcg with writeback disabled, or reaching the end
> of a memcg tree walk as a failure, as long as there are memcgs that are
> candidates for writeback. Systems with one or more empty memcgs will now
> observe significantly higher zswap writeback activity after the zswap
> pool limit is hit.
> 
> To avoid an infinite loop when there are no writeback candidates, this
> patch tracks writeback attempts during memcg tree walks and limits
> reties if no writeback candidates are found.
> 
> To handle the empty memcg case, the helper function shrink_memcg() is
> modified to check if the memcg is empty and then return -ENOENT.
> 
> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> Signed-off-by: Takero Funaki <flintglass@gmail.com>

Looks good to me:

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
>   mm/zswap.c | 40 +++++++++++++++++++++++++++++++++-------
>   1 file changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 3c16a1192252..d46caa42ed4f 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1287,10 +1287,10 @@ static struct shrinker *zswap_alloc_shrinker(void)
>   
>   static int shrink_memcg(struct mem_cgroup *memcg)
>   {
> -	int nid, shrunk = 0;
> +	int nid, shrunk = 0, scanned = 0;
>   
>   	if (!mem_cgroup_zswap_writeback_enabled(memcg))
> -		return -EINVAL;
> +		return -ENOENT;
>   
>   	/*
>   	 * Skip zombies because their LRUs are reparented and we would be
> @@ -1304,21 +1304,34 @@ static int shrink_memcg(struct mem_cgroup *memcg)
>   
>   		shrunk += list_lru_walk_one(&zswap_list_lru, nid, memcg,
>   					    &shrink_memcg_cb, NULL, &nr_to_walk);
> +		scanned += 1 - nr_to_walk;
>   	}
> +
> +	if (!scanned)
> +		return -ENOENT;
> +
>   	return shrunk ? 0 : -EAGAIN;
>   }
>   
>   static void shrink_worker(struct work_struct *w)
>   {
>   	struct mem_cgroup *memcg;
> -	int ret, failures = 0;
> +	int ret, failures = 0, attempts = 0;
>   	unsigned long thr;
>   
>   	/* Reclaim down to the accept threshold */
>   	thr = zswap_accept_thr_pages();
>   
>   	/*
> -	 * Global reclaim will select cgroup in a round-robin fashion.
> +	 * Global reclaim will select cgroup in a round-robin fashion from all
> +	 * online memcgs, but memcgs that have no pages in zswap and
> +	 * writeback-disabled memcgs (memory.zswap.writeback=0) are not
> +	 * candidates for shrinking.
> +	 *
> +	 * Shrinking will be aborted if we encounter the following
> +	 * MAX_RECLAIM_RETRIES times:
> +	 * - No writeback-candidate memcgs found in a memcg tree walk.
> +	 * - Shrinking a writeback-candidate memcg failed.
>   	 *
>   	 * We save iteration cursor memcg into zswap_next_shrink,
>   	 * which can be modified by the offline memcg cleaner
> @@ -1356,9 +1369,14 @@ static void shrink_worker(struct work_struct *w)
>   		spin_unlock(&zswap_shrink_lock);
>   
>   		if (!memcg) {
> -			if (++failures == MAX_RECLAIM_RETRIES)
> +			/*
> +			 * Continue shrinking without incrementing failures if
> +			 * we found candidate memcgs in the last tree walk.
> +			 */
> +			if (!attempts && ++failures == MAX_RECLAIM_RETRIES)
>   				break;
>   
> +			attempts = 0;
>   			goto resched;
>   		}
>   
> @@ -1366,8 +1384,16 @@ static void shrink_worker(struct work_struct *w)
>   		/* drop the extra reference */
>   		mem_cgroup_put(memcg);
>   
> -		if (ret == -EINVAL)
> -			break;
> +		/*
> +		 * There are no writeback-candidate pages in the memcg.
> +		 * This is not an issue as long as we can find another memcg
> +		 * with pages in zswap. Skip this without incrementing attempts
> +		 * and failures.
> +		 */
> +		if (ret == -ENOENT)
> +			continue;
> +		++attempts;
> +
>   		if (ret && ++failures == MAX_RECLAIM_RETRIES)
>   			break;
>   resched:

