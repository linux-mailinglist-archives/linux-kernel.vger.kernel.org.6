Return-Path: <linux-kernel+bounces-422726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1189D9D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA15116757F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7673F1DE3C6;
	Tue, 26 Nov 2024 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YlGh/mmK"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8011DDC2E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646428; cv=none; b=Xtc426KFwhV9FTHv4lzK62tgFKEF+gnLa8mhCsDLrRrUDHh+AobXaSe9QTNkZI14HxRl2PKMdWRGbmeQXP3AM1iUyNZAznouFAJTB8hVhTuy9Nj0M8FQURdSpTZMYqJWO1kzLr6aFNimI14kA9/QBqYicBzrYY+992pCbG2gHvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646428; c=relaxed/simple;
	bh=1b3dMELyLxamvht5e+LV7/lTV4/qEiNlyQkh3+gkwdU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nSG7IjixNcUwv6x9FiQEhajuZZTFkQx/K20Z11nPNf6J9d2cRNvfDe/mNHkV0LT3+e5vf7F82AYm3HM4y5O0mPp5oy3iQwDdn9PYRTAgaGzDnS4ijQUSH29+1d4NJGMojrF8dxkpAuQX0JN7XEkOyMPexfwrYxhk+wlA+C27YlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YlGh/mmK; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7eaac1e95ffso5323252a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732646426; x=1733251226; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=awrGx+G7Hl/os9Vh+fl4vRm8eJvHryPmjNf0DeKDZHM=;
        b=YlGh/mmKXVEu4lP2T2PV5LBrqJNvjo7uuKmiIf3UMPl3WKVaBvuenHhhMc4elXv6mJ
         R1Aym0yoquZXqxBuE7vRUfcy37ea0HP/ELeToOsvPjDGsDcIPKq5On+5HJyazarqQveY
         axjsGhpRwMCeMYT873Mz/lHpHC0+UB5kBL5V3dKzzVLTQlVJyPoIVzWWdhfU7+keB1OD
         I6oT9xVrmFDfNtTPYMezEm1F4EC0tbhBHiZ5zdVCL6WXfELGmGGiljcnzjcElcWPWjmN
         cJq50ov5/wg/B/RptnthpBw+MTPD593jnkM7F/Y4wD43DGJ7cj/JQOdNEXC8EM2xXX+/
         1JoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732646426; x=1733251226;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=awrGx+G7Hl/os9Vh+fl4vRm8eJvHryPmjNf0DeKDZHM=;
        b=S4TxR1fOguKvKsiDETgb5G3/zxQLLCwGlw8QUW831TI9VbTlu9VvyTDXMvYve9Jfq3
         OGh0ln3PX9w8SxZp2TK/kVxg6c4Zuws5Kzo0QGt1AVRbhzE43xNh1wZPRiuxcfOy9zrv
         R2kQNQwiDECUtfEjVdBvdG3WS6hMaQMkyObxzu0d4rJoaOW3MqLjCYTPW78j4HmwFp8O
         7qDDris6PdtVtPFUO7duyIv38bFs63JKrP3yU7Id09gG6vidhzszVhmBfN953xC7twDS
         clBGXq+yO9lHb20OyGREduGQrRGrDLBg2W/UJYhiKycUWsC8DiwQMEP3jQNqkEkCVfaz
         nC+A==
X-Gm-Message-State: AOJu0YxmFEurlrAHJBN3l1mE4AZQeke+7m9+BoYUb7xLtoaeeG0tcOjH
	rbV/aYA5l235JmkLxbw4YIGnnbLHAx6xwnoeIC9iDOMb29Ts7z7gfEBbjlvOeEjsesmYr/auz9Y
	N65F6gymwsA==
X-Google-Smtp-Source: AGHT+IHDDpNX9GMPQmz8d6u/R0ATzXftiCJYQ3Dt7Ne1B3Je173GsCwR60jDp3J5zjrLR96SKwZIyvCEP+TZ6g==
X-Received: from pfwo3.prod.google.com ([2002:a05:6a00:1bc3:b0:724:d819:72])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:158a:b0:1cf:27bf:8e03 with SMTP id adf61e73a8af0-1e0e0b10997mr656858637.26.1732646426258;
 Tue, 26 Nov 2024 10:40:26 -0800 (PST)
Date: Tue, 26 Nov 2024 18:40:04 +0000
In-Reply-To: <20241126184021.45292-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241126184021.45292-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241126184021.45292-2-cmllamas@google.com>
Subject: [PATCH v5 1/9] Revert "binder: switch alloc->mutex to spinlock_t"
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

Resolved trivial conflicts with commit 2c10a20f5e84a ("binder_alloc: Fix
sleeping function called from invalid context") and commit da0c02516c50
("mm/list_lru: simplify the list_lru walk callback function").

Cc: Mukesh Ojha <quic_mojha@quicinc.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 46 +++++++++++++++++-----------------
 drivers/android/binder_alloc.h | 10 ++++----
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index a738e7745865..52f6aa3232e1 100644
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
 
@@ -1070,8 +1070,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		goto err_mmget;
 	if (!mmap_read_trylock(mm))
 		goto err_mmap_read_lock_failed;
-	if (!spin_trylock(&alloc->lock))
-		goto err_get_alloc_lock_failed;
+	if (!mutex_trylock(&alloc->mutex))
+		goto err_get_alloc_mutex_failed;
 	if (!page->page_ptr)
 		goto err_page_already_freed;
 
@@ -1090,7 +1090,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	trace_binder_unmap_kernel_end(alloc, index);
 
 	list_lru_isolate(lru, item);
-	spin_unlock(&alloc->lock);
+	mutex_unlock(&alloc->mutex);
 	spin_unlock(&lru->lock);
 
 	if (vma) {
@@ -1109,8 +1109,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 
 err_invalid_vma:
 err_page_already_freed:
-	spin_unlock(&alloc->lock);
-err_get_alloc_lock_failed:
+	mutex_unlock(&alloc->mutex);
+err_get_alloc_mutex_failed:
 	mmap_read_unlock(mm);
 err_mmap_read_lock_failed:
 	mmput_async(mm);
@@ -1145,7 +1145,7 @@ void binder_alloc_init(struct binder_alloc *alloc)
 	alloc->pid = current->group_leader->pid;
 	alloc->mm = current->mm;
 	mmgrab(alloc->mm);
-	spin_lock_init(&alloc->lock);
+	mutex_init(&alloc->mutex);
 	INIT_LIST_HEAD(&alloc->buffers);
 }
 
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index c02c8ebcb466..33c5f971c0a5 100644
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
2.47.0.338.g60cca15819-goog


