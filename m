Return-Path: <linux-kernel+bounces-331484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE0497AD63
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D286A1F232B9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F60E18893E;
	Tue, 17 Sep 2024 08:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DN/i0HTK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5BkVwM+C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D70183CDF
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563263; cv=none; b=rs4gKAB3CFaHJaNz5V8lwABVYmpNPl1KkcruhEQhVdkwVV1rOyBHWFhmajRkEXEn5VlD877lj4r1cWRljKgWudcT5IjqQWG4hl6vTK5Z2VB5PIMXaqEJqnzxgWf/0XMaUaBc2WQtAVn7f7WE/qgMFnKF/js9yThHOs2qMBrsHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563263; c=relaxed/simple;
	bh=v0lOdPJ7gvFUbjhUVktlqKRtaG9LMiPiIAmNVDM/JfY=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=TgHR3wmy6HNaAMs0dLttNBd1w+LKKB9r/gYJKuPV8lnV0l9yttlrjMlzPvGpFlHwngRf8Ujz/UBU4MOKf6/JmR1ufgboP/s0mj09xA6xAzFFIGxepZcl+ixAQEYx26Y0TzYSxz80LFipcSgdhRg6ugqa/B0T5fCLn/xmWKoAR8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DN/i0HTK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5BkVwM+C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726563259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=ew3H85WX4TlruJoYHBQJyIREKWRq+p6zpooK2vLDW84=;
	b=DN/i0HTK5g+TBjUVmUI3JWWvCbOhINp/M+HiY7IW50M+DnDnOaefEYFHmhl5uQu6jPFOcN
	bxIgQ+VdvURK3h5c3CnnQ66/NOcFe+BCAEchVepY/wFF+M7y57/PdoYn9BB68FRxslRipV
	T1Y09g7gR+hiWK6jMyxsfruJNiCFU3hzYnBFCkhnZCC1TDczJH+zzai3zSpQHxOOkxJ6j2
	YwtwPehSgbJD8AkhxmUfSDSDwgj3OTWK/ruEt56nosB40QIiXKYeLglC6iRSIUGWI166s/
	zyVKBaxuTdoPTv/1l3JdIyoxC6Dw7VK9GsLzmyk6yeJ1Re8gS+KPnMsIr/XMyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726563259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=ew3H85WX4TlruJoYHBQJyIREKWRq+p6zpooK2vLDW84=;
	b=5BkVwM+CgSIy1ENRVPAGDlAMP511cUMnrGHJm95aa7i1LXxCdA1PzN6vKjZyHgbJ8QPcw0
	fRzXaR/G1uB8M/AA==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/timers for v6.12-rc1
References: <172656198112.2471820.6226852046770294674.tglx@xen13>
Message-ID: <172656199565.2471820.2194273071925899062.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Sep 2024 10:54:19 +0200 (CEST)

Linus,

please pull the latest x86/timers branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-timers-2024-=
09-17

up to:  e7ff4ebffe3b: x86/tsc: Check for sockets instead of CPUs to make code=
 match comment

Updates for x86 timers:

  - Use the topology information of number of packages for making the
    decision about TSC trust instead of using the number of online nodes
    which is not reflecting the real topology.

  - Stop the PIT timer 0 when its not in use as to stop pointless emulation
    in the VMM.

  - Fix the PIT timer stop sequence for timer 0 so it truly stops both real
    hardware and buggy VMM emulations.

Thanks,

	tglx

------------------>
David Woodhouse (2):
      x86/i8253: Disable PIT timer 0 when not in use
      clockevents/drivers/i8253: Fix stop sequence for timer 0

Feng Tang (1):
      x86/tsc: Use topology_max_packages() to get package number

Paul E. McKenney (1):
      x86/tsc: Check for sockets instead of CPUs to make code match comment


 arch/x86/kernel/cpu/mshyperv.c | 11 ----------
 arch/x86/kernel/i8253.c        | 11 ++++++++--
 arch/x86/kernel/tsc.c          | 10 ++++-----
 drivers/clocksource/i8253.c    | 49 +++++++++++++++++++++++++++++-----------=
--
 include/linux/i8253.h          |  2 +-
 5 files changed, 48 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e0fd57a8ba84..3d4237f27569 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -16,7 +16,6 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kexec.h>
-#include <linux/i8253.h>
 #include <linux/random.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
@@ -522,16 +521,6 @@ static void __init ms_hyperv_init_platform(void)
 	if (efi_enabled(EFI_BOOT))
 		x86_platform.get_nmi_reason =3D hv_get_nmi_reason;
=20
-	/*
-	 * Hyper-V VMs have a PIT emulation quirk such that zeroing the
-	 * counter register during PIT shutdown restarts the PIT. So it
-	 * continues to interrupt @18.2 HZ. Setting i8253_clear_counter
-	 * to false tells pit_shutdown() not to zero the counter so that
-	 * the PIT really is shutdown. Generation 2 VMs don't have a PIT,
-	 * and setting this value has no effect.
-	 */
-	i8253_clear_counter_on_shutdown =3D false;
-
 #if IS_ENABLED(CONFIG_HYPERV)
 	if ((hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_VBS) ||
 	    ms_hyperv.paravisor_present)
diff --git a/arch/x86/kernel/i8253.c b/arch/x86/kernel/i8253.c
index 2b7999a1a50a..80e262bb627f 100644
--- a/arch/x86/kernel/i8253.c
+++ b/arch/x86/kernel/i8253.c
@@ -8,6 +8,7 @@
 #include <linux/timex.h>
 #include <linux/i8253.h>
=20
+#include <asm/hypervisor.h>
 #include <asm/apic.h>
 #include <asm/hpet.h>
 #include <asm/time.h>
@@ -39,9 +40,15 @@ static bool __init use_pit(void)
=20
 bool __init pit_timer_init(void)
 {
-	if (!use_pit())
+	if (!use_pit()) {
+		/*
+		 * Don't just ignore the PIT. Ensure it's stopped, because
+		 * VMMs otherwise steal CPU time just to pointlessly waggle
+		 * the (masked) IRQ.
+		 */
+		clockevent_i8253_disable();
 		return false;
-
+	}
 	clockevent_i8253_init(true);
 	global_clock_event =3D &i8253_clockevent;
 	return true;
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index d4462fb26299..dfe6847fd99e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -28,6 +28,7 @@
 #include <asm/apic.h>
 #include <asm/cpu_device_id.h>
 #include <asm/i8259.h>
+#include <asm/topology.h>
 #include <asm/uv/uv.h>
=20
 unsigned int __read_mostly cpu_khz;	/* TSC clocks / usec, not used here */
@@ -1253,15 +1254,12 @@ static void __init check_system_tsc_reliable(void)
 	 *  - TSC which does not stop in C-States
 	 *  - the TSC_ADJUST register which allows to detect even minimal
 	 *    modifications
-	 *  - not more than two sockets. As the number of sockets cannot be
-	 *    evaluated at the early boot stage where this has to be
-	 *    invoked, check the number of online memory nodes as a
-	 *    fallback solution which is an reasonable estimate.
+	 *  - not more than four packages
 	 */
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
 	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
 	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
-	    nr_online_nodes <=3D 4)
+	    topology_max_packages() <=3D 4)
 		tsc_disable_clocksource_watchdog();
 }
=20
@@ -1290,7 +1288,7 @@ int unsynchronized_tsc(void)
 	 */
 	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_INTEL) {
 		/* assume multi socket systems are not synchronized: */
-		if (num_possible_cpus() > 1)
+		if (topology_max_packages() > 1)
 			return 1;
 	}
=20
diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index d4350bb10b83..39f7c2d736d1 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -20,13 +20,6 @@
 DEFINE_RAW_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
=20
-/*
- * Handle PIT quirk in pit_shutdown() where zeroing the counter register
- * restarts the PIT, negating the shutdown. On platforms with the quirk,
- * platform specific code can set this to false.
- */
-bool i8253_clear_counter_on_shutdown __ro_after_init =3D true;
-
 #ifdef CONFIG_CLKSRC_I8253
 /*
  * Since the PIT overflows every tick, its not very useful
@@ -108,21 +101,47 @@ int __init clocksource_i8253_init(void)
 #endif
=20
 #ifdef CONFIG_CLKEVT_I8253
-static int pit_shutdown(struct clock_event_device *evt)
+void clockevent_i8253_disable(void)
 {
-	if (!clockevent_state_oneshot(evt) && !clockevent_state_periodic(evt))
-		return 0;
-
 	raw_spin_lock(&i8253_lock);
=20
+	/*
+	 * Writing the MODE register should stop the counter, according to
+	 * the datasheet. This appears to work on real hardware (well, on
+	 * modern Intel and AMD boxes; I didn't dig the Pegasos out of the
+	 * shed).
+	 *
+	 * However, some virtual implementations differ, and the MODE change
+	 * doesn't have any effect until either the counter is written (KVM
+	 * in-kernel PIT) or the next interrupt (QEMU). And in those cases,
+	 * it may not stop the *count*, only the interrupts. Although in
+	 * the virt case, that probably doesn't matter, as the value of the
+	 * counter will only be calculated on demand if the guest reads it;
+	 * it's the interrupts which cause steal time.
+	 *
+	 * Hyper-V apparently has a bug where even in mode 0, the IRQ keeps
+	 * firing repeatedly if the counter is running. But it *does* do the
+	 * right thing when the MODE register is written.
+	 *
+	 * So: write the MODE and then load the counter, which ensures that
+	 * the IRQ is stopped on those buggy virt implementations. And then
+	 * write the MODE again, which is the right way to stop it.
+	 */
 	outb_p(0x30, PIT_MODE);
+	outb_p(0, PIT_CH0);
+	outb_p(0, PIT_CH0);
=20
-	if (i8253_clear_counter_on_shutdown) {
-		outb_p(0, PIT_CH0);
-		outb_p(0, PIT_CH0);
-	}
+	outb_p(0x30, PIT_MODE);
=20
 	raw_spin_unlock(&i8253_lock);
+}
+
+static int pit_shutdown(struct clock_event_device *evt)
+{
+	if (!clockevent_state_oneshot(evt) && !clockevent_state_periodic(evt))
+		return 0;
+
+	clockevent_i8253_disable();
 	return 0;
 }
=20
diff --git a/include/linux/i8253.h b/include/linux/i8253.h
index 8336b2f6f834..56c280eb2d4f 100644
--- a/include/linux/i8253.h
+++ b/include/linux/i8253.h
@@ -21,9 +21,9 @@
 #define PIT_LATCH	((PIT_TICK_RATE + HZ/2) / HZ)
=20
 extern raw_spinlock_t i8253_lock;
-extern bool i8253_clear_counter_on_shutdown;
 extern struct clock_event_device i8253_clockevent;
 extern void clockevent_i8253_init(bool oneshot);
+extern void clockevent_i8253_disable(void);
=20
 extern void setup_pit_timer(void);
=20


