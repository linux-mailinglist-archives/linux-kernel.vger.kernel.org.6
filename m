Return-Path: <linux-kernel+bounces-554251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D0CA59546
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7800F188E892
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E8D229B01;
	Mon, 10 Mar 2025 12:55:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66B4227E9F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611305; cv=none; b=opsKCX1CkRFVybnFD1ciUnepaJRf0Hw2uEd3FSDP4YE87E4ZOn4gecdXQebdjumgRD4e2XXGm6ZzKeQS3DhufH+MGo0bNwJqJVXYhylO44k4bT6emw+00Up0p8FVtRbq2TGILvkSxdy72M/wWhdsHAbY1oI/mBvnObcz/GKxslA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611305; c=relaxed/simple;
	bh=BDT3Rdmjn2ptbbqKIeXWGlSs+uNjCZMpbk0kk83YzC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3KLh3AGlvNVhPMZupHjrbAQn8UPuP4jXcIjVvmaxlbBXekrpVu9BH1PxIiwoWeS9l5NQpj8hFjkF1/NcA2jrUzYXqCBHBj1DwQ5HYmBYUmRtfP1z6I2VM6x9pgBvLtTXhanzvMRi9z4mrApIGLYVNL0keSpfYjG/820UiBIMsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75166152B;
	Mon, 10 Mar 2025 05:55:14 -0700 (PDT)
Received: from [10.1.27.50] (e133649.arm.com [10.1.27.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 591793F673;
	Mon, 10 Mar 2025 05:55:00 -0700 (PDT)
Message-ID: <4a8ed999-2ee5-478c-a759-fec1c496cba9@arm.com>
Date: Mon, 10 Mar 2025 12:54:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] uclamp sum aggregation
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org,
 Xuewen Yan <xuewen.yan@unisoc.com>
References: <cover.1741091349.git.hongyan.xia2@arm.com>
 <CAB8ipk_AvaOWp9QhmnFDdbFSWcKLhCH151=no6kRO2z+pSJfyQ@mail.gmail.com>
 <6eb93af8-e239-44d7-a132-2932f260e792@arm.com>
 <CAB8ipk9LpbiUDnbcV6+59+Sa=Ai7tFzO===mpLD3obNdV4=J-A@mail.gmail.com>
 <13ea9f62-e373-4248-997c-47c15e024c02@arm.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <13ea9f62-e373-4248-997c-47c15e024c02@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/03/2025 11:34, Dietmar Eggemann wrote:
> On 06/03/2025 12:38, Xuewen Yan wrote:
>> On Thu, Mar 6, 2025 at 7:32 PM Hongyan Xia <hongyan.xia2@arm.com> wrote:
>>>
>>> Hi Xuewen,
>>>
>>> On 06/03/2025 11:12, Xuewen Yan wrote:
>>>> Hi Hongyan,
>>>>
>>>> On Tue, Mar 4, 2025 at 10:26 PM Hongyan Xia <hongyan.xia2@arm.com> wrote:
> 
> [...]
> 
>>>> Subject: [PATCH] sched/uclamp: Update the rq's uclamp before enqueue task
>>>>
>>>> When task's uclamp is set, we hope that the CPU frequency
>>>> can increase as quickly as possible when the task is enqueued.
>>>> Because the cpu frequency updating happens during the enqueue_task(),
>>>> so the rq's uclamp needs to be updated before the task is enqueued.
>>>> For sched-delayed tasks, the rq uclamp should only be updated
>>>> when they are enqueued upon being awakened.
>>>>
>>>> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
>>>> ---
>>>>    kernel/sched/core.c | 14 ++++++--------
>>>>    1 file changed, 6 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>> index 67189907214d..b07e78910221 100644
>>>> --- a/kernel/sched/core.c
>>>> +++ b/kernel/sched/core.c
>>>> @@ -1747,7 +1747,7 @@ static inline void uclamp_rq_dec_id(struct rq
>>>> *rq, struct task_struct *p,
>>>>           }
>>>>    }
>>>>
>>>> -static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>>>> +static inline void uclamp_rq_inc(struct rq *rq, struct task_struct
>>>> *p, int flags)
>>>>    {
>>>>           enum uclamp_id clamp_id;
>>>>
>>>> @@ -1763,7 +1763,8 @@ static inline void uclamp_rq_inc(struct rq *rq,
>>>> struct task_struct *p)
>>>>           if (unlikely(!p->sched_class->uclamp_enabled))
>>>>                   return;
>>>>
>>>> -       if (p->se.sched_delayed)
>>>> +       /* Only inc the delayed task which is being woken up. */
>>>> +       if (p->se.sched_delayed && !(flags & ENQUEUE_DELAYED))
>>>>                   return;
>>>>
>>>>           for_each_clamp_id(clamp_id)
>>>> @@ -2031,7 +2032,7 @@ static void __init init_uclamp(void)
>>>>    }
>>>>
>>>>    #else /* !CONFIG_UCLAMP_TASK */
>>>> -static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
>>>> +static inline void uclamp_rq_inc(struct rq *rq, struct task_struct
>>>> *p, int flags) { }
>>>>    static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
>>>>    static inline void uclamp_fork(struct task_struct *p) { }
>>>>    static inline void uclamp_post_fork(struct task_struct *p) { }
>>>> @@ -2067,12 +2068,9 @@ void enqueue_task(struct rq *rq, struct
>>>> task_struct *p, int flags)
>>>>           if (!(flags & ENQUEUE_NOCLOCK))
>>>>                   update_rq_clock(rq);
>>>>
>>>> +       uclamp_rq_inc(rq, p, flags);
>>>> +
>>>>           p->sched_class->enqueue_task(rq, p, flags);
>>>> -       /*
>>>> -        * Must be after ->enqueue_task() because ENQUEUE_DELAYED can clear
>>>> -        * ->sched_delayed.
>>>> -        */
>>>> -       uclamp_rq_inc(rq, p);
>>>>
>>>>           psi_enqueue(p, flags);
> 
> Like I mentioned already in the original thread:
> 
> https://lkml.kernel.org/r/65365ec7-6a16-4e66-8005-e78788cbedfa@arm.com
> 
> I would prefer that uclamp stays in core.c. ENQUEUE_DELAYED among all
> the other flags is already used there (ttwu_runnable()).
> 
> task_struct contains sched_{,rt_,dl_}entity}. We just have to be
> careful when switching policies.
> 
> --
> 
> Could you also incorporate the changes in {en,de}queue_task_fair()
> ((task_on_rq_migrating(p) || (flags & {RESTORE,DEQUEUE}_SAVE))) vs.
> (!p->se.sched_delayed || (flags & ENQUEUE_DELAYED)) and
> (!p->se.sched_delayed) so the uclamp-util_est relation is easier to spot?
> 
> [...]

At the moment we can't do this. Sum aggregation was designed before 
delayed dequeue and it syncs with p->se.on_rq. If we sync with something 
else and take care of delayed dequeue cases (like util_est) then I have 
to rewrite part of the series.

