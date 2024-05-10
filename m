Return-Path: <linux-kernel+bounces-175854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2B68C2641
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0729E284F89
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD56F12CDB5;
	Fri, 10 May 2024 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wAJBWCDO"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576EE16EBFA
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349888; cv=none; b=UyAymtf/8ipe4e0boUxTuULouttWG4JBWC51sPHSZTDUaAhOFHZq5BpgaOVEb/rNOawZjttLCs3dw4kKY4h6DKDqxM9zv9yKiPdrdf+giN48pkJo2MgWtGidT3g9f2epan39O3t8awDxbW6ZRl48mHGPzFsrEg22SUprAZdUdRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349888; c=relaxed/simple;
	bh=AN0Vt2ZM2ZZz/7kC1bS8iBWoZ7vgWH4xwVODG90axrs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KnWg1k0rAj1FVkNGcqZ2ehs6zAXdMbkuQyYYxVZQCMKVfwuVUlzuwuxjsDtnl14i2F3dABKtlOVgZBDMzQJzuk/QkVAmENkxuQTwPFUwdkhc0e9LPqRdznSq6YBisak8It/8Xn8ebgzycBDDo8OyNTvFGlBRFWrtS391lE0B/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wAJBWCDO; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-34eb54c888cso1608306f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715349885; x=1715954685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xdH9i2hDp/YKAgWhNAb4WKl19TWJjk87+LwTG599wtI=;
        b=wAJBWCDOrv9HBscmhprGmnVYI38LTsqxCTbXY1TGIRh3aw7FtaUotyfCxGd5Vaakkz
         PdSrp6ITuqzvAsioE6UfgUxLWYrynCP+yv4DMSwOtxoa185IdPwxvc472CqkMlrXXa9B
         jidOypkI30dZXivqId0I6pFt+55QmNXqww/+Kty6dCdD2VpVIqCOqOK8ralyFTHwiZuN
         DNysewXk2A4EYvrnIq8oY7kuoQhAANbKIU6d2EQT7P+P5V0qwQcb/7Ev38HT3oL3qlaH
         h63zycwkbGPoYBPcjtfvqReCsWfKYfZVHvjE0/ObdX2LX3pzzt9BOr41oWunysiT5xVS
         xCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715349885; x=1715954685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdH9i2hDp/YKAgWhNAb4WKl19TWJjk87+LwTG599wtI=;
        b=aPGyhZcEwEQI7Xz8jWFWur2FYcJbpwFmWWpzfBCzVCBQL1mVspO6LJS1nCYULx9sMu
         OX1D9SZz5rLX2fb9g9o6ooti+SsEYk/APhXV1rwm4W6hiRQryto+8E8nYQX/YQaB9PKl
         s9d0iG+ZsnZpfxWRyJYTk9BbyO0n3L0zB1UMf+rDP0F5Tz7AvYllkF2vln0EbpwStRl4
         6Q8w6ipBAt+o55a6s4B23aIz6fHakaRCtfaFmm7sieL/FneI6zUptT3gW9q+TheW0oqV
         3zLpmVKz0mro023EJXIwf5S6HlehQt/HruCEOfYsREYjRMxPnxtY8PTWRWxCCW+zBEvF
         HOWw==
X-Forwarded-Encrypted: i=1; AJvYcCXhz0lZ84vN1dW7i9xYY62z+fY7dzC8s1TXP/WUmwFOnFBzKVLML2Bt8mETzMI4rJy6zw7rXdlVpDksYVS3K2ynF6rYB8iV7zbiA/Bb
X-Gm-Message-State: AOJu0YxWKFIv+Ly0XQZT2tDyd7AGojmHapXjDbghtE+JMmsb6ZL5aOho
	X3hQTDaAdNJi1N+5x1TEakB1KD5b2x3/XLXy1pWgaKyCprscJL1PM8X1JaQ8Vgl1v57bsWlhteD
	kQs8criPJYT81y3FYTw==
X-Google-Smtp-Source: AGHT+IHQdWxjgiEqPJxHQqLTF9OtntsfUBynn+BhZmFeNsDv2xSQL4mooykwAbKkvYY8QBlqMF1qARft9DgAHHMl
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a5d:6611:0:b0:34d:2794:2c89 with SMTP
 id ffacd0b85a97d-3504a9573d3mr6432f8f.9.1715349884629; Fri, 10 May 2024
 07:04:44 -0700 (PDT)
Date: Fri, 10 May 2024 15:04:31 +0100
In-Reply-To: <20240510140435.3550353-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510140435.3550353-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510140435.3550353-3-vdonnefort@google.com>
Subject: [PATCH v23 2/5] ring-buffer: Introducing ring-buffer mapping functions
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	rdunlap@infradead.org, rppt@kernel.org, david@redhat.com, 
	Vincent Donnefort <vdonnefort@google.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

In preparation for allowing the user-space to map a ring-buffer, add
a set of mapping functions:

  ring_buffer_{map,unmap}()

And controls on the ring-buffer:

  ring_buffer_map_get_reader()  /* swap reader and head */

Mapping the ring-buffer also involves:

  A unique ID for each subbuf of the ring-buffer, currently they are
  only identified through their in-kernel VA.

  A meta-page, where are stored ring-buffer statistics and a
  description for the current reader

The linear mapping exposes the meta-page, and each subbuf of the
ring-buffer, ordered following their unique ID, assigned during the
first mapping.

Once mapped, no subbuf can get in or out of the ring-buffer: the buffer
size will remain unmodified and the splice enabling functions will in
reality simply memcpy the data instead of swapping subbufs.

CC: <linux-mm@kvack.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index dc5ae4e96aee..96d2140b471e 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -6,6 +6,8 @@
 #include <linux/seq_file.h>
 #include <linux/poll.h>
 
+#include <uapi/linux/trace_mmap.h>
+
 struct trace_buffer;
 struct ring_buffer_iter;
 
@@ -223,4 +225,8 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
 #define trace_rb_cpu_prepare	NULL
 #endif
 
+int ring_buffer_map(struct trace_buffer *buffer, int cpu,
+		    struct vm_area_struct *vma);
+int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
+int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu);
 #endif /* _LINUX_RING_BUFFER_H */
diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
new file mode 100644
index 000000000000..b682e9925539
--- /dev/null
+++ b/include/uapi/linux/trace_mmap.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _TRACE_MMAP_H_
+#define _TRACE_MMAP_H_
+
+#include <linux/types.h>
+
+/**
+ * struct trace_buffer_meta - Ring-buffer Meta-page description
+ * @meta_page_size:	Size of this meta-page.
+ * @meta_struct_len:	Size of this structure.
+ * @subbuf_size:	Size of each sub-buffer.
+ * @nr_subbufs:		Number of subbfs in the ring-buffer, including the reader.
+ * @reader.lost_events:	Number of events lost at the time of the reader swap.
+ * @reader.id:		subbuf ID of the current reader. ID range [0 : @nr_subbufs - 1]
+ * @reader.read:	Number of bytes read on the reader subbuf.
+ * @flags:		Placeholder for now, 0 until new features are supported.
+ * @entries:		Number of entries in the ring-buffer.
+ * @overrun:		Number of entries lost in the ring-buffer.
+ * @read:		Number of entries that have been read.
+ * @Reserved1:		Internal use only.
+ * @Reserved2:		Internal use only.
+ */
+struct trace_buffer_meta {
+	__u32		meta_page_size;
+	__u32		meta_struct_len;
+
+	__u32		subbuf_size;
+	__u32		nr_subbufs;
+
+	struct {
+		__u64	lost_events;
+		__u32	id;
+		__u32	read;
+	} reader;
+
+	__u64	flags;
+
+	__u64	entries;
+	__u64	overrun;
+	__u64	read;
+
+	__u64	Reserved1;
+	__u64	Reserved2;
+};
+
+#endif /* _TRACE_MMAP_H_ */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index cc9ebe593571..849f6942bb96 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -9,6 +9,7 @@
 #include <linux/ring_buffer.h>
 #include <linux/trace_clock.h>
 #include <linux/sched/clock.h>
+#include <linux/cacheflush.h>
 #include <linux/trace_seq.h>
 #include <linux/spinlock.h>
 #include <linux/irq_work.h>
@@ -26,6 +27,7 @@
 #include <linux/list.h>
 #include <linux/cpu.h>
 #include <linux/oom.h>
+#include <linux/mm.h>
 
 #include <asm/local64.h>
 #include <asm/local.h>
@@ -338,6 +340,7 @@ struct buffer_page {
 	local_t		 entries;	/* entries on this page */
 	unsigned long	 real_end;	/* real end of data */
 	unsigned	 order;		/* order of the page */
+	u32		 id;		/* ID for external mapping */
 	struct buffer_data_page *page;	/* Actual data page */
 };
 
@@ -484,6 +487,12 @@ struct ring_buffer_per_cpu {
 	u64				read_stamp;
 	/* pages removed since last reset */
 	unsigned long			pages_removed;
+
+	unsigned int			mapped;
+	struct mutex			mapping_lock;
+	unsigned long			*subbuf_ids;	/* ID to subbuf VA */
+	struct trace_buffer_meta	*meta_page;
+
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
@@ -1599,6 +1608,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	init_irq_work(&cpu_buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
+	mutex_init(&cpu_buffer->mapping_lock);
 
 	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
 			    GFP_KERNEL, cpu_to_node(cpu));
@@ -1789,8 +1799,6 @@ bool ring_buffer_time_stamp_abs(struct trace_buffer *buffer)
 	return buffer->time_stamp_abs;
 }
 
-static void rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer);
-
 static inline unsigned long rb_page_entries(struct buffer_page *bpage)
 {
 	return local_read(&bpage->entries) & RB_WRITE_MASK;
@@ -5211,6 +5219,22 @@ static void rb_clear_buffer_page(struct buffer_page *page)
 	page->read = 0;
 }
 
+static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
+
+	meta->reader.read = cpu_buffer->reader_page->read;
+	meta->reader.id = cpu_buffer->reader_page->id;
+	meta->reader.lost_events = cpu_buffer->lost_events;
+
+	meta->entries = local_read(&cpu_buffer->entries);
+	meta->overrun = local_read(&cpu_buffer->overrun);
+	meta->read = cpu_buffer->read;
+
+	/* Some archs do not have data cache coherency between kernel and user-space */
+	flush_dcache_folio(virt_to_folio(cpu_buffer->meta_page));
+}
+
 static void
 rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 {
@@ -5255,6 +5279,9 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->lost_events = 0;
 	cpu_buffer->last_overrun = 0;
 
+	if (cpu_buffer->mapped)
+		rb_update_meta_page(cpu_buffer);
+
 	rb_head_page_activate(cpu_buffer);
 	cpu_buffer->pages_removed = 0;
 }
@@ -5469,6 +5496,12 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 	cpu_buffer_a = buffer_a->buffers[cpu];
 	cpu_buffer_b = buffer_b->buffers[cpu];
 
+	/* It's up to the callers to not try to swap mapped buffers */
+	if (WARN_ON_ONCE(cpu_buffer_a->mapped || cpu_buffer_b->mapped)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	/* At least make sure the two buffers are somewhat the same */
 	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
 		goto out;
@@ -5733,7 +5766,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	 * Otherwise, we can simply swap the page with the one passed in.
 	 */
 	if (read || (len < (commit - read)) ||
-	    cpu_buffer->reader_page == cpu_buffer->commit_page) {
+	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
+	    cpu_buffer->mapped) {
 		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
 		unsigned int rpos = read;
 		unsigned int pos = 0;
@@ -5956,6 +5990,11 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 		cpu_buffer = buffer->buffers[cpu];
 
+		if (cpu_buffer->mapped) {
+			err = -EBUSY;
+			goto error;
+		}
+
 		/* Update the number of pages to match the new size */
 		nr_pages = old_size * buffer->buffers[cpu]->nr_pages;
 		nr_pages = DIV_ROUND_UP(nr_pages, buffer->subbuf_size);
@@ -6057,6 +6096,375 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_set);
 
+static int rb_alloc_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	struct page *page;
+
+	if (cpu_buffer->meta_page)
+		return 0;
+
+	page = alloc_page(GFP_USER | __GFP_ZERO);
+	if (!page)
+		return -ENOMEM;
+
+	cpu_buffer->meta_page = page_to_virt(page);
+
+	return 0;
+}
+
+static void rb_free_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	unsigned long addr = (unsigned long)cpu_buffer->meta_page;
+
+	free_page(addr);
+	cpu_buffer->meta_page = NULL;
+}
+
+static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
+				   unsigned long *subbuf_ids)
+{
+	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
+	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
+	struct buffer_page *first_subbuf, *subbuf;
+	int id = 0;
+
+	subbuf_ids[id] = (unsigned long)cpu_buffer->reader_page->page;
+	cpu_buffer->reader_page->id = id++;
+
+	first_subbuf = subbuf = rb_set_head_page(cpu_buffer);
+	do {
+		if (WARN_ON(id >= nr_subbufs))
+			break;
+
+		subbuf_ids[id] = (unsigned long)subbuf->page;
+		subbuf->id = id;
+
+		rb_inc_page(&subbuf);
+		id++;
+	} while (subbuf != first_subbuf);
+
+	/* install subbuf ID to kern VA translation */
+	cpu_buffer->subbuf_ids = subbuf_ids;
+
+	meta->meta_page_size = PAGE_SIZE;
+	meta->meta_struct_len = sizeof(*meta);
+	meta->nr_subbufs = nr_subbufs;
+	meta->subbuf_size = cpu_buffer->buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
+
+	rb_update_meta_page(cpu_buffer);
+}
+
+static struct ring_buffer_per_cpu *
+rb_get_mapped_buffer(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return ERR_PTR(-EINVAL);
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	mutex_lock(&cpu_buffer->mapping_lock);
+
+	if (!cpu_buffer->mapped) {
+		mutex_unlock(&cpu_buffer->mapping_lock);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return cpu_buffer;
+}
+
+static void rb_put_mapped_buffer(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	mutex_unlock(&cpu_buffer->mapping_lock);
+}
+
+/*
+ * Fast-path for rb_buffer_(un)map(). Called whenever the meta-page doesn't need
+ * to be set-up or torn-down.
+ */
+static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
+			       bool inc)
+{
+	unsigned long flags;
+
+	lockdep_assert_held(&cpu_buffer->mapping_lock);
+
+	if (inc && cpu_buffer->mapped == UINT_MAX)
+		return -EBUSY;
+
+	if (WARN_ON(!inc && cpu_buffer->mapped == 0))
+		return -EINVAL;
+
+	mutex_lock(&cpu_buffer->buffer->mutex);
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+
+	if (inc)
+		cpu_buffer->mapped++;
+	else
+		cpu_buffer->mapped--;
+
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	mutex_unlock(&cpu_buffer->buffer->mutex);
+
+	return 0;
+}
+
+/*
+ *   +--------------+  pgoff == 0
+ *   |   meta page  |
+ *   +--------------+  pgoff == 1
+ *   | subbuffer 0  |
+ *   |              |
+ *   +--------------+  pgoff == (1 + (1 << subbuf_order))
+ *   | subbuffer 1  |
+ *   |              |
+ *         ...
+ */
+#ifdef CONFIG_MMU
+static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
+			struct vm_area_struct *vma)
+{
+	unsigned long nr_subbufs, nr_pages, vma_pages, pgoff = vma->vm_pgoff;
+	unsigned int subbuf_pages, subbuf_order;
+	struct page **pages;
+	int p = 0, s = 0;
+	int err;
+
+	/* Refuse MP_PRIVATE or writable mappings */
+	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
+	    !(vma->vm_flags & VM_MAYSHARE))
+		return -EPERM;
+
+	/*
+	 * Make sure the mapping cannot become writable later. Also tell the VM
+	 * to not touch these pages (VM_DONTCOPY | VM_DONTEXPAND).
+	 */
+	vm_flags_mod(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP,
+		     VM_MAYWRITE);
+
+	lockdep_assert_held(&cpu_buffer->mapping_lock);
+
+	subbuf_order = cpu_buffer->buffer->subbuf_order;
+	subbuf_pages = 1 << subbuf_order;
+
+	nr_subbufs = cpu_buffer->nr_pages + 1; /* + reader-subbuf */
+	nr_pages = ((nr_subbufs) << subbuf_order) - pgoff + 1; /* + meta-page */
+
+	vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	if (!vma_pages || vma_pages > nr_pages)
+		return -EINVAL;
+
+	nr_pages = vma_pages;
+
+	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	if (!pgoff) {
+		pages[p++] = virt_to_page(cpu_buffer->meta_page);
+
+		/*
+		 * TODO: Align sub-buffers on their size, once
+		 * vm_insert_pages() supports the zero-page.
+		 */
+	} else {
+		/* Skip the meta-page */
+		pgoff--;
+
+		if (pgoff % subbuf_pages) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		s += pgoff / subbuf_pages;
+	}
+
+	while (p < nr_pages) {
+		struct page *page = virt_to_page(cpu_buffer->subbuf_ids[s]);
+		int off = 0;
+
+		if (WARN_ON_ONCE(s >= nr_subbufs)) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		for (; off < (1 << (subbuf_order)); off++, page++) {
+			if (p >= nr_pages)
+				break;
+
+			pages[p++] = page;
+		}
+		s++;
+	}
+
+	err = vm_insert_pages(vma, vma->vm_start, pages, &nr_pages);
+
+out:
+	kfree(pages);
+
+	return err;
+}
+#else
+static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
+			struct vm_area_struct *vma)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+int ring_buffer_map(struct trace_buffer *buffer, int cpu,
+		    struct vm_area_struct *vma)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	unsigned long flags, *subbuf_ids;
+	int err = 0;
+
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return -EINVAL;
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	mutex_lock(&cpu_buffer->mapping_lock);
+
+	if (cpu_buffer->mapped) {
+		err = __rb_map_vma(cpu_buffer, vma);
+		if (!err)
+			err = __rb_inc_dec_mapped(cpu_buffer, true);
+		mutex_unlock(&cpu_buffer->mapping_lock);
+		return err;
+	}
+
+	/* prevent another thread from changing buffer/sub-buffer sizes */
+	mutex_lock(&buffer->mutex);
+
+	err = rb_alloc_meta_page(cpu_buffer);
+	if (err)
+		goto unlock;
+
+	/* subbuf_ids include the reader while nr_pages does not */
+	subbuf_ids = kcalloc(cpu_buffer->nr_pages + 1, sizeof(*subbuf_ids), GFP_KERNEL);
+	if (!subbuf_ids) {
+		rb_free_meta_page(cpu_buffer);
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	atomic_inc(&cpu_buffer->resize_disabled);
+
+	/*
+	 * Lock all readers to block any subbuf swap until the subbuf IDs are
+	 * assigned.
+	 */
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+	rb_setup_ids_meta_page(cpu_buffer, subbuf_ids);
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+
+	err = __rb_map_vma(cpu_buffer, vma);
+	if (!err) {
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+		cpu_buffer->mapped = 1;
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	} else {
+		kfree(cpu_buffer->subbuf_ids);
+		cpu_buffer->subbuf_ids = NULL;
+		rb_free_meta_page(cpu_buffer);
+	}
+
+unlock:
+	mutex_unlock(&buffer->mutex);
+	mutex_unlock(&cpu_buffer->mapping_lock);
+
+	return err;
+}
+
+int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	unsigned long flags;
+	int err = 0;
+
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return -EINVAL;
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	mutex_lock(&cpu_buffer->mapping_lock);
+
+	if (!cpu_buffer->mapped) {
+		err = -ENODEV;
+		goto out;
+	} else if (cpu_buffer->mapped > 1) {
+		__rb_inc_dec_mapped(cpu_buffer, false);
+		goto out;
+	}
+
+	mutex_lock(&buffer->mutex);
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+
+	cpu_buffer->mapped = 0;
+
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+
+	kfree(cpu_buffer->subbuf_ids);
+	cpu_buffer->subbuf_ids = NULL;
+	rb_free_meta_page(cpu_buffer);
+	atomic_dec(&cpu_buffer->resize_disabled);
+
+	mutex_unlock(&buffer->mutex);
+
+out:
+	mutex_unlock(&cpu_buffer->mapping_lock);
+
+	return err;
+}
+
+int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	unsigned long reader_size;
+	unsigned long flags;
+
+	cpu_buffer = rb_get_mapped_buffer(buffer, cpu);
+	if (IS_ERR(cpu_buffer))
+		return (int)PTR_ERR(cpu_buffer);
+
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+
+consume:
+	if (rb_per_cpu_empty(cpu_buffer))
+		goto out;
+
+	reader_size = rb_page_size(cpu_buffer->reader_page);
+
+	/*
+	 * There are data to be read on the current reader page, we can
+	 * return to the caller. But before that, we assume the latter will read
+	 * everything. Let's update the kernel reader accordingly.
+	 */
+	if (cpu_buffer->reader_page->read < reader_size) {
+		while (cpu_buffer->reader_page->read < reader_size)
+			rb_advance_reader(cpu_buffer);
+		goto out;
+	}
+
+	if (WARN_ON(!rb_get_reader_page(cpu_buffer)))
+		goto out;
+
+	goto consume;
+
+out:
+	/* Some archs do not have data cache coherency between kernel and user-space */
+	flush_dcache_folio(virt_to_folio(cpu_buffer->reader_page->page));
+
+	rb_update_meta_page(cpu_buffer);
+
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	rb_put_mapped_buffer(cpu_buffer);
+
+	return 0;
+}
+
 /*
  * We only allocate new buffers, never free them if the CPU goes down.
  * If we were to free the buffer, then the user would lose any trace that was in
-- 
2.45.0.118.g7fe29c98d7-goog


