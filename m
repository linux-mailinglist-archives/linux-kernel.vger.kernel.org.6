Return-Path: <linux-kernel+bounces-397080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49C49BD673
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D34DB228C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED335215C60;
	Tue,  5 Nov 2024 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jBbwL592"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1E22161E9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 20:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837006; cv=none; b=esJmpcWMfqQJP8dMlWXX64cj19u8W1brJvYjDXMV0tYoX+SGvIL9tpyg1J7Hd2AQygFOF25MEAf9JW/1P4ssUw7aIa7QZFPIdzKJ6LVPqgxNec+1TexfT/hJaPbpIQ4axdF+sQLJHotUbT2pqK3ei9sHl/tuNENJN4kyAV+b/hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837006; c=relaxed/simple;
	bh=Ckm7wpbU5i1/hU2K+FldMuHODb874ygQ8Wx0As/XBXk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XoWYnHcG8y5baW59WDAznu3WuFQS4IV/fsJt3EorX5aeQZLDXJV0s5CVhKT8aNTooX7mQDF3x/uRv9J6Yl/0B8cLkTimuTj1ffEHCqEOLP1tZXF4OpiXW21zD8j14irysxoznBaULMdLI5dl06rNDl1MEHMLc7KJ7ZUhONYqJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jBbwL592; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea86f1df79so67696187b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 12:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730837003; x=1731441803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DJYcKIvsfCYef6ki+cx028Fm/41DbvehREHf3NCMgSY=;
        b=jBbwL592xyu8XiY9bSf5TvN8xPGamIp5ggVKibz2xEFrcRqUba8MINup4MCDR3Qp+i
         hC9DUPcS7jGP+qm+EfitI1ffkvmT/SeUtH11EEK3droVMfVuBXULKF51bMeBAkNRiyvY
         O0z6Mg1DJqPfPGhAiR5EXJ0SxmgIedX70lqRaYK6BzXlI9xvRATcYYu4HsEih2xJ4uv7
         0O6wmPXPD6VbNLEwpyPYdovTtTdlvSfc1vTJo6uwC454h+10ZBg8oS/VhoGuV7RJ52re
         mSSBwHRtoCV0AwfHS9Ds4vIg/qW0aNGRv70ehy0ESETZTCNY5TUEI0gx7VZM/qGmsnzE
         L8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730837003; x=1731441803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJYcKIvsfCYef6ki+cx028Fm/41DbvehREHf3NCMgSY=;
        b=po574pe8Xyx4j/7NAEbK2DVg5hWcgVfvtKZpPruiKmAM9dtvX6H2RM/M+0cA/JGGhA
         ZLUk3EpysLsLAWpK8QKL1avr1Vdjtbk9yVALnZ8OvZ0hvvMCUJx0zEm4Cz7FTGgTdsTh
         wDfLd1K63LbJxoAF6OnqC0HhIjIGlPk8aU9CZcEqx2Tqg+Eu0Nx4lukWdLs2JKUu2dSS
         fIs6hDkQtG2MsCfZFOXcIRwLI2QoiHKV7Al9ZbcAue2rcoeBgHEibN2WMlGHxKTtCtwY
         IPhl67KFb+BESHzjiRn+xjGUcm/BkMvXB11/1+70WvnNWVyMrrIKxsfxmnwlqbpWxBBY
         avFA==
X-Gm-Message-State: AOJu0YzrSj8r+BTq1oGmlVI/Mi2k29705WwcqvJuQwdAKL02PJC/tB7x
	QNAUPLcExTFb1iSWInZ8OhkgzIPzwgj4OVFHa9OH/TVHrCaT5izTAZWxBGtBzH4IW/7cSBVkR6l
	x8fyUg5T6qA==
X-Google-Smtp-Source: AGHT+IHQdRHCXzW6Yt0gtN2+GE1UnKlQbluksQ6XKPwYVvzl3YWUeoqF3aEW8WHxh181L4g37oAmmw36FJpBHg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:690c:4a02:b0:6e3:b08:92c7 with SMTP
 id 00721157ae682-6e9d87070a8mr9489887b3.0.1730837003421; Tue, 05 Nov 2024
 12:03:23 -0800 (PST)
Date: Tue,  5 Nov 2024 20:02:49 +0000
In-Reply-To: <20241105200258.2380168-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105200258.2380168-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105200258.2380168-8-cmllamas@google.com>
Subject: [PATCH 7/8] binder: rename alloc->buffer to vm_start
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

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c                |  2 +-
 drivers/android/binder_alloc.c          | 28 ++++++++++++-------------
 drivers/android/binder_alloc.h          |  4 ++--
 drivers/android/binder_alloc_selftest.c |  2 +-
 drivers/android/binder_trace.h          |  2 +-
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 978740537a1a..57265cabec43 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6350,7 +6350,7 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
 		seq_printf(m, " node %d", buffer->target_node->debug_id);
 	seq_printf(m, " size %zd:%zd offset %lx\n",
 		   buffer->data_size, buffer->offsets_size,
-		   proc->alloc.buffer - buffer->user_data);
+		   proc->alloc.vm_start - buffer->user_data);
 }
 
 static void print_binder_work_ilocked(struct seq_file *m,
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index a4b7bf8696dd..d505ffddb6db 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -62,7 +62,7 @@ static size_t binder_alloc_buffer_size(struct binder_alloc *alloc,
 				       struct binder_buffer *buffer)
 {
 	if (list_is_last(&buffer->entry, &alloc->buffers))
-		return alloc->buffer + alloc->buffer_size - buffer->user_data;
+		return alloc->vm_start + alloc->buffer_size - buffer->user_data;
 	return binder_buffer_next(buffer)->user_data - buffer->user_data;
 }
 
@@ -204,7 +204,7 @@ static void binder_lru_freelist_add(struct binder_alloc *alloc,
 		size_t index;
 		int ret;
 
-		index = (page_addr - alloc->buffer) / PAGE_SIZE;
+		index = (page_addr - alloc->vm_start) / PAGE_SIZE;
 		page = binder_get_installed_page(alloc, index);
 		if (!page)
 			continue;
@@ -277,7 +277,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		__free_page(page);
 		if (!folio_walk_start(&fw, vma, addr, 0)) {
 			pr_err("%d: failed to find page at offset %lx\n",
-			       alloc->pid, addr - alloc->buffer);
+			       alloc->pid, addr - alloc->vm_start);
 			ret = -ESRCH;
 			break;
 		}
@@ -291,7 +291,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		break;
 	default:
 		pr_err("%d: %s failed to insert page at offset %lx with %d\n",
-		       alloc->pid, __func__, addr - alloc->buffer, ret);
+		       alloc->pid, __func__, addr - alloc->vm_start, ret);
 		ret = -ENOMEM;
 		break;
 	}
@@ -319,7 +319,7 @@ static int binder_install_buffer_pages(struct binder_alloc *alloc,
 		unsigned long index;
 		int ret;
 
-		index = (page_addr - alloc->buffer) / PAGE_SIZE;
+		index = (page_addr - alloc->vm_start) / PAGE_SIZE;
 		if (binder_get_installed_page(alloc, index))
 			continue;
 
@@ -348,7 +348,7 @@ static void binder_lru_freelist_del(struct binder_alloc *alloc,
 		unsigned long index;
 		bool on_lru;
 
-		index = (page_addr - alloc->buffer) / PAGE_SIZE;
+		index = (page_addr - alloc->vm_start) / PAGE_SIZE;
 		page = binder_get_installed_page(alloc, index);
 
 		if (page) {
@@ -700,8 +700,8 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
 	BUG_ON(buffer->free);
 	BUG_ON(size > buffer_size);
 	BUG_ON(buffer->transaction != NULL);
-	BUG_ON(buffer->user_data < alloc->buffer);
-	BUG_ON(buffer->user_data > alloc->buffer + alloc->buffer_size);
+	BUG_ON(buffer->user_data < alloc->vm_start);
+	BUG_ON(buffer->user_data > alloc->vm_start + alloc->buffer_size);
 
 	if (buffer->async_transaction) {
 		alloc->free_async_space += buffer_size;
@@ -760,7 +760,7 @@ static struct page *binder_alloc_get_page(struct binder_alloc *alloc,
 					  pgoff_t *pgoffp)
 {
 	binder_size_t buffer_space_offset = buffer_offset +
-		(buffer->user_data - alloc->buffer);
+		(buffer->user_data - alloc->vm_start);
 	pgoff_t pgoff = buffer_space_offset & ~PAGE_MASK;
 	size_t index = buffer_space_offset >> PAGE_SHIFT;
 
@@ -859,7 +859,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 				   SZ_4M);
 	mutex_unlock(&binder_alloc_mmap_lock);
 
-	alloc->buffer = vma->vm_start;
+	alloc->vm_start = vma->vm_start;
 
 	alloc->pages = kvcalloc(alloc->buffer_size / PAGE_SIZE,
 				sizeof(alloc->pages[0]),
@@ -877,7 +877,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 		goto err_alloc_buf_struct_failed;
 	}
 
-	buffer->user_data = alloc->buffer;
+	buffer->user_data = alloc->vm_start;
 	list_add(&buffer->entry, &alloc->buffers);
 	buffer->free = 1;
 	binder_insert_free_buffer(alloc, buffer);
@@ -892,7 +892,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	kvfree(alloc->pages);
 	alloc->pages = NULL;
 err_alloc_pages_failed:
-	alloc->buffer = 0;
+	alloc->vm_start = 0;
 	mutex_lock(&binder_alloc_mmap_lock);
 	alloc->buffer_size = 0;
 err_already_mapped:
@@ -993,7 +993,7 @@ void binder_alloc_print_allocated(struct seq_file *m,
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
 		seq_printf(m, "  buffer %d: %lx size %zd:%zd:%zd %s\n",
 			   buffer->debug_id,
-			   buffer->user_data - alloc->buffer,
+			   buffer->user_data - alloc->vm_start,
 			   buffer->data_size, buffer->offsets_size,
 			   buffer->extra_buffers_size,
 			   buffer->transaction ? "active" : "delivered");
@@ -1099,7 +1099,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		goto err_get_alloc_mutex_failed;
 
 	index = page->index;
-	page_addr = alloc->buffer + index * PAGE_SIZE;
+	page_addr = alloc->vm_start + index * PAGE_SIZE;
 
 	vma = vma_lookup(mm, page_addr);
 	if (vma && !binder_alloc_is_mapped(alloc))
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index b9e2e9dc90b3..05a01d980f61 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -62,7 +62,7 @@ struct binder_buffer {
  * struct binder_alloc - per-binder proc state for binder allocator
  * @mutex:              protects binder_alloc fields
  * @mm:                 copy of task->mm (invariant after open)
- * @buffer:             base of per-proc address space mapped via mmap
+ * @vm_start:           base of per-proc address space mapped via mmap
  * @buffers:            list of all buffers for this proc
  * @free_buffers:       rb tree of buffers available for allocation
  *                      sorted by size
@@ -85,7 +85,7 @@ struct binder_buffer {
 struct binder_alloc {
 	struct mutex mutex;
 	struct mm_struct *mm;
-	unsigned long buffer;
+	unsigned long vm_start;
 	struct list_head buffers;
 	struct rb_root free_buffers;
 	struct rb_root allocated_buffers;
diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
index 2dda82d0d5e8..d2d086d2c037 100644
--- a/drivers/android/binder_alloc_selftest.c
+++ b/drivers/android/binder_alloc_selftest.c
@@ -104,7 +104,7 @@ static bool check_buffer_pages_allocated(struct binder_alloc *alloc,
 	end = PAGE_ALIGN(buffer->user_data + size);
 	page_addr = buffer->user_data;
 	for (; page_addr < end; page_addr += PAGE_SIZE) {
-		page_index = (page_addr - alloc->buffer) / PAGE_SIZE;
+		page_index = (page_addr - alloc->vm_start) / PAGE_SIZE;
 		if (!alloc->pages[page_index] ||
 		    !list_empty(&alloc->pages[page_index]->lru)) {
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
2.47.0.199.ga7371fff76-goog


