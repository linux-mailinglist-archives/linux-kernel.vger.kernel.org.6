Return-Path: <linux-kernel+bounces-369560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF489A1EEA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE731F23447
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD98F1DC1BE;
	Thu, 17 Oct 2024 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="er0o5HLf"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429161DC194
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158496; cv=none; b=fvmYs0nMSSFJImhFpfxAh7cyUIBH/SYHhZ6Fi41D9TNNC08pG5fz5BCsbxuaEFhRgCPn8zDxZCyHO06wZkcsD4HgLdgwi2KtvHhC5XUP/fKfOHY/COjWSkoX6YMSxXW+mpNbRUc2l6igbO8hZOoJqHgaJD5r+4IIhKpObVJeeyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158496; c=relaxed/simple;
	bh=H6+wTWP26uqZ4YBcgcKoTuVx8AqbeFe0Q57a4F7QhGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e5Cnt7YLUJww7eI7VCd0/bgSYB9h1RFAN4ippOrV7xmnAQPEhByhdyP8gloQLa/hMzjBEH5dkxbf2JSZgMehIdWBTL+fhcb8cYbI0tpHLGs+cn8FzjBjMc2OMJ0gT5pGupcLCuOJ3wpWYyNZiEwZF0i9m4Y1QBPo/gt4FLIdb9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=er0o5HLf; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e5130832aso499846b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729158492; x=1729763292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dj3ri9p71nmuCZf/HvkLHVU1fpbThKpmsfMSEQvNK9I=;
        b=er0o5HLf/f9slaOjlpuD4/dBrwP2oWdKRWK/0qMpXig0yQGFj9U8SgWW1aynnlqovf
         8s1AOGVpF2wFfcQD1C+B2mMkT7I4h+xzHBWYSZlpZnIvDLpvyOoCQHLDZ+5H/RIrRjmy
         YdIjqhQSXOfkp9YFvRKIsJaWGIYMakeVQbmgXv1bCj9nZBi8FXCRGf5o7UzqrOXMLjHU
         p6yDTr3zHJ2fL20IxtYMVcLU4a/zSy3papYz5TNge5PP4vU1UHNslydr5DJDPZFYTOHw
         ziAvRSPNwByfvIzgj9G9SGp5qsdJ11eUDkWnO/T7Fnx8JD9pLd8QLcrXLFRn96sw3xJv
         Opfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729158492; x=1729763292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dj3ri9p71nmuCZf/HvkLHVU1fpbThKpmsfMSEQvNK9I=;
        b=jEb7JIyznwg+eWuNGeHb1HQOZfPR6F9stxGjBjDLF7sD9zyV/J+pSsTZbQGc3FDpxA
         11Ck5Cr+9ODlFLyungl7PxyKM/8XDojCgNBxO0CK9d3uhe4ipe7BdKG1jFF9Q3SaN6Ci
         rMI9PwxvkZWsuNRp6W6ruLCF62ilgOHsCJIcL/gvEFlvhXtqFzB0ixO7TeUWsghXUU8X
         zwLEquu1iPbSdqskJHwZCftdtOhvCIw6pha/dXL9o7cvFuy5fFkiQ1alq9Uk4Y4uIMpA
         IXyPcQDEk7S5WUUIOpD49OLdigVhjpBvicyRdlCz+yb3e7KNGBEq9TE2psDfSFA1ZS3O
         3K5A==
X-Forwarded-Encrypted: i=1; AJvYcCVqwxfGFZXYH0+lBSxS87ksE/sF73RIQt+3LX1dqw2Xl1Qy/w+bOYQbzdBLXH3KKv4OGfkLOWjfOD/A8HI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+sBg596fkMsMAIAYBtCwBNvf2JybZf1+kFSSvvj9YN5LZ2dVF
	wHIqfrns+BTxHfwGNIL21hLb6OrPCMeOrf3Bxp0w5eqUZ2BEo38aROGx5rcRnXo=
X-Google-Smtp-Source: AGHT+IEKEDRwguwxshyZXMicxDUmcRCwiWXS2djsKDNBwB/wtcHqk2whV9zra/Oag0PCIfiHyKtsxQ==
X-Received: by 2002:a05:6a20:9f4a:b0:1d5:1729:35ec with SMTP id adf61e73a8af0-1d8c955c8ebmr29391532637.7.1729158492598;
        Thu, 17 Oct 2024 02:48:12 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a4218sm4385365b3a.120.2024.10.17.02.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:48:12 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com,
	jannh@google.com,
	peterx@redhat.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v1 4/7] mm: zap_present_ptes: return whether the PTE page is unreclaimable
Date: Thu, 17 Oct 2024 17:47:23 +0800
Message-Id: <84a9fddde9993e4a5108f188193fd9c8ff1c5c31.1729157502.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1729157502.git.zhengqi.arch@bytedance.com>
References: <cover.1729157502.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the following two cases, the PTE page cannot be empty and cannot be
reclaimed:

1. an uffd-wp pte was re-installed
2. should_zap_folio() return false

Let's expose this information to the caller through is_pt_unreclaimable,
so that subsequent commits can use this information in zap_pte_range() to
detect whether the PTE page can be reclaimed.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memory.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 534d9d52b5ebe..cc89ede8ce2ab 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1501,7 +1501,7 @@ static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, struct folio *folio,
 		struct page *page, pte_t *pte, pte_t ptent, unsigned int nr,
 		unsigned long addr, struct zap_details *details, int *rss,
-		bool *force_flush, bool *force_break)
+		bool *force_flush, bool *force_break, bool *is_pt_unreclaimable)
 {
 	struct mm_struct *mm = tlb->mm;
 	bool delay_rmap = false;
@@ -1527,8 +1527,8 @@ static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
 	arch_check_zapped_pte(vma, ptent);
 	tlb_remove_tlb_entries(tlb, pte, nr, addr);
 	if (unlikely(userfaultfd_pte_wp(vma, ptent)))
-		zap_install_uffd_wp_if_needed(vma, addr, pte, nr, details,
-					      ptent);
+		*is_pt_unreclaimable =
+			zap_install_uffd_wp_if_needed(vma, addr, pte, nr, details, ptent);
 
 	if (!delay_rmap) {
 		folio_remove_rmap_ptes(folio, page, nr, vma);
@@ -1552,7 +1552,7 @@ static inline int zap_present_ptes(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, pte_t *pte, pte_t ptent,
 		unsigned int max_nr, unsigned long addr,
 		struct zap_details *details, int *rss, bool *force_flush,
-		bool *force_break)
+		bool *force_break, bool *is_pt_unreclaimable)
 {
 	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
 	struct mm_struct *mm = tlb->mm;
@@ -1567,15 +1567,18 @@ static inline int zap_present_ptes(struct mmu_gather *tlb,
 		arch_check_zapped_pte(vma, ptent);
 		tlb_remove_tlb_entry(tlb, pte, addr);
 		if (userfaultfd_pte_wp(vma, ptent))
-			zap_install_uffd_wp_if_needed(vma, addr, pte, 1,
-						      details, ptent);
+			*is_pt_unreclaimable =
+				zap_install_uffd_wp_if_needed(vma, addr, pte, 1,
+							      details, ptent);
 		ksm_might_unmap_zero_page(mm, ptent);
 		return 1;
 	}
 
 	folio = page_folio(page);
-	if (unlikely(!should_zap_folio(details, folio)))
+	if (unlikely(!should_zap_folio(details, folio))) {
+		*is_pt_unreclaimable = true;
 		return 1;
+	}
 
 	/*
 	 * Make sure that the common "small folio" case is as fast as possible
@@ -1587,11 +1590,12 @@ static inline int zap_present_ptes(struct mmu_gather *tlb,
 
 		zap_present_folio_ptes(tlb, vma, folio, page, pte, ptent, nr,
 				       addr, details, rss, force_flush,
-				       force_break);
+				       force_break, is_pt_unreclaimable);
 		return nr;
 	}
 	zap_present_folio_ptes(tlb, vma, folio, page, pte, ptent, 1, addr,
-			       details, rss, force_flush, force_break);
+			       details, rss, force_flush, force_break,
+			       is_pt_unreclaimable);
 	return 1;
 }
 
@@ -1622,6 +1626,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		pte_t ptent = ptep_get(pte);
 		struct folio *folio;
 		struct page *page;
+		bool is_pt_unreclaimable = false;
 		int max_nr;
 
 		nr = 1;
@@ -1635,7 +1640,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			max_nr = (end - addr) / PAGE_SIZE;
 			nr = zap_present_ptes(tlb, vma, pte, ptent, max_nr,
 					      addr, details, rss, &force_flush,
-					      &force_break);
+					      &force_break, &is_pt_unreclaimable);
 			if (unlikely(force_break)) {
 				addr += nr * PAGE_SIZE;
 				break;
-- 
2.20.1


