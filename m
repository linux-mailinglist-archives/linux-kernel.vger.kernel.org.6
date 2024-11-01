Return-Path: <linux-kernel+bounces-392068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C83D9B8F5A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6181F220AB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAF919B3EE;
	Fri,  1 Nov 2024 10:36:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52C41684B0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457368; cv=none; b=sRwY6ntARRKY5w/elx+wd17GBo+/n4mgtR9uQiX7PjxyYi9DpJLQX9YrC57CISCEmitTBjPWfO7GUffSqyEjgu86nDxYc+cvuzD4UFl1LLFS6TtXVcrG5xvDj0gVsuFKjKdGwxvd+t3k+Md6qvQWWprd/qNnGL+NF+XhyWxtViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457368; c=relaxed/simple;
	bh=KPirqsmIwmM16waJQYf5E8xXziiXfrpUSR1ELMhWgV8=;
	h=Message-ID:Date:From:To:Cc:Subject; b=cszFwDGKTbi9zG2DNghh32p6WObCxKeeKRmB1A3/nlviOFw6b6zhFSNaJMgC3qcPX6nWvLmlhLjE+dEfz1erAOoENAgMwUnvWQ8GWfJNRn5Tq2nHHDFEsU45fUXhEUXk6/oX8FBcztojlg56y16xHVsVhSKjWwChQ96aCm29JKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7A5C4CECD;
	Fri,  1 Nov 2024 10:36:08 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t6p1e-00000005S3v-3xGw;
	Fri, 01 Nov 2024 06:37:06 -0400
Message-ID: <20241101103647.011707614@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 01 Nov 2024 06:36:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/11] tracing: Updates for 6.13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: 773180c19386a6ee07368178bb58a3f185e8005d


Jinjie Ruan (1):
      tracing: Replace strncpy() with strscpy() when copying comm

Justin Stitt (1):
      tracing: Replace multiple deprecated strncpy with memcpy

Mathieu Desnoyers (4):
      tracing: Introduce tracepoint extended structure
      tracing: Introduce tracepoint_is_faultable()
      tracing: Fix syscall tracepoint use-after-free
      tracing: Add might_fault() check in __DECLARE_TRACE_SYSCALL

Nir Lichtman (1):
      kdb: Remove fallback interpretation of arbitrary numbers as hex

Ryan Roberts (1):
      tracing: Make percpu stack trace buffer invariant to PAGE_SIZE

Sebastian Andrzej Siewior (1):
      tracing: Remove TRACE_FLAG_IRQS_NOSUPPORT

Yuran Pereira (2):
      kdb: Replace the use of simple_strto with safer kstrto in kdb_main
      trace: kdb: Replace simple_strtoul with kstrtoul in kdb_ftdump

----
 Documentation/trace/ftrace.rst     |  3 --
 include/linux/trace_events.h       | 13 -------
 include/linux/tracepoint-defs.h    | 10 ++++--
 include/linux/tracepoint.h         | 44 ++++++++++++++++++++----
 include/trace/define_trace.h       |  2 +-
 kernel/debug/kdb/kdb_main.c        | 69 ++++++++++----------------------------
 kernel/trace/trace.c               |  4 +--
 kernel/trace/trace_events_filter.c |  8 ++---
 kernel/trace/trace_events_hist.c   |  4 +--
 kernel/trace/trace_kdb.c           | 13 +++----
 kernel/trace/trace_output.c        |  1 -
 kernel/trace/trace_sched_switch.c  |  2 +-
 kernel/tracepoint.c                | 20 ++++++-----
 13 files changed, 89 insertions(+), 104 deletions(-)

