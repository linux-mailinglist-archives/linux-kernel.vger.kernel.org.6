Return-Path: <linux-kernel+bounces-422727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F209D9D7B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12631673CE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6183E1DE4F8;
	Tue, 26 Nov 2024 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZGdWAAC"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EC01DE3A3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646430; cv=none; b=IluoMa6N+GeiGEqZi9G0AYlp821Hxg/9RXiEiO9+XehtTu2i+oh52dCO8c62hki9m9xViupnEU3vgQQ7iGPiGX2lyRWhMqAjTWaSIIAjb5xaJzJ5ciik/ktoU+h2B77SSjFdVTcKkj3hMVDb72H5cB4b2Bw+5aAOOJOExz9BBJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646430; c=relaxed/simple;
	bh=feto92b180sVitSUi6WA4dfzTO6KX//Xofn2Sv0b/xs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WGYNIjsC0L5PR1MKpvUB2ZGTOVzrnCYGtoo95F/a2WLIH55tVEAfkyS8SJJBb+RaaoVR5eAqyc8HMbAP80yBqSW4YOa5lKhjuQjJ0AKDiIUe/dv6w7IkGQeUYH5DLAhN1yKuvvmsADeoqVdKh6d5KXZOMRT3FD1UzaSVSprGw/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZGdWAAC; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7f80959f894so32971a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732646428; x=1733251228; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ybt3W/utb4idptlSsffJBzP4pVTicA4UuTKY+AOtES8=;
        b=PZGdWAACnMUyzakwPSl9KmJ5+3VyOym9QmPv9ME2MUIMW4eab4VHhMeV+CGx0oAA1w
         hY9y7fcPHma74YhfGzwBwYqd5aQT5S5wfcfYWHOpj2GDeztoSatp3rSuISBCCR1/LuIm
         entrPXuq02CQktniZ6aFQJn2JyTHW3qQFkpoKIm9eu2rT3hlvY23kmPp1bkEEDCQgsV3
         bYQZKpqfCm6owalf4o2Jusay7/2MoaZYMkJjr2sGcKqgKuC65SJwnBZp3qqRfE8GB9o0
         +Sd/YLIAPyIivqui6oceESf8oRth/gkYBTs2xHszg3Vs2ty0flUhuNGYL4sRBubK5T5s
         AYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732646428; x=1733251228;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybt3W/utb4idptlSsffJBzP4pVTicA4UuTKY+AOtES8=;
        b=eVU+s2nm/+SI8WCceCwNq/RfgX+Gn0NCmG6Jo4Ct2vx4hPkaG+5t1ibqHbJJuXnFVa
         3hiU8w5hkI/MY32wDQyu9cB6ayShlhFLwX2zeYNQX8tfWmZGD9Ayqw2t876W5Y0NCyjP
         UGj6JiSIcJhOpkqko9DhQeHtHFeZYH5/ZyT1BFaXwA6J2OI8zR+hfgqnTGFzZg2C4WL8
         wO+b0eBdZrjUk8WWxO22TDLAKjgpkYlN6rH/u3jghqb1tTyLy1hdihUbvQRzXhpHlE8u
         MAHTMbVo3UAaAllytOkdenaGQXTaZzWWe7MgGEu+/aprFoaXl9/isOys19jsqEgEu6dl
         OzYg==
X-Gm-Message-State: AOJu0Yw/NywdNNfcEQk4JTEm5IGuyN2QC2D2Rw4TE9fXpDWA+hS1oFae
	BDg0yt419dLf1G3hPeE4Wqju+0BX7brS+deOKCu5jCWgpBU3qMs+loEt1SUWiGX38uClUZNpbga
	czVQqiLE+UQ==
X-Google-Smtp-Source: AGHT+IFT1a1fQiePaQ1qUbP8EcbwdJ+SyQ0GgRw+Bp/RTCFxiVF9NmX8FOecxW7TMwAhdeR4HvcuLsZDme45eA==
X-Received: from pgbct7.prod.google.com ([2002:a05:6a02:2107:b0:7fc:1b9c:dcba])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:729e:b0:1e0:c5f9:75b6 with SMTP id adf61e73a8af0-1e0e13b0786mr455547637.20.1732646428328;
 Tue, 26 Nov 2024 10:40:28 -0800 (PST)
Date: Tue, 26 Nov 2024 18:40:05 +0000
In-Reply-To: <20241126184021.45292-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241126184021.45292-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241126184021.45292-3-cmllamas@google.com>
Subject: [PATCH v5 2/9] binder: concurrent page installation
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


