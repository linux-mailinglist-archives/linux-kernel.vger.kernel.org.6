Return-Path: <linux-kernel+bounces-399301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450F29BFD28
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F78283560
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53C9192B85;
	Thu,  7 Nov 2024 04:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6LeaMeF"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D530191461
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 04:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730952187; cv=none; b=FiRdMCsuBZPcL5nH0Xc+/9Cmw8zyJvbYnGnhf9OGET+YhKx6uo1KEtUDnAuCS9O6KxlDv2i4S4M3/mSkVu0IOjChiWzwtbfV0FAvYKFWow04Eg500MqK23fV3joFBg3TmTFtgdCF8I7pPjeg/YrT3SB4ecgUhoqIaLp0W9zyZV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730952187; c=relaxed/simple;
	bh=JrXBqOo2JhoPajzziRHF9ByUvQg4sbbU4dHzwS1P/dU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tkVERrXVTi7qoIn68iaKPuWO61Sv+vUU+nBlQR3oVwai6qZ/5ijyVODeKoqcMqLCA3J4mkMmRQDQhkbEXgfwag2bOZIc3JUmEeTatWM7Q0zzojDpgDfB+0NwGYv/2FoJPXP0lnWPXpPjBp43Pkod1pwXK1LYyiQRL8fWymFBdPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L6LeaMeF; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ed98536f95so421877a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 20:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730952185; x=1731556985; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VR6K66HQm7qElaALR5w1qrjpqMA/hWE59p9IBcioHF4=;
        b=L6LeaMeFj4vnZRDkCW/wrFJ8/I4mdFYxxwyf8BmIxBDmox7/ANQJUHMO0GnSOXtQp5
         4yHR+QkLsxg+NNFEnrQkPpja3hXCVne84koHrhcCo/nsl4tt9HowDnieiFxV+hjjl5LM
         vIKVhFXUfZLBYvjQLC8k14TZjLfeANn6cR0uMUzBSpCVeh1RxlB6b1LULVqp/wMBa6Xj
         2IytdmGeFrREpAajm3xxAk9+C1etK3Hwd7q3klkbZUDE4Sy/BZyl1+YI1dwqcnidctri
         +Gj1IcvAre+KzZwfRe6wwqLK5hPlTwGqgHEjPkXzhrMqPQJQQqvE8IGe5ZGV8zz/GtBX
         GJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730952185; x=1731556985;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VR6K66HQm7qElaALR5w1qrjpqMA/hWE59p9IBcioHF4=;
        b=pqpb3olGx98hgj+n5Lxzc6ZtPp2sogLtyVK84oe+JYy3Vw3tbQX1cPa+8PyoIQrgjw
         ZExifZwlkc2mVMvgWZ54lIM0vClxFpjs7VU8nFQqyVfvJybqcgqmRoa74jg2b/Jh5F/N
         MNGTH3sFgd0QcUjCl2R8E9i+jNMKvLLOQ/+Q+81SGND1pbm7acP/pauqhiJf7ZPg19Jm
         +rGwrQ+M1Y/1rgMlh2r9eYCpfP95MOu4OOjGE5B4MiVp/5YQT1/DN//nU0u4sYJ+2iUo
         gviYC0AZv59kZCYMSsnK8IpBMjK6c/agECsgcvhUJoiMnarIx0oyg6y8Ii9aV3PbUBsh
         fAXw==
X-Gm-Message-State: AOJu0Yz/8AbBAWWsjhzsHoSWRIzoXH0z7/xPDO/jLjTQKT9uLs6D5PA2
	GKagvoTnmtB2Ngwqg0FS+AEWUckqsa1Z5vhhL0pVt0oqdEM7c2Y0ywKA64vhXAVM4OiczSZywz6
	FQr3s2Y+rWw==
X-Google-Smtp-Source: AGHT+IGzTSkxUrm1MUGUYs5zsF8w+IstRURotU6hnUiYOUqUTJ7+iZFLzQYNfXpOOIrqTc04S4LmfsYOhni34Q==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:f50c:0:b0:7ea:f1c2:8a9 with SMTP id
 41be03b00d2f7-7f41c42f222mr5737a12.0.1730952184702; Wed, 06 Nov 2024 20:03:04
 -0800 (PST)
Date: Thu,  7 Nov 2024 04:02:27 +0000
In-Reply-To: <20241107040239.2847143-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107040239.2847143-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241107040239.2847143-6-cmllamas@google.com>
Subject: [PATCH v2 5/8] binder: use alloc->mapped to save the vma state
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
index 46789fa530a1..7239b92ef20a 100644
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
 		mmap_read_unlock(alloc->mm);
 		__free_page(page);
 		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
@@ -611,7 +624,7 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 	int ret;
 
 	/* Check binder_alloc is fully initialized */
-	if (!binder_alloc_get_vma(alloc)) {
+	if (!binder_alloc_is_mapped(alloc)) {
 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
 				   "%d: binder_alloc_buf, no vma\n",
 				   alloc->pid);
@@ -893,7 +906,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	alloc->free_async_space = alloc->buffer_size / 2;
 
 	/* Signal binder_alloc is fully initialized */
-	binder_alloc_set_vma(alloc, vma);
+	binder_alloc_set_mapped(alloc, true);
 
 	return 0;
 
@@ -923,7 +936,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 
 	buffers = 0;
 	mutex_lock(&alloc->mutex);
-	BUG_ON(alloc->vma);
+	BUG_ON(alloc->mapped);
 
 	while ((n = rb_first(&alloc->allocated_buffers))) {
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
@@ -1029,7 +1042,7 @@ void binder_alloc_print_pages(struct seq_file *m,
 	 * Make sure the binder_alloc is fully initialized, otherwise we might
 	 * read inconsistent state.
 	 */
-	if (binder_alloc_get_vma(alloc) != NULL) {
+	if (binder_alloc_is_mapped(alloc)) {
 		for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
 			page = binder_get_installed_page(alloc, i);
 			if (!page)
@@ -1069,12 +1082,12 @@ int binder_alloc_get_allocated_count(struct binder_alloc *alloc)
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
@@ -1111,7 +1124,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
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


