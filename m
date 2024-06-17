Return-Path: <linux-kernel+bounces-218068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1233D90B8E4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C221C23C8E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F31C194C63;
	Mon, 17 Jun 2024 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kUbRO/m7"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0118B194A61
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647305; cv=none; b=GiY3Zy55DtkjWutQUMAi3Czjrq35OTH22bqgZS8RRKqHlDXTb8MiaxNasQ/FP+B1/KINWAMoPOMAXlz1g9hgIxGCYka+Dc7FfcAi+/r79xAYdTG7Q5bjoDxhN4AHEKgqWBJ9R2BgzbcT6ZK6UoGrV9+YqPyR/V5Ydo0B2/mcDn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647305; c=relaxed/simple;
	bh=uNIfsPwL+wCq42UMAUn2yJtRq0HgfSecHNORtUZrQS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yxiq9vViFs1cdoH4Ag3pwmF8j8Dtn2HyVh+fNgH4/axVRszcKcViD+juLrCLuF/Sq3w8Y6GOBqd8SfQAa948ORQ6PTNWTEqtmbdxxiFO3lDNQOv08OimX/ESO3pMrcA+rQRqk/XCyIzB7AVQpc2rmFE8FJI55AFvmWweMfz9hOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kUbRO/m7; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: hawk@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718647300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9q5pk9eheQqKt91dvfdalJZi0Mslh6TzikYYicPd/c=;
	b=kUbRO/m7Cu0gDkmawgzPLhotwcpg4Q4zhwOTsLhO5hpmTvKBJWa5Btfwj5Jc9YRzj3URAk
	h5SsTEzrKHXlpAufDQwPKsRGC9R3pGxGzqiodXhC+p9CLu36vdyUcaHjjCQgLknB3h6jo/
	R7nJwLqoOrVyUspCsIrp4Oa+PDxjwPY=
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@suse.com
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: yuzhao@google.com
X-Envelope-To: songmuchun@bytedance.com
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kernel-team@cloudflare.com
Date: Mon, 17 Jun 2024 11:01:36 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Yu Zhao <yuzhao@google.com>, Muchun Song <songmuchun@bytedance.com>, 
	Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH] memcg: use ratelimited stats flush in the reclaim
Message-ID: <rhvafiag6fjkj66ohex3eamoqpsw62bxmwbvd7shsa72rqcile@fvo4nsggjpwg>
References: <20240615081257.3945587-1-shakeel.butt@linux.dev>
 <CAJD7tkbpFu8z1HaUgkaE6bup_fsD39QLPmgNyOnaTrm+hZ_9hA@mail.gmail.com>
 <0ec3c33c-d9ff-41a5-be94-0142f103b815@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ec3c33c-d9ff-41a5-be94-0142f103b815@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 17, 2024 at 05:31:21PM GMT, Jesper Dangaard Brouer wrote:
> 
> 
> On 16/06/2024 02.28, Yosry Ahmed wrote:
> > On Sat, Jun 15, 2024 at 1:13 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > 
> > > The Meta prod is seeing large amount of stalls in memcg stats flush
> > > from the memcg reclaim code path. At the moment, this specific callsite
> > > is doing a synchronous memcg stats flush. The rstat flush is an
> > > expensive and time consuming operation, so concurrent relaimers will
> > > busywait on the lock potentially for a long time. Actually this issue is
> > > not unique to Meta and has been observed by Cloudflare [1] as well. For
> > > the Cloudflare case, the stalls were due to contention between kswapd
> > > threads running on their 8 numa node machines which does not make sense
> > > as rstat flush is global and flush from one kswapd thread should be
> > > sufficient for all. Simply replace the synchronous flush with the
> > > ratelimited one.
> > > 
> 
> Like Yosry, I don't agree that simply using ratelimited flush here is
> the right solution, at-least other options need to be investigated first.

I added more detail in my reply to Yosry on why using ratelimited flush
for this specific case is fine.

[...]
> > 
> > I think you already know my opinion about this one :) I don't like it
> > at all, and I will explain why below. I know it may be a necessary
> > evil, but I would like us to make sure there is no other option before
> > going forward with this.
> > 
> I'm signing up to solving this somehow, as this is a real prod issue.
> 
> An easy way to solve the kswapd issue, would be to reintroduce
> "stats_flush_ongoing" concept, that was reverted in 7d7ef0a4686a ("mm:
> memcg: restore subtree stats flushing") (Author: Yosry Ahmed), and
> introduced in 3cd9992b9302 ("memcg: replace stats_flush_lock with an
> atomic") (Author: Yosry Ahmed).
> 

The skipping flush for "stats_flush_ongoing" was there from the start.

> The concept is: If there is an ongoing rstat flush, this time limited to
> the root cgroup, then don't perform the flush.  We can only do this for
> the root cgroup tree, as flushing can be done for subtrees, but kswapd
> is always for root tree, so it is good enough to solve the kswapd
> thundering herd problem.  We might want to generalize this beyond memcg.
> 

No objection from me for this skipping root memcg flush idea.

> 
[...]
> 
> > - With the added thresholding code, a flush is only done if there is a
> > significant number of pending updates in the relevant subtree.
> > Choosing the ratelimited approach is intentionally ignoring a
> > significant change in stats (although arguably it could be irrelevant
> > stats).
> > 
> 
> My production observations are that the thresholding code isn't limiting
> the flushing in practice.
> 

Here we need more production data. I remember you mentioned MEMCG_KMEM
being used for most of the updates. Is it possible to get top 5 (or 10)
most updated stats for your production environment?

> 
> > - Reclaim code is an iterative process, so not updating the stats on
> > every retry is very counterintuitive. We are retrying reclaim using
> > the same stats and heuristics used by a previous iteration,
> > essentially dismissing the effects of those previous iterations.
> > 
> > - Indeterministic behavior like this one is very difficult to debug if
> > it causes problems. The missing updates in the last 2s (or whatever
> > period) could be of any magnitude. We may be ignoring GBs of
> > free/allocated memory. What's worse is, if it causes any problems,
> > tracing it back to this flush will be extremely difficult.
> > 
> 
> The 2 sec seems like a long period for me.
> 
> > What can we do?
> > 
> > - Try to make more fundamental improvements to the flushing code (for
> > memcgs or cgroups in general). The per-memcg flushing thresholding is
> > an example of this. For example, if flushing is taking too long
> > because we are flushing all subsystems, it may make sense to have
> > separate rstat trees for separate subsystems.
> > 
> > One other thing we can try is add a mutex in the memcg flushing path.
> > I had initially had this in my subtree flushing series [1], but I
> > dropped it as we thought it's not very useful.
> 
> I'm running an experimental kernel with rstat lock converted to mutex on
> a number of production servers, and we have not observed any regressions.
> The kswapd thundering herd problem also happen on these machines, but as
> these are sleep-able background threads, it is fine to sleep on the mutex.
> 

Sorry but a global mutex which can be taken by userspace applications
and is needed by node controller (to read stats) is a no from me. On a
multi-tenant systems, global locks causing priority inversion is a real
issue.

> 
[...]
> 
> My pipe dream is that kernel can avoiding the cost of maintain the
> cgroup threshold stats for flushing, and instead rely on a dynamic time
> based threshold (in ms area) that have no fast-path overhead :-P
> 

Please do expand on what you mean by dynamic time based threshold.

