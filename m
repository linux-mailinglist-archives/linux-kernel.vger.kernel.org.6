Return-Path: <linux-kernel+bounces-445080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0879F10F3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45AD21882DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108E91E32A2;
	Fri, 13 Dec 2024 15:26:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F0C1E25F1
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103598; cv=none; b=rP3HfCwoFJrBTlrlMIGErLqKUugc1WYRDiYFK0ThokB/jlmkzakCZCtw00OeCRhlaO5TFEiEIP6cE2unFWbuEP4II7dF52QO4mRZaszvF1iAYpAFy+E+fUhYfzC6A/aTK4Y7AVpfBdamP52H+3SBo57bo7YwS8+zXd6b++ait9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103598; c=relaxed/simple;
	bh=nOB9TGc/K7G7JutJ90iy9R08Uz9M1vdYyX7WZTt3rYs=;
	h=Message-ID:Date:From:To:Cc:Subject; b=IgyhbUBLTkuKKoTloZp0sDRCiJEhdZqlOz/uN+HbrGdUBY0Dl6bhjKJFejFaqjFpYziOIGLrtJiI7v2v7AoT0EFm/MkpZxZYST6cCie/KULEr1nNmAxa9jR7vyvIn7ZOfOtwxTvdkmbw6cIOyOoyEvRI2rmwjsC67gQBPxYujzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE58C4CED6;
	Fri, 13 Dec 2024 15:26:38 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tM7ZI-00000005PFz-0Jpq;
	Fri, 13 Dec 2024 10:27:04 -0500
Message-ID: <20241213152647.904822987@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 13 Dec 2024 10:26:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/3] ftrace: Fixes for 6.13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Ftrace fixes for 6.13:

- Fix output of trace when hashing a pointer is disabled

  Pointers are recorded into the ring buffer by simply copying them.
  When the ring buffer is read directly in binary format, the
  pointers are unhashed, and tools like perf will show them as such.
  But when the pointers are printed from the trace file, they are
  hashed because the output from the trace uses vsnprintf() which will
  hash "%p". Since the tracing infrastructure requires just as much
  privileged as kallsyms this was an unneeded protection. An option
  was created to allow the pointers to not be hashed, as in some cases
  in debugging, the unhashed pointer was required.

  To do this, the unhashing would add a "x" after a "%p" to make it
  "%px" and not hash. It used the iter->fmt temp buffer to accomplish
  this. The problem was that the iter->fmt temp buffer was already
  being used as a temp buffer to check if pointers in the event format
  output were being called indirectly (like using a "%pI4 or %pI6)
  where the pointer may be pointing to a freed location. The check
  code will catch that.

  The issue was that when the hash pointer was being disabled, that
  logic that used the temporary iter->fmt buffer passed that buffer
  to the function that would test bad pointers and that function
  would use iter->fmt buffer as well, causing the output to be
  screwed up.

  The solution was to change the bad pointer logic to use the iter->fmt
  buffer directly and not as a temp buffer. If the fmt parameter passed
  in was not the iter->fmt buffer, it would copy the content to the
  iter->fmt buffer and process that buffer directly. This now allows
  passing the iter->fmt buffer as the fmt parameter to the bad pointer
  check function.

- Always try to initialize the idle functions when graph tracer starts

  A bug was found that when a CPU is offline when graph tracing starts
  and then comes online, that CPU is not traced. The fix to that was
  to move the initialization of the idle shadow stack over to the
  hot plug online logic, which also handle onlined CPUs. The issue was
  that it removed the initialization of the shadow stack when graph tracing
  starts, but the callbacks to the hot plug logic do nothing if graph
  tracing isn't currently running. Although that fix fixed the onlining
  of a CPU during tracing, it broke the CPUs that were already online.

- Have microblaze not try to get the "true parent" in function tracing

  If function tracing and graph tracing are both enabled at the same time
  the parent of the functions traced by the function tracer may sometimes
  be the graph tracing trampoline. The graph tracing hijacks the return
  pointer of the function to trace it, but that can interfere with the
  function tracing parent output. This was fixed by using the
  ftrace_graph_ret_addr() function passing in the kernel stack pointer
  using the ftrace_regs_get_stack_pointer() function. But Al Viro reported
  that Microblaze does not implement the kernel_stack_pointer(regs)
  helper function that ftrace_regs_get_stack_pointer() uses and fails
  to compile when function graph tracing is enabled.

  The real fix would be to have microblaze implement the kernel_stack_pointer()
  function, but they haven't responded to emails. For now, just make
  microblaze use the old logic which prints the function graph trampoline
  in the function tracer.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace/fixes

Head SHA1: 617bbefc102f266b23beac72185a2b0e13aa378d


Steven Rostedt (3):
      tracing: Fix trace output when pointer hash is disabled
      fgraph: Still initialize idle shadow stacks when starting
      ftrace/microblaze: Do not find "true_parent" for return address

----
 kernel/trace/fgraph.c          |  8 +++-
 kernel/trace/trace.c           | 90 ++++++++++++++++++++++++++----------------
 kernel/trace/trace_functions.c |  3 +-
 3 files changed, 64 insertions(+), 37 deletions(-)

