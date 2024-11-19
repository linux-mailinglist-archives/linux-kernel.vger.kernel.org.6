Return-Path: <linux-kernel+bounces-413768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FBA9D1E61
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA1128131A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8BE142E7C;
	Tue, 19 Nov 2024 02:40:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A562213B792
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731984016; cv=none; b=nqle806MMuqODI6jkjcT7RXJLVq9Wo7F+LkL/4qCPDcV2bLNMgEz/srmga3SmifpmuxmuPv9bChvrAKREH6u8bfCR9XiKJ3fXyhdruRQCUmNBj6zSKRtOjfZ40iDqe/KH/Ha96iJkbKjbi+Km1Xy1UwzB0yN5b+PqRtdKcbaD2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731984016; c=relaxed/simple;
	bh=Nhl7lux8kkpCB6lgSQ6dViQBNDnO3wHpyDyLwFi/sHM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kV7hPFFjwQEIx8YEnv6Lzzgf31v/2dolidoHpWg9G/wltHqlFPA4sSN1uCcCEH2pdnJhSwRf5xR1OZpxUI6O257hDs+JDWXBmp6C0AfJHuo9RyfZwHaKoz/4j0TlWtNS9O8OVjPYBocxeLm//FwxtUIoo+dS8jcHWI/6JRdXOog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F00FC4CED9;
	Tue, 19 Nov 2024 02:40:16 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tDEAb-0000000ED3y-0cLQ;
	Mon, 18 Nov 2024 21:40:49 -0500
Message-ID: <20241119024048.996193419@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 18 Nov 2024 21:40:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tatsuya S <tatsuya.s2862@gmail.com>
Subject: [for-next][PATCH 3/3] tracing: Fix function name for trampoline
References: <20241119024016.371665360@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tatsuya S <tatsuya.s2862@gmail.com>

The issue that unrelated function name is shown on stack trace like
following even though it should be trampoline code address is caused by
the creation of trampoline code in the area where .init.text section
of module was freed after module is loaded.

bash-1344    [002] .....    43.644608: <stack trace>
=> (MODULE INIT FUNCTION)
=> vfs_write
=> ksys_write
=> do_syscall_64
=> entry_SYSCALL_64_after_hwframe

To resolve this, when function address of stack trace entry is in
trampoline, output without looking up symbol name.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20241021071454.34610-2-tatsuya.s2862@gmail.com
Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c        | 33 +++++++++++++++++++++++++--------
 kernel/trace/trace.h        |  7 +++++++
 kernel/trace/trace_output.c |  4 ++++
 3 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a587fd7d7447..566d99f9f086 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -975,7 +975,8 @@ static inline void trace_access_lock_init(void)
 #endif
 
 #ifdef CONFIG_STACKTRACE
-static void __ftrace_trace_stack(struct trace_buffer *buffer,
+static void __ftrace_trace_stack(struct trace_array *tr,
+				 struct trace_buffer *buffer,
 				 unsigned int trace_ctx,
 				 int skip, struct pt_regs *regs);
 static inline void ftrace_trace_stack(struct trace_array *tr,
@@ -984,7 +985,8 @@ static inline void ftrace_trace_stack(struct trace_array *tr,
 				      int skip, struct pt_regs *regs);
 
 #else
-static inline void __ftrace_trace_stack(struct trace_buffer *buffer,
+static inline void __ftrace_trace_stack(struct trace_array *tr,
+					struct trace_buffer *buffer,
 					unsigned int trace_ctx,
 					int skip, struct pt_regs *regs)
 {
@@ -2912,7 +2914,8 @@ struct ftrace_stacks {
 static DEFINE_PER_CPU(struct ftrace_stacks, ftrace_stacks);
 static DEFINE_PER_CPU(int, ftrace_stack_reserve);
 
-static void __ftrace_trace_stack(struct trace_buffer *buffer,
+static void __ftrace_trace_stack(struct trace_array *tr,
+				 struct trace_buffer *buffer,
 				 unsigned int trace_ctx,
 				 int skip, struct pt_regs *regs)
 {
@@ -2958,6 +2961,20 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 		nr_entries = stack_trace_save(fstack->calls, size, skip);
 	}
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+	/* Mark entry of stack trace as trampoline code */
+	if (tr->ops && tr->ops->trampoline) {
+		unsigned long tramp_start = tr->ops->trampoline;
+		unsigned long tramp_end = tramp_start + tr->ops->trampoline_size;
+		unsigned long *calls = fstack->calls;
+
+		for (int i = 0; i < nr_entries; i++) {
+			if (calls[i] >= tramp_start && calls[i] < tramp_end)
+				calls[i] = FTRACE_TRAMPOLINE_MARKER;
+		}
+	}
+#endif
+
 	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
 				    struct_size(entry, caller, nr_entries),
 				    trace_ctx);
@@ -2987,7 +3004,7 @@ static inline void ftrace_trace_stack(struct trace_array *tr,
 	if (!(tr->trace_flags & TRACE_ITER_STACKTRACE))
 		return;
 
-	__ftrace_trace_stack(buffer, trace_ctx, skip, regs);
+	__ftrace_trace_stack(tr, buffer, trace_ctx, skip, regs);
 }
 
 void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
@@ -2996,7 +3013,7 @@ void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
 
 	if (rcu_is_watching()) {
-		__ftrace_trace_stack(buffer, trace_ctx, skip, NULL);
+		__ftrace_trace_stack(tr, buffer, trace_ctx, skip, NULL);
 		return;
 	}
 
@@ -3013,7 +3030,7 @@ void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
 		return;
 
 	ct_irq_enter_irqson();
-	__ftrace_trace_stack(buffer, trace_ctx, skip, NULL);
+	__ftrace_trace_stack(tr, buffer, trace_ctx, skip, NULL);
 	ct_irq_exit_irqson();
 }
 
@@ -3030,8 +3047,8 @@ void trace_dump_stack(int skip)
 	/* Skip 1 to skip this function. */
 	skip++;
 #endif
-	__ftrace_trace_stack(printk_trace->array_buffer.buffer,
-			     tracing_gen_ctx(), skip, NULL);
+	__ftrace_trace_stack(printk_trace, printk_trace->array_buffer.buffer,
+				tracing_gen_ctx(), skip, NULL);
 }
 EXPORT_SYMBOL_GPL(trace_dump_stack);
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 638f452eec10..6e66b666c3e9 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2172,4 +2172,11 @@ static inline int rv_init_interface(void)
 }
 #endif
 
+/*
+ * This is used only to distinguish
+ * function address from trampoline code.
+ * So this value has no meaning.
+ */
+#define FTRACE_TRAMPOLINE_MARKER  ((unsigned long) INT_MAX)
+
 #endif /* _LINUX_KERNEL_TRACE_H */
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 2ee6613dce6d..e08aee34ef63 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1245,6 +1245,10 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
 			break;
 
 		trace_seq_puts(s, " => ");
+		if ((*p) == FTRACE_TRAMPOLINE_MARKER) {
+			trace_seq_puts(s, "[FTRACE TRAMPOLINE]\n");
+			continue;
+		}
 		seq_print_ip_sym(s, (*p) + delta, flags);
 		trace_seq_putc(s, '\n');
 	}
-- 
2.45.2



