Return-Path: <linux-kernel+bounces-177577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E788C40FE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693E928223F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76AF150989;
	Mon, 13 May 2024 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iOohE7X4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nepNU4fP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6261474BE
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604604; cv=none; b=usnWRedSdVMAIsSafJUsOf+iF+EjZIEb0fL/5rBWVF/ilH/xqfSvz1jS3LNXQ5QRYbA7U2i6EcpuO6hv17aUiblVjrlSoNnlIv/UsfO3NktJCxZiI92t4CwtnhbC14H7RfL2fWYEpo9BbFT0GD8xa2bUbLj6WYfG6qD4hDxKBlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604604; c=relaxed/simple;
	bh=LqesJ519+Yhq4vY3EAbpN9pu3NjqC3vAMkWGXFuU+4o=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=lBPOlq8WC8JSpyaaLfMlqzNoeDXyJNeZeUtHBn21L1tgN8IWFZ8yOeEuiZ5IxfwgZ/mtW6zwOIN34su1jvjXBN8uykhnzop7IPwNtiCV/xgkwPNnER7aa2FI6IXYoGX5afHp4hepBB4V9M+XZhJHZzCby3hREzoUUNPOuwZMLnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iOohE7X4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nepNU4fP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715604600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=vZbd85XOjWg1+GRdZBpjICEXdLk7or0v6xi6NIp8Baw=;
	b=iOohE7X4LAnZT50AIsfU6tJuxdCxuFS8R74roROkucEO2NNGWHWIGBWF58BbKAzDpd1GG5
	aKO6UvTK2KQwNHw2dovUtaGlMv3R6N85BZKn3TCdSZvSNT31u/5Q+6lEgdvwXZBo2gw9IB
	fimronkJVcYqm4vlJdT4KoDGceI5vJIW+PI+58qVmSa9echYMC1Z8f5dAU8oe6Sf3HeGSg
	PM4sODRaWo3hJeA5X6+VCk00+aGAdq9h9i1mY9KuAAuP79baVkLjsL7jnEDA+Sh3nt2c1g
	NoO/owJ6j3x1RL4bXfHyVyzNHldVLOIpKcpCO5fd79KiYCD++XxuWOh6qeN/Sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715604600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=vZbd85XOjWg1+GRdZBpjICEXdLk7or0v6xi6NIp8Baw=;
	b=nepNU4fPmctcA32YwjqXxlSJKqhWIwEQIgg0og2spfgU7jYfZCSkh3FTUCDLi/4rTDyrgE
	Hp/8ML2MYwXjmmDA==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v6.10-rc1
References: 
 <171560454635.3871325.5773365584560034962.tglx@xen13.tec.linutronix.de>
Message-ID: 
 <171560454760.3871325.16502445987718332843.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 May 2024 14:50:00 +0200 (CEST)

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024=
-05-12

up to:  a3825a769158: Merge tag 'timers-v6.10-rc1' of https://git.linaro.org/=
people/daniel.lezcano/linux into timers/core

Timers and timekeeping updates:

 - Core code:

   - Make timekeeping and VDSO time readouts resilent against math overflow:

     In guest context the kernel is prone to math overflow when the host
     defers the timer interrupt due to overload, malfunction or malice.

     This can be mitigated by checking the clocksource delta for the
     maximum deferrement which is readily available. If that value is
     exceeded then the code uses a slowpath function which can handle the
     multiplication overflow.

     This functionality is enabled unconditionally in the kernel, but made
     conditional in the VDSO code. The latter is conditional because it
     allows architectures to optimize the check so it is not causing
     performance regressions.

     On X86 this is achieved by reworking the existing check for negative
     TSC deltas as a negative delta obviously exceeds the maximum
     deferrement when it is evaluated as an unsigned value. That avoids two
     conditionals in the hotpath and allows to hide both the negative delta
     and the large delta handling in the same slow path.

   - Add an initial minimal ktime_t abstraction for Rust

   - The usual boring cleanups and enhancements

 - Drivers:

   - Boring updates to device trees and trivial enhancements in various
     drivers.

Thanks,

	tglx

------------------>
Adrian Hunter (20):
      vdso: Consolidate vdso_calc_delta()
      vdso: Consolidate nanoseconds calculation
      vdso: Add CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
      math64: Tidy up mul_u64_u32_shr()
      vdso, math64: Provide mul_u64_u32_add_u64_shr()
      vdso: Add vdso_data:: Max_cycles
      vdso: Make delta calculation overflow safe
      x86/vdso: Make delta calculation overflow safe
      timekeeping: Move timekeeping helper functions
      timekeeping: Rename fast_tk_get_delta_ns() to __timekeeping_get_ns()
      timekeeping: Tidy timekeeping_cycles_to_ns() slightly
      timekeeping: Reuse timekeeping_cycles_to_ns()
      timekeeping: Refactor timekeeping helpers
      timekeeping: Consolidate timekeeping helpers
      timekeeping: Fold in timekeeping_delta_to_ns()
      timekeeping: Prepare timekeeping_cycles_to_ns() for overflow safety
      timekeeping: Make delta calculation overflow safe
      timekeeping: Let timekeeping_cycles_to_ns() handle both under and overf=
low
      clocksource: Make watchdog and suspend-timing multiplication overflow s=
afe
      vdso: Fix powerpc build U64_MAX undeclared error

Alice Ryhl (1):
      rust: time: Add Ktime

Anna-Maria Behnsen (1):
      timerqueue: Remove never used function timerqueue_node_expires()

Boqun Feng (1):
      rust: time: doc: Add missing C header links

Borislav Petkov (AMD) (1):
      clocksource: Make the int help prompt unit readable in ncurses

Christophe JAILLET (1):
      clocksource/drivers/timer-ti-dm: Remove an unused field in struct dmtim=
er

Geert Uytterhoeven (1):
      clocksource/drivers/renesas-ostm: Avoid reprobe after successful early =
probe

Jiapeng Chong (2):
      hrtimer: Remove unused function
      hrtimer: Rename __hrtimer_hres_active() to hrtimer_hres_active()

Lad Prabhakar (2):
      dt-bindings: timer: renesas: ostm: Document Renesas RZ/V2H(P) SoC
      clocksource/drivers/renesas-ostm: Allow OSTM driver to reprobe for RZ/V=
2H(P) SoC

Li Zhijian (2):
      clocksource: Convert s[n]printf() to sysfs_emit()
      clockevents: Convert s[n]printf() to sysfs_emit()

Stephen Boyd (1):
      clocksource/drivers/arm_arch_timer: Mark hisi_161010101_oem_info const


 .../devicetree/bindings/timer/renesas,ostm.yaml    |  2 +
 arch/powerpc/include/asm/vdso/gettimeofday.h       | 26 +++---
 arch/s390/include/asm/vdso/gettimeofday.h          |  7 +-
 arch/x86/Kconfig                                   |  1 +
 arch/x86/include/asm/vdso/gettimeofday.h           | 44 ++++++----
 drivers/clocksource/arm_arch_timer.c               |  2 +-
 drivers/clocksource/renesas-ostm.c                 |  3 +-
 drivers/clocksource/timer-ti-dm.c                  |  1 -
 include/linux/math64.h                             |  8 +-
 include/linux/timerqueue.h                         |  5 --
 include/vdso/datapage.h                            |  4 +
 include/vdso/math64.h                              | 38 +++++++++
 kernel/time/Kconfig                                |  2 +-
 kernel/time/clockevents.c                          |  2 +-
 kernel/time/clocksource.c                          | 44 +++++-----
 kernel/time/hrtimer.c                              | 41 ++-------
 kernel/time/timekeeping.c                          | 96 +++++++++++---------=
--
 kernel/time/vsyscall.c                             |  6 ++
 lib/vdso/Kconfig                                   |  7 ++
 lib/vdso/gettimeofday.c                            | 55 ++++++++-----
 rust/kernel/time.rs                                | 63 ++++++++++++++
 21 files changed, 284 insertions(+), 173 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml b/Docu=
mentation/devicetree/bindings/timer/renesas,ostm.yaml
index 8b06a681764e..e8c642166462 100644
--- a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
@@ -26,6 +26,7 @@ properties:
           - renesas,r9a07g043-ostm # RZ/G2UL and RZ/Five
           - renesas,r9a07g044-ostm # RZ/G2{L,LC}
           - renesas,r9a07g054-ostm # RZ/V2L
+          - renesas,r9a09g057-ostm # RZ/V2H(P)
       - const: renesas,ostm        # Generic
=20
   reg:
@@ -58,6 +59,7 @@ if:
           - renesas,r9a07g043-ostm
           - renesas,r9a07g044-ostm
           - renesas,r9a07g054-ostm
+          - renesas,r9a09g057-ostm
 then:
   required:
     - resets
diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/incl=
ude/asm/vdso/gettimeofday.h
index 78302f6c2580..c6390890a60c 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -13,6 +13,17 @@
=20
 #define VDSO_HAS_TIME			1
=20
+/*
+ * powerpc specific delta calculation.
+ *
+ * This variant removes the masking of the subtraction because the
+ * clocksource mask of all VDSO capable clocksources on powerpc is U64_MAX
+ * which would result in a pointless operation. The compiler cannot
+ * optimize it away as the mask comes from the vdso data and is not compile
+ * time constant.
+ */
+#define VDSO_DELTA_NOMASK		1
+
 static __always_inline int do_syscall_2(const unsigned long _r0, const unsig=
ned long _r3,
 					const unsigned long _r4)
 {
@@ -104,21 +115,6 @@ static inline bool vdso_clocksource_ok(const struct vdso=
_data *vd)
 }
 #define vdso_clocksource_ok vdso_clocksource_ok
=20
-/*
- * powerpc specific delta calculation.
- *
- * This variant removes the masking of the subtraction because the
- * clocksource mask of all VDSO capable clocksources on powerpc is U64_MAX
- * which would result in a pointless operation. The compiler cannot
- * optimize it away as the mask comes from the vdso data and is not compile
- * time constant.
- */
-static __always_inline u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u=
32 mult)
-{
-	return (cycles - last) * mult;
-}
-#define vdso_calc_delta vdso_calc_delta
-
 #ifndef __powerpc64__
 static __always_inline u64 vdso_shift_ns(u64 ns, unsigned long shift)
 {
diff --git a/arch/s390/include/asm/vdso/gettimeofday.h b/arch/s390/include/as=
m/vdso/gettimeofday.h
index db84942eb78f..7937765ccfa5 100644
--- a/arch/s390/include/asm/vdso/gettimeofday.h
+++ b/arch/s390/include/asm/vdso/gettimeofday.h
@@ -6,16 +6,13 @@
=20
 #define VDSO_HAS_CLOCK_GETRES 1
=20
+#define VDSO_DELTA_NOMASK 1
+
 #include <asm/syscall.h>
 #include <asm/timex.h>
 #include <asm/unistd.h>
 #include <linux/compiler.h>
=20
-#define vdso_calc_delta __arch_vdso_calc_delta
-static __always_inline u64 __arch_vdso_calc_delta(u64 cycles, u64 last, u64 =
mask, u32 mult)
-{
-	return (cycles - last) * mult;
-}
=20
 static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 {
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4fff6ed46e90..4e251ba3bad2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -168,6 +168,7 @@ config X86
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_VDSO_TIME_NS
+	select GENERIC_VDSO_OVERFLOW_PROTECT
 	select GUP_GET_PXX_LOW_HIGH		if X86_PAE
 	select HARDIRQS_SW_RESEND
 	select HARDLOCKUP_CHECK_TIMESTAMP	if X86_64
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/=
vdso/gettimeofday.h
index 8e048ca980df..0ef36190abe6 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -300,7 +300,7 @@ static inline bool arch_vdso_cycles_ok(u64 cycles)
 #define vdso_cycles_ok arch_vdso_cycles_ok
=20
 /*
- * x86 specific delta calculation.
+ * x86 specific calculation of nanoseconds for the current cycle count
  *
  * The regular implementation assumes that clocksource reads are globally
  * monotonic. The TSC can be slightly off across sockets which can cause
@@ -308,8 +308,8 @@ static inline bool arch_vdso_cycles_ok(u64 cycles)
  * jump.
  *
  * Therefore it needs to be verified that @cycles are greater than
- * @last. If not then use @last, which is the base time of the current
- * conversion period.
+ * @vd->cycles_last. If not then use @vd->cycles_last, which is the base
+ * time of the current conversion period.
  *
  * This variant also uses a custom mask because while the clocksource mask of
  * all the VDSO capable clocksources on x86 is U64_MAX, the above code uses
@@ -317,25 +317,37 @@ static inline bool arch_vdso_cycles_ok(u64 cycles)
  * declares everything with the MSB/Sign-bit set as invalid. Therefore the
  * effective mask is S64_MAX.
  */
-static __always_inline
-u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
+static __always_inline u64 vdso_calc_ns(const struct vdso_data *vd, u64 cycl=
es, u64 base)
 {
-	/*
-	 * Due to the MSB/Sign-bit being used as invalid marker (see
-	 * arch_vdso_cycles_valid() above), the effective mask is S64_MAX.
-	 */
-	u64 delta =3D (cycles - last) & S64_MAX;
+	u64 delta =3D cycles - vd->cycle_last;
=20
 	/*
-	 * Due to the above mentioned TSC wobbles, filter out negative motion.
-	 * Per the above masking, the effective sign bit is now bit 62.
+	 * Negative motion and deltas which can cause multiplication
+	 * overflow require special treatment. This check covers both as
+	 * negative motion is guaranteed to be greater than @vd::max_cycles
+	 * due to unsigned comparison.
+	 *
+	 * Due to the MSB/Sign-bit being used as invalid marker (see
+	 * arch_vdso_cycles_valid() above), the effective mask is S64_MAX,
+	 * but that case is also unlikely and will also take the unlikely path
+	 * here.
 	 */
-	if (unlikely(delta & (1ULL << 62)))
-		return 0;
+	if (unlikely(delta > vd->max_cycles)) {
+		/*
+		 * Due to the above mentioned TSC wobbles, filter out
+		 * negative motion.  Per the above masking, the effective
+		 * sign bit is now bit 62.
+		 */
+		if (delta & (1ULL << 62))
+			return base >> vd->shift;
+
+		/* Handle multiplication overflow gracefully */
+		return mul_u64_u32_add_u64_shr(delta & S64_MAX, vd->mult, base, vd->shift);
+	}
=20
-	return delta * mult;
+	return ((delta * vd->mult) + base) >> vd->shift;
 }
-#define vdso_calc_delta vdso_calc_delta
+#define vdso_calc_ns vdso_calc_ns
=20
 #endif /* !__ASSEMBLY__ */
=20
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_a=
rch_timer.c
index 8d4a52056684..5bb43cc1a8df 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -331,7 +331,7 @@ static u64 notrace hisi_161010101_read_cntvct_el0(void)
 	return __hisi_161010101_read_reg(cntvct_el0);
 }
=20
-static struct ate_acpi_oem_info hisi_161010101_oem_info[] =3D {
+static const struct ate_acpi_oem_info hisi_161010101_oem_info[] =3D {
 	/*
 	 * Note that trailing spaces are required to properly match
 	 * the OEM table information.
diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas=
-ostm.c
index 8da972dc1713..3fcbd02b2483 100644
--- a/drivers/clocksource/renesas-ostm.c
+++ b/drivers/clocksource/renesas-ostm.c
@@ -210,6 +210,7 @@ static int __init ostm_init(struct device_node *np)
 		pr_info("%pOF: used for clock events\n", np);
 	}
=20
+	of_node_set_flag(np, OF_POPULATED);
 	return 0;
=20
 err_cleanup:
@@ -224,7 +225,7 @@ static int __init ostm_init(struct device_node *np)
=20
 TIMER_OF_DECLARE(ostm, "renesas,ostm", ostm_init);
=20
-#ifdef CONFIG_ARCH_RZG2L
+#if defined(CONFIG_ARCH_RZG2L) || defined(CONFIG_ARCH_R9A09G057)
 static int __init ostm_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti=
-dm.c
index 56acf2617262..b7a34b1a975e 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -129,7 +129,6 @@ struct dmtimer {
 	void __iomem	*func_base;	/* function register base */
=20
 	atomic_t enabled;
-	unsigned long rate;
 	unsigned reserved:1;
 	unsigned posted:1;
 	unsigned omap1:1;
diff --git a/include/linux/math64.h b/include/linux/math64.h
index bf74478926d4..d34def7f9a8c 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -4,8 +4,8 @@
=20
 #include <linux/types.h>
 #include <linux/math.h>
-#include <vdso/math64.h>
 #include <asm/div64.h>
+#include <vdso/math64.h>
=20
 #if BITS_PER_LONG =3D=3D 64
=20
@@ -179,16 +179,12 @@ static __always_inline u64 mul_u64_u64_shr(u64 a, u64 m=
ul, unsigned int shift)
 #ifndef mul_u64_u32_shr
 static __always_inline u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned int shif=
t)
 {
-	u32 ah, al;
+	u32 ah =3D a >> 32, al =3D a;
 	u64 ret;
=20
-	al =3D a;
-	ah =3D a >> 32;
-
 	ret =3D mul_u32_u32(al, mul) >> shift;
 	if (ah)
 		ret +=3D mul_u32_u32(ah, mul) << (32 - shift);
-
 	return ret;
 }
 #endif /* mul_u64_u32_shr */
diff --git a/include/linux/timerqueue.h b/include/linux/timerqueue.h
index 62973f7d4610..d306d9dd2207 100644
--- a/include/linux/timerqueue.h
+++ b/include/linux/timerqueue.h
@@ -37,11 +37,6 @@ static inline bool timerqueue_node_queued(struct timerqueu=
e_node *node)
 	return !RB_EMPTY_NODE(&node->node);
 }
=20
-static inline bool timerqueue_node_expires(struct timerqueue_node *node)
-{
-	return node->expires;
-}
-
 static inline void timerqueue_init_head(struct timerqueue_head *head)
 {
 	head->rb_root =3D RB_ROOT_CACHED;
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index c71ddb6d4691..d04d394db064 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -61,6 +61,7 @@ struct vdso_timestamp {
  * @seq:		timebase sequence counter
  * @clock_mode:		clock mode
  * @cycle_last:		timebase at clocksource init
+ * @max_cycles:		maximum cycles which won't overflow 64bit multiplication
  * @mask:		clocksource mask
  * @mult:		clocksource multiplier
  * @shift:		clocksource shift
@@ -92,6 +93,9 @@ struct vdso_data {
=20
 	s32			clock_mode;
 	u64			cycle_last;
+#ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
+	u64			max_cycles;
+#endif
 	u64			mask;
 	u32			mult;
 	u32			shift;
diff --git a/include/vdso/math64.h b/include/vdso/math64.h
index 7da703ee5561..22ae212f8b28 100644
--- a/include/vdso/math64.h
+++ b/include/vdso/math64.h
@@ -21,4 +21,42 @@ __iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remaind=
er)
 	return ret;
 }
=20
+#if defined(CONFIG_ARCH_SUPPORTS_INT128) && defined(__SIZEOF_INT128__)
+
+#ifndef mul_u64_u32_add_u64_shr
+static __always_inline u64 mul_u64_u32_add_u64_shr(u64 a, u32 mul, u64 b, un=
signed int shift)
+{
+	return (u64)((((unsigned __int128)a * mul) + b) >> shift);
+}
+#endif /* mul_u64_u32_add_u64_shr */
+
+#else
+
+#ifndef mul_u64_u32_add_u64_shr
+#ifndef mul_u32_u32
+static inline u64 mul_u32_u32(u32 a, u32 b)
+{
+	return (u64)a * b;
+}
+#define mul_u32_u32 mul_u32_u32
+#endif
+static __always_inline u64 mul_u64_u32_add_u64_shr(u64 a, u32 mul, u64 b, un=
signed int shift)
+{
+	u32 ah =3D a >> 32, al =3D a;
+	bool ovf;
+	u64 ret;
+
+	ovf =3D __builtin_add_overflow(mul_u32_u32(al, mul), b, &ret);
+	ret >>=3D shift;
+	if (ovf && shift)
+		ret +=3D 1ULL << (64 - shift);
+	if (ah)
+		ret +=3D mul_u32_u32(ah, mul) << (32 - shift);
+
+	return ret;
+}
+#endif /* mul_u64_u32_add_u64_shr */
+
+#endif
+
 #endif /* __VDSO_MATH64_H */
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index fc3b1a06c981..8ebb6d5a106b 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -202,7 +202,7 @@ config HIGH_RES_TIMERS
 	  the size of the kernel image.
=20
 config CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
-	int "Clocksource watchdog maximum allowable skew (in =CE=BCs)"
+	int "Clocksource watchdog maximum allowable skew (in microseconds)"
 	depends on CLOCKSOURCE_WATCHDOG
 	range 50 1000
 	default 125
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index a7ca458cdd9c..60a6484831b1 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -677,7 +677,7 @@ static ssize_t current_device_show(struct device *dev,
 	raw_spin_lock_irq(&clockevents_lock);
 	td =3D tick_get_tick_dev(dev);
 	if (td && td->evtdev)
-		count =3D snprintf(buf, PAGE_SIZE, "%s\n", td->evtdev->name);
+		count =3D sysfs_emit(buf, "%s\n", td->evtdev->name);
 	raw_spin_unlock_irq(&clockevents_lock);
 	return count;
 }
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index e5b260aa0e02..d25ba49e313c 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -20,6 +20,16 @@
 #include "tick-internal.h"
 #include "timekeeping_internal.h"
=20
+static noinline u64 cycles_to_nsec_safe(struct clocksource *cs, u64 start, u=
64 end)
+{
+	u64 delta =3D clocksource_delta(end, start, cs->mask);
+
+	if (likely(delta < cs->max_cycles))
+		return clocksource_cyc2ns(delta, cs->mult, cs->shift);
+
+	return mul_u64_u32_shr(delta, cs->mult, cs->shift);
+}
+
 /**
  * clocks_calc_mult_shift - calculate mult/shift factors for scaled math of =
clocks
  * @mult:	pointer to mult variable
@@ -222,8 +232,8 @@ enum wd_read_status {
 static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csn=
ow, u64 *wdnow)
 {
 	unsigned int nretries, max_retries;
-	u64 wd_end, wd_end2, wd_delta;
 	int64_t wd_delay, wd_seq_delay;
+	u64 wd_end, wd_end2;
=20
 	max_retries =3D clocksource_get_max_watchdog_retry();
 	for (nretries =3D 0; nretries <=3D max_retries; nretries++) {
@@ -234,9 +244,7 @@ static enum wd_read_status cs_watchdog_read(struct clocks=
ource *cs, u64 *csnow,
 		wd_end2 =3D watchdog->read(watchdog);
 		local_irq_enable();
=20
-		wd_delta =3D clocksource_delta(wd_end, *wdnow, watchdog->mask);
-		wd_delay =3D clocksource_cyc2ns(wd_delta, watchdog->mult,
-					      watchdog->shift);
+		wd_delay =3D cycles_to_nsec_safe(watchdog, *wdnow, wd_end);
 		if (wd_delay <=3D WATCHDOG_MAX_SKEW) {
 			if (nretries > 1 || nretries >=3D max_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before succe=
ss\n",
@@ -254,8 +262,7 @@ static enum wd_read_status cs_watchdog_read(struct clocks=
ource *cs, u64 *csnow,
 		 * report system busy, reinit the watchdog and skip the current
 		 * watchdog test.
 		 */
-		wd_delta =3D clocksource_delta(wd_end2, wd_end, watchdog->mask);
-		wd_seq_delay =3D clocksource_cyc2ns(wd_delta, watchdog->mult, watchdog->sh=
ift);
+		wd_seq_delay =3D cycles_to_nsec_safe(watchdog, wd_end, wd_end2);
 		if (wd_seq_delay > WATCHDOG_MAX_SKEW/2)
 			goto skip_test;
 	}
@@ -366,8 +373,7 @@ void clocksource_verify_percpu(struct clocksource *cs)
 		delta =3D (csnow_end - csnow_mid) & cs->mask;
 		if (delta < 0)
 			cpumask_set_cpu(cpu, &cpus_ahead);
-		delta =3D clocksource_delta(csnow_end, csnow_begin, cs->mask);
-		cs_nsec =3D clocksource_cyc2ns(delta, cs->mult, cs->shift);
+		cs_nsec =3D cycles_to_nsec_safe(cs, csnow_begin, csnow_end);
 		if (cs_nsec > cs_nsec_max)
 			cs_nsec_max =3D cs_nsec;
 		if (cs_nsec < cs_nsec_min)
@@ -398,8 +404,8 @@ static inline void clocksource_reset_watchdog(void)
=20
 static void clocksource_watchdog(struct timer_list *unused)
 {
-	u64 csnow, wdnow, cslast, wdlast, delta;
 	int64_t wd_nsec, cs_nsec, interval;
+	u64 csnow, wdnow, cslast, wdlast;
 	int next_cpu, reset_pending;
 	struct clocksource *cs;
 	enum wd_read_status read_ret;
@@ -456,12 +462,8 @@ static void clocksource_watchdog(struct timer_list *unus=
ed)
 			continue;
 		}
=20
-		delta =3D clocksource_delta(wdnow, cs->wd_last, watchdog->mask);
-		wd_nsec =3D clocksource_cyc2ns(delta, watchdog->mult,
-					     watchdog->shift);
-
-		delta =3D clocksource_delta(csnow, cs->cs_last, cs->mask);
-		cs_nsec =3D clocksource_cyc2ns(delta, cs->mult, cs->shift);
+		wd_nsec =3D cycles_to_nsec_safe(watchdog, cs->wd_last, wdnow);
+		cs_nsec =3D cycles_to_nsec_safe(cs, cs->cs_last, csnow);
 		wdlast =3D cs->wd_last; /* save these in case we print them */
 		cslast =3D cs->cs_last;
 		cs->cs_last =3D csnow;
@@ -832,7 +834,7 @@ void clocksource_start_suspend_timing(struct clocksource =
*cs, u64 start_cycles)
  */
 u64 clocksource_stop_suspend_timing(struct clocksource *cs, u64 cycle_now)
 {
-	u64 now, delta, nsec =3D 0;
+	u64 now, nsec =3D 0;
=20
 	if (!suspend_clocksource)
 		return 0;
@@ -847,12 +849,8 @@ u64 clocksource_stop_suspend_timing(struct clocksource *=
cs, u64 cycle_now)
 	else
 		now =3D suspend_clocksource->read(suspend_clocksource);
=20
-	if (now > suspend_start) {
-		delta =3D clocksource_delta(now, suspend_start,
-					  suspend_clocksource->mask);
-		nsec =3D mul_u64_u32_shr(delta, suspend_clocksource->mult,
-				       suspend_clocksource->shift);
-	}
+	if (now > suspend_start)
+		nsec =3D cycles_to_nsec_safe(suspend_clocksource, suspend_start, now);
=20
 	/*
 	 * Disable the suspend timer to save power if current clocksource is
@@ -1336,7 +1334,7 @@ static ssize_t current_clocksource_show(struct device *=
dev,
 	ssize_t count =3D 0;
=20
 	mutex_lock(&clocksource_mutex);
-	count =3D snprintf(buf, PAGE_SIZE, "%s\n", curr_clocksource->name);
+	count =3D sysfs_emit(buf, "%s\n", curr_clocksource->name);
 	mutex_unlock(&clocksource_mutex);
=20
 	return count;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 70625dff62ce..492c14aac642 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -644,17 +644,12 @@ static inline ktime_t hrtimer_update_base(struct hrtime=
r_cpu_base *base)
 /*
  * Is the high resolution mode active ?
  */
-static inline int __hrtimer_hres_active(struct hrtimer_cpu_base *cpu_base)
+static inline int hrtimer_hres_active(struct hrtimer_cpu_base *cpu_base)
 {
 	return IS_ENABLED(CONFIG_HIGH_RES_TIMERS) ?
 		cpu_base->hres_active : 0;
 }
=20
-static inline int hrtimer_hres_active(void)
-{
-	return __hrtimer_hres_active(this_cpu_ptr(&hrtimer_bases));
-}
-
 static void __hrtimer_reprogram(struct hrtimer_cpu_base *cpu_base,
 				struct hrtimer *next_timer,
 				ktime_t expires_next)
@@ -678,7 +673,7 @@ static void __hrtimer_reprogram(struct hrtimer_cpu_base *=
cpu_base,
 	 * set. So we'd effectively block all timers until the T2 event
 	 * fires.
 	 */
-	if (!__hrtimer_hres_active(cpu_base) || cpu_base->hang_detected)
+	if (!hrtimer_hres_active(cpu_base) || cpu_base->hang_detected)
 		return;
=20
 	tick_program_event(expires_next, 1);
@@ -789,12 +784,12 @@ static void retrigger_next_event(void *arg)
 	 * function call will take care of the reprogramming in case the
 	 * CPU was in a NOHZ idle sleep.
 	 */
-	if (!__hrtimer_hres_active(base) && !tick_nohz_active)
+	if (!hrtimer_hres_active(base) && !tick_nohz_active)
 		return;
=20
 	raw_spin_lock(&base->lock);
 	hrtimer_update_base(base);
-	if (__hrtimer_hres_active(base))
+	if (hrtimer_hres_active(base))
 		hrtimer_force_reprogram(base, 0);
 	else
 		hrtimer_update_next_event(base);
@@ -951,7 +946,7 @@ void clock_was_set(unsigned int bases)
 	cpumask_var_t mask;
 	int cpu;
=20
-	if (!__hrtimer_hres_active(cpu_base) && !tick_nohz_active)
+	if (!hrtimer_hres_active(cpu_base) && !tick_nohz_active)
 		goto out_timerfd;
=20
 	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
@@ -1491,7 +1486,7 @@ u64 hrtimer_get_next_event(void)
=20
 	raw_spin_lock_irqsave(&cpu_base->lock, flags);
=20
-	if (!__hrtimer_hres_active(cpu_base))
+	if (!hrtimer_hres_active(cpu_base))
 		expires =3D __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_ALL);
=20
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
@@ -1514,7 +1509,7 @@ u64 hrtimer_next_event_without(const struct hrtimer *ex=
clude)
=20
 	raw_spin_lock_irqsave(&cpu_base->lock, flags);
=20
-	if (__hrtimer_hres_active(cpu_base)) {
+	if (hrtimer_hres_active(cpu_base)) {
 		unsigned int active;
=20
 		if (!cpu_base->softirq_activated) {
@@ -1875,25 +1870,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	tick_program_event(expires_next, 1);
 	pr_warn_once("hrtimer: interrupt took %llu ns\n", ktime_to_ns(delta));
 }
-
-/* called with interrupts disabled */
-static inline void __hrtimer_peek_ahead_timers(void)
-{
-	struct tick_device *td;
-
-	if (!hrtimer_hres_active())
-		return;
-
-	td =3D this_cpu_ptr(&tick_cpu_device);
-	if (td && td->evtdev)
-		hrtimer_interrupt(td->evtdev);
-}
-
-#else /* CONFIG_HIGH_RES_TIMERS */
-
-static inline void __hrtimer_peek_ahead_timers(void) { }
-
-#endif	/* !CONFIG_HIGH_RES_TIMERS */
+#endif /* !CONFIG_HIGH_RES_TIMERS */
=20
 /*
  * Called from run_local_timers in hardirq context every jiffy
@@ -1904,7 +1881,7 @@ void hrtimer_run_queues(void)
 	unsigned long flags;
 	ktime_t now;
=20
-	if (__hrtimer_hres_active(cpu_base))
+	if (hrtimer_hres_active(cpu_base))
 		return;
=20
 	/*
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index b58dffc58a8f..4e18db1819f8 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -237,7 +237,9 @@ static void timekeeping_check_update(struct timekeeper *t=
k, u64 offset)
 	}
 }
=20
-static inline u64 timekeeping_get_delta(const struct tk_read_base *tkr)
+static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u=
64 cycles);
+
+static inline u64 timekeeping_debug_get_ns(const struct tk_read_base *tkr)
 {
 	struct timekeeper *tk =3D &tk_core.timekeeper;
 	u64 now, last, mask, max, delta;
@@ -264,34 +266,23 @@ static inline u64 timekeeping_get_delta(const struct tk=
_read_base *tkr)
 	 * Try to catch underflows by checking if we are seeing small
 	 * mask-relative negative values.
 	 */
-	if (unlikely((~delta & mask) < (mask >> 3))) {
+	if (unlikely((~delta & mask) < (mask >> 3)))
 		tk->underflow_seen =3D 1;
-		delta =3D 0;
-	}
=20
-	/* Cap delta value to the max_cycles values to avoid mult overflows */
-	if (unlikely(delta > max)) {
+	/* Check for multiplication overflows */
+	if (unlikely(delta > max))
 		tk->overflow_seen =3D 1;
-		delta =3D tkr->clock->max_cycles;
-	}
=20
-	return delta;
+	/* timekeeping_cycles_to_ns() handles both under and overflow */
+	return timekeeping_cycles_to_ns(tkr, now);
 }
 #else
 static inline void timekeeping_check_update(struct timekeeper *tk, u64 offse=
t)
 {
 }
-static inline u64 timekeeping_get_delta(const struct tk_read_base *tkr)
+static inline u64 timekeeping_debug_get_ns(const struct tk_read_base *tkr)
 {
-	u64 cycle_now, delta;
-
-	/* read clocksource */
-	cycle_now =3D tk_clock_read(tkr);
-
-	/* calculate the delta since the last update_wall_time */
-	delta =3D clocksource_delta(cycle_now, tkr->cycle_last, tkr->mask);
-
-	return delta;
+	BUG();
 }
 #endif
=20
@@ -370,32 +361,46 @@ static void tk_setup_internals(struct timekeeper *tk, s=
truct clocksource *clock)
 }
=20
 /* Timekeeper helper functions. */
+static noinline u64 delta_to_ns_safe(const struct tk_read_base *tkr, u64 del=
ta)
+{
+	return mul_u64_u32_add_u64_shr(delta, tkr->mult, tkr->xtime_nsec, tkr->shif=
t);
+}
=20
-static inline u64 timekeeping_delta_to_ns(const struct tk_read_base *tkr, u6=
4 delta)
+static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u=
64 cycles)
 {
-	u64 nsec;
+	/* Calculate the delta since the last update_wall_time() */
+	u64 mask =3D tkr->mask, delta =3D (cycles - tkr->cycle_last) & mask;
=20
-	nsec =3D delta * tkr->mult + tkr->xtime_nsec;
-	nsec >>=3D tkr->shift;
+	/*
+	 * This detects both negative motion and the case where the delta
+	 * overflows the multiplication with tkr->mult.
+	 */
+	if (unlikely(delta > tkr->clock->max_cycles)) {
+		/*
+		 * Handle clocksource inconsistency between CPUs to prevent
+		 * time from going backwards by checking for the MSB of the
+		 * mask being set in the delta.
+		 */
+		if (delta & ~(mask >> 1))
+			return tkr->xtime_nsec >> tkr->shift;
+
+		return delta_to_ns_safe(tkr, delta);
+	}
=20
-	return nsec;
+	return ((delta * tkr->mult) + tkr->xtime_nsec) >> tkr->shift;
 }
=20
-static inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
+static __always_inline u64 __timekeeping_get_ns(const struct tk_read_base *t=
kr)
 {
-	u64 delta;
-
-	delta =3D timekeeping_get_delta(tkr);
-	return timekeeping_delta_to_ns(tkr, delta);
+	return timekeeping_cycles_to_ns(tkr, tk_clock_read(tkr));
 }
=20
-static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u=
64 cycles)
+static inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
 {
-	u64 delta;
+	if (IS_ENABLED(CONFIG_DEBUG_TIMEKEEPING))
+		return timekeeping_debug_get_ns(tkr);
=20
-	/* calculate the delta since the last update_wall_time */
-	delta =3D clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
-	return timekeeping_delta_to_ns(tkr, delta);
+	return __timekeeping_get_ns(tkr);
 }
=20
 /**
@@ -431,14 +436,6 @@ static void update_fast_timekeeper(const struct tk_read_=
base *tkr,
 	memcpy(base + 1, base, sizeof(*base));
 }
=20
-static __always_inline u64 fast_tk_get_delta_ns(struct tk_read_base *tkr)
-{
-	u64 delta, cycles =3D tk_clock_read(tkr);
-
-	delta =3D clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
-	return timekeeping_delta_to_ns(tkr, delta);
-}
-
 static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
 {
 	struct tk_read_base *tkr;
@@ -449,7 +446,7 @@ static __always_inline u64 __ktime_get_fast_ns(struct tk_=
fast *tkf)
 		seq =3D raw_read_seqcount_latch(&tkf->seq);
 		tkr =3D tkf->base + (seq & 0x01);
 		now =3D ktime_to_ns(tkr->base);
-		now +=3D fast_tk_get_delta_ns(tkr);
+		now +=3D __timekeeping_get_ns(tkr);
 	} while (raw_read_seqcount_latch_retry(&tkf->seq, seq));
=20
 	return now;
@@ -565,7 +562,7 @@ static __always_inline u64 __ktime_get_real_fast(struct t=
k_fast *tkf, u64 *mono)
 		tkr =3D tkf->base + (seq & 0x01);
 		basem =3D ktime_to_ns(tkr->base);
 		baser =3D ktime_to_ns(tkr->base_real);
-		delta =3D fast_tk_get_delta_ns(tkr);
+		delta =3D __timekeeping_get_ns(tkr);
 	} while (raw_read_seqcount_latch_retry(&tkf->seq, seq));
=20
 	if (mono)
@@ -800,10 +797,15 @@ static void timekeeping_forward_now(struct timekeeper *=
tk)
 	tk->tkr_mono.cycle_last =3D cycle_now;
 	tk->tkr_raw.cycle_last  =3D cycle_now;
=20
-	tk->tkr_mono.xtime_nsec +=3D delta * tk->tkr_mono.mult;
-	tk->tkr_raw.xtime_nsec +=3D delta * tk->tkr_raw.mult;
+	while (delta > 0) {
+		u64 max =3D tk->tkr_mono.clock->max_cycles;
+		u64 incr =3D delta < max ? delta : max;
=20
-	tk_normalize_xtime(tk);
+		tk->tkr_mono.xtime_nsec +=3D incr * tk->tkr_mono.mult;
+		tk->tkr_raw.xtime_nsec +=3D incr * tk->tkr_raw.mult;
+		tk_normalize_xtime(tk);
+		delta -=3D incr;
+	}
 }
=20
 /**
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index f0d5062d9cbc..9193d6133e5d 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -22,10 +22,16 @@ static inline void update_vdso_data(struct vdso_data *vda=
ta,
 	u64 nsec, sec;
=20
 	vdata[CS_HRES_COARSE].cycle_last	=3D tk->tkr_mono.cycle_last;
+#ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
+	vdata[CS_HRES_COARSE].max_cycles	=3D tk->tkr_mono.clock->max_cycles;
+#endif
 	vdata[CS_HRES_COARSE].mask		=3D tk->tkr_mono.mask;
 	vdata[CS_HRES_COARSE].mult		=3D tk->tkr_mono.mult;
 	vdata[CS_HRES_COARSE].shift		=3D tk->tkr_mono.shift;
 	vdata[CS_RAW].cycle_last		=3D tk->tkr_raw.cycle_last;
+#ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
+	vdata[CS_RAW].max_cycles		=3D tk->tkr_raw.clock->max_cycles;
+#endif
 	vdata[CS_RAW].mask			=3D tk->tkr_raw.mask;
 	vdata[CS_RAW].mult			=3D tk->tkr_raw.mult;
 	vdata[CS_RAW].shift			=3D tk->tkr_raw.shift;
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index d883ac299508..c46c2300517c 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -30,4 +30,11 @@ config GENERIC_VDSO_TIME_NS
 	  Selected by architectures which support time namespaces in the
 	  VDSO
=20
+config GENERIC_VDSO_OVERFLOW_PROTECT
+	bool
+	help
+	  Select to add multiplication overflow protection to the VDSO
+	  time getter functions for the price of an extra conditional
+	  in the hotpath.
+
 endif
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index ce2f69552003..899850bd6f0b 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -5,15 +5,23 @@
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
=20
-#ifndef vdso_calc_delta
-/*
- * Default implementation which works for all sane clocksources. That
- * obviously excludes x86/TSC.
- */
-static __always_inline
-u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
+#ifndef vdso_calc_ns
+
+#ifdef VDSO_DELTA_NOMASK
+# define VDSO_DELTA_MASK(vd)	ULLONG_MAX
+#else
+# define VDSO_DELTA_MASK(vd)	(vd->mask)
+#endif
+
+#ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
+static __always_inline bool vdso_delta_ok(const struct vdso_data *vd, u64 de=
lta)
+{
+	return delta < vd->max_cycles;
+}
+#else
+static __always_inline bool vdso_delta_ok(const struct vdso_data *vd, u64 de=
lta)
 {
-	return ((cycles - last) & mask) * mult;
+	return true;
 }
 #endif
=20
@@ -24,6 +32,21 @@ static __always_inline u64 vdso_shift_ns(u64 ns, u32 shift)
 }
 #endif
=20
+/*
+ * Default implementation which works for all sane clocksources. That
+ * obviously excludes x86/TSC.
+ */
+static __always_inline u64 vdso_calc_ns(const struct vdso_data *vd, u64 cycl=
es, u64 base)
+{
+	u64 delta =3D (cycles - vd->cycle_last) & VDSO_DELTA_MASK(vd);
+
+	if (likely(vdso_delta_ok(vd, delta)))
+		return vdso_shift_ns((delta * vd->mult) + base, vd->shift);
+
+	return mul_u64_u32_add_u64_shr(delta, vd->mult, base, vd->shift);
+}
+#endif /* vdso_calc_ns */
+
 #ifndef __arch_vdso_hres_capable
 static inline bool __arch_vdso_hres_capable(void)
 {
@@ -49,10 +72,10 @@ static inline bool vdso_cycles_ok(u64 cycles)
 static __always_inline int do_hres_timens(const struct vdso_data *vdns, cloc=
kid_t clk,
 					  struct __kernel_timespec *ts)
 {
-	const struct vdso_data *vd;
 	const struct timens_offset *offs =3D &vdns->offset[clk];
 	const struct vdso_timestamp *vdso_ts;
-	u64 cycles, last, ns;
+	const struct vdso_data *vd;
+	u64 cycles, ns;
 	u32 seq;
 	s64 sec;
=20
@@ -73,10 +96,7 @@ static __always_inline int do_hres_timens(const struct vds=
o_data *vdns, clockid_
 		cycles =3D __arch_get_hw_counter(vd->clock_mode, vd);
 		if (unlikely(!vdso_cycles_ok(cycles)))
 			return -1;
-		ns =3D vdso_ts->nsec;
-		last =3D vd->cycle_last;
-		ns +=3D vdso_calc_delta(cycles, last, vd->mask, vd->mult);
-		ns =3D vdso_shift_ns(ns, vd->shift);
+		ns =3D vdso_calc_ns(vd, cycles, vdso_ts->nsec);
 		sec =3D vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vd, seq)));
=20
@@ -111,7 +131,7 @@ static __always_inline int do_hres(const struct vdso_data=
 *vd, clockid_t clk,
 				   struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts =3D &vd->basetime[clk];
-	u64 cycles, last, sec, ns;
+	u64 cycles, sec, ns;
 	u32 seq;
=20
 	/* Allows to compile the high resolution parts out */
@@ -144,10 +164,7 @@ static __always_inline int do_hres(const struct vdso_dat=
a *vd, clockid_t clk,
 		cycles =3D __arch_get_hw_counter(vd->clock_mode, vd);
 		if (unlikely(!vdso_cycles_ok(cycles)))
 			return -1;
-		ns =3D vdso_ts->nsec;
-		last =3D vd->cycle_last;
-		ns +=3D vdso_calc_delta(cycles, last, vd->mask, vd->mult);
-		ns =3D vdso_shift_ns(ns, vd->shift);
+		ns =3D vdso_calc_ns(vd, cycles, vdso_ts->nsec);
 		sec =3D vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vd, seq)));
=20
diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 25a896eed468..e3bb5e89f88d 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -4,6 +4,12 @@
 //!
 //! This module contains the kernel APIs related to time and timers that
 //! have been ported or wrapped for usage by Rust code in the kernel.
+//!
+//! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
+//! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
+
+/// The number of nanoseconds per millisecond.
+pub const NSEC_PER_MSEC: i64 =3D bindings::NSEC_PER_MSEC as i64;
=20
 /// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
 pub type Jiffies =3D core::ffi::c_ulong;
@@ -18,3 +24,60 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
     // matter what the argument is.
     unsafe { bindings::__msecs_to_jiffies(msecs) }
 }
+
+/// A Rust wrapper around a `ktime_t`.
+#[repr(transparent)]
+#[derive(Copy, Clone)]
+pub struct Ktime {
+    inner: bindings::ktime_t,
+}
+
+impl Ktime {
+    /// Create a `Ktime` from a raw `ktime_t`.
+    #[inline]
+    pub fn from_raw(inner: bindings::ktime_t) -> Self {
+        Self { inner }
+    }
+
+    /// Get the current time using `CLOCK_MONOTONIC`.
+    #[inline]
+    pub fn ktime_get() -> Self {
+        // SAFETY: It is always safe to call `ktime_get` outside of NMI cont=
ext.
+        Self::from_raw(unsafe { bindings::ktime_get() })
+    }
+
+    /// Divide the number of nanoseconds by a compile-time constant.
+    #[inline]
+    fn divns_constant<const DIV: i64>(self) -> i64 {
+        self.to_ns() / DIV
+    }
+
+    /// Returns the number of nanoseconds.
+    #[inline]
+    pub fn to_ns(self) -> i64 {
+        self.inner
+    }
+
+    /// Returns the number of milliseconds.
+    #[inline]
+    pub fn to_ms(self) -> i64 {
+        self.divns_constant::<NSEC_PER_MSEC>()
+    }
+}
+
+/// Returns the number of milliseconds between two ktimes.
+#[inline]
+pub fn ktime_ms_delta(later: Ktime, earlier: Ktime) -> i64 {
+    (later - earlier).to_ms()
+}
+
+impl core::ops::Sub for Ktime {
+    type Output =3D Ktime;
+
+    #[inline]
+    fn sub(self, other: Ktime) -> Ktime {
+        Self {
+            inner: self.inner - other.inner,
+        }
+    }
+}


