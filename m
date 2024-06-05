Return-Path: <linux-kernel+bounces-202286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3558FCABC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64F8DB23012
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A493A199252;
	Wed,  5 Jun 2024 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jo6MEl7i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E0B19924F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587724; cv=none; b=tUVFFvqY1ftcxGCUdRsMlX3N6dwPXkYNE3evzBqh8pSa+YfdpGXKfRLm59ePkhXf/9ILfXFeeyoIzimCaKLAbwOwZnSzjrFjd3Dg4wIokjWQRW1gGIvRP9o/WV3B6TtG9k5JFgdOBQTmwiENTz+C7mSvWJO4KomfJ/jyX1vn8y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587724; c=relaxed/simple;
	bh=IPeVMzLSHAetEan16+4AGusBy5f8DjdVFow0+Vll8PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jeo4sr3IBwbjohyqIKhDe1IeyotWSpWPMLNtPy4QoOm46icJVfqiQhIeQ4tTUOcOvkiZjeP3ea0nsNJ1f5i/aFdRqof+h/CHpYqsx4tV5CKoQEUtdTNajTFbk1VgLGDW7w1/egVKYAZqCQiYVDEZnMzj/fAb8cx/XNw1VmZTFaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jo6MEl7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF64C4AF0C;
	Wed,  5 Jun 2024 11:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587722;
	bh=IPeVMzLSHAetEan16+4AGusBy5f8DjdVFow0+Vll8PM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jo6MEl7isuHaac7iV7kxZMsSBTLmj1eZ5KNdf9SnXhC9rpkaYD0C9ASvySkzfKVoA
	 gTrKEdDt0gpQoX0BIky3ja2sj46cDjW3Qyrq9Zhidq96vvqVl2EBlJ8IJn42DtwXj0
	 89zFsSowmTJK3LO+jbOtmVtfSewlqRQ2mylsiCtsNb8OCmpycycaF7g0QtN6ZWQYMp
	 D1MR8apn8ditgqYOGW2krAy1bR+WunmRVJsKyG1hF8dFzYx71C/RumhKLpICzYp+Z9
	 usff7UPHLDivgDix7qJnceDqNRkKGqCUQm7327NUeGvucwfxvEuUDf/sQ7o4ccSxvM
	 lChmPPJRMdqTg==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	Oscar Salvador <osalvador@suse.de>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v4 10/11] riscv: mm: Add support for ZONE_DEVICE
Date: Wed,  5 Jun 2024 13:40:53 +0200
Message-ID: <20240605114100.315918-11-bjorn@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114100.315918-1-bjorn@kernel.org>
References: <20240605114100.315918-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

ZONE_DEVICE pages need DEVMAP PTEs support to function
(ARCH_HAS_PTE_DEVMAP). Claim another RSW (reserved for software) bit
in the PTE for DEVMAP mark, add the corresponding helpers, and enable
ARCH_HAS_PTE_DEVMAP for riscv64.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig                    |  1 +
 arch/riscv/include/asm/pgtable-64.h   | 20 ++++++++++++++++++++
 arch/riscv/include/asm/pgtable-bits.h |  1 +
 arch/riscv/include/asm/pgtable.h      | 17 +++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8d860ad3b171..8a49b5f4c017 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -37,6 +37,7 @@ config RISCV
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API
 	select ARCH_HAS_PREPARE_SYNC_CORE_CMD
+	select ARCH_HAS_PTE_DEVMAP if 64BIT && MMU
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP if MMU
 	select ARCH_HAS_SET_MEMORY if MMU
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 8c36a8818432..0897dd99ab8d 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -398,4 +398,24 @@ static inline struct page *pgd_page(pgd_t pgd)
 #define p4d_offset p4d_offset
 p4d_t *p4d_offset(pgd_t *pgd, unsigned long address);
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline int pte_devmap(pte_t pte);
+static inline pte_t pmd_pte(pmd_t pmd);
+
+static inline int pmd_devmap(pmd_t pmd)
+{
+	return pte_devmap(pmd_pte(pmd));
+}
+
+static inline int pud_devmap(pud_t pud)
+{
+	return 0;
+}
+
+static inline int pgd_devmap(pgd_t pgd)
+{
+	return 0;
+}
+#endif
+
 #endif /* _ASM_RISCV_PGTABLE_64_H */
diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
index 179bd4afece4..a8f5205cea54 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -19,6 +19,7 @@
 #define _PAGE_SOFT      (3 << 8)    /* Reserved for software */
 
 #define _PAGE_SPECIAL   (1 << 8)    /* RSW: 0x1 */
+#define _PAGE_DEVMAP    (1 << 9)    /* RSW, devmap */
 #define _PAGE_TABLE     _PAGE_PRESENT
 
 /*
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 41f1b2c6f949..dd4d52940106 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -390,6 +390,13 @@ static inline int pte_special(pte_t pte)
 	return pte_val(pte) & _PAGE_SPECIAL;
 }
 
+#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
+static inline int pte_devmap(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_DEVMAP;
+}
+#endif
+
 /* static inline pte_t pte_rdprotect(pte_t pte) */
 
 static inline pte_t pte_wrprotect(pte_t pte)
@@ -431,6 +438,11 @@ static inline pte_t pte_mkspecial(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_SPECIAL);
 }
 
+static inline pte_t pte_mkdevmap(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_DEVMAP);
+}
+
 static inline pte_t pte_mkhuge(pte_t pte)
 {
 	return pte;
@@ -721,6 +733,11 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
 	return pte_pmd(pte_mkdirty(pmd_pte(pmd)));
 }
 
+static inline pmd_t pmd_mkdevmap(pmd_t pmd)
+{
+	return pte_pmd(pte_mkdevmap(pmd_pte(pmd)));
+}
+
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 				pmd_t *pmdp, pmd_t pmd)
 {
-- 
2.43.0


