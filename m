Return-Path: <linux-kernel+bounces-414832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057F09D2DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB9C284216
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AED1D363A;
	Tue, 19 Nov 2024 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ymc7r9IC"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E841D3581
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041181; cv=none; b=tn1uShyUYEZhDdV3KGt52GcFBtNt7FNQff9o+69hp1hrJGaE1fNJ1VlnKfbioVILzYbrkQarh/crhTVxdLQ3Xnpcdrcyrhczi7gzXFYfnzfhcbM/4Yn4+wDPWEbU+mWIlI4CbjSfuJm75NLkmDZnSm+a5q05Ke6w3bQHz9Hjkgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041181; c=relaxed/simple;
	bh=A0WBGcylZLU3DcaShibb41JThSy1QYaFV30IJDZAYCw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S45VTVBGV/bDAqT9QbMrk6WeE7vQ6JuKV82n9F/95DTqsba2oHZrcGZGh8KCLQR2okcXENSxFUVZvHZ5TOsgUhV6oDT+1YwWNUguDzvhQKus00iTHNEl0iwZDpE6eHzClaNH4icS6OezugZ6oTt0pJMY/R7fdCjrwOPe772eKOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ymc7r9IC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ee7ccc0286so48219347b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732041179; x=1732645979; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bn6utr72tyIQMc2MXS808aNFB+NOUPMTkmuXUr1q1p0=;
        b=Ymc7r9ICYXmepd5OB69bpKbwO5QMdZ8Q+C19HvG9c1u5XgieUGcv5FFLz0giLj24st
         CwLfCZ2KWeCyAF71ocByleaUbwMWKZukZ9m3pmweCs+pJT274MQFyaKWBTboHdk9NQUe
         sWZygbFpobhiRvDihNKJCqgjIRPTbhzyUrMUJFa0RCMoKeH7A9nn+KwuxZETicPBPq7L
         zVJI+R0QaoyuEDqj1MhwCjCLTQYmb1LO49LS50EMY8vRoEMAUDF8PizaiFyXodj23dCs
         y1zXICGgM/Y2F8pegJWJIJmL5rnXJuVer7zh+D8m5ByVGqcZq8e/bwvkBeAhos4VWg2U
         06Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732041179; x=1732645979;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bn6utr72tyIQMc2MXS808aNFB+NOUPMTkmuXUr1q1p0=;
        b=fTFTizMriwC4m6I3+NG4gjqqKcSy9vFKdHGOB55JnxOWuEeBeHENlY7UefJQ78a4kk
         tbnJf8KA1bbM/24m7x6YTKiWG5tW6oSBjCKbPx/IyBRcETOiP3Uf8rWaBuQVbl3Bdsro
         DOih64v5l5NTIVDvDlDPVUdLQpOoJsHnGFmCYn4S6JxoWFM68BlrokzTyRRlu3BMo17W
         7yBs/IVMtMbDE5Csim2mX6VW5TWRqIp0ypsoMJ8oSAhy0lG0Epwv0ijwzCh8j8VLu02H
         bzwUY/d0uQbPKH64uisTXjsrj+Kwn9wJU3AcR0/ZXsuFSQ65gzzQaqYyxlq4mQQ3sI33
         ZPVw==
X-Gm-Message-State: AOJu0YziDJdhl5AsxijoRw5pPBU8SZXrvLP9V++t5x4rXZKZF1cCJj20
	TkcRnx5PYdxcErsvjHdImTbLZq7lTwLXakj5T+PWQbecTMvAiFTogfmN+T78OWLs0wwQd+eu420
	Rf7AYAfNfZw==
X-Google-Smtp-Source: AGHT+IGKteloRNN2ipmuKHTr64YcfKxjm1l/LDGUff+hIxE0X7lX5+uMsAykjcSsXJDZLODr8Et4wvAO6jh70Q==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:3055:0:b0:e38:115f:eeb0 with SMTP id
 3f1490d57ef6-e3826614647mr11313276.10.1732041178757; Tue, 19 Nov 2024
 10:32:58 -0800 (PST)
Date: Tue, 19 Nov 2024 18:32:35 +0000
In-Reply-To: <20241119183250.3497547-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119183250.3497547-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241119183250.3497547-3-cmllamas@google.com>
Subject: [PATCH v4 2/9] binder: concurrent page installation
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
index 7241bf4a3ff2..0bc6ff1c341f 100644
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
@@ -1091,7 +1108,6 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	trace_binder_unmap_kernel_end(alloc, index);
 
 	list_lru_isolate(lru, item);
-	mutex_unlock(&alloc->mutex);
 	spin_unlock(lock);
 
 	if (vma) {
@@ -1102,6 +1118,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		trace_binder_unmap_user_end(alloc, index);
 	}
 
+	mutex_unlock(&alloc->mutex);
 	mmap_read_unlock(mm);
 	mmput_async(mm);
 	__free_page(page_to_free);
-- 
2.47.0.338.g60cca15819-goog


