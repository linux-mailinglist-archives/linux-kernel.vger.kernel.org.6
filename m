Return-Path: <linux-kernel+bounces-449579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7120A9F5103
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE62A7A531F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B681F7572;
	Tue, 17 Dec 2024 16:29:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0B61F4E3A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734452989; cv=none; b=IWkKPTsiMZfXKx3ywDFqN2APpZK78pOdwl7VMiOxWo/bowvaTWWMiCh6I6lDjS+tMRktLIJlq7yJlrPIt1hCJyQhrdgVM7Sdz/+v2nLLYv8nNX4COJYAdp2YuD0pj1hqVamuR9u0JSw3nmAx5nPIJ5Z2odEYgN6QWnSlmvhGDkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734452989; c=relaxed/simple;
	bh=Lt5ggiYwec3azx3V1OTxO7NUTlCXmdzxIgl8q7oUQQ8=;
	h=Message-ID:Date:From:To:Cc:Subject; b=GCQp952GGQLbyH07lcP+KayviBgD6c8nzqrPANd/D5YZ8TRZoH+WW3Unmd/ERIusih04Z7Wbtjg/s63ZuHf/lhaFpKSOR8SjubDZjOhUXNe5ojfaayi52s3Odp8kNvrWtF3NN/qyUMLGQIBuYjJtFmIgzARu6zHXovgynCfc6xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD14C4CED3;
	Tue, 17 Dec 2024 16:29:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tNaSn-00000008adp-16Vv;
	Tue, 17 Dec 2024 11:30:25 -0500
Message-ID: <20241217161840.069495339@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 17 Dec 2024 11:18:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Michal Simek <monstr@monstr.eu>
Subject: [for-linus v2][PATCH 0/2] ftrace: Fixes for v6.13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Ftrace fixes for 6.13:

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

  It was first thought that this was a microblaze issue, but the real
  cause is that this only works when an architecture implements
  HAVE_DYNAMIC_FTRACE_WITH_ARGS, as a requirement for that config
  is to have ftrace always pass a valid ftrace_regs to the callbacks.
  That also means that the architecture supports ftrace_regs_get_stack_pointer()
  Microblaze does not set HAVE_DYNAMIC_FTRACE_WITH_ARGS nor does it
  implement ftrace_regs_get_stack_pointer() which caused it to fail to
  build. Only implement the "true parent" logic if an architecture has
  that config set.

Changes since v1: https://lore.kernel.org/all/20241214182138.4e7984a2@batman.local.home/

- Removed the hash-ptr fix as Linus was unhappy with the code it was
  fixing and I have another series to address that. It didn't even
  belong in this pull request, as this is the ftrace topic and that
  was a tracing topic.

- Properly fix the function_get_true_parent_ip(), which wasn't a
  microblaze issue at all, but an issue for any architecture that
  does not support HAVE_DYNAMIC_FTRACE_WITH_ARGS.

