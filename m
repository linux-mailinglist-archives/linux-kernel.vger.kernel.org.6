Return-Path: <linux-kernel+bounces-558248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 074C0A5E371
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0EA18977AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432E31D8A0A;
	Wed, 12 Mar 2025 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aPtX3X/w"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28BE1D5173
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802850; cv=none; b=iRc5eL/oaBJZm3IOjUazsUxOvXcjdmIzXq+9EeCoGav65lwrLcMduuE9PGHBsWsTDg7Dr1umLdqvX32DgXCWx3rSH2lo94xckCmdVehO/ufN+SVDYBJe8pWQp5LbPodX4D5sjwkRqkDrbTT/o4jwCA8ogFhzQYPt2sMBk+4Z0Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802850; c=relaxed/simple;
	bh=jNWQhmWvUQwsPmYzqUENU/t19l+L4CHbFjYd5Qalhak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGrv1nHkLUfVyO4u90WSCaQc5/WSLLSHjIfWOgPl5D/demDZJdF1wqA0vRdiT/6wKNCEB1KJdb6aKLazsdaBnyrxfXRYCwDK92QUHdowB1EKMXHGplthhbwNrSrZS2cvTaGvkjLCUT4OZIoXqNAMV6wLS10o50Rye2EBQyeTDjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aPtX3X/w; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CCdmBs028627;
	Wed, 12 Mar 2025 18:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=6/3eAEikSdPmZMH4s/wxtkNoG+URl5DwRd2UlPziTQo=; b=aPtX3X/w2nK2
	UJLWzDgYe/ZX5A08G0EoC4UbekVNM7pBgtFVrNymYx99xdoO4ZTGqKoUTvCMRShu
	ro88Oe+Jf2PrheBishuhjOmWwFafGB8II80QDFJ/u7ns0J8a9EKqIseiS6z9gztY
	i1OB1Br+2tjAK8x01cwJ6Dt+9tF2EwoUd/Ki5PFyXE0izh8MHtFrRF/HsRPD5Ufd
	X9NugCtm79Wf3Ebd5Q1m+4bzgTIOzvH3zmPH2zAzWyAETAvXUxcE3mHPU9V3kXIu
	2A5x7ye6EZQ1BJ1hxZSGXqQ1jJgoaviQCGNEEGEDMJmIJtKbqHRpx32c+rGMgFXB
	CD7tFmcrjA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45b2n9c52p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 18:07:11 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52CHwGq0009737;
	Wed, 12 Mar 2025 18:07:10 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45b2n9c52m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 18:07:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52CHFOfb026048;
	Wed, 12 Mar 2025 18:07:09 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspdgx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 18:07:09 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52CI78JQ20972104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 18:07:08 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F21F58056;
	Wed, 12 Mar 2025 18:07:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6551658052;
	Wed, 12 Mar 2025 18:07:04 +0000 (GMT)
Received: from [9.43.79.132] (unknown [9.43.79.132])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Mar 2025 18:07:04 +0000 (GMT)
Message-ID: <f3de3cc0-e519-42f7-aa0d-261c5f20ce59@linux.ibm.com>
Date: Wed, 12 Mar 2025 23:37:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] sched: Fix incorrect runnable time calculation in
 sched_stat_wait tracepoint
To: =?UTF-8?B?eGlhbmhlLnpob3Uo5ZGo5pi+6LWrKQ==?= <xianhe.zhou@transsion.com>
Cc: "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "incent.guittot@linaro.org" <incent.guittot@linaro.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de"
 <mgorman@suse.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <98cac8ca355d4aad963deb52a427fa2c@transsion.com>
Content-Language: en-US
Reply-To: 98cac8ca355d4aad963deb52a427fa2c@transsion.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <98cac8ca355d4aad963deb52a427fa2c@transsion.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hU92oMIp4DMQC3OGJe9PT_hri2DdyiV_
X-Proofpoint-ORIG-GUID: UlDW10hDg2UtK-OOmBXWAmcVeel5Q1MN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120124

On 06/03/25 08:09, xianhe.zhou(周显赫) wrote:
> From b07df3ed3fd2186a698ef87ad366523ec7c7fccb Mon Sep 17 00:00:00 2001
> From: "xianhe.zhou" <xianhe.zhou@transsion.com>
> Date: Thu, 20 Feb 2025 22:01:26 +0800
> Subject: [PATCH] sched: Fix incorrect runnable time calculation in
>  sched_stat_wait tracepoint
> 
> The sched_stat_wait tracepoint is intended to record the runnable
> time of a task. However, due to incorrect timestamp handling, two major
> issues arise:
> 
> 1. The tracepoint may incorrectly record consecutive start timestamps
>    or consecutive end timestamps, rather than properly pairing them.
>    This leads to incorrect runnable time calculations.
> 2. The recorded time may include temporary dequeuing and enqueuing
>    events, such as when modifying a task's nice value while it is running.
> 
> This patch ensures that timestamps are properly paired and excludes
> temporary dequeuing events to prevent incorrect measurements.
> 
> Testing:
> This issue was tested on an Android 14 device. The following are the
> trace results before and after applying the patch:
> 
> Before the fix (incorrect values):
> 
> sched_stat_wait: comm=OverlayEngine_0 pid=1533 delay=352418315839 [ns]
> sched_stat_wait: comm=OverlayEngine_0 pid=1533 delay=352409961840 [ns]
> sched_stat_wait: comm=OverlayEngine_0 pid=1533 delay=352393317455 [ns]
> sched_stat_wait: comm=binder:1148_3 pid=2102 delay=352380493377 [ns]
> sched_stat_wait: comm=OverlayEngine_0 pid=1533 delay=352360033377 [ns]
> 
> Clearly, these runnable time values, in the hundreds of seconds,
> are incorrect.
> 
> After the fix (corrected values):
> 
> sched_stat_wait: comm=kworker/7:1 pid=13682 delay=63516923 [ns]
> sched_stat_wait: comm=SuperA_R[136] pid=15074 delay=51324385 [ns]
> sched_stat_wait: comm=SuperA_R[136] pid=15080 delay=50280539 [ns]
> sched_stat_wait: comm=SuperA_R[136] pid=15071 delay=48995692 [ns]
> sched_stat_wait: comm=SuperA_R[34] pid=14951 delay=41876308 [ns]
> 
> After the fix, the recorded runnable times are within expected ranges.

As per my understanding, when a temporary dequeue occurs, the delay value
printed should be smaller compared to when these temporary events are
skipped, as the delay is then computed between the final dequeue and the
original start time. 

I think I am missing something. Can you take an example and explain?

Thanks,
Madadi Vineeth Reddy

> 
> Fixes: 768d0c27226e ("sched: Add wait, sleep and iowait accounting tracepoints")
> Signed-off-by: xianhe.zhou <xianhe.zhou@transsion.com>
> ---
>  kernel/sched/fair.c  | 13 +++++++------
>  kernel/sched/rt.c    | 15 ++++++++++++---
>  kernel/sched/stats.c |  7 ++++++-
>  3 files changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1c0ef435a7aa..37a315b3906b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1331,11 +1331,12 @@ update_stats_enqueue_fair(struct cfs_rq *cfs_rq, struct sched_entity *se, int fl
>  	if (!schedstat_enabled())
>  		return;
>  
> -	/*
> -	 * Are we enqueueing a waiting task? (for current tasks
> -	 * a dequeue/enqueue event is a NOP)
> +    /*
> +     * Are we enqueueing a waiting task? And it is not
> +     * a temporary enqueue?(for current tasks a
> +     * dequeue/enqueue event is a NOP)
>  	 */
> -	if (se != cfs_rq->curr)
> +	if (se != cfs_rq->curr && !(flags & ENQUEUE_RESTORE))
>  		update_stats_wait_start_fair(cfs_rq, se);
>  
>  	if (flags & ENQUEUE_WAKEUP)
> @@ -1351,9 +1352,9 @@ update_stats_dequeue_fair(struct cfs_rq *cfs_rq, struct sched_entity *se, int fl
>  
>  	/*
>  	 * Mark the end of the wait period if dequeueing a
> -	 * waiting task:
> +	 * waiting task and it is not a temporary dequeue:
>  	 */
> -	if (se != cfs_rq->curr)
> +	if (se != cfs_rq->curr && !(flags & DEQUEUE_SAVE))
>  		update_stats_wait_end_fair(cfs_rq, se);
>  
>  	if ((flags & DEQUEUE_SLEEP) && entity_is_task(se)) {
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 4b8e33c615b1..991251feeaf6 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1310,9 +1310,17 @@ static inline void
>  update_stats_enqueue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
>  			int flags)
>  {
> +	struct task_struct *p = NULL;
> +
>  	if (!schedstat_enabled())
>  		return;
>  
> +	if (rt_entity_is_task(rt_se))
> +		p = rt_task_of(rt_se);
> +
> +	if (p != rq_of_rt_rq(rt_rq)->curr && !(flags & ENQUEUE_RESTORE))
> +		update_stats_wait_start_rt(rt_rq, rt_se);
> +
>  	if (flags & ENQUEUE_WAKEUP)
>  		update_stats_enqueue_sleeper_rt(rt_rq, rt_se);
>  }
> @@ -1348,6 +1356,10 @@ update_stats_dequeue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
>  	if (rt_entity_is_task(rt_se))
>  		p = rt_task_of(rt_se);
>  
> +	if (p != rq_of_rt_rq(rt_rq)->curr && !(flags & DEQUEUE_SAVE)) {
> +		update_stats_wait_end_rt(rt_rq, rt_se);
> +	}
> +
>  	if ((flags & DEQUEUE_SLEEP) && p) {
>  		unsigned int state;
>  
> @@ -1474,9 +1486,6 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
>  	if (flags & ENQUEUE_WAKEUP)
>  		rt_se->timeout = 0;
>  
> -	check_schedstat_required();
> -	update_stats_wait_start_rt(rt_rq_of_se(rt_se), rt_se);
> -
>  	enqueue_rt_entity(rt_se, flags);
>  
>  	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
> diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
> index 4346fd81c31f..367f4bb1c759 100644
> --- a/kernel/sched/stats.c
> +++ b/kernel/sched/stats.c
> @@ -20,8 +20,13 @@ void __update_stats_wait_start(struct rq *rq, struct task_struct *p,
>  void __update_stats_wait_end(struct rq *rq, struct task_struct *p,
>  			     struct sched_statistics *stats)
>  {
> -	u64 delta = rq_clock(rq) - schedstat_val(stats->wait_start);
> +	u64 delta;
> +	u64 wait_start = schedstat_val(stats->wait_start);
>  
> +	if (!wait_start)
> +		return;
> +
> +	delta = rq_clock(rq) - wait_start;
>  	if (p) {
>  		if (task_on_rq_migrating(p)) {
>  			/*


