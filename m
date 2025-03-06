Return-Path: <linux-kernel+bounces-548896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C19A54A9B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FC897A7D31
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9284820B7EF;
	Thu,  6 Mar 2025 12:24:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B23320B7FC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741263866; cv=none; b=lysdrhRcQaVOtgHb105N3jl54DjfAC69ptF4gw5a9bC9lKTCnkvskrqHZxyCnFTUir7MxRuIEsvWb2ejgtlPDTTReR9VpT+5pfG6Cv5R/q+JXCMT6DoJAHKKtJhY/REYbOBNQ3H1UQInhiznsH4AHKHuDXqjYMRr4F2RhU1OYow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741263866; c=relaxed/simple;
	bh=hnmsdv0n+xyd1APCTpa5wP64QRKPNqtvYR6RQlwEw+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBEgsihGdP4B8KIjHSu93E0fuIasPV+wv93/yYlF4uJpotyFstnLKj1d77Hd3Xi0yncHYYYbc0L+1eZwco4pMyc1xXzS7pUN8uMdTTLazhwLJxTAVLqPGmw1df0Lx1t/A/Dt58JEQ3ueUV3QCEJ8Hzij0SdWmrNn57kLA2ptmvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 415C71007;
	Thu,  6 Mar 2025 04:24:36 -0800 (PST)
Received: from [10.57.40.132] (unknown [10.57.40.132])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C8343F673;
	Thu,  6 Mar 2025 04:24:20 -0800 (PST)
Message-ID: <34521ae6-5dba-4861-a971-8f7c8a37bb04@arm.com>
Date: Thu, 6 Mar 2025 12:24:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/uclamp: Let each sched_class handle uclamp
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan@unisoc.com>
References: <84441660bef0a5e67fd09dc3787178d0276dad31.1740664400.git.hongyan.xia2@arm.com>
 <CAB8ipk_xXY7Dia32NzCpva_Bi1L7ijTHjZHA_riCUwj7e4PtpA@mail.gmail.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <CAB8ipk_xXY7Dia32NzCpva_Bi1L7ijTHjZHA_riCUwj7e4PtpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/03/2025 12:03, Xuewen Yan wrote:
> Hi Hongyan,
> 
> On Thu, Feb 27, 2025 at 9:55 PM Hongyan Xia <hongyan.xia2@arm.com> wrote:
>>
>> While delayed dequeue issues were being resolved, uclamp was made out of
>> sync with cpufreq, especially in enqueue_task().
>>
>> For example, when a task with uclamp_min goes through enqueue_task() and
>> updates cpufreq, its uclamp_min won't even be considered in the cpufreq
>> update. It is only after enqueue will the uclamp_min be added to rq
>> buckets, and cpufreq will only pick it up at the next update. This is
>> very different from the old behavior, where a uclamp value immediately
>> has an effect at enqueue. Worse, sub classes like fair.c issue cpufreq
>> updates on utilization changes. If no utilization changes for a while,
>> the new uclamp will be delayed further.
>>
>> So, let each sched_class handle uclamp in its own class, in case delayed
>> dequeue needs further tweaks or there are potential future similar
>> changes, and make sure uclamp is picked up immediately on enqueue. In
>> fair.c, we re-use the guard logic for util_est.
>>
>> Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
>> ---
>>   kernel/sched/core.c  | 28 ++--------------------------
>>   kernel/sched/ext.c   |  8 ++++----
>>   kernel/sched/fair.c  | 12 ++++++------
>>   kernel/sched/rt.c    |  8 ++++----
>>   kernel/sched/sched.h |  9 +++++----
>>   5 files changed, 21 insertions(+), 44 deletions(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index b00f884701a6..2d51608a4c46 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -1745,7 +1745,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
>>          }
>>   }
>>
>> -static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>> +void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>>   {
>>          enum uclamp_id clamp_id;
>>
>> @@ -1758,12 +1758,6 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>>          if (!static_branch_unlikely(&sched_uclamp_used))
>>                  return;
>>
>> -       if (unlikely(!p->sched_class->uclamp_enabled))
>> -               return;
>> -
>> -       if (p->se.sched_delayed)
>> -               return;
>> -
>>          for_each_clamp_id(clamp_id)
>>                  uclamp_rq_inc_id(rq, p, clamp_id);
>>
>> @@ -1772,7 +1766,7 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>>                  rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
>>   }
>>
>> -static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
>> +void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
>>   {
>>          enum uclamp_id clamp_id;
>>
>> @@ -1785,12 +1779,6 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
>>          if (!static_branch_unlikely(&sched_uclamp_used))
>>                  return;
>>
>> -       if (unlikely(!p->sched_class->uclamp_enabled))
>> -               return;
>> -
>> -       if (p->se.sched_delayed)
>> -               return;
>> -
>>          for_each_clamp_id(clamp_id)
>>                  uclamp_rq_dec_id(rq, p, clamp_id);
>>   }
>> @@ -2029,8 +2017,6 @@ static void __init init_uclamp(void)
>>   }
>>
>>   #else /* !CONFIG_UCLAMP_TASK */
>> -static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
>> -static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
>>   static inline void uclamp_fork(struct task_struct *p) { }
>>   static inline void uclamp_post_fork(struct task_struct *p) { }
>>   static inline void init_uclamp(void) { }
>> @@ -2066,11 +2052,6 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>>                  update_rq_clock(rq);
>>
>>          p->sched_class->enqueue_task(rq, p, flags);
>> -       /*
>> -        * Must be after ->enqueue_task() because ENQUEUE_DELAYED can clear
>> -        * ->sched_delayed.
>> -        */
>> -       uclamp_rq_inc(rq, p);
>>
>>          psi_enqueue(p, flags);
>>
>> @@ -2097,11 +2078,6 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>>
>>          psi_dequeue(p, flags);
>>
>> -       /*
>> -        * Must be before ->dequeue_task() because ->dequeue_task() can 'fail'
>> -        * and mark the task ->sched_delayed.
>> -        */
>> -       uclamp_rq_dec(rq, p);
>>          return p->sched_class->dequeue_task(rq, p, flags);
>>   }
>>
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index 8857c0709bdd..4521c27f9ab8 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -2094,6 +2094,8 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
>>   {
>>          int sticky_cpu = p->scx.sticky_cpu;
>>
>> +       uclamp_rq_inc(rq, p);
>> +
>>          if (enq_flags & ENQUEUE_WAKEUP)
>>                  rq->scx.flags |= SCX_RQ_IN_WAKEUP;
>>
>> @@ -2181,6 +2183,8 @@ static void ops_dequeue(struct task_struct *p, u64 deq_flags)
>>
>>   static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags)
>>   {
>> +       uclamp_rq_dec(rq, p);
>> +
>>          if (!(p->scx.flags & SCX_TASK_QUEUED)) {
>>                  WARN_ON_ONCE(task_runnable(p));
>>                  return true;
>> @@ -4456,10 +4460,6 @@ DEFINE_SCHED_CLASS(ext) = {
>>          .prio_changed           = prio_changed_scx,
>>
>>          .update_curr            = update_curr_scx,
>> -
>> -#ifdef CONFIG_UCLAMP_TASK
>> -       .uclamp_enabled         = 1,
>> -#endif
>>   };
>>
>>   static void init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id)
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 857808da23d8..7e5a653811ad 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6941,8 +6941,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>           * Let's add the task's estimated utilization to the cfs_rq's
>>           * estimated utilization, before we update schedutil.
>>           */
>> -       if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE))))
>> +       if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE)))) {
>> +               uclamp_rq_inc(rq, p);
>>                  util_est_enqueue(&rq->cfs, p);
>> +       }
>>
>>          if (flags & ENQUEUE_DELAYED) {
>>                  requeue_delayed_entity(se);
>> @@ -7183,8 +7185,10 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>>    */
>>   static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>   {
>> -       if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & DEQUEUE_SAVE))))
>> +       if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & DEQUEUE_SAVE)))) {
>> +               uclamp_rq_dec(rq, p);
>>                  util_est_dequeue(&rq->cfs, p);
>> +       }
>>
>>          util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
>>          if (dequeue_entities(rq, &p->se, flags) < 0)
>> @@ -13660,10 +13664,6 @@ DEFINE_SCHED_CLASS(fair) = {
>>   #ifdef CONFIG_SCHED_CORE
>>          .task_is_throttled      = task_is_throttled_fair,
>>   #endif
>> -
>> -#ifdef CONFIG_UCLAMP_TASK
>> -       .uclamp_enabled         = 1,
>> -#endif
>>   };
>>
>>   #ifdef CONFIG_SCHED_DEBUG
>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> index 4b8e33c615b1..7c0642ea85f2 100644
>> --- a/kernel/sched/rt.c
>> +++ b/kernel/sched/rt.c
>> @@ -1471,6 +1471,8 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
>>   {
>>          struct sched_rt_entity *rt_se = &p->rt;
>>
>> +       uclamp_rq_inc(rq, p);
>> +
>>          if (flags & ENQUEUE_WAKEUP)
>>                  rt_se->timeout = 0;
>>
>> @@ -1487,6 +1489,8 @@ static bool dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
>>   {
>>          struct sched_rt_entity *rt_se = &p->rt;
>>
>> +       uclamp_rq_dec(rq, p);
>> +
>>          update_curr_rt(rq);
>>          dequeue_rt_entity(rt_se, flags);
>>
>> @@ -2649,10 +2653,6 @@ DEFINE_SCHED_CLASS(rt) = {
>>   #ifdef CONFIG_SCHED_CORE
>>          .task_is_throttled      = task_is_throttled_rt,
>>   #endif
>> -
>> -#ifdef CONFIG_UCLAMP_TASK
>> -       .uclamp_enabled         = 1,
>> -#endif
>>   };
>>
>>   #ifdef CONFIG_RT_GROUP_SCHED
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index ab16d3d0e51c..990d87e8d8ed 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -2410,10 +2410,6 @@ extern s64 update_curr_common(struct rq *rq);
>>
>>   struct sched_class {
>>
>> -#ifdef CONFIG_UCLAMP_TASK
>> -       int uclamp_enabled;
>> -#endif
> 
> Why delete the uclamp_enable?
> 

After moving uclamp enqueue dequeue into each sched_class, we no longer 
check sched_class->uclamp_enabled in core.c and it won't be used anywhere.

>> -
>>          void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
>>          bool (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
>>          void (*yield_task)   (struct rq *rq);
>> @@ -3393,6 +3389,8 @@ static inline bool update_other_load_avgs(struct rq *rq) { return false; }
>>   #ifdef CONFIG_UCLAMP_TASK
>>
>>   unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
>> +void uclamp_rq_inc(struct rq *rq, struct task_struct *p);
>> +void uclamp_rq_dec(struct rq *rq, struct task_struct *p);
>>
>>   static inline unsigned long uclamp_rq_get(struct rq *rq,
>>                                            enum uclamp_id clamp_id)
>> @@ -3470,6 +3468,9 @@ uclamp_se_set(struct uclamp_se *uc_se, unsigned int value, bool user_defined)
>>
>>   #else /* !CONFIG_UCLAMP_TASK: */
>>
>> +static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { };
>> +static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { };
>> +
>>   static inline unsigned long
>>   uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
>>   {
>> --
>> 2.34.1
>>
>>


