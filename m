Return-Path: <linux-kernel+bounces-184906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8348CADA1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F7D1F2356D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDC97CF1F;
	Tue, 21 May 2024 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rESFWlwt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C02E76045
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292165; cv=none; b=dkS7wBpl/vvB5l4gjYx48zbU9PAkguRYwYLMwucnhjsFkhQF3VP2/VSg5Npmy/7M3d8iH/AeiSm27Yi02blDMPsk1fQXkRM1OLIqco0sF8pkzDPUm6RjHDgVBYZb8LiJVklYti5bNY/JSSI8zrZSQffGFS7m4hKH726tKApIkM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292165; c=relaxed/simple;
	bh=UfTTCJAd6gAR/W/+kWuHX2+0dwTK25Vi11SpkX7YGOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpCPrrD9Mg7l5FjKa1yruJQPuHRmMtubSkXjjm5Unw6KlIIxueQ6FzUDleLcoQUFbbz2J5Osg+4eaStSodYUGBvOzk0JRxfzI/WC/4V0hBxOZcu6WYbU9fBC+GFdBW29k3RtIb01lyvdW9FOW2KcSkNKEkEc2lhn0kYOlZeSUcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rESFWlwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F4EC2BD11;
	Tue, 21 May 2024 11:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716292164;
	bh=UfTTCJAd6gAR/W/+kWuHX2+0dwTK25Vi11SpkX7YGOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rESFWlwtcK7rvFv8Um9btQJZUwRB2RdO8MjvUB2BICQEPh/EbugiTsxumyL5292hX
	 SaghKnmizBA/pp7A+Dtlq+qwqNSRixbwdlsADGbs6CIn15dyBN0k28FwBbMS8aiTPI
	 Kp1INLM1FgGFhmvmSsgoX0Ju3Cx9yzirSxLHZ/7IJ7s8WGmxnG22tVNZm7926LBz6M
	 m49b2985aSBi87GawTioSdpHQvEIGdWaOc7nHUaGWvtz6CXRNKEfKQBtE6tGfFo5qO
	 sEpBR+MlOfCff/Ge6iR1CKDRfbGBh0FxjrF7lgu/xXIUY28Ntlxfpz6GDjZg2lyHDr
	 N+eN0jCwq4bcw==
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
Subject: [PATCH v3 9/9] riscv: mm: Add support for ZONE_DEVICE
Date: Tue, 21 May 2024 13:48:30 +0200
Message-Id: <20240521114830.841660-10-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240521114830.841660-1-bjorn@kernel.org>
References: <20240521114830.841660-1-bjorn@kernel.org>
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
 arch/riscv/include/asm/pgtable.h      | 17 +++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 2724dc2af29f..0b74698c63c7 100644
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
index 7933f493db71..02fadc276064 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -387,6 +387,13 @@ static inline int pte_special(pte_t pte)
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
@@ -428,6 +435,11 @@ static inline pte_t pte_mkspecial(pte_t pte)
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
@@ -711,6 +723,11 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
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


