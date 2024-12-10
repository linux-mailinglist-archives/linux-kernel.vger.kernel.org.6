Return-Path: <linux-kernel+bounces-439738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 839229EB362
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211722825D5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BE01BD9C5;
	Tue, 10 Dec 2024 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5QtL5rp"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E26A1BD9CF
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841108; cv=none; b=VWrcCbU25B+kK3gIezMVcTLQC6o8dU1jgg+7MN/av+x8/ABNPCqN7P4G6hkxqBPIPEGIU8ahEtIcH66lJiK0MprxgjXowZTqBZfvXOXor8xwCeJLMXSKjMWpC5p1WPB3GfjDDcWyjc5RBh1tECoTrUbEW/BbmCZKLbcok70DtMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841108; c=relaxed/simple;
	bh=eth7T++Q0FzgocqqP4fggTVzzAQIuATo0B0hBmeCoh0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PCym9LhrOIjoWxREb9LkqaJW0luXDwGpX6d+L+xDZ0L7tmzue2tCE4Qzj7jC0EsWTMNJVgfTRDs//b2HkdqzqIMGdY/4TWiKRJn2VHmWQQA9G9UsT6E+RTZapA/WqNrGn2OxM2Hy1WSsKW7tC+GmIp2TUuXQLsm6leDhE1NJ6LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r5QtL5rp; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ea8c2b257bso4231000a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733841106; x=1734445906; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PyA0Lsrj9pN3UREjL6nyJV4Cn0UuYdmgpXHZAKW4bm8=;
        b=r5QtL5rpWp0mpcJiB/jLAef17sAi0WYcOjzSIrWzcCspzxbYUJZZi9m42dwNXD9JQl
         wE5Mtq3BHA46epipofi6C5CPSQxCV6FzFJSuRIRu2bYoXF8ESduMiv1ONzFhzML+Y+yb
         HoRxrDuka8B8/QaCMtyy17DFdL9ZvjnlJ+d+PTIny56XmrsKI7xS/t6CJ+bRqwhuhINC
         EQAUlp+e/JhktbH+YnNtmYx84UpjE+d+41pft9vm3GLZemrMwHeyKdkqknbmNhUwTT81
         ofRqNKKF4PDArEpG0LA9+Vm/B6PzYTULnHUWOaUi0uhxui9tabw08ihC4G6hExyzB2ML
         TMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841106; x=1734445906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PyA0Lsrj9pN3UREjL6nyJV4Cn0UuYdmgpXHZAKW4bm8=;
        b=JAmAQ4NcMkDRFOMn21RurfpzZgwx5FY2vifPHVfB9RNkwfLxwKHQGwJb0T2xsiFt93
         E7PzWW8D642Hsy+s8UcuuiDoPLSvYFQx0KMpjL2T8lR5l4T8hRNRxaUvltVax9CKvqDy
         PpJXkieQKSMP+FCT92SUC5kzEviXTQzWDY/5Ja5xjBW4gufKIKq1Rp+McmfRAc9t0+RT
         6G0bgmGCkIMRwB5ov+uw8Ju3XZMK3Ivao3FaA9Fnj5Y008zqaDdRqav+YyxS1uwv2eKk
         KQ8ExhfEy/ofzdPSyZ+Lj5aIxJoXzLm7d3WI5j4OsS7xd32y9eSl3DYiRcmgTTEDc5pz
         H4Jg==
X-Gm-Message-State: AOJu0YwcBH685Q+UVogFKisTosAEtiohnKy99p2wniyfFGY3aj2LY3wl
	MqV4vN9AWIDjRSB40fgQuUfW4zqs9rseWMIz+OQqPqp/PvFViV8CLZV+jC7Etv7ka9ry1qyPTdB
	LMACTfIyYQA==
X-Google-Smtp-Source: AGHT+IEisSNpbIdzaz3jb4rgLdyrYbzDg7lPEH5METAjJEy2oJLx7l5L1wHkDD49S3wgk2+Z8sVhKgtKUMQN8w==
X-Received: from pfu5.prod.google.com ([2002:a05:6a00:a385:b0:725:f376:f548])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9999:b0:1e1:b062:f409 with SMTP id adf61e73a8af0-1e1b1b903e1mr6687895637.43.1733841105854;
 Tue, 10 Dec 2024 06:31:45 -0800 (PST)
Date: Tue, 10 Dec 2024 14:31:02 +0000
In-Reply-To: <20241210143114.661252-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210143114.661252-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210143114.661252-7-cmllamas@google.com>
Subject: [PATCH v7 6/9] binder: rename alloc->buffer to vm_start
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

The alloc->buffer field in struct binder_alloc stores the starting
address of the mapped vma, rename this field to alloc->vm_start to
better reflect its purpose. It also avoids confusion with the binder
buffer concept, e.g. transaction->buffer.

No functional changes in this patch.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c                |  2 +-
 drivers/android/binder_alloc.c          | 28 ++++++++++++-------------
 drivers/android/binder_alloc.h          |  4 ++--
 drivers/android/binder_alloc_selftest.c |  2 +-
 drivers/android/binder_trace.h          |  2 +-
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index ef353ca13c35..9962c606cabd 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6374,7 +6374,7 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
 		seq_printf(m, " node %d", buffer->target_node->debug_id);
 	seq_printf(m, " size %zd:%zd offset %lx\n",
 		   buffer->data_size, buffer->offsets_size,
-		   proc->alloc.buffer - buffer->user_data);
+		   proc->alloc.vm_start - buffer->user_data);
 }
 
 static void print_binder_work_ilocked(struct seq_file *m,
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index ed79d7c146c8..9cb47e1bc6be 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -61,7 +61,7 @@ static size_t binder_alloc_buffer_size(struct binder_alloc *alloc,
 				       struct binder_buffer *buffer)
 {
 	if (list_is_last(&buffer->entry, &alloc->buffers))
-		return alloc->buffer + alloc->buffer_size - buffer->user_data;
+		return alloc->vm_start + alloc->buffer_size - buffer->user_data;
 	return binder_buffer_next(buffer)->user_data - buffer->user_data;
 }
 
@@ -203,7 +203,7 @@ static void binder_lru_freelist_add(struct binder_alloc *alloc,
 		size_t index;
 		int ret;
 
-		index = (page_addr - alloc->buffer) / PAGE_SIZE;
+		index = (page_addr - alloc->vm_start) / PAGE_SIZE;
 		page = binder_get_installed_page(alloc, index);
 		if (!page)
 			continue;
@@ -305,7 +305,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 					       FOLL_NOFAULT, &page, NULL);
 		if (npages <= 0) {
 			pr_err("%d: failed to find page at offset %lx\n",
-			       alloc->pid, addr - alloc->buffer);
+			       alloc->pid, addr - alloc->vm_start);
 			ret = -ESRCH;
 			break;
 		}
@@ -317,7 +317,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 	default:
 		binder_free_page(page);
 		pr_err("%d: %s failed to insert page at offset %lx with %d\n",
-		       alloc->pid, __func__, addr - alloc->buffer, ret);
+		       alloc->pid, __func__, addr - alloc->vm_start, ret);
 		ret = -ENOMEM;
 		break;
 	}
@@ -342,7 +342,7 @@ static int binder_install_buffer_pages(struct binder_alloc *alloc,
 		unsigned long index;
 		int ret;
 
-		index = (page_addr - alloc->buffer) / PAGE_SIZE;
+		index = (page_addr - alloc->vm_start) / PAGE_SIZE;
 		if (binder_get_installed_page(alloc, index))
 			continue;
 
@@ -371,7 +371,7 @@ static void binder_lru_freelist_del(struct binder_alloc *alloc,
 		unsigned long index;
 		bool on_lru;
 
-		index = (page_addr - alloc->buffer) / PAGE_SIZE;
+		index = (page_addr - alloc->vm_start) / PAGE_SIZE;
 		page = binder_get_installed_page(alloc, index);
 
 		if (page) {
@@ -723,8 +723,8 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
 	BUG_ON(buffer->free);
 	BUG_ON(size > buffer_size);
 	BUG_ON(buffer->transaction != NULL);
-	BUG_ON(buffer->user_data < alloc->buffer);
-	BUG_ON(buffer->user_data > alloc->buffer + alloc->buffer_size);
+	BUG_ON(buffer->user_data < alloc->vm_start);
+	BUG_ON(buffer->user_data > alloc->vm_start + alloc->buffer_size);
 
 	if (buffer->async_transaction) {
 		alloc->free_async_space += buffer_size;
@@ -783,7 +783,7 @@ static struct page *binder_alloc_get_page(struct binder_alloc *alloc,
 					  pgoff_t *pgoffp)
 {
 	binder_size_t buffer_space_offset = buffer_offset +
-		(buffer->user_data - alloc->buffer);
+		(buffer->user_data - alloc->vm_start);
 	pgoff_t pgoff = buffer_space_offset & ~PAGE_MASK;
 	size_t index = buffer_space_offset >> PAGE_SHIFT;
 
@@ -882,7 +882,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 				   SZ_4M);
 	mutex_unlock(&binder_alloc_mmap_lock);
 
-	alloc->buffer = vma->vm_start;
+	alloc->vm_start = vma->vm_start;
 
 	alloc->pages = kvcalloc(alloc->buffer_size / PAGE_SIZE,
 				sizeof(alloc->pages[0]),
@@ -900,7 +900,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 		goto err_alloc_buf_struct_failed;
 	}
 
-	buffer->user_data = alloc->buffer;
+	buffer->user_data = alloc->vm_start;
 	list_add(&buffer->entry, &alloc->buffers);
 	buffer->free = 1;
 	binder_insert_free_buffer(alloc, buffer);
@@ -915,7 +915,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	kvfree(alloc->pages);
 	alloc->pages = NULL;
 err_alloc_pages_failed:
-	alloc->buffer = 0;
+	alloc->vm_start = 0;
 	mutex_lock(&binder_alloc_mmap_lock);
 	alloc->buffer_size = 0;
 err_already_mapped:
@@ -1016,7 +1016,7 @@ void binder_alloc_print_allocated(struct seq_file *m,
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
 		seq_printf(m, "  buffer %d: %lx size %zd:%zd:%zd %s\n",
 			   buffer->debug_id,
-			   buffer->user_data - alloc->buffer,
+			   buffer->user_data - alloc->vm_start,
 			   buffer->data_size, buffer->offsets_size,
 			   buffer->extra_buffers_size,
 			   buffer->transaction ? "active" : "delivered");
@@ -1121,7 +1121,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		goto err_get_alloc_mutex_failed;
 
 	index = mdata->page_index;
-	page_addr = alloc->buffer + index * PAGE_SIZE;
+	page_addr = alloc->vm_start + index * PAGE_SIZE;
 
 	vma = vma_lookup(mm, page_addr);
 	/*
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 3ebb12afd4de..feecd7414241 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -83,7 +83,7 @@ static inline struct list_head *page_to_lru(struct page *p)
  * struct binder_alloc - per-binder proc state for binder allocator
  * @mutex:              protects binder_alloc fields
  * @mm:                 copy of task->mm (invariant after open)
- * @buffer:             base of per-proc address space mapped via mmap
+ * @vm_start:           base of per-proc address space mapped via mmap
  * @buffers:            list of all buffers for this proc
  * @free_buffers:       rb tree of buffers available for allocation
  *                      sorted by size
@@ -107,7 +107,7 @@ static inline struct list_head *page_to_lru(struct page *p)
 struct binder_alloc {
 	struct mutex mutex;
 	struct mm_struct *mm;
-	unsigned long buffer;
+	unsigned long vm_start;
 	struct list_head buffers;
 	struct rb_root free_buffers;
 	struct rb_root allocated_buffers;
diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
index 6a64847a8555..c88735c54848 100644
--- a/drivers/android/binder_alloc_selftest.c
+++ b/drivers/android/binder_alloc_selftest.c
@@ -104,7 +104,7 @@ static bool check_buffer_pages_allocated(struct binder_alloc *alloc,
 	end = PAGE_ALIGN(buffer->user_data + size);
 	page_addr = buffer->user_data;
 	for (; page_addr < end; page_addr += PAGE_SIZE) {
-		page_index = (page_addr - alloc->buffer) / PAGE_SIZE;
+		page_index = (page_addr - alloc->vm_start) / PAGE_SIZE;
 		if (!alloc->pages[page_index] ||
 		    !list_empty(page_to_lru(alloc->pages[page_index]))) {
 			pr_err("expect alloc but is %s at page index %d\n",
diff --git a/drivers/android/binder_trace.h b/drivers/android/binder_trace.h
index fe38c6fc65d0..16de1b9e72f7 100644
--- a/drivers/android/binder_trace.h
+++ b/drivers/android/binder_trace.h
@@ -328,7 +328,7 @@ TRACE_EVENT(binder_update_page_range,
 	TP_fast_assign(
 		__entry->proc = alloc->pid;
 		__entry->allocate = allocate;
-		__entry->offset = start - alloc->buffer;
+		__entry->offset = start - alloc->vm_start;
 		__entry->size = end - start;
 	),
 	TP_printk("proc=%d allocate=%d offset=%zu size=%zu",
-- 
2.47.0.338.g60cca15819-goog


