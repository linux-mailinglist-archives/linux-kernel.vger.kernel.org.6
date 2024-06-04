Return-Path: <linux-kernel+bounces-200648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E14738FB314
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D96E9B2A61C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9260D148FEC;
	Tue,  4 Jun 2024 12:50:34 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065CD1474CC;
	Tue,  4 Jun 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505433; cv=none; b=t4Xb4FWeTZUVTipVDc+9AyFJzb9D+3d2YcR8CfoxF0l77J4CJOthd3MKzchVnqlfQPvElMSFCOSrsHxLSoFSJkW29wC0ae5vUkRyQ5vdObXtPLBXHyw9wo2o0Cr9kqaYoVgmqBWi6ZpBAEaMB0Eo+gLU4rewMC7IWpTyd/mX0V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505433; c=relaxed/simple;
	bh=xP0I9Q66pD6zfdTrX43laZ9i49XP5TurP9X4yb8Ky9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kNgKbX+Juy6n/aQNn4OcY83ood8JlAFy7uHPKEW/94KIHm4lEWqGhsDXrdjp2n+607oFzjLTcq7Zc4319083czaM2G+OTHBBSGz3GQoTDlooCaxTJYhpXNMgMO23LRsjl0Lqwu8iwFkDFT52qQcEr/wc2+JAgBuhC0PsOe1aGW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.10.34])
	by gateway (Coremail) with SMTP id _____8DxSuqUDV9mrmMDAA--.14598S3;
	Tue, 04 Jun 2024 20:50:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxjseTDV9mxkEUAA--.50563S2;
	Tue, 04 Jun 2024 20:50:27 +0800 (CST)
From: Tianyang Zhang <zhangtianyang@loongson.cn>
To: chenhuacai@kernel.org,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH V1 2/2] Loongarch:Support loongarch avec
Date: Tue,  4 Jun 2024 20:50:26 +0800
Message-Id: <20240604125026.18745-1-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxjseTDV9mxkEUAA--.50563S2
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9fXoWfuw17tr4DCrWrZw1xJw1UJwc_yoW5Xr1fKo
	WfXF1Fqw18Gr42krZ8Kwn0qFyjqry8AFWDA3s3ZFs29F47Ars8Kry7Kw13tFW3G3WkGrZr
	Cay2grn3Wa97trnrl-sFpf9Il3svdjkaLaAFLSUrUUUUeb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYA7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==

Introduce the advanced extended interrupt controllers,
This feature will allow each core to have an independent
256 interrupt vectors, and MSI interrupts can be
independently routed to any vector on any CPU.

Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Co-developed-by: Liupu Wang <wangliupu@loongson.cn>
Signed-off-by: Liupu Wang <wangliupu@loongson.cn>
Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
---
 arch/loongarch/Kconfig                    |   1 +
 arch/loongarch/include/asm/cpu-features.h |   1 +
 arch/loongarch/include/asm/cpu.h          |   2 +
 arch/loongarch/include/asm/hw_irq.h       |  10 +
 arch/loongarch/include/asm/irq.h          |  12 +-
 arch/loongarch/include/asm/loongarch.h    |  20 +-
 arch/loongarch/include/asm/smp.h          |   1 +
 arch/loongarch/kernel/cpu-probe.c         |   3 +-
 arch/loongarch/kernel/smp.c               |   5 +
 drivers/irqchip/Makefile                  |   2 +-
 drivers/irqchip/irq-loongarch-avec.c      | 423 ++++++++++++++++++++++
 drivers/irqchip/irq-loongarch-cpu.c       |   4 +-
 drivers/irqchip/irq-loongson-eiointc.c    |   3 +
 drivers/irqchip/irq-loongson-pch-msi.c    |  43 ++-
 14 files changed, 520 insertions(+), 10 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongarch-avec.c

Changes log:
V0->V1:
	1.Modified some formats and declarations
	2.Removed kmalloc/kfree when adding affinity related data to pending_list,
 	  and used moving tag to replace the original behavior
	3.Adjusted the process that enables AVEC interrupts, now it is at the end of all processes
	4.Removed CPUHP related callbacks, now irq_matrix_online/irq_matrix_offline is completed in start_secondary/loongson_cpu_disable
	5.Adjusted compatibility issues for CONFIG_ACPI
	6.About question:
	> irr = csr_read64(LOONGARCH_CSR_IRR0 + vector / 64);
	> should be good enough, no? 
	csr_read64 was built-in as __csrrd_d, it doesn't seem to support variables as parameters 
	>>>>
	drivers/irqchip/irq-loongarch-avec.c: In function ‘complete_irq_moving’:
	./arch/loongarch/include/asm/loongarch.h:164:25: error: invalid argument to built-in function
	  164 | #define csr_read64(reg) __csrrd_d(reg)
	      |                         ^~~~~~~~~
	drivers/irqchip/irq-loongarch-avec.c:170:23: note: in expansion of macro ‘csr_read64’
	  170 |                 irr = csr_read64(LOONGARCH_CSR_IRR_BASE + vector / VECTORS_PER_REG);
	      |                       ^~~~~~~~~~
	>>>>
	So we have temporarily retained the previous implementation.


diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 10959e6c3583..71b8f19745e0 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -76,6 +76,7 @@ config LOONGARCH
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
diff --git a/arch/loongarch/include/asm/hw_irq.h b/arch/loongarch/include/asm/hw_irq.h
index af4f4e8fbd85..521abce32135 100644
--- a/arch/loongarch/include/asm/hw_irq.h
+++ b/arch/loongarch/include/asm/hw_irq.h
@@ -9,6 +9,16 @@
 
 extern atomic_t irq_err_count;
 
+/*
+ * 256 vectors Map:
+ *
+ * 0 - 15: mapping legacy IPs, e.g. IP0-12.
+ * 16 - 255: mapping a vector for external IRQ.
+ *
+ */
+#define NR_VECTORS	256
+#define IRQ_MATRIX_BITS	NR_VECTORS
+#define NR_LEGACY_VECTORS	16
 /*
  * interrupt-retrigger: NOP for now. This may not be appropriate for all
  * machines, we'll see ...
diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index 218b4da0ea90..4e45a55dedfe 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -65,7 +65,7 @@ extern struct acpi_vector_group msi_group[MAX_IO_PICS];
 #define LOONGSON_LPC_LAST_IRQ		(LOONGSON_LPC_IRQ_BASE + 15)
 
 #define LOONGSON_CPU_IRQ_BASE		16
-#define LOONGSON_CPU_LAST_IRQ		(LOONGSON_CPU_IRQ_BASE + 14)
+#define LOONGSON_CPU_LAST_IRQ		(LOONGSON_CPU_IRQ_BASE + 15)
 
 #define LOONGSON_PCH_IRQ_BASE		64
 #define LOONGSON_PCH_ACPI_IRQ		(LOONGSON_PCH_IRQ_BASE + 47)
@@ -101,6 +101,16 @@ int pch_msi_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_msi_pic *acpi_pchmsi);
 int pch_pic_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_bio_pic *acpi_pchpic);
+
+#ifdef CONFIG_ACPI
+int __init pch_msi_acpi_init_v2(struct irq_domain *parent,
+		struct acpi_madt_msi_pic *pch_msi_entry);
+int __init loongarch_avec_acpi_init(struct irq_domain *parent);
+void complete_irq_moving(void);
+int loongarch_avec_offline_cpu(unsigned int cpu);
+int loongarch_avec_online_cpu(unsigned int cpu);
+#endif
+
 int find_pch_pic(u32 gsi);
 struct fwnode_handle *get_pch_msi_handle(int pci_segment);
 
diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 46366e783c84..84fa70ff2ab3 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -72,7 +72,6 @@
 #define  CPUCFG1_RPLV			BIT(23)
 #define  CPUCFG1_HUGEPG			BIT(24)
 #define  CPUCFG1_CRC32			BIT(25)
-#define  CPUCFG1_MSGINT			BIT(26)
 
 #define LOONGARCH_CPUCFG2		0x2
 #define  CPUCFG2_FP			BIT(0)
@@ -240,8 +239,8 @@
 #define  CSR_ESTAT_EXC_WIDTH		6
 #define  CSR_ESTAT_EXC			(_ULCAST_(0x3f) << CSR_ESTAT_EXC_SHIFT)
 #define  CSR_ESTAT_IS_SHIFT		0
-#define  CSR_ESTAT_IS_WIDTH		14
-#define  CSR_ESTAT_IS			(_ULCAST_(0x3fff) << CSR_ESTAT_IS_SHIFT)
+#define  CSR_ESTAT_IS_WIDTH		15
+#define  CSR_ESTAT_IS			(_ULCAST_(0x7fff) << CSR_ESTAT_IS_SHIFT)
 
 #define LOONGARCH_CSR_ERA		0x6	/* ERA */
 
@@ -987,10 +986,18 @@
 #define CSR_FWPC_SKIP_SHIFT		16
 #define CSR_FWPC_SKIP			(_ULCAST_(1) << CSR_FWPC_SKIP_SHIFT)
 
+#define LOONGARCH_CSR_IRR0		0xa0
+#define LOONGARCH_CSR_IRR1		0xa1
+#define LOONGARCH_CSR_IRR2		0xa2
+#define LOONGARCH_CSR_IRR3		0xa3
+#define LOONGARCH_CSR_IRR_BASE		LOONGARCH_CSR_IRR0
+
+#define	LOONGARCH_CSR_ILR		0xa4
+
 /*
  * CSR_ECFG IM
  */
-#define ECFG0_IM		0x00001fff
+#define ECFG0_IM		0x00005fff
 #define ECFGB_SIP0		0
 #define ECFGF_SIP0		(_ULCAST_(1) << ECFGB_SIP0)
 #define ECFGB_SIP1		1
@@ -1033,6 +1040,7 @@
 #define  IOCSRF_EIODECODE		BIT_ULL(9)
 #define  IOCSRF_FLATMODE		BIT_ULL(10)
 #define  IOCSRF_VM			BIT_ULL(11)
+#define  IOCSRF_AVEC			BIT_ULL(15)
 
 #define LOONGARCH_IOCSR_VENDOR		0x10
 
@@ -1043,6 +1051,7 @@
 #define LOONGARCH_IOCSR_MISC_FUNC	0x420
 #define  IOCSR_MISC_FUNC_TIMER_RESET	BIT_ULL(21)
 #define  IOCSR_MISC_FUNC_EXT_IOI_EN	BIT_ULL(48)
+#define  IOCSR_MISC_FUNC_AVEC_EN	BIT_ULL(51)
 
 #define LOONGARCH_IOCSR_CPUTEMP		0x428
 
@@ -1363,9 +1372,10 @@ __BUILD_CSR_OP(tlbidx)
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
index f81e5f01d619..577f591c1c73 100644
--- a/arch/loongarch/include/asm/smp.h
+++ b/arch/loongarch/include/asm/smp.h
@@ -62,6 +62,7 @@ extern int __cpu_logical_map[NR_CPUS];
 #define SMP_BOOT_CPU		0x1
 #define SMP_RESCHEDULE		0x2
 #define SMP_CALL_FUNCTION	0x4
+#define SMP_CLEAR_VECT		0x8
 
 struct secondary_data {
 	unsigned long stack;
diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index 55320813ee08..3b2e72e8f9bd 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -106,7 +106,6 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
 		elf_hwcap |= HWCAP_LOONGARCH_CRC32;
 	}
 
-
 	config = read_cpucfg(LOONGARCH_CPUCFG2);
 	if (config & CPUCFG2_LAM) {
 		c->options |= LOONGARCH_CPU_LAM;
@@ -176,6 +175,8 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
 		c->options |= LOONGARCH_CPU_EIODECODE;
 	if (config & IOCSRF_VM)
 		c->options |= LOONGARCH_CPU_HYPERVISOR;
+	if (config & IOCSRF_AVEC)
+		c->options |= LOONGARCH_CPU_AVECINT;
 
 	config = csr_read32(LOONGARCH_CSR_ASID);
 	config = (config & CSR_ASID_BIT) >> CSR_ASID_BIT_SHIFT;
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index a16e3dbe9f09..4fb8f411040c 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -176,6 +176,9 @@ irqreturn_t loongson_ipi_interrupt(int irq, void *dev)
 		per_cpu(irq_stat, cpu).ipi_irqs[IPI_CALL_FUNCTION]++;
 	}
 
+	if (action & SMP_CLEAR_VECT)
+		complete_irq_moving();
+
 	return IRQ_HANDLED;
 }
 
@@ -308,6 +311,7 @@ int loongson_cpu_disable(void)
 	irq_migrate_all_off_this_cpu();
 	clear_csr_ecfg(ECFG0_IM);
 	local_irq_restore(flags);
+	loongarch_avec_offline_cpu(cpu);
 	local_flush_tlb_all();
 
 	return 0;
@@ -539,6 +543,7 @@ asmlinkage void start_secondary(void)
 	 * early is dangerous.
 	 */
 	WARN_ON_ONCE(!irqs_disabled());
+	loongarch_avec_online_cpu(cpu);
 	loongson_smp_finish();
 
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index ec4a18380998..398db4c3e264 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -105,7 +105,7 @@ obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
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
index 000000000000..3e488f182178
--- /dev/null
+++ b/drivers/irqchip/irq-loongarch-avec.c
@@ -0,0 +1,423 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Loongson Technologies, Inc.
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
+#define VECTORS_PER_REG		64
+#define ILR_INVALID_MASK	0x80000000UL
+#define ILR_VECTOR_MASK		0xffUL
+#define AVEC_MSG_OFFSET		0x100000
+
+static phys_addr_t msi_base_v2;
+static DEFINE_PER_CPU(struct irq_desc * [NR_VECTORS], irq_map);
+
+struct pending_list {
+	struct list_head	head;
+};
+
+static DEFINE_PER_CPU(struct pending_list, pending_list);
+
+struct loongarch_avec_chip {
+	struct fwnode_handle	*fwnode;
+	struct irq_domain	*domain;
+	struct irq_matrix	*vector_matrix;
+	raw_spinlock_t		lock;
+};
+
+static struct loongarch_avec_chip loongarch_avec;
+
+struct loongarch_avec_data {
+	struct list_head	entry;
+	unsigned int		cpu;
+	unsigned int		vec;
+	unsigned int		prev_cpu;
+	unsigned int		prev_vec;
+	unsigned int		moving		: 1,
+				managed		: 1;
+};
+
+static struct cpumask intersect_mask;
+
+static int assign_irq_vector(struct irq_data *irqd, const struct cpumask *dest,
+				unsigned int *cpu)
+{
+	return irq_matrix_alloc(loongarch_avec.vector_matrix, dest, false, cpu);
+}
+
+static inline void loongarch_avec_ack_irq(struct irq_data *d)
+{
+}
+
+static inline void loongarch_avec_unmask_irq(struct irq_data *d)
+{
+}
+
+static inline void loongarch_avec_mask_irq(struct irq_data *d)
+{
+}
+
+static void loongarch_avec_sync(struct loongarch_avec_data *adata)
+{
+	struct pending_list *plist;
+
+	if (cpu_online(adata->prev_cpu)) {
+		plist = per_cpu_ptr(&pending_list, adata->prev_cpu);
+		list_add_tail(&adata->entry, &plist->head);
+		adata->moving = true;
+		loongson_send_ipi_single(adata->prev_cpu, SMP_CLEAR_VECT);
+	}
+	adata->prev_cpu = adata->cpu;
+	adata->prev_vec = adata->vec;
+}
+
+static int loongarch_avec_set_affinity(struct irq_data *data,
+		const struct cpumask *dest, bool force)
+{
+	struct loongarch_avec_data *adata;
+	unsigned int cpu, vector;
+	unsigned long flags;
+	int ret;
+
+	raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
+	adata = irq_data_get_irq_chip_data(data);
+
+	if (adata->vec && cpu_online(adata->cpu) && cpumask_test_cpu(adata->cpu, dest)) {
+		raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
+		return 0;
+	}
+	if (adata->moving)
+		return -EBUSY;
+
+	cpumask_and(&intersect_mask, dest, cpu_online_mask);
+
+	ret = assign_irq_vector(data, &intersect_mask, &cpu);
+	if (ret < 0) {
+		raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
+		return ret;
+	}
+	vector = ret;
+	adata->cpu = cpu;
+	adata->vec = vector;
+	per_cpu_ptr(irq_map, adata->cpu)[adata->vec] = irq_data_to_desc(data);
+	loongarch_avec_sync(adata);
+
+	raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
+	irq_data_update_effective_affinity(data, cpumask_of(cpu));
+
+	return IRQ_SET_MASK_OK;
+}
+
+static void loongarch_avec_compose_msg(struct irq_data *d,
+		struct msi_msg *msg)
+{
+	struct loongarch_avec_data *avec_data;
+
+	avec_data = irq_data_get_irq_chip_data(d);
+
+	msg->address_hi = 0x0;
+	msg->address_lo = msi_base_v2 | ((avec_data->vec & 0xff) << 4) |
+		((cpu_logical_map(avec_data->cpu & 0xffff)) << 12);
+	msg->data = 0x0;
+
+}
+
+static struct irq_chip loongarch_avec_controller = {
+	.name			= "CORE_AVEC",
+	.irq_ack		= loongarch_avec_ack_irq,
+	.irq_mask		= loongarch_avec_mask_irq,
+	.irq_unmask		= loongarch_avec_unmask_irq,
+	.irq_set_affinity	= loongarch_avec_set_affinity,
+	.irq_compose_msi_msg	= loongarch_avec_compose_msg,
+};
+
+void complete_irq_moving(void)
+{
+	struct pending_list *plist = this_cpu_ptr(&pending_list);
+	struct loongarch_avec_data *adata, *tmp;
+	int cpu, vector, bias;
+	u64 irr;
+
+	raw_spin_lock(&loongarch_avec.lock);
+
+	list_for_each_entry_safe(adata, tmp, &plist->head, entry) {
+		cpu = adata->prev_cpu;
+		vector = adata->prev_vec;
+		bias = vector / VECTORS_PER_REG;
+		switch (bias) {
+		case 0:
+			irr = csr_read64(LOONGARCH_CSR_IRR0);
+		case 1:
+			irr = csr_read64(LOONGARCH_CSR_IRR1);
+		case 2:
+			irr = csr_read64(LOONGARCH_CSR_IRR2);
+		case 3:
+			irr = csr_read64(LOONGARCH_CSR_IRR3);
+		}
+
+		if (irr & (1UL << (vector % VECTORS_PER_REG))) {
+			loongson_send_ipi_single(cpu, SMP_CLEAR_VECT);
+			continue;
+		}
+		list_del(&adata->entry);
+		irq_matrix_free(loongarch_avec.vector_matrix, cpu, vector, adata->managed);
+		this_cpu_write(irq_map[vector], NULL);
+		adata->moving = 0;
+	}
+	raw_spin_unlock(&loongarch_avec.lock);
+}
+
+static void loongarch_avec_dispatch(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irq_desc *d;
+	unsigned long vector;
+
+	chained_irq_enter(chip, desc);
+	vector = csr_read64(LOONGARCH_CSR_ILR);
+	if (vector & ILR_INVALID_MASK)
+		return;
+
+	vector &= ILR_VECTOR_MASK;
+
+	d = this_cpu_read(irq_map[vector]);
+	if (d)
+		generic_handle_irq_desc(d);
+	else
+		pr_warn("IRQ ERROR:Unexpected irq  occur on cpu %d[vector %ld]\n",
+			smp_processor_id(), vector);
+
+	chained_irq_exit(chip, desc);
+}
+
+static int loongarch_avec_alloc(struct irq_domain *domain, unsigned int virq,
+		unsigned int nr_irqs, void *arg)
+{
+	struct loongarch_avec_data *adata;
+	struct irq_data *irqd;
+	unsigned int cpu, vector, i, ret;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
+	for (i = 0; i < nr_irqs; i++) {
+		irqd = irq_domain_get_irq_data(domain, virq + i);
+		adata = kzalloc(sizeof(*adata), GFP_KERNEL);
+		if (!adata) {
+			raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
+			return -ENOMEM;
+		}
+		ret = assign_irq_vector(irqd, cpu_online_mask, &cpu);
+		if (ret < 0) {
+			raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
+			return ret;
+		}
+		vector = ret;
+		adata->prev_cpu = adata->cpu = cpu;
+		adata->prev_vec = adata->vec = vector;
+		adata->managed = irqd_affinity_is_managed(irqd);
+		irq_domain_set_info(domain, virq + i, virq + i, &loongarch_avec_controller,
+				adata, handle_edge_irq, NULL, NULL);
+		adata->moving = 0;
+		irqd_set_single_target(irqd);
+		irqd_set_affinity_on_activate(irqd);
+
+		per_cpu_ptr(irq_map, adata->cpu)[adata->vec] = irq_data_to_desc(irqd);
+	}
+	raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
+
+	return 0;
+}
+
+static void clear_free_vector(struct irq_data *irqd)
+{
+	struct loongarch_avec_data *adata = irq_data_get_irq_chip_data(irqd);
+	bool managed = irqd_affinity_is_managed(irqd);
+
+	per_cpu(irq_map, adata->cpu)[adata->vec] = NULL;
+	irq_matrix_free(loongarch_avec.vector_matrix, adata->cpu, adata->vec, managed);
+	adata->cpu = 0;
+	adata->vec = 0;
+	if (!adata->moving)
+		return;
+
+	per_cpu(irq_map, adata->prev_cpu)[adata->prev_vec] = 0;
+	irq_matrix_free(loongarch_avec.vector_matrix, adata->prev_cpu,
+			adata->prev_vec, adata->managed);
+	adata->prev_vec = 0;
+	adata->prev_cpu = 0;
+	adata->moving = 0;
+	list_del_init(&adata->entry);
+}
+
+static void loongarch_avec_free(struct irq_domain *domain, unsigned int virq,
+		unsigned int nr_irqs)
+{
+	struct irq_data *d;
+	unsigned long flags;
+	unsigned int i;
+
+	raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
+	for (i = 0; i < nr_irqs; i++) {
+		d = irq_domain_get_irq_data(domain, virq + i);
+		if (d) {
+			clear_free_vector(d);
+			irq_domain_reset_irq_data(d);
+
+		}
+	}
+
+	raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
+}
+
+static const struct irq_domain_ops loongarch_avec_domain_ops = {
+	.alloc		= loongarch_avec_alloc,
+	.free		= loongarch_avec_free,
+};
+
+static int __init irq_matrix_init(void)
+{
+	int i;
+
+	loongarch_avec.vector_matrix = irq_alloc_matrix(NR_VECTORS, 0, NR_VECTORS - 1);
+	if (!loongarch_avec.vector_matrix)
+		return -ENOMEM;
+	for (i = 0; i < NR_LEGACY_VECTORS; i++)
+		irq_matrix_assign_system(loongarch_avec.vector_matrix, i, false);
+
+	irq_matrix_online(loongarch_avec.vector_matrix);
+
+	return 0;
+}
+
+static int __init loongarch_avec_init(struct irq_domain *parent)
+{
+	struct pending_list *plist = per_cpu_ptr(&pending_list, 0);
+	int ret = 0, parent_irq;
+	unsigned long tmp;
+
+	raw_spin_lock_init(&loongarch_avec.lock);
+
+	loongarch_avec.fwnode = irq_domain_alloc_named_fwnode("CORE_AVEC");
+	if (!loongarch_avec.fwnode) {
+		pr_err("Unable to allocate domain handle\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	loongarch_avec.domain = irq_domain_create_tree(loongarch_avec.fwnode,
+			&loongarch_avec_domain_ops, NULL);
+	if (!loongarch_avec.domain) {
+		pr_err("core-vec: cannot create IRQ domain\n");
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
+	irq_set_chained_handler_and_data(parent_irq, loongarch_avec_dispatch, NULL);
+
+	ret = irq_matrix_init();
+	if (ret) {
+		pr_err("Failed to init irq matrix\n");
+		goto out_free_matrix;
+	}
+
+	INIT_LIST_HEAD(&plist->head);
+	tmp = iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
+	tmp |= IOCSR_MISC_FUNC_AVEC_EN;
+	iocsr_write64(tmp, LOONGARCH_IOCSR_MISC_FUNC);
+
+	return ret;
+
+out_free_matrix:
+	kfree(loongarch_avec.vector_matrix);
+out_remove_domain:
+	irq_domain_remove(loongarch_avec.domain);
+out_free_handle:
+	irq_domain_free_fwnode(loongarch_avec.fwnode);
+out:
+	return ret;
+}
+
+int loongarch_avec_offline_cpu(unsigned int cpu)
+{
+	unsigned long flags;
+	struct pending_list *plist = per_cpu_ptr(&pending_list, cpu);
+
+	raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
+	if (list_empty(&plist->head)) {
+		irq_matrix_offline(loongarch_avec.vector_matrix);
+	} else {
+		pr_warn("cpu %d advanced extioi is busy\n", cpu);
+		raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
+		return -EBUSY;
+	}
+	raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
+	return 0;
+}
+
+int loongarch_avec_online_cpu(unsigned int cpu)
+{
+	struct pending_list *plist = per_cpu_ptr(&pending_list, cpu);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
+
+	irq_matrix_online(loongarch_avec.vector_matrix);
+
+	INIT_LIST_HEAD(&plist->head);
+
+	raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
+	return 0;
+}
+
+static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
+		const unsigned long end)
+{
+	struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
+
+	msi_base_v2 = pchmsi_entry->msg_address - AVEC_MSG_OFFSET;
+	return pch_msi_acpi_init_v2(loongarch_avec.domain, pchmsi_entry);
+}
+
+static inline int __init acpi_cascade_irqdomain_init(void)
+{
+	return acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, pch_msi_parse_madt, 1);
+}
+
+int __init loongarch_avec_acpi_init(struct irq_domain *parent)
+{
+	int ret = 0;
+
+	ret = loongarch_avec_init(parent);
+	if (ret) {
+		pr_err("Failed to init irq domain\n");
+		return ret;
+	}
+
+	ret = acpi_cascade_irqdomain_init();
+	if (ret) {
+		pr_err("Failed to cascade IRQ domain\n");
+		return ret;
+	}
+
+	return ret;
+}
diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 9d8f2c406043..1ecac59925c6 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -138,7 +138,9 @@ static int __init acpi_cascade_irqdomain_init(void)
 	if (r < 0)
 		return r;
 
-	return 0;
+	if (cpu_has_avecint)
+		r = loongarch_avec_acpi_init(irq_domain);
+	return r;
 }
 
 static int __init cpuintc_acpi_init(union acpi_subtable_headers *header,
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 405f622a26ad..39795241304e 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -359,6 +359,9 @@ static int __init acpi_cascade_irqdomain_init(void)
 	if (r < 0)
 		return r;
 
+	if (cpu_has_avecint)
+		return 0;
+
 	r = acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, pch_msi_parse_madt, 1);
 	if (r < 0)
 		return r;
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index 6e1e1f011bb2..af5f0beb7be7 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -16,7 +16,6 @@
 #include <linux/slab.h>
 
 static int nr_pics;
-
 struct pch_msi_data {
 	struct mutex	msi_map_lock;
 	phys_addr_t	doorbell;
@@ -100,6 +99,17 @@ static struct irq_chip middle_irq_chip = {
 	.irq_compose_msi_msg	= pch_msi_compose_msi_msg,
 };
 
+static struct irq_chip pch_msi_irq_chip_v2 = {
+	.name			= "MSI",
+	.irq_ack		= irq_chip_ack_parent,
+};
+
+static struct msi_domain_info pch_msi_domain_info_v2 = {
+	.flags		= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+			MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
+	.chip	= &pch_msi_irq_chip_v2,
+};
+
 static int pch_msi_parent_domain_alloc(struct irq_domain *domain,
 					unsigned int virq, int hwirq)
 {
@@ -268,6 +278,9 @@ struct fwnode_handle *get_pch_msi_handle(int pci_segment)
 {
 	int i;
 
+	if (cpu_has_avecint)
+		return pch_msi_handle[0];
+
 	for (i = 0; i < MAX_IO_PICS; i++) {
 		if (msi_group[i].pci_segment == pci_segment)
 			return pch_msi_handle[i];
@@ -289,4 +302,32 @@ int __init pch_msi_acpi_init(struct irq_domain *parent,
 
 	return ret;
 }
+
+int __init pch_msi_acpi_init_v2(struct irq_domain *parent,
+		struct acpi_madt_msi_pic *msi_entry)
+{
+	struct irq_domain *msi_domain;
+
+	if (pch_msi_handle[0])
+		return 0;
+
+	pch_msi_handle[0] = irq_domain_alloc_named_fwnode("msipic-v2");
+	if (!pch_msi_handle[0]) {
+		pr_err("Unable to allocate domain handle\n");
+		kfree(pch_msi_handle[0]);
+		return -ENOMEM;
+	}
+
+	msi_domain = pci_msi_create_irq_domain(pch_msi_handle[0],
+			&pch_msi_domain_info_v2,
+			parent);
+	if (!msi_domain) {
+		pr_err("Failed to create PCI MSI domain\n");
+		kfree(pch_msi_handle[0]);
+		return -ENOMEM;
+	}
+
+	pr_info("IRQ domain MSIPIC-V2 init done.\n");
+	return 0;
+}
 #endif
-- 
2.20.1


