Return-Path: <linux-kernel+bounces-566311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F93A6764C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E23188DEF5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CF020E6EB;
	Tue, 18 Mar 2025 14:17:52 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128CE20DD7D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307472; cv=none; b=WB23Om7odSmMinC6ZvtINjTlzR+cSAqSWhbLXOCA6BHtdNI4+frSpIbP9ky1kyD0pd7R9QXRIMxbuYqEynJj2TDa/tt8ECAIb9aQxa4kgj3LKYPtNj9B6JTOHCxvu3pFKvLCe6wAkO/i3ph4b11xbkXXNNJuNa2SvWhJ5bbfqY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307472; c=relaxed/simple;
	bh=6Zkz5X5RSaFXuDLrUqSkPi4rNgiaOaB6ukSeQf8vTHY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EVOj1F+MbBGN0NPqXAXzG209w/jGf7l1hEfoSmr42HjCtx4EDS1R8m6La3u/WJ4TxWcTty2l4nYsRghudXG7LeKdqTTrbD1in82KgmiQYEHqLlD2fKF6L+zKiyeT6o+shbzFG58Po5CULWTMyfYPhiJPVA8e5cTRCzmrRTGKebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZHDM85fmQz6H7lw;
	Tue, 18 Mar 2025 22:12:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6DFBD140953;
	Tue, 18 Mar 2025 22:17:40 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 18 Mar
 2025 15:17:38 +0100
Date: Tue, 18 Mar 2025 14:17:37 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Bharata B Rao <bharata@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<AneeshKumar.KizhakeVeetil@arm.com>, <Hasan.Maruf@amd.com>,
	<Michael.Day@amd.com>, <akpm@linux-foundation.org>, <dave.hansen@intel.com>,
	<david@redhat.com>, <feng.tang@intel.com>, <gourry@gourry.net>,
	<hannes@cmpxchg.org>, <honggyu.kim@sk.com>, <hughd@google.com>,
	<jhubbard@nvidia.com>, <k.shutemov@gmail.com>, <kbusch@meta.com>,
	<kmanaouil.dev@gmail.com>, <leesuyeon0506@gmail.com>, <leillc@google.com>,
	<liam.howlett@oracle.com>, <mgorman@techsingularity.net>, <mingo@redhat.com>,
	<nadav.amit@gmail.com>, <nphamcs@gmail.com>, <peterz@infradead.org>,
	<raghavendra.kt@amd.com>, <riel@surriel.com>, <rientjes@google.com>,
	<rppt@kernel.org>, <shivankg@amd.com>, <shy828301@gmail.com>,
	<sj@kernel.org>, <vbabka@suse.cz>, <weixugc@google.com>,
	<willy@infradead.org>, <ying.huang@linux.alibaba.com>, <ziy@nvidia.com>,
	<dave@stgolabs.net>, <yuanchu@google.com>, <hyeonggon.yoo@sk.com>
Subject: Re: [RFC PATCH 2/4] mm: kpromoted: Hot page info collection and
 promotion daemon
Message-ID: <20250318141737.00007495@huawei.com>
In-Reply-To: <65bd664f-efcb-4bec-bf6f-218bc992e6de@amd.com>
References: <20250306054532.221138-1-bharata@amd.com>
	<20250306054532.221138-3-bharata@amd.com>
	<20250314152850.00003112@huawei.com>
	<65bd664f-efcb-4bec-bf6f-218bc992e6de@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 18 Mar 2025 09:39:17 +0530
Bharata B Rao <bharata@amd.com> wrote:

> On 14-Mar-25 8:58 PM, Jonathan Cameron wrote:
> > On Thu, 6 Mar 2025 11:15:30 +0530
> > Bharata B Rao <bharata@amd.com> wrote:
> >   
> >> Subsystems that generate hot page access info can report that
> >> to kpromoted via this API:
> >>
> >> int kpromoted_record_access(u64 pfn, int nid, int src,
> >> 			    unsigned long time)  
> > 
> > This perhaps works as an interface for aggregating methods
> > that produce per access events.  Any hardware counter solution
> > is going to give you data that is closer to what you used for
> > the promotion decision.  
> 
> Right.
> 
> > 
> > We might need to aggregate at different levels.  So access
> > counting promotes to a hot list and we can inject other events
> > at that level.  The data I have from the CXL HMU is typically
> > after an epoch (period of time) these N pages were accessed more
> > than M times.  I can sort of map that to the internal storage
> > you have.  
> 
> Even for IBS source, I am aggregating data in per-cpu buffers before 
> presenting them one by one to kpromoted. Guess CXL HMU aggregated data 
> could be presented in a similar manner.

The nature of the data maybe a bit different but certainly should be
able to find somewhere in the stack!

> 
> > 
> > Would be good to evaluate approximate trackers on top of access
> > counts. I've no idea if sketches or similar would be efficient
> > enough (they have a bit of a write amplification problem) but
> > they may give good answers with much lower storage cost at the
> > risk of occasionally saying something is hot when it's not.  
> 
> Could me point me to some information about sketches??

https://en.wikipedia.org/wiki/Count%E2%80%93min_sketch
Is a good starting point but there are lots of related techniques
that trade off good statistical properties against complexity etc.

Roughly speaking you combine a sorted list of the very hottest
with a small number of different hash tables (the sketch) that let you
get an estimate of how hot things are that have dropped off your
hottest list (or not yet gotten hot enough to get into it). 

Looking for literature for top-k algorithms will find you
more references though not all are light weight enough to be
of interest here.

> 
> >   
> >>
> >> @pfn: The PFN of the memory accessed
> >> @nid: The accessing NUMA node ID
> >> @src: The temperature source (subsystem) that generated the
> >>        access info
> >> @time: The access time in jiffies
> >>
> >> Some temperature sources may not provide the nid from which
> >> the page was accessed. This is true for sources that use
> >> page table scanning for PTE Accessed bit. Currently the toptier
> >> node to which such pages should be promoted to is hard coded.  
> > 
> > For those cases (CXL HMU included) maybe we need to
> > consider how to fill in missing node info with at least a vague chance
> > of getting a reasonable target for migration.  We can always fall
> > back to random top tier node, or nearest one to where we are coming
> > from (on basis we maybe landed in this node based on a fallback
> > list when the top tier was under memory pressure).  
> 
> Yes. For A-bit scanners, Raghu has devised a scheme to obtain the best 
> possible list of target nodes for promotion. He should be sharing more 
> about it soon.

Excellent - look forward to seeing that.  Can think of a few possibilities
on how to get that data efficiently so I'm curious what Raghu has chosen.

> 
> > 
> >  From an interface point of view is that a problem for this layer,
> > or for the underlying tracking mechanism? (maybe with some helpers)  
> 
> It is not a problem from this interface point of view as this interface 
> expects a nid(or default value) and would use that for promotion. It is 
> up to the underlying tracking mechanism to provide the most appropriate 
> target nid.

I was wondering if there is some sharing to do, so whether we push Raghu's
means of getting a target node down into the tracker implementation or use
it to fill in messing info at this layer.  Will depend a bit on how
that technique works perhaps.

> 
> > Also, see later discussion of consistency of hotness tracking and
> > that the best solution for that differs from that to get
> > potential targets.  The answer to Is this page consistently hot?" can be
> > approximated with "Was this page once hot and is it not now cold?"
> > 
> > Access time is something some measurement techniques will only
> > give you wrt to a measurement was in a window (potentially a long
> > one if you are looking for consistent hotness over minutes).
> >   
> >>
> >> Also, the access time provided some sources may at best be
> >> considered approximate. This is especially true for hot pages
> >> detected by PTE A bit scanning.
> >>
> >> kpromoted currently maintains the hot PFN records in hash lists
> >> hashed by PFN value. Each record stores the following info:
> >>
> >> struct page_hotness_info {
> >> 	unsigned long pfn;
> >>
> >> 	/* Time when this record was updated last */
> >> 	unsigned long last_update;
> >>
> >> 	/*
> >> 	 * Number of times this page was accessed in the
> >> 	 * current window  
> > I'd express here how that window was defined (I read on
> > to answer the question I had here at first!)  
> 
> Currently the number of accesses that occur within an observation window 
> of 5s are considered for hotness calculation and access count is reset 
> when the window elapses. This needs to factor in history etc.

Just add that to the comment here perhaps.


> 
> >   
> >>
> >> 	/* Most recent access from this node */
> >> 	int hot_node;  
> > 
> > Probably want to relax the most recent part.  I'd guess
> > the ideal here would be if this is the node accessing it the most
> > 'recently'.  
> 
> You mean the node that did most number of accesses in the given 
> observation window and not necessarily the last (or most recent) 
> accessed node.

yes. Though maybe weighted in some fashion for recency?  Something
cheap to do that approximates that such as small saturating counters
with aging..

> 
> >   
> >>
> >> 	struct hlist_node hnode;
> >> };
> >>
> >> The way in which a page is categorized as hot enough to be
> >> promoted is pretty primitive now.  
> > 
> > That bit is very hard even if we solve everything else and heavily dependent
> > on workload access pattern stability and migration impact.  Maybe for
> > 'very hot' pages a fairly short consistency of hotness period is
> > good enough, but it gets much messier if we care about warm pages.
> > I guess we solve the 'very hot' first though and maybe avoid the phase
> > transition from an application starting to when it is at steady state
> > by considering a wait time for any new userspace process before we
> > consider moving anything?
> > 
> > Also worth noting that the mechanism that makes sense to check if a
> > detected hot page is 'stable hot' might use entirely different tracking
> > approach to that used to find it as a candidate.
> > 
> > Whether that requires passing data between hotness trackers is an
> > interesting question, or whether there is a natural ordering to trackers.  
> 
> I was envisioning that different hotness trackers would reinforce the 
> page hotness by reporting the same to kpromoted and there would be no 
> need to again pass data between hotness trackers.

What makes me wonder about that is the question of stability of hotness.
It is a really bad idea to move data based on a short sample - cost is huge
and quite a bit of data is only briefly hot - moving it to fast memory too
early just results in bouncing.  There are probably heuristics we can apply
on process age etc that will help, but generally we can't assume programs
don't have multiple phases with very different access characteristics.

The different tracking approaches have different sweet spots for short vs long
tracking. So it might be a case of one method, e.g. a hotness tracker
is only suitable for monitoring a short time period
(in the simplest sense, counters saturate if you run too long).
Don't read that to generally though as it's not a universal characteristic
and depends on the implementation used, but it is definitely true of
some potential implementations.

Having gotten a list of 1000+ candidate pages that might be worth moving,
we could use access bits to check it's still accessed reasonsably frequently
over the next minute. That can be much lower cost than an access tracker
that is looking for 'hottest'.

Where all these trade offs with timing occur is tricky and workload
dependent.  So figuring out how to autotune will be a challenging.

> 
> > 
> > 
> >   
> >> diff --git a/mm/kpromoted.c b/mm/kpromoted.c
> >> new file mode 100644
> >> index 000000000000..2a8b8495b6b3
> >> --- /dev/null
> >> +++ b/mm/kpromoted.c  


> >> +	bkt = hash_min(pfn, KPROMOTED_HASH_ORDER);
> >> +	mutex_lock(&page_hotness_lock[bkt]);
> >> +	phi = kpromoted_lookup(pfn, bkt, now);
> >> +	if (!phi) {
> >> +		ret = PTR_ERR(phi);
> >> +		goto out;
> >> +	}
> >> +
> >> +	if ((phi->last_update - now) > msecs_to_jiffies(KPROMOTED_FREQ_WINDOW)) {
> >> +		/* New window */
> >> +		phi->frequency = 1; /* TODO: Factor in the history */
> >> +		phi->last_update = now;
> >> +	} else {
> >> +		phi->frequency++;
> >> +	}
> >> +	phi->recency = now;
> >> +
> >> +	/*
> >> +	 * TODOs:
> >> +	 * 1. Source nid is hard-coded for some temperature sources  
> > 
> > Hard coded rather than unknown? I'm curious, what source has that issue?  
> 
> I meant that source didn't provide a nid and hence kpromoted ended up 
> promoting to a fixed (hard-coded for now) toptier node.

Sure. Unknown nid makes sense here.


Thanks,

Jonathan



