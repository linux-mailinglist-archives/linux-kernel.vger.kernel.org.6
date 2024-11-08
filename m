Return-Path: <linux-kernel+bounces-402240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1CE9C255A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B03286050
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA461AA1FA;
	Fri,  8 Nov 2024 19:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B83R5gCC"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3721AA1E2
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093069; cv=none; b=X7l3CYyqcEf3GI3cexYG5L595q8oVDtx0CGMHp0hIG7YS/UwjAAWrZ+eodaJjv4tPd9fi2jbbTbpESAZHS/xD8Z84rmtDgcyErC4nu/UVCMtfqoJvm7r392QVQygP8q36qrA1NUHS6bw5CR1C/1iADLVdBn1soTYzxL1z+PHjyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093069; c=relaxed/simple;
	bh=5qWgUMoLPo2vgQImG/ude6bNdDeZLsq+jdkxnKkAU8g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jovO9dictaAf9nwXEVwxEQ5sNLoB5/mmh2DJp3gsGWbrboMCvHPDjqo0H8yoJ7/MWLAp/OTydoeC/sslCA/oiFxh++3Q5x+ZQ+lZCsaHMQ8aboGkF/jIt+QOREG4ajVzT6gaAYLvuFiTpRvecVw7vVehYx7ODpecRdTceEe1/qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B83R5gCC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e38fabff35so48475607b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 11:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731093067; x=1731697867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pvmcaEovRetVNqLkHm0l6aGdRO6OSFNaEU0I68EcOXE=;
        b=B83R5gCC3WvQI+BCzysZrX95NrqUYXZF/tpLtD/lH1pmeO+Ijj0o3Jih3Oa2YUtbVB
         zbyVpaJIXp340ncS9/KQFGybpgQlikBMg0rYe049p+MjVNw2ROHcIAgbDhMzO+S93dOS
         qJIKqbqXiN1QBRnq2d9rAxVAKQ46d8kJGDdmP9J487CgxUc1QKQVOpqYgKx7SEs6jYio
         /AEhz/u9ZcDCHR9siLbfzCeiXcwEfO3AYbX6sEV8BzNafFbjms92tKKvQ5v4J299skeQ
         FA0KSps1SqOckWUKlETUwJ/mkJ3DA2mWmYnPUn3rfPE1jpHeT3IkQxdnjEW9VQiz9OHe
         YI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731093067; x=1731697867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvmcaEovRetVNqLkHm0l6aGdRO6OSFNaEU0I68EcOXE=;
        b=PiIqAxecfpCrTbCsIQY3XPBRvzw2WbeRceJ4eKs7zjGiqumC4gt+1VMmh5OuMxKjAN
         w8a5Odvyvpmv6W474AwumRJChvdHeFRLNf7BbpZLUBfGkuvXw8SV+RaCe12t5xCHxE+q
         JnSw6EsyurtB4W3eQmGxzV0BzzyoG993Iy4xUZjhc+hx+NsTmZHh8LfXmFQcOsuJEtye
         T4HZVUPkIwp7eCsVRmqhEN3fVCHLRYbn+eTTuIF/pQY2RZ73O4AnGORUkNfEmqHUXb/p
         1B4/ioXoZuf3UrL6EGdsYqFyvzb6yIbIqvsYphPnl9iO+sMHQpl9+0HvEipQwekpgcaF
         DcoQ==
X-Gm-Message-State: AOJu0Ywb/eyeMxiU8Nsj+oInMP82nVq4x6ssv8YWplfq8kdzkQq9mWsD
	vIdCCuydSl9VU71jcq60iL7jYoJa5SypWxwK6LQeQcaFJBZwNeXagh0prCcQYgL9N/gNcnpAXOn
	ppm3yl40Nkg==
X-Google-Smtp-Source: AGHT+IGJGZ7XxYYkX0+q89PxvpdxjVoiLcO5VI9vDDVYnRaNQAbwNQDLUZoRTMnpj1x8IbyGP3f2K4bfDaVHcg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:2706:0:b0:e33:3af2:4631 with SMTP id
 3f1490d57ef6-e337f861c85mr8191276.4.1731093067026; Fri, 08 Nov 2024 11:11:07
 -0800 (PST)
Date: Fri,  8 Nov 2024 19:10:43 +0000
In-Reply-To: <20241108191057.3288442-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108191057.3288442-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241108191057.3288442-2-cmllamas@google.com>
Subject: [PATCH v3 1/8] Revert "binder: switch alloc->mutex to spinlock_t"
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

Trivial conflicts with commit 2c10a20f5e84a ("binder_alloc: Fix sleeping
function called from invalid context") were resolved.

Cc: Mukesh Ojha <quic_mojha@quicinc.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
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
2.47.0.277.g8800431eea-goog


