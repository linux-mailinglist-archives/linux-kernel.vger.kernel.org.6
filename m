Return-Path: <linux-kernel+bounces-439739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546769EB363
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3A41888855
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1238B1BEF81;
	Tue, 10 Dec 2024 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cU+xtOn3"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F2C1BDAA0
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841110; cv=none; b=p5Ykn0YZyqHxmi32AskZZcg9PO9z1Jqf1JziFQxDkRWBbafSp9z1SRgy2uj4ABixcuzpz/wq9e7/6mQ/rXSkPt2PH8A62ecWkhHxf4WYBMxRxzBLM7qJMeKcsgHB4QuBN/G0I7xkujV5l2OfDm99pAbUabRJzdCh86XlQmYEsUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841110; c=relaxed/simple;
	bh=rO1N2rkVYmws1D0z0gpSDLKI0Y6nPBUE524EjEd+Y5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hx0f9UIN9+r00EpU9Zxryg4f+T0RKroNH/rn5vFwywtF5Br4icN2BAquYbEsJw3dDXi3zGWWuOc+XxuFLzEpEdmDlIl1Uj+ogbzP5pbxaSSCAwOMZWkbeNRRCPo1D4vc2lx0sOch5ziUcgSXSW/ia1FVbhewRpzG0TOV0odfFg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cU+xtOn3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7273a901821so1239401b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733841108; x=1734445908; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v9iHcIMEhyrv4IhgIRMWwr7V9q9LzPr5KpOSI5lhdso=;
        b=cU+xtOn33DsOMiEP+PHSBunCkxrB5MQTtqbDt2HpJA0fo99bay0HmVTHN2Y4CfrKDU
         zMpPqwdhtcVo1SXIkehXyRr0An6UyCpnDdu6Ptyz+INVOGzEO/oFcwRWT9xrMajkGNLT
         7aVat1j522LH+aODP9evN53nIxsy1KwdfuNSaIn2yTtfpeAxTReR7WpIb1J0SWgIrFmx
         zqEoPRP8cs80nsxhdUHELr2rUNAFVFZXeEMgfaCbRNvhjTBCiiKijJxdYMfU5NIAAFIn
         VmqRgJRWy+GTL5gEPnYRFBkrPfLUeJpHqxkznhjn7gP7cf61dmhQJpTdBr4zdkXXuQIu
         39nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841108; x=1734445908;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v9iHcIMEhyrv4IhgIRMWwr7V9q9LzPr5KpOSI5lhdso=;
        b=peGYDIFAuaNqQYBwnRzcSTJDa3VALo6AOAXpVMkEVItFDgf+RCQWuKaX2TNSokxY1r
         0/Xkc4mgOZPdHvPoS+v5nurEJ5x1Zhde/YZ7w0OSK40qaZk3wnHecINqgIRjRSorLwtR
         g3ruIJnvgYEC6gaoFtjKT5Fa728PkoUjtvHCxKlGFdXJsrzgvR9SGf20/+1Xe9aW10pk
         uWEpdPOMaun1kO0jV6+sTADnHhcRMwEqoDp1Dk8LbLtaIjPwimChuv0Z970UrAhG3D2t
         MUCfVNTZltzMNfHOtAQBpBK1uZ4g1FbTdF+CykV+pebDv1lpGw27q5VDLFc6FvtCCH++
         N8cw==
X-Gm-Message-State: AOJu0Yxj5154bR+AporA5JVhkCClBhqd90Ds0fRkMlU/HtWxJu8uWzL6
	jVZ3ELHkyM6VhSx1Hw/w+PlWayQktW62Y0LStsxmwjnmn/Xqo7QSw31Dou7EYzS4tVwTGW1LXLa
	vsjm7PPH4Fg==
X-Google-Smtp-Source: AGHT+IGBybGYX7qQAcCrdzEFZ2ItREUhqifbG4xR18XyvsIuH7ifP5Cg3Z19KNpxgcTxCUdusooUb37r14zc2A==
X-Received: from pfbbu3.prod.google.com ([2002:a05:6a00:4103:b0:725:e60b:1e4f])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:ae16:b0:725:db34:6a7d with SMTP id d2e1a72fcca58-725db346d85mr16204674b3a.23.1733841108144;
 Tue, 10 Dec 2024 06:31:48 -0800 (PST)
Date: Tue, 10 Dec 2024 14:31:03 +0000
In-Reply-To: <20241210143114.661252-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210143114.661252-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210143114.661252-8-cmllamas@google.com>
Subject: [PATCH v7 7/9] binder: use per-vma lock in page installation
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
index 9cb47e1bc6be..f86bd6ded4f4 100644
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


