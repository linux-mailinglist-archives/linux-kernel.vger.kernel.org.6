Return-Path: <linux-kernel+bounces-553499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB846A58A85
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 03:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B033AB0F4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 02:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE111A23A0;
	Mon, 10 Mar 2025 02:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJcgEcs+"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBDC5D477
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741574516; cv=none; b=ZZbS/JX3q7FYPOaynava2m5fR4lKC4c+C2lqmY5SOx9tA5FszGibeawt+lAvX/f3KP1dap6YnMsQAhhrBavOpuxg8SCCCC4/YbTzZG3z/QZS/4nMqKtkYPRqWGb6Zj8zJ4HC5CnV9MLwOD7x7xohJzXJWM3O7au7FWIxBlc6iRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741574516; c=relaxed/simple;
	bh=4KrLYl2qKqNfiBEVnWzyfDyN2aA5EtHozDkLnHxoZJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5GEFEMoX/Z6xxaYS5DFKqEuGivyvcrsSW/T0IOzzqmWR0iz8udBwfv67nWEW0VTgPYWEv3VAiJVVQZ2pP8j4b0Lfxowj02Mo+IHPy9QlXPV3pwXlebyNrxc9c+6sCXnapK14B0IvE1dcRQTrES0eiYczGkdD/KP2+v9y9PVBqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJcgEcs+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2963dc379so89424966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 19:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741574513; x=1742179313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHLvWtQPXgvjESiRPhkT6QRZ5GkDmHO/6264kn6pwe0=;
        b=fJcgEcs+zya9eX/mBnBTP5Hrye8XTeAnZGso1oRV/P1UIEChYV9noG8pXj0zXlwByO
         BRrN2Ka/5gc7tQ/2qB2joWUJOoH9HScev+cH450TmTUirD+D1FooEOcRpnCj9P6r3ffA
         b0UkSnsbWdOMgZ33jYcU4LqHqkrCmWUaR/ypVrkyS3JpVTzKncwL3VGPg1fu0Mo8SEFn
         y3DLFINvcPnPzJ033uCSPMaEF4a4nqi9AzFGRKLzbdyOZ+tDAdwHQL1SuhSamK5jBHm+
         +UqXDKSwzKzfE9qViv24JczQzBt2EWtk96Ny2aFjpaahrxwM3Z4Ze6rsGwyMfjvEuZua
         rB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741574513; x=1742179313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHLvWtQPXgvjESiRPhkT6QRZ5GkDmHO/6264kn6pwe0=;
        b=FclI3urHSj1qobyYY4EOmAk6qaWdrlDpChJPiG/i55pQe6Nk1dkr6srLgXwsak0QIw
         yo8EXTAVnVSsK9TiJG2kbQQhFgE50pe81mR1crzloiUb00x6tZFNDNvFbeQ9LfpJ3ReO
         5VRapLHa08mStBozR3lV+Pu3ezz6TIsi/5RJRda2SftRngCMhHDvUwMkHkK9a0cgMor3
         SyYm83V7sI0QGyDMTxTHjZzJrVj+v1BDo8GyzlAuiuLJpLMB7IpbODdPCDbzHuFpjg/g
         TeYKNWptQeW8LBLowmPlZh4nSgGwjI5ndWjlXEipfPDwSweTXbwqkZ4a+XpWAnh2RVPr
         qD5w==
X-Forwarded-Encrypted: i=1; AJvYcCXshLEvHzJWdOPuW+zkqMMdn/+ZHnjgS+iNkRO8uYCWOpOM1hiuCsBHjWrcM7hBfERfo2sncKB4yt7Znmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXRIXYCXsa+sUCC9cSxx/DOrH5oScXP4vBRygsdjfLohfoqw9C
	G9lHef2d7MSXyVbrxrkub3iN1c3vEEey2dReZjzuWm4YPVWfE+l12CTjGRqG5BJxwawi5KOMamJ
	ln5eiI95F1OJsCNfbD934tDjBBP0=
X-Gm-Gg: ASbGncuEwSHVIkUKMtcdxDbD882UhfKiD61gJEijTVzs0oVg32TjuwlgtP54Razf9vC
	WWWLucvjAOndQ9XmT3WZLe5J/v4lkc4oTnjsg+Bttyzcx4utzLA4m+sazKMu4PGzQdrJOV894Gw
	ClE1lU/nuCdCRV6jFdjIZUvQr5nPwamsMu55XxRA==
X-Google-Smtp-Source: AGHT+IENi7whSVmCwemMEE7LecqKd3Y1KHej278shZ5+4dKYRRRQsa46LXR+xM88GmKXRMc3HgefgltAf8rw4wFJYQE=
X-Received: by 2002:a05:6402:34c7:b0:5e5:ba77:6f24 with SMTP id
 4fb4d7f45d1cf-5e5e22d4c66mr33046977a12.16.1741574512899; Sun, 09 Mar 2025
 19:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <84441660bef0a5e67fd09dc3787178d0276dad31.1740664400.git.hongyan.xia2@arm.com>
 <4394f2a7-b4e8-419a-a299-f1afa560c944@arm.com> <CAB8ipk_627GF+TV5u=6DK_3aRUHW8qGYwmN+KXMq_Cg-+Say1Q@mail.gmail.com>
 <bf5a70bf-3d13-4b3b-a3ef-804998b21fe9@arm.com>
In-Reply-To: <bf5a70bf-3d13-4b3b-a3ef-804998b21fe9@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Mon, 10 Mar 2025 10:41:39 +0800
X-Gm-Features: AQ5f1JpebfVbSsQMV2VBbwFWSJ0PIMu5A1Gm9bVlGJFq40huXg6C-wesWhjd4_w
Message-ID: <CAB8ipk-SUFDATb=euJQFebxQ513SRwTEpSbBSD6K=batQKELHg@mail.gmail.com>
Subject: Re: [PATCH] sched/uclamp: Let each sched_class handle uclamp
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Hongyan Xia <hongyan.xia2@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	Xuewen Yan <xuewen.yan@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 2:32=E2=80=AFAM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 06/03/2025 13:01, Xuewen Yan wrote:
> > On Thu, Mar 6, 2025 at 2:24=E2=80=AFAM Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 27/02/2025 14:54, Hongyan Xia wrote:
> >>
> >> [...]
> >>
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index 857808da23d8..7e5a653811ad 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -6941,8 +6941,10 @@ enqueue_task_fair(struct rq *rq, struct task_s=
truct *p, int flags)
> >>>        * Let's add the task's estimated utilization to the cfs_rq's
> >>>        * estimated utilization, before we update schedutil.
> >>>        */
> >>> -     if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags=
 & ENQUEUE_RESTORE))))
> >>> +     if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags=
 & ENQUEUE_RESTORE)))) {
> >>> +             uclamp_rq_inc(rq, p);
> >>>               util_est_enqueue(&rq->cfs, p);
> >>> +     }
> >>
> >> So you want to have p uclamp-enqueued so that its uclamp_min value
> >> counts for the cpufreq_update_util()/cfs_rq_util_change() calls later =
in
> >> enqueue_task_fair?
> >>
> >>   if (p->in_iowait)
> >>     cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
> >>
> >>   enqueue_entity() -> update_load_avg() -> cfs_rq_util_change() ->
> >>   cpufreq_update_util()
> >>
> >> But if you do this before requeue_delayed_entity() (1) you will not
> >> uclamp-enqueue p which got his ->sched_delayed just cleared in (1)?
> >>
> >
> > Could we change to the following:
> >
> > when enqueue:
> >
> > -     if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags
> > & ENQUEUE_RESTORE))))
> > +     if (!(p->se.sched_delayed && !(flags & ENQUEUE_DELAYED)))
>
> Why you want to check ENQUEUE_DELAYED as well here? Isn't
> !p->se.sched_delayed implying !ENQUEUE_DELAYED).

Indeed, the (!(p->se.sched_delayed && !(flags & ENQUEUE_DELAYED))) is equal=
 to
the  (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags &
ENQUEUE_RESTORE)))).
I just think it might be easier to read using the ENQUEUE_DELAYED flag.
Because we only allow enq the uclamp and util_est when wake up the delayed-=
task.


>
> > +             uclamp_rq_inc(rq, p);
> >                util_est_enqueue(&rq->cfs, p);
> >  +     }
> >
> >
> > when dequeue:
> >
> > -       if (!(p->se.sched_delayed && (task_on_rq_migrating(p) ||
> > (flags & DEQUEUE_SAVE))))
> > +       if (!p->se.sched_delayed) {
> > +               uclamp_rq_dec(rq, p);
> >                 util_est_dequeue(&rq->cfs, p);
> > +       }
>
> So you want to exclude all delayed tasks from util_est and uclamp?

Yes, Because we had dequeued the task's uclamp and util_est when first slee=
ping=E3=80=82
This is achieved by putting the update of uclamp and util_est before
dequeue_entity.
For other dequeue, we should always ignore it. So there is no need to
judge the flags and migration.

BR

