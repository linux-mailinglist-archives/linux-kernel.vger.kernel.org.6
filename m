Return-Path: <linux-kernel+bounces-433457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A4B9E589A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6036116B1A5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C5B219A9F;
	Thu,  5 Dec 2024 14:37:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089B7149C64
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409442; cv=none; b=p5EfiBqbEzDTFnUDCiY6KD+67/04BjRpHh6EgF5mJ47ZriAu1TQiuIHv6SayvOJrHfKgXMxksY7opqLnMgT6vqliKc0jZYYSgo+4YO6BeY1ODo+D7RRVTaSYSXTinfzon9m8te1WamDehFpBZPudP9iC1CqkehDKYUDzc8ym9bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409442; c=relaxed/simple;
	bh=Uv5cnZSdWJQlAkk38mqPhZG0G9lGTjupsKRDQSia+J0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=czOyc1SNGoEE5z/+RLkBLrZCMdnKCTdXLaQYHb0SRo6QNYG5NWevZAtFiq0tge0cptuMcflGKK8quYiqT+iuZcN16/QUMdeONUa/2+lir74Syul+3cV85Y05saVwmFb0I4OjtGPUdkPlN7dNU/X6ZUiYh1j67bVAQmtf2aR6z3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26139C4CED1;
	Thu,  5 Dec 2024 14:37:19 +0000 (UTC)
Date: Thu, 5 Dec 2024 09:37:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, "Paul E. McKenney" <paulmck@kernel.org>, Guenter
 Roeck <linux@roeck-us.net>, Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] tracing: Fixes for v6.13-rc1
Message-ID: <20241205093724.16c2a14d@gandalf.local.home>
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

tracing fixes for v6.13:

- Fix trace histogram sort function cmp_entries_dup()

  The sort function cmp_entries_dup() returns either 1 or 0, and not
  -1 if parameter "a" is less than "b" by memcmp().

- Fix archs that call trace_hardirqs_off() without RCU watching

  Both x86 and arm64 no longer call any tracepoints with RCU not
  watching. It was assumed that it was safe to get rid of
  trace_*_rcuidle() version of the tracepoint calls. This was needed
  to get rid of the SRCU protection and be able to implement features
  like faultable traceponits and add rust tracepoints.

  Unfortunately, there were a few architectures that still relied on
  that logic. There's only one file that has tracepoints that are
  called without RCU watching. Add macro logic around the tracepoints
  for architectures that do not have CONFIG_ARCH_WANTS_NO_INSTR defined
  will check if the code is in the idle path (the only place RCU isn't
  watching), and enable RCU around calling the tracepoint, but only
  do it if the tracepoint is enabled.


Please pull the latest trace-v6.13-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.13-rc1

Tag SHA1: 37bbbac90061b19b3ea6410a57a20742fd648ea6
Head SHA1: dc1b157b828dfe412c776ac1dd8db158f6016b39


Kuan-Wei Chiu (1):
      tracing: Fix cmp_entries_dup() to respect sort() comparison rules

Steven Rostedt (1):
      tracing: Fix archs that still call tracepoints without RCU watching

----
 kernel/trace/trace_preemptirq.c | 43 +++++++++++++++++++++++++++++++++++------
 kernel/trace/tracing_map.c      |  6 +-----
 2 files changed, 38 insertions(+), 11 deletions(-)
---------------------------
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
diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 3a56e7c8aa4f..1921ade45be3 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -845,15 +845,11 @@ int tracing_map_init(struct tracing_map *map)
 static int cmp_entries_dup(const void *A, const void *B)
 {
 	const struct tracing_map_sort_entry *a, *b;
-	int ret = 0;
 
 	a = *(const struct tracing_map_sort_entry **)A;
 	b = *(const struct tracing_map_sort_entry **)B;
 
-	if (memcmp(a->key, b->key, a->elt->map->key_size))
-		ret = 1;
-
-	return ret;
+	return memcmp(a->key, b->key, a->elt->map->key_size);
 }
 
 static int cmp_entries_sum(const void *A, const void *B)

