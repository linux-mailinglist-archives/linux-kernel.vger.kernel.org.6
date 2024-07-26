Return-Path: <linux-kernel+bounces-263767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A239093DA48
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DAF28275B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB29B149E15;
	Fri, 26 Jul 2024 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1jgHPOL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228D911C83
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031027; cv=none; b=aNHSt5+FDiTVyaLkm09rOV3Ugmn+nxdKVSg6gBsgVX+fRJG1CbnXLUe1/+2ab6vmBT8VCDnJ7Ny7jYkyIvrigviKNSJNS3liawFpO7vwb0K4HjXGp8ivKJJeRWmz7PtO9oNE5ZQ/NReELRJ/JVMisdY6Qo1W2ECcYtcRXbFvcEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031027; c=relaxed/simple;
	bh=uXtmgKTUoeAnH/3ADOjmYVhHYhUOaMLgNVg+kgAEqjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5i4k5bzNE9atdOZAtlIUfjO+ca8LnHl3oVcv9/vzAgjied0cIewy/vY7roqIDPZZIEM0E6Kw756FV5LqAFWltuoxtEvHHWaNKr+gtN5n2/7n/DJpaQ3DG8ssC7przr3qWoEFHAP3njqt69oE2Ka2/CMGXdeHvGmsgxsEHMVclY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1jgHPOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AD6C32782;
	Fri, 26 Jul 2024 21:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722031026;
	bh=uXtmgKTUoeAnH/3ADOjmYVhHYhUOaMLgNVg+kgAEqjE=;
	h=From:To:Cc:Subject:Date:From;
	b=H1jgHPOLwbT31nBZ+6xxPQ3EjCol1J/yJtvqwTdXLBLe0qmMeLzG+lTiZm1+Vp7xu
	 LUUQyr42yOylZwIa5onxFkCptoETs3ZoJhth0LblYUU84LLsw8/vG0B444Zm8ZkD5e
	 H8avFUeVsGf+OCEAPZTrVHZy/t+oIRvyGpjU7Sq78gMeieWbjlv8ByhnWB3IjIveU5
	 oh7K79MPMRf40Nq744hMAqMteAFgSeAX1Supixw+CHbBAsp4t4xNfXxNdw5lWpJx+h
	 On89haRAMkJdcC3UqoygDIpoCBexcWJMQ1VkjPQtEdOcchdGVlgwRp88FeYIXzh9Yk
	 vcGdyVdKJR79A==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 00/20] kthread: Introduce preferred affinity
Date: Fri, 26 Jul 2024 23:56:36 +0200
Message-ID: <20240726215701.19459-1-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Affining kthreads follow either of three existing different patterns:

1) Per-CPU kthreads must stay affine to a single CPU and never execute
   relevant code on any other CPU. This is currently handled by smpboot
   code which takes care of CPU-hotplug operations.

2) Kthreads that _have_ to be affine to a specific set of CPUs and can't
   run anywhere else. The affinity is set through kthread_bind_mask()
   and the subsystem takes care by itself to handle CPU-hotplug operations.

3) Kthreads that have a _preferred_ affinity but that can run anywhere
   without breaking correctness. Userspace can overwrite the affinity.
   It is set manually like any other task and CPU-hotplug is supposed
   to be handled by the relevant subsystem so that the task is properly
   reaffined whenever a given CPU from the preferred affinity comes up
   or down. Also care must be taken so that the preferred affinity
   doesn't cross housekeeping cpumask boundaries.

Currently the preferred affinity pattern has at least 4 identified
users, with more or less success when it comes to handle CPU-hotplug
operations and housekeeping cpumask.

This is a infrastructure proposal to handle this (after cleanups from 01
to 10).

Frederic Weisbecker (20):
  arm/bL_switcher: Use kthread_run_on_cpu()
  x86/resctrl: Use kthread_run_on_cpu()
  firmware: stratix10-svc: Use kthread_run_on_cpu()
  scsi: bnx2fc: Use kthread_create_on_cpu()
  scsi: bnx2i: Use kthread_create_on_cpu()
  scsi: qedi: Use kthread_create_on_cpu()
  soc/qman: test: Use kthread_run_on_cpu()
  kallsyms: Use kthread_run_on_cpu()
  lib: test_objpool: Use kthread_run_on_cpu()
  net: pktgen: Use kthread_create_on_node()
  kthread: Make sure kthread hasn't started while binding it
  kthread: Implement preferred affinity
  mm: Make Kcompactd use kthread's preferred affinity
  mm: Allocate kcompactd on its node
  mm: Make kswapd use kthread's preferred affinity
  mm: Allocate kswapd on its node
  rcu: Use kthread preferred affinity for RCU boost
  kthread: Unify kthread_create_on_cpu() and
    kthread_create_worker_on_cpu() automatic format
  treewide: Introduce kthread_run_worker[_on_cpu]()
  rcu: Use kthread preferred affinity for RCU exp kworkers

 arch/arm/common/bL_switcher.c                 |  10 +-
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
 include/linux/kthread.h                       |  56 +++++-
 kernel/kallsyms_selftest.c                    |   4 +-
 kernel/kthread.c                              | 162 +++++++++++++++---
 kernel/rcu/tree.c                             |  94 ++--------
 kernel/rcu/tree_plugin.h                      |  11 +-
 kernel/workqueue.c                            |   2 +-
 lib/test_objpool.c                            |  19 +-
 mm/compaction.c                               |  43 +----
 mm/vmscan.c                                   |   8 +-
 net/core/pktgen.c                             |   7 +-
 net/dsa/tag_ksz.c                             |   2 +-
 net/dsa/tag_ocelot_8021q.c                    |   2 +-
 net/dsa/tag_sja1105.c                         |   2 +-
 46 files changed, 284 insertions(+), 258 deletions(-)

-- 
2.45.2


