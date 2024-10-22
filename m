Return-Path: <linux-kernel+bounces-376639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B769AB446
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554E2284A95
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377C81BBBCA;
	Tue, 22 Oct 2024 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I7dHjWcx"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C85A155A21
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729615527; cv=none; b=BJEvzcZ7h8jise85493i7VhYNRhPpkjV7qzHT7882QOARweCV/yszQvoHk9+w64ez49lDreEB+1jTmCptgpxcxEu9ydzIedgtHG68bCjAteIHeWQeR6UBYYRLTtKJxL5s6WygNcS+I2aA8/uTQqLPQGIflYbacGjQFk64TbO7v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729615527; c=relaxed/simple;
	bh=dB9gEKRPH3B0vA07FtET3y15CDR7nc9Tme3VLJt2dsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qh6J38wKRmqRQNPqC6nuUCTgE2yKsmkB5NfZd92cXRD7uBQD/b2nBvne+BTM5SBMM8AZYmB8GoINP6Up+1b81+ZUayt7GZKNQ5/s5LcXQP7S2dMyV3UTmR1+i2cDltvWEJRJeCK6gxhGzwfveUY7eBtqlJEb9qxDGNu1k79Czp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I7dHjWcx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MDmroH018737;
	Tue, 22 Oct 2024 16:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=E4fyU1
	CX0MJzLrvosirnpOQnOOHSOp0UEmQUeOQOlHM=; b=I7dHjWcxBcUqznFFTH5cu7
	4FMu3sLymqqxlPIM0WQtzsU53ukEBvF27BQUT/sODq/GPuiidD/nXoYlFFFGay6w
	tNY6McA/yRTS6r6R560vOOZtZ2wmZJx2Onlmx2XF+zRX2bBSeaxFYaGRIX6f/PzY
	oeG6j5YR9VLH+e1g0YZUjrz2V+XOwPJBes1/68IMKQiib0/LofVX/YoTrfs3Eh1G
	oXHUB/s3Bk2mCkk75xE1XuFfgGiAHfLPwqMrPKtAN8JnoaUP/sbZIqOroG2Q2uT1
	AnSHtaWrAhu15y5r5Tp/bY+K1QBBCYcMeooebpkdaa7ol53amknqQk7neVRHZMQw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5gcqqp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 16:44:49 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49MGimB3010646;
	Tue, 22 Oct 2024 16:44:48 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5gcqqp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 16:44:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49MCm6A9026491;
	Tue, 22 Oct 2024 16:44:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42cq3sc996-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 16:44:47 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49MGijS353936454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 16:44:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD3AB20043;
	Tue, 22 Oct 2024 16:44:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74A6120040;
	Tue, 22 Oct 2024 16:44:42 +0000 (GMT)
Received: from [9.39.26.176] (unknown [9.39.26.176])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Oct 2024 16:44:42 +0000 (GMT)
Message-ID: <e334aff9-248c-4a00-98e1-7bcb7cdd5e90@linux.ibm.com>
Date: Tue, 22 Oct 2024 22:14:41 +0530
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
X-Proofpoint-GUID: EmN3Evc9n63VGF8nC0jLXFJulgjE0reH
X-Proofpoint-ORIG-GUID: LQU2KVA6IDljnyGTW3SX3qoed5OvgHpc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=844 clxscore=1015 suspectscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220105



On 10/7/24 13:16, Peter Zijlstra wrote:
> Change fair to use resched_curr_lazy(), which, when the lazy
> preemption model is selected, will set TIF_NEED_RESCHED_LAZY.
> 
> This LAZY bit will be promoted to the full NEED_RESCHED bit on tick.
> As such, the average delay between setting LAZY and actually
> rescheduling will be TICK_NSEC/2.
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

I had to make it CONFIG_PREEMPT_LAZY for lazy preemption to work
on systems where CONFIG_PREEMPT_DYNAMIC=n.

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
>   void resched_cpu(int cpu)
>   {
>   	struct rq *rq = cpu_rq(cpu);
> @@ -5598,6 +5627,10 @@ void sched_tick(void)
>   	update_rq_clock(rq);
>   	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
>   	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
> +
> +	if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
> +		resched_curr(rq);
> +
>   	curr->sched_class->task_tick(rq, curr, 0);
>   	if (sched_feat(LATENCY_WARN))
>   		resched_latency = cpu_resched_latency(rq);
> @@ -7334,6 +7367,7 @@ EXPORT_SYMBOL(__cond_resched_rwlock_writ
>    *   preempt_schedule           <- NOP
>    *   preempt_schedule_notrace   <- NOP
>    *   irqentry_exit_cond_resched <- NOP
> + *   dynamic_preempt_lazy       <- false
>    *
>    * VOLUNTARY:
>    *   cond_resched               <- __cond_resched
> @@ -7341,6 +7375,7 @@ EXPORT_SYMBOL(__cond_resched_rwlock_writ
>    *   preempt_schedule           <- NOP
>    *   preempt_schedule_notrace   <- NOP
>    *   irqentry_exit_cond_resched <- NOP
> + *   dynamic_preempt_lazy       <- false
>    *
>    * FULL:
>    *   cond_resched               <- RET0
> @@ -7348,6 +7383,15 @@ EXPORT_SYMBOL(__cond_resched_rwlock_writ
>    *   preempt_schedule           <- preempt_schedule
>    *   preempt_schedule_notrace   <- preempt_schedule_notrace
>    *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
> + *   dynamic_preempt_lazy       <- false
> + *
> + * LAZY:
> + *   cond_resched               <- RET0
> + *   might_resched              <- RET0
> + *   preempt_schedule           <- preempt_schedule
> + *   preempt_schedule_notrace   <- preempt_schedule_notrace
> + *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
> + *   dynamic_preempt_lazy       <- true
>    */
>   
>   enum {
> @@ -7355,6 +7399,7 @@ enum {
>   	preempt_dynamic_none,
>   	preempt_dynamic_voluntary,
>   	preempt_dynamic_full,
> +	preempt_dynamic_lazy,
>   };
>   
>   int preempt_dynamic_mode = preempt_dynamic_undefined;
> @@ -7370,15 +7415,23 @@ int sched_dynamic_mode(const char *str)
>   	if (!strcmp(str, "full"))
>   		return preempt_dynamic_full;
>   
> +#ifdef CONFIG_ARCH_HAS_PREEMPT_LAZY
> +	if (!strcmp(str, "lazy"))
> +		return preempt_dynamic_lazy;
> +#endif
> +
>   	return -EINVAL;
>   }
>   
> +#define preempt_dynamic_key_enable(f)	static_key_enable(&sk_dynamic_##f.key)
> +#define preempt_dynamic_key_disable(f)	static_key_disable(&sk_dynamic_##f.key)
> +
>   #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
>   #define preempt_dynamic_enable(f)	static_call_update(f, f##_dynamic_enabled)
>   #define preempt_dynamic_disable(f)	static_call_update(f, f##_dynamic_disabled)
>   #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> -#define preempt_dynamic_enable(f)	static_key_enable(&sk_dynamic_##f.key)
> -#define preempt_dynamic_disable(f)	static_key_disable(&sk_dynamic_##f.key)
> +#define preempt_dynamic_enable(f)	preempt_dynamic_key_enable(f)
> +#define preempt_dynamic_disable(f)	preempt_dynamic_key_disable(f)
>   #else
>   #error "Unsupported PREEMPT_DYNAMIC mechanism"
>   #endif
> @@ -7398,6 +7451,7 @@ static void __sched_dynamic_update(int m
>   	preempt_dynamic_enable(preempt_schedule);
>   	preempt_dynamic_enable(preempt_schedule_notrace);
>   	preempt_dynamic_enable(irqentry_exit_cond_resched);
> +	preempt_dynamic_key_disable(preempt_lazy);
>   
>   	switch (mode) {
>   	case preempt_dynamic_none:
> @@ -7407,6 +7461,7 @@ static void __sched_dynamic_update(int m
>   		preempt_dynamic_disable(preempt_schedule);
>   		preempt_dynamic_disable(preempt_schedule_notrace);
>   		preempt_dynamic_disable(irqentry_exit_cond_resched);
> +		preempt_dynamic_key_disable(preempt_lazy);
>   		if (mode != preempt_dynamic_mode)
>   			pr_info("Dynamic Preempt: none\n");
>   		break;
> @@ -7418,6 +7473,7 @@ static void __sched_dynamic_update(int m
>   		preempt_dynamic_disable(preempt_schedule);
>   		preempt_dynamic_disable(preempt_schedule_notrace);
>   		preempt_dynamic_disable(irqentry_exit_cond_resched);
> +		preempt_dynamic_key_disable(preempt_lazy);
>   		if (mode != preempt_dynamic_mode)
>   			pr_info("Dynamic Preempt: voluntary\n");
>   		break;
> @@ -7429,9 +7485,22 @@ static void __sched_dynamic_update(int m
>   		preempt_dynamic_enable(preempt_schedule);
>   		preempt_dynamic_enable(preempt_schedule_notrace);
>   		preempt_dynamic_enable(irqentry_exit_cond_resched);
> +		preempt_dynamic_key_disable(preempt_lazy);
>   		if (mode != preempt_dynamic_mode)
>   			pr_info("Dynamic Preempt: full\n");
>   		break;
> +
> +	case preempt_dynamic_lazy:
> +		if (!klp_override)
> +			preempt_dynamic_disable(cond_resched);
> +		preempt_dynamic_disable(might_resched);
> +		preempt_dynamic_enable(preempt_schedule);
> +		preempt_dynamic_enable(preempt_schedule_notrace);
> +		preempt_dynamic_enable(irqentry_exit_cond_resched);
> +		preempt_dynamic_key_enable(preempt_lazy);
> +		if (mode != preempt_dynamic_mode)
> +			pr_info("Dynamic Preempt: lazy\n");
> +		break;
>   	}
>   
>   	preempt_dynamic_mode = mode;
> @@ -7494,6 +7563,8 @@ static void __init preempt_dynamic_init(
>   			sched_dynamic_update(preempt_dynamic_none);
>   		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)) {
>   			sched_dynamic_update(preempt_dynamic_voluntary);
> +		} else if (IS_ENABLED(CONFIG_PREEMPT_LAZY)) {
> +			sched_dynamic_update(preempt_dynamic_lazy);
>   		} else {
>   			/* Default static call setting, nothing to do */
>   			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
> @@ -7514,6 +7585,7 @@ static void __init preempt_dynamic_init(
>   PREEMPT_MODEL_ACCESSOR(none);
>   PREEMPT_MODEL_ACCESSOR(voluntary);
>   PREEMPT_MODEL_ACCESSOR(full);
> +PREEMPT_MODEL_ACCESSOR(lazy);
>   
>   #else /* !CONFIG_PREEMPT_DYNAMIC: */
>   
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -245,11 +245,12 @@ static ssize_t sched_dynamic_write(struc
>   static int sched_dynamic_show(struct seq_file *m, void *v)
>   {
>   	static const char * preempt_modes[] = {
> -		"none", "voluntary", "full"
> +		"none", "voluntary", "full", "lazy",
>   	};
> +	int j = ARRAY_SIZE(preempt_modes) - !IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY);
>   	int i;
>   
> -	for (i = 0; i < ARRAY_SIZE(preempt_modes); i++) {
> +	for (i = 0; i < j; i++) {
>   		if (preempt_dynamic_mode == i)
>   			seq_puts(m, "(");
>   		seq_puts(m, preempt_modes[i]);
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1251,7 +1251,7 @@ static void update_curr(struct cfs_rq *c
>   		return;
>   
>   	if (resched || did_preempt_short(cfs_rq, curr)) {



If there is a long running task, only after it is not eligible, LAZY would be set and
subsequent tick would upgrade it to NR. If one sets sysctl_sched_base_slice to a large
value (max 4seconds), LAZY would set thereafter(max 4 seconds) if there in no wakeup in
that CPU.

If i set sysctl_sched_base_slice=300ms, spawn 2 stress-ng on one CPU, then LAZY bit is
set usually after 300ms of sched_switch if there are no wakeups. Subsequent tick NR is set.
Initially I was thinking, if there is a long running process, then LAZY would be set after
one tick and on subsequent tick NR would set. I was wrong. It might take a long time for LAZY
to be set, and On subsequent tick NR would be set.

That would be expected behavior since one setting sysctl_sched_base_slice know what to expect?

> -		resched_curr(rq);
> +		resched_curr_lazy(rq);
>   		clear_buddies(cfs_rq, curr);
>   	}
>   }
> @@ -5677,7 +5677,7 @@ entity_tick(struct cfs_rq *cfs_rq, struc
>   	 * validating it and just reschedule.
>   	 */
>   	if (queued) {

What's this queued used for? hrtick seems to set it. I haven't understood how it works.

> -		resched_curr(rq_of(cfs_rq));
> +		resched_curr_lazy(rq_of(cfs_rq));
>   		return;
>   	}
>   	/*
> @@ -8832,7 +8832,7 @@ static void check_preempt_wakeup_fair(st
>   	return;
>   
>   preempt:
> -	resched_curr(rq);

Is it better to call resched_curr here? When the code arrives here, it wants to
run pse as soon as possible right?

> +	resched_curr_lazy(rq);
>   }
>   
>   static struct task_struct *pick_task_fair(struct rq *rq)
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2692,6 +2692,7 @@ extern void init_sched_rt_class(void);
>   extern void init_sched_fair_class(void);
>   
>   extern void resched_curr(struct rq *rq);
> +extern void resched_curr_lazy(struct rq *rq);
>   extern void resched_cpu(int cpu);
>   
>   extern void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime);
> 
> 
> 


