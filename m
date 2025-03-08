Return-Path: <linux-kernel+bounces-552619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A1AA57C12
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CEFF1891D64
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027E2383A2;
	Sat,  8 Mar 2025 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lAMgb41m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x4k/D6Zh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A5F14A8B
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741452493; cv=none; b=GIBGLgkwlqEpOKgenYjZSMhwJg9EogqZXEgHiYYtfNo+Y4lNh8eG8BQmYUULlmegyJfmhh3wRO8XsPl4bJE6AZkUQhXptLNecDMDTqsfWvoaG94kcBgsjmwtdcKRWGoIh0Kir2BagAIzojN2SgwbXGdZXnNwzcTk2XucYLTzbQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741452493; c=relaxed/simple;
	bh=e5seaU7h1fj0s7e2+Jy9DxE9AIHEi+Ig9RGIaLfbV3k=;
	h=Message-ID:From:To:Cc:Subject:Date; b=dnmsgMJblRlVzr3maxUTk08mR4bIbG9g6qSB/cpHjrSc8bty8rwJ0etvCKVlrejccDYF7Rd9kgcQLf0aFmhGLMR2aScJcZO5i/63JlR0edAfJEVw0ktfCofiZpEMegJk6L/DlrO2hVwECnrKXM8iyVZOCKuP0dbbjMEA0xxPvrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lAMgb41m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x4k/D6Zh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250308155501.391430556@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741452489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=CoM3wh12g6yZC2LPhjGodXFuF2yIHF+8b08AHc2hs+s=;
	b=lAMgb41mXKPUlf54JlYWoVIOQtKSgOigMR0VMEEzFaM2RGJCUOPWuhH2UNGuwRI7nv/AK7
	xu7S4H3/qqscIrb+H5+4yLtZusBGlv68RTyjEMXqE0yeVjW6Xbr/6bRlPSU943nd96F6Vh
	ODYlbC1GAXUUDCcG2VuYg5rYc44i4izdA7dZYT7FZsRb1PCzXLHT1O8QfvldXX8C2vWWdF
	pqHs5QZxJh4boDlBEADH6Nh/EDxIVPhOehYARgKc07gzdq6/iLlzzdGq24bBS7g4m7VpzV
	xcMY7ZsnIyQF79CuI+UANJaE5JQvodBz+Qzd9xIhiWRIVbKH4xSLuS8Bhuaveg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741452489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=CoM3wh12g6yZC2LPhjGodXFuF2yIHF+8b08AHc2hs+s=;
	b=x4k/D6ZhrDE6gSJ2bvsOvF4FB1mX/WciYv5sLvYXUXmZu1ewpo0Xllf9QklasZePuGQDfm
	SbEIgUXx3tUGH8Cg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Cyrill Gorcunov <gorcunov@gmail.com>
Subject: [patch V3 00/18] posix-timers: Rework the global hash table and
 provide a sane mechanism for CRIU
Date: Sat,  8 Mar 2025 17:48:08 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a follow up on V2 of this work, which can be found here:

     https://lore.kernel.org/all/20250224095736.145530367@linutronix.de

It addresses the scalability problem of the posix timer hash and provides a
performant mechanism to restore Posix timers with a given ID along with a
couple of preperatory cleanups and enhancements. More details about
implementation choices are in the change logs and the cover letter of V1:

     https://lore.kernel.org/all/20250302185753.311903554@linutronix.de

Changes vs. V2:

  - Ensure consistency on timer_create() (new patch) - Frederic
  - Pick up the lock_timer() conditional unlock fix (was V2a)
  - Use proper defines in selftests
  - Pick up review/ack tags

The series survives all posix timer tests and did not show any regressions
so far.

The series is based on:

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip timers/core

and is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git timers/posix

Thanks,

	tglx
---
Eric Dumazet (3):
      posix-timers: Initialise timer before adding it to the hash table
      posix-timers: Add cond_resched() to posix_timer_add() search loop
      posix-timers: Make signal_struct:: Next_posix_timer_id an atomic_t

Peter Zijlstra (1):
      posix-timers: Make lock_timer() use guard()

Thomas Gleixner (14):
      posix-timers: Ensure that timer initialization is fully visible
      posix-timers: Cleanup includes
      posix-timers: Remove a few paranoid warnings
      posix-timers: Remove SLAB_PANIC from kmem cache
      posix-timers: Use guards in a few places
      posix-timers: Simplify lock/unlock_timer()
      posix-timers: Rework timer removal
      posix-timers: Improve hash table performance
      posix-timers: Switch to jhash32()
      posix-timers: Avoid false cacheline sharing
      posix-timers: Make per process list RCU safe
      posix-timers: Dont iterate /proc/$PID/timers with sighand:: Siglock held
      posix-timers: Provide a mechanism to allocate a given timer ID
      selftests/timers/posix-timers: Add a test for exact allocation mode


 fs/proc/base.c                                |   48 --
 include/linux/cleanup.h                       |   22 -
 include/linux/posix-timers.h                  |   30 +
 include/linux/sched/signal.h                  |    3 
 include/uapi/linux/prctl.h                    |   10 
 kernel/signal.c                               |    2 
 kernel/sys.c                                  |    5 
 kernel/time/posix-timers.c                    |  540 +++++++++++++-------------
 tools/testing/selftests/timers/posix_timers.c |   66 +++
 9 files changed, 418 insertions(+), 308 deletions(-)

