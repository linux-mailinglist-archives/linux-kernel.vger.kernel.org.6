Return-Path: <linux-kernel+bounces-439734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5939B9EB35B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55C7167EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC13A1B6544;
	Tue, 10 Dec 2024 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kkh5XxHq"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF5F1B4122
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841097; cv=none; b=jIBlgikFqdhqO/9uZ6TwUy0ppx7QePatYbEaRP60UedsEl4erIMiUGwGGh0kVpRth3BPtyBnp6D6arcHC4tsBxmkTm0RfIARJsOfhjEVGN6qGqjoPTFLs6jB+ijqAUpx8gMMHSpMfPSb5EWkkrgNce+GxjiPFZEySvhSGAVLa+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841097; c=relaxed/simple;
	bh=feto92b180sVitSUi6WA4dfzTO6KX//Xofn2Sv0b/xs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XKDuOOaSztI1YR/VOVHHWZXK9wjXzhXZwaOi8zd00nHWZimk60CoU+Msg/fmmEYEHaCpiLDW9QI7+1X1q4+GggP3CozeGslHyISN9SUpQRVFJ39j8Rf18C8G2a7Dqv2WPrgDDxQNKVWdujPTLjXF+hCzG/RII+2ut7mF3ss+WA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kkh5XxHq; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-728e4e30163so378517b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733841095; x=1734445895; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ybt3W/utb4idptlSsffJBzP4pVTicA4UuTKY+AOtES8=;
        b=kkh5XxHqVfk4JfAtR0o+xf2uqF4RzBzTFw2tupMr60j4N4AgGn8n8cJwmZJCVfnvlZ
         BmOXmBcWXKreVA3BbGzq7/1jO7OeBPEIHBItK2wwIwHsFdmoGYEQLmO0ddPWUwxRltBE
         DjSAjJcW4WQAYcsg/VVLV/C2IDFK34uIVvFb9ug1XBkAVC+ffTP+Bic/UVqUhAYaAJrj
         zjKCAtMofuvMm/IXVZabEkTTUd5ZBhGCRyoMrVEPiGjdEAtVkUcJdvJVq+5hIzSQlmZU
         zMXwemq8UJG9ggq8nyD3VBBypXCZAB3nBsvoqne2Xex7XKdg+v8TJGabiP70i2KENr+O
         i0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841095; x=1734445895;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybt3W/utb4idptlSsffJBzP4pVTicA4UuTKY+AOtES8=;
        b=HVH3IheV+yoovemc6pyZA7G6ym1XxoFK51apuX/jO22V/DtrOacVeC6nguYb2JzG0A
         l0m0Iqp7N/psvtbbKYavSdJgcc5Yyd2vD724ogOEYz72TDWK9atjD5H32bktjOKsVMJv
         tOZfnBcXp1c7PgXo3ce/BD0jrrYsQ6tJL2s4zgmRbuQ6EyoQSv36jUguRwprkbnwzzHh
         VybqE+jLBiQHbMU+0GmYQ0bnPO+Ca9VTw4mNaXgh0qhHSQd2ZEoFgkogcPjNSMLGKu69
         zu+zm5RUxY4gLbWsC3bVrQutELOqn/ND/u95q4gPUWl53Y5GeYf2dR4oazfCe1YmiOjt
         +Rug==
X-Gm-Message-State: AOJu0Yxq5TUgGhuiwTbvDfWceEf8t98n6z+gsWjxUBaPBsDaqwA4Iq1S
	3jWnv5TmaIuHmBBgs1+P3a8hOOELH2CRUqKKl8w83Rgv+IMF0/B12VEDBexNUfM6CxINAG2NJ0o
	uXAB88OHaTw==
X-Google-Smtp-Source: AGHT+IFWWy7b1YZzewnPN0H0qObWkOPB7AFZAI8NPy8nIaPgmPe+sOGX9/4fZidos+a2WsUdLLLz8L6dq1/37g==
X-Received: from pfbcd10.prod.google.com ([2002:a05:6a00:420a:b0:728:ea18:74b5])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:32a8:b0:1e1:9893:9a1a with SMTP id adf61e73a8af0-1e1b1baeb1fmr9242991637.46.1733841094724;
 Tue, 10 Dec 2024 06:31:34 -0800 (PST)
Date: Tue, 10 Dec 2024 14:30:58 +0000
In-Reply-To: <20241210143114.661252-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210143114.661252-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210143114.661252-3-cmllamas@google.com>
Subject: [PATCH v7 2/9] binder: concurrent page installation
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


