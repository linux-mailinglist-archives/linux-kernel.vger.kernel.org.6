Return-Path: <linux-kernel+bounces-552278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFC9A577DF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 04:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C6A07A5889
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 03:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F3A156230;
	Sat,  8 Mar 2025 03:26:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C7514A8B
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 03:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741404371; cv=none; b=qwEq/x6ibcJDibaVmLVJG2ysRKvKoUzKpHjXeBEm4hcJSHwsEZSu8EJIjVf76Y0Ixf9mpK1s3zDoID9ZVm6DKmsU0OHzu6LDiCFN8FLOB29W4LE2QDXSRGcbTAVsgHG0Byyy9JDdnmKxQ6ULp533r7CwM57UyQMNOWPM/z8ZKZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741404371; c=relaxed/simple;
	bh=HCzxZX/4r0HnQhDRVk4ZS38XuOcxR871U/IaOXptd2c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=i6Csi046hCvE8hzHsp7OGVCobPFyBfsrt09cTPyg+yHULcjm/GR5n2BA7Tmb4enTpN7RZqtO9ptyJ/jvkCtVT67M2v/QHFoRyZNOy30pilczooD0qIgb78n9Trc4JsoI6iyL9Jvr/QZG+PPnQ+IjPItrIVVH87+OUMlpHf/23Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F06EC4CEE2;
	Sat,  8 Mar 2025 03:26:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tqkpJ-00000000Ukr-0dqx;
	Fri, 07 Mar 2025 22:26:13 -0500
Message-ID: <20250308032613.007336181@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 07 Mar 2025 22:24:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 1/3] trace/osnoise: Add trace events for samples
References: <20250308032432.109115966@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Add trace events that fire at osnoise and timerlat sample generation, in
addition to the already existing noise and threshold events.

This allows processing the samples directly in the kernel, either with
ftrace triggers or with BPF.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Link: https://lore.kernel.org/20250203090418.1458923-1-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Tested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/osnoise.h | 96 ++++++++++++++++++++++++++++++++++
 kernel/trace/trace_osnoise.c   | 55 ++++++-------------
 2 files changed, 112 insertions(+), 39 deletions(-)

diff --git a/include/trace/events/osnoise.h b/include/trace/events/osnoise.h
index a2379a4f0684..3f4273623801 100644
--- a/include/trace/events/osnoise.h
+++ b/include/trace/events/osnoise.h
@@ -3,9 +3,105 @@
 #define TRACE_SYSTEM osnoise
 
 #if !defined(_OSNOISE_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+
+#ifndef _OSNOISE_TRACE_H
 #define _OSNOISE_TRACE_H
+/*
+ * osnoise sample structure definition. Used to store the statistics of a
+ * sample run.
+ */
+struct osnoise_sample {
+	u64			runtime;	/* runtime */
+	u64			noise;		/* noise */
+	u64			max_sample;	/* max single noise sample */
+	int			hw_count;	/* # HW (incl. hypervisor) interference */
+	int			nmi_count;	/* # NMIs during this sample */
+	int			irq_count;	/* # IRQs during this sample */
+	int			softirq_count;	/* # softirqs during this sample */
+	int			thread_count;	/* # threads during this sample */
+};
+
+#ifdef CONFIG_TIMERLAT_TRACER
+/*
+ * timerlat sample structure definition. Used to store the statistics of
+ * a sample run.
+ */
+struct timerlat_sample {
+	u64			timer_latency;	/* timer_latency */
+	unsigned int		seqnum;		/* unique sequence */
+	int			context;	/* timer context */
+};
+#endif // CONFIG_TIMERLAT_TRACER
+#endif // _OSNOISE_TRACE_H
 
 #include <linux/tracepoint.h>
+TRACE_EVENT(osnoise_sample,
+
+	TP_PROTO(struct osnoise_sample *s),
+
+	TP_ARGS(s),
+
+	TP_STRUCT__entry(
+		__field(	u64,		runtime	)
+		__field(	u64,		noise	)
+		__field(	u64,		max_sample	)
+		__field(	int,		hw_count	)
+		__field(	int,		irq_count	)
+		__field(	int,		nmi_count	)
+		__field(	int, 		softirq_count	)
+		__field(	int,		thread_count	)
+	),
+
+	TP_fast_assign(
+		__entry->runtime = s->runtime;
+		__entry->noise = s->noise;
+		__entry->max_sample = s->max_sample;
+		__entry->hw_count = s->hw_count;
+		__entry->irq_count = s->irq_count;
+		__entry->nmi_count = s->nmi_count;
+		__entry->softirq_count = s->softirq_count;
+		__entry->thread_count = s->thread_count;
+	),
+
+	TP_printk("runtime=%llu noise=%llu max_sample=%llu hw_count=%d"
+		  " irq_count=%d nmi_count=%d softirq_count=%d"
+		  " thread_count=%d",
+		  __entry->runtime,
+		  __entry->noise,
+		  __entry->max_sample,
+		  __entry->hw_count,
+		  __entry->irq_count,
+		  __entry->nmi_count,
+		  __entry->softirq_count,
+		  __entry->thread_count)
+);
+
+#ifdef CONFIG_TIMERLAT_TRACER
+TRACE_EVENT(timerlat_sample,
+
+	TP_PROTO(struct timerlat_sample *s),
+
+	TP_ARGS(s),
+
+	TP_STRUCT__entry(
+		__field(	u64,		timer_latency	)
+		__field(	unsigned int,	seqnum		)
+		__field(	int,		context		)
+	),
+
+	TP_fast_assign(
+		__entry->timer_latency = s->timer_latency;
+		__entry->seqnum = s->seqnum;
+		__entry->context = s->context;
+	),
+
+	TP_printk("timer_latency=%llu seqnum=%u context=%d",
+		  __entry->timer_latency,
+		  __entry->seqnum,
+		  __entry->context)
+);
+#endif // CONFIG_TIMERLAT_TRACER
+
 TRACE_EVENT(thread_noise,
 
 	TP_PROTO(struct task_struct *t, u64 start, u64 duration),
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index f3a2722ee4c0..d7083526d922 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -315,33 +315,6 @@ static inline void osn_var_reset_all(void)
  */
 bool trace_osnoise_callback_enabled;
 
-/*
- * osnoise sample structure definition. Used to store the statistics of a
- * sample run.
- */
-struct osnoise_sample {
-	u64			runtime;	/* runtime */
-	u64			noise;		/* noise */
-	u64			max_sample;	/* max single noise sample */
-	int			hw_count;	/* # HW (incl. hypervisor) interference */
-	int			nmi_count;	/* # NMIs during this sample */
-	int			irq_count;	/* # IRQs during this sample */
-	int			softirq_count;	/* # softirqs during this sample */
-	int			thread_count;	/* # threads during this sample */
-};
-
-#ifdef CONFIG_TIMERLAT_TRACER
-/*
- * timerlat sample structure definition. Used to store the statistics of
- * a sample run.
- */
-struct timerlat_sample {
-	u64			timer_latency;	/* timer_latency */
-	unsigned int		seqnum;		/* unique sequence */
-	int			context;	/* timer context */
-};
-#endif
-
 /*
  * Tracer data.
  */
@@ -497,7 +470,7 @@ static void print_osnoise_headers(struct seq_file *s)
  * Record an osnoise_sample into the tracer buffer.
  */
 static void
-__trace_osnoise_sample(struct osnoise_sample *sample, struct trace_buffer *buffer)
+__record_osnoise_sample(struct osnoise_sample *sample, struct trace_buffer *buffer)
 {
 	struct ring_buffer_event *event;
 	struct osnoise_entry *entry;
@@ -520,17 +493,19 @@ __trace_osnoise_sample(struct osnoise_sample *sample, struct trace_buffer *buffe
 }
 
 /*
- * Record an osnoise_sample on all osnoise instances.
+ * Record an osnoise_sample on all osnoise instances and fire trace event.
  */
-static void trace_osnoise_sample(struct osnoise_sample *sample)
+static void record_osnoise_sample(struct osnoise_sample *sample)
 {
 	struct osnoise_instance *inst;
 	struct trace_buffer *buffer;
 
+	trace_osnoise_sample(sample);
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
 		buffer = inst->tr->array_buffer.buffer;
-		__trace_osnoise_sample(sample, buffer);
+		__record_osnoise_sample(sample, buffer);
 	}
 	rcu_read_unlock();
 }
@@ -574,7 +549,7 @@ static void print_timerlat_headers(struct seq_file *s)
 #endif /* CONFIG_PREEMPT_RT */
 
 static void
-__trace_timerlat_sample(struct timerlat_sample *sample, struct trace_buffer *buffer)
+__record_timerlat_sample(struct timerlat_sample *sample, struct trace_buffer *buffer)
 {
 	struct ring_buffer_event *event;
 	struct timerlat_entry *entry;
@@ -594,15 +569,17 @@ __trace_timerlat_sample(struct timerlat_sample *sample, struct trace_buffer *buf
 /*
  * Record an timerlat_sample into the tracer buffer.
  */
-static void trace_timerlat_sample(struct timerlat_sample *sample)
+static void record_timerlat_sample(struct timerlat_sample *sample)
 {
 	struct osnoise_instance *inst;
 	struct trace_buffer *buffer;
 
+	trace_timerlat_sample(sample);
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
 		buffer = inst->tr->array_buffer.buffer;
-		__trace_timerlat_sample(sample, buffer);
+		__record_timerlat_sample(sample, buffer);
 	}
 	rcu_read_unlock();
 }
@@ -1608,7 +1585,7 @@ static int run_osnoise(void)
 	/* Save interference stats info */
 	diff_osn_sample_stats(osn_var, &s);
 
-	trace_osnoise_sample(&s);
+	record_osnoise_sample(&s);
 
 	notify_new_max_latency(max_noise);
 
@@ -1803,7 +1780,7 @@ static enum hrtimer_restart timerlat_irq(struct hrtimer *timer)
 	s.timer_latency = diff;
 	s.context = IRQ_CONTEXT;
 
-	trace_timerlat_sample(&s);
+	record_timerlat_sample(&s);
 
 	if (osnoise_data.stop_tracing) {
 		if (time_to_us(diff) >= osnoise_data.stop_tracing) {
@@ -1923,7 +1900,7 @@ static int timerlat_main(void *data)
 		s.timer_latency = diff;
 		s.context = THREAD_CONTEXT;
 
-		trace_timerlat_sample(&s);
+		record_timerlat_sample(&s);
 
 		notify_new_max_latency(diff);
 
@@ -2529,7 +2506,7 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 		s.timer_latency = diff;
 		s.context = THREAD_URET;
 
-		trace_timerlat_sample(&s);
+		record_timerlat_sample(&s);
 
 		notify_new_max_latency(diff);
 
@@ -2564,7 +2541,7 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 	s.timer_latency = diff;
 	s.context = THREAD_CONTEXT;
 
-	trace_timerlat_sample(&s);
+	record_timerlat_sample(&s);
 
 	if (osnoise_data.stop_tracing_total) {
 		if (time_to_us(diff) >= osnoise_data.stop_tracing_total) {
-- 
2.47.2



