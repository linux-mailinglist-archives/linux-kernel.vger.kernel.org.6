Return-Path: <linux-kernel+bounces-562416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56988A626F0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 07:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DB117AE6A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 06:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515FB18DB2A;
	Sat, 15 Mar 2025 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/nvyL6Q"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A4741A8F
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 06:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742018754; cv=none; b=VPCu4IECNxoEpQEwu4hc9y7OXMkYHYpEMCUZ/hxTbYkXb4845CYdjf5lv8teYgBYMzQNm1hGJ4+JDgKxGYTRkwmis/RH2DnDZgNxwICzdlcCaStpa6mQHwRAH80SmUpo//2aw/0/JKAZgki4BGWzM6kgMXuy3RmmXLXzu79JPlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742018754; c=relaxed/simple;
	bh=qQ1RR4wxEIvdd0phppqiFLlf6BtvmTpMSoAs9H7RWf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJB/JXU1f6+0/V0ba30QSH1O8P8rRn67o9aC1XFCPKWSYblZQYLA4K1ryLYF6QUf5IVJdQJ+Il8vRo2BaxiIIl6gcSVJx0U6VWGuEWVDYwKYH+Xy60jylLjfpXuVPjNpEfOVXMXe3081uSVkMqrd/AxXFWZ1vhKfwGGLpG9U6Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/nvyL6Q; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54957f0c657so2800176e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 23:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742018751; x=1742623551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTsScUxWRtRUkDimhRHcaz5oETpTene5HZr2tQmNyJ0=;
        b=C/nvyL6Q9EKC1Exhm+ZcJWyRHKeQTbP736MtCP5mAMNSaOFrODWmS8y13dnGne4+yk
         Pe5b/8fijjvfLHPVCnPEGd/8W2ZFr7nx4FkyN2jbOMXTuhy5ynvHIfqm+bBPP48T5hig
         Xg9JRs68JrXc/SU7bGOzvXd5+chtgtazuQ5f+wGdrRtF6aDF5LcRUUjwCqWd8NrLNh66
         n5JnHw5i3ZoSJzfuGPIX2wEyfxlYXyuXJCF+zotJ4xz+o196oBNKh7YFoNI/Th8gRpuD
         xtTHyqNF/YeQTSVzwxqWyjsdVh6KkijbYRf8MHtSk9/WNIfDzLmXi98DSlPWY5lMQ8C7
         G5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742018751; x=1742623551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTsScUxWRtRUkDimhRHcaz5oETpTene5HZr2tQmNyJ0=;
        b=ALmJS/QRgOwI4QfhyavfDB2g4NMCE9CzvfR2Si3QH1Nkos1nf2IxtPyXnLaMNMomLR
         uIzh2LgDV9IfK64oMaW+1XupxsGe0JzUtz8XdB3paLt/kujA8QtnAJ9K+Kz8hi42YlBM
         K29s+Gti5X+yKI0cqn3v53ekTd6OrgVvYqVlRaDyNOCZSXqyWMbwV/NSytsycRQ2z+2Z
         CzgvTWD1jBAVXk2maziC8o/YYXlyE7pwue1Eqbm0zRAWiUFEqVBHLPoK4U+TBASMxEIX
         HS6JxfgWz8/WB7Rq8I/p3TAOlb7dK9jr/6HW4w17upAHQpRXIehrvQsqbfGYTBX9tJoe
         u45A==
X-Gm-Message-State: AOJu0YzPgAgVEDt0tAigr6J2fowJmTnq1ZOWn6S4sIM/2NSTrkPvCCAv
	NeyfPOi2YJBmmTgmDHLkxC2J97+VsZD6fibxzhYVIOOvBCzVm3WOgZQ+KPQ1Z6NZWH8++i+tyS9
	TqWdYLC0HxnVXG258wzw6z1ZOCUWQ4euiDmI=
X-Gm-Gg: ASbGncux5y0wa+o13IkGotljU/pi9q4zL97nhl38Gjm4qqSlwqFULqfct9z1IpI4gTs
	xNKMN+VkodALn/STRdZHwT+TjXxLSv5WvdnbTGISRHY6wTx6q6tA1PkieC6saPaldTNSpaplAq6
	vTxL336tkvrUCwCVT0gLSGulrnDSqc0jgOk7+aDiSAicXHRKrTZbxLSA==
X-Google-Smtp-Source: AGHT+IGI3izsbixM4QYzjZYGoy7JjNJh8iTm0ej3lr78zNJHzylffW2mRy/a4Pz9+XAdla/fwjtioV6OCKI9zxT2b+o=
X-Received: by 2002:a05:6512:2203:b0:545:2474:2c9b with SMTP id
 2adb3069b0e04-549c3fca13emr1951994e87.22.1742018750710; Fri, 14 Mar 2025
 23:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312221147.1865364-1-jstultz@google.com> <20250312221147.1865364-5-jstultz@google.com>
 <20250313062607.5fd9052e@batman.local.home>
In-Reply-To: <20250313062607.5fd9052e@batman.local.home>
From: John Stultz <jstultz@google.com>
Date: Fri, 14 Mar 2025 23:05:38 -0700
X-Gm-Features: AQ5f1JqrttwOggFlMrSViXR_dTtAXJ7ciHdCwj6HRtWg8EiGn0zbou0YxyxJ6_0
Message-ID: <CANDhNCpicgh_ZB45Ndf6tnngJ4gd1UUTYKtPP+SpfGXqr2G_1g@mail.gmail.com>
Subject: Re: [RFC PATCH v15 4/7] sched: Fix runtime accounting w/ split exec &
 sched contexts
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 3:26=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 12 Mar 2025 15:11:34 -0700
> John Stultz <jstultz@google.com> wrote:
>
> > The idea here is we want to charge the scheduler-context task's
> > vruntime but charge the execution-context task's sum_exec_runtime.
>
> The "but" is confusing me. Do you mean, "and also"? The sentence
> doesn't make sense with "but" unless it was:
>
>   "The idea here is we DON'T want to charge the scheduler-context
>   task's vruntime but charge the execution-context task's
>   sum_exec_runtime INSTEAD."
>
> >
> > This way cputime accounting goes against the task actually running
> > but vruntime accounting goes against the rq->donor task so we get
> > proper fairness.
>
> But this shows that you want to do both, although, I would remove the
> "but" here too. Replace it with "while".
>
> Or maybe I'm just confused.

Apologies for beingconfusing. I know I can tangle my words sometimes. :)

Hrmm. I think maybe it's a bit more clear if I switch the order. ie:

Without proxy-exec, we normally charge the "current" task for both its
vruntime as well as its sum_exec_runtime.

With proxy, we want to charge the rq->curr (proxy/lock holder) time to
its sum_exec_runtime (so it's clear to userland the rq->curr task *is*
running).

*But*, instead of charging rq->curr for the vruntime, that is charged
against the rq->donor(lock waiter) task, because that is what it is
donating when it is used as the scheduler-context.

If the donor and curr tasks are the same, then it's the same as without pro=
xy.

Your suggestion of "while" is good as well. I'll try to reword this.


> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index c798d27952431..f8ad3a44b3771 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -1129,22 +1129,33 @@ static void update_tg_load_avg(struct cfs_rq *c=
fs_rq)
> >  }
> >  #endif /* CONFIG_SMP */
> >
> > -static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
> > +static s64 update_curr_se(struct rq *rq, struct sched_entity *se)
>
> Should this be renamed to "update_se()" as it no longer appears to be
> updating "curr_se".
>
> >  {
> >       u64 now =3D rq_clock_task(rq);
> >       s64 delta_exec;
> >
> > -     delta_exec =3D now - curr->exec_start;
> > +     delta_exec =3D now - se->exec_start;
> >       if (unlikely(delta_exec <=3D 0))
> >               return delta_exec;
> >
> > -     curr->exec_start =3D now;
> > -     curr->sum_exec_runtime +=3D delta_exec;
> > +     se->exec_start =3D now;
> > +     if (entity_is_task(se)) {
> > +             struct task_struct *running =3D rq->curr;
> > +             /*
> > +              * If se is a task, we account the time against the runni=
ng
> > +              * task, as w/ proxy-exec they may not be the same.
> > +              */
> > +             running->se.exec_start =3D now;
> > +             running->se.sum_exec_runtime +=3D delta_exec;
> > +     } else {
> > +             /* If not task, account the time against se */
> > +             se->sum_exec_runtime +=3D delta_exec;
> > +     }
>
> Or maybe: update_proxy_se() ?

I'm hesitant to call it update_proxy_se() since it's still used even
when proxy-exec isn't enabled.

update_se() could work, but also feels a little generic.

Maybe update_se_times()? or account_time_se()?


Appreciate the review and feedback!

thanks
-john

