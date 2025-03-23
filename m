Return-Path: <linux-kernel+bounces-572823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E695CA6CF25
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD2716D633
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 12:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D594620409F;
	Sun, 23 Mar 2025 12:29:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD4B20485D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742732950; cv=none; b=YBti6obgBXIfl2zmikFw2QZFhy7FDzrTw3S7bb47Fm5JypZjqypsHk4KrtdBWRbNNBi0kut5N56Nv3VxROZqQfSweljbi0Q3gqlH0XiftZ+6OmI+1oLeqwGzbV9dWwFz7QK4qGXuzj/rpXvHX/y8C/+YO+0eugNseA+LpW+40/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742732950; c=relaxed/simple;
	bh=zktrlL6MwMnGHQtwgb7oxUPjv7qx2XirpvxOqqqc0Qg=;
	h=Message-ID:Date:From:To:Cc:Subject; b=bOcWWFcFs2vClEgeKq2R4yPmiyY2kURMshrvBMDG8LFN8BWA9Z5CDk/O+o1RBseqCLlTnS8HYP2J6NvhYB0T5Fw2/+VyoHaP6m6YE6fp2Zcmwb5g2y80KE88VUSgVTckM7d/GlGOuR7x2rSfGB2B79b0dR7CAkymZM3CYeanMBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13F2C4CEE2;
	Sun, 23 Mar 2025 12:29:09 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1twKSb-00000001ydG-0keP;
	Sun, 23 Mar 2025 08:29:49 -0400
Message-ID: <20250323122933.407277911@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 23 Mar 2025 08:29:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/10] tracing: Updates for 6.15
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: 25a5153c91ad23effc44dd349bea749f30208d45


Christophe JAILLET (1):
      tracing: Constify struct event_trigger_ops

Douglas Raillard (3):
      tracing: Align synth event print fmt
      tracing: Ensure module defining synth event cannot be unloaded while tracing
      tracing: Fix synth event printk format for str fields

Gabriele Paoloni (1):
      tracing: fix return value in __ftrace_event_enable_disable for TRACE_REG_UNREGISTER

Huang Shijie (1):
      tracepoint: Print the function symbol when tracepoint_debug is set

Petr Mladek (1):
      tracing: gfp: vsprintf: Do not print "none" when using %pGg printf format

Ran Xiaokai (1):
      tracing/osnoise: Fix possible recursive locking for cpus_read_lock()

Sasha Levin (1):
      tracing: Use hashtable.h for event_hash

Steven Rostedt (1):
      scripts/tracing: Remove scripts/tracing/draw_functrace.py

----
 include/trace/events/mmflags.h      |   2 +-
 kernel/trace/trace.h                |   4 +-
 kernel/trace/trace_eprobe.c         |   6 +-
 kernel/trace/trace_events.c         |   4 +-
 kernel/trace/trace_events_hist.c    |  20 +++---
 kernel/trace/trace_events_synth.c   |  35 +++++++++-
 kernel/trace/trace_events_trigger.c |  38 +++++------
 kernel/trace/trace_osnoise.c        |   1 -
 kernel/trace/trace_output.c         |  19 ++----
 kernel/tracepoint.c                 |   2 +-
 scripts/tracing/draw_functrace.py   | 129 ------------------------------------
 11 files changed, 78 insertions(+), 182 deletions(-)
 delete mode 100755 scripts/tracing/draw_functrace.py

