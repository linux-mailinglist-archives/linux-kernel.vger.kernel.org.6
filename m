Return-Path: <linux-kernel+bounces-528996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BACA41EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50197188AEC6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210D21A3174;
	Mon, 24 Feb 2025 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j8saYMo4"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CD3219301
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399329; cv=none; b=YjY0LvXYwYNJOGv17vVyboUQSzDUAocmrpsmBrIgEzgm35hAAtmmQs2vS1ghMT9nQPwZg+awUnJYOpwlROrzpoL33xdPUXtROdhu1LVK9eML72XuaNr0kjHZCMEiA3ybfDq3rJxylBsJb46fzgrFzoOAWz1pvtk74jgdbJl1Rrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399329; c=relaxed/simple;
	bh=2EDgKImxG8dUTip2eM2Bli9FfaPUN3K8aLBgBnjNyjg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c+QFTKqWS7B6uV8V5j9ga6OYT4tnSGbEC8FN0c23vWlWh8+uTL4Kjd0VFjSfi5gOKCkizRXidxwDM7tSwAyD7Ruh3XNFSrBObd2cM4OkXxgp5dE9b+Gu8pNnSD+3EPeCAgkqYUwhveDPd6iST4RcZthcRwBJyw+to6taZuNb8UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j8saYMo4; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4398e841963so36940835e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 04:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740399326; x=1741004126; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jWYLW84fII6ZnL9QJz4u7J1y34KkAmylrxqKmP4x71E=;
        b=j8saYMo4MlABTcVnUM1IgdUTHiL+g4kOL9yLFhCdaURpaUY4S2rg9y6J4I+5fZ4OnM
         +JFCJ9a9Zar4mCYQzABN/U6TzO9HEcoTNrhrpQHSCTvoW0rtiCZDsr9tk+r921pHGLuS
         WNB/VUf1YZzHHJ3Z+heIvQphClJQ2d6QB8XICQdWkroTAA6uhaXhDNaf3KoppWz7YnoM
         WPESzjiub9hVkdC9alS+dr4u8BW7j61wthjq07LLxRoLfwSCToVQ/YVJLVcDSHXDaKuZ
         IAMSj0ybTLTmh+I0/A5lClqGZlulUU8IPjpJFf5pW4+mUw9buZ8Knh82j8FE6wStUtvn
         SPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740399326; x=1741004126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWYLW84fII6ZnL9QJz4u7J1y34KkAmylrxqKmP4x71E=;
        b=BNzrOjeI9ob2hbQZpy5DqcgbDF2g0mzTGDEB+q0GnHMZJnLkFEHSH3c0VrjSdBsqED
         PxNrkuBcWXrxS2bywc3pStAO0EfqBGFw4Sj6ss5Ohd+f2tIGY740OtcBUdZztsQAE1oN
         +PoZ0NlGVTwgBOUeA9OjT8yNZ1zgB6g5whfJsIlSF8Fb4QBp64LEsNgpSvbwPWzjfgXt
         t59fGYfhsHUptCvf/SEGujwQHuJ8Og83nBWRSvB82mqv6WbqEuRlDs0qo+Oxm7qEqVip
         Qa+z88sJ8eWe9/7kj4WZ+C+jd8CBKJvpjXskjd2VA03bTjdf+6mwv51dE2/1MPR48B/E
         ij3w==
X-Forwarded-Encrypted: i=1; AJvYcCXK9dTkPlrg3/nym3C7BiOCMLIik9cLtlwo2BETTzKTjJCgRjXpdVVbswFBAMlMPD6gdArFNe4JdasVAbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb4ebTZ7LY1gcwBYn2Ny10G53cjB+VyPAoWxbqEVWGrzQ9wg6V
	j1XPSRuKmKjBKfUj8W6iJR8DsNlFzRDm3zJi4fM1AryI0h3rwSXJKE7iRhVvWJ5ZEq+DJf8ItB7
	ksQIeYIetKM0z50MCiw==
X-Google-Smtp-Source: AGHT+IHyObP309uBRXnN5wwj7NDZKKEgN2u3PMNug3aC5ywwpb/Sai0pnVQ5x/varO7eM7fJIU1wJnfYbD7A4Yfr
X-Received: from wmgg25.prod.google.com ([2002:a05:600d:19:b0:439:997a:8b94])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:6c6d:0:b0:38f:4cdc:5d2a with SMTP id ffacd0b85a97d-38f70783feamr9139552f8f.4.1740399326119;
 Mon, 24 Feb 2025 04:15:26 -0800 (PST)
Date: Mon, 24 Feb 2025 12:13:43 +0000
In-Reply-To: <20250224121353.98697-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250224121353.98697-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250224121353.98697-2-vdonnefort@google.com>
Subject: [PATCH 01/11] ring-buffer: Introduce ring-buffer remote
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

A ring-buffer remote is an entity outside of the kernel (most likely a
firmware or a hypervisor) capable of writing events in a ring-buffer
following the same format as the tracefs ring-buffer.

To setup the ring-buffer on the kernel side, a description of the pages
(struct trace_page_desc) is necessary. A callback (get_reader_page) must
also be provided. It is called whenever it is done reading the previous
reader page.

It is expected from the remote to keep the meta-page updated.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 17fbb7855295..2a1330a65edb 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -248,4 +248,59 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		    struct vm_area_struct *vma);
 int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
 int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu);
+
+#define meta_pages_lost(__meta) \
+	((__meta)->Reserved1)
+#define meta_pages_touched(__meta) \
+	((__meta)->Reserved2)
+
+struct rb_page_desc {
+	unsigned int	cpu;
+	unsigned int	nr_page_va; /* excludes the meta page */
+	unsigned long	meta_va;
+	unsigned long	page_va[];
+};
+
+struct trace_page_desc {
+	size_t		struct_len;
+	unsigned int	nr_cpus;
+	char		__data[]; /* list of rb_page_desc */
+};
+
+static inline
+struct rb_page_desc *__next_rb_page_desc(struct rb_page_desc *pdesc)
+{
+	size_t len = struct_size(pdesc, page_va, pdesc->nr_page_va);
+
+	return (struct rb_page_desc *)((void *)pdesc + len);
+}
+
+static inline
+struct rb_page_desc *__first_rb_page_desc(struct trace_page_desc *trace_pdesc)
+{
+	return (struct rb_page_desc *)(&trace_pdesc->__data[0]);
+}
+
+#define for_each_rb_page_desc(__pdesc, __cpu, __trace_pdesc)		\
+	for (__pdesc = __first_rb_page_desc(__trace_pdesc), __cpu = 0;	\
+	     __cpu < (__trace_pdesc)->nr_cpus;				\
+	     __cpu++, __pdesc = __next_rb_page_desc(__pdesc))
+
+struct ring_buffer_remote {
+	struct trace_page_desc	*pdesc;
+	int			(*get_reader_page)(int cpu);
+	int			(*reset)(int cpu);
+};
+
+int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu);
+
+struct trace_buffer *
+__ring_buffer_alloc_remote(struct ring_buffer_remote *remote,
+			   struct lock_class_key *key);
+
+#define ring_buffer_remote(remote)				\
+({								\
+	static struct lock_class_key __key;			\
+	__ring_buffer_alloc_remote(remote, &__key);		\
+})
 #endif /* _LINUX_RING_BUFFER_H */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index bb6089c2951e..c27516a384a8 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -519,6 +519,8 @@ struct ring_buffer_per_cpu {
 	struct trace_buffer_meta	*meta_page;
 	struct ring_buffer_meta		*ring_meta;
 
+	struct ring_buffer_remote	*remote;
+
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
@@ -541,6 +543,8 @@ struct trace_buffer {
 
 	struct ring_buffer_per_cpu	**buffers;
 
+	struct ring_buffer_remote	*remote;
+
 	struct hlist_node		node;
 	u64				(*clock)(void);
 
@@ -2155,6 +2159,41 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 	return -ENOMEM;
 }
 
+static struct rb_page_desc *rb_page_desc(struct trace_page_desc *trace_pdesc, int cpu)
+{
+	struct rb_page_desc *pdesc, *end;
+	size_t len;
+	int i;
+
+	if (!trace_pdesc)
+		return NULL;
+
+	if (cpu >= trace_pdesc->nr_cpus)
+		return NULL;
+
+	end = (struct rb_page_desc *)((void *)trace_pdesc + trace_pdesc->struct_len);
+	pdesc = __first_rb_page_desc(trace_pdesc);
+	len = struct_size(pdesc, page_va, pdesc->nr_page_va);
+	pdesc = (struct rb_page_desc *)((void *)pdesc + (len * cpu));
+
+	if (pdesc < end && pdesc->cpu == cpu)
+		return pdesc;
+
+	/* Missing CPUs, need to linear search */
+	for_each_rb_page_desc(pdesc, i, trace_pdesc) {
+		if (pdesc->cpu == cpu)
+			return pdesc;
+	}
+
+	return NULL;
+}
+
+static void *rb_page_desc_page(struct rb_page_desc *pdesc, int page_id)
+{
+	return page_id > pdesc->nr_page_va ? NULL : (void *)pdesc->page_va[page_id];
+}
+
+
 static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 			     unsigned long nr_pages)
 {
@@ -2215,6 +2254,31 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 
 	cpu_buffer->reader_page = bpage;
 
+	if (buffer->remote) {
+		struct rb_page_desc *pdesc = rb_page_desc(buffer->remote->pdesc, cpu);
+
+		if (!pdesc)
+			goto fail_free_reader;
+
+		cpu_buffer->remote = buffer->remote;
+		cpu_buffer->meta_page = (struct trace_buffer_meta *)(void *)pdesc->meta_va;
+		cpu_buffer->subbuf_ids = pdesc->page_va;
+		cpu_buffer->nr_pages = pdesc->nr_page_va - 1;
+		atomic_inc(&cpu_buffer->record_disabled);
+		atomic_inc(&cpu_buffer->resize_disabled);
+
+		bpage->page = rb_page_desc_page(pdesc,
+						cpu_buffer->meta_page->reader.id);
+		if (!bpage->page)
+			goto fail_free_reader;
+		/*
+		 * The meta-page can only describe which of the ring-buffer page
+		 * is the reader. There is no need to init the rest of the
+		 * ring-buffer.
+		 */
+		return cpu_buffer;
+	}
+
 	if (buffer->range_addr_start) {
 		/*
 		 * Range mapped buffers have the same restrictions as memory
@@ -2292,6 +2356,10 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 
 	irq_work_sync(&cpu_buffer->irq_work.work);
 
+	/* remote ring-buffer. We do not own the data pages */
+	if (cpu_buffer->remote)
+		cpu_buffer->reader_page->page = NULL;
+
 	free_buffer_page(cpu_buffer->reader_page);
 
 	if (head) {
@@ -2313,7 +2381,8 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 					 int order, unsigned long start,
 					 unsigned long end,
-					 struct lock_class_key *key)
+					 struct lock_class_key *key,
+					 struct ring_buffer_remote *remote)
 {
 	struct trace_buffer *buffer;
 	long nr_pages;
@@ -2341,6 +2410,11 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 	buffer->flags = flags;
 	buffer->clock = trace_clock_local;
 	buffer->reader_lock_key = key;
+	if (remote) {
+		buffer->remote = remote;
+		/* The writer is remote. This ring-buffer is read-only */
+		atomic_inc(&buffer->record_disabled);
+	}
 
 	init_irq_work(&buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&buffer->irq_work.waiters);
@@ -2447,7 +2521,7 @@ struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
 					struct lock_class_key *key)
 {
 	/* Default buffer page size - one system page */
-	return alloc_buffer(size, flags, 0, 0, 0,key);
+	return alloc_buffer(size, flags, 0, 0, 0, key, NULL);
 
 }
 EXPORT_SYMBOL_GPL(__ring_buffer_alloc);
@@ -2471,7 +2545,18 @@ struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flag
 					       unsigned long range_size,
 					       struct lock_class_key *key)
 {
-	return alloc_buffer(size, flags, order, start, start + range_size, key);
+	return alloc_buffer(size, flags, order, start, start + range_size, key, NULL);
+}
+
+/**
+ * __ring_buffer_alloc_remote - allocate a new ring_buffer from a remote
+ * @remote: Contains a description of the ring-buffer pages and remote callbacks.
+ * @key: ring buffer reader_lock_key.
+ */
+struct trace_buffer *__ring_buffer_alloc_remote(struct ring_buffer_remote *remote,
+						struct lock_class_key *key)
+{
+	return alloc_buffer(0, 0, 0, 0, 0, key, remote);
 }
 
 /**
@@ -5225,8 +5310,56 @@ rb_update_iter_read_stamp(struct ring_buffer_iter *iter,
 	}
 }
 
+static bool rb_read_remote_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	local_set(&cpu_buffer->entries, READ_ONCE(cpu_buffer->meta_page->entries));
+	local_set(&cpu_buffer->overrun, READ_ONCE(cpu_buffer->meta_page->overrun));
+	local_set(&cpu_buffer->pages_touched, READ_ONCE(meta_pages_touched(cpu_buffer->meta_page)));
+	local_set(&cpu_buffer->pages_lost, READ_ONCE(meta_pages_lost(cpu_buffer->meta_page)));
+	/*
+	 * No need to get the "read" field, it can be tracked here as any
+	 * reader will have to go through a rign_buffer_per_cpu.
+	 */
+
+	return rb_num_of_entries(cpu_buffer);
+}
+
 static struct buffer_page *
-rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
+__rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	u32 prev_reader;
+
+	if (!rb_read_remote_meta_page(cpu_buffer))
+		return NULL;
+
+	/* More to read on the reader page */
+	if (cpu_buffer->reader_page->read < rb_page_size(cpu_buffer->reader_page)) {
+		if (!cpu_buffer->reader_page->read)
+			cpu_buffer->read_stamp = cpu_buffer->reader_page->page->time_stamp;
+		return cpu_buffer->reader_page;
+	}
+
+	prev_reader = cpu_buffer->meta_page->reader.id;
+
+	WARN_ON(cpu_buffer->remote->get_reader_page(cpu_buffer->cpu));
+	/* nr_pages doesn't include the reader page */
+	if (WARN_ON(cpu_buffer->meta_page->reader.id > cpu_buffer->nr_pages))
+		return NULL;
+
+	cpu_buffer->reader_page->page =
+		(void *)cpu_buffer->subbuf_ids[cpu_buffer->meta_page->reader.id];
+	cpu_buffer->reader_page->id = cpu_buffer->meta_page->reader.id;
+	cpu_buffer->reader_page->read = 0;
+	cpu_buffer->read_stamp = cpu_buffer->reader_page->page->time_stamp;
+	cpu_buffer->lost_events = cpu_buffer->meta_page->reader.lost_events;
+
+	WARN_ON(prev_reader == cpu_buffer->meta_page->reader.id);
+
+	return rb_page_size(cpu_buffer->reader_page) ? cpu_buffer->reader_page : NULL;
+}
+
+static struct buffer_page *
+__rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct buffer_page *reader = NULL;
 	unsigned long bsize = READ_ONCE(cpu_buffer->buffer->subbuf_size);
@@ -5397,6 +5530,13 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	return reader;
 }
 
+static struct buffer_page *
+rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	return cpu_buffer->remote ? __rb_get_reader_page_from_remote(cpu_buffer) :
+				    __rb_get_reader_page(cpu_buffer);
+}
+
 static void rb_advance_reader(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct ring_buffer_event *event;
@@ -5801,7 +5941,7 @@ ring_buffer_read_prepare(struct trace_buffer *buffer, int cpu, gfp_t flags)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_iter *iter;
 
-	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+	if (!cpumask_test_cpu(cpu, buffer->cpumask) || buffer->remote)
 		return NULL;
 
 	iter = kzalloc(sizeof(*iter), flags);
@@ -5971,6 +6111,23 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct buffer_page *page;
 
+	if (cpu_buffer->remote) {
+		if (!cpu_buffer->remote->reset)
+			return;
+
+		cpu_buffer->remote->reset(cpu_buffer->cpu);
+		rb_read_remote_meta_page(cpu_buffer);
+
+		/* Read related values, not covered by the meta-page */
+		local_set(&cpu_buffer->pages_read, 0);
+		cpu_buffer->read = 0;
+		cpu_buffer->read_bytes = 0;
+		cpu_buffer->last_overrun = 0;
+		cpu_buffer->reader_page->read = 0;
+
+		return;
+	}
+
 	rb_head_page_deactivate(cpu_buffer);
 
 	cpu_buffer->head_page
@@ -6218,6 +6375,49 @@ bool ring_buffer_empty_cpu(struct trace_buffer *buffer, int cpu)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_empty_cpu);
 
+int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	unsigned long flags;
+
+	if (cpu != RING_BUFFER_ALL_CPUS) {
+		if (!cpumask_test_cpu(cpu, buffer->cpumask))
+			return -EINVAL;
+
+		cpu_buffer = buffer->buffers[cpu];
+
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+		if (rb_read_remote_meta_page(cpu_buffer))
+			rb_wakeups(buffer, cpu_buffer);
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+
+		return 0;
+	}
+
+	/*
+	 * Make sure all the ring buffers are up to date before we start reading
+	 * them.
+	 */
+	for_each_buffer_cpu(buffer, cpu) {
+		cpu_buffer = buffer->buffers[cpu];
+
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+		rb_read_remote_meta_page(buffer->buffers[cpu]);
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	}
+
+	for_each_buffer_cpu(buffer, cpu) {
+		cpu_buffer = buffer->buffers[cpu];
+
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+		if (rb_num_of_entries(cpu_buffer))
+			rb_wakeups(buffer, buffer->buffers[cpu]);
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_RING_BUFFER_ALLOW_SWAP
 /**
  * ring_buffer_swap_cpu - swap a CPU buffer between two ring buffers
@@ -6469,6 +6669,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	unsigned int commit;
 	unsigned int read;
 	u64 save_timestamp;
+	bool force_memcpy;
 	int ret = -1;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
@@ -6506,6 +6707,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	/* Check if any events were dropped */
 	missed_events = cpu_buffer->lost_events;
 
+	force_memcpy = cpu_buffer->mapped || cpu_buffer->remote;
+
 	/*
 	 * If this page has been partially read or
 	 * if len is not big enough to read the rest of the page or
@@ -6515,7 +6718,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	 */
 	if (read || (len < (commit - read)) ||
 	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
-	    cpu_buffer->mapped) {
+	    force_memcpy) {
 		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
 		unsigned int rpos = read;
 		unsigned int pos = 0;
@@ -7097,7 +7300,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	unsigned long flags, *subbuf_ids;
 	int err = 0;
 
-	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+	if (!cpumask_test_cpu(cpu, buffer->cpumask) || buffer->remote)
 		return -EINVAL;
 
 	cpu_buffer = buffer->buffers[cpu];
-- 
2.48.1.601.g30ceb7b040-goog


