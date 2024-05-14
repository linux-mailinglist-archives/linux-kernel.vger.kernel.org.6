Return-Path: <linux-kernel+bounces-178787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B39518C57A7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DDED2848BB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F8414535E;
	Tue, 14 May 2024 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DocwhOPM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8915144D0E
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695539; cv=none; b=Z5WJdYT8uW6yxkGoOo9A75hpqwseQAZGABOkl7DeujIIxBCfD8KuXbH15sT94eTo0bq2Ew6Ga4e/Cj/KfAMbgavfMkJgrnr4a4mLdIMnqXxzZYNFGCLeBgGcFodNQ4aDDFPt9poaC3j9UVMvoDwvTDyQZ0WBuEhN8aq2qGCiVxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695539; c=relaxed/simple;
	bh=ID0c8KED4MaRAhJEPecqve06L1MFkX8CguX3Z8emb34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PrVUBPoTKo6EM/AekbGM3N4On9WUgi3ZNQ7vzpVGvgb8gzVH6gT1NraG1csItIOKZXi9q5VR7etS5pq/Iun//6UC/QBVpRRdA9QXFvmp6weiuHiTpfn94oBt4XraRu7TUxFxJId41s/SZRoXUpaVJugDKyDKr5ozmJe7wrzfRqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DocwhOPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AD3C32782;
	Tue, 14 May 2024 14:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715695539;
	bh=ID0c8KED4MaRAhJEPecqve06L1MFkX8CguX3Z8emb34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DocwhOPMzvezJPtOLEyIs2TIRSDK1iKYiQIktTqvDEydUXhzyMFEVIe4w7rEBUoLH
	 s1Aip/eIuRLs0LXxRO2MMKQduZjZ4DBOo06roaRsDYMD4/V0p/WrJ1lfcdUWNFUWwn
	 ODSRdACvCftCwaJk1JNzfbi3KPDD6bOSxG75Dty41GwFFUJmy5m2JNOYIkDK9lRWK4
	 +67Ojs55jbeazXTVY+CfQswUJQMXyrqtCucl7p6pKvQpAHUytS7hU/8LLSnmhoiUR/
	 8vk20MjslNrDRrN0YMhL+gaxgJaWiumVfcpTRg8PMQDoBY6o9yqd75mDcjXratHavn
	 aZt3F8dpoR/bA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v2 8/8] riscv: mm: Add support for ZONE_DEVICE
Date: Tue, 14 May 2024 16:04:46 +0200
Message-Id: <20240514140446.538622-9-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240514140446.538622-1-bjorn@kernel.org>
References: <20240514140446.538622-1-bjorn@kernel.org>
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

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig                    |  1 +
 arch/riscv/include/asm/pgtable-64.h   | 20 ++++++++++++++++++++
 arch/riscv/include/asm/pgtable-bits.h |  1 +
 arch/riscv/include/asm/pgtable.h      | 15 +++++++++++++++
 4 files changed, 37 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b9398b64bb69..6d426afdd904 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -36,6 +36,7 @@ config RISCV
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API
 	select ARCH_HAS_PREPARE_SYNC_CORE_CMD
+	select ARCH_HAS_PTE_DEVMAP if 64BIT && MMU
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP if MMU
 	select ARCH_HAS_SET_MEMORY if MMU
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 221a5c1ee287..c67a9bbfd010 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -400,4 +400,24 @@ static inline struct page *pgd_page(pgd_t pgd)
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
index 7933f493db71..216de1db3cd0 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -387,6 +387,11 @@ static inline int pte_special(pte_t pte)
 	return pte_val(pte) & _PAGE_SPECIAL;
 }
 
+static inline int pte_devmap(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_DEVMAP;
+}
+
 /* static inline pte_t pte_rdprotect(pte_t pte) */
 
 static inline pte_t pte_wrprotect(pte_t pte)
@@ -428,6 +433,11 @@ static inline pte_t pte_mkspecial(pte_t pte)
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
@@ -711,6 +721,11 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
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
2.40.1


