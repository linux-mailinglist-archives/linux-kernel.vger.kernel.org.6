Return-Path: <linux-kernel+bounces-217196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7D790ACC0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B41A28433B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB28195382;
	Mon, 17 Jun 2024 11:18:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C172D194C75
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623138; cv=none; b=oPFBhVApkqU+HnXQZp7K010a1EYA9EbbBCGX2himeqqt1pW3gj/cpOLPNVisViotXvvMH/SHPvZMTnnDq58unMi6GZy1qQVvAcUaUzlk34r1fc3e/HeK6/i+FW4jjrV1wOiughX2aZVKtyXn9TlWyG1COo3frLb4yc9Z6ZTeHN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623138; c=relaxed/simple;
	bh=cGBgLEYrC90bViIZubP6Yn3D+hrbkYM6tRdObqhxX0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LVbzfSnX3Dku7lONtShfQsPXHOGUK2kUjZq9jducEd3/2cdzTkXMLPnp0Cl3ssqBCbLyqyhtRaYVPuYjrwEJTyOPkRIwMVEt5XS9KdFxDZSxJcyok6sIUdM0TRnV9AtSJOqRAqNzgtHsB8pV9BuYbe+GJBTYG2udtNLBaMl/Yt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5021DA7;
	Mon, 17 Jun 2024 04:19:20 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1730D3F6A8;
	Mon, 17 Jun 2024 04:18:54 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: alexandru.elisei@arm.com,
	catalin.marinas@arm.com,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	tglx@linutronix.de,
	will@kernel.org
Subject: [PATCH v2 4/5] irqchip/gic-v3: Detect GICD_CTRL.DS and SCR_EL3.FIQ earlier
Date: Mon, 17 Jun 2024 12:18:40 +0100
Message-Id: <20240617111841.2529370-5-mark.rutland@arm.com>
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

In subsequent patches the GICv3 driver will choose the regular interrupt
priority at boot time, dependent on the configuration of GICD_CTRL.DS
and SCR_EL3.FIQ. This will need to be chosen before we configure the
distributor with default prioirities for all the interrupts, which
happens before we currently detect these in gic_cpu_sys_reg_init().

Add a new gic_prio_init() function to detect these earlier and log them
to the console so that any problems can be debugged more easily. This
also allows the uniformity checks in gic_cpu_sys_reg_init() to be
simplified, as we can compare directly with the boot CPU values which
were recorded earlier.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 117 +++++++++++++++++++----------------
 1 file changed, 63 insertions(+), 54 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d884d94c6f4d0..e262f73b1ce84 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -134,6 +134,62 @@ EXPORT_SYMBOL(gic_nonsecure_priorities);
 		__priority;						\
 	})
 
+static u32 gic_get_pribits(void)
+{
+	u32 pribits;
+
+	pribits = gic_read_ctlr();
+	pribits &= ICC_CTLR_EL1_PRI_BITS_MASK;
+	pribits >>= ICC_CTLR_EL1_PRI_BITS_SHIFT;
+	pribits++;
+
+	return pribits;
+}
+
+static bool gic_has_group0(void)
+{
+	u32 val;
+	u32 old_pmr;
+
+	old_pmr = gic_read_pmr();
+
+	/*
+	 * Let's find out if Group0 is under control of EL3 or not by
+	 * setting the highest possible, non-zero priority in PMR.
+	 *
+	 * If SCR_EL3.FIQ is set, the priority gets shifted down in
+	 * order for the CPU interface to set bit 7, and keep the
+	 * actual priority in the non-secure range. In the process, it
+	 * looses the least significant bit and the actual priority
+	 * becomes 0x80. Reading it back returns 0, indicating that
+	 * we're don't have access to Group0.
+	 */
+	gic_write_pmr(BIT(8 - gic_get_pribits()));
+	val = gic_read_pmr();
+
+	gic_write_pmr(old_pmr);
+
+	return val != 0;
+}
+
+static inline bool gic_dist_security_disabled(void)
+{
+	return readl_relaxed(gic_data.dist_base + GICD_CTLR) & GICD_CTLR_DS;
+}
+
+static bool cpus_have_security_disabled __ro_after_init;
+static bool cpus_have_group0 __ro_after_init;
+
+static void __init gic_prio_init(void)
+{
+	cpus_have_security_disabled = gic_dist_security_disabled();
+	cpus_have_group0 = gic_has_group0();
+
+	pr_info("GICD_CTRL.DS=%d, SCR_EL3.FIQ=%d\n",
+		cpus_have_security_disabled,
+		!cpus_have_group0);
+}
+
 /* rdist_nmi_refs[n] == number of cpus having the rdist interrupt n set as NMI */
 static refcount_t *rdist_nmi_refs;
 
@@ -868,44 +924,6 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 		__gic_handle_irq_from_irqson(regs);
 }
 
-static u32 gic_get_pribits(void)
-{
-	u32 pribits;
-
-	pribits = gic_read_ctlr();
-	pribits &= ICC_CTLR_EL1_PRI_BITS_MASK;
-	pribits >>= ICC_CTLR_EL1_PRI_BITS_SHIFT;
-	pribits++;
-
-	return pribits;
-}
-
-static bool gic_has_group0(void)
-{
-	u32 val;
-	u32 old_pmr;
-
-	old_pmr = gic_read_pmr();
-
-	/*
-	 * Let's find out if Group0 is under control of EL3 or not by
-	 * setting the highest possible, non-zero priority in PMR.
-	 *
-	 * If SCR_EL3.FIQ is set, the priority gets shifted down in
-	 * order for the CPU interface to set bit 7, and keep the
-	 * actual priority in the non-secure range. In the process, it
-	 * looses the least significant bit and the actual priority
-	 * becomes 0x80. Reading it back returns 0, indicating that
-	 * we're don't have access to Group0.
-	 */
-	gic_write_pmr(BIT(8 - gic_get_pribits()));
-	val = gic_read_pmr();
-
-	gic_write_pmr(old_pmr);
-
-	return val != 0;
-}
-
 static void __init gic_dist_init(void)
 {
 	unsigned int i;
@@ -1122,12 +1140,6 @@ static void gic_update_rdist_properties(void)
 			gic_data.rdists.has_vpend_valid_dirty ? "Valid+Dirty " : "");
 }
 
-/* Check whether it's single security state view */
-static inline bool gic_dist_security_disabled(void)
-{
-	return readl_relaxed(gic_data.dist_base + GICD_CTLR) & GICD_CTLR_DS;
-}
-
 static void gic_cpu_sys_reg_init(void)
 {
 	int i, cpu = smp_processor_id();
@@ -1155,18 +1167,14 @@ static void gic_cpu_sys_reg_init(void)
 		write_gicreg(DEFAULT_PMR_VALUE, ICC_PMR_EL1);
 	} else if (gic_supports_nmi()) {
 		/*
-		 * Mismatch configuration with boot CPU, the system is likely
-		 * to die as interrupt masking will not work properly on all
-		 * CPUs
+		 * Check that all CPUs use the same priority space.
 		 *
-		 * The boot CPU calls this function before enabling NMI support,
-		 * and as a result we'll never see this warning in the boot path
-		 * for that CPU.
+		 * If there's a mismatch with the boot CPU, the system is
+		 * likely to die as interrupt masking will not work properly on
+		 * all CPUs.
 		 */
-		if (static_branch_unlikely(&gic_nonsecure_priorities))
-			WARN_ON(!group0 || gic_dist_security_disabled());
-		else
-			WARN_ON(group0 && !gic_dist_security_disabled());
+		WARN_ON(group0 != cpus_have_group0);
+		WARN_ON(gic_dist_security_disabled() != cpus_have_security_disabled);
 	}
 
 	/*
@@ -2062,6 +2070,7 @@ static int __init gic_init_bases(phys_addr_t dist_phys_base,
 
 	gic_update_rdist_properties();
 
+	gic_prio_init();
 	gic_dist_init();
 	gic_cpu_init();
 	gic_enable_nmi_support();
-- 
2.30.2


