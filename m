Return-Path: <linux-kernel+bounces-272834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E079461B0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489BA1C210B0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567C7166F1B;
	Fri,  2 Aug 2024 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0CuGRzeu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bg5DIahB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CEC1537DD
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615346; cv=none; b=u5d8drPKI67CmymGE9PIGw0cgANsY1TC3NMLb4M8qUIrr1L+KiXeH7IzudqrjUueRqehXYcNhVohwTe5LA0E9ngmZ1775X/cGOa7aZRVCWE0+tY3pcJscr5VY/5J1a6zkDEMUDi9+v6HHqs8XJdyrid2sdkt/GoKunT7Alfj73k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615346; c=relaxed/simple;
	bh=JfLIm3AgtoiH6DMCBkZMSWWLsWmWfO/VSShxSULhPAE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=QRgd4ePIUgAZ+6r0f32f9q0Rkq/Koq0M0mJeJx6OMMNOvUM9YWC0B2nbZea2jYnvQ+29/KPHbmha4tmfz2hFrCf4pA7Ch6y0FlL1QWEWy6GmS5GkkO/+Ed4FocowmA69XCFALIjllEObcuK1C1uHkgwW+VGHkPkL2mcbtUiCU8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0CuGRzeu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bg5DIahB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240802155440.589821068@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722615341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lCvkAigTlvnFjCeCyGJ6ZWYJAg8BjhRd+upNYUEttLE=;
	b=0CuGRzeuEDY4GY5m9FV8augLhw3s1rihawDkmYKbOVThUF6IWOeQv6N0OTaw4+VSb4Vwk3
	p2UHHRSuyIn3xrUKIhjP0h9pH3lvAF2KQPX7T5JQX0FAfIq42gWFIur8omeesTGR7uBiH/
	VWE3Ngl4JAl/e8h+NYAAGbdvk6gt4qb4n7azAIEART/j2MiG1kdRi/DsP57xPOgiTA3D4k
	0zTxOHjs+p97EMIiItwkUKgvv0/i7+DARPocUMr9wxrfwXDe6F+ILi0eXCN4TNJsHKTtNZ
	YBfCWmNiGah5RAEUv3xIps2WdSOQv+3lVOTVQG5OfNScRVSEGVAPMvpSo9k3nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722615341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lCvkAigTlvnFjCeCyGJ6ZWYJAg8BjhRd+upNYUEttLE=;
	b=Bg5DIahBaczWJdlUMn/rtBuRilettrj7Ddo9gLv5rUgY1Q4MVvXpiiQVu2x9tujJm+q2oS
	cR5orcFagrORX3DQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org
Subject: [patch 06/15] x86/apic: Cleanup apic_printk()s
References: <20240802155038.556977544@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  2 Aug 2024 18:15:41 +0200 (CEST)

Use the new apic_pr_*() helpers and cleanup the apic_printk() maze.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/apic.c |   81 +++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 46 deletions(-)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -677,7 +677,7 @@ calibrate_by_pmtimer(u32 deltapm, long *
 	return -1;
 #endif
 
-	apic_printk(APIC_VERBOSE, "... PM-Timer delta = %u\n", deltapm);
+	apic_pr_verbose("... PM-Timer delta = %u\n", deltapm);
 
 	/* Check, if the PM timer is available */
 	if (!deltapm)
@@ -687,14 +687,14 @@ calibrate_by_pmtimer(u32 deltapm, long *
 
 	if (deltapm > (pm_100ms - pm_thresh) &&
 	    deltapm < (pm_100ms + pm_thresh)) {
-		apic_printk(APIC_VERBOSE, "... PM-Timer result ok\n");
+		apic_pr_verbose("... PM-Timer result ok\n");
 		return 0;
 	}
 
 	res = (((u64)deltapm) *  mult) >> 22;
 	do_div(res, 1000000);
-	pr_warn("APIC calibration not consistent "
-		"with PM-Timer: %ldms instead of 100ms\n", (long)res);
+	pr_warn("APIC calibration not consistent with PM-Timer: %ldms instead of 100ms\n",
+		(long)res);
 
 	/* Correct the lapic counter value */
 	res = (((u64)(*delta)) * pm_100ms);
@@ -707,9 +707,8 @@ calibrate_by_pmtimer(u32 deltapm, long *
 	if (boot_cpu_has(X86_FEATURE_TSC)) {
 		res = (((u64)(*deltatsc)) * pm_100ms);
 		do_div(res, deltapm);
-		apic_printk(APIC_VERBOSE, "TSC delta adjusted to "
-					  "PM-Timer: %lu (%ld)\n",
-					(unsigned long)res, *deltatsc);
+		apic_pr_verbose("TSC delta adjusted to PM-Timer: %lu (%ld)\n",
+				(unsigned long)res, *deltatsc);
 		*deltatsc = (long)res;
 	}
 
@@ -792,8 +791,7 @@ static int __init calibrate_APIC_clock(v
 	 * in the clockevent structure and return.
 	 */
 	if (!lapic_init_clockevent()) {
-		apic_printk(APIC_VERBOSE, "lapic timer already calibrated %d\n",
-			    lapic_timer_period);
+		apic_pr_verbose("lapic timer already calibrated %d\n", lapic_timer_period);
 		/*
 		 * Direct calibration methods must have an always running
 		 * local APIC timer, no need for broadcast timer.
@@ -802,8 +800,7 @@ static int __init calibrate_APIC_clock(v
 		return 0;
 	}
 
-	apic_printk(APIC_VERBOSE, "Using local APIC timer interrupts.\n"
-		    "calibrating APIC timer ...\n");
+	apic_pr_verbose("Using local APIC timer interrupts. Calibrating APIC timer ...\n");
 
 	/*
 	 * There are platforms w/o global clockevent devices. Instead of
@@ -866,7 +863,7 @@ static int __init calibrate_APIC_clock(v
 
 	/* Build delta t1-t2 as apic timer counts down */
 	delta = lapic_cal_t1 - lapic_cal_t2;
-	apic_printk(APIC_VERBOSE, "... lapic delta = %ld\n", delta);
+	apic_pr_verbose("... lapic delta = %ld\n", delta);
 
 	deltatsc = (long)(lapic_cal_tsc2 - lapic_cal_tsc1);
 
@@ -877,22 +874,19 @@ static int __init calibrate_APIC_clock(v
 	lapic_timer_period = (delta * APIC_DIVISOR) / LAPIC_CAL_LOOPS;
 	lapic_init_clockevent();
 
-	apic_printk(APIC_VERBOSE, "..... delta %ld\n", delta);
-	apic_printk(APIC_VERBOSE, "..... mult: %u\n", lapic_clockevent.mult);
-	apic_printk(APIC_VERBOSE, "..... calibration result: %u\n",
-		    lapic_timer_period);
+	apic_pr_verbose("..... delta %ld\n", delta);
+	apic_pr_verbose("..... mult: %u\n", lapic_clockevent.mult);
+	apic_pr_verbose("..... calibration result: %u\n", lapic_timer_period);
 
 	if (boot_cpu_has(X86_FEATURE_TSC)) {
-		apic_printk(APIC_VERBOSE, "..... CPU clock speed is "
-			    "%ld.%04ld MHz.\n",
-			    (deltatsc / LAPIC_CAL_LOOPS) / (1000000 / HZ),
-			    (deltatsc / LAPIC_CAL_LOOPS) % (1000000 / HZ));
+		apic_pr_verbose("..... CPU clock speed is %ld.%04ld MHz.\n",
+				(deltatsc / LAPIC_CAL_LOOPS) / (1000000 / HZ),
+				(deltatsc / LAPIC_CAL_LOOPS) % (1000000 / HZ));
 	}
 
-	apic_printk(APIC_VERBOSE, "..... host bus clock speed is "
-		    "%u.%04u MHz.\n",
-		    lapic_timer_period / (1000000 / HZ),
-		    lapic_timer_period % (1000000 / HZ));
+	apic_pr_verbose("..... host bus clock speed is %u.%04u MHz.\n",
+			lapic_timer_period / (1000000 / HZ),
+			lapic_timer_period % (1000000 / HZ));
 
 	/*
 	 * Do a sanity check on the APIC calibration result
@@ -911,7 +905,7 @@ static int __init calibrate_APIC_clock(v
 	 * available.
 	 */
 	if (!pm_referenced && global_clock_event) {
-		apic_printk(APIC_VERBOSE, "... verify APIC timer\n");
+		apic_pr_verbose("... verify APIC timer\n");
 
 		/*
 		 * Setup the apic timer manually
@@ -932,11 +926,11 @@ static int __init calibrate_APIC_clock(v
 
 		/* Jiffies delta */
 		deltaj = lapic_cal_j2 - lapic_cal_j1;
-		apic_printk(APIC_VERBOSE, "... jiffies delta = %lu\n", deltaj);
+		apic_pr_verbose("... jiffies delta = %lu\n", deltaj);
 
 		/* Check, if the jiffies result is consistent */
 		if (deltaj >= LAPIC_CAL_LOOPS-2 && deltaj <= LAPIC_CAL_LOOPS+2)
-			apic_printk(APIC_VERBOSE, "... jiffies result ok\n");
+			apic_pr_verbose("... jiffies result ok\n");
 		else
 			levt->features |= CLOCK_EVT_FEAT_DUMMY;
 	}
@@ -1221,9 +1215,8 @@ void __init sync_Arb_IDs(void)
 	 */
 	apic_wait_icr_idle();
 
-	apic_printk(APIC_DEBUG, "Synchronizing Arb IDs.\n");
-	apic_write(APIC_ICR, APIC_DEST_ALLINC |
-			APIC_INT_LEVELTRIG | APIC_DM_INIT);
+	apic_pr_debug("Synchronizing Arb IDs.\n");
+	apic_write(APIC_ICR, APIC_DEST_ALLINC | APIC_INT_LEVELTRIG | APIC_DM_INIT);
 }
 
 enum apic_intr_mode_id apic_intr_mode __ro_after_init;
@@ -1409,10 +1402,10 @@ static void lapic_setup_esr(void)
 	if (maxlvt > 3)
 		apic_write(APIC_ESR, 0);
 	value = apic_read(APIC_ESR);
-	if (value != oldvalue)
-		apic_printk(APIC_VERBOSE, "ESR value before enabling "
-			"vector: 0x%08x  after: 0x%08x\n",
-			oldvalue, value);
+	if (value != oldvalue) {
+		apic_pr_verbose("ESR value before enabling vector: 0x%08x  after: 0x%08x\n",
+				oldvalue, value);
+	}
 }
 
 #define APIC_IR_REGS		APIC_ISR_NR
@@ -1599,10 +1592,10 @@ static void setup_local_APIC(void)
 	value = apic_read(APIC_LVT0) & APIC_LVT_MASKED;
 	if (!cpu && (pic_mode || !value || ioapic_is_disabled)) {
 		value = APIC_DM_EXTINT;
-		apic_printk(APIC_VERBOSE, "enabled ExtINT on CPU#%d\n", cpu);
+		apic_pr_verbose("Enabled ExtINT on CPU#%d\n", cpu);
 	} else {
 		value = APIC_DM_EXTINT | APIC_LVT_MASKED;
-		apic_printk(APIC_VERBOSE, "masked ExtINT on CPU#%d\n", cpu);
+		apic_pr_verbose("Masked ExtINT on CPU#%d\n", cpu);
 	}
 	apic_write(APIC_LVT0, value);
 
@@ -2066,8 +2059,7 @@ static __init void apic_set_fixmap(bool
 {
 	set_fixmap_nocache(FIX_APIC_BASE, mp_lapic_addr);
 	apic_mmio_base = APIC_BASE;
-	apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n",
-		    apic_mmio_base, mp_lapic_addr);
+	apic_pr_verbose("Mapped APIC to %16lx (%16lx)\n", apic_mmio_base, mp_lapic_addr);
 	if (read_apic)
 		apic_read_boot_cpu_id(false);
 }
@@ -2170,18 +2162,17 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_error_inte
 	apic_eoi();
 	atomic_inc(&irq_err_count);
 
-	apic_printk(APIC_DEBUG, KERN_DEBUG "APIC error on CPU%d: %02x",
-		    smp_processor_id(), v);
+	apic_pr_debug("APIC error on CPU%d: %02x", smp_processor_id(), v);
 
 	v &= 0xff;
 	while (v) {
 		if (v & 0x1)
-			apic_printk(APIC_DEBUG, KERN_CONT " : %s", error_interrupt_reason[i]);
+			apic_pr_debug_cont(" : %s", error_interrupt_reason[i]);
 		i++;
 		v >>= 1;
 	}
 
-	apic_printk(APIC_DEBUG, KERN_CONT "\n");
+	apic_pr_debug_cont("\n");
 
 	trace_error_apic_exit(ERROR_APIC_VECTOR);
 }
@@ -2201,8 +2192,7 @@ static void __init connect_bsp_APIC(void
 		 * PIC mode, enable APIC mode in the IMCR, i.e.  connect BSP's
 		 * local APIC to INT and NMI lines.
 		 */
-		apic_printk(APIC_VERBOSE, "leaving PIC mode, "
-				"enabling APIC mode.\n");
+		apic_pr_verbose("Leaving PIC mode, enabling APIC mode.\n");
 		imcr_pic_to_apic();
 	}
 #endif
@@ -2227,8 +2217,7 @@ void disconnect_bsp_APIC(int virt_wire_s
 		 * IPIs, won't work beyond this point!  The only exception are
 		 * INIT IPIs.
 		 */
-		apic_printk(APIC_VERBOSE, "disabling APIC mode, "
-				"entering PIC mode.\n");
+		apic_pr_verbose("Disabling APIC mode, entering PIC mode.\n");
 		imcr_apic_to_pic();
 		return;
 	}


