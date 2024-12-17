Return-Path: <linux-kernel+bounces-448571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F052C9F41E0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317BD165984
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 05:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B18145335;
	Tue, 17 Dec 2024 05:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lny16gt6"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B378F77
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 05:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734411700; cv=none; b=MsTCPDgPTXyDMYIkI8Mj3zeSTNy9KSRSB93JFMwYQUtF3GzWF784gl+NRoSGHoIUVidFxHjBF5hg9oCNMa2zdtaCl4GrnfjXZWfFXRp95aX/7rErxz5PqxrMqcO3ak51pKhUqC54LVyGQ7kTRKFngvsRLUcGPF11jqVjbPq4BNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734411700; c=relaxed/simple;
	bh=OpwUEwuHJ4OJxOmVc8v8COqq0NHQoSPIIBHPJt9iUO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJOIXHCSOcfTl4R4NgEsQDH9p7opR6iHgFRVO1xLBUG3R0sKmnqE4ILDKbOlF1t2dkCgf9htNkJFbiB1U12PWaYwAIsw5W5JMZa/ci2S/uQlD3Skq5aZc5p8za+jJLGzjzt6EHKlgrcHJT4tHohtsHgS0t2DuwdvJO3WmTrrAPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lny16gt6; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa6aad76beeso681281166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 21:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734411697; x=1735016497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajdhzWmLQCrCaLfXCLSrq860JSowAhFhFuI7a9oxV5Y=;
        b=lny16gt6aITzxzbMP+jcRRdA+eNvkonF1wdF2/INqfq3eyCiuUyvSuxC04fRnaFeDS
         TyqBuiXp/Katz7I4u1meha6Am70KXuegBGmH5Vcqp0vGObPNdVQADnUrLVIUZxwsHhpH
         jOs1T5Mcn1/nzNy506v0qmhIvq3ZTtHZdsGx0f8o9y1ti5sH1MEOHMtlvec58sRTuXEk
         gSoIofseFJd2wXqDvKP2Zjh7nE6/fuQsNMtE0ixRiwIaydDhR3c50zdo1Rw5FWvsribz
         bXuCmmxESjMVAvgA6otTfIV2V/Jf1KJsGFrw2qZY7yPx0tHJzai1L0KW3PNF+T4KaBv4
         ejvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734411697; x=1735016497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajdhzWmLQCrCaLfXCLSrq860JSowAhFhFuI7a9oxV5Y=;
        b=n85URXWirulDNHOPH5b4kpwllVDiu9/sKns78tMp2LqbRQMm9AgTo4Smt5v6ZuGX+i
         B+ZdAl+MxJvp0oeYNgK3tv2LIqA3UK2kt3iWuqJOuo1dmfTACDwVJ28mFvxUatKw5360
         uNPkSCJOngcPTikORCSZXZg3oRf/bQIaJS8RBpHN6OM2w1uiuy843hG4VyOrcQ3IZCEs
         tQeRYVwcEQGyGWWwfj64R+PUvk9TgsnJPeQglv71ge4BIwAfaiQVonwQYEl5IFeBL/lN
         8D/po2yrcYNsfg8LPABFumqvsAJXzwypHlgpC7QvC9LkpjU5YEXwZJoZcRkMAsBrm+Ai
         toWw==
X-Gm-Message-State: AOJu0YzEq3SJyBLshzUon+aT1nKmKTv+ZhVl1lkfHzQAOR7795KbQOuu
	MRp8H2rCTEIJaA6G3AiI5c7wmZ5f33UxzX3VnqV+lv2+KTNTeHFTa8UMK/RuzsVTZhF6gY04B7q
	ERdvWtDTE8LAXUM4OQXDt9tC6ZJ45pa+Dl7A=
X-Gm-Gg: ASbGncsxrEe7TY84JycM8U6CwOTSKvv5Wn0PM48eavJRzS2Q63T+YsPeavjUNyJ32ws
	FwAFbw72RO+RrkXZCyTWqDwKt6D00OigNChzh+1AhA2Bm5kt3+pSoAI5LxHtxj2uPZas=
X-Google-Smtp-Source: AGHT+IEh62vtUmScKMpxSUABAkkpF29tVHmu3tU1zCY52K8cGDETjJGq1UC+MU8O4iy0CtBGSoDZgGT7/N5QxPNDEgQ=
X-Received: by 2002:a17:907:7205:b0:aa6:a05c:b06d with SMTP id
 a640c23a62f3a-aab77ed4578mr1631214066b.55.1734411696562; Mon, 16 Dec 2024
 21:01:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125195204.2374458-1-jstultz@google.com> <20241125195204.2374458-3-jstultz@google.com>
 <20241213232214.GA17501@noisy.programming.kicks-ass.net> <CANDhNCraMepXyQPs1q-aNa+Gh745WpaFPkngA9Eohi9vXRpe+w@mail.gmail.com>
 <20241216165419.GE35539@noisy.programming.kicks-ass.net>
In-Reply-To: <20241216165419.GE35539@noisy.programming.kicks-ass.net>
From: John Stultz <jstultz@google.com>
Date: Mon, 16 Dec 2024 21:01:24 -0800
X-Gm-Features: AbW1kvbxkRP-PzP9_D_XzKtqXiUozjAOnwnxAyY-as2OZjEdAhqsHy9acKTPslo
Message-ID: <CANDhNCpTfZFOkUkB4f4iQwXA3wnsDuUA_1ZLuseGYunnpgO9Rw@mail.gmail.com>
Subject: Re: [RFC][PATCH v14 2/7] locking/mutex: Rework task_struct::blocked_on
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	"Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 8:54=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> On Fri, Dec 13, 2024 at 07:39:57PM -0800, John Stultz wrote:
> > On Fri, Dec 13, 2024 at 3:22=E2=80=AFPM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > > On Mon, Nov 25, 2024 at 11:51:56AM -0800, John Stultz wrote:
> > So yes, the description can use improvement here. I at one time had
> > 3-4 separate very fine grained patches (see the top 4 patches here:
> > https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v7-6.7-=
rc6-fine-grained/?after=3Dc4cad6e353c00254a2dfbb227ef81d8c3827427d+35)
> > that I rolled into one when sending out(mostly to avoid overwhelming
> > folks), but the squished commit description isn't as clear.
> > So if it's helpful I can split this back out?
> >
> > I'll also add some better comments as well.
>
> Not sure yet about splitting back out -- let me try and figure out what
> all is actually done / needed.
>
> So blocked_lock started out as another lock around ttwu(), in order to
> serialize the task wakeup vs reading a remote ->blocked_on relation.

I think of it primarily to serialize the task->blocked* state (there
gets to be quite a bit by the end of the proxy series).

> Since we do this with rq->lock held, it can't be ->pi_lock, and hence
> ->blocked_lock was born.

Yeah, we needed to use something other than the task->pi_lock to
serialize it as it has to nest under the mutex->wait_lock.

> Later patches appear to have moved it into mutex, mirroring the
> ->wait_lock -- this is probably better.
>
> /me goes chase that state thing for a bit..

? I'm not sure I followed this.  The blocked_lock continues to
serialize the task->blocked* state through the patch series.


> > > > @@ -627,6 +628,7 @@ __mutex_lock_common(struct mutex *lock, unsigne=
d int state, unsigned int subclas
> > > >                       goto err_early_kill;
> > > >       }
> > > >
> > > > +     set_task_blocked_on(current, lock);
> > > >       set_current_state(state);
> > >
> > > blocked_on_state mirrors task-state
> >
> > Yea. I know I always move a little fast in my talks but at OSPM and
> > LPC, but I've raised the point that the blocked_on_state very much
> > seems like it aliases the task->__state.
> > (See slide 26: https://lpc.events/event/18/contributions/1887/attachmen=
ts/1402/3074/LPC_%20Proxy%20Exec%20deep%20dive%20outline.pdf)
> >
> > I've not quite worked out how to integrate it though.
> >
> > My initial introduction of the blocked_on_state was mostly to help
> > detangle the code, as there were a number of cases originally where in
> > order to let the task be selected to try to acquire the mutex, we
> > cleared the task->blocked_on pointer.  But this often ran into races
> > with ttwu, as if it cleared the blocked_on pointer, the task could get
> > selected to run before the return migration happened. So having the
> > tri-state BLOCKED->WAKING->RUNNABLE be explicit helped ensure we
> > enforced the rules properly so we didn't run on the wrong cpu.
>
> Right, so we already have a TASK_WAKING state, that is that
> intermediate. But let me try and get a feel for how things relate;
> TASK_WAKING is after we've determined it is elegible for wakeup, but
> before it is enqueued -- eg. it sits on the wakelist.
>
> This BO_WAKING is not quite that. It happens before doing the actual
> wakeup.

Right. So BO_WAKING is set from the point that the mutex unlock (or
ww_mutex_wound/die code) tries to wake up a task, as the task may have
been proxy-migrated, so we need to return it back before it runs.
So it's sort of a guard to make sure __schedule() doesn't just run the
task (as we could if it were BO_RUNNABLE), but also that we don't try
to proxy for it (as we would if it were BO_BLOCKED), since it needs to
be migrated.

My suspicion is reframing BO_WAKING as TASK_NEEDS_RETURN might be
doable, but I couldn't be sure we wouldn't hit an edge case where
TASK_RUNNING gets written over everything - effectively clearing the
guard.
Maybe the NEEDS_RETURN could just be a side state similar to the
blocked_on_state, and then BO_BLOCKED vs BO_RUNNABLE would just be
distinguishable by the !!task->blocked_on value.

> Also, when I pull your proxy-exec-v7-6.7-rc6-fine-gained and put that
> next to your slides, I'm a little confused.

So, apologies for the confusion. The link I sent you to the
fine-grained changes are a bit old (v7), since I stopped maintaining
the fine-grained patches around v11 (and the most recently shared
version is v14).
I just shared the v7 link as an example to see if it would be helpful
to split the patches here out again in a similar fashion (and I don't
think I published later versions of the fine grained series).

> Specifically, slide 27 talks about a modification to try_to_wake_up() in
> order to force the task into ttwu_runnable() such that it then hits
> proxy_needs_return(). This latter part I can find, but not the former.
>
> /me puzzles

So the slides actually have links to the code at that time, which
should be the v12 series:
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v12-6.11-=
rc5

And the try_to_wake_up() change from slide 27 is here:
https://github.com/johnstultz-work/linux-dev/commit/cc828a6bac87dcd57349020=
21973659fe52ef7e6#diff-cc1a82129952a910fdc4292448c2a097a2ba538bebefcf3c0638=
1e45639ae73eR4158

(and here's the link to the v14 version of the same:
https://github.com/johnstultz-work/linux-dev/commit/602a4197c83b83cff08c7ad=
da31324739c7938c7#diff-cc1a82129952a910fdc4292448c2a097a2ba538bebefcf3c0638=
1e45639ae73eR4314
)

> Hmm, since a blocked task is on the runqueue and all that, you should
> always walk that path, anything else would be buggy.
>
> So fundamentally the problem is that you want to do a reverse migration
> -- it needs to go back to a CPU where it is allowed to run. The way it
> does this is to dequeue itself and let ttwu continue and clean up the
> mess.

Yep.

> This all makes sense, but why can't you do this on the waking side? That
> is, instead of setting BO_WAKING, do this whole if (!is_cpu_allowed())
> deactivate_task() thing right there, before issuing the wakeup.
>
> Notably, that sched_proxy_exec() block in __mutex_unlock_slowpath():
>
>  - probably doesn't need current->blocked_lock, current isn't blocked
>
>  - probably doesn't need lock->wait_lock, donor is stable under
>    preempt_disable().
>
>
> Something like the completely untested below (also, ttwu path needs
> surgery now):
>
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 2711af8c0052..47cfa01cd066 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -946,32 +946,11 @@ static noinline void __sched __mutex_unlock_slowpat=
h(struct mutex *lock, unsigne
>         }
>
>         preempt_disable();
> +       next =3D proxy_handoff(lock);
> +
>         raw_spin_lock_irqsave(&lock->wait_lock, flags);
>         debug_mutex_unlock(lock);
>
> -       if (sched_proxy_exec()) {
> -               raw_spin_lock(&current->blocked_lock);
> -               /*
> -                * If we have a task boosting current, and that task was =
boosting
> -                * current through this lock, hand the lock to that task,=
 as that
> -                * is the highest waiter, as selected by the scheduling f=
unction.
> -                */
> -               donor =3D current->blocked_donor;
> -               if (donor) {
> -                       struct mutex *next_lock;
> -
> -                       raw_spin_lock_nested(&donor->blocked_lock, SINGLE=
_DEPTH_NESTING);
> -                       next_lock =3D get_task_blocked_on(donor);
> -                       if (next_lock =3D=3D lock) {
> -                               next =3D donor;
> -                               donor->blocked_on_state =3D BO_WAKING;
> -                               wake_q_add(&wake_q, donor);
> -                               current->blocked_donor =3D NULL;
> -                       }
> -                       raw_spin_unlock(&donor->blocked_lock);
> -               }
> -       }
> -
>         /*
>          * Failing that, pick any on the wait list.
>          */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 6eaffa913495..30d7371bb5c4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4035,6 +4035,53 @@ static inline void activate_blocked_entities(struc=
t rq *target_rq,
>  }
>  #endif /* CONFIG_SCHED_PROXY_EXEC */
>
> +struct task_struct *proxy_handoff(struct mutex *lock);
> +{
> +       struct task_struct *next;
> +
> +       if (!sched_proxy_exec())
> +               return NULL;
> +
> +       /*
> +        * current->blocked_donor can't change if we can't schedule
> +        * caller needs to do this, since its needs stabiliy of return va=
lue
> +        */
> +       lockdep_assert_preemption_disabled();
> +       next =3D current->blocked_donor;
> +       if (!next)
> +               return NULL;
> +
> +       scoped_guard (task_rq_lock, next) {
> +               /*
> +                * current->blocked_donor had better be on the same CPU a=
s current
> +                */
> +               WARN_ON_ONCE(scope.rq !=3D this_rq());
> +
> +               scoped_guard (raw_spin_lock, next->blocked_lock) {
> +                       /*
> +                        * WARN_ON on this? How can this happen
> +                        */
> +                       if (next->blocked_on !=3D lock)
> +                               return NULL;
> +               }
> +
> +               /*
> +                * blocked_on relation is stable, since we hold both
> +                * next->pi_lock and it's rq->lock
> +                *
> +                * OK -- we have a donor, it is blocked on the lock we're=
 about
> +                * to release and it cannot run on this CPU -- fixies are
> +                * required.
> +                *
> +                * Dequeue the task, such that ttwu() can fix up the plac=
ement thing.
> +                */
> +               if (!is_cpu_allowed(next, cpu_of(scope.rq)))

nit, we'd want to check its not the wake_cpu so we try to return it so
proxy migrations don't upset the tasks' original placement

> +                       deactivate_task(scope.rq, next, DEQUEUE_SLEEP);
> +       }
> +
> +       return next;
> +}
> +

Ok. I'll stare at all this a bit and see if I can give it a try.  I
fret that this doesn't handle the case if wakeups on the task occur
through other code paths? (So we still need BO_WAKING/NEEDS_RETURN to
prevent us from running until we migrate back). I don't really have a
specific case I can articulate, but my gut is telling me the problem
will be w/ ww_mutexes as that was a major source of problems with the
early versions of the patches that I believe tried to use logic
similar to this.

Again, I really appreciate your insight and suggestions here!

thanks
-john

