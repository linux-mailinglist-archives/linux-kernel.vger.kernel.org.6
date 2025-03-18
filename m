Return-Path: <linux-kernel+bounces-566438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84777A67805
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533C319C048E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6542120FAB0;
	Tue, 18 Mar 2025 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="no0GMdPF"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F325E20FAAB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312029; cv=none; b=p3Hpclt4wJtW074/9lazfnUoxWUFv5P8FzfdBzxKp23+csQTK0+5l/PaWwkm//Bg+AJqDF1CD8VDhUKDvouG55gQ2xFcKMYHSCHph2GQL2nc2mYLIqO2iB/ZgGHrESMyXrUMkxmyg2VonyIC67WdaRnL+M1VsRan7jjg/m+7pAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312029; c=relaxed/simple;
	bh=FPZ/3hvflHnLRJVph4n5qHHQLnr5jPDdXG3WqgBS+2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEJeyEXNJeNSOYQnlYMU2LGKhkutzaSggMYC+mTNyNiubqHO/uzkR+WYB+JjJkAztxiTmWHYZktw178rnNk2/543gryvgVbXQLX9gi7kxKFzbQw2125km0aLHHhC3AsZAfDj1ewiAH2OL0yue6bcO4Dr08IZv8X0I5SG6kYCjWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=no0GMdPF; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so1358327a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742312026; x=1742916826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvWyIDqkxUHipZw33800mS7WPkXEbqQlzjbZutcmkWw=;
        b=no0GMdPF9WAV5xa2mNM5755FwWMrlmU7jvOhtg+c/Oi9iWilRGO61msi3pDpEH1Akk
         hGtmHMFVt7MDBtiSPhj44Z/QyO4uHYusILLWmszve+1Te2QWK1skHN5YcbvlcTmTG3xI
         pdj76DcZ3ih7JeiQBevF7vyoA1l7K8veKSe7nJPMRBBVaERGZV3Lr8Ok+gPDaQeDXEkj
         48kjT1MFHD2JB+QBg5714vvK048geQSMapwM991fJeNmqUfbuICyJrYQRIuTkCGTSugu
         +XugieETcLoluGjeP/Mpci1dcAC1cySRgUx0XbnANQmNvdNHxiJh5fFbkF/R5oc2hlVo
         8S0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742312026; x=1742916826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvWyIDqkxUHipZw33800mS7WPkXEbqQlzjbZutcmkWw=;
        b=MsZCY8eCy5whRmQI8rt0xF9bviaieu3Y4SGdQ7jhLKLwZMDX0im+7HkKeNKXbYBz+T
         X9VwbJ0k4C/Q1xwacoo4UAlqqxLvZbuyRC+lZqOqIyZpdjFPbnJTN1+wFh/taOtkIqmb
         g9PiKiiCstM1n7c5hmYd7XxjO3fxvS1DWsDcw1JP2nX7kWqU7JuL1BPVku3jGZWYiTzL
         xtrP15p8Kub0Xk4WnjQ3JvzKNLAJ9kvp5Fqxu5oKZdWK9XyvDChGP3AaejkXzDRUg0AQ
         tme5avVbpKN6UwpowVqQil5SdLPRklOOdKywRMKFJBEMQysdYc9oNpmzfjtBG1eiTpB/
         1GwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz8/QiLNRRwIAyCN1Xk4UwzzPfXek6SdOxfUJn5Qo96d8G9UXef13RKkigUtiDWtvpMfx0dXHgWnFSMqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7eSGkJYFu8Rd1gMjVM7blDaRxWJAffEiVOtyJ7xzYXpWWaqDc
	oKou5+gzYd8DDyKcD2tzQb23vDW6TWu3y2qDdANX6Zj9SYLnVsUX5A5x+jLI7QsE+97ZuS6zEHg
	FqtCfejipyeW6ttbW8HEUEy0+HSQ=
X-Gm-Gg: ASbGncvxeXmYC37xWsInjwJqAvs4rhytg3Sp9pXZQ1EJ4s0gz0lXCeA7/rpwMKKGIGj
	JdCIqoCnDdUfG6bXkUNJ8PQy5o5T34Yeuu7Uifn+R12f588qC1MzDbnRA1ViHWBkiRo3Njm8duZ
	Lrp+2x2/20VpYU1bE18pnCiiCRdYU0XyUBPv4BLU4=
X-Google-Smtp-Source: AGHT+IEV2rDrUQqS4nt/BuWRUYoI4o7rSyoyfvSBJyc8O/iwJkmP6AZIi+VEx5gXdJe0wyxyg5eA6h7Y6R+pHjyED+0=
X-Received: by 2002:a05:6402:2115:b0:5e5:ca1b:c425 with SMTP id
 4fb4d7f45d1cf-5e89fa39e1fmr19229848a12.17.1742312025878; Tue, 18 Mar 2025
 08:33:45 -0700 (PDT)
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
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 18 Mar 2025 23:33:09 +0800
X-Gm-Features: AQ5f1JqtJH9kVUUGnQlPgtAYSoZHp_OiejwKsBgGuVWRv71qwZzDHTdgiOQGM8M
Message-ID: <CAK1f24=rTxBF6RGrToHLCg0cZ5ffe-OLEqXu8eyC5nqStMVRwA@mail.gmail.com>
Subject: Re: [RFC PATCH v15 2/7] locking/mutex: Rework task_struct::blocked_on
To: Masami Hiramatsu <mhiramat@kernel.org>, John Stultz <jstultz@google.com>
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
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com, hikalium@google.com, 
	amaindex@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 10:11=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
>
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
>
> https://lore.kernel.org/all/20250314144300.32542-1-ioworker0@gmail.com/
>
> Please add them for the next version.

Hi John,

When=E2=80=99s the next version expected? I intend to send a new version ou=
t
soon, and it=E2=80=99d be great if you could include it in the next version=
 ;)

Also, since we have similar use cases, it might make sense to use
the same field to store the lock, encoding the lock type in the LSB as
Masami suggested.

>
> >
> > So I should be able to unify these. It looks like Masami's patch is
> > close to being queued, so maybe I'll incorporate it into my series and
> > rework my set ontop. Any objections to this?
>
> No :) Please Cc to me.
>
>
> BTW, I had a chat with Suleiman and he suggested me to expand
> this idea to record what locks the task takes. Then we can search
> all tasks who is holding the lock. Something like,

Hi Masami,

Yeah, that=E2=80=99s a really cool idea - being able to search for all task=
s holding a
lock. Maybe we just keep it simple for now and extend it when we need to
handle more complex stuff like rwsem ;)

Thanks,
Lance

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
>
> Thank you,
>
> >
> > thanks
> > -john
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

