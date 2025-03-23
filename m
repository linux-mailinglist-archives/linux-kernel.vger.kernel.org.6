Return-Path: <linux-kernel+bounces-572918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBDAA6D06E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C51B7A5F8F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 17:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2757019005D;
	Sun, 23 Mar 2025 17:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PjspjUf2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wRLlvWhq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D264F18F2DF
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742752301; cv=none; b=HGyXmF8vWhCGl9n+kgRKMLK3/HnMmxfmBAPmd6f402h9h7A/+5M/mHDJGK6gHx63CdRWawvASaG90bPj5DtrthThzfZcqbq6JlTFGiIA5p+KWzVq1RtP5Gpks6HBWdEF9qv3fmjaqO34oI8+xGQWhPfFVVfibns0WOSjQpNp+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742752301; c=relaxed/simple;
	bh=Szji1nmZPrw9ZDBxu8bqUYKfYabr1EJwAX/y7LdxkOw=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=ZjvdLZsT4GKrk95YAfkdmzo9EOPJ994+q1pOO7Bg3g/gjCcxBNa5BbZZ6fvH/TGgUdhKv5UBpEo8l8QqPVR6wLibjkeOE6S8VGts007euH1rVcBVNRDPmJJoWQdxH0Yc/8jlz5uzqMu13Xl6A6def40S4VhV7kuM3U+aYYVDnJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PjspjUf2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wRLlvWhq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742752294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=pX10J072Za+kzeSkt7pKeMaAy2GfQp1CBTS7AP67uqs=;
	b=PjspjUf2za3+J3rOUcetq5fh9tOST218wL1Ji9i013wbSEQ1mBzm0ll7LIQ8P9m56vQA8C
	18WIQX4gusOOkFCCGaqGMTc5MBnapbnsbGdCGOuooK5qDsCZgxJmPnAldQpVL7uiUKtlNJ
	5ffkmzyRe5GPS8aLZ9AJdnBJPEMEM+aiUNywHILdG80cjy6peLd9hpRumerlJefaIpsaFp
	qigDcui9XQa/zor2D1Y1M1VbB2mVgoZ2X5eGQRdZPthRtgveh0CkYW8AI22mJqQDmm2Kaq
	VPwTNukYrMlGEWDGjKiDgPGTus17Nazvd1Jzzc/cgVvyNl/FBCLfkZ90+uFiiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742752294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=pX10J072Za+kzeSkt7pKeMaAy2GfQp1CBTS7AP67uqs=;
	b=wRLlvWhqUna6kjcvDsUgD+2fs+wrBV8TvGvni27l27AOeHmV4wVpu2HwxmmPNijLAswGmj
	ZBbMrbJ0QDiFaBBQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/drivers for v6.15-rc1
References: <174275225552.1561082.4969731002775597670.tglx@xen13>
Message-ID: <174275225728.1561082.5792124494264581151.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 23 Mar 2025 18:51:34 +0100 (CET)

Linus,

please pull the latest irq/drivers branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-drivers-2025=
-03-23

up to:  7db5fd6b751f: irqchip/imx-irqsteer: Support up to 960 input interrupts


Updates for interrupt chip drivers:

  - Support for hard indices on RISC-V. The hart index identifies a hart
    (core) within a specific interrupt domain in RISC-V's Priviledged
    Architecture.

  - Rework of the RISC-V MSI driver.

    This moves the driver over to the generic MSI library and solves the
    affinity problem of unmaskable PCI/MSI controllers. Unmaskable PCI/MSI
    controllers are prone to lose interrupts when the MSI message is
    updated to change the affinity because the message write consists of
    three 32-bit subsequent writes, which update address and data. As these
    writes are non-atomic versus the device raising an interrupt, the
    device can observe a half written update and issue an interrupt on the
    wrong vector. This is mitiated by a carefully orchestrated step by step
    update and the observation of an eventually pending interrupt on the
    CPU which issues the update. The algorithm follows the well established
    method of the X86 MSI driver.

  - A new driver for the RISC-V Sophgo SG2042 MSI controller

  - Overhaul of the Renesas RZQ2L driver.

    Simplification of the probe function by using devm_*() mechanisms,
    which avoid the endless list of error prone gotos in the failure paths.

  - Expand the Renesas RZV2H driver to support RZ/G3E SoCs

  - A workaround for Rockchip 3568002 erratum in the GIC-V3 driver to
    ensure that the addressing is limited to the lower 32-bit of the
    physical address space.

  - Add support for the Allwinner AS23 NMI controller

  - Expand the IMX irqsteer driver to handle up to 960 input interrupts

  - The usual small updates, cleanups and device tree changes.


Thanks,

	tglx

------------------>
Andre Przywara (2):
      dt-bindings: irq: sun7i-nmi: Document the Allwinner A523 NMI controller
      irqchip/sunxi-nmi: Support Allwinner A523 NMI controller

Andrew Jones (1):
      irqchip/riscv-imsic: Set irq_set_affinity() for IMSIC base

Anup Patel (6):
      genirq: Introduce irq_can_move_in_process_context()
      RISC-V: Select CONFIG_GENERIC_PENDING_IRQ
      irqchip/riscv-imsic: Separate next and previous pointers in IMSIC vector
      irqchip/riscv-imsic: Implement irq_force_complete_move() for IMSIC
      irqchip/riscv-imsic: Avoid interrupt translation in interrupt handler
      irqchip/riscv-imsic: Special handling for non-atomic device MSI update

Bartosz Golaszewski (1):
      irqchip/davinci-cp-intc: Remove public header

Biju Das (12):
      dt-bindings: interrupt-controller: renesas,rzv2h-icu: Document RZ/G3E S=
oC
      irqchip/renesas-rzv2h: Fix wrong variable usage in rzv2h_tint_set_type()
      irqchip/renesas-rzv2h: Drop irqchip from struct rzv2h_icu_priv
      irqchip/renesas-rzv2h: Simplify rzv2h_icu_init()
      irqchip/renesas-rzv2h: Use devm_reset_control_get_exclusive_deasserted()
      irqchip/renesas-rzv2h: Use devm_pm_runtime_enable()
      irqchip/renesas-rzv2h: Add struct rzv2h_hw_info with t_offs variable
      irqchip/renesas-rzv2h: Add max_tssel to struct rzv2h_hw_info
      irqchip/renesas-rzv2h: Add field_width to struct rzv2h_hw_info
      irqchip/renesas-rzv2h: Update TSSR_TIEN macro
      irqchip/renesas-rzv2h: Update macros ICU_TSSR_TSSEL_{MASK,PREP}
      irqchip/renesas-rzv2h: Add RZ/G3E support

Chen Wang (3):
      dt-bindings: interrupt-controller: Add Sophgo SG2042 MSI
      irqchip: Add the Sophgo SG2042 MSI interrupt controller
      riscv: sophgo: dts: Add msi controller for SG2042

Dmitry Osipenko (3):
      irqchip/gic-v3: Add Rockchip 3568002 erratum workaround
      arm64: dts: rockchip: rk356x: Add MSI controller node
      arm64: dts: rockchip: rk356x: Move PCIe MSI to use GIC ITS instead of M=
BI

Fabrizio Castro (6):
      irqchip/renesas-rzg2l: Use local dev pointer in rzg2l_irqc_common_init()
      irqchip/renesas-rzg2l: Use devm_reset_control_get_exclusive_deasserted()
      irqchip/renesas-rzg2l: Use devm_pm_runtime_enable()
      irqchip/renesas-rzg2l: Remove pm_put label
      irqchip/renesas-rzg2l: Switch to using dev_err_probe()
      irqchip/renesas-rzg2l: Simplify checks in rzg2l_irqc_common_init()

Shengjiu Wang (1):
      irqchip/imx-irqsteer: Support up to 960 input interrupts

Thomas Gleixner (3):
      irqchip/irq-msi-lib: Optionally set default irq_eoi()/irq_ack()
      irqchip/riscv-imsic: Move to common MSI library
      genirq: Introduce common irq_force_complete_move() implementation

Vladimir Kondratiev (2):
      dt-bindings: interrupt-controller: Add risc-v,aplic hart indexes
      irqchip/riscv-aplic: Add support for hart indexes


 Documentation/arch/arm64/silicon-errata.rst        |   2 +
 .../allwinner,sun7i-a20-sc-nmi.yaml                |   1 +
 .../interrupt-controller/renesas,rzv2h-icu.yaml    |   6 +-
 .../bindings/interrupt-controller/riscv,aplic.yaml |   8 +
 .../interrupt-controller/sophgo,sg2042-msi.yaml    |  61 +++++
 arch/arm/mach-davinci/da830.c                      |   1 -
 arch/arm64/Kconfig                                 |   9 +
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi      |  14 +-
 arch/riscv/Kconfig                                 |   1 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi             |  10 +
 arch/x86/kernel/apic/vector.c                      | 231 +++++++++----------
 drivers/irqchip/Kconfig                            |  20 +-
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-davinci-cp-intc.c              |  57 ++---
 drivers/irqchip/irq-gic-v2m.c                      |   1 +
 drivers/irqchip/irq-gic-v3-its-msi-parent.c        |   1 +
 drivers/irqchip/irq-gic-v3-its.c                   |  23 +-
 drivers/irqchip/irq-gic-v3-mbi.c                   |   1 +
 drivers/irqchip/irq-imx-irqsteer.c                 |  14 +-
 drivers/irqchip/irq-imx-mu-msi.c                   |   1 +
 drivers/irqchip/irq-loongson-pch-msi.c             |   1 +
 drivers/irqchip/irq-msi-lib.c                      |  11 +-
 drivers/irqchip/irq-mvebu-gicp.c                   |   1 +
 drivers/irqchip/irq-mvebu-odmi.c                   |   1 +
 drivers/irqchip/irq-mvebu-sei.c                    |   1 +
 drivers/irqchip/irq-renesas-rzg2l.c                |  53 ++---
 drivers/irqchip/irq-renesas-rzv2h.c                | 198 +++++++++++-----
 drivers/irqchip/irq-riscv-aplic-direct.c           |  24 +-
 drivers/irqchip/irq-riscv-imsic-early.c            |  14 +-
 drivers/irqchip/irq-riscv-imsic-platform.c         | 215 +++++++++---------
 drivers/irqchip/irq-riscv-imsic-state.c            | 151 ++++++++++---
 drivers/irqchip/irq-riscv-imsic-state.h            |  12 +-
 drivers/irqchip/irq-sg2042-msi.c                   | 249 +++++++++++++++++++=
++
 drivers/irqchip/irq-sunxi-nmi.c                    |  85 ++++---
 include/linux/irq.h                                |   7 +-
 include/linux/irqchip/irq-davinci-cp-intc.h        |  25 ---
 include/linux/msi.h                                |  11 +
 kernel/irq/internals.h                             |   2 +
 kernel/irq/migration.c                             |  20 ++
 39 files changed, 1047 insertions(+), 497 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/so=
phgo,sg2042-msi.yaml
 create mode 100644 drivers/irqchip/irq-sg2042-msi.c
 delete mode 100644 include/linux/irqchip/irq-davinci-cp-intc.h

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch=
/arm64/silicon-errata.rst
index f074f6219f5c..f968c13b46a7 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -284,6 +284,8 @@ stable kernels.
 +----------------+-----------------+-----------------+----------------------=
-------+
 | Rockchip       | RK3588          | #3588001        | ROCKCHIP_ERRATUM_3588=
001    |
 +----------------+-----------------+-----------------+----------------------=
-------+
+| Rockchip       | RK3568          | #3568002        | ROCKCHIP_ERRATUM_3568=
002    |
++----------------+-----------------+-----------------+----------------------=
-------+
 +----------------+-----------------+-----------------+----------------------=
-------+
 | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_01000=
1      |
 +----------------+-----------------+-----------------+----------------------=
-------+
diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner=
,sun7i-a20-sc-nmi.yaml b/Documentation/devicetree/bindings/interrupt-controll=
er/allwinner,sun7i-a20-sc-nmi.yaml
index f49b43f45f3d..06e3621a8c06 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-=
a20-sc-nmi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-=
a20-sc-nmi.yaml
@@ -26,6 +26,7 @@ properties:
         deprecated: true
       - const: allwinner,sun7i-a20-sc-nmi
       - const: allwinner,sun9i-a80-nmi
+      - const: allwinner,sun55i-a523-nmi
       - items:
           - enum:
               - allwinner,sun8i-v3s-nmi
diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,r=
zv2h-icu.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesa=
s,rzv2h-icu.yaml
index d7ef4f1323a7..3f99c8645767 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzv2h-ic=
u.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzv2h-ic=
u.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/interrupt-controller/renesas,rzv2h-icu.ya=
ml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: Renesas RZ/V2H(P) Interrupt Control Unit
+title: Renesas RZ/{G3E,V2H(P)} Interrupt Control Unit
=20
 maintainers:
   - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
@@ -20,7 +20,9 @@ description:
=20
 properties:
   compatible:
-    const: renesas,r9a09g057-icu # RZ/V2H(P)
+    enum:
+      - renesas,r9a09g047-icu # RZ/G3E
+      - renesas,r9a09g057-icu # RZ/V2H(P)
=20
   '#interrupt-cells':
     description: The first cell is the SPI number of the NMI or the
diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,apl=
ic.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.=
yaml
index 190a6499c932..bef00521d5da 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
@@ -91,6 +91,14 @@ properties:
       Firmware must configure interrupt delegation registers based on
       interrupt delegation list.
=20
+  riscv,hart-indexes:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 16384
+    description:
+      A list of hart indexes that APLIC should use to address each hart
+      that is mentioned in the "interrupts-extended"
+
 dependencies:
   riscv,delegation: [ "riscv,children" ]
=20
diff --git a/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg=
2042-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/sophgo=
,sg2042-msi.yaml
new file mode 100644
index 000000000000..e1ffd55fa7bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-ms=
i.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/sophgo,sg2042-msi.ya=
ml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 MSI Controller
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+description:
+  This interrupt controller is in Sophgo SG2042 for transforming interrupts =
from
+  PCIe MSI to PLIC interrupts.
+
+allOf:
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
+
+properties:
+  compatible:
+    const: sophgo,sg2042-msi
+
+  reg:
+    items:
+      - description: clear register
+      - description: msi doorbell address
+
+  reg-names:
+    items:
+      - const: clr
+      - const: doorbell
+
+  msi-controller: true
+
+  msi-ranges:
+    maxItems: 1
+
+  "#msi-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - msi-controller
+  - msi-ranges
+  - "#msi-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    msi-controller@30000000 {
+      compatible =3D "sophgo,sg2042-msi";
+      reg =3D <0x30000000 0x4>, <0x30000008 0x4>;
+      reg-names =3D "clr", "doorbell";
+      msi-controller;
+      #msi-cells =3D <0>;
+      msi-ranges =3D <&plic 64 IRQ_TYPE_LEVEL_HIGH 32>;
+    };
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 2e497745b624..a044ea5cb4f1 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -11,7 +11,6 @@
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/irqchip/irq-davinci-cp-intc.h>
=20
 #include <clocksource/timer-davinci.h>
=20
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fcdd0ed3eca8..0507e476f69f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1303,6 +1303,15 @@ config NVIDIA_CARMEL_CNP_ERRATUM
=20
 	  If unsure, say Y.
=20
+config ROCKCHIP_ERRATUM_3568002
+	bool "Rockchip 3568002: GIC600 can not access physical addresses higher tha=
n 4GB"
+	default y
+	help
+	  The Rockchip RK3566 and RK3568 GIC600 SoC integrations have AXI
+	  addressing limited to the first 32bit of physical address space.
+
+	  If unsure, say Y.
+
 config ROCKCHIP_ERRATUM_3588001
 	bool "Rockchip 3588001: GIC600 can not support shareability attributes"
 	default y
diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/=
dts/rockchip/rk356x-base.dtsi
index e55390629114..4e730aecf84d 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -284,6 +284,18 @@ gic: interrupt-controller@fd400000 {
 		mbi-alias =3D <0x0 0xfd410000>;
 		mbi-ranges =3D <296 24>;
 		msi-controller;
+		ranges;
+		#address-cells =3D <2>;
+		#size-cells =3D <2>;
+		dma-noncoherent;
+
+		its: msi-controller@fd440000 {
+			compatible =3D "arm,gic-v3-its";
+			reg =3D <0x0 0xfd440000 0 0x20000>;
+			dma-noncoherent;
+			msi-controller;
+			#msi-cells =3D <1>;
+		};
 	};
=20
 	usb_host0_ehci: usb@fd800000 {
@@ -957,7 +969,7 @@ pcie2x1: pcie@fe260000 {
 		num-ib-windows =3D <6>;
 		num-ob-windows =3D <2>;
 		max-link-speed =3D <2>;
-		msi-map =3D <0x0 &gic 0x0 0x1000>;
+		msi-map =3D <0x0 &its 0x0 0x1000>;
 		num-lanes =3D <1>;
 		phys =3D <&combphy2 PHY_TYPE_PCIE>;
 		phy-names =3D "pcie-phy";
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7612c52e9b1e..a32f39748775 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -111,6 +111,7 @@ config RISCV
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_LIB_DEVMEM_IS_ALLOWED
+	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_PCI_IOMAP
 	select GENERIC_PTDUMP if MMU
 	select GENERIC_SCHED_CLOCK
diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sop=
hgo/sg2042.dtsi
index e62ac51ac55a..fef2a0e0f7a3 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -173,6 +173,16 @@ pllclk: clock-controller@70300100c0 {
 			#clock-cells =3D <1>;
 		};
=20
+		msi: msi-controller@7030010304 {
+			compatible =3D "sophgo,sg2042-msi";
+			reg =3D <0x70 0x30010304 0x0 0x4>,
+			      <0x70 0x30010300 0x0 0x4>;
+			reg-names =3D "clr", "doorbell";
+			msi-controller;
+			#msi-cells =3D <0>;
+			msi-ranges =3D <&intc 64 IRQ_TYPE_LEVEL_HIGH 32>;
+		};
+
 		rpgate: clock-controller@7030010368 {
 			compatible =3D "sophgo,sg2042-rpgate";
 			reg =3D <0x70 0x30010368 0x0 0x98>;
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 736f62812f5c..72fa4bb78f0a 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -888,8 +888,109 @@ static int apic_set_affinity(struct irq_data *irqd,
 	return err ? err : IRQ_SET_MASK_OK;
 }
=20
+static void free_moved_vector(struct apic_chip_data *apicd)
+{
+	unsigned int vector =3D apicd->prev_vector;
+	unsigned int cpu =3D apicd->prev_cpu;
+	bool managed =3D apicd->is_managed;
+
+	/*
+	 * Managed interrupts are usually not migrated away
+	 * from an online CPU, but CPU isolation 'managed_irq'
+	 * can make that happen.
+	 * 1) Activation does not take the isolation into account
+	 *    to keep the code simple
+	 * 2) Migration away from an isolated CPU can happen when
+	 *    a non-isolated CPU which is in the calculated
+	 *    affinity mask comes online.
+	 */
+	trace_vector_free_moved(apicd->irq, cpu, vector, managed);
+	irq_matrix_free(vector_matrix, cpu, vector, managed);
+	per_cpu(vector_irq, cpu)[vector] =3D VECTOR_UNUSED;
+	hlist_del_init(&apicd->clist);
+	apicd->prev_vector =3D 0;
+	apicd->move_in_progress =3D 0;
+}
+
+/*
+ * Called from fixup_irqs() with @desc->lock held and interrupts disabled.
+ */
+static void apic_force_complete_move(struct irq_data *irqd)
+{
+	unsigned int cpu =3D smp_processor_id();
+	struct apic_chip_data *apicd;
+	unsigned int vector;
+
+	guard(raw_spinlock)(&vector_lock);
+	apicd =3D apic_chip_data(irqd);
+	if (!apicd)
+		return;
+
+	/*
+	 * If prev_vector is empty or the descriptor is neither currently
+	 * nor previously on the outgoing CPU no action required.
+	 */
+	vector =3D apicd->prev_vector;
+	if (!vector || (apicd->cpu !=3D cpu && apicd->prev_cpu !=3D cpu))
+		return;
+
+	/*
+	 * This is tricky. If the cleanup of the old vector has not been
+	 * done yet, then the following setaffinity call will fail with
+	 * -EBUSY. This can leave the interrupt in a stale state.
+	 *
+	 * All CPUs are stuck in stop machine with interrupts disabled so
+	 * calling __irq_complete_move() would be completely pointless.
+	 *
+	 * 1) The interrupt is in move_in_progress state. That means that we
+	 *    have not seen an interrupt since the io_apic was reprogrammed to
+	 *    the new vector.
+	 *
+	 * 2) The interrupt has fired on the new vector, but the cleanup IPIs
+	 *    have not been processed yet.
+	 */
+	if (apicd->move_in_progress) {
+		/*
+		 * In theory there is a race:
+		 *
+		 * set_ioapic(new_vector) <-- Interrupt is raised before update
+		 *			      is effective, i.e. it's raised on
+		 *			      the old vector.
+		 *
+		 * So if the target cpu cannot handle that interrupt before
+		 * the old vector is cleaned up, we get a spurious interrupt
+		 * and in the worst case the ioapic irq line becomes stale.
+		 *
+		 * But in case of cpu hotplug this should be a non issue
+		 * because if the affinity update happens right before all
+		 * cpus rendezvous in stop machine, there is no way that the
+		 * interrupt can be blocked on the target cpu because all cpus
+		 * loops first with interrupts enabled in stop machine, so the
+		 * old vector is not yet cleaned up when the interrupt fires.
+		 *
+		 * So the only way to run into this issue is if the delivery
+		 * of the interrupt on the apic/system bus would be delayed
+		 * beyond the point where the target cpu disables interrupts
+		 * in stop machine. I doubt that it can happen, but at least
+		 * there is a theoretical chance. Virtualization might be
+		 * able to expose this, but AFAICT the IOAPIC emulation is not
+		 * as stupid as the real hardware.
+		 *
+		 * Anyway, there is nothing we can do about that at this point
+		 * w/o refactoring the whole fixup_irq() business completely.
+		 * We print at least the irq number and the old vector number,
+		 * so we have the necessary information when a problem in that
+		 * area arises.
+		 */
+		pr_warn("IRQ fixup: irq %d move in progress, old vector %d\n",
+			irqd->irq, vector);
+	}
+	free_moved_vector(apicd);
+}
+
 #else
-# define apic_set_affinity	NULL
+# define apic_set_affinity		NULL
+# define apic_force_complete_move	NULL
 #endif
=20
 static int apic_retrigger_irq(struct irq_data *irqd)
@@ -923,39 +1024,16 @@ static void x86_vector_msi_compose_msg(struct irq_data=
 *data,
 }
=20
 static struct irq_chip lapic_controller =3D {
-	.name			=3D "APIC",
-	.irq_ack		=3D apic_ack_edge,
-	.irq_set_affinity	=3D apic_set_affinity,
-	.irq_compose_msi_msg	=3D x86_vector_msi_compose_msg,
-	.irq_retrigger		=3D apic_retrigger_irq,
+	.name				=3D "APIC",
+	.irq_ack			=3D apic_ack_edge,
+	.irq_set_affinity		=3D apic_set_affinity,
+	.irq_compose_msi_msg		=3D x86_vector_msi_compose_msg,
+	.irq_force_complete_move	=3D apic_force_complete_move,
+	.irq_retrigger			=3D apic_retrigger_irq,
 };
=20
 #ifdef CONFIG_SMP
=20
-static void free_moved_vector(struct apic_chip_data *apicd)
-{
-	unsigned int vector =3D apicd->prev_vector;
-	unsigned int cpu =3D apicd->prev_cpu;
-	bool managed =3D apicd->is_managed;
-
-	/*
-	 * Managed interrupts are usually not migrated away
-	 * from an online CPU, but CPU isolation 'managed_irq'
-	 * can make that happen.
-	 * 1) Activation does not take the isolation into account
-	 *    to keep the code simple
-	 * 2) Migration away from an isolated CPU can happen when
-	 *    a non-isolated CPU which is in the calculated
-	 *    affinity mask comes online.
-	 */
-	trace_vector_free_moved(apicd->irq, cpu, vector, managed);
-	irq_matrix_free(vector_matrix, cpu, vector, managed);
-	per_cpu(vector_irq, cpu)[vector] =3D VECTOR_UNUSED;
-	hlist_del_init(&apicd->clist);
-	apicd->prev_vector =3D 0;
-	apicd->move_in_progress =3D 0;
-}
-
 static void __vector_cleanup(struct vector_cleanup *cl, bool check_irr)
 {
 	struct apic_chip_data *apicd;
@@ -1068,99 +1146,6 @@ void irq_complete_move(struct irq_cfg *cfg)
 		__vector_schedule_cleanup(apicd);
 }
=20
-/*
- * Called from fixup_irqs() with @desc->lock held and interrupts disabled.
- */
-void irq_force_complete_move(struct irq_desc *desc)
-{
-	unsigned int cpu =3D smp_processor_id();
-	struct apic_chip_data *apicd;
-	struct irq_data *irqd;
-	unsigned int vector;
-
-	/*
-	 * The function is called for all descriptors regardless of which
-	 * irqdomain they belong to. For example if an IRQ is provided by
-	 * an irq_chip as part of a GPIO driver, the chip data for that
-	 * descriptor is specific to the irq_chip in question.
-	 *
-	 * Check first that the chip_data is what we expect
-	 * (apic_chip_data) before touching it any further.
-	 */
-	irqd =3D irq_domain_get_irq_data(x86_vector_domain,
-				       irq_desc_get_irq(desc));
-	if (!irqd)
-		return;
-
-	raw_spin_lock(&vector_lock);
-	apicd =3D apic_chip_data(irqd);
-	if (!apicd)
-		goto unlock;
-
-	/*
-	 * If prev_vector is empty or the descriptor is neither currently
-	 * nor previously on the outgoing CPU no action required.
-	 */
-	vector =3D apicd->prev_vector;
-	if (!vector || (apicd->cpu !=3D cpu && apicd->prev_cpu !=3D cpu))
-		goto unlock;
-
-	/*
-	 * This is tricky. If the cleanup of the old vector has not been
-	 * done yet, then the following setaffinity call will fail with
-	 * -EBUSY. This can leave the interrupt in a stale state.
-	 *
-	 * All CPUs are stuck in stop machine with interrupts disabled so
-	 * calling __irq_complete_move() would be completely pointless.
-	 *
-	 * 1) The interrupt is in move_in_progress state. That means that we
-	 *    have not seen an interrupt since the io_apic was reprogrammed to
-	 *    the new vector.
-	 *
-	 * 2) The interrupt has fired on the new vector, but the cleanup IPIs
-	 *    have not been processed yet.
-	 */
-	if (apicd->move_in_progress) {
-		/*
-		 * In theory there is a race:
-		 *
-		 * set_ioapic(new_vector) <-- Interrupt is raised before update
-		 *			      is effective, i.e. it's raised on
-		 *			      the old vector.
-		 *
-		 * So if the target cpu cannot handle that interrupt before
-		 * the old vector is cleaned up, we get a spurious interrupt
-		 * and in the worst case the ioapic irq line becomes stale.
-		 *
-		 * But in case of cpu hotplug this should be a non issue
-		 * because if the affinity update happens right before all
-		 * cpus rendezvous in stop machine, there is no way that the
-		 * interrupt can be blocked on the target cpu because all cpus
-		 * loops first with interrupts enabled in stop machine, so the
-		 * old vector is not yet cleaned up when the interrupt fires.
-		 *
-		 * So the only way to run into this issue is if the delivery
-		 * of the interrupt on the apic/system bus would be delayed
-		 * beyond the point where the target cpu disables interrupts
-		 * in stop machine. I doubt that it can happen, but at least
-		 * there is a theoretical chance. Virtualization might be
-		 * able to expose this, but AFAICT the IOAPIC emulation is not
-		 * as stupid as the real hardware.
-		 *
-		 * Anyway, there is nothing we can do about that at this point
-		 * w/o refactoring the whole fixup_irq() business completely.
-		 * We print at least the irq number and the old vector number,
-		 * so we have the necessary information when a problem in that
-		 * area arises.
-		 */
-		pr_warn("IRQ fixup: irq %d move in progress, old vector %d\n",
-			irqd->irq, vector);
-	}
-	free_moved_vector(apicd);
-unlock:
-	raw_spin_unlock(&vector_lock);
-}
-
 #ifdef CONFIG_HOTPLUG_CPU
 /*
  * Note, this is not accurate accounting, but at least good enough to
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index be063bfb50c4..441f10711695 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -589,13 +589,7 @@ config RISCV_IMSIC
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_MATRIX_ALLOCATOR
 	select GENERIC_MSI_IRQ
-
-config RISCV_IMSIC_PCI
-	bool
-	depends on RISCV_IMSIC
-	depends on PCI
-	depends on PCI_MSI
-	default RISCV_IMSIC
+	select IRQ_MSI_LIB
=20
 config SIFIVE_PLIC
 	bool
@@ -751,6 +745,18 @@ config MCHP_EIC
 	help
 	  Support for Microchip External Interrupt Controller.
=20
+config SOPHGO_SG2042_MSI
+	bool "Sophgo SG2042 MSI Controller"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	depends on PCI
+	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_MSI_LIB
+	select PCI_MSI
+	help
+	  Support for the Sophgo SG2042 MSI Controller.
+	  This on-chip interrupt controller enables MSI sources to be
+	  routed to the primary PLIC controller on SoC.
+
 config SUNPLUS_SP7021_INTC
 	bool "Sunplus SP7021 interrupt controller" if COMPILE_TEST
 	default SOC_SP7021
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 25e9ad29b8c4..dd60e597491d 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -128,4 +128,5 @@ obj-$(CONFIG_WPCM450_AIC)		+=3D irq-wpcm450-aic.o
 obj-$(CONFIG_IRQ_IDT3243X)		+=3D irq-idt3243x.o
 obj-$(CONFIG_APPLE_AIC)			+=3D irq-apple-aic.o
 obj-$(CONFIG_MCHP_EIC)			+=3D irq-mchp-eic.o
+obj-$(CONFIG_SOPHGO_SG2042_MSI)		+=3D irq-sg2042-msi.o
 obj-$(CONFIG_SUNPLUS_SP7021_INTC)	+=3D irq-sp7021-intc.o
diff --git a/drivers/irqchip/irq-davinci-cp-intc.c b/drivers/irqchip/irq-davi=
nci-cp-intc.c
index f4f8e9fadbbf..d7948c55f542 100644
--- a/drivers/irqchip/irq-davinci-cp-intc.c
+++ b/drivers/irqchip/irq-davinci-cp-intc.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
-#include <linux/irqchip/irq-davinci-cp-intc.h>
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -154,24 +153,20 @@ static const struct irq_domain_ops davinci_cp_intc_irq_=
domain_ops =3D {
 	.xlate =3D irq_domain_xlate_onetwocell,
 };
=20
-static int __init
-davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
-			struct device_node *node)
+static int __init davinci_cp_intc_do_init(struct resource *res, unsigned int=
 num_irqs,
+					  struct device_node *node)
 {
-	unsigned int num_regs =3D BITS_TO_LONGS(config->num_irqs);
+	unsigned int num_regs =3D BITS_TO_LONGS(num_irqs);
 	int offset, irq_base;
 	void __iomem *req;
=20
-	req =3D request_mem_region(config->reg.start,
-				 resource_size(&config->reg),
-				 "davinci-cp-intc");
+	req =3D request_mem_region(res->start, resource_size(res), "davinci-cp-intc=
");
 	if (!req) {
 		pr_err("%s: register range busy\n", __func__);
 		return -EBUSY;
 	}
=20
-	davinci_cp_intc_base =3D ioremap(config->reg.start,
-				       resource_size(&config->reg));
+	davinci_cp_intc_base =3D ioremap(res->start, resource_size(res));
 	if (!davinci_cp_intc_base) {
 		pr_err("%s: unable to ioremap register range\n", __func__);
 		return -EINVAL;
@@ -184,8 +179,7 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_conf=
ig *config,
=20
 	/* Disable system interrupts */
 	for (offset =3D 0; offset < num_regs; offset++)
-		davinci_cp_intc_write(~0,
-			DAVINCI_CP_INTC_SYS_ENABLE_CLR(offset));
+		davinci_cp_intc_write(~0, DAVINCI_CP_INTC_SYS_ENABLE_CLR(offset));
=20
 	/* Set to normal mode, no nesting, no priority hold */
 	davinci_cp_intc_write(0, DAVINCI_CP_INTC_CTRL);
@@ -193,28 +187,25 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_co=
nfig *config,
=20
 	/* Clear system interrupt status */
 	for (offset =3D 0; offset < num_regs; offset++)
-		davinci_cp_intc_write(~0,
-			DAVINCI_CP_INTC_SYS_STAT_CLR(offset));
+		davinci_cp_intc_write(~0, DAVINCI_CP_INTC_SYS_STAT_CLR(offset));
=20
 	/* Enable nIRQ (what about nFIQ?) */
 	davinci_cp_intc_write(1, DAVINCI_CP_INTC_HOST_ENABLE_IDX_SET);
=20
+	/* 4 channels per register */
+	num_regs =3D (num_irqs + 3) >> 2;
 	/* Default all priorities to channel 7. */
-	num_regs =3D (config->num_irqs + 3) >> 2;	/* 4 channels per register */
 	for (offset =3D 0; offset < num_regs; offset++)
-		davinci_cp_intc_write(0x07070707,
-			DAVINCI_CP_INTC_CHAN_MAP(offset));
+		davinci_cp_intc_write(0x07070707, DAVINCI_CP_INTC_CHAN_MAP(offset));
=20
-	irq_base =3D irq_alloc_descs(-1, 0, config->num_irqs, 0);
+	irq_base =3D irq_alloc_descs(-1, 0, num_irqs, 0);
 	if (irq_base < 0) {
-		pr_err("%s: unable to allocate interrupt descriptors: %d\n",
-		       __func__, irq_base);
+		pr_err("%s: unable to allocate interrupt descriptors: %d\n", __func__, irq=
_base);
 		return irq_base;
 	}
=20
-	davinci_cp_intc_irq_domain =3D irq_domain_add_legacy(
-					node, config->num_irqs, irq_base, 0,
-					&davinci_cp_intc_irq_domain_ops, NULL);
+	davinci_cp_intc_irq_domain =3D irq_domain_add_legacy(node, num_irqs, irq_ba=
se, 0,
+							   &davinci_cp_intc_irq_domain_ops, NULL);
=20
 	if (!davinci_cp_intc_irq_domain) {
 		pr_err("%s: unable to create an interrupt domain\n", __func__);
@@ -229,31 +220,25 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_co=
nfig *config,
 	return 0;
 }
=20
-int __init davinci_cp_intc_init(const struct davinci_cp_intc_config *config)
-{
-	return davinci_cp_intc_do_init(config, NULL);
-}
-
 static int __init davinci_cp_intc_of_init(struct device_node *node,
 					  struct device_node *parent)
 {
-	struct davinci_cp_intc_config config =3D { };
+	unsigned int num_irqs;
+	struct resource res;
 	int ret;
=20
-	ret =3D of_address_to_resource(node, 0, &config.reg);
+	ret =3D of_address_to_resource(node, 0, &res);
 	if (ret) {
-		pr_err("%s: unable to get the register range from device-tree\n",
-		       __func__);
+		pr_err("%s: unable to get the register range from device-tree\n", __func__=
);
 		return ret;
 	}
=20
-	ret =3D of_property_read_u32(node, "ti,intc-size", &config.num_irqs);
+	ret =3D of_property_read_u32(node, "ti,intc-size", &num_irqs);
 	if (ret) {
-		pr_err("%s: unable to read the 'ti,intc-size' property\n",
-		       __func__);
+		pr_err("%s: unable to read the 'ti,intc-size' property\n", __func__);
 		return ret;
 	}
=20
-	return davinci_cp_intc_do_init(&config, node);
+	return davinci_cp_intc_do_init(&res, num_irqs, node);
 }
 IRQCHIP_DECLARE(cp_intc, "ti,cp-intc", davinci_cp_intc_of_init);
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index be35c5349986..1e3476c335ca 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -255,6 +255,7 @@ static void __init gicv2m_teardown(void)
 static struct msi_parent_ops gicv2m_msi_parent_ops =3D {
 	.supported_flags	=3D GICV2M_MSI_FLAGS_SUPPORTED,
 	.required_flags		=3D GICV2M_MSI_FLAGS_REQUIRED,
+	.chip_flags		=3D MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
 	.bus_select_token	=3D DOMAIN_BUS_NEXUS,
 	.bus_select_mask	=3D MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
 	.prefix			=3D "GICv2m-",
diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/ir=
q-gic-v3-its-msi-parent.c
index e150365fbe89..bdb04c808148 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -203,6 +203,7 @@ static bool its_init_dev_msi_info(struct device *dev, str=
uct irq_domain *domain,
 const struct msi_parent_ops gic_v3_its_msi_parent_ops =3D {
 	.supported_flags	=3D ITS_MSI_FLAGS_SUPPORTED,
 	.required_flags		=3D ITS_MSI_FLAGS_REQUIRED,
+	.chip_flags		=3D MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
 	.bus_select_token	=3D DOMAIN_BUS_NEXUS,
 	.bus_select_mask	=3D MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
 	.prefix			=3D "ITS-",
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index 8c3ec5734f1e..f30ed281882f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -205,13 +205,15 @@ static DEFINE_IDA(its_vpeid_ida);
 #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
 #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + SZ_128K)
=20
+static gfp_t gfp_flags_quirk;
+
 static struct page *its_alloc_pages_node(int node, gfp_t gfp,
 					 unsigned int order)
 {
 	struct page *page;
 	int ret =3D 0;
=20
-	page =3D alloc_pages_node(node, gfp, order);
+	page =3D alloc_pages_node(node, gfp | gfp_flags_quirk, order);
=20
 	if (!page)
 		return NULL;
@@ -4887,6 +4889,17 @@ static bool __maybe_unused its_enable_quirk_hip09_1621=
00801(void *data)
 	return true;
 }
=20
+static bool __maybe_unused its_enable_rk3568002(void *data)
+{
+	if (!of_machine_is_compatible("rockchip,rk3566") &&
+	    !of_machine_is_compatible("rockchip,rk3568"))
+		return false;
+
+	gfp_flags_quirk |=3D GFP_DMA32;
+
+	return true;
+}
+
 static const struct gic_quirk its_quirks[] =3D {
 #ifdef CONFIG_CAVIUM_ERRATUM_22375
 	{
@@ -4954,6 +4967,14 @@ static const struct gic_quirk its_quirks[] =3D {
 		.property =3D "dma-noncoherent",
 		.init   =3D its_set_non_coherent,
 	},
+#ifdef CONFIG_ROCKCHIP_ERRATUM_3568002
+	{
+		.desc   =3D "ITS: Rockchip erratum RK3568002",
+		.iidr   =3D 0x0201743b,
+		.mask   =3D 0xffffffff,
+		.init   =3D its_enable_rk3568002,
+	},
+#endif
 	{
 	}
 };
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mb=
i.c
index 3fe870f8ee17..3e1d8a1cda5e 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -201,6 +201,7 @@ static bool mbi_init_dev_msi_info(struct device *dev, str=
uct irq_domain *domain,
 static const struct msi_parent_ops gic_v3_mbi_msi_parent_ops =3D {
 	.supported_flags	=3D MBI_MSI_FLAGS_SUPPORTED,
 	.required_flags		=3D MBI_MSI_FLAGS_REQUIRED,
+	.chip_flags		=3D MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
 	.bus_select_token	=3D DOMAIN_BUS_NEXUS,
 	.bus_select_mask	=3D MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
 	.prefix			=3D "MBI-",
diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irq=
steer.c
index b0e9788c0045..afbfcce3b1e3 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -24,7 +24,7 @@
 #define CHAN_MINTDIS(t)		(CTRL_STRIDE_OFF(t, 3) + 0x4)
 #define CHAN_MASTRSTAT(t)	(CTRL_STRIDE_OFF(t, 3) + 0x8)
=20
-#define CHAN_MAX_OUTPUT_INT	0x8
+#define CHAN_MAX_OUTPUT_INT	0xF
=20
 struct irqsteer_data {
 	void __iomem		*regs;
@@ -228,10 +228,8 @@ static int imx_irqsteer_probe(struct platform_device *pd=
ev)
=20
 	for (i =3D 0; i < data->irq_count; i++) {
 		data->irq[i] =3D irq_of_parse_and_map(np, i);
-		if (!data->irq[i]) {
-			ret =3D -EINVAL;
-			goto out;
-		}
+		if (!data->irq[i])
+			break;
=20
 		irq_set_chained_handler_and_data(data->irq[i],
 						 imx_irqsteer_irq_handler,
@@ -254,9 +252,13 @@ static void imx_irqsteer_remove(struct platform_device *=
pdev)
 	struct irqsteer_data *irqsteer_data =3D platform_get_drvdata(pdev);
 	int i;
=20
-	for (i =3D 0; i < irqsteer_data->irq_count; i++)
+	for (i =3D 0; i < irqsteer_data->irq_count; i++) {
+		if (!irqsteer_data->irq[i])
+			break;
+
 		irq_set_chained_handler_and_data(irqsteer_data->irq[i],
 						 NULL, NULL);
+	}
=20
 	irq_domain_remove(irqsteer_data->domain);
=20
diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-ms=
i.c
index 4342a21de1eb..69aacdfc8bef 100644
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -214,6 +214,7 @@ static void imx_mu_msi_irq_handler(struct irq_desc *desc)
 static const struct msi_parent_ops imx_mu_msi_parent_ops =3D {
 	.supported_flags	=3D IMX_MU_MSI_FLAGS_SUPPORTED,
 	.required_flags		=3D IMX_MU_MSI_FLAGS_REQUIRED,
+	.chip_flags		=3D MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
 	.bus_select_token       =3D DOMAIN_BUS_NEXUS,
 	.bus_select_mask	=3D MATCH_PLATFORM_MSI,
 	.prefix			=3D "MU-MSI-",
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loo=
ngson-pch-msi.c
index bd337ecddb40..9c62108b3ad5 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -146,6 +146,7 @@ static const struct irq_domain_ops pch_msi_middle_domain_=
ops =3D {
 static struct msi_parent_ops pch_msi_parent_ops =3D {
 	.required_flags		=3D PCH_MSI_FLAGS_REQUIRED,
 	.supported_flags	=3D PCH_MSI_FLAGS_SUPPORTED,
+	.chip_flags		=3D MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
 	.bus_select_mask	=3D MATCH_PCI_MSI,
 	.bus_select_token	=3D DOMAIN_BUS_NEXUS,
 	.prefix			=3D "PCH-",
diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index d8e29fc0d406..51464c6257f3 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -28,6 +28,7 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct i=
rq_domain *domain,
 			       struct msi_domain_info *info)
 {
 	const struct msi_parent_ops *pops =3D real_parent->msi_parent_ops;
+	struct irq_chip *chip =3D info->chip;
 	u32 required_flags;
=20
 	/* Parent ops available? */
@@ -92,10 +93,10 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct=
 irq_domain *domain,
 	info->flags			|=3D required_flags;
=20
 	/* Chip updates for all child bus types */
-	if (!info->chip->irq_eoi)
-		info->chip->irq_eoi	=3D irq_chip_eoi_parent;
-	if (!info->chip->irq_ack)
-		info->chip->irq_ack	=3D irq_chip_ack_parent;
+	if (!chip->irq_eoi && (pops->chip_flags & MSI_CHIP_FLAG_SET_EOI))
+		chip->irq_eoi =3D irq_chip_eoi_parent;
+	if (!chip->irq_ack && (pops->chip_flags & MSI_CHIP_FLAG_SET_ACK))
+		chip->irq_ack =3D irq_chip_ack_parent;
=20
 	/*
 	 * The device MSI domain can never have a set affinity callback. It
@@ -105,7 +106,7 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct=
 irq_domain *domain,
 	 * device MSI domain aside of mask/unmask which is provided e.g. by
 	 * PCI/MSI device domains.
 	 */
-	info->chip->irq_set_affinity	=3D msi_domain_set_affinity;
+	chip->irq_set_affinity =3D msi_domain_set_affinity;
 	return true;
 }
 EXPORT_SYMBOL_GPL(msi_lib_init_dev_msi_info);
diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gic=
p.c
index 2b6183919ea4..d67f93f6d750 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -161,6 +161,7 @@ static const struct irq_domain_ops gicp_domain_ops =3D {
 static const struct msi_parent_ops gicp_msi_parent_ops =3D {
 	.supported_flags	=3D GICP_MSI_FLAGS_SUPPORTED,
 	.required_flags		=3D GICP_MSI_FLAGS_REQUIRED,
+	.chip_flags		=3D MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
 	.bus_select_token       =3D DOMAIN_BUS_GENERIC_MSI,
 	.bus_select_mask	=3D MATCH_PLATFORM_MSI,
 	.prefix			=3D "GICP-",
diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odm=
i.c
index ff19bfd258dc..28f7e81df94f 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -157,6 +157,7 @@ static const struct irq_domain_ops odmi_domain_ops =3D {
 static const struct msi_parent_ops odmi_msi_parent_ops =3D {
 	.supported_flags	=3D ODMI_MSI_FLAGS_SUPPORTED,
 	.required_flags		=3D ODMI_MSI_FLAGS_REQUIRED,
+	.chip_flags		=3D MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
 	.bus_select_token	=3D DOMAIN_BUS_GENERIC_MSI,
 	.bus_select_mask	=3D MATCH_PLATFORM_MSI,
 	.prefix			=3D "ODMI-",
diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index 065166ab5dbc..ebd4a9014e8d 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -356,6 +356,7 @@ static void mvebu_sei_reset(struct mvebu_sei *sei)
 static const struct msi_parent_ops sei_msi_parent_ops =3D {
 	.supported_flags	=3D SEI_MSI_FLAGS_SUPPORTED,
 	.required_flags		=3D SEI_MSI_FLAGS_REQUIRED,
+	.chip_flags		=3D MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
 	.bus_select_mask	=3D MATCH_PLATFORM_MSI,
 	.bus_select_token	=3D DOMAIN_BUS_GENERIC_MSI,
 	.prefix			=3D "SEI-",
diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesa=
s-rzg2l.c
index 99e27e01b0b1..6a2e41f02446 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -541,43 +541,36 @@ static int rzg2l_irqc_common_init(struct device_node *n=
ode, struct device_node *
 		return -ENODEV;
=20
 	parent_domain =3D irq_find_host(parent);
-	if (!parent_domain) {
-		dev_err(&pdev->dev, "cannot find parent domain\n");
-		return -ENODEV;
-	}
+	if (!parent_domain)
+		return dev_err_probe(dev, -ENODEV, "cannot find parent domain\n");
=20
-	rzg2l_irqc_data =3D devm_kzalloc(&pdev->dev, sizeof(*rzg2l_irqc_data), GFP_=
KERNEL);
+	rzg2l_irqc_data =3D devm_kzalloc(dev, sizeof(*rzg2l_irqc_data), GFP_KERNEL);
 	if (!rzg2l_irqc_data)
 		return -ENOMEM;
=20
 	rzg2l_irqc_data->irqchip =3D irq_chip;
=20
-	rzg2l_irqc_data->base =3D devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, N=
ULL);
+	rzg2l_irqc_data->base =3D devm_of_iomap(dev, dev->of_node, 0, NULL);
 	if (IS_ERR(rzg2l_irqc_data->base))
 		return PTR_ERR(rzg2l_irqc_data->base);
=20
 	ret =3D rzg2l_irqc_parse_interrupts(rzg2l_irqc_data, node);
-	if (ret) {
-		dev_err(&pdev->dev, "cannot parse interrupts: %d\n", ret);
-		return ret;
-	}
-
-	resetn =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(resetn))
-		return PTR_ERR(resetn);
+	if (ret)
+		return dev_err_probe(dev, ret, "cannot parse interrupts: %d\n", ret);
=20
-	ret =3D reset_control_deassert(resetn);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to deassert resetn pin, %d\n", ret);
-		return ret;
+	resetn =3D devm_reset_control_get_exclusive_deasserted(dev, NULL);
+	if (IS_ERR(resetn)) {
+		return dev_err_probe(dev, PTR_ERR(resetn),
+				     "failed to acquire deasserted reset: %d\n", ret);
 	}
=20
-	pm_runtime_enable(&pdev->dev);
-	ret =3D pm_runtime_resume_and_get(&pdev->dev);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "pm_runtime_resume_and_get failed: %d\n", ret);
-		goto pm_disable;
-	}
+	ret =3D devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "devm_pm_runtime_enable failed: %d\n", ret);
+
+	ret =3D pm_runtime_resume_and_get(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "pm_runtime_resume_and_get failed: %d\n", r=
et);
=20
 	raw_spin_lock_init(&rzg2l_irqc_data->lock);
=20
@@ -585,9 +578,8 @@ static int rzg2l_irqc_common_init(struct device_node *nod=
e, struct device_node *
 					      node, &rzg2l_irqc_domain_ops,
 					      rzg2l_irqc_data);
 	if (!irq_domain) {
-		dev_err(&pdev->dev, "failed to add irq domain\n");
-		ret =3D -ENOMEM;
-		goto pm_put;
+		pm_runtime_put(dev);
+		return dev_err_probe(dev, -ENOMEM, "failed to add irq domain\n");
 	}
=20
 	register_syscore_ops(&rzg2l_irqc_syscore_ops);
@@ -604,13 +596,6 @@ static int rzg2l_irqc_common_init(struct device_node *no=
de, struct device_node *
 	dev =3D NULL;
=20
 	return 0;
-
-pm_put:
-	pm_runtime_put(&pdev->dev);
-pm_disable:
-	pm_runtime_disable(&pdev->dev);
-	reset_control_assert(resetn);
-	return ret;
 }
=20
 static int __init rzg2l_irqc_init(struct device_node *node,
diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesa=
s-rzv2h.c
index fe2d29e91026..3d5b5fdf9bde 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -64,11 +64,18 @@
 #define ICU_TINT_LEVEL_HIGH			2
 #define ICU_TINT_LEVEL_LOW			3
=20
-#define ICU_TSSR_K(tint_nr)			((tint_nr) / 4)
-#define ICU_TSSR_TSSEL_N(tint_nr)		((tint_nr) % 4)
-#define ICU_TSSR_TSSEL_PREP(tssel, n)		((tssel) << ((n) * 8))
-#define ICU_TSSR_TSSEL_MASK(n)			ICU_TSSR_TSSEL_PREP(0x7F, n)
-#define ICU_TSSR_TIEN(n)			(BIT(7) << ((n) * 8))
+#define ICU_TSSR_TSSEL_PREP(tssel, n, field_width)	((tssel) << ((n) * (field=
_width)))
+#define ICU_TSSR_TSSEL_MASK(n, field_width)	\
+({\
+		typeof(field_width) (_field_width) =3D (field_width); \
+		ICU_TSSR_TSSEL_PREP((GENMASK(((_field_width) - 2), 0)), (n), _field_width)=
; \
+})
+
+#define ICU_TSSR_TIEN(n, field_width)	\
+({\
+		typeof(field_width) (_field_width) =3D (field_width); \
+		BIT((_field_width) - 1) << ((n) * (_field_width)); \
+})
=20
 #define ICU_TITSR_K(tint_nr)			((tint_nr) / 16)
 #define ICU_TITSR_TITSEL_N(tint_nr)		((tint_nr) % 16)
@@ -78,20 +85,36 @@
=20
 #define ICU_TINT_EXTRACT_HWIRQ(x)		FIELD_GET(GENMASK(15, 0), (x))
 #define ICU_TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
-#define ICU_PB5_TINT				0x55
+#define ICU_RZG3E_TINT_OFFSET			0x800
+#define ICU_RZG3E_TSSEL_MAX_VAL			0x8c
+#define ICU_RZV2H_TSSEL_MAX_VAL			0x55
+
+/**
+ * struct rzv2h_hw_info - Interrupt Control Unit controller hardware info st=
ructure.
+ * @tssel_lut:		TINT lookup table
+ * @t_offs:		TINT offset
+ * @max_tssel:		TSSEL max value
+ * @field_width:	TSSR field width
+ */
+struct rzv2h_hw_info {
+	const u8	*tssel_lut;
+	u16		t_offs;
+	u8		max_tssel;
+	u8		field_width;
+};
=20
 /**
  * struct rzv2h_icu_priv - Interrupt Control Unit controller private data st=
ructure.
  * @base:	Controller's base address
- * @irqchip:	Pointer to struct irq_chip
  * @fwspec:	IRQ firmware specific data
  * @lock:	Lock to serialize access to hardware registers
+ * @info:	Pointer to struct rzv2h_hw_info
  */
 struct rzv2h_icu_priv {
 	void __iomem			*base;
-	const struct irq_chip		*irqchip;
 	struct irq_fwspec		fwspec[ICU_NUM_IRQ];
 	raw_spinlock_t			lock;
+	const struct rzv2h_hw_info	*info;
 };
=20
 static inline struct rzv2h_icu_priv *irq_data_to_priv(struct irq_data *data)
@@ -111,7 +134,7 @@ static void rzv2h_icu_eoi(struct irq_data *d)
 			tintirq_nr =3D hw_irq - ICU_TINT_START;
 			bit =3D BIT(tintirq_nr);
 			if (!irqd_is_level_type(d))
-				writel_relaxed(bit, priv->base + ICU_TSCLR);
+				writel_relaxed(bit, priv->base + priv->info->t_offs + ICU_TSCLR);
 		} else if (hw_irq >=3D ICU_IRQ_START) {
 			tintirq_nr =3D hw_irq - ICU_IRQ_START;
 			bit =3D BIT(tintirq_nr);
@@ -130,21 +153,23 @@ static void rzv2h_tint_irq_endisable(struct irq_data *d=
, bool enable)
 	struct rzv2h_icu_priv *priv =3D irq_data_to_priv(d);
 	unsigned int hw_irq =3D irqd_to_hwirq(d);
 	u32 tint_nr, tssel_n, k, tssr;
+	u8 nr_tint;
=20
 	if (hw_irq < ICU_TINT_START)
 		return;
=20
 	tint_nr =3D hw_irq - ICU_TINT_START;
-	k =3D ICU_TSSR_K(tint_nr);
-	tssel_n =3D ICU_TSSR_TSSEL_N(tint_nr);
+	nr_tint =3D 32 / priv->info->field_width;
+	k =3D tint_nr / nr_tint;
+	tssel_n =3D tint_nr % nr_tint;
=20
 	guard(raw_spinlock)(&priv->lock);
-	tssr =3D readl_relaxed(priv->base + ICU_TSSR(k));
+	tssr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(k));
 	if (enable)
-		tssr |=3D ICU_TSSR_TIEN(tssel_n);
+		tssr |=3D ICU_TSSR_TIEN(tssel_n, priv->info->field_width);
 	else
-		tssr &=3D ~ICU_TSSR_TIEN(tssel_n);
-	writel_relaxed(tssr, priv->base + ICU_TSSR(k));
+		tssr &=3D ~ICU_TSSR_TIEN(tssel_n, priv->info->field_width);
+	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(k));
 }
=20
 static void rzv2h_icu_irq_disable(struct irq_data *d)
@@ -247,8 +272,8 @@ static void rzv2h_clear_tint_int(struct rzv2h_icu_priv *p=
riv, unsigned int hwirq
 	u32 bit =3D BIT(tint_nr);
 	int k =3D tint_nr / 16;
=20
-	tsctr =3D readl_relaxed(priv->base + ICU_TSCTR);
-	titsr =3D readl_relaxed(priv->base + ICU_TITSR(k));
+	tsctr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TSCTR);
+	titsr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TITSR(k));
 	titsel =3D ICU_TITSR_TITSEL_GET(titsr, titsel_n);
=20
 	/*
@@ -257,7 +282,7 @@ static void rzv2h_clear_tint_int(struct rzv2h_icu_priv *p=
riv, unsigned int hwirq
 	 */
 	if ((tsctr & bit) && ((titsel =3D=3D ICU_TINT_EDGE_RISING) ||
 			      (titsel =3D=3D ICU_TINT_EDGE_FALLING)))
-		writel_relaxed(bit, priv->base + ICU_TSCLR);
+		writel_relaxed(bit, priv->base + priv->info->t_offs + ICU_TSCLR);
 }
=20
 static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
@@ -268,6 +293,7 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsign=
ed int type)
 	unsigned int hwirq;
 	u32 tint, sense;
 	int tint_nr;
+	u8 nr_tint;
=20
 	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_LEVEL_LOW:
@@ -290,39 +316,42 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsi=
gned int type)
 		return -EINVAL;
 	}
=20
+	priv =3D irq_data_to_priv(d);
 	tint =3D (u32)(uintptr_t)irq_data_get_irq_chip_data(d);
-	if (tint > ICU_PB5_TINT)
+	if (tint > priv->info->max_tssel)
 		return -EINVAL;
=20
-	priv =3D irq_data_to_priv(d);
-	hwirq =3D irqd_to_hwirq(d);
+	if (priv->info->tssel_lut)
+		tint =3D priv->info->tssel_lut[tint];
=20
+	hwirq =3D irqd_to_hwirq(d);
 	tint_nr =3D hwirq - ICU_TINT_START;
=20
-	tssr_k =3D ICU_TSSR_K(tint_nr);
-	tssel_n =3D ICU_TSSR_TSSEL_N(tint_nr);
+	nr_tint =3D 32 / priv->info->field_width;
+	tssr_k =3D tint_nr / nr_tint;
+	tssel_n =3D tint_nr % nr_tint;
+	tien =3D ICU_TSSR_TIEN(tssel_n, priv->info->field_width);
=20
 	titsr_k =3D ICU_TITSR_K(tint_nr);
 	titsel_n =3D ICU_TITSR_TITSEL_N(tint_nr);
-	tien =3D ICU_TSSR_TIEN(titsel_n);
=20
 	guard(raw_spinlock)(&priv->lock);
=20
-	tssr =3D readl_relaxed(priv->base + ICU_TSSR(tssr_k));
-	tssr &=3D ~(ICU_TSSR_TSSEL_MASK(tssel_n) | tien);
-	tssr |=3D ICU_TSSR_TSSEL_PREP(tint, tssel_n);
+	tssr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
+	tssr &=3D ~(ICU_TSSR_TSSEL_MASK(tssel_n, priv->info->field_width) | tien);
+	tssr |=3D ICU_TSSR_TSSEL_PREP(tint, tssel_n, priv->info->field_width);
=20
-	writel_relaxed(tssr, priv->base + ICU_TSSR(tssr_k));
+	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
=20
-	titsr =3D readl_relaxed(priv->base + ICU_TITSR(titsr_k));
+	titsr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TITSR(titsr_k=
));
 	titsr &=3D ~ICU_TITSR_TITSEL_MASK(titsel_n);
 	titsr |=3D ICU_TITSR_TITSEL_PREP(sense, titsel_n);
=20
-	writel_relaxed(titsr, priv->base + ICU_TITSR(titsr_k));
+	writel_relaxed(titsr, priv->base + priv->info->t_offs + ICU_TITSR(titsr_k));
=20
 	rzv2h_clear_tint_int(priv, hwirq);
=20
-	writel_relaxed(tssr | tien, priv->base + ICU_TSSR(tssr_k));
+	writel_relaxed(tssr | tien, priv->base + priv->info->t_offs + ICU_TSSR(tssr=
_k));
=20
 	return 0;
 }
@@ -390,7 +419,7 @@ static int rzv2h_icu_alloc(struct irq_domain *domain, uns=
igned int virq, unsigne
 	if (hwirq > (ICU_NUM_IRQ - 1))
 		return -EINVAL;
=20
-	ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq, priv->irqchip,
+	ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &rzv2h_icu_chip,
 					    (void *)(uintptr_t)tint);
 	if (ret)
 		return ret;
@@ -421,7 +450,13 @@ static int rzv2h_icu_parse_interrupts(struct rzv2h_icu_p=
riv *priv, struct device
 	return 0;
 }
=20
-static int rzv2h_icu_init(struct device_node *node, struct device_node *pare=
nt)
+static void rzv2h_icu_put_device(void *data)
+{
+	put_device(data);
+}
+
+static int rzv2h_icu_init_common(struct device_node *node, struct device_nod=
e *parent,
+				 const struct rzv2h_hw_info *hw_info)
 {
 	struct irq_domain *irq_domain, *parent_domain;
 	struct rzv2h_icu_priv *rzv2h_icu_data;
@@ -433,50 +468,48 @@ static int rzv2h_icu_init(struct device_node *node, str=
uct device_node *parent)
 	if (!pdev)
 		return -ENODEV;
=20
+	ret =3D devm_add_action_or_reset(&pdev->dev, rzv2h_icu_put_device,
+				       &pdev->dev);
+	if (ret < 0)
+		return ret;
+
 	parent_domain =3D irq_find_host(parent);
 	if (!parent_domain) {
 		dev_err(&pdev->dev, "cannot find parent domain\n");
-		ret =3D -ENODEV;
-		goto put_dev;
+		return -ENODEV;
 	}
=20
 	rzv2h_icu_data =3D devm_kzalloc(&pdev->dev, sizeof(*rzv2h_icu_data), GFP_KE=
RNEL);
-	if (!rzv2h_icu_data) {
-		ret =3D -ENOMEM;
-		goto put_dev;
-	}
-
-	rzv2h_icu_data->irqchip =3D &rzv2h_icu_chip;
+	if (!rzv2h_icu_data)
+		return -ENOMEM;
=20
 	rzv2h_icu_data->base =3D devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NU=
LL);
-	if (IS_ERR(rzv2h_icu_data->base)) {
-		ret =3D PTR_ERR(rzv2h_icu_data->base);
-		goto put_dev;
-	}
+	if (IS_ERR(rzv2h_icu_data->base))
+		return PTR_ERR(rzv2h_icu_data->base);
=20
 	ret =3D rzv2h_icu_parse_interrupts(rzv2h_icu_data, node);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot parse interrupts: %d\n", ret);
-		goto put_dev;
+		return ret;
 	}
=20
-	resetn =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	resetn =3D devm_reset_control_get_exclusive_deasserted(&pdev->dev, NULL);
 	if (IS_ERR(resetn)) {
 		ret =3D PTR_ERR(resetn);
-		goto put_dev;
+		dev_err(&pdev->dev, "failed to acquire deasserted reset: %d\n", ret);
+		return ret;
 	}
=20
-	ret =3D reset_control_deassert(resetn);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to deassert resetn pin, %d\n", ret);
-		goto put_dev;
+	ret =3D devm_pm_runtime_enable(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "devm_pm_runtime_enable failed, %d\n", ret);
+		return ret;
 	}
=20
-	pm_runtime_enable(&pdev->dev);
 	ret =3D pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pm_runtime_resume_and_get failed: %d\n", ret);
-		goto pm_disable;
+		return ret;
 	}
=20
 	raw_spin_lock_init(&rzv2h_icu_data->lock);
@@ -489,6 +522,8 @@ static int rzv2h_icu_init(struct device_node *node, struc=
t device_node *parent)
 		goto pm_put;
 	}
=20
+	rzv2h_icu_data->info =3D hw_info;
+
 	/*
 	 * coccicheck complains about a missing put_device call before returning, b=
ut it's a false
 	 * positive. We still need &pdev->dev after successfully returning from thi=
s function.
@@ -497,16 +532,61 @@ static int rzv2h_icu_init(struct device_node *node, str=
uct device_node *parent)
=20
 pm_put:
 	pm_runtime_put(&pdev->dev);
-pm_disable:
-	pm_runtime_disable(&pdev->dev);
-	reset_control_assert(resetn);
-put_dev:
-	put_device(&pdev->dev);
=20
 	return ret;
 }
=20
+/* Mapping based on port index on Table 4.2-6 and TSSEL bits on Table 4.6-4 =
*/
+static const u8 rzg3e_tssel_lut[] =3D {
+	81, 82, 83, 84, 85, 86, 87, 88,		/* P00-P07 */
+	89, 90, 91, 92, 93, 94, 95, 96,		/* P10-P17 */
+	111, 112,				/* P20-P21 */
+	97, 98, 99, 100, 101, 102, 103, 104,	/* P30-P37 */
+	105, 106, 107, 108, 109, 110,		/* P40-P45 */
+	113, 114, 115, 116, 117, 118, 119,	/* P50-P56 */
+	120, 121, 122, 123, 124, 125, 126,	/* P60-P66 */
+	127, 128, 129, 130, 131, 132, 133, 134,	/* P70-P77 */
+	135, 136, 137, 138, 139, 140,		/* P80-P85 */
+	43, 44, 45, 46, 47, 48, 49, 50,		/* PA0-PA7 */
+	51, 52, 53, 54, 55, 56, 57, 58,		/* PB0-PB7 */
+	59, 60,	61,				/* PC0-PC2 */
+	62, 63, 64, 65, 66, 67, 68, 69,		/* PD0-PD7 */
+	70, 71, 72, 73, 74, 75, 76, 77,		/* PE0-PE7 */
+	78, 79, 80,				/* PF0-PF2 */
+	25, 26, 27, 28, 29, 30, 31, 32,		/* PG0-PG7 */
+	33, 34, 35, 36, 37, 38,			/* PH0-PH5 */
+	4, 5, 6, 7, 8,				/* PJ0-PJ4 */
+	39, 40, 41, 42,				/* PK0-PK3 */
+	9, 10, 11, 12, 21, 22, 23, 24,		/* PL0-PL7 */
+	13, 14, 15, 16, 17, 18, 19, 20,		/* PM0-PM7 */
+	0, 1, 2, 3				/* PS0-PS3 */
+};
+
+static const struct rzv2h_hw_info rzg3e_hw_params =3D {
+	.tssel_lut	=3D rzg3e_tssel_lut,
+	.t_offs		=3D ICU_RZG3E_TINT_OFFSET,
+	.max_tssel	=3D ICU_RZG3E_TSSEL_MAX_VAL,
+	.field_width	=3D 16,
+};
+
+static const struct rzv2h_hw_info rzv2h_hw_params =3D {
+	.t_offs		=3D 0,
+	.max_tssel	=3D ICU_RZV2H_TSSEL_MAX_VAL,
+	.field_width	=3D 8,
+};
+
+static int rzg3e_icu_init(struct device_node *node, struct device_node *pare=
nt)
+{
+	return rzv2h_icu_init_common(node, parent, &rzg3e_hw_params);
+}
+
+static int rzv2h_icu_init(struct device_node *node, struct device_node *pare=
nt)
+{
+	return rzv2h_icu_init_common(node, parent, &rzv2h_hw_params);
+}
+
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzv2h_icu)
+IRQCHIP_MATCH("renesas,r9a09g047-icu", rzg3e_icu_init)
 IRQCHIP_MATCH("renesas,r9a09g057-icu", rzv2h_icu_init)
 IRQCHIP_PLATFORM_DRIVER_END(rzv2h_icu)
 MODULE_AUTHOR("Fabrizio Castro <fabrizio.castro.jz@renesas.com>");
diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-r=
iscv-aplic-direct.c
index 7cd6b646774b..205ad61d15e4 100644
--- a/drivers/irqchip/irq-riscv-aplic-direct.c
+++ b/drivers/irqchip/irq-riscv-aplic-direct.c
@@ -31,7 +31,7 @@ struct aplic_direct {
 };
=20
 struct aplic_idc {
-	unsigned int		hart_index;
+	u32			hart_index;
 	void __iomem		*regs;
 	struct aplic_direct	*direct;
 };
@@ -219,6 +219,20 @@ static int aplic_direct_parse_parent_hwirq(struct device=
 *dev, u32 index,
 	return 0;
 }
=20
+static int aplic_direct_get_hart_index(struct device *dev, u32 logical_index,
+				       u32 *hart_index)
+{
+	const char *prop_hart_index =3D "riscv,hart-indexes";
+	struct device_node *np =3D to_of_node(dev->fwnode);
+
+	if (!np || !of_property_present(np, prop_hart_index)) {
+		*hart_index =3D logical_index;
+		return 0;
+	}
+
+	return of_property_read_u32_index(np, prop_hart_index, logical_index, hart_=
index);
+}
+
 int aplic_direct_setup(struct device *dev, void __iomem *regs)
 {
 	int i, j, rc, cpu, current_cpu, setup_count =3D 0;
@@ -265,8 +279,12 @@ int aplic_direct_setup(struct device *dev, void __iomem =
*regs)
 		cpumask_set_cpu(cpu, &direct->lmask);
=20
 		idc =3D per_cpu_ptr(&aplic_idcs, cpu);
-		idc->hart_index =3D i;
-		idc->regs =3D priv->regs + APLIC_IDC_BASE + i * APLIC_IDC_SIZE;
+		rc =3D aplic_direct_get_hart_index(dev, i, &idc->hart_index);
+		if (rc) {
+			dev_warn(dev, "hart index not found for IDC%d\n", i);
+			continue;
+		}
+		idc->regs =3D priv->regs + APLIC_IDC_BASE + idc->hart_index * APLIC_IDC_SI=
ZE;
 		idc->direct =3D direct;
=20
 		aplic_idc_set_delivery(idc, true);
diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-ri=
scv-imsic-early.c
index c5c2e6929a2f..d2e8ed70d396 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -73,10 +73,16 @@ static int __init imsic_ipi_domain_init(void) { return 0;=
 }
 static void imsic_handle_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	int err, cpu =3D smp_processor_id();
+	int cpu =3D smp_processor_id();
 	struct imsic_vector *vec;
 	unsigned long local_id;
=20
+	/*
+	 * Process pending local synchronization instead of waiting
+	 * for per-CPU local timer to expire.
+	 */
+	imsic_local_sync_all(false);
+
 	chained_irq_enter(chip, desc);
=20
 	while ((local_id =3D csr_swap(CSR_TOPEI, 0))) {
@@ -97,9 +103,7 @@ static void imsic_handle_irq(struct irq_desc *desc)
 			continue;
 		}
=20
-		err =3D generic_handle_domain_irq(imsic->base_domain, vec->hwirq);
-		if (unlikely(err))
-			pr_warn_ratelimited("hwirq 0x%x mapping not found\n", vec->hwirq);
+		generic_handle_irq(vec->irq);
 	}
=20
 	chained_irq_exit(chip, desc);
@@ -120,7 +124,7 @@ static int imsic_starting_cpu(unsigned int cpu)
 	 * Interrupts identities might have been enabled/disabled while
 	 * this CPU was not running so sync-up local enable/disable state.
 	 */
-	imsic_local_sync_all();
+	imsic_local_sync_all(true);
=20
 	/* Enable local interrupt delivery */
 	imsic_local_delivery(true);
diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq=
-riscv-imsic-platform.c
index c708780e8760..b8ae67c25b37 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -20,6 +20,7 @@
 #include <linux/spinlock.h>
 #include <linux/smp.h>
=20
+#include "irq-msi-lib.h"
 #include "irq-riscv-imsic-state.h"
=20
 static bool imsic_cpu_page_phys(unsigned int cpu, unsigned int guest_index,
@@ -63,6 +64,11 @@ static int imsic_irq_retrigger(struct irq_data *d)
 	return 0;
 }
=20
+static void imsic_irq_ack(struct irq_data *d)
+{
+	irq_move_irq(d);
+}
+
 static void imsic_irq_compose_vector_msg(struct imsic_vector *vec, struct ms=
i_msg *msg)
 {
 	phys_addr_t msi_addr;
@@ -96,9 +102,23 @@ static int imsic_irq_set_affinity(struct irq_data *d, con=
st struct cpumask *mask
 				  bool force)
 {
 	struct imsic_vector *old_vec, *new_vec;
-	struct irq_data *pd =3D d->parent_data;
+	struct imsic_vector tmp_vec;
+
+	/*
+	 * Requirements for the downstream irqdomains (or devices):
+	 *
+	 * 1) Downstream irqdomains (or devices) with atomic MSI update can
+	 *    happily do imsic_irq_set_affinity() in the process-context on
+	 *    any CPU so the irqchip of such irqdomains must not set the
+	 *    IRQCHIP_MOVE_DEFERRED flag.
+	 *
+	 * 2) Downstream irqdomains (or devices) with non-atomic MSI update
+	 *    must use imsic_irq_set_affinity() in nterrupt-context upon
+	 *    the next device interrupt so the irqchip of such irqdomains
+	 *    must set the IRQCHIP_MOVE_DEFERRED flag.
+	 */
=20
-	old_vec =3D irq_data_get_irq_chip_data(pd);
+	old_vec =3D irq_data_get_irq_chip_data(d);
 	if (WARN_ON(!old_vec))
 		return -ENOENT;
=20
@@ -111,34 +131,95 @@ static int imsic_irq_set_affinity(struct irq_data *d, c=
onst struct cpumask *mask
 		return -EBUSY;
=20
 	/* Get a new vector on the desired set of CPUs */
-	new_vec =3D imsic_vector_alloc(old_vec->hwirq, mask_val);
+	new_vec =3D imsic_vector_alloc(old_vec->irq, mask_val);
 	if (!new_vec)
 		return -ENOSPC;
=20
+	/*
+	 * Device having non-atomic MSI update might see an intermediate
+	 * state when changing target IMSIC vector from one CPU to another.
+	 *
+	 * To avoid losing interrupt to such intermediate state, do the
+	 * following (just like x86 APIC):
+	 *
+	 * 1) First write a temporary IMSIC vector to the device which
+	 * has MSI address same as the old IMSIC vector but MSI data
+	 * matches the new IMSIC vector.
+	 *
+	 * 2) Next write the new IMSIC vector to the device.
+	 *
+	 * Based on the above, __imsic_local_sync() must check pending
+	 * status of both old MSI data and new MSI data on the old CPU.
+	 */
+	if (!irq_can_move_in_process_context(d) &&
+	    new_vec->local_id !=3D old_vec->local_id) {
+		/* Setup temporary vector */
+		tmp_vec.cpu =3D old_vec->cpu;
+		tmp_vec.local_id =3D new_vec->local_id;
+
+		/* Point device to the temporary vector */
+		imsic_msi_update_msg(irq_get_irq_data(d->irq), &tmp_vec);
+	}
+
 	/* Point device to the new vector */
-	imsic_msi_update_msg(d, new_vec);
+	imsic_msi_update_msg(irq_get_irq_data(d->irq), new_vec);
=20
 	/* Update irq descriptors with the new vector */
-	pd->chip_data =3D new_vec;
+	d->chip_data =3D new_vec;
=20
-	/* Update effective affinity of parent irq data */
-	irq_data_update_effective_affinity(pd, cpumask_of(new_vec->cpu));
+	/* Update effective affinity */
+	irq_data_update_effective_affinity(d, cpumask_of(new_vec->cpu));
=20
 	/* Move state of the old vector to the new vector */
 	imsic_vector_move(old_vec, new_vec);
=20
 	return IRQ_SET_MASK_OK_DONE;
 }
+
+static void imsic_irq_force_complete_move(struct irq_data *d)
+{
+	struct imsic_vector *mvec, *vec =3D irq_data_get_irq_chip_data(d);
+	unsigned int cpu =3D smp_processor_id();
+
+	if (WARN_ON(!vec))
+		return;
+
+	/* Do nothing if there is no in-flight move */
+	mvec =3D imsic_vector_get_move(vec);
+	if (!mvec)
+		return;
+
+	/* Do nothing if the old IMSIC vector does not belong to current CPU */
+	if (mvec->cpu !=3D cpu)
+		return;
+
+	/*
+	 * The best we can do is force cleanup the old IMSIC vector.
+	 *
+	 * The challenges over here are same as x86 vector domain so
+	 * refer to the comments in irq_force_complete_move() function
+	 * implemented at arch/x86/kernel/apic/vector.c.
+	 */
+
+	/* Force cleanup in-flight move */
+	pr_info("IRQ fixup: irq %d move in progress, old vector cpu %d local_id %d\=
n",
+		d->irq, mvec->cpu, mvec->local_id);
+	imsic_vector_force_move_cleanup(vec);
+}
 #endif
=20
 static struct irq_chip imsic_irq_base_chip =3D {
-	.name			=3D "IMSIC",
-	.irq_mask		=3D imsic_irq_mask,
-	.irq_unmask		=3D imsic_irq_unmask,
-	.irq_retrigger		=3D imsic_irq_retrigger,
-	.irq_compose_msi_msg	=3D imsic_irq_compose_msg,
-	.flags			=3D IRQCHIP_SKIP_SET_WAKE |
-				  IRQCHIP_MASK_ON_SUSPEND,
+	.name				=3D "IMSIC",
+	.irq_mask			=3D imsic_irq_mask,
+	.irq_unmask			=3D imsic_irq_unmask,
+#ifdef CONFIG_SMP
+	.irq_set_affinity		=3D imsic_irq_set_affinity,
+	.irq_force_complete_move	=3D imsic_irq_force_complete_move,
+#endif
+	.irq_retrigger			=3D imsic_irq_retrigger,
+	.irq_ack			=3D imsic_irq_ack,
+	.irq_compose_msi_msg		=3D imsic_irq_compose_msg,
+	.flags				=3D IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
 };
=20
 static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int vi=
rq,
@@ -155,7 +236,7 @@ static int imsic_irq_domain_alloc(struct irq_domain *doma=
in, unsigned int virq,
 		return -ENOSPC;
=20
 	irq_domain_set_info(domain, virq, virq, &imsic_irq_base_chip, vec,
-			    handle_simple_irq, NULL, NULL);
+			    handle_edge_irq, NULL, NULL);
 	irq_set_noprobe(virq);
 	irq_set_affinity(virq, cpu_online_mask);
 	irq_data_update_effective_affinity(irq_get_irq_data(virq), cpumask_of(vec->=
cpu));
@@ -172,22 +253,6 @@ static void imsic_irq_domain_free(struct irq_domain *dom=
ain, unsigned int virq,
 	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
 }
=20
-static int imsic_irq_domain_select(struct irq_domain *domain, struct irq_fws=
pec *fwspec,
-				   enum irq_domain_bus_token bus_token)
-{
-	const struct msi_parent_ops *ops =3D domain->msi_parent_ops;
-	u32 busmask =3D BIT(bus_token);
-
-	if (fwspec->fwnode !=3D domain->fwnode || fwspec->param_count !=3D 0)
-		return 0;
-
-	/* Handle pure domain searches */
-	if (bus_token =3D=3D ops->bus_select_token)
-		return 1;
-
-	return !!(ops->bus_select_mask & busmask);
-}
-
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
 static void imsic_irq_debug_show(struct seq_file *m, struct irq_domain *d,
 				 struct irq_data *irqd, int ind)
@@ -204,107 +269,37 @@ static void imsic_irq_debug_show(struct seq_file *m, s=
truct irq_domain *d,
 static const struct irq_domain_ops imsic_base_domain_ops =3D {
 	.alloc		=3D imsic_irq_domain_alloc,
 	.free		=3D imsic_irq_domain_free,
-	.select		=3D imsic_irq_domain_select,
+	.select		=3D msi_lib_irq_domain_select,
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
 	.debug_show	=3D imsic_irq_debug_show,
 #endif
 };
=20
-#ifdef CONFIG_RISCV_IMSIC_PCI
-
-static void imsic_pci_mask_irq(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void imsic_pci_unmask_irq(struct irq_data *d)
+static bool imsic_init_dev_msi_info(struct device *dev, struct irq_domain *d=
omain,
+				    struct irq_domain *real_parent, struct msi_domain_info *info)
 {
-	irq_chip_unmask_parent(d);
-	pci_msi_unmask_irq(d);
-}
-
-#define MATCH_PCI_MSI		BIT(DOMAIN_BUS_PCI_MSI)
-
-#else
-
-#define MATCH_PCI_MSI		0
-
-#endif
-
-static bool imsic_init_dev_msi_info(struct device *dev,
-				    struct irq_domain *domain,
-				    struct irq_domain *real_parent,
-				    struct msi_domain_info *info)
-{
-	const struct msi_parent_ops *pops =3D real_parent->msi_parent_ops;
-
-	/* MSI parent domain specific settings */
-	switch (real_parent->bus_token) {
-	case DOMAIN_BUS_NEXUS:
-		if (WARN_ON_ONCE(domain !=3D real_parent))
-			return false;
-#ifdef CONFIG_SMP
-		info->chip->irq_set_affinity =3D imsic_irq_set_affinity;
-#endif
-		break;
-	default:
-		WARN_ON_ONCE(1);
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
 		return false;
-	}
=20
-	/* Is the target supported? */
 	switch (info->bus_token) {
-#ifdef CONFIG_RISCV_IMSIC_PCI
 	case DOMAIN_BUS_PCI_DEVICE_MSI:
 	case DOMAIN_BUS_PCI_DEVICE_MSIX:
-		info->chip->irq_mask =3D imsic_pci_mask_irq;
-		info->chip->irq_unmask =3D imsic_pci_unmask_irq;
-		break;
-#endif
-	case DOMAIN_BUS_DEVICE_MSI:
-		/*
-		 * Per-device MSI should never have any MSI feature bits
-		 * set. It's sole purpose is to create a dumb interrupt
-		 * chip which has a device specific irq_write_msi_msg()
-		 * callback.
-		 */
-		if (WARN_ON_ONCE(info->flags))
-			return false;
-
-		/* Core managed MSI descriptors */
-		info->flags |=3D MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS |
-			       MSI_FLAG_FREE_MSI_DESCS;
-		break;
-	case DOMAIN_BUS_WIRED_TO_MSI:
+		info->chip->flags |=3D IRQCHIP_MOVE_DEFERRED;
 		break;
 	default:
-		WARN_ON_ONCE(1);
-		return false;
+		break;
 	}
=20
-	/* Use hierarchial chip operations re-trigger */
-	info->chip->irq_retrigger =3D irq_chip_retrigger_hierarchy;
-
-	/*
-	 * Mask out the domain specific MSI feature flags which are not
-	 * supported by the real parent.
-	 */
-	info->flags &=3D pops->supported_flags;
-
-	/* Enforce the required flags */
-	info->flags |=3D pops->required_flags;
-
 	return true;
 }
=20
-#define MATCH_PLATFORM_MSI		BIT(DOMAIN_BUS_PLATFORM_MSI)
-
 static const struct msi_parent_ops imsic_msi_parent_ops =3D {
 	.supported_flags	=3D MSI_GENERIC_FLAGS_MASK |
 				  MSI_FLAG_PCI_MSIX,
 	.required_flags		=3D MSI_FLAG_USE_DEF_DOM_OPS |
-				  MSI_FLAG_USE_DEF_CHIP_OPS,
+				  MSI_FLAG_USE_DEF_CHIP_OPS |
+				  MSI_FLAG_PCI_MSI_MASK_PARENT,
+	.chip_flags		=3D MSI_CHIP_FLAG_SET_ACK,
 	.bus_select_token	=3D DOMAIN_BUS_NEXUS,
 	.bus_select_mask	=3D MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
 	.init_dev_msi_info	=3D imsic_init_dev_msi_info,
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-ri=
scv-imsic-state.c
index b97e6cd89ed7..bdf5cd2037f2 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -124,10 +124,11 @@ void __imsic_eix_update(unsigned long base_id, unsigned=
 long num_id, bool pend,
 	}
 }
=20
-static void __imsic_local_sync(struct imsic_local_priv *lpriv)
+static bool __imsic_local_sync(struct imsic_local_priv *lpriv)
 {
-	struct imsic_local_config *mlocal;
-	struct imsic_vector *vec, *mvec;
+	struct imsic_local_config *tlocal, *mlocal;
+	struct imsic_vector *vec, *tvec, *mvec;
+	bool ret =3D true;
 	int i;
=20
 	lockdep_assert_held(&lpriv->lock);
@@ -143,35 +144,97 @@ static void __imsic_local_sync(struct imsic_local_priv =
*lpriv)
 			__imsic_id_clear_enable(i);
=20
 		/*
-		 * If the ID was being moved to a new ID on some other CPU
-		 * then we can get a MSI during the movement so check the
-		 * ID pending bit and re-trigger the new ID on other CPU
-		 * using MMIO write.
+		 * Clear the previous vector pointer of the new vector only
+		 * after the movement is complete on the old CPU.
 		 */
-		mvec =3D READ_ONCE(vec->move);
-		WRITE_ONCE(vec->move, NULL);
-		if (mvec && mvec !=3D vec) {
-			if (__imsic_id_read_clear_pending(i)) {
+		mvec =3D READ_ONCE(vec->move_prev);
+		if (mvec) {
+			/*
+			 * If the old vector has not been updated then
+			 * try again in the next sync-up call.
+			 */
+			if (READ_ONCE(mvec->move_next)) {
+				ret =3D false;
+				continue;
+			}
+
+			WRITE_ONCE(vec->move_prev, NULL);
+		}
+
+		/*
+		 * If a vector was being moved to a new vector on some other
+		 * CPU then we can get a MSI during the movement so check the
+		 * ID pending bit and re-trigger the new ID on other CPU using
+		 * MMIO write.
+		 */
+		mvec =3D READ_ONCE(vec->move_next);
+		if (mvec) {
+			/*
+			 * Devices having non-atomic MSI update might see
+			 * an intermediate state so check both old ID and
+			 * new ID for pending interrupts.
+			 *
+			 * For details, see imsic_irq_set_affinity().
+			 */
+			tvec =3D vec->local_id =3D=3D mvec->local_id ?
+				NULL : &lpriv->vectors[mvec->local_id];
+
+			if (tvec && !irq_can_move_in_process_context(irq_get_irq_data(vec->irq)) =
&&
+			    __imsic_id_read_clear_pending(tvec->local_id)) {
+				/* Retrigger temporary vector if it was already in-use */
+				if (READ_ONCE(tvec->enable)) {
+					tlocal =3D per_cpu_ptr(imsic->global.local, tvec->cpu);
+					writel_relaxed(tvec->local_id, tlocal->msi_va);
+				}
+
+				mlocal =3D per_cpu_ptr(imsic->global.local, mvec->cpu);
+				writel_relaxed(mvec->local_id, mlocal->msi_va);
+			}
+
+			if (__imsic_id_read_clear_pending(vec->local_id)) {
 				mlocal =3D per_cpu_ptr(imsic->global.local, mvec->cpu);
 				writel_relaxed(mvec->local_id, mlocal->msi_va);
 			}
=20
-			imsic_vector_free(&lpriv->vectors[i]);
+			WRITE_ONCE(vec->move_next, NULL);
+			imsic_vector_free(vec);
 		}
=20
 skip:
 		bitmap_clear(lpriv->dirty_bitmap, i, 1);
 	}
+
+	return ret;
 }
=20
-void imsic_local_sync_all(void)
+#ifdef CONFIG_SMP
+static void __imsic_local_timer_start(struct imsic_local_priv *lpriv)
+{
+	lockdep_assert_held(&lpriv->lock);
+
+	if (!timer_pending(&lpriv->timer)) {
+		lpriv->timer.expires =3D jiffies + 1;
+		add_timer_on(&lpriv->timer, smp_processor_id());
+	}
+}
+#else
+static inline void __imsic_local_timer_start(struct imsic_local_priv *lpriv)
+{
+}
+#endif
+
+void imsic_local_sync_all(bool force_all)
 {
 	struct imsic_local_priv *lpriv =3D this_cpu_ptr(imsic->lpriv);
 	unsigned long flags;
=20
 	raw_spin_lock_irqsave(&lpriv->lock, flags);
-	bitmap_fill(lpriv->dirty_bitmap, imsic->global.nr_ids + 1);
-	__imsic_local_sync(lpriv);
+
+	if (force_all)
+		bitmap_fill(lpriv->dirty_bitmap, imsic->global.nr_ids + 1);
+	if (!__imsic_local_sync(lpriv))
+		__imsic_local_timer_start(lpriv);
+
 	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
 }
=20
@@ -190,12 +253,7 @@ void imsic_local_delivery(bool enable)
 #ifdef CONFIG_SMP
 static void imsic_local_timer_callback(struct timer_list *timer)
 {
-	struct imsic_local_priv *lpriv =3D this_cpu_ptr(imsic->lpriv);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&lpriv->lock, flags);
-	__imsic_local_sync(lpriv);
-	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
+	imsic_local_sync_all(false);
 }
=20
 static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsigned int=
 cpu)
@@ -216,14 +274,11 @@ static void __imsic_remote_sync(struct imsic_local_priv=
 *lpriv, unsigned int cpu
 	 */
 	if (cpu_online(cpu)) {
 		if (cpu =3D=3D smp_processor_id()) {
-			__imsic_local_sync(lpriv);
-			return;
+			if (__imsic_local_sync(lpriv))
+				return;
 		}
=20
-		if (!timer_pending(&lpriv->timer)) {
-			lpriv->timer.expires =3D jiffies + 1;
-			add_timer_on(&lpriv->timer, cpu);
-		}
+		__imsic_local_timer_start(lpriv);
 	}
 }
 #else
@@ -278,8 +333,26 @@ void imsic_vector_unmask(struct imsic_vector *vec)
 	raw_spin_unlock(&lpriv->lock);
 }
=20
-static bool imsic_vector_move_update(struct imsic_local_priv *lpriv, struct =
imsic_vector *vec,
-				     bool new_enable, struct imsic_vector *new_move)
+void imsic_vector_force_move_cleanup(struct imsic_vector *vec)
+{
+	struct imsic_local_priv *lpriv;
+	struct imsic_vector *mvec;
+	unsigned long flags;
+
+	lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
+	raw_spin_lock_irqsave(&lpriv->lock, flags);
+
+	mvec =3D READ_ONCE(vec->move_prev);
+	WRITE_ONCE(vec->move_prev, NULL);
+	if (mvec)
+		imsic_vector_free(mvec);
+
+	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
+}
+
+static bool imsic_vector_move_update(struct imsic_local_priv *lpriv,
+				     struct imsic_vector *vec, bool is_old_vec,
+				     bool new_enable, struct imsic_vector *move_vec)
 {
 	unsigned long flags;
 	bool enabled;
@@ -289,7 +362,10 @@ static bool imsic_vector_move_update(struct imsic_local_=
priv *lpriv, struct imsi
 	/* Update enable and move details */
 	enabled =3D READ_ONCE(vec->enable);
 	WRITE_ONCE(vec->enable, new_enable);
-	WRITE_ONCE(vec->move, new_move);
+	if (is_old_vec)
+		WRITE_ONCE(vec->move_next, move_vec);
+	else
+		WRITE_ONCE(vec->move_prev, move_vec);
=20
 	/* Mark the vector as dirty and synchronize */
 	bitmap_set(lpriv->dirty_bitmap, vec->local_id, 1);
@@ -322,8 +398,8 @@ void imsic_vector_move(struct imsic_vector *old_vec, stru=
ct imsic_vector *new_ve
 	 * interrupt on the old vector while device was being moved
 	 * to the new vector.
 	 */
-	enabled =3D imsic_vector_move_update(old_lpriv, old_vec, false, new_vec);
-	imsic_vector_move_update(new_lpriv, new_vec, enabled, new_vec);
+	enabled =3D imsic_vector_move_update(old_lpriv, old_vec, true, false, new_v=
ec);
+	imsic_vector_move_update(new_lpriv, new_vec, false, enabled, old_vec);
 }
=20
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
@@ -368,7 +444,7 @@ struct imsic_vector *imsic_vector_from_local_id(unsigned =
int cpu, unsigned int l
 	return &lpriv->vectors[local_id];
 }
=20
-struct imsic_vector *imsic_vector_alloc(unsigned int hwirq, const struct cpu=
mask *mask)
+struct imsic_vector *imsic_vector_alloc(unsigned int irq, const struct cpuma=
sk *mask)
 {
 	struct imsic_vector *vec =3D NULL;
 	struct imsic_local_priv *lpriv;
@@ -384,9 +460,10 @@ struct imsic_vector *imsic_vector_alloc(unsigned int hwi=
rq, const struct cpumask
=20
 	lpriv =3D per_cpu_ptr(imsic->lpriv, cpu);
 	vec =3D &lpriv->vectors[local_id];
-	vec->hwirq =3D hwirq;
+	vec->irq =3D irq;
 	vec->enable =3D false;
-	vec->move =3D NULL;
+	vec->move_next =3D NULL;
+	vec->move_prev =3D NULL;
=20
 	return vec;
 }
@@ -396,7 +473,7 @@ void imsic_vector_free(struct imsic_vector *vec)
 	unsigned long flags;
=20
 	raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
-	vec->hwirq =3D UINT_MAX;
+	vec->irq =3D 0;
 	irq_matrix_free(imsic->matrix, vec->cpu, vec->local_id, false);
 	raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
 }
@@ -455,7 +532,7 @@ static int __init imsic_local_init(void)
 			vec =3D &lpriv->vectors[i];
 			vec->cpu =3D cpu;
 			vec->local_id =3D i;
-			vec->hwirq =3D UINT_MAX;
+			vec->irq =3D 0;
 		}
 	}
=20
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-ri=
scv-imsic-state.h
index 391e44280827..3202ffa4e849 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -20,10 +20,11 @@ struct imsic_vector {
 	unsigned int				cpu;
 	unsigned int				local_id;
 	/* Details saved by driver in the vector */
-	unsigned int				hwirq;
+	unsigned int				irq;
 	/* Details accessed using local lock held */
 	bool					enable;
-	struct imsic_vector			*move;
+	struct imsic_vector			*move_next;
+	struct imsic_vector			*move_prev;
 };
=20
 struct imsic_local_priv {
@@ -74,7 +75,7 @@ static inline void __imsic_id_clear_enable(unsigned long id)
 	__imsic_eix_update(id, 1, false, false);
 }
=20
-void imsic_local_sync_all(void);
+void imsic_local_sync_all(bool force_all);
 void imsic_local_delivery(bool enable);
=20
 void imsic_vector_mask(struct imsic_vector *vec);
@@ -87,14 +88,15 @@ static inline bool imsic_vector_isenabled(struct imsic_ve=
ctor *vec)
=20
 static inline struct imsic_vector *imsic_vector_get_move(struct imsic_vector=
 *vec)
 {
-	return READ_ONCE(vec->move);
+	return READ_ONCE(vec->move_prev);
 }
=20
+void imsic_vector_force_move_cleanup(struct imsic_vector *vec);
 void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *ne=
w_vec);
=20
 struct imsic_vector *imsic_vector_from_local_id(unsigned int cpu, unsigned i=
nt local_id);
=20
-struct imsic_vector *imsic_vector_alloc(unsigned int hwirq, const struct cpu=
mask *mask);
+struct imsic_vector *imsic_vector_alloc(unsigned int irq, const struct cpuma=
sk *mask);
 void imsic_vector_free(struct imsic_vector *vector);
=20
 void imsic_vector_debug_show(struct seq_file *m, struct imsic_vector *vec, i=
nt ind);
diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-ms=
i.c
new file mode 100644
index 000000000000..ee682e87eb8b
--- /dev/null
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SG2042 MSI Controller
+ *
+ * Copyright (C) 2024 Sophgo Technology Inc.
+ * Copyright (C) 2024 Chen Wang <unicorn_wang@outlook.com>
+ */
+
+#include <linux/cleanup.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+#include "irq-msi-lib.h"
+
+#define SG2042_MAX_MSI_VECTOR	32
+
+struct sg2042_msi_chipdata {
+	void __iomem	*reg_clr;	// clear reg, see TRM, 10.1.33, GP_INTR0_CLR
+
+	phys_addr_t	doorbell_addr;	// see TRM, 10.1.32, GP_INTR0_SET
+
+	u32		irq_first;	// The vector number that MSIs starts
+	u32		num_irqs;	// The number of vectors for MSIs
+
+	DECLARE_BITMAP(msi_map, SG2042_MAX_MSI_VECTOR);
+	struct mutex	msi_map_lock;	// lock for msi_map
+};
+
+static int sg2042_msi_allocate_hwirq(struct sg2042_msi_chipdata *data, int n=
um_req)
+{
+	int first;
+
+	guard(mutex)(&data->msi_map_lock);
+	first =3D bitmap_find_free_region(data->msi_map, data->num_irqs,
+					get_count_order(num_req));
+	return first >=3D 0 ? first : -ENOSPC;
+}
+
+static void sg2042_msi_free_hwirq(struct sg2042_msi_chipdata *data, int hwir=
q, int num_req)
+{
+	guard(mutex)(&data->msi_map_lock);
+	bitmap_release_region(data->msi_map, hwirq, get_count_order(num_req));
+}
+
+static void sg2042_msi_irq_ack(struct irq_data *d)
+{
+	struct sg2042_msi_chipdata *data  =3D irq_data_get_irq_chip_data(d);
+	int bit_off =3D d->hwirq;
+
+	writel(1 << bit_off, data->reg_clr);
+
+	irq_chip_ack_parent(d);
+}
+
+static void sg2042_msi_irq_compose_msi_msg(struct irq_data *d, struct msi_ms=
g *msg)
+{
+	struct sg2042_msi_chipdata *data =3D irq_data_get_irq_chip_data(d);
+
+	msg->address_hi =3D upper_32_bits(data->doorbell_addr);
+	msg->address_lo =3D lower_32_bits(data->doorbell_addr);
+	msg->data =3D 1 << d->hwirq;
+}
+
+static const struct irq_chip sg2042_msi_middle_irq_chip =3D {
+	.name			=3D "SG2042 MSI",
+	.irq_ack		=3D sg2042_msi_irq_ack,
+	.irq_mask		=3D irq_chip_mask_parent,
+	.irq_unmask		=3D irq_chip_unmask_parent,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
+#endif
+	.irq_compose_msi_msg	=3D sg2042_msi_irq_compose_msi_msg,
+};
+
+static int sg2042_msi_parent_domain_alloc(struct irq_domain *domain, unsigne=
d int virq, int hwirq)
+{
+	struct sg2042_msi_chipdata *data =3D domain->host_data;
+	struct irq_fwspec fwspec;
+	struct irq_data *d;
+	int ret;
+
+	fwspec.fwnode =3D domain->parent->fwnode;
+	fwspec.param_count =3D 2;
+	fwspec.param[0] =3D data->irq_first + hwirq;
+	fwspec.param[1] =3D IRQ_TYPE_EDGE_RISING;
+
+	ret =3D irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
+	if (ret)
+		return ret;
+
+	d =3D irq_domain_get_irq_data(domain->parent, virq);
+	return d->chip->irq_set_type(d, IRQ_TYPE_EDGE_RISING);
+}
+
+static int sg2042_msi_middle_domain_alloc(struct irq_domain *domain, unsigne=
d int virq,
+					  unsigned int nr_irqs, void *args)
+{
+	struct sg2042_msi_chipdata *data =3D domain->host_data;
+	int hwirq, err, i;
+
+	hwirq =3D sg2042_msi_allocate_hwirq(data, nr_irqs);
+	if (hwirq < 0)
+		return hwirq;
+
+	for (i =3D 0; i < nr_irqs; i++) {
+		err =3D sg2042_msi_parent_domain_alloc(domain, virq + i, hwirq + i);
+		if (err)
+			goto err_hwirq;
+
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &sg2042_msi_middle_irq_chip, data);
+	}
+
+	return 0;
+
+err_hwirq:
+	sg2042_msi_free_hwirq(data, hwirq, nr_irqs);
+	irq_domain_free_irqs_parent(domain, virq, i);
+
+	return err;
+}
+
+static void sg2042_msi_middle_domain_free(struct irq_domain *domain, unsigne=
d int virq,
+					  unsigned int nr_irqs)
+{
+	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
+	struct sg2042_msi_chipdata *data =3D irq_data_get_irq_chip_data(d);
+
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+	sg2042_msi_free_hwirq(data, d->hwirq, nr_irqs);
+}
+
+static const struct irq_domain_ops sg2042_msi_middle_domain_ops =3D {
+	.alloc	=3D sg2042_msi_middle_domain_alloc,
+	.free	=3D sg2042_msi_middle_domain_free,
+	.select	=3D msi_lib_irq_domain_select,
+};
+
+#define SG2042_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				   MSI_FLAG_USE_DEF_CHIP_OPS)
+
+#define SG2042_MSI_FLAGS_SUPPORTED MSI_GENERIC_FLAGS_MASK
+
+static const struct msi_parent_ops sg2042_msi_parent_ops =3D {
+	.required_flags		=3D SG2042_MSI_FLAGS_REQUIRED,
+	.supported_flags	=3D SG2042_MSI_FLAGS_SUPPORTED,
+	.bus_select_mask	=3D MATCH_PCI_MSI,
+	.bus_select_token	=3D DOMAIN_BUS_NEXUS,
+	.prefix			=3D "SG2042-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
+};
+
+static int sg2042_msi_init_domains(struct sg2042_msi_chipdata *data,
+				   struct irq_domain *plic_domain, struct device *dev)
+{
+	struct fwnode_handle *fwnode =3D dev_fwnode(dev);
+	struct irq_domain *middle_domain;
+
+	middle_domain =3D irq_domain_create_hierarchy(plic_domain, 0, data->num_irq=
s, fwnode,
+						    &sg2042_msi_middle_domain_ops, data);
+	if (!middle_domain) {
+		pr_err("Failed to create the MSI middle domain\n");
+		return -ENOMEM;
+	}
+
+	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
+
+	middle_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
+	middle_domain->msi_parent_ops =3D &sg2042_msi_parent_ops;
+
+	return 0;
+}
+
+static int sg2042_msi_probe(struct platform_device *pdev)
+{
+	struct fwnode_reference_args args =3D { };
+	struct sg2042_msi_chipdata *data;
+	struct device *dev =3D &pdev->dev;
+	struct irq_domain *plic_domain;
+	struct resource *res;
+	int ret;
+
+	data =3D devm_kzalloc(dev, sizeof(struct sg2042_msi_chipdata), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->reg_clr =3D devm_platform_ioremap_resource_byname(pdev, "clr");
+	if (IS_ERR(data->reg_clr)) {
+		dev_err(dev, "Failed to map clear register\n");
+		return PTR_ERR(data->reg_clr);
+	}
+
+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "doorbell");
+	if (!res) {
+		dev_err(dev, "Failed get resource from set\n");
+		return -EINVAL;
+	}
+	data->doorbell_addr =3D res->start;
+
+	ret =3D fwnode_property_get_reference_args(dev_fwnode(dev), "msi-ranges",
+						 "#interrupt-cells", 0, 0, &args);
+	if (ret) {
+		dev_err(dev, "Unable to parse MSI vec base\n");
+		return ret;
+	}
+	fwnode_handle_put(args.fwnode);
+
+	ret =3D fwnode_property_get_reference_args(dev_fwnode(dev), "msi-ranges", N=
ULL,
+						 args.nargs + 1, 0, &args);
+	if (ret) {
+		dev_err(dev, "Unable to parse MSI vec number\n");
+		return ret;
+	}
+
+	plic_domain =3D irq_find_matching_fwnode(args.fwnode, DOMAIN_BUS_ANY);
+	fwnode_handle_put(args.fwnode);
+	if (!plic_domain) {
+		pr_err("Failed to find the PLIC domain\n");
+		return -ENXIO;
+	}
+
+	data->irq_first =3D (u32)args.args[0];
+	data->num_irqs =3D (u32)args.args[args.nargs - 1];
+
+	mutex_init(&data->msi_map_lock);
+
+	return sg2042_msi_init_domains(data, plic_domain, dev);
+}
+
+static const struct of_device_id sg2042_msi_of_match[] =3D {
+	{ .compatible	=3D "sophgo,sg2042-msi" },
+	{ }
+};
+
+static struct platform_driver sg2042_msi_driver =3D {
+	.driver =3D {
+		.name		=3D "sg2042-msi",
+		.of_match_table	=3D sg2042_msi_of_match,
+	},
+	.probe =3D sg2042_msi_probe,
+};
+builtin_platform_driver(sg2042_msi_driver);
diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index 0b4312152024..01b0d8321728 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -48,32 +48,41 @@ enum {
 	SUNXI_SRC_TYPE_EDGE_RISING,
 };
=20
-struct sunxi_sc_nmi_reg_offs {
-	u32 ctrl;
-	u32 pend;
-	u32 enable;
+struct sunxi_sc_nmi_data {
+	struct {
+		u32	ctrl;
+		u32	pend;
+		u32	enable;
+	} reg_offs;
+	u32		enable_val;
 };
=20
-static const struct sunxi_sc_nmi_reg_offs sun6i_reg_offs __initconst =3D {
-	.ctrl	=3D SUN6I_NMI_CTRL,
-	.pend	=3D SUN6I_NMI_PENDING,
-	.enable	=3D SUN6I_NMI_ENABLE,
+static const struct sunxi_sc_nmi_data sun6i_data __initconst =3D {
+	.reg_offs.ctrl		=3D SUN6I_NMI_CTRL,
+	.reg_offs.pend		=3D SUN6I_NMI_PENDING,
+	.reg_offs.enable	=3D SUN6I_NMI_ENABLE,
 };
=20
-static const struct sunxi_sc_nmi_reg_offs sun7i_reg_offs __initconst =3D {
-	.ctrl	=3D SUN7I_NMI_CTRL,
-	.pend	=3D SUN7I_NMI_PENDING,
-	.enable	=3D SUN7I_NMI_ENABLE,
+static const struct sunxi_sc_nmi_data sun7i_data __initconst =3D {
+	.reg_offs.ctrl		=3D SUN7I_NMI_CTRL,
+	.reg_offs.pend		=3D SUN7I_NMI_PENDING,
+	.reg_offs.enable	=3D SUN7I_NMI_ENABLE,
 };
=20
-static const struct sunxi_sc_nmi_reg_offs sun9i_reg_offs __initconst =3D {
-	.ctrl	=3D SUN9I_NMI_CTRL,
-	.pend	=3D SUN9I_NMI_PENDING,
-	.enable	=3D SUN9I_NMI_ENABLE,
+static const struct sunxi_sc_nmi_data sun9i_data __initconst =3D {
+	.reg_offs.ctrl		=3D SUN9I_NMI_CTRL,
+	.reg_offs.pend		=3D SUN9I_NMI_PENDING,
+	.reg_offs.enable	=3D SUN9I_NMI_ENABLE,
 };
=20
-static inline void sunxi_sc_nmi_write(struct irq_chip_generic *gc, u32 off,
-				      u32 val)
+static const struct sunxi_sc_nmi_data sun55i_a523_data __initconst =3D {
+	.reg_offs.ctrl		=3D SUN9I_NMI_CTRL,
+	.reg_offs.pend		=3D SUN9I_NMI_PENDING,
+	.reg_offs.enable	=3D SUN9I_NMI_ENABLE,
+	.enable_val		=3D BIT(31),
+};
+
+static inline void sunxi_sc_nmi_write(struct irq_chip_generic *gc, u32 off, =
u32 val)
 {
 	irq_reg_writel(gc, val, off);
 }
@@ -143,15 +152,13 @@ static int sunxi_sc_nmi_set_type(struct irq_data *data,=
 unsigned int flow_type)
 }
=20
 static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
-					const struct sunxi_sc_nmi_reg_offs *reg_offs)
+					const struct sunxi_sc_nmi_data *data)
 {
-	struct irq_domain *domain;
+	unsigned int irq, clr =3D IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	struct irq_chip_generic *gc;
-	unsigned int irq;
-	unsigned int clr =3D IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
+	struct irq_domain *domain;
 	int ret;
=20
-
 	domain =3D irq_domain_add_linear(node, 1, &irq_generic_chip_ops, NULL);
 	if (!domain) {
 		pr_err("Could not register interrupt domain.\n");
@@ -186,27 +193,28 @@ static int __init sunxi_sc_nmi_irq_init(struct device_n=
ode *node,
 	gc->chip_types[0].chip.irq_unmask	=3D irq_gc_mask_set_bit;
 	gc->chip_types[0].chip.irq_eoi		=3D irq_gc_ack_set_bit;
 	gc->chip_types[0].chip.irq_set_type	=3D sunxi_sc_nmi_set_type;
-	gc->chip_types[0].chip.flags		=3D IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HAN=
DLED |
+	gc->chip_types[0].chip.flags		=3D IRQCHIP_EOI_THREADED |
+						  IRQCHIP_EOI_IF_HANDLED |
 						  IRQCHIP_SKIP_SET_WAKE;
-	gc->chip_types[0].regs.ack		=3D reg_offs->pend;
-	gc->chip_types[0].regs.mask		=3D reg_offs->enable;
-	gc->chip_types[0].regs.type		=3D reg_offs->ctrl;
+	gc->chip_types[0].regs.ack		=3D data->reg_offs.pend;
+	gc->chip_types[0].regs.mask		=3D data->reg_offs.enable;
+	gc->chip_types[0].regs.type		=3D data->reg_offs.ctrl;
=20
 	gc->chip_types[1].type			=3D IRQ_TYPE_EDGE_BOTH;
 	gc->chip_types[1].chip.irq_ack		=3D irq_gc_ack_set_bit;
 	gc->chip_types[1].chip.irq_mask		=3D irq_gc_mask_clr_bit;
 	gc->chip_types[1].chip.irq_unmask	=3D irq_gc_mask_set_bit;
 	gc->chip_types[1].chip.irq_set_type	=3D sunxi_sc_nmi_set_type;
-	gc->chip_types[1].regs.ack		=3D reg_offs->pend;
-	gc->chip_types[1].regs.mask		=3D reg_offs->enable;
-	gc->chip_types[1].regs.type		=3D reg_offs->ctrl;
+	gc->chip_types[1].regs.ack		=3D data->reg_offs.pend;
+	gc->chip_types[1].regs.mask		=3D data->reg_offs.enable;
+	gc->chip_types[1].regs.type		=3D data->reg_offs.ctrl;
 	gc->chip_types[1].handler		=3D handle_edge_irq;
=20
 	/* Disable any active interrupts */
-	sunxi_sc_nmi_write(gc, reg_offs->enable, 0);
+	sunxi_sc_nmi_write(gc, data->reg_offs.enable, data->enable_val);
=20
 	/* Clear any pending NMI interrupts */
-	sunxi_sc_nmi_write(gc, reg_offs->pend, SUNXI_NMI_IRQ_BIT);
+	sunxi_sc_nmi_write(gc, data->reg_offs.pend, SUNXI_NMI_IRQ_BIT);
=20
 	irq_set_chained_handler_and_data(irq, sunxi_sc_nmi_handle_irq, domain);
=20
@@ -221,20 +229,27 @@ static int __init sunxi_sc_nmi_irq_init(struct device_n=
ode *node,
 static int __init sun6i_sc_nmi_irq_init(struct device_node *node,
 					struct device_node *parent)
 {
-	return sunxi_sc_nmi_irq_init(node, &sun6i_reg_offs);
+	return sunxi_sc_nmi_irq_init(node, &sun6i_data);
 }
 IRQCHIP_DECLARE(sun6i_sc_nmi, "allwinner,sun6i-a31-sc-nmi", sun6i_sc_nmi_irq=
_init);
=20
 static int __init sun7i_sc_nmi_irq_init(struct device_node *node,
 					struct device_node *parent)
 {
-	return sunxi_sc_nmi_irq_init(node, &sun7i_reg_offs);
+	return sunxi_sc_nmi_irq_init(node, &sun7i_data);
 }
 IRQCHIP_DECLARE(sun7i_sc_nmi, "allwinner,sun7i-a20-sc-nmi", sun7i_sc_nmi_irq=
_init);
=20
 static int __init sun9i_nmi_irq_init(struct device_node *node,
 				     struct device_node *parent)
 {
-	return sunxi_sc_nmi_irq_init(node, &sun9i_reg_offs);
+	return sunxi_sc_nmi_irq_init(node, &sun9i_data);
 }
 IRQCHIP_DECLARE(sun9i_nmi, "allwinner,sun9i-a80-nmi", sun9i_nmi_irq_init);
+
+static int __init sun55i_nmi_irq_init(struct device_node *node,
+				      struct device_node *parent)
+{
+	return sunxi_sc_nmi_irq_init(node, &sun55i_a523_data);
+}
+IRQCHIP_DECLARE(sun55i_nmi, "allwinner,sun55i-a523-nmi", sun55i_nmi_irq_init=
);
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 8daa17f0107a..dd5df1e2d032 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -486,6 +486,7 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_da=
ta *d)
  * @ipi_send_mask:	send an IPI to destination cpus in cpumask
  * @irq_nmi_setup:	function called from core code before enabling an NMI
  * @irq_nmi_teardown:	function called from core code after disabling an NMI
+ * @irq_force_complete_move:	optional function to force complete pending irq=
 move
  * @flags:		chip specific flags
  */
 struct irq_chip {
@@ -537,6 +538,8 @@ struct irq_chip {
 	int		(*irq_nmi_setup)(struct irq_data *data);
 	void		(*irq_nmi_teardown)(struct irq_data *data);
=20
+	void		(*irq_force_complete_move)(struct irq_data *data);
+
 	unsigned long	flags;
 };
=20
@@ -612,6 +615,7 @@ extern int irq_affinity_online_cpu(unsigned int cpu);
 #endif
=20
 #if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_PENDING_IRQ)
+bool irq_can_move_in_process_context(struct irq_data *data);
 void __irq_move_irq(struct irq_data *data);
 static inline void irq_move_irq(struct irq_data *data)
 {
@@ -619,11 +623,10 @@ static inline void irq_move_irq(struct irq_data *data)
 		__irq_move_irq(data);
 }
 void irq_move_masked_irq(struct irq_data *data);
-void irq_force_complete_move(struct irq_desc *desc);
 #else
+static inline bool irq_can_move_in_process_context(struct irq_data *data) { =
return true; }
 static inline void irq_move_irq(struct irq_data *data) { }
 static inline void irq_move_masked_irq(struct irq_data *data) { }
-static inline void irq_force_complete_move(struct irq_desc *desc) { }
 #endif
=20
 extern int no_irq_affinity;
diff --git a/include/linux/irqchip/irq-davinci-cp-intc.h b/include/linux/irqc=
hip/irq-davinci-cp-intc.h
deleted file mode 100644
index 8d71ed5b5a61..000000000000
--- a/include/linux/irqchip/irq-davinci-cp-intc.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2019 Texas Instruments
- */
-
-#ifndef _LINUX_IRQ_DAVINCI_CP_INTC_
-#define _LINUX_IRQ_DAVINCI_CP_INTC_
-
-#include <linux/ioport.h>
-
-/**
- * struct davinci_cp_intc_config - configuration data for davinci-cp-intc
- *                                 driver.
- *
- * @reg: register range to map
- * @num_irqs: number of HW interrupts supported by the controller
- */
-struct davinci_cp_intc_config {
-	struct resource reg;
-	unsigned int num_irqs;
-};
-
-int davinci_cp_intc_init(const struct davinci_cp_intc_config *config);
-
-#endif /* _LINUX_IRQ_DAVINCI_CP_INTC_ */
diff --git a/include/linux/msi.h b/include/linux/msi.h
index b10093c4d00e..9abef442c146 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -558,11 +558,21 @@ enum {
 	MSI_FLAG_NO_AFFINITY		=3D (1 << 21),
 };
=20
+/*
+ * Flags for msi_parent_ops::chip_flags
+ */
+enum {
+	MSI_CHIP_FLAG_SET_EOI		=3D (1 << 0),
+	MSI_CHIP_FLAG_SET_ACK		=3D (1 << 1),
+};
+
 /**
  * struct msi_parent_ops - MSI parent domain callbacks and configuration info
  *
  * @supported_flags:	Required: The supported MSI flags of the parent domain
  * @required_flags:	Optional: The required MSI flags of the parent MSI domain
+ * @chip_flags:		Optional: Select MSI chip callbacks to update with defaults
+ *			in msi_lib_init_dev_msi_info().
  * @bus_select_token:	Optional: The bus token of the real parent domain for
  *			irq_domain::select()
  * @bus_select_mask:	Optional: A mask of supported BUS_DOMAINs for
@@ -575,6 +585,7 @@ enum {
 struct msi_parent_ops {
 	u32		supported_flags;
 	u32		required_flags;
+	u32		chip_flags;
 	u32		bus_select_token;
 	u32		bus_select_mask;
 	const char	*prefix;
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index a979523640d0..d4e190e690bd 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -442,6 +442,7 @@ static inline struct cpumask *irq_desc_get_pending_mask(s=
truct irq_desc *desc)
 	return desc->pending_mask;
 }
 bool irq_fixup_move_pending(struct irq_desc *desc, bool force_clear);
+void irq_force_complete_move(struct irq_desc *desc);
 #else /* CONFIG_GENERIC_PENDING_IRQ */
 static inline bool irq_can_move_pcntxt(struct irq_data *data)
 {
@@ -467,6 +468,7 @@ static inline bool irq_fixup_move_pending(struct irq_desc=
 *desc, bool fclear)
 {
 	return false;
 }
+static inline void irq_force_complete_move(struct irq_desc *desc) { }
 #endif /* !CONFIG_GENERIC_PENDING_IRQ */
=20
 #if !defined(CONFIG_IRQ_DOMAIN) || !defined(CONFIG_IRQ_DOMAIN_HIERARCHY)
diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index eb150afd671f..147cabb4c077 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -35,6 +35,16 @@ bool irq_fixup_move_pending(struct irq_desc *desc, bool fo=
rce_clear)
 	return true;
 }
=20
+void irq_force_complete_move(struct irq_desc *desc)
+{
+	for (struct irq_data *d =3D irq_desc_get_irq_data(desc); d; d =3D d->parent=
_data) {
+		if (d->chip && d->chip->irq_force_complete_move) {
+			d->chip->irq_force_complete_move(d);
+			return;
+		}
+	}
+}
+
 void irq_move_masked_irq(struct irq_data *idata)
 {
 	struct irq_desc *desc =3D irq_data_to_desc(idata);
@@ -117,3 +127,13 @@ void __irq_move_irq(struct irq_data *idata)
 	if (!masked)
 		idata->chip->irq_unmask(idata);
 }
+
+bool irq_can_move_in_process_context(struct irq_data *data)
+{
+	/*
+	 * Get the top level irq_data in the hierarchy, which is optimized
+	 * away when CONFIG_IRQ_DOMAIN_HIERARCHY is disabled.
+	 */
+	data =3D irq_desc_get_irq_data(irq_data_to_desc(data));
+	return irq_can_move_pcntxt(data);
+}


