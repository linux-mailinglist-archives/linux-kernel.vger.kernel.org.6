Return-Path: <linux-kernel+bounces-408789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B449C8392
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260531F221C0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9751F5839;
	Thu, 14 Nov 2024 07:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="L1gr+wTd"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E20C1DF72E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731567651; cv=none; b=VUHuWd0qANZKz5M1WZ2IjYMxiBCZ9ssws7x9hghQmVU3Xc7QOWiYR9OVSU1BXstARUfpCjec5WXKHi549WBgPRQ+uuMAkGToI1aWGY7uDGENTk4O6rl+JOFO5gkt78iis3C55LPI3AKm5xN/6vkpmypIuUhz9rthrlnxzJE5kz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731567651; c=relaxed/simple;
	bh=DcijnCvR53Hod0FMwgB4w7OhfVfcuHAm9/anCQe30pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dpGK0PQQrBFLiSkUIeFUYqam7+EvgQHlBPGO51AOSejYJXfBLK9Ijk+DLkgqAbzl7p8sxl7TXPL6bTMN0CojSNfYgzpa1UJ2uisyb367P22HTVOdE6Udf8smbBjAc/4WCdT2/zhmO8GA9DzLnMr3PBIB/Vvw8TE9XbPP+ua5kmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=L1gr+wTd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20e576dbc42so2529815ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 23:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731567649; x=1732172449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Injd64heqojhVahuoVzqrsqJ00krl1pndEuOREo5sHA=;
        b=L1gr+wTd4xhPiKgjPKk9uz3vaoomKit7xmaT8bV0/9Ok9AA7ARniWIDBQ2siz52VcA
         AHuqHEAp4rS4eJjDmOAehMCP6nokAj3u8paeG4kJAWSYIkKX3DhH+Gd68AxDix5xFKHN
         Wd8pdkgJyL3fmuNuUkwGrMnDVZ+lA5uqSDmWndHQyGmRpqh6vWSPZRTWKRt+0NKIaLXn
         fuKulF4/iX7hbLp8tagBPHcpzQx3aQ2PCymJl9ZkyXhkB1YBBNZvxFxhblu9tFgMgEgC
         ieOUWiZDeKIVJBuDJhTZygy8e6DJnioZX7Fja2WThjDhX2qUzqR4qKPe7pLD/bOP+f/9
         vbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731567649; x=1732172449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Injd64heqojhVahuoVzqrsqJ00krl1pndEuOREo5sHA=;
        b=grXYCLjZ6Bvd3T4ML5RrngAx34UYx02cbokuHpMn1gWtN6m/EyleCKPsZobJi8AEJx
         zP+tQHf9c0tAWK83FFipp5tDRiBffyMMpv4OlQ/OZjM4FPIW1EW7bf9gfhlKvVsmWsxB
         8FSqcQpXlgBGxnfrHvAMbhOLQMpvCFbpSnYijAMjsa0U+eukIUOQlQmMATTtvUdBRtdE
         L3WyBoKMA09gpdSd1F5t9TJoH0ewOUkdBxvH1g8Zaz6Oy6/Nd52D5R44ly99F6Ku3HVU
         +kkGO6WQFfVmljohK6Hw2zNvG2iOfEArrHMUcbx5vwFTjNvOBK8X9Ktx7wvzXcERmhCT
         LYBA==
X-Forwarded-Encrypted: i=1; AJvYcCWipU3N1xLQT9glEj49n78gGBAzDBGF/ikDkEZQXabagh4YHoNUkn43RNRg6xUrpt2VQh3L18QkcqWOZXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPK8rQG5/k4Ehet1p/CgQlztsEo9McSHax101gmaV4AAGfYIC8
	oFKMSJaKAUhwZihOsSNPYrFr02qqeeu25mbOz9YZO/mcZLVDNcL47vgA/uXeLmg=
X-Google-Smtp-Source: AGHT+IF9J5Srma9m0kVIWNzHVFQU0S2TqIZpiUbAkjwNNaShq+S4YCS+Ol7MzG3HFBa6aKSnPA4QSw==
X-Received: by 2002:a17:903:2310:b0:20c:aed1:813a with SMTP id d9443c01a7336-211b66023e2mr54146835ad.14.1731567648903;
        Wed, 13 Nov 2024 23:00:48 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d389c2sm4119065ad.268.2024.11.13.23.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:00:48 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	peterx@redhat.com
Cc: mgorman@suse.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	x86@kernel.org,
	lorenzo.stoakes@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zokeefe@google.com,
	rientjes@google.com,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 3/9] mm: introduce zap_nonpresent_ptes()
Date: Thu, 14 Nov 2024 14:59:54 +0800
Message-Id: <25e70f171e17370ec65159a301ff4f852991e14c.1731566457.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1731566457.git.zhengqi.arch@bytedance.com>
References: <cover.1731566457.git.zhengqi.arch@bytedance.com>
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


