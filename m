Return-Path: <linux-kernel+bounces-212491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 544DC9061B5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 04:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0DE1C210BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 02:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C4256B81;
	Thu, 13 Jun 2024 02:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7eeiBWb"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B45A79DF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 02:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718245488; cv=none; b=QYHGlarlUeu1pmZj+Phqar3t5FrGF+jp+JczLxK2ActengSyU+4Pb5j0dPsAUStSfCv756C2S7UVPeoLX+aoi0KHTC2kkX+lJPlxu/KfqrWolcR7uSs6HDAPz7MEoQoc/O4ChGjWknu0iv1XxAoHRwULv6QyAp2kNF5zqfX49Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718245488; c=relaxed/simple;
	bh=nQSDzkkcHc4KoR0HboNNjA7Du1MuVa66UqM62dOnI7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEBjWvhDOlS5orX5g19z+pYUaeMCYH53C1BznViUoELzSjYZRp9LfYs1bt29tB3fa1IBh3tnZl1eV8NS2wHtBKtJ9LWZyG4++5zIE6RProMdykwxdy6c4tqclXhibWeI6Dpv/MG6WjaoVIJmJ/Dpez1hwPbs9x6iEZUU/zxWNCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7eeiBWb; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e724bc466fso4864841fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 19:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718245485; x=1718850285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1KteaWaZgKavbn9Wh1QwkrZVExG0QgqzeKy+h5te8M=;
        b=e7eeiBWbXxvH2iljtPY/0y2SBKrifnFoAGsOwR/NHekHmPZB/2cW8t5qKnlWBG3c5q
         5Uu8U3r7fkR3e4wMdn7PSIM5kgQvwX7Iu2xo6AeJxIMjxXwpSIJXn6aadbg6KAXEAYfj
         EP5LCTFBTXC0tmg81llR8wF4Gby5UOl6cjc9F+guX7youX8A9d5C/e/M36RHIsPioues
         vmbCcMIgYjgckNKx9RCDzeCDqxDYcGxrYGhMTul84EKVPSduWHh5k5OLEJky0Zhj2dVE
         yYj75pGxJi/aP8Z6Kgkb6JDHtmZCSBDt3PrBFA8lDKlc9M1KrqGKkqzdKwTUT5bMzuCg
         QGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718245485; x=1718850285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1KteaWaZgKavbn9Wh1QwkrZVExG0QgqzeKy+h5te8M=;
        b=aL4B+cV03h0EaEPAq3rwOqfalxe5uZFaa88AnxDGwpWRJpKre0biKtHJ6w3cJURyKX
         uY7Gnk+nHcB3DL2HQSCBeNxtz1vYNXd/br5bW8eLVNqQ+RWuwEtbO6x0TTA88+TuEOoj
         PHay10vLLgmGokrE0umwxcdcIGBCQEh497VHfjoPdFyNKvIT9XvjgNk2GjLevEhDX8h5
         rlT9yRmaNML8e8RV3Voz/zXaIibB/LQRM6ywrPWQc0K5L8P81kknzQXkYOGq+fvzQpHG
         9BnqZU1uriaHhKPESPR5b/PbKikXBbepUk2JGoy+Nm4QaqgNrrtXH4f66FXEAbIZz32q
         zBoA==
X-Forwarded-Encrypted: i=1; AJvYcCUmzMggXLuU7BjfncLS7yf+G8dmjvqJNCiOwR5BvneaqgqKqImd4oHtbRT/zDaZ/BIyl6SbMs7UD7Oecd+tj51d8zDVilMTpoKZMTR4
X-Gm-Message-State: AOJu0Ywp+5bl4oQdzI8OtkYqKtvMFqerco+Nox8C0iA12jbp/bvmaB0j
	rO8NXlhx3VwpcaoNzHaIONrfWyhxnm/XOyYf7i1l2FwQF88ez8WGfSBqVvlIAsvfwREeXd6KBa3
	dzgzwwLu0WEQ0XPb3H2CkXJQ1Y/Q=
X-Google-Smtp-Source: AGHT+IGLYT5yFPodZkpUfYOABtOfThfcn8u3cz0imjJ0oJQbzXKHU2fPfLOTjT5b4XSzunhV1hlv1VNen10MrTtmivA=
X-Received: by 2002:a2e:90d9:0:b0:2eb:db67:6101 with SMTP id
 38308e7fff4ca-2ebfc90518fmr27759721fa.13.1718245484854; Wed, 12 Jun 2024
 19:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530122401.3826022-1-zegao@tencent.com> <20240530122401.3826022-2-zegao@tencent.com>
 <ZmONvY8q_lVOdjvu@pavilion.home>
In-Reply-To: <ZmONvY8q_lVOdjvu@pavilion.home>
From: Ze Gao <zegao2021@gmail.com>
Date: Thu, 13 Jun 2024 10:24:33 +0800
Message-ID: <CAD8CoPBJuObvgZT3kzap8j4D+o3fh=PTJJm9_ZhZfJqPP7WtsQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] timer: Use is_idle_task() check instead of
 idle_cpu() on irq exit
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, 
	Cruz Zhao <CruzZhao@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

Thanks for your reply and even more thanks for the detailed comments
and elaboration.

On Sat, Jun 8, 2024 at 6:46=E2=80=AFAM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> Le Thu, May 30, 2024 at 08:24:00AM -0400, Ze Gao a =C3=A9crit :
> > idle_cpu() was initially introduced in irq_enter()/exit() to check
> > whether an irq interrupts an idle cpu or not since commit
> > 79bf2bb335b8 ("[PATCH] tick-management: dyntick / highres functionality=
")
> > and at that time, it's implemented via a simple check if the curr
> > of task of that rq is idle or not. And then commit 6378ddb59215 ("time:
> > track accurate idle time with tick_sched.idle_sleeptime") uses the same
> > check to do accurate idle time accounting.
> >
> > But since commit 908a3283728d ("sched: Fix idle_cpu()"), idle_cpu()
> > takes scheduler stats into consideration and becomes more constrained,
> > and therefore it tells more than if we have interrupted an idle
> > process but also whether a cpu is going to be idle or not since it
> > takes queued tasks and queued to be woken tasks into account.
> >
> > However for tick user, it is too much as now we only rely on this check
> > to do nohz idle time accounting in tick_nohz_start_idle() just in case
> > that tick_nohz_stop_idle() is called upon irq_enter() if we actually
> > rupture an idle cpu(process). The use of idle_cpu() simply complicates
> > things here, and the introduction of sched_core_idle_cpu() in
> > commit 548796e2e70b ("sched/core: introduce sched_core_idle_cpu()")
> > proves this.
> >
> > The use of is_idle_task() just like in commit 0a8a2e78b7ee ("timer: Fix
> > bad idle check on irq entry") helps to save one unnecessary fix for idl=
e
> > time accounting for the newly force idle state. Note this also preps fo=
r
> > the remove of sched_core_idle_cpu() in the following patch.
> >
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > ---
> >  kernel/softirq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > index 02582017759a..24c7bf3c3f6c 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -617,7 +617,7 @@ static inline void tick_irq_exit(void)
> >       int cpu =3D smp_processor_id();
> >
> >       /* Make sure that timer wheel updates are propagated */
> > -     if ((sched_core_idle_cpu(cpu) && !need_resched()) || tick_nohz_fu=
ll_cpu(cpu)) {
> > +     if ((is_idle_task(current) && !need_resched()) || tick_nohz_full_=
cpu(cpu)) {
>
> The reason why there is a check here for idle_cpu() (or sched_core_idle_c=
pu())
> is to avoid calling again tick_nohz_start_idle() and then again
> tick_nohz_stop_idle() later from tick_nohz_idle_exit(). This can save two=
 costly
> calls to ktime_get() when a real task is waiting for the CPU. So any quic=
k clue to
> know if a task is going to be scheduled is good to get. And idle_cpu() gi=
ves
> them all:
>
> int idle_cpu(int cpu)
> {
>         struct rq *rq =3D cpu_rq(cpu);
>
>         if (rq->curr !=3D rq->idle)
>                 return 0;
>
> // This is the necessary is_idle_task() check
>
>         if (rq->nr_running)
>                 return 0;
>
> // This tells if there is a real task pending. Ok that check
> // is perhaps a bit redundant with need_resched()...
>
> #ifdef CONFIG_SMP
>         if (rq->ttwu_pending)
>                 return 0;
> #endif
>
> // This one tells if there is a remote wakeup pending for this CPU.
> // And need_resched() doesn't tell about that yet...

Please correct me if I'm stupid here.

Is it possible that there is a time window between this becoming true and
schedule_idle(), which is TIF_NEED_RESCHED is not set in time and this CPU
will be doing arch idle again? If so, we're actually counting less
idle time than it is.

I will test if this is true and provide statistics later. Appreciate
your attention again:)

Thanks,
Ze

>         return 1;
> }
>
> So it looks to me that idle_cpu() is still a good fit at this place.
> And sched_core_idle_cpu() doesn't bring more overhead since the static
> key in sched_core_enabled() is rarely active (I guess...). And if it is,
> then the check is even more simple.
>
> Thanks.
>
> >               if (!in_hardirq())
> >                       tick_nohz_irq_exit();
> >       }
> > --
> > 2.41.0
> >

