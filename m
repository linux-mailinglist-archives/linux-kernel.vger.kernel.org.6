Return-Path: <linux-kernel+bounces-416493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3689D45D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24E62855AC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394107F477;
	Thu, 21 Nov 2024 02:44:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34E241C79
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732157097; cv=none; b=Pq+nv5YXJrO2qzHEJzF4NHCD4rqal/CcP2jc2y6AeyLiNpTUlNQLd0/bhRc5HM1bVhZH/Pnj0X5/N3NhjM4fR9/+J60hDF73dTIOt5bwUjkMoT4EN5qvCtwtd3OjtVUwpqmt6Cfp7Cs+X47A5ay8T2J9KtPWX4vcbhMWpqmhuaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732157097; c=relaxed/simple;
	bh=k6tEZwa+4NI6XVFBy565uApJHmJ7HIo9yYJXD8C/V38=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MlzKDVpRRBe0MMo7YZYLKpU5+bP5tIgm+qLUjpIiia8ftk9NMukNq/6J8kmAwxBh80/d2ggxCM5qf6qTJ7keRK8uw7JXC61V+WaZ6Pv5RvNHPyR9FxfMg54AFWmPh0iOAm9U9yyPqd+KuH+D+5FT6cRR+HdBFDxmoKks7IZl/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037DCC4CECD;
	Thu, 21 Nov 2024 02:44:54 +0000 (UTC)
Date: Wed, 20 Nov 2024 21:45:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Colin Ian King
 <colin.i.king@gmail.com>, Jeff Xie <jeff.xie@linux.dev>, Jinjie Ruan
 <ruanjinjie@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Justin Stitt
 <justinstitt@google.com>, Levi Yun <yeoreum.yun@arm.com>, Li Chen
 <chenl311@chinatelecom.cn>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tatsuya S
 <tatsuya.s2862@gmail.com>, Uros Bizjak <ubizjak@gmail.com>, Zheng Yejian
 <zhengyejian@huaweicloud.com>, guoweikang <guoweikang.kernel@gmail.com>
Subject: [GIT PULL] tracing: Updates for v6.13
Message-ID: <20241120214531.45d75a60@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

tracing updates for v6.13:

- Addition of faultable tracepoints

  There's a tracepoint attached to both a system call entry and exit. This
  location is known to allow page faults. The tracepoints are called under
  an rcu_read_lock() which does not allow faults that can sleep. This limits
  the ability of tracepoint handlers to page fault in user space system call
  parameters. Now these tracepoints have been made "faultable", allowing the
  callbacks to fault in user space parameters and record them.

  Note, only the infrastructure has been implemented. The consumers (perf,
  ftrace, BPF) now need to have their code modified to allow faults.

- Fix up of BPF code for the tracepoint faultable logic

- Update tracepoints to use the new static branch API

- Remove trace_*_rcuidle() variants and the SRCU protection they used

- Remove unused TRACE_EVENT_FL_FILTERED logic

- Replace strncpy() with strscpy() and memcpy()

- Use replace per_cpu_ptr(smp_processor_id()) with this_cpu_ptr()

- Fix perf events to not duplicate samples when tracing is enabled

- Replace atomic64_add_return(1, counter) with atomic64_inc_return(counter)

- Make stack trace buffer 4K instead of PAGE_SIZE

- Remove TRACE_FLAG_IRQS_NOSUPPORT flag as it was never used

- Get the true return address for function tracer when function graph tracer
  is also running.

  When function_graph trace is running along with function tracer,
  the parent function of the function tracer sometimes is
  "return_to_handler", which is the function graph trampoline to record
  the exit of the function. Use existing logic that calls into the
  fgraph infrastructure to find the real return address.

- Remove (un)regfunc pointers out of tracepoint structure

- Added last minute bug fix for setting pending modules in stack function
  filter.

  echo "write*:mod:ext3" > /sys/kernel/tracing/stack_trace_filter

  Would cause a kernel NULL dereference.

- Minor clean ups


Please pull the latest trace-v6.13 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.13

Tag SHA1: 8f623cff04bb42e08806c4d6ed5ccb6cd49c1365
Head SHA1: 45af52e7d3b8560f21d139b3759735eead8b1653


Andrii Nakryiko (3):
      bpf: put bpf_link's program when link is safe to be deallocated
      bpf: decouple BPF link/attach hook and BPF program sleepable semantics
      bpf: ensure RCU Tasks Trace GP for sleepable raw tracepoint BPF links

Colin Ian King (1):
      tracing: Remove redundant check on field->field in histograms

Jeff Xie (1):
      ftrace: Get the true parent ip for function tracer

Jinjie Ruan (1):
      tracing: Replace strncpy() with strscpy() when copying comm

Josh Poimboeuf (1):
      tracepoints: Use new static branch API

Justin Stitt (2):
      tracing/branch-profiler: Replace deprecated strncpy with strscpy
      tracing: Replace multiple deprecated strncpy with memcpy

Levi Yun (1):
      trace/trace_event_perf: remove duplicate samples on the first tracepoint event

Li Chen (1):
      ftrace: Use this_cpu_ptr() instead of per_cpu_ptr(smp_processor_id())

Mathieu Desnoyers (12):
      tracing: Declare system call tracepoints with TRACE_EVENT_SYSCALL
      tracing/ftrace: disable preemption in syscall probe
      tracing/perf: disable preemption in syscall probe
      tracing/bpf: disable preemption in syscall probe
      tracing: Allow system call tracepoints to handle page faults
      tracing/ftrace: Add might_fault check to syscall probes
      tracing/perf: Add might_fault check to syscall probes
      tracing/bpf: Add might_fault check to syscall probes
      tracing: Introduce tracepoint extended structure
      tracing: Introduce tracepoint_is_faultable()
      tracing: Fix syscall tracepoint use-after-free
      tracing: Add might_fault() check in __DECLARE_TRACE_SYSCALL

Ryan Roberts (1):
      tracing: Make percpu stack trace buffer invariant to PAGE_SIZE

Sebastian Andrzej Siewior (1):
      tracing: Remove TRACE_FLAG_IRQS_NOSUPPORT

Steven Rostedt (2):
      tracing: Remove definition of trace_*_rcuidle()
      tracepoint: Remove SRCU protection

Tatsuya S (1):
      tracing: Fix function name for trampoline

Uros Bizjak (1):
      tracing: Use atomic64_inc_return() in trace_clock_counter()

Zheng Yejian (1):
      tracing: Remove TRACE_EVENT_FL_FILTERED logic

guoweikang (1):
      ftrace: Fix regression with module command in stack_trace_filter

----
 Documentation/trace/ftrace.rst       |   3 -
 include/linux/bpf.h                  |  20 ++++-
 include/linux/trace_events.h         |  17 ----
 include/linux/tracepoint-defs.h      |  14 ++-
 include/linux/tracepoint.h           | 169 ++++++++++++++++++++---------------
 include/trace/bpf_probe.h            |  14 +++
 include/trace/define_trace.h         |   5 ++
 include/trace/events/preemptirq.h    |   8 --
 include/trace/events/syscalls.h      |   4 +-
 include/trace/perf.h                 |  44 ++++++++-
 include/trace/trace_events.h         |  62 ++++++++++++-
 init/Kconfig                         |   1 +
 kernel/bpf/syscall.c                 |  67 ++++++++++----
 kernel/trace/ftrace.c                |   3 +
 kernel/trace/trace.c                 |  81 ++++++++---------
 kernel/trace/trace.h                 |  11 ++-
 kernel/trace/trace_branch.c          |  10 +--
 kernel/trace/trace_clock.c           |   2 +-
 kernel/trace/trace_event_perf.c      |   6 ++
 kernel/trace/trace_events.c          |   2 -
 kernel/trace/trace_events_filter.c   |   8 +-
 kernel/trace/trace_events_hist.c     |  11 +--
 kernel/trace/trace_events_user.c     |   4 +-
 kernel/trace/trace_functions.c       |  36 ++++++--
 kernel/trace/trace_functions_graph.c |   8 +-
 kernel/trace/trace_hwlat.c           |   4 +-
 kernel/trace/trace_mmiotrace.c       |   8 +-
 kernel/trace/trace_osnoise.c         |  12 +--
 kernel/trace/trace_output.c          |   5 +-
 kernel/trace/trace_preemptirq.c      |  26 ++----
 kernel/trace/trace_sched_switch.c    |   2 +-
 kernel/trace/trace_sched_wakeup.c    |   8 +-
 kernel/trace/trace_syscalls.c        |  28 ++++++
 kernel/tracepoint.c                  |  75 +++-------------
 scripts/tags.sh                      |   2 -
 35 files changed, 452 insertions(+), 328 deletions(-)
---------------------------

