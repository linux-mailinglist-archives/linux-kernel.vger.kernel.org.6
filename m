Return-Path: <linux-kernel+bounces-524395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B940A3E2BD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF63B3B519C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795F9212FAD;
	Thu, 20 Feb 2025 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iw9CaWcf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DE61EBA05
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072671; cv=none; b=fmRgyieNOXXrrwLXUcbMQMSDoEuJEHeYSu1Spo+G03mx4aEPAlrCwrHgjiMazZnGybQK5s6Xiz9/x23ves7dZZtv3A415N2j+R3Kb7y4BBvgukq3qayt3miouu5QKhj2JRmkmvBXMwpnKchTzBneQmUJL25ldsQZHPXsaRjD9H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072671; c=relaxed/simple;
	bh=AmT2LTewgUk6W3CyABUagCN/TNALuT3MZwNF040lvPc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=kmmdEatDaW8CXktozZIjqrHgsQrgzsoCQgn5IFu9pwJtTdGDn02wPCWMJ1YAK66EWTNJC4ZjOPJyXgW6EeW2oLL2teIasK+GVtiiGa95HJLp7E8ilG2TcMo8ZZIc4ncW9VbUbu5r57IFVydryVvmJqtywyRS3yYp7UTK4o6llt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iw9CaWcf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740072668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AmT2LTewgUk6W3CyABUagCN/TNALuT3MZwNF040lvPc=;
	b=Iw9CaWcfau/atJJYzwuxhOb3WSX8zHvAkJdPxQvlGepFweM0ObHGxv9sB8m98NJ4woiyq+
	vLi47wbR9Ea6FuKrW0+PU6WE0Z472a5M6X/mAPUtyKtY3nQ5yod2eHGKJqFnSvfgjDf1r9
	fYev7q0zXc6tfnilelM+naMHo5R2fH8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-iS8__7taMLynFEq6S45SyQ-1; Thu, 20 Feb 2025 12:31:07 -0500
X-MC-Unique: iS8__7taMLynFEq6S45SyQ-1
X-Mimecast-MFC-AGG-ID: iS8__7taMLynFEq6S45SyQ_1740072666
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f44be93a8so637024f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:31:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740072666; x=1740677466;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AmT2LTewgUk6W3CyABUagCN/TNALuT3MZwNF040lvPc=;
        b=XaGx+vRWWnmfsUN8UEoYNeOCi2ZbPctXYoT2AmSHT+bO0LPirGGcz9AGP7Asdhu+Js
         +0lpb7lyvQqPurvJWWsu8ykoIKgAkzabD/zpB1Fe7JhaJ1MCkP5Wey37GrpsPLiG8j3I
         wD2UD+VrJ7BM/H2SZoT/2Qz78NSSFNd5GxdzFGmDP7G/yxhViQ3qo03HWuzxenQY33is
         TRwLLEbb5Ncmylx3ki3e2dBb27oDHteDw9czH4KRds+2M+M1H1UPou23vRcC0LZ807Zu
         VRYYP2Jv5shmKDdkWwWzNOxQfyTpx9DaAFXlYbcyEJRvrFdw+fHE8oSUwUvCR+4ItiwN
         lxxw==
X-Gm-Message-State: AOJu0YwL3XQBXzM9j71Em9gJD9LQ07vl5KDjgHFh6SVy19ZyWEw489Iy
	GfEcEXjkB9Ud1enqiee3Q5V91Jrj3JluQvKG/dDor8wtuxaE0fEP1lLwNAbBKjNu8baKxWc/R9f
	X/mdJBtJb8McGR4cX3xWLCogf5o/SO5gZ7POt0eh8XYoTtK6DFm8a7PZDAbD+9Q==
X-Gm-Gg: ASbGncuiAdjT0eun7sdjsQQ/XP/uJWy+f2aFuDLJHVUZuCBj8+6WSroc2FuOhLBCdpx
	4H+oIlF4QZwWSyZW+8GMYYI5bqysGheIVeLVedoxS2X6bnUaSecNEaXgJxfdzEkFACVjYA/ymfp
	mGRZkinNxAs+hhVjVO5SBx0yM8jlSRu0wgqjDdSySu5whldiLmwMT2ZZZaV9d5DfhF7ZQla0PqM
	GgOGrdqEhSMH/LBu7CD+NZ8/QNAqGPZYV3SVaPOapDxjQXoI7kQf+pcVKFhBcgKow+pu29Zl+U5
	Hh8=
X-Received: by 2002:a05:6000:1f83:b0:38f:2193:f8c2 with SMTP id ffacd0b85a97d-38f6e979541mr105669f8f.31.1740072665695;
        Thu, 20 Feb 2025 09:31:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQ9dY1vksBSyw5YrEbmeUp0GicOvbhGSLfYn63nymjJQ6qavWqQdpc5kUCfbNIfd/uix2VhA==
X-Received: by 2002:a05:6000:1f83:b0:38f:2193:f8c2 with SMTP id ffacd0b85a97d-38f6e979541mr105615f8f.31.1740072665165;
        Thu, 20 Feb 2025 09:31:05 -0800 (PST)
Received: from [127.0.0.1] ([195.174.132.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ddba7sm21477624f8f.38.2025.02.20.09.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 09:31:04 -0800 (PST)
Date: Thu, 20 Feb 2025 17:31:00 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>, linux-mm@kvack.org,
	Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>
Message-ID: <f76f6c3a-a1c1-4bdc-bc0b-f419446cac9b@redhat.com>
In-Reply-To: <6b542d40-8163-4156-93af-b3f26c397010@efficios.com>
References: <20250220102639.141314-1-gmonaco@redhat.com> <20250220102639.141314-2-gmonaco@redhat.com> <c9026605-da1b-4631-b0dd-68ae0700ec87@efficios.com> <ebc70e9e9ad4a7055286d0db93085536ed070a6f.camel@redhat.com> <6b542d40-8163-4156-93af-b3f26c397010@efficios.com>
Subject: Re: [PATCH v8 1/2] sched: Move task_mm_cid_work to mm work_struct
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <f76f6c3a-a1c1-4bdc-bc0b-f419446cac9b@redhat.com>

2025-02-20T15:47:26Z Mathieu Desnoyers <mathieu.desnoyers@efficios.com>:

> On 2025-02-20 10:30, Gabriele Monaco wrote:
>>
>> On Thu, 2025-02-20 at 09:42 -0500, Mathieu Desnoyers wrote:
>>> On 2025-02-20 05:26, Gabriele Monaco wrote:
>>>> Currently, the task_mm_cid_work function is called in a task work
>>>> triggered by a scheduler tick to frequently compact the mm_cids of
>>>> each
>>>> process. This can delay the execution of the corresponding thread
>>>> for
>>>> the entire duration of the function, negatively affecting the
>>>> response
>>>> in case of real time tasks. In practice, we observe
>>>> task_mm_cid_work
>>>> increasing the latency of 30-35us on a 128 cores system, this order
>>>> of
>>>> magnitude is meaningful under PREEMPT_RT.
>>>>
>>>> Run the task_mm_cid_work in a new work_struct connected to the
>>>> mm_struct rather than in the task context before returning to
>>>> userspace.
>>>>
>>>> This work_struct is initialised with the mm and disabled before
>>>> freeing
>>>> it. The queuing of the work happens while returning to userspace in
>>>> __rseq_handle_notify_resume, maintaining the checks to avoid
>>>> running
>>>> more frequently than MM_CID_SCAN_DELAY.
>>>> To make sure this happens predictably also on long running tasks,
>>>> we
>>>> trigger a call to __rseq_handle_notify_resume also from the
>>>> scheduler
>>>> tick (which in turn will also schedule the work item).
>>>>
>>>> The main advantage of this change is that the function can be
>>>> offloaded
>>>> to a different CPU and even preempted by RT tasks.
>>>>
>>>> Moreover, this new behaviour is more predictable with periodic
>>>> tasks
>>>> with short runtime, which may rarely run during a scheduler tick.
>>>> Now, the work is always scheduled when the task returns to
>>>> userspace.
>>>>
>>>> The work is disabled during mmdrop, since the function cannot sleep
>>>> in
>>>> all kernel configurations, we cannot wait for possibly running work
>>>> items to terminate. We make sure the mm is valid in case the task
>>>> is
>>>> terminating by reserving it with mmgrab/mmdrop, returning
>>>> prematurely if
>>>> we are really the last user while the work gets to run.
>>>> This situation is unlikely since we don't schedule the work for
>>>> exiting
>>>> tasks, but we cannot rule it out.
>>>>
>>>> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced
>>>> by mm_cid")
>>>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>>>> ---
>>> [...]
>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>> index 9aecd914ac691..363e51dd25175 100644
>>>> --- a/kernel/sched/core.c
>>>> +++ b/kernel/sched/core.c
>>>> @@ -5663,7 +5663,7 @@ void sched_tick(void)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resched_latency =3D cpu_resched_l=
atency(rq);
>>>> =C2=A0=C2=A0 calc_global_load_tick(rq);
>>>> =C2=A0=C2=A0 sched_core_tick(rq);
>>>> -=C2=A0=C2=A0 task_tick_mm_cid(rq, donor);
>>>> +=C2=A0=C2=A0 rseq_preempt(donor);
>>>> =C2=A0=C2=A0 scx_tick(rq);
>>>> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 rq_unlock(rq, &rf);
>>>
>>> There is one tiny important detail worth discussing here: I wonder if
>>> executing a __rseq_handle_notify_resume() on return to userspace on
>>> every scheduler tick will cause noticeable performance degradation ?
>>>
>>> I think we can mitigate the impact if we can quickly compute the
>>> amount
>>> of contiguous unpreempted runtime since last preemption, then we
>>> could
>>> use this as a way to only issue rseq_preempt() when there has been a
>>> minimum amount of contiguous unpreempted execution. Otherwise the
>>> rseq_preempt() already issued by preemption is enough.
>>>
>>> I'm not entirely sure how to compute this "unpreempted contiguous
>>> runtime" value within sched_tick() though, any ideas ?
>> I was a bit concerned but, at least from the latency perspective, I
>> didn't see any noticeable difference. This may also depend on the
>> system under test, though.
>
> I see this as an issue for performance-related workloads, not
> specifically for latency: we'd be adding additional rseq notifiers
> triggered by the tick in workloads that are CPU-heavy and would
> otherwise not run it after tick. And we'd be adding this overhead
> even in scenarios where there are relatively frequent preemptions
> happening, because every tick would end up issuing rseq_preempt().
>
>> We may not need to do that, what we are doing here is improperly
>> calling rseq_preempt. What if we call an rseq_tick which sets a
>> different bit in rseq_event_mask and take that into consideration while
>> running __rseq_handle_notify_resume?
>
> I'm not sure how much it would help. It may reduce the amount of
> work to do, but we'd still be doing additional work at every tick.
>
> See my other email about using
>
> =C2=A0=C2=A0 se->sum_exec_runtime - se->prev_sum_exec_runtime
>
> to only do rseq_preempt() when the last preemption was a certain amount
> of consecutive runtime long ago. This is a better alternative I think.
>
>> We could follow the periodicity of the mm_cid compaction and, if the
>> rseq event is a tick, only continue if it is time to compact (and we
>> can return this value from task_queue_mm_cid to avoid checking twice).
>
> Note that the mm_cid compaction delay is per-mm, and the fact that we
> want to run __rseq_handle_notify_resume periodically to update the
> mm_cid fields applies to all threads. Therefore, I don't think we can
> use the mm_cid compaction delay (per-mm) for this.
>

Alright, didn't think of that, I can explore your suggestion. Looks like mo=
st of it is already implemented.
What would be a good value to consider the notify waited enough? 100ms or e=
ven less?
I don't think this would deserve a config.

>> We would be off by one period (commit the rseq happens before we
>> schedule the next compaction), but it should be acceptable:
>> =C2=A0=C2=A0=C2=A0=C2=A0 __rseq_handle_notify_resume()
>> =C2=A0=C2=A0=C2=A0=C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 should_queue =3D task_q=
ueue_mm_cid();
>
>> Another doubt about this case, here we are worrying about this
>> hypothetical long-running task, I'm assuming this can happen only for:
>> 1. isolated cpus with nohz_full and 1 task (the approach wouldn't work)
>
> The prev_sum_exec_runtime approach would work for this case.
>

I mean in that case nohz_full and isolation would ensure nothing else runs =
on the core, not even the tick (or perhaps that's also nohz=3Don). I don't =
think there's much we can do in such a case is there? (On that core/context=
 at least)

>> =C2=A0=C2=A0 or
>> 2. tasks with RT priority mostly starving the cpu
>
> Likewise.
>
>> In 1. I'm not sure the user would really need rseq in the first place,
>
> Not sure, but I'd prefer to keep this option available unless we have a
> strong reason for not being able to support this.
>
>> in 2., assuming nothing like stalld/sched rt throttling is in place, we
>> will probably also never run the kworker doing mm_cid compaction (I'm
>> using the system_wq), for this reason it's probably wiser to use the
>> system_unbound_wq, which as far as I could understand is the only one
>> that would allow the work to run on any other CPU.
>> I might be missing something trivial here, what do you think though?
>
> Good point. I suspect using the system_unbound_wq would be preferable
> here, especially given that we're iterating over possible CPUs anyway,
> so I don't expect much gain from running in a system_wq over
> system_unbound_wq. Or am I missing something ?

I don't think so, I just picked it as it was easier, but it's probably best=
 to switch.

Thanks,
Gabriele


