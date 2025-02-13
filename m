Return-Path: <linux-kernel+bounces-513550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D21A2A34B89
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4DB1882292
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD4F203711;
	Thu, 13 Feb 2025 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhQ9qg9l"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C09202F60
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466817; cv=none; b=JFwMZqUfFSfWyOJY63GotY/2qMPHawvrUj9Opki4AfGzxv3YIgzDpX9T0PLwhAw0qjE+oJYqwDK6+CYJzGFdDLmmZ8oNJ4iGmbTUz4+/AkOeASq3W3oAixx6d4q8blxkeYVJdhEROrKPksYyCQFBMytlBlgw9CDWElKSXgFM6Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466817; c=relaxed/simple;
	bh=Z1gx+d9KD+fwXgkW7noVLO3LRyUNlol61dY2QcSnYmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTCkFURX5MVLv0t5ebEZ84oSFW/1Y+oTvkRlkyl+ENo7OckL4XUOqJOeWWM0m/kxYP99Lh7RAfnyrL0UVDUWFgKyB0CO0s2MFJzl6MjMfXPf5qmtJRkDNb78fIuznBjAtFzOeITfQ6nGE7YB6yrYpnOcebzlYhBCV2PvV0L0qiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EhQ9qg9l; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6f74b78df93so12060027b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739466814; x=1740071614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4N4dnRJLEMfc5wr2E5ElHWH+c2BgiHQLnksgHaawHw=;
        b=EhQ9qg9lGkZzsgq2QoPMuQXlYkJKfksvtiMnm1DLiWkJy1zRVVYj9ToE8P+YhUIfba
         gql3bJz6iHX3w7xmNZmTl6I2qsAwV/X2FUIG/qlXK5su08dt1zQB/Og3UgiFGh2Ckxtv
         8qVCinIhJfCzaNKJsHz1nAN/qEdORd0u0RRM3X/aOFDdqW6uMfVaX9tqJi8nnRuAH2sE
         RhmgaDcVt+cMWD2iGthGe9rnKAthhLPApkvKYKZVPsUSF4dpXJWxgV5fKLKGOTeE+sk3
         pOHMcAW6Rw/E2c6RKa2S4kWDZSnYzp4p9VyEjtBHXS7KHkL1QkJh5HtU2wFUPeADxDK0
         L6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739466814; x=1740071614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4N4dnRJLEMfc5wr2E5ElHWH+c2BgiHQLnksgHaawHw=;
        b=kra6/0BeDjwZOGBWhiepB9g/JlpqLy8qkGGd5D3yjxgr2+H/iZxkw7D29o0tAlGZhQ
         7QtpyVRKL4E9cMl7PFB4A+nNuDuiYeSb/nYkGi5wkjXd0QkA6P3Gk7Qq5DzqXOaPO6fx
         6++y7/jKIeLQ6F2abnC0PlMSPImkC1zJQqSaQiLQZ8/1fGxXoFCyNipEKtU3/v+btkNS
         snh2M6fw5umW4tvS3cC8liFSdn5ZoCFqJDWH4sbLVCj9DV9cIrv2+0kQ2CPTlHgj0dw9
         3MWD5t61AZi3Yp8TwIbWyCkjzw9qxTMyNsk1T3oBX1hWNrT5ZK0xkaRxf3gwvVl5JK1+
         N/7w==
X-Forwarded-Encrypted: i=1; AJvYcCWTBxBEb0B+1hwvf0jgux30LVUfDd8/79iVj4hlxWG229OaDFi+wouS+wbZNEc46xmHUt1m0ejFlKfkECY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx4H9Q0go7hoktq/7P4oFMJSJ24AWM0AlHLhFaNWPVLJI2K65F
	3ndWs9+pLDmmOSZvw1fa3lXdww7Qf7UreNqNs4FCJyOAih9PXCxOWAoZKYivHkDBI0hhQH37gKY
	Q93zeCQJPRL/j3FoWx1G7xQHQ7rFSJQ18wG+i
X-Gm-Gg: ASbGncu2CUaBOs9z9dBuxbJFpA32yxre7s6z5Q5wHqYU8T4V8y4tfaSyDq+2CWHdeFS
	JwlWkvuWOrfkj679YUebgrT37w9xc6iVdFX3KgfQnLgYyGr0vPsPrpqWb1YhrV6+BpWrdA6zRaJ
	zbKAYwxxlOeJsQWCFapk7CXolwIsjJIA==
X-Google-Smtp-Source: AGHT+IHTlYjRsYcli7xRTU3j9viOC5Jiu+MtNYMPzgb/YmalFnLJw3O3OS3xWtv5cL1TBiwzIVBKACTWlBtYkF2kmN8=
X-Received: by 2002:a05:690c:3802:b0:6f9:957b:e14b with SMTP id
 00721157ae682-6fb1f1ab110mr91023677b3.16.1739466814396; Thu, 13 Feb 2025
 09:13:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z60p755gE1aDiimC@slm.duckdns.org>
In-Reply-To: <Z60p755gE1aDiimC@slm.duckdns.org>
From: Neel Natu <neelnatu@google.com>
Date: Thu, 13 Feb 2025 09:13:23 -0800
X-Gm-Features: AWEUYZlDzNzG3JLWcQs7k_AUvVuvwO3aKr2Xni0KqgBEw4p_80WsE_EtrqXYiJ8
Message-ID: <CAJDe-OLcEe8AuOeffusdxhktTyoAkCgG-7zWAvcuSWWGfDrakQ@mail.gmail.com>
Subject: Re: [PATCH sched_ext/for-6.15] sched_ext: Implement SCX_OPS_ALLOW_QUEUED_WAKEUP
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Barret Rhoden <brho@google.com>, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Tejun!

On Wed, Feb 12, 2025 at 3:08=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> A task wakeup can be either processed on the waker's CPU or bounced to th=
e
> wakee's previous CPU using an IPI (ttwu_queue). Bouncing to the wakee's C=
PU
> avoids the waker's CPU locking and accessing the wakee's rq which can be
> expensive across cache and node boundaries.
>
> When ttwu_queue path is taken, select_task_rq() and thus ops.select_cpu()
> are skipped. As this confused some BPF schedulers, there wasn't a good wa=
y

A minor nit in that the commit msg suggests that if ttwu_queue() path is ta=
ken
to do the wakeup on remote cpu then select_task_rq()->ops.select_cpu() is
always skipped as opposed to "sometimes" skipped.

In my understanding select_task_rq() is skipped in a very specific path:
try_to_wake_up() observes 'p->on_cpu=3D1' and does ttwu_queue_wakelist().

In all the other cases ttwu_queue() will be preceded by select_task_rq().

best
Neel

> for a BPF scheduler to tell whether idle CPU selection has been skipped,
> ops.enqueue() couldn't insert tasks into foreign local DSQs, and the
> performance difference on machines with simple toplogies were minimal,
> sched_ext disabled ttwu_queue.
>
> However, this optimization makes noticeable difference on more complex
> topologies and a BPF scheduler now has an easy way tell whether
> ops.select_cpu() was skipped since 9b671793c7d9 ("sched_ext, scx_qmap: Ad=
d
> and use SCX_ENQ_CPU_SELECTED") and can insert tasks into foreign local DS=
Qs
> since 5b26f7b920f7 ("sched_ext: Allow SCX_DSQ_LOCAL_ON for direct
> dispatches").
>
> Implement SCX_OPS_ALLOW_QUEUED_WAKEUP which allows BPF schedulers to choo=
se
> to enable ttwu_queue optimization.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Neel Natu <neelnatu@google.com>
> Reported-by: Barret Rhoden <brho@google.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c |    9 ++-------
>  kernel/sched/ext.c  |   30 ++++++++++++++++++++++++------
>  kernel/sched/ext.h  |   10 ++++++++++
>  3 files changed, 36 insertions(+), 13 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3921,13 +3921,8 @@ bool cpus_share_resources(int this_cpu,
>
>  static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
>  {
> -       /*
> -        * The BPF scheduler may depend on select_task_rq() being invoked=
 during
> -        * wakeups. In addition, @p may end up executing on a different C=
PU
> -        * regardless of what happens in the wakeup path making the ttwu_=
queue
> -        * optimization less meaningful. Skip if on SCX.
> -        */
> -       if (task_on_scx(p))
> +       /* See SCX_OPS_ALLOW_QUEUED_WAKEUP. */
> +       if (!scx_allow_ttwu_queue(p))
>                 return false;
>
>         /*
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -96,7 +96,7 @@ enum scx_ops_flags {
>         /*
>          * Keep built-in idle tracking even if ops.update_idle() is imple=
mented.
>          */
> -       SCX_OPS_KEEP_BUILTIN_IDLE =3D 1LLU << 0,
> +       SCX_OPS_KEEP_BUILTIN_IDLE       =3D 1LLU << 0,
>
>         /*
>          * By default, if there are no other task to run on the CPU, ext =
core
> @@ -104,7 +104,7 @@ enum scx_ops_flags {
>          * flag is specified, such tasks are passed to ops.enqueue() with
>          * %SCX_ENQ_LAST. See the comment above %SCX_ENQ_LAST for more in=
fo.
>          */
> -       SCX_OPS_ENQ_LAST        =3D 1LLU << 1,
> +       SCX_OPS_ENQ_LAST                =3D 1LLU << 1,
>
>         /*
>          * An exiting task may schedule after PF_EXITING is set. In such =
cases,
> @@ -117,13 +117,13 @@ enum scx_ops_flags {
>          * depend on pid lookups and wants to handle these tasks directly=
, the
>          * following flag can be used.
>          */
> -       SCX_OPS_ENQ_EXITING     =3D 1LLU << 2,
> +       SCX_OPS_ENQ_EXITING             =3D 1LLU << 2,
>
>         /*
>          * If set, only tasks with policy set to SCHED_EXT are attached t=
o
>          * sched_ext. If clear, SCHED_NORMAL tasks are also included.
>          */
> -       SCX_OPS_SWITCH_PARTIAL  =3D 1LLU << 3,
> +       SCX_OPS_SWITCH_PARTIAL          =3D 1LLU << 3,
>
>         /*
>          * A migration disabled task can only execute on its current CPU.=
 By
> @@ -136,7 +136,21 @@ enum scx_ops_flags {
>          * current CPU while p->nr_cpus_allowed keeps tracking p->user_cp=
us_ptr
>          * and thus may disagree with cpumask_weight(p->cpus_ptr).
>          */
> -       SCX_OPS_ENQ_MIGRATION_DISABLED =3D 1LLU << 4,
> +       SCX_OPS_ENQ_MIGRATION_DISABLED  =3D 1LLU << 4,
> +
> +       /*
> +        * Queued wakeup (ttwu_queue) is an optimization during wakeups w=
hich
> +        * bypasses ops.select_cpu() and invokes ops.enqueue() on the wak=
ee's
> +        * previous CPU via IPI (inter-processor interrupt) to reduce cac=
heline
> +        * transfers. As the BPF scheduler may depend on ops.select_cpu()=
 being
> +        * invoked during wakeups, queued wakeup is disabled by default.
> +        *
> +        * If this ops flag is set, queued wakeup optimization is enabled=
 and
> +        * the BPF scheduler must be able to handle ops.enqueue() invoked=
 on the
> +        * wakee's CPU without preceding ops.select_cpu() even for tasks =
which
> +        * may be executed on multiple CPUs.
> +        */
> +       SCX_OPS_ALLOW_QUEUED_WAKEUP     =3D 1LLU << 5,
>
>         /*
>          * CPU cgroup support flags
> @@ -147,6 +161,7 @@ enum scx_ops_flags {
>                                   SCX_OPS_ENQ_LAST |
>                                   SCX_OPS_ENQ_EXITING |
>                                   SCX_OPS_ENQ_MIGRATION_DISABLED |
> +                                 SCX_OPS_ALLOW_QUEUED_WAKEUP |
>                                   SCX_OPS_SWITCH_PARTIAL |
>                                   SCX_OPS_HAS_CGROUP_WEIGHT,
>  };
> @@ -897,6 +912,7 @@ DEFINE_STATIC_KEY_FALSE(__scx_switched_a
>  static struct sched_ext_ops scx_ops;
>  static bool scx_warned_zero_slice;
>
> +DEFINE_STATIC_KEY_FALSE(scx_ops_allow_queued_wakeup);
>  static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_last);
>  static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_exiting);
>  static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_migration_disabled);
> @@ -4717,6 +4733,7 @@ static void scx_ops_disable_workfn(struc
>         static_branch_disable(&__scx_ops_enabled);
>         for (i =3D SCX_OPI_BEGIN; i < SCX_OPI_END; i++)
>                 static_branch_disable(&scx_has_op[i]);
> +       static_branch_disable(&scx_ops_allow_queued_wakeup);
>         static_branch_disable(&scx_ops_enq_last);
>         static_branch_disable(&scx_ops_enq_exiting);
>         static_branch_disable(&scx_ops_enq_migration_disabled);
> @@ -5348,9 +5365,10 @@ static int scx_ops_enable(struct sched_e
>                 if (((void (**)(void))ops)[i])
>                         static_branch_enable(&scx_has_op[i]);
>
> +       if (ops->flags & SCX_OPS_ALLOW_QUEUED_WAKEUP)
> +               static_branch_enable(&scx_ops_allow_queued_wakeup);
>         if (ops->flags & SCX_OPS_ENQ_LAST)
>                 static_branch_enable(&scx_ops_enq_last);
> -
>         if (ops->flags & SCX_OPS_ENQ_EXITING)
>                 static_branch_enable(&scx_ops_enq_exiting);
>         if (ops->flags & SCX_OPS_ENQ_MIGRATION_DISABLED)
> --- a/kernel/sched/ext.h
> +++ b/kernel/sched/ext.h
> @@ -8,6 +8,8 @@
>   */
>  #ifdef CONFIG_SCHED_CLASS_EXT
>
> +DECLARE_STATIC_KEY_FALSE(scx_ops_allow_queued_wakeup);
> +
>  void scx_tick(struct rq *rq);
>  void init_scx_entity(struct sched_ext_entity *scx);
>  void scx_pre_fork(struct task_struct *p);
> @@ -34,6 +36,13 @@ static inline bool task_on_scx(const str
>         return scx_enabled() && p->sched_class =3D=3D &ext_sched_class;
>  }
>
> +static inline bool scx_allow_ttwu_queue(const struct task_struct *p)
> +{
> +       return !scx_enabled() ||
> +               static_branch_likely(&scx_ops_allow_queued_wakeup) ||
> +               p->sched_class !=3D &ext_sched_class;
> +}
> +
>  #ifdef CONFIG_SCHED_CORE
>  bool scx_prio_less(const struct task_struct *a, const struct task_struct=
 *b,
>                    bool in_fi);
> @@ -52,6 +61,7 @@ static inline void scx_rq_activate(struc
>  static inline void scx_rq_deactivate(struct rq *rq) {}
>  static inline int scx_check_setscheduler(struct task_struct *p, int poli=
cy) { return 0; }
>  static inline bool task_on_scx(const struct task_struct *p) { return fal=
se; }
> +static inline bool scx_allow_ttwu_queue(const struct task_struct *p) { r=
eturn true; }
>  static inline void init_sched_ext_class(void) {}
>
>  #endif /* CONFIG_SCHED_CLASS_EXT */

