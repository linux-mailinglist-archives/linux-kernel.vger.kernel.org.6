Return-Path: <linux-kernel+bounces-315891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA28296C83D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AB22866E8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D6A145A05;
	Wed,  4 Sep 2024 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iXFUNW9G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7556BFA3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 20:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481093; cv=none; b=lYN16XtFd1Zo/MDVgbWAS4Wpsur6ntF1Oi/1zIF+b75mYMMwyFr3mKyQpOzWdwNygi6CS+iDeHUAUbBcBj4byiLiIUbhMl8oMTrMXpV1CD5xjqowX7V+a5A4znLiFsrMGVqkpvYelSMO/w50YSxG6vUqCmZ8OTbr/4Sj48HreGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481093; c=relaxed/simple;
	bh=CoqXSn1sTq8nn+oU+UgxqJ42Ebvl7TulVgM+ZPkzvlU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=X1mzaf/GM4R+Rx560MIJjInP8gheUxGLejtjq1pOdxzPnqRTsrWyiMuWtvzMzSKy5NGD88dvUsVk68x+nOMqC3BToDvEfjPLq6rtco2hy/cpN3TlEIog/dCrEESoZVAuHvH45inbKFgqMvty8dWq05lPdGJyMbRPth6c6Qak45Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iXFUNW9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB95DC4CEC5;
	Wed,  4 Sep 2024 20:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725481092;
	bh=CoqXSn1sTq8nn+oU+UgxqJ42Ebvl7TulVgM+ZPkzvlU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iXFUNW9G1AwOdKXtwIP6OBuxUSBgSxQs5mBF/8Y17zDXrNJY/hLc2lkKuBoTwYQfg
	 oVxjFp9IvOxUSoBRM6Guvd4dJPE6HSPkaBHA+I62YVt47wc3cO0U1t3TjFKTRm405V
	 PyLMaxBmfp7Fs8xEnTdQUw9k9DXjB47NqrsJQBGg=
Date: Wed, 4 Sep 2024 13:18:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-mm@kvack.org, mhocko@kernel.org, rientjes@google.com,
 yosryahmed@google.com, hannes@cmpxchg.org, almasrymina@google.com,
 roman.gushchin@linux.dev, gthelen@google.com, dseo3@uci.edu,
 a.manzanares@samsung.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: introduce per-node proactive reclaim
 interface
Message-Id: <20240904131811.234e005307f249ef07670c20@linux-foundation.org>
In-Reply-To: <20240904162740.1043168-1-dave@stgolabs.net>
References: <20240904162740.1043168-1-dave@stgolabs.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Sep 2024 09:27:40 -0700 Davidlohr Bueso <dave@stgolabs.net> wrote:

> This adds support for allowing proactive reclaim in general on a
> NUMA system. A per-node interface extends support for beyond a
> memcg-specific interface, respecting the current semantics of
> memory.reclaim: respecting aging LRU and not supporting
> artificially triggering eviction on nodes belonging to non-bottom
> tiers.
> 
> This patch allows userspace to do:
> 
>      echo 512M swappiness=10 > /sys/devices/system/node/nodeX/reclaim

One value per sysfs file is a rule.

> One of the premises for this is to semantically align as best as
> possible with memory.reclaim. During a brief time memcg did
> support nodemask until 55ab834a86a9 (Revert "mm: add nodes=
> arg to memory.reclaim"), for which semantics around reclaim
> (eviction) vs demotion were not clear, rendering charging
> expectations to be broken.
> 
> With this approach:
> 
> 1. Users who do not use memcg can benefit from proactive reclaim.
> 
> 2. Proactive reclaim on top tiers will trigger demotion, for which
> memory is still byte-addressable. Reclaiming on the bottom nodes
> will trigger evicting to swap (the traditional sense of reclaim).
> This follows the semantics of what is today part of the aging process
> on tiered memory, mirroring what every other form of reclaim does
> (reactive and memcg proactive reclaim). Furthermore per-node proactive
> reclaim is not as susceptible to the memcg charging problem mentioned
> above.
> 
> 3. Unlike memcg, there should be no surprises of callers expecting
> reclaim but instead got a demotion. Essentially relying on behavior
> of shrink_folio_list() after 6b426d071419 (mm: disable top-tier
> fallback to reclaim on proactive reclaim), without the expectations
> of try_to_free_mem_cgroup_pages().
> 
> 4. Unlike the nodes= arg, this interface avoids confusing semantics,
> such as what exactly the user wants when mixing top-tier and low-tier
> nodes in the nodemask. Further per-node interface is less exposed to
> "free up memory in my container" usecases, where eviction is intended.
> 
> 5. Users that *really* want to free up memory can use proactive reclaim
> on nodes knowingly to be on the bottom tiers to force eviction in a
> natural way - higher access latencies are still better than swap.
> If compelled, while no guarantees and perhaps not worth the effort,
> users could also also potentially follow a ladder-like approach to
> eventually free up the memory. Alternatively, perhaps an 'evict' option
> could be added to the parameters for both memory.reclaim and per-node
> interfaces to force this action unconditionally.
> 
> ...
>
> --- a/Documentation/ABI/stable/sysfs-devices-node
> +++ b/Documentation/ABI/stable/sysfs-devices-node
> @@ -221,3 +221,14 @@ Contact:	Jiaqi Yan <jiaqiyan@google.com>
>  Description:
>  		Of the raw poisoned pages on a NUMA node, how many pages are
>  		recovered by memory error recovery attempt.
> +
> +What:		/sys/devices/system/node/nodeX/reclaim
> +Date:		September 2024
> +Contact:	Linux Memory Management list <linux-mm@kvack.org>
> +Description:
> +		This is write-only nested-keyed file which accepts the number of

"is a write-only".

What does "nested keyed" mean?

> +		bytes to reclaim as well as the swappiness for this particular
> +		operation. Write the amount of bytes to induce memory reclaim in
> +		this node. When it completes successfully, the specified amount
> +		or more memory will have been reclaimed, and -EAGAIN if less
> +		bytes are reclaimed than the specified amount.

Could be that this feature would benefit from a more expansive
treatment under Documentation/somewhere.

>
> ...
>
> +#if defined(CONFIG_SYSFS) && defined(CONFIG_NUMA)
> +
> +enum {
> +	MEMORY_RECLAIM_SWAPPINESS = 0,
> +	MEMORY_RECLAIM_NULL,
> +};
> +
> +static const match_table_t tokens = {
> +	{ MEMORY_RECLAIM_SWAPPINESS, "swappiness=%d"},
> +	{ MEMORY_RECLAIM_NULL, NULL },
> +};
> +
> +static ssize_t reclaim_store(struct device *dev,
> +			     struct device_attribute *attr,
> +			     const char *buf, size_t count)
> +{
> +	int nid = dev->id;
> +	gfp_t gfp_mask = GFP_KERNEL;
> +	struct pglist_data *pgdat = NODE_DATA(nid);
> +	unsigned long nr_to_reclaim, nr_reclaimed = 0;
> +	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> +	int swappiness = -1;
> +	char *old_buf, *start;
> +	substring_t args[MAX_OPT_ARGS];
> +	struct scan_control sc = {
> +		.gfp_mask = current_gfp_context(gfp_mask),
> +		.reclaim_idx = gfp_zone(gfp_mask),
> +		.priority = DEF_PRIORITY,
> +		.may_writepage = !laptop_mode,
> +		.may_unmap = 1,
> +		.may_swap = 1,
> +		.proactive = 1,
> +	};
> +
> +	buf = strstrip((char *)buf);
> +
> +	old_buf = (char *)buf;
> +	nr_to_reclaim = memparse(buf, (char **)&buf) / PAGE_SIZE;
> +	if (buf == old_buf)
> +		return -EINVAL;
> +
> +	buf = strstrip((char *)buf);
> +
> +	while ((start = strsep((char **)&buf, " ")) != NULL) {
> +		if (!strlen(start))
> +			continue;
> +		switch (match_token(start, tokens, args)) {
> +		case MEMORY_RECLAIM_SWAPPINESS:
> +			if (match_int(&args[0], &swappiness))
> +				return -EINVAL;
> +			if (swappiness < MIN_SWAPPINESS || swappiness > MAX_SWAPPINESS)
> +				return -EINVAL;

Code forgot to use local `swappiness' for any purpose?

> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
>
> ...
>

