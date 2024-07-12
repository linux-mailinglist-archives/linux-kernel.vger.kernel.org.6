Return-Path: <linux-kernel+bounces-251143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6AF930120
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 21:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44091F2372A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0273A8C0;
	Fri, 12 Jul 2024 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zh4xxaN0"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2035744C86
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720814033; cv=none; b=qS/KButKK7GBOHz2DjSZN21r8hjw68i02EhBjRah+nm7v2qVfr8E5XYPf8xe0brQ7KAxFitb4IEJbstJlEmkRqzhC5InxnxqTgqt3p8QtzqV3QPBbH8qstrIcJHEZWeAP+U+Qj86Jyrlbqwk7vI4iAZcFsxbzY8hv271yGmEnSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720814033; c=relaxed/simple;
	bh=0iJLLgIAj1GDbOz5eCaLhDF160omVeDVbc9/Ai6siRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7Zy0TC2vigngvyyUTTl+0Rw7riHpT45+V1ThW+fCGPbc89y4CoNYgsK68xYXGxB8Q18MY4dkfixnJl8EwdC99Z/cZ0BJ5ZSQX1A7MiBnoip5RuWwbgOSKBEOGJ4xfkvBTSmFGmuH5UziZdzhPKrSXe6vi1pH3YoT0+exl7D8W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zh4xxaN0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4266f796e67so315e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 12:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720814030; x=1721418830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXUjyIfuqHSmLdUVCSqOhZ01RJJ/uPsJn5yQv7GDqYE=;
        b=zh4xxaN00FH4YBs3uTOx5QmT0xIiP7pJ3YQf6ruo5c0Do5V0QkMhQqdiaHJkiIMIYP
         htq3Kcm8eJdiP4wjR9mqRGg/UAe+nlE980cCFjZL05Q0XfUntsUZSIXN7s3hP38/iN6O
         TuhQp1Ighflp94zgPz3xCktPhuLp7WmMbyqEXHII/Kkq4PU5RVTTP3gOy65V3GGonPb/
         i+E5oJHO5X1qjOQss77gp/yLtGD0n/onGS9XZd/9rOK+V/sAQjqnwySl7jw+McQjmzct
         nMN1ZdGaKtE2ugffTYQxaazyvEJ+qlgMuCHcGtRP88pfAK3rYdxKItJcUFFyI7cfCMQA
         m7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720814030; x=1721418830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXUjyIfuqHSmLdUVCSqOhZ01RJJ/uPsJn5yQv7GDqYE=;
        b=rKPlZxHajW4dK18ANcfUKcVLrMoVRbZF3W1eZA+qdhn/jOXhSKKc0S27PCTIEivQHS
         Gt8buorhYEGl4gUClTYTv1ORUpoyCZFY4Y7qSwRLU1uXF5B0DvIAI1CRQpERxUMte7Gb
         pnSQlOFkoQH1LQte+5mUONMGWS37yY6V/dorvJXkoKmY+h0gH4aketoepPYztudcOBGH
         kXEeTLFUGXFYnC0WD9DyCXWmk8DhKxFtVu0Fi2YOH4O9IoUgRV2w1HJumY1YfOVoDyqV
         D4gtISsSBZEpWerMeFUjUP0EcXeu2NU/aSouGBGrk9/ABnTEk3JmYEtN+8U9hFLBLK8k
         r83Q==
X-Gm-Message-State: AOJu0Yxv8XfQYBTTuTyviC3CeXE0ee/Slti2WiWoH78ZqHwK3Tf7YkqM
	VYd35P70b+SzExaWTsTvUq34AiOl04IrUpXMPmEyfwbYqsn6F1HPfCGiwXc4VQxaMvQe0+3uIzY
	4Wam7dtXjhjw1aLS7OxIYCqE1EpoHItxff3U=
X-Google-Smtp-Source: AGHT+IHs0Yu7EKzUkZS/fdsAekQWWCBELn3tw56//UTXPfClEaUH8zP+oxxwG6i4xBoUHnPH8okJlX/l0yXdvQ5x4zw=
X-Received: by 2002:a05:600c:3b0c:b0:426:6e95:6ea7 with SMTP id
 5b1f17b1804b1-427a42796a7mr357145e9.0.1720814030266; Fri, 12 Jul 2024
 12:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709203213.799070-1-jstultz@google.com> <20240709203213.799070-2-jstultz@google.com>
 <d293d88c-b83b-a955-de5e-db775f20c1e1@amd.com>
In-Reply-To: <d293d88c-b83b-a955-de5e-db775f20c1e1@amd.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 12 Jul 2024 12:53:38 -0700
Message-ID: <CANDhNCoTnsUXU9iHj=gW9fhSZs4BZs8UVdQck_N=3-M-NHDdbg@mail.gmail.com>
Subject: Re: [PATCH v11 1/7] locking/mutex: Remove wakeups from under mutex::wait_lock
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat <youssefesmat@google.com>, 
	Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 10:42=E2=80=AFAM 'K Prateek Nayak' via kernel-team
<kernel-team@android.com> wrote:
> On 7/10/2024 2:01 AM, John Stultz wrote:
> > @@ -681,6 +682,11 @@ __mutex_lock_common(struct mutex *lock, unsigned i=
nt state, unsigned int subclas
> >               }
> >
> >               raw_spin_unlock(&lock->wait_lock);
> > +             /* Make sure we do wakeups before calling schedule */
> > +             if (!wake_q_empty(&wake_q)) {
>
> nit.
>
> This checks seems unnecessary (to my untrained eye). Any harm in
> skipping it and simply doing a wake_up_q() followed by wake_q_init()
> unconditionally?
>
> > +                     wake_up_q(&wake_q);
> > +                     wake_q_init(&wake_q);
> > +             }
> >               schedule_preempt_disabled();

Ah, thank you for the suggestion. I've reworked this in my tree!

> > @@ -1207,6 +1209,7 @@ static int __sched task_blocks_on_rt_mutex(struct=
 rt_mutex_base *lock,
> >       struct rt_mutex_waiter *top_waiter =3D waiter;
> >       struct rt_mutex_base *next_lock;
> >       int chain_walk =3D 0, res;
> > +     DEFINE_WAKE_Q(wake_q);
> >
> >       lockdep_assert_held(&lock->wait_lock);
> >
> > @@ -1245,7 +1248,10 @@ static int __sched task_blocks_on_rt_mutex(struc=
t rt_mutex_base *lock,
> >
> >               /* Check whether the waiter should back out immediately *=
/
> >               rtm =3D container_of(lock, struct rt_mutex, rtmutex);
> > -             res =3D __ww_mutex_add_waiter(waiter, rtm, ww_ctx);
> > +             preempt_disable();
> > +             res =3D __ww_mutex_add_waiter(waiter, rtm, ww_ctx, &wake_=
q);
> > +             wake_up_q(&wake_q);
> > +             preempt_enable();
>
> I'm trying to understand this - we enter task_blocks_on_rt_mutex() with
> "wait_lock" held (I believe the lockdep_assert_held() in the previous
> hunk checks for the same). I walked down the call chain (although
> briefly) and could only spot "task->pi_lock" being locked and unlocked
> before this call to "wake_up_q()" but the "wait_lock" seems to be held
> throughout, only being unlocked and locked again for
> "rt_mutex_adjust_prio_chain()" later down.
>
> Did I miss something or is disabling preemption for this specific hunk
> enough to enable safe nesting?

Thank you for pointing this out! It looks like I need to pipe the
wake_q down through task_blocks_on_rt_mutex(), and
rtlock_slowlock_locked() and define one in rtlock_slowlock().

Really appreciate the review and feedback here!
-john

