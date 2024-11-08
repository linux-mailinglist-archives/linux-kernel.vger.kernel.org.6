Return-Path: <linux-kernel+bounces-402241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83C29C255B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13211C21A0C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA32D1C1F0B;
	Fri,  8 Nov 2024 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N7ClKEBg"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8006B1AA1F8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093072; cv=none; b=VLwZNJUtnx4rgvN4vAeIrRb79CAfMnrhJHs8XjF2VRyDAnm6n1NIzpjM61izbbebHSIdb9+t833+CakCfumDHZhPS6b2nx0L86B5u7Y6Kk9fKtqhdbfCpo/O+rZbtsLX2gcZvr3Lo3uLeV/LW+wssk45HldMEzOXjQFEFdWNFAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093072; c=relaxed/simple;
	bh=x2cxwtxxXz74zqVKovw/9jGRMN/NyDnD8Mupa0u1K+c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PzFJ0Qwp9/LtUSLk9jeg2LdMZydt1p4t/fuA35x/n9MCHy62azCnGg2zjk35GQXmQwS1wI/tvbmNpsJWg1wpRBlwNZ5pGXQ0cMMJGXIFjfiEShU0XTzqBxRTiu5RkHCfLiUSNv+KGJ2R4dJuWLe3QAvfW5xrGZCidUyAqsnNV2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N7ClKEBg; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea8a5e86e9so46630537b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 11:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731093069; x=1731697869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PFVz8KSy2QmrXI/JCwqbfSS+RrYNzoax0b45RkBYR+A=;
        b=N7ClKEBgS8hsDuBHZzGLoPBb+DBzVOn2+1vU+84v6gH8XUByuvPDeyID7qnG6IpXAd
         c29eiHDwdq9svJcYC/yTRniFqZd9bhFSdTq2ZDJxUdVybVGcAFcNJZTZIIot6ZCUXHG2
         sUCpstcwjXaPTYEgoE4waJjmMJD0wMzoXtStEuImxntxMbdSMgH4N8WUFb0ha5Rp43v7
         bX+LEROzpd7aZiGuTic9dt+YOwprdp+nPLZGICJ9Gz8v02gFS19RZKL+C5nGHvH0qOOu
         7YoUH+WxllW/DDYsnumt/Y/vtfVCp/RyrVNEV0FhiRlr5xi8QglECih9VZvyGH+9b7nV
         s4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731093069; x=1731697869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PFVz8KSy2QmrXI/JCwqbfSS+RrYNzoax0b45RkBYR+A=;
        b=FdVrZGhNuZ6+rml5fUSSCayVEfTcJiTfFA/Os2QlLgYZIk8NsgceMfOTwLkOlAI7dO
         5ekkIAlo5uOuEmCq13NhbcqZhGNWsvFrL0yywFB214t0IluOT6+pb+7oa21MC3xrw+c7
         wNzH7j4PzEsj3y7FbhmIe1HxhV7bSL3IbhJ+oPv/OtlL11LuQ8DovA2fMWy2KpfrHLYV
         kJnocJbXvtSdA55DK9fmJxHM94n4UzwUb9OSzvP37PnfThG7lCy/Rw3eP/R1h/JWMxPc
         cDOjvl89rlAUzPh+tzsH7HVHYunYtgy47DEC4XfG7A/WJLRY099NRFknjkrB4HDzv9xt
         jawA==
X-Gm-Message-State: AOJu0YxS7BIXa8tLcFZWwnOAxveKG+Skq9ijFaeR2ihoWc8oMQ2A2xDe
	lyZMyDnJ6sThY3/T3ofYAihwGsCUST+WiFu30gSIp/OLZ+XBnQEbgVQM3PUg9oj+DZgjb3zKdQ5
	kUMdddJiIqA==
X-Google-Smtp-Source: AGHT+IG8xhDtuN5sIAPLrZBqYqqwdAzlm9ogIUbu6ekeecrSWufcan4fgIEmxR07BQByCs5Dx8vh6qeTTWV5Cw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a81:ad0e:0:b0:6ea:571e:ac46 with SMTP id
 00721157ae682-6eaddf95af5mr167787b3.6.1731093069597; Fri, 08 Nov 2024
 11:11:09 -0800 (PST)
Date: Fri,  8 Nov 2024 19:10:44 +0000
In-Reply-To: <20241108191057.3288442-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108191057.3288442-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241108191057.3288442-3-cmllamas@google.com>
Subject: [PATCH v3 2/8] binder: concurrent page installation
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	David Hildenbrand <david@redhat.com>, Barry Song <v-songbaohua@oppo.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Allow multiple callers to install pages simultaneously by downgrading
the mmap_sem to non-exclusive mode. Races to the same PTE are handled
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
 drivers/android/binder_alloc.c | 64 +++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 7241bf4a3ff2..2ab520c285b3 100644
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
@@ -248,19 +236,47 @@ static int binder_install_single_page(struct binder_alloc *alloc,
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
+		npages = get_user_pages_remote(alloc->mm, addr, 1, 0, &page, NULL);
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
@@ -1091,7 +1107,6 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	trace_binder_unmap_kernel_end(alloc, index);
 
 	list_lru_isolate(lru, item);
-	mutex_unlock(&alloc->mutex);
 	spin_unlock(lock);
 
 	if (vma) {
@@ -1102,6 +1117,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		trace_binder_unmap_user_end(alloc, index);
 	}
 
+	mutex_unlock(&alloc->mutex);
 	mmap_read_unlock(mm);
 	mmput_async(mm);
 	__free_page(page_to_free);
-- 
2.47.0.277.g8800431eea-goog


