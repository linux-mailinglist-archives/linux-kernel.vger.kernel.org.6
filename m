Return-Path: <linux-kernel+bounces-414981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A253E9D3007
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 22:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A9028390E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2C21D043F;
	Tue, 19 Nov 2024 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="pShvDzp+"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80431D1736
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 21:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732051819; cv=none; b=fN/VN/muRGR5vA2Q1dIiEOjCjO79rqEPIVl+ky7xbGX2I6PoP59icyGlo97rv/fs9pIpZQDBnbbMw2qha+X3sexYE8giXxawsaE++Kg/W12uYqMqDDut2cX/W3f3o184Q4En5+usdai/W9GXuaJkjU9/1HWJHxAV3RagQFOqTfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732051819; c=relaxed/simple;
	bh=CMOj+BYj+LmZhGJYq18cSkk/ylI5vQUz3lssRzF/GJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eddKd7oi8WgBeX7z2cPsMbobIwXCXlSGlK5bt+2XH0A+pGLdMBcGBseSKLX1vmXeLRGirRO3xdz0YeajLE9CPGvFT/W+0yzvvKfvyjRqMfUmzE0IhmDi6lpzz2rAcZW7ghrysYpQz4L7A29qjZsvzZYRgCf+SLS3WCURvG2nASw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=pShvDzp+; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJK1R65000930;
	Tue, 19 Nov 2024 21:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=+L193XjdOlFFS1hxHj51N8V3pF
	AxmcW70ySoIR99Lqs=; b=pShvDzp+QZx+AsGZBXdnqEI7vZW1hSchFXOpAJqm3+
	cjh1J894mqhBNRchMWaOsfIkOqcIYfzgNMrnwCRxc5c2dL2jk7gyd/B9o6DC+E5w
	e3Y9R3UPYpQkaMaeDByDfwi+o+nFt7Bt0Acso6LLeD9rJlUbblaFyTXBrlyZyUkH
	jKytfUkJQjheJr+u9TdVKJEUMV9yi0HyLMFgax1c3ABWgPygzQG2nCGM7ugsbQlF
	bf98OG+/O4AAg47kzGyyZuuVcdUHCf5GIqEGsW0ZbT0etouZMdTbnazo1I47Nt5l
	h6cjPdZ9DL9su59lF2PI3NENmoA79YR7nMzmlX3nTDvw==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4311bggdsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 21:03:50 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 063FA800E9A;
	Tue, 19 Nov 2024 21:03:50 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 70FC28104BB;
	Tue, 19 Nov 2024 21:03:47 +0000 (UTC)
Date: Tue, 19 Nov 2024 15:03:45 -0600
From: Steve Wahl <steve.wahl@hpe.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Vishal Chourasia <vishalc@linux.ibm.com>, samir <samir@linux.ibm.com>,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH v2] sched/topology: improve topology_span_sane speed
Message-ID: <Zzz9MXHaUwpq2h0q@swahl-home.5wahls.com>
References: <20241031200431.182443-1-steve.wahl@hpe.com>
 <xhsmh4j4cctsc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <ZzTI6l-9Z0oCbrEH@swahl-home.5wahls.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzTI6l-9Z0oCbrEH@swahl-home.5wahls.com>
X-Proofpoint-GUID: 1eeG7gpqCsMy6v3UzOuLDUWBW7beJavE
X-Proofpoint-ORIG-GUID: 1eeG7gpqCsMy6v3UzOuLDUWBW7beJavE
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190153

On Wed, Nov 13, 2024 at 09:42:34AM -0600, Steve Wahl wrote:
> On Tue, Nov 12, 2024 at 05:15:47PM +0100, Valentin Schneider wrote:
> > On 31/10/24 15:04, Steve Wahl wrote:
> > > Use a different approach to topology_span_sane(), that checks for the
> > > same constraint of no partial overlaps for any two CPU sets for
> > > non-NUMA topology levels, but does so in a way that is O(N) rather
> > > than O(N^2).
> > >
> > > Instead of comparing with all other masks to detect collisions, keep
> > > one mask that includes all CPUs seen so far and detect collisions with
> > > a single cpumask_intersects test.
> > >
> > > If the current mask has no collisions with previously seen masks, it
> > > should be a new mask, which can be uniquely identified ("id") by the
> > > lowest bit set in this mask.  Mark that we've seen a mask with this
> > > id, and add the CPUs in this mask to the list of those seen.
> > >
> > > If the current mask does collide with previously seen masks, it should
> > > be exactly equal to a mask seen before, identified once again by the
> > > lowest bit the current mask has set.  It's an error if we haven't seen
> > > a mask with that id, or if the current mask doesn't match the one we
> > > get by looking up that id.
> > >
> > > Move the topology_span_sane() check out of the existing topology level
> > > loop, let it do its own looping to match the needs of this algorithm.
> > >
> > > On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
> > > the average time to take one processor offline is reduced from 2.18
> > > seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
> > > 34m49.765s without this change, 16m10.038s with this change in place.)
> > >
> > > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> > > ---
> > >
> > > Version 2: Adopted suggestion by K Prateek Nayak that removes an array and
> > > simplifies the code, and eliminates the erroneous use of
> > > num_possible_cpus() that Peter Zijlstra noted.
> > >
> > > Version 1 discussion:
> > >     https://lore.kernel.org/all/20241010155111.230674-1-steve.wahl@hpe.com/
> > >
> > >  kernel/sched/topology.c | 73 +++++++++++++++++++++++++++--------------
> > >  1 file changed, 48 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > > index 9748a4c8d668..6a2a3e91d59e 100644
> > > --- a/kernel/sched/topology.c
> > > +++ b/kernel/sched/topology.c
> > > @@ -2356,35 +2356,58 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
> > >  
> > >  /*
> > >   * Ensure topology masks are sane, i.e. there are no conflicts (overlaps) for
> > > - * any two given CPUs at this (non-NUMA) topology level.
> > > + * any two given CPUs on non-NUMA topology levels.
> > >   */
> > > -static bool topology_span_sane(struct sched_domain_topology_level *tl,
> > > -			      const struct cpumask *cpu_map, int cpu)
> > > +static bool topology_span_sane(const struct cpumask *cpu_map)
> > >  {
> > > -	int i = cpu + 1;
> > > +	struct sched_domain_topology_level *tl;
> > > +	struct cpumask *covered, *id_seen;
> > > +	int cpu;
> > >  
> > > -	/* NUMA levels are allowed to overlap */
> > > -	if (tl->flags & SDTL_OVERLAP)
> > > -		return true;
> > > +	lockdep_assert_held(&sched_domains_mutex);
> > > +	covered = sched_domains_tmpmask;
> > > +	id_seen = sched_domains_tmpmask2;
> > > +
> > > +	for_each_sd_topology(tl) {
> > > +
> > > +		/* NUMA levels are allowed to overlap */
> > > +		if (tl->flags & SDTL_OVERLAP)
> > > +			continue;
> > > +
> > > +		cpumask_clear(covered);
> > > +		cpumask_clear(id_seen);
> > >  
> > > -	/*
> > > -	 * Non-NUMA levels cannot partially overlap - they must be either
> > > -	 * completely equal or completely disjoint. Otherwise we can end up
> > > -	 * breaking the sched_group lists - i.e. a later get_group() pass
> > > -	 * breaks the linking done for an earlier span.
> > > -	 */
> > > -	for_each_cpu_from(i, cpu_map) {
> > >  		/*
> > > -		 * We should 'and' all those masks with 'cpu_map' to exactly
> > > -		 * match the topology we're about to build, but that can only
> > > -		 * remove CPUs, which only lessens our ability to detect
> > > -		 * overlaps
> > > +		 * Non-NUMA levels cannot partially overlap - they must be either
> > > +		 * completely equal or completely disjoint. Otherwise we can end up
> > > +		 * breaking the sched_group lists - i.e. a later get_group() pass
> > > +		 * breaks the linking done for an earlier span.
> > >  		 */
> > > -		if (!cpumask_equal(tl->mask(cpu), tl->mask(i)) &&
> > > -		    cpumask_intersects(tl->mask(cpu), tl->mask(i)))
> > > -			return false;
> > > +		for_each_cpu(cpu, cpu_map) {
> > > +			const struct cpumask *tl_cpu_mask = tl->mask(cpu);
> > > +			int id;
> > > +
> > > +			/* lowest bit set in this mask is used as a unique id */
> > > +			id = cpumask_first(tl_cpu_mask);
> > > +
> > > +			/* if this mask doesn't collide with what we've already seen */
> > > +			if (!cpumask_intersects(tl_cpu_mask, covered)) {
> > > +				/* Really odd case when cpu != id, likely not sane */
> > > +				if ((cpu != id) && !cpumask_equal(tl_cpu_mask, tl->mask(id)))
> > > +					return false;
> > > +				if (cpumask_test_and_set_cpu(id, id_seen))
> > > +					return false;
> > > +				cpumask_or(covered, tl_cpu_mask, covered);
> > > +			} else if ((!cpumask_test_cpu(id, id_seen)) ||
> > > +				    !cpumask_equal(tl->mask(id), tl_cpu_mask)) {
> > > +				/*
> > > +				 * a collision with covered should have exactly matched
> > > +				 * a previously seen mask with the same id
> > > +				 */
> > > +				return false;
> > > +			}
> > > +		}
> > 
> > Ok so you're speeding it up, but you still get a O(nr_cpu_ids) walk every
> > hotplug when the check itself only needs to be done at most once per
> > possible online CPU combination (~ 2^(nr_cpu_ids)). If all CPUs are kicked
> > to life at boot, then the check only needs to be done once. If you only
> > boot with a subset of present CPUs to speed things up, the check still
> > becomes irrelevant once you've kicked the rest to life.
> > 
> > I would reiterate my suggestion to get to a state where the check can be
> > entirely short-circuited [1].
> > 
> > [1]: http://lore.kernel.org/r/xhsmh8quc5ca4.mognet@vschneid-thinkpadt14sgen2i.remote.csb
> 
> Bringing forward a bit of that conversation:
> 
> > > I tried adding this, surprisingly I saw no effect on the time taken,
> > > perhaps even a small slowdown, when combined with my patch.  So at
> > > this point I don't intend to add it to v2 of the patch.
> > >
> > 
> > Thanks for testing, I assume your cpu_possible_mask reports more CPUs than
> > you have physically plugged in...
> 
> That assumption is wrong.  I started with all CPUs enabled.  Disabled
> and re-enabled cpus from there.  The timings I got were as I stated,
> no effect, perhaps a small slowdown.
> 
> > I guess it would make sense to short-circuit the function when
> > cpu_map is a subset of what we've previously checked, and then
> > re-kick the testing once new CPU(s) are plugged in. Something like
> > the untested below?
> > 
> > Optimisations notwithstanding, IMO we shouldn't be repeating checks if we
> > can avoid it.
> 
> I will attempt to measure it once more.  I was surprised at my
> measured results, but that's why we take them, right?
> 
> If I can't measure a difference, though, I am not sure it's
> appropriate to include the change with this patch, the point of which
> *is* optimization.

I completed timing tests; test system has 1920 logical CPUS, 2 threads
per core, 60 cores per NUMA node, and the script offlined then onlined
both threads of half the cores in each node.  Four runs each were
timed.  Times in seconds.

Unpatched kernel:
	Offline		Online
min	3991.57		3967.22
max	4025.59		4028.66
avg	4013.79		3996.75
stddev	15.28		29.90

With my patch:
	Offline		Online
min	1987.97		2130.7
max	2032.25		2150.93
avg	2017.43		2140.18
stddev	20.12		10.25

With my patch + Valentin's extra short-circuit patch:
min	2019.58		2137.43
max	2056.89		2223.86
avg	2033.04		2171.91
stddev	16.83		37.73

I'm at a loss as to why adding the short circuit slowed things down,
but it's in the noise.  If you want a new version of the patch
incorporating both changes after viewing these timings, I'm willing to
make that change.  Let me know how you feel.

Thanks for your time,

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise

