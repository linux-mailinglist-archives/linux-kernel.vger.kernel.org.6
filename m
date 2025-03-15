Return-Path: <linux-kernel+bounces-562410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95418A6265B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 06:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB753B78FD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 05:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1B718DF81;
	Sat, 15 Mar 2025 05:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qwDgo2KF"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66062E3387
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 05:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742015419; cv=none; b=qGVz8QwcbKQOktP96ESRl1P4lua6cmf5jmNht+vJ6Pj+hjVTP2GiNJvfnWZ1T+uM6Cc7WGTyPxJUJJFwK2L9mvnNdsxPsIzanCNiKkksnnaBo1iXB5nZKO26RABguiTURW6WjgWaMRWyNitkh0saEL+KzR86B+mjxogsnoTM9BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742015419; c=relaxed/simple;
	bh=k+Bt+k0/BHzLVg5JFkRIkBjfl2c6+AU0K1DPtFme5Kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d52/5ASAlQh4Rz4q95gH2YTvtxVrbbq/PJ+q6cWkn/nYvkzOEp1VKVxSwpafeZZd7H58wCnkVFkQOEW2MIpY5xPfQQjK7S4llr1ohBrjzkxAw9SVUtklXrVcuXv+q9Z/sTfufcESkiXxpI71Igd3F2+vmXPeNl3Hi1XUd3q7BYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qwDgo2KF; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5499614d3d2so2880219e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 22:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742015415; x=1742620215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGPXaqFTefv/Hn4UDPwMpRlXpkb+LLM3INGf+5EorVU=;
        b=qwDgo2KFSkgt3L4xybU0UEHdLeW5vbaw9vC6I6V0zVUmaRSCe+rcKI7zSE7zx67z5s
         Rbj0pZtTwdrpvJX3lrhxVfVa1xgg4i5BW1L4a02YiApFvkgBUbRlS/kGUG6kj3VGM0qd
         5aWYd9v30Xo+ZjmrqYzL7yR6M3FvdhODuDFKApBbm5gGCCMXeeUi4M/nbQVPZLkjOKDM
         IWUTC6p2nc6NyauGunSHefcWoJ8JMzCrJ3LxpbFdF2oUHEtwlqzVndYvOhH9XEfNfzSJ
         5OvwNO1aLSzHzQeXAovxU3ciZbxEsMtUHGRh8sYwf1kV7hJTs9+8heVrg1qInuxtAkdr
         jTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742015415; x=1742620215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGPXaqFTefv/Hn4UDPwMpRlXpkb+LLM3INGf+5EorVU=;
        b=C1ofullKY8DtKZ+ao8z9uQ+4THTs0vFICb8WxZwVxvkK865F0l+45vUMyzt7RkFhLs
         zJprH64fwTB8HPeHMTaxE03GLlf0XqvS+pNXwp1osRmYYtcYOB9JVbK+wlopJzVKI/Cp
         jI4o9NZGdsGAJHoA7ks5RpxNPisxTdYdY0OCI7c9gGgGFvIqh1TgVArr4bCVhuGIVCOl
         JvY3oc7ejk254tvNXmBSa7uPxOhG+RJ7VcyNskKBwFC3oLS40T19WEriBHeA/IbJMtR1
         BkRslwnUqTdQlZgmkEZdH82+Coq6cLk7t9a4GG2rkoJGejasqvP1k3VPxkrsgTv/KwTB
         MyVg==
X-Gm-Message-State: AOJu0YzKQBBggUclclfu4wpLP9WB+yYKPFoXDedatVt4Wsw0Lrh+TuLx
	AgbDVDPsDrm1EZs8IDtUB3axLuw8meo/G3ALJn9uemPUDN3pVWJI1Iu60KY8Cp9BnLqj5YATxAX
	1RZT2uej11NkBZBwPpeS8ZQch6nmqfdI4KJw=
X-Gm-Gg: ASbGncv/m1Etm2sdX60P7vd5MDCsJrHyv6UNiJfTXLtvxEIHcd7ruSLEYuz26tHhEum
	BhTME+qCoXlyg8sHEnT2fZXK6XI1dTgvr3rbpv+dOwUx7jFIGbtclYeISueC8INPo6QaV4UUFNf
	LycpNXv2xGj7VPNMMA8xdk5Tq4M127xJUmdqaWsXi1k9+NKp4XpLh2gTtTLs/FXJy+
X-Google-Smtp-Source: AGHT+IHAuiaA4rjsx6l9MCL+KTh4C9tNoBSB4RZ7x654nukzK9Rph9OPplTli0VYagIzjVpKPiJg1yvcwutFt6ehIoA=
X-Received: by 2002:a05:6512:31cc:b0:549:7145:5d28 with SMTP id
 2adb3069b0e04-549c3914159mr1513563e87.25.1742015414467; Fri, 14 Mar 2025
 22:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312221147.1865364-1-jstultz@google.com> <20250312221147.1865364-7-jstultz@google.com>
 <931db71f-a13c-48ab-a315-f04d671bdddb@amd.com>
In-Reply-To: <931db71f-a13c-48ab-a315-f04d671bdddb@amd.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 14 Mar 2025 22:10:00 -0700
X-Gm-Features: AQ5f1JpfL2sDeW1DtZNCdg26iUM90c2wUFNH6uDr83JMVri81JDlZJWuCLXMlhw
Message-ID: <CANDhNCr24WBBhvSQQEmgL8EmC8e9og_LQ8=EEE5DXtY6Twth0A@mail.gmail.com>
Subject: Re: [RFC PATCH v15 6/7] sched: Fix proxy/current (push,pull)ability
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Valentin Schneider <valentin.schneider@arm.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com, 
	"Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 1:40=E2=80=AFAM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
> On 3/13/2025 3:41 AM, John Stultz wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index b4f7b14f62a24..3596244f613f8 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6722,6 +6722,23 @@ find_proxy_task(struct rq *rq, struct task_struc=
t *donor, struct rq_flags *rf)
> >   }
> >   #endif /* SCHED_PROXY_EXEC */
> >
> > +static inline void proxy_tag_curr(struct rq *rq, struct task_struct *o=
wner)
> > +{
> > +     if (!sched_proxy_exec())
> > +             return;
> > +     /*
> > +      * pick_next_task() calls set_next_task() on the chosen task
> > +      * at some point, which ensures it is not push/pullable.
> > +      * However, the chosen/donor task *and* the mutex owner form an
> > +      * atomic pair wrt push/pull.
> > +      *
> > +      * Make sure owner we run is not pushable. Unfortunately we can
> > +      * only deal with that by means of a dequeue/enqueue cycle. :-/
> > +      */
> > +     dequeue_task(rq, owner, DEQUEUE_NOCLOCK | DEQUEUE_SAVE);
> > +     enqueue_task(rq, owner, ENQUEUE_NOCLOCK | ENQUEUE_RESTORE);
> > +}
> > +
> >   /*
> >    * __schedule() is the main scheduler function.
> >    *
> > @@ -6856,6 +6873,10 @@ static void __sched notrace __schedule(int sched=
_mode)
> >                * changes to task_struct made by pick_next_task().
> >                */
> >               RCU_INIT_POINTER(rq->curr, next);
> > +
> > +             if (!task_current_donor(rq, next))
> > +                     proxy_tag_curr(rq, next);
>
> I don't see any dependency on rq->curr for task_current_donor() check.
> Could this check be moved outside of the if-else block to avoid
> duplicating in both places since rq_set_donor() was called just after
> pick_next_task() or am I missing something?

So this check is just looking to see if next is the same as the
selected rq->donor (what pick_next_task() chose).

If so, nothing to do, same as always.

But If not (so we are proxying in this case), we need to call
proxy_tag_curr() because we have to make sure both the donor and the
proxy are not on a sched-classes pushable list.

This is because the logic around pick_next_task() calls
set_next_task() on the returned donor task, and in the sched-class
code, (for example RT) that logic will remove the chosen donor task
from the pushable list.

But when we find a proxy task to run on behalf of the donor, the
problem is that the proxy might be on the sched-class' pushable list.
So if we are proxying, we do a dequeue and enqueue pair, which allows
us to re-evaluate if the task is rq->curr, which will prevent it from
being added to any such pushable list.   This avoids the potential of
the balance callbacks trying to migrate the rq->curr under us.

Thanks so much for the review and the question! Let me know if that
makes any more sense, or if you have suggestions on how I could better
explain it in the commit message to help.

Appreciate it!
-john

