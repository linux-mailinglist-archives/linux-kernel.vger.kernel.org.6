Return-Path: <linux-kernel+bounces-371613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 420BE9A3D59
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98E11F21F17
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030EF4207A;
	Fri, 18 Oct 2024 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NybafT9Y"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12FF2F46
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729251401; cv=none; b=Av2FgD/GfghwHxvGAkqtWfAQlRU3TKA8NJ3com81WAwenQVx17r7Xbvzx42WMNUtxSUwZUwc9/yg7/fUG3QDsv+alfsyj+4xWLTXTvlUsBmz7L3XbkV8HfVEHVNeBqaEWr0yJEKrzAqH2f/9CAj5EfiB7RGJkKDXNBFzvAdYvsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729251401; c=relaxed/simple;
	bh=4pzYH27kexmk58V14s78PMCtx9I72AUyzQ2NX6PTvbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kgb8yzXJHsZnu2yr95S6u2it0e//RkNdNmSmIhEp/f6bKZm3+Zkb43ZWSCh7lkiLc8mHTU4Emrl+BzlwEoL/3R9ju1mXOJoJcdT16V16g90cP6fbOX3cK5e14YMjFukRoyfIruNaKtnfWJzEyKed2viuVcfoYa11p8hq9+usGLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NybafT9Y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I9wA0O025098;
	Fri, 18 Oct 2024 11:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=UVrWRVZd//MTitsCOA1LI3/VouAIsG
	n/iAnymff9yVA=; b=NybafT9YutM8+NQdC165V940Nd2LC1oNHsr1nF3yzi+kvO
	mP2FYuFjHxkqseniGGWDwUP2TYMmQnrMN6UWnlr/CXmBIJmQKdY/Vy6LywMvdeGb
	3rtOFPa0y1fIkazDrUdAKgdtLCIefWD+Avk1PTs6hMfJ23jDcl0uYPTVyB7uMa5a
	HatfN2ufWPWjcyih18X1OM4BDb9k/JegIrlhZFLyPZnEm+d2HEJnVW8/ArsAgPz4
	Vy6skacXU8HUm3sTQbN/rdzbeh76bNxMqbrzaJKpNQLlncLb0XV3sp41wSCLX1QW
	CxeDtZIHEKG2sKZAUZpm45BXvdY3rkOSNsiONILQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42asbd8sa1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 11:35:53 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49IBW2LB023603;
	Fri, 18 Oct 2024 11:35:52 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42asbd8s9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 11:35:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49IBUk3r002343;
	Fri, 18 Oct 2024 11:35:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284en4768-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 11:35:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49IBZnla47055126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 11:35:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 330022004D;
	Fri, 18 Oct 2024 11:35:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47DC120043;
	Fri, 18 Oct 2024 11:35:46 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.109.245.217])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Oct 2024 11:35:46 +0000 (GMT)
Date: Fri, 18 Oct 2024 17:05:43 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] sched/topology: improve topology_span_sane speed
Message-ID: <ZxJIDwHNzPkuyGrU@linux.ibm.com>
References: <20241010155111.230674-1-steve.wahl@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010155111.230674-1-steve.wahl@hpe.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tUmU6aCUgHqwn63SkxV72_ofvGncmj_N
X-Proofpoint-GUID: MqMknrqi3I2F0kCz99-spMeBY9cMUZJ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 mlxlogscore=907
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180073

On Thu, Oct 10, 2024 at 10:51:11AM -0500, Steve Wahl wrote:
> Use a different approach to topology_span_sane(), that checks for the
> same constraint of no partial overlaps for any two CPU sets for
> non-NUMA topology levels, but does so in a way that is O(N) rather
> than O(N^2).
> 
> Instead of comparing with all other masks to detect collisions, keep
> one mask that includes all CPUs seen so far and detect collisions with
> a single cpumask_intersects test.
> 
> If the current mask has no collisions with previously seen masks, it
> should be a new mask, which can be uniquely identified by the lowest
> bit set in this mask.  Keep a pointer to this mask for future
> reference (in an array indexed by the lowest bit set), and add the
> CPUs in this mask to the list of those seen.
> 
> If the current mask does collide with previously seen masks, it should
> be exactly equal to a mask seen before, looked up in the same array
> indexed by the lowest bit set in the mask, a single comparison.
> 
> Move the topology_span_sane() check out of the existing topology level
> loop, let it use its own loop so that the array allocation can be done
> only once, shared across levels.
> 
> On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
> the average time to take one processor offline is reduced from 2.18
> seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
> 34m49.765s without this change, 16m10.038s with this change in place.)
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> ---
>  kernel/sched/topology.c | 79 ++++++++++++++++++++++++++++-------------
>  1 file changed, 54 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9748a4c8d668..c150074033d3 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2356,36 +2356,65 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
>  
>  /*
>   * Ensure topology masks are sane, i.e. there are no conflicts (overlaps) for
> - * any two given CPUs at this (non-NUMA) topology level.
> + * any two given CPUs on non-NUMA topology levels.
>   */
> -static bool topology_span_sane(struct sched_domain_topology_level *tl,
> -			      const struct cpumask *cpu_map, int cpu)
> +static bool topology_span_sane(const struct cpumask *cpu_map)
>  {
> -	int i = cpu + 1;
> +	struct sched_domain_topology_level *tl;
> +	const struct cpumask **masks;
> +	struct cpumask *covered;
> +	int cpu, id;
> +	bool ret = false;
>  
> -	/* NUMA levels are allowed to overlap */
> -	if (tl->flags & SDTL_OVERLAP)
> -		return true;
> +	lockdep_assert_held(&sched_domains_mutex);
> +	covered = sched_domains_tmpmask;
> +
> +	masks = kmalloc_array(num_possible_cpus(), sizeof(struct cpumask *), GFP_KERNEL);
> +	if (!masks)
> +		return ret;
> +
> +	for_each_sd_topology(tl) {
> +
> +		/* NUMA levels are allowed to overlap */
> +		if (tl->flags & SDTL_OVERLAP)
> +			continue;
> +
> +		cpumask_clear(covered);
> +		memset(masks, 0, num_possible_cpus() * sizeof(struct cpumask *));
>  
> -	/*
> -	 * Non-NUMA levels cannot partially overlap - they must be either
> -	 * completely equal or completely disjoint. Otherwise we can end up
> -	 * breaking the sched_group lists - i.e. a later get_group() pass
> -	 * breaks the linking done for an earlier span.
> -	 */
> -	for_each_cpu_from(i, cpu_map) {
>  		/*
> -		 * We should 'and' all those masks with 'cpu_map' to exactly
> -		 * match the topology we're about to build, but that can only
> -		 * remove CPUs, which only lessens our ability to detect
> -		 * overlaps
> +		 * Non-NUMA levels cannot partially overlap - they must be either
> +		 * completely equal or completely disjoint. Otherwise we can end up
> +		 * breaking the sched_group lists - i.e. a later get_group() pass
> +		 * breaks the linking done for an earlier span.
>  		 */
> -		if (!cpumask_equal(tl->mask(cpu), tl->mask(i)) &&
> -		    cpumask_intersects(tl->mask(cpu), tl->mask(i)))
> -			return false;
> +		for_each_cpu(cpu, cpu_map) {
> +			/* lowest bit set in this mask is used as a unique id */
> +			id = cpumask_first(tl->mask(cpu));
> +
> +			/* if this mask doesn't collide with what we've already seen */
> +			if (!cpumask_intersects(tl->mask(cpu), covered)) {
> +				/* this failing would be an error in this algorithm */
> +				if (WARN_ON(masks[id]))
> +					goto notsane;
> +
> +				/* record the mask we saw for this id */
> +				masks[id] = tl->mask(cpu);
> +				cpumask_or(covered, tl->mask(cpu), covered);
> +			} else if ((!masks[id]) || !cpumask_equal(masks[id], tl->mask(cpu))) {
> +				/*
> +				 * a collision with covered should have exactly matched
> +				 * a previously seen mask with the same id
> +				 */
> +				goto notsane;
> +			}
> +		}
>  	}
> +	ret = true;
>  
> -	return true;
> + notsane:
> +	kfree(masks);
> +	return ret;
>  }
>  
>  /*
> @@ -2417,9 +2446,6 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>  		sd = NULL;
>  		for_each_sd_topology(tl) {
>  
> -			if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
> -				goto error;
> -
>  			sd = build_sched_domain(tl, cpu_map, attr, sd, i);
>  
>  			has_asym |= sd->flags & SD_ASYM_CPUCAPACITY;
> @@ -2433,6 +2459,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>  		}
>  	}
>  
> +	if (WARN_ON(!topology_span_sane(cpu_map)))
> +		goto error;
Hi Steve,

Is there any reason why above check is done after initializing
sched domain struct for all the CPUs in the cpu_map?

It looks to me, that this check can be performed before the call to
__visit_domain_allocation_hell() in the build_sched_domains()
resulting in early return if topology_span_sane() detects incorrect
topology.

Also, the error path in the current code only cleans up d->rd struct, keeping 
all the work done by build_sched_domain() inside the loop and __alloc_sdt() 
called from __visit_domain_allocation_hell()

is it because we need all that work to remain intact?

static void __free_domain_allocs(struct s_data *d, enum s_alloc what,
				 const struct cpumask *cpu_map)
{
	switch (what) {
	case sa_rootdomain:
		if (!atomic_read(&d->rd->refcount))
			free_rootdomain(&d->rd->rcu);
		fallthrough;
	case sa_sd:
		free_percpu(d->sd);
		fallthrough;
	case sa_sd_storage:
		__sdt_free(cpu_map);
		fallthrough;
	case sa_none:
		break;
	}
}

> +
>  	/* Build the groups for the domains */
>  	for_each_cpu(i, cpu_map) {
>  		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
> -- 
> 2.26.2
> 

