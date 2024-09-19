Return-Path: <linux-kernel+bounces-333379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1753697C79C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 12:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F4E5B26AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9DE17798F;
	Thu, 19 Sep 2024 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhfBSlHe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727F1FC0C
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726740035; cv=none; b=icjmPcaDYAXLrrAbEPFQHxF1ptko4TTrILtDtd5bRxql719Rf97TQ5i7trNjOAaz3oxAaGlDTc1O/oL4gkbYoVgWJ1h1cwQQ3TNyZ8WB3iZ3r0VEPGfWVfTAkRIYmNYVGI9+zjyMHkPMlUIvPdaNDrwBdGsgKXlQHkB80et9OAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726740035; c=relaxed/simple;
	bh=uyxz21hd8RXJkJGz/3EdhbMYCQPKyTGyE3rfOHdovos=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ec1yxt/U4adRq/LhVK1sQ+0ZZ0KFHI6msOWZtmwN1OGZXRtnPRKjs6okdxe05ZEssaqN2oi2vtTWPNrahxxBVRXKIVkIP+bOIzRGGjBJKkkJZjj+t6Rstj3vC0zYBsVNKaNg55+bsI/ssE9b522wRkDE3YdebEbu63jP6/UI1W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhfBSlHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A7CC4CEC4;
	Thu, 19 Sep 2024 10:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726740035;
	bh=uyxz21hd8RXJkJGz/3EdhbMYCQPKyTGyE3rfOHdovos=;
	h=Date:From:To:Cc:Subject:From;
	b=EhfBSlHeBCA3MzSzHqtzpqJFFVYLrqd6XSGbmD0S+xzPIVGbhFsDE40a9EJojN4Q4
	 nNUPzWv/EugyOmUCK6UbReVfUbepUA4jqMBa4ZXn8dKYZcvqd0Z+nhOsvjrGOL0mPh
	 k+KHOhCg3MQYfPm70Kc9Cy+IYqBRYKmDCxeGxUzql6BVlsmLGr2ySWmit87S21KT7s
	 Hz/xGZlbBwpoNGhNzoe1eVsBVfpEXIrOT7pZBc022gmotgZ+nieLQPwemhelEw6ePx
	 gBldzQd0wfhKQSWxKFBAoQHeG/ghPpfQPlpnLcalPRzEcw8zmQoNk3DdYgjw0C1Oce
	 JDl/RlFuAGmTg==
Date: Thu, 19 Sep 2024 12:00:29 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [GIT PULL] Scheduler changes for v6.12
Message-ID: <Zuv2PZQ1GWpxhQB9@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2024-09-19

   # HEAD: bc9057da1a220ff2cb6c8885fd5352558aceba2c sched/cpufreq: Use NSEC_PER_MSEC for deadline task

Merge conflict notes:

   #
   # The freshly merged timer tree changes cause direct conflicts in two files
   #  and semantic conflicts in three files due to API changes:
   #
   #    Conflicts:
   #            fs/select.c
   #            kernel/time/hrtimer.c
   #    
   #    Semantic conflicts:
   #            fs/proc/base.c
   #            kernel/sched/syscalls.c
   #            kernel/sys.c
   #
   # To double check, see my tentative merge resolution in adf04642e625:
   #
   #   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/merge
   #

In the v6.12 scheduler development cycle we had 63 commits from 18 contributors:

 - Implement the SCHED_DEADLINE server infrastructure - Daniel Bristot de Oliveira's
   last major contribution to the kernel:

     "SCHED_DEADLINE servers can help fixing starvation issues of low priority
     tasks (e.g., SCHED_OTHER) when higher priority tasks monopolize CPU
     cycles. Today we have RT Throttling; DEADLINE servers should be able to
     replace and improve that."

     (Daniel Bristot de Oliveira, Peter Zijlstra, Joel Fernandes,
      Youssef Esmat, Huang Shijie)

 - Preparatory changes for sched_ext integration:

     - Use set_next_task(.first) where required
     - Fix up set_next_task() implementations
     - Clean up DL server vs. core sched
     - Split up put_prev_task_balance()
     - Rework pick_next_task()
     - Combine the last put_prev_task() and the first set_next_task()
     - Rework dl_server
     - Add put_prev_task(.next)

      (Peter Zijlstra, with a fix by Tejun Heo)

 - Complete the EEVDF transition and refine EEVDF scheduling:

     - Implement delayed dequeue
     - Allow shorter slices to wakeup-preempt
     - Use sched_attr::sched_runtime to set request/slice suggestion
     - Document the new feature flags
     - Remove unused and duplicate-functionality fields
     - Simplify & unify pick_next_task_fair()
     - Misc debuggability enhancements

      (Peter Zijlstra, with fixes/cleanups by Dietmar Eggemann,
       Valentin Schneider and Chuyi Zhou)

 - Initialize the vruntime of a new task when it is first enqueued,
   resulting in significant decrease in latency of newly woken tasks.
   (Zhang Qiao)

 - Introduce SM_IDLE and an idle re-entry fast-path in __schedule()
   (K Prateek Nayak, Peter Zijlstra)

 - Clean up and clarify the usage of Clean up usage of rt_task()
   (Qais Yousef)

 - Preempt SCHED_IDLE entities in strict cgroup hierarchies
   (Tianchen Ding)

 - Clarify the documentation of time units for deadline scheduler
   parameters. (Christian Loehle)

 - Remove the HZ_BW chicken-bit feature flag introduced a year ago,
   the original change seems to be working fine.
   (Phil Auld)

 - Misc fixes and cleanups (Chen Yu, Dan Carpenter, Huang Shijie,
   Peilin He, Qais Yousefm and Vincent Guittot)

 Thanks,

	Ingo

------------------>
Chen Yu (2):
      sched/pelt: Use rq_clock_task() for hw_pressure
      kthread: Fix task state in kthread worker if being frozen

Christian Loehle (4):
      sched/deadline: Convert schedtool example to chrt
      sched/deadline: Clarify nanoseconds in uapi
      cpufreq/cppc: Use NSEC_PER_MSEC for deadline task
      sched/cpufreq: Use NSEC_PER_MSEC for deadline task

Chuyi Zhou (1):
      sched/fair: Remove cfs_rq::nr_spread_over and cfs_rq::exec_clock

Dan Carpenter (1):
      sched/debug: Fix fair_server_period_max value

Daniel Bristot de Oliveira (3):
      sched/deadline: Comment sched_dl_entity::dl_server variable
      sched/deadline: Deferrable dl server
      sched/fair: Fair server interface

Dietmar Eggemann (1):
      kernel/sched: Fix util_est accounting for DELAY_DEQUEUE

Huang Shijie (2):
      sched/deadline: Fix schedstats vs deadline servers
      sched/debug: Fix the runnable tasks output

Joel Fernandes (Google) (3):
      sched/core: Add clearing of ->dl_server in put_prev_task_balance()
      sched/core: Fix priority checking for DL server picks
      sched/core: Fix picking of tasks for core scheduling with DL server

Peilin He (1):
      sched/core: Add WARN_ON_ONCE() to check overflow for migrate_disable()

Peter Zijlstra (36):
      sched/fair: Add trivial fair server
      sched/rt: Remove default bandwidth control
      sched/fair: Cleanup fair_server
      sched/eevdf: Add feature comments
      sched/eevdf: Remove min_vruntime_copy
      sched/fair: Cleanup pick_task_fair() vs throttle
      sched/fair: Cleanup pick_task_fair()'s curr
      sched/fair: Unify pick_{,next_}_task_fair()
      sched: Allow sched_class::dequeue_task() to fail
      sched/fair: Re-organize dequeue_task_fair()
      sched: Split DEQUEUE_SLEEP from deactivate_task()
      sched: Prepare generic code for delayed dequeue
      sched/uclamg: Handle delayed dequeue
      sched/fair: Assert {set_next,put_prev}_entity() are properly balanced
      sched/fair: Prepare exit/cleanup paths for delayed_dequeue
      sched/fair: Prepare pick_next_task() for delayed dequeue
      sched/fair: Implement ENQUEUE_DELAYED
      sched,freezer: Mark TASK_FROZEN special
      sched: Teach dequeue_task() about special task states
      sched/fair: Implement delayed dequeue
      sched/fair: Implement DELAY_ZERO
      sched/eevdf: Fixup PELT vs DELAYED_DEQUEUE
      sched/fair: Avoid re-setting virtual deadline on 'migrations'
      sched/eevdf: Allow shorter slices to wakeup-preempt
      sched/eevdf: Use sched_attr::sched_runtime to set request/slice suggestion
      sched/eevdf: Propagate min_slice up the cgroup hierarchy
      sched: Use set_next_task(.first) where required
      sched: Fixup set_next_task() implementations
      sched: Clean up DL server vs core sched
      sched: Split up put_prev_task_balance()
      sched: Rework pick_next_task()
      sched: Combine the last put_prev_task() and the first set_next_task()
      sched: Rework dl_server
      sched: Add put_prev_task(.next)
      sched/core: Introduce SM_IDLE and an idle re-entry fast-path in __schedule()
      sched: Fix sched_delayed vs sched_core

Phil Auld (1):
      sched: remove HZ_BW feature hedge

Qais Yousef (3):
      sched/rt: Clean up usage of rt_task()
      sched/rt, dl: Convert functions to return bool
      sched/rt: Rename realtime_{prio, task}() to rt_or_dl_{prio, task}()

Tejun Heo (1):
      sched/fair: Make balance_fair() test sched_fair_runnable() instead of rq->nr_running

Tianchen Ding (1):
      sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy

Valentin Schneider (1):
      sched/fair: Properly deactivate sched_delayed task upon class change

Vincent Guittot (1):
      sched/fair: Move effective_cpu_util() and effective_cpu_util() in fair.c

Youssef Esmat (1):
      sched/core: Clear prev->dl_server in CFS pick fast path

Zhang Qiao (1):
      sched: Initialize the vruntime of a new task when it is first enqueued


 Documentation/scheduler/sched-deadline.rst |  14 +-
 drivers/cpufreq/cppc_cpufreq.c             |   6 +-
 fs/bcachefs/six.c                          |   2 +-
 fs/select.c                                |   2 +-
 include/linux/ioprio.h                     |   2 +-
 include/linux/sched.h                      |  28 +-
 include/linux/sched/deadline.h             |  14 +-
 include/linux/sched/prio.h                 |   1 +
 include/linux/sched/rt.h                   |  33 +-
 include/uapi/linux/sched/types.h           |   6 +-
 kernel/freezer.c                           |   2 +-
 kernel/kthread.c                           |  10 +-
 kernel/locking/rtmutex.c                   |   4 +-
 kernel/locking/rwsem.c                     |   4 +-
 kernel/locking/ww_mutex.h                  |   2 +-
 kernel/sched/core.c                        | 248 +++++++---
 kernel/sched/cpufreq_schedutil.c           |   6 +-
 kernel/sched/deadline.c                    | 503 +++++++++++++++----
 kernel/sched/debug.c                       | 198 +++++++-
 kernel/sched/fair.c                        | 770 ++++++++++++++++++++++-------
 kernel/sched/features.h                    |  30 +-
 kernel/sched/idle.c                        |  23 +-
 kernel/sched/rt.c                          | 261 +++++-----
 kernel/sched/sched.h                       | 101 +++-
 kernel/sched/stop_task.c                   |  18 +-
 kernel/sched/syscalls.c                    | 132 +----
 kernel/sched/topology.c                    |   8 +
 kernel/time/hrtimer.c                      |   6 +-
 kernel/trace/trace_sched_wakeup.c          |   2 +-
 mm/page-writeback.c                        |   4 +-
 mm/page_alloc.c                            |   2 +-
 31 files changed, 1695 insertions(+), 747 deletions(-)

