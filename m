Return-Path: <linux-kernel+bounces-384240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBA09B28B8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33B11C212FC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE4A190692;
	Mon, 28 Oct 2024 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qMTr6eyB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0sYGRQoB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B10B524C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100603; cv=none; b=BGM/jpv8uk4S0eu5RNMMGjf3CiR+spluJMNsMRcqK1uNcyIbV/ZVlKIxle7gPVBbGMP5Z5/MhyugYIjw5qbQKQiyqEg2r8gKDNGl9dn9f5P9EWGPvU5IBZlvKIL0V6Ru/ZLfNbMP+nKhhhypyE/DEKFEa0AdjPaeUpaxbJ8C3BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100603; c=relaxed/simple;
	bh=WsvXsDM8x64kJMhYpKoTasaKYFjgzj3c3Z5JAqOL8iU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Brx79c22YLFZpHVpsUO3Vj+UyhudCMgqHt/+bJ7i+4IE2Aek51UAPp76hNyHuR7VPVlpde51AWlf7dFfZipab4opNkXFp4Hkk3/ldb4Iw2kuA91lHpPAL9tlNcjFn9FFiyJ7901LPG+4M/3felBJo6BAo96u4/XN8F5IVp1F95I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qMTr6eyB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0sYGRQoB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FXUgt+H700FXJg4w3V9XaXZbVUdNyJP1SKRadounI9M=;
	b=qMTr6eyBWwjLLLifnANyHDQSHGjYKy356JZLb1tmUUquAmeMtREOX/k5DdLDCrBqtmi322
	e8iRgf2DQeFviKjE23dUSQGWrc9rRh463GfOq6MgCDPFeEDHa3ABLhUCZbHWlmDIL42Zy3
	m7/pR/TCK8ENOWXVwchaQK+h+rQGceJRjUipV728hhDZgi5M2GnUi/uwyWW6Wmpo43ayWn
	DXvI9rI42i3x7S/etWNuir99ddZ9kz2WLIFK72ms6zF+T9nyGYPV/gy4uPNgjaLwBwK2M2
	ssQ3CRJgU+hMM7ZV6kd3g72TNf2gHZBinB1ik/SzSpPOsozFptRlczrvBfVHAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FXUgt+H700FXJg4w3V9XaXZbVUdNyJP1SKRadounI9M=;
	b=0sYGRQoBKEmN2ILp4CJdL3GFNnosxrtlyV69+kgy7udh/CcvAd0Ha4lp+rGSBqWWtPOOs8
	SeMyD53l3XWVDkCg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	x86@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Kalle Valo <kvalo@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>
Subject: [PATCH 00/21] hrtimers: Switch to new hrtimer interface functions (1/5)
Date: Mon, 28 Oct 2024 08:29:19 +0100
Message-Id: <cover.1729864615.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is the first part of a 5-part series (split for convenience). All 5
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
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: x86@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: John Stultz <jstultz@google.com>

Nam Cao (21):
  hrtimers: Add missing hrtimer_init event trace points
  hrtimers: Remove unused hrtimer_init_sleeper()
  drm/i915/request: Remove unnecessary abuse of hrtimer::function
  KVM: x86/xen: Initialize hrtimer in kvm_xen_init_vcpu()
  can: bcm: Don't initialized an unused hrtimer
  wifi: rt2x00: Remove redundant hrtimer_init()
  io_uring: Remove redundant hrtimer's callback function setup
  hrtimers: Introduce hrtimer_setup() to replace hrtimer_init()
  hrtimers: Introduce hrtimer_setup_on_stack()
  hrtimers: Introduce hrtimer_setup_sleeper_on_stack()
  hrtimers: Introduce hrtimer_update_function()
  fs/aio: Switch to use hrtimer_setup_sleeper_on_stack()
  futex: Switch to use hrtimer_setup_sleeper_on_stack()
  net: pktgen: Switch to use hrtimer_setup_sleeper_on_stack()
  timers: Switch to use hrtimer_setup_sleeper_on_stack()
  wait: Switch to use hrtimer_setup_sleeper_on_stack()
  hrtimers: Delete hrtimer_init_sleeper_on_stack()
  sched/idle: Switch to use hrtimer_setup_on_stack()
  io_uring: Switch to use hrtimer_setup_on_stack()
  alarmtimer: Switch to use hrtimer_setup() and hrtimer_setup_on_stack()
  hrtimers: Delete hrtimer_init_on_stack()

 arch/x86/kvm/xen.c                            |   4 +-
 drivers/gpu/drm/i915/i915_request.c           |  17 +--
 .../net/wireless/ralink/rt2x00/rt2x00usb.c    |   2 -
 fs/aio.c                                      |   2 +-
 include/linux/hrtimer.h                       |  51 ++++----
 include/linux/wait.h                          |   4 +-
 io_uring/io_uring.c                           |   7 +-
 io_uring/timeout.c                            |   1 -
 kernel/futex/core.c                           |   6 +-
 kernel/sched/idle.c                           |   4 +-
 kernel/time/alarmtimer.c                      |   9 +-
 kernel/time/hrtimer.c                         | 110 +++++++++++++-----
 kernel/time/sleep_timeout.c                   |   2 +-
 net/can/bcm.c                                 |  19 ++-
 net/core/pktgen.c                             |   2 +-
 15 files changed, 143 insertions(+), 97 deletions(-)

--=20
2.39.5


