Return-Path: <linux-kernel+bounces-414834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 768609D2E6E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8680B339E4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175EB1D4333;
	Tue, 19 Nov 2024 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n05DM4sg"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4B61D4329
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041186; cv=none; b=S/Z/2aq1Rhkzkkk6pfVRDT0vqIPD/IUsjj0IJyaGU1vltx4MUZF99gST9MLVhhHQUSJJY7Q3urlZhEG0zlGSxfMDyY+iiAqZk/RdKhBgpGNvJlhZ1fGDwg73w7kKXIj/mu0e9PFyzwGjOwKcZqglzltv2KVUYcXXWwTFkYPw2zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041186; c=relaxed/simple;
	bh=EfcoNG9okG2g4k5D+Jznjitl9kCkxR3Tw4wms6XJ2+E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bY02Uq0qlFdjzUU+u+QEqoojCC6mS3QT39Z/jlkWd83JNVU8Cwre+Dc7CLxvei6YOljZ6zF6GlKlJsmVRojQMUE8DPXQFHyJWzxK960BxkMYQI5G3av7UXTr6UBmG6vHskL8S8OymT2y1Ou9wTTJe4aC+vdj9qbPP4RmNjdLgEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n05DM4sg; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71e58e838d5so1212534b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732041184; x=1732645984; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zMN0k5svveXvC2sH2pHSPqK7eKbC2pditVCZqBEVvus=;
        b=n05DM4sgMwV9G/cCPH4cSluMz80hbcYpkmJi/WtbcGvyzSOVFVWvk7QWPymSvPiW0n
         5GJFBhg1/7K6oGSC84b7YSIZoSX0zS8bGrqfJyY1ite+1lQVTNck3+Q4PUlqx238YsJC
         C2bRYpOmLbvkfxM3e6r5nsCMFPsGSYaB3jw79jDzLkULTC+HH+AGNvUfh9CkFze16VDl
         S/90m2KxcZjpKMud+ErD7jl+DIQxYs2rHlsBFrx+sVKV5r3X2o9eMk6ACsPBScDqf0vQ
         HgiWYrRJURcpVTbo3gzD7qEuqWiHkMS5/4w7khz08bGYMJ4J5qI45Mjo76tBAJ66gLfp
         QN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732041184; x=1732645984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMN0k5svveXvC2sH2pHSPqK7eKbC2pditVCZqBEVvus=;
        b=cWNNfEMZTdTQ1GF1wnZ2cW8vURivuBlBSbZWEMKWwxQim3DeFgAHc00IpIvU5DWxGs
         DmrqW385Y9gPwE99e8kLEuL0YC5vesZc1Qc4CICsEMNG1MzTtrvqOnbxoTC7UBbpjgmf
         Ga24/WgqDAR0OIxOtvdzdR67I+Q1L96DPJM2glJ8PUBHSm0sN5cLhWH+rgXjM1IgIaUI
         tvKPqQtjZ6HOdTnVvQaqcOMVRUliypjyYG3mxe+wcWYOHrLLqJ+SaMd7ajVKNDUGJ3mv
         HpHr0IdXaoN9qwpYYoPy71yFGLctkwESvUzWYNepP3pC40Eg1hrYH5WN6EFPv+Us+oBR
         jvpg==
X-Gm-Message-State: AOJu0YzehEqQiRtvyQZbT6sOvjcEG+3bpGnt2/MyWaxS/1lgNFEGaHL4
	Mjbv7pmHtMhksqCH8B7DoaTlQAOsFbZOhVo9WvCm9SHxmaqJ8lUwmaMjUYphdQZ6g4yQDv6A4jH
	bFbxBs1nxZg==
X-Google-Smtp-Source: AGHT+IGuPsyAO34xBw2ldZBPymcD4qim52fCTMxGEf5mCEmKpjnN7L2HnioprXOg1Cua+8a36Aib67v42ScaLg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:1893:b0:720:2fb7:bcf6 with SMTP
 id d2e1a72fcca58-72476f7dc3fmr369321b3a.3.1732041183769; Tue, 19 Nov 2024
 10:33:03 -0800 (PST)
Date: Tue, 19 Nov 2024 18:32:37 +0000
In-Reply-To: <20241119183250.3497547-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119183250.3497547-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241119183250.3497547-5-cmllamas@google.com>
Subject: [PATCH v4 4/9] binder: remove struct binder_lru_page
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Remove the redundant struct binder_lru_page concept. Instead, let's use
available struct page->lru and page->private members directly to achieve
the same functionality.

This reduces the maximum memory allocated for alloc->pages from 32768
down to 8192 bytes (aarch64). Savings are per binder instance.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c          | 104 ++++++++++++------------
 drivers/android/binder_alloc.h          |  16 +---
 drivers/android/binder_alloc_selftest.c |  14 ++--
 3 files changed, 63 insertions(+), 71 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index c1a9a11d2632..7afb3f74b19f 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -176,25 +176,26 @@ struct binder_buffer *binder_alloc_prepare_to_free(struct binder_alloc *alloc,
 }
 
 static inline void
-binder_set_installed_page(struct binder_lru_page *lru_page,
+binder_set_installed_page(struct binder_alloc *alloc,
+			  unsigned long index,
 			  struct page *page)
 {
 	/* Pairs with acquire in binder_get_installed_page() */
-	smp_store_release(&lru_page->page_ptr, page);
+	smp_store_release(&alloc->pages[index], page);
 }
 
 static inline struct page *
-binder_get_installed_page(struct binder_lru_page *lru_page)
+binder_get_installed_page(struct binder_alloc *alloc, unsigned long index)
 {
 	/* Pairs with release in binder_set_installed_page() */
-	return smp_load_acquire(&lru_page->page_ptr);
+	return smp_load_acquire(&alloc->pages[index]);
 }
 
 static void binder_lru_freelist_add(struct binder_alloc *alloc,
 				    unsigned long start, unsigned long end)
 {
-	struct binder_lru_page *page;
 	unsigned long page_addr;
+	struct page *page;
 
 	trace_binder_update_page_range(alloc, false, start, end);
 
@@ -203,16 +204,15 @@ static void binder_lru_freelist_add(struct binder_alloc *alloc,
 		int ret;
 
 		index = (page_addr - alloc->buffer) / PAGE_SIZE;
-		page = &alloc->pages[index];
-
-		if (!binder_get_installed_page(page))
+		page = binder_get_installed_page(alloc, index);
+		if (!page)
 			continue;
 
 		trace_binder_free_lru_start(alloc, index);
 
 		ret = list_lru_add(&binder_freelist,
 				   &page->lru,
-				   page_to_nid(page->page_ptr),
+				   page_to_nid(page),
 				   NULL);
 		WARN_ON(!ret);
 
@@ -220,8 +220,25 @@ static void binder_lru_freelist_add(struct binder_alloc *alloc,
 	}
 }
 
+static struct page *binder_page_alloc(struct binder_alloc *alloc,
+				      unsigned long index,
+				      unsigned long addr)
+{
+	struct page *page;
+
+	page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
+	if (!page)
+		return NULL;
+
+	page->private = (unsigned long)alloc;
+	INIT_LIST_HEAD(&page->lru);
+	page->index = index;
+
+	return page;
+}
+
 static int binder_install_single_page(struct binder_alloc *alloc,
-				      struct binder_lru_page *lru_page,
+				      unsigned long index,
 				      unsigned long addr)
 {
 	struct vm_area_struct *vma;
@@ -232,9 +249,8 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 	if (!mmget_not_zero(alloc->mm))
 		return -ESRCH;
 
-	page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
+	page = binder_page_alloc(alloc, index, addr);
 	if (!page) {
-		pr_err("%d: failed to allocate page\n", alloc->pid);
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -253,7 +269,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 	case -EBUSY:
 		/*
 		 * EBUSY is ok. Someone installed the pte first but the
-		 * lru_page->page_ptr has not been updated yet. Discard
+		 * alloc->pages[index] has not been updated yet. Discard
 		 * our page and look up the one already installed.
 		 */
 		ret = 0;
@@ -269,7 +285,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		fallthrough;
 	case 0:
 		/* Mark page installation complete and safe to use */
-		binder_set_installed_page(lru_page, page);
+		binder_set_installed_page(alloc, index, page);
 		break;
 	default:
 		__free_page(page);
@@ -289,7 +305,6 @@ static int binder_install_buffer_pages(struct binder_alloc *alloc,
 				       struct binder_buffer *buffer,
 				       size_t size)
 {
-	struct binder_lru_page *page;
 	unsigned long start, final;
 	unsigned long page_addr;
 
@@ -301,14 +316,12 @@ static int binder_install_buffer_pages(struct binder_alloc *alloc,
 		int ret;
 
 		index = (page_addr - alloc->buffer) / PAGE_SIZE;
-		page = &alloc->pages[index];
-
-		if (binder_get_installed_page(page))
+		if (binder_get_installed_page(alloc, index))
 			continue;
 
 		trace_binder_alloc_page_start(alloc, index);
 
-		ret = binder_install_single_page(alloc, page, page_addr);
+		ret = binder_install_single_page(alloc, index, page_addr);
 		if (ret)
 			return ret;
 
@@ -322,8 +335,8 @@ static int binder_install_buffer_pages(struct binder_alloc *alloc,
 static void binder_lru_freelist_del(struct binder_alloc *alloc,
 				    unsigned long start, unsigned long end)
 {
-	struct binder_lru_page *page;
 	unsigned long page_addr;
+	struct page *page;
 
 	trace_binder_update_page_range(alloc, true, start, end);
 
@@ -332,14 +345,14 @@ static void binder_lru_freelist_del(struct binder_alloc *alloc,
 		bool on_lru;
 
 		index = (page_addr - alloc->buffer) / PAGE_SIZE;
-		page = &alloc->pages[index];
+		page = binder_get_installed_page(alloc, index);
 
-		if (page->page_ptr) {
+		if (page) {
 			trace_binder_alloc_lru_start(alloc, index);
 
 			on_lru = list_lru_del(&binder_freelist,
 					      &page->lru,
-					      page_to_nid(page->page_ptr),
+					      page_to_nid(page),
 					      NULL);
 			WARN_ON(!on_lru);
 
@@ -760,11 +773,10 @@ static struct page *binder_alloc_get_page(struct binder_alloc *alloc,
 		(buffer->user_data - alloc->buffer);
 	pgoff_t pgoff = buffer_space_offset & ~PAGE_MASK;
 	size_t index = buffer_space_offset >> PAGE_SHIFT;
-	struct binder_lru_page *lru_page;
 
-	lru_page = &alloc->pages[index];
 	*pgoffp = pgoff;
-	return lru_page->page_ptr;
+
+	return binder_get_installed_page(alloc, index);
 }
 
 /**
@@ -839,7 +851,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 {
 	struct binder_buffer *buffer;
 	const char *failure_string;
-	int ret, i;
+	int ret;
 
 	if (unlikely(vma->vm_mm != alloc->mm)) {
 		ret = -EINVAL;
@@ -862,17 +874,12 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	alloc->pages = kvcalloc(alloc->buffer_size / PAGE_SIZE,
 				sizeof(alloc->pages[0]),
 				GFP_KERNEL);
-	if (alloc->pages == NULL) {
+	if (!alloc->pages) {
 		ret = -ENOMEM;
 		failure_string = "alloc page array";
 		goto err_alloc_pages_failed;
 	}
 
-	for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
-		alloc->pages[i].alloc = alloc;
-		INIT_LIST_HEAD(&alloc->pages[i].lru);
-	}
-
 	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
 	if (!buffer) {
 		ret = -ENOMEM;
@@ -948,20 +955,22 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 		int i;
 
 		for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
+			struct page *page;
 			bool on_lru;
 
-			if (!alloc->pages[i].page_ptr)
+			page = binder_get_installed_page(alloc, i);
+			if (!page)
 				continue;
 
 			on_lru = list_lru_del(&binder_freelist,
-					      &alloc->pages[i].lru,
-					      page_to_nid(alloc->pages[i].page_ptr),
+					      &page->lru,
+					      page_to_nid(page),
 					      NULL);
 			binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 				     "%s: %d: page %d %s\n",
 				     __func__, alloc->pid, i,
 				     on_lru ? "on lru" : "active");
-			__free_page(alloc->pages[i].page_ptr);
+			__free_page(page);
 			page_count++;
 		}
 	}
@@ -1010,7 +1019,7 @@ void binder_alloc_print_allocated(struct seq_file *m,
 void binder_alloc_print_pages(struct seq_file *m,
 			      struct binder_alloc *alloc)
 {
-	struct binder_lru_page *page;
+	struct page *page;
 	int i;
 	int active = 0;
 	int lru = 0;
@@ -1023,8 +1032,8 @@ void binder_alloc_print_pages(struct seq_file *m,
 	 */
 	if (binder_alloc_get_vma(alloc) != NULL) {
 		for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
-			page = &alloc->pages[i];
-			if (!page->page_ptr)
+			page = binder_get_installed_page(alloc, i);
+			if (!page)
 				free++;
 			else if (list_empty(&page->lru))
 				active++;
@@ -1084,11 +1093,10 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 				       void *cb_arg)
 	__must_hold(lock)
 {
-	struct binder_lru_page *page = container_of(item, typeof(*page), lru);
-	struct binder_alloc *alloc = page->alloc;
+	struct page *page = container_of(item, typeof(*page), lru);
+	struct binder_alloc *alloc = (struct binder_alloc *)page->private;
 	struct mm_struct *mm = alloc->mm;
 	struct vm_area_struct *vma;
-	struct page *page_to_free;
 	unsigned long page_addr;
 	size_t index;
 
@@ -1098,10 +1106,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		goto err_mmap_read_lock_failed;
 	if (!mutex_trylock(&alloc->mutex))
 		goto err_get_alloc_mutex_failed;
-	if (!page->page_ptr)
-		goto err_page_already_freed;
 
-	index = page - alloc->pages;
+	index = page->index;
 	page_addr = alloc->buffer + index * PAGE_SIZE;
 
 	vma = vma_lookup(mm, page_addr);
@@ -1110,8 +1116,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 
 	trace_binder_unmap_kernel_start(alloc, index);
 
-	page_to_free = page->page_ptr;
-	page->page_ptr = NULL;
+	binder_set_installed_page(alloc, index, NULL);
 
 	trace_binder_unmap_kernel_end(alloc, index);
 
@@ -1129,13 +1134,12 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	mutex_unlock(&alloc->mutex);
 	mmap_read_unlock(mm);
 	mmput_async(mm);
-	__free_page(page_to_free);
+	__free_page(page);
 
 	spin_lock(lock);
 	return LRU_REMOVED_RETRY;
 
 err_invalid_vma:
-err_page_already_freed:
 	mutex_unlock(&alloc->mutex);
 err_get_alloc_mutex_failed:
 	mmap_read_unlock(mm);
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index a5181916942e..5c2473e95494 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -58,18 +58,6 @@ struct binder_buffer {
 	int pid;
 };
 
-/**
- * struct binder_lru_page - page object used for binder shrinker
- * @page_ptr: pointer to physical page in mmap'd space
- * @lru:      entry in binder_freelist
- * @alloc:    binder_alloc for a proc
- */
-struct binder_lru_page {
-	struct list_head lru;
-	struct page *page_ptr;
-	struct binder_alloc *alloc;
-};
-
 /**
  * struct binder_alloc - per-binder proc state for binder allocator
  * @mutex:              protects binder_alloc fields
@@ -83,7 +71,7 @@ struct binder_lru_page {
  * @allocated_buffers:  rb tree of allocated buffers sorted by address
  * @free_async_space:   VA space available for async buffers. This is
  *                      initialized at mmap time to 1/2 the full VA space
- * @pages:              array of binder_lru_page
+ * @pages:              array of struct page *
  * @buffer_size:        size of address space specified via mmap
  * @pid:                pid for associated binder_proc (invariant after init)
  * @pages_high:         high watermark of offset in @pages
@@ -104,7 +92,7 @@ struct binder_alloc {
 	struct rb_root free_buffers;
 	struct rb_root allocated_buffers;
 	size_t free_async_space;
-	struct binder_lru_page *pages;
+	struct page **pages;
 	size_t buffer_size;
 	int pid;
 	size_t pages_high;
diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
index 81442fe20a69..c6941b9abad9 100644
--- a/drivers/android/binder_alloc_selftest.c
+++ b/drivers/android/binder_alloc_selftest.c
@@ -105,10 +105,10 @@ static bool check_buffer_pages_allocated(struct binder_alloc *alloc,
 	page_addr = buffer->user_data;
 	for (; page_addr < end; page_addr += PAGE_SIZE) {
 		page_index = (page_addr - alloc->buffer) / PAGE_SIZE;
-		if (!alloc->pages[page_index].page_ptr ||
-		    !list_empty(&alloc->pages[page_index].lru)) {
+		if (!alloc->pages[page_index] ||
+		    !list_empty(&alloc->pages[page_index]->lru)) {
 			pr_err("expect alloc but is %s at page index %d\n",
-			       alloc->pages[page_index].page_ptr ?
+			       alloc->pages[page_index] ?
 			       "lru" : "free", page_index);
 			return false;
 		}
@@ -148,10 +148,10 @@ static void binder_selftest_free_buf(struct binder_alloc *alloc,
 		 * if binder shrinker ran during binder_alloc_free_buf
 		 * calls above.
 		 */
-		if (list_empty(&alloc->pages[i].lru)) {
+		if (list_empty(&alloc->pages[i]->lru)) {
 			pr_err_size_seq(sizes, seq);
 			pr_err("expect lru but is %s at page index %d\n",
-			       alloc->pages[i].page_ptr ? "alloc" : "free", i);
+			       alloc->pages[i] ? "alloc" : "free", i);
 			binder_selftest_failures++;
 		}
 	}
@@ -168,9 +168,9 @@ static void binder_selftest_free_page(struct binder_alloc *alloc)
 	}
 
 	for (i = 0; i < (alloc->buffer_size / PAGE_SIZE); i++) {
-		if (alloc->pages[i].page_ptr) {
+		if (alloc->pages[i]) {
 			pr_err("expect free but is %s at page index %d\n",
-			       list_empty(&alloc->pages[i].lru) ?
+			       list_empty(&alloc->pages[i]->lru) ?
 			       "alloc" : "lru", i);
 			binder_selftest_failures++;
 		}
-- 
2.47.0.338.g60cca15819-goog


