Return-Path: <linux-kernel+bounces-296028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1370295A490
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE83B1F22EC1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE00C1B3B3D;
	Wed, 21 Aug 2024 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xWFrkEzb"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AB61B3B1D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724264073; cv=none; b=ihRpkAPErB81PofxSbT5Fr+Pvi0QjgzdQE0vtf2B3AvMH6LxA0KgJSuAixVKH28st/HyWfccMQj+IME/ivuZqKrW724/Wi8ESGusOBBAjOk37VD2pGoUBnTc94UE0/S/A9yUdpNLG+F3p3HlFu4Y7ZuPNAOw/inUzmj22ehQaZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724264073; c=relaxed/simple;
	bh=nxvZXTKpsTpuu9qSvhWOdkr51YNv3JZfPi3+cnDrTaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAfkB7rp+GN4sRps0m8FdDUPUucU6a+GeoQqqMotPDZ9iDxKqarKMJ2EL2HvZu/clUKeJtvAEnbKBiF7Ac2CInkrQerj8JgBNgjB8tK3EYasrg35R8Vk9nRGY/ah081FEzN7iI+R7sZPOY69EKXJrq1Ps9M04sHaslfjU3nZB00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xWFrkEzb; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 Aug 2024 11:14:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724264068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqw3z9XEpjV/KGTSb0qDz+WvspqsTp+dFl1xRPsUBpY=;
	b=xWFrkEzbcdLTRYwDs6FME8WItV8TLl0GFhnq8kIy8c59GU0GEpNI3+P/Ndy2xOxB2lYqcI
	h0KN9BqDhPY4YsFsob0Yk0SgRVLg6DknfxQyxLSIjsfQpVKVucFMPJbKcnKPh6/dEaNpYP
	HfDqKt96GSrUafm6+CQ0OgSVN8CyR6o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Muchun Song <muchun.song@linux.dev>, 
	Chris Li <chrisl@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	"Huang, Ying" <ying.huang@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/swap, workingset: make anon shadow nodes memcg aware
Message-ID: <67wuawgnf5os22gb2woshxve2kdkxz3pkcfdy7kcm7irj6d5tn@h42jzenif3wa>
References: <20240820092359.97782-1-ryncsn@gmail.com>
 <az5fhwmdwxpsgsxb7j3ruzbjevmxqrmx5xswwzuazh6zq5ytrs@bmgbu44mz3po>
 <CAMgjq7D9WWXWFKcGs1ZsU7pNykoWV7RmsoBdP9CcGEa4N7d3fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7D9WWXWFKcGs1ZsU7pNykoWV7RmsoBdP9CcGEa4N7d3fg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 22, 2024 at 01:35:29AM GMT, Kairui Song wrote:
> Shakeel Butt <shakeel.butt@linux.dev> 于 2024年8月21日周三 08:22写道：
[...]
> 
> Hi, Thanks for the comments.
> 
> > Is this a real issue? Have you seen systems in the production with
> > large amount of memory occupied by anon shadow entries? This is still
> > limited to the amount of swap a cgroup is allowed to use.
> 
> No, this patch is cherry picked from previous series, this help
> separating the shadows to different cgroup properly according to my
> test, and reduces the lock contention of list_lru by a lot combined
> with later patches. Not very convincing on its own indeed, so I
> hesitated to send it alone.
> 

So, list_lru lock contention is the problem you are trying to solve.
Without this patch, do you see less impact of your list_lru series?
Anyways this patch is not the right way to solve the list_lru lock
contention issue.

> > The reason I am asking is that this solution is worse than the perceived
> > problem at least to me. With this patch, the kernel will be charging
> > unrelated cgroups for the memory of swap xarray nodes during global
> > reclaim and proactive reclaim.
> 
> Yes, this could be a problem.
> 
> I didn't observe this happening frequently with tests though, SWAP
> tends to cluster the SWAP allocations, and reclaiming tends to batch
> reclaim pages, so usually there is a fair high chance that shadows of
> pages of the same memcg stay on the same node.
> 
> It could end up completely random when the SWAP device is getting
> fragmented or reclaim is struggling though.

In actual production, fragmentation and memory over-commit is very
normal. So, such scenarios would occure more often.

> 
> > You can reduce this weirdness by using set_active_memcg() in
> > add_to_swap_cache() using the given folio's memcg but still you have the
> > case of multiple unrelated folios and shadow entries of different
> > cgroups within the same node. For filesystem case, the userspace can
> > control which files are shared between different cgroups and has more
> > control on it. That is not the case for swap space.
> 
> Right, this fix is not perfect, it's arguable if this new behaviour is
> better or worse than before. There is some ongoing work from the SWAP
> side so things may get fixed differently in the future, but I'll also
> check if this patch can be improved.

Yeah with mTHP we can reevaluate this approach.

