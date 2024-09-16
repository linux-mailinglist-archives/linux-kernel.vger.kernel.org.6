Return-Path: <linux-kernel+bounces-330351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA3C979CFF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053811C22A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F5014659B;
	Mon, 16 Sep 2024 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oswAcE1g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4RTcDhMn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8471532C8E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475931; cv=none; b=b06jC8AGa9q6x3RnHPwxXyCeQpWfUp7Qn/iSb/q9a28hKMiDhL7O8urrAmSh1cObcfJ9IIbhde84PzyUa8wsX6i04Hqf3GnlriSXHsGgdx79Y8weIMu6mi8snrZa9tAI4GF/lyXMTr+K2T1u1W74xmGikPeZOwnlT8aRjqLhSzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475931; c=relaxed/simple;
	bh=sVQVlCtcExkcc0W6q4uwqDciWbEQu/uvVRvIl+cVzIA=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=bflERlDzMLxGDCI1bxUamatftZ/qBw6RsfLRLvWinD88sZMxGlX73SL5ayKITJBoWhECd+WXxyfIcTFII3LZ2E09dpryBU5ITXcW7u07mW2okpa1oZ3/bXeZylAgTL2xD6u7uxoLEgq2FZeJoZIVQQs+sy4Ee4Vr9tN3fR7qTj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oswAcE1g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4RTcDhMn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726475916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=/HB8fTfQMdpg2nduPM/UvAzXtkmcAnH86ZASO+ubBo4=;
	b=oswAcE1gNQjMr/A1PSxQtDEJFeXDRQNqHkVaEz5KvWjAIsN3ZWfwCFzC9Tuprlbd9hbJ2z
	r7QwQ2q7ShbFAn75Cg5edNCf+4UGj/kQCOCuX4zO/rWOhEHTJB8CmSkmC2LaGNMkj5PNFa
	7sx178uVkFTkvepCfNQES5UNmwSU0esN0DvVJhr3rSZ7Vo8gcB2KmWrQ1fcI1epkLoeA5m
	oWfpPgSG7PX5pPjOo/vpG/cSC9lgPOErSkIpzK9poMfvmLVHtrSLgvmqDQG7LRj1fL4J5w
	nx26ZNPXOVIGrQWv68mHgfd1gToRZWMX0yyQeCxvXx416QUUnojwBYiNHY0ViQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726475916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=/HB8fTfQMdpg2nduPM/UvAzXtkmcAnH86ZASO+ubBo4=;
	b=4RTcDhMnw3lKXah1ei/DmfOu9bZ7gHM9X5q74abDTNqn1iHKN+Zq5nrMeGGW4wT1EVBL3v
	B1G5G4D4FCuvTdDg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for v6.12-rc1
References: <172647588843.2450257.3544233832195550173.tglx@xen13>
Message-ID: <172647589071.2450257.3792507929959687176.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Sep 2024 10:38:36 +0200 (CEST)

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2024-09=
-16

up to:  a6fe30d1e365: genirq: Use cpumask_intersects()

Updates for the interrupt subsystem:

 - Core:
	- Remove a global lock in the affinity setting code

	  The lock protects a cpumask for intermediate results and the lock
	  causes a bottleneck on simultaneous start of multiple virtual
	  machines. Replace the lock and the static cpumask with a per CPU
	  cpumask which is nicely serialized by raw spinlock held when
	  executing this code.

	- Provide support for giving a suffix to interrupt domain names.

	  That's required to support devices with subfunctions so that the
	  domain names are distinct even if they originate from the same
	  device node.

	- The usual set of cleanups and enhancements all over the place

  - Drivers:

	- Support for longarch AVEC interrupt chip

	- Refurbishment of the Armada driver so it can be extended for new
          variants.

	- The usual set of cleanups and enhancements all over the place

Thanks,

	tglx

------------------>
Andy Shevchenko (2):
      irqdomain: Clarify checks for bus_token
      irqdomain: Remove stray '-' in the domain name

Anshuman Khandual (1):
      irqchip/gic-v4.1: Replace bare number with ID_AA64PFR0_EL1_GIC_V4P1

Caleb Sander Mateos (1):
      softirq: Remove unused 'action' parameter from action callback

Costa Shulyupin (3):
      genirq: Fix typo in struct comment
      genirq/cpuhotplug: Use cpumask_intersects()
      genirq: Use cpumask_intersects()

Hongbo Li (1):
      irqdomain: Use IS_ERR_OR_NULL() in irq_domain_trim_hierarchy()

Huacai Chen (4):
      irqchip/loongson-pch-msi: Switch to MSI parent domains
      LoongArch: Move irqchip function prototypes to irq-loongson.h
      LoongArch: Architectural preparation for AVEC irqchip
      irqchip/loongson-eiointc: Rename CPUHP_AP_IRQ_LOONGARCH_STARTING

Jeff Xie (2):
      genirq/proc: Correctly set file permissions for affinity control files
      genirq/proc: Change the return value for set affinity permission error

Jinjie Ruan (3):
      irqchip: Remove asmlinkage for handlers registered with set_handle_irq()
      genirq/proc: Use irq_move_pending() in show_irq_affinity()
      genirq/msi: Use kmemdup_array() instead of kmemdup()

Jiri Slaby (SUSE) (3):
      genirq/irq_sim: Remove unused irq_sim_work_ctx:: Irq_base
      genirq: Remove unused irq_chip_generic:: {type,polarity}_cache
      genirq: Remove irq_chip_regs:: Polarity

Konrad Dybcio (1):
      irqchip/apple-aic: Only access system registers on SoCs which provide t=
hem

Marc Zyngier (1):
      genirq: Get rid of global lock in irq_do_set_affinity()

Marek Beh=C3=BAn (41):
      irqchip/armada-370-xp: Drop _OFFS suffix from some register constants
      irqchip/armada-370-xp: Change register constant suffix from _MSK to _MA=
SK
      irqchip/armada-370-xp: Change spaces to tabs
      irqchip/armada-370-xp: Use BIT() and GENMASK() macros
      irqchip/armada-370-xp: Cosmetic fix parentheses in register constant de=
finitions
      irqchip/armada-370-xp: Change register constants prefix to MPIC_
      irqchip/armada-370-xp: Use correct type for cpu variable
      irqchip/armada-370-xp: Simplify is_percpu_irq() code
      irqchip/armada-370-xp: Change to SPDX license identifier
      irqchip/armada-370-xp: Declare iterators in for loop
      irqchip/armada-370-xp: Rename variable for consistency
      irqchip/armada-370-xp: Use unsigned int type for virqs
      irqchip/armada-370-xp: Use !virq instead of virq =3D=3D 0 in condition
      irqchip/armada-370-xp: Simplify ipi_resume() code
      irqchip/armada-370-xp: Improve indentation
      irqchip/armada-370-xp: Change symbol prefixes to mpic
      irqchip/armada-370-xp: Don't read number of supported interrupts multip=
le times
      irqchip/armada-370-xp: Use FIELD_GET() and named register constant
      irqchip/armada-370-xp: Refactor mpic_handle_msi_irq() code
      irqchip/armada-370-xp: Refactor handling IPI interrupts
      irqchip/armada-370-xp: Use consistent variable names for hwirqs
      irqchip/armada-370-xp: Use consistent types when iterating interrupts
      irqchip/armada-370-xp: Use consistent name for struct irq_data variables
      irqchip/armada-370-xp: Simplify mpic_reenable_percpu() and mpic_resume()
      irqchip/armada-370-xp: Drop redundant continue
      irqchip/armada-370-xp: Rename variable for consistency
      irqchip/armada-370-xp: Use u32 type instead of unsigned long where poss=
ieble
      irqchip/armada-370-xp: Refactor initial memory regions mapping
      irqchip/armada-370-xp: Print error and return error code on initializat=
ion failure
      irqchip/armada-370-xp: Drop IPI_DOORBELL_START and rename IPI_DOORBELL_=
END
      irqchip/armada-370-xp: Drop msi_doorbell_end()
      irqchip/armada-370-xp: Add the __init attribute to mpic_msi_init()
      irqchip/armada-370-xp: Put __init attribute after return type in mpic_i=
pi_init()
      irqchip/armada-370-xp: Put static variables into driver private structu=
re
      irqchip/armada-370-xp: Put MSI doorbell limits into the mpic structure
      irqchip/armada-370-xp: Pass around the driver private structure
      irqchip/armada-370-xp: Dynamically allocate the driver private structure
      irqchip/armada-370-xp: Fix reenabling last per-CPU interrupt
      irqchip/armada-370-xp: Iterate only valid bits of the per-CPU interrupt=
 cause register
      irqchip/armada-370-xp: Allow mapping only per-CPU interrupts
      irqchip/armada-370-xp: Use mpic_is_ipi_available() in mpic_of_init()

Matti Vaittinen (3):
      irqdomain: Simplify simple and legacy domain creation
      irqdomain: Allow giving name suffix for domain
      irqdomain: Always associate interrupts for legacy domains

Nick Chan (3):
      dt-bindings: apple,aic: Document A7-A11 compatibles
      irqchip/apple-aic: Skip unnecessary enabling of use_fast_ipi
      irqchip/apple-aic: Add a new "Global fast IPIs only" feature level

Thomas Gleixner (1):
      irqdomain: Cleanup domain name allocation

Tianyang Zhang (2):
      irqchip/loongson-pch-msi: Prepare get_pch_msi_handle() for AVECINTC
      irqchip/loongarch-avec: Add AVEC irqchip support

Zhang Zekun (1):
      irqchip/mbigen: Simplify code logic with for_each_child_of_node_scoped()


 .../bindings/interrupt-controller/apple,aic.yaml   |  14 +-
 arch/loongarch/Kconfig                             |   1 +
 arch/loongarch/include/asm/cpu-features.h          |   1 +
 arch/loongarch/include/asm/cpu.h                   |   2 +
 arch/loongarch/include/asm/hardirq.h               |   3 +-
 arch/loongarch/include/asm/irq.h                   |  31 +-
 arch/loongarch/include/asm/loongarch.h             |  18 +-
 arch/loongarch/include/asm/smp.h                   |   2 +
 arch/loongarch/kernel/cpu-probe.c                  |   3 +-
 arch/loongarch/kernel/irq.c                        |  12 +
 arch/loongarch/kernel/paravirt.c                   |   5 +
 arch/loongarch/kernel/smp.c                        |   6 +
 block/blk-mq.c                                     |   2 +-
 drivers/irqchip/Kconfig                            |   1 +
 drivers/irqchip/Makefile                           |   2 +-
 drivers/irqchip/irq-apple-aic.c                    |  59 +-
 drivers/irqchip/irq-armada-370-xp.c                | 861 +++++++++++--------=
--
 drivers/irqchip/irq-atmel-aic.c                    |   3 +-
 drivers/irqchip/irq-atmel-aic5.c                   |   3 +-
 drivers/irqchip/irq-clps711x.c                     |   2 +-
 drivers/irqchip/irq-davinci-cp-intc.c              |   3 +-
 drivers/irqchip/irq-ftintc010.c                    |   2 +-
 drivers/irqchip/irq-gic-v3.c                       |   2 +-
 drivers/irqchip/irq-gic-v4.c                       |   2 +-
 drivers/irqchip/irq-ixp4xx.c                       |   3 +-
 drivers/irqchip/irq-loongarch-avec.c               | 425 ++++++++++
 drivers/irqchip/irq-loongarch-cpu.c                |   7 +-
 drivers/irqchip/irq-loongson-eiointc.c             |   9 +-
 drivers/irqchip/irq-loongson-htvec.c               |   2 +
 drivers/irqchip/irq-loongson-liointc.c             |   2 +
 drivers/irqchip/irq-loongson-pch-lpc.c             |   2 +
 drivers/irqchip/irq-loongson-pch-msi.c             |  83 +-
 drivers/irqchip/irq-loongson-pch-pic.c             |   2 +
 drivers/irqchip/irq-loongson.h                     |  27 +
 drivers/irqchip/irq-mbigen.c                       |  24 +-
 drivers/irqchip/irq-omap-intc.c                    |   3 +-
 drivers/irqchip/irq-sa11x0.c                       |   3 +-
 drivers/irqchip/irq-versatile-fpga.c               |   2 +-
 include/linux/cpuhotplug.h                         |   3 +-
 include/linux/interrupt.h                          |   6 +-
 include/linux/irq.h                                |   6 -
 include/linux/irqdomain.h                          |   8 +
 kernel/irq/chip.c                                  |   2 +-
 kernel/irq/cpuhotplug.c                            |   4 +-
 kernel/irq/irq_sim.c                               |   1 -
 kernel/irq/irqdomain.c                             | 210 +++--
 kernel/irq/manage.c                                |  21 +-
 kernel/irq/migration.c                             |   4 +-
 kernel/irq/msi.c                                   |   2 +-
 kernel/irq/proc.c                                  |  17 +-
 kernel/rcu/tiny.c                                  |   2 +-
 kernel/rcu/tree.c                                  |   2 +-
 kernel/sched/fair.c                                |   2 +-
 kernel/softirq.c                                   |  15 +-
 kernel/time/hrtimer.c                              |   2 +-
 kernel/time/timer.c                                |   2 +-
 lib/irq_poll.c                                     |   2 +-
 net/core/dev.c                                     |   4 +-
 58 files changed, 1267 insertions(+), 682 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongarch-avec.c
 create mode 100644 drivers/irqchip/irq-loongson.h

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic=
.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
index 698588e9aa86..4be9b596a790 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
@@ -31,13 +31,25 @@ description: |
   This device also represents the FIQ interrupt sources on platforms using A=
IC,
   which do not go through a discrete interrupt controller.
=20
+  IPIs may be performed via MMIO registers on all variants of AIC. Starting
+  from A11, system registers may also be used for "fast" IPIs. Starting from
+  M1, even faster IPIs within the same cluster may be achieved by writing to
+  a "local" fast IPI register as opposed to using the "global" fast IPI
+  register.
+
 allOf:
   - $ref: /schemas/interrupt-controller.yaml#
=20
 properties:
   compatible:
     items:
-      - const: apple,t8103-aic
+      - enum:
+          - apple,s5l8960x-aic
+          - apple,t7000-aic
+          - apple,s8000-aic
+          - apple,t8010-aic
+          - apple,t8015-aic
+          - apple,t8103-aic
       - const: apple,aic
=20
   interrupt-controller: true
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
diff --git a/arch/loongarch/include/asm/cpu-features.h b/arch/loongarch/inclu=
de/asm/cpu-features.h
index 2eafe6a6aca8..16a716f88a5c 100644
--- a/arch/loongarch/include/asm/cpu-features.h
+++ b/arch/loongarch/include/asm/cpu-features.h
@@ -65,5 +65,6 @@
 #define cpu_has_guestid		cpu_opt(LOONGARCH_CPU_GUESTID)
 #define cpu_has_hypervisor	cpu_opt(LOONGARCH_CPU_HYPERVISOR)
 #define cpu_has_ptw		cpu_opt(LOONGARCH_CPU_PTW)
+#define cpu_has_avecint		cpu_opt(LOONGARCH_CPU_AVECINT)
=20
 #endif /* __ASM_CPU_FEATURES_H */
diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include/asm/cp=
u.h
index 48b9f7168bcc..843f9c4ec980 100644
--- a/arch/loongarch/include/asm/cpu.h
+++ b/arch/loongarch/include/asm/cpu.h
@@ -99,6 +99,7 @@ enum cpu_type_enum {
 #define CPU_FEATURE_GUESTID		24	/* CPU has GuestID feature */
 #define CPU_FEATURE_HYPERVISOR		25	/* CPU has hypervisor (running in VM) */
 #define CPU_FEATURE_PTW			26	/* CPU has hardware page table walker */
+#define CPU_FEATURE_AVECINT		27	/* CPU has avec interrupt */
=20
 #define LOONGARCH_CPU_CPUCFG		BIT_ULL(CPU_FEATURE_CPUCFG)
 #define LOONGARCH_CPU_LAM		BIT_ULL(CPU_FEATURE_LAM)
@@ -127,5 +128,6 @@ enum cpu_type_enum {
 #define LOONGARCH_CPU_GUESTID		BIT_ULL(CPU_FEATURE_GUESTID)
 #define LOONGARCH_CPU_HYPERVISOR	BIT_ULL(CPU_FEATURE_HYPERVISOR)
 #define LOONGARCH_CPU_PTW		BIT_ULL(CPU_FEATURE_PTW)
+#define LOONGARCH_CPU_AVECINT		BIT_ULL(CPU_FEATURE_AVECINT)
=20
 #endif /* _ASM_CPU_H */
diff --git a/arch/loongarch/include/asm/hardirq.h b/arch/loongarch/include/as=
m/hardirq.h
index 1d7feb719515..10da8d6961cb 100644
--- a/arch/loongarch/include/asm/hardirq.h
+++ b/arch/loongarch/include/asm/hardirq.h
@@ -12,12 +12,13 @@
 extern void ack_bad_irq(unsigned int irq);
 #define ack_bad_irq ack_bad_irq
=20
-#define NR_IPI	3
+#define NR_IPI	4
=20
 enum ipi_msg_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNCTION,
 	IPI_IRQ_WORK,
+	IPI_CLEAR_VECTOR,
 };
=20
 typedef struct {
diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/ir=
q.h
index 480418bc5071..9c2ca785faa9 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -39,11 +39,22 @@ void spurious_interrupt(void);
=20
 #define NR_IRQS_LEGACY 16
=20
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
 void arch_trigger_cpumask_backtrace(const struct cpumask *mask, int exclude_=
cpu);
=20
 #define MAX_IO_PICS 2
-#define NR_IRQS	(64 + (256 * MAX_IO_PICS))
+#define NR_IRQS	(64 + NR_VECTORS * (NR_CPUS + MAX_IO_PICS))
=20
 struct acpi_vector_group {
 	int node;
@@ -65,7 +76,7 @@ extern struct acpi_vector_group msi_group[MAX_IO_PICS];
 #define LOONGSON_LPC_LAST_IRQ		(LOONGSON_LPC_IRQ_BASE + 15)
=20
 #define LOONGSON_CPU_IRQ_BASE		16
-#define LOONGSON_CPU_LAST_IRQ		(LOONGSON_CPU_IRQ_BASE + 14)
+#define LOONGSON_CPU_LAST_IRQ		(LOONGSON_CPU_IRQ_BASE + 15)
=20
 #define LOONGSON_PCH_IRQ_BASE		64
 #define LOONGSON_PCH_ACPI_IRQ		(LOONGSON_PCH_IRQ_BASE + 47)
@@ -88,20 +99,8 @@ struct acpi_madt_bio_pic;
 struct acpi_madt_msi_pic;
 struct acpi_madt_lpc_pic;
=20
-int liointc_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_lio_pic *acpi_liointc);
-int eiointc_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_eio_pic *acpi_eiointc);
-
-int htvec_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_ht_pic *acpi_htvec);
-int pch_lpc_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_lpc_pic *acpi_pchlpc);
-int pch_msi_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_msi_pic *acpi_pchmsi);
-int pch_pic_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_bio_pic *acpi_pchpic);
-int find_pch_pic(u32 gsi);
+void complete_irq_moving(void);
+
 struct fwnode_handle *get_pch_msi_handle(int pci_segment);
=20
 extern struct acpi_madt_lio_pic *acpi_liointc;
diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/=
asm/loongarch.h
index 04a78010fc72..631d249b3ef2 100644
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
=20
 #define LOONGARCH_CSR_ERA		0x6	/* ERA */
=20
@@ -649,6 +649,13 @@
=20
 #define LOONGARCH_CSR_CTAG		0x98	/* TagLo + TagHi */
=20
+#define LOONGARCH_CSR_ISR0		0xa0
+#define LOONGARCH_CSR_ISR1		0xa1
+#define LOONGARCH_CSR_ISR2		0xa2
+#define LOONGARCH_CSR_ISR3		0xa3
+
+#define LOONGARCH_CSR_IRR		0xa4
+
 #define LOONGARCH_CSR_PRID		0xc0
=20
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
=20
 #define LOONGARCH_IOCSR_VENDOR		0x10
=20
@@ -1065,6 +1073,7 @@
 #define  IOCSR_MISC_FUNC_SOFT_INT	BIT_ULL(10)
 #define  IOCSR_MISC_FUNC_TIMER_RESET	BIT_ULL(21)
 #define  IOCSR_MISC_FUNC_EXT_IOI_EN	BIT_ULL(48)
+#define  IOCSR_MISC_FUNC_AVEC_EN	BIT_ULL(51)
=20
 #define LOONGARCH_IOCSR_CPUTEMP		0x428
=20
@@ -1387,9 +1396,10 @@ __BUILD_CSR_OP(tlbidx)
 #define INT_TI		11	/* Timer */
 #define INT_IPI		12
 #define INT_NMI		13
+#define INT_AVEC	14
=20
 /* ExcCodes corresponding to interrupts */
-#define EXCCODE_INT_NUM		(INT_NMI + 1)
+#define EXCCODE_INT_NUM		(INT_AVEC + 1)
 #define EXCCODE_INT_START	64
 #define EXCCODE_INT_END		(EXCCODE_INT_START + EXCCODE_INT_NUM - 1)
=20
diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/sm=
p.h
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
=20
 struct secondary_data {
 	unsigned long stack;
diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-pr=
obe.c
index 55320813ee08..14f0449f5452 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -106,7 +106,6 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
 		elf_hwcap |=3D HWCAP_LOONGARCH_CRC32;
 	}
=20
-
 	config =3D read_cpucfg(LOONGARCH_CPUCFG2);
 	if (config & CPUCFG2_LAM) {
 		c->options |=3D LOONGARCH_CPU_LAM;
@@ -174,6 +173,8 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
 		c->options |=3D LOONGARCH_CPU_FLATMODE;
 	if (config & IOCSRF_EIODECODE)
 		c->options |=3D LOONGARCH_CPU_EIODECODE;
+	if (config & IOCSRF_AVEC)
+		c->options |=3D LOONGARCH_CPU_AVECINT;
 	if (config & IOCSRF_VM)
 		c->options |=3D LOONGARCH_CPU_HYPERVISOR;
=20
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index f4991c03514f..414f5249d70a 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -87,6 +87,18 @@ static void __init init_vec_parent_group(void)
 	acpi_table_parse(ACPI_SIG_MCFG, early_pci_mcfg_parse);
 }
=20
+int __init arch_probe_nr_irqs(void)
+{
+	int nr_io_pics =3D bitmap_weight(loongson_sysconf.cores_io_master, NR_CPUS);
+
+	if (!cpu_has_avecint)
+		nr_irqs =3D (64 + NR_VECTORS * nr_io_pics);
+	else
+		nr_irqs =3D (64 + NR_VECTORS * (nr_cpu_ids + nr_io_pics));
+
+	return NR_IRQS_LEGACY;
+}
+
 void __init init_IRQ(void)
 {
 	int i;
diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravir=
t.c
index 9c9b75b76f62..4d736a4e488d 100644
--- a/arch/loongarch/kernel/paravirt.c
+++ b/arch/loongarch/kernel/paravirt.c
@@ -134,6 +134,11 @@ static irqreturn_t pv_ipi_interrupt(int irq, void *dev)
 		info->ipi_irqs[IPI_IRQ_WORK]++;
 	}
=20
+	if (action & SMP_CLEAR_VECTOR) {
+		complete_irq_moving();
+		info->ipi_irqs[IPI_CLEAR_VECTOR]++;
+	}
+
 	return IRQ_HANDLED;
 }
=20
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index ca405ab86aae..4adbbef3450a 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -72,6 +72,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string =
=3D {
 	[IPI_RESCHEDULE] =3D "Rescheduling interrupts",
 	[IPI_CALL_FUNCTION] =3D "Function call interrupts",
 	[IPI_IRQ_WORK] =3D "IRQ work interrupts",
+	[IPI_CLEAR_VECTOR] =3D "Clear vector interrupts",
 };
=20
 void show_ipi_list(struct seq_file *p, int prec)
@@ -248,6 +249,11 @@ static irqreturn_t loongson_ipi_interrupt(int irq, void =
*dev)
 		per_cpu(irq_stat, cpu).ipi_irqs[IPI_IRQ_WORK]++;
 	}
=20
+	if (action & SMP_CLEAR_VECTOR) {
+		complete_irq_moving();
+		per_cpu(irq_stat, cpu).ipi_irqs[IPI_CLEAR_VECTOR]++;
+	}
+
 	return IRQ_HANDLED;
 }
=20
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3c3c0c21b55..aa28157b1aaf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1128,7 +1128,7 @@ static void blk_complete_reqs(struct llist_head *list)
 		rq->q->mq_ops->complete(rq);
 }
=20
-static __latent_entropy void blk_done_softirq(struct softirq_action *h)
+static __latent_entropy void blk_done_softirq(void)
 {
 	blk_complete_reqs(this_cpu_ptr(&blk_cpu_done));
 }
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index d078bdc48c38..341cd9ca5a05 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -685,6 +685,7 @@ config LOONGSON_PCH_MSI
 	depends on PCI
 	default MACH_LOONGSON64
 	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_MSI_LIB
 	select PCI_MSI
 	help
 	  Support for the Loongson PCH MSI Controller.
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 15635812b2d6..e3679ec2b9f7 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -110,7 +110,7 @@ obj-$(CONFIG_LS1X_IRQ)			+=3D irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+=3D irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+=3D irq-ti-sci-inta.o
 obj-$(CONFIG_TI_PRUSS_INTC)		+=3D irq-pruss-intc.o
-obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+=3D irq-loongarch-cpu.o
+obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+=3D irq-loongarch-cpu.o irq-loongarch-avec=
.o
 obj-$(CONFIG_LOONGSON_LIOINTC)		+=3D irq-loongson-liointc.o
 obj-$(CONFIG_LOONGSON_EIOINTC)		+=3D irq-loongson-eiointc.o
 obj-$(CONFIG_LOONGSON_HTPIC)		+=3D irq-loongson-htpic.o
diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 5c534d9fd2b0..da5250f0155c 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -234,7 +234,10 @@ enum fiq_hwirq {
 	AIC_NR_FIQ
 };
=20
+/* True if UNCORE/UNCORE2 and Sn_... IPI registers are present and used (A11=
+) */
 static DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
+/* True if SYS_IMP_APL_IPI_RR_LOCAL_EL1 exists for local fast IPIs (M1+) */
+static DEFINE_STATIC_KEY_TRUE(use_local_fast_ipi);
=20
 struct aic_info {
 	int version;
@@ -252,6 +255,7 @@ struct aic_info {
=20
 	/* Features */
 	bool fast_ipi;
+	bool local_fast_ipi;
 };
=20
 static const struct aic_info aic1_info __initconst =3D {
@@ -270,17 +274,32 @@ static const struct aic_info aic1_fipi_info __initconst=
 =3D {
 	.fast_ipi	=3D true,
 };
=20
+static const struct aic_info aic1_local_fipi_info __initconst =3D {
+	.version	=3D 1,
+
+	.event		=3D AIC_EVENT,
+	.target_cpu	=3D AIC_TARGET_CPU,
+
+	.fast_ipi	=3D true,
+	.local_fast_ipi =3D true,
+};
+
 static const struct aic_info aic2_info __initconst =3D {
 	.version	=3D 2,
=20
 	.irq_cfg	=3D AIC2_IRQ_CFG,
=20
 	.fast_ipi	=3D true,
+	.local_fast_ipi =3D true,
 };
=20
 static const struct of_device_id aic_info_match[] =3D {
 	{
 		.compatible =3D "apple,t8103-aic",
+		.data =3D &aic1_local_fipi_info,
+	},
+	{
+		.compatible =3D "apple,t8015-aic",
 		.data =3D &aic1_fipi_info,
 	},
 	{
@@ -532,14 +551,9 @@ static void __exception_irq_entry aic_handle_fiq(struct =
pt_regs *regs)
 	 * we check for everything here, even things we don't support yet.
 	 */
=20
-	if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
-		if (static_branch_likely(&use_fast_ipi)) {
-			aic_handle_ipi(regs);
-		} else {
-			pr_err_ratelimited("Fast IPI fired. Acking.\n");
-			write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
-		}
-	}
+	if (static_branch_likely(&use_fast_ipi) &&
+	    (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING))
+		aic_handle_ipi(regs);
=20
 	if (TIMER_FIRING(read_sysreg(cntp_ctl_el0)))
 		generic_handle_domain_irq(aic_irqc->hw_domain,
@@ -574,8 +588,9 @@ static void __exception_irq_entry aic_handle_fiq(struct p=
t_regs *regs)
 					  AIC_FIQ_HWIRQ(irq));
 	}
=20
-	if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) =3D=3D U=
PMCR0_IMODE_FIQ &&
-			(read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
+	if (static_branch_likely(&use_fast_ipi) &&
+	    (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) =3D=3D =
UPMCR0_IMODE_FIQ) &&
+	    (read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
 		/* Same story with uncore PMCs */
 		pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
 		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
@@ -750,12 +765,12 @@ static void aic_ipi_send_fast(int cpu)
 	u64 cluster =3D MPIDR_CLUSTER(mpidr);
 	u64 idx =3D MPIDR_CPU(mpidr);
=20
-	if (MPIDR_CLUSTER(my_mpidr) =3D=3D cluster)
-		write_sysreg_s(FIELD_PREP(IPI_RR_CPU, idx),
-			       SYS_IMP_APL_IPI_RR_LOCAL_EL1);
-	else
+	if (static_branch_likely(&use_local_fast_ipi) && MPIDR_CLUSTER(my_mpidr) =
=3D=3D cluster) {
+		write_sysreg_s(FIELD_PREP(IPI_RR_CPU, idx), SYS_IMP_APL_IPI_RR_LOCAL_EL1);
+	} else {
 		write_sysreg_s(FIELD_PREP(IPI_RR_CPU, idx) | FIELD_PREP(IPI_RR_CLUSTER, cl=
uster),
 			       SYS_IMP_APL_IPI_RR_GLOBAL_EL1);
+	}
 	isb();
 }
=20
@@ -811,7 +826,8 @@ static int aic_init_cpu(unsigned int cpu)
 	/* Mask all hard-wired per-CPU IRQ/FIQ sources */
=20
 	/* Pending Fast IPI FIQs */
-	write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+	if (static_branch_likely(&use_fast_ipi))
+		write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
=20
 	/* Timer FIQs */
 	sysreg_clear_set(cntp_ctl_el0, 0, ARCH_TIMER_CTRL_IT_MASK);
@@ -832,8 +848,10 @@ static int aic_init_cpu(unsigned int cpu)
 			   FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_OFF));
=20
 	/* Uncore PMC FIQ */
-	sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
-			   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
+	if (static_branch_likely(&use_fast_ipi)) {
+		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
+				   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
+	}
=20
 	/* Commit all of the above */
 	isb();
@@ -987,11 +1005,12 @@ static int __init aic_of_ic_init(struct device_node *n=
ode, struct device_node *p
 	off +=3D sizeof(u32) * (irqc->max_irq >> 5); /* MASK_CLR */
 	off +=3D sizeof(u32) * (irqc->max_irq >> 5); /* HW_STATE */
=20
-	if (irqc->info.fast_ipi)
-		static_branch_enable(&use_fast_ipi);
-	else
+	if (!irqc->info.fast_ipi)
 		static_branch_disable(&use_fast_ipi);
=20
+	if (!irqc->info.local_fast_ipi)
+		static_branch_disable(&use_local_fast_ipi);
+
 	irqc->info.die_stride =3D off - start_off;
=20
 	irqc->hw_domain =3D irq_domain_create_tree(of_node_to_fwnode(node),
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index dce2b80bf439..d7c5ef248474 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Marvell Armada 370 and Armada XP SoC IRQ handling
  *
@@ -7,13 +8,11 @@
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  * Ben Dooks <ben.dooks@codethink.co.uk>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
=20
+#include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -66,19 +65,17 @@
  *                   device
  *
  * The "global interrupt mask/unmask" is modified using the
- * ARMADA_370_XP_INT_SET_ENABLE_OFFS and
- * ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS registers, which are relative
- * to "main_int_base".
+ * MPIC_INT_SET_ENABLE and MPIC_INT_CLEAR_ENABLE
+ * registers, which are relative to "mpic->base".
  *
- * The "per-CPU mask/unmask" is modified using the
- * ARMADA_370_XP_INT_SET_MASK_OFFS and
- * ARMADA_370_XP_INT_CLEAR_MASK_OFFS registers, which are relative to
- * "per_cpu_int_base". This base address points to a special address,
+ * The "per-CPU mask/unmask" is modified using the MPIC_INT_SET_MASK
+ * and MPIC_INT_CLEAR_MASK registers, which are relative to
+ * "mpic->per_cpu". This base address points to a special address,
  * which automatically accesses the registers of the current CPU.
  *
  * The per-CPU mask/unmask can also be adjusted using the global
- * per-interrupt ARMADA_370_XP_INT_SOURCE_CTL register, which we use
- * to configure interrupt affinity.
+ * per-interrupt MPIC_INT_SOURCE_CTL register, which we use to
+ * configure interrupt affinity.
  *
  * Due to this model, all interrupts need to be mask/unmasked at two
  * different levels: at the global level and at the per-CPU level.
@@ -92,9 +89,8 @@
  *    the current CPU, running the ->map() code. This allows to have
  *    the interrupt unmasked at this level in non-SMP
  *    configurations. In SMP configurations, the ->set_affinity()
- *    callback is called, which using the
- *    ARMADA_370_XP_INT_SOURCE_CTL() readjusts the per-CPU mask/unmask
- *    for the interrupt.
+ *    callback is called, which using the MPIC_INT_SOURCE_CTL()
+ *    readjusts the per-CPU mask/unmask for the interrupt.
  *
  *    The ->mask() and ->unmask() operations only mask/unmask the
  *    interrupt at the "global" level.
@@ -116,58 +112,84 @@
  *    at the per-CPU level.
  */
=20
-/* Registers relative to main_int_base */
-#define ARMADA_370_XP_INT_CONTROL		(0x00)
-#define ARMADA_370_XP_SW_TRIG_INT_OFFS		(0x04)
-#define ARMADA_370_XP_INT_SET_ENABLE_OFFS	(0x30)
-#define ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS	(0x34)
-#define ARMADA_370_XP_INT_SOURCE_CTL(irq)	(0x100 + irq*4)
-#define ARMADA_370_XP_INT_SOURCE_CPU_MASK	0xF
-#define ARMADA_370_XP_INT_IRQ_FIQ_MASK(cpuid)	((BIT(0) | BIT(8)) << cpuid)
-
-/* Registers relative to per_cpu_int_base */
-#define ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS	(0x08)
-#define ARMADA_370_XP_IN_DRBEL_MSK_OFFS		(0x0c)
-#define ARMADA_375_PPI_CAUSE			(0x10)
-#define ARMADA_370_XP_CPU_INTACK_OFFS		(0x44)
-#define ARMADA_370_XP_INT_SET_MASK_OFFS		(0x48)
-#define ARMADA_370_XP_INT_CLEAR_MASK_OFFS	(0x4C)
-#define ARMADA_370_XP_INT_FABRIC_MASK_OFFS	(0x54)
-#define ARMADA_370_XP_INT_CAUSE_PERF(cpu)	(1 << cpu)
-
-#define ARMADA_370_XP_MAX_PER_CPU_IRQS		(28)
+/* Registers relative to mpic->base */
+#define MPIC_INT_CONTROL			0x00
+#define MPIC_INT_CONTROL_NUMINT_MASK		GENMASK(12, 2)
+#define MPIC_SW_TRIG_INT			0x04
+#define MPIC_INT_SET_ENABLE			0x30
+#define MPIC_INT_CLEAR_ENABLE			0x34
+#define MPIC_INT_SOURCE_CTL(hwirq)		(0x100 + (hwirq) * 4)
+#define MPIC_INT_SOURCE_CPU_MASK		GENMASK(3, 0)
+#define MPIC_INT_IRQ_FIQ_MASK(cpuid)		((BIT(0) | BIT(8)) << (cpuid))
+
+/* Registers relative to mpic->per_cpu */
+#define MPIC_IN_DRBEL_CAUSE			0x08
+#define MPIC_IN_DRBEL_MASK			0x0c
+#define MPIC_PPI_CAUSE				0x10
+#define MPIC_CPU_INTACK				0x44
+#define MPIC_CPU_INTACK_IID_MASK		GENMASK(9, 0)
+#define MPIC_INT_SET_MASK			0x48
+#define MPIC_INT_CLEAR_MASK			0x4C
+#define MPIC_INT_FABRIC_MASK			0x54
+#define MPIC_INT_CAUSE_PERF(cpu)		BIT(cpu)
+
+#define MPIC_PER_CPU_IRQS_NR			29
=20
 /* IPI and MSI interrupt definitions for IPI platforms */
-#define IPI_DOORBELL_START                      (0)
-#define IPI_DOORBELL_END                        (8)
-#define IPI_DOORBELL_MASK                       0xFF
-#define PCI_MSI_DOORBELL_START                  (16)
-#define PCI_MSI_DOORBELL_NR                     (16)
-#define PCI_MSI_DOORBELL_END                    (32)
-#define PCI_MSI_DOORBELL_MASK                   0xFFFF0000
+#define IPI_DOORBELL_NR				8
+#define IPI_DOORBELL_MASK			GENMASK(7, 0)
+#define PCI_MSI_DOORBELL_START			16
+#define PCI_MSI_DOORBELL_NR			16
+#define PCI_MSI_DOORBELL_MASK			GENMASK(31, 16)
=20
 /* MSI interrupt definitions for non-IPI platforms */
 #define PCI_MSI_FULL_DOORBELL_START		0
 #define PCI_MSI_FULL_DOORBELL_NR		32
-#define PCI_MSI_FULL_DOORBELL_END		32
 #define PCI_MSI_FULL_DOORBELL_MASK		GENMASK(31, 0)
 #define PCI_MSI_FULL_DOORBELL_SRC0_MASK		GENMASK(15, 0)
 #define PCI_MSI_FULL_DOORBELL_SRC1_MASK		GENMASK(31, 16)
=20
-static void __iomem *per_cpu_int_base;
-static void __iomem *main_int_base;
-static struct irq_domain *armada_370_xp_mpic_domain;
-static u32 doorbell_mask_reg;
-static int parent_irq;
+/**
+ * struct mpic - MPIC private data structure
+ * @base:		MPIC registers base address
+ * @per_cpu:		per-CPU registers base address
+ * @parent_irq:		parent IRQ if MPIC is not top-level interrupt controller
+ * @domain:		MPIC main interrupt domain
+ * @ipi_domain:		IPI domain
+ * @msi_domain:		MSI domain
+ * @msi_inner_domain:	MSI inner domain
+ * @msi_used:		bitmap of used MSI numbers
+ * @msi_lock:		mutex serializing access to @msi_used
+ * @msi_doorbell_addr:	physical address of MSI doorbell register
+ * @msi_doorbell_mask:	mask of available doorbell bits for MSIs (either PCI_=
MSI_DOORBELL_MASK or
+ *			PCI_MSI_FULL_DOORBELL_MASK)
+ * @msi_doorbell_start:	first set bit in @msi_doorbell_mask
+ * @msi_doorbell_size:	number of set bits in @msi_doorbell_mask
+ * @doorbell_mask:	doorbell mask of MSIs and IPIs, stored on suspend, restor=
ed on resume
+ */
+struct mpic {
+	void __iomem *base;
+	void __iomem *per_cpu;
+	int parent_irq;
+	struct irq_domain *domain;
+#ifdef CONFIG_SMP
+	struct irq_domain *ipi_domain;
+#endif
 #ifdef CONFIG_PCI_MSI
-static struct irq_domain *armada_370_xp_msi_domain;
-static struct irq_domain *armada_370_xp_msi_inner_domain;
-static DECLARE_BITMAP(msi_used, PCI_MSI_FULL_DOORBELL_NR);
-static DEFINE_MUTEX(msi_used_lock);
-static phys_addr_t msi_doorbell_addr;
+	struct irq_domain *msi_domain;
+	struct irq_domain *msi_inner_domain;
+	DECLARE_BITMAP(msi_used, PCI_MSI_FULL_DOORBELL_NR);
+	struct mutex msi_lock;
+	phys_addr_t msi_doorbell_addr;
+	u32 msi_doorbell_mask;
+	unsigned int msi_doorbell_start, msi_doorbell_size;
 #endif
+	u32 doorbell_mask;
+};
+
+static struct mpic *mpic_data __ro_after_init;
=20
-static inline bool is_ipi_available(void)
+static inline bool mpic_is_ipi_available(struct mpic *mpic)
 {
 	/*
 	 * We distinguish IPI availability in the IC by the IC not having a
@@ -175,39 +197,12 @@ static inline bool is_ipi_available(void)
 	 * interrupt controller (e.g. GIC) that takes care of inter-processor
 	 * interrupts.
 	 */
-	return parent_irq <=3D 0;
-}
-
-static inline u32 msi_doorbell_mask(void)
-{
-	return is_ipi_available() ? PCI_MSI_DOORBELL_MASK :
-				    PCI_MSI_FULL_DOORBELL_MASK;
-}
-
-static inline unsigned int msi_doorbell_start(void)
-{
-	return is_ipi_available() ? PCI_MSI_DOORBELL_START :
-				    PCI_MSI_FULL_DOORBELL_START;
+	return mpic->parent_irq <=3D 0;
 }
=20
-static inline unsigned int msi_doorbell_size(void)
+static inline bool mpic_is_percpu_irq(irq_hw_number_t hwirq)
 {
-	return is_ipi_available() ? PCI_MSI_DOORBELL_NR :
-				    PCI_MSI_FULL_DOORBELL_NR;
-}
-
-static inline unsigned int msi_doorbell_end(void)
-{
-	return is_ipi_available() ? PCI_MSI_DOORBELL_END :
-				    PCI_MSI_FULL_DOORBELL_END;
-}
-
-static inline bool is_percpu_irq(irq_hw_number_t irq)
-{
-	if (irq <=3D ARMADA_370_XP_MAX_PER_CPU_IRQS)
-		return true;
-
-	return false;
+	return hwirq < MPIC_PER_CPU_IRQS_NR;
 }
=20
 /*
@@ -215,55 +210,53 @@ static inline bool is_percpu_irq(irq_hw_number_t irq)
  * For shared global interrupts, mask/unmask global enable bit
  * For CPU interrupts, mask/unmask the calling CPU's bit
  */
-static void armada_370_xp_irq_mask(struct irq_data *d)
+static void mpic_irq_mask(struct irq_data *d)
 {
+	struct mpic *mpic =3D irq_data_get_irq_chip_data(d);
 	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
=20
-	if (!is_percpu_irq(hwirq))
-		writel(hwirq, main_int_base +
-				ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS);
+	if (!mpic_is_percpu_irq(hwirq))
+		writel(hwirq, mpic->base + MPIC_INT_CLEAR_ENABLE);
 	else
-		writel(hwirq, per_cpu_int_base +
-				ARMADA_370_XP_INT_SET_MASK_OFFS);
+		writel(hwirq, mpic->per_cpu + MPIC_INT_SET_MASK);
 }
=20
-static void armada_370_xp_irq_unmask(struct irq_data *d)
+static void mpic_irq_unmask(struct irq_data *d)
 {
+	struct mpic *mpic =3D irq_data_get_irq_chip_data(d);
 	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
=20
-	if (!is_percpu_irq(hwirq))
-		writel(hwirq, main_int_base +
-				ARMADA_370_XP_INT_SET_ENABLE_OFFS);
+	if (!mpic_is_percpu_irq(hwirq))
+		writel(hwirq, mpic->base + MPIC_INT_SET_ENABLE);
 	else
-		writel(hwirq, per_cpu_int_base +
-				ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+		writel(hwirq, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
 }
=20
 #ifdef CONFIG_PCI_MSI
=20
-static struct irq_chip armada_370_xp_msi_irq_chip =3D {
-	.name =3D "MPIC MSI",
-	.irq_mask =3D pci_msi_mask_irq,
-	.irq_unmask =3D pci_msi_unmask_irq,
+static struct irq_chip mpic_msi_irq_chip =3D {
+	.name		=3D "MPIC MSI",
+	.irq_mask	=3D pci_msi_mask_irq,
+	.irq_unmask	=3D pci_msi_unmask_irq,
 };
=20
-static struct msi_domain_info armada_370_xp_msi_domain_info =3D {
+static struct msi_domain_info mpic_msi_domain_info =3D {
 	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
 		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
-	.chip	=3D &armada_370_xp_msi_irq_chip,
+	.chip	=3D &mpic_msi_irq_chip,
 };
=20
-static void armada_370_xp_compose_msi_msg(struct irq_data *data, struct msi_=
msg *msg)
+static void mpic_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 {
-	unsigned int cpu =3D cpumask_first(irq_data_get_effective_affinity_mask(dat=
a));
+	unsigned int cpu =3D cpumask_first(irq_data_get_effective_affinity_mask(d));
+	struct mpic *mpic =3D irq_data_get_irq_chip_data(d);
=20
-	msg->address_lo =3D lower_32_bits(msi_doorbell_addr);
-	msg->address_hi =3D upper_32_bits(msi_doorbell_addr);
-	msg->data =3D BIT(cpu + 8) | (data->hwirq + msi_doorbell_start());
+	msg->address_lo =3D lower_32_bits(mpic->msi_doorbell_addr);
+	msg->address_hi =3D upper_32_bits(mpic->msi_doorbell_addr);
+	msg->data =3D BIT(cpu + 8) | (d->hwirq + mpic->msi_doorbell_start);
 }
=20
-static int armada_370_xp_msi_set_affinity(struct irq_data *irq_data,
-					  const struct cpumask *mask, bool force)
+static int mpic_msi_set_affinity(struct irq_data *d, const struct cpumask *m=
ask, bool force)
 {
 	unsigned int cpu;
=20
@@ -275,33 +268,34 @@ static int armada_370_xp_msi_set_affinity(struct irq_da=
ta *irq_data,
 	if (cpu >=3D nr_cpu_ids)
 		return -EINVAL;
=20
-	irq_data_update_effective_affinity(irq_data, cpumask_of(cpu));
+	irq_data_update_effective_affinity(d, cpumask_of(cpu));
=20
 	return IRQ_SET_MASK_OK;
 }
=20
-static struct irq_chip armada_370_xp_msi_bottom_irq_chip =3D {
+static struct irq_chip mpic_msi_bottom_irq_chip =3D {
 	.name			=3D "MPIC MSI",
-	.irq_compose_msi_msg	=3D armada_370_xp_compose_msi_msg,
-	.irq_set_affinity	=3D armada_370_xp_msi_set_affinity,
+	.irq_compose_msi_msg	=3D mpic_compose_msi_msg,
+	.irq_set_affinity	=3D mpic_msi_set_affinity,
 };
=20
-static int armada_370_xp_msi_alloc(struct irq_domain *domain, unsigned int v=
irq,
-				   unsigned int nr_irqs, void *args)
+static int mpic_msi_alloc(struct irq_domain *domain, unsigned int virq, unsi=
gned int nr_irqs,
+			  void *args)
 {
-	int hwirq, i;
+	struct mpic *mpic =3D domain->host_data;
+	int hwirq;
=20
-	mutex_lock(&msi_used_lock);
-	hwirq =3D bitmap_find_free_region(msi_used, msi_doorbell_size(),
+	mutex_lock(&mpic->msi_lock);
+	hwirq =3D bitmap_find_free_region(mpic->msi_used, mpic->msi_doorbell_size,
 					order_base_2(nr_irqs));
-	mutex_unlock(&msi_used_lock);
+	mutex_unlock(&mpic->msi_lock);
=20
 	if (hwirq < 0)
 		return -ENOSPC;
=20
-	for (i =3D 0; i < nr_irqs; i++) {
+	for (unsigned int i =3D 0; i < nr_irqs; i++) {
 		irq_domain_set_info(domain, virq + i, hwirq + i,
-				    &armada_370_xp_msi_bottom_irq_chip,
+				    &mpic_msi_bottom_irq_chip,
 				    domain->host_data, handle_simple_irq,
 				    NULL, NULL);
 	}
@@ -309,76 +303,84 @@ static int armada_370_xp_msi_alloc(struct irq_domain *d=
omain, unsigned int virq,
 	return 0;
 }
=20
-static void armada_370_xp_msi_free(struct irq_domain *domain,
-				   unsigned int virq, unsigned int nr_irqs)
+static void mpic_msi_free(struct irq_domain *domain, unsigned int virq, unsi=
gned int nr_irqs)
 {
 	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
+	struct mpic *mpic =3D domain->host_data;
=20
-	mutex_lock(&msi_used_lock);
-	bitmap_release_region(msi_used, d->hwirq, order_base_2(nr_irqs));
-	mutex_unlock(&msi_used_lock);
+	mutex_lock(&mpic->msi_lock);
+	bitmap_release_region(mpic->msi_used, d->hwirq, order_base_2(nr_irqs));
+	mutex_unlock(&mpic->msi_lock);
 }
=20
-static const struct irq_domain_ops armada_370_xp_msi_domain_ops =3D {
-	.alloc	=3D armada_370_xp_msi_alloc,
-	.free	=3D armada_370_xp_msi_free,
+static const struct irq_domain_ops mpic_msi_domain_ops =3D {
+	.alloc	=3D mpic_msi_alloc,
+	.free	=3D mpic_msi_free,
 };
=20
-static void armada_370_xp_msi_reenable_percpu(void)
+static void mpic_msi_reenable_percpu(struct mpic *mpic)
 {
 	u32 reg;
=20
 	/* Enable MSI doorbell mask and combined cpu local interrupt */
-	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
-	reg |=3D msi_doorbell_mask();
-	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	reg =3D readl(mpic->per_cpu + MPIC_IN_DRBEL_MASK);
+	reg |=3D mpic->msi_doorbell_mask;
+	writel(reg, mpic->per_cpu + MPIC_IN_DRBEL_MASK);
=20
 	/* Unmask local doorbell interrupt */
-	writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+	writel(1, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
 }
=20
-static int armada_370_xp_msi_init(struct device_node *node,
-				  phys_addr_t main_int_phys_base)
+static int __init mpic_msi_init(struct mpic *mpic, struct device_node *node,
+				phys_addr_t main_int_phys_base)
 {
-	msi_doorbell_addr =3D main_int_phys_base +
-		ARMADA_370_XP_SW_TRIG_INT_OFFS;
+	mpic->msi_doorbell_addr =3D main_int_phys_base + MPIC_SW_TRIG_INT;
+
+	mutex_init(&mpic->msi_lock);
+
+	if (mpic_is_ipi_available(mpic)) {
+		mpic->msi_doorbell_start =3D PCI_MSI_DOORBELL_START;
+		mpic->msi_doorbell_size =3D PCI_MSI_DOORBELL_NR;
+		mpic->msi_doorbell_mask =3D PCI_MSI_DOORBELL_MASK;
+	} else {
+		mpic->msi_doorbell_start =3D PCI_MSI_FULL_DOORBELL_START;
+		mpic->msi_doorbell_size =3D PCI_MSI_FULL_DOORBELL_NR;
+		mpic->msi_doorbell_mask =3D PCI_MSI_FULL_DOORBELL_MASK;
+	}
=20
-	armada_370_xp_msi_inner_domain =3D
-		irq_domain_add_linear(NULL, msi_doorbell_size(),
-				      &armada_370_xp_msi_domain_ops, NULL);
-	if (!armada_370_xp_msi_inner_domain)
+	mpic->msi_inner_domain =3D irq_domain_add_linear(NULL, mpic->msi_doorbell_s=
ize,
+						       &mpic_msi_domain_ops, mpic);
+	if (!mpic->msi_inner_domain)
 		return -ENOMEM;
=20
-	armada_370_xp_msi_domain =3D
-		pci_msi_create_irq_domain(of_node_to_fwnode(node),
-					  &armada_370_xp_msi_domain_info,
-					  armada_370_xp_msi_inner_domain);
-	if (!armada_370_xp_msi_domain) {
-		irq_domain_remove(armada_370_xp_msi_inner_domain);
+	mpic->msi_domain =3D pci_msi_create_irq_domain(of_node_to_fwnode(node), &mp=
ic_msi_domain_info,
+						     mpic->msi_inner_domain);
+	if (!mpic->msi_domain) {
+		irq_domain_remove(mpic->msi_inner_domain);
 		return -ENOMEM;
 	}
=20
-	armada_370_xp_msi_reenable_percpu();
+	mpic_msi_reenable_percpu(mpic);
=20
 	/* Unmask low 16 MSI irqs on non-IPI platforms */
-	if (!is_ipi_available())
-		writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+	if (!mpic_is_ipi_available(mpic))
+		writel(0, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
=20
 	return 0;
 }
 #else
-static __maybe_unused void armada_370_xp_msi_reenable_percpu(void) {}
+static __maybe_unused void mpic_msi_reenable_percpu(struct mpic *mpic) {}
=20
-static inline int armada_370_xp_msi_init(struct device_node *node,
-					 phys_addr_t main_int_phys_base)
+static inline int mpic_msi_init(struct mpic *mpic, struct device_node *node,
+				phys_addr_t main_int_phys_base)
 {
 	return 0;
 }
 #endif
=20
-static void armada_xp_mpic_perf_init(void)
+static void mpic_perf_init(struct mpic *mpic)
 {
-	unsigned long cpuid;
+	u32 cpuid;
=20
 	/*
 	 * This Performance Counter Overflow interrupt is specific for
@@ -390,38 +392,39 @@ static void armada_xp_mpic_perf_init(void)
 	cpuid =3D cpu_logical_map(smp_processor_id());
=20
 	/* Enable Performance Counter Overflow interrupts */
-	writel(ARMADA_370_XP_INT_CAUSE_PERF(cpuid),
-	       per_cpu_int_base + ARMADA_370_XP_INT_FABRIC_MASK_OFFS);
+	writel(MPIC_INT_CAUSE_PERF(cpuid), mpic->per_cpu + MPIC_INT_FABRIC_MASK);
 }
=20
 #ifdef CONFIG_SMP
-static struct irq_domain *ipi_domain;
-
-static void armada_370_xp_ipi_mask(struct irq_data *d)
+static void mpic_ipi_mask(struct irq_data *d)
 {
+	struct mpic *mpic =3D irq_data_get_irq_chip_data(d);
 	u32 reg;
-	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+
+	reg =3D readl(mpic->per_cpu + MPIC_IN_DRBEL_MASK);
 	reg &=3D ~BIT(d->hwirq);
-	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	writel(reg, mpic->per_cpu + MPIC_IN_DRBEL_MASK);
 }
=20
-static void armada_370_xp_ipi_unmask(struct irq_data *d)
+static void mpic_ipi_unmask(struct irq_data *d)
 {
+	struct mpic *mpic =3D irq_data_get_irq_chip_data(d);
 	u32 reg;
-	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+
+	reg =3D readl(mpic->per_cpu + MPIC_IN_DRBEL_MASK);
 	reg |=3D BIT(d->hwirq);
-	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	writel(reg, mpic->per_cpu + MPIC_IN_DRBEL_MASK);
 }
=20
-static void armada_370_xp_ipi_send_mask(struct irq_data *d,
-					const struct cpumask *mask)
+static void mpic_ipi_send_mask(struct irq_data *d, const struct cpumask *mas=
k)
 {
-	unsigned long map =3D 0;
-	int cpu;
+	struct mpic *mpic =3D irq_data_get_irq_chip_data(d);
+	unsigned int cpu;
+	u32 map =3D 0;
=20
 	/* Convert our logical CPU mask into a physical one. */
 	for_each_cpu(cpu, mask)
-		map |=3D 1 << cpu_logical_map(cpu);
+		map |=3D BIT(cpu_logical_map(cpu));
=20
 	/*
 	 * Ensure that stores to Normal memory are visible to the
@@ -430,451 +433,465 @@ static void armada_370_xp_ipi_send_mask(struct irq_da=
ta *d,
 	dsb();
=20
 	/* submit softirq */
-	writel((map << 8) | d->hwirq, main_int_base +
-		ARMADA_370_XP_SW_TRIG_INT_OFFS);
+	writel((map << 8) | d->hwirq, mpic->base + MPIC_SW_TRIG_INT);
 }
=20
-static void armada_370_xp_ipi_ack(struct irq_data *d)
+static void mpic_ipi_ack(struct irq_data *d)
 {
-	writel(~BIT(d->hwirq), per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS=
);
+	struct mpic *mpic =3D irq_data_get_irq_chip_data(d);
+
+	writel(~BIT(d->hwirq), mpic->per_cpu + MPIC_IN_DRBEL_CAUSE);
 }
=20
-static struct irq_chip ipi_irqchip =3D {
+static struct irq_chip mpic_ipi_irqchip =3D {
 	.name		=3D "IPI",
-	.irq_ack	=3D armada_370_xp_ipi_ack,
-	.irq_mask	=3D armada_370_xp_ipi_mask,
-	.irq_unmask	=3D armada_370_xp_ipi_unmask,
-	.ipi_send_mask	=3D armada_370_xp_ipi_send_mask,
+	.irq_ack	=3D mpic_ipi_ack,
+	.irq_mask	=3D mpic_ipi_mask,
+	.irq_unmask	=3D mpic_ipi_unmask,
+	.ipi_send_mask	=3D mpic_ipi_send_mask,
 };
=20
-static int armada_370_xp_ipi_alloc(struct irq_domain *d,
-					 unsigned int virq,
-					 unsigned int nr_irqs, void *args)
+static int mpic_ipi_alloc(struct irq_domain *d, unsigned int virq,
+			  unsigned int nr_irqs, void *args)
 {
-	int i;
-
-	for (i =3D 0; i < nr_irqs; i++) {
+	for (unsigned int i =3D 0; i < nr_irqs; i++) {
 		irq_set_percpu_devid(virq + i);
-		irq_domain_set_info(d, virq + i, i, &ipi_irqchip,
-				    d->host_data,
-				    handle_percpu_devid_irq,
-				    NULL, NULL);
+		irq_domain_set_info(d, virq + i, i, &mpic_ipi_irqchip, d->host_data,
+				    handle_percpu_devid_irq, NULL, NULL);
 	}
=20
 	return 0;
 }
=20
-static void armada_370_xp_ipi_free(struct irq_domain *d,
-					 unsigned int virq,
-					 unsigned int nr_irqs)
+static void mpic_ipi_free(struct irq_domain *d, unsigned int virq,
+			  unsigned int nr_irqs)
 {
 	/* Not freeing IPIs */
 }
=20
-static const struct irq_domain_ops ipi_domain_ops =3D {
-	.alloc	=3D armada_370_xp_ipi_alloc,
-	.free	=3D armada_370_xp_ipi_free,
+static const struct irq_domain_ops mpic_ipi_domain_ops =3D {
+	.alloc	=3D mpic_ipi_alloc,
+	.free	=3D mpic_ipi_free,
 };
=20
-static void ipi_resume(void)
+static void mpic_ipi_resume(struct mpic *mpic)
 {
-	int i;
-
-	for (i =3D 0; i < IPI_DOORBELL_END; i++) {
-		int irq;
+	for (irq_hw_number_t i =3D 0; i < IPI_DOORBELL_NR; i++) {
+		unsigned int virq =3D irq_find_mapping(mpic->ipi_domain, i);
+		struct irq_data *d;
=20
-		irq =3D irq_find_mapping(ipi_domain, i);
-		if (irq <=3D 0)
+		if (!virq || !irq_percpu_is_enabled(virq))
 			continue;
-		if (irq_percpu_is_enabled(irq)) {
-			struct irq_data *d;
-			d =3D irq_domain_get_irq_data(ipi_domain, irq);
-			armada_370_xp_ipi_unmask(d);
-		}
+
+		d =3D irq_domain_get_irq_data(mpic->ipi_domain, virq);
+		mpic_ipi_unmask(d);
 	}
 }
=20
-static __init void armada_xp_ipi_init(struct device_node *node)
+static int __init mpic_ipi_init(struct mpic *mpic, struct device_node *node)
 {
 	int base_ipi;
=20
-	ipi_domain =3D irq_domain_create_linear(of_node_to_fwnode(node),
-					      IPI_DOORBELL_END,
-					      &ipi_domain_ops, NULL);
-	if (WARN_ON(!ipi_domain))
-		return;
+	mpic->ipi_domain =3D irq_domain_create_linear(of_node_to_fwnode(node), IPI_=
DOORBELL_NR,
+						    &mpic_ipi_domain_ops, mpic);
+	if (WARN_ON(!mpic->ipi_domain))
+		return -ENOMEM;
=20
-	irq_domain_update_bus_token(ipi_domain, DOMAIN_BUS_IPI);
-	base_ipi =3D irq_domain_alloc_irqs(ipi_domain, IPI_DOORBELL_END, NUMA_NO_NO=
DE, NULL);
+	irq_domain_update_bus_token(mpic->ipi_domain, DOMAIN_BUS_IPI);
+	base_ipi =3D irq_domain_alloc_irqs(mpic->ipi_domain, IPI_DOORBELL_NR, NUMA_=
NO_NODE, NULL);
 	if (WARN_ON(!base_ipi))
-		return;
+		return -ENOMEM;
+
+	set_smp_ipi_range(base_ipi, IPI_DOORBELL_NR);
=20
-	set_smp_ipi_range(base_ipi, IPI_DOORBELL_END);
+	return 0;
 }
=20
-static int armada_xp_set_affinity(struct irq_data *d,
-				  const struct cpumask *mask_val, bool force)
+static int mpic_set_affinity(struct irq_data *d, const struct cpumask *mask_=
val, bool force)
 {
+	struct mpic *mpic =3D irq_data_get_irq_chip_data(d);
 	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
-	int cpu;
+	unsigned int cpu;
=20
 	/* Select a single core from the affinity mask which is online */
 	cpu =3D cpumask_any_and(mask_val, cpu_online_mask);
=20
-	atomic_io_modify(main_int_base + ARMADA_370_XP_INT_SOURCE_CTL(hwirq),
-			 ARMADA_370_XP_INT_SOURCE_CPU_MASK,
-			 BIT(cpu_logical_map(cpu)));
+	atomic_io_modify(mpic->base + MPIC_INT_SOURCE_CTL(hwirq),
+			 MPIC_INT_SOURCE_CPU_MASK, BIT(cpu_logical_map(cpu)));
=20
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
=20
 	return IRQ_SET_MASK_OK;
 }
=20
-static void armada_xp_mpic_smp_cpu_init(void)
+static void mpic_smp_cpu_init(struct mpic *mpic)
 {
-	u32 control;
-	int nr_irqs, i;
-
-	control =3D readl(main_int_base + ARMADA_370_XP_INT_CONTROL);
-	nr_irqs =3D (control >> 2) & 0x3ff;
+	for (irq_hw_number_t i =3D 0; i < mpic->domain->hwirq_max; i++)
+		writel(i, mpic->per_cpu + MPIC_INT_SET_MASK);
=20
-	for (i =3D 0; i < nr_irqs; i++)
-		writel(i, per_cpu_int_base + ARMADA_370_XP_INT_SET_MASK_OFFS);
-
-	if (!is_ipi_available())
+	if (!mpic_is_ipi_available(mpic))
 		return;
=20
 	/* Disable all IPIs */
-	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	writel(0, mpic->per_cpu + MPIC_IN_DRBEL_MASK);
=20
 	/* Clear pending IPIs */
-	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
+	writel(0, mpic->per_cpu + MPIC_IN_DRBEL_CAUSE);
=20
 	/* Unmask IPI interrupt */
-	writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+	writel(0, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
 }
=20
-static void armada_xp_mpic_reenable_percpu(void)
+static void mpic_reenable_percpu(struct mpic *mpic)
 {
-	unsigned int irq;
-
 	/* Re-enable per-CPU interrupts that were enabled before suspend */
-	for (irq =3D 0; irq < ARMADA_370_XP_MAX_PER_CPU_IRQS; irq++) {
-		struct irq_data *data;
-		int virq;
-
-		virq =3D irq_linear_revmap(armada_370_xp_mpic_domain, irq);
-		if (virq =3D=3D 0)
-			continue;
-
-		data =3D irq_get_irq_data(virq);
+	for (irq_hw_number_t i =3D 0; i < MPIC_PER_CPU_IRQS_NR; i++) {
+		unsigned int virq =3D irq_linear_revmap(mpic->domain, i);
+		struct irq_data *d;
=20
-		if (!irq_percpu_is_enabled(virq))
+		if (!virq || !irq_percpu_is_enabled(virq))
 			continue;
=20
-		armada_370_xp_irq_unmask(data);
+		d =3D irq_get_irq_data(virq);
+		mpic_irq_unmask(d);
 	}
=20
-	if (is_ipi_available())
-		ipi_resume();
+	if (mpic_is_ipi_available(mpic))
+		mpic_ipi_resume(mpic);
=20
-	armada_370_xp_msi_reenable_percpu();
+	mpic_msi_reenable_percpu(mpic);
 }
=20
-static int armada_xp_mpic_starting_cpu(unsigned int cpu)
+static int mpic_starting_cpu(unsigned int cpu)
 {
-	armada_xp_mpic_perf_init();
-	armada_xp_mpic_smp_cpu_init();
-	armada_xp_mpic_reenable_percpu();
+	struct mpic *mpic =3D irq_get_default_host()->host_data;
+
+	mpic_perf_init(mpic);
+	mpic_smp_cpu_init(mpic);
+	mpic_reenable_percpu(mpic);
+
 	return 0;
 }
=20
 static int mpic_cascaded_starting_cpu(unsigned int cpu)
 {
-	armada_xp_mpic_perf_init();
-	armada_xp_mpic_reenable_percpu();
-	enable_percpu_irq(parent_irq, IRQ_TYPE_NONE);
+	struct mpic *mpic =3D mpic_data;
+
+	mpic_perf_init(mpic);
+	mpic_reenable_percpu(mpic);
+	enable_percpu_irq(mpic->parent_irq, IRQ_TYPE_NONE);
+
 	return 0;
 }
 #else
-static void armada_xp_mpic_smp_cpu_init(void) {}
-static void ipi_resume(void) {}
+static void mpic_smp_cpu_init(struct mpic *mpic) {}
+static void mpic_ipi_resume(struct mpic *mpic) {}
 #endif
=20
-static struct irq_chip armada_370_xp_irq_chip =3D {
+static struct irq_chip mpic_irq_chip =3D {
 	.name		=3D "MPIC",
-	.irq_mask       =3D armada_370_xp_irq_mask,
-	.irq_mask_ack   =3D armada_370_xp_irq_mask,
-	.irq_unmask     =3D armada_370_xp_irq_unmask,
+	.irq_mask	=3D mpic_irq_mask,
+	.irq_mask_ack	=3D mpic_irq_mask,
+	.irq_unmask	=3D mpic_irq_unmask,
 #ifdef CONFIG_SMP
-	.irq_set_affinity =3D armada_xp_set_affinity,
+	.irq_set_affinity =3D mpic_set_affinity,
 #endif
 	.flags		=3D IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
 };
=20
-static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
-				      unsigned int virq, irq_hw_number_t hw)
+static int mpic_irq_map(struct irq_domain *domain, unsigned int virq, irq_hw=
_number_t hwirq)
 {
+	struct mpic *mpic =3D domain->host_data;
+
 	/* IRQs 0 and 1 cannot be mapped, they are handled internally */
-	if (hw <=3D 1)
+	if (hwirq <=3D 1)
 		return -EINVAL;
=20
-	armada_370_xp_irq_mask(irq_get_irq_data(virq));
-	if (!is_percpu_irq(hw))
-		writel(hw, per_cpu_int_base +
-			ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+	irq_set_chip_data(virq, mpic);
+
+	mpic_irq_mask(irq_get_irq_data(virq));
+	if (!mpic_is_percpu_irq(hwirq))
+		writel(hwirq, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
 	else
-		writel(hw, main_int_base + ARMADA_370_XP_INT_SET_ENABLE_OFFS);
+		writel(hwirq, mpic->base + MPIC_INT_SET_ENABLE);
 	irq_set_status_flags(virq, IRQ_LEVEL);
=20
-	if (is_percpu_irq(hw)) {
+	if (mpic_is_percpu_irq(hwirq)) {
 		irq_set_percpu_devid(virq);
-		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
-					handle_percpu_devid_irq);
+		irq_set_chip_and_handler(virq, &mpic_irq_chip, handle_percpu_devid_irq);
 	} else {
-		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
-					handle_level_irq);
+		irq_set_chip_and_handler(virq, &mpic_irq_chip, handle_level_irq);
 		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(virq)));
 	}
 	irq_set_probe(virq);
-
 	return 0;
 }
=20
-static const struct irq_domain_ops armada_370_xp_mpic_irq_ops =3D {
-	.map =3D armada_370_xp_mpic_irq_map,
-	.xlate =3D irq_domain_xlate_onecell,
+static const struct irq_domain_ops mpic_irq_ops =3D {
+	.map	=3D mpic_irq_map,
+	.xlate	=3D irq_domain_xlate_onecell,
 };
=20
 #ifdef CONFIG_PCI_MSI
-static void armada_370_xp_handle_msi_irq(struct pt_regs *regs, bool is_chain=
ed)
+static void mpic_handle_msi_irq(struct mpic *mpic)
 {
-	u32 msimask, msinr;
-
-	msimask =3D readl_relaxed(per_cpu_int_base +
-				ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
-	msimask &=3D msi_doorbell_mask();
+	unsigned long cause;
+	unsigned int i;
=20
-	writel(~msimask, per_cpu_int_base +
-	       ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
+	cause =3D readl_relaxed(mpic->per_cpu + MPIC_IN_DRBEL_CAUSE);
+	cause &=3D mpic->msi_doorbell_mask;
+	writel(~cause, mpic->per_cpu + MPIC_IN_DRBEL_CAUSE);
=20
-	for (msinr =3D msi_doorbell_start();
-	     msinr < msi_doorbell_end(); msinr++) {
-		unsigned int irq;
+	for_each_set_bit(i, &cause, BITS_PER_LONG)
+		generic_handle_domain_irq(mpic->msi_inner_domain, i - mpic->msi_doorbell_s=
tart);
+}
+#else
+static void mpic_handle_msi_irq(struct mpic *mpic) {}
+#endif
=20
-		if (!(msimask & BIT(msinr)))
-			continue;
+#ifdef CONFIG_SMP
+static void mpic_handle_ipi_irq(struct mpic *mpic)
+{
+	unsigned long cause;
+	irq_hw_number_t i;
=20
-		irq =3D msinr - msi_doorbell_start();
+	cause =3D readl_relaxed(mpic->per_cpu + MPIC_IN_DRBEL_CAUSE);
+	cause &=3D IPI_DOORBELL_MASK;
=20
-		generic_handle_domain_irq(armada_370_xp_msi_inner_domain, irq);
-	}
+	for_each_set_bit(i, &cause, IPI_DOORBELL_NR)
+		generic_handle_domain_irq(mpic->ipi_domain, i);
 }
 #else
-static void armada_370_xp_handle_msi_irq(struct pt_regs *r, bool b) {}
+static inline void mpic_handle_ipi_irq(struct mpic *mpic) {}
 #endif
=20
-static void armada_370_xp_mpic_handle_cascade_irq(struct irq_desc *desc)
+static void mpic_handle_cascade_irq(struct irq_desc *desc)
 {
+	struct mpic *mpic =3D irq_desc_get_handler_data(desc);
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	unsigned long irqmap, irqn, irqsrc, cpuid;
+	unsigned long cause;
+	u32 irqsrc, cpuid;
+	irq_hw_number_t i;
=20
 	chained_irq_enter(chip, desc);
=20
-	irqmap =3D readl_relaxed(per_cpu_int_base + ARMADA_375_PPI_CAUSE);
+	cause =3D readl_relaxed(mpic->per_cpu + MPIC_PPI_CAUSE);
 	cpuid =3D cpu_logical_map(smp_processor_id());
=20
-	for_each_set_bit(irqn, &irqmap, BITS_PER_LONG) {
-		irqsrc =3D readl_relaxed(main_int_base +
-				       ARMADA_370_XP_INT_SOURCE_CTL(irqn));
+	for_each_set_bit(i, &cause, MPIC_PER_CPU_IRQS_NR) {
+		irqsrc =3D readl_relaxed(mpic->base + MPIC_INT_SOURCE_CTL(i));
=20
 		/* Check if the interrupt is not masked on current CPU.
 		 * Test IRQ (0-1) and FIQ (8-9) mask bits.
 		 */
-		if (!(irqsrc & ARMADA_370_XP_INT_IRQ_FIQ_MASK(cpuid)))
+		if (!(irqsrc & MPIC_INT_IRQ_FIQ_MASK(cpuid)))
 			continue;
=20
-		if (irqn =3D=3D 0 || irqn =3D=3D 1) {
-			armada_370_xp_handle_msi_irq(NULL, true);
+		if (i =3D=3D 0 || i =3D=3D 1) {
+			mpic_handle_msi_irq(mpic);
 			continue;
 		}
=20
-		generic_handle_domain_irq(armada_370_xp_mpic_domain, irqn);
+		generic_handle_domain_irq(mpic->domain, i);
 	}
=20
 	chained_irq_exit(chip, desc);
 }
=20
-static void __exception_irq_entry
-armada_370_xp_handle_irq(struct pt_regs *regs)
+static void __exception_irq_entry mpic_handle_irq(struct pt_regs *regs)
 {
-	u32 irqstat, irqnr;
+	struct mpic *mpic =3D irq_get_default_host()->host_data;
+	irq_hw_number_t i;
+	u32 irqstat;
=20
 	do {
-		irqstat =3D readl_relaxed(per_cpu_int_base +
-					ARMADA_370_XP_CPU_INTACK_OFFS);
-		irqnr =3D irqstat & 0x3FF;
+		irqstat =3D readl_relaxed(mpic->per_cpu + MPIC_CPU_INTACK);
+		i =3D FIELD_GET(MPIC_CPU_INTACK_IID_MASK, irqstat);
=20
-		if (irqnr > 1022)
+		if (i > 1022)
 			break;
=20
-		if (irqnr > 1) {
-			generic_handle_domain_irq(armada_370_xp_mpic_domain,
-						  irqnr);
-			continue;
-		}
+		if (i > 1)
+			generic_handle_domain_irq(mpic->domain, i);
=20
 		/* MSI handling */
-		if (irqnr =3D=3D 1)
-			armada_370_xp_handle_msi_irq(regs, false);
+		if (i =3D=3D 1)
+			mpic_handle_msi_irq(mpic);
=20
-#ifdef CONFIG_SMP
 		/* IPI Handling */
-		if (irqnr =3D=3D 0) {
-			unsigned long ipimask;
-			int ipi;
-
-			ipimask =3D readl_relaxed(per_cpu_int_base +
-						ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS)
-				& IPI_DOORBELL_MASK;
-
-			for_each_set_bit(ipi, &ipimask, IPI_DOORBELL_END)
-				generic_handle_domain_irq(ipi_domain, ipi);
-		}
-#endif
-
+		if (i =3D=3D 0)
+			mpic_handle_ipi_irq(mpic);
 	} while (1);
 }
=20
-static int armada_370_xp_mpic_suspend(void)
+static int mpic_suspend(void)
 {
-	doorbell_mask_reg =3D readl(per_cpu_int_base +
-				  ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	struct mpic *mpic =3D mpic_data;
+
+	mpic->doorbell_mask =3D readl(mpic->per_cpu + MPIC_IN_DRBEL_MASK);
+
 	return 0;
 }
=20
-static void armada_370_xp_mpic_resume(void)
+static void mpic_resume(void)
 {
+	struct mpic *mpic =3D mpic_data;
 	bool src0, src1;
-	int nirqs;
-	irq_hw_number_t irq;
=20
 	/* Re-enable interrupts */
-	nirqs =3D (readl(main_int_base + ARMADA_370_XP_INT_CONTROL) >> 2) & 0x3ff;
-	for (irq =3D 0; irq < nirqs; irq++) {
-		struct irq_data *data;
-		int virq;
+	for (irq_hw_number_t i =3D 0; i < mpic->domain->hwirq_max; i++) {
+		unsigned int virq =3D irq_linear_revmap(mpic->domain, i);
+		struct irq_data *d;
=20
-		virq =3D irq_linear_revmap(armada_370_xp_mpic_domain, irq);
-		if (virq =3D=3D 0)
+		if (!virq)
 			continue;
=20
-		data =3D irq_get_irq_data(virq);
+		d =3D irq_get_irq_data(virq);
=20
-		if (!is_percpu_irq(irq)) {
+		if (!mpic_is_percpu_irq(i)) {
 			/* Non per-CPU interrupts */
-			writel(irq, per_cpu_int_base +
-			       ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
-			if (!irqd_irq_disabled(data))
-				armada_370_xp_irq_unmask(data);
+			writel(i, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
+			if (!irqd_irq_disabled(d))
+				mpic_irq_unmask(d);
 		} else {
 			/* Per-CPU interrupts */
-			writel(irq, main_int_base +
-			       ARMADA_370_XP_INT_SET_ENABLE_OFFS);
+			writel(i, mpic->base + MPIC_INT_SET_ENABLE);
=20
 			/*
-			 * Re-enable on the current CPU,
-			 * armada_xp_mpic_reenable_percpu() will take
-			 * care of secondary CPUs when they come up.
+			 * Re-enable on the current CPU, mpic_reenable_percpu()
+			 * will take care of secondary CPUs when they come up.
 			 */
 			if (irq_percpu_is_enabled(virq))
-				armada_370_xp_irq_unmask(data);
+				mpic_irq_unmask(d);
 		}
 	}
=20
 	/* Reconfigure doorbells for IPIs and MSIs */
-	writel(doorbell_mask_reg,
-	       per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	writel(mpic->doorbell_mask, mpic->per_cpu + MPIC_IN_DRBEL_MASK);
=20
-	if (is_ipi_available()) {
-		src0 =3D doorbell_mask_reg & IPI_DOORBELL_MASK;
-		src1 =3D doorbell_mask_reg & PCI_MSI_DOORBELL_MASK;
+	if (mpic_is_ipi_available(mpic)) {
+		src0 =3D mpic->doorbell_mask & IPI_DOORBELL_MASK;
+		src1 =3D mpic->doorbell_mask & PCI_MSI_DOORBELL_MASK;
 	} else {
-		src0 =3D doorbell_mask_reg & PCI_MSI_FULL_DOORBELL_SRC0_MASK;
-		src1 =3D doorbell_mask_reg & PCI_MSI_FULL_DOORBELL_SRC1_MASK;
+		src0 =3D mpic->doorbell_mask & PCI_MSI_FULL_DOORBELL_SRC0_MASK;
+		src1 =3D mpic->doorbell_mask & PCI_MSI_FULL_DOORBELL_SRC1_MASK;
 	}
=20
 	if (src0)
-		writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+		writel(0, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
 	if (src1)
-		writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+		writel(1, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
=20
-	if (is_ipi_available())
-		ipi_resume();
+	if (mpic_is_ipi_available(mpic))
+		mpic_ipi_resume(mpic);
 }
=20
-static struct syscore_ops armada_370_xp_mpic_syscore_ops =3D {
-	.suspend	=3D armada_370_xp_mpic_suspend,
-	.resume		=3D armada_370_xp_mpic_resume,
+static struct syscore_ops mpic_syscore_ops =3D {
+	.suspend	=3D mpic_suspend,
+	.resume		=3D mpic_resume,
 };
=20
-static int __init armada_370_xp_mpic_of_init(struct device_node *node,
-					     struct device_node *parent)
+static int __init mpic_map_region(struct device_node *np, int index,
+				  void __iomem **base, phys_addr_t *phys_base)
 {
-	struct resource main_int_res, per_cpu_int_res;
-	int nr_irqs, i;
-	u32 control;
+	struct resource res;
+	int err;
+
+	err =3D of_address_to_resource(np, index, &res);
+	if (WARN_ON(err))
+		goto fail;
+
+	if (WARN_ON(!request_mem_region(res.start, resource_size(&res), np->full_na=
me))) {
+		err =3D -EBUSY;
+		goto fail;
+	}
+
+	*base =3D ioremap(res.start, resource_size(&res));
+	if (WARN_ON(!*base)) {
+		err =3D -ENOMEM;
+		goto fail;
+	}
=20
-	BUG_ON(of_address_to_resource(node, 0, &main_int_res));
-	BUG_ON(of_address_to_resource(node, 1, &per_cpu_int_res));
+	if (phys_base)
+		*phys_base =3D res.start;
=20
-	BUG_ON(!request_mem_region(main_int_res.start,
-				   resource_size(&main_int_res),
-				   node->full_name));
-	BUG_ON(!request_mem_region(per_cpu_int_res.start,
-				   resource_size(&per_cpu_int_res),
-				   node->full_name));
+	return 0;
+
+fail:
+	pr_err("%pOF: Unable to map resource %d: %pE\n", np, index, ERR_PTR(err));
+	return err;
+}
=20
-	main_int_base =3D ioremap(main_int_res.start,
-				resource_size(&main_int_res));
-	BUG_ON(!main_int_base);
+static int __init mpic_of_init(struct device_node *node, struct device_node =
*parent)
+{
+	phys_addr_t phys_base;
+	unsigned int nr_irqs;
+	struct mpic *mpic;
+	int err;
+
+	mpic =3D kzalloc(sizeof(*mpic), GFP_KERNEL);
+	if (WARN_ON(!mpic))
+		return -ENOMEM;
=20
-	per_cpu_int_base =3D ioremap(per_cpu_int_res.start,
-				   resource_size(&per_cpu_int_res));
-	BUG_ON(!per_cpu_int_base);
+	mpic_data =3D mpic;
=20
-	control =3D readl(main_int_base + ARMADA_370_XP_INT_CONTROL);
-	nr_irqs =3D (control >> 2) & 0x3ff;
+	err =3D mpic_map_region(node, 0, &mpic->base, &phys_base);
+	if (err)
+		return err;
=20
-	for (i =3D 0; i < nr_irqs; i++)
-		writel(i, main_int_base + ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS);
+	err =3D mpic_map_region(node, 1, &mpic->per_cpu, NULL);
+	if (err)
+		return err;
=20
-	armada_370_xp_mpic_domain =3D
-		irq_domain_add_linear(node, nr_irqs,
-				&armada_370_xp_mpic_irq_ops, NULL);
-	BUG_ON(!armada_370_xp_mpic_domain);
-	irq_domain_update_bus_token(armada_370_xp_mpic_domain, DOMAIN_BUS_WIRED);
+	nr_irqs =3D FIELD_GET(MPIC_INT_CONTROL_NUMINT_MASK, readl(mpic->base + MPIC=
_INT_CONTROL));
+
+	for (irq_hw_number_t i =3D 0; i < nr_irqs; i++)
+		writel(i, mpic->base + MPIC_INT_CLEAR_ENABLE);
+
+	/*
+	 * Initialize mpic->parent_irq before calling any other functions, since
+	 * it is used to distinguish between IPI and non-IPI platforms.
+	 */
+	mpic->parent_irq =3D irq_of_parse_and_map(node, 0);
=20
 	/*
-	 * Initialize parent_irq before calling any other functions, since it is
-	 * used to distinguish between IPI and non-IPI platforms.
+	 * On non-IPI platforms the driver currently supports only the per-CPU
+	 * interrupts (the first 29 interrupts). See mpic_handle_cascade_irq().
 	 */
-	parent_irq =3D irq_of_parse_and_map(node, 0);
+	if (!mpic_is_ipi_available(mpic))
+		nr_irqs =3D MPIC_PER_CPU_IRQS_NR;
+
+	mpic->domain =3D irq_domain_add_linear(node, nr_irqs, &mpic_irq_ops, mpic);
+	if (!mpic->domain) {
+		pr_err("%pOF: Unable to add IRQ domain\n", node);
+		return -ENOMEM;
+	}
+
+	irq_domain_update_bus_token(mpic->domain, DOMAIN_BUS_WIRED);
=20
 	/* Setup for the boot CPU */
-	armada_xp_mpic_perf_init();
-	armada_xp_mpic_smp_cpu_init();
+	mpic_perf_init(mpic);
+	mpic_smp_cpu_init(mpic);
=20
-	armada_370_xp_msi_init(node, main_int_res.start);
+	err =3D mpic_msi_init(mpic, node, phys_base);
+	if (err) {
+		pr_err("%pOF: Unable to initialize MSI domain\n", node);
+		return err;
+	}
=20
-	if (parent_irq <=3D 0) {
-		irq_set_default_host(armada_370_xp_mpic_domain);
-		set_handle_irq(armada_370_xp_handle_irq);
+	if (mpic_is_ipi_available(mpic)) {
+		irq_set_default_host(mpic->domain);
+		set_handle_irq(mpic_handle_irq);
 #ifdef CONFIG_SMP
-		armada_xp_ipi_init(node);
+		err =3D mpic_ipi_init(mpic, node);
+		if (err) {
+			pr_err("%pOF: Unable to initialize IPI domain\n", node);
+			return err;
+		}
+
 		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_ARMADA_XP_STARTING,
 					  "irqchip/armada/ipi:starting",
-					  armada_xp_mpic_starting_cpu, NULL);
+					  mpic_starting_cpu, NULL);
 #endif
 	} else {
 #ifdef CONFIG_SMP
@@ -882,13 +899,13 @@ static int __init armada_370_xp_mpic_of_init(struct dev=
ice_node *node,
 					  "irqchip/armada/cascade:starting",
 					  mpic_cascaded_starting_cpu, NULL);
 #endif
-		irq_set_chained_handler(parent_irq,
-					armada_370_xp_mpic_handle_cascade_irq);
+		irq_set_chained_handler_and_data(mpic->parent_irq,
+						 mpic_handle_cascade_irq, mpic);
 	}
=20
-	register_syscore_ops(&armada_370_xp_mpic_syscore_ops);
+	register_syscore_ops(&mpic_syscore_ops);
=20
 	return 0;
 }
=20
-IRQCHIP_DECLARE(armada_370_xp_mpic, "marvell,mpic", armada_370_xp_mpic_of_in=
it);
+IRQCHIP_DECLARE(marvell_mpic, "marvell,mpic", mpic_of_init);
diff --git a/drivers/irqchip/irq-atmel-aic.c b/drivers/irqchip/irq-atmel-aic.c
index 4631f6847953..3839ad79ad31 100644
--- a/drivers/irqchip/irq-atmel-aic.c
+++ b/drivers/irqchip/irq-atmel-aic.c
@@ -57,8 +57,7 @@
=20
 static struct irq_domain *aic_domain;
=20
-static asmlinkage void __exception_irq_entry
-aic_handle(struct pt_regs *regs)
+static void __exception_irq_entry aic_handle(struct pt_regs *regs)
 {
 	struct irq_domain_chip_generic *dgc =3D aic_domain->gc;
 	struct irq_chip_generic *gc =3D dgc->gc[0];
diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic=
5.c
index 145535bd7560..c0f55dc7b050 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -67,8 +67,7 @@
=20
 static struct irq_domain *aic5_domain;
=20
-static asmlinkage void __exception_irq_entry
-aic5_handle(struct pt_regs *regs)
+static void __exception_irq_entry aic5_handle(struct pt_regs *regs)
 {
 	struct irq_chip_generic *bgc =3D irq_get_domain_generic_chip(aic5_domain, 0=
);
 	u32 irqnr;
diff --git a/drivers/irqchip/irq-clps711x.c b/drivers/irqchip/irq-clps711x.c
index e731e0784f7e..806ebb1de201 100644
--- a/drivers/irqchip/irq-clps711x.c
+++ b/drivers/irqchip/irq-clps711x.c
@@ -69,7 +69,7 @@ static struct {
 	struct irq_domain_ops	ops;
 } *clps711x_intc;
=20
-static asmlinkage void __exception_irq_entry clps711x_irqh(struct pt_regs *r=
egs)
+static void __exception_irq_entry clps711x_irqh(struct pt_regs *regs)
 {
 	u32 irqstat;
=20
diff --git a/drivers/irqchip/irq-davinci-cp-intc.c b/drivers/irqchip/irq-davi=
nci-cp-intc.c
index 7482c8ed34b2..f4f8e9fadbbf 100644
--- a/drivers/irqchip/irq-davinci-cp-intc.c
+++ b/drivers/irqchip/irq-davinci-cp-intc.c
@@ -116,8 +116,7 @@ static struct irq_chip davinci_cp_intc_irq_chip =3D {
 	.flags		=3D IRQCHIP_SKIP_SET_WAKE,
 };
=20
-static asmlinkage void __exception_irq_entry
-davinci_cp_intc_handle_irq(struct pt_regs *regs)
+static void __exception_irq_entry davinci_cp_intc_handle_irq(struct pt_regs =
*regs)
 {
 	int gpir, irqnr, none;
=20
diff --git a/drivers/irqchip/irq-ftintc010.c b/drivers/irqchip/irq-ftintc010.c
index 359efc1d1be7..b91c358ea6db 100644
--- a/drivers/irqchip/irq-ftintc010.c
+++ b/drivers/irqchip/irq-ftintc010.c
@@ -125,7 +125,7 @@ static struct irq_chip ft010_irq_chip =3D {
 /* Local static for the IRQ entry call */
 static struct ft010_irq_data firq;
=20
-static asmlinkage void __exception_irq_entry ft010_irqchip_handle_irq(struct=
 pt_regs *regs)
+static void __exception_irq_entry ft010_irqchip_handle_irq(struct pt_regs *r=
egs)
 {
 	struct ft010_irq_data *f =3D &firq;
 	int irq;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index c19083bfb943..0efa3443c323 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -930,7 +930,7 @@ static void __gic_handle_irq_from_irqsoff(struct pt_regs =
*regs)
 	__gic_handle_nmi(irqnr, regs);
 }
=20
-static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *=
regs)
+static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	if (unlikely(gic_supports_nmi() && !interrupts_enabled(regs)))
 		__gic_handle_irq_from_irqsoff(regs);
diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index ca32ac19d284..58c28895f8c4 100644
--- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -97,7 +97,7 @@ bool gic_cpuif_has_vsgi(void)
=20
 	fld =3D cpuid_feature_extract_unsigned_field(reg, ID_AA64PFR0_EL1_GIC_SHIFT=
);
=20
-	return fld >=3D 0x3;
+	return fld >=3D ID_AA64PFR0_EL1_GIC_V4P1;
 }
 #else
 bool gic_cpuif_has_vsgi(void)
diff --git a/drivers/irqchip/irq-ixp4xx.c b/drivers/irqchip/irq-ixp4xx.c
index 5fba907b9052..f23b02f62a5c 100644
--- a/drivers/irqchip/irq-ixp4xx.c
+++ b/drivers/irqchip/irq-ixp4xx.c
@@ -105,8 +105,7 @@ static void ixp4xx_irq_unmask(struct irq_data *d)
 	}
 }
=20
-static asmlinkage void __exception_irq_entry
-ixp4xx_handle_irq(struct pt_regs *regs)
+static void __exception_irq_entry ixp4xx_handle_irq(struct pt_regs *regs)
 {
 	struct ixp4xx_irq *ixi =3D &ixirq;
 	unsigned long status;
diff --git a/drivers/irqchip/irq-loongarch-avec.c b/drivers/irqchip/irq-loong=
arch-avec.c
new file mode 100644
index 000000000000..0f6e465dd309
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
+	phys_addr_t		msi_base_addr;
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
+	struct pending_list *plist =3D per_cpu_ptr(&pending_list, cpu);
+
+	INIT_LIST_HEAD(&plist->head);
+}
+
+static void avecintc_sync(struct avecintc_data *adata)
+{
+	struct pending_list *plist;
+
+	if (cpu_online(adata->prev_cpu)) {
+		plist =3D per_cpu_ptr(&pending_list, adata->prev_cpu);
+		list_add_tail(&adata->entry, &plist->head);
+		adata->moving =3D 1;
+		mp_ops.send_ipi_single(adata->prev_cpu, ACTION_CLEAR_VECTOR);
+	}
+}
+
+static int avecintc_set_affinity(struct irq_data *data, const struct cpumask=
 *dest, bool force)
+{
+	int cpu, ret, vector;
+	struct avecintc_data *adata;
+
+	scoped_guard(raw_spinlock, &loongarch_avec.lock) {
+		adata =3D irq_data_get_irq_chip_data(data);
+
+		if (adata->moving)
+			return -EBUSY;
+
+		if (cpu_online(adata->cpu) && cpumask_test_cpu(adata->cpu, dest))
+			return 0;
+
+		cpumask_and(&intersect_mask, dest, cpu_online_mask);
+
+		ret =3D irq_matrix_alloc(loongarch_avec.vector_matrix, &intersect_mask, fa=
lse, &cpu);
+		if (ret < 0)
+			return ret;
+
+		vector =3D ret;
+		adata->cpu =3D cpu;
+		adata->vec =3D vector;
+		per_cpu_ptr(irq_map, adata->cpu)[adata->vec] =3D irq_data_to_desc(data);
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
+	struct pending_list *plist =3D per_cpu_ptr(&pending_list, cpu);
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
+	struct pending_list *plist =3D this_cpu_ptr(&pending_list);
+	struct avecintc_data *adata, *tdata;
+	int cpu, vector, bias;
+	uint64_t isr;
+
+	guard(raw_spinlock)(&loongarch_avec.lock);
+
+	list_for_each_entry_safe(adata, tdata, &plist->head, entry) {
+		cpu =3D adata->prev_cpu;
+		vector =3D adata->prev_vec;
+		bias =3D vector / VECTORS_PER_REG;
+		switch (bias) {
+		case 0:
+			isr =3D csr_read64(LOONGARCH_CSR_ISR0);
+			break;
+		case 1:
+			isr =3D csr_read64(LOONGARCH_CSR_ISR1);
+			break;
+		case 2:
+			isr =3D csr_read64(LOONGARCH_CSR_ISR2);
+			break;
+		case 3:
+			isr =3D csr_read64(LOONGARCH_CSR_ISR3);
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
+		adata->moving =3D 0;
+		adata->prev_cpu =3D adata->cpu;
+		adata->prev_vec =3D adata->vec;
+	}
+}
+#endif
+
+static void avecintc_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct avecintc_data *adata =3D irq_data_get_irq_chip_data(d);
+
+	msg->address_hi =3D 0x0;
+	msg->address_lo =3D (loongarch_avec.msi_base_addr | (adata->vec & 0xff) << =
4)
+			  | ((cpu_logical_map(adata->cpu & 0xffff)) << 12);
+	msg->data =3D 0x0;
+}
+
+static struct irq_chip avec_irq_controller =3D {
+	.name			=3D "AVECINTC",
+	.irq_ack		=3D avecintc_ack_irq,
+	.irq_mask		=3D avecintc_mask_irq,
+	.irq_unmask		=3D avecintc_unmask_irq,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	=3D avecintc_set_affinity,
+#endif
+	.irq_compose_msi_msg	=3D avecintc_compose_msi_msg,
+};
+
+static void avecintc_irq_dispatch(struct irq_desc *desc)
+{
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+	struct irq_desc *d;
+
+	chained_irq_enter(chip, desc);
+
+	while (true) {
+		unsigned long vector =3D csr_read64(LOONGARCH_CSR_IRR);
+		if (vector & IRR_INVALID_MASK)
+			break;
+
+		vector &=3D IRR_VECTOR_MASK;
+
+		d =3D this_cpu_read(irq_map[vector]);
+		if (d) {
+			generic_handle_irq_desc(d);
+		} else {
+			spurious_interrupt();
+			pr_warn("Unexpected IRQ occurs on CPU#%d [vector %ld]\n", smp_processor_i=
d(), vector);
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static int avecintc_alloc_vector(struct irq_data *irqd, struct avecintc_data=
 *adata)
+{
+	int cpu, ret;
+
+	guard(raw_spinlock_irqsave)(&loongarch_avec.lock);
+
+	ret =3D irq_matrix_alloc(loongarch_avec.vector_matrix, cpu_online_mask, fal=
se, &cpu);
+	if (ret < 0)
+		return ret;
+
+	adata->prev_cpu =3D adata->cpu =3D cpu;
+	adata->prev_vec =3D adata->vec =3D ret;
+	per_cpu_ptr(irq_map, adata->cpu)[adata->vec] =3D irq_data_to_desc(irqd);
+
+	return 0;
+}
+
+static int avecintc_domain_alloc(struct irq_domain *domain, unsigned int vir=
q,
+				 unsigned int nr_irqs, void *arg)
+{
+	for (unsigned int i =3D 0; i < nr_irqs; i++) {
+		struct irq_data *irqd =3D irq_domain_get_irq_data(domain, virq + i);
+		struct avecintc_data *adata =3D kzalloc(sizeof(*adata), GFP_KERNEL);
+		int ret;
+
+		if (!adata)
+			return -ENOMEM;
+
+		ret =3D avecintc_alloc_vector(irqd, adata);
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
+static void avecintc_free_vector(struct irq_data *irqd, struct avecintc_data=
 *adata)
+{
+	guard(raw_spinlock_irqsave)(&loongarch_avec.lock);
+
+	per_cpu(irq_map, adata->cpu)[adata->vec] =3D NULL;
+	irq_matrix_free(loongarch_avec.vector_matrix, adata->cpu, adata->vec, false=
);
+
+#ifdef CONFIG_SMP
+	if (!adata->moving)
+		return;
+
+	per_cpu(irq_map, adata->prev_cpu)[adata->prev_vec] =3D NULL;
+	irq_matrix_free(loongarch_avec.vector_matrix, adata->prev_cpu, adata->prev_=
vec, false);
+	list_del_init(&adata->entry);
+#endif
+}
+
+static void avecintc_domain_free(struct irq_domain *domain, unsigned int vir=
q,
+				 unsigned int nr_irqs)
+{
+	for (unsigned int i =3D 0; i < nr_irqs; i++) {
+		struct irq_data *d =3D irq_domain_get_irq_data(domain, virq + i);
+
+		if (d) {
+			struct avecintc_data *adata =3D irq_data_get_irq_chip_data(d);
+
+			avecintc_free_vector(d, adata);
+			irq_domain_reset_irq_data(d);
+			kfree(adata);
+		}
+	}
+}
+
+static const struct irq_domain_ops avecintc_domain_ops =3D {
+	.alloc		=3D avecintc_domain_alloc,
+	.free		=3D avecintc_domain_free,
+	.select		=3D msi_lib_irq_domain_select,
+};
+
+static int __init irq_matrix_init(void)
+{
+	loongarch_avec.vector_matrix =3D irq_alloc_matrix(NR_VECTORS, 0, NR_VECTORS=
);
+	if (!loongarch_avec.vector_matrix)
+		return -ENOMEM;
+
+	for (int i =3D 0; i < NR_LEGACY_VECTORS; i++)
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
+	loongarch_avec.fwnode =3D irq_domain_alloc_named_fwnode("AVECINTC");
+	if (!loongarch_avec.fwnode) {
+		pr_err("Unable to allocate domain handle\n");
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	loongarch_avec.domain =3D irq_domain_create_tree(loongarch_avec.fwnode,
+						       &avecintc_domain_ops, NULL);
+	if (!loongarch_avec.domain) {
+		pr_err("Unable to create IRQ domain\n");
+		ret =3D -ENOMEM;
+		goto out_free_handle;
+	}
+
+	parent_irq =3D irq_create_mapping(parent, INT_AVEC);
+	if (!parent_irq) {
+		pr_err("Failed to mapping hwirq\n");
+		ret =3D -EINVAL;
+		goto out_remove_domain;
+	}
+
+	ret =3D irq_matrix_init();
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
+	value =3D iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
+	value |=3D IOCSR_MISC_FUNC_AVEC_EN;
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
+	struct acpi_madt_msi_pic *pchmsi_entry =3D (struct acpi_madt_msi_pic *)head=
er;
+
+	loongarch_avec.msi_base_addr =3D pchmsi_entry->msg_address - AVEC_MSG_OFFSE=
T;
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
+	int ret =3D avecintc_init(parent);
+	if (ret < 0) {
+		pr_err("Failed to init IRQ domain\n");
+		return ret;
+	}
+
+	ret =3D acpi_cascade_irqdomain_init();
+	if (ret < 0) {
+		pr_err("Failed to init cascade IRQ domain\n");
+		return ret;
+	}
+
+	return ret;
+}
diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loonga=
rch-cpu.c
index 9d8f2c406043..bcbd7fd33178 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -13,6 +13,8 @@
 #include <asm/loongarch.h>
 #include <asm/setup.h>
=20
+#include "irq-loongson.h"
+
 static struct irq_domain *irq_domain;
 struct fwnode_handle *cpuintc_handle;
=20
@@ -138,7 +140,10 @@ static int __init acpi_cascade_irqdomain_init(void)
 	if (r < 0)
 		return r;
=20
-	return 0;
+	if (cpu_has_avecint)
+		r =3D avecintc_acpi_init(irq_domain);
+
+	return r;
 }
=20
 static int __init cpuintc_acpi_init(union acpi_subtable_headers *header,
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loo=
ngson-eiointc.c
index b1f2080be2be..e24db71a8783 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -17,6 +17,8 @@
 #include <linux/syscore_ops.h>
 #include <asm/numa.h>
=20
+#include "irq-loongson.h"
+
 #define EIOINTC_REG_NODEMAP	0x14a0
 #define EIOINTC_REG_IPMAP	0x14c0
 #define EIOINTC_REG_ENABLE	0x1600
@@ -360,6 +362,9 @@ static int __init acpi_cascade_irqdomain_init(void)
 	if (r < 0)
 		return r;
=20
+	if (cpu_has_avecint)
+		return 0;
+
 	r =3D acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, pch_msi_parse_madt, 1);
 	if (r < 0)
 		return r;
@@ -396,8 +401,8 @@ static int __init eiointc_init(struct eiointc_priv *priv,=
 int parent_irq,
=20
 	if (nr_pics =3D=3D 1) {
 		register_syscore_ops(&eiointc_syscore_ops);
-		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
-					  "irqchip/loongarch/intc:starting",
+		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_EIOINTC_STARTING,
+					  "irqchip/loongarch/eiointc:starting",
 					  eiointc_router_init, NULL);
 	}
=20
diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loong=
son-htvec.c
index 0bff728b25e3..5da02c7ad0b3 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -17,6 +17,8 @@
 #include <linux/of_irq.h>
 #include <linux/syscore_ops.h>
=20
+#include "irq-loongson.h"
+
 /* Registers */
 #define HTVEC_EN_OFF		0x20
 #define HTVEC_MAX_PARENT_IRQ	8
diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loo=
ngson-liointc.c
index 7c4fe7ab4b83..2b1bd4a96665 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -22,6 +22,8 @@
 #include <asm/loongson.h>
 #endif
=20
+#include "irq-loongson.h"
+
 #define LIOINTC_CHIP_IRQ	32
 #define LIOINTC_NUM_PARENT	4
 #define LIOINTC_NUM_CORES	4
diff --git a/drivers/irqchip/irq-loongson-pch-lpc.c b/drivers/irqchip/irq-loo=
ngson-pch-lpc.c
index 9b35492fb6be..2d4c3ec128b8 100644
--- a/drivers/irqchip/irq-loongson-pch-lpc.c
+++ b/drivers/irqchip/irq-loongson-pch-lpc.c
@@ -15,6 +15,8 @@
 #include <linux/kernel.h>
 #include <linux/syscore_ops.h>
=20
+#include "irq-loongson.h"
+
 /* Registers */
 #define LPC_INT_CTL		0x00
 #define LPC_INT_ENA		0x04
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loo=
ngson-pch-msi.c
index dd4d699170f4..bd337ecddb40 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -15,6 +15,9 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
=20
+#include "irq-msi-lib.h"
+#include "irq-loongson.h"
+
 static int nr_pics;
=20
 struct pch_msi_data {
@@ -27,26 +30,6 @@ struct pch_msi_data {
=20
 static struct fwnode_handle *pch_msi_handle[MAX_IO_PICS];
=20
-static void pch_msi_mask_msi_irq(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void pch_msi_unmask_msi_irq(struct irq_data *d)
-{
-	irq_chip_unmask_parent(d);
-	pci_msi_unmask_irq(d);
-}
-
-static struct irq_chip pch_msi_irq_chip =3D {
-	.name			=3D "PCH PCI MSI",
-	.irq_mask		=3D pch_msi_mask_msi_irq,
-	.irq_unmask		=3D pch_msi_unmask_msi_irq,
-	.irq_ack		=3D irq_chip_ack_parent,
-	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
-};
-
 static int pch_msi_allocate_hwirq(struct pch_msi_data *priv, int num_req)
 {
 	int first;
@@ -85,12 +68,6 @@ static void pch_msi_compose_msi_msg(struct irq_data *data,
 	msg->data =3D data->hwirq;
 }
=20
-static struct msi_domain_info pch_msi_domain_info =3D {
-	.flags	=3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
-	.chip	=3D &pch_msi_irq_chip,
-};
-
 static struct irq_chip middle_irq_chip =3D {
 	.name			=3D "PCH MSI",
 	.irq_mask		=3D irq_chip_mask_parent,
@@ -155,13 +132,31 @@ static void pch_msi_middle_domain_free(struct irq_domai=
n *domain,
 static const struct irq_domain_ops pch_msi_middle_domain_ops =3D {
 	.alloc	=3D pch_msi_middle_domain_alloc,
 	.free	=3D pch_msi_middle_domain_free,
+	.select	=3D msi_lib_irq_domain_select,
+};
+
+#define PCH_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				 MSI_FLAG_USE_DEF_CHIP_OPS |	\
+				 MSI_FLAG_PCI_MSI_MASK_PARENT)
+
+#define PCH_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				 MSI_FLAG_PCI_MSIX      |	\
+				 MSI_FLAG_MULTI_PCI_MSI)
+
+static struct msi_parent_ops pch_msi_parent_ops =3D {
+	.required_flags		=3D PCH_MSI_FLAGS_REQUIRED,
+	.supported_flags	=3D PCH_MSI_FLAGS_SUPPORTED,
+	.bus_select_mask	=3D MATCH_PCI_MSI,
+	.bus_select_token	=3D DOMAIN_BUS_NEXUS,
+	.prefix			=3D "PCH-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
 };
=20
 static int pch_msi_init_domains(struct pch_msi_data *priv,
 				struct irq_domain *parent,
 				struct fwnode_handle *domain_handle)
 {
-	struct irq_domain *middle_domain, *msi_domain;
+	struct irq_domain *middle_domain;
=20
 	middle_domain =3D irq_domain_create_hierarchy(parent, 0, priv->num_irqs,
 						    domain_handle,
@@ -174,14 +169,8 @@ static int pch_msi_init_domains(struct pch_msi_data *pri=
v,
=20
 	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
=20
-	msi_domain =3D pci_msi_create_irq_domain(domain_handle,
-					       &pch_msi_domain_info,
-					       middle_domain);
-	if (!msi_domain) {
-		pr_err("Failed to create PCI MSI domain\n");
-		irq_domain_remove(middle_domain);
-		return -ENOMEM;
-	}
+	middle_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
+	middle_domain->msi_parent_ops =3D &pch_msi_parent_ops;
=20
 	return 0;
 }
@@ -266,17 +255,17 @@ IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_ms=
i_of_init);
 #ifdef CONFIG_ACPI
 struct fwnode_handle *get_pch_msi_handle(int pci_segment)
 {
-	int i;
+	if (cpu_has_avecint)
+		return pch_msi_handle[0];
=20
-	for (i =3D 0; i < MAX_IO_PICS; i++) {
+	for (int i =3D 0; i < MAX_IO_PICS; i++) {
 		if (msi_group[i].pci_segment =3D=3D pci_segment)
 			return pch_msi_handle[i];
 	}
-	return NULL;
+	return pch_msi_handle[0];
 }
=20
-int __init pch_msi_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_msi_pic *acpi_pchmsi)
+int __init pch_msi_acpi_init(struct irq_domain *parent, struct acpi_madt_msi=
_pic *acpi_pchmsi)
 {
 	int ret;
 	struct fwnode_handle *domain_handle;
@@ -289,4 +278,18 @@ int __init pch_msi_acpi_init(struct irq_domain *parent,
=20
 	return ret;
 }
+
+int __init pch_msi_acpi_init_avec(struct irq_domain *parent)
+{
+	if (pch_msi_handle[0])
+		return 0;
+
+	pch_msi_handle[0] =3D parent->fwnode;
+	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
+
+	parent->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
+	parent->msi_parent_ops =3D &pch_msi_parent_ops;
+
+	return 0;
+}
 #endif
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loo=
ngson-pch-pic.c
index cbaef65e804c..69efda35a8e7 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -17,6 +17,8 @@
 #include <linux/of_irq.h>
 #include <linux/syscore_ops.h>
=20
+#include "irq-loongson.h"
+
 /* Registers */
 #define PCH_PIC_MASK		0x20
 #define PCH_PIC_HTMSI_EN	0x40
diff --git a/drivers/irqchip/irq-loongson.h b/drivers/irqchip/irq-loongson.h
new file mode 100644
index 000000000000..11fa138d1f44
--- /dev/null
+++ b/drivers/irqchip/irq-loongson.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
+ */
+
+#ifndef _DRIVERS_IRQCHIP_IRQ_LOONGSON_H
+#define _DRIVERS_IRQCHIP_IRQ_LOONGSON_H
+
+int find_pch_pic(u32 gsi);
+
+int liointc_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_lio_pic *acpi_liointc);
+int eiointc_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_eio_pic *acpi_eiointc);
+int avecintc_acpi_init(struct irq_domain *parent);
+
+int htvec_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_ht_pic *acpi_htvec);
+int pch_lpc_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_lpc_pic *acpi_pchlpc);
+int pch_pic_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_bio_pic *acpi_pchpic);
+int pch_msi_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_msi_pic *acpi_pchmsi);
+int pch_msi_acpi_init_avec(struct irq_domain *parent);
+
+#endif /* _DRIVERS_IRQCHIP_IRQ_LOONGSON_H */
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 093fd42893a7..12919836dadb 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -222,37 +222,27 @@ static int mbigen_of_create_domain(struct platform_devi=
ce *pdev,
 				   struct mbigen_device *mgn_chip)
 {
 	struct platform_device *child;
-	struct device_node *np;
 	u32 num_pins;
-	int ret =3D 0;
=20
-	for_each_child_of_node(pdev->dev.of_node, np) {
+	for_each_child_of_node_scoped(pdev->dev.of_node, np) {
 		if (!of_property_read_bool(np, "interrupt-controller"))
 			continue;
=20
 		child =3D of_platform_device_create(np, NULL, NULL);
-		if (!child) {
-			ret =3D -ENOMEM;
-			break;
-		}
+		if (!child)
+			return -ENOMEM;
=20
 		if (of_property_read_u32(child->dev.of_node, "num-pins",
 					 &num_pins) < 0) {
 			dev_err(&pdev->dev, "No num-pins property\n");
-			ret =3D -EINVAL;
-			break;
+			return -EINVAL;
 		}
=20
-		if (!mbigen_create_device_domain(&child->dev, num_pins, mgn_chip)) {
-			ret =3D -ENOMEM;
-			break;
-		}
+		if (!mbigen_create_device_domain(&child->dev, num_pins, mgn_chip))
+			return -ENOMEM;
 	}
=20
-	if (ret)
-		of_node_put(np);
-
-	return ret;
+	return 0;
 }
=20
 #ifdef CONFIG_ACPI
diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index dc82162ba763..ad84a2f03368 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -325,8 +325,7 @@ static int __init omap_init_irq(u32 base, struct device_n=
ode *node)
 	return ret;
 }
=20
-static asmlinkage void __exception_irq_entry
-omap_intc_handle_irq(struct pt_regs *regs)
+static void __exception_irq_entry omap_intc_handle_irq(struct pt_regs *regs)
 {
 	extern unsigned long irq_err_count;
 	u32 irqnr;
diff --git a/drivers/irqchip/irq-sa11x0.c b/drivers/irqchip/irq-sa11x0.c
index 31c202a1ae62..9d0b80271949 100644
--- a/drivers/irqchip/irq-sa11x0.c
+++ b/drivers/irqchip/irq-sa11x0.c
@@ -127,8 +127,7 @@ static int __init sa1100irq_init_devicefs(void)
=20
 device_initcall(sa1100irq_init_devicefs);
=20
-static asmlinkage void __exception_irq_entry
-sa1100_handle_irq(struct pt_regs *regs)
+static void __exception_irq_entry sa1100_handle_irq(struct pt_regs *regs)
 {
 	uint32_t icip, icmr, mask;
=20
diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versa=
tile-fpga.c
index 5018a06060e6..ca471c6fee99 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -128,7 +128,7 @@ static int handle_one_fpga(struct fpga_irq_data *f, struc=
t pt_regs *regs)
  * Keep iterating over all registered FPGA IRQ controllers until there are
  * no pending interrupts.
  */
-static asmlinkage void __exception_irq_entry fpga_handle_irq(struct pt_regs =
*regs)
+static void __exception_irq_entry fpga_handle_irq(struct pt_regs *regs)
 {
 	int i, handled;
=20
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
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 3f30c88e0b4c..457151f9f263 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -276,7 +276,7 @@ struct irq_affinity_notify {
 #define	IRQ_AFFINITY_MAX_SETS  4
=20
 /**
- * struct irq_affinity - Description for automatic irq affinity assignements
+ * struct irq_affinity - Description for automatic irq affinity assignments
  * @pre_vectors:	Don't apply affinity to @pre_vectors at beginning of
  *			the MSI(-X) vector space
  * @post_vectors:	Don't apply affinity to @post_vectors at end of
@@ -594,7 +594,7 @@ extern const char * const softirq_to_name[NR_SOFTIRQS];
=20
 struct softirq_action
 {
-	void	(*action)(struct softirq_action *);
+	void	(*action)(void);
 };
=20
 asmlinkage void do_softirq(void);
@@ -609,7 +609,7 @@ static inline void do_softirq_post_smp_call_flush(unsigne=
d int unused)
 }
 #endif
=20
-extern void open_softirq(int nr, void (*action)(struct softirq_action *));
+extern void open_softirq(int nr, void (*action)(void));
 extern void softirq_init(void);
 extern void __raise_softirq_irqoff(unsigned int nr);
=20
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 1f5dbf1f92c9..fa711f80957b 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -991,7 +991,6 @@ void irq_init_desc(unsigned int irq);
  * @ack:	Ack register offset to reg_base
  * @eoi:	Eoi register offset to reg_base
  * @type:	Type configuration register offset to reg_base
- * @polarity:	Polarity configuration register offset to reg_base
  */
 struct irq_chip_regs {
 	unsigned long		enable;
@@ -1000,7 +999,6 @@ struct irq_chip_regs {
 	unsigned long		ack;
 	unsigned long		eoi;
 	unsigned long		type;
-	unsigned long		polarity;
 };
=20
 /**
@@ -1040,8 +1038,6 @@ struct irq_chip_type {
  * @irq_base:		Interrupt base nr for this chip
  * @irq_cnt:		Number of interrupts handled by this chip
  * @mask_cache:		Cached mask register shared between all chip types
- * @type_cache:		Cached type register
- * @polarity_cache:	Cached polarity register
  * @wake_enabled:	Interrupt can wakeup from suspend
  * @wake_active:	Interrupt is marked as an wakeup from suspend source
  * @num_ct:		Number of available irq_chip_type instances (usually 1)
@@ -1068,8 +1064,6 @@ struct irq_chip_generic {
 	unsigned int		irq_base;
 	unsigned int		irq_cnt;
 	u32			mask_cache;
-	u32			type_cache;
-	u32			polarity_cache;
 	u32			wake_enabled;
 	u32			wake_active;
 	unsigned int		num_ct;
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index de6105f68fec..e432b6a12a32 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -291,7 +291,12 @@ struct irq_domain_chip_generic_info;
  * @hwirq_max:		Maximum number of interrupts supported by controller
  * @direct_max:		Maximum value of direct maps;
  *			Use ~0 for no limit; 0 for no direct mapping
+ * @hwirq_base:		The first hardware interrupt number (legacy domains only)
+ * @virq_base:		The first Linux interrupt number for legacy domains to
+ *			immediately associate the interrupts after domain creation
  * @bus_token:		Domain bus token
+ * @name_suffix:	Optional name suffix to avoid collisions when multiple
+ *			domains are added using same fwnode
  * @ops:		Domain operation callbacks
  * @host_data:		Controller private data pointer
  * @dgc_info:		Geneneric chip information structure pointer used to
@@ -307,7 +312,10 @@ struct irq_domain_info {
 	unsigned int				size;
 	irq_hw_number_t				hwirq_max;
 	int					direct_max;
+	unsigned int				hwirq_base;
+	unsigned int				virq_base;
 	enum irq_domain_bus_token		bus_token;
+	const char				*name_suffix;
 	const struct irq_domain_ops		*ops;
 	void					*host_data;
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index dc94e0bf2c94..271e9139de77 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -198,7 +198,7 @@ __irq_startup_managed(struct irq_desc *desc, const struct=
 cpumask *aff,
=20
 	irqd_clr_managed_shutdown(d);
=20
-	if (cpumask_any_and(aff, cpu_online_mask) >=3D nr_cpu_ids) {
+	if (!cpumask_intersects(aff, cpu_online_mask)) {
 		/*
 		 * Catch code which fiddles with enable_irq() on a managed
 		 * and potentially shutdown IRQ. Chained interrupt
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index eb8628390156..15a7654eff68 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -37,7 +37,7 @@ static inline bool irq_needs_fixup(struct irq_data *d)
 	 * has been removed from the online mask already.
 	 */
 	if (cpumask_any_but(m, cpu) < nr_cpu_ids &&
-	    cpumask_any_and(m, cpu_online_mask) >=3D nr_cpu_ids) {
+	    !cpumask_intersects(m, cpu_online_mask)) {
 		/*
 		 * If this happens then there was a missed IRQ fixup at some
 		 * point. Warn about it and enforce fixup.
@@ -110,7 +110,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	if (maskchip && chip->irq_mask)
 		chip->irq_mask(d);
=20
-	if (cpumask_any_and(affinity, cpu_online_mask) >=3D nr_cpu_ids) {
+	if (!cpumask_intersects(affinity, cpu_online_mask)) {
 		/*
 		 * If the interrupt is managed, then shut it down and leave
 		 * the affinity untouched.
diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 3d4036db15ac..1a3d483548e2 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -13,7 +13,6 @@
=20
 struct irq_sim_work_ctx {
 	struct irq_work		work;
-	int			irq_base;
 	unsigned int		irq_count;
 	unsigned long		*pending;
 	struct irq_domain	*domain;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index cea8f6874b1f..e0bff21f30e0 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -128,72 +128,98 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnod=
e)
 }
 EXPORT_SYMBOL_GPL(irq_domain_free_fwnode);
=20
-static int irq_domain_set_name(struct irq_domain *domain,
-			       const struct fwnode_handle *fwnode,
-			       enum irq_domain_bus_token bus_token)
+static int alloc_name(struct irq_domain *domain, char *base, enum irq_domain=
_bus_token bus_token)
+{
+	if (bus_token =3D=3D DOMAIN_BUS_ANY)
+		domain->name =3D kasprintf(GFP_KERNEL, "%s", base);
+	else
+		domain->name =3D kasprintf(GFP_KERNEL, "%s-%d", base, bus_token);
+	if (!domain->name)
+		return -ENOMEM;
+
+	domain->flags |=3D IRQ_DOMAIN_NAME_ALLOCATED;
+	return 0;
+}
+
+static int alloc_fwnode_name(struct irq_domain *domain, const struct fwnode_=
handle *fwnode,
+			     enum irq_domain_bus_token bus_token, const char *suffix)
+{
+	const char *sep =3D suffix ? "-" : "";
+	const char *suf =3D suffix ? : "";
+	char *name;
+
+	if (bus_token =3D=3D DOMAIN_BUS_ANY)
+		name =3D kasprintf(GFP_KERNEL, "%pfw%s%s", fwnode, sep, suf);
+	else
+		name =3D kasprintf(GFP_KERNEL, "%pfw%s%s-%d", fwnode, sep, suf, bus_token);
+	if (!name)
+		return -ENOMEM;
+
+	/*
+	 * fwnode paths contain '/', which debugfs is legitimately unhappy
+	 * about. Replace them with ':', which does the trick and is not as
+	 * offensive as '\'...
+	 */
+	domain->name =3D strreplace(name, '/', ':');
+	domain->flags |=3D IRQ_DOMAIN_NAME_ALLOCATED;
+	return 0;
+}
+
+static int alloc_unknown_name(struct irq_domain *domain, enum irq_domain_bus=
_token bus_token)
 {
 	static atomic_t unknown_domains;
-	struct irqchip_fwid *fwid;
+	int id =3D atomic_inc_return(&unknown_domains);
+
+	if (bus_token =3D=3D DOMAIN_BUS_ANY)
+		domain->name =3D kasprintf(GFP_KERNEL, "unknown-%d", id);
+	else
+		domain->name =3D kasprintf(GFP_KERNEL, "unknown-%d-%d", id, bus_token);
+	if (!domain->name)
+		return -ENOMEM;
+
+	domain->flags |=3D IRQ_DOMAIN_NAME_ALLOCATED;
+	return 0;
+}
+
+static int irq_domain_set_name(struct irq_domain *domain, const struct irq_d=
omain_info *info)
+{
+	enum irq_domain_bus_token bus_token =3D info->bus_token;
+	const struct fwnode_handle *fwnode =3D info->fwnode;
=20
 	if (is_fwnode_irqchip(fwnode)) {
-		fwid =3D container_of(fwnode, struct irqchip_fwid, fwnode);
+		struct irqchip_fwid *fwid =3D container_of(fwnode, struct irqchip_fwid, fw=
node);
+
+		/*
+		 * The name_suffix is only intended to be used to avoid a name
+		 * collision when multiple domains are created for a single
+		 * device and the name is picked using a real device node.
+		 * (Typical use-case is regmap-IRQ controllers for devices
+		 * providing more than one physical IRQ.) There should be no
+		 * need to use name_suffix with irqchip-fwnode.
+		 */
+		if (info->name_suffix)
+			return -EINVAL;
=20
 		switch (fwid->type) {
 		case IRQCHIP_FWNODE_NAMED:
 		case IRQCHIP_FWNODE_NAMED_ID:
-			domain->name =3D bus_token ?
-					kasprintf(GFP_KERNEL, "%s-%d",
-						  fwid->name, bus_token) :
-					kstrdup(fwid->name, GFP_KERNEL);
-			if (!domain->name)
-				return -ENOMEM;
-			domain->flags |=3D IRQ_DOMAIN_NAME_ALLOCATED;
-			break;
+			return alloc_name(domain, fwid->name, bus_token);
 		default:
 			domain->name =3D fwid->name;
-			if (bus_token) {
-				domain->name =3D kasprintf(GFP_KERNEL, "%s-%d",
-							 fwid->name, bus_token);
-				if (!domain->name)
-					return -ENOMEM;
-				domain->flags |=3D IRQ_DOMAIN_NAME_ALLOCATED;
-			}
-			break;
+			if (bus_token !=3D DOMAIN_BUS_ANY)
+				return alloc_name(domain, fwid->name, bus_token);
 		}
-	} else if (is_of_node(fwnode) || is_acpi_device_node(fwnode) ||
-		   is_software_node(fwnode)) {
-		char *name;
-
-		/*
-		 * fwnode paths contain '/', which debugfs is legitimately
-		 * unhappy about. Replace them with ':', which does
-		 * the trick and is not as offensive as '\'...
-		 */
-		name =3D bus_token ?
-			kasprintf(GFP_KERNEL, "%pfw-%d", fwnode, bus_token) :
-			kasprintf(GFP_KERNEL, "%pfw", fwnode);
-		if (!name)
-			return -ENOMEM;
=20
-		domain->name =3D strreplace(name, '/', ':');
-		domain->flags |=3D IRQ_DOMAIN_NAME_ALLOCATED;
+	} else if (is_of_node(fwnode) || is_acpi_device_node(fwnode) || is_software=
_node(fwnode)) {
+		return alloc_fwnode_name(domain, fwnode, bus_token, info->name_suffix);
 	}
=20
-	if (!domain->name) {
-		if (fwnode)
-			pr_err("Invalid fwnode type for irqdomain\n");
-		domain->name =3D bus_token ?
-				kasprintf(GFP_KERNEL, "unknown-%d-%d",
-					  atomic_inc_return(&unknown_domains),
-					  bus_token) :
-				kasprintf(GFP_KERNEL, "unknown-%d",
-					  atomic_inc_return(&unknown_domains));
-		if (!domain->name)
-			return -ENOMEM;
-		domain->flags |=3D IRQ_DOMAIN_NAME_ALLOCATED;
-	}
+	if (domain->name)
+		return 0;
=20
-	return 0;
+	if (fwnode)
+		pr_err("Invalid fwnode type for irqdomain\n");
+	return alloc_unknown_name(domain, bus_token);
 }
=20
 static struct irq_domain *__irq_domain_create(const struct irq_domain_info *=
info)
@@ -211,7 +237,7 @@ static struct irq_domain *__irq_domain_create(const struc=
t irq_domain_info *info
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
=20
-	err =3D irq_domain_set_name(domain, info->fwnode, info->bus_token);
+	err =3D irq_domain_set_name(domain, info);
 	if (err) {
 		kfree(domain);
 		return ERR_PTR(err);
@@ -267,13 +293,20 @@ static void irq_domain_free(struct irq_domain *domain)
 	kfree(domain);
 }
=20
-/**
- * irq_domain_instantiate() - Instantiate a new irq domain data structure
- * @info: Domain information pointer pointing to the information for this do=
main
- *
- * Return: A pointer to the instantiated irq domain or an ERR_PTR value.
- */
-struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
+static void irq_domain_instantiate_descs(const struct irq_domain_info *info)
+{
+	if (!IS_ENABLED(CONFIG_SPARSE_IRQ))
+		return;
+
+	if (irq_alloc_descs(info->virq_base, info->virq_base, info->size,
+			    of_node_to_nid(to_of_node(info->fwnode))) < 0) {
+		pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
+			info->virq_base);
+	}
+}
+
+static struct irq_domain *__irq_domain_instantiate(const struct irq_domain_i=
nfo *info,
+						   bool cond_alloc_descs, bool force_associate)
 {
 	struct irq_domain *domain;
 	int err;
@@ -306,6 +339,19 @@ struct irq_domain *irq_domain_instantiate(const struct i=
rq_domain_info *info)
=20
 	__irq_domain_publish(domain);
=20
+	if (cond_alloc_descs && info->virq_base > 0)
+		irq_domain_instantiate_descs(info);
+
+	/*
+	 * Legacy interrupt domains have a fixed Linux interrupt number
+	 * associated. Other interrupt domains can request association by
+	 * providing a Linux interrupt number > 0.
+	 */
+	if (force_associate || info->virq_base > 0) {
+		irq_domain_associate_many(domain, info->virq_base, info->hwirq_base,
+					  info->size - info->hwirq_base);
+	}
+
 	return domain;
=20
 err_domain_gc_remove:
@@ -315,6 +361,17 @@ struct irq_domain *irq_domain_instantiate(const struct i=
rq_domain_info *info)
 	irq_domain_free(domain);
 	return ERR_PTR(err);
 }
+
+/**
+ * irq_domain_instantiate() - Instantiate a new irq domain data structure
+ * @info: Domain information pointer pointing to the information for this do=
main
+ *
+ * Return: A pointer to the instantiated irq domain or an ERR_PTR value.
+ */
+struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
+{
+	return __irq_domain_instantiate(info, false, false);
+}
 EXPORT_SYMBOL_GPL(irq_domain_instantiate);
=20
 /**
@@ -413,28 +470,13 @@ struct irq_domain *irq_domain_create_simple(struct fwno=
de_handle *fwnode,
 		.fwnode		=3D fwnode,
 		.size		=3D size,
 		.hwirq_max	=3D size,
+		.virq_base	=3D first_irq,
 		.ops		=3D ops,
 		.host_data	=3D host_data,
 	};
-	struct irq_domain *domain;
-
-	domain =3D irq_domain_instantiate(&info);
-	if (IS_ERR(domain))
-		return NULL;
+	struct irq_domain *domain =3D __irq_domain_instantiate(&info, true, false);
=20
-	if (first_irq > 0) {
-		if (IS_ENABLED(CONFIG_SPARSE_IRQ)) {
-			/* attempt to allocated irq_descs */
-			int rc =3D irq_alloc_descs(first_irq, first_irq, size,
-						 of_node_to_nid(to_of_node(fwnode)));
-			if (rc < 0)
-				pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
-					first_irq);
-		}
-		irq_domain_associate_many(domain, first_irq, 0, size);
-	}
-
-	return domain;
+	return IS_ERR(domain) ? NULL : domain;
 }
 EXPORT_SYMBOL_GPL(irq_domain_create_simple);
=20
@@ -476,18 +518,14 @@ struct irq_domain *irq_domain_create_legacy(struct fwno=
de_handle *fwnode,
 		.fwnode		=3D fwnode,
 		.size		=3D first_hwirq + size,
 		.hwirq_max	=3D first_hwirq + size,
+		.hwirq_base	=3D first_hwirq,
+		.virq_base	=3D first_irq,
 		.ops		=3D ops,
 		.host_data	=3D host_data,
 	};
-	struct irq_domain *domain;
+	struct irq_domain *domain =3D __irq_domain_instantiate(&info, false, true);
=20
-	domain =3D irq_domain_instantiate(&info);
-	if (IS_ERR(domain))
-		return NULL;
-
-	irq_domain_associate_many(domain, first_irq, first_hwirq, size);
-
-	return domain;
+	return IS_ERR(domain) ? NULL : domain;
 }
 EXPORT_SYMBOL_GPL(irq_domain_create_legacy);
=20
@@ -1365,7 +1403,7 @@ static int irq_domain_trim_hierarchy(unsigned int virq)
 	tail =3D NULL;
=20
 	/* The first entry must have a valid irqchip */
-	if (!irq_data->chip || IS_ERR(irq_data->chip))
+	if (IS_ERR_OR_NULL(irq_data->chip))
 		return -EINVAL;
=20
 	/*
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index dd53298ef1a5..f0803d6bd296 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -218,21 +218,20 @@ static void irq_validate_effective_affinity(struct irq_=
data *data)
 static inline void irq_validate_effective_affinity(struct irq_data *data) { }
 #endif
=20
+static DEFINE_PER_CPU(struct cpumask, __tmp_mask);
+
 int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 			bool force)
 {
+	struct cpumask *tmp_mask =3D this_cpu_ptr(&__tmp_mask);
 	struct irq_desc *desc =3D irq_data_to_desc(data);
 	struct irq_chip *chip =3D irq_data_get_irq_chip(data);
 	const struct cpumask  *prog_mask;
 	int ret;
=20
-	static DEFINE_RAW_SPINLOCK(tmp_mask_lock);
-	static struct cpumask tmp_mask;
-
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
=20
-	raw_spin_lock(&tmp_mask_lock);
 	/*
 	 * If this is a managed interrupt and housekeeping is enabled on
 	 * it check whether the requested affinity mask intersects with
@@ -258,11 +257,11 @@ int irq_do_set_affinity(struct irq_data *data, const st=
ruct cpumask *mask,
=20
 		hk_mask =3D housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
=20
-		cpumask_and(&tmp_mask, mask, hk_mask);
-		if (!cpumask_intersects(&tmp_mask, cpu_online_mask))
+		cpumask_and(tmp_mask, mask, hk_mask);
+		if (!cpumask_intersects(tmp_mask, cpu_online_mask))
 			prog_mask =3D mask;
 		else
-			prog_mask =3D &tmp_mask;
+			prog_mask =3D tmp_mask;
 	} else {
 		prog_mask =3D mask;
 	}
@@ -272,16 +271,14 @@ int irq_do_set_affinity(struct irq_data *data, const st=
ruct cpumask *mask,
 	 * unless we are being asked to force the affinity (in which
 	 * case we do as we are told).
 	 */
-	cpumask_and(&tmp_mask, prog_mask, cpu_online_mask);
-	if (!force && !cpumask_empty(&tmp_mask))
-		ret =3D chip->irq_set_affinity(data, &tmp_mask, force);
+	cpumask_and(tmp_mask, prog_mask, cpu_online_mask);
+	if (!force && !cpumask_empty(tmp_mask))
+		ret =3D chip->irq_set_affinity(data, tmp_mask, force);
 	else if (force)
 		ret =3D chip->irq_set_affinity(data, mask, force);
 	else
 		ret =3D -EINVAL;
=20
-	raw_spin_unlock(&tmp_mask_lock);
-
 	switch (ret) {
 	case IRQ_SET_MASK_OK:
 	case IRQ_SET_MASK_OK_DONE:
diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index 61ca924ef4b4..eb150afd671f 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -26,7 +26,7 @@ bool irq_fixup_move_pending(struct irq_desc *desc, bool for=
ce_clear)
 	 * The outgoing CPU might be the last online target in a pending
 	 * interrupt move. If that's the case clear the pending move bit.
 	 */
-	if (cpumask_any_and(desc->pending_mask, cpu_online_mask) >=3D nr_cpu_ids) {
+	if (!cpumask_intersects(desc->pending_mask, cpu_online_mask)) {
 		irqd_clr_move_pending(data);
 		return false;
 	}
@@ -74,7 +74,7 @@ void irq_move_masked_irq(struct irq_data *idata)
 	 * For correct operation this depends on the caller
 	 * masking the irqs.
 	 */
-	if (cpumask_any_and(desc->pending_mask, cpu_online_mask) < nr_cpu_ids) {
+	if (cpumask_intersects(desc->pending_mask, cpu_online_mask)) {
 		int ret;
=20
 		ret =3D irq_do_set_affinity(data, desc->pending_mask, false);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 5fa0547ece0c..1c7e5159064c 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -82,7 +82,7 @@ static struct msi_desc *msi_alloc_desc(struct device *dev, =
int nvec,
 	desc->dev =3D dev;
 	desc->nvec_used =3D nvec;
 	if (affinity) {
-		desc->affinity =3D kmemdup(affinity, nvec * sizeof(*desc->affinity), GFP_K=
ERNEL);
+		desc->affinity =3D kmemdup_array(affinity, nvec, sizeof(*desc->affinity), =
GFP_KERNEL);
 		if (!desc->affinity) {
 			kfree(desc);
 			return NULL;
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 8cccdf40725a..9081ada81c3d 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -52,10 +52,8 @@ static int show_irq_affinity(int type, struct seq_file *m)
 	case AFFINITY:
 	case AFFINITY_LIST:
 		mask =3D desc->irq_common_data.affinity;
-#ifdef CONFIG_GENERIC_PENDING_IRQ
-		if (irqd_is_setaffinity_pending(&desc->irq_data))
-			mask =3D desc->pending_mask;
-#endif
+		if (irq_move_pending(&desc->irq_data))
+			mask =3D irq_desc_get_pending_mask(desc);
 		break;
 	case EFFECTIVE:
 	case EFFECTIVE_LIST:
@@ -142,7 +140,7 @@ static ssize_t write_irq_affinity(int type, struct file *=
file,
 	int err;
=20
 	if (!irq_can_set_affinity_usr(irq) || no_irq_affinity)
-		return -EIO;
+		return -EPERM;
=20
 	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
 		return -ENOMEM;
@@ -362,8 +360,13 @@ void register_irq_proc(unsigned int irq, struct irq_desc=
 *desc)
 		goto out_unlock;
=20
 #ifdef CONFIG_SMP
+	umode_t umode =3D S_IRUGO;
+
+	if (irq_can_set_affinity_usr(desc->irq_data.irq))
+		umode |=3D S_IWUSR;
+
 	/* create /proc/irq/<irq>/smp_affinity */
-	proc_create_data("smp_affinity", 0644, desc->dir,
+	proc_create_data("smp_affinity", umode, desc->dir,
 			 &irq_affinity_proc_ops, irqp);
=20
 	/* create /proc/irq/<irq>/affinity_hint */
@@ -371,7 +374,7 @@ void register_irq_proc(unsigned int irq, struct irq_desc =
*desc)
 			irq_affinity_hint_proc_show, irqp);
=20
 	/* create /proc/irq/<irq>/smp_affinity_list */
-	proc_create_data("smp_affinity_list", 0644, desc->dir,
+	proc_create_data("smp_affinity_list", umode, desc->dir,
 			 &irq_affinity_list_proc_ops, irqp);
=20
 	proc_create_single_data("node", 0444, desc->dir, irq_node_proc_show,
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 4402d6f5f857..b3b3ce34df63 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -105,7 +105,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
 }
=20
 /* Invoke the RCU callbacks whose grace period has elapsed.  */
-static __latent_entropy void rcu_process_callbacks(struct softirq_action *un=
used)
+static __latent_entropy void rcu_process_callbacks(void)
 {
 	struct rcu_head *next, *list;
 	unsigned long flags;
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e641cc681901..93bd665637c0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2855,7 +2855,7 @@ static __latent_entropy void rcu_core(void)
 		queue_work_on(rdp->cpu, rcu_gp_wq, &rdp->strict_work);
 }
=20
-static void rcu_core_si(struct softirq_action *h)
+static void rcu_core_si(void)
 {
 	rcu_core();
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06d..8dc9385f6da4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12483,7 +12483,7 @@ static int sched_balance_newidle(struct rq *this_rq, =
struct rq_flags *rf)
  * - indirectly from a remote scheduler_tick() for NOHZ idle balancing
  *   through the SMP cross-call nohz_csd_func()
  */
-static __latent_entropy void sched_balance_softirq(struct softirq_action *h)
+static __latent_entropy void sched_balance_softirq(void)
 {
 	struct rq *this_rq =3D this_rq();
 	enum cpu_idle_type idle =3D this_rq->idle_balance;
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 02582017759a..d082e7840f88 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -551,7 +551,7 @@ static void handle_softirqs(bool ksirqd)
 		kstat_incr_softirqs_this_cpu(vec_nr);
=20
 		trace_softirq_entry(vec_nr);
-		h->action(h);
+		h->action();
 		trace_softirq_exit(vec_nr);
 		if (unlikely(prev_count !=3D preempt_count())) {
 			pr_err("huh, entered softirq %u %s %p with preempt_count %08x, exited wit=
h %08x?\n",
@@ -700,7 +700,7 @@ void __raise_softirq_irqoff(unsigned int nr)
 	or_softirq_pending(1UL << nr);
 }
=20
-void open_softirq(int nr, void (*action)(struct softirq_action *))
+void open_softirq(int nr, void (*action)(void))
 {
 	softirq_vec[nr].action =3D action;
 }
@@ -760,8 +760,7 @@ static bool tasklet_clear_sched(struct tasklet_struct *t)
 	return false;
 }
=20
-static void tasklet_action_common(struct softirq_action *a,
-				  struct tasklet_head *tl_head,
+static void tasklet_action_common(struct tasklet_head *tl_head,
 				  unsigned int softirq_nr)
 {
 	struct tasklet_struct *list;
@@ -805,16 +804,16 @@ static void tasklet_action_common(struct softirq_action=
 *a,
 	}
 }
=20
-static __latent_entropy void tasklet_action(struct softirq_action *a)
+static __latent_entropy void tasklet_action(void)
 {
 	workqueue_softirq_action(false);
-	tasklet_action_common(a, this_cpu_ptr(&tasklet_vec), TASKLET_SOFTIRQ);
+	tasklet_action_common(this_cpu_ptr(&tasklet_vec), TASKLET_SOFTIRQ);
 }
=20
-static __latent_entropy void tasklet_hi_action(struct softirq_action *a)
+static __latent_entropy void tasklet_hi_action(void)
 {
 	workqueue_softirq_action(true);
-	tasklet_action_common(a, this_cpu_ptr(&tasklet_hi_vec), HI_SOFTIRQ);
+	tasklet_action_common(this_cpu_ptr(&tasklet_hi_vec), HI_SOFTIRQ);
 }
=20
 void tasklet_setup(struct tasklet_struct *t,
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index b8ee320208d4..836157e09e25 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1757,7 +1757,7 @@ static void __hrtimer_run_queues(struct hrtimer_cpu_bas=
e *cpu_base, ktime_t now,
 	}
 }
=20
-static __latent_entropy void hrtimer_run_softirq(struct softirq_action *h)
+static __latent_entropy void hrtimer_run_softirq(void)
 {
 	struct hrtimer_cpu_base *cpu_base =3D this_cpu_ptr(&hrtimer_bases);
 	unsigned long flags;
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 64b0d8a0aa0f..760bbeb1f331 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2440,7 +2440,7 @@ static void run_timer_base(int index)
 /*
  * This function runs timers and the timer-tq in bottom half context.
  */
-static __latent_entropy void run_timer_softirq(struct softirq_action *h)
+static __latent_entropy void run_timer_softirq(void)
 {
 	run_timer_base(BASE_LOCAL);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
diff --git a/lib/irq_poll.c b/lib/irq_poll.c
index 2d5329a42105..08b242bbdbdf 100644
--- a/lib/irq_poll.c
+++ b/lib/irq_poll.c
@@ -75,7 +75,7 @@ void irq_poll_complete(struct irq_poll *iop)
 }
 EXPORT_SYMBOL(irq_poll_complete);
=20
-static void __latent_entropy irq_poll_softirq(struct softirq_action *h)
+static void __latent_entropy irq_poll_softirq(void)
 {
 	struct list_head *list =3D this_cpu_ptr(&blk_cpu_iopoll);
 	int rearm =3D 0, budget =3D irq_poll_budget;
diff --git a/net/core/dev.c b/net/core/dev.c
index 6ea1d20676fb..e24a3bcb496d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5247,7 +5247,7 @@ int netif_rx(struct sk_buff *skb)
 }
 EXPORT_SYMBOL(netif_rx);
=20
-static __latent_entropy void net_tx_action(struct softirq_action *h)
+static __latent_entropy void net_tx_action(void)
 {
 	struct softnet_data *sd =3D this_cpu_ptr(&softnet_data);
=20
@@ -6920,7 +6920,7 @@ static int napi_threaded_poll(void *data)
 	return 0;
 }
=20
-static __latent_entropy void net_rx_action(struct softirq_action *h)
+static __latent_entropy void net_rx_action(void)
 {
 	struct softnet_data *sd =3D this_cpu_ptr(&softnet_data);
 	unsigned long time_limit =3D jiffies +


