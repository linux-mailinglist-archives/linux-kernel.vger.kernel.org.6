Return-Path: <linux-kernel+bounces-189166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D50698CEC4D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 00:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8984B2829EA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 22:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC47B84DFD;
	Fri, 24 May 2024 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PPSpcjLm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4As9FsQ9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737EE85C65
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716588376; cv=none; b=GrJZpjAyUPIJcH7azTq66bJ8n3xtxCKl+Kzz/tNjxBjjBDNTOuf0kEVkcQUz+/yV0n3OZoDteNajUaLfTtDHeEfKq6+zsSQdl4ov0KOMOoPJ8yM2cg8h4TnfFM+H9WqEsY6mdNcoIT/gLdplNNNbvuwKINrcGYKf1jYrBhCnXS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716588376; c=relaxed/simple;
	bh=TYt9nrydYmUMqF5njWFjHLzMlIrRXGBto4lv/tuqtv4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uxF7MAmZ/gpRv0ZwyVKXD93A3K+RRsAkI0901lKPKGsZyEwfUXM4JEe0fUXu/sqWJt3DGiTeD812TbkHMujQtD+jiR2xNtqG5elobbwkRaF8o68KyXFKGARUd2PZtjJ3iiwlxFGd6Iz2k3E1V+4oOGVJBGCuVpeF4uISsL/CYc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PPSpcjLm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4As9FsQ9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716588367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZQLzUoQnFHlZCD1+3wpQeCvcfOJThYM5hzRmJfPud8=;
	b=PPSpcjLmg5P/HxzqYVLqRlwgLsO0CnhSPmV5NAE7J72CPvy4m+OKslZydxkDUfv5n8jxe8
	V7VAbaS5sjJWv+Z1eJn6StddhMBkIIM6ADsIgdrZDogH4VJKKrRKOUgS1caU6d8b4nrMiZ
	qE9V2F6XHzSZanM/fmGOK9bOFOpRXTrCimhDU2wNouw5xaTgZgNKtTWPnHQg1rKA+TYCJV
	53iq5z7LdWyV3PXw4BxmqvPLcaf+LBo/SFutLmC6ampqcDCINf+Xc9HJUi1Tj43i+++h5g
	pws7hgEM5xF/IU//4aiWpqFyBQkkWnPW1h2RmK2akPVQRN4VAOn86Ms2ZATgww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716588367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZQLzUoQnFHlZCD1+3wpQeCvcfOJThYM5hzRmJfPud8=;
	b=4As9FsQ9b8XPgCRvRnoqiWLybOKaL0oNRKfQIawIGnIlDJ59/i4xJAhjYvueSf47m/tV+v
	Xf86oTMWixL2uOCw==
To: Oleg Nesterov <oleg@redhat.com>, Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>, Chris
 von Recklinghausen <crecklin@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
In-Reply-To: <20240524183700.GA17065@redhat.com>
References: <20240522151742.GA10400@redhat.com>
 <20240523132358.GA1965@redhat.com> <87h6eneeu7.ffs@tglx>
 <ZlCwKk65-eL0FrKX@pavilion.home> <20240524183700.GA17065@redhat.com>
Date: Sat, 25 May 2024 00:06:06 +0200
Message-ID: <87v832dfw1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 24 2024 at 20:37, Oleg Nesterov wrote:

> I've already had a few beers today, I know I'll regret about this
> email tomorrow, but I can't resist ;)

You won't regret it. :)

> On 05/24, Frederic Weisbecker wrote:
> But again, again. tick_sched_do_timer() says
>
> 	* If nohz_full is enabled, this should not happen because the
> 	* 'tick_do_timer_cpu' CPU never relinquishes.
>
> so I guess it is not supposed to happen?

Right. It does not happen because the kernel starts with jiffies as
clocksource except on S390. The jiffies clocksource is not qualified to
switch over to NOHZ mode for obvious reasons. But even on S390 which has
a truly usable and useful clocksource the tick stays periodic to begin
with. Why?

The NOHZ ready notification happens late in the boot process via:
fs_initcall(clocksource_done_booting)

So by the time that happens, the secondary CPUs are up and have taken
over the do timer duty.

[    0.600381] smp: Bringing up secondary CPUs ...

...

[    1.917842] clocksource: Switched to clocksource kvm-clock
[    1.918548] clocksource_done_booting: Switched to NOHZ // debug printk

This is the point where tick_nohz_activate() is called first time and
that does:

  tick_sched_flag_set(ts, TS_FLAG_NOHZ);

So up to this point the tick is never stopped neither on housekeeping
nor on NOHZ FULL CPUs:

tick_nohz_full_update_tick()
  if (!tick_sched_flag_test(ts, TS_FLAG_NOHZ))
    return;

> And. My main question was: how can smp_call_function_single() help???

It's useless.

> Why do we actually need it?

We do not.

As explained above there is also nothing extra to fix contrary to
Frederics fears.

Even in the case that a command line limitation restricts the number of
CPUs such that there is no housekeeping CPU onlined during
smp_init(). That is checked in the isolation init code which clears
nohz_full_running in that case. Nothing to see there either.

So all this needs is the simple:

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index d88b13076b79..dab17d756fd8 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -229,11 +209,9 @@ static void tick_setup_device(struct tick_device *td,
 			if (tick_nohz_full_cpu(cpu))
 				tick_do_timer_boot_cpu = cpu;
 
-		} else if (tick_do_timer_boot_cpu != -1 &&
-						!tick_nohz_full_cpu(cpu)) {
-			tick_take_do_timer_from_boot();
+		} else if (tick_do_timer_boot_cpu != -1 && !tick_nohz_full_cpu(cpu)) {
+			WRITE_ONCE(tick_do_timer_cpu, cpu);
 			tick_do_timer_boot_cpu = -1;
-			WARN_ON(READ_ONCE(tick_do_timer_cpu) != cpu);
 #endif
 		}

along with the removal of the SMP function call voodoo programming gunk,
a lengthy changelog and a bunch of useful comments.

Changing the horribly lazy and incomprehensible '-1' to an actual
meaningful define, e.g. TICK_DO_TIMER_NONE, would definitely help along
with renaming the variable to tick_do_timer_nohz_full_boot_cpu.

There is no race other than the boot CPU reading tick_do_timer_cpu
concurrently to the update, but that's completely harmless whatever it
sees there. If it's the boot CPU, i.e. 0, or the secondary does not
matter. The secondary immediately schedules the tick unconditionally so
timekeeping and jiffies will just work.

If the secondary CPU fails to come up after it installed the clock event
device then the missing tick is the least of the problems.

That has absolutely nothing to do with the issue at hand. If the CPU
which owns tick_do_timer_cpu dies or gets stuck then all bets are off
independent of NOHZ FULL. See the changes which went in during the merge
window to handle the case where the hypervisor fails to inject the timer
interrupts or keeps the time keeper duty CPU scheduled out for a long
period of time....

Thanks,

        tglx

