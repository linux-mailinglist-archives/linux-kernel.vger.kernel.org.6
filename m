Return-Path: <linux-kernel+bounces-177580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9668C4102
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1321C22D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5711474BE;
	Mon, 13 May 2024 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lyrCeb1C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FltTGR7Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39531465A7
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604608; cv=none; b=c0HQI8HufL69sucFZO8HtPLKCNfmc5h9fGo7gRm2L8WGsZHeF+pe9p53Kio/1SAUsQRCBkEbOD0W6z+SphMx1nYSNISwPiK3bz9Pe59v+yW0wJYzLL5N6E3yB0Z1UsxG4oqK6bXFfql/blxyaPRFMOnZqCi7bUta8DGv027XXrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604608; c=relaxed/simple;
	bh=Z8Z9xYQkbeq4SzPXOcoHiN4Yxm2jDfA6TukWEL3Kxsk=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=slaCBymTNbDKvBN8WS3fJ4OqFyNqe93NLKjPRXxnMMXbBNMs0Kh6crv5ov8v1PhPMNRpKkZjW5tollRtub3nGl1usNvyj6TcjaANSIkBcBCNfwK7btngw7p0NkFs8HzHqN35WIxXwC7v/zL2Svfq/46zPl7YGWJ/va1ArO5ARL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lyrCeb1C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FltTGR7Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715604599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1L6egooNqCCvkZCC3zegz9qPNJlzij+6mAK/T7xMjE8=;
	b=lyrCeb1C/XP8M5pnc9Xs8bcCufwmYdw8O66vu/H7aeNhEHxg8SGf5FUWelNscdP6xXXb/3
	RsQ6S7zdi7lOW3deq1qqMaquii/H9BNNMllKF2rwCLA0fNDW9QUIKlSWHvMdAUzSKrTyqk
	cWaXiTNBt/2flV7i1ObLfy8iT+V4PXTKmevsJ6rXzV4NHE1gzobkOHAqV1w6YJZwPGvEMZ
	Wt6hHYcZDj8nX7PpINDERc/K/YYd6Z2aR957iWAo4UEZtwGHVPZrN/pxH7domkzDLmJ0/2
	0ZZsL4jHjm3xn4LT0dyD+nGjlYj4aEAwRRV1Ibf9ttOIgudvk+y/z0LGfBHMIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715604599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1L6egooNqCCvkZCC3zegz9qPNJlzij+6mAK/T7xMjE8=;
	b=FltTGR7ZPv2+ZJ29eMRvM/xS1XyJ9Gu7j5HaAe3Zw0AZFaytcPx2PYZW8niS633QSzKM77
	PTM7zK3u9vWbK5Dg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for v6.10-rc1
Message-ID: 
 <171560454635.3871325.5773365584560034962.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 May 2024 14:49:58 +0200 (CEST)

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2024-05=
-12

up to:  382d2ffe86ef: irqchip/gic-v3-its: Remove BUG_ON in its_vpe_irq_domain=
_alloc

Updates for the interrupt subsystem:

 - Core code:

   - Interrupt storm detection for the lockup watchdog:

     Lockups which are caused by interrupt storms are not easy to debug
     because there is no information about the events which make the lockup
     detector trigger.

     To make this more user friendly, provide an extenstion to interrupt
     statistics which allows to take snapshots and an interface to retrieve
     the delta to the snapshot. Use this new mechanism in the watchdog code
     to do a two stage lockup analysis by taking the snapshot and printing
     the deltas for the topmost active interrupts on the second trigger.

     Note: This contains both the interrupt and the watchdog changes as
     the latter depend on the former obviously.

  - Avoid summation loops in the /proc/interrupts output and use the global
    counter when possible

  - Skip suspended interrupts on CPU hotplug operations to ensure that they
    are not delivered before the system resumes the device drivers when
    coming out of suspend.

  - On CPU hot-unplug interrupts which are affine to the outgoing CPU are
    migrated to a different CPU in the affinity mask. This can fail when
    the CPUs have no vectors left. Instead of giving up try to migrate it
    to any online CPU and thereby breaking the affinity setting in order to
    prevent a stale device interrupt which targets an offline CPU

  - The usual small cleanups

 - Driver code:

  - Support for the RISCV AIA MSI controller

  - Make the interrupt allocation for the Loongson PCH controller more
    flexible to prevent vector exhaustion

  - The usual set of cleanups and fixes all over the place


Thanks,

	tglx

------------------>
Andy Shevchenko (3):
      irqdomain: Check virq for 0 before use in irq_dispose_mapping()
      genirq: Fix trivial typo in the comment CPY =3D=3D> COPY
      genirq: Update MAINTAINERS to include interrupt related header files

Antonio Borneo (11):
      irqchip/stm32-exti: Fix minor indentation issue
      dt-bindings: interrupt-controller: stm32-exti: Add irq mapping to parent
      irqchip/stm32-exti: Map interrupts through interrupts-extended
      irqchip/stm32-exti: Convert driver to standard PM
      irqchip/stm32-exti: Skip secure events
      irqchip/stm32-exti: Mark events reserved with RIF configuration check
      arm64: Kconfig.platforms: Enable STM32_EXTI for ARCH_STM32
      ARM: dts: stm32: List exti parent interrupts on stm32mp151
      ARM: dts: stm32: List exti parent interrupts on stm32mp131
      arm64: dts: st: Add exti1 and exti2 nodes on stm32mp251
      arm64: dts: st: Add interrupt parent to pinctrl on stm32mp251

Anup Patel (10):
      dt-bindings: interrupt-controller: Add RISC-V incoming MSI controller
      irqchip: Add RISC-V incoming MSI controller early driver
      irqchip/riscv-imsic: Add device MSI domain support for platform devices
      irqchip/riscv-imsic: Add device MSI domain support for PCI devices
      dt-bindings: interrupt-controller: Add RISC-V advanced PLIC
      irqchip: Add RISC-V advanced PLIC driver for direct-mode
      irqchip/riscv-aplic: Add support for MSI-mode
      RISC-V: Select APLIC and IMSIC drivers
      MAINTAINERS: Add entry for RISC-V AIA drivers
      irqchip/riscv-imsic: Fix boot time update effective affinity warning

Baoqi Zhang (1):
      irqchip/loongson-pch-pic: Update interrupt registration policy

Biju Das (1):
      irqchip/renesas-rzg2l: Simplify rzg2l_irqc_irq_{en,dis}able()

Bitao Hu (5):
      genirq: Convert kstat_irqs to a struct
      genirq: Provide a snapshot mechanism for interrupt statistics
      genirq: Avoid summation loops for /proc/interrupts
      watchdog/softlockup: Low-overhead detection of interrupt storm
      watchdog/softlockup: Report the most frequent interrupts

Colin Ian King (1):
      irqchip/riscv-aplic: Fix spelling mistake "forwared" -> "forwarded"

David Stevens (1):
      genirq/cpuhotplug: Skip suspended interrupts when restoring affinity

Dawei Li (7):
      cpumask: Introduce cpumask_first_and_and()
      irqchip/irq-bcm6345-l1: Avoid explicit cpumask allocation on stack
      irqchip/gic-v3-its: Avoid explicit cpumask allocation on stack
      irqchip/loongson-eiointc: Avoid explicit cpumask allocation on stack
      irqchip/riscv-aplic-direct: Avoid explicit cpumask allocation on stack
      irqchip/sifive-plic: Avoid explicit cpumask allocation on stack
      cpuidle: Avoid explicit cpumask allocation on stack

Dongli Zhang (1):
      genirq/cpuhotplug: Retry with cpu_online_mask when migration fails

Florian Fainelli (1):
      irqchip/irq-brcmstb-l2: Avoid saving mask on shutdown

Guanrui Huang (1):
      irqchip/gic-v3-its: Remove BUG_ON in its_vpe_irq_domain_alloc

Jinjie Ruan (2):
      genirq: Simplify the checks for irq_set_percpu_devid_partition()
      genirq: Reuse irq_is_nmi()

Keguang Zhang (1):
      irqchip: Remove redundant irq_chip::name initialization

Stefan Wahren (1):
      irqchip/mxs: Declare icoll_handle_irq() as static

Tiezhu Yang (2):
      irqchip/loongson-eiointc: Set CPU affinity only on SMP machines for Loo=
ngArch
      irqchip/loongson: Select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP for IRQ_=
LOONGARCH_CPU

Zenghui Yu (2):
      irqchip/alpine-msi: Fix off-by-one in allocation error path
      irqchip/loongson-pch-msi: Fix off-by-one on allocation error path


 .../bindings/interrupt-controller/riscv,aplic.yaml | 172 ++++
 .../interrupt-controller/riscv,imsics.yaml         | 172 ++++
 .../interrupt-controller/st,stm32-exti.yaml        |  17 +-
 MAINTAINERS                                        |  20 +
 arch/arm/boot/dts/st/stm32mp131.dtsi               |  74 +-
 arch/arm/boot/dts/st/stm32mp151.dtsi               |  75 ++
 arch/arm64/Kconfig.platforms                       |   1 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi             | 176 +++++
 arch/mips/dec/setup.c                              |   2 +-
 arch/parisc/kernel/smp.c                           |   2 +-
 arch/powerpc/kvm/book3s_hv_rm_xics.c               |   2 +-
 arch/riscv/Kconfig                                 |   2 +
 drivers/cpuidle/coupled.c                          |  13 +-
 drivers/irqchip/Kconfig                            |  27 +-
 drivers/irqchip/Makefile                           |   3 +
 drivers/irqchip/irq-alpine-msi.c                   |   2 +-
 drivers/irqchip/irq-bcm6345-l1.c                   |   6 +-
 drivers/irqchip/irq-brcmstb-l2.c                   |  17 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  17 +-
 drivers/irqchip/irq-loongson-eiointc.c             |  12 +-
 drivers/irqchip/irq-loongson-pch-msi.c             |   2 +-
 drivers/irqchip/irq-loongson-pch-pic.c             |  76 +-
 drivers/irqchip/irq-mxs.c                          |   2 +-
 drivers/irqchip/irq-renesas-rzg2l.c                |  28 +-
 drivers/irqchip/irq-riscv-aplic-direct.c           | 323 ++++++++
 drivers/irqchip/irq-riscv-aplic-main.c             | 211 +++++
 drivers/irqchip/irq-riscv-aplic-main.h             |  52 ++
 drivers/irqchip/irq-riscv-aplic-msi.c              | 257 ++++++
 drivers/irqchip/irq-riscv-imsic-early.c            | 201 +++++
 drivers/irqchip/irq-riscv-imsic-platform.c         | 375 +++++++++
 drivers/irqchip/irq-riscv-imsic-state.c            | 865 +++++++++++++++++++=
++
 drivers/irqchip/irq-riscv-imsic-state.h            | 108 +++
 drivers/irqchip/irq-sifive-plic.c                  |   7 +-
 drivers/irqchip/irq-stm32-exti.c                   | 139 +++-
 drivers/irqchip/irq-sunxi-nmi.c                    |   1 -
 drivers/irqchip/irq-tb10x.c                        |   1 -
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/cpumask.h                            |  17 +
 include/linux/find.h                               |  27 +
 include/linux/irq.h                                |   2 +-
 include/linux/irqchip/riscv-aplic.h                | 145 ++++
 include/linux/irqchip/riscv-imsic.h                |  87 +++
 include/linux/irqdesc.h                            |  16 +-
 include/linux/kernel_stat.h                        |   8 +
 kernel/irq/Kconfig                                 |   4 +
 kernel/irq/cpuhotplug.c                            |  27 +-
 kernel/irq/internals.h                             |   9 +-
 kernel/irq/irqdesc.c                               |  65 +-
 kernel/irq/irqdomain.c                             |   5 +-
 kernel/irq/manage.c                                |  28 +-
 kernel/irq/proc.c                                  |   9 +-
 kernel/irq/resend.c                                |   2 +-
 kernel/watchdog.c                                  | 215 ++++-
 lib/Kconfig.debug                                  |  14 +
 lib/find_bit.c                                     |  12 +
 scripts/gdb/linux/interrupts.py                    |   6 +-
 56 files changed, 3977 insertions(+), 182 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ri=
scv,aplic.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ri=
scv,imsics.yaml
 create mode 100644 drivers/irqchip/irq-riscv-aplic-direct.c
 create mode 100644 drivers/irqchip/irq-riscv-aplic-main.c
 create mode 100644 drivers/irqchip/irq-riscv-aplic-main.h
 create mode 100644 drivers/irqchip/irq-riscv-aplic-msi.c
 create mode 100644 drivers/irqchip/irq-riscv-imsic-early.c
 create mode 100644 drivers/irqchip/irq-riscv-imsic-platform.c
 create mode 100644 drivers/irqchip/irq-riscv-imsic-state.c
 create mode 100644 drivers/irqchip/irq-riscv-imsic-state.h
 create mode 100644 include/linux/irqchip/riscv-aplic.h
 create mode 100644 include/linux/irqchip/riscv-imsic.h

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,apl=
ic.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.=
yaml
new file mode 100644
index 000000000000..190a6499c932
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
@@ -0,0 +1,172 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/riscv,aplic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Advanced Platform Level Interrupt Controller (APLIC)
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description:
+  The RISC-V advanced interrupt architecture (AIA) defines an advanced
+  platform level interrupt controller (APLIC) for handling wired interrupts
+  in a RISC-V platform. The RISC-V AIA specification can be found at
+  https://github.com/riscv/riscv-aia.
+
+  The RISC-V APLIC is implemented as hierarchical APLIC domains where all
+  interrupt sources connect to the root APLIC domain and a parent APLIC
+  domain can delegate interrupt sources to it's child APLIC domains. There
+  is one device tree node for each APLIC domain.
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qemu,aplic
+      - const: riscv,aplic
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 16384
+    description:
+      Given APLIC domain directly injects external interrupts to a set of
+      RISC-V HARTS (or CPUs). Each node pointed to should be a riscv,cpu-intc
+      node, which has a CPU node (i.e. RISC-V HART) as parent.
+
+  msi-parent:
+    description:
+      Given APLIC domain forwards wired interrupts as MSIs to a AIA incoming
+      message signaled interrupt controller (IMSIC). If both "msi-parent" and
+      "interrupts-extended" properties are present then it means the APLIC
+      domain supports both MSI mode and Direct mode in HW. In this case, the
+      APLIC driver has to choose between MSI mode or Direct mode.
+
+  riscv,num-sources:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 1023
+    description:
+      Specifies the number of wired interrupt sources supported by this
+      APLIC domain.
+
+  riscv,children:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    maxItems: 1024
+    items:
+      maxItems: 1
+    description:
+      A list of child APLIC domains for the given APLIC domain. Each child
+      APLIC domain is assigned a child index in increasing order, with the
+      first child APLIC domain assigned child index 0. The APLIC domain child
+      index is used by firmware to delegate interrupts from the given APLIC
+      domain to a particular child APLIC domain.
+
+  riscv,delegation:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    maxItems: 1024
+    items:
+      items:
+        - description: child APLIC domain phandle
+        - description: first interrupt number of the parent APLIC domain (in=
clusive)
+        - description: last interrupt number of the parent APLIC domain (inc=
lusive)
+    description:
+      A interrupt delegation list where each entry is a triple consisting
+      of child APLIC domain phandle, first interrupt number of the parent
+      APLIC domain, and last interrupt number of the parent APLIC domain.
+      Firmware must configure interrupt delegation registers based on
+      interrupt delegation list.
+
+dependencies:
+  riscv,delegation: [ "riscv,children" ]
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - "#interrupt-cells"
+  - riscv,num-sources
+
+anyOf:
+  - required:
+      - interrupts-extended
+  - required:
+      - msi-parent
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    // Example 1 (APLIC domains directly injecting interrupt to HARTs):
+
+    interrupt-controller@c000000 {
+      compatible =3D "qemu,aplic", "riscv,aplic";
+      interrupts-extended =3D <&cpu1_intc 11>,
+                            <&cpu2_intc 11>,
+                            <&cpu3_intc 11>,
+                            <&cpu4_intc 11>;
+      reg =3D <0xc000000 0x4080>;
+      interrupt-controller;
+      #interrupt-cells =3D <2>;
+      riscv,num-sources =3D <63>;
+      riscv,children =3D <&aplic1>, <&aplic2>;
+      riscv,delegation =3D <&aplic1 1 63>;
+    };
+
+    aplic1: interrupt-controller@d000000 {
+      compatible =3D "qemu,aplic", "riscv,aplic";
+      interrupts-extended =3D <&cpu1_intc 9>,
+                            <&cpu2_intc 9>;
+      reg =3D <0xd000000 0x4080>;
+      interrupt-controller;
+      #interrupt-cells =3D <2>;
+      riscv,num-sources =3D <63>;
+    };
+
+    aplic2: interrupt-controller@e000000 {
+      compatible =3D "qemu,aplic", "riscv,aplic";
+      interrupts-extended =3D <&cpu3_intc 9>,
+                            <&cpu4_intc 9>;
+      reg =3D <0xe000000 0x4080>;
+      interrupt-controller;
+      #interrupt-cells =3D <2>;
+      riscv,num-sources =3D <63>;
+    };
+
+  - |
+    // Example 2 (APLIC domains forwarding interrupts as MSIs):
+
+    interrupt-controller@c000000 {
+      compatible =3D "qemu,aplic", "riscv,aplic";
+      msi-parent =3D <&imsic_mlevel>;
+      reg =3D <0xc000000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells =3D <2>;
+      riscv,num-sources =3D <63>;
+      riscv,children =3D <&aplic3>;
+      riscv,delegation =3D <&aplic3 1 63>;
+    };
+
+    aplic3: interrupt-controller@d000000 {
+      compatible =3D "qemu,aplic", "riscv,aplic";
+      msi-parent =3D <&imsic_slevel>;
+      reg =3D <0xd000000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells =3D <2>;
+      riscv,num-sources =3D <63>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,ims=
ics.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsic=
s.yaml
new file mode 100644
index 000000000000..84976f17a4a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
@@ -0,0 +1,172 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/riscv,imsics.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Incoming MSI Controller (IMSIC)
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description: |
+  The RISC-V advanced interrupt architecture (AIA) defines a per-CPU incoming
+  MSI controller (IMSIC) for handling MSIs in a RISC-V platform. The RISC-V
+  AIA specification can be found at https://github.com/riscv/riscv-aia.
+
+  The IMSIC is a per-CPU (or per-HART) device with separate interrupt file
+  for each privilege level (machine or supervisor). The configuration of
+  a IMSIC interrupt file is done using AIA CSRs and it also has a 4KB MMIO
+  space to receive MSIs from devices. Each IMSIC interrupt file supports a
+  fixed number of interrupt identities (to distinguish MSIs from devices)
+  which is same for given privilege level across CPUs (or HARTs).
+
+  The device tree of a RISC-V platform will have one IMSIC device tree node
+  for each privilege level (machine or supervisor) which collectively descri=
be
+  IMSIC interrupt files at that privilege level across CPUs (or HARTs).
+
+  The arrangement of IMSIC interrupt files in MMIO space of a RISC-V platform
+  follows a particular scheme defined by the RISC-V AIA specification. A IMS=
IC
+  group is a set of IMSIC interrupt files co-located in MMIO space and we can
+  have multiple IMSIC groups (i.e. clusters, sockets, chiplets, etc) in a
+  RISC-V platform. The MSI target address of a IMSIC interrupt file at given
+  privilege level (machine or supervisor) encodes group index, HART index,
+  and guest index (shown below).
+
+  XLEN-1            > (HART Index MSB)                  12    0
+  |                  |                                  |     |
+  -------------------------------------------------------------
+  |xxxxxx|Group Index|xxxxxxxxxxx|HART Index|Guest Index|  0  |
+  -------------------------------------------------------------
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qemu,imsics
+      - const: riscv,imsics
+
+  reg:
+    minItems: 1
+    maxItems: 16384
+    description:
+      Base address of each IMSIC group.
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 0
+
+  msi-controller: true
+
+  "#msi-cells":
+    const: 0
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 16384
+    description:
+      This property represents the set of CPUs (or HARTs) for which given
+      device tree node describes the IMSIC interrupt files. Each node pointed
+      to should be a riscv,cpu-intc node, which has a CPU node (i.e. RISC-V
+      HART) as parent.
+
+  riscv,num-ids:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 63
+    maximum: 2047
+    description:
+      Number of interrupt identities supported by IMSIC interrupt file.
+
+  riscv,num-guest-ids:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 63
+    maximum: 2047
+    description:
+      Number of interrupt identities are supported by IMSIC guest interrupt
+      file. When not specified it is assumed to be same as specified by the
+      riscv,num-ids property.
+
+  riscv,guest-index-bits:
+    minimum: 0
+    maximum: 7
+    default: 0
+    description:
+      Number of guest index bits in the MSI target address.
+
+  riscv,hart-index-bits:
+    minimum: 0
+    maximum: 15
+    description:
+      Number of HART index bits in the MSI target address. When not
+      specified it is calculated based on the interrupts-extended property.
+
+  riscv,group-index-bits:
+    minimum: 0
+    maximum: 7
+    default: 0
+    description:
+      Number of group index bits in the MSI target address.
+
+  riscv,group-index-shift:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 55
+    default: 24
+    description:
+      The least significant bit position of the group index bits in the
+      MSI target address.
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - msi-controller
+  - "#msi-cells"
+  - interrupts-extended
+  - riscv,num-ids
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    // Example 1 (Machine-level IMSIC files with just one group):
+
+    interrupt-controller@24000000 {
+      compatible =3D "qemu,imsics", "riscv,imsics";
+      interrupts-extended =3D <&cpu1_intc 11>,
+                            <&cpu2_intc 11>,
+                            <&cpu3_intc 11>,
+                            <&cpu4_intc 11>;
+      reg =3D <0x28000000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells =3D <0>;
+      msi-controller;
+      #msi-cells =3D <0>;
+      riscv,num-ids =3D <127>;
+    };
+
+  - |
+    // Example 2 (Supervisor-level IMSIC files with two groups):
+
+    interrupt-controller@28000000 {
+      compatible =3D "qemu,imsics", "riscv,imsics";
+      interrupts-extended =3D <&cpu1_intc 9>,
+                            <&cpu2_intc 9>,
+                            <&cpu3_intc 9>,
+                            <&cpu4_intc 9>;
+      reg =3D <0x28000000 0x2000>, /* Group0 IMSICs */
+            <0x29000000 0x2000>; /* Group1 IMSICs */
+      interrupt-controller;
+      #interrupt-cells =3D <0>;
+      msi-controller;
+      #msi-cells =3D <0>;
+      riscv,num-ids =3D <127>;
+      riscv,group-index-bits =3D <1>;
+      riscv,group-index-shift =3D <24>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-=
exti.yaml b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-e=
xti.yaml
index 00c10a8258f1..9967e57b449b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.ya=
ml
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.ya=
ml
@@ -89,8 +89,23 @@ examples:
         reg =3D <0x5000d000 0x400>;
     };
=20
+  - |
     //Example 2
-    exti2: interrupt-controller@40013c00 {
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    exti2: interrupt-controller@5000d000 {
+        compatible =3D "st,stm32mp1-exti", "syscon";
+        interrupt-controller;
+        #interrupt-cells =3D <2>;
+        reg =3D <0x5000d000 0x400>;
+        interrupts-extended =3D
+            <&intc GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+            <0>,
+            <&intc GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+  - |
+    //Example 3
+    exti3: interrupt-controller@40013c00 {
         compatible =3D "st,stm32-exti";
         interrupt-controller;
         #interrupt-cells =3D <2>;
diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..adab4f3f609a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11435,6 +11435,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
 F:	Documentation/core-api/irq/irq-domain.rst
 F:	include/linux/irqdomain.h
+F:	include/linux/irqdomain_defs.h
 F:	kernel/irq/irqdomain.c
 F:	kernel/irq/msi.c
=20
@@ -11444,6 +11445,10 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
 F:	include/linux/group_cpus.h
+F:	include/linux/irq.h
+F:	include/linux/irqhandler.h
+F:	include/linux/irqnr.h
+F:	include/linux/irqreturn.h
 F:	kernel/irq/
 F:	lib/group_cpus.c
=20
@@ -11454,6 +11459,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
 F:	Documentation/devicetree/bindings/interrupt-controller/
 F:	drivers/irqchip/
+F:	include/linux/irqchip.h
=20
 ISA
 M:	William Breathitt Gray <william.gray@linaro.org>
@@ -18922,6 +18928,20 @@ S:	Maintained
 F:	drivers/mtd/nand/raw/r852.c
 F:	drivers/mtd/nand/raw/r852.h
=20
+RISC-V AIA DRIVERS
+M:	Anup Patel <anup@brainfault.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
+F:	drivers/irqchip/irq-riscv-aplic-*.c
+F:	drivers/irqchip/irq-riscv-aplic-*.h
+F:	drivers/irqchip/irq-riscv-imsic-*.c
+F:	drivers/irqchip/irq-riscv-imsic-*.h
+F:	drivers/irqchip/irq-riscv-intc.c
+F:	include/linux/irqchip/riscv-aplic.h
+F:	include/linux/irqchip/riscv-imsic.h
+
 RISC-V ARCHITECTURE
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Palmer Dabbelt <palmer@dabbelt.com>
diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm3=
2mp131.dtsi
index 3900f32da797..c432fe109cbe 100644
--- a/arch/arm/boot/dts/st/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
@@ -1093,10 +1093,82 @@ rcc: rcc@50000000 {
 		};
=20
 		exti: interrupt-controller@5000d000 {
-			compatible =3D "st,stm32mp13-exti", "syscon";
+			compatible =3D "st,stm32mp1-exti", "syscon";
 			interrupt-controller;
 			#interrupt-cells =3D <2>;
 			reg =3D <0x5000d000 0x400>;
+			interrupts-extended =3D
+				<&intc GIC_SPI 6   IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_0 */
+				<&intc GIC_SPI 7   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 8   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 9   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 10  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 24  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 65  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 66  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 67  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 68  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 41  IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_10 */
+				<&intc GIC_SPI 43  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 77  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 78  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 1   IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 3   IRQ_TYPE_LEVEL_HIGH>,
+				<0>,						/* EXTI_20 */
+				<&intc GIC_SPI 32  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 34  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 73  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 93  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 38  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 39  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 40  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 72  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 53  IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_30 */
+				<&intc GIC_SPI 54  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 83  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 84  IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,						/* EXTI_40 */
+				<0>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 96  IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 92  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_50 */
+				<0>,
+				<&intc GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,						/* EXTI_60 */
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 63  IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 98  IRQ_TYPE_LEVEL_HIGH>;	/* EXTI_70 */
 		};
=20
 		syscfg: syscon@50020000 {
diff --git a/arch/arm/boot/dts/st/stm32mp151.dtsi b/arch/arm/boot/dts/st/stm3=
2mp151.dtsi
index fa4cbd312e5a..bcb3ed94b265 100644
--- a/arch/arm/boot/dts/st/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp151.dtsi
@@ -1224,6 +1224,81 @@ exti: interrupt-controller@5000d000 {
 			interrupt-controller;
 			#interrupt-cells =3D <2>;
 			reg =3D <0x5000d000 0x400>;
+			interrupts-extended =3D
+				<&intc GIC_SPI 6   IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_0 */
+				<&intc GIC_SPI 7   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 8   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 9   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 10  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 23  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 64  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 65  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 66  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 67  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 40  IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_10 */
+				<&intc GIC_SPI 42  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 76  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 77  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 1   IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 3   IRQ_TYPE_LEVEL_HIGH>,
+				<0>,						/* EXTI_20 */
+				<&intc GIC_SPI 31  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 33  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 72  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 95  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 37  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 38  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 39  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 71  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 52  IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_30 */
+				<&intc GIC_SPI 53  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 82  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 83  IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,						/* EXTI_40 */
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 93  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_50 */
+				<0>,
+				<&intc GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,						/* EXTI_60 */
+				<&intc GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 62  IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_70 */
+				<0>,
+				<0>,
+				<&intc GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
 		};
=20
 		syscfg: syscon@50020000 {
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 24335565bad5..19bf58a9d5e1 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -302,6 +302,7 @@ config ARCH_STM32
 	select GPIOLIB
 	select PINCTRL
 	select PINCTRL_STM32MP257
+	select STM32_EXTI
 	select ARM_SMC_MBOX
 	select ARM_SCMI_PROTOCOL
 	select COMMON_CLK_SCMI
diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/=
stm32mp251.dtsi
index 5dd4f3580a60..e7d1614dc744 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -168,6 +168,99 @@ package_otp@1e8 {
 			};
 		};
=20
+		exti1: interrupt-controller@44220000 {
+			compatible =3D "st,stm32mp1-exti", "syscon";
+			interrupt-controller;
+			#interrupt-cells =3D <2>;
+			reg =3D <0x44220000 0x400>;
+			interrupts-extended =3D
+				<&intc GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_0 */
+				<&intc GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_10 */
+				<&intc GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 1   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,						/* EXTI_20 */
+				<&intc GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_30 */
+				<&intc GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_40 */
+				<&intc GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_50 */
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,						/* EXTI_60 */
+				<&intc GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 10  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_70 */
+				<0>,
+				<&intc GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,						/* EXTI_80 */
+				<0>,
+				<0>,
+				<&intc GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		syscfg: syscon@44230000 {
 			compatible =3D "st,stm32mp25-syscfg", "syscon";
 			reg =3D <0x44230000 0x10000>;
@@ -178,6 +271,8 @@ pinctrl: pinctrl@44240000 {
 			#size-cells =3D <1>;
 			compatible =3D "st,stm32mp257-pinctrl";
 			ranges =3D <0 0x44240000 0xa0400>;
+			interrupt-parent =3D <&exti1>;
+			st,syscfg =3D <&exti1 0x60 0xff>;
 			pins-are-numbered;
=20
 			gpioa: gpio@44240000 {
@@ -307,6 +402,8 @@ pinctrl_z: pinctrl@46200000 {
 			#size-cells =3D <1>;
 			compatible =3D "st,stm32mp257-z-pinctrl";
 			ranges =3D <0 0x46200000 0x400>;
+			interrupt-parent =3D <&exti1>;
+			st,syscfg =3D <&exti1 0x60 0xff>;
 			pins-are-numbered;
=20
 			gpioz: gpio@46200000 {
@@ -322,5 +419,84 @@ gpioz: gpio@46200000 {
 			};
=20
 		};
+
+		exti2: interrupt-controller@46230000 {
+			compatible =3D "st,stm32mp1-exti", "syscon";
+			interrupt-controller;
+			#interrupt-cells =3D <2>;
+			reg =3D <0x46230000 0x400>;
+			interrupts-extended =3D
+				<&intc GIC_SPI 17  IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_0 */
+				<&intc GIC_SPI 18  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 19  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 20  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 21  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 22  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 23  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 24  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 25  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 26  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 27  IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_10 */
+				<&intc GIC_SPI 28  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 29  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 30  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 31  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 32  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 12  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 13  IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<0>,						/* EXTI_20 */
+				<&intc GIC_SPI 14  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 15  IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_30 */
+				<&intc GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_40 */
+				<0>,
+				<0>,
+				<&intc GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 11  IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 5   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 4   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 6   IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_50 */
+				<&intc GIC_SPI 7   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 2   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 3   IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,						/* EXTI_60 */
+				<&intc GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>;	/* EXTI_70 */
+		};
 	};
 };
diff --git a/arch/mips/dec/setup.c b/arch/mips/dec/setup.c
index 6c3704f51d0d..87f0a1436bf9 100644
--- a/arch/mips/dec/setup.c
+++ b/arch/mips/dec/setup.c
@@ -756,7 +756,7 @@ void __init arch_init_irq(void)
 				NULL))
 			pr_err("Failed to register fpu interrupt\n");
 		desc_fpu =3D irq_to_desc(irq_fpu);
-		fpu_kstat_irq =3D this_cpu_ptr(desc_fpu->kstat_irqs);
+		fpu_kstat_irq =3D this_cpu_ptr(&desc_fpu->kstat_irqs->cnt);
 	}
 	if (dec_interrupt[DEC_IRQ_CASCADE] >=3D 0) {
 		if (request_irq(dec_interrupt[DEC_IRQ_CASCADE], no_action,
diff --git a/arch/parisc/kernel/smp.c b/arch/parisc/kernel/smp.c
index 444154271f23..800eb64e91ad 100644
--- a/arch/parisc/kernel/smp.c
+++ b/arch/parisc/kernel/smp.c
@@ -344,7 +344,7 @@ static int smp_boot_one_cpu(int cpuid, struct task_struct=
 *idle)
 		struct irq_desc *desc =3D irq_to_desc(i);
=20
 		if (desc && desc->kstat_irqs)
-			*per_cpu_ptr(desc->kstat_irqs, cpuid) =3D 0;
+			*per_cpu_ptr(desc->kstat_irqs, cpuid) =3D (struct irqstat) { };
 	}
 #endif
=20
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_h=
v_rm_xics.c
index e42984878503..f2636414d82a 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -837,7 +837,7 @@ static inline void this_cpu_inc_rm(unsigned int __percpu =
*addr)
  */
 static void kvmppc_rm_handle_irq_desc(struct irq_desc *desc)
 {
-	this_cpu_inc_rm(desc->kstat_irqs);
+	this_cpu_inc_rm(&desc->kstat_irqs->cnt);
 	__this_cpu_inc(kstat.irqs_sum);
 }
=20
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index be09c8836d56..9e87287942dc 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -173,6 +173,8 @@ config RISCV
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_MSI if PCI
 	select RISCV_ALTERNATIVE if !XIP_KERNEL
+	select RISCV_APLIC
+	select RISCV_IMSIC
 	select RISCV_INTC
 	select RISCV_TIMER if RISCV_SBI
 	select SIFIVE_PLIC
diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index 9acde71558d5..bb8761c8a42e 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -439,13 +439,8 @@ static int cpuidle_coupled_clear_pokes(int cpu)
=20
 static bool cpuidle_coupled_any_pokes_pending(struct cpuidle_coupled *couple=
d)
 {
-	cpumask_t cpus;
-	int ret;
-
-	cpumask_and(&cpus, cpu_online_mask, &coupled->coupled_cpus);
-	ret =3D cpumask_and(&cpus, &cpuidle_coupled_poke_pending, &cpus);
-
-	return ret;
+	return cpumask_first_and_and(cpu_online_mask, &coupled->coupled_cpus,
+				     &cpuidle_coupled_poke_pending) < nr_cpu_ids;
 }
=20
 /**
@@ -626,9 +621,7 @@ int cpuidle_enter_state_coupled(struct cpuidle_device *de=
v,
=20
 static void cpuidle_coupled_update_online_cpus(struct cpuidle_coupled *coupl=
ed)
 {
-	cpumask_t cpus;
-	cpumask_and(&cpus, cpu_online_mask, &coupled->coupled_cpus);
-	coupled->online_count =3D cpumask_weight(&cpus);
+	coupled->online_count =3D cpumask_weight_and(cpu_online_mask, &coupled->cou=
pled_cpus);
 }
=20
 /**
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 72c07a12f5e1..14464716bacb 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -540,6 +540,31 @@ config RISCV_INTC
 	depends on RISCV
 	select IRQ_DOMAIN_HIERARCHY
=20
+config RISCV_APLIC
+	bool
+	depends on RISCV
+	select IRQ_DOMAIN_HIERARCHY
+
+config RISCV_APLIC_MSI
+	bool
+	depends on RISCV_APLIC
+	select GENERIC_MSI_IRQ
+	default RISCV_APLIC
+
+config RISCV_IMSIC
+	bool
+	depends on RISCV
+	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_IRQ_MATRIX_ALLOCATOR
+	select GENERIC_MSI_IRQ
+
+config RISCV_IMSIC_PCI
+	bool
+	depends on RISCV_IMSIC
+	depends on PCI
+	depends on PCI_MSI
+	default RISCV_IMSIC
+
 config SIFIVE_PLIC
 	bool
 	depends on RISCV
@@ -568,7 +593,7 @@ config IRQ_LOONGARCH_CPU
 	bool
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 	select LOONGSON_HTVEC
 	select LOONGSON_LIOINTC
 	select LOONGSON_EIOINTC
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index ec4a18380998..d9dc3d99aaa8 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -95,6 +95,9 @@ obj-$(CONFIG_QCOM_MPM)			+=3D irq-qcom-mpm.o
 obj-$(CONFIG_CSKY_MPINTC)		+=3D irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+=3D irq-csky-apb-intc.o
 obj-$(CONFIG_RISCV_INTC)		+=3D irq-riscv-intc.o
+obj-$(CONFIG_RISCV_APLIC)		+=3D irq-riscv-aplic-main.o irq-riscv-aplic-direc=
t.o
+obj-$(CONFIG_RISCV_APLIC_MSI)		+=3D irq-riscv-aplic-msi.o
+obj-$(CONFIG_RISCV_IMSIC)		+=3D irq-riscv-imsic-state.o irq-riscv-imsic-earl=
y.o irq-riscv-imsic-platform.o
 obj-$(CONFIG_SIFIVE_PLIC)		+=3D irq-sifive-plic.o
 obj-$(CONFIG_STARFIVE_JH8100_INTC)	+=3D irq-starfive-jh8100-intc.o
 obj-$(CONFIG_IMX_IRQSTEER)		+=3D irq-imx-irqsteer.o
diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-ms=
i.c
index 9c8b1349ee17..a1430ab60a8a 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -165,7 +165,7 @@ static int alpine_msix_middle_domain_alloc(struct irq_dom=
ain *domain,
 	return 0;
=20
 err_sgi:
-	irq_domain_free_irqs_parent(domain, virq, i - 1);
+	irq_domain_free_irqs_parent(domain, virq, i);
 	alpine_msix_free_sgi(priv, sgi, nr_irqs);
 	return err;
 }
diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l=
1.c
index eb02d203c963..90daa274ef23 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -192,14 +192,10 @@ static int bcm6345_l1_set_affinity(struct irq_data *d,
 	u32 mask =3D BIT(d->hwirq % IRQS_PER_WORD);
 	unsigned int old_cpu =3D cpu_for_irq(intc, d);
 	unsigned int new_cpu;
-	struct cpumask valid;
 	unsigned long flags;
 	bool enabled;
=20
-	if (!cpumask_and(&valid, &intc->cpumask, dest))
-		return -EINVAL;
-
-	new_cpu =3D cpumask_any_and(&valid, cpu_online_mask);
+	new_cpu =3D cpumask_first_and_and(&intc->cpumask, dest, cpu_online_mask);
 	if (new_cpu >=3D nr_cpu_ids)
 		return -EINVAL;
=20
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l=
2.c
index 2b0b3175cea0..c988886917f7 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -118,7 +118,7 @@ static void brcmstb_l2_intc_irq_handle(struct irq_desc *d=
esc)
 	chained_irq_exit(chip, desc);
 }
=20
-static void brcmstb_l2_intc_suspend(struct irq_data *d)
+static void __brcmstb_l2_intc_suspend(struct irq_data *d, bool save)
 {
 	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
 	struct irq_chip_type *ct =3D irq_data_get_chip_type(d);
@@ -127,7 +127,8 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
=20
 	irq_gc_lock_irqsave(gc, flags);
 	/* Save the current mask */
-	b->saved_mask =3D irq_reg_readl(gc, ct->regs.mask);
+	if (save)
+		b->saved_mask =3D irq_reg_readl(gc, ct->regs.mask);
=20
 	if (b->can_wake) {
 		/* Program the wakeup mask */
@@ -137,6 +138,16 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
 	irq_gc_unlock_irqrestore(gc, flags);
 }
=20
+static void brcmstb_l2_intc_shutdown(struct irq_data *d)
+{
+	__brcmstb_l2_intc_suspend(d, false);
+}
+
+static void brcmstb_l2_intc_suspend(struct irq_data *d)
+{
+	__brcmstb_l2_intc_suspend(d, true);
+}
+
 static void brcmstb_l2_intc_resume(struct irq_data *d)
 {
 	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
@@ -252,7 +263,7 @@ static int __init brcmstb_l2_intc_of_init(struct device_n=
ode *np,
=20
 	ct->chip.irq_suspend =3D brcmstb_l2_intc_suspend;
 	ct->chip.irq_resume =3D brcmstb_l2_intc_resume;
-	ct->chip.irq_pm_shutdown =3D brcmstb_l2_intc_suspend;
+	ct->chip.irq_pm_shutdown =3D brcmstb_l2_intc_shutdown;
=20
 	if (data->can_wake) {
 		/* This IRQ chip can wake the system, set all child interrupts
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index fca888b36680..98e559304b7f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3826,9 +3826,9 @@ static int its_vpe_set_affinity(struct irq_data *d,
 				bool force)
 {
 	struct its_vpe *vpe =3D irq_data_get_irq_chip_data(d);
-	struct cpumask common, *table_mask;
+	unsigned int from, cpu =3D nr_cpu_ids;
+	struct cpumask *table_mask;
 	unsigned long flags;
-	int from, cpu;
=20
 	/*
 	 * Changing affinity is mega expensive, so let's be as lazy as
@@ -3850,10 +3850,15 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	 * If we are offered another CPU in the same GICv4.1 ITS
 	 * affinity, pick this one. Otherwise, any CPU will do.
 	 */
-	if (table_mask && cpumask_and(&common, mask_val, table_mask))
-		cpu =3D cpumask_test_cpu(from, &common) ? from : cpumask_first(&common);
-	else
+	if (table_mask)
+		cpu =3D cpumask_any_and(mask_val, table_mask);
+	if (cpu < nr_cpu_ids) {
+		if (cpumask_test_cpu(from, mask_val) &&
+		    cpumask_test_cpu(from, table_mask))
+			cpu =3D from;
+	} else {
 		cpu =3D cpumask_first(mask_val);
+	}
=20
 	if (from =3D=3D cpu)
 		goto out;
@@ -4521,8 +4526,6 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *=
domain, unsigned int virq
 	struct page *vprop_page;
 	int base, nr_ids, i, err =3D 0;
=20
-	BUG_ON(!vm);
-
 	bitmap =3D its_lpi_alloc(roundup_pow_of_two(nr_irqs), &base, &nr_ids);
 	if (!bitmap)
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loo=
ngson-eiointc.c
index b64cbe3052e8..c7ddebf312ad 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -59,6 +59,7 @@ static int cpu_to_eio_node(int cpu)
 	return cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
 }
=20
+#ifdef CONFIG_SMP
 static void eiointc_set_irq_route(int pos, unsigned int cpu, unsigned int mn=
ode, nodemask_t *node_map)
 {
 	int i, node, cpu_node, route_node;
@@ -92,19 +93,15 @@ static int eiointc_set_irq_affinity(struct irq_data *d, c=
onst struct cpumask *af
 	unsigned int cpu;
 	unsigned long flags;
 	uint32_t vector, regaddr;
-	struct cpumask intersect_affinity;
 	struct eiointc_priv *priv =3D d->domain->host_data;
=20
 	raw_spin_lock_irqsave(&affinity_lock, flags);
=20
-	cpumask_and(&intersect_affinity, affinity, cpu_online_mask);
-	cpumask_and(&intersect_affinity, &intersect_affinity, &priv->cpuspan_map);
-
-	if (cpumask_empty(&intersect_affinity)) {
+	cpu =3D cpumask_first_and_and(&priv->cpuspan_map, affinity, cpu_online_mask=
);
+	if (cpu >=3D nr_cpu_ids) {
 		raw_spin_unlock_irqrestore(&affinity_lock, flags);
 		return -EINVAL;
 	}
-	cpu =3D cpumask_first(&intersect_affinity);
=20
 	vector =3D d->hwirq;
 	regaddr =3D EIOINTC_REG_ENABLE + ((vector >> 5) << 2);
@@ -126,6 +123,7 @@ static int eiointc_set_irq_affinity(struct irq_data *d, c=
onst struct cpumask *af
=20
 	return IRQ_SET_MASK_OK;
 }
+#endif
=20
 static int eiointc_index(int node)
 {
@@ -238,7 +236,9 @@ static struct irq_chip eiointc_irq_chip =3D {
 	.irq_ack		=3D eiointc_ack_irq,
 	.irq_mask		=3D eiointc_mask_irq,
 	.irq_unmask		=3D eiointc_unmask_irq,
+#ifdef CONFIG_SMP
 	.irq_set_affinity	=3D eiointc_set_irq_affinity,
+#endif
 };
=20
 static int eiointc_domain_alloc(struct irq_domain *domain, unsigned int virq,
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loo=
ngson-pch-msi.c
index 6e1e1f011bb2..dd4d699170f4 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -136,7 +136,7 @@ static int pch_msi_middle_domain_alloc(struct irq_domain =
*domain,
=20
 err_hwirq:
 	pch_msi_free_hwirq(priv, hwirq, nr_irqs);
-	irq_domain_free_irqs_parent(domain, virq, i - 1);
+	irq_domain_free_irqs_parent(domain, virq, i);
=20
 	return err;
 }
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loo=
ngson-pch-pic.c
index 63db8e2172e0..cbaef65e804c 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -33,6 +33,7 @@
 #define PIC_COUNT		(PIC_COUNT_PER_REG * PIC_REG_COUNT)
 #define PIC_REG_IDX(irq_id)	((irq_id) / PIC_COUNT_PER_REG)
 #define PIC_REG_BIT(irq_id)	((irq_id) % PIC_COUNT_PER_REG)
+#define PIC_UNDEF_VECTOR	255
=20
 static int nr_pics;
=20
@@ -46,12 +47,19 @@ struct pch_pic {
 	u32			saved_vec_en[PIC_REG_COUNT];
 	u32			saved_vec_pol[PIC_REG_COUNT];
 	u32			saved_vec_edge[PIC_REG_COUNT];
+	u8			table[PIC_COUNT];
+	int			inuse;
 };
=20
 static struct pch_pic *pch_pic_priv[MAX_IO_PICS];
=20
 struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
=20
+static inline u8 hwirq_to_bit(struct pch_pic *priv, int hirq)
+{
+	return priv->table[hirq];
+}
+
 static void pch_pic_bitset(struct pch_pic *priv, int offset, int bit)
 {
 	u32 reg;
@@ -80,45 +88,47 @@ static void pch_pic_mask_irq(struct irq_data *d)
 {
 	struct pch_pic *priv =3D irq_data_get_irq_chip_data(d);
=20
-	pch_pic_bitset(priv, PCH_PIC_MASK, d->hwirq);
+	pch_pic_bitset(priv, PCH_PIC_MASK, hwirq_to_bit(priv, d->hwirq));
 	irq_chip_mask_parent(d);
 }
=20
 static void pch_pic_unmask_irq(struct irq_data *d)
 {
 	struct pch_pic *priv =3D irq_data_get_irq_chip_data(d);
+	int bit =3D hwirq_to_bit(priv, d->hwirq);
=20
-	writel(BIT(PIC_REG_BIT(d->hwirq)),
-			priv->base + PCH_PIC_CLR + PIC_REG_IDX(d->hwirq) * 4);
+	writel(BIT(PIC_REG_BIT(bit)),
+			priv->base + PCH_PIC_CLR + PIC_REG_IDX(bit) * 4);
=20
 	irq_chip_unmask_parent(d);
-	pch_pic_bitclr(priv, PCH_PIC_MASK, d->hwirq);
+	pch_pic_bitclr(priv, PCH_PIC_MASK, bit);
 }
=20
 static int pch_pic_set_type(struct irq_data *d, unsigned int type)
 {
 	struct pch_pic *priv =3D irq_data_get_irq_chip_data(d);
+	int bit =3D hwirq_to_bit(priv, d->hwirq);
 	int ret =3D 0;
=20
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
-		pch_pic_bitset(priv, PCH_PIC_EDGE, d->hwirq);
-		pch_pic_bitclr(priv, PCH_PIC_POL, d->hwirq);
+		pch_pic_bitset(priv, PCH_PIC_EDGE, bit);
+		pch_pic_bitclr(priv, PCH_PIC_POL, bit);
 		irq_set_handler_locked(d, handle_edge_irq);
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
-		pch_pic_bitset(priv, PCH_PIC_EDGE, d->hwirq);
-		pch_pic_bitset(priv, PCH_PIC_POL, d->hwirq);
+		pch_pic_bitset(priv, PCH_PIC_EDGE, bit);
+		pch_pic_bitset(priv, PCH_PIC_POL, bit);
 		irq_set_handler_locked(d, handle_edge_irq);
 		break;
 	case IRQ_TYPE_LEVEL_HIGH:
-		pch_pic_bitclr(priv, PCH_PIC_EDGE, d->hwirq);
-		pch_pic_bitclr(priv, PCH_PIC_POL, d->hwirq);
+		pch_pic_bitclr(priv, PCH_PIC_EDGE, bit);
+		pch_pic_bitclr(priv, PCH_PIC_POL, bit);
 		irq_set_handler_locked(d, handle_level_irq);
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
-		pch_pic_bitclr(priv, PCH_PIC_EDGE, d->hwirq);
-		pch_pic_bitset(priv, PCH_PIC_POL, d->hwirq);
+		pch_pic_bitclr(priv, PCH_PIC_EDGE, bit);
+		pch_pic_bitset(priv, PCH_PIC_POL, bit);
 		irq_set_handler_locked(d, handle_level_irq);
 		break;
 	default:
@@ -133,11 +143,12 @@ static void pch_pic_ack_irq(struct irq_data *d)
 {
 	unsigned int reg;
 	struct pch_pic *priv =3D irq_data_get_irq_chip_data(d);
+	int bit =3D hwirq_to_bit(priv, d->hwirq);
=20
-	reg =3D readl(priv->base + PCH_PIC_EDGE + PIC_REG_IDX(d->hwirq) * 4);
-	if (reg & BIT(PIC_REG_BIT(d->hwirq))) {
-		writel(BIT(PIC_REG_BIT(d->hwirq)),
-			priv->base + PCH_PIC_CLR + PIC_REG_IDX(d->hwirq) * 4);
+	reg =3D readl(priv->base + PCH_PIC_EDGE + PIC_REG_IDX(bit) * 4);
+	if (reg & BIT(PIC_REG_BIT(bit))) {
+		writel(BIT(PIC_REG_BIT(bit)),
+			priv->base + PCH_PIC_CLR + PIC_REG_IDX(bit) * 4);
 	}
 	irq_chip_ack_parent(d);
 }
@@ -159,6 +170,8 @@ static int pch_pic_domain_translate(struct irq_domain *d,
 {
 	struct pch_pic *priv =3D d->host_data;
 	struct device_node *of_node =3D to_of_node(fwspec->fwnode);
+	unsigned long flags;
+	int i;
=20
 	if (of_node) {
 		if (fwspec->param_count < 2)
@@ -171,12 +184,33 @@ static int pch_pic_domain_translate(struct irq_domain *=
d,
 			return -EINVAL;
=20
 		*hwirq =3D fwspec->param[0] - priv->gsi_base;
+
 		if (fwspec->param_count > 1)
 			*type =3D fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
 		else
 			*type =3D IRQ_TYPE_NONE;
 	}
=20
+	raw_spin_lock_irqsave(&priv->pic_lock, flags);
+	/* Check pic-table to confirm if the hwirq has been assigned */
+	for (i =3D 0; i < priv->inuse; i++) {
+		if (priv->table[i] =3D=3D *hwirq) {
+			*hwirq =3D i;
+			break;
+		}
+	}
+	if (i =3D=3D priv->inuse) {
+		/* Assign a new hwirq in pic-table */
+		if (priv->inuse >=3D PIC_COUNT) {
+			pr_err("pch-pic domain has no free vectors\n");
+			raw_spin_unlock_irqrestore(&priv->pic_lock, flags);
+			return -EINVAL;
+		}
+		priv->table[priv->inuse] =3D *hwirq;
+		*hwirq =3D priv->inuse++;
+	}
+	raw_spin_unlock_irqrestore(&priv->pic_lock, flags);
+
 	return 0;
 }
=20
@@ -194,6 +228,9 @@ static int pch_pic_alloc(struct irq_domain *domain, unsig=
ned int virq,
 	if (err)
 		return err;
=20
+	/* Write vector ID */
+	writeb(priv->ht_vec_base + hwirq, priv->base + PCH_INT_HTVEC(hwirq_to_bit(p=
riv, hwirq)));
+
 	parent_fwspec.fwnode =3D domain->parent->fwnode;
 	parent_fwspec.param_count =3D 1;
 	parent_fwspec.param[0] =3D hwirq + priv->ht_vec_base;
@@ -222,7 +259,7 @@ static void pch_pic_reset(struct pch_pic *priv)
=20
 	for (i =3D 0; i < PIC_COUNT; i++) {
 		/* Write vector ID */
-		writeb(priv->ht_vec_base + i, priv->base + PCH_INT_HTVEC(i));
+		writeb(priv->ht_vec_base + i, priv->base + PCH_INT_HTVEC(hwirq_to_bit(priv=
, i)));
 		/* Hardcode route to HT0 Lo */
 		writeb(1, priv->base + PCH_INT_ROUTE(i));
 	}
@@ -284,6 +321,7 @@ static int pch_pic_init(phys_addr_t addr, unsigned long s=
ize, int vec_base,
 			u32 gsi_base)
 {
 	struct pch_pic *priv;
+	int i;
=20
 	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -294,6 +332,10 @@ static int pch_pic_init(phys_addr_t addr, unsigned long =
size, int vec_base,
 	if (!priv->base)
 		goto free_priv;
=20
+	priv->inuse =3D 0;
+	for (i =3D 0; i < PIC_COUNT; i++)
+		priv->table[i] =3D PIC_UNDEF_VECTOR;
+
 	priv->ht_vec_base =3D vec_base;
 	priv->vec_count =3D ((readq(priv->base) >> 48) & 0xff) + 1;
 	priv->gsi_base =3D gsi_base;
diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
index be9680645545..d67b5da38982 100644
--- a/drivers/irqchip/irq-mxs.c
+++ b/drivers/irqchip/irq-mxs.c
@@ -130,7 +130,7 @@ static struct irq_chip asm9260_icoll_chip =3D {
 		 IRQCHIP_SKIP_SET_WAKE,
 };
=20
-asmlinkage void __exception_irq_entry icoll_handle_irq(struct pt_regs *regs)
+static void __exception_irq_entry icoll_handle_irq(struct pt_regs *regs)
 {
 	u32 irqnr;
=20
diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesa=
s-rzg2l.c
index ae67fec2ab46..f6484bf15e0b 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -138,7 +138,7 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
 	irq_chip_eoi_parent(d);
 }
=20
-static void rzg2l_irqc_irq_disable(struct irq_data *d)
+static void rzg2l_tint_irq_endisable(struct irq_data *d, bool enable)
 {
 	unsigned int hw_irq =3D irqd_to_hwirq(d);
=20
@@ -151,30 +151,24 @@ static void rzg2l_irqc_irq_disable(struct irq_data *d)
=20
 		raw_spin_lock(&priv->lock);
 		reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
-		reg &=3D ~(TIEN << TSSEL_SHIFT(tssr_offset));
+		if (enable)
+			reg |=3D TIEN << TSSEL_SHIFT(tssr_offset);
+		else
+			reg &=3D ~(TIEN << TSSEL_SHIFT(tssr_offset));
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
 		raw_spin_unlock(&priv->lock);
 	}
+}
+
+static void rzg2l_irqc_irq_disable(struct irq_data *d)
+{
+	rzg2l_tint_irq_endisable(d, false);
 	irq_chip_disable_parent(d);
 }
=20
 static void rzg2l_irqc_irq_enable(struct irq_data *d)
 {
-	unsigned int hw_irq =3D irqd_to_hwirq(d);
-
-	if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
-		struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
-		u32 offset =3D hw_irq - IRQC_TINT_START;
-		u32 tssr_offset =3D TSSR_OFFSET(offset);
-		u8 tssr_index =3D TSSR_INDEX(offset);
-		u32 reg;
-
-		raw_spin_lock(&priv->lock);
-		reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
-		reg |=3D TIEN << TSSEL_SHIFT(tssr_offset);
-		writel_relaxed(reg, priv->base + TSSR(tssr_index));
-		raw_spin_unlock(&priv->lock);
-	}
+	rzg2l_tint_irq_endisable(d, true);
 	irq_chip_enable_parent(d);
 }
=20
diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-r=
iscv-aplic-direct.c
new file mode 100644
index 000000000000..4a3ffe856d6c
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-aplic-direct.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cpu.h>
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/riscv-aplic.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/printk.h>
+#include <linux/smp.h>
+
+#include "irq-riscv-aplic-main.h"
+
+#define APLIC_DISABLE_IDELIVERY		0
+#define APLIC_ENABLE_IDELIVERY		1
+#define APLIC_DISABLE_ITHRESHOLD	1
+#define APLIC_ENABLE_ITHRESHOLD		0
+
+struct aplic_direct {
+	struct aplic_priv	priv;
+	struct irq_domain	*irqdomain;
+	struct cpumask		lmask;
+};
+
+struct aplic_idc {
+	unsigned int		hart_index;
+	void __iomem		*regs;
+	struct aplic_direct	*direct;
+};
+
+static unsigned int aplic_direct_parent_irq;
+static DEFINE_PER_CPU(struct aplic_idc, aplic_idcs);
+
+static void aplic_direct_irq_eoi(struct irq_data *d)
+{
+	/*
+	 * The fasteoi_handler requires irq_eoi() callback hence
+	 * provide a dummy handler.
+	 */
+}
+
+#ifdef CONFIG_SMP
+static int aplic_direct_set_affinity(struct irq_data *d, const struct cpumas=
k *mask_val,
+				     bool force)
+{
+	struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
+	struct aplic_direct *direct =3D container_of(priv, struct aplic_direct, pri=
v);
+	struct aplic_idc *idc;
+	unsigned int cpu, val;
+	void __iomem *target;
+
+	if (force)
+		cpu =3D cpumask_first_and(&direct->lmask, mask_val);
+	else
+		cpu =3D cpumask_first_and_and(&direct->lmask, mask_val, cpu_online_mask);
+
+	if (cpu >=3D nr_cpu_ids)
+		return -EINVAL;
+
+	idc =3D per_cpu_ptr(&aplic_idcs, cpu);
+	target =3D priv->regs + APLIC_TARGET_BASE + (d->hwirq - 1) * sizeof(u32);
+	val =3D FIELD_PREP(APLIC_TARGET_HART_IDX, idc->hart_index);
+	val |=3D FIELD_PREP(APLIC_TARGET_IPRIO, APLIC_DEFAULT_PRIORITY);
+	writel(val, target);
+
+	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	return IRQ_SET_MASK_OK_DONE;
+}
+#endif
+
+static struct irq_chip aplic_direct_chip =3D {
+	.name		=3D "APLIC-DIRECT",
+	.irq_mask	=3D aplic_irq_mask,
+	.irq_unmask	=3D aplic_irq_unmask,
+	.irq_set_type	=3D aplic_irq_set_type,
+	.irq_eoi	=3D aplic_direct_irq_eoi,
+#ifdef CONFIG_SMP
+	.irq_set_affinity =3D aplic_direct_set_affinity,
+#endif
+	.flags		=3D IRQCHIP_SET_TYPE_MASKED |
+			  IRQCHIP_SKIP_SET_WAKE |
+			  IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static int aplic_direct_irqdomain_translate(struct irq_domain *d, struct irq=
_fwspec *fwspec,
+					    unsigned long *hwirq, unsigned int *type)
+{
+	struct aplic_priv *priv =3D d->host_data;
+
+	return aplic_irqdomain_translate(fwspec, priv->gsi_base, hwirq, type);
+}
+
+static int aplic_direct_irqdomain_alloc(struct irq_domain *domain, unsigned =
int virq,
+					unsigned int nr_irqs, void *arg)
+{
+	struct aplic_priv *priv =3D domain->host_data;
+	struct aplic_direct *direct =3D container_of(priv, struct aplic_direct, pri=
v);
+	struct irq_fwspec *fwspec =3D arg;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int i, ret;
+
+	ret =3D aplic_irqdomain_translate(fwspec, priv->gsi_base, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i =3D 0; i < nr_irqs; i++) {
+		irq_domain_set_info(domain, virq + i, hwirq + i, &aplic_direct_chip,
+				    priv, handle_fasteoi_irq, NULL, NULL);
+		irq_set_affinity(virq + i, &direct->lmask);
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops aplic_direct_irqdomain_ops =3D {
+	.translate	=3D aplic_direct_irqdomain_translate,
+	.alloc		=3D aplic_direct_irqdomain_alloc,
+	.free		=3D irq_domain_free_irqs_top,
+};
+
+/*
+ * To handle an APLIC direct interrupts, we just read the CLAIMI register
+ * which will return highest priority pending interrupt and clear the
+ * pending bit of the interrupt. This process is repeated until CLAIMI
+ * register return zero value.
+ */
+static void aplic_direct_handle_irq(struct irq_desc *desc)
+{
+	struct aplic_idc *idc =3D this_cpu_ptr(&aplic_idcs);
+	struct irq_domain *irqdomain =3D idc->direct->irqdomain;
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+	irq_hw_number_t hw_irq;
+	int irq;
+
+	chained_irq_enter(chip, desc);
+
+	while ((hw_irq =3D readl(idc->regs + APLIC_IDC_CLAIMI))) {
+		hw_irq =3D hw_irq >> APLIC_IDC_TOPI_ID_SHIFT;
+		irq =3D irq_find_mapping(irqdomain, hw_irq);
+
+		if (unlikely(irq <=3D 0)) {
+			dev_warn_ratelimited(idc->direct->priv.dev,
+					     "hw_irq %lu mapping not found\n", hw_irq);
+		} else {
+			generic_handle_irq(irq);
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void aplic_idc_set_delivery(struct aplic_idc *idc, bool en)
+{
+	u32 de =3D (en) ? APLIC_ENABLE_IDELIVERY : APLIC_DISABLE_IDELIVERY;
+	u32 th =3D (en) ? APLIC_ENABLE_ITHRESHOLD : APLIC_DISABLE_ITHRESHOLD;
+
+	/* Priority must be less than threshold for interrupt triggering */
+	writel(th, idc->regs + APLIC_IDC_ITHRESHOLD);
+
+	/* Delivery must be set to 1 for interrupt triggering */
+	writel(de, idc->regs + APLIC_IDC_IDELIVERY);
+}
+
+static int aplic_direct_dying_cpu(unsigned int cpu)
+{
+	if (aplic_direct_parent_irq)
+		disable_percpu_irq(aplic_direct_parent_irq);
+
+	return 0;
+}
+
+static int aplic_direct_starting_cpu(unsigned int cpu)
+{
+	if (aplic_direct_parent_irq) {
+		enable_percpu_irq(aplic_direct_parent_irq,
+				  irq_get_trigger_type(aplic_direct_parent_irq));
+	}
+
+	return 0;
+}
+
+static int aplic_direct_parse_parent_hwirq(struct device *dev, u32 index,
+					   u32 *parent_hwirq, unsigned long *parent_hartid)
+{
+	struct of_phandle_args parent;
+	int rc;
+
+	/*
+	 * Currently, only OF fwnode is supported so extend this
+	 * function for ACPI support.
+	 */
+	if (!is_of_node(dev->fwnode))
+		return -EINVAL;
+
+	rc =3D of_irq_parse_one(to_of_node(dev->fwnode), index, &parent);
+	if (rc)
+		return rc;
+
+	rc =3D riscv_of_parent_hartid(parent.np, parent_hartid);
+	if (rc)
+		return rc;
+
+	*parent_hwirq =3D parent.args[0];
+	return 0;
+}
+
+int aplic_direct_setup(struct device *dev, void __iomem *regs)
+{
+	int i, j, rc, cpu, current_cpu, setup_count =3D 0;
+	struct aplic_direct *direct;
+	struct irq_domain *domain;
+	struct aplic_priv *priv;
+	struct aplic_idc *idc;
+	unsigned long hartid;
+	u32 v, hwirq;
+
+	direct =3D devm_kzalloc(dev, sizeof(*direct), GFP_KERNEL);
+	if (!direct)
+		return -ENOMEM;
+	priv =3D &direct->priv;
+
+	rc =3D aplic_setup_priv(priv, dev, regs);
+	if (rc) {
+		dev_err(dev, "failed to create APLIC context\n");
+		return rc;
+	}
+
+	/* Setup per-CPU IDC and target CPU mask */
+	current_cpu =3D get_cpu();
+	for (i =3D 0; i < priv->nr_idcs; i++) {
+		rc =3D aplic_direct_parse_parent_hwirq(dev, i, &hwirq, &hartid);
+		if (rc) {
+			dev_warn(dev, "parent irq for IDC%d not found\n", i);
+			continue;
+		}
+
+		/*
+		 * Skip interrupts other than external interrupts for
+		 * current privilege level.
+		 */
+		if (hwirq !=3D RV_IRQ_EXT)
+			continue;
+
+		cpu =3D riscv_hartid_to_cpuid(hartid);
+		if (cpu < 0) {
+			dev_warn(dev, "invalid cpuid for IDC%d\n", i);
+			continue;
+		}
+
+		cpumask_set_cpu(cpu, &direct->lmask);
+
+		idc =3D per_cpu_ptr(&aplic_idcs, cpu);
+		idc->hart_index =3D i;
+		idc->regs =3D priv->regs + APLIC_IDC_BASE + i * APLIC_IDC_SIZE;
+		idc->direct =3D direct;
+
+		aplic_idc_set_delivery(idc, true);
+
+		/*
+		 * Boot cpu might not have APLIC hart_index =3D 0 so check
+		 * and update target registers of all interrupts.
+		 */
+		if (cpu =3D=3D current_cpu && idc->hart_index) {
+			v =3D FIELD_PREP(APLIC_TARGET_HART_IDX, idc->hart_index);
+			v |=3D FIELD_PREP(APLIC_TARGET_IPRIO, APLIC_DEFAULT_PRIORITY);
+			for (j =3D 1; j <=3D priv->nr_irqs; j++)
+				writel(v, priv->regs + APLIC_TARGET_BASE + (j - 1) * sizeof(u32));
+		}
+
+		setup_count++;
+	}
+	put_cpu();
+
+	/* Find parent domain and register chained handler */
+	domain =3D irq_find_matching_fwnode(riscv_get_intc_hwnode(),
+					  DOMAIN_BUS_ANY);
+	if (!aplic_direct_parent_irq && domain) {
+		aplic_direct_parent_irq =3D irq_create_mapping(domain, RV_IRQ_EXT);
+		if (aplic_direct_parent_irq) {
+			irq_set_chained_handler(aplic_direct_parent_irq,
+						aplic_direct_handle_irq);
+
+			/*
+			 * Setup CPUHP notifier to enable parent
+			 * interrupt on all CPUs
+			 */
+			cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+					  "irqchip/riscv/aplic:starting",
+					  aplic_direct_starting_cpu,
+					  aplic_direct_dying_cpu);
+		}
+	}
+
+	/* Fail if we were not able to setup IDC for any CPU */
+	if (!setup_count)
+		return -ENODEV;
+
+	/* Setup global config and interrupt delivery */
+	aplic_init_hw_global(priv, false);
+
+	/* Create irq domain instance for the APLIC */
+	direct->irqdomain =3D irq_domain_create_linear(dev->fwnode, priv->nr_irqs +=
 1,
+						     &aplic_direct_irqdomain_ops, priv);
+	if (!direct->irqdomain) {
+		dev_err(dev, "failed to create direct irq domain\n");
+		return -ENOMEM;
+	}
+
+	/* Advertise the interrupt controller */
+	dev_info(dev, "%d interrupts directly connected to %d CPUs\n",
+		 priv->nr_irqs, priv->nr_idcs);
+
+	return 0;
+}
diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-ris=
cv-aplic-main.c
new file mode 100644
index 000000000000..774a0c97fdab
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/irqchip/riscv-aplic.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+
+#include "irq-riscv-aplic-main.h"
+
+void aplic_irq_unmask(struct irq_data *d)
+{
+	struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
+
+	writel(d->hwirq, priv->regs + APLIC_SETIENUM);
+}
+
+void aplic_irq_mask(struct irq_data *d)
+{
+	struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
+
+	writel(d->hwirq, priv->regs + APLIC_CLRIENUM);
+}
+
+int aplic_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
+	void __iomem *sourcecfg;
+	u32 val =3D 0;
+
+	switch (type) {
+	case IRQ_TYPE_NONE:
+		val =3D APLIC_SOURCECFG_SM_INACTIVE;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		val =3D APLIC_SOURCECFG_SM_LEVEL_LOW;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		val =3D APLIC_SOURCECFG_SM_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		val =3D APLIC_SOURCECFG_SM_EDGE_FALL;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		val =3D APLIC_SOURCECFG_SM_EDGE_RISE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	sourcecfg =3D priv->regs + APLIC_SOURCECFG_BASE;
+	sourcecfg +=3D (d->hwirq - 1) * sizeof(u32);
+	writel(val, sourcecfg);
+
+	return 0;
+}
+
+int aplic_irqdomain_translate(struct irq_fwspec *fwspec, u32 gsi_base,
+			      unsigned long *hwirq, unsigned int *type)
+{
+	if (WARN_ON(fwspec->param_count < 2))
+		return -EINVAL;
+	if (WARN_ON(!fwspec->param[0]))
+		return -EINVAL;
+
+	/* For DT, gsi_base is always zero. */
+	*hwirq =3D fwspec->param[0] - gsi_base;
+	*type =3D fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+
+	WARN_ON(*type =3D=3D IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode)
+{
+	u32 val;
+#ifdef CONFIG_RISCV_M_MODE
+	u32 valh;
+
+	if (msi_mode) {
+		val =3D lower_32_bits(priv->msicfg.base_ppn);
+		valh =3D FIELD_PREP(APLIC_xMSICFGADDRH_BAPPN, upper_32_bits(priv->msicfg.b=
ase_ppn));
+		valh |=3D FIELD_PREP(APLIC_xMSICFGADDRH_LHXW, priv->msicfg.lhxw);
+		valh |=3D FIELD_PREP(APLIC_xMSICFGADDRH_HHXW, priv->msicfg.hhxw);
+		valh |=3D FIELD_PREP(APLIC_xMSICFGADDRH_LHXS, priv->msicfg.lhxs);
+		valh |=3D FIELD_PREP(APLIC_xMSICFGADDRH_HHXS, priv->msicfg.hhxs);
+		writel(val, priv->regs + APLIC_xMSICFGADDR);
+		writel(valh, priv->regs + APLIC_xMSICFGADDRH);
+	}
+#endif
+
+	/* Setup APLIC domaincfg register */
+	val =3D readl(priv->regs + APLIC_DOMAINCFG);
+	val |=3D APLIC_DOMAINCFG_IE;
+	if (msi_mode)
+		val |=3D APLIC_DOMAINCFG_DM;
+	writel(val, priv->regs + APLIC_DOMAINCFG);
+	if (readl(priv->regs + APLIC_DOMAINCFG) !=3D val)
+		dev_warn(priv->dev, "unable to write 0x%x in domaincfg\n", val);
+}
+
+static void aplic_init_hw_irqs(struct aplic_priv *priv)
+{
+	int i;
+
+	/* Disable all interrupts */
+	for (i =3D 0; i <=3D priv->nr_irqs; i +=3D 32)
+		writel(-1U, priv->regs + APLIC_CLRIE_BASE + (i / 32) * sizeof(u32));
+
+	/* Set interrupt type and default priority for all interrupts */
+	for (i =3D 1; i <=3D priv->nr_irqs; i++) {
+		writel(0, priv->regs + APLIC_SOURCECFG_BASE + (i - 1) * sizeof(u32));
+		writel(APLIC_DEFAULT_PRIORITY,
+		       priv->regs + APLIC_TARGET_BASE + (i - 1) * sizeof(u32));
+	}
+
+	/* Clear APLIC domaincfg */
+	writel(0, priv->regs + APLIC_DOMAINCFG);
+}
+
+int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void __iom=
em *regs)
+{
+	struct of_phandle_args parent;
+	int rc;
+
+	/*
+	 * Currently, only OF fwnode is supported so extend this
+	 * function for ACPI support.
+	 */
+	if (!is_of_node(dev->fwnode))
+		return -EINVAL;
+
+	/* Save device pointer and register base */
+	priv->dev =3D dev;
+	priv->regs =3D regs;
+
+	/* Find out number of interrupt sources */
+	rc =3D of_property_read_u32(to_of_node(dev->fwnode), "riscv,num-sources",
+				  &priv->nr_irqs);
+	if (rc) {
+		dev_err(dev, "failed to get number of interrupt sources\n");
+		return rc;
+	}
+
+	/*
+	 * Find out number of IDCs based on parent interrupts
+	 *
+	 * If "msi-parent" property is present then we ignore the
+	 * APLIC IDCs which forces the APLIC driver to use MSI mode.
+	 */
+	if (!of_property_present(to_of_node(dev->fwnode), "msi-parent")) {
+		while (!of_irq_parse_one(to_of_node(dev->fwnode), priv->nr_idcs, &parent))
+			priv->nr_idcs++;
+	}
+
+	/* Setup initial state APLIC interrupts */
+	aplic_init_hw_irqs(priv);
+
+	return 0;
+}
+
+static int aplic_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	bool msi_mode =3D false;
+	void __iomem *regs;
+	int rc;
+
+	/* Map the MMIO registers */
+	regs =3D devm_platform_ioremap_resource(pdev, 0);
+	if (!regs) {
+		dev_err(dev, "failed map MMIO registers\n");
+		return -ENOMEM;
+	}
+
+	/*
+	 * If msi-parent property is present then setup APLIC MSI
+	 * mode otherwise setup APLIC direct mode.
+	 */
+	if (is_of_node(dev->fwnode))
+		msi_mode =3D of_property_present(to_of_node(dev->fwnode), "msi-parent");
+	if (msi_mode)
+		rc =3D aplic_msi_setup(dev, regs);
+	else
+		rc =3D aplic_direct_setup(dev, regs);
+	if (rc)
+		dev_err(dev, "failed to setup APLIC in %s mode\n", msi_mode ? "MSI" : "dir=
ect");
+
+	return rc;
+}
+
+static const struct of_device_id aplic_match[] =3D {
+	{ .compatible =3D "riscv,aplic" },
+	{}
+};
+
+static struct platform_driver aplic_driver =3D {
+	.driver =3D {
+		.name		=3D "riscv-aplic",
+		.of_match_table	=3D aplic_match,
+	},
+	.probe =3D aplic_probe,
+};
+builtin_platform_driver(aplic_driver);
diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqchip/irq-ris=
cv-aplic-main.h
new file mode 100644
index 000000000000..4393927d8c80
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-aplic-main.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#ifndef _IRQ_RISCV_APLIC_MAIN_H
+#define _IRQ_RISCV_APLIC_MAIN_H
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/fwnode.h>
+
+#define APLIC_DEFAULT_PRIORITY		1
+
+struct aplic_msicfg {
+	phys_addr_t		base_ppn;
+	u32			hhxs;
+	u32			hhxw;
+	u32			lhxs;
+	u32			lhxw;
+};
+
+struct aplic_priv {
+	struct device		*dev;
+	u32			gsi_base;
+	u32			nr_irqs;
+	u32			nr_idcs;
+	void __iomem		*regs;
+	struct aplic_msicfg	msicfg;
+};
+
+void aplic_irq_unmask(struct irq_data *d);
+void aplic_irq_mask(struct irq_data *d);
+int aplic_irq_set_type(struct irq_data *d, unsigned int type);
+int aplic_irqdomain_translate(struct irq_fwspec *fwspec, u32 gsi_base,
+			      unsigned long *hwirq, unsigned int *type);
+void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode);
+int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void __iom=
em *regs);
+int aplic_direct_setup(struct device *dev, void __iomem *regs);
+#ifdef CONFIG_RISCV_APLIC_MSI
+int aplic_msi_setup(struct device *dev, void __iomem *regs);
+#else
+static inline int aplic_msi_setup(struct device *dev, void __iomem *regs)
+{
+	return -ENODEV;
+}
+#endif
+
+#endif
diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-risc=
v-aplic-msi.c
new file mode 100644
index 000000000000..028444af48bd
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cpu.h>
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/riscv-aplic.h>
+#include <linux/irqchip/riscv-imsic.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/smp.h>
+
+#include "irq-riscv-aplic-main.h"
+
+static void aplic_msi_irq_mask(struct irq_data *d)
+{
+	aplic_irq_mask(d);
+	irq_chip_mask_parent(d);
+}
+
+static void aplic_msi_irq_unmask(struct irq_data *d)
+{
+	irq_chip_unmask_parent(d);
+	aplic_irq_unmask(d);
+}
+
+static void aplic_msi_irq_eoi(struct irq_data *d)
+{
+	struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
+
+	/*
+	 * EOI handling is required only for level-triggered interrupts
+	 * when APLIC is in MSI mode.
+	 */
+
+	switch (irqd_get_trigger_type(d)) {
+	case IRQ_TYPE_LEVEL_LOW:
+	case IRQ_TYPE_LEVEL_HIGH:
+		/*
+		 * The section "4.9.2 Special consideration for level-sensitive interrupt
+		 * sources" of the RISC-V AIA specification says:
+		 *
+		 * A second option is for the interrupt service routine to write the
+		 * APLIC=E2=80=99s source identity number for the interrupt to the domain=
=E2=80=99s
+		 * setipnum register just before exiting. This will cause the interrupt=E2=
=80=99s
+		 * pending bit to be set to one again if the source is still asserting
+		 * an interrupt, but not if the source is not asserting an interrupt.
+		 */
+		writel(d->hwirq, priv->regs + APLIC_SETIPNUM_LE);
+		break;
+	}
+}
+
+static void aplic_msi_write_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	unsigned int group_index, hart_index, guest_index, val;
+	struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
+	struct aplic_msicfg *mc =3D &priv->msicfg;
+	phys_addr_t tppn, tbppn, msg_addr;
+	void __iomem *target;
+
+	/* For zeroed MSI, simply write zero into the target register */
+	if (!msg->address_hi && !msg->address_lo && !msg->data) {
+		target =3D priv->regs + APLIC_TARGET_BASE;
+		target +=3D (d->hwirq - 1) * sizeof(u32);
+		writel(0, target);
+		return;
+	}
+
+	/* Sanity check on message data */
+	WARN_ON(msg->data > APLIC_TARGET_EIID_MASK);
+
+	/* Compute target MSI address */
+	msg_addr =3D (((u64)msg->address_hi) << 32) | msg->address_lo;
+	tppn =3D msg_addr >> APLIC_xMSICFGADDR_PPN_SHIFT;
+
+	/* Compute target HART Base PPN */
+	tbppn =3D tppn;
+	tbppn &=3D ~APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
+	tbppn &=3D ~APLIC_xMSICFGADDR_PPN_LHX(mc->lhxw, mc->lhxs);
+	tbppn &=3D ~APLIC_xMSICFGADDR_PPN_HHX(mc->hhxw, mc->hhxs);
+	WARN_ON(tbppn !=3D mc->base_ppn);
+
+	/* Compute target group and hart indexes */
+	group_index =3D (tppn >> APLIC_xMSICFGADDR_PPN_HHX_SHIFT(mc->hhxs)) &
+		     APLIC_xMSICFGADDR_PPN_HHX_MASK(mc->hhxw);
+	hart_index =3D (tppn >> APLIC_xMSICFGADDR_PPN_LHX_SHIFT(mc->lhxs)) &
+		     APLIC_xMSICFGADDR_PPN_LHX_MASK(mc->lhxw);
+	hart_index |=3D (group_index << mc->lhxw);
+	WARN_ON(hart_index > APLIC_TARGET_HART_IDX_MASK);
+
+	/* Compute target guest index */
+	guest_index =3D tppn & APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
+	WARN_ON(guest_index > APLIC_TARGET_GUEST_IDX_MASK);
+
+	/* Update IRQ TARGET register */
+	target =3D priv->regs + APLIC_TARGET_BASE;
+	target +=3D (d->hwirq - 1) * sizeof(u32);
+	val =3D FIELD_PREP(APLIC_TARGET_HART_IDX, hart_index);
+	val |=3D FIELD_PREP(APLIC_TARGET_GUEST_IDX, guest_index);
+	val |=3D FIELD_PREP(APLIC_TARGET_EIID, msg->data);
+	writel(val, target);
+}
+
+static void aplic_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	arg->desc =3D desc;
+	arg->hwirq =3D (u32)desc->data.icookie.value;
+}
+
+static int aplic_msi_translate(struct irq_domain *d, struct irq_fwspec *fwsp=
ec,
+			       unsigned long *hwirq, unsigned int *type)
+{
+	struct msi_domain_info *info =3D d->host_data;
+	struct aplic_priv *priv =3D info->data;
+
+	return aplic_irqdomain_translate(fwspec, priv->gsi_base, hwirq, type);
+}
+
+static const struct msi_domain_template aplic_msi_template =3D {
+	.chip =3D {
+		.name			=3D "APLIC-MSI",
+		.irq_mask		=3D aplic_msi_irq_mask,
+		.irq_unmask		=3D aplic_msi_irq_unmask,
+		.irq_set_type		=3D aplic_irq_set_type,
+		.irq_eoi		=3D aplic_msi_irq_eoi,
+#ifdef CONFIG_SMP
+		.irq_set_affinity	=3D irq_chip_set_affinity_parent,
+#endif
+		.irq_write_msi_msg	=3D aplic_msi_write_msg,
+		.flags			=3D IRQCHIP_SET_TYPE_MASKED |
+					  IRQCHIP_SKIP_SET_WAKE |
+					  IRQCHIP_MASK_ON_SUSPEND,
+	},
+
+	.ops =3D {
+		.set_desc		=3D aplic_msi_set_desc,
+		.msi_translate		=3D aplic_msi_translate,
+	},
+
+	.info =3D {
+		.bus_token		=3D DOMAIN_BUS_WIRED_TO_MSI,
+		.flags			=3D MSI_FLAG_USE_DEV_FWNODE,
+		.handler		=3D handle_fasteoi_irq,
+		.handler_name		=3D "fasteoi",
+	},
+};
+
+int aplic_msi_setup(struct device *dev, void __iomem *regs)
+{
+	const struct imsic_global_config *imsic_global;
+	struct aplic_priv *priv;
+	struct aplic_msicfg *mc;
+	phys_addr_t pa;
+	int rc;
+
+	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	rc =3D aplic_setup_priv(priv, dev, regs);
+	if (rc) {
+		dev_err(dev, "failed to create APLIC context\n");
+		return rc;
+	}
+	mc =3D &priv->msicfg;
+
+	/*
+	 * The APLIC outgoing MSI config registers assume target MSI
+	 * controller to be RISC-V AIA IMSIC controller.
+	 */
+	imsic_global =3D imsic_get_global_config();
+	if (!imsic_global) {
+		dev_err(dev, "IMSIC global config not found\n");
+		return -ENODEV;
+	}
+
+	/* Find number of guest index bits (LHXS) */
+	mc->lhxs =3D imsic_global->guest_index_bits;
+	if (APLIC_xMSICFGADDRH_LHXS_MASK < mc->lhxs) {
+		dev_err(dev, "IMSIC guest index bits big for APLIC LHXS\n");
+		return -EINVAL;
+	}
+
+	/* Find number of HART index bits (LHXW) */
+	mc->lhxw =3D imsic_global->hart_index_bits;
+	if (APLIC_xMSICFGADDRH_LHXW_MASK < mc->lhxw) {
+		dev_err(dev, "IMSIC hart index bits big for APLIC LHXW\n");
+		return -EINVAL;
+	}
+
+	/* Find number of group index bits (HHXW) */
+	mc->hhxw =3D imsic_global->group_index_bits;
+	if (APLIC_xMSICFGADDRH_HHXW_MASK < mc->hhxw) {
+		dev_err(dev, "IMSIC group index bits big for APLIC HHXW\n");
+		return -EINVAL;
+	}
+
+	/* Find first bit position of group index (HHXS) */
+	mc->hhxs =3D imsic_global->group_index_shift;
+	if (mc->hhxs < (2 * APLIC_xMSICFGADDR_PPN_SHIFT)) {
+		dev_err(dev, "IMSIC group index shift should be >=3D %d\n",
+			(2 * APLIC_xMSICFGADDR_PPN_SHIFT));
+		return -EINVAL;
+	}
+	mc->hhxs -=3D (2 * APLIC_xMSICFGADDR_PPN_SHIFT);
+	if (APLIC_xMSICFGADDRH_HHXS_MASK < mc->hhxs) {
+		dev_err(dev, "IMSIC group index shift big for APLIC HHXS\n");
+		return -EINVAL;
+	}
+
+	/* Compute PPN base */
+	mc->base_ppn =3D imsic_global->base_addr >> APLIC_xMSICFGADDR_PPN_SHIFT;
+	mc->base_ppn &=3D ~APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
+	mc->base_ppn &=3D ~APLIC_xMSICFGADDR_PPN_LHX(mc->lhxw, mc->lhxs);
+	mc->base_ppn &=3D ~APLIC_xMSICFGADDR_PPN_HHX(mc->hhxw, mc->hhxs);
+
+	/* Setup global config and interrupt delivery */
+	aplic_init_hw_global(priv, true);
+
+	/* Set the APLIC device MSI domain if not available */
+	if (!dev_get_msi_domain(dev)) {
+		/*
+		 * The device MSI domain for OF devices is only set at the
+		 * time of populating/creating OF device. If the device MSI
+		 * domain is discovered later after the OF device is created
+		 * then we need to set it explicitly before using any platform
+		 * MSI functions.
+		 *
+		 * In case of APLIC device, the parent MSI domain is always
+		 * IMSIC and the IMSIC MSI domains are created later through
+		 * the platform driver probing so we set it explicitly here.
+		 */
+		if (is_of_node(dev->fwnode))
+			of_msi_configure(dev, to_of_node(dev->fwnode));
+	}
+
+	if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, &aplic_msi_templ=
ate,
+					  priv->nr_irqs + 1, priv, priv)) {
+		dev_err(dev, "failed to create MSI irq domain\n");
+		return -ENOMEM;
+	}
+
+	/* Advertise the interrupt controller */
+	pa =3D priv->msicfg.base_ppn << APLIC_xMSICFGADDR_PPN_SHIFT;
+	dev_info(dev, "%d interrupts forwarded to MSI base %pa\n", priv->nr_irqs, &=
pa);
+
+	return 0;
+}
diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-ri=
scv-imsic-early.c
new file mode 100644
index 000000000000..886418ec06cb
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#define pr_fmt(fmt) "riscv-imsic: " fmt
+#include <linux/cpu.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+
+#include "irq-riscv-imsic-state.h"
+
+static int imsic_parent_irq;
+
+#ifdef CONFIG_SMP
+static void imsic_ipi_send(unsigned int cpu)
+{
+	struct imsic_local_config *local =3D per_cpu_ptr(imsic->global.local, cpu);
+
+	writel_relaxed(IMSIC_IPI_ID, local->msi_va);
+}
+
+static void imsic_ipi_starting_cpu(void)
+{
+	/* Enable IPIs for current CPU. */
+	__imsic_id_set_enable(IMSIC_IPI_ID);
+}
+
+static void imsic_ipi_dying_cpu(void)
+{
+	/* Disable IPIs for current CPU. */
+	__imsic_id_clear_enable(IMSIC_IPI_ID);
+}
+
+static int __init imsic_ipi_domain_init(void)
+{
+	int virq;
+
+	/* Create IMSIC IPI multiplexing */
+	virq =3D ipi_mux_create(IMSIC_NR_IPI, imsic_ipi_send);
+	if (virq <=3D 0)
+		return virq < 0 ? virq : -ENOMEM;
+
+	/* Set vIRQ range */
+	riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI, true);
+
+	/* Announce that IMSIC is providing IPIs */
+	pr_info("%pfwP: providing IPIs using interrupt %d\n", imsic->fwnode, IMSIC_=
IPI_ID);
+
+	return 0;
+}
+#else
+static void imsic_ipi_starting_cpu(void) { }
+static void imsic_ipi_dying_cpu(void) { }
+static int __init imsic_ipi_domain_init(void) { return 0; }
+#endif
+
+/*
+ * To handle an interrupt, we read the TOPEI CSR and write zero in one
+ * instruction. If TOPEI CSR is non-zero then we translate TOPEI.ID to
+ * Linux interrupt number and let Linux IRQ subsystem handle it.
+ */
+static void imsic_handle_irq(struct irq_desc *desc)
+{
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+	int err, cpu =3D smp_processor_id();
+	struct imsic_vector *vec;
+	unsigned long local_id;
+
+	chained_irq_enter(chip, desc);
+
+	while ((local_id =3D csr_swap(CSR_TOPEI, 0))) {
+		local_id >>=3D TOPEI_ID_SHIFT;
+
+		if (local_id =3D=3D IMSIC_IPI_ID) {
+			if (IS_ENABLED(CONFIG_SMP))
+				ipi_mux_process();
+			continue;
+		}
+
+		if (unlikely(!imsic->base_domain))
+			continue;
+
+		vec =3D imsic_vector_from_local_id(cpu, local_id);
+		if (!vec) {
+			pr_warn_ratelimited("vector not found for local ID 0x%lx\n", local_id);
+			continue;
+		}
+
+		err =3D generic_handle_domain_irq(imsic->base_domain, vec->hwirq);
+		if (unlikely(err))
+			pr_warn_ratelimited("hwirq 0x%x mapping not found\n", vec->hwirq);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static int imsic_starting_cpu(unsigned int cpu)
+{
+	/* Mark per-CPU IMSIC state as online */
+	imsic_state_online();
+
+	/* Enable per-CPU parent interrupt */
+	enable_percpu_irq(imsic_parent_irq, irq_get_trigger_type(imsic_parent_irq));
+
+	/* Setup IPIs */
+	imsic_ipi_starting_cpu();
+
+	/*
+	 * Interrupts identities might have been enabled/disabled while
+	 * this CPU was not running so sync-up local enable/disable state.
+	 */
+	imsic_local_sync_all();
+
+	/* Enable local interrupt delivery */
+	imsic_local_delivery(true);
+
+	return 0;
+}
+
+static int imsic_dying_cpu(unsigned int cpu)
+{
+	/* Cleanup IPIs */
+	imsic_ipi_dying_cpu();
+
+	/* Mark per-CPU IMSIC state as offline */
+	imsic_state_offline();
+
+	return 0;
+}
+
+static int __init imsic_early_probe(struct fwnode_handle *fwnode)
+{
+	struct irq_domain *domain;
+	int rc;
+
+	/* Find parent domain and register chained handler */
+	domain =3D irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY=
);
+	if (!domain) {
+		pr_err("%pfwP: Failed to find INTC domain\n", fwnode);
+		return -ENOENT;
+	}
+	imsic_parent_irq =3D irq_create_mapping(domain, RV_IRQ_EXT);
+	if (!imsic_parent_irq) {
+		pr_err("%pfwP: Failed to create INTC mapping\n", fwnode);
+		return -ENOENT;
+	}
+
+	/* Initialize IPI domain */
+	rc =3D imsic_ipi_domain_init();
+	if (rc) {
+		pr_err("%pfwP: Failed to initialize IPI domain\n", fwnode);
+		return rc;
+	}
+
+	/* Setup chained handler to the parent domain interrupt */
+	irq_set_chained_handler(imsic_parent_irq, imsic_handle_irq);
+
+	/*
+	 * Setup cpuhp state (must be done after setting imsic_parent_irq)
+	 *
+	 * Don't disable per-CPU IMSIC file when CPU goes offline
+	 * because this affects IPI and the masking/unmasking of
+	 * virtual IPIs is done via generic IPI-Mux
+	 */
+	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_IMSIC_STARTING, "irqchip/riscv/imsic:s=
tarting",
+			  imsic_starting_cpu, imsic_dying_cpu);
+
+	return 0;
+}
+
+static int __init imsic_early_dt_init(struct device_node *node, struct devic=
e_node *parent)
+{
+	struct fwnode_handle *fwnode =3D &node->fwnode;
+	int rc;
+
+	/* Setup IMSIC state */
+	rc =3D imsic_setup_state(fwnode);
+	if (rc) {
+		pr_err("%pfwP: failed to setup state (error %d)\n", fwnode, rc);
+		return rc;
+	}
+
+	/* Do early setup of IPIs */
+	rc =3D imsic_early_probe(fwnode);
+	if (rc)
+		return rc;
+
+	/* Ensure that OF platform device gets probed */
+	of_node_clear_flag(node, OF_POPULATED);
+	return 0;
+}
+
+IRQCHIP_DECLARE(riscv_imsic, "riscv,imsics", imsic_early_dt_init);
diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq=
-riscv-imsic-platform.c
new file mode 100644
index 000000000000..11723a763c10
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#define pr_fmt(fmt) "riscv-imsic: " fmt
+#include <linux/bitmap.h>
+#include <linux/cpu.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+
+#include "irq-riscv-imsic-state.h"
+
+static bool imsic_cpu_page_phys(unsigned int cpu, unsigned int guest_index,
+				phys_addr_t *out_msi_pa)
+{
+	struct imsic_global_config *global;
+	struct imsic_local_config *local;
+
+	global =3D &imsic->global;
+	local =3D per_cpu_ptr(global->local, cpu);
+
+	if (BIT(global->guest_index_bits) <=3D guest_index)
+		return false;
+
+	if (out_msi_pa)
+		*out_msi_pa =3D local->msi_pa + (guest_index * IMSIC_MMIO_PAGE_SZ);
+
+	return true;
+}
+
+static void imsic_irq_mask(struct irq_data *d)
+{
+	imsic_vector_mask(irq_data_get_irq_chip_data(d));
+}
+
+static void imsic_irq_unmask(struct irq_data *d)
+{
+	imsic_vector_unmask(irq_data_get_irq_chip_data(d));
+}
+
+static int imsic_irq_retrigger(struct irq_data *d)
+{
+	struct imsic_vector *vec =3D irq_data_get_irq_chip_data(d);
+	struct imsic_local_config *local;
+
+	if (WARN_ON(!vec))
+		return -ENOENT;
+
+	local =3D per_cpu_ptr(imsic->global.local, vec->cpu);
+	writel_relaxed(vec->local_id, local->msi_va);
+	return 0;
+}
+
+static void imsic_irq_compose_vector_msg(struct imsic_vector *vec, struct ms=
i_msg *msg)
+{
+	phys_addr_t msi_addr;
+
+	if (WARN_ON(!vec))
+		return;
+
+	if (WARN_ON(!imsic_cpu_page_phys(vec->cpu, 0, &msi_addr)))
+		return;
+
+	msg->address_hi =3D upper_32_bits(msi_addr);
+	msg->address_lo =3D lower_32_bits(msi_addr);
+	msg->data =3D vec->local_id;
+}
+
+static void imsic_irq_compose_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	imsic_irq_compose_vector_msg(irq_data_get_irq_chip_data(d), msg);
+}
+
+#ifdef CONFIG_SMP
+static void imsic_msi_update_msg(struct irq_data *d, struct imsic_vector *ve=
c)
+{
+	struct msi_msg msg =3D { };
+
+	imsic_irq_compose_vector_msg(vec, &msg);
+	irq_data_get_irq_chip(d)->irq_write_msi_msg(d, &msg);
+}
+
+static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *=
mask_val,
+				  bool force)
+{
+	struct imsic_vector *old_vec, *new_vec;
+	struct irq_data *pd =3D d->parent_data;
+
+	old_vec =3D irq_data_get_irq_chip_data(pd);
+	if (WARN_ON(!old_vec))
+		return -ENOENT;
+
+	/* If old vector cpu belongs to the target cpumask then do nothing */
+	if (cpumask_test_cpu(old_vec->cpu, mask_val))
+		return IRQ_SET_MASK_OK_DONE;
+
+	/* If move is already in-flight then return failure */
+	if (imsic_vector_get_move(old_vec))
+		return -EBUSY;
+
+	/* Get a new vector on the desired set of CPUs */
+	new_vec =3D imsic_vector_alloc(old_vec->hwirq, mask_val);
+	if (!new_vec)
+		return -ENOSPC;
+
+	/* Point device to the new vector */
+	imsic_msi_update_msg(d, new_vec);
+
+	/* Update irq descriptors with the new vector */
+	pd->chip_data =3D new_vec;
+
+	/* Update effective affinity of parent irq data */
+	irq_data_update_effective_affinity(pd, cpumask_of(new_vec->cpu));
+
+	/* Move state of the old vector to the new vector */
+	imsic_vector_move(old_vec, new_vec);
+
+	return IRQ_SET_MASK_OK_DONE;
+}
+#endif
+
+static struct irq_chip imsic_irq_base_chip =3D {
+	.name			=3D "IMSIC",
+	.irq_mask		=3D imsic_irq_mask,
+	.irq_unmask		=3D imsic_irq_unmask,
+	.irq_retrigger		=3D imsic_irq_retrigger,
+	.irq_compose_msi_msg	=3D imsic_irq_compose_msg,
+	.flags			=3D IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int vi=
rq,
+				  unsigned int nr_irqs, void *args)
+{
+	struct imsic_vector *vec;
+
+	/* Multi-MSI is not supported yet. */
+	if (nr_irqs > 1)
+		return -EOPNOTSUPP;
+
+	vec =3D imsic_vector_alloc(virq, cpu_online_mask);
+	if (!vec)
+		return -ENOSPC;
+
+	irq_domain_set_info(domain, virq, virq, &imsic_irq_base_chip, vec,
+			    handle_simple_irq, NULL, NULL);
+	irq_set_noprobe(virq);
+	irq_set_affinity(virq, cpu_online_mask);
+	irq_data_update_effective_affinity(irq_get_irq_data(virq), cpumask_of(vec->=
cpu));
+
+	return 0;
+}
+
+static void imsic_irq_domain_free(struct irq_domain *domain, unsigned int vi=
rq,
+				  unsigned int nr_irqs)
+{
+	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
+
+	imsic_vector_free(irq_data_get_irq_chip_data(d));
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+}
+
+static int imsic_irq_domain_select(struct irq_domain *domain, struct irq_fws=
pec *fwspec,
+				   enum irq_domain_bus_token bus_token)
+{
+	const struct msi_parent_ops *ops =3D domain->msi_parent_ops;
+	u32 busmask =3D BIT(bus_token);
+
+	if (fwspec->fwnode !=3D domain->fwnode || fwspec->param_count !=3D 0)
+		return 0;
+
+	/* Handle pure domain searches */
+	if (bus_token =3D=3D ops->bus_select_token)
+		return 1;
+
+	return !!(ops->bus_select_mask & busmask);
+}
+
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+static void imsic_irq_debug_show(struct seq_file *m, struct irq_domain *d,
+				 struct irq_data *irqd, int ind)
+{
+	if (!irqd) {
+		imsic_vector_debug_show_summary(m, ind);
+		return;
+	}
+
+	imsic_vector_debug_show(m, irq_data_get_irq_chip_data(irqd), ind);
+}
+#endif
+
+static const struct irq_domain_ops imsic_base_domain_ops =3D {
+	.alloc		=3D imsic_irq_domain_alloc,
+	.free		=3D imsic_irq_domain_free,
+	.select		=3D imsic_irq_domain_select,
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+	.debug_show	=3D imsic_irq_debug_show,
+#endif
+};
+
+#ifdef CONFIG_RISCV_IMSIC_PCI
+
+static void imsic_pci_mask_irq(struct irq_data *d)
+{
+	pci_msi_mask_irq(d);
+	irq_chip_mask_parent(d);
+}
+
+static void imsic_pci_unmask_irq(struct irq_data *d)
+{
+	irq_chip_unmask_parent(d);
+	pci_msi_unmask_irq(d);
+}
+
+#define MATCH_PCI_MSI		BIT(DOMAIN_BUS_PCI_MSI)
+
+#else
+
+#define MATCH_PCI_MSI		0
+
+#endif
+
+static bool imsic_init_dev_msi_info(struct device *dev,
+				    struct irq_domain *domain,
+				    struct irq_domain *real_parent,
+				    struct msi_domain_info *info)
+{
+	const struct msi_parent_ops *pops =3D real_parent->msi_parent_ops;
+
+	/* MSI parent domain specific settings */
+	switch (real_parent->bus_token) {
+	case DOMAIN_BUS_NEXUS:
+		if (WARN_ON_ONCE(domain !=3D real_parent))
+			return false;
+#ifdef CONFIG_SMP
+		info->chip->irq_set_affinity =3D imsic_irq_set_affinity;
+#endif
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	/* Is the target supported? */
+	switch (info->bus_token) {
+#ifdef CONFIG_RISCV_IMSIC_PCI
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		info->chip->irq_mask =3D imsic_pci_mask_irq;
+		info->chip->irq_unmask =3D imsic_pci_unmask_irq;
+		break;
+#endif
+	case DOMAIN_BUS_DEVICE_MSI:
+		/*
+		 * Per-device MSI should never have any MSI feature bits
+		 * set. It's sole purpose is to create a dumb interrupt
+		 * chip which has a device specific irq_write_msi_msg()
+		 * callback.
+		 */
+		if (WARN_ON_ONCE(info->flags))
+			return false;
+
+		/* Core managed MSI descriptors */
+		info->flags |=3D MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS |
+			       MSI_FLAG_FREE_MSI_DESCS;
+		break;
+	case DOMAIN_BUS_WIRED_TO_MSI:
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	/* Use hierarchial chip operations re-trigger */
+	info->chip->irq_retrigger =3D irq_chip_retrigger_hierarchy;
+
+	/*
+	 * Mask out the domain specific MSI feature flags which are not
+	 * supported by the real parent.
+	 */
+	info->flags &=3D pops->supported_flags;
+
+	/* Enforce the required flags */
+	info->flags |=3D pops->required_flags;
+
+	return true;
+}
+
+#define MATCH_PLATFORM_MSI		BIT(DOMAIN_BUS_PLATFORM_MSI)
+
+static const struct msi_parent_ops imsic_msi_parent_ops =3D {
+	.supported_flags	=3D MSI_GENERIC_FLAGS_MASK |
+				  MSI_FLAG_PCI_MSIX,
+	.required_flags		=3D MSI_FLAG_USE_DEF_DOM_OPS |
+				  MSI_FLAG_USE_DEF_CHIP_OPS,
+	.bus_select_token	=3D DOMAIN_BUS_NEXUS,
+	.bus_select_mask	=3D MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
+	.init_dev_msi_info	=3D imsic_init_dev_msi_info,
+};
+
+int imsic_irqdomain_init(void)
+{
+	struct imsic_global_config *global;
+
+	if (!imsic || !imsic->fwnode) {
+		pr_err("early driver not probed\n");
+		return -ENODEV;
+	}
+
+	if (imsic->base_domain) {
+		pr_err("%pfwP: irq domain already created\n", imsic->fwnode);
+		return -ENODEV;
+	}
+
+	/* Create Base IRQ domain */
+	imsic->base_domain =3D irq_domain_create_tree(imsic->fwnode,
+						    &imsic_base_domain_ops, imsic);
+	if (!imsic->base_domain) {
+		pr_err("%pfwP: failed to create IMSIC base domain\n", imsic->fwnode);
+		return -ENOMEM;
+	}
+	imsic->base_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
+	imsic->base_domain->msi_parent_ops =3D &imsic_msi_parent_ops;
+
+	irq_domain_update_bus_token(imsic->base_domain, DOMAIN_BUS_NEXUS);
+
+	global =3D &imsic->global;
+	pr_info("%pfwP:  hart-index-bits: %d,  guest-index-bits: %d\n",
+		imsic->fwnode, global->hart_index_bits, global->guest_index_bits);
+	pr_info("%pfwP: group-index-bits: %d, group-index-shift: %d\n",
+		imsic->fwnode, global->group_index_bits, global->group_index_shift);
+	pr_info("%pfwP: per-CPU IDs %d at base PPN %pa\n",
+		imsic->fwnode, global->nr_ids, &global->base_addr);
+	pr_info("%pfwP: total %d interrupts available\n",
+		imsic->fwnode, num_possible_cpus() * (global->nr_ids - 1));
+
+	return 0;
+}
+
+static int imsic_platform_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+
+	if (imsic && imsic->fwnode !=3D dev->fwnode) {
+		dev_err(dev, "fwnode mismatch\n");
+		return -ENODEV;
+	}
+
+	return imsic_irqdomain_init();
+}
+
+static const struct of_device_id imsic_platform_match[] =3D {
+	{ .compatible =3D "riscv,imsics" },
+	{}
+};
+
+static struct platform_driver imsic_platform_driver =3D {
+	.driver =3D {
+		.name		=3D "riscv-imsic",
+		.of_match_table	=3D imsic_platform_match,
+	},
+	.probe =3D imsic_platform_probe,
+};
+builtin_platform_driver(imsic_platform_driver);
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-ri=
scv-imsic-state.c
new file mode 100644
index 000000000000..5479f872e62b
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -0,0 +1,865 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#define pr_fmt(fmt) "riscv-imsic: " fmt
+#include <linux/cpu.h>
+#include <linux/bitmap.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/seq_file.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <asm/hwcap.h>
+
+#include "irq-riscv-imsic-state.h"
+
+#define IMSIC_DISABLE_EIDELIVERY		0
+#define IMSIC_ENABLE_EIDELIVERY			1
+#define IMSIC_DISABLE_EITHRESHOLD		1
+#define IMSIC_ENABLE_EITHRESHOLD		0
+
+static inline void imsic_csr_write(unsigned long reg, unsigned long val)
+{
+	csr_write(CSR_ISELECT, reg);
+	csr_write(CSR_IREG, val);
+}
+
+static inline unsigned long imsic_csr_read(unsigned long reg)
+{
+	csr_write(CSR_ISELECT, reg);
+	return csr_read(CSR_IREG);
+}
+
+static inline unsigned long imsic_csr_read_clear(unsigned long reg, unsigned=
 long val)
+{
+	csr_write(CSR_ISELECT, reg);
+	return csr_read_clear(CSR_IREG, val);
+}
+
+static inline void imsic_csr_set(unsigned long reg, unsigned long val)
+{
+	csr_write(CSR_ISELECT, reg);
+	csr_set(CSR_IREG, val);
+}
+
+static inline void imsic_csr_clear(unsigned long reg, unsigned long val)
+{
+	csr_write(CSR_ISELECT, reg);
+	csr_clear(CSR_IREG, val);
+}
+
+struct imsic_priv *imsic;
+
+const struct imsic_global_config *imsic_get_global_config(void)
+{
+	return imsic ? &imsic->global : NULL;
+}
+EXPORT_SYMBOL_GPL(imsic_get_global_config);
+
+static bool __imsic_eix_read_clear(unsigned long id, bool pend)
+{
+	unsigned long isel, imask;
+
+	isel =3D id / BITS_PER_LONG;
+	isel *=3D BITS_PER_LONG / IMSIC_EIPx_BITS;
+	isel +=3D pend ? IMSIC_EIP0 : IMSIC_EIE0;
+	imask =3D BIT(id & (__riscv_xlen - 1));
+
+	return !!(imsic_csr_read_clear(isel, imask) & imask);
+}
+
+static inline bool __imsic_id_read_clear_enabled(unsigned long id)
+{
+	return __imsic_eix_read_clear(id, false);
+}
+
+static inline bool __imsic_id_read_clear_pending(unsigned long id)
+{
+	return __imsic_eix_read_clear(id, true);
+}
+
+void __imsic_eix_update(unsigned long base_id, unsigned long num_id, bool pe=
nd, bool val)
+{
+	unsigned long id =3D base_id, last_id =3D base_id + num_id;
+	unsigned long i, isel, ireg;
+
+	while (id < last_id) {
+		isel =3D id / BITS_PER_LONG;
+		isel *=3D BITS_PER_LONG / IMSIC_EIPx_BITS;
+		isel +=3D pend ? IMSIC_EIP0 : IMSIC_EIE0;
+
+		/*
+		 * Prepare the ID mask to be programmed in the
+		 * IMSIC EIEx and EIPx registers. These registers
+		 * are XLEN-wide and we must not touch IDs which
+		 * are < base_id and >=3D (base_id + num_id).
+		 */
+		ireg =3D 0;
+		for (i =3D id & (__riscv_xlen - 1); id < last_id && i < __riscv_xlen; i++)=
 {
+			ireg |=3D BIT(i);
+			id++;
+		}
+
+		/*
+		 * The IMSIC EIEx and EIPx registers are indirectly
+		 * accessed via using ISELECT and IREG CSRs so we
+		 * need to access these CSRs without getting preempted.
+		 *
+		 * All existing users of this function call this
+		 * function with local IRQs disabled so we don't
+		 * need to do anything special here.
+		 */
+		if (val)
+			imsic_csr_set(isel, ireg);
+		else
+			imsic_csr_clear(isel, ireg);
+	}
+}
+
+static void __imsic_local_sync(struct imsic_local_priv *lpriv)
+{
+	struct imsic_local_config *mlocal;
+	struct imsic_vector *vec, *mvec;
+	int i;
+
+	lockdep_assert_held(&lpriv->lock);
+
+	for_each_set_bit(i, lpriv->dirty_bitmap, imsic->global.nr_ids + 1) {
+		if (!i || i =3D=3D IMSIC_IPI_ID)
+			goto skip;
+		vec =3D &lpriv->vectors[i];
+
+		if (READ_ONCE(vec->enable))
+			__imsic_id_set_enable(i);
+		else
+			__imsic_id_clear_enable(i);
+
+		/*
+		 * If the ID was being moved to a new ID on some other CPU
+		 * then we can get a MSI during the movement so check the
+		 * ID pending bit and re-trigger the new ID on other CPU
+		 * using MMIO write.
+		 */
+		mvec =3D READ_ONCE(vec->move);
+		WRITE_ONCE(vec->move, NULL);
+		if (mvec && mvec !=3D vec) {
+			if (__imsic_id_read_clear_pending(i)) {
+				mlocal =3D per_cpu_ptr(imsic->global.local, mvec->cpu);
+				writel_relaxed(mvec->local_id, mlocal->msi_va);
+			}
+
+			imsic_vector_free(&lpriv->vectors[i]);
+		}
+
+skip:
+		bitmap_clear(lpriv->dirty_bitmap, i, 1);
+	}
+}
+
+void imsic_local_sync_all(void)
+{
+	struct imsic_local_priv *lpriv =3D this_cpu_ptr(imsic->lpriv);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&lpriv->lock, flags);
+	bitmap_fill(lpriv->dirty_bitmap, imsic->global.nr_ids + 1);
+	__imsic_local_sync(lpriv);
+	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
+}
+
+void imsic_local_delivery(bool enable)
+{
+	if (enable) {
+		imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_ENABLE_EITHRESHOLD);
+		imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_ENABLE_EIDELIVERY);
+		return;
+	}
+
+	imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_DISABLE_EIDELIVERY);
+	imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_DISABLE_EITHRESHOLD);
+}
+
+#ifdef CONFIG_SMP
+static void imsic_local_timer_callback(struct timer_list *timer)
+{
+	struct imsic_local_priv *lpriv =3D this_cpu_ptr(imsic->lpriv);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&lpriv->lock, flags);
+	__imsic_local_sync(lpriv);
+	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
+}
+
+static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsigned int=
 cpu)
+{
+	lockdep_assert_held(&lpriv->lock);
+
+	/*
+	 * The spinlock acquire/release semantics ensure that changes
+	 * to vector enable, vector move and dirty bitmap are visible
+	 * to the target CPU.
+	 */
+
+	/*
+	 * We schedule a timer on the target CPU if the target CPU is not
+	 * same as the current CPU. An offline CPU will unconditionally
+	 * synchronize IDs through imsic_starting_cpu() when the
+	 * CPU is brought up.
+	 */
+	if (cpu_online(cpu)) {
+		if (cpu =3D=3D smp_processor_id()) {
+			__imsic_local_sync(lpriv);
+			return;
+		}
+
+		if (!timer_pending(&lpriv->timer)) {
+			lpriv->timer.expires =3D jiffies + 1;
+			add_timer_on(&lpriv->timer, cpu);
+		}
+	}
+}
+#else
+static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsigned int=
 cpu)
+{
+	lockdep_assert_held(&lpriv->lock);
+	__imsic_local_sync(lpriv);
+}
+#endif
+
+void imsic_vector_mask(struct imsic_vector *vec)
+{
+	struct imsic_local_priv *lpriv;
+
+	lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
+	if (WARN_ON_ONCE(&lpriv->vectors[vec->local_id] !=3D vec))
+		return;
+
+	/*
+	 * This function is called through Linux irq subsystem with
+	 * irqs disabled so no need to save/restore irq flags.
+	 */
+
+	raw_spin_lock(&lpriv->lock);
+
+	WRITE_ONCE(vec->enable, false);
+	bitmap_set(lpriv->dirty_bitmap, vec->local_id, 1);
+	__imsic_remote_sync(lpriv, vec->cpu);
+
+	raw_spin_unlock(&lpriv->lock);
+}
+
+void imsic_vector_unmask(struct imsic_vector *vec)
+{
+	struct imsic_local_priv *lpriv;
+
+	lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
+	if (WARN_ON_ONCE(&lpriv->vectors[vec->local_id] !=3D vec))
+		return;
+
+	/*
+	 * This function is called through Linux irq subsystem with
+	 * irqs disabled so no need to save/restore irq flags.
+	 */
+
+	raw_spin_lock(&lpriv->lock);
+
+	WRITE_ONCE(vec->enable, true);
+	bitmap_set(lpriv->dirty_bitmap, vec->local_id, 1);
+	__imsic_remote_sync(lpriv, vec->cpu);
+
+	raw_spin_unlock(&lpriv->lock);
+}
+
+static bool imsic_vector_move_update(struct imsic_local_priv *lpriv, struct =
imsic_vector *vec,
+				     bool new_enable, struct imsic_vector *new_move)
+{
+	unsigned long flags;
+	bool enabled;
+
+	raw_spin_lock_irqsave(&lpriv->lock, flags);
+
+	/* Update enable and move details */
+	enabled =3D READ_ONCE(vec->enable);
+	WRITE_ONCE(vec->enable, new_enable);
+	WRITE_ONCE(vec->move, new_move);
+
+	/* Mark the vector as dirty and synchronize */
+	bitmap_set(lpriv->dirty_bitmap, vec->local_id, 1);
+	__imsic_remote_sync(lpriv, vec->cpu);
+
+	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
+
+	return enabled;
+}
+
+void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *ne=
w_vec)
+{
+	struct imsic_local_priv *old_lpriv, *new_lpriv;
+	bool enabled;
+
+	if (WARN_ON_ONCE(old_vec->cpu =3D=3D new_vec->cpu))
+		return;
+
+	old_lpriv =3D per_cpu_ptr(imsic->lpriv, old_vec->cpu);
+	if (WARN_ON_ONCE(&old_lpriv->vectors[old_vec->local_id] !=3D old_vec))
+		return;
+
+	new_lpriv =3D per_cpu_ptr(imsic->lpriv, new_vec->cpu);
+	if (WARN_ON_ONCE(&new_lpriv->vectors[new_vec->local_id] !=3D new_vec))
+		return;
+
+	/*
+	 * Move and re-trigger the new vector based on the pending
+	 * state of the old vector because we might get a device
+	 * interrupt on the old vector while device was being moved
+	 * to the new vector.
+	 */
+	enabled =3D imsic_vector_move_update(old_lpriv, old_vec, false, new_vec);
+	imsic_vector_move_update(new_lpriv, new_vec, enabled, new_vec);
+}
+
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+void imsic_vector_debug_show(struct seq_file *m, struct imsic_vector *vec, i=
nt ind)
+{
+	struct imsic_local_priv *lpriv;
+	struct imsic_vector *mvec;
+	bool is_enabled;
+
+	lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
+	if (WARN_ON_ONCE(&lpriv->vectors[vec->local_id] !=3D vec))
+		return;
+
+	is_enabled =3D imsic_vector_isenabled(vec);
+	mvec =3D imsic_vector_get_move(vec);
+
+	seq_printf(m, "%*starget_cpu      : %5u\n", ind, "", vec->cpu);
+	seq_printf(m, "%*starget_local_id : %5u\n", ind, "", vec->local_id);
+	seq_printf(m, "%*sis_reserved     : %5u\n", ind, "",
+		   (vec->local_id <=3D IMSIC_IPI_ID) ? 1 : 0);
+	seq_printf(m, "%*sis_enabled      : %5u\n", ind, "", is_enabled ? 1 : 0);
+	seq_printf(m, "%*sis_move_pending : %5u\n", ind, "", mvec ? 1 : 0);
+	if (mvec) {
+		seq_printf(m, "%*smove_cpu        : %5u\n", ind, "", mvec->cpu);
+		seq_printf(m, "%*smove_local_id   : %5u\n", ind, "", mvec->local_id);
+	}
+}
+
+void imsic_vector_debug_show_summary(struct seq_file *m, int ind)
+{
+	irq_matrix_debug_show(m, imsic->matrix, ind);
+}
+#endif
+
+struct imsic_vector *imsic_vector_from_local_id(unsigned int cpu, unsigned i=
nt local_id)
+{
+	struct imsic_local_priv *lpriv =3D per_cpu_ptr(imsic->lpriv, cpu);
+
+	if (!lpriv || imsic->global.nr_ids < local_id)
+		return NULL;
+
+	return &lpriv->vectors[local_id];
+}
+
+struct imsic_vector *imsic_vector_alloc(unsigned int hwirq, const struct cpu=
mask *mask)
+{
+	struct imsic_vector *vec =3D NULL;
+	struct imsic_local_priv *lpriv;
+	unsigned long flags;
+	unsigned int cpu;
+	int local_id;
+
+	raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
+	local_id =3D irq_matrix_alloc(imsic->matrix, mask, false, &cpu);
+	raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
+	if (local_id < 0)
+		return NULL;
+
+	lpriv =3D per_cpu_ptr(imsic->lpriv, cpu);
+	vec =3D &lpriv->vectors[local_id];
+	vec->hwirq =3D hwirq;
+	vec->enable =3D false;
+	vec->move =3D NULL;
+
+	return vec;
+}
+
+void imsic_vector_free(struct imsic_vector *vec)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
+	vec->hwirq =3D UINT_MAX;
+	irq_matrix_free(imsic->matrix, vec->cpu, vec->local_id, false);
+	raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
+}
+
+static void __init imsic_local_cleanup(void)
+{
+	struct imsic_local_priv *lpriv;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		lpriv =3D per_cpu_ptr(imsic->lpriv, cpu);
+
+		bitmap_free(lpriv->dirty_bitmap);
+		kfree(lpriv->vectors);
+	}
+
+	free_percpu(imsic->lpriv);
+}
+
+static int __init imsic_local_init(void)
+{
+	struct imsic_global_config *global =3D &imsic->global;
+	struct imsic_local_priv *lpriv;
+	struct imsic_vector *vec;
+	int cpu, i;
+
+	/* Allocate per-CPU private state */
+	imsic->lpriv =3D alloc_percpu(typeof(*imsic->lpriv));
+	if (!imsic->lpriv)
+		return -ENOMEM;
+
+	/* Setup per-CPU private state */
+	for_each_possible_cpu(cpu) {
+		lpriv =3D per_cpu_ptr(imsic->lpriv, cpu);
+
+		raw_spin_lock_init(&lpriv->lock);
+
+		/* Allocate dirty bitmap */
+		lpriv->dirty_bitmap =3D bitmap_zalloc(global->nr_ids + 1, GFP_KERNEL);
+		if (!lpriv->dirty_bitmap)
+			goto fail_local_cleanup;
+
+#ifdef CONFIG_SMP
+		/* Setup lazy timer for synchronization */
+		timer_setup(&lpriv->timer, imsic_local_timer_callback, TIMER_PINNED);
+#endif
+
+		/* Allocate vector array */
+		lpriv->vectors =3D kcalloc(global->nr_ids + 1, sizeof(*lpriv->vectors),
+					 GFP_KERNEL);
+		if (!lpriv->vectors)
+			goto fail_local_cleanup;
+
+		/* Setup vector array */
+		for (i =3D 0; i <=3D global->nr_ids; i++) {
+			vec =3D &lpriv->vectors[i];
+			vec->cpu =3D cpu;
+			vec->local_id =3D i;
+			vec->hwirq =3D UINT_MAX;
+		}
+	}
+
+	return 0;
+
+fail_local_cleanup:
+	imsic_local_cleanup();
+	return -ENOMEM;
+}
+
+void imsic_state_online(void)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
+	irq_matrix_online(imsic->matrix);
+	raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
+}
+
+void imsic_state_offline(void)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
+	irq_matrix_offline(imsic->matrix);
+	raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
+
+#ifdef CONFIG_SMP
+	struct imsic_local_priv *lpriv =3D this_cpu_ptr(imsic->lpriv);
+
+	raw_spin_lock_irqsave(&lpriv->lock, flags);
+	WARN_ON_ONCE(try_to_del_timer_sync(&lpriv->timer) < 0);
+	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
+#endif
+}
+
+static int __init imsic_matrix_init(void)
+{
+	struct imsic_global_config *global =3D &imsic->global;
+
+	raw_spin_lock_init(&imsic->matrix_lock);
+	imsic->matrix =3D irq_alloc_matrix(global->nr_ids + 1,
+					 0, global->nr_ids + 1);
+	if (!imsic->matrix)
+		return -ENOMEM;
+
+	/* Reserve ID#0 because it is special and never implemented */
+	irq_matrix_assign_system(imsic->matrix, 0, false);
+
+	/* Reserve IPI ID because it is special and used internally */
+	irq_matrix_assign_system(imsic->matrix, IMSIC_IPI_ID, false);
+
+	return 0;
+}
+
+static int __init imsic_get_parent_hartid(struct fwnode_handle *fwnode,
+					  u32 index, unsigned long *hartid)
+{
+	struct of_phandle_args parent;
+	int rc;
+
+	/*
+	 * Currently, only OF fwnode is supported so extend this
+	 * function for ACPI support.
+	 */
+	if (!is_of_node(fwnode))
+		return -EINVAL;
+
+	rc =3D of_irq_parse_one(to_of_node(fwnode), index, &parent);
+	if (rc)
+		return rc;
+
+	/*
+	 * Skip interrupts other than external interrupts for
+	 * current privilege level.
+	 */
+	if (parent.args[0] !=3D RV_IRQ_EXT)
+		return -EINVAL;
+
+	return riscv_of_parent_hartid(parent.np, hartid);
+}
+
+static int __init imsic_get_mmio_resource(struct fwnode_handle *fwnode,
+					  u32 index, struct resource *res)
+{
+	/*
+	 * Currently, only OF fwnode is supported so extend this
+	 * function for ACPI support.
+	 */
+	if (!is_of_node(fwnode))
+		return -EINVAL;
+
+	return of_address_to_resource(to_of_node(fwnode), index, res);
+}
+
+static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
+				     struct imsic_global_config *global,
+				     u32 *nr_parent_irqs,
+				     u32 *nr_mmios)
+{
+	unsigned long hartid;
+	struct resource res;
+	int rc;
+	u32 i;
+
+	/*
+	 * Currently, only OF fwnode is supported so extend this
+	 * function for ACPI support.
+	 */
+	if (!is_of_node(fwnode))
+		return -EINVAL;
+
+	*nr_parent_irqs =3D 0;
+	*nr_mmios =3D 0;
+
+	/* Find number of parent interrupts */
+	while (!imsic_get_parent_hartid(fwnode, *nr_parent_irqs, &hartid))
+		(*nr_parent_irqs)++;
+	if (!*nr_parent_irqs) {
+		pr_err("%pfwP: no parent irqs available\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Find number of guest index bits in MSI address */
+	rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,guest-index-bits",
+				  &global->guest_index_bits);
+	if (rc)
+		global->guest_index_bits =3D 0;
+
+	/* Find number of HART index bits */
+	rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,hart-index-bits",
+				  &global->hart_index_bits);
+	if (rc) {
+		/* Assume default value */
+		global->hart_index_bits =3D __fls(*nr_parent_irqs);
+		if (BIT(global->hart_index_bits) < *nr_parent_irqs)
+			global->hart_index_bits++;
+	}
+
+	/* Find number of group index bits */
+	rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,group-index-bits",
+				  &global->group_index_bits);
+	if (rc)
+		global->group_index_bits =3D 0;
+
+	/*
+	 * Find first bit position of group index.
+	 * If not specified assumed the default APLIC-IMSIC configuration.
+	 */
+	rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,group-index-shift",
+				  &global->group_index_shift);
+	if (rc)
+		global->group_index_shift =3D IMSIC_MMIO_PAGE_SHIFT * 2;
+
+	/* Find number of interrupt identities */
+	rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,num-ids",
+				  &global->nr_ids);
+	if (rc) {
+		pr_err("%pfwP: number of interrupt identities not found\n", fwnode);
+		return rc;
+	}
+
+	/* Find number of guest interrupt identities */
+	rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,num-guest-ids",
+				  &global->nr_guest_ids);
+	if (rc)
+		global->nr_guest_ids =3D global->nr_ids;
+
+	/* Sanity check guest index bits */
+	i =3D BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT;
+	if (i < global->guest_index_bits) {
+		pr_err("%pfwP: guest index bits too big\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Sanity check HART index bits */
+	i =3D BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT - global->guest_index_bits;
+	if (i < global->hart_index_bits) {
+		pr_err("%pfwP: HART index bits too big\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Sanity check group index bits */
+	i =3D BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT -
+	    global->guest_index_bits - global->hart_index_bits;
+	if (i < global->group_index_bits) {
+		pr_err("%pfwP: group index bits too big\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Sanity check group index shift */
+	i =3D global->group_index_bits + global->group_index_shift - 1;
+	if (i >=3D BITS_PER_LONG) {
+		pr_err("%pfwP: group index shift too big\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Sanity check number of interrupt identities */
+	if (global->nr_ids < IMSIC_MIN_ID ||
+	    global->nr_ids >=3D IMSIC_MAX_ID ||
+	    (global->nr_ids & IMSIC_MIN_ID) !=3D IMSIC_MIN_ID) {
+		pr_err("%pfwP: invalid number of interrupt identities\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Sanity check number of guest interrupt identities */
+	if (global->nr_guest_ids < IMSIC_MIN_ID ||
+	    global->nr_guest_ids >=3D IMSIC_MAX_ID ||
+	    (global->nr_guest_ids & IMSIC_MIN_ID) !=3D IMSIC_MIN_ID) {
+		pr_err("%pfwP: invalid number of guest interrupt identities\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Compute base address */
+	rc =3D imsic_get_mmio_resource(fwnode, 0, &res);
+	if (rc) {
+		pr_err("%pfwP: first MMIO resource not found\n", fwnode);
+		return -EINVAL;
+	}
+	global->base_addr =3D res.start;
+	global->base_addr &=3D ~(BIT(global->guest_index_bits +
+				   global->hart_index_bits +
+				   IMSIC_MMIO_PAGE_SHIFT) - 1);
+	global->base_addr &=3D ~((BIT(global->group_index_bits) - 1) <<
+			       global->group_index_shift);
+
+	/* Find number of MMIO register sets */
+	while (!imsic_get_mmio_resource(fwnode, *nr_mmios, &res))
+		(*nr_mmios)++;
+
+	return 0;
+}
+
+int __init imsic_setup_state(struct fwnode_handle *fwnode)
+{
+	u32 i, j, index, nr_parent_irqs, nr_mmios, nr_handlers =3D 0;
+	struct imsic_global_config *global;
+	struct imsic_local_config *local;
+	void __iomem **mmios_va =3D NULL;
+	struct resource *mmios =3D NULL;
+	unsigned long reloff, hartid;
+	phys_addr_t base_addr;
+	int rc, cpu;
+
+	/*
+	 * Only one IMSIC instance allowed in a platform for clean
+	 * implementation of SMP IRQ affinity and per-CPU IPIs.
+	 *
+	 * This means on a multi-socket (or multi-die) platform we
+	 * will have multiple MMIO regions for one IMSIC instance.
+	 */
+	if (imsic) {
+		pr_err("%pfwP: already initialized hence ignoring\n", fwnode);
+		return -EALREADY;
+	}
+
+	if (!riscv_isa_extension_available(NULL, SxAIA)) {
+		pr_err("%pfwP: AIA support not available\n", fwnode);
+		return -ENODEV;
+	}
+
+	imsic =3D kzalloc(sizeof(*imsic), GFP_KERNEL);
+	if (!imsic)
+		return -ENOMEM;
+	imsic->fwnode =3D fwnode;
+	global =3D &imsic->global;
+
+	global->local =3D alloc_percpu(typeof(*global->local));
+	if (!global->local) {
+		rc =3D -ENOMEM;
+		goto out_free_priv;
+	}
+
+	/* Parse IMSIC fwnode */
+	rc =3D imsic_parse_fwnode(fwnode, global, &nr_parent_irqs, &nr_mmios);
+	if (rc)
+		goto out_free_local;
+
+	/* Allocate MMIO resource array */
+	mmios =3D kcalloc(nr_mmios, sizeof(*mmios), GFP_KERNEL);
+	if (!mmios) {
+		rc =3D -ENOMEM;
+		goto out_free_local;
+	}
+
+	/* Allocate MMIO virtual address array */
+	mmios_va =3D kcalloc(nr_mmios, sizeof(*mmios_va), GFP_KERNEL);
+	if (!mmios_va) {
+		rc =3D -ENOMEM;
+		goto out_iounmap;
+	}
+
+	/* Parse and map MMIO register sets */
+	for (i =3D 0; i < nr_mmios; i++) {
+		rc =3D imsic_get_mmio_resource(fwnode, i, &mmios[i]);
+		if (rc) {
+			pr_err("%pfwP: unable to parse MMIO regset %d\n", fwnode, i);
+			goto out_iounmap;
+		}
+
+		base_addr =3D mmios[i].start;
+		base_addr &=3D ~(BIT(global->guest_index_bits +
+				   global->hart_index_bits +
+				   IMSIC_MMIO_PAGE_SHIFT) - 1);
+		base_addr &=3D ~((BIT(global->group_index_bits) - 1) <<
+			       global->group_index_shift);
+		if (base_addr !=3D global->base_addr) {
+			rc =3D -EINVAL;
+			pr_err("%pfwP: address mismatch for regset %d\n", fwnode, i);
+			goto out_iounmap;
+		}
+
+		mmios_va[i] =3D ioremap(mmios[i].start, resource_size(&mmios[i]));
+		if (!mmios_va[i]) {
+			rc =3D -EIO;
+			pr_err("%pfwP: unable to map MMIO regset %d\n", fwnode, i);
+			goto out_iounmap;
+		}
+	}
+
+	/* Initialize local (or per-CPU )state */
+	rc =3D imsic_local_init();
+	if (rc) {
+		pr_err("%pfwP: failed to initialize local state\n",
+		       fwnode);
+		goto out_iounmap;
+	}
+
+	/* Configure handlers for target CPUs */
+	for (i =3D 0; i < nr_parent_irqs; i++) {
+		rc =3D imsic_get_parent_hartid(fwnode, i, &hartid);
+		if (rc) {
+			pr_warn("%pfwP: hart ID for parent irq%d not found\n", fwnode, i);
+			continue;
+		}
+
+		cpu =3D riscv_hartid_to_cpuid(hartid);
+		if (cpu < 0) {
+			pr_warn("%pfwP: invalid cpuid for parent irq%d\n", fwnode, i);
+			continue;
+		}
+
+		/* Find MMIO location of MSI page */
+		index =3D nr_mmios;
+		reloff =3D i * BIT(global->guest_index_bits) *
+			 IMSIC_MMIO_PAGE_SZ;
+		for (j =3D 0; nr_mmios; j++) {
+			if (reloff < resource_size(&mmios[j])) {
+				index =3D j;
+				break;
+			}
+
+			/*
+			 * MMIO region size may not be aligned to
+			 * BIT(global->guest_index_bits) * IMSIC_MMIO_PAGE_SZ
+			 * if holes are present.
+			 */
+			reloff -=3D ALIGN(resource_size(&mmios[j]),
+			BIT(global->guest_index_bits) * IMSIC_MMIO_PAGE_SZ);
+		}
+		if (index >=3D nr_mmios) {
+			pr_warn("%pfwP: MMIO not found for parent irq%d\n", fwnode, i);
+			continue;
+		}
+
+		local =3D per_cpu_ptr(global->local, cpu);
+		local->msi_pa =3D mmios[index].start + reloff;
+		local->msi_va =3D mmios_va[index] + reloff;
+
+		nr_handlers++;
+	}
+
+	/* If no CPU handlers found then can't take interrupts */
+	if (!nr_handlers) {
+		pr_err("%pfwP: No CPU handlers found\n", fwnode);
+		rc =3D -ENODEV;
+		goto out_local_cleanup;
+	}
+
+	/* Initialize matrix allocator */
+	rc =3D imsic_matrix_init();
+	if (rc) {
+		pr_err("%pfwP: failed to create matrix allocator\n", fwnode);
+		goto out_local_cleanup;
+	}
+
+	/* We don't need MMIO arrays anymore so let's free-up */
+	kfree(mmios_va);
+	kfree(mmios);
+
+	return 0;
+
+out_local_cleanup:
+	imsic_local_cleanup();
+out_iounmap:
+	for (i =3D 0; i < nr_mmios; i++) {
+		if (mmios_va[i])
+			iounmap(mmios_va[i]);
+	}
+	kfree(mmios_va);
+	kfree(mmios);
+out_free_local:
+	free_percpu(imsic->global.local);
+out_free_priv:
+	kfree(imsic);
+	imsic =3D NULL;
+	return rc;
+}
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-ri=
scv-imsic-state.h
new file mode 100644
index 000000000000..5ae2f69b035b
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#ifndef _IRQ_RISCV_IMSIC_STATE_H
+#define _IRQ_RISCV_IMSIC_STATE_H
+
+#include <linux/irqchip/riscv-imsic.h>
+#include <linux/irqdomain.h>
+#include <linux/fwnode.h>
+#include <linux/timer.h>
+
+#define IMSIC_IPI_ID				1
+#define IMSIC_NR_IPI				8
+
+struct imsic_vector {
+	/* Fixed details of the vector */
+	unsigned int				cpu;
+	unsigned int				local_id;
+	/* Details saved by driver in the vector */
+	unsigned int				hwirq;
+	/* Details accessed using local lock held */
+	bool					enable;
+	struct imsic_vector			*move;
+};
+
+struct imsic_local_priv {
+	/* Local lock to protect vector enable/move variables and dirty bitmap */
+	raw_spinlock_t				lock;
+
+	/* Local dirty bitmap for synchronization */
+	unsigned long				*dirty_bitmap;
+
+#ifdef CONFIG_SMP
+	/* Local timer for synchronization */
+	struct timer_list			timer;
+#endif
+
+	/* Local vector table */
+	struct imsic_vector			*vectors;
+};
+
+struct imsic_priv {
+	/* Device details */
+	struct fwnode_handle			*fwnode;
+
+	/* Global configuration common for all HARTs */
+	struct imsic_global_config		global;
+
+	/* Per-CPU state */
+	struct imsic_local_priv __percpu	*lpriv;
+
+	/* State of IRQ matrix allocator */
+	raw_spinlock_t				matrix_lock;
+	struct irq_matrix			*matrix;
+
+	/* IRQ domains (created by platform driver) */
+	struct irq_domain			*base_domain;
+};
+
+extern struct imsic_priv *imsic;
+
+void __imsic_eix_update(unsigned long base_id, unsigned long num_id, bool pe=
nd, bool val);
+
+static inline void __imsic_id_set_enable(unsigned long id)
+{
+	__imsic_eix_update(id, 1, false, true);
+}
+
+static inline void __imsic_id_clear_enable(unsigned long id)
+{
+	__imsic_eix_update(id, 1, false, false);
+}
+
+void imsic_local_sync_all(void);
+void imsic_local_delivery(bool enable);
+
+void imsic_vector_mask(struct imsic_vector *vec);
+void imsic_vector_unmask(struct imsic_vector *vec);
+
+static inline bool imsic_vector_isenabled(struct imsic_vector *vec)
+{
+	return READ_ONCE(vec->enable);
+}
+
+static inline struct imsic_vector *imsic_vector_get_move(struct imsic_vector=
 *vec)
+{
+	return READ_ONCE(vec->move);
+}
+
+void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *ne=
w_vec);
+
+struct imsic_vector *imsic_vector_from_local_id(unsigned int cpu, unsigned i=
nt local_id);
+
+struct imsic_vector *imsic_vector_alloc(unsigned int hwirq, const struct cpu=
mask *mask);
+void imsic_vector_free(struct imsic_vector *vector);
+
+void imsic_vector_debug_show(struct seq_file *m, struct imsic_vector *vec, i=
nt ind);
+void imsic_vector_debug_show_summary(struct seq_file *m, int ind);
+
+void imsic_state_online(void);
+void imsic_state_offline(void);
+int imsic_setup_state(struct fwnode_handle *fwnode);
+int imsic_irqdomain_init(void);
+
+#endif
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-p=
lic.c
index f3d4cb9e34f7..8fb183ced1e7 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -164,15 +164,12 @@ static int plic_set_affinity(struct irq_data *d,
 			     const struct cpumask *mask_val, bool force)
 {
 	unsigned int cpu;
-	struct cpumask amask;
 	struct plic_priv *priv =3D irq_data_get_irq_chip_data(d);
=20
-	cpumask_and(&amask, &priv->lmask, mask_val);
-
 	if (force)
-		cpu =3D cpumask_first(&amask);
+		cpu =3D cpumask_first_and(&priv->lmask, mask_val);
 	else
-		cpu =3D cpumask_any_and(&amask, cpu_online_mask);
+		cpu =3D cpumask_first_and_and(&priv->lmask, mask_val, cpu_online_mask);
=20
 	if (cpu >=3D nr_cpu_ids)
 		return -EINVAL;
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-ext=
i.c
index 26a5193d0ae4..2cc9f3b7d669 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -19,13 +19,26 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
-#include <linux/syscore_ops.h>
+#include <linux/pm.h>
=20
 #include <dt-bindings/interrupt-controller/arm-gic.h>
=20
-#define IRQS_PER_BANK 32
+#define IRQS_PER_BANK			32
=20
-#define HWSPNLCK_TIMEOUT	1000 /* usec */
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
=20
 struct stm32_exti_bank {
 	u32 imr_ofst;
@@ -36,6 +49,7 @@ struct stm32_exti_bank {
 	u32 rpr_ofst;
 	u32 fpr_ofst;
 	u32 trg_ofst;
+	u32 seccfgr_ofst;
 };
=20
 #define UNDEF_REG ~0
@@ -54,17 +68,18 @@ struct stm32_exti_chip_data {
 	u32 mask_cache;
 	u32 rtsr_cache;
 	u32 ftsr_cache;
+	u32 event_reserved;
 };
=20
 struct stm32_exti_host_data {
 	void __iomem *base;
+	struct device *dev;
 	struct stm32_exti_chip_data *chips_data;
 	const struct stm32_exti_drv_data *drv_data;
 	struct hwspinlock *hwlock;
+	bool dt_has_irqs_desc; /* skip internal desc_irqs array and get it from DT =
*/
 };
=20
-static struct stm32_exti_host_data *stm32_host_data;
-
 static const struct stm32_exti_bank stm32f4xx_exti_b1 =3D {
 	.imr_ofst	=3D 0x00,
 	.emr_ofst	=3D 0x04,
@@ -74,6 +89,7 @@ static const struct stm32_exti_bank stm32f4xx_exti_b1 =3D {
 	.rpr_ofst	=3D 0x14,
 	.fpr_ofst	=3D UNDEF_REG,
 	.trg_ofst	=3D UNDEF_REG,
+	.seccfgr_ofst	=3D UNDEF_REG,
 };
=20
 static const struct stm32_exti_bank *stm32f4xx_exti_banks[] =3D {
@@ -94,6 +110,7 @@ static const struct stm32_exti_bank stm32h7xx_exti_b1 =3D {
 	.rpr_ofst	=3D 0x88,
 	.fpr_ofst	=3D UNDEF_REG,
 	.trg_ofst	=3D UNDEF_REG,
+	.seccfgr_ofst	=3D UNDEF_REG,
 };
=20
 static const struct stm32_exti_bank stm32h7xx_exti_b2 =3D {
@@ -105,6 +122,7 @@ static const struct stm32_exti_bank stm32h7xx_exti_b2 =3D=
 {
 	.rpr_ofst	=3D 0x98,
 	.fpr_ofst	=3D UNDEF_REG,
 	.trg_ofst	=3D UNDEF_REG,
+	.seccfgr_ofst	=3D UNDEF_REG,
 };
=20
 static const struct stm32_exti_bank stm32h7xx_exti_b3 =3D {
@@ -116,6 +134,7 @@ static const struct stm32_exti_bank stm32h7xx_exti_b3 =3D=
 {
 	.rpr_ofst	=3D 0xA8,
 	.fpr_ofst	=3D UNDEF_REG,
 	.trg_ofst	=3D UNDEF_REG,
+	.seccfgr_ofst	=3D UNDEF_REG,
 };
=20
 static const struct stm32_exti_bank *stm32h7xx_exti_banks[] =3D {
@@ -138,6 +157,7 @@ static const struct stm32_exti_bank stm32mp1_exti_b1 =3D {
 	.rpr_ofst	=3D 0x0C,
 	.fpr_ofst	=3D 0x10,
 	.trg_ofst	=3D 0x3EC,
+	.seccfgr_ofst	=3D 0x14,
 };
=20
 static const struct stm32_exti_bank stm32mp1_exti_b2 =3D {
@@ -149,6 +169,7 @@ static const struct stm32_exti_bank stm32mp1_exti_b2 =3D {
 	.rpr_ofst	=3D 0x2C,
 	.fpr_ofst	=3D 0x30,
 	.trg_ofst	=3D 0x3E8,
+	.seccfgr_ofst	=3D 0x34,
 };
=20
 static const struct stm32_exti_bank stm32mp1_exti_b3 =3D {
@@ -160,6 +181,7 @@ static const struct stm32_exti_bank stm32mp1_exti_b3 =3D {
 	.rpr_ofst	=3D 0x4C,
 	.fpr_ofst	=3D 0x50,
 	.trg_ofst	=3D 0x3E4,
+	.seccfgr_ofst	=3D 0x54,
 };
=20
 static const struct stm32_exti_bank *stm32mp1_exti_banks[] =3D {
@@ -322,7 +344,7 @@ static void stm32_irq_handler(struct irq_desc *desc)
 		while ((pending =3D stm32_exti_pending(gc))) {
 			for_each_set_bit(n, &pending, IRQS_PER_BANK)
 				generic_handle_domain_irq(domain, irq_base + n);
- 		}
+		}
 	}
=20
 	chained_irq_exit(chip, desc);
@@ -621,50 +643,32 @@ static int stm32_exti_h_set_affinity(struct irq_data *d,
 	return IRQ_SET_MASK_OK_DONE;
 }
=20
-static int __maybe_unused stm32_exti_h_suspend(void)
+static int stm32_exti_h_suspend(struct device *dev)
 {
+	struct stm32_exti_host_data *host_data =3D dev_get_drvdata(dev);
 	struct stm32_exti_chip_data *chip_data;
 	int i;
=20
-	for (i =3D 0; i < stm32_host_data->drv_data->bank_nr; i++) {
-		chip_data =3D &stm32_host_data->chips_data[i];
-		raw_spin_lock(&chip_data->rlock);
+	for (i =3D 0; i < host_data->drv_data->bank_nr; i++) {
+		chip_data =3D &host_data->chips_data[i];
 		stm32_chip_suspend(chip_data, chip_data->wake_active);
-		raw_spin_unlock(&chip_data->rlock);
 	}
=20
 	return 0;
 }
=20
-static void __maybe_unused stm32_exti_h_resume(void)
+static int stm32_exti_h_resume(struct device *dev)
 {
+	struct stm32_exti_host_data *host_data =3D dev_get_drvdata(dev);
 	struct stm32_exti_chip_data *chip_data;
 	int i;
=20
-	for (i =3D 0; i < stm32_host_data->drv_data->bank_nr; i++) {
-		chip_data =3D &stm32_host_data->chips_data[i];
-		raw_spin_lock(&chip_data->rlock);
+	for (i =3D 0; i < host_data->drv_data->bank_nr; i++) {
+		chip_data =3D &host_data->chips_data[i];
 		stm32_chip_resume(chip_data, chip_data->mask_cache);
-		raw_spin_unlock(&chip_data->rlock);
 	}
-}
=20
-static struct syscore_ops stm32_exti_h_syscore_ops =3D {
-#ifdef CONFIG_PM_SLEEP
-	.suspend	=3D stm32_exti_h_suspend,
-	.resume		=3D stm32_exti_h_resume,
-#endif
-};
-
-static void stm32_exti_h_syscore_init(struct stm32_exti_host_data *host_data)
-{
-	stm32_host_data =3D host_data;
-	register_syscore_ops(&stm32_exti_h_syscore_ops);
-}
-
-static void stm32_exti_h_syscore_deinit(void)
-{
-	unregister_syscore_ops(&stm32_exti_h_syscore_ops);
+	return 0;
 }
=20
 static int stm32_exti_h_retrigger(struct irq_data *d)
@@ -725,12 +729,35 @@ static int stm32_exti_h_domain_alloc(struct irq_domain =
*dm,
 	bank  =3D hwirq / IRQS_PER_BANK;
 	chip_data =3D &host_data->chips_data[bank];
=20
+	/* Check if event is reserved (Secure) */
+	if (chip_data->event_reserved & BIT(hwirq % IRQS_PER_BANK)) {
+		dev_err(host_data->dev, "event %lu is reserved, secure\n", hwirq);
+		return -EPERM;
+	}
+
 	event_trg =3D readl_relaxed(host_data->base + chip_data->reg_bank->trg_ofst=
);
 	chip =3D (event_trg & BIT(hwirq % IRQS_PER_BANK)) ?
 	       &stm32_exti_h_chip : &stm32_exti_h_chip_direct;
=20
 	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, chip, chip_data);
=20
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
 	if (!host_data->drv_data->desc_irqs)
 		return -EINVAL;
=20
@@ -771,8 +798,6 @@ stm32_exti_host_data *stm32_exti_host_init(const struct s=
tm32_exti_drv_data *dd,
 		goto free_chips_data;
 	}
=20
-	stm32_host_data =3D host_data;
-
 	return host_data;
=20
 free_chips_data:
@@ -807,6 +832,10 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_=
exti_host_data *h_data,
 	if (stm32_bank->emr_ofst !=3D UNDEF_REG)
 		writel_relaxed(0, base + stm32_bank->emr_ofst);
=20
+	/* reserve Secure events */
+	if (stm32_bank->seccfgr_ofst !=3D UNDEF_REG)
+		chip_data->event_reserved =3D readl_relaxed(base + stm32_bank->seccfgr_ofs=
t);
+
 	pr_info("%pOF: bank%d\n", node, bank_idx);
=20
 	return chip_data;
@@ -891,6 +920,27 @@ static const struct irq_domain_ops stm32_exti_h_domain_o=
ps =3D {
 	.xlate =3D irq_domain_xlate_twocell,
 };
=20
+static void stm32_exti_check_rif(struct stm32_exti_host_data *host_data)
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
 static void stm32_exti_remove_irq(void *data)
 {
 	struct irq_domain *domain =3D data;
@@ -898,11 +948,6 @@ static void stm32_exti_remove_irq(void *data)
 	irq_domain_remove(domain);
 }
=20
-static void stm32_exti_remove(struct platform_device *pdev)
-{
-	stm32_exti_h_syscore_deinit();
-}
-
 static int stm32_exti_probe(struct platform_device *pdev)
 {
 	int ret, i;
@@ -916,6 +961,9 @@ static int stm32_exti_probe(struct platform_device *pdev)
 	if (!host_data)
 		return -ENOMEM;
=20
+	dev_set_drvdata(dev, host_data);
+	host_data->dev =3D dev;
+
 	/* check for optional hwspinlock which may be not available yet */
 	ret =3D of_hwspin_lock_get_id(np, 0);
 	if (ret =3D=3D -EPROBE_DEFER)
@@ -955,6 +1003,8 @@ static int stm32_exti_probe(struct platform_device *pdev)
 	for (i =3D 0; i < drv_data->bank_nr; i++)
 		stm32_exti_chip_init(host_data, i, np);
=20
+	stm32_exti_check_rif(host_data);
+
 	parent_domain =3D irq_find_host(of_irq_find_parent(np));
 	if (!parent_domain) {
 		dev_err(dev, "GIC interrupt-parent not found\n");
@@ -975,7 +1025,8 @@ static int stm32_exti_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
=20
-	stm32_exti_h_syscore_init(host_data);
+	if (of_property_read_bool(np, "interrupts-extended"))
+		host_data->dt_has_irqs_desc =3D true;
=20
 	return 0;
 }
@@ -988,12 +1039,16 @@ static const struct of_device_id stm32_exti_ids[] =3D {
 };
 MODULE_DEVICE_TABLE(of, stm32_exti_ids);
=20
+static const struct dev_pm_ops stm32_exti_dev_pm_ops =3D {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_exti_h_suspend, stm32_exti_h_resume)
+};
+
 static struct platform_driver stm32_exti_driver =3D {
 	.probe		=3D stm32_exti_probe,
-	.remove_new	=3D stm32_exti_remove,
 	.driver		=3D {
 		.name		=3D "stm32_exti",
 		.of_match_table	=3D stm32_exti_ids,
+		.pm		=3D &stm32_exti_dev_pm_ops,
 	},
 };
=20
diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index e760b1278143..bb92fd85e975 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -192,7 +192,6 @@ static int __init sunxi_sc_nmi_irq_init(struct device_nod=
e *node,
 	gc->chip_types[0].regs.type		=3D reg_offs->ctrl;
=20
 	gc->chip_types[1].type			=3D IRQ_TYPE_EDGE_BOTH;
-	gc->chip_types[1].chip.name		=3D gc->chip_types[0].chip.name;
 	gc->chip_types[1].chip.irq_ack		=3D irq_gc_ack_set_bit;
 	gc->chip_types[1].chip.irq_mask		=3D irq_gc_mask_clr_bit;
 	gc->chip_types[1].chip.irq_unmask	=3D irq_gc_mask_set_bit;
diff --git a/drivers/irqchip/irq-tb10x.c b/drivers/irqchip/irq-tb10x.c
index 680586354d12..d59bfbe8c6d0 100644
--- a/drivers/irqchip/irq-tb10x.c
+++ b/drivers/irqchip/irq-tb10x.c
@@ -150,7 +150,6 @@ static int __init of_tb10x_init_irq(struct device_node *i=
ctl,
 	gc->chip_types[0].regs.mask          =3D AB_IRQCTL_INT_ENABLE;
=20
 	gc->chip_types[1].type               =3D IRQ_TYPE_EDGE_BOTH;
-	gc->chip_types[1].chip.name          =3D gc->chip_types[0].chip.name;
 	gc->chip_types[1].chip.irq_ack       =3D irq_gc_ack_set_bit;
 	gc->chip_types[1].chip.irq_mask      =3D irq_gc_mask_clr_bit;
 	gc->chip_types[1].chip.irq_unmask    =3D irq_gc_mask_set_bit;
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 35e78ddb2b37..7a5785f405b6 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -146,6 +146,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
 	CPUHP_AP_IRQ_LOONGARCH_STARTING,
 	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
+	CPUHP_AP_IRQ_RISCV_IMSIC_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
 	CPUHP_AP_PERF_X86_STARTING,
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 1c29947db848..c46f9e9e1d66 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -187,6 +187,23 @@ unsigned int cpumask_first_and(const struct cpumask *src=
p1, const struct cpumask
 	return find_first_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), small_c=
pumask_bits);
 }
=20
+/**
+ * cpumask_first_and_and - return the first cpu from *srcp1 & *srcp2 & *srcp3
+ * @srcp1: the first input
+ * @srcp2: the second input
+ * @srcp3: the third input
+ *
+ * Return: >=3D nr_cpu_ids if no cpus set in all.
+ */
+static inline
+unsigned int cpumask_first_and_and(const struct cpumask *srcp1,
+				   const struct cpumask *srcp2,
+				   const struct cpumask *srcp3)
+{
+	return find_first_and_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2),
+				      cpumask_bits(srcp3), small_cpumask_bits);
+}
+
 /**
  * cpumask_last - get the last CPU in a cpumask
  * @srcp:	- the cpumask pointer
diff --git a/include/linux/find.h b/include/linux/find.h
index c69598e383c1..28ec5a03393a 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -29,6 +29,8 @@ unsigned long __find_nth_and_andnot_bit(const unsigned long=
 *addr1, const unsign
 					unsigned long n);
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 					 const unsigned long *addr2, unsigned long size);
+unsigned long _find_first_and_and_bit(const unsigned long *addr1, const unsi=
gned long *addr2,
+				      const unsigned long *addr3, unsigned long size);
 extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigne=
d long size);
 extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long=
 size);
=20
@@ -345,6 +347,31 @@ unsigned long find_first_and_bit(const unsigned long *ad=
dr1,
 }
 #endif
=20
+/**
+ * find_first_and_and_bit - find the first set bit in 3 memory regions
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @addr3: The third address to base the search on
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the first set bit
+ * If no bits are set, returns @size.
+ */
+static inline
+unsigned long find_first_and_and_bit(const unsigned long *addr1,
+				     const unsigned long *addr2,
+				     const unsigned long *addr3,
+				     unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val =3D *addr1 & *addr2 & *addr3 & GENMASK(size - 1, 0);
+
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_first_and_and_bit(addr1, addr2, addr3, size);
+}
+
 #ifndef find_first_zero_bit
 /**
  * find_first_zero_bit - find the first cleared bit in a memory region
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 97baa937ab5b..a217e1029c1d 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -115,7 +115,7 @@ enum {
  * Return value for chip->irq_set_affinity()
  *
  * IRQ_SET_MASK_OK	- OK, core updates irq_common_data.affinity
- * IRQ_SET_MASK_NOCPY	- OK, chip did update irq_common_data.affinity
+ * IRQ_SET_MASK_NOCOPY	- OK, chip did update irq_common_data.affinity
  * IRQ_SET_MASK_OK_DONE	- Same as IRQ_SET_MASK_OK for core. Special code to
  *			  support stacked irqchips, which indicates skipping
  *			  all descendant irqchips.
diff --git a/include/linux/irqchip/riscv-aplic.h b/include/linux/irqchip/risc=
v-aplic.h
new file mode 100644
index 000000000000..ec8f7df50583
--- /dev/null
+++ b/include/linux/irqchip/riscv-aplic.h
@@ -0,0 +1,145 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+#ifndef __LINUX_IRQCHIP_RISCV_APLIC_H
+#define __LINUX_IRQCHIP_RISCV_APLIC_H
+
+#include <linux/bitops.h>
+
+#define APLIC_MAX_IDC			BIT(14)
+#define APLIC_MAX_SOURCE		1024
+
+#define APLIC_DOMAINCFG			0x0000
+#define APLIC_DOMAINCFG_RDONLY		0x80000000
+#define APLIC_DOMAINCFG_IE		BIT(8)
+#define APLIC_DOMAINCFG_DM		BIT(2)
+#define APLIC_DOMAINCFG_BE		BIT(0)
+
+#define APLIC_SOURCECFG_BASE		0x0004
+#define APLIC_SOURCECFG_D		BIT(10)
+#define APLIC_SOURCECFG_CHILDIDX_MASK	0x000003ff
+#define APLIC_SOURCECFG_SM_MASK	0x00000007
+#define APLIC_SOURCECFG_SM_INACTIVE	0x0
+#define APLIC_SOURCECFG_SM_DETACH	0x1
+#define APLIC_SOURCECFG_SM_EDGE_RISE	0x4
+#define APLIC_SOURCECFG_SM_EDGE_FALL	0x5
+#define APLIC_SOURCECFG_SM_LEVEL_HIGH	0x6
+#define APLIC_SOURCECFG_SM_LEVEL_LOW	0x7
+
+#define APLIC_MMSICFGADDR		0x1bc0
+#define APLIC_MMSICFGADDRH		0x1bc4
+#define APLIC_SMSICFGADDR		0x1bc8
+#define APLIC_SMSICFGADDRH		0x1bcc
+
+#ifdef CONFIG_RISCV_M_MODE
+#define APLIC_xMSICFGADDR		APLIC_MMSICFGADDR
+#define APLIC_xMSICFGADDRH		APLIC_MMSICFGADDRH
+#else
+#define APLIC_xMSICFGADDR		APLIC_SMSICFGADDR
+#define APLIC_xMSICFGADDRH		APLIC_SMSICFGADDRH
+#endif
+
+#define APLIC_xMSICFGADDRH_L		BIT(31)
+#define APLIC_xMSICFGADDRH_HHXS_MASK	0x1f
+#define APLIC_xMSICFGADDRH_HHXS_SHIFT	24
+#define APLIC_xMSICFGADDRH_HHXS		(APLIC_xMSICFGADDRH_HHXS_MASK << \
+					 APLIC_xMSICFGADDRH_HHXS_SHIFT)
+#define APLIC_xMSICFGADDRH_LHXS_MASK	0x7
+#define APLIC_xMSICFGADDRH_LHXS_SHIFT	20
+#define APLIC_xMSICFGADDRH_LHXS		(APLIC_xMSICFGADDRH_LHXS_MASK << \
+					 APLIC_xMSICFGADDRH_LHXS_SHIFT)
+#define APLIC_xMSICFGADDRH_HHXW_MASK	0x7
+#define APLIC_xMSICFGADDRH_HHXW_SHIFT	16
+#define APLIC_xMSICFGADDRH_HHXW		(APLIC_xMSICFGADDRH_HHXW_MASK << \
+					 APLIC_xMSICFGADDRH_HHXW_SHIFT)
+#define APLIC_xMSICFGADDRH_LHXW_MASK	0xf
+#define APLIC_xMSICFGADDRH_LHXW_SHIFT	12
+#define APLIC_xMSICFGADDRH_LHXW		(APLIC_xMSICFGADDRH_LHXW_MASK << \
+					 APLIC_xMSICFGADDRH_LHXW_SHIFT)
+#define APLIC_xMSICFGADDRH_BAPPN_MASK	0xfff
+#define APLIC_xMSICFGADDRH_BAPPN_SHIFT	0
+#define APLIC_xMSICFGADDRH_BAPPN	(APLIC_xMSICFGADDRH_BAPPN_MASK << \
+					 APLIC_xMSICFGADDRH_BAPPN_SHIFT)
+
+#define APLIC_xMSICFGADDR_PPN_SHIFT	12
+
+#define APLIC_xMSICFGADDR_PPN_HART(__lhxs) \
+	(BIT(__lhxs) - 1)
+
+#define APLIC_xMSICFGADDR_PPN_LHX_MASK(__lhxw) \
+	(BIT(__lhxw) - 1)
+#define APLIC_xMSICFGADDR_PPN_LHX_SHIFT(__lhxs) \
+	((__lhxs))
+#define APLIC_xMSICFGADDR_PPN_LHX(__lhxw, __lhxs) \
+	(APLIC_xMSICFGADDR_PPN_LHX_MASK(__lhxw) << \
+	 APLIC_xMSICFGADDR_PPN_LHX_SHIFT(__lhxs))
+
+#define APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) \
+	(BIT(__hhxw) - 1)
+#define APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs) \
+	((__hhxs) + APLIC_xMSICFGADDR_PPN_SHIFT)
+#define APLIC_xMSICFGADDR_PPN_HHX(__hhxw, __hhxs) \
+	(APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) << \
+	 APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs))
+
+#define APLIC_IRQBITS_PER_REG		32
+
+#define APLIC_SETIP_BASE		0x1c00
+#define APLIC_SETIPNUM			0x1cdc
+
+#define APLIC_CLRIP_BASE		0x1d00
+#define APLIC_CLRIPNUM			0x1ddc
+
+#define APLIC_SETIE_BASE		0x1e00
+#define APLIC_SETIENUM			0x1edc
+
+#define APLIC_CLRIE_BASE		0x1f00
+#define APLIC_CLRIENUM			0x1fdc
+
+#define APLIC_SETIPNUM_LE		0x2000
+#define APLIC_SETIPNUM_BE		0x2004
+
+#define APLIC_GENMSI			0x3000
+
+#define APLIC_TARGET_BASE		0x3004
+#define APLIC_TARGET_HART_IDX_SHIFT	18
+#define APLIC_TARGET_HART_IDX_MASK	0x3fff
+#define APLIC_TARGET_HART_IDX		(APLIC_TARGET_HART_IDX_MASK << \
+					 APLIC_TARGET_HART_IDX_SHIFT)
+#define APLIC_TARGET_GUEST_IDX_SHIFT	12
+#define APLIC_TARGET_GUEST_IDX_MASK	0x3f
+#define APLIC_TARGET_GUEST_IDX		(APLIC_TARGET_GUEST_IDX_MASK << \
+					 APLIC_TARGET_GUEST_IDX_SHIFT)
+#define APLIC_TARGET_IPRIO_SHIFT	0
+#define APLIC_TARGET_IPRIO_MASK		0xff
+#define APLIC_TARGET_IPRIO		(APLIC_TARGET_IPRIO_MASK << \
+					 APLIC_TARGET_IPRIO_SHIFT)
+#define APLIC_TARGET_EIID_SHIFT		0
+#define APLIC_TARGET_EIID_MASK		0x7ff
+#define APLIC_TARGET_EIID		(APLIC_TARGET_EIID_MASK << \
+					 APLIC_TARGET_EIID_SHIFT)
+
+#define APLIC_IDC_BASE			0x4000
+#define APLIC_IDC_SIZE			32
+
+#define APLIC_IDC_IDELIVERY		0x00
+
+#define APLIC_IDC_IFORCE		0x04
+
+#define APLIC_IDC_ITHRESHOLD		0x08
+
+#define APLIC_IDC_TOPI			0x18
+#define APLIC_IDC_TOPI_ID_SHIFT		16
+#define APLIC_IDC_TOPI_ID_MASK		0x3ff
+#define APLIC_IDC_TOPI_ID		(APLIC_IDC_TOPI_ID_MASK << \
+					 APLIC_IDC_TOPI_ID_SHIFT)
+#define APLIC_IDC_TOPI_PRIO_SHIFT	0
+#define APLIC_IDC_TOPI_PRIO_MASK	0xff
+#define APLIC_IDC_TOPI_PRIO		(APLIC_IDC_TOPI_PRIO_MASK << \
+					 APLIC_IDC_TOPI_PRIO_SHIFT)
+
+#define APLIC_IDC_CLAIMI		0x1c
+
+#endif
diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/risc=
v-imsic.h
new file mode 100644
index 000000000000..faf0b800b1b0
--- /dev/null
+++ b/include/linux/irqchip/riscv-imsic.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+#ifndef __LINUX_IRQCHIP_RISCV_IMSIC_H
+#define __LINUX_IRQCHIP_RISCV_IMSIC_H
+
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <asm/csr.h>
+
+#define IMSIC_MMIO_PAGE_SHIFT		12
+#define IMSIC_MMIO_PAGE_SZ		BIT(IMSIC_MMIO_PAGE_SHIFT)
+#define IMSIC_MMIO_PAGE_LE		0x00
+#define IMSIC_MMIO_PAGE_BE		0x04
+
+#define IMSIC_MIN_ID			63
+#define IMSIC_MAX_ID			2048
+
+#define IMSIC_EIDELIVERY		0x70
+
+#define IMSIC_EITHRESHOLD		0x72
+
+#define IMSIC_EIP0			0x80
+#define IMSIC_EIP63			0xbf
+#define IMSIC_EIPx_BITS			32
+
+#define IMSIC_EIE0			0xc0
+#define IMSIC_EIE63			0xff
+#define IMSIC_EIEx_BITS			32
+
+#define IMSIC_FIRST			IMSIC_EIDELIVERY
+#define IMSIC_LAST			IMSIC_EIE63
+
+#define IMSIC_MMIO_SETIPNUM_LE		0x00
+#define IMSIC_MMIO_SETIPNUM_BE		0x04
+
+struct imsic_local_config {
+	phys_addr_t				msi_pa;
+	void __iomem				*msi_va;
+};
+
+struct imsic_global_config {
+	/*
+	 * MSI Target Address Scheme
+	 *
+	 * XLEN-1                                                12     0
+	 * |                                                     |     |
+	 * -------------------------------------------------------------
+	 * |xxxxxx|Group Index|xxxxxxxxxxx|HART Index|Guest Index|  0  |
+	 * -------------------------------------------------------------
+	 */
+
+	/* Bits representing Guest index, HART index, and Group index */
+	u32					guest_index_bits;
+	u32					hart_index_bits;
+	u32					group_index_bits;
+	u32					group_index_shift;
+
+	/* Global base address matching all target MSI addresses */
+	phys_addr_t				base_addr;
+
+	/* Number of interrupt identities */
+	u32					nr_ids;
+
+	/* Number of guest interrupt identities */
+	u32					nr_guest_ids;
+
+	/* Per-CPU IMSIC addresses */
+	struct imsic_local_config __percpu	*local;
+};
+
+#ifdef CONFIG_RISCV_IMSIC
+
+const struct imsic_global_config *imsic_get_global_config(void);
+
+#else
+
+static inline const struct imsic_global_config *imsic_get_global_config(void)
+{
+	return NULL;
+}
+
+#endif
+
+#endif
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index d9451d456a73..fd091c35d572 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -17,6 +17,18 @@ struct irq_desc;
 struct irq_domain;
 struct pt_regs;
=20
+/**
+ * struct irqstat - interrupt statistics
+ * @cnt:	real-time interrupt count
+ * @ref:	snapshot of interrupt count
+ */
+struct irqstat {
+	unsigned int	cnt;
+#ifdef CONFIG_GENERIC_IRQ_STAT_SNAPSHOT
+	unsigned int	ref;
+#endif
+};
+
 /**
  * struct irq_desc - interrupt descriptor
  * @irq_common_data:	per irq and chip data passed down to chip functions
@@ -55,7 +67,7 @@ struct pt_regs;
 struct irq_desc {
 	struct irq_common_data	irq_common_data;
 	struct irq_data		irq_data;
-	unsigned int __percpu	*kstat_irqs;
+	struct irqstat __percpu	*kstat_irqs;
 	irq_flow_handler_t	handle_irq;
 	struct irqaction	*action;	/* IRQ action list */
 	unsigned int		status_use_accessors;
@@ -119,7 +131,7 @@ extern struct irq_desc irq_desc[NR_IRQS];
 static inline unsigned int irq_desc_kstat_cpu(struct irq_desc *desc,
 					      unsigned int cpu)
 {
-	return desc->kstat_irqs ? *per_cpu_ptr(desc->kstat_irqs, cpu) : 0;
+	return desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, cpu) : 0;
 }
=20
 static inline struct irq_desc *irq_data_to_desc(struct irq_data *data)
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 9935f7ecbfb9..9c042c6384bb 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -79,6 +79,14 @@ static inline unsigned int kstat_cpu_softirqs_sum(int cpu)
 	return sum;
 }
=20
+#ifdef CONFIG_GENERIC_IRQ_STAT_SNAPSHOT
+extern void kstat_snapshot_irqs(void);
+extern unsigned int kstat_get_irq_since_snapshot(unsigned int irq);
+#else
+static inline void kstat_snapshot_irqs(void) { }
+static inline unsigned int kstat_get_irq_since_snapshot(unsigned int irq) { =
return 0; }
+#endif
+
 /*
  * Number of interrupts per specific IRQ source, since bootup
  */
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 2531f3496ab6..529adb1f5859 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -108,6 +108,10 @@ config GENERIC_IRQ_MATRIX_ALLOCATOR
 config GENERIC_IRQ_RESERVATION_MODE
 	bool
=20
+# Snapshot for interrupt statistics
+config GENERIC_IRQ_STAT_SNAPSHOT
+	bool
+
 # Support forced irq threading
 config IRQ_FORCED_THREADING
        bool
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 1ed2b1739363..75cadbc3c232 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -130,6 +130,22 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	 * CPU.
 	 */
 	err =3D irq_do_set_affinity(d, affinity, false);
+
+	/*
+	 * If there are online CPUs in the affinity mask, but they have no
+	 * vectors left to make the migration work, try to break the
+	 * affinity by migrating to any online CPU.
+	 */
+	if (err =3D=3D -ENOSPC && !irqd_affinity_is_managed(d) && affinity !=3D cpu=
_online_mask) {
+		pr_debug("IRQ%u: set affinity failed for %*pbl, re-try with online CPUs\n",
+			 d->irq, cpumask_pr_args(affinity));
+
+		affinity =3D cpu_online_mask;
+		brokeaff =3D true;
+
+		err =3D irq_do_set_affinity(d, affinity, false);
+	}
+
 	if (err) {
 		pr_warn_ratelimited("IRQ%u: set affinity failed(%d).\n",
 				    d->irq, err);
@@ -195,10 +211,15 @@ static void irq_restore_affinity_of_irq(struct irq_desc=
 *desc, unsigned int cpu)
 	    !irq_data_get_irq_chip(data) || !cpumask_test_cpu(cpu, affinity))
 		return;
=20
-	if (irqd_is_managed_and_shutdown(data)) {
-		irq_startup(desc, IRQ_RESEND, IRQ_START_COND);
+	/*
+	 * Don't restore suspended interrupts here when a system comes back
+	 * from S3. They are reenabled via resume_device_irqs().
+	 */
+	if (desc->istate & IRQS_SUSPENDED)
 		return;
-	}
+
+	if (irqd_is_managed_and_shutdown(data))
+		irq_startup(desc, IRQ_RESEND, IRQ_START_COND);
=20
 	/*
 	 * If the interrupt can only be directed to a single target
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index bcc7f21db9ee..ed28059e9849 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -98,6 +98,8 @@ extern void mask_irq(struct irq_desc *desc);
 extern void unmask_irq(struct irq_desc *desc);
 extern void unmask_threaded_irq(struct irq_desc *desc);
=20
+extern unsigned int kstat_irqs_desc(struct irq_desc *desc, const struct cpum=
ask *cpumask);
+
 #ifdef CONFIG_SPARSE_IRQ
 static inline void irq_mark_irq(unsigned int irq) { }
 #else
@@ -258,7 +260,7 @@ static inline void irq_state_set_masked(struct irq_desc *=
desc)
=20
 static inline void __kstat_incr_irqs_this_cpu(struct irq_desc *desc)
 {
-	__this_cpu_inc(*desc->kstat_irqs);
+	__this_cpu_inc(desc->kstat_irqs->cnt);
 	__this_cpu_inc(kstat.irqs_sum);
 }
=20
@@ -278,6 +280,11 @@ static inline int irq_desc_is_chained(struct irq_desc *d=
esc)
 	return (desc->action && desc->action =3D=3D &chained_action);
 }
=20
+static inline bool irq_is_nmi(struct irq_desc *desc)
+{
+	return desc->istate & IRQS_NMI;
+}
+
 #ifdef CONFIG_PM_SLEEP
 bool irq_pm_check_wakeup(struct irq_desc *desc);
 void irq_pm_install_action(struct irq_desc *desc, struct irqaction *action);
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 4c6b32318ce3..88ac3652fcf2 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -134,7 +134,7 @@ static void desc_set_defaults(unsigned int irq, struct ir=
q_desc *desc, int node,
 	desc->name =3D NULL;
 	desc->owner =3D owner;
 	for_each_possible_cpu(cpu)
-		*per_cpu_ptr(desc->kstat_irqs, cpu) =3D 0;
+		*per_cpu_ptr(desc->kstat_irqs, cpu) =3D (struct irqstat) { };
 	desc_smp_init(desc, node, affinity);
 }
=20
@@ -186,7 +186,7 @@ static int init_desc(struct irq_desc *desc, int irq, int =
node,
 		     const struct cpumask *affinity,
 		     struct module *owner)
 {
-	desc->kstat_irqs =3D alloc_percpu(unsigned int);
+	desc->kstat_irqs =3D alloc_percpu(struct irqstat);
 	if (!desc->kstat_irqs)
 		return -ENOMEM;
=20
@@ -911,10 +911,7 @@ int irq_set_percpu_devid_partition(unsigned int irq,
 {
 	struct irq_desc *desc =3D irq_to_desc(irq);
=20
-	if (!desc)
-		return -EINVAL;
-
-	if (desc->percpu_enabled)
+	if (!desc || desc->percpu_enabled)
 		return -EINVAL;
=20
 	desc->percpu_enabled =3D kzalloc(sizeof(*desc->percpu_enabled), GFP_KERNEL);
@@ -922,10 +919,7 @@ int irq_set_percpu_devid_partition(unsigned int irq,
 	if (!desc->percpu_enabled)
 		return -ENOMEM;
=20
-	if (affinity)
-		desc->percpu_affinity =3D affinity;
-	else
-		desc->percpu_affinity =3D cpu_possible_mask;
+	desc->percpu_affinity =3D affinity ? : cpu_possible_mask;
=20
 	irq_set_percpu_devid_flags(irq);
 	return 0;
@@ -968,33 +962,58 @@ unsigned int kstat_irqs_cpu(unsigned int irq, int cpu)
 {
 	struct irq_desc *desc =3D irq_to_desc(irq);
=20
-	return desc && desc->kstat_irqs ?
-			*per_cpu_ptr(desc->kstat_irqs, cpu) : 0;
+	return desc && desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, cpu) : 0;
 }
=20
-static bool irq_is_nmi(struct irq_desc *desc)
+unsigned int kstat_irqs_desc(struct irq_desc *desc, const struct cpumask *cp=
umask)
 {
-	return desc->istate & IRQS_NMI;
-}
-
-static unsigned int kstat_irqs(unsigned int irq)
-{
-	struct irq_desc *desc =3D irq_to_desc(irq);
 	unsigned int sum =3D 0;
 	int cpu;
=20
-	if (!desc || !desc->kstat_irqs)
-		return 0;
 	if (!irq_settings_is_per_cpu_devid(desc) &&
 	    !irq_settings_is_per_cpu(desc) &&
 	    !irq_is_nmi(desc))
 		return data_race(desc->tot_count);
=20
-	for_each_possible_cpu(cpu)
-		sum +=3D data_race(*per_cpu_ptr(desc->kstat_irqs, cpu));
+	for_each_cpu(cpu, cpumask)
+		sum +=3D data_race(per_cpu(desc->kstat_irqs->cnt, cpu));
 	return sum;
 }
=20
+static unsigned int kstat_irqs(unsigned int irq)
+{
+	struct irq_desc *desc =3D irq_to_desc(irq);
+
+	if (!desc || !desc->kstat_irqs)
+		return 0;
+	return kstat_irqs_desc(desc, cpu_possible_mask);
+}
+
+#ifdef CONFIG_GENERIC_IRQ_STAT_SNAPSHOT
+
+void kstat_snapshot_irqs(void)
+{
+	struct irq_desc *desc;
+	unsigned int irq;
+
+	for_each_irq_desc(irq, desc) {
+		if (!desc->kstat_irqs)
+			continue;
+		this_cpu_write(desc->kstat_irqs->ref, this_cpu_read(desc->kstat_irqs->cnt)=
);
+	}
+}
+
+unsigned int kstat_get_irq_since_snapshot(unsigned int irq)
+{
+	struct irq_desc *desc =3D irq_to_desc(irq);
+
+	if (!desc || !desc->kstat_irqs)
+		return 0;
+	return this_cpu_read(desc->kstat_irqs->cnt) - this_cpu_read(desc->kstat_irq=
s->ref);
+}
+
+#endif
+
 /**
  * kstat_irqs_usr - Get the statistics for an interrupt from thread context
  * @irq:	The interrupt number
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 3dd1c871e091..aadc8891cc16 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -909,10 +909,11 @@ EXPORT_SYMBOL_GPL(irq_create_of_mapping);
  */
 void irq_dispose_mapping(unsigned int virq)
 {
-	struct irq_data *irq_data =3D irq_get_irq_data(virq);
+	struct irq_data *irq_data;
 	struct irq_domain *domain;
=20
-	if (!virq || !irq_data)
+	irq_data =3D virq ? irq_get_irq_data(virq) : NULL;
+	if (!irq_data)
 		return;
=20
 	domain =3D irq_data->domain;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ad3eaf2ab959..61bdb45de3e0 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -564,7 +564,7 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_af=
finity_notify *notify)
 	/* The release function is promised process context */
 	might_sleep();
=20
-	if (!desc || desc->istate & IRQS_NMI)
+	if (!desc || irq_is_nmi(desc))
 		return -EINVAL;
=20
 	/* Complete initialisation of *notify */
@@ -800,10 +800,14 @@ void __enable_irq(struct irq_desc *desc)
 		irq_settings_set_noprobe(desc);
 		/*
 		 * Call irq_startup() not irq_enable() here because the
-		 * interrupt might be marked NOAUTOEN. So irq_startup()
-		 * needs to be invoked when it gets enabled the first
-		 * time. If it was already started up, then irq_startup()
-		 * will invoke irq_enable() under the hood.
+		 * interrupt might be marked NOAUTOEN so irq_startup()
+		 * needs to be invoked when it gets enabled the first time.
+		 * This is also required when __enable_irq() is invoked for
+		 * a managed and shutdown interrupt from the S3 resume
+		 * path.
+		 *
+		 * If it was already started up, then irq_startup() will
+		 * invoke irq_enable() under the hood.
 		 */
 		irq_startup(desc, IRQ_RESEND, IRQ_START_FORCE);
 		break;
@@ -898,7 +902,7 @@ int irq_set_irq_wake(unsigned int irq, unsigned int on)
 		return -EINVAL;
=20
 	/* Don't use NMIs as wake up interrupts please */
-	if (desc->istate & IRQS_NMI) {
+	if (irq_is_nmi(desc)) {
 		ret =3D -EINVAL;
 		goto out_unlock;
 	}
@@ -1624,7 +1628,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, st=
ruct irqaction *new)
 		 */
 		unsigned int oldtype;
=20
-		if (desc->istate & IRQS_NMI) {
+		if (irq_is_nmi(desc)) {
 			pr_err("Invalid attempt to share NMI for %s (irq %d) on irqchip %s.\n",
 				new->name, irq, desc->irq_data.chip->name);
 			ret =3D -EINVAL;
@@ -2077,7 +2081,7 @@ const void *free_nmi(unsigned int irq, void *dev_id)
 	unsigned long flags;
 	const void *devname;
=20
-	if (!desc || WARN_ON(!(desc->istate & IRQS_NMI)))
+	if (!desc || WARN_ON(!irq_is_nmi(desc)))
 		return NULL;
=20
 	if (WARN_ON(irq_settings_is_per_cpu_devid(desc)))
@@ -2543,7 +2547,7 @@ void free_percpu_nmi(unsigned int irq, void __percpu *d=
ev_id)
 	if (!desc || !irq_settings_is_per_cpu_devid(desc))
 		return;
=20
-	if (WARN_ON(!(desc->istate & IRQS_NMI)))
+	if (WARN_ON(!irq_is_nmi(desc)))
 		return;
=20
 	kfree(__free_percpu_irq(irq, dev_id));
@@ -2679,7 +2683,7 @@ int request_percpu_nmi(unsigned int irq, irq_handler_t =
handler,
 		return -EINVAL;
=20
 	/* The line cannot already be NMI */
-	if (desc->istate & IRQS_NMI)
+	if (irq_is_nmi(desc))
 		return -EINVAL;
=20
 	action =3D kzalloc(sizeof(struct irqaction), GFP_KERNEL);
@@ -2740,7 +2744,7 @@ int prepare_percpu_nmi(unsigned int irq)
 	if (!desc)
 		return -EINVAL;
=20
-	if (WARN(!(desc->istate & IRQS_NMI),
+	if (WARN(!irq_is_nmi(desc),
 		 KERN_ERR "prepare_percpu_nmi called for a non-NMI interrupt: irq %u\n",
 		 irq)) {
 		ret =3D -EINVAL;
@@ -2782,7 +2786,7 @@ void teardown_percpu_nmi(unsigned int irq)
 	if (!desc)
 		return;
=20
-	if (WARN_ON(!(desc->istate & IRQS_NMI)))
+	if (WARN_ON(!irq_is_nmi(desc)))
 		goto out;
=20
 	irq_nmi_teardown(desc);
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 623b8136e9af..5c320c3f10a7 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -488,18 +488,15 @@ int show_interrupts(struct seq_file *p, void *v)
 	if (!desc || irq_settings_is_hidden(desc))
 		goto outsparse;
=20
-	if (desc->kstat_irqs) {
-		for_each_online_cpu(j)
-			any_count |=3D data_race(*per_cpu_ptr(desc->kstat_irqs, j));
-	}
+	if (desc->kstat_irqs)
+		any_count =3D kstat_irqs_desc(desc, cpu_online_mask);
=20
 	if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)
 		goto outsparse;
=20
 	seq_printf(p, "%*d: ", prec, i);
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", desc->kstat_irqs ?
-					*per_cpu_ptr(desc->kstat_irqs, j) : 0);
+		seq_printf(p, "%10u ", desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, j=
) : 0);
=20
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	if (desc->irq_data.chip) {
diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 5f2c66860ac6..b07a2d732ffb 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -190,7 +190,7 @@ int irq_inject_interrupt(unsigned int irq)
 	 *  - not NMI type
 	 *  - activated
 	 */
-	if ((desc->istate & IRQS_NMI) || !irqd_is_activated(&desc->irq_data))
+	if (irq_is_nmi(desc) || !irqd_is_activated(&desc->irq_data))
 		err =3D -EINVAL;
 	else
 		err =3D check_irq_resend(desc, true);
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index d7b2125503af..d12ff74889ed 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -12,20 +12,25 @@
=20
 #define pr_fmt(fmt) "watchdog: " fmt
=20
-#include <linux/mm.h>
 #include <linux/cpu.h>
-#include <linux/nmi.h>
 #include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/kernel_stat.h>
+#include <linux/kvm_para.h>
+#include <linux/math64.h>
+#include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/nmi.h>
+#include <linux/stop_machine.h>
 #include <linux/sysctl.h>
 #include <linux/tick.h>
+
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/isolation.h>
-#include <linux/stop_machine.h>
=20
 #include <asm/irq_regs.h>
-#include <linux/kvm_para.h>
=20
 static DEFINE_MUTEX(watchdog_mutex);
=20
@@ -35,6 +40,8 @@ static DEFINE_MUTEX(watchdog_mutex);
 # define WATCHDOG_HARDLOCKUP_DEFAULT	0
 #endif
=20
+#define NUM_SAMPLE_PERIODS	5
+
 unsigned long __read_mostly watchdog_enabled;
 int __read_mostly watchdog_user_enabled =3D 1;
 static int __read_mostly watchdog_hardlockup_user_enabled =3D WATCHDOG_HARDL=
OCKUP_DEFAULT;
@@ -333,6 +340,188 @@ __setup("watchdog_thresh=3D", watchdog_thresh_setup);
=20
 static void __lockup_detector_cleanup(void);
=20
+#ifdef CONFIG_SOFTLOCKUP_DETECTOR_INTR_STORM
+enum stats_per_group {
+	STATS_SYSTEM,
+	STATS_SOFTIRQ,
+	STATS_HARDIRQ,
+	STATS_IDLE,
+	NUM_STATS_PER_GROUP,
+};
+
+static const enum cpu_usage_stat tracked_stats[NUM_STATS_PER_GROUP] =3D {
+	CPUTIME_SYSTEM,
+	CPUTIME_SOFTIRQ,
+	CPUTIME_IRQ,
+	CPUTIME_IDLE,
+};
+
+static DEFINE_PER_CPU(u16, cpustat_old[NUM_STATS_PER_GROUP]);
+static DEFINE_PER_CPU(u8, cpustat_util[NUM_SAMPLE_PERIODS][NUM_STATS_PER_GRO=
UP]);
+static DEFINE_PER_CPU(u8, cpustat_tail);
+
+/*
+ * We don't need nanosecond resolution. A granularity of 16ms is
+ * sufficient for our precision, allowing us to use u16 to store
+ * cpustats, which will roll over roughly every ~1000 seconds.
+ * 2^24 ~=3D 16 * 10^6
+ */
+static u16 get_16bit_precision(u64 data_ns)
+{
+	return data_ns >> 24LL; /* 2^24ns ~=3D 16.8ms */
+}
+
+static void update_cpustat(void)
+{
+	int i;
+	u8 util;
+	u16 old_stat, new_stat;
+	struct kernel_cpustat kcpustat;
+	u64 *cpustat =3D kcpustat.cpustat;
+	u8 tail =3D __this_cpu_read(cpustat_tail);
+	u16 sample_period_16 =3D get_16bit_precision(sample_period);
+
+	kcpustat_cpu_fetch(&kcpustat, smp_processor_id());
+
+	for (i =3D 0; i < NUM_STATS_PER_GROUP; i++) {
+		old_stat =3D __this_cpu_read(cpustat_old[i]);
+		new_stat =3D get_16bit_precision(cpustat[tracked_stats[i]]);
+		util =3D DIV_ROUND_UP(100 * (new_stat - old_stat), sample_period_16);
+		__this_cpu_write(cpustat_util[tail][i], util);
+		__this_cpu_write(cpustat_old[i], new_stat);
+	}
+
+	__this_cpu_write(cpustat_tail, (tail + 1) % NUM_SAMPLE_PERIODS);
+}
+
+static void print_cpustat(void)
+{
+	int i, group;
+	u8 tail =3D __this_cpu_read(cpustat_tail);
+	u64 sample_period_second =3D sample_period;
+
+	do_div(sample_period_second, NSEC_PER_SEC);
+
+	/*
+	 * Outputting the "watchdog" prefix on every line is redundant and not
+	 * concise, and the original alarm information is sufficient for
+	 * positioning in logs, hence here printk() is used instead of pr_crit().
+	 */
+	printk(KERN_CRIT "CPU#%d Utilization every %llus during lockup:\n",
+	       smp_processor_id(), sample_period_second);
+
+	for (i =3D 0; i < NUM_SAMPLE_PERIODS; i++) {
+		group =3D (tail + i) % NUM_SAMPLE_PERIODS;
+		printk(KERN_CRIT "\t#%d: %3u%% system,\t%3u%% softirq,\t"
+			"%3u%% hardirq,\t%3u%% idle\n", i + 1,
+			__this_cpu_read(cpustat_util[group][STATS_SYSTEM]),
+			__this_cpu_read(cpustat_util[group][STATS_SOFTIRQ]),
+			__this_cpu_read(cpustat_util[group][STATS_HARDIRQ]),
+			__this_cpu_read(cpustat_util[group][STATS_IDLE]));
+	}
+}
+
+#define HARDIRQ_PERCENT_THRESH          50
+#define NUM_HARDIRQ_REPORT              5
+struct irq_counts {
+	int irq;
+	u32 counts;
+};
+
+static DEFINE_PER_CPU(bool, snapshot_taken);
+
+/* Tabulate the most frequent interrupts. */
+static void tabulate_irq_count(struct irq_counts *irq_counts, int irq, u32 c=
ounts, int rank)
+{
+	int i;
+	struct irq_counts new_count =3D {irq, counts};
+
+	for (i =3D 0; i < rank; i++) {
+		if (counts > irq_counts[i].counts)
+			swap(new_count, irq_counts[i]);
+	}
+}
+
+/*
+ * If the hardirq time exceeds HARDIRQ_PERCENT_THRESH% of the sample_period,
+ * then the cause of softlockup might be interrupt storm. In this case, it
+ * would be useful to start interrupt counting.
+ */
+static bool need_counting_irqs(void)
+{
+	u8 util;
+	int tail =3D __this_cpu_read(cpustat_tail);
+
+	tail =3D (tail + NUM_HARDIRQ_REPORT - 1) % NUM_HARDIRQ_REPORT;
+	util =3D __this_cpu_read(cpustat_util[tail][STATS_HARDIRQ]);
+	return util > HARDIRQ_PERCENT_THRESH;
+}
+
+static void start_counting_irqs(void)
+{
+	if (!__this_cpu_read(snapshot_taken)) {
+		kstat_snapshot_irqs();
+		__this_cpu_write(snapshot_taken, true);
+	}
+}
+
+static void stop_counting_irqs(void)
+{
+	__this_cpu_write(snapshot_taken, false);
+}
+
+static void print_irq_counts(void)
+{
+	unsigned int i, count;
+	struct irq_counts irq_counts_sorted[NUM_HARDIRQ_REPORT] =3D {
+		{-1, 0}, {-1, 0}, {-1, 0}, {-1, 0}, {-1, 0}
+	};
+
+	if (__this_cpu_read(snapshot_taken)) {
+		for_each_active_irq(i) {
+			count =3D kstat_get_irq_since_snapshot(i);
+			tabulate_irq_count(irq_counts_sorted, i, count, NUM_HARDIRQ_REPORT);
+		}
+
+		/*
+		 * Outputting the "watchdog" prefix on every line is redundant and not
+		 * concise, and the original alarm information is sufficient for
+		 * positioning in logs, hence here printk() is used instead of pr_crit().
+		 */
+		printk(KERN_CRIT "CPU#%d Detect HardIRQ Time exceeds %d%%. Most frequent H=
ardIRQs:\n",
+		       smp_processor_id(), HARDIRQ_PERCENT_THRESH);
+
+		for (i =3D 0; i < NUM_HARDIRQ_REPORT; i++) {
+			if (irq_counts_sorted[i].irq =3D=3D -1)
+				break;
+
+			printk(KERN_CRIT "\t#%u: %-10u\tirq#%d\n",
+			       i + 1, irq_counts_sorted[i].counts,
+			       irq_counts_sorted[i].irq);
+		}
+
+		/*
+		 * If the hardirq time is less than HARDIRQ_PERCENT_THRESH% in the last
+		 * sample_period, then we suspect the interrupt storm might be subsiding.
+		 */
+		if (!need_counting_irqs())
+			stop_counting_irqs();
+	}
+}
+
+static void report_cpu_status(void)
+{
+	print_cpustat();
+	print_irq_counts();
+}
+#else
+static inline void update_cpustat(void) { }
+static inline void report_cpu_status(void) { }
+static inline bool need_counting_irqs(void) { return false; }
+static inline void start_counting_irqs(void) { }
+static inline void stop_counting_irqs(void) { }
+#endif
+
 /*
  * Hard-lockup warnings should be triggered after just a few seconds. Soft-
  * lockups can have false positives under extreme conditions. So we generally
@@ -364,7 +553,7 @@ static void set_sample_period(void)
 	 * and hard thresholds) to increment before the
 	 * hardlockup detector generates a warning
 	 */
-	sample_period =3D get_softlockup_thresh() * ((u64)NSEC_PER_SEC / 5);
+	sample_period =3D get_softlockup_thresh() * ((u64)NSEC_PER_SEC / NUM_SAMPLE=
_PERIODS);
 	watchdog_update_hrtimer_threshold(sample_period);
 }
=20
@@ -434,6 +623,18 @@ static int is_softlockup(unsigned long touch_ts,
 			 unsigned long now)
 {
 	if ((watchdog_enabled & WATCHDOG_SOFTOCKUP_ENABLED) && watchdog_thresh) {
+		/*
+		 * If period_ts has not been updated during a sample_period, then
+		 * in the subsequent few sample_periods, period_ts might also not
+		 * be updated, which could indicate a potential softlockup. In
+		 * this case, if we suspect the cause of the potential softlockup
+		 * might be interrupt storm, then we need to count the interrupts
+		 * to find which interrupt is storming.
+		 */
+		if (time_after_eq(now, period_ts + get_softlockup_thresh() / NUM_SAMPLE_PE=
RIODS) &&
+		    need_counting_irqs())
+			start_counting_irqs();
+
 		/* Warn about unreasonable delays. */
 		if (time_after(now, period_ts + get_softlockup_thresh()))
 			return now - touch_ts;
@@ -456,6 +657,7 @@ static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_st=
op_work);
 static int softlockup_fn(void *data)
 {
 	update_touch_ts();
+	stop_counting_irqs();
 	complete(this_cpu_ptr(&softlockup_completion));
=20
 	return 0;
@@ -504,6 +706,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrti=
mer *hrtimer)
 	 */
 	period_ts =3D READ_ONCE(*this_cpu_ptr(&watchdog_report_ts));
=20
+	update_cpustat();
+
 	/* Reset the interval when touched by known problematic code. */
 	if (period_ts =3D=3D SOFTLOCKUP_DELAY_REPORT) {
 		if (unlikely(__this_cpu_read(softlockup_touch_sync))) {
@@ -539,6 +743,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrti=
mer *hrtimer)
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
 			smp_processor_id(), duration,
 			current->comm, task_pid_nr(current));
+		report_cpu_status();
 		print_modules();
 		print_irqtrace_events(current);
 		if (regs)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c63a5fbf1f1c..1f0ce712a671 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1029,6 +1029,20 @@ config SOFTLOCKUP_DETECTOR
 	  chance to run.  The current stack trace is displayed upon
 	  detection and the system will stay locked up.
=20
+config SOFTLOCKUP_DETECTOR_INTR_STORM
+	bool "Detect Interrupt Storm in Soft Lockups"
+	depends on SOFTLOCKUP_DETECTOR && IRQ_TIME_ACCOUNTING
+	select GENERIC_IRQ_STAT_SNAPSHOT
+	default y if NR_CPUS <=3D 128
+	help
+	  Say Y here to enable the kernel to detect interrupt storm
+	  during "soft lockups".
+
+	  "soft lockups" can be caused by a variety of reasons. If one is
+	  caused by an interrupt storm, then the storming interrupts will not
+	  be on the callstack. To detect this case, it is necessary to report
+	  the CPU stats and the interrupt counts during the "soft lockups".
+
 config BOOTPARAM_SOFTLOCKUP_PANIC
 	bool "Panic (Reboot) On Soft Lockups"
 	depends on SOFTLOCKUP_DETECTOR
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 32f99e9a670e..dacadd904250 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -116,6 +116,18 @@ unsigned long _find_first_and_bit(const unsigned long *a=
ddr1,
 EXPORT_SYMBOL(_find_first_and_bit);
 #endif
=20
+/*
+ * Find the first set bit in three memory regions.
+ */
+unsigned long _find_first_and_and_bit(const unsigned long *addr1,
+				      const unsigned long *addr2,
+				      const unsigned long *addr3,
+				      unsigned long size)
+{
+	return FIND_FIRST_BIT(addr1[idx] & addr2[idx] & addr3[idx], /* nop */, size=
);
+}
+EXPORT_SYMBOL(_find_first_and_and_bit);
+
 #ifndef find_first_zero_bit
 /*
  * Find the first cleared bit in a memory region.
diff --git a/scripts/gdb/linux/interrupts.py b/scripts/gdb/linux/interrupts.py
index 66ae5c7690cf..616a5f26377a 100644
--- a/scripts/gdb/linux/interrupts.py
+++ b/scripts/gdb/linux/interrupts.py
@@ -37,7 +37,7 @@ def show_irq_desc(prec, irq):
     any_count =3D 0
     if desc['kstat_irqs']:
         for cpu in cpus.each_online_cpu():
-            any_count +=3D cpus.per_cpu(desc['kstat_irqs'], cpu)
+            any_count +=3D cpus.per_cpu(desc['kstat_irqs'], cpu)['cnt']
=20
     if (desc['action'] =3D=3D 0 or irq_desc_is_chained(desc)) and any_count =
=3D=3D 0:
         return text;
@@ -45,7 +45,7 @@ def show_irq_desc(prec, irq):
     text +=3D "%*d: " % (prec, irq)
     for cpu in cpus.each_online_cpu():
         if desc['kstat_irqs']:
-            count =3D cpus.per_cpu(desc['kstat_irqs'], cpu)
+            count =3D cpus.per_cpu(desc['kstat_irqs'], cpu)['cnt']
         else:
             count =3D 0
         text +=3D "%10u" % (count)
@@ -177,7 +177,7 @@ def arm_common_show_interrupts(prec):
         if desc =3D=3D 0:
             continue
         for cpu in cpus.each_online_cpu():
-            text +=3D "%10u" % (cpus.per_cpu(desc['kstat_irqs'], cpu))
+            text +=3D "%10u" % (cpus.per_cpu(desc['kstat_irqs'], cpu)['cnt'])
         text +=3D "      %s" % (ipi_types[ipi].string())
         text +=3D "\n"
     return text


