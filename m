Return-Path: <linux-kernel+bounces-522965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CFEA3D09D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F2207A8CCA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8D219DF6A;
	Thu, 20 Feb 2025 05:05:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643538488
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740027948; cv=none; b=cnL7vCyPR47IACVbF9VHm0ibR4xgViCisohMtT+I9+mfSQow97yhrLcDfr5l3RxYkDgWIaEuPDqpyaKqwyha7d1rO/fH/vY4yjlR88OCq4AgoAI24ijVWyyv3P4wYTtpJ+FfQ9hS4miFSvYDDAvgpSweaTXTOwuqzkOaA2tEGLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740027948; c=relaxed/simple;
	bh=SMRf+EmFHrqGs8VThr3TRHBWy5m2TBg5/amHA9YU1II=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VgbvdQXKGqb3rgGblKwEzophnxnEze0ekNrD3SfSgytfFu+9SJ5vPo4xHC7JhATW+L00i5iq+KWqXJzwbtcuLJB25VEiT7h4twrwSconlDxc14DXP5NKtGY0UHjlmKQUuo9l2nQppJcKqaeXC37PGog1bQRiRLuC+kCQ42POGQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACE9216F3;
	Wed, 19 Feb 2025 21:06:02 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.38.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB3783F6A8;
	Wed, 19 Feb 2025 21:05:41 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: ryan.roberts@arm.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3] arm64/hugetlb: Consistently use pud_sect_supported()
Date: Thu, 20 Feb 2025 10:35:34 +0530
Message-Id: <20250220050534.799645-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's be consistent in using pud_sect_supported() for PUD_SIZE sized pages.
Hence change hugetlb_mask_last_page() and arch_make_huge_pte() as required.
Also re-arranged the switch statement for a common warning message.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on v6.14-rc3

Changes in V3:

- Re-arranged the switch statement for a common warning message per Ryan

Changes in V2:

https://lore.kernel.org/linux-arm-kernel/20250218113639.475947-1-anshuman.khandual@arm.com/

- Added an warning when PUD_SIZE is requested but not supported per Ryan

Changes in V1:

https://lore.kernel.org/linux-arm-kernel/20250217065414.49489-1-anshuman.khandual@arm.com/

 arch/arm64/mm/hugetlbpage.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 98a2a0e64e25..fd7448bb8c80 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -342,7 +342,9 @@ unsigned long hugetlb_mask_last_page(struct hstate *h)
 	switch (hp_size) {
 #ifndef __PAGETABLE_PMD_FOLDED
 	case PUD_SIZE:
-		return PGDIR_SIZE - PUD_SIZE;
+		if (pud_sect_supported())
+			return PGDIR_SIZE - PUD_SIZE;
+		break;
 #endif
 	case CONT_PMD_SIZE:
 		return PUD_SIZE - CONT_PMD_SIZE;
@@ -364,23 +366,21 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	switch (pagesize) {
 #ifndef __PAGETABLE_PMD_FOLDED
 	case PUD_SIZE:
-		entry = pud_pte(pud_mkhuge(pte_pud(entry)));
+		if (pud_sect_supported())
+			return pud_pte(pud_mkhuge(pte_pud(entry)));
 		break;
 #endif
 	case CONT_PMD_SIZE:
-		entry = pmd_pte(pmd_mkcont(pte_pmd(entry)));
-		fallthrough;
+		return pmd_pte(pmd_mkhuge(pmd_mkcont(pte_pmd(entry))));
 	case PMD_SIZE:
-		entry = pmd_pte(pmd_mkhuge(pte_pmd(entry)));
-		break;
+		return pmd_pte(pmd_mkhuge(pte_pmd(entry)));
 	case CONT_PTE_SIZE:
-		entry = pte_mkcont(entry);
-		break;
+		return pte_mkcont(entry);
 	default:
-		pr_warn("%s: unrecognized huge page size 0x%lx\n",
-			__func__, pagesize);
 		break;
 	}
+	pr_warn("%s: unrecognized huge page size 0x%lx\n",
+		__func__, pagesize);
 	return entry;
 }
 
-- 
2.30.2


