Return-Path: <linux-kernel+bounces-406016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A42919C5A62
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13D4DB315DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCAC1FCC5E;
	Tue, 12 Nov 2024 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDIz+k4c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE34142659
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421374; cv=none; b=CfawH884OdnyzUCK+xhM1r+C9rL4lPaOdjq1imehvi/dpB2kPDbFMZKKclNr+A9XzQ5nA+XzghMIpbhW0x8RiOJOEW+7WVyZYs03MbdXIpScGXLBX3pnzbqwlwm6jKn9pmeV7iiTLzQsyfdrMiRTJPHNRBJiNVEyAmyq4GutPcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421374; c=relaxed/simple;
	bh=8jpomFwdy2e1xEB+LiwhN9mUnfHGe6a7MSXjWPzB5h8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EejOwHtfeoechRfSMT8yJ//QEDv3BFcbG7KYtiGXN49pnjpIAm2R0/3TEf1wmyWfUvxbDqTxedUOLTbTyBA7AiuLxlZsMfyHcJnAsIrECM42a0F8HA3QbdI8gZwR7Hih7pT5jJBHnUc2YXFrfFZP/rOuRX5zz6sv0g4tcZtG6Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDIz+k4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF20C4CECD;
	Tue, 12 Nov 2024 14:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731421373;
	bh=8jpomFwdy2e1xEB+LiwhN9mUnfHGe6a7MSXjWPzB5h8=;
	h=From:To:Cc:Subject:Date:From;
	b=gDIz+k4cWUO9HiZqPvBKYpuQAm+t6ns6mqjSXCLM9/q2aVvWGlV1zLTgG5TN/C4c6
	 M3mYFXarQfPkhxTZWvh331we7qndG/qzKJMCIhYQ3KPTL5srZoi0N70JhbP+2/NDKM
	 LwroQH1Mb401A10U5SwUd+GP47yGx3V30j7jVGppiY3u7FUxSUKS19FfEVpGzkRuY1
	 iJW+zTu9uBJwc39cxlJgbiLkc9DsRNNDm0hPjowdlUCGMWy+Xq+VjjJwoqLJrjsAzE
	 cBKyvRXI3cBMAiA6QlUMcB8bvYFXTh7FZINXzc27jbGXUNIjTjh/T87+RbfZVYpxrs
	 3WhdTPSUDhudQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 00/21] kthread: Introduce preferred affinity v5
Date: Tue, 12 Nov 2024 15:22:24 +0100
Message-ID: <20241112142248.20503-1-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Affining kthreads follow either of 4 existing different patterns:

1) Per-CPU kthreads must stay affine to a single CPU and never execute
   relevant code on any other CPU. This is currently handled by smpboot
   code which takes care of CPU-hotplug operations.

2) Kthreads that _have_ to be affine to a specific set of CPUs and can't
   run anywhere else. The affinity is set through kthread_bind_mask()
   and the subsystem takes care by itself to handle CPU-hotplug operations.

3) Kthreads that _prefer_ to be affine to a specific NUMA node.

4) Similar to the previous point but kthreads have a _preferred_ affinity
   different than a node. It is set manually like any other task and
   CPU-hotplug is supposed to be handled by the relevant subsystem so
   that the task is properly reaffined whenever a given CPU from the
   preferred affinity comes up or down. Also care must be taken so that
   the preferred affinity doesn't cross housekeeping cpumask boundaries.

Currently the preferred affinity patterns (3 and 4) have at least 4
identified users, with more or less success when it comes to handle
CPU-hotplug operations and CPU isolation.

This is an infrastructure proposal to handle this (after cleanups from 01
to 10).

Changes since v4:

* Collect more tags
* Fix a title (Vishal Chourasia)
* Handle mismatched 32bits el0 support on arm64, see patches 11 and 12
  (Will Deacon)

Frederic Weisbecker (21):
  arm/bL_switcher: Use kthread_run_on_cpu()
  x86/resctrl: Use kthread_run_on_cpu()
  firmware: stratix10-svc: Use kthread_run_on_cpu()
  scsi: bnx2fc: Use kthread_create_on_cpu()
  scsi: bnx2i: Use kthread_create_on_cpu()
  scsi: qedi: Use kthread_create_on_cpu()
  soc/qman: test: Use kthread_run_on_cpu()
  kallsyms: Use kthread_run_on_cpu()
  lib: test_objpool: Use kthread_run_on_cpu()
  net: pktgen: Use kthread_create_on_cpu()
  arm64: Keep first mismatched 32bits el0 capable CPU online through its
    callbacks
  sched,arm64: Handle CPU isolation on last resort fallback rq selection
  kthread: Make sure kthread hasn't started while binding it
  kthread: Default affine kthread to its preferred NUMA node
  mm: Create/affine kcompactd to its preferred node
  mm: Create/affine kswapd to its preferred node
  kthread: Implement preferred affinity
  rcu: Use kthread preferred affinity for RCU boost
  kthread: Unify kthread_create_on_cpu() and
    kthread_create_worker_on_cpu() automatic format
  treewide: Introduce kthread_run_worker[_on_cpu]()
  rcu: Use kthread preferred affinity for RCU exp kworkers

 arch/arm/common/bL_switcher.c                 |  10 +-
 arch/arm64/include/asm/cpufeature.h           |   1 +
 arch/arm64/include/asm/mmu_context.h          |   2 +
 arch/arm64/kernel/cpufeature.c                |  75 +++++--
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c     |  28 +--
 arch/x86/kvm/i8254.c                          |   2 +-
 crypto/crypto_engine.c                        |   2 +-
 drivers/cpufreq/cppc_cpufreq.c                |   2 +-
 drivers/firmware/stratix10-svc.c              |   9 +-
 drivers/gpu/drm/drm_vblank_work.c             |   2 +-
 .../drm/i915/gem/selftests/i915_gem_context.c |   2 +-
 drivers/gpu/drm/i915/gt/selftest_execlists.c  |   2 +-
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c  |   2 +-
 drivers/gpu/drm/i915/gt/selftest_slpc.c       |   2 +-
 drivers/gpu/drm/i915/selftests/i915_request.c |   8 +-
 drivers/gpu/drm/msm/disp/msm_disp_snapshot.c  |   2 +-
 drivers/gpu/drm/msm/msm_atomic.c              |   2 +-
 drivers/gpu/drm/msm/msm_gpu.c                 |   2 +-
 drivers/gpu/drm/msm/msm_kms.c                 |   2 +-
 .../platform/chips-media/wave5/wave5-vpu.c    |   2 +-
 drivers/net/dsa/mv88e6xxx/chip.c              |   2 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_gnss.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |   2 +-
 drivers/platform/chrome/cros_ec_spi.c         |   2 +-
 drivers/ptp/ptp_clock.c                       |   2 +-
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c             |   7 +-
 drivers/scsi/bnx2i/bnx2i_init.c               |   7 +-
 drivers/scsi/qedi/qedi_main.c                 |   6 +-
 drivers/soc/fsl/qbman/qman_test_stash.c       |   6 +-
 drivers/spi/spi.c                             |   2 +-
 drivers/usb/typec/tcpm/tcpm.c                 |   2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c              |   2 +-
 drivers/watchdog/watchdog_dev.c               |   2 +-
 fs/erofs/zdata.c                              |   2 +-
 include/linux/cpuhotplug.h                    |   1 +
 include/linux/kthread.h                       |  56 ++++-
 include/linux/mmu_context.h                   |   1 +
 kernel/kallsyms_selftest.c                    |   4 +-
 kernel/kthread.c                              | 201 ++++++++++++++++--
 kernel/rcu/tree.c                             |  94 ++------
 kernel/rcu/tree_plugin.h                      |  11 +-
 kernel/sched/core.c                           |   2 +-
 kernel/sched/ext.c                            |   2 +-
 kernel/workqueue.c                            |   2 +-
 lib/test_objpool.c                            |  19 +-
 mm/compaction.c                               |  43 +---
 mm/vmscan.c                                   |   8 +-
 net/core/pktgen.c                             |   7 +-
 net/dsa/tag_ksz.c                             |   2 +-
 net/dsa/tag_ocelot_8021q.c                    |   2 +-
 net/dsa/tag_sja1105.c                         |   2 +-
 52 files changed, 384 insertions(+), 280 deletions(-)

-- 
2.46.0


