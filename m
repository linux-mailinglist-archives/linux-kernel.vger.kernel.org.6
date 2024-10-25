Return-Path: <linux-kernel+bounces-381991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B342B9B075D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BF31C24A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2041C155C8C;
	Fri, 25 Oct 2024 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="kX3780rA"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E7E70839
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868799; cv=none; b=nWyScNH0V4bUFX5NP62MyQDDWZ3j9rPO5odymG01iKMyfsZuaDQbp9Sssyns0tSw6iCj6AMqwsKiWaO5RVbKjUApuVnru97Xw3rgvIRJWFFjJkn1WSm/Ie44u8WVdtRyr3TkLKLaTgxFS9s+876CDZSRjXS70u2NyYfZJdK0ci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868799; c=relaxed/simple;
	bh=RXjbQjWuvBGjAM9mdgID+Z8MbBOg9axZEb0E4R8GZco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2RMAUAasBdnfsIBhVb1jJ3+UsfiSc6naPR7Z550cLdesqCQ/TgEtIrhIXYxlErqmNj4K3Yn3O6yCtC66E8VSw9JYSqyrC92/+jnIzxD6jiDGaDe/1VPqYm0+KjArop3MtDFVP1rRFNIxBEEhlw4ewoLGbMN/ZxJd5UfKgiQErs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=kX3780rA; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PB3BH4022996;
	Fri, 25 Oct 2024 15:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=RFcTYy3srZYLFshIC0xOHECkko
	QynMM7aw09SnKhvh4=; b=kX3780rAADPBjmFQ2mDeMFZdtVBT8EmiuuoD1mAX4P
	A9q75JdVCcORTKDwWDV6idh5xLI3J8+OBW74klD8Ydz3N9KeXF+JrqfNd0Nt5ejY
	UrvEaBLMIso41YUV8u6g2kFVAB7WLpUrD/RHXPWdrcd87ITUqob9tvjH/pgV+66Y
	l2BglR4ExAWqVjIvtKwi2vusEq0KgxHRoDekZD05RRDLXjivG8vPF35FMsOAccLN
	+kf5TfFmBx53OHAdDGvlbyMe+M6tuPLZna1rmjoYHL9n+0PaGoGrvjDESVNxGvs+
	LBDjVvDYFwy6p+c5OxedmWPRwmq6VDWm2JR7cTeo+n9A==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 42g4mc4r94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 15:06:06 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 9EBE213761;
	Fri, 25 Oct 2024 15:06:05 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 35851800EB1;
	Fri, 25 Oct 2024 15:06:02 +0000 (UTC)
Date: Fri, 25 Oct 2024 10:06:00 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] sched/topology: improve topology_span_sane speed
Message-ID: <Zxuz2I1Bn0yG4MYj@swahl-home.5wahls.com>
References: <20241010155111.230674-1-steve.wahl@hpe.com>
 <xhsmh34kxv3dc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh34kxv3dc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
X-Proofpoint-ORIG-GUID: eFVrPvmGA1kCYG14Mk581D5VyKSsV5wy
X-Proofpoint-GUID: eFVrPvmGA1kCYG14Mk581D5VyKSsV5wy
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=978 spamscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410250117

On Tue, Oct 15, 2024 at 04:37:35PM +0200, Valentin Schneider wrote:
> On 10/10/24 10:51, Steve Wahl wrote:
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
> 
> This isn't the first complaint about topology_span_sane() vs big
> systems. It might be worth to disable the check once it has scanned all
> CPUs once - not necessarily at init, since some folks have their systems
> boot with only a subset of the available CPUs and online them later on.
> 
> I'd have to think more about how this behaves vs the dynamic NUMA topology
> code we got as of
> 
>   0fb3978b0aac ("sched/numa: Fix NUMA topology for systems with CPU-less nodes")
> 
> (i.e. is scanning all possible CPUs enough to guarantee no overlaps when
> having only a subset of online CPUs? I think so...)
> 
> but maybe something like so?
> ---
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9748a4c8d6685..bf95c3d4f6072 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2361,12 +2361,25 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
>  static bool topology_span_sane(struct sched_domain_topology_level *tl,
>  			      const struct cpumask *cpu_map, int cpu)
>  {
> +	static bool validated;
>  	int i = cpu + 1;
>  
> +	if (validated)
> +		return true;
> +
>  	/* NUMA levels are allowed to overlap */
>  	if (tl->flags & SDTL_OVERLAP)
>  		return true;
>  
> +	/*
> +	 * We're visiting all CPUs available in the system, no need to re-check
> +	 * things after that. Even if we end up finding overlaps here, we'll
> +	 * have issued a warning and can skip the per-CPU scan in later
> +	 * calls to this function.
> +	 */
> +	if (cpumask_equal(cpu_map, cpu_possible_mask))
> +		validated = true;
> +
>  	/*
>  	 * Non-NUMA levels cannot partially overlap - they must be either
>  	 * completely equal or completely disjoint. Otherwise we can end up

I tried adding this, surprisingly I saw no effect on the time taken,
perhaps even a small slowdown, when combined with my patch.  So at
this point I don't intend to add it to v2 of the patch.

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise

