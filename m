Return-Path: <linux-kernel+bounces-413416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A01899D18C8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAEF5B2285C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6681817597;
	Mon, 18 Nov 2024 19:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kyTn9J6Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="owowUTsr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834261E0DF0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731957726; cv=none; b=OPeHdbniFAuOF8PkGwbHG/JIAaZGVU7ZMojnhBaA94djS6qkvbE9BpsLLp7Vg5qpK9WKIaQctMRm2R42ahaCztarUC70Uw2Yu4+Zibw0V9gaa4ZQ+y6WbCkUbyTV3ci2SGPNUicbj4JJuG/FFq3i4O0JeYWBv34JsexN9xn9XJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731957726; c=relaxed/simple;
	bh=Lr9NLDGwFamdgDZBlPATM7/vzl8FCCpt11i+ZMoKfGw=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=Vva/qeQY+uD2OEnA0VrlYNHlzECZiwTS42AwjQ7nC5QXTKQCXPCcMUOfcJwRDEzdpOAaITWHNgCQi/d5ajwMQCTfw4nvOphRa4KfZwwO06EAn8A0xscSjEomNWtLQUhaTsYI9hij8t/fTTtvYEZY7m4fQbt6YEWFaTNkntnoK+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kyTn9J6Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=owowUTsr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731957718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=sR5SjLP0CC/y98iA5yE/lfeMkaG3hVrt+DlGp+GL/6E=;
	b=kyTn9J6Y/COrickLq4ytvVdHvG1E95T+GB3OtqHuW3rR6rCKJB76vGWVoIYoHta3FKKMQC
	T8FC34/jPmXkx+uKg6zYUzqUpTW1zftaWRhLSCpLDwO3j1KBugdhJKGqI1UctcCeNpagGv
	TPaeO6Ko5XNIOorOXVism8xa9wQSZaCyYo7HTcyPB1ccHPxbvDLAv/nPgzgMYVOfJNrZ37
	lBwyM7hR4t99NxEQjWgwmpsLmVX4kXMMHO4aA6O1uyZ3uxH1QFkGiv1XJnjliaiRbOK1NO
	nIQozxVeip638zJnbw98D0O7dCkxbuow/F6mjm/NR7mUcX4R5C3N5nrSSCsTSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731957718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=sR5SjLP0CC/y98iA5yE/lfeMkaG3hVrt+DlGp+GL/6E=;
	b=owowUTsr+Xa1FapbNn51+XQGf13MEXKF7QzC0DzkPKM6g3AT+A1wMMKInih549K+PbkbrQ
	YwcFs7/Q9XkLmEBQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for v6.13-rc1
References: <173195757899.1896928.6143737920583881655.tglx@xen13>
Message-ID: <173195758303.1896928.8330927472936200835.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Nov 2024 20:21:52 +0100 (CET)

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2024-11=
-18

up to:  1f181d1cda56: irqchip/riscv-aplic: Prevent crash when MSI domain is m=
issing

A set of updates for the interrupt subsystem:

  - Tree wide:

    * Make nr_irqs static to the core code and provide accessor functions
      to remove existing and prevent future aliasing problems with local
      variables or function arguments of the same name.

  - Core code:

    * Prevent freeing an interrupt in the devres code which is not managed
      by devres in the first place.

    * Use seq_put_decimal_ull_width() for decimal values output in
      /proc/interrupts which increases performance significantly as it
      avoids parsing the format strings over and over.

    * Optimize raising the timer and hrtimer soft interrupts by using the
      'set bit only' variants instead of the combined version which checks
      whether ksoftirqd should be woken up. The latter is a pointless
      exercise as both soft interrupts are raised in the context of the
      timer interrupt and therefore never wake up ksoftirqd.

    * Delegate timer/hrtimer soft interrupt processing to a dedicated thread
      on RT.

      Timer and hrtimer soft interrupts are always processed in ksoftirqd
      on RT enabled kernels. This can lead to high latencies when other
      soft interrupts are delegated to ksoftirqd as well.

      The separate thread allows to run them seperately under a RT
      scheduling policy to reduce the latency overhead.

  - Drivers:

    * New drivers or extensions of existing drivers to support Renesas
      RZ/V2H(P), Aspeed AST27XX, T-HEAD C900 and ATMEL sam9x7 interrupt
      chips

    * Support for multi-cluster GICs on MIPS.

      MIPS CPUs can come with multiple CPU clusters, where each CPU cluster
      has its own GIC (Generic Interrupt Controller). This requires to
      access the GIC of a remote cluster through a redirect register block.

      This is encapsulated into a set of helper functions to keep the
      complexity out of the actual code paths which handle the GIC details.

    * Support for encrypted guests in the ARM GICV3 ITS driver

      The ITS page needs to be shared with the hypervisor and therefore
      must be decrypted.

    * Small cleanups and fixes all over the place

Thanks,

	tglx

------------------>
Bart Van Assche (22):
      genirq: Introduce irq_get_nr_irqs() and irq_set_nr_irqs()
      ARM: Switch to irq_get_nr_irqs() / irq_set_nr_irqs()
      LoongArch: Switch to irq_set_nr_irqs()
      powerpc/cell: Switch to irq_get_nr_irqs()
      s390/irq: Switch to irq_get_nr_irqs()
      x86/acpi: Switch to irq_get_nr_irqs() and irq_set_nr_irqs()
      hpet: Switch to irq_get_nr_irqs()
      net: 3com: 3c59x: Switch to irq_get_nr_irqs()
      net: hamradio: baycom_ser_fdx: Switch to irq_get_nr_irqs()
      net: hamradio: scc: Switch to irq_get_nr_irqs()
      scsi: aha152x: Switch to irq_get_nr_irqs()
      serial: core: Switch to irq_get_nr_irqs()
      serial: 8250: Switch to irq_get_nr_irqs()
      serial: amba-pl010: Switch to irq_get_nr_irqs()
      serial: amba-pl011: Switch to irq_get_nr_irqs()
      serial: cpm_uart: Switch to irq_get_nr_irqs()
      serial: ucc_uart: Switch to irq_get_nr_irqs()
      sh: intc: Switch to irq_get_nr_irqs()
      xen/events: Switch to irq_get_nr_irqs()
      fs/procfs: Switch to irq_get_nr_irqs()
      genirq: Switch to irq_get_nr_irqs()
      genirq: Unexport nr_irqs

Chao-ying Fu (1):
      irqchip/mips-gic: Setup defaults in each cluster

David Wang (1):
      genirq/proc: Use seq_put_decimal_ull_width() for decimal values

Fabrizio Castro (3):
      dt-bindings: interrupt-controller: Add Renesas RZ/V2H(P) Interrupt Cont=
roller
      irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) driver
      arm64: dts: renesas: r9a09g057: Add ICU node

Gregory CLEMENT (1):
      irqchip/mips-gic: Prevent indirect access to clusters without CPU cores

Hari Prasath (1):
      irqchip/atmel-aic5: Add support for sam9x7 aic

Hongbo Li (1):
      irqchip/sifive-plic: Make use of __assign_bit()

Inochi Amaoto (3):
      dt-bindings: interrupt-controller: Add T-HEAD C900 ACLINT SSWI device
      irqchip: Add T-HEAD C900 ACLINT SSWI driver
      riscv: defconfig: Enable T-HEAD C900 ACLINT SSWI drivers

Kevin Chen (2):
      dt-bindings: interrupt-controller: Add support for ASPEED AST27XX INTC
      irqchip/aspeed-intc: Add AST27XX INTC support

Nathan Chancellor (1):
      irqchip/mips-gic: Fix selection of GENERIC_IRQ_EFFECTIVE_AFF_MASK

Paul Burton (3):
      irqchip/mips-gic: Replace open coded online CPU iterations
      irqchip/mips-gic: Support multi-cluster in for_each_online_cpu_gic()
      irqchip/mips-gic: Multi-cluster support

Rob Herring (Arm) (1):
      irqchip/stm32mp-exti: Use of_property_present() for non-boolean propert=
ies

Samuel Holland (1):
      irqchip/riscv-aplic: Prevent crash when MSI domain is missing

Sebastian Andrzej Siewior (3):
      hrtimer: Use __raise_softirq_irqoff() to raise the softirq
      timers: Use __raise_softirq_irqoff() to raise the softirq.
      softirq: Use a dedicated thread for timer wakeups on PREEMPT_RT.

Steven Price (3):
      irqchip/gic-v3-its: Share ITS tables with a non-trusted hypervisor
      irqchip/gic-v3-its: Rely on genpool alignment
      irqchip/gic-v3-its: Fix over allocation in itt_alloc_pool()

Thorsten Blum (1):
      genirq/irqdesc: Use str_enabled_disabled() helper in wakeup_show()

Varshini Rajendran (1):
      dt-bindings: interrupt-controller: Add support for sam9x7 aic

Zijun Hu (1):
      genirq/devres: Don't free interrupt which is not managed by devres


 .../interrupt-controller/aspeed,ast2700-intc.yaml  |  86 ++++
 .../bindings/interrupt-controller/atmel,aic.yaml   |   1 +
 .../interrupt-controller/renesas,rzv2h-icu.yaml    | 278 +++++++++++
 .../thead,c900-aclint-sswi.yaml                    |  58 +++
 arch/arm/kernel/irq.c                              |   5 +-
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi         |  90 ++++
 arch/loongarch/kernel/irq.c                        |   4 +-
 arch/powerpc/platforms/cell/axon_msi.c             |   2 +-
 arch/riscv/configs/defconfig                       |   1 +
 arch/s390/kernel/irq.c                             |   2 +-
 arch/x86/kernel/acpi/boot.c                        |   6 +-
 arch/x86/kernel/apic/vector.c                      |   8 +-
 drivers/char/hpet.c                                |   1 +
 drivers/irqchip/Kconfig                            |  20 +
 drivers/irqchip/Makefile                           |   3 +
 drivers/irqchip/irq-aspeed-intc.c                  | 139 ++++++
 drivers/irqchip/irq-atmel-aic5.c                   |   9 +
 drivers/irqchip/irq-gic-v3-its.c                   | 141 +++++-
 drivers/irqchip/irq-mips-gic.c                     | 269 +++++++++--
 drivers/irqchip/irq-renesas-rzv2h.c                | 513 +++++++++++++++++++=
++
 drivers/irqchip/irq-riscv-aplic-main.c             |   3 +-
 drivers/irqchip/irq-riscv-aplic-msi.c              |   3 +
 drivers/irqchip/irq-sifive-plic.c                  |   9 +-
 drivers/irqchip/irq-stm32mp-exti.c                 |   3 +-
 drivers/irqchip/irq-thead-c900-aclint-sswi.c       | 176 +++++++
 drivers/net/ethernet/3com/3c59x.c                  |   2 +-
 drivers/net/hamradio/baycom_ser_fdx.c              |   1 +
 drivers/net/hamradio/scc.c                         |   4 +-
 drivers/scsi/aha152x.c                             |   2 +-
 drivers/sh/intc/virq-debugfs.c                     |   1 +
 drivers/soc/renesas/Kconfig                        |   1 +
 drivers/tty/serial/8250/8250_port.c                |   2 +-
 drivers/tty/serial/amba-pl010.c                    |   2 +-
 drivers/tty/serial/amba-pl011.c                    |   2 +-
 drivers/tty/serial/cpm_uart.c                      |   2 +-
 drivers/tty/serial/serial_core.c                   |   2 +-
 drivers/tty/serial/ucc_uart.c                      |   2 +-
 drivers/xen/events/events_base.c                   |   2 +-
 fs/proc/interrupts.c                               |   4 +-
 fs/proc/stat.c                                     |   4 +-
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/interrupt.h                          |  47 ++
 include/linux/irqnr.h                              |  36 +-
 kernel/irq/devres.c                                |   3 +-
 kernel/irq/irqdesc.c                               |  30 +-
 kernel/irq/irqdomain.c                             |   2 +-
 kernel/irq/proc.c                                  |  12 +-
 kernel/rcu/rcutorture.c                            |   8 +
 kernel/softirq.c                                   |  69 ++-
 kernel/time/hrtimer.c                              |   4 +-
 kernel/time/tick-sched.c                           |   2 +-
 kernel/time/timer.c                                |   2 +-
 52 files changed, 1945 insertions(+), 134 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/as=
peed,ast2700-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/re=
nesas,rzv2h-icu.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/th=
ead,c900-aclint-sswi.yaml
 create mode 100644 drivers/irqchip/irq-aspeed-intc.c
 create mode 100644 drivers/irqchip/irq-renesas-rzv2h.c
 create mode 100644 drivers/irqchip/irq-thead-c900-aclint-sswi.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,as=
t2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspe=
ed,ast2700-intc.yaml
new file mode 100644
index 000000000000..55636d06a674
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-i=
ntc.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.=
yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed AST2700 Interrupt Controller
+
+description:
+  This interrupt controller hardware is second level interrupt controller th=
at
+  is hooked to a parent interrupt controller. It's useful to combine multiple
+  interrupt sources into 1 interrupt to parent interrupt controller.
+
+maintainers:
+  - Kevin Chen <kevin_chen@aspeedtech.com>
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2700-intc-ic
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      The first cell is the IRQ number, the second cell is the trigger
+      type as defined in interrupt.txt in this directory.
+
+  interrupts:
+    maxItems: 6
+    description: |
+      Depend to which INTC0 or INTC1 used.
+      INTC0 and INTC1 are two kinds of interrupt controller with enable and =
raw
+      status registers for use.
+      INTC0 is used to assert GIC if interrupt in INTC1 asserted.
+      INTC1 is used to assert INTC0 if interrupt of modules asserted.
+      +-----+   +-------+     +---------+---module0
+      | GIC |---| INTC0 |--+--| INTC1_0 |---module2
+      |     |   |       |  |  |         |---...
+      +-----+   +-------+  |  +---------+---module31
+                           |
+                           |   +---------+---module0
+                           +---| INTC1_1 |---module2
+                           |   |         |---...
+                           |   +---------+---module31
+                          ...
+                           |   +---------+---module0
+                           +---| INTC1_5 |---module2
+                               |         |---...
+                               +---------+---module31
+
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    bus {
+        #address-cells =3D <2>;
+        #size-cells =3D <2>;
+
+        interrupt-controller@12101b00 {
+            compatible =3D "aspeed,ast2700-intc-ic";
+            reg =3D <0 0x12101b00 0 0x10>;
+            #interrupt-cells =3D <2>;
+            interrupt-controller;
+            interrupts =3D <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic=
.yaml b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
index d4658fe3867c..d671ed884c9e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
@@ -23,6 +23,7 @@ properties:
       - atmel,sama5d3-aic
       - atmel,sama5d4-aic
       - microchip,sam9x60-aic
+      - microchip,sam9x7-aic
=20
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,r=
zv2h-icu.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesa=
s,rzv2h-icu.yaml
new file mode 100644
index 000000000000..d7ef4f1323a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzv2h-ic=
u.yaml
@@ -0,0 +1,278 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/renesas,rzv2h-icu.ya=
ml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/V2H(P) Interrupt Control Unit
+
+maintainers:
+  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+description:
+  The Interrupt Control Unit (ICU) handles external interrupts (NMI, IRQ, and
+  TINT), error interrupts, DMAC requests, GPT interrupts, and internal
+  interrupts.
+
+properties:
+  compatible:
+    const: renesas,r9a09g057-icu # RZ/V2H(P)
+
+  '#interrupt-cells':
+    description: The first cell is the SPI number of the NMI or the
+      PORT_IRQ[0-15] interrupt, as per user manual. The second cell is used =
to
+      specify the flag.
+    const: 2
+
+  '#address-cells':
+    const: 0
+
+  interrupt-controller: true
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 58
+    items:
+      - description: NMI interrupt
+      - description: PORT_IRQ0 interrupt
+      - description: PORT_IRQ1 interrupt
+      - description: PORT_IRQ2 interrupt
+      - description: PORT_IRQ3 interrupt
+      - description: PORT_IRQ4 interrupt
+      - description: PORT_IRQ5 interrupt
+      - description: PORT_IRQ6 interrupt
+      - description: PORT_IRQ7 interrupt
+      - description: PORT_IRQ8 interrupt
+      - description: PORT_IRQ9 interrupt
+      - description: PORT_IRQ10 interrupt
+      - description: PORT_IRQ11 interrupt
+      - description: PORT_IRQ12 interrupt
+      - description: PORT_IRQ13 interrupt
+      - description: PORT_IRQ14 interrupt
+      - description: PORT_IRQ15 interrupt
+      - description: GPIO interrupt, TINT0
+      - description: GPIO interrupt, TINT1
+      - description: GPIO interrupt, TINT2
+      - description: GPIO interrupt, TINT3
+      - description: GPIO interrupt, TINT4
+      - description: GPIO interrupt, TINT5
+      - description: GPIO interrupt, TINT6
+      - description: GPIO interrupt, TINT7
+      - description: GPIO interrupt, TINT8
+      - description: GPIO interrupt, TINT9
+      - description: GPIO interrupt, TINT10
+      - description: GPIO interrupt, TINT11
+      - description: GPIO interrupt, TINT12
+      - description: GPIO interrupt, TINT13
+      - description: GPIO interrupt, TINT14
+      - description: GPIO interrupt, TINT15
+      - description: GPIO interrupt, TINT16
+      - description: GPIO interrupt, TINT17
+      - description: GPIO interrupt, TINT18
+      - description: GPIO interrupt, TINT19
+      - description: GPIO interrupt, TINT20
+      - description: GPIO interrupt, TINT21
+      - description: GPIO interrupt, TINT22
+      - description: GPIO interrupt, TINT23
+      - description: GPIO interrupt, TINT24
+      - description: GPIO interrupt, TINT25
+      - description: GPIO interrupt, TINT26
+      - description: GPIO interrupt, TINT27
+      - description: GPIO interrupt, TINT28
+      - description: GPIO interrupt, TINT29
+      - description: GPIO interrupt, TINT30
+      - description: GPIO interrupt, TINT31
+      - description: Software interrupt, INTA55_0
+      - description: Software interrupt, INTA55_1
+      - description: Software interrupt, INTA55_2
+      - description: Software interrupt, INTA55_3
+      - description: Error interrupt to CA55
+      - description: GTCCRA compare match/input capture (U0)
+      - description: GTCCRB compare match/input capture (U0)
+      - description: GTCCRA compare match/input capture (U1)
+      - description: GTCCRB compare match/input capture (U1)
+
+  interrupt-names:
+    minItems: 58
+    items:
+      - const: nmi
+      - const: port_irq0
+      - const: port_irq1
+      - const: port_irq2
+      - const: port_irq3
+      - const: port_irq4
+      - const: port_irq5
+      - const: port_irq6
+      - const: port_irq7
+      - const: port_irq8
+      - const: port_irq9
+      - const: port_irq10
+      - const: port_irq11
+      - const: port_irq12
+      - const: port_irq13
+      - const: port_irq14
+      - const: port_irq15
+      - const: tint0
+      - const: tint1
+      - const: tint2
+      - const: tint3
+      - const: tint4
+      - const: tint5
+      - const: tint6
+      - const: tint7
+      - const: tint8
+      - const: tint9
+      - const: tint10
+      - const: tint11
+      - const: tint12
+      - const: tint13
+      - const: tint14
+      - const: tint15
+      - const: tint16
+      - const: tint17
+      - const: tint18
+      - const: tint19
+      - const: tint20
+      - const: tint21
+      - const: tint22
+      - const: tint23
+      - const: tint24
+      - const: tint25
+      - const: tint26
+      - const: tint27
+      - const: tint28
+      - const: tint29
+      - const: tint30
+      - const: tint31
+      - const: int-ca55-0
+      - const: int-ca55-1
+      - const: int-ca55-2
+      - const: int-ca55-3
+      - const: icu-error-ca55
+      - const: gpt-u0-gtciada
+      - const: gpt-u0-gtciadb
+      - const: gpt-u1-gtciada
+      - const: gpt-u1-gtciadb
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - '#interrupt-cells'
+  - '#address-cells'
+  - interrupt-controller
+  - interrupts
+  - interrupt-names
+  - clocks
+  - power-domains
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+    icu: interrupt-controller@10400000 {
+        compatible =3D "renesas,r9a09g057-icu";
+        reg =3D <0x10400000 0x10000>;
+        #interrupt-cells =3D <2>;
+        #address-cells =3D <0>;
+        interrupt-controller;
+        interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 433 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 437 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 441 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 442 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 443 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 262 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 263 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 265 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names =3D "nmi",
+                          "port_irq0", "port_irq1", "port_irq2",
+                          "port_irq3", "port_irq4", "port_irq5",
+                          "port_irq6", "port_irq7", "port_irq8",
+                          "port_irq9", "port_irq10", "port_irq11",
+                          "port_irq12", "port_irq13", "port_irq14",
+                          "port_irq15",
+                          "tint0", "tint1", "tint2", "tint3",
+                          "tint4", "tint5", "tint6", "tint7",
+                          "tint8", "tint9", "tint10", "tint11",
+                          "tint12", "tint13", "tint14", "tint15",
+                          "tint16", "tint17", "tint18", "tint19",
+                          "tint20", "tint21", "tint22", "tint23",
+                          "tint24", "tint25", "tint26", "tint27",
+                          "tint28", "tint29", "tint30", "tint31",
+                          "int-ca55-0", "int-ca55-1",
+                          "int-ca55-2", "int-ca55-3",
+                          "icu-error-ca55",
+                          "gpt-u0-gtciada", "gpt-u0-gtciadb",
+                          "gpt-u1-gtciada", "gpt-u1-gtciadb";
+        clocks =3D <&cpg CPG_MOD 0x5>;
+        power-domains =3D <&cpg>;
+        resets =3D <&cpg 0x36>;
+    };
diff --git a/Documentation/devicetree/bindings/interrupt-controller/thead,c90=
0-aclint-sswi.yaml b/Documentation/devicetree/bindings/interrupt-controller/t=
head,c900-aclint-sswi.yaml
new file mode 100644
index 000000000000..8d330906bbbd
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclin=
t-sswi.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/thead,c900-aclint-ss=
wi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-HEAD C900 ACLINT Supervisor-level Software Interrupt Device
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+description:
+  The SSWI device is a part of the THEAD ACLINT device. It provides
+  supervisor-level IPI functionality for a set of HARTs on a THEAD
+  platform. It provides a register to set an IPI (SETSSIP) for each
+  HART connected to the SSWI device.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - sophgo,sg2044-aclint-sswi
+      - const: thead,c900-aclint-sswi
+
+  reg:
+    maxItems: 1
+
+  "#interrupt-cells":
+    const: 0
+
+  interrupt-controller: true
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 4095
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#interrupt-cells"
+  - interrupt-controller
+  - interrupts-extended
+
+examples:
+  - |
+    interrupt-controller@94000000 {
+      compatible =3D "sophgo,sg2044-aclint-sswi", "thead,c900-aclint-sswi";
+      reg =3D <0x94000000 0x00004000>;
+      #interrupt-cells =3D <0>;
+      interrupt-controller;
+      interrupts-extended =3D <&cpu1intc 1>,
+                            <&cpu2intc 1>,
+                            <&cpu3intc 1>,
+                            <&cpu4intc 1>;
+    };
+...
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index dab42d066d06..e1993e28a9ec 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -111,7 +111,7 @@ void handle_IRQ(unsigned int irq, struct pt_regs *regs)
 	 * Some hardware gives randomly wrong interrupts.  Rather
 	 * than crashing, do something sensible.
 	 */
-	if (unlikely(!irq || irq >=3D nr_irqs))
+	if (unlikely(!irq || irq >=3D irq_get_nr_irqs()))
 		desc =3D NULL;
 	else
 		desc =3D irq_to_desc(irq);
@@ -151,7 +151,6 @@ void __init init_IRQ(void)
 #ifdef CONFIG_SPARSE_IRQ
 int __init arch_probe_nr_irqs(void)
 {
-	nr_irqs =3D machine_desc->nr_irqs ? machine_desc->nr_irqs : NR_IRQS;
-	return nr_irqs;
+	return irq_set_nr_irqs(machine_desc->nr_irqs ? : NR_IRQS);
 }
 #endif
diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/dts=
/renesas/r9a09g057.dtsi
index 1ad5a1b6917f..abcdef3ba5bc 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -90,6 +90,95 @@ soc: soc {
 		#size-cells =3D <2>;
 		ranges;
=20
+		icu: interrupt-controller@10400000 {
+			compatible =3D "renesas,r9a09g057-icu";
+			reg =3D <0 0x10400000 0 0x10000>;
+			#interrupt-cells =3D <2>;
+			#address-cells =3D <0>;
+			interrupt-controller;
+			interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 433 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 437 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 441 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 442 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 443 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 262 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 263 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 265 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "nmi",
+					  "port_irq0", "port_irq1", "port_irq2",
+					  "port_irq3", "port_irq4", "port_irq5",
+					  "port_irq6", "port_irq7", "port_irq8",
+					  "port_irq9", "port_irq10", "port_irq11",
+					  "port_irq12", "port_irq13", "port_irq14",
+					  "port_irq15",
+					  "tint0", "tint1", "tint2", "tint3",
+					  "tint4", "tint5", "tint6", "tint7",
+					  "tint8", "tint9", "tint10", "tint11",
+					  "tint12", "tint13", "tint14", "tint15",
+					  "tint16", "tint17", "tint18", "tint19",
+					  "tint20", "tint21", "tint22", "tint23",
+					  "tint24", "tint25", "tint26", "tint27",
+					  "tint28", "tint29", "tint30", "tint31",
+					  "int-ca55-0", "int-ca55-1",
+					  "int-ca55-2", "int-ca55-3",
+					  "icu-error-ca55",
+					  "gpt-u0-gtciada", "gpt-u0-gtciadb",
+					  "gpt-u1-gtciada", "gpt-u1-gtciadb";
+			clocks =3D <&cpg CPG_MOD 0x5>;
+			power-domains =3D <&cpg>;
+			resets =3D <&cpg 0x36>;
+		};
+
 		pinctrl: pinctrl@10410000 {
 			compatible =3D "renesas,r9a09g057-pinctrl";
 			reg =3D <0 0x10410000 0 0x10000>;
@@ -99,6 +188,7 @@ pinctrl: pinctrl@10410000 {
 			gpio-ranges =3D <&pinctrl 0 0 96>;
 			#interrupt-cells =3D <2>;
 			interrupt-controller;
+			interrupt-parent =3D <&icu>;
 			power-domains =3D <&cpg>;
 			resets =3D <&cpg 0xa5>, <&cpg 0xa6>;
 		};
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index d129039b368b..80946cafaec1 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -92,9 +92,9 @@ int __init arch_probe_nr_irqs(void)
 	int nr_io_pics =3D bitmap_weight(loongson_sysconf.cores_io_master, NR_CPUS);
=20
 	if (!cpu_has_avecint)
-		nr_irqs =3D (64 + NR_VECTORS * nr_io_pics);
+		irq_set_nr_irqs(64 + NR_VECTORS * nr_io_pics);
 	else
-		nr_irqs =3D (64 + NR_VECTORS * (nr_cpu_ids + nr_io_pics));
+		irq_set_nr_irqs(64 + NR_VECTORS * (nr_cpu_ids + nr_io_pics));
=20
 	return NR_IRQS_LEGACY;
 }
diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/=
cell/axon_msi.c
index 28dc86744cac..d243f7fd8982 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -112,7 +112,7 @@ static void axon_msi_cascade(struct irq_desc *desc)
 		pr_devel("axon_msi: woff %x roff %x msi %x\n",
 			  write_offset, msic->read_offset, msi);
=20
-		if (msi < nr_irqs && irq_get_chip_data(msi) =3D=3D msic) {
+		if (msi < irq_get_nr_irqs() && irq_get_chip_data(msi) =3D=3D msic) {
 			generic_handle_irq(msi);
 			msic->fifo_virt[idx] =3D cpu_to_le32(0xffffffff);
 		} else {
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 2341393cfac1..5b1d6325df85 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -256,6 +256,7 @@ CONFIG_RPMSG_CTRL=3Dy
 CONFIG_RPMSG_VIRTIO=3Dy
 CONFIG_PM_DEVFREQ=3Dy
 CONFIG_IIO=3Dy
+CONFIG_THEAD_C900_ACLINT_SSWI=3Dy
 CONFIG_PHY_SUN4I_USB=3Dm
 CONFIG_PHY_STARFIVE_JH7110_DPHY_RX=3Dm
 CONFIG_PHY_STARFIVE_JH7110_PCIE=3Dm
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 2639a3d12736..a2c867181b5a 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -253,7 +253,7 @@ int show_interrupts(struct seq_file *p, void *v)
 		seq_putc(p, '\n');
 		goto out;
 	}
-	if (index < nr_irqs) {
+	if (index < irq_get_nr_irqs()) {
 		show_msi_interrupt(p, index);
 		goto out;
 	}
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 4efecac49863..3a44a9dc3fb7 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1171,7 +1171,8 @@ static int __init acpi_parse_madt_ioapic_entries(void)
 	}
=20
 	count =3D acpi_table_parse_madt(ACPI_MADT_TYPE_INTERRUPT_OVERRIDE,
-				      acpi_parse_int_src_ovr, nr_irqs);
+				      acpi_parse_int_src_ovr,
+				      irq_get_nr_irqs());
 	if (count < 0) {
 		pr_err("Error parsing interrupt source overrides entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
@@ -1191,7 +1192,8 @@ static int __init acpi_parse_madt_ioapic_entries(void)
 	mp_config_acpi_legacy_irqs();
=20
 	count =3D acpi_table_parse_madt(ACPI_MADT_TYPE_NMI_SOURCE,
-				      acpi_parse_nmi_src, nr_irqs);
+				      acpi_parse_nmi_src,
+				      irq_get_nr_irqs());
 	if (count < 0) {
 		pr_err("Error parsing NMI SRC entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 557318145038..736f62812f5c 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -712,8 +712,8 @@ int __init arch_probe_nr_irqs(void)
 {
 	int nr;
=20
-	if (nr_irqs > (NR_VECTORS * nr_cpu_ids))
-		nr_irqs =3D NR_VECTORS * nr_cpu_ids;
+	if (irq_get_nr_irqs() > NR_VECTORS * nr_cpu_ids)
+		irq_set_nr_irqs(NR_VECTORS * nr_cpu_ids);
=20
 	nr =3D (gsi_top + nr_legacy_irqs()) + 8 * nr_cpu_ids;
 #if defined(CONFIG_PCI_MSI)
@@ -725,8 +725,8 @@ int __init arch_probe_nr_irqs(void)
 	else
 		nr +=3D gsi_top * 16;
 #endif
-	if (nr < nr_irqs)
-		nr_irqs =3D nr;
+	if (nr < irq_get_nr_irqs())
+		irq_set_nr_irqs(nr);
=20
 	/*
 	 * We don't know if PIC is present at this point so we need to do
diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index e904e476e49a..48fe96ab4649 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -162,6 +162,7 @@ static irqreturn_t hpet_interrupt(int irq, void *data)
=20
 static void hpet_timer_set_irq(struct hpet_dev *devp)
 {
+	const unsigned int nr_irqs =3D irq_get_nr_irqs();
 	unsigned long v;
 	int irq, gsi;
 	struct hpet_timer __iomem *timer;
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 341cd9ca5a05..9cac13663871 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -265,6 +265,13 @@ config RENESAS_RZG2L_IRQC
 	  Enable support for the Renesas RZ/G2L (and alike SoC) Interrupt Controller
 	  for external devices.
=20
+config RENESAS_RZV2H_ICU
+	bool "Renesas RZ/V2H(P) ICU support" if COMPILE_TEST
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Enable support for the Renesas RZ/V2H(P) Interrupt Control Unit (ICU)
+
 config SL28CPLD_INTC
 	bool "Kontron sl28cpld IRQ controller"
 	depends on MFD_SL28CPLD=3Dy || COMPILE_TEST
@@ -345,6 +352,7 @@ config KEYSTONE_IRQ
=20
 config MIPS_GIC
 	bool
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 	select GENERIC_IRQ_IPI if SMP
 	select IRQ_DOMAIN_HIERARCHY
 	select MIPS_CM
@@ -611,6 +619,18 @@ config STARFIVE_JH8100_INTC
=20
 	  If you don't know what to do here, say Y.
=20
+config THEAD_C900_ACLINT_SSWI
+	bool "THEAD C9XX ACLINT S-mode IPI Interrupt Controller"
+	depends on RISCV
+	depends on SMP
+	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_IRQ_IPI_MUX
+	help
+	  This enables support for T-HEAD specific ACLINT SSWI device
+	  support.
+
+	  If you don't know what to do here, say Y.
+
 config EXYNOS_IRQ_COMBINER
 	bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
 	depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e3679ec2b9f7..25e9ad29b8c4 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+=3D irq-renesas-intc-irq=
pin.o
 obj-$(CONFIG_RENESAS_IRQC)		+=3D irq-renesas-irqc.o
 obj-$(CONFIG_RENESAS_RZA1_IRQC)		+=3D irq-renesas-rza1.o
 obj-$(CONFIG_RENESAS_RZG2L_IRQC)	+=3D irq-renesas-rzg2l.o
+obj-$(CONFIG_RENESAS_RZV2H_ICU)		+=3D irq-renesas-rzv2h.o
 obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+=3D irq-versatile-fpga.o
 obj-$(CONFIG_ARCH_NSPIRE)		+=3D irq-zevio.o
 obj-$(CONFIG_ARCH_VT8500)		+=3D irq-vt8500.o
@@ -84,6 +85,7 @@ obj-$(CONFIG_MVEBU_SEI)			+=3D irq-mvebu-sei.o
 obj-$(CONFIG_LS_EXTIRQ)			+=3D irq-ls-extirq.o
 obj-$(CONFIG_LS_SCFG_MSI)		+=3D irq-ls-scfg-msi.o
 obj-$(CONFIG_ARCH_ASPEED)		+=3D irq-aspeed-vic.o irq-aspeed-i2c-ic.o irq-asp=
eed-scu-ic.o
+obj-$(CONFIG_ARCH_ASPEED)		+=3D irq-aspeed-intc.o
 obj-$(CONFIG_STM32MP_EXTI)		+=3D irq-stm32mp-exti.o
 obj-$(CONFIG_STM32_EXTI) 		+=3D irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+=3D qcom-irq-combiner.o
@@ -101,6 +103,7 @@ obj-$(CONFIG_RISCV_APLIC_MSI)		+=3D irq-riscv-aplic-msi.o
 obj-$(CONFIG_RISCV_IMSIC)		+=3D irq-riscv-imsic-state.o irq-riscv-imsic-earl=
y.o irq-riscv-imsic-platform.o
 obj-$(CONFIG_SIFIVE_PLIC)		+=3D irq-sifive-plic.o
 obj-$(CONFIG_STARFIVE_JH8100_INTC)	+=3D irq-starfive-jh8100-intc.o
+obj-$(CONFIG_THEAD_C900_ACLINT_SSWI)	+=3D irq-thead-c900-aclint-sswi.o
 obj-$(CONFIG_IMX_IRQSTEER)		+=3D irq-imx-irqsteer.o
 obj-$(CONFIG_IMX_INTMUX)		+=3D irq-imx-intmux.o
 obj-$(CONFIG_IMX_MU_MSI)		+=3D irq-imx-mu-msi.o
diff --git a/drivers/irqchip/irq-aspeed-intc.c b/drivers/irqchip/irq-aspeed-i=
ntc.c
new file mode 100644
index 000000000000..bd3b759b4b2c
--- /dev/null
+++ b/drivers/irqchip/irq-aspeed-intc.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Aspeed Interrupt Controller.
+ *
+ *  Copyright (C) 2023 ASPEED Technology Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+
+#define INTC_INT_ENABLE_REG	0x00
+#define INTC_INT_STATUS_REG	0x04
+#define INTC_IRQS_PER_WORD	32
+
+struct aspeed_intc_ic {
+	void __iomem		*base;
+	raw_spinlock_t		gic_lock;
+	raw_spinlock_t		intc_lock;
+	struct irq_domain	*irq_domain;
+};
+
+static void aspeed_intc_ic_irq_handler(struct irq_desc *desc)
+{
+	struct aspeed_intc_ic *intc_ic =3D irq_desc_get_handler_data(desc);
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+
+	scoped_guard(raw_spinlock, &intc_ic->gic_lock) {
+		unsigned long bit, status;
+
+		status =3D readl(intc_ic->base + INTC_INT_STATUS_REG);
+		for_each_set_bit(bit, &status, INTC_IRQS_PER_WORD) {
+			generic_handle_domain_irq(intc_ic->irq_domain, bit);
+			writel(BIT(bit), intc_ic->base + INTC_INT_STATUS_REG);
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void aspeed_intc_irq_mask(struct irq_data *data)
+{
+	struct aspeed_intc_ic *intc_ic =3D irq_data_get_irq_chip_data(data);
+	unsigned int mask =3D readl(intc_ic->base + INTC_INT_ENABLE_REG) & ~BIT(dat=
a->hwirq);
+
+	guard(raw_spinlock)(&intc_ic->intc_lock);
+	writel(mask, intc_ic->base + INTC_INT_ENABLE_REG);
+}
+
+static void aspeed_intc_irq_unmask(struct irq_data *data)
+{
+	struct aspeed_intc_ic *intc_ic =3D irq_data_get_irq_chip_data(data);
+	unsigned int unmask =3D readl(intc_ic->base + INTC_INT_ENABLE_REG) | BIT(da=
ta->hwirq);
+
+	guard(raw_spinlock)(&intc_ic->intc_lock);
+	writel(unmask, intc_ic->base + INTC_INT_ENABLE_REG);
+}
+
+static struct irq_chip aspeed_intc_chip =3D {
+	.name			=3D "ASPEED INTC",
+	.irq_mask		=3D aspeed_intc_irq_mask,
+	.irq_unmask		=3D aspeed_intc_irq_unmask,
+};
+
+static int aspeed_intc_ic_map_irq_domain(struct irq_domain *domain, unsigned=
 int irq,
+					 irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &aspeed_intc_chip, handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops aspeed_intc_ic_irq_domain_ops =3D {
+	.map =3D aspeed_intc_ic_map_irq_domain,
+};
+
+static int __init aspeed_intc_ic_of_init(struct device_node *node,
+					 struct device_node *parent)
+{
+	struct aspeed_intc_ic *intc_ic;
+	int irq, i, ret =3D 0;
+
+	intc_ic =3D kzalloc(sizeof(*intc_ic), GFP_KERNEL);
+	if (!intc_ic)
+		return -ENOMEM;
+
+	intc_ic->base =3D of_iomap(node, 0);
+	if (!intc_ic->base) {
+		pr_err("Failed to iomap intc_ic base\n");
+		ret =3D -ENOMEM;
+		goto err_free_ic;
+	}
+	writel(0xffffffff, intc_ic->base + INTC_INT_STATUS_REG);
+	writel(0x0, intc_ic->base + INTC_INT_ENABLE_REG);
+
+	intc_ic->irq_domain =3D irq_domain_add_linear(node, INTC_IRQS_PER_WORD,
+						    &aspeed_intc_ic_irq_domain_ops, intc_ic);
+	if (!intc_ic->irq_domain) {
+		ret =3D -ENOMEM;
+		goto err_iounmap;
+	}
+
+	raw_spin_lock_init(&intc_ic->gic_lock);
+	raw_spin_lock_init(&intc_ic->intc_lock);
+
+	/* Check all the irq numbers valid. If not, unmaps all the base and frees t=
he data. */
+	for (i =3D 0; i < of_irq_count(node); i++) {
+		irq =3D irq_of_parse_and_map(node, i);
+		if (!irq) {
+			pr_err("Failed to get irq number\n");
+			ret =3D -EINVAL;
+			goto err_iounmap;
+		}
+	}
+
+	for (i =3D 0; i < of_irq_count(node); i++) {
+		irq =3D irq_of_parse_and_map(node, i);
+		irq_set_chained_handler_and_data(irq, aspeed_intc_ic_irq_handler, intc_ic);
+	}
+
+	return 0;
+
+err_iounmap:
+	iounmap(intc_ic->base);
+err_free_ic:
+	kfree(intc_ic);
+	return ret;
+}
+
+IRQCHIP_DECLARE(ast2700_intc_ic, "aspeed,ast2700-intc-ic", aspeed_intc_ic_of=
_init);
diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic=
5.c
index c0f55dc7b050..e98c2875af9e 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -319,6 +319,7 @@ static const struct of_device_id aic5_irq_fixups[] __init=
const =3D {
 	{ .compatible =3D "atmel,sama5d3", .data =3D sama5d3_aic_irq_fixup },
 	{ .compatible =3D "atmel,sama5d4", .data =3D sama5d3_aic_irq_fixup },
 	{ .compatible =3D "microchip,sam9x60", .data =3D sam9x60_aic_irq_fixup },
+	{ .compatible =3D "microchip,sam9x7", .data =3D sam9x60_aic_irq_fixup },
 	{ /* sentinel */ },
 };
=20
@@ -405,3 +406,11 @@ static int __init sam9x60_aic5_of_init(struct device_nod=
e *node,
 	return aic5_of_init(node, parent, NR_SAM9X60_IRQS);
 }
 IRQCHIP_DECLARE(sam9x60_aic5, "microchip,sam9x60-aic", sam9x60_aic5_of_init);
+
+#define NR_SAM9X7_IRQS		70
+
+static int __init sam9x7_aic5_of_init(struct device_node *node, struct devic=
e_node *parent)
+{
+	return aic5_of_init(node, parent, NR_SAM9X7_IRQS);
+}
+IRQCHIP_DECLARE(sam9x7_aic5, "microchip,sam9x7-aic", sam9x7_aic5_of_init);
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index fdec478ba5e7..395961fb2180 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -12,12 +12,14 @@
 #include <linux/crash_dump.h>
 #include <linux/delay.h>
 #include <linux/efi.h>
+#include <linux/genalloc.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/irqdomain.h>
 #include <linux/list.h>
 #include <linux/log2.h>
+#include <linux/mem_encrypt.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/msi.h>
@@ -27,6 +29,7 @@
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/percpu.h>
+#include <linux/set_memory.h>
 #include <linux/slab.h>
 #include <linux/syscore_ops.h>
=20
@@ -164,6 +167,7 @@ struct its_device {
 	struct its_node		*its;
 	struct event_lpi_map	event_map;
 	void			*itt;
+	u32			itt_sz;
 	u32			nr_ites;
 	u32			device_id;
 	bool			shared;
@@ -199,6 +203,87 @@ static DEFINE_IDA(its_vpeid_ida);
 #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
 #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + SZ_128K)
=20
+static struct page *its_alloc_pages_node(int node, gfp_t gfp,
+					 unsigned int order)
+{
+	struct page *page;
+	int ret =3D 0;
+
+	page =3D alloc_pages_node(node, gfp, order);
+
+	if (!page)
+		return NULL;
+
+	ret =3D set_memory_decrypted((unsigned long)page_address(page),
+				   1 << order);
+	/*
+	 * If set_memory_decrypted() fails then we don't know what state the
+	 * page is in, so we can't free it. Instead we leak it.
+	 * set_memory_decrypted() will already have WARNed.
+	 */
+	if (ret)
+		return NULL;
+
+	return page;
+}
+
+static struct page *its_alloc_pages(gfp_t gfp, unsigned int order)
+{
+	return its_alloc_pages_node(NUMA_NO_NODE, gfp, order);
+}
+
+static void its_free_pages(void *addr, unsigned int order)
+{
+	/*
+	 * If the memory cannot be encrypted again then we must leak the pages.
+	 * set_memory_encrypted() will already have WARNed.
+	 */
+	if (set_memory_encrypted((unsigned long)addr, 1 << order))
+		return;
+	free_pages((unsigned long)addr, order);
+}
+
+static struct gen_pool *itt_pool;
+
+static void *itt_alloc_pool(int node, int size)
+{
+	unsigned long addr;
+	struct page *page;
+
+	if (size >=3D PAGE_SIZE) {
+		page =3D its_alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, get_order(siz=
e));
+
+		return page ? page_address(page) : NULL;
+	}
+
+	do {
+		addr =3D gen_pool_alloc(itt_pool, size);
+		if (addr)
+			break;
+
+		page =3D its_alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
+		if (!page)
+			break;
+
+		gen_pool_add(itt_pool, (unsigned long)page_address(page), PAGE_SIZE, node);
+	} while (!addr);
+
+	return (void *)addr;
+}
+
+static void itt_free_pool(void *addr, int size)
+{
+	if (!addr)
+		return;
+
+	if (size >=3D PAGE_SIZE) {
+		its_free_pages(addr, get_order(size));
+		return;
+	}
+
+	gen_pool_free(itt_pool, (unsigned long)addr, size);
+}
+
 /*
  * Skip ITSs that have no vLPIs mapped, unless we're on GICv4.1, as we
  * always have vSGIs mapped.
@@ -621,7 +706,6 @@ static struct its_collection *its_build_mapd_cmd(struct i=
ts_node *its,
 	u8 size =3D ilog2(desc->its_mapd_cmd.dev->nr_ites);
=20
 	itt_addr =3D virt_to_phys(desc->its_mapd_cmd.dev->itt);
-	itt_addr =3D ALIGN(itt_addr, ITS_ITT_ALIGN);
=20
 	its_encode_cmd(cmd, GITS_CMD_MAPD);
 	its_encode_devid(cmd, desc->its_mapd_cmd.dev->device_id);
@@ -2181,7 +2265,8 @@ static struct page *its_allocate_prop_table(gfp_t gfp_f=
lags)
 {
 	struct page *prop_page;
=20
-	prop_page =3D alloc_pages(gfp_flags, get_order(LPI_PROPBASE_SZ));
+	prop_page =3D its_alloc_pages(gfp_flags,
+				    get_order(LPI_PROPBASE_SZ));
 	if (!prop_page)
 		return NULL;
=20
@@ -2192,8 +2277,7 @@ static struct page *its_allocate_prop_table(gfp_t gfp_f=
lags)
=20
 static void its_free_prop_table(struct page *prop_page)
 {
-	free_pages((unsigned long)page_address(prop_page),
-		   get_order(LPI_PROPBASE_SZ));
+	its_free_pages(page_address(prop_page), get_order(LPI_PROPBASE_SZ));
 }
=20
 static bool gic_check_reserved_range(phys_addr_t addr, unsigned long size)
@@ -2315,7 +2399,7 @@ static int its_setup_baser(struct its_node *its, struct=
 its_baser *baser,
 		order =3D get_order(GITS_BASER_PAGES_MAX * psz);
 	}
=20
-	page =3D alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO, order);
+	page =3D its_alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO, orde=
r);
 	if (!page)
 		return -ENOMEM;
=20
@@ -2328,7 +2412,7 @@ static int its_setup_baser(struct its_node *its, struct=
 its_baser *baser,
 		/* 52bit PA is supported only when PageSize=3D64K */
 		if (psz !=3D SZ_64K) {
 			pr_err("ITS: no 52bit PA support when psz=3D%d\n", psz);
-			free_pages((unsigned long)base, order);
+			its_free_pages(base, order);
 			return -ENXIO;
 		}
=20
@@ -2384,7 +2468,7 @@ static int its_setup_baser(struct its_node *its, struct=
 its_baser *baser,
 		pr_err("ITS@%pa: %s doesn't stick: %llx %llx\n",
 		       &its->phys_base, its_base_type_string[type],
 		       val, tmp);
-		free_pages((unsigned long)base, order);
+		its_free_pages(base, order);
 		return -ENXIO;
 	}
=20
@@ -2523,8 +2607,7 @@ static void its_free_tables(struct its_node *its)
=20
 	for (i =3D 0; i < GITS_BASER_NR_REGS; i++) {
 		if (its->tables[i].base) {
-			free_pages((unsigned long)its->tables[i].base,
-				   its->tables[i].order);
+			its_free_pages(its->tables[i].base, its->tables[i].order);
 			its->tables[i].base =3D NULL;
 		}
 	}
@@ -2790,7 +2873,7 @@ static bool allocate_vpe_l2_table(int cpu, u32 id)
=20
 	/* Allocate memory for 2nd level table */
 	if (!table[idx]) {
-		page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, get_order(psz));
+		page =3D its_alloc_pages(GFP_KERNEL | __GFP_ZERO, get_order(psz));
 		if (!page)
 			return false;
=20
@@ -2909,7 +2992,7 @@ static int allocate_vpe_l1_table(void)
=20
 	pr_debug("np =3D %d, npg =3D %lld, psz =3D %d, epp =3D %d, esz =3D %d\n",
 		 np, npg, psz, epp, esz);
-	page =3D alloc_pages(GFP_ATOMIC | __GFP_ZERO, get_order(np * PAGE_SIZE));
+	page =3D its_alloc_pages(GFP_ATOMIC | __GFP_ZERO, get_order(np * PAGE_SIZE)=
);
 	if (!page)
 		return -ENOMEM;
=20
@@ -2955,8 +3038,7 @@ static struct page *its_allocate_pending_table(gfp_t gf=
p_flags)
 {
 	struct page *pend_page;
=20
-	pend_page =3D alloc_pages(gfp_flags | __GFP_ZERO,
-				get_order(LPI_PENDBASE_SZ));
+	pend_page =3D its_alloc_pages(gfp_flags | __GFP_ZERO, get_order(LPI_PENDBAS=
E_SZ));
 	if (!pend_page)
 		return NULL;
=20
@@ -2968,7 +3050,7 @@ static struct page *its_allocate_pending_table(gfp_t gf=
p_flags)
=20
 static void its_free_pending_table(struct page *pt)
 {
-	free_pages((unsigned long)page_address(pt), get_order(LPI_PENDBASE_SZ));
+	its_free_pages(page_address(pt), get_order(LPI_PENDBASE_SZ));
 }
=20
 /*
@@ -3303,8 +3385,8 @@ static bool its_alloc_table_entry(struct its_node *its,
=20
 	/* Allocate memory for 2nd level table */
 	if (!table[idx]) {
-		page =3D alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO,
-					get_order(baser->psz));
+		page =3D its_alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO,
+					    get_order(baser->psz));
 		if (!page)
 			return false;
=20
@@ -3399,15 +3481,18 @@ static struct its_device *its_create_device(struct it=
s_node *its, u32 dev_id,
 	if (WARN_ON(!is_power_of_2(nvecs)))
 		nvecs =3D roundup_pow_of_two(nvecs);
=20
-	dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
 	/*
 	 * Even if the device wants a single LPI, the ITT must be
 	 * sized as a power of two (and you need at least one bit...).
 	 */
 	nr_ites =3D max(2, nvecs);
 	sz =3D nr_ites * (FIELD_GET(GITS_TYPER_ITT_ENTRY_SIZE, its->typer) + 1);
-	sz =3D max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
-	itt =3D kzalloc_node(sz, GFP_KERNEL, its->numa_node);
+	sz =3D max(sz, ITS_ITT_ALIGN);
+
+	itt =3D itt_alloc_pool(its->numa_node, sz);
+
+	dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
+
 	if (alloc_lpis) {
 		lpi_map =3D its_lpi_alloc(nvecs, &lpi_base, &nr_lpis);
 		if (lpi_map)
@@ -3419,9 +3504,9 @@ static struct its_device *its_create_device(struct its_=
node *its, u32 dev_id,
 		lpi_base =3D 0;
 	}
=20
-	if (!dev || !itt ||  !col_map || (!lpi_map && alloc_lpis)) {
+	if (!dev || !itt || !col_map || (!lpi_map && alloc_lpis)) {
 		kfree(dev);
-		kfree(itt);
+		itt_free_pool(itt, sz);
 		bitmap_free(lpi_map);
 		kfree(col_map);
 		return NULL;
@@ -3431,6 +3516,7 @@ static struct its_device *its_create_device(struct its_=
node *its, u32 dev_id,
=20
 	dev->its =3D its;
 	dev->itt =3D itt;
+	dev->itt_sz =3D sz;
 	dev->nr_ites =3D nr_ites;
 	dev->event_map.lpi_map =3D lpi_map;
 	dev->event_map.col_map =3D col_map;
@@ -3458,7 +3544,7 @@ static void its_free_device(struct its_device *its_dev)
 	list_del(&its_dev->entry);
 	raw_spin_unlock_irqrestore(&its_dev->its->lock, flags);
 	kfree(its_dev->event_map.col_map);
-	kfree(its_dev->itt);
+	itt_free_pool(its_dev->itt, its_dev->itt_sz);
 	kfree(its_dev);
 }
=20
@@ -5116,8 +5202,9 @@ static int __init its_probe_one(struct its_node *its)
 		}
 	}
=20
-	page =3D alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO,
-				get_order(ITS_CMD_QUEUE_SZ));
+	page =3D its_alloc_pages_node(its->numa_node,
+				    GFP_KERNEL | __GFP_ZERO,
+				    get_order(ITS_CMD_QUEUE_SZ));
 	if (!page) {
 		err =3D -ENOMEM;
 		goto out_unmap_sgir;
@@ -5181,7 +5268,7 @@ static int __init its_probe_one(struct its_node *its)
 out_free_tables:
 	its_free_tables(its);
 out_free_cmd:
-	free_pages((unsigned long)its->cmd_base, get_order(ITS_CMD_QUEUE_SZ));
+	its_free_pages(its->cmd_base, get_order(ITS_CMD_QUEUE_SZ));
 out_unmap_sgir:
 	if (its->sgir_base)
 		iounmap(its->sgir_base);
@@ -5667,6 +5754,10 @@ int __init its_init(struct fwnode_handle *handle, stru=
ct rdists *rdists,
 	bool has_v4_1 =3D false;
 	int err;
=20
+	itt_pool =3D gen_pool_create(get_order(ITS_ITT_ALIGN), -1);
+	if (!itt_pool)
+		return -ENOMEM;
+
 	gic_rdists =3D rdists;
=20
 	lpi_prop_prio =3D irq_prio;
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 76253e864f23..bca8053864b2 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -66,6 +66,87 @@ static struct gic_all_vpes_chip_data {
 	bool	mask;
 } gic_all_vpes_chip_data[GIC_NUM_LOCAL_INTRS];
=20
+static int __gic_with_next_online_cpu(int prev)
+{
+	unsigned int cpu;
+
+	/* Discover the next online CPU */
+	cpu =3D cpumask_next(prev, cpu_online_mask);
+
+	/* If there isn't one, we're done */
+	if (cpu >=3D nr_cpu_ids)
+		return cpu;
+
+	/*
+	 * Move the access lock to the next CPU's GIC local register block.
+	 *
+	 * Set GIC_VL_OTHER. Since the caller holds gic_lock nothing can
+	 * clobber the written value.
+	 */
+	write_gic_vl_other(mips_cm_vp_id(cpu));
+
+	return cpu;
+}
+
+static inline void gic_unlock_cluster(void)
+{
+	if (mips_cps_multicluster_cpus())
+		mips_cm_unlock_other();
+}
+
+/**
+ * for_each_online_cpu_gic() - Iterate over online CPUs, access local regist=
ers
+ * @cpu: An integer variable to hold the current CPU number
+ * @gic_lock: A pointer to raw spin lock used as a guard
+ *
+ * Iterate over online CPUs & configure the other/redirect register region to
+ * access each CPUs GIC local register block, which can be accessed from the
+ * loop body using read_gic_vo_*() or write_gic_vo_*() accessor functions or
+ * their derivatives.
+ */
+#define for_each_online_cpu_gic(cpu, gic_lock)		\
+	guard(raw_spinlock_irqsave)(gic_lock);		\
+	for ((cpu) =3D __gic_with_next_online_cpu(-1);	\
+	     (cpu) < nr_cpu_ids;			\
+	     gic_unlock_cluster(),			\
+	     (cpu) =3D __gic_with_next_online_cpu(cpu))
+
+/**
+ * gic_irq_lock_cluster() - Lock redirect block access to IRQ's cluster
+ * @d: struct irq_data corresponding to the interrupt we're interested in
+ *
+ * Locks redirect register block access to the global register block of the =
GIC
+ * within the remote cluster that the IRQ corresponding to @d is affine to,
+ * returning true when this redirect block setup & locking has been performe=
d.
+ *
+ * If @d is affine to the local cluster then no locking is performed and this
+ * function will return false, indicating to the caller that it should access
+ * the local clusters registers without the overhead of indirection through =
the
+ * redirect block.
+ *
+ * In summary, if this function returns true then the caller should access G=
IC
+ * registers using redirect register block accessors & then call
+ * mips_cm_unlock_other() when done. If this function returns false then the
+ * caller should trivially access GIC registers in the local cluster.
+ *
+ * Returns true if locking performed, else false.
+ */
+static bool gic_irq_lock_cluster(struct irq_data *d)
+{
+	unsigned int cpu, cl;
+
+	cpu =3D cpumask_first(irq_data_get_effective_affinity_mask(d));
+	BUG_ON(cpu >=3D NR_CPUS);
+
+	cl =3D cpu_cluster(&cpu_data[cpu]);
+	if (cl =3D=3D cpu_cluster(&current_cpu_data))
+		return false;
+	if (mips_cps_numcores(cl) =3D=3D 0)
+		return false;
+	mips_cm_lock_other(cl, 0, 0, CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
+	return true;
+}
+
 static void gic_clear_pcpu_masks(unsigned int intr)
 {
 	unsigned int i;
@@ -112,7 +193,12 @@ static void gic_send_ipi(struct irq_data *d, unsigned in=
t cpu)
 {
 	irq_hw_number_t hwirq =3D GIC_HWIRQ_TO_SHARED(irqd_to_hwirq(d));
=20
-	write_gic_wedge(GIC_WEDGE_RW | hwirq);
+	if (gic_irq_lock_cluster(d)) {
+		write_gic_redir_wedge(GIC_WEDGE_RW | hwirq);
+		mips_cm_unlock_other();
+	} else {
+		write_gic_wedge(GIC_WEDGE_RW | hwirq);
+	}
 }
=20
 int gic_get_c0_compare_int(void)
@@ -180,7 +266,13 @@ static void gic_mask_irq(struct irq_data *d)
 {
 	unsigned int intr =3D GIC_HWIRQ_TO_SHARED(d->hwirq);
=20
-	write_gic_rmask(intr);
+	if (gic_irq_lock_cluster(d)) {
+		write_gic_redir_rmask(intr);
+		mips_cm_unlock_other();
+	} else {
+		write_gic_rmask(intr);
+	}
+
 	gic_clear_pcpu_masks(intr);
 }
=20
@@ -189,7 +281,12 @@ static void gic_unmask_irq(struct irq_data *d)
 	unsigned int intr =3D GIC_HWIRQ_TO_SHARED(d->hwirq);
 	unsigned int cpu;
=20
-	write_gic_smask(intr);
+	if (gic_irq_lock_cluster(d)) {
+		write_gic_redir_smask(intr);
+		mips_cm_unlock_other();
+	} else {
+		write_gic_smask(intr);
+	}
=20
 	gic_clear_pcpu_masks(intr);
 	cpu =3D cpumask_first(irq_data_get_effective_affinity_mask(d));
@@ -200,7 +297,12 @@ static void gic_ack_irq(struct irq_data *d)
 {
 	unsigned int irq =3D GIC_HWIRQ_TO_SHARED(d->hwirq);
=20
-	write_gic_wedge(irq);
+	if (gic_irq_lock_cluster(d)) {
+		write_gic_redir_wedge(irq);
+		mips_cm_unlock_other();
+	} else {
+		write_gic_wedge(irq);
+	}
 }
=20
 static int gic_set_type(struct irq_data *d, unsigned int type)
@@ -240,9 +342,16 @@ static int gic_set_type(struct irq_data *d, unsigned int=
 type)
 		break;
 	}
=20
-	change_gic_pol(irq, pol);
-	change_gic_trig(irq, trig);
-	change_gic_dual(irq, dual);
+	if (gic_irq_lock_cluster(d)) {
+		change_gic_redir_pol(irq, pol);
+		change_gic_redir_trig(irq, trig);
+		change_gic_redir_dual(irq, dual);
+		mips_cm_unlock_other();
+	} else {
+		change_gic_pol(irq, pol);
+		change_gic_trig(irq, trig);
+		change_gic_dual(irq, dual);
+	}
=20
 	if (trig =3D=3D GIC_TRIG_EDGE)
 		irq_set_chip_handler_name_locked(d, &gic_edge_irq_controller,
@@ -260,25 +369,72 @@ static int gic_set_affinity(struct irq_data *d, const s=
truct cpumask *cpumask,
 			    bool force)
 {
 	unsigned int irq =3D GIC_HWIRQ_TO_SHARED(d->hwirq);
+	unsigned int cpu, cl, old_cpu, old_cl;
 	unsigned long flags;
-	unsigned int cpu;
=20
+	/*
+	 * The GIC specifies that we can only route an interrupt to one VP(E),
+	 * ie. CPU in Linux parlance, at a time. Therefore we always route to
+	 * the first online CPU in the mask.
+	 */
 	cpu =3D cpumask_first_and(cpumask, cpu_online_mask);
 	if (cpu >=3D NR_CPUS)
 		return -EINVAL;
=20
-	/* Assumption : cpumask refers to a single CPU */
-	raw_spin_lock_irqsave(&gic_lock, flags);
+	old_cpu =3D cpumask_first(irq_data_get_effective_affinity_mask(d));
+	old_cl =3D cpu_cluster(&cpu_data[old_cpu]);
+	cl =3D cpu_cluster(&cpu_data[cpu]);
=20
-	/* Re-route this IRQ */
-	write_gic_map_vp(irq, BIT(mips_cm_vp_id(cpu)));
+	raw_spin_lock_irqsave(&gic_lock, flags);
=20
-	/* Update the pcpu_masks */
-	gic_clear_pcpu_masks(irq);
-	if (read_gic_mask(irq))
-		set_bit(irq, per_cpu_ptr(pcpu_masks, cpu));
+	/*
+	 * If we're moving affinity between clusters, stop routing the
+	 * interrupt to any VP(E) in the old cluster.
+	 */
+	if (cl !=3D old_cl) {
+		if (gic_irq_lock_cluster(d)) {
+			write_gic_redir_map_vp(irq, 0);
+			mips_cm_unlock_other();
+		} else {
+			write_gic_map_vp(irq, 0);
+		}
+	}
=20
+	/*
+	 * Update effective affinity - after this gic_irq_lock_cluster() will
+	 * begin operating on the new cluster.
+	 */
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	/*
+	 * If we're moving affinity between clusters, configure the interrupt
+	 * trigger type in the new cluster.
+	 */
+	if (cl !=3D old_cl)
+		gic_set_type(d, irqd_get_trigger_type(d));
+
+	/* Route the interrupt to its new VP(E) */
+	if (gic_irq_lock_cluster(d)) {
+		write_gic_redir_map_pin(irq,
+					GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
+		write_gic_redir_map_vp(irq, BIT(mips_cm_vp_id(cpu)));
+
+		/* Update the pcpu_masks */
+		gic_clear_pcpu_masks(irq);
+		if (read_gic_redir_mask(irq))
+			set_bit(irq, per_cpu_ptr(pcpu_masks, cpu));
+
+		mips_cm_unlock_other();
+	} else {
+		write_gic_map_pin(irq, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
+		write_gic_map_vp(irq, BIT(mips_cm_vp_id(cpu)));
+
+		/* Update the pcpu_masks */
+		gic_clear_pcpu_masks(irq);
+		if (read_gic_mask(irq))
+			set_bit(irq, per_cpu_ptr(pcpu_masks, cpu));
+	}
+
 	raw_spin_unlock_irqrestore(&gic_lock, flags);
=20
 	return IRQ_SET_MASK_OK;
@@ -350,37 +506,33 @@ static struct irq_chip gic_local_irq_controller =3D {
 static void gic_mask_local_irq_all_vpes(struct irq_data *d)
 {
 	struct gic_all_vpes_chip_data *cd;
-	unsigned long flags;
 	int intr, cpu;
=20
+	if (!mips_cps_multicluster_cpus())
+		return;
+
 	intr =3D GIC_HWIRQ_TO_LOCAL(d->hwirq);
 	cd =3D irq_data_get_irq_chip_data(d);
 	cd->mask =3D false;
=20
-	raw_spin_lock_irqsave(&gic_lock, flags);
-	for_each_online_cpu(cpu) {
-		write_gic_vl_other(mips_cm_vp_id(cpu));
+	for_each_online_cpu_gic(cpu, &gic_lock)
 		write_gic_vo_rmask(BIT(intr));
-	}
-	raw_spin_unlock_irqrestore(&gic_lock, flags);
 }
=20
 static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
 {
 	struct gic_all_vpes_chip_data *cd;
-	unsigned long flags;
 	int intr, cpu;
=20
+	if (!mips_cps_multicluster_cpus())
+		return;
+
 	intr =3D GIC_HWIRQ_TO_LOCAL(d->hwirq);
 	cd =3D irq_data_get_irq_chip_data(d);
 	cd->mask =3D true;
=20
-	raw_spin_lock_irqsave(&gic_lock, flags);
-	for_each_online_cpu(cpu) {
-		write_gic_vl_other(mips_cm_vp_id(cpu));
+	for_each_online_cpu_gic(cpu, &gic_lock)
 		write_gic_vo_smask(BIT(intr));
-	}
-	raw_spin_unlock_irqrestore(&gic_lock, flags);
 }
=20
 static void gic_all_vpes_irq_cpu_online(void)
@@ -436,11 +588,21 @@ static int gic_shared_irq_domain_map(struct irq_domain =
*d, unsigned int virq,
 	unsigned long flags;
=20
 	data =3D irq_get_irq_data(virq);
+	irq_data_update_effective_affinity(data, cpumask_of(cpu));
=20
 	raw_spin_lock_irqsave(&gic_lock, flags);
-	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
-	write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
-	irq_data_update_effective_affinity(data, cpumask_of(cpu));
+
+	/* Route the interrupt to its VP(E) */
+	if (gic_irq_lock_cluster(data)) {
+		write_gic_redir_map_pin(intr,
+					GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
+		write_gic_redir_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
+		mips_cm_unlock_other();
+	} else {
+		write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
+		write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
+	}
+
 	raw_spin_unlock_irqrestore(&gic_lock, flags);
=20
 	return 0;
@@ -469,7 +631,6 @@ static int gic_irq_domain_map(struct irq_domain *d, unsig=
ned int virq,
 			      irq_hw_number_t hwirq)
 {
 	struct gic_all_vpes_chip_data *cd;
-	unsigned long flags;
 	unsigned int intr;
 	int err, cpu;
 	u32 map;
@@ -533,12 +694,10 @@ static int gic_irq_domain_map(struct irq_domain *d, uns=
igned int virq,
 	if (!gic_local_irq_is_routable(intr))
 		return -EPERM;
=20
-	raw_spin_lock_irqsave(&gic_lock, flags);
-	for_each_online_cpu(cpu) {
-		write_gic_vl_other(mips_cm_vp_id(cpu));
-		write_gic_vo_map(mips_gic_vx_map_reg(intr), map);
+	if (mips_cps_multicluster_cpus()) {
+		for_each_online_cpu_gic(cpu, &gic_lock)
+			write_gic_vo_map(mips_gic_vx_map_reg(intr), map);
 	}
-	raw_spin_unlock_irqrestore(&gic_lock, flags);
=20
 	return 0;
 }
@@ -621,6 +780,9 @@ static int gic_ipi_domain_alloc(struct irq_domain *d, uns=
igned int virq,
 		if (ret)
 			goto error;
=20
+		/* Set affinity to cpu.  */
+		irq_data_update_effective_affinity(irq_get_irq_data(virq + i),
+						   cpumask_of(cpu));
 		ret =3D irq_set_irq_type(virq + i, IRQ_TYPE_EDGE_RISING);
 		if (ret)
 			goto error;
@@ -734,7 +896,7 @@ static int gic_cpu_startup(unsigned int cpu)
 static int __init gic_of_init(struct device_node *node,
 			      struct device_node *parent)
 {
-	unsigned int cpu_vec, i, gicconfig;
+	unsigned int cpu_vec, i, gicconfig, cl, nclusters;
 	unsigned long reserved;
 	phys_addr_t gic_base;
 	struct resource res;
@@ -815,11 +977,32 @@ static int __init gic_of_init(struct device_node *node,
=20
 	board_bind_eic_interrupt =3D &gic_bind_eic_interrupt;
=20
-	/* Setup defaults */
-	for (i =3D 0; i < gic_shared_intrs; i++) {
-		change_gic_pol(i, GIC_POL_ACTIVE_HIGH);
-		change_gic_trig(i, GIC_TRIG_LEVEL);
-		write_gic_rmask(i);
+	/*
+	 * Initialise each cluster's GIC shared registers to sane default
+	 * values.
+	 * Otherwise, the IPI set up will be erased if we move code
+	 * to gic_cpu_startup for each cpu.
+	 */
+	nclusters =3D mips_cps_numclusters();
+	for (cl =3D 0; cl < nclusters; cl++) {
+		if (cl =3D=3D cpu_cluster(&current_cpu_data)) {
+			for (i =3D 0; i < gic_shared_intrs; i++) {
+				change_gic_pol(i, GIC_POL_ACTIVE_HIGH);
+				change_gic_trig(i, GIC_TRIG_LEVEL);
+				write_gic_rmask(i);
+			}
+		} else if (mips_cps_numcores(cl) !=3D 0) {
+			mips_cm_lock_other(cl, 0, 0, CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
+			for (i =3D 0; i < gic_shared_intrs; i++) {
+				change_gic_redir_pol(i, GIC_POL_ACTIVE_HIGH);
+				change_gic_redir_trig(i, GIC_TRIG_LEVEL);
+				write_gic_redir_rmask(i);
+			}
+			mips_cm_unlock_other();
+
+		} else {
+			pr_warn("No CPU cores on the cluster %d skip it\n", cl);
+		}
 	}
=20
 	return cpuhp_setup_state(CPUHP_AP_IRQ_MIPS_GIC_STARTING,
diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesa=
s-rzv2h.c
new file mode 100644
index 000000000000..fe2d29e91026
--- /dev/null
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -0,0 +1,513 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/V2H(P) ICU Driver
+ *
+ * Based on irq-renesas-rzg2l.c
+ *
+ * Copyright (C) 2024 Renesas Electronics Corporation.
+ *
+ * Author: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/spinlock.h>
+#include <linux/syscore_ops.h>
+
+/* DT "interrupts" indexes */
+#define ICU_IRQ_START				1
+#define ICU_IRQ_COUNT				16
+#define ICU_TINT_START				(ICU_IRQ_START + ICU_IRQ_COUNT)
+#define ICU_TINT_COUNT				32
+#define ICU_NUM_IRQ				(ICU_TINT_START + ICU_TINT_COUNT)
+
+/* Registers */
+#define ICU_NSCNT				0x00
+#define ICU_NSCLR				0x04
+#define ICU_NITSR				0x08
+#define ICU_ISCTR				0x10
+#define ICU_ISCLR				0x14
+#define ICU_IITSR				0x18
+#define ICU_TSCTR				0x20
+#define ICU_TSCLR				0x24
+#define ICU_TITSR(k)				(0x28 + (k) * 4)
+#define ICU_TSSR(k)				(0x30 + (k) * 4)
+
+/* NMI */
+#define ICU_NMI_EDGE_FALLING			0
+#define ICU_NMI_EDGE_RISING			1
+
+#define ICU_NSCLR_NCLR				BIT(0)
+
+/* IRQ */
+#define ICU_IRQ_LEVEL_LOW			0
+#define ICU_IRQ_EDGE_FALLING			1
+#define ICU_IRQ_EDGE_RISING			2
+#define ICU_IRQ_EDGE_BOTH			3
+
+#define ICU_IITSR_IITSEL_PREP(iitsel, n)	((iitsel) << ((n) * 2))
+#define ICU_IITSR_IITSEL_GET(iitsr, n)		(((iitsr) >> ((n) * 2)) & 0x03)
+#define ICU_IITSR_IITSEL_MASK(n)		ICU_IITSR_IITSEL_PREP(0x03, n)
+
+/* TINT */
+#define ICU_TINT_EDGE_RISING			0
+#define ICU_TINT_EDGE_FALLING			1
+#define ICU_TINT_LEVEL_HIGH			2
+#define ICU_TINT_LEVEL_LOW			3
+
+#define ICU_TSSR_K(tint_nr)			((tint_nr) / 4)
+#define ICU_TSSR_TSSEL_N(tint_nr)		((tint_nr) % 4)
+#define ICU_TSSR_TSSEL_PREP(tssel, n)		((tssel) << ((n) * 8))
+#define ICU_TSSR_TSSEL_MASK(n)			ICU_TSSR_TSSEL_PREP(0x7F, n)
+#define ICU_TSSR_TIEN(n)			(BIT(7) << ((n) * 8))
+
+#define ICU_TITSR_K(tint_nr)			((tint_nr) / 16)
+#define ICU_TITSR_TITSEL_N(tint_nr)		((tint_nr) % 16)
+#define ICU_TITSR_TITSEL_PREP(titsel, n)	ICU_IITSR_IITSEL_PREP(titsel, n)
+#define ICU_TITSR_TITSEL_MASK(n)		ICU_IITSR_IITSEL_MASK(n)
+#define ICU_TITSR_TITSEL_GET(titsr, n)		ICU_IITSR_IITSEL_GET(titsr, n)
+
+#define ICU_TINT_EXTRACT_HWIRQ(x)		FIELD_GET(GENMASK(15, 0), (x))
+#define ICU_TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
+#define ICU_PB5_TINT				0x55
+
+/**
+ * struct rzv2h_icu_priv - Interrupt Control Unit controller private data st=
ructure.
+ * @base:	Controller's base address
+ * @irqchip:	Pointer to struct irq_chip
+ * @fwspec:	IRQ firmware specific data
+ * @lock:	Lock to serialize access to hardware registers
+ */
+struct rzv2h_icu_priv {
+	void __iomem			*base;
+	const struct irq_chip		*irqchip;
+	struct irq_fwspec		fwspec[ICU_NUM_IRQ];
+	raw_spinlock_t			lock;
+};
+
+static inline struct rzv2h_icu_priv *irq_data_to_priv(struct irq_data *data)
+{
+	return data->domain->host_data;
+}
+
+static void rzv2h_icu_eoi(struct irq_data *d)
+{
+	struct rzv2h_icu_priv *priv =3D irq_data_to_priv(d);
+	unsigned int hw_irq =3D irqd_to_hwirq(d);
+	unsigned int tintirq_nr;
+	u32 bit;
+
+	scoped_guard(raw_spinlock, &priv->lock) {
+		if (hw_irq >=3D ICU_TINT_START) {
+			tintirq_nr =3D hw_irq - ICU_TINT_START;
+			bit =3D BIT(tintirq_nr);
+			if (!irqd_is_level_type(d))
+				writel_relaxed(bit, priv->base + ICU_TSCLR);
+		} else if (hw_irq >=3D ICU_IRQ_START) {
+			tintirq_nr =3D hw_irq - ICU_IRQ_START;
+			bit =3D BIT(tintirq_nr);
+			if (!irqd_is_level_type(d))
+				writel_relaxed(bit, priv->base + ICU_ISCLR);
+		} else {
+			writel_relaxed(ICU_NSCLR_NCLR, priv->base + ICU_NSCLR);
+		}
+	}
+
+	irq_chip_eoi_parent(d);
+}
+
+static void rzv2h_tint_irq_endisable(struct irq_data *d, bool enable)
+{
+	struct rzv2h_icu_priv *priv =3D irq_data_to_priv(d);
+	unsigned int hw_irq =3D irqd_to_hwirq(d);
+	u32 tint_nr, tssel_n, k, tssr;
+
+	if (hw_irq < ICU_TINT_START)
+		return;
+
+	tint_nr =3D hw_irq - ICU_TINT_START;
+	k =3D ICU_TSSR_K(tint_nr);
+	tssel_n =3D ICU_TSSR_TSSEL_N(tint_nr);
+
+	guard(raw_spinlock)(&priv->lock);
+	tssr =3D readl_relaxed(priv->base + ICU_TSSR(k));
+	if (enable)
+		tssr |=3D ICU_TSSR_TIEN(tssel_n);
+	else
+		tssr &=3D ~ICU_TSSR_TIEN(tssel_n);
+	writel_relaxed(tssr, priv->base + ICU_TSSR(k));
+}
+
+static void rzv2h_icu_irq_disable(struct irq_data *d)
+{
+	irq_chip_disable_parent(d);
+	rzv2h_tint_irq_endisable(d, false);
+}
+
+static void rzv2h_icu_irq_enable(struct irq_data *d)
+{
+	rzv2h_tint_irq_endisable(d, true);
+	irq_chip_enable_parent(d);
+}
+
+static int rzv2h_nmi_set_type(struct irq_data *d, unsigned int type)
+{
+	struct rzv2h_icu_priv *priv =3D irq_data_to_priv(d);
+	u32 sense;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_EDGE_FALLING:
+		sense =3D ICU_NMI_EDGE_FALLING;
+		break;
+
+	case IRQ_TYPE_EDGE_RISING:
+		sense =3D ICU_NMI_EDGE_RISING;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	writel_relaxed(sense, priv->base + ICU_NITSR);
+
+	return 0;
+}
+
+static void rzv2h_clear_irq_int(struct rzv2h_icu_priv *priv, unsigned int hw=
irq)
+{
+	unsigned int irq_nr =3D hwirq - ICU_IRQ_START;
+	u32 isctr, iitsr, iitsel;
+	u32 bit =3D BIT(irq_nr);
+
+	isctr =3D readl_relaxed(priv->base + ICU_ISCTR);
+	iitsr =3D readl_relaxed(priv->base + ICU_IITSR);
+	iitsel =3D ICU_IITSR_IITSEL_GET(iitsr, irq_nr);
+
+	/*
+	 * When level sensing is used, the interrupt flag gets automatically cleare=
d when the
+	 * interrupt signal is de-asserted by the source of the interrupt request, =
therefore clear
+	 * the interrupt only for edge triggered interrupts.
+	 */
+	if ((isctr & bit) && (iitsel !=3D ICU_IRQ_LEVEL_LOW))
+		writel_relaxed(bit, priv->base + ICU_ISCLR);
+}
+
+static int rzv2h_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct rzv2h_icu_priv *priv =3D irq_data_to_priv(d);
+	unsigned int hwirq =3D irqd_to_hwirq(d);
+	u32 irq_nr =3D hwirq - ICU_IRQ_START;
+	u32 iitsr, sense;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_LEVEL_LOW:
+		sense =3D ICU_IRQ_LEVEL_LOW;
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+		sense =3D ICU_IRQ_EDGE_FALLING;
+		break;
+
+	case IRQ_TYPE_EDGE_RISING:
+		sense =3D ICU_IRQ_EDGE_RISING;
+		break;
+
+	case IRQ_TYPE_EDGE_BOTH:
+		sense =3D ICU_IRQ_EDGE_BOTH;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	guard(raw_spinlock)(&priv->lock);
+	iitsr =3D readl_relaxed(priv->base + ICU_IITSR);
+	iitsr &=3D ~ICU_IITSR_IITSEL_MASK(irq_nr);
+	iitsr |=3D ICU_IITSR_IITSEL_PREP(sense, irq_nr);
+	rzv2h_clear_irq_int(priv, hwirq);
+	writel_relaxed(iitsr, priv->base + ICU_IITSR);
+
+	return 0;
+}
+
+static void rzv2h_clear_tint_int(struct rzv2h_icu_priv *priv, unsigned int h=
wirq)
+{
+	unsigned int tint_nr =3D hwirq - ICU_TINT_START;
+	int titsel_n =3D ICU_TITSR_TITSEL_N(tint_nr);
+	u32 tsctr, titsr, titsel;
+	u32 bit =3D BIT(tint_nr);
+	int k =3D tint_nr / 16;
+
+	tsctr =3D readl_relaxed(priv->base + ICU_TSCTR);
+	titsr =3D readl_relaxed(priv->base + ICU_TITSR(k));
+	titsel =3D ICU_TITSR_TITSEL_GET(titsr, titsel_n);
+
+	/*
+	 * Writing 1 to the corresponding flag from register ICU_TSCTR only has eff=
ect if
+	 * TSTATn =3D 1b and if it's a rising edge or a falling edge interrupt.
+	 */
+	if ((tsctr & bit) && ((titsel =3D=3D ICU_TINT_EDGE_RISING) ||
+			      (titsel =3D=3D ICU_TINT_EDGE_FALLING)))
+		writel_relaxed(bit, priv->base + ICU_TSCLR);
+}
+
+static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
+{
+	u32 titsr, titsr_k, titsel_n, tien;
+	struct rzv2h_icu_priv *priv;
+	u32 tssr, tssr_k, tssel_n;
+	unsigned int hwirq;
+	u32 tint, sense;
+	int tint_nr;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_LEVEL_LOW:
+		sense =3D ICU_TINT_LEVEL_LOW;
+		break;
+
+	case IRQ_TYPE_LEVEL_HIGH:
+		sense =3D ICU_TINT_LEVEL_HIGH;
+		break;
+
+	case IRQ_TYPE_EDGE_RISING:
+		sense =3D ICU_TINT_EDGE_RISING;
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+		sense =3D ICU_TINT_EDGE_FALLING;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	tint =3D (u32)(uintptr_t)irq_data_get_irq_chip_data(d);
+	if (tint > ICU_PB5_TINT)
+		return -EINVAL;
+
+	priv =3D irq_data_to_priv(d);
+	hwirq =3D irqd_to_hwirq(d);
+
+	tint_nr =3D hwirq - ICU_TINT_START;
+
+	tssr_k =3D ICU_TSSR_K(tint_nr);
+	tssel_n =3D ICU_TSSR_TSSEL_N(tint_nr);
+
+	titsr_k =3D ICU_TITSR_K(tint_nr);
+	titsel_n =3D ICU_TITSR_TITSEL_N(tint_nr);
+	tien =3D ICU_TSSR_TIEN(titsel_n);
+
+	guard(raw_spinlock)(&priv->lock);
+
+	tssr =3D readl_relaxed(priv->base + ICU_TSSR(tssr_k));
+	tssr &=3D ~(ICU_TSSR_TSSEL_MASK(tssel_n) | tien);
+	tssr |=3D ICU_TSSR_TSSEL_PREP(tint, tssel_n);
+
+	writel_relaxed(tssr, priv->base + ICU_TSSR(tssr_k));
+
+	titsr =3D readl_relaxed(priv->base + ICU_TITSR(titsr_k));
+	titsr &=3D ~ICU_TITSR_TITSEL_MASK(titsel_n);
+	titsr |=3D ICU_TITSR_TITSEL_PREP(sense, titsel_n);
+
+	writel_relaxed(titsr, priv->base + ICU_TITSR(titsr_k));
+
+	rzv2h_clear_tint_int(priv, hwirq);
+
+	writel_relaxed(tssr | tien, priv->base + ICU_TSSR(tssr_k));
+
+	return 0;
+}
+
+static int rzv2h_icu_set_type(struct irq_data *d, unsigned int type)
+{
+	unsigned int hw_irq =3D irqd_to_hwirq(d);
+	int ret;
+
+	if (hw_irq >=3D ICU_TINT_START)
+		ret =3D rzv2h_tint_set_type(d, type);
+	else if (hw_irq >=3D ICU_IRQ_START)
+		ret =3D rzv2h_irq_set_type(d, type);
+	else
+		ret =3D rzv2h_nmi_set_type(d, type);
+
+	if (ret)
+		return ret;
+
+	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
+}
+
+static const struct irq_chip rzv2h_icu_chip =3D {
+	.name			=3D "rzv2h-icu",
+	.irq_eoi		=3D rzv2h_icu_eoi,
+	.irq_mask		=3D irq_chip_mask_parent,
+	.irq_unmask		=3D irq_chip_unmask_parent,
+	.irq_disable		=3D rzv2h_icu_irq_disable,
+	.irq_enable		=3D rzv2h_icu_irq_enable,
+	.irq_get_irqchip_state	=3D irq_chip_get_parent_state,
+	.irq_set_irqchip_state	=3D irq_chip_set_parent_state,
+	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
+	.irq_set_type		=3D rzv2h_icu_set_type,
+	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
+	.flags			=3D IRQCHIP_SET_TYPE_MASKED,
+};
+
+static int rzv2h_icu_alloc(struct irq_domain *domain, unsigned int virq, uns=
igned int nr_irqs,
+			   void *arg)
+{
+	struct rzv2h_icu_priv *priv =3D domain->host_data;
+	unsigned long tint =3D 0;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret;
+
+	ret =3D irq_domain_translate_twocell(domain, arg, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	/*
+	 * For TINT interrupts the hwirq and TINT are encoded in
+	 * fwspec->param[0].
+	 * hwirq is embedded in bits 0-15.
+	 * TINT is embedded in bits 16-31.
+	 */
+	if (hwirq >=3D ICU_TINT_START) {
+		tint =3D ICU_TINT_EXTRACT_GPIOINT(hwirq);
+		hwirq =3D ICU_TINT_EXTRACT_HWIRQ(hwirq);
+
+		if (hwirq < ICU_TINT_START)
+			return -EINVAL;
+	}
+
+	if (hwirq > (ICU_NUM_IRQ - 1))
+		return -EINVAL;
+
+	ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq, priv->irqchip,
+					    (void *)(uintptr_t)tint);
+	if (ret)
+		return ret;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &priv->fwspec[hw=
irq]);
+}
+
+static const struct irq_domain_ops rzv2h_icu_domain_ops =3D {
+	.alloc		=3D rzv2h_icu_alloc,
+	.free		=3D irq_domain_free_irqs_common,
+	.translate	=3D irq_domain_translate_twocell,
+};
+
+static int rzv2h_icu_parse_interrupts(struct rzv2h_icu_priv *priv, struct de=
vice_node *np)
+{
+	struct of_phandle_args map;
+	unsigned int i;
+	int ret;
+
+	for (i =3D 0; i < ICU_NUM_IRQ; i++) {
+		ret =3D of_irq_parse_one(np, i, &map);
+		if (ret)
+			return ret;
+
+		of_phandle_args_to_fwspec(np, map.args, map.args_count, &priv->fwspec[i]);
+	}
+
+	return 0;
+}
+
+static int rzv2h_icu_init(struct device_node *node, struct device_node *pare=
nt)
+{
+	struct irq_domain *irq_domain, *parent_domain;
+	struct rzv2h_icu_priv *rzv2h_icu_data;
+	struct platform_device *pdev;
+	struct reset_control *resetn;
+	int ret;
+
+	pdev =3D of_find_device_by_node(node);
+	if (!pdev)
+		return -ENODEV;
+
+	parent_domain =3D irq_find_host(parent);
+	if (!parent_domain) {
+		dev_err(&pdev->dev, "cannot find parent domain\n");
+		ret =3D -ENODEV;
+		goto put_dev;
+	}
+
+	rzv2h_icu_data =3D devm_kzalloc(&pdev->dev, sizeof(*rzv2h_icu_data), GFP_KE=
RNEL);
+	if (!rzv2h_icu_data) {
+		ret =3D -ENOMEM;
+		goto put_dev;
+	}
+
+	rzv2h_icu_data->irqchip =3D &rzv2h_icu_chip;
+
+	rzv2h_icu_data->base =3D devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NU=
LL);
+	if (IS_ERR(rzv2h_icu_data->base)) {
+		ret =3D PTR_ERR(rzv2h_icu_data->base);
+		goto put_dev;
+	}
+
+	ret =3D rzv2h_icu_parse_interrupts(rzv2h_icu_data, node);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot parse interrupts: %d\n", ret);
+		goto put_dev;
+	}
+
+	resetn =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(resetn)) {
+		ret =3D PTR_ERR(resetn);
+		goto put_dev;
+	}
+
+	ret =3D reset_control_deassert(resetn);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to deassert resetn pin, %d\n", ret);
+		goto put_dev;
+	}
+
+	pm_runtime_enable(&pdev->dev);
+	ret =3D pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "pm_runtime_resume_and_get failed: %d\n", ret);
+		goto pm_disable;
+	}
+
+	raw_spin_lock_init(&rzv2h_icu_data->lock);
+
+	irq_domain =3D irq_domain_add_hierarchy(parent_domain, 0, ICU_NUM_IRQ, node,
+					      &rzv2h_icu_domain_ops, rzv2h_icu_data);
+	if (!irq_domain) {
+		dev_err(&pdev->dev, "failed to add irq domain\n");
+		ret =3D -ENOMEM;
+		goto pm_put;
+	}
+
+	/*
+	 * coccicheck complains about a missing put_device call before returning, b=
ut it's a false
+	 * positive. We still need &pdev->dev after successfully returning from thi=
s function.
+	 */
+	return 0;
+
+pm_put:
+	pm_runtime_put(&pdev->dev);
+pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	reset_control_assert(resetn);
+put_dev:
+	put_device(&pdev->dev);
+
+	return ret;
+}
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(rzv2h_icu)
+IRQCHIP_MATCH("renesas,r9a09g057-icu", rzv2h_icu_init)
+IRQCHIP_PLATFORM_DRIVER_END(rzv2h_icu)
+MODULE_AUTHOR("Fabrizio Castro <fabrizio.castro.jz@renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/V2H(P) ICU Driver");
diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-ris=
cv-aplic-main.c
index 900e72541db9..93e7c51f944a 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -207,7 +207,8 @@ static int aplic_probe(struct platform_device *pdev)
 	else
 		rc =3D aplic_direct_setup(dev, regs);
 	if (rc)
-		dev_err(dev, "failed to setup APLIC in %s mode\n", msi_mode ? "MSI" : "dir=
ect");
+		dev_err_probe(dev, rc, "failed to setup APLIC in %s mode\n",
+			      msi_mode ? "MSI" : "direct");
=20
 #ifdef CONFIG_ACPI
 	if (!acpi_disabled)
diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-risc=
v-aplic-msi.c
index 945bff28265c..fb8d1838609f 100644
--- a/drivers/irqchip/irq-riscv-aplic-msi.c
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -266,6 +266,9 @@ int aplic_msi_setup(struct device *dev, void __iomem *reg=
s)
 			if (msi_domain)
 				dev_set_msi_domain(dev, msi_domain);
 		}
+
+		if (!dev_get_msi_domain(dev))
+			return -EPROBE_DEFER;
 	}
=20
 	if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, &aplic_msi_templ=
ate,
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-p=
lic.c
index 2f6ef5c495bd..a3b199dd16ef 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -251,11 +251,10 @@ static int plic_irq_suspend(void)
=20
 	priv =3D per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
=20
-	for (i =3D 0; i < priv->nr_irqs; i++)
-		if (readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID))
-			__set_bit(i, priv->prio_save);
-		else
-			__clear_bit(i, priv->prio_save);
+	for (i =3D 0; i < priv->nr_irqs; i++) {
+		__assign_bit(i, priv->prio_save,
+			     readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID));
+	}
=20
 	for_each_cpu(cpu, cpu_present_mask) {
 		struct plic_handler *handler =3D per_cpu_ptr(&plic_handlers, cpu);
diff --git a/drivers/irqchip/irq-stm32mp-exti.c b/drivers/irqchip/irq-stm32mp=
-exti.c
index 33e0cfdea654..cb83d6cc6113 100644
--- a/drivers/irqchip/irq-stm32mp-exti.c
+++ b/drivers/irqchip/irq-stm32mp-exti.c
@@ -696,8 +696,7 @@ static int stm32mp_exti_probe(struct platform_device *pde=
v)
 	if (ret)
 		return ret;
=20
-	if (of_property_read_bool(np, "interrupts-extended"))
-		host_data->dt_has_irqs_desc =3D true;
+	host_data->dt_has_irqs_desc =3D of_property_present(np, "interrupts-extende=
d");
=20
 	return 0;
 }
diff --git a/drivers/irqchip/irq-thead-c900-aclint-sswi.c b/drivers/irqchip/i=
rq-thead-c900-aclint-sswi.c
new file mode 100644
index 000000000000..b0e366ade427
--- /dev/null
+++ b/drivers/irqchip/irq-thead-c900-aclint-sswi.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Inochi Amaoto <inochiama@gmail.com>
+ */
+
+#define pr_fmt(fmt) "thead-c900-aclint-sswi: " fmt
+#include <linux/cpu.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/pci.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <linux/string_choices.h>
+#include <asm/sbi.h>
+#include <asm/vendorid_list.h>
+
+#define THEAD_ACLINT_xSWI_REGISTER_SIZE		4
+
+#define THEAD_C9XX_CSR_SXSTATUS			0x5c0
+#define THEAD_C9XX_SXSTATUS_CLINTEE		BIT(17)
+
+static int sswi_ipi_virq __ro_after_init;
+static DEFINE_PER_CPU(void __iomem *, sswi_cpu_regs);
+
+static void thead_aclint_sswi_ipi_send(unsigned int cpu)
+{
+	writel_relaxed(0x1, per_cpu(sswi_cpu_regs, cpu));
+}
+
+static void thead_aclint_sswi_ipi_clear(void)
+{
+	writel_relaxed(0x0, this_cpu_read(sswi_cpu_regs));
+}
+
+static void thead_aclint_sswi_ipi_handle(struct irq_desc *desc)
+{
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+
+	csr_clear(CSR_IP, IE_SIE);
+	thead_aclint_sswi_ipi_clear();
+
+	ipi_mux_process();
+
+	chained_irq_exit(chip, desc);
+}
+
+static int thead_aclint_sswi_starting_cpu(unsigned int cpu)
+{
+	enable_percpu_irq(sswi_ipi_virq, irq_get_trigger_type(sswi_ipi_virq));
+
+	return 0;
+}
+
+static int thead_aclint_sswi_dying_cpu(unsigned int cpu)
+{
+	thead_aclint_sswi_ipi_clear();
+
+	disable_percpu_irq(sswi_ipi_virq);
+
+	return 0;
+}
+
+static int __init thead_aclint_sswi_parse_irq(struct fwnode_handle *fwnode,
+					      void __iomem *reg)
+{
+	struct of_phandle_args parent;
+	unsigned long hartid;
+	u32 contexts, i;
+	int rc, cpu;
+
+	contexts =3D of_irq_count(to_of_node(fwnode));
+	if (!(contexts)) {
+		pr_err("%pfwP: no ACLINT SSWI context available\n", fwnode);
+		return -EINVAL;
+	}
+
+	for (i =3D 0; i < contexts; i++) {
+		rc =3D of_irq_parse_one(to_of_node(fwnode), i, &parent);
+		if (rc)
+			return rc;
+
+		rc =3D riscv_of_parent_hartid(parent.np, &hartid);
+		if (rc)
+			return rc;
+
+		if (parent.args[0] !=3D RV_IRQ_SOFT)
+			return -ENOTSUPP;
+
+		cpu =3D riscv_hartid_to_cpuid(hartid);
+
+		per_cpu(sswi_cpu_regs, cpu) =3D reg + i * THEAD_ACLINT_xSWI_REGISTER_SIZE;
+	}
+
+	pr_info("%pfwP: register %u CPU%s\n", fwnode, contexts, str_plural(contexts=
));
+
+	return 0;
+}
+
+static int __init thead_aclint_sswi_probe(struct fwnode_handle *fwnode)
+{
+	struct irq_domain *domain;
+	void __iomem *reg;
+	int virq, rc;
+
+	/* If it is T-HEAD CPU, check whether SSWI is enabled */
+	if (riscv_cached_mvendorid(0) =3D=3D THEAD_VENDOR_ID &&
+	    !(csr_read(THEAD_C9XX_CSR_SXSTATUS) & THEAD_C9XX_SXSTATUS_CLINTEE))
+		return -ENOTSUPP;
+
+	if (!is_of_node(fwnode))
+		return -EINVAL;
+
+	reg =3D of_iomap(to_of_node(fwnode), 0);
+	if (!reg)
+		return -ENOMEM;
+
+	/* Parse SSWI setting */
+	rc =3D thead_aclint_sswi_parse_irq(fwnode, reg);
+	if (rc < 0)
+		return rc;
+
+	/* If mulitple SSWI devices are present, do not register irq again */
+	if (sswi_ipi_virq)
+		return 0;
+
+	/* Find riscv intc domain and create IPI irq mapping */
+	domain =3D irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY=
);
+	if (!domain) {
+		pr_err("%pfwP: Failed to find INTC domain\n", fwnode);
+		return -ENOENT;
+	}
+
+	sswi_ipi_virq =3D irq_create_mapping(domain, RV_IRQ_SOFT);
+	if (!sswi_ipi_virq) {
+		pr_err("unable to create ACLINT SSWI IRQ mapping\n");
+		return -ENOMEM;
+	}
+
+	/* Register SSWI irq and handler */
+	virq =3D ipi_mux_create(BITS_PER_BYTE, thead_aclint_sswi_ipi_send);
+	if (virq <=3D 0) {
+		pr_err("unable to create muxed IPIs\n");
+		irq_dispose_mapping(sswi_ipi_virq);
+		return virq < 0 ? virq : -ENOMEM;
+	}
+
+	irq_set_chained_handler(sswi_ipi_virq, thead_aclint_sswi_ipi_handle);
+
+	cpuhp_setup_state(CPUHP_AP_IRQ_THEAD_ACLINT_SSWI_STARTING,
+			  "irqchip/thead-aclint-sswi:starting",
+			  thead_aclint_sswi_starting_cpu,
+			  thead_aclint_sswi_dying_cpu);
+
+	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
+
+	/* Announce that SSWI is providing IPIs */
+	pr_info("providing IPIs using THEAD ACLINT SSWI\n");
+
+	return 0;
+}
+
+static int __init thead_aclint_sswi_early_probe(struct device_node *node,
+						struct device_node *parent)
+{
+	return thead_aclint_sswi_probe(&node->fwnode);
+}
+IRQCHIP_DECLARE(thead_aclint_sswi, "thead,c900-aclint-sswi", thead_aclint_ss=
wi_early_probe);
diff --git a/drivers/net/ethernet/3com/3c59x.c b/drivers/net/ethernet/3com/3c=
59x.c
index 082388bb6169..790270912913 100644
--- a/drivers/net/ethernet/3com/3c59x.c
+++ b/drivers/net/ethernet/3com/3c59x.c
@@ -1302,7 +1302,7 @@ static int vortex_probe1(struct device *gendev, void __=
iomem *ioaddr, int irq,
 	if (print_info)
 		pr_cont(", IRQ %d\n", dev->irq);
 	/* Tell them about an invalid IRQ. */
-	if (dev->irq <=3D 0 || dev->irq >=3D nr_irqs)
+	if (dev->irq <=3D 0 || dev->irq >=3D irq_get_nr_irqs())
 		pr_warn(" *** Warning: IRQ %d is unlikely to work! ***\n",
 			dev->irq);
=20
diff --git a/drivers/net/hamradio/baycom_ser_fdx.c b/drivers/net/hamradio/bay=
com_ser_fdx.c
index 646f605e358f..799f8ece7824 100644
--- a/drivers/net/hamradio/baycom_ser_fdx.c
+++ b/drivers/net/hamradio/baycom_ser_fdx.c
@@ -373,6 +373,7 @@ static enum uart ser12_check_uart(unsigned int iobase)
=20
 static int ser12_open(struct net_device *dev)
 {
+	const unsigned int nr_irqs =3D irq_get_nr_irqs();
 	struct baycom_state *bc =3D netdev_priv(dev);
 	enum uart u;
=20
diff --git a/drivers/net/hamradio/scc.c b/drivers/net/hamradio/scc.c
index a9184a78650b..c71e52249289 100644
--- a/drivers/net/hamradio/scc.c
+++ b/drivers/net/hamradio/scc.c
@@ -1460,6 +1460,7 @@ scc_start_calibrate(struct scc_channel *scc, int durati=
on, unsigned char pattern
=20
 static void z8530_init(void)
 {
+	const unsigned int nr_irqs =3D irq_get_nr_irqs();
 	struct scc_channel *scc;
 	int chip, k;
 	unsigned long flags;
@@ -1735,7 +1736,7 @@ static int scc_net_siocdevprivate(struct net_device *de=
v,
=20
 			if (hwcfg.irq =3D=3D 2) hwcfg.irq =3D 9;
=20
-			if (hwcfg.irq < 0 || hwcfg.irq >=3D nr_irqs)
+			if (hwcfg.irq < 0 || hwcfg.irq >=3D irq_get_nr_irqs())
 				return -EINVAL;
 			=09
 			if (!Ivec[hwcfg.irq].used && hwcfg.irq)
@@ -2117,6 +2118,7 @@ static int __init scc_init_driver (void)
=20
 static void __exit scc_cleanup_driver(void)
 {
+	const unsigned int nr_irqs =3D irq_get_nr_irqs();
 	io_port ctrl;
 	int k;
 	struct scc_channel *scc;
diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index a0fb330b8df5..4276f868cd91 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -295,7 +295,7 @@ CMD_INC_RESID(struct scsi_cmnd *cmd, int inc)
 #else
 #define IRQ_MIN 9
 #if defined(__PPC)
-#define IRQ_MAX (nr_irqs-1)
+#define IRQ_MAX (irq_get_nr_irqs()-1)
 #else
 #define IRQ_MAX 12
 #endif
diff --git a/drivers/sh/intc/virq-debugfs.c b/drivers/sh/intc/virq-debugfs.c
index 939915a07d99..5dd8febe6da5 100644
--- a/drivers/sh/intc/virq-debugfs.c
+++ b/drivers/sh/intc/virq-debugfs.c
@@ -18,6 +18,7 @@
=20
 static int intc_irq_xlate_show(struct seq_file *m, void *priv)
 {
+	const unsigned int nr_irqs =3D irq_get_nr_irqs();
 	int i;
=20
 	seq_printf(m, "%-5s  %-7s  %-15s\n", "irq", "enum", "chip name");
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 5d94c3f31494..9f7fe02310b9 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -347,6 +347,7 @@ config ARCH_R9A09G011
=20
 config ARCH_R9A09G057
 	bool "ARM64 Platform support for RZ/V2H(P)"
+	select RENESAS_RZV2H_ICU
 	help
 	  This enables support for the Renesas RZ/V2H(P) SoC variants.
=20
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/82=
50_port.c
index 3509af7dc52b..0b886c0924da 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3176,7 +3176,7 @@ static void serial8250_config_port(struct uart_port *po=
rt, int flags)
 static int
 serial8250_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
-	if (ser->irq >=3D nr_irqs || ser->irq < 0 ||
+	if (ser->irq >=3D irq_get_nr_irqs() || ser->irq < 0 ||
 	    ser->baud_base < 9600 || ser->type < PORT_UNKNOWN ||
 	    ser->type >=3D ARRAY_SIZE(uart_config) || ser->type =3D=3D PORT_CIRRUS =
||
 	    ser->type =3D=3D PORT_STARTECH)
diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index eabbf8afc9b5..c3a7fad02ac9 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -499,7 +499,7 @@ static int pl010_verify_port(struct uart_port *port, stru=
ct serial_struct *ser)
 	int ret =3D 0;
 	if (ser->type !=3D PORT_UNKNOWN && ser->type !=3D PORT_AMBA)
 		ret =3D -EINVAL;
-	if (ser->irq < 0 || ser->irq >=3D nr_irqs)
+	if (ser->irq < 0 || ser->irq >=3D irq_get_nr_irqs())
 		ret =3D -EINVAL;
 	if (ser->baud_base < 9600)
 		ret =3D -EINVAL;
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7d0134ecd82f..1c60850030b1 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2202,7 +2202,7 @@ static int pl011_verify_port(struct uart_port *port, st=
ruct serial_struct *ser)
=20
 	if (ser->type !=3D PORT_UNKNOWN && ser->type !=3D PORT_AMBA)
 		ret =3D -EINVAL;
-	if (ser->irq < 0 || ser->irq >=3D nr_irqs)
+	if (ser->irq < 0 || ser->irq >=3D irq_get_nr_irqs())
 		ret =3D -EINVAL;
 	if (ser->baud_base < 9600)
 		ret =3D -EINVAL;
diff --git a/drivers/tty/serial/cpm_uart.c b/drivers/tty/serial/cpm_uart.c
index a927478f581d..6eb8625de435 100644
--- a/drivers/tty/serial/cpm_uart.c
+++ b/drivers/tty/serial/cpm_uart.c
@@ -631,7 +631,7 @@ static int cpm_uart_verify_port(struct uart_port *port,
=20
 	if (ser->type !=3D PORT_UNKNOWN && ser->type !=3D PORT_CPM)
 		ret =3D -EINVAL;
-	if (ser->irq < 0 || ser->irq >=3D nr_irqs)
+	if (ser->irq < 0 || ser->irq >=3D irq_get_nr_irqs())
 		ret =3D -EINVAL;
 	if (ser->baud_base < 9600)
 		ret =3D -EINVAL;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_cor=
e.c
index d94d73e45fb6..74fa02b23772 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -919,7 +919,7 @@ static int uart_set_info(struct tty_struct *tty, struct t=
ty_port *port,
 	if (uport->ops->verify_port)
 		retval =3D uport->ops->verify_port(uport, new_info);
=20
-	if ((new_info->irq >=3D nr_irqs) || (new_info->irq < 0) ||
+	if ((new_info->irq >=3D irq_get_nr_irqs()) || (new_info->irq < 0) ||
 	    (new_info->baud_base < 9600))
 		retval =3D -EINVAL;
=20
diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 53bb8c5ef499..4eed909468ff 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1045,7 +1045,7 @@ static int qe_uart_verify_port(struct uart_port *port,
 	if (ser->type !=3D PORT_UNKNOWN && ser->type !=3D PORT_CPM)
 		return -EINVAL;
=20
-	if (ser->irq < 0 || ser->irq >=3D nr_irqs)
+	if (ser->irq < 0 || ser->irq >=3D irq_get_nr_irqs())
 		return -EINVAL;
=20
 	if (ser->baud_base < 9600)
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_bas=
e.c
index 81effbd53dc5..985e155ebe4b 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -411,7 +411,7 @@ static evtchn_port_t evtchn_from_irq(unsigned int irq)
 {
 	const struct irq_info *info =3D NULL;
=20
-	if (likely(irq < nr_irqs))
+	if (likely(irq < irq_get_nr_irqs()))
 		info =3D info_for_irq(irq);
 	if (!info)
 		return 0;
diff --git a/fs/proc/interrupts.c b/fs/proc/interrupts.c
index cb0edc7cbf09..714a22ded8a8 100644
--- a/fs/proc/interrupts.c
+++ b/fs/proc/interrupts.c
@@ -11,13 +11,13 @@
  */
 static void *int_seq_start(struct seq_file *f, loff_t *pos)
 {
-	return (*pos <=3D nr_irqs) ? pos : NULL;
+	return *pos <=3D irq_get_nr_irqs() ? pos : NULL;
 }
=20
 static void *int_seq_next(struct seq_file *f, void *v, loff_t *pos)
 {
 	(*pos)++;
-	if (*pos > nr_irqs)
+	if (*pos > irq_get_nr_irqs())
 		return NULL;
 	return pos;
 }
diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index da60956b2915..8b444e862319 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -76,7 +76,7 @@ static void show_all_irqs(struct seq_file *p)
 		seq_put_decimal_ull(p, " ", kstat_irqs_usr(i));
 		next =3D i + 1;
 	}
-	show_irq_gap(p, nr_irqs - next);
+	show_irq_gap(p, irq_get_nr_irqs() - next);
 }
=20
 static int show_stat(struct seq_file *p, void *v)
@@ -196,7 +196,7 @@ static int stat_open(struct inode *inode, struct file *fi=
le)
 	unsigned int size =3D 1024 + 128 * num_online_cpus();
=20
 	/* minimum size to display an interrupt count : 2 bytes */
-	size +=3D 2 * nr_irqs;
+	size +=3D 2 * irq_get_nr_irqs();
 	return single_open_size(file, show_stat, NULL, size);
 }
=20
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 2361ed4d2b15..799052249c7b 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -147,6 +147,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_EIOINTC_STARTING,
 	CPUHP_AP_IRQ_AVECINTC_STARTING,
 	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
+	CPUHP_AP_IRQ_THEAD_ACLINT_SSWI_STARTING,
 	CPUHP_AP_IRQ_RISCV_IMSIC_STARTING,
 	CPUHP_AP_IRQ_RISCV_SBI_IPI_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 457151f9f263..8cd9327e4e78 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -616,6 +616,53 @@ extern void __raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq(unsigned int nr);
=20
+/*
+ * With forced-threaded interrupts enabled a raised softirq is deferred to
+ * ksoftirqd unless it can be handled within the threaded interrupt. This
+ * affects timer_list timers and hrtimers which are explicitly marked with
+ * HRTIMER_MODE_SOFT.
+ * With PREEMPT_RT enabled more hrtimers are moved to softirq for processing
+ * which includes all timers which are not explicitly marked HRTIMER_MODE_HA=
RD.
+ * Userspace controlled timers (like the clock_nanosleep() interface) is div=
ided
+ * into two categories: Tasks with elevated scheduling policy including
+ * SCHED_{FIFO|RR|DL} and the remaining scheduling policy. The tasks with the
+ * elevated scheduling policy are woken up directly from the HARDIRQ while a=
ll
+ * other wake ups are delayed to softirq and so to ksoftirqd.
+ *
+ * The ksoftirqd runs at SCHED_OTHER policy at which it should remain since =
it
+ * handles the softirq in an overloaded situation (not handled everything
+ * within its last run).
+ * If the timers are handled at SCHED_OTHER priority then they competes with=
 all
+ * other SCHED_OTHER tasks for CPU resources are possibly delayed.
+ * Moving timers softirqs to a low priority SCHED_FIFO thread instead ensures
+ * that timer are performed before scheduling any SCHED_OTHER thread.
+ */
+DECLARE_PER_CPU(struct task_struct *, ktimerd);
+DECLARE_PER_CPU(unsigned long, pending_timer_softirq);
+void raise_ktimers_thread(unsigned int nr);
+
+static inline unsigned int local_timers_pending_force_th(void)
+{
+	return __this_cpu_read(pending_timer_softirq);
+}
+
+static inline void raise_timer_softirq(unsigned int nr)
+{
+	lockdep_assert_in_irq();
+	if (force_irqthreads())
+		raise_ktimers_thread(nr);
+	else
+		__raise_softirq_irqoff(nr);
+}
+
+static inline unsigned int local_timers_pending(void)
+{
+	if (force_irqthreads())
+		return local_timers_pending_force_th();
+	else
+		return local_softirq_pending();
+}
+
 DECLARE_PER_CPU(struct task_struct *, ksoftirqd);
=20
 static inline struct task_struct *this_cpu_ksoftirqd(void)
diff --git a/include/linux/irqnr.h b/include/linux/irqnr.h
index 3496baa0b07f..e97206c721a0 100644
--- a/include/linux/irqnr.h
+++ b/include/linux/irqnr.h
@@ -5,30 +5,36 @@
 #include <uapi/linux/irqnr.h>
=20
=20
-extern int nr_irqs;
+unsigned int irq_get_nr_irqs(void) __pure;
+unsigned int irq_set_nr_irqs(unsigned int nr);
 extern struct irq_desc *irq_to_desc(unsigned int irq);
 unsigned int irq_get_next_irq(unsigned int offset);
=20
-# define for_each_irq_desc(irq, desc)					\
-	for (irq =3D 0, desc =3D irq_to_desc(irq); irq < nr_irqs;		\
-	     irq++, desc =3D irq_to_desc(irq))				\
-		if (!desc)						\
-			;						\
-		else
-
+#define for_each_irq_desc(irq, desc)                                      \
+	for (unsigned int __nr_irqs__ =3D irq_get_nr_irqs(); __nr_irqs__;   \
+	     __nr_irqs__ =3D 0)                                             \
+		for (irq =3D 0, desc =3D irq_to_desc(irq); irq < __nr_irqs__; \
+		     irq++, desc =3D irq_to_desc(irq))                      \
+			if (!desc)                                        \
+				;                                         \
+			else
=20
 # define for_each_irq_desc_reverse(irq, desc)				\
-	for (irq =3D nr_irqs - 1, desc =3D irq_to_desc(irq); irq >=3D 0;	\
-	     irq--, desc =3D irq_to_desc(irq))				\
+	for (irq =3D irq_get_nr_irqs() - 1, desc =3D irq_to_desc(irq);	\
+	     irq >=3D 0; irq--, desc =3D irq_to_desc(irq))			\
 		if (!desc)						\
 			;						\
 		else
=20
-# define for_each_active_irq(irq)			\
-	for (irq =3D irq_get_next_irq(0); irq < nr_irqs;	\
-	     irq =3D irq_get_next_irq(irq + 1))
+#define for_each_active_irq(irq)                                        \
+	for (unsigned int __nr_irqs__ =3D irq_get_nr_irqs(); __nr_irqs__; \
+	     __nr_irqs__ =3D 0)                                           \
+		for (irq =3D irq_get_next_irq(0); irq < __nr_irqs__;      \
+		     irq =3D irq_get_next_irq(irq + 1))
=20
-#define for_each_irq_nr(irq)                   \
-       for (irq =3D 0; irq < nr_irqs; irq++)
+#define for_each_irq_nr(irq)                                            \
+	for (unsigned int __nr_irqs__ =3D irq_get_nr_irqs(); __nr_irqs__; \
+	     __nr_irqs__ =3D 0)                                           \
+		for (irq =3D 0; irq < __nr_irqs__; irq++)
=20
 #endif
diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index b3e98668f4dd..eb16a58e0322 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -141,9 +141,8 @@ void devm_free_irq(struct device *dev, unsigned int irq, =
void *dev_id)
 {
 	struct irq_devres match_data =3D { irq, dev_id };
=20
-	WARN_ON(devres_destroy(dev, devm_irq_release, devm_irq_match,
+	WARN_ON(devres_release(dev, devm_irq_release, devm_irq_match,
 			       &match_data));
-	free_irq(irq, dev_id);
 }
 EXPORT_SYMBOL(devm_free_irq);
=20
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 1dee88ba0ae4..0253e77fcd9a 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -15,6 +15,7 @@
 #include <linux/maple_tree.h>
 #include <linux/irqdomain.h>
 #include <linux/sysfs.h>
+#include <linux/string_choices.h>
=20
 #include "internals.h"
=20
@@ -138,8 +139,30 @@ static void desc_set_defaults(unsigned int irq, struct i=
rq_desc *desc, int node,
 	desc_smp_init(desc, node, affinity);
 }
=20
-int nr_irqs =3D NR_IRQS;
-EXPORT_SYMBOL_GPL(nr_irqs);
+static unsigned int nr_irqs =3D NR_IRQS;
+
+/**
+ * irq_get_nr_irqs() - Number of interrupts supported by the system.
+ */
+unsigned int irq_get_nr_irqs(void)
+{
+	return nr_irqs;
+}
+EXPORT_SYMBOL_GPL(irq_get_nr_irqs);
+
+/**
+ * irq_set_nr_irqs() - Set the number of interrupts supported by the system.
+ * @nr: New number of interrupts.
+ *
+ * Return: @nr.
+ */
+unsigned int irq_set_nr_irqs(unsigned int nr)
+{
+	nr_irqs =3D nr;
+
+	return nr;
+}
+EXPORT_SYMBOL_GPL(irq_set_nr_irqs);
=20
 static DEFINE_MUTEX(sparse_irq_lock);
 static struct maple_tree sparse_irqs =3D MTREE_INIT_EXT(sparse_irqs,
@@ -298,8 +321,7 @@ static ssize_t wakeup_show(struct kobject *kobj,
 	ssize_t ret =3D 0;
=20
 	raw_spin_lock_irq(&desc->lock);
-	ret =3D sprintf(buf, "%s\n",
-		      irqd_is_wakeup_set(&desc->irq_data) ? "enabled" : "disabled");
+	ret =3D sprintf(buf, "%s\n", str_enabled_disabled(irqd_is_wakeup_set(&desc-=
>irq_data)));
 	raw_spin_unlock_irq(&desc->lock);
=20
 	return ret;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index e0bff21f30e0..ec6d8e72d980 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1225,7 +1225,7 @@ int irq_domain_alloc_descs(int virq, unsigned int cnt, =
irq_hw_number_t hwirq,
 		virq =3D __irq_alloc_descs(virq, virq, cnt, node, THIS_MODULE,
 					 affinity);
 	} else {
-		hint =3D hwirq % nr_irqs;
+		hint =3D hwirq % irq_get_nr_irqs();
 		if (hint =3D=3D 0)
 			hint++;
 		virq =3D __irq_alloc_descs(-1, hint, cnt, node, THIS_MODULE,
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 9081ada81c3d..f36c33bd2da4 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -457,11 +457,12 @@ int __weak arch_show_interrupts(struct seq_file *p, int=
 prec)
 }
=20
 #ifndef ACTUAL_NR_IRQS
-# define ACTUAL_NR_IRQS nr_irqs
+# define ACTUAL_NR_IRQS irq_get_nr_irqs()
 #endif
=20
 int show_interrupts(struct seq_file *p, void *v)
 {
+	const unsigned int nr_irqs =3D irq_get_nr_irqs();
 	static int prec;
=20
 	int i =3D *(loff_t *) v, j;
@@ -494,9 +495,12 @@ int show_interrupts(struct seq_file *p, void *v)
 	if (!desc->action || irq_desc_is_chained(desc) || !desc->kstat_irqs)
 		goto outsparse;
=20
-	seq_printf(p, "%*d: ", prec, i);
-	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, j=
) : 0);
+	seq_printf(p, "%*d:", prec, i);
+	for_each_online_cpu(j) {
+		unsigned int cnt =3D desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, j) =
: 0;
+
+		seq_put_decimal_ull_width(p, " ", cnt, 10);
+	}
=20
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	if (desc->irq_data.chip) {
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index bb75dbf5c800..270c31a1e857 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2440,6 +2440,14 @@ static int rcutorture_booster_init(unsigned int cpu)
 		WARN_ON_ONCE(!t);
 		sp.sched_priority =3D 2;
 		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
+#ifdef CONFIG_IRQ_FORCED_THREADING
+		if (force_irqthreads()) {
+			t =3D per_cpu(ktimerd, cpu);
+			WARN_ON_ONCE(!t);
+			sp.sched_priority =3D 2;
+			sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
+		}
+#endif
 	}
=20
 	/* Don't allow time recalculation while creating a new task. */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index d082e7840f88..7b525c904462 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -624,6 +624,24 @@ static inline void tick_irq_exit(void)
 #endif
 }
=20
+#ifdef CONFIG_IRQ_FORCED_THREADING
+DEFINE_PER_CPU(struct task_struct *, ktimerd);
+DEFINE_PER_CPU(unsigned long, pending_timer_softirq);
+
+static void wake_timersd(void)
+{
+	struct task_struct *tsk =3D __this_cpu_read(ktimerd);
+
+	if (tsk)
+		wake_up_process(tsk);
+}
+
+#else
+
+static inline void wake_timersd(void) { }
+
+#endif
+
 static inline void __irq_exit_rcu(void)
 {
 #ifndef __ARCH_IRQ_EXIT_IRQS_DISABLED
@@ -636,6 +654,10 @@ static inline void __irq_exit_rcu(void)
 	if (!in_interrupt() && local_softirq_pending())
 		invoke_softirq();
=20
+	if (IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) && force_irqthreads() &&
+	    local_timers_pending_force_th() && !(in_nmi() | in_hardirq()))
+		wake_timersd();
+
 	tick_irq_exit();
 }
=20
@@ -971,12 +993,57 @@ static struct smp_hotplug_thread softirq_threads =3D {
 	.thread_comm		=3D "ksoftirqd/%u",
 };
=20
+#ifdef CONFIG_IRQ_FORCED_THREADING
+static void ktimerd_setup(unsigned int cpu)
+{
+	/* Above SCHED_NORMAL to handle timers before regular tasks. */
+	sched_set_fifo_low(current);
+}
+
+static int ktimerd_should_run(unsigned int cpu)
+{
+	return local_timers_pending_force_th();
+}
+
+void raise_ktimers_thread(unsigned int nr)
+{
+	trace_softirq_raise(nr);
+	__this_cpu_or(pending_timer_softirq, BIT(nr));
+}
+
+static void run_ktimerd(unsigned int cpu)
+{
+	unsigned int timer_si;
+
+	ksoftirqd_run_begin();
+
+	timer_si =3D local_timers_pending_force_th();
+	__this_cpu_write(pending_timer_softirq, 0);
+	or_softirq_pending(timer_si);
+
+	__do_softirq();
+
+	ksoftirqd_run_end();
+}
+
+static struct smp_hotplug_thread timer_thread =3D {
+	.store			=3D &ktimerd,
+	.setup			=3D ktimerd_setup,
+	.thread_should_run	=3D ktimerd_should_run,
+	.thread_fn		=3D run_ktimerd,
+	.thread_comm		=3D "ktimers/%u",
+};
+#endif
+
 static __init int spawn_ksoftirqd(void)
 {
 	cpuhp_setup_state_nocalls(CPUHP_SOFTIRQ_DEAD, "softirq:dead", NULL,
 				  takeover_tasklets);
 	BUG_ON(smpboot_register_percpu_thread(&softirq_threads));
-
+#ifdef CONFIG_IRQ_FORCED_THREADING
+	if (force_irqthreads())
+		BUG_ON(smpboot_register_percpu_thread(&timer_thread));
+#endif
 	return 0;
 }
 early_initcall(spawn_ksoftirqd);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index cddcd08ea827..d9911516e743 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1811,7 +1811,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	if (!ktime_before(now, cpu_base->softirq_expires_next)) {
 		cpu_base->softirq_expires_next =3D KTIME_MAX;
 		cpu_base->softirq_activated =3D 1;
-		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+		raise_timer_softirq(HRTIMER_SOFTIRQ);
 	}
=20
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
@@ -1906,7 +1906,7 @@ void hrtimer_run_queues(void)
 	if (!ktime_before(now, cpu_base->softirq_expires_next)) {
 		cpu_base->softirq_expires_next =3D KTIME_MAX;
 		cpu_base->softirq_activated =3D 1;
-		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+		raise_timer_softirq(HRTIMER_SOFTIRQ);
 	}
=20
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 753a184c7090..976a212cca2e 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -859,7 +859,7 @@ static void tick_nohz_restart(struct tick_sched *ts, ktim=
e_t now)
=20
 static inline bool local_timer_softirq_pending(void)
 {
-	return local_softirq_pending() & BIT(TIMER_SOFTIRQ);
+	return local_timers_pending() & BIT(TIMER_SOFTIRQ);
 }
=20
 /*
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 0fc9d066a7be..06f0bc1db6d9 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2499,7 +2499,7 @@ static void run_local_timers(void)
 		 */
 		if (time_after_eq(jiffies, READ_ONCE(base->next_expiry)) ||
 		    (i =3D=3D BASE_DEF && tmigr_requires_handle_remote())) {
-			raise_softirq(TIMER_SOFTIRQ);
+			raise_timer_softirq(TIMER_SOFTIRQ);
 			return;
 		}
 	}


