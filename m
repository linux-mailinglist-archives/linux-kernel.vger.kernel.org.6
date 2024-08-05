Return-Path: <linux-kernel+bounces-275027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667AF947FC2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCB5281D2D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E382B15CD61;
	Mon,  5 Aug 2024 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZiM696EH"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AC92C684
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877072; cv=none; b=bWVrhjXsvr8EQfndp7uRwB6SGXX9ieiIgIYWyQk2kt5JuZrE14Q87DB8oQ03XQtqitBEjnhUQmBDwd+ikU4O5gQ6kKGY3x9fF+ZfEnrYEzvGnWGF9StnbXGujtmYC9VG8ochHjT2yOtviW53B75ONcKuUHtevsMUBLhKxOTg8ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877072; c=relaxed/simple;
	bh=IFCTaRJELtcM/Qnt8ygbJRWrpguYALzde3Ni94guTBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=leEF6WR5v+I5BaWBTQpwdOIjEWbmW7PC92zYkOU4l9D4aw2ld1n6NPqbixRfdxAhShBxljpcjeNCT0k86QEU2cW9cXqQmhmjSJchaMR11VfxcOjp9q69QJsvoY3l5LtEpZlEgoWXyd9T0bnmA6oppceMX4xj7I/rJxTRe9Lu+ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZiM696EH; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52efa16aad9so14935590e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 09:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722877069; x=1723481869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSI/fGOk4CVv88+Hq2ub4vYIPClg+RVcfH6g7IHfGno=;
        b=ZiM696EHh7pVcOaEk9z3ndDgJe/HjR7rqN/45oKoNFg0Rnsg56r+999jZ7EhpkEhox
         swTnPvYKphKhOT3wKDor8WAXnztecDoU86Sp8mI/XpS1AlhCwlOE9G+Zs8/TBN1abFR3
         JcNGSYzwUx9au8CaPQm0XEFCVwexwwMosJzNVRs5c+Zxe6hS3NABfdz7T8XaIBMKjICu
         u3Hi6ZexEn/nublD7bIsuQs6W8yoXssQPWbaRBEE3+9GMn/n5CwPdgRBFqV2Ey2gDvgY
         HL9+GuPdWrlce2avQl0KooZd0G5ZcT58K3FRX4hCzktReoB2BXR8oFNSKVym0Y5hN2Qj
         XnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722877069; x=1723481869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSI/fGOk4CVv88+Hq2ub4vYIPClg+RVcfH6g7IHfGno=;
        b=W+OEIvn8/FSNy5cx97H/65x0CXdwBhip4UcoSwmUEEjl2d4aAPyYvvEP43TOov4UMa
         2GJyVQt9AH4xITo1zpILIWcVi0Mvs4cf4d2+yKMzrmOeDLrhDtlPbWapWEBegiY0E3Ak
         5s3HcPIqfL1WdtBvRU07ir4n5/vOPmK2z9EvIqtcPJqZbF6Rs60Ex/hv2rrTqzEe6lPa
         7ur/YuPaxr/DqyvX0+6pMngMTv32MNVa/380MytoD5cGuJYvaFttAp4szdqdhijGxThN
         snKDVGx+Zs4zt4NIqPyvBFQ3MiXu74BPkSZ+phC5Itf03XAdC7X00hBgyG2vewV0Itcm
         O4qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOYvViG4+3DXdVmtKelYPODs3S9VqcihhkGMPVRMA0I+QWD46FJO5e1lySdB9kBk9Ioh4V7uC3fw8p0xHCdhMjKiw63EtugKS3xpOB
X-Gm-Message-State: AOJu0Yz/gEJCvSz74+LX4IKoHLWcIt/JwY07PJqmCqG5in6hnn/RB8Nc
	PurWV1crQiT8pMrZAM7SKVytDw2RVVzJWh44iMcYOD9O7b1TnXPL6PBZI/+sTRfKQxeklNxidvy
	bnfHRZiRVRBe0VNFRKsTpiCxzVqaC+YPDBeP2
X-Google-Smtp-Source: AGHT+IF+Q3Al/z9siXVEKyGs47GrS37gfWZB6ajQea+dipEVC+Mvg4wdZrd8Z7i43kswEXdi4OD/dmk/MVFdqAytPH8=
X-Received: by 2002:a05:6512:239e:b0:52c:daa4:2f5c with SMTP id
 2adb3069b0e04-530bb395ea1mr9034471e87.42.1722877068482; Mon, 05 Aug 2024
 09:57:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730191925.469649-1-namhyung@kernel.org>
In-Reply-To: <20240730191925.469649-1-namhyung@kernel.org>
From: Mingwei Zhang <mizhang@google.com>
Date: Mon, 5 Aug 2024 09:57:11 -0700
Message-ID: <CAL715W+2jmoFvEy=LpkFFwX9oQSW3qhM_D-t77p-2CCBKmpdNg@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Optimize event reschedule for a PMU
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 12:19=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Current ctx_resched() reschedules every events in all PMUs in the
> context even if it only needs to do it for a single event.  This is the
> case when it opens a new event or enables an existing one.  What we
> want is to reschedule events in the PMU only.  Also perf_pmu_resched()
> currently calls ctx_resched() without PMU information.
>
> Let's add __perf_pmu_resched() to do the work for the given PMU only.
> The context time should be updated by ctx_sched_{out,in}(EVENT_TIME)
> outside from it.  And change the __pmu_ctx_sched_in() to be symmetrical
> to the _sched_out() for its arguments so that it can be called easily
> in the __perf_pmu_resched().
>
> Note that __perf_install_in_context() should call ctx_resched() for the
> very first event in the context in order to set ctx->is_active.  Later
> events can be handled by __perf_pmu_resched().
>
> Care should be taken when it installs a task event for a PMU and
> there's no CPU event for the PMU.  __perf_pmu_resched() will ask the
> CPU PMU context to schedule any events in it according to the group
> info.  But as the PMU context was not activated, it didn't set the
> event context pointer.  So I added new NULL checks in the
> __pmu_ctx_sched_{in,out}.
>
> With this change I can get 4x speed up (but actually it's proportional
> to the number of uncore PMU events) on a 2-socket Intel EMR machine in
> opening and closing a perf event for the core PMU in a loop while there
> are a bunch of uncore PMU events active on the CPU.  The test code
> (stress-pmu) follows below.
>
> Before)
>   # ./stress-pmu
>   delta: 0.087068 sec (870 usec/op)

Hi Namhyung,

I wonder how I could test the performance boost on the virtualized
environment. So, I assume this will have a better performance by
reducing the number of wrmsrs to event selectors and counters?

I wonder if I need to run multiple instances of stress-pmu to increase
the number of PMU context switches?

Thanks.
-Mingwei
>
> After)
>   # ./stress-pmu
>   delta: 0.021440 sec (214 usec/op)
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   $ cat stress-pmu.c
>   #include <stdio.h>
>   #include <unistd.h>
>   #include <linux/perf_event.h>
>   #include <sys/syscall.h>
>   #include <sys/time.h>
>
>   /* from uncore cpumask on EMR */
>   #define TARGET_CPU 60
>
>   #define LOOP 100
>   #define US2S 1000000
>
>   int open_perf_event(int type, int config)
>   {
>         struct perf_event_attr attr =3D {
>                 .type =3D type,
>                 .config =3D config,
>         };
>         int fd;
>
>         fd =3D syscall(SYS_perf_event_open, &attr, /*pid=3D*/-1, TARGET_C=
PU,
>                         /*group_fd=3D*/-1, /*flags=3D*/0);
>         if (fd < 0)
>                 printf("perf_event_open failed (type=3D%d, config=3D%d): =
%m\n", type, config);
>         return fd;
>   }
>
>   int main(int argc, char *argv[])
>   {
>         struct timeval ts1, ts2;
>         unsigned long long delta;
>         int target_cpu =3D TARGET_CPU;
>
>         /* open random uncore PMU events */
>         for (int i =3D 0; i < 100; i++)
>                 open_perf_event(/*type=3D*/i + 20, /*config=3D*/0);
>
>         gettimeofday(&ts1, NULL);
>         for (int i =3D 0; i < LOOP; i++)
>                 close(open_perf_event(PERF_TYPE_HARDWARE, PERF_COUNT_HW_C=
PU_CYCLES));
>         gettimeofday(&ts2, NULL);
>
>         delta =3D ts2.tv_sec * US2S + ts2.tv_usec - (ts1.tv_sec * US2S + =
ts1.tv_usec);
>         printf("delta: %llu.%06llu sec (%llu usec/op)\n",
>                 delta / US2S, delta % US2S, delta / LOOP);
>         return 0;
>   }
> ---
>  kernel/events/core.c | 101 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 88 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f64c30e7d5da..a8a078a0a6d9 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -709,6 +709,10 @@ static void perf_ctx_enable(struct perf_event_contex=
t *ctx, bool cgroup)
>
>  static void ctx_sched_out(struct perf_event_context *ctx, enum event_typ=
e_t event_type);
>  static void ctx_sched_in(struct perf_event_context *ctx, enum event_type=
_t event_type);
> +static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,
> +                               enum event_type_t event_type);
> +static void __pmu_ctx_sched_in(struct perf_event_pmu_context *pmu_ctx,
> +                              enum event_type_t event_type);
>
>  #ifdef CONFIG_CGROUP_PERF
>
> @@ -2683,11 +2687,6 @@ static void perf_event_sched_in(struct perf_cpu_co=
ntext *cpuctx,
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
>                         enum event_type_t event_type)
> @@ -2728,13 +2727,62 @@ static void ctx_resched(struct perf_cpu_context *=
cpuctx,
>                 perf_ctx_enable(task_ctx, false);
>  }
>
> +static void __perf_pmu_resched(struct pmu *pmu,
> +                              struct perf_event_context *task_ctx,
> +                              enum event_type_t event_type)
> +{
> +       bool cpu_event =3D !!(event_type & EVENT_CPU);
> +       struct perf_event_pmu_context *epc =3D NULL;
> +       struct perf_cpu_pmu_context *cpc =3D this_cpu_ptr(pmu->cpu_pmu_co=
ntext);
> +
> +       /*
> +        * If pinned groups are involved, flexible groups also need to be
> +        * scheduled out.
> +        */
> +       if (event_type & EVENT_PINNED)
> +               event_type |=3D EVENT_FLEXIBLE;
> +
> +       event_type &=3D EVENT_ALL;
> +
> +       perf_pmu_disable(pmu);
> +       if (task_ctx) {
> +               if (WARN_ON_ONCE(!cpc->task_epc || cpc->task_epc->ctx !=
=3D task_ctx))
> +                       goto out;
> +
> +               epc =3D cpc->task_epc;
> +               __pmu_ctx_sched_out(epc, event_type);
> +       }
> +
> +       /*
> +        * Decide which cpu ctx groups to schedule out based on the types
> +        * of events that caused rescheduling:
> +        *  - EVENT_CPU: schedule out corresponding groups;
> +        *  - EVENT_PINNED task events: schedule out EVENT_FLEXIBLE group=
s;
> +        *  - otherwise, do nothing more.
> +        */
> +       if (cpu_event)
> +               __pmu_ctx_sched_out(&cpc->epc, event_type);
> +       else if (event_type & EVENT_PINNED)
> +               __pmu_ctx_sched_out(&cpc->epc, EVENT_FLEXIBLE);
> +
> +       __pmu_ctx_sched_in(&cpc->epc, EVENT_PINNED);
> +       if (task_ctx)
> +                __pmu_ctx_sched_in(epc, EVENT_PINNED);
> +       __pmu_ctx_sched_in(&cpc->epc, EVENT_FLEXIBLE);
> +       if (task_ctx)
> +                __pmu_ctx_sched_in(epc, EVENT_FLEXIBLE);
> +
> +out:
> +       perf_pmu_enable(pmu);
> +}
> +
>  void perf_pmu_resched(struct pmu *pmu)
>  {
>         struct perf_cpu_context *cpuctx =3D this_cpu_ptr(&perf_cpu_contex=
t);
>         struct perf_event_context *task_ctx =3D cpuctx->task_ctx;
>
>         perf_ctx_lock(cpuctx, task_ctx);
> -       ctx_resched(cpuctx, task_ctx, EVENT_ALL|EVENT_CPU);
> +       __perf_pmu_resched(pmu, task_ctx, EVENT_ALL|EVENT_CPU);
>         perf_ctx_unlock(cpuctx, task_ctx);
>  }
>
> @@ -2792,7 +2840,14 @@ static int  __perf_install_in_context(void *info)
>         if (reprogram) {
>                 ctx_sched_out(ctx, EVENT_TIME);
>                 add_event_to_ctx(event, ctx);
> -               ctx_resched(cpuctx, task_ctx, get_event_type(event));
> +               if (ctx->nr_events =3D=3D 1) {
> +                       /* The first event needs to set ctx->is_active. *=
/
> +                       ctx_resched(cpuctx, task_ctx, get_event_type(even=
t));
> +               } else {
> +                       __perf_pmu_resched(event->pmu_ctx->pmu, task_ctx,
> +                                          get_event_type(event));
> +                       ctx_sched_in(ctx, EVENT_TIME);
> +               }
>         } else {
>                 add_event_to_ctx(event, ctx);
>         }
> @@ -2962,7 +3017,8 @@ static void __perf_event_enable(struct perf_event *=
event,
>         if (ctx->task)
>                 WARN_ON_ONCE(task_ctx !=3D ctx);
>
> -       ctx_resched(cpuctx, task_ctx, get_event_type(event));
> +       __perf_pmu_resched(event->pmu_ctx->pmu, task_ctx, get_event_type(=
event));
> +       ctx_sched_in(ctx, EVENT_TIME);
>  }
>
>  /*
> @@ -3230,6 +3286,13 @@ static void __pmu_ctx_sched_out(struct perf_event_=
pmu_context *pmu_ctx,
>         struct perf_event *event, *tmp;
>         struct pmu *pmu =3D pmu_ctx->pmu;
>
> +       /*
> +        * CPU's pmu_ctx might not be active when __perf_pmu_resched() is=
 called
> +        * for task events and there's no cpu events.
> +        */
> +       if (ctx =3D=3D NULL)
> +               return;
> +
>         if (ctx->task && !ctx->is_active) {
>                 struct perf_cpu_pmu_context *cpc;
>
> @@ -3872,10 +3935,22 @@ static void ctx_groups_sched_in(struct perf_event=
_context *ctx,
>         }
>  }
>
> -static void __pmu_ctx_sched_in(struct perf_event_context *ctx,
> -                              struct pmu *pmu)
> +static void __pmu_ctx_sched_in(struct perf_event_pmu_context *pmu_ctx,
> +                              enum event_type_t event_type)
>  {
> -       pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu);
> +       struct perf_event_context *ctx =3D pmu_ctx->ctx;
> +
> +       /*
> +        * CPU's pmu_ctx might not be active when __perf_pmu_resched() is=
 called
> +        * for task events and there's no cpu events.
> +        */
> +       if (ctx =3D=3D NULL)
> +               return;
> +
> +       if (event_type & EVENT_PINNED)
> +               pmu_groups_sched_in(ctx, &ctx->pinned_groups, pmu_ctx->pm=
u);
> +       if (event_type & EVENT_FLEXIBLE)
> +               pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu_ctx->=
pmu);
>  }
>
>  static void
> @@ -4309,14 +4384,14 @@ static bool perf_rotate_context(struct perf_cpu_p=
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
> --
> 2.46.0.rc1.232.g9752f9e123-goog
>

