Return-Path: <linux-kernel+bounces-402246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FB39C2569
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0611D28603E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86391F26F1;
	Fri,  8 Nov 2024 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xJcc1fsG"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE371F26CD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093085; cv=none; b=geAwBIn4CbHxQjahVjY08Xsz7PTz1VcKV1PzyOrhSldJsPMJfTUUtDZI/51HLn004uMZ4txidEZnaG1y0C5dGGcG31QTM/lv1995NtC8Omp6nvKkOjtlNaenyjsh/zzXIjkcydy0X8O+ZkPz4qmL8k+RfukwU9clLh4HxcDDNGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093085; c=relaxed/simple;
	bh=Zf14GsUaaV/Hd+n5Eqit8C7fwMts9LP+7onXrbB1zbo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VoPanZ1egdUctTOQhm+Y2789AG4AuZHfHn+pd9CxSMHL210okWy6G8/mCGOy6TkcfGJX8XXdXnhu6HBK2WXFiDM+bQ9xh42lMqigD97zmpGipeSCgBOxVjga/9Ua54jJl68Pf7VgaChMecHXba+snhqxDK5W1mF8yHS/SaUMtUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xJcc1fsG; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e58e838d5so2530355b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 11:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731093083; x=1731697883; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bihSAmRaHDXTnS0e+3LMpgHo5grgLUy7mkmndxXDooA=;
        b=xJcc1fsGlRhYVqYC7ul6OgNIleIgmV1WM7UKpwjv9RIqgoWGmSfIg6+2cKc2/x/Pto
         AzCpBLV/5DsuYA/Ubg9TaWtsO+aBxSX3Sbbpn8OurDpC9qEDfyXqLsOS87keJjoQabtE
         ZA4tVe3+c8AcRsHs9j5k8vieoPCYJBBQvWQ/9MwX74aQpV3OYs+/At2weLAUDHlJUgWA
         qQn/emwfFEjExuBxDV129ZTRYzrYGKkCeODqO69sdB7xZ9bLy795u1QzjFHTeCcUXSMy
         Qtpv5aRMdOl1y3A+LTYP1VnJ6aTQXl5oWxtvhlik3pni1bMC0U077h4/XBfmy5b1SPk7
         0jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731093083; x=1731697883;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bihSAmRaHDXTnS0e+3LMpgHo5grgLUy7mkmndxXDooA=;
        b=ehJ2iYc9a+QBgyeePM3obEAIhLrbh/+tu79hR3HdULo5f2xYyPbqaoSIK3IEJ4Eq89
         +S7AB3QQXV/m4QL4F9u0OoZiWaR2+EsPxd18IhTGfeXdA3sEjxiF/kGS2fXgBHUjwSBP
         XmJJm/k9DvJg97jnLZjX2uXFdMb8m1FrKum87SFroUKdpQuthLAczTrOgc086kDTupNK
         UfjELMLkcdlt145xrm75H30RKyVcbsp7lzvCfcGLHQvi024lLVq6P5E1/CrFNQhhC43s
         fAcC9UWelxh0/+WujM/DupbXj3I/0sFH6LFcoP/T9D+5+sNtgHGUSYphd/On6xNjD/ci
         0Oeg==
X-Gm-Message-State: AOJu0YzLofysfYoesvEK2Cilbai3Rk1BmFvVZfyzDVtolV1V0SrrdeYy
	O/kozmKu8Y36p46yhCtsAuvneFgCLCYnc2X+Wge1eeculIC4PsrigoslsYXGfcWTiKX/NcLZjCo
	pzNPDeoGdTA==
X-Google-Smtp-Source: AGHT+IFIkRKPr2Ao3obMPDZOnF/7hv7AraUE5ymQZDdJ7T8jv+4v4wWT8CDAJleJwFtW94pytjTbOy2oMM4Bkg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:2e9e:b0:71e:5dff:32dd with SMTP
 id d2e1a72fcca58-72413297368mr282628b3a.2.1731093083057; Fri, 08 Nov 2024
 11:11:23 -0800 (PST)
Date: Fri,  8 Nov 2024 19:10:49 +0000
In-Reply-To: <20241108191057.3288442-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108191057.3288442-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241108191057.3288442-8-cmllamas@google.com>
Subject: [PATCH v3 7/8] binder: use per-vma lock in page installation
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
 drivers/android/binder_alloc.c | 61 +++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 3716ffd00baf..7d2cad9beebb 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -233,6 +233,48 @@ static inline bool binder_alloc_is_mapped(struct binder_alloc *alloc)
 	return smp_load_acquire(&alloc->mapped);
 }
 
+static struct page *binder_page_lookup(struct binder_alloc *alloc,
+				       unsigned long addr)
+{
+	struct mm_struct *mm = alloc->mm;
+	struct page *page;
+	long ret = 0;
+
+	mmap_read_lock(mm);
+	if (binder_alloc_is_mapped(alloc))
+		ret = get_user_pages_remote(mm, addr, 1, 0, &page, NULL);
+	mmap_read_unlock(mm);
+
+	return ret > 0 ? page : NULL;
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
 				      unsigned long index,
 				      unsigned long addr)
@@ -254,9 +296,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 				      unsigned long index,
 				      unsigned long addr)
 {
-	struct vm_area_struct *vma;
 	struct page *page;
-	long npages;
 	int ret;
 
 	if (!mmget_not_zero(alloc->mm))
@@ -268,16 +308,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		goto out;
 	}
 
-	mmap_read_lock(alloc->mm);
-	vma = vma_lookup(alloc->mm, addr);
-	if (!vma || !binder_alloc_is_mapped(alloc)) {
-		__free_page(page);
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
@@ -287,8 +318,8 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		 */
 		ret = 0;
 		__free_page(page);
-		npages = get_user_pages_remote(alloc->mm, addr, 1, 0, &page, NULL);
-		if (npages <= 0) {
+		page = binder_page_lookup(alloc, addr);
+		if (!page) {
 			pr_err("%d: failed to find page at offset %lx\n",
 			       alloc->pid, addr - alloc->vm_start);
 			ret = -ESRCH;
@@ -306,8 +337,6 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		ret = -ENOMEM;
 		break;
 	}
-unlock:
-	mmap_read_unlock(alloc->mm);
 out:
 	mmput_async(alloc->mm);
 	return ret;
-- 
2.47.0.277.g8800431eea-goog


