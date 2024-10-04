Return-Path: <linux-kernel+bounces-350422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3189904F6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439801C2099D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969C42139AC;
	Fri,  4 Oct 2024 13:56:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A624212EFA
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050187; cv=none; b=OiR7dYGv6APM+9qrCoQYJkLjQPfsVBe0uzaLz0wtoFOTO30R6Uw8vGVAx1KsyFYi597RttvKSjYfh88OaqdBc3rhRi3vCNnSXZbH2xLk2cZf4f3GsQheJx/F6cILmV58P753EeNYqlJRKIflEw4eScx1691owSeIk7Cb1K/r5Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050187; c=relaxed/simple;
	bh=jROLv1v3Df5+smgMGICTvuEjQR+GIYLhC3znIL7OpXU=;
	h=Message-ID:Date:From:To:Cc:Subject; b=QOdv9JIGJllKJ6aJT0ulP8G2Dxa7CN8SHP+N5tOk7XezxxeNNLdV5DX5cAbAki1tPUDNhNmDViils7AIuXNswMM3inESi3NAdBaaXFbT7PVpkISHrOCpI006Ymc/K5E7W7MfZIh+8EluS6lRCLg6OXmlVdiaomesoW33oii5EC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A98C4CEC6;
	Fri,  4 Oct 2024 13:56:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1swio7-00000005C7a-0VDt;
	Fri, 04 Oct 2024 09:57:23 -0400
Message-ID: <20241004135655.993267242@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 04 Oct 2024 09:56:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/8] tracing: Fixes for v6.12 and earlier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Various fixes for tracing:

- Fix tp_printk crashing the kernel

  With the code that can handle a buffer from a previous boot, the
  trace_check_vprintf() needed access to the delta of the address
  space used by the old buffer and the current buffer. To do so,
  the trace_array (tr) parameter was used. But when tp_printk is
  enabled on the kernel command line, no trace buffer is used and
  the trace event is sent directly to printk(). That meant the tr
  field of the iterator descriptor was NULL, and since tp_printk still
  uses trace_check_vprintf() it caused a NULL dereference.

- Add ptrace.h include to x86 ftrace file for completeness

- Fix rtla installation when done with out-of-tree build

- Fix the help messages in rtla that were incorrect

- Several fixes to fix races with the timerlat and hwlat code

  Several locking issues were discovered with the coordination
  between timerlat kthread creation and hotplug. As timerlat has
  callbacks from hotplug code to start kthreads when CPUs come online.
  There are also locking issues with grabbing the cpu_read_lock()
  and the locks within timerlat.

Ben Hutchings (1):
      tools/rtla: Fix installation from out-of-tree build

Eder Zulian (1):
      rtla: Fix the help text in osnoise and timerlat top tools

Sami Tolvanen (1):
      x86/ftrace: Include <asm/ptrace.h>

Steven Rostedt (1):
      tracing: Fix trace_check_vprintf() when tp_printk is used

Wei Li (4):
      tracing/timerlat: Fix duplicated kthread creation due to CPU online/offline
      tracing/timerlat: Drop interface_lock in stop_kthread()
      tracing/timerlat: Fix a race during cpuhp processing
      tracing/hwlat: Fix a race during cpuhp processing

----
 arch/x86/include/asm/ftrace.h         |  2 ++
 kernel/trace/trace.c                  | 15 +++++++++++++--
 kernel/trace/trace_hwlat.c            |  2 ++
 kernel/trace/trace_osnoise.c          | 22 +++++++++++++---------
 tools/tracing/rtla/Makefile.rtla      |  2 +-
 tools/tracing/rtla/src/osnoise_top.c  |  2 +-
 tools/tracing/rtla/src/timerlat_top.c |  4 ++--
 7 files changed, 34 insertions(+), 15 deletions(-)

