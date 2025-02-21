Return-Path: <linux-kernel+bounces-525170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A73ADA3EBF0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20D419C5BD2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 04:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DB31FC7F0;
	Fri, 21 Feb 2025 04:42:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734301FC7D4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 04:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740112977; cv=none; b=pelq2Gj14qF52BhQW8YFi/3qBy3IGDWYVSU/n81om3TT3A3y+1gUTScmP7sASLYDrlQv9xcfsTG764dkyZnPugUbdPYuO3wi8i88vtuH83v0kc6ZJ2eNA2+vNmHoBCGlpklYv+mSyC3gPK65HD8bCxBlryq/wNnv0HF6FXP18os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740112977; c=relaxed/simple;
	bh=hueR/qKnuhBthJQUELmNrlp0F0JfQ1aUISp4QGJ6+f4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V7PPSDtz3S7x3yDUBKgZEEbuthI+LDbLfB+vGZOq4t7pLkMPY5DCuPKgDhYbZXEnzaoft6doaDVMPI+P44Z5BEgT3Trl/IMASuvdsvD19WDoUBxwGrxdRhciaJY2GDG0K9Z3GmaH4Rj8mlGVNnPEhBFyv7ZONJN9hS7w4dvANMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0E381C01;
	Thu, 20 Feb 2025 20:43:13 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 630C83F6A8;
	Thu, 20 Feb 2025 20:42:51 -0800 (PST)
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
Subject: [PATCH V2 3/8] arm64/mm: Clear PXX_TYPE_MASK in mk_[pmd|pud]_sect_prot()
Date: Fri, 21 Feb 2025 10:12:22 +0530
Message-Id: <20250221044227.1145393-4-anshuman.khandual@arm.com>
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

Clear PXX_TYPE_MASK bits in mk_[pmd|pud]_sect_prot() while creating section
mappings instead of just clearing the PXX_TABLE_BIT.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0b2a2ad1b9e8..c16e9e74e309 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -483,12 +483,12 @@ static inline pmd_t pte_pmd(pte_t pte)
 
 static inline pgprot_t mk_pud_sect_prot(pgprot_t prot)
 {
-	return __pgprot((pgprot_val(prot) & ~PUD_TABLE_BIT) | PUD_TYPE_SECT);
+	return __pgprot((pgprot_val(prot) & ~PUD_TYPE_MASK) | PUD_TYPE_SECT);
 }
 
 static inline pgprot_t mk_pmd_sect_prot(pgprot_t prot)
 {
-	return __pgprot((pgprot_val(prot) & ~PMD_TABLE_BIT) | PMD_TYPE_SECT);
+	return __pgprot((pgprot_val(prot) & ~PMD_TYPE_MASK) | PMD_TYPE_SECT);
 }
 
 static inline pte_t pte_swp_mkexclusive(pte_t pte)
-- 
2.25.1


