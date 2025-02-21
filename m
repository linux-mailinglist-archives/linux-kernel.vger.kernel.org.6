Return-Path: <linux-kernel+bounces-525529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D35BFA3F0E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0023B107C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF8B20102C;
	Fri, 21 Feb 2025 09:45:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C5A205509
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131108; cv=none; b=aKb9OM1SqVJlKXTFzyCFn5phQO6sfz/by5P0WqLhcbhWPYhF9goKihn2HF8tVA8nIEl2J2YMk1V+LQrYbNmZGD5DgZDO1FxlXNYF5TO+if0f4f2YHtaJOkfNwDIhEdqAr8+RugfselLvhViK+DtGUpnQk6uEjJcyBrrOWaZaJgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131108; c=relaxed/simple;
	bh=pTbpsDeO4lMEKiDtq6c1jk9rA1q8xSKS1V5q0oE0oQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FmLB+TMXRMmKcXnbjzJfwmCpleQqkjjL4CiXYB+xtSYlWVL0ZDpwu9kpdYjWU4saPO5XV0YihYwPWaWhTUL3HgzQ7+Y86/oER3Kb3MtOoX9R07a36aFz9guMive5CmcmLlw6EZzTFsgZYlwnHE6rswJlk2CMwrqUKBFpogmZ4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB89A12FC;
	Fri, 21 Feb 2025 01:45:22 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D4B73F59E;
	Fri, 21 Feb 2025 01:45:01 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64/mm/hotplug: Replace pxx_present() with pxx_valid()
Date: Fri, 21 Feb 2025 15:14:49 +0530
Message-Id: <20250221094449.1188427-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250221094449.1188427-1-anshuman.khandual@arm.com>
References: <20250221094449.1188427-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pte_present() asserts either the entry has PTE_VALID or PTE_PRESENT_INVALID
bit set. Although PTE_PRESENT_INVALID bit only gets set on user space page
table entries to represent pxx_present_invalid() state. So present invalid
state is not really possible in kernel page table entries including linear
and vmemap mapping which get teared down during memory hot remove operation
. Hence just check for pxx_valid() instead of pxx_present() in all relevant
places.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/mmu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 66906c45c7f6..33a8b77b5e6b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -863,7 +863,7 @@ static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
 		if (pte_none(pte))
 			continue;
 
-		WARN_ON(!pte_present(pte));
+		WARN_ON(!pte_valid(pte));
 		__pte_clear(&init_mm, addr, ptep);
 		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 		if (free_mapped)
@@ -886,7 +886,7 @@ static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
 		if (pmd_none(pmd))
 			continue;
 
-		WARN_ON(!pmd_present(pmd));
+		WARN_ON(!pmd_valid(pmd));
 		if (pmd_sect(pmd)) {
 			pmd_clear(pmdp);
 
@@ -919,7 +919,7 @@ static void unmap_hotplug_pud_range(p4d_t *p4dp, unsigned long addr,
 		if (pud_none(pud))
 			continue;
 
-		WARN_ON(!pud_present(pud));
+		WARN_ON(!pud_valid(pud));
 		if (pud_sect(pud)) {
 			pud_clear(pudp);
 
@@ -1032,7 +1032,7 @@ static void free_empty_pmd_table(pud_t *pudp, unsigned long addr,
 		if (pmd_none(pmd))
 			continue;
 
-		WARN_ON(!pmd_present(pmd) || !pmd_table(pmd) || pmd_sect(pmd));
+		WARN_ON(!pmd_valid(pmd) || !pmd_table(pmd) || pmd_sect(pmd));
 		free_empty_pte_table(pmdp, addr, next, floor, ceiling);
 	} while (addr = next, addr < end);
 
@@ -1072,7 +1072,7 @@ static void free_empty_pud_table(p4d_t *p4dp, unsigned long addr,
 		if (pud_none(pud))
 			continue;
 
-		WARN_ON(!pud_present(pud) || !pud_table(pud) || pud_sect(pud));
+		WARN_ON(!pud_valid(pud) || !pud_table(pud) || pud_sect(pud));
 		free_empty_pmd_table(pudp, addr, next, floor, ceiling);
 	} while (addr = next, addr < end);
 
-- 
2.30.2


