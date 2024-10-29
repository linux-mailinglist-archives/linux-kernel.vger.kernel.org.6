Return-Path: <linux-kernel+bounces-386297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2AA9B41A0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 05:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE317B21933
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B477D1DB53A;
	Tue, 29 Oct 2024 04:45:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C622FB2
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730177141; cv=none; b=IYQHigT9p4AOgWUttrsZA4Jms/4Nb6LKWkDHCz9xEhryFzCnKgH7pDIRKvsnGKNZKcBU25O8hXHB47gUJdfZ4WDNc3cgsp/5YUoUNSDs7NNRMkCyyAdRB76OqYuM81GjCGOZ7OfuYELDKH0HwIk+4BsFJQqGsVvwNDcG3sGnjUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730177141; c=relaxed/simple;
	bh=1fFWrVabQK6lR2qBCMimckzMDKPa1pDQUcCAHcFWbYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LWHFyYaI2d9uUflQynY0Ga+BzY94+Uj/fkI5YY3hy9itn5kfo+4XPNNzJLZlAr1HFIMdYUB1FWMw1XwsPK11mhjPmMcaxmc5LQ5iEbnyA5OtsWFYVIzoHZ9pEqjKCPnImm7/vn4OdLVMHb5POyTN/4zm+uc8JjicyfRM6cNhSL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A90013D5;
	Mon, 28 Oct 2024 21:46:07 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.43.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 23BCA3F66E;
	Mon, 28 Oct 2024 21:45:34 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Re-organize arch_make_huge_pte()
Date: Tue, 29 Oct 2024 10:15:29 +0530
Message-Id: <20241029044529.2624785-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core HugeTLB defines a fallback definition for arch_make_huge_pte(), which
calls platform provided pte_mkhuge(). But if any platform already provides
an override for arch_make_huge_pte(), then it does not need to provide the
helper pte_mkhuge().

arm64 override for arch_make_huge_pte() calls pte_mkhuge() internally, thus
creating an impression, that both of these callbacks are being used in core
HugeTLB and hence required to be defined. This drops off pte_mkhuge() which
was never required to begin with as there could not be any section mappings
at the PTE level. Re-organize arch_make_huge_pte() based on requested page
size and create the entry for the applicable page table level as needed. It
also removes a redundancy of clearing PTE_TABLE_BIT bit followed by setting
both PTE_TABLE_BIT and PTE_VALID bits (via PTE_TYPE_MASK) in the pte, while
creating CONT_PTE_SIZE size entries.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.12-rc5

 arch/arm64/include/asm/pgtable.h |  5 -----
 arch/arm64/mm/hugetlbpage.c      | 21 ++++++++++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index c329ea061dc9..fa4c32a9f572 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -438,11 +438,6 @@ static inline void __set_ptes(struct mm_struct *mm,
 	}
 }
 
-/*
- * Huge pte definitions.
- */
-#define pte_mkhuge(pte)		(__pte(pte_val(pte) & ~PTE_TABLE_BIT))
-
 /*
  * Hugetlb definitions.
  */
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 5f1e2103888b..3215adf48a1b 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -361,14 +361,25 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 {
 	size_t pagesize = 1UL << shift;
 
-	entry = pte_mkhuge(entry);
-	if (pagesize == CONT_PTE_SIZE) {
-		entry = pte_mkcont(entry);
-	} else if (pagesize == CONT_PMD_SIZE) {
+	switch (pagesize) {
+#ifndef __PAGETABLE_PMD_FOLDED
+	case PUD_SIZE:
+		entry = pud_pte(pud_mkhuge(pte_pud(entry)));
+		break;
+#endif
+	case CONT_PMD_SIZE:
 		entry = pmd_pte(pmd_mkcont(pte_pmd(entry)));
-	} else if (pagesize != PUD_SIZE && pagesize != PMD_SIZE) {
+		fallthrough;
+	case PMD_SIZE:
+		entry = pmd_pte(pmd_mkhuge(pte_pmd(entry)));
+		break;
+	case CONT_PTE_SIZE:
+		entry = pte_mkcont(entry);
+		break;
+	default:
 		pr_warn("%s: unrecognized huge page size 0x%lx\n",
 			__func__, pagesize);
+		break;
 	}
 	return entry;
 }
-- 
2.30.2


