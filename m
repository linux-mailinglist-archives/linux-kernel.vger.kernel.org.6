Return-Path: <linux-kernel+bounces-572340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F16A6C92F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 11:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28700188B037
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 10:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F2B1F5437;
	Sat, 22 Mar 2025 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeaNjBRO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12441EB5D7
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638964; cv=none; b=lOnNB0d4tyw28CT5kqWaDK2nQ5+d7lJzBW5xbDjkCELvUe55PN+m+ss/XB9oRjQLcjiJm4/fo0AqTVnuvVuSgSIe3VOFuxbDLjNJcuu39L1afkrIVRc2OiXxcgfr4Hv3KpL5kde4Y7SsZTMMbNtQLCbZw6xj2I4GtiwP5BYXz/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638964; c=relaxed/simple;
	bh=wOctItTP5JstmSA01y/K/Hwjo0SDiaw1hUvjXqfmtX4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jp+EtvfrxG6B/fqULlzlop8kBDTqJOjibX4Z64gZY6wU9h/rNFhBIauB7GK2Eumb3KjDSXg2NMxES3B1G9OMSUgmHir9Oh+LCt7bDzEzJZFELHGkfl53ZC5wpBRpdcfN495L9vj14YutziWbl6u7P49EFoyKeE9f9p5QoujktT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeaNjBRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D40FC4CEDD;
	Sat, 22 Mar 2025 10:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742638964;
	bh=wOctItTP5JstmSA01y/K/Hwjo0SDiaw1hUvjXqfmtX4=;
	h=Date:From:To:Cc:Subject:From;
	b=UeaNjBROiEOccBgt0u4YgN2LDZpv/+bfFaQU2R1+PNZAJ14vC+633V1j6EIKIfX09
	 HUWK0KTRoD6YjHCWPQwJSbJFQbyfc2dQiaEAubNiK3uevxu4V45X0H9LPl5AKS0bYJ
	 V/k7+8f9d/jUFJOThu0nTCSCsQ13Ibd9pC53g8+5fU2XDik+69Ag0/K7m8owkMKwT3
	 SMRk76Hfxce3FWxxM/z9KWTvPZV/6Ojx5JBqFk+dMDNmwDgvH6Ad2tVuZc/DOia0+e
	 Nzto4XEQK46L0x4UYymHniQLDzl6HkUnBweCnYKQTTUJiD5zU/jxLORuYJ+4W7MHv9
	 n+8T5lLgyHCCA==
Date: Sat, 22 Mar 2025 11:22:38 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] Scheduler updates for v6.15
Message-ID: <Z96PbgNRBu_LYr7t@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2025-03-22

   # HEAD: 3785c7dbae0f733f13f8857beaaada5d7dc63e02 cpuidle, sched: Use smp_mb__after_atomic() in current_clr_polling()

Scheduler updates for v6.15:

[ Merge note, these two commits are identical:

   - f3fa0e40df17 ("sched/clock: Don't define sched_clock_irqtime as static key")
   - b9f2b29b9494 ("sched: Don't define sched_clock_irqtime as static key")

  The first one is a cherry-picked version of the second, and the first one
  is already upstream. ]

Core & fair scheduler changes:

  - Cancel the slice protection of the idle entity (Zihan Zhou)
  - Reduce the default slice to avoid tasks getting an extra tick
    (Zihan Zhou)
  - Force propagating min_slice of cfs_rq when {en,de}queue tasks
    (Tianchen Ding)
  - Refactor can_migrate_task() to elimate looping (I Hsin Cheng)
  - Add unlikey branch hints to several system calls (Colin Ian King)
  - Optimize current_clr_polling() on certain architectures (Yujun Dong)

Deadline scheduler: (Juri Lelli)

  - Remove redundant dl_clear_root_domain call
  - Move dl_rebuild_rd_accounting to cpuset.h

Uclamp:

  - Use the uclamp_is_used() helper instead of open-coding it (Xuewen Yan)
  - Optimize sched_uclamp_used static key enabling (Xuewen Yan)

Scheduler topology support: (Juri Lelli)

  - Ignore special tasks when rebuilding domains
  - Add wrappers for sched_domains_mutex
  - Generalize unique visiting of root domains
  - Rebuild root domain accounting after every update
  - Remove partition_and_rebuild_sched_domains
  - Stop exposing partition_sched_domains_locked

RSEQ: (Michael Jeanson)

  - Update kernel fields in lockstep with CONFIG_DEBUG_RSEQ=y
  - Fix segfault on registration when rseq_cs is non-zero
  - selftests: Add rseq syscall errors test
  - selftests: Ensure the rseq ABI TLS is actually 1024 bytes

Membarriers:

  - Fix redundant load of membarrier_state (Nysal Jan K.A.)

Scheduler debugging:

  - Introduce and use preempt_model_str() (Sebastian Andrzej Siewior)
  - Make CONFIG_SCHED_DEBUG unconditional (Ingo Molnar)

Fixes and cleanups:

  - Always save/restore x86 TSC sched_clock() on suspend/resume
   (Guilherme G. Piccoli)

  - Misc fixes and cleanups (Thorsten Blum, Juri Lelli,
    Sebastian Andrzej Siewior)

 Thanks,

	Ingo

------------------>
Colin Ian King (1):
      sched: Add unlikey branch hints to several system calls

Guilherme G. Piccoli (1):
      x86/tsc: Always save/restore TSC sched_clock() on suspend/resume

I Hsin Cheng (1):
      sched/fair: Refactor can_migrate_task() to elimate looping

Ingo Molnar (6):
      sched/debug: Change SCHED_WARN_ON() to WARN_ON_ONCE()
      sched/debug: Make 'const_debug' tunables unconditional __read_mostly
      sched/debug: Make CONFIG_SCHED_DEBUG functionality unconditional
      sched/debug, Documentation: Remove (most) CONFIG_SCHED_DEBUG references from documentation
      sched/debug: Remove CONFIG_SCHED_DEBUG from self-test config files
      sched/debug: Remove CONFIG_SCHED_DEBUG

Juri Lelli (8):
      sched/deadline: Ignore special tasks when rebuilding domains
      sched/topology: Wrappers for sched_domains_mutex
      sched/deadline: Generalize unique visiting of root domains
      sched/deadline: Rebuild root domain accounting after every update
      sched/topology: Remove redundant dl_clear_root_domain call
      cgroup/cpuset: Remove partition_and_rebuild_sched_domains
      sched/topology: Stop exposing partition_sched_domains_locked
      include/{topology,cpuset}: Move dl_rebuild_rd_accounting to cpuset.h

Michael Jeanson (5):
      selftests/rseq: Add rseq syscall errors test
      rseq: Update kernel fields in lockstep with CONFIG_DEBUG_RSEQ=y
      rseq: Fix segfault on registration when rseq_cs is non-zero
      rseq/selftests: Ensure the rseq ABI TLS is actually 1024 bytes
      rseq/selftests: Fix namespace collision with rseq UAPI header

Nysal Jan K.A. (1):
      sched/membarrier: Fix redundant load of membarrier_state

Sebastian Andrzej Siewior (9):
      sched: Add a generic function to return the preemption string
      lib/dump_stack: Use preempt_model_str()
      arm: Rely on generic printing of preemption model
      arm64: Rely on generic printing of preemption model
      powerpc: Rely on generic printing of preemption model
      s390: Rely on generic printing of preemption model
      x86: Rely on generic printing of preemption model
      xtensa: Rely on generic printing of preemption model
      tracing: Use preempt_model_str()

Thorsten Blum (1):
      sched/core: Remove duplicate included header file stats.h

Tianchen Ding (1):
      sched/eevdf: Force propagating min_slice of cfs_rq when {en,de}queue tasks

Xuewen Yan (2):
      sched/uclamp: Use the uclamp_is_used() helper instead of open-coding it
      sched/uclamp: Optimize sched_uclamp_used static key enabling

Yafang Shao (1):
      sched: Don't define sched_clock_irqtime as static key

Yujun Dong (1):
      cpuidle, sched: Use smp_mb__after_atomic() in current_clr_polling()

zihan zhou (2):
      sched: Cancel the slice protection of the idle entity
      sched: Reduce the default slice to avoid tasks getting an extra tick


 Documentation/scheduler/sched-debug.rst            |   2 +-
 Documentation/scheduler/sched-design-CFS.rst       |   2 +-
 Documentation/scheduler/sched-domains.rst          |   5 +-
 Documentation/scheduler/sched-ext.rst              |   3 +-
 Documentation/scheduler/sched-stats.rst            |   2 +-
 .../sp_SP/scheduler/sched-design-CFS.rst           |   2 +-
 arch/arm/kernel/traps.c                            |  11 +-
 arch/arm64/kernel/traps.c                          |  10 +-
 arch/powerpc/kernel/traps.c                        |   3 +-
 arch/s390/kernel/dumpstack.c                       |   7 +-
 arch/x86/kernel/dumpstack.c                        |   9 +-
 arch/x86/kernel/tsc.c                              |   4 +-
 arch/xtensa/kernel/traps.c                         |   6 +-
 fs/proc/base.c                                     |   7 --
 include/linux/cpuset.h                             |  11 ++
 include/linux/energy_model.h                       |   2 -
 include/linux/preempt.h                            |   2 +
 include/linux/sched.h                              |   5 +
 include/linux/sched/deadline.h                     |   4 +
 include/linux/sched/debug.h                        |   2 -
 include/linux/sched/idle.h                         |  23 ++--
 include/linux/sched/mm.h                           |   7 ++
 include/linux/sched/topology.h                     |  14 ---
 include/trace/events/sched.h                       |   2 -
 kernel/cgroup/cpuset.c                             |  34 ++---
 kernel/rseq.c                                      | 140 +++++++++++++--------
 kernel/sched/build_utility.c                       |   4 +-
 kernel/sched/core.c                                | 112 +++++++++++------
 kernel/sched/core_sched.c                          |   2 +-
 kernel/sched/cputime.c                             |   8 +-
 kernel/sched/deadline.c                            |  51 ++++----
 kernel/sched/debug.c                               |  18 +--
 kernel/sched/ext.c                                 |   2 +-
 kernel/sched/fair.c                                | 131 ++++++++++---------
 kernel/sched/rt.c                                  |   9 +-
 kernel/sched/sched.h                               | 132 +++++++------------
 kernel/sched/stats.h                               |   2 +-
 kernel/sched/syscalls.c                            |  12 +-
 kernel/sched/topology.c                            |  45 +++----
 kernel/trace/trace.c                               |   7 +-
 lib/Kconfig.debug                                  |   9 --
 lib/dump_stack.c                                   |   4 +-
 tools/testing/selftests/rseq/.gitignore            |   1 +
 tools/testing/selftests/rseq/Makefile              |   9 +-
 tools/testing/selftests/rseq/rseq.c                |  27 ++--
 tools/testing/selftests/rseq/rseq.h                |   5 +
 .../selftests/rseq/run_syscall_errors_test.sh      |   5 +
 tools/testing/selftests/rseq/syscall_errors_test.c | 124 ++++++++++++++++++
 tools/testing/selftests/sched/config               |   2 +-
 tools/testing/selftests/sched_ext/config           |   1 -
 .../testing/selftests/wireguard/qemu/debug.config  |   1 -
 51 files changed, 595 insertions(+), 447 deletions(-)
 create mode 100755 tools/testing/selftests/rseq/run_syscall_errors_test.sh
 create mode 100644 tools/testing/selftests/rseq/syscall_errors_test.c

