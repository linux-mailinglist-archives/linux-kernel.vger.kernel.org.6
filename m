Return-Path: <linux-kernel+bounces-357115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8ED996BB9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB7A281ECE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFE91991CE;
	Wed,  9 Oct 2024 13:21:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A46197548
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480074; cv=none; b=bT3CNZqyDlJJ1Ke+1k2tCKFMiSQR0xHiWcMI52pXUh19WqJhsNqUI+ZZsw69FuQhQlinR4avbbp9bSnOv8DuYjd+K0NuIK5sQLTKNCdStQysJ3EUNM7XjiN6Ra/o4YyRnqsvDypx07P2y8CYon6tFI1fRIPGG96XMH4c5uqYyr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480074; c=relaxed/simple;
	bh=4j+KN9XQdHqF+fn3C7zZ3iDE1FkexN5wNhON5Q4aX0w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GxJ8EfS2c3kMjJqc1wb5qUs9++CiBnxmm8NSvUYJ6IrEEoG6WCfRDxALVANJFqQkNwxrQQshrlzgcR6PSNVVn3eBrMBimoJTZcIQG+Z2UBqi135CnX25/4iV1WLg4rK2qnTDp+tppdObNWGgViEPwQZcMPyHkFURVf9JKJTOG1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F46C4CED2;
	Wed,  9 Oct 2024 13:21:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1syWcy-0000000176p-0Vd8;
	Wed, 09 Oct 2024 09:21:20 -0400
Message-ID: <20241009132119.981690826@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 09 Oct 2024 09:21:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Zheng Yejian <zhengyejian@huaweicloud.com>
Subject: [for-next][PATCH 3/6] tracing: Remove TRACE_EVENT_FL_FILTERED logic
References: <20241009132104.470687911@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Zheng Yejian <zhengyejian@huaweicloud.com>

After commit dcb0b5575d24 ("tracing: Remove TRACE_EVENT_FL_USE_CALL_FILTER
 logic"), no one's going to set the TRACE_EVENT_FL_FILTERED or change the
call->filter, so remove related logic.

Link: https://lore.kernel.org/20240911010026.2302849-1-zhengyejian@huaweicloud.com
Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_events.h         |  4 ---
 kernel/trace/trace.c                 | 44 ++++++----------------------
 kernel/trace/trace.h                 |  4 ---
 kernel/trace/trace_branch.c          |  4 +--
 kernel/trace/trace_events.c          |  2 --
 kernel/trace/trace_functions_graph.c |  8 ++---
 kernel/trace/trace_hwlat.c           |  4 +--
 kernel/trace/trace_mmiotrace.c       |  8 ++---
 kernel/trace/trace_osnoise.c         | 12 ++------
 kernel/trace/trace_sched_wakeup.c    |  8 ++---
 10 files changed, 20 insertions(+), 78 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 42bedcddd511..f8f2e52653df 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -326,7 +326,6 @@ void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
 void trace_event_buffer_commit(struct trace_event_buffer *fbuffer);
 
 enum {
-	TRACE_EVENT_FL_FILTERED_BIT,
 	TRACE_EVENT_FL_CAP_ANY_BIT,
 	TRACE_EVENT_FL_NO_SET_FILTER_BIT,
 	TRACE_EVENT_FL_IGNORE_ENABLE_BIT,
@@ -341,7 +340,6 @@ enum {
 
 /*
  * Event flags:
- *  FILTERED	  - The event has a filter attached
  *  CAP_ANY	  - Any user can enable for perf
  *  NO_SET_FILTER - Set when filter has error and is to be ignored
  *  IGNORE_ENABLE - For trace internal events, do not enable with debugfs file
@@ -356,7 +354,6 @@ enum {
  *                   to a tracepoint yet, then it is cleared when it is.
  */
 enum {
-	TRACE_EVENT_FL_FILTERED		= (1 << TRACE_EVENT_FL_FILTERED_BIT),
 	TRACE_EVENT_FL_CAP_ANY		= (1 << TRACE_EVENT_FL_CAP_ANY_BIT),
 	TRACE_EVENT_FL_NO_SET_FILTER	= (1 << TRACE_EVENT_FL_NO_SET_FILTER_BIT),
 	TRACE_EVENT_FL_IGNORE_ENABLE	= (1 << TRACE_EVENT_FL_IGNORE_ENABLE_BIT),
@@ -381,7 +378,6 @@ struct trace_event_call {
 	};
 	struct trace_event	event;
 	char			*print_fmt;
-	struct event_filter	*filter;
 	/*
 	 * Static events can disappear with modules,
 	 * where as dynamic ones need their own ref count.
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1c69ca1f1088..bdb776e6ceb9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -593,19 +593,6 @@ int tracing_check_open_get_tr(struct trace_array *tr)
 	return 0;
 }
 
-int call_filter_check_discard(struct trace_event_call *call, void *rec,
-			      struct trace_buffer *buffer,
-			      struct ring_buffer_event *event)
-{
-	if (unlikely(call->flags & TRACE_EVENT_FL_FILTERED) &&
-	    !filter_match_preds(call->filter, rec)) {
-		__trace_event_discard_commit(buffer, event);
-		return 1;
-	}
-
-	return 0;
-}
-
 /**
  * trace_find_filtered_pid - check if a pid exists in a filtered_pid list
  * @filtered_pids: The list of pids to check
@@ -2889,7 +2876,6 @@ void
 trace_function(struct trace_array *tr, unsigned long ip, unsigned long
 	       parent_ip, unsigned int trace_ctx)
 {
-	struct trace_event_call *call = &event_function;
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
 	struct ring_buffer_event *event;
 	struct ftrace_entry *entry;
@@ -2902,11 +2888,9 @@ trace_function(struct trace_array *tr, unsigned long ip, unsigned long
 	entry->ip			= ip;
 	entry->parent_ip		= parent_ip;
 
-	if (!call_filter_check_discard(call, entry, buffer, event)) {
-		if (static_branch_unlikely(&trace_function_exports_enabled))
-			ftrace_exports(event, TRACE_EXPORT_FUNCTION);
-		__buffer_unlock_commit(buffer, event);
-	}
+	if (static_branch_unlikely(&trace_function_exports_enabled))
+		ftrace_exports(event, TRACE_EXPORT_FUNCTION);
+	__buffer_unlock_commit(buffer, event);
 }
 
 #ifdef CONFIG_STACKTRACE
@@ -2932,7 +2916,6 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 				 unsigned int trace_ctx,
 				 int skip, struct pt_regs *regs)
 {
-	struct trace_event_call *call = &event_kernel_stack;
 	struct ring_buffer_event *event;
 	unsigned int size, nr_entries;
 	struct ftrace_stack *fstack;
@@ -2986,8 +2969,7 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 	memcpy(&entry->caller, fstack->calls,
 	       flex_array_size(entry, caller, nr_entries));
 
-	if (!call_filter_check_discard(call, entry, buffer, event))
-		__buffer_unlock_commit(buffer, event);
+	__buffer_unlock_commit(buffer, event);
 
  out:
 	/* Again, don't let gcc optimize things here */
@@ -3060,7 +3042,6 @@ static void
 ftrace_trace_userstack(struct trace_array *tr,
 		       struct trace_buffer *buffer, unsigned int trace_ctx)
 {
-	struct trace_event_call *call = &event_user_stack;
 	struct ring_buffer_event *event;
 	struct userstack_entry *entry;
 
@@ -3094,8 +3075,7 @@ ftrace_trace_userstack(struct trace_array *tr,
 	memset(&entry->caller, 0, sizeof(entry->caller));
 
 	stack_trace_save_user(entry->caller, FTRACE_STACK_ENTRIES);
-	if (!call_filter_check_discard(call, entry, buffer, event))
-		__buffer_unlock_commit(buffer, event);
+	__buffer_unlock_commit(buffer, event);
 
  out_drop_count:
 	__this_cpu_dec(user_stack_count);
@@ -3264,7 +3244,6 @@ static void trace_printk_start_stop_comm(int enabled)
  */
 int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 {
-	struct trace_event_call *call = &event_bprint;
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer;
 	struct trace_array *tr = READ_ONCE(printk_trace);
@@ -3308,10 +3287,8 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 	entry->fmt			= fmt;
 
 	memcpy(entry->buf, tbuffer, sizeof(u32) * len);
-	if (!call_filter_check_discard(call, entry, buffer, event)) {
-		__buffer_unlock_commit(buffer, event);
-		ftrace_trace_stack(tr, buffer, trace_ctx, 6, NULL);
-	}
+	__buffer_unlock_commit(buffer, event);
+	ftrace_trace_stack(tr, buffer, trace_ctx, 6, NULL);
 
 out:
 	ring_buffer_nest_end(buffer);
@@ -3331,7 +3308,6 @@ static int
 __trace_array_vprintk(struct trace_buffer *buffer,
 		      unsigned long ip, const char *fmt, va_list args)
 {
-	struct trace_event_call *call = &event_print;
 	struct ring_buffer_event *event;
 	int len = 0, size;
 	struct print_entry *entry;
@@ -3366,10 +3342,8 @@ __trace_array_vprintk(struct trace_buffer *buffer,
 	entry->ip = ip;
 
 	memcpy(&entry->buf, tbuffer, len + 1);
-	if (!call_filter_check_discard(call, entry, buffer, event)) {
-		__buffer_unlock_commit(buffer, event);
-		ftrace_trace_stack(printk_trace, buffer, trace_ctx, 6, NULL);
-	}
+	__buffer_unlock_commit(buffer, event);
+	ftrace_trace_stack(printk_trace, buffer, trace_ctx, 6, NULL);
 
 out:
 	ring_buffer_nest_end(buffer);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index c866991b9c78..638f452eec10 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1429,10 +1429,6 @@ struct trace_subsystem_dir {
 	int				nr_events;
 };
 
-extern int call_filter_check_discard(struct trace_event_call *call, void *rec,
-				     struct trace_buffer *buffer,
-				     struct ring_buffer_event *event);
-
 void trace_buffer_unlock_commit_regs(struct trace_array *tr,
 				     struct trace_buffer *buffer,
 				     struct ring_buffer_event *event,
diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
index aa63548873c3..6d08a5523ce0 100644
--- a/kernel/trace/trace_branch.c
+++ b/kernel/trace/trace_branch.c
@@ -30,7 +30,6 @@ static struct trace_array *branch_tracer;
 static void
 probe_likely_condition(struct ftrace_likely_data *f, int val, int expect)
 {
-	struct trace_event_call *call = &event_branch;
 	struct trace_array *tr = branch_tracer;
 	struct trace_buffer *buffer;
 	struct trace_array_cpu *data;
@@ -80,8 +79,7 @@ probe_likely_condition(struct ftrace_likely_data *f, int val, int expect)
 	entry->line = f->data.line;
 	entry->correct = val == expect;
 
-	if (!call_filter_check_discard(call, entry, buffer, event))
-		trace_buffer_unlock_commit_nostack(buffer, event);
+	trace_buffer_unlock_commit_nostack(buffer, event);
 
  out:
 	current->trace_recursion &= ~TRACE_BRANCH_BIT;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 7266ec2a4eea..77e68efbd43e 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3149,8 +3149,6 @@ static void __trace_remove_event_call(struct trace_event_call *call)
 {
 	event_remove(call);
 	trace_destroy_fields(call);
-	free_event_filter(call->filter);
-	call->filter = NULL;
 }
 
 static int probe_remove_event_call(struct trace_event_call *call)
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index a569daaac4c4..ab57ec78ca04 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -102,7 +102,6 @@ int __trace_graph_entry(struct trace_array *tr,
 				struct ftrace_graph_ent *trace,
 				unsigned int trace_ctx)
 {
-	struct trace_event_call *call = &event_funcgraph_entry;
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
 	struct ftrace_graph_ent_entry *entry;
@@ -113,8 +112,7 @@ int __trace_graph_entry(struct trace_array *tr,
 		return 0;
 	entry	= ring_buffer_event_data(event);
 	entry->graph_ent			= *trace;
-	if (!call_filter_check_discard(call, entry, buffer, event))
-		trace_buffer_unlock_commit_nostack(buffer, event);
+	trace_buffer_unlock_commit_nostack(buffer, event);
 
 	return 1;
 }
@@ -223,7 +221,6 @@ void __trace_graph_return(struct trace_array *tr,
 				struct ftrace_graph_ret *trace,
 				unsigned int trace_ctx)
 {
-	struct trace_event_call *call = &event_funcgraph_exit;
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
 	struct ftrace_graph_ret_entry *entry;
@@ -234,8 +231,7 @@ void __trace_graph_return(struct trace_array *tr,
 		return;
 	entry	= ring_buffer_event_data(event);
 	entry->ret				= *trace;
-	if (!call_filter_check_discard(call, entry, buffer, event))
-		trace_buffer_unlock_commit_nostack(buffer, event);
+	trace_buffer_unlock_commit_nostack(buffer, event);
 }
 
 void trace_graph_return(struct ftrace_graph_ret *trace,
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 3bd6071441ad..b65353ec2837 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -130,7 +130,6 @@ static bool hwlat_busy;
 static void trace_hwlat_sample(struct hwlat_sample *sample)
 {
 	struct trace_array *tr = hwlat_trace;
-	struct trace_event_call *call = &event_hwlat;
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
 	struct ring_buffer_event *event;
 	struct hwlat_entry *entry;
@@ -148,8 +147,7 @@ static void trace_hwlat_sample(struct hwlat_sample *sample)
 	entry->nmi_count		= sample->nmi_count;
 	entry->count			= sample->count;
 
-	if (!call_filter_check_discard(call, entry, buffer, event))
-		trace_buffer_unlock_commit_nostack(buffer, event);
+	trace_buffer_unlock_commit_nostack(buffer, event);
 }
 
 /* Macros to encapsulate the time capturing infrastructure */
diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index 64e77b513697..ba5858866b2f 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -294,7 +294,6 @@ static void __trace_mmiotrace_rw(struct trace_array *tr,
 				struct trace_array_cpu *data,
 				struct mmiotrace_rw *rw)
 {
-	struct trace_event_call *call = &event_mmiotrace_rw;
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
 	struct ring_buffer_event *event;
 	struct trace_mmiotrace_rw *entry;
@@ -310,8 +309,7 @@ static void __trace_mmiotrace_rw(struct trace_array *tr,
 	entry	= ring_buffer_event_data(event);
 	entry->rw			= *rw;
 
-	if (!call_filter_check_discard(call, entry, buffer, event))
-		trace_buffer_unlock_commit(tr, buffer, event, trace_ctx);
+	trace_buffer_unlock_commit(tr, buffer, event, trace_ctx);
 }
 
 void mmio_trace_rw(struct mmiotrace_rw *rw)
@@ -325,7 +323,6 @@ static void __trace_mmiotrace_map(struct trace_array *tr,
 				struct trace_array_cpu *data,
 				struct mmiotrace_map *map)
 {
-	struct trace_event_call *call = &event_mmiotrace_map;
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
 	struct ring_buffer_event *event;
 	struct trace_mmiotrace_map *entry;
@@ -341,8 +338,7 @@ static void __trace_mmiotrace_map(struct trace_array *tr,
 	entry	= ring_buffer_event_data(event);
 	entry->map			= *map;
 
-	if (!call_filter_check_discard(call, entry, buffer, event))
-		trace_buffer_unlock_commit(tr, buffer, event, trace_ctx);
+	trace_buffer_unlock_commit(tr, buffer, event, trace_ctx);
 }
 
 void mmio_trace_mapping(struct mmiotrace_map *map)
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index a50ed23bee77..b9f96c77527d 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -499,7 +499,6 @@ static void print_osnoise_headers(struct seq_file *s)
 static void
 __trace_osnoise_sample(struct osnoise_sample *sample, struct trace_buffer *buffer)
 {
-	struct trace_event_call *call = &event_osnoise;
 	struct ring_buffer_event *event;
 	struct osnoise_entry *entry;
 
@@ -517,8 +516,7 @@ __trace_osnoise_sample(struct osnoise_sample *sample, struct trace_buffer *buffe
 	entry->softirq_count	= sample->softirq_count;
 	entry->thread_count	= sample->thread_count;
 
-	if (!call_filter_check_discard(call, entry, buffer, event))
-		trace_buffer_unlock_commit_nostack(buffer, event);
+	trace_buffer_unlock_commit_nostack(buffer, event);
 }
 
 /*
@@ -578,7 +576,6 @@ static void print_timerlat_headers(struct seq_file *s)
 static void
 __trace_timerlat_sample(struct timerlat_sample *sample, struct trace_buffer *buffer)
 {
-	struct trace_event_call *call = &event_osnoise;
 	struct ring_buffer_event *event;
 	struct timerlat_entry *entry;
 
@@ -591,8 +588,7 @@ __trace_timerlat_sample(struct timerlat_sample *sample, struct trace_buffer *buf
 	entry->context			= sample->context;
 	entry->timer_latency		= sample->timer_latency;
 
-	if (!call_filter_check_discard(call, entry, buffer, event))
-		trace_buffer_unlock_commit_nostack(buffer, event);
+	trace_buffer_unlock_commit_nostack(buffer, event);
 }
 
 /*
@@ -654,7 +650,6 @@ static void timerlat_save_stack(int skip)
 static void
 __timerlat_dump_stack(struct trace_buffer *buffer, struct trace_stack *fstack, unsigned int size)
 {
-	struct trace_event_call *call = &event_osnoise;
 	struct ring_buffer_event *event;
 	struct stack_entry *entry;
 
@@ -668,8 +663,7 @@ __timerlat_dump_stack(struct trace_buffer *buffer, struct trace_stack *fstack, u
 	memcpy(&entry->caller, fstack->calls, size);
 	entry->size = fstack->nr_entries;
 
-	if (!call_filter_check_discard(call, entry, buffer, event))
-		trace_buffer_unlock_commit_nostack(buffer, event);
+	trace_buffer_unlock_commit_nostack(buffer, event);
 }
 
 /*
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index ae2ace5e515a..d6c7f18daa15 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -378,7 +378,6 @@ tracing_sched_switch_trace(struct trace_array *tr,
 			   struct task_struct *next,
 			   unsigned int trace_ctx)
 {
-	struct trace_event_call *call = &event_context_switch;
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
 	struct ring_buffer_event *event;
 	struct ctx_switch_entry *entry;
@@ -396,8 +395,7 @@ tracing_sched_switch_trace(struct trace_array *tr,
 	entry->next_state		= task_state_index(next);
 	entry->next_cpu	= task_cpu(next);
 
-	if (!call_filter_check_discard(call, entry, buffer, event))
-		trace_buffer_unlock_commit(tr, buffer, event, trace_ctx);
+	trace_buffer_unlock_commit(tr, buffer, event, trace_ctx);
 }
 
 static void
@@ -406,7 +404,6 @@ tracing_sched_wakeup_trace(struct trace_array *tr,
 			   struct task_struct *curr,
 			   unsigned int trace_ctx)
 {
-	struct trace_event_call *call = &event_wakeup;
 	struct ring_buffer_event *event;
 	struct ctx_switch_entry *entry;
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
@@ -424,8 +421,7 @@ tracing_sched_wakeup_trace(struct trace_array *tr,
 	entry->next_state		= task_state_index(wakee);
 	entry->next_cpu			= task_cpu(wakee);
 
-	if (!call_filter_check_discard(call, entry, buffer, event))
-		trace_buffer_unlock_commit(tr, buffer, event, trace_ctx);
+	trace_buffer_unlock_commit(tr, buffer, event, trace_ctx);
 }
 
 static void notrace
-- 
2.45.2



