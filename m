Return-Path: <linux-kernel+bounces-554032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EFDA591FD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6AA16CC1E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542AB22A7F1;
	Mon, 10 Mar 2025 10:53:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD6C227E94
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604025; cv=none; b=EMVAzv3g7aOlBEMSZvYxsVQ0X/1pp1alkCtHppuvbNEgoePn8ZNqjBFOqvPt5l7yyToY3qxkU28g1nn1rG/Z5AsuHzipQnvzALQpewDRUWr5VR5qM5cAS469GCxzjZTDwzENArS8p0Zsg2Z09pgqrgvDbfuEhRxQUodjIvNlgto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604025; c=relaxed/simple;
	bh=kLQPSTKYeEXqLjLThv353A1zrewHsiXzhvlDGG/344Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgbYUnTez5yPj7KGLrxQvnolEye4RGxdcpe4owSJWKv4yhidEJK0jVu6+E3J6kcwg64FXFUIlusljxGJEILCl2QzjGEGLQyh9abU5Zjhi9RZm2DSNWIpz5/nEw7Byyg6hAoSoDvkyM++G5yWCCc427I3E00oBH07RqSABX7U1wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D765A153B;
	Mon, 10 Mar 2025 03:53:54 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 093983F5A1;
	Mon, 10 Mar 2025 03:53:40 -0700 (PDT)
Message-ID: <80c2c9f4-eb84-4a43-9c48-8f776615b45a@arm.com>
Date: Mon, 10 Mar 2025 11:53:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/uclamp: Let each sched_class handle uclamp
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Hongyan Xia <hongyan.xia2@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan@unisoc.com>
References: <84441660bef0a5e67fd09dc3787178d0276dad31.1740664400.git.hongyan.xia2@arm.com>
 <4394f2a7-b4e8-419a-a299-f1afa560c944@arm.com>
 <CAB8ipk_627GF+TV5u=6DK_3aRUHW8qGYwmN+KXMq_Cg-+Say1Q@mail.gmail.com>
 <bf5a70bf-3d13-4b3b-a3ef-804998b21fe9@arm.com>
 <CAB8ipk-SUFDATb=euJQFebxQ513SRwTEpSbBSD6K=batQKELHg@mail.gmail.com>
Content-Language: en-US
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAB8ipk-SUFDATb=euJQFebxQ513SRwTEpSbBSD6K=batQKELHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/03/2025 03:41, Xuewen Yan wrote:
> On Sat, Mar 8, 2025 at 2:32 AM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 06/03/2025 13:01, Xuewen Yan wrote:
>>> On Thu, Mar 6, 2025 at 2:24 AM Dietmar Eggemann
>>> <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 27/02/2025 14:54, Hongyan Xia wrote:
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>> index 857808da23d8..7e5a653811ad 100644
>>>>> --- a/kernel/sched/fair.c
>>>>> +++ b/kernel/sched/fair.c
>>>>> @@ -6941,8 +6941,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>>>>        * Let's add the task's estimated utilization to the cfs_rq's
>>>>>        * estimated utilization, before we update schedutil.
>>>>>        */
>>>>> -     if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE))))
>>>>> +     if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE)))) {
>>>>> +             uclamp_rq_inc(rq, p);
>>>>>               util_est_enqueue(&rq->cfs, p);
>>>>> +     }
>>>>
>>>> So you want to have p uclamp-enqueued so that its uclamp_min value
>>>> counts for the cpufreq_update_util()/cfs_rq_util_change() calls later in
>>>> enqueue_task_fair?
>>>>
>>>>   if (p->in_iowait)
>>>>     cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
>>>>
>>>>   enqueue_entity() -> update_load_avg() -> cfs_rq_util_change() ->
>>>>   cpufreq_update_util()
>>>>
>>>> But if you do this before requeue_delayed_entity() (1) you will not
>>>> uclamp-enqueue p which got his ->sched_delayed just cleared in (1)?
>>>>
>>>
>>> Could we change to the following:
>>>
>>> when enqueue:
>>>
>>> -     if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags
>>> & ENQUEUE_RESTORE))))
>>> +     if (!(p->se.sched_delayed && !(flags & ENQUEUE_DELAYED)))
>>
>> Why you want to check ENQUEUE_DELAYED as well here? Isn't
>> !p->se.sched_delayed implying !ENQUEUE_DELAYED).
> 
> Indeed, the (!(p->se.sched_delayed && !(flags & ENQUEUE_DELAYED))) is equal to
> the  (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags &
> ENQUEUE_RESTORE)))).
> I just think it might be easier to read using the ENQUEUE_DELAYED flag.
> Because we only allow enq the uclamp and util_est when wake up the delayed-task.

OK, I see.

So that means we would not have to move the uclamp handling into the sched
classes necessarily, we could use flags in enqueue_task() as well:

-->8--

Subject: [PATCH] Align uclamp and util_est and call before freq update

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c | 14 ++++++++------
 kernel/sched/fair.c |  4 ++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b60916d77482..f833108a3b2d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1747,7 +1747,8 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	}
 }
 
-static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
+static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p,
+				 int flags)
 {
 	enum uclamp_id clamp_id;
 
@@ -1763,7 +1764,7 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
-	if (p->se.sched_delayed)
+	if (p->se.sched_delayed && !(flags & ENQUEUE_DELAYED))
 		return;
 
 	for_each_clamp_id(clamp_id)
@@ -2067,12 +2068,13 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
-	p->sched_class->enqueue_task(rq, p, flags);
 	/*
-	 * Must be after ->enqueue_task() because ENQUEUE_DELAYED can clear
-	 * ->sched_delayed.
+	 * Can be before ->enqueue_task() because uclamp considers the
+	 * ENQUEUE_DELAYED task before its ->sched_delayed gets cleared
+	 * in ->enqueue_task().
 	 */
-	uclamp_rq_inc(rq, p);
+	uclamp_rq_inc(rq, p, flags);
+	p->sched_class->enqueue_task(rq, p, flags);
 
 	psi_enqueue(p, flags);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 061a29e88ee2..e26d1dfea601 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6951,7 +6951,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 * Let's add the task's estimated utilization to the cfs_rq's
 	 * estimated utilization, before we update schedutil.
 	 */
-	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE))))
+	if (!p->se.sched_delayed || (flags & ENQUEUE_DELAYED))
 		util_est_enqueue(&rq->cfs, p);
 
 	if (flags & ENQUEUE_DELAYED) {
@@ -7193,7 +7193,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
  */
 static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & DEQUEUE_SAVE))))
+	if (!p->se.sched_delayed)
 		util_est_dequeue(&rq->cfs, p);
 
 	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
-- 
2.34.1




































