Return-Path: <linux-kernel+bounces-431045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F2A9E3873
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0962863FF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443571B392F;
	Wed,  4 Dec 2024 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gDYDwL7d"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E361B9831
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310625; cv=none; b=fBx+vX5cuypEKHOULn18/x0wdLoP+N4UDxfQ1QSExihrDgq9veM/sCMn5BTgEvXAvvf5GQUGY8D3QG8g+HPcKOUtl7sOVokmfhp9PJTHPN11tBsqSuQP6+oZ+57BVGNiPkH+a94qDKo51ehCASwAHVXCNl3Ph6C4ItWj5DWRoQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310625; c=relaxed/simple;
	bh=FEBZWUR9v7E8KgYvnYm6uhEr4btIUVDaZhQxoD4rWgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p4QN4pHPlqjOBWuvGyFErNAe0ti4OX5gbQaZoEgwh0x2rDvz3NYWnyxd6xXzCNjKxmrR31oFL9jQuWycK48KgvDVw4Gl+jbLbaSjlzhxEAZ5kpg3vKhsudp2nznZBHTqwdBdHfJ4IgktB/Fi5KGpKVJZpATUgr1cnQjrLTJ05y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gDYDwL7d; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-724f383c5bfso5157394b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733310623; x=1733915423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1cxqrRNLtVgEINqhNBjpEtuU6ycwPEQ1YtKh4XaP64=;
        b=gDYDwL7dDOyyaTtP2iqHdw2xPvs5anu7EvlvMTiROCn/xGqU/etcElPNRIzv/hyHNP
         +y+Sxw1nL/D8aZQ+oL+ZxDHhSEe7Y1RjfDPHqkNNf7lTFAJt2j/TYZ3PKj3cyjnTycFM
         fy4fB0Wuz5wFNs2t0in+R+q3m0UasISCGPFrfzAeLkHB0XRo58kxzgNHIG/fRsHjIcNq
         6VT2pzALGDHnf/JTrngCNplaMPDNWOgZF1aJQPDwX3De+4+JntPA3Xu4umTeDXYQeLq4
         6cR/yPezaBkF66XQi5BfqCvnBSDuguTOossd+MX6IabHGcME5qhHpZDbBEh2w3ymY3tg
         EcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310623; x=1733915423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1cxqrRNLtVgEINqhNBjpEtuU6ycwPEQ1YtKh4XaP64=;
        b=nxUlhi50J7lMi5t2bs5wsE46GQOmbIxOCvTNJfmcbdRqM+6+PwrbY0gV7CX/XpeZq0
         VLDKfR70l4u56jeNCv+YT/01zUyf+FxFRaMbapFeFYM+gxkUQuDHytzwQaUHGIkbSjom
         qW17zPXL2iYdS/+ny9yoKct621UIbXRo4gwNOk95/GDXKqhuVPdMkAfuf6ndCBleYS5w
         0SlpV8yd7MjqlE+usFFgljbrJ0JrPJH3HYY3KskQOzoJidWv7qwTBMHviM40RmT+8yRT
         Vp/p87cu5LsqaagYJ8G7w9jvXF4o5uHdDqFTIAdrlK8OV2+s4y1lCASy+ga6xQ51Mzni
         duBA==
X-Forwarded-Encrypted: i=1; AJvYcCUMQwz1wVUvxhvJK8MRIlw9Icj7566AWOAPGXzBCaYcIeKY5uZdyyz7aiIePepZaNU3Ga+ULXYoLGGmfWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSV7phGb25vYOG2LGk4/3cxheQg+GacqQCve7qDge4RsKauzuI
	4NVchA+bYudJIXZlWzSY3BIrvGLQ4jygeBvtXkpLjxXLfaw8cbSCdh700jD9ZoY=
X-Gm-Gg: ASbGncs6KzW6LRAATsWsXjPIat1n7+SPoPTkPY3QFZXFMoDO9MqM+yNKrnhYl5CsVrl
	Kkh8idhU1tIrWeeldc4I5+TewoqSdIFUfrKzWvHXovwrSu7f9bX8H326M7wz8fy+jegry2ypoiV
	cQBDOBWzQeOeHb2Nx5lb9j33WWD+LsoyBoCogLl6ldrcWw52oAJ3K4SqdPaiGK1HmrUVfxMaI6H
	bB6YL8IQxo7yxlvRSLmXIhZVsleKyZHnkq199NYKCiYsH1Tpyj4XWkTr3EPls3N8VSGga7dZx8S
	wemO377i4U03Pwo=
X-Google-Smtp-Source: AGHT+IF1f5oofbaWvETvYEiHLO/zdFbjQACTN4HhvvjpL8HNWx6S5PsEo00LYzRIYs4wKfqYTCWGBg==
X-Received: by 2002:a17:902:e549:b0:215:6e28:827c with SMTP id d9443c01a7336-215d00f6d59mr48414015ad.56.1733310623257;
        Wed, 04 Dec 2024 03:10:23 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21527515731sm107447495ad.192.2024.12.04.03.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:10:22 -0800 (PST)
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
Subject: [PATCH v4 01/11] mm: khugepaged: recheck pmd state in retract_page_tables()
Date: Wed,  4 Dec 2024 19:09:41 +0800
Message-Id: <70a51804cd19d44ccaf031825d9fb6eaf92f2bad.1733305182.git.zhengqi.arch@bytedance.com>
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

In retract_page_tables(), the lock of new_folio is still held, we will be
blocked in the page fault path, which prevents the pte entries from being
set again. So even though the old empty PTE page may be concurrently freed
and a new PTE page is filled into the pmd entry, it is still empty and can
be removed.

So just refactor the retract_page_tables() a little bit and recheck the
pmd state after holding the pmd lock.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 Documentation/mm/process_addrs.rst |  4 +++
 mm/khugepaged.c                    | 45 ++++++++++++++++++++----------
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
index 1d416658d7f59..81417fa2ed20b 100644
--- a/Documentation/mm/process_addrs.rst
+++ b/Documentation/mm/process_addrs.rst
@@ -531,6 +531,10 @@ are extra requirements for accessing them:
   new page table has been installed in the same location and filled with
   entries. Writers normally need to take the PTE lock and revalidate that the
   PMD entry still refers to the same PTE-level page table.
+  If the writer does not care whether it is the same PTE-level page table, it
+  can take the PMD lock and revalidate that the contents of pmd entry still meet
+  the requirements. In particular, this also happens in :c:func:`!retract_page_tables`
+  when handling :c:macro:`!MADV_COLLAPSE`.
 
 To access PTE-level page tables, a helper like :c:func:`!pte_offset_map_lock` or
 :c:func:`!pte_offset_map` can be used depending on stability requirements.
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6f8d46d107b4b..99dc995aac110 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -947,17 +947,10 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 	return SCAN_SUCCEED;
 }
 
-static int find_pmd_or_thp_or_none(struct mm_struct *mm,
-				   unsigned long address,
-				   pmd_t **pmd)
+static inline int check_pmd_state(pmd_t *pmd)
 {
-	pmd_t pmde;
+	pmd_t pmde = pmdp_get_lockless(pmd);
 
-	*pmd = mm_find_pmd(mm, address);
-	if (!*pmd)
-		return SCAN_PMD_NULL;
-
-	pmde = pmdp_get_lockless(*pmd);
 	if (pmd_none(pmde))
 		return SCAN_PMD_NONE;
 	if (!pmd_present(pmde))
@@ -971,6 +964,17 @@ static int find_pmd_or_thp_or_none(struct mm_struct *mm,
 	return SCAN_SUCCEED;
 }
 
+static int find_pmd_or_thp_or_none(struct mm_struct *mm,
+				   unsigned long address,
+				   pmd_t **pmd)
+{
+	*pmd = mm_find_pmd(mm, address);
+	if (!*pmd)
+		return SCAN_PMD_NULL;
+
+	return check_pmd_state(*pmd);
+}
+
 static int check_pmd_still_valid(struct mm_struct *mm,
 				 unsigned long address,
 				 pmd_t *pmd)
@@ -1720,7 +1724,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		pmd_t *pmd, pgt_pmd;
 		spinlock_t *pml;
 		spinlock_t *ptl;
-		bool skipped_uffd = false;
+		bool success = false;
 
 		/*
 		 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
@@ -1757,6 +1761,19 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		mmu_notifier_invalidate_range_start(&range);
 
 		pml = pmd_lock(mm, pmd);
+		/*
+		 * The lock of new_folio is still held, we will be blocked in
+		 * the page fault path, which prevents the pte entries from
+		 * being set again. So even though the old empty PTE page may be
+		 * concurrently freed and a new PTE page is filled into the pmd
+		 * entry, it is still empty and can be removed.
+		 *
+		 * So here we only need to recheck if the state of pmd entry
+		 * still meets our requirements, rather than checking pmd_same()
+		 * like elsewhere.
+		 */
+		if (check_pmd_state(pmd) != SCAN_SUCCEED)
+			goto drop_pml;
 		ptl = pte_lockptr(mm, pmd);
 		if (ptl != pml)
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
@@ -1770,20 +1787,20 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		 * repeating the anon_vma check protects from one category,
 		 * and repeating the userfaultfd_wp() check from another.
 		 */
-		if (unlikely(vma->anon_vma || userfaultfd_wp(vma))) {
-			skipped_uffd = true;
-		} else {
+		if (likely(!vma->anon_vma && !userfaultfd_wp(vma))) {
 			pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
 			pmdp_get_lockless_sync();
+			success = true;
 		}
 
 		if (ptl != pml)
 			spin_unlock(ptl);
+drop_pml:
 		spin_unlock(pml);
 
 		mmu_notifier_invalidate_range_end(&range);
 
-		if (!skipped_uffd) {
+		if (success) {
 			mm_dec_nr_ptes(mm);
 			page_table_check_pte_clear_range(mm, addr, pgt_pmd);
 			pte_free_defer(mm, pmd_pgtable(pgt_pmd));
-- 
2.20.1


