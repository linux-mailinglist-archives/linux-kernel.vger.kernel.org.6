Return-Path: <linux-kernel+bounces-422731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA1F9D9D81
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 658C7B28245
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F851DF972;
	Tue, 26 Nov 2024 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rFspAPuv"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BE61DF738
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646441; cv=none; b=KaD7Dc9O4YzbHXcmYofIbjoFzyPetW+hFNmeH9DOF6dCWPhumJkM7V0rG3NX20YiXd/CMgctDvB+5b0zwq30wXMFKlPqoob41C1hWABli0DbL0x3qBNV9J4JxzFjEl+Xg9AXheAbgkivLysU8OV5vmr4rLhVzNqtQNRqd65m0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646441; c=relaxed/simple;
	bh=529pDcA5JPLb/a2r6sj/j43DpzHZfwPoAec/EkEcAiY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mQE75ciqj5dEyUSetBAl+e3bQeQTy2S+O23x59yX3ZWZ4JVjOWC4gLVV4kdeWYvYs2GJ+TE9u0nxxwMq5bH5I0EcG3zSKlHgvTJ2SrPKvk84oH+dTmrCPlitUlMjw1is0/yd2pmQZnMFVVICoNj4r9jYFnTvIWGBhwK8L0Q1tVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rFspAPuv; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-724e2c587b1so4252501b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732646439; x=1733251239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b4Gmm0ra7Qe3zgkH+GXJhDigFMNAU2CK+UxxRp3srkA=;
        b=rFspAPuvDs1aMR9yIEn96Bu/IEwOBPV0sEiZHX6AGfLofoLnVh9dfXwaqyYoZBSYtF
         XECXwBGN2M44lmehaYAoz/HLPIrV3I4aDrIJadq/+/ac3l+VE+uFGKhzKif5PDIP04it
         DRyKy2JkvxRSHHqzzkKJAPusXWvSxe+Lhx1R32CxvmHx21tSRODwLNBMMDINPf0IDoOJ
         NvWG18fJZs+gcCg3F5ivkDOVmberYjkswT1KyAzWrLeF/hOx26EM4we0HQkpuZme1rkb
         r0zJokTvDRr4n9ESfhuOjTIC4oRxyg8tcOxMicuu7bRkOItJ4Ex+B226CSV4961iSwCC
         S2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732646439; x=1733251239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4Gmm0ra7Qe3zgkH+GXJhDigFMNAU2CK+UxxRp3srkA=;
        b=RzGrneq8KNo/S4dAFhe896ykpE3FU4RL9M33dsmguoYC3khIOO+hf3j8V9Cotna0jN
         Ny32ftbGqRpyeQeXxWiKBwXtG50wpwUfPhlpKIBcSC8271wMG65TryUOAd5mkbQd1nEI
         irwEx0f//h+nYDMhd6y8x08WmYfGp5bDSdLEquXNcLinluSqzw5mPzMHSxn1TGwixyv7
         vxtfd6NSbphYOOTFNYscBqqFxLATUuSair2e3A2SnwHcxVWp3n3WM2wqnLewPKx0AZUl
         S+l+Fn+jo4S0m1HylT+zt1eHPDMt5Xn9OLm04kZTlO8khoodMEBR7aU8EX4hzBkChJKa
         JxIw==
X-Gm-Message-State: AOJu0Yzgrwiu7CPNUkSw1pj8TeNoqXjNje/dDr5fYrENGCZRcfoE4jQA
	DFf94jfc0MxZLOmLZahT+PKdZbrnleFNlL3MSPTPQ7ldrapiXtYuquKIT8kiGF+VG/IxMfXKQex
	XJpjWh75IzQ==
X-Google-Smtp-Source: AGHT+IGpLShSN/PBPT785tbvVpPkVlzFr1LhtgCk0CZXWI9+cZ+eqpODl3N83ohL1dk4P0TdaPaaNyxILLakLw==
X-Received: from pfaw8.prod.google.com ([2002:a05:6a00:ab88:b0:725:29e2:ecab])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4654:b0:724:de21:60f8 with SMTP id d2e1a72fcca58-7252ffd81e4mr260547b3a.1.1732646438768;
 Tue, 26 Nov 2024 10:40:38 -0800 (PST)
Date: Tue, 26 Nov 2024 18:40:09 +0000
In-Reply-To: <20241126184021.45292-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241126184021.45292-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241126184021.45292-7-cmllamas@google.com>
Subject: [PATCH v5 6/9] binder: rename alloc->buffer to vm_start
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
index 4c308d860478..71b29bfd8a2e 100644
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
@@ -291,7 +291,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 					       FOLL_NOFAULT, &page, NULL);
 		if (npages <= 0) {
 			pr_err("%d: failed to find page at offset %lx\n",
-			       alloc->pid, addr - alloc->buffer);
+			       alloc->pid, addr - alloc->vm_start);
 			ret = -ESRCH;
 			break;
 		}
@@ -303,7 +303,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 	default:
 		__free_page(page);
 		pr_err("%d: %s failed to insert page at offset %lx with %d\n",
-		       alloc->pid, __func__, addr - alloc->buffer, ret);
+		       alloc->pid, __func__, addr - alloc->vm_start, ret);
 		ret = -ENOMEM;
 		break;
 	}
@@ -328,7 +328,7 @@ static int binder_install_buffer_pages(struct binder_alloc *alloc,
 		unsigned long index;
 		int ret;
 
-		index = (page_addr - alloc->buffer) / PAGE_SIZE;
+		index = (page_addr - alloc->vm_start) / PAGE_SIZE;
 		if (binder_get_installed_page(alloc, index))
 			continue;
 
@@ -357,7 +357,7 @@ static void binder_lru_freelist_del(struct binder_alloc *alloc,
 		unsigned long index;
 		bool on_lru;
 
-		index = (page_addr - alloc->buffer) / PAGE_SIZE;
+		index = (page_addr - alloc->vm_start) / PAGE_SIZE;
 		page = binder_get_installed_page(alloc, index);
 
 		if (page) {
@@ -709,8 +709,8 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
 	BUG_ON(buffer->free);
 	BUG_ON(size > buffer_size);
 	BUG_ON(buffer->transaction != NULL);
-	BUG_ON(buffer->user_data < alloc->buffer);
-	BUG_ON(buffer->user_data > alloc->buffer + alloc->buffer_size);
+	BUG_ON(buffer->user_data < alloc->vm_start);
+	BUG_ON(buffer->user_data > alloc->vm_start + alloc->buffer_size);
 
 	if (buffer->async_transaction) {
 		alloc->free_async_space += buffer_size;
@@ -769,7 +769,7 @@ static struct page *binder_alloc_get_page(struct binder_alloc *alloc,
 					  pgoff_t *pgoffp)
 {
 	binder_size_t buffer_space_offset = buffer_offset +
-		(buffer->user_data - alloc->buffer);
+		(buffer->user_data - alloc->vm_start);
 	pgoff_t pgoff = buffer_space_offset & ~PAGE_MASK;
 	size_t index = buffer_space_offset >> PAGE_SHIFT;
 
@@ -868,7 +868,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 				   SZ_4M);
 	mutex_unlock(&binder_alloc_mmap_lock);
 
-	alloc->buffer = vma->vm_start;
+	alloc->vm_start = vma->vm_start;
 
 	alloc->pages = kvcalloc(alloc->buffer_size / PAGE_SIZE,
 				sizeof(alloc->pages[0]),
@@ -886,7 +886,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 		goto err_alloc_buf_struct_failed;
 	}
 
-	buffer->user_data = alloc->buffer;
+	buffer->user_data = alloc->vm_start;
 	list_add(&buffer->entry, &alloc->buffers);
 	buffer->free = 1;
 	binder_insert_free_buffer(alloc, buffer);
@@ -901,7 +901,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	kvfree(alloc->pages);
 	alloc->pages = NULL;
 err_alloc_pages_failed:
-	alloc->buffer = 0;
+	alloc->vm_start = 0;
 	mutex_lock(&binder_alloc_mmap_lock);
 	alloc->buffer_size = 0;
 err_already_mapped:
@@ -1002,7 +1002,7 @@ void binder_alloc_print_allocated(struct seq_file *m,
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
 	/* ensure the vma corresponds to the binder mapping */
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 634bc2e03729..a6f26b1d8f5e 100644
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
2.47.0.338.g60cca15819-goog


