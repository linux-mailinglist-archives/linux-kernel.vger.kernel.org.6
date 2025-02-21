Return-Path: <linux-kernel+bounces-526084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDA2A3F9BC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD86424A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCAC215049;
	Fri, 21 Feb 2025 15:52:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B00214212
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153142; cv=none; b=l0ebXDH50xgmmS7LVtTvUWUPVrJrePITFm2/JuPTJjhvBxSQXv9ku2l+fNl+dTH+d+p2Ua7K8uFEvV928fut384YpM/EMR5fyVHqLiItgqzDco6Yt9CDBbDK3vV2wXxrE5r5xlWkErwwAZGJCK5X+Etlha9rXMgjc5nV21tUfRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153142; c=relaxed/simple;
	bh=TJhpvVPGEiVV08C52WRrpXYRWrzi9WlBRyPw4dSk/gY=;
	h=Message-ID:Date:From:To:Cc:Subject; b=iPFxLQdbsX9B3kuNq2AnW+cOsg/NK/YHjIMyNZRyVqIhgkksgTu2VRT6qOF7m/YbDNC3b2saNIL5ZvwpqQSdYlIQvyVb4IRtoX/NpqWdQmauFybB4NpgyfsNsiYqEZikUz0nkATmRIjMrOYht1ReYy1MYGEiZd3eWWfOUGpXAws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5E0C4CEE4;
	Fri, 21 Feb 2025 15:52:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tlVKd-00000006KR6-2hoH;
	Fri, 21 Feb 2025 10:52:51 -0500
Message-ID: <20250221155210.755295517@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 21 Feb 2025 10:52:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/7] ftrace: Fixes for v6.14
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


tracing fixes for v6.14:

Function graph accounting fixes:

- Fix the manage ops hashes

  The function graph registers a "manager ops" and "sub-ops" to ftrace.
  The manager ops does not have any callback but calls the sub-ops
  callbacks. The manage ops hashes (what is used to tell ftrace what
  functions to attach to) is built on the sub-ops it manages.

  There was an error in the way it built the hash. An empty hash means to
  attach to all functions. When the manager ops had one sub-ops it properly
  copied its hash. But when the manager ops had more than one sub-ops, it
  went into a loop to make a set of all functions it needed to add to the
  hash. If any of the subops hashes was empty, that would mean to attach
  to all functions. The error was that the first iteration of the loop
  passed in an empty hash to start with in order to add the other hashes.
  That starting hash was mistaken as to attach to all functions. This made
  the manage ops attach to all functions whenever it had two or more
  sub-ops, even if each sub-op was attached to only a single function.

- Do not add duplicate entries to the manager ops hash

  If two or more subops hashes trace the same function, an entry for that
  function will be added to the manager ops for each subops. This causes
  waste and extra overhead.

Fprobe accounting fixes:

- Remove last function from fprobe hash

  Fprobes has a ftrace hash to manage which functions an fprobe is attached
  to. It also has a counter of how many fprobes are attached. When the last
  fprobe is removed, it unregisters the fprobe from ftrace but does not
  remove the functions the last fprobe was attached to from the hash. This
  leaves the old functions attached. When a new fprobe is added, the fprobe
  infrastructure attaches to not only the functions of the new fprobe, but
  also to the functions of the last fprobe.

- Fix accounting of the fprobe counter

  When a fprobe is added, it updates a counter. If the counter goes from
  zero to one, it attaches its ops to ftrace. When an fprobe is removed, the
  counter is decremented. If the counter goes from 1 to zero, it removes the
  fprobes ops from ftrace. There was an issue where if two fprobes trace the
  same function, the addition of each fprobe would increment the counter.
  But when removing the first of the fprobes, it would notice that another
  fprobe is still attached to one of its functions no it does not remove
  the functions from the ftrace ops. But it also did not decrement the
  counter. When the last fprobe is removed, the counter is still one. This
  leaves the fprobes callback still registered with ftrace and it being
  called by the functions defined by the fprobes ops hash.  Worse yet,
  because all the functions from the fprobe ops hash have been removed, that
  tells ftrace that it wants to trace all functions. Thus, this puts the
  state of the system where every function is calling the fprobe callback
  handler (which does nothing as there are no registered fprobes), but this
  causes a good 13% slow down of the entire system.

Other updates:

- Add a selftest to test the above issues to prevent regressions.

- Fix preempt count accounting in function tracing

  Better recursion protection was added to function tracing which added
  another layer of preempt disable. As the preempt_count gets traced in the
  event, it needs to subtract the amount of preempt disabling the tracer
  does to record what the preempt_count was when the trace was triggered.

- Fix memory leak in output of set_event

  A variable is passed by the seq_file functions in the location that is
  set by the return of the next() function. The start() function allocates
  it and the stop() function frees it. But when the last item is found, the
  next() returns NULL which leaks the data that was allocated in start().
  The m->private is used for something else, so have next() free the data
  when it returns NULL, as stop() will then just receive NULL in that case.


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace/fixes

Head SHA1: 2fa6a01345b538faa7b0fae8f723bb6977312428


Adrian Huang (1):
      tracing: Fix memory leak when reading set_event file

Sebastian Andrzej Siewior (1):
      ftrace: Correct preemption accounting for function tracing.

Steven Rostedt (5):
      ftrace: Fix accounting of adding subops to a manager ops
      ftrace: Do not add duplicate entries in subops manager ops
      fprobe: Always unregister fgraph function from ops
      fprobe: Fix accounting of when to unregister from function graph
      selftests/ftrace: Update fprobe test to check enabled_functions file

----
 kernel/trace/fprobe.c                              | 12 ++---
 kernel/trace/ftrace.c                              | 36 ++++++++++-----
 kernel/trace/trace_events.c                        | 11 ++++-
 kernel/trace/trace_functions.c                     |  6 +--
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    | 54 ++++++++++++++++++++++
 5 files changed, 95 insertions(+), 24 deletions(-)

