Return-Path: <linux-kernel+bounces-374748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8DE9A6F58
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41673B21868
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD101E1A3B;
	Mon, 21 Oct 2024 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="mDsHzhXO"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3BE1E0E0E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729527736; cv=none; b=ANSeAYs3dXlpQmtgvAc6OCZ8OnnlIgiflWP0NKUOX41NQy22jhtuntdI+9jtgaht/+dozAKcNP+r4ki51yMdOG1HXirvPl2cU2ViQZd45YgChu4uVZcariH6y0rBsbnnrQTsYZ3iIN51cQnqYaRmbLa16fN/1qhlRUZuedGmOR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729527736; c=relaxed/simple;
	bh=lzp0H/Y1uO9GRVm194ac4GVLjcxyGmupgeugTXZfLt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DC4YTUFQJIg79EACgIAjdly9TKb2M34mvlbUXfkCbhp4bW3TI/AGZrlDB8gwFEwT+TWvHjcYpj7rlctBxSX8oWLrqO5jtT58ashjYMk2A8un0hHx7i95a4peMOvuUBKvgdna+wzpXgL8aRVQIAGJHBhRODFVlZsZRH9QDeZT0uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=mDsHzhXO; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LEWPa4015394;
	Mon, 21 Oct 2024 16:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=tLBv13IoTRnJ2ISoDjmkpN9Bi1
	nHEHfzkKAfNd2g6bc=; b=mDsHzhXOgiZEpvFIBeFkdyiOm2j4PZgeshONKNtcue
	OBeL8gbH17Miy8BDv5bf80NotIaUhQGb2F3akfWchA99tZRPiK17cvcNvq4abJLV
	s1JHKubkEO4jiprq5Efusep/Tmbhxu0u3axIsICfxuCRj1iYaL+cIiQ9p/SZf0a0
	Emgv63Z3yudtUrT4HtvrfV0tWw091FTsNoYCZca4w1XsG9xt7JN6g3URDG/8BUTl
	NAf1hdsnWlzXa/I2BKT8/F8Zm0ycGKeac8vHn1QM2fOBCes4INztz6ibBdhAqB9R
	eUlKw7lkrRQGElSr2FMJcDoGTP+TaEbFQey+zZPZgsbg==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 42dq0kad12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 16:21:05 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id A19D213759;
	Mon, 21 Oct 2024 16:21:04 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 744CE8065FD;
	Mon, 21 Oct 2024 16:21:00 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:20:58 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] sched/topology: improve topology_span_sane speed
Message-ID: <ZxZ_arDwEu489GkN@swahl-home.5wahls.com>
References: <20241010155111.230674-1-steve.wahl@hpe.com>
 <ZxJIDwHNzPkuyGrU@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxJIDwHNzPkuyGrU@linux.ibm.com>
X-Proofpoint-ORIG-GUID: RkcI-V7mKgVbpz91_pmITAQl9Y1UqY1E
X-Proofpoint-GUID: RkcI-V7mKgVbpz91_pmITAQl9Y1UqY1E
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210117

On Fri, Oct 18, 2024 at 05:05:43PM +0530, Vishal Chourasia wrote:
> On Thu, Oct 10, 2024 at 10:51:11AM -0500, Steve Wahl wrote:
> > Use a different approach to topology_span_sane(), that checks for the
> > same constraint of no partial overlaps for any two CPU sets for
> > non-NUMA topology levels, but does so in a way that is O(N) rather
> > than O(N^2).
> > 
> > Instead of comparing with all other masks to detect collisions, keep
> > one mask that includes all CPUs seen so far and detect collisions with
> > a single cpumask_intersects test.
> > 
> > If the current mask has no collisions with previously seen masks, it
> > should be a new mask, which can be uniquely identified by the lowest
> > bit set in this mask.  Keep a pointer to this mask for future
> > reference (in an array indexed by the lowest bit set), and add the
> > CPUs in this mask to the list of those seen.
> > 
> > If the current mask does collide with previously seen masks, it should
> > be exactly equal to a mask seen before, looked up in the same array
> > indexed by the lowest bit set in the mask, a single comparison.
> > 
> > Move the topology_span_sane() check out of the existing topology level
> > loop, let it use its own loop so that the array allocation can be done
> > only once, shared across levels.
> > 
> > On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
> > the average time to take one processor offline is reduced from 2.18
> > seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
> > 34m49.765s without this change, 16m10.038s with this change in place.)
> > 
> > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> > ---
> >  kernel/sched/topology.c | 79 ++++++++++++++++++++++++++++-------------
> >  1 file changed, 54 insertions(+), 25 deletions(-)
> > 
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 9748a4c8d668..c150074033d3 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -2356,36 +2356,65 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
> >  
> >  /*
> >   * Ensure topology masks are sane, i.e. there are no conflicts (overlaps) for
> > - * any two given CPUs at this (non-NUMA) topology level.
> > + * any two given CPUs on non-NUMA topology levels.
> >   */
> > -static bool topology_span_sane(struct sched_domain_topology_level *tl,
> > -			      const struct cpumask *cpu_map, int cpu)
> > +static bool topology_span_sane(const struct cpumask *cpu_map)
> >  {
> > -	int i = cpu + 1;
> > +	struct sched_domain_topology_level *tl;
> > +	const struct cpumask **masks;
> > +	struct cpumask *covered;
> > +	int cpu, id;
> > +	bool ret = false;
> >  
> > -	/* NUMA levels are allowed to overlap */
> > -	if (tl->flags & SDTL_OVERLAP)
> > -		return true;
> > +	lockdep_assert_held(&sched_domains_mutex);
> > +	covered = sched_domains_tmpmask;
> > +
> > +	masks = kmalloc_array(num_possible_cpus(), sizeof(struct cpumask *), GFP_KERNEL);
> > +	if (!masks)
> > +		return ret;
> > +
> > +	for_each_sd_topology(tl) {
> > +
> > +		/* NUMA levels are allowed to overlap */
> > +		if (tl->flags & SDTL_OVERLAP)
> > +			continue;
> > +
> > +		cpumask_clear(covered);
> > +		memset(masks, 0, num_possible_cpus() * sizeof(struct cpumask *));
> >  
> > -	/*
> > -	 * Non-NUMA levels cannot partially overlap - they must be either
> > -	 * completely equal or completely disjoint. Otherwise we can end up
> > -	 * breaking the sched_group lists - i.e. a later get_group() pass
> > -	 * breaks the linking done for an earlier span.
> > -	 */
> > -	for_each_cpu_from(i, cpu_map) {
> >  		/*
> > -		 * We should 'and' all those masks with 'cpu_map' to exactly
> > -		 * match the topology we're about to build, but that can only
> > -		 * remove CPUs, which only lessens our ability to detect
> > -		 * overlaps
> > +		 * Non-NUMA levels cannot partially overlap - they must be either
> > +		 * completely equal or completely disjoint. Otherwise we can end up
> > +		 * breaking the sched_group lists - i.e. a later get_group() pass
> > +		 * breaks the linking done for an earlier span.
> >  		 */
> > -		if (!cpumask_equal(tl->mask(cpu), tl->mask(i)) &&
> > -		    cpumask_intersects(tl->mask(cpu), tl->mask(i)))
> > -			return false;
> > +		for_each_cpu(cpu, cpu_map) {
> > +			/* lowest bit set in this mask is used as a unique id */
> > +			id = cpumask_first(tl->mask(cpu));
> > +
> > +			/* if this mask doesn't collide with what we've already seen */
> > +			if (!cpumask_intersects(tl->mask(cpu), covered)) {
> > +				/* this failing would be an error in this algorithm */
> > +				if (WARN_ON(masks[id]))
> > +					goto notsane;
> > +
> > +				/* record the mask we saw for this id */
> > +				masks[id] = tl->mask(cpu);
> > +				cpumask_or(covered, tl->mask(cpu), covered);
> > +			} else if ((!masks[id]) || !cpumask_equal(masks[id], tl->mask(cpu))) {
> > +				/*
> > +				 * a collision with covered should have exactly matched
> > +				 * a previously seen mask with the same id
> > +				 */
> > +				goto notsane;
> > +			}
> > +		}
> >  	}
> > +	ret = true;
> >  
> > -	return true;
> > + notsane:
> > +	kfree(masks);
> > +	return ret;
> >  }
> >  
> >  /*
> > @@ -2417,9 +2446,6 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
> >  		sd = NULL;
> >  		for_each_sd_topology(tl) {
> >  
> > -			if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
> > -				goto error;
> > -
> >  			sd = build_sched_domain(tl, cpu_map, attr, sd, i);
> >  
> >  			has_asym |= sd->flags & SD_ASYM_CPUCAPACITY;
> > @@ -2433,6 +2459,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
> >  		}
> >  	}
> >  
> > +	if (WARN_ON(!topology_span_sane(cpu_map)))
> > +		goto error;
> Hi Steve,

Vishal, thank you for taking the time to review.

> Is there any reason why above check is done after initializing
> sched domain struct for all the CPUs in the cpu_map?

The original check was done in the same for_each_sd_topology(tl) loop
that calls build_sched_domain().  I had trouble 100% convincing myself
that calls to build_sched_domain() on the previous levels couldn't
affect calls to tl->mask() in later levels, so I placed the new check
after all calls to build_sched_domain were complete.

> It looks to me, that this check can be performed before the call to
> __visit_domain_allocation_hell() in the build_sched_domains()
> resulting in early return if topology_span_sane() detects incorrect
> topology.

This might be OK to do.  I would greatly appreciate somebody well
versed in this code area telling me for certain that it would work.

> Also, the error path in the current code only cleans up d->rd struct, keeping 
> all the work done by build_sched_domain() inside the loop and __alloc_sdt() 
> called from __visit_domain_allocation_hell()
> 
> is it because we need all that work to remain intact?

I'm not seeing this.  The return from __visit_domain_allocation_hell()
is stored in alloc_state immediately checked to be == sa_rootdomain;
if not, the error path is taken, deallocating everything and
returning.

The rest of the function does not touch alloc_state, so any error from
that point on makes the call to __free_domain_allocs with what ==
sa_rootdomain, which seems to undo everything.

Are you possibly missing the fallthroughs in __free_domain_allocs()
even though they're clearly emphasized?

> static void __free_domain_allocs(struct s_data *d, enum s_alloc what,
> 				 const struct cpumask *cpu_map)
> {
> 	switch (what) {
> 	case sa_rootdomain:
> 		if (!atomic_read(&d->rd->refcount))
> 			free_rootdomain(&d->rd->rcu);
> 		fallthrough;
> 	case sa_sd:
> 		free_percpu(d->sd);
> 		fallthrough;
> 	case sa_sd_storage:
> 		__sdt_free(cpu_map);
> 		fallthrough;
> 	case sa_none:
> 		break;
> 	}
> }
> 

Thanks,

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise

