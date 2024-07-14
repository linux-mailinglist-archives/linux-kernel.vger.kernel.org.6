Return-Path: <linux-kernel+bounces-251924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7B8930BAD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 22:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7A6280F70
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 20:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9555813F42D;
	Sun, 14 Jul 2024 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1q27h+su";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eE7mu/NX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F90D50A63
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720990218; cv=none; b=hK1GUEt3W/Llax8KA8nt/QycafNCbhFTPxGzP0VGziSyhcEg9hVv+eXyLMtLiRRC9k7ubbWN0sidCOF3wOsJmmDqgxUb8v3zFBCRM0HXUs6M8JRMVb25ltcFGd8dy6aGDu2ycAjmXwwpNPGVno5lzcFa7oPpAfEChcj92gbBh10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720990218; c=relaxed/simple;
	bh=1ACq9ndDr4CB2RZiAHsK4dXhJFcQwj0WT+3maLqu/Y4=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=kD5Tp5ZDkWITxv4VfXwFbwaBlLyQfqk8rDyVdiXZJF30No1TFCUkR7Iu0e+OymrEgZtvv6/bd+/EcgKDgpmXknNxdjCBlt1x9Rhr1KBkt5JyCtYz3Me7h3jcbmY3YoY5l2Lv8Yi8qx8qbU6vGl8B85zhwPV2NqTbIeXncD+YP+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1q27h+su; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eE7mu/NX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720990207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=VDyOQkiqypmhYGWdsDOzrP60cPjv8+hZ+2MyaiOPTNU=;
	b=1q27h+su7QFcZQx7nvy21BQlh56jUdRVBJ2ZrBcmg0M5C5xcq+Zh1ippBjGw8oqaJf4ore
	wwSGZ7yf8Qt3BSwfUB8dquxFz6PvOca74Buz37t/DEG73sGMGri0dBDLYtyznorW7Dq/Nm
	n2ZE2NMQbcDF0WEIu7+ONMOioWxza1NMSqCJ8CveRsQUDUS0nlmTZd6wzT7P49ILGQ2Iz7
	XOAeTkrXs6cnZa0eqXMziLQ3OyKmtm1sCeoNCWnQ/Nz71tCfO4+s1bdwspy0xE5BQ3KI1k
	Kb+luoGuzvrmbG1BRzqR8VrAd7Sb0qkVCBX6D5RRTSlj9VGl6wP76bu7kzyhqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720990207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=VDyOQkiqypmhYGWdsDOzrP60cPjv8+hZ+2MyaiOPTNU=;
	b=eE7mu/NXSkE5T5BrrMoQ88/LVPjobylvyKRRLEjPM9zYcJRA+7YVJpb6/hxQK3PhjoqmDi
	GXXQg9Sfw3EFvVBw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for v6.11-rc1
References: <172099001487.1942258.17671805941963584080.tglx@xen13>
Message-ID: <172099001665.1942258.758282869896052475.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 14 Jul 2024 22:50:06 +0200 (CEST)

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2024-07=
-14

up to:  faf243d11659: Merge branch 'irq/msi' into irq/core

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

  - MSI

    - Switch ARM/ARM64 over to the modern per device MSI domains.

      This simplifies the handling of platform MSI and wire to MSI
      controllers and removes about 500 lines of legacy code.

      Aside of that it paves the way for ARM/ARM64 to utilize the dynamic
      allocation of PCI/MSI interrupts and to support the upcoming non
      standard IMS (Interrupt Message Store) mechanism on PCIe devices

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

Anna-Maria Behnsen (2):
      irqchip/imx-mu-msi: Fix codingstyle in imx_mu_msi_domains_init()
      irqdomain: Fix formatting irq_find_matching_fwspec() kerneldoc comment

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

Shivamurthy Shastri (1):
      PCI/MSI: Provide MSI_FLAG_PCI_MSI_MASK_PARENT

Stefan Wahren (1):
      irqchip/bcm2835: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND

Thomas Gleixner (23):
      irqdomain: Make build work for CONFIG_GENERIC_IRQ_CHIP=3Dn
      Revert "Loongarch: Support loongarch avec"
      Revert "irqchip/dw-apb-ictl: Support building as module"
      irqchip: Provide irq-msi-lib
      irqchip/gic-v3-its: Provide MSI parent infrastructure
      irqchip/irq-msi-lib: Prepare for PCI MSI/MSIX
      irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]
      irqchip/irq-msi-lib: Prepare for DEVICE MSI to replace platform MSI
      irqchip/mbigen: Prepare for real per device MSI
      irqchip/irq-msi-lib: Prepare for DOMAIN_BUS_WIRED_TO_MSI
      irqchip/gic-v3-its: Switch platform MSI to MSI parent
      irqchip/mbigen: Remove platform_msi_create_device_domain() fallback
      genirq/msi: Remove platform_msi_create_device_domain()
      irqchip/gic_v3_mbi: Switch over to parent domain
      irqchip/gic-v2m: Switch to device MSI
      irqchip/imx-mu-msi: Switch to MSI parent
      irqchip/irq-mvebu-icu: Prepare for real per device MSI
      irqchip/mvebu-gicp: Switch to MSI parent
      irqchip/mvebu-odmi: Switch to parent MSI
      irqchip/irq-mvebu-sei: Switch to MSI parent
      irqchip/irq-mvebu-icu: Remove platform MSI leftovers
      genirq/msi: Remove platform MSI leftovers
      genirq/msi: Move msi_device_data to core

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
 drivers/base/platform-msi.c                        | 350 +---------
 drivers/irqchip/Kconfig                            |  29 +
 drivers/irqchip/Makefile                           |   6 +-
 drivers/irqchip/irq-armada-370-xp.c                | 121 +++-
 drivers/irqchip/irq-bcm2835.c                      |   4 +-
 drivers/irqchip/irq-gic-common.h                   |   3 +
 drivers/irqchip/irq-gic-v2m.c                      |  81 +--
 drivers/irqchip/irq-gic-v3-its-msi-parent.c        | 210 ++++++
 drivers/irqchip/irq-gic-v3-its-pci-msi.c           | 202 ------
 drivers/irqchip/irq-gic-v3-its-platform-msi.c      | 163 -----
 drivers/irqchip/irq-gic-v3-its.c                   |  57 +-
 drivers/irqchip/irq-gic-v3-mbi.c                   | 130 ++--
 drivers/irqchip/irq-gic-v3.c                       |  22 +-
 drivers/irqchip/irq-imx-irqsteer.c                 |  24 +-
 drivers/irqchip/irq-imx-mu-msi.c                   |  54 +-
 drivers/irqchip/irq-lan966x-oic.c                  | 278 ++++++++
 drivers/irqchip/irq-mbigen.c                       |  96 +--
 drivers/irqchip/irq-meson-gpio.c                   |   1 +
 drivers/irqchip/irq-msi-lib.c                      | 140 ++++
 drivers/irqchip/irq-msi-lib.h                      |  27 +
 drivers/irqchip/irq-mvebu-gicp.c                   |  44 +-
 drivers/irqchip/irq-mvebu-icu.c                    | 275 ++++----
 drivers/irqchip/irq-mvebu-odmi.c                   |  37 +-
 drivers/irqchip/irq-mvebu-pic.c                    |   1 +
 drivers/irqchip/irq-mvebu-sei.c                    |  52 +-
 drivers/irqchip/irq-renesas-rzg2l.c                | 150 ++++-
 drivers/irqchip/irq-riscv-aplic-main.c             |  13 +-
 drivers/irqchip/irq-riscv-intc.c                   |   4 +-
 drivers/irqchip/irq-stm32-exti.c                   | 670 +------------------
 drivers/irqchip/irq-stm32mp-exti.c                 | 729 +++++++++++++++++++=
++
 drivers/irqchip/irq-ts4800.c                       |   1 +
 drivers/pci/msi/irqdomain.c                        |  20 +
 include/linux/acpi.h                               |   3 +
 include/linux/interrupt.h                          |   2 +-
 include/linux/irq.h                                |  43 ++
 include/linux/irqchip/arm-gic-v4.h                 |   8 +
 include/linux/irqdomain.h                          | 136 +++-
 include/linux/msi.h                                |  52 +-
 kernel/irq/debugfs.c                               |  10 +-
 kernel/irq/devres.c                                |  41 ++
 kernel/irq/generic-chip.c                          | 111 +++-
 kernel/irq/internals.h                             |  10 +
 kernel/irq/irqdomain.c                             | 290 +++++---
 kernel/irq/msi.c                                   |  95 +--
 kernel/irq/proc.c                                  |   7 +-
 53 files changed, 2712 insertions(+), 2204 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mi=
crochip,lan966x-oic.yaml
 create mode 100644 drivers/irqchip/irq-gic-v3-its-msi-parent.c
 delete mode 100644 drivers/irqchip/irq-gic-v3-its-pci-msi.c
 delete mode 100644 drivers/irqchip/irq-gic-v3-its-platform-msi.c
 create mode 100644 drivers/irqchip/irq-lan966x-oic.c
 create mode 100644 drivers/irqchip/irq-msi-lib.c
 create mode 100644 drivers/irqchip/irq-msi-lib.h
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
index aacccb376c28..57a29adc7a44 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14726,6 +14726,12 @@ L:	netdev@vger.kernel.org
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
diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 11f5fdf65b9e..0e60dd650b5e 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -4,346 +4,12 @@
  *
  * Copyright (C) 2015 ARM Limited, All Rights Reserved.
  * Author: Marc Zyngier <marc.zyngier@arm.com>
+ * Copyright (C) 2022 Linutronix GmbH
  */
=20
 #include <linux/device.h>
-#include <linux/idr.h>
-#include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
-#include <linux/slab.h>
-
-/* Begin of removal area. Once everything is converted over. Cleanup the inc=
ludes too! */
-
-#define DEV_ID_SHIFT	21
-#define MAX_DEV_MSIS	(1 << (32 - DEV_ID_SHIFT))
-
-/*
- * Internal data structure containing a (made up, but unique) devid
- * and the callback to write the MSI message.
- */
-struct platform_msi_priv_data {
-	struct device			*dev;
-	void				*host_data;
-	msi_alloc_info_t		arg;
-	irq_write_msi_msg_t		write_msg;
-	int				devid;
-};
-
-/* The devid allocator */
-static DEFINE_IDA(platform_msi_devid_ida);
-
-#ifdef GENERIC_MSI_DOMAIN_OPS
-/*
- * Convert an msi_desc to a globaly unique identifier (per-device
- * devid + msi_desc position in the msi_list).
- */
-static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
-{
-	u32 devid =3D desc->dev->msi.data->platform_data->devid;
-
-	return (devid << (32 - DEV_ID_SHIFT)) | desc->msi_index;
-}
-
-static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *de=
sc)
-{
-	arg->desc =3D desc;
-	arg->hwirq =3D platform_msi_calc_hwirq(desc);
-}
-
-static int platform_msi_init(struct irq_domain *domain,
-			     struct msi_domain_info *info,
-			     unsigned int virq, irq_hw_number_t hwirq,
-			     msi_alloc_info_t *arg)
-{
-	return irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
-					     info->chip, info->chip_data);
-}
-
-static void platform_msi_set_proxy_dev(msi_alloc_info_t *arg)
-{
-	arg->flags |=3D MSI_ALLOC_FLAGS_PROXY_DEVICE;
-}
-#else
-#define platform_msi_set_desc		NULL
-#define platform_msi_init		NULL
-#define platform_msi_set_proxy_dev(x)	do {} while(0)
-#endif
-
-static void platform_msi_update_dom_ops(struct msi_domain_info *info)
-{
-	struct msi_domain_ops *ops =3D info->ops;
-
-	BUG_ON(!ops);
-
-	if (ops->msi_init =3D=3D NULL)
-		ops->msi_init =3D platform_msi_init;
-	if (ops->set_desc =3D=3D NULL)
-		ops->set_desc =3D platform_msi_set_desc;
-}
-
-static void platform_msi_write_msg(struct irq_data *data, struct msi_msg *ms=
g)
-{
-	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
-
-	desc->dev->msi.data->platform_data->write_msg(desc, msg);
-}
-
-static void platform_msi_update_chip_ops(struct msi_domain_info *info)
-{
-	struct irq_chip *chip =3D info->chip;
-
-	BUG_ON(!chip);
-	if (!chip->irq_mask)
-		chip->irq_mask =3D irq_chip_mask_parent;
-	if (!chip->irq_unmask)
-		chip->irq_unmask =3D irq_chip_unmask_parent;
-	if (!chip->irq_eoi)
-		chip->irq_eoi =3D irq_chip_eoi_parent;
-	if (!chip->irq_set_affinity)
-		chip->irq_set_affinity =3D msi_domain_set_affinity;
-	if (!chip->irq_write_msi_msg)
-		chip->irq_write_msi_msg =3D platform_msi_write_msg;
-	if (WARN_ON((info->flags & MSI_FLAG_LEVEL_CAPABLE) &&
-		    !(chip->flags & IRQCHIP_SUPPORTS_LEVEL_MSI)))
-		info->flags &=3D ~MSI_FLAG_LEVEL_CAPABLE;
-}
-
-/**
- * platform_msi_create_irq_domain - Create a platform MSI interrupt domain
- * @fwnode:		Optional fwnode of the interrupt controller
- * @info:	MSI domain info
- * @parent:	Parent irq domain
- *
- * Updates the domain and chip ops and creates a platform MSI
- * interrupt domain.
- *
- * Returns:
- * A domain pointer or NULL in case of failure.
- */
-struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwno=
de,
-						  struct msi_domain_info *info,
-						  struct irq_domain *parent)
-{
-	struct irq_domain *domain;
-
-	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
-		platform_msi_update_dom_ops(info);
-	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
-		platform_msi_update_chip_ops(info);
-	info->flags |=3D MSI_FLAG_DEV_SYSFS | MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS |
-		       MSI_FLAG_FREE_MSI_DESCS;
-
-	domain =3D msi_create_irq_domain(fwnode, info, parent);
-	if (domain)
-		irq_domain_update_bus_token(domain, DOMAIN_BUS_PLATFORM_MSI);
-
-	return domain;
-}
-EXPORT_SYMBOL_GPL(platform_msi_create_irq_domain);
-
-static int platform_msi_alloc_priv_data(struct device *dev, unsigned int nve=
c,
-					irq_write_msi_msg_t write_msi_msg)
-{
-	struct platform_msi_priv_data *datap;
-	int err;
-
-	/*
-	 * Limit the number of interrupts to 2048 per device. Should we
-	 * need to bump this up, DEV_ID_SHIFT should be adjusted
-	 * accordingly (which would impact the max number of MSI
-	 * capable devices).
-	 */
-	if (!dev->msi.domain || !write_msi_msg || !nvec || nvec > MAX_DEV_MSIS)
-		return -EINVAL;
-
-	if (dev->msi.domain->bus_token !=3D DOMAIN_BUS_PLATFORM_MSI) {
-		dev_err(dev, "Incompatible msi_domain, giving up\n");
-		return -EINVAL;
-	}
-
-	err =3D msi_setup_device_data(dev);
-	if (err)
-		return err;
-
-	/* Already initialized? */
-	if (dev->msi.data->platform_data)
-		return -EBUSY;
-
-	datap =3D kzalloc(sizeof(*datap), GFP_KERNEL);
-	if (!datap)
-		return -ENOMEM;
-
-	datap->devid =3D ida_alloc_max(&platform_msi_devid_ida,
-				     (1 << DEV_ID_SHIFT) - 1, GFP_KERNEL);
-	if (datap->devid < 0) {
-		err =3D datap->devid;
-		kfree(datap);
-		return err;
-	}
-
-	datap->write_msg =3D write_msi_msg;
-	datap->dev =3D dev;
-	dev->msi.data->platform_data =3D datap;
-	return 0;
-}
-
-static void platform_msi_free_priv_data(struct device *dev)
-{
-	struct platform_msi_priv_data *data =3D dev->msi.data->platform_data;
-
-	dev->msi.data->platform_data =3D NULL;
-	ida_free(&platform_msi_devid_ida, data->devid);
-	kfree(data);
-}
-
-/**
- * platform_msi_domain_alloc_irqs - Allocate MSI interrupts for @dev
- * @dev:		The device for which to allocate interrupts
- * @nvec:		The number of interrupts to allocate
- * @write_msi_msg:	Callback to write an interrupt message for @dev
- *
- * Returns:
- * Zero for success, or an error code in case of failure
- */
-static int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int n=
vec,
-					  irq_write_msi_msg_t write_msi_msg)
-{
-	int err;
-
-	err =3D platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
-	if (err)
-		return err;
-
-	err =3D msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN, 0, nvec - 1);
-	if (err)
-		platform_msi_free_priv_data(dev);
-
-	return err;
-}
-
-/**
- * platform_msi_get_host_data - Query the private data associated with
- *                              a platform-msi domain
- * @domain:	The platform-msi domain
- *
- * Return: The private data provided when calling
- * platform_msi_create_device_domain().
- */
-void *platform_msi_get_host_data(struct irq_domain *domain)
-{
-	struct platform_msi_priv_data *data =3D domain->host_data;
-
-	return data->host_data;
-}
-
-static struct lock_class_key platform_device_msi_lock_class;
-
-/**
- * __platform_msi_create_device_domain - Create a platform-msi device domain
- *
- * @dev:		The device generating the MSIs
- * @nvec:		The number of MSIs that need to be allocated
- * @is_tree:		flag to indicate tree hierarchy
- * @write_msi_msg:	Callback to write an interrupt message for @dev
- * @ops:		The hierarchy domain operations to use
- * @host_data:		Private data associated to this domain
- *
- * Return: An irqdomain for @nvec interrupts on success, NULL in case of err=
or.
- *
- * This is for interrupt domains which stack on a platform-msi domain
- * created by platform_msi_create_irq_domain(). @dev->msi.domain points to
- * that platform-msi domain which is the parent for the new domain.
- */
-struct irq_domain *
-__platform_msi_create_device_domain(struct device *dev,
-				    unsigned int nvec,
-				    bool is_tree,
-				    irq_write_msi_msg_t write_msi_msg,
-				    const struct irq_domain_ops *ops,
-				    void *host_data)
-{
-	struct platform_msi_priv_data *data;
-	struct irq_domain *domain;
-	int err;
-
-	err =3D platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
-	if (err)
-		return NULL;
-
-	/*
-	 * Use a separate lock class for the MSI descriptor mutex on
-	 * platform MSI device domains because the descriptor mutex nests
-	 * into the domain mutex. See alloc/free below.
-	 */
-	lockdep_set_class(&dev->msi.data->mutex, &platform_device_msi_lock_class);
-
-	data =3D dev->msi.data->platform_data;
-	data->host_data =3D host_data;
-	domain =3D irq_domain_create_hierarchy(dev->msi.domain, 0,
-					     is_tree ? 0 : nvec,
-					     dev->fwnode, ops, data);
-	if (!domain)
-		goto free_priv;
-
-	platform_msi_set_proxy_dev(&data->arg);
-	err =3D msi_domain_prepare_irqs(domain->parent, dev, nvec, &data->arg);
-	if (err)
-		goto free_domain;
-
-	return domain;
-
-free_domain:
-	irq_domain_remove(domain);
-free_priv:
-	platform_msi_free_priv_data(dev);
-	return NULL;
-}
-
-/**
- * platform_msi_device_domain_free - Free interrupts associated with a platf=
orm-msi
- *				     device domain
- *
- * @domain:	The platform-msi device domain
- * @virq:	The base irq from which to perform the free operation
- * @nr_irqs:	How many interrupts to free from @virq
- */
-void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int=
 virq,
-				     unsigned int nr_irqs)
-{
-	struct platform_msi_priv_data *data =3D domain->host_data;
-
-	msi_lock_descs(data->dev);
-	msi_domain_depopulate_descs(data->dev, virq, nr_irqs);
-	irq_domain_free_irqs_common(domain, virq, nr_irqs);
-	msi_free_msi_descs_range(data->dev, virq, virq + nr_irqs - 1);
-	msi_unlock_descs(data->dev);
-}
-
-/**
- * platform_msi_device_domain_alloc - Allocate interrupts associated with
- *				      a platform-msi device domain
- *
- * @domain:	The platform-msi device domain
- * @virq:	The base irq from which to perform the allocate operation
- * @nr_irqs:	How many interrupts to allocate from @virq
- *
- * Return 0 on success, or an error code on failure. Must be called
- * with irq_domain_mutex held (which can only be done as part of a
- * top-level interrupt allocation).
- */
-int platform_msi_device_domain_alloc(struct irq_domain *domain, unsigned int=
 virq,
-				     unsigned int nr_irqs)
-{
-	struct platform_msi_priv_data *data =3D domain->host_data;
-	struct device *dev =3D data->dev;
-
-	return msi_domain_populate_irqs(domain->parent, dev, virq, nr_irqs, &data->=
arg);
-}
-
-/* End of removal area */
-
-/* Real per device domain interfaces */
=20
 /*
  * This indirection can go when platform_device_msi_init_and_alloc_irqs()
@@ -357,7 +23,7 @@ static void platform_msi_write_msi_msg(struct irq_data *d,=
 struct msi_msg *msg)
 	cb(irq_data_get_msi_desc(d), msg);
 }
=20
-static void platform_msi_set_desc_byindex(msi_alloc_info_t *arg, struct msi_=
desc *desc)
+static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *de=
sc)
 {
 	arg->desc =3D desc;
 	arg->hwirq =3D desc->msi_index;
@@ -373,7 +39,7 @@ static const struct msi_domain_template platform_msi_templ=
ate =3D {
 	},
=20
 	.ops =3D {
-		.set_desc		=3D platform_msi_set_desc_byindex,
+		.set_desc		=3D platform_msi_set_desc,
 	},
=20
 	.info =3D {
@@ -408,10 +74,6 @@ int platform_device_msi_init_and_alloc_irqs(struct device=
 *dev, unsigned int nve
 	if (!domain || !write_msi_msg)
 		return -EINVAL;
=20
-	/* Migration support. Will go away once everything is converted */
-	if (!irq_domain_is_msi_parent(domain))
-		return platform_msi_domain_alloc_irqs(dev, nvec, write_msi_msg);
-
 	/*
 	 * @write_msi_msg is stored in the resulting msi_domain_info::data.
 	 * The underlying domain creation mechanism will assign that
@@ -432,12 +94,6 @@ EXPORT_SYMBOL_GPL(platform_device_msi_init_and_alloc_irqs=
);
  */
 void platform_device_msi_free_irqs_all(struct device *dev)
 {
-	struct irq_domain *domain =3D dev->msi.domain;
-
 	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
-
-	/* Migration support. Will go away once everything is converted */
-	if (!irq_domain_is_msi_parent(domain))
-		platform_msi_free_priv_data(dev);
 }
 EXPORT_SYMBOL_GPL(platform_device_msi_free_irqs_all);
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 14464716bacb..d078bdc48c38 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -26,6 +26,7 @@ config ARM_GIC_V2M
 	bool
 	depends on PCI
 	select ARM_GIC
+	select IRQ_MSI_LIB
 	select PCI_MSI
=20
 config GIC_NON_BANKED
@@ -41,6 +42,7 @@ config ARM_GIC_V3
 config ARM_GIC_V3_ITS
 	bool
 	select GENERIC_MSI_IRQ
+	select IRQ_MSI_LIB
 	default ARM_GIC_V3
=20
 config ARM_GIC_V3_ITS_PCI
@@ -74,6 +76,9 @@ config ARM_VIC_NR
 	  The maximum number of VICs available in the system, for
 	  power management.
=20
+config IRQ_MSI_LIB
+	bool
+
 config ARMADA_370_XP_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
@@ -169,6 +174,18 @@ config IXP4XX_IRQ
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
@@ -366,6 +383,7 @@ config MSCC_OCELOT_IRQ
 	select GENERIC_IRQ_CHIP
=20
 config MVEBU_GICP
+	select IRQ_MSI_LIB
 	bool
=20
 config MVEBU_ICU
@@ -373,6 +391,7 @@ config MVEBU_ICU
=20
 config MVEBU_ODMI
 	bool
+	select IRQ_MSI_LIB
 	select GENERIC_MSI_IRQ
=20
 config MVEBU_PIC
@@ -392,6 +411,15 @@ config LS_SCFG_MSI
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
@@ -487,6 +515,7 @@ config IMX_MU_MSI
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_MSI_IRQ
+	select IRQ_MSI_LIB
 	help
 	  Provide a driver for the i.MX Messaging Unit block used as a
 	  CPU-to-CPU MSI controller. This requires a specially crafted DT
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d9dc3d99aaa8..15635812b2d6 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -29,10 +29,10 @@ obj-$(CONFIG_ARCH_SPEAR3XX)		+=3D spear-shirq.o
 obj-$(CONFIG_ARM_GIC)			+=3D irq-gic.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_PM)		+=3D irq-gic-pm.o
 obj-$(CONFIG_ARCH_REALVIEW)		+=3D irq-gic-realview.o
+obj-$(CONFIG_IRQ_MSI_LIB)		+=3D irq-msi-lib.o
 obj-$(CONFIG_ARM_GIC_V2M)		+=3D irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+=3D irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-common.o
-obj-$(CONFIG_ARM_GIC_V3_ITS)		+=3D irq-gic-v3-its.o irq-gic-v3-its-platform-=
msi.o irq-gic-v4.o
-obj-$(CONFIG_ARM_GIC_V3_ITS_PCI)	+=3D irq-gic-v3-its-pci-msi.o
+obj-$(CONFIG_ARM_GIC_V3_ITS)		+=3D irq-gic-v3-its.o irq-gic-v4.o irq-gic-v3-=
its-msi-parent.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+=3D irq-gic-v3-its-fsl-mc-msi.o
 obj-$(CONFIG_PARTITION_PERCPU)		+=3D irq-partition-percpu.o
 obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+=3D irq-mbigen.o
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
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-commo=
n.h
index f407cce9ecaa..eb4a220dd6ad 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -8,6 +8,7 @@
=20
 #include <linux/of.h>
 #include <linux/irqdomain.h>
+#include <linux/msi.h>
 #include <linux/irqchip/arm-gic-common.h>
=20
 struct gic_quirk {
@@ -29,6 +30,8 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *qu=
irks,
 void gic_enable_of_quirks(const struct device_node *np,
 			  const struct gic_quirk *quirks, void *data);
=20
+extern const struct msi_parent_ops gic_v3_its_msi_parent_ops;
+
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING    (1 << 0)
 #define RDIST_FLAGS_RD_TABLES_PREALLOCATED     (1 << 1)
 #define RDIST_FLAGS_FORCE_NON_SHAREABLE        (1 << 2)
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index f2ff4387870d..51af63c046ed 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -26,6 +26,8 @@
 #include <linux/irqchip/arm-gic.h>
 #include <linux/irqchip/arm-gic-common.h>
=20
+#include "irq-msi-lib.h"
+
 /*
 * MSI_TYPER:
 *     [31:26] Reserved
@@ -72,31 +74,6 @@ struct v2m_data {
 	u32 flags;		/* v2m flags for specific implementation */
 };
=20
-static void gicv2m_mask_msi_irq(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void gicv2m_unmask_msi_irq(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip gicv2m_msi_irq_chip =3D {
-	.name			=3D "MSI",
-	.irq_mask		=3D gicv2m_mask_msi_irq,
-	.irq_unmask		=3D gicv2m_unmask_msi_irq,
-	.irq_eoi		=3D irq_chip_eoi_parent,
-};
-
-static struct msi_domain_info gicv2m_msi_domain_info =3D {
-	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
-	.chip	=3D &gicv2m_msi_irq_chip,
-};
-
 static phys_addr_t gicv2m_get_msi_addr(struct v2m_data *v2m, int hwirq)
 {
 	if (v2m->flags & GICV2M_GRAVITON_ADDRESS_ONLY)
@@ -230,6 +207,7 @@ static void gicv2m_irq_domain_free(struct irq_domain *dom=
ain,
 }
=20
 static const struct irq_domain_ops gicv2m_domain_ops =3D {
+	.select			=3D msi_lib_irq_domain_select,
 	.alloc			=3D gicv2m_irq_domain_alloc,
 	.free			=3D gicv2m_irq_domain_free,
 };
@@ -250,19 +228,6 @@ static bool is_msi_spi_valid(u32 base, u32 num)
 	return true;
 }
=20
-static struct irq_chip gicv2m_pmsi_irq_chip =3D {
-	.name			=3D "pMSI",
-};
-
-static struct msi_domain_ops gicv2m_pmsi_ops =3D {
-};
-
-static struct msi_domain_info gicv2m_pmsi_domain_info =3D {
-	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
-	.ops	=3D &gicv2m_pmsi_ops,
-	.chip	=3D &gicv2m_pmsi_irq_chip,
-};
-
 static void __init gicv2m_teardown(void)
 {
 	struct v2m_data *v2m, *tmp;
@@ -278,9 +243,27 @@ static void __init gicv2m_teardown(void)
 	}
 }
=20
+
+#define GICV2M_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |		\
+				    MSI_FLAG_USE_DEF_CHIP_OPS |		\
+				    MSI_FLAG_PCI_MSI_MASK_PARENT)
+
+#define GICV2M_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				    MSI_FLAG_PCI_MSIX      |	\
+				    MSI_FLAG_MULTI_PCI_MSI)
+
+static struct msi_parent_ops gicv2m_msi_parent_ops =3D {
+	.supported_flags	=3D GICV2M_MSI_FLAGS_SUPPORTED,
+	.required_flags		=3D GICV2M_MSI_FLAGS_REQUIRED,
+	.bus_select_token	=3D DOMAIN_BUS_NEXUS,
+	.bus_select_mask	=3D MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
+	.prefix			=3D "GICv2m-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
+};
+
 static __init int gicv2m_allocate_domains(struct irq_domain *parent)
 {
-	struct irq_domain *inner_domain, *pci_domain, *plat_domain;
+	struct irq_domain *inner_domain;
 	struct v2m_data *v2m;
=20
 	v2m =3D list_first_entry_or_null(&v2m_nodes, struct v2m_data, entry);
@@ -295,22 +278,8 @@ static __init int gicv2m_allocate_domains(struct irq_dom=
ain *parent)
 	}
=20
 	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
-	pci_domain =3D pci_msi_create_irq_domain(v2m->fwnode,
-					       &gicv2m_msi_domain_info,
-					       inner_domain);
-	plat_domain =3D platform_msi_create_irq_domain(v2m->fwnode,
-						     &gicv2m_pmsi_domain_info,
-						     inner_domain);
-	if (!pci_domain || !plat_domain) {
-		pr_err("Failed to create MSI domains\n");
-		if (plat_domain)
-			irq_domain_remove(plat_domain);
-		if (pci_domain)
-			irq_domain_remove(pci_domain);
-		irq_domain_remove(inner_domain);
-		return -ENOMEM;
-	}
-
+	inner_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
+	inner_domain->msi_parent_ops =3D &gicv2m_msi_parent_ops;
 	return 0;
 }
=20
@@ -511,7 +480,7 @@ acpi_parse_madt_msi(union acpi_subtable_headers *header,
 		pr_info("applying Amazon Graviton quirk\n");
 		res.end =3D res.start + SZ_8K - 1;
 		flags |=3D GICV2M_GRAVITON_ADDRESS_ONLY;
-		gicv2m_msi_domain_info.flags &=3D ~MSI_FLAG_MULTI_PCI_MSI;
+		gicv2m_msi_parent_ops.supported_flags &=3D ~MSI_FLAG_MULTI_PCI_MSI;
 	}
=20
 	if (m->flags & ACPI_MADT_OVERRIDE_SPI_VALUES) {
diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/ir=
q-gic-v3-its-msi-parent.c
new file mode 100644
index 000000000000..780e1bc9df54
--- /dev/null
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2013-2015 ARM Limited, All Rights Reserved.
+// Author: Marc Zyngier <marc.zyngier@arm.com>
+// Copyright (C) 2022 Linutronix GmbH
+// Copyright (C) 2022 Intel
+
+#include <linux/acpi_iort.h>
+#include <linux/pci.h>
+
+#include "irq-gic-common.h"
+#include "irq-msi-lib.h"
+
+#define ITS_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				 MSI_FLAG_USE_DEF_CHIP_OPS |	\
+				 MSI_FLAG_PCI_MSI_MASK_PARENT)
+
+#define ITS_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				 MSI_FLAG_PCI_MSIX      |	\
+				 MSI_FLAG_MULTI_PCI_MSI)
+
+#ifdef CONFIG_PCI_MSI
+static int its_pci_msi_vec_count(struct pci_dev *pdev, void *data)
+{
+	int msi, msix, *count =3D data;
+
+	msi =3D max(pci_msi_vec_count(pdev), 0);
+	msix =3D max(pci_msix_vec_count(pdev), 0);
+	*count +=3D max(msi, msix);
+
+	return 0;
+}
+
+static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct pci_dev **alias_dev =3D data;
+
+	*alias_dev =3D pdev;
+
+	return 0;
+}
+
+static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
+			       int nvec, msi_alloc_info_t *info)
+{
+	struct pci_dev *pdev, *alias_dev;
+	struct msi_domain_info *msi_info;
+	int alias_count =3D 0, minnvec =3D 1;
+
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	pdev =3D to_pci_dev(dev);
+	/*
+	 * If pdev is downstream of any aliasing bridges, take an upper
+	 * bound of how many other vectors could map to the same DevID.
+	 * Also tell the ITS that the signalling will come from a proxy
+	 * device, and that special allocation rules apply.
+	 */
+	pci_for_each_dma_alias(pdev, its_get_pci_alias, &alias_dev);
+	if (alias_dev !=3D pdev) {
+		if (alias_dev->subordinate)
+			pci_walk_bus(alias_dev->subordinate,
+				     its_pci_msi_vec_count, &alias_count);
+		info->flags |=3D MSI_ALLOC_FLAGS_PROXY_DEVICE;
+	}
+
+	/* ITS specific DeviceID, as the core ITS ignores dev. */
+	info->scratchpad[0].ul =3D pci_msi_domain_get_msi_rid(domain, pdev);
+
+	/*
+	 * @domain->msi_domain_info->hwsize contains the size of the
+	 * MSI[-X] domain, but vector allocation happens one by one. This
+	 * needs some thought when MSI comes into play as the size of MSI
+	 * might be unknown at domain creation time and therefore set to
+	 * MSI_MAX_INDEX.
+	 */
+	msi_info =3D msi_get_domain_info(domain);
+	if (msi_info->hwsize > nvec)
+		nvec =3D msi_info->hwsize;
+
+	/*
+	 * Always allocate a power of 2, and special case device 0 for
+	 * broken systems where the DevID is not wired (and all devices
+	 * appear as DevID 0). For that reason, we generously allocate a
+	 * minimum of 32 MSIs for DevID 0. If you want more because all
+	 * your devices are aliasing to DevID 0, consider fixing your HW.
+	 */
+	nvec =3D max(nvec, alias_count);
+	if (!info->scratchpad[0].ul)
+		minnvec =3D 32;
+	nvec =3D max_t(int, minnvec, roundup_pow_of_two(nvec));
+
+	msi_info =3D msi_get_domain_info(domain->parent);
+	return msi_info->ops->msi_prepare(domain->parent, dev, nvec, info);
+}
+#else /* CONFIG_PCI_MSI */
+#define its_pci_msi_prepare	NULL
+#endif /* !CONFIG_PCI_MSI */
+
+static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
+				  u32 *dev_id)
+{
+	int ret, index =3D 0;
+
+	/* Suck the DeviceID out of the msi-parent property */
+	do {
+		struct of_phandle_args args;
+
+		ret =3D of_parse_phandle_with_args(dev->of_node,
+						 "msi-parent", "#msi-cells",
+						 index, &args);
+		if (args.np =3D=3D irq_domain_get_of_node(domain)) {
+			if (WARN_ON(args.args_count !=3D 1))
+				return -EINVAL;
+			*dev_id =3D args.args[0];
+			break;
+		}
+		index++;
+	} while (!ret);
+
+	return ret;
+}
+
+int __weak iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
+{
+	return -1;
+}
+
+static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
+			    int nvec, msi_alloc_info_t *info)
+{
+	struct msi_domain_info *msi_info;
+	u32 dev_id;
+	int ret;
+
+	if (dev->of_node)
+		ret =3D of_pmsi_get_dev_id(domain, dev, &dev_id);
+	else
+		ret =3D iort_pmsi_get_dev_id(dev, &dev_id);
+	if (ret)
+		return ret;
+
+	/* ITS specific DeviceID, as the core ITS ignores dev. */
+	info->scratchpad[0].ul =3D dev_id;
+
+	/*
+	 * @domain->msi_domain_info->hwsize contains the size of the device
+	 * domain, but vector allocation happens one by one.
+	 */
+	msi_info =3D msi_get_domain_info(domain);
+	if (msi_info->hwsize > nvec)
+		nvec =3D msi_info->hwsize;
+
+	/* Allocate at least 32 MSIs, and always as a power of 2 */
+	nvec =3D max_t(int, 32, roundup_pow_of_two(nvec));
+
+	msi_info =3D msi_get_domain_info(domain->parent);
+	return msi_info->ops->msi_prepare(domain->parent,
+					  dev, nvec, info);
+}
+
+static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *dom=
ain,
+				  struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
+
+	switch(info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		/*
+		 * FIXME: This probably should be done after a (not yet
+		 * existing) post domain creation callback once to make
+		 * support for dynamic post-enable MSI-X allocations
+		 * work without having to reevaluate the domain size
+		 * over and over. It is known already at allocation
+		 * time via info->hwsize.
+		 *
+		 * That should work perfectly fine for MSI/MSI-X but needs
+		 * some thoughts for purely software managed MSI domains
+		 * where the index space is only limited artificially via
+		 * %MSI_MAX_INDEX.
+		 */
+		info->ops->msi_prepare =3D its_pci_msi_prepare;
+		break;
+	case DOMAIN_BUS_DEVICE_MSI:
+	case DOMAIN_BUS_WIRED_TO_MSI:
+		/*
+		 * FIXME: See the above PCI prepare comment. The domain
+		 * size is also known at domain creation time.
+		 */
+		info->ops->msi_prepare =3D its_pmsi_prepare;
+		break;
+	default:
+		/* Confused. How did the lib return true? */
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	return true;
+}
+
+const struct msi_parent_ops gic_v3_its_msi_parent_ops =3D {
+	.supported_flags	=3D ITS_MSI_FLAGS_SUPPORTED,
+	.required_flags		=3D ITS_MSI_FLAGS_REQUIRED,
+	.bus_select_token	=3D DOMAIN_BUS_NEXUS,
+	.bus_select_mask	=3D MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
+	.prefix			=3D "ITS-",
+	.init_dev_msi_info	=3D its_init_dev_msi_info,
+};
diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-g=
ic-v3-its-pci-msi.c
deleted file mode 100644
index 93f77a8196da..000000000000
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ /dev/null
@@ -1,202 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2013-2015 ARM Limited, All Rights Reserved.
- * Author: Marc Zyngier <marc.zyngier@arm.com>
- */
-
-#include <linux/acpi_iort.h>
-#include <linux/pci.h>
-#include <linux/msi.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
-#include <linux/of_pci.h>
-
-static void its_mask_msi_irq(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void its_unmask_msi_irq(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip its_msi_irq_chip =3D {
-	.name			=3D "ITS-MSI",
-	.irq_unmask		=3D its_unmask_msi_irq,
-	.irq_mask		=3D its_mask_msi_irq,
-	.irq_eoi		=3D irq_chip_eoi_parent,
-};
-
-static int its_pci_msi_vec_count(struct pci_dev *pdev, void *data)
-{
-	int msi, msix, *count =3D data;
-
-	msi =3D max(pci_msi_vec_count(pdev), 0);
-	msix =3D max(pci_msix_vec_count(pdev), 0);
-	*count +=3D max(msi, msix);
-
-	return 0;
-}
-
-static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
-{
-	struct pci_dev **alias_dev =3D data;
-
-	*alias_dev =3D pdev;
-
-	return 0;
-}
-
-static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
-			       int nvec, msi_alloc_info_t *info)
-{
-	struct pci_dev *pdev, *alias_dev;
-	struct msi_domain_info *msi_info;
-	int alias_count =3D 0, minnvec =3D 1;
-
-	if (!dev_is_pci(dev))
-		return -EINVAL;
-
-	msi_info =3D msi_get_domain_info(domain->parent);
-
-	pdev =3D to_pci_dev(dev);
-	/*
-	 * If pdev is downstream of any aliasing bridges, take an upper
-	 * bound of how many other vectors could map to the same DevID.
-	 * Also tell the ITS that the signalling will come from a proxy
-	 * device, and that special allocation rules apply.
-	 */
-	pci_for_each_dma_alias(pdev, its_get_pci_alias, &alias_dev);
-	if (alias_dev !=3D pdev) {
-		if (alias_dev->subordinate)
-			pci_walk_bus(alias_dev->subordinate,
-				     its_pci_msi_vec_count, &alias_count);
-		info->flags |=3D MSI_ALLOC_FLAGS_PROXY_DEVICE;
-	}
-
-	/* ITS specific DeviceID, as the core ITS ignores dev. */
-	info->scratchpad[0].ul =3D pci_msi_domain_get_msi_rid(domain, pdev);
-
-	/*
-	 * Always allocate a power of 2, and special case device 0 for
-	 * broken systems where the DevID is not wired (and all devices
-	 * appear as DevID 0). For that reason, we generously allocate a
-	 * minimum of 32 MSIs for DevID 0. If you want more because all
-	 * your devices are aliasing to DevID 0, consider fixing your HW.
-	 */
-	nvec =3D max(nvec, alias_count);
-	if (!info->scratchpad[0].ul)
-		minnvec =3D 32;
-	nvec =3D max_t(int, minnvec, roundup_pow_of_two(nvec));
-	return msi_info->ops->msi_prepare(domain->parent, dev, nvec, info);
-}
-
-static struct msi_domain_ops its_pci_msi_ops =3D {
-	.msi_prepare	=3D its_pci_msi_prepare,
-};
-
-static struct msi_domain_info its_pci_msi_domain_info =3D {
-	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
-	.ops	=3D &its_pci_msi_ops,
-	.chip	=3D &its_msi_irq_chip,
-};
-
-static struct of_device_id its_device_id[] =3D {
-	{	.compatible	=3D "arm,gic-v3-its",	},
-	{},
-};
-
-static int __init its_pci_msi_init_one(struct fwnode_handle *handle,
-				       const char *name)
-{
-	struct irq_domain *parent;
-
-	parent =3D irq_find_matching_fwnode(handle, DOMAIN_BUS_NEXUS);
-	if (!parent || !msi_get_domain_info(parent)) {
-		pr_err("%s: Unable to locate ITS domain\n", name);
-		return -ENXIO;
-	}
-
-	if (!pci_msi_create_irq_domain(handle, &its_pci_msi_domain_info,
-				       parent)) {
-		pr_err("%s: Unable to create PCI domain\n", name);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static int __init its_pci_of_msi_init(void)
-{
-	struct device_node *np;
-
-	for (np =3D of_find_matching_node(NULL, its_device_id); np;
-	     np =3D of_find_matching_node(np, its_device_id)) {
-		if (!of_device_is_available(np))
-			continue;
-		if (!of_property_read_bool(np, "msi-controller"))
-			continue;
-
-		if (its_pci_msi_init_one(of_node_to_fwnode(np), np->full_name))
-			continue;
-
-		pr_info("PCI/MSI: %pOF domain created\n", np);
-	}
-
-	return 0;
-}
-
-#ifdef CONFIG_ACPI
-
-static int __init
-its_pci_msi_parse_madt(union acpi_subtable_headers *header,
-		       const unsigned long end)
-{
-	struct acpi_madt_generic_translator *its_entry;
-	struct fwnode_handle *dom_handle;
-	const char *node_name;
-	int err =3D -ENXIO;
-
-	its_entry =3D (struct acpi_madt_generic_translator *)header;
-	node_name =3D kasprintf(GFP_KERNEL, "ITS@0x%lx",
-			      (long)its_entry->base_address);
-	dom_handle =3D iort_find_domain_token(its_entry->translation_id);
-	if (!dom_handle) {
-		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
-		goto out;
-	}
-
-	err =3D its_pci_msi_init_one(dom_handle, node_name);
-	if (!err)
-		pr_info("PCI/MSI: %s domain created\n", node_name);
-
-out:
-	kfree(node_name);
-	return err;
-}
-
-static int __init its_pci_acpi_msi_init(void)
-{
-	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
-			      its_pci_msi_parse_madt, 0);
-	return 0;
-}
-#else
-static int __init its_pci_acpi_msi_init(void)
-{
-	return 0;
-}
-#endif
-
-static int __init its_pci_msi_init(void)
-{
-	its_pci_of_msi_init();
-	its_pci_acpi_msi_init();
-
-	return 0;
-}
-early_initcall(its_pci_msi_init);
diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/=
irq-gic-v3-its-platform-msi.c
deleted file mode 100644
index daa6d5053bc3..000000000000
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ /dev/null
@@ -1,163 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2013-2015 ARM Limited, All Rights Reserved.
- * Author: Marc Zyngier <marc.zyngier@arm.com>
- */
-
-#include <linux/acpi_iort.h>
-#include <linux/device.h>
-#include <linux/msi.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
-
-static struct irq_chip its_pmsi_irq_chip =3D {
-	.name			=3D "ITS-pMSI",
-};
-
-static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
-				  u32 *dev_id)
-{
-	int ret, index =3D 0;
-
-	/* Suck the DeviceID out of the msi-parent property */
-	do {
-		struct of_phandle_args args;
-
-		ret =3D of_parse_phandle_with_args(dev->of_node,
-						 "msi-parent", "#msi-cells",
-						 index, &args);
-		if (args.np =3D=3D irq_domain_get_of_node(domain)) {
-			if (WARN_ON(args.args_count !=3D 1))
-				return -EINVAL;
-			*dev_id =3D args.args[0];
-			break;
-		}
-		index++;
-	} while (!ret);
-
-	return ret;
-}
-
-int __weak iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
-{
-	return -1;
-}
-
-static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
-			    int nvec, msi_alloc_info_t *info)
-{
-	struct msi_domain_info *msi_info;
-	u32 dev_id;
-	int ret;
-
-	msi_info =3D msi_get_domain_info(domain->parent);
-
-	if (dev->of_node)
-		ret =3D of_pmsi_get_dev_id(domain, dev, &dev_id);
-	else
-		ret =3D iort_pmsi_get_dev_id(dev, &dev_id);
-	if (ret)
-		return ret;
-
-	/* ITS specific DeviceID, as the core ITS ignores dev. */
-	info->scratchpad[0].ul =3D dev_id;
-
-	/* Allocate at least 32 MSIs, and always as a power of 2 */
-	nvec =3D max_t(int, 32, roundup_pow_of_two(nvec));
-	return msi_info->ops->msi_prepare(domain->parent,
-					  dev, nvec, info);
-}
-
-static struct msi_domain_ops its_pmsi_ops =3D {
-	.msi_prepare	=3D its_pmsi_prepare,
-};
-
-static struct msi_domain_info its_pmsi_domain_info =3D {
-	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
-	.ops	=3D &its_pmsi_ops,
-	.chip	=3D &its_pmsi_irq_chip,
-};
-
-static const struct of_device_id its_device_id[] =3D {
-	{	.compatible	=3D "arm,gic-v3-its",	},
-	{},
-};
-
-static int __init its_pmsi_init_one(struct fwnode_handle *fwnode,
-				const char *name)
-{
-	struct irq_domain *parent;
-
-	parent =3D irq_find_matching_fwnode(fwnode, DOMAIN_BUS_NEXUS);
-	if (!parent || !msi_get_domain_info(parent)) {
-		pr_err("%s: unable to locate ITS domain\n", name);
-		return -ENXIO;
-	}
-
-	if (!platform_msi_create_irq_domain(fwnode, &its_pmsi_domain_info,
-					    parent)) {
-		pr_err("%s: unable to create platform domain\n", name);
-		return -ENXIO;
-	}
-
-	pr_info("Platform MSI: %s domain created\n", name);
-	return 0;
-}
-
-#ifdef CONFIG_ACPI
-static int __init
-its_pmsi_parse_madt(union acpi_subtable_headers *header,
-			const unsigned long end)
-{
-	struct acpi_madt_generic_translator *its_entry;
-	struct fwnode_handle *domain_handle;
-	const char *node_name;
-	int err =3D -ENXIO;
-
-	its_entry =3D (struct acpi_madt_generic_translator *)header;
-	node_name =3D kasprintf(GFP_KERNEL, "ITS@0x%lx",
-			      (long)its_entry->base_address);
-	domain_handle =3D iort_find_domain_token(its_entry->translation_id);
-	if (!domain_handle) {
-		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
-		goto out;
-	}
-
-	err =3D its_pmsi_init_one(domain_handle, node_name);
-
-out:
-	kfree(node_name);
-	return err;
-}
-
-static void __init its_pmsi_acpi_init(void)
-{
-	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
-			      its_pmsi_parse_madt, 0);
-}
-#else
-static inline void its_pmsi_acpi_init(void) { }
-#endif
-
-static void __init its_pmsi_of_init(void)
-{
-	struct device_node *np;
-
-	for (np =3D of_find_matching_node(NULL, its_device_id); np;
-	     np =3D of_find_matching_node(np, its_device_id)) {
-		if (!of_device_is_available(np))
-			continue;
-		if (!of_property_read_bool(np, "msi-controller"))
-			continue;
-
-		its_pmsi_init_one(of_node_to_fwnode(np), np->full_name);
-	}
-}
-
-static int __init its_pmsi_init(void)
-{
-	its_pmsi_of_init();
-	its_pmsi_acpi_init();
-	return 0;
-}
-early_initcall(its_pmsi_init);
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index 3c755d5dad6e..18cb551889e9 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -38,6 +38,7 @@
 #include <asm/exception.h>
=20
 #include "irq-gic-common.h"
+#include "irq-msi-lib.h"
=20
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
@@ -1317,7 +1318,6 @@ static void its_send_vmovp(struct its_vpe *vpe)
 {
 	struct its_cmd_desc desc =3D {};
 	struct its_node *its;
-	unsigned long flags;
 	int col_id =3D vpe->col_idx;
=20
 	desc.its_vmovp_cmd.vpe =3D vpe;
@@ -1329,6 +1329,12 @@ static void its_send_vmovp(struct its_vpe *vpe)
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
@@ -1337,8 +1343,7 @@ static void its_send_vmovp(struct its_vpe *vpe)
 	 *
 	 * Wall <-- Head.
 	 */
-	raw_spin_lock_irqsave(&vmovp_lock, flags);
-
+	guard(raw_spinlock)(&vmovp_lock);
 	desc.its_vmovp_cmd.seq_num =3D vmovp_seq_num++;
 	desc.its_vmovp_cmd.its_list =3D get_its_list(vpe->its_vm);
=20
@@ -1353,8 +1358,6 @@ static void its_send_vmovp(struct its_vpe *vpe)
 		desc.its_vmovp_cmd.col =3D &its->collections[col_id];
 		its_send_single_vcommand(its, its_build_vmovp_cmd, &desc);
 	}
-
-	raw_spin_unlock_irqrestore(&vmovp_lock, flags);
 }
=20
 static void its_send_vinvall(struct its_node *its, struct its_vpe *vpe)
@@ -1791,12 +1794,10 @@ static bool gic_requires_eager_mapping(void)
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
@@ -1809,37 +1810,31 @@ static void its_map_vm(struct its_node *its, struct i=
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
@@ -3688,6 +3683,7 @@ static void its_irq_domain_free(struct irq_domain *doma=
in, unsigned int virq,
 }
=20
 static const struct irq_domain_ops its_domain_ops =3D {
+	.select			=3D msi_lib_irq_domain_select,
 	.alloc			=3D its_irq_domain_alloc,
 	.free			=3D its_irq_domain_free,
 	.activate		=3D its_irq_domain_activate,
@@ -3926,6 +3922,8 @@ static void its_vpe_invall(struct its_vpe *vpe)
 {
 	struct its_node *its;
=20
+	guard(raw_spinlock_irqsave)(&vpe->its_vm->vmapp_lock);
+
 	list_for_each_entry(its, &its_nodes, entry) {
 		if (!is_v4(its))
 			continue;
@@ -4531,6 +4529,7 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *=
domain, unsigned int virq
 	vm->db_lpi_base =3D base;
 	vm->nr_db_lpis =3D nr_ids;
 	vm->vprop_page =3D vprop_page;
+	raw_spin_lock_init(&vm->vmapp_lock);
=20
 	if (gic_rdists->has_rvpeid)
 		irqchip =3D &its_vpe_4_1_irq_chip;
@@ -4562,6 +4561,10 @@ static int its_vpe_irq_domain_activate(struct irq_doma=
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
@@ -4570,9 +4573,6 @@ static int its_vpe_irq_domain_activate(struct irq_domai=
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
@@ -4581,8 +4581,6 @@ static int its_vpe_irq_domain_activate(struct irq_domai=
n *domain,
 		its_send_vinvall(its, vpe);
 	}
=20
-	irq_data_update_effective_affinity(d, cpumask_of(vpe->col_idx));
-
 	return 0;
 }
=20
@@ -4993,6 +4991,9 @@ static int its_init_domain(struct its_node *its)
=20
 	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
=20
+	inner_domain->msi_parent_ops =3D &gic_v3_its_msi_parent_ops;
+	inner_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
+
 	return 0;
 }
=20
@@ -5580,6 +5581,10 @@ static int __init gic_acpi_parse_madt_its(union acpi_s=
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
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mb=
i.c
index dbb8b1efda44..3fe870f8ee17 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -18,6 +18,8 @@
=20
 #include <linux/irqchip/arm-gic-v3.h>
=20
+#include "irq-msi-lib.h"
+
 struct mbi_range {
 	u32			spi_start;
 	u32			nr_spis;
@@ -138,6 +140,7 @@ static void mbi_irq_domain_free(struct irq_domain *domain,
 }
=20
 static const struct irq_domain_ops mbi_domain_ops =3D {
+	.select			=3D msi_lib_irq_domain_select,
 	.alloc			=3D mbi_irq_domain_alloc,
 	.free			=3D mbi_irq_domain_free,
 };
@@ -151,54 +154,6 @@ static void mbi_compose_msi_msg(struct irq_data *data, s=
truct msi_msg *msg)
 	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
 }
=20
-#ifdef CONFIG_PCI_MSI
-/* PCI-specific irqchip */
-static void mbi_mask_msi_irq(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void mbi_unmask_msi_irq(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip mbi_msi_irq_chip =3D {
-	.name			=3D "MSI",
-	.irq_mask		=3D mbi_mask_msi_irq,
-	.irq_unmask		=3D mbi_unmask_msi_irq,
-	.irq_eoi		=3D irq_chip_eoi_parent,
-	.irq_compose_msi_msg	=3D mbi_compose_msi_msg,
-};
-
-static struct msi_domain_info mbi_msi_domain_info =3D {
-	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
-	.chip	=3D &mbi_msi_irq_chip,
-};
-
-static int mbi_allocate_pci_domain(struct irq_domain *nexus_domain,
-				   struct irq_domain **pci_domain)
-{
-	*pci_domain =3D pci_msi_create_irq_domain(nexus_domain->parent->fwnode,
-						&mbi_msi_domain_info,
-						nexus_domain);
-	if (!*pci_domain)
-		return -ENOMEM;
-
-	return 0;
-}
-#else
-static int mbi_allocate_pci_domain(struct irq_domain *nexus_domain,
-				   struct irq_domain **pci_domain)
-{
-	*pci_domain =3D NULL;
-	return 0;
-}
-#endif
-
 static void mbi_compose_mbi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	mbi_compose_msi_msg(data, msg);
@@ -210,28 +165,51 @@ static void mbi_compose_mbi_msg(struct irq_data *data, =
struct msi_msg *msg)
 	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), &msg[1]);
 }
=20
-/* Platform-MSI specific irqchip */
-static struct irq_chip mbi_pmsi_irq_chip =3D {
-	.name			=3D "pMSI",
-	.irq_set_type		=3D irq_chip_set_type_parent,
-	.irq_compose_msi_msg	=3D mbi_compose_mbi_msg,
-	.flags			=3D IRQCHIP_SUPPORTS_LEVEL_MSI,
-};
-
-static struct msi_domain_ops mbi_pmsi_ops =3D {
-};
+static bool mbi_init_dev_msi_info(struct device *dev, struct irq_domain *dom=
ain,
+				  struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
+
+	switch (info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		info->chip->irq_compose_msi_msg =3D mbi_compose_msi_msg;
+		return true;
+
+	case DOMAIN_BUS_DEVICE_MSI:
+		info->chip->irq_compose_msi_msg =3D mbi_compose_mbi_msg;
+		info->chip->irq_set_type =3D irq_chip_set_type_parent;
+		info->chip->flags |=3D IRQCHIP_SUPPORTS_LEVEL_MSI;
+		info->flags |=3D MSI_FLAG_LEVEL_CAPABLE;
+		return true;
+
+	default:
+		WARN_ON_ONCE(1);
+		return false;
+	}
+}
=20
-static struct msi_domain_info mbi_pmsi_domain_info =3D {
-	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_LEVEL_CAPABLE),
-	.ops	=3D &mbi_pmsi_ops,
-	.chip	=3D &mbi_pmsi_irq_chip,
+#define MBI_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				 MSI_FLAG_USE_DEF_CHIP_OPS |	\
+				 MSI_FLAG_PCI_MSI_MASK_PARENT)
+
+#define MBI_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				 MSI_FLAG_PCI_MSIX      |	\
+				 MSI_FLAG_MULTI_PCI_MSI)
+
+static const struct msi_parent_ops gic_v3_mbi_msi_parent_ops =3D {
+	.supported_flags	=3D MBI_MSI_FLAGS_SUPPORTED,
+	.required_flags		=3D MBI_MSI_FLAGS_REQUIRED,
+	.bus_select_token	=3D DOMAIN_BUS_NEXUS,
+	.bus_select_mask	=3D MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
+	.prefix			=3D "MBI-",
+	.init_dev_msi_info	=3D mbi_init_dev_msi_info,
 };
=20
-static int mbi_allocate_domains(struct irq_domain *parent)
+static int mbi_allocate_domain(struct irq_domain *parent)
 {
-	struct irq_domain *nexus_domain, *pci_domain, *plat_domain;
-	int err;
+	struct irq_domain *nexus_domain;
=20
 	nexus_domain =3D irq_domain_create_hierarchy(parent, 0, 0, parent->fwnode,
 						   &mbi_domain_ops, NULL);
@@ -239,22 +217,8 @@ static int mbi_allocate_domains(struct irq_domain *paren=
t)
 		return -ENOMEM;
=20
 	irq_domain_update_bus_token(nexus_domain, DOMAIN_BUS_NEXUS);
-
-	err =3D mbi_allocate_pci_domain(nexus_domain, &pci_domain);
-
-	plat_domain =3D platform_msi_create_irq_domain(parent->fwnode,
-						     &mbi_pmsi_domain_info,
-						     nexus_domain);
-
-	if (err || !plat_domain) {
-		if (plat_domain)
-			irq_domain_remove(plat_domain);
-		if (pci_domain)
-			irq_domain_remove(pci_domain);
-		irq_domain_remove(nexus_domain);
-		return -ENOMEM;
-	}
-
+	nexus_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
+	nexus_domain->msi_parent_ops =3D &gic_v3_mbi_msi_parent_ops;
 	return 0;
 }
=20
@@ -317,7 +281,7 @@ int __init mbi_init(struct fwnode_handle *fwnode, struct =
irq_domain *parent)
=20
 	pr_info("Using MBI frame %pa\n", &mbi_phys_base);
=20
-	ret =3D mbi_allocate_domains(parent);
+	ret =3D mbi_allocate_domain(parent);
 	if (ret)
 		goto err_free_mbi;
=20
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
diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-ms=
i.c
index 90d41c1407ac..4342a21de1eb 100644
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -24,6 +24,8 @@
 #include <linux/pm_domain.h>
 #include <linux/spinlock.h>
=20
+#include "irq-msi-lib.h"
+
 #define IMX_MU_CHANS            4
=20
 enum imx_mu_xcr {
@@ -114,20 +116,6 @@ static void imx_mu_msi_parent_ack_irq(struct irq_data *d=
ata)
 	imx_mu_read(msi_data, msi_data->cfg->xRR + data->hwirq * 4);
 }
=20
-static struct irq_chip imx_mu_msi_irq_chip =3D {
-	.name =3D "MU-MSI",
-	.irq_ack =3D irq_chip_ack_parent,
-};
-
-static struct msi_domain_ops imx_mu_msi_irq_ops =3D {
-};
-
-static struct msi_domain_info imx_mu_msi_domain_info =3D {
-	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
-	.ops	=3D &imx_mu_msi_irq_ops,
-	.chip	=3D &imx_mu_msi_irq_chip,
-};
-
 static void imx_mu_msi_parent_compose_msg(struct irq_data *data,
 					  struct msi_msg *msg)
 {
@@ -195,6 +183,7 @@ static void imx_mu_msi_domain_irq_free(struct irq_domain =
*domain,
 }
=20
 static const struct irq_domain_ops imx_mu_msi_domain_ops =3D {
+	.select	=3D msi_lib_irq_domain_select,
 	.alloc	=3D imx_mu_msi_domain_irq_alloc,
 	.free	=3D imx_mu_msi_domain_irq_free,
 };
@@ -216,35 +205,38 @@ static void imx_mu_msi_irq_handler(struct irq_desc *des=
c)
 	chained_irq_exit(chip, desc);
 }
=20
+#define IMX_MU_MSI_FLAGS_REQUIRED	(MSI_FLAG_USE_DEF_DOM_OPS |	\
+					 MSI_FLAG_USE_DEF_CHIP_OPS |	\
+					 MSI_FLAG_PARENT_PM_DEV)
+
+#define IMX_MU_MSI_FLAGS_SUPPORTED	(MSI_GENERIC_FLAGS_MASK)
+
+static const struct msi_parent_ops imx_mu_msi_parent_ops =3D {
+	.supported_flags	=3D IMX_MU_MSI_FLAGS_SUPPORTED,
+	.required_flags		=3D IMX_MU_MSI_FLAGS_REQUIRED,
+	.bus_select_token       =3D DOMAIN_BUS_NEXUS,
+	.bus_select_mask	=3D MATCH_PLATFORM_MSI,
+	.prefix			=3D "MU-MSI-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
+};
+
 static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data, struct devic=
e *dev)
 {
 	struct fwnode_handle *fwnodes =3D dev_fwnode(dev);
 	struct irq_domain *parent;
=20
 	/* Initialize MSI domain parent */
-	parent =3D irq_domain_create_linear(fwnodes,
-					    IMX_MU_CHANS,
-					    &imx_mu_msi_domain_ops,
-					    msi_data);
+	parent =3D irq_domain_create_linear(fwnodes, IMX_MU_CHANS,
+					  &imx_mu_msi_domain_ops, msi_data);
 	if (!parent) {
 		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
=20
 	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
-
-	msi_data->msi_domain =3D platform_msi_create_irq_domain(fwnodes,
-					&imx_mu_msi_domain_info,
-					parent);
-
-	if (!msi_data->msi_domain) {
-		dev_err(dev, "failed to create MSI domain\n");
-		irq_domain_remove(parent);
-		return -ENOMEM;
-	}
-
-	irq_domain_set_pm_device(msi_data->msi_domain, dev);
-
+	parent->dev =3D parent->pm_dev =3D dev;
+	parent->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
+	parent->msi_parent_ops =3D &imx_mu_msi_parent_ops;
 	return 0;
 }
=20
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
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 58881d313979..093fd42893a7 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -135,24 +135,14 @@ static int mbigen_set_type(struct irq_data *data, unsig=
ned int type)
 	return 0;
 }
=20
-static struct irq_chip mbigen_irq_chip =3D {
-	.name =3D			"mbigen-v2",
-	.irq_mask =3D		irq_chip_mask_parent,
-	.irq_unmask =3D		irq_chip_unmask_parent,
-	.irq_eoi =3D		mbigen_eoi_irq,
-	.irq_set_type =3D		mbigen_set_type,
-	.irq_set_affinity =3D	irq_chip_set_affinity_parent,
-};
-
-static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
+static void mbigen_write_msi_msg(struct irq_data *d, struct msi_msg *msg)
 {
-	struct irq_data *d =3D irq_get_irq_data(desc->irq);
 	void __iomem *base =3D d->chip_data;
 	u32 val;
=20
 	if (!msg->address_lo && !msg->address_hi)
 		return;
-=20
+
 	base +=3D get_mbigen_vec_reg(d->hwirq);
 	val =3D readl_relaxed(base);
=20
@@ -165,10 +155,8 @@ static void mbigen_write_msg(struct msi_desc *desc, stru=
ct msi_msg *msg)
 	writel_relaxed(val, base);
 }
=20
-static int mbigen_domain_translate(struct irq_domain *d,
-				    struct irq_fwspec *fwspec,
-				    unsigned long *hwirq,
-				    unsigned int *type)
+static int mbigen_domain_translate(struct irq_domain *d, struct irq_fwspec *=
fwspec,
+				   unsigned long *hwirq, unsigned int *type)
 {
 	if (is_of_node(fwspec->fwnode) || is_acpi_device_node(fwspec->fwnode)) {
 		if (fwspec->param_count !=3D 2)
@@ -192,51 +180,48 @@ static int mbigen_domain_translate(struct irq_domain *d,
 	return -EINVAL;
 }
=20
-static int mbigen_irq_domain_alloc(struct irq_domain *domain,
-					unsigned int virq,
-					unsigned int nr_irqs,
-					void *args)
+static void mbigen_domain_set_desc(msi_alloc_info_t *arg, struct msi_desc *d=
esc)
 {
-	struct irq_fwspec *fwspec =3D args;
-	irq_hw_number_t hwirq;
-	unsigned int type;
-	struct mbigen_device *mgn_chip;
-	int i, err;
-
-	err =3D mbigen_domain_translate(domain, fwspec, &hwirq, &type);
-	if (err)
-		return err;
-
-	err =3D platform_msi_device_domain_alloc(domain, virq, nr_irqs);
-	if (err)
-		return err;
+	arg->desc =3D desc;
+	arg->hwirq =3D (u32)desc->data.icookie.value;
+}
=20
-	mgn_chip =3D platform_msi_get_host_data(domain);
+static const struct msi_domain_template mbigen_msi_template =3D {
+	.chip =3D {
+		.name			=3D "mbigen-v2",
+		.irq_mask		=3D irq_chip_mask_parent,
+		.irq_unmask		=3D irq_chip_unmask_parent,
+		.irq_eoi		=3D mbigen_eoi_irq,
+		.irq_set_type		=3D mbigen_set_type,
+		.irq_write_msi_msg	=3D mbigen_write_msi_msg,
+	},
=20
-	for (i =3D 0; i < nr_irqs; i++)
-		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
-				      &mbigen_irq_chip, mgn_chip->base);
+	.ops =3D {
+		.set_desc		=3D mbigen_domain_set_desc,
+		.msi_translate		=3D mbigen_domain_translate,
+	},
=20
-	return 0;
-}
+	.info =3D {
+		.bus_token		=3D DOMAIN_BUS_WIRED_TO_MSI,
+		.flags			=3D MSI_FLAG_USE_DEV_FWNODE,
+	},
+};
=20
-static void mbigen_irq_domain_free(struct irq_domain *domain, unsigned int v=
irq,
-				   unsigned int nr_irqs)
+static bool mbigen_create_device_domain(struct device *dev, unsigned int siz=
e,
+					struct mbigen_device *mgn_chip)
 {
-	platform_msi_device_domain_free(domain, virq, nr_irqs);
-}
+	if (WARN_ON_ONCE(!dev->msi.domain))
+		return false;
=20
-static const struct irq_domain_ops mbigen_domain_ops =3D {
-	.translate	=3D mbigen_domain_translate,
-	.alloc		=3D mbigen_irq_domain_alloc,
-	.free		=3D mbigen_irq_domain_free,
-};
+	return msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN,
+					    &mbigen_msi_template, size,
+					    NULL, mgn_chip->base);
+}
=20
 static int mbigen_of_create_domain(struct platform_device *pdev,
 				   struct mbigen_device *mgn_chip)
 {
 	struct platform_device *child;
-	struct irq_domain *domain;
 	struct device_node *np;
 	u32 num_pins;
 	int ret =3D 0;
@@ -258,11 +243,7 @@ static int mbigen_of_create_domain(struct platform_devic=
e *pdev,
 			break;
 		}
=20
-		domain =3D platform_msi_create_device_domain(&child->dev, num_pins,
-							   mbigen_write_msg,
-							   &mbigen_domain_ops,
-							   mgn_chip);
-		if (!domain) {
+		if (!mbigen_create_device_domain(&child->dev, num_pins, mgn_chip)) {
 			ret =3D -ENOMEM;
 			break;
 		}
@@ -284,7 +265,6 @@ MODULE_DEVICE_TABLE(acpi, mbigen_acpi_match);
 static int mbigen_acpi_create_domain(struct platform_device *pdev,
 				     struct mbigen_device *mgn_chip)
 {
-	struct irq_domain *domain;
 	u32 num_pins =3D 0;
 	int ret;
=20
@@ -315,11 +295,7 @@ static int mbigen_acpi_create_domain(struct platform_dev=
ice *pdev,
 	if (ret || num_pins =3D=3D 0)
 		return -EINVAL;
=20
-	domain =3D platform_msi_create_device_domain(&pdev->dev, num_pins,
-						   mbigen_write_msg,
-						   &mbigen_domain_ops,
-						   mgn_chip);
-	if (!domain)
+	if (!mbigen_create_device_domain(&pdev->dev, num_pins, mgn_chip))
 		return -ENOMEM;
=20
 	return 0;
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
diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
new file mode 100644
index 000000000000..b5b90003311a
--- /dev/null
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022 Linutronix GmbH
+// Copyright (C) 2022 Intel
+
+#include <linux/export.h>
+
+#include "irq-msi-lib.h"
+
+/**
+ * msi_lib_init_dev_msi_info - Domain info setup for MSI domains
+ * @dev:		The device for which the domain is created for
+ * @domain:		The domain providing this callback
+ * @real_parent:	The real parent domain of the domain to be initialized
+ *			which might be a domain built on top of @domain or
+ *			@domain itself
+ * @info:		The domain info for the domain to be initialize
+ *
+ * This function is to be used for all types of MSI domains above the root
+ * parent domain and any intermediates. The topmost parent domain specific
+ * functionality is determined via @real_parent.
+ *
+ * All intermediate domains between the root and the device domain must
+ * have either msi_parent_ops.init_dev_msi_info =3D msi_parent_init_dev_msi_=
info
+ * or invoke it down the line.
+ */
+bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+			       struct irq_domain *real_parent,
+			       struct msi_domain_info *info)
+{
+	const struct msi_parent_ops *pops =3D real_parent->msi_parent_ops;
+	u32 required_flags;
+
+	/* Parent ops available? */
+	if (WARN_ON_ONCE(!pops))
+		return false;
+
+	/*
+	 * MSI parent domain specific settings. For now there is only the
+	 * root parent domain, e.g. NEXUS, acting as a MSI parent, but it is
+	 * possible to stack MSI parents. See x86 vector -> irq remapping
+	 */
+	if (domain->bus_token =3D=3D pops->bus_select_token) {
+		if (WARN_ON_ONCE(domain !=3D real_parent))
+			return false;
+	} else {
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	required_flags =3D pops->required_flags;
+
+	/* Is the target domain bus token supported? */
+	switch(info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PCI_MSI)))
+			return false;
+
+		break;
+	case DOMAIN_BUS_DEVICE_MSI:
+		/*
+		 * Per device MSI should never have any MSI feature bits
+		 * set. It's sole purpose is to create a dumb interrupt
+		 * chip which has a device specific irq_write_msi_msg()
+		 * callback.
+		 */
+		if (WARN_ON_ONCE(info->flags))
+			return false;
+
+		/* Core managed MSI descriptors */
+		info->flags =3D MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS;
+		fallthrough;
+	case DOMAIN_BUS_WIRED_TO_MSI:
+		/* Remove PCI specific flags */
+		required_flags &=3D ~MSI_FLAG_PCI_MSI_MASK_PARENT;
+		break;
+	default:
+		/*
+		 * This should never be reached. See
+		 * msi_lib_irq_domain_select()
+		 */
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	/*
+	 * Mask out the domain specific MSI feature flags which are not
+	 * supported by the real parent.
+	 */
+	info->flags			&=3D pops->supported_flags;
+	/* Enforce the required flags */
+	info->flags			|=3D required_flags;
+
+	/* Chip updates for all child bus types */
+	if (!info->chip->irq_eoi)
+		info->chip->irq_eoi	=3D irq_chip_eoi_parent;
+	if (!info->chip->irq_ack)
+		info->chip->irq_ack	=3D irq_chip_ack_parent;
+
+	/*
+	 * The device MSI domain can never have a set affinity callback. It
+	 * always has to rely on the parent domain to handle affinity
+	 * settings. The device MSI domain just has to write the resulting
+	 * MSI message into the hardware which is the whole purpose of the
+	 * device MSI domain aside of mask/unmask which is provided e.g. by
+	 * PCI/MSI device domains.
+	 */
+	info->chip->irq_set_affinity	=3D msi_domain_set_affinity;
+	return true;
+}
+EXPORT_SYMBOL_GPL(msi_lib_init_dev_msi_info);
+
+/**
+ * msi_lib_irq_domain_select - Shared select function for NEXUS domains
+ * @d:		Pointer to the irq domain on which select is invoked
+ * @fwspec:	Firmware spec describing what is searched
+ * @bus_token:	The bus token for which a matching irq domain is looked up
+ *
+ * Returns:	%0 if @d is not what is being looked for
+ *
+ *		%1 if @d is either the domain which is directly searched for or
+ *		   if @d is providing the parent MSI domain for the functionality
+ *			 requested with @bus_token.
+ */
+int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspe=
c,
+			      enum irq_domain_bus_token bus_token)
+{
+	const struct msi_parent_ops *ops =3D d->msi_parent_ops;
+	u32 busmask =3D BIT(bus_token);
+
+	if (fwspec->fwnode !=3D d->fwnode || fwspec->param_count !=3D 0)
+		return 0;
+
+	/* Handle pure domain searches */
+	if (bus_token =3D=3D ops->bus_select_token)
+		return 1;
+
+	return ops && !!(ops->bus_select_mask & busmask);
+}
+EXPORT_SYMBOL_GPL(msi_lib_irq_domain_select);
diff --git a/drivers/irqchip/irq-msi-lib.h b/drivers/irqchip/irq-msi-lib.h
new file mode 100644
index 000000000000..681ceabb7bc7
--- /dev/null
+++ b/drivers/irqchip/irq-msi-lib.h
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022 Linutronix GmbH
+// Copyright (C) 2022 Intel
+
+#ifndef _DRIVERS_IRQCHIP_IRQ_MSI_LIB_H
+#define _DRIVERS_IRQCHIP_IRQ_MSI_LIB_H
+
+#include <linux/bits.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+
+#ifdef CONFIG_PCI_MSI
+#define MATCH_PCI_MSI		BIT(DOMAIN_BUS_PCI_MSI)
+#else
+#define MATCH_PCI_MSI		(0)
+#endif
+
+#define MATCH_PLATFORM_MSI	BIT(DOMAIN_BUS_PLATFORM_MSI)
+
+int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspe=
c,
+			      enum irq_domain_bus_token bus_token);
+
+bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+			       struct irq_domain *real_parent,
+			       struct msi_domain_info *info);
+
+#endif /* _DRIVERS_IRQCHIP_IRQ_MSI_LIB_H */
diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gic=
p.c
index c43a345061d5..2b6183919ea4 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -17,6 +17,8 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
=20
+#include "irq-msi-lib.h"
+
 #include <dt-bindings/interrupt-controller/arm-gic.h>
=20
 #define GICP_SETSPI_NSR_OFFSET	0x0
@@ -145,32 +147,32 @@ static void gicp_irq_domain_free(struct irq_domain *dom=
ain,
 }
=20
 static const struct irq_domain_ops gicp_domain_ops =3D {
+	.select	=3D msi_lib_irq_domain_select,
 	.alloc	=3D gicp_irq_domain_alloc,
 	.free	=3D gicp_irq_domain_free,
 };
=20
-static struct irq_chip gicp_msi_irq_chip =3D {
-	.name		=3D "GICP",
-	.irq_set_type	=3D irq_chip_set_type_parent,
-	.flags		=3D IRQCHIP_SUPPORTS_LEVEL_MSI,
-};
+#define GICP_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				  MSI_FLAG_USE_DEF_CHIP_OPS)
=20
-static struct msi_domain_ops gicp_msi_ops =3D {
-};
+#define GICP_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				  MSI_FLAG_LEVEL_CAPABLE)
=20
-static struct msi_domain_info gicp_msi_domain_info =3D {
-	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_LEVEL_CAPABLE),
-	.ops	=3D &gicp_msi_ops,
-	.chip	=3D &gicp_msi_irq_chip,
+static const struct msi_parent_ops gicp_msi_parent_ops =3D {
+	.supported_flags	=3D GICP_MSI_FLAGS_SUPPORTED,
+	.required_flags		=3D GICP_MSI_FLAGS_REQUIRED,
+	.bus_select_token       =3D DOMAIN_BUS_GENERIC_MSI,
+	.bus_select_mask	=3D MATCH_PLATFORM_MSI,
+	.prefix			=3D "GICP-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
 };
=20
 static int mvebu_gicp_probe(struct platform_device *pdev)
 {
-	struct mvebu_gicp *gicp;
-	struct irq_domain *inner_domain, *plat_domain, *parent_domain;
+	struct irq_domain *inner_domain, *parent_domain;
 	struct device_node *node =3D pdev->dev.of_node;
 	struct device_node *irq_parent_dn;
+	struct mvebu_gicp *gicp;
 	int ret, i;
=20
 	gicp =3D devm_kzalloc(&pdev->dev, sizeof(*gicp), GFP_KERNEL);
@@ -234,17 +236,9 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
 	if (!inner_domain)
 		return -ENOMEM;
=20
-
-	plat_domain =3D platform_msi_create_irq_domain(of_node_to_fwnode(node),
-						     &gicp_msi_domain_info,
-						     inner_domain);
-	if (!plat_domain) {
-		irq_domain_remove(inner_domain);
-		return -ENOMEM;
-	}
-
-	platform_set_drvdata(pdev, gicp);
-
+	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_GENERIC_MSI);
+	inner_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
+	inner_domain->msi_parent_ops =3D &gicp_msi_parent_ops;
 	return 0;
 }
=20
diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 3c77acc7ec6a..b337f6c05f18 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -20,6 +20,8 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
=20
+#include "irq-msi-lib.h"
+
 #include <dt-bindings/interrupt-controller/mvebu-icu.h>
=20
 /* ICU registers */
@@ -60,99 +62,13 @@ struct mvebu_icu_msi_data {
 	const struct mvebu_icu_subset_data *subset_data;
 };
=20
-struct mvebu_icu_irq_data {
-	struct mvebu_icu *icu;
-	unsigned int icu_group;
-	unsigned int type;
-};
-
 static DEFINE_STATIC_KEY_FALSE(legacy_bindings);
=20
-static void mvebu_icu_init(struct mvebu_icu *icu,
-			   struct mvebu_icu_msi_data *msi_data,
-			   struct msi_msg *msg)
-{
-	const struct mvebu_icu_subset_data *subset =3D msi_data->subset_data;
-
-	if (atomic_cmpxchg(&msi_data->initialized, false, true))
-		return;
-
-	/* Set 'SET' ICU SPI message address in AP */
-	writel_relaxed(msg[0].address_hi, icu->base + subset->offset_set_ah);
-	writel_relaxed(msg[0].address_lo, icu->base + subset->offset_set_al);
-
-	if (subset->icu_group !=3D ICU_GRP_NSR)
-		return;
-
-	/* Set 'CLEAR' ICU SPI message address in AP (level-MSI only) */
-	writel_relaxed(msg[1].address_hi, icu->base + subset->offset_clr_ah);
-	writel_relaxed(msg[1].address_lo, icu->base + subset->offset_clr_al);
-}
-
-static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
-{
-	struct irq_data *d =3D irq_get_irq_data(desc->irq);
-	struct mvebu_icu_msi_data *msi_data =3D platform_msi_get_host_data(d->domai=
n);
-	struct mvebu_icu_irq_data *icu_irqd =3D d->chip_data;
-	struct mvebu_icu *icu =3D icu_irqd->icu;
-	unsigned int icu_int;
-
-	if (msg->address_lo || msg->address_hi) {
-		/* One off initialization per domain */
-		mvebu_icu_init(icu, msi_data, msg);
-		/* Configure the ICU with irq number & type */
-		icu_int =3D msg->data | ICU_INT_ENABLE;
-		if (icu_irqd->type & IRQ_TYPE_EDGE_RISING)
-			icu_int |=3D ICU_IS_EDGE;
-		icu_int |=3D icu_irqd->icu_group << ICU_GROUP_SHIFT;
-	} else {
-		/* De-configure the ICU */
-		icu_int =3D 0;
-	}
-
-	writel_relaxed(icu_int, icu->base + ICU_INT_CFG(d->hwirq));
-
-	/*
-	 * The SATA unit has 2 ports, and a dedicated ICU entry per
-	 * port. The ahci sata driver supports only one irq interrupt
-	 * per SATA unit. To solve this conflict, we configure the 2
-	 * SATA wired interrupts in the south bridge into 1 GIC
-	 * interrupt in the north bridge. Even if only a single port
-	 * is enabled, if sata node is enabled, both interrupts are
-	 * configured (regardless of which port is actually in use).
-	 */
-	if (d->hwirq =3D=3D ICU_SATA0_ICU_ID || d->hwirq =3D=3D ICU_SATA1_ICU_ID) {
-		writel_relaxed(icu_int,
-			       icu->base + ICU_INT_CFG(ICU_SATA0_ICU_ID));
-		writel_relaxed(icu_int,
-			       icu->base + ICU_INT_CFG(ICU_SATA1_ICU_ID));
-	}
-}
-
-static struct irq_chip mvebu_icu_nsr_chip =3D {
-	.name			=3D "ICU-NSR",
-	.irq_mask		=3D irq_chip_mask_parent,
-	.irq_unmask		=3D irq_chip_unmask_parent,
-	.irq_eoi		=3D irq_chip_eoi_parent,
-	.irq_set_type		=3D irq_chip_set_type_parent,
-	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
-};
-
-static struct irq_chip mvebu_icu_sei_chip =3D {
-	.name			=3D "ICU-SEI",
-	.irq_ack		=3D irq_chip_ack_parent,
-	.irq_mask		=3D irq_chip_mask_parent,
-	.irq_unmask		=3D irq_chip_unmask_parent,
-	.irq_set_type		=3D irq_chip_set_type_parent,
-	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
-};
-
-static int
-mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwsp=
ec,
+static int mvebu_icu_translate(struct irq_domain *d, struct irq_fwspec *fwsp=
ec,
 			       unsigned long *hwirq, unsigned int *type)
 {
 	unsigned int param_count =3D static_branch_unlikely(&legacy_bindings) ? 3 :=
 2;
-	struct mvebu_icu_msi_data *msi_data =3D platform_msi_get_host_data(d);
+	struct mvebu_icu_msi_data *msi_data =3D d->host_data;
 	struct mvebu_icu *icu =3D msi_data->icu;
=20
 	/* Check the count of the parameters in dt */
@@ -192,81 +108,126 @@ mvebu_icu_irq_domain_translate(struct irq_domain *d, s=
truct irq_fwspec *fwspec,
 	return 0;
 }
=20
-static int
-mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
-			   unsigned int nr_irqs, void *args)
+static void mvebu_icu_init(struct mvebu_icu *icu,
+			   struct mvebu_icu_msi_data *msi_data,
+			   struct msi_msg *msg)
 {
-	int err;
-	unsigned long hwirq;
-	struct irq_fwspec *fwspec =3D args;
-	struct mvebu_icu_msi_data *msi_data =3D platform_msi_get_host_data(domain);
-	struct mvebu_icu *icu =3D msi_data->icu;
-	struct mvebu_icu_irq_data *icu_irqd;
-	struct irq_chip *chip =3D &mvebu_icu_nsr_chip;
+	const struct mvebu_icu_subset_data *subset =3D msi_data->subset_data;
=20
-	icu_irqd =3D kmalloc(sizeof(*icu_irqd), GFP_KERNEL);
-	if (!icu_irqd)
-		return -ENOMEM;
+	if (atomic_cmpxchg(&msi_data->initialized, false, true))
+		return;
=20
-	err =3D mvebu_icu_irq_domain_translate(domain, fwspec, &hwirq,
-					     &icu_irqd->type);
-	if (err) {
-		dev_err(icu->dev, "failed to translate ICU parameters\n");
-		goto free_irqd;
-	}
+	/* Set 'SET' ICU SPI message address in AP */
+	writel_relaxed(msg[0].address_hi, icu->base + subset->offset_set_ah);
+	writel_relaxed(msg[0].address_lo, icu->base + subset->offset_set_al);
=20
-	if (static_branch_unlikely(&legacy_bindings))
-		icu_irqd->icu_group =3D fwspec->param[0];
-	else
-		icu_irqd->icu_group =3D msi_data->subset_data->icu_group;
-	icu_irqd->icu =3D icu;
+	if (subset->icu_group !=3D ICU_GRP_NSR)
+		return;
=20
-	err =3D platform_msi_device_domain_alloc(domain, virq, nr_irqs);
-	if (err) {
-		dev_err(icu->dev, "failed to allocate ICU interrupt in parent domain\n");
-		goto free_irqd;
-	}
+	/* Set 'CLEAR' ICU SPI message address in AP (level-MSI only) */
+	writel_relaxed(msg[1].address_hi, icu->base + subset->offset_clr_ah);
+	writel_relaxed(msg[1].address_lo, icu->base + subset->offset_clr_al);
+}
=20
-	/* Make sure there is no interrupt left pending by the firmware */
-	err =3D irq_set_irqchip_state(virq, IRQCHIP_STATE_PENDING, false);
-	if (err)
-		goto free_msi;
+static int mvebu_icu_msi_init(struct irq_domain *domain, struct msi_domain_i=
nfo *info,
+			      unsigned int virq, irq_hw_number_t hwirq, msi_alloc_info_t *arg)
+{
+	irq_domain_set_hwirq_and_chip(domain, virq, hwirq, info->chip, info->chip_d=
ata);
+	return irq_set_irqchip_state(virq, IRQCHIP_STATE_PENDING, false);
+}
=20
-	if (icu_irqd->icu_group =3D=3D ICU_GRP_SEI)
-		chip =3D &mvebu_icu_sei_chip;
+static void mvebu_icu_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	arg->desc =3D desc;
+	arg->hwirq =3D (u32)desc->data.icookie.value;
+}
=20
-	err =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
-					    chip, icu_irqd);
-	if (err) {
-		dev_err(icu->dev, "failed to set the data to IRQ domain\n");
-		goto free_msi;
+static void mvebu_icu_write_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct mvebu_icu_msi_data *msi_data =3D d->chip_data;
+	unsigned int icu_group =3D msi_data->subset_data->icu_group;
+	struct msi_desc *desc =3D irq_data_get_msi_desc(d);
+	struct mvebu_icu *icu =3D msi_data->icu;
+	unsigned int type;
+	u32 icu_int;
+
+	if (msg->address_lo || msg->address_hi) {
+		/* One off initialization per domain */
+		mvebu_icu_init(icu, msi_data, msg);
+		/* Configure the ICU with irq number & type */
+		icu_int =3D msg->data | ICU_INT_ENABLE;
+		type =3D (unsigned int)(desc->data.icookie.value >> 32);
+		if (type & IRQ_TYPE_EDGE_RISING)
+			icu_int |=3D ICU_IS_EDGE;
+		icu_int |=3D icu_group << ICU_GROUP_SHIFT;
+	} else {
+		/* De-configure the ICU */
+		icu_int =3D 0;
 	}
=20
-	return 0;
+	writel_relaxed(icu_int, icu->base + ICU_INT_CFG(d->hwirq));
=20
-free_msi:
-	platform_msi_device_domain_free(domain, virq, nr_irqs);
-free_irqd:
-	kfree(icu_irqd);
-	return err;
+	/*
+	 * The SATA unit has 2 ports, and a dedicated ICU entry per
+	 * port. The ahci sata driver supports only one irq interrupt
+	 * per SATA unit. To solve this conflict, we configure the 2
+	 * SATA wired interrupts in the south bridge into 1 GIC
+	 * interrupt in the north bridge. Even if only a single port
+	 * is enabled, if sata node is enabled, both interrupts are
+	 * configured (regardless of which port is actually in use).
+	 */
+	if (d->hwirq =3D=3D ICU_SATA0_ICU_ID || d->hwirq =3D=3D ICU_SATA1_ICU_ID) {
+		writel_relaxed(icu_int, icu->base + ICU_INT_CFG(ICU_SATA0_ICU_ID));
+		writel_relaxed(icu_int, icu->base + ICU_INT_CFG(ICU_SATA1_ICU_ID));
+	}
 }
=20
-static void
-mvebu_icu_irq_domain_free(struct irq_domain *domain, unsigned int virq,
-			  unsigned int nr_irqs)
-{
-	struct irq_data *d =3D irq_get_irq_data(virq);
-	struct mvebu_icu_irq_data *icu_irqd =3D d->chip_data;
+static const struct msi_domain_template mvebu_icu_nsr_msi_template =3D {
+	.chip =3D {
+		.name			=3D "ICU-NSR",
+		.irq_mask		=3D irq_chip_mask_parent,
+		.irq_unmask		=3D irq_chip_unmask_parent,
+		.irq_eoi		=3D irq_chip_eoi_parent,
+		.irq_set_type		=3D irq_chip_set_type_parent,
+		.irq_write_msi_msg	=3D mvebu_icu_write_msi_msg,
+		.flags			=3D IRQCHIP_SUPPORTS_LEVEL_MSI,
+	},
=20
-	kfree(icu_irqd);
+	.ops =3D {
+		.msi_translate		=3D mvebu_icu_translate,
+		.msi_init		=3D mvebu_icu_msi_init,
+		.set_desc		=3D mvebu_icu_set_desc,
+	},
=20
-	platform_msi_device_domain_free(domain, virq, nr_irqs);
-}
+	.info =3D {
+		.bus_token		=3D DOMAIN_BUS_WIRED_TO_MSI,
+		.flags			=3D MSI_FLAG_LEVEL_CAPABLE |
+					  MSI_FLAG_USE_DEV_FWNODE,
+	},
+};
+
+static const struct msi_domain_template mvebu_icu_sei_msi_template =3D {
+	.chip =3D {
+		.name			=3D "ICU-SEI",
+		.irq_mask		=3D irq_chip_mask_parent,
+		.irq_unmask		=3D irq_chip_unmask_parent,
+		.irq_ack		=3D irq_chip_ack_parent,
+		.irq_set_type		=3D irq_chip_set_type_parent,
+		.irq_write_msi_msg	=3D mvebu_icu_write_msi_msg,
+		.flags			=3D IRQCHIP_SUPPORTS_LEVEL_MSI,
+	},
=20
-static const struct irq_domain_ops mvebu_icu_domain_ops =3D {
-	.translate =3D mvebu_icu_irq_domain_translate,
-	.alloc     =3D mvebu_icu_irq_domain_alloc,
-	.free      =3D mvebu_icu_irq_domain_free,
+	.ops =3D {
+		.msi_translate		=3D mvebu_icu_translate,
+		.msi_init		=3D mvebu_icu_msi_init,
+		.set_desc		=3D mvebu_icu_set_desc,
+	},
+
+	.info =3D {
+		.bus_token		=3D DOMAIN_BUS_WIRED_TO_MSI,
+		.flags			=3D MSI_FLAG_LEVEL_CAPABLE |
+					  MSI_FLAG_USE_DEV_FWNODE,
+	},
 };
=20
 static const struct mvebu_icu_subset_data mvebu_icu_nsr_subset_data =3D {
@@ -297,10 +258,10 @@ static const struct of_device_id mvebu_icu_subset_of_ma=
tch[] =3D {
=20
 static int mvebu_icu_subset_probe(struct platform_device *pdev)
 {
+	const struct msi_domain_template *tmpl;
 	struct mvebu_icu_msi_data *msi_data;
-	struct device_node *msi_parent_dn;
 	struct device *dev =3D &pdev->dev;
-	struct irq_domain *irq_domain;
+	bool sei;
=20
 	msi_data =3D devm_kzalloc(dev, sizeof(*msi_data), GFP_KERNEL);
 	if (!msi_data)
@@ -314,20 +275,18 @@ static int mvebu_icu_subset_probe(struct platform_devic=
e *pdev)
 		msi_data->subset_data =3D of_device_get_match_data(dev);
 	}
=20
-	dev->msi.domain =3D of_msi_get_domain(dev, dev->of_node,
-					    DOMAIN_BUS_PLATFORM_MSI);
+	dev->msi.domain =3D of_msi_get_domain(dev, dev->of_node, DOMAIN_BUS_PLATFOR=
M_MSI);
 	if (!dev->msi.domain)
 		return -EPROBE_DEFER;
=20
-	msi_parent_dn =3D irq_domain_get_of_node(dev->msi.domain);
-	if (!msi_parent_dn)
+	if (!irq_domain_get_of_node(dev->msi.domain))
 		return -ENODEV;
=20
-	irq_domain =3D platform_msi_create_device_tree_domain(dev, ICU_MAX_IRQS,
-							    mvebu_icu_write_msg,
-							    &mvebu_icu_domain_ops,
-							    msi_data);
-	if (!irq_domain) {
+	sei =3D msi_data->subset_data->icu_group =3D=3D ICU_GRP_SEI;
+	tmpl =3D sei ? &mvebu_icu_sei_msi_template : &mvebu_icu_nsr_msi_template;
+
+	if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, tmpl,
+					  ICU_MAX_IRQS, NULL, msi_data)) {
 		dev_err(dev, "Failed to create ICU MSI domain\n");
 		return -ENOMEM;
 	}
diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odm=
i.c
index 108091533e10..ff19bfd258dc 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -17,6 +17,9 @@
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
+
+#include "irq-msi-lib.h"
+
 #include <dt-bindings/interrupt-controller/arm-gic.h>
=20
 #define GICP_ODMIN_SET			0x40
@@ -141,27 +144,29 @@ static void odmi_irq_domain_free(struct irq_domain *dom=
ain,
 }
=20
 static const struct irq_domain_ops odmi_domain_ops =3D {
+	.select	=3D msi_lib_irq_domain_select,
 	.alloc	=3D odmi_irq_domain_alloc,
 	.free	=3D odmi_irq_domain_free,
 };
=20
-static struct irq_chip odmi_msi_irq_chip =3D {
-	.name	=3D "ODMI",
-};
+#define ODMI_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				  MSI_FLAG_USE_DEF_CHIP_OPS)
=20
-static struct msi_domain_ops odmi_msi_ops =3D {
-};
+#define ODMI_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK)
=20
-static struct msi_domain_info odmi_msi_domain_info =3D {
-	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
-	.ops	=3D &odmi_msi_ops,
-	.chip	=3D &odmi_msi_irq_chip,
+static const struct msi_parent_ops odmi_msi_parent_ops =3D {
+	.supported_flags	=3D ODMI_MSI_FLAGS_SUPPORTED,
+	.required_flags		=3D ODMI_MSI_FLAGS_REQUIRED,
+	.bus_select_token	=3D DOMAIN_BUS_GENERIC_MSI,
+	.bus_select_mask	=3D MATCH_PLATFORM_MSI,
+	.prefix			=3D "ODMI-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
 };
=20
 static int __init mvebu_odmi_init(struct device_node *node,
 				  struct device_node *parent)
 {
-	struct irq_domain *parent_domain, *inner_domain, *plat_domain;
+	struct irq_domain *parent_domain, *inner_domain;
 	int ret, i;
=20
 	if (of_property_read_u32(node, "marvell,odmi-frames", &odmis_count))
@@ -208,18 +213,12 @@ static int __init mvebu_odmi_init(struct device_node *n=
ode,
 		goto err_unmap;
 	}
=20
-	plat_domain =3D platform_msi_create_irq_domain(of_node_to_fwnode(node),
-						     &odmi_msi_domain_info,
-						     inner_domain);
-	if (!plat_domain) {
-		ret =3D -ENOMEM;
-		goto err_remove_inner;
-	}
+	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_GENERIC_MSI);
+	inner_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
+	inner_domain->msi_parent_ops =3D &odmi_msi_parent_ops;
=20
 	return 0;
=20
-err_remove_inner:
-	irq_domain_remove(inner_domain);
 err_unmap:
 	for (i =3D 0; i < odmis_count; i++) {
 		struct odmi_data *odmi =3D &odmis[i];
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
diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index a48dbe91b036..f8c70f2d100a 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -14,6 +14,8 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
=20
+#include "irq-msi-lib.h"
+
 /* Cause register */
 #define GICP_SECR(idx)		(0x0  + ((idx) * 0x4))
 /* Mask register */
@@ -190,6 +192,7 @@ static void mvebu_sei_domain_free(struct irq_domain *doma=
in, unsigned int virq,
 }
=20
 static const struct irq_domain_ops mvebu_sei_domain_ops =3D {
+	.select	=3D msi_lib_irq_domain_select,
 	.alloc	=3D mvebu_sei_domain_alloc,
 	.free	=3D mvebu_sei_domain_free,
 };
@@ -307,21 +310,6 @@ static const struct irq_domain_ops mvebu_sei_cp_domain_o=
ps =3D {
 	.free	=3D mvebu_sei_cp_domain_free,
 };
=20
-static struct irq_chip mvebu_sei_msi_irq_chip =3D {
-	.name		=3D "SEI pMSI",
-	.irq_ack	=3D irq_chip_ack_parent,
-	.irq_set_type	=3D irq_chip_set_type_parent,
-};
-
-static struct msi_domain_ops mvebu_sei_msi_ops =3D {
-};
-
-static struct msi_domain_info mvebu_sei_msi_domain_info =3D {
-	.flags	=3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS,
-	.ops	=3D &mvebu_sei_msi_ops,
-	.chip	=3D &mvebu_sei_msi_irq_chip,
-};
-
 static void mvebu_sei_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct mvebu_sei *sei =3D irq_desc_get_handler_data(desc);
@@ -360,10 +348,23 @@ static void mvebu_sei_reset(struct mvebu_sei *sei)
 	}
 }
=20
+#define SEI_MSI_FLAGS_REQUIRED	(MSI_FLAG_USE_DEF_DOM_OPS |	\
+				 MSI_FLAG_USE_DEF_CHIP_OPS)
+
+#define SEI_MSI_FLAGS_SUPPORTED	(MSI_GENERIC_FLAGS_MASK)
+
+static const struct msi_parent_ops sei_msi_parent_ops =3D {
+	.supported_flags	=3D SEI_MSI_FLAGS_SUPPORTED,
+	.required_flags		=3D SEI_MSI_FLAGS_REQUIRED,
+	.bus_select_mask	=3D MATCH_PLATFORM_MSI,
+	.bus_select_token	=3D DOMAIN_BUS_GENERIC_MSI,
+	.prefix			=3D "SEI-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
+};
+
 static int mvebu_sei_probe(struct platform_device *pdev)
 {
 	struct device_node *node =3D pdev->dev.of_node;
-	struct irq_domain *plat_domain;
 	struct mvebu_sei *sei;
 	u32 parent_irq;
 	int ret;
@@ -440,33 +441,20 @@ static int mvebu_sei_probe(struct platform_device *pdev)
 	}
=20
 	irq_domain_update_bus_token(sei->cp_domain, DOMAIN_BUS_GENERIC_MSI);
-
-	plat_domain =3D platform_msi_create_irq_domain(of_node_to_fwnode(node),
-						     &mvebu_sei_msi_domain_info,
-						     sei->cp_domain);
-	if (!plat_domain) {
-		pr_err("Failed to create CPs MSI domain\n");
-		ret =3D -ENOMEM;
-		goto remove_cp_domain;
-	}
+	sei->cp_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
+	sei->cp_domain->msi_parent_ops =3D &sei_msi_parent_ops;
=20
 	mvebu_sei_reset(sei);
=20
-	irq_set_chained_handler_and_data(parent_irq,
-					 mvebu_sei_handle_cascade_irq,
-					 sei);
-
+	irq_set_chained_handler_and_data(parent_irq, mvebu_sei_handle_cascade_irq, =
sei);
 	return 0;
=20
-remove_cp_domain:
-	irq_domain_remove(sei->cp_domain);
 remove_ap_domain:
 	irq_domain_remove(sei->ap_domain);
 remove_sei_domain:
 	irq_domain_remove(sei->sei_domain);
 dispose_irq:
 	irq_dispose_mapping(parent_irq);
-
 	return ret;
 }
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
index 4f3a12383a1e..47f3200476da 100644
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
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 03d2dd25790d..569125726b3e 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -148,17 +148,35 @@ static void pci_device_domain_set_desc(msi_alloc_info_t=
 *arg, struct msi_desc *d
 	arg->hwirq =3D desc->msi_index;
 }
=20
+static __always_inline void cond_mask_parent(struct irq_data *data)
+{
+	struct msi_domain_info *info =3D data->domain->host_data;
+
+	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
+		irq_chip_mask_parent(data);
+}
+
+static __always_inline void cond_unmask_parent(struct irq_data *data)
+{
+	struct msi_domain_info *info =3D data->domain->host_data;
+
+	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
+		irq_chip_unmask_parent(data);
+}
+
 static void pci_irq_mask_msi(struct irq_data *data)
 {
 	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
=20
 	pci_msi_mask(desc, BIT(data->irq - desc->irq));
+	cond_mask_parent(data);
 }
=20
 static void pci_irq_unmask_msi(struct irq_data *data)
 {
 	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
=20
+	cond_unmask_parent(data);
 	pci_msi_unmask(desc, BIT(data->irq - desc->irq));
 }
=20
@@ -195,10 +213,12 @@ static const struct msi_domain_template pci_msi_templat=
e =3D {
 static void pci_irq_mask_msix(struct irq_data *data)
 {
 	pci_msix_mask(irq_data_get_msi_desc(data));
+	cond_mask_parent(data);
 }
=20
 static void pci_irq_unmask_msix(struct irq_data *data)
 {
+	cond_unmask_parent(data);
 	pci_msix_unmask(irq_data_get_msi_desc(data));
 }
=20
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
diff --git a/include/linux/msi.h b/include/linux/msi.h
index dc27cf3903d5..369367ecae5e 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -21,11 +21,7 @@
 #include <linux/irqdomain_defs.h>
 #include <linux/cpumask.h>
 #include <linux/msi_api.h>
-#include <linux/xarray.h>
-#include <linux/mutex.h>
-#include <linux/list.h>
 #include <linux/irq.h>
-#include <linux/bits.h>
=20
 #include <asm/msi.h>
=20
@@ -81,7 +77,6 @@ extern int pci_msi_ignore_mask;
 /* Helper functions */
 struct msi_desc;
 struct pci_dev;
-struct platform_msi_priv_data;
 struct device_attribute;
 struct irq_domain;
 struct irq_affinity_desc;
@@ -228,22 +223,6 @@ struct msi_dev_domain {
 	struct irq_domain	*domain;
 };
=20
-/**
- * msi_device_data - MSI per device data
- * @properties:		MSI properties which are interesting to drivers
- * @platform_data:	Platform-MSI specific data
- * @mutex:		Mutex protecting the MSI descriptor store
- * @__domains:		Internal data for per device MSI domains
- * @__iter_idx:		Index to search the next entry for iterators
- */
-struct msi_device_data {
-	unsigned long			properties;
-	struct platform_msi_priv_data	*platform_data;
-	struct mutex			mutex;
-	struct msi_dev_domain		__domains[MSI_MAX_DEVICE_IRQDOMAINS];
-	unsigned long			__iter_idx;
-};
-
 int msi_setup_device_data(struct device *dev);
=20
 void msi_lock_descs(struct device *dev);
@@ -556,6 +535,8 @@ enum {
 	MSI_FLAG_USE_DEV_FWNODE		=3D (1 << 7),
 	/* Set parent->dev into domain->pm_dev on device domain creation */
 	MSI_FLAG_PARENT_PM_DEV		=3D (1 << 8),
+	/* Support for parent mask/unmask */
+	MSI_FLAG_PCI_MSI_MASK_PARENT	=3D (1 << 9),
=20
 	/* Mask for the generic functionality */
 	MSI_GENERIC_FLAGS_MASK		=3D GENMASK(15, 0),
@@ -639,35 +620,6 @@ void msi_domain_free_irqs_all(struct device *dev, unsign=
ed int domid);
=20
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
=20
-struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwno=
de,
-						  struct msi_domain_info *info,
-						  struct irq_domain *parent);
-
-/* When an MSI domain is used as an intermediate domain */
-int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
-			    int nvec, msi_alloc_info_t *args);
-int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
-			     int virq, int nvec, msi_alloc_info_t *args);
-void msi_domain_depopulate_descs(struct device *dev, int virq, int nvec);
-
-struct irq_domain *
-__platform_msi_create_device_domain(struct device *dev,
-				    unsigned int nvec,
-				    bool is_tree,
-				    irq_write_msi_msg_t write_msi_msg,
-				    const struct irq_domain_ops *ops,
-				    void *host_data);
-
-#define platform_msi_create_device_domain(dev, nvec, write, ops, data)	\
-	__platform_msi_create_device_domain(dev, nvec, false, write, ops, data)
-#define platform_msi_create_device_tree_domain(dev, nvec, write, ops, data) \
-	__platform_msi_create_device_domain(dev, nvec, true, write, ops, data)
-
-int platform_msi_device_domain_alloc(struct irq_domain *domain, unsigned int=
 virq,
-				     unsigned int nr_irqs);
-void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int=
 virq,
-				     unsigned int nvec);
-void *platform_msi_get_host_data(struct irq_domain *domain);
 /* Per device platform MSI */
 int platform_device_msi_init_and_alloc_irqs(struct device *dev, unsigned int=
 nvec,
 					    irq_write_msi_msg_t write_msi_msg);
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
index aadc8891cc16..cea8f6874b1f 100644
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
+
+	domain =3D __irq_domain_create(info);
+	if (IS_ERR(domain))
+		return domain;
=20
-	domain =3D __irq_domain_create(fwnode, size, hwirq_max, direct_max,
-				     ops, host_data);
-	if (domain)
-		__irq_domain_publish(domain);
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
@@ -438,7 +503,8 @@ struct irq_domain *irq_find_matching_fwspec(struct irq_fw=
spec *fwspec,
 	struct fwnode_handle *fwnode =3D fwspec->fwnode;
 	int rc;
=20
-	/* We might want to match the legacy controller last since
+	/*
+	 * We might want to match the legacy controller last since
 	 * it might potentially be set to match all interrupts in
 	 * the absence of a device node. This isn't a problem so far
 	 * yet though...
@@ -982,6 +1048,12 @@ EXPORT_SYMBOL_GPL(__irq_resolve_mapping);
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
@@ -1000,6 +1072,12 @@ EXPORT_SYMBOL_GPL(irq_domain_xlate_onecell);
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
@@ -1018,6 +1096,12 @@ EXPORT_SYMBOL_GPL(irq_domain_xlate_twocell);
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
@@ -1051,6 +1135,10 @@ EXPORT_SYMBOL_GPL(irq_domain_simple_ops);
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
@@ -1068,6 +1156,10 @@ EXPORT_SYMBOL_GPL(irq_domain_translate_onecell);
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
@@ -1144,23 +1236,22 @@ struct irq_domain *irq_domain_create_hierarchy(struct=
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
@@ -1932,13 +2023,26 @@ static void irq_domain_free_one_irq(struct irq_domain=
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
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 2024f89baea4..5fa0547ece0c 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -8,17 +8,33 @@
  * This file contains common code to support Message Signaled Interrupts for
  * PCI compatible and non PCI compatible devices.
  */
-#include <linux/types.h>
 #include <linux/device.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/xarray.h>
=20
 #include "internals.h"
=20
+/**
+ * struct msi_device_data - MSI per device data
+ * @properties:		MSI properties which are interesting to drivers
+ * @mutex:		Mutex protecting the MSI descriptor store
+ * @__domains:		Internal data for per device MSI domains
+ * @__iter_idx:		Index to search the next entry for iterators
+ */
+struct msi_device_data {
+	unsigned long			properties;
+	struct mutex			mutex;
+	struct msi_dev_domain		__domains[MSI_MAX_DEVICE_IRQDOMAINS];
+	unsigned long			__iter_idx;
+};
+
 /**
  * struct msi_ctrl - MSI internal management control structure
  * @domid:	ID of the domain on which management operations should be done
@@ -1088,8 +1104,8 @@ bool msi_match_device_irq_domain(struct device *dev, un=
signed int domid,
 	return ret;
 }
=20
-int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
-			    int nvec, msi_alloc_info_t *arg)
+static int msi_domain_prepare_irqs(struct irq_domain *domain, struct device =
*dev,
+				   int nvec, msi_alloc_info_t *arg)
 {
 	struct msi_domain_info *info =3D domain->host_data;
 	struct msi_domain_ops *ops =3D info->ops;
@@ -1097,77 +1113,6 @@ int msi_domain_prepare_irqs(struct irq_domain *domain,=
 struct device *dev,
 	return ops->msi_prepare(domain, dev, nvec, arg);
 }
=20
-int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
-			     int virq_base, int nvec, msi_alloc_info_t *arg)
-{
-	struct msi_domain_info *info =3D domain->host_data;
-	struct msi_domain_ops *ops =3D info->ops;
-	struct msi_ctrl ctrl =3D {
-		.domid	=3D MSI_DEFAULT_DOMAIN,
-		.first  =3D virq_base,
-		.last	=3D virq_base + nvec - 1,
-	};
-	struct msi_desc *desc;
-	struct xarray *xa;
-	int ret, virq;
-
-	msi_lock_descs(dev);
-
-	if (!msi_ctrl_valid(dev, &ctrl)) {
-		ret =3D -EINVAL;
-		goto unlock;
-	}
-
-	ret =3D msi_domain_add_simple_msi_descs(dev, &ctrl);
-	if (ret)
-		goto unlock;
-
-	xa =3D &dev->msi.data->__domains[ctrl.domid].store;
-
-	for (virq =3D virq_base; virq < virq_base + nvec; virq++) {
-		desc =3D xa_load(xa, virq);
-		desc->irq =3D virq;
-
-		ops->set_desc(arg, desc);
-		ret =3D irq_domain_alloc_irqs_hierarchy(domain, virq, 1, arg);
-		if (ret)
-			goto fail;
-
-		irq_set_msi_desc(virq, desc);
-	}
-	msi_unlock_descs(dev);
-	return 0;
-
-fail:
-	for (--virq; virq >=3D virq_base; virq--) {
-		msi_domain_depopulate_descs(dev, virq, 1);
-		irq_domain_free_irqs_common(domain, virq, 1);
-	}
-	msi_domain_free_descs(dev, &ctrl);
-unlock:
-	msi_unlock_descs(dev);
-	return ret;
-}
-
-void msi_domain_depopulate_descs(struct device *dev, int virq_base, int nvec)
-{
-	struct msi_ctrl ctrl =3D {
-		.domid	=3D MSI_DEFAULT_DOMAIN,
-		.first  =3D virq_base,
-		.last	=3D virq_base + nvec - 1,
-	};
-	struct msi_desc *desc;
-	struct xarray *xa;
-	unsigned long idx;
-
-	if (!msi_ctrl_valid(dev, &ctrl))
-		return;
-
-	xa =3D &dev->msi.data->__domains[ctrl.domid].store;
-	xa_for_each_range(xa, idx, desc, ctrl.first, ctrl.last)
-		desc->irq =3D 0;
-}
-
 /*
  * Carefully check whether the device can use reservation mode. If
  * reservation mode is enabled then the early activation will assign a
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


