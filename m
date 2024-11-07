Return-Path: <linux-kernel+bounces-399304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0380D9BFD2B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26AC11C21391
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897BC18FDC5;
	Thu,  7 Nov 2024 04:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mzG3QnqQ"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCD8194137
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 04:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730952194; cv=none; b=FYSPi9knCJ8k/PESSebYIJF363C/ImeQbBA+gRttIYFEpBFAS7A763dJYwp5MljXf+BwgZwJgKnyVYA1B0GUXF7nI306dyqUvSWwpOwBDQ7whFXI3b6maxnL6ytzA3I32AfBG/a6KjjOmswCcg8/Kec3GcTulQikDRhvh4Jg1Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730952194; c=relaxed/simple;
	bh=QeLO5CweM43xvKPgGpxsla8P+CWhmaCF9BF4DW0pZVA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ApMbFrsjDgFsa4tLd+Q2fKHixXIto+sX98Suvqe1WFsT9ah6KyS5/mJmSgL1ufXf4Er8Whq/PrkgtVO2MLJhjE/6GVzOsDSERgWwVfnMAN7rqBtSCpMde8tZgDkuoy482EBmMs4BLEMkl8Yw6GEKTQA0Xl0GgxOiPRYuqazlgLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mzG3QnqQ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e55c9d23cso469988b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 20:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730952193; x=1731556993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1I8PhWwXfD9Dckv+8oqyYv+UjXvs0aSVowyzRmrk8To=;
        b=mzG3QnqQLsP1zyMXDVnweiFUgXr63Cw0EphfQ4ERe5EoNFnj0cGDBM6pT9WAddZAHy
         K6MeEZMHNQVXHf3xlEQomeE65OiRq8crZgrgyGB5WpnfiUWLJroFT0kDK+pYFSh0Ibr2
         4sC/lvSve15Dz/YZ3iK2L/IVX6iT151eZdKthTsGr5axa3VwoCwLi+Ovo7jjkecmyLs7
         Vp1ZLt+PnxZXzlD/S6sH44Q8peN1CCSWdd6y4Y96Lvziwhz4Rf+LN56SMtklWbMM+CbK
         qgBXbGh/EMbtN8vCNNcC0G1un+Xthv5aEiquu3ucA/SLZr/c17a7PaAlqE1MclzGSyJm
         7Jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730952193; x=1731556993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1I8PhWwXfD9Dckv+8oqyYv+UjXvs0aSVowyzRmrk8To=;
        b=AZ58n25Rh4KXKBzTOMzVRg1us8GXrhl/YIOUmK5ZyY+pzv/+EKGOzaVKZIjVnOfkrW
         yGe7Mtro71AB8WCzxbWsD6NVrvmzvzxr3/McmLm8DDVhTMTdId5bhoTYuF9ddbnQ67Y8
         82yJ6/M3UbXTuzCUwT69+xqbeRtjjFMquGAFlbs+lf/DGlOKuc8w0C4UCEOrGSNKCnsJ
         TTaxAXKGe/AaTmOxEwxAZQthz6ZGfjy/hjO/X+4Imvz12x8EkzwpkYXJtk5FZmmPNPdq
         eaPBLMOQG8StVNPhIOggMY9s1M50Ftl3e+hdf/bTPFO8DWvujot4YVSv7s61Wr5mo/nB
         jlBg==
X-Gm-Message-State: AOJu0Yypw76uAyBkFepmVG+B8mbXlA0FzY049ewnehdZe0NAlQVuu8Ca
	YxBUTQBQoKhxxH7b8j/V0v8WRQrXnPKn+mgxchW9F0l48ntJcOcMDDB5j4zpAk6RcdpPTMA9/Nb
	/UaOtbHe/Yg==
X-Google-Smtp-Source: AGHT+IH428ZLhClaHyRkD1K0hT9OQaRA/HomA+uiHXNnVIBDOhkf7PCI9vy4dOcT6I5phcYEihJHZuONtC/kuQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:73b1:b0:71e:5e28:306a with SMTP
 id d2e1a72fcca58-72403e2e188mr79647b3a.0.1730952192713; Wed, 06 Nov 2024
 20:03:12 -0800 (PST)
Date: Thu,  7 Nov 2024 04:02:30 +0000
In-Reply-To: <20241107040239.2847143-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107040239.2847143-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241107040239.2847143-9-cmllamas@google.com>
Subject: [PATCH v2 8/8] binder: use per-vma lock in page installation
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
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 85 +++++++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 28 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 814435a2601a..debfa541e01b 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -233,6 +233,56 @@ static inline bool binder_alloc_is_mapped(struct binder_alloc *alloc)
 	return smp_load_acquire(&alloc->mapped);
 }
 
+static struct page *binder_page_lookup(struct mm_struct *mm,
+				       unsigned long addr)
+{
+	struct page *page;
+	long ret;
+
+	if (!mmget_not_zero(mm))
+		return NULL;
+
+	mmap_read_lock(mm);
+	ret = get_user_pages_remote(mm, addr, 1, 0, &page, NULL);
+	mmap_read_unlock(mm);
+	mmput_async(mm);
+
+	return ret > 0 ? page : NULL;
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
+	if (!mmget_not_zero(mm))
+		return -ESRCH;
+
+	/* attempt per-vma lock first */
+	vma = lock_vma_under_rcu(mm, addr);
+	if (!vma)
+		goto lock_mmap;
+
+	if (binder_alloc_is_mapped(alloc))
+		ret = vm_insert_page(vma, addr, page);
+	vma_end_read(vma);
+	goto done;
+
+lock_mmap:
+	/* fall back to mmap_lock */
+	mmap_read_lock(mm);
+	vma = vma_lookup(mm, addr);
+	if (vma && binder_alloc_is_mapped(alloc))
+		ret = vm_insert_page(vma, addr, page);
+	mmap_read_unlock(mm);
+done:
+	mmput_async(mm);
+	return ret;
+}
+
 static struct page *binder_page_alloc(struct binder_alloc *alloc,
 				      unsigned long index,
 				      unsigned long addr)
@@ -254,31 +304,14 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 				      unsigned long index,
 				      unsigned long addr)
 {
-	struct vm_area_struct *vma;
 	struct page *page;
-	long npages;
 	int ret;
 
-	if (!mmget_not_zero(alloc->mm))
-		return -ESRCH;
-
 	page = binder_page_alloc(alloc, index, addr);
-	if (!page) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	mmap_read_lock(alloc->mm);
-	vma = vma_lookup(alloc->mm, addr);
-	if (!vma || !binder_alloc_is_mapped(alloc)) {
-		mmap_read_unlock(alloc->mm);
-		__free_page(page);
-		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
-		ret = -ESRCH;
-		goto out;
-	}
+	if (!page)
+		return -ENOMEM;
 
-	ret = vm_insert_page(vma, addr, page);
+	ret = binder_page_insert(alloc, addr, page);
 	switch (ret) {
 	case -EBUSY:
 		/*
@@ -288,12 +321,11 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		 */
 		ret = 0;
 		__free_page(page);
-		npages = get_user_pages_remote(alloc->mm, addr, 1, 0, &page, NULL);
-		if (npages <= 0) {
+		page = binder_page_lookup(alloc->mm, addr);
+		if (!page) {
 			pr_err("%d: failed to find page at offset %lx\n",
 			       alloc->pid, addr - alloc->vm_start);
-			ret = -ESRCH;
-			break;
+			return -ESRCH;
 		}
 		fallthrough;
 	case 0:
@@ -304,12 +336,9 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		__free_page(page);
 		pr_err("%d: %s failed to insert page at offset %lx with %d\n",
 		       alloc->pid, __func__, addr - alloc->vm_start, ret);
-		ret = -ENOMEM;
 		break;
 	}
-	mmap_read_unlock(alloc->mm);
-out:
-	mmput_async(alloc->mm);
+
 	return ret;
 }
 
-- 
2.47.0.199.ga7371fff76-goog


