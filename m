Return-Path: <linux-kernel+bounces-432516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685139E4C61
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28DBA282F10
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 02:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151DC18C924;
	Thu,  5 Dec 2024 02:41:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02471885A5
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 02:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733366471; cv=none; b=Vpi9k/75SGHhxVHQSnhIZjbUiQsGDoUl0j4GVI6Rx+9qKRH9eNgV47qA3IxgvXnckQr8Y84bau6tz0kbwxX+fEt4aw2d+j9G/igWYWEwzYjcJAht1JiYjYRJdFTFNDFDa/+cQ3sSkygDY0U6bOyNUfVs5eIjmNfN/4VU5IhNYMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733366471; c=relaxed/simple;
	bh=L1HzYJzi6gy6IjARKvUPACx5km6Bwr1469sz9pI3b+Y=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=k5DP2tXxHL54WJ6mMyEUp8LGkCR7AMiNoU28zglwlRlvsAx+Qe4fyEortMOMFuigsj1at4IsCX4U96K6zAwB8/lESvtqAYfutyeZnRfu6fgCnWtuhEv+FEOkTuH+TttGzQao680+RIThAyadXgz+JmfppBAD8sPjvKGHdQcX+jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4534EC4CED2;
	Thu,  5 Dec 2024 02:41:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tJ1nn-000000022fJ-36GZ;
	Wed, 04 Dec 2024 21:41:15 -0500
Message-ID: <20241205024115.589822301@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 04 Dec 2024 21:35:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [for-linus][PATCH 2/2] tracing: Fix archs that still call tracepoints without RCU watching
References: <20241205023552.609451828@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Tracepoints require having RCU "watching" as it uses RCU to do updates to
the tracepoints. There are some cases that would call a tracepoint when
RCU was not "watching". This was usually in the idle path where RCU has
"shutdown". For the few locations that had tracepoints without RCU
watching, there was an trace_*_rcuidle() variant that could be used. This
used SRCU for protection.

There are tracepoints that trace when interrupts and preemption are
enabled and disabled. In some architectures, these tracepoints are called
in a path where RCU is not watching. When x86 and arm64 removed these
locations, it was incorrectly assumed that it would be safe to remove the
trace_*_rcuidle() variant and also remove the SRCU logic, as it made the
code more complex and harder to implement new tracepoint features (like
faultable tracepoints and tracepoints in rust).

Instead of bringing back the trace_*_rcuidle(), as it will not be trivial
to do as new code has already been added depending on its removal, add a
workaround to the one file that still requires it (trace_preemptirq.c). If
the architecture does not define CONFIG_ARCH_WANTS_NO_INSTR, then check if
the code is in the idle path, and if so, call ct_irq_enter/exit() which
will enable RCU around the tracepoint.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/20241204100414.4d3e06d0@gandalf.local.home
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 48bcda684823 ("tracing: Remove definition of trace_*_rcuidle()")
Closes: https://lore.kernel.org/all/bddb02de-957a-4df5-8e77-829f55728ea2@roeck-us.net/
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_preemptirq.c | 43 ++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index 5c03633316a6..0c42b15c3800 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -10,11 +10,42 @@
 #include <linux/module.h>
 #include <linux/ftrace.h>
 #include <linux/kprobes.h>
+#include <linux/hardirq.h>
 #include "trace.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/preemptirq.h>
 
+/*
+ * Use regular trace points on architectures that implement noinstr
+ * tooling: these calls will only happen with RCU enabled, which can
+ * use a regular tracepoint.
+ *
+ * On older architectures, RCU may not be watching in idle. In that
+ * case, wake up RCU to watch while calling the tracepoint. These
+ * aren't NMI-safe - so exclude NMI contexts:
+ */
+#ifdef CONFIG_ARCH_WANTS_NO_INSTR
+#define trace(point, args)	trace_##point(args)
+#else
+#define trace(point, args)					\
+	do {							\
+		if (trace_##point##_enabled()) {		\
+			bool exit_rcu = false;			\
+			if (in_nmi())				\
+				break;				\
+			if (!IS_ENABLED(CONFIG_TINY_RCU) &&	\
+			    is_idle_task(current)) {		\
+				ct_irq_enter();			\
+				exit_rcu = true;		\
+			}					\
+			trace_##point(args);			\
+			if (exit_rcu)				\
+				ct_irq_exit();			\
+		}						\
+	} while (0)
+#endif
+
 #ifdef CONFIG_TRACE_IRQFLAGS
 /* Per-cpu variable to prevent redundant calls when IRQs already off */
 static DEFINE_PER_CPU(int, tracing_irq_cpu);
@@ -28,7 +59,7 @@ static DEFINE_PER_CPU(int, tracing_irq_cpu);
 void trace_hardirqs_on_prepare(void)
 {
 	if (this_cpu_read(tracing_irq_cpu)) {
-		trace_irq_enable(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_enable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
 		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
@@ -39,7 +70,7 @@ NOKPROBE_SYMBOL(trace_hardirqs_on_prepare);
 void trace_hardirqs_on(void)
 {
 	if (this_cpu_read(tracing_irq_cpu)) {
-		trace_irq_enable(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_enable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
 		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
@@ -61,7 +92,7 @@ void trace_hardirqs_off_finish(void)
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
 		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
-		trace_irq_disable(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_disable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
 	}
 
 }
@@ -75,7 +106,7 @@ void trace_hardirqs_off(void)
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
 		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
-		trace_irq_disable(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_disable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
 	}
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
@@ -86,13 +117,13 @@ NOKPROBE_SYMBOL(trace_hardirqs_off);
 
 void trace_preempt_on(unsigned long a0, unsigned long a1)
 {
-	trace_preempt_enable(a0, a1);
+	trace(preempt_enable, TP_ARGS(a0, a1));
 	tracer_preempt_on(a0, a1);
 }
 
 void trace_preempt_off(unsigned long a0, unsigned long a1)
 {
-	trace_preempt_disable(a0, a1);
+	trace(preempt_disable, TP_ARGS(a0, a1));
 	tracer_preempt_off(a0, a1);
 }
 #endif
-- 
2.45.2



