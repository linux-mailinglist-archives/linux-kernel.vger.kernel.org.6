Return-Path: <linux-kernel+bounces-363885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A7799C824
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CBE81C258C9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45596197A7F;
	Mon, 14 Oct 2024 11:01:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272E41CDA1C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903690; cv=none; b=J41EGh0EthBvxMy8ORdUX++KLKnvGtQv7dv/n1r4IYuQtrmdacCBdbh8pdhr8iqyvCRQskHko1e6LQ26B4MwIW56Ac5hmciayftlepPN9jTgXTPZ7sjpJb2lAxlds5W5pRDyxwbUd/UcI6m8qR0PC13BxhXf7IFwkSYCrIaz7dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903690; c=relaxed/simple;
	bh=OLdhu0u23F+ZZljFwJnrSwSvGS+FWLHxCZdY+sSLaV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StXrBAxXTaiFuZ6gZvPvx2DEJqFJSexln3jSal3HvjSkLOTSuMk4MYtDB++VEUdCNkf7Nd7/OFDeTgw/yDlQGXBEtfejsxzkhZbsVW+HXwkm2pP2DgXEmABtGdIJPqZJtofJOgHga00RpN2nEthMjmlod0AwL3uTahjZx/Hmv1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F1811756;
	Mon, 14 Oct 2024 04:01:58 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E88C3F51B;
	Mon, 14 Oct 2024 04:01:26 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 39/57] arm64: Introduce macros required for boot-time page selection
Date: Mon, 14 Oct 2024 11:58:46 +0100
Message-ID: <20241014105912.3207374-39-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This minmal set of macros will allow boot-time page selection support to
be added to the arm64 arch code incrementally over the following set of
patches.

The definitions in pgtable-geometry.h are for compile-time page size
currently, but they will be modified in future to support boot-time page
size.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 arch/arm64/include/asm/page-def.h         |  5 ++--
 arch/arm64/include/asm/pgtable-geometry.h | 28 +++++++++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h    | 16 ++++++++-----
 3 files changed, 40 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/include/asm/pgtable-geometry.h

diff --git a/arch/arm64/include/asm/page-def.h b/arch/arm64/include/asm/page-def.h
index d69971cf49cd2..b99dee0112463 100644
--- a/arch/arm64/include/asm/page-def.h
+++ b/arch/arm64/include/asm/page-def.h
@@ -9,12 +9,11 @@
 #define __ASM_PAGE_DEF_H
 
 #include <linux/const.h>
+#include <asm/pgtable-geometry.h>
 
 /* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT		CONFIG_PAGE_SHIFT
+#define PAGE_SHIFT		ptg_page_shift
 #define PAGE_SIZE		(_AC(1, UL) << PAGE_SHIFT)
 #define PAGE_MASK		(~(PAGE_SIZE-1))
 
-#include <asm-generic/pgtable-geometry.h>
-
 #endif /* __ASM_PAGE_DEF_H */
diff --git a/arch/arm64/include/asm/pgtable-geometry.h b/arch/arm64/include/asm/pgtable-geometry.h
new file mode 100644
index 0000000000000..62fe125909c08
--- /dev/null
+++ b/arch/arm64/include/asm/pgtable-geometry.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef ASM_PGTABLE_GEOMETRY_H
+#define ASM_PGTABLE_GEOMETRY_H
+
+#define ARM64_PAGE_SHIFT_4K	12
+#define ARM64_PAGE_SHIFT_16K	14
+#define ARM64_PAGE_SHIFT_64K	16
+
+#define PAGE_SHIFT_MIN		CONFIG_PAGE_SHIFT
+#define PAGE_SIZE_MIN		(_AC(1, UL) << PAGE_SHIFT_MIN)
+#define PAGE_MASK_MIN		(~(PAGE_SIZE_MIN-1))
+
+#define PAGE_SHIFT_MAX		CONFIG_PAGE_SHIFT
+#define PAGE_SIZE_MAX		(_AC(1, UL) << PAGE_SHIFT_MAX)
+#define PAGE_MASK_MAX		(~(PAGE_SIZE_MAX-1))
+
+#include <asm-generic/pgtable-geometry.h>
+
+#define ptg_page_shift		CONFIG_PAGE_SHIFT
+#define ptg_pmd_shift		ARM64_HW_PGTABLE_LEVEL_SHIFT(2)
+#define ptg_pud_shift		ARM64_HW_PGTABLE_LEVEL_SHIFT(1)
+#define ptg_p4d_shift		ARM64_HW_PGTABLE_LEVEL_SHIFT(0)
+#define ptg_pgdir_shift		ARM64_HW_PGTABLE_LEVEL_SHIFT(4 - CONFIG_PGTABLE_LEVELS)
+#define ptg_cont_pte_shift	(CONFIG_ARM64_CONT_PTE_SHIFT + PAGE_SHIFT)
+#define ptg_cont_pmd_shift	(CONFIG_ARM64_CONT_PMD_SHIFT + PMD_SHIFT)
+#define ptg_pgtable_levels	CONFIG_PGTABLE_LEVELS
+
+#endif /* ASM_PGTABLE_GEOMETRY_H */
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 1f60aa1bc750c..54a9153f56bc5 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -41,39 +41,43 @@
 #define ARM64_HW_PGTABLE_LEVEL_SHIFT(n)	((PAGE_SHIFT - 3) * (4 - (n)) + 3)
 
 #define PTRS_PER_PTE		(1 << (PAGE_SHIFT - 3))
+#define MAX_PTRS_PER_PTE	(1 << (PAGE_SHIFT_MAX - 3))
 
 /*
  * PMD_SHIFT determines the size a level 2 page table entry can map.
  */
 #if CONFIG_PGTABLE_LEVELS > 2
-#define PMD_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(2)
+#define PMD_SHIFT		ptg_pmd_shift
 #define PMD_SIZE		(_AC(1, UL) << PMD_SHIFT)
 #define PMD_MASK		(~(PMD_SIZE-1))
 #define PTRS_PER_PMD		(1 << (PAGE_SHIFT - 3))
+#define MAX_PTRS_PER_PMD	(1 << (PAGE_SHIFT_MAX - 3))
 #endif
 
 /*
  * PUD_SHIFT determines the size a level 1 page table entry can map.
  */
 #if CONFIG_PGTABLE_LEVELS > 3
-#define PUD_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(1)
+#define PUD_SHIFT		ptg_pud_shift
 #define PUD_SIZE		(_AC(1, UL) << PUD_SHIFT)
 #define PUD_MASK		(~(PUD_SIZE-1))
 #define PTRS_PER_PUD		(1 << (PAGE_SHIFT - 3))
+#define MAX_PTRS_PER_PUD	(1 << (PAGE_SHIFT_MAX - 3))
 #endif
 
 #if CONFIG_PGTABLE_LEVELS > 4
-#define P4D_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(0)
+#define P4D_SHIFT		ptg_p4d_shift
 #define P4D_SIZE		(_AC(1, UL) << P4D_SHIFT)
 #define P4D_MASK		(~(P4D_SIZE-1))
 #define PTRS_PER_P4D		(1 << (PAGE_SHIFT - 3))
+#define MAX_PTRS_PER_P4D	(1 << (PAGE_SHIFT_MAX - 3))
 #endif
 
 /*
  * PGDIR_SHIFT determines the size a top-level page table entry can map
  * (depending on the configuration, this level can be -1, 0, 1 or 2).
  */
-#define PGDIR_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(4 - CONFIG_PGTABLE_LEVELS)
+#define PGDIR_SHIFT		ptg_pgdir_shift
 #define PGDIR_SIZE		(_AC(1, UL) << PGDIR_SHIFT)
 #define PGDIR_MASK		(~(PGDIR_SIZE-1))
 #define PTRS_PER_PGD		(1 << (VA_BITS - PGDIR_SHIFT))
@@ -81,12 +85,12 @@
 /*
  * Contiguous page definitions.
  */
-#define CONT_PTE_SHIFT		(CONFIG_ARM64_CONT_PTE_SHIFT + PAGE_SHIFT)
+#define CONT_PTE_SHIFT		ptg_cont_pte_shift
 #define CONT_PTES		(1 << (CONT_PTE_SHIFT - PAGE_SHIFT))
 #define CONT_PTE_SIZE		(CONT_PTES * PAGE_SIZE)
 #define CONT_PTE_MASK		(~(CONT_PTE_SIZE - 1))
 
-#define CONT_PMD_SHIFT		(CONFIG_ARM64_CONT_PMD_SHIFT + PMD_SHIFT)
+#define CONT_PMD_SHIFT		ptg_cont_pmd_shift
 #define CONT_PMDS		(1 << (CONT_PMD_SHIFT - PMD_SHIFT))
 #define CONT_PMD_SIZE		(CONT_PMDS * PMD_SIZE)
 #define CONT_PMD_MASK		(~(CONT_PMD_SIZE - 1))
-- 
2.43.0


