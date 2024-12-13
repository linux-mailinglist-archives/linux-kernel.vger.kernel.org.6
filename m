Return-Path: <linux-kernel+bounces-445025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 077889F101E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40EB188E451
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0A61E1A33;
	Fri, 13 Dec 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aJglMFZj"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD411E105B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101759; cv=none; b=L9iPOnmGEse78vLP2ZO6FVdKVariVbvCxyhECXhoLzu3kEcfPf3JK2GVQoovS7N+JbuKS2SEKZNmhcJxAxFUKmdajedBiotIuwJezAVaYxj7tnkMbLRT2A1woBBgmuo54YHEHryqhFTxbztmLxDLP28Z1e6L+3xEWkaYndgLOR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101759; c=relaxed/simple;
	bh=q91KS/0q5q9k3lhPdBYWdeYnReE3m9vfNKZLQ2fe5Bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZwgRXyL8VFYG3d2H6HZ4qU1r54KewH7J/70wWt3uQISBL3k9QvtInsrE9YCS1FRUDDXf+LwlSnaMRBbUW6zLNd9GpOm8HrBrjy/s71jjOvG6eo8Xo83f/WvMTKhcP/gPNh/BdxO8BDoCVl35gRis1UHGIEqH9zdusrX/9jbXAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aJglMFZj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDEItnQ015238;
	Fri, 13 Dec 2024 14:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MDP5Nm
	HKsAXFD9N2yMDtd3MBsqjN8bvK4ztkk7Fekgw=; b=aJglMFZjh/kfnTDS+agfFz
	6ukKp6jKWmcu5JNm0KR03uGomQGPY5bAiiwPJIXm2yqVwCJG5ZL59+W+ZwRcIqTR
	gmjU+JJPyuhxLkWtajGCPXQgoXuVGa1DA60evjpd3zew3PEM8bdQWtb1+SD5mZ+B
	p8w54E8erjuz55FbwazjovSnYKAFIitkoJdEYomDgdxrNqslXyfgLYBUAquO2A7W
	9noHHn0IQOSRmuxuCTdIH1lKxoum6Mpahs4S1Wx40xNRzcVe23SX7mpUXbRg41eG
	Gb9er+ld5T/aLCATPmOB718FPoXNfahtmL4n3ibWteoeQ9QJE0sTF2c0eHNPULkQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gddmawdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:55:21 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BDEiipb006826;
	Fri, 13 Dec 2024 14:55:21 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gddmawd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:55:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDBRAgL029309;
	Fri, 13 Dec 2024 14:55:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43gcprtjh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:55:20 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BDEtISu21103042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 14:55:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A8492004D;
	Fri, 13 Dec 2024 14:55:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C672B2004B;
	Fri, 13 Dec 2024 14:55:13 +0000 (GMT)
Received: from [9.124.213.1] (unknown [9.124.213.1])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 14:55:13 +0000 (GMT)
Message-ID: <ddbb4070-e7bd-485a-bcd6-d6b9192656d6@linux.ibm.com>
Date: Fri, 13 Dec 2024 20:25:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] sched/fair: Do not compute NUMA Balancing stats
 unnecessarily during lb
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
 <20241211185552.4553-7-kprateek.nayak@amd.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20241211185552.4553-7-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G9toq4KhWHuJL4D6JK-VsOieYsJDuj8N
X-Proofpoint-GUID: eqyanjVg8eos1ZAeWAfGtkpKw5qQECyj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130103



On 12/12/24 00:25, K Prateek Nayak wrote:
> Aggregate nr_numa_running and nr_preferred_running when load balancing
> at NUMA domains only. While at it, also move the aggregation below the
> idle_cpu() check since an idle CPU cannot have any preferred tasks.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>   kernel/sched/fair.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2c4ebfc82917..ec2a79c8d0e7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10340,7 +10340,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>   				      bool *sg_overloaded,
>   				      bool *sg_overutilized)
>   {
> -	int i, nr_running, local_group;
> +	int i, nr_running, local_group, sd_flags = env->sd->flags;
>   
>   	memset(sgs, 0, sizeof(*sgs));
>   
> @@ -10364,10 +10364,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>   		if (cpu_overutilized(i))
>   			*sg_overutilized = 1;
>   
> -#ifdef CONFIG_NUMA_BALANCING
> -		sgs->nr_numa_running += rq->nr_numa_running;
> -		sgs->nr_preferred_running += rq->nr_preferred_running;
> -#endif
>   		/*
>   		 * No need to call idle_cpu() if nr_running is not 0
>   		 */
> @@ -10377,10 +10373,17 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>   			continue;
>   		}
>   
> +#ifdef CONFIG_NUMA_BALANCING
> +		/* Only fbq_classify_group() uses this to classify NUMA groups */
> +		if (sd_flags & SD_NUMA) {
> +			sgs->nr_numa_running += rq->nr_numa_running;
> +			sgs->nr_preferred_running += rq->nr_preferred_running;
> +		}
> +#endif
>   		if (local_group)
>   			continue;
>   
> -		if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
> +		if (sd_flags & SD_ASYM_CPUCAPACITY) {
>   			/* Check for a misfit task on the cpu */
>   			if (sgs->group_misfit_task_load < rq->misfit_task_load) {
>   				sgs->group_misfit_task_load = rq->misfit_task_load;

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

