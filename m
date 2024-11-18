Return-Path: <linux-kernel+bounces-413418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF329D18CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777E91F22B73
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9911C07C4;
	Mon, 18 Nov 2024 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VEroVCDW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dhC2OybD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953261E5037
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731957739; cv=none; b=ss4myqPaXWdE1Ao49ncIAVrPMaVAYtkjXF7ew/fYouH1dlfDAM/hiWf2L+2xNDdz9o1SyNMOq4ycBTbKU7H0TTnKp053S5Ns6neONZo2Cd4v/Qfse0Jr0gHrdOMeIh9mYc4sU+1NYS0TU852JNeENQt0XmttnL2DDvrVgDn+xv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731957739; c=relaxed/simple;
	bh=vpEZw2hLGUDFqV4gtRMtrzfk6r75YzJdwPF97PxBjbI=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=QrJJjQjzMnMdo3Odzr/4pMhF7k66lmCHIyaFB5eGOGjGuO2ru2L9mI9QqaaY5uhiM9ByX0iFMloBb39JNhDOKomu4LZ0vLtrMSFbRNzlJgsl6Kh3hoddUoVRXlFAFPyv0FWGYTzWooHibQua4KlOpmoGwO7AHqKua91kECdJTDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VEroVCDW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dhC2OybD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731957726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=jFaIDC9x4CzY3KstaZU8vjzqRKYoHePTAr6u7cweVLE=;
	b=VEroVCDWiYjwdDUcYWG41pLwpHYSNpEzhQFb16VDWAkQmQzVygEt4MeYrJs+5iFP5cqgxL
	gqtijP6xYTENIDC8Oe60rKJP65itKBlXvXfrh69d5BSiiOF7M2YXKbiWPjhl1aXLvHvybO
	splK8/q8qfUu6Vatm8543TOe1d5yAbwTx6rMlv+eVi/78c8GrHbZ8PUz207necDGXOE2Dy
	/YLkwjCKSviJ7SPOSTpQKTiO5KMDAydwc4mapfxIQbpNVfWYLpVAgttd+QDMK6TypraQEb
	WTZulyvZagMv4NLHW9ecpreyVX8kORWc59IaIlaqVpqd38QhfHD7BVJqS47e7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731957726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=jFaIDC9x4CzY3KstaZU8vjzqRKYoHePTAr6u7cweVLE=;
	b=dhC2OybDVz97UxE3thn/xhWU0+Pz6r1W7A8aNicflfLO8vHAVdLTG8MzdgfpM5a42XWF2u
	7ty+6WTKmM4lNSBA==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v6.13-rc1
References: <173195757899.1896928.6143737920583881655.tglx@xen13>
Message-ID: <173195758632.1896928.11371209657780930206.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Nov 2024 20:21:57 +0100 (CET)

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024=
-11-18

up to:  cdc905d16b07: posix-timers: Fix spurious warning on double enqueue ve=
rsus do_exit()


A rather large update for timekeeping and timers:

  - The final step to get rid of auto-rearming posix-timers

    posix-timers are currently auto-rearmed by the kernel when the signal
    of the timer is ignored so that the timer signal can be delivered once
    the corresponding signal is unignored.

    This requires to throttle the timer to prevent a DoS by small intervals
    and keeps the system pointlessly out of low power states for no value.
    This is a long standing non-trivial problem due to the lock order of
    posix-timer lock and the sighand lock along with life time issues as
    the timer and the sigqueue have different life time rules.

    Cure this by:

     * Embedding the sigqueue into the timer struct to have the same life
       time rules. Aside of that this also avoids the lookup of the timer
       in the signal delivery and rearm path as it's just a always valid
       container_of() now.

     * Queuing ignored timer signals onto a seperate ignored list.

     * Moving queued timer signals onto the ignored list when the signal is
       switched to SIG_IGN before it could be delivered.

     * Walking the ignored list when SIG_IGN is lifted and requeue the
       signals to the actual signal lists. This allows the signal delivery
       code to rearm the timer.

    This also required to consolidate the signal delivery rules so they are
    consistent across all situations. With that all self test scenarios
    finally succeed.


  - Core infrastructure for VFS multigrain timestamping

    This is required to allow the kernel to use coarse grained time stamps
    by default and switch to fine grained time stamps when inode attributes
    are actively observed via getattr().

    These changes have been provided to the VFS tree as well, so that the
    VFS specific infrastructure could be built on top.


  - Cleanup and consolidation of the sleep() infrastructure

    * Move all sleep and timeout functions into one file

    * Rework udelay() and ndelay() into proper documented inline functions
      and replace the hardcoded magic numbers by proper defines.

    * Rework the fsleep() implementation to take the reality of the timer
      wheel granularity on different HZ values into account. Right now the
      boundaries are hard coded time ranges which fail to provide the
      requested accuracy on different HZ settings.

    * Update documentation for all sleep/timeout related functions and fix
      up stale documentation links all over the place

    * Fixup a few usage sites


  - Rework of timekeeping and adjtimex(2) to prepare for multiple PTP clocks

    A system can have multiple PTP clocks which are participating in
    seperate and independent PTP clock domains. So far the kernel only
    considers the PTP clock which is based on CLOCK TAI relevant as that's
    the clock which drives the timekeeping adjustments via the various user
    space daemons through adjtimex(2).

    The non TAI based clock domains are accessible via the file descriptor
    based posix clocks, but their usability is very limited. They can't be
    accessed fast as they always go all the way out to the hardware and
    they cannot be utilized in the kernel itself.

    As Time Sensitive Networking (TSN) gains traction it is required to
    provide fast user and kernel space access to these clocks.

    The approach taken is to utilize the timekeeping and adjtimex(2)
    infrastructure to provide this access in a similar way how the kernel
    provides access to clock MONOTONIC, REALTIME etc.

    Instead of creating a duplicated infrastructure this rework converts
    timekeeping and adjtimex(2) into generic functionality which operates
    on pointers to data structures instead of using static variables.

    This allows to provide time accessors and adjtimex(2) functionality for
    the independent PTP clocks in a subsequent step.


  - Consolidate hrtimer initialization

    hrtimers are set up by initializing the data structure and then
    seperately setting the callback function for historical reasons.

    That's an extra unnecessary step and makes Rust support less straight
    forward than it should be.

    Provide a new set of hrtimer_setup*() functions and convert the core
    code and a few usage sites of the less frequently used interfaces over.

    The bulk of the htimer_init() to hrtimer_setup() conversion is already
    prepared and scheduled for the next merge window.


  - Drivers:

    * Ensure that the global timekeeping clocksource is utilizing the
      cluster 0 timer on MIPS multi-cluster systems.

      Otherwise CPUs on different clusters use their cluster specific
      clocksource which is not guaranteed to be synchronized with other
      clusters.

    * Mostly boring cleanups, fixes, improvements and code movement

Thanks,

	tglx

------------------>
Anna-Maria Behnsen (32):
      ntp: Cleanup formatting of code
      MAINTAINERS: Add missing file include/linux/delay.h
      timers: Move *sleep*() and timeout functions into a separate file
      timers: Update schedule_[hr]timeout*() related function descriptions
      timers: Rename usleep_idle_range() to usleep_range_idle()
      timers: Update function descriptions of sleep/delay related functions
      delay: Rework udelay and ndelay
      timers: Adjust flseep() to reflect reality
      mm/damon/core: Use generic upper bound recommondation for usleep_range()
      timers: Add a warning to usleep_range_state() for wrong order of argume=
nts
      checkpatch: Remove links to outdated documentation
      iopoll/regmap/phy/snd: Fix comment referencing outdated timer documenta=
tion
      powerpc/rtas: Use fsleep() to minimize additional sleep duration
      media: anysee: Fix and remove outdated comment
      timers/Documentation: Cleanup delay/sleep documentation
      timekeeping: Avoid duplicate leap state update
      timekeeping: Move timekeeper_lock into tk_core
      timekeeping: Define a struct type for tk_core to make it reusable
      timekeeping: Introduce tkd_basic_setup() to make lock and seqcount init=
 reusable
      timekeeping: Add struct tk_data as argument to timekeeping_update()
      timekeeping: Split out timekeeper update of timekeeping_advanced()
      timekeeping: Introduce combined timekeeping action flag
      timekeeping: Rework do_settimeofday64() to use shadow_timekeeper
      timekeeping: Rework timekeeping_inject_offset() to use shadow_timekeeper
      timekeeping: Rework change_clocksource() to use shadow_timekeeper
      timekeeping: Rework timekeeping_init() to use shadow_timekeeper
      timekeeping: Rework timekeeping_inject_sleeptime64() to use shadow_time=
keeper
      timekeeping: Rework timekeeping_resume() to use shadow_timekeeper
      timekeeping: Rework timekeeping_suspend() to use shadow_timekeeper
      timekeeping: Rework do_adjtimex() to use shadow_timekeeper
      timekeeping: Remove TK_MIRROR timekeeping_update() action
      timekeeping: Merge timekeeping_update_staged() and timekeeping_update()

Dr. David Alan Gilbert (2):
      clocksource: Remove unused clocksource_change_rating
      clocksource/drivers/dw_apb: Remove unused dw_apb_clockevent functions

Easwar Hariharan (1):
      jiffies: Define secs_to_jiffies()

Frederic Weisbecker (11):
      clockevents: Improve clockevents_notify_released() comment
      clockevents: Shutdown and unregister current clockevents at CPUHP_AP_TI=
CK_DYING
      tick: Remove now unneeded low-res tick stop on CPUHP_AP_TICK_DYING
      ARM: smp_twd: Remove clockevents shutdown call on offlining
      clocksource/drivers/arm_arch_timer: Remove clockevents shutdown call on=
 offlining
      clocksource/drivers/arm_global_timer: Remove clockevents shutdown call =
on offlining
      clocksource/drivers/exynos_mct: Remove clockevents shutdown call on off=
lining
      clocksource/drivers/armada-370-xp: Remove clockevents shutdown call on =
offlining
      clocksource/drivers/qcom: Remove clockevents shutdown call on offlining
      clocksource/drivers/timer-tegra: Remove clockevents shutdown call on of=
flining
      posix-timers: Fix spurious warning on double enqueue versus do_exit()

Ivaylo Ivanov (1):
      dt-bindings: timer: actions,owl-timer: convert to YAML

Javier Carrasco (1):
      clocksource/drivers/timer-ti-dm: Fix child node refcount handling

Jeff Layton (3):
      timekeeping: Don't use seqcount loop in ktime_mono_to_any() on 64-bit s=
ystems
      timekeeping: Add interfaces for handling timestamps with a floor value
      timekeeping: Add percpu counter for tracking floor swap events

Judith Mendez (1):
      clocksource/drivers/timer-ti-dm: Don't fail probe if int not found

Julia Lawall (1):
      posix-timers: Replace call_rcu() by kfree_rcu() for simple kmem_cache_f=
ree() callback

Mark Brown (1):
      clocksource/drivers:sp804: Make user selectable

Miguel Ojeda (2):
      time: Partially revert cleanup on msecs_to_jiffies() documentation
      time: Fix references to _msecs_to_jiffies() handling of values

Nam Cao (19):
      hrtimers: Add missing hrtimer_init() trace points
      drm/i915/request: Remove unnecessary modification of hrtimer:: Function
      KVM: x86/xen: Initialize hrtimer in kvm_xen_init_vcpu()
      _RESEND_PATCH_v2_04_19_wifi_rt2x00_Remove_redundant_hrtimer_init_
      io_uring: Remove redundant hrtimer's callback function setup
      hrtimers: Introduce hrtimer_setup() to replace hrtimer_init()
      hrtimers: Introduce hrtimer_setup_on_stack()
      hrtimers: Introduce hrtimer_setup_sleeper_on_stack()
      hrtimers: Introduce hrtimer_update_function()
      fs/aio: Switch to use hrtimer_setup_sleeper_on_stack()
      futex: Switch to use hrtimer_setup_sleeper_on_stack()
      net: pktgen: Switch to use hrtimer_setup_sleeper_on_stack()
      timers: Switch to use hrtimer_setup_sleeper_on_stack()
      wait: Switch to use hrtimer_setup_sleeper_on_stack()
      hrtimers: Delete hrtimer_init_sleeper_on_stack()
      sched/idle: Switch to use hrtimer_setup_on_stack()
      io_uring: Switch to use hrtimer_setup_on_stack()
      alarmtimer: Switch to use hrtimer_setup() and hrtimer_setup_on_stack()
      hrtimers: Delete hrtimer_init_on_stack()

Paul Burton (1):
      clocksource/drivers/mips-gic-timer: Always use cluster 0 counter as clo=
cksource

Rob Herring (Arm) (1):
      clocksource/drivers/arm_arch_timer: Use of_property_present() for non-b=
oolean properties

Sergio Paracuellos (1):
      clocksource/drivers/ralink: Add Ralink System Tick Counter driver

Tang Bin (1):
      clocksource/drivers/gpx: Remove redundant casts

Thomas Gleixner (59):
      ntp: Remove unused tick_nsec
      ntp: Make tick_usec static
      ntp: Clean up comments
      ntp: Convert functions with only two states to bool
      ntp: Read reference time only once
      ntp: Introduce struct ntp_data
      ntp: Move tick_length* into ntp_data
      ntp: Move tick_stat* into ntp_data
      ntp: Move time_offset/constant into ntp_data
      ntp: Move time_max/esterror into ntp_data
      ntp: Move time_freq/reftime into ntp_data
      ntp: Move time_adj/ntp_tick_adj into ntp_data
      ntp: Move ntp_next_leap_sec into ntp_data
      ntp: Move pps_valid into ntp_data
      ntp: Move pps_ft into ntp_data
      ntp: Move pps_jitter into ntp_data
      ntp: Move pps_fbase into ntp_data
      ntp: Move pps_shift/intcnt into ntp_data
      ntp: Move pps_freq/stabil into ntp_data
      ntp: Move pps monitors into ntp_data
      timekeeping: Read NTP tick length only once
      timekeeping: Don't stop time readers across hard_pps() update
      timekeeping: Abort clocksource change in case of failure
      timekeeping: Simplify code in timekeeping_advance()
      timekeeping: Reorder struct timekeeper
      timekeeping: Move shadow_timekeeper into tk_core
      timekeeping: Encapsulate locking/unlocking of timekeeper_lock
      timekeeping: Provide timekeeping_restore_shadow()
      signal: Confine POSIX_TIMERS properly
      signal: Cleanup flush_sigqueue_mask()
      posix-timers: Cure si_sys_private race
      signal: Allow POSIX timer signals to be dropped
      posix-timers: Drop signal if timer has been deleted or reprogrammed
      posix-timers: Rename k_itimer:: It_requeue_pending
      posix-timers: Add proper state tracking
      timers: Add missing READ_ONCE() in __run_timer_base()
      timekeeping: Remove CONFIG_DEBUG_TIMEKEEPING
      timekeeping: Always check for negative motion
      posix-cpu-timers: Correctly update timer status in posix_cpu_timer_del()
      posix-timers: Make signal delivery consistent
      posix-timers: Make signal overrun accounting sensible
      posix-cpu-timers: Cleanup the firing logic
      posix-cpu-timers: Use dedicated flag for CPU timer nanosleep
      posix-timers: Add a refcount to struct k_itimer
      signal: Split up __sigqueue_alloc()
      signal: Provide posixtimer_sigqueue_init()
      posix-timers: Store PID type in the timer
      signal: Refactor send_sigqueue()
      signal: Replace resched_timer logic
      posix-timers: Embed sigqueue in struct k_itimer
      signal: Cleanup unused posix-timer leftovers
      posix-timers: Move sequence logic into struct k_itimer
      signal: Provide ignored_posix_timers list
      posix-timers: Handle ignored list on delete and exit
      signal: Handle ignored signals in do_sigaction(action !=3D SIG_IGN)
      signal: Queue ignored posixtimers on ignore list
      posix-timers: Cleanup SIG_IGN workaround leftovers
      alarmtimers: Remove the throttle mechanism from alarm_forward_now()
      alarmtimers: Remove return value from alarm functions

Vincent Donnefort (1):
      timekeeping: Add the boot clock to system time snapshot

Wang Jinchao (1):
      time: Remove '%' from numeric constant in kernel-doc comment


 Documentation/dev-tools/checkpatch.rst             |   2 -
 .../bindings/timer/actions,owl-timer.txt           |  21 -
 .../bindings/timer/actions,owl-timer.yaml          | 107 +++
 Documentation/timers/delay_sleep_functions.rst     | 121 +++
 Documentation/timers/index.rst                     |   2 +-
 Documentation/timers/timers-howto.rst              | 115 ---
 MAINTAINERS                                        |   4 +-
 arch/arm/kernel/smp_twd.c                          |   1 -
 arch/mips/ralink/Kconfig                           |   7 -
 arch/mips/ralink/Makefile                          |   2 -
 arch/powerpc/kernel/rtas.c                         |  21 +-
 arch/riscv/configs/defconfig                       |   1 -
 arch/x86/Kconfig                                   |   1 -
 arch/x86/include/asm/timer.h                       |   2 -
 arch/x86/kvm/xen.c                                 |  12 +-
 drivers/clocksource/Kconfig                        |  12 +-
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/arm_arch_timer.c               |   4 +-
 drivers/clocksource/arm_global_timer.c             |   1 -
 drivers/clocksource/dw_apb_timer.c                 |  39 -
 drivers/clocksource/exynos_mct.c                   |   1 -
 drivers/clocksource/mips-gic-timer.c               |  39 +-
 drivers/clocksource/timer-armada-370-xp.c          |   1 -
 drivers/clocksource/timer-gxp.c                    |   2 +-
 drivers/clocksource/timer-qcom.c                   |   1 -
 .../clocksource/timer-ralink.c                     |  11 +-
 drivers/clocksource/timer-tegra.c                  |   1 -
 drivers/clocksource/timer-ti-dm-systimer.c         |   8 +-
 drivers/clocksource/timer-ti-dm.c                  |   8 +-
 drivers/gpu/drm/i915/i915_request.c                |  17 +-
 drivers/media/usb/dvb-usb-v2/anysee.c              |  17 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c     |   2 -
 drivers/power/supply/charger-manager.c             |   3 +-
 fs/aio.c                                           |   2 +-
 fs/proc/base.c                                     |   4 +-
 fs/timerfd.c                                       |   4 +-
 include/asm-generic/delay.h                        |  96 ++-
 include/linux/alarmtimer.h                         |  10 +-
 include/linux/clocksource.h                        |   1 -
 include/linux/delay.h                              |  79 +-
 include/linux/dw_apb_timer.h                       |   3 -
 include/linux/hrtimer.h                            |  51 +-
 include/linux/iopoll.h                             |  52 +-
 include/linux/jiffies.h                            |  15 +-
 include/linux/phy.h                                |   9 +-
 include/linux/posix-timers.h                       |  72 +-
 include/linux/regmap.h                             |  38 +-
 include/linux/sched/signal.h                       |   4 +-
 include/linux/tick.h                               |   2 -
 include/linux/timekeeper_internal.h                | 114 +--
 include/linux/timekeeping.h                        |   7 +
 include/linux/timex.h                              |   8 -
 include/linux/wait.h                               |   4 +-
 include/uapi/asm-generic/siginfo.h                 |   2 +-
 init/init_task.c                                   |   5 +-
 io_uring/io_uring.c                                |   7 +-
 io_uring/timeout.c                                 |   1 -
 kernel/cpu.c                                       |   2 -
 kernel/fork.c                                      |   1 +
 kernel/futex/core.c                                |   6 +-
 kernel/sched/idle.c                                |   4 +-
 kernel/signal.c                                    | 494 +++++++-----
 kernel/time/Kconfig                                |   5 -
 kernel/time/Makefile                               |   2 +-
 kernel/time/alarmtimer.c                           |  96 +--
 kernel/time/clockevents.c                          |  42 +-
 kernel/time/clocksource.c                          |  40 +-
 kernel/time/hrtimer.c                              | 230 ++----
 kernel/time/itimer.c                               |  22 +-
 kernel/time/ntp.c                                  | 840 ++++++++++---------=
--
 kernel/time/posix-cpu-timers.c                     |  72 +-
 kernel/time/posix-timers.c                         | 267 ++++---
 kernel/time/posix-timers.h                         |   8 +-
 kernel/time/sleep_timeout.c                        | 377 +++++++++
 kernel/time/tick-internal.h                        |   3 +-
 kernel/time/tick-sched.c                           |  25 +-
 kernel/time/time.c                                 |  20 +-
 kernel/time/timekeeping.c                          | 637 ++++++++--------
 kernel/time/timekeeping_debug.c                    |  13 +
 kernel/time/timekeeping_internal.h                 |  25 +-
 kernel/time/timer.c                                | 195 +----
 kernel/time/vsyscall.c                             |   5 +-
 lib/Kconfig.debug                                  |  13 -
 mm/damon/core.c                                    |   5 +-
 net/bluetooth/hci_event.c                          |   2 -
 net/core/pktgen.c                                  |   2 +-
 net/netfilter/xt_IDLETIMER.c                       |   4 +-
 scripts/checkpatch.pl                              |  10 +-
 sound/soc/sof/ops.h                                |   8 +-
 .../testing/selftests/wireguard/qemu/debug.config  |   1 -
 90 files changed, 2494 insertions(+), 2159 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/actions,owl-timer=
.txt
 create mode 100644 Documentation/devicetree/bindings/timer/actions,owl-timer=
.yaml
 create mode 100644 Documentation/timers/delay_sleep_functions.rst
 delete mode 100644 Documentation/timers/timers-howto.rst
 rename arch/mips/ralink/cevt-rt3352.c =3D> drivers/clocksource/timer-ralink.=
c (91%)
 create mode 100644 kernel/time/sleep_timeout.c

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools=
/checkpatch.rst
index a9fac978a525..abb3ff682076 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -470,8 +470,6 @@ API usage
     usleep_range() should be preferred over udelay(). The proper way of
     using usleep_range() is mentioned in the kernel docs.
=20
-    See: https://www.kernel.org/doc/html/latest/timers/timers-howto.html#del=
ays-information-on-the-various-kernel-delay-sleep-mechanisms
-
=20
 Comments
 --------
diff --git a/Documentation/devicetree/bindings/timer/actions,owl-timer.txt b/=
Documentation/devicetree/bindings/timer/actions,owl-timer.txt
deleted file mode 100644
index 977054f87563..000000000000
--- a/Documentation/devicetree/bindings/timer/actions,owl-timer.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Actions Semi Owl Timer
-
-Required properties:
-- compatible      :  "actions,s500-timer" for S500
-                     "actions,s700-timer" for S700
-                     "actions,s900-timer" for S900
-- reg             :  Offset and length of the register set for the device.
-- interrupts      :  Should contain the interrupts.
-- interrupt-names :  Valid names are: "2hz0", "2hz1",
-                                      "timer0", "timer1", "timer2", "timer3"
-                     See ../resource-names.txt
-
-Example:
-
-		timer@b0168000 {
-			compatible =3D "actions,s500-timer";
-			reg =3D <0xb0168000 0x100>;
-			interrupts =3D <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-			             <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names =3D "timer0", "timer1";
-		};
diff --git a/Documentation/devicetree/bindings/timer/actions,owl-timer.yaml b=
/Documentation/devicetree/bindings/timer/actions,owl-timer.yaml
new file mode 100644
index 000000000000..646c554a390a
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/actions,owl-timer.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/actions,owl-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi Owl timer
+
+maintainers:
+  - Andreas F=C3=A4rber <afaerber@suse.de>
+
+description:
+  Actions Semi Owl SoCs provide 32bit and 2Hz timers.
+  The 32bit timers support dynamic irq, as well as one-shot mode.
+
+properties:
+  compatible:
+    enum:
+      - actions,s500-timer
+      - actions,s700-timer
+      - actions,s900-timer
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 6
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 6
+    items:
+      enum:
+        - 2hz0
+        - 2hz1
+        - timer0
+        - timer1
+        - timer2
+        - timer3
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - interrupts
+  - interrupt-names
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - actions,s500-timer
+    then:
+      properties:
+        interrupts:
+          minItems: 4
+          maxItems: 4
+        interrupt-names:
+          items:
+            - const: 2hz0
+            - const: 2hz1
+            - const: timer0
+            - const: timer1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - actions,s700-timer
+              - actions,s900-timer
+    then:
+      properties:
+        interrupts:
+          minItems: 1
+          maxItems: 1
+        interrupt-names:
+          items:
+            - const: timer1
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    soc {
+      #address-cells =3D <1>;
+      #size-cells =3D <1>;
+      timer@b0168000 {
+        compatible =3D "actions,s500-timer";
+        reg =3D <0xb0168000 0x100>;
+        clocks =3D <&hosc>;
+        interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names =3D "2hz0", "2hz1", "timer0", "timer1";
+      };
+    };
+...
diff --git a/Documentation/timers/delay_sleep_functions.rst b/Documentation/t=
imers/delay_sleep_functions.rst
new file mode 100644
index 000000000000..49d603a3f113
--- /dev/null
+++ b/Documentation/timers/delay_sleep_functions.rst
@@ -0,0 +1,121 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Delay and sleep mechanisms
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+This document seeks to answer the common question: "What is the
+RightWay (TM) to insert a delay?"
+
+This question is most often faced by driver writers who have to
+deal with hardware delays and who may not be the most intimately
+familiar with the inner workings of the Linux Kernel.
+
+The following table gives a rough overview about the existing function
+'families' and their limitations. This overview table does not replace the
+reading of the function description before usage!
+
+.. list-table::
+   :widths: 20 20 20 20 20
+   :header-rows: 2
+
+   * -
+     - `*delay()`
+     - `usleep_range*()`
+     - `*sleep()`
+     - `fsleep()`
+   * -
+     - busy-wait loop
+     - hrtimers based
+     - timer list timers based
+     - combines the others
+   * - Usage in atomic Context
+     - yes
+     - no
+     - no
+     - no
+   * - precise on "short intervals"
+     - yes
+     - yes
+     - depends
+     - yes
+   * - precise on "long intervals"
+     - Do not use!
+     - yes
+     - max 12.5% slack
+     - yes
+   * - interruptible variant
+     - no
+     - yes
+     - yes
+     - no
+
+A generic advice for non atomic contexts could be:
+
+#. Use `fsleep()` whenever unsure (as it combines all the advantages of the
+   others)
+#. Use `*sleep()` whenever possible
+#. Use `usleep_range*()` whenever accuracy of `*sleep()` is not sufficient
+#. Use `*delay()` for very, very short delays
+
+Find some more detailed information about the function 'families' in the next
+sections.
+
+`*delay()` family of functions
+------------------------------
+
+These functions use the jiffy estimation of clock speed and will busy wait f=
or
+enough loop cycles to achieve the desired delay. udelay() is the basic
+implementation and ndelay() as well as mdelay() are variants.
+
+These functions are mainly used to add a delay in atomic context. Please make
+sure to ask yourself before adding a delay in atomic context: Is this really
+required?
+
+.. kernel-doc:: include/asm-generic/delay.h
+	:identifiers: udelay ndelay
+
+.. kernel-doc:: include/linux/delay.h
+	:identifiers: mdelay
+
+
+`usleep_range*()` and `*sleep()` family of functions
+----------------------------------------------------
+
+These functions use hrtimers or timer list timers to provide the requested
+sleeping duration. In order to decide which function is the right one to use,
+take some basic information into account:
+
+#. hrtimers are more expensive as they are using an rb-tree (instead of hash=
ing)
+#. hrtimers are more expensive when the requested sleeping duration is the f=
irst
+   timer which means real hardware has to be programmed
+#. timer list timers always provide some sort of slack as they are jiffy bas=
ed
+
+The generic advice is repeated here:
+
+#. Use `fsleep()` whenever unsure (as it combines all the advantages of the
+   others)
+#. Use `*sleep()` whenever possible
+#. Use `usleep_range*()` whenever accuracy of `*sleep()` is not sufficient
+
+First check fsleep() function description and to learn more about accuracy,
+please check msleep() function description.
+
+
+`usleep_range*()`
+~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: include/linux/delay.h
+	:identifiers: usleep_range usleep_range_idle
+
+.. kernel-doc:: kernel/time/sleep_timeout.c
+	:identifiers: usleep_range_state
+
+
+`*sleep()`
+~~~~~~~~~~
+
+.. kernel-doc:: kernel/time/sleep_timeout.c
+       :identifiers: msleep msleep_interruptible
+
+.. kernel-doc:: include/linux/delay.h
+	:identifiers: ssleep fsleep
diff --git a/Documentation/timers/index.rst b/Documentation/timers/index.rst
index 983f91f8f023..4e88116e4dcf 100644
--- a/Documentation/timers/index.rst
+++ b/Documentation/timers/index.rst
@@ -12,7 +12,7 @@ Timers
     hrtimers
     no_hz
     timekeeping
-    timers-howto
+    delay_sleep_functions
=20
 .. only::  subproject and html
=20
diff --git a/Documentation/timers/timers-howto.rst b/Documentation/timers/tim=
ers-howto.rst
deleted file mode 100644
index ef7a4652ccc9..000000000000
--- a/Documentation/timers/timers-howto.rst
+++ /dev/null
@@ -1,115 +0,0 @@
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-delays - Information on the various kernel delay / sleep mechanisms
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-This document seeks to answer the common question: "What is the
-RightWay (TM) to insert a delay?"
-
-This question is most often faced by driver writers who have to
-deal with hardware delays and who may not be the most intimately
-familiar with the inner workings of the Linux Kernel.
-
-
-Inserting Delays
-----------------
-
-The first, and most important, question you need to ask is "Is my
-code in an atomic context?"  This should be followed closely by "Does
-it really need to delay in atomic context?" If so...
-
-ATOMIC CONTEXT:
-	You must use the `*delay` family of functions. These
-	functions use the jiffy estimation of clock speed
-	and will busy wait for enough loop cycles to achieve
-	the desired delay:
-
-	ndelay(unsigned long nsecs)
-	udelay(unsigned long usecs)
-	mdelay(unsigned long msecs)
-
-	udelay is the generally preferred API; ndelay-level
-	precision may not actually exist on many non-PC devices.
-
-	mdelay is macro wrapper around udelay, to account for
-	possible overflow when passing large arguments to udelay.
-	In general, use of mdelay is discouraged and code should
-	be refactored to allow for the use of msleep.
-
-NON-ATOMIC CONTEXT:
-	You should use the `*sleep[_range]` family of functions.
-	There are a few more options here, while any of them may
-	work correctly, using the "right" sleep function will
-	help the scheduler, power management, and just make your
-	driver better :)
-
-	-- Backed by busy-wait loop:
-
-		udelay(unsigned long usecs)
-
-	-- Backed by hrtimers:
-
-		usleep_range(unsigned long min, unsigned long max)
-
-	-- Backed by jiffies / legacy_timers
-
-		msleep(unsigned long msecs)
-		msleep_interruptible(unsigned long msecs)
-
-	Unlike the `*delay` family, the underlying mechanism
-	driving each of these calls varies, thus there are
-	quirks you should be aware of.
-
-
-	SLEEPING FOR "A FEW" USECS ( < ~10us? ):
-		* Use udelay
-
-		- Why not usleep?
-			On slower systems, (embedded, OR perhaps a speed-
-			stepped PC!) the overhead of setting up the hrtimers
-			for usleep *may* not be worth it. Such an evaluation
-			will obviously depend on your specific situation, but
-			it is something to be aware of.
-
-	SLEEPING FOR ~USECS OR SMALL MSECS ( 10us - 20ms):
-		* Use usleep_range
-
-		- Why not msleep for (1ms - 20ms)?
-			Explained originally here:
-				https://lore.kernel.org/r/15327.1186166232@lwn.net
-
-			msleep(1~20) may not do what the caller intends, and
-			will often sleep longer (~20 ms actual sleep for any
-			value given in the 1~20ms range). In many cases this
-			is not the desired behavior.
-
-		- Why is there no "usleep" / What is a good range?
-			Since usleep_range is built on top of hrtimers, the
-			wakeup will be very precise (ish), thus a simple
-			usleep function would likely introduce a large number
-			of undesired interrupts.
-
-			With the introduction of a range, the scheduler is
-			free to coalesce your wakeup with any other wakeup
-			that may have happened for other reasons, or at the
-			worst case, fire an interrupt for your upper bound.
-
-			The larger a range you supply, the greater a chance
-			that you will not trigger an interrupt; this should
-			be balanced with what is an acceptable upper bound on
-			delay / performance for your specific code path. Exact
-			tolerances here are very situation specific, thus it
-			is left to the caller to determine a reasonable range.
-
-	SLEEPING FOR LARGER MSECS ( 10ms+ )
-		* Use msleep or possibly msleep_interruptible
-
-		- What's the difference?
-			msleep sets the current task to TASK_UNINTERRUPTIBLE
-			whereas msleep_interruptible sets the current task to
-			TASK_INTERRUPTIBLE before scheduling the sleep. In
-			short, the difference is whether the sleep can be ended
-			early by a signal. In general, just use msleep unless
-			you know you have a need for the interruptible variant.
-
-	FLEXIBLE SLEEPING (any delay, uninterruptible)
-		* Use fsleep
diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f..3a24287712f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2004,7 +2004,7 @@ F:	Documentation/devicetree/bindings/mmc/owl-mmc.yaml
 F:	Documentation/devicetree/bindings/net/actions,owl-emac.yaml
 F:	Documentation/devicetree/bindings/pinctrl/actions,*
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
-F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
+F:	Documentation/devicetree/bindings/timer/actions,owl-timer.yaml
 F:	arch/arm/boot/dts/actions/
 F:	arch/arm/mach-actions/
 F:	arch/arm64/boot/dts/actions/
@@ -10162,10 +10162,12 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
 F:	Documentation/timers/
 F:	include/linux/clockchips.h
+F:	include/linux/delay.h
 F:	include/linux/hrtimer.h
 F:	include/linux/timer.h
 F:	kernel/time/clockevents.c
 F:	kernel/time/hrtimer.c
+F:	kernel/time/sleep_timeout.c
 F:	kernel/time/timer.c
 F:	kernel/time/timer_list.c
 F:	kernel/time/timer_migration.*
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 9a14f721a2b0..42a3706e16a6 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -93,7 +93,6 @@ static void twd_timer_stop(void)
 {
 	struct clock_event_device *clk =3D raw_cpu_ptr(twd_evt);
=20
-	twd_shutdown(clk);
 	disable_percpu_irq(clk->irq);
 }
=20
diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 08c012a2591f..910d059ec70b 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -1,13 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 if RALINK
=20
-config CLKEVT_RT3352
-	bool
-	depends on SOC_RT305X || SOC_MT7620
-	default y
-	select TIMER_OF
-	select CLKSRC_MMIO
-
 config RALINK_ILL_ACC
 	bool
 	depends on SOC_RT305X
diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
index 26fabbdea1f1..0c109eae1953 100644
--- a/arch/mips/ralink/Makefile
+++ b/arch/mips/ralink/Makefile
@@ -10,8 +10,6 @@ ifndef CONFIG_MIPS_GIC
 	obj-y +=3D clk.o timer.o
 endif
=20
-obj-$(CONFIG_CLKEVT_RT3352) +=3D cevt-rt3352.o
-
 obj-$(CONFIG_RALINK_ILL_ACC) +=3D ill_acc.o
=20
 obj-$(CONFIG_IRQ_INTC) +=3D irq.o
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index f7e86e09c49f..d31c9799cab2 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1390,21 +1390,14 @@ bool __ref rtas_busy_delay(int status)
 		 */
 		ms =3D clamp(ms, 1U, 1000U);
 		/*
-		 * The delay hint is an order-of-magnitude suggestion, not
-		 * a minimum. It is fine, possibly even advantageous, for
-		 * us to pause for less time than hinted. For small values,
-		 * use usleep_range() to ensure we don't sleep much longer
-		 * than actually needed.
-		 *
-		 * See Documentation/timers/timers-howto.rst for
-		 * explanation of the threshold used here. In effect we use
-		 * usleep_range() for 9900 and 9901, msleep() for
-		 * 9902-9905.
+		 * The delay hint is an order-of-magnitude suggestion, not a
+		 * minimum. It is fine, possibly even advantageous, for us to
+		 * pause for less time than hinted. To make sure pause time will
+		 * not be way longer than requested independent of HZ
+		 * configuration, use fsleep(). See fsleep() for details of
+		 * used sleeping functions.
 		 */
-		if (ms <=3D 20)
-			usleep_range(ms * 100, ms * 1000);
-		else
-			msleep(ms);
+		fsleep(ms * 1000);
 		break;
 	case RTAS_BUSY:
 		ret =3D true;
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 2341393cfac1..26c01b9e3434 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -301,7 +301,6 @@ CONFIG_DEBUG_MEMORY_INIT=3Dy
 CONFIG_DEBUG_PER_CPU_MAPS=3Dy
 CONFIG_SOFTLOCKUP_DETECTOR=3Dy
 CONFIG_WQ_WATCHDOG=3Dy
-CONFIG_DEBUG_TIMEKEEPING=3Dy
 CONFIG_DEBUG_RT_MUTEXES=3Dy
 CONFIG_DEBUG_SPINLOCK=3Dy
 CONFIG_DEBUG_MUTEXES=3Dy
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2852fcd82cbd..53a5eda8219c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -145,7 +145,6 @@ config X86
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select BUILDTIME_TABLE_SORT
 	select CLKEVT_I8253
-	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
 	select CLOCKSOURCE_WATCHDOG
 	# Word-size accesses may read uninitialized data past the trailing \0
 	# in strings and cause false KMSAN reports.
diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index 7365dd4acffb..23baf8c9b34c 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -6,8 +6,6 @@
 #include <linux/interrupt.h>
 #include <linux/math64.h>
=20
-#define TICK_SIZE (tick_nsec / 1000)
-
 unsigned long long native_sched_clock(void);
 extern void recalibrate_cpu_khz(void);
=20
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 622fe24da910..a909b817b9c0 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -263,13 +263,6 @@ static void kvm_xen_stop_timer(struct kvm_vcpu *vcpu)
 	atomic_set(&vcpu->arch.xen.timer_pending, 0);
 }
=20
-static void kvm_xen_init_timer(struct kvm_vcpu *vcpu)
-{
-	hrtimer_init(&vcpu->arch.xen.timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_ABS_HARD);
-	vcpu->arch.xen.timer.function =3D xen_timer_callback;
-}
-
 static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
 {
 	struct kvm_vcpu_xen *vx =3D &v->arch.xen;
@@ -1070,9 +1063,6 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct=
 kvm_xen_vcpu_attr *data)
 			break;
 		}
=20
-		if (!vcpu->arch.xen.timer.function)
-			kvm_xen_init_timer(vcpu);
-
 		/* Stop the timer (if it's running) before changing the vector */
 		kvm_xen_stop_timer(vcpu);
 		vcpu->arch.xen.timer_virq =3D data->u.timer.port;
@@ -2235,6 +2225,8 @@ void kvm_xen_init_vcpu(struct kvm_vcpu *vcpu)
 	vcpu->arch.xen.poll_evtchn =3D 0;
=20
 	timer_setup(&vcpu->arch.xen.poll_timer, cancel_evtchn_poll, 0);
+	hrtimer_init(&vcpu->arch.xen.timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
+	vcpu->arch.xen.timer.function =3D xen_timer_callback;
=20
 	kvm_gpc_init(&vcpu->arch.xen.runstate_cache, vcpu->kvm);
 	kvm_gpc_init(&vcpu->arch.xen.runstate2_cache, vcpu->kvm);
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 95dd4660b5b6..487c85259967 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -400,7 +400,8 @@ config ARM_GT_INITIAL_PRESCALER_VAL
 	  This affects CPU_FREQ max delta from the initial frequency.
=20
 config ARM_TIMER_SP804
-	bool "Support for Dual Timer SP804 module" if COMPILE_TEST
+	bool "Support for Dual Timer SP804 module"
+	depends on ARM || ARM64 || COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && HAVE_CLK
 	select CLKSRC_MMIO
 	select TIMER_OF if OF
@@ -753,4 +754,13 @@ config EP93XX_TIMER
 	  Enables support for the Cirrus Logic timer block
 	  EP93XX.
=20
+config RALINK_TIMER
+	bool "Ralink System Tick Counter"
+	depends on SOC_RT305X || SOC_MT7620 || COMPILE_TEST
+	select CLKSRC_MMIO
+	select TIMER_OF
+	help
+	  Enables support for system tick counter present on
+	  Ralink SoCs RT3352 and MT7620.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 22743785299e..43ef16a4efa6 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -91,3 +91,4 @@ obj-$(CONFIG_GOLDFISH_TIMER)		+=3D timer-goldfish.o
 obj-$(CONFIG_GXP_TIMER)			+=3D timer-gxp.o
 obj-$(CONFIG_CLKSRC_LOONGSON1_PWM)	+=3D timer-loongson1-pwm.o
 obj-$(CONFIG_EP93XX_TIMER)		+=3D timer-ep93xx.o
+obj-$(CONFIG_RALINK_TIMER)		+=3D timer-ralink.o
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_a=
rch_timer.c
index 03733101e231..808f259781fd 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1179,8 +1179,6 @@ static void arch_timer_stop(struct clock_event_device *=
clk)
 	disable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi]);
 	if (arch_timer_has_nonsecure_ppi())
 		disable_percpu_irq(arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]);
-
-	clk->set_state_shutdown(clk);
 }
=20
 static int arch_timer_dying_cpu(unsigned int cpu)
@@ -1430,7 +1428,7 @@ static int __init arch_timer_of_init(struct device_node=
 *np)
=20
 	arch_timers_present |=3D ARCH_TIMER_TYPE_CP15;
=20
-	has_names =3D of_property_read_bool(np, "interrupt-names");
+	has_names =3D of_property_present(np, "interrupt-names");
=20
 	for (i =3D ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++) {
 		if (has_names)
diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm=
_global_timer.c
index a05cfaab5f84..2d86bbc2764a 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -195,7 +195,6 @@ static int gt_dying_cpu(unsigned int cpu)
 {
 	struct clock_event_device *clk =3D this_cpu_ptr(gt_evt);
=20
-	gt_clockevent_shutdown(clk);
 	disable_percpu_irq(clk->irq);
 	return 0;
 }
diff --git a/drivers/clocksource/dw_apb_timer.c b/drivers/clocksource/dw_apb_=
timer.c
index f5f24a95ee82..3a55ae5fe225 100644
--- a/drivers/clocksource/dw_apb_timer.c
+++ b/drivers/clocksource/dw_apb_timer.c
@@ -68,25 +68,6 @@ static inline void apbt_writel_relaxed(struct dw_apb_timer=
 *timer, u32 val,
 	writel_relaxed(val, timer->base + offs);
 }
=20
-static void apbt_disable_int(struct dw_apb_timer *timer)
-{
-	u32 ctrl =3D apbt_readl(timer, APBTMR_N_CONTROL);
-
-	ctrl |=3D APBTMR_CONTROL_INT;
-	apbt_writel(timer, ctrl, APBTMR_N_CONTROL);
-}
-
-/**
- * dw_apb_clockevent_pause() - stop the clock_event_device from running
- *
- * @dw_ced:	The APB clock to stop generating events.
- */
-void dw_apb_clockevent_pause(struct dw_apb_clock_event_device *dw_ced)
-{
-	disable_irq(dw_ced->timer.irq);
-	apbt_disable_int(&dw_ced->timer);
-}
-
 static void apbt_eoi(struct dw_apb_timer *timer)
 {
 	apbt_readl_relaxed(timer, APBTMR_N_EOI);
@@ -284,26 +265,6 @@ dw_apb_clockevent_init(int cpu, const char *name, unsign=
ed rating,
 	return dw_ced;
 }
=20
-/**
- * dw_apb_clockevent_resume() - resume a clock that has been paused.
- *
- * @dw_ced:	The APB clock to resume.
- */
-void dw_apb_clockevent_resume(struct dw_apb_clock_event_device *dw_ced)
-{
-	enable_irq(dw_ced->timer.irq);
-}
-
-/**
- * dw_apb_clockevent_stop() - stop the clock_event_device and release the IR=
Q.
- *
- * @dw_ced:	The APB clock to stop generating the events.
- */
-void dw_apb_clockevent_stop(struct dw_apb_clock_event_device *dw_ced)
-{
-	free_irq(dw_ced->timer.irq, &dw_ced->ced);
-}
-
 /**
  * dw_apb_clockevent_register() - register the clock with the generic layer
  *
diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mc=
t.c
index ef8cb1b71be4..e6a02e351d77 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -496,7 +496,6 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
 		per_cpu_ptr(&percpu_mct_tick, cpu);
 	struct clock_event_device *evt =3D &mevt->evt;
=20
-	evt->set_state_shutdown(evt);
 	if (mct_int_type =3D=3D MCT_INT_SPI) {
 		if (evt->irq !=3D -1)
 			disable_irq_nosync(evt->irq);
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-=
gic-timer.c
index 110347707ff9..7907b740497a 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -166,6 +166,37 @@ static u64 gic_hpt_read(struct clocksource *cs)
 	return gic_read_count();
 }
=20
+static u64 gic_hpt_read_multicluster(struct clocksource *cs)
+{
+	unsigned int hi, hi2, lo;
+	u64 count;
+
+	mips_cm_lock_other(0, 0, 0, CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
+
+	if (mips_cm_is64) {
+		count =3D read_gic_redir_counter();
+		goto out;
+	}
+
+	hi =3D read_gic_redir_counter_32h();
+	while (true) {
+		lo =3D read_gic_redir_counter_32l();
+
+		/* If hi didn't change then lo didn't wrap & we're done */
+		hi2 =3D read_gic_redir_counter_32h();
+		if (hi2 =3D=3D hi)
+			break;
+
+		/* Otherwise, repeat with the latest hi value */
+		hi =3D hi2;
+	}
+
+	count =3D (((u64)hi) << 32) + lo;
+out:
+	mips_cm_unlock_other();
+	return count;
+}
+
 static struct clocksource gic_clocksource =3D {
 	.name			=3D "GIC",
 	.read			=3D gic_hpt_read,
@@ -203,6 +234,11 @@ static int __init __gic_clocksource_init(void)
 		gic_clocksource.rating =3D 200;
 	gic_clocksource.rating +=3D clamp(gic_frequency / 10000000, 0, 99);
=20
+	if (mips_cps_multicluster_cpus()) {
+		gic_clocksource.read =3D &gic_hpt_read_multicluster;
+		gic_clocksource.vdso_clock_mode =3D VDSO_CLOCKMODE_NONE;
+	}
+
 	ret =3D clocksource_register_hz(&gic_clocksource, gic_frequency);
 	if (ret < 0)
 		pr_warn("Unable to register clocksource\n");
@@ -261,7 +297,8 @@ static int __init gic_clocksource_of_init(struct device_n=
ode *node)
 	 * stable CPU frequency or on the platforms with CM3 and CPU frequency
 	 * change performed by the CPC core clocks divider.
 	 */
-	if (mips_cm_revision() >=3D CM_REV_CM3 || !IS_ENABLED(CONFIG_CPU_FREQ)) {
+	if ((mips_cm_revision() >=3D CM_REV_CM3 || !IS_ENABLED(CONFIG_CPU_FREQ)) &&
+	     !mips_cps_multicluster_cpus()) {
 		sched_clock_register(mips_cm_is64 ?
 				     gic_read_count_64 : gic_read_count_2x32,
 				     gic_count_width, gic_frequency);
diff --git a/drivers/clocksource/timer-armada-370-xp.c b/drivers/clocksource/=
timer-armada-370-xp.c
index 6ec565d6939a..54284c1c0651 100644
--- a/drivers/clocksource/timer-armada-370-xp.c
+++ b/drivers/clocksource/timer-armada-370-xp.c
@@ -201,7 +201,6 @@ static int armada_370_xp_timer_dying_cpu(unsigned int cpu)
 {
 	struct clock_event_device *evt =3D per_cpu_ptr(armada_370_xp_evt, cpu);
=20
-	evt->set_state_shutdown(evt);
 	disable_percpu_irq(evt->irq);
 	return 0;
 }
diff --git a/drivers/clocksource/timer-gxp.c b/drivers/clocksource/timer-gxp.c
index 57aa2e2cce53..48a73c101eb8 100644
--- a/drivers/clocksource/timer-gxp.c
+++ b/drivers/clocksource/timer-gxp.c
@@ -85,7 +85,7 @@ static int __init gxp_timer_init(struct device_node *node)
=20
 	clk =3D of_clk_get(node, 0);
 	if (IS_ERR(clk)) {
-		ret =3D (int)PTR_ERR(clk);
+		ret =3D PTR_ERR(clk);
 		pr_err("%pOFn clock not found: %d\n", node, ret);
 		goto err_free;
 	}
diff --git a/drivers/clocksource/timer-qcom.c b/drivers/clocksource/timer-qco=
m.c
index eac4c95c6127..ddb1debe6a6b 100644
--- a/drivers/clocksource/timer-qcom.c
+++ b/drivers/clocksource/timer-qcom.c
@@ -130,7 +130,6 @@ static int msm_local_timer_dying_cpu(unsigned int cpu)
 {
 	struct clock_event_device *evt =3D per_cpu_ptr(msm_evt, cpu);
=20
-	evt->set_state_shutdown(evt);
 	disable_percpu_irq(evt->irq);
 	return 0;
 }
diff --git a/arch/mips/ralink/cevt-rt3352.c b/drivers/clocksource/timer-ralin=
k.c
similarity index 91%
rename from arch/mips/ralink/cevt-rt3352.c
rename to drivers/clocksource/timer-ralink.c
index 269d4877d120..6ecdb4228f76 100644
--- a/arch/mips/ralink/cevt-rt3352.c
+++ b/drivers/clocksource/timer-ralink.c
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
+ * Ralink System Tick Counter driver present on RT3352 and MT7620 SoCs.
  *
  * Copyright (C) 2013 by John Crispin <john@phrozen.org>
  */
@@ -16,8 +15,6 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
=20
-#include <asm/mach-ralink/ralink_regs.h>
-
 #define SYSTICK_FREQ		(50 * 1000)
=20
 #define SYSTICK_CONFIG		0x00
@@ -40,7 +37,7 @@ static int systick_set_oneshot(struct clock_event_device *e=
vt);
 static int systick_shutdown(struct clock_event_device *evt);
=20
 static int systick_next_event(unsigned long delta,
-				struct clock_event_device *evt)
+			      struct clock_event_device *evt)
 {
 	struct systick_device *sdev;
 	u32 count;
@@ -60,7 +57,7 @@ static void systick_event_handler(struct clock_event_device=
 *dev)
=20
 static irqreturn_t systick_interrupt(int irq, void *dev_id)
 {
-	struct clock_event_device *dev =3D (struct clock_event_device *) dev_id;
+	struct clock_event_device *dev =3D (struct clock_event_device *)dev_id;
=20
 	dev->event_handler(dev);
=20
diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-te=
gra.c
index e9635c25eef4..35b6ce9deffa 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -158,7 +158,6 @@ static int tegra_timer_stop(unsigned int cpu)
 {
 	struct timer_of *to =3D per_cpu_ptr(&tegra_to, cpu);
=20
-	to->clkevt.set_state_shutdown(&to->clkevt);
 	disable_irq_nosync(to->clkevt.irq);
=20
 	return 0;
diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource=
/timer-ti-dm-systimer.c
index c2dcd8d68e45..985a6d08512b 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -202,10 +202,10 @@ static bool __init dmtimer_is_preferred(struct device_n=
ode *np)
=20
 	/* Secure gptimer12 is always clocked with a fixed source */
 	if (!of_property_read_bool(np, "ti,timer-secure")) {
-		if (!of_property_read_bool(np, "assigned-clocks"))
+		if (!of_property_present(np, "assigned-clocks"))
 			return false;
=20
-		if (!of_property_read_bool(np, "assigned-clock-parents"))
+		if (!of_property_present(np, "assigned-clock-parents"))
 			return false;
 	}
=20
@@ -686,9 +686,9 @@ subsys_initcall(dmtimer_percpu_timer_startup);
=20
 static int __init dmtimer_percpu_quirk_init(struct device_node *np, u32 pa)
 {
-	struct device_node *arm_timer;
+	struct device_node *arm_timer __free(device_node) =3D
+		of_find_compatible_node(NULL, NULL, "arm,armv7-timer");
=20
-	arm_timer =3D of_find_compatible_node(NULL, NULL, "arm,armv7-timer");
 	if (of_device_is_available(arm_timer)) {
 		pr_warn_once("ARM architected timer wrap issue i940 detected\n");
 		return 0;
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti=
-dm.c
index b7a34b1a975e..3666d94cc8dd 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -1104,8 +1104,12 @@ static int omap_dm_timer_probe(struct platform_device =
*pdev)
 		return  -ENOMEM;
=20
 	timer->irq =3D platform_get_irq(pdev, 0);
-	if (timer->irq < 0)
-		return timer->irq;
+	if (timer->irq < 0) {
+		if (of_property_read_bool(dev->of_node, "ti,timer-pwm"))
+			dev_info(dev, "Did not find timer interrupt, timer usable in PWM mode onl=
y\n");
+		else
+			return timer->irq;
+	}
=20
 	timer->io_base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(timer->io_base))
diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_=
request.c
index 519e096c607c..8f62cfa23fb7 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -273,11 +273,6 @@ i915_request_active_engine(struct i915_request *rq,
 	return ret;
 }
=20
-static void __rq_init_watchdog(struct i915_request *rq)
-{
-	rq->watchdog.timer.function =3D NULL;
-}
-
 static enum hrtimer_restart __rq_watchdog_expired(struct hrtimer *hrtimer)
 {
 	struct i915_request *rq =3D
@@ -294,6 +289,14 @@ static enum hrtimer_restart __rq_watchdog_expired(struct=
 hrtimer *hrtimer)
 	return HRTIMER_NORESTART;
 }
=20
+static void __rq_init_watchdog(struct i915_request *rq)
+{
+	struct i915_request_watchdog *wdg =3D &rq->watchdog;
+
+	hrtimer_init(&wdg->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	wdg->timer.function =3D __rq_watchdog_expired;
+}
+
 static void __rq_arm_watchdog(struct i915_request *rq)
 {
 	struct i915_request_watchdog *wdg =3D &rq->watchdog;
@@ -304,8 +307,6 @@ static void __rq_arm_watchdog(struct i915_request *rq)
=20
 	i915_request_get(rq);
=20
-	hrtimer_init(&wdg->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	wdg->timer.function =3D __rq_watchdog_expired;
 	hrtimer_start_range_ns(&wdg->timer,
 			       ns_to_ktime(ce->watchdog.timeout_us *
 					   NSEC_PER_USEC),
@@ -317,7 +318,7 @@ static void __rq_cancel_watchdog(struct i915_request *rq)
 {
 	struct i915_request_watchdog *wdg =3D &rq->watchdog;
=20
-	if (wdg->timer.function && hrtimer_try_to_cancel(&wdg->timer) > 0)
+	if (hrtimer_try_to_cancel(&wdg->timer) > 0)
 		i915_request_put(rq);
 }
=20
diff --git a/drivers/media/usb/dvb-usb-v2/anysee.c b/drivers/media/usb/dvb-us=
b-v2/anysee.c
index 8699846eb416..bea12cdc85e8 100644
--- a/drivers/media/usb/dvb-usb-v2/anysee.c
+++ b/drivers/media/usb/dvb-usb-v2/anysee.c
@@ -46,24 +46,15 @@ static int anysee_ctrl_msg(struct dvb_usb_device *d,
=20
 	dev_dbg(&d->udev->dev, "%s: >>> %*ph\n", __func__, slen, state->buf);
=20
-	/* We need receive one message more after dvb_usb_generic_rw due
-	   to weird transaction flow, which is 1 x send + 2 x receive. */
+	/*
+	 * We need receive one message more after dvb_usbv2_generic_rw_locked()
+	 * due to weird transaction flow, which is 1 x send + 2 x receive.
+	 */
 	ret =3D dvb_usbv2_generic_rw_locked(d, state->buf, sizeof(state->buf),
 			state->buf, sizeof(state->buf));
 	if (ret)
 		goto error_unlock;
=20
-	/* TODO FIXME: dvb_usb_generic_rw() fails rarely with error code -32
-	 * (EPIPE, Broken pipe). Function supports currently msleep() as a
-	 * parameter but I would not like to use it, since according to
-	 * Documentation/timers/timers-howto.rst it should not be used such
-	 * short, under < 20ms, sleeps. Repeating failed message would be
-	 * better choice as not to add unwanted delays...
-	 * Fixing that correctly is one of those or both;
-	 * 1) use repeat if possible
-	 * 2) add suitable delay
-	 */
-
 	/* get answer, retry few times if error returned */
 	for (i =3D 0; i < 3; i++) {
 		/* receive 2nd answer */
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c b/drivers/net/wir=
eless/ralink/rt2x00/rt2x00usb.c
index 8fd22c69855f..a6d50149e0c3 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
@@ -823,8 +823,6 @@ int rt2x00usb_probe(struct usb_interface *usb_intf,
=20
 	INIT_WORK(&rt2x00dev->rxdone_work, rt2x00usb_work_rxdone);
 	INIT_WORK(&rt2x00dev->txdone_work, rt2x00usb_work_txdone);
-	hrtimer_init(&rt2x00dev->txstatus_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
=20
 	retval =3D rt2x00usb_alloc_reg(rt2x00dev);
 	if (retval)
diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/ch=
arger-manager.c
index 96f0a7fbf105..09ec0ecf1486 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1412,10 +1412,9 @@ static inline struct charger_desc *cm_get_drv_data(str=
uct platform_device *pdev)
 	return dev_get_platdata(&pdev->dev);
 }
=20
-static enum alarmtimer_restart cm_timer_func(struct alarm *alarm, ktime_t no=
w)
+static void cm_timer_func(struct alarm *alarm, ktime_t now)
 {
 	cm_timer_set =3D false;
-	return ALARMTIMER_NORESTART;
 }
=20
 static int charger_manager_probe(struct platform_device *pdev)
diff --git a/fs/aio.c b/fs/aio.c
index e8920178b50f..a5d331f29943 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1335,7 +1335,7 @@ static long read_events(struct kioctx *ctx, long min_nr=
, long nr,
 	if (until =3D=3D 0 || ret < 0 || ret >=3D min_nr)
 		return ret;
=20
-	hrtimer_init_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_setup_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	if (until !=3D KTIME_MAX) {
 		hrtimer_set_expires_range_ns(&t.timer, until, current->timer_slack_ns);
 		hrtimer_sleeper_start_expires(&t, HRTIMER_MODE_REL);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index b31283d81c52..6a37a43241e4 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2553,8 +2553,8 @@ static int show_timer(struct seq_file *m, void *v)
=20
 	seq_printf(m, "ID: %d\n", timer->it_id);
 	seq_printf(m, "signal: %d/%px\n",
-		   timer->sigq->info.si_signo,
-		   timer->sigq->info.si_value.sival_ptr);
+		   timer->sigq.info.si_signo,
+		   timer->sigq.info.si_value.sival_ptr);
 	seq_printf(m, "notify: %s/%s.%d\n",
 		   nstr[notify & ~SIGEV_THREAD_ID],
 		   (notify & SIGEV_THREAD_ID) ? "tid" : "pid",
diff --git a/fs/timerfd.c b/fs/timerfd.c
index 137523e0bb21..f10c99ad5c60 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -79,13 +79,11 @@ static enum hrtimer_restart timerfd_tmrproc(struct hrtime=
r *htmr)
 	return HRTIMER_NORESTART;
 }
=20
-static enum alarmtimer_restart timerfd_alarmproc(struct alarm *alarm,
-	ktime_t now)
+static void timerfd_alarmproc(struct alarm *alarm, ktime_t now)
 {
 	struct timerfd_ctx *ctx =3D container_of(alarm, struct timerfd_ctx,
 					       t.alarm);
 	timerfd_triggered(ctx);
-	return ALARMTIMER_NORESTART;
 }
=20
 /*
diff --git a/include/asm-generic/delay.h b/include/asm-generic/delay.h
index e448ac61430c..76cf237b6e4c 100644
--- a/include/asm-generic/delay.h
+++ b/include/asm-generic/delay.h
@@ -2,6 +2,9 @@
 #ifndef __ASM_GENERIC_DELAY_H
 #define __ASM_GENERIC_DELAY_H
=20
+#include <linux/math.h>
+#include <vdso/time64.h>
+
 /* Undefined functions to get compile-time errors */
 extern void __bad_udelay(void);
 extern void __bad_ndelay(void);
@@ -12,34 +15,73 @@ extern void __const_udelay(unsigned long xloops);
 extern void __delay(unsigned long loops);
=20
 /*
- * The weird n/20000 thing suppresses a "comparison is always false due to
- * limited range of data type" warning with non-const 8-bit arguments.
+ * The microseconds/nanosecond delay multiplicators are used to convert a
+ * constant microseconds/nanoseconds value to a value which can be used by t=
he
+ * architectures specific implementation to transform it into loops.
+ */
+#define UDELAY_CONST_MULT	((unsigned long)DIV_ROUND_UP(1ULL << 32, USEC_PER_=
SEC))
+#define NDELAY_CONST_MULT	((unsigned long)DIV_ROUND_UP(1ULL << 32, NSEC_PER_=
SEC))
+
+/*
+ * The maximum constant udelay/ndelay value picked out of thin air to prevent
+ * too long constant udelays/ndelays.
  */
+#define DELAY_CONST_MAX   20000
=20
-/* 0x10c7 is 2**32 / 1000000 (rounded up) */
-#define udelay(n)							\
-	({								\
-		if (__builtin_constant_p(n)) {				\
-			if ((n) / 20000 >=3D 1)				\
-				 __bad_udelay();			\
-			else						\
-				__const_udelay((n) * 0x10c7ul);		\
-		} else {						\
-			__udelay(n);					\
-		}							\
-	})
-
-/* 0x5 is 2**32 / 1000000000 (rounded up) */
-#define ndelay(n)							\
-	({								\
-		if (__builtin_constant_p(n)) {				\
-			if ((n) / 20000 >=3D 1)				\
-				__bad_ndelay();				\
-			else						\
-				__const_udelay((n) * 5ul);		\
-		} else {						\
-			__ndelay(n);					\
-		}							\
-	})
+/**
+ * udelay - Inserting a delay based on microseconds with busy waiting
+ * @usec:	requested delay in microseconds
+ *
+ * When delaying in an atomic context ndelay(), udelay() and mdelay() are the
+ * only valid variants of delaying/sleeping to go with.
+ *
+ * When inserting delays in non atomic context which are shorter than the ti=
me
+ * which is required to queue e.g. an hrtimer and to enter then the schedule=
r,
+ * it is also valuable to use udelay(). But it is not simple to specify a
+ * generic threshold for this which will fit for all systems. An approximati=
on
+ * is a threshold for all delays up to 10 microseconds.
+ *
+ * When having a delay which is larger than the architecture specific
+ * %MAX_UDELAY_MS value, please make sure mdelay() is used. Otherwise a over=
flow
+ * risk is given.
+ *
+ * Please note that ndelay(), udelay() and mdelay() may return early for sev=
eral
+ * reasons (https://lists.openwall.net/linux-kernel/2011/01/09/56):
+ *
+ * #. computed loops_per_jiffy too low (due to the time taken to execute the
+ *    timer interrupt.)
+ * #. cache behaviour affecting the time it takes to execute the loop functi=
on.
+ * #. CPU clock rate changes.
+ */
+static __always_inline void udelay(unsigned long usec)
+{
+	if (__builtin_constant_p(usec)) {
+		if (usec >=3D DELAY_CONST_MAX)
+			__bad_udelay();
+		else
+			__const_udelay(usec * UDELAY_CONST_MULT);
+	} else {
+		__udelay(usec);
+	}
+}
+
+/**
+ * ndelay - Inserting a delay based on nanoseconds with busy waiting
+ * @nsec:	requested delay in nanoseconds
+ *
+ * See udelay() for basic information about ndelay() and it's variants.
+ */
+static __always_inline void ndelay(unsigned long nsec)
+{
+	if (__builtin_constant_p(nsec)) {
+		if (nsec >=3D DELAY_CONST_MAX)
+			__bad_udelay();
+		else
+			__const_udelay(nsec * NDELAY_CONST_MULT);
+	} else {
+		__udelay(nsec);
+	}
+}
+#define ndelay(x) ndelay(x)
=20
 #endif /* __ASM_GENERIC_DELAY_H */
diff --git a/include/linux/alarmtimer.h b/include/linux/alarmtimer.h
index 05e758b8b894..3ffa5341dce2 100644
--- a/include/linux/alarmtimer.h
+++ b/include/linux/alarmtimer.h
@@ -20,12 +20,6 @@ enum alarmtimer_type {
 	ALARM_BOOTTIME_FREEZER,
 };
=20
-enum alarmtimer_restart {
-	ALARMTIMER_NORESTART,
-	ALARMTIMER_RESTART,
-};
-
-
 #define ALARMTIMER_STATE_INACTIVE	0x00
 #define ALARMTIMER_STATE_ENQUEUED	0x01
=20
@@ -42,14 +36,14 @@ enum alarmtimer_restart {
 struct alarm {
 	struct timerqueue_node	node;
 	struct hrtimer		timer;
-	enum alarmtimer_restart	(*function)(struct alarm *, ktime_t now);
+	void			(*function)(struct alarm *, ktime_t now);
 	enum alarmtimer_type	type;
 	int			state;
 	void			*data;
 };
=20
 void alarm_init(struct alarm *alarm, enum alarmtimer_type type,
-		enum alarmtimer_restart (*function)(struct alarm *, ktime_t));
+		void (*function)(struct alarm *, ktime_t));
 void alarm_start(struct alarm *alarm, ktime_t start);
 void alarm_start_relative(struct alarm *alarm, ktime_t start);
 void alarm_restart(struct alarm *alarm);
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index d35b677b08fe..ef1b16da6ad5 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -215,7 +215,6 @@ static inline s64 clocksource_cyc2ns(u64 cycles, u32 mult=
, u32 shift)
=20
 extern int clocksource_unregister(struct clocksource*);
 extern void clocksource_touch_watchdog(void);
-extern void clocksource_change_rating(struct clocksource *cs, int rating);
 extern void clocksource_suspend(void);
 extern void clocksource_resume(void);
 extern struct clocksource * __init clocksource_default_clock(void);
diff --git a/include/linux/delay.h b/include/linux/delay.h
index ff9cda975e30..89866bab100d 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -6,21 +6,12 @@
  * Copyright (C) 1993 Linus Torvalds
  *
  * Delay routines, using a pre-computed "loops_per_jiffy" value.
- *
- * Please note that ndelay(), udelay() and mdelay() may return early for
- * several reasons:
- *  1. computed loops_per_jiffy too low (due to the time taken to
- *     execute the timer interrupt.)
- *  2. cache behaviour affecting the time it takes to execute the
- *     loop function.
- *  3. CPU clock rate changes.
- *
- * Please see this thread:
- *   https://lists.openwall.net/linux-kernel/2011/01/09/56
+ * Sleep routines using timer list timers or hrtimers.
  */
=20
 #include <linux/math.h>
 #include <linux/sched.h>
+#include <linux/jiffies.h>
=20
 extern unsigned long loops_per_jiffy;
=20
@@ -35,12 +26,21 @@ extern unsigned long loops_per_jiffy;
  * The 2nd mdelay() definition ensures GCC will optimize away the=20
  * while loop for the common cases where n <=3D MAX_UDELAY_MS  --  Paul G.
  */
-
 #ifndef MAX_UDELAY_MS
 #define MAX_UDELAY_MS	5
 #endif
=20
 #ifndef mdelay
+/**
+ * mdelay - Inserting a delay based on milliseconds with busy waiting
+ * @n:	requested delay in milliseconds
+ *
+ * See udelay() for basic information about mdelay() and it's variants.
+ *
+ * Please double check, whether mdelay() is the right way to go or whether a
+ * refactoring of the code is the better variant to be able to use msleep()
+ * instead.
+ */
 #define mdelay(n) (\
 	(__builtin_constant_p(n) && (n)<=3DMAX_UDELAY_MS) ? udelay((n)*1000) : \
 	({unsigned long __ms=3D(n); while (__ms--) udelay(1000);}))
@@ -63,30 +63,75 @@ unsigned long msleep_interruptible(unsigned int msecs);
 void usleep_range_state(unsigned long min, unsigned long max,
 			unsigned int state);
=20
+/**
+ * usleep_range - Sleep for an approximate time
+ * @min:	Minimum time in microseconds to sleep
+ * @max:	Maximum time in microseconds to sleep
+ *
+ * For basic information please refere to usleep_range_state().
+ *
+ * The task will be in the state TASK_UNINTERRUPTIBLE during the sleep.
+ */
 static inline void usleep_range(unsigned long min, unsigned long max)
 {
 	usleep_range_state(min, max, TASK_UNINTERRUPTIBLE);
 }
=20
-static inline void usleep_idle_range(unsigned long min, unsigned long max)
+/**
+ * usleep_range_idle - Sleep for an approximate time with idle time accounti=
ng
+ * @min:	Minimum time in microseconds to sleep
+ * @max:	Maximum time in microseconds to sleep
+ *
+ * For basic information please refere to usleep_range_state().
+ *
+ * The sleeping task has the state TASK_IDLE during the sleep to prevent
+ * contribution to the load avarage.
+ */
+static inline void usleep_range_idle(unsigned long min, unsigned long max)
 {
 	usleep_range_state(min, max, TASK_IDLE);
 }
=20
+/**
+ * ssleep - wrapper for seconds around msleep
+ * @seconds:	Requested sleep duration in seconds
+ *
+ * Please refere to msleep() for detailed information.
+ */
 static inline void ssleep(unsigned int seconds)
 {
 	msleep(seconds * 1000);
 }
=20
-/* see Documentation/timers/timers-howto.rst for the thresholds */
+static const unsigned int max_slack_shift =3D 2;
+#define USLEEP_RANGE_UPPER_BOUND	((TICK_NSEC << max_slack_shift) / NSEC_PER_=
USEC)
+
+/**
+ * fsleep - flexible sleep which autoselects the best mechanism
+ * @usecs:	requested sleep duration in microseconds
+ *
+ * flseep() selects the best mechanism that will provide maximum 25% slack
+ * to the requested sleep duration. Therefore it uses:
+ *
+ * * udelay() loop for sleep durations <=3D 10 microseconds to avoid hrtimer
+ *   overhead for really short sleep durations.
+ * * usleep_range() for sleep durations which would lead with the usage of
+ *   msleep() to a slack larger than 25%. This depends on the granularity of
+ *   jiffies.
+ * * msleep() for all other sleep durations.
+ *
+ * Note: When %CONFIG_HIGH_RES_TIMERS is not set, all sleeps are processed w=
ith
+ * the granularity of jiffies and the slack might exceed 25% especially for
+ * short sleep durations.
+ */
 static inline void fsleep(unsigned long usecs)
 {
 	if (usecs <=3D 10)
 		udelay(usecs);
-	else if (usecs <=3D 20000)
-		usleep_range(usecs, 2 * usecs);
+	else if (usecs < USLEEP_RANGE_UPPER_BOUND)
+		usleep_range(usecs, usecs + (usecs >> max_slack_shift));
 	else
-		msleep(DIV_ROUND_UP(usecs, 1000));
+		msleep(DIV_ROUND_UP(usecs, USEC_PER_MSEC));
 }
=20
 #endif /* defined(_LINUX_DELAY_H) */
diff --git a/include/linux/dw_apb_timer.h b/include/linux/dw_apb_timer.h
index 82ebf9223948..f8811c46b89e 100644
--- a/include/linux/dw_apb_timer.h
+++ b/include/linux/dw_apb_timer.h
@@ -34,9 +34,6 @@ struct dw_apb_clocksource {
 };
=20
 void dw_apb_clockevent_register(struct dw_apb_clock_event_device *dw_ced);
-void dw_apb_clockevent_pause(struct dw_apb_clock_event_device *dw_ced);
-void dw_apb_clockevent_resume(struct dw_apb_clock_event_device *dw_ced);
-void dw_apb_clockevent_stop(struct dw_apb_clock_event_device *dw_ced);
=20
 struct dw_apb_clock_event_device *
 dw_apb_clockevent_init(int cpu, const char *name, unsigned rating,
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index aa1e65ccb615..7ef5f7ef31a9 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -228,32 +228,17 @@ static inline void hrtimer_cancel_wait_running(struct h=
rtimer *timer)
 /* Initialize timers: */
 extern void hrtimer_init(struct hrtimer *timer, clockid_t which_clock,
 			 enum hrtimer_mode mode);
-extern void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, clockid_t clock=
_id,
-				 enum hrtimer_mode mode);
+extern void hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*func=
tion)(struct hrtimer *),
+			  clockid_t clock_id, enum hrtimer_mode mode);
+extern void hrtimer_setup_on_stack(struct hrtimer *timer,
+				   enum hrtimer_restart (*function)(struct hrtimer *),
+				   clockid_t clock_id, enum hrtimer_mode mode);
+extern void hrtimer_setup_sleeper_on_stack(struct hrtimer_sleeper *sl, clock=
id_t clock_id,
+					   enum hrtimer_mode mode);
=20
 #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
-extern void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t which_clo=
ck,
-				  enum hrtimer_mode mode);
-extern void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
-					  clockid_t clock_id,
-					  enum hrtimer_mode mode);
-
 extern void destroy_hrtimer_on_stack(struct hrtimer *timer);
 #else
-static inline void hrtimer_init_on_stack(struct hrtimer *timer,
-					 clockid_t which_clock,
-					 enum hrtimer_mode mode)
-{
-	hrtimer_init(timer, which_clock, mode);
-}
-
-static inline void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
-						 clockid_t clock_id,
-						 enum hrtimer_mode mode)
-{
-	hrtimer_init_sleeper(sl, clock_id, mode);
-}
-
 static inline void destroy_hrtimer_on_stack(struct hrtimer *timer) { }
 #endif
=20
@@ -337,6 +322,28 @@ static inline int hrtimer_callback_running(struct hrtime=
r *timer)
 	return timer->base->running =3D=3D timer;
 }
=20
+/**
+ * hrtimer_update_function - Update the timer's callback function
+ * @timer:	Timer to update
+ * @function:	New callback function
+ *
+ * Only safe to call if the timer is not enqueued. Can be called in the call=
back function if the
+ * timer is not enqueued at the same time (see the comments above HRTIMER_ST=
ATE_ENQUEUED).
+ */
+static inline void hrtimer_update_function(struct hrtimer *timer,
+					   enum hrtimer_restart (*function)(struct hrtimer *))
+{
+	guard(raw_spinlock_irqsave)(&timer->base->cpu_base->lock);
+
+	if (WARN_ON_ONCE(hrtimer_is_queued(timer)))
+		return;
+
+	if (WARN_ON_ONCE(!function))
+		return;
+
+	timer->function =3D function;
+}
+
 /* Forward a hrtimer so it expires after now: */
 extern u64
 hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval);
diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 19a7b00baff4..91324c331a4b 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -19,19 +19,19 @@
  * @op: accessor function (takes @args as its arguments)
  * @val: Variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @sleep_us: Maximum time to sleep between reads in us (0
- *            tight-loops).  Should be less than ~20ms since usleep_range
- *            is used (see Documentation/timers/timers-howto.rst).
+ * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Ple=
ase
+ *            read usleep_range() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  * @sleep_before_read: if it is true, sleep @sleep_us before read.
  * @args: arguments for @op poll
  *
- * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
- * case, the last read value at @args is stored in @val. Must not
- * be called from atomic context if sleep_us or timeout_us are used.
- *
  * When available, you'll probably want to use one of the specialized
  * macros defined below rather than this macro directly.
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @args is stored in @val. Must not
+ * be called from atomic context if sleep_us or timeout_us are used.
  */
 #define read_poll_timeout(op, val, cond, sleep_us, timeout_us, \
 				sleep_before_read, args...) \
@@ -64,22 +64,22 @@
  * @op: accessor function (takes @args as its arguments)
  * @val: Variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @delay_us: Time to udelay between reads in us (0 tight-loops).  Should
- *            be less than ~10us since udelay is used (see
- *            Documentation/timers/timers-howto.rst).
+ * @delay_us: Time to udelay between reads in us (0 tight-loops). Please
+ *            read udelay() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  * @delay_before_read: if it is true, delay @delay_us before read.
  * @args: arguments for @op poll
  *
- * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
- * case, the last read value at @args is stored in @val.
- *
  * This macro does not rely on timekeeping.  Hence it is safe to call even w=
hen
  * timekeeping is suspended, at the expense of an underestimation of wall cl=
ock
  * time, which is rather minimal with a non-zero delay_us.
  *
  * When available, you'll probably want to use one of the specialized
  * macros defined below rather than this macro directly.
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @args is stored in @val.
  */
 #define read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, \
 					delay_before_read, args...) \
@@ -119,17 +119,17 @@
  * @addr: Address to poll
  * @val: Variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @sleep_us: Maximum time to sleep between reads in us (0
- *            tight-loops).  Should be less than ~20ms since usleep_range
- *            is used (see Documentation/timers/timers-howto.rst).
+ * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Ple=
ase
+ *            read usleep_range() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  *
- * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
- * case, the last read value at @addr is stored in @val. Must not
- * be called from atomic context if sleep_us or timeout_us are used.
- *
  * When available, you'll probably want to use one of the specialized
  * macros defined below rather than this macro directly.
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @addr is stored in @val. Must not
+ * be called from atomic context if sleep_us or timeout_us are used.
  */
 #define readx_poll_timeout(op, addr, val, cond, sleep_us, timeout_us)	\
 	read_poll_timeout(op, val, cond, sleep_us, timeout_us, false, addr)
@@ -140,16 +140,16 @@
  * @addr: Address to poll
  * @val: Variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @delay_us: Time to udelay between reads in us (0 tight-loops).  Should
- *            be less than ~10us since udelay is used (see
- *            Documentation/timers/timers-howto.rst).
+ * @delay_us: Time to udelay between reads in us (0 tight-loops). Please
+ *            read udelay() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  *
- * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
- * case, the last read value at @addr is stored in @val.
- *
  * When available, you'll probably want to use one of the specialized
  * macros defined below rather than this macro directly.
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @addr is stored in @val.
  */
 #define readx_poll_timeout_atomic(op, addr, val, cond, delay_us, timeout_us)=
 \
 	read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, false, addr)
diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 1220f0fbe5bf..ed945f42e064 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -502,7 +502,7 @@ static inline unsigned long _msecs_to_jiffies(const unsig=
ned int m)
  * - all other values are converted to jiffies by either multiplying
  *   the input value by a factor or dividing it with a factor and
  *   handling any 32-bit overflows.
- *   for the details see __msecs_to_jiffies()
+ *   for the details see _msecs_to_jiffies()
  *
  * msecs_to_jiffies() checks for the passed in value being a constant
  * via __builtin_constant_p() allowing gcc to eliminate most of the
@@ -526,6 +526,19 @@ static __always_inline unsigned long msecs_to_jiffies(co=
nst unsigned int m)
 	}
 }
=20
+/**
+ * secs_to_jiffies: - convert seconds to jiffies
+ * @_secs: time in seconds
+ *
+ * Conversion is done by simple multiplication with HZ
+ *
+ * secs_to_jiffies() is defined as a macro rather than a static inline
+ * function so it can be used in static initializers.
+ *
+ * Return: jiffies value
+ */
+#define secs_to_jiffies(_secs) ((_secs) * HZ)
+
 extern unsigned long __usecs_to_jiffies(const unsigned int u);
 #if !(USEC_PER_SEC % HZ)
 static inline unsigned long _usecs_to_jiffies(const unsigned int u)
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a98bc91a0cde..504766d4b2d5 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1378,12 +1378,13 @@ int phy_read_mmd(struct phy_device *phydev, int devad=
, u32 regnum);
  * @regnum: The register on the MMD to read
  * @val: Variable to read the register into
  * @cond: Break condition (usually involving @val)
- * @sleep_us: Maximum time to sleep between reads in us (0
- *            tight-loops).  Should be less than ~20ms since usleep_range
- *            is used (see Documentation/timers/timers-howto.rst).
+ * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Ple=
ase
+ *            read usleep_range() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  * @sleep_before_read: if it is true, sleep @sleep_us before read.
- * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
  * case, the last read value at @args is stored in @val. Must not
  * be called from atomic context if sleep_us or timeout_us are used.
  */
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 453691710839..f11f10c97bd9 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -5,12 +5,16 @@
 #include <linux/alarmtimer.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/pid.h>
 #include <linux/posix-timers_types.h>
+#include <linux/rcuref.h>
 #include <linux/spinlock.h>
 #include <linux/timerqueue.h>
=20
 struct kernel_siginfo;
 struct task_struct;
+struct sigqueue;
+struct k_itimer;
=20
 static inline clockid_t make_process_cpuclock(const unsigned int pid,
 		const clockid_t clock)
@@ -35,6 +39,8 @@ static inline int clockid_to_fd(const clockid_t clk)
=20
 #ifdef CONFIG_POSIX_TIMERS
=20
+#include <linux/signal_types.h>
+
 /**
  * cpu_timer - Posix CPU timer representation for k_itimer
  * @node:	timerqueue node to queue in the task/sig
@@ -42,6 +48,7 @@ static inline int clockid_to_fd(const clockid_t clk)
  * @pid:	Pointer to target task PID
  * @elist:	List head for the expiry list
  * @firing:	Timer is currently firing
+ * @nanosleep:	Timer is used for nanosleep and is not a regular posix-timer
  * @handling:	Pointer to the task which handles expiry
  */
 struct cpu_timer {
@@ -49,7 +56,8 @@ struct cpu_timer {
 	struct timerqueue_head		*head;
 	struct pid			*pid;
 	struct list_head		elist;
-	int				firing;
+	bool				firing;
+	bool				nanosleep;
 	struct task_struct __rcu	*handling;
 };
=20
@@ -101,6 +109,12 @@ static inline void posix_cputimers_rt_watchdog(struct po=
six_cputimers *pct,
 	pct->bases[CPUCLOCK_SCHED].nextevt =3D runtime;
 }
=20
+void posixtimer_rearm_itimer(struct task_struct *p);
+bool posixtimer_init_sigqueue(struct sigqueue *q);
+void posixtimer_send_sigqueue(struct k_itimer *tmr);
+bool posixtimer_deliver_signal(struct kernel_siginfo *info, struct sigqueue =
*timer_sigq);
+void posixtimer_free_timer(struct k_itimer *timer);
+
 /* Init task static initializer */
 #define INIT_CPU_TIMERBASE(b) {						\
 	.nextevt	=3D U64_MAX,					\
@@ -122,6 +136,10 @@ struct cpu_timer { };
 static inline void posix_cputimers_init(struct posix_cputimers *pct) { }
 static inline void posix_cputimers_group_init(struct posix_cputimers *pct,
 					      u64 cpu_limit) { }
+static inline void posixtimer_rearm_itimer(struct task_struct *p) { }
+static inline bool posixtimer_deliver_signal(struct kernel_siginfo *info,
+					     struct sigqueue *timer_sigq) { return false; }
+static inline void posixtimer_free_timer(struct k_itimer *timer) { }
 #endif
=20
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
@@ -132,50 +150,56 @@ static inline void clear_posix_cputimers_work(struct ta=
sk_struct *p) { }
 static inline void posix_cputimers_init_work(void) { }
 #endif
=20
-#define REQUEUE_PENDING 1
-
 /**
  * struct k_itimer - POSIX.1b interval timer structure.
- * @list:		List head for binding the timer to signals->posix_timers
+ * @list:		List node for binding the timer to tsk::signal::posix_timers
+ * @ignored_list:	List node for tracking ignored timers in tsk::signal::igno=
red_posix_timers
  * @t_hash:		Entry in the posix timer hash table
  * @it_lock:		Lock protecting the timer
  * @kclock:		Pointer to the k_clock struct handling this timer
  * @it_clock:		The posix timer clock id
  * @it_id:		The posix timer id for identifying the timer
- * @it_active:		Marker that timer is active
+ * @it_status:		The status of the timer
+ * @it_sig_periodic:	The periodic status at signal delivery
  * @it_overrun:		The overrun counter for pending signals
  * @it_overrun_last:	The overrun at the time of the last delivered signal
- * @it_requeue_pending:	Indicator that timer waits for being requeued on
- *			signal delivery
+ * @it_signal_seq:	Sequence count to control signal delivery
+ * @it_sigqueue_seq:	The sequence count at the point where the signal was qu=
eued
  * @it_sigev_notify:	The notify word of sigevent struct for signal delivery
  * @it_interval:	The interval for periodic timers
  * @it_signal:		Pointer to the creators signal struct
  * @it_pid:		The pid of the process/task targeted by the signal
  * @it_process:		The task to wakeup on clock_nanosleep (CPU timers)
- * @sigq:		Pointer to preallocated sigqueue
+ * @rcuref:		Reference count for life time management
+ * @sigq:		Embedded sigqueue
  * @it:			Union representing the various posix timer type
  *			internals.
  * @rcu:		RCU head for freeing the timer.
  */
 struct k_itimer {
 	struct hlist_node	list;
+	struct hlist_node	ignored_list;
 	struct hlist_node	t_hash;
 	spinlock_t		it_lock;
 	const struct k_clock	*kclock;
 	clockid_t		it_clock;
 	timer_t			it_id;
-	int			it_active;
+	int			it_status;
+	bool			it_sig_periodic;
 	s64			it_overrun;
 	s64			it_overrun_last;
-	int			it_requeue_pending;
+	unsigned int		it_signal_seq;
+	unsigned int		it_sigqueue_seq;
 	int			it_sigev_notify;
+	enum pid_type		it_pid_type;
 	ktime_t			it_interval;
 	struct signal_struct	*it_signal;
 	union {
 		struct pid		*it_pid;
 		struct task_struct	*it_process;
 	};
-	struct sigqueue		*sigq;
+	struct sigqueue		sigq;
+	rcuref_t		rcuref;
 	union {
 		struct {
 			struct hrtimer	timer;
@@ -196,5 +220,29 @@ void set_process_cpu_timer(struct task_struct *task, uns=
igned int clock_idx,
=20
 int update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new);
=20
-void posixtimer_rearm(struct kernel_siginfo *info);
+#ifdef CONFIG_POSIX_TIMERS
+static inline void posixtimer_putref(struct k_itimer *tmr)
+{
+	if (rcuref_put(&tmr->rcuref))
+		posixtimer_free_timer(tmr);
+}
+
+static inline void posixtimer_sigqueue_getref(struct sigqueue *q)
+{
+	struct k_itimer *tmr =3D container_of(q, struct k_itimer, sigq);
+
+	WARN_ON_ONCE(!rcuref_get(&tmr->rcuref));
+}
+
+static inline void posixtimer_sigqueue_putref(struct sigqueue *q)
+{
+	struct k_itimer *tmr =3D container_of(q, struct k_itimer, sigq);
+
+	posixtimer_putref(tmr);
+}
+#else  /* CONFIG_POSIX_TIMERS */
+static inline void posixtimer_sigqueue_getref(struct sigqueue *q) { }
+static inline void posixtimer_sigqueue_putref(struct sigqueue *q) { }
+#endif /* !CONFIG_POSIX_TIMERS */
+
 #endif
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index f9ccad32fc5c..75f162b60ba1 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -106,17 +106,17 @@ struct reg_sequence {
  * @addr: Address to poll
  * @val: Unsigned integer variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @sleep_us: Maximum time to sleep between reads in us (0
- *            tight-loops).  Should be less than ~20ms since usleep_range
- *            is used (see Documentation/timers/timers-howto.rst).
+ * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Ple=
ase
+ *            read usleep_range() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  *
- * Returns 0 on success and -ETIMEDOUT upon a timeout or the regmap_read
+ * This is modelled after the readx_poll_timeout macros in linux/iopoll.h.
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout or the regmap_read
  * error return value in case of a error read. In the two former cases,
  * the last read value at @addr is stored in @val. Must not be called
  * from atomic context if sleep_us or timeout_us are used.
- *
- * This is modelled after the readx_poll_timeout macros in linux/iopoll.h.
  */
 #define regmap_read_poll_timeout(map, addr, val, cond, sleep_us, timeout_us)=
 \
 ({ \
@@ -133,20 +133,20 @@ struct reg_sequence {
  * @addr: Address to poll
  * @val: Unsigned integer variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @delay_us: Time to udelay between reads in us (0 tight-loops).
- *            Should be less than ~10us since udelay is used
- *            (see Documentation/timers/timers-howto.rst).
+ * @delay_us: Time to udelay between reads in us (0 tight-loops). Please
+ *            read udelay() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  *
- * Returns 0 on success and -ETIMEDOUT upon a timeout or the regmap_read
- * error return value in case of a error read. In the two former cases,
- * the last read value at @addr is stored in @val.
- *
  * This is modelled after the readx_poll_timeout_atomic macros in linux/iopo=
ll.h.
  *
  * Note: In general regmap cannot be used in atomic context. If you want to =
use
  * this macro then first setup your regmap for atomic use (flat or no cache
  * and MMIO regmap).
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout or the regmap_read
+ * error return value in case of a error read. In the two former cases,
+ * the last read value at @addr is stored in @val.
  */
 #define regmap_read_poll_timeout_atomic(map, addr, val, cond, delay_us, time=
out_us) \
 ({ \
@@ -177,17 +177,17 @@ struct reg_sequence {
  * @field: Regmap field to read from
  * @val: Unsigned integer variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @sleep_us: Maximum time to sleep between reads in us (0
- *            tight-loops).  Should be less than ~20ms since usleep_range
- *            is used (see Documentation/timers/timers-howto.rst).
+ * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Ple=
ase
+ *            read usleep_range() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  *
- * Returns 0 on success and -ETIMEDOUT upon a timeout or the regmap_field_re=
ad
+ * This is modelled after the readx_poll_timeout macros in linux/iopoll.h.
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout or the regmap_field_r=
ead
  * error return value in case of a error read. In the two former cases,
  * the last read value at @addr is stored in @val. Must not be called
  * from atomic context if sleep_us or timeout_us are used.
- *
- * This is modelled after the readx_poll_timeout macros in linux/iopoll.h.
  */
 #define regmap_field_read_poll_timeout(field, val, cond, sleep_us, timeout_u=
s) \
 ({ \
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index c8ed09ac29ac..d5d03d919df8 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -138,6 +138,7 @@ struct signal_struct {
 	/* POSIX.1b Interval Timers */
 	unsigned int		next_posix_timer_id;
 	struct hlist_head	posix_timers;
+	struct hlist_head	ignored_posix_timers;
=20
 	/* ITIMER_REAL timer for the process */
 	struct hrtimer real_timer;
@@ -338,9 +339,6 @@ extern void force_fatal_sig(int);
 extern void force_exit_sig(int);
 extern int send_sig(int, struct task_struct *, int);
 extern int zap_other_threads(struct task_struct *p);
-extern struct sigqueue *sigqueue_alloc(void);
-extern void sigqueue_free(struct sigqueue *);
-extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type);
 extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
=20
 static inline void clear_notify_signal(void)
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 72744638c5b0..b0c74bfe0600 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -20,12 +20,10 @@ extern void __init tick_init(void);
 extern void tick_suspend_local(void);
 /* Should be core only, but XEN resume magic and ARM BL switcher require it =
*/
 extern void tick_resume_local(void);
-extern void tick_cleanup_dead_cpu(int cpu);
 #else /* CONFIG_GENERIC_CLOCKEVENTS */
 static inline void tick_init(void) { }
 static inline void tick_suspend_local(void) { }
 static inline void tick_resume_local(void) { }
-static inline void tick_cleanup_dead_cpu(int cpu) { }
 #endif /* !CONFIG_GENERIC_CLOCKEVENTS */
=20
 #if defined(CONFIG_GENERIC_CLOCKEVENTS) && defined(CONFIG_HOTPLUG_CPU)
diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_i=
nternal.h
index 902c20ef495a..e39d4d563b19 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -26,7 +26,7 @@
  * occupies a single 64byte cache line.
  *
  * The struct is separate from struct timekeeper as it is also used
- * for a fast NMI safe accessors.
+ * for the fast NMI safe accessors.
  *
  * @base_real is for the fast NMI safe accessor to allow reading clock
  * realtime from any context.
@@ -44,33 +44,38 @@ struct tk_read_base {
=20
 /**
  * struct timekeeper - Structure holding internal timekeeping values.
- * @tkr_mono:		The readout base structure for CLOCK_MONOTONIC
- * @tkr_raw:		The readout base structure for CLOCK_MONOTONIC_RAW
- * @xtime_sec:		Current CLOCK_REALTIME time in seconds
- * @ktime_sec:		Current CLOCK_MONOTONIC time in seconds
- * @wall_to_monotonic:	CLOCK_REALTIME to CLOCK_MONOTONIC offset
- * @offs_real:		Offset clock monotonic -> clock realtime
- * @offs_boot:		Offset clock monotonic -> clock boottime
- * @offs_tai:		Offset clock monotonic -> clock tai
- * @tai_offset:		The current UTC to TAI offset in seconds
- * @clock_was_set_seq:	The sequence number of clock was set events
- * @cs_was_changed_seq:	The sequence number of clocksource change events
- * @next_leap_ktime:	CLOCK_MONOTONIC time value of a pending leap-second
- * @raw_sec:		CLOCK_MONOTONIC_RAW  time in seconds
- * @monotonic_to_boot:	CLOCK_MONOTONIC to CLOCK_BOOTTIME offset
- * @cycle_interval:	Number of clock cycles in one NTP interval
- * @xtime_interval:	Number of clock shifted nano seconds in one NTP
- *			interval.
- * @xtime_remainder:	Shifted nano seconds left over when rounding
- *			@cycle_interval
- * @raw_interval:	Shifted raw nano seconds accumulated per NTP interval.
- * @ntp_error:		Difference between accumulated time and NTP time in ntp
- *			shifted nano seconds.
- * @ntp_error_shift:	Shift conversion between clock shifted nano seconds and
- *			ntp shifted nano seconds.
- * @last_warning:	Warning ratelimiter (DEBUG_TIMEKEEPING)
- * @underflow_seen:	Underflow warning flag (DEBUG_TIMEKEEPING)
- * @overflow_seen:	Overflow warning flag (DEBUG_TIMEKEEPING)
+ * @tkr_mono:			The readout base structure for CLOCK_MONOTONIC
+ * @xtime_sec:			Current CLOCK_REALTIME time in seconds
+ * @ktime_sec:			Current CLOCK_MONOTONIC time in seconds
+ * @wall_to_monotonic:		CLOCK_REALTIME to CLOCK_MONOTONIC offset
+ * @offs_real:			Offset clock monotonic -> clock realtime
+ * @offs_boot:			Offset clock monotonic -> clock boottime
+ * @offs_tai:			Offset clock monotonic -> clock tai
+ * @tai_offset:			The current UTC to TAI offset in seconds
+ * @tkr_raw:			The readout base structure for CLOCK_MONOTONIC_RAW
+ * @raw_sec:			CLOCK_MONOTONIC_RAW  time in seconds
+ * @clock_was_set_seq:		The sequence number of clock was set events
+ * @cs_was_changed_seq:		The sequence number of clocksource change events
+ * @monotonic_to_boot:		CLOCK_MONOTONIC to CLOCK_BOOTTIME offset
+ * @cycle_interval:		Number of clock cycles in one NTP interval
+ * @xtime_interval:		Number of clock shifted nano seconds in one NTP
+ *				interval.
+ * @xtime_remainder:		Shifted nano seconds left over when rounding
+ *				@cycle_interval
+ * @raw_interval:		Shifted raw nano seconds accumulated per NTP interval.
+ * @next_leap_ktime:		CLOCK_MONOTONIC time value of a pending leap-second
+ * @ntp_tick:			The ntp_tick_length() value currently being
+ *				used. This cached copy ensures we consistently
+ *				apply the tick length for an entire tick, as
+ *				ntp_tick_length may change mid-tick, and we don't
+ *				want to apply that new value to the tick in
+ *				progress.
+ * @ntp_error:			Difference between accumulated time and NTP time in ntp
+ *				shifted nano seconds.
+ * @ntp_error_shift:		Shift conversion between clock shifted nano seconds and
+ *				ntp shifted nano seconds.
+ * @ntp_err_mult:		Multiplication factor for scaled math conversion
+ * @skip_second_overflow:	Flag used to avoid updating NTP twice with same se=
cond
  *
  * Note: For timespec(64) based interfaces wall_to_monotonic is what
  * we need to add to xtime (or xtime corrected for sub jiffy times)
@@ -88,10 +93,28 @@ struct tk_read_base {
  *
  * @monotonic_to_boottime is a timespec64 representation of @offs_boot to
  * accelerate the VDSO update for CLOCK_BOOTTIME.
+ *
+ * The cacheline ordering of the structure is optimized for in kernel usage =
of
+ * the ktime_get() and ktime_get_ts64() family of time accessors. Struct
+ * timekeeper is prepended in the core timekeeping code with a sequence coun=
t,
+ * which results in the following cacheline layout:
+ *
+ * 0:	seqcount, tkr_mono
+ * 1:	xtime_sec ... tai_offset
+ * 2:	tkr_raw, raw_sec
+ * 3,4: Internal variables
+ *
+ * Cacheline 0,1 contain the data which is used for accessing
+ * CLOCK_MONOTONIC/REALTIME/BOOTTIME/TAI, while cacheline 2 contains the
+ * data for accessing CLOCK_MONOTONIC_RAW.  Cacheline 3,4 are internal
+ * variables which are only accessed during timekeeper updates once per
+ * tick.
  */
 struct timekeeper {
+	/* Cacheline 0 (together with prepended seqcount of timekeeper core): */
 	struct tk_read_base	tkr_mono;
-	struct tk_read_base	tkr_raw;
+
+	/* Cacheline 1: */
 	u64			xtime_sec;
 	unsigned long		ktime_sec;
 	struct timespec64	wall_to_monotonic;
@@ -99,43 +122,28 @@ struct timekeeper {
 	ktime_t			offs_boot;
 	ktime_t			offs_tai;
 	s32			tai_offset;
+
+	/* Cacheline 2: */
+	struct tk_read_base	tkr_raw;
+	u64			raw_sec;
+
+	/* Cachline 3 and 4 (timekeeping internal variables): */
 	unsigned int		clock_was_set_seq;
 	u8			cs_was_changed_seq;
-	ktime_t			next_leap_ktime;
-	u64			raw_sec;
+
 	struct timespec64	monotonic_to_boot;
=20
-	/* The following members are for timekeeping internal use */
 	u64			cycle_interval;
 	u64			xtime_interval;
 	s64			xtime_remainder;
 	u64			raw_interval;
-	/* The ntp_tick_length() value currently being used.
-	 * This cached copy ensures we consistently apply the tick
-	 * length for an entire tick, as ntp_tick_length may change
-	 * mid-tick, and we don't want to apply that new value to
-	 * the tick in progress.
-	 */
+
+	ktime_t			next_leap_ktime;
 	u64			ntp_tick;
-	/* Difference between accumulated time and NTP time in ntp
-	 * shifted nano seconds. */
 	s64			ntp_error;
 	u32			ntp_error_shift;
 	u32			ntp_err_mult;
-	/* Flag used to avoid updating NTP twice with same second */
 	u32			skip_second_overflow;
-#ifdef CONFIG_DEBUG_TIMEKEEPING
-	long			last_warning;
-	/*
-	 * These simple flag variables are managed
-	 * without locks, which is racy, but they are
-	 * ok since we don't really care about being
-	 * super precise about how many events were
-	 * seen, just that a problem was observed.
-	 */
-	int			underflow_seen;
-	int			overflow_seen;
-#endif
 };
=20
 #ifdef CONFIG_GENERIC_TIME_VSYSCALL
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index fc12a9ba2c88..0e035f675efe 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -45,6 +45,11 @@ extern void ktime_get_real_ts64(struct timespec64 *tv);
 extern void ktime_get_coarse_ts64(struct timespec64 *ts);
 extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
=20
+/* Multigrain timestamp interfaces */
+extern void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts);
+extern void ktime_get_real_ts64_mg(struct timespec64 *ts);
+extern unsigned long timekeeping_get_mg_floor_swaps(void);
+
 void getboottime64(struct timespec64 *ts);
=20
 /*
@@ -275,6 +280,7 @@ struct ktime_timestamps {
  *				 counter value
  * @cycles:	Clocksource counter value to produce the system times
  * @real:	Realtime system time
+ * @boot:	Boot time
  * @raw:	Monotonic raw system time
  * @cs_id:	Clocksource ID
  * @clock_was_set_seq:	The sequence number of clock-was-set events
@@ -283,6 +289,7 @@ struct ktime_timestamps {
 struct system_time_snapshot {
 	u64			cycles;
 	ktime_t			real;
+	ktime_t			boot;
 	ktime_t			raw;
 	enum clocksource_ids	cs_id;
 	unsigned int		clock_was_set_seq;
diff --git a/include/linux/timex.h b/include/linux/timex.h
index 3871b06bd302..4ee32eff3f22 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -139,14 +139,6 @@ unsigned long random_get_entropy_fallback(void);
 #define MAXSEC 2048		/* max interval between updates (s) */
 #define NTP_PHASE_LIMIT ((MAXPHASE / NSEC_PER_USEC) << 5) /* beyond max. dis=
persion */
=20
-/*
- * kernel variables
- * Note: maximum error =3D NTP sync distance =3D dispersion + delay / 2;
- * estimated error =3D NTP dispersion.
- */
-extern unsigned long tick_usec;		/* USER_HZ period (usec) */
-extern unsigned long tick_nsec;		/* SHIFTED_HZ period (nsec) */
-
 /* Required to safely shift negative values */
 #define shift_right(x, s) ({	\
 	__typeof__(x) __x =3D (x);	\
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 8aa3372f21a0..643b7c7bf376 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -541,8 +541,8 @@ do {										\
 	int __ret =3D 0;								\
 	struct hrtimer_sleeper __t;						\
 										\
-	hrtimer_init_sleeper_on_stack(&__t, CLOCK_MONOTONIC,			\
-				      HRTIMER_MODE_REL);			\
+	hrtimer_setup_sleeper_on_stack(&__t, CLOCK_MONOTONIC,			\
+				       HRTIMER_MODE_REL);			\
 	if ((timeout) !=3D KTIME_MAX) {						\
 		hrtimer_set_expires_range_ns(&__t.timer, timeout,		\
 					current->timer_slack_ns);		\
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/si=
ginfo.h
index b7bc545ec3b2..5a1ca43b5fc6 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -46,7 +46,7 @@ union __sifields {
 		__kernel_timer_t _tid;	/* timer id */
 		int _overrun;		/* overrun count */
 		sigval_t _sigval;	/* same as below */
-		int _sys_private;       /* not to be passed to user */
+		int _sys_private;       /* Not used by the kernel. Historic leftover. Alwa=
ys 0. */
 	} _timer;
=20
 	/* POSIX.1b signals */
diff --git a/init/init_task.c b/init/init_task.c
index 136a8231355a..e557f622bd90 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -30,8 +30,9 @@ static struct signal_struct init_signals =3D {
 	.cred_guard_mutex =3D __MUTEX_INITIALIZER(init_signals.cred_guard_mutex),
 	.exec_update_lock =3D __RWSEM_INITIALIZER(init_signals.exec_update_lock),
 #ifdef CONFIG_POSIX_TIMERS
-	.posix_timers	=3D HLIST_HEAD_INIT,
-	.cputimer	=3D {
+	.posix_timers		=3D HLIST_HEAD_INIT,
+	.ignored_posix_timers	=3D HLIST_HEAD_INIT,
+	.cputimer		=3D {
 		.cputime_atomic	=3D INIT_CPUTIME_ATOMIC,
 	},
 #endif
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index feb61d68dca6..0842aa3f60e7 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2435,13 +2435,14 @@ static int io_cqring_schedule_timeout(struct io_wait_=
queue *iowq,
 {
 	ktime_t timeout;
=20
-	hrtimer_init_on_stack(&iowq->t, clock_id, HRTIMER_MODE_ABS);
 	if (iowq->min_timeout) {
 		timeout =3D ktime_add_ns(iowq->min_timeout, start_time);
-		iowq->t.function =3D io_cqring_min_timer_wakeup;
+		hrtimer_setup_on_stack(&iowq->t, io_cqring_min_timer_wakeup, clock_id,
+				       HRTIMER_MODE_ABS);
 	} else {
 		timeout =3D iowq->timeout;
-		iowq->t.function =3D io_cqring_timer_wakeup;
+		hrtimer_setup_on_stack(&iowq->t, io_cqring_timer_wakeup, clock_id,
+				       HRTIMER_MODE_ABS);
 	}
=20
 	hrtimer_set_expires_range_ns(&iowq->t, timeout, 0);
diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index 9973876d91b0..2ffe5e1dc68a 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -76,7 +76,6 @@ static void io_timeout_complete(struct io_kiocb *req, struc=
t io_tw_state *ts)
 			/* re-arm timer */
 			spin_lock_irq(&ctx->timeout_lock);
 			list_add(&timeout->list, ctx->timeout_list.prev);
-			data->timer.function =3D io_timeout_fn;
 			hrtimer_start(&data->timer, timespec64_to_ktime(data->ts), data->mode);
 			spin_unlock_irq(&ctx->timeout_lock);
 			return;
diff --git a/kernel/cpu.c b/kernel/cpu.c
index d293d52a3e00..895f3287e3f3 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1338,8 +1338,6 @@ static int takedown_cpu(unsigned int cpu)
=20
 	cpuhp_bp_sync_dead(cpu);
=20
-	tick_cleanup_dead_cpu(cpu);
-
 	/*
 	 * Callbacks must be re-integrated right away to the RCU state machine.
 	 * Otherwise an RCU callback could block a further teardown function
diff --git a/kernel/fork.c b/kernel/fork.c
index 60c0b4868fd4..c2bd8367a850 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1864,6 +1864,7 @@ static int copy_signal(unsigned long clone_flags, struc=
t task_struct *tsk)
=20
 #ifdef CONFIG_POSIX_TIMERS
 	INIT_HLIST_HEAD(&sig->posix_timers);
+	INIT_HLIST_HEAD(&sig->ignored_posix_timers);
 	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	sig->real_timer.function =3D it_real_fn;
 #endif
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 136768ae2637..fb7214c7a36f 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -140,9 +140,9 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *=
timeout,
 	if (!time)
 		return NULL;
=20
-	hrtimer_init_sleeper_on_stack(timeout, (flags & FLAGS_CLOCKRT) ?
-				      CLOCK_REALTIME : CLOCK_MONOTONIC,
-				      HRTIMER_MODE_ABS);
+	hrtimer_setup_sleeper_on_stack(timeout,
+				       (flags & FLAGS_CLOCKRT) ? CLOCK_REALTIME : CLOCK_MONOTONIC,
+				       HRTIMER_MODE_ABS);
 	/*
 	 * If range_ns is 0, calling hrtimer_set_expires_range_ns() is
 	 * effectively the same as calling hrtimer_set_expires().
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index d2f096bb274c..631e42802925 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -399,8 +399,8 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
 	cpuidle_use_deepest_state(latency_ns);
=20
 	it.done =3D 0;
-	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	it.timer.function =3D idle_inject_timer_fn;
+	hrtimer_setup_on_stack(&it.timer, idle_inject_timer_fn, CLOCK_MONOTONIC,
+			       HRTIMER_MODE_REL_HARD);
 	hrtimer_start(&it.timer, ns_to_ktime(duration_ns),
 		      HRTIMER_MODE_REL_PINNED_HARD);
=20
diff --git a/kernel/signal.c b/kernel/signal.c
index 4344860ffcac..10b464b9d91f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -59,6 +59,8 @@
 #include <asm/cacheflush.h>
 #include <asm/syscall.h>	/* for syscall_get_* */
=20
+#include "time/posix-timers.h"
+
 /*
  * SLAB caches for signal bits.
  */
@@ -396,16 +398,9 @@ void task_join_group_stop(struct task_struct *task)
 	task_set_jobctl_pending(task, mask | JOBCTL_STOP_PENDING);
 }
=20
-/*
- * allocate a new signal queue record
- * - this may be called without locks if and only if t =3D=3D current, other=
wise an
- *   appropriate lock must be held to stop the target task from exiting
- */
-static struct sigqueue *
-__sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
-		 int override_rlimit, const unsigned int sigqueue_flags)
+static struct ucounts *sig_get_ucounts(struct task_struct *t, int sig,
+				       int override_rlimit)
 {
-	struct sigqueue *q =3D NULL;
 	struct ucounts *ucounts;
 	long sigpending;
=20
@@ -424,26 +419,53 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t =
gfp_flags,
 	if (!sigpending)
 		return NULL;
=20
-	if (override_rlimit || likely(sigpending <=3D task_rlimit(t, RLIMIT_SIGPEND=
ING))) {
-		q =3D kmem_cache_alloc(sigqueue_cachep, gfp_flags);
-	} else {
+	if (unlikely(!override_rlimit && sigpending > task_rlimit(t, RLIMIT_SIGPEND=
ING))) {
+		dec_rlimit_put_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING);
 		print_dropped_signal(sig);
+		return NULL;
 	}
=20
-	if (unlikely(q =3D=3D NULL)) {
+	return ucounts;
+}
+
+static void __sigqueue_init(struct sigqueue *q, struct ucounts *ucounts,
+			    const unsigned int sigqueue_flags)
+{
+	INIT_LIST_HEAD(&q->list);
+	q->flags =3D sigqueue_flags;
+	q->ucounts =3D ucounts;
+}
+
+/*
+ * allocate a new signal queue record
+ * - this may be called without locks if and only if t =3D=3D current, other=
wise an
+ *   appropriate lock must be held to stop the target task from exiting
+ */
+static struct sigqueue *sigqueue_alloc(int sig, struct task_struct *t, gfp_t=
 gfp_flags,
+				       int override_rlimit)
+{
+	struct ucounts *ucounts =3D sig_get_ucounts(t, sig, override_rlimit);
+	struct sigqueue *q;
+
+	if (!ucounts)
+		return NULL;
+
+	q =3D kmem_cache_alloc(sigqueue_cachep, gfp_flags);
+	if (!q) {
 		dec_rlimit_put_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING);
-	} else {
-		INIT_LIST_HEAD(&q->list);
-		q->flags =3D sigqueue_flags;
-		q->ucounts =3D ucounts;
+		return NULL;
 	}
+
+	__sigqueue_init(q, ucounts, 0);
 	return q;
 }
=20
 static void __sigqueue_free(struct sigqueue *q)
 {
-	if (q->flags & SIGQUEUE_PREALLOC)
+	if (q->flags & SIGQUEUE_PREALLOC) {
+		posixtimer_sigqueue_putref(q);
 		return;
+	}
 	if (q->ucounts) {
 		dec_rlimit_put_ucounts(q->ucounts, UCOUNT_RLIMIT_SIGPENDING);
 		q->ucounts =3D NULL;
@@ -478,42 +500,6 @@ void flush_signals(struct task_struct *t)
 }
 EXPORT_SYMBOL(flush_signals);
=20
-#ifdef CONFIG_POSIX_TIMERS
-static void __flush_itimer_signals(struct sigpending *pending)
-{
-	sigset_t signal, retain;
-	struct sigqueue *q, *n;
-
-	signal =3D pending->signal;
-	sigemptyset(&retain);
-
-	list_for_each_entry_safe(q, n, &pending->list, list) {
-		int sig =3D q->info.si_signo;
-
-		if (likely(q->info.si_code !=3D SI_TIMER)) {
-			sigaddset(&retain, sig);
-		} else {
-			sigdelset(&signal, sig);
-			list_del_init(&q->list);
-			__sigqueue_free(q);
-		}
-	}
-
-	sigorsets(&pending->signal, &signal, &retain);
-}
-
-void flush_itimer_signals(void)
-{
-	struct task_struct *tsk =3D current;
-	unsigned long flags;
-
-	spin_lock_irqsave(&tsk->sighand->siglock, flags);
-	__flush_itimer_signals(&tsk->pending);
-	__flush_itimer_signals(&tsk->signal->shared_pending);
-	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
-}
-#endif
-
 void ignore_signals(struct task_struct *t)
 {
 	int i;
@@ -563,7 +549,7 @@ bool unhandled_signal(struct task_struct *tsk, int sig)
 }
=20
 static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_=
t *info,
-			   bool *resched_timer)
+			   struct sigqueue **timer_sigq)
 {
 	struct sigqueue *q, *first =3D NULL;
=20
@@ -586,12 +572,17 @@ static void collect_signal(int sig, struct sigpending *=
list, kernel_siginfo_t *i
 		list_del_init(&first->list);
 		copy_siginfo(info, &first->info);
=20
-		*resched_timer =3D
-			(first->flags & SIGQUEUE_PREALLOC) &&
-			(info->si_code =3D=3D SI_TIMER) &&
-			(info->si_sys_private);
-
-		__sigqueue_free(first);
+		/*
+		 * posix-timer signals are preallocated and freed when the last
+		 * reference count is dropped in posixtimer_deliver_signal() or
+		 * immediately on timer deletion when the signal is not pending.
+		 * Spare the extra round through __sigqueue_free() which is
+		 * ignoring preallocated signals.
+		 */
+		if (unlikely((first->flags & SIGQUEUE_PREALLOC) && (info->si_code =3D=3D S=
I_TIMER)))
+			*timer_sigq =3D first;
+		else
+			__sigqueue_free(first);
 	} else {
 		/*
 		 * Ok, it wasn't in the queue.  This must be
@@ -608,12 +599,12 @@ static void collect_signal(int sig, struct sigpending *=
list, kernel_siginfo_t *i
 }
=20
 static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
-			kernel_siginfo_t *info, bool *resched_timer)
+			    kernel_siginfo_t *info, struct sigqueue **timer_sigq)
 {
 	int sig =3D next_signal(pending, mask);
=20
 	if (sig)
-		collect_signal(sig, pending, info, resched_timer);
+		collect_signal(sig, pending, info, timer_sigq);
 	return sig;
 }
=20
@@ -625,42 +616,22 @@ static int __dequeue_signal(struct sigpending *pending,=
 sigset_t *mask,
 int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *ty=
pe)
 {
 	struct task_struct *tsk =3D current;
-	bool resched_timer =3D false;
+	struct sigqueue *timer_sigq;
 	int signr;
=20
 	lockdep_assert_held(&tsk->sighand->siglock);
=20
+again:
 	*type =3D PIDTYPE_PID;
-	signr =3D __dequeue_signal(&tsk->pending, mask, info, &resched_timer);
+	timer_sigq =3D NULL;
+	signr =3D __dequeue_signal(&tsk->pending, mask, info, &timer_sigq);
 	if (!signr) {
 		*type =3D PIDTYPE_TGID;
 		signr =3D __dequeue_signal(&tsk->signal->shared_pending,
-					 mask, info, &resched_timer);
-#ifdef CONFIG_POSIX_TIMERS
-		/*
-		 * itimer signal ?
-		 *
-		 * itimers are process shared and we restart periodic
-		 * itimers in the signal delivery path to prevent DoS
-		 * attacks in the high resolution timer case. This is
-		 * compliant with the old way of self-restarting
-		 * itimers, as the SIGALRM is a legacy signal and only
-		 * queued once. Changing the restart behaviour to
-		 * restart the timer in the signal dequeue path is
-		 * reducing the timer noise on heavy loaded !highres
-		 * systems too.
-		 */
-		if (unlikely(signr =3D=3D SIGALRM)) {
-			struct hrtimer *tmr =3D &tsk->signal->real_timer;
-
-			if (!hrtimer_is_queued(tmr) &&
-			    tsk->signal->it_real_incr !=3D 0) {
-				hrtimer_forward(tmr, tmr->base->get_time(),
-						tsk->signal->it_real_incr);
-				hrtimer_restart(tmr);
-			}
-		}
-#endif
+					 mask, info, &timer_sigq);
+
+		if (unlikely(signr =3D=3D SIGALRM))
+			posixtimer_rearm_itimer(tsk);
 	}
=20
 	recalc_sigpending();
@@ -682,22 +653,12 @@ int dequeue_signal(sigset_t *mask, kernel_siginfo_t *in=
fo, enum pid_type *type)
 		 */
 		current->jobctl |=3D JOBCTL_STOP_DEQUEUED;
 	}
-#ifdef CONFIG_POSIX_TIMERS
-	if (resched_timer) {
-		/*
-		 * Release the siglock to ensure proper locking order
-		 * of timer locks outside of siglocks.  Note, we leave
-		 * irqs disabled here, since the posix-timers code is
-		 * about to disable them again anyway.
-		 */
-		spin_unlock(&tsk->sighand->siglock);
-		posixtimer_rearm(info);
-		spin_lock(&tsk->sighand->siglock);
=20
-		/* Don't expose the si_sys_private value to userspace */
-		info->si_sys_private =3D 0;
+	if (IS_ENABLED(CONFIG_POSIX_TIMERS) && unlikely(timer_sigq)) {
+		if (!posixtimer_deliver_signal(info, timer_sigq))
+			goto again;
 	}
-#endif
+
 	return signr;
 }
 EXPORT_SYMBOL_GPL(dequeue_signal);
@@ -772,17 +733,24 @@ void signal_wake_up_state(struct task_struct *t, unsign=
ed int state)
 		kick_process(t);
 }
=20
-/*
- * Remove signals in mask from the pending set and queue.
- * Returns 1 if any signals were found.
- *
- * All callers must be holding the siglock.
- */
-static void flush_sigqueue_mask(sigset_t *mask, struct sigpending *s)
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sig=
queue *q);
+
+static void sigqueue_free_ignored(struct task_struct *tsk, struct sigqueue *=
q)
+{
+	if (likely(!(q->flags & SIGQUEUE_PREALLOC) || q->info.si_code !=3D SI_TIMER=
))
+		__sigqueue_free(q);
+	else
+		posixtimer_sig_ignore(tsk, q);
+}
+
+/* Remove signals in mask from the pending set and queue. */
+static void flush_sigqueue_mask(struct task_struct *p, sigset_t *mask, struc=
t sigpending *s)
 {
 	struct sigqueue *q, *n;
 	sigset_t m;
=20
+	lockdep_assert_held(&p->sighand->siglock);
+
 	sigandsets(&m, mask, &s->signal);
 	if (sigisemptyset(&m))
 		return;
@@ -791,7 +759,7 @@ static void flush_sigqueue_mask(sigset_t *mask, struct si=
gpending *s)
 	list_for_each_entry_safe(q, n, &s->list, list) {
 		if (sigismember(mask, q->info.si_signo)) {
 			list_del_init(&q->list);
-			__sigqueue_free(q);
+			sigqueue_free_ignored(p, q);
 		}
 	}
 }
@@ -916,18 +884,18 @@ static bool prepare_signal(int sig, struct task_struct =
*p, bool force)
 		 * This is a stop signal.  Remove SIGCONT from all queues.
 		 */
 		siginitset(&flush, sigmask(SIGCONT));
-		flush_sigqueue_mask(&flush, &signal->shared_pending);
+		flush_sigqueue_mask(p, &flush, &signal->shared_pending);
 		for_each_thread(p, t)
-			flush_sigqueue_mask(&flush, &t->pending);
+			flush_sigqueue_mask(p, &flush, &t->pending);
 	} else if (sig =3D=3D SIGCONT) {
 		unsigned int why;
 		/*
 		 * Remove all stop signals from all queues, wake all threads.
 		 */
 		siginitset(&flush, SIG_KERNEL_STOP_MASK);
-		flush_sigqueue_mask(&flush, &signal->shared_pending);
+		flush_sigqueue_mask(p, &flush, &signal->shared_pending);
 		for_each_thread(p, t) {
-			flush_sigqueue_mask(&flush, &t->pending);
+			flush_sigqueue_mask(p, &flush, &t->pending);
 			task_clear_jobctl_pending(t, JOBCTL_STOP_PENDING);
 			if (likely(!(t->ptrace & PT_SEIZED))) {
 				t->jobctl &=3D ~JOBCTL_STOPPED;
@@ -1114,7 +1082,7 @@ static int __send_signal_locked(int sig, struct kernel_=
siginfo *info,
 	else
 		override_rlimit =3D 0;
=20
-	q =3D __sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit, 0);
+	q =3D sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit);
=20
 	if (q) {
 		list_add_tail(&q->list, &pending->list);
@@ -1922,112 +1890,242 @@ int kill_pid(struct pid *pid, int sig, int priv)
 }
 EXPORT_SYMBOL(kill_pid);
=20
+#ifdef CONFIG_POSIX_TIMERS
 /*
- * These functions support sending signals using preallocated sigqueue
- * structures.  This is needed "because realtime applications cannot
- * afford to lose notifications of asynchronous events, like timer
- * expirations or I/O completions".  In the case of POSIX Timers
- * we allocate the sigqueue structure from the timer_create.  If this
- * allocation fails we are able to report the failure to the application
- * with an EAGAIN error.
+ * These functions handle POSIX timer signals. POSIX timers use
+ * preallocated sigqueue structs for sending signals.
  */
-struct sigqueue *sigqueue_alloc(void)
+static void __flush_itimer_signals(struct sigpending *pending)
 {
-	return __sigqueue_alloc(-1, current, GFP_KERNEL, 0, SIGQUEUE_PREALLOC);
+	sigset_t signal, retain;
+	struct sigqueue *q, *n;
+
+	signal =3D pending->signal;
+	sigemptyset(&retain);
+
+	list_for_each_entry_safe(q, n, &pending->list, list) {
+		int sig =3D q->info.si_signo;
+
+		if (likely(q->info.si_code !=3D SI_TIMER)) {
+			sigaddset(&retain, sig);
+		} else {
+			sigdelset(&signal, sig);
+			list_del_init(&q->list);
+			__sigqueue_free(q);
+		}
+	}
+
+	sigorsets(&pending->signal, &signal, &retain);
 }
=20
-void sigqueue_free(struct sigqueue *q)
+void flush_itimer_signals(void)
 {
-	spinlock_t *lock =3D &current->sighand->siglock;
-	unsigned long flags;
+	struct task_struct *tsk =3D current;
=20
-	if (WARN_ON_ONCE(!(q->flags & SIGQUEUE_PREALLOC)))
-		return;
-	/*
-	 * We must hold ->siglock while testing q->list
-	 * to serialize with collect_signal() or with
-	 * __exit_signal()->flush_sigqueue().
-	 */
-	spin_lock_irqsave(lock, flags);
-	q->flags &=3D ~SIGQUEUE_PREALLOC;
-	/*
-	 * If it is queued it will be freed when dequeued,
-	 * like the "regular" sigqueue.
-	 */
-	if (!list_empty(&q->list))
-		q =3D NULL;
-	spin_unlock_irqrestore(lock, flags);
+	guard(spinlock_irqsave)(&tsk->sighand->siglock);
+	__flush_itimer_signals(&tsk->pending);
+	__flush_itimer_signals(&tsk->signal->shared_pending);
+}
=20
-	if (q)
-		__sigqueue_free(q);
+bool posixtimer_init_sigqueue(struct sigqueue *q)
+{
+	struct ucounts *ucounts =3D sig_get_ucounts(current, -1, 0);
+
+	if (!ucounts)
+		return false;
+	clear_siginfo(&q->info);
+	__sigqueue_init(q, ucounts, SIGQUEUE_PREALLOC);
+	return true;
 }
=20
-int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
+static void posixtimer_queue_sigqueue(struct sigqueue *q, struct task_struct=
 *t, enum pid_type type)
 {
-	int sig =3D q->info.si_signo;
 	struct sigpending *pending;
+	int sig =3D q->info.si_signo;
+
+	signalfd_notify(t, sig);
+	pending =3D (type !=3D PIDTYPE_PID) ? &t->signal->shared_pending : &t->pend=
ing;
+	list_add_tail(&q->list, &pending->list);
+	sigaddset(&pending->signal, sig);
+	complete_signal(sig, t, type);
+}
+
+/*
+ * This function is used by POSIX timers to deliver a timer signal.
+ * Where type is PIDTYPE_PID (such as for timers with SIGEV_THREAD_ID
+ * set), the signal must be delivered to the specific thread (queues
+ * into t->pending).
+ *
+ * Where type is not PIDTYPE_PID, signals must be delivered to the
+ * process. In this case, prefer to deliver to current if it is in
+ * the same thread group as the target process, which avoids
+ * unnecessarily waking up a potentially idle task.
+ */
+static inline struct task_struct *posixtimer_get_target(struct k_itimer *tmr)
+{
+	struct task_struct *t =3D pid_task(tmr->it_pid, tmr->it_pid_type);
+
+	if (t && tmr->it_pid_type !=3D PIDTYPE_PID && same_thread_group(t, current))
+		t =3D current;
+	return t;
+}
+
+void posixtimer_send_sigqueue(struct k_itimer *tmr)
+{
+	struct sigqueue *q =3D &tmr->sigq;
+	int sig =3D q->info.si_signo;
 	struct task_struct *t;
 	unsigned long flags;
-	int ret, result;
+	int result;
=20
-	if (WARN_ON_ONCE(!(q->flags & SIGQUEUE_PREALLOC)))
-		return 0;
-	if (WARN_ON_ONCE(q->info.si_code !=3D SI_TIMER))
-		return 0;
+	guard(rcu)();
=20
-	ret =3D -1;
-	rcu_read_lock();
+	t =3D posixtimer_get_target(tmr);
+	if (!t)
+		return;
+
+	if (!likely(lock_task_sighand(t, &flags)))
+		return;
=20
 	/*
-	 * This function is used by POSIX timers to deliver a timer signal.
-	 * Where type is PIDTYPE_PID (such as for timers with SIGEV_THREAD_ID
-	 * set), the signal must be delivered to the specific thread (queues
-	 * into t->pending).
-	 *
-	 * Where type is not PIDTYPE_PID, signals must be delivered to the
-	 * process. In this case, prefer to deliver to current if it is in
-	 * the same thread group as the target process, which avoids
-	 * unnecessarily waking up a potentially idle task.
+	 * Update @tmr::sigqueue_seq for posix timer signals with sighand
+	 * locked to prevent a race against dequeue_signal().
 	 */
-	t =3D pid_task(pid, type);
-	if (!t)
-		goto ret;
-	if (type !=3D PIDTYPE_PID && same_thread_group(t, current))
-		t =3D current;
-	if (!likely(lock_task_sighand(t, &flags)))
-		goto ret;
+	tmr->it_sigqueue_seq =3D tmr->it_signal_seq;
=20
-	ret =3D 1; /* the signal is ignored */
-	result =3D TRACE_SIGNAL_IGNORED;
-	if (!prepare_signal(sig, t, false))
+	/*
+	 * Set the signal delivery status under sighand lock, so that the
+	 * ignored signal handling can distinguish between a periodic and a
+	 * non-periodic timer.
+	 */
+	tmr->it_sig_periodic =3D tmr->it_status =3D=3D POSIX_TIMER_REQUEUE_PENDING;
+
+	if (!prepare_signal(sig, t, false)) {
+		result =3D TRACE_SIGNAL_IGNORED;
+
+		if (!list_empty(&q->list)) {
+			/*
+			 * If task group is exiting with the signal already pending,
+			 * wait for __exit_signal() to do its job. Otherwise if
+			 * ignored, it's not supposed to be queued. Try to survive.
+			 */
+			WARN_ON_ONCE(!(t->signal->flags & SIGNAL_GROUP_EXIT));
+			goto out;
+		}
+
+		/* Periodic timers with SIG_IGN are queued on the ignored list */
+		if (tmr->it_sig_periodic) {
+			/*
+			 * Already queued means the timer was rearmed after
+			 * the previous expiry got it on the ignore list.
+			 * Nothing to do for that case.
+			 */
+			if (hlist_unhashed(&tmr->ignored_list)) {
+				/*
+				 * Take a signal reference and queue it on
+				 * the ignored list.
+				 */
+				posixtimer_sigqueue_getref(q);
+				posixtimer_sig_ignore(t, q);
+			}
+		} else if (!hlist_unhashed(&tmr->ignored_list)) {
+			/*
+			 * Covers the case where a timer was periodic and
+			 * then the signal was ignored. Later it was rearmed
+			 * as oneshot timer. The previous signal is invalid
+			 * now, and this oneshot signal has to be dropped.
+			 * Remove it from the ignored list and drop the
+			 * reference count as the signal is not longer
+			 * queued.
+			 */
+			hlist_del_init(&tmr->ignored_list);
+			posixtimer_putref(tmr);
+		}
 		goto out;
+	}
+
+	/* This should never happen and leaks a reference count */
+	if (WARN_ON_ONCE(!hlist_unhashed(&tmr->ignored_list)))
+		hlist_del_init(&tmr->ignored_list);
=20
-	ret =3D 0;
 	if (unlikely(!list_empty(&q->list))) {
-		/*
-		 * If an SI_TIMER entry is already queue just increment
-		 * the overrun count.
-		 */
-		q->info.si_overrun++;
+		/* This holds a reference count already */
 		result =3D TRACE_SIGNAL_ALREADY_PENDING;
 		goto out;
 	}
-	q->info.si_overrun =3D 0;
=20
-	signalfd_notify(t, sig);
-	pending =3D (type !=3D PIDTYPE_PID) ? &t->signal->shared_pending : &t->pend=
ing;
-	list_add_tail(&q->list, &pending->list);
-	sigaddset(&pending->signal, sig);
-	complete_signal(sig, t, type);
+	posixtimer_sigqueue_getref(q);
+	posixtimer_queue_sigqueue(q, t, tmr->it_pid_type);
 	result =3D TRACE_SIGNAL_DELIVERED;
 out:
-	trace_signal_generate(sig, &q->info, t, type !=3D PIDTYPE_PID, result);
+	trace_signal_generate(sig, &q->info, t, tmr->it_pid_type !=3D PIDTYPE_PID, =
result);
 	unlock_task_sighand(t, &flags);
-ret:
-	rcu_read_unlock();
-	return ret;
 }
=20
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sig=
queue *q)
+{
+	struct k_itimer *tmr =3D container_of(q, struct k_itimer, sigq);
+
+	/*
+	 * If the timer is marked deleted already or the signal originates
+	 * from a non-periodic timer, then just drop the reference
+	 * count. Otherwise queue it on the ignored list.
+	 */
+	if (tmr->it_signal && tmr->it_sig_periodic)
+		hlist_add_head(&tmr->ignored_list, &tsk->signal->ignored_posix_timers);
+	else
+		posixtimer_putref(tmr);
+}
+
+static void posixtimer_sig_unignore(struct task_struct *tsk, int sig)
+{
+	struct hlist_head *head =3D &tsk->signal->ignored_posix_timers;
+	struct hlist_node *tmp;
+	struct k_itimer *tmr;
+
+	if (likely(hlist_empty(head)))
+		return;
+
+	/*
+	 * Rearming a timer with sighand lock held is not possible due to
+	 * lock ordering vs. tmr::it_lock. Just stick the sigqueue back and
+	 * let the signal delivery path deal with it whether it needs to be
+	 * rearmed or not. This cannot be decided here w/o dropping sighand
+	 * lock and creating a loop retry horror show.
+	 */
+	hlist_for_each_entry_safe(tmr, tmp , head, ignored_list) {
+		struct task_struct *target;
+
+		/*
+		 * tmr::sigq.info.si_signo is immutable, so accessing it
+		 * without holding tmr::it_lock is safe.
+		 */
+		if (tmr->sigq.info.si_signo !=3D sig)
+			continue;
+
+		hlist_del_init(&tmr->ignored_list);
+
+		/* This should never happen and leaks a reference count */
+		if (WARN_ON_ONCE(!list_empty(&tmr->sigq.list)))
+			continue;
+
+		/*
+		 * Get the target for the signal. If target is a thread and
+		 * has exited by now, drop the reference count.
+		 */
+		guard(rcu)();
+		target =3D posixtimer_get_target(tmr);
+		if (target)
+			posixtimer_queue_sigqueue(&tmr->sigq, target, tmr->it_pid_type);
+		else
+			posixtimer_putref(tmr);
+	}
+}
+#else /* CONFIG_POSIX_TIMERS */
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sig=
queue *q) { }
+static inline void posixtimer_sig_unignore(struct task_struct *tsk, int sig)=
 { }
+#endif /* !CONFIG_POSIX_TIMERS */
+
 void do_notify_pidfd(struct task_struct *task)
 {
 	struct pid *pid =3D task_pid(task);
@@ -4153,8 +4251,8 @@ void kernel_sigaction(int sig, __sighandler_t action)
 		sigemptyset(&mask);
 		sigaddset(&mask, sig);
=20
-		flush_sigqueue_mask(&mask, &current->signal->shared_pending);
-		flush_sigqueue_mask(&mask, &current->pending);
+		flush_sigqueue_mask(current, &mask, &current->signal->shared_pending);
+		flush_sigqueue_mask(current, &mask, &current->pending);
 		recalc_sigpending();
 	}
 	spin_unlock_irq(&current->sighand->siglock);
@@ -4204,6 +4302,8 @@ int do_sigaction(int sig, struct k_sigaction *act, stru=
ct k_sigaction *oact)
 	sigaction_compat_abi(act, oact);
=20
 	if (act) {
+		bool was_ignored =3D k->sa.sa_handler =3D=3D SIG_IGN;
+
 		sigdelsetmask(&act->sa.sa_mask,
 			      sigmask(SIGKILL) | sigmask(SIGSTOP));
 		*k =3D *act;
@@ -4221,9 +4321,11 @@ int do_sigaction(int sig, struct k_sigaction *act, str=
uct k_sigaction *oact)
 		if (sig_handler_ignored(sig_handler(p, sig), sig)) {
 			sigemptyset(&mask);
 			sigaddset(&mask, sig);
-			flush_sigqueue_mask(&mask, &p->signal->shared_pending);
+			flush_sigqueue_mask(p, &mask, &p->signal->shared_pending);
 			for_each_thread(p, t)
-				flush_sigqueue_mask(&mask, &t->pending);
+				flush_sigqueue_mask(p, &mask, &t->pending);
+		} else if (was_ignored) {
+			posixtimer_sig_unignore(p, sig);
 		}
 	}
=20
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 8ebb6d5a106b..b0b97a60aaa6 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -17,11 +17,6 @@ config ARCH_CLOCKSOURCE_DATA
 config ARCH_CLOCKSOURCE_INIT
 	bool
=20
-# Clocksources require validation of the clocksource against the last
-# cycle update - x86/TSC misfeature
-config CLOCKSOURCE_VALIDATE_LAST_CYCLE
-	bool
-
 # Timekeeping vsyscall support
 config GENERIC_TIME_VSYSCALL
 	bool
diff --git a/kernel/time/Makefile b/kernel/time/Makefile
index 4af2a264a160..fe0ae82124fe 100644
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y +=3D time.o timer.o hrtimer.o
+obj-y +=3D time.o timer.o hrtimer.o sleep_timeout.o
 obj-y +=3D timekeeping.o ntp.o clocksource.o jiffies.o timer_list.o
 obj-y +=3D timeconv.o timecounter.o alarmtimer.o
=20
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 8bf888641694..0ddccdff119a 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -197,28 +197,15 @@ static enum hrtimer_restart alarmtimer_fired(struct hrt=
imer *timer)
 {
 	struct alarm *alarm =3D container_of(timer, struct alarm, timer);
 	struct alarm_base *base =3D &alarm_bases[alarm->type];
-	unsigned long flags;
-	int ret =3D HRTIMER_NORESTART;
-	int restart =3D ALARMTIMER_NORESTART;
=20
-	spin_lock_irqsave(&base->lock, flags);
-	alarmtimer_dequeue(base, alarm);
-	spin_unlock_irqrestore(&base->lock, flags);
+	scoped_guard (spinlock_irqsave, &base->lock)
+		alarmtimer_dequeue(base, alarm);
=20
 	if (alarm->function)
-		restart =3D alarm->function(alarm, base->get_ktime());
-
-	spin_lock_irqsave(&base->lock, flags);
-	if (restart !=3D ALARMTIMER_NORESTART) {
-		hrtimer_set_expires(&alarm->timer, alarm->node.expires);
-		alarmtimer_enqueue(base, alarm);
-		ret =3D HRTIMER_RESTART;
-	}
-	spin_unlock_irqrestore(&base->lock, flags);
+		alarm->function(alarm, base->get_ktime());
=20
 	trace_alarmtimer_fired(alarm, base->get_ktime());
-	return ret;
-
+	return HRTIMER_NORESTART;
 }
=20
 ktime_t alarm_expires_remaining(const struct alarm *alarm)
@@ -334,10 +321,9 @@ static int alarmtimer_resume(struct device *dev)
=20
 static void
 __alarm_init(struct alarm *alarm, enum alarmtimer_type type,
-	     enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
+	     void (*function)(struct alarm *, ktime_t))
 {
 	timerqueue_init(&alarm->node);
-	alarm->timer.function =3D alarmtimer_fired;
 	alarm->function =3D function;
 	alarm->type =3D type;
 	alarm->state =3D ALARMTIMER_STATE_INACTIVE;
@@ -350,10 +336,10 @@ __alarm_init(struct alarm *alarm, enum alarmtimer_type =
type,
  * @function: callback that is run when the alarm fires
  */
 void alarm_init(struct alarm *alarm, enum alarmtimer_type type,
-		enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
+		void (*function)(struct alarm *, ktime_t))
 {
-	hrtimer_init(&alarm->timer, alarm_bases[type].base_clockid,
-		     HRTIMER_MODE_ABS);
+	hrtimer_setup(&alarm->timer, alarmtimer_fired, alarm_bases[type].base_clock=
id,
+		      HRTIMER_MODE_ABS);
 	__alarm_init(alarm, type, function);
 }
 EXPORT_SYMBOL_GPL(alarm_init);
@@ -480,35 +466,11 @@ u64 alarm_forward(struct alarm *alarm, ktime_t now, kti=
me_t interval)
 }
 EXPORT_SYMBOL_GPL(alarm_forward);
=20
-static u64 __alarm_forward_now(struct alarm *alarm, ktime_t interval, bool t=
hrottle)
+u64 alarm_forward_now(struct alarm *alarm, ktime_t interval)
 {
 	struct alarm_base *base =3D &alarm_bases[alarm->type];
-	ktime_t now =3D base->get_ktime();
-
-	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && throttle) {
-		/*
-		 * Same issue as with posix_timer_fn(). Timers which are
-		 * periodic but the signal is ignored can starve the system
-		 * with a very small interval. The real fix which was
-		 * promised in the context of posix_timer_fn() never
-		 * materialized, but someone should really work on it.
-		 *
-		 * To prevent DOS fake @now to be 1 jiffy out which keeps
-		 * the overrun accounting correct but creates an
-		 * inconsistency vs. timer_gettime(2).
-		 */
-		ktime_t kj =3D NSEC_PER_SEC / HZ;
=20
-		if (interval < kj)
-			now =3D ktime_add(now, kj);
-	}
-
-	return alarm_forward(alarm, now, interval);
-}
-
-u64 alarm_forward_now(struct alarm *alarm, ktime_t interval)
-{
-	return __alarm_forward_now(alarm, interval, false);
+	return alarm_forward(alarm, base->get_ktime(), interval);
 }
 EXPORT_SYMBOL_GPL(alarm_forward_now);
=20
@@ -567,30 +529,12 @@ static enum alarmtimer_type clock2alarm(clockid_t clock=
id)
  *
  * Return: whether the timer is to be restarted
  */
-static enum alarmtimer_restart alarm_handle_timer(struct alarm *alarm,
-							ktime_t now)
+static void alarm_handle_timer(struct alarm *alarm, ktime_t now)
 {
-	struct k_itimer *ptr =3D container_of(alarm, struct k_itimer,
-					    it.alarm.alarmtimer);
-	enum alarmtimer_restart result =3D ALARMTIMER_NORESTART;
-	unsigned long flags;
+	struct k_itimer *ptr =3D container_of(alarm, struct k_itimer, it.alarm.alar=
mtimer);
=20
-	spin_lock_irqsave(&ptr->it_lock, flags);
-
-	if (posix_timer_queue_signal(ptr) && ptr->it_interval) {
-		/*
-		 * Handle ignored signals and rearm the timer. This will go
-		 * away once we handle ignored signals proper. Ensure that
-		 * small intervals cannot starve the system.
-		 */
-		ptr->it_overrun +=3D __alarm_forward_now(alarm, ptr->it_interval, true);
-		++ptr->it_requeue_pending;
-		ptr->it_active =3D 1;
-		result =3D ALARMTIMER_RESTART;
-	}
-	spin_unlock_irqrestore(&ptr->it_lock, flags);
-
-	return result;
+	guard(spinlock_irqsave)(&ptr->it_lock);
+	posix_timer_queue_signal(ptr);
 }
=20
 /**
@@ -751,18 +695,14 @@ static int alarm_timer_create(struct k_itimer *new_time=
r)
  * @now: time at the timer expiration
  *
  * Wakes up the task that set the alarmtimer
- *
- * Return: ALARMTIMER_NORESTART
  */
-static enum alarmtimer_restart alarmtimer_nsleep_wakeup(struct alarm *alarm,
-								ktime_t now)
+static void alarmtimer_nsleep_wakeup(struct alarm *alarm, ktime_t now)
 {
 	struct task_struct *task =3D alarm->data;
=20
 	alarm->data =3D NULL;
 	if (task)
 		wake_up_process(task);
-	return ALARMTIMER_NORESTART;
 }
=20
 /**
@@ -814,10 +754,10 @@ static int alarmtimer_do_nsleep(struct alarm *alarm, kt=
ime_t absexp,
=20
 static void
 alarm_init_on_stack(struct alarm *alarm, enum alarmtimer_type type,
-		    enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
+		    void (*function)(struct alarm *, ktime_t))
 {
-	hrtimer_init_on_stack(&alarm->timer, alarm_bases[type].base_clockid,
-			      HRTIMER_MODE_ABS);
+	hrtimer_setup_on_stack(&alarm->timer, alarmtimer_fired, alarm_bases[type].b=
ase_clockid,
+			       HRTIMER_MODE_ABS);
 	__alarm_init(alarm, type, function);
 }
=20
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 78c7bd64d0dd..f3e831f62906 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -337,13 +337,21 @@ int clockevents_program_event(struct clock_event_device=
 *dev, ktime_t expires,
 }
=20
 /*
- * Called after a notify add to make devices available which were
- * released from the notifier call.
+ * Called after a clockevent has been added which might
+ * have replaced a current regular or broadcast device. A
+ * released normal device might be a suitable replacement
+ * for the current broadcast device. Similarly a released
+ * broadcast device might be a suitable replacement for a
+ * normal device.
  */
 static void clockevents_notify_released(void)
 {
 	struct clock_event_device *dev;
=20
+	/*
+	 * Keep iterating as long as tick_check_new_device()
+	 * replaces a device.
+	 */
 	while (!list_empty(&clockevents_released)) {
 		dev =3D list_entry(clockevents_released.next,
 				 struct clock_event_device, list);
@@ -610,39 +618,30 @@ void clockevents_resume(void)
=20
 #ifdef CONFIG_HOTPLUG_CPU
=20
-# ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 /**
- * tick_offline_cpu - Take CPU out of the broadcast mechanism
+ * tick_offline_cpu - Shutdown all clock events related
+ *                    to this CPU and take it out of the
+ *                    broadcast mechanism.
  * @cpu:	The outgoing CPU
  *
- * Called on the outgoing CPU after it took itself offline.
+ * Called by the dying CPU during teardown.
  */
 void tick_offline_cpu(unsigned int cpu)
-{
-	raw_spin_lock(&clockevents_lock);
-	tick_broadcast_offline(cpu);
-	raw_spin_unlock(&clockevents_lock);
-}
-# endif
-
-/**
- * tick_cleanup_dead_cpu - Cleanup the tick and clockevents of a dead cpu
- * @cpu:	The dead CPU
- */
-void tick_cleanup_dead_cpu(int cpu)
 {
 	struct clock_event_device *dev, *tmp;
-	unsigned long flags;
=20
-	raw_spin_lock_irqsave(&clockevents_lock, flags);
+	raw_spin_lock(&clockevents_lock);
=20
+	tick_broadcast_offline(cpu);
 	tick_shutdown(cpu);
+
 	/*
 	 * Unregister the clock event devices which were
-	 * released from the users in the notify chain.
+	 * released above.
 	 */
 	list_for_each_entry_safe(dev, tmp, &clockevents_released, list)
 		list_del(&dev->list);
+
 	/*
 	 * Now check whether the CPU has left unused per cpu devices
 	 */
@@ -654,7 +653,8 @@ void tick_cleanup_dead_cpu(int cpu)
 			list_del(&dev->list);
 		}
 	}
-	raw_spin_unlock_irqrestore(&clockevents_lock, flags);
+
+	raw_spin_unlock(&clockevents_lock);
 }
 #endif
=20
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 23336eecb4f4..aab6472853fa 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -20,6 +20,8 @@
 #include "tick-internal.h"
 #include "timekeeping_internal.h"
=20
+static void clocksource_enqueue(struct clocksource *cs);
+
 static noinline u64 cycles_to_nsec_safe(struct clocksource *cs, u64 start, u=
64 end)
 {
 	u64 delta =3D clocksource_delta(end, start, cs->mask);
@@ -171,7 +173,6 @@ static inline void clocksource_watchdog_unlock(unsigned l=
ong *flags)
 }
=20
 static int clocksource_watchdog_kthread(void *data);
-static void __clocksource_change_rating(struct clocksource *cs, int rating);
=20
 static void clocksource_watchdog_work(struct work_struct *work)
 {
@@ -191,6 +192,13 @@ static void clocksource_watchdog_work(struct work_struct=
 *work)
 	kthread_run(clocksource_watchdog_kthread, NULL, "kwatchdog");
 }
=20
+static void clocksource_change_rating(struct clocksource *cs, int rating)
+{
+	list_del(&cs->list);
+	cs->rating =3D rating;
+	clocksource_enqueue(cs);
+}
+
 static void __clocksource_unstable(struct clocksource *cs)
 {
 	cs->flags &=3D ~(CLOCK_SOURCE_VALID_FOR_HRES | CLOCK_SOURCE_WATCHDOG);
@@ -697,7 +705,7 @@ static int __clocksource_watchdog_kthread(void)
 	list_for_each_entry_safe(cs, tmp, &watchdog_list, wd_list) {
 		if (cs->flags & CLOCK_SOURCE_UNSTABLE) {
 			list_del_init(&cs->wd_list);
-			__clocksource_change_rating(cs, 0);
+			clocksource_change_rating(cs, 0);
 			select =3D 1;
 		}
 		if (cs->flags & CLOCK_SOURCE_RESELECT) {
@@ -1255,34 +1263,6 @@ int __clocksource_register_scale(struct clocksource *c=
s, u32 scale, u32 freq)
 }
 EXPORT_SYMBOL_GPL(__clocksource_register_scale);
=20
-static void __clocksource_change_rating(struct clocksource *cs, int rating)
-{
-	list_del(&cs->list);
-	cs->rating =3D rating;
-	clocksource_enqueue(cs);
-}
-
-/**
- * clocksource_change_rating - Change the rating of a registered clocksource
- * @cs:		clocksource to be changed
- * @rating:	new rating
- */
-void clocksource_change_rating(struct clocksource *cs, int rating)
-{
-	unsigned long flags;
-
-	mutex_lock(&clocksource_mutex);
-	clocksource_watchdog_lock(&flags);
-	__clocksource_change_rating(cs, rating);
-	clocksource_watchdog_unlock(&flags);
-
-	clocksource_select();
-	clocksource_select_watchdog(false);
-	clocksource_suspend_select(false);
-	mutex_unlock(&clocksource_mutex);
-}
-EXPORT_SYMBOL(clocksource_change_rating);
-
 /*
  * Unbind clocksource @cs. Called with clocksource_mutex held
  */
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index cddcd08ea827..55e9ffbcd49a 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -417,6 +417,11 @@ static inline void debug_hrtimer_init(struct hrtimer *ti=
mer)
 	debug_object_init(timer, &hrtimer_debug_descr);
 }
=20
+static inline void debug_hrtimer_init_on_stack(struct hrtimer *timer)
+{
+	debug_object_init_on_stack(timer, &hrtimer_debug_descr);
+}
+
 static inline void debug_hrtimer_activate(struct hrtimer *timer,
 					  enum hrtimer_mode mode)
 {
@@ -428,28 +433,6 @@ static inline void debug_hrtimer_deactivate(struct hrtim=
er *timer)
 	debug_object_deactivate(timer, &hrtimer_debug_descr);
 }
=20
-static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
-			   enum hrtimer_mode mode);
-
-void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t clock_id,
-			   enum hrtimer_mode mode)
-{
-	debug_object_init_on_stack(timer, &hrtimer_debug_descr);
-	__hrtimer_init(timer, clock_id, mode);
-}
-EXPORT_SYMBOL_GPL(hrtimer_init_on_stack);
-
-static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
-				   clockid_t clock_id, enum hrtimer_mode mode);
-
-void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
-				   clockid_t clock_id, enum hrtimer_mode mode)
-{
-	debug_object_init_on_stack(&sl->timer, &hrtimer_debug_descr);
-	__hrtimer_init_sleeper(sl, clock_id, mode);
-}
-EXPORT_SYMBOL_GPL(hrtimer_init_sleeper_on_stack);
-
 void destroy_hrtimer_on_stack(struct hrtimer *timer)
 {
 	debug_object_free(timer, &hrtimer_debug_descr);
@@ -459,6 +442,7 @@ EXPORT_SYMBOL_GPL(destroy_hrtimer_on_stack);
 #else
=20
 static inline void debug_hrtimer_init(struct hrtimer *timer) { }
+static inline void debug_hrtimer_init_on_stack(struct hrtimer *timer) { }
 static inline void debug_hrtimer_activate(struct hrtimer *timer,
 					  enum hrtimer_mode mode) { }
 static inline void debug_hrtimer_deactivate(struct hrtimer *timer) { }
@@ -472,6 +456,13 @@ debug_init(struct hrtimer *timer, clockid_t clockid,
 	trace_hrtimer_init(timer, clockid, mode);
 }
=20
+static inline void debug_init_on_stack(struct hrtimer *timer, clockid_t cloc=
kid,
+				       enum hrtimer_mode mode)
+{
+	debug_hrtimer_init_on_stack(timer);
+	trace_hrtimer_init(timer, clockid, mode);
+}
+
 static inline void debug_activate(struct hrtimer *timer,
 				  enum hrtimer_mode mode)
 {
@@ -1544,6 +1535,11 @@ static inline int hrtimer_clockid_to_base(clockid_t cl=
ock_id)
 	return HRTIMER_BASE_MONOTONIC;
 }
=20
+static enum hrtimer_restart hrtimer_dummy_timeout(struct hrtimer *unused)
+{
+	return HRTIMER_NORESTART;
+}
+
 static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 			   enum hrtimer_mode mode)
 {
@@ -1580,6 +1576,18 @@ static void __hrtimer_init(struct hrtimer *timer, cloc=
kid_t clock_id,
 	timerqueue_init(&timer->node);
 }
=20
+static void __hrtimer_setup(struct hrtimer *timer,
+			    enum hrtimer_restart (*function)(struct hrtimer *),
+			    clockid_t clock_id, enum hrtimer_mode mode)
+{
+	__hrtimer_init(timer, clock_id, mode);
+
+	if (WARN_ON_ONCE(!function))
+		timer->function =3D hrtimer_dummy_timeout;
+	else
+		timer->function =3D function;
+}
+
 /**
  * hrtimer_init - initialize a timer to the given clock
  * @timer:	the timer to be initialized
@@ -1600,6 +1608,46 @@ void hrtimer_init(struct hrtimer *timer, clockid_t clo=
ck_id,
 }
 EXPORT_SYMBOL_GPL(hrtimer_init);
=20
+/**
+ * hrtimer_setup - initialize a timer to the given clock
+ * @timer:	the timer to be initialized
+ * @function:	the callback function
+ * @clock_id:	the clock to be used
+ * @mode:       The modes which are relevant for initialization:
+ *              HRTIMER_MODE_ABS, HRTIMER_MODE_REL, HRTIMER_MODE_ABS_SOFT,
+ *              HRTIMER_MODE_REL_SOFT
+ *
+ *              The PINNED variants of the above can be handed in,
+ *              but the PINNED bit is ignored as pinning happens
+ *              when the hrtimer is started
+ */
+void hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*function)(s=
truct hrtimer *),
+		   clockid_t clock_id, enum hrtimer_mode mode)
+{
+	debug_init(timer, clock_id, mode);
+	__hrtimer_setup(timer, function, clock_id, mode);
+}
+EXPORT_SYMBOL_GPL(hrtimer_setup);
+
+/**
+ * hrtimer_setup_on_stack - initialize a timer on stack memory
+ * @timer:	The timer to be initialized
+ * @function:	the callback function
+ * @clock_id:	The clock to be used
+ * @mode:       The timer mode
+ *
+ * Similar to hrtimer_setup(), except that this one must be used if struct h=
rtimer is in stack
+ * memory.
+ */
+void hrtimer_setup_on_stack(struct hrtimer *timer,
+			    enum hrtimer_restart (*function)(struct hrtimer *),
+			    clockid_t clock_id, enum hrtimer_mode mode)
+{
+	debug_init_on_stack(timer, clock_id, mode);
+	__hrtimer_setup(timer, function, clock_id, mode);
+}
+EXPORT_SYMBOL_GPL(hrtimer_setup_on_stack);
+
 /*
  * A timer is active, when it is enqueued into the rbtree or the
  * callback function is running or it's in the state of being migrated
@@ -1944,7 +1992,7 @@ void hrtimer_sleeper_start_expires(struct hrtimer_sleep=
er *sl,
 	 * Make the enqueue delivery mode check work on RT. If the sleeper
 	 * was initialized for hard interrupt delivery, force the mode bit.
 	 * This is a special case for hrtimer_sleepers because
-	 * hrtimer_init_sleeper() determines the delivery mode on RT so the
+	 * __hrtimer_init_sleeper() determines the delivery mode on RT so the
 	 * fiddling with this decision is avoided at the call sites.
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && sl->timer.is_hard)
@@ -1987,19 +2035,18 @@ static void __hrtimer_init_sleeper(struct hrtimer_sle=
eper *sl,
 }
=20
 /**
- * hrtimer_init_sleeper - initialize sleeper to the given clock
+ * hrtimer_setup_sleeper_on_stack - initialize a sleeper in stack memory
  * @sl:		sleeper to be initialized
  * @clock_id:	the clock to be used
  * @mode:	timer mode abs/rel
  */
-void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, clockid_t clock_id,
-			  enum hrtimer_mode mode)
+void hrtimer_setup_sleeper_on_stack(struct hrtimer_sleeper *sl,
+				    clockid_t clock_id, enum hrtimer_mode mode)
 {
-	debug_init(&sl->timer, clock_id, mode);
+	debug_init_on_stack(&sl->timer, clock_id, mode);
 	__hrtimer_init_sleeper(sl, clock_id, mode);
-
 }
-EXPORT_SYMBOL_GPL(hrtimer_init_sleeper);
+EXPORT_SYMBOL_GPL(hrtimer_setup_sleeper_on_stack);
=20
 int nanosleep_copyout(struct restart_block *restart, struct timespec64 *ts)
 {
@@ -2060,8 +2107,7 @@ static long __sched hrtimer_nanosleep_restart(struct re=
start_block *restart)
 	struct hrtimer_sleeper t;
 	int ret;
=20
-	hrtimer_init_sleeper_on_stack(&t, restart->nanosleep.clockid,
-				      HRTIMER_MODE_ABS);
+	hrtimer_setup_sleeper_on_stack(&t, restart->nanosleep.clockid, HRTIMER_MODE=
_ABS);
 	hrtimer_set_expires_tv64(&t.timer, restart->nanosleep.expires);
 	ret =3D do_nanosleep(&t, HRTIMER_MODE_ABS);
 	destroy_hrtimer_on_stack(&t.timer);
@@ -2075,7 +2121,7 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer=
_mode mode,
 	struct hrtimer_sleeper t;
 	int ret =3D 0;
=20
-	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
+	hrtimer_setup_sleeper_on_stack(&t, clockid, mode);
 	hrtimer_set_expires_range_ns(&t.timer, rqtp, current->timer_slack_ns);
 	ret =3D do_nanosleep(&t, mode);
 	if (ret !=3D -ERESTART_RESTARTBLOCK)
@@ -2242,123 +2288,3 @@ void __init hrtimers_init(void)
 	hrtimers_prepare_cpu(smp_processor_id());
 	open_softirq(HRTIMER_SOFTIRQ, hrtimer_run_softirq);
 }
-
-/**
- * schedule_hrtimeout_range_clock - sleep until timeout
- * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t)
- * @mode:	timer mode
- * @clock_id:	timer clock to be used
- */
-int __sched
-schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
-			       const enum hrtimer_mode mode, clockid_t clock_id)
-{
-	struct hrtimer_sleeper t;
-
-	/*
-	 * Optimize when a zero timeout value is given. It does not
-	 * matter whether this is an absolute or a relative time.
-	 */
-	if (expires && *expires =3D=3D 0) {
-		__set_current_state(TASK_RUNNING);
-		return 0;
-	}
-
-	/*
-	 * A NULL parameter means "infinite"
-	 */
-	if (!expires) {
-		schedule();
-		return -EINTR;
-	}
-
-	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
-	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
-	hrtimer_sleeper_start_expires(&t, mode);
-
-	if (likely(t.task))
-		schedule();
-
-	hrtimer_cancel(&t.timer);
-	destroy_hrtimer_on_stack(&t.timer);
-
-	__set_current_state(TASK_RUNNING);
-
-	return !t.task ? 0 : -EINTR;
-}
-EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
-
-/**
- * schedule_hrtimeout_range - sleep until timeout
- * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t)
- * @mode:	timer mode
- *
- * Make the current task sleep until the given expiry time has
- * elapsed. The routine will return immediately unless
- * the current task state has been set (see set_current_state()).
- *
- * The @delta argument gives the kernel the freedom to schedule the
- * actual wakeup to a time that is both power and performance friendly
- * for regular (non RT/DL) tasks.
- * The kernel give the normal best effort behavior for "@expires+@delta",
- * but may decide to fire the timer earlier, but no earlier than @expires.
- *
- * You can set the task state as follows -
- *
- * %TASK_UNINTERRUPTIBLE - at least @timeout time is guaranteed to
- * pass before the routine returns unless the current task is explicitly
- * woken up, (e.g. by wake_up_process()).
- *
- * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
- * delivered to the current task or the current task is explicitly woken
- * up.
- *
- * The current task state is guaranteed to be TASK_RUNNING when this
- * routine returns.
- *
- * Returns 0 when the timer has expired. If the task was woken before the
- * timer expired by a signal (only possible in state TASK_INTERRUPTIBLE) or
- * by an explicit wakeup, it returns -EINTR.
- */
-int __sched schedule_hrtimeout_range(ktime_t *expires, u64 delta,
-				     const enum hrtimer_mode mode)
-{
-	return schedule_hrtimeout_range_clock(expires, delta, mode,
-					      CLOCK_MONOTONIC);
-}
-EXPORT_SYMBOL_GPL(schedule_hrtimeout_range);
-
-/**
- * schedule_hrtimeout - sleep until timeout
- * @expires:	timeout value (ktime_t)
- * @mode:	timer mode
- *
- * Make the current task sleep until the given expiry time has
- * elapsed. The routine will return immediately unless
- * the current task state has been set (see set_current_state()).
- *
- * You can set the task state as follows -
- *
- * %TASK_UNINTERRUPTIBLE - at least @timeout time is guaranteed to
- * pass before the routine returns unless the current task is explicitly
- * woken up, (e.g. by wake_up_process()).
- *
- * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
- * delivered to the current task or the current task is explicitly woken
- * up.
- *
- * The current task state is guaranteed to be TASK_RUNNING when this
- * routine returns.
- *
- * Returns 0 when the timer has expired. If the task was woken before the
- * timer expired by a signal (only possible in state TASK_INTERRUPTIBLE) or
- * by an explicit wakeup, it returns -EINTR.
- */
-int __sched schedule_hrtimeout(ktime_t *expires,
-			       const enum hrtimer_mode mode)
-{
-	return schedule_hrtimeout_range(expires, 0, mode);
-}
-EXPORT_SYMBOL_GPL(schedule_hrtimeout);
diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index 00629e658ca1..876d389b2e21 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -151,7 +151,27 @@ COMPAT_SYSCALL_DEFINE2(getitimer, int, which,
 #endif
=20
 /*
- * The timer is automagically restarted, when interval !=3D 0
+ * Invoked from dequeue_signal() when SIG_ALRM is delivered.
+ *
+ * Restart the ITIMER_REAL timer if it is armed as periodic timer.  Doing
+ * this in the signal delivery path instead of self rearming prevents a DoS
+ * with small increments in the high reolution timer case and reduces timer
+ * noise in general.
+ */
+void posixtimer_rearm_itimer(struct task_struct *tsk)
+{
+	struct hrtimer *tmr =3D &tsk->signal->real_timer;
+
+	if (!hrtimer_is_queued(tmr) && tsk->signal->it_real_incr !=3D 0) {
+		hrtimer_forward(tmr, tmr->base->get_time(),
+				tsk->signal->it_real_incr);
+		hrtimer_restart(tmr);
+	}
+}
+
+/*
+ * Interval timers are restarted in the signal delivery path.  See
+ * posixtimer_rearm_itimer().
  */
 enum hrtimer_restart it_real_fn(struct hrtimer *timer)
 {
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 802b336f4b8c..b550ebe0f03b 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -22,22 +22,79 @@
 #include "ntp_internal.h"
 #include "timekeeping_internal.h"
=20
-
-/*
- * NTP timekeeping variables:
+/**
+ * struct ntp_data - Structure holding all NTP related state
+ * @tick_usec:		USER_HZ period in microseconds
+ * @tick_length:	Adjusted tick length
+ * @tick_length_base:	Base value for @tick_length
+ * @time_state:		State of the clock synchronization
+ * @time_status:	Clock status bits
+ * @time_offset:	Time adjustment in nanoseconds
+ * @time_constant:	PLL time constant
+ * @time_maxerror:	Maximum error in microseconds holding the NTP sync distan=
ce
+ *			(NTP dispersion + delay / 2)
+ * @time_esterror:	Estimated error in microseconds holding NTP dispersion
+ * @time_freq:		Frequency offset scaled nsecs/secs
+ * @time_reftime:	Time at last adjustment in seconds
+ * @time_adjust:	Adjustment value
+ * @ntp_tick_adj:	Constant boot-param configurable NTP tick adjustment (upsc=
aled)
+ * @ntp_next_leap_sec:	Second value of the next pending leapsecond, or TIME6=
4_MAX if no leap
  *
- * Note: All of the NTP state is protected by the timekeeping locks.
+ * @pps_valid:		PPS signal watchdog counter
+ * @pps_tf:		PPS phase median filter
+ * @pps_jitter:		PPS current jitter in nanoseconds
+ * @pps_fbase:		PPS beginning of the last freq interval
+ * @pps_shift:		PPS current interval duration in seconds (shift value)
+ * @pps_intcnt:		PPS interval counter
+ * @pps_freq:		PPS frequency offset in scaled ns/s
+ * @pps_stabil:		PPS current stability in scaled ns/s
+ * @pps_calcnt:		PPS monitor: calibration intervals
+ * @pps_jitcnt:		PPS monitor: jitter limit exceeded
+ * @pps_stbcnt:		PPS monitor: stability limit exceeded
+ * @pps_errcnt:		PPS monitor: calibration errors
+ *
+ * Protected by the timekeeping locks.
  */
+struct ntp_data {
+	unsigned long		tick_usec;
+	u64			tick_length;
+	u64			tick_length_base;
+	int			time_state;
+	int			time_status;
+	s64			time_offset;
+	long			time_constant;
+	long			time_maxerror;
+	long			time_esterror;
+	s64			time_freq;
+	time64_t		time_reftime;
+	long			time_adjust;
+	s64			ntp_tick_adj;
+	time64_t		ntp_next_leap_sec;
+#ifdef CONFIG_NTP_PPS
+	int			pps_valid;
+	long			pps_tf[3];
+	long			pps_jitter;
+	struct timespec64	pps_fbase;
+	int			pps_shift;
+	int			pps_intcnt;
+	s64			pps_freq;
+	long			pps_stabil;
+	long			pps_calcnt;
+	long			pps_jitcnt;
+	long			pps_stbcnt;
+	long			pps_errcnt;
+#endif
+};
=20
-
-/* USER_HZ period (usecs): */
-unsigned long			tick_usec =3D USER_TICK_USEC;
-
-/* SHIFTED_HZ period (nsecs): */
-unsigned long			tick_nsec;
-
-static u64			tick_length;
-static u64			tick_length_base;
+static struct ntp_data tk_ntp_data =3D {
+	.tick_usec		=3D USER_TICK_USEC,
+	.time_state		=3D TIME_OK,
+	.time_status		=3D STA_UNSYNC,
+	.time_constant		=3D 2,
+	.time_maxerror		=3D NTP_PHASE_LIMIT,
+	.time_esterror		=3D NTP_PHASE_LIMIT,
+	.ntp_next_leap_sec	=3D TIME64_MAX,
+};
=20
 #define SECS_PER_DAY		86400
 #define MAX_TICKADJ		500LL		/* usecs */
@@ -45,46 +102,6 @@ static u64			tick_length_base;
 	(((MAX_TICKADJ * NSEC_PER_USEC) << NTP_SCALE_SHIFT) / NTP_INTERVAL_FREQ)
 #define MAX_TAI_OFFSET		100000
=20
-/*
- * phase-lock loop variables
- */
-
-/*
- * clock synchronization status
- *
- * (TIME_ERROR prevents overwriting the CMOS clock)
- */
-static int			time_state =3D TIME_OK;
-
-/* clock status bits:							*/
-static int			time_status =3D STA_UNSYNC;
-
-/* time adjustment (nsecs):						*/
-static s64			time_offset;
-
-/* pll time constant:							*/
-static long			time_constant =3D 2;
-
-/* maximum error (usecs):						*/
-static long			time_maxerror =3D NTP_PHASE_LIMIT;
-
-/* estimated error (usecs):						*/
-static long			time_esterror =3D NTP_PHASE_LIMIT;
-
-/* frequency offset (scaled nsecs/secs):				*/
-static s64			time_freq;
-
-/* time at last adjustment (secs):					*/
-static time64_t		time_reftime;
-
-static long			time_adjust;
-
-/* constant (boot-param configurable) NTP tick adjustment (upscaled)	*/
-static s64			ntp_tick_adj;
-
-/* second value of the next pending leapsecond, or TIME64_MAX if no leap */
-static time64_t			ntp_next_leap_sec =3D TIME64_MAX;
-
 #ifdef CONFIG_NTP_PPS
=20
 /*
@@ -101,128 +118,115 @@ static time64_t			ntp_next_leap_sec =3D TIME64_MAX;
 				   intervals to decrease it */
 #define PPS_MAXWANDER	100000	/* max PPS freq wander (ns/s) */
=20
-static int pps_valid;		/* signal watchdog counter */
-static long pps_tf[3];		/* phase median filter */
-static long pps_jitter;		/* current jitter (ns) */
-static struct timespec64 pps_fbase; /* beginning of the last freq interval */
-static int pps_shift;		/* current interval duration (s) (shift) */
-static int pps_intcnt;		/* interval counter */
-static s64 pps_freq;		/* frequency offset (scaled ns/s) */
-static long pps_stabil;		/* current stability (scaled ns/s) */
-
 /*
- * PPS signal quality monitors
- */
-static long pps_calcnt;		/* calibration intervals */
-static long pps_jitcnt;		/* jitter limit exceeded */
-static long pps_stbcnt;		/* stability limit exceeded */
-static long pps_errcnt;		/* calibration errors */
-
-
-/* PPS kernel consumer compensates the whole phase error immediately.
+ * PPS kernel consumer compensates the whole phase error immediately.
  * Otherwise, reduce the offset by a fixed factor times the time constant.
  */
-static inline s64 ntp_offset_chunk(s64 offset)
+static inline s64 ntp_offset_chunk(struct ntp_data *ntpdata, s64 offset)
 {
-	if (time_status & STA_PPSTIME && time_status & STA_PPSSIGNAL)
+	if (ntpdata->time_status & STA_PPSTIME && ntpdata->time_status & STA_PPSSIG=
NAL)
 		return offset;
 	else
-		return shift_right(offset, SHIFT_PLL + time_constant);
+		return shift_right(offset, SHIFT_PLL + ntpdata->time_constant);
 }
=20
-static inline void pps_reset_freq_interval(void)
+static inline void pps_reset_freq_interval(struct ntp_data *ntpdata)
 {
-	/* the PPS calibration interval may end
-	   surprisingly early */
-	pps_shift =3D PPS_INTMIN;
-	pps_intcnt =3D 0;
+	/* The PPS calibration interval may end surprisingly early */
+	ntpdata->pps_shift =3D PPS_INTMIN;
+	ntpdata->pps_intcnt =3D 0;
 }
=20
 /**
  * pps_clear - Clears the PPS state variables
+ * @ntpdata:	Pointer to ntp data
  */
-static inline void pps_clear(void)
+static inline void pps_clear(struct ntp_data *ntpdata)
 {
-	pps_reset_freq_interval();
-	pps_tf[0] =3D 0;
-	pps_tf[1] =3D 0;
-	pps_tf[2] =3D 0;
-	pps_fbase.tv_sec =3D pps_fbase.tv_nsec =3D 0;
-	pps_freq =3D 0;
+	pps_reset_freq_interval(ntpdata);
+	ntpdata->pps_tf[0] =3D 0;
+	ntpdata->pps_tf[1] =3D 0;
+	ntpdata->pps_tf[2] =3D 0;
+	ntpdata->pps_fbase.tv_sec =3D ntpdata->pps_fbase.tv_nsec =3D 0;
+	ntpdata->pps_freq =3D 0;
 }
=20
-/* Decrease pps_valid to indicate that another second has passed since
- * the last PPS signal. When it reaches 0, indicate that PPS signal is
- * missing.
+/*
+ * Decrease pps_valid to indicate that another second has passed since the
+ * last PPS signal. When it reaches 0, indicate that PPS signal is missing.
  */
-static inline void pps_dec_valid(void)
+static inline void pps_dec_valid(struct ntp_data *ntpdata)
 {
-	if (pps_valid > 0)
-		pps_valid--;
-	else {
-		time_status &=3D ~(STA_PPSSIGNAL | STA_PPSJITTER |
-				 STA_PPSWANDER | STA_PPSERROR);
-		pps_clear();
+	if (ntpdata->pps_valid > 0) {
+		ntpdata->pps_valid--;
+	} else {
+		ntpdata->time_status &=3D ~(STA_PPSSIGNAL | STA_PPSJITTER |
+					  STA_PPSWANDER | STA_PPSERROR);
+		pps_clear(ntpdata);
 	}
 }
=20
-static inline void pps_set_freq(s64 freq)
+static inline void pps_set_freq(struct ntp_data *ntpdata)
 {
-	pps_freq =3D freq;
+	ntpdata->pps_freq =3D ntpdata->time_freq;
 }
=20
-static inline int is_error_status(int status)
+static inline bool is_error_status(int status)
 {
 	return (status & (STA_UNSYNC|STA_CLOCKERR))
-		/* PPS signal lost when either PPS time or
-		 * PPS frequency synchronization requested
+		/*
+		 * PPS signal lost when either PPS time or PPS frequency
+		 * synchronization requested
 		 */
 		|| ((status & (STA_PPSFREQ|STA_PPSTIME))
 			&& !(status & STA_PPSSIGNAL))
-		/* PPS jitter exceeded when
-		 * PPS time synchronization requested */
+		/*
+		 * PPS jitter exceeded when PPS time synchronization
+		 * requested
+		 */
 		|| ((status & (STA_PPSTIME|STA_PPSJITTER))
 			=3D=3D (STA_PPSTIME|STA_PPSJITTER))
-		/* PPS wander exceeded or calibration error when
-		 * PPS frequency synchronization requested
+		/*
+		 * PPS wander exceeded or calibration error when PPS
+		 * frequency synchronization requested
 		 */
 		|| ((status & STA_PPSFREQ)
 			&& (status & (STA_PPSWANDER|STA_PPSERROR)));
 }
=20
-static inline void pps_fill_timex(struct __kernel_timex *txc)
+static inline void pps_fill_timex(struct ntp_data *ntpdata, struct __kernel_=
timex *txc)
 {
-	txc->ppsfreq	   =3D shift_right((pps_freq >> PPM_SCALE_INV_SHIFT) *
+	txc->ppsfreq	   =3D shift_right((ntpdata->pps_freq >> PPM_SCALE_INV_SHIFT) *
 					 PPM_SCALE_INV, NTP_SCALE_SHIFT);
-	txc->jitter	   =3D pps_jitter;
-	if (!(time_status & STA_NANO))
-		txc->jitter =3D pps_jitter / NSEC_PER_USEC;
-	txc->shift	   =3D pps_shift;
-	txc->stabil	   =3D pps_stabil;
-	txc->jitcnt	   =3D pps_jitcnt;
-	txc->calcnt	   =3D pps_calcnt;
-	txc->errcnt	   =3D pps_errcnt;
-	txc->stbcnt	   =3D pps_stbcnt;
+	txc->jitter	   =3D ntpdata->pps_jitter;
+	if (!(ntpdata->time_status & STA_NANO))
+		txc->jitter =3D ntpdata->pps_jitter / NSEC_PER_USEC;
+	txc->shift	   =3D ntpdata->pps_shift;
+	txc->stabil	   =3D ntpdata->pps_stabil;
+	txc->jitcnt	   =3D ntpdata->pps_jitcnt;
+	txc->calcnt	   =3D ntpdata->pps_calcnt;
+	txc->errcnt	   =3D ntpdata->pps_errcnt;
+	txc->stbcnt	   =3D ntpdata->pps_stbcnt;
 }
=20
 #else /* !CONFIG_NTP_PPS */
=20
-static inline s64 ntp_offset_chunk(s64 offset)
+static inline s64 ntp_offset_chunk(struct ntp_data *ntpdata, s64 offset)
 {
-	return shift_right(offset, SHIFT_PLL + time_constant);
+	return shift_right(offset, SHIFT_PLL + ntpdata->time_constant);
 }
=20
-static inline void pps_reset_freq_interval(void) {}
-static inline void pps_clear(void) {}
-static inline void pps_dec_valid(void) {}
-static inline void pps_set_freq(s64 freq) {}
+static inline void pps_reset_freq_interval(struct ntp_data *ntpdata) {}
+static inline void pps_clear(struct ntp_data *ntpdata) {}
+static inline void pps_dec_valid(struct ntp_data *ntpdata) {}
+static inline void pps_set_freq(struct ntp_data *ntpdata) {}
=20
-static inline int is_error_status(int status)
+static inline bool is_error_status(int status)
 {
 	return status & (STA_UNSYNC|STA_CLOCKERR);
 }
=20
-static inline void pps_fill_timex(struct __kernel_timex *txc)
+static inline void pps_fill_timex(struct ntp_data *ntpdata, struct __kernel_=
timex *txc)
 {
 	/* PPS is not implemented, so these are zero */
 	txc->ppsfreq	   =3D 0;
@@ -237,138 +241,123 @@ static inline void pps_fill_timex(struct __kernel_tim=
ex *txc)
=20
 #endif /* CONFIG_NTP_PPS */
=20
-
-/**
- * ntp_synced - Returns 1 if the NTP status is not UNSYNC
- *
- */
-static inline int ntp_synced(void)
-{
-	return !(time_status & STA_UNSYNC);
-}
-
-
 /*
- * NTP methods:
+ * Update tick_length and tick_length_base, based on tick_usec, ntp_tick_adj=
 and
+ * time_freq:
  */
-
-/*
- * Update (tick_length, tick_length_base, tick_nsec), based
- * on (tick_usec, ntp_tick_adj, time_freq):
- */
-static void ntp_update_frequency(void)
+static void ntp_update_frequency(struct ntp_data *ntpdata)
 {
-	u64 second_length;
-	u64 new_base;
+	u64 second_length, new_base, tick_usec =3D (u64)ntpdata->tick_usec;
=20
-	second_length		 =3D (u64)(tick_usec * NSEC_PER_USEC * USER_HZ)
-						<< NTP_SCALE_SHIFT;
+	second_length		 =3D (u64)(tick_usec * NSEC_PER_USEC * USER_HZ) << NTP_SCALE=
_SHIFT;
=20
-	second_length		+=3D ntp_tick_adj;
-	second_length		+=3D time_freq;
+	second_length		+=3D ntpdata->ntp_tick_adj;
+	second_length		+=3D ntpdata->time_freq;
=20
-	tick_nsec		 =3D div_u64(second_length, HZ) >> NTP_SCALE_SHIFT;
 	new_base		 =3D div_u64(second_length, NTP_INTERVAL_FREQ);
=20
 	/*
-	 * Don't wait for the next second_overflow, apply
-	 * the change to the tick length immediately:
+	 * Don't wait for the next second_overflow, apply the change to the
+	 * tick length immediately:
 	 */
-	tick_length		+=3D new_base - tick_length_base;
-	tick_length_base	 =3D new_base;
+	ntpdata->tick_length		+=3D new_base - ntpdata->tick_length_base;
+	ntpdata->tick_length_base	 =3D new_base;
 }
=20
-static inline s64 ntp_update_offset_fll(s64 offset64, long secs)
+static inline s64 ntp_update_offset_fll(struct ntp_data *ntpdata, s64 offset=
64, long secs)
 {
-	time_status &=3D ~STA_MODE;
+	ntpdata->time_status &=3D ~STA_MODE;
=20
 	if (secs < MINSEC)
 		return 0;
=20
-	if (!(time_status & STA_FLL) && (secs <=3D MAXSEC))
+	if (!(ntpdata->time_status & STA_FLL) && (secs <=3D MAXSEC))
 		return 0;
=20
-	time_status |=3D STA_MODE;
+	ntpdata->time_status |=3D STA_MODE;
=20
 	return div64_long(offset64 << (NTP_SCALE_SHIFT - SHIFT_FLL), secs);
 }
=20
-static void ntp_update_offset(long offset)
+static void ntp_update_offset(struct ntp_data *ntpdata, long offset)
 {
-	s64 freq_adj;
-	s64 offset64;
-	long secs;
+	s64 freq_adj, offset64;
+	long secs, real_secs;
=20
-	if (!(time_status & STA_PLL))
+	if (!(ntpdata->time_status & STA_PLL))
 		return;
=20
-	if (!(time_status & STA_NANO)) {
+	if (!(ntpdata->time_status & STA_NANO)) {
 		/* Make sure the multiplication below won't overflow */
 		offset =3D clamp(offset, -USEC_PER_SEC, USEC_PER_SEC);
 		offset *=3D NSEC_PER_USEC;
 	}
=20
-	/*
-	 * Scale the phase adjustment and
-	 * clamp to the operating range.
-	 */
+	/* Scale the phase adjustment and clamp to the operating range. */
 	offset =3D clamp(offset, -MAXPHASE, MAXPHASE);
=20
 	/*
 	 * Select how the frequency is to be controlled
 	 * and in which mode (PLL or FLL).
 	 */
-	secs =3D (long)(__ktime_get_real_seconds() - time_reftime);
-	if (unlikely(time_status & STA_FREQHOLD))
+	real_secs =3D __ktime_get_real_seconds();
+	secs =3D (long)(real_secs - ntpdata->time_reftime);
+	if (unlikely(ntpdata->time_status & STA_FREQHOLD))
 		secs =3D 0;
=20
-	time_reftime =3D __ktime_get_real_seconds();
+	ntpdata->time_reftime =3D real_secs;
=20
 	offset64    =3D offset;
-	freq_adj    =3D ntp_update_offset_fll(offset64, secs);
+	freq_adj    =3D ntp_update_offset_fll(ntpdata, offset64, secs);
=20
 	/*
 	 * Clamp update interval to reduce PLL gain with low
 	 * sampling rate (e.g. intermittent network connection)
 	 * to avoid instability.
 	 */
-	if (unlikely(secs > 1 << (SHIFT_PLL + 1 + time_constant)))
-		secs =3D 1 << (SHIFT_PLL + 1 + time_constant);
+	if (unlikely(secs > 1 << (SHIFT_PLL + 1 + ntpdata->time_constant)))
+		secs =3D 1 << (SHIFT_PLL + 1 + ntpdata->time_constant);
=20
 	freq_adj    +=3D (offset64 * secs) <<
-			(NTP_SCALE_SHIFT - 2 * (SHIFT_PLL + 2 + time_constant));
+			(NTP_SCALE_SHIFT - 2 * (SHIFT_PLL + 2 + ntpdata->time_constant));
=20
-	freq_adj    =3D min(freq_adj + time_freq, MAXFREQ_SCALED);
+	freq_adj    =3D min(freq_adj + ntpdata->time_freq, MAXFREQ_SCALED);
=20
-	time_freq   =3D max(freq_adj, -MAXFREQ_SCALED);
+	ntpdata->time_freq   =3D max(freq_adj, -MAXFREQ_SCALED);
=20
-	time_offset =3D div_s64(offset64 << NTP_SCALE_SHIFT, NTP_INTERVAL_FREQ);
+	ntpdata->time_offset =3D div_s64(offset64 << NTP_SCALE_SHIFT, NTP_INTERVAL_=
FREQ);
 }
=20
-/**
- * ntp_clear - Clears the NTP state variables
- */
-void ntp_clear(void)
+static void __ntp_clear(struct ntp_data *ntpdata)
 {
-	time_adjust	=3D 0;		/* stop active adjtime() */
-	time_status	|=3D STA_UNSYNC;
-	time_maxerror	=3D NTP_PHASE_LIMIT;
-	time_esterror	=3D NTP_PHASE_LIMIT;
+	/* Stop active adjtime() */
+	ntpdata->time_adjust	=3D 0;
+	ntpdata->time_status	|=3D STA_UNSYNC;
+	ntpdata->time_maxerror	=3D NTP_PHASE_LIMIT;
+	ntpdata->time_esterror	=3D NTP_PHASE_LIMIT;
=20
-	ntp_update_frequency();
+	ntp_update_frequency(ntpdata);
=20
-	tick_length	=3D tick_length_base;
-	time_offset	=3D 0;
+	ntpdata->tick_length	=3D ntpdata->tick_length_base;
+	ntpdata->time_offset	=3D 0;
=20
-	ntp_next_leap_sec =3D TIME64_MAX;
+	ntpdata->ntp_next_leap_sec =3D TIME64_MAX;
 	/* Clear PPS state variables */
-	pps_clear();
+	pps_clear(ntpdata);
+}
+
+/**
+ * ntp_clear - Clears the NTP state variables
+ */
+void ntp_clear(void)
+{
+	__ntp_clear(&tk_ntp_data);
 }
=20
=20
 u64 ntp_tick_length(void)
 {
-	return tick_length;
+	return tk_ntp_data.tick_length;
 }
=20
 /**
@@ -379,16 +368,17 @@ u64 ntp_tick_length(void)
  */
 ktime_t ntp_get_next_leap(void)
 {
+	struct ntp_data *ntpdata =3D &tk_ntp_data;
 	ktime_t ret;
=20
-	if ((time_state =3D=3D TIME_INS) && (time_status & STA_INS))
-		return ktime_set(ntp_next_leap_sec, 0);
+	if ((ntpdata->time_state =3D=3D TIME_INS) && (ntpdata->time_status & STA_IN=
S))
+		return ktime_set(ntpdata->ntp_next_leap_sec, 0);
 	ret =3D KTIME_MAX;
 	return ret;
 }
=20
 /*
- * this routine handles the overflow of the microsecond field
+ * This routine handles the overflow of the microsecond field
  *
  * The tricky bits of code to handle the accurate clock support
  * were provided by Dave Mills (Mills@UDEL.EDU) of NTP fame.
@@ -399,6 +389,7 @@ ktime_t ntp_get_next_leap(void)
  */
 int second_overflow(time64_t secs)
 {
+	struct ntp_data *ntpdata =3D &tk_ntp_data;
 	s64 delta;
 	int leap =3D 0;
 	s32 rem;
@@ -408,87 +399,84 @@ int second_overflow(time64_t secs)
 	 * day, the system clock is set back one second; if in leap-delete
 	 * state, the system clock is set ahead one second.
 	 */
-	switch (time_state) {
+	switch (ntpdata->time_state) {
 	case TIME_OK:
-		if (time_status & STA_INS) {
-			time_state =3D TIME_INS;
+		if (ntpdata->time_status & STA_INS) {
+			ntpdata->time_state =3D TIME_INS;
 			div_s64_rem(secs, SECS_PER_DAY, &rem);
-			ntp_next_leap_sec =3D secs + SECS_PER_DAY - rem;
-		} else if (time_status & STA_DEL) {
-			time_state =3D TIME_DEL;
+			ntpdata->ntp_next_leap_sec =3D secs + SECS_PER_DAY - rem;
+		} else if (ntpdata->time_status & STA_DEL) {
+			ntpdata->time_state =3D TIME_DEL;
 			div_s64_rem(secs + 1, SECS_PER_DAY, &rem);
-			ntp_next_leap_sec =3D secs + SECS_PER_DAY - rem;
+			ntpdata->ntp_next_leap_sec =3D secs + SECS_PER_DAY - rem;
 		}
 		break;
 	case TIME_INS:
-		if (!(time_status & STA_INS)) {
-			ntp_next_leap_sec =3D TIME64_MAX;
-			time_state =3D TIME_OK;
-		} else if (secs =3D=3D ntp_next_leap_sec) {
+		if (!(ntpdata->time_status & STA_INS)) {
+			ntpdata->ntp_next_leap_sec =3D TIME64_MAX;
+			ntpdata->time_state =3D TIME_OK;
+		} else if (secs =3D=3D ntpdata->ntp_next_leap_sec) {
 			leap =3D -1;
-			time_state =3D TIME_OOP;
-			printk(KERN_NOTICE
-				"Clock: inserting leap second 23:59:60 UTC\n");
+			ntpdata->time_state =3D TIME_OOP;
+			pr_notice("Clock: inserting leap second 23:59:60 UTC\n");
 		}
 		break;
 	case TIME_DEL:
-		if (!(time_status & STA_DEL)) {
-			ntp_next_leap_sec =3D TIME64_MAX;
-			time_state =3D TIME_OK;
-		} else if (secs =3D=3D ntp_next_leap_sec) {
+		if (!(ntpdata->time_status & STA_DEL)) {
+			ntpdata->ntp_next_leap_sec =3D TIME64_MAX;
+			ntpdata->time_state =3D TIME_OK;
+		} else if (secs =3D=3D ntpdata->ntp_next_leap_sec) {
 			leap =3D 1;
-			ntp_next_leap_sec =3D TIME64_MAX;
-			time_state =3D TIME_WAIT;
-			printk(KERN_NOTICE
-				"Clock: deleting leap second 23:59:59 UTC\n");
+			ntpdata->ntp_next_leap_sec =3D TIME64_MAX;
+			ntpdata->time_state =3D TIME_WAIT;
+			pr_notice("Clock: deleting leap second 23:59:59 UTC\n");
 		}
 		break;
 	case TIME_OOP:
-		ntp_next_leap_sec =3D TIME64_MAX;
-		time_state =3D TIME_WAIT;
+		ntpdata->ntp_next_leap_sec =3D TIME64_MAX;
+		ntpdata->time_state =3D TIME_WAIT;
 		break;
 	case TIME_WAIT:
-		if (!(time_status & (STA_INS | STA_DEL)))
-			time_state =3D TIME_OK;
+		if (!(ntpdata->time_status & (STA_INS | STA_DEL)))
+			ntpdata->time_state =3D TIME_OK;
 		break;
 	}
=20
-
 	/* Bump the maxerror field */
-	time_maxerror +=3D MAXFREQ / NSEC_PER_USEC;
-	if (time_maxerror > NTP_PHASE_LIMIT) {
-		time_maxerror =3D NTP_PHASE_LIMIT;
-		time_status |=3D STA_UNSYNC;
+	ntpdata->time_maxerror +=3D MAXFREQ / NSEC_PER_USEC;
+	if (ntpdata->time_maxerror > NTP_PHASE_LIMIT) {
+		ntpdata->time_maxerror =3D NTP_PHASE_LIMIT;
+		ntpdata->time_status |=3D STA_UNSYNC;
 	}
=20
 	/* Compute the phase adjustment for the next second */
-	tick_length	 =3D tick_length_base;
+	ntpdata->tick_length	 =3D ntpdata->tick_length_base;
=20
-	delta		 =3D ntp_offset_chunk(time_offset);
-	time_offset	-=3D delta;
-	tick_length	+=3D delta;
+	delta			 =3D ntp_offset_chunk(ntpdata, ntpdata->time_offset);
+	ntpdata->time_offset	-=3D delta;
+	ntpdata->tick_length	+=3D delta;
=20
 	/* Check PPS signal */
-	pps_dec_valid();
+	pps_dec_valid(ntpdata);
=20
-	if (!time_adjust)
+	if (!ntpdata->time_adjust)
 		goto out;
=20
-	if (time_adjust > MAX_TICKADJ) {
-		time_adjust -=3D MAX_TICKADJ;
-		tick_length +=3D MAX_TICKADJ_SCALED;
+	if (ntpdata->time_adjust > MAX_TICKADJ) {
+		ntpdata->time_adjust -=3D MAX_TICKADJ;
+		ntpdata->tick_length +=3D MAX_TICKADJ_SCALED;
 		goto out;
 	}
=20
-	if (time_adjust < -MAX_TICKADJ) {
-		time_adjust +=3D MAX_TICKADJ;
-		tick_length -=3D MAX_TICKADJ_SCALED;
+	if (ntpdata->time_adjust < -MAX_TICKADJ) {
+		ntpdata->time_adjust +=3D MAX_TICKADJ;
+		ntpdata->tick_length -=3D MAX_TICKADJ_SCALED;
 		goto out;
 	}
=20
-	tick_length +=3D (s64)(time_adjust * NSEC_PER_USEC / NTP_INTERVAL_FREQ)
-							 << NTP_SCALE_SHIFT;
-	time_adjust =3D 0;
+	ntpdata->tick_length +=3D (s64)(ntpdata->time_adjust * NSEC_PER_USEC / NTP_=
INTERVAL_FREQ)
+				<< NTP_SCALE_SHIFT;
+	ntpdata->time_adjust =3D 0;
=20
 out:
 	return leap;
@@ -611,6 +599,15 @@ static inline int update_rtc(struct timespec64 *to_set, =
unsigned long *offset_ns
 }
 #endif
=20
+/**
+ * ntp_synced - Tells whether the NTP status is not UNSYNC
+ * Returns:	true if not UNSYNC, false otherwise
+ */
+static inline bool ntp_synced(void)
+{
+	return !(tk_ntp_data.time_status & STA_UNSYNC);
+}
+
 /*
  * If we have an externally synchronized Linux clock, then update RTC clock
  * accordingly every ~11 minutes. Generally RTCs can only store second
@@ -691,162 +688,156 @@ static inline void __init ntp_init_cmos_sync(void) { }
 /*
  * Propagate a new txc->status value into the NTP state:
  */
-static inline void process_adj_status(const struct __kernel_timex *txc)
+static inline void process_adj_status(struct ntp_data *ntpdata, const struct=
 __kernel_timex *txc)
 {
-	if ((time_status & STA_PLL) && !(txc->status & STA_PLL)) {
-		time_state =3D TIME_OK;
-		time_status =3D STA_UNSYNC;
-		ntp_next_leap_sec =3D TIME64_MAX;
-		/* restart PPS frequency calibration */
-		pps_reset_freq_interval();
+	if ((ntpdata->time_status & STA_PLL) && !(txc->status & STA_PLL)) {
+		ntpdata->time_state =3D TIME_OK;
+		ntpdata->time_status =3D STA_UNSYNC;
+		ntpdata->ntp_next_leap_sec =3D TIME64_MAX;
+		/* Restart PPS frequency calibration */
+		pps_reset_freq_interval(ntpdata);
 	}
=20
 	/*
 	 * If we turn on PLL adjustments then reset the
 	 * reference time to current time.
 	 */
-	if (!(time_status & STA_PLL) && (txc->status & STA_PLL))
-		time_reftime =3D __ktime_get_real_seconds();
+	if (!(ntpdata->time_status & STA_PLL) && (txc->status & STA_PLL))
+		ntpdata->time_reftime =3D __ktime_get_real_seconds();
=20
 	/* only set allowed bits */
-	time_status &=3D STA_RONLY;
-	time_status |=3D txc->status & ~STA_RONLY;
+	ntpdata->time_status &=3D STA_RONLY;
+	ntpdata->time_status |=3D txc->status & ~STA_RONLY;
 }
=20
-
-static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
+static inline void process_adjtimex_modes(struct ntp_data *ntpdata, const st=
ruct __kernel_timex *txc,
 					  s32 *time_tai)
 {
 	if (txc->modes & ADJ_STATUS)
-		process_adj_status(txc);
+		process_adj_status(ntpdata, txc);
=20
 	if (txc->modes & ADJ_NANO)
-		time_status |=3D STA_NANO;
+		ntpdata->time_status |=3D STA_NANO;
=20
 	if (txc->modes & ADJ_MICRO)
-		time_status &=3D ~STA_NANO;
+		ntpdata->time_status &=3D ~STA_NANO;
=20
 	if (txc->modes & ADJ_FREQUENCY) {
-		time_freq =3D txc->freq * PPM_SCALE;
-		time_freq =3D min(time_freq, MAXFREQ_SCALED);
-		time_freq =3D max(time_freq, -MAXFREQ_SCALED);
-		/* update pps_freq */
-		pps_set_freq(time_freq);
+		ntpdata->time_freq =3D txc->freq * PPM_SCALE;
+		ntpdata->time_freq =3D min(ntpdata->time_freq, MAXFREQ_SCALED);
+		ntpdata->time_freq =3D max(ntpdata->time_freq, -MAXFREQ_SCALED);
+		/* Update pps_freq */
+		pps_set_freq(ntpdata);
 	}
=20
 	if (txc->modes & ADJ_MAXERROR)
-		time_maxerror =3D clamp(txc->maxerror, 0, NTP_PHASE_LIMIT);
+		ntpdata->time_maxerror =3D clamp(txc->maxerror, 0, NTP_PHASE_LIMIT);
=20
 	if (txc->modes & ADJ_ESTERROR)
-		time_esterror =3D clamp(txc->esterror, 0, NTP_PHASE_LIMIT);
+		ntpdata->time_esterror =3D clamp(txc->esterror, 0, NTP_PHASE_LIMIT);
=20
 	if (txc->modes & ADJ_TIMECONST) {
-		time_constant =3D clamp(txc->constant, 0, MAXTC);
-		if (!(time_status & STA_NANO))
-			time_constant +=3D 4;
-		time_constant =3D clamp(time_constant, 0, MAXTC);
+		ntpdata->time_constant =3D clamp(txc->constant, 0, MAXTC);
+		if (!(ntpdata->time_status & STA_NANO))
+			ntpdata->time_constant +=3D 4;
+		ntpdata->time_constant =3D clamp(ntpdata->time_constant, 0, MAXTC);
 	}
=20
-	if (txc->modes & ADJ_TAI &&
-			txc->constant >=3D 0 && txc->constant <=3D MAX_TAI_OFFSET)
+	if (txc->modes & ADJ_TAI && txc->constant >=3D 0 && txc->constant <=3D MAX_=
TAI_OFFSET)
 		*time_tai =3D txc->constant;
=20
 	if (txc->modes & ADJ_OFFSET)
-		ntp_update_offset(txc->offset);
+		ntp_update_offset(ntpdata, txc->offset);
=20
 	if (txc->modes & ADJ_TICK)
-		tick_usec =3D txc->tick;
+		ntpdata->tick_usec =3D txc->tick;
=20
 	if (txc->modes & (ADJ_TICK|ADJ_FREQUENCY|ADJ_OFFSET))
-		ntp_update_frequency();
+		ntp_update_frequency(ntpdata);
 }
=20
-
 /*
- * adjtimex mainly allows reading (and writing, if superuser) of
+ * adjtimex() mainly allows reading (and writing, if superuser) of
  * kernel time-keeping variables. used by xntpd.
  */
 int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 		  s32 *time_tai, struct audit_ntp_data *ad)
 {
+	struct ntp_data *ntpdata =3D &tk_ntp_data;
 	int result;
=20
 	if (txc->modes & ADJ_ADJTIME) {
-		long save_adjust =3D time_adjust;
+		long save_adjust =3D ntpdata->time_adjust;
=20
 		if (!(txc->modes & ADJ_OFFSET_READONLY)) {
 			/* adjtime() is independent from ntp_adjtime() */
-			time_adjust =3D txc->offset;
-			ntp_update_frequency();
+			ntpdata->time_adjust =3D txc->offset;
+			ntp_update_frequency(ntpdata);
=20
 			audit_ntp_set_old(ad, AUDIT_NTP_ADJUST,	save_adjust);
-			audit_ntp_set_new(ad, AUDIT_NTP_ADJUST,	time_adjust);
+			audit_ntp_set_new(ad, AUDIT_NTP_ADJUST,	ntpdata->time_adjust);
 		}
 		txc->offset =3D save_adjust;
 	} else {
 		/* If there are input parameters, then process them: */
 		if (txc->modes) {
-			audit_ntp_set_old(ad, AUDIT_NTP_OFFSET,	time_offset);
-			audit_ntp_set_old(ad, AUDIT_NTP_FREQ,	time_freq);
-			audit_ntp_set_old(ad, AUDIT_NTP_STATUS,	time_status);
+			audit_ntp_set_old(ad, AUDIT_NTP_OFFSET,	ntpdata->time_offset);
+			audit_ntp_set_old(ad, AUDIT_NTP_FREQ,	ntpdata->time_freq);
+			audit_ntp_set_old(ad, AUDIT_NTP_STATUS,	ntpdata->time_status);
 			audit_ntp_set_old(ad, AUDIT_NTP_TAI,	*time_tai);
-			audit_ntp_set_old(ad, AUDIT_NTP_TICK,	tick_usec);
+			audit_ntp_set_old(ad, AUDIT_NTP_TICK,	ntpdata->tick_usec);
=20
-			process_adjtimex_modes(txc, time_tai);
+			process_adjtimex_modes(ntpdata, txc, time_tai);
=20
-			audit_ntp_set_new(ad, AUDIT_NTP_OFFSET,	time_offset);
-			audit_ntp_set_new(ad, AUDIT_NTP_FREQ,	time_freq);
-			audit_ntp_set_new(ad, AUDIT_NTP_STATUS,	time_status);
+			audit_ntp_set_new(ad, AUDIT_NTP_OFFSET,	ntpdata->time_offset);
+			audit_ntp_set_new(ad, AUDIT_NTP_FREQ,	ntpdata->time_freq);
+			audit_ntp_set_new(ad, AUDIT_NTP_STATUS,	ntpdata->time_status);
 			audit_ntp_set_new(ad, AUDIT_NTP_TAI,	*time_tai);
-			audit_ntp_set_new(ad, AUDIT_NTP_TICK,	tick_usec);
+			audit_ntp_set_new(ad, AUDIT_NTP_TICK,	ntpdata->tick_usec);
 		}
=20
-		txc->offset =3D shift_right(time_offset * NTP_INTERVAL_FREQ,
-				  NTP_SCALE_SHIFT);
-		if (!(time_status & STA_NANO))
+		txc->offset =3D shift_right(ntpdata->time_offset * NTP_INTERVAL_FREQ, NTP_=
SCALE_SHIFT);
+		if (!(ntpdata->time_status & STA_NANO))
 			txc->offset =3D (u32)txc->offset / NSEC_PER_USEC;
 	}
=20
-	result =3D time_state;	/* mostly `TIME_OK' */
-	/* check for errors */
-	if (is_error_status(time_status))
+	result =3D ntpdata->time_state;
+	if (is_error_status(ntpdata->time_status))
 		result =3D TIME_ERROR;
=20
-	txc->freq	   =3D shift_right((time_freq >> PPM_SCALE_INV_SHIFT) *
+	txc->freq	   =3D shift_right((ntpdata->time_freq >> PPM_SCALE_INV_SHIFT) *
 					 PPM_SCALE_INV, NTP_SCALE_SHIFT);
-	txc->maxerror	   =3D time_maxerror;
-	txc->esterror	   =3D time_esterror;
-	txc->status	   =3D time_status;
-	txc->constant	   =3D time_constant;
+	txc->maxerror	   =3D ntpdata->time_maxerror;
+	txc->esterror	   =3D ntpdata->time_esterror;
+	txc->status	   =3D ntpdata->time_status;
+	txc->constant	   =3D ntpdata->time_constant;
 	txc->precision	   =3D 1;
 	txc->tolerance	   =3D MAXFREQ_SCALED / PPM_SCALE;
-	txc->tick	   =3D tick_usec;
+	txc->tick	   =3D ntpdata->tick_usec;
 	txc->tai	   =3D *time_tai;
=20
-	/* fill PPS status fields */
-	pps_fill_timex(txc);
+	/* Fill PPS status fields */
+	pps_fill_timex(ntpdata, txc);
=20
 	txc->time.tv_sec =3D ts->tv_sec;
 	txc->time.tv_usec =3D ts->tv_nsec;
-	if (!(time_status & STA_NANO))
+	if (!(ntpdata->time_status & STA_NANO))
 		txc->time.tv_usec =3D ts->tv_nsec / NSEC_PER_USEC;
=20
 	/* Handle leapsec adjustments */
-	if (unlikely(ts->tv_sec >=3D ntp_next_leap_sec)) {
-		if ((time_state =3D=3D TIME_INS) && (time_status & STA_INS)) {
+	if (unlikely(ts->tv_sec >=3D ntpdata->ntp_next_leap_sec)) {
+		if ((ntpdata->time_state =3D=3D TIME_INS) && (ntpdata->time_status & STA_I=
NS)) {
 			result =3D TIME_OOP;
 			txc->tai++;
 			txc->time.tv_sec--;
 		}
-		if ((time_state =3D=3D TIME_DEL) && (time_status & STA_DEL)) {
+		if ((ntpdata->time_state =3D=3D TIME_DEL) && (ntpdata->time_status & STA_D=
EL)) {
 			result =3D TIME_WAIT;
 			txc->tai--;
 			txc->time.tv_sec++;
 		}
-		if ((time_state =3D=3D TIME_OOP) &&
-					(ts->tv_sec =3D=3D ntp_next_leap_sec)) {
+		if ((ntpdata->time_state =3D=3D TIME_OOP) && (ts->tv_sec =3D=3D ntpdata->n=
tp_next_leap_sec))
 			result =3D TIME_WAIT;
-		}
 	}
=20
 	return result;
@@ -854,17 +845,21 @@ int __do_adjtimex(struct __kernel_timex *txc, const str=
uct timespec64 *ts,
=20
 #ifdef	CONFIG_NTP_PPS
=20
-/* actually struct pps_normtime is good old struct timespec, but it is
+/*
+ * struct pps_normtime is basically a struct timespec, but it is
  * semantically different (and it is the reason why it was invented):
  * pps_normtime.nsec has a range of ( -NSEC_PER_SEC / 2, NSEC_PER_SEC / 2 ]
- * while timespec.tv_nsec has a range of [0, NSEC_PER_SEC) */
+ * while timespec.tv_nsec has a range of [0, NSEC_PER_SEC)
+ */
 struct pps_normtime {
 	s64		sec;	/* seconds */
 	long		nsec;	/* nanoseconds */
 };
=20
-/* normalize the timestamp so that nsec is in the
-   ( -NSEC_PER_SEC / 2, NSEC_PER_SEC / 2 ] interval */
+/*
+ * Normalize the timestamp so that nsec is in the
+ * [ -NSEC_PER_SEC / 2, NSEC_PER_SEC / 2 ] interval
+ */
 static inline struct pps_normtime pps_normalize_ts(struct timespec64 ts)
 {
 	struct pps_normtime norm =3D {
@@ -880,54 +875,57 @@ static inline struct pps_normtime pps_normalize_ts(stru=
ct timespec64 ts)
 	return norm;
 }
=20
-/* get current phase correction and jitter */
-static inline long pps_phase_filter_get(long *jitter)
+/* Get current phase correction and jitter */
+static inline long pps_phase_filter_get(struct ntp_data *ntpdata, long *jitt=
er)
 {
-	*jitter =3D pps_tf[0] - pps_tf[1];
+	*jitter =3D ntpdata->pps_tf[0] - ntpdata->pps_tf[1];
 	if (*jitter < 0)
 		*jitter =3D -*jitter;
=20
 	/* TODO: test various filters */
-	return pps_tf[0];
+	return ntpdata->pps_tf[0];
 }
=20
-/* add the sample to the phase filter */
-static inline void pps_phase_filter_add(long err)
+/* Add the sample to the phase filter */
+static inline void pps_phase_filter_add(struct ntp_data *ntpdata, long err)
 {
-	pps_tf[2] =3D pps_tf[1];
-	pps_tf[1] =3D pps_tf[0];
-	pps_tf[0] =3D err;
+	ntpdata->pps_tf[2] =3D ntpdata->pps_tf[1];
+	ntpdata->pps_tf[1] =3D ntpdata->pps_tf[0];
+	ntpdata->pps_tf[0] =3D err;
 }
=20
-/* decrease frequency calibration interval length.
- * It is halved after four consecutive unstable intervals.
+/*
+ * Decrease frequency calibration interval length. It is halved after four
+ * consecutive unstable intervals.
  */
-static inline void pps_dec_freq_interval(void)
+static inline void pps_dec_freq_interval(struct ntp_data *ntpdata)
 {
-	if (--pps_intcnt <=3D -PPS_INTCOUNT) {
-		pps_intcnt =3D -PPS_INTCOUNT;
-		if (pps_shift > PPS_INTMIN) {
-			pps_shift--;
-			pps_intcnt =3D 0;
+	if (--ntpdata->pps_intcnt <=3D -PPS_INTCOUNT) {
+		ntpdata->pps_intcnt =3D -PPS_INTCOUNT;
+		if (ntpdata->pps_shift > PPS_INTMIN) {
+			ntpdata->pps_shift--;
+			ntpdata->pps_intcnt =3D 0;
 		}
 	}
 }
=20
-/* increase frequency calibration interval length.
- * It is doubled after four consecutive stable intervals.
+/*
+ * Increase frequency calibration interval length. It is doubled after
+ * four consecutive stable intervals.
  */
-static inline void pps_inc_freq_interval(void)
+static inline void pps_inc_freq_interval(struct ntp_data *ntpdata)
 {
-	if (++pps_intcnt >=3D PPS_INTCOUNT) {
-		pps_intcnt =3D PPS_INTCOUNT;
-		if (pps_shift < PPS_INTMAX) {
-			pps_shift++;
-			pps_intcnt =3D 0;
+	if (++ntpdata->pps_intcnt >=3D PPS_INTCOUNT) {
+		ntpdata->pps_intcnt =3D PPS_INTCOUNT;
+		if (ntpdata->pps_shift < PPS_INTMAX) {
+			ntpdata->pps_shift++;
+			ntpdata->pps_intcnt =3D 0;
 		}
 	}
 }
=20
-/* update clock frequency based on MONOTONIC_RAW clock PPS signal
+/*
+ * Update clock frequency based on MONOTONIC_RAW clock PPS signal
  * timestamps
  *
  * At the end of the calibration interval the difference between the
@@ -936,90 +934,88 @@ static inline void pps_inc_freq_interval(void)
  * too long, the data are discarded.
  * Returns the difference between old and new frequency values.
  */
-static long hardpps_update_freq(struct pps_normtime freq_norm)
+static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtim=
e freq_norm)
 {
 	long delta, delta_mod;
 	s64 ftemp;
=20
-	/* check if the frequency interval was too long */
-	if (freq_norm.sec > (2 << pps_shift)) {
-		time_status |=3D STA_PPSERROR;
-		pps_errcnt++;
-		pps_dec_freq_interval();
-		printk_deferred(KERN_ERR
-			"hardpps: PPSERROR: interval too long - %lld s\n",
-			freq_norm.sec);
+	/* Check if the frequency interval was too long */
+	if (freq_norm.sec > (2 << ntpdata->pps_shift)) {
+		ntpdata->time_status |=3D STA_PPSERROR;
+		ntpdata->pps_errcnt++;
+		pps_dec_freq_interval(ntpdata);
+		printk_deferred(KERN_ERR "hardpps: PPSERROR: interval too long - %lld s\n",
+				freq_norm.sec);
 		return 0;
 	}
=20
-	/* here the raw frequency offset and wander (stability) is
-	 * calculated. If the wander is less than the wander threshold
-	 * the interval is increased; otherwise it is decreased.
+	/*
+	 * Here the raw frequency offset and wander (stability) is
+	 * calculated. If the wander is less than the wander threshold the
+	 * interval is increased; otherwise it is decreased.
 	 */
 	ftemp =3D div_s64(((s64)(-freq_norm.nsec)) << NTP_SCALE_SHIFT,
 			freq_norm.sec);
-	delta =3D shift_right(ftemp - pps_freq, NTP_SCALE_SHIFT);
-	pps_freq =3D ftemp;
+	delta =3D shift_right(ftemp - ntpdata->pps_freq, NTP_SCALE_SHIFT);
+	ntpdata->pps_freq =3D ftemp;
 	if (delta > PPS_MAXWANDER || delta < -PPS_MAXWANDER) {
-		printk_deferred(KERN_WARNING
-				"hardpps: PPSWANDER: change=3D%ld\n", delta);
-		time_status |=3D STA_PPSWANDER;
-		pps_stbcnt++;
-		pps_dec_freq_interval();
-	} else {	/* good sample */
-		pps_inc_freq_interval();
+		printk_deferred(KERN_WARNING "hardpps: PPSWANDER: change=3D%ld\n", delta);
+		ntpdata->time_status |=3D STA_PPSWANDER;
+		ntpdata->pps_stbcnt++;
+		pps_dec_freq_interval(ntpdata);
+	} else {
+		/* Good sample */
+		pps_inc_freq_interval(ntpdata);
 	}
=20
-	/* the stability metric is calculated as the average of recent
-	 * frequency changes, but is used only for performance
-	 * monitoring
+	/*
+	 * The stability metric is calculated as the average of recent
+	 * frequency changes, but is used only for performance monitoring
 	 */
 	delta_mod =3D delta;
 	if (delta_mod < 0)
 		delta_mod =3D -delta_mod;
-	pps_stabil +=3D (div_s64(((s64)delta_mod) <<
-				(NTP_SCALE_SHIFT - SHIFT_USEC),
-				NSEC_PER_USEC) - pps_stabil) >> PPS_INTMIN;
-
-	/* if enabled, the system clock frequency is updated */
-	if ((time_status & STA_PPSFREQ) !=3D 0 &&
-	    (time_status & STA_FREQHOLD) =3D=3D 0) {
-		time_freq =3D pps_freq;
-		ntp_update_frequency();
+	ntpdata->pps_stabil +=3D (div_s64(((s64)delta_mod) << (NTP_SCALE_SHIFT - SH=
IFT_USEC),
+				     NSEC_PER_USEC) - ntpdata->pps_stabil) >> PPS_INTMIN;
+
+	/* If enabled, the system clock frequency is updated */
+	if ((ntpdata->time_status & STA_PPSFREQ) && !(ntpdata->time_status & STA_FR=
EQHOLD)) {
+		ntpdata->time_freq =3D ntpdata->pps_freq;
+		ntp_update_frequency(ntpdata);
 	}
=20
 	return delta;
 }
=20
-/* correct REALTIME clock phase error against PPS signal */
-static void hardpps_update_phase(long error)
+/* Correct REALTIME clock phase error against PPS signal */
+static void hardpps_update_phase(struct ntp_data *ntpdata, long error)
 {
 	long correction =3D -error;
 	long jitter;
=20
-	/* add the sample to the median filter */
-	pps_phase_filter_add(correction);
-	correction =3D pps_phase_filter_get(&jitter);
+	/* Add the sample to the median filter */
+	pps_phase_filter_add(ntpdata, correction);
+	correction =3D pps_phase_filter_get(ntpdata, &jitter);
=20
-	/* Nominal jitter is due to PPS signal noise. If it exceeds the
+	/*
+	 * Nominal jitter is due to PPS signal noise. If it exceeds the
 	 * threshold, the sample is discarded; otherwise, if so enabled,
 	 * the time offset is updated.
 	 */
-	if (jitter > (pps_jitter << PPS_POPCORN)) {
-		printk_deferred(KERN_WARNING
-				"hardpps: PPSJITTER: jitter=3D%ld, limit=3D%ld\n",
-				jitter, (pps_jitter << PPS_POPCORN));
-		time_status |=3D STA_PPSJITTER;
-		pps_jitcnt++;
-	} else if (time_status & STA_PPSTIME) {
-		/* correct the time using the phase offset */
-		time_offset =3D div_s64(((s64)correction) << NTP_SCALE_SHIFT,
-				NTP_INTERVAL_FREQ);
-		/* cancel running adjtime() */
-		time_adjust =3D 0;
+	if (jitter > (ntpdata->pps_jitter << PPS_POPCORN)) {
+		printk_deferred(KERN_WARNING "hardpps: PPSJITTER: jitter=3D%ld, limit=3D%l=
d\n",
+				jitter, (ntpdata->pps_jitter << PPS_POPCORN));
+		ntpdata->time_status |=3D STA_PPSJITTER;
+		ntpdata->pps_jitcnt++;
+	} else if (ntpdata->time_status & STA_PPSTIME) {
+		/* Correct the time using the phase offset */
+		ntpdata->time_offset =3D div_s64(((s64)correction) << NTP_SCALE_SHIFT,
+					       NTP_INTERVAL_FREQ);
+		/* Cancel running adjtime() */
+		ntpdata->time_adjust =3D 0;
 	}
-	/* update jitter */
-	pps_jitter +=3D (jitter - pps_jitter) >> PPS_INTMIN;
+	/* Update jitter */
+	ntpdata->pps_jitter +=3D (jitter - ntpdata->pps_jitter) >> PPS_INTMIN;
 }
=20
 /*
@@ -1037,60 +1033,62 @@ static void hardpps_update_phase(long error)
 void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *r=
aw_ts)
 {
 	struct pps_normtime pts_norm, freq_norm;
+	struct ntp_data *ntpdata =3D &tk_ntp_data;
=20
 	pts_norm =3D pps_normalize_ts(*phase_ts);
=20
-	/* clear the error bits, they will be set again if needed */
-	time_status &=3D ~(STA_PPSJITTER | STA_PPSWANDER | STA_PPSERROR);
+	/* Clear the error bits, they will be set again if needed */
+	ntpdata->time_status &=3D ~(STA_PPSJITTER | STA_PPSWANDER | STA_PPSERROR);
=20
 	/* indicate signal presence */
-	time_status |=3D STA_PPSSIGNAL;
-	pps_valid =3D PPS_VALID;
+	ntpdata->time_status |=3D STA_PPSSIGNAL;
+	ntpdata->pps_valid =3D PPS_VALID;
=20
-	/* when called for the first time,
-	 * just start the frequency interval */
-	if (unlikely(pps_fbase.tv_sec =3D=3D 0)) {
-		pps_fbase =3D *raw_ts;
+	/*
+	 * When called for the first time, just start the frequency
+	 * interval
+	 */
+	if (unlikely(ntpdata->pps_fbase.tv_sec =3D=3D 0)) {
+		ntpdata->pps_fbase =3D *raw_ts;
 		return;
 	}
=20
-	/* ok, now we have a base for frequency calculation */
-	freq_norm =3D pps_normalize_ts(timespec64_sub(*raw_ts, pps_fbase));
-
-	/* check that the signal is in the range
-	 * [1s - MAXFREQ us, 1s + MAXFREQ us], otherwise reject it */
-	if ((freq_norm.sec =3D=3D 0) ||
-			(freq_norm.nsec > MAXFREQ * freq_norm.sec) ||
-			(freq_norm.nsec < -MAXFREQ * freq_norm.sec)) {
-		time_status |=3D STA_PPSJITTER;
-		/* restart the frequency calibration interval */
-		pps_fbase =3D *raw_ts;
+	/* Ok, now we have a base for frequency calculation */
+	freq_norm =3D pps_normalize_ts(timespec64_sub(*raw_ts, ntpdata->pps_fbase));
+
+	/*
+	 * Check that the signal is in the range
+	 * [1s - MAXFREQ us, 1s + MAXFREQ us], otherwise reject it
+	 */
+	if ((freq_norm.sec =3D=3D 0) || (freq_norm.nsec > MAXFREQ * freq_norm.sec) =
||
+	    (freq_norm.nsec < -MAXFREQ * freq_norm.sec)) {
+		ntpdata->time_status |=3D STA_PPSJITTER;
+		/* Restart the frequency calibration interval */
+		ntpdata->pps_fbase =3D *raw_ts;
 		printk_deferred(KERN_ERR "hardpps: PPSJITTER: bad pulse\n");
 		return;
 	}
=20
-	/* signal is ok */
-
-	/* check if the current frequency interval is finished */
-	if (freq_norm.sec >=3D (1 << pps_shift)) {
-		pps_calcnt++;
-		/* restart the frequency calibration interval */
-		pps_fbase =3D *raw_ts;
-		hardpps_update_freq(freq_norm);
+	/* Signal is ok. Check if the current frequency interval is finished */
+	if (freq_norm.sec >=3D (1 << ntpdata->pps_shift)) {
+		ntpdata->pps_calcnt++;
+		/* Restart the frequency calibration interval */
+		ntpdata->pps_fbase =3D *raw_ts;
+		hardpps_update_freq(ntpdata, freq_norm);
 	}
=20
-	hardpps_update_phase(pts_norm.nsec);
+	hardpps_update_phase(ntpdata, pts_norm.nsec);
=20
 }
 #endif	/* CONFIG_NTP_PPS */
=20
 static int __init ntp_tick_adj_setup(char *str)
 {
-	int rc =3D kstrtos64(str, 0, &ntp_tick_adj);
+	int rc =3D kstrtos64(str, 0, &tk_ntp_data.ntp_tick_adj);
 	if (rc)
 		return rc;
=20
-	ntp_tick_adj <<=3D NTP_SCALE_SHIFT;
+	tk_ntp_data.ntp_tick_adj <<=3D NTP_SCALE_SHIFT;
 	return 1;
 }
=20
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 6bcee4704059..50e8d04ab661 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -453,7 +453,6 @@ static void disarm_timer(struct k_itimer *timer, struct t=
ask_struct *p)
 	struct cpu_timer *ctmr =3D &timer->it.cpu;
 	struct posix_cputimer_base *base;
=20
-	timer->it_active =3D 0;
 	if (!cpu_timer_dequeue(ctmr))
 		return;
=20
@@ -494,19 +493,28 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
 		 */
 		WARN_ON_ONCE(ctmr->head || timerqueue_node_queued(&ctmr->node));
 	} else {
-		if (timer->it.cpu.firing)
+		if (timer->it.cpu.firing) {
+			/*
+			 * Prevent signal delivery. The timer cannot be dequeued
+			 * because it is on the firing list which is not protected
+			 * by sighand->lock. The delivery path is waiting for
+			 * the timer lock. So go back, unlock and retry.
+			 */
+			timer->it.cpu.firing =3D false;
 			ret =3D TIMER_RETRY;
-		else
+		} else {
 			disarm_timer(timer, p);
-
+		}
 		unlock_task_sighand(p, &flags);
 	}
=20
 out:
 	rcu_read_unlock();
-	if (!ret)
-		put_pid(ctmr->pid);
=20
+	if (!ret) {
+		put_pid(ctmr->pid);
+		timer->it_status =3D POSIX_TIMER_DISARMED;
+	}
 	return ret;
 }
=20
@@ -560,7 +568,7 @@ static void arm_timer(struct k_itimer *timer, struct task=
_struct *p)
 	struct cpu_timer *ctmr =3D &timer->it.cpu;
 	u64 newexp =3D cpu_timer_getexpires(ctmr);
=20
-	timer->it_active =3D 1;
+	timer->it_status =3D POSIX_TIMER_ARMED;
 	if (!cpu_timer_enqueue(&base->tqhead, ctmr))
 		return;
=20
@@ -586,29 +594,20 @@ static void cpu_timer_fire(struct k_itimer *timer)
 {
 	struct cpu_timer *ctmr =3D &timer->it.cpu;
=20
-	timer->it_active =3D 0;
-	if (unlikely(timer->sigq =3D=3D NULL)) {
+	timer->it_status =3D POSIX_TIMER_DISARMED;
+
+	if (unlikely(ctmr->nanosleep)) {
 		/*
 		 * This a special case for clock_nanosleep,
 		 * not a normal timer from sys_timer_create.
 		 */
 		wake_up_process(timer->it_process);
 		cpu_timer_setexpires(ctmr, 0);
-	} else if (!timer->it_interval) {
-		/*
-		 * One-shot timer.  Clear it as soon as it's fired.
-		 */
+	} else {
 		posix_timer_queue_signal(timer);
-		cpu_timer_setexpires(ctmr, 0);
-	} else if (posix_timer_queue_signal(timer)) {
-		/*
-		 * The signal did not get queued because the signal
-		 * was ignored, so we won't get any callback to
-		 * reload the timer.  But we need to keep it
-		 * ticking in case the signal is deliverable next time.
-		 */
-		posix_cpu_timer_rearm(timer);
-		++timer->it_requeue_pending;
+		/* Disable oneshot timers */
+		if (!timer->it_interval)
+			cpu_timer_setexpires(ctmr, 0);
 	}
 }
=20
@@ -667,11 +666,17 @@ static int posix_cpu_timer_set(struct k_itimer *timer, =
int timer_flags,
 	old_expires =3D cpu_timer_getexpires(ctmr);
=20
 	if (unlikely(timer->it.cpu.firing)) {
-		timer->it.cpu.firing =3D -1;
+		/*
+		 * Prevent signal delivery. The timer cannot be dequeued
+		 * because it is on the firing list which is not protected
+		 * by sighand->lock. The delivery path is waiting for
+		 * the timer lock. So go back, unlock and retry.
+		 */
+		timer->it.cpu.firing =3D false;
 		ret =3D TIMER_RETRY;
 	} else {
 		cpu_timer_dequeue(ctmr);
-		timer->it_active =3D 0;
+		timer->it_status =3D POSIX_TIMER_DISARMED;
 	}
=20
 	/*
@@ -745,7 +750,7 @@ static void __posix_cpu_timer_get(struct k_itimer *timer,=
 struct itimerspec64 *i
 	 *  - Timers which expired, but the signal has not yet been
 	 *    delivered
 	 */
-	if (iv && ((timer->it_requeue_pending & REQUEUE_PENDING) || sigev_none))
+	if (iv && timer->it_status !=3D POSIX_TIMER_ARMED)
 		expires =3D bump_cpu_timer(timer, now);
 	else
 		expires =3D cpu_timer_getexpires(&timer->it.cpu);
@@ -808,7 +813,7 @@ static u64 collect_timerqueue(struct timerqueue_head *hea=
d,
 		if (++i =3D=3D MAX_COLLECTED || now < expires)
 			return expires;
=20
-		ctmr->firing =3D 1;
+		ctmr->firing =3D true;
 		/* See posix_cpu_timer_wait_running() */
 		rcu_assign_pointer(ctmr->handling, current);
 		cpu_timer_dequeue(ctmr);
@@ -1363,7 +1368,7 @@ static void handle_posix_cpu_timers(struct task_struct =
*tsk)
 	 * timer call will interfere.
 	 */
 	list_for_each_entry_safe(timer, next, &firing, it.cpu.elist) {
-		int cpu_firing;
+		bool cpu_firing;
=20
 		/*
 		 * spin_lock() is sufficient here even independent of the
@@ -1375,13 +1380,13 @@ static void handle_posix_cpu_timers(struct task_struc=
t *tsk)
 		spin_lock(&timer->it_lock);
 		list_del_init(&timer->it.cpu.elist);
 		cpu_firing =3D timer->it.cpu.firing;
-		timer->it.cpu.firing =3D 0;
+		timer->it.cpu.firing =3D false;
 		/*
-		 * The firing flag is -1 if we collided with a reset
-		 * of the timer, which already reported this
-		 * almost-firing as an overrun.  So don't generate an event.
+		 * If the firing flag is cleared then this raced with a
+		 * timer rearm/delete operation. So don't generate an
+		 * event.
 		 */
-		if (likely(cpu_firing >=3D 0))
+		if (likely(cpu_firing))
 			cpu_timer_fire(timer);
 		/* See posix_cpu_timer_wait_running() */
 		rcu_assign_pointer(timer->it.cpu.handling, NULL);
@@ -1478,6 +1483,7 @@ static int do_cpu_nanosleep(const clockid_t which_clock=
, int flags,
 	timer.it_overrun =3D -1;
 	error =3D posix_cpu_timer_create(&timer);
 	timer.it_process =3D current;
+	timer.it.cpu.nanosleep =3D true;
=20
 	if (!error) {
 		static struct itimerspec64 zero_it;
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 4576aaed13b2..881a9ce96af7 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -233,11 +233,12 @@ __initcall(init_posix_timers);
  * The siginfo si_overrun field and the return value of timer_getoverrun(2)
  * are of type int. Clamp the overrun value to INT_MAX
  */
-static inline int timer_overrun_to_int(struct k_itimer *timr, int baseval)
+static inline int timer_overrun_to_int(struct k_itimer *timr)
 {
-	s64 sum =3D timr->it_overrun_last + (s64)baseval;
+	if (timr->it_overrun_last > (s64)INT_MAX)
+		return INT_MAX;
=20
-	return sum > (s64)INT_MAX ? INT_MAX : (int)sum;
+	return (int)timr->it_overrun_last;
 }
=20
 static void common_hrtimer_rearm(struct k_itimer *timr)
@@ -249,62 +250,62 @@ static void common_hrtimer_rearm(struct k_itimer *timr)
 	hrtimer_restart(timer);
 }
=20
+static bool __posixtimer_deliver_signal(struct kernel_siginfo *info, struct =
k_itimer *timr)
+{
+	guard(spinlock)(&timr->it_lock);
+
+	/*
+	 * Check if the timer is still alive or whether it got modified
+	 * since the signal was queued. In either case, don't rearm and
+	 * drop the signal.
+	 */
+	if (timr->it_signal_seq !=3D timr->it_sigqueue_seq || WARN_ON_ONCE(!timr->i=
t_signal))
+		return false;
+
+	if (!timr->it_interval || WARN_ON_ONCE(timr->it_status !=3D POSIX_TIMER_REQ=
UEUE_PENDING))
+		return true;
+
+	timr->kclock->timer_rearm(timr);
+	timr->it_status =3D POSIX_TIMER_ARMED;
+	timr->it_overrun_last =3D timr->it_overrun;
+	timr->it_overrun =3D -1LL;
+	++timr->it_signal_seq;
+	info->si_overrun =3D timer_overrun_to_int(timr);
+	return true;
+}
+
 /*
- * This function is called from the signal delivery code if
- * info->si_sys_private is not zero, which indicates that the timer has to
- * be rearmed. Restart the timer and update info::si_overrun.
+ * This function is called from the signal delivery code. It decides
+ * whether the signal should be dropped and rearms interval timers.  The
+ * timer can be unconditionally accessed as there is a reference held on
+ * it.
  */
-void posixtimer_rearm(struct kernel_siginfo *info)
+bool posixtimer_deliver_signal(struct kernel_siginfo *info, struct sigqueue =
*timer_sigq)
 {
-	struct k_itimer *timr;
-	unsigned long flags;
-
-	timr =3D lock_timer(info->si_tid, &flags);
-	if (!timr)
-		return;
+	struct k_itimer *timr =3D container_of(timer_sigq, struct k_itimer, sigq);
+	bool ret;
=20
-	if (timr->it_interval && timr->it_requeue_pending =3D=3D info->si_sys_priva=
te) {
-		timr->kclock->timer_rearm(timr);
+	/*
+	 * Release siglock to ensure proper locking order versus
+	 * timr::it_lock. Keep interrupts disabled.
+	 */
+	spin_unlock(&current->sighand->siglock);
=20
-		timr->it_active =3D 1;
-		timr->it_overrun_last =3D timr->it_overrun;
-		timr->it_overrun =3D -1LL;
-		++timr->it_requeue_pending;
+	ret =3D __posixtimer_deliver_signal(info, timr);
=20
-		info->si_overrun =3D timer_overrun_to_int(timr, info->si_overrun);
-	}
+	/* Drop the reference which was acquired when the signal was queued */
+	posixtimer_putref(timr);
=20
-	unlock_timer(timr, flags);
+	spin_lock(&current->sighand->siglock);
+	return ret;
 }
=20
-int posix_timer_queue_signal(struct k_itimer *timr)
+void posix_timer_queue_signal(struct k_itimer *timr)
 {
-	int ret, si_private =3D 0;
-	enum pid_type type;
-
 	lockdep_assert_held(&timr->it_lock);
=20
-	timr->it_active =3D 0;
-	if (timr->it_interval)
-		si_private =3D ++timr->it_requeue_pending;
-
-	/*
-	 * FIXME: if ->sigq is queued we can race with
-	 * dequeue_signal()->posixtimer_rearm().
-	 *
-	 * If dequeue_signal() sees the "right" value of
-	 * si_sys_private it calls posixtimer_rearm().
-	 * We re-queue ->sigq and drop ->it_lock().
-	 * posixtimer_rearm() locks the timer
-	 * and re-schedules it while ->sigq is pending.
-	 * Not really bad, but not that we want.
-	 */
-	timr->sigq->info.si_sys_private =3D si_private;
-
-	type =3D !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYP=
E_PID;
-	ret =3D send_sigqueue(timr->sigq, timr->it_pid, type);
-	/* If we failed to send the signal the timer stops. */
-	return ret > 0;
+	timr->it_status =3D timr->it_interval ? POSIX_TIMER_REQUEUE_PENDING : POSIX=
_TIMER_DISARMED;
+	posixtimer_send_sigqueue(timr);
 }
=20
 /*
@@ -317,62 +318,10 @@ int posix_timer_queue_signal(struct k_itimer *timr)
 static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 {
 	struct k_itimer *timr =3D container_of(timer, struct k_itimer, it.real.time=
r);
-	enum hrtimer_restart ret =3D HRTIMER_NORESTART;
-	unsigned long flags;
-
-	spin_lock_irqsave(&timr->it_lock, flags);
-
-	if (posix_timer_queue_signal(timr)) {
-		/*
-		 * The signal was not queued due to SIG_IGN. As a
-		 * consequence the timer is not going to be rearmed from
-		 * the signal delivery path. But as a real signal handler
-		 * can be installed later the timer must be rearmed here.
-		 */
-		if (timr->it_interval !=3D 0) {
-			ktime_t now =3D hrtimer_cb_get_time(timer);
-
-			/*
-			 * FIXME: What we really want, is to stop this
-			 * timer completely and restart it in case the
-			 * SIG_IGN is removed. This is a non trivial
-			 * change to the signal handling code.
-			 *
-			 * For now let timers with an interval less than a
-			 * jiffy expire every jiffy and recheck for a
-			 * valid signal handler.
-			 *
-			 * This avoids interrupt starvation in case of a
-			 * very small interval, which would expire the
-			 * timer immediately again.
-			 *
-			 * Moving now ahead of time by one jiffy tricks
-			 * hrtimer_forward() to expire the timer later,
-			 * while it still maintains the overrun accuracy
-			 * for the price of a slight inconsistency in the
-			 * timer_gettime() case. This is at least better
-			 * than a timer storm.
-			 *
-			 * Only required when high resolution timers are
-			 * enabled as the periodic tick based timers are
-			 * automatically aligned to the next tick.
-			 */
-			if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS)) {
-				ktime_t kj =3D TICK_NSEC;
-
-				if (timr->it_interval < kj)
-					now =3D ktime_add(now, kj);
-			}
-
-			timr->it_overrun +=3D hrtimer_forward(timer, now, timr->it_interval);
-			ret =3D HRTIMER_RESTART;
-			++timr->it_requeue_pending;
-			timr->it_active =3D 1;
-		}
-	}
=20
-	unlock_timer(timr, flags);
-	return ret;
+	guard(spinlock_irqsave)(&timr->it_lock);
+	posix_timer_queue_signal(timr);
+	return HRTIMER_NORESTART;
 }
=20
 static struct pid *good_sigevent(sigevent_t * event)
@@ -399,32 +348,27 @@ static struct pid *good_sigevent(sigevent_t * event)
 	}
 }
=20
-static struct k_itimer * alloc_posix_timer(void)
+static struct k_itimer *alloc_posix_timer(void)
 {
 	struct k_itimer *tmr =3D kmem_cache_zalloc(posix_timers_cache, GFP_KERNEL);
=20
 	if (!tmr)
 		return tmr;
-	if (unlikely(!(tmr->sigq =3D sigqueue_alloc()))) {
+
+	if (unlikely(!posixtimer_init_sigqueue(&tmr->sigq))) {
 		kmem_cache_free(posix_timers_cache, tmr);
 		return NULL;
 	}
-	clear_siginfo(&tmr->sigq->info);
+	rcuref_init(&tmr->rcuref, 1);
 	return tmr;
 }
=20
-static void k_itimer_rcu_free(struct rcu_head *head)
-{
-	struct k_itimer *tmr =3D container_of(head, struct k_itimer, rcu);
-
-	kmem_cache_free(posix_timers_cache, tmr);
-}
-
-static void posix_timer_free(struct k_itimer *tmr)
+void posixtimer_free_timer(struct k_itimer *tmr)
 {
 	put_pid(tmr->it_pid);
-	sigqueue_free(tmr->sigq);
-	call_rcu(&tmr->rcu, k_itimer_rcu_free);
+	if (tmr->sigq.ucounts)
+		dec_rlimit_put_ucounts(tmr->sigq.ucounts, UCOUNT_RLIMIT_SIGPENDING);
+	kfree_rcu(tmr, rcu);
 }
=20
 static void posix_timer_unhash_and_free(struct k_itimer *tmr)
@@ -432,7 +376,7 @@ static void posix_timer_unhash_and_free(struct k_itimer *=
tmr)
 	spin_lock(&hash_lock);
 	hlist_del_rcu(&tmr->t_hash);
 	spin_unlock(&hash_lock);
-	posix_timer_free(tmr);
+	posixtimer_putref(tmr);
 }
=20
 static int common_timer_create(struct k_itimer *new_timer)
@@ -467,7 +411,7 @@ static int do_timer_create(clockid_t which_clock, struct =
sigevent *event,
 	 */
 	new_timer_id =3D posix_timer_add(new_timer);
 	if (new_timer_id < 0) {
-		posix_timer_free(new_timer);
+		posixtimer_free_timer(new_timer);
 		return new_timer_id;
 	}
=20
@@ -485,18 +429,23 @@ static int do_timer_create(clockid_t which_clock, struc=
t sigevent *event,
 			goto out;
 		}
 		new_timer->it_sigev_notify     =3D event->sigev_notify;
-		new_timer->sigq->info.si_signo =3D event->sigev_signo;
-		new_timer->sigq->info.si_value =3D event->sigev_value;
+		new_timer->sigq.info.si_signo =3D event->sigev_signo;
+		new_timer->sigq.info.si_value =3D event->sigev_value;
 	} else {
 		new_timer->it_sigev_notify     =3D SIGEV_SIGNAL;
-		new_timer->sigq->info.si_signo =3D SIGALRM;
-		memset(&new_timer->sigq->info.si_value, 0, sizeof(sigval_t));
-		new_timer->sigq->info.si_value.sival_int =3D new_timer->it_id;
+		new_timer->sigq.info.si_signo =3D SIGALRM;
+		memset(&new_timer->sigq.info.si_value, 0, sizeof(sigval_t));
+		new_timer->sigq.info.si_value.sival_int =3D new_timer->it_id;
 		new_timer->it_pid =3D get_pid(task_tgid(current));
 	}
=20
-	new_timer->sigq->info.si_tid   =3D new_timer->it_id;
-	new_timer->sigq->info.si_code  =3D SI_TIMER;
+	if (new_timer->it_sigev_notify & SIGEV_THREAD_ID)
+		new_timer->it_pid_type =3D PIDTYPE_PID;
+	else
+		new_timer->it_pid_type =3D PIDTYPE_TGID;
+
+	new_timer->sigq.info.si_tid =3D new_timer->it_id;
+	new_timer->sigq.info.si_code =3D SI_TIMER;
=20
 	if (copy_to_user(created_timer_id, &new_timer_id, sizeof (new_timer_id))) {
 		error =3D -EFAULT;
@@ -580,7 +529,14 @@ static struct k_itimer *__lock_timer(timer_t timer_id, u=
nsigned long *flags)
 	 *  1) Set timr::it_signal to NULL with timr::it_lock held
 	 *  2) Release timr::it_lock
 	 *  3) Remove from the hash under hash_lock
-	 *  4) Call RCU for removal after the grace period
+	 *  4) Put the reference count.
+	 *
+	 * The reference count might not drop to zero if timr::sigq is
+	 * queued. In that case the signal delivery or flush will put the
+	 * last reference count.
+	 *
+	 * When the reference count reaches zero, the timer is scheduled
+	 * for RCU removal after the grace period.
 	 *
 	 * Holding rcu_read_lock() accross the lookup ensures that
 	 * the timer cannot be freed.
@@ -647,10 +603,10 @@ void common_timer_get(struct k_itimer *timr, struct iti=
merspec64 *cur_setting)
 	/* interval timer ? */
 	if (iv) {
 		cur_setting->it_interval =3D ktime_to_timespec64(iv);
-	} else if (!timr->it_active) {
+	} else if (timr->it_status =3D=3D POSIX_TIMER_DISARMED) {
 		/*
 		 * SIGEV_NONE oneshot timers are never queued and therefore
-		 * timr->it_active is always false. The check below
+		 * timr->it_status is always DISARMED. The check below
 		 * vs. remaining time will handle this case.
 		 *
 		 * For all other timers there is nothing to update here, so
@@ -667,7 +623,7 @@ void common_timer_get(struct k_itimer *timr, struct itime=
rspec64 *cur_setting)
 	 * is a SIGEV_NONE timer move the expiry time forward by intervals,
 	 * so expiry is > now.
 	 */
-	if (iv && (timr->it_requeue_pending & REQUEUE_PENDING || sig_none))
+	if (iv && timr->it_status !=3D POSIX_TIMER_ARMED)
 		timr->it_overrun +=3D kc->timer_forward(timr, now);
=20
 	remaining =3D kc->timer_remaining(timr, now);
@@ -775,7 +731,7 @@ SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 	if (!timr)
 		return -EINVAL;
=20
-	overrun =3D timer_overrun_to_int(timr, 0);
+	overrun =3D timer_overrun_to_int(timr);
 	unlock_timer(timr, flags);
=20
 	return overrun;
@@ -867,8 +823,6 @@ void posix_timer_set_common(struct k_itimer *timer, struc=
t itimerspec64 *new_set
 	else
 		timer->it_interval =3D 0;
=20
-	/* Prevent reloading in case there is a signal pending */
-	timer->it_requeue_pending =3D (timer->it_requeue_pending + 2) & ~REQUEUE_PE=
NDING;
 	/* Reset overrun accounting */
 	timer->it_overrun_last =3D 0;
 	timer->it_overrun =3D -1LL;
@@ -886,8 +840,6 @@ int common_timer_set(struct k_itimer *timr, int flags,
 	if (old_setting)
 		common_timer_get(timr, old_setting);
=20
-	/* Prevent rearming by clearing the interval */
-	timr->it_interval =3D 0;
 	/*
 	 * Careful here. On SMP systems the timer expiry function could be
 	 * active and spinning on timr->it_lock.
@@ -895,7 +847,7 @@ int common_timer_set(struct k_itimer *timr, int flags,
 	if (kc->timer_try_to_cancel(timr) < 0)
 		return TIMER_RETRY;
=20
-	timr->it_active =3D 0;
+	timr->it_status =3D POSIX_TIMER_DISARMED;
 	posix_timer_set_common(timr, new_setting);
=20
 	/* Keep timer disarmed when it_value is zero */
@@ -908,7 +860,8 @@ int common_timer_set(struct k_itimer *timr, int flags,
 	sigev_none =3D timr->it_sigev_notify =3D=3D SIGEV_NONE;
=20
 	kc->timer_arm(timr, expires, flags & TIMER_ABSTIME, sigev_none);
-	timr->it_active =3D !sigev_none;
+	if (!sigev_none)
+		timr->it_status =3D POSIX_TIMER_ARMED;
 	return 0;
 }
=20
@@ -936,6 +889,9 @@ static int do_timer_settime(timer_t timer_id, int tmr_fla=
gs,
 	if (old_spec64)
 		old_spec64->it_interval =3D ktime_to_timespec64(timr->it_interval);
=20
+	/* Prevent signal delivery and rearming. */
+	timr->it_signal_seq++;
+
 	kc =3D timr->kclock;
 	if (WARN_ON_ONCE(!kc || !kc->timer_set))
 		error =3D -EINVAL;
@@ -1004,17 +960,31 @@ int common_timer_del(struct k_itimer *timer)
 {
 	const struct k_clock *kc =3D timer->kclock;
=20
-	timer->it_interval =3D 0;
 	if (kc->timer_try_to_cancel(timer) < 0)
 		return TIMER_RETRY;
-	timer->it_active =3D 0;
+	timer->it_status =3D POSIX_TIMER_DISARMED;
 	return 0;
 }
=20
+/*
+ * If the deleted timer is on the ignored list, remove it and
+ * drop the associated reference.
+ */
+static inline void posix_timer_cleanup_ignored(struct k_itimer *tmr)
+{
+	if (!hlist_unhashed(&tmr->ignored_list)) {
+		hlist_del_init(&tmr->ignored_list);
+		posixtimer_putref(tmr);
+	}
+}
+
 static inline int timer_delete_hook(struct k_itimer *timer)
 {
 	const struct k_clock *kc =3D timer->kclock;
=20
+	/* Prevent signal delivery and rearming. */
+	timer->it_signal_seq++;
+
 	if (WARN_ON_ONCE(!kc || !kc->timer_del))
 		return -EINVAL;
 	return kc->timer_del(timer);
@@ -1040,12 +1010,18 @@ SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
=20
 	spin_lock(&current->sighand->siglock);
 	hlist_del(&timer->list);
-	spin_unlock(&current->sighand->siglock);
+	posix_timer_cleanup_ignored(timer);
 	/*
 	 * A concurrent lookup could check timer::it_signal lockless. It
 	 * will reevaluate with timer::it_lock held and observe the NULL.
+	 *
+	 * It must be written with siglock held so that the signal code
+	 * observes timer->it_signal =3D=3D NULL in do_sigaction(SIG_IGN),
+	 * which prevents it from moving a pending signal of a deleted
+	 * timer to the ignore list.
 	 */
 	WRITE_ONCE(timer->it_signal, NULL);
+	spin_unlock(&current->sighand->siglock);
=20
 	unlock_timer(timer, flags);
 	posix_timer_unhash_and_free(timer);
@@ -1091,6 +1067,8 @@ static void itimer_delete(struct k_itimer *timer)
 	}
 	hlist_del(&timer->list);
=20
+	posix_timer_cleanup_ignored(timer);
+
 	/*
 	 * Setting timer::it_signal to NULL is technically not required
 	 * here as nothing can access the timer anymore legitimately via
@@ -1123,6 +1101,19 @@ void exit_itimers(struct task_struct *tsk)
 	/* The timers are not longer accessible via tsk::signal */
 	while (!hlist_empty(&timers))
 		itimer_delete(hlist_entry(timers.first, struct k_itimer, list));
+
+	/*
+	 * There should be no timers on the ignored list. itimer_delete() has
+	 * mopped them up.
+	 */
+	if (!WARN_ON_ONCE(!hlist_empty(&tsk->signal->ignored_posix_timers)))
+		return;
+
+	hlist_move_list(&tsk->signal->ignored_posix_timers, &timers);
+	while (!hlist_empty(&timers)) {
+		posix_timer_cleanup_ignored(hlist_entry(timers.first, struct k_itimer,
+							ignored_list));
+	}
 }
=20
 SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index 4784ea65f685..61906f0688c1 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -1,6 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #define TIMER_RETRY 1
=20
+enum posix_timer_state {
+	POSIX_TIMER_DISARMED,
+	POSIX_TIMER_ARMED,
+	POSIX_TIMER_REQUEUE_PENDING,
+};
+
 struct k_clock {
 	int	(*clock_getres)(const clockid_t which_clock,
 				struct timespec64 *tp);
@@ -36,7 +42,7 @@ extern const struct k_clock clock_process;
 extern const struct k_clock clock_thread;
 extern const struct k_clock alarm_clock;
=20
-int posix_timer_queue_signal(struct k_itimer *timr);
+void posix_timer_queue_signal(struct k_itimer *timr);
=20
 void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_settin=
g);
 int common_timer_set(struct k_itimer *timr, int flags,
diff --git a/kernel/time/sleep_timeout.c b/kernel/time/sleep_timeout.c
new file mode 100644
index 000000000000..dfe939f6e4ec
--- /dev/null
+++ b/kernel/time/sleep_timeout.c
@@ -0,0 +1,377 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Kernel internal schedule timeout and sleeping functions
+ */
+
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/timer.h>
+#include <linux/sched/signal.h>
+#include <linux/sched/debug.h>
+
+#include "tick-internal.h"
+
+/*
+ * Since schedule_timeout()'s timer is defined on the stack, it must store
+ * the target task on the stack as well.
+ */
+struct process_timer {
+	struct timer_list timer;
+	struct task_struct *task;
+};
+
+static void process_timeout(struct timer_list *t)
+{
+	struct process_timer *timeout =3D from_timer(timeout, t, timer);
+
+	wake_up_process(timeout->task);
+}
+
+/**
+ * schedule_timeout - sleep until timeout
+ * @timeout: timeout value in jiffies
+ *
+ * Make the current task sleep until @timeout jiffies have elapsed.
+ * The function behavior depends on the current task state
+ * (see also set_current_state() description):
+ *
+ * %TASK_RUNNING - the scheduler is called, but the task does not sleep
+ * at all. That happens because sched_submit_work() does nothing for
+ * tasks in %TASK_RUNNING state.
+ *
+ * %TASK_UNINTERRUPTIBLE - at least @timeout jiffies are guaranteed to
+ * pass before the routine returns unless the current task is explicitly
+ * woken up, (e.g. by wake_up_process()).
+ *
+ * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
+ * delivered to the current task or the current task is explicitly woken
+ * up.
+ *
+ * The current task state is guaranteed to be %TASK_RUNNING when this
+ * routine returns.
+ *
+ * Specifying a @timeout value of %MAX_SCHEDULE_TIMEOUT will schedule
+ * the CPU away without a bound on the timeout. In this case the return
+ * value will be %MAX_SCHEDULE_TIMEOUT.
+ *
+ * Returns: 0 when the timer has expired otherwise the remaining time in
+ * jiffies will be returned. In all cases the return value is guaranteed
+ * to be non-negative.
+ */
+signed long __sched schedule_timeout(signed long timeout)
+{
+	struct process_timer timer;
+	unsigned long expire;
+
+	switch (timeout) {
+	case MAX_SCHEDULE_TIMEOUT:
+		/*
+		 * These two special cases are useful to be comfortable
+		 * in the caller. Nothing more. We could take
+		 * MAX_SCHEDULE_TIMEOUT from one of the negative value
+		 * but I' d like to return a valid offset (>=3D0) to allow
+		 * the caller to do everything it want with the retval.
+		 */
+		schedule();
+		goto out;
+	default:
+		/*
+		 * Another bit of PARANOID. Note that the retval will be
+		 * 0 since no piece of kernel is supposed to do a check
+		 * for a negative retval of schedule_timeout() (since it
+		 * should never happens anyway). You just have the printk()
+		 * that will tell you if something is gone wrong and where.
+		 */
+		if (timeout < 0) {
+			pr_err("%s: wrong timeout value %lx\n", __func__, timeout);
+			dump_stack();
+			__set_current_state(TASK_RUNNING);
+			goto out;
+		}
+	}
+
+	expire =3D timeout + jiffies;
+
+	timer.task =3D current;
+	timer_setup_on_stack(&timer.timer, process_timeout, 0);
+	timer.timer.expires =3D expire;
+	add_timer(&timer.timer);
+	schedule();
+	del_timer_sync(&timer.timer);
+
+	/* Remove the timer from the object tracker */
+	destroy_timer_on_stack(&timer.timer);
+
+	timeout =3D expire - jiffies;
+
+ out:
+	return timeout < 0 ? 0 : timeout;
+}
+EXPORT_SYMBOL(schedule_timeout);
+
+/*
+ * __set_current_state() can be used in schedule_timeout_*() functions, beca=
use
+ * schedule_timeout() calls schedule() unconditionally.
+ */
+
+/**
+ * schedule_timeout_interruptible - sleep until timeout (interruptible)
+ * @timeout: timeout value in jiffies
+ *
+ * See schedule_timeout() for details.
+ *
+ * Task state is set to TASK_INTERRUPTIBLE before starting the timeout.
+ */
+signed long __sched schedule_timeout_interruptible(signed long timeout)
+{
+	__set_current_state(TASK_INTERRUPTIBLE);
+	return schedule_timeout(timeout);
+}
+EXPORT_SYMBOL(schedule_timeout_interruptible);
+
+/**
+ * schedule_timeout_killable - sleep until timeout (killable)
+ * @timeout: timeout value in jiffies
+ *
+ * See schedule_timeout() for details.
+ *
+ * Task state is set to TASK_KILLABLE before starting the timeout.
+ */
+signed long __sched schedule_timeout_killable(signed long timeout)
+{
+	__set_current_state(TASK_KILLABLE);
+	return schedule_timeout(timeout);
+}
+EXPORT_SYMBOL(schedule_timeout_killable);
+
+/**
+ * schedule_timeout_uninterruptible - sleep until timeout (uninterruptible)
+ * @timeout: timeout value in jiffies
+ *
+ * See schedule_timeout() for details.
+ *
+ * Task state is set to TASK_UNINTERRUPTIBLE before starting the timeout.
+ */
+signed long __sched schedule_timeout_uninterruptible(signed long timeout)
+{
+	__set_current_state(TASK_UNINTERRUPTIBLE);
+	return schedule_timeout(timeout);
+}
+EXPORT_SYMBOL(schedule_timeout_uninterruptible);
+
+/**
+ * schedule_timeout_idle - sleep until timeout (idle)
+ * @timeout: timeout value in jiffies
+ *
+ * See schedule_timeout() for details.
+ *
+ * Task state is set to TASK_IDLE before starting the timeout. It is similar=
 to
+ * schedule_timeout_uninterruptible(), except this task will not contribute =
to
+ * load average.
+ */
+signed long __sched schedule_timeout_idle(signed long timeout)
+{
+	__set_current_state(TASK_IDLE);
+	return schedule_timeout(timeout);
+}
+EXPORT_SYMBOL(schedule_timeout_idle);
+
+/**
+ * schedule_hrtimeout_range_clock - sleep until timeout
+ * @expires:	timeout value (ktime_t)
+ * @delta:	slack in expires timeout (ktime_t)
+ * @mode:	timer mode
+ * @clock_id:	timer clock to be used
+ *
+ * Details are explained in schedule_hrtimeout_range() function description =
as
+ * this function is commonly used.
+ */
+int __sched schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
+					   const enum hrtimer_mode mode, clockid_t clock_id)
+{
+	struct hrtimer_sleeper t;
+
+	/*
+	 * Optimize when a zero timeout value is given. It does not
+	 * matter whether this is an absolute or a relative time.
+	 */
+	if (expires && *expires =3D=3D 0) {
+		__set_current_state(TASK_RUNNING);
+		return 0;
+	}
+
+	/*
+	 * A NULL parameter means "infinite"
+	 */
+	if (!expires) {
+		schedule();
+		return -EINTR;
+	}
+
+	hrtimer_setup_sleeper_on_stack(&t, clock_id, mode);
+	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
+	hrtimer_sleeper_start_expires(&t, mode);
+
+	if (likely(t.task))
+		schedule();
+
+	hrtimer_cancel(&t.timer);
+	destroy_hrtimer_on_stack(&t.timer);
+
+	__set_current_state(TASK_RUNNING);
+
+	return !t.task ? 0 : -EINTR;
+}
+EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
+
+/**
+ * schedule_hrtimeout_range - sleep until timeout
+ * @expires:	timeout value (ktime_t)
+ * @delta:	slack in expires timeout (ktime_t)
+ * @mode:	timer mode
+ *
+ * Make the current task sleep until the given expiry time has
+ * elapsed. The routine will return immediately unless
+ * the current task state has been set (see set_current_state()).
+ *
+ * The @delta argument gives the kernel the freedom to schedule the
+ * actual wakeup to a time that is both power and performance friendly
+ * for regular (non RT/DL) tasks.
+ * The kernel give the normal best effort behavior for "@expires+@delta",
+ * but may decide to fire the timer earlier, but no earlier than @expires.
+ *
+ * You can set the task state as follows -
+ *
+ * %TASK_UNINTERRUPTIBLE - at least @timeout time is guaranteed to
+ * pass before the routine returns unless the current task is explicitly
+ * woken up, (e.g. by wake_up_process()).
+ *
+ * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
+ * delivered to the current task or the current task is explicitly woken
+ * up.
+ *
+ * The current task state is guaranteed to be TASK_RUNNING when this
+ * routine returns.
+ *
+ * Returns: 0 when the timer has expired. If the task was woken before the
+ * timer expired by a signal (only possible in state TASK_INTERRUPTIBLE) or
+ * by an explicit wakeup, it returns -EINTR.
+ */
+int __sched schedule_hrtimeout_range(ktime_t *expires, u64 delta,
+				     const enum hrtimer_mode mode)
+{
+	return schedule_hrtimeout_range_clock(expires, delta, mode,
+					      CLOCK_MONOTONIC);
+}
+EXPORT_SYMBOL_GPL(schedule_hrtimeout_range);
+
+/**
+ * schedule_hrtimeout - sleep until timeout
+ * @expires:	timeout value (ktime_t)
+ * @mode:	timer mode
+ *
+ * See schedule_hrtimeout_range() for details. @delta argument of
+ * schedule_hrtimeout_range() is set to 0 and has therefore no impact.
+ */
+int __sched schedule_hrtimeout(ktime_t *expires, const enum hrtimer_mode mod=
e)
+{
+	return schedule_hrtimeout_range(expires, 0, mode);
+}
+EXPORT_SYMBOL_GPL(schedule_hrtimeout);
+
+/**
+ * msleep - sleep safely even with waitqueue interruptions
+ * @msecs:	Requested sleep duration in milliseconds
+ *
+ * msleep() uses jiffy based timeouts for the sleep duration. Because of the
+ * design of the timer wheel, the maximum additional percentage delay (slack=
) is
+ * 12.5%. This is only valid for timers which will end up in level 1 or a hi=
gher
+ * level of the timer wheel. For explanation of those 12.5% please check the
+ * detailed description about the basics of the timer wheel.
+ *
+ * The slack of timers which will end up in level 0 depends on sleep duration
+ * (msecs) and HZ configuration and can be calculated in the following way (=
with
+ * the timer wheel design restriction that the slack is not less than 12.5%):
+ *
+ *   ``slack =3D MSECS_PER_TICK / msecs``
+ *
+ * When the allowed slack of the callsite is known, the calculation could be
+ * turned around to find the minimal allowed sleep duration to meet the
+ * constraints. For example:
+ *
+ * * ``HZ=3D1000`` with ``slack=3D25%``: ``MSECS_PER_TICK / slack =3D 1 / (1=
/4) =3D 4``:
+ *   all sleep durations greater or equal 4ms will meet the constraints.
+ * * ``HZ=3D1000`` with ``slack=3D12.5%``: ``MSECS_PER_TICK / slack =3D 1 / =
(1/8) =3D 8``:
+ *   all sleep durations greater or equal 8ms will meet the constraints.
+ * * ``HZ=3D250`` with ``slack=3D25%``: ``MSECS_PER_TICK / slack =3D 4 / (1/=
4) =3D 16``:
+ *   all sleep durations greater or equal 16ms will meet the constraints.
+ * * ``HZ=3D250`` with ``slack=3D12.5%``: ``MSECS_PER_TICK / slack =3D 4 / (=
1/8) =3D 32``:
+ *   all sleep durations greater or equal 32ms will meet the constraints.
+ *
+ * See also the signal aware variant msleep_interruptible().
+ */
+void msleep(unsigned int msecs)
+{
+	unsigned long timeout =3D msecs_to_jiffies(msecs);
+
+	while (timeout)
+		timeout =3D schedule_timeout_uninterruptible(timeout);
+}
+EXPORT_SYMBOL(msleep);
+
+/**
+ * msleep_interruptible - sleep waiting for signals
+ * @msecs:	Requested sleep duration in milliseconds
+ *
+ * See msleep() for some basic information.
+ *
+ * The difference between msleep() and msleep_interruptible() is that the sl=
eep
+ * could be interrupted by a signal delivery and then returns early.
+ *
+ * Returns: The remaining time of the sleep duration transformed to msecs (s=
ee
+ * schedule_timeout() for details).
+ */
+unsigned long msleep_interruptible(unsigned int msecs)
+{
+	unsigned long timeout =3D msecs_to_jiffies(msecs);
+
+	while (timeout && !signal_pending(current))
+		timeout =3D schedule_timeout_interruptible(timeout);
+	return jiffies_to_msecs(timeout);
+}
+EXPORT_SYMBOL(msleep_interruptible);
+
+/**
+ * usleep_range_state - Sleep for an approximate time in a given state
+ * @min:	Minimum time in usecs to sleep
+ * @max:	Maximum time in usecs to sleep
+ * @state:	State of the current task that will be while sleeping
+ *
+ * usleep_range_state() sleeps at least for the minimum specified time but n=
ot
+ * longer than the maximum specified amount of time. The range might reduce
+ * power usage by allowing hrtimers to coalesce an already scheduled interru=
pt
+ * with this hrtimer. In the worst case, an interrupt is scheduled for the u=
pper
+ * bound.
+ *
+ * The sleeping task is set to the specified state before starting the sleep.
+ *
+ * In non-atomic context where the exact wakeup time is flexible, use
+ * usleep_range() or its variants instead of udelay(). The sleep improves
+ * responsiveness by avoiding the CPU-hogging busy-wait of udelay().
+ */
+void __sched usleep_range_state(unsigned long min, unsigned long max, unsign=
ed int state)
+{
+	ktime_t exp =3D ktime_add_us(ktime_get(), min);
+	u64 delta =3D (u64)(max - min) * NSEC_PER_USEC;
+
+	if (WARN_ON_ONCE(max < min))
+		delta =3D 0;
+
+	for (;;) {
+		__set_current_state(state);
+		/* Do not return before the requested sleep time has elapsed */
+		if (!schedule_hrtimeout_range(&exp, delta, HRTIMER_MODE_ABS))
+			break;
+	}
+}
+EXPORT_SYMBOL(usleep_range_state);
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 5f2105e637bd..faac36de35b9 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -25,6 +25,7 @@ extern int tick_do_timer_cpu __read_mostly;
 extern void tick_setup_periodic(struct clock_event_device *dev, int broadcas=
t);
 extern void tick_handle_periodic(struct clock_event_device *dev);
 extern void tick_check_new_device(struct clock_event_device *dev);
+extern void tick_offline_cpu(unsigned int cpu);
 extern void tick_shutdown(unsigned int cpu);
 extern void tick_suspend(void);
 extern void tick_resume(void);
@@ -142,10 +143,8 @@ static inline bool tick_broadcast_oneshot_available(void=
) { return tick_oneshot_
 #endif /* !(BROADCAST && ONESHOT) */
=20
 #if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_HOTPLUG_=
CPU)
-extern void tick_offline_cpu(unsigned int cpu);
 extern void tick_broadcast_offline(unsigned int cpu);
 #else
-static inline void tick_offline_cpu(unsigned int cpu) { }
 static inline void tick_broadcast_offline(unsigned int cpu) { }
 #endif
=20
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 753a184c7090..9f90c7333b1d 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -311,14 +311,6 @@ static enum hrtimer_restart tick_nohz_handler(struct hrt=
imer *timer)
 	return HRTIMER_RESTART;
 }
=20
-static void tick_sched_timer_cancel(struct tick_sched *ts)
-{
-	if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES))
-		hrtimer_cancel(&ts->sched_timer);
-	else if (tick_sched_flag_test(ts, TS_FLAG_NOHZ))
-		tick_program_event(KTIME_MAX, 1);
-}
-
 #ifdef CONFIG_NO_HZ_FULL
 cpumask_var_t tick_nohz_full_mask;
 EXPORT_SYMBOL_GPL(tick_nohz_full_mask);
@@ -1055,7 +1047,10 @@ static void tick_nohz_stop_tick(struct tick_sched *ts,=
 int cpu)
 	 * the tick timer.
 	 */
 	if (unlikely(expires =3D=3D KTIME_MAX)) {
-		tick_sched_timer_cancel(ts);
+		if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES))
+			hrtimer_cancel(&ts->sched_timer);
+		else
+			tick_program_event(KTIME_MAX, 1);
 		return;
 	}
=20
@@ -1604,21 +1599,13 @@ void tick_setup_sched_timer(bool hrtimer)
  */
 void tick_sched_timer_dying(int cpu)
 {
-	struct tick_device *td =3D &per_cpu(tick_cpu_device, cpu);
 	struct tick_sched *ts =3D &per_cpu(tick_cpu_sched, cpu);
-	struct clock_event_device *dev =3D td->evtdev;
 	ktime_t idle_sleeptime, iowait_sleeptime;
 	unsigned long idle_calls, idle_sleeps;
=20
 	/* This must happen before hrtimers are migrated! */
-	tick_sched_timer_cancel(ts);
-
-	/*
-	 * If the clockevents doesn't support CLOCK_EVT_STATE_ONESHOT_STOPPED,
-	 * make sure not to call low-res tick handler.
-	 */
-	if (tick_sched_flag_test(ts, TS_FLAG_NOHZ))
-		dev->event_handler =3D clockevents_handle_noop;
+	if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES))
+		hrtimer_cancel(&ts->sched_timer);
=20
 	idle_sleeptime =3D ts->idle_sleeptime;
 	iowait_sleeptime =3D ts->iowait_sleeptime;
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 642647f5046b..1b69caa87480 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -556,9 +556,9 @@ EXPORT_SYMBOL(ns_to_timespec64);
  * - all other values are converted to jiffies by either multiplying
  *   the input value by a factor or dividing it with a factor and
  *   handling any 32-bit overflows.
- *   for the details see __msecs_to_jiffies()
+ *   for the details see _msecs_to_jiffies()
  *
- * __msecs_to_jiffies() checks for the passed in value being a constant
+ * msecs_to_jiffies() checks for the passed in value being a constant
  * via __builtin_constant_p() allowing gcc to eliminate most of the
  * code, __msecs_to_jiffies() is called if the value passed does not
  * allow constant folding and the actual conversion must be done at
@@ -866,7 +866,7 @@ struct timespec64 timespec64_add_safe(const struct timesp=
ec64 lhs,
  *
  * Handles compat or 32-bit modes.
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int get_timespec64(struct timespec64 *ts,
 		   const struct __kernel_timespec __user *uts)
@@ -897,7 +897,7 @@ EXPORT_SYMBOL_GPL(get_timespec64);
  * @ts: input &struct timespec64
  * @uts: user's &struct __kernel_timespec
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int put_timespec64(const struct timespec64 *ts,
 		   struct __kernel_timespec __user *uts)
@@ -944,7 +944,7 @@ static int __put_old_timespec32(const struct timespec64 *=
ts64,
  *
  * Handles X86_X32_ABI compatibility conversion.
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int get_old_timespec32(struct timespec64 *ts, const void __user *uts)
 {
@@ -963,7 +963,7 @@ EXPORT_SYMBOL_GPL(get_old_timespec32);
  *
  * Handles X86_X32_ABI compatibility conversion.
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int put_old_timespec32(const struct timespec64 *ts, void __user *uts)
 {
@@ -979,7 +979,7 @@ EXPORT_SYMBOL_GPL(put_old_timespec32);
  * @it: destination &struct itimerspec64
  * @uit: user's &struct __kernel_itimerspec
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int get_itimerspec64(struct itimerspec64 *it,
 			const struct __kernel_itimerspec __user *uit)
@@ -1002,7 +1002,7 @@ EXPORT_SYMBOL_GPL(get_itimerspec64);
  * @it: input &struct itimerspec64
  * @uit: user's &struct __kernel_itimerspec
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int put_itimerspec64(const struct itimerspec64 *it,
 			struct __kernel_itimerspec __user *uit)
@@ -1024,7 +1024,7 @@ EXPORT_SYMBOL_GPL(put_itimerspec64);
  * @its: destination &struct itimerspec64
  * @uits: user's &struct old_itimerspec32
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int get_old_itimerspec32(struct itimerspec64 *its,
 			const struct old_itimerspec32 __user *uits)
@@ -1043,7 +1043,7 @@ EXPORT_SYMBOL_GPL(get_old_itimerspec32);
  * @its: input &struct itimerspec64
  * @uits: user's &struct old_itimerspec32
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int put_old_itimerspec32(const struct itimerspec64 *its,
 			struct old_itimerspec32 __user *uits)
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 7e6f409bf311..d115adebc418 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -30,8 +30,9 @@
 #include "timekeeping_internal.h"
=20
 #define TK_CLEAR_NTP		(1 << 0)
-#define TK_MIRROR		(1 << 1)
-#define TK_CLOCK_WAS_SET	(1 << 2)
+#define TK_CLOCK_WAS_SET	(1 << 1)
+
+#define TK_UPDATE_ALL		(TK_CLEAR_NTP | TK_CLOCK_WAS_SET)
=20
 enum timekeeping_adv_mode {
 	/* Update timekeeper when a tick has passed */
@@ -41,20 +42,18 @@ enum timekeeping_adv_mode {
 	TK_ADV_FREQ
 };
=20
-DEFINE_RAW_SPINLOCK(timekeeper_lock);
-
 /*
  * The most important data for readout fits into a single 64 byte
  * cache line.
  */
-static struct {
+struct tk_data {
 	seqcount_raw_spinlock_t	seq;
 	struct timekeeper	timekeeper;
-} tk_core ____cacheline_aligned =3D {
-	.seq =3D SEQCNT_RAW_SPINLOCK_ZERO(tk_core.seq, &timekeeper_lock),
-};
+	struct timekeeper	shadow_timekeeper;
+	raw_spinlock_t		lock;
+} ____cacheline_aligned;
=20
-static struct timekeeper shadow_timekeeper;
+static struct tk_data tk_core;
=20
 /* flag for if timekeeping is suspended */
 int __read_mostly timekeeping_suspended;
@@ -114,6 +113,36 @@ static struct tk_fast tk_fast_raw  ____cacheline_aligned=
 =3D {
 	.base[1] =3D FAST_TK_INIT,
 };
=20
+unsigned long timekeeper_lock_irqsave(void)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&tk_core.lock, flags);
+	return flags;
+}
+
+void timekeeper_unlock_irqrestore(unsigned long flags)
+{
+	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
+}
+
+/*
+ * Multigrain timestamps require tracking the latest fine-grained timestamp
+ * that has been issued, and never returning a coarse-grained timestamp that=
 is
+ * earlier than that value.
+ *
+ * mg_floor represents the latest fine-grained time that has been handed out=
 as
+ * a file timestamp on the system. This is tracked as a monotonic ktime_t, a=
nd
+ * converted to a realtime clock value on an as-needed basis.
+ *
+ * Maintaining mg_floor ensures the multigrain interfaces never issue a
+ * timestamp earlier than one that has been previously issued.
+ *
+ * The exception to this rule is when there is a backward realtime clock jum=
p. If
+ * such an event occurs, a timestamp can appear to be earlier than a previou=
s one.
+ */
+static __cacheline_aligned_in_smp atomic64_t mg_floor;
+
 static inline void tk_normalize_xtime(struct timekeeper *tk)
 {
 	while (tk->tkr_mono.xtime_nsec >=3D ((u64)NSEC_PER_SEC << tk->tkr_mono.shif=
t)) {
@@ -161,13 +190,15 @@ static void tk_set_wall_to_mono(struct timekeeper *tk, =
struct timespec64 wtm)
 	WARN_ON_ONCE(tk->offs_real !=3D timespec64_to_ktime(tmp));
 	tk->wall_to_monotonic =3D wtm;
 	set_normalized_timespec64(&tmp, -wtm.tv_sec, -wtm.tv_nsec);
-	tk->offs_real =3D timespec64_to_ktime(tmp);
-	tk->offs_tai =3D ktime_add(tk->offs_real, ktime_set(tk->tai_offset, 0));
+	/* Paired with READ_ONCE() in ktime_mono_to_any() */
+	WRITE_ONCE(tk->offs_real, timespec64_to_ktime(tmp));
+	WRITE_ONCE(tk->offs_tai, ktime_add(tk->offs_real, ktime_set(tk->tai_offset,=
 0)));
 }
=20
 static inline void tk_update_sleep_time(struct timekeeper *tk, ktime_t delta)
 {
-	tk->offs_boot =3D ktime_add(tk->offs_boot, delta);
+	/* Paired with READ_ONCE() in ktime_mono_to_any() */
+	WRITE_ONCE(tk->offs_boot, ktime_add(tk->offs_boot, delta));
 	/*
 	 * Timespec representation for VDSO update to avoid 64bit division
 	 * on every update.
@@ -184,7 +215,7 @@ static inline void tk_update_sleep_time(struct timekeeper=
 *tk, ktime_t delta)
  * the tkr's clocksource may change between the read reference, and the
  * clock reference passed to the read function.  This can cause crashes if
  * the wrong clocksource is passed to the wrong read function.
- * This isn't necessary to use when holding the timekeeper_lock or doing
+ * This isn't necessary to use when holding the tk_core.lock or doing
  * a read of the fast-timekeeper tkrs (which is protected by its own locking
  * and update logic).
  */
@@ -195,97 +226,6 @@ static inline u64 tk_clock_read(const struct tk_read_bas=
e *tkr)
 	return clock->read(clock);
 }
=20
-#ifdef CONFIG_DEBUG_TIMEKEEPING
-#define WARNING_FREQ (HZ*300) /* 5 minute rate-limiting */
-
-static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
-{
-
-	u64 max_cycles =3D tk->tkr_mono.clock->max_cycles;
-	const char *name =3D tk->tkr_mono.clock->name;
-
-	if (offset > max_cycles) {
-		printk_deferred("WARNING: timekeeping: Cycle offset (%lld) is larger than =
allowed by the '%s' clock's max_cycles value (%lld): time overflow danger\n",
-				offset, name, max_cycles);
-		printk_deferred("         timekeeping: Your kernel is sick, but tries to c=
ope by capping time updates\n");
-	} else {
-		if (offset > (max_cycles >> 1)) {
-			printk_deferred("INFO: timekeeping: Cycle offset (%lld) is larger than th=
e '%s' clock's 50%% safety margin (%lld)\n",
-					offset, name, max_cycles >> 1);
-			printk_deferred("      timekeeping: Your kernel is still fine, but is fee=
ling a bit nervous\n");
-		}
-	}
-
-	if (tk->underflow_seen) {
-		if (jiffies - tk->last_warning > WARNING_FREQ) {
-			printk_deferred("WARNING: Underflow in clocksource '%s' observed, time up=
date ignored.\n", name);
-			printk_deferred("         Please report this, consider using a different =
clocksource, if possible.\n");
-			printk_deferred("         Your kernel is probably still fine.\n");
-			tk->last_warning =3D jiffies;
-		}
-		tk->underflow_seen =3D 0;
-	}
-
-	if (tk->overflow_seen) {
-		if (jiffies - tk->last_warning > WARNING_FREQ) {
-			printk_deferred("WARNING: Overflow in clocksource '%s' observed, time upd=
ate capped.\n", name);
-			printk_deferred("         Please report this, consider using a different =
clocksource, if possible.\n");
-			printk_deferred("         Your kernel is probably still fine.\n");
-			tk->last_warning =3D jiffies;
-		}
-		tk->overflow_seen =3D 0;
-	}
-}
-
-static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u=
64 cycles);
-
-static inline u64 timekeeping_debug_get_ns(const struct tk_read_base *tkr)
-{
-	struct timekeeper *tk =3D &tk_core.timekeeper;
-	u64 now, last, mask, max, delta;
-	unsigned int seq;
-
-	/*
-	 * Since we're called holding a seqcount, the data may shift
-	 * under us while we're doing the calculation. This can cause
-	 * false positives, since we'd note a problem but throw the
-	 * results away. So nest another seqcount here to atomically
-	 * grab the points we are checking with.
-	 */
-	do {
-		seq =3D read_seqcount_begin(&tk_core.seq);
-		now =3D tk_clock_read(tkr);
-		last =3D tkr->cycle_last;
-		mask =3D tkr->mask;
-		max =3D tkr->clock->max_cycles;
-	} while (read_seqcount_retry(&tk_core.seq, seq));
-
-	delta =3D clocksource_delta(now, last, mask);
-
-	/*
-	 * Try to catch underflows by checking if we are seeing small
-	 * mask-relative negative values.
-	 */
-	if (unlikely((~delta & mask) < (mask >> 3)))
-		tk->underflow_seen =3D 1;
-
-	/* Check for multiplication overflows */
-	if (unlikely(delta > max))
-		tk->overflow_seen =3D 1;
-
-	/* timekeeping_cycles_to_ns() handles both under and overflow */
-	return timekeeping_cycles_to_ns(tkr, now);
-}
-#else
-static inline void timekeeping_check_update(struct timekeeper *tk, u64 offse=
t)
-{
-}
-static inline u64 timekeeping_debug_get_ns(const struct tk_read_base *tkr)
-{
-	BUG();
-}
-#endif
-
 /**
  * tk_setup_internals - Set up internals to use clocksource clock.
  *
@@ -390,19 +330,11 @@ static inline u64 timekeeping_cycles_to_ns(const struct=
 tk_read_base *tkr, u64 c
 	return ((delta * tkr->mult) + tkr->xtime_nsec) >> tkr->shift;
 }
=20
-static __always_inline u64 __timekeeping_get_ns(const struct tk_read_base *t=
kr)
+static __always_inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
 {
 	return timekeeping_cycles_to_ns(tkr, tk_clock_read(tkr));
 }
=20
-static inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
-{
-	if (IS_ENABLED(CONFIG_DEBUG_TIMEKEEPING))
-		return timekeeping_debug_get_ns(tkr);
-
-	return __timekeeping_get_ns(tkr);
-}
-
 /**
  * update_fast_timekeeper - Update the fast and NMI safe monotonic timekeepe=
r.
  * @tkr: Timekeeping readout base from which we take the update
@@ -446,7 +378,7 @@ static __always_inline u64 __ktime_get_fast_ns(struct tk_=
fast *tkf)
 		seq =3D raw_read_seqcount_latch(&tkf->seq);
 		tkr =3D tkf->base + (seq & 0x01);
 		now =3D ktime_to_ns(tkr->base);
-		now +=3D __timekeeping_get_ns(tkr);
+		now +=3D timekeeping_get_ns(tkr);
 	} while (raw_read_seqcount_latch_retry(&tkf->seq, seq));
=20
 	return now;
@@ -517,7 +449,7 @@ EXPORT_SYMBOL_GPL(ktime_get_raw_fast_ns);
  *    timekeeping_inject_sleeptime64()
  *    __timekeeping_inject_sleeptime(tk, delta);
  *                                                 timestamp();
- *    timekeeping_update(tk, TK_CLEAR_NTP...);
+ *    timekeeping_update_staged(tkd, TK_CLEAR_NTP...);
  *
  * (2) On 32-bit systems, the 64-bit boot offset (tk->offs_boot) may be
  * partially updated.  Since the tk->offs_boot update is a rare event, this
@@ -562,7 +494,7 @@ static __always_inline u64 __ktime_get_real_fast(struct t=
k_fast *tkf, u64 *mono)
 		tkr =3D tkf->base + (seq & 0x01);
 		basem =3D ktime_to_ns(tkr->base);
 		baser =3D ktime_to_ns(tkr->base_real);
-		delta =3D __timekeeping_get_ns(tkr);
+		delta =3D timekeeping_get_ns(tkr);
 	} while (raw_read_seqcount_latch_retry(&tkf->seq, seq));
=20
 	if (mono)
@@ -676,13 +608,11 @@ static void update_pvclock_gtod(struct timekeeper *tk, =
bool was_set)
 int pvclock_gtod_register_notifier(struct notifier_block *nb)
 {
 	struct timekeeper *tk =3D &tk_core.timekeeper;
-	unsigned long flags;
 	int ret;
=20
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	guard(raw_spinlock_irqsave)(&tk_core.lock);
 	ret =3D raw_notifier_chain_register(&pvclock_gtod_chain, nb);
 	update_pvclock_gtod(tk, true);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
=20
 	return ret;
 }
@@ -695,14 +625,8 @@ EXPORT_SYMBOL_GPL(pvclock_gtod_register_notifier);
  */
 int pvclock_gtod_unregister_notifier(struct notifier_block *nb)
 {
-	unsigned long flags;
-	int ret;
-
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
-	ret =3D raw_notifier_chain_unregister(&pvclock_gtod_chain, nb);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
-
-	return ret;
+	guard(raw_spinlock_irqsave)(&tk_core.lock);
+	return raw_notifier_chain_unregister(&pvclock_gtod_chain, nb);
 }
 EXPORT_SYMBOL_GPL(pvclock_gtod_unregister_notifier);
=20
@@ -717,6 +641,18 @@ static inline void tk_update_leap_state(struct timekeepe=
r *tk)
 		tk->next_leap_ktime =3D ktime_sub(tk->next_leap_ktime, tk->offs_real);
 }
=20
+/*
+ * Leap state update for both shadow and the real timekeeper
+ * Separate to spare a full memcpy() of the timekeeper.
+ */
+static void tk_update_leap_state_all(struct tk_data *tkd)
+{
+	write_seqcount_begin(&tkd->seq);
+	tk_update_leap_state(&tkd->shadow_timekeeper);
+	tkd->timekeeper.next_leap_ktime =3D tkd->shadow_timekeeper.next_leap_ktime;
+	write_seqcount_end(&tkd->seq);
+}
+
 /*
  * Update the ktime_t based scalar nsec members of the timekeeper
  */
@@ -750,9 +686,30 @@ static inline void tk_update_ktime_data(struct timekeepe=
r *tk)
 	tk->tkr_raw.base =3D ns_to_ktime(tk->raw_sec * NSEC_PER_SEC);
 }
=20
-/* must hold timekeeper_lock */
-static void timekeeping_update(struct timekeeper *tk, unsigned int action)
+/*
+ * Restore the shadow timekeeper from the real timekeeper.
+ */
+static void timekeeping_restore_shadow(struct tk_data *tkd)
+{
+	lockdep_assert_held(&tkd->lock);
+	memcpy(&tkd->shadow_timekeeper, &tkd->timekeeper, sizeof(tkd->timekeeper));
+}
+
+static void timekeeping_update_from_shadow(struct tk_data *tkd, unsigned int=
 action)
 {
+	struct timekeeper *tk =3D &tk_core.shadow_timekeeper;
+
+	lockdep_assert_held(&tkd->lock);
+
+	/*
+	 * Block out readers before running the updates below because that
+	 * updates VDSO and other time related infrastructure. Not blocking
+	 * the readers might let a reader see time going backwards when
+	 * reading from the VDSO after the VDSO update and then reading in
+	 * the kernel from the timekeeper before that got updated.
+	 */
+	write_seqcount_begin(&tkd->seq);
+
 	if (action & TK_CLEAR_NTP) {
 		tk->ntp_error =3D 0;
 		ntp_clear();
@@ -770,14 +727,17 @@ static void timekeeping_update(struct timekeeper *tk, u=
nsigned int action)
=20
 	if (action & TK_CLOCK_WAS_SET)
 		tk->clock_was_set_seq++;
+
 	/*
-	 * The mirroring of the data to the shadow-timekeeper needs
-	 * to happen last here to ensure we don't over-write the
-	 * timekeeper structure on the next update with stale data
+	 * Update the real timekeeper.
+	 *
+	 * We could avoid this memcpy() by switching pointers, but that has
+	 * the downside that the reader side does not longer benefit from
+	 * the cacheline optimized data layout of the timekeeper and requires
+	 * another indirection.
 	 */
-	if (action & TK_MIRROR)
-		memcpy(&shadow_timekeeper, &tk_core.timekeeper,
-		       sizeof(tk_core.timekeeper));
+	memcpy(&tkd->timekeeper, tk, sizeof(*tk));
+	write_seqcount_end(&tkd->seq);
 }
=20
 /**
@@ -930,6 +890,14 @@ ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets=
 offs)
 	unsigned int seq;
 	ktime_t tconv;
=20
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		/*
+		 * Paired with WRITE_ONCE()s in tk_set_wall_to_mono() and
+		 * tk_update_sleep_time().
+		 */
+		return ktime_add(tmono, READ_ONCE(*offset));
+	}
+
 	do {
 		seq =3D read_seqcount_begin(&tk_core.seq);
 		tconv =3D ktime_add(tmono, *offset);
@@ -1060,6 +1028,7 @@ void ktime_get_snapshot(struct system_time_snapshot *sy=
stime_snapshot)
 	unsigned int seq;
 	ktime_t base_raw;
 	ktime_t base_real;
+	ktime_t base_boot;
 	u64 nsec_raw;
 	u64 nsec_real;
 	u64 now;
@@ -1074,6 +1043,8 @@ void ktime_get_snapshot(struct system_time_snapshot *sy=
stime_snapshot)
 		systime_snapshot->clock_was_set_seq =3D tk->clock_was_set_seq;
 		base_real =3D ktime_add(tk->tkr_mono.base,
 				      tk_core.timekeeper.offs_real);
+		base_boot =3D ktime_add(tk->tkr_mono.base,
+				      tk_core.timekeeper.offs_boot);
 		base_raw =3D tk->tkr_raw.base;
 		nsec_real =3D timekeeping_cycles_to_ns(&tk->tkr_mono, now);
 		nsec_raw  =3D timekeeping_cycles_to_ns(&tk->tkr_raw, now);
@@ -1081,6 +1052,7 @@ void ktime_get_snapshot(struct system_time_snapshot *sy=
stime_snapshot)
=20
 	systime_snapshot->cycles =3D now;
 	systime_snapshot->real =3D ktime_add_ns(base_real, nsec_real);
+	systime_snapshot->boot =3D ktime_add_ns(base_boot, nsec_real);
 	systime_snapshot->raw =3D ktime_add_ns(base_raw, nsec_raw);
 }
 EXPORT_SYMBOL_GPL(ktime_get_snapshot);
@@ -1440,45 +1412,35 @@ EXPORT_SYMBOL_GPL(timekeeping_clocksource_has_base);
  */
 int do_settimeofday64(const struct timespec64 *ts)
 {
-	struct timekeeper *tk =3D &tk_core.timekeeper;
 	struct timespec64 ts_delta, xt;
-	unsigned long flags;
-	int ret =3D 0;
=20
 	if (!timespec64_valid_settod(ts))
 		return -EINVAL;
=20
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-
-	timekeeping_forward_now(tk);
+	scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
+		struct timekeeper *tks =3D &tk_core.shadow_timekeeper;
=20
-	xt =3D tk_xtime(tk);
-	ts_delta =3D timespec64_sub(*ts, xt);
-
-	if (timespec64_compare(&tk->wall_to_monotonic, &ts_delta) > 0) {
-		ret =3D -EINVAL;
-		goto out;
-	}
+		timekeeping_forward_now(tks);
=20
-	tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, ts_delta));
+		xt =3D tk_xtime(tks);
+		ts_delta =3D timespec64_sub(*ts, xt);
=20
-	tk_set_xtime(tk, ts);
-out:
-	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
+		if (timespec64_compare(&tks->wall_to_monotonic, &ts_delta) > 0) {
+			timekeeping_restore_shadow(&tk_core);
+			return -EINVAL;
+		}
=20
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+		tk_set_wall_to_mono(tks, timespec64_sub(tks->wall_to_monotonic, ts_delta));
+		tk_set_xtime(tks, ts);
+		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
+	}
=20
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL);
=20
-	if (!ret) {
-		audit_tk_injoffset(ts_delta);
-		add_device_randomness(ts, sizeof(*ts));
-	}
-
-	return ret;
+	audit_tk_injoffset(ts_delta);
+	add_device_randomness(ts, sizeof(*ts));
+	return 0;
 }
 EXPORT_SYMBOL(do_settimeofday64);
=20
@@ -1490,40 +1452,31 @@ EXPORT_SYMBOL(do_settimeofday64);
  */
 static int timekeeping_inject_offset(const struct timespec64 *ts)
 {
-	struct timekeeper *tk =3D &tk_core.timekeeper;
-	unsigned long flags;
-	struct timespec64 tmp;
-	int ret =3D 0;
-
 	if (ts->tv_nsec < 0 || ts->tv_nsec >=3D NSEC_PER_SEC)
 		return -EINVAL;
=20
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-
-	timekeeping_forward_now(tk);
-
-	/* Make sure the proposed value is valid */
-	tmp =3D timespec64_add(tk_xtime(tk), *ts);
-	if (timespec64_compare(&tk->wall_to_monotonic, ts) > 0 ||
-	    !timespec64_valid_settod(&tmp)) {
-		ret =3D -EINVAL;
-		goto error;
-	}
+	scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
+		struct timekeeper *tks =3D &tk_core.shadow_timekeeper;
+		struct timespec64 tmp;
=20
-	tk_xtime_add(tk, ts);
-	tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, *ts));
+		timekeeping_forward_now(tks);
=20
-error: /* even if we error out, we forwarded the time, so call update */
-	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
+		/* Make sure the proposed value is valid */
+		tmp =3D timespec64_add(tk_xtime(tks), *ts);
+		if (timespec64_compare(&tks->wall_to_monotonic, ts) > 0 ||
+		    !timespec64_valid_settod(&tmp)) {
+			timekeeping_restore_shadow(&tk_core);
+			return -EINVAL;
+		}
=20
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+		tk_xtime_add(tks, ts);
+		tk_set_wall_to_mono(tks, timespec64_sub(tks->wall_to_monotonic, *ts));
+		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
+	}
=20
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL);
-
-	return ret;
+	return 0;
 }
=20
 /*
@@ -1576,43 +1529,34 @@ static void __timekeeping_set_tai_offset(struct timek=
eeper *tk, s32 tai_offset)
  */
 static int change_clocksource(void *data)
 {
-	struct timekeeper *tk =3D &tk_core.timekeeper;
-	struct clocksource *new, *old =3D NULL;
-	unsigned long flags;
-	bool change =3D false;
-
-	new =3D (struct clocksource *) data;
+	struct clocksource *new =3D data, *old =3D NULL;
=20
 	/*
-	 * If the cs is in module, get a module reference. Succeeds
-	 * for built-in code (owner =3D=3D NULL) as well.
+	 * If the clocksource is in a module, get a module reference.
+	 * Succeeds for built-in code (owner =3D=3D NULL) as well. Abort if the
+	 * reference can't be acquired.
 	 */
-	if (try_module_get(new->owner)) {
-		if (!new->enable || new->enable(new) =3D=3D 0)
-			change =3D true;
-		else
-			module_put(new->owner);
-	}
-
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-
-	timekeeping_forward_now(tk);
+	if (!try_module_get(new->owner))
+		return 0;
=20
-	if (change) {
-		old =3D tk->tkr_mono.clock;
-		tk_setup_internals(tk, new);
+	/* Abort if the device can't be enabled */
+	if (new->enable && new->enable(new) !=3D 0) {
+		module_put(new->owner);
+		return 0;
 	}
=20
-	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
+	scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
+		struct timekeeper *tks =3D &tk_core.shadow_timekeeper;
=20
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+		timekeeping_forward_now(tks);
+		old =3D tks->tkr_mono.clock;
+		tk_setup_internals(tks, new);
+		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
+	}
=20
 	if (old) {
 		if (old->disable)
 			old->disable(old);
-
 		module_put(old->owner);
 	}
=20
@@ -1737,6 +1681,12 @@ read_persistent_wall_and_boot_offset(struct timespec64=
 *wall_time,
 	*boot_offset =3D ns_to_timespec64(local_clock());
 }
=20
+static __init void tkd_basic_setup(struct tk_data *tkd)
+{
+	raw_spin_lock_init(&tkd->lock);
+	seqcount_raw_spinlock_init(&tkd->seq, &tkd->lock);
+}
+
 /*
  * Flag reflecting whether timekeeping_resume() has injected sleeptime.
  *
@@ -1761,9 +1711,10 @@ static bool persistent_clock_exists;
 void __init timekeeping_init(void)
 {
 	struct timespec64 wall_time, boot_offset, wall_to_mono;
-	struct timekeeper *tk =3D &tk_core.timekeeper;
+	struct timekeeper *tks =3D &tk_core.shadow_timekeeper;
 	struct clocksource *clock;
-	unsigned long flags;
+
+	tkd_basic_setup(&tk_core);
=20
 	read_persistent_wall_and_boot_offset(&wall_time, &boot_offset);
 	if (timespec64_valid_settod(&wall_time) &&
@@ -1783,24 +1734,21 @@ void __init timekeeping_init(void)
 	 */
 	wall_to_mono =3D timespec64_sub(boot_offset, wall_time);
=20
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
-	write_seqcount_begin(&tk_core.seq);
+	guard(raw_spinlock_irqsave)(&tk_core.lock);
+
 	ntp_init();
=20
 	clock =3D clocksource_default_clock();
 	if (clock->enable)
 		clock->enable(clock);
-	tk_setup_internals(tk, clock);
+	tk_setup_internals(tks, clock);
=20
-	tk_set_xtime(tk, &wall_time);
-	tk->raw_sec =3D 0;
+	tk_set_xtime(tks, &wall_time);
+	tks->raw_sec =3D 0;
=20
-	tk_set_wall_to_mono(tk, wall_to_mono);
+	tk_set_wall_to_mono(tks, wall_to_mono);
=20
-	timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
-
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	timekeeping_update_from_shadow(&tk_core, TK_CLOCK_WAS_SET);
 }
=20
 /* time in seconds when suspend began for persistent clock */
@@ -1878,22 +1826,14 @@ bool timekeeping_rtc_skipsuspend(void)
  */
 void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
 {
-	struct timekeeper *tk =3D &tk_core.timekeeper;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-
-	suspend_timing_needed =3D false;
-
-	timekeeping_forward_now(tk);
+	scoped_guard(raw_spinlock_irqsave, &tk_core.lock) {
+		struct timekeeper *tks =3D &tk_core.shadow_timekeeper;
=20
-	__timekeeping_inject_sleeptime(tk, delta);
-
-	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
-
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+		suspend_timing_needed =3D false;
+		timekeeping_forward_now(tks);
+		__timekeeping_inject_sleeptime(tks, delta);
+		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
+	}
=20
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL | CLOCK_SET_BOOT);
@@ -1905,20 +1845,19 @@ void timekeeping_inject_sleeptime64(const struct time=
spec64 *delta)
  */
 void timekeeping_resume(void)
 {
-	struct timekeeper *tk =3D &tk_core.timekeeper;
-	struct clocksource *clock =3D tk->tkr_mono.clock;
-	unsigned long flags;
+	struct timekeeper *tks =3D &tk_core.shadow_timekeeper;
+	struct clocksource *clock =3D tks->tkr_mono.clock;
 	struct timespec64 ts_new, ts_delta;
-	u64 cycle_now, nsec;
 	bool inject_sleeptime =3D false;
+	u64 cycle_now, nsec;
+	unsigned long flags;
=20
 	read_persistent_clock64(&ts_new);
=20
 	clockevents_resume();
 	clocksource_resume();
=20
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
-	write_seqcount_begin(&tk_core.seq);
+	raw_spin_lock_irqsave(&tk_core.lock, flags);
=20
 	/*
 	 * After system resumes, we need to calculate the suspended time and
@@ -1932,7 +1871,7 @@ void timekeeping_resume(void)
 	 * The less preferred source will only be tried if there is no better
 	 * usable source. The rtc part is handled separately in rtc core code.
 	 */
-	cycle_now =3D tk_clock_read(&tk->tkr_mono);
+	cycle_now =3D tk_clock_read(&tks->tkr_mono);
 	nsec =3D clocksource_stop_suspend_timing(clock, cycle_now);
 	if (nsec > 0) {
 		ts_delta =3D ns_to_timespec64(nsec);
@@ -1944,18 +1883,17 @@ void timekeeping_resume(void)
=20
 	if (inject_sleeptime) {
 		suspend_timing_needed =3D false;
-		__timekeeping_inject_sleeptime(tk, &ts_delta);
+		__timekeeping_inject_sleeptime(tks, &ts_delta);
 	}
=20
 	/* Re-base the last cycle value */
-	tk->tkr_mono.cycle_last =3D cycle_now;
-	tk->tkr_raw.cycle_last  =3D cycle_now;
+	tks->tkr_mono.cycle_last =3D cycle_now;
+	tks->tkr_raw.cycle_last  =3D cycle_now;
=20
-	tk->ntp_error =3D 0;
+	tks->ntp_error =3D 0;
 	timekeeping_suspended =3D 0;
-	timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	timekeeping_update_from_shadow(&tk_core, TK_CLOCK_WAS_SET);
+	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
=20
 	touch_softlockup_watchdog();
=20
@@ -1967,11 +1905,11 @@ void timekeeping_resume(void)
=20
 int timekeeping_suspend(void)
 {
-	struct timekeeper *tk =3D &tk_core.timekeeper;
-	unsigned long flags;
-	struct timespec64		delta, delta_delta;
-	static struct timespec64	old_delta;
+	struct timekeeper *tks =3D &tk_core.shadow_timekeeper;
+	struct timespec64 delta, delta_delta;
+	static struct timespec64 old_delta;
 	struct clocksource *curr_clock;
+	unsigned long flags;
 	u64 cycle_now;
=20
 	read_persistent_clock64(&timekeeping_suspend_time);
@@ -1986,9 +1924,8 @@ int timekeeping_suspend(void)
=20
 	suspend_timing_needed =3D true;
=20
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-	timekeeping_forward_now(tk);
+	raw_spin_lock_irqsave(&tk_core.lock, flags);
+	timekeeping_forward_now(tks);
 	timekeeping_suspended =3D 1;
=20
 	/*
@@ -1996,8 +1933,8 @@ int timekeeping_suspend(void)
 	 * just read from the current clocksource. Save this to potentially
 	 * use in suspend timing.
 	 */
-	curr_clock =3D tk->tkr_mono.clock;
-	cycle_now =3D tk->tkr_mono.cycle_last;
+	curr_clock =3D tks->tkr_mono.clock;
+	cycle_now =3D tks->tkr_mono.cycle_last;
 	clocksource_start_suspend_timing(curr_clock, cycle_now);
=20
 	if (persistent_clock_exists) {
@@ -2007,7 +1944,7 @@ int timekeeping_suspend(void)
 		 * try to compensate so the difference in system time
 		 * and persistent_clock time stays close to constant.
 		 */
-		delta =3D timespec64_sub(tk_xtime(tk), timekeeping_suspend_time);
+		delta =3D timespec64_sub(tk_xtime(tks), timekeeping_suspend_time);
 		delta_delta =3D timespec64_sub(delta, old_delta);
 		if (abs(delta_delta.tv_sec) >=3D 2) {
 			/*
@@ -2022,10 +1959,9 @@ int timekeeping_suspend(void)
 		}
 	}
=20
-	timekeeping_update(tk, TK_MIRROR);
-	halt_fast_timekeeper(tk);
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	timekeeping_update_from_shadow(&tk_core, 0);
+	halt_fast_timekeeper(tks);
+	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
=20
 	tick_suspend();
 	clocksource_suspend();
@@ -2130,16 +2066,17 @@ static __always_inline void timekeeping_apply_adjustm=
ent(struct timekeeper *tk,
  */
 static void timekeeping_adjust(struct timekeeper *tk, s64 offset)
 {
+	u64 ntp_tl =3D ntp_tick_length();
 	u32 mult;
=20
 	/*
 	 * Determine the multiplier from the current NTP tick length.
 	 * Avoid expensive division when the tick length doesn't change.
 	 */
-	if (likely(tk->ntp_tick =3D=3D ntp_tick_length())) {
+	if (likely(tk->ntp_tick =3D=3D ntp_tl)) {
 		mult =3D tk->tkr_mono.mult - tk->ntp_err_mult;
 	} else {
-		tk->ntp_tick =3D ntp_tick_length();
+		tk->ntp_tick =3D ntp_tl;
 		mult =3D div64_u64((tk->ntp_tick >> tk->ntp_error_shift) -
 				 tk->xtime_remainder, tk->cycle_interval);
 	}
@@ -2278,28 +2215,24 @@ static u64 logarithmic_accumulation(struct timekeeper=
 *tk, u64 offset,
  */
 static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 {
+	struct timekeeper *tk =3D &tk_core.shadow_timekeeper;
 	struct timekeeper *real_tk =3D &tk_core.timekeeper;
-	struct timekeeper *tk =3D &shadow_timekeeper;
-	u64 offset;
-	int shift =3D 0, maxshift;
 	unsigned int clock_set =3D 0;
-	unsigned long flags;
+	int shift =3D 0, maxshift;
+	u64 offset;
=20
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	guard(raw_spinlock_irqsave)(&tk_core.lock);
=20
 	/* Make sure we're fully resumed: */
 	if (unlikely(timekeeping_suspended))
-		goto out;
+		return false;
=20
 	offset =3D clocksource_delta(tk_clock_read(&tk->tkr_mono),
 				   tk->tkr_mono.cycle_last, tk->tkr_mono.mask);
=20
 	/* Check if there's really nothing to do */
 	if (offset < real_tk->cycle_interval && mode =3D=3D TK_ADV_TICK)
-		goto out;
-
-	/* Do some additional sanity checking */
-	timekeeping_check_update(tk, offset);
+		return false;
=20
 	/*
 	 * With NO_HZ we may have to accumulate many cycle_intervals
@@ -2315,8 +2248,7 @@ static bool timekeeping_advance(enum timekeeping_adv_mo=
de mode)
 	maxshift =3D (64 - (ilog2(ntp_tick_length())+1)) - 1;
 	shift =3D min(shift, maxshift);
 	while (offset >=3D tk->cycle_interval) {
-		offset =3D logarithmic_accumulation(tk, offset, shift,
-							&clock_set);
+		offset =3D logarithmic_accumulation(tk, offset, shift, &clock_set);
 		if (offset < tk->cycle_interval<<shift)
 			shift--;
 	}
@@ -2330,23 +2262,7 @@ static bool timekeeping_advance(enum timekeeping_adv_m=
ode mode)
 	 */
 	clock_set |=3D accumulate_nsecs_to_secs(tk);
=20
-	write_seqcount_begin(&tk_core.seq);
-	/*
-	 * Update the real timekeeper.
-	 *
-	 * We could avoid this memcpy by switching pointers, but that
-	 * requires changes to all other timekeeper usage sites as
-	 * well, i.e. move the timekeeper pointer getter into the
-	 * spinlocked/seqcount protected sections. And we trade this
-	 * memcpy under the tk_core.seq against one before we start
-	 * updating.
-	 */
-	timekeeping_update(tk, clock_set);
-	memcpy(real_tk, tk, sizeof(*tk));
-	/* The memcpy must come last. Do not put anything here! */
-	write_seqcount_end(&tk_core.seq);
-out:
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	timekeeping_update_from_shadow(&tk_core, clock_set);
=20
 	return !!clock_set;
 }
@@ -2394,6 +2310,94 @@ void ktime_get_coarse_real_ts64(struct timespec64 *ts)
 }
 EXPORT_SYMBOL(ktime_get_coarse_real_ts64);
=20
+/**
+ * ktime_get_coarse_real_ts64_mg - return latter of coarse grained time or f=
loor
+ * @ts:		timespec64 to be filled
+ *
+ * Fetch the global mg_floor value, convert it to realtime and compare it
+ * to the current coarse-grained time. Fill @ts with whichever is
+ * latest. Note that this is a filesystem-specific interface and should be
+ * avoided outside of that context.
+ */
+void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts)
+{
+	struct timekeeper *tk =3D &tk_core.timekeeper;
+	u64 floor =3D atomic64_read(&mg_floor);
+	ktime_t f_real, offset, coarse;
+	unsigned int seq;
+
+	do {
+		seq =3D read_seqcount_begin(&tk_core.seq);
+		*ts =3D tk_xtime(tk);
+		offset =3D tk_core.timekeeper.offs_real;
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	coarse =3D timespec64_to_ktime(*ts);
+	f_real =3D ktime_add(floor, offset);
+	if (ktime_after(f_real, coarse))
+		*ts =3D ktime_to_timespec64(f_real);
+}
+
+/**
+ * ktime_get_real_ts64_mg - attempt to update floor value and return result
+ * @ts:		pointer to the timespec to be set
+ *
+ * Get a monotonic fine-grained time value and attempt to swap it into
+ * mg_floor. If that succeeds then accept the new floor value. If it fails
+ * then another task raced in during the interim time and updated the
+ * floor.  Since any update to the floor must be later than the previous
+ * floor, either outcome is acceptable.
+ *
+ * Typically this will be called after calling ktime_get_coarse_real_ts64_mg=
(),
+ * and determining that the resulting coarse-grained timestamp did not effect
+ * a change in ctime. Any more recent floor value would effect a change to
+ * ctime, so there is no need to retry the atomic64_try_cmpxchg() on failure.
+ *
+ * @ts will be filled with the latest floor value, regardless of the outcome=
 of
+ * the cmpxchg. Note that this is a filesystem specific interface and should=
 be
+ * avoided outside of that context.
+ */
+void ktime_get_real_ts64_mg(struct timespec64 *ts)
+{
+	struct timekeeper *tk =3D &tk_core.timekeeper;
+	ktime_t old =3D atomic64_read(&mg_floor);
+	ktime_t offset, mono;
+	unsigned int seq;
+	u64 nsecs;
+
+	do {
+		seq =3D read_seqcount_begin(&tk_core.seq);
+
+		ts->tv_sec =3D tk->xtime_sec;
+		mono =3D tk->tkr_mono.base;
+		nsecs =3D timekeeping_get_ns(&tk->tkr_mono);
+		offset =3D tk_core.timekeeper.offs_real;
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	mono =3D ktime_add_ns(mono, nsecs);
+
+	/*
+	 * Attempt to update the floor with the new time value. As any
+	 * update must be later then the existing floor, and would effect
+	 * a change to ctime from the perspective of the current task,
+	 * accept the resulting floor value regardless of the outcome of
+	 * the swap.
+	 */
+	if (atomic64_try_cmpxchg(&mg_floor, &old, mono)) {
+		ts->tv_nsec =3D 0;
+		timespec64_add_ns(ts, nsecs);
+		timekeeping_inc_mg_floor_swaps();
+	} else {
+		/*
+		 * Another task changed mg_floor since "old" was fetched.
+		 * "old" has been updated with the latest value of "mg_floor".
+		 * That value is newer than the previous floor value, which
+		 * is enough to effect a change to ctime. Accept it.
+		 */
+		*ts =3D ktime_to_timespec64(ktime_add(old, offset));
+	}
+}
+
 void ktime_get_coarse_ts64(struct timespec64 *ts)
 {
 	struct timekeeper *tk =3D &tk_core.timekeeper;
@@ -2551,13 +2555,10 @@ EXPORT_SYMBOL_GPL(random_get_entropy_fallback);
  */
 int do_adjtimex(struct __kernel_timex *txc)
 {
-	struct timekeeper *tk =3D &tk_core.timekeeper;
 	struct audit_ntp_data ad;
 	bool offset_set =3D false;
 	bool clock_set =3D false;
 	struct timespec64 ts;
-	unsigned long flags;
-	s32 orig_tai, tai;
 	int ret;
=20
 	/* Validate the data before disabling interrupts */
@@ -2568,6 +2569,7 @@ int do_adjtimex(struct __kernel_timex *txc)
=20
 	if (txc->modes & ADJ_SETOFFSET) {
 		struct timespec64 delta;
+
 		delta.tv_sec  =3D txc->time.tv_sec;
 		delta.tv_nsec =3D txc->time.tv_usec;
 		if (!(txc->modes & ADJ_NANO))
@@ -2585,21 +2587,21 @@ int do_adjtimex(struct __kernel_timex *txc)
 	ktime_get_real_ts64(&ts);
 	add_device_randomness(&ts, sizeof(ts));
=20
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
-	write_seqcount_begin(&tk_core.seq);
+	scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
+		struct timekeeper *tks =3D &tk_core.shadow_timekeeper;
+		s32 orig_tai, tai;
=20
-	orig_tai =3D tai =3D tk->tai_offset;
-	ret =3D __do_adjtimex(txc, &ts, &tai, &ad);
+		orig_tai =3D tai =3D tks->tai_offset;
+		ret =3D __do_adjtimex(txc, &ts, &tai, &ad);
=20
-	if (tai !=3D orig_tai) {
-		__timekeeping_set_tai_offset(tk, tai);
-		timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
-		clock_set =3D true;
+		if (tai !=3D orig_tai) {
+			__timekeeping_set_tai_offset(tks, tai);
+			timekeeping_update_from_shadow(&tk_core, TK_CLOCK_WAS_SET);
+			clock_set =3D true;
+		} else {
+			tk_update_leap_state_all(&tk_core);
+		}
 	}
-	tk_update_leap_state(tk);
-
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
=20
 	audit_ntp_log(&ad);
=20
@@ -2623,15 +2625,8 @@ int do_adjtimex(struct __kernel_timex *txc)
  */
 void hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw=
_ts)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-
+	guard(raw_spinlock_irqsave)(&tk_core.lock);
 	__hardpps(phase_ts, raw_ts);
-
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 }
 EXPORT_SYMBOL(hardpps);
 #endif /* CONFIG_NTP_PPS */
diff --git a/kernel/time/timekeeping_debug.c b/kernel/time/timekeeping_debug.c
index b73e8850e58d..badeb222eab9 100644
--- a/kernel/time/timekeeping_debug.c
+++ b/kernel/time/timekeeping_debug.c
@@ -17,6 +17,9 @@
=20
 #define NUM_BINS 32
=20
+/* Incremented every time mg_floor is updated */
+DEFINE_PER_CPU(unsigned long, timekeeping_mg_floor_swaps);
+
 static unsigned int sleep_time_bin[NUM_BINS] =3D {0};
=20
 static int tk_debug_sleep_time_show(struct seq_file *s, void *data)
@@ -53,3 +56,13 @@ void tk_debug_account_sleep_time(const struct timespec64 *=
t)
 			   (s64)t->tv_sec, t->tv_nsec / NSEC_PER_MSEC);
 }
=20
+unsigned long timekeeping_get_mg_floor_swaps(void)
+{
+	unsigned long sum =3D 0;
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		sum +=3D data_race(per_cpu(timekeeping_mg_floor_swaps, cpu));
+
+	return sum;
+}
diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping_int=
ernal.h
index 4ca2787d1642..63e600e943a7 100644
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -10,12 +10,26 @@
  * timekeeping debug functions
  */
 #ifdef CONFIG_DEBUG_FS
+
+DECLARE_PER_CPU(unsigned long, timekeeping_mg_floor_swaps);
+
+static inline void timekeeping_inc_mg_floor_swaps(void)
+{
+	this_cpu_inc(timekeeping_mg_floor_swaps);
+}
+
 extern void tk_debug_account_sleep_time(const struct timespec64 *t);
+
 #else
+
 #define tk_debug_account_sleep_time(x)
+
+static inline void timekeeping_inc_mg_floor_swaps(void)
+{
+}
+
 #endif
=20
-#ifdef CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE
 static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
 {
 	u64 ret =3D (now - last) & mask;
@@ -26,14 +40,9 @@ static inline u64 clocksource_delta(u64 now, u64 last, u64=
 mask)
 	 */
 	return ret & ~(mask >> 1) ? 0 : ret;
 }
-#else
-static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
-{
-	return (now - last) & mask;
-}
-#endif
=20
 /* Semi public for serialization of non timekeeper VDSO updates. */
-extern raw_spinlock_t timekeeper_lock;
+unsigned long timekeeper_lock_irqsave(void);
+void timekeeper_unlock_irqrestore(unsigned long flags);
=20
 #endif /* _TIMEKEEPING_INTERNAL_H */
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 0fc9d066a7be..a283e524835d 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -37,7 +37,6 @@
 #include <linux/tick.h>
 #include <linux/kallsyms.h>
 #include <linux/irq_work.h>
-#include <linux/sched/signal.h>
 #include <linux/sched/sysctl.h>
 #include <linux/sched/nohz.h>
 #include <linux/sched/debug.h>
@@ -2422,7 +2421,8 @@ static inline void __run_timers(struct timer_base *base)
=20
 static void __run_timer_base(struct timer_base *base)
 {
-	if (time_before(jiffies, base->next_expiry))
+	/* Can race against a remote CPU updating next_expiry under the lock */
+	if (time_before(jiffies, READ_ONCE(base->next_expiry)))
 		return;
=20
 	timer_base_lock_expiry(base);
@@ -2526,141 +2526,6 @@ void update_process_times(int user_tick)
 		run_posix_cpu_timers();
 }
=20
-/*
- * Since schedule_timeout()'s timer is defined on the stack, it must store
- * the target task on the stack as well.
- */
-struct process_timer {
-	struct timer_list timer;
-	struct task_struct *task;
-};
-
-static void process_timeout(struct timer_list *t)
-{
-	struct process_timer *timeout =3D from_timer(timeout, t, timer);
-
-	wake_up_process(timeout->task);
-}
-
-/**
- * schedule_timeout - sleep until timeout
- * @timeout: timeout value in jiffies
- *
- * Make the current task sleep until @timeout jiffies have elapsed.
- * The function behavior depends on the current task state
- * (see also set_current_state() description):
- *
- * %TASK_RUNNING - the scheduler is called, but the task does not sleep
- * at all. That happens because sched_submit_work() does nothing for
- * tasks in %TASK_RUNNING state.
- *
- * %TASK_UNINTERRUPTIBLE - at least @timeout jiffies are guaranteed to
- * pass before the routine returns unless the current task is explicitly
- * woken up, (e.g. by wake_up_process()).
- *
- * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
- * delivered to the current task or the current task is explicitly woken
- * up.
- *
- * The current task state is guaranteed to be %TASK_RUNNING when this
- * routine returns.
- *
- * Specifying a @timeout value of %MAX_SCHEDULE_TIMEOUT will schedule
- * the CPU away without a bound on the timeout. In this case the return
- * value will be %MAX_SCHEDULE_TIMEOUT.
- *
- * Returns 0 when the timer has expired otherwise the remaining time in
- * jiffies will be returned. In all cases the return value is guaranteed
- * to be non-negative.
- */
-signed long __sched schedule_timeout(signed long timeout)
-{
-	struct process_timer timer;
-	unsigned long expire;
-
-	switch (timeout)
-	{
-	case MAX_SCHEDULE_TIMEOUT:
-		/*
-		 * These two special cases are useful to be comfortable
-		 * in the caller. Nothing more. We could take
-		 * MAX_SCHEDULE_TIMEOUT from one of the negative value
-		 * but I' d like to return a valid offset (>=3D0) to allow
-		 * the caller to do everything it want with the retval.
-		 */
-		schedule();
-		goto out;
-	default:
-		/*
-		 * Another bit of PARANOID. Note that the retval will be
-		 * 0 since no piece of kernel is supposed to do a check
-		 * for a negative retval of schedule_timeout() (since it
-		 * should never happens anyway). You just have the printk()
-		 * that will tell you if something is gone wrong and where.
-		 */
-		if (timeout < 0) {
-			printk(KERN_ERR "schedule_timeout: wrong timeout "
-				"value %lx\n", timeout);
-			dump_stack();
-			__set_current_state(TASK_RUNNING);
-			goto out;
-		}
-	}
-
-	expire =3D timeout + jiffies;
-
-	timer.task =3D current;
-	timer_setup_on_stack(&timer.timer, process_timeout, 0);
-	__mod_timer(&timer.timer, expire, MOD_TIMER_NOTPENDING);
-	schedule();
-	del_timer_sync(&timer.timer);
-
-	/* Remove the timer from the object tracker */
-	destroy_timer_on_stack(&timer.timer);
-
-	timeout =3D expire - jiffies;
-
- out:
-	return timeout < 0 ? 0 : timeout;
-}
-EXPORT_SYMBOL(schedule_timeout);
-
-/*
- * We can use __set_current_state() here because schedule_timeout() calls
- * schedule() unconditionally.
- */
-signed long __sched schedule_timeout_interruptible(signed long timeout)
-{
-	__set_current_state(TASK_INTERRUPTIBLE);
-	return schedule_timeout(timeout);
-}
-EXPORT_SYMBOL(schedule_timeout_interruptible);
-
-signed long __sched schedule_timeout_killable(signed long timeout)
-{
-	__set_current_state(TASK_KILLABLE);
-	return schedule_timeout(timeout);
-}
-EXPORT_SYMBOL(schedule_timeout_killable);
-
-signed long __sched schedule_timeout_uninterruptible(signed long timeout)
-{
-	__set_current_state(TASK_UNINTERRUPTIBLE);
-	return schedule_timeout(timeout);
-}
-EXPORT_SYMBOL(schedule_timeout_uninterruptible);
-
-/*
- * Like schedule_timeout_uninterruptible(), except this task will not contri=
bute
- * to load average.
- */
-signed long __sched schedule_timeout_idle(signed long timeout)
-{
-	__set_current_state(TASK_IDLE);
-	return schedule_timeout(timeout);
-}
-EXPORT_SYMBOL(schedule_timeout_idle);
-
 #ifdef CONFIG_HOTPLUG_CPU
 static void migrate_timer_list(struct timer_base *new_base, struct hlist_hea=
d *head)
 {
@@ -2757,59 +2622,3 @@ void __init init_timers(void)
 	posix_cputimers_init_work();
 	open_softirq(TIMER_SOFTIRQ, run_timer_softirq);
 }
-
-/**
- * msleep - sleep safely even with waitqueue interruptions
- * @msecs: Time in milliseconds to sleep for
- */
-void msleep(unsigned int msecs)
-{
-	unsigned long timeout =3D msecs_to_jiffies(msecs);
-
-	while (timeout)
-		timeout =3D schedule_timeout_uninterruptible(timeout);
-}
-
-EXPORT_SYMBOL(msleep);
-
-/**
- * msleep_interruptible - sleep waiting for signals
- * @msecs: Time in milliseconds to sleep for
- */
-unsigned long msleep_interruptible(unsigned int msecs)
-{
-	unsigned long timeout =3D msecs_to_jiffies(msecs);
-
-	while (timeout && !signal_pending(current))
-		timeout =3D schedule_timeout_interruptible(timeout);
-	return jiffies_to_msecs(timeout);
-}
-
-EXPORT_SYMBOL(msleep_interruptible);
-
-/**
- * usleep_range_state - Sleep for an approximate time in a given state
- * @min:	Minimum time in usecs to sleep
- * @max:	Maximum time in usecs to sleep
- * @state:	State of the current task that will be while sleeping
- *
- * In non-atomic context where the exact wakeup time is flexible, use
- * usleep_range_state() instead of udelay().  The sleep improves responsiven=
ess
- * by avoiding the CPU-hogging busy-wait of udelay(), and the range reduces
- * power usage by allowing hrtimers to take advantage of an already-
- * scheduled interrupt instead of scheduling a new one just for this sleep.
- */
-void __sched usleep_range_state(unsigned long min, unsigned long max,
-				unsigned int state)
-{
-	ktime_t exp =3D ktime_add_us(ktime_get(), min);
-	u64 delta =3D (u64)(max - min) * NSEC_PER_USEC;
-
-	for (;;) {
-		__set_current_state(state);
-		/* Do not return before the requested sleep time has elapsed */
-		if (!schedule_hrtimeout_range(&exp, delta, HRTIMER_MODE_ABS))
-			break;
-	}
-}
-EXPORT_SYMBOL(usleep_range_state);
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 9193d6133e5d..98488b20b594 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -151,9 +151,8 @@ void update_vsyscall_tz(void)
 unsigned long vdso_update_begin(void)
 {
 	struct vdso_data *vdata =3D __arch_get_k_vdso_data();
-	unsigned long flags;
+	unsigned long flags =3D timekeeper_lock_irqsave();
=20
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
 	vdso_write_begin(vdata);
 	return flags;
 }
@@ -172,5 +171,5 @@ void vdso_update_end(unsigned long flags)
=20
 	vdso_write_end(vdata);
 	__arch_sync_vdso_data(vdata);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	timekeeper_unlock_irqrestore(flags);
 }
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7315f643817a..14977b9fc254 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1328,19 +1328,6 @@ config SCHEDSTATS
=20
 endmenu
=20
-config DEBUG_TIMEKEEPING
-	bool "Enable extra timekeeping sanity checking"
-	help
-	  This option will enable additional timekeeping sanity checks
-	  which may be helpful when diagnosing issues where timekeeping
-	  problems are suspected.
-
-	  This may include checks in the timekeeping hotpaths, so this
-	  option may have a (very small) performance impact to some
-	  workloads.
-
-	  If unsure, say N.
-
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPTION && TRACE_IRQFLAGS_SUPPORT
diff --git a/mm/damon/core.c b/mm/damon/core.c
index a83f3b736d51..79efd8089d6c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1892,11 +1892,10 @@ static unsigned long damos_wmark_wait_us(struct damos=
 *scheme)
=20
 static void kdamond_usleep(unsigned long usecs)
 {
-	/* See Documentation/timers/timers-howto.rst for the thresholds */
-	if (usecs > 20 * USEC_PER_MSEC)
+	if (usecs >=3D USLEEP_RANGE_UPPER_BOUND)
 		schedule_timeout_idle(usecs_to_jiffies(usecs));
 	else
-		usleep_idle_range(usecs, usecs + 1);
+		usleep_range_idle(usecs, usecs + 1);
 }
=20
 /* Returns negative error code if it's not activated but should return */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1c82dcdf6e8f..4bd94d432bcf 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -42,8 +42,6 @@
 #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
 		 "\x00\x00\x00\x00\x00\x00\x00\x00"
=20
-#define secs_to_jiffies(_secs) msecs_to_jiffies((_secs) * 1000)
-
 /* Handle HCI Event packets */
=20
 static void *hci_ev_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 34f68ef74b8f..7e23cacbe66e 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2285,7 +2285,7 @@ static void spin(struct pktgen_dev *pkt_dev, ktime_t sp=
in_until)
 	s64 remaining;
 	struct hrtimer_sleeper t;
=20
-	hrtimer_init_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_setup_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	hrtimer_set_expires(&t.timer, spin_until);
=20
 	remaining =3D ktime_to_ns(hrtimer_expires_remaining(&t.timer));
diff --git a/net/netfilter/xt_IDLETIMER.c b/net/netfilter/xt_IDLETIMER.c
index db720efa811d..5514600586a9 100644
--- a/net/netfilter/xt_IDLETIMER.c
+++ b/net/netfilter/xt_IDLETIMER.c
@@ -107,14 +107,12 @@ static void idletimer_tg_expired(struct timer_list *t)
 	schedule_work(&timer->work);
 }
=20
-static enum alarmtimer_restart idletimer_tg_alarmproc(struct alarm *alarm,
-							  ktime_t now)
+static void idletimer_tg_alarmproc(struct alarm *alarm, ktime_t now)
 {
 	struct idletimer_tg *timer =3D alarm->data;
=20
 	pr_debug("alarm %s expired\n", timer->attr.attr.name);
 	schedule_work(&timer->work);
-	return ALARMTIMER_NORESTART;
 }
=20
 static int idletimer_check_sysfs_name(const char *name, unsigned int size)
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4427572b2477..98790fe5115d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6597,11 +6597,11 @@ sub process {
 			# ignore udelay's < 10, however
 			if (! ($delay < 10) ) {
 				CHK("USLEEP_RANGE",
-				    "usleep_range is preferred over udelay; see Documentation/timers/tim=
ers-howto.rst\n" . $herecurr);
+				    "usleep_range is preferred over udelay; see function description of =
usleep_range() and udelay().\n" . $herecurr);
 			}
 			if ($delay > 2000) {
 				WARN("LONG_UDELAY",
-				     "long udelay - prefer mdelay; see arch/arm/include/asm/delay.h\n" .=
 $herecurr);
+				     "long udelay - prefer mdelay; see function description of mdelay().=
\n" . $herecurr);
 			}
 		}
=20
@@ -6609,7 +6609,7 @@ sub process {
 		if ($line =3D~ /\bmsleep\s*\((\d+)\);/) {
 			if ($1 < 20) {
 				WARN("MSLEEP",
-				     "msleep < 20ms can sleep for up to 20ms; see Documentation/timers/t=
imers-howto.rst\n" . $herecurr);
+				     "msleep < 20ms can sleep for up to 20ms; see function description o=
f msleep().\n" . $herecurr);
 			}
 		}
=20
@@ -7077,11 +7077,11 @@ sub process {
 			my $max =3D $7;
 			if ($min eq $max) {
 				WARN("USLEEP_RANGE",
-				     "usleep_range should not use min =3D=3D max args; see Documentation=
/timers/timers-howto.rst\n" . "$here\n$stat\n");
+				     "usleep_range should not use min =3D=3D max args;  see function des=
cription of usleep_range().\n" . "$here\n$stat\n");
 			} elsif ($min =3D~ /^\d+$/ && $max =3D~ /^\d+$/ &&
 				 $min > $max) {
 				WARN("USLEEP_RANGE",
-				     "usleep_range args reversed, use min then max; see Documentation/ti=
mers/timers-howto.rst\n" . "$here\n$stat\n");
+				     "usleep_range args reversed, use min then max;  see function descri=
ption of usleep_range().\n" . "$here\n$stat\n");
 			}
 		}
=20
diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index 2584621c3b2d..d73644e85b6e 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -597,12 +597,12 @@ snd_sof_is_chain_dma_supported(struct snd_sof_dev *sdev=
, u32 dai_type)
  * @addr: Address to poll
  * @val: Variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @sleep_us: Maximum time to sleep between reads in us (0
- *            tight-loops).  Should be less than ~20ms since usleep_range
- *            is used (see Documentation/timers/timers-howto.rst).
+ * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Ple=
ase
+ *            read usleep_range() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  *
- * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
  * case, the last read value at @addr is stored in @val. Must not
  * be called from atomic context if sleep_us or timeout_us are used.
  *
diff --git a/tools/testing/selftests/wireguard/qemu/debug.config b/tools/test=
ing/selftests/wireguard/qemu/debug.config
index 9d172210e2c6..139fd9aa8b12 100644
--- a/tools/testing/selftests/wireguard/qemu/debug.config
+++ b/tools/testing/selftests/wireguard/qemu/debug.config
@@ -31,7 +31,6 @@ CONFIG_SCHED_DEBUG=3Dy
 CONFIG_SCHED_INFO=3Dy
 CONFIG_SCHEDSTATS=3Dy
 CONFIG_SCHED_STACK_END_CHECK=3Dy
-CONFIG_DEBUG_TIMEKEEPING=3Dy
 CONFIG_DEBUG_PREEMPT=3Dy
 CONFIG_DEBUG_RT_MUTEXES=3Dy
 CONFIG_DEBUG_SPINLOCK=3Dy


