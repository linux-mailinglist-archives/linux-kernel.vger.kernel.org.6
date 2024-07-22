Return-Path: <linux-kernel+bounces-259325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91318939433
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E8F1C21733
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D56D171080;
	Mon, 22 Jul 2024 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gMKqFdW9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/DedHDuh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21F17C74
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676448; cv=none; b=LyejDKJkDfGPy6p5ZzOhwNLnvnGIKOEBLSqVltOgh7NHdV5YUKds6L1RRhcOZGBPUImxd5qXgZ/SXMXC53lQAeW7x1Yh/J1dUn5FJ2aK1cJrRY0jR5HDdpDSFt0mGDRd0pyl3h61R7Kq/Kl5QwYAqWy4h7RFgLfWYkVB+poXhE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676448; c=relaxed/simple;
	bh=09PYC3RWE7v3COh9qcFzLi/0BVnANzk0t7muAHiPmHQ=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=ITgDi4WGS59fGGjPopJZ0JQFooqC0ub/jiR02HS49auUDrpElrb1bzuU1v8L+eNmTQr/s2famcAexADS2RxrQGJh59KYnSugw6tj3eKpxaiYjcks3JNk64u+39ayu7GfYH3gRGpFz/Qe5B0GvF5BYjGuLrR1FL+GvCdxhqesHXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gMKqFdW9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/DedHDuh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721676439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zTqAPSQOKFywXvSkFHnbeOSSW8FEyJ/1Be4JDHYbCRQ=;
	b=gMKqFdW9NOlNojpfba/iev78dYVG0IyA3pIDeVSBeV0Khjfjd9D9ZEmHk6QlYkszB5PQFL
	dm9VQsPA+TExntF0iKn/fpDRiYomb5iBZhYB/M7C7Uf8182pyURd8Qolq1HxH9dJcPSinM
	H1RVdcQdusdCNvDUemP3ZE8Qe8trFZWMToeyO5Qm9o2Zl1q8cPAWVULY7JQVAWNICJGqd5
	13lOi2uzUteNIIKxU39bUWPlb1KaGct7hmTNWjlkXdsOFbj3DvHzu+I/sfxs2qPfZzkRGV
	y6m/eX/YvI4hDoVMtmLlER1zCRjhulVd0WyS+KsX9cpjV2ogO6jzETFipIMupA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721676439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zTqAPSQOKFywXvSkFHnbeOSSW8FEyJ/1Be4JDHYbCRQ=;
	b=/DedHDuhtQ4gxfwUQctZIMk7/4q2WLHIqIJZEZZBoNkFuGZQpbxPjJ26L1MDlX8/RIh8J8
	ehwm9Y/GjtXg6yBg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for v6.11-rc1
Message-ID: <172167641737.62829.15719424739961406637.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Jul 2024 21:27:18 +0200 (CEST)

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2024-07=
-15

up to:  b7b377332b96: irqdomain: Fix the kernel-doc and plug it into Document=
ation

[ Same as V1 minus the MSI conversion ]

Updates for the interrupt subsystem:

  - Core:

    - Provide a new mechanism to create interrupt domains. The existing
      interfaces have already too many parameters and it's a pain to expand
      any of this for new required functionality.

      The new function takes a pointer to a data structure as argument. The
      data structure combines all existing parameters and allows for easy
      extension.

      The first extension for this is to handle the instantiation of
      generic interrupt chips at the core level and to allow drivers to
      provide extra init/exit callbacks.

      This is necessary to do the full interrupt chip initialization before
      the new domain is published, so that concurrent usage sites won't see
      a half initialized interrupt domain. Similar problems exist on
      teardown.

      This has turned out to be a real problem due to the deferred and
      parallel probing which was added in recent years.

      Handling this at the core level allows to remove quite some accrued
      boilerplate code in existing drivers and avoids horrible workarounds
      at the driver level.

    - The usual small improvements all over the place

  - Drivers

    - Add support for LAN966x OIC and RZ/Five SoC

    - Split the STM ExtI driver into a microcontroller and a SMP version to
      allow building the latter as a module for multi-platform kernels.

    - Enable MSI support for Armada 370XP on platforms which do not support
      IPIs.

    - The usual small fixes and enhancements all over the place.


Thanks,

	tglx

------------------>
Adrian Huang (1):
      genirq/proc: Simplify irqdesc::kstat_irqs handling further

Antonio Borneo (8):
      irqchip/stm32-exti: Add CONFIG_STM32MP_EXTI
      ARM: stm32: Use different EXTI driver on ARMv7m and ARMv7a
      arm64: Kconfig: Select STM32MP_EXTI on STM32 platforms
      irqchip/stm32-exti: Split MCU and MPU code
      irqchip/stm32mp-exti: Rename internal symbols
      irqchip/stm32mp-exti: Allow building as module
      ARM: stm32: Allow build irq-stm32mp-exti driver as module
      arm64: Kconfig: Allow build irq-stm32mp-exti driver as module

Geert Uytterhoeven (1):
      irqchip/gic-v3: Pass #redistributor-regions to gic_of_setup_kvm_info()

Herve Codina (24):
      irqdomain: Add missing parameter descriptions in kernel-doc comments
      irqdomain: Fixed unbalanced fwnode get and put
      irqdomain: Introduce irq_domain_free()
      irqdomain: Introduce irq_domain_instantiate()
      irqdomain: Constify parameter in is_fwnode_irqchip()
      irqdomain: Use a dedicated function to set the domain name
      irqdomain: Convert __irq_domain_create() to use struct irq_domain_info
      irqdomain: Handle additional domain flags in irq_domain_instantiate()
      irqdomain: Handle domain hierarchy parent in irq_domain_instantiate()
      irqdomain: Use irq_domain_instantiate() for hierarchy domain creation
      irqdomain: Make __irq_domain_create() return an error code
      irqdomain: Handle domain bus token in irq_domain_create()
      irqdomain: Introduce init() and exit() hooks
      genirq/generic_chip: Introduce irq_domain_{alloc,remove}_generic_chips()
      genirq/generic_chip: Introduce init() and exit() hooks
      irqdomain: Add support for generic irq chips creation before publishing=
 a domain
      irqdomain: Add a resource managed version of irq_domain_instantiate()
      irqdomain: Convert __irq_domain_add() wrappers to irq_domain_instantiat=
e()
      irqdomain: Convert domain creation functions to irq_domain_instantiate()
      _PATCH_19_23_um_virt_pci_Use_irq_domain_instantiate_
      irqdomain: Remove __irq_domain_add()
      dt-bindings: interrupt-controller: Add support for Microchip LAN966x OIC
      irqchip: Add support for LAN966x OIC
      MAINTAINERS: Add the Microchip LAN966x OIC driver entry

Jeff Johnson (1):
      irqchip: Add missing MODULE_DESCRIPTION() macros

Jinjie Ruan (2):
      genirq/debugfs: Print irqdomain flags as human-readable strings
      irqchip/riscv-aplic: Simplify the initialization code

Jiri Slaby (SUSE) (1):
      irqdomain: Fix the kernel-doc and plug it into Documentation

Jisheng Zhang (2):
      irqchip/riscv-intc: Remove asmlinkage
      irqchip/dw-apb-ictl: Support building as module

Lad Prabhakar (3):
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/Five=
 SoC
      irqchip/renesas-rzg2l: Add support for RZ/Five SoC
      irqchip/renesas-rzg2l: Reorder function calls in rzg2l_irqc_irq_disable=
()

Lorenzo Pieralisi (1):
      irqchip/gic-v3: Enable non-coherent redistributors/ITSes ACPI probing

Marc Zyngier (3):
      irqchip/gic-v4: Always configure affinity on VPE activation
      irqchip/gic-v4: Substitute vmovp_lock for a per-VM lock
      irqchip/gic-v4: Make sure a VPE is locked when VMAPP is issued

Marek Beh=C3=BAn (1):
      irqchip/armada-370-xp: Use atomic_io_modify() instead of another spinlo=
ck

Pali Roh=C3=A1r (4):
      irqchip/armada-370-xp: Do not allow mapping IRQ 0 and 1
      irqchip/armada-370-xp: Only call ipi_resume() if IPI is available
      irqchip/armada-370-xp: Do not touch IPI registers on platforms without =
IPI
      irqchip/armada-370-xp: Add support for 32 MSI interrupts on non-IPI pla=
tforms

Rafael J. Wysocki (1):
      genirq: Set IRQF_COND_ONESHOT in request_irq()

Shenwei Wang (1):
      irqchip/imx-irqsteer: Handle runtime power management correctly

Stefan Wahren (1):
      irqchip/bcm2835: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND

Thomas Gleixner (3):
      irqdomain: Make build work for CONFIG_GENERIC_IRQ_CHIP=3Dn
      Revert "Loongarch: Support loongarch avec"
      Revert "irqchip/dw-apb-ictl: Support building as module"

Tianyang Zhang (1):
      Loongarch: Support loongarch avec


 Documentation/core-api/genericirq.rst              |   2 +
 .../microchip,lan966x-oic.yaml                     |  55 ++
 .../interrupt-controller/renesas,rzg2l-irqc.yaml   |  17 +-
 MAINTAINERS                                        |   6 +
 arch/arm/mach-stm32/Kconfig                        |   2 +-
 arch/arm64/Kconfig.platforms                       |   1 -
 arch/um/drivers/virt-pci.c                         |  16 +-
 drivers/acpi/processor_core.c                      |  15 +
 drivers/irqchip/Kconfig                            |  21 +
 drivers/irqchip/Makefile                           |   2 +
 drivers/irqchip/irq-armada-370-xp.c                | 121 +++-
 drivers/irqchip/irq-bcm2835.c                      |   4 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  52 +-
 drivers/irqchip/irq-gic-v3.c                       |  22 +-
 drivers/irqchip/irq-imx-irqsteer.c                 |  24 +-
 drivers/irqchip/irq-lan966x-oic.c                  | 278 ++++++++
 drivers/irqchip/irq-meson-gpio.c                   |   1 +
 drivers/irqchip/irq-mvebu-pic.c                    |   1 +
 drivers/irqchip/irq-renesas-rzg2l.c                | 150 ++++-
 drivers/irqchip/irq-riscv-aplic-main.c             |  13 +-
 drivers/irqchip/irq-riscv-intc.c                   |   4 +-
 drivers/irqchip/irq-stm32-exti.c                   | 670 +------------------
 drivers/irqchip/irq-stm32mp-exti.c                 | 729 +++++++++++++++++++=
++
 drivers/irqchip/irq-ts4800.c                       |   1 +
 include/linux/acpi.h                               |   3 +
 include/linux/interrupt.h                          |   2 +-
 include/linux/irq.h                                |  43 ++
 include/linux/irqchip/arm-gic-v4.h                 |   8 +
 include/linux/irqdomain.h                          | 136 +++-
 kernel/irq/debugfs.c                               |  10 +-
 kernel/irq/devres.c                                |  41 ++
 kernel/irq/generic-chip.c                          | 111 +++-
 kernel/irq/internals.h                             |  10 +
 kernel/irq/irqdomain.c                             | 287 +++++---
 kernel/irq/proc.c                                  |   7 +-
 35 files changed, 1965 insertions(+), 900 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mi=
crochip,lan966x-oic.yaml
 create mode 100644 drivers/irqchip/irq-lan966x-oic.c
 create mode 100644 drivers/irqchip/irq-stm32mp-exti.c

diff --git a/Documentation/core-api/genericirq.rst b/Documentation/core-api/g=
enericirq.rst
index 4a460639ab1c..7a27663f309f 100644
--- a/Documentation/core-api/genericirq.rst
+++ b/Documentation/core-api/genericirq.rst
@@ -410,6 +410,8 @@ which are used in the generic IRQ layer.
 .. kernel-doc:: include/linux/interrupt.h
    :internal:
=20
+.. kernel-doc:: include/linux/irqdomain.h
+
 Public Functions Provided
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/Documentation/devicetree/bindings/interrupt-controller/microchip=
,lan966x-oic.yaml b/Documentation/devicetree/bindings/interrupt-controller/mi=
crochip,lan966x-oic.yaml
new file mode 100644
index 000000000000..b2adc7174177
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/microchip,lan966=
x-oic.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/microchip,lan966x-oi=
c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN966x outband interrupt controller
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+description: |
+  The Microchip LAN966x outband interrupt controller (OIC) maps the internal
+  interrupt sources of the LAN966x device to an external interrupt.
+  When the LAN966x device is used as a PCI device, the external interrupt is
+  routed to the PCI interrupt.
+
+properties:
+  compatible:
+    const: microchip,lan966x-oic
+
+  '#interrupt-cells':
+    const: 2
+
+  interrupt-controller: true
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - interrupt-controller
+  - interrupts
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@e00c0120 {
+        compatible =3D "microchip,lan966x-oic";
+        reg =3D <0xe00c0120 0x190>;
+        #interrupt-cells =3D <2>;
+        interrupt-controller;
+        interrupts =3D <0>;
+        interrupt-parent =3D <&intc>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,r=
zg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renes=
as,rzg2l-irqc.yaml
index daef4ee06f4e..44b6ae5fc802 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-ir=
qc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-ir=
qc.yaml
@@ -21,13 +21,16 @@ description: |
=20
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r9a07g043u-irqc   # RZ/G2UL
-          - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
-          - renesas,r9a07g054-irqc    # RZ/V2L
-          - renesas,r9a08g045-irqc    # RZ/G3S
-      - const: renesas,rzg2l-irqc
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g043u-irqc    # RZ/G2UL
+              - renesas,r9a07g044-irqc     # RZ/G2{L,LC}
+              - renesas,r9a07g054-irqc     # RZ/V2L
+              - renesas,r9a08g045-irqc     # RZ/G3S
+          - const: renesas,rzg2l-irqc
+
+      - const: renesas,r9a07g043f-irqc     # RZ/Five
=20
   '#interrupt-cells':
     description: The first cell should contain a macro RZG2L_{NMI,IRQX} incl=
uded in the
diff --git a/MAINTAINERS b/MAINTAINERS
index 8754ac2c259d..c47d8b9114b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14727,6 +14727,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/microchip/lan966x/*
=20
+MICROCHIP LAN966X OIC DRIVER
+M:	Herve Codina <herve.codina@bootlin.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-=
oic.yaml
+F:	drivers/irqchip/irq-lan966x-oic.c
+
 MICROCHIP LCDFB DRIVER
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 L:	linux-fbdev@vger.kernel.org
diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index ae21a9f78f9c..630b992f32b1 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -11,7 +11,7 @@ menuconfig ARCH_STM32
 	select CLKSRC_STM32
 	select PINCTRL
 	select RESET_CONTROLLER
-	select STM32_EXTI
+	select STM32_EXTI if ARM_SINGLE_ARMV7M
 	select STM32_FIREWALL
 	help
 	  Support for STMicroelectronics STM32 processors.
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index a52618073de2..a028ea312378 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -309,7 +309,6 @@ config ARCH_STM32
 	select GPIOLIB
 	select PINCTRL
 	select PINCTRL_STM32MP257
-	select STM32_EXTI
 	select ARM_SMC_MBOX
 	select ARM_SCMI_PROTOCOL
 	select COMMON_CLK_SCMI
diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 7cb503469bbd..a0883d5445b5 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -986,6 +986,11 @@ static struct resource virt_platform_resource =3D {
=20
 static int __init um_pci_init(void)
 {
+	struct irq_domain_info inner_domain_info =3D {
+		.size		=3D MAX_MSI_VECTORS,
+		.hwirq_max	=3D MAX_MSI_VECTORS,
+		.ops		=3D &um_pci_inner_domain_ops,
+	};
 	int err, i;
=20
 	WARN_ON(logic_iomem_add_region(&virt_cfgspace_resource,
@@ -1015,11 +1020,10 @@ static int __init um_pci_init(void)
 		goto free;
 	}
=20
-	um_pci_inner_domain =3D __irq_domain_add(um_pci_fwnode, MAX_MSI_VECTORS,
-					       MAX_MSI_VECTORS, 0,
-					       &um_pci_inner_domain_ops, NULL);
-	if (!um_pci_inner_domain) {
-		err =3D -ENOMEM;
+	inner_domain_info.fwnode =3D um_pci_fwnode;
+	um_pci_inner_domain =3D irq_domain_instantiate(&inner_domain_info);
+	if (IS_ERR(um_pci_inner_domain)) {
+		err =3D PTR_ERR(um_pci_inner_domain);
 		goto free;
 	}
=20
@@ -1056,7 +1060,7 @@ static int __init um_pci_init(void)
 		goto free;
 	return 0;
 free:
-	if (um_pci_inner_domain)
+	if (!IS_ERR_OR_NULL(um_pci_inner_domain))
 		irq_domain_remove(um_pci_inner_domain);
 	if (um_pci_fwnode)
 		irq_domain_free_fwnode(um_pci_fwnode);
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index b203cfe28550..915713c0e9b7 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -215,6 +215,21 @@ phys_cpuid_t __init acpi_map_madt_entry(u32 acpi_id)
 	return rv;
 }
=20
+int __init acpi_get_madt_revision(void)
+{
+	struct acpi_table_header *madt =3D NULL;
+	int revision;
+
+	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_MADT, 0, &madt)))
+		return -EINVAL;
+
+	revision =3D madt->revision;
+
+	acpi_put_table(madt);
+
+	return revision;
+}
+
 static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
 {
 	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 14464716bacb..344c484736af 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -169,6 +169,18 @@ config IXP4XX_IRQ
 	select IRQ_DOMAIN
 	select SPARSE_IRQ
=20
+config LAN966X_OIC
+	tristate "Microchip LAN966x OIC Support"
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+	help
+	  Enable support for the LAN966x Outbound Interrupt Controller.
+	  This controller is present on the Microchip LAN966x PCI device and
+	  maps the internal interrupts sources to PCIe interrupt.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called irq-lan966x-oic.
+
 config MADERA_IRQ
 	tristate
=20
@@ -392,6 +404,15 @@ config LS_SCFG_MSI
 config PARTITION_PERCPU
 	bool
=20
+config STM32MP_EXTI
+	tristate "STM32MP extended interrupts and event controller"
+	depends on (ARCH_STM32 && !ARM_SINGLE_ARMV7M) || COMPILE_TEST
+	default y
+	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_IRQ_CHIP
+	help
+	  Support STM32MP EXTI (extended interrupts and event) controller.
+
 config STM32_EXTI
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d9dc3d99aaa8..2df72b7b165b 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_MVEBU_SEI)			+=3D irq-mvebu-sei.o
 obj-$(CONFIG_LS_EXTIRQ)			+=3D irq-ls-extirq.o
 obj-$(CONFIG_LS_SCFG_MSI)		+=3D irq-ls-scfg-msi.o
 obj-$(CONFIG_ARCH_ASPEED)		+=3D irq-aspeed-vic.o irq-aspeed-i2c-ic.o irq-asp=
eed-scu-ic.o
+obj-$(CONFIG_STM32MP_EXTI)		+=3D irq-stm32mp-exti.o
 obj-$(CONFIG_STM32_EXTI) 		+=3D irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+=3D qcom-irq-combiner.o
 obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+=3D irq-uniphier-aidet.o
@@ -104,6 +105,7 @@ obj-$(CONFIG_IMX_IRQSTEER)		+=3D irq-imx-irqsteer.o
 obj-$(CONFIG_IMX_INTMUX)		+=3D irq-imx-intmux.o
 obj-$(CONFIG_IMX_MU_MSI)		+=3D irq-imx-mu-msi.o
 obj-$(CONFIG_MADERA_IRQ)		+=3D irq-madera.o
+obj-$(CONFIG_LAN966X_OIC)		+=3D irq-lan966x-oic.o
 obj-$(CONFIG_LS1X_IRQ)			+=3D irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+=3D irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+=3D irq-ti-sci-inta.o
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 4b021a67bdfe..dce2b80bf439 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -13,6 +13,7 @@
  * warranty of any kind, whether express or implied.
  */
=20
+#include <linux/bits.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -29,6 +30,7 @@
 #include <linux/slab.h>
 #include <linux/syscore_ops.h>
 #include <linux/msi.h>
+#include <linux/types.h>
 #include <asm/mach/arch.h>
 #include <asm/exception.h>
 #include <asm/smp_plat.h>
@@ -135,6 +137,7 @@
=20
 #define ARMADA_370_XP_MAX_PER_CPU_IRQS		(28)
=20
+/* IPI and MSI interrupt definitions for IPI platforms */
 #define IPI_DOORBELL_START                      (0)
 #define IPI_DOORBELL_END                        (8)
 #define IPI_DOORBELL_MASK                       0xFF
@@ -143,6 +146,14 @@
 #define PCI_MSI_DOORBELL_END                    (32)
 #define PCI_MSI_DOORBELL_MASK                   0xFFFF0000
=20
+/* MSI interrupt definitions for non-IPI platforms */
+#define PCI_MSI_FULL_DOORBELL_START		0
+#define PCI_MSI_FULL_DOORBELL_NR		32
+#define PCI_MSI_FULL_DOORBELL_END		32
+#define PCI_MSI_FULL_DOORBELL_MASK		GENMASK(31, 0)
+#define PCI_MSI_FULL_DOORBELL_SRC0_MASK		GENMASK(15, 0)
+#define PCI_MSI_FULL_DOORBELL_SRC1_MASK		GENMASK(31, 16)
+
 static void __iomem *per_cpu_int_base;
 static void __iomem *main_int_base;
 static struct irq_domain *armada_370_xp_mpic_domain;
@@ -151,11 +162,46 @@ static int parent_irq;
 #ifdef CONFIG_PCI_MSI
 static struct irq_domain *armada_370_xp_msi_domain;
 static struct irq_domain *armada_370_xp_msi_inner_domain;
-static DECLARE_BITMAP(msi_used, PCI_MSI_DOORBELL_NR);
+static DECLARE_BITMAP(msi_used, PCI_MSI_FULL_DOORBELL_NR);
 static DEFINE_MUTEX(msi_used_lock);
 static phys_addr_t msi_doorbell_addr;
 #endif
=20
+static inline bool is_ipi_available(void)
+{
+	/*
+	 * We distinguish IPI availability in the IC by the IC not having a
+	 * parent irq defined. If a parent irq is defined, there is a parent
+	 * interrupt controller (e.g. GIC) that takes care of inter-processor
+	 * interrupts.
+	 */
+	return parent_irq <=3D 0;
+}
+
+static inline u32 msi_doorbell_mask(void)
+{
+	return is_ipi_available() ? PCI_MSI_DOORBELL_MASK :
+				    PCI_MSI_FULL_DOORBELL_MASK;
+}
+
+static inline unsigned int msi_doorbell_start(void)
+{
+	return is_ipi_available() ? PCI_MSI_DOORBELL_START :
+				    PCI_MSI_FULL_DOORBELL_START;
+}
+
+static inline unsigned int msi_doorbell_size(void)
+{
+	return is_ipi_available() ? PCI_MSI_DOORBELL_NR :
+				    PCI_MSI_FULL_DOORBELL_NR;
+}
+
+static inline unsigned int msi_doorbell_end(void)
+{
+	return is_ipi_available() ? PCI_MSI_DOORBELL_END :
+				    PCI_MSI_FULL_DOORBELL_END;
+}
+
 static inline bool is_percpu_irq(irq_hw_number_t irq)
 {
 	if (irq <=3D ARMADA_370_XP_MAX_PER_CPU_IRQS)
@@ -213,7 +259,7 @@ static void armada_370_xp_compose_msi_msg(struct irq_data=
 *data, struct msi_msg
=20
 	msg->address_lo =3D lower_32_bits(msi_doorbell_addr);
 	msg->address_hi =3D upper_32_bits(msi_doorbell_addr);
-	msg->data =3D BIT(cpu + 8) | (data->hwirq + PCI_MSI_DOORBELL_START);
+	msg->data =3D BIT(cpu + 8) | (data->hwirq + msi_doorbell_start());
 }
=20
 static int armada_370_xp_msi_set_affinity(struct irq_data *irq_data,
@@ -246,7 +292,7 @@ static int armada_370_xp_msi_alloc(struct irq_domain *dom=
ain, unsigned int virq,
 	int hwirq, i;
=20
 	mutex_lock(&msi_used_lock);
-	hwirq =3D bitmap_find_free_region(msi_used, PCI_MSI_DOORBELL_NR,
+	hwirq =3D bitmap_find_free_region(msi_used, msi_doorbell_size(),
 					order_base_2(nr_irqs));
 	mutex_unlock(&msi_used_lock);
=20
@@ -283,9 +329,10 @@ static void armada_370_xp_msi_reenable_percpu(void)
 	u32 reg;
=20
 	/* Enable MSI doorbell mask and combined cpu local interrupt */
-	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS)
-		| PCI_MSI_DOORBELL_MASK;
+	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	reg |=3D msi_doorbell_mask();
 	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+
 	/* Unmask local doorbell interrupt */
 	writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
 }
@@ -297,7 +344,7 @@ static int armada_370_xp_msi_init(struct device_node *nod=
e,
 		ARMADA_370_XP_SW_TRIG_INT_OFFS;
=20
 	armada_370_xp_msi_inner_domain =3D
-		irq_domain_add_linear(NULL, PCI_MSI_DOORBELL_NR,
+		irq_domain_add_linear(NULL, msi_doorbell_size(),
 				      &armada_370_xp_msi_domain_ops, NULL);
 	if (!armada_370_xp_msi_inner_domain)
 		return -ENOMEM;
@@ -313,6 +360,10 @@ static int armada_370_xp_msi_init(struct device_node *no=
de,
=20
 	armada_370_xp_msi_reenable_percpu();
=20
+	/* Unmask low 16 MSI irqs on non-IPI platforms */
+	if (!is_ipi_available())
+		writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+
 	return 0;
 }
 #else
@@ -461,24 +512,18 @@ static __init void armada_xp_ipi_init(struct device_nod=
e *node)
 	set_smp_ipi_range(base_ipi, IPI_DOORBELL_END);
 }
=20
-static DEFINE_RAW_SPINLOCK(irq_controller_lock);
-
 static int armada_xp_set_affinity(struct irq_data *d,
 				  const struct cpumask *mask_val, bool force)
 {
 	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
-	unsigned long reg, mask;
 	int cpu;
=20
 	/* Select a single core from the affinity mask which is online */
 	cpu =3D cpumask_any_and(mask_val, cpu_online_mask);
-	mask =3D 1UL << cpu_logical_map(cpu);
=20
-	raw_spin_lock(&irq_controller_lock);
-	reg =3D readl(main_int_base + ARMADA_370_XP_INT_SOURCE_CTL(hwirq));
-	reg =3D (reg & (~ARMADA_370_XP_INT_SOURCE_CPU_MASK)) | mask;
-	writel(reg, main_int_base + ARMADA_370_XP_INT_SOURCE_CTL(hwirq));
-	raw_spin_unlock(&irq_controller_lock);
+	atomic_io_modify(main_int_base + ARMADA_370_XP_INT_SOURCE_CTL(hwirq),
+			 ARMADA_370_XP_INT_SOURCE_CPU_MASK,
+			 BIT(cpu_logical_map(cpu)));
=20
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
=20
@@ -496,6 +541,9 @@ static void armada_xp_mpic_smp_cpu_init(void)
 	for (i =3D 0; i < nr_irqs; i++)
 		writel(i, per_cpu_int_base + ARMADA_370_XP_INT_SET_MASK_OFFS);
=20
+	if (!is_ipi_available())
+		return;
+
 	/* Disable all IPIs */
 	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
=20
@@ -527,7 +575,8 @@ static void armada_xp_mpic_reenable_percpu(void)
 		armada_370_xp_irq_unmask(data);
 	}
=20
-	ipi_resume();
+	if (is_ipi_available())
+		ipi_resume();
=20
 	armada_370_xp_msi_reenable_percpu();
 }
@@ -566,6 +615,10 @@ static struct irq_chip armada_370_xp_irq_chip =3D {
 static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 				      unsigned int virq, irq_hw_number_t hw)
 {
+	/* IRQs 0 and 1 cannot be mapped, they are handled internally */
+	if (hw <=3D 1)
+		return -EINVAL;
+
 	armada_370_xp_irq_mask(irq_get_irq_data(virq));
 	if (!is_percpu_irq(hw))
 		writel(hw, per_cpu_int_base +
@@ -599,20 +652,20 @@ static void armada_370_xp_handle_msi_irq(struct pt_regs=
 *regs, bool is_chained)
 	u32 msimask, msinr;
=20
 	msimask =3D readl_relaxed(per_cpu_int_base +
-				ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS)
-		& PCI_MSI_DOORBELL_MASK;
+				ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
+	msimask &=3D msi_doorbell_mask();
=20
 	writel(~msimask, per_cpu_int_base +
 	       ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
=20
-	for (msinr =3D PCI_MSI_DOORBELL_START;
-	     msinr < PCI_MSI_DOORBELL_END; msinr++) {
+	for (msinr =3D msi_doorbell_start();
+	     msinr < msi_doorbell_end(); msinr++) {
 		unsigned int irq;
=20
 		if (!(msimask & BIT(msinr)))
 			continue;
=20
-		irq =3D msinr - PCI_MSI_DOORBELL_START;
+		irq =3D msinr - msi_doorbell_start();
=20
 		generic_handle_domain_irq(armada_370_xp_msi_inner_domain, irq);
 	}
@@ -641,7 +694,7 @@ static void armada_370_xp_mpic_handle_cascade_irq(struct =
irq_desc *desc)
 		if (!(irqsrc & ARMADA_370_XP_INT_IRQ_FIQ_MASK(cpuid)))
 			continue;
=20
-		if (irqn =3D=3D 1) {
+		if (irqn =3D=3D 0 || irqn =3D=3D 1) {
 			armada_370_xp_handle_msi_irq(NULL, true);
 			continue;
 		}
@@ -702,6 +755,7 @@ static int armada_370_xp_mpic_suspend(void)
=20
 static void armada_370_xp_mpic_resume(void)
 {
+	bool src0, src1;
 	int nirqs;
 	irq_hw_number_t irq;
=20
@@ -741,12 +795,22 @@ static void armada_370_xp_mpic_resume(void)
 	/* Reconfigure doorbells for IPIs and MSIs */
 	writel(doorbell_mask_reg,
 	       per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
-	if (doorbell_mask_reg & IPI_DOORBELL_MASK)
+
+	if (is_ipi_available()) {
+		src0 =3D doorbell_mask_reg & IPI_DOORBELL_MASK;
+		src1 =3D doorbell_mask_reg & PCI_MSI_DOORBELL_MASK;
+	} else {
+		src0 =3D doorbell_mask_reg & PCI_MSI_FULL_DOORBELL_SRC0_MASK;
+		src1 =3D doorbell_mask_reg & PCI_MSI_FULL_DOORBELL_SRC1_MASK;
+	}
+
+	if (src0)
 		writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
-	if (doorbell_mask_reg & PCI_MSI_DOORBELL_MASK)
+	if (src1)
 		writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
=20
-	ipi_resume();
+	if (is_ipi_available())
+		ipi_resume();
 }
=20
 static struct syscore_ops armada_370_xp_mpic_syscore_ops =3D {
@@ -791,13 +855,18 @@ static int __init armada_370_xp_mpic_of_init(struct dev=
ice_node *node,
 	BUG_ON(!armada_370_xp_mpic_domain);
 	irq_domain_update_bus_token(armada_370_xp_mpic_domain, DOMAIN_BUS_WIRED);
=20
+	/*
+	 * Initialize parent_irq before calling any other functions, since it is
+	 * used to distinguish between IPI and non-IPI platforms.
+	 */
+	parent_irq =3D irq_of_parse_and_map(node, 0);
+
 	/* Setup for the boot CPU */
 	armada_xp_mpic_perf_init();
 	armada_xp_mpic_smp_cpu_init();
=20
 	armada_370_xp_msi_init(node, main_int_res.start);
=20
-	parent_irq =3D irq_of_parse_and_map(node, 0);
 	if (parent_irq <=3D 0) {
 		irq_set_default_host(armada_370_xp_mpic_domain);
 		set_handle_irq(armada_370_xp_handle_irq);
diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index e94e2882286c..6c20604c2242 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -102,7 +102,9 @@ static void armctrl_unmask_irq(struct irq_data *d)
 static struct irq_chip armctrl_chip =3D {
 	.name =3D "ARMCTRL-level",
 	.irq_mask =3D armctrl_mask_irq,
-	.irq_unmask =3D armctrl_unmask_irq
+	.irq_unmask =3D armctrl_unmask_irq,
+	.flags =3D IRQCHIP_MASK_ON_SUSPEND |
+		 IRQCHIP_SKIP_SET_WAKE,
 };
=20
 static int armctrl_xlate(struct irq_domain *d, struct device_node *ctrlr,
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index 40ebf1726393..c23a64fcf9b3 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1317,7 +1317,6 @@ static void its_send_vmovp(struct its_vpe *vpe)
 {
 	struct its_cmd_desc desc =3D {};
 	struct its_node *its;
-	unsigned long flags;
 	int col_id =3D vpe->col_idx;
=20
 	desc.its_vmovp_cmd.vpe =3D vpe;
@@ -1329,6 +1328,12 @@ static void its_send_vmovp(struct its_vpe *vpe)
 		return;
 	}
=20
+	/*
+	 * Protect against concurrent updates of the mapping state on
+	 * individual VMs.
+	 */
+	guard(raw_spinlock_irqsave)(&vpe->its_vm->vmapp_lock);
+
 	/*
 	 * Yet another marvel of the architecture. If using the
 	 * its_list "feature", we need to make sure that all ITSs
@@ -1337,8 +1342,7 @@ static void its_send_vmovp(struct its_vpe *vpe)
 	 *
 	 * Wall <-- Head.
 	 */
-	raw_spin_lock_irqsave(&vmovp_lock, flags);
-
+	guard(raw_spinlock)(&vmovp_lock);
 	desc.its_vmovp_cmd.seq_num =3D vmovp_seq_num++;
 	desc.its_vmovp_cmd.its_list =3D get_its_list(vpe->its_vm);
=20
@@ -1353,8 +1357,6 @@ static void its_send_vmovp(struct its_vpe *vpe)
 		desc.its_vmovp_cmd.col =3D &its->collections[col_id];
 		its_send_single_vcommand(its, its_build_vmovp_cmd, &desc);
 	}
-
-	raw_spin_unlock_irqrestore(&vmovp_lock, flags);
 }
=20
 static void its_send_vinvall(struct its_node *its, struct its_vpe *vpe)
@@ -1791,12 +1793,10 @@ static bool gic_requires_eager_mapping(void)
=20
 static void its_map_vm(struct its_node *its, struct its_vm *vm)
 {
-	unsigned long flags;
-
 	if (gic_requires_eager_mapping())
 		return;
=20
-	raw_spin_lock_irqsave(&vmovp_lock, flags);
+	guard(raw_spinlock_irqsave)(&vm->vmapp_lock);
=20
 	/*
 	 * If the VM wasn't mapped yet, iterate over the vpes and get
@@ -1809,37 +1809,31 @@ static void its_map_vm(struct its_node *its, struct i=
ts_vm *vm)
=20
 		for (i =3D 0; i < vm->nr_vpes; i++) {
 			struct its_vpe *vpe =3D vm->vpes[i];
-			struct irq_data *d =3D irq_get_irq_data(vpe->irq);
=20
-			/* Map the VPE to the first possible CPU */
-			vpe->col_idx =3D cpumask_first(cpu_online_mask);
-			its_send_vmapp(its, vpe, true);
+			scoped_guard(raw_spinlock, &vpe->vpe_lock)
+				its_send_vmapp(its, vpe, true);
+
 			its_send_vinvall(its, vpe);
-			irq_data_update_effective_affinity(d, cpumask_of(vpe->col_idx));
 		}
 	}
-
-	raw_spin_unlock_irqrestore(&vmovp_lock, flags);
 }
=20
 static void its_unmap_vm(struct its_node *its, struct its_vm *vm)
 {
-	unsigned long flags;
-
 	/* Not using the ITS list? Everything is always mapped. */
 	if (gic_requires_eager_mapping())
 		return;
=20
-	raw_spin_lock_irqsave(&vmovp_lock, flags);
+	guard(raw_spinlock_irqsave)(&vm->vmapp_lock);
=20
 	if (!--vm->vlpi_count[its->list_nr]) {
 		int i;
=20
-		for (i =3D 0; i < vm->nr_vpes; i++)
+		for (i =3D 0; i < vm->nr_vpes; i++) {
+			guard(raw_spinlock)(&vm->vpes[i]->vpe_lock);
 			its_send_vmapp(its, vm->vpes[i], false);
+		}
 	}
-
-	raw_spin_unlock_irqrestore(&vmovp_lock, flags);
 }
=20
 static int its_vlpi_map(struct irq_data *d, struct its_cmd_info *info)
@@ -3946,6 +3940,8 @@ static void its_vpe_invall(struct its_vpe *vpe)
 {
 	struct its_node *its;
=20
+	guard(raw_spinlock_irqsave)(&vpe->its_vm->vmapp_lock);
+
 	list_for_each_entry(its, &its_nodes, entry) {
 		if (!is_v4(its))
 			continue;
@@ -4551,6 +4547,7 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *=
domain, unsigned int virq
 	vm->db_lpi_base =3D base;
 	vm->nr_db_lpis =3D nr_ids;
 	vm->vprop_page =3D vprop_page;
+	raw_spin_lock_init(&vm->vmapp_lock);
=20
 	if (gic_rdists->has_rvpeid)
 		irqchip =3D &its_vpe_4_1_irq_chip;
@@ -4582,6 +4579,10 @@ static int its_vpe_irq_domain_activate(struct irq_doma=
in *domain,
 	struct its_vpe *vpe =3D irq_data_get_irq_chip_data(d);
 	struct its_node *its;
=20
+	/* Map the VPE to the first possible CPU */
+	vpe->col_idx =3D cpumask_first(cpu_online_mask);
+	irq_data_update_effective_affinity(d, cpumask_of(vpe->col_idx));
+
 	/*
 	 * If we use the list map, we issue VMAPP on demand... Unless
 	 * we're on a GICv4.1 and we eagerly map the VPE on all ITSs
@@ -4590,9 +4591,6 @@ static int its_vpe_irq_domain_activate(struct irq_domai=
n *domain,
 	if (!gic_requires_eager_mapping())
 		return 0;
=20
-	/* Map the VPE to the first possible CPU */
-	vpe->col_idx =3D cpumask_first(cpu_online_mask);
-
 	list_for_each_entry(its, &its_nodes, entry) {
 		if (!is_v4(its))
 			continue;
@@ -4601,8 +4599,6 @@ static int its_vpe_irq_domain_activate(struct irq_domai=
n *domain,
 		its_send_vinvall(its, vpe);
 	}
=20
-	irq_data_update_effective_affinity(d, cpumask_of(vpe->col_idx));
-
 	return 0;
 }
=20
@@ -5600,6 +5596,10 @@ static int __init gic_acpi_parse_madt_its(union acpi_s=
ubtable_headers *header,
 		goto node_err;
 	}
=20
+	if (acpi_get_madt_revision() >=3D 7 &&
+	    (its_entry->flags & ACPI_MADT_ITS_NON_COHERENT))
+		its->flags |=3D ITS_FLAGS_FORCE_NON_SHAREABLE;
+
 	err =3D its_probe_one(its);
 	if (!err)
 		return 0;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 6fb276504bcc..7c12d11513c6 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2190,11 +2190,10 @@ static void __init gic_populate_ppi_partitions(struct=
 device_node *gic_node)
 	of_node_put(parts_node);
 }
=20
-static void __init gic_of_setup_kvm_info(struct device_node *node)
+static void __init gic_of_setup_kvm_info(struct device_node *node, u32 nr_re=
dist_regions)
 {
 	int ret;
 	struct resource r;
-	u32 gicv_idx;
=20
 	gic_v3_kvm_info.type =3D GIC_V3;
=20
@@ -2202,12 +2201,8 @@ static void __init gic_of_setup_kvm_info(struct device=
_node *node)
 	if (!gic_v3_kvm_info.maint_irq)
 		return;
=20
-	if (of_property_read_u32(node, "#redistributor-regions",
-				 &gicv_idx))
-		gicv_idx =3D 1;
-
-	gicv_idx +=3D 3;	/* Also skip GICD, GICC, GICH */
-	ret =3D of_address_to_resource(node, gicv_idx, &r);
+	/* Also skip GICD, GICC, GICH */
+	ret =3D of_address_to_resource(node, nr_redist_regions + 3, &r);
 	if (!ret)
 		gic_v3_kvm_info.vcpu =3D r;
=20
@@ -2297,7 +2292,7 @@ static int __init gic_of_init(struct device_node *node,=
 struct device_node *pare
 	gic_populate_ppi_partitions(node);
=20
 	if (static_branch_likely(&supports_deactivate_key))
-		gic_of_setup_kvm_info(node);
+		gic_of_setup_kvm_info(node, nr_redist_regions);
 	return 0;
=20
 out_unmap_rdist:
@@ -2349,6 +2344,11 @@ gic_acpi_parse_madt_redist(union acpi_subtable_headers=
 *header,
 		pr_err("Couldn't map GICR region @%llx\n", redist->base_address);
 		return -ENOMEM;
 	}
+
+	if (acpi_get_madt_revision() >=3D 7 &&
+	    (redist->flags & ACPI_MADT_GICR_NON_COHERENT))
+		gic_data.rdists.flags |=3D RDIST_FLAGS_FORCE_NON_SHAREABLE;
+
 	gic_request_region(redist->base_address, redist->length, "GICR");
=20
 	gic_acpi_register_redist(redist->base_address, redist_base);
@@ -2373,6 +2373,10 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *=
header,
 		return -ENOMEM;
 	gic_request_region(gicc->gicr_base_address, size, "GICR");
=20
+	if (acpi_get_madt_revision() >=3D 7 &&
+	    (gicc->flags & ACPI_MADT_GICC_NON_COHERENT))
+		gic_data.rdists.flags |=3D RDIST_FLAGS_FORCE_NON_SHAREABLE;
+
 	gic_acpi_register_redist(gicc->gicr_base_address, redist_base);
 	return 0;
 }
diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irq=
steer.c
index 20cf7a9e9ece..75a0e980ff35 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -36,6 +36,7 @@ struct irqsteer_data {
 	int			channel;
 	struct irq_domain	*domain;
 	u32			*saved_reg;
+	struct device		*dev;
 };
=20
 static int imx_irqsteer_get_reg_index(struct irqsteer_data *data,
@@ -72,10 +73,26 @@ static void imx_irqsteer_irq_mask(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&data->lock, flags);
 }
=20
+static void imx_irqsteer_irq_bus_lock(struct irq_data *d)
+{
+	struct irqsteer_data *data =3D d->chip_data;
+
+	pm_runtime_get_sync(data->dev);
+}
+
+static void imx_irqsteer_irq_bus_sync_unlock(struct irq_data *d)
+{
+	struct irqsteer_data *data =3D d->chip_data;
+
+	pm_runtime_put_autosuspend(data->dev);
+}
+
 static const struct irq_chip imx_irqsteer_irq_chip =3D {
-	.name		=3D "irqsteer",
-	.irq_mask	=3D imx_irqsteer_irq_mask,
-	.irq_unmask	=3D imx_irqsteer_irq_unmask,
+	.name			=3D "irqsteer",
+	.irq_mask		=3D imx_irqsteer_irq_mask,
+	.irq_unmask		=3D imx_irqsteer_irq_unmask,
+	.irq_bus_lock		=3D imx_irqsteer_irq_bus_lock,
+	.irq_bus_sync_unlock	=3D imx_irqsteer_irq_bus_sync_unlock,
 };
=20
 static int imx_irqsteer_irq_map(struct irq_domain *h, unsigned int irq,
@@ -150,6 +167,7 @@ static int imx_irqsteer_probe(struct platform_device *pde=
v)
 	if (!data)
 		return -ENOMEM;
=20
+	data->dev =3D &pdev->dev;
 	data->regs =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->regs)) {
 		dev_err(&pdev->dev, "failed to initialize reg\n");
diff --git a/drivers/irqchip/irq-lan966x-oic.c b/drivers/irqchip/irq-lan966x-=
oic.c
new file mode 100644
index 000000000000..41ac880e3b87
--- /dev/null
+++ b/drivers/irqchip/irq-lan966x-oic.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the Microchip LAN966x outbound interrupt controller
+ *
+ * Copyright (c) 2024 Technology Inc. and its subsidiaries.
+ *
+ * Authors:
+ *	Horatiu Vultur <horatiu.vultur@microchip.com>
+ *	Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
+ *	Herve Codina <herve.codina@bootlin.com>
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip.h>
+#include <linux/irq.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+struct lan966x_oic_chip_regs {
+	int reg_off_ena_set;
+	int reg_off_ena_clr;
+	int reg_off_sticky;
+	int reg_off_ident;
+	int reg_off_map;
+};
+
+struct lan966x_oic_data {
+	void __iomem	*regs;
+	int		irq;
+};
+
+#define LAN966X_OIC_NR_IRQ 86
+
+/* Interrupt sticky status */
+#define LAN966X_OIC_INTR_STICKY		0x30
+#define LAN966X_OIC_INTR_STICKY1	0x34
+#define LAN966X_OIC_INTR_STICKY2	0x38
+
+/* Interrupt enable */
+#define LAN966X_OIC_INTR_ENA		0x48
+#define LAN966X_OIC_INTR_ENA1		0x4c
+#define LAN966X_OIC_INTR_ENA2		0x50
+
+/* Atomic clear of interrupt enable */
+#define LAN966X_OIC_INTR_ENA_CLR	0x54
+#define LAN966X_OIC_INTR_ENA_CLR1	0x58
+#define LAN966X_OIC_INTR_ENA_CLR2	0x5c
+
+/* Atomic set of interrupt */
+#define LAN966X_OIC_INTR_ENA_SET	0x60
+#define LAN966X_OIC_INTR_ENA_SET1	0x64
+#define LAN966X_OIC_INTR_ENA_SET2	0x68
+
+/* Mapping of source to destination interrupts (_n =3D 0..8) */
+#define LAN966X_OIC_DST_INTR_MAP(_n)	(0x78 + (_n) * 4)
+#define LAN966X_OIC_DST_INTR_MAP1(_n)	(0x9c + (_n) * 4)
+#define LAN966X_OIC_DST_INTR_MAP2(_n)	(0xc0 + (_n) * 4)
+
+/* Currently active interrupt sources per destination (_n =3D 0..8) */
+#define LAN966X_OIC_DST_INTR_IDENT(_n)	(0xe4 + (_n) * 4)
+#define LAN966X_OIC_DST_INTR_IDENT1(_n)	(0x108 + (_n) * 4)
+#define LAN966X_OIC_DST_INTR_IDENT2(_n)	(0x12c + (_n) * 4)
+
+static unsigned int lan966x_oic_irq_startup(struct irq_data *data)
+{
+	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(data);
+	struct irq_chip_type *ct =3D irq_data_get_chip_type(data);
+	struct lan966x_oic_chip_regs *chip_regs =3D gc->private;
+	u32 map;
+
+	irq_gc_lock(gc);
+
+	/* Map the source interrupt to the destination */
+	map =3D irq_reg_readl(gc, chip_regs->reg_off_map);
+	map |=3D data->mask;
+	irq_reg_writel(gc, map, chip_regs->reg_off_map);
+
+	irq_gc_unlock(gc);
+
+	ct->chip.irq_ack(data);
+	ct->chip.irq_unmask(data);
+
+	return 0;
+}
+
+static void lan966x_oic_irq_shutdown(struct irq_data *data)
+{
+	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(data);
+	struct irq_chip_type *ct =3D irq_data_get_chip_type(data);
+	struct lan966x_oic_chip_regs *chip_regs =3D gc->private;
+	u32 map;
+
+	ct->chip.irq_mask(data);
+
+	irq_gc_lock(gc);
+
+	/* Unmap the interrupt */
+	map =3D irq_reg_readl(gc, chip_regs->reg_off_map);
+	map &=3D ~data->mask;
+	irq_reg_writel(gc, map, chip_regs->reg_off_map);
+
+	irq_gc_unlock(gc);
+}
+
+static int lan966x_oic_irq_set_type(struct irq_data *data,
+				    unsigned int flow_type)
+{
+	if (flow_type !=3D IRQ_TYPE_LEVEL_HIGH) {
+		pr_err("lan966x oic doesn't support flow type %d\n", flow_type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void lan966x_oic_irq_handler_domain(struct irq_domain *d, u32 first_i=
rq)
+{
+	struct irq_chip_generic *gc =3D irq_get_domain_generic_chip(d, first_irq);
+	struct lan966x_oic_chip_regs *chip_regs =3D gc->private;
+	unsigned long ident;
+	unsigned int hwirq;
+
+	ident =3D irq_reg_readl(gc, chip_regs->reg_off_ident);
+	if (!ident)
+		return;
+
+	for_each_set_bit(hwirq, &ident, 32)
+		generic_handle_domain_irq(d, hwirq + first_irq);
+}
+
+static void lan966x_oic_irq_handler(struct irq_desc *desc)
+{
+	struct irq_domain *d =3D irq_desc_get_handler_data(desc);
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+	lan966x_oic_irq_handler_domain(d, 0);
+	lan966x_oic_irq_handler_domain(d, 32);
+	lan966x_oic_irq_handler_domain(d, 64);
+	chained_irq_exit(chip, desc);
+}
+
+static struct lan966x_oic_chip_regs lan966x_oic_chip_regs[3] =3D {
+	{
+		.reg_off_ena_set =3D LAN966X_OIC_INTR_ENA_SET,
+		.reg_off_ena_clr =3D LAN966X_OIC_INTR_ENA_CLR,
+		.reg_off_sticky  =3D LAN966X_OIC_INTR_STICKY,
+		.reg_off_ident   =3D LAN966X_OIC_DST_INTR_IDENT(0),
+		.reg_off_map     =3D LAN966X_OIC_DST_INTR_MAP(0),
+	}, {
+		.reg_off_ena_set =3D LAN966X_OIC_INTR_ENA_SET1,
+		.reg_off_ena_clr =3D LAN966X_OIC_INTR_ENA_CLR1,
+		.reg_off_sticky  =3D LAN966X_OIC_INTR_STICKY1,
+		.reg_off_ident   =3D LAN966X_OIC_DST_INTR_IDENT1(0),
+		.reg_off_map     =3D LAN966X_OIC_DST_INTR_MAP1(0),
+	}, {
+		.reg_off_ena_set =3D LAN966X_OIC_INTR_ENA_SET2,
+		.reg_off_ena_clr =3D LAN966X_OIC_INTR_ENA_CLR2,
+		.reg_off_sticky  =3D LAN966X_OIC_INTR_STICKY2,
+		.reg_off_ident   =3D LAN966X_OIC_DST_INTR_IDENT2(0),
+		.reg_off_map     =3D LAN966X_OIC_DST_INTR_MAP2(0),
+	}
+};
+
+static int lan966x_oic_chip_init(struct irq_chip_generic *gc)
+{
+	struct lan966x_oic_data *lan966x_oic =3D gc->domain->host_data;
+	struct lan966x_oic_chip_regs *chip_regs;
+
+	chip_regs =3D &lan966x_oic_chip_regs[gc->irq_base / 32];
+
+	gc->reg_base =3D lan966x_oic->regs;
+	gc->chip_types[0].regs.enable =3D chip_regs->reg_off_ena_set;
+	gc->chip_types[0].regs.disable =3D chip_regs->reg_off_ena_clr;
+	gc->chip_types[0].regs.ack =3D chip_regs->reg_off_sticky;
+	gc->chip_types[0].chip.irq_startup =3D lan966x_oic_irq_startup;
+	gc->chip_types[0].chip.irq_shutdown =3D lan966x_oic_irq_shutdown;
+	gc->chip_types[0].chip.irq_set_type =3D lan966x_oic_irq_set_type;
+	gc->chip_types[0].chip.irq_mask =3D irq_gc_mask_disable_reg;
+	gc->chip_types[0].chip.irq_unmask =3D irq_gc_unmask_enable_reg;
+	gc->chip_types[0].chip.irq_ack =3D irq_gc_ack_set_bit;
+	gc->private =3D chip_regs;
+
+	/* Disable all interrupts handled by this chip */
+	irq_reg_writel(gc, ~0U, chip_regs->reg_off_ena_clr);
+
+	return 0;
+}
+
+static void lan966x_oic_chip_exit(struct irq_chip_generic *gc)
+{
+	/* Disable and ack all interrupts handled by this chip */
+	irq_reg_writel(gc, ~0U, gc->chip_types[0].regs.disable);
+	irq_reg_writel(gc, ~0U, gc->chip_types[0].regs.ack);
+}
+
+static int lan966x_oic_domain_init(struct irq_domain *d)
+{
+	struct lan966x_oic_data *lan966x_oic =3D d->host_data;
+
+	irq_set_chained_handler_and_data(lan966x_oic->irq, lan966x_oic_irq_handler,=
 d);
+
+	return 0;
+}
+
+static void lan966x_oic_domain_exit(struct irq_domain *d)
+{
+	struct lan966x_oic_data *lan966x_oic =3D d->host_data;
+
+	irq_set_chained_handler_and_data(lan966x_oic->irq, NULL, NULL);
+}
+
+static int lan966x_oic_probe(struct platform_device *pdev)
+{
+	struct irq_domain_chip_generic_info dgc_info =3D {
+		.name		=3D "lan966x-oic",
+		.handler	=3D handle_level_irq,
+		.irqs_per_chip	=3D 32,
+		.num_ct		=3D 1,
+		.init		=3D lan966x_oic_chip_init,
+		.exit		=3D lan966x_oic_chip_exit,
+	};
+	struct irq_domain_info d_info =3D {
+		.fwnode		=3D of_node_to_fwnode(pdev->dev.of_node),
+		.domain_flags	=3D IRQ_DOMAIN_FLAG_DESTROY_GC,
+		.size		=3D LAN966X_OIC_NR_IRQ,
+		.hwirq_max	=3D LAN966X_OIC_NR_IRQ,
+		.ops		=3D &irq_generic_chip_ops,
+		.dgc_info	=3D &dgc_info,
+		.init		=3D lan966x_oic_domain_init,
+		.exit		=3D lan966x_oic_domain_exit,
+	};
+	struct lan966x_oic_data *lan966x_oic;
+	struct device *dev =3D &pdev->dev;
+	struct irq_domain *domain;
+
+	lan966x_oic =3D devm_kmalloc(dev, sizeof(*lan966x_oic), GFP_KERNEL);
+	if (!lan966x_oic)
+		return -ENOMEM;
+
+	lan966x_oic->regs =3D devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(lan966x_oic->regs))
+		return dev_err_probe(dev, PTR_ERR(lan966x_oic->regs),
+				     "failed to map resource\n");
+
+	lan966x_oic->irq =3D platform_get_irq(pdev, 0);
+	if (lan966x_oic->irq < 0)
+		return dev_err_probe(dev, lan966x_oic->irq, "failed to get the IRQ\n");
+
+	d_info.host_data =3D lan966x_oic;
+	domain =3D devm_irq_domain_instantiate(dev, &d_info);
+	if (IS_ERR(domain))
+		return dev_err_probe(dev, PTR_ERR(domain),
+				     "failed to instantiate the IRQ domain\n");
+	return 0;
+}
+
+static const struct of_device_id lan966x_oic_of_match[] =3D {
+	{ .compatible =3D "microchip,lan966x-oic" },
+	{} /* sentinel */
+};
+MODULE_DEVICE_TABLE(of, lan966x_oic_of_match);
+
+static struct platform_driver lan966x_oic_driver =3D {
+	.probe =3D lan966x_oic_probe,
+	.driver =3D {
+		.name =3D "lan966x-oic",
+		.of_match_table =3D lan966x_oic_of_match,
+	},
+};
+module_platform_driver(lan966x_oic_driver);
+
+MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
+MODULE_DESCRIPTION("Microchip LAN966x OIC driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpi=
o.c
index 9a1791908598..27e30ce41db3 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -608,5 +608,6 @@ IRQCHIP_MATCH("amlogic,meson-gpio-intc", meson_gpio_irq_o=
f_init)
 IRQCHIP_PLATFORM_DRIVER_END(meson_gpio_intc)
=20
 MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_DESCRIPTION("Meson GPIO Interrupt Multiplexer driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:meson-gpio-intc");
diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index d17d9c0e2880..08b0cc862adf 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -193,6 +193,7 @@ module_platform_driver(mvebu_pic_driver);
=20
 MODULE_AUTHOR("Yehuda Yitschak <yehuday@marvell.com>");
 MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com>");
+MODULE_DESCRIPTION("Marvell Armada 7K/8K PIC driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:mvebu_pic");
=20
diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesa=
s-rzg2l.c
index f6484bf15e0b..693ff285ca2c 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -37,6 +37,8 @@
 #define TSSEL_SHIFT(n)			(8 * (n))
 #define TSSEL_MASK			GENMASK(7, 0)
 #define IRQ_MASK			0x3
+#define IMSK				0x10010
+#define TMSK				0x10020
=20
 #define TSSR_OFFSET(n)			((n) % 4)
 #define TSSR_INDEX(n)			((n) / 4)
@@ -69,12 +71,14 @@ struct rzg2l_irqc_reg_cache {
 /**
  * struct rzg2l_irqc_priv - IRQ controller private data structure
  * @base:	Controller's base address
+ * @irqchip:	Pointer to struct irq_chip
  * @fwspec:	IRQ firmware specific data
  * @lock:	Lock to serialize access to hardware registers
  * @cache:	Registers cache for suspend/resume
  */
 static struct rzg2l_irqc_priv {
 	void __iomem			*base;
+	const struct irq_chip		*irqchip;
 	struct irq_fwspec		fwspec[IRQC_NUM_IRQ];
 	raw_spinlock_t			lock;
 	struct rzg2l_irqc_reg_cache	cache;
@@ -138,6 +142,111 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
 	irq_chip_eoi_parent(d);
 }
=20
+static void rzfive_irqc_mask_irq_interrupt(struct rzg2l_irqc_priv *priv,
+					   unsigned int hwirq)
+{
+	u32 bit =3D BIT(hwirq - IRQC_IRQ_START);
+
+	writel_relaxed(readl_relaxed(priv->base + IMSK) | bit, priv->base + IMSK);
+}
+
+static void rzfive_irqc_unmask_irq_interrupt(struct rzg2l_irqc_priv *priv,
+					     unsigned int hwirq)
+{
+	u32 bit =3D BIT(hwirq - IRQC_IRQ_START);
+
+	writel_relaxed(readl_relaxed(priv->base + IMSK) & ~bit, priv->base + IMSK);
+}
+
+static void rzfive_irqc_mask_tint_interrupt(struct rzg2l_irqc_priv *priv,
+					    unsigned int hwirq)
+{
+	u32 bit =3D BIT(hwirq - IRQC_TINT_START);
+
+	writel_relaxed(readl_relaxed(priv->base + TMSK) | bit, priv->base + TMSK);
+}
+
+static void rzfive_irqc_unmask_tint_interrupt(struct rzg2l_irqc_priv *priv,
+					      unsigned int hwirq)
+{
+	u32 bit =3D BIT(hwirq - IRQC_TINT_START);
+
+	writel_relaxed(readl_relaxed(priv->base + TMSK) & ~bit, priv->base + TMSK);
+}
+
+static void rzfive_irqc_mask(struct irq_data *d)
+{
+	struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
+	unsigned int hwirq =3D irqd_to_hwirq(d);
+
+	raw_spin_lock(&priv->lock);
+	if (hwirq >=3D IRQC_IRQ_START && hwirq <=3D IRQC_IRQ_COUNT)
+		rzfive_irqc_mask_irq_interrupt(priv, hwirq);
+	else if (hwirq >=3D IRQC_TINT_START && hwirq < IRQC_NUM_IRQ)
+		rzfive_irqc_mask_tint_interrupt(priv, hwirq);
+	raw_spin_unlock(&priv->lock);
+	irq_chip_mask_parent(d);
+}
+
+static void rzfive_irqc_unmask(struct irq_data *d)
+{
+	struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
+	unsigned int hwirq =3D irqd_to_hwirq(d);
+
+	raw_spin_lock(&priv->lock);
+	if (hwirq >=3D IRQC_IRQ_START && hwirq <=3D IRQC_IRQ_COUNT)
+		rzfive_irqc_unmask_irq_interrupt(priv, hwirq);
+	else if (hwirq >=3D IRQC_TINT_START && hwirq < IRQC_NUM_IRQ)
+		rzfive_irqc_unmask_tint_interrupt(priv, hwirq);
+	raw_spin_unlock(&priv->lock);
+	irq_chip_unmask_parent(d);
+}
+
+static void rzfive_tint_irq_endisable(struct irq_data *d, bool enable)
+{
+	struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
+	unsigned int hwirq =3D irqd_to_hwirq(d);
+
+	if (hwirq >=3D IRQC_TINT_START && hwirq < IRQC_NUM_IRQ) {
+		u32 offset =3D hwirq - IRQC_TINT_START;
+		u32 tssr_offset =3D TSSR_OFFSET(offset);
+		u8 tssr_index =3D TSSR_INDEX(offset);
+		u32 reg;
+
+		raw_spin_lock(&priv->lock);
+		if (enable)
+			rzfive_irqc_unmask_tint_interrupt(priv, hwirq);
+		else
+			rzfive_irqc_mask_tint_interrupt(priv, hwirq);
+		reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
+		if (enable)
+			reg |=3D TIEN << TSSEL_SHIFT(tssr_offset);
+		else
+			reg &=3D ~(TIEN << TSSEL_SHIFT(tssr_offset));
+		writel_relaxed(reg, priv->base + TSSR(tssr_index));
+		raw_spin_unlock(&priv->lock);
+	} else {
+		raw_spin_lock(&priv->lock);
+		if (enable)
+			rzfive_irqc_unmask_irq_interrupt(priv, hwirq);
+		else
+			rzfive_irqc_mask_irq_interrupt(priv, hwirq);
+		raw_spin_unlock(&priv->lock);
+	}
+}
+
+static void rzfive_irqc_irq_disable(struct irq_data *d)
+{
+	irq_chip_disable_parent(d);
+	rzfive_tint_irq_endisable(d, false);
+}
+
+static void rzfive_irqc_irq_enable(struct irq_data *d)
+{
+	rzfive_tint_irq_endisable(d, true);
+	irq_chip_enable_parent(d);
+}
+
 static void rzg2l_tint_irq_endisable(struct irq_data *d, bool enable)
 {
 	unsigned int hw_irq =3D irqd_to_hwirq(d);
@@ -162,8 +271,8 @@ static void rzg2l_tint_irq_endisable(struct irq_data *d, =
bool enable)
=20
 static void rzg2l_irqc_irq_disable(struct irq_data *d)
 {
-	rzg2l_tint_irq_endisable(d, false);
 	irq_chip_disable_parent(d);
+	rzg2l_tint_irq_endisable(d, false);
 }
=20
 static void rzg2l_irqc_irq_enable(struct irq_data *d)
@@ -321,7 +430,7 @@ static struct syscore_ops rzg2l_irqc_syscore_ops =3D {
 	.resume		=3D rzg2l_irqc_irq_resume,
 };
=20
-static const struct irq_chip irqc_chip =3D {
+static const struct irq_chip rzg2l_irqc_chip =3D {
 	.name			=3D "rzg2l-irqc",
 	.irq_eoi		=3D rzg2l_irqc_eoi,
 	.irq_mask		=3D irq_chip_mask_parent,
@@ -338,6 +447,23 @@ static const struct irq_chip irqc_chip =3D {
 				  IRQCHIP_SKIP_SET_WAKE,
 };
=20
+static const struct irq_chip rzfive_irqc_chip =3D {
+	.name			=3D "rzfive-irqc",
+	.irq_eoi		=3D rzg2l_irqc_eoi,
+	.irq_mask		=3D rzfive_irqc_mask,
+	.irq_unmask		=3D rzfive_irqc_unmask,
+	.irq_disable		=3D rzfive_irqc_irq_disable,
+	.irq_enable		=3D rzfive_irqc_irq_enable,
+	.irq_get_irqchip_state	=3D irq_chip_get_parent_state,
+	.irq_set_irqchip_state	=3D irq_chip_set_parent_state,
+	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
+	.irq_set_type		=3D rzg2l_irqc_set_type,
+	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
+	.flags			=3D IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE,
+};
+
 static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int virq,
 			    unsigned int nr_irqs, void *arg)
 {
@@ -369,7 +495,7 @@ static int rzg2l_irqc_alloc(struct irq_domain *domain, un=
signed int virq,
 	if (hwirq > (IRQC_NUM_IRQ - 1))
 		return -EINVAL;
=20
-	ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &irqc_chip,
+	ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq, priv->irqchip,
 					    (void *)(uintptr_t)tint);
 	if (ret)
 		return ret;
@@ -401,7 +527,8 @@ static int rzg2l_irqc_parse_interrupts(struct rzg2l_irqc_=
priv *priv,
 	return 0;
 }
=20
-static int rzg2l_irqc_init(struct device_node *node, struct device_node *par=
ent)
+static int rzg2l_irqc_common_init(struct device_node *node, struct device_no=
de *parent,
+				  const struct irq_chip *irq_chip)
 {
 	struct irq_domain *irq_domain, *parent_domain;
 	struct platform_device *pdev;
@@ -422,6 +549,8 @@ static int rzg2l_irqc_init(struct device_node *node, stru=
ct device_node *parent)
 	if (!rzg2l_irqc_data)
 		return -ENOMEM;
=20
+	rzg2l_irqc_data->irqchip =3D irq_chip;
+
 	rzg2l_irqc_data->base =3D devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, N=
ULL);
 	if (IS_ERR(rzg2l_irqc_data->base))
 		return PTR_ERR(rzg2l_irqc_data->base);
@@ -472,8 +601,21 @@ static int rzg2l_irqc_init(struct device_node *node, str=
uct device_node *parent)
 	return ret;
 }
=20
+static int __init rzg2l_irqc_init(struct device_node *node,
+				  struct device_node *parent)
+{
+	return rzg2l_irqc_common_init(node, parent, &rzg2l_irqc_chip);
+}
+
+static int __init rzfive_irqc_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	return rzg2l_irqc_common_init(node, parent, &rzfive_irqc_chip);
+}
+
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzg2l_irqc)
 IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
+IRQCHIP_MATCH("renesas,r9a07g043f-irqc", rzfive_irqc_init)
 IRQCHIP_PLATFORM_DRIVER_END(rzg2l_irqc)
 MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
 MODULE_DESCRIPTION("Renesas RZ/G2L IRQC Driver");
diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-ris=
cv-aplic-main.c
index 774a0c97fdab..28dd175b5764 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -127,6 +127,7 @@ static void aplic_init_hw_irqs(struct aplic_priv *priv)
=20
 int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void __iom=
em *regs)
 {
+	struct device_node *np =3D to_of_node(dev->fwnode);
 	struct of_phandle_args parent;
 	int rc;
=20
@@ -134,7 +135,7 @@ int aplic_setup_priv(struct aplic_priv *priv, struct devi=
ce *dev, void __iomem *
 	 * Currently, only OF fwnode is supported so extend this
 	 * function for ACPI support.
 	 */
-	if (!is_of_node(dev->fwnode))
+	if (!np)
 		return -EINVAL;
=20
 	/* Save device pointer and register base */
@@ -142,8 +143,7 @@ int aplic_setup_priv(struct aplic_priv *priv, struct devi=
ce *dev, void __iomem *
 	priv->regs =3D regs;
=20
 	/* Find out number of interrupt sources */
-	rc =3D of_property_read_u32(to_of_node(dev->fwnode), "riscv,num-sources",
-				  &priv->nr_irqs);
+	rc =3D of_property_read_u32(np, "riscv,num-sources", &priv->nr_irqs);
 	if (rc) {
 		dev_err(dev, "failed to get number of interrupt sources\n");
 		return rc;
@@ -155,8 +155,8 @@ int aplic_setup_priv(struct aplic_priv *priv, struct devi=
ce *dev, void __iomem *
 	 * If "msi-parent" property is present then we ignore the
 	 * APLIC IDCs which forces the APLIC driver to use MSI mode.
 	 */
-	if (!of_property_present(to_of_node(dev->fwnode), "msi-parent")) {
-		while (!of_irq_parse_one(to_of_node(dev->fwnode), priv->nr_idcs, &parent))
+	if (!of_property_present(np, "msi-parent")) {
+		while (!of_irq_parse_one(np, priv->nr_idcs, &parent))
 			priv->nr_idcs++;
 	}
=20
@@ -184,8 +184,7 @@ static int aplic_probe(struct platform_device *pdev)
 	 * If msi-parent property is present then setup APLIC MSI
 	 * mode otherwise setup APLIC direct mode.
 	 */
-	if (is_of_node(dev->fwnode))
-		msi_mode =3D of_property_present(to_of_node(dev->fwnode), "msi-parent");
+	msi_mode =3D of_property_present(to_of_node(dev->fwnode), "msi-parent");
 	if (msi_mode)
 		rc =3D aplic_msi_setup(dev, regs);
 	else
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-int=
c.c
index 9e71c4428814..983538a89e65 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -26,7 +26,7 @@ static unsigned int riscv_intc_nr_irqs __ro_after_init =3D =
BITS_PER_LONG;
 static unsigned int riscv_intc_custom_base __ro_after_init =3D BITS_PER_LONG;
 static unsigned int riscv_intc_custom_nr_irqs __ro_after_init;
=20
-static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
+static void riscv_intc_irq(struct pt_regs *regs)
 {
 	unsigned long cause =3D regs->cause & ~CAUSE_IRQ_FLAG;
=20
@@ -34,7 +34,7 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 		pr_warn_ratelimited("Failed to handle interrupt (cause: %ld)\n", cause);
 }
=20
-static asmlinkage void riscv_intc_aia_irq(struct pt_regs *regs)
+static void riscv_intc_aia_irq(struct pt_regs *regs)
 {
 	unsigned long topi;
=20
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-ext=
i.c
index 2cc9f3b7d669..7c6a0080c330 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -1,45 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) Maxime Coquelin 2015
- * Copyright (C) STMicroelectronics 2017
+ * Copyright (C) STMicroelectronics 2017-2024
  * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
  */
=20
 #include <linux/bitops.h>
-#include <linux/delay.h>
-#include <linux/hwspinlock.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
-#include <linux/mod_devicetable.h>
-#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/platform_device.h>
-#include <linux/pm.h>
-
-#include <dt-bindings/interrupt-controller/arm-gic.h>
=20
 #define IRQS_PER_BANK			32
=20
-#define HWSPNLCK_TIMEOUT		1000 /* usec */
-
-#define EXTI_EnCIDCFGR(n)		(0x180 + (n) * 4)
-#define EXTI_HWCFGR1			0x3f0
-
-/* Register: EXTI_EnCIDCFGR(n) */
-#define EXTI_CIDCFGR_CFEN_MASK		BIT(0)
-#define EXTI_CIDCFGR_CID_MASK		GENMASK(6, 4)
-#define EXTI_CIDCFGR_CID_SHIFT		4
-
-/* Register: EXTI_HWCFGR1 */
-#define EXTI_HWCFGR1_CIDWIDTH_MASK	GENMASK(27, 24)
-
-#define EXTI_CID1			1
-
 struct stm32_exti_bank {
 	u32 imr_ofst;
 	u32 emr_ofst;
@@ -47,13 +24,8 @@ struct stm32_exti_bank {
 	u32 ftsr_ofst;
 	u32 swier_ofst;
 	u32 rpr_ofst;
-	u32 fpr_ofst;
-	u32 trg_ofst;
-	u32 seccfgr_ofst;
 };
=20
-#define UNDEF_REG ~0
-
 struct stm32_exti_drv_data {
 	const struct stm32_exti_bank **exti_banks;
 	const u8 *desc_irqs;
@@ -63,7 +35,6 @@ struct stm32_exti_drv_data {
 struct stm32_exti_chip_data {
 	struct stm32_exti_host_data *host_data;
 	const struct stm32_exti_bank *reg_bank;
-	struct raw_spinlock rlock;
 	u32 wake_active;
 	u32 mask_cache;
 	u32 rtsr_cache;
@@ -76,8 +47,6 @@ struct stm32_exti_host_data {
 	struct device *dev;
 	struct stm32_exti_chip_data *chips_data;
 	const struct stm32_exti_drv_data *drv_data;
-	struct hwspinlock *hwlock;
-	bool dt_has_irqs_desc; /* skip internal desc_irqs array and get it from DT =
*/
 };
=20
 static const struct stm32_exti_bank stm32f4xx_exti_b1 =3D {
@@ -87,9 +56,6 @@ static const struct stm32_exti_bank stm32f4xx_exti_b1 =3D {
 	.ftsr_ofst	=3D 0x0C,
 	.swier_ofst	=3D 0x10,
 	.rpr_ofst	=3D 0x14,
-	.fpr_ofst	=3D UNDEF_REG,
-	.trg_ofst	=3D UNDEF_REG,
-	.seccfgr_ofst	=3D UNDEF_REG,
 };
=20
 static const struct stm32_exti_bank *stm32f4xx_exti_banks[] =3D {
@@ -108,9 +74,6 @@ static const struct stm32_exti_bank stm32h7xx_exti_b1 =3D {
 	.ftsr_ofst	=3D 0x04,
 	.swier_ofst	=3D 0x08,
 	.rpr_ofst	=3D 0x88,
-	.fpr_ofst	=3D UNDEF_REG,
-	.trg_ofst	=3D UNDEF_REG,
-	.seccfgr_ofst	=3D UNDEF_REG,
 };
=20
 static const struct stm32_exti_bank stm32h7xx_exti_b2 =3D {
@@ -120,9 +83,6 @@ static const struct stm32_exti_bank stm32h7xx_exti_b2 =3D {
 	.ftsr_ofst	=3D 0x24,
 	.swier_ofst	=3D 0x28,
 	.rpr_ofst	=3D 0x98,
-	.fpr_ofst	=3D UNDEF_REG,
-	.trg_ofst	=3D UNDEF_REG,
-	.seccfgr_ofst	=3D UNDEF_REG,
 };
=20
 static const struct stm32_exti_bank stm32h7xx_exti_b3 =3D {
@@ -132,9 +92,6 @@ static const struct stm32_exti_bank stm32h7xx_exti_b3 =3D {
 	.ftsr_ofst	=3D 0x44,
 	.swier_ofst	=3D 0x48,
 	.rpr_ofst	=3D 0xA8,
-	.fpr_ofst	=3D UNDEF_REG,
-	.trg_ofst	=3D UNDEF_REG,
-	.seccfgr_ofst	=3D UNDEF_REG,
 };
=20
 static const struct stm32_exti_bank *stm32h7xx_exti_banks[] =3D {
@@ -148,183 +105,12 @@ static const struct stm32_exti_drv_data stm32h7xx_drv_=
data =3D {
 	.bank_nr =3D ARRAY_SIZE(stm32h7xx_exti_banks),
 };
=20
-static const struct stm32_exti_bank stm32mp1_exti_b1 =3D {
-	.imr_ofst	=3D 0x80,
-	.emr_ofst	=3D UNDEF_REG,
-	.rtsr_ofst	=3D 0x00,
-	.ftsr_ofst	=3D 0x04,
-	.swier_ofst	=3D 0x08,
-	.rpr_ofst	=3D 0x0C,
-	.fpr_ofst	=3D 0x10,
-	.trg_ofst	=3D 0x3EC,
-	.seccfgr_ofst	=3D 0x14,
-};
-
-static const struct stm32_exti_bank stm32mp1_exti_b2 =3D {
-	.imr_ofst	=3D 0x90,
-	.emr_ofst	=3D UNDEF_REG,
-	.rtsr_ofst	=3D 0x20,
-	.ftsr_ofst	=3D 0x24,
-	.swier_ofst	=3D 0x28,
-	.rpr_ofst	=3D 0x2C,
-	.fpr_ofst	=3D 0x30,
-	.trg_ofst	=3D 0x3E8,
-	.seccfgr_ofst	=3D 0x34,
-};
-
-static const struct stm32_exti_bank stm32mp1_exti_b3 =3D {
-	.imr_ofst	=3D 0xA0,
-	.emr_ofst	=3D UNDEF_REG,
-	.rtsr_ofst	=3D 0x40,
-	.ftsr_ofst	=3D 0x44,
-	.swier_ofst	=3D 0x48,
-	.rpr_ofst	=3D 0x4C,
-	.fpr_ofst	=3D 0x50,
-	.trg_ofst	=3D 0x3E4,
-	.seccfgr_ofst	=3D 0x54,
-};
-
-static const struct stm32_exti_bank *stm32mp1_exti_banks[] =3D {
-	&stm32mp1_exti_b1,
-	&stm32mp1_exti_b2,
-	&stm32mp1_exti_b3,
-};
-
-static struct irq_chip stm32_exti_h_chip;
-static struct irq_chip stm32_exti_h_chip_direct;
-
-#define EXTI_INVALID_IRQ       U8_MAX
-#define STM32MP1_DESC_IRQ_SIZE (ARRAY_SIZE(stm32mp1_exti_banks) * IRQS_PER_B=
ANK)
-
-/*
- * Use some intentionally tricky logic here to initialize the whole array to
- * EXTI_INVALID_IRQ, but then override certain fields, requiring us to indic=
ate
- * that we "know" that there are overrides in this structure, and we'll need=
 to
- * disable that warning from W=3D1 builds.
- */
-__diag_push();
-__diag_ignore_all("-Woverride-init",
-		  "logic to initialize all and then override some is OK");
-
-static const u8 stm32mp1_desc_irq[] =3D {
-	/* default value */
-	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] =3D EXTI_INVALID_IRQ,
-
-	[0] =3D 6,
-	[1] =3D 7,
-	[2] =3D 8,
-	[3] =3D 9,
-	[4] =3D 10,
-	[5] =3D 23,
-	[6] =3D 64,
-	[7] =3D 65,
-	[8] =3D 66,
-	[9] =3D 67,
-	[10] =3D 40,
-	[11] =3D 42,
-	[12] =3D 76,
-	[13] =3D 77,
-	[14] =3D 121,
-	[15] =3D 127,
-	[16] =3D 1,
-	[19] =3D 3,
-	[21] =3D 31,
-	[22] =3D 33,
-	[23] =3D 72,
-	[24] =3D 95,
-	[25] =3D 107,
-	[26] =3D 37,
-	[27] =3D 38,
-	[28] =3D 39,
-	[29] =3D 71,
-	[30] =3D 52,
-	[31] =3D 53,
-	[32] =3D 82,
-	[33] =3D 83,
-	[46] =3D 151,
-	[47] =3D 93,
-	[48] =3D 138,
-	[50] =3D 139,
-	[52] =3D 140,
-	[53] =3D 141,
-	[54] =3D 135,
-	[61] =3D 100,
-	[65] =3D 144,
-	[68] =3D 143,
-	[70] =3D 62,
-	[73] =3D 129,
-};
-
-static const u8 stm32mp13_desc_irq[] =3D {
-	/* default value */
-	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] =3D EXTI_INVALID_IRQ,
-
-	[0] =3D 6,
-	[1] =3D 7,
-	[2] =3D 8,
-	[3] =3D 9,
-	[4] =3D 10,
-	[5] =3D 24,
-	[6] =3D 65,
-	[7] =3D 66,
-	[8] =3D 67,
-	[9] =3D 68,
-	[10] =3D 41,
-	[11] =3D 43,
-	[12] =3D 77,
-	[13] =3D 78,
-	[14] =3D 106,
-	[15] =3D 109,
-	[16] =3D 1,
-	[19] =3D 3,
-	[21] =3D 32,
-	[22] =3D 34,
-	[23] =3D 73,
-	[24] =3D 93,
-	[25] =3D 114,
-	[26] =3D 38,
-	[27] =3D 39,
-	[28] =3D 40,
-	[29] =3D 72,
-	[30] =3D 53,
-	[31] =3D 54,
-	[32] =3D 83,
-	[33] =3D 84,
-	[44] =3D 96,
-	[47] =3D 92,
-	[48] =3D 116,
-	[50] =3D 117,
-	[52] =3D 118,
-	[53] =3D 119,
-	[68] =3D 63,
-	[70] =3D 98,
-};
-
-__diag_pop();
-
-static const struct stm32_exti_drv_data stm32mp1_drv_data =3D {
-	.exti_banks =3D stm32mp1_exti_banks,
-	.bank_nr =3D ARRAY_SIZE(stm32mp1_exti_banks),
-	.desc_irqs =3D stm32mp1_desc_irq,
-};
-
-static const struct stm32_exti_drv_data stm32mp13_drv_data =3D {
-	.exti_banks =3D stm32mp1_exti_banks,
-	.bank_nr =3D ARRAY_SIZE(stm32mp1_exti_banks),
-	.desc_irqs =3D stm32mp13_desc_irq,
-};
-
 static unsigned long stm32_exti_pending(struct irq_chip_generic *gc)
 {
 	struct stm32_exti_chip_data *chip_data =3D gc->private;
 	const struct stm32_exti_bank *stm32_bank =3D chip_data->reg_bank;
-	unsigned long pending;
=20
-	pending =3D irq_reg_readl(gc, stm32_bank->rpr_ofst);
-	if (stm32_bank->fpr_ofst !=3D UNDEF_REG)
-		pending |=3D irq_reg_readl(gc, stm32_bank->fpr_ofst);
-
-	return pending;
+	return irq_reg_readl(gc, stm32_bank->rpr_ofst);
 }
=20
 static void stm32_irq_handler(struct irq_desc *desc)
@@ -380,33 +166,21 @@ static int stm32_irq_set_type(struct irq_data *d, unsig=
ned int type)
 	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
 	struct stm32_exti_chip_data *chip_data =3D gc->private;
 	const struct stm32_exti_bank *stm32_bank =3D chip_data->reg_bank;
-	struct hwspinlock *hwlock =3D chip_data->host_data->hwlock;
 	u32 rtsr, ftsr;
 	int err;
=20
 	irq_gc_lock(gc);
=20
-	if (hwlock) {
-		err =3D hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT);
-		if (err) {
-			pr_err("%s can't get hwspinlock (%d)\n", __func__, err);
-			goto unlock;
-		}
-	}
-
 	rtsr =3D irq_reg_readl(gc, stm32_bank->rtsr_ofst);
 	ftsr =3D irq_reg_readl(gc, stm32_bank->ftsr_ofst);
=20
 	err =3D stm32_exti_set_type(d, type, &rtsr, &ftsr);
 	if (err)
-		goto unspinlock;
+		goto unlock;
=20
 	irq_reg_writel(gc, rtsr, stm32_bank->rtsr_ofst);
 	irq_reg_writel(gc, ftsr, stm32_bank->ftsr_ofst);
=20
-unspinlock:
-	if (hwlock)
-		hwspin_unlock_in_atomic(hwlock);
 unlock:
 	irq_gc_unlock(gc);
=20
@@ -494,287 +268,10 @@ static void stm32_irq_ack(struct irq_data *d)
 	irq_gc_lock(gc);
=20
 	irq_reg_writel(gc, d->mask, stm32_bank->rpr_ofst);
-	if (stm32_bank->fpr_ofst !=3D UNDEF_REG)
-		irq_reg_writel(gc, d->mask, stm32_bank->fpr_ofst);
=20
 	irq_gc_unlock(gc);
 }
=20
-/* directly set the target bit without reading first. */
-static inline void stm32_exti_write_bit(struct irq_data *d, u32 reg)
-{
-	struct stm32_exti_chip_data *chip_data =3D irq_data_get_irq_chip_data(d);
-	void __iomem *base =3D chip_data->host_data->base;
-	u32 val =3D BIT(d->hwirq % IRQS_PER_BANK);
-
-	writel_relaxed(val, base + reg);
-}
-
-static inline u32 stm32_exti_set_bit(struct irq_data *d, u32 reg)
-{
-	struct stm32_exti_chip_data *chip_data =3D irq_data_get_irq_chip_data(d);
-	void __iomem *base =3D chip_data->host_data->base;
-	u32 val;
-
-	val =3D readl_relaxed(base + reg);
-	val |=3D BIT(d->hwirq % IRQS_PER_BANK);
-	writel_relaxed(val, base + reg);
-
-	return val;
-}
-
-static inline u32 stm32_exti_clr_bit(struct irq_data *d, u32 reg)
-{
-	struct stm32_exti_chip_data *chip_data =3D irq_data_get_irq_chip_data(d);
-	void __iomem *base =3D chip_data->host_data->base;
-	u32 val;
-
-	val =3D readl_relaxed(base + reg);
-	val &=3D ~BIT(d->hwirq % IRQS_PER_BANK);
-	writel_relaxed(val, base + reg);
-
-	return val;
-}
-
-static void stm32_exti_h_eoi(struct irq_data *d)
-{
-	struct stm32_exti_chip_data *chip_data =3D irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank =3D chip_data->reg_bank;
-
-	raw_spin_lock(&chip_data->rlock);
-
-	stm32_exti_write_bit(d, stm32_bank->rpr_ofst);
-	if (stm32_bank->fpr_ofst !=3D UNDEF_REG)
-		stm32_exti_write_bit(d, stm32_bank->fpr_ofst);
-
-	raw_spin_unlock(&chip_data->rlock);
-
-	if (d->parent_data->chip)
-		irq_chip_eoi_parent(d);
-}
-
-static void stm32_exti_h_mask(struct irq_data *d)
-{
-	struct stm32_exti_chip_data *chip_data =3D irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank =3D chip_data->reg_bank;
-
-	raw_spin_lock(&chip_data->rlock);
-	chip_data->mask_cache =3D stm32_exti_clr_bit(d, stm32_bank->imr_ofst);
-	raw_spin_unlock(&chip_data->rlock);
-
-	if (d->parent_data->chip)
-		irq_chip_mask_parent(d);
-}
-
-static void stm32_exti_h_unmask(struct irq_data *d)
-{
-	struct stm32_exti_chip_data *chip_data =3D irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank =3D chip_data->reg_bank;
-
-	raw_spin_lock(&chip_data->rlock);
-	chip_data->mask_cache =3D stm32_exti_set_bit(d, stm32_bank->imr_ofst);
-	raw_spin_unlock(&chip_data->rlock);
-
-	if (d->parent_data->chip)
-		irq_chip_unmask_parent(d);
-}
-
-static int stm32_exti_h_set_type(struct irq_data *d, unsigned int type)
-{
-	struct stm32_exti_chip_data *chip_data =3D irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank =3D chip_data->reg_bank;
-	struct hwspinlock *hwlock =3D chip_data->host_data->hwlock;
-	void __iomem *base =3D chip_data->host_data->base;
-	u32 rtsr, ftsr;
-	int err;
-
-	raw_spin_lock(&chip_data->rlock);
-
-	if (hwlock) {
-		err =3D hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT);
-		if (err) {
-			pr_err("%s can't get hwspinlock (%d)\n", __func__, err);
-			goto unlock;
-		}
-	}
-
-	rtsr =3D readl_relaxed(base + stm32_bank->rtsr_ofst);
-	ftsr =3D readl_relaxed(base + stm32_bank->ftsr_ofst);
-
-	err =3D stm32_exti_set_type(d, type, &rtsr, &ftsr);
-	if (err)
-		goto unspinlock;
-
-	writel_relaxed(rtsr, base + stm32_bank->rtsr_ofst);
-	writel_relaxed(ftsr, base + stm32_bank->ftsr_ofst);
-
-unspinlock:
-	if (hwlock)
-		hwspin_unlock_in_atomic(hwlock);
-unlock:
-	raw_spin_unlock(&chip_data->rlock);
-
-	return err;
-}
-
-static int stm32_exti_h_set_wake(struct irq_data *d, unsigned int on)
-{
-	struct stm32_exti_chip_data *chip_data =3D irq_data_get_irq_chip_data(d);
-	u32 mask =3D BIT(d->hwirq % IRQS_PER_BANK);
-
-	raw_spin_lock(&chip_data->rlock);
-
-	if (on)
-		chip_data->wake_active |=3D mask;
-	else
-		chip_data->wake_active &=3D ~mask;
-
-	raw_spin_unlock(&chip_data->rlock);
-
-	return 0;
-}
-
-static int stm32_exti_h_set_affinity(struct irq_data *d,
-				     const struct cpumask *dest, bool force)
-{
-	if (d->parent_data->chip)
-		return irq_chip_set_affinity_parent(d, dest, force);
-
-	return IRQ_SET_MASK_OK_DONE;
-}
-
-static int stm32_exti_h_suspend(struct device *dev)
-{
-	struct stm32_exti_host_data *host_data =3D dev_get_drvdata(dev);
-	struct stm32_exti_chip_data *chip_data;
-	int i;
-
-	for (i =3D 0; i < host_data->drv_data->bank_nr; i++) {
-		chip_data =3D &host_data->chips_data[i];
-		stm32_chip_suspend(chip_data, chip_data->wake_active);
-	}
-
-	return 0;
-}
-
-static int stm32_exti_h_resume(struct device *dev)
-{
-	struct stm32_exti_host_data *host_data =3D dev_get_drvdata(dev);
-	struct stm32_exti_chip_data *chip_data;
-	int i;
-
-	for (i =3D 0; i < host_data->drv_data->bank_nr; i++) {
-		chip_data =3D &host_data->chips_data[i];
-		stm32_chip_resume(chip_data, chip_data->mask_cache);
-	}
-
-	return 0;
-}
-
-static int stm32_exti_h_retrigger(struct irq_data *d)
-{
-	struct stm32_exti_chip_data *chip_data =3D irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank =3D chip_data->reg_bank;
-	void __iomem *base =3D chip_data->host_data->base;
-	u32 mask =3D BIT(d->hwirq % IRQS_PER_BANK);
-
-	writel_relaxed(mask, base + stm32_bank->swier_ofst);
-
-	return 0;
-}
-
-static struct irq_chip stm32_exti_h_chip =3D {
-	.name			=3D "stm32-exti-h",
-	.irq_eoi		=3D stm32_exti_h_eoi,
-	.irq_mask		=3D stm32_exti_h_mask,
-	.irq_unmask		=3D stm32_exti_h_unmask,
-	.irq_retrigger		=3D stm32_exti_h_retrigger,
-	.irq_set_type		=3D stm32_exti_h_set_type,
-	.irq_set_wake		=3D stm32_exti_h_set_wake,
-	.flags			=3D IRQCHIP_MASK_ON_SUSPEND,
-	.irq_set_affinity	=3D IS_ENABLED(CONFIG_SMP) ? stm32_exti_h_set_affinity : =
NULL,
-};
-
-static struct irq_chip stm32_exti_h_chip_direct =3D {
-	.name			=3D "stm32-exti-h-direct",
-	.irq_eoi		=3D irq_chip_eoi_parent,
-	.irq_ack		=3D irq_chip_ack_parent,
-	.irq_mask		=3D stm32_exti_h_mask,
-	.irq_unmask		=3D stm32_exti_h_unmask,
-	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
-	.irq_set_type		=3D irq_chip_set_type_parent,
-	.irq_set_wake		=3D stm32_exti_h_set_wake,
-	.flags			=3D IRQCHIP_MASK_ON_SUSPEND,
-	.irq_set_affinity	=3D IS_ENABLED(CONFIG_SMP) ? irq_chip_set_affinity_parent=
 : NULL,
-};
-
-static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
-				     unsigned int virq,
-				     unsigned int nr_irqs, void *data)
-{
-	struct stm32_exti_host_data *host_data =3D dm->host_data;
-	struct stm32_exti_chip_data *chip_data;
-	u8 desc_irq;
-	struct irq_fwspec *fwspec =3D data;
-	struct irq_fwspec p_fwspec;
-	irq_hw_number_t hwirq;
-	int bank;
-	u32 event_trg;
-	struct irq_chip *chip;
-
-	hwirq =3D fwspec->param[0];
-	if (hwirq >=3D host_data->drv_data->bank_nr * IRQS_PER_BANK)
-		return -EINVAL;
-
-	bank  =3D hwirq / IRQS_PER_BANK;
-	chip_data =3D &host_data->chips_data[bank];
-
-	/* Check if event is reserved (Secure) */
-	if (chip_data->event_reserved & BIT(hwirq % IRQS_PER_BANK)) {
-		dev_err(host_data->dev, "event %lu is reserved, secure\n", hwirq);
-		return -EPERM;
-	}
-
-	event_trg =3D readl_relaxed(host_data->base + chip_data->reg_bank->trg_ofst=
);
-	chip =3D (event_trg & BIT(hwirq % IRQS_PER_BANK)) ?
-	       &stm32_exti_h_chip : &stm32_exti_h_chip_direct;
-
-	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, chip, chip_data);
-
-	if (host_data->dt_has_irqs_desc) {
-		struct of_phandle_args out_irq;
-		int ret;
-
-		ret =3D of_irq_parse_one(host_data->dev->of_node, hwirq, &out_irq);
-		if (ret)
-			return ret;
-		/* we only support one parent, so far */
-		if (of_node_to_fwnode(out_irq.np) !=3D dm->parent->fwnode)
-			return -EINVAL;
-
-		of_phandle_args_to_fwspec(out_irq.np, out_irq.args,
-					  out_irq.args_count, &p_fwspec);
-
-		return irq_domain_alloc_irqs_parent(dm, virq, 1, &p_fwspec);
-	}
-
-	if (!host_data->drv_data->desc_irqs)
-		return -EINVAL;
-
-	desc_irq =3D host_data->drv_data->desc_irqs[hwirq];
-	if (desc_irq !=3D EXTI_INVALID_IRQ) {
-		p_fwspec.fwnode =3D dm->parent->fwnode;
-		p_fwspec.param_count =3D 3;
-		p_fwspec.param[0] =3D GIC_SPI;
-		p_fwspec.param[1] =3D desc_irq;
-		p_fwspec.param[2] =3D IRQ_TYPE_LEVEL_HIGH;
-
-		return irq_domain_alloc_irqs_parent(dm, virq, 1, &p_fwspec);
-	}
-
-	return 0;
-}
-
 static struct
 stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data =
*dd,
 					   struct device_node *node)
@@ -822,19 +319,12 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32=
_exti_host_data *h_data,
 	chip_data->host_data =3D h_data;
 	chip_data->reg_bank =3D stm32_bank;
=20
-	raw_spin_lock_init(&chip_data->rlock);
-
 	/*
 	 * This IP has no reset, so after hot reboot we should
 	 * clear registers to avoid residue
 	 */
 	writel_relaxed(0, base + stm32_bank->imr_ofst);
-	if (stm32_bank->emr_ofst !=3D UNDEF_REG)
-		writel_relaxed(0, base + stm32_bank->emr_ofst);
-
-	/* reserve Secure events */
-	if (stm32_bank->seccfgr_ofst !=3D UNDEF_REG)
-		chip_data->event_reserved =3D readl_relaxed(base + stm32_bank->seccfgr_ofs=
t);
+	writel_relaxed(0, base + stm32_bank->emr_ofst);
=20
 	pr_info("%pOF: bank%d\n", node, bank_idx);
=20
@@ -914,158 +404,6 @@ static int __init stm32_exti_init(const struct stm32_ex=
ti_drv_data *drv_data,
 	return ret;
 }
=20
-static const struct irq_domain_ops stm32_exti_h_domain_ops =3D {
-	.alloc	=3D stm32_exti_h_domain_alloc,
-	.free	=3D irq_domain_free_irqs_common,
-	.xlate =3D irq_domain_xlate_twocell,
-};
-
-static void stm32_exti_check_rif(struct stm32_exti_host_data *host_data)
-{
-	unsigned int bank, i, event;
-	u32 cid, cidcfgr, hwcfgr1;
-
-	/* quit on CID not supported */
-	hwcfgr1 =3D readl_relaxed(host_data->base + EXTI_HWCFGR1);
-	if ((hwcfgr1 & EXTI_HWCFGR1_CIDWIDTH_MASK) =3D=3D 0)
-		return;
-
-	for (bank =3D 0; bank < host_data->drv_data->bank_nr; bank++) {
-		for (i =3D 0; i < IRQS_PER_BANK; i++) {
-			event =3D bank * IRQS_PER_BANK + i;
-			cidcfgr =3D readl_relaxed(host_data->base + EXTI_EnCIDCFGR(event));
-			cid =3D (cidcfgr & EXTI_CIDCFGR_CID_MASK) >> EXTI_CIDCFGR_CID_SHIFT;
-			if ((cidcfgr & EXTI_CIDCFGR_CFEN_MASK) && cid !=3D EXTI_CID1)
-				host_data->chips_data[bank].event_reserved |=3D BIT(i);
-		}
-	}
-}
-
-static void stm32_exti_remove_irq(void *data)
-{
-	struct irq_domain *domain =3D data;
-
-	irq_domain_remove(domain);
-}
-
-static int stm32_exti_probe(struct platform_device *pdev)
-{
-	int ret, i;
-	struct device *dev =3D &pdev->dev;
-	struct device_node *np =3D dev->of_node;
-	struct irq_domain *parent_domain, *domain;
-	struct stm32_exti_host_data *host_data;
-	const struct stm32_exti_drv_data *drv_data;
-
-	host_data =3D devm_kzalloc(dev, sizeof(*host_data), GFP_KERNEL);
-	if (!host_data)
-		return -ENOMEM;
-
-	dev_set_drvdata(dev, host_data);
-	host_data->dev =3D dev;
-
-	/* check for optional hwspinlock which may be not available yet */
-	ret =3D of_hwspin_lock_get_id(np, 0);
-	if (ret =3D=3D -EPROBE_DEFER)
-		/* hwspinlock framework not yet ready */
-		return ret;
-
-	if (ret >=3D 0) {
-		host_data->hwlock =3D devm_hwspin_lock_request_specific(dev, ret);
-		if (!host_data->hwlock) {
-			dev_err(dev, "Failed to request hwspinlock\n");
-			return -EINVAL;
-		}
-	} else if (ret !=3D -ENOENT) {
-		/* note: ENOENT is a valid case (means 'no hwspinlock') */
-		dev_err(dev, "Failed to get hwspinlock\n");
-		return ret;
-	}
-
-	/* initialize host_data */
-	drv_data =3D of_device_get_match_data(dev);
-	if (!drv_data) {
-		dev_err(dev, "no of match data\n");
-		return -ENODEV;
-	}
-	host_data->drv_data =3D drv_data;
-
-	host_data->chips_data =3D devm_kcalloc(dev, drv_data->bank_nr,
-					     sizeof(*host_data->chips_data),
-					     GFP_KERNEL);
-	if (!host_data->chips_data)
-		return -ENOMEM;
-
-	host_data->base =3D devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(host_data->base))
-		return PTR_ERR(host_data->base);
-
-	for (i =3D 0; i < drv_data->bank_nr; i++)
-		stm32_exti_chip_init(host_data, i, np);
-
-	stm32_exti_check_rif(host_data);
-
-	parent_domain =3D irq_find_host(of_irq_find_parent(np));
-	if (!parent_domain) {
-		dev_err(dev, "GIC interrupt-parent not found\n");
-		return -EINVAL;
-	}
-
-	domain =3D irq_domain_add_hierarchy(parent_domain, 0,
-					  drv_data->bank_nr * IRQS_PER_BANK,
-					  np, &stm32_exti_h_domain_ops,
-					  host_data);
-
-	if (!domain) {
-		dev_err(dev, "Could not register exti domain\n");
-		return -ENOMEM;
-	}
-
-	ret =3D devm_add_action_or_reset(dev, stm32_exti_remove_irq, domain);
-	if (ret)
-		return ret;
-
-	if (of_property_read_bool(np, "interrupts-extended"))
-		host_data->dt_has_irqs_desc =3D true;
-
-	return 0;
-}
-
-/* platform driver only for MP1 */
-static const struct of_device_id stm32_exti_ids[] =3D {
-	{ .compatible =3D "st,stm32mp1-exti", .data =3D &stm32mp1_drv_data},
-	{ .compatible =3D "st,stm32mp13-exti", .data =3D &stm32mp13_drv_data},
-	{},
-};
-MODULE_DEVICE_TABLE(of, stm32_exti_ids);
-
-static const struct dev_pm_ops stm32_exti_dev_pm_ops =3D {
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_exti_h_suspend, stm32_exti_h_resume)
-};
-
-static struct platform_driver stm32_exti_driver =3D {
-	.probe		=3D stm32_exti_probe,
-	.driver		=3D {
-		.name		=3D "stm32_exti",
-		.of_match_table	=3D stm32_exti_ids,
-		.pm		=3D &stm32_exti_dev_pm_ops,
-	},
-};
-
-static int __init stm32_exti_arch_init(void)
-{
-	return platform_driver_register(&stm32_exti_driver);
-}
-
-static void __exit stm32_exti_arch_exit(void)
-{
-	return platform_driver_unregister(&stm32_exti_driver);
-}
-
-arch_initcall(stm32_exti_arch_init);
-module_exit(stm32_exti_arch_exit);
-
-/* no platform driver for F4 and H7 */
 static int __init stm32f4_exti_of_init(struct device_node *np,
 				       struct device_node *parent)
 {
diff --git a/drivers/irqchip/irq-stm32mp-exti.c b/drivers/irqchip/irq-stm32mp=
-exti.c
new file mode 100644
index 000000000000..33e0cfdea654
--- /dev/null
+++ b/drivers/irqchip/irq-stm32mp-exti.c
@@ -0,0 +1,729 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Maxime Coquelin 2015
+ * Copyright (C) STMicroelectronics 2017-2024
+ * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/hwspinlock.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#define IRQS_PER_BANK			32
+
+#define HWSPNLCK_TIMEOUT		1000 /* usec */
+
+#define EXTI_EnCIDCFGR(n)		(0x180 + (n) * 4)
+#define EXTI_HWCFGR1			0x3f0
+
+/* Register: EXTI_EnCIDCFGR(n) */
+#define EXTI_CIDCFGR_CFEN_MASK		BIT(0)
+#define EXTI_CIDCFGR_CID_MASK		GENMASK(6, 4)
+#define EXTI_CIDCFGR_CID_SHIFT		4
+
+/* Register: EXTI_HWCFGR1 */
+#define EXTI_HWCFGR1_CIDWIDTH_MASK	GENMASK(27, 24)
+
+#define EXTI_CID1			1
+
+struct stm32mp_exti_bank {
+	u32 imr_ofst;
+	u32 rtsr_ofst;
+	u32 ftsr_ofst;
+	u32 swier_ofst;
+	u32 rpr_ofst;
+	u32 fpr_ofst;
+	u32 trg_ofst;
+	u32 seccfgr_ofst;
+};
+
+struct stm32mp_exti_drv_data {
+	const struct stm32mp_exti_bank	**exti_banks;
+	const u8			*desc_irqs;
+	u32				bank_nr;
+};
+
+struct stm32mp_exti_chip_data {
+	struct stm32mp_exti_host_data	*host_data;
+	const struct stm32mp_exti_bank	*reg_bank;
+	struct raw_spinlock		rlock;
+	u32				wake_active;
+	u32				mask_cache;
+	u32				rtsr_cache;
+	u32				ftsr_cache;
+	u32				event_reserved;
+};
+
+struct stm32mp_exti_host_data {
+	void __iomem				*base;
+	struct device				*dev;
+	struct stm32mp_exti_chip_data		*chips_data;
+	const struct stm32mp_exti_drv_data	*drv_data;
+	struct hwspinlock			*hwlock;
+	/* skip internal desc_irqs array and get it from DT */
+	bool dt_has_irqs_desc;
+};
+
+static const struct stm32mp_exti_bank stm32mp_exti_b1 =3D {
+	.imr_ofst	=3D 0x80,
+	.rtsr_ofst	=3D 0x00,
+	.ftsr_ofst	=3D 0x04,
+	.swier_ofst	=3D 0x08,
+	.rpr_ofst	=3D 0x0C,
+	.fpr_ofst	=3D 0x10,
+	.trg_ofst	=3D 0x3EC,
+	.seccfgr_ofst	=3D 0x14,
+};
+
+static const struct stm32mp_exti_bank stm32mp_exti_b2 =3D {
+	.imr_ofst	=3D 0x90,
+	.rtsr_ofst	=3D 0x20,
+	.ftsr_ofst	=3D 0x24,
+	.swier_ofst	=3D 0x28,
+	.rpr_ofst	=3D 0x2C,
+	.fpr_ofst	=3D 0x30,
+	.trg_ofst	=3D 0x3E8,
+	.seccfgr_ofst	=3D 0x34,
+};
+
+static const struct stm32mp_exti_bank stm32mp_exti_b3 =3D {
+	.imr_ofst	=3D 0xA0,
+	.rtsr_ofst	=3D 0x40,
+	.ftsr_ofst	=3D 0x44,
+	.swier_ofst	=3D 0x48,
+	.rpr_ofst	=3D 0x4C,
+	.fpr_ofst	=3D 0x50,
+	.trg_ofst	=3D 0x3E4,
+	.seccfgr_ofst	=3D 0x54,
+};
+
+static const struct stm32mp_exti_bank *stm32mp_exti_banks[] =3D {
+	&stm32mp_exti_b1,
+	&stm32mp_exti_b2,
+	&stm32mp_exti_b3,
+};
+
+static struct irq_chip stm32mp_exti_chip;
+static struct irq_chip stm32mp_exti_chip_direct;
+
+#define EXTI_INVALID_IRQ       U8_MAX
+#define STM32MP_DESC_IRQ_SIZE  (ARRAY_SIZE(stm32mp_exti_banks) * IRQS_PER_BA=
NK)
+
+/*
+ * Use some intentionally tricky logic here to initialize the whole array to
+ * EXTI_INVALID_IRQ, but then override certain fields, requiring us to indic=
ate
+ * that we "know" that there are overrides in this structure, and we'll need=
 to
+ * disable that warning from W=3D1 builds.
+ */
+__diag_push();
+__diag_ignore_all("-Woverride-init",
+		  "logic to initialize all and then override some is OK");
+
+static const u8 stm32mp1_desc_irq[] =3D {
+	/* default value */
+	[0 ... (STM32MP_DESC_IRQ_SIZE - 1)] =3D EXTI_INVALID_IRQ,
+
+	[0] =3D 6,
+	[1] =3D 7,
+	[2] =3D 8,
+	[3] =3D 9,
+	[4] =3D 10,
+	[5] =3D 23,
+	[6] =3D 64,
+	[7] =3D 65,
+	[8] =3D 66,
+	[9] =3D 67,
+	[10] =3D 40,
+	[11] =3D 42,
+	[12] =3D 76,
+	[13] =3D 77,
+	[14] =3D 121,
+	[15] =3D 127,
+	[16] =3D 1,
+	[19] =3D 3,
+	[21] =3D 31,
+	[22] =3D 33,
+	[23] =3D 72,
+	[24] =3D 95,
+	[25] =3D 107,
+	[26] =3D 37,
+	[27] =3D 38,
+	[28] =3D 39,
+	[29] =3D 71,
+	[30] =3D 52,
+	[31] =3D 53,
+	[32] =3D 82,
+	[33] =3D 83,
+	[46] =3D 151,
+	[47] =3D 93,
+	[48] =3D 138,
+	[50] =3D 139,
+	[52] =3D 140,
+	[53] =3D 141,
+	[54] =3D 135,
+	[61] =3D 100,
+	[65] =3D 144,
+	[68] =3D 143,
+	[70] =3D 62,
+	[73] =3D 129,
+};
+
+static const u8 stm32mp13_desc_irq[] =3D {
+	/* default value */
+	[0 ... (STM32MP_DESC_IRQ_SIZE - 1)] =3D EXTI_INVALID_IRQ,
+
+	[0] =3D 6,
+	[1] =3D 7,
+	[2] =3D 8,
+	[3] =3D 9,
+	[4] =3D 10,
+	[5] =3D 24,
+	[6] =3D 65,
+	[7] =3D 66,
+	[8] =3D 67,
+	[9] =3D 68,
+	[10] =3D 41,
+	[11] =3D 43,
+	[12] =3D 77,
+	[13] =3D 78,
+	[14] =3D 106,
+	[15] =3D 109,
+	[16] =3D 1,
+	[19] =3D 3,
+	[21] =3D 32,
+	[22] =3D 34,
+	[23] =3D 73,
+	[24] =3D 93,
+	[25] =3D 114,
+	[26] =3D 38,
+	[27] =3D 39,
+	[28] =3D 40,
+	[29] =3D 72,
+	[30] =3D 53,
+	[31] =3D 54,
+	[32] =3D 83,
+	[33] =3D 84,
+	[44] =3D 96,
+	[47] =3D 92,
+	[48] =3D 116,
+	[50] =3D 117,
+	[52] =3D 118,
+	[53] =3D 119,
+	[68] =3D 63,
+	[70] =3D 98,
+};
+
+__diag_pop();
+
+static const struct stm32mp_exti_drv_data stm32mp1_drv_data =3D {
+	.exti_banks =3D stm32mp_exti_banks,
+	.bank_nr =3D ARRAY_SIZE(stm32mp_exti_banks),
+	.desc_irqs =3D stm32mp1_desc_irq,
+};
+
+static const struct stm32mp_exti_drv_data stm32mp13_drv_data =3D {
+	.exti_banks =3D stm32mp_exti_banks,
+	.bank_nr =3D ARRAY_SIZE(stm32mp_exti_banks),
+	.desc_irqs =3D stm32mp13_desc_irq,
+};
+
+static int stm32mp_exti_convert_type(struct irq_data *d, unsigned int type, =
u32 *rtsr, u32 *ftsr)
+{
+	u32 mask =3D BIT(d->hwirq % IRQS_PER_BANK);
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		*rtsr |=3D mask;
+		*ftsr &=3D ~mask;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		*rtsr &=3D ~mask;
+		*ftsr |=3D mask;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		*rtsr |=3D mask;
+		*ftsr |=3D mask;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void stm32mp_chip_suspend(struct stm32mp_exti_chip_data *chip_data, u=
32 wake_active)
+{
+	const struct stm32mp_exti_bank *bank =3D chip_data->reg_bank;
+	void __iomem *base =3D chip_data->host_data->base;
+
+	/* save rtsr, ftsr registers */
+	chip_data->rtsr_cache =3D readl_relaxed(base + bank->rtsr_ofst);
+	chip_data->ftsr_cache =3D readl_relaxed(base + bank->ftsr_ofst);
+
+	writel_relaxed(wake_active, base + bank->imr_ofst);
+}
+
+static void stm32mp_chip_resume(struct stm32mp_exti_chip_data *chip_data, u3=
2 mask_cache)
+{
+	const struct stm32mp_exti_bank *bank =3D chip_data->reg_bank;
+	void __iomem *base =3D chip_data->host_data->base;
+
+	/* restore rtsr, ftsr, registers */
+	writel_relaxed(chip_data->rtsr_cache, base + bank->rtsr_ofst);
+	writel_relaxed(chip_data->ftsr_cache, base + bank->ftsr_ofst);
+
+	writel_relaxed(mask_cache, base + bank->imr_ofst);
+}
+
+/* directly set the target bit without reading first. */
+static inline void stm32mp_exti_write_bit(struct irq_data *d, u32 reg)
+{
+	struct stm32mp_exti_chip_data *chip_data =3D irq_data_get_irq_chip_data(d);
+	void __iomem *base =3D chip_data->host_data->base;
+	u32 val =3D BIT(d->hwirq % IRQS_PER_BANK);
+
+	writel_relaxed(val, base + reg);
+}
+
+static inline u32 stm32mp_exti_set_bit(struct irq_data *d, u32 reg)
+{
+	struct stm32mp_exti_chip_data *chip_data =3D irq_data_get_irq_chip_data(d);
+	void __iomem *base =3D chip_data->host_data->base;
+	u32 val;
+
+	val =3D readl_relaxed(base + reg);
+	val |=3D BIT(d->hwirq % IRQS_PER_BANK);
+	writel_relaxed(val, base + reg);
+
+	return val;
+}
+
+static inline u32 stm32mp_exti_clr_bit(struct irq_data *d, u32 reg)
+{
+	struct stm32mp_exti_chip_data *chip_data =3D irq_data_get_irq_chip_data(d);
+	void __iomem *base =3D chip_data->host_data->base;
+	u32 val;
+
+	val =3D readl_relaxed(base + reg);
+	val &=3D ~BIT(d->hwirq % IRQS_PER_BANK);
+	writel_relaxed(val, base + reg);
+
+	return val;
+}
+
+static void stm32mp_exti_eoi(struct irq_data *d)
+{
+	struct stm32mp_exti_chip_data *chip_data =3D irq_data_get_irq_chip_data(d);
+	const struct stm32mp_exti_bank *bank =3D chip_data->reg_bank;
+
+	raw_spin_lock(&chip_data->rlock);
+
+	stm32mp_exti_write_bit(d, bank->rpr_ofst);
+	stm32mp_exti_write_bit(d, bank->fpr_ofst);
+
+	raw_spin_unlock(&chip_data->rlock);
+
+	if (d->parent_data->chip)
+		irq_chip_eoi_parent(d);
+}
+
+static void stm32mp_exti_mask(struct irq_data *d)
+{
+	struct stm32mp_exti_chip_data *chip_data =3D irq_data_get_irq_chip_data(d);
+	const struct stm32mp_exti_bank *bank =3D chip_data->reg_bank;
+
+	raw_spin_lock(&chip_data->rlock);
+	chip_data->mask_cache =3D stm32mp_exti_clr_bit(d, bank->imr_ofst);
+	raw_spin_unlock(&chip_data->rlock);
+
+	if (d->parent_data->chip)
+		irq_chip_mask_parent(d);
+}
+
+static void stm32mp_exti_unmask(struct irq_data *d)
+{
+	struct stm32mp_exti_chip_data *chip_data =3D irq_data_get_irq_chip_data(d);
+	const struct stm32mp_exti_bank *bank =3D chip_data->reg_bank;
+
+	raw_spin_lock(&chip_data->rlock);
+	chip_data->mask_cache =3D stm32mp_exti_set_bit(d, bank->imr_ofst);
+	raw_spin_unlock(&chip_data->rlock);
+
+	if (d->parent_data->chip)
+		irq_chip_unmask_parent(d);
+}
+
+static int stm32mp_exti_set_type(struct irq_data *d, unsigned int type)
+{
+	struct stm32mp_exti_chip_data *chip_data =3D irq_data_get_irq_chip_data(d);
+	const struct stm32mp_exti_bank *bank =3D chip_data->reg_bank;
+	struct hwspinlock *hwlock =3D chip_data->host_data->hwlock;
+	void __iomem *base =3D chip_data->host_data->base;
+	u32 rtsr, ftsr;
+	int err;
+
+	raw_spin_lock(&chip_data->rlock);
+
+	if (hwlock) {
+		err =3D hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT);
+		if (err) {
+			pr_err("%s can't get hwspinlock (%d)\n", __func__, err);
+			goto unlock;
+		}
+	}
+
+	rtsr =3D readl_relaxed(base + bank->rtsr_ofst);
+	ftsr =3D readl_relaxed(base + bank->ftsr_ofst);
+
+	err =3D stm32mp_exti_convert_type(d, type, &rtsr, &ftsr);
+	if (!err) {
+		writel_relaxed(rtsr, base + bank->rtsr_ofst);
+		writel_relaxed(ftsr, base + bank->ftsr_ofst);
+	}
+
+	if (hwlock)
+		hwspin_unlock_in_atomic(hwlock);
+unlock:
+	raw_spin_unlock(&chip_data->rlock);
+	return err;
+}
+
+static int stm32mp_exti_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct stm32mp_exti_chip_data *chip_data =3D irq_data_get_irq_chip_data(d);
+	u32 mask =3D BIT(d->hwirq % IRQS_PER_BANK);
+
+	raw_spin_lock(&chip_data->rlock);
+
+	if (on)
+		chip_data->wake_active |=3D mask;
+	else
+		chip_data->wake_active &=3D ~mask;
+
+	raw_spin_unlock(&chip_data->rlock);
+
+	return 0;
+}
+
+static int stm32mp_exti_set_affinity(struct irq_data *d, const struct cpumas=
k *dest, bool force)
+{
+	if (d->parent_data->chip)
+		return irq_chip_set_affinity_parent(d, dest, force);
+
+	return IRQ_SET_MASK_OK_DONE;
+}
+
+static int stm32mp_exti_suspend(struct device *dev)
+{
+	struct stm32mp_exti_host_data *host_data =3D dev_get_drvdata(dev);
+	struct stm32mp_exti_chip_data *chip_data;
+	int i;
+
+	for (i =3D 0; i < host_data->drv_data->bank_nr; i++) {
+		chip_data =3D &host_data->chips_data[i];
+		stm32mp_chip_suspend(chip_data, chip_data->wake_active);
+	}
+
+	return 0;
+}
+
+static int stm32mp_exti_resume(struct device *dev)
+{
+	struct stm32mp_exti_host_data *host_data =3D dev_get_drvdata(dev);
+	struct stm32mp_exti_chip_data *chip_data;
+	int i;
+
+	for (i =3D 0; i < host_data->drv_data->bank_nr; i++) {
+		chip_data =3D &host_data->chips_data[i];
+		stm32mp_chip_resume(chip_data, chip_data->mask_cache);
+	}
+
+	return 0;
+}
+
+static int stm32mp_exti_retrigger(struct irq_data *d)
+{
+	struct stm32mp_exti_chip_data *chip_data =3D irq_data_get_irq_chip_data(d);
+	const struct stm32mp_exti_bank *bank =3D chip_data->reg_bank;
+	void __iomem *base =3D chip_data->host_data->base;
+	u32 mask =3D BIT(d->hwirq % IRQS_PER_BANK);
+
+	writel_relaxed(mask, base + bank->swier_ofst);
+
+	return 0;
+}
+
+static struct irq_chip stm32mp_exti_chip =3D {
+	.name			=3D "stm32mp-exti",
+	.irq_eoi		=3D stm32mp_exti_eoi,
+	.irq_mask		=3D stm32mp_exti_mask,
+	.irq_unmask		=3D stm32mp_exti_unmask,
+	.irq_retrigger		=3D stm32mp_exti_retrigger,
+	.irq_set_type		=3D stm32mp_exti_set_type,
+	.irq_set_wake		=3D stm32mp_exti_set_wake,
+	.flags			=3D IRQCHIP_MASK_ON_SUSPEND,
+	.irq_set_affinity	=3D IS_ENABLED(CONFIG_SMP) ? stm32mp_exti_set_affinity : =
NULL,
+};
+
+static struct irq_chip stm32mp_exti_chip_direct =3D {
+	.name			=3D "stm32mp-exti-direct",
+	.irq_eoi		=3D irq_chip_eoi_parent,
+	.irq_ack		=3D irq_chip_ack_parent,
+	.irq_mask		=3D stm32mp_exti_mask,
+	.irq_unmask		=3D stm32mp_exti_unmask,
+	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
+	.irq_set_type		=3D irq_chip_set_type_parent,
+	.irq_set_wake		=3D stm32mp_exti_set_wake,
+	.flags			=3D IRQCHIP_MASK_ON_SUSPEND,
+	.irq_set_affinity	=3D IS_ENABLED(CONFIG_SMP) ? irq_chip_set_affinity_parent=
 : NULL,
+};
+
+static int stm32mp_exti_domain_alloc(struct irq_domain *dm,
+				     unsigned int virq,
+				     unsigned int nr_irqs, void *data)
+{
+	struct stm32mp_exti_host_data *host_data =3D dm->host_data;
+	struct stm32mp_exti_chip_data *chip_data;
+	struct irq_fwspec *fwspec =3D data;
+	struct irq_fwspec p_fwspec;
+	irq_hw_number_t hwirq;
+	struct irq_chip *chip;
+	u32 event_trg;
+	u8 desc_irq;
+	int bank;
+
+	hwirq =3D fwspec->param[0];
+	if (hwirq >=3D host_data->drv_data->bank_nr * IRQS_PER_BANK)
+		return -EINVAL;
+
+	bank  =3D hwirq / IRQS_PER_BANK;
+	chip_data =3D &host_data->chips_data[bank];
+
+	/* Check if event is reserved (Secure) */
+	if (chip_data->event_reserved & BIT(hwirq % IRQS_PER_BANK)) {
+		dev_err(host_data->dev, "event %lu is reserved, secure\n", hwirq);
+		return -EPERM;
+	}
+
+	event_trg =3D readl_relaxed(host_data->base + chip_data->reg_bank->trg_ofst=
);
+	chip =3D (event_trg & BIT(hwirq % IRQS_PER_BANK)) ?
+	       &stm32mp_exti_chip : &stm32mp_exti_chip_direct;
+
+	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, chip, chip_data);
+
+	if (host_data->dt_has_irqs_desc) {
+		struct of_phandle_args out_irq;
+		int ret;
+
+		ret =3D of_irq_parse_one(host_data->dev->of_node, hwirq, &out_irq);
+		if (ret)
+			return ret;
+		/* we only support one parent, so far */
+		if (of_node_to_fwnode(out_irq.np) !=3D dm->parent->fwnode)
+			return -EINVAL;
+
+		of_phandle_args_to_fwspec(out_irq.np, out_irq.args,
+					  out_irq.args_count, &p_fwspec);
+
+		return irq_domain_alloc_irqs_parent(dm, virq, 1, &p_fwspec);
+	}
+
+	if (!host_data->drv_data->desc_irqs)
+		return -EINVAL;
+
+	desc_irq =3D host_data->drv_data->desc_irqs[hwirq];
+	if (desc_irq !=3D EXTI_INVALID_IRQ) {
+		p_fwspec.fwnode =3D dm->parent->fwnode;
+		p_fwspec.param_count =3D 3;
+		p_fwspec.param[0] =3D GIC_SPI;
+		p_fwspec.param[1] =3D desc_irq;
+		p_fwspec.param[2] =3D IRQ_TYPE_LEVEL_HIGH;
+
+		return irq_domain_alloc_irqs_parent(dm, virq, 1, &p_fwspec);
+	}
+
+	return 0;
+}
+
+static struct stm32mp_exti_chip_data *stm32mp_exti_chip_init(struct stm32mp_=
exti_host_data *h_data,
+							     u32 bank_idx, struct device_node *node)
+{
+	struct stm32mp_exti_chip_data *chip_data;
+	const struct stm32mp_exti_bank *bank;
+	void __iomem *base =3D h_data->base;
+
+	bank =3D h_data->drv_data->exti_banks[bank_idx];
+	chip_data =3D &h_data->chips_data[bank_idx];
+	chip_data->host_data =3D h_data;
+	chip_data->reg_bank =3D bank;
+
+	raw_spin_lock_init(&chip_data->rlock);
+
+	/*
+	 * This IP has no reset, so after hot reboot we should
+	 * clear registers to avoid residue
+	 */
+	writel_relaxed(0, base + bank->imr_ofst);
+
+	/* reserve Secure events */
+	chip_data->event_reserved =3D readl_relaxed(base + bank->seccfgr_ofst);
+
+	pr_info("%pOF: bank%d\n", node, bank_idx);
+
+	return chip_data;
+}
+
+static const struct irq_domain_ops stm32mp_exti_domain_ops =3D {
+	.alloc	=3D stm32mp_exti_domain_alloc,
+	.free	=3D irq_domain_free_irqs_common,
+	.xlate =3D irq_domain_xlate_twocell,
+};
+
+static void stm32mp_exti_check_rif(struct stm32mp_exti_host_data *host_data)
+{
+	unsigned int bank, i, event;
+	u32 cid, cidcfgr, hwcfgr1;
+
+	/* quit on CID not supported */
+	hwcfgr1 =3D readl_relaxed(host_data->base + EXTI_HWCFGR1);
+	if ((hwcfgr1 & EXTI_HWCFGR1_CIDWIDTH_MASK) =3D=3D 0)
+		return;
+
+	for (bank =3D 0; bank < host_data->drv_data->bank_nr; bank++) {
+		for (i =3D 0; i < IRQS_PER_BANK; i++) {
+			event =3D bank * IRQS_PER_BANK + i;
+			cidcfgr =3D readl_relaxed(host_data->base + EXTI_EnCIDCFGR(event));
+			cid =3D (cidcfgr & EXTI_CIDCFGR_CID_MASK) >> EXTI_CIDCFGR_CID_SHIFT;
+			if ((cidcfgr & EXTI_CIDCFGR_CFEN_MASK) && cid !=3D EXTI_CID1)
+				host_data->chips_data[bank].event_reserved |=3D BIT(i);
+		}
+	}
+}
+
+static void stm32mp_exti_remove_irq(void *data)
+{
+	struct irq_domain *domain =3D data;
+
+	irq_domain_remove(domain);
+}
+
+static int stm32mp_exti_probe(struct platform_device *pdev)
+{
+	const struct stm32mp_exti_drv_data *drv_data;
+	struct irq_domain *parent_domain, *domain;
+	struct stm32mp_exti_host_data *host_data;
+	struct device *dev =3D &pdev->dev;
+	struct device_node *np =3D dev->of_node;
+	int ret, i;
+
+	host_data =3D devm_kzalloc(dev, sizeof(*host_data), GFP_KERNEL);
+	if (!host_data)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, host_data);
+	host_data->dev =3D dev;
+
+	/* check for optional hwspinlock which may be not available yet */
+	ret =3D of_hwspin_lock_get_id(np, 0);
+	if (ret =3D=3D -EPROBE_DEFER)
+		/* hwspinlock framework not yet ready */
+		return ret;
+
+	if (ret >=3D 0) {
+		host_data->hwlock =3D devm_hwspin_lock_request_specific(dev, ret);
+		if (!host_data->hwlock) {
+			dev_err(dev, "Failed to request hwspinlock\n");
+			return -EINVAL;
+		}
+	} else if (ret !=3D -ENOENT) {
+		/* note: ENOENT is a valid case (means 'no hwspinlock') */
+		dev_err(dev, "Failed to get hwspinlock\n");
+		return ret;
+	}
+
+	/* initialize host_data */
+	drv_data =3D of_device_get_match_data(dev);
+	if (!drv_data) {
+		dev_err(dev, "no of match data\n");
+		return -ENODEV;
+	}
+	host_data->drv_data =3D drv_data;
+
+	host_data->chips_data =3D devm_kcalloc(dev, drv_data->bank_nr,
+					     sizeof(*host_data->chips_data),
+					     GFP_KERNEL);
+	if (!host_data->chips_data)
+		return -ENOMEM;
+
+	host_data->base =3D devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(host_data->base))
+		return PTR_ERR(host_data->base);
+
+	for (i =3D 0; i < drv_data->bank_nr; i++)
+		stm32mp_exti_chip_init(host_data, i, np);
+
+	stm32mp_exti_check_rif(host_data);
+
+	parent_domain =3D irq_find_host(of_irq_find_parent(np));
+	if (!parent_domain) {
+		dev_err(dev, "GIC interrupt-parent not found\n");
+		return -EINVAL;
+	}
+
+	domain =3D irq_domain_add_hierarchy(parent_domain, 0,
+					  drv_data->bank_nr * IRQS_PER_BANK,
+					  np, &stm32mp_exti_domain_ops,
+					  host_data);
+
+	if (!domain) {
+		dev_err(dev, "Could not register exti domain\n");
+		return -ENOMEM;
+	}
+
+	ret =3D devm_add_action_or_reset(dev, stm32mp_exti_remove_irq, domain);
+	if (ret)
+		return ret;
+
+	if (of_property_read_bool(np, "interrupts-extended"))
+		host_data->dt_has_irqs_desc =3D true;
+
+	return 0;
+}
+
+static const struct of_device_id stm32mp_exti_ids[] =3D {
+	{ .compatible =3D "st,stm32mp1-exti", .data =3D &stm32mp1_drv_data},
+	{ .compatible =3D "st,stm32mp13-exti", .data =3D &stm32mp13_drv_data},
+	{},
+};
+MODULE_DEVICE_TABLE(of, stm32mp_exti_ids);
+
+static const struct dev_pm_ops stm32mp_exti_dev_pm_ops =3D {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32mp_exti_suspend, stm32mp_exti_resume)
+};
+
+static struct platform_driver stm32mp_exti_driver =3D {
+	.probe		=3D stm32mp_exti_probe,
+	.driver		=3D {
+		.name		=3D "stm32mp_exti",
+		.of_match_table	=3D stm32mp_exti_ids,
+		.pm		=3D &stm32mp_exti_dev_pm_ops,
+	},
+};
+
+module_platform_driver(stm32mp_exti_driver);
+
+MODULE_AUTHOR("Maxime Coquelin <mcoquelin.stm32@gmail.com>");
+MODULE_DESCRIPTION("STM32MP EXTI driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index 57f610dab6b8..b5dddb3c1568 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -163,5 +163,6 @@ static struct platform_driver ts4800_ic_driver =3D {
 module_platform_driver(ts4800_ic_driver);
=20
 MODULE_AUTHOR("Damien Riegel <damien.riegel@savoirfairelinux.com>");
+MODULE_DESCRIPTION("Multiplexed-IRQs driver for TS-4800's FPGA");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:ts4800_irqc");
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 28c3fb2bef0d..000d339e1596 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -279,6 +279,9 @@ static inline bool invalid_phys_cpuid(phys_cpuid_t phys_i=
d)
 	return phys_id =3D=3D PHYS_CPUID_INVALID;
 }
=20
+
+int __init acpi_get_madt_revision(void);
+
 /* Validate the processor object's proc_id */
 bool acpi_duplicate_processor_id(int proc_id);
 /* Processor _CTS control */
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5c9bdd3ffccc..dac7466de5f3 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -168,7 +168,7 @@ static inline int __must_check
 request_irq(unsigned int irq, irq_handler_t handler, unsigned long flags,
 	    const char *name, void *dev)
 {
-	return request_threaded_irq(irq, handler, NULL, flags, name, dev);
+	return request_threaded_irq(irq, handler, NULL, flags | IRQF_COND_ONESHOT, =
name, dev);
 }
=20
 extern int __must_check
diff --git a/include/linux/irq.h b/include/linux/irq.h
index a217e1029c1d..1f5dbf1f92c9 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1106,6 +1106,7 @@ enum irq_gc_flags {
  * @irq_flags_to_set:	IRQ* flags to set on irq setup
  * @irq_flags_to_clear:	IRQ* flags to clear on irq setup
  * @gc_flags:		Generic chip specific setup flags
+ * @exit:		Function called on each chip when they are destroyed.
  * @gc:			Array of pointers to generic interrupt chips
  */
 struct irq_domain_chip_generic {
@@ -1114,9 +1115,37 @@ struct irq_domain_chip_generic {
 	unsigned int		irq_flags_to_clear;
 	unsigned int		irq_flags_to_set;
 	enum irq_gc_flags	gc_flags;
+	void			(*exit)(struct irq_chip_generic *gc);
 	struct irq_chip_generic	*gc[];
 };
=20
+/**
+ * struct irq_domain_chip_generic_info - Generic chip information structure
+ * @name:		Name of the generic interrupt chip
+ * @handler:		Interrupt handler used by the generic interrupt chip
+ * @irqs_per_chip:	Number of interrupts each chip handles (max 32)
+ * @num_ct:		Number of irq_chip_type instances associated with each
+ *			chip
+ * @irq_flags_to_clear:	IRQ_* bits to clear in the mapping function
+ * @irq_flags_to_set:	IRQ_* bits to set in the mapping function
+ * @gc_flags:		Generic chip specific setup flags
+ * @init:		Function called on each chip when they are created.
+ *			Allow to do some additional chip initialisation.
+ * @exit:		Function called on each chip when they are destroyed.
+ *			Allow to do some chip cleanup operation.
+ */
+struct irq_domain_chip_generic_info {
+	const char		*name;
+	irq_flow_handler_t	handler;
+	unsigned int		irqs_per_chip;
+	unsigned int		num_ct;
+	unsigned int		irq_flags_to_clear;
+	unsigned int		irq_flags_to_set;
+	enum irq_gc_flags	gc_flags;
+	int			(*init)(struct irq_chip_generic *gc);
+	void			(*exit)(struct irq_chip_generic *gc);
+};
+
 /* Generic chip callback functions */
 void irq_gc_noop(struct irq_data *d);
 void irq_gc_mask_disable_reg(struct irq_data *d);
@@ -1153,6 +1182,20 @@ int devm_irq_setup_generic_chip(struct device *dev, st=
ruct irq_chip_generic *gc,
=20
 struct irq_chip_generic *irq_get_domain_generic_chip(struct irq_domain *d, u=
nsigned int hw_irq);
=20
+#ifdef CONFIG_GENERIC_IRQ_CHIP
+int irq_domain_alloc_generic_chips(struct irq_domain *d,
+				   const struct irq_domain_chip_generic_info *info);
+void irq_domain_remove_generic_chips(struct irq_domain *d);
+#else
+static inline int
+irq_domain_alloc_generic_chips(struct irq_domain *d,
+			       const struct irq_domain_chip_generic_info *info)
+{
+	return -EINVAL;
+}
+static inline void irq_domain_remove_generic_chips(struct irq_domain *d) { }
+#endif /* CONFIG_GENERIC_IRQ_CHIP */
+
 int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 				     int num_ct, const char *name,
 				     irq_flow_handler_t handler,
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-g=
ic-v4.h
index 2c63375bbd43..ecabed6d3307 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -25,6 +25,14 @@ struct its_vm {
 	irq_hw_number_t		db_lpi_base;
 	unsigned long		*db_bitmap;
 	int			nr_db_lpis;
+	/*
+	 * Ensures mutual exclusion between updates to vlpi_count[]
+	 * and map/unmap when using the ITSList mechanism.
+	 *
+	 * The lock order for any sequence involving the ITSList is
+	 * vmapp_lock -> vpe_lock ->vmovp_lock.
+	 */
+	raw_spinlock_t		vmapp_lock;
 	u32			vlpi_count[GICv4_ITS_LIST_MAX];
 };
=20
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 21ecf582a0fe..de6105f68fec 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -74,11 +74,24 @@ void of_phandle_args_to_fwspec(struct device_node *np, co=
nst u32 *args,
  * struct irq_domain_ops - Methods for irq_domain objects
  * @match: Match an interrupt controller device node to a host, returns
  *         1 on a match
+ * @select: Match an interrupt controller fw specification. It is more gener=
ic
+ *	    than @match as it receives a complete struct irq_fwspec. Therefore,
+ *	    @select is preferred if provided. Returns 1 on a match.
  * @map: Create or update a mapping between a virtual irq number and a hw
  *       irq number. This is called only once for a given mapping.
  * @unmap: Dispose of such a mapping
  * @xlate: Given a device tree node and interrupt specifier, decode
  *         the hardware irq number and linux irq type value.
+ * @alloc: Allocate @nr_irqs interrupts starting from @virq.
+ * @free: Free @nr_irqs interrupts starting from @virq.
+ * @activate: Activate one interrupt in HW (@irqd). If @reserve is set, only
+ *	      reserve the vector. If unset, assign the vector (called from
+ *	      request_irq()).
+ * @deactivate: Disarm one interrupt (@irqd).
+ * @translate: Given @fwspec, decode the hardware irq number (@out_hwirq) and
+ *	       linux irq type value (@out_type). This is a generalised @xlate
+ *	       (over struct irq_fwspec) and is preferred if provided.
+ * @debug_show: For domains to show specific data for an interrupt in debugf=
s.
  *
  * Functions below are provided by the driver and called whenever a new mapp=
ing
  * is created or an old mapping is disposed. The driver can then proceed to
@@ -131,6 +144,9 @@ struct irq_domain_chip_generic;
  * Optional elements:
  * @fwnode:	Pointer to firmware node associated with the irq_domain. Pretty =
easy
  *		to swap it for the of_node via the irq_domain_get_of_node accessor
+ * @bus_token:	@fwnode's device_node might be used for several irq domains. =
But
+ *		in connection with @bus_token, the pair shall be unique in a
+ *		system.
  * @gc:		Pointer to a list of generic chips. There is a helper function for
  *		setting up one or more generic chips for interrupt controllers
  *		drivers using the generic chip library which uses this pointer.
@@ -141,9 +157,12 @@ struct irq_domain_chip_generic;
  *		purposes related to the irq domain.
  * @parent:	Pointer to parent irq_domain to support hierarchy irq_domains
  * @msi_parent_ops: Pointer to MSI parent domain methods for per device doma=
in init
+ * @exit:	Function called when the domain is destroyed
  *
  * Revmap data, used internally by the irq domain code:
- * @revmap_size:	Size of the linear map table @revmap[]
+ * @hwirq_max:		Top limit for the HW irq number. Especially to avoid
+ *			conflicts/failures with reserved HW irqs. Can be ~0.
+ * @revmap_size:	Size of the linear map table @revmap
  * @revmap_tree:	Radix map tree for hwirqs that don't fit in the linear map
  * @revmap:		Linear table of irq_data pointers
  */
@@ -169,6 +188,7 @@ struct irq_domain {
 #ifdef CONFIG_GENERIC_MSI_IRQ
 	const struct msi_parent_ops	*msi_parent_ops;
 #endif
+	void				(*exit)(struct irq_domain *d);
=20
 	/* reverse map data. The linear map gets appended to the irq_domain */
 	irq_hw_number_t			hwirq_max;
@@ -182,7 +202,7 @@ enum {
 	/* Irq domain is hierarchical */
 	IRQ_DOMAIN_FLAG_HIERARCHY	=3D (1 << 0),
=20
-	/* Irq domain name was allocated in __irq_domain_add() */
+	/* Irq domain name was allocated internally */
 	IRQ_DOMAIN_NAME_ALLOCATED	=3D (1 << 1),
=20
 	/* Irq domain is an IPI domain with virq per cpu */
@@ -208,6 +228,9 @@ enum {
 	/* Irq domain is a MSI device domain */
 	IRQ_DOMAIN_FLAG_MSI_DEVICE	=3D (1 << 9),
=20
+	/* Irq domain must destroy generic chips when removed */
+	IRQ_DOMAIN_FLAG_DESTROY_GC	=3D (1 << 10),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the
@@ -257,10 +280,51 @@ static inline struct fwnode_handle *irq_domain_alloc_fw=
node(phys_addr_t *pa)
 }
=20
 void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
-struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned i=
nt size,
-				    irq_hw_number_t hwirq_max, int direct_max,
-				    const struct irq_domain_ops *ops,
-				    void *host_data);
+
+struct irq_domain_chip_generic_info;
+
+/**
+ * struct irq_domain_info - Domain information structure
+ * @fwnode:		firmware node for the interrupt controller
+ * @domain_flags:	Additional flags to add to the domain flags
+ * @size:		Size of linear map; 0 for radix mapping only
+ * @hwirq_max:		Maximum number of interrupts supported by controller
+ * @direct_max:		Maximum value of direct maps;
+ *			Use ~0 for no limit; 0 for no direct mapping
+ * @bus_token:		Domain bus token
+ * @ops:		Domain operation callbacks
+ * @host_data:		Controller private data pointer
+ * @dgc_info:		Geneneric chip information structure pointer used to
+ *			create generic chips for the domain if not NULL.
+ * @init:		Function called when the domain is created.
+ *			Allow to do some additional domain initialisation.
+ * @exit:		Function called when the domain is destroyed.
+ *			Allow to do some additional cleanup operation.
+ */
+struct irq_domain_info {
+	struct fwnode_handle			*fwnode;
+	unsigned int				domain_flags;
+	unsigned int				size;
+	irq_hw_number_t				hwirq_max;
+	int					direct_max;
+	enum irq_domain_bus_token		bus_token;
+	const struct irq_domain_ops		*ops;
+	void					*host_data;
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+	/**
+	 * @parent: Pointer to the parent irq domain used in a hierarchy domain
+	 */
+	struct irq_domain			*parent;
+#endif
+	struct irq_domain_chip_generic_info	*dgc_info;
+	int					(*init)(struct irq_domain *d);
+	void					(*exit)(struct irq_domain *d);
+};
+
+struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info=
);
+struct irq_domain *devm_irq_domain_instantiate(struct device *dev,
+					       const struct irq_domain_info *info);
+
 struct irq_domain *irq_domain_create_simple(struct fwnode_handle *fwnode,
 					    unsigned int size,
 					    unsigned int first_irq,
@@ -293,7 +357,7 @@ static inline struct fwnode_handle *of_node_to_fwnode(str=
uct device_node *node)
=20
 extern const struct fwnode_operations irqchip_fwnode_ops;
=20
-static inline bool is_fwnode_irqchip(struct fwnode_handle *fwnode)
+static inline bool is_fwnode_irqchip(const struct fwnode_handle *fwnode)
 {
 	return fwnode && fwnode->ops =3D=3D &irqchip_fwnode_ops;
 }
@@ -350,7 +414,17 @@ static inline struct irq_domain *irq_domain_add_linear(s=
truct device_node *of_no
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node_to_fwnode(of_node), size, size, 0, ops, hos=
t_data);
+	struct irq_domain_info info =3D {
+		.fwnode		=3D of_node_to_fwnode(of_node),
+		.size		=3D size,
+		.hwirq_max	=3D size,
+		.ops		=3D ops,
+		.host_data	=3D host_data,
+	};
+	struct irq_domain *d;
+
+	d =3D irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
=20
 #ifdef CONFIG_IRQ_DOMAIN_NOMAP
@@ -359,7 +433,17 @@ static inline struct irq_domain *irq_domain_add_nomap(st=
ruct device_node *of_nod
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node_to_fwnode(of_node), 0, max_irq, max_irq, op=
s, host_data);
+	struct irq_domain_info info =3D {
+		.fwnode		=3D of_node_to_fwnode(of_node),
+		.hwirq_max	=3D max_irq,
+		.direct_max	=3D max_irq,
+		.ops		=3D ops,
+		.host_data	=3D host_data,
+	};
+	struct irq_domain *d;
+
+	d =3D irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
=20
 extern unsigned int irq_create_direct_mapping(struct irq_domain *host);
@@ -369,7 +453,16 @@ static inline struct irq_domain *irq_domain_add_tree(str=
uct device_node *of_node
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node_to_fwnode(of_node), 0, ~0, 0, ops, host_dat=
a);
+	struct irq_domain_info info =3D {
+		.fwnode		=3D of_node_to_fwnode(of_node),
+		.hwirq_max	=3D ~0U,
+		.ops		=3D ops,
+		.host_data	=3D host_data,
+	};
+	struct irq_domain *d;
+
+	d =3D irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
=20
 static inline struct irq_domain *irq_domain_create_linear(struct fwnode_hand=
le *fwnode,
@@ -377,14 +470,33 @@ static inline struct irq_domain *irq_domain_create_line=
ar(struct fwnode_handle *
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(fwnode, size, size, 0, ops, host_data);
+	struct irq_domain_info info =3D {
+		.fwnode		=3D fwnode,
+		.size		=3D size,
+		.hwirq_max	=3D size,
+		.ops		=3D ops,
+		.host_data	=3D host_data,
+	};
+	struct irq_domain *d;
+
+	d =3D irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
=20
 static inline struct irq_domain *irq_domain_create_tree(struct fwnode_handle=
 *fwnode,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(fwnode, 0, ~0, 0, ops, host_data);
+	struct irq_domain_info info =3D {
+		.fwnode		=3D fwnode,
+		.hwirq_max	=3D ~0,
+		.ops		=3D ops,
+		.host_data	=3D host_data,
+	};
+	struct irq_domain *d;
+
+	d =3D irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
=20
 extern void irq_domain_remove(struct irq_domain *host);
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index aae0402507ed..c6ffb97966be 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -9,14 +9,8 @@
=20
 static struct dentry *irq_dir;
=20
-struct irq_bit_descr {
-	unsigned int	mask;
-	char		*name;
-};
-#define BIT_MASK_DESCR(m)	{ .mask =3D m, .name =3D #m }
-
-static void irq_debug_show_bits(struct seq_file *m, int ind, unsigned int st=
ate,
-				const struct irq_bit_descr *sd, int size)
+void irq_debug_show_bits(struct seq_file *m, int ind, unsigned int state,
+			 const struct irq_bit_descr *sd, int size)
 {
 	int i;
=20
diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index f6e5515ee077..b3e98668f4dd 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/device.h>
 #include <linux/gfp.h>
 #include <linux/irq.h>
@@ -282,3 +283,43 @@ int devm_irq_setup_generic_chip(struct device *dev, stru=
ct irq_chip_generic *gc,
 }
 EXPORT_SYMBOL_GPL(devm_irq_setup_generic_chip);
 #endif /* CONFIG_GENERIC_IRQ_CHIP */
+
+#ifdef CONFIG_IRQ_DOMAIN
+static void devm_irq_domain_remove(struct device *dev, void *res)
+{
+	struct irq_domain **domain =3D res;
+
+	irq_domain_remove(*domain);
+}
+
+/**
+ * devm_irq_domain_instantiate() - Instantiate a new irq domain data for a
+ *                                 managed device.
+ * @dev:	Device to instantiate the domain for
+ * @info:	Domain information pointer pointing to the information for this
+ *		domain
+ *
+ * Return: A pointer to the instantiated irq domain or an ERR_PTR value.
+ */
+struct irq_domain *devm_irq_domain_instantiate(struct device *dev,
+					       const struct irq_domain_info *info)
+{
+	struct irq_domain *domain;
+	struct irq_domain **dr;
+
+	dr =3D devres_alloc(devm_irq_domain_remove, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return ERR_PTR(-ENOMEM);
+
+	domain =3D irq_domain_instantiate(info);
+	if (!IS_ERR(domain)) {
+		*dr =3D domain;
+		devres_add(dev, dr);
+	} else {
+		devres_free(dr);
+	}
+
+	return domain;
+}
+EXPORT_SYMBOL_GPL(devm_irq_domain_instantiate);
+#endif /* CONFIG_IRQ_DOMAIN */
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index d39a40bc542b..32ffcbb87fa1 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -276,21 +276,14 @@ irq_gc_init_mask_cache(struct irq_chip_generic *gc, enu=
m irq_gc_flags flags)
 }
=20
 /**
- * __irq_alloc_domain_generic_chips - Allocate generic chips for an irq doma=
in
- * @d:			irq domain for which to allocate chips
- * @irqs_per_chip:	Number of interrupts each chip handles (max 32)
- * @num_ct:		Number of irq_chip_type instances associated with this
- * @name:		Name of the irq chip
- * @handler:		Default flow handler associated with these chips
- * @clr:		IRQ_* bits to clear in the mapping function
- * @set:		IRQ_* bits to set in the mapping function
- * @gcflags:		Generic chip specific setup flags
+ * irq_domain_alloc_generic_chips - Allocate generic chips for an irq domain
+ * @d:		irq domain for which to allocate chips
+ * @info:	Generic chip information
+ *
+ * Return: 0 on success, negative error code on failure
  */
-int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
-				     int num_ct, const char *name,
-				     irq_flow_handler_t handler,
-				     unsigned int clr, unsigned int set,
-				     enum irq_gc_flags gcflags)
+int irq_domain_alloc_generic_chips(struct irq_domain *d,
+				   const struct irq_domain_chip_generic_info *info)
 {
 	struct irq_domain_chip_generic *dgc;
 	struct irq_chip_generic *gc;
@@ -300,27 +293,29 @@ int __irq_alloc_domain_generic_chips(struct irq_domain =
*d, int irqs_per_chip,
 	size_t gc_sz;
 	size_t sz;
 	void *tmp;
+	int ret;
=20
 	if (d->gc)
 		return -EBUSY;
=20
-	numchips =3D DIV_ROUND_UP(d->revmap_size, irqs_per_chip);
+	numchips =3D DIV_ROUND_UP(d->revmap_size, info->irqs_per_chip);
 	if (!numchips)
 		return -EINVAL;
=20
 	/* Allocate a pointer, generic chip and chiptypes for each chip */
-	gc_sz =3D struct_size(gc, chip_types, num_ct);
+	gc_sz =3D struct_size(gc, chip_types, info->num_ct);
 	dgc_sz =3D struct_size(dgc, gc, numchips);
 	sz =3D dgc_sz + numchips * gc_sz;
=20
 	tmp =3D dgc =3D kzalloc(sz, GFP_KERNEL);
 	if (!dgc)
 		return -ENOMEM;
-	dgc->irqs_per_chip =3D irqs_per_chip;
+	dgc->irqs_per_chip =3D info->irqs_per_chip;
 	dgc->num_chips =3D numchips;
-	dgc->irq_flags_to_set =3D set;
-	dgc->irq_flags_to_clear =3D clr;
-	dgc->gc_flags =3D gcflags;
+	dgc->irq_flags_to_set =3D info->irq_flags_to_set;
+	dgc->irq_flags_to_clear =3D info->irq_flags_to_clear;
+	dgc->gc_flags =3D info->gc_flags;
+	dgc->exit =3D info->exit;
 	d->gc =3D dgc;
=20
 	/* Calc pointer to the first generic chip */
@@ -328,15 +323,22 @@ int __irq_alloc_domain_generic_chips(struct irq_domain =
*d, int irqs_per_chip,
 	for (i =3D 0; i < numchips; i++) {
 		/* Store the pointer to the generic chip */
 		dgc->gc[i] =3D gc =3D tmp;
-		irq_init_generic_chip(gc, name, num_ct, i * irqs_per_chip,
-				      NULL, handler);
+		irq_init_generic_chip(gc, info->name, info->num_ct,
+				      i * dgc->irqs_per_chip, NULL,
+				      info->handler);
=20
 		gc->domain =3D d;
-		if (gcflags & IRQ_GC_BE_IO) {
+		if (dgc->gc_flags & IRQ_GC_BE_IO) {
 			gc->reg_readl =3D &irq_readl_be;
 			gc->reg_writel =3D &irq_writel_be;
 		}
=20
+		if (info->init) {
+			ret =3D info->init(gc);
+			if (ret)
+				goto err;
+		}
+
 		raw_spin_lock_irqsave(&gc_lock, flags);
 		list_add_tail(&gc->list, &gc_list);
 		raw_spin_unlock_irqrestore(&gc_lock, flags);
@@ -344,6 +346,69 @@ int __irq_alloc_domain_generic_chips(struct irq_domain *=
d, int irqs_per_chip,
 		tmp +=3D gc_sz;
 	}
 	return 0;
+
+err:
+	while (i--) {
+		if (dgc->exit)
+			dgc->exit(dgc->gc[i]);
+		irq_remove_generic_chip(dgc->gc[i], ~0U, 0, 0);
+	}
+	d->gc =3D NULL;
+	kfree(dgc);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(irq_domain_alloc_generic_chips);
+
+/**
+ * irq_domain_remove_generic_chips - Remove generic chips from an irq domain
+ * @d: irq domain for which generic chips are to be removed
+ */
+void irq_domain_remove_generic_chips(struct irq_domain *d)
+{
+	struct irq_domain_chip_generic *dgc =3D d->gc;
+	unsigned int i;
+
+	if (!dgc)
+		return;
+
+	for (i =3D 0; i < dgc->num_chips; i++) {
+		if (dgc->exit)
+			dgc->exit(dgc->gc[i]);
+		irq_remove_generic_chip(dgc->gc[i], ~0U, 0, 0);
+	}
+	d->gc =3D NULL;
+	kfree(dgc);
+}
+EXPORT_SYMBOL_GPL(irq_domain_remove_generic_chips);
+
+/**
+ * __irq_alloc_domain_generic_chips - Allocate generic chips for an irq doma=
in
+ * @d:			irq domain for which to allocate chips
+ * @irqs_per_chip:	Number of interrupts each chip handles (max 32)
+ * @num_ct:		Number of irq_chip_type instances associated with this
+ * @name:		Name of the irq chip
+ * @handler:		Default flow handler associated with these chips
+ * @clr:		IRQ_* bits to clear in the mapping function
+ * @set:		IRQ_* bits to set in the mapping function
+ * @gcflags:		Generic chip specific setup flags
+ */
+int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
+				     int num_ct, const char *name,
+				     irq_flow_handler_t handler,
+				     unsigned int clr, unsigned int set,
+				     enum irq_gc_flags gcflags)
+{
+	struct irq_domain_chip_generic_info info =3D {
+		.irqs_per_chip		=3D irqs_per_chip,
+		.num_ct			=3D num_ct,
+		.name			=3D name,
+		.handler		=3D handler,
+		.irq_flags_to_clear	=3D clr,
+		.irq_flags_to_set	=3D set,
+		.gc_flags		=3D gcflags,
+	};
+
+	return irq_domain_alloc_generic_chips(d, &info);
 }
 EXPORT_SYMBOL_GPL(__irq_alloc_domain_generic_chips);
=20
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index ed28059e9849..fe0272cd84a5 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -501,6 +501,16 @@ static inline struct irq_data *irqd_get_parent_data(stru=
ct irq_data *irqd)
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
 #include <linux/debugfs.h>
=20
+struct irq_bit_descr {
+	unsigned int	mask;
+	char		*name;
+};
+
+#define BIT_MASK_DESCR(m)	{ .mask =3D m, .name =3D #m }
+
+void irq_debug_show_bits(struct seq_file *m, int ind, unsigned int state,
+			 const struct irq_bit_descr *sd, int size);
+
 void irq_add_debugfs_entry(unsigned int irq, struct irq_desc *desc);
 static inline void irq_remove_debugfs_entry(struct irq_desc *desc)
 {
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index aadc8891cc16..91eaf6bfcbf0 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -111,6 +111,7 @@ EXPORT_SYMBOL_GPL(__irq_domain_alloc_fwnode);
=20
 /**
  * irq_domain_free_fwnode - Free a non-OF-backed fwnode_handle
+ * @fwnode: fwnode_handle to free
  *
  * Free a fwnode_handle allocated with irq_domain_alloc_fwnode.
  */
@@ -127,27 +128,12 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnod=
e)
 }
 EXPORT_SYMBOL_GPL(irq_domain_free_fwnode);
=20
-static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
-					      unsigned int size,
-					      irq_hw_number_t hwirq_max,
-					      int direct_max,
-					      const struct irq_domain_ops *ops,
-					      void *host_data)
+static int irq_domain_set_name(struct irq_domain *domain,
+			       const struct fwnode_handle *fwnode,
+			       enum irq_domain_bus_token bus_token)
 {
-	struct irqchip_fwid *fwid;
-	struct irq_domain *domain;
-
 	static atomic_t unknown_domains;
-
-	if (WARN_ON((size && direct_max) ||
-		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && direct_max) ||
-		    (direct_max && (direct_max !=3D hwirq_max))))
-		return NULL;
-
-	domain =3D kzalloc_node(struct_size(domain, revmap, size),
-			      GFP_KERNEL, of_node_to_nid(to_of_node(fwnode)));
-	if (!domain)
-		return NULL;
+	struct irqchip_fwid *fwid;
=20
 	if (is_fwnode_irqchip(fwnode)) {
 		fwid =3D container_of(fwnode, struct irqchip_fwid, fwnode);
@@ -155,17 +141,23 @@ static struct irq_domain *__irq_domain_create(struct fw=
node_handle *fwnode,
 		switch (fwid->type) {
 		case IRQCHIP_FWNODE_NAMED:
 		case IRQCHIP_FWNODE_NAMED_ID:
-			domain->fwnode =3D fwnode;
-			domain->name =3D kstrdup(fwid->name, GFP_KERNEL);
-			if (!domain->name) {
-				kfree(domain);
-				return NULL;
-			}
+			domain->name =3D bus_token ?
+					kasprintf(GFP_KERNEL, "%s-%d",
+						  fwid->name, bus_token) :
+					kstrdup(fwid->name, GFP_KERNEL);
+			if (!domain->name)
+				return -ENOMEM;
 			domain->flags |=3D IRQ_DOMAIN_NAME_ALLOCATED;
 			break;
 		default:
-			domain->fwnode =3D fwnode;
 			domain->name =3D fwid->name;
+			if (bus_token) {
+				domain->name =3D kasprintf(GFP_KERNEL, "%s-%d",
+							 fwid->name, bus_token);
+				if (!domain->name)
+					return -ENOMEM;
+				domain->flags |=3D IRQ_DOMAIN_NAME_ALLOCATED;
+			}
 			break;
 		}
 	} else if (is_of_node(fwnode) || is_acpi_device_node(fwnode) ||
@@ -177,42 +169,68 @@ static struct irq_domain *__irq_domain_create(struct fw=
node_handle *fwnode,
 		 * unhappy about. Replace them with ':', which does
 		 * the trick and is not as offensive as '\'...
 		 */
-		name =3D kasprintf(GFP_KERNEL, "%pfw", fwnode);
-		if (!name) {
-			kfree(domain);
-			return NULL;
-		}
+		name =3D bus_token ?
+			kasprintf(GFP_KERNEL, "%pfw-%d", fwnode, bus_token) :
+			kasprintf(GFP_KERNEL, "%pfw", fwnode);
+		if (!name)
+			return -ENOMEM;
=20
 		domain->name =3D strreplace(name, '/', ':');
-		domain->fwnode =3D fwnode;
 		domain->flags |=3D IRQ_DOMAIN_NAME_ALLOCATED;
 	}
=20
 	if (!domain->name) {
 		if (fwnode)
 			pr_err("Invalid fwnode type for irqdomain\n");
-		domain->name =3D kasprintf(GFP_KERNEL, "unknown-%d",
-					 atomic_inc_return(&unknown_domains));
-		if (!domain->name) {
-			kfree(domain);
-			return NULL;
-		}
+		domain->name =3D bus_token ?
+				kasprintf(GFP_KERNEL, "unknown-%d-%d",
+					  atomic_inc_return(&unknown_domains),
+					  bus_token) :
+				kasprintf(GFP_KERNEL, "unknown-%d",
+					  atomic_inc_return(&unknown_domains));
+		if (!domain->name)
+			return -ENOMEM;
 		domain->flags |=3D IRQ_DOMAIN_NAME_ALLOCATED;
 	}
=20
-	fwnode_handle_get(fwnode);
-	fwnode_dev_initialized(fwnode, true);
+	return 0;
+}
+
+static struct irq_domain *__irq_domain_create(const struct irq_domain_info *=
info)
+{
+	struct irq_domain *domain;
+	int err;
+
+	if (WARN_ON((info->size && info->direct_max) ||
+		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && info->direct_max) ||
+		    (info->direct_max && info->direct_max !=3D info->hwirq_max)))
+		return ERR_PTR(-EINVAL);
+
+	domain =3D kzalloc_node(struct_size(domain, revmap, info->size),
+			      GFP_KERNEL, of_node_to_nid(to_of_node(info->fwnode)));
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	err =3D irq_domain_set_name(domain, info->fwnode, info->bus_token);
+	if (err) {
+		kfree(domain);
+		return ERR_PTR(err);
+	}
+
+	domain->fwnode =3D fwnode_handle_get(info->fwnode);
+	fwnode_dev_initialized(domain->fwnode, true);
=20
 	/* Fill structure */
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
-	domain->ops =3D ops;
-	domain->host_data =3D host_data;
-	domain->hwirq_max =3D hwirq_max;
+	domain->ops =3D info->ops;
+	domain->host_data =3D info->host_data;
+	domain->bus_token =3D info->bus_token;
+	domain->hwirq_max =3D info->hwirq_max;
=20
-	if (direct_max)
+	if (info->direct_max)
 		domain->flags |=3D IRQ_DOMAIN_FLAG_NO_MAP;
=20
-	domain->revmap_size =3D size;
+	domain->revmap_size =3D info->size;
=20
 	/*
 	 * Hierarchical domains use the domain lock of the root domain
@@ -240,34 +258,64 @@ static void __irq_domain_publish(struct irq_domain *dom=
ain)
 	pr_debug("Added domain %s\n", domain->name);
 }
=20
+static void irq_domain_free(struct irq_domain *domain)
+{
+	fwnode_dev_initialized(domain->fwnode, false);
+	fwnode_handle_put(domain->fwnode);
+	if (domain->flags & IRQ_DOMAIN_NAME_ALLOCATED)
+		kfree(domain->name);
+	kfree(domain);
+}
+
 /**
- * __irq_domain_add() - Allocate a new irq_domain data structure
- * @fwnode: firmware node for the interrupt controller
- * @size: Size of linear map; 0 for radix mapping only
- * @hwirq_max: Maximum number of interrupts supported by controller
- * @direct_max: Maximum value of direct maps; Use ~0 for no limit; 0 for no
- *              direct mapping
- * @ops: domain callbacks
- * @host_data: Controller private data pointer
+ * irq_domain_instantiate() - Instantiate a new irq domain data structure
+ * @info: Domain information pointer pointing to the information for this do=
main
  *
- * Allocates and initializes an irq_domain structure.
- * Returns pointer to IRQ domain, or NULL on failure.
+ * Return: A pointer to the instantiated irq domain or an ERR_PTR value.
  */
-struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned i=
nt size,
-				    irq_hw_number_t hwirq_max, int direct_max,
-				    const struct irq_domain_ops *ops,
-				    void *host_data)
+struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 {
 	struct irq_domain *domain;
+	int err;
=20
-	domain =3D __irq_domain_create(fwnode, size, hwirq_max, direct_max,
-				     ops, host_data);
-	if (domain)
-		__irq_domain_publish(domain);
+	domain =3D __irq_domain_create(info);
+	if (IS_ERR(domain))
+		return domain;
+
+	domain->flags |=3D info->domain_flags;
+	domain->exit =3D info->exit;
+
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+	if (info->parent) {
+		domain->root =3D info->parent->root;
+		domain->parent =3D info->parent;
+	}
+#endif
+
+	if (info->dgc_info) {
+		err =3D irq_domain_alloc_generic_chips(domain, info->dgc_info);
+		if (err)
+			goto err_domain_free;
+	}
+
+	if (info->init) {
+		err =3D info->init(domain);
+		if (err)
+			goto err_domain_gc_remove;
+	}
+
+	__irq_domain_publish(domain);
=20
 	return domain;
+
+err_domain_gc_remove:
+	if (info->dgc_info)
+		irq_domain_remove_generic_chips(domain);
+err_domain_free:
+	irq_domain_free(domain);
+	return ERR_PTR(err);
 }
-EXPORT_SYMBOL_GPL(__irq_domain_add);
+EXPORT_SYMBOL_GPL(irq_domain_instantiate);
=20
 /**
  * irq_domain_remove() - Remove an irq domain.
@@ -279,6 +327,9 @@ EXPORT_SYMBOL_GPL(__irq_domain_add);
  */
 void irq_domain_remove(struct irq_domain *domain)
 {
+	if (domain->exit)
+		domain->exit(domain);
+
 	mutex_lock(&irq_domain_mutex);
 	debugfs_remove_domain_dir(domain);
=20
@@ -294,13 +345,11 @@ void irq_domain_remove(struct irq_domain *domain)
=20
 	mutex_unlock(&irq_domain_mutex);
=20
-	pr_debug("Removed domain %s\n", domain->name);
+	if (domain->flags & IRQ_DOMAIN_FLAG_DESTROY_GC)
+		irq_domain_remove_generic_chips(domain);
=20
-	fwnode_dev_initialized(domain->fwnode, false);
-	fwnode_handle_put(domain->fwnode);
-	if (domain->flags & IRQ_DOMAIN_NAME_ALLOCATED)
-		kfree(domain->name);
-	kfree(domain);
+	pr_debug("Removed domain %s\n", domain->name);
+	irq_domain_free(domain);
 }
 EXPORT_SYMBOL_GPL(irq_domain_remove);
=20
@@ -360,10 +409,17 @@ struct irq_domain *irq_domain_create_simple(struct fwno=
de_handle *fwnode,
 					    const struct irq_domain_ops *ops,
 					    void *host_data)
 {
+	struct irq_domain_info info =3D {
+		.fwnode		=3D fwnode,
+		.size		=3D size,
+		.hwirq_max	=3D size,
+		.ops		=3D ops,
+		.host_data	=3D host_data,
+	};
 	struct irq_domain *domain;
=20
-	domain =3D __irq_domain_add(fwnode, size, size, 0, ops, host_data);
-	if (!domain)
+	domain =3D irq_domain_instantiate(&info);
+	if (IS_ERR(domain))
 		return NULL;
=20
 	if (first_irq > 0) {
@@ -416,11 +472,20 @@ struct irq_domain *irq_domain_create_legacy(struct fwno=
de_handle *fwnode,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
+	struct irq_domain_info info =3D {
+		.fwnode		=3D fwnode,
+		.size		=3D first_hwirq + size,
+		.hwirq_max	=3D first_hwirq + size,
+		.ops		=3D ops,
+		.host_data	=3D host_data,
+	};
 	struct irq_domain *domain;
=20
-	domain =3D __irq_domain_add(fwnode, first_hwirq + size, first_hwirq + size,=
 0, ops, host_data);
-	if (domain)
-		irq_domain_associate_many(domain, first_irq, first_hwirq, size);
+	domain =3D irq_domain_instantiate(&info);
+	if (IS_ERR(domain))
+		return NULL;
+
+	irq_domain_associate_many(domain, first_irq, first_hwirq, size);
=20
 	return domain;
 }
@@ -982,6 +1047,12 @@ EXPORT_SYMBOL_GPL(__irq_resolve_mapping);
=20
 /**
  * irq_domain_xlate_onecell() - Generic xlate for direct one cell bindings
+ * @d:		Interrupt domain involved in the translation
+ * @ctrlr:	The device tree node for the device whose interrupt is translated
+ * @intspec:	The interrupt specifier data from the device tree
+ * @intsize:	The number of entries in @intspec
+ * @out_hwirq:	Pointer to storage for the hardware interrupt number
+ * @out_type:	Pointer to storage for the interrupt type
  *
  * Device Tree IRQ specifier translation function which works with one cell
  * bindings where the cell value maps directly to the hwirq number.
@@ -1000,6 +1071,12 @@ EXPORT_SYMBOL_GPL(irq_domain_xlate_onecell);
=20
 /**
  * irq_domain_xlate_twocell() - Generic xlate for direct two cell bindings
+ * @d:		Interrupt domain involved in the translation
+ * @ctrlr:	The device tree node for the device whose interrupt is translated
+ * @intspec:	The interrupt specifier data from the device tree
+ * @intsize:	The number of entries in @intspec
+ * @out_hwirq:	Pointer to storage for the hardware interrupt number
+ * @out_type:	Pointer to storage for the interrupt type
  *
  * Device Tree IRQ specifier translation function which works with two cell
  * bindings where the cell values map directly to the hwirq number
@@ -1018,6 +1095,12 @@ EXPORT_SYMBOL_GPL(irq_domain_xlate_twocell);
=20
 /**
  * irq_domain_xlate_onetwocell() - Generic xlate for one or two cell bindings
+ * @d:		Interrupt domain involved in the translation
+ * @ctrlr:	The device tree node for the device whose interrupt is translated
+ * @intspec:	The interrupt specifier data from the device tree
+ * @intsize:	The number of entries in @intspec
+ * @out_hwirq:	Pointer to storage for the hardware interrupt number
+ * @out_type:	Pointer to storage for the interrupt type
  *
  * Device Tree IRQ specifier translation function which works with either one
  * or two cell bindings where the cell values map directly to the hwirq numb=
er
@@ -1051,6 +1134,10 @@ EXPORT_SYMBOL_GPL(irq_domain_simple_ops);
 /**
  * irq_domain_translate_onecell() - Generic translate for direct one cell
  * bindings
+ * @d:		Interrupt domain involved in the translation
+ * @fwspec:	The firmware interrupt specifier to translate
+ * @out_hwirq:	Pointer to storage for the hardware interrupt number
+ * @out_type:	Pointer to storage for the interrupt type
  */
 int irq_domain_translate_onecell(struct irq_domain *d,
 				 struct irq_fwspec *fwspec,
@@ -1068,6 +1155,10 @@ EXPORT_SYMBOL_GPL(irq_domain_translate_onecell);
 /**
  * irq_domain_translate_twocell() - Generic translate for direct two cell
  * bindings
+ * @d:		Interrupt domain involved in the translation
+ * @fwspec:	The firmware interrupt specifier to translate
+ * @out_hwirq:	Pointer to storage for the hardware interrupt number
+ * @out_type:	Pointer to storage for the interrupt type
  *
  * Device Tree IRQ specifier translation function which works with two cell
  * bindings where the cell values map directly to the hwirq number
@@ -1144,23 +1235,22 @@ struct irq_domain *irq_domain_create_hierarchy(struct=
 irq_domain *parent,
 					    const struct irq_domain_ops *ops,
 					    void *host_data)
 {
-	struct irq_domain *domain;
-
-	if (size)
-		domain =3D __irq_domain_create(fwnode, size, size, 0, ops, host_data);
-	else
-		domain =3D __irq_domain_create(fwnode, 0, ~0, 0, ops, host_data);
-
-	if (domain) {
-		if (parent)
-			domain->root =3D parent->root;
-		domain->parent =3D parent;
-		domain->flags |=3D flags;
+	struct irq_domain_info info =3D {
+		.fwnode		=3D fwnode,
+		.size		=3D size,
+		.hwirq_max	=3D size,
+		.ops		=3D ops,
+		.host_data	=3D host_data,
+		.domain_flags	=3D flags,
+		.parent		=3D parent,
+	};
+	struct irq_domain *d;
=20
-		__irq_domain_publish(domain);
-	}
+	if (!info.size)
+		info.hwirq_max =3D ~0U;
=20
-	return domain;
+	d =3D irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
 EXPORT_SYMBOL_GPL(irq_domain_create_hierarchy);
=20
@@ -1932,13 +2022,26 @@ static void irq_domain_free_one_irq(struct irq_domain=
 *domain, unsigned int virq
=20
 static struct dentry *domain_dir;
=20
-static void
-irq_domain_debug_show_one(struct seq_file *m, struct irq_domain *d, int ind)
+static const struct irq_bit_descr irqdomain_flags[] =3D {
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_HIERARCHY),
+	BIT_MASK_DESCR(IRQ_DOMAIN_NAME_ALLOCATED),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_IPI_PER_CPU),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_IPI_SINGLE),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_MSI),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_ISOLATED_MSI),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_NO_MAP),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_MSI_PARENT),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_MSI_DEVICE),
+	BIT_MASK_DESCR(IRQ_DOMAIN_FLAG_NONCORE),
+};
+
+static void irq_domain_debug_show_one(struct seq_file *m, struct irq_domain =
*d, int ind)
 {
 	seq_printf(m, "%*sname:   %s\n", ind, "", d->name);
 	seq_printf(m, "%*ssize:   %u\n", ind + 1, "", d->revmap_size);
 	seq_printf(m, "%*smapped: %u\n", ind + 1, "", d->mapcount);
 	seq_printf(m, "%*sflags:  0x%08x\n", ind +1 , "", d->flags);
+	irq_debug_show_bits(m, ind, d->flags, irqdomain_flags, ARRAY_SIZE(irqdomain=
_flags));
 	if (d->ops && d->ops->debug_show)
 		d->ops->debug_show(m, d, NULL, ind + 1);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 5c320c3f10a7..8cccdf40725a 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -461,10 +461,10 @@ int show_interrupts(struct seq_file *p, void *v)
 {
 	static int prec;
=20
-	unsigned long flags, any_count =3D 0;
 	int i =3D *(loff_t *) v, j;
 	struct irqaction *action;
 	struct irq_desc *desc;
+	unsigned long flags;
=20
 	if (i > ACTUAL_NR_IRQS)
 		return 0;
@@ -488,10 +488,7 @@ int show_interrupts(struct seq_file *p, void *v)
 	if (!desc || irq_settings_is_hidden(desc))
 		goto outsparse;
=20
-	if (desc->kstat_irqs)
-		any_count =3D kstat_irqs_desc(desc, cpu_online_mask);
-
-	if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)
+	if (!desc->action || irq_desc_is_chained(desc) || !desc->kstat_irqs)
 		goto outsparse;
=20
 	seq_printf(p, "%*d: ", prec, i);


