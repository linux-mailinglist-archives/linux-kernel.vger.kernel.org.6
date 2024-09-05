Return-Path: <linux-kernel+bounces-317274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F4B96DBC4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0630E1F22374
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966E63A27E;
	Thu,  5 Sep 2024 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RRK5HKJV"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C292286A3
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546577; cv=none; b=gLri8HGLc9IEPQOrkjtiRAbSKcZJeyypo8BPU4JPd+djKmAwtltG4M2Q4fE2S82rq5swLD7XyWjB1CpOAdzeMbWtGx2KCs7N993uYtC4Z8thXYk8sL8NdMijZtVYJjMPn2Q1XNJGTyNOeRy06bpqth3kfZYlwxGFiA97zitatjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546577; c=relaxed/simple;
	bh=xxGJCZMSl1EORcj78daru0j2yZ4lEmaOwBGXzNOwM/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qtm+TqMTOd4J0Hqzj0WlUizGLAN6Vk6JxmGD61J0gUGnKn5vJAmB0AMMuclXXUtmosVRVdmLAObQBPv2pMH3wBd+spJIORQNeivSy2L+T0vCQ+fWIS/sFI2alWvBKV/1CYUGeOgooVgAUNrV2bcEWv8cJbNYJrbzYLPzr8BAL/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RRK5HKJV; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d877e9054eso598621a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 07:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725546575; x=1726151375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LZSQ2YYHucYkVUTmh7I0H5lyWJ0HFQRSy2aFeM9y7d0=;
        b=RRK5HKJVLgDEjNiLyw7OT7prKgB+k3y4SYduterS/MXTln3SDldmMmaNPeVSQXq88J
         4NT4X2E6PinF50PFKWU+1iulABpyndv6a1QqjYXg/AdikD4+kZxE36+2kTWOi9Sdm1Me
         RbXBEZyx+O846Aw28kd03iyDC22yYCn6/d1yvzYd5fprMR9MUc0BGgBbUqpYgHv13VxZ
         qMNfWTvyZfgAdIB3usn4+W1YCnpFjBEpuWnQpuCf9LV1/PLD80cEgViS0rcZo51vUcOn
         tHDg553mTK6Y0dBw3qSNv4VWo8VUAUQOGgEZppzTg3ExD0isvvW1wBPgw6QLQ0HtUmk+
         G8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725546575; x=1726151375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZSQ2YYHucYkVUTmh7I0H5lyWJ0HFQRSy2aFeM9y7d0=;
        b=NJ8h6l4PfARaZOF+enC8KEITU+xsGaVBd2aL89U598bvnZcsKSHWNWdiJ3/OlgiTec
         xjM6YOi975RCIpbyTDETAcyzi29S672EB3BTKtrsCU6AlMzgGPX/Cueyqyl063CVqiUq
         8TRKzCBmLGLNzDlSi3gA3gBd2m/LlPpds8KmPhgHbOa+xKqffEwmRETJsrEyVFIla4R8
         d2GbsIe5c67rn5l4eICIR4X9tQZUI5rszjUxHrqN2pqmXnHeM3Azh7ul6ZgdHdPmtXe6
         I82hBDsW3qVxQXLFtm0NnALcPiI0pk/FJxWJCEFwCYrZP4pZR0plB6+zCHnGsfyP7HDF
         Fv6g==
X-Forwarded-Encrypted: i=1; AJvYcCUlgHmTPkT4fM+qyPLVdG6YmQl10OnBZwFp8p8+a2cJfqMwfo8q6FPcEdruk26nUhXvUwQpHMu8Qnz/gUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMQP889WFL14rKLxxCVNTG1vYdHRl0zgWMYvrhh+1pK5coT3YE
	+EL6ffHOUfzYp8RfXIRVkDYdemF7NjIeF2W1yoTeHfm7I5SlmmAjchQx/pM7R5MKPdKcZ0lKTax
	w3deGqctnSZIV3cqTw/qniPhXZXxLF8EnbunAjA==
X-Google-Smtp-Source: AGHT+IG8eTd0Ymo2SW7L2Nji24CC2wWOaZaMnAK4EnyeO5tkn/neAuD6lUtaeGmyiPoOnpS1pN8NUCLXMc86e0gOdrU=
X-Received: by 2002:a17:90a:a88a:b0:2c9:5ecd:e3c5 with SMTP id
 98e67ed59e1d1-2d8563922b8mr25876757a91.33.1725546575315; Thu, 05 Sep 2024
 07:29:35 -0700 (PDT)
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
 <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com> <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
In-Reply-To: <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 5 Sep 2024 16:29:24 +0200
Message-ID: <CAKfTPtCa3CAc+v55HdgTSAFTXF446KOCY6UsUyUes2ZVZqw1sg@mail.gmail.com>
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Hongyan Xia <hongyan.xia2@arm.com>, Luis Machado <luis.machado@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, juri.lelli@redhat.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de, 
	efault@gmx.de
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Sept 2024 at 16:07, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 05/09/2024 15:33, Vincent Guittot wrote:
> > On Thu, 5 Sept 2024 at 15:02, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 29/08/2024 17:42, Hongyan Xia wrote:
> >>> On 22/08/2024 15:58, Vincent Guittot wrote:
> >>>> On Thu, 22 Aug 2024 at 14:10, Vincent Guittot
> >>>> <vincent.guittot@linaro.org> wrote:
> >>>>>
> >>>>> On Thu, 22 Aug 2024 at 14:08, Luis Machado <luis.machado@arm.com> wrote:
> >>>>>>
> >>>>>> Vincent,
> >>>>>>
> >>>>>> On 8/22/24 11:28, Luis Machado wrote:
> >>>>>>> On 8/22/24 10:53, Vincent Guittot wrote:
> >>>>>>>> On Thu, 22 Aug 2024 at 11:22, Luis Machado <luis.machado@arm.com>
> >>>>>>>> wrote:
> >>>>>>>>>
> >>>>>>>>> On 8/22/24 09:19, Vincent Guittot wrote:
> >>>>>>>>>> Hi,
> >>>>>>>>>>
> >>>>>>>>>> On Wed, 21 Aug 2024 at 15:34, Hongyan Xia <hongyan.xia2@arm.com>
>
> [...]
>
> >>> After staring at the code even more, I think the situation is worse.
> >>>
> >>> First thing is that uclamp might also want to be part of these stats
> >>> (h_nr_running, util_est, runnable_avg, load_avg) that do not follow
> >>> delayed dequeue which needs to be specially handled in the same way. The
> >>> current way of handling uclamp in core.c misses the frequency update,
> >>> like I commented before.
> >>>
> >>> Second, there is also an out-of-sync issue in update_load_avg(). We only
> >>> update the task-level se in delayed dequeue and requeue, but we return
> >>> early and the upper levels are completely skipped, as if the delayed
> >>> task is still on rq. This de-sync is wrong.
> >>
> >> I had a look at the util_est issue.
> >>
> >> This keeps rq->cfs.avg.util_avg sane for me with
> >> SCHED_FEAT(DELAY_DEQUEUE, true):
> >>
> >> -->8--
> >>
> >> From 0d7e8d057f49a47e0f3f484ac7d41e047dccec38 Mon Sep 17 00:00:00 2001
> >> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> >> Date: Thu, 5 Sep 2024 00:05:23 +0200
> >> Subject: [PATCH] kernel/sched: Fix util_est accounting for DELAY_DEQUEUE
> >>
> >> Remove delayed tasks from util_est even they are runnable.
> >
> > Unfortunately, this is not only about util_est
> >
> > cfs_rq's runnable_avg is also wrong  because we normally have :
> > cfs_rq's runnable_avg == /Sum se's runnable_avg
> > but cfs_rq's runnable_avg uses cfs_rq's h_nr_running but delayed
> > entities are still accounted in h_nr_running
>
> Yes, I agree.
>
> se's runnable_avg should be fine already since:
>
> se_runnable()
>
>   if (se->sched_delayed)
>     return false
>
> But then, like you said, __update_load_avg_cfs_rq() needs correct
> cfs_rq->h_nr_running.
>
> And I guess we need something like:
>
> se_on_rq()
>
>   if (se->sched_delayed)
>     return false
>
> for
>
> __update_load_avg_se()
>
> - if (___update_load_sum(now, &se->avg, !!se->on_rq, se_runnable(se),
> + if (___update_load_sum(now, &se->avg, se_on_rq(se), se_runnable(se),
>
>
> My hope was we can fix util_est independently since it drives CPU
> frequency. Whereas PELT load_avg and runnable_avg are "only" used for
> load balancing. But I agree, it has to be fixed as well.

runnable_avg is also used for frequency selection

>
> > That also means that cfs_rq's h_nr_running is not accurate anymore
> > because it includes delayed dequeue
>
> +1
>
> > and cfs_rq load_avg is kept artificially high which biases
> > load_balance and cgroup's shares
>
> +1
>
> >> Exclude delayed task which are (a) migrating between rq's or (b) in a
> >> SAVE/RESTORE dequeue/enqueue.
>
> I just realized that this fixes the uneven util_est_dequeue/enqueue
> calls so we don't see the underflow depicted by Hongyan and no massive
> rq->cfs util_est due to missing ue_dequeues.
> But delayed tasks are part of rq->cfs util_est, not excluded. Let me fix
> that.
>
> >> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> >> ---
> >>  kernel/sched/fair.c | 16 +++++++++-------
> >>  1 file changed, 9 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 1e693ca8ebd6..5c32cc26d6c2 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -6948,18 +6948,19 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >>         int rq_h_nr_running = rq->cfs.h_nr_running;
> >>         u64 slice = 0;
> >>
> >> -       if (flags & ENQUEUE_DELAYED) {
> >> -               requeue_delayed_entity(se);
> >> -               return;
> >> -       }
> >> -
> >>         /*
> >>          * The code below (indirectly) updates schedutil which looks at
> >>          * the cfs_rq utilization to select a frequency.
> >>          * Let's add the task's estimated utilization to the cfs_rq's
> >>          * estimated utilization, before we update schedutil.
> >>          */
> >> -       util_est_enqueue(&rq->cfs, p);
> >> +       if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE))))
> >> +               util_est_enqueue(&rq->cfs, p);
> >> +
> >> +       if (flags & ENQUEUE_DELAYED) {
> >> +               requeue_delayed_entity(se);
> >> +               return;
> >> +       }
> >>
> >>         /*
> >>          * If in_iowait is set, the code below may not trigger any cpufreq
> >> @@ -7177,7 +7178,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
> >>   */
> >>  static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >>  {
> >> -       util_est_dequeue(&rq->cfs, p);
> >> +       if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & DEQUEUE_SAVE))))
> >> +               util_est_dequeue(&rq->cfs, p);
> >>
> >>         if (dequeue_entities(rq, &p->se, flags) < 0) {
> >>                 if (!rq->cfs.h_nr_running)
> >> --
> >> 2.34.1
>

