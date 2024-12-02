Return-Path: <linux-kernel+bounces-427429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8FC9E00D1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB6116215F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81E01FC0E8;
	Mon,  2 Dec 2024 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gvTCr+Ad"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682891D8DFB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733139782; cv=none; b=t15dnPduttaBjmigvdypIuNSiMDn91eeHJB3GGhSKFZFJv5o8s5hoHzGRRckQu7wG/iHCd/5d6/RA0Pc61XIPw6uo24G5Fp7eTjGnf61hUjI/BXbnDg7p3tl6gIZAE+i5hQ60A9oRGduCuaSxGc0x205TUwKRwkrL37hUDKNC5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733139782; c=relaxed/simple;
	bh=mJx95gAN/aKpluKOlko5Z9ks8rFj2UR0lYop2kvTgag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXL3iuBgH2CJ4gtaL9fx+WybDwJSZlZCrE4CIyDaGcAu+6Ie7bIHg668nwZWjGmS/aXVOBkvvFS15basdtDKC/c0aIug7mcHzRavs67ziPtzG+vBWpM8aH/MePH2GB88KfcyBXnWWMYd8p83+TlwSsTbLDK73dSGYUxVnEwK9Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gvTCr+Ad; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-724f74d6457so3966984b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 03:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733139780; x=1733744580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66a5SYXcO+KsbC/e3uaXpSY5dDKpppwC/ZfdWF569rw=;
        b=gvTCr+AdC7sG60X0Adv2pZT3K1z5YMWweXFXM8qXI2gVOZJ0h++6Q3py7BNQ2GjFCb
         xM6HbH8e6JpV9fWBjAdZNwl+Gt+u02+0X4WeL8ZaXPXWlGcmGMFlERbISxLMXIuW8Ycb
         NxaW6Hyk8tRS4E5rvZble74Z9RtFWYVVFi7P+F4y+oKBt8xjI2UPsmI1+s/+6rZksidt
         oTpbD+m9rDkU0Oyew5pN332w52XssYo096fUeZ5Z2AQSa9quT+vZgPD9XZx5OSYD+/VT
         ZUJIe5VYANuWC9xJppi/Fo1JKtBN50xPLPa9vrzSF4pvVmgLYPykLvrdmdKf7cFRVfwN
         5LdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733139780; x=1733744580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66a5SYXcO+KsbC/e3uaXpSY5dDKpppwC/ZfdWF569rw=;
        b=L8INgazHYIBvN8ePoGVHcFKT56QWuVdVK9k7taON1OVRHZeKyHxHFFyDVidlCJBidG
         WF1K6WkP507ta8YHnnKoAA3GmvFua6L26z2uqGZZC2NSrF6tB8YVcGJhS1NbI2JHK403
         YoCGOQeCdZkJFgMPkX61oKkbDuiV+JS2rLQ75MfSL9kJk6XgRsXLbgNz4pn++00/Ts/F
         cWg6gHDbp0Z6TAoUVUflOZGbF+vQh+0Y3OrFT4ez903sMAK27q3z0nWIyywd1i2EIMir
         PN0OWcgcYFaJOfbxFf+MA0mzO3XP7kOSOgXd/jftYGVCSaRmxYe3yY7eOAxQo6+zjab4
         DTHg==
X-Forwarded-Encrypted: i=1; AJvYcCUjG65zy5VTkceg4qVH30QyQFLNmGYK6VBcNDtsxTvlA8SYccEK9kgdzq7R4Y/uMNfMZ2f6Q748BEIMo5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwUdFZMiwVGBRl3Ha5xUmQWG3huu+PHchtERh6pIE0zxQ+L8RS
	4RHWUeeKewvRMO/spMJ9tFDRBStz3tJrDKXCKRWKH5Vt3921gZNbY1tzWPmZDFPd7RB2r5aHewv
	NeP6W0awbXlogZ8VkvYcAXRgE51dFDBLeB6IzxA==
X-Gm-Gg: ASbGncsXEmPOk1Vyyf2+ztn5QUyl6O4Fh6t0dsBnW/t3ng2ieNEvO6p2rbytVHdSIbp
	eCcXMYd95p3TaRmrLiXYdePP5zAFW0EJewO4EvLja3Hqe67890vC4/zQ9Hno3
X-Google-Smtp-Source: AGHT+IEANdimpi4feCWQh5SimjtqO0MGR0mIJWKyZTQe1WOOw46NJf9Ki1fzp+GFKavmNjIzhwLyXhfBbd86HqpdI0w=
X-Received: by 2002:a17:90b:4d0d:b0:2ea:a25d:3baa with SMTP id
 98e67ed59e1d1-2ee08e5bad3mr28643649a91.5.1733139779752; Mon, 02 Dec 2024
 03:42:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129161756.3081386-1-vincent.guittot@linaro.org>
 <227863d758551e75cd0807a5f1f31916d695205b.camel@gmx.de> <CAKfTPtDwS4+t0Fnacre6dtxKdxtrgua_2v=s7pZHqDsYoMMxFA@mail.gmail.com>
 <ab68a4ae-f640-4057-8607-6cca9b5ce90e@amd.com>
In-Reply-To: <ab68a4ae-f640-4057-8607-6cca9b5ce90e@amd.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 2 Dec 2024 12:42:48 +0100
Message-ID: <CAKfTPtA4CpemXN7nY9URsrt+ygUYBTGbJdPuzP8wiQQkzLwmMQ@mail.gmail.com>
Subject: Re: [PATCH 0/10 v2] sched/fair: Fix statistics with delayed dequeue
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Mike Galbraith <efault@gmx.de>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, pauld@redhat.com, luis.machado@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Dec 2024 at 10:58, K Prateek Nayak <kprateek.nayak@amd.com> wrote=
:
>
> Hello Vincent, Mike,
>
> On 12/2/2024 2:47 PM, Vincent Guittot wrote:
> > On Sun, 1 Dec 2024 at 14:30, Mike Galbraith <efault@gmx.de> wrote:
> >>
> >> Greetings,
> >>
> >> On Fri, 2024-11-29 at 17:17 +0100, Vincent Guittot wrote:
> >>> Delayed dequeued feature keeps a sleeping sched_entitiy enqueued unti=
l its
> >>> lag has elapsed. As a result, it stays also visible in the statistics=
 that
> >>> are used to balance the system and in particular the field h_nr_runni=
ng.
> >>>
> >>> This serie fixes those metrics by creating a new h_nr_queued that tra=
cks
> >>> all queued tasks. It renames h_nr_running into h_nr_runnable and rest=
ores
> >>> the behavior of h_nr_running i.e. tracking the number of fair tasks t=
hat
> >>>   want to run.
> >>>
> >>> h_nr_runnable is used in several places to make decision on load bala=
nce:
> >>>    - PELT runnable_avg
> >>>    - deciding if a group is overloaded or has spare capacity
> >>>    - numa stats
> >>>    - reduced capacity management
> >>>    - load balance between groups
> >>
> >> I took the series for a spin in tip v6.12-10334-gb1b238fba309, but
> >> runnable seems to have an off-by-one issue, causing it to wander ever
> >> further south.
> >>
> >> patches 1-3 applied.
> >>    .h_nr_runnable                 : -3046
> >>    .runnable_avg                  : 450189777126
> >
> > Yeah, I messed up something around finish_delayed_dequeue_entity().
> > I'm' going to prepare a v3
>
> I was looking into this and I have the below diff so far that seems to
> solve the post boot negative values of h_nr_runnable on my setup; it is
> only lightly tested so far:
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 87552870958c..423981e65aba 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5464,6 +5464,10 @@ static __always_inline void return_cfs_rq_runtime(=
struct cfs_rq *cfs_rq);
>   static void set_delayed(struct sched_entity *se)
>   {
>         se->sched_delayed =3D 1;
> +
> +       if (!entity_is_task(se))
> +               return;
> +
>         for_each_sched_entity(se) {
>                 struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
>
> @@ -5476,6 +5480,10 @@ static void set_delayed(struct sched_entity *se)
>   static void clear_delayed(struct sched_entity *se)
>   {
>         se->sched_delayed =3D 0;
> +
> +       if (!entity_is_task(se))
> +               return;
> +
>         for_each_sched_entity(se) {
>                 struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
>
> @@ -6977,7 +6985,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct=
 *p, int flags)
>         struct cfs_rq *cfs_rq;
>         struct sched_entity *se =3D &p->se;
>         int h_nr_idle =3D task_has_idle_policy(p);
> -       int h_nr_runnable =3D 0;
> +       int h_nr_runnable =3D 1;

I miss to invert default value when moving from h_nr_delayed to h_nr_runnab=
le

>         int task_new =3D !(flags & ENQUEUE_WAKEUP);
>         int rq_h_nr_queued =3D rq->cfs.h_nr_queued;
>         u64 slice =3D 0;
> @@ -7124,8 +7132,7 @@ static int dequeue_entities(struct rq *rq, struct s=
ched_entity *se, int flags)
>                 p =3D task_of(se);
>                 h_nr_queued =3D 1;
>                 h_nr_idle =3D task_has_idle_policy(p);
> -               if (!task_sleep && !task_delayed)
> -                       h_nr_runnable =3D !se->sched_delayed;
> +               h_nr_runnable =3D !se->sched_delayed;
>         } else {
>                 cfs_rq =3D group_cfs_rq(se);
>                 slice =3D cfs_rq_min_slice(cfs_rq);
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index ab911d1335ba..f4ef5aaa4674 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -457,6 +457,7 @@ static void put_prev_task_idle(struct rq *rq, struct =
task_struct *prev, struct t
>
>   static void set_next_task_idle(struct rq *rq, struct task_struct *next,=
 bool first)
>   {
> +       SCHED_WARN_ON(rq->cfs.h_nr_runnable);
>         update_idle_core(rq);
>         scx_update_idle(rq, true);
>         schedstat_inc(rq->sched_goidle);
> --
>
> I'm not sure if the change in dequeue_entities() is completely necessary
> but I added it after seeing the (DEQUEUE_SLEEP | DEQUEUE_DELAYED) in
> throttle_cfs_rq() but there the entity cannot possibly be a task so
> perhaps that part is unnecessary =C2=AF\_(=E3=83=84)_/=C2=AF
>
> Still testing! Will keep an eye out for v3.
>
> >
> >>
> >> full set applied.
> >>    .h_nr_runnable                 : -5707
> >>    .runnable_avg                  : 4391793519526
> >>
> >>          -Mike
>
> --
> Thanks and Regards,
> Prateek
>

