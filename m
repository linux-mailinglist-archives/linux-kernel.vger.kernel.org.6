Return-Path: <linux-kernel+bounces-402244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F609C2563
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C00C1C22F2D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297711C1F39;
	Fri,  8 Nov 2024 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHZMPpQZ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1E61AA1E9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093082; cv=none; b=IOTfwdc92mGWUliet60lf+THq9SfxKFEQyfTKeS3RmLBRZ3gNJFMOykOGyttetuvEubjWpsWPpyaw+aMNVaCSOgUO02ac2cL9Ci2JjZoaOObAidasbF5LE/lqAhpLHWq5Si4q8jePa+JjQZ9yjbuTT8wfVrU1mzcg2Py15i2y4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093082; c=relaxed/simple;
	bh=iC9h1z38ITthByFqWXDG6gmMON/YuVdoJXgCqGTpz1A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tSa0IxCD0eXMLJmL27RlsO7MQkBaX03HNh7H1ezNf0NuttFTZI3K20lyjcVKhlP78H6TPRiCm9zdMdx8H8CGFqPYnY/34VNcSjH9BdzO/P9wM5+mf4re9vGg0t+6+LR/8PTvz4gRMT3cK+4hSDxr3et9CgEJkGiy07Ey/9XNk04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MHZMPpQZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e33152c8225so5242122276.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 11:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731093077; x=1731697877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mamCdB/fpcXnWfOHApiuvYC+ri2/tZGlXfY0LPaAxUA=;
        b=MHZMPpQZ+l9TjA6Gv4KQbn8iHAltyUTvTygyLCv0oWar3OVB4b+SYuFAU8X92DiHIb
         sX5U0CfzjHXGYsHXOw1NONILVezlUW54RyudrMY1mo2Ju0MMWZ0L+o9QrbzPR3bVa9UX
         df7jRRlhPcg412/IO7wY3yypvKXTRfILdgqnu7GNDPbxWfO4YwdMytt9xOY13BrcBfxc
         rk1osIHO79si+a9AtmkcANU+YWyG8oCn/siA735d4t7L1klJNv06zqpMZkEJlUkFGZae
         jQFxPabm4YhBWFYtCZEcyBNq+oaMWEn+WvGmPQdQDKjwOOHu3ZM/0TXfZ5tnRoN1E3fS
         +wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731093077; x=1731697877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mamCdB/fpcXnWfOHApiuvYC+ri2/tZGlXfY0LPaAxUA=;
        b=cZIgT3XxIjlk85f6aH4gohnf2pdVkRmP5Vi7ARCUYeFI6GNr+bheVl7hMuHVSUw9T5
         /F3raKA2vOvjtPpl+V3ez+KZEst5e9wAfzJOA+iyq86pubHWKy9Fz3HayvZy2aEIep5t
         lHQgfstTjCMnN+QC+9ucrsVZ/nv9uspAk8MrrSxUuzQNE4iQpUQ5zClXYEAysB5jmhjy
         cyeZWCRz22va0EGXVKQxw56i91slD/sDCCePPTjAqcBm+TyJfoGopqfdd9viTdeikIyJ
         WW8hO7PAs1ttvxJntrU+V/wRPLgrb+BwHXhRheIq93/PcHKcaYHjKm6Oi/xRXX41qI/D
         E1UQ==
X-Gm-Message-State: AOJu0Yw01N7SGrU7MrR4k3RPAGCwGQG2i4dPv8EJONuSs+EW5ju3h8s3
	x8aREUO03fAAjw8mPwVbEh907MSbqShORlH9Vj94y8qxAtFb13lmo7Hd9vYsHwN9etJj7QbiJDe
	IpQ3lrVU+Cg==
X-Google-Smtp-Source: AGHT+IEzyPkmUSowVZatkrS0Zy0Ne1u4xKp/AkzwqmQVtCNYZUgZw6mTes3ZfJ+vodn/vhR3B+oCVgjgHeHuXg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a5b:c09:0:b0:e16:68fb:f261 with SMTP id
 3f1490d57ef6-e337f8ed425mr2693276.5.1731093077577; Fri, 08 Nov 2024 11:11:17
 -0800 (PST)
Date: Fri,  8 Nov 2024 19:10:47 +0000
In-Reply-To: <20241108191057.3288442-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108191057.3288442-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241108191057.3288442-6-cmllamas@google.com>
Subject: [PATCH v3 5/8] binder: replace alloc->vma with alloc->mapped
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
index 457fa937aa8f..a6697b5a4b2f 100644
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
@@ -364,20 +377,6 @@ static void binder_lru_freelist_del(struct binder_alloc *alloc,
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
@@ -611,7 +610,7 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 	int ret;
 
 	/* Check binder_alloc is fully initialized */
-	if (!binder_alloc_get_vma(alloc)) {
+	if (!binder_alloc_is_mapped(alloc)) {
 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
 				   "%d: binder_alloc_buf, no vma\n",
 				   alloc->pid);
@@ -893,7 +892,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	alloc->free_async_space = alloc->buffer_size / 2;
 
 	/* Signal binder_alloc is fully initialized */
-	binder_alloc_set_vma(alloc, vma);
+	binder_alloc_set_mapped(alloc, true);
 
 	return 0;
 
@@ -923,7 +922,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 
 	buffers = 0;
 	mutex_lock(&alloc->mutex);
-	BUG_ON(alloc->vma);
+	BUG_ON(alloc->mapped);
 
 	while ((n = rb_first(&alloc->allocated_buffers))) {
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
@@ -1029,7 +1028,7 @@ void binder_alloc_print_pages(struct seq_file *m,
 	 * Make sure the binder_alloc is fully initialized, otherwise we might
 	 * read inconsistent state.
 	 */
-	if (binder_alloc_get_vma(alloc) != NULL) {
+	if (binder_alloc_is_mapped(alloc)) {
 		for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
 			page = binder_get_installed_page(alloc, i);
 			if (!page)
@@ -1069,12 +1068,12 @@ int binder_alloc_get_allocated_count(struct binder_alloc *alloc)
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
@@ -1110,7 +1109,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
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
2.47.0.277.g8800431eea-goog


