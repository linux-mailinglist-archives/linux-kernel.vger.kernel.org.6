Return-Path: <linux-kernel+bounces-179155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE228C5C77
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC2D11C218FA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51EB339A0;
	Tue, 14 May 2024 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OGQpwThJ"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9921DFD1
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 20:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715719741; cv=none; b=QJfrpBGFMSLbZVoy7DZbTR1dOv3tPloZDmGnrlj0QQ+fHvka34idSKzkql2Xrqlth6QJ56ykvYO8IPSAm5DzJL/Qq9QLv67O4GV79ccZ/7UYb7GC/AHtndqxm0PyTAjjkDu/scSYFCMibPTME1kx3/cMZfJBUA1yLSnCNdVg+Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715719741; c=relaxed/simple;
	bh=+kC3x8SXXb0no0oRx22C1RCk9ERpR8hzu7TzSlw8wEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bei6XDjck1LhfmywWD/vzpzEj5Xxzbma2uulMg6ZI0hP+WMp9PVOcW3AeWwQeTT8eKrfAxsKz5ZS9m030xdN0BMqkBkwJNHjZqjTTIOfPaeStX+bCRBfn8A4GNnYsWUdqlyAV7O2j8DX/okOyVk6Z09NXmy6czFe2g28F+/6154=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OGQpwThJ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 14 May 2024 13:48:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715719737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vjO7VnrroqxxgnD3OiMZO9Nx30PMYAUaL1ENaC7gzp0=;
	b=OGQpwThJqbh+faErC9luLSfbckj35Wc0Ehw3+nSaXp9SeE7K4BbMHDB74xYP0iRy49c8iV
	0FPeMy9LX1E2pl9GAgAFJ4KQq6jO9kP2IghKENNjf3jOeLwUzPt5S7bt2ZGWSeumNApQDp
	KHHP+Ef5Nqvk58wjoPRIH+AgL9SKHUQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: vmscan: restore incremental cgroup iteration
Message-ID: <whvb6gkmciiogjoevep6pep6ibkjxoabgckeog6dejn4wjqxpj@przngnktv255>
References: <20240514202641.2821494-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514202641.2821494-1-hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Tue, May 14, 2024 at 04:26:41PM -0400, Johannes Weiner wrote:
> Currently, reclaim always walks the entire cgroup tree in order to
> ensure fairness between groups. While overreclaim is limited in
> shrink_lruvec(), many of our systems have a sizable number of active
> groups, and an even bigger number of idle cgroups with cache left
> behind by previous jobs; the mere act of walking all these cgroups can
> impose significant latency on direct reclaimers.
> 
> In the past, we've used a save-and-restore iterator that enabled
> incremental tree walks over multiple reclaim invocations. This ensured
> fairness, while keeping the work of individual reclaimers small.
> 
> However, in edge cases with a lot of reclaim concurrency, individual
> reclaimers would sometimes not see enough of the cgroup tree to make
> forward progress and (prematurely) declare OOM. Consequently we
> switched to comprehensive walks in 1ba6fc9af35b ("mm: vmscan: do not
> share cgroup iteration between reclaimers").
> 
> To address the latency problem without bringing back the premature OOM
> issue, reinstate the shared iteration, but with a restart condition to
> do the full walk in the OOM case - similar to what we do for
> memory.low enforcement and active page protection.
> 
> In the worst case, we do one more full tree walk before declaring
> OOM. But the vast majority of direct reclaim scans can then finish
> much quicker, while fairness across the tree is maintained:
> 
> - Before this patch, we observed that direct reclaim always takes more
>   than 100us and most direct reclaim time is spent in reclaim cycles
>   lasting between 1ms and 1 second. Almost 40% of direct reclaim time
>   was spent on reclaim cycles exceeding 100ms.
> 
> - With this patch, almost all page reclaim cycles last less than 10ms,
>   and a good amount of direct page reclaim finishes in under 100us. No
>   page reclaim cycles lasting over 100ms were observed anymore.
> 
> The shared iterator state is maintaned inside the target cgroup, so
> fair and incremental walks are performed during both global reclaim
> and cgroup limit reclaim of complex subtrees.
> 
> Reported-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Rik van Riel <riel@surriel.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

