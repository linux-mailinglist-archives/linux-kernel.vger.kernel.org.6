Return-Path: <linux-kernel+bounces-572921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C740A6D070
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EE43A6F31
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 17:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651A319E806;
	Sun, 23 Mar 2025 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IIKvQ9XE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+aRnhk3H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F09A19004B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742752309; cv=none; b=ssns32nn+djoFZcbLWP/HP6+Rm9JFs+b5btDV14MuCljC3N+arnuDtWPbK1XCFStNr9HX+0tmUO8Mn4r4CMBwaBgVjfH00NKG1sHsdvQGbmK/fbgBD2LPoWp7jdoWGSZjwgl8kWqftgI6fN/esu+jzvtIRSm8krp/LKXzzR87LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742752309; c=relaxed/simple;
	bh=0JCjq8QWMF3hUiSOJzUC89Ez/RP8hYOoJpoE5eYn7ME=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=Blsls6rQ0SfxnpPyNZZdZK5gm6KldLOGjB2+94+fZ4HP5yz7bUPeAR/VKzSEQrSMKe0O6b7+wzB3uoAKP0+3uwVCmXdmsfGDhwQMEjZrard4qxicpeW9MLz3lTePbvirzKRUpjQPu8gtuQgdNnmJgNXIv3wbdvXk7gGpp7XvfvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IIKvQ9XE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+aRnhk3H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742752301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=gaT2IHy6W5UHcOiWfBK+y2Zke5HtDaOH5cMi+YECTjY=;
	b=IIKvQ9XEalvFcLTXB2eCHiU4nUdrpeptqjFFbhaYN9k+ZQ803FvwBHSLMraZD7szxzLxzm
	11Dm0xL8yOdAg+X4UYmpmh4tBuleGLWTW/+Yovcft/uI8AwhWJkoLdJA07QNRXTQ8OkVzO
	5JzG97ZhmD+AHyp6t/AgEHr0Y8NshKyyKJC1ERvQ9zxcQPFQ99PHhf9jWpW0AEvAqQfzU+
	PYoJPZuFiZV/T20Szx147LUB2mBlfqIXn/IwoNAdnqKeFGH1kPmBMBDqqj7/Pd9Wr5UQGc
	QoDNav2JDxRZ1hDzIy04LiWIWWgDThkKbnMbN0lEFmJxN2KrKIUIhX1NbWI7AQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742752301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=gaT2IHy6W5UHcOiWfBK+y2Zke5HtDaOH5cMi+YECTjY=;
	b=+aRnhk3HNZBPASzpCD+SDD7UwHGW31Ldn7H3Asv+wzNlQ8tLfcb3/I0pZ7/7KReea9dng1
	Jl24V35dsJh9wTAw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/cleanups for v6.15-rc1
References: <174275225552.1561082.4969731002775597670.tglx@xen13>
Message-ID: <174275226234.1561082.3090009452237682595.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 23 Mar 2025 18:51:40 +0100 (CET)

Linus,

please pull the latest timers/cleanups branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-cleanups-=
2025-03-23

up to:  86a578e780a9: wifi: rt2x00: Switch to use hrtimer_update_function()


A treewide hrtimer timer cleanup

  hrtimers are initialized with hrtimer_init() and a subsequent store to
  the callback pointer. This turned out to be suboptimal for the upcoming
  Rust integration and is obviously a silly implementation to begin with.

  This cleanup replaces the hrtimer_init(T); T->function =3D cb; sequence
  with hrtimer_setup(T, cb);

  The conversion was done with Coccinelle and a few manual fixups.

  Once the conversion has completely landed in mainline, hrtimer_init()
  will be removed and the hrtimer::function becomes a private member.

Note: There are a few known duplicate commits as some maintainers picked up
      the subsystem specific patches after the lot was merged into tip.

Thanks,

	tglx

------------------>
Nam Cao (100):
      KVM: MIPS: Switch to use hrtimer_setup()
      KVM: PPC: Switch to use hrtimer_setup()
      KVM: s390: Switch to use hrtimer_setup()
      KVM: x86: Switch to use hrtimer_setup()
      KVM: arm64: Switch to use hrtimer_setup()
      LoongArch: KVM: Switch to use hrtimer_setup()
      riscv: kvm: Switch to use hrtimer_setup()
      ARM: imx: Switch to use hrtimer_setup()
      ARM: 8611/1: l2x0: Switch to use hrtimer_setup()
      powerpc/watchdog: Switch to use hrtimer_setup()
      perf/x86: Switch to use hrtimer_setup()
      s390/ap_bus: Switch to use hrtimer_setup()
      sched: Switch to use hrtimer_setup()
      mm/slab: Switch to use hrtimer_setup()
      lib: test_objpool: Switch to use hrtimer_setup()
      io_uring/timeout: Switch to use hrtimer_setup()
      fork: Switch to use hrtimer_setup()
      perf: Switch to use hrtimer_setup()
      timerfd: Switch to use hrtimer_setup()
      time: Switch to hrtimer_setup()
      bpf: Switch to use hrtimer_setup()
      ubifs: Switch to use hrtimer_setup()
      watchdog: Switch to use hrtimer_setup()
      tracing/osnoise: Switch to use hrtimer_setup()
      block, bfq: Switch to use hrtimer_setup()
      ata: pata_octeon_cf: Switch to use hrtimer_setup()
      blk_iocost: Switch to use hrtimer_setup()
      PM: runtime: Switch to use hrtimer_setup()
      PM / devfreq: rockchip-dfi: Switch to use hrtimer_setup()
      null_blk: Switch to use hrtimer_setup()
      hwrng: timeriomem: Switch to use hrtimer_setup()
      netdev: Switch to use hrtimer_setup()
      net/sched: Switch to use hrtimer_setup()
      mac802154: Switch to use hrtimer_setup()
      tcp: Switch to use hrtimer_setup()
      can: m_can: Switch to use hrtimer_setup()
      can: mcp251xfd: Switch to use hrtimer_setup()
      can: Switch to use hrtimer_setup()
      net: ethernet: ti: Switch to use hrtimer_setup()
      net: ethernet: cortina: Switch to use hrtimer_setup()
      net: ethernet: ec_bhf: Switch to use hrtimer_setup()
      net: ethernet: hisilicon: Switch to use hrtimer_setup()
      net: sparx5: Switch to use hrtimer_setup()
      net: ieee802154: at86rf230: Switch to use hrtimer_setup()
      net: mvpp2: Switch to use hrtimer_setup()
      net: qualcomm: rmnet: Switch to use hrtimer_setup()
      net: stmmac: Switch to use hrtimer_setup()
      net: fec: Switch to use hrtimer_setup()
      net: wwan: iosm: Switch to use hrtimer_setup()
      net/cdc_ncm: Switch to use hrtimer_setup()
      wifi: Switch to use hrtimer_setup()
      wifi: rt2x00: Switch to use hrtimer_setup()
      igc: Switch to use hrtimer_setup()
      octeontx2-pf: Switch to use hrtimer_setup()
      xfrm: Switch to use hrtimer_setup()
      USB: chipidea: Switch to use hrtimer_setup()
      usb: dwc2: Switch to use hrtimer_setup()
      usb: fotg210-hcd: Switch to use hrtimer_setup()
      usb: gadget: Switch to use hrtimer_setup()
      usb: ehci: Switch to use hrtimer_setup()
      usb: musb: cppi41: Switch to use hrtimer_setup()
      usb: typec: tcpm: Switch to use hrtimer_setup()
      serial: 8250: Switch to use hrtimer_setup()
      serial: amba-pl011: Switch to use hrtimer_setup()
      serial: imx: Switch to use hrtimer_setup()
      serial: sh-sci: Switch to use hrtimer_setup()
      serial: xilinx_uartps: Switch to use hrtimer_setup()
      scsi: Switch to use hrtimer_setup()
      rtc: class: Switch to use hrtimer_setup()
      pps: generators: pps_gen_parport: Switch to use hrtimer_setup()
      powercap: Switch to use hrtimer_setup()
      power: supply: ab8500_chargalg: Switch to use hrtimer_setup()
      power: reset: ltc2952-poweroff: Switch to use hrtimer_setup()
      drivers: perf: Switch to use hrtimer_setup()
      ntb: ntb_pingpong: Switch to use hrtimer_setup()
      mmc: dw_mmc: Switch to use hrtimer_setup()
      misc: vcpu_stall_detector: Switch to use hrtimer_setup()
      media: Switch to use hrtimer_setup()
      mailbox: Switch to use hrtimer_setup()
      leds: trigger: pattern: Switch to use hrtimer_setup()
      iio: Switch to use hrtimer_setup()
      i2c: Switch to use hrtimer_setup()
      stm class: heartbeat: Switch to use hrtimer_setup()
      drm/amdgpu: Switch to use hrtimer_setup()
      drm/i915/huc: Switch to use hrtimer_setup()
      drm/i915/gvt: Switch to use hrtimer_setup()
      drm/i915/perf: Switch to use hrtimer_setup()
      drm/i915/pmu: Switch to use hrtimer_setup()
      drm/i915/uncore: Switch to use hrtimer_setup()
      drm/i915/request: Switch to use hrtimer_setup()
      drm/msm: Switch to use hrtimer_setup()
      drm/vkms: Switch to use hrtimer_setup()
      drm/xe/oa: Switch to use hrtimer_setup()
      drm/vmwgfx: Switch to use hrtimer_setup()
      virtio: mem: Switch to use hrtimer_setup()
      RDMA: Switch to use hrtimer_setup()
      ASoC: fsl: imx-pcm-fiq: Switch to use hrtimer_setup()
      serial: xilinx_uartps: Use helper function hrtimer_update_function()
      io_uring: Use helper function hrtimer_update_function()
      wifi: rt2x00: Switch to use hrtimer_update_function()


 arch/arm/mach-imx/mmdc.c                           |  5 ++---
 arch/arm/mm/cache-l2x0-pmu.c                       |  3 +--
 arch/arm64/kvm/arch_timer.c                        |  7 +++----
 arch/loongarch/kvm/vcpu.c                          |  4 ++--
 arch/mips/kvm/mips.c                               |  5 ++---
 arch/powerpc/kernel/watchdog.c                     |  3 +--
 arch/powerpc/kvm/powerpc.c                         |  4 ++--
 arch/riscv/kvm/vcpu_timer.c                        |  7 ++++---
 arch/s390/kvm/interrupt.c                          |  3 +--
 arch/s390/kvm/kvm-s390.c                           |  4 ++--
 arch/x86/events/intel/uncore.c                     |  3 +--
 arch/x86/events/rapl.c                             |  3 +--
 arch/x86/kvm/hyperv.c                              |  3 +--
 arch/x86/kvm/i8254.c                               |  3 +--
 arch/x86/kvm/lapic.c                               |  5 ++---
 arch/x86/kvm/vmx/nested.c                          |  5 ++---
 arch/x86/kvm/xen.c                                 |  4 ++--
 block/bfq-iosched.c                                |  5 ++---
 block/blk-iocost.c                                 |  3 +--
 drivers/ata/pata_octeon_cf.c                       |  5 ++---
 drivers/base/power/runtime.c                       |  4 ++--
 drivers/block/null_blk/main.c                      |  7 +++----
 drivers/char/hw_random/timeriomem-rng.c            |  3 +--
 drivers/devfreq/event/rockchip-dfi.c               |  3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |  4 ++--
 drivers/gpu/drm/i915/gt/uc/intel_huc.c             |  4 ++--
 drivers/gpu/drm/i915/gvt/display.c                 |  3 +--
 drivers/gpu/drm/i915/gvt/sched_policy.c            |  3 +--
 drivers/gpu/drm/i915/i915_perf.c                   |  5 ++---
 drivers/gpu/drm/i915/i915_pmu.c                    |  3 +--
 drivers/gpu/drm/i915/i915_request.c                |  3 +--
 drivers/gpu/drm/i915/intel_uncore.c                |  3 +--
 drivers/gpu/drm/msm/msm_fence.c                    |  3 +--
 drivers/gpu/drm/msm/msm_io_utils.c                 |  3 +--
 drivers/gpu/drm/vkms/vkms_crtc.c                   |  4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c               |  4 ++--
 drivers/gpu/drm/xe/xe_oa.c                         |  4 ++--
 drivers/hwtracing/stm/heartbeat.c                  |  6 ++----
 drivers/i2c/busses/i2c-imx.c                       |  4 ++--
 drivers/iio/adc/ti-tsc2046.c                       |  4 +---
 drivers/iio/trigger/iio-trig-hrtimer.c             |  4 ++--
 drivers/infiniband/hw/hfi1/init.c                  |  5 ++---
 drivers/infiniband/sw/rdmavt/qp.c                  |  5 ++---
 drivers/leds/trigger/ledtrig-pattern.c             |  4 ++--
 drivers/mailbox/mailbox.c                          |  4 +---
 drivers/media/cec/core/cec-pin.c                   |  3 +--
 drivers/media/pci/cx88/cx88-input.c                |  3 +--
 .../media/platform/chips-media/wave5/wave5-vpu.c   |  4 ++--
 drivers/media/rc/pwm-ir-tx.c                       |  3 +--
 drivers/misc/vcpu_stall_detector.c                 |  3 +--
 drivers/mmc/host/dw_mmc.c                          |  3 +--
 drivers/net/can/m_can/m_can.c                      |  9 ++++----
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c     |  8 ++++----
 drivers/net/ethernet/cortina/gemini.c              |  5 ++---
 drivers/net/ethernet/ec_bhf.c                      |  3 +--
 drivers/net/ethernet/freescale/fec_ptp.c           |  4 ++--
 drivers/net/ethernet/hisilicon/hip04_eth.c         |  4 +---
 drivers/net/ethernet/intel/igc/igc_main.c          |  4 ++--
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |  5 ++---
 drivers/net/ethernet/marvell/octeontx2/af/ptp.c    |  3 +--
 .../net/ethernet/microchip/sparx5/sparx5_packet.c  |  4 ++--
 .../net/ethernet/qualcomm/rmnet/rmnet_map_data.c   |  4 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  6 ++----
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |  9 ++++----
 drivers/net/ethernet/ti/icssg/icssg_common.c       |  5 ++---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |  5 ++---
 drivers/net/ieee802154/at86rf230.c                 |  4 ++--
 drivers/net/usb/cdc_ncm.c                          |  3 +--
 .../net/wireless/mediatek/mt76/mt76x02_usb_core.c  |  4 ++--
 drivers/net/wireless/ralink/rt2x00/rt2800mmio.c    |  2 +-
 drivers/net/wireless/ralink/rt2x00/rt2800usb.c     |  2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c     |  4 ++--
 drivers/net/wireless/virtual/mac80211_hwsim.c      |  6 ++----
 drivers/net/wwan/iosm/iosm_ipc_imem.c              | 24 +++++++++-----------=
--
 drivers/ntb/test/ntb_pingpong.c                    |  3 +--
 drivers/perf/arm-ccn.c                             |  5 ++---
 drivers/perf/marvell_cn10k_ddr_pmu.c               |  4 ++--
 drivers/perf/thunderx2_pmu.c                       |  5 ++---
 drivers/power/reset/ltc2952-poweroff.c             |  8 ++++----
 drivers/power/supply/ab8500_chargalg.c             |  9 ++++----
 drivers/powercap/idle_inject.c                     |  3 +--
 drivers/powercap/intel_rapl_common.c               |  3 +--
 drivers/pps/generators/pps_gen_parport.c           |  3 +--
 drivers/rtc/class.c                                |  3 +--
 drivers/s390/crypto/ap_bus.c                       |  3 +--
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c           |  4 +---
 drivers/scsi/lpfc/lpfc_init.c                      |  7 +++----
 drivers/scsi/scsi_debug.c                          |  4 ++--
 drivers/tty/serial/8250/8250_bcm7271.c             |  3 +--
 drivers/tty/serial/8250/8250_port.c                | 10 ++++-----
 drivers/tty/serial/amba-pl011.c                    |  9 ++++----
 drivers/tty/serial/imx.c                           |  8 ++++----
 drivers/tty/serial/sh-sci.c                        |  3 +--
 drivers/tty/serial/xilinx_uartps.c                 |  8 ++++----
 drivers/usb/chipidea/otg_fsm.c                     |  3 +--
 drivers/usb/dwc2/hcd_queue.c                       |  3 +--
 drivers/usb/fotg210/fotg210-hcd.c                  |  3 +--
 drivers/usb/gadget/function/f_ncm.c                |  3 +--
 drivers/usb/gadget/udc/dummy_hcd.c                 |  6 ++----
 drivers/usb/host/ehci-hcd.c                        |  3 +--
 drivers/usb/musb/musb_cppi41.c                     |  4 ++--
 drivers/usb/typec/tcpm/tcpm.c                      | 16 +++++++--------
 drivers/virtio/virtio_mem.c                        |  4 ++--
 drivers/watchdog/softdog.c                         |  8 +++-----
 drivers/watchdog/watchdog_dev.c                    |  4 ++--
 drivers/watchdog/watchdog_hrtimer_pretimeout.c     |  4 ++--
 fs/timerfd.c                                       |  5 ++---
 fs/ubifs/io.c                                      |  3 +--
 include/linux/hrtimer.h                            |  5 +++++
 io_uring/io_uring.c                                |  2 +-
 io_uring/timeout.c                                 | 13 ++++++------
 kernel/bpf/helpers.c                               |  3 +--
 kernel/events/core.c                               |  7 +++----
 kernel/fork.c                                      |  3 +--
 kernel/sched/core.c                                |  3 +--
 kernel/sched/deadline.c                            |  6 ++----
 kernel/sched/fair.c                                |  8 ++++----
 kernel/sched/rt.c                                  |  5 ++---
 kernel/time/hrtimer.c                              |  5 -----
 kernel/time/ntp.c                                  |  3 +--
 kernel/time/posix-timers.c                         |  7 +++----
 kernel/time/sched_clock.c                          |  3 +--
 kernel/time/tick-broadcast-hrtimer.c               |  3 +--
 kernel/time/tick-sched.c                           |  6 ++----
 kernel/trace/trace_osnoise.c                       |  6 ++----
 kernel/watchdog.c                                  |  3 +--
 lib/test_objpool.c                                 |  3 +--
 mm/slab_common.c                                   |  4 ++--
 net/can/bcm.c                                      | 20 ++++++++----------
 net/can/isotp.c                                    | 10 ++++-----
 net/can/j1939/bus.c                                |  4 ++--
 net/can/j1939/transport.c                          |  8 ++------
 net/core/dev.c                                     |  3 +--
 net/ipv4/tcp_timer.c                               | 10 ++++-----
 net/mac802154/main.c                               |  4 ++--
 net/sched/act_gate.c                               |  3 +--
 net/sched/sch_api.c                                |  3 +--
 net/sched/sch_taprio.c                             |  6 ++----
 net/xfrm/xfrm_iptfs.c                              |  6 ++----
 net/xfrm/xfrm_state.c                              |  4 ++--
 sound/soc/fsl/imx-pcm-fiq.c                        |  3 +--
 141 files changed, 281 insertions(+), 404 deletions(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index e898f7c2733e..94e4f4a2f73f 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -509,9 +509,8 @@ static int imx_mmdc_perf_init(struct platform_device *pde=
v, void __iomem *mmdc_b
 	pmu_mmdc->mmdc_ipg_clk =3D mmdc_ipg_clk;
 	pmu_mmdc->devtype_data =3D device_get_match_data(&pdev->dev);
=20
-	hrtimer_init(&pmu_mmdc->hrtimer, CLOCK_MONOTONIC,
-			HRTIMER_MODE_REL);
-	pmu_mmdc->hrtimer.function =3D mmdc_pmu_timer_handler;
+	hrtimer_setup(&pmu_mmdc->hrtimer, mmdc_pmu_timer_handler, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
 	cpumask_set_cpu(raw_smp_processor_id(), &pmu_mmdc->cpu);
=20
diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
index 993fefdc167a..93ef0502b7ff 100644
--- a/arch/arm/mm/cache-l2x0-pmu.c
+++ b/arch/arm/mm/cache-l2x0-pmu.c
@@ -539,8 +539,7 @@ static __init int l2x0_pmu_init(void)
 	 * at higher frequencies.
 	 */
 	l2x0_pmu_poll_period =3D ms_to_ktime(1000);
-	hrtimer_init(&l2x0_pmu_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	l2x0_pmu_hrtimer.function =3D l2x0_pmu_poll;
+	hrtimer_setup(&l2x0_pmu_hrtimer, l2x0_pmu_poll, CLOCK_MONOTONIC, HRTIMER_MO=
DE_REL);
=20
 	cpumask_set_cpu(0, &pmu_cpu);
 	ret =3D cpuhp_setup_state_nocalls(CPUHP_AP_PERF_ARM_L2X0_ONLINE,
diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 70802e4c91cf..5133dcbfe9f7 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -1070,8 +1070,7 @@ static void timer_context_init(struct kvm_vcpu *vcpu, i=
nt timerid)
 	else
 		ctxt->offset.vm_offset =3D &kvm->arch.timer_data.poffset;
=20
-	hrtimer_init(&ctxt->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	ctxt->hrtimer.function =3D kvm_hrtimer_expire;
+	hrtimer_setup(&ctxt->hrtimer, kvm_hrtimer_expire, CLOCK_MONOTONIC, HRTIMER_=
MODE_ABS_HARD);
=20
 	switch (timerid) {
 	case TIMER_PTIMER:
@@ -1098,8 +1097,8 @@ void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
 		timer_set_offset(vcpu_ptimer(vcpu), 0);
 	}
=20
-	hrtimer_init(&timer->bg_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	timer->bg_timer.function =3D kvm_bg_timer_expire;
+	hrtimer_setup(&timer->bg_timer, kvm_bg_timer_expire, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_HARD);
 }
=20
 void kvm_timer_init_vm(struct kvm *kvm)
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 20f941af3e9e..6230458d579a 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1459,8 +1459,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	vcpu->arch.vpid =3D 0;
 	vcpu->arch.flush_gpa =3D INVALID_GPA;
=20
-	hrtimer_init(&vcpu->arch.swtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_=
HARD);
-	vcpu->arch.swtimer.function =3D kvm_swtimer_wakeup;
+	hrtimer_setup(&vcpu->arch.swtimer, kvm_swtimer_wakeup, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_PINNED_HARD);
=20
 	vcpu->arch.handle_exit =3D kvm_handle_exit;
 	vcpu->arch.guest_eentry =3D (unsigned long)kvm_loongarch_ops->exc_entry;
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 60b43ea85c12..cef3c423a41a 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -288,9 +288,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	if (err)
 		return err;
=20
-	hrtimer_init(&vcpu->arch.comparecount_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	vcpu->arch.comparecount_timer.function =3D kvm_mips_comparecount_wakeup;
+	hrtimer_setup(&vcpu->arch.comparecount_timer, kvm_mips_comparecount_wakeup,=
 CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
 	/*
 	 * Allocate space for host mode exception handlers that handle
diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 8c464a5d8246..2429cb1c7baa 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -495,8 +495,7 @@ static void start_watchdog(void *arg)
=20
 	*this_cpu_ptr(&wd_timer_tb) =3D get_tb();
=20
-	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	hrtimer->function =3D watchdog_timer_fn;
+	hrtimer_setup(hrtimer, watchdog_timer_fn, CLOCK_MONOTONIC, HRTIMER_MODE_REL=
);
 	hrtimer_start(hrtimer, ms_to_ktime(wd_timer_period_ms),
 		      HRTIMER_MODE_REL_PINNED);
 }
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index ce1d91eed231..61f2b7e007fa 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -766,8 +766,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 {
 	int err;
=20
-	hrtimer_init(&vcpu->arch.dec_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
-	vcpu->arch.dec_timer.function =3D kvmppc_decrementer_wakeup;
+	hrtimer_setup(&vcpu->arch.dec_timer, kvmppc_decrementer_wakeup, CLOCK_REALT=
IME,
+		      HRTIMER_MODE_ABS);
=20
 #ifdef CONFIG_KVM_EXIT_TIMING
 	mutex_init(&vcpu->arch.exit_timing_lock);
diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
index 96e7a4e463f7..ff672fa71fcc 100644
--- a/arch/riscv/kvm/vcpu_timer.c
+++ b/arch/riscv/kvm/vcpu_timer.c
@@ -248,18 +248,19 @@ int kvm_riscv_vcpu_timer_init(struct kvm_vcpu *vcpu)
 	if (t->init_done)
 		return -EINVAL;
=20
-	hrtimer_init(&t->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	t->init_done =3D true;
 	t->next_set =3D false;
=20
 	/* Enable sstc for every vcpu if available in hardware */
 	if (riscv_isa_extension_available(NULL, SSTC)) {
 		t->sstc_enabled =3D true;
-		t->hrt.function =3D kvm_riscv_vcpu_vstimer_expired;
+		hrtimer_setup(&t->hrt, kvm_riscv_vcpu_vstimer_expired, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 		t->timer_next_event =3D kvm_riscv_vcpu_update_vstimecmp;
 	} else {
 		t->sstc_enabled =3D false;
-		t->hrt.function =3D kvm_riscv_vcpu_hrtimer_expired;
+		hrtimer_setup(&t->hrt, kvm_riscv_vcpu_hrtimer_expired, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 		t->timer_next_event =3D kvm_riscv_vcpu_update_hrtimer;
 	}
=20
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 07ff0e10cb7f..0f00f8e85fee 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -3174,8 +3174,7 @@ void kvm_s390_gisa_init(struct kvm *kvm)
 	gi->alert.mask =3D 0;
 	spin_lock_init(&gi->alert.ref_lock);
 	gi->expires =3D 50 * 1000; /* 50 usec */
-	hrtimer_init(&gi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	gi->timer.function =3D gisa_vcpu_kicker;
+	hrtimer_setup(&gi->timer, gisa_vcpu_kicker, CLOCK_MONOTONIC, HRTIMER_MODE_R=
EL);
 	memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
 	gi->origin->next_alert =3D (u32)virt_to_phys(gi->origin);
 	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ebecb96bacce..1066c6ac5901 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3943,8 +3943,8 @@ static int kvm_s390_vcpu_setup(struct kvm_vcpu *vcpu)
 		if (rc)
 			return rc;
 	}
-	hrtimer_init(&vcpu->arch.ckc_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	vcpu->arch.ckc_timer.function =3D kvm_s390_idle_wakeup;
+	hrtimer_setup(&vcpu->arch.ckc_timer, kvm_s390_idle_wakeup, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
 	vcpu->arch.sie_block->hpid =3D HPID_KVM;
=20
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 60b3078b7502..a34e50fc4a8f 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -347,8 +347,7 @@ void uncore_pmu_cancel_hrtimer(struct intel_uncore_box *b=
ox)
=20
 static void uncore_pmu_init_hrtimer(struct intel_uncore_box *box)
 {
-	hrtimer_init(&box->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	box->hrtimer.function =3D uncore_pmu_hrtimer;
+	hrtimer_setup(&box->hrtimer, uncore_pmu_hrtimer, CLOCK_MONOTONIC, HRTIMER_M=
ODE_REL);
 }
=20
 static struct intel_uncore_box *uncore_alloc_box(struct intel_uncore_type *t=
ype,
diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 4952faf03e82..6a0d957d9d7e 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -274,8 +274,7 @@ static void rapl_hrtimer_init(struct rapl_pmu *rapl_pmu)
 {
 	struct hrtimer *hr =3D &rapl_pmu->hrtimer;
=20
-	hrtimer_init(hr, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	hr->function =3D rapl_hrtimer_handle;
+	hrtimer_setup(hr, rapl_hrtimer_handle, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 }
=20
 static void __rapl_pmu_event_start(struct rapl_pmu *rapl_pmu,
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 6ebeb6cea6c0..24f0318c50d7 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -952,8 +952,7 @@ static void stimer_init(struct kvm_vcpu_hv_stimer *stimer=
, int timer_index)
 {
 	memset(stimer, 0, sizeof(*stimer));
 	stimer->index =3D timer_index;
-	hrtimer_init(&stimer->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	stimer->timer.function =3D stimer_timer_callback;
+	hrtimer_setup(&stimer->timer, stimer_timer_callback, CLOCK_MONOTONIC, HRTIM=
ER_MODE_ABS);
 	stimer_prepare_msg(stimer);
 }
=20
diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
index d7ab8780ab9e..739aa6c0d0c3 100644
--- a/arch/x86/kvm/i8254.c
+++ b/arch/x86/kvm/i8254.c
@@ -690,8 +690,7 @@ struct kvm_pit *kvm_create_pit(struct kvm *kvm, u32 flags)
 	pit->kvm =3D kvm;
=20
 	pit_state =3D &pit->pit_state;
-	hrtimer_init(&pit_state->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	pit_state->timer.function =3D pit_timer_fn;
+	hrtimer_setup(&pit_state->timer, pit_timer_fn, CLOCK_MONOTONIC, HRTIMER_MOD=
E_ABS);
=20
 	pit_state->irq_ack_notifier.gsi =3D 0;
 	pit_state->irq_ack_notifier.irq_acked =3D kvm_pit_ack_irq;
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index a009c94c26c2..eb56cd989574 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2921,9 +2921,8 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu)
=20
 	apic->nr_lvt_entries =3D kvm_apic_calc_nr_lvt_entries(vcpu);
=20
-	hrtimer_init(&apic->lapic_timer.timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_ABS_HARD);
-	apic->lapic_timer.timer.function =3D apic_timer_fn;
+	hrtimer_setup(&apic->lapic_timer.timer, apic_timer_fn, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_HARD);
 	if (lapic_timer_advance)
 		apic->lapic_timer.timer_advance_ns =3D LAPIC_TIMER_ADVANCE_NS_INIT;
=20
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 8a7af02d466e..ca18c3eec76d 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5316,9 +5316,8 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
 	if (enable_shadow_vmcs && !alloc_shadow_vmcs(vcpu))
 		goto out_shadow_vmcs;
=20
-	hrtimer_init(&vmx->nested.preemption_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_ABS_PINNED);
-	vmx->nested.preemption_timer.function =3D vmx_preemption_timer_fn;
+	hrtimer_setup(&vmx->nested.preemption_timer, vmx_preemption_timer_fn, CLOCK=
_MONOTONIC,
+		      HRTIMER_MODE_ABS_PINNED);
=20
 	vmx->nested.vpid02 =3D allocate_vpid();
=20
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index a909b817b9c0..1ac738dcf7a2 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -2225,8 +2225,8 @@ void kvm_xen_init_vcpu(struct kvm_vcpu *vcpu)
 	vcpu->arch.xen.poll_evtchn =3D 0;
=20
 	timer_setup(&vcpu->arch.xen.poll_timer, cancel_evtchn_poll, 0);
-	hrtimer_init(&vcpu->arch.xen.timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	vcpu->arch.xen.timer.function =3D xen_timer_callback;
+	hrtimer_setup(&vcpu->arch.xen.timer, xen_timer_callback, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_HARD);
=20
 	kvm_gpc_init(&vcpu->arch.xen.runstate_cache, vcpu->kvm);
 	kvm_gpc_init(&vcpu->arch.xen.runstate2_cache, vcpu->kvm);
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 167542201603..abd80dc13562 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7315,9 +7315,8 @@ static int bfq_init_queue(struct request_queue *q, stru=
ct elevator_type *e)
=20
 	INIT_LIST_HEAD(&bfqd->dispatch);
=20
-	hrtimer_init(&bfqd->idle_slice_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	bfqd->idle_slice_timer.function =3D bfq_idle_slice_timer;
+	hrtimer_setup(&bfqd->idle_slice_timer, bfq_idle_slice_timer, CLOCK_MONOTONI=
C,
+		      HRTIMER_MODE_REL);
=20
 	bfqd->queue_weights_tree =3D RB_ROOT_CACHED;
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 65a1d4427ccf..ed11438eb4be 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3004,8 +3004,7 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 	iocg->hweight_inuse =3D WEIGHT_ONE;
=20
 	init_waitqueue_head(&iocg->waitq);
-	hrtimer_init(&iocg->waitq_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	iocg->waitq_timer.function =3D iocg_waitq_timer_fn;
+	hrtimer_setup(&iocg->waitq_timer, iocg_waitq_timer_fn, CLOCK_MONOTONIC, HRT=
IMER_MODE_ABS);
=20
 	iocg->level =3D blkg->blkcg->css.cgroup->level;
=20
diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index dce24806a052..2d32125c16fd 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -935,9 +935,8 @@ static int octeon_cf_probe(struct platform_device *pdev)
 		ap->mwdma_mask	=3D enable_dma ? ATA_MWDMA4 : 0;
=20
 		/* True IDE mode needs a timer to poll for not-busy.  */
-		hrtimer_init(&cf_port->delayed_finish, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL);
-		cf_port->delayed_finish.function =3D octeon_cf_delayed_finish;
+		hrtimer_setup(&cf_port->delayed_finish, octeon_cf_delayed_finish, CLOCK_MO=
NOTONIC,
+			      HRTIMER_MODE_REL);
 	} else {
 		/* 16 bit but not True IDE */
 		base =3D cs0 + 0x800;
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 2ee45841486b..425c43b2d478 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1764,8 +1764,8 @@ void pm_runtime_init(struct device *dev)
 	INIT_WORK(&dev->power.work, pm_runtime_work);
=20
 	dev->power.timer_expires =3D 0;
-	hrtimer_init(&dev->power.suspend_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	dev->power.suspend_timer.function =3D pm_suspend_timer_fn;
+	hrtimer_setup(&dev->power.suspend_timer, pm_suspend_timer_fn, CLOCK_MONOTON=
IC,
+		      HRTIMER_MODE_ABS);
=20
 	init_waitqueue_head(&dev->power.wait_queue);
 }
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d94ef37480bd..16457330c1bc 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1426,8 +1426,7 @@ static void nullb_setup_bwtimer(struct nullb *nullb)
 {
 	ktime_t timer_interval =3D ktime_set(0, TIMER_INTERVAL);
=20
-	hrtimer_init(&nullb->bw_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	nullb->bw_timer.function =3D nullb_bwtimer_fn;
+	hrtimer_setup(&nullb->bw_timer, nullb_bwtimer_fn, CLOCK_MONOTONIC, HRTIMER_=
MODE_REL);
 	atomic_long_set(&nullb->cur_bytes, mb_per_tick(nullb->dev->mbps));
 	hrtimer_start(&nullb->bw_timer, timer_interval, HRTIMER_MODE_REL);
 }
@@ -1604,8 +1603,8 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx =
*hctx,
 	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
=20
 	if (!is_poll && nq->dev->irqmode =3D=3D NULL_IRQ_TIMER) {
-		hrtimer_init(&cmd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		cmd->timer.function =3D null_cmd_timer_expired;
+		hrtimer_setup(&cmd->timer, null_cmd_timer_expired, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 	}
 	cmd->error =3D BLK_STS_OK;
 	cmd->nq =3D nq;
diff --git a/drivers/char/hw_random/timeriomem-rng.c b/drivers/char/hw_random=
/timeriomem-rng.c
index 7174bfccc7b3..b95f6d0f17ed 100644
--- a/drivers/char/hw_random/timeriomem-rng.c
+++ b/drivers/char/hw_random/timeriomem-rng.c
@@ -152,8 +152,7 @@ static int timeriomem_rng_probe(struct platform_device *p=
dev)
=20
 	priv->period =3D ns_to_ktime(period * NSEC_PER_USEC);
 	init_completion(&priv->completion);
-	hrtimer_init(&priv->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	priv->timer.function =3D timeriomem_rng_trigger;
+	hrtimer_setup(&priv->timer, timeriomem_rng_trigger, CLOCK_MONOTONIC, HRTIME=
R_MODE_ABS);
=20
 	priv->rng_ops.name =3D dev_name(&pdev->dev);
 	priv->rng_ops.read =3D timeriomem_rng_read;
diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/roc=
kchip-dfi.c
index e2a1e4463b6f..0470d7c175f4 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -642,8 +642,7 @@ static int rockchip_ddr_perf_init(struct rockchip_dfi *df=
i)
 	if (ret)
 		return ret;
=20
-	hrtimer_init(&dfi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	dfi->timer.function =3D rockchip_dfi_timer;
+	hrtimer_setup(&dfi->timer, rockchip_dfi_timer, CLOCK_MONOTONIC, HRTIMER_MOD=
E_REL);
=20
 	switch (dfi->ddr_type) {
 	case ROCKCHIP_DDRTYPE_LPDDR2:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vkms.c
index 03308261f894..7507d9443028 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -188,8 +188,8 @@ static int amdgpu_vkms_crtc_init(struct drm_device *dev, =
struct drm_crtc *crtc,
 	amdgpu_crtc->connector =3D NULL;
 	amdgpu_crtc->vsync_timer_enabled =3D AMDGPU_IRQ_STATE_DISABLE;
=20
-	hrtimer_init(&amdgpu_crtc->vblank_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	amdgpu_crtc->vblank_timer.function =3D &amdgpu_vkms_vblank_simulate;
+	hrtimer_setup(&amdgpu_crtc->vblank_timer, &amdgpu_vkms_vblank_simulate, CLO=
CK_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
 	return ret;
 }
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_huc.c b/drivers/gpu/drm/i915/gt=
/uc/intel_huc.c
index b3cbf85c00cb..00d00c480cc5 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_huc.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_huc.c
@@ -231,8 +231,8 @@ static void delayed_huc_load_init(struct intel_huc *huc)
 			   sw_fence_dummy_notify);
 	i915_sw_fence_commit(&huc->delayed_load.fence);
=20
-	hrtimer_init(&huc->delayed_load.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	huc->delayed_load.timer.function =3D huc_delayed_load_timer_callback;
+	hrtimer_setup(&huc->delayed_load.timer, huc_delayed_load_timer_callback, CL=
OCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 }
=20
 static void delayed_huc_load_fini(struct intel_huc *huc)
diff --git a/drivers/gpu/drm/i915/gvt/display.c b/drivers/gpu/drm/i915/gvt/di=
splay.c
index 95570cabdf27..f668cd9487f1 100644
--- a/drivers/gpu/drm/i915/gvt/display.c
+++ b/drivers/gpu/drm/i915/gvt/display.c
@@ -581,8 +581,7 @@ static int setup_virtual_dp_monitor(struct intel_vgpu *vg=
pu, int port_num,
 	vgpu->display.port_num =3D port_num;
=20
 	/* Init hrtimer based on default refresh rate */
-	hrtimer_init(&vblank_timer->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	vblank_timer->timer.function =3D vblank_timer_fn;
+	hrtimer_setup(&vblank_timer->timer, vblank_timer_fn, CLOCK_MONOTONIC, HRTIM=
ER_MODE_ABS);
 	vblank_timer->vrefresh_k =3D port->vrefresh_k;
 	vblank_timer->period =3D DIV64_U64_ROUND_CLOSEST(NSEC_PER_SEC * MSEC_PER_SE=
C, vblank_timer->vrefresh_k);
=20
diff --git a/drivers/gpu/drm/i915/gvt/sched_policy.c b/drivers/gpu/drm/i915/g=
vt/sched_policy.c
index c077fb4674f0..9f97f743aa71 100644
--- a/drivers/gpu/drm/i915/gvt/sched_policy.c
+++ b/drivers/gpu/drm/i915/gvt/sched_policy.c
@@ -286,8 +286,7 @@ static int tbs_sched_init(struct intel_gvt *gvt)
 		return -ENOMEM;
=20
 	INIT_LIST_HEAD(&data->lru_runq_head);
-	hrtimer_init(&data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	data->timer.function =3D tbs_timer_fn;
+	hrtimer_setup(&data->timer, tbs_timer_fn, CLOCK_MONOTONIC, HRTIMER_MODE_ABS=
);
 	data->period =3D GVT_DEFAULT_TIME_SLICE;
 	data->gvt =3D gvt;
=20
diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_per=
f.c
index 5384d1bb4923..279e266b4b06 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -3359,9 +3359,8 @@ static int i915_oa_stream_init(struct i915_perf_stream =
*stream,
 		"opening stream oa config uuid=3D%s\n",
 		  stream->oa_config->uuid);
=20
-	hrtimer_init(&stream->poll_check_timer,
-		     CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	stream->poll_check_timer.function =3D oa_poll_check_timer_cb;
+	hrtimer_setup(&stream->poll_check_timer, oa_poll_check_timer_cb, CLOCK_MONO=
TONIC,
+		      HRTIMER_MODE_REL);
 	init_waitqueue_head(&stream->poll_wq);
 	spin_lock_init(&stream->oa_buffer.ptr_lock);
 	mutex_init(&stream->lock);
diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index e55db036be1b..0ce87f188d11 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -1264,8 +1264,7 @@ void i915_pmu_register(struct drm_i915_private *i915)
 	int ret =3D -ENOMEM;
=20
 	spin_lock_init(&pmu->lock);
-	hrtimer_init(&pmu->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	pmu->timer.function =3D i915_sample;
+	hrtimer_setup(&pmu->timer, i915_sample, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	pmu->cpuhp.cpu =3D -1;
 	init_rc6(pmu);
=20
diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_=
request.c
index 8f62cfa23fb7..ea0b8e7e4828 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -293,8 +293,7 @@ static void __rq_init_watchdog(struct i915_request *rq)
 {
 	struct i915_request_watchdog *wdg =3D &rq->watchdog;
=20
-	hrtimer_init(&wdg->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	wdg->timer.function =3D __rq_watchdog_expired;
+	hrtimer_setup(&wdg->timer, __rq_watchdog_expired, CLOCK_MONOTONIC, HRTIMER_=
MODE_REL);
 }
=20
 static void __rq_arm_watchdog(struct i915_request *rq)
diff --git a/drivers/gpu/drm/i915/intel_uncore.c b/drivers/gpu/drm/i915/intel=
_uncore.c
index eed4937c3ff3..bdcfcae83b52 100644
--- a/drivers/gpu/drm/i915/intel_uncore.c
+++ b/drivers/gpu/drm/i915/intel_uncore.c
@@ -2103,8 +2103,7 @@ static int __fw_domain_init(struct intel_uncore *uncore,
=20
 	d->mask =3D BIT(domain_id);
=20
-	hrtimer_init(&d->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	d->timer.function =3D intel_uncore_fw_release_timer;
+	hrtimer_setup(&d->timer, intel_uncore_fw_release_timer, CLOCK_MONOTONIC, HR=
TIMER_MODE_REL);
=20
 	uncore->fw_domains |=3D BIT(domain_id);
=20
diff --git a/drivers/gpu/drm/msm/msm_fence.c b/drivers/gpu/drm/msm/msm_fence.c
index 1a5d4f1c8b42..d41e5a6bbee0 100644
--- a/drivers/gpu/drm/msm/msm_fence.c
+++ b/drivers/gpu/drm/msm/msm_fence.c
@@ -65,8 +65,7 @@ msm_fence_context_alloc(struct drm_device *dev, volatile ui=
nt32_t *fenceptr,
 	fctx->completed_fence =3D fctx->last_fence;
 	*fctx->fenceptr =3D fctx->last_fence;
=20
-	hrtimer_init(&fctx->deadline_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	fctx->deadline_timer.function =3D deadline_timer;
+	hrtimer_setup(&fctx->deadline_timer, deadline_timer, CLOCK_MONOTONIC, HRTIM=
ER_MODE_ABS);
=20
 	kthread_init_work(&fctx->deadline_work, deadline_work);
=20
diff --git a/drivers/gpu/drm/msm/msm_io_utils.c b/drivers/gpu/drm/msm/msm_io_=
utils.c
index afedd61c3e28..a6efe1eac271 100644
--- a/drivers/gpu/drm/msm/msm_io_utils.c
+++ b/drivers/gpu/drm/msm/msm_io_utils.c
@@ -135,8 +135,7 @@ void msm_hrtimer_work_init(struct msm_hrtimer_work *work,
 			   clockid_t clock_id,
 			   enum hrtimer_mode mode)
 {
-	hrtimer_init(&work->timer, clock_id, mode);
-	work->timer.function =3D msm_hrtimer_worktimer;
+	hrtimer_setup(&work->timer, msm_hrtimer_worktimer, clock_id, mode);
 	work->worker =3D worker;
 	kthread_init_work(&work->work, fn);
 }
diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crt=
c.c
index 28a57ae109fc..ae4e36bc337c 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -64,8 +64,8 @@ static int vkms_enable_vblank(struct drm_crtc *crtc)
 	struct drm_vblank_crtc *vblank =3D drm_crtc_vblank_crtc(crtc);
 	struct vkms_output *out =3D drm_crtc_to_vkms_output(crtc);
=20
-	hrtimer_init(&out->vblank_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	out->vblank_hrtimer.function =3D &vkms_vblank_simulate;
+	hrtimer_setup(&out->vblank_hrtimer, &vkms_vblank_simulate, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	out->period_ns =3D ktime_set(0, vblank->framedur_ns);
 	hrtimer_start(&out->vblank_hrtimer, out->period_ns, HRTIMER_MODE_REL);
=20
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgfx/vm=
wgfx_vkms.c
index 8651b788e98b..aec774fa4d7b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
@@ -290,8 +290,8 @@ vmw_vkms_enable_vblank(struct drm_crtc *crtc)
=20
 	drm_calc_timestamping_constants(crtc, &crtc->mode);
=20
-	hrtimer_init(&du->vkms.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	du->vkms.timer.function =3D &vmw_vkms_vblank_simulate;
+	hrtimer_setup(&du->vkms.timer, &vmw_vkms_vblank_simulate, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	du->vkms.period_ns =3D ktime_set(0, vblank->framedur_ns);
 	hrtimer_start(&du->vkms.timer, du->vkms.period_ns, HRTIMER_MODE_REL);
=20
diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index fa873f3d0a9d..f03b3a99ae43 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -1766,8 +1766,8 @@ static int xe_oa_stream_init(struct xe_oa_stream *strea=
m,
=20
 	WRITE_ONCE(u->exclusive_stream, stream);
=20
-	hrtimer_init(&stream->poll_check_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	stream->poll_check_timer.function =3D xe_oa_poll_check_timer_cb;
+	hrtimer_setup(&stream->poll_check_timer, xe_oa_poll_check_timer_cb, CLOCK_M=
ONOTONIC,
+		      HRTIMER_MODE_REL);
 	init_waitqueue_head(&stream->poll_wq);
=20
 	spin_lock_init(&stream->oa_buffer.ptr_lock);
diff --git a/drivers/hwtracing/stm/heartbeat.c b/drivers/hwtracing/stm/heartb=
eat.c
index e9496fe97baa..495eb1dc8ac5 100644
--- a/drivers/hwtracing/stm/heartbeat.c
+++ b/drivers/hwtracing/stm/heartbeat.c
@@ -81,10 +81,8 @@ static int stm_heartbeat_init(void)
 		stm_heartbeat[i].data.type	=3D STM_USER;
 		stm_heartbeat[i].data.link	=3D stm_heartbeat_link;
 		stm_heartbeat[i].data.unlink	=3D stm_heartbeat_unlink;
-		hrtimer_init(&stm_heartbeat[i].hrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_ABS);
-		stm_heartbeat[i].hrtimer.function =3D
-			stm_heartbeat_hrtimer_handler;
+		hrtimer_setup(&stm_heartbeat[i].hrtimer, stm_heartbeat_hrtimer_handler,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
=20
 		ret =3D stm_source_register_device(NULL, &stm_heartbeat[i].data);
 		if (ret)
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index ee0d25b498cb..9e5d454d8318 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1723,8 +1723,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
 		return -ENOMEM;
=20
 	spin_lock_init(&i2c_imx->slave_lock);
-	hrtimer_init(&i2c_imx->slave_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	i2c_imx->slave_timer.function =3D i2c_imx_slave_timeout;
+	hrtimer_setup(&i2c_imx->slave_timer, i2c_imx_slave_timeout, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS);
=20
 	match =3D device_get_match_data(&pdev->dev);
 	if (match)
diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index 7dde5713973f..49560059f4b7 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -812,9 +812,7 @@ static int tsc2046_adc_probe(struct spi_device *spi)
=20
 	spin_lock_init(&priv->state_lock);
 	priv->state =3D TSC2046_STATE_SHUTDOWN;
-	hrtimer_init(&priv->trig_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL_SOFT);
-	priv->trig_timer.function =3D tsc2046_adc_timer;
+	hrtimer_setup(&priv->trig_timer, tsc2046_adc_timer, CLOCK_MONOTONIC, HRTIME=
R_MODE_REL_SOFT);
=20
 	ret =3D devm_iio_trigger_register(dev, trig);
 	if (ret) {
diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio=
-trig-hrtimer.c
index 716c795d08fb..82c72baccb62 100644
--- a/drivers/iio/trigger/iio-trig-hrtimer.c
+++ b/drivers/iio/trigger/iio-trig-hrtimer.c
@@ -145,8 +145,8 @@ static struct iio_sw_trigger *iio_trig_hrtimer_probe(cons=
t char *name)
 	trig_info->swt.trigger->ops =3D &iio_hrtimer_trigger_ops;
 	trig_info->swt.trigger->dev.groups =3D iio_hrtimer_attr_groups;
=20
-	hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	trig_info->timer.function =3D iio_hrtimer_trig_handler;
+	hrtimer_setup(&trig_info->timer, iio_hrtimer_trig_handler, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_HARD);
=20
 	trig_info->sampling_frequency[0] =3D HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
 	trig_info->period =3D NSEC_PER_SEC / trig_info->sampling_frequency[0];
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/i=
nit.c
index cbac4a442d9e..d6fbd9c2b8b4 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -635,12 +635,11 @@ void hfi1_init_pportdata(struct pci_dev *pdev, struct h=
fi1_pportdata *ppd,
 	spin_lock_init(&ppd->cca_timer_lock);
=20
 	for (i =3D 0; i < OPA_MAX_SLS; i++) {
-		hrtimer_init(&ppd->cca_timer[i].hrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL);
 		ppd->cca_timer[i].ppd =3D ppd;
 		ppd->cca_timer[i].sl =3D i;
 		ppd->cca_timer[i].ccti =3D 0;
-		ppd->cca_timer[i].hrtimer.function =3D cca_timer_fn;
+		hrtimer_setup(&ppd->cca_timer[i].hrtimer, cca_timer_fn, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 	}
=20
 	ppd->cc_max_table_entries =3D IB_CC_TABLE_CAP_DEFAULT;
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt=
/qp.c
index e6203e26cc06..614009fb9632 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1107,9 +1107,8 @@ int rvt_create_qp(struct ib_qp *ibqp, struct ib_qp_init=
_attr *init_attr,
 		}
 		/* initialize timers needed for rc qp */
 		timer_setup(&qp->s_timer, rvt_rc_timeout, 0);
-		hrtimer_init(&qp->s_rnr_timer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL);
-		qp->s_rnr_timer.function =3D rvt_rc_rnr_retry;
+		hrtimer_setup(&qp->s_rnr_timer, rvt_rc_rnr_retry, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
=20
 		/*
 		 * Driver needs to set up it's private QP structure and do any
diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/le=
dtrig-pattern.c
index aad48c2540fc..a594bd5e2233 100644
--- a/drivers/leds/trigger/ledtrig-pattern.c
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -483,8 +483,8 @@ static int pattern_trig_activate(struct led_classdev *led=
_cdev)
 	data->led_cdev =3D led_cdev;
 	led_set_trigger_data(led_cdev, data);
 	timer_setup(&data->timer, pattern_trig_timer_function, 0);
-	hrtimer_init(&data->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	data->hrtimer.function =3D pattern_trig_hrtimer_function;
+	hrtimer_setup(&data->hrtimer, pattern_trig_hrtimer_function, CLOCK_MONOTONI=
C,
+		      HRTIMER_MODE_REL);
 	led_cdev->activated =3D true;
=20
 	if (led_cdev->flags & LED_INIT_DEFAULT_TRIGGER) {
diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index d3d26a2c9895..118beaf447aa 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -534,9 +534,7 @@ int mbox_controller_register(struct mbox_controller *mbox)
 			return -EINVAL;
 		}
=20
-		hrtimer_init(&mbox->poll_hrt, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL);
-		mbox->poll_hrt.function =3D txdone_hrtimer;
+		hrtimer_setup(&mbox->poll_hrt, txdone_hrtimer, CLOCK_MONOTONIC, HRTIMER_MO=
DE_REL);
 		spin_lock_init(&mbox->poll_hrt_lock);
 	}
=20
diff --git a/drivers/media/cec/core/cec-pin.c b/drivers/media/cec/core/cec-pi=
n.c
index a70451d99ebc..bebaa40e0eb5 100644
--- a/drivers/media/cec/core/cec-pin.c
+++ b/drivers/media/cec/core/cec-pin.c
@@ -1346,9 +1346,8 @@ struct cec_adapter *cec_pin_allocate_adapter(const stru=
ct cec_pin_ops *pin_ops,
 	if (pin =3D=3D NULL)
 		return ERR_PTR(-ENOMEM);
 	pin->ops =3D pin_ops;
-	hrtimer_init(&pin->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	atomic_set(&pin->work_pin_num_events, 0);
-	pin->timer.function =3D cec_pin_timer;
+	hrtimer_setup(&pin->timer, cec_pin_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL=
);
 	init_waitqueue_head(&pin->kthread_waitq);
 	pin->tx_custom_low_usecs =3D CEC_TIM_CUSTOM_DEFAULT;
 	pin->tx_custom_high_usecs =3D CEC_TIM_CUSTOM_DEFAULT;
diff --git a/drivers/media/pci/cx88/cx88-input.c b/drivers/media/pci/cx88/cx8=
8-input.c
index a04a1d33fadb..b9f2c14d62b4 100644
--- a/drivers/media/pci/cx88/cx88-input.c
+++ b/drivers/media/pci/cx88/cx88-input.c
@@ -190,8 +190,7 @@ static int __cx88_ir_start(void *priv)
 	ir =3D core->ir;
=20
 	if (ir->polling) {
-		hrtimer_init(&ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		ir->timer.function =3D cx88_ir_work;
+		hrtimer_setup(&ir->timer, cx88_ir_work, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 		hrtimer_start(&ir->timer,
 			      ktime_set(0, ir->polling * 1000000),
 			      HRTIMER_MODE_REL);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/m=
edia/platform/chips-media/wave5/wave5-vpu.c
index d1320298a0f7..8479dc9c9a8f 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -269,8 +269,8 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 	dev->irq =3D platform_get_irq(pdev, 0);
 	if (dev->irq < 0) {
 		dev_err(&pdev->dev, "failed to get irq resource, falling back to polling\n=
");
-		hrtimer_init(&dev->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
-		dev->hrtimer.function =3D &wave5_vpu_timer_callback;
+		hrtimer_setup(&dev->hrtimer, &wave5_vpu_timer_callback, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL_PINNED);
 		dev->worker =3D kthread_run_worker(0, "vpu_irq_thread");
 		if (IS_ERR(dev->worker)) {
 			dev_err(&pdev->dev, "failed to create vpu irq worker\n");
diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
index fe368aebbc13..84533fdd61aa 100644
--- a/drivers/media/rc/pwm-ir-tx.c
+++ b/drivers/media/rc/pwm-ir-tx.c
@@ -172,8 +172,7 @@ static int pwm_ir_probe(struct platform_device *pdev)
 		rcdev->tx_ir =3D pwm_ir_tx_sleep;
 	} else {
 		init_completion(&pwm_ir->tx_done);
-		hrtimer_init(&pwm_ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		pwm_ir->timer.function =3D pwm_ir_timer;
+		hrtimer_setup(&pwm_ir->timer, pwm_ir_timer, CLOCK_MONOTONIC, HRTIMER_MODE_=
REL);
 		rcdev->tx_ir =3D pwm_ir_tx_atomic;
 	}
=20
diff --git a/drivers/misc/vcpu_stall_detector.c b/drivers/misc/vcpu_stall_det=
ector.c
index f0b1fc87490e..26166357b255 100644
--- a/drivers/misc/vcpu_stall_detector.c
+++ b/drivers/misc/vcpu_stall_detector.c
@@ -111,8 +111,7 @@ static int start_stall_detector_cpu(unsigned int cpu)
 	ping_timeout_ms =3D vcpu_stall_config.stall_timeout_sec *
 			  MSEC_PER_SEC / 2;
=20
-	hrtimer_init(vcpu_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	vcpu_hrtimer->function =3D vcpu_stall_detect_timer_fn;
+	hrtimer_setup(vcpu_hrtimer, vcpu_stall_detect_timer_fn, CLOCK_MONOTONIC, HR=
TIMER_MODE_REL);
 	vcpu_stall_detector->is_initialized =3D true;
=20
 	hrtimer_start(vcpu_hrtimer, ms_to_ktime(ping_timeout_ms),
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 3cbda98d08d2..31f40c04afda 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1875,8 +1875,7 @@ static void dw_mci_init_fault(struct dw_mci *host)
 {
 	host->fail_data_crc =3D (struct fault_attr) FAULT_ATTR_INITIALIZER;
=20
-	hrtimer_init(&host->fault_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	host->fault_timer.function =3D dw_mci_fault_timer;
+	hrtimer_setup(&host->fault_timer, dw_mci_fault_timer, CLOCK_MONOTONIC, HRTI=
MER_MODE_REL);
 }
 #else
 static void dw_mci_init_fault(struct dw_mci *host)
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index d025d4163fd1..884a6352c42b 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2420,12 +2420,11 @@ int m_can_class_register(struct m_can_classdev *cdev)
=20
 	if (!cdev->net->irq) {
 		dev_dbg(cdev->dev, "Polling enabled, initialize hrtimer");
-		hrtimer_init(&cdev->hrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_PINNED);
-		cdev->hrtimer.function =3D &hrtimer_callback;
+		hrtimer_setup(&cdev->hrtimer, &hrtimer_callback, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL_PINNED);
 	} else {
-		hrtimer_init(&cdev->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		cdev->hrtimer.function =3D m_can_coalescing_timer;
+		hrtimer_setup(&cdev->hrtimer, m_can_coalescing_timer, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 	}
=20
 	ret =3D m_can_dev_setup(cdev);
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can=
/spi/mcp251xfd/mcp251xfd-ring.c
index 7209a831f0f2..c34f2067a989 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -541,11 +541,11 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 	}
 	priv->rx_ring_num =3D i;
=20
-	hrtimer_init(&priv->rx_irq_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	priv->rx_irq_timer.function =3D mcp251xfd_rx_irq_timer;
+	hrtimer_setup(&priv->rx_irq_timer, mcp251xfd_rx_irq_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
-	hrtimer_init(&priv->tx_irq_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	priv->tx_irq_timer.function =3D mcp251xfd_tx_irq_timer;
+	hrtimer_setup(&priv->tx_irq_timer, mcp251xfd_tx_irq_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
 	return 0;
 }
diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cor=
tina/gemini.c
index 991e3839858b..2b4bb74f21bf 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1833,9 +1833,8 @@ static int gmac_open(struct net_device *netdev)
 	gmac_enable_tx_rx(netdev);
 	netif_tx_start_all_queues(netdev);
=20
-	hrtimer_init(&port->rx_coalesce_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	port->rx_coalesce_timer.function =3D &gmac_coalesce_delay_expired;
+	hrtimer_setup(&port->rx_coalesce_timer, &gmac_coalesce_delay_expired, CLOCK=
_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
 	netdev_dbg(netdev, "opened\n");
=20
diff --git a/drivers/net/ethernet/ec_bhf.c b/drivers/net/ethernet/ec_bhf.c
index 44af1d13d931..67275aa4f65b 100644
--- a/drivers/net/ethernet/ec_bhf.c
+++ b/drivers/net/ethernet/ec_bhf.c
@@ -416,8 +416,7 @@ static int ec_bhf_open(struct net_device *net_dev)
=20
 	netif_start_queue(net_dev);
=20
-	hrtimer_init(&priv->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	priv->hrtimer.function =3D ec_bhf_timer_fun;
+	hrtimer_setup(&priv->hrtimer, ec_bhf_timer_fun, CLOCK_MONOTONIC, HRTIMER_MO=
DE_REL);
 	hrtimer_start(&priv->hrtimer, polling_frequency, HRTIMER_MODE_REL);
=20
 	return 0;
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/=
freescale/fec_ptp.c
index 7f6b57432071..fe4e7f99b6a3 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -739,8 +739,8 @@ void fec_ptp_init(struct platform_device *pdev, int irq_i=
dx)
=20
 	INIT_DELAYED_WORK(&fep->time_keep, fec_time_keep);
=20
-	hrtimer_init(&fep->perout_timer, CLOCK_REALTIME, HRTIMER_MODE_REL);
-	fep->perout_timer.function =3D fec_ptp_pps_perout_handler;
+	hrtimer_setup(&fep->perout_timer, fec_ptp_pps_perout_handler, CLOCK_REALTIM=
E,
+		      HRTIMER_MODE_REL);
=20
 	irq =3D platform_get_irq_byname_optional(pdev, "pps");
 	if (irq < 0)
diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/etherne=
t/hisilicon/hip04_eth.c
index a376d4bdf281..18376bcc718a 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -934,8 +934,6 @@ static int hip04_mac_probe(struct platform_device *pdev)
 	priv->chan =3D arg.args[1] * RX_DESC_NUM;
 	priv->group =3D arg.args[2];
=20
-	hrtimer_init(&priv->tx_coalesce_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-
 	/* BQL will try to keep the TX queue as short as possible, but it can't
 	 * be faster than tx_coalesce_usecs, so we need a fast timeout here,
 	 * but also long enough to gather up enough frames to ensure we don't
@@ -944,7 +942,7 @@ static int hip04_mac_probe(struct platform_device *pdev)
 	 */
 	priv->tx_coalesce_frames =3D TX_DESC_NUM * 3 / 4;
 	priv->tx_coalesce_usecs =3D 200;
-	priv->tx_coalesce_timer.function =3D tx_done;
+	hrtimer_setup(&priv->tx_coalesce_timer, tx_done, CLOCK_MONOTONIC, HRTIMER_M=
ODE_REL);
=20
 	priv->map =3D syscon_node_to_regmap(arg.np);
 	of_node_put(arg.np);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet=
/intel/igc/igc_main.c
index 84307bb7313e..733820a0c350 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7090,8 +7090,8 @@ static int igc_probe(struct pci_dev *pdev,
 	INIT_WORK(&adapter->reset_task, igc_reset_task);
 	INIT_WORK(&adapter->watchdog_task, igc_watchdog_task);
=20
-	hrtimer_init(&adapter->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	adapter->hrtimer.function =3D &igc_qbv_scheduling_timer;
+	hrtimer_setup(&adapter->hrtimer, &igc_qbv_scheduling_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
 	/* Initialize link properties that are user-changeable */
 	adapter->fc_autoneg =3D true;
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/et=
hernet/marvell/mvpp2/mvpp2_main.c
index dd76c1b7ed3a..3c7b43712d25 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -6985,9 +6985,8 @@ static int mvpp2_port_probe(struct platform_device *pde=
v,
 		for (thread =3D 0; thread < priv->nthreads; thread++) {
 			port_pcpu =3D per_cpu_ptr(port->pcpu, thread);
=20
-			hrtimer_init(&port_pcpu->tx_done_timer, CLOCK_MONOTONIC,
-				     HRTIMER_MODE_REL_PINNED_SOFT);
-			port_pcpu->tx_done_timer.function =3D mvpp2_hr_timer_cb;
+			hrtimer_setup(&port_pcpu->tx_done_timer, mvpp2_hr_timer_cb, CLOCK_MONOTON=
IC,
+				      HRTIMER_MODE_REL_PINNED_SOFT);
 			port_pcpu->timer_scheduled =3D false;
 			port_pcpu->dev =3D dev;
 		}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c b/drivers/net/et=
hernet/marvell/octeontx2/af/ptp.c
index bcc96eed2481..66749b3649c1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
@@ -545,8 +545,7 @@ static int ptp_probe(struct pci_dev *pdev,
 	spin_lock_init(&ptp->ptp_lock);
 	if (cn10k_ptp_errata(ptp)) {
 		ptp->read_ptp_tstmp =3D &read_ptp_tstmp_sec_nsec;
-		hrtimer_init(&ptp->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		ptp->hrtimer.function =3D ptp_reset_thresh;
+		hrtimer_setup(&ptp->hrtimer, ptp_reset_thresh, CLOCK_MONOTONIC, HRTIMER_MO=
DE_REL);
 	} else {
 		ptp->read_ptp_tstmp =3D &read_ptp_tstmp_nsec;
 	}
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/drivers/=
net/ethernet/microchip/sparx5/sparx5_packet.c
index 138ac58fae51..f713656f1fae 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
@@ -375,6 +375,6 @@ irqreturn_t sparx5_xtr_handler(int irq, void *_sparx5)
=20
 void sparx5_port_inj_timer_setup(struct sparx5_port *port)
 {
-	hrtimer_init(&port->inj_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	port->inj_timer.function =3D sparx5_injection_timeout;
+	hrtimer_setup(&port->inj_timer, sparx5_injection_timeout, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 }
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/n=
et/ethernet/qualcomm/rmnet/rmnet_map_data.c
index a5e3d1a88305..8b4640c5d61e 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -686,8 +686,8 @@ void rmnet_map_update_ul_agg_config(struct rmnet_port *po=
rt, u32 size,
=20
 void rmnet_map_tx_aggregate_init(struct rmnet_port *port)
 {
-	hrtimer_init(&port->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	port->hrtimer.function =3D rmnet_map_flush_tx_packet_queue;
+	hrtimer_setup(&port->hrtimer, rmnet_map_flush_tx_packet_queue, CLOCK_MONOTO=
NIC,
+		      HRTIMER_MODE_REL);
 	spin_lock_init(&port->agg_lock);
 	rmnet_map_update_ul_agg_config(port, 4096, 1, 800);
 	INIT_WORK(&port->agg_wq, rmnet_map_flush_tx_packet_work);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/=
ethernet/stmicro/stmmac/stmmac_main.c
index c0ae7db96f46..554d2c0a8fde 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3199,8 +3199,7 @@ static void stmmac_init_coalesce(struct stmmac_priv *pr=
iv)
 		priv->tx_coal_frames[chan] =3D STMMAC_TX_FRAMES;
 		priv->tx_coal_timer[chan] =3D STMMAC_COAL_TX_TIMER;
=20
-		hrtimer_init(&tx_q->txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		tx_q->txtimer.function =3D stmmac_tx_timer;
+		hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_MO=
DE_REL);
 	}
=20
 	for (chan =3D 0; chan < rx_channel_count; chan++)
@@ -6970,8 +6969,7 @@ int stmmac_xdp_open(struct net_device *dev)
 		stmmac_set_tx_tail_ptr(priv, priv->ioaddr,
 				       tx_q->tx_tail_addr, chan);
=20
-		hrtimer_init(&tx_q->txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		tx_q->txtimer.function =3D stmmac_tx_timer;
+		hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_MO=
DE_REL);
 	}
=20
 	/* Enable the MAC Rx/Tx */
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/=
ti/am65-cpsw-nuss.c
index 2806238629f8..361169db4bef 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2311,8 +2311,8 @@ static int am65_cpsw_nuss_ndev_add_tx_napi(struct am65_=
cpsw_common *common)
 	for (i =3D 0; i < common->tx_ch_num; i++) {
 		struct am65_cpsw_tx_chn *tx_chn =3D &common->tx_chns[i];
=20
-		hrtimer_init(&tx_chn->tx_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED=
);
-		tx_chn->tx_hrtimer.function =3D &am65_cpsw_nuss_tx_timer_callback;
+		hrtimer_setup(&tx_chn->tx_hrtimer, &am65_cpsw_nuss_tx_timer_callback,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
=20
 		ret =3D devm_request_irq(dev, tx_chn->irq,
 				       am65_cpsw_nuss_tx_irq,
@@ -2565,9 +2565,8 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw=
_common *common)
 		snprintf(flow->name,
 			 sizeof(flow->name), "%s-rx%d",
 			 dev_name(dev), i);
-		hrtimer_init(&flow->rx_hrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_PINNED);
-		flow->rx_hrtimer.function =3D &am65_cpsw_nuss_rx_timer_callback;
+		hrtimer_setup(&flow->rx_hrtimer, &am65_cpsw_nuss_rx_timer_callback, CLOCK_=
MONOTONIC,
+			      HRTIMER_MODE_REL_PINNED);
=20
 		ret =3D devm_request_irq(dev, flow->irq,
 				       am65_cpsw_nuss_rx_irq,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ether=
net/ti/icssg/icssg_common.c
index 74f0f200a89d..6c1b8ff563e0 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -249,9 +249,8 @@ int prueth_ndev_add_tx_napi(struct prueth_emac *emac)
 		struct prueth_tx_chn *tx_chn =3D &emac->tx_chns[i];
=20
 		netif_napi_add_tx(emac->ndev, &tx_chn->napi_tx, emac_napi_tx_poll);
-		hrtimer_init(&tx_chn->tx_hrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_PINNED);
-		tx_chn->tx_hrtimer.function =3D &emac_tx_timer_callback;
+		hrtimer_setup(&tx_chn->tx_hrtimer, &emac_tx_timer_callback, CLOCK_MONOTONI=
C,
+			      HRTIMER_MODE_REL_PINNED);
 		ret =3D request_irq(tx_chn->irq, prueth_tx_irq,
 				  IRQF_TRIGGER_HIGH, tx_chn->name,
 				  tx_chn);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ether=
net/ti/icssg/icssg_prueth.c
index 00ed97860547..d3bdde6bd3aa 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1169,9 +1169,8 @@ static int prueth_netdev_init(struct prueth *prueth,
 	ndev->hw_features |=3D NETIF_PRUETH_HSR_OFFLOAD_FEATURES;
=20
 	netif_napi_add(ndev, &emac->napi_rx, icssg_napi_rx_poll);
-	hrtimer_init(&emac->rx_hrtimer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL_PINNED);
-	emac->rx_hrtimer.function =3D &emac_rx_timer_callback;
+	hrtimer_setup(&emac->rx_hrtimer, &emac_rx_timer_callback, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_PINNED);
 	prueth->emac[mac] =3D emac;
=20
 	return 0;
diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86=
rf230.c
index f632b0cfd5ae..fd91f8a45bce 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -776,8 +776,8 @@ at86rf230_setup_spi_messages(struct at86rf230_local *lp,
 	state->trx.tx_buf =3D state->buf;
 	state->trx.rx_buf =3D state->buf;
 	spi_message_add_tail(&state->trx, &state->msg);
-	hrtimer_init(&state->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	state->timer.function =3D at86rf230_async_state_timer;
+	hrtimer_setup(&state->timer, at86rf230_async_state_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 }
=20
 static irqreturn_t at86rf230_isr(int irq, void *data)
diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index d5c47a2a62dc..34e82f1e37d9 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -833,8 +833,7 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_in=
terface *intf, u8 data_
=20
 	ctx->dev =3D dev;
=20
-	hrtimer_init(&ctx->tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	ctx->tx_timer.function =3D &cdc_ncm_tx_timer_cb;
+	hrtimer_setup(&ctx->tx_timer, &cdc_ncm_tx_timer_cb, CLOCK_MONOTONIC, HRTIME=
R_MODE_REL);
 	tasklet_setup(&ctx->bh, cdc_ncm_txpath_bh);
 	atomic_set(&ctx->stop, 0);
 	spin_lock_init(&ctx->mtx);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/=
net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 0e1ede9314d8..4840d0b500b3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -264,8 +264,8 @@ void mt76x02u_init_beacon_config(struct mt76x02_dev *dev)
 	};
 	dev->beacon_ops =3D &beacon_ops;
=20
-	hrtimer_init(&dev->pre_tbtt_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	dev->pre_tbtt_timer.function =3D mt76x02u_pre_tbtt_interrupt;
+	hrtimer_setup(&dev->pre_tbtt_timer, mt76x02u_pre_tbtt_interrupt, CLOCK_MONO=
TONIC,
+		      HRTIMER_MODE_REL);
 	INIT_WORK(&dev->pre_tbtt_work, mt76x02u_pre_tbtt_work);
=20
 	mt76x02_init_beacon_config(dev);
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c b/drivers/net/wi=
reless/ralink/rt2x00/rt2800mmio.c
index 5323acff962a..45775ecdf221 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c
@@ -842,7 +842,7 @@ int rt2800mmio_probe_hw(struct rt2x00_dev *rt2x00dev)
 	/*
 	 * Set txstatus timer function.
 	 */
-	rt2x00dev->txstatus_timer.function =3D rt2800mmio_tx_sta_fifo_timeout;
+	hrtimer_update_function(&rt2x00dev->txstatus_timer, rt2800mmio_tx_sta_fifo_=
timeout);
=20
 	/*
 	 * Overwrite TX done handler
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c b/drivers/net/wir=
eless/ralink/rt2x00/rt2800usb.c
index 160bef79acdb..b51a23300ba2 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
@@ -618,7 +618,7 @@ static int rt2800usb_probe_hw(struct rt2x00_dev *rt2x00de=
v)
 	/*
 	 * Set txstatus timer function.
 	 */
-	rt2x00dev->txstatus_timer.function =3D rt2800usb_tx_sta_fifo_timeout;
+	hrtimer_update_function(&rt2x00dev->txstatus_timer, rt2800usb_tx_sta_fifo_t=
imeout);
=20
 	/*
 	 * Overwrite TX done handler
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wir=
eless/ralink/rt2x00/rt2x00dev.c
index 9e7d9dbe954c..432ddfac2c33 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -1391,8 +1391,8 @@ int rt2x00lib_probe_dev(struct rt2x00_dev *rt2x00dev)
 	mutex_init(&rt2x00dev->conf_mutex);
 	INIT_LIST_HEAD(&rt2x00dev->bar_list);
 	spin_lock_init(&rt2x00dev->bar_list_lock);
-	hrtimer_init(&rt2x00dev->txstatus_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
+	hrtimer_setup(&rt2x00dev->txstatus_timer, hrtimer_dummy_timeout, CLOCK_MONO=
TONIC,
+		      HRTIMER_MODE_REL);
=20
 	set_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags);
=20
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wire=
less/virtual/mac80211_hwsim.c
index cf6a331d4042..fb187a9e984e 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -5548,10 +5548,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *=
info,
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
=20
 	for (i =3D 0; i < ARRAY_SIZE(data->link_data); i++) {
-		hrtimer_init(&data->link_data[i].beacon_timer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_ABS_SOFT);
-		data->link_data[i].beacon_timer.function =3D
-			mac80211_hwsim_beacon;
+		hrtimer_setup(&data->link_data[i].beacon_timer, mac80211_hwsim_beacon,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_ABS_SOFT);
 		data->link_data[i].link_id =3D i;
 	}
=20
diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.c b/drivers/net/wwan/iosm/io=
sm_ipc_imem.c
index 829515a601b3..530a3ea47a1a 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem.c
@@ -1381,24 +1381,20 @@ struct iosm_imem *ipc_imem_init(struct iosm_pcie *pci=
e, unsigned int device_id,
 	/* The phase is set to power off. */
 	ipc_imem->phase =3D IPC_P_OFF;
=20
-	hrtimer_init(&ipc_imem->startup_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	ipc_imem->startup_timer.function =3D ipc_imem_startup_timer_cb;
+	hrtimer_setup(&ipc_imem->startup_timer, ipc_imem_startup_timer_cb, CLOCK_MO=
NOTONIC,
+		      HRTIMER_MODE_REL);
=20
-	hrtimer_init(&ipc_imem->tdupdate_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	ipc_imem->tdupdate_timer.function =3D ipc_imem_td_update_timer_cb;
+	hrtimer_setup(&ipc_imem->tdupdate_timer, ipc_imem_td_update_timer_cb, CLOCK=
_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
-	hrtimer_init(&ipc_imem->fast_update_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	ipc_imem->fast_update_timer.function =3D ipc_imem_fast_update_timer_cb;
+	hrtimer_setup(&ipc_imem->fast_update_timer, ipc_imem_fast_update_timer_cb, =
CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
-	hrtimer_init(&ipc_imem->td_alloc_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	ipc_imem->td_alloc_timer.function =3D ipc_imem_td_alloc_timer_cb;
+	hrtimer_setup(&ipc_imem->td_alloc_timer, ipc_imem_td_alloc_timer_cb, CLOCK_=
MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
-	hrtimer_init(&ipc_imem->adb_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	ipc_imem->adb_timer.function =3D ipc_imem_adb_timer_cb;
+	hrtimer_setup(&ipc_imem->adb_timer, ipc_imem_adb_timer_cb, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
 	if (ipc_imem_config(ipc_imem)) {
 		dev_err(ipc_imem->dev, "failed to initialize the imem");
diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
index 8aeca7914050..1c1c74f4ff2d 100644
--- a/drivers/ntb/test/ntb_pingpong.c
+++ b/drivers/ntb/test/ntb_pingpong.c
@@ -284,8 +284,7 @@ static struct pp_ctx *pp_create_data(struct ntb_dev *ntb)
 	pp->ntb =3D ntb;
 	atomic_set(&pp->count, 0);
 	spin_lock_init(&pp->lock);
-	hrtimer_init(&pp->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	pp->timer.function =3D pp_timer_func;
+	hrtimer_setup(&pp->timer, pp_timer_func, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
=20
 	return pp;
 }
diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index d5fcea3d4328..1a0d0e1a2263 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -1273,9 +1273,8 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
 	/* No overflow interrupt? Have to use a timer instead. */
 	if (!ccn->irq) {
 		dev_info(ccn->dev, "No access to interrupts, using timer.\n");
-		hrtimer_init(&ccn->dt.hrtimer, CLOCK_MONOTONIC,
-				HRTIMER_MODE_REL);
-		ccn->dt.hrtimer.function =3D arm_ccn_pmu_timer_handler;
+		hrtimer_setup(&ccn->dt.hrtimer, arm_ccn_pmu_timer_handler, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 	}
=20
 	/* Pick one CPU which we will use to collect data from CCN... */
diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10=
k_ddr_pmu.c
index 039feded9152..72ac17efd846 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -1064,8 +1064,8 @@ static int cn10k_ddr_perf_probe(struct platform_device =
*pdev)
 	if (!name)
 		return -ENOMEM;
=20
-	hrtimer_init(&ddr_pmu->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	ddr_pmu->hrtimer.function =3D cn10k_ddr_pmu_timer_handler;
+	hrtimer_setup(&ddr_pmu->hrtimer, cn10k_ddr_pmu_timer_handler, CLOCK_MONOTON=
IC,
+		      HRTIMER_MODE_REL);
=20
 	cpuhp_state_add_instance_nocalls(
 				CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index cadd60221b8f..6ed4707bd6bb 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -752,9 +752,8 @@ static int tx2_uncore_pmu_add_dev(struct tx2_uncore_pmu *=
tx2_pmu)
 	tx2_pmu->cpu =3D cpu;
=20
 	if (tx2_pmu->hrtimer_callback) {
-		hrtimer_init(&tx2_pmu->hrtimer,
-				CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		tx2_pmu->hrtimer.function =3D tx2_pmu->hrtimer_callback;
+		hrtimer_setup(&tx2_pmu->hrtimer, tx2_pmu->hrtimer_callback, CLOCK_MONOTONI=
C,
+			      HRTIMER_MODE_REL);
 	}
=20
 	ret =3D tx2_uncore_pmu_register(tx2_pmu);
diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc=
2952-poweroff.c
index 1a6fc8d38e20..90c664d344d0 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -162,11 +162,11 @@ static void ltc2952_poweroff_default(struct ltc2952_pow=
eroff *data)
 	data->wde_interval =3D 300L * NSEC_PER_MSEC;
 	data->trigger_delay =3D ktime_set(2, 500L * NSEC_PER_MSEC);
=20
-	hrtimer_init(&data->timer_trigger, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	data->timer_trigger.function =3D ltc2952_poweroff_timer_trigger;
+	hrtimer_setup(&data->timer_trigger, ltc2952_poweroff_timer_trigger, CLOCK_M=
ONOTONIC,
+		      HRTIMER_MODE_REL);
=20
-	hrtimer_init(&data->timer_wde, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	data->timer_wde.function =3D ltc2952_poweroff_timer_wde;
+	hrtimer_setup(&data->timer_wde, ltc2952_poweroff_timer_wde, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 }
=20
 static int ltc2952_poweroff_init(struct platform_device *pdev)
diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab=
8500_chargalg.c
index 7a8d1feb8e90..dc6c8b0dd1cf 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -1787,13 +1787,12 @@ static int ab8500_chargalg_probe(struct platform_devi=
ce *pdev)
 	psy_cfg.drv_data =3D di;
=20
 	/* Initilialize safety timer */
-	hrtimer_init(&di->safety_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	di->safety_timer.function =3D ab8500_chargalg_safety_timer_expired;
+	hrtimer_setup(&di->safety_timer, ab8500_chargalg_safety_timer_expired, CLOC=
K_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
 	/* Initilialize maintenance timer */
-	hrtimer_init(&di->maintenance_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	di->maintenance_timer.function =3D
-		ab8500_chargalg_maintenance_timer_expired;
+	hrtimer_setup(&di->maintenance_timer, ab8500_chargalg_maintenance_timer_exp=
ired,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
=20
 	/* Init work for chargalg */
 	INIT_DEFERRABLE_WORK(&di->chargalg_periodic_work,
diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index 04c212953ded..5ad7cc438068 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -339,8 +339,7 @@ struct idle_inject_device *idle_inject_register_full(stru=
ct cpumask *cpumask,
 		return NULL;
=20
 	cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
-	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	ii_dev->timer.function =3D idle_inject_timer_fn;
+	hrtimer_setup(&ii_dev->timer, idle_inject_timer_fn, CLOCK_MONOTONIC, HRTIME=
R_MODE_REL);
 	ii_dev->latency_us =3D UINT_MAX;
 	ii_dev->update =3D update;
=20
diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_ra=
pl_common.c
index 77d75e1f14a9..cf3d806284c4 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -2064,8 +2064,7 @@ int rapl_package_add_pmu(struct rapl_package *rp)
 	raw_spin_lock_init(&data->lock);
 	INIT_LIST_HEAD(&data->active_list);
 	data->timer_interval =3D ms_to_ktime(rapl_pmu.timer_ms);
-	hrtimer_init(&data->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	data->hrtimer.function =3D rapl_hrtimer_handle;
+	hrtimer_setup(&data->hrtimer, rapl_hrtimer_handle, CLOCK_MONOTONIC, HRTIMER=
_MODE_REL);
=20
 	return rapl_pmu_update(rp);
 }
diff --git a/drivers/pps/generators/pps_gen_parport.c b/drivers/pps/generator=
s/pps_gen_parport.c
index d46eed159495..f5eeb4dd01ad 100644
--- a/drivers/pps/generators/pps_gen_parport.c
+++ b/drivers/pps/generators/pps_gen_parport.c
@@ -208,8 +208,7 @@ static void parport_attach(struct parport *port)
=20
 	calibrate_port(&device);
=20
-	hrtimer_init(&device.timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
-	device.timer.function =3D hrtimer_event;
+	hrtimer_setup(&device.timer, hrtimer_event, CLOCK_REALTIME, HRTIMER_MODE_AB=
S);
 	hrtimer_start(&device.timer, next_intr_time(&device), HRTIMER_MODE_ABS);
=20
 	return;
diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index e31fa0ad127e..b88cd4fb295b 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -240,8 +240,7 @@ static struct rtc_device *rtc_allocate_device(void)
 	/* Init uie timer */
 	rtc_timer_init(&rtc->uie_rtctimer, rtc_uie_update_irq, rtc);
 	/* Init pie timer */
-	hrtimer_init(&rtc->pie_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	rtc->pie_timer.function =3D rtc_pie_update_irq;
+	hrtimer_setup(&rtc->pie_timer, rtc_pie_update_irq, CLOCK_MONOTONIC, HRTIMER=
_MODE_REL);
 	rtc->pie_enabled =3D 0;
=20
 	set_bit(RTC_FEATURE_ALARM, rtc->features);
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 26e1ea1940ec..62feb2c639d5 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -2326,8 +2326,7 @@ static inline int __init ap_async_init(void)
 	 */
 	if (MACHINE_IS_VM)
 		poll_high_timeout =3D 1500000;
-	hrtimer_init(&ap_poll_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	ap_poll_timer.function =3D ap_poll_timeout;
+	hrtimer_setup(&ap_poll_timer, ap_poll_timeout, CLOCK_MONOTONIC, HRTIMER_MOD=
E_ABS);
=20
 	queue_work(system_long_wq, &ap_scan_bus_work);
=20
diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi=
_tgt/ibmvscsi_tgt.c
index 16d085d56e9d..9e42230e42b8 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -2922,9 +2922,7 @@ static long ibmvscsis_alloctimer(struct scsi_info *vscs=
i)
 	struct timer_cb *p_timer;
=20
 	p_timer =3D &vscsi->rsp_q_timer;
-	hrtimer_init(&p_timer->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-
-	p_timer->timer.function =3D ibmvscsis_service_wait_q;
+	hrtimer_setup(&p_timer->timer, ibmvscsis_service_wait_q, CLOCK_MONOTONIC, H=
RTIMER_MODE_REL);
 	p_timer->started =3D false;
 	p_timer->timer_pops =3D 0;
=20
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index bcadf11414c8..d1ac1d1cec3c 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -7952,11 +7952,10 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	timer_setup(&phba->fcf.redisc_wait, lpfc_sli4_fcf_redisc_wait_tmo, 0);
=20
 	/* CMF congestion timer */
-	hrtimer_init(&phba->cmf_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	phba->cmf_timer.function =3D lpfc_cmf_timer;
+	hrtimer_setup(&phba->cmf_timer, lpfc_cmf_timer, CLOCK_MONOTONIC, HRTIMER_MO=
DE_REL);
 	/* CMF 1 minute stats collection timer */
-	hrtimer_init(&phba->cmf_stats_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	phba->cmf_stats_timer.function =3D lpfc_cmf_stats_timer;
+	hrtimer_setup(&phba->cmf_stats_timer, lpfc_cmf_stats_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
 	/*
 	 * Control structure for handling external multi-buffer mailbox
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 5ceaa4665e5d..fe5c30bb2639 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -6384,8 +6384,8 @@ static struct sdebug_queued_cmd *sdebug_alloc_queued_cm=
d(struct scsi_cmnd *scmd)
=20
 	sd_dp =3D &sqcp->sd_dp;
=20
-	hrtimer_init(&sd_dp->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
-	sd_dp->hrt.function =3D sdebug_q_cmd_hrt_complete;
+	hrtimer_setup(&sd_dp->hrt, sdebug_q_cmd_hrt_complete, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_PINNED);
 	INIT_WORK(&sd_dp->ew.work, sdebug_q_cmd_wq_complete);
=20
 	sqcp->scmd =3D scmd;
diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250=
/8250_bcm7271.c
index d0b18358859e..742004d63c6f 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1056,8 +1056,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 	}
=20
 	/* setup HR timer */
-	hrtimer_init(&priv->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	priv->hrt.function =3D brcmuart_hrtimer_func;
+	hrtimer_setup(&priv->hrt, brcmuart_hrtimer_func, CLOCK_MONOTONIC, HRTIMER_M=
ODE_ABS);
=20
 	up.port.shutdown =3D brcmuart_shutdown;
 	up.port.startup =3D brcmuart_startup;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/82=
50_port.c
index 442967a6cd52..c57f44882abb 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -566,12 +566,10 @@ static int serial8250_em485_init(struct uart_8250_port =
*p)
 	if (!p->em485)
 		return -ENOMEM;
=20
-	hrtimer_init(&p->em485->stop_tx_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	hrtimer_init(&p->em485->start_tx_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	p->em485->stop_tx_timer.function =3D &serial8250_em485_handle_stop_tx;
-	p->em485->start_tx_timer.function =3D &serial8250_em485_handle_start_tx;
+	hrtimer_setup(&p->em485->stop_tx_timer, &serial8250_em485_handle_stop_tx, C=
LOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
+	hrtimer_setup(&p->em485->start_tx_timer, &serial8250_em485_handle_start_tx,=
 CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	p->em485->port =3D p;
 	p->em485->active_timer =3D NULL;
 	p->em485->tx_stopped =3D true;
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 04212c823a91..98f178bdbcbe 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2867,11 +2867,10 @@ static int pl011_probe(struct amba_device *dev, const=
 struct amba_id *id)
 			return -EINVAL;
 		}
 	}
-
-	hrtimer_init(&uap->trigger_start_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	hrtimer_init(&uap->trigger_stop_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	uap->trigger_start_tx.function =3D pl011_trigger_start_tx;
-	uap->trigger_stop_tx.function =3D pl011_trigger_stop_tx;
+	hrtimer_setup(&uap->trigger_start_tx, pl011_trigger_start_tx, CLOCK_MONOTON=
IC,
+		      HRTIMER_MODE_REL);
+	hrtimer_setup(&uap->trigger_stop_tx, pl011_trigger_stop_tx, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
 	ret =3D pl011_setup_port(&dev->dev, uap, &dev->res, portnr);
 	if (ret)
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 9c59ec128bb4..9a1afe409b98 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2582,10 +2582,10 @@ static int imx_uart_probe(struct platform_device *pde=
v)
 		imx_uart_writel(sport, ucr3, UCR3);
 	}
=20
-	hrtimer_init(&sport->trigger_start_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	hrtimer_init(&sport->trigger_stop_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	sport->trigger_start_tx.function =3D imx_trigger_start_tx;
-	sport->trigger_stop_tx.function =3D imx_trigger_stop_tx;
+	hrtimer_setup(&sport->trigger_start_tx, imx_trigger_start_tx, CLOCK_MONOTON=
IC,
+		      HRTIMER_MODE_REL);
+	hrtimer_setup(&sport->trigger_stop_tx, imx_trigger_stop_tx, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
 	/*
 	 * Allocate the IRQ(s) i.MX1 has three interrupts whereas later
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b1ea48f38248..b72c3bc19bfa 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1702,8 +1702,7 @@ static void sci_request_dma(struct uart_port *port)
 			dma +=3D s->buf_len_rx;
 		}
=20
-		hrtimer_init(&s->rx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		s->rx_timer.function =3D sci_dma_rx_timer_fn;
+		hrtimer_setup(&s->rx_timer, sci_dma_rx_timer_fn, CLOCK_MONOTONIC, HRTIMER_=
MODE_REL);
=20
 		s->chan_rx_saved =3D s->chan_rx =3D chan;
=20
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_u=
artps.c
index 92ec51870d1d..fe457bf1e15b 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -454,7 +454,7 @@ static void cdns_uart_handle_tx(void *dev_id)
=20
 	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED &&
 	    (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))) {
-		cdns_uart->tx_timer.function =3D &cdns_rs485_rx_callback;
+		hrtimer_update_function(&cdns_uart->tx_timer, cdns_rs485_rx_callback);
 		hrtimer_start(&cdns_uart->tx_timer,
 			      ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart)), HRTIMER_MODE_REL);
 	}
@@ -734,7 +734,7 @@ static void cdns_uart_start_tx(struct uart_port *port)
=20
 	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
 		if (!cdns_uart->rs485_tx_started) {
-			cdns_uart->tx_timer.function =3D &cdns_rs485_tx_callback;
+			hrtimer_update_function(&cdns_uart->tx_timer, cdns_rs485_tx_callback);
 			cdns_rs485_tx_setup(cdns_uart);
 			return hrtimer_start(&cdns_uart->tx_timer,
 					     ms_to_ktime(port->rs485.delay_rts_before_send),
@@ -1626,8 +1626,8 @@ static int cdns_rs485_config(struct uart_port *port, st=
ruct ktermios *termios,
 		writel(val, port->membase + CDNS_UART_MODEMCR);
=20
 		/* Timer setup */
-		hrtimer_init(&cdns_uart->tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		cdns_uart->tx_timer.function =3D &cdns_rs485_tx_callback;
+		hrtimer_setup(&cdns_uart->tx_timer, &cdns_rs485_tx_callback, CLOCK_MONOTON=
IC,
+			      HRTIMER_MODE_REL);
=20
 		/* Disable transmitter and make Rx setup*/
 		cdns_uart_stop_tx(port);
diff --git a/drivers/usb/chipidea/otg_fsm.c b/drivers/usb/chipidea/otg_fsm.c
index c17516c29b63..a093544482d5 100644
--- a/drivers/usb/chipidea/otg_fsm.c
+++ b/drivers/usb/chipidea/otg_fsm.c
@@ -424,8 +424,7 @@ static enum hrtimer_restart ci_otg_hrtimer_func(struct hr=
timer *t)
 /* Initialize timers */
 static int ci_otg_init_timers(struct ci_hdrc *ci)
 {
-	hrtimer_init(&ci->otg_fsm_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	ci->otg_fsm_hrtimer.function =3D ci_otg_hrtimer_func;
+	hrtimer_setup(&ci->otg_fsm_hrtimer, ci_otg_hrtimer_func, CLOCK_MONOTONIC, H=
RTIMER_MODE_ABS);
=20
 	return 0;
 }
diff --git a/drivers/usb/dwc2/hcd_queue.c b/drivers/usb/dwc2/hcd_queue.c
index 238c6fd50e75..2a542a99ec44 100644
--- a/drivers/usb/dwc2/hcd_queue.c
+++ b/drivers/usb/dwc2/hcd_queue.c
@@ -1459,8 +1459,7 @@ static void dwc2_qh_init(struct dwc2_hsotg *hsotg, stru=
ct dwc2_qh *qh,
 	/* Initialize QH */
 	qh->hsotg =3D hsotg;
 	timer_setup(&qh->unreserve_timer, dwc2_unreserve_timer_fn, 0);
-	hrtimer_init(&qh->wait_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	qh->wait_timer.function =3D &dwc2_wait_timer_fn;
+	hrtimer_setup(&qh->wait_timer, &dwc2_wait_timer_fn, CLOCK_MONOTONIC, HRTIME=
R_MODE_REL);
 	qh->ep_type =3D ep_type;
 	qh->ep_is_in =3D ep_is_in;
=20
diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-=
hcd.c
index 3d404d19a205..64c4965a160f 100644
--- a/drivers/usb/fotg210/fotg210-hcd.c
+++ b/drivers/usb/fotg210/fotg210-hcd.c
@@ -4901,8 +4901,7 @@ static int hcd_fotg210_init(struct usb_hcd *hcd)
 	 */
 	fotg210->need_io_watchdog =3D 1;
=20
-	hrtimer_init(&fotg210->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	fotg210->hrtimer.function =3D fotg210_hrtimer_func;
+	hrtimer_setup(&fotg210->hrtimer, fotg210_hrtimer_func, CLOCK_MONOTONIC, HRT=
IMER_MODE_ABS);
 	fotg210->next_hrtimer_event =3D FOTG210_HRTIMER_NO_EVENT;
=20
 	hcc_params =3D fotg210_readl(fotg210, &fotg210->caps->hcc_params);
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/functio=
n/f_ncm.c
index f60576a65ca6..58b0dd575af3 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1559,8 +1559,7 @@ static int ncm_bind(struct usb_configuration *c, struct=
 usb_function *f)
 	ncm->port.open =3D ncm_open;
 	ncm->port.close =3D ncm_close;
=20
-	hrtimer_init(&ncm->task_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	ncm->task_timer.function =3D ncm_tx_timeout;
+	hrtimer_setup(&ncm->task_timer, ncm_tx_timeout, CLOCK_MONOTONIC, HRTIMER_MO=
DE_REL_SOFT);
=20
 	DBG(cdev, "CDC Network: IN/%s OUT/%s NOTIFY/%s\n",
 			ncm->port.in_ep->name, ncm->port.out_ep->name,
diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dumm=
y_hcd.c
index bda08c5ba7c0..4f1b5db51dda 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -2479,8 +2479,7 @@ static DEVICE_ATTR_RO(urbs);
=20
 static int dummy_start_ss(struct dummy_hcd *dum_hcd)
 {
-	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	dum_hcd->timer.function =3D dummy_timer;
+	hrtimer_setup(&dum_hcd->timer, dummy_timer, CLOCK_MONOTONIC, HRTIMER_MODE_R=
EL_SOFT);
 	dum_hcd->rh_state =3D DUMMY_RH_RUNNING;
 	dum_hcd->stream_en_ep =3D 0;
 	INIT_LIST_HEAD(&dum_hcd->urbp_list);
@@ -2509,8 +2508,7 @@ static int dummy_start(struct usb_hcd *hcd)
 		return dummy_start_ss(dum_hcd);
=20
 	spin_lock_init(&dum_hcd->dum->lock);
-	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	dum_hcd->timer.function =3D dummy_timer;
+	hrtimer_setup(&dum_hcd->timer, dummy_timer, CLOCK_MONOTONIC, HRTIMER_MODE_R=
EL_SOFT);
 	dum_hcd->rh_state =3D DUMMY_RH_RUNNING;
=20
 	INIT_LIST_HEAD(&dum_hcd->urbp_list);
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 6de79ac5e6a4..6d1d190c914d 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -466,8 +466,7 @@ static int ehci_init(struct usb_hcd *hcd)
 	 */
 	ehci->need_io_watchdog =3D 1;
=20
-	hrtimer_init(&ehci->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	ehci->hrtimer.function =3D ehci_hrtimer_func;
+	hrtimer_setup(&ehci->hrtimer, ehci_hrtimer_func, CLOCK_MONOTONIC, HRTIMER_M=
ODE_ABS);
 	ehci->next_hrtimer_event =3D EHCI_HRTIMER_NO_EVENT;
=20
 	hcc_params =3D ehci_readl(ehci, &ehci->caps->hcc_params);
diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
index 9589243e8951..4cde3abb7006 100644
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -760,8 +760,8 @@ cppi41_dma_controller_create(struct musb *musb, void __io=
mem *base)
 	if (!controller)
 		goto kzalloc_fail;
=20
-	hrtimer_init(&controller->early_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	controller->early_tx.function =3D cppi41_recheck_tx_req;
+	hrtimer_setup(&controller->early_tx, cppi41_recheck_tx_req, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	INIT_LIST_HEAD(&controller->early_tx_list);
=20
 	controller->controller.channel_alloc =3D cppi41_dma_channel_allocate;
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 6bf1a22c785a..9c455f073233 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -7721,14 +7721,14 @@ struct tcpm_port *tcpm_register_port(struct device *d=
ev, struct tcpc_dev *tcpc)
 	kthread_init_work(&port->event_work, tcpm_pd_event_handler);
 	kthread_init_work(&port->enable_frs, tcpm_enable_frs_work);
 	kthread_init_work(&port->send_discover_work, tcpm_send_discover_work);
-	hrtimer_init(&port->state_machine_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	port->state_machine_timer.function =3D state_machine_timer_handler;
-	hrtimer_init(&port->vdm_state_machine_timer, CLOCK_MONOTONIC, HRTIMER_MODE_=
REL);
-	port->vdm_state_machine_timer.function =3D vdm_state_machine_timer_handler;
-	hrtimer_init(&port->enable_frs_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	port->enable_frs_timer.function =3D enable_frs_timer_handler;
-	hrtimer_init(&port->send_discover_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	port->send_discover_timer.function =3D send_discover_timer_handler;
+	hrtimer_setup(&port->state_machine_timer, state_machine_timer_handler, CLOC=
K_MONOTONIC,
+		      HRTIMER_MODE_REL);
+	hrtimer_setup(&port->vdm_state_machine_timer, vdm_state_machine_timer_handl=
er,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_setup(&port->enable_frs_timer, enable_frs_timer_handler, CLOCK_MONO=
TONIC,
+		      HRTIMER_MODE_REL);
+	hrtimer_setup(&port->send_discover_timer, send_discover_timer_handler, CLOC=
K_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
 	spin_lock_init(&port->pd_event_lock);
=20
diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 8a294b9cbcf6..56d0dbe62163 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2950,8 +2950,8 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 	mutex_init(&vm->hotplug_mutex);
 	INIT_LIST_HEAD(&vm->next);
 	spin_lock_init(&vm->removal_lock);
-	hrtimer_init(&vm->retry_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	vm->retry_timer.function =3D virtio_mem_timer_expired;
+	hrtimer_setup(&vm->retry_timer, virtio_mem_timer_expired, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	vm->retry_timer_ms =3D VIRTIO_MEM_RETRY_TIMER_MIN_MS;
 	vm->in_kdump =3D is_kdump_kernel();
=20
diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index 7a1096265f18..0820e35ad2e3 100644
--- a/drivers/watchdog/softdog.c
+++ b/drivers/watchdog/softdog.c
@@ -187,14 +187,12 @@ static int __init softdog_init(void)
 	watchdog_set_nowayout(&softdog_dev, nowayout);
 	watchdog_stop_on_reboot(&softdog_dev);
=20
-	hrtimer_init(&softdog_ticktock, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	softdog_ticktock.function =3D softdog_fire;
+	hrtimer_setup(&softdog_ticktock, softdog_fire, CLOCK_MONOTONIC, HRTIMER_MOD=
E_REL);
=20
 	if (IS_ENABLED(CONFIG_SOFT_WATCHDOG_PRETIMEOUT)) {
 		softdog_info.options |=3D WDIOF_PRETIMEOUT;
-		hrtimer_init(&softdog_preticktock, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL);
-		softdog_preticktock.function =3D softdog_pretimeout;
+		hrtimer_setup(&softdog_preticktock, softdog_pretimeout, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 	}
=20
 	if (soft_active_on_boot)
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 19698d87dc57..8369fd94fc1a 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -1051,8 +1051,8 @@ static int watchdog_cdev_register(struct watchdog_devic=
e *wdd)
 	}
=20
 	kthread_init_work(&wd_data->work, watchdog_ping_work);
-	hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	wd_data->timer.function =3D watchdog_timer_expired;
+	hrtimer_setup(&wd_data->timer, watchdog_timer_expired, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_HARD);
 	watchdog_hrtimer_pretimeout_init(wdd);
=20
 	if (wdd->id =3D=3D 0) {
diff --git a/drivers/watchdog/watchdog_hrtimer_pretimeout.c b/drivers/watchdo=
g/watchdog_hrtimer_pretimeout.c
index 940b53718a91..fbc7eecd8b20 100644
--- a/drivers/watchdog/watchdog_hrtimer_pretimeout.c
+++ b/drivers/watchdog/watchdog_hrtimer_pretimeout.c
@@ -23,8 +23,8 @@ void watchdog_hrtimer_pretimeout_init(struct watchdog_devic=
e *wdd)
 {
 	struct watchdog_core_data *wd_data =3D wdd->wd_data;
=20
-	hrtimer_init(&wd_data->pretimeout_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	wd_data->pretimeout_timer.function =3D watchdog_hrtimer_pretimeout;
+	hrtimer_setup(&wd_data->pretimeout_timer, watchdog_hrtimer_pretimeout, CLOC=
K_MONOTONIC,
+		      HRTIMER_MODE_REL);
 }
=20
 void watchdog_hrtimer_pretimeout_start(struct watchdog_device *wdd)
diff --git a/fs/timerfd.c b/fs/timerfd.c
index 9f7eb451a60f..cee007e0d978 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -205,9 +205,8 @@ static int timerfd_setup(struct timerfd_ctx *ctx, int fla=
gs,
 			   ALARM_REALTIME : ALARM_BOOTTIME,
 			   timerfd_alarmproc);
 	} else {
-		hrtimer_init(&ctx->t.tmr, clockid, htmode);
+		hrtimer_setup(&ctx->t.tmr, timerfd_tmrproc, clockid, htmode);
 		hrtimer_set_expires(&ctx->t.tmr, texp);
-		ctx->t.tmr.function =3D timerfd_tmrproc;
 	}
=20
 	if (texp !=3D 0) {
@@ -429,7 +428,7 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 			   ALARM_REALTIME : ALARM_BOOTTIME,
 			   timerfd_alarmproc);
 	else
-		hrtimer_init(&ctx->t.tmr, clockid, HRTIMER_MODE_ABS);
+		hrtimer_setup(&ctx->t.tmr, timerfd_tmrproc, clockid, HRTIMER_MODE_ABS);
=20
 	ctx->moffs =3D ktime_mono_to_real(0);
=20
diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
index 01d8eb170382..a79f229df475 100644
--- a/fs/ubifs/io.c
+++ b/fs/ubifs/io.c
@@ -1179,8 +1179,7 @@ int ubifs_wbuf_init(struct ubifs_info *c, struct ubifs_=
wbuf *wbuf)
 	wbuf->c =3D c;
 	wbuf->next_ino =3D 0;
=20
-	hrtimer_init(&wbuf->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	wbuf->timer.function =3D wbuf_timer_callback_nolock;
+	hrtimer_setup(&wbuf->timer, wbuf_timer_callback_nolock, CLOCK_MONOTONIC, HR=
TIMER_MODE_REL);
 	return 0;
 }
=20
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index f7bfdcf0dda3..acae379541c5 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -223,6 +223,11 @@ static inline void hrtimer_cancel_wait_running(struct hr=
timer *timer)
 }
 #endif
=20
+static inline enum hrtimer_restart hrtimer_dummy_timeout(struct hrtimer *unu=
sed)
+{
+	return HRTIMER_NORESTART;
+}
+
 /* Exported timer functions: */
=20
 /* Initialize timers: */
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ceacf6230e34..936f8b4106cf 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2421,7 +2421,7 @@ static enum hrtimer_restart io_cqring_min_timer_wakeup(=
struct hrtimer *timer)
 			goto out_wake;
 	}
=20
-	iowq->t.function =3D io_cqring_timer_wakeup;
+	hrtimer_update_function(&iowq->t, io_cqring_timer_wakeup);
 	hrtimer_set_expires(timer, iowq->timeout);
 	return HRTIMER_RESTART;
 out_wake:
diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index 48fc8cf70784..c5fb817b1e28 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -407,8 +407,7 @@ static int io_linked_timeout_update(struct io_ring_ctx *c=
tx, __u64 user_data,
 	io =3D req->async_data;
 	if (hrtimer_try_to_cancel(&io->timer) =3D=3D -1)
 		return -EALREADY;
-	hrtimer_init(&io->timer, io_timeout_get_clock(io), mode);
-	io->timer.function =3D io_link_timeout_fn;
+	hrtimer_setup(&io->timer, io_link_timeout_fn, io_timeout_get_clock(io), mod=
e);
 	hrtimer_start(&io->timer, timespec64_to_ktime(*ts), mode);
 	return 0;
 }
@@ -430,8 +429,7 @@ static int io_timeout_update(struct io_ring_ctx *ctx, __u=
64 user_data,
 	data->ts =3D *ts;
=20
 	list_add_tail(&timeout->list, &ctx->timeout_list);
-	hrtimer_init(&data->timer, io_timeout_get_clock(data), mode);
-	data->timer.function =3D io_timeout_fn;
+	hrtimer_setup(&data->timer, io_timeout_fn, io_timeout_get_clock(data), mode=
);
 	hrtimer_start(&data->timer, timespec64_to_ktime(data->ts), mode);
 	return 0;
 }
@@ -557,7 +555,6 @@ static int __io_timeout_prep(struct io_kiocb *req,
 		return -EINVAL;
=20
 	data->mode =3D io_translate_timeout_mode(flags);
-	hrtimer_init(&data->timer, io_timeout_get_clock(data), data->mode);
=20
 	if (is_timeout_link) {
 		struct io_submit_link *link =3D &req->ctx->submit_state.link;
@@ -568,6 +565,10 @@ static int __io_timeout_prep(struct io_kiocb *req,
 			return -EINVAL;
 		timeout->head =3D link->last;
 		link->last->flags |=3D REQ_F_ARM_LTIMEOUT;
+		hrtimer_setup(&data->timer, io_link_timeout_fn, io_timeout_get_clock(data),
+			      data->mode);
+	} else {
+		hrtimer_setup(&data->timer, io_timeout_fn, io_timeout_get_clock(data), dat=
a->mode);
 	}
 	return 0;
 }
@@ -627,7 +628,6 @@ int io_timeout(struct io_kiocb *req, unsigned int issue_f=
lags)
 	}
 add:
 	list_add(&timeout->list, entry);
-	data->timer.function =3D io_timeout_fn;
 	hrtimer_start(&data->timer, timespec64_to_ktime(data->ts), data->mode);
 	raw_spin_unlock_irq(&ctx->timeout_lock);
 	return IOU_ISSUE_SKIP_COMPLETE;
@@ -646,7 +646,6 @@ void io_queue_linked_timeout(struct io_kiocb *req)
 	if (timeout->head) {
 		struct io_timeout_data *data =3D req->async_data;
=20
-		data->timer.function =3D io_link_timeout_fn;
 		hrtimer_start(&data->timer, timespec64_to_ktime(data->ts),
 				data->mode);
 		list_add_tail(&timeout->list, &ctx->ltimeout_list);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f27ce162427a..672abe111282 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1284,8 +1284,7 @@ static int __bpf_async_init(struct bpf_async_kern *asyn=
c, struct bpf_map *map, u
=20
 		atomic_set(&t->cancelling, 0);
 		INIT_WORK(&t->cb.delete_work, bpf_timer_delete_work);
-		hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
-		t->timer.function =3D bpf_timer_cb;
+		hrtimer_setup(&t->timer, bpf_timer_cb, clockid, HRTIMER_MODE_REL_SOFT);
 		cb->value =3D (void *)async - map->record->timer_off;
 		break;
 	case BPF_ASYNC_TYPE_WQ:
diff --git a/kernel/events/core.c b/kernel/events/core.c
index bcb09e011e9e..db5792d79b7f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1147,8 +1147,8 @@ static void __perf_mux_hrtimer_init(struct perf_cpu_pmu=
_context *cpc, int cpu)
 	cpc->hrtimer_interval =3D ns_to_ktime(NSEC_PER_MSEC * interval);
=20
 	raw_spin_lock_init(&cpc->hrtimer_lock);
-	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
-	timer->function =3D perf_mux_hrtimer_handler;
+	hrtimer_setup(timer, perf_mux_hrtimer_handler, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_PINNED_HARD);
 }
=20
 static int perf_mux_hrtimer_restart(struct perf_cpu_pmu_context *cpc)
@@ -11367,8 +11367,7 @@ static void perf_swevent_init_hrtimer(struct perf_eve=
nt *event)
 	if (!is_sampling_event(event))
 		return;
=20
-	hrtimer_init(&hwc->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	hwc->hrtimer.function =3D perf_swevent_hrtimer;
+	hrtimer_setup(&hwc->hrtimer, perf_swevent_hrtimer, CLOCK_MONOTONIC, HRTIMER=
_MODE_REL_HARD);
=20
 	/*
 	 * Since hrtimers have a fixed rate, we can do a static freq->period
diff --git a/kernel/fork.c b/kernel/fork.c
index 735405a9c5f3..e27fe5d5a15c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1891,8 +1891,7 @@ static int copy_signal(unsigned long clone_flags, struc=
t task_struct *tsk)
 #ifdef CONFIG_POSIX_TIMERS
 	INIT_HLIST_HEAD(&sig->posix_timers);
 	INIT_HLIST_HEAD(&sig->ignored_posix_timers);
-	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	sig->real_timer.function =3D it_real_fn;
+	hrtimer_setup(&sig->real_timer, it_real_fn, CLOCK_MONOTONIC, HRTIMER_MODE_R=
EL);
 #endif
=20
 	task_lock(current->group_leader);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9aecd914ac69..6469755ea6ad 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -916,8 +916,7 @@ static void hrtick_rq_init(struct rq *rq)
 #ifdef CONFIG_SMP
 	INIT_CSD(&rq->hrtick_csd, __hrtick_start, rq);
 #endif
-	hrtimer_init(&rq->hrtick_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	rq->hrtick_timer.function =3D hrtick;
+	hrtimer_setup(&rq->hrtick_timer, hrtick, CLOCK_MONOTONIC, HRTIMER_MODE_REL_=
HARD);
 }
 #else	/* CONFIG_SCHED_HRTICK */
 static inline void hrtick_clear(struct rq *rq)
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 38e4537790af..2d0f571f95e9 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1382,8 +1382,7 @@ static void init_dl_task_timer(struct sched_dl_entity *=
dl_se)
 {
 	struct hrtimer *timer =3D &dl_se->dl_timer;
=20
-	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	timer->function =3D dl_task_timer;
+	hrtimer_setup(timer, dl_task_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 }
=20
 /*
@@ -1839,8 +1838,7 @@ static void init_dl_inactive_task_timer(struct sched_dl=
_entity *dl_se)
 {
 	struct hrtimer *timer =3D &dl_se->inactive_timer;
=20
-	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	timer->function =3D inactive_task_timer;
+	hrtimer_setup(timer, inactive_task_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL=
_HARD);
 }
=20
 #define __node_2_dle(node) \
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1c0ef435a7aa..88923f1873f6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6539,14 +6539,14 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, =
struct cfs_bandwidth *paren
 	cfs_b->hierarchical_quota =3D parent ? parent->hierarchical_quota : RUNTIME=
_INF;
=20
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
-	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED=
);
-	cfs_b->period_timer.function =3D sched_cfs_period_timer;
+	hrtimer_setup(&cfs_b->period_timer, sched_cfs_period_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_PINNED);
=20
 	/* Add a random offset so that timers interleave */
 	hrtimer_set_expires(&cfs_b->period_timer,
 			    get_random_u32_below(cfs_b->period));
-	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	cfs_b->slack_timer.function =3D sched_cfs_slack_timer;
+	hrtimer_setup(&cfs_b->slack_timer, sched_cfs_slack_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	cfs_b->slack_started =3D false;
 }
=20
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4b8e33c615b1..7a9ed4d93397 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -127,9 +127,8 @@ void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 per=
iod, u64 runtime)
=20
 	raw_spin_lock_init(&rt_b->rt_runtime_lock);
=20
-	hrtimer_init(&rt_b->rt_period_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL_HARD);
-	rt_b->rt_period_timer.function =3D sched_rt_period_timer;
+	hrtimer_setup(&rt_b->rt_period_timer, sched_rt_period_timer, CLOCK_MONOTONI=
C,
+		      HRTIMER_MODE_REL_HARD);
 }
=20
 static inline void do_start_rt_bandwidth(struct rt_bandwidth *rt_b)
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index deb1aa32814e..47df6f50e12c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1597,11 +1597,6 @@ static inline int hrtimer_clockid_to_base(clockid_t cl=
ock_id)
 	return HRTIMER_BASE_MONOTONIC;
 }
=20
-static enum hrtimer_restart hrtimer_dummy_timeout(struct hrtimer *unused)
-{
-	return HRTIMER_NORESTART;
-}
-
 static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 			   enum hrtimer_mode mode)
 {
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 163e7a2033b6..b837d3d9d325 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -678,8 +678,7 @@ void ntp_notify_cmos_timer(bool offset_set)
=20
 static void __init ntp_init_cmos_sync(void)
 {
-	hrtimer_init(&sync_hrtimer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
-	sync_hrtimer.function =3D sync_timer_callback;
+	hrtimer_setup(&sync_hrtimer, sync_timer_callback, CLOCK_REALTIME, HRTIMER_M=
ODE_ABS);
 }
 #else /* CONFIG_GENERIC_CMOS_UPDATE) || defined(CONFIG_RTC_SYSTOHC) */
 static inline void __init ntp_init_cmos_sync(void) { }
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 1b675aee99a9..58351f537a04 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -381,7 +381,7 @@ static void posix_timer_unhash_and_free(struct k_itimer *=
tmr)
=20
 static int common_timer_create(struct k_itimer *new_timer)
 {
-	hrtimer_init(&new_timer->it.real.timer, new_timer->it_clock, 0);
+	hrtimer_setup(&new_timer->it.real.timer, posix_timer_fn, new_timer->it_cloc=
k, 0);
 	return 0;
 }
=20
@@ -747,7 +747,7 @@ static void common_hrtimer_arm(struct k_itimer *timr, kti=
me_t expires,
 	/*
 	 * Posix magic: Relative CLOCK_REALTIME timers are not affected by
 	 * clock modifications, so they become CLOCK_MONOTONIC based under the
-	 * hood. See hrtimer_init(). Update timr->kclock, so the generic
+	 * hood. See hrtimer_setup(). Update timr->kclock, so the generic
 	 * functions which use timr->kclock->clock_get_*() work.
 	 *
 	 * Note: it_clock stays unmodified, because the next timer_set() might
@@ -756,8 +756,7 @@ static void common_hrtimer_arm(struct k_itimer *timr, kti=
me_t expires,
 	if (timr->it_clock =3D=3D CLOCK_REALTIME)
 		timr->kclock =3D absolute ? &clock_realtime : &clock_monotonic;
=20
-	hrtimer_init(&timr->it.real.timer, timr->it_clock, mode);
-	timr->it.real.timer.function =3D posix_timer_fn;
+	hrtimer_setup(&timr->it.real.timer, posix_timer_fn, timr->it_clock, mode);
=20
 	if (!absolute)
 		expires =3D ktime_add_safe(expires, timer->base->get_time());
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index fcca4e72f1ef..cc15fe293719 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -263,8 +263,7 @@ void __init generic_sched_clock_init(void)
 	 * Start the timer to keep sched_clock() properly updated and
 	 * sets the initial epoch.
 	 */
-	hrtimer_init(&sched_clock_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	sched_clock_timer.function =3D sched_clock_poll;
+	hrtimer_setup(&sched_clock_timer, sched_clock_poll, CLOCK_MONOTONIC, HRTIME=
R_MODE_REL_HARD);
 	hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL_HARD);
 }
=20
diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcas=
t-hrtimer.c
index e28f9210f8a1..a88b72b0f35e 100644
--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -100,7 +100,6 @@ static enum hrtimer_restart bc_handler(struct hrtimer *t)
=20
 void tick_setup_hrtimer_broadcast(void)
 {
-	hrtimer_init(&bctimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	bctimer.function =3D bc_handler;
+	hrtimer_setup(&bctimer, bc_handler, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 	clockevents_register_device(&ce_broadcast_hrtimer);
 }
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index fa058510af9c..c527b421c865 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1573,12 +1573,10 @@ void tick_setup_sched_timer(bool hrtimer)
 	struct tick_sched *ts =3D this_cpu_ptr(&tick_cpu_sched);
=20
 	/* Emulate tick processing via per-CPU hrtimers: */
-	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
+	hrtimer_setup(&ts->sched_timer, tick_nohz_handler, CLOCK_MONOTONIC, HRTIMER=
_MODE_ABS_HARD);
=20
-	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && hrtimer) {
+	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && hrtimer)
 		tick_sched_flag_set(ts, TS_FLAG_HIGHRES);
-		ts->sched_timer.function =3D tick_nohz_handler;
-	}
=20
 	/* Get the next period (per-CPU) */
 	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index f3a2722ee4c0..15999532956a 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1901,8 +1901,7 @@ static int timerlat_main(void *data)
 	tlat->count =3D 0;
 	tlat->tracing_thread =3D false;
=20
-	hrtimer_init(&tlat->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
-	tlat->timer.function =3D timerlat_irq;
+	hrtimer_setup(&tlat->timer, timerlat_irq, CLOCK_MONOTONIC, HRTIMER_MODE_ABS=
_PINNED_HARD);
 	tlat->kthread =3D current;
 	osn_var->pid =3D current->pid;
 	/*
@@ -2456,8 +2455,7 @@ static int timerlat_fd_open(struct inode *inode, struct=
 file *file)
 	tlat =3D this_cpu_tmr_var();
 	tlat->count =3D 0;
=20
-	hrtimer_init(&tlat->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
-	tlat->timer.function =3D timerlat_irq;
+	hrtimer_setup(&tlat->timer, timerlat_irq, CLOCK_MONOTONIC, HRTIMER_MODE_ABS=
_PINNED_HARD);
=20
 	migrate_enable();
 	return 0;
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index b2da7de39d06..6a98dbc931ac 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -797,8 +797,7 @@ static void watchdog_enable(unsigned int cpu)
 	 * Start the timer first to prevent the hardlockup watchdog triggering
 	 * before the timer has a chance to fire.
 	 */
-	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	hrtimer->function =3D watchdog_timer_fn;
+	hrtimer_setup(hrtimer, watchdog_timer_fn, CLOCK_MONOTONIC, HRTIMER_MODE_REL=
_HARD);
 	hrtimer_start(hrtimer, ns_to_ktime(sample_period),
 		      HRTIMER_MODE_REL_PINNED_HARD);
=20
diff --git a/lib/test_objpool.c b/lib/test_objpool.c
index 896c0131c9a8..8f688187fa87 100644
--- a/lib/test_objpool.c
+++ b/lib/test_objpool.c
@@ -190,8 +190,7 @@ static int ot_init_hrtimer(struct ot_item *item, unsigned=
 long hrtimer)
 		return -ENOENT;
=20
 	item->hrtcycle =3D ktime_set(0, hrtimer * 1000000UL);
-	hrtimer_init(hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	hrt->function =3D ot_hrtimer_handler;
+	hrtimer_setup(hrt, ot_hrtimer_handler, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	return 0;
 }
=20
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 4030907b6b7d..59578dafbf37 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1887,8 +1887,8 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 				&krcp->page_cache_work,
 					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
 		} else {
-			hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-			krcp->hrtimer.function =3D schedule_page_work_fn;
+			hrtimer_setup(&krcp->hrtimer, schedule_page_work_fn, CLOCK_MONOTONIC,
+				      HRTIMER_MODE_REL);
 			hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
 		}
 	}
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 217049fa496e..526cb6cd901f 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1011,13 +1011,12 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head=
, struct msghdr *msg,
 		op->ifindex =3D ifindex;
=20
 		/* initialize uninitialized (kzalloc) structure */
-		hrtimer_init(&op->timer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_SOFT);
-		op->timer.function =3D bcm_tx_timeout_handler;
+		hrtimer_setup(&op->timer, bcm_tx_timeout_handler, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL_SOFT);
=20
 		/* currently unused in tx_ops */
-		hrtimer_init(&op->thrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_SOFT);
+		hrtimer_setup(&op->thrtimer, hrtimer_dummy_timeout, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL_SOFT);
=20
 		/* add this bcm_op to the list of the tx_ops */
 		list_add(&op->list, &bo->tx_ops);
@@ -1192,13 +1191,10 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head=
, struct msghdr *msg,
 		op->rx_ifindex =3D ifindex;
=20
 		/* initialize uninitialized (kzalloc) structure */
-		hrtimer_init(&op->timer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_SOFT);
-		op->timer.function =3D bcm_rx_timeout_handler;
-
-		hrtimer_init(&op->thrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_SOFT);
-		op->thrtimer.function =3D bcm_rx_thr_handler;
+		hrtimer_setup(&op->timer, bcm_rx_timeout_handler, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL_SOFT);
+		hrtimer_setup(&op->thrtimer, bcm_rx_thr_handler, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL_SOFT);
=20
 		/* add this bcm_op to the list of the rx_ops */
 		list_add(&op->list, &bo->rx_ops);
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 16046931542a..442c343afe1f 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1634,12 +1634,10 @@ static int isotp_init(struct sock *sk)
 	so->rx.buflen =3D ARRAY_SIZE(so->rx.sbuf);
 	so->tx.buflen =3D ARRAY_SIZE(so->tx.sbuf);
=20
-	hrtimer_init(&so->rxtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	so->rxtimer.function =3D isotp_rx_timer_handler;
-	hrtimer_init(&so->txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	so->txtimer.function =3D isotp_tx_timer_handler;
-	hrtimer_init(&so->txfrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	so->txfrtimer.function =3D isotp_txfr_timer_handler;
+	hrtimer_setup(&so->rxtimer, isotp_rx_timer_handler, CLOCK_MONOTONIC, HRTIME=
R_MODE_REL_SOFT);
+	hrtimer_setup(&so->txtimer, isotp_tx_timer_handler, CLOCK_MONOTONIC, HRTIME=
R_MODE_REL_SOFT);
+	hrtimer_setup(&so->txfrtimer, isotp_txfr_timer_handler, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_SOFT);
=20
 	init_waitqueue_head(&so->wait);
 	spin_lock_init(&so->rx_lock);
diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index 486687901602..39844f14eed8 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -158,8 +158,8 @@ struct j1939_ecu *j1939_ecu_create_locked(struct j1939_pr=
iv *priv, name_t name)
 	ecu->addr =3D J1939_IDLE_ADDR;
 	ecu->name =3D name;
=20
-	hrtimer_init(&ecu->ac_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	ecu->ac_timer.function =3D j1939_ecu_timer_handler;
+	hrtimer_setup(&ecu->ac_timer, j1939_ecu_timer_handler, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_SOFT);
 	INIT_LIST_HEAD(&ecu->list);
=20
 	j1939_priv_get(priv);
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 9b72d118d756..fbf5c8001c9d 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1511,12 +1511,8 @@ static struct j1939_session *j1939_session_new(struct =
j1939_priv *priv,
 	skcb =3D j1939_skb_to_cb(skb);
 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
=20
-	hrtimer_init(&session->txtimer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL_SOFT);
-	session->txtimer.function =3D j1939_tp_txtimer;
-	hrtimer_init(&session->rxtimer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL_SOFT);
-	session->rxtimer.function =3D j1939_tp_rxtimer;
+	hrtimer_setup(&session->txtimer, j1939_tp_txtimer, CLOCK_MONOTONIC, HRTIMER=
_MODE_REL_SOFT);
+	hrtimer_setup(&session->rxtimer, j1939_tp_rxtimer, CLOCK_MONOTONIC, HRTIMER=
_MODE_REL_SOFT);
=20
 	netdev_dbg(priv->ndev, "%s: 0x%p: sa: %02x, da: %02x\n",
 		   __func__, session, skcb->addr.sa, skcb->addr.da);
diff --git a/net/core/dev.c b/net/core/dev.c
index b91658e8aedb..1ad2ca4d2116 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6931,8 +6931,7 @@ void netif_napi_add_weight_locked(struct net_device *de=
v,
=20
 	INIT_LIST_HEAD(&napi->poll_list);
 	INIT_HLIST_NODE(&napi->napi_hash_node);
-	hrtimer_init(&napi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
-	napi->timer.function =3D napi_watchdog;
+	hrtimer_setup(&napi->timer, napi_watchdog, CLOCK_MONOTONIC, HRTIMER_MODE_RE=
L_PINNED);
 	init_gro_hash(napi);
 	napi->skb =3D NULL;
 	INIT_LIST_HEAD(&napi->rx_list);
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index b412ed88ccd9..e7a75afa995d 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -884,11 +884,9 @@ void tcp_init_xmit_timers(struct sock *sk)
 {
 	inet_csk_init_xmit_timers(sk, &tcp_write_timer, &tcp_delack_timer,
 				  &tcp_keepalive_timer);
-	hrtimer_init(&tcp_sk(sk)->pacing_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_ABS_PINNED_SOFT);
-	tcp_sk(sk)->pacing_timer.function =3D tcp_pace_kick;
+	hrtimer_setup(&tcp_sk(sk)->pacing_timer, tcp_pace_kick, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_PINNED_SOFT);
=20
-	hrtimer_init(&tcp_sk(sk)->compressed_ack_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL_PINNED_SOFT);
-	tcp_sk(sk)->compressed_ack_timer.function =3D tcp_compressed_ack_kick;
+	hrtimer_setup(&tcp_sk(sk)->compressed_ack_timer, tcp_compressed_ack_kick, C=
LOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_PINNED_SOFT);
 }
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 21b7c3b280b4..ea1efef3572a 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -213,8 +213,8 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
 		goto out_wq;
 	}
=20
-	hrtimer_init(&local->ifs_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	local->ifs_timer.function =3D ieee802154_xmit_ifs_timer;
+	hrtimer_setup(&local->ifs_timer, ieee802154_xmit_ifs_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
 	wpan_phy_set_dev(local->phy, local->hw.parent);
=20
diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 91c0ec729823..c1f75f272757 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -287,8 +287,7 @@ static void gate_setup_timer(struct tcf_gate *gact, u64 b=
asetime,
 	gact->param.tcfg_basetime =3D basetime;
 	gact->param.tcfg_clockid =3D clockid;
 	gact->tk_offset =3D tko;
-	hrtimer_init(&gact->hitimer, clockid, HRTIMER_MODE_ABS_SOFT);
-	gact->hitimer.function =3D gate_timer_func;
+	hrtimer_setup(&gact->hitimer, gate_timer_func, clockid, HRTIMER_MODE_ABS_SO=
FT);
 }
=20
 static int tcf_gate_init(struct net *net, struct nlattr *nla,
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index e3e91cf867eb..6d85b342a857 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -619,8 +619,7 @@ static enum hrtimer_restart qdisc_watchdog(struct hrtimer=
 *timer)
 void qdisc_watchdog_init_clockid(struct qdisc_watchdog *wd, struct Qdisc *qd=
isc,
 				 clockid_t clockid)
 {
-	hrtimer_init(&wd->timer, clockid, HRTIMER_MODE_ABS_PINNED);
-	wd->timer.function =3D qdisc_watchdog;
+	hrtimer_setup(&wd->timer, qdisc_watchdog, clockid, HRTIMER_MODE_ABS_PINNED);
 	wd->qdisc =3D qdisc;
 }
 EXPORT_SYMBOL(qdisc_watchdog_init_clockid);
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index a68e17891b0b..14021b812329 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1932,8 +1932,7 @@ static int taprio_change(struct Qdisc *sch, struct nlat=
tr *opt,
 	if (!TXTIME_ASSIST_IS_ENABLED(q->flags) &&
 	    !FULL_OFFLOAD_IS_ENABLED(q->flags) &&
 	    !hrtimer_active(&q->advance_timer)) {
-		hrtimer_init(&q->advance_timer, q->clockid, HRTIMER_MODE_ABS);
-		q->advance_timer.function =3D advance_sched;
+		hrtimer_setup(&q->advance_timer, advance_sched, q->clockid, HRTIMER_MODE_A=
BS);
 	}
=20
 	err =3D taprio_get_start_time(sch, new_admin, &start);
@@ -2056,8 +2055,7 @@ static int taprio_init(struct Qdisc *sch, struct nlattr=
 *opt,
=20
 	spin_lock_init(&q->current_entry_lock);
=20
-	hrtimer_init(&q->advance_timer, CLOCK_TAI, HRTIMER_MODE_ABS);
-	q->advance_timer.function =3D advance_sched;
+	hrtimer_setup(&q->advance_timer, advance_sched, CLOCK_TAI, HRTIMER_MODE_ABS=
);
=20
 	q->root =3D sch;
=20
diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 755f1eea8bfa..3b6d7284fc70 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2625,12 +2625,10 @@ static void __iptfs_init_state(struct xfrm_state *x,
 			       struct xfrm_iptfs_data *xtfs)
 {
 	__skb_queue_head_init(&xtfs->queue);
-	hrtimer_init(&xtfs->iptfs_timer, CLOCK_MONOTONIC, IPTFS_HRTIMER_MODE);
-	xtfs->iptfs_timer.function =3D iptfs_delay_timer;
+	hrtimer_setup(&xtfs->iptfs_timer, iptfs_delay_timer, CLOCK_MONOTONIC, IPTFS=
_HRTIMER_MODE);
=20
 	spin_lock_init(&xtfs->drop_lock);
-	hrtimer_init(&xtfs->drop_timer, CLOCK_MONOTONIC, IPTFS_HRTIMER_MODE);
-	xtfs->drop_timer.function =3D iptfs_drop_timer;
+	hrtimer_setup(&xtfs->drop_timer, iptfs_drop_timer, CLOCK_MONOTONIC, IPTFS_H=
RTIMER_MODE);
=20
 	/* Modify type (esp) adjustment values */
=20
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index ad2202fa82f3..9bd14fdb67a5 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -746,8 +746,8 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
 		INIT_HLIST_NODE(&x->bysrc);
 		INIT_HLIST_NODE(&x->byspi);
 		INIT_HLIST_NODE(&x->byseq);
-		hrtimer_init(&x->mtimer, CLOCK_BOOTTIME, HRTIMER_MODE_ABS_SOFT);
-		x->mtimer.function =3D xfrm_timer_handler;
+		hrtimer_setup(&x->mtimer, xfrm_timer_handler, CLOCK_BOOTTIME,
+			      HRTIMER_MODE_ABS_SOFT);
 		timer_setup(&x->rtimer, xfrm_replay_timer_handler, 0);
 		x->curlft.add_time =3D ktime_get_real_seconds();
 		x->lft.soft_byte_limit =3D XFRM_INF;
diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 3391430e4253..83de3ae33691 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -185,8 +185,7 @@ static int snd_imx_open(struct snd_soc_component *compone=
nt,
=20
 	atomic_set(&iprtd->playing, 0);
 	atomic_set(&iprtd->capturing, 0);
-	hrtimer_init(&iprtd->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	iprtd->hrt.function =3D snd_hrtimer_callback;
+	hrtimer_setup(&iprtd->hrt, snd_hrtimer_callback, CLOCK_MONOTONIC, HRTIMER_M=
ODE_REL);
=20
 	ret =3D snd_pcm_hw_constraint_integer(substream->runtime,
 			SNDRV_PCM_HW_PARAM_PERIODS);


