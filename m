Return-Path: <linux-kernel+bounces-420345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92FA9D7931
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 00:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685D9162F9C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 23:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577621891AA;
	Sun, 24 Nov 2024 23:49:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13F12500C0
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 23:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732492173; cv=none; b=Yh1YwZmeAhQzfiGPeTaSor662LGIt9cycLnhlqCX1rVSuBKeJEDC2xERqr5iQiuE17RYaT4tFe/GwypmFFOoRlsaOvHi6i4hJAZ/CbCUfCiSHZ0Hluyn5V58YqO4+ezJ4h28yJbBhke8uQTRHNYLXEZtJGpZKdlfHuAxKCEL+CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732492173; c=relaxed/simple;
	bh=J0ZBrRrdg1o0iLnZNJ8OQADhUuuRbbT3zvO0yT572TQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=S9ctZPSWX4YOkei/HP216U4EjNPlzJI7613frdyhq1WI89F0c8Beh+LSIDfsZFh7Fs1B1/z5fTibYyRJimYMI2+dWTTpkiSbKD9OsllGynkb6XHPr8IHUp1pUmkaaB2DaeV3PGuBvsYYLAT1GtaqNnT4KIG4kqpXY+MyFSESh+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8AAC4CED6;
	Sun, 24 Nov 2024 23:49:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tFMMs-00000006vjB-392N;
	Sun, 24 Nov 2024 18:50:18 -0500
Message-ID: <20241124235018.603224910@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 24 Nov 2024 18:49:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ankur Arora <ankur.a.arora@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [for-next][PATCH 1/6] tracing: Record task flag NEED_RESCHED_LAZY.
References: <20241124234940.017394686@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Thomas Gleixner <tglx@linutronix.de>

The scheduler added NEED_RESCHED_LAZY scheduling. Record this state as
part of trace flags and expose it in the need_resched field.

Record and expose NEED_RESCHED_LAZY.

[bigeasy: Commit description, documentation bits.]

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20241122202849.7DfYpJR0@linutronix.de
Reviewed-by: Ankur Arora <ankur.a.arora@oracle.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst |  4 ++++
 include/linux/trace_events.h   |  1 +
 kernel/trace/trace.c           |  2 ++
 kernel/trace/trace_output.c    | 14 +++++++++++++-
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 74d5bd801b1a..272464bb7c60 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1033,9 +1033,13 @@ explains which is which.
   irqs-off: 'd' interrupts are disabled. '.' otherwise.
 
   need-resched:
+	- 'B' all, TIF_NEED_RESCHED, PREEMPT_NEED_RESCHED and TIF_RESCHED_LAZY is set,
 	- 'N' both TIF_NEED_RESCHED and PREEMPT_NEED_RESCHED is set,
 	- 'n' only TIF_NEED_RESCHED is set,
 	- 'p' only PREEMPT_NEED_RESCHED is set,
+	- 'L' both PREEMPT_NEED_RESCHED and TIF_RESCHED_LAZY is set,
+	- 'b' both TIF_NEED_RESCHED and TIF_RESCHED_LAZY is set,
+	- 'l' only TIF_RESCHED_LAZY is set
 	- '.' otherwise.
 
   hardirq/softirq:
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 016b29a56c87..2a5df5b62cfc 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -184,6 +184,7 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status);
 
 enum trace_flag_type {
 	TRACE_FLAG_IRQS_OFF		= 0x01,
+	TRACE_FLAG_NEED_RESCHED_LAZY	= 0x02,
 	TRACE_FLAG_NEED_RESCHED		= 0x04,
 	TRACE_FLAG_HARDIRQ		= 0x08,
 	TRACE_FLAG_SOFTIRQ		= 0x10,
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3ef047ed9705..be62f0ea1814 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2552,6 +2552,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
 		trace_flags |= TRACE_FLAG_NEED_RESCHED;
 	if (test_preempt_need_resched())
 		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
+	if (IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY) && tif_test_bit(TIF_NEED_RESCHED_LAZY))
+		trace_flags |= TRACE_FLAG_NEED_RESCHED_LAZY;
 	return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
 		(min_t(unsigned int, migration_disable_value(), 0xf)) << 4;
 }
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index e08aee34ef63..da748b7cbc4d 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -462,17 +462,29 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
 		bh_off ? 'b' :
 		'.';
 
-	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED |
+	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY |
 				TRACE_FLAG_PREEMPT_RESCHED)) {
+	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
+		need_resched = 'B';
+		break;
 	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_PREEMPT_RESCHED:
 		need_resched = 'N';
 		break;
+	case TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
+		need_resched = 'L';
+		break;
+	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY:
+		need_resched = 'b';
+		break;
 	case TRACE_FLAG_NEED_RESCHED:
 		need_resched = 'n';
 		break;
 	case TRACE_FLAG_PREEMPT_RESCHED:
 		need_resched = 'p';
 		break;
+	case TRACE_FLAG_NEED_RESCHED_LAZY:
+		need_resched = 'l';
+		break;
 	default:
 		need_resched = '.';
 		break;
-- 
2.45.2



