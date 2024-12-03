Return-Path: <linux-kernel+bounces-430249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2B09E2F00
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 011B7B3B08E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B07220ADC2;
	Tue,  3 Dec 2024 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HNojayIy"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C2209684
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262918; cv=none; b=XFITJoIp8Na5sCu+AaMlo7rfBLCRtvkMewKoNk123VWFyl2lxKobYN5x7NZpXn7RT6hXGaPhrBqXjA/XYymkAvmtrY4MwdVQ7Cl7V6EoSwTXqiI4bf7L+gwwf+5IqDLS9mLGd8XvKjKURUly8K2lRVct1bdGN9DHK/P/gL9M6ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262918; c=relaxed/simple;
	bh=1b3dMELyLxamvht5e+LV7/lTV4/qEiNlyQkh3+gkwdU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=alca03r2wcq5uQZpd4tBZEcIRfhu29sKYfXtiHAO6E7mrV454xK/yvvOH8IENQMmqbnWxv0MZ/hkC3e0WM6ugacsjHkMAHhu8KLBT5uxw7hzRsVNjd0kuClRCkwkBUPUY4WDS9I2ZI3BMlkpwGj/U8uGwW4t93gzoc2qHORZeuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HNojayIy; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee534bdee3so4674276a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733262916; x=1733867716; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=awrGx+G7Hl/os9Vh+fl4vRm8eJvHryPmjNf0DeKDZHM=;
        b=HNojayIyuTAW/R0o3ug6c67VXe0yGzeigg3k662rxeDWE21a4BTjhQ0AGNxRHcOIeH
         9HugAChOf8wBCG/KffD+W8DmilOCCy14/lT+rNnXw/cyQ0jSFLomvUcIfCBfPpXpQ80K
         r3w4ftO+eW6jO7CO9uA0ZxBbwTMU3F6zGWMxBvCgEI6ekvm3+3LZHja+M57RQpzl8QnP
         MrFxEtqkD5QEwXDKZCKdPxdnRzUa2I3kRg4bjxYhIIuh2jgAf+UZUFMmVVQgfRt+/laR
         eYtRWIMKpLmvURWK2X5U4MYDpn28LxMOsi9lSctzjESQf3/TvMzbeUVmqjKIkfTO+XbN
         +jpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262916; x=1733867716;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=awrGx+G7Hl/os9Vh+fl4vRm8eJvHryPmjNf0DeKDZHM=;
        b=VSluTB9+m84647cWzJW6YwoO3FneCU1OLqVhFK8kid8FPROB9Jw1r44uDITmRzu3CC
         CktLwKBYTX3mj8xJgcy16VxM9XXp7hQvLPfZ/ez4kWB/7vwZKRhNrScwhcGMtCMOZyXc
         fnh43jBmRn92wjSuTEX5wXqW8+ssObdHvZLlsICu4U9NHO58VkbEF9SNf2u2Incvkqb/
         EL3Rd9WIfDdNnrR1p5SkyNjnn//JbiMg9GDdXgdZKI4uNkbOop0i3AELBDC7Cko2wUvX
         0V9qm48k62eTh4Y2ERZ3EQvfOSNaoEkV8wfoXjM9h6Lrwe2hnX5YP9xfghh5EiLn8GQ0
         8rlQ==
X-Gm-Message-State: AOJu0YyL+BiEDdl4Tzi9aIDo5b0lmSkn1g+FeGB9VrCSjM46kB2lL11J
	zxCvukOcyQR4B9q/Me1OE4MTQ8UixpHBpQ3AskBnH1/xorenaonAsLAWoeMEXnOtzSeLujH9mNj
	hJWHm+QRPyg==
X-Google-Smtp-Source: AGHT+IHVj/a9bvZ4VL+l9wBJSeJ69tsuvok8PCipIA5ro4bv9rROTXR66JxOwMBEPNnZ69pOCpYxwg3BUeJ5VA==
X-Received: from pfxa18.prod.google.com ([2002:a05:6a00:1d12:b0:725:202d:aaff])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3e81:b0:2ea:8fee:508d with SMTP id 98e67ed59e1d1-2ef0124c4c4mr5516597a91.30.1733262916021;
 Tue, 03 Dec 2024 13:55:16 -0800 (PST)
Date: Tue,  3 Dec 2024 21:54:35 +0000
In-Reply-To: <20241203215452.2820071-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203215452.2820071-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203215452.2820071-2-cmllamas@google.com>
Subject: [PATCH v6 1/9] Revert "binder: switch alloc->mutex to spinlock_t"
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


