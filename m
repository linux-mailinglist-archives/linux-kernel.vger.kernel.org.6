Return-Path: <linux-kernel+bounces-227646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7309154F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7716E284D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E615319F46F;
	Mon, 24 Jun 2024 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KF73x2M2"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B2D13E024
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248578; cv=none; b=lzVvlHH3Ln1BUYiDqXYplNc9MZIopCHi6WlT3cwIGm/Pohad1DkRUquC34OP0ZdYRWKcmrHTa38BSAuyiYi63CN8sC6VJsirSpLO48Y55VERJAk9tozyVLHC7tLG+xLG+J5OFIKkPTMWZLO5f20aHk3qeEL9p3gM1rshaFGqr7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248578; c=relaxed/simple;
	bh=u3m8PvzguSh+prWR5r5AsyaDSGQZpz9mpA4jjQUoIjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHguhpWSG/zR55nq3j65vxL17fEj4rdeV8espJSLRStz/V9Lz1+MOugy5JQ3fjDB/CQyla801nrMpx/TTOQqDY2/myU3ytX2Vj23p8ktSqGVHtB9WbMAGr8bgke+v0BVMBDM3HYwNKev5SAj+3kRAfBih0cyM+5hZqf0LFRHqb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KF73x2M2; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719248569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WLu+V2MKAr+T8vIVzaWcCXsvgj+Dk/5RNmAxKrhoWJs=;
	b=KF73x2M2+QzH5jfz1tOrUAbn69LBTA6fj4fPfIDpUJfJiCxOFlnTUpwTEhI2rdHGanZCWx
	BymMLCaLJElNNyaCAbZK67T+EP4h7oaMLPB2g+Qj/GEtmR2F7Rn/qbk/45RCgo+5p+Tfft
	8xoExjfEtUV4koS8symwqbbsY3vtITI=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@suse.com
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: hawk@kernel.org
X-Envelope-To: yuzhao@google.com
X-Envelope-To: songmuchun@bytedance.com
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 24 Jun 2024 10:02:44 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Muchun Song <songmuchun@bytedance.com>, 
	Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: use ratelimited stats flush in the reclaim
Message-ID: <rbetatcg46uddpde3dw35g4kgzesbtrtyzhg666cqjneucey65@nhcc6i775qte>
References: <20240615081257.3945587-1-shakeel.butt@linux.dev>
 <CAJD7tkbpFu8z1HaUgkaE6bup_fsD39QLPmgNyOnaTrm+hZ_9hA@mail.gmail.com>
 <tbi7h7lw4gvl2lsobco4s2qq5phln4uilfvpzpqytlwwmerynd@5nrl5odpwcrx>
 <CAJD7tka-Wa95t29G0EY4xd8TWXkw1q_QNQ-QjzNvqnUQovMtQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tka-Wa95t29G0EY4xd8TWXkw1q_QNQ-QjzNvqnUQovMtQw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 24, 2024 at 05:57:51AM GMT, Yosry Ahmed wrote:
> > > and I will explain why below. I know it may be a necessary
> > > evil, but I would like us to make sure there is no other option before
> > > going forward with this.
> >
> > Instead of necessary evil, I would call it a pragmatic approach i.e.
> > resolve the ongoing pain with good enough solution and work on long term
> > solution later.
> 
> It seems like there are a few ideas for solutions that may address
> longer-term concerns, let's make sure we try those out first before we
> fall back to the short-term mitigation.
> 

Why? More specifically why try out other things before this patch? Both
can be done in parallel. This patch has been running in production at
Meta for several weeks without issues. Also I don't see how merging this
would impact us on working on long term solutions.

[...]
> 
> Thanks for explaining this in such detail. It does make me feel
> better, but keep in mind that the above heuristics may change in the
> future and become more sensitive to stale stats, and very likely no
> one will remember that we decided that stale stats are fine
> previously.
> 

When was the last time this heuristic change? This heuristic was
introduced in 2008 for anon pages and extended to file pages in 2016. In
2019 the ratio enforcement at 'reclaim root' was introduce. I am pretty
sure we will improve the whole rstat flushing thing within a year or so
:P

> >
> > For the cache trim mode, inactive file LRU size is read and the kernel
> > scales it down based on the reclaim iteration (file >> sc->priority) and
> > only checks if it is zero or not. Again precise information is not
> > needed.
> 
> It sounds like it is possible that we enter the cache trim mode when
> we shouldn't if the stats are stale. Couldn't this lead to
> over-reclaiming file memory?
> 

Can you explain how this over-reclaiming file will happen?

[...]
> > >
> > > - Try to figure out if one (or a few) update paths are regressing all
> > > flushers. If one specific stat or stats update path is causing most of
> > > the updates, we can try to fix that instead. Especially if it's a
> > > counter that is continuously being increased and decreases (so the net
> > > change is not as high as we think).
> >
> > This is actually a good point. I remember Jasper telling that MEMCG_KMEM
> > might be the one with most updates. I can try to collect from Meta fleet
> > what is the cause of most updates.
> 
> Let's also wait and see what comes out of this. It would be
> interesting if we can fix this on the update side instead.
> 

Yes it would be interesting but I don't see any reason to wait for it.

> >
> > >
> > > At the end of the day, all of the above may not work, and we may have
> > > to live with just using the ratelimited approach. But I *really* hope
> > > we could actually go the other way. Fix things on a more fundamental
> > > level and eventually drop the ratelimited variants completely.
> > >
> > > Just my 2c. Sorry for the long email :)
> >
> > Please note that this is not some user API which can not be changed
> > later. We can change and disect however we want. My only point is not to
> > wait for the perfect solution and have some intermediate and good enough
> > solution.
> 
> I agree that we shouldn't wait for a perfect solution, but it also
> seems like there are a few easy-ish solutions that we can discover
> first (Jesper's patch, investigating update paths, etc). If none of
> those pan out, we can fall back to the ratelimited flush, ideally with
> a plan on next steps for a longer-term solution.

I think I already explain why there is no need to wait. One thing we
should agree on is that this is hard problem and will need multiple
iterations to comeup with a solution which is acceptable for most. Until
then I don't see any reason to block mitigations to reduce pain.

thanks,
Shakeel



