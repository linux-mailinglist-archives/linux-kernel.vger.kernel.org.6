Return-Path: <linux-kernel+bounces-426740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDAF9DF725
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 22:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEEA32814EB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 21:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F119A1D933A;
	Sun,  1 Dec 2024 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYPNMRtT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931531D8E10
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733088183; cv=none; b=rBs+L8d74pVwoQ4yw8jBLxjLTFwiqbtInHcV81NrtsV2T8w1mq3n1JqKhN4apguDUY6cDJyhtjumu26YGKJDl2ikaBavW68zsysTN0+dT9VXUOTXJfSQ/Fi40B4altpKyxcm/HefKtw0XJrY0q/sOXxaJ2dBO0ATLWtY4aClPQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733088183; c=relaxed/simple;
	bh=1rrfEw0ohQL9JMTBiEb7GsB38WqkjvEvkPExpDK2JPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwe25mahgidwQ+D7L6XKxJRS3Qvi8Ygm2VKcKSx/Y8J+8oSM8e1seJ6Oqc7lWc0aDiVufAaFz1tOkqpiuyxP0EKxekfP+brliFvmjwLvRIUttlpYVEk2MKBgFGDV0xtXYAk2Zc7WEml6j3KN9rJAGfLMI3DkOzBQAzUGIHOGZ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FYPNMRtT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733088177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eYuSsE1kcQK7m9nM+2EfixOkXvdk4hDxDm5g5MvtHpw=;
	b=FYPNMRtTDgAAqr+zK4Or9Mz+2IwlhuH6zklXpSwVKYtguuz4aqMS7yQKgFrepU/+BDP1ER
	HfWjcB+Vtqzs6XDiedxwcwXp4gb+93A4Li0VDtJrqNi8PJ1SlM7+0s/GxjXBT1J90YrKyq
	/4W6ktCWLXlyKiVMUcrD+HXI2RgruQU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-armYcqloOPWkxdp11jjrOw-1; Sun, 01 Dec 2024 16:22:55 -0500
X-MC-Unique: armYcqloOPWkxdp11jjrOw-1
X-Mimecast-MFC-AGG-ID: armYcqloOPWkxdp11jjrOw
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-466cc5287ffso44304801cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 13:22:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733088174; x=1733692974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYuSsE1kcQK7m9nM+2EfixOkXvdk4hDxDm5g5MvtHpw=;
        b=F23SzYspVCJq7qpTWeQFeoMj7AN5JeMYLlq5IfVp3DsuIGKMz+ZSfwAymuDuQnM5JA
         R/4yj0742KmuqLl0FgemKKboTZAWkcWu6QgdeLaSnSxh2YeMv3X1UAHuh+LE8EWEnDLc
         I3A6fv9Pyfm1P7Qy9KqXLXyoXA5FbfF3fnR0wmGQaUL4GSJuwOlUDX8qfidp9sKbiTE4
         K852s2D2PMQlg7ANaDYBCPWnDIGohuK283q1M/CuV2UmrkhOV83PyK615UDekn9D6SPH
         hB8bZOt5ZI7t2mWybERPtK+SXgzHLssBVC/1FxMIzv7VHg8rHmEuRSfK//7vNDP8TU2o
         gjqQ==
X-Gm-Message-State: AOJu0Yx0ideiCPc429TjkYpViuT//AX7Ne6SvF/KidrznnVPIiy7Okqo
	36grTzAjA6lpKskFAnXn79FR6EhLhDY1fnFSWuNMtyMY6K8Cdf1PrJpiez/PdOCPP7XDUEBh+2w
	E/WRj6mVHYHv6x4h6BzaHoNlqN49IwLq1XqH6S6PPtx30QF7WqxZTlwYE6MeUIYrUF2NKTMbcpo
	qc40XD1Zmyj+MSjaMnqYBA752NnWM14O8WrfpsjBi2Zas=
X-Gm-Gg: ASbGncvLw1sMNe077z4ekizAUrlprDTT8V3Yy9U+WWubaEfkQAZRqkUfMb5PVo0Ctr6
	bWTg2809jDyY4Yp16Vzn2OWNdgf3QFqvx673pEZ2ILoAJ2qtZuPUO8jdgLzF+Znq27u2QjEndpb
	/G6hWjQ5ZxeanSQ5RpbVFnjkOhCnDWxNFCnWY/WvT+h8fwIOHBurtGZE0/KwIODso+1eqXMLZLy
	v9pa/tiTAKUdRyCzmBlNhQHx9GWx01w/RgJbKo8iG1BX3xD2K2uKRLXfjlu4N+HZcLbXF45kI0r
	W4CbfA5pSfCan6DEsq7+v4Tl2w==
X-Received: by 2002:ac8:5a86:0:b0:466:a060:a484 with SMTP id d75a77b69052e-466b35264a8mr377536311cf.27.1733088173915;
        Sun, 01 Dec 2024 13:22:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEB36TOKW8CGRWjXDNI9ssLhVGE/dYfSeis1g4xl3UE1LIzQ+/MdfCEtO+Pg1Pp3wKjx4YPPw==
X-Received: by 2002:ac8:5a86:0:b0:466:a060:a484 with SMTP id d75a77b69052e-466b35264a8mr377535791cf.27.1733088173463;
        Sun, 01 Dec 2024 13:22:53 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c4249f0asm41278911cf.81.2024.12.01.13.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 13:22:52 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Rik van Riel <riel@surriel.com>,
	Breno Leitao <leitao@debian.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Ackerley Tng <ackerleytng@google.com>
Subject: [PATCH 3/7] mm/hugetlb: Rename avoid_reserve to cow_from_owner
Date: Sun,  1 Dec 2024 16:22:36 -0500
Message-ID: <20241201212240.533824-4-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241201212240.533824-1-peterx@redhat.com>
References: <20241201212240.533824-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old name "avoid_reserve" can be too generic and can be used wrongly in
the new call sites that want to allocate a hugetlb folio.

It's confusing on two things: (1) whether one can opt-in to avoid global
reservation, and (2) whether it should take more than one count.

In reality, this flag is only used in an extremely hacky path, in an
extremely hacky way in hugetlb CoW path only, and always use with 1 saying
"skip global reservation".  Rename the flag to avoid future abuse of this
flag, making it a boolean so as to reflect its true representation that
it's not a counter.  To make it even harder to abuse, add a comment above
the function to explain it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/hugetlbfs/inode.c    |  2 +-
 include/linux/hugetlb.h |  4 ++--
 mm/hugetlb.c            | 33 ++++++++++++++++++++-------------
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a5ea006f403e..665c736bdb30 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -819,7 +819,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		 * folios in these areas, we need to consume the reserves
 		 * to keep reservation accounting consistent.
 		 */
-		folio = alloc_hugetlb_folio(&pseudo_vma, addr, 0);
+		folio = alloc_hugetlb_folio(&pseudo_vma, addr, false);
 		if (IS_ERR(folio)) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			error = PTR_ERR(folio);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ae4fe8615bb6..6189d0383c7f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -682,7 +682,7 @@ struct huge_bootmem_page {
 
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
-				unsigned long addr, int avoid_reserve);
+				unsigned long addr, bool cow_from_owner);
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask,
 				bool allow_alloc_fallback);
@@ -1061,7 +1061,7 @@ static inline int isolate_or_dissolve_huge_page(struct page *page,
 
 static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 					   unsigned long addr,
-					   int avoid_reserve)
+					   bool cow_from_owner)
 {
 	return NULL;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8d4b4197d11b..dfd479a857b6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2956,8 +2956,15 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	return ret;
 }
 
+/*
+ * NOTE! "cow_from_owner" represents a very hacky usage only used in CoW
+ * faults of hugetlb private mappings on top of a non-page-cache folio (in
+ * which case even if there's a private vma resv map it won't cover such
+ * allocation).  New call sites should (probably) never set it to true!!
+ * When it's set, the allocation will bypass all vma level reservations.
+ */
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
-				    unsigned long addr, int avoid_reserve)
+				    unsigned long addr, bool cow_from_owner)
 {
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	struct hstate *h = hstate_vma(vma);
@@ -2998,7 +3005,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	 * Allocations for MAP_NORESERVE mappings also need to be
 	 * checked against any subpool limit.
 	 */
-	if (map_chg || avoid_reserve) {
+	if (map_chg || cow_from_owner) {
 		gbl_chg = hugepage_subpool_get_pages(spool, 1);
 		if (gbl_chg < 0)
 			goto out_end_reservation;
@@ -3006,7 +3013,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 	/* If this allocation is not consuming a reservation, charge it now.
 	 */
-	deferred_reserve = map_chg || avoid_reserve;
+	deferred_reserve = map_chg || cow_from_owner;
 	if (deferred_reserve) {
 		ret = hugetlb_cgroup_charge_cgroup_rsvd(
 			idx, pages_per_huge_page(h), &h_cg);
@@ -3031,7 +3038,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		if (!folio)
 			goto out_uncharge_cgroup;
 		spin_lock_irq(&hugetlb_lock);
-		if (!avoid_reserve && vma_has_reserves(vma, gbl_chg)) {
+		if (!cow_from_owner && vma_has_reserves(vma, gbl_chg)) {
 			folio_set_hugetlb_restore_reserve(folio);
 			h->resv_huge_pages--;
 		}
@@ -3090,7 +3097,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, pages_per_huge_page(h),
 						    h_cg);
 out_subpool_put:
-	if (map_chg || avoid_reserve)
+	if (map_chg || cow_from_owner)
 		hugepage_subpool_put_pages(spool, 1);
 out_end_reservation:
 	vma_end_reservation(h, vma, addr);
@@ -5317,7 +5324,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
 				/* Do not use reserve as it's private owned */
-				new_folio = alloc_hugetlb_folio(dst_vma, addr, 0);
+				new_folio = alloc_hugetlb_folio(dst_vma, addr, false);
 				if (IS_ERR(new_folio)) {
 					folio_put(pte_folio);
 					ret = PTR_ERR(new_folio);
@@ -5771,7 +5778,7 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 	struct hstate *h = hstate_vma(vma);
 	struct folio *old_folio;
 	struct folio *new_folio;
-	int outside_reserve = 0;
+	bool cow_from_owner = 0;
 	vm_fault_t ret = 0;
 	struct mmu_notifier_range range;
 
@@ -5840,7 +5847,7 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 	 */
 	if (is_vma_resv_set(vma, HPAGE_RESV_OWNER) &&
 			old_folio != pagecache_folio)
-		outside_reserve = 1;
+		cow_from_owner = true;
 
 	folio_get(old_folio);
 
@@ -5849,7 +5856,7 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 	 * be acquired again before returning to the caller, as expected.
 	 */
 	spin_unlock(vmf->ptl);
-	new_folio = alloc_hugetlb_folio(vma, vmf->address, outside_reserve);
+	new_folio = alloc_hugetlb_folio(vma, vmf->address, cow_from_owner);
 
 	if (IS_ERR(new_folio)) {
 		/*
@@ -5859,7 +5866,7 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 		 * reliability, unmap the page from child processes. The child
 		 * may get SIGKILLed if it later faults.
 		 */
-		if (outside_reserve) {
+		if (cow_from_owner) {
 			struct address_space *mapping = vma->vm_file->f_mapping;
 			pgoff_t idx;
 			u32 hash;
@@ -6110,7 +6117,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 				goto out;
 		}
 
-		folio = alloc_hugetlb_folio(vma, vmf->address, 0);
+		folio = alloc_hugetlb_folio(vma, vmf->address, false);
 		if (IS_ERR(folio)) {
 			/*
 			 * Returning error will result in faulting task being
@@ -6578,7 +6585,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			goto out;
 		}
 
-		folio = alloc_hugetlb_folio(dst_vma, dst_addr, 0);
+		folio = alloc_hugetlb_folio(dst_vma, dst_addr, false);
 		if (IS_ERR(folio)) {
 			ret = -ENOMEM;
 			goto out;
@@ -6620,7 +6627,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			goto out;
 		}
 
-		folio = alloc_hugetlb_folio(dst_vma, dst_addr, 0);
+		folio = alloc_hugetlb_folio(dst_vma, dst_addr, false);
 		if (IS_ERR(folio)) {
 			folio_put(*foliop);
 			ret = -ENOMEM;
-- 
2.47.0


