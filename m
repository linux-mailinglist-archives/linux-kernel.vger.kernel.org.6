Return-Path: <linux-kernel+bounces-567522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D247A68752
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D67B19C71EB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEF72517B6;
	Wed, 19 Mar 2025 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Haze0vU+"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08C9251798
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742374494; cv=none; b=J/OY5KRmuO3oe9NNn4aTp95U5VZrq9inDo8SIgI1xNJ9ethVt1M95oNsjIbjJYfI6882DDJklRQyQ6Ry0FjYmpb4WVHM1fPipIofEtTE/Cnu37XgIg+Cr3xJh1tIvNpmV2/rIVXgceTE20p926MhinPIgZe7qXe4/kblmIHmjtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742374494; c=relaxed/simple;
	bh=/eFOkm/Rc8pm583f5BislW5sAhP6YWPlw+gKr1LjMWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAUJUmytMSsxS4fmUGdD6doDOdsCVlgxe6WJzxT38pzvCbBO6hUuzDOZHGj1XVdI78zW6775atLrVOuWPTbIfPa7Rj8K8KgBwyXX/B6q0uMOgabZVNfol/Qgbp18ttQmfarIopdeaxR4D2/gRfLDoGLEt7EISTjmE+eOu7nOco8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Haze0vU+; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bee278c2aso5436881fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 01:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742374491; x=1742979291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E75qYqJA9QcfJR0IgLxqcAg5aJGgvfAP1E+I53YEqVI=;
        b=Haze0vU+8S1Vqd/VvpIjT5Sxcl37vKMPT2IDspNH15bcaxG/9dh5SuOwqmdDYWO3lG
         GYyy76Sx84ZmUfYaUYwNzdkX9hmAAFmErkQntYyRRNrzTTW9k40HT8l3AZtJA1C/dTYY
         8rqg37BGbyPYb+qafWe/Wv7Ag8k7DuLEir53zNg6V6xKLyDhtZ1Ud1dXHRvjdU/hPUEt
         Tz7Y+ynPF8dw7gueRH+eJeErqgIPTwSnjiRdtm3JnrBZXY1r6zxdW64/Qu7I5nwtPyGZ
         9/vcdB6XR6trTqZbbNWvx5LnIdHwF0cXi7F77Mfdfi2r3IxtewHmRujhUIvU3euDDyVv
         xzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742374491; x=1742979291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E75qYqJA9QcfJR0IgLxqcAg5aJGgvfAP1E+I53YEqVI=;
        b=iu166JthZV/4rdThgqLeMyVxaULdnACeqKCorzdLp/i2/TBrlNyApTvgI5u96Vuj4v
         2dgm9ndRn9bjvfYpOrRZoIT8k1xP0Vsu50Jib3xH0f4txJ0EIr8SmBIGZC7409ju6exi
         uIsvL0fWneg4B5F0pan1BkdeLe3qc8ntIc98EORlHaeSwpvA3pOK0wSUOBJ1c28+J+/0
         VXX9BN70YUZaURde5d968FzczGU7uCEpNYvBO4SML1Ij6jaNz/jY7D0HxDZHFO6WDAv+
         77XLiFFetPTKzBqzuxjDPkdLD0W1kij94Y/fIpCBP/Dzsca/u39jwowEp15sJIUqOczS
         /z8w==
X-Forwarded-Encrypted: i=1; AJvYcCX5N7BgNaj09DpEVDpBaD8J3MBe6X0+yWwpow6H9rpOg5k7kK6rTPhnR4C79LiGUSV/j4963ZMpMBFmiaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YygQOYLjt/k+ArR95vJGAPJtJxcgaxCJ0ruW6wYg0Yl+vMJLbM4
	I6tIoMx33cZ6g/EZaPAeWcwF0wcevq5yPQVKCUliNkeuxwtgxymmYmeMwX4PiOClmiu/lwvLQ7A
	Oz+rgJe3nI0BHXfHCeps6jXjBkXp3VI+NXOc=
X-Gm-Gg: ASbGncvud2owSdB+PnTSHcT7bOOSd3nLgRakUZfuv6cNZ6YnDzak+VyTjyiXZWkblC+
	dG1KJRpEEXOle9delUrpMqRQxcH3lR8Qtna+86qR6uTjJd7qJm+ut245+MGLFJ2U1sVucgCf+ux
	QdI7YBd3qkeG1ZlLQFyUL4kbOOtSV/31LZLg6yO4/uVCMA9IFHg+iv4U0=
X-Google-Smtp-Source: AGHT+IFz/av0GEN2Yri0sEOkJjApWK02V27uXuvZD2ZDah34oDuMdS6CGgqT/tsWweF4ER+nhlR0NfMgGoX6HigYUeE=
X-Received: by 2002:a05:6512:3984:b0:549:9606:adc0 with SMTP id
 2adb3069b0e04-54a3735bab0mr3356937e87.25.1742374490377; Wed, 19 Mar 2025
 01:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312221147.1865364-1-jstultz@google.com> <20250312221147.1865364-3-jstultz@google.com>
 <20250313061351.412bc92e@batman.local.home> <CANDhNCou90nzwZR+cQisJnwBis=JGSw0WYE6BDRddhMobrkkXA@mail.gmail.com>
 <20250318231101.a77dd6de0f5e48cffad5e08a@kernel.org>
In-Reply-To: <20250318231101.a77dd6de0f5e48cffad5e08a@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Wed, 19 Mar 2025 09:54:38 +0100
X-Gm-Features: AQ5f1JqEGsKSMRkEx5HKiOTjKgV9uzGvcGDjPI5pQ64q1GNVpZh05_mHvY2zpXc
Message-ID: <CANDhNCoB9AksL_v8_3Xs_2Q0axBdCrZtzc_=Wzq=6KQk765dPw@mail.gmail.com>
Subject: Re: [RFC PATCH v15 2/7] locking/mutex: Rework task_struct::blocked_on
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com, 
	Lance Yang <ioworker0@gmail.com>, hikalium@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 3:11=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
> On Thu, 13 Mar 2025 23:12:57 -0700
> John Stultz <jstultz@google.com> wrote:
>
> > On Thu, Mar 13, 2025 at 3:14=E2=80=AFAM Steven Rostedt <rostedt@goodmis=
.org> wrote:
> > > FYI, this is useful for Masami's "hung task" work that will show what
> > > tasks a hung task is blocked on in a crash report.
> > >
> > >   https://lore.kernel.org/all/174046694331.2194069.154729520502408074=
69.stgit@mhiramat.tok.corp.google.com/
> > >
> >
> > Ah. Indeed, we have similar use cases. There's some slight difference
> > in when we consider the task blocked, especially in this early patch
> > (as waking tasks mark us as unblocked so we can be selected to run).
> > But later on in the series (in the portions I've not yet submitted
> > here) when the blocked_on_state has been introduced, the blocked_on
> > value approximates to about the same spot as used here.
>
> Interesting. Can yo also track tasks which takes other locks like
> rwsem/semaphore ? Lance is also working on this to expand it to
> support semaphore.

Currently no, proxy-exec is initially just focused on kernel mutexes.
However I do hope to expand it to be usable with other locking
primitives, so something like what Lance is proposing would be  needed
for that, so I'm eager to make use of his work.

I've pulled both of your work into my tree and will try to rework my
logic on top.

> BTW, I had a chat with Suleiman and he suggested me to expand
> this idea to record what locks the task takes. Then we can search
> all tasks who is holding the lock. Something like,
>
> struct task_struct {
>         unsigned long blocking_on;
>         unsigned long holding_locks[HOLDING_LOCK_MAX];
>         unsigned int holding_idx;
> };
>
> lock(lock_addr) {
>         if (succeeded_to_lock) {
>                 current->holding_locks[current->holding_idx++] =3D lock_a=
ddr;
>         } else {
>                 record_blocking_on(current, lock_addr)
>                 wait_for_lock();
>                 clear_blocking_on(current, lock_addr)
>         }
> }
>
> unlock(lock_addr) {
>         current->holding_locks[--current->holding_idx] =3D 0UL;
> }
>
> And when we found a hung task, call dump_blocker() like this;
>
> dump_blocker() {
>         lock_addr =3D hung_task->blocking_on;
>         for_each_task(task) {
>                 if (find_lock(task->holding_locks, lock_addr)) {
>                         dump_task(task);
>                         /* semaphore, rwsem will need to dump all holders=
. */
>                         if (lock is mutex)
>                                 break;
>                 }
>         }
> }
>
> This can be too much but interesting idea to find semaphore type blocker.

Yeah. I suspect the rw/sem -> owners mapping is a missing piece that
will be needed for proxy-exec, but I've not looked closely yet.

thanks
-john

