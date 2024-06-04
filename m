Return-Path: <linux-kernel+bounces-201292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6097D8FBCA0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180792841D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846CE14B07E;
	Tue,  4 Jun 2024 19:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="szbjZZPs"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC45B644
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717529610; cv=none; b=nlXLD7RsctAFoEMHRyTc1Lp1ADunP9DJFkVfPgJH8gHyoUAryF6H9m4gruYYxGFSu0KbxWI2TLbiVQD3LsH97xbi7NdqvgBQ3aZUF/odjMcI4k33WnmJaq8AkfP/jQOYlub2BEQl7otwUflr+QXpXnyAi/NMLVUNKZSwSYNYibs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717529610; c=relaxed/simple;
	bh=vgdxlTZ9zAtW+udxA8m6PAK22JHwIYNVn5vlP5QV7to=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThgVIc8tsyQ2g4w8e1oULgyi7hyecGo3DT7CGqp+cOxRkYrMv5b/f+GDxK0K3tf6tSfi4OoilyfIGHfk1vWx4aJFXvZ1LOwDlZmnT9FylU9TrM7tGpuJ1aJoW9MERBvqBGyHjlntZvFaGioeQZXcqaJ6FYIglGzjjmvxP+d+X0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=szbjZZPs; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42135a497c3so24545e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 12:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717529607; x=1718134407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6u4W0V48gzoTjx+GgS8SoKFrcT3JitnB4OcgYHGtwKE=;
        b=szbjZZPspA1L/yAfHDjMCfBrhyyX8LtbPkeOLFWA3MaJSLkM8iv3/HdeB1OhW6Z89c
         1MK8Lw4CePz2ftcLTG+TbTewi7j/Jzubbfvqa3VfBzo772J25vfp08IAgE4UE/+vnIGy
         xkUADcg+d0aj57vNuZ6vOhBoZQFZytodqwexzZ4Z0VcUm4fe+YRIC3xbzzB5eIvsvmUO
         ZOMpjwndC8mobPBmYWUSDkpeifPT9yOjv3jXlvtaW3ihq7Rmny4Pkl4zLL27UPjeolZ9
         fa8/rb1W9grsfd6Moihzy4gEwtBZpUtMQ+Bqb7VMpjMbksrjI8bHh4Z5WbyW2jXSidUM
         Nnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717529607; x=1718134407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6u4W0V48gzoTjx+GgS8SoKFrcT3JitnB4OcgYHGtwKE=;
        b=tZ21EdtSMVLjiNDfrFHSji3iVs/orgAUSWAkEOuDjGWPujU7P1rFUekXb5qg1kgEyu
         hZTJQSwug9r7mAlZVQPL3lR+IIr58Y8QcS3RaRXSWKS0tuh3PlzFyzxxEqUQNrV2mji6
         eJYFec0UoQErI/k/1fopid/V/GfaBipJHK/EVhQT/2L7BueS77cd25jJe6Khiqr3Buc1
         DBvQ0LFqWdO52eAJHIDqbFNFL2PdhfdSDdLamA/xnN+4RkNIAp6ngfke3HLp5mH/Umu1
         LUA5WLyhdLb2YA2GFjl0Cz3eey+epby22dVX/cmwgsjqhzaxDvbK0mZm0jxrf9hsOZ0K
         Q7jA==
X-Gm-Message-State: AOJu0YwORNNxC8Mu2QF6jlG0Fc+wiQcnZfu+QPh2q/DUVS716LcLtQeb
	N+MonqnfVsH0RUVtvDip1OJmagZNvMmOVy5TZ7E9pPquomc7acP32VpFVA0Hss73zcF5eSAClt6
	mFlyW4EmkIm5laEgsrNnjLR4TOeQY1xdIozU=
X-Google-Smtp-Source: AGHT+IEguA7ci4IQoa7s9OhrhwKylnWarPFnJ+m0ihTS3IrNE6auL4B6uKUrRjEEGqnhNfOoc8N7yHFfTKYKH7HLXhE=
X-Received: by 2002:a05:600c:2104:b0:418:5aaa:7db1 with SMTP id
 5b1f17b1804b1-421571d2366mr276055e9.1.1717529606869; Tue, 04 Jun 2024
 12:33:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507045450.895430-1-jstultz@google.com> <20240507045450.895430-8-jstultz@google.com>
 <20240604141103.idwodwyeecml4keh@airbuntu>
In-Reply-To: <20240604141103.idwodwyeecml4keh@airbuntu>
From: John Stultz <jstultz@google.com>
Date: Tue, 4 Jun 2024 12:33:13 -0700
Message-ID: <CANDhNCrDqK=hmK3w5P74twM6YFPhp9VKsvSfbcGh1xwO1PjHNQ@mail.gmail.com>
Subject: Re: [PATCH v10 7/7] sched: Split scheduler and execution contexts
To: Qais Yousef <qyousef@layalina.io>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Joel Fernandes <joelaf@google.com>, Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Metin Kaya <Metin.Kaya@arm.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, 
	"Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 7:11=E2=80=AFAM Qais Yousef <qyousef@layalina.io> wr=
ote:
>
> On 05/06/24 21:54, John Stultz wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > Let's define the scheduling context as all the scheduler state
> > in task_struct for the task selected to run, and the execution
> > context as all state required to actually run the task.
> >
> > Currently both are intertwined in task_struct. We want to
> > logically split these such that we can use the scheduling
> > context of the task selected to be scheduled, but use the
> > execution context of a different task to actually be run.
> >
> > To this purpose, introduce rq_selected() macro to point to the
> > task_struct selected from the runqueue by the scheduler, and
> > will be used for scheduler state, and preserve rq->curr to
> > indicate the execution context of the task that will actually be
> > run.
>
> This is subjective opinion of course. But I am not a fan of rq_selected()=
.
> I think we are better with more explicit
>
>         rq->currs       /* current sched context */
>         rq->currx       /* current execution context */

Yeah. While I've got my own opinions, I'm very flexible on names/style
details if maintainers want it any specific way.

But just personally, this strikes me as easier to misread, and not as
descriptive as the "selected" vs the "executing" task.

> and the helpers
>
>         task_curr_sctx()
>         task_curr_xctx()

Though would rq_curr_sctx() and rq_curr_xctx() make more sense, as
it's a property of the runqueue (not the task)?

> This will ensure all current users of rq->curr will generate a build erro=
r and
> be better audited what they are supposed to be. And I think the code is m=
ore
> readable this way.

So earlier I had changed it to: rq_curr() and rq_selected(), but Peter
complained about the rq_curr() macro making things indirect, so I
dropped it (though I kept the rq_selected() macro because it allowed
things to collapse down better if SCHED_PROXY_EXEC was not
configured).  I do agree the macro (along with renaming the field)
helps ensure each use is considered properly, but I also want to align
with the feedback Peter gave previously.

> Another way to do it is to split task_struct to sched and exec context (r=
ather
> than control the reference to curr as done here). Then curr would be alwa=
ys the
> same, but reference to its sched context would change with inheritance.
>
> ie:
>
>         struct task_sctx {
>                 ...
>         };
>
>         struct task_struct {
>                 struct task_sctx *sctx;
>                 /* exec context is embedded as-is */
>                 ...
>         };
>
> Which means would just have to update all accessors to sched context to d=
o
> extra dereference. Which I am not sure if a problematic extra level of
> indirection.
>
> I see the latter approach  more intuitive and explicit about what is a sc=
hed
> context that is supposed to be inherited and what is not.

Hrm. So I think I see what you're saying. Particularly with the logic
where we sometimes care about the execution context and sometimes care
about the scheduler context, I can understand wanting to better define
that separation with structures.  One thing to note from your example
above for unblocked tasks, the scheduler and execution contexts can be
the same. So you'd likely want the task_struct to not just have a
reference to the scheduler context, but its own internal scheduler
context structure as well.

That said, I'm not sure if adding the current scheduler context
reference into the task struct as you propose above is the right
approach. Particularly because while this is a generalization of
priority inheritance, it isn't actually implemented in the same way as
priority inheritance.  We don't raise and lower the lock owner task's
priority.  Instead we pick a task from the rq, and if its blocked, we
traverse the blocked_on chain to find the runnable owner.  So the two
are really properties of the rq and not really part of the task. And
remember there can be multiple blocked waiters on a mutex, and they
can both be used to run the lock owner. So one would have to be
setting the owner's scheduler context reference on each selection,
which seems a bit noisy (I also will have to think about the
serialization as you may need to hold the rq lock to keep the donor's
sched context in place (as your crossing task to task), which might be
an unintuitive/unexpected dependency).

Instead as the two contexts are really attributes of the runqueue, it
would seem like one could have what is currently rq_selected() just
return the struct task_sctx from the selected task (instead of an
entire task), but that might also cause some annoyance for things like
debugging (as having both selected and current task's comm and pid
available together are very useful for understanding what's going on).

> I generally think breaking down task structure would be good. Hopefully t=
he new
> data perf can help us make better decision on what attributes to group
> together. And generally this might be a good exercise to rethink its cont=
ent
> which grown organicaly over the year. Maybe we want to create similar suc=
h
> smaller wrapper structs for other fields too.
>
> I **think** with this approach we would just need go fix compilation erro=
rs to
> do p->sctx->{attribute}.
>
> Proxy exec later would only update the reference to this struct to enforc=
e
> inheritance for rq->curr->sctx to point to the donor's context.

I'll need to think about this a bit more (and hopefully others can
chime in on if they see it as worth it). It would be a *lot* of churn
to tweak all the users to have the extra structure indirection, so I'm
hesitant to go running after this without wider agreement. But I do
see there would be some benefit to avoiding some of the confusion that
can come from having to deal with two full separate tasks in much of
the logic.

thanks
-john

