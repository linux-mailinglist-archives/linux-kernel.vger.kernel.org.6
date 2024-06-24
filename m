Return-Path: <linux-kernel+bounces-227822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4A59156D9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55764284ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C24119FA9B;
	Mon, 24 Jun 2024 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zob7r+dc"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AF419EED7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255576; cv=none; b=gwWTXeR6tkRfeFYoYwexZxUyuswaBmj3Gq8lQl95z0coO7j5wODaRViz4pWeMqIQL8KTd3XAoBSSCgsAVdc92j/P9mKoATdhWPQHE22tg88sbEQRRm1tYDifWk39Z9qFB8HFqzIiHf95UspQYeU78ww3MfAhuAA+O5dq7y6yzJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255576; c=relaxed/simple;
	bh=wUeLzdwdtzXSP9fTWwdgSsyGjSuLZ3yhbrqOjY6+yVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmMoUniUwgRJilJOAxbBsA6VEo5U78hjZNYA1PY5JSKXzJUoPnrZJKYuj8pmzCktdwmdUzyRjrtnGLMCMvyYeLB2/L6BGyGl5kbg4hZZ4r8DrTZ+wobFWh9h6ms1/ByGzhMOlxi0W39orBEYEz5e+U1+36sWciIakfjOT4Z0yXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zob7r+dc; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719255570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3xut/snTyFh3/c2AVt/fR731d9rDR0i/G+Mm1ffae0E=;
	b=Zob7r+dcq19p6uNhLmu/2Blc9Yx37pqRtHXXDCvV9L1I0hc2UNqJ4W8inmfytVdenwwsJy
	b3OTXDyBzEsakIsurpoiBDvnymCUjcRPNvHdQRz3akrW0cnFQ9w9wWUkzUujgsc7yASwuc
	G3WhvcReCngtgHiNO2kvGB/LfA+yKRA=
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
Date: Mon, 24 Jun 2024 11:59:24 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Muchun Song <songmuchun@bytedance.com>, 
	Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: use ratelimited stats flush in the reclaim
Message-ID: <ymi5ztypuurvtczjep3spulr7klfqh5y4rwuwu2g4pfgxb7hpw@7htpiuhzwc7n>
References: <20240615081257.3945587-1-shakeel.butt@linux.dev>
 <CAJD7tkbpFu8z1HaUgkaE6bup_fsD39QLPmgNyOnaTrm+hZ_9hA@mail.gmail.com>
 <tbi7h7lw4gvl2lsobco4s2qq5phln4uilfvpzpqytlwwmerynd@5nrl5odpwcrx>
 <CAJD7tka-Wa95t29G0EY4xd8TWXkw1q_QNQ-QjzNvqnUQovMtQw@mail.gmail.com>
 <rbetatcg46uddpde3dw35g4kgzesbtrtyzhg666cqjneucey65@nhcc6i775qte>
 <CAJD7tkaB+JgP=+Nb2Ecikw024eO7qHo6vkHKL-uf2f135LL4UQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkaB+JgP=+Nb2Ecikw024eO7qHo6vkHKL-uf2f135LL4UQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 24, 2024 at 10:15:38AM GMT, Yosry Ahmed wrote:
> On Mon, Jun 24, 2024 at 10:02 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Mon, Jun 24, 2024 at 05:57:51AM GMT, Yosry Ahmed wrote:
> > > > > and I will explain why below. I know it may be a necessary
> > > > > evil, but I would like us to make sure there is no other option before
> > > > > going forward with this.
> > > >
> > > > Instead of necessary evil, I would call it a pragmatic approach i.e.
> > > > resolve the ongoing pain with good enough solution and work on long term
> > > > solution later.
> > >
> > > It seems like there are a few ideas for solutions that may address
> > > longer-term concerns, let's make sure we try those out first before we
> > > fall back to the short-term mitigation.
> > >
> >
> > Why? More specifically why try out other things before this patch? Both
> > can be done in parallel. This patch has been running in production at
> > Meta for several weeks without issues. Also I don't see how merging this
> > would impact us on working on long term solutions.
> 
> The problem is that once this is merged, it will be difficult to
> change this back to a normal flush once other improvements land. We
> don't have a test that reproduces the problem that we can use to make
> sure it's safe to revert this change later, it's only using data from
> prod.
> 

I am pretty sure the work on long term solution would be iterative which
will involve many reverts and redoing things differently. So, I think it
is understandable that we may need to revert or revert the reverts.

> Once this mitigation goes in, I think everyone will be less motivated
> to get more data from prod about whether it's safe to revert the
> ratelimiting later :)

As I said I don't expect "safe in prod" as a strict requirement for a
change.

> 
> >
> > [...]
> > >
> > > Thanks for explaining this in such detail. It does make me feel
> > > better, but keep in mind that the above heuristics may change in the
> > > future and become more sensitive to stale stats, and very likely no
> > > one will remember that we decided that stale stats are fine
> > > previously.
> > >
> >
> > When was the last time this heuristic change? This heuristic was
> > introduced in 2008 for anon pages and extended to file pages in 2016. In
> > 2019 the ratio enforcement at 'reclaim root' was introduce. I am pretty
> > sure we will improve the whole rstat flushing thing within a year or so
> > :P
> 
> Fair point, although I meant it's easy to miss that the flush is
> ratelimited and the stats are potentially stale in general :)
> 
> >
> > > >
> > > > For the cache trim mode, inactive file LRU size is read and the kernel
> > > > scales it down based on the reclaim iteration (file >> sc->priority) and
> > > > only checks if it is zero or not. Again precise information is not
> > > > needed.
> > >
> > > It sounds like it is possible that we enter the cache trim mode when
> > > we shouldn't if the stats are stale. Couldn't this lead to
> > > over-reclaiming file memory?
> > >
> >
> > Can you explain how this over-reclaiming file will happen?
> 
> In one reclaim iteration, we could flush the stats, read the inactive
> file LRU size, confirm that (file >> sc->priority) > 0 and enter the
> cache trim mode, reclaiming file memory only. Let's assume that we
> reclaimed enough file memory such that the condition (file >>
> sc->priority) > 0 does not hold anymore.
> 
> In a subsequent reclaim iteration, the flush could be skipped due to
> ratelimiting. Now we will enter the cache trim mode again and reclaim
> file memory only, even though the actual amount of file memory is low.
> This will cause over-reclaiming from file memory and dismissing anon
> memory that we should have reclaimed, which means that we will need
> additional reclaim iterations to actually free memory.
> 
> I believe this scenario would be possible with ratelimiting, right?
> 

So, the (old_file >> sc->priority) > 0 is true but the (new_file >>
sc->priority) > is false. In the next iteration, (old_file >>
(sc->priority-1)) > 0 will still be true but somehow (new_file >>
(sc->priority-1)) > 0 is false. It can happen if in the previous
iteration, somehow kernel has reclaimed more than double what it was
supposed to reclaim or there are concurrent reclaimers. In addition the
nr_reclaim is still less than nr_to_reclaim and there is no file
deactivation request.

Yeah it can happen but a lot of wierd conditions need to happen
concurrently for this to happen.

