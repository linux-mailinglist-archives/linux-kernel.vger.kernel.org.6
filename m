Return-Path: <linux-kernel+bounces-258511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2744938904
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0AF1F215D0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727C71B5AA;
	Mon, 22 Jul 2024 06:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZchxHqd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC1C1946B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721630698; cv=none; b=c3oZ3kY0Hg2VaegWS8PDOLOJkgVMmMwFntgzkTlLUO5xpF9JIzErToNkZHx0O+qVXqXT/RwHcsQWgbVQBNvKHYbvequkUGjixwzkBAt8wKcy8/TzzXwAOTNEgISX2CaSn6+troL9LPRqgdE68V8wPoJKWznwBAbdCiSPHjzgsI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721630698; c=relaxed/simple;
	bh=imk9qeSKssMP43EivBkJbYhgn7TTBeSWRGr8uYPHarE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VN3mBGUy9nl1vgk5jIx4gyfcZ7n8C5LgoFgUfSWQZS91vD7BEXg+syNbvr6mEWjpR4FI13plbv4XkZl0fXVfFZx74e2akZ15EFw/WAvorExGUNO3WCYMFZ0IV5nQ9u7bPrzDzFAepr4Q4yLbnmlLE3KzlaHPTLMNmHVyzD4TJxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZchxHqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E6FC116B1;
	Mon, 22 Jul 2024 06:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721630698;
	bh=imk9qeSKssMP43EivBkJbYhgn7TTBeSWRGr8uYPHarE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pZchxHqdqBUFU9p0ToSXaXNKrQ04OA3kBhc70bnnMvMvAJCCDRgY2zmKIDIVAVm7y
	 eXPKKDpImJ+ItIfLET+7e5Ts4AIjyzuRve/+juai4oRscrh99YpcH25x+J6+jQIhXQ
	 kYad+nN1HaDiQklfucwBG4kDcKi959669FZul7rpldzfCc9lS2OoH+WHxsJ/gGWVXw
	 p3JV/nVTvt0QY/IIIYTGBpgGkhgkj+MH4oWD5jOT6hzRCWNrcmXTqMYRo9XvWYllRb
	 13zxqdCICGJNgA5DZHXOTvIad6zCmnJpSfdCRhtWzCtz9YIKa2e+PAzHpNRg4CSmzN
	 TxBUmtkrcYiJw==
Message-ID: <8323327f-3386-48ba-8554-10a5a6d12a04@kernel.org>
Date: Mon, 22 Jul 2024 08:44:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/page_alloc: Fix pcp->count race between
 drain_pages_zone() vs __rmqueue_pcplist()
To: Li Zhijian <lizhijian@fujitsu.com>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 Yasunori Gotou <y-goto@fujitsu.com>, David Hildenbrand <david@redhat.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>
References: <20240722021059.1076399-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20240722021059.1076399-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/24 4:10 AM, Li Zhijian wrote:
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
> drain_pages_zone(), to ensure no pages are left in the pcp list after
> zone_pcp_disable()
> 
> [1] https://lore.kernel.org/linux-mm/6a07125f-e720-404c-b2f9-e55f3f166e85@fujitsu.com/
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Reported-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Can we find a breaking commit for Fixes: ?

> ---
> V2:
>     - Narrow down the scope of the spin_lock() to limit the draining latency. # Vlastimil and David
>     - In above scenario, it's sufficient to read pcp->count once with lock held, and it fully fixed
>       my issue[1] in thounds runs(It happened in more than 5% before).

That should be ok indeed, but...

> RFC:
>     https://lore.kernel.org/linux-mm/20240716073929.843277-1-lizhijian@fujitsu.com/
> ---
>  mm/page_alloc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9ecf99190ea2..5388a35c4e9c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2323,8 +2323,11 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
>  static void drain_pages_zone(unsigned int cpu, struct zone *zone)
>  {
>  	struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
> -	int count = READ_ONCE(pcp->count);
> +	int count;
>  
> +	spin_lock(&pcp->lock);
> +	count = pcp->count;
> +	spin_unlock(&pcp->lock);
>  	while (count) {
>  		int to_drain = min(count, pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
>  		count -= to_drain;

It's wasteful to do a lock/unlock cycle just to read the count. It could
rather look something like this:

while (true)
    spin_lock(&pcp->lock);
    count = pcp->count;
    ...
    count -= to_drain;
    if (to_drain)
        drain_zone_pages(...)
    ...
    spin_unlock(&pcp->lock);
    if (count)
         break;

