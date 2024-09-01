Return-Path: <linux-kernel+bounces-310205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B11B967649
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 13:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5E11F215D2
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 11:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE35417ADE1;
	Sun,  1 Sep 2024 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R+jvI/iY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F+8A/IVd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DF016DC33
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 11:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725191051; cv=none; b=OxXoIn3/i1EioLr9PxBFFNZ+OQ4YsKzUApoiqX3uoVtd/lxva89IIww3Q3NUlkxBhg+RK/Tv0hhp5gTem3uYSawyvf1r5uJ3mUP15z7n+56i1HA1hSgCdqKg1dFnT12ZLWZ8J64Kq4e5mMfnL62ikXJ/U80kc3Ls0F0UuebL4CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725191051; c=relaxed/simple;
	bh=OrIKQEe6ak8Z2xTNQIKEJO9BUXFj8czX6ptSXnJ9Myw=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=L4lYoBQzfaDJd6xAJPOQOthVbNYHz5Z/OqSEPqg4uTNApoQBqXSLLKLkuzWbJko163QZnClBPDn9z+2vZmYvVinx476PX9cNcdqTL9dnOoPo//Ktivb+aGWbo8U83tqmNp6kHMSIBvX7vo4lngYijvZWcMlteIfU1FTwBFwYaRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R+jvI/iY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F+8A/IVd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725191040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wcgh/wxUz27T6W1DI0p7pcf+eLiBYfkY2GAcV+Joac4=;
	b=R+jvI/iY6ibcXfEE2WgG3dO8sJCCaBDQ2Ull1c8GrOtPouvrbXAtWldNoX08Q1fX+CUYKR
	ULag8J2Fb5N5iDkBa+df7RSejYNJtQasntWY2SZ2tpQjaeV77sUQyxdnwyH/BLyIKq2GAA
	0aQ2ep66NM80DxWHdWE/Y9GZx+f2g6ZHUWM/rZ79jL+Xqd28pJt57rVxDrT6KBBK+vCYNg
	9sH+SaZFYrqmNt0NMWSp3SUUtpSjAQLTvSDsBtUkRRow7r2kXnzJQ2Y4qnrtsFk63tlV8G
	JmN+X3orofb2vQXfKvDx3/HqHw+D8LYz5w1ZkgdxqwzChuGR/8gtyzEuUxU/8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725191040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wcgh/wxUz27T6W1DI0p7pcf+eLiBYfkY2GAcV+Joac4=;
	b=F+8A/IVdNoUQa+0hMnr4DnycSxqCkKfngWd8akVO3VsfhDGGIs2VArttzEDxXvAUX22w+p
	kDJZqFoQ8SpwKvDw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v6.11-rc7
Message-ID: <172519097408.1871736.16401401125691449823.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun,  1 Sep 2024 13:43:59 +0200 (CEST)

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-=
08-25

up to:  880799fc7a3a: irqchip/irq-msi-lib: Check for NULL ops in msi_lib_irq_=
domain_select()


A set of fixes for interrupt chip drivers:

  - Unbreak the PLIC driver for Allwinner D1 systems

    The recent conversion of the PLIC driver to a platform driver broke
    Allwinnder D1 systems due to the deferred probing of platform drivers.

    Due to that the only timer available on D1 systems cannot get an
    interrupt, which causes the system to hang at boot. Other RISCV
    platforms are not affected because they provide the architected SBI
    timer which uses the built in core interrupt controller.

    Cure this by probing PLIC early on D1 systems

  - Cure a regression in ARM/GIC-V3 on 32-bit ARM systems caused by the
    recent addition of a initialization function, which accesses system
    registers before they are enabled. On 64-bit ARM they are enabled
    prior to that by sheer luck.

    Ensure they are enabled.

  - Cure a use before check problem in the MSI library. The existing NULL
    pointer check is too late.

  - Cure a lock order inversion in the ARM/GIC-V4 driver

  - Fix a IS_ERR() vs. NULL pointer check issue in the RISCV APLIC driver

  - Plug a reference count leak in the ARM/GIC-V2 driver


Thanks,

	tglx

------------------>
Anup Patel (1):
      irqchip/sifive-plic: Probe plic driver early for Allwinner D1 platform

Dan Carpenter (1):
      irqchip/riscv-aplic: Fix an IS_ERR() vs NULL bug in probe()

Ma Ke (1):
      irqchip/gic-v2m: Fix refcount leak in gicv2m_of_init()

Marc Zyngier (1):
      irqchip/gic-v4: Fix ordering between vmapp and vpe locks

Mark Rutland (1):
      irqchip/gic-v3: Init SRE before poking sysregs

Maxime Chevallier (1):
      irqchip/irq-msi-lib: Check for NULL ops in msi_lib_irq_domain_select()


 drivers/irqchip/irq-gic-v2m.c          |   6 +-
 drivers/irqchip/irq-gic-v3-its.c       |  16 +++--
 drivers/irqchip/irq-gic-v3.c           |  21 ++++--
 drivers/irqchip/irq-msi-lib.c          |   5 +-
 drivers/irqchip/irq-riscv-aplic-main.c |   4 +-
 drivers/irqchip/irq-sifive-plic.c      | 115 ++++++++++++++++++++-----------=
--
 6 files changed, 104 insertions(+), 63 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 51af63c046ed..be35c5349986 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -407,12 +407,12 @@ static int __init gicv2m_of_init(struct fwnode_handle *=
parent_handle,
=20
 		ret =3D gicv2m_init_one(&child->fwnode, spi_start, nr_spis,
 				      &res, 0);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			break;
-		}
 	}
=20
+	if (ret && child)
+		of_node_put(child);
 	if (!ret)
 		ret =3D gicv2m_allocate_domains(parent);
 	if (ret)
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index 9b34596b3542..fdec478ba5e7 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1329,12 +1329,6 @@ static void its_send_vmovp(struct its_vpe *vpe)
 		return;
 	}
=20
-	/*
-	 * Protect against concurrent updates of the mapping state on
-	 * individual VMs.
-	 */
-	guard(raw_spinlock_irqsave)(&vpe->its_vm->vmapp_lock);
-
 	/*
 	 * Yet another marvel of the architecture. If using the
 	 * its_list "feature", we need to make sure that all ITSs
@@ -3824,7 +3818,14 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	 * protect us, and that we must ensure nobody samples vpe->col_idx
 	 * during the update, hence the lock below which must also be
 	 * taken on any vLPI handling path that evaluates vpe->col_idx.
+	 *
+	 * Finally, we must protect ourselves against concurrent updates of
+	 * the mapping state on this VM should the ITS list be in use (see
+	 * the shortcut in its_send_vmovp() otherewise).
 	 */
+	if (its_list_map)
+		raw_spin_lock(&vpe->its_vm->vmapp_lock);
+
 	from =3D vpe_to_cpuid_lock(vpe, &flags);
 	table_mask =3D gic_data_rdist_cpu(from)->vpe_table_mask;
=20
@@ -3854,6 +3855,9 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 	vpe_to_cpuid_unlock(vpe, flags);
=20
+	if (its_list_map)
+		raw_spin_unlock(&vpe->its_vm->vmapp_lock);
+
 	return IRQ_SET_MASK_OK_DONE;
 }
=20
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index c19083bfb943..74f21e03d4a3 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1154,14 +1154,8 @@ static void gic_update_rdist_properties(void)
 			gic_data.rdists.has_vpend_valid_dirty ? "Valid+Dirty " : "");
 }
=20
-static void gic_cpu_sys_reg_init(void)
+static void gic_cpu_sys_reg_enable(void)
 {
-	int i, cpu =3D smp_processor_id();
-	u64 mpidr =3D gic_cpu_to_affinity(cpu);
-	u64 need_rss =3D MPIDR_RS(mpidr);
-	bool group0;
-	u32 pribits;
-
 	/*
 	 * Need to check that the SRE bit has actually been set. If
 	 * not, it means that SRE is disabled at EL2. We're going to
@@ -1172,6 +1166,16 @@ static void gic_cpu_sys_reg_init(void)
 	if (!gic_enable_sre())
 		pr_err("GIC: unable to set SRE (disabled at EL2), panic ahead\n");
=20
+}
+
+static void gic_cpu_sys_reg_init(void)
+{
+	int i, cpu =3D smp_processor_id();
+	u64 mpidr =3D gic_cpu_to_affinity(cpu);
+	u64 need_rss =3D MPIDR_RS(mpidr);
+	bool group0;
+	u32 pribits;
+
 	pribits =3D gic_get_pribits();
=20
 	group0 =3D gic_has_group0();
@@ -1333,6 +1337,7 @@ static int gic_check_rdist(unsigned int cpu)
=20
 static int gic_starting_cpu(unsigned int cpu)
 {
+	gic_cpu_sys_reg_enable();
 	gic_cpu_init();
=20
 	if (gic_dist_supports_lpis())
@@ -1498,6 +1503,7 @@ static int gic_cpu_pm_notifier(struct notifier_block *s=
elf,
 	if (cmd =3D=3D CPU_PM_EXIT) {
 		if (gic_dist_security_disabled())
 			gic_enable_redist(true);
+		gic_cpu_sys_reg_enable();
 		gic_cpu_sys_reg_init();
 	} else if (cmd =3D=3D CPU_PM_ENTER && gic_dist_security_disabled()) {
 		gic_write_grpen1(0);
@@ -2070,6 +2076,7 @@ static int __init gic_init_bases(phys_addr_t dist_phys_=
base,
=20
 	gic_update_rdist_properties();
=20
+	gic_cpu_sys_reg_enable();
 	gic_prio_init();
 	gic_dist_init();
 	gic_cpu_init();
diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index b5b90003311a..d8e29fc0d406 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -128,6 +128,9 @@ int msi_lib_irq_domain_select(struct irq_domain *d, struc=
t irq_fwspec *fwspec,
 	const struct msi_parent_ops *ops =3D d->msi_parent_ops;
 	u32 busmask =3D BIT(bus_token);
=20
+	if (!ops)
+		return 0;
+
 	if (fwspec->fwnode !=3D d->fwnode || fwspec->param_count !=3D 0)
 		return 0;
=20
@@ -135,6 +138,6 @@ int msi_lib_irq_domain_select(struct irq_domain *d, struc=
t irq_fwspec *fwspec,
 	if (bus_token =3D=3D ops->bus_select_token)
 		return 1;
=20
-	return ops && !!(ops->bus_select_mask & busmask);
+	return !!(ops->bus_select_mask & busmask);
 }
 EXPORT_SYMBOL_GPL(msi_lib_irq_domain_select);
diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-ris=
cv-aplic-main.c
index 28dd175b5764..981fad6fb8f7 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -175,9 +175,9 @@ static int aplic_probe(struct platform_device *pdev)
=20
 	/* Map the MMIO registers */
 	regs =3D devm_platform_ioremap_resource(pdev, 0);
-	if (!regs) {
+	if (IS_ERR(regs)) {
 		dev_err(dev, "failed map MMIO registers\n");
-		return -ENOMEM;
+		return PTR_ERR(regs);
 	}
=20
 	/*
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-p=
lic.c
index 9e22f7e378f5..4d9ea718086d 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2017 SiFive
  * Copyright (C) 2018 Christoph Hellwig
  */
+#define pr_fmt(fmt) "riscv-plic: " fmt
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -63,7 +64,7 @@
 #define PLIC_QUIRK_EDGE_INTERRUPT	0
=20
 struct plic_priv {
-	struct device *dev;
+	struct fwnode_handle *fwnode;
 	struct cpumask lmask;
 	struct irq_domain *irqdomain;
 	void __iomem *regs;
@@ -378,8 +379,8 @@ static void plic_handle_irq(struct irq_desc *desc)
 		int err =3D generic_handle_domain_irq(handler->priv->irqdomain,
 						    hwirq);
 		if (unlikely(err)) {
-			dev_warn_ratelimited(handler->priv->dev,
-					     "can't find mapping for hwirq %lu\n", hwirq);
+			pr_warn_ratelimited("%pfwP: can't find mapping for hwirq %lu\n",
+					    handler->priv->fwnode, hwirq);
 		}
 	}
=20
@@ -408,7 +409,8 @@ static int plic_starting_cpu(unsigned int cpu)
 		enable_percpu_irq(plic_parent_irq,
 				  irq_get_trigger_type(plic_parent_irq));
 	else
-		dev_warn(handler->priv->dev, "cpu%d: parent irq not available\n", cpu);
+		pr_warn("%pfwP: cpu%d: parent irq not available\n",
+			handler->priv->fwnode, cpu);
 	plic_set_threshold(handler, PLIC_ENABLE_THRESHOLD);
=20
 	return 0;
@@ -424,38 +426,36 @@ static const struct of_device_id plic_match[] =3D {
 	{}
 };
=20
-static int plic_parse_nr_irqs_and_contexts(struct platform_device *pdev,
+static int plic_parse_nr_irqs_and_contexts(struct fwnode_handle *fwnode,
 					   u32 *nr_irqs, u32 *nr_contexts)
 {
-	struct device *dev =3D &pdev->dev;
 	int rc;
=20
 	/*
 	 * Currently, only OF fwnode is supported so extend this
 	 * function for ACPI support.
 	 */
-	if (!is_of_node(dev->fwnode))
+	if (!is_of_node(fwnode))
 		return -EINVAL;
=20
-	rc =3D of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", nr_irqs);
+	rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,ndev", nr_irqs);
 	if (rc) {
-		dev_err(dev, "riscv,ndev property not available\n");
+		pr_err("%pfwP: riscv,ndev property not available\n", fwnode);
 		return rc;
 	}
=20
-	*nr_contexts =3D of_irq_count(to_of_node(dev->fwnode));
+	*nr_contexts =3D of_irq_count(to_of_node(fwnode));
 	if (WARN_ON(!(*nr_contexts))) {
-		dev_err(dev, "no PLIC context available\n");
+		pr_err("%pfwP: no PLIC context available\n", fwnode);
 		return -EINVAL;
 	}
=20
 	return 0;
 }
=20
-static int plic_parse_context_parent(struct platform_device *pdev, u32 conte=
xt,
+static int plic_parse_context_parent(struct fwnode_handle *fwnode, u32 conte=
xt,
 				     u32 *parent_hwirq, int *parent_cpu)
 {
-	struct device *dev =3D &pdev->dev;
 	struct of_phandle_args parent;
 	unsigned long hartid;
 	int rc;
@@ -464,10 +464,10 @@ static int plic_parse_context_parent(struct platform_de=
vice *pdev, u32 context,
 	 * Currently, only OF fwnode is supported so extend this
 	 * function for ACPI support.
 	 */
-	if (!is_of_node(dev->fwnode))
+	if (!is_of_node(fwnode))
 		return -EINVAL;
=20
-	rc =3D of_irq_parse_one(to_of_node(dev->fwnode), context, &parent);
+	rc =3D of_irq_parse_one(to_of_node(fwnode), context, &parent);
 	if (rc)
 		return rc;
=20
@@ -480,48 +480,55 @@ static int plic_parse_context_parent(struct platform_de=
vice *pdev, u32 context,
 	return 0;
 }
=20
-static int plic_probe(struct platform_device *pdev)
+static int plic_probe(struct fwnode_handle *fwnode)
 {
 	int error =3D 0, nr_contexts, nr_handlers =3D 0, cpu, i;
-	struct device *dev =3D &pdev->dev;
 	unsigned long plic_quirks =3D 0;
 	struct plic_handler *handler;
 	u32 nr_irqs, parent_hwirq;
 	struct plic_priv *priv;
 	irq_hw_number_t hwirq;
+	void __iomem *regs;
=20
-	if (is_of_node(dev->fwnode)) {
+	if (is_of_node(fwnode)) {
 		const struct of_device_id *id;
=20
-		id =3D of_match_node(plic_match, to_of_node(dev->fwnode));
+		id =3D of_match_node(plic_match, to_of_node(fwnode));
 		if (id)
 			plic_quirks =3D (unsigned long)id->data;
+
+		regs =3D of_iomap(to_of_node(fwnode), 0);
+		if (!regs)
+			return -ENOMEM;
+	} else {
+		return -ENODEV;
 	}
=20
-	error =3D plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_contexts);
+	error =3D plic_parse_nr_irqs_and_contexts(fwnode, &nr_irqs, &nr_contexts);
 	if (error)
-		return error;
+		goto fail_free_regs;
=20
-	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		error =3D -ENOMEM;
+		goto fail_free_regs;
+	}
=20
-	priv->dev =3D dev;
+	priv->fwnode =3D fwnode;
 	priv->plic_quirks =3D plic_quirks;
 	priv->nr_irqs =3D nr_irqs;
+	priv->regs =3D regs;
=20
-	priv->regs =3D devm_platform_ioremap_resource(pdev, 0);
-	if (WARN_ON(!priv->regs))
-		return -EIO;
-
-	priv->prio_save =3D devm_bitmap_zalloc(dev, nr_irqs, GFP_KERNEL);
-	if (!priv->prio_save)
-		return -ENOMEM;
+	priv->prio_save =3D bitmap_zalloc(nr_irqs, GFP_KERNEL);
+	if (!priv->prio_save) {
+		error =3D -ENOMEM;
+		goto fail_free_priv;
+	}
=20
 	for (i =3D 0; i < nr_contexts; i++) {
-		error =3D plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu);
+		error =3D plic_parse_context_parent(fwnode, i, &parent_hwirq, &cpu);
 		if (error) {
-			dev_warn(dev, "hwirq for context%d not found\n", i);
+			pr_warn("%pfwP: hwirq for context%d not found\n", fwnode, i);
 			continue;
 		}
=20
@@ -543,7 +550,7 @@ static int plic_probe(struct platform_device *pdev)
 		}
=20
 		if (cpu < 0) {
-			dev_warn(dev, "Invalid cpuid for context %d\n", i);
+			pr_warn("%pfwP: Invalid cpuid for context %d\n", fwnode, i);
 			continue;
 		}
=20
@@ -554,7 +561,7 @@ static int plic_probe(struct platform_device *pdev)
 		 */
 		handler =3D per_cpu_ptr(&plic_handlers, cpu);
 		if (handler->present) {
-			dev_warn(dev, "handler already present for context %d.\n", i);
+			pr_warn("%pfwP: handler already present for context %d.\n", fwnode, i);
 			plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
 			goto done;
 		}
@@ -568,8 +575,8 @@ static int plic_probe(struct platform_device *pdev)
 			i * CONTEXT_ENABLE_SIZE;
 		handler->priv =3D priv;
=20
-		handler->enable_save =3D devm_kcalloc(dev, DIV_ROUND_UP(nr_irqs, 32),
-						    sizeof(*handler->enable_save), GFP_KERNEL);
+		handler->enable_save =3D kcalloc(DIV_ROUND_UP(nr_irqs, 32),
+					       sizeof(*handler->enable_save), GFP_KERNEL);
 		if (!handler->enable_save)
 			goto fail_cleanup_contexts;
 done:
@@ -581,7 +588,7 @@ static int plic_probe(struct platform_device *pdev)
 		nr_handlers++;
 	}
=20
-	priv->irqdomain =3D irq_domain_add_linear(to_of_node(dev->fwnode), nr_irqs =
+ 1,
+	priv->irqdomain =3D irq_domain_add_linear(to_of_node(fwnode), nr_irqs + 1,
 						&plic_irqdomain_ops, priv);
 	if (WARN_ON(!priv->irqdomain))
 		goto fail_cleanup_contexts;
@@ -619,13 +626,13 @@ static int plic_probe(struct platform_device *pdev)
 		}
 	}
=20
-	dev_info(dev, "mapped %d interrupts with %d handlers for %d contexts.\n",
-		 nr_irqs, nr_handlers, nr_contexts);
+	pr_info("%pfwP: mapped %d interrupts with %d handlers for %d contexts.\n",
+		fwnode, nr_irqs, nr_handlers, nr_contexts);
 	return 0;
=20
 fail_cleanup_contexts:
 	for (i =3D 0; i < nr_contexts; i++) {
-		if (plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu))
+		if (plic_parse_context_parent(fwnode, i, &parent_hwirq, &cpu))
 			continue;
 		if (parent_hwirq !=3D RV_IRQ_EXT || cpu < 0)
 			continue;
@@ -634,17 +641,37 @@ static int plic_probe(struct platform_device *pdev)
 		handler->present =3D false;
 		handler->hart_base =3D NULL;
 		handler->enable_base =3D NULL;
+		kfree(handler->enable_save);
 		handler->enable_save =3D NULL;
 		handler->priv =3D NULL;
 	}
-	return -ENOMEM;
+	bitmap_free(priv->prio_save);
+fail_free_priv:
+	kfree(priv);
+fail_free_regs:
+	iounmap(regs);
+	return error;
+}
+
+static int plic_platform_probe(struct platform_device *pdev)
+{
+	return plic_probe(pdev->dev.fwnode);
 }
=20
 static struct platform_driver plic_driver =3D {
 	.driver =3D {
 		.name		=3D "riscv-plic",
 		.of_match_table	=3D plic_match,
+		.suppress_bind_attrs =3D true,
 	},
-	.probe =3D plic_probe,
+	.probe =3D plic_platform_probe,
 };
 builtin_platform_driver(plic_driver);
+
+static int __init plic_early_probe(struct device_node *node,
+				   struct device_node *parent)
+{
+	return plic_probe(&node->fwnode);
+}
+
+IRQCHIP_DECLARE(riscv, "allwinner,sun20i-d1-plic", plic_early_probe);


