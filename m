Return-Path: <linux-kernel+bounces-273555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FC9946A96
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 19:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098D51F2124C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 17:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD3814265;
	Sat,  3 Aug 2024 17:08:47 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FC61078B
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722704926; cv=none; b=EVZHyNdWPLiy0kgOF333x/7i44PhVC2+pwsDabn8rtkZqe0KPLroJ1r0/Hh6V4AEr8GUIubidQcrChl04VWlygXxgOgdN3JH3k5DBC25eNJPYh740QYl+veUhFs53tqOycyRoL4mfzEZqwxQ3fZm4DQl5hD66j+Yqr9pHjLHp1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722704926; c=relaxed/simple;
	bh=I//yWTIIG1UCOTwiHZobDYDy6T7OT2Eq/zErguHRvEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8DGCH7iDc00sV1jTsf4haXJWl4K4gFk2EPK0NtMAx9+FCar17CuAhIng3pRr1/pQQbMl4dpeo8WvC9h5yJClKCYm95t9EB66/HIJ5uqeQqqzlw0d2m+mQHtvyFbc7upslXJs/ajvEgT0Jja3qsmwW2lhunEV88/jdoCUJfoXSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7a92098ec97so6216129a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 10:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722704924; x=1723309724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fn/0uLSlhlTd3bl5UifS9dvTBHWbbFLP5seR1ppdIqY=;
        b=g5qkgsRw4hOiTAGERrJCKBrEj+owgKLYTKPL7HwSsI3XXdJJYKQlg7lgKhQOlai/yd
         p0qnFTHzcfvEUpZqO4sO5FoKm9gCOWSlFnPWpc5BV2bJDBkNkv7aRAI41bBjClY2iqxv
         NFrIJ3Y8N6nnywazWxLwHiewRxeNkag3Xe6p8NtxGq74yFzM4+MgfmDkaBMqugUrWADZ
         X/uZv3oOoS2X9jgft9zo7mnEhl0efkjPrAsqoOdOFti9JURa4jeGqwBzd6I2pfR7dJ/V
         QVMt19niMX3SihOZ14cbWzsRkFvZvQsx6zL1vX2BuJ+tx859s4vkj1VpT+b33WWEgJr7
         gfzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs+Fku4A/7dHAG/APO4D0OHW92w9gVN+oydWwMXtvAbycs+hP4e08npMyg47KOirkH6QSu7ycTn9B3APzZ9Cc/2b11+IuZb2Oqzy/G
X-Gm-Message-State: AOJu0YyjrUwkZ+ECvPKHuOkYtwRKaTO9whDbTh0JucOc+E3gDYGyJZFT
	xalKpoCvgC5ltjUPbhqa6Um/nzp0OB9xIDa8+YoVMpvYaFTljgBBCCfXpOBFJHCV8wLl38U4aiJ
	J1QGa8QjkVrsOW+rXh1ClGDnoORQ=
X-Google-Smtp-Source: AGHT+IHbdhNHaWI8z6YMH0R8/F8InSm2sWQC9qLd2/TUhHPawM4u1LpJYyRJHzVKiGUGBnsDxh9yywbktdyJGtCfMrg=
X-Received: by 2002:a05:6a21:999d:b0:1c4:f0e0:9ec with SMTP id
 adf61e73a8af0-1c699559c57mr9977398637.20.1722704923509; Sat, 03 Aug 2024
 10:08:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731000607.543783-1-namhyung@kernel.org> <476e7cea-f987-432a-995b-f7d52a123c9d@linux.intel.com>
 <20240802183841.GG37996@noisy.programming.kicks-ass.net> <20240802184350.GA12673@noisy.programming.kicks-ass.net>
 <20240802185023.GB12673@noisy.programming.kicks-ass.net> <20240802191123.GC12673@noisy.programming.kicks-ass.net>
 <20240803103202.GD12673@noisy.programming.kicks-ass.net>
In-Reply-To: <20240803103202.GD12673@noisy.programming.kicks-ass.net>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sat, 3 Aug 2024 10:08:32 -0700
Message-ID: <CAM9d7cgNZQrJk7-TnMgqvCMpkYkcpBT78Ts_5oTsAzNB9gp+_w@mail.gmail.com>
Subject: Re: [PATCH v2] perf/core: Optimize event reschedule for a PMU
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 3:32=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Fri, Aug 02, 2024 at 09:11:23PM +0200, Peter Zijlstra wrote:
>
> > But I'll have to continue staring at this later.
>
> OK, I have the below, which boots and seems able to do:
>
>   perf stat -ae power/energy-pkg/ -- sleep 1
>
> and
>
>   perf top
>
> also still works, so it must be perfect, right, right?

I really hope so. :)  I'll test it over the weekend.

>
> It should be split up in at least 3, possibly more patches, but that's
> for Monday. Now I get to mow the lawn or any of the other real-life
> things weekends are for :-)

Sure.

>
> It also isn't ideal in that it still has a ton of pmu_ctx_list
> iteration, but at least it will skip all the expensive parts.

Yep, I think it's good enough.

>
> ---
>  kernel/events/core.c | 210 +++++++++++++++++++++++++++------------------=
------
>  1 file changed, 110 insertions(+), 100 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c01a32687dad..2e30ac0fbaf6 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -685,30 +685,32 @@ do {                                               =
                       \
>         ___p;                                                           \
>  })
>
> +#define for_each_epc(_epc, _ctx, _pmu, _cgroup)                         =
       \
> +       list_for_each_entry(_epc, &((_ctx)->pmu_ctx_list), pmu_ctx_entry)=
 \
> +               if (_cgroup && !_epc->nr_cgroups)                       \
> +                       continue;                                       \
> +               else if (_pmu && _epc->pmu !=3D _pmu)                    =
 \
> +                       continue;                                       \
> +               else
> +
>  static void perf_ctx_disable(struct perf_event_context *ctx, bool cgroup=
)
>  {
>         struct perf_event_pmu_context *pmu_ctx;
>
> -       list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> -               if (cgroup && !pmu_ctx->nr_cgroups)
> -                       continue;
> +       for_each_epc(pmu_ctx, ctx, NULL, cgroup)
>                 perf_pmu_disable(pmu_ctx->pmu);
> -       }
>  }
>
>  static void perf_ctx_enable(struct perf_event_context *ctx, bool cgroup)
>  {
>         struct perf_event_pmu_context *pmu_ctx;
>
> -       list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> -               if (cgroup && !pmu_ctx->nr_cgroups)
> -                       continue;
> +       for_each_epc(pmu_ctx, ctx, NULL, cgroup)
>                 perf_pmu_enable(pmu_ctx->pmu);
> -       }
>  }
>
> -static void ctx_sched_out(struct perf_event_context *ctx, enum event_typ=
e_t event_type);
> -static void ctx_sched_in(struct perf_event_context *ctx, enum event_type=
_t event_type);
> +static void ctx_sched_out(struct perf_event_context *ctx, struct pmu *pm=
u, enum event_type_t event_type);
> +static void ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu=
, enum event_type_t event_type);
>
>  #ifdef CONFIG_CGROUP_PERF
>
> @@ -865,7 +867,7 @@ static void perf_cgroup_switch(struct task_struct *ta=
sk)
>         perf_ctx_lock(cpuctx, cpuctx->task_ctx);
>         perf_ctx_disable(&cpuctx->ctx, true);
>
> -       ctx_sched_out(&cpuctx->ctx, EVENT_ALL|EVENT_CGROUP);
> +       ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
>         /*
>          * must not be done before ctxswout due
>          * to update_cgrp_time_from_cpuctx() in
> @@ -877,7 +879,7 @@ static void perf_cgroup_switch(struct task_struct *ta=
sk)
>          * perf_cgroup_set_timestamp() in ctx_sched_in()
>          * to not have to pass task around
>          */
> -       ctx_sched_in(&cpuctx->ctx, EVENT_ALL|EVENT_CGROUP);
> +       ctx_sched_in(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
>
>         perf_ctx_enable(&cpuctx->ctx, true);
>         perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> @@ -2328,6 +2330,24 @@ group_sched_out(struct perf_event *group_event, st=
ruct perf_event_context *ctx)
>                 event_sched_out(event, ctx);
>  }
>
> +static void
> +ctx_update_time(struct perf_cpu_context *cpuctx, struct perf_event_conte=
xt *ctx)
> +{
> +       if (ctx->is_active & EVENT_TIME) {
> +               update_context_time(ctx);
> +               update_cgrp_time_from_cpuctx(cpuctx, false);
> +       }
> +}
> +
> +static void
> +ctx_update_event_time(struct perf_event_context *ctx, struct perf_event =
*event)
> +{
> +       if (ctx->is_active & EVENT_TIME) {
> +               update_context_time(ctx);
> +               update_cgrp_time_from_event(event);
> +       }
> +}
> +
>  #define DETACH_GROUP   0x01UL
>  #define DETACH_CHILD   0x02UL
>  #define DETACH_DEAD    0x04UL
> @@ -2347,10 +2367,7 @@ __perf_remove_from_context(struct perf_event *even=
t,
>         struct perf_event_pmu_context *pmu_ctx =3D event->pmu_ctx;
>         unsigned long flags =3D (unsigned long)info;
>
> -       if (ctx->is_active & EVENT_TIME) {
> -               update_context_time(ctx);
> -               update_cgrp_time_from_cpuctx(cpuctx, false);
> -       }
> +       ctx_update_time(cpuctx, ctx);
>
>         /*
>          * Ensure event_sched_out() switches to OFF, at the very least
> @@ -2435,12 +2452,8 @@ static void __perf_event_disable(struct perf_event=
 *event,
>         if (event->state < PERF_EVENT_STATE_INACTIVE)
>                 return;
>
> -       if (ctx->is_active & EVENT_TIME) {
> -               update_context_time(ctx);
> -               update_cgrp_time_from_event(event);
> -       }
> -
>         perf_pmu_disable(event->pmu_ctx->pmu);
> +       ctx_update_event_time(ctx, event);
>
>         if (event =3D=3D event->group_leader)
>                 group_sched_out(event, ctx);
> @@ -2656,7 +2669,8 @@ static void add_event_to_ctx(struct perf_event *eve=
nt,
>  }
>
>  static void task_ctx_sched_out(struct perf_event_context *ctx,
> -                               enum event_type_t event_type)
> +                              struct pmu *pmu,
> +                              enum event_type_t event_type)
>  {
>         struct perf_cpu_context *cpuctx =3D this_cpu_ptr(&perf_cpu_contex=
t);
>
> @@ -2666,18 +2680,19 @@ static void task_ctx_sched_out(struct perf_event_=
context *ctx,
>         if (WARN_ON_ONCE(ctx !=3D cpuctx->task_ctx))
>                 return;
>
> -       ctx_sched_out(ctx, event_type);
> +       ctx_sched_out(ctx, pmu, event_type);
>  }
>
>  static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
> -                               struct perf_event_context *ctx)
> +                               struct perf_event_context *ctx,
> +                               struct pmu *pmu)
>  {
> -       ctx_sched_in(&cpuctx->ctx, EVENT_PINNED);
> +       ctx_sched_in(&cpuctx->ctx, pmu, EVENT_PINNED);
>         if (ctx)
> -                ctx_sched_in(ctx, EVENT_PINNED);
> -       ctx_sched_in(&cpuctx->ctx, EVENT_FLEXIBLE);
> +                ctx_sched_in(ctx, pmu, EVENT_PINNED);
> +       ctx_sched_in(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
>         if (ctx)
> -                ctx_sched_in(ctx, EVENT_FLEXIBLE);
> +                ctx_sched_in(ctx, pmu, EVENT_FLEXIBLE);
>  }
>
>  /*
> @@ -2695,16 +2710,12 @@ static void perf_event_sched_in(struct perf_cpu_c=
ontext *cpuctx,
>   * event_type is a bit mask of the types of events involved. For CPU eve=
nts,
>   * event_type is only either EVENT_PINNED or EVENT_FLEXIBLE.
>   */
> -/*
> - * XXX: ctx_resched() reschedule entire perf_event_context while adding =
new
> - * event to the context or enabling existing event in the context. We ca=
n
> - * probably optimize it by rescheduling only affected pmu_ctx.
> - */
>  static void ctx_resched(struct perf_cpu_context *cpuctx,
>                         struct perf_event_context *task_ctx,
> -                       enum event_type_t event_type)
> +                       struct pmu *pmu, enum event_type_t event_type)
>  {
>         bool cpu_event =3D !!(event_type & EVENT_CPU);
> +       struct perf_event_pmu_context *epc;
>
>         /*
>          * If pinned groups are involved, flexible groups also need to be
> @@ -2715,10 +2726,14 @@ static void ctx_resched(struct perf_cpu_context *=
cpuctx,
>
>         event_type &=3D EVENT_ALL;
>
> -       perf_ctx_disable(&cpuctx->ctx, false);
> +       for_each_epc(epc, &cpuctx->ctx, pmu, false)
> +               perf_pmu_disable(epc->pmu);
> +
>         if (task_ctx) {
> -               perf_ctx_disable(task_ctx, false);
> -               task_ctx_sched_out(task_ctx, event_type);
> +               for_each_epc(epc, task_ctx, pmu, false)
> +                       perf_pmu_disable(epc->pmu);
> +
> +               task_ctx_sched_out(task_ctx, pmu, event_type);
>         }
>
>         /*
> @@ -2729,15 +2744,19 @@ static void ctx_resched(struct perf_cpu_context *=
cpuctx,
>          *  - otherwise, do nothing more.
>          */
>         if (cpu_event)
> -               ctx_sched_out(&cpuctx->ctx, event_type);
> +               ctx_sched_out(&cpuctx->ctx, pmu, event_type);
>         else if (event_type & EVENT_PINNED)
> -               ctx_sched_out(&cpuctx->ctx, EVENT_FLEXIBLE);
> +               ctx_sched_out(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
>
> -       perf_event_sched_in(cpuctx, task_ctx);
> +       perf_event_sched_in(cpuctx, task_ctx, pmu);
>
> -       perf_ctx_enable(&cpuctx->ctx, false);
> -       if (task_ctx)
> -               perf_ctx_enable(task_ctx, false);
> +       for_each_epc(epc, &cpuctx->ctx, pmu, false)
> +               perf_pmu_enable(epc->pmu);
> +
> +       if (task_ctx) {
> +               for_each_epc(epc, task_ctx, pmu, false)
> +                       perf_pmu_enable(epc->pmu);
> +       }
>  }
>
>  void perf_pmu_resched(struct pmu *pmu)
> @@ -2746,7 +2765,7 @@ void perf_pmu_resched(struct pmu *pmu)
>         struct perf_event_context *task_ctx =3D cpuctx->task_ctx;
>
>         perf_ctx_lock(cpuctx, task_ctx);
> -       ctx_resched(cpuctx, task_ctx, EVENT_ALL|EVENT_CPU);
> +       ctx_resched(cpuctx, task_ctx, pmu, EVENT_ALL|EVENT_CPU);
>         perf_ctx_unlock(cpuctx, task_ctx);
>  }
>
> @@ -2802,9 +2821,10 @@ static int  __perf_install_in_context(void *info)
>  #endif
>
>         if (reprogram) {
> -               ctx_sched_out(ctx, EVENT_TIME);
> +               ctx_update_time(cpuctx, ctx);

So you don't want to stop the context time while adding or enabling a new
event, right?  Then I'm not sure if it's needed to update the time here as
it'll be updated in the ctx_sched_out() again.

Also calling ctx_sched_out() will clear EVENT_TIME when is_active has
no EVENT_ALL and it'll stop the context time anyway, right?

Thanks,
Namhyung


>                 add_event_to_ctx(event, ctx);
> -               ctx_resched(cpuctx, task_ctx, get_event_type(event));
> +               ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu,
> +                           get_event_type(event));
>         } else {
>                 add_event_to_ctx(event, ctx);
>         }
> @@ -2947,8 +2967,7 @@ static void __perf_event_enable(struct perf_event *=
event,
>             event->state <=3D PERF_EVENT_STATE_ERROR)
>                 return;
>
> -       if (ctx->is_active)
> -               ctx_sched_out(ctx, EVENT_TIME);
> +       ctx_update_time(cpuctx, ctx);
>
>         perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
>         perf_cgroup_event_enable(event, ctx);
> @@ -2956,25 +2975,21 @@ static void __perf_event_enable(struct perf_event=
 *event,
>         if (!ctx->is_active)
>                 return;
>
> -       if (!event_filter_match(event)) {
> -               ctx_sched_in(ctx, EVENT_TIME);
> +       if (!event_filter_match(event))
>                 return;
> -       }
>
>         /*
>          * If the event is in a group and isn't the group leader,
>          * then don't put it on unless the group is on.
>          */
> -       if (leader !=3D event && leader->state !=3D PERF_EVENT_STATE_ACTI=
VE) {
> -               ctx_sched_in(ctx, EVENT_TIME);
> +       if (leader !=3D event && leader->state !=3D PERF_EVENT_STATE_ACTI=
VE)
>                 return;
> -       }
>
>         task_ctx =3D cpuctx->task_ctx;
>         if (ctx->task)
>                 WARN_ON_ONCE(task_ctx !=3D ctx);
>
> -       ctx_resched(cpuctx, task_ctx, get_event_type(event));
> +       ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu, get_event_type=
(event));
>  }
>
>  /*
> @@ -3250,7 +3265,7 @@ static void __pmu_ctx_sched_out(struct perf_event_p=
mu_context *pmu_ctx,
>                 cpc->task_epc =3D NULL;
>         }
>
> -       if (!event_type)
> +       if (!(event_type & EVENT_ALL))
>                 return;
>
>         perf_pmu_disable(pmu);
> @@ -3276,8 +3291,17 @@ static void __pmu_ctx_sched_out(struct perf_event_=
pmu_context *pmu_ctx,
>         perf_pmu_enable(pmu);
>  }
>
> +/*
> + * Be very careful with the @pmu argument since this will change ctx sta=
te.
> + * The @pmu argument works for ctx_resched(), because that is symmetric =
in
> + * ctx_sched_out() / ctx_sched_in() usage and the ctx state ends up inva=
riant.
> + *
> + * However, if you were to be asymmetrical, you could end up with messed=
 up
> + * state, eg. ctx->is_active cleared even though most EPCs would still a=
ctually
> + * be active.
> + */
>  static void
> -ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_ty=
pe)
> +ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, enum even=
t_type_t event_type)
>  {
>         struct perf_cpu_context *cpuctx =3D this_cpu_ptr(&perf_cpu_contex=
t);
>         struct perf_event_pmu_context *pmu_ctx;
> @@ -3331,11 +3355,8 @@ ctx_sched_out(struct perf_event_context *ctx, enum=
 event_type_t event_type)
>
>         is_active ^=3D ctx->is_active; /* changed bits */
>
> -       list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> -               if (cgroup && !pmu_ctx->nr_cgroups)
> -                       continue;
> +       for_each_epc(pmu_ctx, ctx, pmu, cgroup)
>                 __pmu_ctx_sched_out(pmu_ctx, is_active);
> -       }
>  }
>
>  /*
> @@ -3579,7 +3600,7 @@ perf_event_context_sched_out(struct task_struct *ta=
sk, struct task_struct *next)
>
>  inside_switch:
>                 perf_ctx_sched_task_cb(ctx, false);
> -               task_ctx_sched_out(ctx, EVENT_ALL);
> +               task_ctx_sched_out(ctx, NULL, EVENT_ALL);
>
>                 perf_ctx_enable(ctx, false);
>                 raw_spin_unlock(&ctx->lock);
> @@ -3877,29 +3898,22 @@ static void pmu_groups_sched_in(struct perf_event=
_context *ctx,
>                            merge_sched_in, &can_add_hw);
>  }
>
> -static void ctx_groups_sched_in(struct perf_event_context *ctx,
> -                               struct perf_event_groups *groups,
> -                               bool cgroup)
> +static void __pmu_ctx_sched_in(struct perf_event_pmu_context *pmu_ctx,
> +                              enum event_type_t event_type)
>  {
> -       struct perf_event_pmu_context *pmu_ctx;
> -
> -       list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> -               if (cgroup && !pmu_ctx->nr_cgroups)
> -                       continue;
> -               pmu_groups_sched_in(ctx, groups, pmu_ctx->pmu);
> -       }
> -}
> +       struct perf_event_context *ctx =3D pmu_ctx->ctx;
>
> -static void __pmu_ctx_sched_in(struct perf_event_context *ctx,
> -                              struct pmu *pmu)
> -{
> -       pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu);
> +       if (event_type & EVENT_PINNED)
> +               pmu_groups_sched_in(ctx, &ctx->pinned_groups, pmu_ctx->pm=
u);
> +       if (event_type & EVENT_FLEXIBLE)
> +               pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu_ctx->=
pmu);
>  }
>
>  static void
> -ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_typ=
e)
> +ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event=
_type_t event_type)
>  {
>         struct perf_cpu_context *cpuctx =3D this_cpu_ptr(&perf_cpu_contex=
t);
> +       struct perf_event_pmu_context *pmu_ctx;
>         int is_active =3D ctx->is_active;
>         bool cgroup =3D event_type & EVENT_CGROUP;
>
> @@ -3935,12 +3949,16 @@ ctx_sched_in(struct perf_event_context *ctx, enum=
 event_type_t event_type)
>          * First go through the list and put on any pinned groups
>          * in order to give them the best chance of going on.
>          */
> -       if (is_active & EVENT_PINNED)
> -               ctx_groups_sched_in(ctx, &ctx->pinned_groups, cgroup);
> +       if (is_active & EVENT_PINNED) {
> +               for_each_epc(pmu_ctx, ctx, pmu, cgroup)
> +                       __pmu_ctx_sched_in(pmu_ctx, EVENT_PINNED);
> +       }
>
>         /* Then walk through the lower prio flexible groups */
> -       if (is_active & EVENT_FLEXIBLE)
> -               ctx_groups_sched_in(ctx, &ctx->flexible_groups, cgroup);
> +       if (is_active & EVENT_FLEXIBLE) {
> +               for_each_epc(pmu_ctx, ctx, pmu, cgroup)
> +                       __pmu_ctx_sched_in(pmu_ctx, EVENT_FLEXIBLE);
> +       }
>  }
>
>  static void perf_event_context_sched_in(struct task_struct *task)
> @@ -3983,10 +4001,10 @@ static void perf_event_context_sched_in(struct ta=
sk_struct *task)
>          */
>         if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree)) {
>                 perf_ctx_disable(&cpuctx->ctx, false);
> -               ctx_sched_out(&cpuctx->ctx, EVENT_FLEXIBLE);
> +               ctx_sched_out(&cpuctx->ctx, NULL, EVENT_FLEXIBLE);
>         }
>
> -       perf_event_sched_in(cpuctx, ctx);
> +       perf_event_sched_in(cpuctx, ctx, NULL);
>
>         perf_ctx_sched_task_cb(cpuctx->task_ctx, true);
>
> @@ -4327,14 +4345,14 @@ static bool perf_rotate_context(struct perf_cpu_p=
mu_context *cpc)
>                 update_context_time(&cpuctx->ctx);
>                 __pmu_ctx_sched_out(cpu_epc, EVENT_FLEXIBLE);
>                 rotate_ctx(&cpuctx->ctx, cpu_event);
> -               __pmu_ctx_sched_in(&cpuctx->ctx, pmu);
> +               __pmu_ctx_sched_in(cpu_epc, EVENT_FLEXIBLE);
>         }
>
>         if (task_event)
>                 rotate_ctx(task_epc->ctx, task_event);
>
>         if (task_event || (task_epc && cpu_event))
> -               __pmu_ctx_sched_in(task_epc->ctx, pmu);
> +               __pmu_ctx_sched_in(task_epc, EVENT_FLEXIBLE);
>
>         perf_pmu_enable(pmu);
>         perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> @@ -4400,7 +4418,7 @@ static void perf_event_enable_on_exec(struct perf_e=
vent_context *ctx)
>
>         cpuctx =3D this_cpu_ptr(&perf_cpu_context);
>         perf_ctx_lock(cpuctx, ctx);
> -       ctx_sched_out(ctx, EVENT_TIME);
> +       ctx_update_time(cpuctx, ctx);
>
>         list_for_each_entry(event, &ctx->event_list, event_entry) {
>                 enabled |=3D event_enable_on_exec(event, ctx);
> @@ -4412,9 +4430,7 @@ static void perf_event_enable_on_exec(struct perf_e=
vent_context *ctx)
>          */
>         if (enabled) {
>                 clone_ctx =3D unclone_ctx(ctx);
> -               ctx_resched(cpuctx, ctx, event_type);
> -       } else {
> -               ctx_sched_in(ctx, EVENT_TIME);
> +               ctx_resched(cpuctx, ctx, NULL, event_type);
>         }
>         perf_ctx_unlock(cpuctx, ctx);
>
> @@ -4517,10 +4533,7 @@ static void __perf_event_read(void *info)
>                 return;
>
>         raw_spin_lock(&ctx->lock);
> -       if (ctx->is_active & EVENT_TIME) {
> -               update_context_time(ctx);
> -               update_cgrp_time_from_event(event);
> -       }
> +       ctx_update_event_time(ctx, event);
>
>         perf_event_update_time(event);
>         if (data->group)
> @@ -4720,10 +4733,7 @@ static int perf_event_read(struct perf_event *even=
t, bool group)
>                  * May read while context is not active (e.g., thread is
>                  * blocked), in that case we cannot update context time
>                  */
> -               if (ctx->is_active & EVENT_TIME) {
> -                       update_context_time(ctx);
> -                       update_cgrp_time_from_event(event);
> -               }
> +               ctx_update_event_time(ctx, event);
>
>                 perf_event_update_time(event);
>                 if (group)
> @@ -13202,7 +13212,7 @@ static void perf_event_exit_task_context(struct t=
ask_struct *child)
>          * in.
>          */
>         raw_spin_lock_irq(&child_ctx->lock);
> -       task_ctx_sched_out(child_ctx, EVENT_ALL);
> +       task_ctx_sched_out(child_ctx, NULL, EVENT_ALL);
>
>         /*
>          * Now that the context is inactive, destroy the task <-> ctx rel=
ation
> @@ -13751,7 +13761,7 @@ static void __perf_event_exit_context(void *__inf=
o)
>         struct perf_event *event;
>
>         raw_spin_lock(&ctx->lock);
> -       ctx_sched_out(ctx, EVENT_TIME);
> +       ctx_sched_out(ctx, NULL, EVENT_TIME);
>         list_for_each_entry(event, &ctx->event_list, event_entry)
>                 __perf_remove_from_context(event, cpuctx, ctx, (void *)DE=
TACH_GROUP);
>         raw_spin_unlock(&ctx->lock);
>

