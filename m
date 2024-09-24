Return-Path: <linux-kernel+bounces-336585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC5E983CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CEB01C21987
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3B35A79B;
	Tue, 24 Sep 2024 06:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="B5VUyCKx"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE91126BF6
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158266; cv=none; b=CmAUszmozPHhHmuF963kWs5xlwbWpCQdM9g4Nd6pGph411gTC7B/1D9WNiCbnss/4QwBq4I511if2JrISo0sS4Hlmz720EBmj6zNOfVRcXr1CH0CoLZZBKo4QbnJoV0bZLYYgA3B3Bf9PEsfSS1sFAEJA/qzNZuHUcSAsdTDD3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158266; c=relaxed/simple;
	bh=cUqvPzkChjavQi5ll+6QC49FMZw8M0EOQ/mq6UklpII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E2d9u5xctNVD7Iv2CEUvwIKQqISnCW1VcvQsHALNedA5jSKLKxQOSBrr3iI22OaF/hV2Ysriw7AUv0okOUJncB15P7CXvHAbiN47foht5DW/QZpYYAsP0edpVZnjoTk5LBnW3UMSvCDZ5oTLNpnIymWQzElzeiQ/4L8dQNwz4cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=B5VUyCKx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-206aee40676so41322505ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727158264; x=1727763064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqTOjUnPHL3XRjrt8I2PlSfGhzwzG7n3dPRatvbgECo=;
        b=B5VUyCKxnQSCrR0T912xOurp7HUfyVmfG9IuLLH/NuDVTAhd/uZl71VbJx6HOotOjt
         uwe5q96lAHCfH0R+KwNxxA2/AEWXmda8CKQt472QJWkG0VGbz0ssci06dSw8ZBJFv9nK
         BqWtfh8p5uKalTpo6gV+zprKjb41nilqdzHiF1/kwh4pHm5TVCMtIZMUdzzlsPMlXmiZ
         qats42sBtixJn4FXE9+SwXutKTqWWn87Wu8hCB6Dml3YhKKkkadHL+qQGXZFJ0s9V6Yt
         Ccz8I6M1sS46cRaOb+U0MCcx3IDmRbsxp4uZuim+vj1xfNalWsbAxcC5udn2sPSzwV6r
         5B2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727158264; x=1727763064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqTOjUnPHL3XRjrt8I2PlSfGhzwzG7n3dPRatvbgECo=;
        b=V9tZtqqpMQ7UvQ4Q8v6xld0Htx0YO93mZhK3coONEUJSwthn5OB3hvhxl99db+7jtu
         gOiKa40D50hH3sJ4vlnXOWpdGZoVjubaumrcyI9IAa2+XqqHo9NvbiArir2u4P9Vz547
         0zjFRyep7jW2gb+zJ5up9XiPgxNPkP7pcr1rTvg2SV4KFfeFW1+MO1mDC55+JwzvW10F
         ppStymExcWS7AJBHIO8g1DLt+zyqsvfOXf0nMpsCUfK3Phbz1JsD9z6CkYKirI17fStY
         cIrPENO6+PW+yPhkUqnj/DmbEUL45H/ZpSeGIDeyzAV2p+eWN9EKU9FkcNB3M2AGJUij
         fDNQ==
X-Gm-Message-State: AOJu0YyM4XcjxmWQlvnJ7qk/Z5aF2Xyxip9mGV4OyC42gLVIJ9yH6sqQ
	ca21IcuF9wLTCZKePB/kiLESEO92kjwc3OgfDhMkQ1Y3JP9XCqAKY6LG4oYKtRM=
X-Google-Smtp-Source: AGHT+IGIKI1reF9Jfo+dWimmN1cyjgiGD8qn8mcbfIJc2tOglwlNFzTXQQXYEG1VSSXByHdLorgo7Q==
X-Received: by 2002:a17:903:944:b0:205:4e15:54c8 with SMTP id d9443c01a7336-208d8440f7amr165611365ad.61.1727158259613;
        Mon, 23 Sep 2024 23:10:59 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17229c9sm4344885ad.85.2024.09.23.23.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:10:59 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	vishal.moola@gmail.com,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	christophe.leroy2@cs-soprasteria.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 05/13] arm: adjust_pte() use pte_offset_map_rw_nolock()
Date: Tue, 24 Sep 2024 14:09:57 +0800
Message-Id: <f2359e4fe8b9806e878e6b28c4594d741137faf9.1727148662.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1727148662.git.zhengqi.arch@bytedance.com>
References: <cover.1727148662.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In do_adjust_pte(), we may modify the pte entry. The corresponding pmd
entry may have been modified concurrently. Therefore, in order to ensure
the stability if pmd entry, use pte_offset_map_rw_nolock() to replace
pte_offset_map_nolock(), and do pmd_same() check after holding the PTL.

All callers of update_mmu_cache_range() hold the vmf->ptl, so we can
determined whether split PTE locks is being used by doing the following,
just as we do elsewhere in the kernel.

	ptl != vmf->ptl

And then we can delete the do_pte_lock() and do_pte_unlock().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
Hi David and Muchun, I did not remove your Acked-by and Reviewed-by tags since
there is no functional change.

 arch/arm/mm/fault-armv.c | 53 +++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 831793cd6ff94..2bec87c3327d2 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -61,32 +61,8 @@ static int do_adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	return ret;
 }
 
-#if defined(CONFIG_SPLIT_PTE_PTLOCKS)
-/*
- * If we are using split PTE locks, then we need to take the page
- * lock here.  Otherwise we are using shared mm->page_table_lock
- * which is already locked, thus cannot take it.
- */
-static inline void do_pte_lock(spinlock_t *ptl)
-{
-	/*
-	 * Use nested version here to indicate that we are already
-	 * holding one similar spinlock.
-	 */
-	spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
-}
-
-static inline void do_pte_unlock(spinlock_t *ptl)
-{
-	spin_unlock(ptl);
-}
-#else /* !defined(CONFIG_SPLIT_PTE_PTLOCKS) */
-static inline void do_pte_lock(spinlock_t *ptl) {}
-static inline void do_pte_unlock(spinlock_t *ptl) {}
-#endif /* defined(CONFIG_SPLIT_PTE_PTLOCKS) */
-
 static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
-	unsigned long pfn)
+		      unsigned long pfn, struct vm_fault *vmf)
 {
 	spinlock_t *ptl;
 	pgd_t *pgd;
@@ -94,6 +70,7 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	pmd_t pmdval;
 	int ret;
 
 	pgd = pgd_offset(vma->vm_mm, address);
@@ -112,20 +89,33 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	if (pmd_none_or_clear_bad(pmd))
 		return 0;
 
+again:
 	/*
 	 * This is called while another page table is mapped, so we
 	 * must use the nested version.  This also means we need to
 	 * open-code the spin-locking.
 	 */
-	pte = pte_offset_map_nolock(vma->vm_mm, pmd, address, &ptl);
+	pte = pte_offset_map_rw_nolock(vma->vm_mm, pmd, address, &pmdval, &ptl);
 	if (!pte)
 		return 0;
 
-	do_pte_lock(ptl);
+	/*
+	 * If we are using split PTE locks, then we need to take the page
+	 * lock here.  Otherwise we are using shared mm->page_table_lock
+	 * which is already locked, thus cannot take it.
+	 */
+	if (ptl != vmf->ptl) {
+		spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
+		if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
+			pte_unmap_unlock(pte, ptl);
+			goto again;
+		}
+	}
 
 	ret = do_adjust_pte(vma, address, pfn, pte);
 
-	do_pte_unlock(ptl);
+	if (ptl != vmf->ptl)
+		spin_unlock(ptl);
 	pte_unmap(pte);
 
 	return ret;
@@ -133,7 +123,8 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 
 static void
 make_coherent(struct address_space *mapping, struct vm_area_struct *vma,
-	unsigned long addr, pte_t *ptep, unsigned long pfn)
+	      unsigned long addr, pte_t *ptep, unsigned long pfn,
+	      struct vm_fault *vmf)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *mpnt;
@@ -160,7 +151,7 @@ make_coherent(struct address_space *mapping, struct vm_area_struct *vma,
 		if (!(mpnt->vm_flags & VM_MAYSHARE))
 			continue;
 		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
-		aliases += adjust_pte(mpnt, mpnt->vm_start + offset, pfn);
+		aliases += adjust_pte(mpnt, mpnt->vm_start + offset, pfn, vmf);
 	}
 	flush_dcache_mmap_unlock(mapping);
 	if (aliases)
@@ -203,7 +194,7 @@ void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
 		__flush_dcache_folio(mapping, folio);
 	if (mapping) {
 		if (cache_is_vivt())
-			make_coherent(mapping, vma, addr, ptep, pfn);
+			make_coherent(mapping, vma, addr, ptep, pfn, vmf);
 		else if (vma->vm_flags & VM_EXEC)
 			__flush_icache_all();
 	}
-- 
2.20.1


