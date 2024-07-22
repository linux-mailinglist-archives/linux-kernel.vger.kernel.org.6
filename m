Return-Path: <linux-kernel+bounces-258774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB472938C88
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A191F24F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8786D176257;
	Mon, 22 Jul 2024 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="TuR8JI1L"
Received: from smtpout143.security-mail.net (smtpout143.security-mail.net [85.31.212.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D893816D31D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641511; cv=none; b=lJTcV/O3W5cGuY5nDm24kSOh+cpBGg59q0Y2ColgAww/Z5AD3aD04QtFG0vmDSG2RVRpEe/trYQzSgj/BHJR2o9aLRbqKEiiOwmUV6wSXMEEr2uNG/VwdEkS7ZpU5OffQixOq7q+raF089XjZKku8Xqf3m2LYx47RZBYhptXar8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641511; c=relaxed/simple;
	bh=wtUIEjp9nl8GBvzI2dMgN5okl7BiS/K6FDMX592+yNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sdsBC4NkCRUDT82yWNt9T++kTJmlO79+7IvtQv8HvEXcML7AJ7mzQhioOJSefDBmKbRn/keqnd8AxEeJ/apMmp/CizYRdv7D8aDwgvCSvkFjGmVhWPs2jpZ1mQH8/jYmKoar4g9VQkBEizPf9bgGyhUz32ZucG0L9jnxM1gEzb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=TuR8JI1L; arc=none smtp.client-ip=85.31.212.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx403.security-mail.net (Postfix) with ESMTP id CEA7948EDE9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641413;
	bh=wtUIEjp9nl8GBvzI2dMgN5okl7BiS/K6FDMX592+yNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TuR8JI1L4ZodMtuazz+okKzLYIoXD8FD2q4TqYRHxJ+X/pm6X+HBdEWhApGiyYh2C
	 99X/jKAdbwWwn7AhjQQhwA6St2TXGWRPyWpBEOcoZXGT3S6utvKn/0EMNCmSQerD4o
	 ummccDvPbx8L/b8T2HPI9Ikq3MLfB1hjnfBMyHSg=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id 8943848EE82; Mon, 22 Jul 2024 11:43:33 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx403.security-mail.net (Postfix) with ESMTPS id ADA9948E46E; Mon, 22 Jul
 2024 11:43:32 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id 75FD040317; Mon, 22 Jul
 2024 11:43:32 +0200 (CEST)
X-Secumail-id: <cea8.669e29c4.a9f71.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Vincent Chardon
 <vincent.chardon@elsys-design.com>
Subject: [RFC PATCH v3 19/37] irqchip: Add irq-kvx-apic-gic driver
Date: Mon, 22 Jul 2024 11:41:30 +0200
Message-ID: <20240722094226.21602-20-ysionneau@kalrayinc.com>
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

Each Cluster of the Coolidge SoC includes an Advanced Programmable
Interrupt Controller (APIC) and Generic Interrupt Controller (GIC).

The APIC GIC acts as an intermediary interrupt controller, muxing/routing
incoming interrupts to cores in the cluster.

The 139 possible input interrupt lines are organized as follows:
 - 128 from the mailbox controller (one it per mailboxes)
 - 1   from the NoC router
 - 5   from IOMMUs
 - 1   from L2 cache DMA job FIFO
 - 1   from cluster watchdog
 - 2   for SECC, DECC
 - 1   from Data NoC

The 72 possible output interrupt lines:
 -  68: 4 interrupts per core (17 cores)
 -  1 for L2 cache controller
 -  3 extra that are for padding

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Co-developed-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:
V1 -> V2:
- removed irq-kvx-itgen driver (moved in its own patch)
- removed irq-kvx-apic-mailbox driver (moved in its own patch)
- removed irq-kvx-core-intc driver (moved in its own patch)
- removed print on probe success

V2 -> V3: update compatible
---
 drivers/irqchip/Kconfig            |   6 +
 drivers/irqchip/Makefile           |   1 +
 drivers/irqchip/irq-kvx-apic-gic.c | 356 +++++++++++++++++++++++++++++
 3 files changed, 363 insertions(+)
 create mode 100644 drivers/irqchip/irq-kvx-apic-gic.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 14464716bacbb..566425731b757 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -332,6 +332,12 @@ config MIPS_GIC
 	select IRQ_DOMAIN_HIERARCHY
 	select MIPS_CM
 
+config KVX_APIC_GIC
+	bool
+	depends on KVX
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+
 config INGENIC_IRQ
 	bool
 	depends on MACH_INGENIC
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d9dc3d99aaa86..f59255947c8ed 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_BCM7120_L2_IRQ)		+= irq-bcm7120-l2.o
 obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o
 obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
 obj-$(CONFIG_MIPS_GIC)			+= irq-mips-gic.o
+obj-$(CONFIG_KVX_APIC_GIC)		+= irq-kvx-apic-gic.o
 obj-$(CONFIG_ARCH_MEDIATEK)		+= irq-mtk-sysirq.o irq-mtk-cirq.o
 obj-$(CONFIG_ARCH_DIGICOLOR)		+= irq-digicolor.o
 obj-$(CONFIG_ARCH_SA1100)		+= irq-sa11x0.o
diff --git a/drivers/irqchip/irq-kvx-apic-gic.c b/drivers/irqchip/irq-kvx-apic-gic.c
new file mode 100644
index 0000000000000..95196bd7ef058
--- /dev/null
+++ b/drivers/irqchip/irq-kvx-apic-gic.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017 - 2022 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Julian Vetter
+ */
+
+#define pr_fmt(fmt)	"kvx_apic_gic: " fmt
+
+#include <linux/of_address.h>
+#include <linux/cpuhotplug.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/spinlock.h>
+#include <linux/irqchip.h>
+#include <linux/of_irq.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/of.h>
+
+/* APIC is organized in 18 groups of 4 output lines
+ * However, the two upper lines are for Secure RM and DMA engine
+ * Thus, we do not have to use them
+ */
+#define KVX_GIC_PER_CPU_IT_COUNT	4
+#define KVX_GIC_INPUT_IT_COUNT		0x9D
+#define KVX_GIC_OUTPUT_IT_COUNT		0x10
+
+/* GIC enable register definitions */
+#define KVX_GIC_ENABLE_OFFSET		0x0
+#define KVX_GIC_ENABLE_ELEM_SIZE	0x1
+#define KVX_GIC_ELEM_SIZE		0x400
+
+/* GIC status lac register definitions */
+#define KVX_GIC_STATUS_LAC_OFFSET	0x120
+#define KVX_GIC_STATUS_LAC_ELEM_SIZE	0x8
+#define KVX_GIC_STATUS_LAC_ARRAY_SIZE	0x3
+
+/**
+ * For each CPU, there is 4 output lines coming from the apic GIC.
+ * We only use 1 line and this structure represent this line.
+ * @base Output line base address
+ * @cpu CPU associated to this line
+ */
+struct gic_out_irq_line {
+	void __iomem *base;
+	unsigned int cpu;
+};
+
+/**
+ * Input irq line.
+ * This structure is used to store the status of the input line and the
+ * associated output line.
+ * @enabled Boolean for line status
+ * @cpu CPU currently receiving this interrupt
+ * @it_num Interrupt number
+ */
+struct gic_in_irq_line {
+	bool enabled;
+	struct gic_out_irq_line *out_line;
+	unsigned int it_num;
+};
+
+/**
+ * struct kvx_apic_gic - kvx apic gic
+ * @base: Base address of the controller
+ * @domain Domain for this controller
+ * @input_nr_irqs: maximum number of supported input interrupts
+ * @cpus: Per cpu interrupt configuration
+ * @output_irq: Array of output irq lines
+ * @input_irq: Array of input irq lines
+ */
+struct kvx_apic_gic {
+	raw_spinlock_t lock;
+	void __iomem *base;
+	struct irq_domain *domain;
+	uint32_t input_nr_irqs;
+	/* For each cpu, there is an output IT line */
+	struct gic_out_irq_line output_irq[KVX_GIC_OUTPUT_IT_COUNT];
+	/* Input interrupt status */
+	struct gic_in_irq_line input_irq[KVX_GIC_INPUT_IT_COUNT];
+};
+
+static int gic_parent_irq;
+
+/**
+ * Enable/Disable an output irq line
+ * This function is used by both mask/unmask to disable/enable the line.
+ */
+static void irq_line_set_enable(struct gic_out_irq_line *irq_line,
+				struct gic_in_irq_line *in_irq_line,
+				int enable)
+{
+	void __iomem *enable_line_addr = irq_line->base +
+	       KVX_GIC_ENABLE_OFFSET +
+	       in_irq_line->it_num * KVX_GIC_ENABLE_ELEM_SIZE;
+
+	writeb((uint8_t) enable ? 1 : 0, enable_line_addr);
+	in_irq_line->enabled = enable;
+}
+
+static void kvx_apic_gic_set_line(struct irq_data *data, int enable)
+{
+	struct kvx_apic_gic *gic = irq_data_get_irq_chip_data(data);
+	unsigned int in_irq = irqd_to_hwirq(data);
+	struct gic_in_irq_line *in_line = &gic->input_irq[in_irq];
+	struct gic_out_irq_line *out_line = in_line->out_line;
+
+	raw_spin_lock(&gic->lock);
+	/* Set line enable on currently assigned cpu */
+	irq_line_set_enable(out_line, in_line, enable);
+	raw_spin_unlock(&gic->lock);
+}
+
+static void kvx_apic_gic_mask(struct irq_data *data)
+{
+	kvx_apic_gic_set_line(data, 0);
+}
+
+static void kvx_apic_gic_unmask(struct irq_data *data)
+{
+	kvx_apic_gic_set_line(data, 1);
+}
+
+#ifdef CONFIG_SMP
+
+static int kvx_apic_gic_set_affinity(struct irq_data *d,
+				     const struct cpumask *cpumask,
+				     bool force)
+{
+	struct kvx_apic_gic *gic = irq_data_get_irq_chip_data(d);
+	unsigned int new_cpu;
+	unsigned int hw_irq = irqd_to_hwirq(d);
+	struct gic_in_irq_line *input_line = &gic->input_irq[hw_irq];
+	struct gic_out_irq_line *new_out_line;
+
+	/* We assume there is only one cpu in the mask */
+	new_cpu = cpumask_first(cpumask);
+	new_out_line = &gic->output_irq[new_cpu];
+
+	raw_spin_lock(&gic->lock);
+
+	/* Nothing to do, line is the same */
+	if (new_out_line == input_line->out_line)
+		goto out;
+
+	/* If old line was enabled, enable the new one before disabling
+	 * the old one
+	 */
+	if (input_line->enabled)
+		irq_line_set_enable(new_out_line, input_line, 1);
+
+	/* Disable it on old line */
+	irq_line_set_enable(input_line->out_line, input_line, 0);
+
+	/* Assign new output line to input IRQ */
+	input_line->out_line = new_out_line;
+
+out:
+	raw_spin_unlock(&gic->lock);
+
+	irq_data_update_effective_affinity(d, cpumask_of(new_cpu));
+
+	return IRQ_SET_MASK_OK;
+}
+#endif
+
+static struct irq_chip kvx_apic_gic_chip = {
+	.name           = "kvx apic gic",
+	.irq_mask	= kvx_apic_gic_mask,
+	.irq_unmask	= kvx_apic_gic_unmask,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = kvx_apic_gic_set_affinity,
+#endif
+};
+
+static int kvx_apic_gic_alloc(struct irq_domain *domain, unsigned int virq,
+				   unsigned int nr_irqs, void *args)
+{
+	int i;
+	struct irq_fwspec *fwspec = args;
+	int hwirq = fwspec->param[0];
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_domain_set_info(domain, virq + i, hwirq + i,
+				    &kvx_apic_gic_chip,
+				    domain->host_data, handle_simple_irq,
+				    NULL, NULL);
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops kvx_apic_gic_domain_ops = {
+	.alloc  = kvx_apic_gic_alloc,
+	.free   = irq_domain_free_irqs_common,
+};
+
+static void irq_line_get_status_lac(struct gic_out_irq_line *out_irq_line,
+			uint64_t status[KVX_GIC_STATUS_LAC_ARRAY_SIZE])
+{
+	int i;
+
+	for (i = 0; i < KVX_GIC_STATUS_LAC_ARRAY_SIZE; i++) {
+		status[i] = readq(out_irq_line->base +
+				  KVX_GIC_STATUS_LAC_OFFSET +
+				  i * KVX_GIC_STATUS_LAC_ELEM_SIZE);
+	}
+}
+
+static void kvx_apic_gic_handle_irq(struct irq_desc *desc)
+{
+	struct kvx_apic_gic *gic_data = irq_desc_get_handler_data(desc);
+	struct gic_out_irq_line *out_line;
+	uint64_t status[KVX_GIC_STATUS_LAC_ARRAY_SIZE];
+	unsigned long irqn, cascade_irq;
+	unsigned long cpu = smp_processor_id();
+
+	out_line = &gic_data->output_irq[cpu];
+
+	irq_line_get_status_lac(out_line, status);
+
+	for_each_set_bit(irqn, (unsigned long *) status,
+			KVX_GIC_STATUS_LAC_ARRAY_SIZE * BITS_PER_LONG) {
+
+		cascade_irq = irq_find_mapping(gic_data->domain, irqn);
+
+		generic_handle_irq(cascade_irq);
+	}
+}
+
+static void __init apic_gic_init(struct kvx_apic_gic *gic)
+{
+	unsigned int cpu, line;
+	struct gic_in_irq_line *input_irq_line;
+	struct gic_out_irq_line *output_irq_line;
+	uint64_t status[KVX_GIC_STATUS_LAC_ARRAY_SIZE];
+
+	/* Initialize all input lines (device -> )*/
+	for (line = 0; line < KVX_GIC_INPUT_IT_COUNT; line++) {
+		input_irq_line = &gic->input_irq[line];
+		input_irq_line->enabled = false;
+		/* All input lines map on output 0 */
+		input_irq_line->out_line = &gic->output_irq[0];
+		input_irq_line->it_num = line;
+	}
+
+	/* Clear all output lines (-> cpus) */
+	for (cpu = 0; cpu < KVX_GIC_OUTPUT_IT_COUNT; cpu++) {
+		output_irq_line = &gic->output_irq[cpu];
+		output_irq_line->cpu = cpu;
+		output_irq_line->base = gic->base +
+			cpu * (KVX_GIC_ELEM_SIZE * KVX_GIC_PER_CPU_IT_COUNT);
+
+		/* Disable all external lines on this core */
+		for (line = 0; line < KVX_GIC_INPUT_IT_COUNT; line++)
+			irq_line_set_enable(output_irq_line,
+					&gic->input_irq[line], 0x0);
+
+		irq_line_get_status_lac(output_irq_line, status);
+	}
+}
+
+static int kvx_gic_starting_cpu(unsigned int cpu)
+{
+	enable_percpu_irq(gic_parent_irq, IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static int kvx_gic_dying_cpu(unsigned int cpu)
+{
+	disable_percpu_irq(gic_parent_irq);
+
+	return 0;
+}
+
+static int __init kvx_init_apic_gic(struct device_node *node,
+				    struct device_node *parent)
+{
+	struct kvx_apic_gic *gic;
+	int ret;
+	unsigned int irq;
+
+	if (!parent) {
+		pr_err("kvx apic gic does not have parent\n");
+		return -EINVAL;
+	}
+
+	gic = kzalloc(sizeof(*gic), GFP_KERNEL);
+	if (!gic)
+		return -ENOMEM;
+
+	if (of_property_read_u32(node, "kalray,intc-nr-irqs",
+						&gic->input_nr_irqs))
+		gic->input_nr_irqs = KVX_GIC_INPUT_IT_COUNT;
+
+	if (WARN_ON(gic->input_nr_irqs > KVX_GIC_INPUT_IT_COUNT)) {
+		ret = -EINVAL;
+		goto err_kfree;
+	}
+
+	gic->base = of_io_request_and_map(node, 0, node->name);
+	if (!gic->base) {
+		ret = -EINVAL;
+		goto err_kfree;
+	}
+
+	raw_spin_lock_init(&gic->lock);
+	apic_gic_init(gic);
+
+	gic->domain = irq_domain_add_linear(node,
+					gic->input_nr_irqs,
+					&kvx_apic_gic_domain_ops,
+					gic);
+	if (!gic->domain) {
+		pr_err("Failed to add IRQ domain\n");
+		ret = -EINVAL;
+		goto err_iounmap;
+	}
+
+	irq = irq_of_parse_and_map(node, 0);
+	if (irq <= 0) {
+		pr_err("unable to parse irq\n");
+		ret = -EINVAL;
+		goto err_irq_domain_remove;
+	}
+
+	irq_set_chained_handler_and_data(irq, kvx_apic_gic_handle_irq,
+								gic);
+
+	gic_parent_irq = irq;
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				"kvx/gic:online",
+				kvx_gic_starting_cpu,
+				kvx_gic_dying_cpu);
+	if (ret < 0) {
+		pr_err("Failed to setup hotplug state");
+		goto err_irq_unmap;
+	}
+
+	return 0;
+
+err_irq_unmap:
+	irq_dispose_mapping(irq);
+err_irq_domain_remove:
+	irq_domain_remove(gic->domain);
+err_iounmap:
+	iounmap(gic->base);
+err_kfree:
+	kfree(gic);
+
+	return ret;
+}
+
+IRQCHIP_DECLARE(kvx_apic_gic, "kalray,coolidge-apic-gic", kvx_init_apic_gic);
-- 
2.45.2






