Return-Path: <linux-kernel+bounces-256306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C871934C47
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BB6CB209FB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B206C13210D;
	Thu, 18 Jul 2024 11:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/O7hlgt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029507D3EF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721301400; cv=none; b=Hwxhg3vn0o9Mp3KFpzXTgAPAIhGlPeMH0z7Q+ygEJGktwvJNgI/r1vyataoDOEZvrnVYu47nHwRwdoRnuZPdjwlixw5yO2eyfkb4pmfItXXVcRnuTMsBBy8ZLmS6OfIkKvfLHxrL/0Pwvv4EcGfhAo4vrh9hiFQw1bDkH7yzg9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721301400; c=relaxed/simple;
	bh=41McLAL0buFEegU9JpAI8+wwAy56uuO6YT3HPAfpnZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSSchrcpBcO4rqBbhvfZ/+XsSTlNC1mThvTYvsfNPT1t3mXxAytClD+4SFrktvPL7/HAhu1cy3JULVf+AFJLrwsv576bj0IIryVLB+A8zSAfEBPlGlonaFNdHwVipwFplOJlCluO6NKpsbP4QxO6ERVzxfq2ehj4U3RTINYMdWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/O7hlgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E604BC116B1;
	Thu, 18 Jul 2024 11:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721301399;
	bh=41McLAL0buFEegU9JpAI8+wwAy56uuO6YT3HPAfpnZc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O/O7hlgtxbeSUrMj49RzBgA7RI7Mz4tx2bmVlmn4bvyGhumV/FRUw8RHEg4iROuE/
	 +HM3mVEl3FjdKXN6UIcybeiRPRvbviRMa0jU0TnBO8G9RvOaeD8EpbDlXD9iPgjA3+
	 GtLqnsXczne2F0Tz2Kx30jEcxz/tGVfSrIDlilLHQXaGYFSIIjhi3+ipq6SvaZk7eJ
	 j5U2BcbuKeZXmKAMMq/1Wmws0uQ7Bk20l+tqgChaO+PFSfxtX7P13VGuLM1c4c+2Rb
	 7fpbu7VMbfYi447hACzgRaS8HBmW0irXOQTV6kKjzoKRs/xNzml3HDrrE+u74DYeZ0
	 jE6FU9I4c4Ljw==
Message-ID: <6f2151a9-da23-4917-b985-8de6b0852e37@kernel.org>
Date: Thu, 18 Jul 2024 13:16:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm/page_alloc: Fix pcp->count race between
 drain_pages_zone() vs __rmqueue_pcplist()
Content-Language: en-US
To: Li Zhijian <lizhijian@fujitsu.com>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 Yasunori Gotou <y-goto@fujitsu.com>, David Hildenbrand <david@redhat.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Lucas Stach <l.stach@pengutronix.de>
References: <20240716073929.843277-1-lizhijian@fujitsu.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20240716073929.843277-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/24 9:39 AM, Li Zhijian wrote:
> It's expected that no page should be left in pcp_list after calling
> zone_pcp_disable() in offline_pages(). Previously, it's observed that
> offline_pages() gets stuck [1] due to some pages remaining in pcp_list.
> 
> Cause:
> There is a race condition between drain_pages_zone() and __rmqueue_pcplist()
> involving the pcp->count variable. See below scenario:
> 
>          CPU0                              CPU1
>     ----------------                    ---------------
>                                       spin_lock(&pcp->lock);
>                                       __rmqueue_pcplist() {
> zone_pcp_disable() {
>                                         /* list is empty */
>                                         if (list_empty(list)) {
>                                           /* add pages to pcp_list */
>                                           alloced = rmqueue_bulk()
>   mutex_lock(&pcp_batch_high_lock)
>   ...
>   __drain_all_pages() {
>     drain_pages_zone() {
>       /* read pcp->count, it's 0 here */
>       count = READ_ONCE(pcp->count)
>       /* 0 means nothing to drain */
>                                           /* update pcp->count */
>                                           pcp->count += alloced << order;
>       ...
>                                       ...
>                                       spin_unlock(&pcp->lock);
> 
> In this case, after calling zone_pcp_disable() though, there are still some
> pages in pcp_list. And these pages in pcp_list are neither movable nor
> isolated, offline_pages() gets stuck as a result.
> 
> Solution:
> Expand the scope of the pcp->lock to also protect pcp->count in
> drain_pages_zone(), ensuring no pages are left in the pcp list.
> 
> [1] https://lore.kernel.org/linux-mm/6a07125f-e720-404c-b2f9-e55f3f166e85@fujitsu.com/
> 
> Cc: David Hildenbrand <david@redhat.com>
> Reported-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  mm/page_alloc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9ecf99190ea2..1780df31d5f5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2323,16 +2323,17 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
>  static void drain_pages_zone(unsigned int cpu, struct zone *zone)
>  {
>  	struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
> -	int count = READ_ONCE(pcp->count);
> +	int count;
>  
> +	spin_lock(&pcp->lock);
> +	count = pcp->count;
>  	while (count) {
>  		int to_drain = min(count, pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
>  		count -= to_drain;
>  
> -		spin_lock(&pcp->lock);
>  		free_pcppages_bulk(zone, to_drain, pcp, 0);
> -		spin_unlock(&pcp->lock);
>  	}
> +	spin_unlock(&pcp->lock);

This way seems to be partially going against the purpose of 55f77df7d715
("mm: page_alloc: control latency caused by zone PCP draining") - the zone
lock hold time will still be limited by the batch, but not the pcp lock
time. It should still be possible to relock between the iterations? To
prevent the race I think the main part is determining pcp->count under the
lock, but release/retake should still be ok if the pcp->count is reread
after relocking.

>  }
>  
>  /*


