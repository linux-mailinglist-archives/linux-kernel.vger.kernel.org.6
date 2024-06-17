Return-Path: <linux-kernel+bounces-218004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D72E690B7C4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B297B28494E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0E116CD21;
	Mon, 17 Jun 2024 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jm0VGila"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4D116CD1C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718644832; cv=none; b=kA2Rvv0zBaCtWtMawf+6oNhGMHeEIG1916gBa6hucI+Epol3ZYPoN0RBV9Cm5H/wcqzgcjBnXizj/+dYTvhOYv7E/Tw2qjgOH+JpYuEKql8QRLh4rf73Anw9E25UlPVyIFePuCEAerPhSKsbuPjqcPRxJrRXEDnJ9kPAjWrRlRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718644832; c=relaxed/simple;
	bh=mn7QHc4xHU3pbObk9y1U0ujZdVDiobrJDnyIGZZ2TIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AU2MJ0P2U7LX7zRU8s21SXzUXwncgEFq2pF39WXkg0hKlMGuq4GMk7gz7x3qUkPO0w9eR4ldID29ontIeX3LILN87xq6h6ZhN5/FryEWfXaltysG8IRb73X4G3QsbRytNlxZac/fa03hxLuqMDpazrhY+3CidAp8rcBwN9Z5Xtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jm0VGila; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718644827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdXwI+p6S0bnvx9513DEJ8ZGMQjZAhsSguPb47KnFQA=;
	b=Jm0VGilavH5nkzGdbhhIM42iiU/WwMWdGPZa60sATuC7kUE+3Ir34u3WI7idJehb/w9HzD
	lImEYVivyJffzMbQaN9yLqHK5K5skx3W5C2Z0gqBlSmGDu7ejfjpCp+1nmiilcg8i44RpA
	ItZP0EWbrEz2twO+qzDXpmTyUwbiqU4=
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
Date: Mon, 17 Jun 2024 10:20:21 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Muchun Song <songmuchun@bytedance.com>, 
	Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: use ratelimited stats flush in the reclaim
Message-ID: <tbi7h7lw4gvl2lsobco4s2qq5phln4uilfvpzpqytlwwmerynd@5nrl5odpwcrx>
References: <20240615081257.3945587-1-shakeel.butt@linux.dev>
 <CAJD7tkbpFu8z1HaUgkaE6bup_fsD39QLPmgNyOnaTrm+hZ_9hA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbpFu8z1HaUgkaE6bup_fsD39QLPmgNyOnaTrm+hZ_9hA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Jun 15, 2024 at 05:28:55PM GMT, Yosry Ahmed wrote:
> On Sat, Jun 15, 2024 at 1:13 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > The Meta prod is seeing large amount of stalls in memcg stats flush
> > from the memcg reclaim code path. At the moment, this specific callsite
> > is doing a synchronous memcg stats flush. The rstat flush is an
> > expensive and time consuming operation, so concurrent relaimers will
> > busywait on the lock potentially for a long time. Actually this issue is
> > not unique to Meta and has been observed by Cloudflare [1] as well. For
> > the Cloudflare case, the stalls were due to contention between kswapd
> > threads running on their 8 numa node machines which does not make sense
> > as rstat flush is global and flush from one kswapd thread should be
> > sufficient for all. Simply replace the synchronous flush with the
> > ratelimited one.
> >
> > One may raise a concern on potentially using 2 sec stale (at worst)
> > stats for heuristics like desirable inactive:active ratio and preferring
> > inactive file pages over anon pages but these specific heuristics do not
> > require very precise stats and also are ignored under severe memory
> > pressure. This patch has been running on Meta fleet for more than a
> > month and we have not observed any issues. Please note that MGLRU is not
> > impacted by this issue at all as it avoids rstat flushing completely.
> >
> > Link: https://lore.kernel.org/all/6ee2518b-81dd-4082-bdf5-322883895ffc@kernel.org [1]
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >  mm/vmscan.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index c0429fd6c573..bda4f92eba71 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2263,7 +2263,7 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
> >          * Flush the memory cgroup stats, so that we read accurate per-memcg
> >          * lruvec stats for heuristics.
> >          */
> > -       mem_cgroup_flush_stats(sc->target_mem_cgroup);
> > +       mem_cgroup_flush_stats_ratelimited(sc->target_mem_cgroup);
> 
> I think you already know my opinion about this one :) I don't like it
> at all, 

Yup I know.

> and I will explain why below. I know it may be a necessary
> evil, but I would like us to make sure there is no other option before
> going forward with this.

Instead of necessary evil, I would call it a pragmatic approach i.e.
resolve the ongoing pain with good enough solution and work on long term
solution later.

> 
> Unfortunately, I am travelling this week, so I probably won't be able
> to follow up on this for a week or so, but I will try to lay down my
> thoughts as much as I can.
> 
> Why don't I like this?
> 
> - From a high level, I don't like the approach of replacing
> problematic flushing calls with the ratelimited version. It strikes me
> as a whac-a-mole approach that is mitigating symptoms of a larger
> problem.
> 
> - With the added thresholding code, a flush is only done if there is a
> significant number of pending updates in the relevant subtree.
> Choosing the ratelimited approach is intentionally ignoring a
> significant change in stats (although arguably it could be irrelevant
> stats).

Intentionally ignoring the significant change is fine for, as you said,
for irrelevant stats but also for the cases where we don't need the
exact and precise stats. See my next point.

> 
> - Reclaim code is an iterative process, so not updating the stats on
> every retry is very counterintuitive. We are retrying reclaim using
> the same stats and heuristics used by a previous iteration,
> essentially dismissing the effects of those previous iterations.
> 

I think I explained in the commit message why we don't need the precise
metrics for this specific case but let me reiterate.

The stats are needed for two specific heuristics in this case:

1. Deactivate LRUs
2. Cache trim mode

The deactivate LRUs heuristic is to maintain a desirable inactive:active
ratio of the LRUs. The specific stats needed are WORKINGSET_ACTIVATE*
and the hierarchical LRU size. The WORKINGSET_ACTIVATE* is needed to
check if there is a refault since last snapshot and the LRU size are
needed for the desirable ratio between inactive and active LRUs. See the
table below on how the desirable ratio is calculated.

/* total     target    max
 * memory    ratio     inactive
 * -------------------------------------
 *   10MB       1         5MB
 *  100MB       1        50MB
 *    1GB       3       250MB
 *   10GB      10       0.9GB
 *  100GB      31         3GB
 *    1TB     101        10GB
 *   10TB     320        32GB
 */

The desirable ratio only changes at the boundary of 1 GiB, 10 GiB,
100 GiB, 1 TiB and 10 TiB. There is no need for the precise and accurate
LRU size information to calculate this ratio. In addition, if
deactivation is skipped for some LRU, the kernel will force deactive on
the severe memory pressure situation.

For the cache trim mode, inactive file LRU size is read and the kernel
scales it down based on the reclaim iteration (file >> sc->priority) and
only checks if it is zero or not. Again precise information is not
needed.

> - Indeterministic behavior like this one is very difficult to debug if
> it causes problems. The missing updates in the last 2s (or whatever
> period) could be of any magnitude. We may be ignoring GBs of
> free/allocated memory. What's worse is, if it causes any problems,
> tracing it back to this flush will be extremely difficult.

This is indeed an issue but that is common with the heuristics in
general. They work most of the time and fail for small set of cases.

Anyways, I am not arguing to remove sync flush for all cases. Rather I
am arguing for this specific case, we don't need to be precise as I have
explained above.

> 
> What can we do?
> 
> - Try to make more fundamental improvements to the flushing code (for
> memcgs or cgroups in general). The per-memcg flushing thresholding is
> an example of this. For example, if flushing is taking too long
> because we are flushing all subsystems, it may make sense to have
> separate rstat trees for separate subsystems.

Yes separate flushing for each subsystems make sense and can be done
orthogonally.

> 
> One other thing we can try is add a mutex in the memcg flushing path.
> I had initially had this in my subtree flushing series [1], but I
> dropped it as we thought it's not very useful. Currently in
> mem_cgroup_flush_stats(), we check if there are enough pending updates
> to flush, then we call cgroup_flush_stats() and spin on the lock. It
> is possible that while we spin, those pending updates we observed have
> been flushed. If we add back the mutex like in [1], then once we
> acquire the mutex we check again to make sure there are still enough
> stats to flush.
> 
> [1]https://lore.kernel.org/all/20231010032117.1577496-6-yosryahmed@google.com/

My main beef with the global mutex is the possible priority inversion.
Unless you agree to add try_lock() and skip flushing i.e. no one sleeps
on the mutex, this is a no go.

> 
> - Try to avoid the need for flushing in this path. I am not sure what
> approach MGLRU uses to avoid the flush, but if we can do something
> similar for classic LRUs that would be preferable. I am guessing MGLRU
> may be maintaining its own stats outside of the rstat framework.

MGLRU simply don't use these heuristics (Yu Zhao please correct me if I
am wrong). 

> 
> - Try to figure out if one (or a few) update paths are regressing all
> flushers. If one specific stat or stats update path is causing most of
> the updates, we can try to fix that instead. Especially if it's a
> counter that is continuously being increased and decreases (so the net
> change is not as high as we think).

This is actually a good point. I remember Jasper telling that MEMCG_KMEM
might be the one with most updates. I can try to collect from Meta fleet
what is the cause of most updates.

> 
> At the end of the day, all of the above may not work, and we may have
> to live with just using the ratelimited approach. But I *really* hope
> we could actually go the other way. Fix things on a more fundamental
> level and eventually drop the ratelimited variants completely.
> 
> Just my 2c. Sorry for the long email :)

Please note that this is not some user API which can not be changed
later. We can change and disect however we want. My only point is not to
wait for the perfect solution and have some intermediate and good enough
solution.

Thanks for the review.

