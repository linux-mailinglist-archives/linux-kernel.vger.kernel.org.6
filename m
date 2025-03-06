Return-Path: <linux-kernel+bounces-549205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D6EA54F06
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9C218988A1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD202147F7;
	Thu,  6 Mar 2025 15:26:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5755211A29
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741274777; cv=none; b=QGxL1Mv8haJShA7rDlB36yWifrvcbbruKZiSPK3JxIKWkFvhnKFEokVPL00uk9u7XLrVyhHy/iKP5BLTTHFR5+WYJLvgEC/SvUkgvvRYcOX0W5LmzDhp64cwJp1xWgoJ03kVDMZiaMHabEYYTGkLgEBrsw6wV8ojdq+c0OC39tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741274777; c=relaxed/simple;
	bh=hEkxuiRCA6cRZHJ5XwIsYod70mdBZEyM/KfZrrfntnk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nAHTzLm3UHUl4Js1o67OgZZ1dk8WofjjnxxPSDBiqFABN1VEVlFQIwYFDoD4NsUEmM2u1cnvXzkQcP5/+bneinhOvRfdwfVFtDbkk2ad4nIY6z7foOQBMM1uThUpp9R6rCQtguTp0vG5a7pS+dsJyUEMuYTm+Oar+vTPI/xBv7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B623BC4CEEA;
	Thu,  6 Mar 2025 15:26:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tqD75-00000000MdH-0k3j;
	Thu, 06 Mar 2025 10:26:19 -0500
Message-ID: <20250306152619.051545903@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Mar 2025 10:25:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 06/10] tracing: Have persistent trace instances save KASLR offset
References: <20250306152548.763044302@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

There's no reason to save the KASLR offset for the ring buffer itself.
That is used by the tracer. Now that the tracer has a way to save data in
the persistent memory of the ring buffer, have the tracing infrastructure
take care of the saving of the KASLR offset.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/20250305164608.792722274@goodmis.org
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  1 -
 kernel/trace/ring_buffer.c  | 59 +++++++------------------------------
 kernel/trace/trace.c        | 37 +++++++++++++++++++----
 kernel/trace/trace.h        |  6 ++--
 4 files changed, 46 insertions(+), 57 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 019b59a0bbc9..56e27263acf8 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -95,7 +95,6 @@ struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flag
 					       unsigned long scratch_size,
 					       struct lock_class_key *key);
 
-bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, unsigned long *kaslr_addr);
 void *ring_buffer_meta_scratch(struct trace_buffer *buffer, unsigned int *size);
 
 /*
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index bff199d31df3..649724efd1be 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -55,7 +55,6 @@ struct ring_buffer_meta {
 };
 
 struct ring_buffer_cpu_meta {
-	unsigned long	kaslr_addr;
 	unsigned long	first_buffer;
 	unsigned long	head_buffer;
 	unsigned long	commit_buffer;
@@ -557,8 +556,6 @@ struct trace_buffer {
 
 	struct ring_buffer_meta		*meta;
 
-	unsigned long			kaslr_addr;
-
 	unsigned int			subbuf_size;
 	unsigned int			subbuf_order;
 	unsigned int			max_data_size;
@@ -1949,15 +1946,6 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	}
 }
 
-static void rb_meta_init_text_addr(struct ring_buffer_cpu_meta *meta)
-{
-#ifdef CONFIG_RANDOMIZE_BASE
-	meta->kaslr_addr = kaslr_offset();
-#else
-	meta->kaslr_addr = 0;
-#endif
-}
-
 static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages, int scratch_size)
 {
 	struct ring_buffer_cpu_meta *meta;
@@ -1990,7 +1978,6 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages, int sc
 			meta->first_buffer += delta;
 			meta->head_buffer += delta;
 			meta->commit_buffer += delta;
-			buffer->kaslr_addr = meta->kaslr_addr;
 			continue;
 		}
 
@@ -2007,7 +1994,6 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages, int sc
 		subbuf = rb_subbufs_from_meta(meta);
 
 		meta->first_buffer = (unsigned long)subbuf;
-		rb_meta_init_text_addr(meta);
 
 		/*
 		 * The buffers[] array holds the order of the sub-buffers
@@ -2549,35 +2535,22 @@ struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flag
 			    scratch_size, key);
 }
 
-/**
- * ring_buffer_last_boot_delta - return the delta offset from last boot
- * @buffer: The buffer to return the delta from
- * @text: Return text delta
- * @data: Return data delta
- *
- * Returns: The true if the delta is non zero
- */
-bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, unsigned long *kaslr_addr)
-{
-	if (!buffer)
-		return false;
-
-	if (!buffer->kaslr_addr)
-		return false;
-
-	*kaslr_addr = buffer->kaslr_addr;
-
-	return true;
-}
-
 void *ring_buffer_meta_scratch(struct trace_buffer *buffer, unsigned int *size)
 {
+	struct ring_buffer_meta *meta;
+	void *ptr;
+
 	if (!buffer || !buffer->meta)
 		return NULL;
 
-	*size = PAGE_SIZE - sizeof(*buffer->meta);
+	meta = buffer->meta;
 
-	return (void *)buffer->meta + sizeof(*buffer->meta);
+	ptr = (void *)ALIGN((unsigned long)meta + sizeof(*meta), sizeof(long));
+
+	if (size)
+		*size = (void *)meta + meta->buffers_offset - ptr;
+
+	return ptr;
 }
 
 /**
@@ -6144,7 +6117,6 @@ static void reset_disabled_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
-	struct ring_buffer_cpu_meta *meta;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return;
@@ -6163,11 +6135,6 @@ void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
 	atomic_dec(&cpu_buffer->record_disabled);
 	atomic_dec(&cpu_buffer->resize_disabled);
 
-	/* Make sure persistent meta now uses this buffer's addresses */
-	meta = rb_range_meta(buffer, 0, cpu_buffer->cpu);
-	if (meta)
-		rb_meta_init_text_addr(meta);
-
 	mutex_unlock(&buffer->mutex);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
@@ -6182,7 +6149,6 @@ EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
 void ring_buffer_reset_online_cpus(struct trace_buffer *buffer)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	struct ring_buffer_cpu_meta *meta;
 	int cpu;
 
 	/* prevent another thread from changing buffer sizes */
@@ -6210,11 +6176,6 @@ void ring_buffer_reset_online_cpus(struct trace_buffer *buffer)
 
 		reset_disabled_cpu_buffer(cpu_buffer);
 
-		/* Make sure persistent meta now uses this buffer's addresses */
-		meta = rb_range_meta(buffer, 0, cpu_buffer->cpu);
-		if (meta)
-			rb_meta_init_text_addr(meta);
-
 		atomic_dec(&cpu_buffer->record_disabled);
 		atomic_sub(RESET_BIT, &cpu_buffer->resize_disabled);
 	}
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 69dcd7edaf26..12a359c293c6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5988,8 +5988,14 @@ ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 	return __tracing_resize_ring_buffer(tr, size, cpu_id);
 }
 
+struct trace_scratch {
+	unsigned long		kaslr_addr;
+};
+
 static void update_last_data(struct trace_array *tr)
 {
+	struct trace_scratch *tscratch;
+
 	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
 		return;
 
@@ -6004,6 +6010,17 @@ static void update_last_data(struct trace_array *tr)
 	/* Using current data now */
 	tr->text_delta = 0;
 
+	if (!tr->scratch)
+		return;
+
+	tscratch = tr->scratch;
+
+	/* Set the persistent ring buffer meta data to this address */
+#ifdef CONFIG_RANDOMIZE_BASE
+	tscratch->kaslr_addr = kaslr_offset();
+#else
+	tscratch->kaslr_addr = 0;
+#endif
 	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
 }
 
@@ -6817,6 +6834,7 @@ static ssize_t
 tracing_last_boot_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 {
 	struct trace_array *tr = filp->private_data;
+	struct trace_scratch *tscratch = tr->scratch;
 	struct seq_buf seq;
 	char buf[64];
 
@@ -6829,8 +6847,8 @@ tracing_last_boot_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t
 	 * Otherwise it shows the KASLR address from the previous boot which
 	 * should not be the same as the current boot.
 	 */
-	if (tr->flags & TRACE_ARRAY_FL_LAST_BOOT)
-		seq_buf_printf(&seq, "%lx\t[kernel]\n", tr->kaslr_addr);
+	if (tscratch && (tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
+		seq_buf_printf(&seq, "%lx\t[kernel]\n", tscratch->kaslr_addr);
 	else
 		seq_buf_puts(&seq, "# Current\n");
 
@@ -9206,6 +9224,8 @@ static int
 allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size)
 {
 	enum ring_buffer_flags rb_flags;
+	struct trace_scratch *tscratch;
+	unsigned int scratch_size;
 
 	rb_flags = tr->trace_flags & TRACE_ITER_OVERWRITE ? RB_FL_OVERWRITE : 0;
 
@@ -9214,12 +9234,19 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
 	if (tr->range_addr_start && tr->range_addr_size) {
 		buf->buffer = ring_buffer_alloc_range(size, rb_flags, 0,
 						      tr->range_addr_start,
-						      tr->range_addr_size, 0);
+						      tr->range_addr_size,
+						      sizeof(*tscratch));
+
+		tscratch = ring_buffer_meta_scratch(buf->buffer, &scratch_size);
+		if (tscratch) {
+			tr->scratch = tscratch;
+			tr->scratch_size = scratch_size;
 
 #ifdef CONFIG_RANDOMIZE_BASE
-		if (ring_buffer_last_boot_delta(buf->buffer, &tr->kaslr_addr))
-			tr->text_delta = kaslr_offset() - tr->kaslr_addr;
+			if (tscratch->kaslr_addr)
+				tr->text_delta = kaslr_offset() - tscratch->kaslr_addr;
 #endif
+		}
 		/*
 		 * This is basically the same as a mapped buffer,
 		 * with the same restrictions.
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index abe8169c3e87..3a020fb82a34 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -348,8 +348,11 @@ struct trace_array {
 	unsigned int		mapped;
 	unsigned long		range_addr_start;
 	unsigned long		range_addr_size;
-	unsigned long		kaslr_addr;
 	long			text_delta;
+	void			*scratch; /* pointer in persistent memory */
+	int			scratch_size;
+
+	int			buffer_disabled;
 
 	struct trace_pid_list	__rcu *filtered_pids;
 	struct trace_pid_list	__rcu *filtered_no_pids;
@@ -367,7 +370,6 @@ struct trace_array {
 	 * CONFIG_TRACER_MAX_TRACE.
 	 */
 	arch_spinlock_t		max_lock;
-	int			buffer_disabled;
 #ifdef CONFIG_FTRACE_SYSCALLS
 	int			sys_refcount_enter;
 	int			sys_refcount_exit;
-- 
2.47.2



