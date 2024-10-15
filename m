Return-Path: <linux-kernel+bounces-366835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B2C99FB40
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B230B21ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C565A1B0F22;
	Tue, 15 Oct 2024 22:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="A62KjsmN"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E392C185B47
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030836; cv=none; b=KHgWe7y0TvrbpqVAy3Hs3ib95MLtZrBOCCAbVLIDK6rD8aPRaHs2QzHg9s4+muId/de/7KJa0/zP22XasOwugYFBs8ARscz1d0RHHaAzir2A0kjjKF2gJ3DetLxtgslYRuIAc7eRp95AZ6RiiC7GOLwtPe7o03sZZmvJKqZjcwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030836; c=relaxed/simple;
	bh=Pa8o1QeMXSY0l5Qcs6OKSw78TdJwlhwEml/FKZu/MPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niSpX6xN6SH9qjFOiffUTX/6qF+n6/vDdK7shkNedH8O1jIbM41F99niIvCv/aQogBW4zz+qOwYsxyHhI57o1VAF4/1b0HOFmYkx/Bg7ChEgUauc6EZQ8ol5z1yUEd+vHqBPcQ3EipwzUy8xUxdBBLf2PXHWZA2KmQEsYKF9/50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=A62KjsmN; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FKKAYC015864;
	Tue, 15 Oct 2024 22:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=BvfThIuYqv6GnYLzbxkNMlAKjt
	ewSVu27ZdlTr4izHU=; b=A62KjsmNCuKBgxMUj++xa0yjDsXjPjsrVg59kz1i6w
	VAeSV9ciMQ5aEmChtugcpco+BT8u8abfTMTvzU5RQ/2opbKOIaFTB3SJHpqR8SMk
	ZcV955skqcAoks4Z8dXpU3de6LR+oXIgTtGJ48QrP/FWdPikdNPmGSlFTk97UHh6
	1Dt7L51mw2cjA47gknMFq8xqPA8yGuZmsRiQnZz6aYVMOo4sXKNpl/tgb8jNekHM
	Cm2cz10+juWycil6boH01g4v2DSp/cgRu2vZbl666BT+ISnnzDs4+CDS+0U5Jk1L
	tVfR6I38zGUJRzCvTQGeUaxFD/efdwcy01W9MudvmuJQ==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4297a0cr94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 22:20:04 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 22B4F806B37;
	Tue, 15 Oct 2024 22:20:03 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 1532280E713;
	Tue, 15 Oct 2024 22:19:59 +0000 (UTC)
Date: Tue, 15 Oct 2024 17:19:58 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/topology: improve topology_span_sane speed
Message-ID: <Zw7qjuDVIcBc8ECu@swahl-home.5wahls.com>
References: <20241010155111.230674-1-steve.wahl@hpe.com>
 <60473622-e6f9-561b-a269-9da64add4966@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60473622-e6f9-561b-a269-9da64add4966@amd.com>
X-Proofpoint-GUID: 2GVs67ztofOBD8ItgxCd3fV_1bCWPdnY
X-Proofpoint-ORIG-GUID: 2GVs67ztofOBD8ItgxCd3fV_1bCWPdnY
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150148

On Tue, Oct 15, 2024 at 03:50:49PM +0530, K Prateek Nayak wrote:
> Hello Steve,
> 
> On 10/10/2024 9:21 PM, Steve Wahl wrote:
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
> >   kernel/sched/topology.c | 79 ++++++++++++++++++++++++++++-------------
> >   1 file changed, 54 insertions(+), 25 deletions(-)
> > 
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 9748a4c8d668..c150074033d3 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -2356,36 +2356,65 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
> >   /*
> >    * Ensure topology masks are sane, i.e. there are no conflicts (overlaps) for
> > - * any two given CPUs at this (non-NUMA) topology level.
> > + * any two given CPUs on non-NUMA topology levels.
> >    */
> > -static bool topology_span_sane(struct sched_domain_topology_level *tl,
> > -			      const struct cpumask *cpu_map, int cpu)
> > +static bool topology_span_sane(const struct cpumask *cpu_map)
> >   {
> > -	int i = cpu + 1;
> > +	struct sched_domain_topology_level *tl;
> > +	const struct cpumask **masks;
> > +	struct cpumask *covered;
> > +	int cpu, id;
> > +	bool ret = false;
> > -	/* NUMA levels are allowed to overlap */
> > -	if (tl->flags & SDTL_OVERLAP)
> > -		return true;
> > +	lockdep_assert_held(&sched_domains_mutex);
> > +	covered = sched_domains_tmpmask;
> > +
> > +	masks = kmalloc_array(num_possible_cpus(), sizeof(struct cpumask *), GFP_KERNEL);
> > +	if (!masks)
> > +		return ret;
> 
> That looks like a very large array that seems unnecessary. Instead, is
> it possible to use "tl->mask(id)" down blow to check for equality? (I'll
> elaborate more below)
> 
> > +
> > +	for_each_sd_topology(tl) {
> > +
> > +		/* NUMA levels are allowed to overlap */
> > +		if (tl->flags & SDTL_OVERLAP)
> > +			continue;
> > +
> > +		cpumask_clear(covered);
> > +		memset(masks, 0, num_possible_cpus() * sizeof(struct cpumask *));
> > -	/*
> > -	 * Non-NUMA levels cannot partially overlap - they must be either
> > -	 * completely equal or completely disjoint. Otherwise we can end up
> > -	 * breaking the sched_group lists - i.e. a later get_group() pass
> > -	 * breaks the linking done for an earlier span.
> > -	 */
> > -	for_each_cpu_from(i, cpu_map) {
> >   		/*
> > -		 * We should 'and' all those masks with 'cpu_map' to exactly
> > -		 * match the topology we're about to build, but that can only
> > -		 * remove CPUs, which only lessens our ability to detect
> > -		 * overlaps
> > +		 * Non-NUMA levels cannot partially overlap - they must be either
> > +		 * completely equal or completely disjoint. Otherwise we can end up
> > +		 * breaking the sched_group lists - i.e. a later get_group() pass
> > +		 * breaks the linking done for an earlier span.
> >   		 */
> > -		if (!cpumask_equal(tl->mask(cpu), tl->mask(i)) &&
> > -		    cpumask_intersects(tl->mask(cpu), tl->mask(i)))
> > -			return false;
> > +		for_each_cpu(cpu, cpu_map) {
> > +			/* lowest bit set in this mask is used as a unique id */
> > +			id = cpumask_first(tl->mask(cpu));
> 
> nit. "id" can be declared in this scope since it is not used anywhere
> outside. Also perhaps you can store "tl->mask(cpu)" instead of calling
> the function multiple times below. Thoughts?

I think that would work.  I'll see if I can work it in.

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
> 
> Elaborating the above point, instead of caching cpumask in an array with:
> 
> 	masks[id] = tl->mask(cpu);
> 
> how about, having a single "struct cpumask *id_seen" that is cleared at
> the same time as "covered" cpumask, and a bit corresponding to every
> "id" seen is set. If there is an intersection, and this bit against the
> "id" seen is not set or if the "tl->mask(cpu)" is not same as
> "tl->mask(id)", one can detect if the range is overlapping. This
> requires much less space compared to an array of cpumasks but I'm not
> sure how much more expensive it is to access "tl->mask(id)" compared
> to reading it from the array of cpumasks.

So, I was at first skeptical that this would work, I thought it might
miss some error cases.  But after a lot of thought I think I was wrong
and it will work.  And it lets me get rid of the array and with it
the use of num_possible_cpus vs. nr_cpu_ids that Peter Z. commented
about.

Thanks, I will re-work and post a new version.

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise

