Return-Path: <linux-kernel+bounces-449597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 995039F5136
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD95164CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0D21F3D58;
	Tue, 17 Dec 2024 16:38:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87D142E77
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734453527; cv=none; b=HKA+Enhq7zrP8n+hHt5Wg9fnIe9u1Oi14qBmkZ9vejcL739B8nQBhX2yx3C2Evjr5xHjfbocgYukDBEbOd7atgBMSKmlBr0vknvIS9D6ypEOiQzUrS5KF8RHNbEWERrjHyjjTtQubcqxoBGkFah8iv2KFpILKBk0X1SuruQQtwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734453527; c=relaxed/simple;
	bh=P9htpVAscVrVAFpbNyfRgxQlx61j79kfcc0I/1Du+l0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gartMqG/z4aocZBwo2dpwKPyf07vtqSOAFLU/j7TUNMVzuVoSAqzFvaNu5AKKDUB6LmDFIIhgpliKp/B8vH4YmUo2jTSWuICL5ypvOmMDqhySPbn8PZMx7Obn8JHemL8D8aHd4ehqpbMhK6APN5GrIMti3PqLpj8nJI/0GsuJ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0439C4CED3;
	Tue, 17 Dec 2024 16:38:45 +0000 (UTC)
Date: Tue, 17 Dec 2024 11:39:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro
 <viro@ZenIV.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] ftrace: Fixes for v6.13
Message-ID: <20241217113921.7254325e@gandalf.local.home>
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

Ftrace fixes for 6.13:

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

  It was first thought that this was a microblaze issue, but the real
  cause is that this only works when an architecture implements
  HAVE_DYNAMIC_FTRACE_WITH_ARGS, as a requirement for that config
  is to have ftrace always pass a valid ftrace_regs to the callbacks.
  That also means that the architecture supports ftrace_regs_get_stack_pointer()
  Microblaze does not set HAVE_DYNAMIC_FTRACE_WITH_ARGS nor does it
  implement ftrace_regs_get_stack_pointer() which caused it to fail to
  build. Only implement the "true parent" logic if an architecture has
  that config set.

[
  This does not contain any of the trace_check_printf() code, as that
  is being handled in a separate topic branch. It didn't belong with
  the ftrace branch anyway, as this branch is for function attachment
  code only.
]

Please pull the latest ftrace-v6.13-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace-v6.13-rc3

Tag SHA1: 4f5e6967508d77ae95d08b143892e421c0bdb9fd
Head SHA1: 166438a432d76c68d3f0da60667248f3c2303d6c


Steven Rostedt (2):
      fgraph: Still initialize idle shadow stacks when starting
      ftrace: Do not find "true_parent" if HAVE_DYNAMIC_FTRACE_WITH_ARGS is not set

----
 kernel/trace/fgraph.c          | 8 +++++++-
 kernel/trace/trace_functions.c | 3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)
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
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 74c353164ca1..d358c9935164 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -176,7 +176,8 @@ static void function_trace_start(struct trace_array *tr)
 	tracing_reset_online_cpus(&tr->array_buffer);
 }
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+/* fregs are guaranteed not to be NULL if HAVE_DYNAMIC_FTRACE_WITH_ARGS is set */
+#if defined(CONFIG_FUNCTION_GRAPH_TRACER) && defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS)
 static __always_inline unsigned long
 function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_regs *fregs)
 {

