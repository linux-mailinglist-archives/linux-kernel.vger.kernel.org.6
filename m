Return-Path: <linux-kernel+bounces-437745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C10F9E97F7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE6A162A8C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65E61A23AD;
	Mon,  9 Dec 2024 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="GtqXsS2U"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17BF23313A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752618; cv=none; b=MWMg9cULxYX+D2TSz9urfOXsBSzddZhxLzNsaId6XrsqaQGWBt1N37mfsBqyUL7TfweV2HHljoe6RVuszgOz46uLhgkGqIxlZ8WPtatJMXtnQXJofPbphrgjXnVX/R50ToCZ0iIY09ZQZd3x+Tk5cVyARD2/Hgz7KPTxs5o0qOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752618; c=relaxed/simple;
	bh=oHNroCtjsd+esuEWfwLQ2kk7DldTQB0cG8SzktBLVqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtCa1jXwu6TIfk27iIVV7uVxTWVw4Bop2cXMSssJkY+Mym4zdQgWz8ER7qla+u7VWjvY27hPehfa+nUT5pW7Dl1oFaLtcklEvLR6wcdph1ke4/tJZLO/fhr5D7E9M15JsEyWJVM6H8DQa8miRHVzjafl6LMzXXSzLgGXlWt7/fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=GtqXsS2U; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f0054cb797so10585997b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 05:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1733752614; x=1734357414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPgXRhytYkzwLb3kRdbmN8bdYqkD9uyRNJIQsnPnMCg=;
        b=GtqXsS2UxIZNe22spccsDNeYbkRMH4D8KKxEPvMx3Vw4nvsEuZMcJPJwR//LTiX1sR
         v0HnUiQ5PpDoW5ZC8NI39eF2JwUsF8ea5/6N1Nzwgl9OVQqT/+vN6aZvvhSx74POKMdB
         qc+A3QPdmWonghSQuGWiDl6RIbLIAELpOd1beIVAvbjkkQpqE3/kAbbeqvPy42Jv3uaI
         L7RHJQKmG1Bd6wFAgml/JUE2qu6Nzgc80xete3AfrGaLVTARn28HKdTcHddrSyGfRfFw
         4RFtTm60/M88hpOGrT4QbGFZinCy92yF0LcYozvjEjftps5RN8vDY+41OZLEWcGCRxA8
         W3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733752614; x=1734357414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPgXRhytYkzwLb3kRdbmN8bdYqkD9uyRNJIQsnPnMCg=;
        b=kIjNhYVJOCFWr11NcpyIgtk9HQvZv9AyVYJd2rsI6QV4fcHHHIWRU3uof9D+FY13OU
         loujtGlG/a8o+vEV89VV8QFiMClS8kAL8kvCNwioxoANRG3TpYsXvCyk/b9ptLZg/MuX
         e6Xpi/dFXABJsD9whPDQWpCzAZ+mN/uLMHH3emnzAlJlDfVBuIvHj7f23ap74pQSvoBb
         tXLl3jlzaySx9va12/mM133yfcgfpXYEXxyJlISK9ScttFsaGDhsb/jZDUvMirxv7Quq
         CMZOGKFYbo9v+pgQ8SfkfIjd+KjnZEz+8txs5nocchBdS0yQHXyt1Zlr1UXeaSeV1tdf
         ffXw==
X-Forwarded-Encrypted: i=1; AJvYcCV22SXHcK4ck/pO4Qgs09Xku4tqZnDXxTgIMR+vhxNWFm1PO2dvytLerxXdHhGpy8iFhHrwq5z72JX664o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPXyAwPhfK8M54C70q/0bdpSBIko7kSk0MCcSoDMVKuxNyDCNu
	W9NaTvCsGZXL7VSrUSZDGMbgXzVCX/HqK89kJIx6YHuWEo7wlMkOSC+jUV+axsQ2QKnLC8XrUw7
	VZ0qcKuShc3tMnuE0R21PrBAVpBSicpTel0nK6Q==
X-Gm-Gg: ASbGncvUQo6HN78p6C7RQcw83Un1vHsilk/MKd87Gy8g2IppseMEadqdKjhUDKpPFen
	fXjB7AhanVfcIZssr+KoqCyYv4NO0W4c=
X-Google-Smtp-Source: AGHT+IEGm2BmjiIyGYAEjv/5OcK/7WQQ1Ja4aL3yNrtHPDLo79ej0eXW7pVkFQ71kcSW3TNwp1eOlcATEJHGvloIzgs=
X-Received: by 2002:a05:690c:7347:b0:6ef:4e42:64d0 with SMTP id
 00721157ae682-6f022e73ed9mr5050867b3.11.1733752614595; Mon, 09 Dec 2024
 05:56:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <571b2045-320d-4ac2-95db-1423d0277613@ovn.org> <20241206151819.GA3949140@google.com>
 <CAO7JXPhdv+Jx_UpAq=-aG-BKwiyjZ2kvuZDM4+GLjbya_=ZJsw@mail.gmail.com>
 <20241209105514.GK21636@noisy.programming.kicks-ass.net> <CAO7JXPgSYCzu0mtnWqBaS8ihmoQXX3WE_Yb_rEYuMeQn+B6KJg@mail.gmail.com>
 <20241209125601.GQ35539@noisy.programming.kicks-ass.net>
In-Reply-To: <20241209125601.GQ35539@noisy.programming.kicks-ass.net>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Mon, 9 Dec 2024 08:56:43 -0500
Message-ID: <CAO7JXPj6_VF+T1ykwQsCmBjVhHQdpX0wJssPPRYOazJcciCCyA@mail.gmail.com>
Subject: Re: [v6.12] WARNING: at kernel/sched/deadline.c:1995
 enqueue_dl_entity (task blocked for more than 28262 seconds)
To: Peter Zijlstra <peterz@infradead.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, Ilya Maximets <i.maximets@ovn.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, vineethrp@google.com, 
	shraash@google.com, marcel.ziswiler@codethink.co.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 7:56=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Mon, Dec 09, 2024 at 07:29:52AM -0500, Vineeth Remanan Pillai wrote:
> > On Mon, Dec 9, 2024 at 5:55=E2=80=AFAM Peter Zijlstra <peterz@infradead=
.org> wrote:
> > >
> > > On Fri, Dec 06, 2024 at 11:57:30AM -0500, Vineeth Remanan Pillai wrot=
e:
> > >
> > > > I was able to reproduce this WARN_ON couple of days back with
> > > > syzkaller. dlserver's dl_se gets enqueued during a update_curr whil=
e
> > > > the dlserver is stopped. And subsequent dlserver start will cause a
> > > > double enqueue.
> > >
> > > Right, I spotted that hole late last week. There is this thread:
> > >
> > >   https://lore.kernel.org/all/20241209094941.GF21636@noisy.programmin=
g.kicks-ass.net/T/#u
> > >
> > > Where I just added this thunk:
> > >
> > >   @@ -1674,6 +1679,12 @@ void dl_server_start(struct sched_dl_entity =
*dl_se)
> > >
> > >  void dl_server_stop(struct sched_dl_entity *dl_se)
> > >  {
> > > +       if (current->dl_server =3D=3D dl_se) {
> > > +               struct rq *rq =3D rq_of_dl_se(dl_se);
> > > +               trace_printk("stop fair server %d\n", cpu_of(rq));
> > > +               current->dl_server =3D NULL;
> > > +       }
> > > +
> > >         if (!dl_se->dl_runtime)
> > >                 return;
> > >
> > > Which was my attempt at plugging said hole. But since I do not have
> > > means of reproduction, I'm not at all sure it is sufficient :/
> > >
> > I think I was able to get to the root cause last week. So the issue
> > seems to be that dlserver is stopped in the pick_task path of dlserver
> > itself when the sched_delayed is set:
> > __pick_next_task
> > =3D> pick_task_dl -> server_pick_task
> >      =3D> pick_task_fair
> >           =3D> pick_next_entity (if (sched_delayed))
> >                =3D> dequeue_entities
> >                      =3D> dl_server_stop
>
> Ooh, that's where it happens.
>
> So the scenario I had in mind was that we were doing something like:
>
>         current->state =3D TASK_INTERRUPTIBLE();
>         schedule();
>           deactivate_task()
>             dl_stop_server();
>           pick_next_task()
>             pick_next_task_fair()
>               sched_balance_newidle()
>                 rq_unlock(this_rq)
>
> at which point another CPU can take our RQ-lock and do:
>
>         try_to_wake_up()
>           ttwu_queue()
>             rq_lock()
>             ...
>             activate_task()
>               dl_server_start()
>             wakeup_preempt() :=3D check_preempt_wakeup_fair()
>               update_curr()
>                 update_curr_task()
>                   if (current->dl_server)
>                     dl_server_update()
>                       enqueue_dl_entity()
>
>
> Which then also goes *bang*. The above can't happen if we clear
> current->dl_server in dl_stop_server().
>
I also thought this could be a possibility but the previous deactivate
for this task would have cleared the dl_server no? Soon after this in
update_curr() we again call dl_server_update if p_.dl_server !=3D
rq->fair_server and this is also another possibility of a double
enqueue. Thats the reason I thought we should have a flag to denote if
dl_server is active or not. I initially had a fix as you suggested
below. But it was not fully fixing the issue because the dl_yield was
confusing the server. So I split into 2 patches with dl_server active
flag as the second patch.

> I was worried that might not be it, bcause Marcel had biscected it to
> the delayed stuff, but I'd not managed to reach the pick site yet :/
>
> ...
> ....
> Hmm.. so fundamentally that yield() makes sense, but yeah, it's lost
> track of the fact that we've stopped the server and it should not
> continue.
>
> Does something like the below make sense?
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d380bffee2ef..abebeb67de4e 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -664,6 +664,7 @@ struct sched_dl_entity {
>         unsigned int                    dl_non_contending : 1;
>         unsigned int                    dl_overrun        : 1;
>         unsigned int                    dl_server         : 1;
> +       unsigned int                    dl_server_active  : 1;
>         unsigned int                    dl_defer          : 1;
>         unsigned int                    dl_defer_armed    : 1;
>         unsigned int                    dl_defer_running  : 1;
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d9d5a702f1a6..e2b542f684db 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1647,6 +1647,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
>         if (!dl_se->dl_runtime)
>                 return;
>
> +       dl_se->dl_server_active =3D 1;
>         enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
>         if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->cu=
rr->dl))
>                 resched_curr(dl_se->rq);
> @@ -1661,6 +1662,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
>         hrtimer_try_to_cancel(&dl_se->dl_timer);
>         dl_se->dl_defer_armed =3D 0;
>         dl_se->dl_throttled =3D 0;
> +       dl_se->dl_server_active =3D 0;
>  }
>
>  void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
> @@ -2420,8 +2422,10 @@ static struct task_struct *__pick_task_dl(struct r=
q *rq)
>         if (dl_server(dl_se)) {
>                 p =3D dl_se->server_pick_task(dl_se);
>                 if (!p) {
> -                       dl_se->dl_yielded =3D 1;
> -                       update_curr_dl_se(rq, dl_se, 0);
> +                       if (dl_se->dl_server_active) {
> +                               dl_se->dl_yielded =3D 1;
> +                               update_curr_dl_se(rq, dl_se, 0);
> +                       }
>                         goto again;
>                 }
>                 rq->dl_server =3D dl_se;

This should work as well. I was planning to send a second patch with
the dl_server active flag as it was not strictly the root cause of
this. But the active flag serves the purpose here and this change
looks good to me :-). I will test this on my end and let you know. It
takes more than 12 hours to reproduce in my test case ;-)

I feel that p should never be NULL when dl_server is active and that
should be a bug. From going through the code, I think we should never
hit this and a WARN_ON_ONCE would be good. What do you think about it?

Thanks,
Vineeth

