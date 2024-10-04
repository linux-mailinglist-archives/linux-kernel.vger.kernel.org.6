Return-Path: <linux-kernel+bounces-350743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4C29908E4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821E01F23333
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072C61C7264;
	Fri,  4 Oct 2024 16:17:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DE31C7265
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058641; cv=none; b=AO0b5yu0cFnhQspSTX2XEtjeYQy1zgqZwlZHTx0bE9nVXb8mqRwFkuUIqyuHyIswYz4l3BqCGzDBdVSkXHYXbU4xb4HuNNRkIT0Y09UYZCsX1aKoIpfc/pP6B9qwywN/3+XiPQcONDnLPMxYKAZDnNZu8nZ45EkLdnWlOA48swY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058641; c=relaxed/simple;
	bh=PQGXcJQ+NH84gNBSkiKiYOP/5hiIc0AZPTwp7DeLsIk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=XXeI09EWkis9nGosH3S5PJkGUezSBEIAvnkyehDr0iQulSxdQkr7MNCDVuSI/MtUCTloQFC81YP/DeU+spQA9i4fEjPYIBDaMWw7wxJiFNCoEkMHkZewL/lyzGCqhJda4fb+J6xJxfTKdHEa6G/DzztcB3sKCbfT+aOwdIdsHK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F073C4CEC6;
	Fri,  4 Oct 2024 16:17:19 +0000 (UTC)
Date: Fri, 4 Oct 2024 12:18:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ben Hutchings <benh@debian.org>, Eder Zulian <ezulian@redhat.com>, Sami
 Tolvanen <samitolvanen@google.com>, Wei Li <liwei391@huawei.com>
Subject: [GIT PULL] tracing: Various fixes for 6.12
Message-ID: <20241004121815.18a7ad46@gandalf.local.home>
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

Various fixes for tracing:

- Fix tp_printk command line option crashing the kernel

  With the code that can handle a buffer from a previous boot, the
  trace_check_vprintf() needed access to the delta of the address
  space used by the old buffer and the current buffer. To do so,
  the trace_array (tr) parameter was used. But when tp_printk is
  enabled on the kernel command line, no trace buffer is used and
  the trace event is sent directly to printk(). That meant the tr
  field of the iterator descriptor was NULL, and since tp_printk still
  uses trace_check_vprintf() it caused a NULL dereference.

- Add ptrace.h include to x86 ftrace file for completeness

- Fix rtla installation when done with out-of-tree build

- Fix the help messages in rtla that were incorrect

- Several fixes to fix races with the timerlat and hwlat code

  Several locking issues were discovered with the coordination
  between timerlat kthread creation and hotplug. As timerlat has
  callbacks from hotplug code to start kthreads when CPUs come online.
  There are also locking issues with grabbing the cpu_read_lock()
  and the locks within timerlat.


Please pull the latest trace-v6.12-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.12-rc1

Tag SHA1: 43a1f62bee4cb8e76308992c160c44cea0e2d9d7
Head SHA1: 2a13ca2e8abb12ee43ada8a107dadca83f140937


Ben Hutchings (1):
      tools/rtla: Fix installation from out-of-tree build

Eder Zulian (1):
      rtla: Fix the help text in osnoise and timerlat top tools

Sami Tolvanen (1):
      x86/ftrace: Include <asm/ptrace.h>

Steven Rostedt (1):
      tracing: Fix trace_check_vprintf() when tp_printk is used

Wei Li (4):
      tracing/timerlat: Fix duplicated kthread creation due to CPU online/offline
      tracing/timerlat: Drop interface_lock in stop_kthread()
      tracing/timerlat: Fix a race during cpuhp processing
      tracing/hwlat: Fix a race during cpuhp processing

----
 arch/x86/include/asm/ftrace.h         |  2 ++
 kernel/trace/trace.c                  | 15 +++++++++++++--
 kernel/trace/trace_hwlat.c            |  2 ++
 kernel/trace/trace_osnoise.c          | 22 +++++++++++++---------
 tools/tracing/rtla/Makefile.rtla      |  2 +-
 tools/tracing/rtla/src/osnoise_top.c  |  2 +-
 tools/tracing/rtla/src/timerlat_top.c |  4 ++--
 7 files changed, 34 insertions(+), 15 deletions(-)
---------------------------
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 0152a81d9b4a..b4d719de2c84 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_FTRACE_H
 #define _ASM_X86_FTRACE_H
 
+#include <asm/ptrace.h>
+
 #ifdef CONFIG_FUNCTION_TRACER
 #ifndef CC_USING_FENTRY
 # error Compiler does not support fentry?
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c01375adc471..1c69ca1f1088 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3697,8 +3697,8 @@ static void test_can_verify(void)
 void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 			 va_list ap)
 {
-	long text_delta = iter->tr->text_delta;
-	long data_delta = iter->tr->data_delta;
+	long text_delta = 0;
+	long data_delta = 0;
 	const char *p = fmt;
 	const char *str;
 	bool good;
@@ -3710,6 +3710,17 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 	if (static_branch_unlikely(&trace_no_verify))
 		goto print;
 
+	/*
+	 * When the kernel is booted with the tp_printk command line
+	 * parameter, trace events go directly through to printk().
+	 * It also is checked by this function, but it does not
+	 * have an associated trace_array (tr) for it.
+	 */
+	if (iter->tr) {
+		text_delta = iter->tr->text_delta;
+		data_delta = iter->tr->data_delta;
+	}
+
 	/* Don't bother checking when doing a ftrace_dump() */
 	if (iter->fmt == static_fmt_buf)
 		goto print;
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index b791524a6536..3bd6071441ad 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -520,6 +520,8 @@ static void hwlat_hotplug_workfn(struct work_struct *dummy)
 	if (!hwlat_busy || hwlat_data.thread_mode != MODE_PER_CPU)
 		goto out_unlock;
 
+	if (!cpu_online(cpu))
+		goto out_unlock;
 	if (!cpumask_test_cpu(cpu, tr->tracing_cpumask))
 		goto out_unlock;
 
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 1439064f65d6..a50ed23bee77 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1953,12 +1953,8 @@ static void stop_kthread(unsigned int cpu)
 {
 	struct task_struct *kthread;
 
-	mutex_lock(&interface_lock);
-	kthread = per_cpu(per_cpu_osnoise_var, cpu).kthread;
+	kthread = xchg_relaxed(&(per_cpu(per_cpu_osnoise_var, cpu).kthread), NULL);
 	if (kthread) {
-		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
-		mutex_unlock(&interface_lock);
-
 		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask) &&
 		    !WARN_ON(!test_bit(OSN_WORKLOAD, &osnoise_options))) {
 			kthread_stop(kthread);
@@ -1972,7 +1968,6 @@ static void stop_kthread(unsigned int cpu)
 			put_task_struct(kthread);
 		}
 	} else {
-		mutex_unlock(&interface_lock);
 		/* if no workload, just return */
 		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
 			/*
@@ -1994,8 +1989,12 @@ static void stop_per_cpu_kthreads(void)
 {
 	int cpu;
 
-	for_each_possible_cpu(cpu)
+	cpus_read_lock();
+
+	for_each_online_cpu(cpu)
 		stop_kthread(cpu);
+
+	cpus_read_unlock();
 }
 
 /*
@@ -2007,6 +2006,10 @@ static int start_kthread(unsigned int cpu)
 	void *main = osnoise_main;
 	char comm[24];
 
+	/* Do not start a new thread if it is already running */
+	if (per_cpu(per_cpu_osnoise_var, cpu).kthread)
+		return 0;
+
 	if (timerlat_enabled()) {
 		snprintf(comm, 24, "timerlat/%d", cpu);
 		main = timerlat_main;
@@ -2061,11 +2064,10 @@ static int start_per_cpu_kthreads(void)
 		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask)) {
 			struct task_struct *kthread;
 
-			kthread = per_cpu(per_cpu_osnoise_var, cpu).kthread;
+			kthread = xchg_relaxed(&(per_cpu(per_cpu_osnoise_var, cpu).kthread), NULL);
 			if (!WARN_ON(!kthread))
 				kthread_stop(kthread);
 		}
-		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
 	}
 
 	for_each_cpu(cpu, current_mask) {
@@ -2095,6 +2097,8 @@ static void osnoise_hotplug_workfn(struct work_struct *dummy)
 	mutex_lock(&interface_lock);
 	cpus_read_lock();
 
+	if (!cpu_online(cpu))
+		goto out_unlock;
 	if (!cpumask_test_cpu(cpu, &osnoise_cpumask))
 		goto out_unlock;
 
diff --git a/tools/tracing/rtla/Makefile.rtla b/tools/tracing/rtla/Makefile.rtla
index 3ff0b8970896..cc1d6b615475 100644
--- a/tools/tracing/rtla/Makefile.rtla
+++ b/tools/tracing/rtla/Makefile.rtla
@@ -38,7 +38,7 @@ BINDIR		:= /usr/bin
 .PHONY: install
 install: doc_install
 	@$(MKDIR) -p $(DESTDIR)$(BINDIR)
-	$(call QUIET_INSTALL,rtla)$(INSTALL) rtla -m 755 $(DESTDIR)$(BINDIR)
+	$(call QUIET_INSTALL,rtla)$(INSTALL) $(RTLA) -m 755 $(DESTDIR)$(BINDIR)
 	@$(STRIP) $(DESTDIR)$(BINDIR)/rtla
 	@test ! -f $(DESTDIR)$(BINDIR)/osnoise || $(RM) $(DESTDIR)$(BINDIR)/osnoise
 	@$(LN) rtla $(DESTDIR)$(BINDIR)/osnoise
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 2f756628613d..30e3853076a0 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -442,7 +442,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'd':
 			params->duration = parse_seconds_duration(optarg);
 			if (!params->duration)
-				osnoise_top_usage(params, "Invalid -D duration\n");
+				osnoise_top_usage(params, "Invalid -d duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 8c16419fe22a..210b0f533534 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -459,7 +459,7 @@ static void timerlat_top_usage(char *usage)
 		"	  -c/--cpus cpus: run the tracer only on the given cpus",
 		"	  -H/--house-keeping cpus: run rtla control threads only on the given cpus",
 		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
-		"	  -d/--duration time[m|h|d]: duration of the session in seconds",
+		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	  -D/--debug: print debug info",
 		"	     --dump-tasks: prints the task running on all CPUs if stop conditions are met (depends on !--no-aa)",
 		"	  -t/--trace[file]: save the stopped trace to [file|timerlat_trace.txt]",
@@ -613,7 +613,7 @@ static struct timerlat_top_params
 		case 'd':
 			params->duration = parse_seconds_duration(optarg);
 			if (!params->duration)
-				timerlat_top_usage("Invalid -D duration\n");
+				timerlat_top_usage("Invalid -d duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);

