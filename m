Return-Path: <linux-kernel+bounces-414839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1819D2E05
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1BA284236
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456B21D88D5;
	Tue, 19 Nov 2024 18:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="svnFInen"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1AB1D86C7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041199; cv=none; b=tjnADGKqTJOQjOWGMAk/0LuQw/WyHOlpuCjIfYdBWzeK0KDfMJEG4P2ofNNiVjFquws1ltyp1p27eyohDo0ePZr3Wv+4Y0hQDw+mqqPeIsKpKaYc4n9Uq6gyFx6niECXrbgUaN6LAV5FSp9mlcCs39s2JWVQhaElezk90uEtJf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041199; c=relaxed/simple;
	bh=jgGxBpCNEu9KEEniPSZgpzzvAzuwtb3/WNSDo9OiNFA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EOHgizt9AimD7ImrIiYBKcnlTM/R6jro8xtginbVyCy5O5FFEcM/wgi/d9u5NVgZUAgo+8RhcT6T1QlQhnHeexXgUCWm6dAPfTKwD5b2XOMnQ8QOQr8xfj5a6yVCUzCzlW8ukuWI/+15uIL93lvUUsTo66QcyiD1MBrM8xnTgZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=svnFInen; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea6aa3b68bso82521317b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732041197; x=1732645997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i7giPzKmhTug7GC37/yaLfvsOihG5y0Sl3zHLNgstjs=;
        b=svnFInenhfk26QdHTsGsko6XC6AV7OqZLgT9ji/r85TDH461bGTuMTxUmisHZqOgbz
         mJ/tOL1s1QbNhR0z1Kwp9xbAiQXAOwBOh97W/DW9lzM1GPuoiyk/HgVIne5l/V6/jaWb
         X/pgmhrjPSuegkSYmPk8qo2TNOUAlHMdICBoXakiKgw8M5bkkqdhE7mCUiVz3tGfRIf0
         1nPdQRbPet1u1+vhnqlkkdOQs7uhJssR6n+mJbqMfR71WVtaDjfAErh4Fy/S11zjD5uY
         iIxpupoyJKvJ82/yEWFik8vYCTxfRERwJop2sML7jxkF4Mwx4hd1lSZ4r+vee6PTqbh6
         a/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732041197; x=1732645997;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7giPzKmhTug7GC37/yaLfvsOihG5y0Sl3zHLNgstjs=;
        b=F8VOftCG81sk8b8Cq+p/9kDL7kai6norh3sp9tH1ngrvReUTNYh9BaK35jhbrFldNG
         fFwc22wHOp9R/oAk7TvoiNudscgOITzDdGVi5eKZ2RnN0/1E9WnzuSPvSJliguqIY0Za
         csiZ5u4Ae9rTVHQZtd/Eh7LmwIY9vETHEuLvgcyK/ZHikJ3qqKAoJj5oiwnpvU1WWTQk
         fhLDzQbEilDB1AF2cb8VhB6pgdYDhefcqmT2w6PEvQPZX7bGpK/KunZy/Y1lV/ySltMS
         xYdGwjthJUxf1M/dSnbdsLIe4VYSzJMG+ps4a7Qse4AVGTN8IQw+PsmwvEd9pqX9KiQe
         xB4A==
X-Gm-Message-State: AOJu0YzQEzm4KtEoLW9bLf6XJrqYDn40q0J8dVAj23qvXxifQk8kcDYK
	i2woxC25GHAIjE1heeaD2JFv9B7ImIZNPuUclsBcYkg/OWHlZURNI7RrhBxBSG9GlZHurRz2mLY
	cBTQbW+n/Tw==
X-Google-Smtp-Source: AGHT+IEp2WTe/lMBMe6FiOp4xUYGRVhGj1CtKQ9wVyVVN8/MbDg+JCIqObmH9/kmTSyQNKZpRUkWiFDzu9b2/g==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:690c:3081:b0:6ee:8453:f427 with SMTP
 id 00721157ae682-6ee8453f5b5mr756017b3.7.1732041196813; Tue, 19 Nov 2024
 10:33:16 -0800 (PST)
Date: Tue, 19 Nov 2024 18:32:42 +0000
In-Reply-To: <20241119183250.3497547-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119183250.3497547-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241119183250.3497547-10-cmllamas@google.com>
Subject: [PATCH v4 9/9] binder: use per-vma lock in page reclaiming
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Use per-vma locking in the shrinker's callback when reclaiming pages,
similar to the page installation logic. This minimizes contention with
unrelated vmas improving performance. The mmap_sem is still acquired if
the per-vma lock cannot be obtained.

Cc: Suren Baghdasaryan <surenb@google.com>
Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index aea35d475ee8..85753897efa1 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1129,19 +1129,28 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	struct mm_struct *mm = alloc->mm;
 	struct vm_area_struct *vma;
 	unsigned long page_addr;
+	int mm_locked = 0;
 	size_t index;
 
 	if (!mmget_not_zero(mm))
 		goto err_mmget;
-	if (!mmap_read_trylock(mm))
-		goto err_mmap_read_lock_failed;
-	if (!mutex_trylock(&alloc->mutex))
-		goto err_get_alloc_mutex_failed;
 
 	index = page->index;
 	page_addr = alloc->vm_start + index * PAGE_SIZE;
 
-	vma = vma_lookup(mm, page_addr);
+	/* attempt per-vma lock first */
+	vma = lock_vma_under_rcu(mm, page_addr);
+	if (!vma) {
+		/* fall back to mmap_lock */
+		if (!mmap_read_trylock(mm))
+			goto err_mmap_read_lock_failed;
+		mm_locked = 1;
+		vma = vma_lookup(mm, page_addr);
+	}
+
+	if (!mutex_trylock(&alloc->mutex))
+		goto err_get_alloc_mutex_failed;
+
 	if (vma && !binder_alloc_is_mapped(alloc))
 		goto err_invalid_vma;
 
@@ -1163,7 +1172,10 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	}
 
 	mutex_unlock(&alloc->mutex);
-	mmap_read_unlock(mm);
+	if (mm_locked)
+		mmap_read_unlock(mm);
+	else
+		vma_end_read(vma);
 	mmput_async(mm);
 	__free_page(page);
 
@@ -1173,7 +1185,10 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 err_invalid_vma:
 	mutex_unlock(&alloc->mutex);
 err_get_alloc_mutex_failed:
-	mmap_read_unlock(mm);
+	if (mm_locked)
+		mmap_read_unlock(mm);
+	else
+		vma_end_read(vma);
 err_mmap_read_lock_failed:
 	mmput_async(mm);
 err_mmget:
-- 
2.47.0.338.g60cca15819-goog


