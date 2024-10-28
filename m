Return-Path: <linux-kernel+bounces-384265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1744F9B28D8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98992820FD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D167D1922E8;
	Mon, 28 Oct 2024 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rcbNxN5r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hMZwCOGX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1DA190662
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100740; cv=none; b=BQbCYAxov1l5wLLyg/BWe3qCOnR9g5GsIg56WgCXZSCIuro96GM7BvO7gOlg1mH9x5KsrMf8sMeLrgkr48ED7bw4UIYnGReoAQp6u3BU4RFq5xKmL+u9dd1clGQQRja7DFCpocFMlCyG3J2SlQ1kR9SG1tPtM21qfIPq8XcZI5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100740; c=relaxed/simple;
	bh=l0h79QdPKDcU5p7fo58DCAoMod++E7m1WB8y8/ltG08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kjFP4Bnjg5hKuM4wcPpZKpFX/2waHHUeWCgDDFX2JxAxBAlrZpOrrh6b+zL1bS//rA9DNmQF/VaZGp3qbgQleGQZlSnZPcfH6Cn/yVZ7k7kZOFjuGhU+7xRbiyBTEOLrBSJV7bCjKxdfdC6AHIuM3aT3LjhPWsLxV/M+NPaaw8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rcbNxN5r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hMZwCOGX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NF3eWlD7121YEb2lDisWLm11nt1ec5bbxFiMgc7WtLE=;
	b=rcbNxN5rJdNc4+x5LEXzKwk+PbSBpno+vKbgSJyo7ssLuU+zzBNaNWm/4FWRnrNXK0sque
	EyjR0KdkYr8twJ+ZnasV9jaoRWlZ+v7EzHL3MUNNFYd8+UESM4Ikhd3X1e7j7gK2L2Ak5Z
	F/XzxBob3+jlbs4J8CYS2/2t6ybc5/bPXCkBm3thHT9AVero2rIMC+EKvShaCMjQjlLhyK
	GR7LbVx9FinnyuNjDLds2FJUtUTK+AmQOWZwyLKTTHGQgaijJzCvi7XAA+ReKS4FvdCuG1
	4VTJBj9OHD9HjQPd1zsFjrKd/axdoT0NUjAqGYyz7HH1btTwQrY1JOS6CG4N1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NF3eWlD7121YEb2lDisWLm11nt1ec5bbxFiMgc7WtLE=;
	b=hMZwCOGXQv9Z0QEDS2BBAZ5PVfjKSLZ8UafgtkYUILGAGCcR2xvWcoG7B2kiAncWno5aS8
	HScUMNxjFCTr2VDQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	John Stultz <jstultz@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 00/31] hrtimers: Switch to new hrtimer interface functions (2/5)
Date: Mon, 28 Oct 2024 08:31:33 +0100
Message-Id: <cover.1729864823.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is the second part of a 5-part series (split for convenience). All 5
parts are:

Part 1: https://lore.kernel.org/lkml/cover.1729864615.git.namcao@linutronix=
.de
Part 2: https://lore.kernel.org/lkml/cover.1729864823.git.namcao@linutronix=
.de
Part 3: https://lore.kernel.org/lkml/cover.1729865232.git.namcao@linutronix=
.de
Part 4: https://lore.kernel.org/lkml/cover.1729865485.git.namcao@linutronix=
.de
Part 5: https://lore.kernel.org/lkml/cover.1729865740.git.namcao@linutronix=
.de

To use hrtimer, hrtimer_init() (or one of its variant) must be called, and
also the timer's callfack function must be setup separately.

That can cause misuse of hrtimer. For example, because:
  - The callback function is not setup
  - The callback function is setup while it is not safe to do so

To prevent misuse of hrtimer, this series:
  - Introduce new functions hrtimer_setup*(). These new functions are
    similar to hrtimer_init*(), except that they also sanity-check and
    initialize the callback function.
  - Introduce hrtimer_update_function() which checks that it is safe to
    change the callback function. The 'function' field of hrtimer is then
    made private.
  - Convert all users to use the new functions.
  - Some minor cleanups on the way.

Most conversion patches were created using Coccinelle with the sematic
patch below; except for tricky cases that Coccinelle cannot handle, or for
some cases where a Coccinelle's bug regarding 100 column limit is
triggered. Any patches not mentioning Coccinelle were done manually.

virtual patch
@@ expression timer, clock, mode, func; @@
- hrtimer_init(timer, clock, mode);
  ...
- timer->function =3D func;
+ hrtimer_setup(timer, func, clock, mode);

@@ expression timer, clock, mode, func; @@
- hrtimer_init(&timer, clock, mode);
  ...
- timer.function =3D func;
+ hrtimer_setup(&timer, func, clock, mode);

@@ expression timer, clock, mode, func; @@
- hrtimer_init_on_stack(&timer, clock, mode);
  ...
- timer.function =3D func;
+ hrtimer_setup_on_stack(&timer, func, clock, mode);

@@ expression timer, clock, mode; @@
- hrtimer_init_sleeper_on_stack(timer, clock, mode);
+ hrtimer_setup_sleeper_on_stack(timer, clock, mode);

Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Anup Patel <anup@brainfault.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>


Nam Cao (31):
  KVM: MIPS: Switch to use hrtimer_setup()
  KVM: PPC: Switch to use hrtimer_setup()
  KVM: s390: Switch to use hrtimer_setup()
  KVM: x86: Switch to use hrtimer_setup()
  KVM: arm64: Switch to use hrtimer_setup()
  LoongArch: KVM: Switch to use hrtimer_setup()
  riscv: kvm: Switch to use hrtimer_setup()
  ARM: imx: Switch to use hrtimer_setup()
  ARM: 8611/1: l2x0: Switch to use hrtimer_setup()
  powerpc/watchdog: Switch to use hrtimer_setup()
  perf/x86: Switch to use hrtimer_setup()
  s390/ap_bus: Switch to use hrtimer_setup()
  sched: Switch to use hrtimer_setup()
  rcu: Switch to use hrtimer_setup()
  lib: test_objpool: Switch to use hrtimer_setup()
  io_uring/timeout: Switch to use hrtimer_setup()
  fork: Switch to use hrtimer_setup()
  perf: Switch to use hrtimer_setup()
  timerfd: Switch to use hrtimer_setup()
  time: Switch to hrtimer_setup()
  bpf: Switch to use hrtimer_setup()
  ubifs: Switch to use hrtimer_setup()
  watchdog: Switch to use hrtimer_setup()
  tracing/osnoise: Switch to use hrtimer_setup()
  block, bfq: Switch to use hrtimer_setup()
  ata: pata_octeon_cf: Switch to use hrtimer_setup()
  blk_iocost: Switch to use hrtimer_setup()
  PM: runtime: Switch to use hrtimer_setup()
  PM / devfreq: rockchip-dfi: Switch to use hrtimer_setup()
  null_blk: Switch to use hrtimer_setup()
  hwrng: timeriomem: Switch to use hrtimer_setup()

 arch/arm/mach-imx/mmdc.c                       |  5 ++---
 arch/arm/mm/cache-l2x0-pmu.c                   |  3 +--
 arch/arm64/kvm/arch_timer.c                    |  7 +++----
 arch/loongarch/kvm/vcpu.c                      |  4 ++--
 arch/mips/kvm/mips.c                           |  5 ++---
 arch/powerpc/kernel/watchdog.c                 |  3 +--
 arch/powerpc/kvm/powerpc.c                     |  4 ++--
 arch/riscv/kvm/vcpu_timer.c                    |  7 ++++---
 arch/s390/kvm/interrupt.c                      |  3 +--
 arch/s390/kvm/kvm-s390.c                       |  4 ++--
 arch/x86/events/intel/uncore.c                 |  3 +--
 arch/x86/events/rapl.c                         |  3 +--
 arch/x86/kvm/hyperv.c                          |  3 +--
 arch/x86/kvm/i8254.c                           |  3 +--
 arch/x86/kvm/lapic.c                           |  5 ++---
 arch/x86/kvm/vmx/nested.c                      |  5 ++---
 arch/x86/kvm/xen.c                             |  5 ++---
 block/bfq-iosched.c                            |  5 ++---
 block/blk-iocost.c                             |  3 +--
 drivers/ata/pata_octeon_cf.c                   |  5 ++---
 drivers/base/power/runtime.c                   |  4 ++--
 drivers/block/null_blk/main.c                  |  7 +++----
 drivers/char/hw_random/timeriomem-rng.c        |  3 +--
 drivers/devfreq/event/rockchip-dfi.c           |  3 +--
 drivers/s390/crypto/ap_bus.c                   |  3 +--
 drivers/watchdog/softdog.c                     |  8 +++-----
 drivers/watchdog/watchdog_dev.c                |  4 ++--
 drivers/watchdog/watchdog_hrtimer_pretimeout.c |  4 ++--
 fs/timerfd.c                                   |  5 ++---
 fs/ubifs/io.c                                  |  3 +--
 io_uring/timeout.c                             | 13 ++++++-------
 kernel/bpf/helpers.c                           |  3 +--
 kernel/events/core.c                           |  7 +++----
 kernel/fork.c                                  |  3 +--
 kernel/rcu/tree.c                              |  4 ++--
 kernel/sched/core.c                            |  3 +--
 kernel/sched/deadline.c                        |  6 ++----
 kernel/sched/fair.c                            |  8 ++++----
 kernel/sched/rt.c                              |  5 ++---
 kernel/time/ntp.c                              |  3 +--
 kernel/time/posix-timers.c                     |  7 +++----
 kernel/time/sched_clock.c                      |  3 +--
 kernel/time/tick-broadcast-hrtimer.c           |  3 +--
 kernel/time/tick-sched.c                       |  6 ++----
 kernel/trace/trace_osnoise.c                   |  6 ++----
 kernel/watchdog.c                              |  3 +--
 lib/test_objpool.c                             |  3 +--
 47 files changed, 87 insertions(+), 128 deletions(-)

--=20
2.39.5


