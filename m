Return-Path: <linux-kernel+bounces-315085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A951996BDD7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345871F26B5F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F471DC756;
	Wed,  4 Sep 2024 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L40TBvDd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w3osrh9x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC7C1DB54A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455137; cv=none; b=K56tDfOn3TyV9SuKakuZ/EBrI3csaYM3ERUCgIJGrzowqy6auSGyNf35p6L/0t25uqFKdtoM5YpL5JY5WFNcVpUJH00OTNY5Ydbg0nIsjBmnPObRG+EqRuRLCENl+TCypx2ta2G7jxuJuJDI2JA/LklpfMDDzuX7Aj/4PrYCDDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455137; c=relaxed/simple;
	bh=MTJL4Zkzckx7B+yEBbwwYRmr38U6nUmiuTCpxJ4/AFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ioOoebq8wjsPCjHG2HSsJpWywSc9yDWHGrCR7HEKB2yJaNVhyQnJtxQQdmUBeoTREPP91+veHEdeXSYqDfkEKmV0ap1lvIrN4cE1E9gQX4PKIH6RWKdeYYFfDWGbw7S0svdNzXjZZJGES/SDY8fU1r6iiJpzftjaUMM0wEzTrZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L40TBvDd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w3osrh9x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725455133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+i4/OFoPPq+xjtuv5gmXePpdIiBTWSikyghyXzck/s=;
	b=L40TBvDdghSx+aIB8NfXLTn4tqJWarVO4OZ9s56JNbnRbxU0T5GBYD0T/4gY0UfKLm2Gnd
	QO444uEkFJaSnBnJprn+bX+RTyaFDJc8Q6QlyoC4W/1r8rf4VCLeAkaJr/3UtbWsAjDAgf
	KSWqfuEPe91uAHDwiZgVxdJw+qCX3x3gUWW1Cp1sUOvXQ9TTozOCuf1wIK/MGADON7PhPV
	bu90SP2iGyOiBPAX/4nrF9jLviv30DcqtjZ+I9V3kt9RR0IJZPspUgbjlaypG1n0A7+bsd
	X0xlbZFg0oiMXItjyOAHZTyVkCJDRMO+HHYM6OkDs0T8qz6gQJally4km67MvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725455133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+i4/OFoPPq+xjtuv5gmXePpdIiBTWSikyghyXzck/s=;
	b=w3osrh9xPaa106cN0ciiHQvAOL/3IjBNxuDfinKCq720oXKNP7/miCHeduZ5IfEOc5hae4
	ZJ/4xz13DkyCF4DA==
Date: Wed, 04 Sep 2024 15:04:53 +0200
Subject: [PATCH 03/15] Comments: Fix wrong singular form of jiffies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240904-devel-anna-maria-b4-timers-flseep-v1-3-e98760256370@linutronix.de>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

There are several comments all over the place, which uses a wrong singular
form of jiffies.

Replace 'jiffie' by 'jiffy'. No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 Documentation/admin-guide/media/vivid.rst                    |  2 +-
 Documentation/timers/timers-howto.rst                        |  2 +-
 .../translations/sp_SP/scheduler/sched-design-CFS.rst        |  2 +-
 arch/arm/mach-versatile/spc.c                                |  2 +-
 arch/m68k/q40/q40ints.c                                      |  2 +-
 arch/x86/kernel/cpu/mce/dev-mcelog.c                         |  2 +-
 drivers/char/ipmi/ipmi_ssif.c                                |  2 +-
 drivers/dma-buf/st-dma-fence.c                               |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_wait.c                     |  2 +-
 drivers/gpu/drm/i915/gt/selftest_execlists.c                 |  4 ++--
 drivers/gpu/drm/i915/i915_utils.c                            |  2 +-
 drivers/gpu/drm/v3d/v3d_bo.c                                 |  2 +-
 drivers/isdn/mISDN/dsp_cmx.c                                 |  2 +-
 drivers/net/ethernet/marvell/mvmdio.c                        |  2 +-
 fs/xfs/xfs_buf.h                                             |  2 +-
 include/linux/jiffies.h                                      |  2 +-
 include/linux/timekeeper_internal.h                          |  2 +-
 kernel/time/alarmtimer.c                                     |  2 +-
 kernel/time/clockevents.c                                    |  2 +-
 kernel/time/hrtimer.c                                        |  2 +-
 kernel/time/posix-timers.c                                   |  4 ++--
 kernel/time/timer.c                                          | 12 ++++++------
 lib/Kconfig.debug                                            |  2 +-
 net/batman-adv/types.h                                       |  2 +-
 24 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/Documentation/admin-guide/media/vivid.rst b/Documentation/admin-guide/media/vivid.rst
index 1306f19ecb5a..c9d301ab46a3 100644
--- a/Documentation/admin-guide/media/vivid.rst
+++ b/Documentation/admin-guide/media/vivid.rst
@@ -328,7 +328,7 @@ and an HDMI input, one input for each input type. Those are described in more
 detail below.
 
 Special attention has been given to the rate at which new frames become
-available. The jitter will be around 1 jiffie (that depends on the HZ
+available. The jitter will be around 1 jiffy (that depends on the HZ
 configuration of your kernel, so usually 1/100, 1/250 or 1/1000 of a second),
 but the long-term behavior is exactly following the framerate. So a
 framerate of 59.94 Hz is really different from 60 Hz. If the framerate
diff --git a/Documentation/timers/timers-howto.rst b/Documentation/timers/timers-howto.rst
index 5c169e3d29a8..ef7a4652ccc9 100644
--- a/Documentation/timers/timers-howto.rst
+++ b/Documentation/timers/timers-howto.rst
@@ -19,7 +19,7 @@ it really need to delay in atomic context?" If so...
 
 ATOMIC CONTEXT:
 	You must use the `*delay` family of functions. These
-	functions use the jiffie estimation of clock speed
+	functions use the jiffy estimation of clock speed
 	and will busy wait for enough loop cycles to achieve
 	the desired delay:
 
diff --git a/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst b/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
index 90a153cad4e8..731c266beb1a 100644
--- a/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
+++ b/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
@@ -109,7 +109,7 @@ para que se ejecute, y la tarea en ejecución es interrumpida.
 ==================================
 
 CFS usa una granularidad de nanosegundos y no depende de ningún
-jiffie o detalles como HZ. De este modo, el gestor de tareas CFS no tiene
+jiffy o detalles como HZ. De este modo, el gestor de tareas CFS no tiene
 noción de "ventanas de tiempo" de la forma en que tenía el gestor de
 tareas previo, y tampoco tiene heurísticos. Únicamente hay un parámetro
 central ajustable (se ha de cambiar en CONFIG_SCHED_DEBUG):
diff --git a/arch/arm/mach-versatile/spc.c b/arch/arm/mach-versatile/spc.c
index 5e44170e1a9a..790092734cf6 100644
--- a/arch/arm/mach-versatile/spc.c
+++ b/arch/arm/mach-versatile/spc.c
@@ -73,7 +73,7 @@
 
 /*
  * Even though the SPC takes max 3-5 ms to complete any OPP/COMMS
- * operation, the operation could start just before jiffie is about
+ * operation, the operation could start just before jiffy is about
  * to be incremented. So setting timeout value of 20ms = 2jiffies@100Hz
  */
 #define TIMEOUT_US	20000
diff --git a/arch/m68k/q40/q40ints.c b/arch/m68k/q40/q40ints.c
index 10f1f294e91f..14b774b9d308 100644
--- a/arch/m68k/q40/q40ints.c
+++ b/arch/m68k/q40/q40ints.c
@@ -106,7 +106,7 @@ void __init q40_init_IRQ(void)
  * this stuff doesn't really belong here..
  */
 
-int ql_ticks;              /* 200Hz ticks since last jiffie */
+int ql_ticks;              /* 200Hz ticks since last jiffy */
 static int sound_ticks;
 
 #define SVOL 45
diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index a05ac0716ecf..a3aa0199222e 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -314,7 +314,7 @@ static ssize_t mce_chrdev_write(struct file *filp, const char __user *ubuf,
 
 	/*
 	 * Need to give user space some time to set everything up,
-	 * so do it a jiffie or two later everywhere.
+	 * so do it a jiffy or two later everywhere.
 	 */
 	schedule_timeout(2);
 
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 96ad571d041a..e093028391af 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -980,7 +980,7 @@ static void msg_written_handler(struct ssif_info *ssif_info, int result,
 			ipmi_ssif_unlock_cond(ssif_info, flags);
 			start_get(ssif_info);
 		} else {
-			/* Wait a jiffie then request the next message */
+			/* Wait a jiffy then request the next message */
 			ssif_info->waiting_alert = true;
 			ssif_info->retries_left = SSIF_RECV_RETRIES;
 			if (!ssif_info->stopping)
diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-fence.c
index 6a1bfcd0cc21..cf2ce3744ce6 100644
--- a/drivers/dma-buf/st-dma-fence.c
+++ b/drivers/dma-buf/st-dma-fence.c
@@ -402,7 +402,7 @@ static int test_wait_timeout(void *arg)
 
 	if (dma_fence_wait_timeout(wt.f, false, 2) == -ETIME) {
 		if (timer_pending(&wt.timer)) {
-			pr_notice("Timer did not fire within the jiffie!\n");
+			pr_notice("Timer did not fire within the jiffy!\n");
 			err = 0; /* not our fault! */
 		} else {
 			pr_err("Wait reported incomplete after timeout\n");
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_wait.c b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
index d4b918fb11ce..1f55e62044a4 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_wait.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
@@ -266,7 +266,7 @@ i915_gem_wait_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 		if (ret == -ETIME && !nsecs_to_jiffies(args->timeout_ns))
 			args->timeout_ns = 0;
 
-		/* Asked to wait beyond the jiffie/scheduler precision? */
+		/* Asked to wait beyond the jiffy/scheduler precision? */
 		if (ret == -ETIME && args->timeout_ns)
 			ret = -EAGAIN;
 	}
diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i915/gt/selftest_execlists.c
index 4202df5b8c12..222ca7c44951 100644
--- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
+++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
@@ -93,7 +93,7 @@ static int wait_for_reset(struct intel_engine_cs *engine,
 		return -EINVAL;
 	}
 
-	/* Give the request a jiffie to complete after flushing the worker */
+	/* Give the request a jiffy to complete after flushing the worker */
 	if (i915_request_wait(rq, 0,
 			      max(0l, (long)(timeout - jiffies)) + 1) < 0) {
 		pr_err("%s: hanging request %llx:%lld did not complete\n",
@@ -3426,7 +3426,7 @@ static int live_preempt_timeout(void *arg)
 			cpu_relax();
 
 		saved_timeout = engine->props.preempt_timeout_ms;
-		engine->props.preempt_timeout_ms = 1; /* in ms, -> 1 jiffie */
+		engine->props.preempt_timeout_ms = 1; /* in ms, -> 1 jiffy */
 
 		i915_request_get(rq);
 		i915_request_add(rq);
diff --git a/drivers/gpu/drm/i915/i915_utils.c b/drivers/gpu/drm/i915/i915_utils.c
index 6f9e7b354b54..f2ba51c20e97 100644
--- a/drivers/gpu/drm/i915/i915_utils.c
+++ b/drivers/gpu/drm/i915/i915_utils.c
@@ -110,7 +110,7 @@ void set_timer_ms(struct timer_list *t, unsigned long timeout)
 	 * Paranoia to make sure the compiler computes the timeout before
 	 * loading 'jiffies' as jiffies is volatile and may be updated in
 	 * the background by a timer tick. All to reduce the complexity
-	 * of the addition and reduce the risk of losing a jiffie.
+	 * of the addition and reduce the risk of losing a jiffy.
 	 */
 	barrier();
 
diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index a165cbcdd27b..9eafe53a8f41 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -279,7 +279,7 @@ v3d_wait_bo_ioctl(struct drm_device *dev, void *data,
 	else
 		args->timeout_ns = 0;
 
-	/* Asked to wait beyond the jiffie/scheduler precision? */
+	/* Asked to wait beyond the jiffy/scheduler precision? */
 	if (ret == -ETIME && args->timeout_ns)
 		ret = -EAGAIN;
 
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
diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 9190eff6c0bb..e1d003fdbc2e 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -104,7 +104,7 @@ static int orion_mdio_wait_ready(const struct orion_mdio_ops *ops,
 			return 0;
 	} else {
 		/* wait_event_timeout does not guarantee a delay of at
-		 * least one whole jiffie, so timeout must be no less
+		 * least one whole jiffy, so timeout must be no less
 		 * than two.
 		 */
 		timeout = max(usecs_to_jiffies(MVMDIO_SMI_TIMEOUT), 2);
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
diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
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
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 76bd4fda3472..8bf888641694 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -493,7 +493,7 @@ static u64 __alarm_forward_now(struct alarm *alarm, ktime_t interval, bool throt
 		 * promised in the context of posix_timer_fn() never
 		 * materialized, but someone should really work on it.
 		 *
-		 * To prevent DOS fake @now to be 1 jiffie out which keeps
+		 * To prevent DOS fake @now to be 1 jiffy out which keeps
 		 * the overrun accounting correct but creates an
 		 * inconsistency vs. timer_gettime(2).
 		 */
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 60a6484831b1..78c7bd64d0dd 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -190,7 +190,7 @@ int clockevents_tick_resume(struct clock_event_device *dev)
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST
 
-/* Limit min_delta to a jiffie */
+/* Limit min_delta to a jiffy */
 #define MIN_DELTA_LIMIT		(NSEC_PER_SEC / HZ)
 
 /**
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index a023946f8558..e834b2bd83df 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1177,7 +1177,7 @@ static inline ktime_t hrtimer_update_lowres(struct hrtimer *timer, ktime_t tim,
 	/*
 	 * CONFIG_TIME_LOW_RES indicates that the system has no way to return
 	 * granular time values. For relative timers we add hrtimer_resolution
-	 * (i.e. one jiffie) to prevent short timeouts.
+	 * (i.e. one jiffy) to prevent short timeouts.
 	 */
 	timer->is_rel = mode & HRTIMER_MODE_REL;
 	if (timer->is_rel)
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 1cc830ef93a7..4576aaed13b2 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -339,14 +339,14 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
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
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 5e021a2d8d61..2b38f3035a3e 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -365,7 +365,7 @@ static unsigned long round_jiffies_common(unsigned long j, int cpu,
 	rem = j % HZ;
 
 	/*
-	 * If the target jiffie is just after a whole second (which can happen
+	 * If the target jiffy is just after a whole second (which can happen
 	 * due to delays of the timer irq, long irq off times etc etc) then
 	 * we should round down to the whole second, not up. Use 1/4th second
 	 * as cutoff for this rounding as an extreme upper bound for this.
@@ -1930,7 +1930,7 @@ static void timer_recalc_next_expiry(struct timer_base *base)
 		 * bits are zero, we look at the next level as is. If not we
 		 * need to advance it by one because that's going to be the
 		 * next expiring bucket in that level. base->clk is the next
-		 * expiring jiffie. So in case of:
+		 * expiring jiffy. So in case of:
 		 *
 		 * LVL5 LVL4 LVL3 LVL2 LVL1 LVL0
 		 *  0    0    0    0    0    0
@@ -1995,7 +1995,7 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 		return basem;
 
 	/*
-	 * Round up to the next jiffie. High resolution timers are
+	 * Round up to the next jiffy. High resolution timers are
 	 * off, so the hrtimers are expired in the tick and we need to
 	 * make sure that this tick really expires the timer to avoid
 	 * a ping pong of the nohz stop code.
@@ -2254,7 +2254,7 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 					     base_global, &tevt);
 
 	/*
-	 * If the next event is only one jiffie ahead there is no need to call
+	 * If the next event is only one jiffy ahead there is no need to call
 	 * timer migration hierarchy related functions. The value for the next
 	 * global timer in @tevt struct equals then KTIME_MAX. This is also
 	 * true, when the timer base is idle.
@@ -2486,11 +2486,11 @@ static void run_local_timers(void)
 		 * updated. When this update is missed, this isn't a
 		 * problem, as an IPI is executed nevertheless when the CPU
 		 * was idle before. When the CPU wasn't idle but the update
-		 * is missed, then the timer would expire one jiffie late -
+		 * is missed, then the timer would expire one jiffy late -
 		 * bad luck.
 		 *
 		 * Those unlikely corner cases where the worst outcome is only a
-		 * one jiffie delay or a superfluous raise of the softirq are
+		 * one jiffy delay or a superfluous raise of the softirq are
 		 * not that expensive as doing the check always while holding
 		 * the lock.
 		 *
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a30c03a66172..a40aa606cd04 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -97,7 +97,7 @@ config BOOT_PRINTK_DELAY
 	  using "boot_delay=N".
 
 	  It is likely that you would also need to use "lpj=M" to preset
-	  the "loops per jiffie" value.
+	  the "loops per jiffy" value.
 	  See a previous boot log for the "lpj" value to use for your
 	  system, and then set "lpj=M" before setting "boot_delay=N".
 	  NOTE:  Using this option may adversely affect SMP systems.
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 00840d5784fe..04f6398b3a40 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -287,7 +287,7 @@ struct batadv_frag_table_entry {
 	/** @lock: lock to protect the list of fragments */
 	spinlock_t lock;
 
-	/** @timestamp: time (jiffie) of last received fragment */
+	/** @timestamp: time (jiffy) of last received fragment */
 	unsigned long timestamp;
 
 	/** @seqno: sequence number of the fragments in the list */

-- 
2.39.2


