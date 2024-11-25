Return-Path: <linux-kernel+bounces-421363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8B39D8A29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720E128467A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16C41B393A;
	Mon, 25 Nov 2024 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QZCvAmyv"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB47625771
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732551680; cv=none; b=stUnZJa7raAHJDVLRhD0E5gOs4n7R9vA0nfx46fmg70ghpRsE5YXRsyGtupfgcRvyhDEj4p4CgDydWwR0Pj3JrRyOJrGGQBxkfZjh5v3Cx7SGVvdUpzWwwmePpiSqTOE38wQsXHDmYx2sKF+M7138+gUOc66AOU47VDR9eU7BvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732551680; c=relaxed/simple;
	bh=f9wZWDIcqq39Eb8m2p1qcPxbvWS3hSYqdCxQA0Ilj6M=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZnVoqpztBikUHUrCRzK+GGA3+olZK6kbYUY4+HPaJTLuZc77A3MgwepY4dR0kV4xV/Jq6tMOcGvRmKQFoTkmIQucI42aAD2XdI0vxLr07IGWQpJIHM7DSfb4W5DGXUpD6hi1G7/DpY7BAiqcQuq1Kgeemi0iZQVts3NIs/cqLjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QZCvAmyv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APFZiYF012701;
	Mon, 25 Nov 2024 16:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=S4REH6
	Jl0eSCvzgQ5N53mWUjdX1LL3nXL9jcmf6VY1U=; b=QZCvAmyv+SgRfaPDoJJFgG
	PEJDTEKzzoMYs8J6QCfPofarQlNXjfFgwdxS3mxRw5nBB4/mbr80P9rv/jBr5DrK
	Ohu+difE6Wz2cctMDhFSmD3JRikHv8d+HYpG1+dJ6JsFvw9aSU1iquoVox44NTYY
	QPiBqQpYQFkquA5zbCv8a7V0uFYdhQIZrOrQoNocnGmAQ/ABgymZVAfVmqKWcJM6
	/NtlfinoMPDco6QB/QKPjrtGb5FM5ZetKmIK1WOuG/RfzrsWJt6ulCwsfkJvayny
	py8065V88ffO15QjFyQapB8QRzy3uEcuWv/3RXDeMk6KaXh2HRPZLb8EabE7x2Kg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386n9dhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 16:20:57 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4APG1QXw013320;
	Mon, 25 Nov 2024 16:20:56 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386n9dhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 16:20:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP8jGQ1012370;
	Mon, 25 Nov 2024 16:20:55 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 433scrtumw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 16:20:55 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4APGKsHI55771622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 16:20:54 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AA1558058;
	Mon, 25 Nov 2024 16:20:54 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 582295805F;
	Mon, 25 Nov 2024 16:20:53 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 Nov 2024 16:20:53 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 25 Nov 2024 21:50:53 +0530
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
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Vishal Chourasia <vishalc@linux.ibm.com>, Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>, srikar@linux.ibm.com,
        sshegde@linux.ibm.com
Subject: Re: [PATCH v2] sched/topology: improve topology_span_sane speed
In-Reply-To: <20241031200431.182443-1-steve.wahl@hpe.com>
References: <20241031200431.182443-1-steve.wahl@hpe.com>
Message-ID: <02dbeaa81619ccf86204f577c5ef7705@linux.ibm.com>
X-Sender: samir@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pb4VDs4YBfMCwLX8dHK2XM9iCnL9-GxR
X-Proofpoint-ORIG-GUID: 4bV516rdd8qPyrPD8D7rRBZWyS1r420K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=764 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411250134

On 2024-11-01 01:34, Steve Wahl wrote:
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
> should be a new mask, which can be uniquely identified ("id") by the
> lowest bit set in this mask.  Mark that we've seen a mask with this
> id, and add the CPUs in this mask to the list of those seen.
> 
> If the current mask does collide with previously seen masks, it should
> be exactly equal to a mask seen before, identified once again by the
> lowest bit the current mask has set.  It's an error if we haven't seen
> a mask with that id, or if the current mask doesn't match the one we
> get by looking up that id.
> 
> Move the topology_span_sane() check out of the existing topology level
> loop, let it do its own looping to match the needs of this algorithm.
> 
> On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
> the average time to take one processor offline is reduced from 2.18
> seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
> 34m49.765s without this change, 16m10.038s with this change in place.)
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> ---
> 
> Version 2: Adopted suggestion by K Prateek Nayak that removes an array 
> and
> simplifies the code, and eliminates the erroneous use of
> num_possible_cpus() that Peter Zijlstra noted.
> 
> Version 1 discussion:
>     
> https://lore.kernel.org/all/20241010155111.230674-1-steve.wahl@hpe.com/
> 
>  kernel/sched/topology.c | 73 +++++++++++++++++++++++++++--------------
>  1 file changed, 48 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9748a4c8d668..6a2a3e91d59e 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2356,35 +2356,58 @@ static struct sched_domain
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
> +	struct cpumask *covered, *id_seen;
> +	int cpu;
> 
> -	/* NUMA levels are allowed to overlap */
> -	if (tl->flags & SDTL_OVERLAP)
> -		return true;
> +	lockdep_assert_held(&sched_domains_mutex);
> +	covered = sched_domains_tmpmask;
> +	id_seen = sched_domains_tmpmask2;
> +
> +	for_each_sd_topology(tl) {
> +
> +		/* NUMA levels are allowed to overlap */
> +		if (tl->flags & SDTL_OVERLAP)
> +			continue;
> +
> +		cpumask_clear(covered);
> +		cpumask_clear(id_seen);
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
> +			const struct cpumask *tl_cpu_mask = tl->mask(cpu);
> +			int id;
> +
> +			/* lowest bit set in this mask is used as a unique id */
> +			id = cpumask_first(tl_cpu_mask);
> +
> +			/* if this mask doesn't collide with what we've already seen */
> +			if (!cpumask_intersects(tl_cpu_mask, covered)) {
> +				/* Really odd case when cpu != id, likely not sane */
> +				if ((cpu != id) && !cpumask_equal(tl_cpu_mask, tl->mask(id)))
> +					return false;
> +				if (cpumask_test_and_set_cpu(id, id_seen))
> +					return false;
> +				cpumask_or(covered, tl_cpu_mask, covered);
> +			} else if ((!cpumask_test_cpu(id, id_seen)) ||
> +				    !cpumask_equal(tl->mask(id), tl_cpu_mask)) {
> +				/*
> +				 * a collision with covered should have exactly matched
> +				 * a previously seen mask with the same id
> +				 */
> +				return false;
> +			}
> +		}
>  	}
> -
>  	return true;
>  }
> 
> @@ -2417,9 +2440,6 @@ build_sched_domains(const struct cpumask
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
> @@ -2433,6 +2453,9 @@ build_sched_domains(const struct cpumask
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

Hello Steve,

I have verified the above patch on PowerPC, and here are my findings:
Below are the 5 iteration data for “time ppc64_cpu --smt=off/4” 
command(min, max, Average, and Std Dev).

——lscpu—-
CPU(s):                   360
  On-line CPU(s) list:    0-359

Without Patch:
————uname -a————
6.12.0+ 

Metric        SMT Off (s)            SMT 4 (s)

Min	      71.123			37.629

Max	      75.031			40.785

Average       73.175			39.992

Std Dev	      1.619			1.191


With patch:
————uname -a————
6.12.0+ 

Metric        SMT Off (s)            SMT 4 (s)

Min		63.638			37.114

Max		73.707			40.773

Average		70.106			 38.641

Std Dev		 3.443			1.472

The logs indicate minimal improvement in the SMT 4 state with the patch. 
However, a slight improvement is observed in the SMT OFF state with the 
patch, as reflected in all three metrics: Min, Max, and Average.

SMT 4 State:
	•	Across all metrics (Min, Max, and Average), there is negligible 
improvement with the patch.
	•	The differences are within the margin of measurement variability, as 
reflected in the similar Std Dev values (~1.1–1.4).
SMT Off State:
	•	A noticeable improvement is observed in the Min, Max, and Average 
values with the patch:
	◦	Min: Improved by ~10.5% (from 71.123 to 63.638 seconds).
	◦	Max: Improved by ~1.8% (from 75.031 to 73.707 seconds).
	◦	Average: Improved by ~4.2% (from 73.175 to 70.106 seconds).
	•	The Std Dev increased significantly (from 1.619 to 3.443).

Thanks,
Samir

