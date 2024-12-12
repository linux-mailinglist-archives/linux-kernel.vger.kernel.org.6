Return-Path: <linux-kernel+bounces-443603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177579EF9A1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9E4284FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0767C223C7B;
	Thu, 12 Dec 2024 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FDLiiZDb"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A124223E62
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025924; cv=none; b=IRgqeAdoKxzmbh2Mg7E3LB1tIqr3kC3Gk/0P2yQ8r9/z3PLokGKSuS8Bwz2PitNEu4oIp114Pnn6U8b/FluxhiO8H/bFf5xArRFroyd4tPXBwb0TXDvS5snLysUetZsTwFG4TjwLrNcReUsCrqcYuZps5kdrPSvnB9Zk+tBAneg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025924; c=relaxed/simple;
	bh=RFNKVw5SAUUJiiJDpqRQ01TJM9B1+0nfwbZ4M7WdyOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUbXmz0XmZbTByySefveVBAlZvPcQKEbwz+J65+yevLtKxkhNo6Re6uDY2RwW7AK7Eny35mOBrvGPyfwWU9Hi4qvDwDmxdDrMIEVqbLvp8leGln6PZNp0jz1QZ+Hjhq2Ns3EiQ2Ui4lf+eCHiTFwfsCwYqonKc8bqvakCoJ3sZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FDLiiZDb; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 12 Dec 2024 09:51:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734025916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZZXEGYkGK4kAXvmT4RcWMA7K4KCrvzXjT7TqPR9oKs=;
	b=FDLiiZDbmR2mvO0cLFZVa9/knfz5jtMYG6PcDqxA+IE2383+ypIPrAlGRiAe+XF1PuCT/j
	WGGiuIieOLGHmnJXgcnBb27oh3hJ8iRM8BXkzC7T+UHptrpXKZD59vPY3ttLbTTkb34li7
	PT7UhnSSnMHKjBRrQbRObqRl+ejP4Mc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Rik van Riel <riel@surriel.com>, Balbir Singh <balbirs@nvidia.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
Message-ID: <4oxovutecmn7mkbbmbk3rhqudilivf6fkedvmcbcttmcspwebl@fp6pv2a45x6n>
References: <20241212115754.38f798b3@fangorn>
 <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 12, 2024 at 09:06:25AM -0800, Yosry Ahmed wrote:
> On Thu, Dec 12, 2024 at 8:58 AM Rik van Riel <riel@surriel.com> wrote:
> >
> > A task already in exit can get stuck trying to allocate pages, if its
> > cgroup is at the memory.max limit, the cgroup is using zswap, but
> > zswap writeback is enabled, and the remaining memory in the cgroup is
> > not compressible.
> >
> > This seems like an unlikely confluence of events, but it can happen
> > quite easily if a cgroup is OOM killed due to exceeding its memory.max
> > limit, and all the tasks in the cgroup are trying to exit simultaneously.
> >
> > When this happens, it can sometimes take hours for tasks to exit,
> > as they are all trying to squeeze things into zswap to bring the group's
> > memory consumption below memory.max.
> >
> > Allowing these exiting programs to push some memory from their own
> > cgroup into swap allows them to quickly bring the cgroup's memory
> > consumption below memory.max, and exit in seconds rather than hours.
> >
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> 
> Thanks for sending a v2.
> 
> I still think maybe this needs to be fixed on the memcg side, at least
> by not making exiting tasks try really hard to reclaim memory to the
> point where this becomes a problem. IIUC there could be other reasons
> why reclaim may take too long, but maybe not as pathological as this
> case to be fair. I will let the memcg maintainers chime in for this.
> 
> If there's a fundamental reason why this cannot be fixed on the memcg
> side, I don't object to this change.
> 
> Nhat, any objections on your end? I think your fleet workloads were
> the first users of this interface. Does this break their expectations?
> 

Let me give my personal take. This seems like a stopgap or a quick hack
to resolve the very specific situation happening in real world. I am ok
with having this solution but only temporarily. The reason why I think
this is short term fix or a quick hack is because it is not specifically
solving the fundamental issue here. The same situation can reoccur if
let's say the swap storage was slow or stuck or contended. A somewhat
similar situation is when there are lot of unreclaimable memory either
through pinning or maybe mlock.

The fundamental issue is that the exiting process (killed by oomd or
simple exit) has to allocated memory but the cgroup is at limit and the
reclaim is very very slow.

I can see attacking this issue with multiple angles. Some mixture of
reusing kernel's oom reaper and some buffer to allow the exiting process
to go over the limit. Let's brainstorm and explore this direction.

In the meantime, I think we can have this stopgap solution.

