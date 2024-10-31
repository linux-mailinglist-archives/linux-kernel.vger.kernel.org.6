Return-Path: <linux-kernel+bounces-390148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4CD9B7625
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0D31F20F0C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21A21547E3;
	Thu, 31 Oct 2024 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ereH/toc"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99A7154445
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362463; cv=none; b=GMOiWiQSCzP7C7o1pcaRC07y0ewIcflZrAqVhjLepBIgFePRo1G5njuR/fo2TyhmEndVKDkEnjU6ycDW0XV4WivhQH8hcvm7rQRunhxNi6T6AtG+r1uSUEBCEw4BMQ+v4XtUwcTL0RG8zlDxl6jpPNcOTNB/zxq44RzLUgxEshk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362463; c=relaxed/simple;
	bh=31kONglB0KigiLfabCVYk2k8OYeGF43W/Zv8pVM3t+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fAKcUYgzJYchW+1p6sG6wYu3RscWUfwZClUbpiwgA7nTpTU9goOgZSiX13rkTenTWVTvHbjLrjKoT/l6+ifrEvlZeo168wtPd43q6pvqKUfyC/GUGD3GHA+1jopJYx2NqTWvLpDvMNnWSnwUZRRyDTxo8JauttuKTNxIl1CydgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ereH/toc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20ce65c8e13so7533785ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730362459; x=1730967259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uS9zjnEttUyVTWzhhVIHAdfZYrGflmgRk9QlOwbpbs=;
        b=ereH/tocTjuPaRa1PpXM6qI4zC3IDSxeXKVqrInLS9IjoLAfaFbGY6SL4Gy8V5tD3w
         0uN+zsnj9GjdMK7JhJroM7A1Ln8KroVrmrbEPhUQrDImsOrxY0zvUtuXsbISmOvN5RQx
         7yoFENx+xRtoCjth3dSOrEjXcx1lEt7tHzdU4vtde25wCBWIOprYzxuKErCe6xf99dJP
         wQQS+/Rv2YRDYzEPHVUPAVF43inuSLA+1N8nFSZKaba5mtwBDV/7rwnOuIGTw9narcst
         ZoFc62n0B/CI2BrZ7w/dedOSSJG5Kg7QwZ+jj8LxS0wLogTUOKMOeQqMEY8YDnV/Xpfs
         cf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730362459; x=1730967259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uS9zjnEttUyVTWzhhVIHAdfZYrGflmgRk9QlOwbpbs=;
        b=vcOfsmerVEK9VPShR9FWxUEUxIEsBH8P3ndrP3uMswcdZNBiyFQ4GNA3+oh7apxoLp
         IjB0EwEG/VFvGaLSdW8LOBB8l7wedINXSxXFWX4y51sh7kIevnetlWi2TvyaE5yek4lQ
         sFEiQqVWJ29tm7IS3ngRGE1Yu9sqtwZz/4afvHTby99LA1tAdr31o9rQaXg1gBMJjdzU
         Mol29TAe3wHV8VitgNW1hUAIpckZGxrjI091ys5HMe6DWrK4iXy7WmTXPWSlk2W/h2A0
         PyMWA2q3+mY4JzBgoS6E9J0m8f1Y2+WTe4DsizEKteY8bSEFLo7WM7+5fwGyIwhaJgxf
         2rag==
X-Forwarded-Encrypted: i=1; AJvYcCVle4+3WN6xND6eDv0OchgCrgBEJNx6/fE6Z9EGzZx35BKKZA+QoXS1RiNo3rG50qt5z1kdFKViShlRSvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf51ohMn0TPbx/2slZDMPaJkqy8EHZ20oHpPrknQ0bB9AwTGxE
	h8FTl84xobjZeFfCIeXIKYluGrA5SL8y92wo5TrU+1PHyypis0vFpUA+1GZt57o=
X-Google-Smtp-Source: AGHT+IHliHONlLjM71G0WcLE2jZg2du2F6KU7SIJsE29Lnbx/3IrRdww7bJdFluVjjQ6fAFe8KWB2A==
X-Received: by 2002:a17:90b:53c3:b0:2e2:d859:1603 with SMTP id 98e67ed59e1d1-2e93c1d39b0mr2658162a91.25.1730362459134;
        Thu, 31 Oct 2024 01:14:19 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9201b2586sm5163996a91.0.2024.10.31.01.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 01:14:18 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com,
	peterx@redhat.com,
	catalin.marinas@arm.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 2/7] mm: introduce zap_nonpresent_ptes()
Date: Thu, 31 Oct 2024 16:13:18 +0800
Message-Id: <34ef26a763af7b2d8dee707b6f60ff85edda345f.1730360798.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1730360798.git.zhengqi.arch@bytedance.com>
References: <cover.1730360798.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to zap_present_ptes(), let's introduce zap_nonpresent_ptes() to
handle non-present ptes, which can improve code readability.

No functional change.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memory.c | 136 ++++++++++++++++++++++++++++------------------------
 1 file changed, 73 insertions(+), 63 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 209885a4134f7..bd9ebe0f4471f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1587,6 +1587,76 @@ static inline int zap_present_ptes(struct mmu_gather *tlb,
 	return 1;
 }
 
+static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, pte_t *pte, pte_t ptent,
+		unsigned int max_nr, unsigned long addr,
+		struct zap_details *details, int *rss)
+{
+	swp_entry_t entry;
+	int nr = 1;
+
+	entry = pte_to_swp_entry(ptent);
+	if (is_device_private_entry(entry) ||
+		is_device_exclusive_entry(entry)) {
+		struct page *page = pfn_swap_entry_to_page(entry);
+		struct folio *folio = page_folio(page);
+
+		if (unlikely(!should_zap_folio(details, folio)))
+			return 1;
+		/*
+		 * Both device private/exclusive mappings should only
+		 * work with anonymous page so far, so we don't need to
+		 * consider uffd-wp bit when zap. For more information,
+		 * see zap_install_uffd_wp_if_needed().
+		 */
+		WARN_ON_ONCE(!vma_is_anonymous(vma));
+		rss[mm_counter(folio)]--;
+		if (is_device_private_entry(entry))
+			folio_remove_rmap_pte(folio, page, vma);
+		folio_put(folio);
+	} else if (!non_swap_entry(entry)) {
+		/* Genuine swap entries, hence a private anon pages */
+		if (!should_zap_cows(details))
+			return 1;
+
+		nr = swap_pte_batch(pte, max_nr, ptent);
+		rss[MM_SWAPENTS] -= nr;
+		free_swap_and_cache_nr(entry, nr);
+	} else if (is_migration_entry(entry)) {
+		struct folio *folio = pfn_swap_entry_folio(entry);
+
+		if (!should_zap_folio(details, folio))
+			return 1;
+		rss[mm_counter(folio)]--;
+	} else if (pte_marker_entry_uffd_wp(entry)) {
+		/*
+		 * For anon: always drop the marker; for file: only
+		 * drop the marker if explicitly requested.
+		 */
+		if (!vma_is_anonymous(vma) && !zap_drop_markers(details))
+			return 1;
+	} else if (is_guard_swp_entry(entry)) {
+		/*
+		 * Ordinary zapping should not remove guard PTE
+		 * markers. Only do so if we should remove PTE markers
+		 * in general.
+		 */
+		if (!zap_drop_markers(details))
+			return 1;
+	} else if (is_hwpoison_entry(entry) || is_poisoned_swp_entry(entry)) {
+		if (!should_zap_cows(details))
+			return 1;
+	} else {
+		/* We should have covered all the swap entry types */
+		pr_alert("unrecognized swap entry 0x%lx\n", entry.val);
+		WARN_ON_ONCE(1);
+	}
+	clear_not_present_full_ptes(vma->vm_mm, addr, pte, nr, tlb->fullmm);
+	zap_install_uffd_wp_if_needed(vma, addr, pte, nr, details, ptent);
+
+	return nr;
+}
+
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
@@ -1598,7 +1668,6 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	spinlock_t *ptl;
 	pte_t *start_pte;
 	pte_t *pte;
-	swp_entry_t entry;
 	int nr;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
@@ -1611,8 +1680,6 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	arch_enter_lazy_mmu_mode();
 	do {
 		pte_t ptent = ptep_get(pte);
-		struct folio *folio;
-		struct page *page;
 		int max_nr;
 
 		nr = 1;
@@ -1622,8 +1689,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		if (need_resched())
 			break;
 
+		max_nr = (end - addr) / PAGE_SIZE;
 		if (pte_present(ptent)) {
-			max_nr = (end - addr) / PAGE_SIZE;
 			nr = zap_present_ptes(tlb, vma, pte, ptent, max_nr,
 					      addr, details, rss, &force_flush,
 					      &force_break);
@@ -1631,67 +1698,10 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				addr += nr * PAGE_SIZE;
 				break;
 			}
-			continue;
-		}
-
-		entry = pte_to_swp_entry(ptent);
-		if (is_device_private_entry(entry) ||
-		    is_device_exclusive_entry(entry)) {
-			page = pfn_swap_entry_to_page(entry);
-			folio = page_folio(page);
-			if (unlikely(!should_zap_folio(details, folio)))
-				continue;
-			/*
-			 * Both device private/exclusive mappings should only
-			 * work with anonymous page so far, so we don't need to
-			 * consider uffd-wp bit when zap. For more information,
-			 * see zap_install_uffd_wp_if_needed().
-			 */
-			WARN_ON_ONCE(!vma_is_anonymous(vma));
-			rss[mm_counter(folio)]--;
-			if (is_device_private_entry(entry))
-				folio_remove_rmap_pte(folio, page, vma);
-			folio_put(folio);
-		} else if (!non_swap_entry(entry)) {
-			max_nr = (end - addr) / PAGE_SIZE;
-			nr = swap_pte_batch(pte, max_nr, ptent);
-			/* Genuine swap entries, hence a private anon pages */
-			if (!should_zap_cows(details))
-				continue;
-			rss[MM_SWAPENTS] -= nr;
-			free_swap_and_cache_nr(entry, nr);
-		} else if (is_migration_entry(entry)) {
-			folio = pfn_swap_entry_folio(entry);
-			if (!should_zap_folio(details, folio))
-				continue;
-			rss[mm_counter(folio)]--;
-		} else if (pte_marker_entry_uffd_wp(entry)) {
-			/*
-			 * For anon: always drop the marker; for file: only
-			 * drop the marker if explicitly requested.
-			 */
-			if (!vma_is_anonymous(vma) &&
-			    !zap_drop_markers(details))
-				continue;
-		} else if (is_guard_swp_entry(entry)) {
-			/*
-			 * Ordinary zapping should not remove guard PTE
-			 * markers. Only do so if we should remove PTE markers
-			 * in general.
-			 */
-			if (!zap_drop_markers(details))
-				continue;
-		} else if (is_hwpoison_entry(entry) ||
-			   is_poisoned_swp_entry(entry)) {
-			if (!should_zap_cows(details))
-				continue;
 		} else {
-			/* We should have covered all the swap entry types */
-			pr_alert("unrecognized swap entry 0x%lx\n", entry.val);
-			WARN_ON_ONCE(1);
+			nr = zap_nonpresent_ptes(tlb, vma, pte, ptent, max_nr,
+						 addr, details, rss);
 		}
-		clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
-		zap_install_uffd_wp_if_needed(vma, addr, pte, nr, details, ptent);
 	} while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
 
 	add_mm_rss_vec(mm, rss);
-- 
2.20.1


