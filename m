Return-Path: <linux-kernel+bounces-287871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F01B952D72
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0CE1F25F72
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713647DA87;
	Thu, 15 Aug 2024 11:26:25 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6B91714C7;
	Thu, 15 Aug 2024 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721183; cv=none; b=lkUEGYnVrwa2HWxtmpnT6xFO+JUd76qiJv5O5IRfOqrqiYUnIVfxNHY9VDAvug/5n39ssRgkkFFyF9UIAVDmL3juQvF/wa0sBIPa1gNG+bYliKahM1cF97yMcAcHnQCwcGUkvuRsbffdPOvbRgJXFCCtt7iZwGdxNmEY4AsOYVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721183; c=relaxed/simple;
	bh=q3vkPy4T7mbjF+x5fyskpB4/4T8eGbH7g+VwXS7RsMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvzzc/IvO5BpWmbkV8uu3U0qFCLZ6ZkXzWhdQGsvUlYyTSyk1JbBmTZGSiHu2xD0BHamgJsibUNG7vFZ7xYRQzn87yzxadz4rmupAnYjdw/SC7j4FOjQhIs2Js55GkaXOjuGSVQCGqiFTRbvb4pvSi81vqGWhLkC9aFIRq+yWRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.10.34])
	by gateway (Coremail) with SMTP id _____8CxKJra5b1moMgUAA--.11687S3;
	Thu, 15 Aug 2024 19:26:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
	by front1 (Coremail) with SMTP id qMiowMAxVODU5b1mwT4VAA--.33702S4;
	Thu, 15 Aug 2024 19:26:17 +0800 (CST)
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
Subject: [PATCH v10 2/2] irqchip/loongarch-avec: Add AVEC irqchip support
Date: Thu, 15 Aug 2024 19:26:08 +0800
Message-Id: <20240815112608.26925-3-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240815112608.26925-1-zhangtianyang@loongson.cn>
References: <20240815112608.26925-1-zhangtianyang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxVODU5b1mwT4VAA--.33702S4
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9fXoWfuFy5CryfJw4xWrW3WF1kXrc_yoW5ZF1rWo
	WfZF1Yy348Gr45urZ8Jw1qqFWUZr4qkrWkA3srua13CayxAF15KryUKw13KFy3Grs5GFZx
	CayfWrn3Jayxtrn5l-sFpf9Il3svdjkaLaAFLSUrUUUU5b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYZ7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4YLvDUUUU

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
 .../arch/loongarch/irq-chip-model.rst         |  32 ++
 .../zh_CN/arch/loongarch/irq-chip-model.rst   |  32 ++
 arch/loongarch/Kconfig                        |   1 +
 arch/loongarch/include/asm/cpu-features.h     |   1 +
 arch/loongarch/include/asm/cpu.h              |   2 +
 arch/loongarch/include/asm/hardirq.h          |   3 +-
 arch/loongarch/include/asm/hw_irq.h           |   2 +
 arch/loongarch/include/asm/irq.h              |  25 +-
 arch/loongarch/include/asm/loongarch.h        |  18 +-
 arch/loongarch/include/asm/smp.h              |   2 +
 arch/loongarch/kernel/cpu-probe.c             |   3 +-
 arch/loongarch/kernel/irq.c                   |  15 +-
 arch/loongarch/kernel/paravirt.c              |   5 +
 arch/loongarch/kernel/smp.c                   |   6 +
 drivers/irqchip/Makefile                      |   2 +-
 drivers/irqchip/irq-loongarch-avec.c          | 426 ++++++++++++++++++
 drivers/irqchip/irq-loongarch-cpu.c           |   5 +-
 drivers/irqchip/irq-loongson-eiointc.c        |   7 +-
 drivers/irqchip/irq-loongson-pch-msi.c        |  24 +-
 include/linux/cpuhotplug.h                    |   3 +-
 20 files changed, 591 insertions(+), 23 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongarch-avec.c

diff --git a/Documentation/arch/loongarch/irq-chip-model.rst b/Documentation/arch/loongarch/irq-chip-model.rst
index 7988f4192363..6dd48256e39f 100644
--- a/Documentation/arch/loongarch/irq-chip-model.rst
+++ b/Documentation/arch/loongarch/irq-chip-model.rst
@@ -85,6 +85,38 @@ to CPUINTC directly::
     | Devices |
     +---------+
 
+Advanced Extended IRQ model
+===========================
+
+In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer interrupt go
+to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, PCH-MSI interrupts go
+to AVECINTC, and then go to CPUINTC directly, while all other devices interrupts
+go to PCH-PIC/PCH-LPC and gathered by EIOINTC, and then go to CPUINTC directly::
+
+ +-----+     +-----------------------+     +-------+
+ | IPI | --> |        CPUINTC        | <-- | Timer |
+ +-----+     +-----------------------+     +-------+
+              ^          ^          ^
+              |          |          |
+       +---------+ +----------+ +---------+     +-------+
+       | EIOINTC | | AVECINTC | | LIOINTC | <-- | UARTs |
+       +---------+ +----------+ +---------+     +-------+
+            ^            ^
+            |            |
+       +---------+  +---------+
+       | PCH-PIC |  | PCH-MSI |
+       +---------+  +---------+
+         ^     ^           ^
+         |     |           |
+ +---------+ +---------+ +---------+
+ | Devices | | PCH-LPC | | Devices |
+ +---------+ +---------+ +---------+
+                  ^
+                  |
+             +---------+
+             | Devices |
+             +---------+
+
 ACPI-related definitions
 ========================
 
diff --git a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
index f1e9ab18206c..472761938682 100644
--- a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
+++ b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
@@ -87,6 +87,38 @@ PCH-LPC/PCH-MSI，然后被EIOINTC统一收集，再直接到达CPUINTC::
     | Devices |
     +---------+
 
+高级扩展IRQ模型
+===============
+
+在这种模型里面，IPI（Inter-Processor Interrupt）和CPU本地时钟中断直接发送到CPUINTC，
+CPU串口（UARTs）中断发送到LIOINTC，PCH-MSI中断发送到AVECINTC，而后通过AVECINTC直接
+送达CPUINTC，而其他所有设备的中断则分别发送到所连接的PCH-PIC/PCH-LPC，然后由EIOINTC
+统一收集，再直接到达CPUINTC::
+
+ +-----+     +-----------------------+     +-------+
+ | IPI | --> |        CPUINTC        | <-- | Timer |
+ +-----+     +-----------------------+     +-------+
+              ^          ^          ^
+              |          |          |
+       +---------+ +----------+ +---------+     +-------+
+       | EIOINTC | | AVECINTC | | LIOINTC | <-- | UARTs |
+       +---------+ +----------+ +---------+     +-------+
+            ^            ^
+            |            |
+       +---------+  +---------+
+       | PCH-PIC |  | PCH-MSI |
+       +---------+  +---------+
+         ^     ^           ^
+         |     |           |
+ +---------+ +---------+ +---------+
+ | Devices | | PCH-LPC | | Devices |
+ +---------+ +---------+ +---------+
+                  ^
+                  |
+             +---------+
+             | Devices |
+             +---------+
+
 ACPI相关的定义
 ==============
 
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
diff --git a/arch/loongarch/include/asm/cpu-features.h b/arch/loongarch/include/asm/cpu-features.h
index 2eafe6a6aca8..16a716f88a5c 100644
--- a/arch/loongarch/include/asm/cpu-features.h
+++ b/arch/loongarch/include/asm/cpu-features.h
@@ -65,5 +65,6 @@
 #define cpu_has_guestid		cpu_opt(LOONGARCH_CPU_GUESTID)
 #define cpu_has_hypervisor	cpu_opt(LOONGARCH_CPU_HYPERVISOR)
 #define cpu_has_ptw		cpu_opt(LOONGARCH_CPU_PTW)
+#define cpu_has_avecint		cpu_opt(LOONGARCH_CPU_AVECINT)
 
 #endif /* __ASM_CPU_FEATURES_H */
diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include/asm/cpu.h
index 48b9f7168bcc..843f9c4ec980 100644
--- a/arch/loongarch/include/asm/cpu.h
+++ b/arch/loongarch/include/asm/cpu.h
@@ -99,6 +99,7 @@ enum cpu_type_enum {
 #define CPU_FEATURE_GUESTID		24	/* CPU has GuestID feature */
 #define CPU_FEATURE_HYPERVISOR		25	/* CPU has hypervisor (running in VM) */
 #define CPU_FEATURE_PTW			26	/* CPU has hardware page table walker */
+#define CPU_FEATURE_AVECINT		27	/* CPU has avec interrupt */
 
 #define LOONGARCH_CPU_CPUCFG		BIT_ULL(CPU_FEATURE_CPUCFG)
 #define LOONGARCH_CPU_LAM		BIT_ULL(CPU_FEATURE_LAM)
@@ -127,5 +128,6 @@ enum cpu_type_enum {
 #define LOONGARCH_CPU_GUESTID		BIT_ULL(CPU_FEATURE_GUESTID)
 #define LOONGARCH_CPU_HYPERVISOR	BIT_ULL(CPU_FEATURE_HYPERVISOR)
 #define LOONGARCH_CPU_PTW		BIT_ULL(CPU_FEATURE_PTW)
+#define LOONGARCH_CPU_AVECINT		BIT_ULL(CPU_FEATURE_AVECINT)
 
 #endif /* _ASM_CPU_H */
diff --git a/arch/loongarch/include/asm/hardirq.h b/arch/loongarch/include/asm/hardirq.h
index 1d7feb719515..10da8d6961cb 100644
--- a/arch/loongarch/include/asm/hardirq.h
+++ b/arch/loongarch/include/asm/hardirq.h
@@ -12,12 +12,13 @@
 extern void ack_bad_irq(unsigned int irq);
 #define ack_bad_irq ack_bad_irq
 
-#define NR_IPI	3
+#define NR_IPI	4
 
 enum ipi_msg_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNCTION,
 	IPI_IRQ_WORK,
+	IPI_CLEAR_VECTOR,
 };
 
 typedef struct {
diff --git a/arch/loongarch/include/asm/hw_irq.h b/arch/loongarch/include/asm/hw_irq.h
index af4f4e8fbd85..8156ffb67415 100644
--- a/arch/loongarch/include/asm/hw_irq.h
+++ b/arch/loongarch/include/asm/hw_irq.h
@@ -9,6 +9,8 @@
 
 extern atomic_t irq_err_count;
 
+#define ARCH_IRQ_INIT_FLAGS	IRQ_NOPROBE
+
 /*
  * interrupt-retrigger: NOP for now. This may not be appropriate for all
  * machines, we'll see ...
diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index 480418bc5071..1b255bf8168f 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -39,11 +39,22 @@ void spurious_interrupt(void);
 
 #define NR_IRQS_LEGACY 16
 
+/*
+ * 256 Vectors Mapping for AVECINTC:
+ *
+ * 0 - 15: Mapping classic IPs, e.g. IP0-12.
+ * 16 - 255: Mapping vectors for external IRQ.
+ *
+ */
+#define NR_VECTORS		256
+#define NR_LEGACY_VECTORS	16
+#define IRQ_MATRIX_BITS		NR_VECTORS
+
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 void arch_trigger_cpumask_backtrace(const struct cpumask *mask, int exclude_cpu);
 
 #define MAX_IO_PICS 2
-#define NR_IRQS	(64 + (256 * MAX_IO_PICS))
+#define NR_IRQS	(64 + NR_VECTORS * (NR_CPUS + MAX_IO_PICS))
 
 struct acpi_vector_group {
 	int node;
@@ -65,7 +76,7 @@ extern struct acpi_vector_group msi_group[MAX_IO_PICS];
 #define LOONGSON_LPC_LAST_IRQ		(LOONGSON_LPC_IRQ_BASE + 15)
 
 #define LOONGSON_CPU_IRQ_BASE		16
-#define LOONGSON_CPU_LAST_IRQ		(LOONGSON_CPU_IRQ_BASE + 14)
+#define LOONGSON_CPU_LAST_IRQ		(LOONGSON_CPU_IRQ_BASE + 15)
 
 #define LOONGSON_PCH_IRQ_BASE		64
 #define LOONGSON_PCH_ACPI_IRQ		(LOONGSON_PCH_IRQ_BASE + 47)
@@ -92,15 +103,21 @@ int liointc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_lio_pic *acpi_liointc);
 int eiointc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_eio_pic *acpi_eiointc);
+int avecintc_acpi_init(struct irq_domain *parent);
+
+void complete_irq_moving(void);
 
 int htvec_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_ht_pic *acpi_htvec);
 int pch_lpc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_lpc_pic *acpi_pchlpc);
-int pch_msi_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_msi_pic *acpi_pchmsi);
 int pch_pic_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_bio_pic *acpi_pchpic);
+int pch_msi_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_msi_pic *acpi_pchmsi);
+int pch_msi_acpi_init_v2(struct irq_domain *parent,
+					struct acpi_madt_msi_pic *acpi_pchmsi);
+
 int find_pch_pic(u32 gsi);
 struct fwnode_handle *get_pch_msi_handle(int pci_segment);
 
diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 04a78010fc72..70834a47257d 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -253,8 +253,8 @@
 #define  CSR_ESTAT_EXC_WIDTH		6
 #define  CSR_ESTAT_EXC			(_ULCAST_(0x3f) << CSR_ESTAT_EXC_SHIFT)
 #define  CSR_ESTAT_IS_SHIFT		0
-#define  CSR_ESTAT_IS_WIDTH		14
-#define  CSR_ESTAT_IS			(_ULCAST_(0x3fff) << CSR_ESTAT_IS_SHIFT)
+#define  CSR_ESTAT_IS_WIDTH		15
+#define  CSR_ESTAT_IS			(_ULCAST_(0x7fff) << CSR_ESTAT_IS_SHIFT)
 
 #define LOONGARCH_CSR_ERA		0x6	/* ERA */
 
@@ -649,6 +649,13 @@
 
 #define LOONGARCH_CSR_CTAG		0x98	/* TagLo + TagHi */
 
+#define LOONGARCH_CSR_ISR0		0xa0
+#define LOONGARCH_CSR_ISR1		0xa1
+#define LOONGARCH_CSR_ISR2		0xa2
+#define LOONGARCH_CSR_ISR3		0xa3
+
+#define	LOONGARCH_CSR_IRR		0xa4
+
 #define LOONGARCH_CSR_PRID		0xc0
 
 /* Shadow MCSR : 0xc0 ~ 0xff */
@@ -1011,7 +1018,7 @@
 /*
  * CSR_ECFG IM
  */
-#define ECFG0_IM		0x00001fff
+#define ECFG0_IM		0x00005fff
 #define ECFGB_SIP0		0
 #define ECFGF_SIP0		(_ULCAST_(1) << ECFGB_SIP0)
 #define ECFGB_SIP1		1
@@ -1054,6 +1061,7 @@
 #define  IOCSRF_EIODECODE		BIT_ULL(9)
 #define  IOCSRF_FLATMODE		BIT_ULL(10)
 #define  IOCSRF_VM			BIT_ULL(11)
+#define  IOCSRF_AVEC			BIT_ULL(15)
 
 #define LOONGARCH_IOCSR_VENDOR		0x10
 
@@ -1065,6 +1073,7 @@
 #define  IOCSR_MISC_FUNC_SOFT_INT	BIT_ULL(10)
 #define  IOCSR_MISC_FUNC_TIMER_RESET	BIT_ULL(21)
 #define  IOCSR_MISC_FUNC_EXT_IOI_EN	BIT_ULL(48)
+#define  IOCSR_MISC_FUNC_AVEC_EN	BIT_ULL(51)
 
 #define LOONGARCH_IOCSR_CPUTEMP		0x428
 
@@ -1387,9 +1396,10 @@ __BUILD_CSR_OP(tlbidx)
 #define INT_TI		11	/* Timer */
 #define INT_IPI		12
 #define INT_NMI		13
+#define INT_AVEC	14
 
 /* ExcCodes corresponding to interrupts */
-#define EXCCODE_INT_NUM		(INT_NMI + 1)
+#define EXCCODE_INT_NUM		(INT_AVEC + 1)
 #define EXCCODE_INT_START	64
 #define EXCCODE_INT_END		(EXCCODE_INT_START + EXCCODE_INT_NUM - 1)
 
diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
index 50db503f44e3..3383c9d24e94 100644
--- a/arch/loongarch/include/asm/smp.h
+++ b/arch/loongarch/include/asm/smp.h
@@ -70,10 +70,12 @@ extern int __cpu_logical_map[NR_CPUS];
 #define ACTION_RESCHEDULE	1
 #define ACTION_CALL_FUNCTION	2
 #define ACTION_IRQ_WORK		3
+#define ACTION_CLEAR_VECTOR	4
 #define SMP_BOOT_CPU		BIT(ACTION_BOOT_CPU)
 #define SMP_RESCHEDULE		BIT(ACTION_RESCHEDULE)
 #define SMP_CALL_FUNCTION	BIT(ACTION_CALL_FUNCTION)
 #define SMP_IRQ_WORK		BIT(ACTION_IRQ_WORK)
+#define SMP_CLEAR_VECTOR	BIT(ACTION_CLEAR_VECTOR)
 
 struct secondary_data {
 	unsigned long stack;
diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index 55320813ee08..14f0449f5452 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -106,7 +106,6 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
 		elf_hwcap |= HWCAP_LOONGARCH_CRC32;
 	}
 
-
 	config = read_cpucfg(LOONGARCH_CPUCFG2);
 	if (config & CPUCFG2_LAM) {
 		c->options |= LOONGARCH_CPU_LAM;
@@ -174,6 +173,8 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
 		c->options |= LOONGARCH_CPU_FLATMODE;
 	if (config & IOCSRF_EIODECODE)
 		c->options |= LOONGARCH_CPU_EIODECODE;
+	if (config & IOCSRF_AVEC)
+		c->options |= LOONGARCH_CPU_AVECINT;
 	if (config & IOCSRF_VM)
 		c->options |= LOONGARCH_CPU_HYPERVISOR;
 
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index f4991c03514f..d129039b368b 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -87,6 +87,18 @@ static void __init init_vec_parent_group(void)
 	acpi_table_parse(ACPI_SIG_MCFG, early_pci_mcfg_parse);
 }
 
+int __init arch_probe_nr_irqs(void)
+{
+	int nr_io_pics = bitmap_weight(loongson_sysconf.cores_io_master, NR_CPUS);
+
+	if (!cpu_has_avecint)
+		nr_irqs = (64 + NR_VECTORS * nr_io_pics);
+	else
+		nr_irqs = (64 + NR_VECTORS * (nr_cpu_ids + nr_io_pics));
+
+	return NR_IRQS_LEGACY;
+}
+
 void __init init_IRQ(void)
 {
 	int i;
@@ -102,9 +114,6 @@ void __init init_IRQ(void)
 	mp_ops.init_ipi();
 #endif
 
-	for (i = 0; i < NR_IRQS; i++)
-		irq_set_noprobe(i);
-
 	for_each_possible_cpu(i) {
 		page = alloc_pages_node(cpu_to_node(i), GFP_KERNEL, order);
 
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
index 000000000000..d66fae41d95a
--- /dev/null
+++ b/drivers/irqchip/irq-loongarch-avec.c
@@ -0,0 +1,426 @@
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
+
+#define VECTORS_PER_REG		64
+#define IRR_VECTOR_MASK		0xffUL
+#define IRR_INVALID_MASK	0x80000000UL
+#define AVEC_MSG_OFFSET		0x100000
+
+static phys_addr_t msi_base_addr;
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
+	struct fwnode_handle	*fwnode;
+	struct irq_domain	*domain;
+	struct irq_matrix	*vector_matrix;
+	raw_spinlock_t		lock;
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
+	unsigned int		moving		: 1,
+				managed		: 1;
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
+	unsigned int cpu, ret, vector;
+	struct avecintc_data *adata;
+
+	scoped_guard(raw_spinlock, &loongarch_avec.lock) {
+		adata = irq_data_get_irq_chip_data(data);
+
+		if (adata->moving)
+			return -EBUSY;
+
+		if (adata->vec == UINT_MAX)
+			return -EINVAL;
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
+		irq_matrix_free(loongarch_avec.vector_matrix, cpu, vector, adata->managed);
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
+	msg->address_lo = (msi_base_addr | (adata->vec & 0xff) << 4) |
+			  ((cpu_logical_map(adata->cpu & 0xffff)) << 12);
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
+static int avecintc_domain_alloc(struct irq_domain *domain,
+				 unsigned int virq, unsigned int nr_irqs, void *arg)
+{
+	guard(raw_spinlock_irqsave)(&loongarch_avec.lock);
+
+	for (unsigned int i = 0; i < nr_irqs; i++) {
+		struct irq_data *irqd = irq_domain_get_irq_data(domain, virq + i);
+		struct avecintc_data *adata = kzalloc(sizeof(*adata), GFP_KERNEL);
+		unsigned int cpu, ret;
+
+		if (!adata)
+			return -ENOMEM;
+
+		ret = irq_matrix_alloc(loongarch_avec.vector_matrix, cpu_online_mask, false, &cpu);
+		if (ret < 0) {
+			kfree(adata);
+			return ret;
+		}
+
+		adata->moving = 0;
+		adata->prev_cpu = adata->cpu = cpu;
+		adata->prev_vec = adata->vec = ret;
+		adata->managed = irqd_affinity_is_managed(irqd);
+		irq_domain_set_info(domain, virq + i, virq + i, &avec_irq_controller,
+				    adata, handle_edge_irq, NULL, NULL);
+		irqd_set_single_target(irqd);
+		irqd_set_affinity_on_activate(irqd);
+
+		per_cpu_ptr(irq_map, adata->cpu)[adata->vec] = irq_data_to_desc(irqd);
+	}
+
+	return 0;
+}
+
+static void clear_free_vector(struct irq_data *irqd)
+{
+	struct avecintc_data *adata = irq_data_get_irq_chip_data(irqd);
+	bool managed = irqd_affinity_is_managed(irqd);
+
+	per_cpu(irq_map, adata->cpu)[adata->vec] = NULL;
+	irq_matrix_free(loongarch_avec.vector_matrix, adata->cpu, adata->vec, managed);
+	adata->cpu = UINT_MAX;
+	adata->vec = UINT_MAX;
+
+#ifdef CONFIG_SMP
+	if (!adata->moving)
+		return;
+
+	per_cpu(irq_map, adata->prev_cpu)[adata->prev_vec] = NULL;
+	irq_matrix_free(loongarch_avec.vector_matrix,
+			adata->prev_cpu, adata->prev_vec, adata->managed);
+	adata->moving = 0;
+	adata->prev_vec = UINT_MAX;
+	adata->prev_cpu = UINT_MAX;
+	list_del_init(&adata->entry);
+#endif
+	kfree(adata);
+}
+
+static void avecintc_domain_free(struct irq_domain *domain,
+				 unsigned int virq, unsigned int nr_irqs)
+{
+	guard(raw_spinlock_irqsave)(&loongarch_avec.lock);
+
+	for (unsigned int i = 0; i < nr_irqs; i++) {
+		struct irq_data *d = irq_domain_get_irq_data(domain, virq + i);
+		if (d) {
+			clear_free_vector(d);
+			irq_domain_reset_irq_data(d);
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
+	msi_base_addr = pchmsi_entry->msg_address - AVEC_MSG_OFFSET;
+
+	return pch_msi_acpi_init_v2(loongarch_avec.domain, pchmsi_entry);
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
index 9d8f2c406043..4fdc490b94c3 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -138,7 +138,10 @@ static int __init acpi_cascade_irqdomain_init(void)
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
index b1f2080be2be..895d15b96669 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -360,6 +360,9 @@ static int __init acpi_cascade_irqdomain_init(void)
 	if (r < 0)
 		return r;
 
+	if (cpu_has_avecint)
+		return 0;
+
 	r = acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, pch_msi_parse_madt, 1);
 	if (r < 0)
 		return r;
@@ -396,8 +399,8 @@ static int __init eiointc_init(struct eiointc_priv *priv, int parent_irq,
 
 	if (nr_pics == 1) {
 		register_syscore_ops(&eiointc_syscore_ops);
-		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
-					  "irqchip/loongarch/intc:starting",
+		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_EIOINTC_STARTING,
+					  "irqchip/loongarch/eiointc:starting",
 					  eiointc_router_init, NULL);
 	}
 
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index 2242f63c66fc..a56127314ecc 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -254,17 +254,17 @@ IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_msi_of_init);
 #ifdef CONFIG_ACPI
 struct fwnode_handle *get_pch_msi_handle(int pci_segment)
 {
-	int i;
+	if (cpu_has_avecint)
+		return pch_msi_handle[0];
 
-	for (i = 0; i < MAX_IO_PICS; i++) {
+	for (int i = 0; i < MAX_IO_PICS; i++) {
 		if (msi_group[i].pci_segment == pci_segment)
 			return pch_msi_handle[i];
 	}
-	return NULL;
+	return pch_msi_handle[0];
 }
 
-int __init pch_msi_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_msi_pic *acpi_pchmsi)
+int __init pch_msi_acpi_init(struct irq_domain *parent, struct acpi_madt_msi_pic *acpi_pchmsi)
 {
 	int ret;
 	struct fwnode_handle *domain_handle;
@@ -277,4 +277,18 @@ int __init pch_msi_acpi_init(struct irq_domain *parent,
 
 	return ret;
 }
+
+int __init pch_msi_acpi_init_v2(struct irq_domain *parent, struct acpi_madt_msi_pic *acpi_pchmsi)
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
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 51ba681b915a..55a726d317d4 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -145,7 +145,8 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_ARMADA_XP_STARTING,
 	CPUHP_AP_IRQ_BCM2836_STARTING,
 	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
-	CPUHP_AP_IRQ_LOONGARCH_STARTING,
+	CPUHP_AP_IRQ_EIOINTC_STARTING,
+	CPUHP_AP_IRQ_AVECINTC_STARTING,
 	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 	CPUHP_AP_IRQ_RISCV_IMSIC_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
-- 
2.20.1


