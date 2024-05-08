Return-Path: <linux-kernel+bounces-173909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CEC8C0771
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473622845F6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8DE130ACF;
	Wed,  8 May 2024 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQE3uGsI"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AA324B2F
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 22:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715208148; cv=none; b=AMPbNLqQrQCBV8lFWDcojsWZTV+0vGhZndadmcUwDXvaPL9nL4Km9xhcD/fszlpE0U8SF3KplpXhBqYjtf6Z6adui1BDbYBD8QNOPAacuu0A1m5WyA3r67d4PTptFIK/nIjFKzbOIBUf2YgiDVEgoyXra9FO1yDQQl7aTMWIebw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715208148; c=relaxed/simple;
	bh=I8jcwKuouofcxZRKWJiNRwxuS2b/SayLDctNUASbQlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WwYSdr93g+dnRBFD+JlpCrbHXICDr7PV29sM5FDl2C/MBRO5/iZEr610WE2MReWp0/Vppi/IZY3jR7JceoEYWhqBV+bGSSfbajkQElyuNHeqPmxjtJv07Cg5uZqOgzuyNm64NjLBFKwsUHSwsjadW0QjCRIZIDRa81UVIPcuXwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQE3uGsI; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso200054a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 15:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715208146; x=1715812946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEA7q2xvrQmRo9zBznhNS6ApXjfQDgq/4gBxPbR9Hqk=;
        b=WQE3uGsIHml1bNsBtW475/i0Dc8Jib7QEkeLyk/B+x+fulOX3L+e8irr3NsbfqaI85
         3GQpVDG8zTylpx97sKGtek0fYGi8LwhQBQ5Xy0Mr4W5IHz23duoS7yISot2HVDRDZKQz
         JymkLRYxTomAXC4kVdWW1LMyjozbxDDVmLVvQbA6y8t4t2eRsQzNNjQhAZtB17QERz5y
         R7GHBIMaTT0hKxHdiWcktxB79NPm98KJk1mTSjSfEpXiyCw1SXvb+TtDy1zqU3fGzHGa
         Qb7T+/q27WDm/u9I9/J78Vwqd4WSCnHLKBFbet0Gith2lxA1u5Bj5Qh7YvTUdVH+Wm50
         4ooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715208146; x=1715812946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEA7q2xvrQmRo9zBznhNS6ApXjfQDgq/4gBxPbR9Hqk=;
        b=be9nw6LtWvWyvsOuBJNllB5gskOgt06aZtqgLJY5UciBAcrxJinHY9tLWN3Iv6Kzo2
         EYSArkGy7khRVeeIJGREP0kSVZwm8hhp691zTRFBGnzu6sN9IDRdjPTwICFStRdSoKq4
         uLF/P+zCOD2WCk3WDB2vu6cYiTjSyaVT791fJu8jliJm5pV7duglOGPqiV19PT1uu4/P
         yfDjWZLhwv6nCRb/ivIqeZoL9kDkEGF9XkWdmhrOwz+uwvb6jVVz2CmLetYEC9cLIMAK
         uZZLBCLQAEFQ7K8dad/HOPVEBZY/v4CL1BkPBOckOP1NxCAWO3SBeBtR7MhZbC7ictPd
         DrIw==
X-Forwarded-Encrypted: i=1; AJvYcCV0U/0GKYNfwjlOtxu69SUWifcFaNU0X9y9UMqe09BXxjth4Eilry+KVmSiEuaFVJ76KAe20lS6aNeSxUipX9sfK25yPpym8JfH0/pY
X-Gm-Message-State: AOJu0Ywpm28jtyrPPXMR+xDAJ0o8Vwp+dvCl1WLQGsP1ZatyDi9nvzHB
	ssgfN/OQWXm1So8ute2I+pe6xPpgl9IvIqfFTvzupseX/O1vAIDg
X-Google-Smtp-Source: AGHT+IGq29rmz9yqnIyAWg43yTePii4lbT2fQtdkcVHel1ug/Dy/4QuBgQDgX9YahoaNoa9CKKLOjw==
X-Received: by 2002:a17:90a:8811:b0:2b3:28df:92bb with SMTP id 98e67ed59e1d1-2b6165a62eemr3793409a91.13.1715208146212;
        Wed, 08 May 2024 15:42:26 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67126b666sm102082a91.34.2024.05.08.15.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 15:42:25 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com
Subject: [PATCH v4 6/6] mm: swap: entirely map large folios found in swapcache
Date: Thu,  9 May 2024 10:40:40 +1200
Message-Id: <20240508224040.190469-7-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508224040.190469-1-21cnbao@gmail.com>
References: <20240508224040.190469-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuanhua Han <hanchuanhua@oppo.com>

When a large folio is found in the swapcache, the current implementation
requires calling do_swap_page() nr_pages times, resulting in nr_pages
page faults. This patch opts to map the entire large folio at once to
minimize page faults. Additionally, redundant checks and early exits
for ARM64 MTE restoring are removed.

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/memory.c | 59 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index d9434df24d62..8b9e4cab93ed 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3968,6 +3968,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	pte_t pte;
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
+	int nr_pages;
+	unsigned long page_idx;
+	unsigned long address;
+	pte_t *ptep;
 
 	if (!pte_unmap_same(vmf))
 		goto out;
@@ -4166,6 +4170,38 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_nomap;
 	}
 
+	nr_pages = 1;
+	page_idx = 0;
+	address = vmf->address;
+	ptep = vmf->pte;
+	if (folio_test_large(folio) && folio_test_swapcache(folio)) {
+		int nr = folio_nr_pages(folio);
+		unsigned long idx = folio_page_idx(folio, page);
+		unsigned long folio_start = address - idx * PAGE_SIZE;
+		unsigned long folio_end = folio_start + nr * PAGE_SIZE;
+		pte_t *folio_ptep;
+		pte_t folio_pte;
+
+		if (unlikely(folio_start < max(address & PMD_MASK, vma->vm_start)))
+			goto check_folio;
+		if (unlikely(folio_end > pmd_addr_end(address, vma->vm_end)))
+			goto check_folio;
+
+		folio_ptep = vmf->pte - idx;
+		folio_pte = ptep_get(folio_ptep);
+		if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pte, -idx)) ||
+		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
+			goto check_folio;
+
+		page_idx = idx;
+		address = folio_start;
+		ptep = folio_ptep;
+		nr_pages = nr;
+		entry = folio->swap;
+		page = &folio->page;
+	}
+
+check_folio:
 	/*
 	 * PG_anon_exclusive reuses PG_mappedtodisk for anon pages. A swap pte
 	 * must never point at an anonymous page in the swapcache that is
@@ -4225,12 +4261,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 * We're already holding a reference on the page but haven't mapped it
 	 * yet.
 	 */
-	swap_free(entry);
+	swap_free_nr(entry, nr_pages);
 	if (should_try_to_free_swap(folio, vma, vmf->flags))
 		folio_free_swap(folio);
 
-	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
-	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
+	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
+	add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
 	pte = mk_pte(page, vma->vm_page_prot);
 
 	/*
@@ -4247,27 +4283,28 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		}
 		rmap_flags |= RMAP_EXCLUSIVE;
 	}
-	flush_icache_page(vma, page);
+	folio_ref_add(folio, nr_pages - 1);
+	flush_icache_pages(vma, page, nr_pages);
 	if (pte_swp_soft_dirty(vmf->orig_pte))
 		pte = pte_mksoft_dirty(pte);
 	if (pte_swp_uffd_wp(vmf->orig_pte))
 		pte = pte_mkuffd_wp(pte);
-	vmf->orig_pte = pte;
+	vmf->orig_pte = pte_advance_pfn(pte, page_idx);
 
 	/* ksm created a completely new copy */
 	if (unlikely(folio != swapcache && swapcache)) {
-		folio_add_new_anon_rmap(folio, vma, vmf->address);
+		folio_add_new_anon_rmap(folio, vma, address);
 		folio_add_lru_vma(folio, vma);
 	} else {
-		folio_add_anon_rmap_pte(folio, page, vma, vmf->address,
+		folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, address,
 					rmap_flags);
 	}
 
 	VM_BUG_ON(!folio_test_anon(folio) ||
 			(pte_write(pte) && !PageAnonExclusive(page)));
-	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
-	arch_do_swap_page_nr(vma->vm_mm, vma, vmf->address,
-			pte, vmf->orig_pte, 1);
+	set_ptes(vma->vm_mm, address, ptep, pte, nr_pages);
+	arch_do_swap_page_nr(vma->vm_mm, vma, address,
+			pte, pte, nr_pages);
 
 	folio_unlock(folio);
 	if (folio != swapcache && swapcache) {
@@ -4291,7 +4328,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 
 	/* No need to invalidate - it was non-present before */
-	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
+	update_mmu_cache_range(vmf, vma, address, ptep, nr_pages);
 unlock:
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-- 
2.34.1


