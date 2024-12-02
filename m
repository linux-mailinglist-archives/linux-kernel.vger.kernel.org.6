Return-Path: <linux-kernel+bounces-428248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C36F9E0BDE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE028282402
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A1C1DE3A7;
	Mon,  2 Dec 2024 19:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jobyaviation.com header.i=@jobyaviation.com header.b="CK24D814"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA431DACA7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733167019; cv=none; b=EfuFUtXxZ7MaEQCgv/FUlpJqXVTbQb1UovlulWSA0+To/l9AgpvZT9GR+5J0h02IeNBhZSCtxI4ujGomHOB2/wp55GCAtWmgd/0sJooGcP1WBHqQdxUWbK5JpqR8okazWbtlFWK2+i9CInwA4glwqzMSkRVvlZevv5A2ozhblxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733167019; c=relaxed/simple;
	bh=Nckuv6hATlKq/HtY/KkK+SWSCjWapfTxPZWs7KJuGkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkmvC38SF4+2klHeYcvbTpdCqSFdfR2K2lduYwZMOTtF6e3M21SHwYRNXXRPCzv6HLH79AO9K3he/H9pdulklnuMw7E/9Al0ugEJM9cgE2xlaFF+MvI4UUmeWFRaJ1cEHBt6beNpzXCSi5exBa52IHNmhZkTP1QPJ6GiA7ykVzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jobyaviation.com; spf=pass smtp.mailfrom=jobyaviation.com; dkim=pass (2048-bit key) header.d=jobyaviation.com header.i=@jobyaviation.com header.b=CK24D814; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jobyaviation.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jobyaviation.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-215b0582aaeso5257585ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 11:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jobyaviation.com; s=google; t=1733167017; x=1733771817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q57ivaqtZdXHj40aGMomGBPEpCPwm3IGe0CZcucTxLY=;
        b=CK24D814iHUV2Irs7p1FZs2dIU6BBsY5GGruF1eeiv7v4XoctdYAajgyY36FmjCbWY
         nAzrE0sC28dMq16RUvULvQHo1YCwHxJAPsrwfPJ1TLbNE/5whzaCTIJvfdyx8dCprQXG
         oRuTJ+2K+wV6zxBBhYckFQrcC0lL4VhfzgDo9Od04iaiFYUXJPlSZsJwpnu1Lkoi+Fhn
         V2jXgsdJF7t5EJEMJQOWl+DjlTfY5SRAZKEBBJ6U8mgmELoaXzdi0QWKAg1g5shl8/dQ
         sbz2BOKihj+tQU6GxkznEBDAe0aSPAh8m2GaiKt9L0QTO9f6mfHMvUKHDumSWW/tw50I
         UZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733167017; x=1733771817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q57ivaqtZdXHj40aGMomGBPEpCPwm3IGe0CZcucTxLY=;
        b=D+QM8wo0J8eiWy9Cj6/Px/BfXV7Zah8ytzu0IunAJ/iG3zbSxpdniU2O0Zr0Uj7fro
         11+BBMRmZQhA4GsbqBJ/78xZ8cMC/UpVDXHTD1Wx8XtK3o/BC8bk1zGaOey2/n88+9Hh
         DTrrLKaOUrykQY6YfxSqPkcY13g6ayrsFs9NZgSDPhvH6t9uepFcfw+4pMxnsXIBXyUc
         vclho58+LRSES76f9Jj3IC0UXM+3GKPuEjig1ICn0qmx2/ZioZL/wvG5ABsRzR2zovEr
         e4DYi9OcjFQQXOhV7Nhkb9+gIi3+Aa6DkKUVWk4MuO5G7L5z3T40oH0tiH9hJRBcj5j+
         MWdw==
X-Forwarded-Encrypted: i=1; AJvYcCUngBc87if1XNuRiRX0tPI3PxkxhgtXAH0GeMgkOg09OeOvf0jsxwRFknt9OBfT7o8o5hV+h6SWIXBN1Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvd0sGqGkuOMh0a4UI7sxzdM0iFybrTf3ETIUTm6lrqfeMOqMm
	eHIbw+piAOF0VxuJlvHovg/f4ibDP7gx/9oOJu1/sRNT7BVFv4s/cn48hwN2NJ2B0EEQ9C5OlCv
	N8q8R5hUdhR41ORv4X60/GbS6XaZS8+x5z6UQIP2eMl7tszDkqwC7WMYTw9HE5Wj07dQJmhuXJr
	kQfTXZT2yJD7TGyB1lXzi3vs00OV7u
X-Gm-Gg: ASbGnct1pc+RKeJ3EfezbGvoRBqF+kMs+bZ8BxB+gMd84wuUPui7d827eoYOdFeCZTT
	VHuvddQ06o5ic/ouWu4amKXm0Eg5sdV0=
X-Google-Smtp-Source: AGHT+IHXotag8OVIec9YbcZNOA+aqWmJHuTbf5Gno47rTJ7wBXw87VnjsKFCUe/ii6Z7EB1DHUsNyPY2dtKxY2SeVVI=
X-Received: by 2002:a17:902:e881:b0:215:7287:67c2 with SMTP id
 d9443c01a7336-21572876c74mr128108905ad.42.1733167017210; Mon, 02 Dec 2024
 11:16:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACodVevaOp4f=Gg467_m-FAdQFceGQYr7_Ahtt6CfpDVQhAsjA@mail.gmail.com>
 <20241120090354.GE19989@noisy.programming.kicks-ass.net> <xhsmhzflkmvt0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmhzflkmvt0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Chenbo Lu <chenbo.lu@jobyaviation.com>
Date: Mon, 2 Dec 2024 11:16:45 -0800
Message-ID: <CACodVet-QpGeixsYdDnRbZdzd1ScGHxPaFUjzBpXW9upZxZzfg@mail.gmail.com>
Subject: Re: Performance Degradation After Upgrading to Kernel 6.8
To: Valentin Schneider <vschneid@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org, 
	regressions@lists.linux.dev, mingo@redhat.com, juri.lelli@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Valentin,
Thanks for the reply. I tried the patch, but it does not bring back
the performance (the average execution time is 6.15ms).

On Wed, Nov 27, 2024 at 9:27=E2=80=AFAM Valentin Schneider <vschneid@redhat=
.com> wrote:
>
> Damn, I wrote a reply on the 20th but seems like I never sent it. At leas=
t
> I found it saved somewhere, so I don't have to rewrite it...
>
> On 20/11/24 10:03, Peter Zijlstra wrote:
> > On Tue, Nov 19, 2024 at 04:30:02PM -0800, Chenbo Lu wrote:
> >> Hello,
> >>
> >> I am experiencing a significant performance degradation after
> >> upgrading my kernel from version 6.6 to 6.8 and would appreciate any
> >> insights or suggestions.
> >>
> >> I am running a high-load simulation system that spawns more than 1000
> >> threads and the overall CPU usage is 30%+ . Most of the threads are
> >> using real-time
> >> scheduling (SCHED_RR), and the threads of a model are using
> >> SCHED_DEADLINE. After upgrading the kernel, I noticed that the
> >> execution time of my model has increased from 4.5ms to 6ms.
> >>
> >> What I Have Done So Far:
> >> 1. I found this [bug
> >> report](https://bugzilla.kernel.org/show_bug.cgi?id=3D219366#c7) and
> >> reverted the commit efa7df3e3bb5da8e6abbe37727417f32a37fba47 mentioned
> >> in the post. Unfortunately, this did not resolve the issue.
> >> 2. I performed a git bisect and found that after these two commits
> >> related to scheduling (RT and deadline) were merged, the problem
> >> happened. They are 612f769edd06a6e42f7cd72425488e68ddaeef0a,
> >> 5fe7765997b139e2d922b58359dea181efe618f9
> >
> > And yet you failed to Cc Valentin, the author of said commits :/
> >
> >> After reverting these two commits, the model execution time improved
> >> to around 5 ms.
> >> 3. I revert two more commits, and the execution time is back to 4.7ms:
> >> 63ba8422f876e32ee564ea95da9a7313b13ff0a1,
> >> efa7df3e3bb5da8e6abbe37727417f32a37fba47
> >>
> >> My questions are:
> >> 1.Has anyone else experienced similar performance degradation after
> >> upgrading to kernel 6.8?
> >
> > This is 4 kernel releases back, I my memory isn't that long.
> >
> >> 2.Can anyone explain why these two commits are causing the problem? I
> >> am not very familiar with the kernel code and would appreciate any
> >> insights.
> >
> > There might be a race window between setting the tro and sending the
> > IPI, such that previously the extra IPIs would sooner find the newly
> > pushable task.
> >
> > Valentin, would it make sense to set tro before enqueueing the pushable=
,
> > instead of after it?
>
> Urgh, those cachelines are beyond cold...
>
> /me goes reading
>
> Ok yeah I guess we could have this race vs
>
> rto_push_irq_work_func()
> `\
>   rto_next_cpu()
>
> Not sure if that applies to DL too since it doesn't have the PUSH_IPI
> thing, but anyway - Chenbo, could you please try the below?
> ---
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d9d5a702f1a61..270a25335c4bc 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -602,16 +602,16 @@ static void enqueue_pushable_dl_task(struct rq *rq,=
 struct task_struct *p)
>
>         WARN_ON_ONCE(!RB_EMPTY_NODE(&p->pushable_dl_tasks));
>
> +       if (!rq->dl.overloaded) {
> +               dl_set_overload(rq);
> +               rq->dl.overloaded =3D 1;
> +       }
> +
>         leftmost =3D rb_add_cached(&p->pushable_dl_tasks,
>                                  &rq->dl.pushable_dl_tasks_root,
>                                  __pushable_less);
>         if (leftmost)
>                 rq->dl.earliest_dl.next =3D p->dl.deadline;
> -
> -       if (!rq->dl.overloaded) {
> -               dl_set_overload(rq);
> -               rq->dl.overloaded =3D 1;
> -       }
>  }
>
>  static void dequeue_pushable_dl_task(struct rq *rq, struct task_struct *=
p)
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index bd66a46b06aca..1ea45a45ed657 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -385,6 +385,15 @@ static inline void rt_queue_pull_task(struct rq *rq)
>
>  static void enqueue_pushable_task(struct rq *rq, struct task_struct *p)
>  {
> +       /*
> +        * Set RTO first so rto_push_irq_work_func() can see @rq as a pus=
h
> +        * candidate as early as possible.
> +        */
> +       if (!rq->rt.overloaded) {
> +               rt_set_overload(rq);
> +               rq->rt.overloaded =3D 1;
> +       }
> +
>         plist_del(&p->pushable_tasks, &rq->rt.pushable_tasks);
>         plist_node_init(&p->pushable_tasks, p->prio);
>         plist_add(&p->pushable_tasks, &rq->rt.pushable_tasks);
> @@ -392,15 +401,15 @@ static void enqueue_pushable_task(struct rq *rq, st=
ruct task_struct *p)
>         /* Update the highest prio pushable task */
>         if (p->prio < rq->rt.highest_prio.next)
>                 rq->rt.highest_prio.next =3D p->prio;
> -
> -       if (!rq->rt.overloaded) {
> -               rt_set_overload(rq);
> -               rq->rt.overloaded =3D 1;
> -       }
>  }
>
>  static void dequeue_pushable_task(struct rq *rq, struct task_struct *p)
>  {
> +       /*
> +        * To match enqueue we should check/unset RTO first, but for that=
 we
> +        * need to pop @p first. This makes this asymmetric wrt enqueue, =
but
> +        * the worst we can get out of this is an extra useless IPI.
> +        */
>         plist_del(&p->pushable_tasks, &rq->rt.pushable_tasks);
>
>         /* Update the new highest prio pushable task */
>

--=20
This email and any relevant attachments may include confidential and/or=20
proprietary information.=C2=A0 Any distribution or use by anyone other than=
 the=20
intended recipient(s) or other than for the intended purpose(s) is=20
prohibited and may be unlawful.=C2=A0 If you are not the intended recipient=
 of=20
this message, please notify the sender by replying to this message and then=
=20
delete it from your system.

