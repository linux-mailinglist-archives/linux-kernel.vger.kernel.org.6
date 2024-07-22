Return-Path: <linux-kernel+bounces-258736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED30938C38
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF40F281E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BC916D4C6;
	Mon, 22 Jul 2024 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="mqfThSte"
Received: from smtpout145.security-mail.net (smtpout145.security-mail.net [85.31.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61C016CD3A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641420; cv=none; b=QcmwEX27kl4/mf0xx5wcFpkxkVGKn1zrsWvucc7mA52Mjg8I8l8YG2nEjr0rFRqZ9rBbbHT989npdN+33LolZb/hVTf/D1DrKQ6cNXPCKeLW0GHBjkJZ2Vwoi5I+HXfUmxG8JppnnnTzQoInf8GZGzrNmLfy2Z/Mzp6z0h3cLyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641420; c=relaxed/simple;
	bh=L96ODBHo6UR6sT6ZF6s0e8YDw+7iW1MS0z104V6XW2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCM8ujcshbssdUE1ntj3sokytcnJcYwuCYYnfcL7GqAEepf35kje463H9wHoGxoT5zZPWtu5LNy1Im61cLeGeqzv03bXj/sYqX3/OTfF5bE92lUB8ou4wKx7mWULXF6ojf62XRPsm4RYZKx0KUec3+suRwVp8PsGkaICItBGDNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=mqfThSte; arc=none smtp.client-ip=85.31.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx405.security-mail.net [127.0.0.1])
	by fx405.security-mail.net (Postfix) with ESMTP id 109F2335F4D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641416;
	bh=L96ODBHo6UR6sT6ZF6s0e8YDw+7iW1MS0z104V6XW2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mqfThSte/Q7qp2WfoN8PcJB7qJ59t7ULhup44eZz0ORc7OV/YV2vdYDjZYmbmT60E
	 D+XVLFSt1FN8H+p5DNAVEFbh6Kj3Vh2OWOxh9+Uf4ujDiL8lgaeyIN1bEBGr/TTbal
	 TiJEM4wyz7wOK/a7JqyjRSNdpYpAv47sd5jkLLvA=
Received: from fx405 (fx405.security-mail.net [127.0.0.1]) by
 fx405.security-mail.net (Postfix) with ESMTP id 99E6B335E3E; Mon, 22 Jul
 2024 11:43:35 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx405.security-mail.net (Postfix) with ESMTPS id 67BD2335DAF; Mon, 22 Jul
 2024 11:43:34 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id 32E8740317; Mon, 22 Jul
 2024 11:43:34 +0200 (CEST)
X-Secumail-id: <8c76.669e29c6.63f6b.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Jules Maselbas <jmaselbas@zdiv.net>, Luc
 Michel <luc@lmichel.fr>
Subject: [RFC PATCH v3 21/37] irqchip: Add irq-kvx-apic-mailbox driver
Date: Mon, 22 Jul 2024 11:41:32 +0200
Message-ID: <20240722094226.21602-22-ysionneau@kalrayinc.com>
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

The APIC includes a mailbox controller, containing 128 mailboxes.
Each mailbox is an 8-byte word.
Each mailbox can be independently configured with a trigger condition
and an input function.
After a write to a mailbox if the trigger condition is met, an
interrupt will be generated.
Since this hardware block generates IRQs based on writes at some memory
locations, it is both an interrupt-controller and an MSI controller.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Jules Maselbas <jmaselbas@zdiv.net>
Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Co-developed-by: Luc Michel <luc@lmichel.fr>
Signed-off-by: Luc Michel <luc@lmichel.fr>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:
V1 -> V2:
- new patch
- removed print on probe success

V2 -> V3: update compatible
---
 drivers/irqchip/Kconfig                |   8 +
 drivers/irqchip/Makefile               |   1 +
 drivers/irqchip/irq-kvx-apic-mailbox.c | 480 +++++++++++++++++++++++++
 3 files changed, 489 insertions(+)
 create mode 100644 drivers/irqchip/irq-kvx-apic-mailbox.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index bf06506d611d5..dbac5b4400e02 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -346,6 +346,14 @@ config KVX_ITGEN
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 
+config KVX_APIC_MAILBOX
+       bool
+       depends on KVX
+       select GENERIC_IRQ_IPI if SMP
+       select GENERIC_MSI_IRQ_DOMAIN
+       select IRQ_DOMAIN
+       select IRQ_DOMAIN_HIERARCHY
+
 config INGENIC_IRQ
 	bool
 	depends on MACH_INGENIC
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index b2c514faf9bf7..16a2f666b788d 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
 obj-$(CONFIG_MIPS_GIC)			+= irq-mips-gic.o
 obj-$(CONFIG_KVX_APIC_GIC)		+= irq-kvx-apic-gic.o
 obj-$(CONFIG_KVX_ITGEN)			+= irq-kvx-itgen.o
+obj-$(CONFIG_KVX_APIC_MAILBOX)		+= irq-kvx-apic-mailbox.o
 obj-$(CONFIG_ARCH_MEDIATEK)		+= irq-mtk-sysirq.o irq-mtk-cirq.o
 obj-$(CONFIG_ARCH_DIGICOLOR)		+= irq-digicolor.o
 obj-$(CONFIG_ARCH_SA1100)		+= irq-sa11x0.o
diff --git a/drivers/irqchip/irq-kvx-apic-mailbox.c b/drivers/irqchip/irq-kvx-apic-mailbox.c
new file mode 100644
index 0000000000000..6f0e9134db2ff
--- /dev/null
+++ b/drivers/irqchip/irq-kvx-apic-mailbox.c
@@ -0,0 +1,480 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Jules Maselbas
+ */
+
+#define pr_fmt(fmt)	"kvx_apic_mailbox: " fmt
+
+#include <linux/irqchip/chained_irq.h>
+#include <linux/of_address.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/iommu.h>
+#include <linux/irqchip.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/init.h>
+#include <linux/msi.h>
+#include <linux/of.h>
+
+#define KVX_MAILBOX_MODE_WRITE  0x0
+#define KVX_MAILBOX_MODE_OR  0x1
+#define KVX_MAILBOX_MODE_ADD  0x2
+
+#define KVX_MAILBOX_TRIG_NO_TRIG 0x0
+#define KVX_MAILBOX_TRIG_DOORBELL 0x1
+#define KVX_MAILBOX_TRIG_MATCH 0x2
+#define KVX_MAILBOX_TRIG_BARRIER 0x3
+#define KVX_MAILBOX_TRIG_THRESHOLD 0x4
+
+#define KVX_MAILBOX_OFFSET 0x0
+#define KVX_MAILBOX_ELEM_SIZE 0x200
+#define KVX_MAILBOX_MASK_OFFSET     0x10
+#define KVX_MAILBOX_FUNCT_OFFSET     0x18
+#define KVX_MAILBOX_LAC_OFFSET     0x8
+#define KVX_MAILBOX_VALUE_OFFSET     0x0
+#define KVX_MAILBOX_FUNCT_MODE_SHIFT  0x0
+#define KVX_MAILBOX_FUNCT_TRIG_SHIFT 0x8
+
+#define MAILBOXES_MAX_COUNT 128
+
+/* Mailboxes are 64 bits wide */
+#define MAILBOXES_BIT_SIZE 64
+
+/* Maximum number of mailboxes available */
+#define MAILBOXES_MAX_BIT_COUNT (MAILBOXES_MAX_COUNT * MAILBOXES_BIT_SIZE)
+
+/* Mailboxes are grouped by 8 in a single page */
+#define MAILBOXES_BITS_PER_PAGE (8 * MAILBOXES_BIT_SIZE)
+
+/**
+ * struct mb_data - per mailbox data
+ * @cpu: CPU on which the mailbox is routed
+ * @parent_irq: Parent IRQ on the GIC
+ */
+struct mb_data {
+	unsigned int cpu;
+	unsigned int parent_irq;
+};
+
+/**
+ * struct kvx_apic_mailbox - kvx apic mailbox
+ * @base: base address of the controller
+ * @device_domain: IRQ device domain for mailboxes
+ * @msi_domain: platform MSI domain for MSI interface
+ * @domain_info: Domain information needed for the MSI domain
+ * @mb_count: Count of mailboxes we are handling
+ * @available: bitmap of availables bits in mailboxes
+ * @mailboxes_lock: lock for irq migration
+ * @mask_lock: lock for irq masking
+ * @mb_data: data associated to each mailbox
+ */
+struct kvx_apic_mailbox {
+	void __iomem *base;
+	phys_addr_t phys_base;
+	struct irq_domain *device_domain;
+	struct irq_domain *msi_domain;
+	struct msi_domain_info domain_info;
+	/* Start and count of device mailboxes */
+	unsigned int mb_count;
+	/* Bitmap of allocated bits in mailboxes */
+	DECLARE_BITMAP(available, MAILBOXES_MAX_BIT_COUNT);
+	spinlock_t mailboxes_lock;
+	raw_spinlock_t mask_lock;
+	struct mb_data mb_data[MAILBOXES_MAX_COUNT];
+};
+
+/**
+ * struct kvx_irq_data - per irq data
+ * @mb: Mailbox structure
+ */
+struct kvx_irq_data {
+	struct kvx_apic_mailbox *mb;
+};
+
+static void kvx_mailbox_get_from_hwirq(unsigned int hw_irq,
+				       unsigned int *mailbox_num,
+				       unsigned int *mailbox_bit)
+{
+	*mailbox_num = hw_irq / MAILBOXES_BIT_SIZE;
+	*mailbox_bit = hw_irq % MAILBOXES_BIT_SIZE;
+}
+
+static void __iomem *kvx_mailbox_get_addr(struct kvx_apic_mailbox *mb,
+				   unsigned int num)
+{
+	return mb->base + (num * KVX_MAILBOX_ELEM_SIZE);
+}
+
+static phys_addr_t kvx_mailbox_get_phys_addr(struct kvx_apic_mailbox *mb,
+				   unsigned int num)
+{
+	return mb->phys_base + (num * KVX_MAILBOX_ELEM_SIZE);
+}
+
+static void kvx_mailbox_msi_compose_msg(struct irq_data *data,
+					struct msi_msg *msg)
+{
+	struct kvx_irq_data *kd = irq_data_get_irq_chip_data(data);
+	struct kvx_apic_mailbox *mb = kd->mb;
+	unsigned int mb_num, mb_bit;
+	phys_addr_t mb_addr;
+
+	kvx_mailbox_get_from_hwirq(irqd_to_hwirq(data), &mb_num, &mb_bit);
+	mb_addr = kvx_mailbox_get_phys_addr(mb, mb_num);
+
+	msg->address_hi = upper_32_bits(mb_addr);
+	msg->address_lo = lower_32_bits(mb_addr);
+	msg->data = mb_bit;
+
+	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
+}
+
+static void kvx_mailbox_set_irq_enable(struct irq_data *data,
+				     bool enabled)
+{
+	struct kvx_irq_data *kd = irq_data_get_irq_chip_data(data);
+	struct kvx_apic_mailbox *mb = kd->mb;
+	unsigned int mb_num, mb_bit;
+	void __iomem *mb_addr;
+	u64 mask_value, mb_value;
+
+	kvx_mailbox_get_from_hwirq(irqd_to_hwirq(data), &mb_num, &mb_bit);
+	mb_addr = kvx_mailbox_get_addr(mb, mb_num);
+
+	raw_spin_lock(&mb->mask_lock);
+	mask_value = readq(mb_addr + KVX_MAILBOX_MASK_OFFSET);
+	if (enabled)
+		mask_value |= BIT_ULL(mb_bit);
+	else
+		mask_value &= ~BIT_ULL(mb_bit);
+
+	writeq(mask_value, mb_addr + KVX_MAILBOX_MASK_OFFSET);
+
+	raw_spin_unlock(&mb->mask_lock);
+
+	/**
+	 * Since interrupts on mailboxes are edge triggered and are only
+	 * triggered when writing the value, we need to trigger it manually
+	 * after updating the mask if enabled. If the interrupt was triggered by
+	 * the device just after the mask write, we can trigger a spurious
+	 * interrupt but that is still better than missing one...
+	 * Moreover, the mailbox is configured in OR mode which means that even
+	 * if we write a single bit, all other bits will be kept intact.
+	 */
+	if (enabled) {
+		mb_value = readq(mb_addr + KVX_MAILBOX_VALUE_OFFSET);
+		if (mb_value & BIT_ULL(mb_bit))
+			writeq(BIT_ULL(mb_bit),
+			       mb_addr + KVX_MAILBOX_VALUE_OFFSET);
+	}
+}
+
+static void kvx_mailbox_mask(struct irq_data *data)
+{
+	kvx_mailbox_set_irq_enable(data, false);
+}
+
+static void kvx_mailbox_unmask(struct irq_data *data)
+{
+	kvx_mailbox_set_irq_enable(data, true);
+}
+
+static void kvx_mailbox_set_cpu(struct kvx_apic_mailbox *mb, int mb_id,
+			       int new_cpu)
+{
+	irq_set_affinity(mb->mb_data[mb_id].parent_irq, cpumask_of(new_cpu));
+	mb->mb_data[mb_id].cpu = new_cpu;
+}
+
+static void kvx_mailbox_free_bit(struct kvx_apic_mailbox *mb, int hw_irq)
+{
+	unsigned int mb_num, mb_bit;
+
+	kvx_mailbox_get_from_hwirq(hw_irq, &mb_num, &mb_bit);
+	bitmap_clear(mb->available, hw_irq, 1);
+
+	/* If there is no more IRQ on this mailbox, reset it to CPU 0 */
+	if (mb->available[mb_num] == 0)
+		kvx_mailbox_set_cpu(mb, mb_num, 0);
+}
+
+struct irq_chip kvx_apic_mailbox_irq_chip = {
+	.name = "kvx apic mailbox",
+	.irq_compose_msi_msg = kvx_mailbox_msi_compose_msg,
+	.irq_mask = kvx_mailbox_mask,
+	.irq_unmask = kvx_mailbox_unmask,
+};
+
+static int kvx_mailbox_allocate_bits(struct kvx_apic_mailbox *mb, int num_req)
+{
+	int first, align_mask = 0;
+
+	/* This must be a power of 2 for bitmap_find_next_zero_area to work */
+	BUILD_BUG_ON((MAILBOXES_BITS_PER_PAGE & (MAILBOXES_BITS_PER_PAGE - 1)));
+
+	/*
+	 * If user requested more than 1 mailbox, we must make sure it will be
+	 * aligned on a page size for iommu_dma_prepare_msi to be correctly
+	 * mapped in a single page.
+	 */
+	if (num_req > 1)
+		align_mask = (MAILBOXES_BITS_PER_PAGE - 1);
+
+	spin_lock(&mb->mailboxes_lock);
+
+	first = bitmap_find_next_zero_area(mb->available,
+			mb->mb_count * MAILBOXES_BIT_SIZE, 0,
+			num_req, align_mask);
+	if (first >= MAILBOXES_MAX_BIT_COUNT) {
+		spin_unlock(&mb->mailboxes_lock);
+		return -ENOSPC;
+	}
+
+	bitmap_set(mb->available, first, num_req);
+
+	spin_unlock(&mb->mailboxes_lock);
+
+	return first;
+}
+
+static int kvx_apic_mailbox_msi_alloc(struct irq_domain *domain,
+				      unsigned int virq,
+				      unsigned int nr_irqs, void *args)
+{
+	int i, err;
+	int hwirq = 0;
+	u64 mb_addr;
+	struct irq_data *d;
+	struct kvx_irq_data *kd;
+	struct kvx_apic_mailbox *mb = domain->host_data;
+	struct msi_alloc_info *msi_info = (struct msi_alloc_info *)args;
+	struct msi_desc *desc = msi_info->desc;
+	unsigned int mb_num, mb_bit;
+
+	/* We will not be able to guarantee page alignment ! */
+	if (nr_irqs > MAILBOXES_BITS_PER_PAGE)
+		return -EINVAL;
+
+	hwirq = kvx_mailbox_allocate_bits(mb, nr_irqs);
+	if (hwirq < 0)
+		return hwirq;
+
+	kvx_mailbox_get_from_hwirq(hwirq, &mb_num, &mb_bit);
+	mb_addr = (u64) kvx_mailbox_get_phys_addr(mb, mb_num);
+	err = iommu_dma_prepare_msi(desc, mb_addr);
+	if (err)
+		goto free_mb_bits;
+
+	for (i = 0; i < nr_irqs; i++) {
+		kd = kmalloc(sizeof(*kd), GFP_KERNEL);
+		if (!kd) {
+			err = -ENOMEM;
+			goto free_irq_data;
+		}
+
+		kd->mb = mb;
+		irq_domain_set_info(domain, virq + i, hwirq + i,
+				    &kvx_apic_mailbox_irq_chip,
+				    kd, handle_simple_irq,
+				    NULL, NULL);
+	}
+
+	return 0;
+
+free_irq_data:
+	for (i--; i >= 0; i--) {
+		d = irq_domain_get_irq_data(domain, virq + i);
+		kd = irq_data_get_irq_chip_data(d);
+		kfree(kd);
+	}
+
+free_mb_bits:
+	spin_lock(&mb->mailboxes_lock);
+	bitmap_clear(mb->available, hwirq, nr_irqs);
+	spin_unlock(&mb->mailboxes_lock);
+
+	return err;
+}
+
+static void kvx_apic_mailbox_msi_free(struct irq_domain *domain,
+				      unsigned int virq,
+				      unsigned int nr_irqs)
+{
+	int i;
+	struct irq_data *d;
+	struct kvx_irq_data *kd;
+	struct kvx_apic_mailbox *mb = domain->host_data;
+
+	spin_lock(&mb->mailboxes_lock);
+
+	for (i = 0; i < nr_irqs; i++) {
+		d = irq_domain_get_irq_data(domain, virq + i);
+		kd = irq_data_get_irq_chip_data(d);
+		kfree(kd);
+		kvx_mailbox_free_bit(mb, d->hwirq);
+	}
+
+	spin_unlock(&mb->mailboxes_lock);
+}
+
+static const struct irq_domain_ops kvx_apic_mailbox_domain_ops = {
+	.alloc  = kvx_apic_mailbox_msi_alloc,
+	.free	= kvx_apic_mailbox_msi_free
+};
+
+static struct irq_chip kvx_msi_irq_chip = {
+	.name	= "KVX MSI",
+};
+
+static void kvx_apic_mailbox_handle_irq(struct irq_desc *desc)
+{
+	struct irq_data *data = irq_desc_get_irq_data(desc);
+	struct kvx_apic_mailbox *mb = irq_desc_get_handler_data(desc);
+	void __iomem *mb_addr = kvx_mailbox_get_addr(mb, irqd_to_hwirq(data));
+	unsigned int irqn, cascade_irq, bit;
+	u64 mask_value, masked_its;
+	u64 mb_value;
+	/* Since we allocate 64 interrupts for each mailbox, the scheme
+	 * to find the hwirq associated to a mailbox irq is the
+	 * following:
+	 * hw_irq = mb_num * MAILBOXES_BIT_SIZE + bit
+	 */
+	unsigned int mb_hwirq = irqd_to_hwirq(data) * MAILBOXES_BIT_SIZE;
+
+	mb_value = readq(mb_addr + KVX_MAILBOX_LAC_OFFSET);
+	mask_value = readq(mb_addr + KVX_MAILBOX_MASK_OFFSET);
+	/* Mask any disabled interrupts */
+	mb_value &= mask_value;
+
+	/**
+	 * Write all pending ITs that are masked to process them later
+	 * Since the mailbox is in OR mode, these bits will be merged with any
+	 * already set bits and thus avoid losing any interrupts.
+	 */
+	masked_its = (~mask_value) & mb_value;
+	if (masked_its)
+		writeq(masked_its, mb_addr + KVX_MAILBOX_LAC_OFFSET);
+
+	for_each_set_bit(bit, (unsigned long *) &mb_value, BITS_PER_LONG) {
+		irqn = bit + mb_hwirq;
+		cascade_irq = irq_find_mapping(mb->device_domain, irqn);
+		generic_handle_irq(cascade_irq);
+	}
+}
+
+static void __init
+apic_mailbox_reset(struct kvx_apic_mailbox *mb)
+{
+	unsigned int i;
+	unsigned int mb_end = mb->mb_count;
+	void __iomem *mb_addr;
+	u64 funct_val = (KVX_MAILBOX_MODE_OR << KVX_MAILBOX_FUNCT_MODE_SHIFT) |
+		(KVX_MAILBOX_TRIG_DOORBELL << KVX_MAILBOX_FUNCT_TRIG_SHIFT);
+
+	for (i = 0; i < mb_end; i++) {
+		mb_addr = kvx_mailbox_get_addr(mb, i);
+		/* Disable all interrupts */
+		writeq(0ULL, mb_addr + KVX_MAILBOX_MASK_OFFSET);
+		/* Set mailbox to OR mode + trigger */
+		writeq(funct_val, mb_addr + KVX_MAILBOX_FUNCT_OFFSET);
+		/* Load & Clear mailbox value */
+		readq(mb_addr + KVX_MAILBOX_LAC_OFFSET);
+	}
+}
+
+static struct msi_domain_ops kvx_msi_domain_ops = {
+};
+
+static struct msi_domain_info kvx_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
+	.ops	= &kvx_msi_domain_ops,
+	.chip	= &kvx_msi_irq_chip,
+};
+
+static int __init
+kvx_init_apic_mailbox(struct device_node *node,
+		      struct device_node *parent)
+{
+	struct kvx_apic_mailbox *mb;
+	unsigned int parent_irq, irq_count;
+	struct resource res;
+	int ret, i;
+
+	mb = kzalloc(sizeof(*mb), GFP_KERNEL);
+	if (!mb)
+		return -ENOMEM;
+
+	ret = of_address_to_resource(node, 0, &res);
+	if (ret)
+		return -EINVAL;
+
+	mb->phys_base = res.start;
+	mb->base = of_io_request_and_map(node, 0, node->name);
+	if (!mb->base) {
+		ret = -EINVAL;
+		goto err_kfree;
+	}
+
+	spin_lock_init(&mb->mailboxes_lock);
+	raw_spin_lock_init(&mb->mask_lock);
+
+	irq_count = of_irq_count(node);
+	if (irq_count == 0 || irq_count > MAILBOXES_MAX_COUNT) {
+		ret = -EINVAL;
+		goto err_kfree;
+	}
+	mb->mb_count = irq_count;
+
+	apic_mailbox_reset(mb);
+
+	mb->device_domain = irq_domain_add_tree(node,
+						&kvx_apic_mailbox_domain_ops,
+						mb);
+	if (!mb->device_domain) {
+		pr_err("Failed to setup device domain\n");
+		ret = -EINVAL;
+		goto err_iounmap;
+	}
+
+	mb->msi_domain = platform_msi_create_irq_domain(of_node_to_fwnode(node),
+						     &kvx_msi_domain_info,
+						     mb->device_domain);
+	if (!mb->msi_domain) {
+		ret = -EINVAL;
+		goto err_irq_domain_add_tree;
+	}
+
+	/* Chain all interrupts from gic to mailbox */
+	for (i = 0; i < irq_count; i++) {
+		parent_irq = irq_of_parse_and_map(node, i);
+		if (parent_irq == 0) {
+			pr_err("unable to parse irq\n");
+			ret = -EINVAL;
+			goto err_irq_domain_msi_create;
+		}
+		mb->mb_data[i].parent_irq = parent_irq;
+
+		irq_set_chained_handler_and_data(parent_irq,
+						 kvx_apic_mailbox_handle_irq,
+						 mb);
+	}
+
+	return 0;
+
+err_irq_domain_msi_create:
+	irq_domain_remove(mb->msi_domain);
+err_irq_domain_add_tree:
+	irq_domain_remove(mb->device_domain);
+err_iounmap:
+	iounmap(mb->base);
+err_kfree:
+	kfree(mb);
+
+	return ret;
+}
+
+IRQCHIP_DECLARE(kvx_apic_mailbox, "kalray,coolidge-apic-mailbox",
+		kvx_init_apic_mailbox);
-- 
2.45.2






