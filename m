Return-Path: <linux-kernel+bounces-359265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D79AF998988
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DCF81F22BF8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950681CF28E;
	Thu, 10 Oct 2024 14:25:42 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3AD1CBE92
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570342; cv=none; b=Fm3GaAwDJAgdSv3rSd4uT8y75Kt/5zBOEnEltaK9IuYvY7eQ/7f3qKvbYk8Cf7OaXYxcSIKfg7ASSy54Q25bHyShvyRZ/0GW74mygLKH4rNxnixf9FVe/pY3/XgQcS/YWW8uAsuy2HmLJr4+BnrXPM/bZntw/sN1rXF1RP5ip0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570342; c=relaxed/simple;
	bh=2rZkopSpPhf5J8+EuIDLDP9+fB0XnQ1YmFHjGHiUydw=;
	h=Message-ID:Date:From:To:Cc:Subject; b=JNROK3na4tsq6e/E1N1qhGVJXwOIULtrXWU+mIFTw4zbzd3CbRBs75EhE7cNcyu9X0aituO3OfXoYiKy5154b/BbrnThbI+yLTDJ0ZbccEs3YdDvYTxOkshJGG5xuZzhq+HWnNot5n6HdmAY0jO49cHBJ8RDfqBbuTht1yFyxEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16FAC4CECC;
	Thu, 10 Oct 2024 14:25:41 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1syu6v-00000001HGM-2pHo;
	Thu, 10 Oct 2024 10:25:49 -0400
Message-ID: <20241010142537.255433162@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 10 Oct 2024 10:25:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/10] tracing: Updates for 6.13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: eb887c4567d1b0e7684c026fe7df44afa96589e6


Levi Yun (1):
      trace/trace_event_perf: remove duplicate samples on the first tracepoint event

Mathieu Desnoyers (8):
      tracing: Declare system call tracepoints with TRACE_EVENT_SYSCALL
      tracing/ftrace: disable preemption in syscall probe
      tracing/perf: disable preemption in syscall probe
      tracing/bpf: disable preemption in syscall probe
      tracing: Allow system call tracepoints to handle page faults
      tracing/ftrace: Add might_fault check to syscall probes
      tracing/perf: Add might_fault check to syscall probes
      tracing/bpf: Add might_fault check to syscall probes

Uros Bizjak (1):
      tracing: Use atomic64_inc_return() in trace_clock_counter()

----
 include/linux/tracepoint.h      | 71 ++++++++++++++++++++++++++++++++---------
 include/trace/bpf_probe.h       | 14 ++++++++
 include/trace/define_trace.h    |  5 +++
 include/trace/events/syscalls.h |  4 +--
 include/trace/perf.h            | 44 +++++++++++++++++++++++--
 include/trace/trace_events.h    | 62 ++++++++++++++++++++++++++++++++---
 init/Kconfig                    |  1 +
 kernel/trace/trace_clock.c      |  2 +-
 kernel/trace/trace_event_perf.c |  6 ++++
 kernel/trace/trace_syscalls.c   | 28 ++++++++++++++++
 10 files changed, 212 insertions(+), 25 deletions(-)

