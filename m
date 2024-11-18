Return-Path: <linux-kernel+bounces-413331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B822B9D1779
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B19285433
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846FF1BE226;
	Mon, 18 Nov 2024 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfThQ0bR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58F1101E6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731952552; cv=none; b=kQdry9S04H6z7VG8KwSXffA0vPU9DJ3RD2KABAscu49ly3esDQ0s5NroqRcsLKg16v3RnPW/CjHgBd9+RYPLBw77KYDVf4BNGb/2N11/+nrLFlXHrdQfIZ9xZDt2F0eJLtAEwmOkDqx2VZc6AXt3vGMhPKjxI5sfoJWyxr3IX84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731952552; c=relaxed/simple;
	bh=BMIWKiwktnsx0QpaXqCvaw4Fuf0XJoqeDaf/wmZQI2s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NilKsW47E9FRNkjSgOqp8yDbObIN/SZirxbY5P0gSRFCQZbXJsdkpBiT7FBXoJVboDjne7iL7aFk3pRqcvMyfaPO3/lPP8nn8zJbyc6HcOhG3Kr5FvOcDOWILNoBD9HT25U4CUZOzSxphxgMnWq1rQVjiEBKm1k6DcXImtLErFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfThQ0bR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414C3C4CECC;
	Mon, 18 Nov 2024 17:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731952552;
	bh=BMIWKiwktnsx0QpaXqCvaw4Fuf0XJoqeDaf/wmZQI2s=;
	h=Date:From:To:Cc:Subject:From;
	b=TfThQ0bR0FJrx/1xWFSg6lysb1DmYJ4aqYeQJ3ywP90xMs1mba/x3lGDwSChwqrge
	 DZCMu+1t4b5/T1pLukGY0whnUz5Tv3c0ljKQufg6YnbI/nd2zVnSh+s38UQ1xm5ak6
	 od+u8kdNb0L8GDnKZLQqErCuEqh7J0WLG8SA2r7WEhlpKarzx8k5rTAsAusjQDgDaS
	 F2RRBWTBZ74N5xRsSCdbY70TC6sslupQNjZ626zH/oqoinoYuR/7Dnv3LsyXa1SN4e
	 YJRqrPpmJHtvef+I8ozu0HhEKSMb219J5WiwFmzBU0zbV7KAtT5SqRV4Iy6uGjesLM
	 8V0MFCNmRhv+g==
Date: Mon, 18 Nov 2024 18:55:46 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] Scheduler changes for v6.13
Message-ID: <Zzt_or2E2KEypfbi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Linus,

Please pull the latest sched/core Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2024-11-18

   # HEAD: 771d271b2b908cf660d6789bb4355ed553250edc sched, x86: Update the comment for TIF_NEED_RESCHED_LAZY.

Scheduler changes for v6.13:

 - Core facilities:

    - Add the "Lazy preemption" model (CONFIG_PREEMPT_LAZY=y), which optimizes
      fair-class preemption by delaying preemption requests to the
      tick boundary, while working as full preemption for RR/FIFO/DEADLINE
      classes. (Peter Zijlstra)

        - x86:   Enable Lazy preemption (Peter Zijlstra)
        - riscv: Enable Lazy preemption (Jisheng Zhang)

    - Initialize idle tasks only once (Thomas Gleixner)

    - sched/ext: Remove sched_fork() hack (Thomas Gleixner)

 - Fair scheduler:
    - Optimize the PLACE_LAG when se->vlag is zero (Huang Shijie)

 - Idle loop:
      Optimize the generic idle loop by removing unnecessary
      memory barrier (Zhongqiu Han)

 - RSEQ:
    - Improve cache locality of RSEQ concurrency IDs for
      intermittent workloads (Mathieu Desnoyers)

 - Waitqueues:
    - Make wake_up_{bit,var} less fragile (Neil Brown)

 - PSI:
    - Pass enqueue/dequeue flags to psi callbacks directly (Johannes Weiner)

 - Preparatory patches for proxy execution:
    - core: Add move_queued_task_locked helper (Connor O'Brien)
    - core: Consolidate pick_*_task to task_is_pushable helper (Connor O'Brien)
    - core: Split out __schedule() deactivate task logic into a helper (John Stultz)
    - core: Split scheduler and execution contexts (Peter Zijlstra)
    - locking/mutex: Make mutex::wait_lock irq safe (Juri Lelli)
    - locking/mutex: Expose __mutex_owner() (Juri Lelli)
    - locking/mutex: Remove wakeups from under mutex::wait_lock (Peter Zijlstra)

 - Misc fixes and cleanups:
    - core: Remove unused __HAVE_THREAD_FUNCTIONS hook support (David Disseldorp)
    - core: Update the comment for TIF_NEED_RESCHED_LAZY (Sebastian Andrzej Siewior)
    - wait: Remove unused bit_wait_io_timeout (Dr. David Alan Gilbert)
    - fair: remove the DOUBLE_TICK feature (Huang Shijie)
    - fair: fix the comment for PREEMPT_SHORT (Huang Shijie)
    - uclamp: Fix unnused variable warning (Christian Loehle)
    - rt: No PREEMPT_RT=y for all{yes,mod}config

 Thanks,

	Ingo

------------------>
Christian Loehle (1):
      sched/uclamp: Fix unnused variable warning

Connor O'Brien (2):
      sched: Add move_queued_task_locked helper
      sched: Consolidate pick_*_task to task_is_pushable helper

David Disseldorp (1):
      sched: remove unused __HAVE_THREAD_FUNCTIONS hook support

Dr. David Alan Gilbert (1):
      sched/wait: Remove unused bit_wait_io_timeout

Huang Shijie (3):
      sched/fair: remove the DOUBLE_TICK feature
      sched/fair: optimize the PLACE_LAG when se->vlag is zero
      sched/fair: fix the comment for PREEMPT_SHORT

Ingo Molnar (1):
      fs/bcachefs: Fix __wait_on_freeing_inode() definition of waitqueue entry

Jisheng Zhang (1):
      riscv: add PREEMPT_LAZY support

Johannes Weiner (1):
      sched: psi: pass enqueue/dequeue flags to psi callbacks directly

John Stultz (1):
      sched: Split out __schedule() deactivate task logic into a helper

Juri Lelli (2):
      locking/mutex: Make mutex::wait_lock irq safe
      locking/mutex: Expose __mutex_owner()

Mathieu Desnoyers (1):
      sched: Improve cache locality of RSEQ concurrency IDs for intermittent workloads

NeilBrown (7):
      sched: change wake_up_bit() and related function to expect unsigned long *
      sched: Improve documentation for wake_up_bit/wait_on_bit family of functions
      sched: Document wait_var_event() family of functions and wake_up_var()
      sched: Add test_and_clear_wake_up_bit() and atomic_dec_and_wake_up()
      sched: Add wait/wake interface for variable updated under a lock.
      sched: add wait_var_event_io()
      softirq: use bit waits instead of var waits.

Peter Zijlstra (7):
      locking/mutex: Remove wakeups from under mutex::wait_lock
      sched: Split scheduler and execution contexts
      sched: Add TIF_NEED_RESCHED_LAZY infrastructure
      sched: Add Lazy preemption model
      sched: Enable PREEMPT_DYNAMIC for PREEMPT_RT
      sched, x86: Enable Lazy preemption
      sched: No PREEMPT_RT=y for all{yes,mod}config

Sebastian Andrzej Siewior (1):
      sched, x86: Update the comment for TIF_NEED_RESCHED_LAZY.

Thomas Gleixner (2):
      sched: Initialize idle tasks only once
      sched/ext: Remove sched_fork() hack

Zhongqiu Han (1):
      sched: idle: Optimize the generic idle loop by removing needless memory barrier


 arch/riscv/Kconfig                   |   1 +
 arch/riscv/include/asm/thread_info.h |  10 +-
 arch/x86/Kconfig                     |   1 +
 arch/x86/include/asm/thread_info.h   |   6 +-
 fs/exec.c                            |   2 +-
 include/linux/entry-common.h         |   3 +-
 include/linux/entry-kvm.h            |   5 +-
 include/linux/mm_types.h             |  72 +++++-
 include/linux/preempt.h              |   8 +-
 include/linux/sched.h                |   5 +-
 include/linux/sched/ext.h            |   1 -
 include/linux/sched/task_stack.h     |   2 +-
 include/linux/thread_info.h          |  21 +-
 include/linux/wait_bit.h             | 444 ++++++++++++++++++++++++++++-------
 kernel/Kconfig.preempt               |  27 ++-
 kernel/entry/common.c                |   2 +-
 kernel/entry/kvm.c                   |   4 +-
 kernel/fork.c                        |   2 +-
 kernel/futex/pi.c                    |   6 +-
 kernel/locking/mutex.c               |  59 ++---
 kernel/locking/mutex.h               |  27 +++
 kernel/locking/rtmutex.c             |  51 ++--
 kernel/locking/rtmutex_api.c         |  12 +-
 kernel/locking/rtmutex_common.h      |   3 +-
 kernel/locking/rwbase_rt.c           |   8 +-
 kernel/locking/rwsem.c               |   4 +-
 kernel/locking/spinlock_rt.c         |   5 +-
 kernel/locking/ww_mutex.h            |  51 ++--
 kernel/sched/core.c                  | 289 +++++++++++++++--------
 kernel/sched/deadline.c              |  57 ++---
 kernel/sched/debug.c                 |   7 +-
 kernel/sched/ext.c                   |   7 +-
 kernel/sched/fair.c                  |  42 ++--
 kernel/sched/features.h              |   3 +-
 kernel/sched/idle.c                  |   1 -
 kernel/sched/pelt.c                  |   2 +-
 kernel/sched/rt.c                    |  67 +++---
 kernel/sched/sched.h                 | 155 ++++++++----
 kernel/sched/stats.h                 |  29 ++-
 kernel/sched/syscalls.c              |   4 +-
 kernel/sched/wait_bit.c              |  90 ++++---
 kernel/softirq.c                     |  14 +-
 42 files changed, 1105 insertions(+), 504 deletions(-)

