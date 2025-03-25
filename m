Return-Path: <linux-kernel+bounces-576302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A033FA70DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD39F3B2D4B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91086263F3E;
	Tue, 25 Mar 2025 23:38:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A97018A6A8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742945932; cv=none; b=s+WcvB3IPRK3aC4YfhB3yPIg2wekL2x/CKFMNmfBou76mLQ7qGsbbE2f/w/VDiJWSWlPJ8l1U5AUuTtnEHAJh1TqStwW/Sx+WLAXzWo7rW3BUiD+QSZLQrsVW6RexPWI/K6kFPS1AqlmUENwowSGHdc1wfklj4iZ6w9vgt07pfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742945932; c=relaxed/simple;
	bh=prt0lASwxXBSBcy9UEKjIrliqfxx7XczJ3QrmorlyQo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FxVGa09er9crbFTz2rbdJ3engki/+fbD1IZH7vivNiVodxllpY1G2MXW4TrvdPZViu02W5lq8VQeYS94GetRfY5MLgL2a0NXMKlLzuS+DAC3lUfPSKRJKTURQl9nfBjxrHKTe02vOfAQC8bBkC957qkWEvFiGYr3zJJjNI6Plhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CBDC4CEE4;
	Tue, 25 Mar 2025 23:38:50 +0000 (UTC)
Date: Tue, 25 Mar 2025 19:39:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Haiyue Wang <haiyuewa@163.com>, Jiapeng Chong
 <jiapeng.chong@linux.alibaba.com>, Sasha Levin <sashal@kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Tengda Wu <wutengda@huaweicloud.com>
Subject: [GIT PULL] ftrace: Updates for 6.15
Message-ID: <20250325193935.66020aa3@gandalf.local.home>
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

ftrace changes for v6.15:

- Record function parameters for function and function graph tracers

  An option has been added to function tracer (func-args) and the function
  graph tracer (funcgraph-args) that when set, the tracers will record the
  registers that hold the arguments into each function event. On reading of
  the trace, it will use BTF to print those arguments. Most archs support up
  to 6 arguments (depending on the complexity of the arguments) and those
  are printed. If a function has more arguments then what was recorded, the
  output will end with " ... )".

    Example of function graph tracer:

    6)              | dummy_xmit [dummy](skb = 0x8887c100, dev = 0x872ca000) {
    6)              |   consume_skb(skb = 0x8887c100) {
    6)              |     skb_release_head_state(skb = 0x8887c100) {
    6)  0.178 us    |       sock_wfree(skb = 0x8887c100)
    6)  0.627 us    |     }

- The rest of the changes are minor clean ups and fixes


Please pull the latest ftrace-v6.15 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace-v6.15

Tag SHA1: d96c183fee82a7cb9e3875c6e65fae637768d592
Head SHA1: 391dda1bd7c56de62b96126214f040fe8965561b


Haiyue Wang (1):
      fgraph: Correct typo in ftrace_return_to_handler comment

Jiapeng Chong (1):
      function_graph: Remove the unused variable func

Sasha Levin (1):
      tracing: Use hashtable.h for event_hash

Steven Rostedt (2):
      ftrace: Have ftrace_free_filter() WARN and exit if ops is active
      ftrace: Have funcgraph-args take affect during tracing

Sven Schnelle (3):
      ftrace: Add print_function_args()
      ftrace: Add support for function argument to graph tracer
      ftrace: Add arguments to function tracer

Tengda Wu (1):
      tracing: Fix use-after-free in print_graph_function_flags during tracer switching

----
 include/linux/ftrace_regs.h          |   5 +
 kernel/trace/Kconfig                 |  12 +++
 kernel/trace/fgraph.c                |   2 +-
 kernel/trace/ftrace.c                |   2 +
 kernel/trace/trace.c                 |  14 ++-
 kernel/trace/trace.h                 |   5 +-
 kernel/trace/trace_entries.h         |  12 ++-
 kernel/trace/trace_functions.c       |  46 ++++++++-
 kernel/trace/trace_functions_graph.c | 176 ++++++++++++++++++++++++++++-------
 kernel/trace/trace_irqsoff.c         |  14 ++-
 kernel/trace/trace_output.c          | 122 +++++++++++++++++++++---
 kernel/trace/trace_output.h          |   9 ++
 kernel/trace/trace_sched_wakeup.c    |   6 +-
 13 files changed, 351 insertions(+), 74 deletions(-)
---------------------------

