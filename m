Return-Path: <linux-kernel+bounces-399298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD3A9BFD25
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAE0283512
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C233190679;
	Thu,  7 Nov 2024 04:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="euvg0qe/"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB07F18F2DA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 04:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730952179; cv=none; b=JFHcsBN3B2UMqZy82AsI2mWcZ+pvzqZ5oJZImK/lqqG7nQhYfXUFQdj7ex0Xx19fabxP9IK6U1gjAhkaYJUC2btAqEa3xai/LGu6XkVfYIBgX41nM9tBSmR+Bqt/kIJQA3W8rjk5AHoR+fJnP4Al6Th1N2io+oBDmo5+M5Hwfi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730952179; c=relaxed/simple;
	bh=b3NB17IoZxtPjgmyAnkktSR8S47PnlT/gM+D1o9Rwz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g1NLRAqa37kDXfqW+grw+o57kkOUs7AaXOJf6BCpdOvmVGSKitaGjDR6d9o0IEDk9ijgo3un8npDAmEOG1Y1BmXVa6VgcNARf0+DC/m2tbTffNS0oKwWkowUGRIIjQ9tz0Fr1Tm0ewXdGR4l6S/ESlhMhV7tPoy9KuyJdkdiLAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=euvg0qe/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8d6fb2ffso10439487b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 20:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730952177; x=1731556977; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PoA41PKnjl7Bcop6YK1T7osmkskExFu/kuDntua0J3Y=;
        b=euvg0qe/n8Me0CcJi5Y9oRewWVik3bJtOsxqE6kUDnV7sS/LlIVTCfApqJl3EOpjg0
         NXN3ZMtHTiACM9jzB5TKhwZiS4ASXNik7ufUUvT9LkATzz4DO7rjO84AcbKxL3uXKvHA
         SOhtI9rXrtFEuBg4oJ/u9G8d+a9+5CmOweELzC/mQTufpAs1+1PIekfdZQQF+J+5QA0u
         /H97qwhdPcznkiTkX5u/TG9T7VTrZ0yw6qMf86/FGvYEocB2s+S6UuLVO4EGr9zeE88z
         c0/iptxWkCfVxNsW0sGF4YUi90tieOPaNgHZ5V7c9kJwdUcra4ffEGKCkUD0KTxPU0CJ
         50PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730952177; x=1731556977;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PoA41PKnjl7Bcop6YK1T7osmkskExFu/kuDntua0J3Y=;
        b=TNGjSxp3mkw0EaEjiqlRhuay1CMxnLYojpHk/5gstdBVCT8C1IXT1nHNv0Y/oq+iQW
         7dDZjBY5kuxcyse5s4MNs2q6YZhjUWiofCK9Q93HOTZj1NuRxoCkahAPPizjjiT6G3MQ
         7GirDK9jnLovX4FrWX0PzBI+TgWm17ByfOijcznysVSLnrY9USxYjRseTYfA+CKpnVLU
         CfPW5crmvFzI4mY4uNbJPzvRblGeYP72RabXQ9GOnlVq+mCGqEK2vVD0X9eWiEMfJL8Q
         0KAdJXXcRMEx56FUgDpeVedCACxJVPqdcbuGN1HsVBQTOCd6GceC6O7MWznb8oAURRT8
         t4GQ==
X-Gm-Message-State: AOJu0Yy+NiBbqM2mWybH/9++JxaCvoxMfjTAbth8BuGEPJlT1QS4CiE6
	elhmcXIrJYerfj/bFIYgYGAH6C/5nodyQ7+dL70S1mEsYZgwn21WMqhO3MubpX/zktp2Lm5PnSe
	YvnPh6xdX5A==
X-Google-Smtp-Source: AGHT+IHtv5RChbrnmtW5n+BrsQUYznKzLonVoC9N7KFiCDxROpnWYtAtAQ0ePbakaHJNWDyAvGo11Rp43/XFMg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:690c:308a:b0:6e9:f188:8638 with SMTP
 id 00721157ae682-6e9f1888858mr14589497b3.7.1730952176904; Wed, 06 Nov 2024
 20:02:56 -0800 (PST)
Date: Thu,  7 Nov 2024 04:02:24 +0000
In-Reply-To: <20241107040239.2847143-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107040239.2847143-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241107040239.2847143-3-cmllamas@google.com>
Subject: [PATCH v2 2/8] binder: concurrent page installation
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
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 64 +++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 7241bf4a3ff2..acdc05552603 100644
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
-		pr_err("%d: %s failed to insert page at offset %lx with %d\n",
-		       alloc->pid, __func__, addr - alloc->buffer, ret);
+	mmap_read_lock(alloc->mm);
+	vma = vma_lookup(alloc->mm, addr);
+	if (!vma || vma != alloc->vma) {
+		mmap_read_unlock(alloc->mm);
 		__free_page(page);
-		ret = -ENOMEM;
+		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
+		ret = -ESRCH;
 		goto out;
 	}
 
-	/* Mark page installation complete and safe to use */
-	binder_set_installed_page(lru_page, page);
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
+		pr_err("%d: %s failed to insert page at offset %lx with %d\n",
+		       alloc->pid, __func__, addr - alloc->buffer, ret);
+		ret = -ENOMEM;
+		break;
+	}
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
2.47.0.199.ga7371fff76-goog


