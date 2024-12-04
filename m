Return-Path: <linux-kernel+bounces-431047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 250129E3876
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179731606A8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592911B4146;
	Wed,  4 Dec 2024 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NDnfWb0H"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1411B4130
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310642; cv=none; b=F+qxKas5jOsafyUe0yiwcfhhunDoJTAKeo2ivUpuvYWfoiYuiGCa9LLCNPHsgY2PJrcdb/DRgc8TSxW+Xah+o9bUDd+XXa8yOBLdgeohjbHptqwDLH5MV2zkTJ3KKfmZmHmxzGW4csaEMiZIQDdiusi2SPtUqPPo1lFXdRC4KCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310642; c=relaxed/simple;
	bh=7roOxUQ9JUnSMsdXAsiPgJXsMQAjgBLALyc1oPKltDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ft66ukhaF6Rovmq487d4YEKd3fZloz17MSDsVBu1tiIgBMzdB3dcjvoO+Evor0Uvcw/7+mk85uPteI9lQR84vq/SkF7mLQrADCh2usTWHuBJ4VXp4ABRTugVTTrVVoODJn1KWoVNbM7ZmzAnnvynfBCxJ6qTvGQmla/feUjRpHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NDnfWb0H; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7f46d5d1ad5so5079827a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733310640; x=1733915440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBIs+RyxQ8T92otn81RkrE5S0sfAaFlsvX0Ncx+wxck=;
        b=NDnfWb0H7kpbOSn5gT6sEI4/K5uyaQ9cVCItUOB1AoNhThwd5aLwC0E3rr9Bz6L/dw
         p9eIr9vJ4FCo+n7mL5FI1Os42xfwPbXUaxB5d/xjdrwawbR56e+uxQpeB2jb2Fu//WiA
         FJHFVgb1YGXyjsIK6pTlHdVs6QDuaCuEWkGL//vYYdlEBbCZmS8L2H9cPZc7QG7HxSeV
         2t/OIVd5sCHDhtNeNJoxMMeBxNp/BPHFYq8yYmxL98NP+1LWGLjP6I/gvBHDMrVKxDHU
         DldERsIo4kwM026X3HpzvsAp7PPPcGOQF1sY2CnicK5p5Bq54Xtw8O02sUnPRqvKtriq
         DqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310640; x=1733915440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBIs+RyxQ8T92otn81RkrE5S0sfAaFlsvX0Ncx+wxck=;
        b=S8Y0Y1/aR6c4VqicjEjBS9uS0VOatcQi660A88xCOA6uKVuKazvHBZnUhHXhQoQkXf
         5LhV/V4DvWFkVjs/0ZEHpjMUFzvmd7NOYfR2lfTs7YPttMqYZOXBRzL3NH35l6nTUbMu
         H557qRyD3q8VnhP6WytXHzqQ2IJ6rJrP83ZIcCduWIr9dmjD7HUFl7TkxNgvBBGXhrzL
         Hd0zxJp6F/U4x891ogz3lcZp/Fy2KYXWmdr1VyR2mJRS1mJ/7An08l0rsX2PA4i7TK3a
         itYiVRzt4TVas4nXqOSEn453+2jLptyW9spEx7Z8yIHIZ2ruAUN8ZYWX0Nu0skI7sVBo
         q7dw==
X-Forwarded-Encrypted: i=1; AJvYcCWMFK9ugMjhVa3dJLY/ojoeMvHJM/YCvDZsix2hSxbkdSyC4fKKKoEW8CBKs3eUQnEr3lSYmxllS5zPFIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLTa6JK/KeXcohTQ8z94jg4/dct7X+GcqrsV+yKVvxOz6ndutK
	wJaOR4H0Q0ReP3ecUEYt6uXn+ZH6vwEXAKtP2fieOYATA7GXcTl7je6gi2CyAYk=
X-Gm-Gg: ASbGnculwCdTbt0OdiCQ87kZLVUmoEdm7j7C5405mzE/sDinTf1n07M4xq8fw8PkDdd
	IZYi1Wj/9JL3Cpsc2o6luV3V5ji8F+RM1P6oXT6fb6cHNq9i9HvccyA6bm2oqotRBrglrPg+JpB
	9yn7vhYp7d5qbQgjCTQIhKTRXvz0zVxQCgkTqDCB0tm/csp5ozWKY2VTTd9LT5+GFg3k/mouIVW
	A6DvrdoNVIGFxsdXtuwgTn6C1AeElquhO68P4Dra6iPmceNExsO++yO13N/secErB7TDB/1P2dy
	2sT5KurkaR/ob1o=
X-Google-Smtp-Source: AGHT+IER5lnoQQdWEC7gbQxZosi7N0mw2aeYdLAS9LZW7bMxGiW32vvaQ3PYOO0pQsVEtwB2CIp8WQ==
X-Received: by 2002:a05:6a20:7f8e:b0:1e0:ca95:3cb2 with SMTP id adf61e73a8af0-1e1653a7c1fmr8526385637.8.1733310640114;
        Wed, 04 Dec 2024 03:10:40 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21527515731sm107447495ad.192.2024.12.04.03.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:10:38 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	peterx@redhat.com,
	akpm@linux-foundation.org
Cc: mgorman@suse.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	x86@kernel.org,
	lorenzo.stoakes@oracle.com,
	zokeefe@google.com,
	rientjes@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 03/11] mm: introduce zap_nonpresent_ptes()
Date: Wed,  4 Dec 2024 19:09:43 +0800
Message-Id: <009ca882036d9c7a9f815489cfeafe0bdb79d62d.1733305182.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1733305182.git.zhengqi.arch@bytedance.com>
References: <cover.1733305182.git.zhengqi.arch@bytedance.com>
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
Reviewed-by: Jann Horn <jannh@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 136 ++++++++++++++++++++++++++++------------------------
 1 file changed, 73 insertions(+), 63 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index d5a1b0a6bf1fa..5624c22bb03cf 100644
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


