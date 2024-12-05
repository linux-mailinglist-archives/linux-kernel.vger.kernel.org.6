Return-Path: <linux-kernel+bounces-433503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 545EE9E594C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AADE28827D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C275622256F;
	Thu,  5 Dec 2024 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PaTeOW09"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE24E221464
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411014; cv=none; b=ayigFuUZ9/3ZmOTreYvJ1A9/kBxmQQySw3FHOZ36oXCWm+RN0+Lsx/Zvn2q5kE+G8XKBnMuXsJ3OroZRKck1X8yfnzpyJvDG9DZzWSUw93XUIERrtQlLiesoi7BSPrNg1Fr9cZajPMJXuKwo2NUc2i6yFZs5bisaGoV4ubvguTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411014; c=relaxed/simple;
	bh=/efouv/fnY9jpclCTjbvs7bgImVVhlEa7Ddk6CNuL1k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DC5paxhZfI3Gp5u1qFspTFu6qI30mfbk4maU/SYqgMsDEofmBTrLFrSXCwA58uS3S24HKqTKcukx1urRC/r7Rj+ps3a5mRnpZiCCjwI+TwSU1rEKVolAou9BcnLB6hxK6T/upwMWiOu1F9zApQiAKyzxZzRvDHkfBFBAJYRGjf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PaTeOW09; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4349fd2965fso10175885e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733411010; x=1734015810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yclFVXNTRVuI3ORl238ziN2lD13I6D6/6bjC0IoKiuY=;
        b=PaTeOW093vZamfJO0DJaAZ+UIug9qsE9XNxb+IhcP0kiAd/4dnChTjdEjeG6ROSwCP
         AT22blfOQDnHRYZB65N5bvRh1dyp5E6cOn6OV+215KWHRej4IP5NHOiiNG/RFiJeOILe
         kZlqrlM0ElQJ9fvr8SOk7U1HMx/5rEJxhu5VBM/N9nnqcSgXkrgzXR/hBT+1xppiGuc8
         5DvyfXx0StDbo5fGtLliBwJ1MtXQuB1gAIwTa8i6EpxSoh/nmU7zaxfBP7bgrVBvmF9D
         RMDYe82QSrPyWF6nfZ78dcVP7JvOV2Ppd6AeHOhrDpA+ppyUoOGusOwDNTiGyOt3G/S9
         YnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733411010; x=1734015810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yclFVXNTRVuI3ORl238ziN2lD13I6D6/6bjC0IoKiuY=;
        b=DJjAYsonpyPLT/ywO/qWIJ+F0392GRsp8wf9Umu5szk1+tTt4Ff+c9zXllZlgzC5S+
         Ai0zf3AGzkLhBbUWh/Dv75TeeavrkFJSSAJga1uuwjaqZYCb0A2w4rArsJgVRydGD2gC
         QrV1dzDBBULBR31PIRg8FHFDkst6zLGFaUwTb2mozb8mSiTKZtb/QUeaNEXYgtZBGJ+5
         DEzL1VsWxhlFIoUABOvdWY2mk5s+rVJb/W1RQR2k94ppc6wORxmgtTuNvdI+Q4bDC3VO
         noYKT8gs19T+h0YajCyjZzIpHfT+qbkPEcx31rkhlf2OpTPKPJWvBMTJRL5nWOeAefch
         hTBg==
X-Gm-Message-State: AOJu0YxVUIXeHytM596SHRu7kem4fJSV+wEPQ7j2iXw/PrlaG3mW84wC
	Dr6oS9CzkcCMp6w5qy77OkTct9s86g8rTpbGJcGNIby69FrtSzvht9sz4LQES+3rS5xVdg==
X-Google-Smtp-Source: AGHT+IELvbd/O2SzZ3VWAEsTtUMSY7osqaiF93nf6dbOeGzMGVe84oA9bVeQxjEQScmqr6dd6O+shRpZ
X-Received: from wmbbg6.prod.google.com ([2002:a05:600c:3c86:b0:434:a045:c681])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:450e:b0:434:a30b:5445
 with SMTP id 5b1f17b1804b1-434d09d1cfemr102033595e9.19.1733411010060; Thu, 05
 Dec 2024 07:03:30 -0800 (PST)
Date: Thu,  5 Dec 2024 16:02:36 +0100
In-Reply-To: <20241205150229.3510177-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241205150229.3510177-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=11772; i=ardb@kernel.org;
 h=from:subject; bh=YzoW1gjf9Ier2qiu9vhpZuWDAp/MgsDQS+JjT1HAPQc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT3wQP89lwXtR1gVP3YpJy68///7Qt3pjGGtE7hvLBB6N
 69R8duvjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRVekM/8vSQ0yM247o2Dtv
 OHZxWmLX+UvCj71bmi7FtH4VDH734QEjw0GNwsddZxdHHv79YKWCZZ5X/J2M90uarB+7fus4FHa Ukx0A
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205150229.3510177-14-ardb+git@google.com>
Subject: [PATCH v2 6/6] arm64/mm: Drop configurable 48-bit physical address
 space limit
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <keescook@chromium.org>, 
	Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Currently, the maximum supported physical address space can be
configured as either 48 bits or 52 bits. The only remaining difference
between these in practice is that the former omits the masking and
shifting required to construct TTBR and PTE values, which carry bits #48
and higher disjoint from the rest of the physical address.

The overhead of performing these additional calculations is negligible,
and so there is little reason to retain support for two different
configurations, and we can simply support whatever the hardware
supports.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Kconfig                     | 31 +-------------------
 arch/arm64/include/asm/assembler.h     | 13 ++------
 arch/arm64/include/asm/cpufeature.h    |  3 +-
 arch/arm64/include/asm/kvm_pgtable.h   |  3 +-
 arch/arm64/include/asm/pgtable-hwdef.h |  6 +---
 arch/arm64/include/asm/pgtable-prot.h  |  4 +--
 arch/arm64/include/asm/pgtable.h       | 11 +------
 arch/arm64/include/asm/sysreg.h        |  6 ----
 arch/arm64/mm/pgd.c                    |  9 +++---
 arch/arm64/mm/proc.S                   |  2 --
 scripts/gdb/linux/constants.py.in      |  1 -
 tools/arch/arm64/include/asm/sysreg.h  |  6 ----
 12 files changed, 14 insertions(+), 81 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c1ca21adddc1..7ebd0ba32a32 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1416,38 +1416,9 @@ config ARM64_VA_BITS
 	default 48 if ARM64_VA_BITS_48
 	default 52 if ARM64_VA_BITS_52
 
-choice
-	prompt "Physical address space size"
-	default ARM64_PA_BITS_48
-	help
-	  Choose the maximum physical address range that the kernel will
-	  support.
-
-config ARM64_PA_BITS_48
-	bool "48-bit"
-	depends on ARM64_64K_PAGES || !ARM64_VA_BITS_52
-
-config ARM64_PA_BITS_52
-	bool "52-bit"
-	depends on ARM64_64K_PAGES || ARM64_VA_BITS_52
-	help
-	  Enable support for a 52-bit physical address space, introduced as
-	  part of the ARMv8.2-LPA extension.
-
-	  With this enabled, the kernel will also continue to work on CPUs that
-	  do not support ARMv8.2-LPA, but with some added memory overhead (and
-	  minor performance overhead).
-
-endchoice
-
-config ARM64_PA_BITS
-	int
-	default 48 if ARM64_PA_BITS_48
-	default 52 if ARM64_PA_BITS_52
-
 config ARM64_LPA2
 	def_bool y
-	depends on ARM64_PA_BITS_52 && !ARM64_64K_PAGES
+	depends on !ARM64_64K_PAGES
 
 choice
 	prompt "Endianness"
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index ad63457a05c5..01a1e3c16283 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -342,14 +342,13 @@ alternative_cb_end
 	mrs	\tmp0, ID_AA64MMFR0_EL1
 	// Narrow PARange to fit the PS field in TCR_ELx
 	ubfx	\tmp0, \tmp0, #ID_AA64MMFR0_EL1_PARANGE_SHIFT, #3
-	mov	\tmp1, #ID_AA64MMFR0_EL1_PARANGE_MAX
 #ifdef CONFIG_ARM64_LPA2
 alternative_if_not ARM64_HAS_VA52
 	mov	\tmp1, #ID_AA64MMFR0_EL1_PARANGE_48
-alternative_else_nop_endif
-#endif
 	cmp	\tmp0, \tmp1
 	csel	\tmp0, \tmp1, \tmp0, hi
+alternative_else_nop_endif
+#endif
 	bfi	\tcr, \tmp0, \pos, #3
 	.endm
 
@@ -599,21 +598,13 @@ alternative_endif
  * 	ttbr:	returns the TTBR value
  */
 	.macro	phys_to_ttbr, ttbr, phys
-#ifdef CONFIG_ARM64_PA_BITS_52
 	orr	\ttbr, \phys, \phys, lsr #46
 	and	\ttbr, \ttbr, #TTBR_BADDR_MASK_52
-#else
-	mov	\ttbr, \phys
-#endif
 	.endm
 
 	.macro	phys_to_pte, pte, phys
-#ifdef CONFIG_ARM64_PA_BITS_52
 	orr	\pte, \phys, \phys, lsr #PTE_ADDR_HIGH_SHIFT
 	and	\pte, \pte, #PHYS_TO_PTE_ADDR_MASK
-#else
-	mov	\pte, \phys
-#endif
 	.endm
 
 /*
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index b64e49bd9d10..ed327358e734 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -885,9 +885,8 @@ static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
 	 * However, by the "D10.1.4 Principles of the ID scheme
 	 * for fields in ID registers", ARM DDI 0487C.a, any new
 	 * value is guaranteed to be higher than what we know already.
-	 * As a safe limit, we return the limit supported by the kernel.
 	 */
-	default: return CONFIG_ARM64_PA_BITS;
+	default: return 52;
 	}
 }
 
diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index aab04097b505..525aef178cb4 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -30,8 +30,7 @@
 
 static inline u64 kvm_get_parange_max(void)
 {
-	if (kvm_lpa2_is_enabled() ||
-	   (IS_ENABLED(CONFIG_ARM64_PA_BITS_52) && PAGE_SHIFT == 16))
+	if (kvm_lpa2_is_enabled() || PAGE_SHIFT == 16)
 		return ID_AA64MMFR0_EL1_PARANGE_52;
 	else
 		return ID_AA64MMFR0_EL1_PARANGE_48;
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index a9136cc551cc..9b34180042b2 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -176,7 +176,6 @@
 #define PTE_SWBITS_MASK		_AT(pteval_t, (BIT(63) | GENMASK(58, 55)))
 
 #define PTE_ADDR_LOW		(((_AT(pteval_t, 1) << (50 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
-#ifdef CONFIG_ARM64_PA_BITS_52
 #ifdef CONFIG_ARM64_64K_PAGES
 #define PTE_ADDR_HIGH		(_AT(pteval_t, 0xf) << 12)
 #define PTE_ADDR_HIGH_SHIFT	36
@@ -186,7 +185,6 @@
 #define PTE_ADDR_HIGH_SHIFT	42
 #define PHYS_TO_PTE_ADDR_MASK	GENMASK_ULL(49, 8)
 #endif
-#endif
 
 /*
  * AttrIndx[2:0] encoding (mapping attributes defined in the MAIR* registers).
@@ -327,12 +325,10 @@
 /*
  * TTBR.
  */
-#ifdef CONFIG_ARM64_PA_BITS_52
 /*
- * TTBR_ELx[1] is RES0 in this configuration.
+ * TTBR_ELx[1] is RES0 when using 52-bit physical addressing
  */
 #define TTBR_BADDR_MASK_52	GENMASK_ULL(47, 2)
-#endif
 
 #ifdef CONFIG_ARM64_VA_BITS_52
 /* Must be at least 64-byte aligned to prevent corruption of the TTBR */
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index a95f1f77bb39..b73acf25341f 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -81,7 +81,7 @@ extern unsigned long prot_ns_shared;
 #define lpa2_is_enabled()	false
 #define PTE_MAYBE_SHARED	PTE_SHARED
 #define PMD_MAYBE_SHARED	PMD_SECT_S
-#define PHYS_MASK_SHIFT		(CONFIG_ARM64_PA_BITS)
+#define PHYS_MASK_SHIFT		(52)
 #else
 static inline bool __pure lpa2_is_enabled(void)
 {
@@ -90,7 +90,7 @@ static inline bool __pure lpa2_is_enabled(void)
 
 #define PTE_MAYBE_SHARED	(lpa2_is_enabled() ? 0 : PTE_SHARED)
 #define PMD_MAYBE_SHARED	(lpa2_is_enabled() ? 0 : PMD_SECT_S)
-#define PHYS_MASK_SHIFT		(lpa2_is_enabled() ? CONFIG_ARM64_PA_BITS : 48)
+#define PHYS_MASK_SHIFT		(lpa2_is_enabled() ? 52 : 48)
 #endif
 
 /*
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 6986345b537a..ec8124d66b9c 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -69,10 +69,9 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 	pr_err("%s:%d: bad pte %016llx.\n", __FILE__, __LINE__, pte_val(e))
 
 /*
- * Macros to convert between a physical address and its placement in a
+ * Helpers to convert between a physical address and its placement in a
  * page table entry, taking care of 52-bit addresses.
  */
-#ifdef CONFIG_ARM64_PA_BITS_52
 static inline phys_addr_t __pte_to_phys(pte_t pte)
 {
 	pte_val(pte) &= ~PTE_MAYBE_SHARED;
@@ -83,10 +82,6 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 {
 	return (phys | (phys >> PTE_ADDR_HIGH_SHIFT)) & PHYS_TO_PTE_ADDR_MASK;
 }
-#else
-#define __pte_to_phys(pte)	(pte_val(pte) & PTE_ADDR_LOW)
-#define __phys_to_pte_val(phys)	(phys)
-#endif
 
 #define pte_pfn(pte)		(__pte_to_phys(pte) >> PAGE_SHIFT)
 #define pfn_pte(pfn,prot)	\
@@ -1495,11 +1490,7 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 	update_mmu_cache_range(NULL, vma, addr, ptep, 1)
 #define update_mmu_cache_pmd(vma, address, pmd) do { } while (0)
 
-#ifdef CONFIG_ARM64_PA_BITS_52
 #define phys_to_ttbr(addr)	(((addr) | ((addr) >> 46)) & TTBR_BADDR_MASK_52)
-#else
-#define phys_to_ttbr(addr)	(addr)
-#endif
 
 /*
  * On arm64 without hardware Access Flag, copying from user will fail because
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index b8303a83c0bf..f902893ec903 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -916,12 +916,6 @@
 #define ID_AA64MMFR0_EL1_TGRAN_2_SUPPORTED_LPA2		0x3
 #define ID_AA64MMFR0_EL1_TGRAN_2_SUPPORTED_MAX		0x7
 
-#ifdef CONFIG_ARM64_PA_BITS_52
-#define ID_AA64MMFR0_EL1_PARANGE_MAX	ID_AA64MMFR0_EL1_PARANGE_52
-#else
-#define ID_AA64MMFR0_EL1_PARANGE_MAX	ID_AA64MMFR0_EL1_PARANGE_48
-#endif
-
 #if defined(CONFIG_ARM64_4K_PAGES)
 #define ID_AA64MMFR0_EL1_TGRAN_SHIFT		ID_AA64MMFR0_EL1_TGRAN4_SHIFT
 #define ID_AA64MMFR0_EL1_TGRAN_LPA2		ID_AA64MMFR0_EL1_TGRAN4_52_BIT
diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
index 0c501cabc238..8722ab6d4b1c 100644
--- a/arch/arm64/mm/pgd.c
+++ b/arch/arm64/mm/pgd.c
@@ -48,20 +48,21 @@ void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 
 void __init pgtable_cache_init(void)
 {
+	unsigned int pgd_size = PGD_SIZE;
+
 	if (pgdir_is_page_size())
 		return;
 
-#ifdef CONFIG_ARM64_PA_BITS_52
 	/*
 	 * With 52-bit physical addresses, the architecture requires the
 	 * top-level table to be aligned to at least 64 bytes.
 	 */
-	BUILD_BUG_ON(PGD_SIZE < 64);
-#endif
+	if (PHYS_MASK_SHIFT >= 52)
+		pgd_size = max(pgd_size, 64);
 
 	/*
 	 * Naturally aligned pgds required by the architecture.
 	 */
-	pgd_cache = kmem_cache_create("pgd_cache", PGD_SIZE, PGD_SIZE,
+	pgd_cache = kmem_cache_create("pgd_cache", pgd_size, pgd_size,
 				      SLAB_PANIC, NULL);
 }
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index b8edc5765441..51ed0e9d0a0d 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -197,10 +197,8 @@ SYM_FUNC_ALIAS(__pi_idmap_cpu_replace_ttbr1, idmap_cpu_replace_ttbr1)
 
 	.macro	pte_to_phys, phys, pte
 	and	\phys, \pte, #PTE_ADDR_LOW
-#ifdef CONFIG_ARM64_PA_BITS_52
 	and	\pte, \pte, #PTE_ADDR_HIGH
 	orr	\phys, \phys, \pte, lsl #PTE_ADDR_HIGH_SHIFT
-#endif
 	.endm
 
 	.macro	kpti_mk_tbl_ng, type, num_entries
diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index fd6bd69c5096..05034c0b8fd7 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -141,7 +141,6 @@ LX_CONFIG(CONFIG_ARM64_4K_PAGES)
 LX_CONFIG(CONFIG_ARM64_16K_PAGES)
 LX_CONFIG(CONFIG_ARM64_64K_PAGES)
 if IS_BUILTIN(CONFIG_ARM64):
-    LX_VALUE(CONFIG_ARM64_PA_BITS)
     LX_VALUE(CONFIG_ARM64_VA_BITS)
     LX_VALUE(CONFIG_PAGE_SHIFT)
     LX_VALUE(CONFIG_ARCH_FORCE_MAX_ORDER)
diff --git a/tools/arch/arm64/include/asm/sysreg.h b/tools/arch/arm64/include/asm/sysreg.h
index cd8420e8c3ad..daeecb1a5366 100644
--- a/tools/arch/arm64/include/asm/sysreg.h
+++ b/tools/arch/arm64/include/asm/sysreg.h
@@ -574,12 +574,6 @@
 #define ID_AA64MMFR0_EL1_TGRAN_2_SUPPORTED_MIN		0x2
 #define ID_AA64MMFR0_EL1_TGRAN_2_SUPPORTED_MAX		0x7
 
-#ifdef CONFIG_ARM64_PA_BITS_52
-#define ID_AA64MMFR0_EL1_PARANGE_MAX	ID_AA64MMFR0_EL1_PARANGE_52
-#else
-#define ID_AA64MMFR0_EL1_PARANGE_MAX	ID_AA64MMFR0_EL1_PARANGE_48
-#endif
-
 #if defined(CONFIG_ARM64_4K_PAGES)
 #define ID_AA64MMFR0_EL1_TGRAN_SHIFT		ID_AA64MMFR0_EL1_TGRAN4_SHIFT
 #define ID_AA64MMFR0_EL1_TGRAN_SUPPORTED_MIN	ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MIN
-- 
2.47.0.338.g60cca15819-goog


