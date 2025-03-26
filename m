Return-Path: <linux-kernel+bounces-577637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE92A71FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B391C176B62
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD77424C08E;
	Wed, 26 Mar 2025 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E/6UXai8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IFceABE8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD11F6664
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019012; cv=none; b=ml8i6PfFR9y833gWqWzsSX4V7m3WiLLPtPkOGwGFYXKoQD0+P7Pp84NvlROTNzwBeBQhVnoaQrISt6qeoREuiKxtF4C3uLwRGVGEKv+zKuuozv1eVJbGLY7Dky8MglQGqUh5aSQtJdzGKKZ1snTns2dDBfCb+nYt+6fBhteCSNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019012; c=relaxed/simple;
	bh=m03reCLvFnqQVCX01Imnr2eEvpW2q5X0O6GQmV+ax64=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=muW3hzaRH6kUUiZVfTnrQ2/b/uSLvwFWWSC7lHqIey3zOhg9sGW8u7nf8Bx6DMkhLjxvQ4lwOC2ySnH+BUHAALGkiV5K5VJ3S6suMxRh9l0QNtFyyEJDJlQBlPsEA+aaxOCKlQNXHhBJasJDbbT0hvzzRcfeUFrBCdxrgGBYhj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E/6UXai8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IFceABE8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743019008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ExHLePYOH4snhFWvF2qHldvL7sVko7NOLFHpBdqPZZ0=;
	b=E/6UXai8Fb1xaLI0NWOmH3fccToHDFJGCTh/BhcZk4cbhMl/ZZ1DkagpRb7ryc+5mup4sQ
	x/7uZPDaD885TS/YdwI7RgjU6DgUUO4nidkMY7KUX0cGRJTGjbmuWkjwCbiw+e/BVKwIQr
	8YnRzP+zofDlp2JIMGbrcHmsKZ1AW3yUFU3x9r4HovcLGIUaOnsp++vGlq4N4SJELmuPju
	Tr7RhYNB+LfvbuHpawoQMtGt3pTZg/QUkN4d25fvgVKlt2Ybf5ANCx8aoQRPQE4AH+QjkA
	saOVdvPwTyAUbQTyb9HZuMAdIEjLWvUQ8y/6pHARjMA45wC6nnMos3RqXy8iyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743019008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ExHLePYOH4snhFWvF2qHldvL7sVko7NOLFHpBdqPZZ0=;
	b=IFceABE8bwwMkTr7DwfC/yArXvZ81q8itenIrK5KU41l6GYSxj4uJFaAhqYFOPuzpNLbY/
	/ITj7h4ppVRUx7DQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/clocksource for v6.15-rc1
Message-ID: 
 <174301899918.1664839.7260897179786919327.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Mar 2025 20:56:48 +0100 (CET)

Linus,

please pull the latest timers/clocksource branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-clocksour=
ce-2025-03-26

up to:  abfa6d6fe2e9: Merge tag 'timers-v6.15-rc1' of https://git.linaro.org/=
people/daniel.lezcano/linux into timers/clocksource


Updates for clocksource/event drivers:

  - Add support for suspend/resume in the STM32 LP-Timer driver with a
    follow up fix, which uses the proper method to setup the timer as a
    optional wakeup source instead of trying to force it as mandatory
    wakeup source.

  - The usual device tree updates to enable new SoC models in existing
    drivers.

  - Trivial spelling, style and indentation fixes

Thanks,

	tglx

------------------>
Alexandre Torgue (1):
      clocksource/drivers/stm32-lptimer: Use wakeup capable instead of init w=
akeup

Anindya Sundar Gayen (1):
      clocksource/drivers/exynos_mct: Fixed a spelling error

Fabrice Gasnier (1):
      clocksource/drivers/stm32-lptimer: Add support for suspend / resume

Igor Belwon (1):
      dt-bindings: timer: exynos4210-mct: Add samsung,exynos990-mct compatible

Ivaylo Ivanov (1):
      dt-bindings: timer: exynos4210-mct: add samsung,exynos2200-mct-peris co=
mpatible

Krzysztof Kozlowski (1):
      dt-bindings: timer: Correct indentation and style in DTS example

Nick Hu (1):
      dt-bindings: timer: Add SiFive CLINT2


 .../devicetree/bindings/timer/arm,twd-timer.yaml   |  6 +--
 .../devicetree/bindings/timer/renesas,cmt.yaml     | 44 +++++++++++---------=
--
 .../devicetree/bindings/timer/renesas,em-sti.yaml  | 10 ++---
 .../devicetree/bindings/timer/renesas,mtu2.yaml    | 14 +++----
 .../devicetree/bindings/timer/renesas,ostm.yaml    | 10 ++---
 .../devicetree/bindings/timer/renesas,tmu.yaml     | 22 +++++------
 .../devicetree/bindings/timer/renesas,tpu.yaml     |  8 ++--
 .../bindings/timer/samsung,exynos4210-mct.yaml     |  4 ++
 .../devicetree/bindings/timer/sifive,clint.yaml    | 24 +++++++++++-
 drivers/clocksource/exynos_mct.c                   |  2 +-
 drivers/clocksource/timer-stm32-lp.c               | 36 +++++++++++++++---
 11 files changed, 115 insertions(+), 65 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/arm,twd-timer.yaml b/Doc=
umentation/devicetree/bindings/timer/arm,twd-timer.yaml
index 5684df6448ef..eb1127352c7b 100644
--- a/Documentation/devicetree/bindings/timer/arm,twd-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/arm,twd-timer.yaml
@@ -50,7 +50,7 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
=20
     timer@2c000600 {
-            compatible =3D "arm,arm11mp-twd-timer";
-            reg =3D <0x2c000600 0x20>;
-            interrupts =3D <GIC_PPI 13 0xf01>;
+        compatible =3D "arm,arm11mp-twd-timer";
+        reg =3D <0x2c000600 0x20>;
+        interrupts =3D <GIC_PPI 13 0xf01>;
     };
diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml b/Docum=
entation/devicetree/bindings/timer/renesas,cmt.yaml
index 5e09c04da30e..260b05f213e6 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
@@ -178,29 +178,29 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/power/r8a7790-sysc.h>
     cmt0: timer@ffca0000 {
-            compatible =3D "renesas,r8a7790-cmt0", "renesas,rcar-gen2-cmt0";
-            reg =3D <0xffca0000 0x1004>;
-            interrupts =3D <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
-            clocks =3D <&cpg CPG_MOD 124>;
-            clock-names =3D "fck";
-            power-domains =3D <&sysc R8A7790_PD_ALWAYS_ON>;
-            resets =3D <&cpg 124>;
+        compatible =3D "renesas,r8a7790-cmt0", "renesas,rcar-gen2-cmt0";
+        reg =3D <0xffca0000 0x1004>;
+        interrupts =3D <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+        clocks =3D <&cpg CPG_MOD 124>;
+        clock-names =3D "fck";
+        power-domains =3D <&sysc R8A7790_PD_ALWAYS_ON>;
+        resets =3D <&cpg 124>;
     };
=20
     cmt1: timer@e6130000 {
-            compatible =3D "renesas,r8a7790-cmt1", "renesas,rcar-gen2-cmt1";
-            reg =3D <0xe6130000 0x1004>;
-            interrupts =3D <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
-            clocks =3D <&cpg CPG_MOD 329>;
-            clock-names =3D "fck";
-            power-domains =3D <&sysc R8A7790_PD_ALWAYS_ON>;
-            resets =3D <&cpg 329>;
+        compatible =3D "renesas,r8a7790-cmt1", "renesas,rcar-gen2-cmt1";
+        reg =3D <0xe6130000 0x1004>;
+        interrupts =3D <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+        clocks =3D <&cpg CPG_MOD 329>;
+        clock-names =3D "fck";
+        power-domains =3D <&sysc R8A7790_PD_ALWAYS_ON>;
+        resets =3D <&cpg 329>;
     };
diff --git a/Documentation/devicetree/bindings/timer/renesas,em-sti.yaml b/Do=
cumentation/devicetree/bindings/timer/renesas,em-sti.yaml
index 233d74d5402c..a7385d865bca 100644
--- a/Documentation/devicetree/bindings/timer/renesas,em-sti.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,em-sti.yaml
@@ -38,9 +38,9 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     timer@e0180000 {
-            compatible =3D "renesas,em-sti";
-            reg =3D <0xe0180000 0x54>;
-            interrupts =3D <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
-            clocks =3D <&sti_sclk>;
-            clock-names =3D "sclk";
+        compatible =3D "renesas,em-sti";
+        reg =3D <0xe0180000 0x54>;
+        interrupts =3D <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+        clocks =3D <&sti_sclk>;
+        clock-names =3D "sclk";
     };
diff --git a/Documentation/devicetree/bindings/timer/renesas,mtu2.yaml b/Docu=
mentation/devicetree/bindings/timer/renesas,mtu2.yaml
index 15d8dddf4ae9..e56c12f03f72 100644
--- a/Documentation/devicetree/bindings/timer/renesas,mtu2.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,mtu2.yaml
@@ -66,11 +66,11 @@ examples:
     #include <dt-bindings/clock/r7s72100-clock.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     mtu2: timer@fcff0000 {
-            compatible =3D "renesas,mtu2-r7s72100", "renesas,mtu2";
-            reg =3D <0xfcff0000 0x400>;
-            interrupts =3D <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-            interrupt-names =3D "tgi0a";
-            clocks =3D <&mstp3_clks R7S72100_CLK_MTU2>;
-            clock-names =3D "fck";
-            power-domains =3D <&cpg_clocks>;
+        compatible =3D "renesas,mtu2-r7s72100", "renesas,mtu2";
+        reg =3D <0xfcff0000 0x400>;
+        interrupts =3D <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names =3D "tgi0a";
+        clocks =3D <&mstp3_clks R7S72100_CLK_MTU2>;
+        clock-names =3D "fck";
+        power-domains =3D <&cpg_clocks>;
     };
diff --git a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml b/Docu=
mentation/devicetree/bindings/timer/renesas,ostm.yaml
index e8c642166462..9ba858f094ab 100644
--- a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
@@ -71,9 +71,9 @@ examples:
     #include <dt-bindings/clock/r7s72100-clock.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     ostm0: timer@fcfec000 {
-            compatible =3D "renesas,r7s72100-ostm", "renesas,ostm";
-            reg =3D <0xfcfec000 0x30>;
-            interrupts =3D <GIC_SPI 102 IRQ_TYPE_EDGE_RISING>;
-            clocks =3D <&mstp5_clks R7S72100_CLK_OSTM0>;
-            power-domains =3D <&cpg_clocks>;
+        compatible =3D "renesas,r7s72100-ostm", "renesas,ostm";
+        reg =3D <0xfcfec000 0x30>;
+        interrupts =3D <GIC_SPI 102 IRQ_TYPE_EDGE_RISING>;
+        clocks =3D <&mstp5_clks R7S72100_CLK_OSTM0>;
+        power-domains =3D <&cpg_clocks>;
     };
diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/Docum=
entation/devicetree/bindings/timer/renesas,tmu.yaml
index 75b0e7c70b62..b1229595acfb 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
@@ -122,15 +122,15 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/power/r8a7779-sysc.h>
     tmu0: timer@ffd80000 {
-            compatible =3D "renesas,tmu-r8a7779", "renesas,tmu";
-            reg =3D <0xffd80000 0x30>;
-            interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-            interrupt-names =3D "tuni0", "tuni1", "tuni2", "ticpi2";
-            clocks =3D <&mstp0_clks R8A7779_CLK_TMU0>;
-            clock-names =3D "fck";
-            power-domains =3D <&sysc R8A7779_PD_ALWAYS_ON>;
-            #renesas,channels =3D <3>;
+        compatible =3D "renesas,tmu-r8a7779", "renesas,tmu";
+        reg =3D <0xffd80000 0x30>;
+        interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names =3D "tuni0", "tuni1", "tuni2", "ticpi2";
+        clocks =3D <&mstp0_clks R8A7779_CLK_TMU0>;
+        clock-names =3D "fck";
+        power-domains =3D <&sysc R8A7779_PD_ALWAYS_ON>;
+        #renesas,channels =3D <3>;
     };
diff --git a/Documentation/devicetree/bindings/timer/renesas,tpu.yaml b/Docum=
entation/devicetree/bindings/timer/renesas,tpu.yaml
index 01554dff23d8..7a473b302775 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tpu.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,tpu.yaml
@@ -49,8 +49,8 @@ additionalProperties: false
 examples:
   - |
     tpu: tpu@ffffe0 {
-            compatible =3D "renesas,tpu";
-            reg =3D <0xffffe0 16>, <0xfffff0 12>;
-            clocks =3D <&pclk>;
-            clock-names =3D "fck";
+        compatible =3D "renesas,tpu";
+        reg =3D <0xffffe0 16>, <0xfffff0 12>;
+        clocks =3D <&pclk>;
+        clock-names =3D "fck";
     };
diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.y=
aml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
index 02d1c355808e..10578f544581 100644
--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
@@ -27,6 +27,7 @@ properties:
           - enum:
               - axis,artpec8-mct
               - google,gs101-mct
+              - samsung,exynos2200-mct-peris
               - samsung,exynos3250-mct
               - samsung,exynos5250-mct
               - samsung,exynos5260-mct
@@ -34,6 +35,7 @@ properties:
               - samsung,exynos5433-mct
               - samsung,exynos850-mct
               - samsung,exynos8895-mct
+              - samsung,exynos990-mct
               - tesla,fsd-mct
           - const: samsung,exynos4210-mct
=20
@@ -130,11 +132,13 @@ allOf:
             enum:
               - axis,artpec8-mct
               - google,gs101-mct
+              - samsung,exynos2200-mct-peris
               - samsung,exynos5260-mct
               - samsung,exynos5420-mct
               - samsung,exynos5433-mct
               - samsung,exynos850-mct
               - samsung,exynos8895-mct
+              - samsung,exynos990-mct
     then:
       properties:
         interrupts:
diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Docu=
mentation/devicetree/bindings/timer/sifive,clint.yaml
index 76d83aea4e2b..653e2e0ca878 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -36,6 +36,12 @@ properties:
               - starfive,jh7110-clint   # StarFive JH7110
               - starfive,jh8100-clint   # StarFive JH8100
           - const: sifive,clint0        # SiFive CLINT v0 IP block
+      - items:
+          - {}
+          - const: sifive,clint2        # SiFive CLINT v2 IP block
+        description:
+          SiFive CLINT v2 is the HRT that supports the Zicntr. The control o=
f sifive,clint2
+          differs from that of sifive,clint0, making them incompatible.
       - items:
           - enum:
               - allwinner,sun20i-d1-clint
@@ -62,6 +68,22 @@ properties:
     minItems: 1
     maxItems: 4095
=20
+  sifive,fine-ctr-bits:
+    maximum: 15
+    description: The width in bits of the fine counter.
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: sifive,clint2
+then:
+  required:
+    - sifive,fine-ctr-bits
+else:
+  properties:
+    sifive,fine-ctr-bits: false
+
 additionalProperties: false
=20
 required:
@@ -77,6 +99,6 @@ examples:
                             <&cpu2intc 3>, <&cpu2intc 7>,
                             <&cpu3intc 3>, <&cpu3intc 7>,
                             <&cpu4intc 3>, <&cpu4intc 7>;
-       reg =3D <0x2000000 0x10000>;
+      reg =3D <0x2000000 0x10000>;
     };
 ...
diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mc=
t.c
index e6a02e351d77..da09f467a6bb 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -238,7 +238,7 @@ static cycles_t exynos4_read_current_timer(void)
 static int __init exynos4_clocksource_init(bool frc_shared)
 {
 	/*
-	 * When the frc is shared, the main processer should have already
+	 * When the frc is shared, the main processor should have already
 	 * turned it on and we shouldn't be writing to TCON.
 	 */
 	if (frc_shared)
diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer=
-stm32-lp.c
index a4c95161cb22..928da2f6de69 100644
--- a/drivers/clocksource/timer-stm32-lp.c
+++ b/drivers/clocksource/timer-stm32-lp.c
@@ -24,7 +24,9 @@ struct stm32_lp_private {
 	struct regmap *reg;
 	struct clock_event_device clkevt;
 	unsigned long period;
+	u32 psc;
 	struct device *dev;
+	struct clk *clk;
 };
=20
 static struct stm32_lp_private*
@@ -120,6 +122,27 @@ static void stm32_clkevent_lp_set_prescaler(struct stm32=
_lp_private *priv,
 	/* Adjust rate and period given the prescaler value */
 	*rate =3D DIV_ROUND_CLOSEST(*rate, (1 << i));
 	priv->period =3D DIV_ROUND_UP(*rate, HZ);
+	priv->psc =3D i;
+}
+
+static void stm32_clkevent_lp_suspend(struct clock_event_device *clkevt)
+{
+	struct stm32_lp_private *priv =3D to_priv(clkevt);
+
+	stm32_clkevent_lp_shutdown(clkevt);
+
+	/* balance clk_prepare_enable() from the probe */
+	clk_disable_unprepare(priv->clk);
+}
+
+static void stm32_clkevent_lp_resume(struct clock_event_device *clkevt)
+{
+	struct stm32_lp_private *priv =3D to_priv(clkevt);
+
+	clk_prepare_enable(priv->clk);
+
+	/* restore prescaler */
+	regmap_write(priv->reg, STM32_LPTIM_CFGR, priv->psc << CFGR_PSC_OFFSET);
 }
=20
 static void stm32_clkevent_lp_init(struct stm32_lp_private *priv,
@@ -134,6 +157,8 @@ static void stm32_clkevent_lp_init(struct stm32_lp_privat=
e *priv,
 	priv->clkevt.set_state_oneshot =3D stm32_clkevent_lp_set_oneshot;
 	priv->clkevt.set_next_event =3D stm32_clkevent_lp_set_next_event;
 	priv->clkevt.rating =3D STM32_LP_RATING;
+	priv->clkevt.suspend =3D stm32_clkevent_lp_suspend;
+	priv->clkevt.resume =3D stm32_clkevent_lp_resume;
=20
 	clockevents_config_and_register(&priv->clkevt, rate, 0x1,
 					STM32_LPTIM_MAX_ARR);
@@ -151,11 +176,12 @@ static int stm32_clkevent_lp_probe(struct platform_devi=
ce *pdev)
 		return -ENOMEM;
=20
 	priv->reg =3D ddata->regmap;
-	ret =3D clk_prepare_enable(ddata->clk);
+	priv->clk =3D ddata->clk;
+	ret =3D clk_prepare_enable(priv->clk);
 	if (ret)
 		return -EINVAL;
=20
-	rate =3D clk_get_rate(ddata->clk);
+	rate =3D clk_get_rate(priv->clk);
 	if (!rate) {
 		ret =3D -EINVAL;
 		goto out_clk_disable;
@@ -168,9 +194,7 @@ static int stm32_clkevent_lp_probe(struct platform_device=
 *pdev)
 	}
=20
 	if (of_property_read_bool(pdev->dev.parent->of_node, "wakeup-source")) {
-		ret =3D device_init_wakeup(&pdev->dev, true);
-		if (ret)
-			goto out_clk_disable;
+		device_set_wakeup_capable(&pdev->dev, true);
=20
 		ret =3D dev_pm_set_wake_irq(&pdev->dev, irq);
 		if (ret)
@@ -191,7 +215,7 @@ static int stm32_clkevent_lp_probe(struct platform_device=
 *pdev)
 	return 0;
=20
 out_clk_disable:
-	clk_disable_unprepare(ddata->clk);
+	clk_disable_unprepare(priv->clk);
 	return ret;
 }
=20


