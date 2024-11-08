Return-Path: <linux-kernel+bounces-402245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4999C2565
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C2B1C23151
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55BB1F26C1;
	Fri,  8 Nov 2024 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oY8HPcdx"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571DA1EBA0C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093083; cv=none; b=K2zlJNMZLvXf8PjFImOH0p8R0Z0J3hhXcO8UN4vgtdLh2nYl/Jij/8Cec5YN53SFvnuSZxHW2K+HstBMvL4k6KZMaAEuZE0s8W9vetlGK/C4S2WSGa+X43BQKsoXheJTa3P9tpUOz+xzsoH89TL3w/JwIhDZBf5IYDkQwdQsgM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093083; c=relaxed/simple;
	bh=AlYkDMaOHpURAI/JcOKfZUbLLSJ0Lxyop+6desmuhnQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KnVcxhdeFmWxGr0Bfds0fUY+jOjPYYcKS0lO4qn/8XeGjEOfM+R8f0L54Wflpkwt+YB8Jcq0pYN1VCj7vbl58FT0nVeCcL8UqeQSHnv2cCaEHnAQ/CEaoteh0GnpWTjm4iyR7ym71yJlju+euAQbyrL7KB9xiVCo+NzlPDhkaok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oY8HPcdx; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-720738f8040so2034162b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 11:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731093080; x=1731697880; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OxO0bWh8K6LE5JehtANYtMg4flCydjOM0+4L5atuHkc=;
        b=oY8HPcdxY4yQdbNqm4ky3ULQKZMqPYbrm8AdSadLC1oiVO1lbCNe2VQyUueNCp3dTN
         S/mihwHWahTXX47G6bxHwydA9MOUS4+jN6DDGl8pssXoXILCtoDMwl5jO14RULkqYv4Q
         5J8HFWFhzIpxo/757XNCNA4a4NDj7ZOHx7zu1OXTih71WLOUuqJ124/LJVpc0sd5kb2f
         d5awLiaKNp1D8EdS6G1I+lG3pniNF4kmKhE/R6trWYTLRsSMi1VJYaueBgzb8yo5Spgc
         B9M6yyHkIiclboCdl/iiq1Mow3CaE3wcyBxaYrjnKbnnC8E2WaAzhqa21jq3oBNqx6WI
         jffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731093080; x=1731697880;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OxO0bWh8K6LE5JehtANYtMg4flCydjOM0+4L5atuHkc=;
        b=GeQFy7nwn0gotPFuKDRn+uezjmxtqCaeEbaWx7mvBTE7a9A4wOd1Vr7rcf0LGF7OLw
         aqGHSN2rh/XET7XJllVUWF9VEq8k2mmWddPANZ8TvNqEYDErgZa1SJWT4pzA+eObW2PH
         IPZq9hFfpFUCA2LEQh73jEWOgcJx/P8SO1oAPNidDmwAmrjbkXFZ0XMxOEoDvUMzjS1S
         Bz+nNpiivURP3/3zjiCb7cStFDu0uq9MyMMwlRUFhmDtHsDvjlCAh03GdrnyS5DNwGGm
         sUQyJZcc7NfgiSUt43W/klJSlHbVA6XcJ35NWcNAL/MEgVvxadR2IgYGD14ZK+caEBLo
         3EGQ==
X-Gm-Message-State: AOJu0Yx6KJVG5ipu+2OWVNNuEFB5STuQeapLzNyQgv0L1xTQei5ZYUpS
	txWe0PDgbzwIBTnG2KFTZSVpSJFGl8ze+EQMXQif8RY8Wm1ZD/8UKBQfdI+8CB1uq4cvYrpHyPO
	uCSEcUqfw8g==
X-Google-Smtp-Source: AGHT+IEDiJO7caezidZqUhVhtAYdZoMi+BM4JCPu80AeV3YDXnoG1Wh60btU6XRNvyKi9hEyBBrMXnPLbaYCPg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:69ad:b0:71e:5b2b:991c with SMTP
 id d2e1a72fcca58-724133b1490mr64800b3a.5.1731093080456; Fri, 08 Nov 2024
 11:11:20 -0800 (PST)
Date: Fri,  8 Nov 2024 19:10:48 +0000
In-Reply-To: <20241108191057.3288442-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108191057.3288442-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241108191057.3288442-7-cmllamas@google.com>
Subject: [PATCH v3 6/8] binder: rename alloc->buffer to vm_start
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
index a6697b5a4b2f..3716ffd00baf 100644
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
@@ -290,7 +290,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		npages = get_user_pages_remote(alloc->mm, addr, 1, 0, &page, NULL);
 		if (npages <= 0) {
 			pr_err("%d: failed to find page at offset %lx\n",
-			       alloc->pid, addr - alloc->buffer);
+			       alloc->pid, addr - alloc->vm_start);
 			ret = -ESRCH;
 			break;
 		}
@@ -302,7 +302,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 	default:
 		__free_page(page);
 		pr_err("%d: %s failed to insert page at offset %lx with %d\n",
-		       alloc->pid, __func__, addr - alloc->buffer, ret);
+		       alloc->pid, __func__, addr - alloc->vm_start, ret);
 		ret = -ENOMEM;
 		break;
 	}
@@ -327,7 +327,7 @@ static int binder_install_buffer_pages(struct binder_alloc *alloc,
 		unsigned long index;
 		int ret;
 
-		index = (page_addr - alloc->buffer) / PAGE_SIZE;
+		index = (page_addr - alloc->vm_start) / PAGE_SIZE;
 		if (binder_get_installed_page(alloc, index))
 			continue;
 
@@ -356,7 +356,7 @@ static void binder_lru_freelist_del(struct binder_alloc *alloc,
 		unsigned long index;
 		bool on_lru;
 
-		index = (page_addr - alloc->buffer) / PAGE_SIZE;
+		index = (page_addr - alloc->vm_start) / PAGE_SIZE;
 		page = binder_get_installed_page(alloc, index);
 
 		if (page) {
@@ -708,8 +708,8 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
 	BUG_ON(buffer->free);
 	BUG_ON(size > buffer_size);
 	BUG_ON(buffer->transaction != NULL);
-	BUG_ON(buffer->user_data < alloc->buffer);
-	BUG_ON(buffer->user_data > alloc->buffer + alloc->buffer_size);
+	BUG_ON(buffer->user_data < alloc->vm_start);
+	BUG_ON(buffer->user_data > alloc->vm_start + alloc->buffer_size);
 
 	if (buffer->async_transaction) {
 		alloc->free_async_space += buffer_size;
@@ -768,7 +768,7 @@ static struct page *binder_alloc_get_page(struct binder_alloc *alloc,
 					  pgoff_t *pgoffp)
 {
 	binder_size_t buffer_space_offset = buffer_offset +
-		(buffer->user_data - alloc->buffer);
+		(buffer->user_data - alloc->vm_start);
 	pgoff_t pgoff = buffer_space_offset & ~PAGE_MASK;
 	size_t index = buffer_space_offset >> PAGE_SHIFT;
 
@@ -867,7 +867,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 				   SZ_4M);
 	mutex_unlock(&binder_alloc_mmap_lock);
 
-	alloc->buffer = vma->vm_start;
+	alloc->vm_start = vma->vm_start;
 
 	alloc->pages = kvcalloc(alloc->buffer_size / PAGE_SIZE,
 				sizeof(alloc->pages[0]),
@@ -885,7 +885,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 		goto err_alloc_buf_struct_failed;
 	}
 
-	buffer->user_data = alloc->buffer;
+	buffer->user_data = alloc->vm_start;
 	list_add(&buffer->entry, &alloc->buffers);
 	buffer->free = 1;
 	binder_insert_free_buffer(alloc, buffer);
@@ -900,7 +900,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	kvfree(alloc->pages);
 	alloc->pages = NULL;
 err_alloc_pages_failed:
-	alloc->buffer = 0;
+	alloc->vm_start = 0;
 	mutex_lock(&binder_alloc_mmap_lock);
 	alloc->buffer_size = 0;
 err_already_mapped:
@@ -1001,7 +1001,7 @@ void binder_alloc_print_allocated(struct seq_file *m,
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
 		seq_printf(m, "  buffer %d: %lx size %zd:%zd:%zd %s\n",
 			   buffer->debug_id,
-			   buffer->user_data - alloc->buffer,
+			   buffer->user_data - alloc->vm_start,
 			   buffer->data_size, buffer->offsets_size,
 			   buffer->extra_buffers_size,
 			   buffer->transaction ? "active" : "delivered");
@@ -1106,7 +1106,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		goto err_get_alloc_mutex_failed;
 
 	index = page->index;
-	page_addr = alloc->buffer + index * PAGE_SIZE;
+	page_addr = alloc->vm_start + index * PAGE_SIZE;
 
 	vma = vma_lookup(mm, page_addr);
 	if (vma && !binder_alloc_is_mapped(alloc))
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index a3c043cb8343..088829ce6668 100644
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
@@ -86,7 +86,7 @@ struct binder_buffer {
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
2.47.0.277.g8800431eea-goog


