Return-Path: <linux-kernel+bounces-317177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A224B96DA70
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2451A1F242BB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9401E19D8AC;
	Thu,  5 Sep 2024 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pk+2BkTA"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2920C19CCE2
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543234; cv=none; b=TTMDs784h313friahVYefsadLquHMQLKIc0yIwsFTn9scK31PFm2iWng3TlA44PQyy68F7hqmk08i6tUVKuxlKWskoQ6XxA9roSYw8nfPdrh0qlm4jlqzy+zqZP3QGuUqUa2AfdoxM4jDg4kqK9f3LUWVRLzqeImluo1+EJGCVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543234; c=relaxed/simple;
	bh=YkQEO1wMvd7q6NK8pJQ8yw8I727ntMDCG24DrHabbeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ka7+Ej8/2aUSkjFkgVi9lMteMNZMF51o9Y8b65SGKfy1usRfzUI7JHbs/dHrjDccMYgVkCpLcF1Gu96xD9OIx/FjMY+rdrqR2it7dTjSiQzjabgBeriu/V6YCGEvPQ1N8cDcGypicC7fmkO57cKz1MH890WQM//9kw62eIb/zAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pk+2BkTA; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso708543a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 06:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725543232; x=1726148032; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IfvmcKFg6Fj0YKAq/WfJsPKdkVZtnDTZ/TfUJlo8saI=;
        b=Pk+2BkTAJZK4HDYyxLGJzUChg8l/D60Fd3Fucng9ypv60vb4NkV3CYN4EHoL+D+rlj
         Kt7ES1GNPA18jP/kvmU636IgKivUBU+5g5m1oSAni5tH8UivP2RT74qeZh0WnY2eAK81
         ANmbB8hLgJ+1XaR/Rgyi9ihEcD2phPpoh3p+UoxUzrwoH8gWRULQ/1B88E3FSl0kuz3q
         6Nn6mkOrmLMfx3OT/wq/wsQGQj0yRhv19RF0Rftg8FNZQIatApDh/V3whkqyP/xOfzYi
         N2YpHizmm4coS5ToM5u4WxGEuNhPOuitRyWcTHoM3LLCHBe8e9K0S4E9H1es+DyMrfpt
         /21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725543232; x=1726148032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfvmcKFg6Fj0YKAq/WfJsPKdkVZtnDTZ/TfUJlo8saI=;
        b=ffY6P32E1kuf4p6G+mKUMKW5gL4MLaZ2+0NrwHd6/WKtdrpRL0/Zj1ooVYYT2wmVq2
         uBpIz19qZ1BCxBXtmCqsaZicIUUztptZYmAfD9in7EwTG7S06idcDflcb8IlKqFoUljO
         1v1PB7C5ONpSdg1/LqPpAX0Z5dhVbBoB9dmfbBH07EJvDrjqCDA5BjJzQzbjp4WZGFCL
         RB2mJXOyRVOeEA+BaDExWORxbLy0+tiyP8vY4k37k+tsXnF7DJZk4xCJaOZNtdsa3fQ7
         hYFLO3fV0YBb0j6r2orzbnbX+7nHU5+JGcJVSgJ6ILD3MjP/t2Z1kI+8Y+CVqQaH+zEB
         5r3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVURb0wMR1LqqgKm0D5BOfTiRfOTmE17KbzBSPI78Xntj/FPMFjoD+1g5FCUYiHUlPhZouuS9UNkpQ95kA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEc20U+YSE4oH0AYyKkKaXoEy5cO665x/joYD7S8mwOyj1Nyuu
	LtfOKGzkNEGEZq3IyLfeeZ69nNnUB7WSdztB4dIScEbbC40r7WtQqN5q0lQAuDyBulxqudUowrq
	kJmCR3nJHfhZcOK6LK9Z0xdq6D9LC0qmuf+AAqw==
X-Google-Smtp-Source: AGHT+IEbdAaF/S349FwhT1ajllrEB43/lA/KsZFEjJ3xG1z/uF8wUnknCP15JQnesNs68wlM7IyvJP8JIsvzQJJfHzg=
X-Received: by 2002:a05:6a21:3a93:b0:1cc:c202:b289 with SMTP id
 adf61e73a8af0-1cece2d1d10mr20439140637.0.1725543232314; Thu, 05 Sep 2024
 06:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727102732.960974693@infradead.org> <20240727105029.315205425@infradead.org>
 <6f39e567-fd9a-4157-949d-7a9ccd9c3592@arm.com> <CAKfTPtAS0eSqf5Qoq_rpQC7DbyyGX=GACsB7OPdhi8=HEciPUQ@mail.gmail.com>
 <1debbea4-a0cf-4de9-9033-4f6135a156ed@arm.com> <CAKfTPtCEUZxV9zMpguf7RKs6njLsJJUmz8WadyS4ryr+Fqca1Q@mail.gmail.com>
 <83a20d85-de7a-4fe6-8cd8-5a96d822eb6b@arm.com> <629937b1-6f97-41d1-aa4f-7349c2ffa29d@arm.com>
 <CAKfTPtBPK8ovttHDQjfuwve63PK_pNH4WMznEHWoXQ=2vGhKQQ@mail.gmail.com>
 <CAKfTPtDO3n-4mcr2Sk-uu0ZS5xQnagdicQmaBh-CyrndPLM8eQ@mail.gmail.com>
 <aa81d37e-ad9c-42c6-a104-fe8496c5d907@arm.com> <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
In-Reply-To: <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 5 Sep 2024 15:33:41 +0200
Message-ID: <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Hongyan Xia <hongyan.xia2@arm.com>, Luis Machado <luis.machado@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, juri.lelli@redhat.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de, 
	efault@gmx.de
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Sept 2024 at 15:02, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 29/08/2024 17:42, Hongyan Xia wrote:
> > On 22/08/2024 15:58, Vincent Guittot wrote:
> >> On Thu, 22 Aug 2024 at 14:10, Vincent Guittot
> >> <vincent.guittot@linaro.org> wrote:
> >>>
> >>> On Thu, 22 Aug 2024 at 14:08, Luis Machado <luis.machado@arm.com> wrote:
> >>>>
> >>>> Vincent,
> >>>>
> >>>> On 8/22/24 11:28, Luis Machado wrote:
> >>>>> On 8/22/24 10:53, Vincent Guittot wrote:
> >>>>>> On Thu, 22 Aug 2024 at 11:22, Luis Machado <luis.machado@arm.com>
> >>>>>> wrote:
> >>>>>>>
> >>>>>>> On 8/22/24 09:19, Vincent Guittot wrote:
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> On Wed, 21 Aug 2024 at 15:34, Hongyan Xia <hongyan.xia2@arm.com>
> >>>>>>>> wrote:
> >>>>>>>>>
> >>>>>>>>> Hi Peter,
> >>>>>>>>>
> >>>>>>>>> Sorry for bombarding this thread in the last couple of days.
> >>>>>>>>> I'm seeing
> >>>>>>>>> several issues in the latest tip/sched/core after these patches
> >>>>>>>>> landed.
> >>>>>>>>>
> >>>>>>>>> What I'm now seeing seems to be an unbalanced call of util_est.
> >>>>>>>>> First, I applied
> >>>>>>>>
> >>>>>>>> I also see a remaining util_est for idle rq because of an unbalance
> >>>>>>>> call of util_est_enqueue|dequeue
> >>>>>>>>
> >>>>>>>
> >>>>>>> I can confirm issues with the utilization values and frequencies
> >>>>>>> being driven
> >>>>>>> seemingly incorrectly, in particular for little cores.
> >>>>>>>
> >>>>>>> What I'm seeing with the stock series is high utilization values
> >>>>>>> for some tasks
> >>>>>>> and little cores having their frequencies maxed out for extended
> >>>>>>> periods of
> >>>>>>> time. Sometimes for 5+ or 10+ seconds, which is excessive as the
> >>>>>>> cores are mostly
> >>>>>>> idle. But whenever certain tasks get scheduled there, they have a
> >>>>>>> very high util
> >>>>>>> level and so the frequency is kept at max.
> >>>>>>>
> >>>>>>> As a consequence this drives up power usage.
> >>>>>>>
> >>>>>>> I gave Hongyan's draft fix a try and observed a much more
> >>>>>>> reasonable behavior for
> >>>>>>> the util numbers and frequencies being used for the little cores.
> >>>>>>> With his fix,
> >>>>>>> I can also see lower energy use for my specific benchmark.
> >>>>>>
> >>>>>> The main problem is that the util_est of a delayed dequeued task
> >>>>>> remains on the rq and keeps the rq utilization high and as a result
> >>>>>> the frequency higher than needed.
> >>>>>>
> >>>>>> The below seems to works for me and keep sync the enqueue/dequeue of
> >>>>>> uti_test with the enqueue/dequeue of the task as if de dequeue was
> >>>>>> not
> >>>>>> delayed
> >>>>>>
> >>>>>> Another interest is that we will not try to migrate a delayed dequeue
> >>>>>> sleeping task that doesn't actually impact the current load of the
> >>>>>> cpu
> >>>>>> and as a result will not help in the load balance. I haven't yet
> >>>>>> fully
> >>>>>> checked what would happen with hotplug
> >>>>>
> >>>>> Thanks. Those are good points. Let me go and try your patch.
> >>>>
> >>>> I gave your fix a try, but it seems to make things worse. It is
> >>>> comparable
> >>>> to the behavior we had before Peter added the uclamp imbalance fix,
> >>>> so I
> >>>> believe there is something incorrect there.
> >>>
> >>> we need to filter case where task are enqueued/dequeued several
> >>> consecutive times. That's what I'm look now
> >>
> >> I just realize before that It's not only util_est but the h_nr_running
> >> that keeps delayed tasks as well so all stats of the rq are biased:
> >> h_nr_running, util_est, runnable avg and load_avg.
> >
> > After staring at the code even more, I think the situation is worse.
> >
> > First thing is that uclamp might also want to be part of these stats
> > (h_nr_running, util_est, runnable_avg, load_avg) that do not follow
> > delayed dequeue which needs to be specially handled in the same way. The
> > current way of handling uclamp in core.c misses the frequency update,
> > like I commented before.
> >
> > Second, there is also an out-of-sync issue in update_load_avg(). We only
> > update the task-level se in delayed dequeue and requeue, but we return
> > early and the upper levels are completely skipped, as if the delayed
> > task is still on rq. This de-sync is wrong.
>
> I had a look at the util_est issue.
>
> This keeps rq->cfs.avg.util_avg sane for me with
> SCHED_FEAT(DELAY_DEQUEUE, true):
>
> -->8--
>
> From 0d7e8d057f49a47e0f3f484ac7d41e047dccec38 Mon Sep 17 00:00:00 2001
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Date: Thu, 5 Sep 2024 00:05:23 +0200
> Subject: [PATCH] kernel/sched: Fix util_est accounting for DELAY_DEQUEUE
>
> Remove delayed tasks from util_est even they are runnable.

Unfortunately, this is not only about util_est

cfs_rq's runnable_avg is also wrong  because we normally have :
cfs_rq's runnable_avg == /Sum se's runnable_avg
but cfs_rq's runnable_avg uses cfs_rq's h_nr_running but delayed
entities are still accounted in h_nr_running

That also means that cfs_rq's h_nr_running is not accurate anymore
because it includes delayed dequeue

and cfs_rq load_avg is kept artificially high which biases
load_balance and cgroup's shares

>
> Exclude delayed task which are (a) migrating between rq's or (b) in a
> SAVE/RESTORE dequeue/enqueue.
>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/fair.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1e693ca8ebd6..5c32cc26d6c2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6948,18 +6948,19 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>         int rq_h_nr_running = rq->cfs.h_nr_running;
>         u64 slice = 0;
>
> -       if (flags & ENQUEUE_DELAYED) {
> -               requeue_delayed_entity(se);
> -               return;
> -       }
> -
>         /*
>          * The code below (indirectly) updates schedutil which looks at
>          * the cfs_rq utilization to select a frequency.
>          * Let's add the task's estimated utilization to the cfs_rq's
>          * estimated utilization, before we update schedutil.
>          */
> -       util_est_enqueue(&rq->cfs, p);
> +       if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE))))
> +               util_est_enqueue(&rq->cfs, p);
> +
> +       if (flags & ENQUEUE_DELAYED) {
> +               requeue_delayed_entity(se);
> +               return;
> +       }
>
>         /*
>          * If in_iowait is set, the code below may not trigger any cpufreq
> @@ -7177,7 +7178,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>   */
>  static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  {
> -       util_est_dequeue(&rq->cfs, p);
> +       if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & DEQUEUE_SAVE))))
> +               util_est_dequeue(&rq->cfs, p);
>
>         if (dequeue_entities(rq, &p->se, flags) < 0) {
>                 if (!rq->cfs.h_nr_running)
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

