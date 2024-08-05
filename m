Return-Path: <linux-kernel+bounces-274089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E2C947344
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 04:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F222B20CFD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 02:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71613E479;
	Mon,  5 Aug 2024 02:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fbNEId2C"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1541EEDC
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 02:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722823608; cv=none; b=hX3MM672vCOrLhSnw4iTEPBbzHONkPKz16HqRK8Rm2GH63hSL/HF1q80nRM1JCGmTRuT9e+Yv3IyceE+GWfOK+qIfzHmXCgoryv3VwpmUa+ChyLt8WmmARG5V8cd16MafGBRymQNshZNTp4qNq7LyfZVC1A2fASunNRCKW4Q8gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722823608; c=relaxed/simple;
	bh=QThnm43i4rNIGgFac39qGLWtmc37HM5VFEbmbB6s2Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JN+awdKd/FN83B3US9qUEs1Rup7rfnyuZktYFKqYyWu0PuW7yBdoLLo3nyEjq9ZzZgJV7CeP16HucBVXknhXTG5yVXN1PjfggSeYIGbYcZs7K3aXOQGZUghFqC8QmK3lsGaet3D0+MDPEHDUH82Q3FWU3RjPFBTb/z2vxRgK/EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fbNEId2C; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a3fc7bc6-d9c0-43e2-a530-4dafff61203b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722823602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l44H4QWdGe86dD8zQeD5JdGzKItvgmz16BSy3TEXbJU=;
	b=fbNEId2C4gLy6nbRlUcLD4xGv/QOhM21IgsaQuP1c1FeJkXLdg59LRcTK9BZ2J03zzIzq/
	G6Uvg/3/z0CEjO1BoqkIDHErxZ4aOEWfZgBnH5k0tpdCkVokkHF2qkz6OuqSW385xAwTZO
	TAoApuhi/7Pq8yklJ4WetZi+X8O/AdA=
Date: Mon, 5 Aug 2024 10:06:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: zswap: make the lock critical section obvious in
 shrink_worker()
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Takero Funaki <flintglass@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240803053306.2685541-1-yosryahmed@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240803053306.2685541-1-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/8/3 13:33, Yosry Ahmed wrote:
> Move the comments and spin_{lock/unlock}() calls around in
> shrink_worker() to make it obvious the lock is protecting the loop
> updating zswap_next_shrink.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Yeah, it's clearer.

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
> 
> This is intended to be squashed into "mm: zswap: fix global shrinker
> memcg iteration".
> 
> ---
>   mm/zswap.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index babf0abbcc765..df620eacd1d11 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1364,24 +1364,22 @@ static void shrink_worker(struct work_struct *w)
>   	 * until the next run of shrink_worker().
>   	 */
>   	do {
> -		spin_lock(&zswap_shrink_lock);
> -
>   		/*
>   		 * Start shrinking from the next memcg after zswap_next_shrink.
>   		 * When the offline cleaner has already advanced the cursor,
>   		 * advancing the cursor here overlooks one memcg, but this
>   		 * should be negligibly rare.
> +		 *
> +		 * If we get an online memcg, keep the extra reference in case
> +		 * the original one obtained by mem_cgroup_iter() is dropped by
> +		 * zswap_memcg_offline_cleanup() while we are shrinking the
> +		 * memcg.
>   		 */
> +		spin_lock(&zswap_shrink_lock);
>   		do {
>   			memcg = mem_cgroup_iter(NULL, zswap_next_shrink, NULL);
>   			zswap_next_shrink = memcg;
>   		} while (memcg && !mem_cgroup_tryget_online(memcg));
> -		/*
> -		 * Note that if we got an online memcg, we will keep the extra
> -		 * reference in case the original reference obtained by mem_cgroup_iter
> -		 * is dropped by the zswap memcg offlining callback, ensuring that the
> -		 * memcg is not killed when we are reclaiming.
> -		 */
>   		spin_unlock(&zswap_shrink_lock);
>   
>   		if (!memcg) {

