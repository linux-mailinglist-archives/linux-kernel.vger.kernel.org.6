Return-Path: <linux-kernel+bounces-546052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D668CA4F5AD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C5616EFFC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBEB188722;
	Wed,  5 Mar 2025 03:50:31 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5371F2AD2D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741146631; cv=none; b=P+3ngc9Vn0esvh1PxLhZBtn49LtcJLlIyMgGq+ktlLM/bOyRHGNybzN61sZLLwV3EzHbZ5mRtng4MhhcOzO4hW63YbhM+PDqRixDBj5Sw8W2bNNhQo3105X5N+DID1rk796yij2HAZZL5NBRPyZ54Bc+vTbw3YKPW5S3Y85KUd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741146631; c=relaxed/simple;
	bh=kXq/UkvYgp51lssqjMAFjFGsSEFzNgK9+h6YdAhrHg0=;
	h=Message-ID:Date:From:To:Cc:Subject; b=EaoUlBLq8jBssB9mITXxawbZKOwQb9+z+Qa1xKCXR6Bluk6Y+QpZ+ycBI+EnwSPIdchNgszc2qeS1WDBRT4zUUkRLFAg/l8MDQ7DGIio/08OLooHXzL+fi1KBUUZt0SSD4iP+38dDCHJ6WJ/PA13M2FbkET+fSRomHPjgeh5VKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8231C4CEEA;
	Wed,  5 Mar 2025 03:50:30 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tpfn5-0000000CYTw-0w72;
	Tue, 04 Mar 2025 22:51:27 -0500
Message-ID: <20250305035107.307030265@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Mar 2025 22:51:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/6] ftrace: Updates for v6.15
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace/for-next

Head SHA1: 76fe0337c2199988cb9ed7e41c05d687d95f2e18


Haiyue Wang (1):
      fgraph: Correct typo in ftrace_return_to_handler comment

Steven Rostedt (2):
      ftrace: Have ftrace_free_filter() WARN and exit if ops is active
      ftrace: Have funcgraph-args take affect during tracing

Sven Schnelle (3):
      ftrace: Add print_function_args()
      ftrace: Add support for function argument to graph tracer
      ftrace: Add arguments to function tracer

----
 include/linux/ftrace_regs.h          |   5 +
 kernel/trace/Kconfig                 |  12 +++
 kernel/trace/fgraph.c                |   2 +-
 kernel/trace/ftrace.c                |   2 +
 kernel/trace/trace.c                 |  14 ++-
 kernel/trace/trace.h                 |   5 +-
 kernel/trace/trace_entries.h         |  12 ++-
 kernel/trace/trace_functions.c       |  46 +++++++++-
 kernel/trace/trace_functions_graph.c | 172 ++++++++++++++++++++++++++++-------
 kernel/trace/trace_irqsoff.c         |  12 ++-
 kernel/trace/trace_output.c          | 103 ++++++++++++++++++++-
 kernel/trace/trace_output.h          |   9 ++
 kernel/trace/trace_sched_wakeup.c    |   4 +-
 13 files changed, 343 insertions(+), 55 deletions(-)

