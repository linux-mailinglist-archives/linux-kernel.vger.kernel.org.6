Return-Path: <linux-kernel+bounces-294730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2419591BA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC71283458
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956E46FA8;
	Wed, 21 Aug 2024 00:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uX9ffBcf"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF17134AC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 00:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724199722; cv=none; b=TLENzgE32eQ/WdF9+QhNygyLyWgUhCod+SclwCelSpdQnM1ixDRjCpsC9S0qiUGep1X3PCzU5OT6XovDVevPRoAXlzgLDpRIOLXVmR7bpNbwJ3QIj/TdE1LcmmqePSXguckvSUCxgQgoPN3fslLua4CwrADv1oPLre1kmtTHlUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724199722; c=relaxed/simple;
	bh=UjpXQo6A7+0//4j7DndPfB95lyHaRH2TnLYP2u5D1Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8bmeoXwYBQpcBYAWXFppQAv/MC2YYykO1fmMK7KG255Ii2njAgQjRDvGuA8Som9pJlZqfBIrQS03xNj4NyQwfcPGOqG6ySgf+0mpIat+Z8aJMksg1n03HTwo73AsCoJ6BAim+66r5x0Lbkzh+fl60XrfqTtDm6HMDRvzoWMB30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uX9ffBcf; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Aug 2024 17:21:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724199717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sJxyQBBIYLkrS1prYD2jOPVLP+NyZepcQ3cKy2Gpp0g=;
	b=uX9ffBcfjQNqLrlx8bV687YLnQF2Odqs3ehbHtx/rAM8QAFxODXSTWbPMypAR5zodv5V54
	sfBExJxMFhHeaQ/l5/HmYWb3edlMpI/0GyAHSurKDx0yCKKmChruNLkYg3o37b7TCIl5hE
	mbjCfZQ21Q9oeu5YiKxhZOgaQMNXhfg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Muchun Song <muchun.song@linux.dev>, 
	Chris Li <chrisl@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	"Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swap, workingset: make anon shadow nodes memcg aware
Message-ID: <az5fhwmdwxpsgsxb7j3ruzbjevmxqrmx5xswwzuazh6zq5ytrs@bmgbu44mz3po>
References: <20240820092359.97782-1-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820092359.97782-1-ryncsn@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 20, 2024 at 05:23:59PM GMT, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Currently, the workingset (shadow) nodes of the swap cache are not
> accounted to their corresponding memory cgroup, instead, they are
> all accounted to the root cgroup. This leads to inaccurate accounting
> and ineffective reclaiming. One cgroup could swap out a large amount
> of memory, take up a large amount of memory with shadow nodes without
> being accounted.
> 
> This issue is similar to commit 7b785645e8f1 ("mm: fix page cache
> convergence regression"), where page cache shadow nodes were incorrectly
> accounted. That was due to the accidental dropping of the accounting
> flag during the XArray conversion in commit a28334862993
> ("page cache: Finish XArray conversion").
> 
> However, this fix has a different cause. Swap cache shadow nodes were
> never accounted even before the XArray conversion, since they did not
> exist until commit 3852f6768ede ("mm/swapcache: support to handle the
> shadow entries"), which was years after the XArray conversion.
> 
> It's worth noting that one anon shadow Xarray node may contain
> different entries from different cgroup, and it gets accounted at reclaim
> time, so it's arguable which cgroup it should be accounted to (as
> Shakeal Butt pointed out [1]). File pages may suffer similar issue
> but less common. Things like proactive memory reclaim could make thing
> more complex.
> 
> So this commit still can't provide a 100% accurate accounting of anon
> shadows, but it covers the cases when one memory cgroup uses significant
> amount of swap, and in most cases memory pressure in one cgroup only
> suppose to reclaim this cgroup and children. Besides, this fix is clean and
> easy enough.
> 
> Link: https://lore.kernel.org/all/7gzevefivueqtebzvikzbucnrnpurmh3scmfuiuo2tnrs37xso@haj7gzepjur2/ [1]
> Signed-off-by: Kairui Song <kasong@tencent.com>
> 

Is this a real issue? Have you seen systems in the production with
large amount of memory occupied by anon shadow entries? This is still
limited to the amount of swap a cgroup is allowed to use.

The reason I am asking is that this solution is worse than the perceived
problem at least to me. With this patch, the kernel will be charging
unrelated cgroups for the memory of swap xarray nodes during global
reclaim and proactive reclaim.

You can reduce this weirdness by using set_active_memcg() in
add_to_swap_cache() using the given folio's memcg but still you have the
case of multiple unrelated folios and shadow entries of different
cgroups within the same node. For filesystem case, the userspace can
control which files are shared between different cgroups and has more
control on it. That is not the case for swap space.

thanks,
Shakeel

