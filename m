Return-Path: <linux-kernel+bounces-397077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EA59BD670
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E051F25BB2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755C2214418;
	Tue,  5 Nov 2024 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ITn8g//6"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC95215F58
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730836997; cv=none; b=FhKEr0RdHSUt/XYJU0nwKtx0OZ3HP8gr/zclKmoMfePT1ILGF18tPAWiOtGRE9uSMfPLV/nCFi0scRtVMvc9IltRmDBkaW+q+j33g1e4uJHaTGYkLbo3+gOTe564stx9lMidit7oRLDaZe1U/TnYN1GIHis4g5risHr2xTJH4Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730836997; c=relaxed/simple;
	bh=WaEk+3ckmsAXcx7hqvxbBJTwANFNujzpQv6UwLeqpaA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EqGi2vD5Er9uRveu8/jPxECYuMxLRqeobqUu/UmBtHogRLqUYIfsO4JfL61zs5rA9c2sTryxIznTuwZBibnvZGcQiUO2zFZK49ejsQ0Lae1Eyx6lf+biubuYrqCnYaUEn6rez4V1XvAuox5ynFQgkV6yrPoJvfsPxTpjsE47bCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ITn8g//6; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7d4dee4dfdcso5589609a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 12:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730836995; x=1731441795; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=swNgjjE0ZLrgGShA+Kd7LNNDUbW+nWT8OeDDtuwNCAQ=;
        b=ITn8g//6wNkfCNUTex0bbeF02fn8jm/dM4ECRhp9MA1lyWDxev5+f1obyg2YW8gh86
         7D8wS7JPZvWQUbobdsCXx0/YMxm0u7Ud1ZoNbEXZ2a+XEYtpBitDqTn+nKbS/2bG+s8w
         4MyY5yiAXTQeoOLhVvdwsQrVgUKqAPA5YV92ttuRiCeRHWvu0PvihKpedSlP0jvrK4tb
         5GHq7aWdOJ3I3Ic9tZQ3Njkp04GIOuQWn6ScRSrtBGwfzrGJ2Reknvpj3nzFFgdR0cIO
         g/rHju6/N0K9rKr+PIgpThiBeP/FhbvtdmOfN5F5mEDS5S+syg4ghyhdoBhirRsWYAmD
         rvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730836995; x=1731441795;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swNgjjE0ZLrgGShA+Kd7LNNDUbW+nWT8OeDDtuwNCAQ=;
        b=m7/V2arV50O8UtMGOrEKDCb2ouK8xO7xV8Sm3nI+hYYMB1aLpG03NTkTX8SgqFNu9f
         uC/M1rJVA583Y/LzDwEaIQPXBqiASi41hp8549qTuqLP/1O5oyBrX5QkiR8oLvSe94jf
         OIoa0VRLE2VZgsvG2aU6hw1q2RZXdD/PsYfetimbkRN7rSQ7Dv9YBSj8tLR8kr5I1re3
         eY7ZoWJTsEWyYPSzbbmu3SwsN3i4GprrhyZe1IEyZy5uhwKRj++WArVa6iXRGdMssxr+
         dehenjATz86dljNO73gEqo2SMIUT+LK/5MMmenzAh4pkKieKiBAUsYu1StCCbBGu7iIr
         Oisw==
X-Gm-Message-State: AOJu0YznWXrVcoj9ATnnP1Q+oaqfT69DLI6iXIohI4uUfTvbUDbPMfDL
	jD8RLlQsrep1EUENLIaWR/mTgM0wLFKzjfrJ373RE5LBhD0HH4auEZDTh6Lcv5+diZJDvSjGHbb
	IlOXoJPsPeA==
X-Google-Smtp-Source: AGHT+IHTQNLyomE96dbPozAY01t5quiLGcy+qe47HB0rULHIbWbdwhfKJK8iZ7HdXiCz/h/MDd2RaOrlbGiPIA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:34c1:0:b0:7ea:c554:d831 with SMTP id
 41be03b00d2f7-7ee290c2030mr27795a12.7.1730836994957; Tue, 05 Nov 2024
 12:03:14 -0800 (PST)
Date: Tue,  5 Nov 2024 20:02:46 +0000
In-Reply-To: <20241105200258.2380168-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105200258.2380168-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105200258.2380168-5-cmllamas@google.com>
Subject: [PATCH 4/8] binder: remove struct binder_lru_page
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
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c          | 86 ++++++++++++-------------
 drivers/android/binder_alloc.h          | 16 +----
 drivers/android/binder_alloc_selftest.c | 14 ++--
 3 files changed, 49 insertions(+), 67 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 87011be7d8b7..98606e1ba687 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -177,25 +177,26 @@ struct binder_buffer *binder_alloc_prepare_to_free(struct binder_alloc *alloc,
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
 
@@ -204,16 +205,15 @@ static void binder_lru_freelist_add(struct binder_alloc *alloc,
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
 
@@ -222,7 +222,7 @@ static void binder_lru_freelist_add(struct binder_alloc *alloc,
 }
 
 static int binder_install_single_page(struct binder_alloc *alloc,
-				      struct binder_lru_page *lru_page,
+				      unsigned long index,
 				      unsigned long addr)
 {
 	struct vm_area_struct *vma;
@@ -240,6 +240,10 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		goto out;
 	}
 
+	page->private = (unsigned long)alloc;
+	INIT_LIST_HEAD(&page->lru);
+	page->index = index;
+
 	mmap_read_lock(alloc->mm);
 	vma = vma_lookup(alloc->mm, addr);
 	if (!vma || vma != alloc->vma) {
@@ -253,7 +257,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 	case -EBUSY:
 		/*
 		 * EBUSY is ok. Someone installed the pte first but the
-		 * lru_page->page_ptr has not been updated yet. Discard
+		 * alloc->pages[index] has not been updated yet. Discard
 		 * our page and look up the one already installed.
 		 */
 		ret = 0;
@@ -269,7 +273,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		fallthrough;
 	case 0:
 		/* Mark page installation complete and safe to use */
-		binder_set_installed_page(lru_page, page);
+		binder_set_installed_page(alloc, index, page);
 		page = NULL;
 		break;
 	default:
@@ -292,7 +296,6 @@ static int binder_install_buffer_pages(struct binder_alloc *alloc,
 				       struct binder_buffer *buffer,
 				       size_t size)
 {
-	struct binder_lru_page *page;
 	unsigned long start, final;
 	unsigned long page_addr;
 
@@ -304,14 +307,12 @@ static int binder_install_buffer_pages(struct binder_alloc *alloc,
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
 
@@ -325,8 +326,8 @@ static int binder_install_buffer_pages(struct binder_alloc *alloc,
 static void binder_lru_freelist_del(struct binder_alloc *alloc,
 				    unsigned long start, unsigned long end)
 {
-	struct binder_lru_page *page;
 	unsigned long page_addr;
+	struct page *page;
 
 	trace_binder_update_page_range(alloc, true, start, end);
 
@@ -335,14 +336,14 @@ static void binder_lru_freelist_del(struct binder_alloc *alloc,
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
 
@@ -763,11 +764,10 @@ static struct page *binder_alloc_get_page(struct binder_alloc *alloc,
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
@@ -842,7 +842,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 {
 	struct binder_buffer *buffer;
 	const char *failure_string;
-	int ret, i;
+	int ret;
 
 	if (unlikely(vma->vm_mm != alloc->mm)) {
 		ret = -EINVAL;
@@ -865,17 +865,12 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
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
@@ -951,20 +946,22 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
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
@@ -1013,7 +1010,7 @@ void binder_alloc_print_allocated(struct seq_file *m,
 void binder_alloc_print_pages(struct seq_file *m,
 			      struct binder_alloc *alloc)
 {
-	struct binder_lru_page *page;
+	struct page *page;
 	int i;
 	int active = 0;
 	int lru = 0;
@@ -1026,8 +1023,8 @@ void binder_alloc_print_pages(struct seq_file *m,
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
@@ -1087,8 +1084,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 				       void *cb_arg)
 	__must_hold(lock)
 {
-	struct binder_lru_page *page = container_of(item, typeof(*page), lru);
-	struct binder_alloc *alloc = page->alloc;
+	struct page *page = container_of(item, typeof(*page), lru);
+	struct binder_alloc *alloc = (struct binder_alloc *)page->private;
 	struct mm_struct *mm = alloc->mm;
 	struct vm_area_struct *vma;
 	struct page *page_to_free;
@@ -1101,10 +1098,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		goto err_mmap_read_lock_failed;
 	if (!mutex_trylock(&alloc->mutex))
 		goto err_get_alloc_mutex_failed;
-	if (!page->page_ptr)
-		goto err_page_already_freed;
 
-	index = page - alloc->pages;
+	index = page->index;
 	page_addr = alloc->buffer + index * PAGE_SIZE;
 
 	vma = vma_lookup(mm, page_addr);
@@ -1113,8 +1108,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 
 	trace_binder_unmap_kernel_start(alloc, index);
 
-	page_to_free = page->page_ptr;
-	page->page_ptr = NULL;
+	page_to_free = page;
+	binder_set_installed_page(alloc, index, NULL);
 
 	trace_binder_unmap_kernel_end(alloc, index);
 
@@ -1138,7 +1133,6 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
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
2.47.0.199.ga7371fff76-goog


