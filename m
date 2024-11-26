Return-Path: <linux-kernel+bounces-422734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4799D9D80
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EBAC283F43
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9D81DFE22;
	Tue, 26 Nov 2024 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2aORK4XU"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2669F1DE3CA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646447; cv=none; b=QbIlLJtF2x9GUcwznGn5FuWJO5wT2HxJTiRKKfLTb+fmT5HkN+2+JP/EDlCEOGWnzCA2QoDCqzc0ztBgSU6wB/C28WYcYgFafGwM9spOPgGRR49dZBUX0qrPOGQEob4x5QIracdKTvWyoylEMi2vua/pS8ZJMkhodCradqMdE6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646447; c=relaxed/simple;
	bh=DVbIdWXyM3lRNsCoIo6/WLQp2IDa5LGGZa1uB9F6FMw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aFHGuX3Du5DUiS0gGg46ZO9amZhfdc4qIAuIsM4dmNLmSeJdtA5UYcby2MVF3ysSGsD4hDrpQm03/UZj43QLE0KxYGWG/WnkCHpdf4wPl6xIGpSsOWPauQnwrv8xZR72NSrnhrxVLRRBGcH1e+ngLUTypPsoqev64nUuKFW6jIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2aORK4XU; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2eaadc7c431so6880599a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732646445; x=1733251245; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qB9hna6YxkapW5S11BsFlpVZaJ15RhGZBwePsnA/2cA=;
        b=2aORK4XUPZR6rkyTaq8gLJ9yaZbbeQnd0Dz41RtEkRpQVFTd3no/9looRqdApcR7QZ
         QM6QTzD0AYqaJ3MpWgUGvG8VuAKmnbikziDkPZ3tV4Gs9eFz1NAVIIiel5wtLns0i/Ej
         Gp4yZFwIbtxonCGCOjXucePgNR61b02BCgLIlBqL8Y7DJ4CL2aHcX7oNOAWGSrWpoFbx
         7nEUl/S6yl8H/7HTpZfxKeb/TDXlztdC/ENL4eI8lTcWzXJTuPe2JpnLFZz4h7lh1CnI
         3Aufno6klILjV+E05RIIXoZUCnfsvO+czA4R5OOZJVWT2iG6VBtam0X11d/xTkoh+1AT
         JWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732646445; x=1733251245;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qB9hna6YxkapW5S11BsFlpVZaJ15RhGZBwePsnA/2cA=;
        b=B9sbZGKdHfO1mXWedJz0b0WftGhn8vaxIcVOFzdmpj2rcyNDtgkLfMtVHEZEASXF63
         X+SUx/tXmxD3DIm4ociDsUN3F7MmkBRJHa2ZYS5abDWGJf/N7KVq9/P41Xo6FcAagAYJ
         phjumy8mgtlqVgmUuNReeXgmt5gZ3hXNtObB8yDhC8o5rKVj5fTERztpqGVohqdWibAU
         JJX8j+hdggfw6nnMd7rkPKmVWnSeZjZe1zIr6zB4qkqltIiNrpTML0JRyeOLgqc6oI+E
         TH7CbGzpgfsrpIx5JT01ysvidsxpkVYJ1MXp35K6zNcx5GswR68DugVpxJ/iqMzXLEIx
         le9g==
X-Gm-Message-State: AOJu0YwKRRZeZD6eHC+kBZlh+S7ZepLAeDGT7NfFy70VpiWbDCLqECUE
	/zGehCBZH3L8pLKxbn+NpyBKl2V5q5kxk2Y8USrFsB2k6ZVDg7GOTUwdogKVRCePlIjX2smroYs
	CD0WCahy6PQ==
X-Google-Smtp-Source: AGHT+IGqmbDN2bbNqCc3JKy6L65i9HhRhpGsNJDmcYRPsv2M1uE0xe4h225c+x65j4Zt3x9HBx7b6UgR/jr6Og==
X-Received: from pjbsw15.prod.google.com ([2002:a17:90b:2c8f:b0:2e1:8750:2b46])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d04:b0:2ea:356f:51a6 with SMTP id 98e67ed59e1d1-2ee08eb2bc7mr401047a91.14.1732646445512;
 Tue, 26 Nov 2024 10:40:45 -0800 (PST)
Date: Tue, 26 Nov 2024 18:40:12 +0000
In-Reply-To: <20241126184021.45292-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241126184021.45292-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241126184021.45292-10-cmllamas@google.com>
Subject: [PATCH v5 9/9] binder: use per-vma lock in page reclaiming
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
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 339db88c1522..8c10c1a6f459 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1128,19 +1128,28 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
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
 	/* ensure the vma corresponds to the binder mapping */
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
 
@@ -1172,7 +1184,10 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
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


