Return-Path: <linux-kernel+bounces-302963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9870396058D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDB51C227A3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D993419FA6B;
	Tue, 27 Aug 2024 09:27:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF14919DFB8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750824; cv=none; b=MfiJHJR/qwOpcW22Ngl+0G3lFnJT2PqsDtOYQ5AXWhK3gzGBClotVTwVi8T2IcnZoNvSw9Junf/iWUxTZDlhn8DbWS/HB4yTq/bBz2DH8/fl8960GQaQzNJL1ZwiZC7CtD+L449EF50Ib4VMowYV6hLcG+vVaTQYVh7+zu5enQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750824; c=relaxed/simple;
	bh=tynU/d4Be9ZcuLtBouPQyAlIHYILeSRyw/x2aNqlZR4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OJ80ybSC9zYQWWz1J7dHwaC/O7yMD6yTYb1EUBeZK6iztgK8ebnRBN6haEQvYsAUEJIa9UXkxZRR03Lw2ZYix8YffflCOVUL74Cbyxb+gjE5gM1YzdayYGuK+RlkMYlj6i8+lNoNlGjieFoy/L/9XvfC1cYhSxuCrxy67ngMgF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F664C8B7C0;
	Tue, 27 Aug 2024 09:27:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sisUN-00000004SND-0ZtR;
	Tue, 27 Aug 2024 05:27:47 -0400
Message-ID: <20240827092746.999458647@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 27 Aug 2024 05:27:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 David Howells <dhowells@redhat.com>,
 Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Tony Luck <tony.luck@intel.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Ross Zwisler <zwisler@google.com>,
 Kees Cook <keescook@chromium.org>,
 Alexander Aring <aahringo@redhat.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Clark Williams <williams@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Jonathan Corbet" <corbet@lwn.net>
Subject: [for-next][PATCH 6/8] tracing: Have trace_printk not use binary prints if boot buffer
References: <20240827092716.515115830@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

If the persistent boot mapped ring buffer is used for trace_printk(),
force it to not use the binary versions. trace_printk() by default uses
bin_printf() that only saves the pointer to the format and not the format
itself inside the ring buffer. But for a persistent buffer that is read
after reboot, the pointers to the format strings may not be the same, or
worse, not even exist! Instead, just force the more robust, but slower,
version that does the formatting before saving into the ring buffer.

The boot mapped buffer can now be used for trace_printk and friends!

Using the trace_printk() and the persistent buffer was used to debug the
issue with the osnoise tracer:

Link: https://lore.kernel.org/all/20240822103443.6a6ae051@gandalf.local.home/

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vincent Donnefort <vdonnefort@google.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vineeth Pillai <vineeth@bitbyteword.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Ross Zwisler <zwisler@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Alexander Aring <aahringo@redhat.com>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Jonathan Corbet" <corbet@lwn.net>
Link: https://lore.kernel.org/20240823014019.386925800@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../admin-guide/kernel-parameters.txt         |  4 +-
 kernel/trace/trace.c                          | 44 ++++++++++++-------
 kernel/trace/trace.h                          |  3 +-
 kernel/trace/trace_output.c                   |  5 ++-
 4 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a8803c0c0a89..9e507e6cb4c8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6751,8 +6751,6 @@
 			    traceoff	- Have the tracing instance tracing disabled after it is created.
 			    traceprintk	- Have trace_printk() write into this trace instance
 					  (note, "printk" and "trace_printk" can also be used)
-					  Currently, traceprintk flag cannot be used for memory
-					  mapped ring buffers as described below.
 
 				trace_instance=foo^traceoff^traceprintk,sched,irq
 
@@ -6785,7 +6783,7 @@
 			mix with events of the current boot (unless you are debugging a random crash
 			at boot up).
 
-				reserve_mem=12M:4096:trace trace_instance=boot_map^traceoff@trace,sched,irq
+				reserve_mem=12M:4096:trace trace_instance=boot_map^traceoff^traceprintk@trace,sched,irq
 
 
 	trace_options=[option-list]
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8e28f19f5316..35b37c9aa26c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -502,6 +502,17 @@ static struct trace_array global_trace = {
 
 static struct trace_array *printk_trace = &global_trace;
 
+static __always_inline bool printk_binsafe(struct trace_array *tr)
+{
+	/*
+	 * The binary format of traceprintk can cause a crash if used
+	 * by a buffer from another boot. Force the use of the
+	 * non binary version of trace_printk if the trace_printk
+	 * buffer is a boot mapped ring buffer.
+	 */
+	return !(tr->flags & TRACE_ARRAY_FL_BOOT);
+}
+
 void trace_set_ring_buffer_expanded(struct trace_array *tr)
 {
 	if (!tr)
@@ -1130,7 +1141,7 @@ EXPORT_SYMBOL_GPL(__trace_puts);
  */
 int __trace_bputs(unsigned long ip, const char *str)
 {
-	struct trace_array *tr = printk_trace;
+	struct trace_array *tr = READ_ONCE(printk_trace);
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer;
 	struct bputs_entry *entry;
@@ -1138,6 +1149,9 @@ int __trace_bputs(unsigned long ip, const char *str)
 	int size = sizeof(struct bputs_entry);
 	int ret = 0;
 
+	if (!printk_binsafe(tr))
+		return __trace_puts(ip, str, strlen(str));
+
 	if (!(tr->trace_flags & TRACE_ITER_PRINTK))
 		return 0;
 
@@ -3247,12 +3261,15 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 	struct trace_event_call *call = &event_bprint;
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer;
-	struct trace_array *tr = printk_trace;
+	struct trace_array *tr = READ_ONCE(printk_trace);
 	struct bprint_entry *entry;
 	unsigned int trace_ctx;
 	char *tbuffer;
 	int len = 0, size;
 
+	if (!printk_binsafe(tr))
+		return trace_vprintk(ip, fmt, args);
+
 	if (unlikely(tracing_selftest_running || tracing_disabled))
 		return 0;
 
@@ -10560,20 +10577,17 @@ __init static void enable_instances(void)
 		if (traceoff)
 			tracer_tracing_off(tr);
 
-		if (traceprintk) {
-			/*
-			 * The binary format of traceprintk can cause a crash if used
-			 * by a buffer from another boot. Do not allow it for the
-			 * memory mapped ring buffers.
-			 */
-			if (start)
-				pr_warn("Tracing: WARNING: memory mapped ring buffers cannot be used for trace_printk\n");
-			else
-				printk_trace = tr;
-		}
+		if (traceprintk)
+			printk_trace = tr;
 
-		/* Only allow non mapped buffers to be deleted */
-		if (!start)
+		/*
+		 * If start is set, then this is a mapped buffer, and
+		 * cannot be deleted by user space, so keep the reference
+		 * to it.
+		 */
+		if (start)
+			tr->flags |= TRACE_ARRAY_FL_BOOT;
+		else
 			trace_array_put(tr);
 
 		while ((tok = strsep(&curr_str, ","))) {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 4f448ab2d1e7..07b2d2af9b33 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -429,7 +429,8 @@ struct trace_array {
 };
 
 enum {
-	TRACE_ARRAY_FL_GLOBAL	= (1 << 0)
+	TRACE_ARRAY_FL_GLOBAL	= BIT(0),
+	TRACE_ARRAY_FL_BOOT	= BIT(1),
 };
 
 extern struct list_head ftrace_trace_arrays;
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 48de93598897..868f2f912f28 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1591,10 +1591,13 @@ static enum print_line_t trace_print_print(struct trace_iterator *iter,
 {
 	struct print_entry *field;
 	struct trace_seq *s = &iter->seq;
+	unsigned long ip;
 
 	trace_assign_type(field, iter->ent);
 
-	seq_print_ip_sym(s, field->ip, flags);
+	ip = field->ip + iter->tr->text_delta;
+
+	seq_print_ip_sym(s, ip, flags);
 	trace_seq_printf(s, ": %s", field->buf);
 
 	return trace_handle_return(s);
-- 
2.43.0



