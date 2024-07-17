Return-Path: <linux-kernel+bounces-254895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D169338F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB351F23B46
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626DE39FFE;
	Wed, 17 Jul 2024 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4UBxEUb"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C04383B2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721204790; cv=none; b=JBFLYVfhVyxXXA1fk0L+Af3r8VlyASfk4pbFi1GpSiPLy7dPHPdCz0uChtOb0jg8WjCnGDqFCty74AzMwep82bpSt1RbMn26VGBzN+Ah4hkWmglMU9t7y6j/R3Iz/DTuJ+GRRlEdiZWyw2MFi0JsaFDzMyTPXfaJTXoxkp55SMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721204790; c=relaxed/simple;
	bh=Kx/PPYl/O9tFMKGNyqbM3elgXoFZmDegn3IoV7KT51s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgIz3Bd1bMg4ya8+kC612hKjCRfgMFpNCuAp1hrw9/o7NhxSk1r4ZCOomKgZTdCZ9JMANVtzVSD0rQ5zYFaR5GGifxuOVHScYbW9nJsQLb9wyNpcwwHBxUEZzfIYjs5rar7EGyPk+gJsz+0svDIn3NrR6UmXVoyKaVhU5+YFYXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4UBxEUb; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25e1610e359so2827478fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 01:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721204788; x=1721809588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0pvikHoZAbxdJeRTItG7pgAV7GYU3xRMDxJdbny26g=;
        b=K4UBxEUbRYi5X3qnw1jpXdxuVtEuFVXe6k1QqMt3gwFZ/MLtEkGMl2H6bZIrgl+B+g
         jKMarMWGEjAB26ZHZUbQomryHeBx2xlosjwJFf959ekq+c4yQYwEL/A9c67l9DdGFL1g
         cF/chrj9vPjGUVXXpGCKUwmJrDD2b+t3D5FEgMH94MSLhWqOxlWURWdGTjI5QaZrZwKR
         yTeDZQX3NDhKZcEWXwhf8IcVUNMTPlT6jR2/kOj6j73FDyzLauMwrrLOi3ryPZo0A0eQ
         NK9Hp/1GUh1xSDOEvZETyX1rG3OZ25ZmnU1D2E1lOwXqqFc16GowYVjc8Y4aPTsSAV+U
         Ceww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721204788; x=1721809588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0pvikHoZAbxdJeRTItG7pgAV7GYU3xRMDxJdbny26g=;
        b=Yn+D11Z9oprAnst5fpsS8YxnPfL1rmKGeXFjZI5DNoAYsHBtqC7OPOLbwOSFXs+8xJ
         +d4rW0bk4AYZ1oINmFZTVF51iA/lmllGPK8fR+UA80sBN8GO87cTFhYokWKfEbM1g4Ks
         G43Xb33IIURQN8maB4oLTekYW0r9mHJgp2pyXSAdO4B0X5opU8/4M+ra+WWBkx7u/49Q
         PObiYYBfoKIQImXnsXkWLDNh+mVltLrd8tsEFa8D0VGgv5q47BbsKgLVbaTkBEcqUNLm
         s71WmwI9RRR6MdjTbSd+lPbRcOwg2ZFnxUqv1d6P3r+N3HEYq+5qESYOqFordebbnMrb
         RcXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoB1dDddGc35XbJdIXqmU0PfBTLtdlC7b2+3w+ufFlLOYsKXktgOIoWFfsztDyIh8dcsIdi4vcFbRVsfR1tuHfSbLM/ee+YE65Da+K
X-Gm-Message-State: AOJu0YxI51m7Jbdt68lLivBQaSmdIqmpWzi7CJ/npBVRzDHiZE9gCf+R
	QTbFehKTWff1uFYIChy3HpHJNfChbPouuoeUHU96jl6yuzI+Iwmu5yC9+grw5dNLTMNNyGMzDnJ
	i0N2JSFzeK9nSjHikV2k91f0RNb0=
X-Google-Smtp-Source: AGHT+IEi8+LAqr7M7+PlXXU+d8PD+/+v8r2Ml37OoEb6w6b3ZDcOFiZLaXpWjdOhauWV6In6pzCMI/P2W3A82AZQXPY=
X-Received: by 2002:a05:6870:9688:b0:259:5907:d714 with SMTP id
 586e51a60fabf-260d91f45b7mr803094fac.42.1721204787723; Wed, 17 Jul 2024
 01:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231209011759.398021-1-qyousef@layalina.io> <20231209011759.398021-3-qyousef@layalina.io>
In-Reply-To: <20231209011759.398021-3-qyousef@layalina.io>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Wed, 17 Jul 2024 16:26:16 +0800
Message-ID: <CAB8ipk9+4p29iE8HSiRrcc8DanCcO2U3+HRVY5LXLJRWXFMpOw@mail.gmail.com>
Subject: Re: [PATCH 2/3] sched/fair: Generalize misfit lb by adding a misfit reason
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>, 
	Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>, 
	Xuewen Yan <xuewen.yan@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qais

On Sat, Dec 9, 2023 at 9:19=E2=80=AFAM Qais Yousef <qyousef@layalina.io> wr=
ote:
>
> MISFIT_PERF is what is currently implemented. It indicates that the task
> requires moving to a more performant CPU.
>
> Guard misfit handling in find_busiest_queue and update_sd_pick_busiest
> with MISFIT_PERF. They explicitly assume this type of misfit
>
> This generalizes misfit lb to allow for more types of misfits to be
> added. Like MISFIT_POWER to help uclamp_max being more effective, and
> MISFIT_LATENCY to help latency sensitive tasks to be spread in
> oversubscribe conditions.
>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  kernel/sched/fair.c  | 28 +++++++++++++++++++++++-----
>  kernel/sched/sched.h |  8 ++++++++
>  2 files changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index eb9e891182cc..dd49b89a6e3e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5063,7 +5063,8 @@ static inline int task_fits_cpu(struct task_struct =
*p, int cpu)
>         return (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0);
>  }
>
> -static inline int is_misfit_task(struct task_struct *p, struct rq *rq)
> +static inline int is_misfit_task(struct task_struct *p, struct rq *rq,
> +                                misfit_reason_t *reason)
>  {
>         if (!p || p->nr_cpus_allowed =3D=3D 1)
>                 return 0;
> @@ -5071,16 +5072,21 @@ static inline int is_misfit_task(struct task_stru=
ct *p, struct rq *rq)
>         if (task_fits_cpu(p, cpu_of(rq)))
>                 return 0;
>
> +       if (reason)
> +               *reason =3D MISFIT_PERF;
>         return 1;
>  }
>
>  static inline void update_misfit_status(struct task_struct *p, struct rq=
 *rq)
>  {
> +       misfit_reason_t reason;
> +
>         if (!sched_asym_cpucap_active())
>                 return;
>
> -       if (!is_misfit_task(p, rq)) {
> +       if (!is_misfit_task(p, rq, &reason)) {
>                 rq->misfit_task_load =3D 0;
> +               rq->misfit_reason =3D -1;
>                 return;
>         }
>
> @@ -5089,6 +5095,7 @@ static inline void update_misfit_status(struct task=
_struct *p, struct rq *rq)
>          * task_h_load() returns 0.
>          */
>         rq->misfit_task_load =3D max_t(unsigned long, task_h_load(p), 1);
> +       rq->misfit_reason =3D reason;
>  }
>
>  #else /* CONFIG_SMP */
> @@ -9111,7 +9118,7 @@ static int detach_tasks(struct lb_env *env)
>
>                 case migrate_misfit:
>                         /* This is not a misfit task */
> -                       if (!is_misfit_task(p, cpu_rq(env->src_cpu)))
> +                       if (!is_misfit_task(p, cpu_rq(env->src_cpu), NULL=
))
>                                 goto next;
>
>                         env->imbalance =3D 0;
> @@ -9426,6 +9433,7 @@ struct sg_lb_stats {
>         unsigned int group_asym_packing; /* Tasks should be moved to pref=
erred CPU */
>         unsigned int group_smt_balance;  /* Task on busy SMT be moved */
>         unsigned long group_misfit_task_load; /* A CPU has a task too big=
 for its capacity */
> +       misfit_reason_t group_misfit_reason;
>  #ifdef CONFIG_NUMA_BALANCING
>         unsigned int nr_numa_running;
>         unsigned int nr_preferred_running;
> @@ -9904,6 +9912,7 @@ static inline void update_sg_lb_stats(struct lb_env=
 *env,
>                         /* Check for a misfit task on the cpu */
>                         if (sgs->group_misfit_task_load < rq->misfit_task=
_load) {
>                                 sgs->group_misfit_task_load =3D rq->misfi=
t_task_load;
> +                               sgs->group_misfit_reason =3D rq->misfit_r=
eason;
>                                 *sg_status |=3D SG_OVERLOAD;
>                         }
>                 } else if ((env->idle !=3D CPU_NOT_IDLE) &&
> @@ -9969,6 +9978,7 @@ static bool update_sd_pick_busiest(struct lb_env *e=
nv,
>          */
>         if ((env->sd->flags & SD_ASYM_CPUCAPACITY) &&
>             (sgs->group_type =3D=3D group_misfit_task) &&
> +           (sgs->group_misfit_reason =3D=3D MISFIT_PERF) &&
>             (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_ca=
pacity) ||
>              sds->local_stat.group_type !=3D group_has_spare))
>                 return false;
> @@ -10193,6 +10203,7 @@ static inline void update_sg_wakeup_stats(struct =
sched_domain *sd,
>
>         for_each_cpu(i, sched_group_span(group)) {
>                 struct rq *rq =3D cpu_rq(i);
> +               misfit_reason_t reason;
>                 unsigned int local;
>
>                 sgs->group_load +=3D cpu_load_without(rq, p);
> @@ -10212,9 +10223,15 @@ static inline void update_sg_wakeup_stats(struct=
 sched_domain *sd,
>
>                 /* Check if task fits in the CPU */
>                 if (sd->flags & SD_ASYM_CPUCAPACITY &&
> -                   sgs->group_misfit_task_load &&
> -                   !is_misfit_task(p, rq))
> +                   sgs->group_misfit_task_load) {
> +                   if (!is_misfit_task(p, rq, &reason)) {
>                         sgs->group_misfit_task_load =3D 0;
> +                       sgs->group_misfit_reason =3D -1;
> +                   } else {
> +                       sgs->group_misfit_task_load =3D max_t(unsigned lo=
ng, task_h_load(p), 1);
> +                       sgs->group_misfit_reason =3D reason;
> +                   }
> +               }
>
>         }
>
> @@ -11008,6 +11025,7 @@ static struct rq *find_busiest_queue(struct lb_en=
v *env,
>                  * average load.
>                  */
>                 if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
> +                   rq->misfit_reason =3D=3D MISFIT_PERF &&

In Android, I found this would cause a task loop to change the CPUs.
Maybe this should be removed. Because for the same capacity cpus, we
should skip this cpu when nr_running=3D1.

>                     !capacity_greater(capacity_of(env->dst_cpu), capacity=
) &&
>                     nr_running =3D=3D 1)
>                         continue;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e58a54bda77d..399b6526afab 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -962,6 +962,10 @@ struct balance_callback {
>         void (*func)(struct rq *rq);
>  };
>
> +typedef enum misfit_reason {
> +       MISFIT_PERF,            /* Requires moving to a more performant C=
PU */
> +} misfit_reason_t;
> +
>  /*
>   * This is the main, per-CPU runqueue data structure.
>   *
> @@ -1168,6 +1172,10 @@ struct rq {
>         call_single_data_t      cfsb_csd;
>         struct list_head        cfsb_csd_list;
>  #endif
> +
> +#ifdef CONFIG_SMP
> +       misfit_reason_t         misfit_reason;
> +#endif
>  };
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> --
> 2.34.1
>

