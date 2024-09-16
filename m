Return-Path: <linux-kernel+bounces-330348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 013A5979CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1241C2226E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8ED14A4D4;
	Mon, 16 Sep 2024 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HRDuGcra";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/qJT+N+U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B06613EFF3
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475929; cv=none; b=scEdoqPjluHOC3oJN0fELeW+FcT4gRrxnRn5AtsCv4zDE1GRIl/B9L52dfeO605vgNpPaxEiqZEeGscFkNvUC45WAJaJE2V1IjQAuEk0WfskKpfXmECzeWQ+wIY/wGrpQ+X9pbQO5IsGJswfXH4TrdvNxk4Ibl6a/puLU9y19bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475929; c=relaxed/simple;
	bh=tZ6FR9GZeBQlUzhTM/BS8cRLEyHUnMt0ePxx2gweuYo=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=XvW+Jr6oRoT0LbYGjl7cqM8tNIfqtG9brj+SWgxQWAUyF8jEaDG2ghR3uK4QPhguah6Eb4M9exkSEH9e/ls7ere/7bkD7DIWRl9tFxIVqNuSL4sG27IxSU8aiDXNyuNhp/0gZy8+ZrY0drygYPuF/DufFzY3lSR/lkSOTlGs8nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HRDuGcra; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/qJT+N+U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726475922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=lYrQ2BBujWJpF4TZhtVR4tnmrybNtx30IbfQmOgLv8E=;
	b=HRDuGcraMJ9rPPZlu64ptj2KH+ZM+MBaEcnsCkCzZImsRLc0pW4oX4iIx80rVc8uME1Bf7
	jideF/8+dQmkfyLXhZ7goIqz0SzNgd5vOcJgjY0x78i+fWnUmeaxAKKkg3bKX7XDyOk5zo
	mF//7CTTkUrHr14mApREy4tR/RUM4B7q9iVMdhSr1eCePaydd2tOPEN4BMG4vWF5l83zok
	Wb87KkvrGlvCuLwiPiCNak2xGQJf85/tc57+4NHGuAQzh7xl7S4cIf44VcM0ROuXGSh6va
	+mwhsDDv02L7u6ivvtJ9uqjl2PBtXheuRrwYZT6iKKmpB50ISQr3YbVZmuW/RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726475922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=lYrQ2BBujWJpF4TZhtVR4tnmrybNtx30IbfQmOgLv8E=;
	b=/qJT+N+UPOCd7XLq3+gYBrdOSpoxilbOwDLZGHufHgnjeytXTks5B1n7obrjoOyYxu7vIo
	M0H3pzeAu1eCf7Bw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v6.12-rc1
References: <172647588843.2450257.3544233832195550173.tglx@xen13>
Message-ID: <172647589572.2450257.7902245321154816798.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Sep 2024 10:38:41 +0200 (CEST)

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024=
-09-16

up to:  35b603f8a78b: ntp: Make sure RTC is synchronized when time goes backw=
ards

Updates for timers and timekeeping:

  - Core:

	- Overhaul of posix-timers in preparation of removing the
	  workaround for periodic timers which have signal delivery
	  ignored.

        - Remove the historical extra jiffie in msleep()

	  msleep() adds an extra jiffie to the timeout value to ensure
	  minimal sleep time. The timer wheel ensures minimal sleep
	  time since the large rewrite to a non-cascading wheel, but the
	  extra jiffie in msleep() remained unnoticed. Remove it.

        - Make the timer slack handling correct for realtime tasks.

	  The procfs interface is inconsistent and does neither reflect
	  reality nor conforms to the man page. Show the correct 0 slack
	  for real time tasks and enforce it at the core level instead of
	  having inconsistent individual checks in various timer setup
	  functions.

        - The usual set of updates and enhancements all over the place.

  - Drivers:

        - Allow the ACPI PM timer to be turned off during suspend
=09
	- No new drivers

	- The usual updates and enhancements in various drivers

Thanks,

	tglx

------------------>
Ankit Agrawal (1):
      clocksource/drivers/qcom: Add missing iounmap() on errors in msm_dt_tim=
er_init()

Anna-Maria Behnsen (5):
      timers: Remove historical extra jiffie for timeout in msleep()
      timers: Annotate possible non critical data race of next_expiry
      timers: Rename next_expiry_recalc() to be unique
      cpu: Use already existing usleep_range()
      treewide: Fix wrong singular form of jiffies in comments

Benjamin ROBIN (1):
      ntp: Make sure RTC is synchronized when time goes backwards

Detlev Casanova (1):
      dt-bindings: timer: rockchip: Add rk3576 compatible

Felix Moessbauer (1):
      hrtimer: Use and report correct timerslack values for realtime tasks

Gaosheng Cui (2):
      clocksource/drivers/asm9260: Add missing clk_disable_unprepare in asm92=
60_timer_init
      clocksource/drivers/cadence-ttc: Add missing clk_disable_unprepare in t=
tc_setup_clockevent

Huan Yang (1):
      clocksource/drivers/ingenic: Use devm_clk_get_enabled() helpers

Marek Maslanka (3):
      clocksource: acpi_pm: Add external callback for suspend/resume
      platform/x86:intel/pmc: Enable the ACPI PM Timer to be turned off when =
suspended
      platform/x86:intel/pmc: Fix comment for the pmc_core_acpi_pm_timer_susp=
end_resume function

Sebastian Andrzej Siewior (2):
      timers: Add sparse annotation for timer_sync_wait_running().
      hrtimer: Annotate hrtimer_cpu_base_.*_expiry() for sparse.

Thomas Gleixner (24):
      selftests/timers/posix_timers: Simplify error handling
      selftests/timers/posix_timers: Add SIG_IGN test
      selftests/timers/posix_timers: Validate signal rules
      selftests/timers/posix-timers: Validate SIGEV_NONE
      selftests/timers/posix-timers: Validate timer_gettime()
      selftests/timers/posix-timers: Validate overrun after unblock
      posix-cpu-timers: Split up posix_cpu_timer_get()
      posix-cpu-timers: Save interval only for armed timers
      posix-cpu-timers: Handle interval timers correctly in timer_get()
      posix-cpu-timers: Handle SIGEV_NONE timers correctly in timer_get()
      posix-cpu-timers: Handle SIGEV_NONE timers correctly in timer_set()
      posix-cpu-timers: Replace old expiry retrieval in posix_cpu_timer_set()
      posix-cpu-timers: Do not arm SIGEV_NONE timers
      posix-cpu-timers: Use @now instead of @val for clarity
      posix-cpu-timers: Remove incorrect comment in posix_cpu_timer_set()
      posix-cpu-timers: Simplify posix_cpu_timer_set()
      posix-timers: Retrieve interval in common timer_settime() code
      posix-timers: Clear overrun in common_timer_set()
      posix-timers: Convert timer list to hlist
      posix-timers: Consolidate timer setup
      posix-cpu-timers: Make k_itimer::it_active consistent
      posix-timers: Consolidate signal queueing
      signal: Remove task argument from dequeue_signal()
      signal: Replace BUG_ON()s

Uros Bizjak (1):
      clocksource/drivers/jcore: Use request_percpu_irq()

Zhang Zekun (1):
      clocksource/drivers/arm_arch_timer: Using for_each_available_child_of_n=
ode_scoped()


 Documentation/admin-guide/media/vivid.rst          |   2 +-
 .../bindings/timer/rockchip,rk-timer.yaml          |   1 +
 Documentation/timers/timers-howto.rst              |   2 +-
 .../sp_SP/scheduler/sched-design-CFS.rst           |   2 +-
 arch/arm/mach-versatile/spc.c                      |   2 +-
 arch/m68k/q40/q40ints.c                            |   2 +-
 arch/x86/kernel/cpu/mce/dev-mcelog.c               |   2 +-
 drivers/char/ipmi/ipmi_ssif.c                      |   2 +-
 drivers/clocksource/acpi_pm.c                      |  32 ++
 drivers/clocksource/arm_arch_timer.c               |  11 +-
 drivers/clocksource/asm9260_timer.c                |   1 +
 drivers/clocksource/ingenic-ost.c                  |   7 +-
 drivers/clocksource/jcore-pit.c                    |   7 +-
 drivers/clocksource/timer-cadence-ttc.c            |   6 +-
 drivers/clocksource/timer-qcom.c                   |   7 +-
 drivers/dma-buf/st-dma-fence.c                     |   2 +-
 drivers/gpu/drm/i915/gem/i915_gem_wait.c           |   2 +-
 drivers/gpu/drm/i915/gt/selftest_execlists.c       |   4 +-
 drivers/gpu/drm/i915/i915_utils.c                  |   2 +-
 drivers/gpu/drm/v3d/v3d_bo.c                       |   2 +-
 drivers/isdn/mISDN/dsp_cmx.c                       |   2 +-
 drivers/net/ethernet/marvell/mvmdio.c              |   2 +-
 drivers/platform/x86/intel/pmc/adl.c               |   2 +
 drivers/platform/x86/intel/pmc/cnp.c               |   2 +
 drivers/platform/x86/intel/pmc/core.c              |  45 ++
 drivers/platform/x86/intel/pmc/core.h              |   8 +
 drivers/platform/x86/intel/pmc/icl.c               |   2 +
 drivers/platform/x86/intel/pmc/mtl.c               |   2 +
 drivers/platform/x86/intel/pmc/spt.c               |   2 +
 drivers/platform/x86/intel/pmc/tgl.c               |   2 +
 fs/proc/base.c                                     |  15 +-
 fs/select.c                                        |  11 +-
 fs/signalfd.c                                      |   4 +-
 fs/xfs/xfs_buf.h                                   |   2 +-
 include/linux/acpi_pmtmr.h                         |  13 +
 include/linux/jiffies.h                            |   2 +-
 include/linux/posix-timers.h                       |   2 +-
 include/linux/sched/signal.h                       |   7 +-
 include/linux/timekeeper_internal.h                |   2 +-
 init/init_task.c                                   |   2 +-
 kernel/cpu.c                                       |   2 +-
 kernel/fork.c                                      |   2 +-
 kernel/sched/syscalls.c                            |   8 +
 kernel/signal.c                                    |  34 +-
 kernel/sys.c                                       |   2 +
 kernel/time/alarmtimer.c                           |   9 +-
 kernel/time/clockevents.c                          |   2 +-
 kernel/time/hrtimer.c                              |  22 +-
 kernel/time/ntp.c                                  |  10 +-
 kernel/time/ntp_internal.h                         |   4 +-
 kernel/time/posix-cpu-timers.c                     | 207 ++++----
 kernel/time/posix-timers.c                         |  73 +--
 kernel/time/posix-timers.h                         |   3 +-
 kernel/time/timekeeping.c                          |   4 +-
 kernel/time/timer.c                                |  62 ++-
 lib/Kconfig.debug                                  |   2 +-
 net/batman-adv/types.h                             |   2 +-
 tools/testing/selftests/timers/posix_timers.c      | 550 +++++++++++++++++--=
--
 58 files changed, 848 insertions(+), 377 deletions(-)

diff --git a/Documentation/admin-guide/media/vivid.rst b/Documentation/admin-=
guide/media/vivid.rst
index 1306f19ecb5a..c9d301ab46a3 100644
--- a/Documentation/admin-guide/media/vivid.rst
+++ b/Documentation/admin-guide/media/vivid.rst
@@ -328,7 +328,7 @@ and an HDMI input, one input for each input type. Those a=
re described in more
 detail below.
=20
 Special attention has been given to the rate at which new frames become
-available. The jitter will be around 1 jiffie (that depends on the HZ
+available. The jitter will be around 1 jiffy (that depends on the HZ
 configuration of your kernel, so usually 1/100, 1/250 or 1/1000 of a second),
 but the long-term behavior is exactly following the framerate. So a
 framerate of 59.94 Hz is really different from 60 Hz. If the framerate
diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml b=
/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
index 19e56b7577a0..6d0eb0014eee 100644
--- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
@@ -24,6 +24,7 @@ properties:
               - rockchip,rk3228-timer
               - rockchip,rk3229-timer
               - rockchip,rk3368-timer
+              - rockchip,rk3576-timer
               - rockchip,rk3588-timer
               - rockchip,px30-timer
           - const: rockchip,rk3288-timer
diff --git a/Documentation/timers/timers-howto.rst b/Documentation/timers/tim=
ers-howto.rst
index 5c169e3d29a8..ef7a4652ccc9 100644
--- a/Documentation/timers/timers-howto.rst
+++ b/Documentation/timers/timers-howto.rst
@@ -19,7 +19,7 @@ it really need to delay in atomic context?" If so...
=20
 ATOMIC CONTEXT:
 	You must use the `*delay` family of functions. These
-	functions use the jiffie estimation of clock speed
+	functions use the jiffy estimation of clock speed
 	and will busy wait for enough loop cycles to achieve
 	the desired delay:
=20
diff --git a/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst =
b/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
index 90a153cad4e8..731c266beb1a 100644
--- a/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
+++ b/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
@@ -109,7 +109,7 @@ para que se ejecute, y la tarea en ejecuci=C3=B3n es inte=
rrumpida.
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 CFS usa una granularidad de nanosegundos y no depende de ning=C3=BAn
-jiffie o detalles como HZ. De este modo, el gestor de tareas CFS no tiene
+jiffy o detalles como HZ. De este modo, el gestor de tareas CFS no tiene
 noci=C3=B3n de "ventanas de tiempo" de la forma en que ten=C3=ADa el gestor =
de
 tareas previo, y tampoco tiene heur=C3=ADsticos. =C3=9Anicamente hay un par=
=C3=A1metro
 central ajustable (se ha de cambiar en CONFIG_SCHED_DEBUG):
diff --git a/arch/arm/mach-versatile/spc.c b/arch/arm/mach-versatile/spc.c
index 5e44170e1a9a..790092734cf6 100644
--- a/arch/arm/mach-versatile/spc.c
+++ b/arch/arm/mach-versatile/spc.c
@@ -73,7 +73,7 @@
=20
 /*
  * Even though the SPC takes max 3-5 ms to complete any OPP/COMMS
- * operation, the operation could start just before jiffie is about
+ * operation, the operation could start just before jiffy is about
  * to be incremented. So setting timeout value of 20ms =3D 2jiffies@100Hz
  */
 #define TIMEOUT_US	20000
diff --git a/arch/m68k/q40/q40ints.c b/arch/m68k/q40/q40ints.c
index 10f1f294e91f..14b774b9d308 100644
--- a/arch/m68k/q40/q40ints.c
+++ b/arch/m68k/q40/q40ints.c
@@ -106,7 +106,7 @@ void __init q40_init_IRQ(void)
  * this stuff doesn't really belong here..
  */
=20
-int ql_ticks;              /* 200Hz ticks since last jiffie */
+int ql_ticks;              /* 200Hz ticks since last jiffy */
 static int sound_ticks;
=20
 #define SVOL 45
diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/d=
ev-mcelog.c
index a05ac0716ecf..a3aa0199222e 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -314,7 +314,7 @@ static ssize_t mce_chrdev_write(struct file *filp, const =
char __user *ubuf,
=20
 	/*
 	 * Need to give user space some time to set everything up,
-	 * so do it a jiffie or two later everywhere.
+	 * so do it a jiffy or two later everywhere.
 	 */
 	schedule_timeout(2);
=20
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 96ad571d041a..e093028391af 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -980,7 +980,7 @@ static void msg_written_handler(struct ssif_info *ssif_in=
fo, int result,
 			ipmi_ssif_unlock_cond(ssif_info, flags);
 			start_get(ssif_info);
 		} else {
-			/* Wait a jiffie then request the next message */
+			/* Wait a jiffy then request the next message */
 			ssif_info->waiting_alert =3D true;
 			ssif_info->retries_left =3D SSIF_RECV_RETRIES;
 			if (!ssif_info->stopping)
diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
index 82338773602c..b4330a01a566 100644
--- a/drivers/clocksource/acpi_pm.c
+++ b/drivers/clocksource/acpi_pm.c
@@ -25,6 +25,10 @@
 #include <asm/io.h>
 #include <asm/time.h>
=20
+static void *suspend_resume_cb_data;
+
+static void (*suspend_resume_callback)(void *data, bool suspend);
+
 /*
  * The I/O port the PMTMR resides at.
  * The location is detected during setup_arch(),
@@ -58,6 +62,32 @@ u32 acpi_pm_read_verified(void)
 	return v2;
 }
=20
+void acpi_pmtmr_register_suspend_resume_callback(void (*cb)(void *data, bool=
 suspend), void *data)
+{
+	suspend_resume_callback =3D cb;
+	suspend_resume_cb_data =3D data;
+}
+EXPORT_SYMBOL_GPL(acpi_pmtmr_register_suspend_resume_callback);
+
+void acpi_pmtmr_unregister_suspend_resume_callback(void)
+{
+	suspend_resume_callback =3D NULL;
+	suspend_resume_cb_data =3D NULL;
+}
+EXPORT_SYMBOL_GPL(acpi_pmtmr_unregister_suspend_resume_callback);
+
+static void acpi_pm_suspend(struct clocksource *cs)
+{
+	if (suspend_resume_callback)
+		suspend_resume_callback(suspend_resume_cb_data, true);
+}
+
+static void acpi_pm_resume(struct clocksource *cs)
+{
+	if (suspend_resume_callback)
+		suspend_resume_callback(suspend_resume_cb_data, false);
+}
+
 static u64 acpi_pm_read(struct clocksource *cs)
 {
 	return (u64)read_pmtmr();
@@ -69,6 +99,8 @@ static struct clocksource clocksource_acpi_pm =3D {
 	.read		=3D acpi_pm_read,
 	.mask		=3D (u64)ACPI_PM_MASK,
 	.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
+	.suspend	=3D acpi_pm_suspend,
+	.resume		=3D acpi_pm_resume,
 };
=20
=20
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_a=
rch_timer.c
index aeafc74181f0..03733101e231 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1594,7 +1594,6 @@ static int __init arch_timer_mem_of_init(struct device_=
node *np)
 {
 	struct arch_timer_mem *timer_mem;
 	struct arch_timer_mem_frame *frame;
-	struct device_node *frame_node;
 	struct resource res;
 	int ret =3D -EINVAL;
 	u32 rate;
@@ -1608,33 +1607,29 @@ static int __init arch_timer_mem_of_init(struct devic=
e_node *np)
 	timer_mem->cntctlbase =3D res.start;
 	timer_mem->size =3D resource_size(&res);
=20
-	for_each_available_child_of_node(np, frame_node) {
+	for_each_available_child_of_node_scoped(np, frame_node) {
 		u32 n;
 		struct arch_timer_mem_frame *frame;
=20
 		if (of_property_read_u32(frame_node, "frame-number", &n)) {
 			pr_err(FW_BUG "Missing frame-number.\n");
-			of_node_put(frame_node);
 			goto out;
 		}
 		if (n >=3D ARCH_TIMER_MEM_MAX_FRAMES) {
 			pr_err(FW_BUG "Wrong frame-number, only 0-%u are permitted.\n",
 			       ARCH_TIMER_MEM_MAX_FRAMES - 1);
-			of_node_put(frame_node);
 			goto out;
 		}
 		frame =3D &timer_mem->frame[n];
=20
 		if (frame->valid) {
 			pr_err(FW_BUG "Duplicated frame-number.\n");
-			of_node_put(frame_node);
 			goto out;
 		}
=20
-		if (of_address_to_resource(frame_node, 0, &res)) {
-			of_node_put(frame_node);
+		if (of_address_to_resource(frame_node, 0, &res))
 			goto out;
-		}
+
 		frame->cntbase =3D res.start;
 		frame->size =3D resource_size(&res);
=20
diff --git a/drivers/clocksource/asm9260_timer.c b/drivers/clocksource/asm926=
0_timer.c
index 5b39d3701fa3..8f97ab0b01ec 100644
--- a/drivers/clocksource/asm9260_timer.c
+++ b/drivers/clocksource/asm9260_timer.c
@@ -210,6 +210,7 @@ static int __init asm9260_timer_init(struct device_node *=
np)
 			DRIVER_NAME, &event_dev);
 	if (ret) {
 		pr_err("Failed to setup irq!\n");
+		clk_disable_unprepare(clk);
 		return ret;
 	}
=20
diff --git a/drivers/clocksource/ingenic-ost.c b/drivers/clocksource/ingenic-=
ost.c
index 9f7c280a1336..e0ec33307c84 100644
--- a/drivers/clocksource/ingenic-ost.c
+++ b/drivers/clocksource/ingenic-ost.c
@@ -93,14 +93,10 @@ static int __init ingenic_ost_probe(struct platform_devic=
e *pdev)
 		return PTR_ERR(map);
 	}
=20
-	ost->clk =3D devm_clk_get(dev, "ost");
+	ost->clk =3D devm_clk_get_enabled(dev, "ost");
 	if (IS_ERR(ost->clk))
 		return PTR_ERR(ost->clk);
=20
-	err =3D clk_prepare_enable(ost->clk);
-	if (err)
-		return err;
-
 	/* Clear counter high/low registers */
 	if (soc_info->is64bit)
 		regmap_write(map, TCU_REG_OST_CNTL, 0);
@@ -129,7 +125,6 @@ static int __init ingenic_ost_probe(struct platform_devic=
e *pdev)
 	err =3D clocksource_register_hz(cs, rate);
 	if (err) {
 		dev_err(dev, "clocksource registration failed");
-		clk_disable_unprepare(ost->clk);
 		return err;
 	}
=20
diff --git a/drivers/clocksource/jcore-pit.c b/drivers/clocksource/jcore-pit.c
index a4a991101fa3..a3fe98cd3838 100644
--- a/drivers/clocksource/jcore-pit.c
+++ b/drivers/clocksource/jcore-pit.c
@@ -120,7 +120,7 @@ static int jcore_pit_local_init(unsigned cpu)
=20
 static irqreturn_t jcore_timer_interrupt(int irq, void *dev_id)
 {
-	struct jcore_pit *pit =3D this_cpu_ptr(dev_id);
+	struct jcore_pit *pit =3D dev_id;
=20
 	if (clockevent_state_oneshot(&pit->ced))
 		jcore_pit_disable(pit);
@@ -168,9 +168,8 @@ static int __init jcore_pit_init(struct device_node *node)
 		return -ENOMEM;
 	}
=20
-	err =3D request_irq(pit_irq, jcore_timer_interrupt,
-			  IRQF_TIMER | IRQF_PERCPU,
-			  "jcore_pit", jcore_pit_percpu);
+	err =3D request_percpu_irq(pit_irq, jcore_timer_interrupt,
+				 "jcore_pit", jcore_pit_percpu);
 	if (err) {
 		pr_err("pit irq request failed: %d\n", err);
 		free_percpu(jcore_pit_percpu);
diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/ti=
mer-cadence-ttc.c
index ca7a06489c40..b8a1cf59b9d6 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -435,7 +435,7 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 				    &ttcce->ttc.clk_rate_change_nb);
 	if (err) {
 		pr_warn("Unable to register clock notifier.\n");
-		goto out_kfree;
+		goto out_clk_unprepare;
 	}
=20
 	ttcce->ttc.freq =3D clk_get_rate(ttcce->ttc.clk);
@@ -465,13 +465,15 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 	err =3D request_irq(irq, ttc_clock_event_interrupt,
 			  IRQF_TIMER, ttcce->ce.name, ttcce);
 	if (err)
-		goto out_kfree;
+		goto out_clk_unprepare;
=20
 	clockevents_config_and_register(&ttcce->ce,
 			ttcce->ttc.freq / PRESCALE, 1, 0xfffe);
=20
 	return 0;
=20
+out_clk_unprepare:
+	clk_disable_unprepare(ttcce->ttc.clk);
 out_kfree:
 	kfree(ttcce);
 	return err;
diff --git a/drivers/clocksource/timer-qcom.c b/drivers/clocksource/timer-qco=
m.c
index b4afe3a67583..eac4c95c6127 100644
--- a/drivers/clocksource/timer-qcom.c
+++ b/drivers/clocksource/timer-qcom.c
@@ -233,6 +233,7 @@ static int __init msm_dt_timer_init(struct device_node *n=
p)
 	}
=20
 	if (of_property_read_u32(np, "clock-frequency", &freq)) {
+		iounmap(cpu0_base);
 		pr_err("Unknown frequency\n");
 		return -EINVAL;
 	}
@@ -243,7 +244,11 @@ static int __init msm_dt_timer_init(struct device_node *=
np)
 	freq /=3D 4;
 	writel_relaxed(DGT_CLK_CTL_DIV_4, source_base + DGT_CLK_CTL);
=20
-	return msm_timer_init(freq, 32, irq, !!percpu_offset);
+	ret =3D msm_timer_init(freq, 32, irq, !!percpu_offset);
+	if (ret)
+		iounmap(cpu0_base);
+
+	return ret;
 }
 TIMER_OF_DECLARE(kpss_timer, "qcom,kpss-timer", msm_dt_timer_init);
 TIMER_OF_DECLARE(scss_timer, "qcom,scss-timer", msm_dt_timer_init);
diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-fence.c
index 6a1bfcd0cc21..cf2ce3744ce6 100644
--- a/drivers/dma-buf/st-dma-fence.c
+++ b/drivers/dma-buf/st-dma-fence.c
@@ -402,7 +402,7 @@ static int test_wait_timeout(void *arg)
=20
 	if (dma_fence_wait_timeout(wt.f, false, 2) =3D=3D -ETIME) {
 		if (timer_pending(&wt.timer)) {
-			pr_notice("Timer did not fire within the jiffie!\n");
+			pr_notice("Timer did not fire within the jiffy!\n");
 			err =3D 0; /* not our fault! */
 		} else {
 			pr_err("Wait reported incomplete after timeout\n");
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_wait.c b/drivers/gpu/drm/i915/=
gem/i915_gem_wait.c
index d4b918fb11ce..1f55e62044a4 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_wait.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
@@ -266,7 +266,7 @@ i915_gem_wait_ioctl(struct drm_device *dev, void *data, s=
truct drm_file *file)
 		if (ret =3D=3D -ETIME && !nsecs_to_jiffies(args->timeout_ns))
 			args->timeout_ns =3D 0;
=20
-		/* Asked to wait beyond the jiffie/scheduler precision? */
+		/* Asked to wait beyond the jiffy/scheduler precision? */
 		if (ret =3D=3D -ETIME && args->timeout_ns)
 			ret =3D -EAGAIN;
 	}
diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i=
915/gt/selftest_execlists.c
index 4202df5b8c12..222ca7c44951 100644
--- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
+++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
@@ -93,7 +93,7 @@ static int wait_for_reset(struct intel_engine_cs *engine,
 		return -EINVAL;
 	}
=20
-	/* Give the request a jiffie to complete after flushing the worker */
+	/* Give the request a jiffy to complete after flushing the worker */
 	if (i915_request_wait(rq, 0,
 			      max(0l, (long)(timeout - jiffies)) + 1) < 0) {
 		pr_err("%s: hanging request %llx:%lld did not complete\n",
@@ -3426,7 +3426,7 @@ static int live_preempt_timeout(void *arg)
 			cpu_relax();
=20
 		saved_timeout =3D engine->props.preempt_timeout_ms;
-		engine->props.preempt_timeout_ms =3D 1; /* in ms, -> 1 jiffie */
+		engine->props.preempt_timeout_ms =3D 1; /* in ms, -> 1 jiffy */
=20
 		i915_request_get(rq);
 		i915_request_add(rq);
diff --git a/drivers/gpu/drm/i915/i915_utils.c b/drivers/gpu/drm/i915/i915_ut=
ils.c
index 6f9e7b354b54..f2ba51c20e97 100644
--- a/drivers/gpu/drm/i915/i915_utils.c
+++ b/drivers/gpu/drm/i915/i915_utils.c
@@ -110,7 +110,7 @@ void set_timer_ms(struct timer_list *t, unsigned long tim=
eout)
 	 * Paranoia to make sure the compiler computes the timeout before
 	 * loading 'jiffies' as jiffies is volatile and may be updated in
 	 * the background by a timer tick. All to reduce the complexity
-	 * of the addition and reduce the risk of losing a jiffie.
+	 * of the addition and reduce the risk of losing a jiffy.
 	 */
 	barrier();
=20
diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index a165cbcdd27b..9eafe53a8f41 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -279,7 +279,7 @@ v3d_wait_bo_ioctl(struct drm_device *dev, void *data,
 	else
 		args->timeout_ns =3D 0;
=20
-	/* Asked to wait beyond the jiffie/scheduler precision? */
+	/* Asked to wait beyond the jiffy/scheduler precision? */
 	if (ret =3D=3D -ETIME && args->timeout_ns)
 		ret =3D -EAGAIN;
=20
diff --git a/drivers/isdn/mISDN/dsp_cmx.c b/drivers/isdn/mISDN/dsp_cmx.c
index 61cb45c5d0d8..53fad9487574 100644
--- a/drivers/isdn/mISDN/dsp_cmx.c
+++ b/drivers/isdn/mISDN/dsp_cmx.c
@@ -82,7 +82,7 @@
  *  - has multiple clocks.
  *  - has no usable clock due to jitter or packet loss (VoIP).
  * In this case the system's clock is used. The clock resolution depends on
- * the jiffie resolution.
+ * the jiffy resolution.
  *
  * If a member joins a conference:
  *
diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/mar=
vell/mvmdio.c
index 9190eff6c0bb..e1d003fdbc2e 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -104,7 +104,7 @@ static int orion_mdio_wait_ready(const struct orion_mdio_=
ops *ops,
 			return 0;
 	} else {
 		/* wait_event_timeout does not guarantee a delay of at
-		 * least one whole jiffie, so timeout must be no less
+		 * least one whole jiffy, so timeout must be no less
 		 * than two.
 		 */
 		timeout =3D max(usecs_to_jiffies(MVMDIO_SMI_TIMEOUT), 2);
diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/inte=
l/pmc/adl.c
index e7878558fd90..9d9c07f44ff6 100644
--- a/drivers/platform/x86/intel/pmc/adl.c
+++ b/drivers/platform/x86/intel/pmc/adl.c
@@ -295,6 +295,8 @@ const struct pmc_reg_map adl_reg_map =3D {
 	.ppfear_buckets =3D CNP_PPFEAR_NUM_ENTRIES,
 	.pm_cfg_offset =3D CNP_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit =3D CNP_PMC_READ_DISABLE_BIT,
+	.acpi_pm_tmr_ctl_offset =3D SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
+	.acpi_pm_tmr_disable_bit =3D SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
 	.ltr_ignore_max =3D ADL_NUM_IP_IGN_ALLOWED,
 	.lpm_num_modes =3D ADL_LPM_NUM_MODES,
 	.lpm_num_maps =3D ADL_LPM_NUM_MAPS,
diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/inte=
l/pmc/cnp.c
index dd72974bf71e..513c02670c5a 100644
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -200,6 +200,8 @@ const struct pmc_reg_map cnp_reg_map =3D {
 	.ppfear_buckets =3D CNP_PPFEAR_NUM_ENTRIES,
 	.pm_cfg_offset =3D CNP_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit =3D CNP_PMC_READ_DISABLE_BIT,
+	.acpi_pm_tmr_ctl_offset =3D SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
+	.acpi_pm_tmr_disable_bit =3D SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
 	.ltr_ignore_max =3D CNP_NUM_IP_IGN_ALLOWED,
 	.etr3_offset =3D ETR3_OFFSET,
 };
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/int=
el/pmc/core.c
index 01ae71c6df59..e2b4c74ce7f6 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -11,6 +11,7 @@
=20
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
=20
+#include <linux/acpi_pmtmr.h>
 #include <linux/bitfield.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -1208,6 +1209,38 @@ static bool pmc_core_is_pson_residency_enabled(struct =
pmc_dev *pmcdev)
 	return val =3D=3D 1;
 }
=20
+/*
+ * Enable or disable ACPI PM Timer
+ *
+ * This function is intended to be a callback for ACPI PM suspend/resume eve=
nt.
+ * The ACPI PM Timer is enabled on resume only if it was enabled during susp=
end.
+ */
+static void pmc_core_acpi_pm_timer_suspend_resume(void *data, bool suspend)
+{
+	struct pmc_dev *pmcdev =3D data;
+	struct pmc *pmc =3D pmcdev->pmcs[PMC_IDX_MAIN];
+	const struct pmc_reg_map *map =3D pmc->map;
+	bool enabled;
+	u32 reg;
+
+	if (!map->acpi_pm_tmr_ctl_offset)
+		return;
+
+	guard(mutex)(&pmcdev->lock);
+
+	if (!suspend && !pmcdev->enable_acpi_pm_timer_on_resume)
+		return;
+
+	reg =3D pmc_core_reg_read(pmc, map->acpi_pm_tmr_ctl_offset);
+	enabled =3D !(reg & map->acpi_pm_tmr_disable_bit);
+	if (suspend)
+		reg |=3D map->acpi_pm_tmr_disable_bit;
+	else
+		reg &=3D ~map->acpi_pm_tmr_disable_bit;
+	pmc_core_reg_write(pmc, map->acpi_pm_tmr_ctl_offset, reg);
+
+	pmcdev->enable_acpi_pm_timer_on_resume =3D suspend && enabled;
+}
=20
 static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
 {
@@ -1404,6 +1437,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 	struct pmc_dev *pmcdev;
 	const struct x86_cpu_id *cpu_id;
 	int (*core_init)(struct pmc_dev *pmcdev);
+	const struct pmc_reg_map *map;
 	struct pmc *primary_pmc;
 	int ret;
=20
@@ -1462,6 +1496,11 @@ static int pmc_core_probe(struct platform_device *pdev)
 	pm_report_max_hw_sleep(FIELD_MAX(SLP_S0_RES_COUNTER_MASK) *
 			       pmc_core_adjust_slp_s0_step(primary_pmc, 1));
=20
+	map =3D primary_pmc->map;
+	if (map->acpi_pm_tmr_ctl_offset)
+		acpi_pmtmr_register_suspend_resume_callback(pmc_core_acpi_pm_timer_suspend=
_resume,
+							 pmcdev);
+
 	device_initialized =3D true;
 	dev_info(&pdev->dev, " initialized\n");
=20
@@ -1471,6 +1510,12 @@ static int pmc_core_probe(struct platform_device *pdev)
 static void pmc_core_remove(struct platform_device *pdev)
 {
 	struct pmc_dev *pmcdev =3D platform_get_drvdata(pdev);
+	const struct pmc *pmc =3D pmcdev->pmcs[PMC_IDX_MAIN];
+	const struct pmc_reg_map *map =3D pmc->map;
+
+	if (map->acpi_pm_tmr_ctl_offset)
+		acpi_pmtmr_unregister_suspend_resume_callback();
+
 	pmc_core_dbgfs_unregister(pmcdev);
 	pmc_core_clean_structure(pdev);
 }
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/int=
el/pmc/core.h
index ea04de7eb9e8..4d37ef7113d7 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -68,6 +68,8 @@ struct telem_endpoint;
 #define SPT_PMC_LTR_SCC				0x3A0
 #define SPT_PMC_LTR_ISH				0x3A4
=20
+#define SPT_PMC_ACPI_PM_TMR_CTL_OFFSET		0x18FC
+
 /* Sunrise Point: PGD PFET Enable Ack Status Registers */
 enum ppfear_regs {
 	SPT_PMC_XRAM_PPFEAR0A =3D 0x590,
@@ -148,6 +150,8 @@ enum ppfear_regs {
 #define SPT_PMC_VRIC1_SLPS0LVEN			BIT(13)
 #define SPT_PMC_VRIC1_XTALSDQDIS		BIT(22)
=20
+#define SPT_PMC_BIT_ACPI_PM_TMR_DISABLE		BIT(1)
+
 /* Cannonlake Power Management Controller register offsets */
 #define CNP_PMC_SLPS0_DBG_OFFSET		0x10B4
 #define CNP_PMC_PM_CFG_OFFSET			0x1818
@@ -351,6 +355,8 @@ struct pmc_reg_map {
 	const u8  *lpm_reg_index;
 	const u32 pson_residency_offset;
 	const u32 pson_residency_counter_step;
+	const u32 acpi_pm_tmr_ctl_offset;
+	const u32 acpi_pm_tmr_disable_bit;
 };
=20
 /**
@@ -424,6 +430,8 @@ struct pmc_dev {
 	u32 die_c6_offset;
 	struct telem_endpoint *punit_ep;
 	struct pmc_info *regmap_list;
+
+	bool enable_acpi_pm_timer_on_resume;
 };
=20
 enum pmc_index {
diff --git a/drivers/platform/x86/intel/pmc/icl.c b/drivers/platform/x86/inte=
l/pmc/icl.c
index 71b0fd6cb7d8..cbbd44054468 100644
--- a/drivers/platform/x86/intel/pmc/icl.c
+++ b/drivers/platform/x86/intel/pmc/icl.c
@@ -46,6 +46,8 @@ const struct pmc_reg_map icl_reg_map =3D {
 	.ppfear_buckets =3D ICL_PPFEAR_NUM_ENTRIES,
 	.pm_cfg_offset =3D CNP_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit =3D CNP_PMC_READ_DISABLE_BIT,
+	.acpi_pm_tmr_ctl_offset =3D SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
+	.acpi_pm_tmr_disable_bit =3D SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
 	.ltr_ignore_max =3D ICL_NUM_IP_IGN_ALLOWED,
 	.etr3_offset =3D ETR3_OFFSET,
 };
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/inte=
l/pmc/mtl.c
index c7d15d864039..91f2fa728f5c 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -462,6 +462,8 @@ const struct pmc_reg_map mtl_socm_reg_map =3D {
 	.ppfear_buckets =3D MTL_SOCM_PPFEAR_NUM_ENTRIES,
 	.pm_cfg_offset =3D CNP_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit =3D CNP_PMC_READ_DISABLE_BIT,
+	.acpi_pm_tmr_ctl_offset =3D SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
+	.acpi_pm_tmr_disable_bit =3D SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
 	.lpm_num_maps =3D ADL_LPM_NUM_MAPS,
 	.ltr_ignore_max =3D MTL_SOCM_NUM_IP_IGN_ALLOWED,
 	.lpm_res_counter_step_x2 =3D TGL_PMC_LPM_RES_COUNTER_STEP_X2,
diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/inte=
l/pmc/spt.c
index ab993a69e33e..2cd2b3c68e46 100644
--- a/drivers/platform/x86/intel/pmc/spt.c
+++ b/drivers/platform/x86/intel/pmc/spt.c
@@ -130,6 +130,8 @@ const struct pmc_reg_map spt_reg_map =3D {
 	.ppfear_buckets =3D SPT_PPFEAR_NUM_ENTRIES,
 	.pm_cfg_offset =3D SPT_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit =3D SPT_PMC_READ_DISABLE_BIT,
+	.acpi_pm_tmr_ctl_offset =3D SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
+	.acpi_pm_tmr_disable_bit =3D SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
 	.ltr_ignore_max =3D SPT_NUM_IP_IGN_ALLOWED,
 	.pm_vric1_offset =3D SPT_PMC_VRIC1_OFFSET,
 };
diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/inte=
l/pmc/tgl.c
index e0580de18077..371b4e30f142 100644
--- a/drivers/platform/x86/intel/pmc/tgl.c
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@ -197,6 +197,8 @@ const struct pmc_reg_map tgl_reg_map =3D {
 	.ppfear_buckets =3D ICL_PPFEAR_NUM_ENTRIES,
 	.pm_cfg_offset =3D CNP_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit =3D CNP_PMC_READ_DISABLE_BIT,
+	.acpi_pm_tmr_ctl_offset =3D SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
+	.acpi_pm_tmr_disable_bit =3D SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
 	.ltr_ignore_max =3D TGL_NUM_IP_IGN_ALLOWED,
 	.lpm_num_maps =3D TGL_LPM_NUM_MAPS,
 	.lpm_res_counter_step_x2 =3D TGL_PMC_LPM_RES_COUNTER_STEP_X2,
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 72a1acd03675..afe573e8d8f1 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2456,13 +2456,13 @@ static void *timers_start(struct seq_file *m, loff_t =
*pos)
 	if (!tp->sighand)
 		return ERR_PTR(-ESRCH);
=20
-	return seq_list_start(&tp->task->signal->posix_timers, *pos);
+	return seq_hlist_start(&tp->task->signal->posix_timers, *pos);
 }
=20
 static void *timers_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct timers_private *tp =3D m->private;
-	return seq_list_next(v, &tp->task->signal->posix_timers, pos);
+	return seq_hlist_next(v, &tp->task->signal->posix_timers, pos);
 }
=20
 static void timers_stop(struct seq_file *m, void *v)
@@ -2491,7 +2491,7 @@ static int show_timer(struct seq_file *m, void *v)
 		[SIGEV_THREAD] =3D "thread",
 	};
=20
-	timer =3D list_entry((struct list_head *)v, struct k_itimer, list);
+	timer =3D hlist_entry((struct hlist_node *)v, struct k_itimer, list);
 	notify =3D timer->it_sigev_notify;
=20
 	seq_printf(m, "ID: %d\n", timer->it_id);
@@ -2569,10 +2569,11 @@ static ssize_t timerslack_ns_write(struct file *file,=
 const char __user *buf,
 	}
=20
 	task_lock(p);
-	if (slack_ns =3D=3D 0)
-		p->timer_slack_ns =3D p->default_timer_slack_ns;
-	else
-		p->timer_slack_ns =3D slack_ns;
+	if (task_is_realtime(p))
+		slack_ns =3D 0;
+	else if (slack_ns =3D=3D 0)
+		slack_ns =3D p->default_timer_slack_ns;
+	p->timer_slack_ns =3D slack_ns;
 	task_unlock(p);
=20
 out:
diff --git a/fs/select.c b/fs/select.c
index 9515c3fa1a03..ad171b7a5c11 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -77,19 +77,16 @@ u64 select_estimate_accuracy(struct timespec64 *tv)
 {
 	u64 ret;
 	struct timespec64 now;
+	u64 slack =3D current->timer_slack_ns;
=20
-	/*
-	 * Realtime tasks get a slack of 0 for obvious reasons.
-	 */
-
-	if (rt_task(current))
+	if (slack =3D=3D 0)
 		return 0;
=20
 	ktime_get_ts64(&now);
 	now =3D timespec64_sub(*tv, now);
 	ret =3D __estimate_accuracy(&now);
-	if (ret < current->timer_slack_ns)
-		return current->timer_slack_ns;
+	if (ret < slack)
+		return slack;
 	return ret;
 }
=20
diff --git a/fs/signalfd.c b/fs/signalfd.c
index ec7b2da2477a..d0333bce015e 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -159,7 +159,7 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx,=
 kernel_siginfo_t *info
 	DECLARE_WAITQUEUE(wait, current);
=20
 	spin_lock_irq(&current->sighand->siglock);
-	ret =3D dequeue_signal(current, &ctx->sigmask, info, &type);
+	ret =3D dequeue_signal(&ctx->sigmask, info, &type);
 	switch (ret) {
 	case 0:
 		if (!nonblock)
@@ -174,7 +174,7 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx,=
 kernel_siginfo_t *info
 	add_wait_queue(&current->sighand->signalfd_wqh, &wait);
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		ret =3D dequeue_signal(current, &ctx->sigmask, info, &type);
+		ret =3D dequeue_signal(&ctx->sigmask, info, &type);
 		if (ret !=3D 0)
 			break;
 		if (signal_pending(current)) {
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index b1580644501f..209a389f2abc 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -210,7 +210,7 @@ struct xfs_buf {
 	 * success the write is considered to be failed permanently and the
 	 * iodone handler will take appropriate action.
 	 *
-	 * For retry timeouts, we record the jiffie of the first failure. This
+	 * For retry timeouts, we record the jiffy of the first failure. This
 	 * means that we can change the retry timeout for buffers already under
 	 * I/O and thus avoid getting stuck in a retry loop with a long timeout.
 	 *
diff --git a/include/linux/acpi_pmtmr.h b/include/linux/acpi_pmtmr.h
index 50d88bf1498d..0ded9220d379 100644
--- a/include/linux/acpi_pmtmr.h
+++ b/include/linux/acpi_pmtmr.h
@@ -26,6 +26,19 @@ static inline u32 acpi_pm_read_early(void)
 	return acpi_pm_read_verified() & ACPI_PM_MASK;
 }
=20
+/**
+ * Register callback for suspend and resume event
+ *
+ * @cb Callback triggered on suspend and resume
+ * @data Data passed with the callback
+ */
+void acpi_pmtmr_register_suspend_resume_callback(void (*cb)(void *data, bool=
 suspend), void *data);
+
+/**
+ * Remove registered callback for suspend and resume event
+ */
+void acpi_pmtmr_unregister_suspend_resume_callback(void);
+
 #else
=20
 static inline u32 acpi_pm_read_early(void)
diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index d9f1435a5a13..1220f0fbe5bf 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -418,7 +418,7 @@ extern unsigned long preset_lpj;
 #define NSEC_CONVERSION ((unsigned long)((((u64)1 << NSEC_JIFFIE_SC) +\
                                         TICK_NSEC -1) / (u64)TICK_NSEC))
 /*
- * The maximum jiffie value is (MAX_INT >> 1).  Here we translate that
+ * The maximum jiffy value is (MAX_INT >> 1).  Here we translate that
  * into seconds.  The 64-bit case will overflow if we are not careful,
  * so use the messy SH_DIV macro to do it.  Still all constants.
  */
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index dc7b738de299..453691710839 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -158,7 +158,7 @@ static inline void posix_cputimers_init_work(void) { }
  * @rcu:		RCU head for freeing the timer.
  */
 struct k_itimer {
-	struct list_head	list;
+	struct hlist_node	list;
 	struct hlist_node	t_hash;
 	spinlock_t		it_lock;
 	const struct k_clock	*kclock;
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 0a0e23c45406..c8ed09ac29ac 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -137,7 +137,7 @@ struct signal_struct {
=20
 	/* POSIX.1b Interval Timers */
 	unsigned int		next_posix_timer_id;
-	struct list_head	posix_timers;
+	struct hlist_head	posix_timers;
=20
 	/* ITIMER_REAL timer for the process */
 	struct hrtimer real_timer;
@@ -276,8 +276,7 @@ static inline void signal_set_stop_flags(struct signal_st=
ruct *sig,
 extern void flush_signals(struct task_struct *);
 extern void ignore_signals(struct task_struct *);
 extern void flush_signal_handlers(struct task_struct *, int force_default);
-extern int dequeue_signal(struct task_struct *task, sigset_t *mask,
-			  kernel_siginfo_t *info, enum pid_type *type);
+extern int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_t=
ype *type);
=20
 static inline int kernel_dequeue_signal(void)
 {
@@ -287,7 +286,7 @@ static inline int kernel_dequeue_signal(void)
 	int ret;
=20
 	spin_lock_irq(&task->sighand->siglock);
-	ret =3D dequeue_signal(task, &task->blocked, &__info, &__type);
+	ret =3D dequeue_signal(&task->blocked, &__info, &__type);
 	spin_unlock_irq(&task->sighand->siglock);
=20
 	return ret;
diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_i=
nternal.h
index 84ff2844df2a..902c20ef495a 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -73,7 +73,7 @@ struct tk_read_base {
  * @overflow_seen:	Overflow warning flag (DEBUG_TIMEKEEPING)
  *
  * Note: For timespec(64) based interfaces wall_to_monotonic is what
- * we need to add to xtime (or xtime corrected for sub jiffie times)
+ * we need to add to xtime (or xtime corrected for sub jiffy times)
  * to get to monotonic time.  Monotonic is pegged at zero at system
  * boot time, so wall_to_monotonic will be negative, however, we will
  * ALWAYS keep the tv_nsec part positive so we can use the usual
diff --git a/init/init_task.c b/init/init_task.c
index eeb110c65fe2..5d0399bc8d2f 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -29,7 +29,7 @@ static struct signal_struct init_signals =3D {
 	.cred_guard_mutex =3D __MUTEX_INITIALIZER(init_signals.cred_guard_mutex),
 	.exec_update_lock =3D __RWSEM_INITIALIZER(init_signals.exec_update_lock),
 #ifdef CONFIG_POSIX_TIMERS
-	.posix_timers =3D LIST_HEAD_INIT(init_signals.posix_timers),
+	.posix_timers	=3D HLIST_HEAD_INIT,
 	.cputimer	=3D {
 		.cputime_atomic	=3D INIT_CPUTIME_ATOMIC,
 	},
diff --git a/kernel/cpu.c b/kernel/cpu.c
index b1fd2a3db91a..5bfc2fdd7da0 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -330,7 +330,7 @@ static bool cpuhp_wait_for_sync_state(unsigned int cpu, e=
num cpuhp_sync_state st
 			/* Poll for one millisecond */
 			arch_cpuhp_sync_state_poll();
 		} else {
-			usleep_range_state(USEC_PER_MSEC, 2 * USEC_PER_MSEC, TASK_UNINTERRUPTIBLE=
);
+			usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
 		}
 		sync =3D atomic_read(st);
 	}
diff --git a/kernel/fork.c b/kernel/fork.c
index cc760491f201..c1b343cba560 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1861,7 +1861,7 @@ static int copy_signal(unsigned long clone_flags, struc=
t task_struct *tsk)
 	prev_cputime_init(&sig->prev_cputime);
=20
 #ifdef CONFIG_POSIX_TIMERS
-	INIT_LIST_HEAD(&sig->posix_timers);
+	INIT_HLIST_HEAD(&sig->posix_timers);
 	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	sig->real_timer.function =3D it_real_fn;
 #endif
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index ae1b42775ef9..195d2f2834a9 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -406,6 +406,14 @@ static void __setscheduler_params(struct task_struct *p,
 	else if (fair_policy(policy))
 		p->static_prio =3D NICE_TO_PRIO(attr->sched_nice);
=20
+	/* rt-policy tasks do not have a timerslack */
+	if (task_is_realtime(p)) {
+		p->timer_slack_ns =3D 0;
+	} else if (p->timer_slack_ns =3D=3D 0) {
+		/* when switching back to non-rt policy, restore timerslack */
+		p->timer_slack_ns =3D p->default_timer_slack_ns;
+	}
+
 	/*
 	 * __sched_setscheduler() ensures attr->sched_priority =3D=3D 0 when
 	 * !rt_policy. Always setting this ensures that things like
diff --git a/kernel/signal.c b/kernel/signal.c
index 60c737e423a1..6f3a5aa39b09 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -618,20 +618,18 @@ static int __dequeue_signal(struct sigpending *pending,=
 sigset_t *mask,
 }
=20
 /*
- * Dequeue a signal and return the element to the caller, which is
- * expected to free it.
- *
- * All callers have to hold the siglock.
+ * Try to dequeue a signal. If a deliverable signal is found fill in the
+ * caller provided siginfo and return the signal number. Otherwise return
+ * 0.
  */
-int dequeue_signal(struct task_struct *tsk, sigset_t *mask,
-		   kernel_siginfo_t *info, enum pid_type *type)
+int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *ty=
pe)
 {
+	struct task_struct *tsk =3D current;
 	bool resched_timer =3D false;
 	int signr;
=20
-	/* We only dequeue private signals from ourselves, we don't let
-	 * signalfd steal them
-	 */
+	lockdep_assert_held(&tsk->sighand->siglock);
+
 	*type =3D PIDTYPE_PID;
 	signr =3D __dequeue_signal(&tsk->pending, mask, info, &resched_timer);
 	if (!signr) {
@@ -1940,10 +1938,11 @@ struct sigqueue *sigqueue_alloc(void)
=20
 void sigqueue_free(struct sigqueue *q)
 {
-	unsigned long flags;
 	spinlock_t *lock =3D &current->sighand->siglock;
+	unsigned long flags;
=20
-	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
+	if (WARN_ON_ONCE(!(q->flags & SIGQUEUE_PREALLOC)))
+		return;
 	/*
 	 * We must hold ->siglock while testing q->list
 	 * to serialize with collect_signal() or with
@@ -1971,7 +1970,10 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid,=
 enum pid_type type)
 	unsigned long flags;
 	int ret, result;
=20
-	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
+	if (WARN_ON_ONCE(!(q->flags & SIGQUEUE_PREALLOC)))
+		return 0;
+	if (WARN_ON_ONCE(q->info.si_code !=3D SI_TIMER))
+		return 0;
=20
 	ret =3D -1;
 	rcu_read_lock();
@@ -2006,7 +2008,6 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, =
enum pid_type type)
 		 * If an SI_TIMER entry is already queue just increment
 		 * the overrun count.
 		 */
-		BUG_ON(q->info.si_code !=3D SI_TIMER);
 		q->info.si_overrun++;
 		result =3D TRACE_SIGNAL_ALREADY_PENDING;
 		goto out;
@@ -2793,8 +2794,7 @@ bool get_signal(struct ksignal *ksig)
 		type =3D PIDTYPE_PID;
 		signr =3D dequeue_synchronous_signal(&ksig->info);
 		if (!signr)
-			signr =3D dequeue_signal(current, &current->blocked,
-					       &ksig->info, &type);
+			signr =3D dequeue_signal(&current->blocked, &ksig->info, &type);
=20
 		if (!signr)
 			break; /* will return 0 */
@@ -3648,7 +3648,7 @@ static int do_sigtimedwait(const sigset_t *which, kerne=
l_siginfo_t *info,
 	signotset(&mask);
=20
 	spin_lock_irq(&tsk->sighand->siglock);
-	sig =3D dequeue_signal(tsk, &mask, info, &type);
+	sig =3D dequeue_signal(&mask, info, &type);
 	if (!sig && timeout) {
 		/*
 		 * None ready, temporarily unblock those we're interested
@@ -3667,7 +3667,7 @@ static int do_sigtimedwait(const sigset_t *which, kerne=
l_siginfo_t *info,
 		spin_lock_irq(&tsk->sighand->siglock);
 		__set_task_blocked(tsk, &tsk->real_blocked);
 		sigemptyset(&tsk->real_blocked);
-		sig =3D dequeue_signal(tsk, &mask, info, &type);
+		sig =3D dequeue_signal(&mask, info, &type);
 	}
 	spin_unlock_irq(&tsk->sighand->siglock);
=20
diff --git a/kernel/sys.c b/kernel/sys.c
index 3a2df1bd9f64..e3c4cffb520c 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2557,6 +2557,8 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2=
, unsigned long, arg3,
 			error =3D current->timer_slack_ns;
 		break;
 	case PR_SET_TIMERSLACK:
+		if (task_is_realtime(current))
+			break;
 		if (arg2 <=3D 0)
 			current->timer_slack_ns =3D
 					current->default_timer_slack_ns;
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 5abfa4390673..8bf888641694 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -493,7 +493,7 @@ static u64 __alarm_forward_now(struct alarm *alarm, ktime=
_t interval, bool throt
 		 * promised in the context of posix_timer_fn() never
 		 * materialized, but someone should really work on it.
 		 *
-		 * To prevent DOS fake @now to be 1 jiffie out which keeps
+		 * To prevent DOS fake @now to be 1 jiffy out which keeps
 		 * the overrun accounting correct but creates an
 		 * inconsistency vs. timer_gettime(2).
 		 */
@@ -574,15 +574,10 @@ static enum alarmtimer_restart alarm_handle_timer(struc=
t alarm *alarm,
 					    it.alarm.alarmtimer);
 	enum alarmtimer_restart result =3D ALARMTIMER_NORESTART;
 	unsigned long flags;
-	int si_private =3D 0;
=20
 	spin_lock_irqsave(&ptr->it_lock, flags);
=20
-	ptr->it_active =3D 0;
-	if (ptr->it_interval)
-		si_private =3D ++ptr->it_requeue_pending;
-
-	if (posix_timer_event(ptr, si_private) && ptr->it_interval) {
+	if (posix_timer_queue_signal(ptr) && ptr->it_interval) {
 		/*
 		 * Handle ignored signals and rearm the timer. This will go
 		 * away once we handle ignored signals proper. Ensure that
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 60a6484831b1..78c7bd64d0dd 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -190,7 +190,7 @@ int clockevents_tick_resume(struct clock_event_device *de=
v)
=20
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST
=20
-/* Limit min_delta to a jiffie */
+/* Limit min_delta to a jiffy */
 #define MIN_DELTA_LIMIT		(NSEC_PER_SEC / HZ)
=20
 /**
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index b8ee320208d4..e834b2bd83df 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1177,7 +1177,7 @@ static inline ktime_t hrtimer_update_lowres(struct hrti=
mer *timer, ktime_t tim,
 	/*
 	 * CONFIG_TIME_LOW_RES indicates that the system has no way to return
 	 * granular time values. For relative timers we add hrtimer_resolution
-	 * (i.e. one jiffie) to prevent short timeouts.
+	 * (i.e. one jiffy) to prevent short timeouts.
 	 */
 	timer->is_rel =3D mode & HRTIMER_MODE_REL;
 	if (timer->is_rel)
@@ -1351,11 +1351,13 @@ static void hrtimer_cpu_base_init_expiry_lock(struct =
hrtimer_cpu_base *base)
 }
=20
 static void hrtimer_cpu_base_lock_expiry(struct hrtimer_cpu_base *base)
+	__acquires(&base->softirq_expiry_lock)
 {
 	spin_lock(&base->softirq_expiry_lock);
 }
=20
 static void hrtimer_cpu_base_unlock_expiry(struct hrtimer_cpu_base *base)
+	__releases(&base->softirq_expiry_lock)
 {
 	spin_unlock(&base->softirq_expiry_lock);
 }
@@ -2072,14 +2074,9 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtime=
r_mode mode,
 	struct restart_block *restart;
 	struct hrtimer_sleeper t;
 	int ret =3D 0;
-	u64 slack;
-
-	slack =3D current->timer_slack_ns;
-	if (rt_task(current))
-		slack =3D 0;
=20
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
-	hrtimer_set_expires_range_ns(&t.timer, rqtp, slack);
+	hrtimer_set_expires_range_ns(&t.timer, rqtp, current->timer_slack_ns);
 	ret =3D do_nanosleep(&t, mode);
 	if (ret !=3D -ERESTART_RESTARTBLOCK)
 		goto out;
@@ -2249,7 +2246,7 @@ void __init hrtimers_init(void)
 /**
  * schedule_hrtimeout_range_clock - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
+ * @delta:	slack in expires timeout (ktime_t)
  * @mode:	timer mode
  * @clock_id:	timer clock to be used
  */
@@ -2276,13 +2273,6 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 d=
elta,
 		return -EINTR;
 	}
=20
-	/*
-	 * Override any slack passed by the user if under
-	 * rt contraints.
-	 */
-	if (rt_task(current))
-		delta =3D 0;
-
 	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
 	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
 	hrtimer_sleeper_start_expires(&t, mode);
@@ -2302,7 +2292,7 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
 /**
  * schedule_hrtimeout_range - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
+ * @delta:	slack in expires timeout (ktime_t)
  * @mode:	timer mode
  *
  * Make the current task sleep until the given expiry time has
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 8d2dd214ec68..802b336f4b8c 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -660,8 +660,16 @@ static void sync_hw_clock(struct work_struct *work)
 	sched_sync_hw_clock(offset_nsec, res !=3D 0);
 }
=20
-void ntp_notify_cmos_timer(void)
+void ntp_notify_cmos_timer(bool offset_set)
 {
+	/*
+	 * If the time jumped (using ADJ_SETOFFSET) cancels sync timer,
+	 * which may have been running if the time was synchronized
+	 * prior to the ADJ_SETOFFSET call.
+	 */
+	if (offset_set)
+		hrtimer_cancel(&sync_hrtimer);
+
 	/*
 	 * When the work is currently executed but has not yet the timer
 	 * rearmed this queues the work immediately again. No big issue,
diff --git a/kernel/time/ntp_internal.h b/kernel/time/ntp_internal.h
index 23d1b74c3065..5a633dce9057 100644
--- a/kernel/time/ntp_internal.h
+++ b/kernel/time/ntp_internal.h
@@ -14,9 +14,9 @@ extern int __do_adjtimex(struct __kernel_timex *txc,
 extern void __hardpps(const struct timespec64 *phase_ts, const struct timesp=
ec64 *raw_ts);
=20
 #if defined(CONFIG_GENERIC_CMOS_UPDATE) || defined(CONFIG_RTC_SYSTOHC)
-extern void ntp_notify_cmos_timer(void);
+extern void ntp_notify_cmos_timer(bool offset_set);
 #else
-static inline void ntp_notify_cmos_timer(void) { }
+static inline void ntp_notify_cmos_timer(bool offset_set) { }
 #endif
=20
 #endif /* _LINUX_NTP_INTERNAL_H */
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index e9c6f9d0e42c..6bcee4704059 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -453,6 +453,7 @@ static void disarm_timer(struct k_itimer *timer, struct t=
ask_struct *p)
 	struct cpu_timer *ctmr =3D &timer->it.cpu;
 	struct posix_cputimer_base *base;
=20
+	timer->it_active =3D 0;
 	if (!cpu_timer_dequeue(ctmr))
 		return;
=20
@@ -559,6 +560,7 @@ static void arm_timer(struct k_itimer *timer, struct task=
_struct *p)
 	struct cpu_timer *ctmr =3D &timer->it.cpu;
 	u64 newexp =3D cpu_timer_getexpires(ctmr);
=20
+	timer->it_active =3D 1;
 	if (!cpu_timer_enqueue(&base->tqhead, ctmr))
 		return;
=20
@@ -584,12 +586,8 @@ static void cpu_timer_fire(struct k_itimer *timer)
 {
 	struct cpu_timer *ctmr =3D &timer->it.cpu;
=20
-	if ((timer->it_sigev_notify & ~SIGEV_THREAD_ID) =3D=3D SIGEV_NONE) {
-		/*
-		 * User don't want any signal.
-		 */
-		cpu_timer_setexpires(ctmr, 0);
-	} else if (unlikely(timer->sigq =3D=3D NULL)) {
+	timer->it_active =3D 0;
+	if (unlikely(timer->sigq =3D=3D NULL)) {
 		/*
 		 * This a special case for clock_nanosleep,
 		 * not a normal timer from sys_timer_create.
@@ -600,9 +598,9 @@ static void cpu_timer_fire(struct k_itimer *timer)
 		/*
 		 * One-shot timer.  Clear it as soon as it's fired.
 		 */
-		posix_timer_event(timer, 0);
+		posix_timer_queue_signal(timer);
 		cpu_timer_setexpires(ctmr, 0);
-	} else if (posix_timer_event(timer, ++timer->it_requeue_pending)) {
+	} else if (posix_timer_queue_signal(timer)) {
 		/*
 		 * The signal did not get queued because the signal
 		 * was ignored, so we won't get any callback to
@@ -614,6 +612,8 @@ static void cpu_timer_fire(struct k_itimer *timer)
 	}
 }
=20
+static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec6=
4 *itp, u64 now);
+
 /*
  * Guts of sys_timer_settime for CPU timers.
  * This is called with the timer locked and interrupts disabled.
@@ -623,9 +623,10 @@ static void cpu_timer_fire(struct k_itimer *timer)
 static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 			       struct itimerspec64 *new, struct itimerspec64 *old)
 {
+	bool sigev_none =3D timer->it_sigev_notify =3D=3D SIGEV_NONE;
 	clockid_t clkid =3D CPUCLOCK_WHICH(timer->it_clock);
-	u64 old_expires, new_expires, old_incr, val;
 	struct cpu_timer *ctmr =3D &timer->it.cpu;
+	u64 old_expires, new_expires, now;
 	struct sighand_struct *sighand;
 	struct task_struct *p;
 	unsigned long flags;
@@ -662,10 +663,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, i=
nt timer_flags,
 		return -ESRCH;
 	}
=20
-	/*
-	 * Disarm any old timer after extracting its expiry time.
-	 */
-	old_incr =3D timer->it_interval;
+	/* Retrieve the current expiry time before disarming the timer */
 	old_expires =3D cpu_timer_getexpires(ctmr);
=20
 	if (unlikely(timer->it.cpu.firing)) {
@@ -673,157 +671,122 @@ static int posix_cpu_timer_set(struct k_itimer *timer=
, int timer_flags,
 		ret =3D TIMER_RETRY;
 	} else {
 		cpu_timer_dequeue(ctmr);
+		timer->it_active =3D 0;
 	}
=20
 	/*
-	 * We need to sample the current value to convert the new
-	 * value from to relative and absolute, and to convert the
-	 * old value from absolute to relative.  To set a process
-	 * timer, we need a sample to balance the thread expiry
-	 * times (in arm_timer).  With an absolute time, we must
-	 * check if it's already passed.  In short, we need a sample.
+	 * Sample the current clock for saving the previous setting
+	 * and for rearming the timer.
 	 */
 	if (CPUCLOCK_PERTHREAD(timer->it_clock))
-		val =3D cpu_clock_sample(clkid, p);
+		now =3D cpu_clock_sample(clkid, p);
 	else
-		val =3D cpu_clock_sample_group(clkid, p, true);
+		now =3D cpu_clock_sample_group(clkid, p, !sigev_none);
=20
+	/* Retrieve the previous expiry value if requested. */
 	if (old) {
-		if (old_expires =3D=3D 0) {
-			old->it_value.tv_sec =3D 0;
-			old->it_value.tv_nsec =3D 0;
-		} else {
-			/*
-			 * Update the timer in case it has overrun already.
-			 * If it has, we'll report it as having overrun and
-			 * with the next reloaded timer already ticking,
-			 * though we are swallowing that pending
-			 * notification here to install the new setting.
-			 */
-			u64 exp =3D bump_cpu_timer(timer, val);
-
-			if (val < exp) {
-				old_expires =3D exp - val;
-				old->it_value =3D ns_to_timespec64(old_expires);
-			} else {
-				old->it_value.tv_nsec =3D 1;
-				old->it_value.tv_sec =3D 0;
-			}
-		}
+		old->it_value =3D (struct timespec64){ };
+		if (old_expires)
+			__posix_cpu_timer_get(timer, old, now);
 	}
=20
+	/* Retry if the timer expiry is running concurrently */
 	if (unlikely(ret)) {
-		/*
-		 * We are colliding with the timer actually firing.
-		 * Punt after filling in the timer's old value, and
-		 * disable this firing since we are already reporting
-		 * it as an overrun (thanks to bump_cpu_timer above).
-		 */
 		unlock_task_sighand(p, &flags);
 		goto out;
 	}
=20
-	if (new_expires !=3D 0 && !(timer_flags & TIMER_ABSTIME)) {
-		new_expires +=3D val;
-	}
+	/* Convert relative expiry time to absolute */
+	if (new_expires && !(timer_flags & TIMER_ABSTIME))
+		new_expires +=3D now;
+
+	/* Set the new expiry time (might be 0) */
+	cpu_timer_setexpires(ctmr, new_expires);
=20
 	/*
-	 * Install the new expiry time (or zero).
-	 * For a timer with no notification action, we don't actually
-	 * arm the timer (we'll just fake it for timer_gettime).
+	 * Arm the timer if it is not disabled, the new expiry value has
+	 * not yet expired and the timer requires signal delivery.
+	 * SIGEV_NONE timers are never armed. In case the timer is not
+	 * armed, enforce the reevaluation of the timer base so that the
+	 * process wide cputime counter can be disabled eventually.
 	 */
-	cpu_timer_setexpires(ctmr, new_expires);
-	if (new_expires !=3D 0 && val < new_expires) {
-		arm_timer(timer, p);
+	if (likely(!sigev_none)) {
+		if (new_expires && now < new_expires)
+			arm_timer(timer, p);
+		else
+			trigger_base_recalc_expires(timer, p);
 	}
=20
 	unlock_task_sighand(p, &flags);
+
+	posix_timer_set_common(timer, new);
+
 	/*
-	 * Install the new reload setting, and
-	 * set up the signal and overrun bookkeeping.
+	 * If the new expiry time was already in the past the timer was not
+	 * queued. Fire it immediately even if the thread never runs to
+	 * accumulate more time on this clock.
 	 */
-	timer->it_interval =3D timespec64_to_ktime(new->it_interval);
+	if (!sigev_none && new_expires && now >=3D new_expires)
+		cpu_timer_fire(timer);
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
+static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec6=
4 *itp, u64 now)
+{
+	bool sigev_none =3D timer->it_sigev_notify =3D=3D SIGEV_NONE;
+	u64 expires, iv =3D timer->it_interval;
=20
 	/*
-	 * This acts as a modification timestamp for the timer,
-	 * so any automatic reload attempt will punt on seeing
-	 * that we have reset the timer manually.
+	 * Make sure that interval timers are moved forward for the
+	 * following cases:
+	 *  - SIGEV_NONE timers which are never armed
+	 *  - Timers which expired, but the signal has not yet been
+	 *    delivered
 	 */
-	timer->it_requeue_pending =3D (timer->it_requeue_pending + 2) &
-		~REQUEUE_PENDING;
-	timer->it_overrun_last =3D 0;
-	timer->it_overrun =3D -1;
-
-	if (val >=3D new_expires) {
-		if (new_expires !=3D 0) {
-			/*
-			 * The designated time already passed, so we notify
-			 * immediately, even if the thread never runs to
-			 * accumulate more time on this clock.
-			 */
-			cpu_timer_fire(timer);
-		}
+	if (iv && ((timer->it_requeue_pending & REQUEUE_PENDING) || sigev_none))
+		expires =3D bump_cpu_timer(timer, now);
+	else
+		expires =3D cpu_timer_getexpires(&timer->it.cpu);
=20
+	/*
+	 * Expired interval timers cannot have a remaining time <=3D 0.
+	 * The kernel has to move them forward so that the next
+	 * timer expiry is > @now.
+	 */
+	if (now < expires) {
+		itp->it_value =3D ns_to_timespec64(expires - now);
+	} else {
 		/*
-		 * Make sure we don't keep around the process wide cputime
-		 * counter or the tick dependency if they are not necessary.
+		 * A single shot SIGEV_NONE timer must return 0, when it is
+		 * expired! Timers which have a real signal delivery mode
+		 * must return a remaining time greater than 0 because the
+		 * signal has not yet been delivered.
 		 */
-		sighand =3D lock_task_sighand(p, &flags);
-		if (!sighand)
-			goto out;
-
-		if (!cpu_timer_queued(ctmr))
-			trigger_base_recalc_expires(timer, p);
-
-		unlock_task_sighand(p, &flags);
+		if (!sigev_none)
+			itp->it_value.tv_nsec =3D 1;
 	}
- out:
-	rcu_read_unlock();
-	if (old)
-		old->it_interval =3D ns_to_timespec64(old_incr);
-
-	return ret;
 }
=20
 static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 =
*itp)
 {
 	clockid_t clkid =3D CPUCLOCK_WHICH(timer->it_clock);
-	struct cpu_timer *ctmr =3D &timer->it.cpu;
-	u64 now, expires =3D cpu_timer_getexpires(ctmr);
 	struct task_struct *p;
+	u64 now;
=20
 	rcu_read_lock();
 	p =3D cpu_timer_task_rcu(timer);
-	if (!p)
-		goto out;
+	if (p && cpu_timer_getexpires(&timer->it.cpu)) {
+		itp->it_interval =3D ktime_to_timespec64(timer->it_interval);
=20
-	/*
-	 * Easy part: convert the reload time.
-	 */
-	itp->it_interval =3D ktime_to_timespec64(timer->it_interval);
-
-	if (!expires)
-		goto out;
-
-	/*
-	 * Sample the clock to take the difference with the expiry time.
-	 */
-	if (CPUCLOCK_PERTHREAD(timer->it_clock))
-		now =3D cpu_clock_sample(clkid, p);
-	else
-		now =3D cpu_clock_sample_group(clkid, p, false);
+		if (CPUCLOCK_PERTHREAD(timer->it_clock))
+			now =3D cpu_clock_sample(clkid, p);
+		else
+			now =3D cpu_clock_sample_group(clkid, p, false);
=20
-	if (now < expires) {
-		itp->it_value =3D ns_to_timespec64(expires - now);
-	} else {
-		/*
-		 * The timer should have expired already, but the firing
-		 * hasn't taken place yet.  Say it's just about to expire.
-		 */
-		itp->it_value.tv_nsec =3D 1;
-		itp->it_value.tv_sec =3D 0;
+		__posix_cpu_timer_get(timer, itp, now);
 	}
-out:
 	rcu_read_unlock();
 }
=20
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index b924f0f096fa..4576aaed13b2 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -277,10 +277,17 @@ void posixtimer_rearm(struct kernel_siginfo *info)
 	unlock_timer(timr, flags);
 }
=20
-int posix_timer_event(struct k_itimer *timr, int si_private)
+int posix_timer_queue_signal(struct k_itimer *timr)
 {
+	int ret, si_private =3D 0;
 	enum pid_type type;
-	int ret;
+
+	lockdep_assert_held(&timr->it_lock);
+
+	timr->it_active =3D 0;
+	if (timr->it_interval)
+		si_private =3D ++timr->it_requeue_pending;
+
 	/*
 	 * FIXME: if ->sigq is queued we can race with
 	 * dequeue_signal()->posixtimer_rearm().
@@ -309,19 +316,13 @@ int posix_timer_event(struct k_itimer *timr, int si_pri=
vate)
  */
 static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 {
+	struct k_itimer *timr =3D container_of(timer, struct k_itimer, it.real.time=
r);
 	enum hrtimer_restart ret =3D HRTIMER_NORESTART;
-	struct k_itimer *timr;
 	unsigned long flags;
-	int si_private =3D 0;
=20
-	timr =3D container_of(timer, struct k_itimer, it.real.timer);
 	spin_lock_irqsave(&timr->it_lock, flags);
=20
-	timr->it_active =3D 0;
-	if (timr->it_interval !=3D 0)
-		si_private =3D ++timr->it_requeue_pending;
-
-	if (posix_timer_event(timr, si_private)) {
+	if (posix_timer_queue_signal(timr)) {
 		/*
 		 * The signal was not queued due to SIG_IGN. As a
 		 * consequence the timer is not going to be rearmed from
@@ -338,14 +339,14 @@ static enum hrtimer_restart posix_timer_fn(struct hrtim=
er *timer)
 			 * change to the signal handling code.
 			 *
 			 * For now let timers with an interval less than a
-			 * jiffie expire every jiffie and recheck for a
+			 * jiffy expire every jiffy and recheck for a
 			 * valid signal handler.
 			 *
 			 * This avoids interrupt starvation in case of a
 			 * very small interval, which would expire the
 			 * timer immediately again.
 			 *
-			 * Moving now ahead of time by one jiffie tricks
+			 * Moving now ahead of time by one jiffy tricks
 			 * hrtimer_forward() to expire the timer later,
 			 * while it still maintains the overrun accuracy
 			 * for the price of a slight inconsistency in the
@@ -515,7 +516,7 @@ static int do_timer_create(clockid_t which_clock, struct =
sigevent *event,
 	spin_lock_irq(&current->sighand->siglock);
 	/* This makes the timer valid in the hash table */
 	WRITE_ONCE(new_timer->it_signal, current->signal);
-	list_add(&new_timer->list, &current->signal->posix_timers);
+	hlist_add_head(&new_timer->list, &current->signal->posix_timers);
 	spin_unlock_irq(&current->sighand->siglock);
 	/*
 	 * After unlocking sighand::siglock @new_timer is subject to
@@ -856,6 +857,23 @@ static struct k_itimer *timer_wait_running(struct k_itim=
er *timer,
 	return lock_timer(timer_id, flags);
 }
=20
+/*
+ * Set up the new interval and reset the signal delivery data
+ */
+void posix_timer_set_common(struct k_itimer *timer, struct itimerspec64 *new=
_setting)
+{
+	if (new_setting->it_value.tv_sec || new_setting->it_value.tv_nsec)
+		timer->it_interval =3D timespec64_to_ktime(new_setting->it_interval);
+	else
+		timer->it_interval =3D 0;
+
+	/* Prevent reloading in case there is a signal pending */
+	timer->it_requeue_pending =3D (timer->it_requeue_pending + 2) & ~REQUEUE_PE=
NDING;
+	/* Reset overrun accounting */
+	timer->it_overrun_last =3D 0;
+	timer->it_overrun =3D -1LL;
+}
+
 /* Set a POSIX.1b interval timer. */
 int common_timer_set(struct k_itimer *timr, int flags,
 		     struct itimerspec64 *new_setting,
@@ -878,15 +896,12 @@ int common_timer_set(struct k_itimer *timr, int flags,
 		return TIMER_RETRY;
=20
 	timr->it_active =3D 0;
-	timr->it_requeue_pending =3D (timr->it_requeue_pending + 2) &
-		~REQUEUE_PENDING;
-	timr->it_overrun_last =3D 0;
+	posix_timer_set_common(timr, new_setting);
=20
-	/* Switch off the timer when it_value is zero */
+	/* Keep timer disarmed when it_value is zero */
 	if (!new_setting->it_value.tv_sec && !new_setting->it_value.tv_nsec)
 		return 0;
=20
-	timr->it_interval =3D timespec64_to_ktime(new_setting->it_interval);
 	expires =3D timespec64_to_ktime(new_setting->it_value);
 	if (flags & TIMER_ABSTIME)
 		expires =3D timens_ktime_to_host(timr->it_clock, expires);
@@ -904,7 +919,7 @@ static int do_timer_settime(timer_t timer_id, int tmr_fla=
gs,
 	const struct k_clock *kc;
 	struct k_itimer *timr;
 	unsigned long flags;
-	int error =3D 0;
+	int error;
=20
 	if (!timespec64_valid(&new_spec64->it_interval) ||
 	    !timespec64_valid(&new_spec64->it_value))
@@ -918,6 +933,9 @@ static int do_timer_settime(timer_t timer_id, int tmr_fla=
gs,
 	if (!timr)
 		return -EINVAL;
=20
+	if (old_spec64)
+		old_spec64->it_interval =3D ktime_to_timespec64(timr->it_interval);
+
 	kc =3D timr->kclock;
 	if (WARN_ON_ONCE(!kc || !kc->timer_set))
 		error =3D -EINVAL;
@@ -1021,7 +1039,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 	}
=20
 	spin_lock(&current->sighand->siglock);
-	list_del(&timer->list);
+	hlist_del(&timer->list);
 	spin_unlock(&current->sighand->siglock);
 	/*
 	 * A concurrent lookup could check timer::it_signal lockless. It
@@ -1071,7 +1089,7 @@ static void itimer_delete(struct k_itimer *timer)
=20
 		goto retry_delete;
 	}
-	list_del(&timer->list);
+	hlist_del(&timer->list);
=20
 	/*
 	 * Setting timer::it_signal to NULL is technically not required
@@ -1092,22 +1110,19 @@ static void itimer_delete(struct k_itimer *timer)
  */
 void exit_itimers(struct task_struct *tsk)
 {
-	struct list_head timers;
-	struct k_itimer *tmr;
+	struct hlist_head timers;
=20
-	if (list_empty(&tsk->signal->posix_timers))
+	if (hlist_empty(&tsk->signal->posix_timers))
 		return;
=20
 	/* Protect against concurrent read via /proc/$PID/timers */
 	spin_lock_irq(&tsk->sighand->siglock);
-	list_replace_init(&tsk->signal->posix_timers, &timers);
+	hlist_move_list(&tsk->signal->posix_timers, &timers);
 	spin_unlock_irq(&tsk->sighand->siglock);
=20
 	/* The timers are not longer accessible via tsk::signal */
-	while (!list_empty(&timers)) {
-		tmr =3D list_first_entry(&timers, struct k_itimer, list);
-		itimer_delete(tmr);
-	}
+	while (!hlist_empty(&timers))
+		itimer_delete(hlist_entry(timers.first, struct k_itimer, list));
 }
=20
 SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index f32a2ebba9b8..4784ea65f685 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -36,10 +36,11 @@ extern const struct k_clock clock_process;
 extern const struct k_clock clock_thread;
 extern const struct k_clock alarm_clock;
=20
-int posix_timer_event(struct k_itimer *timr, int si_private);
+int posix_timer_queue_signal(struct k_itimer *timr);
=20
 void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_settin=
g);
 int common_timer_set(struct k_itimer *timr, int flags,
 		     struct itimerspec64 *new_setting,
 		     struct itimerspec64 *old_setting);
+void posix_timer_set_common(struct k_itimer *timer, struct itimerspec64 *new=
_setting);
 int common_timer_del(struct k_itimer *timer);
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5391e4167d60..7e6f409bf311 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2553,6 +2553,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 {
 	struct timekeeper *tk =3D &tk_core.timekeeper;
 	struct audit_ntp_data ad;
+	bool offset_set =3D false;
 	bool clock_set =3D false;
 	struct timespec64 ts;
 	unsigned long flags;
@@ -2575,6 +2576,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 		if (ret)
 			return ret;
=20
+		offset_set =3D delta.tv_sec !=3D 0;
 		audit_tk_injoffset(delta);
 	}
=20
@@ -2608,7 +2610,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 	if (clock_set)
 		clock_was_set(CLOCK_SET_WALL);
=20
-	ntp_notify_cmos_timer();
+	ntp_notify_cmos_timer(offset_set);
=20
 	return ret;
 }
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 64b0d8a0aa0f..2b38f3035a3e 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -365,7 +365,7 @@ static unsigned long round_jiffies_common(unsigned long j=
, int cpu,
 	rem =3D j % HZ;
=20
 	/*
-	 * If the target jiffie is just after a whole second (which can happen
+	 * If the target jiffy is just after a whole second (which can happen
 	 * due to delays of the timer irq, long irq off times etc etc) then
 	 * we should round down to the whole second, not up. Use 1/4th second
 	 * as cutoff for this rounding as an extreme upper bound for this.
@@ -672,7 +672,7 @@ static void enqueue_timer(struct timer_base *base, struct=
 timer_list *timer,
 		 * Set the next expiry time and kick the CPU so it
 		 * can reevaluate the wheel:
 		 */
-		base->next_expiry =3D bucket_expiry;
+		WRITE_ONCE(base->next_expiry, bucket_expiry);
 		base->timers_pending =3D true;
 		base->next_expiry_recalc =3D false;
 		trigger_dyntick_cpu(base, timer);
@@ -1561,6 +1561,8 @@ static inline void timer_base_unlock_expiry(struct time=
r_base *base)
  * the waiter to acquire the lock and make progress.
  */
 static void timer_sync_wait_running(struct timer_base *base)
+	__releases(&base->lock) __releases(&base->expiry_lock)
+	__acquires(&base->expiry_lock) __acquires(&base->lock)
 {
 	if (atomic_read(&base->timer_waiters)) {
 		raw_spin_unlock_irq(&base->lock);
@@ -1898,7 +1900,7 @@ static int next_pending_bucket(struct timer_base *base,=
 unsigned offset,
  *
  * Store next expiry time in base->next_expiry.
  */
-static void next_expiry_recalc(struct timer_base *base)
+static void timer_recalc_next_expiry(struct timer_base *base)
 {
 	unsigned long clk, next, adj;
 	unsigned lvl, offset =3D 0;
@@ -1928,7 +1930,7 @@ static void next_expiry_recalc(struct timer_base *base)
 		 * bits are zero, we look at the next level as is. If not we
 		 * need to advance it by one because that's going to be the
 		 * next expiring bucket in that level. base->clk is the next
-		 * expiring jiffie. So in case of:
+		 * expiring jiffy. So in case of:
 		 *
 		 * LVL5 LVL4 LVL3 LVL2 LVL1 LVL0
 		 *  0    0    0    0    0    0
@@ -1964,7 +1966,7 @@ static void next_expiry_recalc(struct timer_base *base)
 		clk +=3D adj;
 	}
=20
-	base->next_expiry =3D next;
+	WRITE_ONCE(base->next_expiry, next);
 	base->next_expiry_recalc =3D false;
 	base->timers_pending =3D !(next =3D=3D base->clk + NEXT_TIMER_MAX_DELTA);
 }
@@ -1993,7 +1995,7 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expire=
s)
 		return basem;
=20
 	/*
-	 * Round up to the next jiffie. High resolution timers are
+	 * Round up to the next jiffy. High resolution timers are
 	 * off, so the hrtimers are expired in the tick and we need to
 	 * make sure that this tick really expires the timer to avoid
 	 * a ping pong of the nohz stop code.
@@ -2007,7 +2009,7 @@ static unsigned long next_timer_interrupt(struct timer_=
base *base,
 					  unsigned long basej)
 {
 	if (base->next_expiry_recalc)
-		next_expiry_recalc(base);
+		timer_recalc_next_expiry(base);
=20
 	/*
 	 * Move next_expiry for the empty base into the future to prevent an
@@ -2018,7 +2020,7 @@ static unsigned long next_timer_interrupt(struct timer_=
base *base,
 	 * easy comparable to find out which base holds the first pending timer.
 	 */
 	if (!base->timers_pending)
-		base->next_expiry =3D basej + NEXT_TIMER_MAX_DELTA;
+		WRITE_ONCE(base->next_expiry, basej + NEXT_TIMER_MAX_DELTA);
=20
 	return base->next_expiry;
 }
@@ -2252,7 +2254,7 @@ static inline u64 __get_next_timer_interrupt(unsigned l=
ong basej, u64 basem,
 					     base_global, &tevt);
=20
 	/*
-	 * If the next event is only one jiffie ahead there is no need to call
+	 * If the next event is only one jiffy ahead there is no need to call
 	 * timer migration hierarchy related functions. The value for the next
 	 * global timer in @tevt struct equals then KTIME_MAX. This is also
 	 * true, when the timer base is idle.
@@ -2411,7 +2413,7 @@ static inline void __run_timers(struct timer_base *base)
 		 * jiffies to avoid endless requeuing to current jiffies.
 		 */
 		base->clk++;
-		next_expiry_recalc(base);
+		timer_recalc_next_expiry(base);
=20
 		while (levels--)
 			expire_timers(base, heads + levels);
@@ -2462,8 +2464,40 @@ static void run_local_timers(void)
 	hrtimer_run_queues();
=20
 	for (int i =3D 0; i < NR_BASES; i++, base++) {
-		/* Raise the softirq only if required. */
-		if (time_after_eq(jiffies, base->next_expiry) ||
+		/*
+		 * Raise the softirq only if required.
+		 *
+		 * timer_base::next_expiry can be written by a remote CPU while
+		 * holding the lock. If this write happens at the same time than
+		 * the lockless local read, sanity checker could complain about
+		 * data corruption.
+		 *
+		 * There are two possible situations where
+		 * timer_base::next_expiry is written by a remote CPU:
+		 *
+		 * 1. Remote CPU expires global timers of this CPU and updates
+		 * timer_base::next_expiry of BASE_GLOBAL afterwards in
+		 * next_timer_interrupt() or timer_recalc_next_expiry(). The
+		 * worst outcome is a superfluous raise of the timer softirq
+		 * when the not yet updated value is read.
+		 *
+		 * 2. A new first pinned timer is enqueued by a remote CPU
+		 * and therefore timer_base::next_expiry of BASE_LOCAL is
+		 * updated. When this update is missed, this isn't a
+		 * problem, as an IPI is executed nevertheless when the CPU
+		 * was idle before. When the CPU wasn't idle but the update
+		 * is missed, then the timer would expire one jiffy late -
+		 * bad luck.
+		 *
+		 * Those unlikely corner cases where the worst outcome is only a
+		 * one jiffy delay or a superfluous raise of the softirq are
+		 * not that expensive as doing the check always while holding
+		 * the lock.
+		 *
+		 * Possible remote writers are using WRITE_ONCE(). Local reader
+		 * uses therefore READ_ONCE().
+		 */
+		if (time_after_eq(jiffies, READ_ONCE(base->next_expiry)) ||
 		    (i =3D=3D BASE_DEF && tmigr_requires_handle_remote())) {
 			raise_softirq(TIMER_SOFTIRQ);
 			return;
@@ -2730,7 +2764,7 @@ void __init init_timers(void)
  */
 void msleep(unsigned int msecs)
 {
-	unsigned long timeout =3D msecs_to_jiffies(msecs) + 1;
+	unsigned long timeout =3D msecs_to_jiffies(msecs);
=20
 	while (timeout)
 		timeout =3D schedule_timeout_uninterruptible(timeout);
@@ -2744,7 +2778,7 @@ EXPORT_SYMBOL(msleep);
  */
 unsigned long msleep_interruptible(unsigned int msecs)
 {
-	unsigned long timeout =3D msecs_to_jiffies(msecs) + 1;
+	unsigned long timeout =3D msecs_to_jiffies(msecs);
=20
 	while (timeout && !signal_pending(current))
 		timeout =3D schedule_timeout_interruptible(timeout);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a30c03a66172..a40aa606cd04 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -97,7 +97,7 @@ config BOOT_PRINTK_DELAY
 	  using "boot_delay=3DN".
=20
 	  It is likely that you would also need to use "lpj=3DM" to preset
-	  the "loops per jiffie" value.
+	  the "loops per jiffy" value.
 	  See a previous boot log for the "lpj" value to use for your
 	  system, and then set "lpj=3DM" before setting "boot_delay=3DN".
 	  NOTE:  Using this option may adversely affect SMP systems.
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 00840d5784fe..04f6398b3a40 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -287,7 +287,7 @@ struct batadv_frag_table_entry {
 	/** @lock: lock to protect the list of fragments */
 	spinlock_t lock;
=20
-	/** @timestamp: time (jiffie) of last received fragment */
+	/** @timestamp: time (jiffy) of last received fragment */
 	unsigned long timestamp;
=20
 	/** @seqno: sequence number of the fragments in the list */
diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/se=
lftests/timers/posix_timers.c
index 07c81c0093c0..16bd49492efa 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -6,10 +6,13 @@
  *
  * Kernel loop code stolen from Steven Rostedt <srostedt@redhat.com>
  */
-
+#define _GNU_SOURCE
 #include <sys/time.h>
+#include <sys/types.h>
 #include <stdio.h>
 #include <signal.h>
+#include <stdint.h>
+#include <string.h>
 #include <unistd.h>
 #include <time.h>
 #include <pthread.h>
@@ -18,6 +21,21 @@
=20
 #define DELAY 2
 #define USECS_PER_SEC 1000000
+#define NSECS_PER_SEC 1000000000
+
+static void __fatal_error(const char *test, const char *name, const char *wh=
at)
+{
+	char buf[64];
+
+	strerror_r(errno, buf, sizeof(buf));
+
+	if (name && strlen(name))
+		ksft_exit_fail_msg("%s %s %s %s\n", test, name, what, buf);
+	else
+		ksft_exit_fail_msg("%s %s %s\n", test, what, buf);
+}
+
+#define fatal_error(name, what)	__fatal_error(__func__, name, what)
=20
 static volatile int done;
=20
@@ -74,24 +92,13 @@ static int check_diff(struct timeval start, struct timeva=
l end)
 	return 0;
 }
=20
-static int check_itimer(int which)
+static void check_itimer(int which, const char *name)
 {
-	const char *name;
-	int err;
 	struct timeval start, end;
 	struct itimerval val =3D {
 		.it_value.tv_sec =3D DELAY,
 	};
=20
-	if (which =3D=3D ITIMER_VIRTUAL)
-		name =3D "ITIMER_VIRTUAL";
-	else if (which =3D=3D ITIMER_PROF)
-		name =3D "ITIMER_PROF";
-	else if (which =3D=3D ITIMER_REAL)
-		name =3D "ITIMER_REAL";
-	else
-		return -1;
-
 	done =3D 0;
=20
 	if (which =3D=3D ITIMER_VIRTUAL)
@@ -101,17 +108,11 @@ static int check_itimer(int which)
 	else if (which =3D=3D ITIMER_REAL)
 		signal(SIGALRM, sig_handler);
=20
-	err =3D gettimeofday(&start, NULL);
-	if (err < 0) {
-		ksft_perror("Can't call gettimeofday()");
-		return -1;
-	}
+	if (gettimeofday(&start, NULL) < 0)
+		fatal_error(name, "gettimeofday()");
=20
-	err =3D setitimer(which, &val, NULL);
-	if (err < 0) {
-		ksft_perror("Can't set timer");
-		return -1;
-	}
+	if (setitimer(which, &val, NULL) < 0)
+		fatal_error(name, "setitimer()");
=20
 	if (which =3D=3D ITIMER_VIRTUAL)
 		user_loop();
@@ -120,68 +121,41 @@ static int check_itimer(int which)
 	else if (which =3D=3D ITIMER_REAL)
 		idle_loop();
=20
-	err =3D gettimeofday(&end, NULL);
-	if (err < 0) {
-		ksft_perror("Can't call gettimeofday()");
-		return -1;
-	}
+	if (gettimeofday(&end, NULL) < 0)
+		fatal_error(name, "gettimeofday()");
=20
 	ksft_test_result(check_diff(start, end) =3D=3D 0, "%s\n", name);
-
-	return 0;
 }
=20
-static int check_timer_create(int which)
+static void check_timer_create(int which, const char *name)
 {
-	const char *type;
-	int err;
-	timer_t id;
 	struct timeval start, end;
 	struct itimerspec val =3D {
 		.it_value.tv_sec =3D DELAY,
 	};
-
-	if (which =3D=3D CLOCK_THREAD_CPUTIME_ID) {
-		type =3D "thread";
-	} else if (which =3D=3D CLOCK_PROCESS_CPUTIME_ID) {
-		type =3D "process";
-	} else {
-		ksft_print_msg("Unknown timer_create() type %d\n", which);
-		return -1;
-	}
+	timer_t id;
=20
 	done =3D 0;
-	err =3D timer_create(which, NULL, &id);
-	if (err < 0) {
-		ksft_perror("Can't create timer");
-		return -1;
-	}
-	signal(SIGALRM, sig_handler);
=20
-	err =3D gettimeofday(&start, NULL);
-	if (err < 0) {
-		ksft_perror("Can't call gettimeofday()");
-		return -1;
-	}
+	if (timer_create(which, NULL, &id) < 0)
+		fatal_error(name, "timer_create()");
=20
-	err =3D timer_settime(id, 0, &val, NULL);
-	if (err < 0) {
-		ksft_perror("Can't set timer");
-		return -1;
-	}
+	if (signal(SIGALRM, sig_handler) =3D=3D SIG_ERR)
+		fatal_error(name, "signal()");
+
+	if (gettimeofday(&start, NULL) < 0)
+		fatal_error(name, "gettimeofday()");
+
+	if (timer_settime(id, 0, &val, NULL) < 0)
+		fatal_error(name, "timer_settime()");
=20
 	user_loop();
=20
-	err =3D gettimeofday(&end, NULL);
-	if (err < 0) {
-		ksft_perror("Can't call gettimeofday()");
-		return -1;
-	}
+	if (gettimeofday(&end, NULL) < 0)
+		fatal_error(name, "gettimeofday()");
=20
 	ksft_test_result(check_diff(start, end) =3D=3D 0,
-			 "timer_create() per %s\n", type);
-
-	return 0;
+			 "timer_create() per %s\n", name);
 }
=20
 static pthread_t ctd_thread;
@@ -209,15 +183,14 @@ static void *ctd_thread_func(void *arg)
=20
 	ctd_count =3D 100;
 	if (timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id))
-		return "Can't create timer\n";
+		fatal_error(NULL, "timer_create()");
 	if (timer_settime(id, 0, &val, NULL))
-		return "Can't set timer\n";
-
+		fatal_error(NULL, "timer_settime()");
 	while (ctd_count > 0 && !ctd_failed)
 		;
=20
 	if (timer_delete(id))
-		return "Can't delete timer\n";
+		fatal_error(NULL, "timer_delete()");
=20
 	return NULL;
 }
@@ -225,19 +198,16 @@ static void *ctd_thread_func(void *arg)
 /*
  * Test that only the running thread receives the timer signal.
  */
-static int check_timer_distribution(void)
+static void check_timer_distribution(void)
 {
-	const char *errmsg;
+	if (signal(SIGALRM, ctd_sighandler) =3D=3D SIG_ERR)
+		fatal_error(NULL, "signal()");
=20
-	signal(SIGALRM, ctd_sighandler);
-
-	errmsg =3D "Can't create thread\n";
 	if (pthread_create(&ctd_thread, NULL, ctd_thread_func, NULL))
-		goto err;
+		fatal_error(NULL, "pthread_create()");
=20
-	errmsg =3D "Can't join thread\n";
-	if (pthread_join(ctd_thread, (void **)&errmsg) || errmsg)
-		goto err;
+	if (pthread_join(ctd_thread, NULL))
+		fatal_error(NULL, "pthread_join()");
=20
 	if (!ctd_failed)
 		ksft_test_result_pass("check signal distribution\n");
@@ -245,31 +215,399 @@ static int check_timer_distribution(void)
 		ksft_test_result_fail("check signal distribution\n");
 	else
 		ksft_test_result_skip("check signal distribution (old kernel)\n");
-	return 0;
-err:
-	ksft_print_msg("%s", errmsg);
-	return -1;
+}
+
+struct tmrsig {
+	int	signals;
+	int	overruns;
+};
+
+static void siginfo_handler(int sig, siginfo_t *si, void *uc)
+{
+	struct tmrsig *tsig =3D si ? si->si_ptr : NULL;
+
+	if (tsig) {
+		tsig->signals++;
+		tsig->overruns +=3D si->si_overrun;
+	}
+}
+
+static void *ignore_thread(void *arg)
+{
+	unsigned int *tid =3D arg;
+	sigset_t set;
+
+	sigemptyset(&set);
+	sigaddset(&set, SIGUSR1);
+	if (sigprocmask(SIG_BLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_BLOCK)");
+
+	*tid =3D gettid();
+	sleep(100);
+
+	if (sigprocmask(SIG_UNBLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_UNBLOCK)");
+	return NULL;
+}
+
+static void check_sig_ign(int thread)
+{
+	struct tmrsig tsig =3D { };
+	struct itimerspec its;
+	unsigned int tid =3D 0;
+	struct sigaction sa;
+	struct sigevent sev;
+	pthread_t pthread;
+	timer_t timerid;
+	sigset_t set;
+
+	if (thread) {
+		if (pthread_create(&pthread, NULL, ignore_thread, &tid))
+			fatal_error(NULL, "pthread_create()");
+		sleep(1);
+	}
+
+	sa.sa_flags =3D SA_SIGINFO;
+	sa.sa_sigaction =3D siginfo_handler;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGUSR1, &sa, NULL))
+		fatal_error(NULL, "sigaction()");
+
+	/* Block the signal */
+	sigemptyset(&set);
+	sigaddset(&set, SIGUSR1);
+	if (sigprocmask(SIG_BLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_BLOCK)");
+
+	memset(&sev, 0, sizeof(sev));
+	sev.sigev_notify =3D SIGEV_SIGNAL;
+	sev.sigev_signo =3D SIGUSR1;
+	sev.sigev_value.sival_ptr =3D &tsig;
+	if (thread) {
+		sev.sigev_notify =3D SIGEV_THREAD_ID;
+		sev._sigev_un._tid =3D tid;
+	}
+
+	if (timer_create(CLOCK_MONOTONIC, &sev, &timerid))
+		fatal_error(NULL, "timer_create()");
+
+	/* Start the timer to expire in 100ms and 100ms intervals */
+	its.it_value.tv_sec =3D 0;
+	its.it_value.tv_nsec =3D 100000000;
+	its.it_interval.tv_sec =3D 0;
+	its.it_interval.tv_nsec =3D 100000000;
+	timer_settime(timerid, 0, &its, NULL);
+
+	sleep(1);
+
+	/* Set the signal to be ignored */
+	if (signal(SIGUSR1, SIG_IGN) =3D=3D SIG_ERR)
+		fatal_error(NULL, "signal(SIG_IGN)");
+
+	sleep(1);
+
+	if (thread) {
+		/* Stop the thread first. No signal should be delivered to it */
+		if (pthread_cancel(pthread))
+			fatal_error(NULL, "pthread_cancel()");
+		if (pthread_join(pthread, NULL))
+			fatal_error(NULL, "pthread_join()");
+	}
+
+	/* Restore the handler */
+	if (sigaction(SIGUSR1, &sa, NULL))
+		fatal_error(NULL, "sigaction()");
+
+	sleep(1);
+
+	/* Unblock it, which should deliver the signal in the !thread case*/
+	if (sigprocmask(SIG_UNBLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_UNBLOCK)");
+
+	if (timer_delete(timerid))
+		fatal_error(NULL, "timer_delete()");
+
+	if (!thread) {
+		ksft_test_result(tsig.signals =3D=3D 1 && tsig.overruns =3D=3D 29,
+				 "check_sig_ign SIGEV_SIGNAL\n");
+	} else {
+		ksft_test_result(tsig.signals =3D=3D 0 && tsig.overruns =3D=3D 0,
+				 "check_sig_ign SIGEV_THREAD_ID\n");
+	}
+}
+
+static void check_rearm(void)
+{
+	struct tmrsig tsig =3D { };
+	struct itimerspec its;
+	struct sigaction sa;
+	struct sigevent sev;
+	timer_t timerid;
+	sigset_t set;
+
+	sa.sa_flags =3D SA_SIGINFO;
+	sa.sa_sigaction =3D siginfo_handler;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGUSR1, &sa, NULL))
+		fatal_error(NULL, "sigaction()");
+
+	/* Block the signal */
+	sigemptyset(&set);
+	sigaddset(&set, SIGUSR1);
+	if (sigprocmask(SIG_BLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_BLOCK)");
+
+	memset(&sev, 0, sizeof(sev));
+	sev.sigev_notify =3D SIGEV_SIGNAL;
+	sev.sigev_signo =3D SIGUSR1;
+	sev.sigev_value.sival_ptr =3D &tsig;
+	if (timer_create(CLOCK_MONOTONIC, &sev, &timerid))
+		fatal_error(NULL, "timer_create()");
+
+	/* Start the timer to expire in 100ms and 100ms intervals */
+	its.it_value.tv_sec =3D 0;
+	its.it_value.tv_nsec =3D 100000000;
+	its.it_interval.tv_sec =3D 0;
+	its.it_interval.tv_nsec =3D 100000000;
+	if (timer_settime(timerid, 0, &its, NULL))
+		fatal_error(NULL, "timer_settime()");
+
+	sleep(1);
+
+	/* Reprogram the timer to single shot */
+	its.it_value.tv_sec =3D 10;
+	its.it_value.tv_nsec =3D 0;
+	its.it_interval.tv_sec =3D 0;
+	its.it_interval.tv_nsec =3D 0;
+	if (timer_settime(timerid, 0, &its, NULL))
+		fatal_error(NULL, "timer_settime()");
+
+	/* Unblock it, which should not deliver a signal */
+	if (sigprocmask(SIG_UNBLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_UNBLOCK)");
+
+	if (timer_delete(timerid))
+		fatal_error(NULL, "timer_delete()");
+
+	ksft_test_result(!tsig.signals, "check_rearm\n");
+}
+
+static void check_delete(void)
+{
+	struct tmrsig tsig =3D { };
+	struct itimerspec its;
+	struct sigaction sa;
+	struct sigevent sev;
+	timer_t timerid;
+	sigset_t set;
+
+	sa.sa_flags =3D SA_SIGINFO;
+	sa.sa_sigaction =3D siginfo_handler;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGUSR1, &sa, NULL))
+		fatal_error(NULL, "sigaction()");
+
+	/* Block the signal */
+	sigemptyset(&set);
+	sigaddset(&set, SIGUSR1);
+	if (sigprocmask(SIG_BLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_BLOCK)");
+
+	memset(&sev, 0, sizeof(sev));
+	sev.sigev_notify =3D SIGEV_SIGNAL;
+	sev.sigev_signo =3D SIGUSR1;
+	sev.sigev_value.sival_ptr =3D &tsig;
+	if (timer_create(CLOCK_MONOTONIC, &sev, &timerid))
+		fatal_error(NULL, "timer_create()");
+
+	/* Start the timer to expire in 100ms and 100ms intervals */
+	its.it_value.tv_sec =3D 0;
+	its.it_value.tv_nsec =3D 100000000;
+	its.it_interval.tv_sec =3D 0;
+	its.it_interval.tv_nsec =3D 100000000;
+	if (timer_settime(timerid, 0, &its, NULL))
+		fatal_error(NULL, "timer_settime()");
+
+	sleep(1);
+
+	if (timer_delete(timerid))
+		fatal_error(NULL, "timer_delete()");
+
+	/* Unblock it, which should not deliver a signal */
+	if (sigprocmask(SIG_UNBLOCK, &set, NULL))
+		fatal_error(NULL, "sigprocmask(SIG_UNBLOCK)");
+
+	ksft_test_result(!tsig.signals, "check_delete\n");
+}
+
+static inline int64_t calcdiff_ns(struct timespec t1, struct timespec t2)
+{
+	int64_t diff;
+
+	diff =3D NSECS_PER_SEC * (int64_t)((int) t1.tv_sec - (int) t2.tv_sec);
+	diff +=3D ((int) t1.tv_nsec - (int) t2.tv_nsec);
+	return diff;
+}
+
+static void check_sigev_none(int which, const char *name)
+{
+	struct timespec start, now;
+	struct itimerspec its;
+	struct sigevent sev;
+	timer_t timerid;
+
+	memset(&sev, 0, sizeof(sev));
+	sev.sigev_notify =3D SIGEV_NONE;
+
+	if (timer_create(which, &sev, &timerid))
+		fatal_error(name, "timer_create()");
+
+	/* Start the timer to expire in 100ms and 100ms intervals */
+	its.it_value.tv_sec =3D 0;
+	its.it_value.tv_nsec =3D 100000000;
+	its.it_interval.tv_sec =3D 0;
+	its.it_interval.tv_nsec =3D 100000000;
+	timer_settime(timerid, 0, &its, NULL);
+
+	if (clock_gettime(which, &start))
+		fatal_error(name, "clock_gettime()");
+
+	do {
+		if (clock_gettime(which, &now))
+			fatal_error(name, "clock_gettime()");
+	} while (calcdiff_ns(now, start) < NSECS_PER_SEC);
+
+	if (timer_gettime(timerid, &its))
+		fatal_error(name, "timer_gettime()");
+
+	if (timer_delete(timerid))
+		fatal_error(name, "timer_delete()");
+
+	ksft_test_result(its.it_value.tv_sec || its.it_value.tv_nsec,
+			 "check_sigev_none %s\n", name);
+}
+
+static void check_gettime(int which, const char *name)
+{
+	struct itimerspec its, prev;
+	struct timespec start, now;
+	struct sigevent sev;
+	timer_t timerid;
+	int wraps =3D 0;
+	sigset_t set;
+
+	/* Block the signal */
+	sigemptyset(&set);
+	sigaddset(&set, SIGUSR1);
+	if (sigprocmask(SIG_BLOCK, &set, NULL))
+		fatal_error(name, "sigprocmask(SIG_BLOCK)");
+
+	memset(&sev, 0, sizeof(sev));
+	sev.sigev_notify =3D SIGEV_SIGNAL;
+	sev.sigev_signo =3D SIGUSR1;
+
+	if (timer_create(which, &sev, &timerid))
+		fatal_error(name, "timer_create()");
+
+	/* Start the timer to expire in 100ms and 100ms intervals */
+	its.it_value.tv_sec =3D 0;
+	its.it_value.tv_nsec =3D 100000000;
+	its.it_interval.tv_sec =3D 0;
+	its.it_interval.tv_nsec =3D 100000000;
+	if (timer_settime(timerid, 0, &its, NULL))
+		fatal_error(name, "timer_settime()");
+
+	if (timer_gettime(timerid, &prev))
+		fatal_error(name, "timer_gettime()");
+
+	if (clock_gettime(which, &start))
+		fatal_error(name, "clock_gettime()");
+
+	do {
+		if (clock_gettime(which, &now))
+			fatal_error(name, "clock_gettime()");
+		if (timer_gettime(timerid, &its))
+			fatal_error(name, "timer_gettime()");
+		if (its.it_value.tv_nsec > prev.it_value.tv_nsec)
+			wraps++;
+		prev =3D its;
+
+	} while (calcdiff_ns(now, start) < NSECS_PER_SEC);
+
+	if (timer_delete(timerid))
+		fatal_error(name, "timer_delete()");
+
+	ksft_test_result(wraps > 1, "check_gettime %s\n", name);
+}
+
+static void check_overrun(int which, const char *name)
+{
+	struct timespec start, now;
+	struct tmrsig tsig =3D { };
+	struct itimerspec its;
+	struct sigaction sa;
+	struct sigevent sev;
+	timer_t timerid;
+	sigset_t set;
+
+	sa.sa_flags =3D SA_SIGINFO;
+	sa.sa_sigaction =3D siginfo_handler;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGUSR1, &sa, NULL))
+		fatal_error(name, "sigaction()");
+
+	/* Block the signal */
+	sigemptyset(&set);
+	sigaddset(&set, SIGUSR1);
+	if (sigprocmask(SIG_BLOCK, &set, NULL))
+		fatal_error(name, "sigprocmask(SIG_BLOCK)");
+
+	memset(&sev, 0, sizeof(sev));
+	sev.sigev_notify =3D SIGEV_SIGNAL;
+	sev.sigev_signo =3D SIGUSR1;
+	sev.sigev_value.sival_ptr =3D &tsig;
+	if (timer_create(which, &sev, &timerid))
+		fatal_error(name, "timer_create()");
+
+	/* Start the timer to expire in 100ms and 100ms intervals */
+	its.it_value.tv_sec =3D 0;
+	its.it_value.tv_nsec =3D 100000000;
+	its.it_interval.tv_sec =3D 0;
+	its.it_interval.tv_nsec =3D 100000000;
+	if (timer_settime(timerid, 0, &its, NULL))
+		fatal_error(name, "timer_settime()");
+
+	if (clock_gettime(which, &start))
+		fatal_error(name, "clock_gettime()");
+
+	do {
+		if (clock_gettime(which, &now))
+			fatal_error(name, "clock_gettime()");
+	} while (calcdiff_ns(now, start) < NSECS_PER_SEC);
+
+	/* Unblock it, which should deliver a signal */
+	if (sigprocmask(SIG_UNBLOCK, &set, NULL))
+		fatal_error(name, "sigprocmask(SIG_UNBLOCK)");
+
+	if (timer_delete(timerid))
+		fatal_error(name, "timer_delete()");
+
+	ksft_test_result(tsig.signals =3D=3D 1 && tsig.overruns =3D=3D 9,
+			 "check_overrun %s\n", name);
 }
=20
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(6);
+	ksft_set_plan(18);
=20
 	ksft_print_msg("Testing posix timers. False negative may happen on CPU exec=
ution \n");
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
=20
-	if (check_itimer(ITIMER_VIRTUAL) < 0)
-		ksft_exit_fail();
-
-	if (check_itimer(ITIMER_PROF) < 0)
-		ksft_exit_fail();
-
-	if (check_itimer(ITIMER_REAL) < 0)
-		ksft_exit_fail();
-
-	if (check_timer_create(CLOCK_THREAD_CPUTIME_ID) < 0)
-		ksft_exit_fail();
+	check_itimer(ITIMER_VIRTUAL, "ITIMER_VIRTUAL");
+	check_itimer(ITIMER_PROF, "ITIMER_PROF");
+	check_itimer(ITIMER_REAL, "ITIMER_REAL");
+	check_timer_create(CLOCK_THREAD_CPUTIME_ID, "CLOCK_THREAD_CPUTIME_ID");
=20
 	/*
 	 * It's unfortunately hard to reliably test a timer expiration
@@ -280,11 +618,21 @@ int main(int argc, char **argv)
 	 * to ensure true parallelism. So test only one thread until we
 	 * find a better solution.
 	 */
-	if (check_timer_create(CLOCK_PROCESS_CPUTIME_ID) < 0)
-		ksft_exit_fail();
-
-	if (check_timer_distribution() < 0)
-		ksft_exit_fail();
+	check_timer_create(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
+	check_timer_distribution();
+
+	check_sig_ign(0);
+	check_sig_ign(1);
+	check_rearm();
+	check_delete();
+	check_sigev_none(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
+	check_sigev_none(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
+	check_gettime(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
+	check_gettime(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
+	check_gettime(CLOCK_THREAD_CPUTIME_ID, "CLOCK_THREAD_CPUTIME_ID");
+	check_overrun(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
+	check_overrun(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
+	check_overrun(CLOCK_THREAD_CPUTIME_ID, "CLOCK_THREAD_CPUTIME_ID");
=20
 	ksft_finished();
 }


