Return-Path: <linux-kernel+bounces-422732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEC59D9D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C0828335F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F313F1DFD81;
	Tue, 26 Nov 2024 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R4u6DUF4"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C820E1DF973
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646443; cv=none; b=bkpw5/Ugv8tSSP/yCRgu1B/oPYGoFSUbnKkLXZ11nlGSizf9+xQkQwh0Ztb1HdS2QFpSzTPXzf6PXU6j8RJMMgcmwEF8By+Oj/l1aEUEFvuuzVk6EMcfn1FRK8MVXe7XutN4B0LdHYPepFhAbVdIs3e56Rg2GZk9lzs6OaM34O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646443; c=relaxed/simple;
	bh=kobwXc6tmkTAygusWJ9qIVEQqqZsRYGXaPpK6AJbvPE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NhlkzVi5O4YOJGYyYgmyNqM2pEpXbXbDSH4+gej+xeHrwVMYqRaM3mi+n8u7wFCoE+WgBGySKi00UbeYAoa4PTnhZibW+guHq9EFKuiVD1z33YSccsmLqIk8+rAAe5i/ULW0qZ88qX3d1/IGDpZc/PVBJC9WZbT0BUIPAs7NUKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R4u6DUF4; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-72524409ab8so723098b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732646441; x=1733251241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sQAKTawIpYzMqOEmfUklmOtYHhl/FZVnlNMqQiUQFZQ=;
        b=R4u6DUF4HLpW3Hj+WiNMFCIarNlyOUAvvbqI0Y58+mOLaEU7gopPXKw7/oaQ1oUazV
         +AHso5lswswK9JJbHMt98kXL+rX0PAAeK5G6++KYPkSdCJvjgFMQjMvdkHHF3iUzS3XV
         uJDlp8DKlNNFKqjpkcAtd2DnN5Da6JrehkIc/KCU746lQxjp7d4mZ5xpJtF9jGnbDABd
         gIufCf90siY5q2opJsjHlW+a1kOQWIjgdx0OLmCRuZJXkmc84ole1CbGRB0mTJFArID6
         TjxmpB8YtaBbil0dqAO7SGO9XI6F2U30qAAdEci13/FFifYN/OuHJoauMqrRLtZaIvdF
         oqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732646441; x=1733251241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sQAKTawIpYzMqOEmfUklmOtYHhl/FZVnlNMqQiUQFZQ=;
        b=WoIaxK20uwqHetys0kv7sCEuXsUoNsw65+vY90U0NAWCyb4OqAuWhva+M1ULfH53IU
         scVaI1POgYPFGGW+WY7Pkrs49RGdfYj8iQevpok0ZkFWp0609HYm3R5zODMC75mgz3UW
         GRs33/3tvyH+hUn04dMGRRKsWXKR30vl8mecE+dv2v8aDAdyNoJtPW+PqQbhpqEXszMu
         iK+ONLPkNIyQMhP7wfTkwFKjYwp5z6VMfjHleLmBjMVrMUZ+Z87cTKicnb8QDr0hxOmd
         STY7Wb9Ot+LcjJVYKjC85eBxn9sexWba3MrUeukM4NvIHRw/Imf5VgWinyQKssHahg+8
         NbSA==
X-Gm-Message-State: AOJu0YzugpiOpCEddZAADDoF4crbD4dIb1gwUzXVWHYRyuUXWdgNDRye
	rb+83VXdiuQsqgT1baaPMO7Hrjrjdiu03u0fBti6xnH7uXhHZFVUuCE0sL49ka2ZcHqry3fc/Df
	aRfDjLKSqEg==
X-Google-Smtp-Source: AGHT+IGNlsge5O5WMP8QAnHXkYLMBHylGDOARCueNtukNeyuQLPFmoCK0YExqxBDRZmhW8oKC8XQCzwrIJEhmg==
X-Received: from pfwz5.prod.google.com ([2002:a05:6a00:1d85:b0:725:22:4960])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e91:b0:71e:795f:92f0 with SMTP id d2e1a72fcca58-7252ff9987fmr309443b3a.3.1732646441070;
 Tue, 26 Nov 2024 10:40:41 -0800 (PST)
Date: Tue, 26 Nov 2024 18:40:10 +0000
In-Reply-To: <20241126184021.45292-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241126184021.45292-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241126184021.45292-8-cmllamas@google.com>
Subject: [PATCH v5 7/9] binder: use per-vma lock in page installation
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <v-songbaohua@oppo.com>, Hillf Danton <hdanton@sina.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Use per-vma locking for concurrent page installations, this minimizes
contention with unrelated vmas improving performance. The mmap_lock is
still acquired when needed though, e.g. before get_user_pages_remote().

Many thanks to Barry Song who posted a similar approach [1].

Link: https://lore.kernel.org/all/20240902225009.34576-1-21cnbao@gmail.com/ [1]
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Barry Song <v-songbaohua@oppo.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 67 +++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 17 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 71b29bfd8a2e..f550dec4b790 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -233,6 +233,53 @@ static inline bool binder_alloc_is_mapped(struct binder_alloc *alloc)
 	return smp_load_acquire(&alloc->mapped);
 }
 
+static struct page *binder_page_lookup(struct binder_alloc *alloc,
+				       unsigned long addr)
+{
+	struct mm_struct *mm = alloc->mm;
+	struct page *page;
+	long npages = 0;
+
+	/*
+	 * Find an existing page in the remote mm. If missing,
+	 * don't attempt to fault-in just propagate an error.
+	 */
+	mmap_read_lock(mm);
+	if (binder_alloc_is_mapped(alloc))
+		npages = get_user_pages_remote(mm, addr, 1, FOLL_NOFAULT,
+					       &page, NULL);
+	mmap_read_unlock(mm);
+
+	return npages > 0 ? page : NULL;
+}
+
+static int binder_page_insert(struct binder_alloc *alloc,
+			      unsigned long addr,
+			      struct page *page)
+{
+	struct mm_struct *mm = alloc->mm;
+	struct vm_area_struct *vma;
+	int ret = -ESRCH;
+
+	/* attempt per-vma lock first */
+	vma = lock_vma_under_rcu(mm, addr);
+	if (vma) {
+		if (binder_alloc_is_mapped(alloc))
+			ret = vm_insert_page(vma, addr, page);
+		vma_end_read(vma);
+		return ret;
+	}
+
+	/* fall back to mmap_lock */
+	mmap_read_lock(mm);
+	vma = vma_lookup(mm, addr);
+	if (vma && binder_alloc_is_mapped(alloc))
+		ret = vm_insert_page(vma, addr, page);
+	mmap_read_unlock(mm);
+
+	return ret;
+}
+
 static struct page *binder_page_alloc(struct binder_alloc *alloc,
 				      unsigned long index,
 				      unsigned long addr)
@@ -254,9 +301,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 				      unsigned long index,
 				      unsigned long addr)
 {
-	struct vm_area_struct *vma;
 	struct page *page;
-	long npages;
 	int ret;
 
 	if (!mmget_not_zero(alloc->mm))
@@ -268,16 +313,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		goto out;
 	}
 
-	mmap_read_lock(alloc->mm);
-	vma = vma_lookup(alloc->mm, addr);
-	if (!vma || !binder_alloc_is_mapped(alloc)) {
-		__free_page(page);
-		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
-		ret = -ESRCH;
-		goto unlock;
-	}
-
-	ret = vm_insert_page(vma, addr, page);
+	ret = binder_page_insert(alloc, addr, page);
 	switch (ret) {
 	case -EBUSY:
 		/*
@@ -287,9 +323,8 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		 */
 		ret = 0;
 		__free_page(page);
-		npages = get_user_pages_remote(alloc->mm, addr, 1,
-					       FOLL_NOFAULT, &page, NULL);
-		if (npages <= 0) {
+		page = binder_page_lookup(alloc, addr);
+		if (!page) {
 			pr_err("%d: failed to find page at offset %lx\n",
 			       alloc->pid, addr - alloc->vm_start);
 			ret = -ESRCH;
@@ -307,8 +342,6 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		ret = -ENOMEM;
 		break;
 	}
-unlock:
-	mmap_read_unlock(alloc->mm);
 out:
 	mmput_async(alloc->mm);
 	return ret;
-- 
2.47.0.338.g60cca15819-goog


