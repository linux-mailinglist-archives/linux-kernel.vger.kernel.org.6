Return-Path: <linux-kernel+bounces-339969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E819986CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EEF2282FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A4D18BC10;
	Thu, 26 Sep 2024 06:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="H2L8G213"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C06818D621
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333249; cv=none; b=lqUm+C0yTUel9O77hPeS1L72RKRHqX3BRrOr/PFHrBUZ/EEtWltBOu3oQjYzz9ZumLDsJ404PUEeY3V3ONrYlD+f7Vj0kfUGD5ibzxb8D+dsnPacRzvdzMQYvXS4pf2EcdPERnSUCkVsLeUDNB973Ft4ad6MVP7koacHGyGDRtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333249; c=relaxed/simple;
	bh=29OR+TVmri3kqIvPShCpc5yTrHLSKlzLO/ZlFINbxMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hI8wHOyb1H7TM/gCUb7FJwjTwhqlgnD+uvyMOk412hgEshP5b7++alNLMT10n2/+zVwqf2o4LJEyP0ETrMWWTxVJdwdC9dVhu5LihatiMKy0vGNnN8aspxHsjN9Pb3ZWkwpuW44RWLHv89+C3FBJcur6fGfHIEo2WamO7dZVtQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=H2L8G213; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-45832b2784bso4621261cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727333246; x=1727938046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXy51M36oXFNN3kWVEF6T1v76BlvE2cEswNH4MTPbjU=;
        b=H2L8G213bOzJ2yhf/l0PdUzYarrxzmDIqkPlqQfUjc8yUH4DPdn0c1opY/nkQobSqO
         bNsNs/LTpsUOEUSEzi7/ekqAVQylI04nUez7qotyiOi1kd+92grdjTfdgmAosjusanko
         1wuggjcnqQRiIkGL+Qy6Dd0lbSd3LPOcPOkmZ0tQS3KRLmsxi2+A/O834XD2iy8B9Iot
         0gl1P6obaIiCs383+vrtC3K1337de2ZfN3KVXNrcHlySlQYp4eAy3lxRoA1gaBarF/Vj
         KKYBJ0QOSbTqKoOe/wtSg8ngX+N4BZU+mu5L0mFDtWKk9cdZ6f/MSZT6Edh4MAyVIpHy
         DDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333246; x=1727938046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXy51M36oXFNN3kWVEF6T1v76BlvE2cEswNH4MTPbjU=;
        b=LkQxv1hWXQunsHWdChjyIS9+8VweZSyxBTVCI1kOYMuUoGMc6XCrJ/InMbx0qSvn2P
         JTl+uAfrFyfIC3UnElADQblfrfATvqW77m4vyj91nr6V/5ayJG77L/lO/X5MJzlG+XyQ
         UvYdN/n42kYvg0gvcC+QKo/w9FMxVNzPcuEOR8l8wcnnXcKFE0grqeE7DU1BlDqd34CU
         J2T5h2o8En4OvTARRRMYIcTgpKkXG2ujNnC9Wr4qqw1tJ6z2ILSZjNWXFNFB1de+U6Bj
         WhRkOK78GizZuZENNCflORtu5QiBxr3c+kiS034z2ZhODhwuFj0E9FJGram9z4QEYI0P
         bPhw==
X-Gm-Message-State: AOJu0YwWqpQrjlOjSHr9fEJRQcPQrmTIQ2rHNVzC+ChhzfTQgSSP1F39
	OneINZAx63N6qzmgmdMY6n1OTQFjXihl567gF0y1IpBKBJmCkoayUgEwU5l7WBI=
X-Google-Smtp-Source: AGHT+IGInGARMP6O0lOtN8I02J26ctBRW9WAU/Ifxw0RvFOYg2EOnEie2juwEDAOYLUuf+d4v6O7qQ==
X-Received: by 2002:ac8:5885:0:b0:456:94fe:dcdf with SMTP id d75a77b69052e-45b5def4674mr66807991cf.35.1727333246109;
        Wed, 25 Sep 2024 23:47:26 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b5257ff1esm23024611cf.38.2024.09.25.23.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:47:25 -0700 (PDT)
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
Subject: [PATCH v5 05/13] arm: adjust_pte() use pte_offset_map_rw_nolock()
Date: Thu, 26 Sep 2024 14:46:18 +0800
Message-Id: <0eaf6b69aeb2fe35092a633fed12537efe645303.1727332572.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1727332572.git.zhengqi.arch@bytedance.com>
References: <cover.1727332572.git.zhengqi.arch@bytedance.com>
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


