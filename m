Return-Path: <linux-kernel+bounces-400411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DF69C0D22
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF871F235E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21702170AE;
	Thu,  7 Nov 2024 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="BhSv/ZlI"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400B721620A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001502; cv=none; b=W4SPd3VPDVpbpP6oCEWCM6gjjmZtofTH1UL3ab4d6TedcJ0MOa84zcLWQyeRiiizoKSpG1VON9Qy2i9FYebSuNCZwNGdP6CsNwH6SrpphOcWK7eOOk/HLsctspqw4/q6EKLUIJXjvfLIS0i15QmmQrR9hbnRQdhUpD8R+vqeXyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001502; c=relaxed/simple;
	bh=SKq93ELwemMIkeH2BafkYe/Rz8K6ZLxxC5aL6zPT81U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMckIHD0zry+pkLuHbw2xO83bWOTYTD0pdXfy5Pq3S7QNVz347b7Nw0TBJenwMVa7NmdJRdFELjka2wZo8L0owv8CTqHyiolD0QXquziqe0L2k9Qv+1JKiAwSlWtu4kpmJLyh3X+yO5UbowwBC1CbFX0Q0Gw+4T9TXYD1N7uycY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=BhSv/ZlI; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7CL7IA003908;
	Thu, 7 Nov 2024 17:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=b58dVz/1SjXZO/0oHlIC8n9mqw
	QV+KForNhPkLNG+GQ=; b=BhSv/ZlICO+mY5C8BO/QukpUZcHddO2lmJOfRaBwku
	tJqK7hXfMW4CVDSVUPvsIwhhermSW8WLClwYEvID/9YDBTimbLUYUKAn+im/8nvE
	Aio/EQ66soBNWJJyTbhwtabJy3ilelEwGd8oJu/iRORs6OT7SybUIUdpysfFvhZ5
	A3OTZbcPr1iITObNh9QCDxQRX3k1X3GDknsDu5pYFgQ6qFkdOrH0CuNJ0ARKJqD0
	ckjGi2eimws+FezbNB9f6pxshU1Y82WOX7FFB+px85VzlEOeznoTGJEtUs0D0w/W
	gc6se1/L8BawGO+4b0tC8TpJgsVSNRy9dv/hFpdqeahg==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 42rwftjwyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 17:44:01 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id A3859295CB;
	Thu,  7 Nov 2024 17:43:59 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id D452180BB08;
	Thu,  7 Nov 2024 17:43:56 +0000 (UTC)
Date: Thu, 7 Nov 2024 11:43:54 -0600
From: Steve Wahl <steve.wahl@hpe.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Vishal Chourasia <vishalc@linux.ibm.com>,
        samir <samir@linux.ibm.com>, Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH v2] sched/topology: improve topology_span_sane speed
Message-ID: <Zyz8WpuIppVhcLHU@swahl-home.5wahls.com>
References: <20241031200431.182443-1-steve.wahl@hpe.com>
 <19ae802e-fada-68ee-8a78-fbd61f85d7ed@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19ae802e-fada-68ee-8a78-fbd61f85d7ed@amd.com>
X-Proofpoint-GUID: FJ006ThMY4UTR6UqOz1wPQLU4WAGnX0H
X-Proofpoint-ORIG-GUID: FJ006ThMY4UTR6UqOz1wPQLU4WAGnX0H
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070138

On Wed, Nov 06, 2024 at 10:19:13AM +0530, K Prateek Nayak wrote:
> Hello Steve,

Hi, Prateek; thanks for looking at this patch.

> On 11/1/2024 1:34 AM, Steve Wahl wrote:
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
> > should be a new mask, which can be uniquely identified ("id") by the
> > lowest bit set in this mask.  Mark that we've seen a mask with this
> > id, and add the CPUs in this mask to the list of those seen.
> > 
> > If the current mask does collide with previously seen masks, it should
> > be exactly equal to a mask seen before, identified once again by the
> > lowest bit the current mask has set.  It's an error if we haven't seen
> > a mask with that id, or if the current mask doesn't match the one we
> > get by looking up that id.
> > 
> > Move the topology_span_sane() check out of the existing topology level
> > loop, let it do its own looping to match the needs of this algorithm.
> > 
> > On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
> > the average time to take one processor offline is reduced from 2.18
> > seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
> > 34m49.765s without this change, 16m10.038s with this change in place.)
> > 
> > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> > ---
> > 
> > Version 2: Adopted suggestion by K Prateek Nayak that removes an array and
> > simplifies the code, and eliminates the erroneous use of
> > num_possible_cpus() that Peter Zijlstra noted.
> > 
> > Version 1 discussion:
> >      https://lore.kernel.org/all/20241010155111.230674-1-steve.wahl@hpe.com/
> > 
> >   kernel/sched/topology.c | 73 +++++++++++++++++++++++++++--------------
> >   1 file changed, 48 insertions(+), 25 deletions(-)
> > 
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 9748a4c8d668..6a2a3e91d59e 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -2356,35 +2356,58 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
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
> > +	struct cpumask *covered, *id_seen;
> > +	int cpu;
> > -	/* NUMA levels are allowed to overlap */
> > -	if (tl->flags & SDTL_OVERLAP)
> > -		return true;
> > +	lockdep_assert_held(&sched_domains_mutex);
> > +	covered = sched_domains_tmpmask;
> > +	id_seen = sched_domains_tmpmask2;
> > +
> > +	for_each_sd_topology(tl) {
> > +
> > +		/* NUMA levels are allowed to overlap */
> > +		if (tl->flags & SDTL_OVERLAP)
> > +			continue;
> > +
> > +		cpumask_clear(covered);
> > +		cpumask_clear(id_seen);
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
> > +			const struct cpumask *tl_cpu_mask = tl->mask(cpu);
> > +			int id;
> > +
> > +			/* lowest bit set in this mask is used as a unique id */
> > +			id = cpumask_first(tl_cpu_mask);
> > +
> > +			/* if this mask doesn't collide with what we've already seen */
> > +			if (!cpumask_intersects(tl_cpu_mask, covered)) {
> > +				/* Really odd case when cpu != id, likely not sane */
> > +				if ((cpu != id) && !cpumask_equal(tl_cpu_mask, tl->mask(id)))
> 
> I was wondering, since we are doing a "for_each_cpu(cpu, cpu_map)",
> wouldn't we always see the "id" cpu first since "id" is nothing but the
> first CPU of the topology level mask? Maybe I'm not thinking creatively
> enough but I cannot see a scenario where the sanity check will trip
> here and not in the "else if" clause down below :)

The scenario I was thinking of that could trip this is if
tl->mask(cpu) does not actually include this CPU.  It should not
happen, but we are looking to detect a malformed set of masks, so I
added the check.

> I've done some basic testing on my system on all NPS modes and also
> with "numa=fake" cmdline and I do not see any splats in my case. Please
> feel free to include:
> 
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 
> I'll try to hack the kernel to trip the topology check, with and without
> the patch, and also try to get back with some hotplug perf numbers but
> for the time being I do not see any false negatives with the approach on
> my dual socket 3rd Generation EPYC system (2 x 64C/128T)
> 
> -- 
> Thanks and Regards,
> Prateek

Thanks so much!

--> Steve Wahl

> > +					return false;
> > +				if (cpumask_test_and_set_cpu(id, id_seen))
> > +					return false;
> > +				cpumask_or(covered, tl_cpu_mask, covered);
> > +			} else if ((!cpumask_test_cpu(id, id_seen)) ||
> > +				    !cpumask_equal(tl->mask(id), tl_cpu_mask)) {
> > +				/*
> > +				 * a collision with covered should have exactly matched
> > +				 * a previously seen mask with the same id
> > +				 */
> > +				return false;
> > +			}
> > +		}
> >   	}
> > -
> >   	return true;
> >   }
> > @@ -2417,9 +2440,6 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
> >   		sd = NULL;
> >   		for_each_sd_topology(tl) {
> > -			if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
> > -				goto error;
> > -
> >   			sd = build_sched_domain(tl, cpu_map, attr, sd, i);
> >   			has_asym |= sd->flags & SD_ASYM_CPUCAPACITY;
> > @@ -2433,6 +2453,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
> >   		}
> >   	}
> > +	if (WARN_ON(!topology_span_sane(cpu_map)))
> > +		goto error;
> > +
> >   	/* Build the groups for the domains */
> >   	for_each_cpu(i, cpu_map) {
> >   		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
> 

-- 
Steve Wahl, Hewlett Packard Enterprise

