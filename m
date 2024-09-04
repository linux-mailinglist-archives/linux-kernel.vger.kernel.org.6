Return-Path: <linux-kernel+bounces-316084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4247196CAEF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 997DFB20DB3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FC9186E40;
	Wed,  4 Sep 2024 23:43:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B717917A5BE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493406; cv=none; b=GeTgYUA5Tl5uaIEH/i1lvc/6OeEQBS8sNXbydNdH/io0vTChEqqgz8UOfqY5OOlpoFHrli/+Z0kC7SODnnJJqm4BmwsHl4TYMhOA3CEIjjIj/3V6DuhGZhvU4Wevq1DyNhtQy+pMphEQNb5Z0Bt2isj00tlsC1pucuBhya2r08U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493406; c=relaxed/simple;
	bh=zMv9MPyIKwsvvjX4QyMZPUL87mCEvR6utgZAA+Eu0SA=;
	h=Message-ID:Date:From:To:Cc:Subject; b=fmhjMQlgvBhDOy5YV2IXBHO8AifCPc7n/oVgt4NkaX3muXYy+lvg9e09JsolP+/rTm+IaOkkVV/mJ32f9mlMM3VLxXxh/I7ju+hdbEq1phig1BcnCafx7GB3Ol7HsOF08KJLIcfJL9trmIFsFzwO+4inLeGjDdYL2BVMCfktWr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F62C4CEC2;
	Wed,  4 Sep 2024 23:43:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1slzfn-00000005Bml-2Rrg;
	Wed, 04 Sep 2024 19:44:27 -0400
Message-ID: <20240904234411.443593140@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 04 Sep 2024 19:44:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/6] tracing: Fixes for 6.11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Tracing fixes for 6.11:

- Fix adding a new fgraph callback after function graph tracing has
  already started.

  If the new caller does not initialize its hash before registering the
  fgraph_ops, it can cause a NULL pointer dereference. Fix this by adding
  a new parameter to ftrace_graph_enable_direct() passing in the newly
  added gops directly and not rely on using the fgraph_array[], as entries
  in the fgraph_array[] must be initialized. Assign the new gops to the
  fgraph_array[] after it goes through ftrace_startup_subops() as that
  will properly initialize the gops->ops and initialize its hashes.

- Fix a memory leak in fgraph storage memory test.

  If the "multiple fgraph storage on a function" boot up selftest
  fails in the registering of the function graph tracer, it will
  not free the memory it allocated for the filter. Break the loop
  up into two where it allocates the filters first and then registers
  the functions where any errors will do the appropriate clean ups.

- Only clear the timerlat timers if it has an associated kthread.

  In the rtla tool that uses timerlat, if it was killed just as it
  was shutting down, the signals can free the kthread and the timer.
  But the closing of the timerlat files could cause the hrtimer_cancel()
  to be called on the already freed timer. As the kthread variable is
  is set to NULL when the kthreads are stopped and the timers are freed
  it can be used to know not to call hrtimer_cancel() on the timer if
  the kthread variable is NULL.

  Note, this code requires more design changes to fix properly, but
  this is a easy workaround that can be backported to stable.

- Use a cpumask to keep track of osnoise/timerlat kthreads

  The timerlat tracer can use user space threads for its analysis.
  With the killing of the rtla tool, the kernel can get confused
  between if it is using a user space thread to analyze or one of its
  own kernel threads. When this confusion happens, kthread_stop()
  can be called on a user space thread and bad things happen.
  As the kernel threads are per-cpu, a bitmask can be used to know
  when a kernel thread is used or when a user space thread is used.

- Add cond_resched() to the tracing_iter_reset() loop.

  The latency tracers keep writing to the ring buffer without resetting
  when it issues a new "start" event (like interrupts being disabled).
  When reading the buffer with an iterator, the tracing_iter_reset()
  sets its pointer to that start event by walking through all the events
  in the buffer until it gets to the time stamp of the start event.
  In the case of a very large buffer, the loop that looks for the start
  event has been reported taking a very long time with a non preempt kernel
  that it can trigger a soft lock up warning. Add a cond_resched() into
  that loop to make sure that doesn't happen. 

- Use list_del_rcu() for eventfs ei->list variable

  It was reported that running loops of creating and deleting  kprobe events
  could cause a crash due to the eventfs list iteration hitting a LIST_POISON
  variable. This is because the list is protected by SRCU but when an item is
  deleted from the list, it was using list_del() which poisons the "next"
  pointer. This is what list_del_rcu() was to prevent.

Masami Hiramatsu (Google) (2):
      tracing: fgraph: Fix to add new fgraph_ops to array after ftrace_startup_subops()
      tracing: Fix memory leak in fgraph storage selftest

Steven Rostedt (3):
      tracing/timerlat: Only clear timer if a kthread exists
      tracing/osnoise: Use a cpumask to know what threads are kthreads
      eventfs: Use list_del_rcu() for SRCU protected list variable

Zheng Yejian (1):
      tracing: Avoid possible softlockup in tracing_iter_reset()

----
 fs/tracefs/event_inode.c      |  2 +-
 kernel/trace/fgraph.c         | 31 ++++++++++++++++++-------------
 kernel/trace/trace.c          |  2 ++
 kernel/trace/trace_osnoise.c  | 23 +++++++++++++++++++----
 kernel/trace/trace_selftest.c | 23 ++++++++++++++++++-----
 5 files changed, 58 insertions(+), 23 deletions(-)

