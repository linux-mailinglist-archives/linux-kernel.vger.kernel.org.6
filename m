Return-Path: <linux-kernel+bounces-363888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C0699C829
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473911F25E39
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F03119E7E3;
	Mon, 14 Oct 2024 11:01:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C531CF7DF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903699; cv=none; b=eKgG2rMxA4GhsCEE9bEsBwi/r9Ysj2RIPxy4lnBMJAjBsGORLDMsiHTy7CuegXKnfF7+87hAsYJ5BXqOeXpSS4ziLLSzE3V2JSRab1JWkixlS4R0xnnJoTzpuOk4rc2bivD+UlDxn9jPI0Po6kQy72w6ZT4KfSSXXBStFPjfTfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903699; c=relaxed/simple;
	bh=AsTWefbKiSXkDg07/DrGZu4A5R3XubbQ3R+O66zJIKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3LP/ySNbs/DlXjOyLN+JoqFW6aWtemZEkQ15Xa8N26Hmxx/8993KrD52E8OyGpvuUnZdwJJK9mGwObE1VZ4Rw8u15TegEu002arX4ouXbDWdkIYW9EDjCNx6aqFafdtYuBEDb3C/1I2kQNEruS4cgzQ0thkFOTRVGmGbXqk7Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7674D175A;
	Mon, 14 Oct 2024 04:02:06 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 760F73F51B;
	Mon, 14 Oct 2024 04:01:34 -0700 (PDT)
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
Subject: [RFC PATCH v1 42/57] arm64: Divorce early init from PAGE_SIZE
Date: Mon, 14 Oct 2024 11:58:49 +0100
Message-ID: <20241014105912.3207374-42-ryan.roberts@arm.com>
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

Refactor all the early code between entrypoint and start_kernel() so
that it does not rely on compile-time configuration of page size. For
now, that code chooses to use the compile-time page size as its
boot-time selected page size, but this will change in the near future to
allow the page size to be specified on the command line.

An initial page size is selected by probe_init_idmap_page_shift(), which
is used for the init_idmap_pg_dir. This selects the largest page size
that the HW supports and which is also in the range of page sizes
allowed by the compile-time config. For now, the allowed range only
covers the compile-time selected page size, but in future boot-time page
size builds, the range will be expanded.

Once the mmu is enabled, we access the command line in the device tree
as before, which allows us to determine the page size requested by the
user, filtered by the same allowed compile-time range of page sizes -
still just the compile-time selected page size for now. If no acceptable
page size was specified on the command line, we fall back to the page
size selected in probe_init_idmap_page_shift(). We then do a dance to
repaint init_idmap_pg_dir for the final page size and for LPA2, if in
use. Finally with that installed, we can continue booting the kernel.

For all of this to work, we must replace previous compile-time decisions
with run-time decisions. For the most part, we can do this by looking at
tcr_el1.tg0 to determine the installed page size. These run-time
decisions are not in hot code paths so I don't anticipate any
performance regressions as a result and therefore I prefer the
simplicity of using the run-time approach even for builds that specify a
compile-time page size.

Of course to be able to actually change the early page size, the static
storage for the page tables need to be sized for the maximum
requirement. Currently they are still sized for the compile-time page
size.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 arch/arm64/include/asm/assembler.h    |  50 +++++++-
 arch/arm64/include/asm/cpufeature.h   |  33 +++--
 arch/arm64/include/asm/pgtable-prot.h |   2 +-
 arch/arm64/kernel/head.S              |  40 ++++--
 arch/arm64/kernel/pi/idreg-override.c |  32 +++--
 arch/arm64/kernel/pi/map_kernel.c     |  87 +++++++++----
 arch/arm64/kernel/pi/map_range.c      | 171 ++++++++++++++++++++++----
 arch/arm64/kernel/pi/pi.h             |  61 ++++++++-
 arch/arm64/mm/proc.S                  |  21 ++--
 9 files changed, 405 insertions(+), 92 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index bc0b0d75acef7..77c2d707adb1a 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -568,6 +568,14 @@ alternative_endif
 	mrs	\rd, sp_el0
 	.endm
 
+/*
+ * Retrieve and return tcr_el1.tg0 in \tg0.
+ */
+	.macro	get_tg0, tg0
+	mrs	\tg0, tcr_el1
+	and	\tg0, \tg0, #TCR_TG0_MASK
+	.endm
+
 /*
  * If the kernel is built for 52-bit virtual addressing but the hardware only
  * supports 48 bits, we cannot program the pgdir address into TTBR1 directly,
@@ -584,12 +592,16 @@ alternative_endif
  * 	ttbr: Value of ttbr to set, modified.
  */
 	.macro	offset_ttbr1, ttbr, tmp
-#if defined(CONFIG_ARM64_VA_BITS_52) && !defined(CONFIG_ARM64_LPA2)
+#if defined(CONFIG_ARM64_VA_BITS_52)
+	get_tg0	\tmp
+	cmp	\tmp, #TCR_TG0_64K
+	b.ne	.Ldone\@
 	mrs	\tmp, tcr_el1
 	and	\tmp, \tmp, #TCR_T1SZ_MASK
 	cmp	\tmp, #TCR_T1SZ(VA_BITS_MIN)
 	orr	\tmp, \ttbr, #TTBR1_BADDR_4852_OFFSET
 	csel	\ttbr, \tmp, \ttbr, eq
+.Ldone\@:
 #endif
 	.endm
 
@@ -863,4 +875,40 @@ alternative_cb ARM64_ALWAYS_SYSTEM, spectre_bhb_patch_clearbhb
 alternative_cb_end
 #endif /* CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY */
 	.endm
+
+/*
+ * Given \tg0, populates \val with one of the 3 passed in values, corresponding
+ * to the page size advertised by \tg0.
+ */
+	.macro	value_for_page_size, val, tg0, val4k, val16k, val64k
+.Lsz_64k\@:
+	cmp	\tg0, #TCR_TG0_64K
+	b.ne	.Lsz_16k\@
+	mov	\val, #\val64k
+	b	.Ldone\@
+.Lsz_16k\@:
+	cmp	\tg0, #TCR_TG0_16K
+	b.ne	.Lsz_4k\@
+	mov	\val, #\val16k
+	b	.Ldone\@
+.Lsz_4k\@:
+	mov	\val, #\val4k
+.Ldone\@:
+	.endm
+
+	.macro	tgran_shift, val, tg0
+	value_for_page_size \val, \tg0, ID_AA64MMFR0_EL1_TGRAN4_SHIFT, ID_AA64MMFR0_EL1_TGRAN16_SHIFT, ID_AA64MMFR0_EL1_TGRAN64_SHIFT
+	.endm
+
+	.macro	tgran_min, val, tg0
+	value_for_page_size \val, \tg0, ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MIN, ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MIN, ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MIN
+	.endm
+
+	.macro	tgran_max, val, tg0
+	value_for_page_size \val, \tg0, ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MAX, ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MAX, ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MAX
+	.endm
+
+	.macro	tgran_lpa2, val, tg0
+	value_for_page_size \val, \tg0, ID_AA64MMFR0_EL1_TGRAN4_52_BIT, ID_AA64MMFR0_EL1_TGRAN16_52_BIT, -1
+	.endm
 #endif	/* __ASM_ASSEMBLER_H */
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 4edbb586810d7..2c22cfdc04bc7 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -26,6 +26,7 @@
 #include <linux/jump_label.h>
 #include <linux/kernel.h>
 #include <linux/cpumask.h>
+#include <linux/sizes.h>
 
 /*
  * CPU feature register tracking
@@ -1014,10 +1015,13 @@ static inline bool cpu_has_pac(void)
 					    &id_aa64isar2_override);
 }
 
-static inline bool cpu_has_lva(void)
+static inline bool cpu_has_lva(u64 page_size)
 {
 	u64 mmfr2;
 
+	if (page_size != SZ_64K)
+		return false;
+
 	mmfr2 = read_sysreg_s(SYS_ID_AA64MMFR2_EL1);
 	mmfr2 &= ~id_aa64mmfr2_override.mask;
 	mmfr2 |= id_aa64mmfr2_override.val;
@@ -1025,22 +1029,31 @@ static inline bool cpu_has_lva(void)
 						    ID_AA64MMFR2_EL1_VARange_SHIFT);
 }
 
-static inline bool cpu_has_lpa2(void)
+static inline bool cpu_has_lpa2(u64 page_size)
 {
-#ifdef CONFIG_ARM64_LPA2
 	u64 mmfr0;
 	int feat;
+	int shift;
+	int minval;
+
+	switch (page_size) {
+	case SZ_4K:
+		shift = ID_AA64MMFR0_EL1_TGRAN4_SHIFT;
+		minval = ID_AA64MMFR0_EL1_TGRAN4_52_BIT;
+		break;
+	case SZ_16K:
+		shift = ID_AA64MMFR0_EL1_TGRAN16_SHIFT;
+		minval = ID_AA64MMFR0_EL1_TGRAN16_52_BIT;
+		break;
+	default:
+		return false;
+	}
 
 	mmfr0 = read_sysreg(id_aa64mmfr0_el1);
 	mmfr0 &= ~id_aa64mmfr0_override.mask;
 	mmfr0 |= id_aa64mmfr0_override.val;
-	feat = cpuid_feature_extract_signed_field(mmfr0,
-						  ID_AA64MMFR0_EL1_TGRAN_SHIFT);
-
-	return feat >= ID_AA64MMFR0_EL1_TGRAN_LPA2;
-#else
-	return false;
-#endif
+	feat = cpuid_feature_extract_signed_field(mmfr0, shift);
+	return feat >= minval;
 }
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index b11cfb9fdd379..f8ebf424ca016 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -74,7 +74,7 @@ extern bool arm64_use_ng_mappings;
 #define PTE_MAYBE_NG		(arm64_use_ng_mappings ? PTE_NG : 0)
 #define PMD_MAYBE_NG		(arm64_use_ng_mappings ? PMD_SECT_NG : 0)
 
-#ifndef CONFIG_ARM64_LPA2
+#ifndef CONFIG_ARM64_VA_BITS_52
 #define lpa2_is_enabled()	false
 #define PTE_MAYBE_SHARED	PTE_SHARED
 #define PMD_MAYBE_SHARED	PMD_SECT_S
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 7e17a71fd9e4b..761b7f5633e15 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -88,6 +88,8 @@ SYM_CODE_START(primary_entry)
 	adrp	x1, early_init_stack
 	mov	sp, x1
 	mov	x29, xzr
+	bl	__pi_probe_init_idmap_page_shift
+	mov	x3, x0
 	adrp	x0, init_idmap_pg_dir
 	adrp	x1, init_idmap_pg_end
 	mov	x2, xzr
@@ -471,11 +473,16 @@ SYM_FUNC_END(set_cpu_boot_mode_flag)
  */
 	.section ".idmap.text","a"
 SYM_FUNC_START(__enable_mmu)
+	get_tg0 x3
+	tgran_shift x4, x3
+	tgran_min x5, x3
+	tgran_max x6, x3
 	mrs	x3, ID_AA64MMFR0_EL1
-	ubfx	x3, x3, #ID_AA64MMFR0_EL1_TGRAN_SHIFT, 4
-	cmp     x3, #ID_AA64MMFR0_EL1_TGRAN_SUPPORTED_MIN
+	lsr	x3, x3, x4
+	ubfx	x3, x3, #0, 4
+	cmp     x3, x5
 	b.lt    __no_granule_support
-	cmp     x3, #ID_AA64MMFR0_EL1_TGRAN_SUPPORTED_MAX
+	cmp     x3, x6
 	b.gt    __no_granule_support
 	phys_to_ttbr x2, x2
 	msr	ttbr0_el1, x2			// load TTBR0
@@ -488,17 +495,32 @@ SYM_FUNC_END(__enable_mmu)
 
 #ifdef CONFIG_ARM64_VA_BITS_52
 SYM_FUNC_START(__cpu_secondary_check52bitva)
-#ifndef CONFIG_ARM64_LPA2
+	/*
+	 * tcr_el1 is not yet loaded (there is a chicken-and-egg problem) so we
+	 * can't figure out LPA2 vs LVA from that. But this is only called for
+	 * secondary cpus so tcr_boot_fields has already been populated by the
+	 * primary cpu. So grab that and rely on the DS bit to tell us if we are
+	 * LPA2 or LVA.
+	 */
+	adr_l	x1, __pi_tcr_boot_fields
+	ldr	x0, [x1]
+	and	x1, x0, #TCR_DS
+	cbnz	x1, .Llpa2
+.Llva:
 	mrs_s	x0, SYS_ID_AA64MMFR2_EL1
 	and	x0, x0, ID_AA64MMFR2_EL1_VARange_MASK
 	cbnz	x0, 2f
-#else
+	b	.Lfail
+.Llpa2:
+	and	x0, x0, #TCR_TG0_MASK
+	tgran_shift x1, x0
+	tgran_lpa2 x2, x0
 	mrs	x0, id_aa64mmfr0_el1
-	sbfx	x0, x0, #ID_AA64MMFR0_EL1_TGRAN_SHIFT, 4
-	cmp	x0, #ID_AA64MMFR0_EL1_TGRAN_LPA2
+	lsr	x0, x0, x1
+	sbfx	x0, x0, #0, 4
+	cmp	x0, x2
 	b.ge	2f
-#endif
-
+.Lfail:
 	update_early_cpu_boot_status \
 		CPU_STUCK_IN_KERNEL | CPU_STUCK_REASON_52_BIT_VA, x0, x1
 1:	wfe
diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
index 5a38bdb231bc8..0685c0a3255e2 100644
--- a/arch/arm64/kernel/pi/idreg-override.c
+++ b/arch/arm64/kernel/pi/idreg-override.c
@@ -62,20 +62,34 @@ static const struct ftr_set_desc mmfr1 __prel64_initconst = {
 
 static bool __init mmfr2_varange_filter(u64 val)
 {
-	int __maybe_unused feat;
+	u64 mmfr0;
+	int feat;
+	int shift;
+	int minval;
 
 	if (val)
 		return false;
 
-#ifdef CONFIG_ARM64_LPA2
-	feat = cpuid_feature_extract_signed_field(read_sysreg(id_aa64mmfr0_el1),
-						  ID_AA64MMFR0_EL1_TGRAN_SHIFT);
-	if (feat >= ID_AA64MMFR0_EL1_TGRAN_LPA2) {
-		id_aa64mmfr0_override.val |=
-			(ID_AA64MMFR0_EL1_TGRAN_LPA2 - 1) << ID_AA64MMFR0_EL1_TGRAN_SHIFT;
-		id_aa64mmfr0_override.mask |= 0xfU << ID_AA64MMFR0_EL1_TGRAN_SHIFT;
+	mmfr0 = read_sysreg(id_aa64mmfr0_el1);
+
+	/* Remove LPA2 support for 4K granule. */
+	shift = ID_AA64MMFR0_EL1_TGRAN4_SHIFT;
+	minval = ID_AA64MMFR0_EL1_TGRAN4_52_BIT;
+	feat = cpuid_feature_extract_signed_field(mmfr0, shift);
+	if (feat >= minval) {
+		id_aa64mmfr0_override.val |= (minval - 1) << shift;
+		id_aa64mmfr0_override.mask |= 0xfU << shift;
+	}
+
+	/* Remove LPA2 support for 16K granule. */
+	shift = ID_AA64MMFR0_EL1_TGRAN16_SHIFT;
+	minval = ID_AA64MMFR0_EL1_TGRAN16_52_BIT;
+	feat = cpuid_feature_extract_signed_field(mmfr0, shift);
+	if (feat >= minval) {
+		id_aa64mmfr0_override.val |= (minval - 1) << shift;
+		id_aa64mmfr0_override.mask |= 0xfU << shift;
 	}
-#endif
+
 	return true;
 }
 
diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
index a53fc225d2d0d..7a62d4238449d 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -133,10 +133,18 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_offset, int root_level)
 	idmap_cpu_replace_ttbr1(swapper_pg_dir);
 }
 
-static void noinline __section(".idmap.text") set_ttbr0_for_lpa2(u64 ttbr)
+static void noinline __section(".idmap.text") set_ttbr0(u64 ttbr, bool use_lpa2,
+							int page_shift)
 {
 	u64 sctlr = read_sysreg(sctlr_el1);
-	u64 tcr = read_sysreg(tcr_el1) | TCR_DS;
+	u64 tcr = read_sysreg(tcr_el1);
+	u64 boot_fields = early_page_shift_to_tcr_tgx(page_shift);
+
+	if (use_lpa2)
+		boot_fields |= TCR_DS;
+
+	tcr &= ~(TCR_TG0_MASK | TCR_TG1_MASK | TCR_DS);
+	tcr |= boot_fields;
 
 	asm("	msr	sctlr_el1, %0		;"
 	    "	isb				;"
@@ -149,57 +157,66 @@ static void noinline __section(".idmap.text") set_ttbr0_for_lpa2(u64 ttbr)
 	    "	msr     sctlr_el1, %3		;"
 	    "	isb				;"
 	    ::	"r"(sctlr & ~SCTLR_ELx_M), "r"(ttbr), "r"(tcr), "r"(sctlr));
+
+	/* Stash this for __cpu_setup to configure secondary cpus' tcr_el1. */
+	set_tcr_boot_fields(boot_fields);
 }
 
-static void __init remap_idmap_for_lpa2(void)
+static void __init remap_idmap(bool use_lpa2, int page_shift)
 {
 	/* clear the bits that change meaning once LPA2 is turned on */
-	pteval_t mask = PTE_SHARED;
+	pteval_t mask = use_lpa2 ? PTE_SHARED : 0;
 
 	/*
-	 * We have to clear bits [9:8] in all block or page descriptors in the
-	 * initial ID map, as otherwise they will be (mis)interpreted as
+	 * For LPA2, We have to clear bits [9:8] in all block or page descriptors
+	 * in the initial ID map, as otherwise they will be (mis)interpreted as
 	 * physical address bits once we flick the LPA2 switch (TCR.DS). Since
 	 * we cannot manipulate live descriptors in that way without creating
 	 * potential TLB conflicts, let's create another temporary ID map in a
 	 * LPA2 compatible fashion, and update the initial ID map while running
 	 * from that.
 	 */
-	create_init_idmap(init_pg_dir, init_pg_end, mask);
+	create_init_idmap(init_pg_dir, init_pg_end, mask, page_shift);
 	dsb(ishst);
-	set_ttbr0_for_lpa2((u64)init_pg_dir);
+	set_ttbr0((u64)init_pg_dir, use_lpa2, page_shift);
 
 	/*
-	 * Recreate the initial ID map with the same granularity as before.
-	 * Don't bother with the FDT, we no longer need it after this.
+	 * Recreate the initial ID map with new page size and, if LPA2 is in
+	 * use, bits [9:8] cleared.
 	 */
 	memset(init_idmap_pg_dir, 0,
 	       (u64)init_idmap_pg_end - (u64)init_idmap_pg_dir);
 
-	create_init_idmap(init_idmap_pg_dir, init_idmap_pg_end, mask);
+	create_init_idmap(init_idmap_pg_dir, init_idmap_pg_end, mask, page_shift);
 	dsb(ishst);
 
 	/* switch back to the updated initial ID map */
-	set_ttbr0_for_lpa2((u64)init_idmap_pg_dir);
+	set_ttbr0((u64)init_idmap_pg_dir, use_lpa2, page_shift);
 
 	/* wipe the temporary ID map from memory */
 	memset(init_pg_dir, 0, (u64)init_pg_end - (u64)init_pg_dir);
 }
 
-static void __init map_fdt(u64 fdt)
+static void __init map_fdt(u64 fdt, int page_shift)
 {
 	static u8 ptes[INIT_IDMAP_FDT_SIZE_MAX] __initdata __aligned(PAGE_SIZE);
+	static bool first_time __initdata = true;
 	u64 limit = (u64)&ptes[INIT_IDMAP_FDT_SIZE_MAX];
 	u64 efdt = fdt + MAX_FDT_SIZE;
 	u64 ptep = (u64)ptes;
 
+	if (!first_time) {
+		memset(ptes, 0, sizeof(ptes));
+		first_time = false;
+	}
+
 	/*
 	 * Map up to MAX_FDT_SIZE bytes, but avoid overlap with
 	 * the kernel image.
 	 */
 	map_range(&ptep, limit, fdt,
 		  (u64)_text > fdt ? min((u64)_text, efdt) : efdt,
-		  fdt, PAGE_KERNEL, IDMAP_ROOT_LEVEL(PAGE_SHIFT),
+		  fdt, PAGE_KERNEL, IDMAP_ROOT_LEVEL(page_shift),
 		  (pte_t *)init_idmap_pg_dir, false, 0);
 	dsb(ishst);
 }
@@ -207,13 +224,16 @@ static void __init map_fdt(u64 fdt)
 asmlinkage void __init early_map_kernel(u64 boot_status, void *fdt)
 {
 	static char const chosen_str[] __initconst = "/chosen";
+	u64 early_page_shift = early_tcr_tg0_to_page_shift();
 	u64 va_base, pa_base = (u64)&_text;
 	u64 kaslr_offset = pa_base % MIN_KIMG_ALIGN;
-	int root_level = 4 - CONFIG_PGTABLE_LEVELS;
 	int va_bits = VA_BITS;
+	bool use_lpa2 = false;
+	int root_level;
+	int page_shift;
 	int chosen;
 
-	map_fdt((u64)fdt);
+	map_fdt((u64)fdt, early_page_shift);
 
 	/* Clear BSS and the initial page tables */
 	memset(__bss_start, 0, (u64)init_pg_end - (u64)__bss_start);
@@ -222,16 +242,37 @@ asmlinkage void __init early_map_kernel(u64 boot_status, void *fdt)
 	chosen = fdt_path_offset(fdt, chosen_str);
 	init_feature_override(boot_status, fdt, chosen);
 
-	if (IS_ENABLED(CONFIG_ARM64_64K_PAGES) && !cpu_has_lva()) {
-		va_bits = VA_BITS_MIN;
-	} else if (IS_ENABLED(CONFIG_ARM64_LPA2) && !cpu_has_lpa2()) {
-		va_bits = VA_BITS_MIN;
-		root_level++;
+	/* Get page_shift from cmdline, falling back to early_page_shift. */
+	page_shift = arm64_pageshift_cmdline();
+	if (!page_shift)
+		page_shift = early_page_shift;
+
+	if (va_bits > 48) {
+		u64 page_size = early_page_size(page_shift);
+
+		if (page_size == SZ_64K) {
+			if (!cpu_has_lva(page_size))
+				va_bits = VA_BITS_MIN;
+		} else {
+			use_lpa2 = cpu_has_lpa2(page_size);
+			if (!use_lpa2)
+				va_bits = VA_BITS_MIN;
+		}
 	}
 
 	if (va_bits > VA_BITS_MIN)
 		sysreg_clear_set(tcr_el1, TCR_T1SZ_MASK, TCR_T1SZ(va_bits));
 
+	/*
+	 * This will update tg0/tg1 in tcr for the final page size. After this,
+	 * PAGE_SIZE and friends can be used safely. kaslr_early_init(), below,
+	 * is the first such user.
+	 */
+	if (use_lpa2 || page_shift != early_page_shift) {
+		remap_idmap(use_lpa2, page_shift);
+		map_fdt((u64)fdt, page_shift);
+	}
+
 	/*
 	 * The virtual KASLR displacement modulo 2MiB is decided by the
 	 * physical placement of the image, as otherwise, we might not be able
@@ -248,9 +289,7 @@ asmlinkage void __init early_map_kernel(u64 boot_status, void *fdt)
 		kaslr_offset |= kaslr_seed & ~(MIN_KIMG_ALIGN - 1);
 	}
 
-	if (IS_ENABLED(CONFIG_ARM64_LPA2) && va_bits > VA_BITS_MIN)
-		remap_idmap_for_lpa2();
-
 	va_base = KIMAGE_VADDR + kaslr_offset;
+	root_level = 4 - PGTABLE_LEVELS(page_shift, va_bits);
 	map_kernel(kaslr_offset, va_base - pa_base, root_level);
 }
diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_range.c
index b62d2e3135f81..be5470a969a47 100644
--- a/arch/arm64/kernel/pi/map_range.c
+++ b/arch/arm64/kernel/pi/map_range.c
@@ -11,6 +11,34 @@
 
 #include "pi.h"
 
+static inline u64 __init pte_get_oa(pte_t pte, int page_shift, bool oa52bit)
+{
+	pteval_t pv = pte_val(pte);
+
+#ifdef CONFIG_ARM64_PA_BITS_52
+	if (oa52bit) {
+		if (early_page_size(page_shift) == SZ_64K)
+			return (pv & GENMASK(47, 16)) |
+			       ((pv & GENMASK(15, 12)) << 36);
+		return (pv & GENMASK(49, 12)) | ((pv & GENMASK(9, 8)) << 42);
+	}
+#endif
+	return pv & GENMASK(47, 12);
+}
+
+static inline u64 __init pte_prep_oa(u64 oa, int page_shift, bool oa52bit)
+{
+#ifdef CONFIG_ARM64_PA_BITS_52
+	if (oa52bit) {
+		if (early_page_size(page_shift) == SZ_64K)
+			return (oa & GENMASK(47, 16)) |
+			       ((oa >> 36) & GENMASK(15, 12));
+		return (oa & GENMASK(49, 12)) | ((oa >> 42) & GENMASK(9, 8));
+	}
+#endif
+	return oa;
+}
+
 static void __init mmuoff_data_clean(void)
 {
 	bool cache_ena = !!(read_sysreg(sctlr_el1) & SCTLR_ELx_C);
@@ -35,8 +63,19 @@ static void __init report_cpu_stuck(long val)
 	cpu_park_loop();
 }
 
+u64 __section(".mmuoff.data.read") tcr_boot_fields;
+
+void __init set_tcr_boot_fields(u64 val)
+{
+	WRITE_ONCE(tcr_boot_fields, val);
+
+	/* Ensure the visibility of the new value */
+	dsb(ishst);
+	mmuoff_data_clean();
+}
+
 /**
- * map_range - Map a contiguous range of physical pages into virtual memory
+ * __map_range - Map a contiguous range of physical pages into virtual memory
  *
  * @pte:		Address of physical pointer to array of pages to
  *			allocate page tables from
@@ -50,21 +89,28 @@ static void __init report_cpu_stuck(long val)
  * @may_use_cont:	Whether the use of the contiguous attribute is allowed
  * @va_offset:		Offset between a physical page and its current mapping
  * 			in the VA space
+ * @page_shift:		Page size (as a shift) to create page table for
+ * @oa52bit:		Whether to store output addresses in 52-bit format
  */
-void __init map_range(u64 *pte, u64 limit, u64 start, u64 end, u64 pa,
-		      pgprot_t prot, int level, pte_t *tbl, bool may_use_cont,
-		      u64 va_offset)
+static void __init __map_range(u64 *pte, u64 limit, u64 start, u64 end, u64 pa,
+			       pgprot_t prot, int level, pte_t *tbl,
+			       bool may_use_cont, u64 va_offset, int page_shift,
+			       bool oa52bit)
 {
-	u64 cmask = (level == 3) ? CONT_PTE_SIZE - 1 : U64_MAX;
+	const u64 page_size = early_page_size(page_shift);
+	const u64 page_mask = early_page_mask(page_shift);
+	const u64 cont_pte_size = early_cont_pte_size(page_shift);
+	const u64 ptrs_per_pte = early_ptrs_per_pte(page_shift);
+	u64 cmask = (level == 3) ? cont_pte_size - 1 : U64_MAX;
 	u64 protval = pgprot_val(prot) & ~PTE_TYPE_MASK;
-	int lshift = (3 - level) * (PAGE_SHIFT - 3);
-	u64 lmask = (PAGE_SIZE << lshift) - 1;
+	int lshift = (3 - level) * (page_shift - 3);
+	u64 lmask = (page_size << lshift) - 1;
 
-	start	&= PAGE_MASK;
-	pa	&= PAGE_MASK;
+	start	&= page_mask;
+	pa	&= page_mask;
 
 	/* Advance tbl to the entry that covers start */
-	tbl += (start >> (lshift + PAGE_SHIFT)) % PTRS_PER_PTE;
+	tbl += (start >> (lshift + page_shift)) % ptrs_per_pte;
 
 	/*
 	 * Set the right block/page bits for this level unless we are
@@ -74,7 +120,7 @@ void __init map_range(u64 *pte, u64 limit, u64 start, u64 end, u64 pa,
 		protval |= (level < 3) ? PMD_TYPE_SECT : PTE_TYPE_PAGE;
 
 	while (start < end) {
-		u64 next = min((start | lmask) + 1, PAGE_ALIGN(end));
+		u64 next = min((start | lmask) + 1, ALIGN(end, page_size));
 
 		if (level < 3 && (start | next | pa) & lmask) {
 			/*
@@ -82,20 +128,20 @@ void __init map_range(u64 *pte, u64 limit, u64 start, u64 end, u64 pa,
 			 * table mapping if necessary and recurse.
 			 */
 			if (pte_none(*tbl)) {
-				u64 size = PTRS_PER_PTE * sizeof(pte_t);
+				u64 size = ptrs_per_pte * sizeof(pte_t);
 
 				if (*pte + size > limit) {
 					report_cpu_stuck(
 						CPU_STUCK_REASON_NO_PGTABLE_MEM);
 				}
 
-				*tbl = __pte(__phys_to_pte_val(*pte) |
+				*tbl = __pte(pte_prep_oa(*pte, page_shift, oa52bit) |
 					     PMD_TYPE_TABLE | PMD_TABLE_UXN);
 				*pte += size;
 			}
-			map_range(pte, limit, start, next, pa, prot, level + 1,
-				  (pte_t *)(__pte_to_phys(*tbl) + va_offset),
-				  may_use_cont, va_offset);
+			__map_range(pte, limit, start, next, pa, prot, level + 1,
+				    (pte_t *)(pte_get_oa(*tbl, page_shift, oa52bit) + va_offset),
+				    may_use_cont, va_offset, page_shift, oa52bit);
 		} else {
 			/*
 			 * Start a contiguous range if start and pa are
@@ -112,7 +158,8 @@ void __init map_range(u64 *pte, u64 limit, u64 start, u64 end, u64 pa,
 				protval &= ~PTE_CONT;
 
 			/* Put down a block or page mapping */
-			*tbl = __pte(__phys_to_pte_val(pa) | protval);
+			*tbl = __pte(pte_prep_oa(pa, page_shift, oa52bit) |
+				     protval);
 		}
 		pa += next - start;
 		start = next;
@@ -120,22 +167,96 @@ void __init map_range(u64 *pte, u64 limit, u64 start, u64 end, u64 pa,
 	}
 }
 
+/**
+ * map_range - Map a contiguous range of physical pages into virtual memory
+ *
+ * As per __map_range(), except it uses the page_shift and oa52bit of the
+ * currently tcr-installed granule size instead of passing explicitly.
+ */
+void __init map_range(u64 *pte, u64 limit, u64 start, u64 end, u64 pa,
+		      pgprot_t prot, int level, pte_t *tbl, bool may_use_cont,
+		      u64 va_offset)
+{
+	int page_shift = early_tcr_tg0_to_page_shift();
+	bool oa52bit = false;
+
+#ifdef CONFIG_ARM64_PA_BITS_52
+	/*
+	 * We can safely assume 52bit for 64K pages because if it turns out to
+	 * be 48bit, its still safe to treat [51:48] as address bits because
+	 * they are 0.
+	 */
+	if (early_page_size(page_shift) == SZ_64K)
+		oa52bit = true;
+	/*
+	 * For 4K and 16K, on the other hand, those bits are used for something
+	 * else when LPA2 is not explicitly enabled. Deliberately not using
+	 * read_tcr() since it is marked pure, and at this point, the tcr is not
+	 * yet stable.
+	 */
+	else if (read_sysreg(tcr_el1) & TCR_DS)
+		oa52bit = true;
+#endif
+
+	__map_range(pte, limit, start, end, pa, prot, level, tbl, may_use_cont,
+		    va_offset, page_shift, oa52bit);
+}
+
+asmlinkage u64 __init probe_init_idmap_page_shift(void)
+{
+	u64 mmfr0 = read_sysreg_s(SYS_ID_AA64MMFR0_EL1);
+	u32 tgran64 = SYS_FIELD_GET(ID_AA64MMFR0_EL1, TGRAN64, mmfr0);
+	u32 tgran16 = SYS_FIELD_GET(ID_AA64MMFR0_EL1, TGRAN16, mmfr0);
+	u32 tgran4 = SYS_FIELD_GET(ID_AA64MMFR0_EL1, TGRAN4, mmfr0);
+	u64 page_shift;
+
+	/*
+	 * Select the largest page size supported by the HW, which is also
+	 * allowed by the compilation config.
+	 */
+	if (ARM64_PAGE_SHIFT_64K >= PAGE_SHIFT_MIN &&
+	    ARM64_PAGE_SHIFT_64K <= PAGE_SHIFT_MAX &&
+	    tgran64 >= ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MIN &&
+	    tgran64 <= ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MAX)
+		page_shift = ARM64_PAGE_SHIFT_64K;
+	else if (ARM64_PAGE_SHIFT_16K >= PAGE_SHIFT_MIN &&
+	    ARM64_PAGE_SHIFT_16K <= PAGE_SHIFT_MAX &&
+	    tgran16 >= ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MIN &&
+	    tgran16 <= ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MAX)
+		page_shift = ARM64_PAGE_SHIFT_16K;
+	else if (ARM64_PAGE_SHIFT_4K >= PAGE_SHIFT_MIN &&
+	    ARM64_PAGE_SHIFT_4K <= PAGE_SHIFT_MAX &&
+	    tgran4 >= ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MIN &&
+	    tgran4 <= ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MAX)
+		page_shift = ARM64_PAGE_SHIFT_4K;
+	else
+		report_cpu_stuck(CPU_STUCK_REASON_NO_GRAN);
+
+	/* Stash this for __cpu_setup to configure primary cpu's tcr_el1. */
+	set_tcr_boot_fields(early_page_shift_to_tcr_tgx(page_shift));
+
+	return page_shift;
+}
+
 asmlinkage u64 __init create_init_idmap(pgd_t *pg_dir, pgd_t *pg_end,
-					pteval_t clrmask)
+					pteval_t clrmask, int page_shift)
 {
-	u64 ptep = (u64)pg_dir + PAGE_SIZE;
+	const u64 page_size = early_page_size(page_shift);
+	u64 ptep = (u64)pg_dir + page_size;
 	pgprot_t text_prot = PAGE_KERNEL_ROX;
 	pgprot_t data_prot = PAGE_KERNEL;
 
 	pgprot_val(text_prot) &= ~clrmask;
 	pgprot_val(data_prot) &= ~clrmask;
 
-	map_range(&ptep, (u64)pg_end, (u64)_stext, (u64)__initdata_begin,
-		  (u64)_stext, text_prot,
-		  IDMAP_ROOT_LEVEL(PAGE_SHIFT), (pte_t *)pg_dir, false, 0);
-	map_range(&ptep, (u64)pg_end, (u64)__initdata_begin, (u64)_end,
-		  (u64)__initdata_begin, data_prot,
-		  IDMAP_ROOT_LEVEL(PAGE_SHIFT), (pte_t *)pg_dir, false, 0);
+	__map_range(&ptep, (u64)pg_end, (u64)_stext, (u64)__initdata_begin,
+		    (u64)_stext, text_prot,
+		    IDMAP_ROOT_LEVEL(page_shift), (pte_t *)pg_dir, false, 0,
+		    page_shift, false);
+	__map_range(&ptep, (u64)pg_end, (u64)__initdata_begin, (u64)_end,
+		    (u64)__initdata_begin, data_prot,
+		    IDMAP_ROOT_LEVEL(page_shift), (pte_t *)pg_dir, false, 0,
+		    page_shift, false);
 
 	return ptep;
 }
diff --git a/arch/arm64/kernel/pi/pi.h b/arch/arm64/kernel/pi/pi.h
index 20fe0941cb8ee..15c14d0aa6c63 100644
--- a/arch/arm64/kernel/pi/pi.h
+++ b/arch/arm64/kernel/pi/pi.h
@@ -23,6 +23,62 @@ extern bool dynamic_scs_is_enabled;
 
 extern pgd_t init_idmap_pg_dir[], init_idmap_pg_end[];
 
+static inline u64 early_page_size(int page_shift)
+{
+	return 1UL << page_shift;
+}
+
+static inline u64 early_page_mask(int page_shift)
+{
+	return ~(early_page_size(page_shift) - 1);
+}
+
+static inline u64 early_cont_pte_size(int page_shift)
+{
+	switch (page_shift) {
+	case 16: /* 64K */
+	case 14: /* 16K */
+		return SZ_2M;
+	default: /* 12 4K */
+		return SZ_64K;
+	}
+}
+
+static inline u64 early_ptrs_per_pte(int page_shift)
+{
+	return 1UL << (page_shift - 3);
+}
+
+static inline int early_tcr_tg0_to_page_shift(void)
+{
+	/*
+	 * Deliberately not using read_tcr() since it is marked pure, and at
+	 * this point, the tcr is not yet stable.
+	 */
+	u64 tg0 = read_sysreg(tcr_el1) & TCR_TG0_MASK;
+
+	switch (tg0) {
+	case TCR_TG0_64K:
+		return 16;
+	case TCR_TG0_16K:
+		return 14;
+	default: /* TCR_TG0_4K */
+		return 12;
+	}
+}
+
+static inline u64 early_page_shift_to_tcr_tgx(int page_shift)
+{
+	switch (early_page_size(page_shift)) {
+	case SZ_64K:
+		return TCR_TG0_64K | TCR_TG1_64K;
+	case SZ_16K:
+		return TCR_TG0_16K | TCR_TG1_16K;
+	default:
+		return TCR_TG0_4K | TCR_TG1_4K;
+	}
+}
+
 void init_feature_override(u64 boot_status, const void *fdt, int chosen);
 u64 kaslr_early_init(void *fdt, int chosen);
 void relocate_kernel(u64 offset);
@@ -33,4 +89,7 @@ void map_range(u64 *pgd, u64 limit, u64 start, u64 end, u64 pa, pgprot_t prot,
 
 asmlinkage void early_map_kernel(u64 boot_status, void *fdt);
 
-asmlinkage u64 create_init_idmap(pgd_t *pgd, pgd_t *pg_end, pteval_t clrmask);
+void set_tcr_boot_fields(u64 val);
+asmlinkage u64 probe_init_idmap_page_shift(void);
+asmlinkage u64 create_init_idmap(pgd_t *pgd, pgd_t *pg_end, pteval_t clrmask,
+				 int page_shift);
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index f4bc6c5bac062..ab5aa84923524 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -22,14 +22,6 @@
 #include <asm/smp.h>
 #include <asm/sysreg.h>
 
-#ifdef CONFIG_ARM64_64K_PAGES
-#define TCR_TG_FLAGS	TCR_TG0_64K | TCR_TG1_64K
-#elif defined(CONFIG_ARM64_16K_PAGES)
-#define TCR_TG_FLAGS	TCR_TG0_16K | TCR_TG1_16K
-#else /* CONFIG_ARM64_4K_PAGES */
-#define TCR_TG_FLAGS	TCR_TG0_4K | TCR_TG1_4K
-#endif
-
 #ifdef CONFIG_RANDOMIZE_BASE
 #define TCR_KASLR_FLAGS	TCR_NFD1
 #else
@@ -469,18 +461,23 @@ SYM_FUNC_START(__cpu_setup)
 	tcr	.req	x16
 	mov_q	mair, MAIR_EL1_SET
 	mov_q	tcr, TCR_T0SZ(IDMAP_VA_BITS) | TCR_T1SZ(VA_BITS_MIN) | TCR_CACHE_FLAGS | \
-		     TCR_SMP_FLAGS | TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
+		     TCR_SMP_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
 		     TCR_TBI0 | TCR_A1 | TCR_KASAN_SW_FLAGS | TCR_MTE_FLAGS
 
+	/*
+	 * Insert the boot-time determined fields (TG0, TG1 and DS), which are
+	 * cached in the tcr_boot_fields variable.
+	 */
+	adr_l	x2, __pi_tcr_boot_fields
+	ldr	x3, [x2]
+	orr	tcr, tcr, x3
+
 	tcr_clear_errata_bits tcr, x9, x5
 
 #ifdef CONFIG_ARM64_VA_BITS_52
 	mov		x9, #64 - VA_BITS
 alternative_if ARM64_HAS_VA52
 	tcr_set_t1sz	tcr, x9
-#ifdef CONFIG_ARM64_LPA2
-	orr		tcr, tcr, #TCR_DS
-#endif
 alternative_else_nop_endif
 #endif
 
-- 
2.43.0


