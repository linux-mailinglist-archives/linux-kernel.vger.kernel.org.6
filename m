Return-Path: <linux-kernel+bounces-445854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CD09F1C6C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 04:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 282787A045C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 03:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80200335B5;
	Sat, 14 Dec 2024 03:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="odk4xN3m"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E2617579
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 03:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734147612; cv=none; b=OfTZtmr5eUQSh4BH5Sw1hLdYIe9/axLbZoAHAyhbQha48aFxs5WfXx4C8s0y5Hr6+i0uPI54NKJ6zk6vnwcWCUIa+BfyUSFLaepOTC2JoqgyXKt855UNi95ZZmoaK7MQC0cSf2MU74pU/aQ16iQInV+k+325oooWYE/AXFU+sY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734147612; c=relaxed/simple;
	bh=MTlx805+uCZCBFdVf9zvZLYoyMGOLv8zTQCXLL4CFAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDJcQmbryFjf25HcCZzKuExdZuff9Ig/o1ws0vNghCDLIb+S/2xhuS+rfl9vkZIMjzNTnAn27Z9VO2ETStBiOO9fhXvkskc2AQudbpP4anW5WbOQn+vIM+ia8Ezyl9ftMmcVOiIPwVgs1rutHcTOOa0ofOrGIjcFyc+7uwuDfQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=odk4xN3m; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa66ead88b3so443552266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 19:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734147609; x=1734752409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d42LDnldAxN7cOcL4CduttZf2JA1tAALNF0pJ78cn8g=;
        b=odk4xN3m3FlEtlUzSndXtkks3iXBC1P/Kf/33ZB8on0w5MY0f301cA6ffr15TnAqz8
         C7JASoWQXR1bM/k348Osalzl3Kh8XFtRgvHjxK6l/kWx2AoPJyfBoSzduuEuoydEvqFJ
         zJ27EX3Ne2g6uzfF8nitNGwFWtX0OCQTkS/nH+D4vpSmf8i0PF/LWZLj8UE95eg9zglT
         JKmytqAdssqTYnbPcESsiHvk7SH6Rgq1lxGNtxrmZiLF4mG6v1iUf5zPTx6uz5tDfqLR
         HmwNeABS3D7ULNkZGBhtB4jIG/lMFqqxglM0NlS+qUfdiKuU8WDW3Boir+yDyL2EivgT
         vxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734147609; x=1734752409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d42LDnldAxN7cOcL4CduttZf2JA1tAALNF0pJ78cn8g=;
        b=DLkvX1oeTdOnjO/iN559Ue7Ej0m9h3dRGRvrJSppozBJtj9a/Q+TmNH76h/6/DK8N9
         ytIOfC+lZO6g6THI3lUC+1EBZCa1W7zE1P4IA0dcuIe5MwJZ0Z3XbhC9RJYC+SiaDEdh
         t4EKC3aKn2PRzf82iqkduzINHX6Ueo8laZD8fhVh1gKMfawUgqoFjXUmvgXiO7j7z3lU
         iKCGo/4q4as3Rsbb6Fira+m5/sMuQAxG3PqZZgG20H8fzcwj+FoHBrO5mPqVvayAVxmZ
         vnaPe+qoLdjL0+OaYIZ30sQ/cp0xKiwN9N6gRyb/EcuOQhCZWCn/9CmcTtPC81R9cMpA
         eigA==
X-Gm-Message-State: AOJu0Yy9/cB11BV+KknsPXLLI7yDKW2EAsNWoksKWMXKke3p0uFOvlcK
	2Tu/eB2DRP93ZVoOveOC3exoZpRJ/jJYzyXzyiMJb14Oyal8xDzOakXJJR/EpHKqAvcPOCLHO76
	yCYHf+mZj6/hwNztk36iWn5Rp/IdG+n/9eXQ=
X-Gm-Gg: ASbGnctMqiR5k+eVzioj/CaEWyeZ4mRdF2Hls1iu5nWVj3HGwNWcMZAF0t/OVhVqoDs
	/mJWbLCweknFOQd0/fdGMaJ7Z5ajw22Y3ZWKA0ziTfIbmMrgji91Qk9uAlXoJjhbva90=
X-Google-Smtp-Source: AGHT+IGhBRfga1NCBxlPOw94ha5CG+m7Bv41+2azZ1bW7U2A5cC3tnfXdnjbJzpreSBjk9Fz0H542FgFPeevFSEIGR0=
X-Received: by 2002:a17:907:3e91:b0:aa6:6331:936c with SMTP id
 a640c23a62f3a-aab77eb0085mr453133066b.59.1734147609204; Fri, 13 Dec 2024
 19:40:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125195204.2374458-1-jstultz@google.com> <20241125195204.2374458-3-jstultz@google.com>
 <20241213232214.GA17501@noisy.programming.kicks-ass.net>
In-Reply-To: <20241213232214.GA17501@noisy.programming.kicks-ass.net>
From: John Stultz <jstultz@google.com>
Date: Fri, 13 Dec 2024 19:39:57 -0800
X-Gm-Features: AbW1kvY1y25yUMNwHbsBLivm5D55Cq_wgofeiPerhhEOV-rJ8_j5dn1ITXcalm8
Message-ID: <CANDhNCraMepXyQPs1q-aNa+Gh745WpaFPkngA9Eohi9vXRpe+w@mail.gmail.com>
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

On Fri, Dec 13, 2024 at 3:22=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Nov 25, 2024 at 11:51:56AM -0800, John Stultz wrote:
>
> > Also add a blocked_on_state value so we can distinguish when a
> > task is blocked_on a mutex, but is either blocked, waking up, or
> > runnable (such that it can try to acquire the lock its blocked
> > on).
> >
> > This avoids some of the subtle & racy games where the blocked_on
> > state gets cleared, only to have it re-added by the
> > mutex_lock_slowpath call when it tries to acquire the lock on
> > wakeup
>
> If you can remember those sublte cases, I'm sure our future selves
> would've loved it if you wrote a comment to go with these states :-)

Thanks so much for the review feedback! I really appreciate it!

So yes, the description can use improvement here. I at one time had
3-4 separate very fine grained patches (see the top 4 patches here:
https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v7-6.7-rc6-=
fine-grained/?after=3Dc4cad6e353c00254a2dfbb227ef81d8c3827427d+35)
that I rolled into one when sending out(mostly to avoid overwhelming
folks), but the squished commit description isn't as clear.
So if it's helpful I can split this back out?

I'll also add some better comments as well.


> > +static inline void set_blocked_on_runnable(struct task_struct *p)
> > +{
> > +     unsigned long flags;
> > +
> > +     if (!sched_proxy_exec())
> > +             return;
> > +
> > +     raw_spin_lock_irqsave(&p->blocked_lock, flags);
>
> Do we want to make this:
>
>         guard(raw_spinlock_irqsave)(&p->blocked_lock);
>
> ?

Sure, sorry, while I've seen the guard bits, I've not yet really utilized t=
hem.
I'll take a stab at this for v15.

>
> > +     __set_blocked_on_runnable(p);
> > +     raw_spin_unlock_irqrestore(&p->blocked_lock, flags);
> > +}
> > +
> > +static inline void set_blocked_on_waking(struct task_struct *p)
>
> consistent naming would be __set_blocked_on_waking()

Yeah, I started with the unlocked versions and then added the one case
that takes the lock, but that does make it inconsistent. I'll rework
all these. Thanks for pointing this out!


> > @@ -627,6 +628,7 @@ __mutex_lock_common(struct mutex *lock, unsigned in=
t state, unsigned int subclas
> >                       goto err_early_kill;
> >       }
> >
> > +     set_task_blocked_on(current, lock);
> >       set_current_state(state);
>
> blocked_on_state mirrors task-state

Yea. I know I always move a little fast in my talks but at OSPM and
LPC, but I've raised the point that the blocked_on_state very much
seems like it aliases the task->__state.
(See slide 26: https://lpc.events/event/18/contributions/1887/attachments/1=
402/3074/LPC_%20Proxy%20Exec%20deep%20dive%20outline.pdf)

I've not quite worked out how to integrate it though.

My initial introduction of the blocked_on_state was mostly to help
detangle the code, as there were a number of cases originally where in
order to let the task be selected to try to acquire the mutex, we
cleared the task->blocked_on pointer.  But this often ran into races
with ttwu, as if it cleared the blocked_on pointer, the task could get
selected to run before the return migration happened. So having the
tri-state BLOCKED->WAKING->RUNNABLE be explicit helped ensure we
enforced the rules properly so we didn't run on the wrong cpu.

Trying to squish this tristate into the task->__state has eluded me a
bit (mostly due to the lockfree manipulations being a little subtle -
defaulting to RUNNABLE has been usually safe, as the task will just
loop on the condition but with this we really don't want to lose the
signal that we need to do a return migration before the task runs), so
I'd love your insight here.

One thing I've been thinking about is reworking the blocked_on_state
to instead just be a "needs_return" flag. This might simplify things
as we could only set needs_return when we proxy_migrate away from the
task->wake_cpu, so we wouldn't have to handle the WAKING->RUNNABLE
transition for tasks that were never migrated.  And, once it's down to
a single bit, that might work better as a task->__state flag (but
again, it has to prevent transition to TASK_RUNNING until we migrate
back).

Thoughts?


> > @@ -676,16 +686,26 @@ __mutex_lock_common(struct mutex *lock, unsigned =
int state, unsigned int subclas
> >                       break;
> >
> >               if (first) {
> > +                     bool opt_acquired;
> > +
> > +                     /*
> > +                      * mutex_optimistic_spin() can schedule, so  we n=
eed to
> > +                      * release these locks before calling it.
> > +                      */
> > +                     current->blocked_on_state =3D BO_RUNNABLE;
> > +                     raw_spin_unlock(&current->blocked_lock);
> > +                     raw_spin_unlock_irqrestore(&lock->wait_lock, flag=
s);
> >                       trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_=
SPIN);
> > -                     if (mutex_optimistic_spin(lock, ww_ctx, &waiter))
> > +                     opt_acquired =3D mutex_optimistic_spin(lock, ww_c=
tx, &waiter);
>
> I'm confused -- didn't I kill optimistic spinning for proxy? IIRC it
> fundamentally doesn't make sense since we do a hand-off to the donor
> thread.

So, the trouble was killing optimistic spinning with proxy-exec had a
larger performance impact. So around v8 (this time last year, I
think), I worked to re-enable optimistic spinning.

The idea is as long as the lock owner is running, we do the optimistic
spin as there's no benefit to proxy boosting it (the owner is already
running, mission accomplished). But, if it's not on_cpu, then we
consider ourselves blocked, and will go into __schedule() where we can
be selected and boost whomever the chain is waiting on. Then if we are
proxy boosting, on release we can hand it over to the boosting donor.

This feels like it nicely balances the normal non-proxy performance
where possible, only switching into proxy-boosting when things are
going to take longer to release.

> All in all I'm properly confused by this patch... please write
> more/better comments changelog.

Sure, I think it's probably worth splitting it out, so I'll take a
swing at that before v15.

Definitely would appreciate your thoughts on the idea for a
TASK_NEEDS_RETURN __state flag or if you see a more elegant way to put
an intermediate step in place on the wakeup to ensure we don't wake
proxy-migrated tasks on the wrong cpu.

Thanks so much again for the input! Really appreciate the feedback!
-john

