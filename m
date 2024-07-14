Return-Path: <linux-kernel+bounces-251923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 544A2930BAC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 22:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ABD9B2262B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 20:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCD4142E86;
	Sun, 14 Jul 2024 20:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h0EbWM28";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QggK4q4t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9002113E88B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720990215; cv=none; b=JHx91D0xj39jnBZG3B8Im91b+enEX2zGaIuIyIbo+2/F0XCN/bU4zneJt17o1QJVAnu+0z40SH5NtXIfJLeTo2ryOQ4/2pJGVej1a86qFSzsYVLlsjbZED/BYsOuTXvuPrhsjV79lZDBMNqeOJbQVcOQO9/6ELSB8mcFH8K7Hfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720990215; c=relaxed/simple;
	bh=WYCcRTsdkyxnsp/51JJcoqJQTjKKXLgFgy4HFeCA+r4=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=AAaIlj68TxhHU41PVC2dwTblw/3yBZZ+NY2UYepOcQBlNi5TDe1R/UU6gy6+7chUWiK4GZ4a9MWtM98Nu6gmMFJpCmJhJDYOORZ6GxnZEAotsrGno+dCzxYtaXa+bFc/dEpwySjvVPvXZjh5YkJOn84vr/st3ZdiHiUxtWxo1XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h0EbWM28; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QggK4q4t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720990210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=6pQpYtjapOSTAV4sbKNTcGVyzNJ9wmRMnznO+20xwik=;
	b=h0EbWM28SIDi35g/3cyGjVexd3co2pxsUSIy5REVKbHDNe5CjC6q8sG3NMcliLMBsLbbOm
	g9DYat8eDgpOfVjXgU3CpoNl2FHjHI1hYpvasnXHs8N5hQYrVbheB09Ui5s1C6BKEM++fo
	T4aK6ZRxvdVyylVAv2zldZMWosnJD8K0tWc6xJm6aYS+bInYflGTb2l2VeePFKCF3W4NCe
	PvR8oSMkCWvhgz/Aq9azX06g4vKRlqW1zKkgcVvZtMekT1RUgFoeYdI51JHpCYBSumCJSp
	S2uiCD//l999UzlvfeGHsuqKya5INUrHkJM0kbLVUiJyR8mZEKEsUSYuldqYLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720990210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=6pQpYtjapOSTAV4sbKNTcGVyzNJ9wmRMnznO+20xwik=;
	b=QggK4q4toF1Xfd0hWIYADDF377lXNvieDa11l1MV0bzj9xCVYOfX41a3Vr8QIkEqGEXw5n
	6toveKjxbGW9hmCA==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v6.11-rc1
References: <172099001487.1942258.17671805941963584080.tglx@xen13>
Message-ID: <172099001980.1942258.17387914707489716419.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 14 Jul 2024 22:50:10 +0200 (CEST)

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024=
-07-14

up to:  b7625d67eb1a: Merge tag 'timers-v6.11-rc1' of https://git.linaro.org/=
people/daniel.lezcano/linux into timers/core

Updates for timers, timekeeping and related functionality:

  - Core:

    - Make the takeover of a hrtimer based broadcast timer reliable during
      CPU hot-unplug. The current implementation suffers from a race which
      can lead to broadcast timer starvation in the worst case.

    - VDSO related cleanups and simplifications

    - Small cleanups and enhancements all over the place
   =20
  - PTP:

    - Replace the architecture specific base clock to clocksource, e.g. ART
      to TSC, conversion function with generic functionality to avoid
      exposing such internals to drivers and convert all existing drivers
      over. This also allows to provide functionality which converts the
      other way round in the core code based on the same parameter set.

    - Provide a function to convert CLOCK_REALTIME to the base clock to
      support the upcoming PPS output driver on Intel platforms.

  - Drivers:

    - A set of Device Tree bindings for new hardware

    - Cleanups and enhancements all over the place

Thanks,

	tglx

------------------>
Anna-Maria Behnsen (6):
      vdso/gettimeofday: Clarify comment about open coded function
      vdso: Add comment about reason for vdso struct ordering
      x86/vdso: Fix function reference in comment
      x86/vgtod: Remove unused typedef gtod_long_t
      x86/vdso: Remove unused include
      tick/sched: Combine WARN_ON_ONCE and print_once

Chris Packham (2):
      dt-bindings: timer: Add schema for realtek,otto-timer
      clocksource/drivers/realtek: Add timer driver for rtl-otto platforms

Christian Loehle (1):
      tick: Remove unnused tick_nohz_get_idle_calls()

Geert Uytterhoeven (3):
      dt-bindings: timer: renesas,tmu: Add R-Mobile APE6 support
      dt-bindings: timer: renesas,tmu: Add RZ/G1 support
      dt-bindings: timer: renesas,tmu: Add R-Car Gen2 support

Jeff Johnson (1):
      time: Add MODULE_DESCRIPTION() to time test modules

Jiaxun Yang (2):
      clocksource/drivers/mips-gic-timer: Refine rating computation
      clocksource/drivers/mips-gic-timer: Correct sched_clock width

Lakshmi Sowjanya D (4):
      timekeeping: Provide infrastructure for converting to/from a base clock
      x86/tsc: Provide ART base clock information for TSC
      x86/tsc: Remove obsolete ART to TSC conversion functions
      timekeeping: Add function to convert realtime to base clock

Li kunyu (2):
      clocksource/drivers/arm_arch_timer: Remove unnecessary =E2=80=980=E2=80=
=99 values from irq
      clocksource/driver/arm_global_timer: Remove unnecessary =E2=80=980=E2=
=80=99 values from err

Niklas S=C3=B6derlund (1):
      clocksource/drivers/sh_cmt: Address race condition for clock events

Thomas Bonnefille (1):
      dt-bindings: timer: Add SOPHGO SG2002 clint

Thomas Gleixner (5):
      e1000e: Replace convert_art_to_tsc()
      igc: Remove convert_art_ns_to_tsc()
      stmmac: intel: Remove convert_art_to_tsc()
      ALSA: hda: Remove convert_art_to_tsc()
      ice/ptp: Remove convert_art_to_tsc()

Yang Li (1):
      timekeeping: Add missing kernel-doc function comments

Yu Liao (1):
      tick/broadcast: Make takeover of broadcast hrtimer reliable


 .../bindings/timer/realtek,otto-timer.yaml         |  63 +++++
 .../devicetree/bindings/timer/renesas,tmu.yaml     |  12 +
 .../devicetree/bindings/timer/sifive,clint.yaml    |   1 +
 arch/x86/include/asm/tsc.h                         |   3 -
 arch/x86/include/asm/vdso/gettimeofday.h           |   5 +-
 arch/x86/include/asm/vdso/vsyscall.h               |   1 -
 arch/x86/include/asm/vgtod.h                       |   5 -
 arch/x86/kernel/tsc.c                              |  92 ++-----
 drivers/clocksource/Kconfig                        |  10 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/arm_arch_timer.c               |   2 +-
 drivers/clocksource/arm_global_timer.c             |   2 +-
 drivers/clocksource/mips-gic-timer.c               |  20 +-
 drivers/clocksource/sh_cmt.c                       |  13 +-
 drivers/clocksource/timer-rtl-otto.c               | 291 +++++++++++++++++++=
++
 drivers/net/ethernet/intel/e1000e/ptp.c            |   3 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |   3 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c           |   6 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |   3 +-
 include/linux/clocksource.h                        |  27 ++
 include/linux/clocksource_ids.h                    |   1 +
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/tick.h                               |   1 -
 include/linux/timekeeping.h                        |   6 +
 include/vdso/datapage.h                            |   4 +
 kernel/time/clocksource-wdtest.c                   |   1 +
 kernel/time/test_udelay.c                          |   1 +
 kernel/time/tick-broadcast.c                       |  23 ++
 kernel/time/tick-sched.c                           |  22 +-
 kernel/time/time_test.c                            |   1 +
 kernel/time/timekeeping.c                          | 131 +++++++++-
 lib/vdso/gettimeofday.c                            |  20 +-
 sound/pci/hda/hda_controller.c                     |   3 +-
 33 files changed, 647 insertions(+), 131 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/realtek,otto-time=
r.yaml
 create mode 100644 drivers/clocksource/timer-rtl-otto.c

diff --git a/Documentation/devicetree/bindings/timer/realtek,otto-timer.yaml =
b/Documentation/devicetree/bindings/timer/realtek,otto-timer.yaml
new file mode 100644
index 000000000000..7b6ec2c69484
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/realtek,otto-timer.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/realtek,otto-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek Otto SoCs Timer/Counter
+
+description:
+  Realtek SoCs support a number of timers/counters. These are used
+  as a per CPU clock event generator and an overall CPU clocksource.
+
+maintainers:
+  - Chris Packham <chris.packham@alliedtelesis.co.nz>
+
+properties:
+  $nodename:
+    pattern: "^timer@[0-9a-f]+$"
+
+  compatible:
+    items:
+      - enum:
+          - realtek,rtl9302-timer
+      - const: realtek,otto-timer
+
+  reg:
+    items:
+      - description: timer0 registers
+      - description: timer1 registers
+      - description: timer2 registers
+      - description: timer3 registers
+      - description: timer4 registers
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: timer0 interrupt
+      - description: timer1 interrupt
+      - description: timer2 interrupt
+      - description: timer3 interrupt
+      - description: timer4 interrupt
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@3200 {
+      compatible =3D "realtek,rtl9302-timer", "realtek,otto-timer";
+      reg =3D <0x3200 0x10>, <0x3210 0x10>, <0x3220 0x10>,
+            <0x3230 0x10>, <0x3240 0x10>;
+
+      interrupt-parent =3D <&intc>;
+      interrupts =3D <7>, <8>, <9>, <10>, <11>;
+      clocks =3D <&lx_clk>;
+    };
diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/Docum=
entation/devicetree/bindings/timer/renesas,tmu.yaml
index 360a5cf1ae9c..b6dd98d956f3 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
@@ -21,13 +21,24 @@ properties:
   compatible:
     items:
       - enum:
+          - renesas,tmu-r8a73a4  # R-Mobile APE6
           - renesas,tmu-r8a7740  # R-Mobile A1
+          - renesas,tmu-r8a7742  # RZ/G1H
+          - renesas,tmu-r8a7743  # RZ/G1M
+          - renesas,tmu-r8a7744  # RZ/G1N
+          - renesas,tmu-r8a7745  # RZ/G1E
+          - renesas,tmu-r8a77470 # RZ/G1C
           - renesas,tmu-r8a774a1 # RZ/G2M
           - renesas,tmu-r8a774b1 # RZ/G2N
           - renesas,tmu-r8a774c0 # RZ/G2E
           - renesas,tmu-r8a774e1 # RZ/G2H
           - renesas,tmu-r8a7778  # R-Car M1A
           - renesas,tmu-r8a7779  # R-Car H1
+          - renesas,tmu-r8a7790  # R-Car H2
+          - renesas,tmu-r8a7791  # R-Car M2-W
+          - renesas,tmu-r8a7792  # R-Car V2H
+          - renesas,tmu-r8a7793  # R-Car M2-N
+          - renesas,tmu-r8a7794  # R-Car E2
           - renesas,tmu-r8a7795  # R-Car H3
           - renesas,tmu-r8a7796  # R-Car M3-W
           - renesas,tmu-r8a77961 # R-Car M3-W+
@@ -94,6 +105,7 @@ if:
       compatible:
         contains:
           enum:
+            - renesas,tmu-r8a73a4
             - renesas,tmu-r8a7740
             - renesas,tmu-r8a7778
             - renesas,tmu-r8a7779
diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Docu=
mentation/devicetree/bindings/timer/sifive,clint.yaml
index fced6f2d8ecb..b42d43d2de48 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -40,6 +40,7 @@ properties:
               - allwinner,sun20i-d1-clint
               - sophgo,cv1800b-clint
               - sophgo,cv1812h-clint
+              - sophgo,sg2002-clint
               - thead,th1520-clint
           - const: thead,c900-clint
       - items:
diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 405efb3e4996..94408a784c8e 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -28,9 +28,6 @@ static inline cycles_t get_cycles(void)
 }
 #define get_cycles get_cycles
=20
-extern struct system_counterval_t convert_art_to_tsc(u64 art);
-extern struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns);
-
 extern void tsc_early_init(void);
 extern void tsc_init(void);
 extern void mark_tsc_unstable(char *reason);
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/=
vdso/gettimeofday.h
index 0ef36190abe6..b2d2df026f6e 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -328,9 +328,8 @@ static __always_inline u64 vdso_calc_ns(const struct vdso=
_data *vd, u64 cycles,
 	 * due to unsigned comparison.
 	 *
 	 * Due to the MSB/Sign-bit being used as invalid marker (see
-	 * arch_vdso_cycles_valid() above), the effective mask is S64_MAX,
-	 * but that case is also unlikely and will also take the unlikely path
-	 * here.
+	 * arch_vdso_cycles_ok() above), the effective mask is S64_MAX, but that
+	 * case is also unlikely and will also take the unlikely path here.
 	 */
 	if (unlikely(delta > vd->max_cycles)) {
 		/*
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso=
/vsyscall.h
index be199a9b2676..93226281b450 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -4,7 +4,6 @@
=20
 #ifndef __ASSEMBLY__
=20
-#include <linux/hrtimer.h>
 #include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
 #include <asm/vgtod.h>
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index 7aa38b2ad8a9..a0ce291abcae 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -14,11 +14,6 @@
=20
 #include <uapi/linux/time.h>
=20
-#ifdef BUILD_VDSO32_64
-typedef u64 gtod_long_t;
-#else
-typedef unsigned long gtod_long_t;
-#endif
 #endif /* CONFIG_GENERIC_GETTIMEOFDAY */
=20
 #endif /* _ASM_X86_VGTOD_H */
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 06b170759e5b..d4462fb26299 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -50,9 +50,9 @@ int tsc_clocksource_reliable;
=20
 static int __read_mostly tsc_force_recalibrate;
=20
-static u32 art_to_tsc_numerator;
-static u32 art_to_tsc_denominator;
-static u64 art_to_tsc_offset;
+static struct clocksource_base art_base_clk =3D {
+	.id    =3D CSID_X86_ART,
+};
 static bool have_art;
=20
 struct cyc2ns {
@@ -1074,7 +1074,7 @@ core_initcall(cpufreq_register_tsc_scaling);
  */
 static void __init detect_art(void)
 {
-	unsigned int unused[2];
+	unsigned int unused;
=20
 	if (boot_cpu_data.cpuid_level < ART_CPUID_LEAF)
 		return;
@@ -1089,13 +1089,14 @@ static void __init detect_art(void)
 	    tsc_async_resets)
 		return;
=20
-	cpuid(ART_CPUID_LEAF, &art_to_tsc_denominator,
-	      &art_to_tsc_numerator, unused, unused+1);
+	cpuid(ART_CPUID_LEAF, &art_base_clk.denominator,
+	      &art_base_clk.numerator, &art_base_clk.freq_khz, &unused);
=20
-	if (art_to_tsc_denominator < ART_MIN_DENOMINATOR)
+	art_base_clk.freq_khz /=3D KHZ;
+	if (art_base_clk.denominator < ART_MIN_DENOMINATOR)
 		return;
=20
-	rdmsrl(MSR_IA32_TSC_ADJUST, art_to_tsc_offset);
+	rdmsrl(MSR_IA32_TSC_ADJUST, art_base_clk.offset);
=20
 	/* Make this sticky over multiple CPU init calls */
 	setup_force_cpu_cap(X86_FEATURE_ART);
@@ -1296,67 +1297,6 @@ int unsynchronized_tsc(void)
 	return 0;
 }
=20
-/*
- * Convert ART to TSC given numerator/denominator found in detect_art()
- */
-struct system_counterval_t convert_art_to_tsc(u64 art)
-{
-	u64 tmp, res, rem;
-
-	rem =3D do_div(art, art_to_tsc_denominator);
-
-	res =3D art * art_to_tsc_numerator;
-	tmp =3D rem * art_to_tsc_numerator;
-
-	do_div(tmp, art_to_tsc_denominator);
-	res +=3D tmp + art_to_tsc_offset;
-
-	return (struct system_counterval_t) {
-		.cs_id	=3D have_art ? CSID_X86_TSC : CSID_GENERIC,
-		.cycles	=3D res,
-	};
-}
-EXPORT_SYMBOL(convert_art_to_tsc);
-
-/**
- * convert_art_ns_to_tsc() - Convert ART in nanoseconds to TSC.
- * @art_ns: ART (Always Running Timer) in unit of nanoseconds
- *
- * PTM requires all timestamps to be in units of nanoseconds. When user
- * software requests a cross-timestamp, this function converts system timest=
amp
- * to TSC.
- *
- * This is valid when CPU feature flag X86_FEATURE_TSC_KNOWN_FREQ is set
- * indicating the tsc_khz is derived from CPUID[15H]. Drivers should check
- * that this flag is set before conversion to TSC is attempted.
- *
- * Return:
- * struct system_counterval_t - system counter value with the ID of the
- *	corresponding clocksource:
- *	cycles:		System counter value
- *	cs_id:		The clocksource ID for validating comparability
- */
-
-struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
-{
-	u64 tmp, res, rem;
-
-	rem =3D do_div(art_ns, USEC_PER_SEC);
-
-	res =3D art_ns * tsc_khz;
-	tmp =3D rem * tsc_khz;
-
-	do_div(tmp, USEC_PER_SEC);
-	res +=3D tmp;
-
-	return (struct system_counterval_t) {
-		.cs_id	=3D have_art ? CSID_X86_TSC : CSID_GENERIC,
-		.cycles	=3D res,
-	};
-}
-EXPORT_SYMBOL(convert_art_ns_to_tsc);
-
-
 static void tsc_refine_calibration_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
 /**
@@ -1458,8 +1398,10 @@ static void tsc_refine_calibration_work(struct work_st=
ruct *work)
 	if (tsc_unstable)
 		goto unreg;
=20
-	if (boot_cpu_has(X86_FEATURE_ART))
+	if (boot_cpu_has(X86_FEATURE_ART)) {
 		have_art =3D true;
+		clocksource_tsc.base =3D &art_base_clk;
+	}
 	clocksource_register_khz(&clocksource_tsc, tsc_khz);
 unreg:
 	clocksource_unregister(&clocksource_tsc_early);
@@ -1484,8 +1426,10 @@ static int __init init_tsc_clocksource(void)
 	 * the refined calibration and directly register it as a clocksource.
 	 */
 	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
-		if (boot_cpu_has(X86_FEATURE_ART))
+		if (boot_cpu_has(X86_FEATURE_ART)) {
 			have_art =3D true;
+			clocksource_tsc.base =3D &art_base_clk;
+		}
 		clocksource_register_khz(&clocksource_tsc, tsc_khz);
 		clocksource_unregister(&clocksource_tsc_early);
=20
@@ -1509,10 +1453,12 @@ static bool __init determine_cpu_tsc_frequencies(bool=
 early)
=20
 	if (early) {
 		cpu_khz =3D x86_platform.calibrate_cpu();
-		if (tsc_early_khz)
+		if (tsc_early_khz) {
 			tsc_khz =3D tsc_early_khz;
-		else
+		} else {
 			tsc_khz =3D x86_platform.calibrate_tsc();
+			clocksource_tsc.freq_khz =3D tsc_khz;
+		}
 	} else {
 		/* We should not be here with non-native cpu calibration */
 		WARN_ON(x86_platform.calibrate_cpu !=3D native_calibrate_cpu);
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 34faa0320ece..95dd4660b5b6 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -134,6 +134,16 @@ config RDA_TIMER
 	help
 	  Enables the support for the RDA Micro timer driver.
=20
+config REALTEK_OTTO_TIMER
+	bool "Clocksource/timer for the Realtek Otto platform" if COMPILE_TEST
+	select TIMER_OF
+	help
+	  This driver adds support for the timers found in the Realtek RTL83xx
+	  and RTL93xx SoCs series. This includes chips such as RTL8380, RTL8381
+	  and RTL832, as well as chips from the RTL839x series, such as RTL8390
+	  RT8391, RTL8392, RTL8393 and RTL8396 and chips of the RTL930x series
+	  such as RTL9301, RTL9302 or RTL9303.
+
 config SUN4I_TIMER
 	bool "Sun4i timer driver" if COMPILE_TEST
 	depends on HAS_IOMEM
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 4bb856e4df55..22743785299e 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_MILBEAUT_TIMER)	+=3D timer-milbeaut.o
 obj-$(CONFIG_SPRD_TIMER)	+=3D timer-sprd.o
 obj-$(CONFIG_NPCM7XX_TIMER)	+=3D timer-npcm7xx.o
 obj-$(CONFIG_RDA_TIMER)		+=3D timer-rda.o
+obj-$(CONFIG_REALTEK_OTTO_TIMER)	+=3D timer-rtl-otto.o
=20
 obj-$(CONFIG_ARC_TIMERS)		+=3D arc_timer.o
 obj-$(CONFIG_ARM_ARCH_TIMER)		+=3D arm_arch_timer.o
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_a=
rch_timer.c
index 5bb43cc1a8df..aeafc74181f0 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1556,7 +1556,7 @@ static int __init
 arch_timer_mem_frame_register(struct arch_timer_mem_frame *frame)
 {
 	void __iomem *base;
-	int ret, irq =3D 0;
+	int ret, irq;
=20
 	if (arch_timer_mem_use_virtual)
 		irq =3D frame->virt_irq;
diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm=
_global_timer.c
index ab1c8c2b66b8..a05cfaab5f84 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -343,7 +343,7 @@ static int __init global_timer_of_register(struct device_=
node *np)
 {
 	struct clk *gt_clk;
 	static unsigned long gt_clk_rate;
-	int err =3D 0;
+	int err;
=20
 	/*
 	 * In A9 r2p0 the comparators for each processor with the global timer
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-=
gic-timer.c
index b3ae38f36720..110347707ff9 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -19,6 +19,7 @@
 static DEFINE_PER_CPU(struct clock_event_device, gic_clockevent_device);
 static int gic_timer_irq;
 static unsigned int gic_frequency;
+static unsigned int gic_count_width;
 static bool __read_mostly gic_clock_unstable;
=20
 static void gic_clocksource_unstable(char *reason);
@@ -186,18 +187,21 @@ static void gic_clocksource_unstable(char *reason)
=20
 static int __init __gic_clocksource_init(void)
 {
-	unsigned int count_width;
 	int ret;
=20
 	/* Set clocksource mask. */
-	count_width =3D read_gic_config() & GIC_CONFIG_COUNTBITS;
-	count_width >>=3D __ffs(GIC_CONFIG_COUNTBITS);
-	count_width *=3D 4;
-	count_width +=3D 32;
-	gic_clocksource.mask =3D CLOCKSOURCE_MASK(count_width);
+	gic_count_width =3D read_gic_config() & GIC_CONFIG_COUNTBITS;
+	gic_count_width >>=3D __ffs(GIC_CONFIG_COUNTBITS);
+	gic_count_width *=3D 4;
+	gic_count_width +=3D 32;
+	gic_clocksource.mask =3D CLOCKSOURCE_MASK(gic_count_width);
=20
 	/* Calculate a somewhat reasonable rating value. */
-	gic_clocksource.rating =3D 200 + gic_frequency / 10000000;
+	if (mips_cm_revision() >=3D CM_REV_CM3 || !IS_ENABLED(CONFIG_CPU_FREQ))
+		gic_clocksource.rating =3D 300; /* Good when frequecy is stable */
+	else
+		gic_clocksource.rating =3D 200;
+	gic_clocksource.rating +=3D clamp(gic_frequency / 10000000, 0, 99);
=20
 	ret =3D clocksource_register_hz(&gic_clocksource, gic_frequency);
 	if (ret < 0)
@@ -260,7 +264,7 @@ static int __init gic_clocksource_of_init(struct device_n=
ode *node)
 	if (mips_cm_revision() >=3D CM_REV_CM3 || !IS_ENABLED(CONFIG_CPU_FREQ)) {
 		sched_clock_register(mips_cm_is64 ?
 				     gic_read_count_64 : gic_read_count_2x32,
-				     64, gic_frequency);
+				     gic_count_width, gic_frequency);
 	}
=20
 	return 0;
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 26919556ef5f..b72b36e0abed 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -528,6 +528,7 @@ static void sh_cmt_set_next(struct sh_cmt_channel *ch, un=
signed long delta)
 static irqreturn_t sh_cmt_interrupt(int irq, void *dev_id)
 {
 	struct sh_cmt_channel *ch =3D dev_id;
+	unsigned long flags;
=20
 	/* clear flags */
 	sh_cmt_write_cmcsr(ch, sh_cmt_read_cmcsr(ch) &
@@ -558,6 +559,8 @@ static irqreturn_t sh_cmt_interrupt(int irq, void *dev_id)
=20
 	ch->flags &=3D ~FLAG_SKIPEVENT;
=20
+	raw_spin_lock_irqsave(&ch->lock, flags);
+
 	if (ch->flags & FLAG_REPROGRAM) {
 		ch->flags &=3D ~FLAG_REPROGRAM;
 		sh_cmt_clock_event_program_verify(ch, 1);
@@ -570,6 +573,8 @@ static irqreturn_t sh_cmt_interrupt(int irq, void *dev_id)
=20
 	ch->flags &=3D ~FLAG_IRQCONTEXT;
=20
+	raw_spin_unlock_irqrestore(&ch->lock, flags);
+
 	return IRQ_HANDLED;
 }
=20
@@ -780,12 +785,18 @@ static int sh_cmt_clock_event_next(unsigned long delta,
 				   struct clock_event_device *ced)
 {
 	struct sh_cmt_channel *ch =3D ced_to_sh_cmt(ced);
+	unsigned long flags;
=20
 	BUG_ON(!clockevent_state_oneshot(ced));
+
+	raw_spin_lock_irqsave(&ch->lock, flags);
+
 	if (likely(ch->flags & FLAG_IRQCONTEXT))
 		ch->next_match_value =3D delta - 1;
 	else
-		sh_cmt_set_next(ch, delta - 1);
+		__sh_cmt_set_next(ch, delta - 1);
+
+	raw_spin_unlock_irqrestore(&ch->lock, flags);
=20
 	return 0;
 }
diff --git a/drivers/clocksource/timer-rtl-otto.c b/drivers/clocksource/timer=
-rtl-otto.c
new file mode 100644
index 000000000000..8a3068b36e75
--- /dev/null
+++ b/drivers/clocksource/timer-rtl-otto.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/cpu.h>
+#include <linux/cpuhotplug.h>
+#include <linux/cpumask.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/printk.h>
+#include <linux/sched_clock.h>
+#include "timer-of.h"
+
+#define RTTM_DATA		0x0
+#define RTTM_CNT		0x4
+#define RTTM_CTRL		0x8
+#define RTTM_INT		0xc
+
+#define RTTM_CTRL_ENABLE	BIT(28)
+#define RTTM_INT_PENDING	BIT(16)
+#define RTTM_INT_ENABLE		BIT(20)
+
+/*
+ * The Otto platform provides multiple 28 bit timers/counters with the follo=
wing
+ * operating logic. If enabled the timer counts up. Per timer one can set a
+ * maximum counter value as an end marker. If end marker is reached the timer
+ * fires an interrupt. If the timer "overflows" by reaching the end marker or
+ * by adding 1 to 0x0fffffff the counter is reset to 0. When this happens and
+ * the timer is in operating mode COUNTER it stops. In mode TIMER it will
+ * continue to count up.
+ */
+#define RTTM_CTRL_COUNTER	0
+#define RTTM_CTRL_TIMER		BIT(24)
+
+#define RTTM_BIT_COUNT		28
+#define RTTM_MIN_DELTA		8
+#define RTTM_MAX_DELTA		CLOCKSOURCE_MASK(28)
+
+/*
+ * Timers are derived from the LXB clock frequency. Usually this is a fixed
+ * multiple of the 25 MHz oscillator. The 930X SOC is an exception from that.
+ * Its LXB clock has only dividers and uses the switch PLL of 2.45 GHz as its
+ * base. The only meaningful frequencies we can achieve from that are 175.000
+ * MHz and 153.125 MHz. The greatest common divisor of all explained possible
+ * speeds is 3125000. Pin the timers to this 3.125 MHz reference frequency.
+ */
+#define RTTM_TICKS_PER_SEC	3125000
+
+struct rttm_cs {
+	struct timer_of		to;
+	struct clocksource	cs;
+};
+
+/* Simple internal register functions */
+static inline void rttm_set_counter(void __iomem *base, unsigned int counter)
+{
+	iowrite32(counter, base + RTTM_CNT);
+}
+
+static inline unsigned int rttm_get_counter(void __iomem *base)
+{
+	return ioread32(base + RTTM_CNT);
+}
+
+static inline void rttm_set_period(void __iomem *base, unsigned int period)
+{
+	iowrite32(period, base + RTTM_DATA);
+}
+
+static inline void rttm_disable_timer(void __iomem *base)
+{
+	iowrite32(0, base + RTTM_CTRL);
+}
+
+static inline void rttm_enable_timer(void __iomem *base, u32 mode, u32 divis=
or)
+{
+	iowrite32(RTTM_CTRL_ENABLE | mode | divisor, base + RTTM_CTRL);
+}
+
+static inline void rttm_ack_irq(void __iomem *base)
+{
+	iowrite32(ioread32(base + RTTM_INT) | RTTM_INT_PENDING, base + RTTM_INT);
+}
+
+static inline void rttm_enable_irq(void __iomem *base)
+{
+	iowrite32(RTTM_INT_ENABLE, base + RTTM_INT);
+}
+
+static inline void rttm_disable_irq(void __iomem *base)
+{
+	iowrite32(0, base + RTTM_INT);
+}
+
+/* Aggregated control functions for kernel clock framework */
+#define RTTM_DEBUG(base)			\
+	pr_debug("------------- %d %p\n",	\
+		 smp_processor_id(), base)
+
+static irqreturn_t rttm_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *clkevt =3D dev_id;
+	struct timer_of *to =3D to_timer_of(clkevt);
+
+	rttm_ack_irq(to->of_base.base);
+	RTTM_DEBUG(to->of_base.base);
+	clkevt->event_handler(clkevt);
+
+	return IRQ_HANDLED;
+}
+
+static void rttm_stop_timer(void __iomem *base)
+{
+	rttm_disable_timer(base);
+	rttm_ack_irq(base);
+}
+
+static void rttm_start_timer(struct timer_of *to, u32 mode)
+{
+	rttm_set_counter(to->of_base.base, 0);
+	rttm_enable_timer(to->of_base.base, mode, to->of_clk.rate / RTTM_TICKS_PER_=
SEC);
+}
+
+static int rttm_next_event(unsigned long delta, struct clock_event_device *c=
lkevt)
+{
+	struct timer_of *to =3D to_timer_of(clkevt);
+
+	RTTM_DEBUG(to->of_base.base);
+	rttm_stop_timer(to->of_base.base);
+	rttm_set_period(to->of_base.base, delta);
+	rttm_start_timer(to, RTTM_CTRL_COUNTER);
+
+	return 0;
+}
+
+static int rttm_state_oneshot(struct clock_event_device *clkevt)
+{
+	struct timer_of *to =3D to_timer_of(clkevt);
+
+	RTTM_DEBUG(to->of_base.base);
+	rttm_stop_timer(to->of_base.base);
+	rttm_set_period(to->of_base.base, RTTM_TICKS_PER_SEC / HZ);
+	rttm_start_timer(to, RTTM_CTRL_COUNTER);
+
+	return 0;
+}
+
+static int rttm_state_periodic(struct clock_event_device *clkevt)
+{
+	struct timer_of *to =3D to_timer_of(clkevt);
+
+	RTTM_DEBUG(to->of_base.base);
+	rttm_stop_timer(to->of_base.base);
+	rttm_set_period(to->of_base.base, RTTM_TICKS_PER_SEC / HZ);
+	rttm_start_timer(to, RTTM_CTRL_TIMER);
+
+	return 0;
+}
+
+static int rttm_state_shutdown(struct clock_event_device *clkevt)
+{
+	struct timer_of *to =3D to_timer_of(clkevt);
+
+	RTTM_DEBUG(to->of_base.base);
+	rttm_stop_timer(to->of_base.base);
+
+	return 0;
+}
+
+static void rttm_setup_timer(void __iomem *base)
+{
+	RTTM_DEBUG(base);
+	rttm_stop_timer(base);
+	rttm_set_period(base, 0);
+}
+
+static u64 rttm_read_clocksource(struct clocksource *cs)
+{
+	struct rttm_cs *rcs =3D container_of(cs, struct rttm_cs, cs);
+
+	return rttm_get_counter(rcs->to.of_base.base);
+}
+
+/* Module initialization part. */
+static DEFINE_PER_CPU(struct timer_of, rttm_to) =3D {
+	.flags				=3D TIMER_OF_BASE | TIMER_OF_CLOCK | TIMER_OF_IRQ,
+	.of_irq =3D {
+		.flags			=3D IRQF_PERCPU | IRQF_TIMER,
+		.handler		=3D rttm_timer_interrupt,
+	},
+	.clkevt =3D {
+		.rating			=3D 400,
+		.features		=3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+		.set_state_periodic	=3D rttm_state_periodic,
+		.set_state_shutdown	=3D rttm_state_shutdown,
+		.set_state_oneshot	=3D rttm_state_oneshot,
+		.set_next_event		=3D rttm_next_event
+	},
+};
+
+static int rttm_enable_clocksource(struct clocksource *cs)
+{
+	struct rttm_cs *rcs =3D container_of(cs, struct rttm_cs, cs);
+
+	rttm_disable_irq(rcs->to.of_base.base);
+	rttm_setup_timer(rcs->to.of_base.base);
+	rttm_enable_timer(rcs->to.of_base.base, RTTM_CTRL_TIMER,
+			  rcs->to.of_clk.rate / RTTM_TICKS_PER_SEC);
+
+	return 0;
+}
+
+struct rttm_cs rttm_cs =3D {
+	.to =3D {
+		.flags	=3D TIMER_OF_BASE | TIMER_OF_CLOCK,
+	},
+	.cs =3D {
+		.name	=3D "realtek_otto_timer",
+		.rating	=3D 400,
+		.mask	=3D CLOCKSOURCE_MASK(RTTM_BIT_COUNT),
+		.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
+		.read	=3D rttm_read_clocksource,
+	}
+};
+
+static u64 notrace rttm_read_clock(void)
+{
+	return rttm_get_counter(rttm_cs.to.of_base.base);
+}
+
+static int rttm_cpu_starting(unsigned int cpu)
+{
+	struct timer_of *to =3D per_cpu_ptr(&rttm_to, cpu);
+
+	RTTM_DEBUG(to->of_base.base);
+	to->clkevt.cpumask =3D cpumask_of(cpu);
+	irq_force_affinity(to->of_irq.irq, to->clkevt.cpumask);
+	clockevents_config_and_register(&to->clkevt, RTTM_TICKS_PER_SEC,
+					RTTM_MIN_DELTA, RTTM_MAX_DELTA);
+	rttm_enable_irq(to->of_base.base);
+
+	return 0;
+}
+
+static int __init rttm_probe(struct device_node *np)
+{
+	unsigned int cpu, cpu_rollback;
+	struct timer_of *to;
+	unsigned int clkidx =3D num_possible_cpus();
+
+	/* Use the first n timers as per CPU clock event generators */
+	for_each_possible_cpu(cpu) {
+		to =3D per_cpu_ptr(&rttm_to, cpu);
+		to->of_irq.index =3D to->of_base.index =3D cpu;
+		if (timer_of_init(np, to)) {
+			pr_err("setup of timer %d failed\n", cpu);
+			goto rollback;
+		}
+		rttm_setup_timer(to->of_base.base);
+	}
+
+	/* Activate the n'th + 1 timer as a stable CPU clocksource. */
+	to =3D &rttm_cs.to;
+	to->of_base.index =3D clkidx;
+	timer_of_init(np, to);
+	if (rttm_cs.to.of_base.base && rttm_cs.to.of_clk.rate) {
+		rttm_enable_clocksource(&rttm_cs.cs);
+		clocksource_register_hz(&rttm_cs.cs, RTTM_TICKS_PER_SEC);
+		sched_clock_register(rttm_read_clock, RTTM_BIT_COUNT, RTTM_TICKS_PER_SEC);
+	} else
+		pr_err(" setup of timer %d as clocksource failed", clkidx);
+
+	return cpuhp_setup_state(CPUHP_AP_REALTEK_TIMER_STARTING,
+				"timer/realtek:online",
+				rttm_cpu_starting, NULL);
+rollback:
+	pr_err("timer registration failed\n");
+	for_each_possible_cpu(cpu_rollback) {
+		if (cpu_rollback =3D=3D cpu)
+			break;
+		to =3D per_cpu_ptr(&rttm_to, cpu_rollback);
+		timer_of_cleanup(to);
+	}
+
+	return -EINVAL;
+}
+
+TIMER_OF_DECLARE(otto_timer, "realtek,otto-timer", rttm_probe);
diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethernet/i=
ntel/e1000e/ptp.c
index bbcfd529399b..89d57dd911dc 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -124,7 +124,8 @@ static int e1000e_phc_get_syncdevicetime(ktime_t *device,
 	sys_cycles =3D er32(PLTSTMPH);
 	sys_cycles <<=3D 32;
 	sys_cycles |=3D er32(PLTSTMPL);
-	*system =3D convert_art_to_tsc(sys_cycles);
+	system->cycles =3D sys_cycles;
+	system->cs_id =3D CSID_X86_ART;
=20
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/=
intel/ice/ice_ptp.c
index fefaf52fd677..927b623cedd5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2156,7 +2156,8 @@ ice_ptp_get_syncdevicetime(ktime_t *device,
 			hh_ts_lo =3D rd32(hw, GLHH_ART_TIME_L);
 			hh_ts_hi =3D rd32(hw, GLHH_ART_TIME_H);
 			hh_ts =3D ((u64)hh_ts_hi << 32) | hh_ts_lo;
-			*system =3D convert_art_ns_to_tsc(hh_ts);
+			system->cycles =3D hh_ts;
+			system->cs_id =3D CSID_X86_ART;
 			/* Read Device source clock time */
 			hh_ts_lo =3D rd32(hw, GLTSYN_HHTIME_L(tmr_idx));
 			hh_ts_hi =3D rd32(hw, GLTSYN_HHTIME_H(tmr_idx));
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/=
intel/igc/igc_ptp.c
index 1bb026232efc..946edbad4302 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -938,7 +938,11 @@ static bool igc_is_crosststamp_supported(struct igc_adap=
ter *adapter)
 static struct system_counterval_t igc_device_tstamp_to_system(u64 tstamp)
 {
 #if IS_ENABLED(CONFIG_X86_TSC) && !defined(CONFIG_UML)
-	return convert_art_ns_to_tsc(tstamp);
+	return (struct system_counterval_t) {
+		.cs_id		=3D CSID_X86_ART,
+		.cycles		=3D tstamp,
+		.use_nsecs	=3D true,
+	};
 #else
 	return (struct system_counterval_t) { };
 #endif
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/=
ethernet/stmicro/stmmac/dwmac-intel.c
index 60283543ffc8..e73fa34237d3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -390,10 +390,11 @@ static int intel_crosststamp(ktime_t *device,
 		*device =3D ns_to_ktime(ptp_time);
 		read_unlock_irqrestore(&priv->ptp_lock, flags);
 		get_arttime(priv->mii, intel_priv->mdio_adhoc_addr, &art_time);
-		*system =3D convert_art_to_tsc(art_time);
+		system->cycles =3D art_time;
 	}
=20
 	system->cycles *=3D intel_priv->crossts_adj;
+	system->cs_id =3D CSID_X86_ART;
 	priv->plat->flags &=3D ~STMMAC_FLAG_INT_SNAPSHOT_EN;
=20
 	return 0;
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 0ad8b550bb4b..d35b677b08fe 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -21,6 +21,7 @@
 #include <asm/div64.h>
 #include <asm/io.h>
=20
+struct clocksource_base;
 struct clocksource;
 struct module;
=20
@@ -50,6 +51,7 @@ struct module;
  *			multiplication
  * @name:		Pointer to clocksource name
  * @list:		List head for registration (internal)
+ * @freq_khz:		Clocksource frequency in khz.
  * @rating:		Rating value for selection (higher is better)
  *			To avoid rating inflation the following
  *			list should give you a guide as to how
@@ -70,6 +72,8 @@ struct module;
  *			validate the clocksource from which the snapshot was
  *			taken.
  * @flags:		Flags describing special properties
+ * @base:		Hardware abstraction for clock on which a clocksource
+ *			is based
  * @enable:		Optional function to enable the clocksource
  * @disable:		Optional function to disable the clocksource
  * @suspend:		Optional suspend function for the clocksource
@@ -107,10 +111,12 @@ struct clocksource {
 	u64			max_cycles;
 	const char		*name;
 	struct list_head	list;
+	u32			freq_khz;
 	int			rating;
 	enum clocksource_ids	id;
 	enum vdso_clock_mode	vdso_clock_mode;
 	unsigned long		flags;
+	struct clocksource_base *base;
=20
 	int			(*enable)(struct clocksource *cs);
 	void			(*disable)(struct clocksource *cs);
@@ -306,4 +312,25 @@ static inline unsigned int clocksource_get_max_watchdog_=
retry(void)
=20
 void clocksource_verify_percpu(struct clocksource *cs);
=20
+/**
+ * struct clocksource_base - hardware abstraction for clock on which a clock=
source
+ *			is based
+ * @id:			Defaults to CSID_GENERIC. The id value is used for conversion
+ *			functions which require that the current clocksource is based
+ *			on a clocksource_base with a particular ID in certain snapshot
+ *			functions to allow callers to validate the clocksource from
+ *			which the snapshot was taken.
+ * @freq_khz:		Nominal frequency of the base clock in kHz
+ * @offset:		Offset between the base clock and the clocksource
+ * @numerator:		Numerator of the clock ratio between base clock and the cloc=
ksource
+ * @denominator:	Denominator of the clock ratio between base clock and the c=
locksource
+ */
+struct clocksource_base {
+	enum clocksource_ids	id;
+	u32			freq_khz;
+	u64			offset;
+	u32			numerator;
+	u32			denominator;
+};
+
 #endif /* _LINUX_CLOCKSOURCE_H */
diff --git a/include/linux/clocksource_ids.h b/include/linux/clocksource_ids.h
index a4fa3436940c..2bb4d8c2f1b0 100644
--- a/include/linux/clocksource_ids.h
+++ b/include/linux/clocksource_ids.h
@@ -9,6 +9,7 @@ enum clocksource_ids {
 	CSID_X86_TSC_EARLY,
 	CSID_X86_TSC,
 	CSID_X86_KVM_CLK,
+	CSID_X86_ART,
 	CSID_MAX,
 };
=20
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 7a5785f405b6..56b744dc1317 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -171,6 +171,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARMADA_TIMER_STARTING,
 	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
 	CPUHP_AP_ARC_TIMER_STARTING,
+	CPUHP_AP_REALTEK_TIMER_STARTING,
 	CPUHP_AP_RISCV_TIMER_STARTING,
 	CPUHP_AP_CLINT_TIMER_STARTING,
 	CPUHP_AP_CSKY_TIMER_STARTING,
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 4924a33700b7..72744638c5b0 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -139,7 +139,6 @@ extern void tick_nohz_irq_exit(void);
 extern bool tick_nohz_idle_got_tick(void);
 extern ktime_t tick_nohz_get_next_hrtimer(void);
 extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
-extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 0ea7823b7f31..fc12a9ba2c88 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -310,12 +310,18 @@ struct system_device_crosststamp {
  *		timekeeping code to verify comparability of two cycle values.
  *		The default ID, CSID_GENERIC, does not identify a specific
  *		clocksource.
+ * @use_nsecs:	@cycles is in nanoseconds.
  */
 struct system_counterval_t {
 	u64			cycles;
 	enum clocksource_ids	cs_id;
+	bool			use_nsecs;
 };
=20
+extern bool ktime_real_to_base_clock(ktime_t treal,
+				     enum clocksource_ids base_id, u64 *cycles);
+extern bool timekeeping_clocksource_has_base(enum clocksource_ids id);
+
 /*
  * Get cross timestamp between system clock and device clock
  */
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index d04d394db064..7647e0946f50 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -77,6 +77,10 @@ struct vdso_timestamp {
  * vdso_data will be accessed by 64 bit and compat code at the same time
  * so we should be careful before modifying this structure.
  *
+ * The ordering of the struct members is optimized to have fast access to the
+ * often required struct members which are related to CLOCK_REALTIME and
+ * CLOCK_MONOTONIC. This information is stored in the first cache lines.
+ *
  * @basetime is used to store the base time for the system wide time getter
  * VVAR page.
  *
diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtes=
t.c
index d06185e054ea..62e73444ffe4 100644
--- a/kernel/time/clocksource-wdtest.c
+++ b/kernel/time/clocksource-wdtest.c
@@ -22,6 +22,7 @@
 #include "tick-internal.h"
=20
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Clocksource watchdog unit test");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@kernel.org>");
=20
 static int holdoff =3D IS_BUILTIN(CONFIG_TEST_CLOCKSOURCE_WATCHDOG) ? 10 : 0;
diff --git a/kernel/time/test_udelay.c b/kernel/time/test_udelay.c
index 20d5df631570..783f2297111b 100644
--- a/kernel/time/test_udelay.c
+++ b/kernel/time/test_udelay.c
@@ -155,5 +155,6 @@ static void __exit udelay_test_exit(void)
=20
 module_exit(udelay_test_exit);
=20
+MODULE_DESCRIPTION("udelay test module");
 MODULE_AUTHOR("David Riley <davidriley@chromium.org>");
 MODULE_LICENSE("GPL");
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 771d1e040303..b4843099a8da 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -1141,6 +1141,7 @@ void tick_broadcast_switch_to_oneshot(void)
 #ifdef CONFIG_HOTPLUG_CPU
 void hotplug_cpu__broadcast_tick_pull(int deadcpu)
 {
+	struct tick_device *td =3D this_cpu_ptr(&tick_cpu_device);
 	struct clock_event_device *bc;
 	unsigned long flags;
=20
@@ -1148,6 +1149,28 @@ void hotplug_cpu__broadcast_tick_pull(int deadcpu)
 	bc =3D tick_broadcast_device.evtdev;
=20
 	if (bc && broadcast_needs_cpu(bc, deadcpu)) {
+		/*
+		 * If the broadcast force bit of the current CPU is set,
+		 * then the current CPU has not yet reprogrammed the local
+		 * timer device to avoid a ping-pong race. See
+		 * ___tick_broadcast_oneshot_control().
+		 *
+		 * If the broadcast device is hrtimer based then
+		 * programming the broadcast event below does not have any
+		 * effect because the local clockevent device is not
+		 * running and not programmed because the broadcast event
+		 * is not earlier than the pending event of the local clock
+		 * event device. As a consequence all CPUs waiting for a
+		 * broadcast event are stuck forever.
+		 *
+		 * Detect this condition and reprogram the cpu local timer
+		 * device to avoid the starvation.
+		 */
+		if (tick_check_broadcast_expired()) {
+			cpumask_clear_cpu(smp_processor_id(), tick_broadcast_force_mask);
+			tick_program_event(td->evtdev->next_event, 1);
+		}
+
 		/* This moves the broadcast assignment to this CPU: */
 		clockevents_program_event(bc, bc->next_event, 1);
 	}
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 71a792cd8936..753a184c7090 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1026,10 +1026,10 @@ static void tick_nohz_stop_tick(struct tick_sched *ts=
, int cpu)
 		if (expires =3D=3D KTIME_MAX || ts->next_tick =3D=3D hrtimer_get_expires(&=
ts->sched_timer))
 			return;
=20
-		WARN_ON_ONCE(1);
-		printk_once("basemono: %llu ts->next_tick: %llu dev->next_event: %llu time=
r->active: %d timer->expires: %llu\n",
-			    basemono, ts->next_tick, dev->next_event,
-			    hrtimer_active(&ts->sched_timer), hrtimer_get_expires(&ts->sched_time=
r));
+		WARN_ONCE(1, "basemono: %llu ts->next_tick: %llu dev->next_event: %llu "
+			  "timer->active: %d timer->expires: %llu\n", basemono, ts->next_tick,
+			  dev->next_event, hrtimer_active(&ts->sched_timer),
+			  hrtimer_get_expires(&ts->sched_timer));
 	}
=20
 	/*
@@ -1385,20 +1385,6 @@ unsigned long tick_nohz_get_idle_calls_cpu(int cpu)
 	return ts->idle_calls;
 }
=20
-/**
- * tick_nohz_get_idle_calls - return the current idle calls counter value
- *
- * Called from the schedutil frequency scaling governor in scheduler context.
- *
- * Return: the current idle calls counter value for the current CPU
- */
-unsigned long tick_nohz_get_idle_calls(void)
-{
-	struct tick_sched *ts =3D this_cpu_ptr(&tick_cpu_sched);
-
-	return ts->idle_calls;
-}
-
 static void tick_nohz_account_idle_time(struct tick_sched *ts,
 					ktime_t now)
 {
diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
index 3e5d422dd15c..2889763165e5 100644
--- a/kernel/time/time_test.c
+++ b/kernel/time/time_test.c
@@ -96,4 +96,5 @@ static struct kunit_suite time_test_suite =3D {
 };
=20
 kunit_test_suite(time_test_suite);
+MODULE_DESCRIPTION("time unit test suite");
 MODULE_LICENSE("GPL");
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4e18db1819f8..2fa87dcfeda9 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1195,6 +1195,108 @@ static bool timestamp_in_interval(u64 start, u64 end,=
 u64 ts)
 	return false;
 }
=20
+static bool convert_clock(u64 *val, u32 numerator, u32 denominator)
+{
+	u64 rem, res;
+
+	if (!numerator || !denominator)
+		return false;
+
+	res =3D div64_u64_rem(*val, denominator, &rem) * numerator;
+	*val =3D res + div_u64(rem * numerator, denominator);
+	return true;
+}
+
+static bool convert_base_to_cs(struct system_counterval_t *scv)
+{
+	struct clocksource *cs =3D tk_core.timekeeper.tkr_mono.clock;
+	struct clocksource_base *base;
+	u32 num, den;
+
+	/* The timestamp was taken from the time keeper clock source */
+	if (cs->id =3D=3D scv->cs_id)
+		return true;
+
+	/*
+	 * Check whether cs_id matches the base clock. Prevent the compiler from
+	 * re-evaluating @base as the clocksource might change concurrently.
+	 */
+	base =3D READ_ONCE(cs->base);
+	if (!base || base->id !=3D scv->cs_id)
+		return false;
+
+	num =3D scv->use_nsecs ? cs->freq_khz : base->numerator;
+	den =3D scv->use_nsecs ? USEC_PER_SEC : base->denominator;
+
+	if (!convert_clock(&scv->cycles, num, den))
+		return false;
+
+	scv->cycles +=3D base->offset;
+	return true;
+}
+
+static bool convert_cs_to_base(u64 *cycles, enum clocksource_ids base_id)
+{
+	struct clocksource *cs =3D tk_core.timekeeper.tkr_mono.clock;
+	struct clocksource_base *base;
+
+	/*
+	 * Check whether base_id matches the base clock. Prevent the compiler from
+	 * re-evaluating @base as the clocksource might change concurrently.
+	 */
+	base =3D READ_ONCE(cs->base);
+	if (!base || base->id !=3D base_id)
+		return false;
+
+	*cycles -=3D base->offset;
+	if (!convert_clock(cycles, base->denominator, base->numerator))
+		return false;
+	return true;
+}
+
+static bool convert_ns_to_cs(u64 *delta)
+{
+	struct tk_read_base *tkr =3D &tk_core.timekeeper.tkr_mono;
+
+	if (BITS_TO_BYTES(fls64(*delta) + tkr->shift) >=3D sizeof(*delta))
+		return false;
+
+	*delta =3D div_u64((*delta << tkr->shift) - tkr->xtime_nsec, tkr->mult);
+	return true;
+}
+
+/**
+ * ktime_real_to_base_clock() - Convert CLOCK_REALTIME timestamp to a base c=
lock timestamp
+ * @treal:	CLOCK_REALTIME timestamp to convert
+ * @base_id:	base clocksource id
+ * @cycles:	pointer to store the converted base clock timestamp
+ *
+ * Converts a supplied, future realtime clock value to the corresponding bas=
e clock value.
+ *
+ * Return:  true if the conversion is successful, false otherwise.
+ */
+bool ktime_real_to_base_clock(ktime_t treal, enum clocksource_ids base_id, u=
64 *cycles)
+{
+	struct timekeeper *tk =3D &tk_core.timekeeper;
+	unsigned int seq;
+	u64 delta;
+
+	do {
+		seq =3D read_seqcount_begin(&tk_core.seq);
+		if ((u64)treal < tk->tkr_mono.base_real)
+			return false;
+		delta =3D (u64)treal - tk->tkr_mono.base_real;
+		if (!convert_ns_to_cs(&delta))
+			return false;
+		*cycles =3D tk->tkr_mono.cycle_last + delta;
+		if (!convert_cs_to_base(cycles, base_id))
+			return false;
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(ktime_real_to_base_clock);
+
 /**
  * get_device_system_crosststamp - Synchronously capture system/device times=
tamp
  * @get_time_fn:	Callback to get simultaneous device time and
@@ -1241,7 +1343,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 		 * installed timekeeper clocksource
 		 */
 		if (system_counterval.cs_id =3D=3D CSID_GENERIC ||
-		    tk->tkr_mono.clock->id !=3D system_counterval.cs_id)
+		    !convert_base_to_cs(&system_counterval))
 			return -ENODEV;
 		cycles =3D system_counterval.cycles;
=20
@@ -1306,6 +1408,30 @@ int get_device_system_crosststamp(int (*get_time_fn)
 }
 EXPORT_SYMBOL_GPL(get_device_system_crosststamp);
=20
+/**
+ * timekeeping_clocksource_has_base - Check whether the current clocksource
+ *				      is based on given a base clock
+ * @id:		base clocksource ID
+ *
+ * Note:	The return value is a snapshot which can become invalid right
+ *		after the function returns.
+ *
+ * Return:	true if the timekeeper clocksource has a base clock with @id,
+ *		false otherwise
+ */
+bool timekeeping_clocksource_has_base(enum clocksource_ids id)
+{
+	/*
+	 * This is a snapshot, so no point in using the sequence
+	 * count. Just prevent the compiler from re-evaluating @base as the
+	 * clocksource might change concurrently.
+	 */
+	struct clocksource_base *base =3D READ_ONCE(tk_core.timekeeper.tkr_mono.clo=
ck->base);
+
+	return base ? base->id =3D=3D id : false;
+}
+EXPORT_SYMBOL_GPL(timekeeping_clocksource_has_base);
+
 /**
  * do_settimeofday64 - Sets the time of day.
  * @ts:     pointer to the timespec64 variable containing the new time
@@ -2421,6 +2547,7 @@ EXPORT_SYMBOL_GPL(random_get_entropy_fallback);
=20
 /**
  * do_adjtimex() - Accessor function to NTP __do_adjtimex function
+ * @txc:	Pointer to kernel_timex structure containing NTP parameters
  */
 int do_adjtimex(struct __kernel_timex *txc)
 {
@@ -2489,6 +2616,8 @@ int do_adjtimex(struct __kernel_timex *txc)
 #ifdef CONFIG_NTP_PPS
 /**
  * hardpps() - Accessor function to NTP __hardpps function
+ * @phase_ts:	Pointer to timespec64 structure representing phase timestamp
+ * @raw_ts:	Pointer to timespec64 structure representing raw timestamp
  */
 void hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw=
_ts)
 {
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 899850bd6f0b..c01eaafd8041 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -140,14 +140,14 @@ static __always_inline int do_hres(const struct vdso_da=
ta *vd, clockid_t clk,
=20
 	do {
 		/*
-		 * Open coded to handle VDSO_CLOCKMODE_TIMENS. Time namespace
-		 * enabled tasks have a special VVAR page installed which
-		 * has vd->seq set to 1 and vd->clock_mode set to
-		 * VDSO_CLOCKMODE_TIMENS. For non time namespace affected tasks
-		 * this does not affect performance because if vd->seq is
-		 * odd, i.e. a concurrent update is in progress the extra
-		 * check for vd->clock_mode is just a few extra
-		 * instructions while spin waiting for vd->seq to become
+		 * Open coded function vdso_read_begin() to handle
+		 * VDSO_CLOCKMODE_TIMENS. Time namespace enabled tasks have a
+		 * special VVAR page installed which has vd->seq set to 1 and
+		 * vd->clock_mode set to VDSO_CLOCKMODE_TIMENS. For non time
+		 * namespace affected tasks this does not affect performance
+		 * because if vd->seq is odd, i.e. a concurrent update is in
+		 * progress the extra check for vd->clock_mode is just a few
+		 * extra instructions while spin waiting for vd->seq to become
 		 * even again.
 		 */
 		while (unlikely((seq =3D READ_ONCE(vd->seq)) & 1)) {
@@ -223,8 +223,8 @@ static __always_inline int do_coarse(const struct vdso_da=
ta *vd, clockid_t clk,
=20
 	do {
 		/*
-		 * Open coded to handle VDSO_CLOCK_TIMENS. See comment in
-		 * do_hres().
+		 * Open coded function vdso_read_begin() to handle
+		 * VDSO_CLOCK_TIMENS. See comment in do_hres().
 		 */
 		while ((seq =3D READ_ONCE(vd->seq)) & 1) {
 			if (IS_ENABLED(CONFIG_TIME_NS) &&
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 766734dc5be2..5d86e5a9c814 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -463,7 +463,8 @@ static int azx_get_sync_time(ktime_t *device,
 	*device =3D ktime_add_ns(*device, (wallclk_cycles * NSEC_PER_SEC) /
 			       ((HDA_MAX_CYCLE_VALUE + 1) * runtime->rate));
=20
-	*system =3D convert_art_to_tsc(tsc_counter);
+	system->cycles =3D tsc_counter;
+	system->cs_id =3D CSID_X86_ART;
=20
 	return 0;
 }


