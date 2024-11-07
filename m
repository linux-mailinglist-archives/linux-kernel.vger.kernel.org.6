Return-Path: <linux-kernel+bounces-399297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85CA9BFD24
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6856B283434
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF4115E97;
	Thu,  7 Nov 2024 04:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KOQc1kNn"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9A81822E5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 04:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730952176; cv=none; b=vC+XZcNE3fYvsLLPfMVGbzqiqxqtaOfEXCKMLxBF15MYVFypxlIEyuyTdrrD8/sCD6SuVEh7XkavkyulextZvMSnssgKZHSZFTbHGqe5Oaj88Ag2YSH4QmjnctCZ8F1pqTZ/MDPGmYDm3UEPuAEDMMFwwEkhMU0rmyy10CUUWhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730952176; c=relaxed/simple;
	bh=88wq84S5d5ZZylLA/CwWmKpip9hM35aPvuKn6ree2C4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rB5n68b51TIZSAgDQcscJTki8W5Un1Lr/TAEvWvZGvXtpiHnRLX+iCrr/o3jE9tDGIlUXg3BgkZcEvyKZnVgaIUVShDnRrIN90PgYqO1zv9TZ7vM0D5urCUjaWyzmV8SqWY5mHmUDEUEO+O70trBI3uVXwutwDyIeorjMTZGcVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KOQc1kNn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e3be80e9f3so1381106a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 20:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730952174; x=1731556974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWKTVNEJbjLhQRSA7l18YBajLooEVjsYG+y5xx907h4=;
        b=KOQc1kNn+dbdMmE6kqLTnjmH2rm8C4pPCIxg21CWux2k3rP6n5xc/TRdVaq4CCT6jy
         KrLRP5JaAydrHgtXz+KZAjZpAhAVy7/uTy2NYWAVscs403M4+9RmDTYX4cvOhlwU+08b
         KmpQohtJYjN0H3jLUH5KyHOKrufWX5FKdCBc/8yNh2fbDgetxb8Ur/EUh6P+lvSLmA+w
         BRrdi4jT3K5iwxPBa5kvY33y9LfDIYI1c1aScaz5DTCeJ2R5eljFuu/tix6K16LhyJhx
         2gLmS9JYUHYoh/XDMg47LiMu1hDJrW7pAa62Vd8BEyB3SgWmEqjQ0Co3sghHa5jJGUO/
         gUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730952174; x=1731556974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWKTVNEJbjLhQRSA7l18YBajLooEVjsYG+y5xx907h4=;
        b=LM4dr3Tokvc3dLoX/UnnTZF1O36PQAyQHoMk/ZU/bWWWHpa0H0RU6qP5DrErrGqrGu
         opgXdx285L2OXAbo6RBdrTWVfY4SED09c3nZh4B1zkbQXw1BYFv6UUefqeoHlklPI3cf
         xSxaw7RTe3k9dm4QDk4kvw6bXcvIMfgU7gv+uCMWe/pagilDgd+eIKJvkZHH8OExuapP
         5qaoW3oKXHNNyvz3zYr+GIeculzEXRZVzBxivHyc39lcevHGePLiZ+67P42zQCwbEnOo
         MREDqCP1Mj1uUItPvCO8t/w2tyzyx2A/T96EfeBCk5XBXJDxhnZf+4AbpxTKlEppqv7G
         Tyeg==
X-Gm-Message-State: AOJu0YyMyWQGxADVSe7f9DKPUPdGkUybrbOvIdTC0LsCpGFSxbfa/PWR
	wk8Y8F5WV3cnt0Z0CPD6RjAU1z+csFuTakQcGpbBMC3mV+BnWCq3/6+FOXmpm5bGmCG/ZKIrWxw
	8ebDbN0VypA==
X-Google-Smtp-Source: AGHT+IEzPCrIrGL9Dx4sFlXSN0sFKe0seRw7LeujrW3v443fa/h3ldKBBYNEwjvRvoQxuL792or67ngOprAnow==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:90b:110c:b0:2e3:112:22cd with SMTP id
 98e67ed59e1d1-2e9a4bc0d0bmr36705a91.0.1730952174545; Wed, 06 Nov 2024
 20:02:54 -0800 (PST)
Date: Thu,  7 Nov 2024 04:02:23 +0000
In-Reply-To: <20241107040239.2847143-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107040239.2847143-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241107040239.2847143-2-cmllamas@google.com>
Subject: [PATCH v2 1/8] Revert "binder: switch alloc->mutex to spinlock_t"
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Mukesh Ojha <quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

This reverts commit 7710e2cca32e7f3958480e8bd44f50e29d0c2509.

In preparation for concurrent page installations, restore the original
alloc->mutex which will serialize zap_page_range_single() against page
installations in subsequent patches (instead of the mmap_sem).

Cc: Mukesh Ojha <quic_mojha@quicinc.com>
[cmllamas: fix trivial conflict due to 2c10a20f5e84a]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 46 +++++++++++++++++-----------------
 drivers/android/binder_alloc.h | 10 ++++----
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index b3acbc4174fb..7241bf4a3ff2 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -169,9 +169,9 @@ struct binder_buffer *binder_alloc_prepare_to_free(struct binder_alloc *alloc,
 {
 	struct binder_buffer *buffer;
 
-	spin_lock(&alloc->lock);
+	mutex_lock(&alloc->mutex);
 	buffer = binder_alloc_prepare_to_free_locked(alloc, user_ptr);
-	spin_unlock(&alloc->lock);
+	mutex_unlock(&alloc->mutex);
 	return buffer;
 }
 
@@ -597,10 +597,10 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 	if (!next)
 		return ERR_PTR(-ENOMEM);
 
-	spin_lock(&alloc->lock);
+	mutex_lock(&alloc->mutex);
 	buffer = binder_alloc_new_buf_locked(alloc, next, size, is_async);
 	if (IS_ERR(buffer)) {
-		spin_unlock(&alloc->lock);
+		mutex_unlock(&alloc->mutex);
 		goto out;
 	}
 
@@ -608,7 +608,7 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 	buffer->offsets_size = offsets_size;
 	buffer->extra_buffers_size = extra_buffers_size;
 	buffer->pid = current->tgid;
-	spin_unlock(&alloc->lock);
+	mutex_unlock(&alloc->mutex);
 
 	ret = binder_install_buffer_pages(alloc, buffer, size);
 	if (ret) {
@@ -785,17 +785,17 @@ void binder_alloc_free_buf(struct binder_alloc *alloc,
 	 * We could eliminate the call to binder_alloc_clear_buf()
 	 * from binder_alloc_deferred_release() by moving this to
 	 * binder_free_buf_locked(). However, that could
-	 * increase contention for the alloc->lock if clear_on_free
-	 * is used frequently for large buffers. This lock is not
+	 * increase contention for the alloc mutex if clear_on_free
+	 * is used frequently for large buffers. The mutex is not
 	 * needed for correctness here.
 	 */
 	if (buffer->clear_on_free) {
 		binder_alloc_clear_buf(alloc, buffer);
 		buffer->clear_on_free = false;
 	}
-	spin_lock(&alloc->lock);
+	mutex_lock(&alloc->mutex);
 	binder_free_buf_locked(alloc, buffer);
-	spin_unlock(&alloc->lock);
+	mutex_unlock(&alloc->mutex);
 }
 
 /**
@@ -893,7 +893,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 	struct binder_buffer *buffer;
 
 	buffers = 0;
-	spin_lock(&alloc->lock);
+	mutex_lock(&alloc->mutex);
 	BUG_ON(alloc->vma);
 
 	while ((n = rb_first(&alloc->allocated_buffers))) {
@@ -940,7 +940,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 			page_count++;
 		}
 	}
-	spin_unlock(&alloc->lock);
+	mutex_unlock(&alloc->mutex);
 	kvfree(alloc->pages);
 	if (alloc->mm)
 		mmdrop(alloc->mm);
@@ -964,7 +964,7 @@ void binder_alloc_print_allocated(struct seq_file *m,
 	struct binder_buffer *buffer;
 	struct rb_node *n;
 
-	spin_lock(&alloc->lock);
+	mutex_lock(&alloc->mutex);
 	for (n = rb_first(&alloc->allocated_buffers); n; n = rb_next(n)) {
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
 		seq_printf(m, "  buffer %d: %lx size %zd:%zd:%zd %s\n",
@@ -974,7 +974,7 @@ void binder_alloc_print_allocated(struct seq_file *m,
 			   buffer->extra_buffers_size,
 			   buffer->transaction ? "active" : "delivered");
 	}
-	spin_unlock(&alloc->lock);
+	mutex_unlock(&alloc->mutex);
 }
 
 /**
@@ -991,7 +991,7 @@ void binder_alloc_print_pages(struct seq_file *m,
 	int lru = 0;
 	int free = 0;
 
-	spin_lock(&alloc->lock);
+	mutex_lock(&alloc->mutex);
 	/*
 	 * Make sure the binder_alloc is fully initialized, otherwise we might
 	 * read inconsistent state.
@@ -1007,7 +1007,7 @@ void binder_alloc_print_pages(struct seq_file *m,
 				lru++;
 		}
 	}
-	spin_unlock(&alloc->lock);
+	mutex_unlock(&alloc->mutex);
 	seq_printf(m, "  pages: %d:%d:%d\n", active, lru, free);
 	seq_printf(m, "  pages high watermark: %zu\n", alloc->pages_high);
 }
@@ -1023,10 +1023,10 @@ int binder_alloc_get_allocated_count(struct binder_alloc *alloc)
 	struct rb_node *n;
 	int count = 0;
 
-	spin_lock(&alloc->lock);
+	mutex_lock(&alloc->mutex);
 	for (n = rb_first(&alloc->allocated_buffers); n != NULL; n = rb_next(n))
 		count++;
-	spin_unlock(&alloc->lock);
+	mutex_unlock(&alloc->mutex);
 	return count;
 }
 
@@ -1071,8 +1071,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		goto err_mmget;
 	if (!mmap_read_trylock(mm))
 		goto err_mmap_read_lock_failed;
-	if (!spin_trylock(&alloc->lock))
-		goto err_get_alloc_lock_failed;
+	if (!mutex_trylock(&alloc->mutex))
+		goto err_get_alloc_mutex_failed;
 	if (!page->page_ptr)
 		goto err_page_already_freed;
 
@@ -1091,7 +1091,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	trace_binder_unmap_kernel_end(alloc, index);
 
 	list_lru_isolate(lru, item);
-	spin_unlock(&alloc->lock);
+	mutex_unlock(&alloc->mutex);
 	spin_unlock(lock);
 
 	if (vma) {
@@ -1111,8 +1111,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 
 err_invalid_vma:
 err_page_already_freed:
-	spin_unlock(&alloc->lock);
-err_get_alloc_lock_failed:
+	mutex_unlock(&alloc->mutex);
+err_get_alloc_mutex_failed:
 	mmap_read_unlock(mm);
 err_mmap_read_lock_failed:
 	mmput_async(mm);
@@ -1147,7 +1147,7 @@ void binder_alloc_init(struct binder_alloc *alloc)
 	alloc->pid = current->group_leader->pid;
 	alloc->mm = current->mm;
 	mmgrab(alloc->mm);
-	spin_lock_init(&alloc->lock);
+	mutex_init(&alloc->mutex);
 	INIT_LIST_HEAD(&alloc->buffers);
 }
 
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 70387234477e..a5181916942e 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -9,7 +9,7 @@
 #include <linux/rbtree.h>
 #include <linux/list.h>
 #include <linux/mm.h>
-#include <linux/spinlock.h>
+#include <linux/rtmutex.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/list_lru.h>
@@ -72,7 +72,7 @@ struct binder_lru_page {
 
 /**
  * struct binder_alloc - per-binder proc state for binder allocator
- * @lock:               protects binder_alloc fields
+ * @mutex:              protects binder_alloc fields
  * @vma:                vm_area_struct passed to mmap_handler
  *                      (invariant after mmap)
  * @mm:                 copy of task->mm (invariant after open)
@@ -96,7 +96,7 @@ struct binder_lru_page {
  * struct binder_buffer objects used to track the user buffers
  */
 struct binder_alloc {
-	spinlock_t lock;
+	struct mutex mutex;
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	unsigned long buffer;
@@ -153,9 +153,9 @@ binder_alloc_get_free_async_space(struct binder_alloc *alloc)
 {
 	size_t free_async_space;
 
-	spin_lock(&alloc->lock);
+	mutex_lock(&alloc->mutex);
 	free_async_space = alloc->free_async_space;
-	spin_unlock(&alloc->lock);
+	mutex_unlock(&alloc->mutex);
 	return free_async_space;
 }
 
-- 
2.47.0.199.ga7371fff76-goog


