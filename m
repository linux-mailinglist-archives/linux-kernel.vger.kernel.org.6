Return-Path: <linux-kernel+bounces-522032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DEDA3C519
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05A3189D8B5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D201FBEB0;
	Wed, 19 Feb 2025 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nxn2nE1l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816D91DE4C6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982763; cv=none; b=VTNBbKcK2gEt6V+gPZ/q++UOZ3A7KR3ZFnbm7FeNEmOEHPDn5vGhuRO0Jb9h/+A1PzsbudsT0VHIVRtBNwRG2wisRr/5nWI1JiR+PLUPuEYzwpFSo3ZprXHot8IGDnKBEGURibibjEoTPTmHaI2z3hK4P1jU/Vf9Xju8vY0c8Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982763; c=relaxed/simple;
	bh=Q8CgIcE3QwJsFaPpCkGgnCnoYS4A/W2amcUZ6xEWGUo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Wz6WvyYV3EWyi2Ir6MDd0ynqI1g/osofD6ykYttAnf8Mq8dGk37xFEBT2MyJvzjS1B+6vp9QVoIon0w9tk/oKmfL6wCqMX97uV669nhoDYPXUgJJOSRvjdQcmgb87ghgMkPq0kpP14IBeQHK5nLV6gVp2WODY2DGCr3QZ7y78kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nxn2nE1l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739982760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8CgIcE3QwJsFaPpCkGgnCnoYS4A/W2amcUZ6xEWGUo=;
	b=Nxn2nE1lz8pBl0SbCOuKEAxvNtzd7cFsZoWJyNX8omnf+IfKk7P9RxYCvtMd3FGm4oVfy7
	pVx4N2OuEIjESanjortjtoXvYkJ6hvmnoAlyQTfF9cLvJ8EexMWqjxr3imoGTxwUQmBj/m
	ED/0XHKpVnkmw9EteDSfnEy3t0Qkby0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-IHZiPI3nP_SjLZyMvFhpJg-1; Wed, 19 Feb 2025 11:32:39 -0500
X-MC-Unique: IHZiPI3nP_SjLZyMvFhpJg-1
X-Mimecast-MFC-AGG-ID: IHZiPI3nP_SjLZyMvFhpJg_1739982758
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38ddf4fa345so4632677f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739982758; x=1740587558;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q8CgIcE3QwJsFaPpCkGgnCnoYS4A/W2amcUZ6xEWGUo=;
        b=edi4O2YVryuwRQgc7eeq3gYXUCZFmD/I/MS93IMfxilQ8r2WOdPqtNi8oTul7+FjeF
         hzUPfqF8cavCHT/QqKEfqnUwPn1U13sPF6ZqixJAGjWv83v/dDQ4XrYphUeyY1mJ6hrR
         n/FWJFebB7yLif5ToU3uA9M8HBtdyix0rc7yd0iZcz1KUpitHxMHD6JiANHHLH+xfpDi
         ipz4V0oaP+Kg96iZLevUXV0909pj1X2OcFzjDG+s2ekyKDzM951L+sIIuCtbZqsl5q9R
         sb326prBwrnXa1nkpeWHRZFfC+WpS7mlT9KVmzkR0PdkunpJ0yoLXh2SbDW5fXfYI+Hd
         bWMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU33LgkmEmqAczASN1UwvAw6wKoxY8kiBKDSQR/RlNTXtdSH6EdMdw6gfJ2gEWvsn+ngDuGmoNrmHAkwRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQJulO1fuW3PQXbYolb1+L81Ri8bH3kWn/obU1D1M1m5F85wec
	XGNTy9/+bSTTjjq3dkf5Ft1YnV9dbg9g+J3ClApeq0yOtEEuHpS/UcGmGByme0jcQNopfxfIeOL
	bAVhOIkQcZfK70vtewDzG8kzgInlvF5lO2HIPZ3dMlU+w9Ru2ItPS6OK/2RMgyw==
X-Gm-Gg: ASbGncu5zG1kGiZb/4izz5I+FS8QtQmV8eJdvBPBxiM4xCzxOoU6O77FGT6ARsRcLQN
	s58yIwB0mm66XAchHd3HN6lG/WQF3eiMTRXsJX72Xirg8gFfAoIoa/Q9xTjhmVjTK55xDMvK7Qh
	Pm+qxRJTHg7u+7hTo0PI8OfHRjhrmY0n3G1Bx3IOWn0PE4GOl1YYBMe0zjDTwZJ6DOyKwT1E1iF
	8FS0Fr8C/QyDRl/Yu8yqdAyjGND8qnAbWqUg4tRB+QOKBNRloClHbo80DgUtb6FMGzoBIXjtySG
	T/Y=
X-Received: by 2002:a5d:66d0:0:b0:386:3835:9fec with SMTP id ffacd0b85a97d-38f340676d1mr16163505f8f.44.1739982757897;
        Wed, 19 Feb 2025 08:32:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvKPVsH8+ffaanDYO10CBiRBWfP22KMm4t8NJEN1CoxxHA3ngdYS4eiyl+z/MxGvgghgAGsA==
X-Received: by 2002:a5d:66d0:0:b0:386:3835:9fec with SMTP id ffacd0b85a97d-38f340676d1mr16163462f8f.44.1739982757459;
        Wed, 19 Feb 2025 08:32:37 -0800 (PST)
Received: from [127.0.0.1] ([195.174.132.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258cccdesm18262801f8f.26.2025.02.19.08.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 08:32:37 -0800 (PST)
Date: Wed, 19 Feb 2025 16:32:34 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>, linux-mm@kvack.org
Cc: Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>
Message-ID: <86fad2bd-643d-4d3a-bd41-8ffd9389428b@redhat.com>
In-Reply-To: <8fc793e3-cdfc-4603-afe6-d2ed6785ffbb@efficios.com>
References: <20250219113108.325545-1-gmonaco@redhat.com> <20250219113108.325545-2-gmonaco@redhat.com> <8fc793e3-cdfc-4603-afe6-d2ed6785ffbb@efficios.com>
Subject: Re: [PATCH v7 1/2] sched: Move task_mm_cid_work to mm work_struct
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <86fad2bd-643d-4d3a-bd41-8ffd9389428b@redhat.com>



On Wed, 2025-02-19 at 10:13 -0500, Mathieu Desnoyers wrote:
>> On 2025-02-19 06:31, Gabriele Monaco wrote:
>>> > Currently, the task_mm_cid_work function is called in a task work
>>> > triggered by a scheduler tick to frequently compact the mm_cids of
>>> > each
>>> > process. This can delay the execution of the corresponding thread
>>> > for
>>> > the entire duration of the function, negatively affecting the
>>> > response
>>> > in case of real time tasks. In practice, we observe
>>> > task_mm_cid_work
>>> > increasing the latency of 30-35us on a 128 cores system, this order
>>> > of
>>> > magnitude is meaningful under PREEMPT_RT.
>>> >
>>> > Run the task_mm_cid_work in a new work_struct connected to the
>>> > mm_struct rather than in the task context before returning to
>>> > userspace.
>>> >
>>> > This work_struct is initialised with the mm and disabled before
>>> > freeing
>>> > it. Its execution is no longer triggered by scheduler ticks: the
>>> > queuing
>>> > of the work happens while returning to userspace in
>>> > __rseq_handle_notify_resume, maintaining the checks to avoid
>>> > running
>>> > more frequently than MM_CID_SCAN_DELAY.
>>> >
>>> > The main advantage of this change is that the function can be
>>> > offloaded
>>> > to a different CPU and even preempted by RT tasks.
>>> >
>>> > Moreover, this new behaviour is more predictable with periodic
>>> > tasks
>>> > with short runtime, which may rarely run during a scheduler tick.
>>> > Now, the work is always scheduled when the task returns to
>>> > userspace.
>>> >
>>> > The work is disabled during mmdrop, since the function cannot sleep
>>> > in
>>> > all kernel configurations, we cannot wait for possibly running work
>>> > items to terminate. We make sure the mm is valid in case the task
>>> > is
>>> > terminating by reserving it with mmgrab/mmdrop, returning
>>> > prematurely if
>>> > we are really the last user before mmgrab.
>>> > This situation is unlikely since we don't schedule the work for
>>> > exiting
>>> > tasks, but we cannot rule it out.
>>> >
>>> > Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced
>>> > by mm_cid")
>>> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>>> > ---
>>> > diff --git a/kernel/rseq.c b/kernel/rseq.c
>>> > index 442aba29bc4cf..f8394ebbb6f4d 100644
>>> > --- a/kernel/rseq.c
>>> > +++ b/kernel/rseq.c
>>> > @@ -419,6 +419,7 @@ void __rseq_handle_notify_resume(struct ksignal
>>> > *ksig, struct pt_regs *regs)
>>> > =C2=A0=C2=A0 }
>>> > =C2=A0=C2=A0 if (unlikely(rseq_update_cpu_node_id(t)))
>>> > =C2=A0=C2=A0 goto error;
>>> > + task_queue_mm_cid(t);
>>> > =C2=A0=C2=A0 return;
>>> > =C2=A0
>>> > =C2=A0 error:
>>> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> > index 9aecd914ac691..ee35f9962444b 100644
>>> > --- a/kernel/sched/core.c
>>> > +++ b/kernel/sched/core.c
>>> > @@ -5663,7 +5663,6 @@ void sched_tick(void)
>>> > =C2=A0=C2=A0 resched_latency =3D cpu_resched_latency(rq);
>>> > =C2=A0=C2=A0 calc_global_load_tick(rq);
>>> > =C2=A0=C2=A0 sched_core_tick(rq);
>>> > - task_tick_mm_cid(rq, donor);
>>
>> I agree that this approach is promising, however I am concerned about
>> the fact that a task running alone on its runqueue (thus without
>> preemption) for a long time will never recompact mm_cid, and also
>> will never update its mm_cid field.
>>
>> So I am tempted to insert this in the sched_tick to cover that
>> scenario:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rseq_preempt(current);
>>
>> This would ensure that the task runs __rseq_handle_notify_resume() at
>> least each tick.
>>

Right, I thought about this scenario but forgot to add it in the final patc=
h.
We could have a test doing that: instead of sleeping, the task busy waits.

Does __rseq_handle_notify_resume need to run in this case, besides for the =
cid compaction, I mean? Otherwise we could again just enqueu
the work from there.

I'll give a shot for both.


>>> > =C2=A0=C2=A0 scx_tick(rq);
>>> > =C2=A0
>>> > =C2=A0=C2=A0 rq_unlock(rq, &rf);
>>> > @@ -10530,22 +10529,16 @@ static void
>>> > sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
>>> > =C2=A0=C2=A0 sched_mm_cid_remote_clear(mm, pcpu_cid, cpu);
>>> > =C2=A0 }
>>> > =C2=A0
>>> > -static void task_mm_cid_work(struct callback_head *work)
>>> > +void task_mm_cid_work(struct work_struct *work)
>>> > =C2=A0 {
>>> > =C2=A0=C2=A0 unsigned long now =3D jiffies, old_scan, next_scan;
>>> > - struct task_struct *t =3D current;
>>> > =C2=A0=C2=A0 struct cpumask *cidmask;
>>> > - struct mm_struct *mm;
>>> > + struct mm_struct *mm =3D container_of(work, struct mm_struct,
>>> > cid_work);
>>> > =C2=A0=C2=A0 int weight, cpu;
>>> > =C2=A0
>>> > - SCHED_WARN_ON(t !=3D container_of(work, struct task_struct,
>>> > cid_work));
>>> > -
>>> > - work->next =3D work; /* Prevent double-add */
>>> > - if (t->flags & PF_EXITING)
>>> > - return;
>>> > - mm =3D t->mm;
>>> > - if (!mm)
>>> > + if (!atomic_read(&mm->mm_count))
>>> > =C2=A0=C2=A0 return;
>>> > + mmgrab(mm);
>>
>> AFAIU this is racy with respect to re-use of mm struct.
>>
>> I recommend that you move mmgrab() to task_queue_mm_cid() just before
>> invoking schedule_work. That way you ensure that the mm count never
>> reaches 0 while there is work in flight (and therefore guarantee that
>> the mm is not re-used).
>>


Mmh good point, in that case I think we can still keep on testing the mm_co=
unt and return prematurely if it's 1 (we are the only user and the task exi=
ted before the work got scheduled).
That would be a safe assumption if we don't get to 0, wouldn't it?

Thanks,
Gabriele


