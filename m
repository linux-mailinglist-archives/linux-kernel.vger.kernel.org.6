Return-Path: <linux-kernel+bounces-298728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F246695CAB3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65ECF1F2678E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA4A187547;
	Fri, 23 Aug 2024 10:43:53 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3A4187337;
	Fri, 23 Aug 2024 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724409832; cv=none; b=hbAeaAk+AxwXAoAZ2JG8o22UF5/M6Fx7JgHTMgvYYaDFFDFyKBUqs2KUZpsXv2KzQnucoYxOQ7+NMQFIqhTLsmLj+fij6ruycHUGWiA1ODEbuaB5Hv4r2EJK2t7xDaoAYbDgU7LK+hzEPzSh81hKL0g+9UDrhi7aj/ZpgihQ+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724409832; c=relaxed/simple;
	bh=er47gNbkj+DX5JmX2xGA/2jrxF+dwW9XVxPJL/Vv4YI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uI7Vl+8iMicdkNAnBj2zurqSDGDuHWJEMuSwChVdwpUiIUAWqA1Ii/eWU2LebJdyZHBko+XNPo4JWBHerCXkPE411yY6ZifCr6E6T+pHiTs4DYLOmOdRZOe+Sje8E/eKgsCjNQz27aRiNxGsKPnKyVdCzEJZAgtyzkH6eQNUOzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.10.34])
	by gateway (Coremail) with SMTP id _____8Dx+5rjZ8hmo1YdAA--.25400S3;
	Fri, 23 Aug 2024 18:43:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
	by front1 (Coremail) with SMTP id qMiowMCxC2faZ8hm3TgfAA--.40011S3;
	Fri, 23 Aug 2024 18:43:45 +0800 (CST)
From: Tianyang Zhang <zhangtianyang@loongson.cn>
To: corbet@lwn.net,
	alexs@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tglx@linutronix.de,
	jiaxun.yang@flygoat.com,
	gaoliang@loongson.cn,
	wangliupu@loongson.cn,
	lvjianmin@loongson.cn,
	zhangtianyang@loongson.cn,
	yijun@loongson.cn,
	mhocko@suse.com,
	akpm@linux-foundation.org,
	dianders@chromium.org,
	maobibo@loongson.cn,
	xry111@xry111.site,
	zhaotianrui@loongson.cn,
	nathan@kernel.org,
	yangtiezhu@loongson.cn,
	zhoubinbin@loongson.cn
Cc: loongarch@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v11 7/7] irqchip/loongarch-avec: Add AVEC irqchip support
Date: Fri, 23 Aug 2024 18:43:37 +0800
Message-Id: <20240823104337.25577-2-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240823104337.25577-1-zhangtianyang@loongson.cn>
References: <20240823104337.25577-1-zhangtianyang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxC2faZ8hm3TgfAA--.40011S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3tFWxWr43CF4kKF13Xr4UWrX_yoW8Cw4DCo
	WfZFn8A348Gr17GryrJrs5tFyjq3yUCrZ8Awn3uFsxuayFyF4rK3y7Kw13KFy3Gan5GFsr
	Aay8Wr1fGFZ7trn3l-sFpf9Il3svdjkaLaAFLSUrUUUU5b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUOI7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVW3AVW8Xw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y4
	8IcxkI7VAKI48JM4x0Y40E4IxF1VCIxcxG6Fyj6r4UJwCY1x0262kKe7AKxVWUtVW8ZwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IU5kpnPUUUUU==

Introduce the advanced extended interrupt controllers (AVECINTC). This
feature will allow each core to have 256 independent interrupt vectors
and MSI interrupts can be independently routed to any vector on any CPU.

The whole topology of irqchips in LoongArch machines looks like this if
AVECINTC is supported:

  +-----+     +-----------------------+     +-------+
  | IPI | --> |        CPUINTC        | <-- | Timer |
  +-----+     +-----------------------+     +-------+
               ^          ^          ^
               |          |          |
        +---------+ +----------+ +---------+     +-------+
        | EIOINTC | | AVECINTC | | LIOINTC | <-- | UARTs |
        +---------+ +----------+ +---------+     +-------+
             ^            ^
             |            |
        +---------+  +---------+
        | PCH-PIC |  | PCH-MSI |
        +---------+  +---------+
          ^     ^           ^
          |     |           |
  +---------+ +---------+ +---------+
  | Devices | | PCH-LPC | | Devices |
  +---------+ +---------+ +---------+
                   ^
                   |
              +---------+
              | Devices |
              +---------+

Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Co-developed-by: Liupu Wang <wangliupu@loongson.cn>
Signed-off-by: Liupu Wang <wangliupu@loongson.cn>
Co-developed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
---
 arch/loongarch/Kconfig                 |   1 +
 arch/loongarch/include/asm/irq.h       |   2 +
 arch/loongarch/kernel/paravirt.c       |   5 +
 arch/loongarch/kernel/smp.c            |   6 +
 drivers/irqchip/Makefile               |   2 +-
 drivers/irqchip/irq-loongarch-avec.c   | 425 +++++++++++++++++++++++++
 drivers/irqchip/irq-loongarch-cpu.c    |   5 +-
 drivers/irqchip/irq-loongson-eiointc.c |   3 +
 drivers/irqchip/irq-loongson-pch-msi.c |  14 +
 drivers/irqchip/irq-loongson.h         |   2 +
 include/linux/cpuhotplug.h             |   1 +
 11 files changed, 464 insertions(+), 2 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongarch-avec.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 70f169210b52..0e3abf7b0bd3 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -85,6 +85,7 @@ config LOONGARCH
 	select GENERIC_ENTRY
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_IOREMAP if !ARCH_IOREMAP
+	select GENERIC_IRQ_MATRIX_ALLOCATOR
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index c4835800c8b9..9c2ca785faa9 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -99,6 +99,8 @@ struct acpi_madt_bio_pic;
 struct acpi_madt_msi_pic;
 struct acpi_madt_lpc_pic;
 
+void complete_irq_moving(void);
+
 struct fwnode_handle *get_pch_msi_handle(int pci_segment);
 
 extern struct acpi_madt_lio_pic *acpi_liointc;
diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
index 9c9b75b76f62..4d736a4e488d 100644
--- a/arch/loongarch/kernel/paravirt.c
+++ b/arch/loongarch/kernel/paravirt.c
@@ -134,6 +134,11 @@ static irqreturn_t pv_ipi_interrupt(int irq, void *dev)
 		info->ipi_irqs[IPI_IRQ_WORK]++;
 	}
 
+	if (action & SMP_CLEAR_VECTOR) {
+		complete_irq_moving();
+		info->ipi_irqs[IPI_CLEAR_VECTOR]++;
+	}
+
 	return IRQ_HANDLED;
 }
 
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index ca405ab86aae..4adbbef3450a 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -72,6 +72,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	[IPI_RESCHEDULE] = "Rescheduling interrupts",
 	[IPI_CALL_FUNCTION] = "Function call interrupts",
 	[IPI_IRQ_WORK] = "IRQ work interrupts",
+	[IPI_CLEAR_VECTOR] = "Clear vector interrupts",
 };
 
 void show_ipi_list(struct seq_file *p, int prec)
@@ -248,6 +249,11 @@ static irqreturn_t loongson_ipi_interrupt(int irq, void *dev)
 		per_cpu(irq_stat, cpu).ipi_irqs[IPI_IRQ_WORK]++;
 	}
 
+	if (action & SMP_CLEAR_VECTOR) {
+		complete_irq_moving();
+		per_cpu(irq_stat, cpu).ipi_irqs[IPI_CLEAR_VECTOR]++;
+	}
+
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 15635812b2d6..e3679ec2b9f7 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -110,7 +110,7 @@ obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
 obj-$(CONFIG_TI_PRUSS_INTC)		+= irq-pruss-intc.o
-obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+= irq-loongarch-cpu.o
+obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+= irq-loongarch-cpu.o irq-loongarch-avec.o
 obj-$(CONFIG_LOONGSON_LIOINTC)		+= irq-loongson-liointc.o
 obj-$(CONFIG_LOONGSON_EIOINTC)		+= irq-loongson-eiointc.o
 obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
diff --git a/drivers/irqchip/irq-loongarch-avec.c b/drivers/irqchip/irq-loongarch-avec.c
new file mode 100644
index 000000000000..866624ac0635
--- /dev/null
+++ b/drivers/irqchip/irq-loongarch-avec.c
@@ -0,0 +1,425 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2024 Loongson Technologies, Inc.
+ */
+
+#include <linux/cpuhotplug.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/msi.h>
+#include <linux/radix-tree.h>
+#include <linux/spinlock.h>
+
+#include <asm/loongarch.h>
+#include <asm/setup.h>
+
+#include "irq-msi-lib.h"
+#include "irq-loongson.h"
+
+#define VECTORS_PER_REG		64
+#define IRR_VECTOR_MASK		0xffUL
+#define IRR_INVALID_MASK	0x80000000UL
+#define AVEC_MSG_OFFSET		0x100000
+
+#ifdef CONFIG_SMP
+struct pending_list {
+	struct list_head	head;
+};
+
+static struct cpumask intersect_mask;
+static DEFINE_PER_CPU(struct pending_list, pending_list);
+#endif
+
+static DEFINE_PER_CPU(struct irq_desc * [NR_VECTORS], irq_map);
+
+struct avecintc_chip {
+	raw_spinlock_t		lock;
+	struct fwnode_handle	*fwnode;
+	struct irq_domain	*domain;
+	struct irq_matrix	*vector_matrix;
+	phys_addr_t 		msi_base_addr;
+};
+
+static struct avecintc_chip loongarch_avec;
+
+struct avecintc_data {
+	struct list_head	entry;
+	unsigned int		cpu;
+	unsigned int		vec;
+	unsigned int		prev_cpu;
+	unsigned int		prev_vec;
+	unsigned int		moving;
+};
+
+static inline void avecintc_ack_irq(struct irq_data *d)
+{
+}
+
+static inline void avecintc_mask_irq(struct irq_data *d)
+{
+}
+
+static inline void avecintc_unmask_irq(struct irq_data *d)
+{
+}
+
+#ifdef CONFIG_SMP
+static inline void pending_list_init(int cpu)
+{
+	struct pending_list *plist = per_cpu_ptr(&pending_list, cpu);
+
+	INIT_LIST_HEAD(&plist->head);
+}
+
+static void avecintc_sync(struct avecintc_data *adata)
+{
+	struct pending_list *plist;
+
+	if (cpu_online(adata->prev_cpu)) {
+		plist = per_cpu_ptr(&pending_list, adata->prev_cpu);
+		list_add_tail(&adata->entry, &plist->head);
+		adata->moving = 1;
+		mp_ops.send_ipi_single(adata->prev_cpu, ACTION_CLEAR_VECTOR);
+	}
+}
+
+static int avecintc_set_affinity(struct irq_data *data, const struct cpumask *dest, bool force)
+{
+	int cpu, ret, vector;
+	struct avecintc_data *adata;
+
+	scoped_guard(raw_spinlock, &loongarch_avec.lock) {
+		adata = irq_data_get_irq_chip_data(data);
+
+		if (adata->moving)
+			return -EBUSY;
+
+		if (cpu_online(adata->cpu) && cpumask_test_cpu(adata->cpu, dest))
+			return 0;
+
+		cpumask_and(&intersect_mask, dest, cpu_online_mask);
+
+		ret = irq_matrix_alloc(loongarch_avec.vector_matrix, &intersect_mask, false, &cpu);
+		if (ret < 0)
+			return ret;
+
+		vector = ret;
+		adata->cpu = cpu;
+		adata->vec = vector;
+		per_cpu_ptr(irq_map, adata->cpu)[adata->vec] = irq_data_to_desc(data);
+		avecintc_sync(adata);
+	}
+
+	irq_data_update_effective_affinity(data, cpumask_of(cpu));
+
+	return IRQ_SET_MASK_OK;
+}
+
+static int avecintc_cpu_online(unsigned int cpu)
+{
+	if (!loongarch_avec.vector_matrix)
+		return 0;
+
+	guard(raw_spinlock)(&loongarch_avec.lock);
+
+	irq_matrix_online(loongarch_avec.vector_matrix);
+
+	pending_list_init(cpu);
+
+	return 0;
+}
+
+static int avecintc_cpu_offline(unsigned int cpu)
+{
+	struct pending_list *plist = per_cpu_ptr(&pending_list, cpu);
+
+	if (!loongarch_avec.vector_matrix)
+		return 0;
+
+	guard(raw_spinlock)(&loongarch_avec.lock);
+
+	if (!list_empty(&plist->head))
+		pr_warn("CPU#%d vector is busy\n", cpu);
+
+	irq_matrix_offline(loongarch_avec.vector_matrix);
+
+	return 0;
+}
+
+void complete_irq_moving(void)
+{
+	struct pending_list *plist = this_cpu_ptr(&pending_list);
+	struct avecintc_data *adata, *tdata;
+	int cpu, vector, bias;
+	uint64_t isr;
+
+	guard(raw_spinlock)(&loongarch_avec.lock);
+
+	list_for_each_entry_safe(adata, tdata, &plist->head, entry) {
+		cpu = adata->prev_cpu;
+		vector = adata->prev_vec;
+		bias = vector / VECTORS_PER_REG;
+		switch (bias) {
+		case 0:
+			isr = csr_read64(LOONGARCH_CSR_ISR0);
+			break;
+		case 1:
+			isr = csr_read64(LOONGARCH_CSR_ISR1);
+			break;
+		case 2:
+			isr = csr_read64(LOONGARCH_CSR_ISR2);
+			break;
+		case 3:
+			isr = csr_read64(LOONGARCH_CSR_ISR3);
+			break;
+		}
+
+		if (isr & (1UL << (vector % VECTORS_PER_REG))) {
+			mp_ops.send_ipi_single(cpu, ACTION_CLEAR_VECTOR);
+			continue;
+		}
+		list_del(&adata->entry);
+		irq_matrix_free(loongarch_avec.vector_matrix, cpu, vector, false);
+		this_cpu_write(irq_map[vector], NULL);
+		adata->moving = 0;
+		adata->prev_cpu = adata->cpu;
+		adata->prev_vec = adata->vec;
+	}
+}
+#endif
+
+static void avecintc_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct avecintc_data *adata = irq_data_get_irq_chip_data(d);
+
+	msg->address_hi = 0x0;
+	msg->address_lo = (loongarch_avec.msi_base_addr | (adata->vec & 0xff) << 4)
+			  | ((cpu_logical_map(adata->cpu & 0xffff)) << 12);
+	msg->data = 0x0;
+}
+
+static struct irq_chip avec_irq_controller = {
+	.name			= "AVECINTC",
+	.irq_ack		= avecintc_ack_irq,
+	.irq_mask		= avecintc_mask_irq,
+	.irq_unmask		= avecintc_unmask_irq,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= avecintc_set_affinity,
+#endif
+	.irq_compose_msi_msg	= avecintc_compose_msi_msg,
+};
+
+static void avecintc_irq_dispatch(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irq_desc *d;
+
+	chained_irq_enter(chip, desc);
+
+	while (true) {
+		unsigned long vector = csr_read64(LOONGARCH_CSR_IRR);
+		if (vector & IRR_INVALID_MASK)
+			break;
+
+		vector &= IRR_VECTOR_MASK;
+
+		d = this_cpu_read(irq_map[vector]);
+		if (d) {
+			generic_handle_irq_desc(d);
+		} else {
+			spurious_interrupt();
+			pr_warn("Unexpected IRQ occurs on CPU#%d [vector %ld]\n", smp_processor_id(), vector);
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static int avecintc_alloc_vector(struct irq_data *irqd, struct avecintc_data *adata)
+{
+	int cpu, ret;
+
+	guard(raw_spinlock_irqsave)(&loongarch_avec.lock);
+
+	ret = irq_matrix_alloc(loongarch_avec.vector_matrix, cpu_online_mask, false, &cpu);
+	if (ret < 0)
+		return ret;
+
+	adata->prev_cpu = adata->cpu = cpu;
+	adata->prev_vec = adata->vec = ret;
+	per_cpu_ptr(irq_map, adata->cpu)[adata->vec] = irq_data_to_desc(irqd);
+
+	return 0;
+}
+
+static int avecintc_domain_alloc(struct irq_domain *domain,
+				 unsigned int virq, unsigned int nr_irqs, void *arg)
+{
+	for (unsigned int i = 0; i < nr_irqs; i++) {
+		struct irq_data *irqd = irq_domain_get_irq_data(domain, virq + i);
+		struct avecintc_data *adata = kzalloc(sizeof(*adata), GFP_KERNEL);
+		int ret;
+
+		if (!adata)
+			return -ENOMEM;
+
+		ret = avecintc_alloc_vector(irqd, adata);
+		if (ret < 0) {
+			kfree(adata);
+			return ret;
+		}
+
+		irq_domain_set_info(domain, virq + i, virq + i, &avec_irq_controller,
+				    adata, handle_edge_irq, NULL, NULL);
+		irqd_set_single_target(irqd);
+		irqd_set_affinity_on_activate(irqd);
+	}
+
+	return 0;
+}
+
+static void avecintc_free_vector(struct irq_data *irqd, struct avecintc_data *adata)
+{
+	guard(raw_spinlock_irqsave)(&loongarch_avec.lock);
+
+	per_cpu(irq_map, adata->cpu)[adata->vec] = NULL;
+	irq_matrix_free(loongarch_avec.vector_matrix, adata->cpu, adata->vec, false);
+
+#ifdef CONFIG_SMP
+	if (!adata->moving)
+		return;
+
+	per_cpu(irq_map, adata->prev_cpu)[adata->prev_vec] = NULL;
+	irq_matrix_free(loongarch_avec.vector_matrix, adata->prev_cpu, adata->prev_vec, false);
+	list_del_init(&adata->entry);
+#endif
+}
+
+static void avecintc_domain_free(struct irq_domain *domain,
+				 unsigned int virq, unsigned int nr_irqs)
+{
+	for (unsigned int i = 0; i < nr_irqs; i++) {
+		struct irq_data *d = irq_domain_get_irq_data(domain, virq + i);
+
+		if (d) {
+			struct avecintc_data *adata = irq_data_get_irq_chip_data(d);
+
+			avecintc_free_vector(d, adata);
+			irq_domain_reset_irq_data(d);
+			kfree(adata);
+		}
+	}
+}
+
+static const struct irq_domain_ops avecintc_domain_ops = {
+	.alloc		= avecintc_domain_alloc,
+	.free		= avecintc_domain_free,
+	.select		= msi_lib_irq_domain_select,
+};
+
+static int __init irq_matrix_init(void)
+{
+	loongarch_avec.vector_matrix = irq_alloc_matrix(NR_VECTORS, 0, NR_VECTORS);
+	if (!loongarch_avec.vector_matrix)
+		return -ENOMEM;
+
+	for (int i = 0; i < NR_LEGACY_VECTORS; i++)
+		irq_matrix_assign_system(loongarch_avec.vector_matrix, i, false);
+
+	irq_matrix_online(loongarch_avec.vector_matrix);
+
+	return 0;
+}
+
+static int __init avecintc_init(struct irq_domain *parent)
+{
+	int ret, parent_irq;
+	unsigned long value;
+
+	raw_spin_lock_init(&loongarch_avec.lock);
+
+	loongarch_avec.fwnode = irq_domain_alloc_named_fwnode("AVECINTC");
+	if (!loongarch_avec.fwnode) {
+		pr_err("Unable to allocate domain handle\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	loongarch_avec.domain = irq_domain_create_tree(loongarch_avec.fwnode,
+						       &avecintc_domain_ops, NULL);
+	if (!loongarch_avec.domain) {
+		pr_err("Unable to create IRQ domain\n");
+		ret = -ENOMEM;
+		goto out_free_handle;
+	}
+
+	parent_irq = irq_create_mapping(parent, INT_AVEC);
+	if (!parent_irq) {
+		pr_err("Failed to mapping hwirq\n");
+		ret = -EINVAL;
+		goto out_remove_domain;
+	}
+
+	ret = irq_matrix_init();
+	if (ret < 0) {
+		pr_err("Failed to init irq matrix\n");
+		goto out_remove_domain;
+	}
+	irq_set_chained_handler_and_data(parent_irq, avecintc_irq_dispatch, NULL);
+
+#ifdef CONFIG_SMP
+	pending_list_init(0);
+	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_AVECINTC_STARTING,
+				  "irqchip/loongarch/avecintc:starting",
+				  avecintc_cpu_online, avecintc_cpu_offline);
+#endif
+	value = iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
+	value |= IOCSR_MISC_FUNC_AVEC_EN;
+	iocsr_write64(value, LOONGARCH_IOCSR_MISC_FUNC);
+
+	return ret;
+
+out_remove_domain:
+	irq_domain_remove(loongarch_avec.domain);
+out_free_handle:
+	irq_domain_free_fwnode(loongarch_avec.fwnode);
+out:
+	return ret;
+}
+
+static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
+				     const unsigned long end)
+{
+	struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
+
+	loongarch_avec.msi_base_addr = pchmsi_entry->msg_address - AVEC_MSG_OFFSET;
+
+	return pch_msi_acpi_init_avec(loongarch_avec.domain);
+}
+
+static inline int __init acpi_cascade_irqdomain_init(void)
+{
+	return acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, pch_msi_parse_madt, 1);
+}
+
+int __init avecintc_acpi_init(struct irq_domain *parent)
+{
+	int ret = avecintc_init(parent);
+	if (ret < 0) {
+		pr_err("Failed to init IRQ domain\n");
+		return ret;
+	}
+
+	ret = acpi_cascade_irqdomain_init();
+	if (ret < 0) {
+		pr_err("Failed to init cascade IRQ domain\n");
+		return ret;
+	}
+
+	return ret;
+}
diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 83f7492290a8..bcbd7fd33178 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -140,7 +140,10 @@ static int __init acpi_cascade_irqdomain_init(void)
 	if (r < 0)
 		return r;
 
-	return 0;
+	if (cpu_has_avecint)
+		r = avecintc_acpi_init(irq_domain);
+
+	return r;
 }
 
 static int __init cpuintc_acpi_init(union acpi_subtable_headers *header,
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index c756b7aa8055..e24db71a8783 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -362,6 +362,9 @@ static int __init acpi_cascade_irqdomain_init(void)
 	if (r < 0)
 		return r;
 
+	if (cpu_has_avecint)
+		return 0;
+
 	r = acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, pch_msi_parse_madt, 1);
 	if (r < 0)
 		return r;
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index 0dc14550791d..bd337ecddb40 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -278,4 +278,18 @@ int __init pch_msi_acpi_init(struct irq_domain *parent, struct acpi_madt_msi_pic
 
 	return ret;
 }
+
+int __init pch_msi_acpi_init_avec(struct irq_domain *parent)
+{
+	if (pch_msi_handle[0])
+		return 0;
+
+	pch_msi_handle[0] = parent->fwnode;
+	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
+
+	parent->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	parent->msi_parent_ops = &pch_msi_parent_ops;
+
+	return 0;
+}
 #endif
diff --git a/drivers/irqchip/irq-loongson.h b/drivers/irqchip/irq-loongson.h
index b155f1258ed5..11fa138d1f44 100644
--- a/drivers/irqchip/irq-loongson.h
+++ b/drivers/irqchip/irq-loongson.h
@@ -12,6 +12,7 @@ int liointc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_lio_pic *acpi_liointc);
 int eiointc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_eio_pic *acpi_eiointc);
+int avecintc_acpi_init(struct irq_domain *parent);
 
 int htvec_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_ht_pic *acpi_htvec);
@@ -21,5 +22,6 @@ int pch_pic_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_bio_pic *acpi_pchpic);
 int pch_msi_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_msi_pic *acpi_pchmsi);
+int pch_msi_acpi_init_avec(struct irq_domain *parent);
 
 #endif /* _DRIVERS_IRQCHIP_IRQ_LOONGSON_H */
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index e49807f7805c..55a726d317d4 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -146,6 +146,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_BCM2836_STARTING,
 	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
 	CPUHP_AP_IRQ_EIOINTC_STARTING,
+	CPUHP_AP_IRQ_AVECINTC_STARTING,
 	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 	CPUHP_AP_IRQ_RISCV_IMSIC_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
-- 
2.20.1


