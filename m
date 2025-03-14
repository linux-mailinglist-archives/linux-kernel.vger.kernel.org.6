Return-Path: <linux-kernel+bounces-561055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064EFA60D09
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39EC1188A8F8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02F61DE8A5;
	Fri, 14 Mar 2025 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSQA+dQx"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4701C84AF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943970; cv=none; b=LZtZzG3YFL81XWqPhqq/+Bo5M+pdlD/IqpO6DSTzYpWLnfPYGzAkFz+w0SIIk9urLCbM0KIt86d/6+1hdItqsXqIuHcytIso3hC3vvrJy8Y76JupLUVE/86hyxHjtj6RbhUFUh8JEnZ1ukuIlwffUGbN3Sk2VrzQnu0sDkVa4fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943970; c=relaxed/simple;
	bh=JsGiqSxQ+uES/UVBw++SAa8K/pq1wo8w1GM7hPbd5vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THQfgL+dMMeqywa7Xx2LqFwsgCRGAnLj9Ogw2h38qkbzzkkrORbsKKzNngua0vtbC96jZZdGhnqGHL7t/hVRxvuKZKHK89j/ljknMS0wcFwQvF4gzX38xpZmwIYiyK8YpBzdw+q+HjgmaMTzQe1kh7lGocmAy8cfJRJaQCcxhUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSQA+dQx; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac298c8fa50so352825366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741943966; x=1742548766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8mewEtYRY7SCffsa0BO3r3igwVwITc1Ia4jv49hzOA=;
        b=ZSQA+dQxhtG4Z3RGA+dV4gCeQOxkz5e/aPItz1AZLom5GGrk1j5i9tWrO75DfM+lwV
         mhqBC+bbGD3EqA4gO+4+Pk5ysooX/1FLw6rmdqJKO5/28mQFfmsdaWuC1v8/WGQmfuFR
         0u5RfG8L/m4l9AOqkFnCgldY3h6XNcbsIfnQpgR3p0h8qPPHpWgqtT3ScGCKUienLyiL
         sOCY4nbZAPkjUJEd9ZmXNz60Wu8O0uvtlgk8oACyA9hi5W57beyEw8tr5apnFsdxF/rM
         CAtc3aSh/b4oT6Jj2TddMHcjL4vJgMI4VPmkJpmL/oHk3E1rjC6+DSQ1MRS3MJVGBNJW
         oeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741943966; x=1742548766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8mewEtYRY7SCffsa0BO3r3igwVwITc1Ia4jv49hzOA=;
        b=etBTdcEcVOxVXITSOyO0Ketr6qPtq2qTRsEjCDZkmnscfbsT8IUgjlPY5Ly0DDGHUz
         +ei9M+MmelsPEoECShJWTNT13ShX6EBkP3aNbPQBenystmi+7Br3ak+Ga+QHQA/KvX+c
         fu+mJJjHznUhNdb9fzecENR/kY5keqMd44rwEVJuy1d0AnpuHkzPGLFUKiA6keKHglZ3
         6shdxSFdS7pSK9kUgy7NADNDvEnZSOP+2QRb/rjlvLhXPiiJcFoRvxU9XtQJgao7eZiU
         Lw16SpHTTDPKX4kSLkF27/3joyyJl/mcxWF4iIwn4dIqY+qgFhcN1QAApVKVL4vlBrxS
         mWEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgQOex7GqnXlWu36m7BlMglleJewXL0a8I6ZIp9rJ0CpGWPVd0VaPpZaBD4BLXc4dS0t9k2zUsVscg6VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUCXT/9S0w8WE2LRAYQSHVTbCwpCUi026T/SelDlzWdiVrOcVr
	NAa46EcpvjKcTC3boeto6YkwYqZLHJInao+nTNhFjH2/p0XUPuErtqubyBY+dCr5rV7YgN84h2y
	oxd7GCgUe01D6akDzFeHN2YCAA/M=
X-Gm-Gg: ASbGncvoAY/MNe2KJXU6OV7M6Jl6+0zf9QMY9KDirUw5+fldSnq/fYyV3o0dVlzt1xp
	OXUaKjV7k7i5TtHQUuHKWLsjhyw6MiFQ1xIp088pkrQuf6gX/+ug2JQmbx2DJ89hbUiCTURe3OQ
	NPUY7qv/bbEm9iaWC24rKsan6N728=
X-Google-Smtp-Source: AGHT+IFYg8xOH85El3VZg3ODncvjagdMkBT1KtYdSIH7bMhDvOoJdlEFTniIcI57WR47dSzYFFSud1zWYiLjzP4IIDM=
X-Received: by 2002:a17:906:794d:b0:ac1:fea1:3b68 with SMTP id
 a640c23a62f3a-ac3303f75bamr187994766b.41.1741943966100; Fri, 14 Mar 2025
 02:19:26 -0700 (PDT)
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
Date: Fri, 14 Mar 2025 17:19:13 +0800
X-Gm-Features: AQ5f1Jps4fuEE1ZYvAgfzlQF4s2SJ2zt-HKok9QDYc4B8OXQ1I0Ja_hzQkSeYO8
Message-ID: <CAB8ipk_1gimUxswgqnYRbhgA9Zims-iKHiEusfNJJdNyLYNwGg@mail.gmail.com>
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

Hi Dietmar  and Hongyan,

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
Whether uclamp should be placed in the class might require further
discussion, but at this point, I believe the conditions for util-est
can be simplified.
I discovered another issue with util-est in the past couple of days,
and I have also included the simplification of its condition check in
the same patch.
Could you please help review it?
https://lore.kernel.org/all/20250314090909.8404-1-xuewen.yan@unisoc.com/

Thanks!
BR

>                 util_est_dequeue(&rq->cfs, p);
>
>         util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
> --
> 2.34.1
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>

