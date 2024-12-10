Return-Path: <linux-kernel+bounces-438792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5349EA609
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 03:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F187516470D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B451AFB35;
	Tue, 10 Dec 2024 02:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="Q/t9GxSB"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF67C1A2550
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733799170; cv=none; b=TJUoJp/KY3wEvUOXGs4NA57ayutKzZ0zU3HfEcbMPgkjvCe9fdukmRxOWCXz/dc0muGOjAsT6vAA2iPv/B9yokDIb24iUCh5NWAYyQvH0gOJazKYe26zWQJ3Vud0LFD/dr5vLKLGhRGJlJ85Bgx/1MUFYxH1YcHsnKmYmwAbVIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733799170; c=relaxed/simple;
	bh=SnNjus0bU71PjH40/50iGOzVkychSxX7oJfpDxNQ97Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idn24d6LtH27lfq48YiRUO/y/OmQelkz1gWcGo+IxuJ4ELvTB5HfLuEAkwsD2axYxAZ2clbiXWVp/EaBFyAUHAj6guIGfEKbTfOF3x5/WkujIm0eFc6IhDKDcQXG7wLtFNfXhnVlcWO4FUvp2c/RZnUCAPiB+CsFkLJftQNfnCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=Q/t9GxSB; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6efa08f91c8so48300737b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 18:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1733799166; x=1734403966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RO9xPg4/U00W7fHMTYGXY1kJkQI0c6wxXxe1zFQZb/w=;
        b=Q/t9GxSBg//mTcr2aa4NMnKta+oCMNUqn/o0irR3q2lnr/ev+UbuCWXIz4pGNb/cru
         HoHlZqlZTfluzhKgM0Mp69cGHEPmmazFryUTPWGc/6VZbZrSnxaWFgW6blvCBoqBngyQ
         2kSPXyvVsWCEdItzPJL3VMjdyCyux/rcpmw8j6gdr98P733ANP12VCxTeNg1qZ3CSkc3
         4Nv0r/HEDj/98N+g4LiG6guW8I9pLNbo7vW9tRqM35NYzj0pMI1Wuwpu9gMwS5z/4/rw
         iFcvIbMXm8/KMczBrSIYMG4hWBP6Rx3i8OzNc6++C4b3ML8HT8OYWO5/0tHh1uQsm75T
         wBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733799166; x=1734403966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RO9xPg4/U00W7fHMTYGXY1kJkQI0c6wxXxe1zFQZb/w=;
        b=B6UnDPHb+uQ3l9QXnryzTnxsFEnScRiHJCIigCFXYg7xuzFRV5NEgkOGb2UcOfpyJS
         //pbcahn/I2u26dZnC9SBTPsiGSSC3aqo9okuX0QCmVFC/ygV1TuDyKoSmKgnrzTlG8p
         94MKMdiUuYDEEur6ObN0aquNwpa+8muFbmuHxIC/5nuSQ+gR4BKonCO3EkMApJ2Qtfi1
         ErP3soFG+93Bsj8LuMzYXAbIjcc9TKAuSpSxVdKAFRonYC45dIlQuMNnOkZUa65qr36z
         25zRW6AV+MSgrTEA8SGUHN07GBHpdQJS37lrWrL3QfHnMbLLJ++dJtO+GEIne9muhgH/
         4IEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOjvl8sLCZt1gdhyuVTJBLhhMliHKJezkHIjDYu4L4ezKZ8ByXheHw1hXaFI6rRvoBHWrdrYAYdjHKbb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXQDhE/GVlrqZTr1gMaTppXX8qYeqYk4cH2eehRC4m8U810RHP
	Q6SGPtJqtV/mGOJRWxu/ForYSq5JSf8r1eWfkecHGsZ5bgxwFcp6OMqGLTkzrRznk6yMy5jRxOQ
	j1s0fLz9EkbyiP1ZnAnIQj9WD0dMXu02g1/LjjVzMVJMbs9o/Hr38pA==
X-Gm-Gg: ASbGncuI0gkkVXWdfTQAUJGUgLTjOEhak2SA8IFfhmk87VifN+oeZvGRtsJs8aNGCXC
	mIIaTCP0YQZcYxbSUuqDqA2td95/8TDr9Xbk=
X-Google-Smtp-Source: AGHT+IF0mPpEo726yuSiydrNTtVawpmKRH2Gt8spsE9KrozvJdNmnvL7/fV7qiOesKafHVNQa23BUl0LgEpZfXBgSIc=
X-Received: by 2002:a05:690c:6011:b0:6ef:593e:285c with SMTP id
 00721157ae682-6efe3bceb35mr158553077b3.3.1733799166594; Mon, 09 Dec 2024
 18:52:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <571b2045-320d-4ac2-95db-1423d0277613@ovn.org> <20241206151819.GA3949140@google.com>
 <CAO7JXPhdv+Jx_UpAq=-aG-BKwiyjZ2kvuZDM4+GLjbya_=ZJsw@mail.gmail.com>
 <20241209105514.GK21636@noisy.programming.kicks-ass.net> <CAO7JXPgSYCzu0mtnWqBaS8ihmoQXX3WE_Yb_rEYuMeQn+B6KJg@mail.gmail.com>
 <20241209125601.GQ35539@noisy.programming.kicks-ass.net> <8ff30c5d-b8ac-4825-874a-d73931b85014@ovn.org>
In-Reply-To: <8ff30c5d-b8ac-4825-874a-d73931b85014@ovn.org>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Mon, 9 Dec 2024 21:52:35 -0500
Message-ID: <CAO7JXPijXstA3Eh_LrRGiK26U1Mfn8C1jSXP+4kfTnQRxSax7g@mail.gmail.com>
Subject: Re: [v6.12] WARNING: at kernel/sched/deadline.c:1995
 enqueue_dl_entity (task blocked for more than 28262 seconds)
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, vineethrp@google.com, 
	shraash@google.com, marcel.ziswiler@codethink.co.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 7:34=E2=80=AFPM Ilya Maximets <i.maximets@ovn.org> w=
rote:
>
> On 12/9/24 13:56, Peter Zijlstra wrote:
> >
> > Does something like the below make sense?
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index d380bffee2ef..abebeb67de4e 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -664,6 +664,7 @@ struct sched_dl_entity {
> >       unsigned int                    dl_non_contending : 1;
> >       unsigned int                    dl_overrun        : 1;
> >       unsigned int                    dl_server         : 1;
> > +     unsigned int                    dl_server_active  : 1;
> >       unsigned int                    dl_defer          : 1;
> >       unsigned int                    dl_defer_armed    : 1;
> >       unsigned int                    dl_defer_running  : 1;
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index d9d5a702f1a6..e2b542f684db 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -1647,6 +1647,7 @@ void dl_server_start(struct sched_dl_entity *dl_s=
e)
> >       if (!dl_se->dl_runtime)
> >               return;
> >
> > +     dl_se->dl_server_active =3D 1;
> >       enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
> >       if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->cu=
rr->dl))
> >               resched_curr(dl_se->rq);
> > @@ -1661,6 +1662,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se=
)
> >       hrtimer_try_to_cancel(&dl_se->dl_timer);
> >       dl_se->dl_defer_armed =3D 0;
> >       dl_se->dl_throttled =3D 0;
> > +     dl_se->dl_server_active =3D 0;
> >  }
> >
> >  void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
> > @@ -2420,8 +2422,10 @@ static struct task_struct *__pick_task_dl(struct=
 rq *rq)
> >       if (dl_server(dl_se)) {
> >               p =3D dl_se->server_pick_task(dl_se);
> >               if (!p) {
> > -                     dl_se->dl_yielded =3D 1;
> > -                     update_curr_dl_se(rq, dl_se, 0);
> > +                     if (dl_se->dl_server_active) {
> > +                             dl_se->dl_yielded =3D 1;
> > +                             update_curr_dl_se(rq, dl_se, 0);
> > +                     }
> >                       goto again;
> >               }
> >               rq->dl_server =3D dl_se;
>
> And I tried this one on top of v6.12, but got a warning after about 1 min=
ute (lucky?).
>
Hmm strange, I was running it for about 12 hours and has not WARNed
till now. I am on 6.13-rc1 but git log did not show any dlserver
related changes between 6.12 and 6.13 though. I also have another
patch for the double enqueue scenario we were disussing in this
thread(because of the wrong check in update_curr). Could you please
add the following changes to above patches and see if the isssue is
reproducible?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fbdca89c677f..1f4b76c1f032 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1159,8 +1159,6 @@ static inline void update_curr_task(struct
task_struct *p, s64 delta_exec)
        trace_sched_stat_runtime(p, delta_exec);
        account_group_exec_runtime(p, delta_exec);
        cgroup_account_cputime(p, delta_exec);
-       if (p->dl_server)
-               dl_server_update(p->dl_server, delta_exec);
 }

 static inline bool did_preempt_short(struct cfs_rq *cfs_rq, struct
sched_entity *curr)
@@ -1210,6 +1208,11 @@ s64 update_curr_common(struct rq *rq)
        return delta_exec;
 }

+static inline bool dl_server_active(struct dl_sched_entity *dl_se)
+{
+       return dl_se->dl_server_active;
+}
+
 /*
  * Update the current task's runtime statistics.
  */
@@ -1237,11 +1240,16 @@ static void update_curr(struct cfs_rq *cfs_rq)
                update_curr_task(p, delta_exec);

                /*
-                * Any fair task that runs outside of fair_server should
-                * account against fair_server such that it can account for
-                * this time and possibly avoid running this period.
+                * If the fair_server is active, we need to account for the
+                * fair_server time whether or not the task is running on
+                * behalf of fair_server or not:
+                *  - If the task is running on behalf of fair_server, we n=
eed
+                *    to limit its time based on the assigned runtime.
+                *  - Fair task that runs outside of fair_server should acc=
ount
+                *    against fair_server such that it can account for this=
 time
+                *    and possibly avoid running this period.
                 */
-               if (p->dl_server !=3D &rq->fair_server)
+               if (dl_server_active(&rq->fair_server))
                        dl_server_update(&rq->fair_server, delta_exec);
        }


Thanks for your time testing the fixes :-)

~Vineeth

