Return-Path: <linux-kernel+bounces-412610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47E29D0B59
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65118282887
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDCF161302;
	Mon, 18 Nov 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ob59wJak"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CA12907
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731920626; cv=none; b=bM32mGScoIFKPqE4a4w7q0/YSsUOJNeLNNksYxmpOQq9HNCvOQ9iPjLnwQNcwjMZkhq11UcM1PoF4gA6DR2RtE6aiQlajClc36BvYaTI2hh3Nyhn1NzEsDrXfjQnPa8NsyrU313LxWLlqvTxYZ1whClcEZSwU6jXyHNpeKmEs3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731920626; c=relaxed/simple;
	bh=SPLHhyfMcYNJIihTAb++6ZxHd/96Bu1vqadZjuhb/v0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UeZ/9Gee6zWw0Qf5VRFzT4ah+QZfYWXzJcokPGfR3SoFblzsvPxEHJBXn9IvxQM6o7FQzDRz9laMcpedjR9tCwdkQWiW8PmqdreIKcsw07rNneb0neU80lxW2dsuGa00JdYjGLojisgprX5xkBdBgo69F9y0N5CQmcroqJRiSrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ob59wJak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC9BC4CED6;
	Mon, 18 Nov 2024 09:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731920625;
	bh=SPLHhyfMcYNJIihTAb++6ZxHd/96Bu1vqadZjuhb/v0=;
	h=Date:From:To:Cc:Subject:From;
	b=ob59wJak6oYW1Q0BXf/fJxAVzzQ9vSXyUNGYzotHOlbBABjRKyJofMg0AUJrNusSo
	 QQYjWMyb82IL3soDfgl24O8qKTofSwxE2qTMPoUenlH6m2Rzielp60bLOa2tGxHUML
	 N0wYhNv5NTjq5ISctwcvzgbSzZAQkr0fzhPbmmQYS/55/JgJkYVIA10WxsKX/dyxMO
	 kLF6VrYYSK/MIhd+Ct1ADeU1xE8Qg0JE3R57xybzNQDsPHW4WgM3AHzWKkJhEnmXDW
	 3NKERTEh+4DVvYpuOTrEYR/eL2QSqJIS/dZbbm971J51PwY8Yx+br11M6LyRRFYKh3
	 rOf1v8Pyo46YQ==
Date: Mon, 18 Nov 2024 10:03:40 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] locking changes for v6.13
Message-ID: <ZzsC7HOiJ8Mwk8D6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Linus,

Please pull the latest locking/core Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2024-11-18

   # HEAD: 3b49a347d751553b1d1be69c8619ae2e85fdc28d locking/Documentation: Fix grammar in percpu-rw-semaphore.rst

Locking changes for v6.13 are:

 - lockdep:
    - Enable PROVE_RAW_LOCK_NESTING with PROVE_LOCKING (Sebastian Andrzej Siewior)
    - Add lockdep_cleanup_dead_cpu() (David Woodhouse)

 - futexes:
    - Use atomic64_inc_return() in get_inode_sequence_number() (Uros Bizjak)
    - Use atomic64_try_cmpxchg_relaxed() in get_inode_sequence_number() (Uros Bizjak)

 - RT locking:
    - Add sparse annotation PREEMPT_RT's locking (Sebastian Andrzej Siewior)

 - spinlocks:
    - Use atomic_try_cmpxchg_release() in osq_unlock() (Uros Bizjak)

 - atomics:
    - x86: Use ALT_OUTPUT_SP() for __alternative_atomic64() (Uros Bizjak)
    - x86: Use ALT_OUTPUT_SP() for __arch_{,try_}cmpxchg64_emu() (Uros Bizjak)

 - KCSAN, seqlocks:
    - Support seqcount_latch_t (Marco Elver)

 - <linux/cleanup.h>:
    - Add if_not_cond_guard() conditional guard helper (David Lechner)
    - Adjust scoped_guard() macros to avoid potential warning (Przemek Kitszel)
    - Remove address space of returned pointer (Uros Bizjak)

 - WW mutexes:
    - locking/ww_mutex: Adjust to lockdep nest_lock requirements (Thomas Hellström)

 - Rust integration:
    - Fix raw_spin_lock initialization on PREEMPT_RT (Eder Zulian)

 - miscellaneous cleanups & fixes:
    - lockdep: Fix wait-type check related warnings (Ahmed Ehab)
    - lockdep: Use info level for initial info messages (Jiri Slaby)
    - spinlocks: Make __raw_* lock ops static (Geert Uytterhoeven)
    - pvqspinlock: Convert fields of 'enum vcpu_state' to uppercase (Qiuxu Zhuo)
    - iio: magnetometer: Fix if () scoped_guard() formatting (Stephen Rothwell)
    - rtmutex: Fix misleading comment (Peter Zijlstra)
    - percpu-rw-semaphores: Fix grammar in percpu-rw-semaphore.rst (Xiu Jianfeng)

 Thanks,

	Ingo

------------------>
Ahmed Ehab (2):
      locking/lockdep: Avoid creating new name string literals in lockdep_set_subclass()
      locking/lockdep: Add a test for lockdep_set_subclass()

David Lechner (1):
      cleanup: Add conditional guard helper

David Woodhouse (1):
      lockdep: Add lockdep_cleanup_dead_cpu()

Eder Zulian (1):
      rust: helpers: Avoid raw_spin_lock initialization for PREEMPT_RT

Geert Uytterhoeven (1):
      locking/spinlocks: Make __raw_* lock ops static

Jiri Slaby (SUSE) (1):
      lockdep: Use info level for lockdep initial info messages

Marco Elver (5):
      time/sched_clock: Swap update_clock_read_data() latch writes
      time/sched_clock: Broaden sched_clock()'s instrumentation coverage
      kcsan, seqlock: Support seqcount_latch_t
      seqlock, treewide: Switch to non-raw seqcount_latch interface
      kcsan, seqlock: Fix incorrect assumption in read_seqbegin()

Peter Zijlstra (1):
      locking/rtmutex: Fix misleading comment

Przemek Kitszel (1):
      cleanup: Adjust scoped_guard() macros to avoid potential warning

Qiuxu Zhuo (1):
      locking/pvqspinlock: Convert fields of 'enum vcpu_state' to uppercase

Sebastian Andrzej Siewior (5):
      lockdep: Enable PROVE_RAW_LOCK_NESTING with PROVE_LOCKING.
      locking/rt: Add sparse annotation PREEMPT_RT's sleeping locks.
      locking/rt: Remove one __cond_lock() in RT's spin_trylock_irqsave()
      locking/rt: Add sparse annotation for RCU.
      locking/rt: Annotate unlock followed by lock for sparse.

Stephen Rothwell (1):
      iio: magnetometer: fix if () scoped_guard() formatting

Thomas Hellström (1):
      locking/ww_mutex: Adjust to lockdep nest_lock requirements

Uros Bizjak (6):
      futex: Use atomic64_inc_return() in get_inode_sequence_number()
      futex: Use atomic64_try_cmpxchg_relaxed() in get_inode_sequence_number()
      cleanup: Remove address space of returned pointer
      locking/osq_lock: Use atomic_try_cmpxchg_release() in osq_unlock()
      locking/atomic/x86: Use ALT_OUTPUT_SP() for __alternative_atomic64()
      locking/atomic/x86: Use ALT_OUTPUT_SP() for __arch_{,try_}cmpxchg64_emu()

Xiu Jianfeng (1):
      locking/Documentation: Fix grammar in percpu-rw-semaphore.rst


 Documentation/locking/percpu-rw-semaphore.rst |  4 +-
 Documentation/locking/seqlock.rst             |  2 +-
 arch/x86/include/asm/atomic64_32.h            |  3 +-
 arch/x86/include/asm/cmpxchg_32.h             |  6 +-
 arch/x86/kernel/tsc.c                         |  5 +-
 drivers/iio/magnetometer/af8133j.c            |  3 +-
 include/linux/cleanup.h                       | 69 ++++++++++++++++---
 include/linux/irqflags.h                      |  6 ++
 include/linux/lockdep.h                       |  2 +-
 include/linux/rbtree_latch.h                  | 20 +++---
 include/linux/rwlock_rt.h                     | 10 +--
 include/linux/seqlock.h                       | 98 ++++++++++++++++++++-------
 include/linux/spinlock_rt.h                   | 28 ++++----
 include/linux/ww_mutex.h                      | 14 ++++
 kernel/cpu.c                                  |  1 +
 kernel/futex/core.c                           |  6 +-
 kernel/locking/lockdep.c                      | 46 ++++++++++---
 kernel/locking/osq_lock.c                     |  3 +-
 kernel/locking/qspinlock_paravirt.h           | 36 +++++-----
 kernel/locking/rtmutex.c                      |  2 +
 kernel/locking/rtmutex_api.c                  |  8 +--
 kernel/locking/spinlock.c                     |  8 +--
 kernel/locking/spinlock_rt.c                  | 14 ++--
 kernel/locking/test-ww_mutex.c                |  8 ++-
 kernel/printk/printk.c                        |  9 +--
 kernel/time/sched_clock.c                     | 34 +++++++---
 kernel/time/timekeeping.c                     | 12 ++--
 lib/Kconfig.debug                             | 12 +---
 lib/locking-selftest.c                        | 39 +++++++++++
 rust/helpers/spinlock.c                       |  8 ++-
 30 files changed, 355 insertions(+), 161 deletions(-)

