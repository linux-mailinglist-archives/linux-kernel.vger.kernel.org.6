Return-Path: <linux-kernel+bounces-448626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0082C9F4319
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECDE188C901
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 05:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1208B155C9E;
	Tue, 17 Dec 2024 05:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="husBgj6e"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9393114D456
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 05:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734414167; cv=none; b=Jqcs82p5nttq4a3B/5VpuvjnF+OKYiPKlzr/45wbqhIRbxdnXgFky3bLGs/Nev396I9dfSC762aVt6ayUTouHeij7Ru8G5cwZ8531chZuF3S0aU09tkgc3/R3QlfkMZ/BT36UA/oDZzKJjTi/NLqN5a3Nd3T0AxLqGmBJhbTRsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734414167; c=relaxed/simple;
	bh=zDfeMhxQClLHlRKNg0xWcox9GYazka1dScf3t1EIuj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moyaVczOqozXmQKbD22xIymV3XUB0nzB/UKUfZej0dxMqWhjjIMbg2Sczf3auxuihOfVbNL+7z7pwihc00ocWCEKDMkSxcqYtFKBD6iOAQUFO7TZ3n3UGnmjLVdmGwkSnYaaMNEkE1IwqxHI9mUNymYxmskLfRw1BTB98Ze1xDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=husBgj6e; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso744527266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 21:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734414164; x=1735018964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RHo1jtSk4Mm2ImsZhCHdjVBF5TTUFkPvcVLGKrrVN8=;
        b=husBgj6e0s0ygz1IL38n4u6zM1dR/BeYSsYSCb6hl4MVExOHtXZ4DGk2aD0nbDcFVp
         2iG1UCO6+c+gBigsz4+cE7dNL8miGoB9eUgbLHrwXzHvoqwi7e4ddJ7dsq+jzz3RLcWX
         05nRXG2jVb3fozj6DO9A/I6sA8PSDR2QnyCw41tSPvQTZQru9gTKan+E0GA7vI4DwdXC
         laQ483YuLDox8gZ6JBuZXBTfezmybJQD7K0dF2hVUUiN/bdaePUJNS16MxoCajaCfmhP
         +pPEejkpUSx9pzgtqKhDdjgIOtiiMk2FXX3N2yVQI3ymVAuFfhUdHn7vxS6DcFqj5/kv
         cifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734414164; x=1735018964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RHo1jtSk4Mm2ImsZhCHdjVBF5TTUFkPvcVLGKrrVN8=;
        b=t2RM/hD319kp8KdPvtrVyhoetRjorsjBFMrBJfGg84y+BqcW+8XSgn5qzutVX9mv8c
         LCeqyg9epX9kICpSlkyQ1V+JDICBM1Hk0XOxqH1gTgiJJtWQk/pHDNwpZ0HZVICSLGFw
         5fRTNziaG5YsS5af3MYB+ltUw5BERaTHaRZqulidh13jiRO+bH/JT9uXJA2dqhvprvBJ
         9bx8mPgcu3+79Hl0NihFC2A/uss8//6h3pqgHEkS42kfcN4KpTts6ixHE/MkAkvT1YoG
         gUkofsDzcHEc9kibHaAB10hZD+oLM2b1qqSOWjAXVYxwFSL9LebsUYo8F9BkNQykWY2H
         0ljQ==
X-Gm-Message-State: AOJu0YyYuvRBFIOIsDc4tVnSMhZHdCYbcbKBQzd9oZOjBNIf2r8FYE2r
	UjHF+4+hRoVcVU/xwbl+0fiim57Oa1KgPrXLaSuARWCZVPYAMnanNeC26L4ETZBD/fgp2058JC/
	cY2EaiGbn//Q1Z5lh0Yncn8YumMhwiouCdeY=
X-Gm-Gg: ASbGncvDlZ7vRvv9tcnahYf2964kRoA8iWMzdW3NXb7MV//e6jtSogMderiMdyCB7CI
	1ca8quuFnA6WjDZLfQWiQmIo4OzFC4xN9nC659k2bKe5SsdDWdEsDWmGjwhF8dtNOtc0=
X-Google-Smtp-Source: AGHT+IGH9WTQm0PuV21F/NU+4B/x2Bn3wqP71IKCOkyPuG0oTNFDOVfsNIexhUBrVVRsZz6POhzwWn7pHPx4GOT8hHI=
X-Received: by 2002:a17:907:2da0:b0:aa6:9176:61ed with SMTP id
 a640c23a62f3a-aab77ea6187mr1387926466b.48.1734414163675; Mon, 16 Dec 2024
 21:42:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125195204.2374458-1-jstultz@google.com> <20241125195204.2374458-6-jstultz@google.com>
 <20241214000559.GC17501@noisy.programming.kicks-ass.net>
In-Reply-To: <20241214000559.GC17501@noisy.programming.kicks-ass.net>
From: John Stultz <jstultz@google.com>
Date: Mon, 16 Dec 2024 21:42:31 -0800
X-Gm-Features: AbW1kvakRXnldIu3hG10v6VrndWiuit2lHbunPb9uBZ1F7g12qIFVUEw4Fdis6M
Message-ID: <CANDhNCpYgQ6KspsykWhewNAm1N1mPSh=hthx2OnisX3c+7M0ng@mail.gmail.com>
Subject: Re: [RFC][PATCH v14 5/7] sched: Add an initial sketch of the
 find_proxy_task() function
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 4:06=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Nov 25, 2024 at 11:51:59AM -0800, John Stultz wrote:
>
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index f8714050b6d0d..b492506d33415 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -5052,6 +5052,34 @@ static void do_balance_callbacks(struct rq *rq, =
struct balance_callback *head)
> >       }
> >  }
> >
> > +/*
> > + * Only called from __schedule context
> > + *
> > + * There are some cases where we are going to re-do the action
> > + * that added the balance callbacks. We may not be in a state
> > + * where we can run them, so just zap them so they can be
> > + * properly re-added on the next time around. This is similar
> > + * handling to running the callbacks, except we just don't call
> > + * them.
> > + */
>
> Which specific callbacks are this? sched_core_balance()?
>
> In general, shooting down all callbacks like this makes me feel somewhat
> uncomfortable.

So, if we originally picked a RT task, I believe it would setup the
push_rt_tasks callback, but if it got migrated and if we needed to
pick again,  we'd end up tripping on
`SCHED_WARN_ON(rq->balance_callback && rq->balance_callback !=3D
&balance_push_callback);`

For a while I tried to unpin and run the balance callbacks before
calling pick_again, if find_proxy_task() failed, but that was running
into troubles with tasks getting unintentionally added to the rt
pushable list (this was back in ~feb, so my memory is a little fuzzy).

So that's when I figured zaping the callbacks would be best, with the
idea being that we are starting selection over, so we effectively have
to undo any of the state that was set by pick_next_task() before
calling it again.

Let me know if you have concerns with this, or suggestions for other approa=
ches.

> > +/*
> > + * Initial simple proxy that just returns the task if it's waking
> > + * or deactivates the blocked task so we can pick something that
> > + * isn't blocked.
> > + */
> > +static struct task_struct *
> > +find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_fl=
ags *rf)
> > +{
> > +     struct task_struct *p =3D donor;
> > +     struct mutex *mutex;
> > +
> > +     mutex =3D p->blocked_on;
> > +     /* Something changed in the chain, so pick again */
> > +     if (!mutex)
> > +             return NULL;
> > +     /*
> > +      * By taking mutex->wait_lock we hold off concurrent mutex_unlock=
()
> > +      * and ensure @owner sticks around.
> > +      */
> > +     raw_spin_lock(&mutex->wait_lock);
> > +     raw_spin_lock(&p->blocked_lock);
>
> I'm still wondering what this blocked_lock does, that previous patch had
> it mirror wait_mutex too, so far I don't see the point.

Yeah, early on in the series it's maybe not as useful, but as we start
dealing with sleeping owner enqueuing, its doing more:
  https://github.com/johnstultz-work/linux-dev/commit/d594ca8df88645aa3b2b9=
daa105664893818bdb7

But it is possible it is more of a crutch for me to keep straight the
locking rules as it's simpler to keep in my head. :)
Happy to think a bit more on if it can be folded together with another lock=
.

Thanks again for the review and thoughts here!

thanks
-john

