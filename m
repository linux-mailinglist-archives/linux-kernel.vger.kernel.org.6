Return-Path: <linux-kernel+bounces-548862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC9A54A3E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3BB188E23F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192A02063C3;
	Thu,  6 Mar 2025 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FovarSi7"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4754D1FC7FF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741262631; cv=none; b=Wza7tGs0Ld9yA2wjSIohJ4k4gNKHXdywkEo+m9asLA/o2TlYBhZ4LDJIrfbBmbB9yq/ptb8iRhDnTlBSA4K2VbGyumZ2I64OFwlcSpVK9IwPYZ2Orh5kqQUCZl+X2Dqmr0iuZ5Z377KSSKqlDs5uM55IoDAtF//BOjxktFefdTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741262631; c=relaxed/simple;
	bh=jWFV4ugbql1khahqJopcd/i0Pa4mczy1QE6qHiXtVb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9mVWoWcO45hjCpicbre6GE6SBz/Ue7CebQs4sp7wbooe+dqvIpj2t56QFxsKXwLmR4kp1Vfw8GDuCXnMmS7m+XxiDfNvzhbwwlayUw8vFjP/UDMTb1YhcC17TF3VRtO14W8dXWnB8SuSgw3/qEE8kegeyNNw9P7MvvfcokWTys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FovarSi7; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab771575040so337829866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 04:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741262627; x=1741867427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8jaf1DymlDATybUorICW5SzH4hHp8n7eITjEXTUSps=;
        b=FovarSi7muwWxSE0b6yFXZfFD1EzWJnJCgt6wL9aZj73MljPC8lklyS5lPWBx4gtvd
         0JZVayxkfqHpUtcSvSlEGKf2IYRNhz66LuLEPuLMPOKjP7gejNoQT7YVJZ5NnyVb/o7F
         TImKiUGMUY0keyk0m+tYNr3t7UiwCDIc7Bf456QWhuIxvrUVky5L9q7pMimiuWH/DWFy
         U80r3xYv35aPcD18k7ojJCdQn9jHiHMWWB5SN+1QzubnvhSOXkjtLR+vgPJHahjYXHiD
         iKibXhzwY3EBXRbAqpKQuY9EwTdHrQw5TnkdXDKHyNFijMT/awCiKag0i9YNQ8altszJ
         Mzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741262627; x=1741867427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8jaf1DymlDATybUorICW5SzH4hHp8n7eITjEXTUSps=;
        b=rYoNPUM2pk48t2SyB5XLivwLFvJXY4gGedK4yG2N0KN0uleQJzF93QlGVpc2sJirRT
         qcqT286Np58GZpgHaJi/H899YXAWtFcIQTIaK6iAgQTHyep34A39xLzEYT+8kT+m7sbi
         ytiHPBdXWEsCVksfxP4oj94bZTMpXPPmB9vpdDanD3MsqDXovsQdeRlFNLrSkjOcMMNn
         NMKijnfkvTE/Zi4IDgpbwlzdjfD/0BuQ+yj2dEfft2u7+P0w8HHYhxLaevi4RZS3NrdZ
         fPBFXV0bpMaeo8LO68JBohdFjnKDna+VyIGonLwAqV7ZxM8dtkhEpF9amwdiScvxYq1v
         r31Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqQmPfCguOqYxZBCAGXBG/ezIYTH+PlkKYfexcNharkK6WAj4cs91ypXbydwZu2FWjgnjGp0zmSu2w94E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGkcTn24tZTkMQWA3vEtIH8Ed++Z3AFp4CQmT1S6jKLEo4ASaX
	eAGePQcXvVDuBdt3wZykpSvem/8Vrap6694oGyg7/9aDA9kIY1u70Ise32YZVEvQg2QqUnc3hNf
	wGa1EE17YZNUvGGFGpVKCbdOf2Q8=
X-Gm-Gg: ASbGncvk2XyXLVWSvskxQDZpxH+23AmAT50UZYakF1A/yrHGyY42uqZi/l/562RNm1s
	XzJ2ubVqSBiscyGTB3WjBG4IrM4qwgykor+PMbh0lG0MqwCypgwKnyv0SyDwSqS+q+wSlkhH6Bq
	3aTuUKjlvHa8tryEpDr1fTOeVSSQI=
X-Google-Smtp-Source: AGHT+IFcWkO1tOCSIQdjCALK5MOzbXU6T8HPu+q+v8f13GktJf/jKewg7YW/p7ePabblkK3GTMCCBPoDW4ASlm20im4=
X-Received: by 2002:a17:907:2d12:b0:abf:4a62:6e5b with SMTP id
 a640c23a62f3a-ac22ca6c17emr278138566b.5.1741262627188; Thu, 06 Mar 2025
 04:03:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <84441660bef0a5e67fd09dc3787178d0276dad31.1740664400.git.hongyan.xia2@arm.com>
In-Reply-To: <84441660bef0a5e67fd09dc3787178d0276dad31.1740664400.git.hongyan.xia2@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Thu, 6 Mar 2025 20:03:34 +0800
X-Gm-Features: AQ5f1JpH_yIH3DJregzXfMOKSWac8fpX8Wqg9oddhEjnc23k1qrzYsnXeZmWq8k
Message-ID: <CAB8ipk_xXY7Dia32NzCpva_Bi1L7ijTHjZHA_riCUwj7e4PtpA@mail.gmail.com>
Subject: Re: [PATCH] sched/uclamp: Let each sched_class handle uclamp
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	Xuewen Yan <xuewen.yan@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hongyan,

On Thu, Feb 27, 2025 at 9:55=E2=80=AFPM Hongyan Xia <hongyan.xia2@arm.com> =
wrote:
>
> While delayed dequeue issues were being resolved, uclamp was made out of
> sync with cpufreq, especially in enqueue_task().
>
> For example, when a task with uclamp_min goes through enqueue_task() and
> updates cpufreq, its uclamp_min won't even be considered in the cpufreq
> update. It is only after enqueue will the uclamp_min be added to rq
> buckets, and cpufreq will only pick it up at the next update. This is
> very different from the old behavior, where a uclamp value immediately
> has an effect at enqueue. Worse, sub classes like fair.c issue cpufreq
> updates on utilization changes. If no utilization changes for a while,
> the new uclamp will be delayed further.
>
> So, let each sched_class handle uclamp in its own class, in case delayed
> dequeue needs further tweaks or there are potential future similar
> changes, and make sure uclamp is picked up immediately on enqueue. In
> fair.c, we re-use the guard logic for util_est.
>
> Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
> ---
>  kernel/sched/core.c  | 28 ++--------------------------
>  kernel/sched/ext.c   |  8 ++++----
>  kernel/sched/fair.c  | 12 ++++++------
>  kernel/sched/rt.c    |  8 ++++----
>  kernel/sched/sched.h |  9 +++++----
>  5 files changed, 21 insertions(+), 44 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b00f884701a6..2d51608a4c46 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1745,7 +1745,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, =
struct task_struct *p,
>         }
>  }
>
> -static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
> +void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>  {
>         enum uclamp_id clamp_id;
>
> @@ -1758,12 +1758,6 @@ static inline void uclamp_rq_inc(struct rq *rq, st=
ruct task_struct *p)
>         if (!static_branch_unlikely(&sched_uclamp_used))
>                 return;
>
> -       if (unlikely(!p->sched_class->uclamp_enabled))
> -               return;
> -
> -       if (p->se.sched_delayed)
> -               return;
> -
>         for_each_clamp_id(clamp_id)
>                 uclamp_rq_inc_id(rq, p, clamp_id);
>
> @@ -1772,7 +1766,7 @@ static inline void uclamp_rq_inc(struct rq *rq, str=
uct task_struct *p)
>                 rq->uclamp_flags &=3D ~UCLAMP_FLAG_IDLE;
>  }
>
> -static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
> +void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
>  {
>         enum uclamp_id clamp_id;
>
> @@ -1785,12 +1779,6 @@ static inline void uclamp_rq_dec(struct rq *rq, st=
ruct task_struct *p)
>         if (!static_branch_unlikely(&sched_uclamp_used))
>                 return;
>
> -       if (unlikely(!p->sched_class->uclamp_enabled))
> -               return;
> -
> -       if (p->se.sched_delayed)
> -               return;
> -
>         for_each_clamp_id(clamp_id)
>                 uclamp_rq_dec_id(rq, p, clamp_id);
>  }
> @@ -2029,8 +2017,6 @@ static void __init init_uclamp(void)
>  }
>
>  #else /* !CONFIG_UCLAMP_TASK */
> -static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) {=
 }
> -static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) {=
 }
>  static inline void uclamp_fork(struct task_struct *p) { }
>  static inline void uclamp_post_fork(struct task_struct *p) { }
>  static inline void init_uclamp(void) { }
> @@ -2066,11 +2052,6 @@ void enqueue_task(struct rq *rq, struct task_struc=
t *p, int flags)
>                 update_rq_clock(rq);
>
>         p->sched_class->enqueue_task(rq, p, flags);
> -       /*
> -        * Must be after ->enqueue_task() because ENQUEUE_DELAYED can cle=
ar
> -        * ->sched_delayed.
> -        */
> -       uclamp_rq_inc(rq, p);
>
>         psi_enqueue(p, flags);
>
> @@ -2097,11 +2078,6 @@ inline bool dequeue_task(struct rq *rq, struct tas=
k_struct *p, int flags)
>
>         psi_dequeue(p, flags);
>
> -       /*
> -        * Must be before ->dequeue_task() because ->dequeue_task() can '=
fail'
> -        * and mark the task ->sched_delayed.
> -        */
> -       uclamp_rq_dec(rq, p);
>         return p->sched_class->dequeue_task(rq, p, flags);
>  }
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 8857c0709bdd..4521c27f9ab8 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2094,6 +2094,8 @@ static void enqueue_task_scx(struct rq *rq, struct =
task_struct *p, int enq_flags
>  {
>         int sticky_cpu =3D p->scx.sticky_cpu;
>
> +       uclamp_rq_inc(rq, p);
> +
>         if (enq_flags & ENQUEUE_WAKEUP)
>                 rq->scx.flags |=3D SCX_RQ_IN_WAKEUP;
>
> @@ -2181,6 +2183,8 @@ static void ops_dequeue(struct task_struct *p, u64 =
deq_flags)
>
>  static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int d=
eq_flags)
>  {
> +       uclamp_rq_dec(rq, p);
> +
>         if (!(p->scx.flags & SCX_TASK_QUEUED)) {
>                 WARN_ON_ONCE(task_runnable(p));
>                 return true;
> @@ -4456,10 +4460,6 @@ DEFINE_SCHED_CLASS(ext) =3D {
>         .prio_changed           =3D prio_changed_scx,
>
>         .update_curr            =3D update_curr_scx,
> -
> -#ifdef CONFIG_UCLAMP_TASK
> -       .uclamp_enabled         =3D 1,
> -#endif
>  };
>
>  static void init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id)
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 857808da23d8..7e5a653811ad 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6941,8 +6941,10 @@ enqueue_task_fair(struct rq *rq, struct task_struc=
t *p, int flags)
>          * Let's add the task's estimated utilization to the cfs_rq's
>          * estimated utilization, before we update schedutil.
>          */
> -       if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags &=
 ENQUEUE_RESTORE))))
> +       if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags &=
 ENQUEUE_RESTORE)))) {
> +               uclamp_rq_inc(rq, p);
>                 util_est_enqueue(&rq->cfs, p);
> +       }
>
>         if (flags & ENQUEUE_DELAYED) {
>                 requeue_delayed_entity(se);
> @@ -7183,8 +7185,10 @@ static int dequeue_entities(struct rq *rq, struct =
sched_entity *se, int flags)
>   */
>  static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int =
flags)
>  {
> -       if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags &=
 DEQUEUE_SAVE))))
> +       if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags &=
 DEQUEUE_SAVE)))) {
> +               uclamp_rq_dec(rq, p);
>                 util_est_dequeue(&rq->cfs, p);
> +       }
>
>         util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
>         if (dequeue_entities(rq, &p->se, flags) < 0)
> @@ -13660,10 +13664,6 @@ DEFINE_SCHED_CLASS(fair) =3D {
>  #ifdef CONFIG_SCHED_CORE
>         .task_is_throttled      =3D task_is_throttled_fair,
>  #endif
> -
> -#ifdef CONFIG_UCLAMP_TASK
> -       .uclamp_enabled         =3D 1,
> -#endif
>  };
>
>  #ifdef CONFIG_SCHED_DEBUG
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 4b8e33c615b1..7c0642ea85f2 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1471,6 +1471,8 @@ enqueue_task_rt(struct rq *rq, struct task_struct *=
p, int flags)
>  {
>         struct sched_rt_entity *rt_se =3D &p->rt;
>
> +       uclamp_rq_inc(rq, p);
> +
>         if (flags & ENQUEUE_WAKEUP)
>                 rt_se->timeout =3D 0;
>
> @@ -1487,6 +1489,8 @@ static bool dequeue_task_rt(struct rq *rq, struct t=
ask_struct *p, int flags)
>  {
>         struct sched_rt_entity *rt_se =3D &p->rt;
>
> +       uclamp_rq_dec(rq, p);
> +
>         update_curr_rt(rq);
>         dequeue_rt_entity(rt_se, flags);
>
> @@ -2649,10 +2653,6 @@ DEFINE_SCHED_CLASS(rt) =3D {
>  #ifdef CONFIG_SCHED_CORE
>         .task_is_throttled      =3D task_is_throttled_rt,
>  #endif
> -
> -#ifdef CONFIG_UCLAMP_TASK
> -       .uclamp_enabled         =3D 1,
> -#endif
>  };
>
>  #ifdef CONFIG_RT_GROUP_SCHED
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ab16d3d0e51c..990d87e8d8ed 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2410,10 +2410,6 @@ extern s64 update_curr_common(struct rq *rq);
>
>  struct sched_class {
>
> -#ifdef CONFIG_UCLAMP_TASK
> -       int uclamp_enabled;
> -#endif

Why delete the uclamp_enable?

> -
>         void (*enqueue_task) (struct rq *rq, struct task_struct *p, int f=
lags);
>         bool (*dequeue_task) (struct rq *rq, struct task_struct *p, int f=
lags);
>         void (*yield_task)   (struct rq *rq);
> @@ -3393,6 +3389,8 @@ static inline bool update_other_load_avgs(struct rq=
 *rq) { return false; }
>  #ifdef CONFIG_UCLAMP_TASK
>
>  unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id cla=
mp_id);
> +void uclamp_rq_inc(struct rq *rq, struct task_struct *p);
> +void uclamp_rq_dec(struct rq *rq, struct task_struct *p);
>
>  static inline unsigned long uclamp_rq_get(struct rq *rq,
>                                           enum uclamp_id clamp_id)
> @@ -3470,6 +3468,9 @@ uclamp_se_set(struct uclamp_se *uc_se, unsigned int=
 value, bool user_defined)
>
>  #else /* !CONFIG_UCLAMP_TASK: */
>
> +static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) {=
 };
> +static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) {=
 };
> +
>  static inline unsigned long
>  uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
>  {
> --
> 2.34.1
>
>

