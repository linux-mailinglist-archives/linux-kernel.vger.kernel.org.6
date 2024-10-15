Return-Path: <linux-kernel+bounces-366171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C9699F195
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21301C237A8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BCA1E7C35;
	Tue, 15 Oct 2024 15:37:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747BE1F6667
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006653; cv=none; b=WeKALkfkRVOxwpm2wh7Y8j63+n0zNx5gOs+sTmqdCeVVZGLZwO5jLzMx53TTttx+/0ddn33U69KkqPrdcp821WoY5uzDRadPPWYDWTE6mh6O5+hvRYorO3N22cCCngGN8AOH+vjlhwqiwIuFwr6JF2w/YTTfcDUUNhimzCRVYuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006653; c=relaxed/simple;
	bh=rB75Kb5i9n13uptgYuUcYrN5JJj+UVcy6RoGq3DtHEk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HkqLBGdduwRaGD+MGZREqJpNwtNNWPSstkf+2/XIornjxQYh9lh0yhzK5MhHVdCct969DvWPRs6TEdSGV52B1kdTDRe+wy+tJcbJP6bZ0NNQwXDV7xgvNguLtRU3fDGSO6Zc3lBnk4a4gz8DHhemtRwlPgmCIqTsQ1ZbI7omol8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6142DC4CECD;
	Tue, 15 Oct 2024 15:37:32 +0000 (UTC)
Date: Tue, 15 Oct 2024 11:37:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Petr Pavlu <petr.pavlu@suse.com>
Subject: [GIT PULL] ring-buffer: A couple of fixes for 6.12
Message-ID: <20241015113751.7cb18c09@gandalf.local.home>
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

ring-buffer: Fixes for v6.12

- Fix ref counter of buffers assigned at boot up

  A tracing instance can be created from the kernel command line.
  If it maps to memory, it is considered permanent and should not
  be deleted, or bad things can happen. If it is not mapped to memory,
  then the user is fine to delete it via rmdir from the instances
  directory. But the ref counts assumed 0 was free to remove and
  greater than zero was not. But this was not the case. When an
  instance is created, it should have the reference of 1, and if
  it should not be removed, it must be greater than 1. The boot up
  code set normal instances with a ref count of 0, which could get
  removed if something accessed it and then released it. And memory
  mapped instances had a ref count of 1 which meant it could be deleted,
  and bad things happen. Keep normal instances ref count as 1, and
  set memory mapped instances ref count to 2.

- Protect sub buffer size (order) updates from other modifications

  When a ring buffer is changing the size of its sub-buffers, no other
  operations should be performed on the ring buffer. That includes
  reading it. But the locking only grabbed the buffer->mutex that
  keeps some operations from touching the ring buffer. It also must
  hold the cpu_buffer->reader_lock as well when updates happen as
  other paths use that to do some operations on the ring buffer.


Please pull the latest trace-ringbuffer-v6.12-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-ringbuffer-v6.12-rc3

Tag SHA1: fcddf5b97582ef8d7ed526585880a14d8239d5ae
Head SHA1: 09661f75e75cb6c1d2d8326a70c311d46729235f


Petr Pavlu (1):
      ring-buffer: Fix reader locking when changing the sub buffer order

Steven Rostedt (1):
      ring-buffer: Fix refcount setting of boot mapped buffers

----
 kernel/trace/ring_buffer.c | 44 ++++++++++++++++++++++++++------------------
 kernel/trace/trace.c       |  6 +++---
 2 files changed, 29 insertions(+), 21 deletions(-)
---------------------------
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index fb04445f92c3..3ea4f7bb1837 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6728,39 +6728,38 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	}
 
 	for_each_buffer_cpu(buffer, cpu) {
+		struct buffer_data_page *old_free_data_page;
+		struct list_head old_pages;
+		unsigned long flags;
 
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
 			continue;
 
 		cpu_buffer = buffer->buffers[cpu];
 
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+
 		/* Clear the head bit to make the link list normal to read */
 		rb_head_page_deactivate(cpu_buffer);
 
-		/* Now walk the list and free all the old sub buffers */
-		list_for_each_entry_safe(bpage, tmp, cpu_buffer->pages, list) {
-			list_del_init(&bpage->list);
-			free_buffer_page(bpage);
-		}
-		/* The above loop stopped an the last page needing to be freed */
-		bpage = list_entry(cpu_buffer->pages, struct buffer_page, list);
-		free_buffer_page(bpage);
-
-		/* Free the current reader page */
-		free_buffer_page(cpu_buffer->reader_page);
+		/*
+		 * Collect buffers from the cpu_buffer pages list and the
+		 * reader_page on old_pages, so they can be freed later when not
+		 * under a spinlock. The pages list is a linked list with no
+		 * head, adding old_pages turns it into a regular list with
+		 * old_pages being the head.
+		 */
+		list_add(&old_pages, cpu_buffer->pages);
+		list_add(&cpu_buffer->reader_page->list, &old_pages);
 
 		/* One page was allocated for the reader page */
 		cpu_buffer->reader_page = list_entry(cpu_buffer->new_pages.next,
 						     struct buffer_page, list);
 		list_del_init(&cpu_buffer->reader_page->list);
 
-		/* The cpu_buffer pages are a link list with no head */
+		/* Install the new pages, remove the head from the list */
 		cpu_buffer->pages = cpu_buffer->new_pages.next;
-		cpu_buffer->new_pages.next->prev = cpu_buffer->new_pages.prev;
-		cpu_buffer->new_pages.prev->next = cpu_buffer->new_pages.next;
-
-		/* Clear the new_pages list */
-		INIT_LIST_HEAD(&cpu_buffer->new_pages);
+		list_del_init(&cpu_buffer->new_pages);
 
 		cpu_buffer->head_page
 			= list_entry(cpu_buffer->pages, struct buffer_page, list);
@@ -6769,11 +6768,20 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		cpu_buffer->nr_pages = cpu_buffer->nr_pages_to_update;
 		cpu_buffer->nr_pages_to_update = 0;
 
-		free_pages((unsigned long)cpu_buffer->free_page, old_order);
+		old_free_data_page = cpu_buffer->free_page;
 		cpu_buffer->free_page = NULL;
 
 		rb_head_page_activate(cpu_buffer);
 
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+
+		/* Free old sub buffers */
+		list_for_each_entry_safe(bpage, tmp, &old_pages, list) {
+			list_del_init(&bpage->list);
+			free_buffer_page(bpage);
+		}
+		free_pages((unsigned long)old_free_data_page, old_order);
+
 		rb_check_pages(cpu_buffer);
 	}
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1c69ca1f1088..a8f52b6527ca 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10621,10 +10621,10 @@ __init static void enable_instances(void)
 		 * cannot be deleted by user space, so keep the reference
 		 * to it.
 		 */
-		if (start)
+		if (start) {
 			tr->flags |= TRACE_ARRAY_FL_BOOT;
-		else
-			trace_array_put(tr);
+			tr->ref++;
+		}
 
 		while ((tok = strsep(&curr_str, ","))) {
 			early_enable_events(tr, tok, true);

