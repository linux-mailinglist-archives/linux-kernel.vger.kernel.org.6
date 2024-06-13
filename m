Return-Path: <linux-kernel+bounces-212362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E022F905F16
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 01:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62119284790
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D902012DDA7;
	Wed, 12 Jun 2024 23:20:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5EB12C80F;
	Wed, 12 Jun 2024 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718234406; cv=none; b=E4rzg13G2UfRqHOjkS/fWiRb6Rg7+RwACOSidsVyhrMkRhCy3zamNpyd9AdRAJSPu4cAi2Ru4RUpMyEeeXmv2C3fepEN3F6Xnx08y1arSS+GpOlMhK/qVti2nha2RW6I1gqhyBUf1w73LbYu6g/ICQcjG7uDjoR4bbHNfCIwtWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718234406; c=relaxed/simple;
	bh=3UfkaqkBpnx6QuH4w7P0TzeLjusSm/+/FRuwYN80P9g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CVmb2eO8y69djFEBKJDYLNtBT+vBG9iV8vyULhym1wtdH+ll+XFVSF8x6W4SQdxc+iV8lRBBydbe0jsN8NnzWwJDIdkfB1o+i1LNDsbbBx+oNF4cG4ItONEWZEJjPgFoFg9DPoAr00yaTdXBZn+djHBp0rLn26FCZjc8nBxxz1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D788C4AF49;
	Wed, 12 Jun 2024 23:20:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sHXGT-00000001db0-28ck;
	Wed, 12 Jun 2024 19:20:25 -0400
Message-ID: <20240612232025.363998725@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 12 Jun 2024 19:19:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Youssef Esmat <youssefesmat@google.com>,
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
 Kees Cook <keescook@chromium.org>
Subject: [PATCH v6 02/13] ring-buffer: Add ring_buffer_alloc_range()
References: <20240612231934.608252486@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

In preparation to allowing the trace ring buffer to be allocated in a
range of memory that is persistent across reboots, add
ring_buffer_alloc_range(). It takes a contiguous range of memory and will
split it up evenly for the per CPU ring buffers.

If there's not enough memory to handle all CPUs with the minimum size, it
will fail to allocate the ring buffer.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  17 +++
 kernel/trace/ring_buffer.c  | 239 ++++++++++++++++++++++++++++++------
 2 files changed, 220 insertions(+), 36 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 96d2140b471e..a50b0223b1d3 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -89,6 +89,11 @@ void ring_buffer_discard_commit(struct trace_buffer *buffer,
 struct trace_buffer *
 __ring_buffer_alloc(unsigned long size, unsigned flags, struct lock_class_key *key);
 
+struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flags,
+					       int order, unsigned long start,
+					       unsigned long range_size,
+					       struct lock_class_key *key);
+
 /*
  * Because the ring buffer is generic, if other users of the ring buffer get
  * traced by ftrace, it can produce lockdep warnings. We need to keep each
@@ -100,6 +105,18 @@ __ring_buffer_alloc(unsigned long size, unsigned flags, struct lock_class_key *k
 	__ring_buffer_alloc((size), (flags), &__key);	\
 })
 
+/*
+ * Because the ring buffer is generic, if other users of the ring buffer get
+ * traced by ftrace, it can produce lockdep warnings. We need to keep each
+ * ring buffer's lock class separate.
+ */
+#define ring_buffer_alloc_range(size, flags, order, start, range_size)	\
+({									\
+	static struct lock_class_key __key;				\
+	__ring_buffer_alloc_range((size), (flags), (order), (start),	\
+				  (range_size), &__key);		\
+})
+
 typedef bool (*ring_buffer_cond_fn)(void *data);
 int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full,
 		     ring_buffer_cond_fn cond, void *data);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a240bdc0f2d8..6edd70e45807 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -42,6 +42,9 @@
 
 static void update_pages_handler(struct work_struct *work);
 
+struct ring_buffer_meta {
+};
+
 /*
  * The ring buffer header is special. We must manually up keep it.
  */
@@ -342,7 +345,8 @@ struct buffer_page {
 	local_t		 entries;	/* entries on this page */
 	unsigned long	 real_end;	/* real end of data */
 	unsigned	 order;		/* order of the page */
-	u32		 id;		/* ID for external mapping */
+	u32		 id:30;		/* ID for external mapping */
+	u32		 range:1;	/* Mapped via a range */
 	struct buffer_data_page *page;	/* Actual data page */
 };
 
@@ -373,7 +377,9 @@ static __always_inline unsigned int rb_page_commit(struct buffer_page *bpage)
 
 static void free_buffer_page(struct buffer_page *bpage)
 {
-	free_pages((unsigned long)bpage->page, bpage->order);
+	/* Range pages are not to be freed */
+	if (!bpage->range)
+		free_pages((unsigned long)bpage->page, bpage->order);
 	kfree(bpage);
 }
 
@@ -524,6 +530,9 @@ struct trace_buffer {
 	struct rb_irq_work		irq_work;
 	bool				time_stamp_abs;
 
+	unsigned long			range_addr_start;
+	unsigned long			range_addr_end;
+
 	unsigned int			subbuf_size;
 	unsigned int			subbuf_order;
 	unsigned int			max_data_size;
@@ -1491,9 +1500,70 @@ static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 	}
 }
 
+/*
+ * Take an address, add the meta data size as well as the array of
+ * array subbuffer indexes, then align it to a subbuffer size.
+ *
+ * This is used to help find the next per cpu subbuffer within a mapped range.
+ */
+static unsigned long
+rb_range_align_subbuf(unsigned long addr, int subbuf_size, int nr_subbufs)
+{
+	addr += sizeof(struct ring_buffer_meta) +
+		sizeof(int) * nr_subbufs;
+	return ALIGN(addr, subbuf_size);
+}
+
+/*
+ * Return a specific sub-buffer for a given @cpu defined by @idx.
+ */
+static void *rb_range_buffer(struct trace_buffer *buffer, int cpu, int nr_pages, int idx)
+{
+	unsigned long ptr;
+	int subbuf_size = buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
+	int nr_subbufs;
+
+	/* Include the reader page */
+	nr_subbufs = nr_pages + 1;
+
+	/*
+	 * The first chunk may not be subbuffer aligned, where as
+	 * the rest of the chunks are.
+	 */
+	ptr = buffer->range_addr_start;
+	ptr = rb_range_align_subbuf(ptr, subbuf_size, nr_subbufs);
+	if (cpu) {
+		unsigned long p;
+
+		ptr += subbuf_size * nr_subbufs;
+
+		/* Save the beginning of this CPU chunk */
+		p = ptr;
+
+		ptr = rb_range_align_subbuf(ptr, subbuf_size, nr_subbufs);
+
+		/* We can use multiplication to find chunks greater than 1 */
+		if (cpu > 1) {
+			unsigned long size;
+
+			ptr += subbuf_size * nr_subbufs;
+
+			/* Now all chunks after this are the same size */
+			size = ptr - p;
+			ptr += size * (cpu - 2);
+
+			ptr = rb_range_align_subbuf(ptr, subbuf_size, nr_subbufs);
+		}
+	}
+	if (ptr + subbuf_size * nr_subbufs > buffer->range_addr_end)
+		return NULL;
+	return (void *)ptr;
+}
+
 static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		long nr_pages, struct list_head *pages)
 {
+	struct trace_buffer *buffer = cpu_buffer->buffer;
 	struct buffer_page *bpage, *tmp;
 	bool user_thread = current->mm != NULL;
 	gfp_t mflags;
@@ -1530,6 +1600,7 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		set_current_oom_origin();
 	for (i = 0; i < nr_pages; i++) {
 		struct page *page;
+		int cpu = cpu_buffer->cpu;
 
 		bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
 				    mflags, cpu_to_node(cpu_buffer->cpu));
@@ -1538,14 +1609,26 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 
 		rb_check_bpage(cpu_buffer, bpage);
 
-		list_add(&bpage->list, pages);
-
-		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu),
-					mflags | __GFP_COMP | __GFP_ZERO,
-					cpu_buffer->buffer->subbuf_order);
-		if (!page)
-			goto free_pages;
-		bpage->page = page_address(page);
+		/*
+		 * Append the pages as for mapped buffers we want to keep
+		 * the order
+		 */
+		list_add_tail(&bpage->list, pages);
+
+		if (buffer->range_addr_start) {
+			/* A range was given. Use that for the buffer page */
+			bpage->page = rb_range_buffer(buffer, cpu, nr_pages, i + 1);
+			if (!bpage->page)
+				goto free_pages;
+			bpage->range = 1;
+		} else {
+			page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu),
+						mflags | __GFP_COMP | __GFP_ZERO,
+						cpu_buffer->buffer->subbuf_order);
+			if (!page)
+				goto free_pages;
+			bpage->page = page_address(page);
+		}
 		bpage->order = cpu_buffer->buffer->subbuf_order;
 		rb_init_page(bpage->page);
 
@@ -1627,11 +1710,19 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 
 	cpu_buffer->reader_page = bpage;
 
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_COMP | __GFP_ZERO,
-				cpu_buffer->buffer->subbuf_order);
-	if (!page)
-		goto fail_free_reader;
-	bpage->page = page_address(page);
+	if (buffer->range_addr_start) {
+		bpage->page = rb_range_buffer(buffer, cpu, nr_pages, 0);
+		if (!bpage->page)
+			goto fail_free_reader;
+		bpage->range = 1;
+	} else {
+		page = alloc_pages_node(cpu_to_node(cpu),
+					GFP_KERNEL | __GFP_COMP | __GFP_ZERO,
+					cpu_buffer->buffer->subbuf_order);
+		if (!page)
+			goto fail_free_reader;
+		bpage->page = page_address(page);
+	}
 	rb_init_page(bpage->page);
 
 	INIT_LIST_HEAD(&cpu_buffer->reader_page->list);
@@ -1682,22 +1773,14 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 	kfree(cpu_buffer);
 }
 
-/**
- * __ring_buffer_alloc - allocate a new ring_buffer
- * @size: the size in bytes per cpu that is needed.
- * @flags: attributes to set for the ring buffer.
- * @key: ring buffer reader_lock_key.
- *
- * Currently the only flag that is available is the RB_FL_OVERWRITE
- * flag. This flag means that the buffer will overwrite old data
- * when the buffer wraps. If this flag is not set, the buffer will
- * drop data when the tail hits the head.
- */
-struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
-					struct lock_class_key *key)
+static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
+					 int order, unsigned long start,
+					 unsigned long end,
+					 struct lock_class_key *key)
 {
 	struct trace_buffer *buffer;
 	long nr_pages;
+	int subbuf_size;
 	int bsize;
 	int cpu;
 	int ret;
@@ -1711,14 +1794,13 @@ struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
 	if (!zalloc_cpumask_var(&buffer->cpumask, GFP_KERNEL))
 		goto fail_free_buffer;
 
-	/* Default buffer page size - one system page */
-	buffer->subbuf_order = 0;
-	buffer->subbuf_size = PAGE_SIZE - BUF_PAGE_HDR_SIZE;
+	buffer->subbuf_order = order;
+	subbuf_size = (PAGE_SIZE << order);
+	buffer->subbuf_size = subbuf_size - BUF_PAGE_HDR_SIZE;
 
 	/* Max payload is buffer page size - header (8bytes) */
 	buffer->max_data_size = buffer->subbuf_size - (sizeof(u32) * 2);
 
-	nr_pages = DIV_ROUND_UP(size, buffer->subbuf_size);
 	buffer->flags = flags;
 	buffer->clock = trace_clock_local;
 	buffer->reader_lock_key = key;
@@ -1726,10 +1808,6 @@ struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
 	init_irq_work(&buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&buffer->irq_work.waiters);
 
-	/* need at least two pages */
-	if (nr_pages < 2)
-		nr_pages = 2;
-
 	buffer->cpus = nr_cpu_ids;
 
 	bsize = sizeof(void *) * nr_cpu_ids;
@@ -1738,6 +1816,54 @@ struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
 	if (!buffer->buffers)
 		goto fail_free_cpumask;
 
+	/* If start/end are specified, then that overrides size */
+	if (start && end) {
+		unsigned long ptr;
+		int n;
+
+		size = end - start;
+		size = size / nr_cpu_ids;
+
+		/*
+		 * The number of sub-buffers (nr_pages) is determined by the
+		 * total size allocated minus the meta data size.
+		 * Then that is divided by the number of per CPU buffers
+		 * needed, plus account for the integer array index that
+		 * will be appended to the meta data.
+		 */
+		nr_pages = (size - sizeof(struct ring_buffer_meta)) /
+			(subbuf_size + sizeof(int));
+		/* Need at least two pages plus the reader page */
+		if (nr_pages < 3)
+			goto fail_free_buffers;
+
+ again:
+		/* Make sure that the size fits aligned */
+		for (n = 0, ptr = start; n < nr_cpu_ids; n++) {
+			ptr += sizeof(struct ring_buffer_meta) +
+				sizeof(int) * nr_pages;
+			ptr = ALIGN(ptr, subbuf_size);
+			ptr += subbuf_size * nr_pages;
+		}
+		if (ptr > end) {
+			if (nr_pages <= 3)
+				goto fail_free_buffers;
+			nr_pages--;
+			goto again;
+		}
+
+		/* nr_pages should not count the reader page */
+		nr_pages--;
+		buffer->range_addr_start = start;
+		buffer->range_addr_end = end;
+	} else {
+
+		/* need at least two pages */
+		nr_pages = DIV_ROUND_UP(size, buffer->subbuf_size);
+		if (nr_pages < 2)
+			nr_pages = 2;
+	}
+
 	cpu = raw_smp_processor_id();
 	cpumask_set_cpu(cpu, buffer->cpumask);
 	buffer->buffers[cpu] = rb_allocate_cpu_buffer(buffer, nr_pages, cpu);
@@ -1766,8 +1892,49 @@ struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
 	kfree(buffer);
 	return NULL;
 }
+
+/**
+ * __ring_buffer_alloc - allocate a new ring_buffer
+ * @size: the size in bytes per cpu that is needed.
+ * @flags: attributes to set for the ring buffer.
+ * @key: ring buffer reader_lock_key.
+ *
+ * Currently the only flag that is available is the RB_FL_OVERWRITE
+ * flag. This flag means that the buffer will overwrite old data
+ * when the buffer wraps. If this flag is not set, the buffer will
+ * drop data when the tail hits the head.
+ */
+struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
+					struct lock_class_key *key)
+{
+	/* Default buffer page size - one system page */
+	return alloc_buffer(size, flags, 0, 0, 0,key);
+
+}
 EXPORT_SYMBOL_GPL(__ring_buffer_alloc);
 
+/**
+ * __ring_buffer_alloc_range - allocate a new ring_buffer from existing memory
+ * @size: the size in bytes per cpu that is needed.
+ * @flags: attributes to set for the ring buffer.
+ * @start: start of allocated range
+ * @range_size: size of allocated range
+ * @order: sub-buffer order
+ * @key: ring buffer reader_lock_key.
+ *
+ * Currently the only flag that is available is the RB_FL_OVERWRITE
+ * flag. This flag means that the buffer will overwrite old data
+ * when the buffer wraps. If this flag is not set, the buffer will
+ * drop data when the tail hits the head.
+ */
+struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flags,
+					       int order, unsigned long start,
+					       unsigned long range_size,
+					       struct lock_class_key *key)
+{
+	return alloc_buffer(size, flags, order, start, start + range_size, key);
+}
+
 /**
  * ring_buffer_free - free a ring buffer.
  * @buffer: the buffer to free.
-- 
2.43.0



