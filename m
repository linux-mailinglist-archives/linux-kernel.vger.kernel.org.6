Return-Path: <linux-kernel+bounces-525171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3F5A3EBF3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17835702598
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 04:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8538B1FBE9D;
	Fri, 21 Feb 2025 04:43:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A523B1FBE89
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 04:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740112983; cv=none; b=mdLNLlGezjbihxFw5jQ2ZZMDrcZ5UHMX4OQKnOdl7ItnrYMZZisQms4cQlDHWB742pJWKEBL9pE3Rj5EUVPeKjndXmzDVVXUq87GYPOraEwNNmmCrDLvAOrXAl5kTcpCIE7nD+rd9XAfHQLkqQ6oGVykEKRe/YeL3k8Dxe+ZUGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740112983; c=relaxed/simple;
	bh=w12RmaK2E7AsICmm7r1Zy5+t5NgzhGpim7OZ2dRKUyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fGaovn7Cg4+5UsycuHrsC3MBBnsrWNUVwXx8ZlgUH7XsifPz/QS6Sgq8+6mdNzNuskrjL2B8UO5K+KXC/QGhrjEUMzz1MBDF/lgmzxZ7F1yijDRK++Fzt3gCcLja6ofspxQHeZTq3gaxBMdpXD5bC/xyNfVZYyA0czkFaECWijU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBB601C01;
	Thu, 20 Feb 2025 20:43:18 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 808E03F6A8;
	Thu, 20 Feb 2025 20:42:56 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/8] arm64/mm: Clear PXX_TYPE_MASK and set PXD_TYPE_SECT in [pmd|pud]_mkhuge()
Date: Fri, 21 Feb 2025 10:12:23 +0530
Message-Id: <20250221044227.1145393-5-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250221044227.1145393-1-anshuman.khandual@arm.com>
References: <20250221044227.1145393-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clear PXX_TYPE_MASK in [pmd|pud]_mkhuge() while creating section mappings
instead of just the PXX_TABLE_BIT and also set PXD_TYPE_SECT. Also ensure
PTE_VALID does not get modified in these helpers, because present-invalid
entries should preserve their state across.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index c16e9e74e309..4485ecdffd8a 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -585,7 +585,18 @@ static inline int pmd_trans_huge(pmd_t pmd)
 
 #define pmd_write(pmd)		pte_write(pmd_pte(pmd))
 
-#define pmd_mkhuge(pmd)		(__pmd(pmd_val(pmd) & ~PMD_TABLE_BIT))
+static inline pmd_t pmd_mkhuge(pmd_t pmd)
+{
+	/*
+	 * It's possible that the pmd is present-invalid on entry
+	 * and in that case it needs to remain present-invalid on
+	 * exit. So ensure the VALID bit does not get modified.
+	 */
+	pmdval_t mask = PMD_TYPE_MASK & ~PTE_VALID;
+	pmdval_t val = PMD_TYPE_SECT & ~PTE_VALID;
+
+	return __pmd((pmd_val(pmd) & ~mask) | val);
+}
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define pmd_devmap(pmd)		pte_devmap(pmd_pte(pmd))
@@ -613,7 +624,18 @@ static inline pmd_t pmd_mkspecial(pmd_t pmd)
 #define pud_mkyoung(pud)	pte_pud(pte_mkyoung(pud_pte(pud)))
 #define pud_write(pud)		pte_write(pud_pte(pud))
 
-#define pud_mkhuge(pud)		(__pud(pud_val(pud) & ~PUD_TABLE_BIT))
+static inline pud_t pud_mkhuge(pud_t pud)
+{
+	/*
+	 * It's possible that the pud is present-invalid on entry
+	 * and in that case it needs to remain present-invalid on
+	 * exit. So ensure the VALID bit does not get modified.
+	 */
+	pudval_t mask = PUD_TYPE_MASK & ~PTE_VALID;
+	pudval_t val = PUD_TYPE_SECT & ~PTE_VALID;
+
+	return __pud((pud_val(pud) & ~mask) | val);
+}
 
 #define __pud_to_phys(pud)	__pte_to_phys(pud_pte(pud))
 #define __phys_to_pud_val(phys)	__phys_to_pte_val(phys)
-- 
2.25.1


