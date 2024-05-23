Return-Path: <linux-kernel+bounces-187646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3276A8CD5D3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C27281526
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E741EB5B;
	Thu, 23 May 2024 14:31:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BE4625
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474681; cv=none; b=Ut/uQ91DzSUTuYVb31YDrm2L2L11TW/U27TtadrKS9qtduJr3FMWV5b/oWiy0kDA5qaMhUCgVcaaNks+AZYAadI9DuAFMHQ1+hP+MHYrQzkFUq5vUceumiYD+WhrFcR8PfeuRoCKwzC17HxWNYTADHavgrpy4qSZwHpD4HPnEHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474681; c=relaxed/simple;
	bh=5wxjxXYY5M16SJq11haOqbaKduxIuftNrA11V5+B2/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=r3B3erXbNz9DnJL9thg5e6VfYx5Pp4bw7tVkG3uiLK7EwOdcvaxdJAn3Hn8MeJB+Kb0353nsitOh3ls1vW95GBTpbbBrAjPUqbM+0NPcj9+QRFLeR0DQemFIQLj1q/+PaWvfkYjLh/ZcZipWGOuMTTO42GicJQzLHx4mFwvc00U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDCFC32782;
	Thu, 23 May 2024 14:31:20 +0000 (UTC)
Date: Thu, 23 May 2024 10:32:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] tracing/treewide: Remove second parameter of
 __assign_str()
Message-ID: <20240523103204.7c50b070@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Linus,

[
  I'm sending this now, near the end of the merge window. As it touches over
  140 files and makes over 700 updates, adding it before -rc1 would help
  prevent conflicts. I did a diff between the commit I based this off of and
  linux-next and I don't see any new __assign_str()s added. I'm doing an
  allmodconfig build of this merged with linux-next just to make sure.
]

tracing: Remove second argument of __assign_str()

The __assign_str() macro logic of the TRACE_EVENT() macro was optimized so
that it no longer needs the second argument. The __assign_str() is always
matched with __string() field that takes a field name and the source for
that field:

  __string(field, source)

The TRACE_EVENT() macro logic will save off the source value and then use
that value to copy into the ring buffer via the __assign_str(). Before
commit c1fa617caeb0 ("tracing: Rework __assign_str() and __string() to not
duplicate getting the string"), the __assign_str() needed the second
argument which would perform the same logic as the __string() source
parameter did. Not only would this add overhead, but it was error prone as
if the __assign_str() source produced something different, it may not have
allocated enough for the string in the ring buffer (as the __string()
source was used to determine how much to allocate)

Now that the __assign_str() just uses the same string that was used in
__string() it no longer needs the source parameter. It can now be removed.


Please pull the latest trace-assign-str-v6.10 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-assign-str-v6.10

Tag SHA1: a4a3570b492898d2bcff5e578856895681d93458
Head SHA1: 2c92ca849fcc6ee7d0c358e9959abc9f58661aea


Steven Rostedt (Google) (1):
      tracing/treewide: Remove second parameter of __assign_str()

----
 arch/arm64/kernel/trace-events-emulation.h         |   2 +-
 arch/powerpc/include/asm/trace.h                   |   4 +-
 arch/x86/kvm/trace.h                               |   2 +-
 drivers/base/regmap/trace.h                        |  18 ++--
 drivers/base/trace.h                               |   2 +-
 drivers/block/rnbd/rnbd-srv-trace.h                |  12 +--
 drivers/bus/mhi/host/trace.h                       |  12 +--
 drivers/cxl/core/trace.h                           |  32 +++---
 drivers/dma-buf/sync_trace.h                       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |  16 +--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h    |   2 +-
 drivers/gpu/drm/i915/display/intel_display_trace.h |  56 +++++-----
 drivers/gpu/drm/lima/lima_trace.h                  |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h          |  12 +--
 drivers/gpu/drm/scheduler/gpu_scheduler_trace.h    |   4 +-
 drivers/gpu/drm/virtio/virtgpu_trace.h             |   2 +-
 drivers/infiniband/core/cma_trace.h                |   4 +-
 drivers/infiniband/hw/hfi1/hfi.h                   |   2 +-
 drivers/infiniband/hw/hfi1/trace_dbg.h             |   2 +-
 drivers/infiniband/hw/hfi1/trace_rx.h              |   2 +-
 drivers/infiniband/hw/hfi1/trace_tid.h             |   4 +-
 drivers/infiniband/hw/hfi1/trace_tx.h              |   4 +-
 drivers/infiniband/sw/rdmavt/trace.h               |   2 +-
 drivers/infiniband/sw/rdmavt/trace_rvt.h           |   2 +-
 drivers/interconnect/trace.h                       |  10 +-
 drivers/iommu/intel/trace.h                        |  14 +--
 drivers/media/platform/nvidia/tegra-vde/trace.h    |   2 +-
 drivers/misc/mei/mei-trace.h                       |   6 +-
 drivers/net/dsa/mv88e6xxx/trace.h                  |   4 +-
 .../net/ethernet/freescale/dpaa/dpaa_eth_trace.h   |   2 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-eth-trace.h |   4 +-
 .../net/ethernet/fungible/funeth/funeth_trace.h    |   6 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_trace.h   |   4 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_trace.h   |  12 +--
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h |  10 +-
 drivers/net/ethernet/intel/i40e/i40e_trace.h       |  10 +-
 drivers/net/ethernet/intel/iavf/iavf_trace.h       |   6 +-
 drivers/net/ethernet/intel/ice/ice_trace.h         |  12 +--
 .../net/ethernet/marvell/octeontx2/af/rvu_trace.h  |  12 +--
 .../mellanox/mlx5/core/diag/cmd_tracepoint.h       |   4 +-
 .../mellanox/mlx5/core/diag/en_rep_tracepoint.h    |   2 +-
 .../mellanox/mlx5/core/diag/en_tc_tracepoint.h     |   2 +-
 .../mellanox/mlx5/core/diag/fw_tracer_tracepoint.h |   5 +-
 .../mellanox/mlx5/core/esw/diag/qos_tracepoint.h   |   8 +-
 .../mlx5/core/sf/dev/diag/dev_tracepoint.h         |   2 +-
 .../mellanox/mlx5/core/sf/diag/sf_tracepoint.h     |  14 +--
 .../mellanox/mlx5/core/sf/diag/vhca_tracepoint.h   |   2 +-
 drivers/net/fjes/fjes_trace.h                      |  10 +-
 drivers/net/hyperv/netvsc_trace.h                  |   8 +-
 drivers/net/wireless/ath/ath10k/trace.h            |  64 +++++------
 drivers/net/wireless/ath/ath11k/trace.h            |  44 ++++----
 drivers/net/wireless/ath/ath12k/trace.h            |  16 +--
 drivers/net/wireless/ath/ath6kl/trace.h            |   4 +-
 drivers/net/wireless/ath/trace.h                   |   4 +-
 .../broadcom/brcm80211/brcmfmac/tracepoint.h       |   4 +-
 .../brcm80211/brcmsmac/brcms_trace_brcmsmac.h      |   2 +-
 .../brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h  |   2 +-
 .../brcm80211/brcmsmac/brcms_trace_brcmsmac_tx.h   |   6 +-
 .../net/wireless/intel/iwlwifi/iwl-devtrace-msg.h  |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h  |   2 +-
 drivers/soc/qcom/pmic_pdcharger_ulog.h             |   2 +-
 drivers/soc/qcom/trace-aoss.h                      |   4 +-
 drivers/soc/qcom/trace-rpmh.h                      |   4 +-
 drivers/thermal/thermal_trace.h                    |  10 +-
 drivers/usb/cdns3/cdns3-trace.h                    |  26 ++---
 drivers/usb/cdns3/cdnsp-trace.h                    |  10 +-
 drivers/usb/chipidea/trace.h                       |   4 +-
 drivers/usb/dwc3/trace.h                           |   8 +-
 drivers/usb/gadget/udc/cdns2/cdns2-trace.h         |  22 ++--
 drivers/usb/gadget/udc/trace.h                     |   4 +-
 drivers/usb/mtu3/mtu3_trace.h                      |   8 +-
 drivers/usb/musb/musb_trace.h                      |  12 +--
 fs/bcachefs/trace.h                                |   6 +-
 fs/nfs/nfs4trace.h                                 |  42 ++++----
 fs/nfs/nfstrace.h                                  |  41 ++++---
 fs/nfsd/trace.h                                    |  40 +++----
 fs/ocfs2/ocfs2_trace.h                             |  60 +++++------
 fs/smb/client/trace.h                              |  18 ++--
 fs/xfs/scrub/trace.h                               |  10 +-
 fs/xfs/xfs_trace.h                                 |  28 ++---
 include/ras/ras_event.h                            |  12 +--
 include/trace/events/asoc.h                        |  22 ++--
 include/trace/events/avc.h                         |   6 +-
 include/trace/events/bridge.h                      |  16 +--
 include/trace/events/btrfs.h                       |   6 +-
 include/trace/events/cgroup.h                      |  10 +-
 include/trace/events/clk.h                         |  18 ++--
 include/trace/events/cma.h                         |   8 +-
 include/trace/events/devfreq.h                     |   4 +-
 include/trace/events/devlink.h                     |  50 ++++-----
 include/trace/events/dma_fence.h                   |   4 +-
 include/trace/events/erofs.h                       |   2 +-
 include/trace/events/f2fs.h                        |  20 ++--
 include/trace/events/habanalabs.h                  |  10 +-
 include/trace/events/huge_memory.h                 |   4 +-
 include/trace/events/hwmon.h                       |   6 +-
 include/trace/events/initcall.h                    |   2 +-
 include/trace/events/intel_ish.h                   |   2 +-
 include/trace/events/io_uring.h                    |  14 +--
 include/trace/events/iocost.h                      |  14 +--
 include/trace/events/iommu.h                       |   8 +-
 include/trace/events/irq.h                         |   2 +-
 include/trace/events/iscsi.h                       |   2 +-
 include/trace/events/kmem.h                        |   2 +-
 include/trace/events/lock.h                        |   4 +-
 include/trace/events/mmap_lock.h                   |   4 +-
 include/trace/events/mmc.h                         |   4 +-
 include/trace/events/module.h                      |   8 +-
 include/trace/events/napi.h                        |   2 +-
 include/trace/events/neigh.h                       |   6 +-
 include/trace/events/net.h                         |  12 +--
 include/trace/events/netlink.h                     |   2 +-
 include/trace/events/oom.h                         |   2 +-
 include/trace/events/osnoise.h                     |   2 +-
 include/trace/events/power.h                       |  23 ++--
 include/trace/events/pwc.h                         |   4 +-
 include/trace/events/qdisc.h                       |  12 +--
 include/trace/events/qla.h                         |   2 +-
 include/trace/events/qrtr.h                        |   2 +-
 include/trace/events/regulator.h                   |   6 +-
 include/trace/events/rpcgss.h                      |  20 ++--
 include/trace/events/rpcrdma.h                     |  52 ++++-----
 include/trace/events/rpm.h                         |   6 +-
 include/trace/events/sched.h                       |   8 +-
 include/trace/events/sof.h                         |  12 +--
 include/trace/events/sof_intel.h                   |  16 +--
 include/trace/events/sunrpc.h                      | 118 ++++++++++-----------
 include/trace/events/swiotlb.h                     |   2 +-
 include/trace/events/target.h                      |   4 +-
 include/trace/events/tegra_apb_dma.h               |   6 +-
 include/trace/events/ufs.h                         |  24 ++---
 include/trace/events/workqueue.h                   |   2 +-
 include/trace/events/xdp.h                         |   2 +-
 include/trace/stages/stage6_event_callback.h       |   4 +-
 kernel/trace/bpf_trace.h                           |   2 +-
 net/batman-adv/trace.h                             |   4 +-
 net/dsa/trace.h                                    |  34 +++---
 net/ieee802154/trace.h                             |   2 +-
 net/mac80211/trace.h                               |   2 +-
 net/openvswitch/openvswitch_trace.h                |   8 +-
 net/smc/smc_tracepoint.h                           |   4 +-
 net/tipc/trace.h                                   |  16 +--
 net/wireless/trace.h                               |   2 +-
 samples/trace_events/trace-events-sample.h         |  19 ++--
 sound/core/pcm_trace.h                             |   2 +-
 sound/hda/trace.h                                  |   6 +-
 sound/soc/intel/avs/trace.h                        |   4 +-
 147 files changed, 794 insertions(+), 808 deletions(-)
---------------------------

