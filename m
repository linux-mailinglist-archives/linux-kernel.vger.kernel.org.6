Return-Path: <linux-kernel+bounces-414835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7616F9D2DFE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B252841E4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663BE1D5CF4;
	Tue, 19 Nov 2024 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fGCt+PKq"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08771D5ABA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041189; cv=none; b=mGQakq11iIllk94k3QnuDgLpg0ipdTrMsgsI0M++jl4Cp2gwgH3/x8SFv8jQel+JfH1waMPoKjaAzFsaE/Ruv2MZY4zRtzipa79NBowbDhhfhJSTCq+eg6aTBMk9hNLv7L/ELTB/EcFNSETpIp52mK/iX0hRHgHLTJX32AvVNC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041189; c=relaxed/simple;
	bh=aCbsPgQYe39IyV/L0vtNyOQErRLIEY5HkWRButB7hHg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c8OXTpx6B7ihwnEtZv4dwz/Ua4pv0rqSiy/CXWIkabPE22yIhO/2fiPuc1GsJIfc9r5w9KkW/ytyRatPy9YoXw93zfi4C3rLT/vD2qZuVaMMzLyb9QaeWI++0yaQrtvcdoDOVGIysJdG2xbtt0Uzsyjb1AH5TW3dbyPJa/13swU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fGCt+PKq; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ee7ccc0283so54420627b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732041187; x=1732645987; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9QP22PXIuQsNxGf7geF7h77az312wscnwPc4kqV8q1Y=;
        b=fGCt+PKqr5BswDKXXQmiiSBw89CQpYx/NlWZzIUW+Uhor1CdU7j0dsdGwH4yrMUvgf
         Y/a82vIi94lNUFuQKjRR24AS05/XAgqMRDCqt5qpt2p6qZiFi8iz7i+oHif5GuxEvgkU
         e0YWqRNIYtGiiGzHaqeC1rD4oJo7XVgIZQ8agzaV7bJJZf+BR4LkNBMT59TBcWAvtQOJ
         YQtgi9iZw3XcF9FGGua6ieFQWEUgKLTYC000+DlnUy3wnuAYdtf4DkUc5hDyGLaNeFM0
         k7tu+3bOeclXNNsfj9o+h3iWUA9fzuwTyRN3BaUYHx4NHoLf9Q2sRnSP1QzglAWcMoeW
         jW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732041187; x=1732645987;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9QP22PXIuQsNxGf7geF7h77az312wscnwPc4kqV8q1Y=;
        b=FyuOX1u3JPHJwD+voYS/gOQGCobx3lFhrh5u0PzOiqdA1fIteyDmhswMh2Y0zrOhmU
         dp0Ui/sclcLZOh1qJMao1aY2/6TBkx2rmvAOpTsdkl8dRDRvGabdntKsDGSZMk4Iua1c
         YgoJRlFs7powgTf0dvkf7H5wWfjD39o9xWJmuTMHfUcglnjIRoYPTrjk+nsZ7QtmUPz1
         SnxfOi8qyyt/zn61vkeffAA4hDAptRDqMSme5fWPhhRlsc6CHmGPOYYFWGcDfunuVr2R
         WyH/w/FZiu4bEDwWu9a/D+bprOrXOt+FLS77WJwy7W6ExQDFpKslgYGb8FCps2b6hJ00
         lTqw==
X-Gm-Message-State: AOJu0YyxryT8/j+9kXT2Bq4o52Bi9ADO4PhzA91WzVv8GZU0foZPShLA
	SEgUZj7q/LozTHN1d6T9F8HWi/nv0iZJ3CzaoxsLEyb+kCUEYALYml12U1KRrjyf/ugWFJMK8g/
	moOvNHY36zQ==
X-Google-Smtp-Source: AGHT+IGsvmrUdOiN1NBs0S1fEfmlHcEeE3qXgyFCfMVqguLbsutiKYNYA4aN1DygLUVHjM1DwhhvKk6XCqdwyA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:bb0e:0:b0:e38:2136:9482 with SMTP id
 3f1490d57ef6-e3826614e75mr12184276.10.1732041186532; Tue, 19 Nov 2024
 10:33:06 -0800 (PST)
Date: Tue, 19 Nov 2024 18:32:38 +0000
In-Reply-To: <20241119183250.3497547-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119183250.3497547-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241119183250.3497547-6-cmllamas@google.com>
Subject: [PATCH v4 5/9] binder: replace alloc->vma with alloc->mapped
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Minchan Kim <minchan@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

It is unsafe to use alloc->vma outside of the mmap_sem. Instead, add a
new boolean alloc->mapped to save the vma state (mapped or unmmaped) and
use this as a replacement for alloc->vma to validate several paths.

Using the alloc->vma caused several performance and security issues in
the past. Now that it has been replaced with either vm_lookup() or the
alloc->mapped state, we can finally remove it.

Cc: Minchan Kim <minchan@kernel.org>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c          | 43 ++++++++++++-------------
 drivers/android/binder_alloc.h          |  6 ++--
 drivers/android/binder_alloc_selftest.c |  2 +-
 3 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 7afb3f74b19f..faf27f963088 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -220,6 +220,19 @@ static void binder_lru_freelist_add(struct binder_alloc *alloc,
 	}
 }
 
+static inline
+void binder_alloc_set_mapped(struct binder_alloc *alloc, bool state)
+{
+	/* pairs with smp_load_acquire in binder_alloc_is_mapped() */
+	smp_store_release(&alloc->mapped, state);
+}
+
+static inline bool binder_alloc_is_mapped(struct binder_alloc *alloc)
+{
+	/* pairs with smp_store_release in binder_alloc_set_mapped() */
+	return smp_load_acquire(&alloc->mapped);
+}
+
 static struct page *binder_page_alloc(struct binder_alloc *alloc,
 				      unsigned long index,
 				      unsigned long addr)
@@ -257,7 +270,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 
 	mmap_read_lock(alloc->mm);
 	vma = vma_lookup(alloc->mm, addr);
-	if (!vma || vma != alloc->vma) {
+	if (!vma || !binder_alloc_is_mapped(alloc)) {
 		__free_page(page);
 		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
 		ret = -ESRCH;
@@ -365,20 +378,6 @@ static void binder_lru_freelist_del(struct binder_alloc *alloc,
 	}
 }
 
-static inline void binder_alloc_set_vma(struct binder_alloc *alloc,
-		struct vm_area_struct *vma)
-{
-	/* pairs with smp_load_acquire in binder_alloc_get_vma() */
-	smp_store_release(&alloc->vma, vma);
-}
-
-static inline struct vm_area_struct *binder_alloc_get_vma(
-		struct binder_alloc *alloc)
-{
-	/* pairs with smp_store_release in binder_alloc_set_vma() */
-	return smp_load_acquire(&alloc->vma);
-}
-
 static void debug_no_space_locked(struct binder_alloc *alloc)
 {
 	size_t largest_alloc_size = 0;
@@ -612,7 +611,7 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 	int ret;
 
 	/* Check binder_alloc is fully initialized */
-	if (!binder_alloc_get_vma(alloc)) {
+	if (!binder_alloc_is_mapped(alloc)) {
 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
 				   "%d: binder_alloc_buf, no vma\n",
 				   alloc->pid);
@@ -894,7 +893,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	alloc->free_async_space = alloc->buffer_size / 2;
 
 	/* Signal binder_alloc is fully initialized */
-	binder_alloc_set_vma(alloc, vma);
+	binder_alloc_set_mapped(alloc, true);
 
 	return 0;
 
@@ -924,7 +923,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 
 	buffers = 0;
 	mutex_lock(&alloc->mutex);
-	BUG_ON(alloc->vma);
+	BUG_ON(alloc->mapped);
 
 	while ((n = rb_first(&alloc->allocated_buffers))) {
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
@@ -1030,7 +1029,7 @@ void binder_alloc_print_pages(struct seq_file *m,
 	 * Make sure the binder_alloc is fully initialized, otherwise we might
 	 * read inconsistent state.
 	 */
-	if (binder_alloc_get_vma(alloc) != NULL) {
+	if (binder_alloc_is_mapped(alloc)) {
 		for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
 			page = binder_get_installed_page(alloc, i);
 			if (!page)
@@ -1070,12 +1069,12 @@ int binder_alloc_get_allocated_count(struct binder_alloc *alloc)
  * @alloc: binder_alloc for this proc
  *
  * Called from binder_vma_close() when releasing address space.
- * Clears alloc->vma to prevent new incoming transactions from
+ * Clears alloc->mapped to prevent new incoming transactions from
  * allocating more buffers.
  */
 void binder_alloc_vma_close(struct binder_alloc *alloc)
 {
-	binder_alloc_set_vma(alloc, NULL);
+	binder_alloc_set_mapped(alloc, false);
 }
 
 /**
@@ -1111,7 +1110,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	page_addr = alloc->buffer + index * PAGE_SIZE;
 
 	vma = vma_lookup(mm, page_addr);
-	if (vma && vma != binder_alloc_get_vma(alloc))
+	if (vma && !binder_alloc_is_mapped(alloc))
 		goto err_invalid_vma;
 
 	trace_binder_unmap_kernel_start(alloc, index);
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 5c2473e95494..a3c043cb8343 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -61,8 +61,6 @@ struct binder_buffer {
 /**
  * struct binder_alloc - per-binder proc state for binder allocator
  * @mutex:              protects binder_alloc fields
- * @vma:                vm_area_struct passed to mmap_handler
- *                      (invariant after mmap)
  * @mm:                 copy of task->mm (invariant after open)
  * @buffer:             base of per-proc address space mapped via mmap
  * @buffers:            list of all buffers for this proc
@@ -75,6 +73,8 @@ struct binder_buffer {
  * @buffer_size:        size of address space specified via mmap
  * @pid:                pid for associated binder_proc (invariant after init)
  * @pages_high:         high watermark of offset in @pages
+ * @mapped:             whether the vm area is mapped, each binder instance is
+ *                      allowed a single mapping throughout its lifetime
  * @oneway_spam_detected: %true if oneway spam detection fired, clear that
  * flag once the async buffer has returned to a healthy state
  *
@@ -85,7 +85,6 @@ struct binder_buffer {
  */
 struct binder_alloc {
 	struct mutex mutex;
-	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	unsigned long buffer;
 	struct list_head buffers;
@@ -96,6 +95,7 @@ struct binder_alloc {
 	size_t buffer_size;
 	int pid;
 	size_t pages_high;
+	bool mapped;
 	bool oneway_spam_detected;
 };
 
diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
index c6941b9abad9..2dda82d0d5e8 100644
--- a/drivers/android/binder_alloc_selftest.c
+++ b/drivers/android/binder_alloc_selftest.c
@@ -291,7 +291,7 @@ void binder_selftest_alloc(struct binder_alloc *alloc)
 	if (!binder_selftest_run)
 		return;
 	mutex_lock(&binder_selftest_lock);
-	if (!binder_selftest_run || !alloc->vma)
+	if (!binder_selftest_run || !alloc->mapped)
 		goto done;
 	pr_info("STARTED\n");
 	binder_selftest_alloc_offset(alloc, end_offset, 0);
-- 
2.47.0.338.g60cca15819-goog


