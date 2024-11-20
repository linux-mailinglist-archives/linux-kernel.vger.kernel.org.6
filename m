Return-Path: <linux-kernel+bounces-416320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D419D433E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEF60B25E76
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7943185920;
	Wed, 20 Nov 2024 20:47:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528CC487A7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732135679; cv=none; b=Pa3HsqCWyfl5bpGnvh0agveNssBS+3TQ6GqXgKTycFx/sqn6LYoWoxXzP3sO32momgGxuGg0wUwkl1xr4+AiC8ByL/rT3ktBHpuCgPDuc2VtZCkHscs4qZuIqiPhVrzELZTS3WCefjoV/fGghgPaA3qsCz2dlxP+gv45aSaV2TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732135679; c=relaxed/simple;
	bh=15nfMlUHCxOniaNA/Q6orvofTHfumVXyZG+JbyeWwqg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=aIOLtaJAIeZ1pKYRrD+K6myVZ+BoSSfEDoGQkTLexkLhBJUTwyfEdG+eQlGmlIN0VSCzx3WSpYvosV+j+IqgLMSAFm4ZTfec69dbscJhwPHnwxxtFKlJQxSde48OAfdDk23tTgcTvaOQ2k9nG2VTyJSUeSULXK3kWvGrkSJ9xxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2C9C4CECD;
	Wed, 20 Nov 2024 20:47:57 +0000 (UTC)
Date: Wed, 20 Nov 2024 15:48:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Petr Pavlu <petr.pavlu@suse.com>,
 Thorsten Blum <thorsten.blum@linux.dev>, liujing
 <liujing@cmss.chinamobile.com>
Subject: [GIT PULL] ring-buffer: Updates for 6.13
Message-ID: <20241120154833.4f6a9c4b@gandalf.local.home>
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

trace ring-buffer updates for v6.13

- Limit the time interrupts are disabled in rb_check_pages()

  The rb_check_pages() is called after the ring buffer size is updated to
  make sure that the ring buffer has not been corrupted. Commit
  c2274b908db05 ("ring-buffer: Fix a race between readers and resize
  checks") fixed a race with the check pages and simultaneous resizes to the
  ring buffer by adding a raw_spin_lock_irqsave() around the check
  operation. Although this was a simple fix, it would hold interrupts
  disabled for non determinative amount of time. This could harm PREEMPT_RT
  operations.

  Instead, modify the logic by adding a counter when the buffer is modified
  and to release the raw_spin_lock() at each iteration. It checks the
  counter under the lock to see if a modification happened during the loop,
  and if it did, it would restart the loop up to 3 times. After 3 times, it
  will simply exit the check, as it is unlikely that would ever happen as
  buffer resizes are rare occurrences.

- Replace some open coded str_low_high() with the helper

- Fix some documentation/comments


Please pull the latest trace-ring-buffer-v6.13 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-ring-buffer-v6.13

Tag SHA1: 787da17c39b4daa2c77c98a0a2821f68a030022a
Head SHA1: 537affea1672a841cd5b87b208c193a3a542c7cf


Julia Lawall (1):
      ring-buffer: Reorganize kerneldoc parameter names

Petr Pavlu (1):
      ring-buffer: Limit time with disabled interrupts in rb_check_pages()

Thorsten Blum (1):
      ring-buffer: Use str_low_high() helper in ring_buffer_producer()

liujing (1):
      ring-buffer: Correct a grammatical error in a comment

----
 kernel/trace/ring_buffer.c           | 102 +++++++++++++++++++++++++----------
 kernel/trace/ring_buffer_benchmark.c |   4 +-
 2 files changed, 76 insertions(+), 30 deletions(-)
---------------------------
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 3ea4f7bb1837..d6100a7da483 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -482,6 +482,8 @@ struct ring_buffer_per_cpu {
 	unsigned long			nr_pages;
 	unsigned int			current_context;
 	struct list_head		*pages;
+	/* pages generation counter, incremented when the list changes */
+	unsigned long			cnt;
 	struct buffer_page		*head_page;	/* read from head */
 	struct buffer_page		*tail_page;	/* write to tail */
 	struct buffer_page		*commit_page;	/* committed pages */
@@ -1475,40 +1477,87 @@ static void rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
 	RB_WARN_ON(cpu_buffer, val & RB_FLAG_MASK);
 }
 
+static bool rb_check_links(struct ring_buffer_per_cpu *cpu_buffer,
+			   struct list_head *list)
+{
+	if (RB_WARN_ON(cpu_buffer,
+		       rb_list_head(rb_list_head(list->next)->prev) != list))
+		return false;
+
+	if (RB_WARN_ON(cpu_buffer,
+		       rb_list_head(rb_list_head(list->prev)->next) != list))
+		return false;
+
+	return true;
+}
+
 /**
  * rb_check_pages - integrity check of buffer pages
  * @cpu_buffer: CPU buffer with pages to test
  *
  * As a safety measure we check to make sure the data pages have not
  * been corrupted.
- *
- * Callers of this function need to guarantee that the list of pages doesn't get
- * modified during the check. In particular, if it's possible that the function
- * is invoked with concurrent readers which can swap in a new reader page then
- * the caller should take cpu_buffer->reader_lock.
  */
 static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	struct list_head *head = rb_list_head(cpu_buffer->pages);
-	struct list_head *tmp;
+	struct list_head *head, *tmp;
+	unsigned long buffer_cnt;
+	unsigned long flags;
+	int nr_loops = 0;
 
-	if (RB_WARN_ON(cpu_buffer,
-			rb_list_head(rb_list_head(head->next)->prev) != head))
+	/*
+	 * Walk the linked list underpinning the ring buffer and validate all
+	 * its next and prev links.
+	 *
+	 * The check acquires the reader_lock to avoid concurrent processing
+	 * with code that could be modifying the list. However, the lock cannot
+	 * be held for the entire duration of the walk, as this would make the
+	 * time when interrupts are disabled non-deterministic, dependent on the
+	 * ring buffer size. Therefore, the code releases and re-acquires the
+	 * lock after checking each page. The ring_buffer_per_cpu.cnt variable
+	 * is then used to detect if the list was modified while the lock was
+	 * not held, in which case the check needs to be restarted.
+	 *
+	 * The code attempts to perform the check at most three times before
+	 * giving up. This is acceptable because this is only a self-validation
+	 * to detect problems early on. In practice, the list modification
+	 * operations are fairly spaced, and so this check typically succeeds at
+	 * most on the second try.
+	 */
+again:
+	if (++nr_loops > 3)
 		return;
 
-	if (RB_WARN_ON(cpu_buffer,
-			rb_list_head(rb_list_head(head->prev)->next) != head))
-		return;
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+	head = rb_list_head(cpu_buffer->pages);
+	if (!rb_check_links(cpu_buffer, head))
+		goto out_locked;
+	buffer_cnt = cpu_buffer->cnt;
+	tmp = head;
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
-	for (tmp = rb_list_head(head->next); tmp != head; tmp = rb_list_head(tmp->next)) {
-		if (RB_WARN_ON(cpu_buffer,
-				rb_list_head(rb_list_head(tmp->next)->prev) != tmp))
-			return;
+	while (true) {
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 
-		if (RB_WARN_ON(cpu_buffer,
-				rb_list_head(rb_list_head(tmp->prev)->next) != tmp))
-			return;
+		if (buffer_cnt != cpu_buffer->cnt) {
+			/* The list was updated, try again. */
+			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+			goto again;
+		}
+
+		tmp = rb_list_head(tmp->next);
+		if (tmp == head)
+			/* The iteration circled back, all is done. */
+			goto out_locked;
+
+		if (!rb_check_links(cpu_buffer, tmp))
+			goto out_locked;
+
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 	}
+
+out_locked:
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 }
 
 /*
@@ -2387,9 +2436,9 @@ EXPORT_SYMBOL_GPL(__ring_buffer_alloc);
  * __ring_buffer_alloc_range - allocate a new ring_buffer from existing memory
  * @size: the size in bytes per cpu that is needed.
  * @flags: attributes to set for the ring buffer.
+ * @order: sub-buffer order
  * @start: start of allocated range
  * @range_size: size of allocated range
- * @order: sub-buffer order
  * @key: ring buffer reader_lock_key.
  *
  * Currently the only flag that is available is the RB_FL_OVERWRITE
@@ -2535,6 +2584,7 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 
 	/* make sure pages points to a valid page in the ring buffer */
 	cpu_buffer->pages = next_page;
+	cpu_buffer->cnt++;
 
 	/* update head page */
 	if (head_bit)
@@ -2641,6 +2691,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 			 * pointer to point to end of list
 			 */
 			head_page->prev = last_page;
+			cpu_buffer->cnt++;
 			success = true;
 			break;
 		}
@@ -2876,12 +2927,8 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		 */
 		synchronize_rcu();
 		for_each_buffer_cpu(buffer, cpu) {
-			unsigned long flags;
-
 			cpu_buffer = buffer->buffers[cpu];
-			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 			rb_check_pages(cpu_buffer);
-			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 		}
 		atomic_dec(&buffer->record_disabled);
 	}
@@ -4013,7 +4060,7 @@ static const char *show_irq_str(int bits)
 	return type[bits];
 }
 
-/* Assume this is an trace event */
+/* Assume this is a trace event */
 static const char *show_flags(struct ring_buffer_event *event)
 {
 	struct trace_entry *entry;
@@ -5299,6 +5346,7 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	rb_list_head(reader->list.next)->prev = &cpu_buffer->reader_page->list;
 	rb_inc_page(&cpu_buffer->head_page);
 
+	cpu_buffer->cnt++;
 	local_inc(&cpu_buffer->pages_read);
 
 	/* Finally update the reader page to the new head */
@@ -5838,12 +5886,9 @@ void
 ring_buffer_read_finish(struct ring_buffer_iter *iter)
 {
 	struct ring_buffer_per_cpu *cpu_buffer = iter->cpu_buffer;
-	unsigned long flags;
 
 	/* Use this opportunity to check the integrity of the ring buffer. */
-	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 	rb_check_pages(cpu_buffer);
-	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
 	atomic_dec(&cpu_buffer->resize_disabled);
 	kfree(iter->event);
@@ -6760,6 +6805,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		/* Install the new pages, remove the head from the list */
 		cpu_buffer->pages = cpu_buffer->new_pages.next;
 		list_del_init(&cpu_buffer->new_pages);
+		cpu_buffer->cnt++;
 
 		cpu_buffer->head_page
 			= list_entry(cpu_buffer->pages, struct buffer_page, list);
diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index 008187ebd7fe..cdc3aea12c93 100644
--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -307,14 +307,14 @@ static void ring_buffer_producer(void)
 	if (!disable_reader) {
 		if (consumer_fifo)
 			trace_printk("Running Consumer at SCHED_FIFO %s\n",
-				     consumer_fifo == 1 ? "low" : "high");
+				     str_low_high(consumer_fifo == 1));
 		else
 			trace_printk("Running Consumer at nice: %d\n",
 				     consumer_nice);
 	}
 	if (producer_fifo)
 		trace_printk("Running Producer at SCHED_FIFO %s\n",
-			     producer_fifo == 1 ? "low" : "high");
+			     str_low_high(producer_fifo == 1));
 	else
 		trace_printk("Running Producer at nice: %d\n",
 			     producer_nice);

