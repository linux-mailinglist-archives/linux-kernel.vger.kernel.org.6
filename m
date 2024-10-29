Return-Path: <linux-kernel+bounces-387425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D27AB9B510F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0100A1C22CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECD1207209;
	Tue, 29 Oct 2024 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U8DYrcFq"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77A81DD539
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730223316; cv=none; b=mHyEBtvFS4lvN4CbzSu6fY/YxvsDk3OJWZJH0pR0d5Qn9D7XkYL3/jk3GYjeT09znd5nVFgJ2hKQBgWI2ggya7yac/lsqmmUFtzByj1WxINXq53sT6A9jeMWPiagfhC/dzpmnRuwFNftNB9hn3o5CymG4wNT0k0wKXmtlg8QTKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730223316; c=relaxed/simple;
	bh=SDWsetSq3T80KLWTfn7FpqWvjWF8js3WFRxV3164jI4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=U58yQ+edhyzcyGfDsIrNlQdiOg/LY+81Y0nBOL9ovQiv9Oc7f/qFktiEgUpCratgNE5MUSYcjlaRM4J2V0tSCOzpDr5/TUSZr0rT/yL3kZ6vZ5YVENDCVzOQRU5FzklC5a2CAR/2LB7yg5lfmqwJQGH5j8kDZeUOn5oKmqW4DdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U8DYrcFq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TGkZJP029040;
	Tue, 29 Oct 2024 17:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ct4LEo
	VJxdoFzJwCy5/UYYFzvNKB/Aj0pTo2DdSNCbQ=; b=U8DYrcFqFioyVV9JaLK6XO
	6DX2PlNwlcGITdBWiUtgjPy33GR+Ui7fIOt0JmYmE+0Vyhr+mkduZiJMELhi/e+/
	LjJpUTC4Lx2dlaWBFB7NMHwgFnT+CmPRQaVveIyGTroum1WCpP9l+vzQpkKV83nT
	dQwAEAFNYmyQ2STN3+WzQkW/q6YdPLKQZrSRvqlNWebMkFGKBQ8LcAn6yxG44MQx
	io86F+NyAgdtUKW9nRYmb06DZGXjD3hUjjskO9aGkPfdDQnjfC6ULgCSnYXHAIpf
	kVEtwDP4pX05/+yOqSGSeTwHM+4Zw8ubzvi6fEzUb+h2yhdisnp+NWroJENjPW2w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42js0h3qch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 17:34:56 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49THUIKR005388;
	Tue, 29 Oct 2024 17:34:56 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42js0h3qca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 17:34:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49TF6jmr018808;
	Tue, 29 Oct 2024 17:34:55 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42hc8k43g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 17:34:54 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49THYrF65112524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 17:34:53 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88E0E58056;
	Tue, 29 Oct 2024 17:34:53 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDFF85803F;
	Tue, 29 Oct 2024 17:34:52 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Oct 2024 17:34:52 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 29 Oct 2024 23:04:52 +0530
From: samir <samir@linux.ibm.com>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot
 <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel
 Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich
 <sivanich@hpe.com>,
        vishalc@linux.ibm.com, sshegde@linux.ibm.com, srikar@linux.ibm.com
Subject: Re: [PATCH] sched/topology: improve topology_span_sane speed
In-Reply-To: <20241010155111.230674-1-steve.wahl@hpe.com>
References: <20241010155111.230674-1-steve.wahl@hpe.com>
Message-ID: <d64234e1e2c537be9d490247295f7b36@linux.ibm.com>
X-Sender: samir@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xlPWy3PY0_QzFvK4OHNtr7wB6kK5P8Pn
X-Proofpoint-ORIG-GUID: pAzO7hNR5irCmyC1nBOIxYo2lT_awrY7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1011 mlxlogscore=874
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290128

On 2024-10-10 21:21, Steve Wahl wrote:
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
> @@ -2356,36 +2356,65 @@ static struct sched_domain
> *build_sched_domain(struct sched_domain_topology_leve
> 
>  /*
>   * Ensure topology masks are sane, i.e. there are no conflicts 
> (overlaps) for
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
> +	masks = kmalloc_array(num_possible_cpus(), sizeof(struct cpumask *),
> GFP_KERNEL);
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
> +			} else if ((!masks[id]) || !cpumask_equal(masks[id], 
> tl->mask(cpu))) {
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
> @@ -2417,9 +2446,6 @@ build_sched_domains(const struct cpumask
> *cpu_map, struct sched_domain_attr *att
>  		sd = NULL;
>  		for_each_sd_topology(tl) {
> 
> -			if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
> -				goto error;
> -
>  			sd = build_sched_domain(tl, cpu_map, attr, sd, i);
> 
>  			has_asym |= sd->flags & SD_ASYM_CPUCAPACITY;
> @@ -2433,6 +2459,9 @@ build_sched_domains(const struct cpumask
> *cpu_map, struct sched_domain_attr *att
>  		}
>  	}
> 
> +	if (WARN_ON(!topology_span_sane(cpu_map)))
> +		goto error;
> +
>  	/* Build the groups for the domains */
>  	for_each_cpu(i, cpu_map) {
>  		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {

Hello,

I have verified this patch on PowerPC and below are the results for 
"time ppc64_cpu —smt =off/4" mode,
Here are the 5 iteration data for “time ppc64_cpu --smt=off/4” 
command(min, max, Average, and Std Dev).

——————Without patch——————
————uname -a————
6.12.0-rc5

————lscpu————
lscpu
Architecture:             ppc64le
   Byte Order:             Little Endian
CPU(s):                   360
   On-line CPU(s) list:    0-359
NUMA:
   NUMA node(s):           4
   NUMA node0 CPU(s):      0-95
   NUMA node1 CPU(s):      96-191
   NUMA node2 CPU(s):      192-271
   NUMA node3 CPU(s):      272-359

Without Patch:
Metric	       SMT Off (s)   SMT 4 (s)
Min	      	  68.63	      37.64
Max	      	  74.92	      39.39
Average	   	  70.92	      38.48
Std Dev	    	  2.22	      0.63


——————With patch——————
————uname -a————
6.12.0-rc5-dirty

————lscpu————
lscpu
Architecture:             ppc64le
   Byte Order:             Little Endian
CPU(s):                   360
   On-line CPU(s) list:    0-359
NUMA:
   NUMA node(s):           4
   NUMA node0 CPU(s):      0-95
   NUMA node1 CPU(s):      96-191
   NUMA node2 CPU(s):      192-271
   NUMA node3 CPU(s):      272-359

With Patch:
Metric	    SMT Off (s)	    SMT 4 (s)
Min 	        68.748	     33.442
Max	        72.954	     38.042
Average	        70.309	     36.206
Std Dev	        1.41	     1.66

 From the results it’s seen that there is no significant improvement, 
however, with the patch applied, the SMT=4 state shows a decrease in 
both average time, as reflected in the lower average (36.21s vs. 38.48s) 
and higher standard deviation (1.66s vs. 0.63s) compared to the previous 
without patch apply result.

Thanks,
Samir

