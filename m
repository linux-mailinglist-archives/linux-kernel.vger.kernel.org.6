Return-Path: <linux-kernel+bounces-239018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF879254F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BBAF1C2271F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19BC1384B1;
	Wed,  3 Jul 2024 07:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GcdDQjZy"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CA23D0A9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719993227; cv=none; b=O4Iz2deuTOQ+3WXz2LvwTalodlrUoRjOstNxlj6ayH2E4m+u1UluK9pITs9g+Y6QUtoZZTICY9CjFckLVAuS118ua95mkMJvOyeY/6nf1nxxvplday9z5eO+Bj1eJyLdUwuNyE93PzMwaQ1BYGgpZfLD3QIs+KHCHDNsx5tQsos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719993227; c=relaxed/simple;
	bh=Du+hbtiVe0vXnZWfZdgrHmmTfF2kGLcwXBrD2Oxxgjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=trSiPWyiFfQjW9UH6EeWu/zOrt91KdGA1uLrYybt46vSQXlsCZcjXYno6W6Su3yHkl0vO53JmRdr/rMQ7EQsd7MrtBlnEEDo+W9ra8CNfvLCACMSLvuBz9ko3vlyXr36Ky44Tb1LRBFbtHhIrpSoPJigcdHiE9SNiiweNEl3kd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GcdDQjZy; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57cb9a370ddso3269292a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 00:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719993223; x=1720598023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U5JXgyMic27rF0uTzeA4AUA7J0+eENGzNVobt6nLL58=;
        b=GcdDQjZyTRcjBnL9qEFlSYkHCowNubI1leV9g29WtADcqWWk8P/+/gNQLBaQ0OX6jN
         aL8xi9IbtAXDX5Ph0KbQy1oN1E6Wqpl88ll51ScC8kxPVF51HKso/xvwaeCH1QYamSRd
         7xF26UUzptqgmpkiReOMYFWP5HSidYVmZRp00LPfKtDwd9F0AxdmCpSc1I0Mb+NCvkRM
         LQ94oi1S0qK97NqS/jMJ7XR3pyELWqIl21polGUsR+Yk1GcUb9/b4h4y0uaRCg6lub3U
         ZtDZRuEQuxbZ0OQjBGkLe+hXXeaRDF0p0i4v8xwwTQUWo/9/HfrVW0m+ZBgMuCjDjm2n
         GWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719993223; x=1720598023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5JXgyMic27rF0uTzeA4AUA7J0+eENGzNVobt6nLL58=;
        b=UYsthTT8Sz+Lwu5T1tDqk0UJQmoxXB5T/iLLn/NM/vbzQIlqGzJWw9TWJOr/sSLzBP
         GuU1QB5bUhqiLq/SzcifH3MVHRN8lTCP0NCb5eLl/Xel/m2qNaWEafz51VpqtGqvsbNq
         +fgn0qLxlbHNA9Bj4I/wYFAwPAeHVccI2zH5JDOkREKtfVwu0yVX/uXj1tRyymk9lCo8
         eDuz7xuUjvIIU2SD2P9m1OHySedoKH572Az6avMY4lFUlinpeeSpXHZDzli9c/fETNsP
         68ivbPkH9jn14HpmtW+ynywXTveG7geZVkPPSyc9jgrPlP0SDkbKLLt86h5oiPHK1+Kc
         E4Sw==
X-Gm-Message-State: AOJu0YxwbkSi2tUW4EbO6lluljDh8FBTla93XBp3VrZeg+rvQ2UjfNko
	KwJfqpUgt1YwMW2z/LLWhp9Ca6JZ+1Vh8OoiqBhvVBHdvBFC0hDocC/eXtxSYWo=
X-Google-Smtp-Source: AGHT+IHx2gSoZYtFSuNqPB57GKnRYFsLhjFlEi4nE9BwzkxY9JN1lUj3Kg8MQ0EELkRhuPKAEIgTAA==
X-Received: by 2002:a05:6402:254a:b0:578:649e:e63e with SMTP id 4fb4d7f45d1cf-5879f1c2563mr7293173a12.16.1719993222472;
        Wed, 03 Jul 2024 00:53:42 -0700 (PDT)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58bef78662fsm1409447a12.70.2024.07.03.00.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 00:53:42 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v2] ring-buffer: Limit time with disabled interrupts in rb_check_pages()
Date: Wed,  3 Jul 2024 09:53:14 +0200
Message-Id: <20240703075314.23511-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function rb_check_pages() validates the integrity of a specified
per-CPU tracing ring buffer. It does so by traversing the underlying
linked list and checking its next and prev links.

To guarantee that the list isn't modified during the check, a caller
typically needs to take cpu_buffer->reader_lock. This prevents the check
from running concurrently, for example, with a potential reader which
can make the list temporarily inconsistent when swapping its old reader
page into the buffer.

A problem with this approach is that the time when interrupts are
disabled is non-deterministic, dependent on the ring buffer size. This
particularly affects PREEMPT_RT because the reader_lock is a raw
spinlock which doesn't become sleepable on PREEMPT_RT kernels.

Modify the check so it still attempts to traverse the entire list, but
gives up the reader_lock between checking individual pages. Introduce
for this purpose a new variable ring_buffer_per_cpu.pages_era which is
bumped any time the list is modified. The value is used by
rb_check_pages() to detect such a change and restart the check.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---

This is a follow-up to the discussion about improving this check [1].

Changes since v1 [2]:
* Correct the case when rb_check_pages() is invoked concurrently with
  the resize code which modifies the list. Introduce
  ring_buffer_per_cpu.pages_era for this purpose.

[1] https://lore.kernel.org/linux-trace-kernel/20240517134008.24529-1-petr.pavlu@suse.com/
[2] https://lore.kernel.org/linux-trace-kernel/20240621150956.24814-1-petr.pavlu@suse.com/

 kernel/trace/ring_buffer.c | 97 ++++++++++++++++++++++++++++----------
 1 file changed, 71 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 28853966aa9a..ff9a98c06043 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -462,6 +462,7 @@ struct ring_buffer_per_cpu {
 	unsigned long			nr_pages;
 	unsigned int			current_context;
 	struct list_head		*pages;
+	unsigned long			pages_era;	/* list state era */
 	struct buffer_page		*head_page;	/* read from head */
 	struct buffer_page		*tail_page;	/* write to tail */
 	struct buffer_page		*commit_page;	/* committed pages */
@@ -1454,40 +1455,87 @@ static void rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
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
+	unsigned long pages_era;
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
+	 * lock after checking each page. The pages_era variable is then used to
+	 * detect if the list was modified while the lock was not held, in which
+	 * case the check needs to be restarted.
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
+	pages_era = cpu_buffer->pages_era;
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
+		if (pages_era != cpu_buffer->pages_era) {
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
 
 static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
@@ -1874,6 +1922,7 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 
 	/* make sure pages points to a valid page in the ring buffer */
 	cpu_buffer->pages = next_page;
+	cpu_buffer->pages_era++;
 
 	/* update head page */
 	if (head_bit)
@@ -1980,6 +2029,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 			 * pointer to point to end of list
 			 */
 			head_page->prev = last_page;
+			cpu_buffer->pages_era++;
 			success = true;
 			break;
 		}
@@ -2215,12 +2265,8 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
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
@@ -4611,6 +4657,7 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	rb_list_head(reader->list.next)->prev = &cpu_buffer->reader_page->list;
 	rb_inc_page(&cpu_buffer->head_page);
 
+	cpu_buffer->pages_era++;
 	local_inc(&cpu_buffer->pages_read);
 
 	/* Finally update the reader page to the new head */
@@ -5150,12 +5197,9 @@ void
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
@@ -6050,6 +6094,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		cpu_buffer->pages = cpu_buffer->new_pages.next;
 		cpu_buffer->new_pages.next->prev = cpu_buffer->new_pages.prev;
 		cpu_buffer->new_pages.prev->next = cpu_buffer->new_pages.next;
+		cpu_buffer->pages_era++;
 
 		/* Clear the new_pages list */
 		INIT_LIST_HEAD(&cpu_buffer->new_pages);

base-commit: 1dfe225e9af5bd3399a1dbc6a4df6a6041ff9c23
-- 
2.35.3


