Return-Path: <linux-kernel+bounces-422730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE54D9D9D7C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1B7283956
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09A91DF726;
	Tue, 26 Nov 2024 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mdtLmVgk"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB911DE2A8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646438; cv=none; b=S1DHSLT4Pw/lEKrFpcqJg8XvSF+qQk4zGGd+1daC3+PByMwA/fR89nOXhTOd5dAOV680EI3icmflHdBH4qsAHWa773FIUYPJCn/9bBCwdB3nqFspF3eiRc9tK7gL+AOH1LlGlB8W63ZQHQ2x5VK5uYrcGAySI19fzcDnkRED/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646438; c=relaxed/simple;
	bh=+YueLBpXhct/5r9ESZ6mKeySFEVOoXDlJQzfwzcQSmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qQs1Lw583wPaFyDszSRpmXIJ8aGn7v2zenJ7Ill1lkbzQhsxBZooWmX4t9X5FvqiIRVBJblsGPtt1mYg9BIh/ln3xkyo1o1NE+/0NF8tMzPUBltkEkIFlXB7LmMMv3HrVqXEXJkxVj30a1n2jCmIzsicnlxGut/Az6PJZ0VkyAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mdtLmVgk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ea50590a43so6861289a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732646436; x=1733251236; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GUZblWB5BGFZ8fypeg+VMjlX//kBM9YKQ4HZ8RcYsmk=;
        b=mdtLmVgkw1p1ysoBb0298FvezmbAA3hFiNGB0DAYVCn0QtIm3PO1uovlYGVaHpqmG8
         5YElMl09/c7jJKBO1gdA22yT4itf4v/Xmn9jo8d7uphgohkjTLwJIwTtQO4YrU6dYSeL
         7HlVS27Q85RX9bPHv7u10gcU7gwT/Df/iTc/dz8THUYnyAP7rMUE7PPmAeIFwFX5Jmfy
         BQlC9lMOeT+XII/vPZhbXbqGvogkd6eh251KYnmSzetoIcBp5B0clxWsfX8Gd+hBiiql
         wDXgwnZv9pPhfmHuUW3OcLXX7lzalHabhCO77GAb0IISdHKv7xfVc9cHObiqWnhOPljX
         0xmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732646436; x=1733251236;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GUZblWB5BGFZ8fypeg+VMjlX//kBM9YKQ4HZ8RcYsmk=;
        b=bT4iwntqlVbuzXQkhCKrCNiHVr7ezv8GU4HFBs+NQRKQdrmV1xkBhQnFia7ms0s37F
         0eOhBt/UuKZ2aCb5G2bDmhfxJ3lcRf3lpRtoQd2j1B/1fGM5GV63V7fmQ31uLu26Fhbl
         zcqNjSJ8CfMFD/XYI3MzDRoWR4XNLfUQBK/fs4eGXzDZEVA5AyvNBuo7SlofFGmOwsSJ
         b24r0RfoI5ZB2J11Vl9AX5bZcc3NWstDow/nABqb0bpUmii+h8lwkkJAIysrFC63Mw9E
         yDbzPdF++OJYzXEN6ZKEk5yppbm+JEmI+Ku0tknKEszkRoCUyLsMlPquB2a0DXMaf8GJ
         jK3A==
X-Gm-Message-State: AOJu0YwUFMrliVMe+fDv2BLOiy3VgBkyRaH9wuQ/ANMOLy2o/YRDq5aa
	gt9GOOkWQZFs0ansEJ3zfKLmqrA3pDmahBpo7D1h/ujYA7NeNCyfiqROkfVw+b5HmstrlDryDQ3
	Bzuk/3ppK0w==
X-Google-Smtp-Source: AGHT+IGGU9v0gG3aucNpeuV+kJjhHCGgIknliWLmvGq4MlILCWcmMX78+slqY+1jay/q0sAu+QBml5Kf6WFLTg==
X-Received: from pjyd15.prod.google.com ([2002:a17:90a:dfcf:b0:2e0:5d64:e34c])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:544e:b0:2ea:7a22:5390 with SMTP id 98e67ed59e1d1-2ee08e9d43emr409621a91.5.1732646435778;
 Tue, 26 Nov 2024 10:40:35 -0800 (PST)
Date: Tue, 26 Nov 2024 18:40:08 +0000
In-Reply-To: <20241126184021.45292-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241126184021.45292-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241126184021.45292-6-cmllamas@google.com>
Subject: [PATCH v5 5/9] binder: replace alloc->vma with alloc->mapped
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
 drivers/android/binder_alloc.c          | 44 ++++++++++++-------------
 drivers/android/binder_alloc.h          |  6 ++--
 drivers/android/binder_alloc_selftest.c |  2 +-
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 21edd16bf23d..4c308d860478 100644
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
@@ -1110,7 +1109,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	page_addr = alloc->buffer + index * PAGE_SIZE;
 
 	vma = vma_lookup(mm, page_addr);
-	if (vma && vma != binder_alloc_get_vma(alloc))
+	/* ensure the vma corresponds to the binder mapping */
+	if (vma && !binder_alloc_is_mapped(alloc))
 		goto err_invalid_vma;
 
 	trace_binder_unmap_kernel_start(alloc, index);
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 69cce5bac1e1..634bc2e03729 100644
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


