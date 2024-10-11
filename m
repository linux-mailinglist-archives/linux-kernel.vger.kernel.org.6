Return-Path: <linux-kernel+bounces-361203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB1999A506
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34C51F23CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2924E2194A5;
	Fri, 11 Oct 2024 13:29:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363620CCE6
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653386; cv=none; b=FW7GmRfOrEHDQ3on4p1JduvCCV6TxY3tUKEPxziEBR8dQ8LRQqpYcNhy4clnGGTow4C1udg/ig+ldhhHWAbIbMQYjWI1izvA3BxoyT6a03KdcEDnbcLzUPlHRGQsYsmHX8fpbTJZdvsN8bXoslcxJ1iYvuSDEkz2XT2rT4u9l68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653386; c=relaxed/simple;
	bh=EYaeIqvy5+cYHqrZlJUVfXMauHuio98DTE7XZd5BX78=;
	h=Message-ID:Date:From:To:Cc:Subject; b=GOlNjtKd6EnVQ7zTgvQKmsOEjVDiNwvrxaVpcLzrk792kUJnPKZQKj2RhDex6DUy87bO98qNogcQ8NLuYMmQVFrnYYEQFEGCHOZpxkMdDkcE/cseaxP7Kklm0+uAH1gQQsqiW57BMUc6IF+KCnAfB01r6laxHFOnH1VR9IrEVUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F177C4CEC3;
	Fri, 11 Oct 2024 13:29:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1szFiO-00000001QWz-1cBI;
	Fri, 11 Oct 2024 09:29:56 -0400
Message-ID: <20241011132941.339392460@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 11 Oct 2024 09:29:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/4] ftrace: Updates for 6.13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace/for-next

Head SHA1: 3e7814207b41eafafd49e6d8010c07f2d5831891


Masami Hiramatsu (Google) (1):
      fgraph: Simplify return address printing in function graph tracer

Steven Rostedt (3):
      fgragh: No need to invoke the function call_filter_check_discard()
      ftrace: Make ftrace_regs abstract from direct use
      ftrace: Consolidate ftrace_regs accessor functions for archs using pt_regs

----
 arch/arm64/include/asm/ftrace.h          | 21 ++++++------
 arch/arm64/kernel/asm-offsets.c          | 22 ++++++-------
 arch/arm64/kernel/ftrace.c               | 10 +++---
 arch/loongarch/include/asm/ftrace.h      | 29 +++--------------
 arch/loongarch/kernel/ftrace_dyn.c       |  2 +-
 arch/powerpc/include/asm/ftrace.h        | 27 ++--------------
 arch/powerpc/kernel/trace/ftrace.c       |  4 +--
 arch/powerpc/kernel/trace/ftrace_64_pg.c |  2 +-
 arch/riscv/include/asm/ftrace.h          | 22 +++++++------
 arch/riscv/kernel/asm-offsets.c          | 28 ++++++++--------
 arch/riscv/kernel/ftrace.c               |  2 +-
 arch/s390/include/asm/ftrace.h           | 29 +++--------------
 arch/s390/kernel/asm-offsets.c           |  4 +--
 arch/s390/kernel/ftrace.c                |  2 +-
 arch/s390/lib/test_unwind.c              |  4 +--
 arch/x86/include/asm/ftrace.h            | 30 ++++-------------
 arch/x86/kernel/ftrace.c                 |  2 +-
 include/linux/ftrace.h                   | 55 ++++++++++++--------------------
 include/linux/ftrace_regs.h              | 36 +++++++++++++++++++++
 kernel/trace/fgraph.c                    | 45 ++++++++++++++++----------
 kernel/trace/ftrace.c                    |  5 ++-
 kernel/trace/trace.h                     |  3 +-
 kernel/trace/trace_functions_graph.c     | 22 ++++++-------
 kernel/trace/trace_irqsoff.c             |  3 +-
 kernel/trace/trace_sched_wakeup.c        |  3 +-
 kernel/trace/trace_selftest.c            |  8 ++---
 26 files changed, 188 insertions(+), 232 deletions(-)
 create mode 100644 include/linux/ftrace_regs.h

