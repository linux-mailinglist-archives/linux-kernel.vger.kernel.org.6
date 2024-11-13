Return-Path: <linux-kernel+bounces-408204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 326C69C7BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46BB281DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F76204031;
	Wed, 13 Nov 2024 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gn/50PUn"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6684F15ADA4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524840; cv=none; b=K/nEcNeGTXZttAXzAFgt9OUqY2t1keoNfgP6znyuq+KUy+qfVFMvwaGae8AzX09N9zroosLqQySu8irJQBVozs3nV5Qg5VPh1XuU/AhQUbdjrluIlYmaNJT17vaBfiNMMFRqnGTqqfQjhJ7YgiyRFbMmpXYFiLjnz60KtviN4OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524840; c=relaxed/simple;
	bh=dJzjW6mC+hJ9E9ouofADVRGXMYGJoQzo1vNKPQ6ZBt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIM05z+eIWTEhDu8ddICaH3/DofpGJEKuyZJOMY/cJ80/RM2V3tux16NB/TZrXZQxrn2yk5ddICqaJ2AlLtw5FCcoam98mCSxhuno5uPe5bjAQGEy0aSbRE1I6W4G0+/zuBtn2pho/rEsaX9ag21PhCCL7UCTrTxZB9i7U+V1gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gn/50PUn; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a850270e2so1327983166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731524837; x=1732129637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q13ryzNosnV/xJZBtK9f6BHsIvOTAR4m1CtdmIv3JKg=;
        b=Gn/50PUnsiC8ASqqa+ptS/pO7r8oKMpfT5hlTJdSTCKE/ZzGQqRUwPYajtF4O4bwuq
         T/nTfFkItTz4nLO9rGNsvQQON/F1/SCgsOqV5XS1+NApGTYARm8zxmQOsZtEksgpnzOI
         WCLidMAIc7e30xSnIEs1VN5QytCM3w8852dAWMtC1LgvvhcxVak09G7GiCATb6RPoIYU
         lQPfv5CVGv6YCK2FKhORK7hs9AiW9zcuelCIogEM5rX0mf1P0mJj7BgOkGRuh8QOQa/u
         msh3ENioHyC9WjfFN7dzowS+ja5StyP8vW61IowrOR7GLX1WnSXm14NaCTMSOhhcG7V8
         w3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731524837; x=1732129637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q13ryzNosnV/xJZBtK9f6BHsIvOTAR4m1CtdmIv3JKg=;
        b=HuAZrmb3/vcIJJeI6Su5YKJ3KaAXzjtvE3LRGwvS79eGyimx2x7YgiAz2rqn8QHMYH
         aOa8ZpsuktQuO/a6ufj4Dq7zQM/zXjfafcAC2/HfSbXkeiVRHBNWd5cd0f4CJA7jtmWb
         bncY/a9amd3la7rDwerGmEjgj8/1t3iGlMPPgYr2QNLUwRbMIYoRRY99v7SmH00b9D38
         k4znWMAWFS7IWFy3pNMpavx2Lh6v5+Zr+07SgQZI+xAa6Gpc4hkB7boF5YraELZSr0e1
         aOZwGNKXW+5ukEGePIayrQV65AcjO608s6Dg9rIkfDWS+P7brjZfGMsILJ4AZmAs1Jnh
         /xNw==
X-Gm-Message-State: AOJu0Yz55kgdwe+jnO7zI5IrAIjTIchZIyF93PumMvdtNriiHPouS6Wa
	MPSzPbge+LcRSJ30hRcOv1uhwT3Zu70+GHzWFkEvxOhQQpXkI/2770wr1XYBIrIo6vepFUkDU5K
	UCghOyiCUXMwqNpIVg1fsHaDbwCszq9qWRw0=
X-Google-Smtp-Source: AGHT+IHlEG7voMOSbDHO/W3YquguiufNqqvK5nE93aiC6YEexxFH+95V2J7kw6FOL+djBBBXpxHn0IOM6XkIHr8ea0Y=
X-Received: by 2002:a17:907:3e1a:b0:a9e:b610:8586 with SMTP id
 a640c23a62f3a-a9eefeade5dmr1866705666b.5.1731524836575; Wed, 13 Nov 2024
 11:07:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011232525.2513424-1-jstultz@google.com> <20241011232525.2513424-2-jstultz@google.com>
 <6afb936f-17c7-43fa-90e0-b9e780866097@app.fastmail.com>
In-Reply-To: <6afb936f-17c7-43fa-90e0-b9e780866097@app.fastmail.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 13 Nov 2024 11:07:05 -0800
Message-ID: <CANDhNCo_CMNaVm5J+5ka24rb+gRjfeujyVakV6Hai_5j=V-axQ@mail.gmail.com>
Subject: Re: [PATCH v13 1/7] locking/mutex: Remove wakeups from under mutex::wait_lock
To: Arnd Bergmann <arnd@arndb.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	Davidlohr Bueso <dave@stgolabs.net>, regressions@lists.linux.dev, 
	Thorsten Leemhuis <linux@leemhuis.info>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 10:18=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Sat, Oct 12, 2024, at 01:25, John Stultz wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > In preparation to nest mutex::wait_lock under rq::lock we need
> > to remove wakeups from under it.
> >
> > Do this by utilizing wake_qs to defer the wakeup until after the
> > lock is dropped.
>
> To follow up from IRC, this patch is the one that caused a
> boot time regression in linux-next in the regulator framework.
>
> Anders Roxell found this during testing on the Rock Pi 4 board
> (rockchips rk3399 based).
>
> The book load with the NULL pointer dereference is at
> https://lkft.validation.linaro.org/scheduler/job/7979980#L741
>
> The interesting bit is this:
>
> [ 0.957586] rk_gmac-dwmac fe300000.ethernet: Enable RX Mitigation via HW =
Watchdog Timer"}
> [ 0.969402] hub 6-0:1.0: USB hub found"}
> [ 0.969450] hub 6-0:1.0: 1 port detected"}
> [ 0.988163] Unable to handle kernel NULL pointer dereference at virtual a=
ddress 0000000000000000"}
> [ 0.988172] Mem abort info:"}
> [ 0.988174]   ESR =3D 0x0000000096000004"}
> [ 0.988176]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits"}
> [ 0.988180]   SET =3D 0, FnV =3D 0"}
> [ 0.988183]   EA =3D 0, S1PTW =3D 0"}
> [ 0.988185]   FSC =3D 0x04: level 0 translation fault"}
> [ 0.988187] Data abort info:"}
> [ 0.988189]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000"}
> [ 0.988191]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0"}
> [ 0.988194]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0"}
> [ 0.988197] [0000000000000000] user address but active_mm is swapper"}
> [ 0.988201] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP"}
> [ 0.988205] Modules linked in:"}
> [ 0.988217] Hardware name: Radxa ROCK Pi 4B (DT)"}
> [ 0.988225] pc : wake_up_q (kernel/sched/core.c:1059)
> [ 0.988238] lr : wake_up_q (kernel/sched/core.c:1054)
> [ 0.988243] sp : ffff800083433a00"}
> [ 0.988245] x29: ffff800083433a00 x28: 0000000000000000 x27: ffff0000053b=
6080"}
> [ 0.988253] x26: ffff800083433b90 x25: ffff0000053b6000 x24: ffff80008009=
8000"}
> [ 0.988259] x23: 00000000ffffffff x22: 0000000000000001 x21: 000000000000=
0000"}
> [ 0.988265] x20: fffffffffffff850 x19: 0000000000000000 x18: 000000000000=
0001"}
> [ 0.988272] x17: ffff800075678000 x16: ffff800082728000 x15: 019ee6ab9800=
6e30"}
> [ 0.988278] x14: 000002ce459acd0c x13: 000b52b4cf08772c x12: 000000000000=
000f"}
> [ 0.988284] x11: 0000000000000000 x10: 0000000000000a50 x9 : ffff80008343=
3870"}
> [ 0.988291] x8 : ffff0000050fceb0 x7 : ffff0000f76ab9c0 x6 : 00000000000b=
52b4"}
> [ 0.988297] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 000000000000=
0000"}
> [ 0.988303] x2 : 0000000000002710 x1 : 0000000000000001 x0 : 000000000000=
2710"}
> [ 0.988310] Call trace:"}
> [ 0.988313] wake_up_q+0x50/0xf0 P)"}
> [ 0.988319] wake_up_q+0xa0/0xf0 L)"}
> [ 0.988325] __ww_rt_mutex_lock.isra.0 (arch/arm64/include/asm/preempt.h:6=
2 (discriminator 2) kernel/locking/rtmutex.c:1794 kernel/locking/ww_rt_mute=
x.c:71)
> [ 0.988333] ww_mutex_lock (kernel/locking/ww_rt_mutex.c:82)
> [ 0.988338] regulator_lock_recursive (drivers/regulator/core.c:161 driver=
s/regulator/core.c:333)
> [ 0.988347] regulator_lock_recursive (drivers/regulator/core.c:348)
> [ 0.988354] regulator_lock_dependent (drivers/regulator/core.c:409)
> [ 0.988360] regulator_set_voltage (drivers/regulator/core.c:4173)
> [ 0.988366] _opp_config_regulator_single (include/linux/regulator/consume=
r.h:707 (discriminator 1) drivers/opp/core.c:933 drivers/opp/core.c:1019)
> [ 0.988375] _set_opp (drivers/opp/core.c:1253)
> [ 0.988379] dev_pm_opp_set_rate (drivers/opp/core.c:1357)
> [ 0.988384] set_target (drivers/cpufreq/cpufreq-dt.c:63)
> [ 0.988392] __cpufreq_driver_target (drivers/cpufreq/cpufreq.c:2292 drive=
rs/cpufreq/cpufreq.c:2355)
> [ 0.988398] sugov_work (kernel/sched/cpufreq_schedutil.c:537)
> [ 0.988406] kthread_worker_fn (arch/arm64/include/asm/jump_label.h:32 inc=
lude/linux/freezer.h:36 include/linux/freezer.h:54 kernel/kthread.c:861)
> [ 0.988414] kthread (kernel/kthread.c:389)
> [ 0.988420] ret_from_fork (arch/arm64/kernel/entry.S:863)
> [ 0.988430] Code: f100067f 54000320 d11ec274 aa1303f5 (f9400273) "}
>
>
> > @@ -1776,8 +1785,11 @@ static int __sched rt_mutex_slowlock(struct
> > rt_mutex_base *lock,
> >        * irqsave/restore variants.
> >        */
> >       raw_spin_lock_irqsave(&lock->wait_lock, flags);
> > -     ret =3D __rt_mutex_slowlock_locked(lock, ww_ctx, state);
> > +     ret =3D __rt_mutex_slowlock_locked(lock, ww_ctx, state, &wake_q);
> > +     preempt_disable();
> >       raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
> > +     wake_up_q(&wake_q);
> > +     preempt_enable();
> >       rt_mutex_post_schedule();
> >
> >       return ret;
>
> This is apparently where things went wrong, but it's possible that
> the actual root cause is in the regulator framework instead.
>
> The NULL pointer itself happens when chasing wake_q->first->next,
> so it would seem that one of these got reinitialized at
> the wrong time, perhaps with a task_struct getting freed
> or getting put on more than one wake_q_head lists at the
> same time.

Thanks so much again to Anders for finding and reporting this!

So I've managed to reproduce this and I'm chasing down what's going wrong n=
ow.

Thanks so much for the report!
-john

