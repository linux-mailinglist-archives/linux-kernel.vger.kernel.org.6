Return-Path: <linux-kernel+bounces-406644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0463F9C62FF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C12A2B636F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A80F219E55;
	Tue, 12 Nov 2024 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sMv7+KD1"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8200219E39
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440814; cv=none; b=OHlR2cwiwIQEKO/sr3teJOI7tFepjNNFTBpzDsxhm4mLP7P6Vy6hd2AeFmnxxfEXJ0j6rMthGYZa3UAoHYQv107DJrBv3gF/+C5A4gj2XGY3dSkv58E9JDdi03X7swHlKKMjyGpPIlI0f4TxjLAK+VVK4ax0J6vxk+ETYCqoWeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440814; c=relaxed/simple;
	bh=YKtXb1PXNfYRfTpUn/jInuvLjoizjOFbByYQH+ZuGoY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o49BvzPXC87CnqJrlLyqM2PHljYug6ZpChKf+MOlhxEXe6/BRUqsxGv/jIpAI4KHagrEQ8L65F6ZAXrf7B2aS+Jppb99L5afn+gc49xNWLrNlKPQ18WSR7NtKUP0MxsHWxreEDD/GCnd6sGPXlbBgRB67waP6oHEiZEbP7RN184=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sMv7+KD1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6eb0a1d0216so40616627b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731440812; x=1732045612; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1CCbcAxwVITlach3ohAL8Fs+Rkv4PQfEREgrvS8KzA=;
        b=sMv7+KD1zflUCDWe4IXAAc+UPtsYiSkLS2GPpijQm91av/fajUJXtSAo6QTBTJ99s1
         KWv3V1yr1M0p4VTysTrrqw8ce13v/vOCuxbs5XndZQxIH7R2BQicyn0V4BWia/RTiqRu
         brvzXWtpR+djfEBjSJXkbGiHVUXi2et+IMn4C0x5VeSz9gWYz034N5hY7vIkJ45kF+uj
         tvNWoC47Lu3TUw9nKTTqgFt36+WrPN9+5J6et7mg9SKSje4N1e2YHc1GojXggWVgllvT
         ijGj/4dIOBU007ZgIaFHhQbmhhvFnGaaTZRZRQUtuIPS3zcaURcw93pbwb1cC3brta1k
         1rxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731440812; x=1732045612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1CCbcAxwVITlach3ohAL8Fs+Rkv4PQfEREgrvS8KzA=;
        b=qs9LYjuA+GyEpi9FlWVALk641gtBgAJdmXKWPaFPn715gBQR5qziTmXFx+Z9XFCDE7
         9jSwSvPyzd6BagxEBeahRST0aIjetEFhdsRpEvcjWwZWvlSN7pOKBEaYB+ugwPGJ5Ell
         slpQJIUp2Wc0DLCG93dLB3ew5LOmROSFUJ2MfM5PRFueD0APZC5syyzMiW7zvQZFgtWP
         awrbScHoF6uNgcCD2xvWETftWDpueBLmvOfthOUZn26sergufCXT1IaMu97bhgSDlAAt
         Rf9gyJToaijL0INCgKO/YrR5wTiaEDVIku+5hgfqDNNlyhFZAk0aGP+RcUZIbzxsjhVZ
         MMrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWnM9dSLVWK3a8pd595u6QCwZpUhN1YjdwlkLDd3OfQx/zbeAKuZkAgd0g1PwVCcnGeZLFTBUyOXnIjPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy87jul1EhzFInQMI/Xkw6y+eZLaehgx5M7d9CUFi9J/Hz5wSQH
	lEqqJiFyHw1ZdLAXoZW35Ly5TLWT654TRl1j+ErFdbBx76aYECsA9ayCmN4vblE7uVwoNmE14cL
	COw==
X-Google-Smtp-Source: AGHT+IEq0LcdS3gaxVGqCSmSAjHrghcWgLVyn1pnLLC1ahL+sX7JpJH17PWyfqB3xOS3eIrVCs2OBxnyQWY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:cad5:5dc6:1298:ec42])
 (user=surenb job=sendgmr) by 2002:a25:dc92:0:b0:e28:eaba:356a with SMTP id
 3f1490d57ef6-e337f8f04e4mr71200276.9.1731440811893; Tue, 12 Nov 2024 11:46:51
 -0800 (PST)
Date: Tue, 12 Nov 2024 11:46:33 -0800
In-Reply-To: <20241112194635.444146-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241112194635.444146-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112194635.444146-4-surenb@google.com>
Subject: [PATCH v2 3/5] mm: mark vma as detached until it's added into vma tree
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Current implementation does not set detached flag when a VMA is first
allocated. This does not represent the real state of the VMA, which is
detached until it is added into mm's VMA tree. Fix this by marking new
VMAs as detached and resetting detached flag only after VMA is added
into a tree.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h               | 10 +++++++++-
 mm/memory.c                      |  2 +-
 mm/mmap.c                        |  2 ++
 mm/nommu.c                       |  2 ++
 mm/vma.c                         |  3 +++
 tools/testing/vma/vma_internal.h |  3 ++-
 6 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a5eb0be3e351..245a85caf4c3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -812,6 +812,11 @@ static inline void vma_mark_detached(struct vm_area_struct *vma, bool detached)
 	vma->detached = detached;
 }
 
+static inline bool is_vma_detached(struct vm_area_struct *vma)
+{
+	return vma->detached;
+}
+
 static inline void release_fault_lock(struct vm_fault *vmf)
 {
 	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
@@ -874,7 +879,10 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &vma_dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
-	vma_mark_detached(vma, false);
+#ifdef CONFIG_PER_VMA_LOCK
+	/* vma is not locked, can't use vma_mark_detached() */
+	vma->detached = true;
+#endif
 	vma_numab_state_init(vma);
 	vma_lock_init(vma);
 }
diff --git a/mm/memory.c b/mm/memory.c
index 209885a4134f..d0197a0c0996 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6279,7 +6279,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 		goto inval;
 
 	/* Check if the VMA got isolated after we found it */
-	if (vma->detached) {
+	if (is_vma_detached(vma)) {
 		vma_end_read(vma);
 		count_vm_vma_lock_event(VMA_LOCK_MISS);
 		/* The area was replaced with another one */
diff --git a/mm/mmap.c b/mm/mmap.c
index 386429f7db5a..1295c4cedaf4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1570,6 +1570,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
 		goto mas_store_fail;
 
+	vma_mark_detached(vma, false);
 	mm->map_count++;
 	validate_mm(mm);
 	ksm_add_vma(vma);
@@ -1890,6 +1891,7 @@ static struct vm_area_struct *__install_special_mapping(
 	if (ret)
 		goto out;
 
+	vma_mark_detached(vma, false);
 	vm_stat_account(mm, vma->vm_flags, len >> PAGE_SHIFT);
 
 	perf_event_mmap(vma);
diff --git a/mm/nommu.c b/mm/nommu.c
index 9cb6e99215e2..6afd5c2bd97d 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1192,6 +1192,7 @@ unsigned long do_mmap(struct file *file,
 	current->mm->map_count++;
 	/* add the VMA to the tree */
 	vma_iter_store(&vmi, vma);
+	vma_mark_detached(vma, false);
 
 	/* we flush the region from the icache only when the first executable
 	 * mapping of it is made  */
@@ -1357,6 +1358,7 @@ static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	setup_vma_to_mm(vma, mm);
 	setup_vma_to_mm(new, mm);
 	vma_iter_store(vmi, new);
+	vma_mark_detached(new, false);
 	mm->map_count++;
 	return 0;
 
diff --git a/mm/vma.c b/mm/vma.c
index 8a454a7bbc80..1426871fa6e0 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -275,6 +275,7 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
 		 * (it may either follow vma or precede it).
 		 */
 		vma_iter_store(vmi, vp->insert);
+		vma_mark_detached(vp->insert, false);
 		mm->map_count++;
 	}
 
@@ -1690,6 +1691,7 @@ int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 
 	vma_start_write(vma);
 	vma_iter_store(&vmi, vma);
+	vma_mark_detached(vma, false);
 	vma_link_file(vma);
 	mm->map_count++;
 	validate_mm(mm);
@@ -2369,6 +2371,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
 	vma_iter_store(vmi, vma);
+	vma_mark_detached(vma, false);
 	map->mm->map_count++;
 	vma_link_file(vma);
 
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 1d9fc97b8e80..fdb60978821f 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -438,7 +438,8 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &vma_dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
-	vma_mark_detached(vma, false);
+	/* vma is not locked, can't use vma_mark_detached() */
+	vma->detached = true;
 }
 
 static inline struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
-- 
2.47.0.277.g8800431eea-goog


