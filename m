Return-Path: <linux-kernel+bounces-393060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8889B9B76
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFBB6B22695
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690A815099D;
	Sat,  2 Nov 2024 00:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ql5GPr9Y"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6098114831E
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 00:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730506137; cv=none; b=Yd9MOSxBG5hMcxAy9j02xJro+WPYbTwhAaBnfvUeXSyGf/E+ZmOwjEjLyMmVsdzyoqHC+yGbPSmbvXVWtEzo6ojwT65RPMmAomfpNQDPz0jkE0WiM0/HZBWGYvCIZzx64/mmiRewHqYGVQ+yuEyoN7D/9H3NtphQbXSEHBGwF50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730506137; c=relaxed/simple;
	bh=HN4QdcLDeu86WgLw+qX0w7mLtlrDOaDvQrf/IjdAGds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UU3+FLlw53DQTjJMP6fPt4djtJl0Y9syS5i0hhipVIccZGFiOFpC38G2AJ50UOaRzA0XT0Hnyu+4exYYGJQC2XzZyZVdZVw+5ohEjk/QabqTvdFH8apuG4NQnsJj/s4TgLQP/JNRmah/t7k/bFClYtF3Gu9lFA0Y0doxM6OF+pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Ql5GPr9Y; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2ad9825a7so1884095a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 17:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1730506135; x=1731110935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMt0e0PXpWjMqjxD9TZrMjT1DgeDdbgWuHWjw4p2qQ4=;
        b=Ql5GPr9Y3yumT8DBsRcFCweP8T8Vhr0JgSJwHHHrDTuvXkqSgpIZKy4VEQxLSzFxl9
         IP6P9+zxtCE8VgRMe64copbkFJAiOZrQsXrwyKOabAOqGsPQl5cRP2/VMKtq4gDeruPr
         1lX0LhYRsXAmK9/p7O73ZO6F8hujhZtCViOVNUDGWhcM3kjz6e65FmgnPm0we1aw7hwW
         WzZCiqV6sXIRwbfFnVKZ8Lw4XojwxxegTfmUY6pHvbF5O2ZrmqUjBSPgx7D0fu3mfMgs
         Xz6LmZk56WE6Xx/a/ivFORSNGBtz+arMKizNgrGN9g0SkcfXdP32m78+zW3jr8kMjEhm
         6NRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730506135; x=1731110935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMt0e0PXpWjMqjxD9TZrMjT1DgeDdbgWuHWjw4p2qQ4=;
        b=pOgNz+nFrYw3dfrHId2+6cZdCmeiT4yxz3+8hberqtwQsB+ngZtOGk4ThoTjYseHlm
         qNiV7tsF4Am/B5RpYwmwuNywDglmlID+hgH/wLo1Pri4jwTtlX7jHgTKde2tieO6wdjd
         NNoBRZZdRPc34Q9ogYCEAqTIQ7sxrrUyhAmy5tRTDBlnZPk824NlSqfiUOxtNJAS7Hnp
         897NBjYQLpZ7YWQ50cakIqpOGTfoDY15pCW7kn1giqr8xmqSTjmntgDKJjfxM4LL7d7f
         7bxEoreHHu/T/08UGSFhV5HeusvpIpRvZewqNEFVmgZUydwIThFr4aNUEndwgEXg9OqT
         e8Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXLm0UHJPB/mflUxUKIW8LcMtWPlFIRkuOJbEtJ2phjphY0a24ab4b0n71Pa73vYT4NZ4RcGAcCWSCzTZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhMmMak6mlBpZ44Vnx+zC5edRh5g0FxhaHoQg77C+2m3q0qQR3
	/sY7kXRLpGdOIv9Wigx4Er296xjAr1GNdxr5UQi7bbFnoUFLJk6QWv5Z2UYBTYE=
X-Google-Smtp-Source: AGHT+IGMDMDnYQja/VMsL8qyOr773n770HJzgkUAslo6h99AvoGePUEFx6d5XngignCVr6mFiZ4Fsw==
X-Received: by 2002:a17:90b:4b0d:b0:2e2:b219:40a2 with SMTP id 98e67ed59e1d1-2e8f11b8bdfmr27282773a91.28.1730506134638;
        Fri, 01 Nov 2024 17:08:54 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fc00856sm5505749a91.54.2024.11.01.17.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 17:08:54 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 06/11] riscv: mm: Fix up memory types when writing page tables
Date: Fri,  1 Nov 2024 17:08:00 -0700
Message-ID: <20241102000843.1301099-7-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241102000843.1301099-1-samuel.holland@sifive.com>
References: <20241102000843.1301099-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, Linux on RISC-V has three ways to specify the cacheability
and ordering PMAs of a page:
 1) Do nothing; assume the system is entirely cache-coherent and rely on
    the hardware for any ordering requirements
 2) Use the page table bits specified by Svpbmt
 3) Use the page table bits specified by XTheadMae

To support all three methods, the kernel dynamically determines the
definitions of the _PAGE_NOCACHE and _PAGE_IO fields. However, this
alone is not sufficient, as XTheadMae uses a nonzero memory type value
for normal memory pages. So the kernel has an additional alternative
sequence (ALT_THEAD_PMA) to insert the correct memory type when writing
page table entries.

Some RISC-V platforms use a fourth method to specify the cacheability of
a page of RAM: RAM is mapped to multiple physical address ranges, with
each alias having a different set of statically-determined PMAs.
Software selects the PMAs for a page by choosing a PFN from the
corresponding physical address range. This strategy also requires
applying a transformation when writing page table entries. Since these
physical memory aliases should be invisible to the rest of the kernel,
the opposite transformation must be applied when reading page table
entries.

However, with this last method of specifying PMAs, there is no inherent
way to indicate the cacheability of a page in the pgprot_t value, since
the PFN itself determines cacheability. One possible way is to reuse the
PTE bits from Svpbmt, as Svpbmt is the standard extension. This requires
the Svpbmt version of _PAGE_NOCACHE and _PAGE_IO to be available even
when the CPU does not support the extension.

It turns out that with some clever bit manipulation, it is just as
efficient to transform all three Svpbmt memory type values to the
corresponding XTheadMae values, as it is to check for and insert the
one XTheadMae memory type value for normal memory. This allows the
_PAGE_NOCACHE and _PAGE_IO definitions to be compile-time constants,
and it centralizes all memory type handling to one set of ALTERNATIVE
macros.

For a kernel with both Svpbmt and XTheadMae enabled, this change reduces
both kernel text size and the number of alternatives applied at boot.
However, there are a couple of small costs. For platforms using the
first method ("do nothing"), we must mask off the memory type bits when
writing page table entries, whereas previously no action was needed.
Second, when reading page table entries, the XTheadMae values must be
transformed back to the Svpbmt values. This "unfix" operation is also
needed for alias-based PMA selection, so both methods can use the same
ALTERNATIVE.

As a side effect, this change fixes the reporting of the NAPOT and
memory type bits from ptdump on platforms with XTheadMae.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/Kconfig.errata            |   1 +
 arch/riscv/include/asm/errata_list.h |  45 -----------
 arch/riscv/include/asm/pgtable-32.h  |   3 +
 arch/riscv/include/asm/pgtable-64.h  | 108 ++++++++++++++++++---------
 arch/riscv/include/asm/pgtable.h     |  18 +++--
 arch/riscv/mm/ptdump.c               |  13 ++--
 6 files changed, 93 insertions(+), 95 deletions(-)

diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
index 2acc7d876e1f..2806ed7916c7 100644
--- a/arch/riscv/Kconfig.errata
+++ b/arch/riscv/Kconfig.errata
@@ -86,6 +86,7 @@ config ERRATA_THEAD_MAE
 	bool "Apply T-Head's memory attribute extension (XTheadMae) errata"
 	depends on ERRATA_THEAD && 64BIT && MMU
 	select RISCV_ALTERNATIVE_EARLY
+	select RISCV_ISA_SVPBMT
 	default y
 	help
 	  This will apply the memory attribute extension errata to handle the
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 7c8a71a526a3..b127f4891083 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -58,51 +58,6 @@ asm(ALTERNATIVE("sfence.vma %0, %1", "sfence.vma", SIFIVE_VENDOR_ID,	\
 		ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)	\
 		: : "r" (addr), "r" (asid) : "memory")
 
-/*
- * _val is marked as "will be overwritten", so need to set it to 0
- * in the default case.
- */
-#define ALT_SVPBMT_SHIFT 61
-#define ALT_THEAD_MAE_SHIFT 59
-#define ALT_SVPBMT(_val, prot)						\
-asm(ALTERNATIVE_2("li %0, 0\t\nnop",					\
-		  "li %0, %1\t\nslli %0,%0,%3", 0,			\
-			RISCV_ISA_EXT_SVPBMT, CONFIG_RISCV_ISA_SVPBMT,	\
-		  "li %0, %2\t\nslli %0,%0,%4", THEAD_VENDOR_ID,	\
-			ERRATA_THEAD_MAE, CONFIG_ERRATA_THEAD_MAE)	\
-		: "=r"(_val)						\
-		: "I"(prot##_SVPBMT >> ALT_SVPBMT_SHIFT),		\
-		  "I"(prot##_THEAD >> ALT_THEAD_MAE_SHIFT),		\
-		  "I"(ALT_SVPBMT_SHIFT),				\
-		  "I"(ALT_THEAD_MAE_SHIFT))
-
-#ifdef CONFIG_ERRATA_THEAD_MAE
-/*
- * IO/NOCACHE memory types are handled together with svpbmt,
- * so on T-Head chips, check if no other memory type is set,
- * and set the non-0 PMA type if applicable.
- */
-#define ALT_THEAD_PMA(_val)						\
-asm volatile(ALTERNATIVE(						\
-	__nops(7),							\
-	"li      t3, %1\n\t"						\
-	"slli    t3, t3, %3\n\t"					\
-	"and     t3, %0, t3\n\t"					\
-	"bne     t3, zero, 2f\n\t"					\
-	"li      t3, %2\n\t"						\
-	"slli    t3, t3, %3\n\t"					\
-	"or      %0, %0, t3\n\t"					\
-	"2:",  THEAD_VENDOR_ID,						\
-		ERRATA_THEAD_MAE, CONFIG_ERRATA_THEAD_MAE)		\
-	: "+r"(_val)							\
-	: "I"(_PAGE_MTMASK_THEAD >> ALT_THEAD_MAE_SHIFT),		\
-	  "I"(_PAGE_PMA_THEAD >> ALT_THEAD_MAE_SHIFT),			\
-	  "I"(ALT_THEAD_MAE_SHIFT)					\
-	: "t3")
-#else
-#define ALT_THEAD_PMA(_val)
-#endif
-
 #define ALT_CMO_OP(_op, _start, _size, _cachesize)			\
 asm volatile(ALTERNATIVE(						\
 	__nops(5),							\
diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
index 7dc0751d67dc..b422a15fb464 100644
--- a/arch/riscv/include/asm/pgtable-32.h
+++ b/arch/riscv/include/asm/pgtable-32.h
@@ -28,6 +28,9 @@
 #define _PAGE_IO		0
 #define _PAGE_MTMASK		0
 
+#define ALT_FIXUP_MT(_val)
+#define ALT_UNFIX_MT(_val)
+
 #define pud_pfn(pud)				(pmd_pfn((pmd_t){ pud }))
 #define p4d_pfn(p4d)				(pud_pfn((pud_t){ p4d }))
 #define pgd_pfn(pgd)				(p4d_pfn((p4d_t){ pgd }))
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 4ba88592b8d1..4e8a32f035d7 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -8,7 +8,7 @@
 
 #include <linux/bits.h>
 #include <linux/const.h>
-#include <asm/errata_list.h>
+#include <asm/alternative-macros.h>
 
 extern bool pgtable_l4_enabled;
 extern bool pgtable_l5_enabled;
@@ -109,6 +109,8 @@ enum napot_cont_order {
 #define HUGE_MAX_HSTATE		2
 #endif
 
+#ifdef CONFIG_RISCV_ISA_SVPBMT
+
 /*
  * [62:61] Svpbmt Memory Type definitions:
  *
@@ -117,9 +119,9 @@ enum napot_cont_order {
  *  10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O memory
  *  11 - Rsvd   Reserved for future standard use
  */
-#define _PAGE_NOCACHE_SVPBMT	(1UL << 61)
-#define _PAGE_IO_SVPBMT		(1UL << 62)
-#define _PAGE_MTMASK_SVPBMT	(_PAGE_NOCACHE_SVPBMT | _PAGE_IO_SVPBMT)
+#define _PAGE_NOCACHE		(1UL << 61)
+#define _PAGE_IO		(2UL << 61)
+#define _PAGE_MTMASK		(3UL << 61)
 
 /*
  * [63:59] T-Head Memory Type definitions:
@@ -128,42 +130,66 @@ enum napot_cont_order {
  * bit[61] B - Bufferable
  * bit[60] SH - Shareable
  * bit[59] Sec - Trustable
- * 00110 - NC   Weakly-ordered, Non-cacheable, Bufferable, Shareable, Non-trustable
  * 01110 - PMA  Weakly-ordered, Cacheable, Bufferable, Shareable, Non-trustable
+ * 00110 - NC   Weakly-ordered, Non-cacheable, Bufferable, Shareable, Non-trustable
  * 10010 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Shareable, Non-trustable
+ *
+ * ALT_FIXUP_MT translates Svpbmt memory types to XTheadMae memory types.
+ * Pseudocode operating on bits [63:60]:
+ *   t0 = mt << 1
+ *   if (t0 == 0)
+ *     t0 |= 2
+ *   t0 ^= 0x5
+ *   mt ^= t0
+ *
+ * ALT_UNFIX_MT translates XTheadMae memory types to Svpbmt memory types.
+ * Pseudocode operating on bits [63:60]:
+ *   t0 = mt & 0xd
+ *   t0 ^= t0 >> 1
+ *   mt ^= t0
  */
-#define _PAGE_PMA_THEAD		((1UL << 62) | (1UL << 61) | (1UL << 60))
-#define _PAGE_NOCACHE_THEAD	((1UL << 61) | (1UL << 60))
-#define _PAGE_IO_THEAD		((1UL << 63) | (1UL << 60))
-#define _PAGE_MTMASK_THEAD	(_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (1UL << 59))
-
-static inline u64 riscv_page_mtmask(void)
-{
-	u64 val;
-
-	ALT_SVPBMT(val, _PAGE_MTMASK);
-	return val;
-}
 
-static inline u64 riscv_page_nocache(void)
-{
-	u64 val;
+#define ALT_FIXUP_MT(_val)								\
+	asm(ALTERNATIVE_2("addi	t0, zero, 0x3\n\t"					\
+			  "slli	t0, t0, 61\n\t"						\
+			  "not	t0, t0\n\t"						\
+			  "and	%0, %0, t0\n\t"						\
+			  "nop\n\t"							\
+			  "nop\n\t"							\
+			  "nop",							\
+			  __nops(7),							\
+			  0, RISCV_ISA_EXT_SVPBMT, CONFIG_RISCV_ISA_SVPBMT,		\
+			  "srli	t0, %0, 59\n\t"						\
+			  "seqz t1, t0\n\t"						\
+			  "slli	t1, t1, 1\n\t"						\
+			  "or	t0, t0, t1\n\t"						\
+			  "xori	t0, t0, 0x5\n\t"					\
+			  "slli	t0, t0, 60\n\t"						\
+			  "xor	%0, %0, t0",						\
+			  THEAD_VENDOR_ID, ERRATA_THEAD_MAE, CONFIG_ERRATA_THEAD_MAE)	\
+			  : "+r" (_val) :: "t0", "t1")
+
+#define ALT_UNFIX_MT(_val)								\
+	asm(ALTERNATIVE(__nops(6),							\
+			  "srli	t0, %0, 60\n\t"						\
+			  "andi	t0, t0, 0xd\n\t"					\
+			  "srli	t1, t0, 1\n\t"						\
+			  "xor	t0, t0, t1\n\t"						\
+			  "slli	t0, t0, 60\n\t"						\
+			  "xor	%0, %0, t0",						\
+			  THEAD_VENDOR_ID, ERRATA_THEAD_MAE, CONFIG_ERRATA_THEAD_MAE)	\
+			  : "+r" (_val) :: "t0", "t1")
 
-	ALT_SVPBMT(val, _PAGE_NOCACHE);
-	return val;
-}
+#else
 
-static inline u64 riscv_page_io(void)
-{
-	u64 val;
+#define _PAGE_NOCACHE		0
+#define _PAGE_IO		0
+#define _PAGE_MTMASK		0
 
-	ALT_SVPBMT(val, _PAGE_IO);
-	return val;
-}
+#define ALT_FIXUP_MT(_val)
+#define ALT_UNFIX_MT(_val)
 
-#define _PAGE_NOCACHE		riscv_page_nocache()
-#define _PAGE_IO		riscv_page_io()
-#define _PAGE_MTMASK		riscv_page_mtmask()
+#endif /* CONFIG_RISCV_ISA_SVPBMT */
 
 static inline int pud_present(pud_t pud)
 {
@@ -203,7 +229,11 @@ static inline void pud_clear(pud_t *pudp)
 
 static inline pud_t pfn_pud(unsigned long pfn, pgprot_t prot)
 {
-	return __pud((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
+	pud_t pud = __pud((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
+
+	ALT_FIXUP_MT(pud);
+
+	return pud;
 }
 
 #define pud_pfn pud_pfn
@@ -244,11 +274,11 @@ static inline bool mm_pud_folded(struct mm_struct *mm)
 
 static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
 {
-	unsigned long prot_val = pgprot_val(prot);
+	pmd_t pmd = __pmd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
 
-	ALT_THEAD_PMA(prot_val);
+	ALT_FIXUP_MT(pmd);
 
-	return __pmd((pfn << _PAGE_PFN_SHIFT) | prot_val);
+	return pmd;
 }
 
 #define mk_pmd(page, prot)    pfn_pmd(page_to_pfn(page), prot)
@@ -302,7 +332,11 @@ static inline void p4d_clear(p4d_t *p4d)
 
 static inline p4d_t pfn_p4d(unsigned long pfn, pgprot_t prot)
 {
-	return __p4d((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
+	p4d_t p4d = __p4d((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
+
+	ALT_FIXUP_MT(p4d);
+
+	return p4d;
 }
 
 static inline unsigned long p4d_pfn(p4d_t p4d)
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index afa0b455eaa4..3ffcff76ac0d 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -257,11 +257,11 @@ static inline void pmd_clear(pmd_t *pmdp)
 
 static inline pgd_t pfn_pgd(unsigned long pfn, pgprot_t prot)
 {
-	unsigned long prot_val = pgprot_val(prot);
+	pgd_t pgd = __pgd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
 
-	ALT_THEAD_PMA(prot_val);
+	ALT_FIXUP_MT(pgd);
 
-	return __pgd((pfn << _PAGE_PFN_SHIFT) | prot_val);
+	return pgd;
 }
 
 static inline unsigned long pmd_pfn(pmd_t pmd)
@@ -338,11 +338,11 @@ static inline unsigned long pte_pfn(pte_t pte)
 /* Constructs a page table entry */
 static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
 {
-	unsigned long prot_val = pgprot_val(prot);
+	pte_t pte = __pte((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
 
-	ALT_THEAD_PMA(prot_val);
+	ALT_FIXUP_MT(pte);
 
-	return __pte((pfn << _PAGE_PFN_SHIFT) | prot_val);
+	return pte;
 }
 
 #define mk_pte(page, prot)       pfn_pte(page_to_pfn(page), prot)
@@ -489,9 +489,11 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	unsigned long newprot_val = pgprot_val(newprot);
 
-	ALT_THEAD_PMA(newprot_val);
+	ALT_UNFIX_MT(pte);
+	pte = __pte((pte_val(pte) & _PAGE_CHG_MASK) | newprot_val);
+	ALT_FIXUP_MT(pte);
 
-	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | newprot_val);
+	return pte;
 }
 
 #define pgd_ERROR(e) \
diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index 58a7322e9a82..6528c2561437 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -142,7 +142,7 @@ static const struct prot_bits pte_bits[] = {
 	}, {
 #endif
 #ifdef CONFIG_RISCV_ISA_SVPBMT
-		.mask = _PAGE_MTMASK_SVPBMT,
+		.mask = _PAGE_MTMASK,
 		.set = "MT(%s)",
 		.clear = "  ..  ",
 	}, {
@@ -218,10 +218,10 @@ static void dump_prot(struct pg_state *st)
 			if (pte_bits[i].mask == _PAGE_SOFT)
 				sprintf(s, pte_bits[i].set, val >> 8);
 #ifdef CONFIG_RISCV_ISA_SVPBMT
-			else if (pte_bits[i].mask == _PAGE_MTMASK_SVPBMT) {
-				if (val == _PAGE_NOCACHE_SVPBMT)
+			else if (pte_bits[i].mask == _PAGE_MTMASK) {
+				if (val == _PAGE_NOCACHE)
 					sprintf(s, pte_bits[i].set, "NC");
-				else if (val == _PAGE_IO_SVPBMT)
+				else if (val == _PAGE_IO)
 					sprintf(s, pte_bits[i].set, "IO");
 				else
 					sprintf(s, pte_bits[i].set, "??");
@@ -282,9 +282,12 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr,
 		      int level, u64 val)
 {
 	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
-	u64 pa = PFN_PHYS(pte_pfn(__pte(val)));
 	u64 prot = 0;
+	u64 pa;
 
+	ALT_UNFIX_MT(val);
+
+	pa = PFN_PHYS(pte_pfn(__pte(val)));
 	if (level >= 0)
 		prot = val & pg_level[level].mask;
 
-- 
2.45.1


