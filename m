Return-Path: <linux-kernel+bounces-397075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AFB9BD66E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5230C1C2264C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84A0215C73;
	Tue,  5 Nov 2024 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hYmsrwkm"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CBE215C5C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730836992; cv=none; b=OhB/HONstVxB66egn1xvvqqL4pOMuUQiP+R7oxmZa3mzPgCztXGzJhkXL+GH1k5dfhZ7PLlmwMsA11GwNshl51Wtef7KjNU7FOS0GM02SDMWvbgP8mth5s5cD8JGH0uchElaGgXmvVcWUJ1Zm49HqjMdwhqncUYHFZ9w7HZ8ft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730836992; c=relaxed/simple;
	bh=54tc+22skwqLZjWpHpMI8mWFZ/nSFK2fHaRDE1iPbOg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NiVB3mqGTcFfslftm6sh9UoStGMwebXx/jwvbZXrdMfe2otFyqf4v9sNhnToO4zKXtBQx7qTq+V6REQ+hQBrINbVPnlfcg+FDI7k76I0tzSBuTcKuYp+9QrJyDPaQeayt9rDdyqtm6GDiqHjz/xx/IL533zke4erqRPMYFcDg/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hYmsrwkm; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7203cdc239dso7021805b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 12:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730836990; x=1731441790; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6s9N8bXLfq0vyRr/QJi4V+6LVydH0wqVse2bO6v6lY0=;
        b=hYmsrwkmDeyyRPxoS/XtnHzzoKONESdBfUQTGYuoqcwKk+NZzv/EoTVEPrcTZTnQfq
         jplgkxwVDwJN4C8OUkbLvK1t81SW2Nz5r5BgQTg0HYUf/vy7uNE2U4/zlI47/I3nXP/E
         Rl2q5qMAJqn4cG2Zu4jt5oxmysjPFvqWhi1ESG6hG8RvLcDPBoKyaKN3uyY/2Q9hmude
         owWEqkERCJbf3juQNTBeqewYu8F927lDfgEWlxdFdOqoCnNB68uDm1yxiC1a59JYTt+u
         PlLHxOmM58cqTIrSK41k+vh4y9z8+CvNucFPVFA07+IKT/gr8SfIVbOvIdTeOgXvARlY
         9QJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730836990; x=1731441790;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6s9N8bXLfq0vyRr/QJi4V+6LVydH0wqVse2bO6v6lY0=;
        b=nc2wmAAtB2QkXKCCXluG3sXXo/wHjnCApoqgamswhG5eab7BYvIXYUhkHQ+COUwr8A
         HyRyGKoseqQMquFHPssWLmNwG4NXnjz9iUJjBkiNZKZ8pdgXv67rkFxmhZbfz/e2Q2ll
         Tavhi9BnTCPeLGAmYveM0oqMH3mPrJZLJx9Sync9ZZTAQrv4UQQvrbE9HmsWDszS4JuY
         WbAJT+FFG6VosLpTJiDsvW3WBHVq81i3TAFVBK4Vtb9zNcRbuNDmFlBFbpdG8kfN+Ztu
         Qkv32YUdRHK9z0wVnpWd8Ks0n5WMqHX4s0rfhJBq3+qwzDrOJy6lIEOAt+RfQadc1xkp
         akqw==
X-Gm-Message-State: AOJu0YydkQtKGRQ9FwW3M/2uE806YyWY+zZSl/J6kljw+TFGicP2pdXy
	sghRLn/QhcfZLDW74QSnYvZZWfdZkxajAI+FF43LWMaQl+UarLo/yOln+c11Q9UZojaWiZ5FBUr
	9c72facrxmA==
X-Google-Smtp-Source: AGHT+IHxxsnAPQRqCZHVHc1NYflGFybcvrbqekBw3mHRrFi9WlmKTQ2rw3L87rykSMzBO+mu0pt8HHYIn/LbgQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:6616:b0:71e:4c4f:9d28 with SMTP
 id d2e1a72fcca58-720ab42fb21mr52389b3a.2.1730836989139; Tue, 05 Nov 2024
 12:03:09 -0800 (PST)
Date: Tue,  5 Nov 2024 20:02:44 +0000
In-Reply-To: <20241105200258.2380168-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105200258.2380168-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105200258.2380168-3-cmllamas@google.com>
Subject: [PATCH 2/8] binder: concurrent page installation
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
using folio_walk_start() to retrieve the already installed page. This
method significantly reduces contention in the mmap semaphore.

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
 drivers/android/binder_alloc.c | 64 ++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 7241bf4a3ff2..0fc6048cbc72 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -23,6 +23,7 @@
 #include <linux/uaccess.h>
 #include <linux/highmem.h>
 #include <linux/sizes.h>
+#include <linux/pagewalk.h>
 #include "binder_alloc.h"
 #include "binder_trace.h"
 
@@ -221,26 +222,14 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 				      struct binder_lru_page *lru_page,
 				      unsigned long addr)
 {
+	struct vm_area_struct *vma;
+	struct folio_walk fw;
 	struct page *page;
 	int ret = 0;
 
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
@@ -248,19 +237,50 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		goto out;
 	}
 
-	ret = vm_insert_page(alloc->vma, addr, page);
-	if (ret) {
+	mmap_read_lock(alloc->mm);
+	vma = vma_lookup(alloc->mm, addr);
+	if (!vma || vma != alloc->vma) {
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
+		if (!folio_walk_start(&fw, vma, addr, 0)) {
+			pr_err("%d: failed to find page at offset %lx\n",
+			       alloc->pid, addr - alloc->buffer);
+			ret = -ESRCH;
+			break;
+		}
+		page = fw.page;
+		folio_walk_end(&fw, vma);
+		fallthrough;
+	case 0:
+		/* Mark page installation complete and safe to use */
+		binder_set_installed_page(lru_page, page);
+		page = NULL;
+		break;
+	default:
 		pr_err("%d: %s failed to insert page at offset %lx with %d\n",
 		       alloc->pid, __func__, addr - alloc->buffer, ret);
-		__free_page(page);
 		ret = -ENOMEM;
-		goto out;
+		break;
 	}
 
-	/* Mark page installation complete and safe to use */
-	binder_set_installed_page(lru_page, page);
+unlock:
+	mmap_read_unlock(alloc->mm);
+	if (page)
+		__free_page(page);
 out:
-	mmap_write_unlock(alloc->mm);
 	mmput_async(alloc->mm);
 	return ret;
 }
@@ -1091,7 +1111,6 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	trace_binder_unmap_kernel_end(alloc, index);
 
 	list_lru_isolate(lru, item);
-	mutex_unlock(&alloc->mutex);
 	spin_unlock(lock);
 
 	if (vma) {
@@ -1102,6 +1121,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		trace_binder_unmap_user_end(alloc, index);
 	}
 
+	mutex_unlock(&alloc->mutex);
 	mmap_read_unlock(mm);
 	mmput_async(mm);
 	__free_page(page_to_free);
-- 
2.47.0.199.ga7371fff76-goog


