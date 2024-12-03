Return-Path: <linux-kernel+bounces-430250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8840B9E2E7C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66051165045
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F5E207A20;
	Tue,  3 Dec 2024 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+l91Jci"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F6120A5FA
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262920; cv=none; b=EqC/ugYefbVgzB5dJEguZUofkyD6y3GSdk0VP8SdP3A/t+wnfdZ6Yk5dclnY4jNEt5425SYBkek54v0zcoycZyybcW5HaL7Y/eAjN7MYE5LriFQ2JOWGySh96tAprBxbF0WVTYThAMWx0vo7UatNEsZ1JXGf92WbmNZJyllJ+Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262920; c=relaxed/simple;
	bh=feto92b180sVitSUi6WA4dfzTO6KX//Xofn2Sv0b/xs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sVnf7matonMmwq3x18Mu+YVj2LzoAvpDmYMaEtrFtrV62ONqtWTIBXjWNEZqVkfzGccvsOxqLx8cxVxJfcetCCBcphDPJbbC5twJhrMyLR0PdFUNuYvYUzp4+0hh84sspAnN28ErngF4GeQyUhNhUXJBAe7eiDcwfLWvpq799sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B+l91Jci; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee5f6fa3feso6000283a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733262918; x=1733867718; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ybt3W/utb4idptlSsffJBzP4pVTicA4UuTKY+AOtES8=;
        b=B+l91JciG+VKXvQYWhKEFn8Q1sTPTT6R/q6Y/t54yTMZhYaETWRO0crPalU/q6JbsC
         dJYjghmOYTzeCbEQ0GIVaZ16RKx3cByk1p5LTN7p6Mm7TotUDWoCHp+7TiTo0amOTKs6
         ZtBz863UzmWgEoo9BawfOjArCmPnE1E7Exok+wPiAn9GVJitqvq4rbNyLI5ld82rzZLl
         CojRASfl3K3AcRUDRBYTJugUlHroH5dv8lILEvHyxfTCIDucpAkWZayxRDKPAd1UGV40
         c0f0XdHyvR+XaiDqGB6xwrpW3us58ekJDllLN5p9HA7oqDXA0JWHUR5kYXgpYyNNQRnk
         PGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262918; x=1733867718;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybt3W/utb4idptlSsffJBzP4pVTicA4UuTKY+AOtES8=;
        b=Ob2I6M1rK0PsJmvjOnCNV272QAUeCWKlofOvLSxYwJGnlYr0No7dEZlrGwgPnB26pr
         76CIL1iCBLWa5aPRgp4jNyfc5Lljzyq8J18X9OJ2CXMJ+miq26XZbGSvpwdQYlM2wO4E
         cgnYdfMDMgad6n/8guWXQtYNrO9xj2xZs1WU0s+M+wAqILdlJGorVKeyJNYf8vJ4uKc5
         6bZtNdhSxVj643yiZoGsRhEJG2Fmsp614Uz0tPULXfnNEb081Uh2iMYJCj8cKqp70jMF
         DvTBQyFlRGiEngS/HD3yMsI6sjQdfvyPz3i5Sml36Fsu64R+PxH/uRIc+kNyUP6KiwUS
         hWLA==
X-Gm-Message-State: AOJu0YzUEPy59xwUYWDvKxTazmmet7kuKHpf2Ma6zW8xjgCrlOCjLe3g
	pLlZG2JRHoYog/F2/lrNp6Dp2m2k+D4IPgCdLmZgrjWZUdM2L5nFIDFDpsmAmlMPajTIGBMqm1m
	mwfrH4uRvZQ==
X-Google-Smtp-Source: AGHT+IG6LOHr8nv/5OQkg2nS8yTZbbXLg7Kko7qvE20Jg+aPBhyBNIWSEjDB4gfRA/S7rXb1WX7MD+b7L5OsTw==
X-Received: from pjur6.prod.google.com ([2002:a17:90a:d406:b0:2ee:4b69:50e1])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2547:b0:2ee:fa3f:4740 with SMTP id 98e67ed59e1d1-2ef012759b6mr6171548a91.35.1733262918471;
 Tue, 03 Dec 2024 13:55:18 -0800 (PST)
Date: Tue,  3 Dec 2024 21:54:36 +0000
In-Reply-To: <20241203215452.2820071-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203215452.2820071-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203215452.2820071-3-cmllamas@google.com>
Subject: [PATCH v6 2/9] binder: concurrent page installation
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	David Hildenbrand <david@redhat.com>, Barry Song <v-songbaohua@oppo.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Allow multiple callers to install pages simultaneously by switching the
mmap_sem from write-mode to read-mode. Races to the same PTE are handled
using get_user_pages_remote() to retrieve the already installed page.
This method significantly reduces contention in the mmap semaphore.

To ensure safety, vma_lookup() is used (instead of alloc->vma) to avoid
operating on an isolated VMA. In addition, zap_page_range_single() is
called under the alloc->mutex to avoid racing with the shrinker.

Many thanks to Barry Song who posted a similar approach [1].

Link: https://lore.kernel.org/all/20240902225009.34576-1-21cnbao@gmail.com/ [1]
Cc: David Hildenbrand <david@redhat.com>
Cc: Barry Song <v-songbaohua@oppo.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 65 +++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 52f6aa3232e1..f26283c2c768 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -221,26 +221,14 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 				      struct binder_lru_page *lru_page,
 				      unsigned long addr)
 {
+	struct vm_area_struct *vma;
 	struct page *page;
-	int ret = 0;
+	long npages;
+	int ret;
 
 	if (!mmget_not_zero(alloc->mm))
 		return -ESRCH;
 
-	/*
-	 * Protected with mmap_sem in write mode as multiple tasks
-	 * might race to install the same page.
-	 */
-	mmap_write_lock(alloc->mm);
-	if (binder_get_installed_page(lru_page))
-		goto out;
-
-	if (!alloc->vma) {
-		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
-		ret = -ESRCH;
-		goto out;
-	}
-
 	page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
 	if (!page) {
 		pr_err("%d: failed to allocate page\n", alloc->pid);
@@ -248,19 +236,48 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		goto out;
 	}
 
-	ret = vm_insert_page(alloc->vma, addr, page);
-	if (ret) {
+	mmap_read_lock(alloc->mm);
+	vma = vma_lookup(alloc->mm, addr);
+	if (!vma || vma != alloc->vma) {
+		__free_page(page);
+		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
+		ret = -ESRCH;
+		goto unlock;
+	}
+
+	ret = vm_insert_page(vma, addr, page);
+	switch (ret) {
+	case -EBUSY:
+		/*
+		 * EBUSY is ok. Someone installed the pte first but the
+		 * lru_page->page_ptr has not been updated yet. Discard
+		 * our page and look up the one already installed.
+		 */
+		ret = 0;
+		__free_page(page);
+		npages = get_user_pages_remote(alloc->mm, addr, 1,
+					       FOLL_NOFAULT, &page, NULL);
+		if (npages <= 0) {
+			pr_err("%d: failed to find page at offset %lx\n",
+			       alloc->pid, addr - alloc->buffer);
+			ret = -ESRCH;
+			break;
+		}
+		fallthrough;
+	case 0:
+		/* Mark page installation complete and safe to use */
+		binder_set_installed_page(lru_page, page);
+		break;
+	default:
+		__free_page(page);
 		pr_err("%d: %s failed to insert page at offset %lx with %d\n",
 		       alloc->pid, __func__, addr - alloc->buffer, ret);
-		__free_page(page);
 		ret = -ENOMEM;
-		goto out;
+		break;
 	}
-
-	/* Mark page installation complete and safe to use */
-	binder_set_installed_page(lru_page, page);
+unlock:
+	mmap_read_unlock(alloc->mm);
 out:
-	mmap_write_unlock(alloc->mm);
 	mmput_async(alloc->mm);
 	return ret;
 }
@@ -1090,7 +1107,6 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	trace_binder_unmap_kernel_end(alloc, index);
 
 	list_lru_isolate(lru, item);
-	mutex_unlock(&alloc->mutex);
 	spin_unlock(&lru->lock);
 
 	if (vma) {
@@ -1101,6 +1117,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		trace_binder_unmap_user_end(alloc, index);
 	}
 
+	mutex_unlock(&alloc->mutex);
 	mmap_read_unlock(mm);
 	mmput_async(mm);
 	__free_page(page_to_free);
-- 
2.47.0.338.g60cca15819-goog


