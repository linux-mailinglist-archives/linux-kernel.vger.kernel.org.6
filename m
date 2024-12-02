Return-Path: <linux-kernel+bounces-427684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B018C9E04C1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF65283C18
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2546520408F;
	Mon,  2 Dec 2024 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NjSM9n2G"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32C81FECB5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149480; cv=none; b=eahtHETMHgAupybMzBhfzVbgWIDTHnr2weQjZhWg+c2XSa7uAGkSGo/YAg70mzkqiy7biGoyLPpUrgAgTmhIth/bKhtY9qsGm1wspE309XlQUR4UlapHgqMI/Z9wq6kSTLgx1NqUTUzuaG0d9/3lxBaK11veQunbXK7JZxlwHbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149480; c=relaxed/simple;
	bh=0KY/4YTl4pZsvobQVT//F4NX5/vrB6JxJhMNbxVsVXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qfj0juwKpBPU6pXtETwfN9le5DnW+GsukM0FYnd65tIVfwESIXz5jih4kgJr8mXBnuN/J3I2kJYWycbi/59ryx+MroyPIGZQbBn2+ezItnzv97IaqV+c5TzJ8LM6CCBUmlm4C5TtLOpv8NPyESEe0DpEm+jfGdfHR0hoJoPOm5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NjSM9n2G; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee786b3277so1594922a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733149478; x=1733754278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yG2M1bwx3dGC92pi1KU6VnhRqMtcdPDvg1eTYuWQgM=;
        b=NjSM9n2Guotc7yMOXNGIJCicBCLtc3M877RvohhKJYKkzEPeDOzFtN9TvbUHoYnWsf
         0bFwQu3JMSWFZyG4v9uW4es0h0ewkb+YKBvad82cF5LpAP7kLiQMnH31ZQu6/cqDYoaT
         51Wu/TkN/AcNmnYnAKX1aqP0WBOZifirpX5sYUBzbab6f4ghEDZo4+MbR6GT9yrVG8Sf
         y9LY8K0A4+7GQqhP3ZrkoiL/+PF0Xy5VsieBaQYgcTeFsY94jf2SLLYf2De7y7RwkALS
         Ats0cppeWKxfLWM6KWwYYcpFubm52VqU7AeebGaMtuQDHxX8L4ufJc2XI/3Sr2x+EJXZ
         B9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733149478; x=1733754278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yG2M1bwx3dGC92pi1KU6VnhRqMtcdPDvg1eTYuWQgM=;
        b=si2IP0/7zIL4FfnQoAv9z4w5UKZx+OPCTY5pwb51pO82B9PlZDFG9XxBTpBll/RdE/
         CWsBHtEtIvLZdA0KN1ayiWBII3/fhQsmytbd/u0k/u1gOGn+2xMFQ2+ZxnvOQXMZcSYs
         kwG+5rOfKk03BKc0DcA6tKVVrq4E4oZAm30vYE1+Pawh31fZmaMqZ2bb/rR03UhZ1T2m
         cf9TuhiT2j7YOmz7nkEslJw/V0n6BQDPhTukk+dvqy/U4oQ+57QV6+yNmZzUyfSkY44V
         pNwGxbDvdVrISQN3sYBcCq+YQv+V+FRv/a1I9SLRh8WjRfYbI8o0bVH06QwvZxSnMzZg
         mT6g==
X-Forwarded-Encrypted: i=1; AJvYcCV927N1PrHyd7GMbTW+xfzbIF0TBDbLFKi1EISv4PGyAKUJKVgLAxS1UEM+HD3ko7iC3Tvnn44GTQJKt6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjaa2EaxWoSZTUhyg2rM7p94qjaAsoXkRxUbE/nTAhfPPBOa/E
	8GXhf4j+Nn/goR/mbZc9Be52y3yw4T/kvKxH3JWfjUYr12I0ydu5IKjbWym3df3B9Navsfb2hW8
	jEKKGi49rZ4yVvHvFSQBP1g+qXy2xoO1Cw2OEpw==
X-Gm-Gg: ASbGncsJPl9AROFjGaIT8WB2rbuQeeQebKx/ucAKgVAvseKdv2OiC6gaiMN2pUS7gBH
	EiDS8dyixAEkgFtrFxBOvPqkf68NKs0tQmPnYPdM/wV29FKKWOv+//Yb6nWdf
X-Google-Smtp-Source: AGHT+IHrkr60Is3gC4EjFIoLGE5QzjKl3dS4mccqdGjoXsurRKNsLhAmiQXjFXun7K8hYC8pXmKaZdSiHSF79dW+5/k=
X-Received: by 2002:a17:90b:380a:b0:2ee:d7d3:3019 with SMTP id
 98e67ed59e1d1-2eed7d34d4cmr4802755a91.12.1733149477731; Mon, 02 Dec 2024
 06:24:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129161756.3081386-1-vincent.guittot@linaro.org>
 <227863d758551e75cd0807a5f1f31916d695205b.camel@gmx.de> <CAKfTPtDwS4+t0Fnacre6dtxKdxtrgua_2v=s7pZHqDsYoMMxFA@mail.gmail.com>
 <ab68a4ae-f640-4057-8607-6cca9b5ce90e@amd.com> <CAKfTPtA4CpemXN7nY9URsrt+ygUYBTGbJdPuzP8wiQQkzLwmMQ@mail.gmail.com>
In-Reply-To: <CAKfTPtA4CpemXN7nY9URsrt+ygUYBTGbJdPuzP8wiQQkzLwmMQ@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 2 Dec 2024 15:24:26 +0100
Message-ID: <CAKfTPtB4_gPdgSWMfk+ZZ0H8x4T8_-CUZaaUe_ZiWJTK6mAe4Q@mail.gmail.com>
Subject: Re: [PATCH 0/10 v2] sched/fair: Fix statistics with delayed dequeue
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Mike Galbraith <efault@gmx.de>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, pauld@redhat.com, luis.machado@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Dec 2024 at 12:42, Vincent Guittot <vincent.guittot@linaro.org> w=
rote:
>
> On Mon, 2 Dec 2024 at 10:58, K Prateek Nayak <kprateek.nayak@amd.com> wro=
te:
> >
> > Hello Vincent, Mike,
> >
> > On 12/2/2024 2:47 PM, Vincent Guittot wrote:
> > > On Sun, 1 Dec 2024 at 14:30, Mike Galbraith <efault@gmx.de> wrote:
> > >>
> > >> Greetings,
> > >>
> > >> On Fri, 2024-11-29 at 17:17 +0100, Vincent Guittot wrote:
> > >>> Delayed dequeued feature keeps a sleeping sched_entitiy enqueued un=
til its
> > >>> lag has elapsed. As a result, it stays also visible in the statisti=
cs that
> > >>> are used to balance the system and in particular the field h_nr_run=
ning.
> > >>>
> > >>> This serie fixes those metrics by creating a new h_nr_queued that t=
racks
> > >>> all queued tasks. It renames h_nr_running into h_nr_runnable and re=
stores
> > >>> the behavior of h_nr_running i.e. tracking the number of fair tasks=
 that
> > >>>   want to run.
> > >>>
> > >>> h_nr_runnable is used in several places to make decision on load ba=
lance:
> > >>>    - PELT runnable_avg
> > >>>    - deciding if a group is overloaded or has spare capacity
> > >>>    - numa stats
> > >>>    - reduced capacity management
> > >>>    - load balance between groups
> > >>
> > >> I took the series for a spin in tip v6.12-10334-gb1b238fba309, but
> > >> runnable seems to have an off-by-one issue, causing it to wander eve=
r
> > >> further south.
> > >>
> > >> patches 1-3 applied.
> > >>    .h_nr_runnable                 : -3046
> > >>    .runnable_avg                  : 450189777126
> > >
> > > Yeah, I messed up something around finish_delayed_dequeue_entity().
> > > I'm' going to prepare a v3
> >
> > I was looking into this and I have the below diff so far that seems to
> > solve the post boot negative values of h_nr_runnable on my setup; it is
> > only lightly tested so far:
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 87552870958c..423981e65aba 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5464,6 +5464,10 @@ static __always_inline void return_cfs_rq_runtim=
e(struct cfs_rq *cfs_rq);
> >   static void set_delayed(struct sched_entity *se)
> >   {
> >         se->sched_delayed =3D 1;
> > +
> > +       if (!entity_is_task(se))
> > +               return;
> > +
> >         for_each_sched_entity(se) {
> >                 struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
> >
> > @@ -5476,6 +5480,10 @@ static void set_delayed(struct sched_entity *se)
> >   static void clear_delayed(struct sched_entity *se)
> >   {
> >         se->sched_delayed =3D 0;
> > +
> > +       if (!entity_is_task(se))
> > +               return;
> > +
> >         for_each_sched_entity(se) {
> >                 struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
> >
> > @@ -6977,7 +6985,7 @@ enqueue_task_fair(struct rq *rq, struct task_stru=
ct *p, int flags)
> >         struct cfs_rq *cfs_rq;
> >         struct sched_entity *se =3D &p->se;
> >         int h_nr_idle =3D task_has_idle_policy(p);
> > -       int h_nr_runnable =3D 0;
> > +       int h_nr_runnable =3D 1;
>
> I miss to invert default value when moving from h_nr_delayed to h_nr_runn=
able
>
> >         int task_new =3D !(flags & ENQUEUE_WAKEUP);
> >         int rq_h_nr_queued =3D rq->cfs.h_nr_queued;
> >         u64 slice =3D 0;
> > @@ -7124,8 +7132,7 @@ static int dequeue_entities(struct rq *rq, struct=
 sched_entity *se, int flags)
> >                 p =3D task_of(se);
> >                 h_nr_queued =3D 1;
> >                 h_nr_idle =3D task_has_idle_policy(p);
> > -               if (!task_sleep && !task_delayed)
> > -                       h_nr_runnable =3D !se->sched_delayed;
> > +               h_nr_runnable =3D !se->sched_delayed;

And I screwed up h_nr_runnable here as well

> >         } else {
> >                 cfs_rq =3D group_cfs_rq(se);
> >                 slice =3D cfs_rq_min_slice(cfs_rq);
> > diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> > index ab911d1335ba..f4ef5aaa4674 100644
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -457,6 +457,7 @@ static void put_prev_task_idle(struct rq *rq, struc=
t task_struct *prev, struct t
> >
> >   static void set_next_task_idle(struct rq *rq, struct task_struct *nex=
t, bool first)
> >   {
> > +       SCHED_WARN_ON(rq->cfs.h_nr_runnable);
> >         update_idle_core(rq);
> >         scx_update_idle(rq, true);
> >         schedstat_inc(rq->sched_goidle);
> > --
> >
> > I'm not sure if the change in dequeue_entities() is completely necessar=
y
> > but I added it after seeing the (DEQUEUE_SLEEP | DEQUEUE_DELAYED) in
> > throttle_cfs_rq() but there the entity cannot possibly be a task so
> > perhaps that part is unnecessary =C2=AF\_(=E3=83=84)_/=C2=AF
> >
> > Still testing! Will keep an eye out for v3.
> >
> > >
> > >>
> > >> full set applied.
> > >>    .h_nr_runnable                 : -5707
> > >>    .runnable_avg                  : 4391793519526
> > >>
> > >>          -Mike
> >
> > --
> > Thanks and Regards,
> > Prateek
> >

