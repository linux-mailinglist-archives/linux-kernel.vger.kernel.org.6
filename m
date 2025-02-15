Return-Path: <linux-kernel+bounces-516385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 078ECA37077
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 20:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8690A18936E8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 19:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70A31EDA0F;
	Sat, 15 Feb 2025 19:47:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84B15696E
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 19:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739648842; cv=none; b=tqqcQmdeAAeYu1JY/trk7srzR6hL32Id4N/GPOrLlbVUff/adFBDELsSZIRF+6fhI2c9wylwyqMHesuW8X42tgLR4HIBZA1zOVSqiNtrt8tWcXTLD4LlBXVQvKj8IuNpdGFDRfs7wT56WYNAlfORPZkUWzQeq2n+jpYjarWHL9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739648842; c=relaxed/simple;
	bh=4wl7UBTs5Mar2UqO8ZJnxz/AGe9h4i57Uf+woQkLdl0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mT8DZs14WLdWl8QNSUchGTPC3HQdRnMX652A1zeOrlJtuBdBmq1cDXt00dceZ9LiAlTb9D1qZrGlxCXmxpoA56w+zflEUQbTud6Y0jBVgEx42zROq4k26DvgsovdqgyQhp48lXXyD37NuoLYoFXel1ldrZTybiKo7xfMcelgQTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CEAC4CEDF;
	Sat, 15 Feb 2025 19:47:21 +0000 (UTC)
Date: Sat, 15 Feb 2025 14:47:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] ring-buffer: Fixes for v6.14
Message-ID: <20250215144719.404616dc@batman.local.home>
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

Ring buffer fixes for v6.14:

- Enable resize on mmap() error

  When a process mmaps a ring buffer, its size is locked and resizing is
  disabled. But if the user passes in a wrong parameter, the mmap() can fail
  after the resize was disabled and the mmap() exits with error without
  reenabling the ring buffer resize. This prevents the ring buffer from ever
  being resized after that. Reenable resizing of the ring buffer on mmap()
  error.

- Have resizing return proper error and not always -ENOMEM

  If the ring buffer is mmapped by one task and another task tries to resize
  the buffer it will error with -ENOMEM. This is confusing to the user as
  there may be plenty of memory available. Have it return the error that
  actually happens (in this case -EBUSY) where the user can understand why
  the resize failed.

- Test the sub-buffer array to validate persistent memory buffer

  On boot up, the initialization of the persistent memory buffer will do a
  validation check to see if the content of the data is valid, and if so, it
  will use the memory as is, otherwise it re-initializes it. There's meta
  data in this persistent memory that keeps track of which sub-buffer is the
  reader page and an array that states the order of the sub-buffers. The
  values in this array are indexes into the sub-buffers. The validator
  checks to make sure that all the entries in the array are within the
  sub-buffer list index, but it does not check for duplications.

  While working on this code, the array got corrupted and had duplicates,
  where not all the sub-buffers were accounted for. This passed the
  validator as all entries were valid, but the link list was incorrect and
  could have caused a crash. The corruption only produced incorrect data,
  but it could have been more severe. To fix this, create a bitmask that
  covers all the sub-buffer indexes and set it to all zeros. While iterating
  the array checking the values of the array content, have it set a bit
  corresponding to the index in the array. If the bit was already set, then
  it is a duplicate and mark the buffer as invalid and reset it.

- Prevent mmap()ing persistent ring buffer

  The persistent ring buffer uses vmap() to map the persistent memory.
  Currently, the mmap() logic only uses virt_to_page() to get the page
  from the ring buffer memory and use that to map to user space. This works
  because a normal ring buffer uses alloc_page() to allocate its memory.
  But because the persistent ring buffer use vmap() it causes a kernel
  crash.  Fixing this to work with vmap() is not hard, but since mmap() on
  persistent memory buffers never worked, just have the mmap() return
  -ENODEV (what was returned before mmap() for persistent memory ring
  buffers, as they never supported mmap. Normal buffers will still allow
  mmap(). Implementing mmap() for persistent memory ring buffers can wait
  till the next merge window.

- Fix polling on persistent ring buffers

  There's a "buffer_percent" option (default set to 50), that is used to
  have reads of the ring buffer binary data block until the buffer fills to
  that percentage. The field "pages_touched" is incremented every time a
  new sub-buffer has content added to it. This field is used in the
  calculations to determine the amount of content is in the buffer and if it
  exceeds the "buffer_percent" then it will wake the task polling on the
  buffer.

  As persistent ring buffers can be created by the content from a previous
  boot, the "pages_touched" field was not updated. This means that if a task
  were to poll on the persistent buffer, it would block even if the buffer
  was completely full. It would block even if the "buffer_percent" was zero,
  because with "pages_touched" as zero, it would be calculated as the buffer
  having no content. Update pages_touched when initializing the persistent
  ring buffer from a previous boot.


Please pull the latest trace-ring-buffer-v6.14-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-ring-buffer-v6.14-rc2

Tag SHA1: 8fc8285409ff42935830f40e429fea5c8f691c3c
Head SHA1: 97937834ae876f29565415ab15f1284666dc6be3


Steven Rostedt (5):
      ring-buffer: Unlock resize on mmap error
      tracing: Have the error of __tracing_resize_ring_buffer() passed to user
      ring-buffer: Validate the persistent meta data subbuf array
      tracing: Do not allow mmap() of persistent ring buffer
      ring-buffer: Update pages_touched to reflect persistent buffer content

----
 kernel/trace/ring_buffer.c | 28 ++++++++++++++++++++++++++--
 kernel/trace/trace.c       | 12 +++++-------
 2 files changed, 31 insertions(+), 9 deletions(-)
---------------------------
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index b8e0ae15ca5b..bb6089c2951e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1672,7 +1672,8 @@ static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, int idx)
  * must be the same.
  */
 static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
-			  struct trace_buffer *buffer, int nr_pages)
+			  struct trace_buffer *buffer, int nr_pages,
+			  unsigned long *subbuf_mask)
 {
 	int subbuf_size = PAGE_SIZE;
 	struct buffer_data_page *subbuf;
@@ -1680,6 +1681,9 @@ static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
 	unsigned long buffers_end;
 	int i;
 
+	if (!subbuf_mask)
+		return false;
+
 	/* Check the meta magic and meta struct size */
 	if (meta->magic != RING_BUFFER_META_MAGIC ||
 	    meta->struct_size != sizeof(*meta)) {
@@ -1712,6 +1716,8 @@ static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
 
 	subbuf = rb_subbufs_from_meta(meta);
 
+	bitmap_clear(subbuf_mask, 0, meta->nr_subbufs);
+
 	/* Is the meta buffers and the subbufs themselves have correct data? */
 	for (i = 0; i < meta->nr_subbufs; i++) {
 		if (meta->buffers[i] < 0 ||
@@ -1725,6 +1731,12 @@ static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
 			return false;
 		}
 
+		if (test_bit(meta->buffers[i], subbuf_mask)) {
+			pr_info("Ring buffer boot meta [%d] array has duplicates\n", cpu);
+			return false;
+		}
+
+		set_bit(meta->buffers[i], subbuf_mask);
 		subbuf = (void *)subbuf + subbuf_size;
 	}
 
@@ -1838,6 +1850,11 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 				cpu_buffer->cpu);
 			goto invalid;
 		}
+
+		/* If the buffer has content, update pages_touched */
+		if (ret)
+			local_inc(&cpu_buffer->pages_touched);
+
 		entries += ret;
 		entry_bytes += local_read(&head_page->page->commit);
 		local_set(&cpu_buffer->head_page->entries, ret);
@@ -1889,17 +1906,22 @@ static void rb_meta_init_text_addr(struct ring_buffer_meta *meta)
 static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 {
 	struct ring_buffer_meta *meta;
+	unsigned long *subbuf_mask;
 	unsigned long delta;
 	void *subbuf;
 	int cpu;
 	int i;
 
+	/* Create a mask to test the subbuf array */
+	subbuf_mask = bitmap_alloc(nr_pages + 1, GFP_KERNEL);
+	/* If subbuf_mask fails to allocate, then rb_meta_valid() will return false */
+
 	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
 		void *next_meta;
 
 		meta = rb_range_meta(buffer, nr_pages, cpu);
 
-		if (rb_meta_valid(meta, cpu, buffer, nr_pages)) {
+		if (rb_meta_valid(meta, cpu, buffer, nr_pages, subbuf_mask)) {
 			/* Make the mappings match the current address */
 			subbuf = rb_subbufs_from_meta(meta);
 			delta = (unsigned long)subbuf - meta->first_buffer;
@@ -1943,6 +1965,7 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 			subbuf += meta->subbuf_size;
 		}
 	}
+	bitmap_free(subbuf_mask);
 }
 
 static void *rbm_start(struct seq_file *m, loff_t *pos)
@@ -7126,6 +7149,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		kfree(cpu_buffer->subbuf_ids);
 		cpu_buffer->subbuf_ids = NULL;
 		rb_free_meta_page(cpu_buffer);
+		atomic_dec(&cpu_buffer->resize_disabled);
 	}
 
 unlock:
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1496a5ac33ae..0e6d517e74e0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5977,8 +5977,6 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 				  unsigned long size, int cpu_id)
 {
-	int ret;
-
 	guard(mutex)(&trace_types_lock);
 
 	if (cpu_id != RING_BUFFER_ALL_CPUS) {
@@ -5987,11 +5985,7 @@ ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 			return -EINVAL;
 	}
 
-	ret = __tracing_resize_ring_buffer(tr, size, cpu_id);
-	if (ret < 0)
-		ret = -ENOMEM;
-
-	return ret;
+	return __tracing_resize_ring_buffer(tr, size, cpu_id);
 }
 
 static void update_last_data(struct trace_array *tr)
@@ -8285,6 +8279,10 @@ static int tracing_buffers_mmap(struct file *filp, struct vm_area_struct *vma)
 	struct trace_iterator *iter = &info->iter;
 	int ret = 0;
 
+	/* Currently the boot mapped buffer is not supported for mmap */
+	if (iter->tr->flags & TRACE_ARRAY_FL_BOOT)
+		return -ENODEV;
+
 	ret = get_snapshot_map(iter->tr);
 	if (ret)
 		return ret;

