Return-Path: <linux-kernel+bounces-413240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB9A9D157E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C9E0B273CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F871BD9D0;
	Mon, 18 Nov 2024 16:37:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFF01A0BD8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731947858; cv=none; b=ptc5oEGMkdlZA3W6nOP1kQE+q8PEPLwWnJp8Gx6dMMGcup49dK32JNIRL7SObdAugHunM+wqg0siqnqAE4qrEYqm6yvtVyPEvsetABN/kyFITZOiPYrQo5ehEuxOIMBj2PueDFq+vlWfbXHv32e6/9nVct20ZdH/gRyKZ7HK6dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731947858; c=relaxed/simple;
	bh=ayBpu8TDSonOGKWcl6EEK8IjaqJk5BC4CO06hlnp+ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=QFo6AJjCxJXmb39vuKQjHPxSzZ+MMaYQ49+WEnnUZPhtNtZWzWt3aQbDfvrjgZLU95OVHGaJ0TuVSs5kKwkEICbh9Qh9A5ofYMLBk1JRaaXDBQKUcrPbf9oKjhOEzPaP53saH/+UvZeCeAqHIhoNs2R6/efzM3TZAagCIQH5vM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE3DC4CECC;
	Mon, 18 Nov 2024 16:37:36 +0000 (UTC)
Date: Mon, 18 Nov 2024 11:38:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Donglin Peng
 <pengdonglin@xiaomi.com>, Oleg Nesterov <oleg@redhat.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>
Subject: [GIT PULL] ftrace: Updates for v6.13
Message-ID: <20241118113807.7071ee24@gandalf.local.home>
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

ftrace updates for v6.13:

- Merged tag ftrace-v6.12-rc4

  There was a fix to locking in register_ftrace_graph() for shadow stacks
  that was sent upstream. But this code was also being rewritten, and the
  locking fix was needed. Merging this fix was required to continue the
  work.

- Restructure the function graph shadow stack to prepare it for use with
  kretprobes

  With the goal of merging the shadow stack logic of function graph and
  kretprobes, some more restructuring of the function shadow stack is
  required.

  Move out function graph specific fields from the fgraph infrastructure and
  store it on the new stack variables that can pass data from the entry
  callback to the exit callback.

  Hopefully, with this change, the merge of kretprobes to use fgraph shadow
  stacks will be ready by the next merge window.

- Make shadow stack 4k instead of using PAGE_SIZE.

  Some architectures have very large PAGE_SIZE values which make its use for
  shadow stacks waste a lot of memory.

- Give shadow stacks its own kmem cache.

  When function graph is started, every task on the system gets a shadow
  stack. In the future, shadow stacks may not be 4K in size. Have it have
  its own kmem cache so that whatever size it becomes will still be
  efficient in allocations.

- Initialize profiler graph ops as it will be needed for new updates to fgraph

- Convert to use guard(mutex) for several ftrace and fgraph functions

- Add more comments and documentation

- Show function return address in function graph tracer

  Add an option to show the caller of a function at each entry of the
  function graph tracer, similar to what the function tracer does.

- Abstract out ftrace_regs from being used directly like pt_regs

  ftrace_regs was created to store a partial pt_regs. It holds only the
  registers and stack information to get to the function arguments and
  return values. On several archs, it is simply a wrapper around pt_regs.
  But some users would access ftrace_regs directly to get the pt_regs which
  will not work on all archs. Make ftrace_regs an abstract structure that
  requires all access to its fields be through accessor functions.

- Show how long it takes to do function code modifications

  When code modification for function hooks happen, it always had the time
  recorded in how long it took to do the conversion. But this value was
  never exported. Recently the code was touched due to new ROX modification
  handling that caused a large slow down in doing the modifications and
  had a significant impact on boot times.

  Expose the timings in the dyn_ftrace_total_info file. This file was
  created a while ago to show information about memory usage and such to
  implement dynamic function tracing. It's also an appropriate file to store
  the timings of this modification as well. This will make it easier to see
  the impact of changes to code modification on boot up timings.

- Other clean ups and small fixes


[
  NOTE: Reminder that this has a conflict with the powerpc tree.
  https://lore.kernel.org/all/20241106140414.760b502c@canb.auug.org.au/
]

Please pull the latest ftrace-v6.13 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace-v6.13

Tag SHA1: f66edaf1213965180f6935c52a303e5e478e8692
Head SHA1: 36a367b8912a3aac023d9e35c815f7b1e609f4a3


Donglin Peng (1):
      function_graph: Support recording and printing the function return address

Masami Hiramatsu (Google) (5):
      tracing: Fix function timing profiler to initialize hashtable
      tracing: Add a comment about ftrace_regs definition
      fgraph: Simplify return address printing in function graph tracer
      ftrace: Use arch_ftrace_regs() for ftrace_regs_*() macros
      ftrace: Rename ftrace_regs_return_value to ftrace_regs_get_return_value

Oleg Nesterov (1):
      function_graph: Remove unnecessary initialization in ftrace_graph_ret_addr()

Steven Rostedt (16):
      fgraph: Use fgraph data to store subtime for profiler
      ftrace: Use a running sleeptime instead of saving on shadow stack
      ftrace: Have calltime be saved in the fgraph storage
      fgragh: No need to invoke the function call_filter_check_discard()
      ftrace: Make ftrace_regs abstract from direct use
      ftrace: Consolidate ftrace_regs accessor functions for archs using pt_regs
      selftests/ftrace: Fix check of return value in fgraph-retval.tc test
      Merge tag 'ftrace-v6.12-rc4' into trace/ftrace/core
      fgraph: Separate size of ret_stack from PAGE_SIZE
      fgraph: Give ret_stack its own kmem cache
      fgraph: Use guard(mutex)(&ftrace_lock) for unregister_ftrace_graph()
      ftrace: Use guard for match_records()
      ftrace: Use guard to lock ftrace_lock in cache_mod()
      ftrace: Use guard to take the ftrace_lock in release_probe()
      ftrace: Use guard to take ftrace_lock in ftrace_graph_set_hash()
      ftrace: Show timings of how long nop patching took

----
 arch/arm64/include/asm/ftrace.h                    |  21 +-
 arch/arm64/kernel/asm-offsets.c                    |  22 +-
 arch/arm64/kernel/ftrace.c                         |  10 +-
 arch/loongarch/include/asm/ftrace.h                |  29 +--
 arch/loongarch/kernel/ftrace_dyn.c                 |   2 +-
 arch/powerpc/include/asm/ftrace.h                  |  27 +--
 arch/powerpc/kernel/trace/ftrace.c                 |   4 +-
 arch/powerpc/kernel/trace/ftrace_64_pg.c           |   2 +-
 arch/riscv/include/asm/ftrace.h                    |  22 +-
 arch/riscv/kernel/asm-offsets.c                    |  28 +--
 arch/riscv/kernel/ftrace.c                         |   2 +-
 arch/s390/include/asm/ftrace.h                     |  29 +--
 arch/s390/kernel/asm-offsets.c                     |   4 +-
 arch/s390/kernel/ftrace.c                          |   2 +-
 arch/s390/lib/test_unwind.c                        |   4 +-
 arch/x86/include/asm/ftrace.h                      |  30 +--
 arch/x86/kernel/ftrace.c                           |   2 +-
 include/linux/ftrace.h                             |  85 +++++--
 include/linux/ftrace_regs.h                        |  36 +++
 include/linux/sched.h                              |   1 +
 kernel/trace/Kconfig                               |  10 +
 kernel/trace/fgraph.c                              | 155 ++++++++----
 kernel/trace/ftrace.c                              | 115 ++++-----
 kernel/trace/trace.c                               |  15 +-
 kernel/trace/trace.h                               |  11 +
 kernel/trace/trace_entries.h                       |  29 ++-
 kernel/trace/trace_functions_graph.c               | 264 +++++++++++++++++----
 kernel/trace/trace_selftest.c                      |   1 +
 .../ftrace/test.d/ftrace/fgraph-retval.tc          |   2 +-
 29 files changed, 632 insertions(+), 332 deletions(-)
 create mode 100644 include/linux/ftrace_regs.h
---------------------------

