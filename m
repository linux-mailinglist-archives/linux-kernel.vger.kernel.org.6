Return-Path: <linux-kernel+bounces-554052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92803A59230
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440B03A7241
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C326B226D07;
	Mon, 10 Mar 2025 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlR+AvCu"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C80B17A2E7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604638; cv=none; b=aGExcQigMmum0Xh9a74C/k3MhPYQSZ0D27HFb2rUwyATDwNJREb5gZrTrNMevUYTnctdja/CDh22/rL0FlrHPbMzAu9Aqs6pyjgSckEPXPMo0cGOmD58qWI1afgGpabjdwYIP+CKuWzdCxhWutKMXzkfw7QkbapSP7E4y/mQ5t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604638; c=relaxed/simple;
	bh=twRHMbIp6OZQj2m+uuxfbqk1Kfu7YwN+abkej4hPLH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZsb9RSEP2NbnW8TyFHaFC8bZ4UTf19hgITwH4rOqdBeTdg8xEQDVlHRy/ke/+app3p582x3D3GOaHh11tH5KRrTOiIw9MlTBXT9Ssrb186gr4EX42VCHZ6V974K6OX5L9Re325mJCGB6ClhPp42C90O9vE7TNaQdjakmgDJdws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlR+AvCu; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso2299690a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 04:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741604634; x=1742209434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7BUcFsRj/y6rxeqK+E6cVPSLMvQ8YkhpTA5EiP+/fM=;
        b=BlR+AvCuczA8iIq9rzlY3CMJwsX5QRcIkdE5bjZgx3N2oloyQ60NDE1CcQvs1fGAeC
         g99BgcEMC9oD0zufapBKfgSucEz0EVgYL+7HsdmlhUytxx8LvIYLtaSnCadRONyKiTa9
         NH57Ie+ssqdipNHLnjeRP2ydlJFNwVnEU4Mzoh2ZsNGQeHBYPfX40oBjyK7SEBApqzTj
         dfqHTBCda5oHOWX/B91HkbTj2RSB3gk/Zt9RcRCF+P3PnNjUZBvIcJjApRJzjqeOlU2H
         Jg5qT6aKoZikhaiYf9FAO0QnZkFoTc6uomY7PQ+LmzrFpTy4bXDWe8guDF6vzJGCRJfF
         T3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741604634; x=1742209434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7BUcFsRj/y6rxeqK+E6cVPSLMvQ8YkhpTA5EiP+/fM=;
        b=q+QmuBqfJaYGzMphErCX7t2m93f6NkWKyszcNQmrGqfCTG1u0y8Xz8FKqtKPE9A1+E
         Sad4m75SpmIB9QrtitznFk/U24uNVb4hrVNdO3WR9PCSAa+WT9nGrZiAdQpUDzUgWAC2
         avZj3uGCGsvqjKOPHoLC/WJ/jOv4KQXPURPLOJxItNqs4/tCj4S6lMwinNtiyE5tKm3J
         dmuue9x++0VQU+F8n0qXZPyQ48ehkvbq2kPeafdcwdy6/Fg3v9tONNtooAtTNX+R+I4g
         ofEFehxv+U8fWJazKyhIUIK4Ohge3/6nEdRZnQ9v9G9A0OGGVpDRSUx1OaLL5zKjIg1d
         PqGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrK26fkC3IGM+S8yEy8zT+hzT+ARoHLCTowkV3ge82dmF2pOOzSz34cu3lDlnFjwDhk3SX+juqJ2jbDTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXrPnE13kTsA0pZQv3riHn5irxP1iJn7qE+j0j8umR1kwbVStH
	4fdU2gkRrply4esl0F4wZbNlhftPaN3WHZCdGqcdCxnxm2zgCvWWARop3IQ7ChqMPpEwiUpY6cw
	cYTX4zMIE+Ji0jo7LjRFAgd4pxmY=
X-Gm-Gg: ASbGncvyTby8taEMemqy218nQi9tkc1TCT6mboXaslCStYs8ea+tvUZHYuU/2CbampP
	dh8dv7Roaj+83YsDaT125Ej05IrceUirHeGv1wA+iPzp+XoNIgoyZczI8fOL4TET0+XdJBlELuz
	xtE1iecyC2mj86AAQCRdOFKqTwVjok0zvOPcDB5A==
X-Google-Smtp-Source: AGHT+IHnacd1EO2fA0BCrhBmew4ClDZnEqgIHehs6/WfxW5IdNYnTw1DnACPp9MwTxNVzP0KDkmlkyEhavYW2JuUBjc=
X-Received: by 2002:a17:907:1b16:b0:abf:742e:1fca with SMTP id
 a640c23a62f3a-ac252a9e1e0mr1443040266b.18.1741604633932; Mon, 10 Mar 2025
 04:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <84441660bef0a5e67fd09dc3787178d0276dad31.1740664400.git.hongyan.xia2@arm.com>
 <4394f2a7-b4e8-419a-a299-f1afa560c944@arm.com> <CAB8ipk_627GF+TV5u=6DK_3aRUHW8qGYwmN+KXMq_Cg-+Say1Q@mail.gmail.com>
 <bf5a70bf-3d13-4b3b-a3ef-804998b21fe9@arm.com> <CAB8ipk-SUFDATb=euJQFebxQ513SRwTEpSbBSD6K=batQKELHg@mail.gmail.com>
 <80c2c9f4-eb84-4a43-9c48-8f776615b45a@arm.com>
In-Reply-To: <80c2c9f4-eb84-4a43-9c48-8f776615b45a@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Mon, 10 Mar 2025 19:03:41 +0800
X-Gm-Features: AQ5f1JrY3qEjfDyzCNw4GX0UhOiRNBWcFqVLNtj4zvjRxSSPp0noSZZz8DkT4M0
Message-ID: <CAB8ipk8pEvOtCm-d0o1rsekwxPWUHk9iBGtt9TLTWW-iWTQKiA@mail.gmail.com>
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

Hi Dietmar,

On Mon, Mar 10, 2025 at 6:53=E2=80=AFPM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 10/03/2025 03:41, Xuewen Yan wrote:
> > On Sat, Mar 8, 2025 at 2:32=E2=80=AFAM Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 06/03/2025 13:01, Xuewen Yan wrote:
> >>> On Thu, Mar 6, 2025 at 2:24=E2=80=AFAM Dietmar Eggemann
> >>> <dietmar.eggemann@arm.com> wrote:
> >>>>
> >>>> On 27/02/2025 14:54, Hongyan Xia wrote:
> >>>>
> >>>> [...]
> >>>>
> >>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>>>> index 857808da23d8..7e5a653811ad 100644
> >>>>> --- a/kernel/sched/fair.c
> >>>>> +++ b/kernel/sched/fair.c
> >>>>> @@ -6941,8 +6941,10 @@ enqueue_task_fair(struct rq *rq, struct task=
_struct *p, int flags)
> >>>>>        * Let's add the task's estimated utilization to the cfs_rq's
> >>>>>        * estimated utilization, before we update schedutil.
> >>>>>        */
> >>>>> -     if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (fla=
gs & ENQUEUE_RESTORE))))
> >>>>> +     if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (fla=
gs & ENQUEUE_RESTORE)))) {
> >>>>> +             uclamp_rq_inc(rq, p);
> >>>>>               util_est_enqueue(&rq->cfs, p);
> >>>>> +     }
> >>>>
> >>>> So you want to have p uclamp-enqueued so that its uclamp_min value
> >>>> counts for the cpufreq_update_util()/cfs_rq_util_change() calls late=
r in
> >>>> enqueue_task_fair?
> >>>>
> >>>>   if (p->in_iowait)
> >>>>     cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
> >>>>
> >>>>   enqueue_entity() -> update_load_avg() -> cfs_rq_util_change() ->
> >>>>   cpufreq_update_util()
> >>>>
> >>>> But if you do this before requeue_delayed_entity() (1) you will not
> >>>> uclamp-enqueue p which got his ->sched_delayed just cleared in (1)?
> >>>>
> >>>
> >>> Could we change to the following:
> >>>
> >>> when enqueue:
> >>>
> >>> -     if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags
> >>> & ENQUEUE_RESTORE))))
> >>> +     if (!(p->se.sched_delayed && !(flags & ENQUEUE_DELAYED)))
> >>
> >> Why you want to check ENQUEUE_DELAYED as well here? Isn't
> >> !p->se.sched_delayed implying !ENQUEUE_DELAYED).
> >
> > Indeed, the (!(p->se.sched_delayed && !(flags & ENQUEUE_DELAYED))) is e=
qual to
> > the  (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags &
> > ENQUEUE_RESTORE)))).
> > I just think it might be easier to read using the ENQUEUE_DELAYED flag.
> > Because we only allow enq the uclamp and util_est when wake up the dela=
yed-task.
>
> OK, I see.
>
> So that means we would not have to move the uclamp handling into the sche=
d
> classes necessarily, we could use flags in enqueue_task() as well:
>
> -->8--
>
> Subject: [PATCH] Align uclamp and util_est and call before freq update
>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/core.c | 14 ++++++++------
>  kernel/sched/fair.c |  4 ++--
>  2 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b60916d77482..f833108a3b2d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1747,7 +1747,8 @@ static inline void uclamp_rq_dec_id(struct rq *rq, =
struct task_struct *p,
>         }
>  }
>
> -static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
> +static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p,
> +                                int flags)
>  {
>         enum uclamp_id clamp_id;
>
> @@ -1763,7 +1764,7 @@ static inline void uclamp_rq_inc(struct rq *rq, str=
uct task_struct *p)
>         if (unlikely(!p->sched_class->uclamp_enabled))
>                 return;
>
> -       if (p->se.sched_delayed)
> +       if (p->se.sched_delayed && !(flags & ENQUEUE_DELAYED))
>                 return;
>
>         for_each_clamp_id(clamp_id)
> @@ -2067,12 +2068,13 @@ void enqueue_task(struct rq *rq, struct task_stru=
ct *p, int flags)
>         if (!(flags & ENQUEUE_NOCLOCK))
>                 update_rq_clock(rq);
>
> -       p->sched_class->enqueue_task(rq, p, flags);
>         /*
> -        * Must be after ->enqueue_task() because ENQUEUE_DELAYED can cle=
ar
> -        * ->sched_delayed.
> +        * Can be before ->enqueue_task() because uclamp considers the
> +        * ENQUEUE_DELAYED task before its ->sched_delayed gets cleared
> +        * in ->enqueue_task().
>          */
> -       uclamp_rq_inc(rq, p);
> +       uclamp_rq_inc(rq, p, flags);
> +       p->sched_class->enqueue_task(rq, p, flags);
>
>         psi_enqueue(p, flags);
>

I submitted a patch similar to yours before:

https://lore.kernel.org/all/CAB8ipk_AvaOWp9QhmnFDdbFSWcKLhCH151=3Dno6kRO2z+=
pSJfyQ@mail.gmail.com/

And Hongyan fears that as more complexity goes into each sched_class
like delayed dequeue,
so it's better to just let the sched_class handle how uclamp is
enqueued and dequeued within itself rather than leaking into core.c.


> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 061a29e88ee2..e26d1dfea601 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6951,7 +6951,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct=
 *p, int flags)
>          * Let's add the task's estimated utilization to the cfs_rq's
>          * estimated utilization, before we update schedutil.
>          */
> -       if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags &=
 ENQUEUE_RESTORE))))
> +       if (!p->se.sched_delayed || (flags & ENQUEUE_DELAYED))
>                 util_est_enqueue(&rq->cfs, p);
>
>         if (flags & ENQUEUE_DELAYED) {
> @@ -7193,7 +7193,7 @@ static int dequeue_entities(struct rq *rq, struct s=
ched_entity *se, int flags)
>   */
>  static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int =
flags)
>  {
> -       if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags &=
 DEQUEUE_SAVE))))
> +       if (!p->se.sched_delayed)
>                 util_est_dequeue(&rq->cfs, p);
>
>         util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
> --
> 2.34.1

