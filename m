Return-Path: <linux-kernel+bounces-397081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDAA9BD674
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC57283EF9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32714216215;
	Tue,  5 Nov 2024 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Va1gCUVo"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1EC215C68
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837010; cv=none; b=o7alSlg+Vou0JR6AnQeFHPo3YYuUtIt0w62tHzb7GM1jPAse+rqN5wP5ciJKIchTxLDRiVaEbeee6Dyf9/0wmGpff8n56OpDHQpOQu76tnWsfFnuLNM/uQ/nA+WPmzbUXOIyuLDuvrj4BV86FomRCXstxthieyBXHS8Qo2QJIu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837010; c=relaxed/simple;
	bh=axu+SuCUcLr8WtJ/zdsr2jK+nOb0rk9rZ16hbDD7jtY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=clBhSBI6ctGm5RpdjmzSs94djp+bZvO9Lt5K9vXYDkyLEp0RFNnC/d+63pSP8Pd9SuHdqIzF44kc3rPw4XpxvTLeGckRHnYBpsmxYlxvr9ys0CT4+GLxf0O29Kw00igqtw+9s8UAF//0vZS0zYBpC8B6OHqtDaUwR8PqCtgiCvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Va1gCUVo; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea95f530fdso46704697b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 12:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730837006; x=1731441806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yd7j9aSxGIpn4d13uPZM6xFte0p1814h13XmA29rNnY=;
        b=Va1gCUVoTrtZHSC0tM9i2MUsYewhGRH4vO9VVx5RZGjuugMH+eG3F9GSpwtNFgu/UP
         DeUfv1F+6OpJqJ1Xnk0vzkfVSIwe/LgXea/vDgyz/P4wD2kTv5PMkCaKz+sIi+Wll/wc
         9CWJpeu0w5erJ+bZNFY8f9rPNm8NnSffWaGSdFT+NzStPGjpC9zj7gVV/w/lcxIecBA3
         oPpB4FVluVG2vRGW+OEU3/5X9p0nvLT5LhXCEgEHNgi9S9Iks2CdRm+ctyTll55U1hEI
         yY3xDYZV/WIfI/UPOwpgm9G2aTQAUVmIAt9c1WmgMx2iVsSEQLRkW+4y+wGfd6rVBHzj
         qJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730837006; x=1731441806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yd7j9aSxGIpn4d13uPZM6xFte0p1814h13XmA29rNnY=;
        b=vumSPNHpxocjLcpY4GXxuYLJYtLsFKHJOta3UNSt/ybA0d4nRZKabFzhadJRw4OfYt
         rYSsvvNt9A20awfda5pgmPicRjz2pI/rSsTccfYnOca22pSatcDBY+l1XZzStMIsqNSW
         TxborTHGivuGJYyIA79TaMSZI/kiBUM9x/zA0JN8cUTRIQToQyqcn98CSdOIvCgZLCRi
         GpTcvRBmRjcJ6RnHWoBitpGLSz3C3kSNZKbkN54seLYnaq6CSjQZR8YgR+0+Wdw7d1RQ
         fdgFzvy7amZIabrHFHD1Hf5mZS52AJbSK9ZhA/wOsYkgKNWXScM+YRXAwzWj2wFWyUNE
         7yVQ==
X-Gm-Message-State: AOJu0Yy7jdV7SFlMzOQuBCR2gu3YED3ljmtYHALrnpClOllu7FF69X06
	V39UN9trhf9HNCwInEebITe0uREWXibM+JsMX1fs2ASlcC0wf+K+HXGrWV0KAhhp0FYfVCClzPP
	XVH9WcUSfkw==
X-Google-Smtp-Source: AGHT+IH0YVtb6fbOYKhMlgKfSIaLFwui3tGnWQHJ30WqiKR1QVTWDBUeeuoYelFC3rgUjGvVDQNzQTQodFhefg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:e04e:0:b0:e30:cd7e:c0b5 with SMTP id
 3f1490d57ef6-e30cd7ec150mr44863276.3.1730837005801; Tue, 05 Nov 2024 12:03:25
 -0800 (PST)
Date: Tue,  5 Nov 2024 20:02:50 +0000
In-Reply-To: <20241105200258.2380168-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105200258.2380168-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105200258.2380168-9-cmllamas@google.com>
Subject: [PATCH 8/8] binder: use per-vma lock in page installation
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"

Use per-vma locking for concurrent page installations, this minimizes
contention with unrelated vmas improving performance. The mmap_lock is
still acquired when needed though, e.g. before folio_walk_start().

Many thanks to Barry Song who posted a similar approach [1].

Link: https://lore.kernel.org/all/20240902225009.34576-1-21cnbao@gmail.com/ [1]
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Barry Song <v-songbaohua@oppo.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 70 +++++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index d505ffddb6db..47cf1c354e6f 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -234,13 +234,63 @@ static inline bool binder_alloc_is_mapped(struct binder_alloc *alloc)
 	return smp_load_acquire(&alloc->mapped);
 }
 
+static struct vm_area_struct *binder_find_lock_vma(struct binder_alloc *alloc,
+						   unsigned long addr,
+						   bool *mm_locked)
+{
+	struct mm_struct *mm = alloc->mm;
+	struct vm_area_struct *vma;
+
+	/* attempt per-vma lock first */
+	vma = lock_vma_under_rcu(mm, addr);
+	if (vma) {
+		*mm_locked = false;
+		return vma;
+	}
+
+	/* fallback to mmap_lock */
+	mmap_read_lock(mm);
+	vma = vma_lookup(mm, addr);
+	if (!vma || !binder_alloc_is_mapped(alloc)) {
+		mmap_read_unlock(mm);
+		return NULL;
+	}
+	*mm_locked = true;
+
+	return vma;
+}
+
+static struct page *binder_page_lookup(struct mm_struct *mm,
+				       struct vm_area_struct *vma,
+				       unsigned long addr,
+				       bool mm_locked)
+{
+	struct folio_walk fw;
+	struct page *page;
+
+	/* folio_walk_start() requires the mmap_lock */
+	if (!mm_locked)
+		mmap_read_lock(mm);
+
+	if (!folio_walk_start(&fw, vma, addr, 0))
+		return NULL;
+
+	page = fw.page;
+	folio_walk_end(&fw, vma);
+
+	if (!mm_locked)
+		mmap_read_unlock(mm);
+
+	return page;
+}
+
 static int binder_install_single_page(struct binder_alloc *alloc,
 				      unsigned long index,
 				      unsigned long addr)
 {
 	struct vm_area_struct *vma;
-	struct folio_walk fw;
 	struct page *page;
+	bool mm_locked;
 	int ret = 0;
 
 	if (!mmget_not_zero(alloc->mm))
@@ -257,12 +307,11 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 	INIT_LIST_HEAD(&page->lru);
 	page->index = index;
 
-	mmap_read_lock(alloc->mm);
-	vma = vma_lookup(alloc->mm, addr);
-	if (!vma || !binder_alloc_is_mapped(alloc)) {
+	vma = binder_find_lock_vma(alloc, addr, &mm_locked);
+	if (!vma) {
 		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
 		ret = -ESRCH;
-		goto unlock;
+		goto out;
 	}
 
 	ret = vm_insert_page(vma, addr, page);
@@ -275,14 +324,13 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		 */
 		ret = 0;
 		__free_page(page);
-		if (!folio_walk_start(&fw, vma, addr, 0)) {
+		page = binder_page_lookup(alloc->mm, vma, addr, mm_locked);
+		if (!page) {
 			pr_err("%d: failed to find page at offset %lx\n",
 			       alloc->pid, addr - alloc->vm_start);
 			ret = -ESRCH;
 			break;
 		}
-		page = fw.page;
-		folio_walk_end(&fw, vma);
 		fallthrough;
 	case 0:
 		/* Mark page installation complete and safe to use */
@@ -296,8 +344,10 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		break;
 	}
 
-unlock:
-	mmap_read_unlock(alloc->mm);
+	if (mm_locked)
+		mmap_read_unlock(alloc->mm);
+	else
+		vma_end_read(vma);
 	if (page)
 		__free_page(page);
 out:
-- 
2.47.0.199.ga7371fff76-goog


