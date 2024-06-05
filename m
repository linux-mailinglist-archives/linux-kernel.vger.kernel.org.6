Return-Path: <linux-kernel+bounces-201830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE4B8FC412
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85A70B264F3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A401607A8;
	Wed,  5 Jun 2024 07:02:37 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7765542AA5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717570956; cv=none; b=XISTZrB3UtThYA7dVqGNCLPWFCUpe+RcvFP3UOwTiUPnWjFUEuESAXwZNbbpDqvldE7aJuZaTSECIueUZjSMx/o+nLkdypdBaAOya+QnDNBvGanUbpfxT+M6Fij2asxMIoKHLGTfu0tdgBSiJInh/cs/1q8t3vouOdO6ZfkMPAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717570956; c=relaxed/simple;
	bh=R48qmA9yZgHiNaOTrvqaS0iMbtpTJie3sibyntaVZ3c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qwHO/aJhtSsN6B9+0owDOo5OqqaRF8X9/EpFxQMVf2Ia1IOEvHN0k6BDvpGIMKHIkeTb/zrRESPVrpwGGs/2O6XAX57jVKTv5W2WA36NF1kyqPnhp+uT2g7RFl2181Hy6eG3CAtGqd4q5URPJdnFd348rVk/H5fAN2AJvKzvoL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.185])
	by gateway (Coremail) with SMTP id _____8CxvOqGDWBmj6wDAA--.15625S3;
	Wed, 05 Jun 2024 15:02:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxosSFDWBmzkoVAA--.42528S2;
	Wed, 05 Jun 2024 15:02:30 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: linux-kernel@vger.kernel.org
Cc: chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com,
	tglx@linutronix.de,
	maobibo@loongson.cn
Subject: [PATCH] irqchip/loongson-eiointc: Add extioi virt extension support
Date: Wed,  5 Jun 2024 15:02:29 +0800
Message-Id: <20240605070229.2569875-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxosSFDWBmzkoVAA--.42528S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Currently IRQs can be routed to only 4 vcpus with one Hw extioi.
This patch adds the extioi virt extension support so that IRQs can
be routed to 256 vcpus on hypervior mode.

Now IRQs is emulated in userspace, so the extioi virt device emulation
is implemented in userspace firstly.

See:
  https://patchew.org/QEMU/20240528083855.1912757-1-gaosong@loongson.cn/

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 arch/loongarch/include/asm/irq.h       |  1 +
 drivers/irqchip/irq-loongson-eiointc.c | 75 +++++++++++++++++++++-----
 2 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index 480418bc5071..95542515b66e 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -53,6 +53,7 @@ struct acpi_vector_group {
 extern struct acpi_vector_group pch_group[MAX_IO_PICS];
 extern struct acpi_vector_group msi_group[MAX_IO_PICS];
 
+#define MAX_CORES_PER_EIO_NODE  256
 #define CORES_PER_EIO_NODE	4
 
 #define LOONGSON_CPU_UART0_VEC		10 /* CPU UART0 */
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index c7ddebf312ad..073445d64e3b 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -23,6 +23,16 @@
 #define EIOINTC_REG_ISR		0x1800
 #define EIOINTC_REG_ROUTE	0x1c00
 
+#define EXTIOI_VIRT_FEATURES           0x40000000
+#define  EXTIOI_HAS_VIRT_EXTENSION     0
+#define  EXTIOI_HAS_ENABLE_OPTION      1
+#define  EXTIOI_HAS_INT_ENCODE         2
+#define  EXTIOI_HAS_CPU_ENCODE         3
+#define EXTIOI_VIRT_CONFIG             0x40000004
+#define  EXTIOI_ENABLE                 1
+#define  EXTIOI_ENABLE_INT_ENCODE      2
+#define  EXTIOI_ENABLE_CPU_ENCODE      3
+
 #define VEC_REG_COUNT		4
 #define VEC_COUNT_PER_REG	64
 #define VEC_COUNT		(VEC_REG_COUNT * VEC_COUNT_PER_REG)
@@ -41,6 +51,7 @@ struct eiointc_priv {
 	cpumask_t		cpuspan_map;
 	struct fwnode_handle	*domain_handle;
 	struct irq_domain	*eiointc_domain;
+	bool			cpu_encoded;
 };
 
 static struct eiointc_priv *eiointc_priv[MAX_IO_PICS];
@@ -56,7 +67,9 @@ static void eiointc_enable(void)
 
 static int cpu_to_eio_node(int cpu)
 {
-	return cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
+	int cores = (cpu_has_hypervisor ? MAX_CORES_PER_EIO_NODE : CORES_PER_EIO_NODE);
+
+	return cpu_logical_map(cpu) / cores;
 }
 
 #ifdef CONFIG_SMP
@@ -88,6 +101,20 @@ static void eiointc_set_irq_route(int pos, unsigned int cpu, unsigned int mnode,
 
 static DEFINE_RAW_SPINLOCK(affinity_lock);
 
+static void virt_extioi_set_irq_route(int irq, unsigned int cpu)
+{
+        int data;
+
+        /*
+         * get irq route info for continuous 4 vectors
+         * and set affinity for specified vector
+         */
+        data = iocsr_read32(EIOINTC_REG_ROUTE + (irq & ~3));
+        data &=  ~(0xff << ((irq & 3) * 8));
+        data |= cpu_logical_map(cpu) << ((irq & 3) * 8);
+        iocsr_write32(data, EIOINTC_REG_ROUTE + (irq & ~3));
+}
+
 static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *affinity, bool force)
 {
 	unsigned int cpu;
@@ -106,16 +133,22 @@ static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *af
 	vector = d->hwirq;
 	regaddr = EIOINTC_REG_ENABLE + ((vector >> 5) << 2);
 
-	/* Mask target vector */
-	csr_any_send(regaddr, EIOINTC_ALL_ENABLE & (~BIT(vector & 0x1F)),
-			0x0, priv->node * CORES_PER_EIO_NODE);
-
-	/* Set route for target vector */
-	eiointc_set_irq_route(vector, cpu, priv->node, &priv->node_map);
-
-	/* Unmask target vector */
-	csr_any_send(regaddr, EIOINTC_ALL_ENABLE,
-			0x0, priv->node * CORES_PER_EIO_NODE);
+	if (priv->cpu_encoded) {
+		iocsr_write32(EIOINTC_ALL_ENABLE & ~BIT(vector & 0x1F), regaddr);
+		virt_extioi_set_irq_route(vector, cpu);
+		iocsr_write32(EIOINTC_ALL_ENABLE, regaddr);
+	} else {
+		/* Mask target vector */
+		csr_any_send(regaddr, EIOINTC_ALL_ENABLE & (~BIT(vector & 0x1F)),
+				0x0, priv->node * CORES_PER_EIO_NODE);
+
+		/* Set route for target vector */
+		eiointc_set_irq_route(vector, cpu, priv->node, &priv->node_map);
+
+		/* Unmask target vector */
+		csr_any_send(regaddr, EIOINTC_ALL_ENABLE,
+				0x0, priv->node * CORES_PER_EIO_NODE);
+	}
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
@@ -143,13 +176,14 @@ static int eiointc_router_init(unsigned int cpu)
 	uint32_t data;
 	uint32_t node = cpu_to_eio_node(cpu);
 	int index = eiointc_index(node);
+	int cores = (cpu_has_hypervisor ? MAX_CORES_PER_EIO_NODE : CORES_PER_EIO_NODE);
 
 	if (index < 0) {
 		pr_err("Error: invalid nodemap!\n");
 		return -1;
 	}
 
-	if ((cpu_logical_map(cpu) % CORES_PER_EIO_NODE) == 0) {
+	if ((cpu_logical_map(cpu) % cores) == 0) {
 		eiointc_enable();
 
 		for (i = 0; i < eiointc_priv[0]->vec_count / 32; i++) {
@@ -165,7 +199,9 @@ static int eiointc_router_init(unsigned int cpu)
 
 		for (i = 0; i < eiointc_priv[0]->vec_count / 4; i++) {
 			/* Route to Node-0 Core-0 */
-			if (index == 0)
+			if (eiointc_priv[index]->cpu_encoded)
+				bit = cpu_logical_map(0);
+			else if (index == 0)
 				bit = BIT(cpu_logical_map(0));
 			else
 				bit = (eiointc_priv[index]->node << 4) | 1;
@@ -369,7 +405,7 @@ static int __init acpi_cascade_irqdomain_init(void)
 static int __init eiointc_init(struct eiointc_priv *priv, int parent_irq,
 			       u64 node_map)
 {
-	int i;
+	int i, val;
 
 	node_map = node_map ? node_map : -1ULL;
 	for_each_possible_cpu(i) {
@@ -389,6 +425,17 @@ static int __init eiointc_init(struct eiointc_priv *priv, int parent_irq,
 		return -ENOMEM;
 	}
 
+	if (cpu_has_hypervisor) {
+		val = iocsr_read32(EXTIOI_VIRT_FEATURES);
+		if (val & BIT(EXTIOI_HAS_CPU_ENCODE)) {
+			val = iocsr_read32(EXTIOI_VIRT_CONFIG);
+			val |= BIT(EXTIOI_ENABLE_CPU_ENCODE);
+			iocsr_write32(val, EXTIOI_VIRT_CONFIG);
+			priv->cpu_encoded = true;
+			pr_info("loongson-extioi: enable cpu encodig \n");
+		}
+	}
+
 	eiointc_priv[nr_pics++] = priv;
 	eiointc_router_init(0);
 	irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch, priv);
-- 
2.39.3


