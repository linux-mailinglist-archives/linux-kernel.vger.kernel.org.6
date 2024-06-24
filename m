Return-Path: <linux-kernel+bounces-227868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF5B915782
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 109BFB210A9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88553BBC2;
	Mon, 24 Jun 2024 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K+Ui1wIU"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8491EFBEF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 20:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719259310; cv=none; b=piQ1FWz39/J2p8AXikVzpLBB8Pr7zcgCX1CYcNXwj8BLfSjCsePfBZLdM78l5m/hRtBJUfk/psNHAtPp4IBaCWEgEPrEye49x2Zi5oMSMvJ8Sdx0TnxqVZOp0qDWKnIrSEN3hCahwXson6sX0xy8a1pFBn5fDCh/h6AErH2e0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719259310; c=relaxed/simple;
	bh=s/wO9BOv11BjvWK6aEZs9g66A4ghGz+Nx6anCW5tiv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjBBqB3nsHzt17HMPcbylfG5g9Z3Lgx+NgcS8n8K/rzG/+8OlAIaT96IPPZU3HCscfDAzQckNTKpXSVhlflLgsV6H3eOFGD2Exv+tE7vx1e67+YB6IPQ4LOjKID0b/pNzp/lQZr0z2EXsqkBKLcT5JQ0QcBNvGegA31J750c7bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K+Ui1wIU; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719259305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lU/VAsgWGlzvjkIooytwpJB7jKapz6hsQomF/7QdbZQ=;
	b=K+Ui1wIUMQ01SNYwttteRjBnT1191wOCLf4fj66J/O36azsdguRJ7j9OGkG7HkY1oEdpzS
	6spj/GzHeQARMqB/QWKFuCkSN043SrUBRKGBtKc4bBoqbn4D/uAfumi3rL7LZA0tp81S7s
	Mr4We5oS4tFAhexjDJS75Vv/DcCXJPY=
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
Date: Mon, 24 Jun 2024 13:01:39 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Muchun Song <songmuchun@bytedance.com>, 
	Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: use ratelimited stats flush in the reclaim
Message-ID: <wlgw7fz4cgwlsnvzufeak26fqfj5ahutnfnbfifgob722il253@k2qxpgdtutmt>
References: <20240615081257.3945587-1-shakeel.butt@linux.dev>
 <CAJD7tkbpFu8z1HaUgkaE6bup_fsD39QLPmgNyOnaTrm+hZ_9hA@mail.gmail.com>
 <tbi7h7lw4gvl2lsobco4s2qq5phln4uilfvpzpqytlwwmerynd@5nrl5odpwcrx>
 <CAJD7tka-Wa95t29G0EY4xd8TWXkw1q_QNQ-QjzNvqnUQovMtQw@mail.gmail.com>
 <rbetatcg46uddpde3dw35g4kgzesbtrtyzhg666cqjneucey65@nhcc6i775qte>
 <CAJD7tkaB+JgP=+Nb2Ecikw024eO7qHo6vkHKL-uf2f135LL4UQ@mail.gmail.com>
 <ymi5ztypuurvtczjep3spulr7klfqh5y4rwuwu2g4pfgxb7hpw@7htpiuhzwc7n>
 <CAJD7tkb74XVZx+g_xmdC8saH6AXg1seunNSmkYYNsMKfJfg0Cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkb74XVZx+g_xmdC8saH6AXg1seunNSmkYYNsMKfJfg0Cg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 24, 2024 at 12:06:28PM GMT, Yosry Ahmed wrote:
> On Mon, Jun 24, 2024 at 11:59 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Mon, Jun 24, 2024 at 10:15:38AM GMT, Yosry Ahmed wrote:
> > > On Mon, Jun 24, 2024 at 10:02 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > >
> > > > On Mon, Jun 24, 2024 at 05:57:51AM GMT, Yosry Ahmed wrote:
> > > > > > > and I will explain why below. I know it may be a necessary
> > > > > > > evil, but I would like us to make sure there is no other option before
> > > > > > > going forward with this.
> > > > > >
> > > > > > Instead of necessary evil, I would call it a pragmatic approach i.e.
> > > > > > resolve the ongoing pain with good enough solution and work on long term
> > > > > > solution later.
> > > > >
> > > > > It seems like there are a few ideas for solutions that may address
> > > > > longer-term concerns, let's make sure we try those out first before we
> > > > > fall back to the short-term mitigation.
> > > > >
> > > >
> > > > Why? More specifically why try out other things before this patch? Both
> > > > can be done in parallel. This patch has been running in production at
> > > > Meta for several weeks without issues. Also I don't see how merging this
> > > > would impact us on working on long term solutions.
> > >
> > > The problem is that once this is merged, it will be difficult to
> > > change this back to a normal flush once other improvements land. We
> > > don't have a test that reproduces the problem that we can use to make
> > > sure it's safe to revert this change later, it's only using data from
> > > prod.
> > >
> >
> > I am pretty sure the work on long term solution would be iterative which
> > will involve many reverts and redoing things differently. So, I think it
> > is understandable that we may need to revert or revert the reverts.
> >
> > > Once this mitigation goes in, I think everyone will be less motivated
> > > to get more data from prod about whether it's safe to revert the
> > > ratelimiting later :)
> >
> > As I said I don't expect "safe in prod" as a strict requirement for a
> > change.
> 
> If everyone agrees that we can experiment with reverting this change
> later without having to prove that it is safe, then I think it's fine.
> Let's document this in the commit log though, so that whoever tries to
> revert this in the future (if any) does not have to re-explain all of
> this :)

Sure.

> 
> [..]
> > > > > >
> > > > > > For the cache trim mode, inactive file LRU size is read and the kernel
> > > > > > scales it down based on the reclaim iteration (file >> sc->priority) and
> > > > > > only checks if it is zero or not. Again precise information is not
> > > > > > needed.
> > > > >
> > > > > It sounds like it is possible that we enter the cache trim mode when
> > > > > we shouldn't if the stats are stale. Couldn't this lead to
> > > > > over-reclaiming file memory?
> > > > >
> > > >
> > > > Can you explain how this over-reclaiming file will happen?
> > >
> > > In one reclaim iteration, we could flush the stats, read the inactive
> > > file LRU size, confirm that (file >> sc->priority) > 0 and enter the
> > > cache trim mode, reclaiming file memory only. Let's assume that we
> > > reclaimed enough file memory such that the condition (file >>
> > > sc->priority) > 0 does not hold anymore.
> > >
> > > In a subsequent reclaim iteration, the flush could be skipped due to
> > > ratelimiting. Now we will enter the cache trim mode again and reclaim
> > > file memory only, even though the actual amount of file memory is low.
> > > This will cause over-reclaiming from file memory and dismissing anon
> > > memory that we should have reclaimed, which means that we will need
> > > additional reclaim iterations to actually free memory.
> > >
> > > I believe this scenario would be possible with ratelimiting, right?
> > >
> >
> > So, the (old_file >> sc->priority) > 0 is true but the (new_file >>
> > sc->priority) > is false. In the next iteration, (old_file >>
> > (sc->priority-1)) > 0 will still be true but somehow (new_file >>
> > (sc->priority-1)) > 0 is false. It can happen if in the previous
> > iteration, somehow kernel has reclaimed more than double what it was
> > supposed to reclaim or there are concurrent reclaimers. In addition the
> > nr_reclaim is still less than nr_to_reclaim and there is no file
> > deactivation request.
> >
> > Yeah it can happen but a lot of wierd conditions need to happen
> > concurrently for this to happen.
> 
> Not necessarily sc->priority-1. Consider two separate sequential
> reclaim attempts. At the same priority, the first reclaim attempt
> could rightfully enter cache trim mode, while the second one
> wrongfully enters cache trim mode due to stale stats, over-reclaim
> file memory, and stall longer to actually reclaim the anon memory.
> 

For two different reclaim attempts even more things need to go wrong.
Anyways we are talking too much in abstract here and focusing on the
corner cases which almost all heuristics have. Unless there is a clear
explanation that the corner case probability will be increased, I don't
think spending time discussing it is useful.

> I am sure such a scenario is not going to be common, but I am also
> sure if it happens it will be a huge pain to debug.
> 
> If others agree that this is fine, let's document this with a comment
> and in the commit log. I am not sure how common the cache trim mode is
> in practice to understand the potential severity of such problems.
> There may also be other consequences that I am not aware of.

What is your definition of "others" though?

