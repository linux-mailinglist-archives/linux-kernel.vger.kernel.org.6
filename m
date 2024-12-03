Return-Path: <linux-kernel+bounces-430255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6779E2E81
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3992820E8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722A920C031;
	Tue,  3 Dec 2024 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="navMQVas"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203F220B21E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262933; cv=none; b=h+2WYETjh/SCqtiCjPNHNTyIZaklj8togaR7Ob16dyvFzeaz4z/F+WogRyFT1jeZyGEDWnViEYGQT0pQapHwyiXSb0bXdnvRZvRhPasD+hOVnaPemy70vmCpFtshHIC3FOz+PYVXDlMUczc47yPKKNDEZ/pRrnSuUNoiDhuFAFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262933; c=relaxed/simple;
	bh=oq+O/8jSsxaIOAOpTxBSu3K18phBhR4QBfPwlsmJAek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fft9FqO5LfhKx6cDlI6qHGqGCEI0KaIZPjD6bNPDyVKM6XCYrPMIfkjSkRx816qMuq1y6q2YwcJeJBf8fzoqhIzBSTrLVvY9l49tk6NL+WBDFZcZbaJzjUtXK2sZ8Ls7n5wzKNkMl18seuyJmrcOB1yZ5zGQW0BDVYu+kBdLNgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=navMQVas; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2154e1cdf72so39386155ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733262931; x=1733867731; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MPXJ2872zU944HGrm8VzJkh2Cc9BZttgBo1z7c+E8aU=;
        b=navMQVasLZpC6DsIdoguFustIVmgA7z5CDpfQQwyTbLad44VvhQzOv6U7aa0Xo8t5I
         /wtW6Ta5CJOv0r3qSdlOkZ3EvqiAv8b7kI4wLDWGai9SliFS+4vQoOd1Kni6EPgDGhwO
         0SMrxjcWkAkw/CMhuYa5J1DSBzIW/4kAjL0EryowkAvTi79ZJzFz4H4XQYlLzJ0gjosC
         OiuSVzc6tVc/ckddFFECY6Gt+p1YytjwUZ76+9kiLi4n4+bgcueE6VfRsqZWX1bFKxD+
         aYBc7myRamSln1KZ/TAS5PCY4KwKgw4zhLcEnCanDj+8B4xli9WthMEkqXRomn3SmMbA
         63vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262931; x=1733867731;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPXJ2872zU944HGrm8VzJkh2Cc9BZttgBo1z7c+E8aU=;
        b=qXXNkJPP/ciD6+1NxJg7pCXO3ltDSeUA1sJe9FzbyZjuZTrma6Z4ESML798jjY59EX
         lPaz+bIYwGDCDBUPgm4Ik8WQsB1AikT+UKu+uOLG+6L3nzjs5UopV0TsUWc64pTlI1ky
         wCjtHltoIpB9s1iyriuI0V8nwcbV9zxhi6GNJVUz3Vga/PvMLnd3YVb+qFGzwHn5k8PJ
         xg2bMGPH6BmdM4UKGWD9m/l+pB+jqrmTZy/phWTwmwQnuzK0/Ue975BhFVEnpAasqpVq
         vpWhm4W60LywelHaJcSo9D0l+SbCW3uSyQE3MgmWGyCZWS2T29ecTiabsfCRRoSvX2fv
         IQAg==
X-Gm-Message-State: AOJu0YyuYTGOQ0Kcz7KSQ2OqaxSPoBZmL4yq9dFvVLK5eZImbLtu4VIn
	8cthtac3fgAzNQoPiZLI/7zETLpCHS9vv3Unj5ZzZfYeoeCwpbsokG/sibyIi/D+ytHwhM/RLJF
	4shXQydfZiw==
X-Google-Smtp-Source: AGHT+IHo1lXs605vY4Q9s6sdjOgWez3tqOA2C6jAa7Jl0HAoAqtvVWK61ONGYszX7lELB3MBqatyPrB1GA5gUw==
X-Received: from pfwz33.prod.google.com ([2002:a05:6a00:1da1:b0:725:381c:396a])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:db12:b0:215:44fe:1640 with SMTP id d9443c01a7336-215bcfbcdbcmr50656045ad.3.1733262931261;
 Tue, 03 Dec 2024 13:55:31 -0800 (PST)
Date: Tue,  3 Dec 2024 21:54:41 +0000
In-Reply-To: <20241203215452.2820071-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203215452.2820071-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203215452.2820071-8-cmllamas@google.com>
Subject: [PATCH v6 7/9] binder: use per-vma lock in page installation
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
index ce2bdf278b82..0c54e50841c8 100644
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
 				      unsigned long index)
 {
@@ -268,9 +315,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 				      unsigned long index,
 				      unsigned long addr)
 {
-	struct vm_area_struct *vma;
 	struct page *page;
-	long npages;
 	int ret;
 
 	if (!mmget_not_zero(alloc->mm))
@@ -282,16 +327,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		goto out;
 	}
 
-	mmap_read_lock(alloc->mm);
-	vma = vma_lookup(alloc->mm, addr);
-	if (!vma || !binder_alloc_is_mapped(alloc)) {
-		binder_free_page(page);
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
@@ -301,9 +337,8 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		 */
 		ret = 0;
 		binder_free_page(page);
-		npages = get_user_pages_remote(alloc->mm, addr, 1,
-					       FOLL_NOFAULT, &page, NULL);
-		if (npages <= 0) {
+		page = binder_page_lookup(alloc, addr);
+		if (!page) {
 			pr_err("%d: failed to find page at offset %lx\n",
 			       alloc->pid, addr - alloc->vm_start);
 			ret = -ESRCH;
@@ -321,8 +356,6 @@ static int binder_install_single_page(struct binder_alloc *alloc,
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


