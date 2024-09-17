Return-Path: <linux-kernel+bounces-331477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B403097AD61
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB44C1C214F4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91615185939;
	Tue, 17 Sep 2024 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ieGN2vK3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ePiXyj2o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2427615746B
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563257; cv=none; b=f2Wk7Kt+PsQ9ornBetu2pnwdmI+hCfUZdHIQXtk1QE1LGphLiA2k5BM/CuYzpsEXDOZfAFdff5TU4UJJrjGms/lD6QrLHHo+bxS0Iku9CJ8Wwe1WFmqF4Rs+2t0iorHxwgHSaiZPDkQtMphs9ons2TDa4707NL4yvfN8Y3pM2sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563257; c=relaxed/simple;
	bh=VXwNg6s6qMxTFMVqvodCBexsOsAAP49UF6THMwsq0GI=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=AM01s80CeqfrnZwmo1S/YtZgHQihgumFg7CI9qa02e7dQkUsRv3GlBX7Zk4yvzHC2JdK9D47CWco8ydf80argg3qO0oAt+KhZyD+mamswdDOXggfKq9ARM092XkTBQC2lO0TfEkvaDmIz5HjOL34GZyGrMCc0kF1Wy8qRQWiSbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ieGN2vK3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ePiXyj2o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726563244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rmXyATDs2thi3kGwllh2eOn55Xa6YeNXHucZqR8RAPc=;
	b=ieGN2vK3y2L+YM2sDD1H4zNISq6RfU9MPxuCcxqGcsRqDTRK/vLgaawzLEBhbcS//GVoiX
	exqQno2M0Ycwjvb1fPvy3BfVfxbl4W5lY3gRGk9Rej42MmK6rM2KXd5uPw/XOMrhlefncM
	6EcqaTPfdINeMy7ME/YKGB1Cp9Xbtb8gWoyaueZOxALffxgAF8WS7FVpKGUUG1NEoWlxX3
	AvkNC1mL9dGwGcnzBBkUbl8Y8f9r20RSRJAD3mS7Kgpc06JfLaqkF5ugJ+yKxG5UC0ekXm
	2PeTYVdFUn/fANhj+HwCYceGNNy6vo0sMpNgZn78gEnd4iBb/jN8UYYydcP7bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726563244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rmXyATDs2thi3kGwllh2eOn55Xa6YeNXHucZqR8RAPc=;
	b=ePiXyj2o4tmC29Am7eg9lIWkY3Y6T+qTy8GpyUGD4IqWOhr2pj7XCPBqSgmfU/bmwmWGuZ
	xP/l3oly0LTs74Dw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/apic for v6.12-rc1
Message-ID: <172656198112.2471820.6226852046770294674.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Sep 2024 10:54:04 +0200 (CEST)

Linus,

please pull the latest x86/apic branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2024-09=
-17

up to:  a1fab3e69d9d: x86/irq: Fix comment on IRQ vector layout

Updates for the x86 APIC code:

  - Handle an allocation failure in the IO/APIC code gracefully instead of
    crashing the machine.

  - Remove support for APIC local destination mode on 64bit

    Logical destination mode of the local APIC is used for systems with up
    to 8 CPUs. It has an advantage over physical destination mode as it
    allows to target multiple CPUs at once with IPIs. That advantage was
    definitely worth it when systems with up to 8 CPUs were state of the
    art for servers and workstations, but that's history.

    In the recent past there were quite some reports of new laptops failing
    to boot with logical destination mode, but they work fine with physical
    destination mode. That's not a suprise because physical destination
    mode is guaranteed to work as it's the only way to get a CPU up and
    running via the INIT/INIT/STARTUP sequence. Some of the affected
    systems were cured by BIOS updates, but not all OEMs provide them.

    As the number of CPUs keep increasing, logical destination mode becomes
    less used and the benefit for small systems, like laptops, is not
    really worth the trouble. So just remove logical destination mode
    support for 64bit and be done with it.

  - Code and comment cleanups in the APIC area.

Thanks,

	tglx

------------------>
Sohil Mehta (1):
      x86/irq: Fix comment on IRQ vector layout

Thomas Gleixner (16):
      x86/ioapic: Handle allocation failures gracefully
      x86/ioapic: Mark mp_alloc_timer_irq() __init
      x86/ioapic: Cleanup structs
      x86/ioapic: Use guard() for locking where applicable
      x86/apic: Provide apic_printk() helpers
      x86/apic: Cleanup apic_printk()s
      x86/ioapic: Cleanup apic_printk()s
      x86/ioapic: Cleanup guarded debug printk()s
      x86/mpparse: Cleanup apic_printk()s
      iommu/vt-d: Cleanup apic_printk()
      x86/ioapic: Move replace_pin_at_irq_node() to the call site
      x86/ioapic: Cleanup comments
      x86/ioapic: Cleanup bracket usage
      x86/ioapic: Cleanup line breaks
      x86/ioapic: Cleanup remaining coding style issues
      x86/apic: Remove logical destination mode for 64-bit

Yue Haibing (2):
      x86/apic: Remove unused inline function apic_set_eoi_cb()
      x86/apic: Remove unused extern declarations


 arch/x86/include/asm/apic.h         |  48 +--
 arch/x86/include/asm/irq_vectors.h  |   4 +-
 arch/x86/kernel/apic/apic.c         |  81 ++--
 arch/x86/kernel/apic/apic_flat_64.c | 119 +-----
 arch/x86/kernel/apic/io_apic.c      | 749 +++++++++++++++-------------------=
--
 arch/x86/kernel/mpparse.c           |  13 +-
 drivers/iommu/intel/irq_remapping.c |  11 +-
 7 files changed, 378 insertions(+), 647 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 9327eb00e96d..f21ff1932699 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -18,6 +18,11 @@
=20
 #define ARCH_APICTIMER_STOPS_ON_C3	1
=20
+/* Macros for apic_extnmi which controls external NMI masking */
+#define APIC_EXTNMI_BSP		0 /* Default */
+#define APIC_EXTNMI_ALL		1
+#define APIC_EXTNMI_NONE	2
+
 /*
  * Debugging macros
  */
@@ -25,22 +30,22 @@
 #define APIC_VERBOSE 1
 #define APIC_DEBUG   2
=20
-/* Macros for apic_extnmi which controls external NMI masking */
-#define APIC_EXTNMI_BSP		0 /* Default */
-#define APIC_EXTNMI_ALL		1
-#define APIC_EXTNMI_NONE	2
-
 /*
- * Define the default level of output to be very little
- * This can be turned up by using apic=3Dverbose for more
- * information and apic=3Ddebug for _lots_ of information.
- * apic_verbosity is defined in apic.c
+ * Define the default level of output to be very little This can be turned
+ * up by using apic=3Dverbose for more information and apic=3Ddebug for _lot=
s_
+ * of information.  apic_verbosity is defined in apic.c
  */
-#define apic_printk(v, s, a...) do {       \
-		if ((v) <=3D apic_verbosity) \
-			printk(s, ##a);    \
-	} while (0)
-
+#define apic_printk(v, s, a...)			\
+do {						\
+	if ((v) <=3D apic_verbosity)		\
+		printk(s, ##a);			\
+} while (0)
+
+#define apic_pr_verbose(s, a...)	apic_printk(APIC_VERBOSE, KERN_INFO s, ##a)
+#define apic_pr_debug(s, a...)		apic_printk(APIC_DEBUG, KERN_DEBUG s, ##a)
+#define apic_pr_debug_cont(s, a...)	apic_printk(APIC_DEBUG, KERN_CONT s, ##a)
+/* Unconditional debug prints for code which is guarded by apic_verbosity al=
ready */
+#define apic_dbg(s, a...)		printk(KERN_DEBUG s, ##a)
=20
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86_32)
 extern void x86_32_probe_apic(void);
@@ -122,8 +127,6 @@ static inline bool apic_is_x2apic_enabled(void)
=20
 extern void enable_IR_x2apic(void);
=20
-extern int get_physical_broadcast(void);
-
 extern int lapic_get_maxlvt(void);
 extern void clear_local_APIC(void);
 extern void disconnect_bsp_APIC(int virt_wire_setup);
@@ -345,20 +348,12 @@ extern struct apic *apic;
  * APIC drivers are probed based on how they are listed in the .apicdrivers
  * section. So the order is important and enforced by the ordering
  * of different apic driver files in the Makefile.
- *
- * For the files having two apic drivers, we use apic_drivers()
- * to enforce the order with in them.
  */
 #define apic_driver(sym)					\
 	static const struct apic *__apicdrivers_##sym __used		\
 	__aligned(sizeof(struct apic *))			\
 	__section(".apicdrivers") =3D { &sym }
=20
-#define apic_drivers(sym1, sym2)					\
-	static struct apic *__apicdrivers_##sym1##sym2[2] __used	\
-	__aligned(sizeof(struct apic *))				\
-	__section(".apicdrivers") =3D { &sym1, &sym2 }
-
 extern struct apic *__apicdrivers[], *__apicdrivers_end[];
=20
 /*
@@ -484,7 +479,6 @@ static inline u64 apic_icr_read(void) { return 0; }
 static inline void apic_icr_write(u32 low, u32 high) { }
 static inline void apic_wait_icr_idle(void) { }
 static inline u32 safe_apic_wait_icr_idle(void) { return 0; }
-static inline void apic_set_eoi_cb(void (*eoi)(void)) {}
 static inline void apic_native_eoi(void) { WARN_ON_ONCE(1); }
 static inline void apic_setup_apic_calls(void) { }
=20
@@ -512,8 +506,6 @@ static inline bool is_vector_pending(unsigned int vector)
 #define TRAMPOLINE_PHYS_LOW		0x467
 #define TRAMPOLINE_PHYS_HIGH		0x469
=20
-extern void generic_bigsmp_probe(void);
-
 #ifdef CONFIG_X86_LOCAL_APIC
=20
 #include <asm/smp.h>
@@ -536,8 +528,6 @@ static inline int default_acpi_madt_oem_check(char *a, ch=
ar *b) { return 0; }
 static inline void x86_64_probe_apic(void) { }
 #endif
=20
-extern int default_apic_id_valid(u32 apicid);
-
 extern u32 apic_default_calc_apicid(unsigned int cpu);
 extern u32 apic_flat_calc_apicid(unsigned int cpu);
=20
diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_ve=
ctors.h
index 13aea8fc3d45..47051871b436 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -18,8 +18,8 @@
  *  Vectors   0 ...  31 : system traps and exceptions - hardcoded events
  *  Vectors  32 ... 127 : device interrupts
  *  Vector  128         : legacy int80 syscall interface
- *  Vectors 129 ... LOCAL_TIMER_VECTOR-1
- *  Vectors LOCAL_TIMER_VECTOR ... 255 : special interrupts
+ *  Vectors 129 ... FIRST_SYSTEM_VECTOR-1 : device interrupts
+ *  Vectors FIRST_SYSTEM_VECTOR ... 255   : special interrupts
  *
  * 64-bit x86 has per CPU IDT tables, 32-bit has one shared IDT table.
  *
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 66fd4b2a37a3..1838a73b0950 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -677,7 +677,7 @@ calibrate_by_pmtimer(u32 deltapm, long *delta, long *delt=
atsc)
 	return -1;
 #endif
=20
-	apic_printk(APIC_VERBOSE, "... PM-Timer delta =3D %u\n", deltapm);
+	apic_pr_verbose("... PM-Timer delta =3D %u\n", deltapm);
=20
 	/* Check, if the PM timer is available */
 	if (!deltapm)
@@ -687,14 +687,14 @@ calibrate_by_pmtimer(u32 deltapm, long *delta, long *de=
ltatsc)
=20
 	if (deltapm > (pm_100ms - pm_thresh) &&
 	    deltapm < (pm_100ms + pm_thresh)) {
-		apic_printk(APIC_VERBOSE, "... PM-Timer result ok\n");
+		apic_pr_verbose("... PM-Timer result ok\n");
 		return 0;
 	}
=20
 	res =3D (((u64)deltapm) *  mult) >> 22;
 	do_div(res, 1000000);
-	pr_warn("APIC calibration not consistent "
-		"with PM-Timer: %ldms instead of 100ms\n", (long)res);
+	pr_warn("APIC calibration not consistent with PM-Timer: %ldms instead of 10=
0ms\n",
+		(long)res);
=20
 	/* Correct the lapic counter value */
 	res =3D (((u64)(*delta)) * pm_100ms);
@@ -707,9 +707,8 @@ calibrate_by_pmtimer(u32 deltapm, long *delta, long *delt=
atsc)
 	if (boot_cpu_has(X86_FEATURE_TSC)) {
 		res =3D (((u64)(*deltatsc)) * pm_100ms);
 		do_div(res, deltapm);
-		apic_printk(APIC_VERBOSE, "TSC delta adjusted to "
-					  "PM-Timer: %lu (%ld)\n",
-					(unsigned long)res, *deltatsc);
+		apic_pr_verbose("TSC delta adjusted to PM-Timer: %lu (%ld)\n",
+				(unsigned long)res, *deltatsc);
 		*deltatsc =3D (long)res;
 	}
=20
@@ -792,8 +791,7 @@ static int __init calibrate_APIC_clock(void)
 	 * in the clockevent structure and return.
 	 */
 	if (!lapic_init_clockevent()) {
-		apic_printk(APIC_VERBOSE, "lapic timer already calibrated %d\n",
-			    lapic_timer_period);
+		apic_pr_verbose("lapic timer already calibrated %d\n", lapic_timer_period);
 		/*
 		 * Direct calibration methods must have an always running
 		 * local APIC timer, no need for broadcast timer.
@@ -802,8 +800,7 @@ static int __init calibrate_APIC_clock(void)
 		return 0;
 	}
=20
-	apic_printk(APIC_VERBOSE, "Using local APIC timer interrupts.\n"
-		    "calibrating APIC timer ...\n");
+	apic_pr_verbose("Using local APIC timer interrupts. Calibrating APIC timer =
...\n");
=20
 	/*
 	 * There are platforms w/o global clockevent devices. Instead of
@@ -866,7 +863,7 @@ static int __init calibrate_APIC_clock(void)
=20
 	/* Build delta t1-t2 as apic timer counts down */
 	delta =3D lapic_cal_t1 - lapic_cal_t2;
-	apic_printk(APIC_VERBOSE, "... lapic delta =3D %ld\n", delta);
+	apic_pr_verbose("... lapic delta =3D %ld\n", delta);
=20
 	deltatsc =3D (long)(lapic_cal_tsc2 - lapic_cal_tsc1);
=20
@@ -877,22 +874,19 @@ static int __init calibrate_APIC_clock(void)
 	lapic_timer_period =3D (delta * APIC_DIVISOR) / LAPIC_CAL_LOOPS;
 	lapic_init_clockevent();
=20
-	apic_printk(APIC_VERBOSE, "..... delta %ld\n", delta);
-	apic_printk(APIC_VERBOSE, "..... mult: %u\n", lapic_clockevent.mult);
-	apic_printk(APIC_VERBOSE, "..... calibration result: %u\n",
-		    lapic_timer_period);
+	apic_pr_verbose("..... delta %ld\n", delta);
+	apic_pr_verbose("..... mult: %u\n", lapic_clockevent.mult);
+	apic_pr_verbose("..... calibration result: %u\n", lapic_timer_period);
=20
 	if (boot_cpu_has(X86_FEATURE_TSC)) {
-		apic_printk(APIC_VERBOSE, "..... CPU clock speed is "
-			    "%ld.%04ld MHz.\n",
-			    (deltatsc / LAPIC_CAL_LOOPS) / (1000000 / HZ),
-			    (deltatsc / LAPIC_CAL_LOOPS) % (1000000 / HZ));
+		apic_pr_verbose("..... CPU clock speed is %ld.%04ld MHz.\n",
+				(deltatsc / LAPIC_CAL_LOOPS) / (1000000 / HZ),
+				(deltatsc / LAPIC_CAL_LOOPS) % (1000000 / HZ));
 	}
=20
-	apic_printk(APIC_VERBOSE, "..... host bus clock speed is "
-		    "%u.%04u MHz.\n",
-		    lapic_timer_period / (1000000 / HZ),
-		    lapic_timer_period % (1000000 / HZ));
+	apic_pr_verbose("..... host bus clock speed is %u.%04u MHz.\n",
+			lapic_timer_period / (1000000 / HZ),
+			lapic_timer_period % (1000000 / HZ));
=20
 	/*
 	 * Do a sanity check on the APIC calibration result
@@ -911,7 +905,7 @@ static int __init calibrate_APIC_clock(void)
 	 * available.
 	 */
 	if (!pm_referenced && global_clock_event) {
-		apic_printk(APIC_VERBOSE, "... verify APIC timer\n");
+		apic_pr_verbose("... verify APIC timer\n");
=20
 		/*
 		 * Setup the apic timer manually
@@ -932,11 +926,11 @@ static int __init calibrate_APIC_clock(void)
=20
 		/* Jiffies delta */
 		deltaj =3D lapic_cal_j2 - lapic_cal_j1;
-		apic_printk(APIC_VERBOSE, "... jiffies delta =3D %lu\n", deltaj);
+		apic_pr_verbose("... jiffies delta =3D %lu\n", deltaj);
=20
 		/* Check, if the jiffies result is consistent */
 		if (deltaj >=3D LAPIC_CAL_LOOPS-2 && deltaj <=3D LAPIC_CAL_LOOPS+2)
-			apic_printk(APIC_VERBOSE, "... jiffies result ok\n");
+			apic_pr_verbose("... jiffies result ok\n");
 		else
 			levt->features |=3D CLOCK_EVT_FEAT_DUMMY;
 	}
@@ -1221,9 +1215,8 @@ void __init sync_Arb_IDs(void)
 	 */
 	apic_wait_icr_idle();
=20
-	apic_printk(APIC_DEBUG, "Synchronizing Arb IDs.\n");
-	apic_write(APIC_ICR, APIC_DEST_ALLINC |
-			APIC_INT_LEVELTRIG | APIC_DM_INIT);
+	apic_pr_debug("Synchronizing Arb IDs.\n");
+	apic_write(APIC_ICR, APIC_DEST_ALLINC | APIC_INT_LEVELTRIG | APIC_DM_INIT);
 }
=20
 enum apic_intr_mode_id apic_intr_mode __ro_after_init;
@@ -1409,10 +1402,10 @@ static void lapic_setup_esr(void)
 	if (maxlvt > 3)
 		apic_write(APIC_ESR, 0);
 	value =3D apic_read(APIC_ESR);
-	if (value !=3D oldvalue)
-		apic_printk(APIC_VERBOSE, "ESR value before enabling "
-			"vector: 0x%08x  after: 0x%08x\n",
-			oldvalue, value);
+	if (value !=3D oldvalue) {
+		apic_pr_verbose("ESR value before enabling vector: 0x%08x  after: 0x%08x\n=
",
+				oldvalue, value);
+	}
 }
=20
 #define APIC_IR_REGS		APIC_ISR_NR
@@ -1599,10 +1592,10 @@ static void setup_local_APIC(void)
 	value =3D apic_read(APIC_LVT0) & APIC_LVT_MASKED;
 	if (!cpu && (pic_mode || !value || ioapic_is_disabled)) {
 		value =3D APIC_DM_EXTINT;
-		apic_printk(APIC_VERBOSE, "enabled ExtINT on CPU#%d\n", cpu);
+		apic_pr_verbose("Enabled ExtINT on CPU#%d\n", cpu);
 	} else {
 		value =3D APIC_DM_EXTINT | APIC_LVT_MASKED;
-		apic_printk(APIC_VERBOSE, "masked ExtINT on CPU#%d\n", cpu);
+		apic_pr_verbose("Masked ExtINT on CPU#%d\n", cpu);
 	}
 	apic_write(APIC_LVT0, value);
=20
@@ -2066,8 +2059,7 @@ static __init void apic_set_fixmap(bool read_apic)
 {
 	set_fixmap_nocache(FIX_APIC_BASE, mp_lapic_addr);
 	apic_mmio_base =3D APIC_BASE;
-	apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n",
-		    apic_mmio_base, mp_lapic_addr);
+	apic_pr_verbose("Mapped APIC to %16lx (%16lx)\n", apic_mmio_base, mp_lapic_=
addr);
 	if (read_apic)
 		apic_read_boot_cpu_id(false);
 }
@@ -2170,18 +2162,17 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_error_interrupt)
 	apic_eoi();
 	atomic_inc(&irq_err_count);
=20
-	apic_printk(APIC_DEBUG, KERN_DEBUG "APIC error on CPU%d: %02x",
-		    smp_processor_id(), v);
+	apic_pr_debug("APIC error on CPU%d: %02x", smp_processor_id(), v);
=20
 	v &=3D 0xff;
 	while (v) {
 		if (v & 0x1)
-			apic_printk(APIC_DEBUG, KERN_CONT " : %s", error_interrupt_reason[i]);
+			apic_pr_debug_cont(" : %s", error_interrupt_reason[i]);
 		i++;
 		v >>=3D 1;
 	}
=20
-	apic_printk(APIC_DEBUG, KERN_CONT "\n");
+	apic_pr_debug_cont("\n");
=20
 	trace_error_apic_exit(ERROR_APIC_VECTOR);
 }
@@ -2201,8 +2192,7 @@ static void __init connect_bsp_APIC(void)
 		 * PIC mode, enable APIC mode in the IMCR, i.e.  connect BSP's
 		 * local APIC to INT and NMI lines.
 		 */
-		apic_printk(APIC_VERBOSE, "leaving PIC mode, "
-				"enabling APIC mode.\n");
+		apic_pr_verbose("Leaving PIC mode, enabling APIC mode.\n");
 		imcr_pic_to_apic();
 	}
 #endif
@@ -2227,8 +2217,7 @@ void disconnect_bsp_APIC(int virt_wire_setup)
 		 * IPIs, won't work beyond this point!  The only exception are
 		 * INIT IPIs.
 		 */
-		apic_printk(APIC_VERBOSE, "disabling APIC mode, "
-				"entering PIC mode.\n");
+		apic_pr_verbose("Disabling APIC mode, entering PIC mode.\n");
 		imcr_apic_to_pic();
 		return;
 	}
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_=
flat_64.c
index f37ad3392fec..e0308d8c4e6c 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -8,129 +8,25 @@
  * Martin Bligh, Andi Kleen, James Bottomley, John Stultz, and
  * James Cleverdon.
  */
-#include <linux/cpumask.h>
 #include <linux/export.h>
-#include <linux/acpi.h>
=20
-#include <asm/jailhouse_para.h>
 #include <asm/apic.h>
=20
 #include "local.h"
=20
-static struct apic apic_physflat;
-static struct apic apic_flat;
-
-struct apic *apic __ro_after_init =3D &apic_flat;
-EXPORT_SYMBOL_GPL(apic);
-
-static int flat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
-{
-	return 1;
-}
-
-static void _flat_send_IPI_mask(unsigned long mask, int vector)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__default_send_IPI_dest_field(mask, vector, APIC_DEST_LOGICAL);
-	local_irq_restore(flags);
-}
-
-static void flat_send_IPI_mask(const struct cpumask *cpumask, int vector)
-{
-	unsigned long mask =3D cpumask_bits(cpumask)[0];
-
-	_flat_send_IPI_mask(mask, vector);
-}
-
-static void
-flat_send_IPI_mask_allbutself(const struct cpumask *cpumask, int vector)
-{
-	unsigned long mask =3D cpumask_bits(cpumask)[0];
-	int cpu =3D smp_processor_id();
-
-	if (cpu < BITS_PER_LONG)
-		__clear_bit(cpu, &mask);
-
-	_flat_send_IPI_mask(mask, vector);
-}
-
-static u32 flat_get_apic_id(u32 x)
+static u32 physflat_get_apic_id(u32 x)
 {
 	return (x >> 24) & 0xFF;
 }
=20
-static int flat_probe(void)
+static int physflat_probe(void)
 {
 	return 1;
 }
=20
-static struct apic apic_flat __ro_after_init =3D {
-	.name				=3D "flat",
-	.probe				=3D flat_probe,
-	.acpi_madt_oem_check		=3D flat_acpi_madt_oem_check,
-
-	.dest_mode_logical		=3D true,
-
-	.disable_esr			=3D 0,
-
-	.init_apic_ldr			=3D default_init_apic_ldr,
-	.cpu_present_to_apicid		=3D default_cpu_present_to_apicid,
-
-	.max_apic_id			=3D 0xFE,
-	.get_apic_id			=3D flat_get_apic_id,
-
-	.calc_dest_apicid		=3D apic_flat_calc_apicid,
-
-	.send_IPI			=3D default_send_IPI_single,
-	.send_IPI_mask			=3D flat_send_IPI_mask,
-	.send_IPI_mask_allbutself	=3D flat_send_IPI_mask_allbutself,
-	.send_IPI_allbutself		=3D default_send_IPI_allbutself,
-	.send_IPI_all			=3D default_send_IPI_all,
-	.send_IPI_self			=3D default_send_IPI_self,
-	.nmi_to_offline_cpu		=3D true,
-
-	.read				=3D native_apic_mem_read,
-	.write				=3D native_apic_mem_write,
-	.eoi				=3D native_apic_mem_eoi,
-	.icr_read			=3D native_apic_icr_read,
-	.icr_write			=3D native_apic_icr_write,
-	.wait_icr_idle			=3D apic_mem_wait_icr_idle,
-	.safe_wait_icr_idle		=3D apic_mem_wait_icr_idle_timeout,
-};
-
-/*
- * Physflat mode is used when there are more than 8 CPUs on a system.
- * We cannot use logical delivery in this case because the mask
- * overflows, so use physical mode.
- */
 static int physflat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
-#ifdef CONFIG_ACPI
-	/*
-	 * Quirk: some x86_64 machines can only use physical APIC mode
-	 * regardless of how many processors are present (x86_64 ES7000
-	 * is an example).
-	 */
-	if (acpi_gbl_FADT.header.revision >=3D FADT2_REVISION_ID &&
-		(acpi_gbl_FADT.flags & ACPI_FADT_APIC_PHYSICAL)) {
-		printk(KERN_DEBUG "system APIC only can use physical flat");
-		return 1;
-	}
-
-	if (!strncmp(oem_id, "IBM", 3) && !strncmp(oem_table_id, "EXA", 3)) {
-		printk(KERN_DEBUG "IBM Summit detected, will use apic physical");
-		return 1;
-	}
-#endif
-
-	return 0;
-}
-
-static int physflat_probe(void)
-{
-	return apic =3D=3D &apic_physflat || num_possible_cpus() > 8 || jailhouse_p=
aravirt();
+	return 1;
 }
=20
 static struct apic apic_physflat __ro_after_init =3D {
@@ -146,7 +42,7 @@ static struct apic apic_physflat __ro_after_init =3D {
 	.cpu_present_to_apicid		=3D default_cpu_present_to_apicid,
=20
 	.max_apic_id			=3D 0xFE,
-	.get_apic_id			=3D flat_get_apic_id,
+	.get_apic_id			=3D physflat_get_apic_id,
=20
 	.calc_dest_apicid		=3D apic_default_calc_apicid,
=20
@@ -166,8 +62,7 @@ static struct apic apic_physflat __ro_after_init =3D {
 	.wait_icr_idle			=3D apic_mem_wait_icr_idle,
 	.safe_wait_icr_idle		=3D apic_mem_wait_icr_idle_timeout,
 };
+apic_driver(apic_physflat);
=20
-/*
- * We need to check for physflat first, so this order is important.
- */
-apic_drivers(apic_physflat, apic_flat);
+struct apic *apic __ro_after_init =3D &apic_physflat;
+EXPORT_SYMBOL_GPL(apic);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 477b740b2f26..1029ea4ac8ba 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -86,8 +86,8 @@ static unsigned int ioapic_dynirq_base;
 static int ioapic_initialized;
=20
 struct irq_pin_list {
-	struct list_head list;
-	int apic, pin;
+	struct list_head	list;
+	int			apic, pin;
 };
=20
 struct mp_chip_data {
@@ -96,7 +96,7 @@ struct mp_chip_data {
 	bool				is_level;
 	bool				active_low;
 	bool				isa_irq;
-	u32 count;
+	u32				count;
 };
=20
 struct mp_ioapic_gsi {
@@ -105,21 +105,17 @@ struct mp_ioapic_gsi {
 };
=20
 static struct ioapic {
-	/*
-	 * # of IRQ routing registers
-	 */
-	int nr_registers;
-	/*
-	 * Saved state during suspend/resume, or while enabling intr-remap.
-	 */
-	struct IO_APIC_route_entry *saved_registers;
+	/* # of IRQ routing registers */
+	int				nr_registers;
+	/* Saved state during suspend/resume, or while enabling intr-remap. */
+	struct IO_APIC_route_entry	*saved_registers;
 	/* I/O APIC config */
-	struct mpc_ioapic mp_config;
+	struct mpc_ioapic		mp_config;
 	/* IO APIC gsi routing info */
-	struct mp_ioapic_gsi  gsi_config;
-	struct ioapic_domain_cfg irqdomain_cfg;
-	struct irq_domain *irqdomain;
-	struct resource *iomem_res;
+	struct mp_ioapic_gsi		gsi_config;
+	struct ioapic_domain_cfg	irqdomain_cfg;
+	struct irq_domain		*irqdomain;
+	struct resource			*iomem_res;
 } ioapics[MAX_IO_APICS];
=20
 #define mpc_ioapic_ver(ioapic_idx)	ioapics[ioapic_idx].mp_config.apicver
@@ -205,10 +201,9 @@ void mp_save_irq(struct mpc_intsrc *m)
 {
 	int i;
=20
-	apic_printk(APIC_VERBOSE, "Int: type %d, pol %d, trig %d, bus %02x,"
-		" IRQ %02x, APIC ID %x, APIC INT %02x\n",
-		m->irqtype, m->irqflag & 3, (m->irqflag >> 2) & 3, m->srcbus,
-		m->srcbusirq, m->dstapic, m->dstirq);
+	apic_pr_verbose("Int: type %d, pol %d, trig %d, bus %02x, IRQ %02x, APIC ID=
 %x, APIC INT %02x\n",
+			m->irqtype, m->irqflag & 3, (m->irqflag >> 2) & 3, m->srcbus,
+			m->srcbusirq, m->dstapic, m->dstirq);
=20
 	for (i =3D 0; i < mp_irq_entries; i++) {
 		if (!memcmp(&mp_irqs[i], m, sizeof(*m)))
@@ -269,12 +264,14 @@ static __attribute_const__ struct io_apic __iomem *io_a=
pic_base(int idx)
 static inline void io_apic_eoi(unsigned int apic, unsigned int vector)
 {
 	struct io_apic __iomem *io_apic =3D io_apic_base(apic);
+
 	writel(vector, &io_apic->eoi);
 }
=20
 unsigned int native_io_apic_read(unsigned int apic, unsigned int reg)
 {
 	struct io_apic __iomem *io_apic =3D io_apic_base(apic);
+
 	writel(reg, &io_apic->index);
 	return readl(&io_apic->data);
 }
@@ -300,14 +297,8 @@ static struct IO_APIC_route_entry __ioapic_read_entry(in=
t apic, int pin)
=20
 static struct IO_APIC_route_entry ioapic_read_entry(int apic, int pin)
 {
-	struct IO_APIC_route_entry entry;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
-	entry =3D __ioapic_read_entry(apic, pin);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
-
-	return entry;
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
+	return __ioapic_read_entry(apic, pin);
 }
=20
 /*
@@ -324,11 +315,8 @@ static void __ioapic_write_entry(int apic, int pin, stru=
ct IO_APIC_route_entry e
=20
 static void ioapic_write_entry(int apic, int pin, struct IO_APIC_route_entry=
 e)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	__ioapic_write_entry(apic, pin, e);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 }
=20
 /*
@@ -339,12 +327,10 @@ static void ioapic_write_entry(int apic, int pin, struc=
t IO_APIC_route_entry e)
 static void ioapic_mask_entry(int apic, int pin)
 {
 	struct IO_APIC_route_entry e =3D { .masked =3D true };
-	unsigned long flags;
=20
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	io_apic_write(apic, 0x10 + 2*pin, e.w1);
 	io_apic_write(apic, 0x11 + 2*pin, e.w2);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 }
=20
 /*
@@ -352,68 +338,39 @@ static void ioapic_mask_entry(int apic, int pin)
  * shared ISA-space IRQs, so we have to support them. We are super
  * fast in the common case, and fast for shared ISA-space IRQs.
  */
-static int __add_pin_to_irq_node(struct mp_chip_data *data,
-				 int node, int apic, int pin)
+static bool add_pin_to_irq_node(struct mp_chip_data *data, int node, int api=
c, int pin)
 {
 	struct irq_pin_list *entry;
=20
-	/* don't allow duplicates */
-	for_each_irq_pin(entry, data->irq_2_pin)
+	/* Don't allow duplicates */
+	for_each_irq_pin(entry, data->irq_2_pin) {
 		if (entry->apic =3D=3D apic && entry->pin =3D=3D pin)
-			return 0;
+			return true;
+	}
=20
 	entry =3D kzalloc_node(sizeof(struct irq_pin_list), GFP_ATOMIC, node);
 	if (!entry) {
-		pr_err("can not alloc irq_pin_list (%d,%d,%d)\n",
-		       node, apic, pin);
-		return -ENOMEM;
+		pr_err("Cannot allocate irq_pin_list (%d,%d,%d)\n", node, apic, pin);
+		return false;
 	}
+
 	entry->apic =3D apic;
 	entry->pin =3D pin;
 	list_add_tail(&entry->list, &data->irq_2_pin);
-
-	return 0;
+	return true;
 }
=20
 static void __remove_pin_from_irq(struct mp_chip_data *data, int apic, int p=
in)
 {
 	struct irq_pin_list *tmp, *entry;
=20
-	list_for_each_entry_safe(entry, tmp, &data->irq_2_pin, list)
+	list_for_each_entry_safe(entry, tmp, &data->irq_2_pin, list) {
 		if (entry->apic =3D=3D apic && entry->pin =3D=3D pin) {
 			list_del(&entry->list);
 			kfree(entry);
 			return;
 		}
-}
-
-static void add_pin_to_irq_node(struct mp_chip_data *data,
-				int node, int apic, int pin)
-{
-	if (__add_pin_to_irq_node(data, node, apic, pin))
-		panic("IO-APIC: failed to add irq-pin. Can not proceed\n");
-}
-
-/*
- * Reroute an IRQ to a different pin.
- */
-static void __init replace_pin_at_irq_node(struct mp_chip_data *data, int no=
de,
-					   int oldapic, int oldpin,
-					   int newapic, int newpin)
-{
-	struct irq_pin_list *entry;
-
-	for_each_irq_pin(entry, data->irq_2_pin) {
-		if (entry->apic =3D=3D oldapic && entry->pin =3D=3D oldpin) {
-			entry->apic =3D newapic;
-			entry->pin =3D newpin;
-			/* every one is different, right? */
-			return;
-		}
 	}
-
-	/* old apic/pin didn't exist, so just add new ones */
-	add_pin_to_irq_node(data, node, newapic, newpin);
 }
=20
 static void io_apic_modify_irq(struct mp_chip_data *data, bool masked,
@@ -430,12 +387,12 @@ static void io_apic_modify_irq(struct mp_chip_data *dat=
a, bool masked,
 	}
 }
=20
+/*
+ * Synchronize the IO-APIC and the CPU by doing a dummy read from the
+ * IO-APIC
+ */
 static void io_apic_sync(struct irq_pin_list *entry)
 {
-	/*
-	 * Synchronize the IO-APIC and the CPU by doing
-	 * a dummy read from the IO-APIC
-	 */
 	struct io_apic __iomem *io_apic;
=20
 	io_apic =3D io_apic_base(entry->apic);
@@ -445,11 +402,9 @@ static void io_apic_sync(struct irq_pin_list *entry)
 static void mask_ioapic_irq(struct irq_data *irq_data)
 {
 	struct mp_chip_data *data =3D irq_data->chip_data;
-	unsigned long flags;
=20
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	io_apic_modify_irq(data, true, &io_apic_sync);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 }
=20
 static void __unmask_ioapic(struct mp_chip_data *data)
@@ -460,11 +415,9 @@ static void __unmask_ioapic(struct mp_chip_data *data)
 static void unmask_ioapic_irq(struct irq_data *irq_data)
 {
 	struct mp_chip_data *data =3D irq_data->chip_data;
-	unsigned long flags;
=20
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	__unmask_ioapic(data);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 }
=20
 /*
@@ -492,30 +445,24 @@ static void __eoi_ioapic_pin(int apic, int pin, int vec=
tor)
=20
 		entry =3D entry1 =3D __ioapic_read_entry(apic, pin);
=20
-		/*
-		 * Mask the entry and change the trigger mode to edge.
-		 */
+		/* Mask the entry and change the trigger mode to edge. */
 		entry1.masked =3D true;
 		entry1.is_level =3D false;
=20
 		__ioapic_write_entry(apic, pin, entry1);
=20
-		/*
-		 * Restore the previous level triggered entry.
-		 */
+		/* Restore the previous level triggered entry. */
 		__ioapic_write_entry(apic, pin, entry);
 	}
 }
=20
 static void eoi_ioapic_pin(int vector, struct mp_chip_data *data)
 {
-	unsigned long flags;
 	struct irq_pin_list *entry;
=20
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	for_each_irq_pin(entry, data->irq_2_pin)
 		__eoi_ioapic_pin(entry->apic, entry->pin, vector);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 }
=20
 static void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
@@ -538,8 +485,6 @@ static void clear_IO_APIC_pin(unsigned int apic, unsigned=
 int pin)
 	}
=20
 	if (entry.irr) {
-		unsigned long flags;
-
 		/*
 		 * Make sure the trigger mode is set to level. Explicit EOI
 		 * doesn't clear the remote-IRR if the trigger mode is not
@@ -549,9 +494,8 @@ static void clear_IO_APIC_pin(unsigned int apic, unsigned=
 int pin)
 			entry.is_level =3D true;
 			ioapic_write_entry(apic, pin, entry);
 		}
-		raw_spin_lock_irqsave(&ioapic_lock, flags);
+		guard(raw_spinlock_irqsave)(&ioapic_lock);
 		__eoi_ioapic_pin(apic, pin, entry.vector);
-		raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 	}
=20
 	/*
@@ -586,28 +530,23 @@ static int pirq_entries[MAX_PIRQS] =3D {
=20
 static int __init ioapic_pirq_setup(char *str)
 {
-	int i, max;
-	int ints[MAX_PIRQS+1];
+	int i, max, ints[MAX_PIRQS+1];
=20
 	get_options(str, ARRAY_SIZE(ints), ints);
=20
-	apic_printk(APIC_VERBOSE, KERN_INFO
-			"PIRQ redirection, working around broken MP-BIOS.\n");
+	apic_pr_verbose("PIRQ redirection, working around broken MP-BIOS.\n");
+
 	max =3D MAX_PIRQS;
 	if (ints[0] < MAX_PIRQS)
 		max =3D ints[0];
=20
 	for (i =3D 0; i < max; i++) {
-		apic_printk(APIC_VERBOSE, KERN_DEBUG
-				"... PIRQ%d -> IRQ %d\n", i, ints[i+1]);
-		/*
-		 * PIRQs are mapped upside down, usually.
-		 */
+		apic_pr_verbose("... PIRQ%d -> IRQ %d\n", i, ints[i + 1]);
+		/* PIRQs are mapped upside down, usually */
 		pirq_entries[MAX_PIRQS-i-1] =3D ints[i+1];
 	}
 	return 1;
 }
-
 __setup("pirq=3D", ioapic_pirq_setup);
 #endif /* CONFIG_X86_32 */
=20
@@ -626,8 +565,7 @@ int save_ioapic_entries(void)
 		}
=20
 		for_each_pin(apic, pin)
-			ioapics[apic].saved_registers[pin] =3D
-				ioapic_read_entry(apic, pin);
+			ioapics[apic].saved_registers[pin] =3D ioapic_read_entry(apic, pin);
 	}
=20
 	return err;
@@ -668,8 +606,7 @@ int restore_ioapic_entries(void)
 			continue;
=20
 		for_each_pin(apic, pin)
-			ioapic_write_entry(apic, pin,
-					   ioapics[apic].saved_registers[pin]);
+			ioapic_write_entry(apic, pin, ioapics[apic].saved_registers[pin]);
 	}
 	return 0;
 }
@@ -681,12 +618,13 @@ static int find_irq_entry(int ioapic_idx, int pin, int =
type)
 {
 	int i;
=20
-	for (i =3D 0; i < mp_irq_entries; i++)
+	for (i =3D 0; i < mp_irq_entries; i++) {
 		if (mp_irqs[i].irqtype =3D=3D type &&
 		    (mp_irqs[i].dstapic =3D=3D mpc_ioapic_id(ioapic_idx) ||
 		     mp_irqs[i].dstapic =3D=3D MP_APIC_ALL) &&
 		    mp_irqs[i].dstirq =3D=3D pin)
 			return i;
+	}
=20
 	return -1;
 }
@@ -701,10 +639,8 @@ static int __init find_isa_irq_pin(int irq, int type)
 	for (i =3D 0; i < mp_irq_entries; i++) {
 		int lbus =3D mp_irqs[i].srcbus;
=20
-		if (test_bit(lbus, mp_bus_not_pci) &&
-		    (mp_irqs[i].irqtype =3D=3D type) &&
+		if (test_bit(lbus, mp_bus_not_pci) && (mp_irqs[i].irqtype =3D=3D type) &&
 		    (mp_irqs[i].srcbusirq =3D=3D irq))
-
 			return mp_irqs[i].dstirq;
 	}
 	return -1;
@@ -717,8 +653,7 @@ static int __init find_isa_irq_apic(int irq, int type)
 	for (i =3D 0; i < mp_irq_entries; i++) {
 		int lbus =3D mp_irqs[i].srcbus;
=20
-		if (test_bit(lbus, mp_bus_not_pci) &&
-		    (mp_irqs[i].irqtype =3D=3D type) &&
+		if (test_bit(lbus, mp_bus_not_pci) && (mp_irqs[i].irqtype =3D=3D type) &&
 		    (mp_irqs[i].srcbusirq =3D=3D irq))
 			break;
 	}
@@ -726,9 +661,10 @@ static int __init find_isa_irq_apic(int irq, int type)
 	if (i < mp_irq_entries) {
 		int ioapic_idx;
=20
-		for_each_ioapic(ioapic_idx)
+		for_each_ioapic(ioapic_idx) {
 			if (mpc_ioapic_id(ioapic_idx) =3D=3D mp_irqs[i].dstapic)
 				return ioapic_idx;
+		}
 	}
=20
 	return -1;
@@ -769,8 +705,7 @@ static bool EISA_ELCR(unsigned int irq)
 		unsigned int port =3D PIC_ELCR1 + (irq >> 3);
 		return (inb(port) >> (irq & 7)) & 1;
 	}
-	apic_printk(APIC_VERBOSE, KERN_INFO
-			"Broken MPtable reports ISA irq %d\n", irq);
+	apic_pr_verbose("Broken MPtable reports ISA irq %d\n", irq);
 	return false;
 }
=20
@@ -947,9 +882,9 @@ static bool mp_check_pin_attr(int irq, struct irq_alloc_i=
nfo *info)
 static int alloc_irq_from_domain(struct irq_domain *domain, int ioapic, u32 =
gsi,
 				 struct irq_alloc_info *info)
 {
+	int type =3D ioapics[ioapic].irqdomain_cfg.type;
 	bool legacy =3D false;
 	int irq =3D -1;
-	int type =3D ioapics[ioapic].irqdomain_cfg.type;
=20
 	switch (type) {
 	case IOAPIC_DOMAIN_LEGACY:
@@ -971,8 +906,7 @@ static int alloc_irq_from_domain(struct irq_domain *domai=
n, int ioapic, u32 gsi,
 		return -1;
 	}
=20
-	return __irq_domain_alloc_irqs(domain, irq, 1,
-				       ioapic_alloc_attr_node(info),
+	return __irq_domain_alloc_irqs(domain, irq, 1, ioapic_alloc_attr_node(info),
 				       info, legacy, NULL);
 }
=20
@@ -986,13 +920,12 @@ static int alloc_irq_from_domain(struct irq_domain *dom=
ain, int ioapic, u32 gsi,
  * PIRQs instead of reprogramming the interrupt routing logic. Thus there ma=
y be
  * multiple pins sharing the same legacy IRQ number when ACPI is disabled.
  */
-static int alloc_isa_irq_from_domain(struct irq_domain *domain,
-				     int irq, int ioapic, int pin,
+static int alloc_isa_irq_from_domain(struct irq_domain *domain, int irq, int=
 ioapic, int pin,
 				     struct irq_alloc_info *info)
 {
-	struct mp_chip_data *data;
 	struct irq_data *irq_data =3D irq_get_irq_data(irq);
 	int node =3D ioapic_alloc_attr_node(info);
+	struct mp_chip_data *data;
=20
 	/*
 	 * Legacy ISA IRQ has already been allocated, just add pin to
@@ -1002,13 +935,11 @@ static int alloc_isa_irq_from_domain(struct irq_domain=
 *domain,
 	if (irq_data && irq_data->parent_data) {
 		if (!mp_check_pin_attr(irq, info))
 			return -EBUSY;
-		if (__add_pin_to_irq_node(irq_data->chip_data, node, ioapic,
-					  info->ioapic.pin))
+		if (!add_pin_to_irq_node(irq_data->chip_data, node, ioapic, info->ioapic.p=
in))
 			return -ENOMEM;
 	} else {
 		info->flags |=3D X86_IRQ_ALLOC_LEGACY;
-		irq =3D __irq_domain_alloc_irqs(domain, irq, 1, node, info, true,
-					      NULL);
+		irq =3D __irq_domain_alloc_irqs(domain, irq, 1, node, info, true, NULL);
 		if (irq >=3D 0) {
 			irq_data =3D irq_domain_get_irq_data(domain, irq);
 			data =3D irq_data->chip_data;
@@ -1022,11 +953,11 @@ static int alloc_isa_irq_from_domain(struct irq_domain=
 *domain,
 static int mp_map_pin_to_irq(u32 gsi, int idx, int ioapic, int pin,
 			     unsigned int flags, struct irq_alloc_info *info)
 {
-	int irq;
-	bool legacy =3D false;
+	struct irq_domain *domain =3D mp_ioapic_irqdomain(ioapic);
 	struct irq_alloc_info tmp;
 	struct mp_chip_data *data;
-	struct irq_domain *domain =3D mp_ioapic_irqdomain(ioapic);
+	bool legacy =3D false;
+	int irq;
=20
 	if (!domain)
 		return -ENOSYS;
@@ -1046,7 +977,7 @@ static int mp_map_pin_to_irq(u32 gsi, int idx, int ioapi=
c, int pin,
 			return -EINVAL;
 	}
=20
-	mutex_lock(&ioapic_mutex);
+	guard(mutex)(&ioapic_mutex);
 	if (!(flags & IOAPIC_MAP_ALLOC)) {
 		if (!legacy) {
 			irq =3D irq_find_mapping(domain, pin);
@@ -1067,8 +998,6 @@ static int mp_map_pin_to_irq(u32 gsi, int idx, int ioapi=
c, int pin,
 			data->count++;
 		}
 	}
-	mutex_unlock(&ioapic_mutex);
-
 	return irq;
 }
=20
@@ -1076,26 +1005,20 @@ static int pin_2_irq(int idx, int ioapic, int pin, un=
signed int flags)
 {
 	u32 gsi =3D mp_pin_to_gsi(ioapic, pin);
=20
-	/*
-	 * Debugging check, we are in big trouble if this message pops up!
-	 */
+	/* Debugging check, we are in big trouble if this message pops up! */
 	if (mp_irqs[idx].dstirq !=3D pin)
 		pr_err("broken BIOS or MPTABLE parser, ayiee!!\n");
=20
 #ifdef CONFIG_X86_32
-	/*
-	 * PCI IRQ command line redirection. Yes, limits are hardcoded.
-	 */
+	/* PCI IRQ command line redirection. Yes, limits are hardcoded. */
 	if ((pin >=3D 16) && (pin <=3D 23)) {
-		if (pirq_entries[pin-16] !=3D -1) {
-			if (!pirq_entries[pin-16]) {
-				apic_printk(APIC_VERBOSE, KERN_DEBUG
-						"disabling PIRQ%d\n", pin-16);
+		if (pirq_entries[pin - 16] !=3D -1) {
+			if (!pirq_entries[pin - 16]) {
+				apic_pr_verbose("Disabling PIRQ%d\n", pin - 16);
 			} else {
 				int irq =3D pirq_entries[pin-16];
-				apic_printk(APIC_VERBOSE, KERN_DEBUG
-						"using PIRQ%d -> IRQ %d\n",
-						pin-16, irq);
+
+				apic_pr_verbose("Using PIRQ%d -> IRQ %d\n", pin - 16, irq);
 				return irq;
 			}
 		}
@@ -1133,10 +1056,9 @@ void mp_unmap_irq(int irq)
 	if (!data || data->isa_irq)
 		return;
=20
-	mutex_lock(&ioapic_mutex);
+	guard(mutex)(&ioapic_mutex);
 	if (--data->count =3D=3D 0)
 		irq_domain_free_irqs(irq, 1);
-	mutex_unlock(&ioapic_mutex);
 }
=20
 /*
@@ -1147,12 +1069,10 @@ int IO_APIC_get_PCI_irq_vector(int bus, int slot, int=
 pin)
 {
 	int irq, i, best_ioapic =3D -1, best_idx =3D -1;
=20
-	apic_printk(APIC_DEBUG,
-		    "querying PCI -> IRQ mapping bus:%d, slot:%d, pin:%d.\n",
-		    bus, slot, pin);
+	apic_pr_debug("Querying PCI -> IRQ mapping bus:%d, slot:%d, pin:%d.\n",
+		      bus, slot, pin);
 	if (test_bit(bus, mp_bus_not_pci)) {
-		apic_printk(APIC_VERBOSE,
-			    "PCI BIOS passed nonexistent PCI bus %d!\n", bus);
+		apic_pr_verbose("PCI BIOS passed nonexistent PCI bus %d!\n", bus);
 		return -1;
 	}
=20
@@ -1197,8 +1117,7 @@ int IO_APIC_get_PCI_irq_vector(int bus, int slot, int p=
in)
 		return -1;
=20
 out:
-	return pin_2_irq(best_idx, best_ioapic, mp_irqs[best_idx].dstirq,
-			 IOAPIC_MAP_ALLOC);
+	return pin_2_irq(best_idx, best_ioapic, mp_irqs[best_idx].dstirq, IOAPIC_MA=
P_ALLOC);
 }
 EXPORT_SYMBOL(IO_APIC_get_PCI_irq_vector);
=20
@@ -1209,17 +1128,16 @@ static void __init setup_IO_APIC_irqs(void)
 	unsigned int ioapic, pin;
 	int idx;
=20
-	apic_printk(APIC_VERBOSE, KERN_DEBUG "init IO_APIC IRQs\n");
+	apic_pr_verbose("Init IO_APIC IRQs\n");
=20
 	for_each_ioapic_pin(ioapic, pin) {
 		idx =3D find_irq_entry(ioapic, pin, mp_INT);
-		if (idx < 0)
-			apic_printk(APIC_VERBOSE,
-				    KERN_DEBUG " apic %d pin %d not connected\n",
-				    mpc_ioapic_id(ioapic), pin);
-		else
-			pin_2_irq(idx, ioapic, pin,
-				  ioapic ? 0 : IOAPIC_MAP_ALLOC);
+		if (idx < 0) {
+			apic_pr_verbose("apic %d pin %d not connected\n",
+					mpc_ioapic_id(ioapic), pin);
+		} else {
+			pin_2_irq(idx, ioapic, pin, ioapic ? 0 : IOAPIC_MAP_ALLOC);
+		}
 	}
 }
=20
@@ -1234,26 +1152,21 @@ static void io_apic_print_entries(unsigned int apic, =
unsigned int nr_entries)
 	char buf[256];
 	int i;
=20
-	printk(KERN_DEBUG "IOAPIC %d:\n", apic);
+	apic_dbg("IOAPIC %d:\n", apic);
 	for (i =3D 0; i <=3D nr_entries; i++) {
 		entry =3D ioapic_read_entry(apic, i);
-		snprintf(buf, sizeof(buf),
-			 " pin%02x, %s, %s, %s, V(%02X), IRR(%1d), S(%1d)",
-			 i,
-			 entry.masked ? "disabled" : "enabled ",
+		snprintf(buf, sizeof(buf), " pin%02x, %s, %s, %s, V(%02X), IRR(%1d), S(%1d=
)",
+			 i, entry.masked ? "disabled" : "enabled ",
 			 entry.is_level ? "level" : "edge ",
 			 entry.active_low ? "low " : "high",
 			 entry.vector, entry.irr, entry.delivery_status);
 		if (entry.ir_format) {
-			printk(KERN_DEBUG "%s, remapped, I(%04X),  Z(%X)\n",
-			       buf,
-			       (entry.ir_index_15 << 15) | entry.ir_index_0_14,
-				entry.ir_zero);
+			apic_dbg("%s, remapped, I(%04X),  Z(%X)\n", buf,
+				 (entry.ir_index_15 << 15) | entry.ir_index_0_14, entry.ir_zero);
 		} else {
-			printk(KERN_DEBUG "%s, %s, D(%02X%02X), M(%1d)\n", buf,
-			       entry.dest_mode_logical ? "logical " : "physical",
-			       entry.virt_destid_8_14, entry.destid_0_7,
-			       entry.delivery_mode);
+			apic_dbg("%s, %s, D(%02X%02X), M(%1d)\n", buf,
+				 entry.dest_mode_logical ? "logical " : "physic	al",
+				 entry.virt_destid_8_14, entry.destid_0_7, entry.delivery_mode);
 		}
 	}
 }
@@ -1264,30 +1177,25 @@ static void __init print_IO_APIC(int ioapic_idx)
 	union IO_APIC_reg_01 reg_01;
 	union IO_APIC_reg_02 reg_02;
 	union IO_APIC_reg_03 reg_03;
-	unsigned long flags;
=20
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
-	reg_00.raw =3D io_apic_read(ioapic_idx, 0);
-	reg_01.raw =3D io_apic_read(ioapic_idx, 1);
-	if (reg_01.bits.version >=3D 0x10)
-		reg_02.raw =3D io_apic_read(ioapic_idx, 2);
-	if (reg_01.bits.version >=3D 0x20)
-		reg_03.raw =3D io_apic_read(ioapic_idx, 3);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
-
-	printk(KERN_DEBUG "IO APIC #%d......\n", mpc_ioapic_id(ioapic_idx));
-	printk(KERN_DEBUG ".... register #00: %08X\n", reg_00.raw);
-	printk(KERN_DEBUG ".......    : physical APIC id: %02X\n", reg_00.bits.ID);
-	printk(KERN_DEBUG ".......    : Delivery Type: %X\n", reg_00.bits.delivery_=
type);
-	printk(KERN_DEBUG ".......    : LTS          : %X\n", reg_00.bits.LTS);
-
-	printk(KERN_DEBUG ".... register #01: %08X\n", *(int *)&reg_01);
-	printk(KERN_DEBUG ".......     : max redirection entries: %02X\n",
-		reg_01.bits.entries);
-
-	printk(KERN_DEBUG ".......     : PRQ implemented: %X\n", reg_01.bits.PRQ);
-	printk(KERN_DEBUG ".......     : IO APIC version: %02X\n",
-		reg_01.bits.version);
+	scoped_guard (raw_spinlock_irqsave, &ioapic_lock) {
+		reg_00.raw =3D io_apic_read(ioapic_idx, 0);
+		reg_01.raw =3D io_apic_read(ioapic_idx, 1);
+		if (reg_01.bits.version >=3D 0x10)
+			reg_02.raw =3D io_apic_read(ioapic_idx, 2);
+		if (reg_01.bits.version >=3D 0x20)
+			reg_03.raw =3D io_apic_read(ioapic_idx, 3);
+	}
+
+	apic_dbg("IO APIC #%d......\n", mpc_ioapic_id(ioapic_idx));
+	apic_dbg(".... register #00: %08X\n", reg_00.raw);
+	apic_dbg(".......    : physical APIC id: %02X\n", reg_00.bits.ID);
+	apic_dbg(".......    : Delivery Type: %X\n", reg_00.bits.delivery_type);
+	apic_dbg(".......    : LTS          : %X\n", reg_00.bits.LTS);
+	apic_dbg(".... register #01: %08X\n", *(int *)&reg_01);
+	apic_dbg(".......     : max redirection entries: %02X\n", reg_01.bits.entri=
es);
+	apic_dbg(".......     : PRQ implemented: %X\n", reg_01.bits.PRQ);
+	apic_dbg(".......     : IO APIC version: %02X\n", reg_01.bits.version);
=20
 	/*
 	 * Some Intel chipsets with IO APIC VERSION of 0x1? don't have reg_02,
@@ -1295,8 +1203,8 @@ static void __init print_IO_APIC(int ioapic_idx)
 	 * value, so ignore it if reg_02 =3D=3D reg_01.
 	 */
 	if (reg_01.bits.version >=3D 0x10 && reg_02.raw !=3D reg_01.raw) {
-		printk(KERN_DEBUG ".... register #02: %08X\n", reg_02.raw);
-		printk(KERN_DEBUG ".......     : arbitration: %02X\n", reg_02.bits.arbitra=
tion);
+		apic_dbg(".... register #02: %08X\n", reg_02.raw);
+		apic_dbg(".......     : arbitration: %02X\n", reg_02.bits.arbitration);
 	}
=20
 	/*
@@ -1306,11 +1214,11 @@ static void __init print_IO_APIC(int ioapic_idx)
 	 */
 	if (reg_01.bits.version >=3D 0x20 && reg_03.raw !=3D reg_02.raw &&
 	    reg_03.raw !=3D reg_01.raw) {
-		printk(KERN_DEBUG ".... register #03: %08X\n", reg_03.raw);
-		printk(KERN_DEBUG ".......     : Boot DT    : %X\n", reg_03.bits.boot_DT);
+		apic_dbg(".... register #03: %08X\n", reg_03.raw);
+		apic_dbg(".......     : Boot DT    : %X\n", reg_03.bits.boot_DT);
 	}
=20
-	printk(KERN_DEBUG ".... IRQ redirection table:\n");
+	apic_dbg(".... IRQ redirection table:\n");
 	io_apic_print_entries(ioapic_idx, reg_01.bits.entries);
 }
=20
@@ -1319,11 +1227,11 @@ void __init print_IO_APICs(void)
 	int ioapic_idx;
 	unsigned int irq;
=20
-	printk(KERN_DEBUG "number of MP IRQ sources: %d.\n", mp_irq_entries);
-	for_each_ioapic(ioapic_idx)
-		printk(KERN_DEBUG "number of IO-APIC #%d registers: %d.\n",
-		       mpc_ioapic_id(ioapic_idx),
-		       ioapics[ioapic_idx].nr_registers);
+	apic_dbg("number of MP IRQ sources: %d.\n", mp_irq_entries);
+	for_each_ioapic(ioapic_idx) {
+		apic_dbg("number of IO-APIC #%d registers: %d.\n",
+			 mpc_ioapic_id(ioapic_idx), ioapics[ioapic_idx].nr_registers);
+	}
=20
 	/*
 	 * We are a bit conservative about what we expect.  We have to
@@ -1334,7 +1242,7 @@ void __init print_IO_APICs(void)
 	for_each_ioapic(ioapic_idx)
 		print_IO_APIC(ioapic_idx);
=20
-	printk(KERN_DEBUG "IRQ to pin mappings:\n");
+	apic_dbg("IRQ to pin mappings:\n");
 	for_each_active_irq(irq) {
 		struct irq_pin_list *entry;
 		struct irq_chip *chip;
@@ -1349,7 +1257,7 @@ void __init print_IO_APICs(void)
 		if (list_empty(&data->irq_2_pin))
 			continue;
=20
-		printk(KERN_DEBUG "IRQ%d ", irq);
+		apic_dbg("IRQ%d ", irq);
 		for_each_irq_pin(entry, data->irq_2_pin)
 			pr_cont("-> %d:%d", entry->apic, entry->pin);
 		pr_cont("\n");
@@ -1363,8 +1271,7 @@ static struct { int pin, apic; } ioapic_i8259 =3D { -1,=
 -1 };
=20
 void __init enable_IO_APIC(void)
 {
-	int i8259_apic, i8259_pin;
-	int apic, pin;
+	int i8259_apic, i8259_pin, apic, pin;
=20
 	if (ioapic_is_disabled)
 		nr_ioapics =3D 0;
@@ -1376,19 +1283,21 @@ void __init enable_IO_APIC(void)
 		/* See if any of the pins is in ExtINT mode */
 		struct IO_APIC_route_entry entry =3D ioapic_read_entry(apic, pin);
=20
-		/* If the interrupt line is enabled and in ExtInt mode
-		 * I have found the pin where the i8259 is connected.
+		/*
+		 * If the interrupt line is enabled and in ExtInt mode I
+		 * have found the pin where the i8259 is connected.
 		 */
-		if (!entry.masked &&
-		    entry.delivery_mode =3D=3D APIC_DELIVERY_MODE_EXTINT) {
+		if (!entry.masked && entry.delivery_mode =3D=3D APIC_DELIVERY_MODE_EXTINT)=
 {
 			ioapic_i8259.apic =3D apic;
 			ioapic_i8259.pin  =3D pin;
-			goto found_i8259;
+			break;
 		}
 	}
- found_i8259:
-	/* Look to see what if the MP table has reported the ExtINT */
-	/* If we could not find the appropriate pin by looking at the ioapic
+
+	/*
+	 * Look to see what if the MP table has reported the ExtINT
+	 *
+	 * If we could not find the appropriate pin by looking at the ioapic
 	 * the i8259 probably is not connected the ioapic but give the
 	 * mptable a chance anyway.
 	 */
@@ -1396,29 +1305,24 @@ void __init enable_IO_APIC(void)
 	i8259_apic =3D find_isa_irq_apic(0, mp_ExtINT);
 	/* Trust the MP table if nothing is setup in the hardware */
 	if ((ioapic_i8259.pin =3D=3D -1) && (i8259_pin >=3D 0)) {
-		printk(KERN_WARNING "ExtINT not setup in hardware but reported by MP table=
\n");
+		pr_warn("ExtINT not setup in hardware but reported by MP table\n");
 		ioapic_i8259.pin  =3D i8259_pin;
 		ioapic_i8259.apic =3D i8259_apic;
 	}
 	/* Complain if the MP table and the hardware disagree */
 	if (((ioapic_i8259.apic !=3D i8259_apic) || (ioapic_i8259.pin !=3D i8259_pi=
n)) &&
-		(i8259_pin >=3D 0) && (ioapic_i8259.pin >=3D 0))
-	{
-		printk(KERN_WARNING "ExtINT in hardware and MP table differ\n");
-	}
+	    (i8259_pin >=3D 0) && (ioapic_i8259.pin >=3D 0))
+		pr_warn("ExtINT in hardware and MP table differ\n");
=20
-	/*
-	 * Do not trust the IO-APIC being empty at bootup
-	 */
+	/* Do not trust the IO-APIC being empty at bootup */
 	clear_IO_APIC();
 }
=20
 void native_restore_boot_irq_mode(void)
 {
 	/*
-	 * If the i8259 is routed through an IOAPIC
-	 * Put that IOAPIC in virtual wire mode
-	 * so legacy interrupts can be delivered.
+	 * If the i8259 is routed through an IOAPIC Put that IOAPIC in
+	 * virtual wire mode so legacy interrupts can be delivered.
 	 */
 	if (ioapic_i8259.pin !=3D -1) {
 		struct IO_APIC_route_entry entry;
@@ -1433,9 +1337,7 @@ void native_restore_boot_irq_mode(void)
 		entry.destid_0_7	=3D apic_id & 0xFF;
 		entry.virt_destid_8_14	=3D apic_id >> 8;
=20
-		/*
-		 * Add it to the IO-APIC irq-routing table:
-		 */
+		/* Add it to the IO-APIC irq-routing table */
 		ioapic_write_entry(ioapic_i8259.apic, ioapic_i8259.pin, entry);
 	}
=20
@@ -1464,7 +1366,6 @@ static void __init setup_ioapic_ids_from_mpc_nocheck(vo=
id)
 	const u32 broadcast_id =3D 0xF;
 	union IO_APIC_reg_00 reg_00;
 	unsigned char old_id;
-	unsigned long flags;
 	int ioapic_idx, i;
=20
 	/*
@@ -1478,9 +1379,8 @@ static void __init setup_ioapic_ids_from_mpc_nocheck(vo=
id)
 	 */
 	for_each_ioapic(ioapic_idx) {
 		/* Read the register 0 value */
-		raw_spin_lock_irqsave(&ioapic_lock, flags);
-		reg_00.raw =3D io_apic_read(ioapic_idx, 0);
-		raw_spin_unlock_irqrestore(&ioapic_lock, flags);
+		scoped_guard (raw_spinlock_irqsave, &ioapic_lock)
+			reg_00.raw =3D io_apic_read(ioapic_idx, 0);
=20
 		old_id =3D mpc_ioapic_id(ioapic_idx);
=20
@@ -1508,47 +1408,42 @@ static void __init setup_ioapic_ids_from_mpc_nocheck(=
void)
 			set_bit(i, phys_id_present_map);
 			ioapics[ioapic_idx].mp_config.apicid =3D i;
 		} else {
-			apic_printk(APIC_VERBOSE, "Setting %d in the phys_id_present_map\n",
-				    mpc_ioapic_id(ioapic_idx));
+			apic_pr_verbose("Setting %d in the phys_id_present_map\n",
+					mpc_ioapic_id(ioapic_idx));
 			set_bit(mpc_ioapic_id(ioapic_idx), phys_id_present_map);
 		}
=20
 		/*
-		 * We need to adjust the IRQ routing table
-		 * if the ID changed.
+		 * We need to adjust the IRQ routing table if the ID
+		 * changed.
 		 */
-		if (old_id !=3D mpc_ioapic_id(ioapic_idx))
-			for (i =3D 0; i < mp_irq_entries; i++)
+		if (old_id !=3D mpc_ioapic_id(ioapic_idx)) {
+			for (i =3D 0; i < mp_irq_entries; i++) {
 				if (mp_irqs[i].dstapic =3D=3D old_id)
-					mp_irqs[i].dstapic
-						=3D mpc_ioapic_id(ioapic_idx);
+					mp_irqs[i].dstapic =3D mpc_ioapic_id(ioapic_idx);
+			}
+		}
=20
 		/*
-		 * Update the ID register according to the right value
-		 * from the MPC table if they are different.
+		 * Update the ID register according to the right value from
+		 * the MPC table if they are different.
 		 */
 		if (mpc_ioapic_id(ioapic_idx) =3D=3D reg_00.bits.ID)
 			continue;
=20
-		apic_printk(APIC_VERBOSE, KERN_INFO
-			"...changing IO-APIC physical APIC ID to %d ...",
-			mpc_ioapic_id(ioapic_idx));
+		apic_pr_verbose("...changing IO-APIC physical APIC ID to %d ...",
+				mpc_ioapic_id(ioapic_idx));
=20
 		reg_00.bits.ID =3D mpc_ioapic_id(ioapic_idx);
-		raw_spin_lock_irqsave(&ioapic_lock, flags);
-		io_apic_write(ioapic_idx, 0, reg_00.raw);
-		raw_spin_unlock_irqrestore(&ioapic_lock, flags);
-
-		/*
-		 * Sanity check
-		 */
-		raw_spin_lock_irqsave(&ioapic_lock, flags);
-		reg_00.raw =3D io_apic_read(ioapic_idx, 0);
-		raw_spin_unlock_irqrestore(&ioapic_lock, flags);
+		scoped_guard (raw_spinlock_irqsave, &ioapic_lock) {
+			io_apic_write(ioapic_idx, 0, reg_00.raw);
+			reg_00.raw =3D io_apic_read(ioapic_idx, 0);
+		}
+		/* Sanity check */
 		if (reg_00.bits.ID !=3D mpc_ioapic_id(ioapic_idx))
 			pr_cont("could not set ID!\n");
 		else
-			apic_printk(APIC_VERBOSE, " ok.\n");
+			apic_pr_verbose(" ok.\n");
 	}
 }
=20
@@ -1593,8 +1488,7 @@ static void __init delay_with_tsc(void)
 	do {
 		rep_nop();
 		now =3D rdtsc();
-	} while ((now - start) < 40000000000ULL / HZ &&
-		time_before_eq(jiffies, end));
+	} while ((now - start) < 40000000000ULL / HZ &&	time_before_eq(jiffies, end=
));
 }
=20
 static void __init delay_without_tsc(void)
@@ -1655,36 +1549,29 @@ static int __init timer_irq_works(void)
  * so we 'resend' these IRQs via IPIs, to the same CPU. It's much
  * better to do it this way as thus we do not have to be aware of
  * 'pending' interrupts in the IRQ path, except at this point.
- */
-/*
- * Edge triggered needs to resend any interrupt
- * that was delayed but this is now handled in the device
- * independent code.
- */
-
-/*
- * Starting up a edge-triggered IO-APIC interrupt is
- * nasty - we need to make sure that we get the edge.
- * If it is already asserted for some reason, we need
- * return 1 to indicate that is was pending.
  *
- * This is not complete - we should be able to fake
- * an edge even if it isn't on the 8259A...
+ *
+ * Edge triggered needs to resend any interrupt that was delayed but this
+ * is now handled in the device independent code.
+ *
+ * Starting up a edge-triggered IO-APIC interrupt is nasty - we need to
+ * make sure that we get the edge.  If it is already asserted for some
+ * reason, we need return 1 to indicate that is was pending.
+ *
+ * This is not complete - we should be able to fake an edge even if it
+ * isn't on the 8259A...
  */
 static unsigned int startup_ioapic_irq(struct irq_data *data)
 {
 	int was_pending =3D 0, irq =3D data->irq;
-	unsigned long flags;
=20
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	if (irq < nr_legacy_irqs()) {
 		legacy_pic->mask(irq);
 		if (legacy_pic->irq_pending(irq))
 			was_pending =3D 1;
 	}
 	__unmask_ioapic(data->chip_data);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
-
 	return was_pending;
 }
=20
@@ -1694,9 +1581,8 @@ atomic_t irq_mis_count;
 static bool io_apic_level_ack_pending(struct mp_chip_data *data)
 {
 	struct irq_pin_list *entry;
-	unsigned long flags;
=20
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	for_each_irq_pin(entry, data->irq_2_pin) {
 		struct IO_APIC_route_entry e;
 		int pin;
@@ -1704,13 +1590,9 @@ static bool io_apic_level_ack_pending(struct mp_chip_d=
ata *data)
 		pin =3D entry->pin;
 		e.w1 =3D io_apic_read(entry->apic, 0x10 + pin*2);
 		/* Is the remote IRR bit set? */
-		if (e.irr) {
-			raw_spin_unlock_irqrestore(&ioapic_lock, flags);
+		if (e.irr)
 			return true;
-		}
 	}
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
-
 	return false;
 }
=20
@@ -1728,7 +1610,8 @@ static inline bool ioapic_prepare_move(struct irq_data =
*data)
 static inline void ioapic_finish_move(struct irq_data *data, bool moveit)
 {
 	if (unlikely(moveit)) {
-		/* Only migrate the irq if the ack has been received.
+		/*
+		 * Only migrate the irq if the ack has been received.
 		 *
 		 * On rare occasions the broadcast level triggered ack gets
 		 * delayed going to ioapics, and if we reprogram the
@@ -1911,18 +1794,16 @@ static void ioapic_configure_entry(struct irq_data *i=
rqd)
 		__ioapic_write_entry(entry->apic, entry->pin, mpd->entry);
 }
=20
-static int ioapic_set_affinity(struct irq_data *irq_data,
-			       const struct cpumask *mask, bool force)
+static int ioapic_set_affinity(struct irq_data *irq_data, const struct cpuma=
sk *mask, bool force)
 {
 	struct irq_data *parent =3D irq_data->parent_data;
-	unsigned long flags;
 	int ret;
=20
 	ret =3D parent->chip->irq_set_affinity(parent, mask, force);
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	if (ret >=3D 0 && ret !=3D IRQ_SET_MASK_OK_DONE)
 		ioapic_configure_entry(irq_data);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
=20
 	return ret;
 }
@@ -1941,9 +1822,8 @@ static int ioapic_set_affinity(struct irq_data *irq_dat=
a,
  *
  * Verify that the corresponding Remote-IRR bits are clear.
  */
-static int ioapic_irq_get_chip_state(struct irq_data *irqd,
-				   enum irqchip_irq_state which,
-				   bool *state)
+static int ioapic_irq_get_chip_state(struct irq_data *irqd, enum irqchip_irq=
_state which,
+				     bool *state)
 {
 	struct mp_chip_data *mcd =3D irqd->chip_data;
 	struct IO_APIC_route_entry rentry;
@@ -1953,7 +1833,8 @@ static int ioapic_irq_get_chip_state(struct irq_data *i=
rqd,
 		return -EINVAL;
=20
 	*state =3D false;
-	raw_spin_lock(&ioapic_lock);
+
+	guard(raw_spinlock)(&ioapic_lock);
 	for_each_irq_pin(p, mcd->irq_2_pin) {
 		rentry =3D __ioapic_read_entry(p->apic, p->pin);
 		/*
@@ -1967,7 +1848,6 @@ static int ioapic_irq_get_chip_state(struct irq_data *i=
rqd,
 			break;
 		}
 	}
-	raw_spin_unlock(&ioapic_lock);
 	return 0;
 }
=20
@@ -2008,14 +1888,13 @@ static inline void init_IO_APIC_traps(void)
 		cfg =3D irq_cfg(irq);
 		if (IO_APIC_IRQ(irq) && cfg && !cfg->vector) {
 			/*
-			 * Hmm.. We don't have an entry for this,
-			 * so default to an old-fashioned 8259
-			 * interrupt if we can..
+			 * Hmm.. We don't have an entry for this, so
+			 * default to an old-fashioned 8259 interrupt if we
+			 * can. Otherwise set the dummy interrupt chip.
 			 */
 			if (irq < nr_legacy_irqs())
 				legacy_pic->make_irq(irq);
 			else
-				/* Strange. Oh, well.. */
 				irq_set_chip(irq, &no_irq_chip);
 		}
 	}
@@ -2024,20 +1903,17 @@ static inline void init_IO_APIC_traps(void)
 /*
  * The local APIC irq-chip implementation:
  */
-
 static void mask_lapic_irq(struct irq_data *data)
 {
-	unsigned long v;
+	unsigned long v =3D apic_read(APIC_LVT0);
=20
-	v =3D apic_read(APIC_LVT0);
 	apic_write(APIC_LVT0, v | APIC_LVT_MASKED);
 }
=20
 static void unmask_lapic_irq(struct irq_data *data)
 {
-	unsigned long v;
+	unsigned long v =3D apic_read(APIC_LVT0);
=20
-	v =3D apic_read(APIC_LVT0);
 	apic_write(APIC_LVT0, v & ~APIC_LVT_MASKED);
 }
=20
@@ -2056,8 +1932,7 @@ static struct irq_chip lapic_chip __read_mostly =3D {
 static void lapic_register_intr(int irq)
 {
 	irq_clear_status_flags(irq, IRQ_LEVEL);
-	irq_set_chip_and_handler_name(irq, &lapic_chip, handle_edge_irq,
-				      "edge");
+	irq_set_chip_and_handler_name(irq, &lapic_chip, handle_edge_irq, "edge");
 }
=20
 /*
@@ -2069,9 +1944,9 @@ static void lapic_register_intr(int irq)
  */
 static inline void __init unlock_ExtINT_logic(void)
 {
-	int apic, pin, i;
-	struct IO_APIC_route_entry entry0, entry1;
 	unsigned char save_control, save_freq_select;
+	struct IO_APIC_route_entry entry0, entry1;
+	int apic, pin, i;
 	u32 apic_id;
=20
 	pin  =3D find_isa_irq_pin(8, mp_INT);
@@ -2131,10 +2006,10 @@ static int __init disable_timer_pin_setup(char *arg)
 }
 early_param("disable_timer_pin_1", disable_timer_pin_setup);
=20
-static int mp_alloc_timer_irq(int ioapic, int pin)
+static int __init mp_alloc_timer_irq(int ioapic, int pin)
 {
-	int irq =3D -1;
 	struct irq_domain *domain =3D mp_ioapic_irqdomain(ioapic);
+	int irq =3D -1;
=20
 	if (domain) {
 		struct irq_alloc_info info;
@@ -2142,21 +2017,36 @@ static int mp_alloc_timer_irq(int ioapic, int pin)
 		ioapic_set_alloc_attr(&info, NUMA_NO_NODE, 0, 0);
 		info.devid =3D mpc_ioapic_id(ioapic);
 		info.ioapic.pin =3D pin;
-		mutex_lock(&ioapic_mutex);
+		guard(mutex)(&ioapic_mutex);
 		irq =3D alloc_isa_irq_from_domain(domain, 0, ioapic, pin, &info);
-		mutex_unlock(&ioapic_mutex);
 	}
=20
 	return irq;
 }
=20
+static void __init replace_pin_at_irq_node(struct mp_chip_data *data, int no=
de,
+					   int oldapic, int oldpin,
+					   int newapic, int newpin)
+{
+	struct irq_pin_list *entry;
+
+	for_each_irq_pin(entry, data->irq_2_pin) {
+		if (entry->apic =3D=3D oldapic && entry->pin =3D=3D oldpin) {
+			entry->apic =3D newapic;
+			entry->pin =3D newpin;
+			return;
+		}
+	}
+
+	/* Old apic/pin didn't exist, so just add a new one */
+	add_pin_to_irq_node(data, node, newapic, newpin);
+}
+
 /*
  * This code may look a bit paranoid, but it's supposed to cooperate with
  * a wide range of boards and BIOS bugs.  Fortunately only the timer IRQ
  * is so screwy.  Thanks to Brian Perkins for testing/hacking this beast
  * fanatically on his truly buggy board.
- *
- * FIXME: really need to revamp this for all platforms.
  */
 static inline void __init check_timer(void)
 {
@@ -2194,9 +2084,8 @@ static inline void __init check_timer(void)
 	pin2  =3D ioapic_i8259.pin;
 	apic2 =3D ioapic_i8259.apic;
=20
-	apic_printk(APIC_QUIET, KERN_INFO "..TIMER: vector=3D0x%02X "
-		    "apic1=3D%d pin1=3D%d apic2=3D%d pin2=3D%d\n",
-		    cfg->vector, apic1, pin1, apic2, pin2);
+	pr_info("..TIMER: vector=3D0x%02X apic1=3D%d pin1=3D%d apic2=3D%d pin2=3D%d=
\n",
+		cfg->vector, apic1, pin1, apic2, pin2);
=20
 	/*
 	 * Some BIOS writers are clueless and report the ExtINTA
@@ -2240,13 +2129,10 @@ static inline void __init check_timer(void)
 		panic_if_irq_remap("timer doesn't work through Interrupt-remapped IO-APIC"=
);
 		clear_IO_APIC_pin(apic1, pin1);
 		if (!no_pin1)
-			apic_printk(APIC_QUIET, KERN_ERR "..MP-BIOS bug: "
-				    "8254 timer not connected to IO-APIC\n");
+			pr_err("..MP-BIOS bug: 8254 timer not connected to IO-APIC\n");
=20
-		apic_printk(APIC_QUIET, KERN_INFO "...trying to set up timer "
-			    "(IRQ0) through the 8259A ...\n");
-		apic_printk(APIC_QUIET, KERN_INFO
-			    "..... (found apic %d pin %d) ...\n", apic2, pin2);
+		pr_info("...trying to set up timer (IRQ0) through the 8259A ...\n");
+		pr_info("..... (found apic %d pin %d) ...\n", apic2, pin2);
 		/*
 		 * legacy devices should be connected to IO APIC #0
 		 */
@@ -2255,7 +2141,7 @@ static inline void __init check_timer(void)
 		irq_domain_activate_irq(irq_data, false);
 		legacy_pic->unmask(0);
 		if (timer_irq_works()) {
-			apic_printk(APIC_QUIET, KERN_INFO "....... works.\n");
+			pr_info("....... works.\n");
 			goto out;
 		}
 		/*
@@ -2263,26 +2149,24 @@ static inline void __init check_timer(void)
 		 */
 		legacy_pic->mask(0);
 		clear_IO_APIC_pin(apic2, pin2);
-		apic_printk(APIC_QUIET, KERN_INFO "....... failed.\n");
+		pr_info("....... failed.\n");
 	}
=20
-	apic_printk(APIC_QUIET, KERN_INFO
-		    "...trying to set up timer as Virtual Wire IRQ...\n");
+	pr_info("...trying to set up timer as Virtual Wire IRQ...\n");
=20
 	lapic_register_intr(0);
 	apic_write(APIC_LVT0, APIC_DM_FIXED | cfg->vector);	/* Fixed mode */
 	legacy_pic->unmask(0);
=20
 	if (timer_irq_works()) {
-		apic_printk(APIC_QUIET, KERN_INFO "..... works.\n");
+		pr_info("..... works.\n");
 		goto out;
 	}
 	legacy_pic->mask(0);
 	apic_write(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_FIXED | cfg->vector);
-	apic_printk(APIC_QUIET, KERN_INFO "..... failed.\n");
+	pr_info("..... failed.\n");
=20
-	apic_printk(APIC_QUIET, KERN_INFO
-		    "...trying to set up timer as ExtINT IRQ...\n");
+	pr_info("...trying to set up timer as ExtINT IRQ...\n");
=20
 	legacy_pic->init(0);
 	legacy_pic->make_irq(0);
@@ -2292,14 +2176,15 @@ static inline void __init check_timer(void)
 	unlock_ExtINT_logic();
=20
 	if (timer_irq_works()) {
-		apic_printk(APIC_QUIET, KERN_INFO "..... works.\n");
+		pr_info("..... works.\n");
 		goto out;
 	}
-	apic_printk(APIC_QUIET, KERN_INFO "..... failed :(.\n");
-	if (apic_is_x2apic_enabled())
-		apic_printk(APIC_QUIET, KERN_INFO
-			    "Perhaps problem with the pre-enabled x2apic mode\n"
-			    "Try booting with x2apic and interrupt-remapping disabled in the bios=
.\n");
+
+	pr_info("..... failed :\n");
+	if (apic_is_x2apic_enabled()) {
+		pr_info("Perhaps problem with the pre-enabled x2apic mode\n"
+			"Try booting with x2apic and interrupt-remapping disabled in the bios.\n"=
);
+	}
 	panic("IO-APIC + timer doesn't work!  Boot with apic=3Ddebug and send a "
 		"report.  Then try booting with the 'noapic' option.\n");
 out:
@@ -2327,11 +2212,11 @@ static inline void __init check_timer(void)
=20
 static int mp_irqdomain_create(int ioapic)
 {
-	struct irq_domain *parent;
+	struct mp_ioapic_gsi *gsi_cfg =3D mp_ioapic_gsi_routing(ioapic);
 	int hwirqs =3D mp_ioapic_pin_count(ioapic);
 	struct ioapic *ip =3D &ioapics[ioapic];
 	struct ioapic_domain_cfg *cfg =3D &ip->irqdomain_cfg;
-	struct mp_ioapic_gsi *gsi_cfg =3D mp_ioapic_gsi_routing(ioapic);
+	struct irq_domain *parent;
 	struct fwnode_handle *fn;
 	struct irq_fwspec fwspec;
=20
@@ -2367,10 +2252,8 @@ static int mp_irqdomain_create(int ioapic)
 		return -ENOMEM;
 	}
=20
-	if (cfg->type =3D=3D IOAPIC_DOMAIN_LEGACY ||
-	    cfg->type =3D=3D IOAPIC_DOMAIN_STRICT)
-		ioapic_dynirq_base =3D max(ioapic_dynirq_base,
-					 gsi_cfg->gsi_end + 1);
+	if (cfg->type =3D=3D IOAPIC_DOMAIN_LEGACY || cfg->type =3D=3D IOAPIC_DOMAIN=
_STRICT)
+		ioapic_dynirq_base =3D max(ioapic_dynirq_base, gsi_cfg->gsi_end + 1);
=20
 	return 0;
 }
@@ -2397,13 +2280,11 @@ void __init setup_IO_APIC(void)
=20
 	io_apic_irqs =3D nr_legacy_irqs() ? ~PIC_IRQS : ~0UL;
=20
-	apic_printk(APIC_VERBOSE, "ENABLING IO-APIC IRQs\n");
+	apic_pr_verbose("ENABLING IO-APIC IRQs\n");
 	for_each_ioapic(ioapic)
 		BUG_ON(mp_irqdomain_create(ioapic));
=20
-	/*
-         * Set up IO-APIC IRQ routing.
-         */
+	/* Set up IO-APIC IRQ routing. */
 	x86_init.mpparse.setup_ioapic_ids();
=20
 	sync_Arb_IDs();
@@ -2417,16 +2298,14 @@ void __init setup_IO_APIC(void)
=20
 static void resume_ioapic_id(int ioapic_idx)
 {
-	unsigned long flags;
 	union IO_APIC_reg_00 reg_00;
=20
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	reg_00.raw =3D io_apic_read(ioapic_idx, 0);
 	if (reg_00.bits.ID !=3D mpc_ioapic_id(ioapic_idx)) {
 		reg_00.bits.ID =3D mpc_ioapic_id(ioapic_idx);
 		io_apic_write(ioapic_idx, 0, reg_00.raw);
 	}
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 }
=20
 static void ioapic_resume(void)
@@ -2440,8 +2319,8 @@ static void ioapic_resume(void)
 }
=20
 static struct syscore_ops ioapic_syscore_ops =3D {
-	.suspend =3D save_ioapic_entries,
-	.resume =3D ioapic_resume,
+	.suspend	=3D save_ioapic_entries,
+	.resume		=3D ioapic_resume,
 };
=20
 static int __init ioapic_init_ops(void)
@@ -2456,15 +2335,13 @@ device_initcall(ioapic_init_ops);
 static int io_apic_get_redir_entries(int ioapic)
 {
 	union IO_APIC_reg_01	reg_01;
-	unsigned long flags;
=20
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	reg_01.raw =3D io_apic_read(ioapic, 1);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
=20
-	/* The register returns the maximum index redir index
-	 * supported, which is one less than the total number of redir
-	 * entries.
+	/*
+	 * The register returns the maximum index redir index supported,
+	 * which is one less than the total number of redir entries.
 	 */
 	return reg_01.bits.entries + 1;
 }
@@ -2494,16 +2371,14 @@ static int io_apic_get_unique_id(int ioapic, int apic=
_id)
 	static DECLARE_BITMAP(apic_id_map, MAX_LOCAL_APIC);
 	const u32 broadcast_id =3D 0xF;
 	union IO_APIC_reg_00 reg_00;
-	unsigned long flags;
 	int i =3D 0;
=20
 	/* Initialize the ID map */
 	if (bitmap_empty(apic_id_map, MAX_LOCAL_APIC))
 		copy_phys_cpu_present_map(apic_id_map);
=20
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
-	reg_00.raw =3D io_apic_read(ioapic, 0);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
+	scoped_guard (raw_spinlock_irqsave, &ioapic_lock)
+		reg_00.raw =3D io_apic_read(ioapic, 0);
=20
 	if (apic_id >=3D broadcast_id) {
 		pr_warn("IOAPIC[%d]: Invalid apic_id %d, trying %d\n",
@@ -2530,21 +2405,19 @@ static int io_apic_get_unique_id(int ioapic, int apic=
_id)
 	if (reg_00.bits.ID !=3D apic_id) {
 		reg_00.bits.ID =3D apic_id;
=20
-		raw_spin_lock_irqsave(&ioapic_lock, flags);
-		io_apic_write(ioapic, 0, reg_00.raw);
-		reg_00.raw =3D io_apic_read(ioapic, 0);
-		raw_spin_unlock_irqrestore(&ioapic_lock, flags);
+		scoped_guard (raw_spinlock_irqsave, &ioapic_lock) {
+			io_apic_write(ioapic, 0, reg_00.raw);
+			reg_00.raw =3D io_apic_read(ioapic, 0);
+		}
=20
 		/* Sanity check */
 		if (reg_00.bits.ID !=3D apic_id) {
-			pr_err("IOAPIC[%d]: Unable to change apic_id!\n",
-			       ioapic);
+			pr_err("IOAPIC[%d]: Unable to change apic_id!\n", ioapic);
 			return -1;
 		}
 	}
=20
-	apic_printk(APIC_VERBOSE, KERN_INFO
-			"IOAPIC[%d]: Assigned apic_id %d\n", ioapic, apic_id);
+	apic_pr_verbose("IOAPIC[%d]: Assigned apic_id %d\n", ioapic, apic_id);
=20
 	return apic_id;
 }
@@ -2560,7 +2433,6 @@ static u8 io_apic_unique_id(int idx, u8 id)
 {
 	union IO_APIC_reg_00 reg_00;
 	DECLARE_BITMAP(used, 256);
-	unsigned long flags;
 	u8 new_id;
 	int i;
=20
@@ -2576,26 +2448,23 @@ static u8 io_apic_unique_id(int idx, u8 id)
 	 * Read the current id from the ioapic and keep it if
 	 * available.
 	 */
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
-	reg_00.raw =3D io_apic_read(idx, 0);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
+	scoped_guard (raw_spinlock_irqsave, &ioapic_lock)
+		reg_00.raw =3D io_apic_read(idx, 0);
+
 	new_id =3D reg_00.bits.ID;
 	if (!test_bit(new_id, used)) {
-		apic_printk(APIC_VERBOSE, KERN_INFO
-			"IOAPIC[%d]: Using reg apic_id %d instead of %d\n",
-			 idx, new_id, id);
+		apic_pr_verbose("IOAPIC[%d]: Using reg apic_id %d instead of %d\n",
+				idx, new_id, id);
 		return new_id;
 	}
=20
-	/*
-	 * Get the next free id and write it to the ioapic.
-	 */
+	/* Get the next free id and write it to the ioapic. */
 	new_id =3D find_first_zero_bit(used, 256);
 	reg_00.bits.ID =3D new_id;
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(idx, 0, reg_00.raw);
-	reg_00.raw =3D io_apic_read(idx, 0);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
+	scoped_guard (raw_spinlock_irqsave, &ioapic_lock) {
+		io_apic_write(idx, 0, reg_00.raw);
+		reg_00.raw =3D io_apic_read(idx, 0);
+	}
 	/* Sanity check */
 	BUG_ON(reg_00.bits.ID !=3D new_id);
=20
@@ -2605,12 +2474,10 @@ static u8 io_apic_unique_id(int idx, u8 id)
=20
 static int io_apic_get_version(int ioapic)
 {
-	union IO_APIC_reg_01	reg_01;
-	unsigned long flags;
+	union IO_APIC_reg_01 reg_01;
=20
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	reg_01.raw =3D io_apic_read(ioapic, 1);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
=20
 	return reg_01.bits.version;
 }
@@ -2625,8 +2492,8 @@ static struct resource *ioapic_resources;
=20
 static struct resource * __init ioapic_setup_resources(void)
 {
-	unsigned long n;
 	struct resource *res;
+	unsigned long n;
 	char *mem;
 	int i;
=20
@@ -2686,9 +2553,7 @@ void __init io_apic_init_mappings(void)
 			ioapic_phys =3D mpc_ioapic_addr(i);
 #ifdef CONFIG_X86_32
 			if (!ioapic_phys) {
-				printk(KERN_ERR
-				       "WARNING: bogus zero IO-APIC "
-				       "address found in MPTABLE, "
+				pr_err("WARNING: bogus zero IO-APIC address found in MPTABLE, "
 				       "disabling IO/APIC support!\n");
 				smp_found_config =3D 0;
 				ioapic_is_disabled =3D true;
@@ -2707,9 +2572,8 @@ void __init io_apic_init_mappings(void)
 			ioapic_phys =3D __pa(ioapic_phys);
 		}
 		io_apic_set_fixmap(idx, ioapic_phys);
-		apic_printk(APIC_VERBOSE, "mapped IOAPIC to %08lx (%08lx)\n",
-			__fix_to_virt(idx) + (ioapic_phys & ~PAGE_MASK),
-			ioapic_phys);
+		apic_pr_verbose("mapped IOAPIC to %08lx (%08lx)\n",
+				__fix_to_virt(idx) + (ioapic_phys & ~PAGE_MASK), ioapic_phys);
 		idx++;
=20
 		ioapic_res->start =3D ioapic_phys;
@@ -2720,13 +2584,12 @@ void __init io_apic_init_mappings(void)
=20
 void __init ioapic_insert_resources(void)
 {
-	int i;
 	struct resource *r =3D ioapic_resources;
+	int i;
=20
 	if (!r) {
 		if (nr_ioapics > 0)
-			printk(KERN_ERR
-				"IO APIC resources couldn't be allocated.\n");
+			pr_err("IO APIC resources couldn't be allocated.\n");
 		return;
 	}
=20
@@ -2746,11 +2609,12 @@ int mp_find_ioapic(u32 gsi)
 	/* Find the IOAPIC that manages this GSI. */
 	for_each_ioapic(i) {
 		struct mp_ioapic_gsi *gsi_cfg =3D mp_ioapic_gsi_routing(i);
+
 		if (gsi >=3D gsi_cfg->gsi_base && gsi <=3D gsi_cfg->gsi_end)
 			return i;
 	}
=20
-	printk(KERN_ERR "ERROR: Unable to locate IOAPIC for GSI %d\n", gsi);
+	pr_err("ERROR: Unable to locate IOAPIC for GSI %d\n", gsi);
 	return -1;
 }
=20
@@ -2789,12 +2653,10 @@ static int bad_ioapic_register(int idx)
=20
 static int find_free_ioapic_entry(void)
 {
-	int idx;
-
-	for (idx =3D 0; idx < MAX_IO_APICS; idx++)
+	for (int idx =3D 0; idx < MAX_IO_APICS; idx++) {
 		if (ioapics[idx].nr_registers =3D=3D 0)
 			return idx;
-
+	}
 	return MAX_IO_APICS;
 }
=20
@@ -2805,8 +2667,7 @@ static int find_free_ioapic_entry(void)
  * @gsi_base:	base of GSI associated with the IOAPIC
  * @cfg:	configuration information for the IOAPIC
  */
-int mp_register_ioapic(int id, u32 address, u32 gsi_base,
-		       struct ioapic_domain_cfg *cfg)
+int mp_register_ioapic(int id, u32 address, u32 gsi_base, struct ioapic_doma=
in_cfg *cfg)
 {
 	bool hotplug =3D !!ioapic_initialized;
 	struct mp_ioapic_gsi *gsi_cfg;
@@ -2817,12 +2678,13 @@ int mp_register_ioapic(int id, u32 address, u32 gsi_b=
ase,
 		pr_warn("Bogus (zero) I/O APIC address found, skipping!\n");
 		return -EINVAL;
 	}
-	for_each_ioapic(ioapic)
+
+	for_each_ioapic(ioapic) {
 		if (ioapics[ioapic].mp_config.apicaddr =3D=3D address) {
-			pr_warn("address 0x%x conflicts with IOAPIC%d\n",
-				address, ioapic);
+			pr_warn("address 0x%x conflicts with IOAPIC%d\n", address, ioapic);
 			return -EEXIST;
 		}
+	}
=20
 	idx =3D find_free_ioapic_entry();
 	if (idx >=3D MAX_IO_APICS) {
@@ -2857,8 +2719,7 @@ int mp_register_ioapic(int id, u32 address, u32 gsi_bas=
e,
 		    (gsi_end >=3D gsi_cfg->gsi_base &&
 		     gsi_end <=3D gsi_cfg->gsi_end)) {
 			pr_warn("GSI range [%u-%u] for new IOAPIC conflicts with GSI[%u-%u]\n",
-				gsi_base, gsi_end,
-				gsi_cfg->gsi_base, gsi_cfg->gsi_end);
+				gsi_base, gsi_end, gsi_cfg->gsi_base, gsi_cfg->gsi_end);
 			clear_fixmap(FIX_IO_APIC_BASE_0 + idx);
 			return -ENOSPC;
 		}
@@ -2892,8 +2753,7 @@ int mp_register_ioapic(int id, u32 address, u32 gsi_bas=
e,
 	ioapics[idx].nr_registers =3D entries;
=20
 	pr_info("IOAPIC[%d]: apic_id %d, version %d, address 0x%x, GSI %d-%d\n",
-		idx, mpc_ioapic_id(idx),
-		mpc_ioapic_ver(idx), mpc_ioapic_addr(idx),
+		idx, mpc_ioapic_id(idx), mpc_ioapic_ver(idx), mpc_ioapic_addr(idx),
 		gsi_cfg->gsi_base, gsi_cfg->gsi_end);
=20
 	return 0;
@@ -2904,11 +2764,13 @@ int mp_unregister_ioapic(u32 gsi_base)
 	int ioapic, pin;
 	int found =3D 0;
=20
-	for_each_ioapic(ioapic)
+	for_each_ioapic(ioapic) {
 		if (ioapics[ioapic].gsi_config.gsi_base =3D=3D gsi_base) {
 			found =3D 1;
 			break;
 		}
+	}
+
 	if (!found) {
 		pr_warn("can't find IOAPIC for GSI %d\n", gsi_base);
 		return -ENODEV;
@@ -2922,8 +2784,7 @@ int mp_unregister_ioapic(u32 gsi_base)
 		if (irq >=3D 0) {
 			data =3D irq_get_chip_data(irq);
 			if (data && data->count) {
-				pr_warn("pin%d on IOAPIC%d is still in use.\n",
-					pin, ioapic);
+				pr_warn("pin%d on IOAPIC%d is still in use.\n",	pin, ioapic);
 				return -EBUSY;
 			}
 		}
@@ -2958,8 +2819,7 @@ static void mp_irqdomain_get_attr(u32 gsi, struct mp_ch=
ip_data *data,
 	if (info && info->ioapic.valid) {
 		data->is_level =3D info->ioapic.is_level;
 		data->active_low =3D info->ioapic.active_low;
-	} else if (__acpi_get_override_irq(gsi, &data->is_level,
-					   &data->active_low) < 0) {
+	} else if (__acpi_get_override_irq(gsi, &data->is_level, &data->active_low)=
 < 0) {
 		/* PCI interrupts are always active low level triggered. */
 		data->is_level =3D true;
 		data->active_low =3D true;
@@ -3017,10 +2877,8 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsi=
gned int virq,
 		return -ENOMEM;
=20
 	ret =3D irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, info);
-	if (ret < 0) {
-		kfree(data);
-		return ret;
-	}
+	if (ret < 0)
+		goto free_data;
=20
 	INIT_LIST_HEAD(&data->irq_2_pin);
 	irq_data->hwirq =3D info->ioapic.pin;
@@ -3029,7 +2887,10 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsi=
gned int virq,
 	irq_data->chip_data =3D data;
 	mp_irqdomain_get_attr(mp_pin_to_gsi(ioapic, pin), data, info);
=20
-	add_pin_to_irq_node(data, ioapic_alloc_attr_node(info), ioapic, pin);
+	if (!add_pin_to_irq_node(data, ioapic_alloc_attr_node(info), ioapic, pin)) {
+		ret =3D -ENOMEM;
+		goto free_irqs;
+	}
=20
 	mp_preconfigure_entry(data);
 	mp_register_handler(virq, data->is_level);
@@ -3039,11 +2900,15 @@ int mp_irqdomain_alloc(struct irq_domain *domain, uns=
igned int virq,
 		legacy_pic->mask(virq);
 	local_irq_restore(flags);
=20
-	apic_printk(APIC_VERBOSE, KERN_DEBUG
-		    "IOAPIC[%d]: Preconfigured routing entry (%d-%d -> IRQ %d Level:%i Act=
iveLow:%i)\n",
-		    ioapic, mpc_ioapic_id(ioapic), pin, virq,
-		    data->is_level, data->active_low);
+	apic_pr_verbose("IOAPIC[%d]: Preconfigured routing entry (%d-%d -> IRQ %d L=
evel:%i ActiveLow:%i)\n",
+			ioapic, mpc_ioapic_id(ioapic), pin, virq, data->is_level, data->active_lo=
w);
 	return 0;
+
+free_irqs:
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+free_data:
+	kfree(data);
+	return ret;
 }
=20
 void mp_irqdomain_free(struct irq_domain *domain, unsigned int virq,
@@ -3056,22 +2921,17 @@ void mp_irqdomain_free(struct irq_domain *domain, uns=
igned int virq,
 	irq_data =3D irq_domain_get_irq_data(domain, virq);
 	if (irq_data && irq_data->chip_data) {
 		data =3D irq_data->chip_data;
-		__remove_pin_from_irq(data, mp_irqdomain_ioapic_idx(domain),
-				      (int)irq_data->hwirq);
+		__remove_pin_from_irq(data, mp_irqdomain_ioapic_idx(domain), (int)irq_data=
->hwirq);
 		WARN_ON(!list_empty(&data->irq_2_pin));
 		kfree(irq_data->chip_data);
 	}
 	irq_domain_free_irqs_top(domain, virq, nr_irqs);
 }
=20
-int mp_irqdomain_activate(struct irq_domain *domain,
-			  struct irq_data *irq_data, bool reserve)
+int mp_irqdomain_activate(struct irq_domain *domain, struct irq_data *irq_da=
ta, bool reserve)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	guard(raw_spinlock_irqsave)(&ioapic_lock);
 	ioapic_configure_entry(irq_data);
-	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 	return 0;
 }
=20
@@ -3079,8 +2939,7 @@ void mp_irqdomain_deactivate(struct irq_domain *domain,
 			     struct irq_data *irq_data)
 {
 	/* It won't be called for IRQ with multiple IOAPIC pins associated */
-	ioapic_mask_entry(mp_irqdomain_ioapic_idx(domain),
-			  (int)irq_data->hwirq);
+	ioapic_mask_entry(mp_irqdomain_ioapic_idx(domain), (int)irq_data->hwirq);
 }
=20
 int mp_irqdomain_ioapic_idx(struct irq_domain *domain)
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index e89171b0347a..4a1b1b28abf9 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -68,7 +68,7 @@ static void __init mpc_oem_bus_info(struct mpc_bus *m, char=
 *str)
 {
 	memcpy(str, m->bustype, 6);
 	str[6] =3D 0;
-	apic_printk(APIC_VERBOSE, "Bus #%d is %s\n", m->busid, str);
+	apic_pr_verbose("Bus #%d is %s\n", m->busid, str);
 }
=20
 static void __init MP_bus_info(struct mpc_bus *m)
@@ -417,7 +417,7 @@ static unsigned long __init get_mpc_size(unsigned long ph=
ysptr)
 	mpc =3D early_memremap(physptr, PAGE_SIZE);
 	size =3D mpc->length;
 	early_memunmap(mpc, PAGE_SIZE);
-	apic_printk(APIC_VERBOSE, "  mpc: %lx-%lx\n", physptr, physptr + size);
+	apic_pr_verbose("  mpc: %lx-%lx\n", physptr, physptr + size);
=20
 	return size;
 }
@@ -560,8 +560,7 @@ static int __init smp_scan_config(unsigned long base, uns=
igned long length)
 	struct mpf_intel *mpf;
 	int ret =3D 0;
=20
-	apic_printk(APIC_VERBOSE, "Scan for SMP in [mem %#010lx-%#010lx]\n",
-		    base, base + length - 1);
+	apic_pr_verbose("Scan for SMP in [mem %#010lx-%#010lx]\n", base, base + len=
gth - 1);
 	BUILD_BUG_ON(sizeof(*mpf) !=3D 16);
=20
 	while (length > 0) {
@@ -683,13 +682,13 @@ static void __init check_irq_src(struct mpc_intsrc *m, =
int *nr_m_spare)
 {
 	int i;
=20
-	apic_printk(APIC_VERBOSE, "OLD ");
+	apic_pr_verbose("OLD ");
 	print_mp_irq_info(m);
=20
 	i =3D get_MP_intsrc_index(m);
 	if (i > 0) {
 		memcpy(m, &mp_irqs[i], sizeof(*m));
-		apic_printk(APIC_VERBOSE, "NEW ");
+		apic_pr_verbose("NEW ");
 		print_mp_irq_info(&mp_irqs[i]);
 		return;
 	}
@@ -772,7 +771,7 @@ static int  __init replace_intsrc_all(struct mpc_table *m=
pc,
 			continue;
=20
 		if (nr_m_spare > 0) {
-			apic_printk(APIC_VERBOSE, "*NEW* found\n");
+			apic_pr_verbose("*NEW* found\n");
 			nr_m_spare--;
 			memcpy(m_spare[nr_m_spare], &mp_irqs[i], sizeof(mp_irqs[i]));
 			m_spare[nr_m_spare] =3D NULL;
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_re=
mapping.c
index e090ca07364b..7a6d188e3bea 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1352,12 +1352,11 @@ static void intel_irq_remapping_prepare_irte(struct i=
ntel_ir_data *data,
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
 		/* Set source-id of interrupt request */
 		set_ioapic_sid(irte, info->devid);
-		apic_printk(APIC_VERBOSE, KERN_DEBUG "IOAPIC[%d]: Set IRTE entry (P:%d FPD=
:%d Dst_Mode:%d Redir_hint:%d Trig_Mode:%d Dlvry_Mode:%X Avail:%X Vector:%02X=
 Dest:%08X SID:%04X SQ:%X SVT:%X)\n",
-			info->devid, irte->present, irte->fpd,
-			irte->dst_mode, irte->redir_hint,
-			irte->trigger_mode, irte->dlvry_mode,
-			irte->avail, irte->vector, irte->dest_id,
-			irte->sid, irte->sq, irte->svt);
+		apic_pr_verbose("IOAPIC[%d]: Set IRTE entry (P:%d FPD:%d Dst_Mode:%d Redir=
_hint:%d Trig_Mode:%d Dlvry_Mode:%X Avail:%X Vector:%02X Dest:%08X SID:%04X S=
Q:%X SVT:%X)\n",
+				info->devid, irte->present, irte->fpd, irte->dst_mode,
+				irte->redir_hint, irte->trigger_mode, irte->dlvry_mode,
+				irte->avail, irte->vector, irte->dest_id, irte->sid,
+				irte->sq, irte->svt);
 		sub_handle =3D info->ioapic.pin;
 		break;
 	case X86_IRQ_ALLOC_TYPE_HPET:


