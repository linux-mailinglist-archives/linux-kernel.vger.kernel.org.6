Return-Path: <linux-kernel+bounces-441542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F729ED002
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979AA28338B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4EC1CB9E2;
	Wed, 11 Dec 2024 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtiYbO1F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403ED1A4F22
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931642; cv=none; b=rG9r4ZT1O++jkfTIdUgDEX140BUmPoecy2Zem0ON+GADws+J+9bCA3Pe8Xfc8eohlLEFJas1eqzd4DP2OKaze0CXoUeBiuBcWK66TZqo/w5Sse/RJzUcpkSJCLmejYULcpCTdm68IlxRMI59RVajl8afx3VCaA8LPNugJEHg90M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931642; c=relaxed/simple;
	bh=Tul/0MFZNlIK7ABDEeVoaNgslTMTAWCQ0DhdYRYFLUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tAWDuKSNbgw/XmBnhFsutA7TRUs7PWoeKcfT77zvqzuQd1DVLQxzaUHM+8TqfrBfW2BBpU9CBj2i9ZP5pSE6Xu1f705YbIzKEF6MpKBo79rVD6BNRGK8IO4ZLp+aEZlsELyw8DSTZDcf6zu+U3QJG9fJxw4ofBcr6kVasndkorE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtiYbO1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF0DC4CED2;
	Wed, 11 Dec 2024 15:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931640;
	bh=Tul/0MFZNlIK7ABDEeVoaNgslTMTAWCQ0DhdYRYFLUY=;
	h=From:To:Cc:Subject:Date:From;
	b=UtiYbO1F8t5c1LHsatqU7qkT/hPWPwwLereHEQQnHgxLcWXvcsvfY9D1XzLAFqokA
	 8ziwQuQEcdeYwq+HJsCxKdZEe4Xa2W3FI7JEAmJ5cGHX30OahE8wHoI7bLPWuRrNTe
	 T/OwrdG0i7dJPhS5OwsCCZvyZFIrfZNQzGSc0SXsJsuBcqigvQf543Qcxxbp1bMYa9
	 tdXpQFTCGoKpiDNEcApBeQh6N/zVJ4IuV1uJnq9PSCxopDH72RNek9wbBuydaJq++E
	 UQiZ7XQcztCdL88Qi0j+u6xx+WOCqvu4NqVAp94l4qZSzT3OzgbV5dXPzwDHYGgY3H
	 jCIUoDv/IBUYg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH 00/19] kthread: Introduce preferred affinity v6
Date: Wed, 11 Dec 2024 16:40:13 +0100
Message-ID: <20241211154035.75565-1-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

For reference, see the summary on previous version:

https://lore.kernel.org/lkml/20241112142248.20503-3-frederic@kernel.org/T/

I don't know if anybody is willing to take this patchset. To make sure
it's not getting lost, I'm setting a branch for linux-next. If the set
happens not to be applied by anyone before the next merge window, and
if no concern arises, I'll do the pull request to Linus myself.

Changes since v5:

- Dropped two standalone patches applied to relevant maintainer's tree

- Handle the arm64 mismatched 32bit el0 support case differently as per
  Will's suggestion: nohz_full CPUs are simply treated as 64bit support
  only.

Frederic Weisbecker (19):
  arm/bL_switcher: Use kthread_run_on_cpu()
  firmware: stratix10-svc: Use kthread_run_on_cpu()
  scsi: bnx2fc: Use kthread_create_on_cpu()
  scsi: bnx2i: Use kthread_create_on_cpu()
  scsi: qedi: Use kthread_create_on_cpu()
  soc/qman: test: Use kthread_run_on_cpu()
  kallsyms: Use kthread_run_on_cpu()
  lib: test_objpool: Use kthread_run_on_cpu()
  arm64: Exclude nohz_full CPUs from 32bits el0 support
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

 Documentation/arch/arm64/asymmetric-32bit.rst |   9 +
 arch/arm/common/bL_switcher.c                 |  10 +-
 arch/arm64/include/asm/cpufeature.h           |   1 +
 arch/arm64/include/asm/mmu_context.h          |   2 +
 arch/arm64/kernel/cpufeature.c                |  17 +-
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
 net/dsa/tag_ksz.c                             |   2 +-
 net/dsa/tag_ocelot_8021q.c                    |   2 +-
 net/dsa/tag_sja1105.c                         |   2 +-
 51 files changed, 343 insertions(+), 237 deletions(-)

-- 
2.46.0


