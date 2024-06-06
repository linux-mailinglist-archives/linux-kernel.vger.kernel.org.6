Return-Path: <linux-kernel+bounces-204240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BD78FE634
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4F81C25360
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B9F19598E;
	Thu,  6 Jun 2024 12:11:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9B713F014
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675860; cv=none; b=e8QowkI8wGy+9QW4CEtMZjpjJqJs2aybUZSkq/rfpknyFPsHsNSAK/cnzwTMWfCecdwoZX/DQJpOFSE3+X7ireesCT0DyEdYJEk0uK1Eo6+3XErbRnuaGjD3MOTiZ7eBM2oplm93Z281bOkuIKQ6WvxPuNzoPLjeYF90JkAwnbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675860; c=relaxed/simple;
	bh=6KIZeu7P4A+VqmPbs2foZWElhHKRiOJsd/xHANXue+M=;
	h=Message-ID:Date:From:To:Cc:Subject; b=uTwrqs43Fpfx5Oyw5qx3fqzrMQOXTT1JOCUKmwBUytMnYM0B1pbSikAG0Oosw4LQXD6zuu9swyy43DflpgYLGFcAyUY3c+82oNdTYEqY15dtvYS4mknmr+eLGw4yhFdn2oipCGRGT4lJ4dKlKyvNyd5zByn2EZnRkMdOWckyFT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22863C4AF0A;
	Thu,  6 Jun 2024 12:11:00 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sFBxQ-00000000nIN-2E0Y;
	Thu, 06 Jun 2024 08:11:04 -0400
Message-ID: <20240606121004.857581251@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Jun 2024 08:10:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/15] ftrace: Updates for 6.11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
fgraph/for-next

Head SHA1: f6716bf04b50e791f47a5e35002ccec22b7c74be


Jiapeng Chong (1):
      fgraph: Remove some unused functions

Steven Rostedt (Google) (13):
      ftrace: Add back ftrace_update_trampoline() to ftrace_update_pid_func()
      ftrace/selftests: Fix pid test with function graph not showing pids
      ftrace: Rename dup_hash() and comment it
      ftrace: Remove "ftrace_hash" parameter from __ftrace_hash_rec_update()
      ftrace: Add comments to ftrace_hash_rec_disable/enable()
      ftrace: Convert "inc" parameter to bool in ftrace_hash_rec_update_modify()
      ftrace: Add comments to ftrace_hash_move() and friends
      ftrace: Declare function_trace_op in header to quiet sparse warning
      ftrace: Assign ftrace_list_end to ftrace_ops_list type cast to RCU
      ftrace: Assign RCU list variable with rcu_assign_ptr()
      ftrace: Fix prototypes for ftrace_startup/shutdown_subops()
      function_graph: Make fgraph_do_direct static key static
      function_graph: Do not update pid func if CONFIG_DYNAMIC_FTRACE not enabled

Tatsuya S (1):
      ftrace: Hide one more entry in stack trace when ftrace_pid is enabled

----
 include/linux/ftrace.h                             |   3 +
 kernel/trace/fgraph.c                              |  17 +--
 kernel/trace/ftrace.c                              | 166 ++++++++++++---------
 kernel/trace/ftrace_internal.h                     |   9 ++
 kernel/trace/trace.h                               |   1 -
 kernel/trace/trace_functions.c                     |   7 +-
 .../ftrace/test.d/ftrace/func-filter-pid.tc        |   2 +
 7 files changed, 120 insertions(+), 85 deletions(-)

