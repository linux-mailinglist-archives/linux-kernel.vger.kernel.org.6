Return-Path: <linux-kernel+bounces-414837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8579D2E01
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6781F23008
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F36F1D79A4;
	Tue, 19 Nov 2024 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JmJXj3Ri"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BEA1D6DA9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041194; cv=none; b=I4kewWhcA4lDt9D06qQ17YZkVgrieWYa/eOGUzKjre4Iv0x241NZL+6CDJuWpxEtOgGyRoOrC912SST2LLcz8AirTKFZWyqY3eQcH2rMWK5ZyX60TCVdAPIsqM36Y3ijV5Z8V0DjaPu9MwEvsZZMS6G4Ul1NR3lL6B4u7BTQPoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041194; c=relaxed/simple;
	bh=ZFfObOEuO1vLP5HevUD6BdJRdLDoEknLUF/lgQIYqoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kl4IS20DpcUB85Y6T626gDvFczntkUcilMHqj9LjEQ/6RnxHZVbYgvD00jj0TCPuXFQb2/yYbP9XQj9oxbTYox604/9SP8sz2eKIOLESvz4sRC/aTRIEfu6KO20AAtGr1JkvEnK0AVK/y4LpTDXAv8Hm5fhA5Nom7GAsQV54Tnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JmJXj3Ri; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71e51a31988so3776718b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732041192; x=1732645992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1MLxi0fM3sWNzEe2yYI4m7Zvs0DMIqXAh40zCoKo1As=;
        b=JmJXj3Rig9bbakwtiPe/voachTnT0u56h20PmWm+XwC3lbooUW1UVJugPzt7EfDJPR
         w1ps67zKR2Or+UGktrqtRB7tPhwyMFAGj6Nr4haJWh412fbG2oj+X5Ll5/0f5x9naJlC
         R/LQtQR0ZRxHQb7jccI8hggiry3uYr9I1zDR1ILkjfn7zXrgeK8Bz8uRLGM6qwxFdxb1
         gaaeQai0ou8l4ckLPGnlrI9BJvrnvcAOcVnnYm+li+dNchw2ObKDaCJm2HF8FOd28stB
         Un0pxeqTsrmBj7SOFp/5wdW5ptzZ1KlSh3Cz7ohowMhdQnptL755T/8Bu1Nrga80CTzs
         dqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732041192; x=1732645992;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MLxi0fM3sWNzEe2yYI4m7Zvs0DMIqXAh40zCoKo1As=;
        b=LwyBp032+qjdlUqqRcNXzn4SuVaujC0pY6gDkZFUotBtDrrNLUxOa11IrJkz7QtYYr
         B246nxBYAJNo6+4m3BTzScjjKV1C0vfJAIzYEob+8qy5uX28nBIq4O26UCDSeJkn8mG5
         hUWI5bMj+0zLF8VQn+Zb1n+faxXwrJjB/hDlS3L3O3EgjkYU7va14XVKz8YZOBEeqG9a
         QSbqcmUXkX6LlKIcyxh2ZTQjHdLOtya1KcMN7nZlkre13QiGkaIEBPPk6W2Z0QG9wrI9
         qQYjL+NUoCbpuQtWu/OhQONCTT+pRqRikDBl/cxP65ctLTr5h5Nq9QOA4Ostb4OJMrxq
         /Qxg==
X-Gm-Message-State: AOJu0YwakUep228Aw+9CK3q7XTKoasye3yZr1tCrHLqNr1+nZgVZ8trB
	15Fa2L7RUfbP/NmDGdmlwIcFJr2kiHAODkNQKyi3Qda/qV/KBltID8Q2HICc9UKTAr/qXXg+wTM
	M99YLZEmesw==
X-Google-Smtp-Source: AGHT+IGm507puIcsXl7gmG3qfuGnLlzJrXUJHjRkZ/l4ObK+tYKQGV+VAOBGu7wl2abL/zkVrlUZOw+ZXHkp6A==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:aa7:88c9:0:b0:71e:5e50:755e with SMTP id
 d2e1a72fcca58-72477110770mr83380b3a.6.1732041192296; Tue, 19 Nov 2024
 10:33:12 -0800 (PST)
Date: Tue, 19 Nov 2024 18:32:40 +0000
In-Reply-To: <20241119183250.3497547-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119183250.3497547-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241119183250.3497547-8-cmllamas@google.com>
Subject: [PATCH v4 7/9] binder: use per-vma lock in page installation
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
index 553efe110aac..f5dbaf1d7d65 100644
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
 				      unsigned long index,
 				      unsigned long addr)
@@ -254,9 +301,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 				      unsigned long index,
 				      unsigned long addr)
 {
-	struct vm_area_struct *vma;
 	struct page *page;
-	long npages;
 	int ret;
 
 	if (!mmget_not_zero(alloc->mm))
@@ -268,16 +313,7 @@ static int binder_install_single_page(struct binder_alloc *alloc,
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
@@ -287,9 +323,8 @@ static int binder_install_single_page(struct binder_alloc *alloc,
 		 */
 		ret = 0;
 		__free_page(page);
-		npages = get_user_pages_remote(alloc->mm, addr, 1,
-					       FOLL_NOFAULT, &page, NULL);
-		if (npages <= 0) {
+		page = binder_page_lookup(alloc, addr);
+		if (!page) {
 			pr_err("%d: failed to find page at offset %lx\n",
 			       alloc->pid, addr - alloc->vm_start);
 			ret = -ESRCH;
@@ -307,8 +342,6 @@ static int binder_install_single_page(struct binder_alloc *alloc,
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


