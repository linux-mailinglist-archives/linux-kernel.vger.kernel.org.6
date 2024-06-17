Return-Path: <linux-kernel+bounces-217197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3926E90ACC1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F811C21EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160551953AF;
	Mon, 17 Jun 2024 11:19:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C04194A75
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623140; cv=none; b=c7TZKETuP3fZt9aTefjItn6SlVdvfojxYffJK2wxUw+dWEff3gLVHgTtAZlRvOb4vXnYIFU8uRuy+ZL47GHUvVOLISx0mdPctminyeygPLwBeKvBaHYSEpiKszT73ZrZLBrMBWan05SYi0gHexjr9Mec1JlptyDrm/3i+w+yGKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623140; c=relaxed/simple;
	bh=KnngVLiI+ACw91dsOqhXf45YArtNq2zX461WZtPUjtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iE4ZE/8uzLLeFLH4xW76wpC0ORtmTkWitaF8r28QI5QIip9F5c7xhZBZdXKBdwfmEZMKpQOuUHX651wqayuWi6yrJkrbb2LNHFEGuhiFqgEehMpg4ZOHaNql7wTXvFFenScl0Ii+xn3gdFoc4uuan2iyb1Zu1EJk3mSkC8FbkVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88E45152B;
	Mon, 17 Jun 2024 04:19:22 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CD44A3F6A8;
	Mon, 17 Jun 2024 04:18:56 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: alexandru.elisei@arm.com,
	catalin.marinas@arm.com,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	tglx@linutronix.de,
	will@kernel.org
Subject: [PATCH v2 5/5] arm64: irqchip/gic-v3: Select priorities at boot time
Date: Mon, 17 Jun 2024 12:18:41 +0100
Message-Id: <20240617111841.2529370-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240617111841.2529370-1-mark.rutland@arm.com>
References: <20240617111841.2529370-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The distributor and PMR/RPR can present different views of the interrupt
priority space dependent upon the values of GICD_CTLR.DS and
SCR_EL3.FIQ. Currently we treat the distributor's view of the priority
space as canonical, and when the two differ we change the way we handle
values in the PMR/RPR, using the `gic_nonsecure_priorities` static key
to decide what to do.

This approach works, but it's sub-optimal. When using pseudo-NMI we
manipulate the distributor rarely, and we manipulate the PMR/RPR
registers very frequently in code spread out throughout the kernel (e.g.
local_irq_{save,restore}()). It would be nicer if we could use fixed
values for the PMR/RPR, and dynamically choose the values programmed
into the distributor.

This patch changes the GICv3 driver and arm64 code accordingly. PMR
values are chosen at compile time, and the GICv3 driver determines the
appropriate values to program into the distributor at boot time. This
removes the need for the `gic_nonsecure_priorities` static key and
results in smaller and better generated code for saving/restoring the
irqflags.

Before this patch, local_irq_disable() compiles to:

| 0000000000000000 <outlined_local_irq_disable>:
|    0:   d503201f        nop
|    4:   d50343df        msr     daifset, #0x3
|    8:   d65f03c0        ret
|    c:   d503201f        nop
|   10:   d2800c00        mov     x0, #0x60                       // #96
|   14:   d5184600        msr     icc_pmr_el1, x0
|   18:   d65f03c0        ret
|   1c:   d2801400        mov     x0, #0xa0                       // #160
|   20:   17fffffd        b       14 <outlined_local_irq_disable+0x14>

After this patch, local_irq_disable() compiles to:

| 0000000000000000 <outlined_local_irq_disable>:
|    0:   d503201f        nop
|    4:   d50343df        msr     daifset, #0x3
|    8:   d65f03c0        ret
|    c:   d2801800        mov     x0, #0xc0                       // #192
|   10:   d5184600        msr     icc_pmr_el1, x0
|   14:   d65f03c0        ret

... with 3 fewer instructions per call.

For defconfig + CONFIG_PSEUDO_NMI=y, this results in a minor saving of
~4K of text, and will make it easier to make further improvements to the
way we manipulate irqflags and DAIF bits.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/arch_gicv3.h     | 15 ----
 arch/arm64/include/asm/ptrace.h         | 35 ++-------
 arch/arm64/kernel/image-vars.h          |  5 --
 drivers/irqchip/irq-gic-v3.c            | 96 ++++++++++---------------
 include/linux/irqchip/arm-gic-v3-prio.h | 52 ++++++++++++++
 5 files changed, 97 insertions(+), 106 deletions(-)
 create mode 100644 include/linux/irqchip/arm-gic-v3-prio.h

diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 5f172611654b1..9e96f024b2f19 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -175,21 +175,6 @@ static inline bool gic_prio_masking_enabled(void)
 
 static inline void gic_pmr_mask_irqs(void)
 {
-	BUILD_BUG_ON(GICD_INT_DEF_PRI < (__GIC_PRIO_IRQOFF |
-					 GIC_PRIO_PSR_I_SET));
-	BUILD_BUG_ON(GICD_INT_DEF_PRI >= GIC_PRIO_IRQON);
-	/*
-	 * Need to make sure IRQON allows IRQs when SCR_EL3.FIQ is cleared
-	 * and non-secure PMR accesses are not subject to the shifts that
-	 * are applied to IRQ priorities
-	 */
-	BUILD_BUG_ON((0x80 | (GICD_INT_DEF_PRI >> 1)) >= GIC_PRIO_IRQON);
-	/*
-	 * Same situation as above, but now we make sure that we can mask
-	 * regular interrupts.
-	 */
-	BUILD_BUG_ON((0x80 | (GICD_INT_DEF_PRI >> 1)) < (__GIC_PRIO_IRQOFF_NS |
-							 GIC_PRIO_PSR_I_SET));
 	gic_write_pmr(GIC_PRIO_IRQOFF);
 }
 
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 47ec58031f11b..0abe975d68a8e 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -21,35 +21,12 @@
 #define INIT_PSTATE_EL2 \
 	(PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT | PSR_MODE_EL2h)
 
-/*
- * PMR values used to mask/unmask interrupts.
- *
- * GIC priority masking works as follows: if an IRQ's priority is a higher value
- * than the value held in PMR, that IRQ is masked. Lowering the value of PMR
- * means masking more IRQs (or at least that the same IRQs remain masked).
- *
- * To mask interrupts, we clear the most significant bit of PMR.
- *
- * Some code sections either automatically switch back to PSR.I or explicitly
- * require to not use priority masking. If bit GIC_PRIO_PSR_I_SET is included
- * in the priority mask, it indicates that PSR.I should be set and
- * interrupt disabling temporarily does not rely on IRQ priorities.
- */
-#define GIC_PRIO_IRQON			0xe0
-#define __GIC_PRIO_IRQOFF		(GIC_PRIO_IRQON & ~0x80)
-#define __GIC_PRIO_IRQOFF_NS		0xa0
-#define GIC_PRIO_PSR_I_SET		(1 << 4)
-
-#define GIC_PRIO_IRQOFF							\
-	({								\
-		extern struct static_key_false gic_nonsecure_priorities;\
-		u8 __prio = __GIC_PRIO_IRQOFF;				\
-									\
-		if (static_branch_unlikely(&gic_nonsecure_priorities))	\
-			__prio = __GIC_PRIO_IRQOFF_NS;			\
-									\
-		__prio;							\
-	})
+#include <linux/irqchip/arm-gic-v3-prio.h>
+
+#define GIC_PRIO_IRQON		GICV3_PRIO_UNMASKED
+#define GIC_PRIO_IRQOFF		GICV3_PRIO_IRQ
+
+#define GIC_PRIO_PSR_I_SET	GICV3_PRIO_PSR_I_SET
 
 /* Additional SPSR bits not exposed in the UABI */
 #define PSR_MODE_THREAD_BIT	(1 << 0)
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index ba4f8f7d6a91a..8f5422ed1b758 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -105,11 +105,6 @@ KVM_NVHE_ALIAS(__hyp_stub_vectors);
 KVM_NVHE_ALIAS(vgic_v2_cpuif_trap);
 KVM_NVHE_ALIAS(vgic_v3_cpuif_trap);
 
-#ifdef CONFIG_ARM64_PSEUDO_NMI
-/* Static key checked in GIC_PRIO_IRQOFF. */
-KVM_NVHE_ALIAS(gic_nonsecure_priorities);
-#endif
-
 /* EL2 exception handling */
 KVM_NVHE_ALIAS(__start___kvm_ex_table);
 KVM_NVHE_ALIAS(__stop___kvm_ex_table);
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e262f73b1ce84..1b2b5f89f8321 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -25,6 +25,7 @@
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-common.h>
 #include <linux/irqchip/arm-gic-v3.h>
+#include <linux/irqchip/arm-gic-v3-prio.h>
 #include <linux/irqchip/irq-partition-percpu.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
@@ -37,8 +38,8 @@
 
 #include "irq-gic-common.h"
 
-static u8 dist_prio_irq __ro_after_init = GICD_INT_DEF_PRI;
-static u8 dist_prio_nmi __ro_after_init = GICD_INT_DEF_PRI & ~0x80;
+static u8 dist_prio_irq __ro_after_init = GICV3_PRIO_IRQ;
+static u8 dist_prio_nmi __ro_after_init = GICV3_PRIO_NMI;
 
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
@@ -110,30 +111,6 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
  */
 static DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
 
-DEFINE_STATIC_KEY_FALSE(gic_nonsecure_priorities);
-EXPORT_SYMBOL(gic_nonsecure_priorities);
-
-/*
- * When the Non-secure world has access to group 0 interrupts (as a
- * consequence of SCR_EL3.FIQ == 0), reading the ICC_RPR_EL1 register will
- * return the Distributor's view of the interrupt priority.
- *
- * When GIC security is enabled (GICD_CTLR.DS == 0), the interrupt priority
- * written by software is moved to the Non-secure range by the Distributor.
- *
- * If both are true (which is when gic_nonsecure_priorities gets enabled),
- * we need to shift down the priority programmed by software to match it
- * against the value returned by ICC_RPR_EL1.
- */
-#define GICD_INT_RPR_PRI(priority)					\
-	({								\
-		u32 __priority = (priority);				\
-		if (static_branch_unlikely(&gic_nonsecure_priorities))	\
-			__priority = 0x80 | (__priority >> 1);		\
-									\
-		__priority;						\
-	})
-
 static u32 gic_get_pribits(void)
 {
 	u32 pribits;
@@ -185,6 +162,41 @@ static void __init gic_prio_init(void)
 	cpus_have_security_disabled = gic_dist_security_disabled();
 	cpus_have_group0 = gic_has_group0();
 
+	/*
+	 * How priority values are used by the GIC depends on two things:
+	 * the security state of the GIC (controlled by the GICD_CTRL.DS bit)
+	 * and if Group 0 interrupts can be delivered to Linux in the non-secure
+	 * world as FIQs (controlled by the SCR_EL3.FIQ bit). These affect the
+	 * way priorities are presented in ICC_PMR_EL1 and in the distributor:
+	 *
+	 * GICD_CTRL.DS | SCR_EL3.FIQ | ICC_PMR_EL1 | Distributor
+	 * -------------------------------------------------------
+	 *      1       |      -      |  unchanged  |  unchanged
+	 * -------------------------------------------------------
+	 *      0       |      1      |  non-secure |  non-secure
+	 * -------------------------------------------------------
+	 *      0       |      0      |  unchanged  |  non-secure
+	 *
+	 * In the non-secure view reads and writes are modified:
+	 *
+	 * - A value written is right-shifted by one and the MSB is set,
+	 *   forcing the priority into the non-secure range.
+	 *
+	 * - A value read is left-shifted by one.
+	 *
+	 * In the first two cases, where ICC_PMR_EL1 and the interrupt priority
+	 * are both either modified or unchanged, we can use the same set of
+	 * priorities.
+	 *
+	 * In the last case, where only the interrupt priorities are modified to
+	 * be in the non-secure range, we program the non-secure values into
+	 * the distributor to match the PMR values we want.
+	 */
+	if (cpus_have_group0 & !cpus_have_security_disabled) {
+		dist_prio_irq = __gicv3_prio_to_ns(dist_prio_irq);
+		dist_prio_nmi = __gicv3_prio_to_ns(dist_prio_nmi);
+	}
+
 	pr_info("GICD_CTRL.DS=%d, SCR_EL3.FIQ=%d\n",
 		cpus_have_security_disabled,
 		!cpus_have_group0);
@@ -811,7 +823,7 @@ static bool gic_rpr_is_nmi_prio(void)
 	if (!gic_supports_nmi())
 		return false;
 
-	return unlikely(gic_read_rpr() == GICD_INT_RPR_PRI(dist_prio_nmi));
+	return unlikely(gic_read_rpr() == GICV3_PRIO_NMI);
 }
 
 static bool gic_irqnr_is_special(u32 irqnr)
@@ -1960,36 +1972,6 @@ static void gic_enable_nmi_support(void)
 	pr_info("Pseudo-NMIs enabled using %s ICC_PMR_EL1 synchronisation\n",
 		gic_has_relaxed_pmr_sync() ? "relaxed" : "forced");
 
-	/*
-	 * How priority values are used by the GIC depends on two things:
-	 * the security state of the GIC (controlled by the GICD_CTRL.DS bit)
-	 * and if Group 0 interrupts can be delivered to Linux in the non-secure
-	 * world as FIQs (controlled by the SCR_EL3.FIQ bit). These affect the
-	 * ICC_PMR_EL1 register and the priority that software assigns to
-	 * interrupts:
-	 *
-	 * GICD_CTRL.DS | SCR_EL3.FIQ | ICC_PMR_EL1 | Group 1 priority
-	 * -----------------------------------------------------------
-	 *      1       |      -      |  unchanged  |    unchanged
-	 * -----------------------------------------------------------
-	 *      0       |      1      |  non-secure |    non-secure
-	 * -----------------------------------------------------------
-	 *      0       |      0      |  unchanged  |    non-secure
-	 *
-	 * where non-secure means that the value is right-shifted by one and the
-	 * MSB bit set, to make it fit in the non-secure priority range.
-	 *
-	 * In the first two cases, where ICC_PMR_EL1 and the interrupt priority
-	 * are both either modified or unchanged, we can use the same set of
-	 * priorities.
-	 *
-	 * In the last case, where only the interrupt priorities are modified to
-	 * be in the non-secure range, we use a different PMR value to mask IRQs
-	 * and the rest of the values that we use remain unchanged.
-	 */
-	if (gic_has_group0() && !gic_dist_security_disabled())
-		static_branch_enable(&gic_nonsecure_priorities);
-
 	static_branch_enable(&supports_pseudo_nmis);
 
 	if (static_branch_likely(&supports_deactivate_key))
diff --git a/include/linux/irqchip/arm-gic-v3-prio.h b/include/linux/irqchip/arm-gic-v3-prio.h
new file mode 100644
index 0000000000000..44157c9abb78b
--- /dev/null
+++ b/include/linux/irqchip/arm-gic-v3-prio.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __LINUX_IRQCHIP_ARM_GIC_V3_PRIO_H
+#define __LINUX_IRQCHIP_ARM_GIC_V3_PRIO_H
+
+/*
+ * GIC priorities from the view of the PMR/RPR.
+ *
+ * These values are chosen to be valid in either the absolute priority space or
+ * the NS view of the priority space. The value programmed into the distributor
+ * and ITS will be chosen at boot time such that these values appear in the
+ * PMR/RPR.
+ *
+ * GICV3_PRIO_UNMASKED is the PMR view of the priority to use to permit both
+ * IRQs and pseudo-NMIs.
+ *
+ * GICV3_PRIO_IRQ is the PMR view of the priority of regular interrupts. This
+ * can be written to the PMR to mask regular IRQs.
+ *
+ * GICV3_PRIO_NMI is the PMR view of the priority of pseudo-NMIs. This can be
+ * written to the PMR to mask pseudo-NMIs.
+ *
+ * On arm64 some code sections either automatically switch back to PSR.I or
+ * explicitly require to not use priority masking. If bit GICV3_PRIO_PSR_I_SET
+ * is included in the priority mask, it indicates that PSR.I should be set and
+ * interrupt disabling temporarily does not rely on IRQ priorities.
+ */
+#define GICV3_PRIO_UNMASKED	0xe0
+#define GICV3_PRIO_IRQ		0xc0
+#define GICV3_PRIO_NMI		0x80
+
+#define GICV3_PRIO_PSR_I_SET	(1 << 4)
+
+#ifndef __ASSEMBLER__
+
+#define __gicv3_prio_to_ns(p)	(0xff & ((p) << 1))
+#define __gicv3_ns_to_prio(ns)	(0x80 | ((ns) >> 1))
+
+#define __gicv3_prio_valid_ns(p) \
+	(__gicv3_ns_to_prio(__gicv3_prio_to_ns(p)) == (p))
+
+static_assert(__gicv3_prio_valid_ns(GICV3_PRIO_NMI));
+static_assert(__gicv3_prio_valid_ns(GICV3_PRIO_IRQ));
+
+static_assert(GICV3_PRIO_NMI < GICV3_PRIO_IRQ);
+static_assert(GICV3_PRIO_IRQ < GICV3_PRIO_UNMASKED);
+
+static_assert(GICV3_PRIO_IRQ < (GICV3_PRIO_IRQ | GICV3_PRIO_PSR_I_SET));
+
+#endif /* __ASSEMBLER */
+
+#endif /* __LINUX_IRQCHIP_ARM_GIC_V3_PRIO_H */
-- 
2.30.2


