Return-Path: <linux-kernel+bounces-366020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 155F299EFBF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FAF28105C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217141D5152;
	Tue, 15 Oct 2024 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LoQWYvz/"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E121C4A3C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003089; cv=none; b=QidErlv4rY32T6O5vofVU1nYZuatWNCLe6Rgc30/xywbt/0I818rVSzo72Ukz4/jxewVSla0JKqc/L0+JBE9cr1W8lPLqcoqKZuvZpOzwcLVzNJ43kLfiYDVoh/NBpq8w3ND8PQaSgXHzDTCu+c8jK6BLvbn3rAjSuKnkbZoKb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003089; c=relaxed/simple;
	bh=GFrSe+oivlgQHPf0515s3NEqoSyC1MADkYV2KOlT5as=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lrydFHgLYlGDWrOtnE21jUSPsdjYbjLd64kGZDw4HD7yyascT6z0qvkJ7nS7kN8MNNSzIPBW31TrykSRoRK9sYfUNH2p5t90E/U/1hwdkS0Vd1eTXpCq2e1G0J85tVBxWDWvS+owt8HAJ/rmEvmBgllOVD6eZ/hIDcYCAxgmOpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LoQWYvz/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FCOYZM011396;
	Tue, 15 Oct 2024 14:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Cua8iE
	SqFbhX1nT7WP+xVsZCpyNiVEsClSIG0Bq+HNk=; b=LoQWYvz/bX/3MAo4swf5pm
	RSnxqFmf3b7zXr1uZh40HOsmKRit99X0Yd0ZQWhUdFUgQ9l2o7nBxm+0HE+Wsaev
	hnBkS6me+bA2Wn7+zQprFODmDvrTYSvRevwtCSgaHvCUj5yBCofGCM6XUgLNwOW2
	/OSGeo++BK/gL3dS6khucW1VYXzApaOdYhQhicDi1QzhU5L/3HqvjpID4ZDJKMS0
	68PH/6XQPp6H+kH0Lj/d2j/LQDUpqhE3x+3SmDGkQKCEnFahnf+Gt1Y41eCGpCGN
	62Yuk8DEafp2YPeoj1/WVgiBBXnZIhOvnPx07hoxkje5gy9xOslTT0sz7EGLVNVw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429rcerrdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 14:37:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FEaioE022745;
	Tue, 15 Oct 2024 14:37:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429rcerrdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 14:37:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FDjote027452;
	Tue, 15 Oct 2024 14:37:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4283txme90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 14:37:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FEbVMX56820122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 14:37:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 008E620043;
	Tue, 15 Oct 2024 14:37:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34A652004D;
	Tue, 15 Oct 2024 14:37:28 +0000 (GMT)
Received: from [9.124.220.187] (unknown [9.124.220.187])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 14:37:27 +0000 (GMT)
Message-ID: <c1462c96-2b42-4a57-8560-60066d334248@linux.ibm.com>
Date: Tue, 15 Oct 2024 20:07:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] sched: Add Lazy preemption model
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de,
        bigeasy@linutronix.de, tglx@linutronix.de, mingo@kernel.org
References: <20241007074609.447006177@infradead.org>
 <20241007075055.331243614@infradead.org>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20241007075055.331243614@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wbuO1QjY457Z0f18SbdLl34KSdmXjo7H
X-Proofpoint-ORIG-GUID: 7vJprb-a7DL1PkBxsX0PPu34VEpJP2rK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=773 clxscore=1015 phishscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150097



On 10/7/24 13:16, Peter Zijlstra wrote:
> Change fair to use resched_curr_lazy(), which, when the lazy
> preemption model is selected, will set TIF_NEED_RESCHED_LAZY.
> 
> This LAZY bit will be promoted to the full NEED_RESCHED bit on tick.
> As such, the average delay between setting LAZY and actually
> rescheduling will be TICK_NSEC/2.

I didn't understand the math here. How?

> 
> In short, Lazy preemption will delay preemption for fair class but
> will function as Full preemption for all the other classes, most
> notably the realtime (RR/FIFO/DEADLINE) classes.
> 
> The goal is to bridge the performance gap with Voluntary, such that we
> might eventually remove that option entirely.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   include/linux/preempt.h |    8 ++++-
>   kernel/Kconfig.preempt  |   15 +++++++++
>   kernel/sched/core.c     |   76 ++++++++++++++++++++++++++++++++++++++++++++++--
>   kernel/sched/debug.c    |    5 +--
>   kernel/sched/fair.c     |    6 +--
>   kernel/sched/sched.h    |    1
>   6 files changed, 103 insertions(+), 8 deletions(-)
> 
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -486,6 +486,7 @@ DEFINE_LOCK_GUARD_0(migrate, migrate_dis
>   extern bool preempt_model_none(void);
>   extern bool preempt_model_voluntary(void);
>   extern bool preempt_model_full(void);
> +extern bool preempt_model_lazy(void);
>   
>   #else
>   
> @@ -502,6 +503,11 @@ static inline bool preempt_model_full(vo
>   	return IS_ENABLED(CONFIG_PREEMPT);
>   }
>   
> +static inline bool preempt_model_lazy(void)
> +{
> +	return IS_ENABLED(CONFIG_PREEMPT_LAZY);
> +}
> +
>   #endif
>   
>   static inline bool preempt_model_rt(void)
> @@ -519,7 +525,7 @@ static inline bool preempt_model_rt(void
>    */
>   static inline bool preempt_model_preemptible(void)
>   {
> -	return preempt_model_full() || preempt_model_rt();
> +	return preempt_model_full() || preempt_model_lazy() || preempt_model_rt();
>   }
>   
>   #endif /* __LINUX_PREEMPT_H */
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -11,6 +11,9 @@ config PREEMPT_BUILD
>   	select PREEMPTION
>   	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
>   
> +config ARCH_HAS_PREEMPT_LAZY
> +	bool
> +
>   choice
>   	prompt "Preemption Model"
>   	default PREEMPT_NONE
> @@ -67,6 +70,18 @@ config PREEMPT
>   	  embedded system with latency requirements in the milliseconds
>   	  range.
>   
> +config PREEMPT_LAZY
> +	bool "Scheduler controlled preemption model"
> +	depends on !ARCH_NO_PREEMPT
> +	depends on ARCH_HAS_PREEMPT_LAZY
> +	select PREEMPT_BUILD
> +	help
> +	  This option provides a scheduler driven preemption model that
> +	  is fundamentally similar to full preemption, but is less
> +	  eager to preempt SCHED_NORMAL tasks in an attempt to
> +	  reduce lock holder preemption and recover some of the performance
> +	  gains seen from using Voluntary preemption.
> +
>   config PREEMPT_RT
>   	bool "Fully Preemptible Kernel (Real-Time)"
>   	depends on EXPERT && ARCH_SUPPORTS_RT
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1078,6 +1078,9 @@ static void __resched_curr(struct rq *rq
>   
>   	lockdep_assert_rq_held(rq);
>   
> +	if (is_idle_task(curr) && tif == TIF_NEED_RESCHED_LAZY)
> +		tif = TIF_NEED_RESCHED;
> +
>   	if (cti->flags & ((1 << tif) | _TIF_NEED_RESCHED))
>   		return;
>   
> @@ -1103,6 +1106,32 @@ void resched_curr(struct rq *rq)
>   	__resched_curr(rq, TIF_NEED_RESCHED);
>   }
>   
> +#ifdef CONFIG_PREEMPT_DYNAMIC
> +static DEFINE_STATIC_KEY_FALSE(sk_dynamic_preempt_lazy);
> +static __always_inline bool dynamic_preempt_lazy(void)
> +{
> +	return static_branch_unlikely(&sk_dynamic_preempt_lazy);
> +}
> +#else
> +static __always_inline bool dynamic_preempt_lazy(void)
> +{
> +	return IS_ENABLED(PREEMPT_LAZY);


This should be CONFIG_PREEMPT_LAZY no?

> +}
> +#endif
> +
> +static __always_inline int tif_need_resched_lazy(void)
> +{
> +	if (dynamic_preempt_lazy())
> +		return TIF_NEED_RESCHED_LAZY;
> +
> +	return TIF_NEED_RESCHED;
> +}
> +
> +void resched_curr_lazy(struct rq *rq)
> +{
> +	__resched_curr(rq, tif_need_resched_lazy());
> +}
> +
...

