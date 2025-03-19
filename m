Return-Path: <linux-kernel+bounces-567575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA70A68809
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18163BE03B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506C6254855;
	Wed, 19 Mar 2025 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyf0LouK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C199253F38
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376650; cv=none; b=nnL3STKyA1PkL/bok2ykrjUoOFaHgs/neVn6WWR0sVGRYFQy4Xj760vkE7FrfiD4SenMd/vcC5h0rK1MSHVPlyG3I3htSGiTw8b5yYbv026JCS72e6ktgrqO9olh+dyKMp6lT7aWBmRIXypu4i9GV+GzSbwMAONrsr1mMrXQ0uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376650; c=relaxed/simple;
	bh=W2yoLk8Z7BUtYz+ArNlwFlFbW8sF7dD0fbRsBx8Eu+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqoMTKYKpm4BUPVHL/Z4iIjrLeYFWyeSic7FsZUnEPb56QiOy0F6jkxMJP7WYF6UpZnz6o039QKiY1G32IeSuIH/+NHc+ylHo56OAnfcJD5tKlDncRPQ5pQkSNahGr7f/uaB6ivqfXiCYf2hEfsdMNNA0z6oNx1mfQnFnI5Kstw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyf0LouK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61497C4CEF4;
	Wed, 19 Mar 2025 09:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376650;
	bh=W2yoLk8Z7BUtYz+ArNlwFlFbW8sF7dD0fbRsBx8Eu+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jyf0LouKyHam0KU0DuG12ewsKYORsvz21Jd4/5AIhKc8oBmYUj4cmqSo2ezylraqV
	 KWqpKb3/kq2fErEXKdG/G7Yd5P+oVTfz7JLv52uuZjFXOd1s4tJQVQS0agdcVtq3tj
	 AA0ZqTMAcRl+J4kXB94a6vCwdRi2hF8veo6zxxi2oSA6XUwIBtRybnpP6+34K1MUsX
	 XxkiEAWJjYSr3Cxb6VbHjSZCA0lafxa25slJl5c47mTfk7aF1JWxwV+roEwqSK+mHG
	 Fqz6ru4+ynN1p7IHMEBzj30gupJ2m/K2DgkPqLMo17vd/oIR54veiIGKBzkuwBKttz
	 E/f/7q163qOxA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH v2 03/57] irqdomain: Rename irq_get_default_host() to irq_get_default_domain()
Date: Wed, 19 Mar 2025 10:28:56 +0100
Message-ID: <20250319092951.37667-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call the irq_domain consistently a domain, not host. Here, rename
irq_get_default_host() to irq_get_default_domain().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/mips/pci/pci-xtalk-bridge.c          | 2 +-
 arch/powerpc/kvm/book3s_hv.c              | 2 +-
 arch/powerpc/kvm/book3s_xive.c            | 2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 arch/powerpc/platforms/pseries/msi.c      | 2 +-
 drivers/irqchip/irq-armada-370-xp.c       | 4 ++--
 include/linux/irqdomain.h                 | 2 +-
 kernel/irq/irqdomain.c                    | 6 +++---
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
index dae856fb3e5b..e00c38620d14 100644
--- a/arch/mips/pci/pci-xtalk-bridge.c
+++ b/arch/mips/pci/pci-xtalk-bridge.c
@@ -620,7 +620,7 @@ static int bridge_probe(struct platform_device *pdev)
 	if (bridge_get_partnum(virt_to_phys((void *)bd->bridge_addr), partnum))
 		return -EPROBE_DEFER; /* not available yet */
 
-	parent = irq_get_default_host();
+	parent = irq_get_default_domain();
 	if (!parent)
 		return -ENODEV;
 	fn = irq_domain_alloc_named_fwnode("BRIDGE");
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 86bff159c51e..19f4d298dd17 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6041,7 +6041,7 @@ static int kvmppc_set_passthru_irq(struct kvm *kvm, int host_irq, int guest_gsi)
 	 * the underlying calls, which will EOI the interrupt in real
 	 * mode, need an HW IRQ number mapped in the XICS IRQ domain.
 	 */
-	host_data = irq_domain_get_irq_data(irq_get_default_host(), host_irq);
+	host_data = irq_domain_get_irq_data(irq_get_default_domain(), host_irq);
 	irq_map->r_hwirq = (unsigned int)irqd_to_hwirq(host_data);
 
 	if (i == pimap->n_mapped)
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 1362c672387e..1302b5ac5672 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -1555,7 +1555,7 @@ int kvmppc_xive_set_mapped(struct kvm *kvm, unsigned long guest_irq,
 	struct kvmppc_xive_src_block *sb;
 	struct kvmppc_xive_irq_state *state;
 	struct irq_data *host_data =
-		irq_domain_get_irq_data(irq_get_default_host(), host_irq);
+		irq_domain_get_irq_data(irq_get_default_domain(), host_irq);
 	unsigned int hw_irq = (unsigned int)irqd_to_hwirq(host_data);
 	u16 idx;
 	u8 prio;
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d2a8e0287811..ae4b549b5ca0 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1881,7 +1881,7 @@ static const struct irq_domain_ops pnv_irq_domain_ops = {
 static int __init pnv_msi_allocate_domains(struct pci_controller *hose, unsigned int count)
 {
 	struct pnv_phb *phb = hose->private_data;
-	struct irq_domain *parent = irq_get_default_host();
+	struct irq_domain *parent = irq_get_default_domain();
 
 	hose->fwnode = irq_domain_alloc_named_id_fwnode("PNV-MSI", phb->opal_id);
 	if (!hose->fwnode)
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index fdc2f7f38dc9..f9d80111c322 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -611,7 +611,7 @@ static const struct irq_domain_ops pseries_irq_domain_ops = {
 static int __pseries_msi_allocate_domains(struct pci_controller *phb,
 					  unsigned int count)
 {
-	struct irq_domain *parent = irq_get_default_host();
+	struct irq_domain *parent = irq_get_default_domain();
 
 	phb->fwnode = irq_domain_alloc_named_id_fwnode("pSeries-MSI",
 						       phb->global_number);
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 6218e5d20b50..2aa6a51e05d0 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -564,7 +564,7 @@ static void mpic_reenable_percpu(struct mpic *mpic)
 
 static int mpic_starting_cpu(unsigned int cpu)
 {
-	struct mpic *mpic = irq_get_default_host()->host_data;
+	struct mpic *mpic = irq_get_default_domain()->host_data;
 
 	mpic_perf_init(mpic);
 	mpic_smp_cpu_init(mpic);
@@ -700,7 +700,7 @@ static void mpic_handle_cascade_irq(struct irq_desc *desc)
 
 static void __exception_irq_entry mpic_handle_irq(struct pt_regs *regs)
 {
-	struct mpic *mpic = irq_get_default_host()->host_data;
+	struct mpic *mpic = irq_get_default_domain()->host_data;
 	irq_hw_number_t i;
 	u32 irqstat;
 
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 4b5c495b5710..e9ab95fbc5a9 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -353,7 +353,7 @@ struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
 struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 					    enum irq_domain_bus_token bus_token);
 void irq_set_default_domain(struct irq_domain *domain);
-struct irq_domain *irq_get_default_host(void);
+struct irq_domain *irq_get_default_domain(void);
 int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
 			   irq_hw_number_t hwirq, int node,
 			   const struct irq_affinity_desc *affinity);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 480fdc9e769e..9d5c8651492d 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -590,7 +590,7 @@ void irq_set_default_domain(struct irq_domain *domain)
 EXPORT_SYMBOL_GPL(irq_set_default_domain);
 
 /**
- * irq_get_default_host() - Retrieve the "default" irq domain
+ * irq_get_default_domain() - Retrieve the "default" irq domain
  *
  * Returns: the default domain, if any.
  *
@@ -598,11 +598,11 @@ EXPORT_SYMBOL_GPL(irq_set_default_domain);
  * systems that cannot implement a firmware->fwnode mapping (which
  * both DT and ACPI provide).
  */
-struct irq_domain *irq_get_default_host(void)
+struct irq_domain *irq_get_default_domain(void)
 {
 	return irq_default_domain;
 }
-EXPORT_SYMBOL_GPL(irq_get_default_host);
+EXPORT_SYMBOL_GPL(irq_get_default_domain);
 
 static bool irq_domain_is_nomap(struct irq_domain *domain)
 {
-- 
2.49.0


