Return-Path: <linux-kernel+bounces-226918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D6A9145A8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1BAA286CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7C2745E2;
	Mon, 24 Jun 2024 09:01:43 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B4F12E1D2
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219702; cv=none; b=K4Pn3g+DU8m3cawyjrBS7QbVfjfnVMLrNLxukfIvhSahP1SB/JzyE5prUWCK165sCMHpA48HhWmXL5DMnyPwpqq7nfcoKffuX5p7ttKNdropy3dx2p9Adrr1L5Ui4dOiP4mYJ9GVncDNYbNGtioEW4gIoYnTp/wBA/ASteix7WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219702; c=relaxed/simple;
	bh=OUzc6Pl/zIhmdd2onn0YSHqlDi3lxSWe/2L7t5QGVtI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=k0ghKkWs6Gxag2000NiOfHfMfRsmuUI3+GeUpXP0eWDV0CFZR1eDYQ64M1c2c21+3IR1GRh0Phx6xF5fVygaUe5dtb/9ZceRdP62hBqXitB5m3o2GLpctOIhWfw4FPPcyewt53rUY1eXTZJ5Fd6n8hK8A+QKbNFnupO3zmpsXFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.185])
	by gateway (Coremail) with SMTP id _____8Bx7erqNXlmvncJAA--.38691S3;
	Mon, 24 Jun 2024 17:01:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxacboNXlmbPguAA--.46124S2;
	Mon, 24 Jun 2024 17:01:28 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: linux-kernel@vger.kernel.org
Cc: chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com,
	tglx@linutronix.de,
	maobibo@loongson.cn
Subject: [PATCH v3] irqchip/loongson-eiointc: Add extioi virt extension support
Date: Mon, 24 Jun 2024 16:44:10 +0800
Message-Id: <20240624084410.1026648-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxacboNXlmbPguAA--.46124S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Interrupts can be routed to maximal four virtual CPUs with one external
hardware interrupt. Add the extioi virt extension support so that
Interrupts can be routed to 256 vcpus on hypervior mode.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
v3:
- Introduce V-EIOINTC and update the Chinese document.
- Link to v2: https://lore.kernel.org/all/20240611123348.8374-1-gaosong@loongson.cn/ 

v2:
- Simplify commit messages and code.
- Follow the documented tip tree coding style.
- Add the virtual extended interrupt model to the documentation.
- Link to v1: https://lore.kernel.org/all/20240605070229.2569875-1-gaosong@loongson.cn/

 .../arch/loongarch/irq-chip-model.rst         |  32 ++++++
 .../zh_CN/arch/loongarch/irq-chip-model.rst   |  29 +++++
 arch/loongarch/include/asm/irq.h              |   1 +
 drivers/irqchip/irq-loongson-eiointc.c        | 104 ++++++++++++++----
 4 files changed, 146 insertions(+), 20 deletions(-)

diff --git a/Documentation/arch/loongarch/irq-chip-model.rst b/Documentation/arch/loongarch/irq-chip-model.rst
index 7988f4192363..36435f29e451 100644
--- a/Documentation/arch/loongarch/irq-chip-model.rst
+++ b/Documentation/arch/loongarch/irq-chip-model.rst
@@ -85,6 +85,38 @@ to CPUINTC directly::
     | Devices |
     +---------+
 
+Virtual extended IRQ model
+==========================
+
+In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer interrupt
+go to CPUINTC directly, CPU UARTS interrupts go to PCH-PIC, while all other
+devices interrupts go to PCH-PIC/PCH-MSI and gathered by V-EIOINTC (Virtual
+Extended I/O Interrupt Controller), and then go to CPUINTC directly::
+
+       +-----+    +-------------------+     +-------+
+       | IPI |--> | CPUINTC(0-255vcpu)| <-- | Timer |
+       +-----+    +-------------------+     +-------+
+                            ^
+                            |
+                      +-----------+
+                      | V-EIOINTC |
+                      +-----------+
+                       ^         ^
+                       |         |
+                +---------+ +---------+
+                | PCH-PIC | | PCH-MSI |
+                +---------+ +---------+
+                  ^      ^          ^
+                  |      |          |
+           +--------+ +---------+ +---------+
+           | UARTs  | | Devices | | Devices |
+           +--------+ +---------+ +---------+
+
+
+V-EIOINTC (Virtual Extended I/O Interrupt Controller) is an extension of EIOINTC,
+it only works in hypervior mode. Interrupts can be routed to up to four virtual
+cpus via EIOINTC, but interrupts can be routed to up to 256 virtual cpus via V-EIOINTC.
+
 ACPI-related definitions
 ========================
 
diff --git a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
index f1e9ab18206c..f211ed192bfc 100644
--- a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
+++ b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
@@ -87,6 +87,35 @@ PCH-LPC/PCH-MSI，然后被EIOINTC统一收集，再直接到达CPUINTC::
     | Devices |
     +---------+
 
+虚拟扩展IRQ模型
+===============
+
+在这种模型里面, IPI(Inter-Processor Interrupt) 和CPU本地时钟中断直接发送到CPUINTC,
+CPU串口 (UARTs) 中断发送到PCH-PIC, 而其他所有设备的中断则分别发送到所连接的PCH_PIC/
+PCH-MSI, 然后V-EIOINTC统一收集，再直接到达CPUINTC::
+
+        +-----+    +-------------------+     +-------+
+        | IPI |--> | CPUINTC(0-255vcpu)| <-- | Timer |
+        +-----+    +-------------------+     +-------+
+                             ^
+                             |
+                       +-----------+
+                       | V-EIOINTC |
+                       +-----------+
+                        ^         ^
+                        |         |
+                 +---------+ +---------+
+                 | PCH-PIC | | PCH-MSI |
+                 +---------+ +---------+
+                   ^      ^          ^
+                   |      |          |
+            +--------+ +---------+ +---------+
+            | UARTs  | | Devices | | Devices |
+            +--------+ +---------+ +---------+
+
+V-EIOINTC 是EIOINTC的扩展, 仅工作在hyperisor模式下, 中断经EIOINTC最多可个路由到４个
+虚拟cpu. 但中断经V-EIOINTC最多可个路由到256个虚拟cpu.
+
 ACPI相关的定义
 ==============
 
diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index 480418bc5071..c97a7ab0e56f 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -53,6 +53,7 @@ struct acpi_vector_group {
 extern struct acpi_vector_group pch_group[MAX_IO_PICS];
 extern struct acpi_vector_group msi_group[MAX_IO_PICS];
 
+#define MAX_CORES_PER_EIO_NODE	256
 #define CORES_PER_EIO_NODE	4
 
 #define LOONGSON_CPU_UART0_VEC		10 /* CPU UART0 */
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index c7ddebf312ad..430fda9e8ce5 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -23,15 +23,43 @@
 #define EIOINTC_REG_ISR		0x1800
 #define EIOINTC_REG_ROUTE	0x1c00
 
+#define EXTIOI_VIRT_FEATURES           0x40000000
+#define  EXTIOI_HAS_VIRT_EXTENSION     BIT(0)
+#define  EXTIOI_HAS_ENABLE_OPTION      BIT(1)
+#define  EXTIOI_HAS_INT_ENCODE         BIT(2)
+#define  EXTIOI_HAS_CPU_ENCODE         BIT(3)
+#define EXTIOI_VIRT_CONFIG             0x40000004
+#define  EXTIOI_ENABLE                 BIT(1)
+#define  EXTIOI_ENABLE_INT_ENCODE      BIT(2)
+#define  EXTIOI_ENABLE_CPU_ENCODE      BIT(3)
+
 #define VEC_REG_COUNT		4
 #define VEC_COUNT_PER_REG	64
 #define VEC_COUNT		(VEC_REG_COUNT * VEC_COUNT_PER_REG)
 #define VEC_REG_IDX(irq_id)	((irq_id) / VEC_COUNT_PER_REG)
 #define VEC_REG_BIT(irq_id)     ((irq_id) % VEC_COUNT_PER_REG)
 #define EIOINTC_ALL_ENABLE	0xffffffff
+#define EIOINTC_ALL_ENABLE_VEC_MASK(vector) 	\
+	(EIOINTC_ALL_ENABLE & ~BIT(vector & 0x1F))
+#define EIOINTC_REG_ENABLE_VEC(vector)		\
+	(EIOINTC_REG_ENABLE + ((vector >> 5) << 2))
 
 #define MAX_EIO_NODES		(NR_CPUS / CORES_PER_EIO_NODE)
 
+/*
+ * Routing registers contain four vectors and have an offset of four to
+ * the base. The routing information is 8 bit wide.
+ */
+
+#define EIOINTC_REG_ROUTE_VEC(vector)		\
+	(EIOINTC_REG_ROUTE + (vector & ~0x03))
+
+#define EIOINTC_REG_ROUTE_VEC_SHIFT(vector) 	\
+	((vector & 0x03) << 3)
+
+#define EIOINTC_REG_ROUTE_VEC_MASK(vector)	\
+	(0xff << EIOINTC_REG_ROUTE_VEC_SHIFT(vector))
+
 static int nr_pics;
 
 struct eiointc_priv {
@@ -41,6 +69,7 @@ struct eiointc_priv {
 	cpumask_t		cpuspan_map;
 	struct fwnode_handle	*domain_handle;
 	struct irq_domain	*eiointc_domain;
+	bool			cpu_encoded;
 };
 
 static struct eiointc_priv *eiointc_priv[MAX_IO_PICS];
@@ -56,7 +85,9 @@ static void eiointc_enable(void)
 
 static int cpu_to_eio_node(int cpu)
 {
-	return cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
+	int cores = cpu_has_hypervisor ? MAX_CORES_PER_EIO_NODE : CORES_PER_EIO_NODE;
+
+	return cpu_logical_map(cpu) / cores;
 }
 
 #ifdef CONFIG_SMP
@@ -88,6 +119,16 @@ static void eiointc_set_irq_route(int pos, unsigned int cpu, unsigned int mnode,
 
 static DEFINE_RAW_SPINLOCK(affinity_lock);
 
+static void virt_extioi_set_irq_route(unsigned int vector, unsigned int cpu)
+{
+	unsigned long reg = EIOINTC_REG_ROUTE_VEC(vector);
+	u32 data = iocsr_read32(reg);
+
+	data &= ~EIOINTC_REG_ROUTE_VEC_MASK(vector);
+	data |= cpu_logical_map(cpu) << EIOINTC_REG_ROUTE_VEC_SHIFT(vector);
+	iocsr_write32(data, reg);
+}
+
 static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *affinity, bool force)
 {
 	unsigned int cpu;
@@ -104,18 +145,24 @@ static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *af
 	}
 
 	vector = d->hwirq;
-	regaddr = EIOINTC_REG_ENABLE + ((vector >> 5) << 2);
-
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
+	regaddr = EIOINTC_REG_ENABLE_VEC(vector);
+
+	if (priv->cpu_encoded) {
+		iocsr_write32(EIOINTC_ALL_ENABLE_VEC_MASK(vector), regaddr);
+		virt_extioi_set_irq_route(vector, cpu);
+		iocsr_write32(EIOINTC_ALL_ENABLE, regaddr);
+	} else {
+		/* Mask target vector */
+		csr_any_send(regaddr, EIOINTC_ALL_ENABLE_VEC_MASK(vector),
+			     0x0, priv->node * CORES_PER_EIO_NODE);
+
+		/* Set route for target vector */
+		eiointc_set_irq_route(vector, cpu, priv->node, &priv->node_map);
+
+		/* Unmask target vector */
+		csr_any_send(regaddr, EIOINTC_ALL_ENABLE,
+			     0x0, priv->node * CORES_PER_EIO_NODE);
+	}
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
@@ -139,17 +186,20 @@ static int eiointc_index(int node)
 
 static int eiointc_router_init(unsigned int cpu)
 {
-	int i, bit;
-	uint32_t data;
-	uint32_t node = cpu_to_eio_node(cpu);
-	int index = eiointc_index(node);
+	uint32_t data, node;
+	int i, bit, cores, index;
+
+	node = cpu_to_eio_node(cpu);
+	index = eiointc_index(node);
 
 	if (index < 0) {
 		pr_err("Error: invalid nodemap!\n");
-		return -1;
+		return -EINVAL;
 	}
 
-	if ((cpu_logical_map(cpu) % CORES_PER_EIO_NODE) == 0) {
+	cores = (cpu_has_hypervisor ? MAX_CORES_PER_EIO_NODE : CORES_PER_EIO_NODE);
+
+	if ((cpu_logical_map(cpu) % cores) == 0) {
 		eiointc_enable();
 
 		for (i = 0; i < eiointc_priv[0]->vec_count / 32; i++) {
@@ -165,7 +215,9 @@ static int eiointc_router_init(unsigned int cpu)
 
 		for (i = 0; i < eiointc_priv[0]->vec_count / 4; i++) {
 			/* Route to Node-0 Core-0 */
-			if (index == 0)
+			if (eiointc_priv[index]->cpu_encoded)
+				bit = cpu_logical_map(0);
+			else if (index == 0)
 				bit = BIT(cpu_logical_map(0));
 			else
 				bit = (eiointc_priv[index]->node << 4) | 1;
@@ -369,6 +421,7 @@ static int __init acpi_cascade_irqdomain_init(void)
 static int __init eiointc_init(struct eiointc_priv *priv, int parent_irq,
 			       u64 node_map)
 {
+	u32 val;
 	int i;
 
 	node_map = node_map ? node_map : -1ULL;
@@ -389,6 +442,17 @@ static int __init eiointc_init(struct eiointc_priv *priv, int parent_irq,
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


