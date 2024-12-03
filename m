Return-Path: <linux-kernel+bounces-430253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3515F9E2E7F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA343280D67
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADBE20B21B;
	Tue,  3 Dec 2024 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NIHEcfGw"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052F1209F5B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262930; cv=none; b=ZFOs2HphX0l4+ycV3gImj/aRC9NS+gVvu0tAsKQaibc41oZVQ/QJeTlg++z+KiAOTmQWyFiCjPJYWe0t73ED1Ae/2YbzFw8dETBIxCNDbeHtswXISIpYUbEwrsUzw3inc70IuD+o5tfSLixH1xWYcFOj76RC9jXYNGqZZf8zjHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262930; c=relaxed/simple;
	bh=msK5KcGQmHUu2fA38/levDh0PvlQn0YxxPRKG6VndmU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hV1jOaFWoNp4NQ1WgYY9vT/KgW1rRrfKXKbZgsu2AY8XBA7AAyRRomN3scaaIBB93HgcPt72Bj/YYrkWOgwHDIKrp6sXfRXRthJekckmeJclqyRrwBwpH56rsyb21IWuJXVimkHWHJpSxaB+qD+H4+FYQ8PYWKuIHqUO31AoLvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NIHEcfGw; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7254237c888so5601329b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733262926; x=1733867726; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Fa+MnaWny57URM8+FFXTKSPVzeXZgh6NYzjgpD0ip0=;
        b=NIHEcfGw0QIUGQFMBIV2S56pVyJZmGJU9YJ+5mkpZ163hF0uJaXKU09ZkPhZ9lCbvf
         Wf1GW6YlIOBPykU9O+xX3cRvCPUCQTl3cGrnXHPrEDfdx9A4Ta6ocVY6KcfTc8jATFZG
         W253tD2u8nBlAQGHPMUAi9b+dnf4pMU8umzsWpL5apN9IhG6HlRl7g+/8emY4WKI3I7I
         B/oRSNM5Fv69oN/t3qdHIH8bus6MpzMfRBbvojy7jFylEUPmLBY+THlZtO7zXgBTZV3j
         EU+ZETMO2325QOG7T+Xo1W1zk/PdKJVs7i+Msq/lPu0pKj7aiPaO2EEy8zFs5LjnR+pv
         SnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262926; x=1733867726;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Fa+MnaWny57URM8+FFXTKSPVzeXZgh6NYzjgpD0ip0=;
        b=G0at+w/SBB7DqReKnrtntuMRs2egZovOUwu9ITQUH4vYTXfEq3kuhCVE0TgCV5Dh3Q
         xnvXpD5b4rK+GFxpwtpUKu2V8qEmqFaMPfv+wJOT1R87U6Pae+R8RUe1IrqDONyX1e9V
         oHWhUy5lQCc85JlrASxe+hc8x/iRiSZ/rRZeIlE3Vjnes0rQvYaVXMl7ofcyIYbULI1c
         UXowEBttA5lQ874O5m1Xy+asMZdUkDykzeCg/LthkgsahZol0Mj7YzYo8rgZAPPtu2LD
         7h+8xS/ihqZ3DWDTF5OvM/7RetZmjlSbglTpDfBLPYiY7PIwqZz7+7nSQBmTFRWUWnDh
         ywvw==
X-Gm-Message-State: AOJu0YxKc/4bgytzZWbchwBwlRHFYU8Gx+KLdLHq5pKwXAPtEJ45mxVk
	6pmYBzUlhaO4ivo2TYu9RncwREAIrbZREULW8dcXl8z7qSBs9NOSVIO5Cv/FVEWkkbj0NZf0X9H
	7uaLJgxSL2Q==
X-Google-Smtp-Source: AGHT+IEqqiODcQspNsL6jtBxOiOYh6104GsAAwyMN2VyJbnGTiB/0lwaTbuQqREg4UwVYng36fBASdmJIATpgw==
X-Received: from pfau12.prod.google.com ([2002:a05:6a00:aa8c:b0:724:edad:f712])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:8889:0:b0:71e:4786:98ee with SMTP id d2e1a72fcca58-7257fcccc8dmr5274675b3a.21.1733262926183;
 Tue, 03 Dec 2024 13:55:26 -0800 (PST)
Date: Tue,  3 Dec 2024 21:54:39 +0000
In-Reply-To: <20241203215452.2820071-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203215452.2820071-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203215452.2820071-6-cmllamas@google.com>
Subject: [PATCH v6 5/9] binder: replace alloc->vma with alloc->mapped
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
 drivers/android/binder_alloc.c          | 48 +++++++++++++------------
 drivers/android/binder_alloc.h          |  6 ++--
 drivers/android/binder_alloc_selftest.c |  2 +-
 3 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index fd82ecefd961..60ca0e541d6f 100644
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
 				      unsigned long index)
 {
@@ -271,7 +284,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 
 	mmap_read_lock(alloc->mm);
 	vma = vma_lookup(alloc->mm, addr);
-	if (!vma || vma != alloc->vma) {
+	if (!vma || !binder_alloc_is_mapped(alloc)) {
 		binder_free_page(page);
 		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
 		ret = -ESRCH;
@@ -379,20 +392,6 @@ static void binder_lru_freelist_del(struct binder_alloc *alloc,
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
@@ -626,7 +625,7 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 	int ret;
 
 	/* Check binder_alloc is fully initialized */
-	if (!binder_alloc_get_vma(alloc)) {
+	if (!binder_alloc_is_mapped(alloc)) {
 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
 				   "%d: binder_alloc_buf, no vma\n",
 				   alloc->pid);
@@ -908,7 +907,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	alloc->free_async_space = alloc->buffer_size / 2;
 
 	/* Signal binder_alloc is fully initialized */
-	binder_alloc_set_vma(alloc, vma);
+	binder_alloc_set_mapped(alloc, true);
 
 	return 0;
 
@@ -938,7 +937,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 
 	buffers = 0;
 	mutex_lock(&alloc->mutex);
-	BUG_ON(alloc->vma);
+	BUG_ON(alloc->mapped);
 
 	while ((n = rb_first(&alloc->allocated_buffers))) {
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
@@ -1044,7 +1043,7 @@ void binder_alloc_print_pages(struct seq_file *m,
 	 * Make sure the binder_alloc is fully initialized, otherwise we might
 	 * read inconsistent state.
 	 */
-	if (binder_alloc_get_vma(alloc) != NULL) {
+	if (binder_alloc_is_mapped(alloc)) {
 		for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
 			page = binder_get_installed_page(alloc, i);
 			if (!page)
@@ -1084,12 +1083,12 @@ int binder_alloc_get_allocated_count(struct binder_alloc *alloc)
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
@@ -1125,7 +1124,12 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	page_addr = alloc->buffer + index * PAGE_SIZE;
 
 	vma = vma_lookup(mm, page_addr);
-	if (vma && vma != binder_alloc_get_vma(alloc))
+	/*
+	 * Since a binder_alloc can only be mapped once, we ensure
+	 * the vma corresponds to this mapping by checking whether
+	 * the binder_alloc is still mapped.
+	 */
+	if (vma && !binder_alloc_is_mapped(alloc))
 		goto err_invalid_vma;
 
 	trace_binder_unmap_kernel_start(alloc, index);
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index d71f99189ef5..3ebb12afd4de 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -82,8 +82,6 @@ static inline struct list_head *page_to_lru(struct page *p)
 /**
  * struct binder_alloc - per-binder proc state for binder allocator
  * @mutex:              protects binder_alloc fields
- * @vma:                vm_area_struct passed to mmap_handler
- *                      (invariant after mmap)
  * @mm:                 copy of task->mm (invariant after open)
  * @buffer:             base of per-proc address space mapped via mmap
  * @buffers:            list of all buffers for this proc
@@ -96,6 +94,8 @@ static inline struct list_head *page_to_lru(struct page *p)
  * @buffer_size:        size of address space specified via mmap
  * @pid:                pid for associated binder_proc (invariant after init)
  * @pages_high:         high watermark of offset in @pages
+ * @mapped:             whether the vm area is mapped, each binder instance is
+ *                      allowed a single mapping throughout its lifetime
  * @oneway_spam_detected: %true if oneway spam detection fired, clear that
  * flag once the async buffer has returned to a healthy state
  *
@@ -106,7 +106,6 @@ static inline struct list_head *page_to_lru(struct page *p)
  */
 struct binder_alloc {
 	struct mutex mutex;
-	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	unsigned long buffer;
 	struct list_head buffers;
@@ -117,6 +116,7 @@ struct binder_alloc {
 	size_t buffer_size;
 	int pid;
 	size_t pages_high;
+	bool mapped;
 	bool oneway_spam_detected;
 };
 
diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
index a4c650843bee..6a64847a8555 100644
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


