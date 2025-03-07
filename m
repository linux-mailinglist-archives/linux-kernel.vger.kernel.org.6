Return-Path: <linux-kernel+bounces-551768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC61DA5709A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120781786C9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A9624166F;
	Fri,  7 Mar 2025 18:32:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F17194C9E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741372339; cv=none; b=Aoj7RWPaMsCWeg7sySjk/RHq5MXSPA9+KrUSrY8lZT5mTN/XzZ3r1xOYvMXQaYkxgAcVn9h7CuE07bpEC9eXtYqCLSZYegTA7y7qvF+7/cVsFKgFNI9RCG+y2KCgk+Q+fX0aFubXEw5XXJb4EL/UbsXePT2F6llnxmd7A0UPpDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741372339; c=relaxed/simple;
	bh=CYbLzp9/CJ1BIQeFIIoACM5Eqy8e3pWgm+FoIUKj8ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMev/w2Ao7a4S7hKVrM9F2M9ZfbzSdyWz04Y+zfykI65GWTYGWbgDtkc6gPZXHt8thZszNFK1TX3SaO4PQhTEUm5F14x4iD+Gpze2prVDLxbj7mjKFkPjT9OsvOIG3jKh/wEwLYSGMdEMLjHmy3CxloZOWNjJMXTtyp+z8ER2Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C558A1477;
	Fri,  7 Mar 2025 10:32:28 -0800 (PST)
Received: from [192.168.2.98] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A6CD3F66E;
	Fri,  7 Mar 2025 10:32:10 -0800 (PST)
Message-ID: <bf5a70bf-3d13-4b3b-a3ef-804998b21fe9@arm.com>
Date: Fri, 7 Mar 2025 19:32:07 +0100
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
 linux-kernel@vger.kernel.org
References: <84441660bef0a5e67fd09dc3787178d0276dad31.1740664400.git.hongyan.xia2@arm.com>
 <4394f2a7-b4e8-419a-a299-f1afa560c944@arm.com>
 <CAB8ipk_627GF+TV5u=6DK_3aRUHW8qGYwmN+KXMq_Cg-+Say1Q@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <CAB8ipk_627GF+TV5u=6DK_3aRUHW8qGYwmN+KXMq_Cg-+Say1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/03/2025 13:01, Xuewen Yan wrote:
> On Thu, Mar 6, 2025 at 2:24 AM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 27/02/2025 14:54, Hongyan Xia wrote:
>>
>> [...]
>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 857808da23d8..7e5a653811ad 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -6941,8 +6941,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>>        * Let's add the task's estimated utilization to the cfs_rq's
>>>        * estimated utilization, before we update schedutil.
>>>        */
>>> -     if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE))))
>>> +     if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE)))) {
>>> +             uclamp_rq_inc(rq, p);
>>>               util_est_enqueue(&rq->cfs, p);
>>> +     }
>>
>> So you want to have p uclamp-enqueued so that its uclamp_min value
>> counts for the cpufreq_update_util()/cfs_rq_util_change() calls later in
>> enqueue_task_fair?
>>
>>   if (p->in_iowait)
>>     cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
>>
>>   enqueue_entity() -> update_load_avg() -> cfs_rq_util_change() ->
>>   cpufreq_update_util()
>>
>> But if you do this before requeue_delayed_entity() (1) you will not
>> uclamp-enqueue p which got his ->sched_delayed just cleared in (1)?
>>
> 
> Could we change to the following:
> 
> when enqueue:
> 
> -     if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags
> & ENQUEUE_RESTORE))))
> +     if (!(p->se.sched_delayed && !(flags & ENQUEUE_DELAYED)))

Why you want to check ENQUEUE_DELAYED as well here? Isn't
!p->se.sched_delayed implying !ENQUEUE_DELAYED).

> +             uclamp_rq_inc(rq, p);
>                util_est_enqueue(&rq->cfs, p);
>  +     }
> 
> 
> when dequeue:
> 
> -       if (!(p->se.sched_delayed && (task_on_rq_migrating(p) ||
> (flags & DEQUEUE_SAVE))))
> +       if (!p->se.sched_delayed) {
> +               uclamp_rq_dec(rq, p);
>                 util_est_dequeue(&rq->cfs, p);
> +       }

So you want to exclude all delayed tasks from util_est and uclamp?

