Return-Path: <linux-kernel+bounces-535441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BCDA472E1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A233A15C6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5401A08B1;
	Thu, 27 Feb 2025 02:24:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3B9187554
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740623064; cv=none; b=BuyRamuZMdKbQjZX7G4Tc4rlBEJc7tTBIXbzWtqONgGt1rKUHJfDxFnWAO6Yh7OfQQPjKjhx7lVflk3i/M5bqmi8ypaFRkPyRLHsXP533zs6ooBy1hIikcWrvvUATQjQ0TWbutFEDcjJwmZW1JsyLl0BB9K7j14h6b/Sqv/0sdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740623064; c=relaxed/simple;
	bh=bIRnW7/oAp/lEs55zCfjyViQq6VYZdJG2zEWrh0tpV4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Axml5X5FVKuwfmN/h3iAFCBnDfl6iaUiwIYZbROhMdx/AllGLzWUOFuhXz2FLqZ3gd4/xUeeIJ+g+sE0r5MOcpYODstYB6nhqDgePUwNrZxsHj6Ttejn4nyoT1SyxIYqJPIEt2y/joxXIUkbYz02F7rEh4GttGV52pBZGVRkPhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC0EB1515;
	Wed, 26 Feb 2025 18:24:36 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6504A3F673;
	Wed, 26 Feb 2025 18:24:18 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com,
	ryan.roberts@arm.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64/mm: Convert __pte_to_phys() and __phys_to_pte_val() as functions
Date: Thu, 27 Feb 2025 07:54:12 +0530
Message-Id: <20250227022412.2015835-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_ARM64_PA_BITS_52 is enabled, page table helpers __pte_to_phys()
and __phys_to_pte_val() are functions which return phys_addr_t and pteval_t
respectively as expected. But otherwise without this config being enabled,
they are defined as macros and their return types are implicit.

Until now this has worked out correctly as both pte_t and phys_addr_t data
types have been 64 bits. But with the introduction of 128 bit page tables,
pte_t becomes 128 bits. Hence this ends up with incorrect widths after the
conversions, which leads to compiler warnings.

Fix these warnings by converting __pte_to_phys() and __phys_to_pte_val()
as functions instead where the return types are handled explicitly.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on v6.14-rc3

Changes in V2:

- Changed the helper macros as functions instead per Mark
- Dropped irrelevant (now) in-code comments per Mark

Changes in V1:

https://lore.kernel.org/all/20250219035646.536707-1-anshuman.khandual@arm.com/

 arch/arm64/include/asm/pgtable.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0b2a2ad1b9e8..4ebfa60ea5c6 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -68,10 +68,6 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 #define pte_ERROR(e)	\
 	pr_err("%s:%d: bad pte %016llx.\n", __FILE__, __LINE__, pte_val(e))
 
-/*
- * Macros to convert between a physical address and its placement in a
- * page table entry, taking care of 52-bit addresses.
- */
 #ifdef CONFIG_ARM64_PA_BITS_52
 static inline phys_addr_t __pte_to_phys(pte_t pte)
 {
@@ -84,8 +80,15 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 	return (phys | (phys >> PTE_ADDR_HIGH_SHIFT)) & PHYS_TO_PTE_ADDR_MASK;
 }
 #else
-#define __pte_to_phys(pte)	(pte_val(pte) & PTE_ADDR_LOW)
-#define __phys_to_pte_val(phys)	(phys)
+static inline phys_addr_t __pte_to_phys(pte_t pte)
+{
+	return pte_val(pte) & PTE_ADDR_LOW;
+}
+
+static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
+{
+	return phys;
+}
 #endif
 
 #define pte_pfn(pte)		(__pte_to_phys(pte) >> PAGE_SHIFT)
-- 
2.30.2


