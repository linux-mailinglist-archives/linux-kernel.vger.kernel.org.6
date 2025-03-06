Return-Path: <linux-kernel+bounces-548831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F262A549CB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7967216A038
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9812D20B1FB;
	Thu,  6 Mar 2025 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVVom/fN"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF4F2080C8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261130; cv=none; b=IKcq058mE6LV06NGonU5r34rLBjvgngIbHG8RRRubJ1EJYarrmLUmqeTgxJlcpI6kr4LuIeJYwLl/KJZk4hvvkcwfU5RbatU5rz9GfR7eaSvF9nBg3unx6STgNbAS2jyO1tvY61kP0U19rwYFZGvp6P+L4fV6iTHBvEGfFrVFuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261130; c=relaxed/simple;
	bh=IVvO0RfCZcEKDAjGaq870Xd3vUIClSf8/YZjqDgkEX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqSOioMBfpAbDKVrzMnxNjmJ7qKyHuQHrHTiiVDPkqj7l4Y9j46SEIBJxGVQKKSzkWS+wb28OkHXlkLKmnt2jXUPx59FoKPL4q9G2lRL2APzPyiSHYTUgbxWPkUPg6ce1sh24KL7kpz85BBBfnbjYUgK+db1YbVDPdut8u03S44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVVom/fN; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac202264f9cso101640866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741261127; x=1741865927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58y0YduPzvRb5g3H7uTGOXUasoLSnrc7jZbMgbP171I=;
        b=WVVom/fNUtNA31113/sXkQWuU3LTdUeFtT9xtYZiyFFmCAZMthlmxGVSu8CrMQ5iT9
         wDnq5J9Z1yezq0kuWzgF/5i7o2h3/f1YHsk31KMBiZVJBB74sjt9xA1hlwpUt3SVNvRy
         mVNxsiwj1af5QxzcxYt3iqCgUvYFlJdIMjWVOIvqBm9wq84t1alcGIcBx6TJ/lqaoUzF
         Q6oQXTz0kymSdXTY6+VPdVszyCHgQIlbqlTUYTlQeCKeiT883Y8X3YC0L7a8QYh8x1Pk
         M/zfXcT1r7I7emubYKF/WBmtuuEKd99vP4/LwgMepTsfruSPIXRqDM2vBWhixcZ/NnW/
         xt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741261127; x=1741865927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58y0YduPzvRb5g3H7uTGOXUasoLSnrc7jZbMgbP171I=;
        b=qSdLrSM+FA59H9unwE/+0V0Z12dG8LTxXBzUrXB9BmfRBSQ5bJ4bEnt/YRfMDTKvfM
         fxWcemu8N6BSHzvDpDwFwYq2ses+K5j/lLtXjPBO/beFqIo0ywlYOS0ZWodyjG1HVzoe
         ZaVBq+sfT7k5tNmBP0NRnu10ZR20HAnbTuwEHvFQvA00r4N+g/SmKtukSMBfC8JDKr1n
         rg8I+mzwrhOoEBF/QxA0havvMtMPfJAnsOVkrms56qCwfFDbTVfr+VeAbFo12hC38ZNQ
         z4BFlXpJ51ohNLEoel6GOQNJT4S1w/e03/Mkg6DV+GqQ+lUNWuUsGbR8UIGhoiqyTHfO
         l/Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWUCCwxTmAFQgsX10vg57tvvCOhgO3PER18rhcX4K4w7KHJSARLjGx8vYlJoqBk/c9lpbTbqfHppz9sdac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF7HcYNgRx9f1AWnCgHDh76p/QJ45TTg2XiqGVl6BrVRyA6VTc
	aHSlGJjaAIutk/Bz99rkpAPD78MYWJc8211IT2onPpjHUowf5hlS8RPscJ5U2GlVtNPrr1D4bC9
	sAeb5hQJM96sEljN2aDqOHlXDTf0=
X-Gm-Gg: ASbGncvZPLxKmIQ9JZcw8LOzCq07eG59df9oYkfl3eHiyLSBKhI9enhhYe1ooAAi7uQ
	HtZ5UaIo3XjFSqK3GY/4Zm6r1fABWn0LBDqfQBaxcf9BP3V6lLvmtdZ3NPKu7/gbmYiL2M9htwp
	Agf7sLnnKEob5A9TFt/ymzAHjV0vA=
X-Google-Smtp-Source: AGHT+IETtjtUL9Gj2b74tY5U7EfU5wIOklGcMl599OpsREYBpv5oYO6nis879waPb3Ab5tBd4LqkDnLPDmkR7rbeWGQ=
X-Received: by 2002:a17:907:2dac:b0:abf:425d:5d3 with SMTP id
 a640c23a62f3a-ac20e153516mr619220666b.40.1741261126385; Thu, 06 Mar 2025
 03:38:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741091349.git.hongyan.xia2@arm.com> <CAB8ipk_AvaOWp9QhmnFDdbFSWcKLhCH151=no6kRO2z+pSJfyQ@mail.gmail.com>
 <6eb93af8-e239-44d7-a132-2932f260e792@arm.com>
In-Reply-To: <6eb93af8-e239-44d7-a132-2932f260e792@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Thu, 6 Mar 2025 19:38:32 +0800
X-Gm-Features: AQ5f1JpfTCbRkyQCKmAUZWbsfpVfduCFNez3qodahuyH-rZNKvWoCLLoPdWtwZ0
Message-ID: <CAB8ipk9LpbiUDnbcV6+59+Sa=Ai7tFzO===mpLD3obNdV4=J-A@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] uclamp sum aggregation
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Morten Rasmussen <morten.rasmussen@arm.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Christian Loehle <christian.loehle@arm.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 7:32=E2=80=AFPM Hongyan Xia <hongyan.xia2@arm.com> w=
rote:
>
> Hi Xuewen,
>
> On 06/03/2025 11:12, Xuewen Yan wrote:
> > Hi Hongyan,
> >
> > On Tue, Mar 4, 2025 at 10:26=E2=80=AFPM Hongyan Xia <hongyan.xia2@arm.c=
om> wrote:
> >>
> >> This series gives an alternative implementation that addresses some of
> >> the problems in uclamp max aggregation. Sum aggregation mostly gives:
> >>
> >> 1. Simplicity. Sum aggregation implements uclamp with less than half o=
f
> >>     code than max aggregation.
> >> 2. Effectiveness. Sum aggregation shows better uclamp effectiveness,
> >>     either in benchmark scores or sometimes in energy efficiency.
> >>
> >> The key idea of sum aggregation is fairly simple. Each task has a
> >> util_avg_bias, which is obtained by:
> >>
> >>      util_avg_bias =3D clamp(util_avg, uclamp_min, uclamp_max) - util_=
avg;
> >>
> >> If a CPU has N tasks, p1, p2, p3... pN, then we sum the biases up and
> >> obtain a rq total bias:
> >>
> >>      rq_bias =3D util_avg_bias1 + util_avg_bias2... + util_avg_biasN;
> >>
> >> Then we use the biased rq utilization rq_util + rq_bias to select OPP
> >> and to schedule tasks.
> >>
> >> PATCH BREAKDOWN:
> >>
> >> Patch 1/6 reverts a patch that accommodate uclamp_max tasks under max
> >> aggregation. This patch is not needed and creates other problems for s=
um
> >> aggregation. It is discussed elsewhere that this patch will be improve=
d
> >> and there may not be the need to revert it in the future.
> >>
> >> Patch 2, 3 and 4 implement sum aggregation.
> >>
> >> Patch 5 and 6 remove max aggregation.
> >>
> >> Patch 7 applies PELT decay on negative util_avg_bias. This improves
> >> energy efficiency and task placement, but is not strictly necessary.
> >>
> >> Patch 8 addresses sum aggregation under-utilization problem.
> >>
> >> TESTING:
> >>
> >> Two notebooks are shared at
> >>
> >> https://nbviewer.org/github/honxia02/notebooks/blob/aac12d9becae2b2fe4=
690cbb672439fd884ede30/whitebox/max.ipynb
> >> https://nbviewer.org/github/honxia02/notebooks/blob/aac12d9becae2b2fe4=
690cbb672439fd884ede30/whitebox/sum-offset.ipynb
> >>
> >> The experiments done in notebooks are on Arm Juno r2 board. CPU0-3 are
> >> little cores with capacity of 383. CPU4-5 are big cores. The rt-app
> >> profiles used for these experiments are included in the notebooks.
> >>
> >> Scenario 1: Scheduling 4 tasks with UCLAMP_MAX at 110.
> >>
> >> The scheduling decisions are plotted in Out[11]. Both max and sum
> >> aggregation understand the UCLAMP_MAX hint and schedule all 4 tasks on
> >> the little cluster. Max aggregation sometimes schedule 2 tasks on 1 CP=
U,
> >> and this is the reason why sum aggregation reverts the 1st commit.
> >>
> >> Scenario 2: Scheduling 4 tasks with UCLAMP_MIN and UCLAMP_MAX at a val=
ue
> >> slightly above the capacity of the little CPU.
> >>
> >> Results are in Out[17]. The purpose is to use UCLAMP_MIN to place task=
s
> >> on the big core. Both max and sum aggregation handle this correctly.
> >>
> >> Scenario 3: Task A is a task with a small utilization pinned to CPU4.
> >> Task B is an always-running task pinned to CPU5, but UCLAMP_MAX capped
> >> at 300. After a while, task A is then pinned to CPU5, joining B.
> >>
> >> Results are in Out[23]. Max aggregation sees a frequency spike at
> >> 873.64s. When zoomed in, one can see square-wave-like utilization valu=
es
> >> because of A periodically going to sleep. When A wakes up, its default
> >> UCLAMP_MAX of 1024 will uncap B and reach the highest CPU frequency.
> >> When A sleeps, B's UCLAMP_MAX will be in effect and will reduce rq
> >> utilization. This happens repeatedly, hence the square wave. In
> >> contrast, sum aggregation sees a normal increase in utilization when A
> >> joins B, without any square-wave behavior.
> >>
> >> Scenario 4: 4 always-running tasks with UCLAMP_MAX of 110 pinned to th=
e
> >> little PD (CPU0-3). 4 same tasks pinned to the big PD (CPU4-5).
> >> After a while, remove the CPU pinning of the 4 tasks on the big PD.
> >>
> >> Results are in Out[29]. After unpinning, max aggregation moves all 8
> >> tasks to the little cluster, but schedules 5 tasks on CPU0 and 1 each =
on
> >> CPU1-3. In contrast, sum aggregation schedules 2 on each little CPU
> >> after unpinning, which is the desired balanced task placement.
> >>
> >> EVALUATION:
> >>
> >> We backport patches to GKI kernel v6.1 on Pixel 9 and run Android
> >> benchmarks.
> >>
> >> Speedometer:
> >>
> >> We run Speedometer 2.1 on Chrome v131 to test ADPF/uclamp effectivenes=
s.
> >> Because sum aggregation does not circumvent the 25% OPP margin, we
> >> reduce uclamp values to 80% to be fair.
> >>
> >> |   score   | score |   %    | CPU power % |
> >> |    max    | 192.4 |        |             |
> >> |  sum_0.8  | 230.8 | +19.96 |   +31.54    |
> >> | sum_tuned | 201.8 |  +4.89 |    -0.41    |
> >>
> >> We see a consistant higher score and higher average power consumption.
> >> Note that a higher score also means a reduction in run-time, total
> >> energy increase for sum_0.8 is only 9.65%.
> >>
> >> We then reduce uclamp values so that power consumption is roughly
> >> the same. If we do so, then sum aggregation achieves slightly better
> >> scores, shown in the sum_tuned row.
> >>
> >> UIBench:
> >>
> >> |   score   | jank percentage |   %    | CPU power (mW) |   %   |
> >> |    max    |     0.115%      |        |     158.1      |       |
> >> |  sum_0.8  |     0.129%      | +11.96 |     154.9      | -4.19 |
> >>
> >> UIBench on Pixel 9 by default already has a low enough jank percentage=
.
> >> Moving to sum aggregation gives slightly higher jank percentage and
> >> lower power consumption.
> >>
> >> ---
> >> Changed in v2:
> >> - Completely separate uclamp component from PELT and util_est.
> >> - Separate util_est_uclamp into an individual patch.
> >> - Address the under-utilization problem.
> >> - Update Python notebooks to reflect the latest sched/tip.
> >>
> >> Hongyan Xia (8):
> >>    Revert "sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap i=
s
> >>      0"
> >>    sched/uclamp: Track a new util_avg_bias signal
> >>    sched/uclamp: Add util_est_uclamp
> >>    sched/fair: Use util biases for utilization and frequency
> >>    sched/uclamp: Remove all uclamp bucket logic
> >
> > I=E2=80=99ve recently been looking into the issue with uclamp and
> > delayed-dequeue, and I found that uclamp_rq_inc should be placed
> > before enqueue_task, which led to a patch.
> > Before sending the patch, I came across your series of patches. I
> > haven=E2=80=99t fully understood your patch yet, but it seems like
> > uclamp_rq_inc is no longer needed.
> > Do you think the patch below is still necessary?
> >
>
> I posted a fix of the issue you mentioned days ago here
>
> https://lore.kernel.org/lkml/84441660bef0a5e67fd09dc3787178d0276dad31.174=
0664400.git.hongyan.xia2@arm.com/
>
> I think we found the same issue, but our approaches are different. I
> fear that as more complexity goes into each sched_class like delayed
> dequeue, it's better to just let the sched_class handle how uclamp is
> enqueued and dequeued within itself rather than leaking into core.c.
> Would be nice if you could take a look at my fix.
>
> Your patch is definitely necessary. The thing with this uclamp sum
> aggregation series is that there are still debates around it and it
> might take a while before everything is settled. So, at the moment we
> should view this series and the uclamp enqueue fix as separate things.

Okay, I will look at the patch.

Thanks!

>
> > --->
> >
> > Subject: [PATCH] sched/uclamp: Update the rq's uclamp before enqueue ta=
sk
> >
> > When task's uclamp is set, we hope that the CPU frequency
> > can increase as quickly as possible when the task is enqueued.
> > Because the cpu frequency updating happens during the enqueue_task(),
> > so the rq's uclamp needs to be updated before the task is enqueued.
> > For sched-delayed tasks, the rq uclamp should only be updated
> > when they are enqueued upon being awakened.
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >   kernel/sched/core.c | 14 ++++++--------
> >   1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 67189907214d..b07e78910221 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1747,7 +1747,7 @@ static inline void uclamp_rq_dec_id(struct rq
> > *rq, struct task_struct *p,
> >          }
> >   }
> >
> > -static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
> > +static inline void uclamp_rq_inc(struct rq *rq, struct task_struct
> > *p, int flags)
> >   {
> >          enum uclamp_id clamp_id;
> >
> > @@ -1763,7 +1763,8 @@ static inline void uclamp_rq_inc(struct rq *rq,
> > struct task_struct *p)
> >          if (unlikely(!p->sched_class->uclamp_enabled))
> >                  return;
> >
> > -       if (p->se.sched_delayed)
> > +       /* Only inc the delayed task which is being woken up. */
> > +       if (p->se.sched_delayed && !(flags & ENQUEUE_DELAYED))
> >                  return;
> >
> >          for_each_clamp_id(clamp_id)
> > @@ -2031,7 +2032,7 @@ static void __init init_uclamp(void)
> >   }
> >
> >   #else /* !CONFIG_UCLAMP_TASK */
> > -static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)=
 { }
> > +static inline void uclamp_rq_inc(struct rq *rq, struct task_struct
> > *p, int flags) { }
> >   static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p=
) { }
> >   static inline void uclamp_fork(struct task_struct *p) { }
> >   static inline void uclamp_post_fork(struct task_struct *p) { }
> > @@ -2067,12 +2068,9 @@ void enqueue_task(struct rq *rq, struct
> > task_struct *p, int flags)
> >          if (!(flags & ENQUEUE_NOCLOCK))
> >                  update_rq_clock(rq);
> >
> > +       uclamp_rq_inc(rq, p, flags);
> > +
> >          p->sched_class->enqueue_task(rq, p, flags);
> > -       /*
> > -        * Must be after ->enqueue_task() because ENQUEUE_DELAYED can c=
lear
> > -        * ->sched_delayed.
> > -        */
> > -       uclamp_rq_inc(rq, p);
> >
> >          psi_enqueue(p, flags);
> >
> > --
> >
> > Thanks!
> >
> > BR
> > ---
> >
> >>    sched/uclamp: Simplify uclamp_eff_value()
> >>    sched/uclamp: Propagate negative bias
> >>    sched/uclamp: Solve under-utilization problem
> >>
> >>   include/linux/sched.h            |   8 +-
> >>   init/Kconfig                     |  32 ---
> >>   kernel/sched/core.c              | 308 ++--------------------
> >>   kernel/sched/cpufreq_schedutil.c |   6 +-
> >>   kernel/sched/debug.c             |   2 +-
> >>   kernel/sched/fair.c              | 430 ++++++++++++++++-------------=
--
> >>   kernel/sched/pelt.c              |  62 +++++
> >>   kernel/sched/rt.c                |   4 -
> >>   kernel/sched/sched.h             | 132 +++-------
> >>   kernel/sched/syscalls.c          |   2 +
> >>   10 files changed, 341 insertions(+), 645 deletions(-)
> >>
> >> --
> >> 2.34.1
> >>
> >>
>

