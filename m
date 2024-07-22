Return-Path: <linux-kernel+bounces-258777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7775F938C8E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37B81F21CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E9B16CD24;
	Mon, 22 Jul 2024 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="bJY+XfgR"
Received: from smtpout45.security-mail.net (smtpout45.security-mail.net [85.31.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D354416CD38
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641516; cv=none; b=bRI1BssNlMIOViZKWeP6VMtENUaRw/IlBavLhOd3RRgHH8gPdVx8P03CXAI2ghfiaKXNf1sBjbz+4nEIUh4zqQXdyvdeS0YrL78MfoSwUsnI5H8FkPdiBOX0U2mlaK4xdCXwBQx32p5XmYmRyL3A9O8i1zjkMm12/3TK+Jk5EbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641516; c=relaxed/simple;
	bh=RextYat3Ge6uyQ+AHL1kM8QnyeEFds56yLW3LRhE70k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0D8dPJOrvJpMcYdix0B6O1MjZF3dt9aIVgQ4QZEWQrp3uMvsMm2SXYAGz1irk741wgr5nDeJCfoXc13X1bDE73KLjGVTJtnn/L6chX+x0ORBnB2LNZDEql1h19XN4+YHb0m6mzTTFceGjf7aQa3fuldlAlBwR5Uyru/nV8WmOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=bJY+XfgR; arc=none smtp.client-ip=85.31.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx301.security-mail.net (Postfix) with ESMTP id DA0B96D2350
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641415;
	bh=RextYat3Ge6uyQ+AHL1kM8QnyeEFds56yLW3LRhE70k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bJY+XfgRrKH12rGSgqkD/9U6lUS45bfjNNV2FD6877hTYpnBDsmgh5l1CdBzm2jlT
	 dB98WhPUabbooQZRvx0xADc0b6MuEFfE/c7cAl3v69T0H0DGoSZwg3q93ZD8I+L8zs
	 pxAPgcxBrz4LuO1IlZZ6GL9D+tKTGV2TebvCh5lY=
Received: from fx301 (localhost [127.0.0.1]) by fx301.security-mail.net
 (Postfix) with ESMTP id BA6E06D2E03; Mon, 22 Jul 2024 11:43:35 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx301.security-mail.net (Postfix) with ESMTPS id 46C446D2BC3; Mon, 22 Jul
 2024 11:43:35 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id 01A7E40317; Mon, 22 Jul
 2024 11:43:35 +0200 (CEST)
X-Secumail-id: <83f3.669e29c7.3a620.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Vincent Chardon
 <vincent.chardon@elsys-design.com>, Jules Maselbas <jmaselbas@zdiv.net>
Subject: [RFC PATCH v3 22/37] irqchip: Add kvx-core-intc core interrupt
 controller driver
Date: Mon, 22 Jul 2024 11:41:33 +0200
Message-ID: <20240722094226.21602-23-ysionneau@kalrayinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722094226.21602-1-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

From: Yann Sionneau <ysionneau@kalrayinc.com>

Each kvx core includes a hardware interrupt controller (core INTC)
with the following features:
 - 32 independent interrupt sources
 - 4-bit priotity level
 - Individual interrupt enable bit
 - Interrupt status bit displaying the pending interrupts
 - Priority management between the 32 interrupts

Among those 32 interrupt sources, the 0-17 and 24-31 are hard-wired to hardware
sources. The remaining interrupt sources can be triggered via software
by directly writing to the ILR SFR.

The hard-wired interrupt sources are the following:
  0: Timer 0
  1: Timer 1
  2: Watchdog
  3: Performance Monitors
  4: APIC GIC line 0
  5: APIC GIC line 1
  6: APIC GIC line 2
  7: APIC GIC line 3
 12: SECC error from memory system
 13: Arithmetic exception (carry and IEEE 754 flags)
 16: Data Asynchronous Memory Error (DAME), raised for DECC/DSYS errors
 17: CLI (Cache Line Invalidation) for L1D or L1I following
     DECC/DSYS/Parity errors
 24-31: IPIs

The APIC GIC lines will be used to route interrupts coming from SoC
peripherals from outside the Cluster to the kvx core. Those peripherals
include USB host controller, eMMC/SD host controller, i2c, spi, PCIe,
IOMMUs etc...

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Co-developed-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Co-developed-by: Jules Maselbas <jmaselbas@zdiv.net>
Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:
V1 -> V2: new patch
- removed print on probe success
V2 -> V3:
- now use generic irq multi-handler
- correctly set hwirq using irq_domain_set_info()
- move core_intc DT node as CPU subnode
---
 drivers/irqchip/Kconfig             |   5 ++
 drivers/irqchip/Makefile            |   1 +
 drivers/irqchip/irq-kvx-core-intc.c | 117 ++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 drivers/irqchip/irq-kvx-core-intc.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index dbac5b4400e02..da1dbd79dab54 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -332,6 +332,11 @@ config MIPS_GIC
 	select IRQ_DOMAIN_HIERARCHY
 	select MIPS_CM
 
+config KVX_CORE_INTC
+	bool
+	depends on KVX
+	select IRQ_DOMAIN
+
 config KVX_APIC_GIC
 	bool
 	depends on KVX
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 16a2f666b788d..30b69db8789f7 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_BCM7120_L2_IRQ)		+= irq-bcm7120-l2.o
 obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o
 obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
 obj-$(CONFIG_MIPS_GIC)			+= irq-mips-gic.o
+obj-$(CONFIG_KVX_CORE_INTC)		+= irq-kvx-core-intc.o
 obj-$(CONFIG_KVX_APIC_GIC)		+= irq-kvx-apic-gic.o
 obj-$(CONFIG_KVX_ITGEN)			+= irq-kvx-itgen.o
 obj-$(CONFIG_KVX_APIC_MAILBOX)		+= irq-kvx-apic-mailbox.o
diff --git a/drivers/irqchip/irq-kvx-core-intc.c b/drivers/irqchip/irq-kvx-core-intc.c
new file mode 100644
index 0000000000000..2f5be973d2b07
--- /dev/null
+++ b/drivers/irqchip/irq-kvx-core-intc.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#define pr_fmt(fmt)	"kvx_core_intc: " fmt
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/processor.h>
+
+#include <asm/irq.h>
+
+#define KVX_CORE_INTC_IRQ	32
+
+static struct irq_domain *root_domain;
+
+static void handle_kvx_irq(struct pt_regs *regs)
+{
+	u32 ilr, ile, cause, hwirq_mask;
+	u8 es_itn, hwirq;
+	unsigned long es;
+
+	ilr = kvx_sfr_get(ILR);
+	ile = kvx_sfr_get(ILE);
+	es = regs->es;
+
+	es_itn = (es & KVX_SFR_ES_ITN_MASK) >> KVX_SFR_ES_ITN_SHIFT;
+	cause = (1 << es_itn);
+
+	hwirq_mask = (ilr & ile) | cause;
+	kvx_sfr_clear_bit(ILR, hwirq_mask);
+
+	while (hwirq_mask) {
+		hwirq = __ffs(hwirq_mask);
+		generic_handle_domain_irq(root_domain, hwirq);
+		hwirq_mask &= ~BIT_ULL(hwirq);
+	}
+
+	kvx_sfr_set_field(PS, IL, 0);
+}
+
+static void kvx_irq_mask(struct irq_data *data)
+{
+	kvx_sfr_clear_bit(ILE, data->hwirq);
+}
+
+static void kvx_irq_unmask(struct irq_data *data)
+{
+	kvx_sfr_set_bit(ILE, data->hwirq);
+}
+
+static struct irq_chip kvx_irq_chip = {
+	.name           = "kvx core Intc",
+	.irq_mask	= kvx_irq_mask,
+	.irq_unmask	= kvx_irq_unmask,
+};
+
+static int kvx_irq_map(struct irq_domain *d, unsigned int irq,
+			 irq_hw_number_t hwirq)
+{
+	/* All interrupts for core are per cpu */
+	irq_set_percpu_devid(irq);
+	irq_domain_set_info(d, irq, hwirq, &kvx_irq_chip, d->host_data,
+			    handle_percpu_devid_irq, NULL, NULL);
+
+	return 0;
+}
+
+static const struct irq_domain_ops kvx_irq_ops = {
+	.xlate = irq_domain_xlate_onecell,
+	.map = kvx_irq_map,
+};
+
+static int __init
+kvx_init_core_intc(struct device_node *intc, struct device_node *parent)
+{
+	uint32_t core_nr_irqs;
+	unsigned long cpuid;
+	int ret;
+
+	ret = kvx_of_parent_cpuid(intc, &cpuid);
+	if (ret)
+		panic("core intc has no CPU parent\n");
+
+	if (smp_processor_id() != cpuid) {
+		fwnode_dev_initialized(of_fwnode_handle(intc), true);
+		return 0;
+	}
+
+	if (of_property_read_u32(intc, "kalray,intc-nr-irqs", &core_nr_irqs))
+		core_nr_irqs = KVX_CORE_INTC_IRQ;
+
+	/* We only have up to 32 interrupts,
+	 * linear is likely to be the best choice
+	 */
+	root_domain = irq_domain_add_linear(intc, core_nr_irqs,
+						&kvx_irq_ops, NULL);
+	if (!root_domain)
+		panic("root irq domain not available\n");
+
+	/*
+	 * Needed for primary domain lookup to succeed
+	 * This is a primary irqchip, and can never have a parent
+	 */
+	irq_set_default_host(root_domain);
+	set_handle_irq(handle_kvx_irq);
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(kvx_core_intc, "kalray,kv3-1-intc", kvx_init_core_intc);
-- 
2.45.2






