Return-Path: <linux-kernel+bounces-576438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07004A70F43
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83F66170F74
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 02:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173841519A3;
	Wed, 26 Mar 2025 02:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBbQ+UA8"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C814F5E0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 02:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742957858; cv=none; b=apY+34Lsm0rOTguHNCliEuQ7FRu4GlYtL8GBPdx9IRD8CMczLlVVDoePJDiwvZDKabNbNxjBZOZ3VwIJWUsFdfhaf6v7arD/16EgYCzcPOakbyUrKcP0sN1s7O4epNsemc1Caq32U2M3zwL+fW6X617rkwBLrN6HKHqf21EPxew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742957858; c=relaxed/simple;
	bh=3zUh25igPqCU3rwxsNPuIVUkhsq5iIUk+p/otzHQNUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2dTOq/b/N9oZJ9Wz6e5TVZZ5t6S0blT3TG4c049UAkQZ+8yVrDAFi/z4vviHMnhdB6ngbumnqUpAj+sLN6thN4mS2cu1WY3HnLgtw9hM/D1jARF3n7rztiQ+K/2byUtMReNRlT/RQ2LrsNiG4ljyF1Eqn96f0llAknJ7J2Cwak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBbQ+UA8; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4766cb762b6so4906621cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742957855; x=1743562655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPGsfAMweyg7f/PkC1c7/z0HXQRDPVLYe4d4lmlCJnQ=;
        b=dBbQ+UA8ywKdcteNI+mQikKGH2Gy/w6ZrOwCdH6BQDJxKImMW8nxjpY2LTd8MYiY32
         bkVRt9eTzAEnf+DfAAwTbvgodzybkrw2at7lpS32NrEWx0810yo1MsYFn3bfOonhqIws
         Es2U0tEG7X0FPBqQG9Eo7SKCXevqB+YeWCjzLP9KPpPrbQed3qDoEPr6H6afZreJxjaj
         747ogYdDD+QGUqobaGlGkB3TeaRT/WPL/D1mgYMvVHHFCFr8n/y5FP0XFfHsUnSAn2kd
         bvXJVhGOE35piAMkjhBA3M8+eVe75r0ijb1mJyGEz1SpaRpa0aNoewqJul+S2Kqk/c1f
         NB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742957855; x=1743562655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPGsfAMweyg7f/PkC1c7/z0HXQRDPVLYe4d4lmlCJnQ=;
        b=KZCQYUujsasbBBedY6o/AMOa0g1TpO8I1pmyskxQn+Ubnm7N8sTL5kGFWmqrokb3mQ
         0E+fouNXBz+0QCxhvu6vPEa8nfYrYS+p+eOrnkjn8V7QMD7QMitiWeXFXl64JHxbGmxP
         qw0eBs8jIZY3wH1L1q8DvIRWGGPR1PYJnIDhMUt8zFTz51vzLeB3GRGS/dAAJXIHpQbq
         vLVFrDgUPMwV4v5KzBJSt9PuVQKr++qG01d182tH0pt9ZkP6C/hWOKX0f40F6J2MgqnJ
         eJReMo5UCa9BH8/VNh6yFc+z1l9FYcjQB3afeFZ9J+FTdQE4RsmpSmm6WYK6jdOqiArN
         QxpA==
X-Forwarded-Encrypted: i=1; AJvYcCW1KKXv3v8yIGVanis9VltxyGgyGYTyPeeD5PeaEMN3R7ZfEg9Bqg/YpvT+qIX9CAUs2KrNkl255xIuj/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9WDdaHMHyrt8HzVZTYNzcxpy0x/IczW+tAnXk0ctsKPfW2GJU
	+YYd/WZm5RJosijJC1mHHeP+niPwBjWKcBo+QVUilf0BGVsRHme9S8CuDrz/RPgehqcjmP41BkZ
	YsmLYDhQK3XsrEdj7NnQRgWehpJx7WZA4
X-Gm-Gg: ASbGnctpHCMBpvxY2GEVe3LHPbLT7gNuthNi8a5JiZMBNLGa1jnfQhCOVABW2kCL8os
	LnXnyMgdrAl9w9mS9NDAtPp2FtjQVPsEdzg9cxo2U2wjoCX8iLOtxGuWLjY5Yqhx5b+dRy77ojg
	r9iHF7+CRO2FpGoH1GXvFnOfXhSf3kW+4LETBb0g==
X-Google-Smtp-Source: AGHT+IGicsEMCxsAryy3ZCzJQ3ey3GSGgSPsekkSLB1RI4X2rGLX/udY9fX3GXWhovM4HrLfGXcFxPl8Zw/S0/dNKbw=
X-Received: by 2002:a05:622a:5883:b0:472:521:871a with SMTP id
 d75a77b69052e-4775f3c92a1mr35167131cf.23.1742957855168; Tue, 25 Mar 2025
 19:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325014733.18405-1-xuewen.yan@unisoc.com> <03344e80-4ed2-41f1-9d2b-f7ed2e201eba@amd.com>
In-Reply-To: <03344e80-4ed2-41f1-9d2b-f7ed2e201eba@amd.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Wed, 26 Mar 2025 10:57:24 +0800
X-Gm-Features: AQ5f1JrCDvHsL9QpBKnSly3SPyFwPeWIywHrCRLH3WOtGnb5Zjh6rQ4QNjXctBI
Message-ID: <CAB8ipk_1=U_HgVQrfQ4VRUDrcHJBQd2LJ9aXh8PG6E-Z4_xS+g@mail.gmail.com>
Subject: Re: [PATCH v2] sched/uclamp: Align uclamp and util_est and call
 before freq update
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	hongyan.xia2@arm.com, qyousef@layalina.io, ke.wang@unisoc.com, 
	di.shen@unisoc.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prateek,

On Wed, Mar 26, 2025 at 12:54=E2=80=AFAM K Prateek Nayak <kprateek.nayak@am=
d.com> wrote:
>
> Hello Xuewen,
>
> On 3/25/2025 7:17 AM, Xuewen Yan wrote:
> > When task's uclamp is set, we hope that the CPU frequency
> > can increase as quickly as possible when the task is enqueued.
> > Because the cpu frequency updating happens during the enqueue_task(),
> > so the rq's uclamp needs to be updated before the task is enqueued,
> > just like util_est.
> > So, aline the uclamp and util_est and call before freq update.
> >
> > For sched-delayed tasks, the rq uclamp/util_est should only be updated
> > when they are enqueued upon being awakened.
> > So simply the logic of util_est's enqueue/dequeue check.
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> > v2:
> > - simply the util-est's en/dequeue check;
> > ---
> > Previous discussion:
> > https://lore.kernel.org/all/CAB8ipk8pEvOtCm-d0o1rsekwxPWUHk9iBGtt9TLTWW=
-iWTQKiA@mail.gmail.com/
> > https://lore.kernel.org/all/84441660bef0a5e67fd09dc3787178d0276dad31.17=
40664400.git.hongyan.xia2@arm.com/T/#u
> > https://lore.kernel.org/all/CAB8ipk9LpbiUDnbcV6+59+Sa=3DAi7tFzO=3D=3D=
=3DmpLD3obNdV4=3DJ-A@mail.gmail.com/T/#u
> > https://lore.kernel.org/all/aa8baf67-a8ec-4ad8-a6a8-afdcd7036771@arm.co=
m/
> > ---
> >   kernel/sched/core.c | 17 ++++++++++-------
> >   kernel/sched/fair.c |  4 ++--
> >   2 files changed, 12 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 042351c7afce..72fbe2031e54 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1747,7 +1747,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq=
, struct task_struct *p,
> >       }
> >   }
> >
> > -static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
> > +static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p,=
 int flags)
> >   {
> >       enum uclamp_id clamp_id;
> >
> > @@ -1763,7 +1763,8 @@ static inline void uclamp_rq_inc(struct rq *rq, s=
truct task_struct *p)
> >       if (unlikely(!p->sched_class->uclamp_enabled))
> >               return;
> >
> > -     if (p->se.sched_delayed)
> > +     /* Only inc the delayed task which being woken up. */
> > +     if (p->se.sched_delayed && !(flags & ENQUEUE_DELAYED))
> >               return;
> >
> >       for_each_clamp_id(clamp_id)
> > @@ -2031,7 +2032,7 @@ static void __init init_uclamp(void)
> >   }
> >
> >   #else /* !CONFIG_UCLAMP_TASK */
> > -static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)=
 { }
> > +static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p,=
 int flags) { }
> >   static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p=
) { }
> >   static inline void uclamp_fork(struct task_struct *p) { }
> >   static inline void uclamp_post_fork(struct task_struct *p) { }
> > @@ -2067,12 +2068,14 @@ void enqueue_task(struct rq *rq, struct task_st=
ruct *p, int flags)
> >       if (!(flags & ENQUEUE_NOCLOCK))
> >               update_rq_clock(rq);
> >
> > -     p->sched_class->enqueue_task(rq, p, flags);
> >       /*
> > -      * Must be after ->enqueue_task() because ENQUEUE_DELAYED can cle=
ar
> > -      * ->sched_delayed.
> > +      * Can be before ->enqueue_task() because uclamp considers the
> > +      * ENQUEUE_DELAYED task before its ->sched_delayed gets cleared
> > +      * in ->enqueue_task().
> >        */
> > -     uclamp_rq_inc(rq, p);
> > +     uclamp_rq_inc(rq, p, flags);
> > +
> > +     p->sched_class->enqueue_task(rq, p, flags);
> >
> >       psi_enqueue(p, flags);
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index c798d2795243..c92fee07fb7b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6930,7 +6930,7 @@ enqueue_task_fair(struct rq *rq, struct task_stru=
ct *p, int flags)
> >        * Let's add the task's estimated utilization to the cfs_rq's
> >        * estimated utilization, before we update schedutil.
> >        */
> > -     if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags &=
 ENQUEUE_RESTORE))))
> > +     if (!p->se.sched_delayed || (flags & ENQUEUE_DELAYED))
> >               util_est_enqueue(&rq->cfs, p);
>
> Wouldn't this do a util_est_{dequeue,enqueue}() for a save restore
> operation too of a non-delayed task? Is that desired?

For delayed-task, its util_est should dequeue/enqueue only for its
sleeping and waking up,
For the save restore operation, there is no need to enqueue it,
because it is not woken up.
So the condition of enqueue actually is:
if (!p->se.sched_delayed || (p->se.sched_delayed && (flags & ENQUEUE_DELAYE=
D)))
And, this is equal to :
if (!p->se.sched_delayed || (flags & ENQUEUE_DELAYED))

More details here:
https://lore.kernel.org/all/84441660bef0a5e67fd09dc3787178d0276dad31.174066=
4400.git.hongyan.xia2@arm.com/T/#ma2505e90489316eb354390b42dee9d053f6fd1e9

>
> On a larger note ...
>
> An enqueue of a delayed task will call requeue_delayed_entity() which
> will only enqueue p->se on its cfs_rq and do an update_load_avg() for
> that cfs_rq alone.
>
> With cgroups enabled, this cfs_rq might not be the root cfs_rq and
> cfs_rq_util_change() will not call cpufreq_update_util() leaving the
> CPU running at the older frequency despite the updated uclamp
> constraints.
>
> If think cfs_rq_util_change() should be called for the root cfs_rq
> when a task is delayed or when it is re-enqueued to re-evaluate
> the uclamp constraints.

I think you're referring to a different issue with the delayed-task's
util_ets/uclamp.
This issue is unrelated to util-est and uclamp, because even without
these two features, the problem you're mentioning still exists.
Specifically, if the delayed-task is not the root CFS task, the CPU
frequency might not be updated in time when the delayed-task is
enqueued.
Maybe we could add the update_load_avg() in clear_delayed to solve the issu=
e?

-->8--

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a0c4cd26ee07..c75d50dab86b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5435,6 +5435,7 @@ static void clear_delayed(struct sched_entity *se)
        for_each_sched_entity(se) {
                struct cfs_rq *cfs_rq =3D cfs_rq_of(se);

+               update_load_avg(cfs_rq, se, UPDATE_TG);
                cfs_rq->h_nr_runnable++;
                if (cfs_rq_throttled(cfs_rq))
                        break;

---

BR
xuewen

