Return-Path: <linux-kernel+bounces-200862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641508FB5D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951D31C22719
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B9A14431C;
	Tue,  4 Jun 2024 14:42:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAC913A863
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512134; cv=none; b=dUvSQz7kGehxjCPT2QstMKmpuoVFhJHl+ez+hTFGGSxjMJuNnxcaTd/09oCKBAKfcgm68/WsOc49hZOwltWl/etYF9eqOpFqKCLAatP5YEc0E1E/TusxVHLYM5KIs191CVgnDys5k0Szv+fiS1vJL/89IAn4ilEqBxzdV4fp4uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512134; c=relaxed/simple;
	bh=QhueViGQ6pQwXQ+A7L/O06/Vk+SdAysHzZ8fTiTjFis=;
	h=Message-ID:Date:From:To:Cc:Subject; b=IINeg75fXwhkmDSbGA7SQM286kiLUn0HyjSOBSH7QqUwEW6tynquekYy9xgOtDAXfW6OiBdgPeI4/MkIovZWOi/ywA/5cFjvXkdw8ylvrF8HavTFR1CSRLZlJ3/MtSTk7VZgWPk+KNQDshoD0GnZCxQATJ28lvHaWMxOw05JucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACEDC32786;
	Tue,  4 Jun 2024 14:42:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEVMc-00000000Yt9-0V0T;
	Tue, 04 Jun 2024 10:42:14 -0400
Message-ID: <20240604144103.293353991@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Jun 2024 10:41:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/27] function_graph: Allow multiple users for v6.11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
fgraph/for-next

Head SHA1: 8d4e21bd4cca8013d2c6f55d42df85838d4ebce6


Masami Hiramatsu (Google) (3):
      function_graph: Handle tail calls for stack unwinding
      function_graph: Use a simple LRU for fgraph_array index number
      ftrace: Add multiple fgraph storage selftest

Steven Rostedt (Google) (9):
      ftrace: Add subops logic to allow one ops to manage many
      ftrace: Allow subops filtering to be modified
      function_graph: Add pid tracing back to function graph tracer
      function_graph: Use for_each_set_bit() in __ftrace_return_to_handler()
      function_graph: Use bitmask to loop on fgraph entry
      function_graph: Use static_call and branch to optimize entry function
      function_graph: Use static_call and branch to optimize return function
      selftests/ftrace: Add function_graph tracer to func-filter-pid test
      selftests/ftrace: Add fgraph-multi.tc test

Steven Rostedt (VMware) (15):
      function_graph: Convert ret_stack to a series of longs
      fgraph: Use BUILD_BUG_ON() to make sure we have structures divisible by long
      function_graph: Add an array structure that will allow multiple callbacks
      function_graph: Allow multiple users to attach to function graph
      function_graph: Remove logic around ftrace_graph_entry and return
      ftrace/function_graph: Pass fgraph_ops to function graph callbacks
      ftrace: Allow function_graph tracer to be enabled in instances
      ftrace: Allow ftrace startup flags to exist without dynamic ftrace
      function_graph: Have the instances use their own ftrace_ops for filtering
      function_graph: Add "task variables" per task for fgraph_ops
      function_graph: Move set_graph_function tests to shadow stack global var
      function_graph: Move graph depth stored data to shadow stack global var
      function_graph: Move graph notrace bit to shadow stack global var
      function_graph: Implement fgraph_reserve_data() and fgraph_retrieve_data()
      function_graph: Add selftest for passing local variables

----
 include/linux/ftrace.h                             |   43 +-
 include/linux/sched.h                              |    2 +-
 include/linux/trace_recursion.h                    |   39 -
 kernel/trace/fgraph.c                              | 1044 ++++++++++++++++----
 kernel/trace/ftrace.c                              |  522 +++++++++-
 kernel/trace/ftrace_internal.h                     |    5 +-
 kernel/trace/trace.h                               |   94 +-
 kernel/trace/trace_functions.c                     |    8 +
 kernel/trace/trace_functions_graph.c               |   96 +-
 kernel/trace/trace_irqsoff.c                       |   10 +-
 kernel/trace/trace_sched_wakeup.c                  |   10 +-
 kernel/trace/trace_selftest.c                      |  259 ++++-
 .../selftests/ftrace/test.d/ftrace/fgraph-multi.tc |  103 ++
 .../ftrace/test.d/ftrace/func-filter-pid.tc        |   27 +-
 14 files changed, 1945 insertions(+), 317 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-multi.tc

