Return-Path: <linux-kernel+bounces-445840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B139F1C21
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 03:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8909416586B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 02:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F47B17BB6;
	Sat, 14 Dec 2024 02:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WwiH2gtY"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E49FBF6
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 02:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734144000; cv=none; b=YfKPSyThB5xTrrp/3ykQLZ9Y5N+EWgpGvLDa1A0goDtFWl6s8MvjF+3IXPODKeZ3gTnIEMeXpObnifhREMj3s9sVBlPLZYTBZ/usElWyRR7Iwvexcu/7hXQ4xOMQ6Wzn9/hmDbSBQJftmoUkkNS1RRakEg7doe4YZIJSEquKcvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734144000; c=relaxed/simple;
	bh=CpYEd+MHVxlo6UOMuDPZeDAHGP+KjfKsFRmCOZi9ztA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFbEjWLQ8b3ZFdwC7ZeCkd4wXLjLZU8SVteG8pYB2VjP/maUXu4AyWIoos386k+J2S+cgIXlIrFoTiNBnm0iim9bO9Jm5rlpDtUDuAtaNdVEjsmZGVjyLHXxLKXApNs0pqjRpJ/h3Zbc4ugTh/EZI8yfpGFnIgn7JaKuyLxQ3x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WwiH2gtY; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso343504566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734143997; x=1734748797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acz4a1CtLmHqY0hs65r3J6l3cfn4CQhhkU50yv57948=;
        b=WwiH2gtYgnDd/LfqWZbFDLmJ8AV3ee24y++ysn6gINYyPk/dSAFaguyKQPChGu0hs6
         nBXMBG/h9YCWXgPx1Obfv4mFP2h6Lq3N9fUhA56YZEl8SbguS+BRszyF9Q/1cDPJcg5h
         gwKshJ0yldjNLlJLe1qJ2g5aE2/ml/HGyFB+K29fT4qGpWWxZk28KFRtq5krxXYdMuoC
         SmnszVLStMFkejUfNBtWnb/0wamJz5cbpNjCjCtfn/Xnr5MzhLRXw9ZfFsxJkgtmzGVE
         4o4uJZ6Oc1xig2c/AxQCd4lbS5OZekV2YIp5BId5+uqDaNIFQ/gD98jdAjBtSMyNIrCZ
         Zxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734143997; x=1734748797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acz4a1CtLmHqY0hs65r3J6l3cfn4CQhhkU50yv57948=;
        b=ZIhne1cuLT3YvsM7CnyglAC7hLHKbODnNYo1dgqOSChZllySIA8EP9R+G44BSwHvV9
         QUc+NJ87uJlcV9xmFmZ7Um33Htj8UcrO7qRf2Hw45MLAxYOUWjX/lyZEHmTxsOVtlTUZ
         WsMkhS1djMJ0UCDYnceMgAG/7hXqCZ27GMH5wsMxQLwgTrL69qdTMN2Tv5VRLTzbCTwG
         fBZXBOwiYGnorvIu/K8qq7kWjXSR1KKHjXF74USQUzfd/IlGajTo9/NJYYfNuctN2TY2
         Ba9cuhM2dLhYv+lTnQFxYs4k6glgiEM/T6XhyLaKB4F5Q9RhtNGyuEP20nPCkof6PfOt
         vtlg==
X-Gm-Message-State: AOJu0YylDXHaxwlq21vtEyIGM33KMLYiX2YsOvNQomCbR5I6w1k+ison
	5GU1RMvDXAxcJHBLlaqzwMmOvbqJpZEBncKIPWfBvZ9BzLlxeCzAwZAI3VNZfRtLaFvGt9fb9nX
	ZkuE48bCapAldI0hO5LxLT+UP3lyac/6zRik=
X-Gm-Gg: ASbGncs6khcln+fKIefh4J9KcfSQoR5qCeucB4ur/ZPrLyu5ByH3h4Rdfl8xJXLwYQS
	vvDhel53wqGY4XJA+/w64HAC1WZVZjQm/Y4twqSRUUG/u50r+uMz/7mEpkB3605Re5u4=
X-Google-Smtp-Source: AGHT+IFmARx6HH0jMAiu/FoIScFvu6EiOfjpAZvtvt0srcyd8ZEKsrTQwGJ68TMYNTu9Xeqq+u4YwVCsEeEOv3Y6WC4=
X-Received: by 2002:a17:907:1c0f:b0:aa6:b4b3:5925 with SMTP id
 a640c23a62f3a-aab77909d61mr407783466b.14.1734143997057; Fri, 13 Dec 2024
 18:39:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212222138.2400498-1-jstultz@google.com> <20241213124614.GA12338@noisy.programming.kicks-ass.net>
In-Reply-To: <20241213124614.GA12338@noisy.programming.kicks-ass.net>
From: John Stultz <jstultz@google.com>
Date: Fri, 13 Dec 2024 18:39:45 -0800
X-Gm-Features: AbW1kvaCZ9tVExy_wYYt6Eym76cuFsl5HPs44lJExTzW4jwMQ6IB44otCYPEpGI
Message-ID: <CANDhNCo0W6cYhVQm7TQso=E9evhYy2oxSLnVz-KxbOdfomZFgQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] locking/rtmutex: Make sure we wake anything on the
 wake_q when we release the lock->wait_lock
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Bert Karwatzki <spasswolf@web.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 4:46=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Dec 12, 2024 at 02:21:33PM -0800, John Stultz wrote:
> > Bert reported seeing occasional boot hangs when running with
> > PREEPT_RT and bisected it down to commit 894d1b3db41c
> > ("locking/mutex: Remove wakeups from under mutex::wait_lock").
> >
> > It looks like I missed a few spots where we drop the wait_lock and
> > potentially call into schedule without waking up the tasks on the
> > wake_q structure. Since the tasks being woken are ww_mutex tasks
> > they need to be able to run to release the mutex and unblock the
> > task that currently is planning to wake them. Thus we can deadlock.
> >
> > So make sure we wake the wake_q tasks when we unlock the wait_lock.
> >
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Bert Karwatzki <spasswolf@web.de>
> > Cc: kernel-team@android.com
> > Reported-by: Bert Karwatzki <spasswolf@web.de>
> > Closes: https://lore.kernel.org/lkml/20241211182502.2915-1-spasswolf@we=
b.de
> > Fixes: 894d1b3db41c ("locking/mutex: Remove wakeups from under mutex::w=
ait_lock")
> > Signed-off-by: John Stultz <jstultz@google.com>
> > ---
>
> I don't suppose this actually makes things much better -- but I had to
> try.
>
>
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1192,6 +1192,17 @@ try_to_take_rt_mutex(struct rt_mutex_bas
>         return 1;
>  }
>
> +#define WRAP_WAKE(_stmt, _q) \
> +do { \
> +       struct wake_q_head *_Q =3D (_q); \
> +       guard(preempt)(); \
> +       _stmt; \
> +       if (_Q && !wake_q_empty(_Q)) { \
> +               wake_up_q(_Q); \
> +               wake_q_init(_Q); \
> +       } \
> +} while (0)
> +
>  /*
>   * Task blocks on lock.
>   *
> @@ -1295,13 +1303,7 @@ static int __sched task_blocks_on_rt_mut
>          */
>         get_task_struct(owner);
>
> -       preempt_disable();
> -       raw_spin_unlock_irq(&lock->wait_lock);
> -       /* wake up any tasks on the wake_q before calling rt_mutex_adjust=
_prio_chain */
> -       wake_up_q(wake_q);
> -       wake_q_init(wake_q);
> -       preempt_enable();
> -
> +       WRAP_WAKE(raw_spin_unlock_irq(&lock->wait_lock), wake_q);

I worry this obscures the _stmt action and makes it a bit harder to read.

I think all of the calls are tied to the unlock (the one you quoted
earlier was removed with 82f9cc094975240), so would something like a
special unlock be reasonable:
   raw_spin_unlock_irq_and_wake(&lock->wait_lock, wake_q)
?

thanks
-john

