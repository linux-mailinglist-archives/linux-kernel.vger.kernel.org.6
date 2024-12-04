Return-Path: <linux-kernel+bounces-431052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5359E38A3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85420B3AE55
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAE71B3928;
	Wed,  4 Dec 2024 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aWWfKcp+"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457161B21B9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310674; cv=none; b=Jm630/+5ycGTP0PM52GiItvSaekk+OvQebLaq2/9Sg0xl3/uEEtteXzOcRMJFG/ogYGQRbQCQhkqXyGA/6lcMYd76YVHGiBgj++INZr1mtEFIxbXBMDFZly2/Q2KGZl0V4+63IpR3ZfiUCTSbHoEVPGFWoeFTQvz6RAIY3Ea+8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310674; c=relaxed/simple;
	bh=wiCDcOADgZY8H+pYsTtIJYWHM/qJJDm87JLvD+UEQDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sgg3xSoxmDMNIgunFdYChbtU9LWKsW7SdkNjUBEKY4eqgnw5+4pi02Mc7In6a+KByXj6RClcIuOVOY/elaWlKnk4hDXg+xb9YFE3ZN8PnPdtzMws1vJJUYTdBKPGNItre1bKWt2bXNzO52RMCw3plXEyECl5G+lb1VDdYx0Cqv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aWWfKcp+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21578cfad81so30814165ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733310672; x=1733915472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4hB6V6uA9TX2vZoO0lHgFVoZw/iaOacAaPzNOaZz/w=;
        b=aWWfKcp+E/sHzwnP+BqmVBwfvjS20XBFpFdpdepOcxiyLIwDkqhM+FAyQ0xBldwrKH
         F+GgYP4VTjS499Lklfg0TWkENjJ6kj7tdGang1V42yfdvVkc9FlRgY6ZjNHhVScirhue
         GB6s46iAflZMQFI4+sCsy/2QBC9Opjw7LyMbM71eweS/Q75kgUVX7r0y+WnAh8J3KHiy
         JP6B7BHWSG4S4jYsWHh50FX/GAjZC0NQ3ub+M7I7pL8FjDijRgO1+8YlEsaVdupKuFf/
         xjSP3Kd6uNf9arJzl19J6jy6yxy35XdXHC0WUQxNNe8LRbWTRUcu2Bn0LOYpncs26NvL
         nUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310672; x=1733915472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4hB6V6uA9TX2vZoO0lHgFVoZw/iaOacAaPzNOaZz/w=;
        b=OSTkRlUipZAwD89XIF+K2MIOndAhV3ImA9Oxh3rXFcpjR4lETd4u5urumB679uhAWo
         +zlHD80gnWtU/p6DLvsGRoYaz8/Q0siRvysIdYPoVVaCBT3ADAV/QAnzj9OgRLH5dl35
         a81/ZvXJa4ss9UV4RNgXBxld1SHrOb8tFRvpJ3jXnyn2qwomNOQW1m6GMtU6FKJws4Ir
         OCW4yt5q7oGeCCUV0ZPl3cvhRwIk0QF531Ov4dpjb/eE2c4/ydjqYXCWMPXkhVE8EGLn
         PZAfqFf0DftIVjI34gCQJFi2zwlR/f94YmdQ3QdYCE5qQuyu1cesNVlEUFeEYuaZkHai
         JVYw==
X-Forwarded-Encrypted: i=1; AJvYcCW9mm+6AFMgFz6mq54K/SlvxDtly28nNCWMTiegkMOIzJc8cZQw3RGGuTTWSMcE/Jm01XPExm9YVURoVPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv+5jGdOtGn+jddRcF7iBO+m5l6T+meAdir/DQ+cLAdtcXnQI5
	L8Dtc+O3+9a6boa31y/Xu5rlaEyQg6sKbILiyPfFlrhBDfwYbTNgeLCWxfgySlk=
X-Gm-Gg: ASbGnctkqr2ebirJup+5jE7t7kMJtVQ9pKtNOMKqxjEIykX8AblIT4fyIHXxnqWPP2b
	iZnV+EREE/DGpTvcxJB4UEac+X96i3PNX+wGSo102DVqzF4qGCjDGEItlc7buxcb65W4ZuMcx4U
	BUErXv2KZutJ4j/cS7Tfe+5JVQpBuwBu3yOmyBLf4Gd9oH9NDbCbY11o43BmC40bREiWp/ODFMm
	EMVB4wHGLQI2Ieks97/ttjG7TjeFIumjR3WR3emDdtc99rJJDr+JotzvndeKmB+ABR2ED8USkAC
	wJEA40R3+dDBc68=
X-Google-Smtp-Source: AGHT+IHVmRnYQumB1wXhU3np0xfxzAbGYvF0A99UdzOBbPzf6Gm/CK0T1MxPbJQR0FQZPPyKoGad2Q==
X-Received: by 2002:a17:902:ce0c:b0:211:6b21:73d9 with SMTP id d9443c01a7336-215bd24146cmr87777885ad.37.1733310672514;
        Wed, 04 Dec 2024 03:11:12 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21527515731sm107447495ad.192.2024.12.04.03.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:11:11 -0800 (PST)
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
Subject: [PATCH v4 07/11] mm: do_zap_pte_range: return any_skipped information to the caller
Date: Wed,  4 Dec 2024 19:09:47 +0800
Message-Id: <59f33ec9f74e9f058ed319b0bfadd76b0f7adf9b.1733305182.git.zhengqi.arch@bytedance.com>
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

Let the caller of do_zap_pte_range() know whether we skip zap ptes or
reinstall uffd-wp ptes through any_skipped parameter, so that subsequent
commits can use this information in zap_pte_range() to detect whether the
PTE page can be reclaimed.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memory.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 1f149bc2c0586..fdefa551d1250 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1501,7 +1501,7 @@ static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, struct folio *folio,
 		struct page *page, pte_t *pte, pte_t ptent, unsigned int nr,
 		unsigned long addr, struct zap_details *details, int *rss,
-		bool *force_flush, bool *force_break)
+		bool *force_flush, bool *force_break, bool *any_skipped)
 {
 	struct mm_struct *mm = tlb->mm;
 	bool delay_rmap = false;
@@ -1527,8 +1527,8 @@ static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
 	arch_check_zapped_pte(vma, ptent);
 	tlb_remove_tlb_entries(tlb, pte, nr, addr);
 	if (unlikely(userfaultfd_pte_wp(vma, ptent)))
-		zap_install_uffd_wp_if_needed(vma, addr, pte, nr, details,
-					      ptent);
+		*any_skipped = zap_install_uffd_wp_if_needed(vma, addr, pte,
+							     nr, details, ptent);
 
 	if (!delay_rmap) {
 		folio_remove_rmap_ptes(folio, page, nr, vma);
@@ -1552,7 +1552,7 @@ static inline int zap_present_ptes(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, pte_t *pte, pte_t ptent,
 		unsigned int max_nr, unsigned long addr,
 		struct zap_details *details, int *rss, bool *force_flush,
-		bool *force_break)
+		bool *force_break, bool *any_skipped)
 {
 	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
 	struct mm_struct *mm = tlb->mm;
@@ -1567,15 +1567,17 @@ static inline int zap_present_ptes(struct mmu_gather *tlb,
 		arch_check_zapped_pte(vma, ptent);
 		tlb_remove_tlb_entry(tlb, pte, addr);
 		if (userfaultfd_pte_wp(vma, ptent))
-			zap_install_uffd_wp_if_needed(vma, addr, pte, 1,
-						      details, ptent);
+			*any_skipped = zap_install_uffd_wp_if_needed(vma, addr,
+						pte, 1, details, ptent);
 		ksm_might_unmap_zero_page(mm, ptent);
 		return 1;
 	}
 
 	folio = page_folio(page);
-	if (unlikely(!should_zap_folio(details, folio)))
+	if (unlikely(!should_zap_folio(details, folio))) {
+		*any_skipped = true;
 		return 1;
+	}
 
 	/*
 	 * Make sure that the common "small folio" case is as fast as possible
@@ -1587,22 +1589,23 @@ static inline int zap_present_ptes(struct mmu_gather *tlb,
 
 		zap_present_folio_ptes(tlb, vma, folio, page, pte, ptent, nr,
 				       addr, details, rss, force_flush,
-				       force_break);
+				       force_break, any_skipped);
 		return nr;
 	}
 	zap_present_folio_ptes(tlb, vma, folio, page, pte, ptent, 1, addr,
-			       details, rss, force_flush, force_break);
+			       details, rss, force_flush, force_break, any_skipped);
 	return 1;
 }
 
 static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, pte_t *pte, pte_t ptent,
 		unsigned int max_nr, unsigned long addr,
-		struct zap_details *details, int *rss)
+		struct zap_details *details, int *rss, bool *any_skipped)
 {
 	swp_entry_t entry;
 	int nr = 1;
 
+	*any_skipped = true;
 	entry = pte_to_swp_entry(ptent);
 	if (is_device_private_entry(entry) ||
 		is_device_exclusive_entry(entry)) {
@@ -1660,7 +1663,7 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 		WARN_ON_ONCE(1);
 	}
 	clear_not_present_full_ptes(vma->vm_mm, addr, pte, nr, tlb->fullmm);
-	zap_install_uffd_wp_if_needed(vma, addr, pte, nr, details, ptent);
+	*any_skipped = zap_install_uffd_wp_if_needed(vma, addr, pte, nr, details, ptent);
 
 	return nr;
 }
@@ -1669,7 +1672,8 @@ static inline int do_zap_pte_range(struct mmu_gather *tlb,
 				   struct vm_area_struct *vma, pte_t *pte,
 				   unsigned long addr, unsigned long end,
 				   struct zap_details *details, int *rss,
-				   bool *force_flush, bool *force_break)
+				   bool *force_flush, bool *force_break,
+				   bool *any_skipped)
 {
 	pte_t ptent = ptep_get(pte);
 	int max_nr = (end - addr) / PAGE_SIZE;
@@ -1691,10 +1695,11 @@ static inline int do_zap_pte_range(struct mmu_gather *tlb,
 
 	if (pte_present(ptent))
 		nr += zap_present_ptes(tlb, vma, pte, ptent, max_nr, addr,
-				       details, rss, force_flush, force_break);
+				       details, rss, force_flush, force_break,
+				       any_skipped);
 	else
 		nr += zap_nonpresent_ptes(tlb, vma, pte, ptent, max_nr, addr,
-					  details, rss);
+					  details, rss, any_skipped);
 
 	return nr;
 }
@@ -1705,6 +1710,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct zap_details *details)
 {
 	bool force_flush = false, force_break = false;
+	bool any_skipped = false;
 	struct mm_struct *mm = tlb->mm;
 	int rss[NR_MM_COUNTERS];
 	spinlock_t *ptl;
@@ -1725,7 +1731,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			break;
 
 		nr = do_zap_pte_range(tlb, vma, pte, addr, end, details, rss,
-				      &force_flush, &force_break);
+				      &force_flush, &force_break, &any_skipped);
 		if (unlikely(force_break)) {
 			addr += nr * PAGE_SIZE;
 			break;
-- 
2.20.1


