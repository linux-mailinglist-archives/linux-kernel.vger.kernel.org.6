Return-Path: <linux-kernel+bounces-439736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDEE9EB35E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39EDB281B87
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FC61BD00A;
	Tue, 10 Dec 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6USOp86"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BE91BBBE5
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841102; cv=none; b=cGrj5eJqSTjxBIE7XCQCCOKQNBLQyczRR5t99A+K7JHeNkf0i3TDNBqNEbNrT5Th4l9d1HolKW1lffEoYCrEcP8cNGehPTpo8bGycIohER32+CASygPktQJ1didUxhoLTDegV1TWfvr8GwCg/s7Eseb7Y7RPP64g6Bt+YxnD2aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841102; c=relaxed/simple;
	bh=wAaigS6NH6PqGwnudawemvFlr2fZzNAgsZbar9I9fyI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Klzvp1OOnXf0kBswsvLA7MZ648sEYtQ9yeQJMk7sNkkrdcZ1+CT7pK94FWCDFzvrdBEAZn691Lz5ZPSEjgIBOK9IvXlpQhPrKuGZzys/x5Lm1usX5Hi6LxGINjUgA/HFJ7rs3sbSQVGsNdSXh9l6vTSbd4oilvrqawRGexoofkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m6USOp86; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-728cd4fd607so732028b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733841100; x=1734445900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YWCl4bC7SjhlPyHHmXEehoZqdMhl2lWNKi3u9l92T3I=;
        b=m6USOp86eLuEOBoJSt1JYBHS+7FIsnx8p8K3zz90rZOPvfek4rF5ay4ijWDvXBOBvE
         PPK2QHUVMuL+8dmDDjgEFAR0Y4impFrsM/Vjg2NIvvNXBinrclHn0dERJXdJBeWrz0GA
         YAcFOE/kXN1CVfcDxXAD7GJHL+H84W/JSlgqNRWgqoLkLnjTRU8kitl/S6hSLa2Cs8iq
         k26UiwcQPQBzvlct2sr94XpPSLeV5pzOZOR1Cx2JFmifdknrnJitgMCeE+6PdroTbPbK
         XsRlsIEmL5EjyodRbZZxd1Woci2LQqoL8SiqpwggFcEWgETFoEcaMdoHgD7rkVoRxQP1
         m4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841100; x=1734445900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YWCl4bC7SjhlPyHHmXEehoZqdMhl2lWNKi3u9l92T3I=;
        b=WYxxDfitlPjwy+S4G65LgZz9WSd7jrNYhMf42eC37NJNf/efG3mswWL+tcotNDCSz0
         U4cSt4MxYzRIBfCGrF2rudmRyQ9vtqm0uRp00B72kGKxfIiCkhELxXPsAU2SWpjNAu8D
         6Po1ys+8jQB0rqvKOhhlfW980w9z0CSQgih1U1yY60mW+D9Ao0pPC8CYM/+6NJk62PR9
         f/XySh/MGCtOwd+VMAhmPMQFg71Fww6GdxUJEIUKs6eM1OpQFZRM2zoVDrWDNPngMmm2
         qyDl0vqgl6gtVaMJCmSaaBOqaR94s5EUNLlpLSo7Wrawo3tL3k0gpgv1iwV90HcT7EIA
         16Og==
X-Gm-Message-State: AOJu0YzndhL95NP9HPjoN6SJyEHtYcjN9G1Dl1sDJXlLN1cXmmWsEl0c
	B2EFFMa5p5ddP6nmwOWNrGJ+UywJw7kYAdE2EzWD7GeoRlXGfIbPVFGiAncwpRv+04AHC2F8xGS
	fQsU00guMEQ==
X-Google-Smtp-Source: AGHT+IEh/PkXy1LEUgu5KSVMEMcWZuT0t3eEeUXacUumQbdB4j717njIRwJpejhyFlmbB/EnZfxk0Brr3ljdtA==
X-Received: from pfbeg17.prod.google.com ([2002:a05:6a00:8011:b0:725:e46a:4fdd])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:88c2:0:b0:725:f18a:da42 with SMTP id d2e1a72fcca58-725f18adde0mr9564043b3a.2.1733841100019;
 Tue, 10 Dec 2024 06:31:40 -0800 (PST)
Date: Tue, 10 Dec 2024 14:31:00 +0000
In-Reply-To: <20241210143114.661252-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210143114.661252-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210143114.661252-5-cmllamas@google.com>
Subject: [PATCH v7 4/9] binder: store shrinker metadata under page->private
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Instead of pre-allocating an entire array of struct binder_lru_page in
alloc->pages, install the shrinker metadata under page->private. This
ensures the memory is allocated and released as needed alongside pages.

By converting the alloc->pages[] into an array of struct page pointers,
we can access these pages directly and only reference the shrinker
metadata where it's being used (e.g. inside the shrinker's callback).

Rename struct binder_lru_page to struct binder_shrinker_mdata to better
reflect its purpose. Add convenience functions that wrap the allocation
and freeing of pages along with their shrinker metadata.

Note I've reworked this patch to avoid using page->lru and page->index
directly, as Matthew pointed out that these are being removed [1].

Link: https://lore.kernel.org/all/ZzziucEm3np6e7a0@casper.infradead.org/ [1]
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c          | 130 ++++++++++++++----------
 drivers/android/binder_alloc.h          |  25 +++--
 drivers/android/binder_alloc_selftest.c |  14 +--
 3 files changed, 99 insertions(+), 70 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 1f02bec78451..3e30ac5b4861 100644
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
-				   &page->lru,
-				   page_to_nid(page->page_ptr),
+				   page_to_lru(page),
+				   page_to_nid(page),
 				   NULL);
 		WARN_ON(!ret);
 
@@ -220,8 +220,39 @@ static void binder_lru_freelist_add(struct binder_alloc *alloc,
 	}
 }
 
+static struct page *binder_page_alloc(struct binder_alloc *alloc,
+				      unsigned long index)
+{
+	struct binder_shrinker_mdata *mdata;
+	struct page *page;
+
+	page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
+	if (!page)
+		return NULL;
+
+	/* allocate and install shrinker metadata under page->private */
+	mdata = kzalloc(sizeof(*mdata), GFP_KERNEL);
+	if (!mdata) {
+		__free_page(page);
+		return NULL;
+	}
+
+	mdata->alloc = alloc;
+	mdata->page_index = index;
+	INIT_LIST_HEAD(&mdata->lru);
+	set_page_private(page, (unsigned long)mdata);
+
+	return page;
+}
+
+static void binder_free_page(struct page *page)
+{
+	kfree((struct binder_shrinker_mdata *)page_private(page));
+	__free_page(page);
+}
+
 static int binder_install_single_page(struct binder_alloc *alloc,
-				      struct binder_lru_page *lru_page,
+				      unsigned long index,
 				      unsigned long addr)
 {
 	struct vm_area_struct *vma;
@@ -232,9 +263,8 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 	if (!mmget_not_zero(alloc->mm))
 		return -ESRCH;
 
-	page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
+	page = binder_page_alloc(alloc, index);
 	if (!page) {
-		pr_err("%d: failed to allocate page\n", alloc->pid);
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -242,7 +272,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 	mmap_read_lock(alloc->mm);
 	vma = vma_lookup(alloc->mm, addr);
 	if (!vma || vma != alloc->vma) {
-		__free_page(page);
+		binder_free_page(page);
 		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
 		ret = -ESRCH;
 		goto unlock;
@@ -253,11 +283,11 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 	case -EBUSY:
 		/*
 		 * EBUSY is ok. Someone installed the pte first but the
-		 * lru_page->page_ptr has not been updated yet. Discard
+		 * alloc->pages[index] has not been updated yet. Discard
 		 * our page and look up the one already installed.
 		 */
 		ret = 0;
-		__free_page(page);
+		binder_free_page(page);
 		npages = get_user_pages_remote(alloc->mm, addr, 1,
 					       FOLL_NOFAULT, &page, NULL);
 		if (npages <= 0) {
@@ -269,10 +299,10 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		fallthrough;
 	case 0:
 		/* Mark page installation complete and safe to use */
-		binder_set_installed_page(lru_page, page);
+		binder_set_installed_page(alloc, index, page);
 		break;
 	default:
-		__free_page(page);
+		binder_free_page(page);
 		pr_err("%d: %s failed to insert page at offset %lx with %d\n",
 		       alloc->pid, __func__, addr - alloc->buffer, ret);
 		ret = -ENOMEM;
@@ -289,7 +319,6 @@ static int binder_install_buffer_pages(struct binder_alloc *alloc,
 				       struct binder_buffer *buffer,
 				       size_t size)
 {
-	struct binder_lru_page *page;
 	unsigned long start, final;
 	unsigned long page_addr;
 
@@ -301,14 +330,12 @@ static int binder_install_buffer_pages(struct binder_alloc *alloc,
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
 
@@ -322,8 +349,8 @@ static int binder_install_buffer_pages(struct binder_alloc *alloc,
 static void binder_lru_freelist_del(struct binder_alloc *alloc,
 				    unsigned long start, unsigned long end)
 {
-	struct binder_lru_page *page;
 	unsigned long page_addr;
+	struct page *page;
 
 	trace_binder_update_page_range(alloc, true, start, end);
 
@@ -332,14 +359,14 @@ static void binder_lru_freelist_del(struct binder_alloc *alloc,
 		bool on_lru;
 
 		index = (page_addr - alloc->buffer) / PAGE_SIZE;
-		page = &alloc->pages[index];
+		page = binder_get_installed_page(alloc, index);
 
-		if (page->page_ptr) {
+		if (page) {
 			trace_binder_alloc_lru_start(alloc, index);
 
 			on_lru = list_lru_del(&binder_freelist,
-					      &page->lru,
-					      page_to_nid(page->page_ptr),
+					      page_to_lru(page),
+					      page_to_nid(page),
 					      NULL);
 			WARN_ON(!on_lru);
 
@@ -760,11 +787,10 @@ static struct page *binder_alloc_get_page(struct binder_alloc *alloc,
 		(buffer->user_data - alloc->buffer);
 	pgoff_t pgoff = buffer_space_offset & ~PAGE_MASK;
 	size_t index = buffer_space_offset >> PAGE_SHIFT;
-	struct binder_lru_page *lru_page;
 
-	lru_page = &alloc->pages[index];
 	*pgoffp = pgoff;
-	return lru_page->page_ptr;
+
+	return alloc->pages[index];
 }
 
 /**
@@ -839,7 +865,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 {
 	struct binder_buffer *buffer;
 	const char *failure_string;
-	int ret, i;
+	int ret;
 
 	if (unlikely(vma->vm_mm != alloc->mm)) {
 		ret = -EINVAL;
@@ -862,17 +888,12 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
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
@@ -948,20 +969,22 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
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
+					      page_to_lru(page),
+					      page_to_nid(page),
 					      NULL);
 			binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 				     "%s: %d: page %d %s\n",
 				     __func__, alloc->pid, i,
 				     on_lru ? "on lru" : "active");
-			__free_page(alloc->pages[i].page_ptr);
+			binder_free_page(page);
 			page_count++;
 		}
 	}
@@ -1010,7 +1033,7 @@ void binder_alloc_print_allocated(struct seq_file *m,
 void binder_alloc_print_pages(struct seq_file *m,
 			      struct binder_alloc *alloc)
 {
-	struct binder_lru_page *page;
+	struct page *page;
 	int i;
 	int active = 0;
 	int lru = 0;
@@ -1023,10 +1046,10 @@ void binder_alloc_print_pages(struct seq_file *m,
 	 */
 	if (binder_alloc_get_vma(alloc) != NULL) {
 		for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
-			page = &alloc->pages[i];
-			if (!page->page_ptr)
+			page = binder_get_installed_page(alloc, i);
+			if (!page)
 				free++;
-			else if (list_empty(&page->lru))
+			else if (list_empty(page_to_lru(page)))
 				active++;
 			else
 				lru++;
@@ -1083,8 +1106,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 				       void *cb_arg)
 	__must_hold(&lru->lock)
 {
-	struct binder_lru_page *page = container_of(item, typeof(*page), lru);
-	struct binder_alloc *alloc = page->alloc;
+	struct binder_shrinker_mdata *mdata = container_of(item, typeof(*mdata), lru);
+	struct binder_alloc *alloc = mdata->alloc;
 	struct mm_struct *mm = alloc->mm;
 	struct vm_area_struct *vma;
 	struct page *page_to_free;
@@ -1097,10 +1120,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		goto err_mmap_read_lock_failed;
 	if (!mutex_trylock(&alloc->mutex))
 		goto err_get_alloc_mutex_failed;
-	if (!page->page_ptr)
-		goto err_page_already_freed;
 
-	index = page - alloc->pages;
+	index = mdata->page_index;
 	page_addr = alloc->buffer + index * PAGE_SIZE;
 
 	vma = vma_lookup(mm, page_addr);
@@ -1109,8 +1130,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 
 	trace_binder_unmap_kernel_start(alloc, index);
 
-	page_to_free = page->page_ptr;
-	page->page_ptr = NULL;
+	page_to_free = alloc->pages[index];
+	binder_set_installed_page(alloc, index, NULL);
 
 	trace_binder_unmap_kernel_end(alloc, index);
 
@@ -1128,12 +1149,11 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	mutex_unlock(&alloc->mutex);
 	mmap_read_unlock(mm);
 	mmput_async(mm);
-	__free_page(page_to_free);
+	binder_free_page(page_to_free);
 
 	return LRU_REMOVED_RETRY;
 
 err_invalid_vma:
-err_page_already_freed:
 	mutex_unlock(&alloc->mutex);
 err_get_alloc_mutex_failed:
 	mmap_read_unlock(mm);
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 33c5f971c0a5..d71f99189ef5 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -59,17 +59,26 @@ struct binder_buffer {
 };
 
 /**
- * struct binder_lru_page - page object used for binder shrinker
- * @page_ptr: pointer to physical page in mmap'd space
- * @lru:      entry in binder_freelist
- * @alloc:    binder_alloc for a proc
+ * struct binder_shrinker_mdata - binder metadata used to reclaim pages
+ * @lru:         LRU entry in binder_freelist
+ * @alloc:       binder_alloc owning the page to reclaim
+ * @page_index:  offset in @alloc->pages[] into the page to reclaim
  */
-struct binder_lru_page {
+struct binder_shrinker_mdata {
 	struct list_head lru;
-	struct page *page_ptr;
 	struct binder_alloc *alloc;
+	unsigned long page_index;
 };
 
+static inline struct list_head *page_to_lru(struct page *p)
+{
+	struct binder_shrinker_mdata *mdata;
+
+	mdata = (struct binder_shrinker_mdata *)page_private(p);
+
+	return &mdata->lru;
+}
+
 /**
  * struct binder_alloc - per-binder proc state for binder allocator
  * @mutex:              protects binder_alloc fields
@@ -83,7 +92,7 @@ struct binder_lru_page {
  * @allocated_buffers:  rb tree of allocated buffers sorted by address
  * @free_async_space:   VA space available for async buffers. This is
  *                      initialized at mmap time to 1/2 the full VA space
- * @pages:              array of binder_lru_page
+ * @pages:              array of struct page *
  * @buffer_size:        size of address space specified via mmap
  * @pid:                pid for associated binder_proc (invariant after init)
  * @pages_high:         high watermark of offset in @pages
@@ -104,7 +113,7 @@ struct binder_alloc {
 	struct rb_root free_buffers;
 	struct rb_root allocated_buffers;
 	size_t free_async_space;
-	struct binder_lru_page *pages;
+	struct page **pages;
 	size_t buffer_size;
 	int pid;
 	size_t pages_high;
diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
index 81442fe20a69..a4c650843bee 100644
--- a/drivers/android/binder_alloc_selftest.c
+++ b/drivers/android/binder_alloc_selftest.c
@@ -105,10 +105,10 @@ static bool check_buffer_pages_allocated(struct binder_alloc *alloc,
 	page_addr = buffer->user_data;
 	for (; page_addr < end; page_addr += PAGE_SIZE) {
 		page_index = (page_addr - alloc->buffer) / PAGE_SIZE;
-		if (!alloc->pages[page_index].page_ptr ||
-		    !list_empty(&alloc->pages[page_index].lru)) {
+		if (!alloc->pages[page_index] ||
+		    !list_empty(page_to_lru(alloc->pages[page_index]))) {
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
+		if (list_empty(page_to_lru(alloc->pages[i]))) {
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
+			       list_empty(page_to_lru(alloc->pages[i])) ?
 			       "alloc" : "lru", i);
 			binder_selftest_failures++;
 		}
-- 
2.47.0.338.g60cca15819-goog


