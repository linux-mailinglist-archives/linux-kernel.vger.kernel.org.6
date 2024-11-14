Return-Path: <linux-kernel+bounces-408787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAF89C8390
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3071F21A4B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067BB1EC01B;
	Thu, 14 Nov 2024 07:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gUUyCeAy"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60D51F26C4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731567637; cv=none; b=iO9LV2wzvKfFxbuzZq8lr3E+94nEA/wsmGzGsqZa8Ymk6pnGYbnEatVcblQkCshQVs40gVgCArlTexw1+htf9/LOJ1wkxxdIMsRQuARogx3l8FXTsVLSBsqrTpPLxPDMS+s09kldXJU+ij7332SClXzXgjZe83yhVJyCgIxeA5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731567637; c=relaxed/simple;
	bh=8YRALO0EvYrZsfU4rQrXY0d2VfwYIIaImO3anfpy2LA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PoCqTSUV8/n9bArNl+93GFeRQEJBrexfWMS0GnvKuSa6q0RQQ4tQNh5LGGHAy0P0bJ/UpieN7FPGMiZQkFxIUP0NNeWyoh0u8d/ksqS2WZExWns0esRiCJhuujjMoL0XMEM6XuXhelGV0cFiNH2eRK8mFQ5NWEBURG/6MyTftlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gUUyCeAy; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea8de14848so169690a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 23:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731567634; x=1732172434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23GC9z2kYnX1PBmcPyoYRptMMW0UHpf+qVqZ3j/14aw=;
        b=gUUyCeAynnNl3ao/FS3QT5jFaB69NEh/mbwTn6pAzN1CjISZEj4yOuaspPFMdeXHfK
         dRtJT/VvLLHy1Bf+F2gLXYVUEvrQvtJFPSA9SCAHG9PYflKbJU5LkWw5XfNApVRZqxng
         2znwksbLZ7rKc0lzZAeCCAvgtpXXijrpPyBLEF2Epdln7BywOWAK0Xwuw3pzhp9Oa8oH
         jeVEcQ/ZCzOJqiGGEP8TgMgwOEH/y8eP1uTly0iWw/qPIiem8OtNkNFWFbioA68RPGal
         rfPDTWGsNv3VyxG36h54GG05Ky317H02xvRTc8IjBgNK7EvlYDLoECAEB2MsRpoEwDQN
         aVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731567634; x=1732172434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23GC9z2kYnX1PBmcPyoYRptMMW0UHpf+qVqZ3j/14aw=;
        b=VfmxnTQAu2SDxAOebdVo4JzhvZM8LXCRIXJJq25JtWodUjySambcZ1L1w3rk/C8ND6
         0YjAqaXaCw+BPeN5jb6r+1taeFmtITUyTtwN9dyUMUJp0sdAHttpErRmD/7wES5l3Vdi
         pSjsW4XzSZeQnDXeqR473Ti87lOpox5m/Ujb4y//GItrzsXP3hpT09Ia3fDboU8NV/sb
         7OV8SwR3oY6eyU/S5yiIsMjVc8jpgXnDR3h82xGhXYHvu5lPmf3pSaIfobTSB+aD6wmJ
         LVGzhqJYhnZEGdQj/ZhlFyFvJkHtfQpIPNCfme01NDqucSQLzPT9oGt9wTHjUdn19sLC
         wryw==
X-Forwarded-Encrypted: i=1; AJvYcCX4p/IDmhYAi8p+/kj+BrSe5hSpRHiPDO7NUXWe9YVupgnSE4ywDbd5GFWgNwtmBObz2hfxP4+vFrko5FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJZ6Cfmqt5qHKvCR9lKGD3oWhz7F/yXDy8FuACj4OoRNimsk96
	m+Yui3kGyjYF341NGlF+O5YH37Cfbo9F/iY5RUbDkirr6wkY7pO/RN7OoJt6CFI=
X-Google-Smtp-Source: AGHT+IE3O39rZGVFEPKMSxSa/5Ca+GqYQaa3AwUorYO2XE8T6fJA6cVIU7wKCrtDgDFVz/hz4vTDDg==
X-Received: by 2002:a05:6a20:8418:b0:1db:d81a:a900 with SMTP id adf61e73a8af0-1dc700ee224mr8489901637.0.1731567633901;
        Wed, 13 Nov 2024 23:00:33 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d389c2sm4119065ad.268.2024.11.13.23.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:00:33 -0800 (PST)
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
Subject: [PATCH v3 1/9] mm: khugepaged: recheck pmd state in retract_page_tables()
Date: Thu, 14 Nov 2024 14:59:52 +0800
Message-Id: <e5b321ffc3ebfcc46e53830e917ad246f7d2825f.1731566457.git.zhengqi.arch@bytedance.com>
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
 mm/khugepaged.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

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


