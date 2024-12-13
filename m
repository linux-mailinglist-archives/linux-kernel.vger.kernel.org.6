Return-Path: <linux-kernel+bounces-445038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F449F1037
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D7F16BD0E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2546A1E2009;
	Fri, 13 Dec 2024 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PI+wXOka"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68C91DFD9A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102182; cv=none; b=qGhtnM3ONneigzTm2m0yWsQnPTEbVY6JPP86WJRY9slGM8uKqhUdYqTnknXsuY6rlZzHsBLpw+E9/Dm67vw4aDG4tnAIfCJcM/ewnrzH0zD3vmXBdfZ1IpI0ShYo3+jfd1/kH5l9Hyu+XSZZlgGZ+YZ3zIfAi9D6CfpIcQYFSX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102182; c=relaxed/simple;
	bh=yTXkG9xsORyjLBEoc5qhvGM9iruX9VHdVXkMcbsWiTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPXPaDlcx0D4nRv+GlCjMz0qBpnUgf8aiBnyulUQzHezkNcK7uEvtWBE4+yvd5NC72TjnUBG+VI4hFfjjkt/lPKs99whD5GCy0Miy223IWDkGFN8PKuVBxAps5MyNdDVVgln/Os4OFW9H9hhry9lc8fK30Z87oWASoQteaMQbw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PI+wXOka; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDEIt7M015193;
	Fri, 13 Dec 2024 15:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7JRJ2A
	J6cj+ZwQl0vIZEIumux8D4wSZd5RQvS2sDKtw=; b=PI+wXOka5fTqls4H+7nLsn
	TIl1WKIeU517xclOaSb8rNWBDaAq6n+VMwrdF925BaAhUYDswVMrKXDdG2cByIT+
	7Qx6zN6HKbBP1iVJVeUDTYsmQKOGNQa7KJU1rpqsyMUZjUncSx9Yjo+awpYQb8iG
	XjIx7Pd4NJ8bdErDPFAQuYczHuhbixYM7LDvGPAQhTwg+SLh91wjMz+suGia619x
	PX4V2wwTvWRjFBxrtYPwrXX7qs/98w8YCz1itguxKA837dKW5iViYhSP9iE7n3dx
	oz8hhxbcioXmllvX3qkO6nWh519g/33UejqRV1/5lOWtPUpvne8DTPgILDqsj43A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gddmay38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 15:02:31 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BDExsPP014500;
	Fri, 13 Dec 2024 15:02:30 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gddmay32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 15:02:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDCcdgC016930;
	Fri, 13 Dec 2024 15:02:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12ypkkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 15:02:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BDF2RnS22217136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 15:02:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11BCA2004B;
	Fri, 13 Dec 2024 15:02:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 421FF20040;
	Fri, 13 Dec 2024 15:02:22 +0000 (GMT)
Received: from [9.124.213.1] (unknown [9.124.213.1])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 15:02:22 +0000 (GMT)
Message-ID: <de1c97e0-9dd7-4e7f-b6f8-ce3f856c96f3@linux.ibm.com>
Date: Fri, 13 Dec 2024 20:32:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 8/8] sched/fair: Uncache asym_prefer_cpu and find it
 during update_sd_lb_stats()
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20241211185552.4553-1-kprateek.nayak@amd.com>
 <20241211185552.4553-9-kprateek.nayak@amd.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20241211185552.4553-9-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uqAz7kyaEwOAwE8QbJjZr5QSs_htFafM
X-Proofpoint-GUID: TpWDiPfjuScJS2E29md0kEoCEpWeiLll
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130106



On 12/12/24 00:25, K Prateek Nayak wrote:
> On AMD processors supporting dynamic preferred core ranking, the
> asym_prefer_cpu cached in sched_group can change dynamically. Since
> asym_prefer_cpu is cached when the sched domain hierarchy is built,
> updating the cached value across the system would require rebuilding
> the sched domain which is prohibitively expensive.
> 
> All the asym_prefer_cpu comparisons in the load balancing path are only
> carried out post the sched group stats have been updated after iterating
> all the CPUs in the group. Uncache the asym_prefer_cpu and compute it
> while sched group statistics are being updated as a part of sg_lb_stats.
> 
> Fixes: f3a052391822 ("cpufreq: amd-pstate: Enable amd-pstate preferred core support")
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>   kernel/sched/fair.c     | 21 +++++++++++++++++++--
>   kernel/sched/sched.h    |  1 -
>   kernel/sched/topology.c | 15 +--------------
>   3 files changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3f36805ecdca..166b8e831064 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9911,6 +9911,8 @@ struct sg_lb_stats {
>   	unsigned int sum_nr_running;		/* Nr of all tasks running in the group */
>   	unsigned int sum_h_nr_running;		/* Nr of CFS tasks running in the group */
>   	unsigned int idle_cpus;                 /* Nr of idle CPUs         in the group */
> +	unsigned int asym_prefer_cpu;		/* CPU with highest asym priority */
> +	int highest_asym_prio;			/* Asym priority of asym_prefer_cpu */

Its better to move this after group_asym_packing field, so all related 
fields are together.

>   	unsigned int group_weight;
>   	enum group_type group_type;
>   	unsigned int group_asym_packing;	/* Tasks should be moved to preferred CPU */
> @@ -10243,7 +10245,7 @@ sched_group_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group
>   	    (sgs->group_weight - sgs->idle_cpus != 1))
>   		return false;
>   
> -	return sched_asym(env->sd, env->dst_cpu, group->asym_prefer_cpu);
> +	return sched_asym(env->sd, env->dst_cpu, sgs->asym_prefer_cpu);
>   }
>   
>   /* One group has more than one SMT CPU while the other group does not */
> @@ -10324,6 +10326,17 @@ sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
>   	return check_cpu_capacity(rq, sd);
>   }
>   
> +static inline void
> +update_sg_pick_asym_prefer(struct sg_lb_stats *sgs, int cpu)
> +{
> +	int asym_prio = arch_asym_cpu_priority(cpu);
> +
> +	if (asym_prio > sgs->highest_asym_prio) {
> +		sgs->asym_prefer_cpu = cpu;
> +		sgs->highest_asym_prio = asym_prio;
> +	}
> +}
> +
>   /**
>    * update_sg_lb_stats - Update sched_group's statistics for load balancing.
>    * @env: The load balancing environment.
> @@ -10345,6 +10358,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>   	memset(sgs, 0, sizeof(*sgs));
>   
>   	local_group = group == sds->local;
> +	sgs->highest_asym_prio = INT_MIN;
>   
>   	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
>   		struct rq *rq = cpu_rq(i);
> @@ -10358,6 +10372,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>   		nr_running = rq->nr_running;
>   		sgs->sum_nr_running += nr_running;
>   
> +		if (sd_flags & SD_ASYM_PACKING)
> +			update_sg_pick_asym_prefer(sgs, i);
> +
>   		if (cpu_overutilized(i))
>   			*sg_overutilized = 1;
>   
> @@ -10479,7 +10496,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>   
>   	case group_asym_packing:
>   		/* Prefer to move from lowest priority CPU's work */
> -		return sched_asym_prefer(sds->busiest->asym_prefer_cpu, sg->asym_prefer_cpu);
> +		return sched_asym_prefer(busiest->asym_prefer_cpu, sgs->asym_prefer_cpu);
>   
>   	case group_misfit_task:
>   		/*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index aef716c41edb..a3f0d326bd11 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2047,7 +2047,6 @@ struct sched_group {
>   	unsigned int		group_weight;
>   	unsigned int		cores;
>   	struct sched_group_capacity *sgc;
> -	int			asym_prefer_cpu;	/* CPU of highest priority in group */
>   	int			flags;
>   
>   	/*
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9c405f0e7b26..20aa087710f0 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1302,7 +1302,7 @@ static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
>   	WARN_ON(!sg);
>   
>   	do {
> -		int cpu, cores = 0, max_cpu = -1;
> +		int cpu, cores = 0;
>   
>   		sg->group_weight = cpumask_weight(sched_group_span(sg));
>   
> @@ -1314,19 +1314,6 @@ static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
>   #endif
>   		}
>   		sg->cores = cores;
> -
> -		if (!(sd->flags & SD_ASYM_PACKING))
> -			goto next;
> -
> -		for_each_cpu(cpu, sched_group_span(sg)) {
> -			if (max_cpu < 0)
> -				max_cpu = cpu;
> -			else if (sched_asym_prefer(cpu, max_cpu))
> -				max_cpu = cpu;
> -		}
> -		sg->asym_prefer_cpu = max_cpu;
> -
> -next:
>   		sg = sg->next;
>   	} while (sg != sd->groups);
>   

Tried minimal testing of ASYM_PACKING behavior on Power10 Shared VM. It 
is working as expected with the patch as well. (functionality wise, 
performance isn't tested)

