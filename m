Return-Path: <linux-kernel+bounces-397078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B40F79BD671
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C72283BF9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEFE215F78;
	Tue,  5 Nov 2024 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wN5B0Jsy"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BB0215C79
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837000; cv=none; b=bZxoX1IWwO6YwdN8awP43xoy/LFTnxFDax2JFl5NCU+rFTiUGLS2ETmZzd5bGqA2UF490Jg0NADs6Qmyetwwn+PZi+smCYqRgpR6qScWHN3iR9FbJFOhdaZXQCscZB4TNG6WZC7cXgJQHNe8B5AkblQWQO0kgH2tfQZPrPhnl2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837000; c=relaxed/simple;
	bh=4WMT7DSvO5PrYb9aiyo1LhXcfWflQ5QnPXv5axEuwRE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ExCQfMRia2fQopMnCPrhiuw2n2DL6qnmuUejAzPmxK2YHh8XAdqIMlOCt+cGnL9HR9cnm701V1OY8bRMM1A5ndE1XvApFqG+QHhr6xC0DjzdZbkcN07ch2s7eYMyJXGI3oFaWBEyHZYkpnS0NSv1YgE2bU6kxve0S5apg+ndvck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wN5B0Jsy; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea8a5e86e9so56429627b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 12:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730836998; x=1731441798; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1T3eDuGh4my+88RGLbqVsPKjKaUxdvhrUVyHawglmE8=;
        b=wN5B0JsyJd/89Ekq3jtMlw/e8YhmZDG8Xb5VNJkLD0yey1phEaga4smGhdJXnrixbj
         JFuNtRyt3UrRxTr0rJfvXDLprAy20Nuzxx50mkZR+yDCabilIvY6cYyR68SHbEr2sAU4
         uJLxZpZt3SGr//KkhpUlfWuASlEdGgOkzmtq4b52hYACO4Iq8C9YupWrdV5YMXdW9Wfe
         O6I6pLJXxafAtw+mCgPL+jt2WoKLyKtHa6BfCcW6B++UA+sR0BjKo3KGmstLwvv0H4n1
         ZQVPKIFK6vA8JT+AGNL2DVVVxDlPccPt7F6ukk6XuFWpRe6hdmfWPx24tnBw18Qtaq4h
         +10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730836998; x=1731441798;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1T3eDuGh4my+88RGLbqVsPKjKaUxdvhrUVyHawglmE8=;
        b=wNva/tXfSsqipXg1Olw44338o9zUY0e8Xy0L/IiWYnSegWHRS9XbUI+pFZC8iCXsny
         YWuVrKEzCWY+Mo9Sa4GEAwKwa7zgYDR4yDj43gfDsVQPTZXjPWQ1DmE/njDBuZoVmbZS
         hAdu8Bfk8OagdilVo1f296Z3KQEyXRhEPQ7xf0eq1HF17xDMrtSlf82xUJzA+tmf8oEu
         fEZ21OjsEE76fhnbMJIbRGPxCzFvtT6BRE5yfvW1IUJHdD2PoFIRXvewkiUnE1sWjmky
         wE2AGhv12zWSR2rav/LkHDEWwZ3B2lmsEDr+8Z2XcIPCUaUgye6q1IsJvR1RTpfCAU+Q
         k3yw==
X-Gm-Message-State: AOJu0YxUaobUqRFKEk8VjsOUEoKvGwqMPbIo52fJ31Lb1Wa4FQwqLAcC
	6J2Hx96NFrtVtWffNDLLmgLF64CZPr0W8lboHaOe+JS0rWS89ThUoRirTPES+6HgbOhw8m4Y+Vy
	zYJNay3b3uw==
X-Google-Smtp-Source: AGHT+IGCzflDdiS3gDFpeTWinGiE+gvnujs86BE/S/Czz64hAXB8e6C7dx9LQIf+i/lULwr+YSBJ3IbO81zShw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:690c:67ca:b0:6e3:d670:f62a with SMTP
 id 00721157ae682-6ea52518e31mr1333147b3.3.1730836997754; Tue, 05 Nov 2024
 12:03:17 -0800 (PST)
Date: Tue,  5 Nov 2024 20:02:47 +0000
In-Reply-To: <20241105200258.2380168-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105200258.2380168-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105200258.2380168-6-cmllamas@google.com>
Subject: [PATCH 5/8] binder: use alloc->mapped to save the vma state
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
use this to validate several paths. This change is in preparation for
removing the alloc->vma pointer in a subsequent patch.

Cc: Minchan Kim <minchan@kernel.org>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c          | 29 ++++++++++++++++++-------
 drivers/android/binder_alloc.h          |  2 ++
 drivers/android/binder_alloc_selftest.c |  2 +-
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 98606e1ba687..aa299cbdab92 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -221,6 +221,19 @@ static void binder_lru_freelist_add(struct binder_alloc *alloc,
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
 static int binder_install_single_page(struct binder_alloc *alloc,
 				      unsigned long index,
 				      unsigned long addr)
@@ -246,7 +259,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 
 	mmap_read_lock(alloc->mm);
 	vma = vma_lookup(alloc->mm, addr);
-	if (!vma || vma != alloc->vma) {
+	if (!vma || !binder_alloc_is_mapped(alloc)) {
 		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
 		ret = -ESRCH;
 		goto unlock;
@@ -603,7 +616,7 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 	int ret;
 
 	/* Check binder_alloc is fully initialized */
-	if (!binder_alloc_get_vma(alloc)) {
+	if (!binder_alloc_is_mapped(alloc)) {
 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
 				   "%d: binder_alloc_buf, no vma\n",
 				   alloc->pid);
@@ -885,7 +898,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	alloc->free_async_space = alloc->buffer_size / 2;
 
 	/* Signal binder_alloc is fully initialized */
-	binder_alloc_set_vma(alloc, vma);
+	binder_alloc_set_mapped(alloc, true);
 
 	return 0;
 
@@ -915,7 +928,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 
 	buffers = 0;
 	mutex_lock(&alloc->mutex);
-	BUG_ON(alloc->vma);
+	BUG_ON(alloc->mapped);
 
 	while ((n = rb_first(&alloc->allocated_buffers))) {
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
@@ -1021,7 +1034,7 @@ void binder_alloc_print_pages(struct seq_file *m,
 	 * Make sure the binder_alloc is fully initialized, otherwise we might
 	 * read inconsistent state.
 	 */
-	if (binder_alloc_get_vma(alloc) != NULL) {
+	if (binder_alloc_is_mapped(alloc)) {
 		for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
 			page = binder_get_installed_page(alloc, i);
 			if (!page)
@@ -1061,12 +1074,12 @@ int binder_alloc_get_allocated_count(struct binder_alloc *alloc)
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
@@ -1103,7 +1116,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	page_addr = alloc->buffer + index * PAGE_SIZE;
 
 	vma = vma_lookup(mm, page_addr);
-	if (vma && vma != binder_alloc_get_vma(alloc))
+	if (vma && !binder_alloc_is_mapped(alloc))
 		goto err_invalid_vma;
 
 	trace_binder_unmap_kernel_start(alloc, index);
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 5c2473e95494..89f6fa25c670 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -75,6 +75,7 @@ struct binder_buffer {
  * @buffer_size:        size of address space specified via mmap
  * @pid:                pid for associated binder_proc (invariant after init)
  * @pages_high:         high watermark of offset in @pages
+ * @mapped:             whether the vm area is mapped
  * @oneway_spam_detected: %true if oneway spam detection fired, clear that
  * flag once the async buffer has returned to a healthy state
  *
@@ -96,6 +97,7 @@ struct binder_alloc {
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
2.47.0.199.ga7371fff76-goog


