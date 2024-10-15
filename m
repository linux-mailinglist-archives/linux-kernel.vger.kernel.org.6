Return-Path: <linux-kernel+bounces-366131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 555B199F138
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35CC1F239FC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2779F1DD0EB;
	Tue, 15 Oct 2024 15:31:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A4B1D8A12
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006266; cv=none; b=qnUh/eR94NuvgnbT84fAveDOIE4dXucAnjycCfJQWZKT5OrqbDhq5vyDZgTiA7IyL22ooGQetCQaT6ik3vA4p2gcM4ZS1GiMZYdq0WlKGkke5k3BotQRM0nNq4EeTXIv/zcky7LwzPHHjmUSJ8uEUUTyN9l2UIluNEnDn1R6QfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006266; c=relaxed/simple;
	bh=SzgDNqXDB3VwKZFe2irsr0kmfNOEzg1eE1sTlNR1tbc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MCmhNQ4Yccfn23VkUbz9RvUUVfS9AD8skVJJodr5JGVCENI7OZo4VG/1MZcSEKF3vbcB3iRBluna8STpIzawS6TV0pBRuUz12ytSmSmFKVHl2C3LhG4nPvt5mX1wm5y3avGXk8kZ0t643pbBqIX/7GxHbGTxtvZhuOpg0/7brzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EE1C4CED0;
	Tue, 15 Oct 2024 15:31:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t0jW9-00000002z5N-3JiT;
	Tue, 15 Oct 2024 11:31:25 -0400
Message-ID: <20241015153125.652461107@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 15 Oct 2024 11:31:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Petr Pavlu <petr.pavlu@suse.com>
Subject: [for-next][PATCH 2/2] ring-buffer: Fix reader locking when changing the sub buffer order
References: <20241015153105.843619901@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Petr Pavlu <petr.pavlu@suse.com>

The function ring_buffer_subbuf_order_set() updates each
ring_buffer_per_cpu and installs new sub buffers that match the requested
page order. This operation may be invoked concurrently with readers that
rely on some of the modified data, such as the head bit (RB_PAGE_HEAD), or
the ring_buffer_per_cpu.pages and reader_page pointers. However, no
exclusive access is acquired by ring_buffer_subbuf_order_set(). Modifying
the mentioned data while a reader also operates on them can then result in
incorrect memory access and various crashes.

Fix the problem by taking the reader_lock when updating a specific
ring_buffer_per_cpu in ring_buffer_subbuf_order_set().

Link: https://lore.kernel.org/linux-trace-kernel/20240715145141.5528-1-petr.pavlu@suse.com/
Link: https://lore.kernel.org/linux-trace-kernel/20241010195849.2f77cc3f@gandalf.local.home/
Link: https://lore.kernel.org/linux-trace-kernel/20241011112850.17212b25@gandalf.local.home/

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20241015112440.26987-1-petr.pavlu@suse.com
Fixes: 8e7b58c27b3c ("ring-buffer: Just update the subbuffers when changing their allocation order")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 44 ++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

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
 
-- 
2.45.2



