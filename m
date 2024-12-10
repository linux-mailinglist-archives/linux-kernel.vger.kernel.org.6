Return-Path: <linux-kernel+bounces-439354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE719EAE0A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F124F188A109
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774D02080D3;
	Tue, 10 Dec 2024 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yeN6a27/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s94ZxbjH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE02823DEAC
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826859; cv=none; b=W5L8B90FqVRA3ydcES4phb01JEDKUzcnelruV3fuhxgUkhfGd3t5JIeQk6oCx+zuNxSyOShwfg/U8azdRY60nqOsexeZEH/uK2RbWA34QvdkiDqktzFPm7c9FFJQGUbfPGU7TiGVtTWk2RoHsCex6Tj2MXI5Ink29cVdP6me1Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826859; c=relaxed/simple;
	bh=50hjnL6/kwp+wasxvFJmUdYywUs9rRLs0MrZrePqjZQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=T3955hX+8XLS2jgfmgrkvswBBzsilrZdQ9TdiXSxq3/RQ42XQGWSF8Tbq/sVppVsrI5Yc3Juxh6EPmfAmwJb83WU87U5myRNGaqEhK5JdUVvWIyGvM07vx2+RGN+mgtXQNVHzRF4tTY0BnQHoye8pVmBF+kOlAGyY8v22G/qUYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yeN6a27/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s94ZxbjH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241210103335.563277044@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733826856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=FUc3H37fA9rOswJxSZX3b2bKHt1EFh0JW7lQda1YR7Y=;
	b=yeN6a27/ykOS9NxJw6WhnWX6bgPgSiVwj8BQ8aibleAXN5epMjrU5ubhW1f0cHuNpxdCio
	Syjc8vdmb7/7wWTz0QX7aaXdBhPkz5u+rteDALPnZck7jQc0hSno4uNJu5xXRgmxQBcEWW
	c/YI1B1czTcMCTZic5AF1cLbUA7A3apL7fj6lLmaSvhkn9yI+s8y6eBmlfKeuLkmweBsB2
	QJdnV9y7nUaDLqpWiB6/qhYyesikIjUq2PDnCJzV14Chs8qsbmjAdQJoG4Jo4K/kjO8TZI
	cHlk9lzMhidjLwy+cVBOfNc2h9huIpv+SAUSJIPF63oLSKxa2zmXUKcDZmRt1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733826856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=FUc3H37fA9rOswJxSZX3b2bKHt1EFh0JW7lQda1YR7Y=;
	b=s94ZxbjHH9Ey2QqMNp2lD3tKXK2HY11BAXqnAsaPCMFi0zHmD/yNLUUQ5PVYhorz1awOSC
	Oo/UWnNZ/GuvWrCQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Anup Patel <apatel@ventanamicro.com>,
 Wei Liu <wei.liu@kernel.org>,
 Steve Wahl <steve.wahl@hpe.com>,
 Joerg Roedel <joro@8bytes.org>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Juergen Gross <jgross@suse.com>,
 Vineet Gupta <vgupta@kernel.org>,
 Brian Cain <bcain@quicinc.com>
Subject: [patch 4/5] x86/apic: Convert to IRQCHIP_MOVE_DEFERRED
References: <20241210102148.760383417@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Dec 2024 11:34:15 +0100 (CET)

Instead of marking individual interrupts as safe to be migrated in
arbitrary contexts, mark the interrupt chips, which require the interrupt
to be moved in actual interrupt context, with the new IRQCHIP_MOVE_DEFERRED
flag. This makes more sense because this is a per interrupt chip property
and not restricted to individual interrupts.

That flips the logic from the historical opt-out to a opt-in model. This is
simpler to handle for other architectures, which default to unrestricted
affinity setting. It also allows to cleanup the redundant core logic
significantly.

All interrupt chips, which belong to a top-level domain sitting directly on
top of the x86 vector domain are marked accordingly, unless the related
setup code marks the interrupts with IRQ_MOVE_PCNTXT, i.e. XEN.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Juergen Gross <jgross@suse.com>
---
 arch/x86/Kconfig                    |    1 +
 arch/x86/hyperv/irqdomain.c         |    2 +-
 arch/x86/kernel/apic/io_apic.c      |    2 +-
 arch/x86/kernel/apic/msi.c          |    3 ++-
 arch/x86/kernel/hpet.c              |    8 --------
 arch/x86/platform/uv/uv_irq.c       |    2 --
 drivers/iommu/amd/init.c            |    2 +-
 drivers/iommu/amd/iommu.c           |    1 -
 drivers/iommu/intel/irq_remapping.c |    1 -
 drivers/pci/controller/pci-hyperv.c |    1 +
 drivers/xen/events/events_base.c    |    6 ------
 11 files changed, 7 insertions(+), 22 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -173,6 +173,7 @@ config X86
 	select GENERIC_IRQ_RESERVATION_MODE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PENDING_IRQ		if SMP
+	select GENERIC_PENDING_IRQ_CHIPFLAGS	if SMP
 	select GENERIC_PTDUMP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -304,7 +304,7 @@ static struct irq_chip hv_pci_msi_contro
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_compose_msi_msg	= hv_irq_compose_msi_msg,
 	.irq_set_affinity	= msi_domain_set_affinity,
-	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED,
 };
 
 static struct msi_domain_ops pci_msi_domain_ops = {
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1861,7 +1861,7 @@ static struct irq_chip ioapic_chip __rea
 	.irq_set_affinity	= ioapic_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_get_irqchip_state	= ioapic_irq_get_chip_state,
-	.flags			= IRQCHIP_SKIP_SET_WAKE |
+	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED |
 				  IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -214,6 +214,7 @@ static bool x86_init_dev_msi_info(struct
 		if (WARN_ON_ONCE(domain != real_parent))
 			return false;
 		info->chip->irq_set_affinity = msi_set_affinity;
+		info->chip->flags |= IRQCHIP_MOVE_DEFERRED;
 		break;
 	case DOMAIN_BUS_DMAR:
 	case DOMAIN_BUS_AMDVI:
@@ -315,7 +316,7 @@ static struct irq_chip dmar_msi_controll
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_compose_msi_msg	= dmar_msi_compose_msg,
 	.irq_write_msi_msg	= dmar_msi_write_msg,
-	.flags			= IRQCHIP_SKIP_SET_WAKE |
+	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED |
 				  IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -516,22 +516,14 @@ static int hpet_msi_init(struct irq_doma
 			 struct msi_domain_info *info, unsigned int virq,
 			 irq_hw_number_t hwirq, msi_alloc_info_t *arg)
 {
-	irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
 	irq_domain_set_info(domain, virq, arg->hwirq, info->chip, NULL,
 			    handle_edge_irq, arg->data, "edge");
 
 	return 0;
 }
 
-static void hpet_msi_free(struct irq_domain *domain,
-			  struct msi_domain_info *info, unsigned int virq)
-{
-	irq_clear_status_flags(virq, IRQ_MOVE_PCNTXT);
-}
-
 static struct msi_domain_ops hpet_msi_domain_ops = {
 	.msi_init	= hpet_msi_init,
-	.msi_free	= hpet_msi_free,
 };
 
 static struct msi_domain_info hpet_msi_domain_info = {
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -92,8 +92,6 @@ static int uv_domain_alloc(struct irq_do
 	if (ret >= 0) {
 		if (info->uv.limit == UV_AFFINITY_CPU)
 			irq_set_status_flags(virq, IRQ_NO_BALANCING);
-		else
-			irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
 
 		chip_data->pnode = uv_blade_to_pnode(info->uv.blade);
 		chip_data->offset = info->uv.offset;
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2332,7 +2332,7 @@ static struct irq_chip intcapxt_controll
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_affinity       = intcapxt_set_affinity,
 	.irq_set_wake		= intcapxt_set_wake,
-	.flags			= IRQCHIP_MASK_ON_SUSPEND,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_MOVE_DEFERRED,
 };
 
 static const struct irq_domain_ops intcapxt_domain_ops = {
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3532,7 +3532,6 @@ static int irq_remapping_alloc(struct ir
 		irq_data->chip_data = data;
 		irq_data->chip = &amd_ir_chip;
 		irq_remapping_prepare_irte(data, cfg, info, devid, index, i);
-		irq_set_status_flags(virq + i, IRQ_MOVE_PCNTXT);
 	}
 
 	return 0;
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1463,7 +1463,6 @@ static int intel_irq_remapping_alloc(str
 		else
 			irq_data->chip = &intel_ir_chip;
 		intel_irq_remapping_prepare_irte(ird, irq_cfg, info, index, i);
-		irq_set_status_flags(virq + i, IRQ_MOVE_PCNTXT);
 	}
 	return 0;
 
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2053,6 +2053,7 @@ static struct irq_chip hv_msi_irq_chip =
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 #ifdef CONFIG_X86
 	.irq_ack		= irq_chip_ack_parent,
+	.flags			= IRQCHIP_MOVE_DEFERRED,
 #elif defined(CONFIG_ARM64)
 	.irq_eoi		= irq_chip_eoi_parent,
 #endif
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -722,12 +722,6 @@ static struct irq_info *xen_irq_init(uns
 		INIT_RCU_WORK(&info->rwork, delayed_free_irq);
 
 		set_info_for_irq(irq, info);
-		/*
-		 * Interrupt affinity setting can be immediate. No point
-		 * in delaying it until an interrupt is handled.
-		 */
-		irq_set_status_flags(irq, IRQ_MOVE_PCNTXT);
-
 		INIT_LIST_HEAD(&info->eoi_list);
 		list_add_tail(&info->list, &xen_irq_list_head);
 	}


