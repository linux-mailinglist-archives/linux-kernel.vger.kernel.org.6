Return-Path: <linux-kernel+bounces-446234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB449F2188
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 00:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5471886E3F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 23:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E5718DF93;
	Sat, 14 Dec 2024 23:21:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E65D38DD3
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 23:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734218502; cv=none; b=SJJ4u02DeFf05KfoaGJeECx2rR7VUj1Md2EaYjJOhAItw5qJjp1jJPJAvdRtPjgb3vPhe7tyx7d1Z67wCTLQ0S8a9FrIawwy8evi2oX8QYfSqoLYtv1qaJ8kSo1Kwftmo8GZnPAoDvlbFWmGUXrKa2fSOdPl4+NLUOEzPHquH9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734218502; c=relaxed/simple;
	bh=3Jlr+Z7ExdmQldssAoHzDja2m7I1Ad/JJjbCiaVUwpo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bs/DFSiu29l6E2e2fQ4IfrZE69HBU3GeroiFMmOSz9Ge2P7xM8GelvE8sm/Yv2S0VfjHNIi0n6MxKjqzXaNJr1WOWbuxkvr535HOh4mVff+OWJnggOwo53S1wJreVP8QO7sNJVGpWhYPkDKJ/aig8BWuQR+vguqiG0wBGJ8mdgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB886C4CED1;
	Sat, 14 Dec 2024 23:21:40 +0000 (UTC)
Date: Sat, 14 Dec 2024 18:21:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro
 <viro@ZenIV.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] ftrace: Fixes for v6.13
Message-ID: <20241214182138.4e7984a2@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Linus,

Ftrace fixes for 6.13:

- Fix output of trace when hashing a pointer is disabled

  Pointers are recorded into the ring buffer by simply copying them.
  When the ring buffer is read directly in binary format, the
  pointers are unhashed, and tools like perf will show them as such.
  But when the pointers are printed from the trace file, they are
  hashed because the output from the trace uses vsnprintf() which will
  hash "%p". Since the tracing infrastructure requires just as much
  privileged as kallsyms this was an unneeded protection. An option
  was created to allow the pointers to not be hashed, as in some cases
  in debugging, the unhashed pointer was required.

  To do this, the unhashing would add a "x" after a "%p" to make it
  "%px" and not have the call to vsnprintf() hash. It used the iter->fmt
  temp buffer to accomplish this. The problem was that the iter->fmt temp
  buffer was already being used as a temp buffer to check if pointers in the
  event format output were being called indirectly (like using a "%pI4" or
  "%pI6") where the pointer may be pointing to a freed location. The check
  code will catch that.

  The issue was that when the hash pointer was being disabled, the
  logic that used the temporary iter->fmt buffer passed that buffer
  to the function that would test bad pointers and that function
  would use iter->fmt buffer as well, causing the output to be
  screwed up.

  The solution was to change the bad pointer logic to use the iter->fmt
  buffer directly and not as a temp buffer. If the fmt parameter passed
  in was not the iter->fmt buffer, it would copy the content to the
  iter->fmt buffer and process that buffer directly. This now allows
  passing the iter->fmt buffer as the fmt parameter to the bad pointer
  check function. The nohash function that added the "%px" would not be an
  issue when passing the iter->fmt to the check function as the format to
  check.

- Always try to initialize the idle functions when graph tracer starts

  A bug was found that when a CPU is offline when graph tracing starts
  and then comes online, that CPU is not traced. The fix to that was
  to move the initialization of the idle shadow stack over to the
  hot plug online logic, which also handle onlined CPUs. The issue was
  that it removed the initialization of the shadow stack when graph tracing
  starts, but the callbacks to the hot plug logic do nothing if graph
  tracing isn't currently running. Although that fix fixed the onlining
  of a CPU during tracing, it broke the CPUs that were already online.

- Have microblaze not try to get the "true parent" in function tracing

  If function tracing and graph tracing are both enabled at the same time
  the parent of the functions traced by the function tracer may sometimes
  be the graph tracing trampoline. The graph tracing hijacks the return
  pointer of the function to trace it, but that can interfere with the
  function tracing parent output. This was fixed by using the
  ftrace_graph_ret_addr() function passing in the kernel stack pointer
  using the ftrace_regs_get_stack_pointer() function. But Al Viro reported
  that Microblaze does not implement the kernel_stack_pointer(regs)
  helper function that ftrace_regs_get_stack_pointer() uses and fails
  to compile when function graph tracing is enabled.

  The real fix would be to have microblaze implement the kernel_stack_pointer()
  function. For now, just make microblaze use the old logic which prints the
  function graph trampoline in the function tracer.


Please pull the latest ftrace-v6.13-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace-v6.13-rc2

Tag SHA1: bdc021d764d3b571031c195506eb0eed208b2087
Head SHA1: 607f2f4884c1a66c297cd0fb35d5523538d18b90


Steven Rostedt (3):
      tracing: Fix trace output when pointer hash is disabled
      fgraph: Still initialize idle shadow stacks when starting
      ftrace/microblaze: Do not find "true_parent" for return address

----
 kernel/trace/fgraph.c          |  8 +++-
 kernel/trace/trace.c           | 90 ++++++++++++++++++++++++++----------------
 kernel/trace/trace_functions.c |  3 +-
 3 files changed, 64 insertions(+), 37 deletions(-)
---------------------------
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 0bf78517b5d4..ddedcb50917f 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1215,7 +1215,7 @@ void fgraph_update_pid_func(void)
 static int start_graph_tracing(void)
 {
 	unsigned long **ret_stack_list;
-	int ret;
+	int ret, cpu;
 
 	ret_stack_list = kcalloc(FTRACE_RETSTACK_ALLOC_SIZE,
 				 sizeof(*ret_stack_list), GFP_KERNEL);
@@ -1223,6 +1223,12 @@ static int start_graph_tracing(void)
 	if (!ret_stack_list)
 		return -ENOMEM;
 
+	/* The cpu_boot init_task->ret_stack will never be freed */
+	for_each_online_cpu(cpu) {
+		if (!idle_task(cpu)->ret_stack)
+			ftrace_graph_init_idle_task(idle_task(cpu), cpu);
+	}
+
 	do {
 		ret = alloc_retstack_tasklist(ret_stack_list);
 	} while (ret == -EAGAIN);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index be62f0ea1814..b44b1cdaa20e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3711,8 +3711,10 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 {
 	long text_delta = 0;
 	long data_delta = 0;
-	const char *p = fmt;
 	const char *str;
+	char save_ch;
+	char *buf = NULL;
+	char *p;
 	bool good;
 	int i, j;
 
@@ -3720,7 +3722,7 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		return;
 
 	if (static_branch_unlikely(&trace_no_verify))
-		goto print;
+		goto print_fmt;
 
 	/*
 	 * When the kernel is booted with the tp_printk command line
@@ -3735,8 +3737,21 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 
 	/* Don't bother checking when doing a ftrace_dump() */
 	if (iter->fmt == static_fmt_buf)
-		goto print;
+		goto print_fmt;
 
+	if (fmt != iter->fmt) {
+		int len = strlen(fmt);
+		while (iter->fmt_size < len + 1) {
+			/*
+			 * If we can't expand the copy buffer,
+			 * just print it.
+			 */
+			if (!trace_iter_expand_format(iter))
+				goto print_fmt;
+		}
+		strscpy(iter->fmt, fmt, iter->fmt_size);
+	}
+	p = iter->fmt;
 	while (*p) {
 		bool star = false;
 		int len = 0;
@@ -3748,14 +3763,6 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		 * as well as %p[sS] if delta is non-zero
 		 */
 		for (i = 0; p[i]; i++) {
-			if (i + 1 >= iter->fmt_size) {
-				/*
-				 * If we can't expand the copy buffer,
-				 * just print it.
-				 */
-				if (!trace_iter_expand_format(iter))
-					goto print;
-			}
 
 			if (p[i] == '\\' && p[i+1]) {
 				i++;
@@ -3788,10 +3795,11 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		if (!p[i])
 			break;
 
-		/* Copy up to the %s, and print that */
-		strncpy(iter->fmt, p, i);
-		iter->fmt[i] = '\0';
-		trace_seq_vprintf(&iter->seq, iter->fmt, ap);
+		/* Print up to the %s */
+		save_ch = p[i];
+		p[i] = '\0';
+		trace_seq_vprintf(&iter->seq, p, ap);
+		p[i] = save_ch;
 
 		/* Add delta to %pS pointers */
 		if (p[i+1] == 'p') {
@@ -3837,6 +3845,8 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 			good = trace_safe_str(iter, str, star, len);
 		}
 
+		p += i;
+
 		/*
 		 * If you hit this warning, it is likely that the
 		 * trace event in question used %s on a string that
@@ -3849,41 +3859,51 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		if (WARN_ONCE(!good, "fmt: '%s' current_buffer: '%s'",
 			      fmt, seq_buf_str(&iter->seq.seq))) {
 			int ret;
+#define TEMP_BUFSIZ 1024
+
+			if (!buf) {
+				char *buf = kmalloc(TEMP_BUFSIZ, GFP_KERNEL);
+				if (!buf) {
+					/* Need buffer to read address */
+					trace_seq_printf(&iter->seq, "(0x%px)[UNSAFE-MEMORY]", str);
+					p += j + 1;
+					goto print;
+				}
+			}
+			if (len >= TEMP_BUFSIZ)
+				len = TEMP_BUFSIZ - 1;
 
 			/* Try to safely read the string */
 			if (star) {
-				if (len + 1 > iter->fmt_size)
-					len = iter->fmt_size - 1;
-				if (len < 0)
-					len = 0;
-				ret = copy_from_kernel_nofault(iter->fmt, str, len);
-				iter->fmt[len] = 0;
-				star = false;
+				ret = copy_from_kernel_nofault(buf, str, len);
+				buf[len] = 0;
 			} else {
-				ret = strncpy_from_kernel_nofault(iter->fmt, str,
-								  iter->fmt_size);
+				ret = strncpy_from_kernel_nofault(buf, str, TEMP_BUFSIZ);
 			}
 			if (ret < 0)
 				trace_seq_printf(&iter->seq, "(0x%px)", str);
 			else
-				trace_seq_printf(&iter->seq, "(0x%px:%s)",
-						 str, iter->fmt);
-			str = "[UNSAFE-MEMORY]";
-			strcpy(iter->fmt, "%s");
+				trace_seq_printf(&iter->seq, "(0x%px:%s)", str, buf);
+			trace_seq_puts(&iter->seq, "[UNSAFE-MEMORY]");
 		} else {
-			strncpy(iter->fmt, p + i, j + 1);
-			iter->fmt[j+1] = '\0';
+			save_ch = p[j + 1];
+			p[j + 1] = '\0';
+			if (star)
+				trace_seq_printf(&iter->seq, p, len, str);
+			else
+				trace_seq_printf(&iter->seq, p, str);
+			p[j + 1] = save_ch;
 		}
-		if (star)
-			trace_seq_printf(&iter->seq, iter->fmt, len, str);
-		else
-			trace_seq_printf(&iter->seq, iter->fmt, str);
 
-		p += i + j + 1;
+		p += j + 1;
 	}
  print:
 	if (*p)
 		trace_seq_vprintf(&iter->seq, p, ap);
+	kfree(buf);
+	return;
+ print_fmt:
+	trace_seq_vprintf(&iter->seq, fmt, ap);
 }
 
 const char *trace_event_format(struct trace_iterator *iter, const char *fmt)
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 74c353164ca1..a75d107a45f8 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -176,7 +176,8 @@ static void function_trace_start(struct trace_array *tr)
 	tracing_reset_online_cpus(&tr->array_buffer);
 }
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+/* Microblaze currently doesn't implement kernel_stack_pointer() */
+#if defined(CONFIG_FUNCTION_GRAPH_TRACER) && !defined(CONFIG_MICROBLAZE)
 static __always_inline unsigned long
 function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_regs *fregs)
 {

