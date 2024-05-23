Return-Path: <linux-kernel+bounces-187610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5018CD532
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877021C228AE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F96014B082;
	Thu, 23 May 2024 13:59:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE0213D621
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472779; cv=none; b=hnzI+qeijAnoWOJCWNufpd4v9uKXaPui+Ldtavmz05KPhb09747G/JkwxzVQWBVrpIbJHkm40xsN9C1aeqswnE/IU6qYtCKtWSRcY83M5HU5w90JFdX+NGtxyDcpzPJq457m05vmHuRwq8JnT2JvvRE06rA0CEpMapxbNJQgtd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472779; c=relaxed/simple;
	bh=A7aDgshxdxvPE6zr2SuXdprFW7lL/3tT8WBuFcSyypM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Qhv/PSC86BALgV8Pt50x0iTVfoinKwKuiIBHp7U1VqUJljAnHuKdF4hfUneqQLaj5VSaET3yClon/zyI+zCpARhJtEcHxnaLGMy9dFRdDaR1zN5TAJdR2BQ+B0ZRV9IonKl5Bxyb1MG8Tc4z0iqqYr2S9fpgKc0umEhtelC7NDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F4BC2BD10;
	Thu, 23 May 2024 13:59:36 +0000 (UTC)
Date: Thu, 23 May 2024 10:00:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Julia Lawall <Julia.Lawall@inria.fr>, Jani
 Nikula <jani.nikula@intel.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>, "Darrick J. Wong"
 <djwong@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Subject: [for-linus][PATCH] tracing/treewide: Remove second parameter of
 __assign_str()
Message-ID: <20240523100021.78128b5e@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


The __assign_str() macro logic of the TRACE_EVENT() macro was optimized so
that it no longer needs the second argument. The __assign_str() is always
matched with __string() field that takes a field name and the source for
that field:

  __string(field, source)

The TRACE_EVENT() macro logic will save off the source value and then use
that value to copy into the ring buffer via the __assign_str(). Before=20
commit c1fa617caeb0 ("tracing: Rework __assign_str() and __string() to not
duplicate getting the string"), the __assign_str() needed the second
argument which would perform the same logic as the __string() source
parameter did. Not only would this add overhead, but it was error prone as
if the __assign_str() source produced something different, it may not have
allocated enough for the string in the ring buffer (as the __string()
source was used to determine how much to allocate)

Now that the __assign_str() just uses the same string that was used in
__string() it no longer needs the source parameter. It can now be removed.

This was based on Linus's tree as of Wednesday May 22 on top of commit
de7e71ef8bed222dd144d8878091ecb6d5dfd208

Having this applied at the end of the merge window should keep conflicts to
a minimum.

I'm currently running a "make allmodconfig" with this merged into
linux-next to see if there was anything added there that would break.

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
 include/trace/events/sunrpc.h                      | 118 ++++++++++-------=
----
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
commit 2c92ca849fcc6ee7d0c358e9959abc9f58661aea
Author: Steven Rostedt (Google) <rostedt@goodmis.org>
Date:   Thu May 16 13:34:54 2024 -0400

    tracing/treewide: Remove second parameter of __assign_str()
   =20
    With the rework of how the __string() handles dynamic strings where it
    saves off the source string in field in the helper structure[1], the
    assignment of that value to the trace event field is stored in the help=
er
    value and does not need to be passed in again.
   =20
    This means that with:
   =20
      __string(field, mystring)
   =20
    Which use to be assigned with __assign_str(field, mystring), no longer
    needs the second parameter and it is unused. With this, __assign_str()
    will now only get a single parameter.
   =20
    There's over 700 users of __assign_str() and because coccinelle does not
    handle the TRACE_EVENT() macro I ended up using the following sed scrip=
t:
   =20
      git grep -l __assign_str | while read a ; do
          sed -e 's/\(__assign_str([^,]*[^ ,]\) *,[^;]*/\1)/' $a > /tmp/tes=
t-file;
          mv /tmp/test-file $a;
      done
   =20
    I then searched for __assign_str() that did not end with ';' as those
    were multi line assignments that the sed script above would fail to cat=
ch.
   =20
    Note, the same updates will need to be done for:
   =20
      __assign_str_len()
      __assign_rel_str()
      __assign_rel_str_len()
   =20
    I tested this with both an allmodconfig and an allyesconfig (build only=
 for both).
   =20
    [1] https://lore.kernel.org/linux-trace-kernel/20240222211442.634192653=
@goodmis.org/
   =20
    Link: https://lore.kernel.org/linux-trace-kernel/20240516133454.681ba6a=
0@rorschach.local.home
   =20
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Julia Lawall <Julia.Lawall@inria.fr>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
    Acked-by: Jani Nikula <jani.nikula@intel.com>
    Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com> for the amdgp=
u parts.
    Acked-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com> #for
    Acked-by: Rafael J. Wysocki <rafael@kernel.org> # for thermal
    Acked-by: Takashi Iwai <tiwai@suse.de>
    Acked-by: Darrick J. Wong <djwong@kernel.org>   # xfs
    Tested-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/arch/arm64/kernel/trace-events-emulation.h b/arch/arm64/kernel=
/trace-events-emulation.h
index 6c40f58b844a..c51b547b583e 100644
--- a/arch/arm64/kernel/trace-events-emulation.h
+++ b/arch/arm64/kernel/trace-events-emulation.h
@@ -18,7 +18,7 @@ TRACE_EVENT(instruction_emulation,
 	),
=20
 	TP_fast_assign(
-		__assign_str(instr, instr);
+		__assign_str(instr);
 		__entry->addr =3D addr;
 	),
=20
diff --git a/arch/powerpc/include/asm/trace.h b/arch/powerpc/include/asm/tr=
ace.h
index d9ac3a4f46e1..a7b69b25296b 100644
--- a/arch/powerpc/include/asm/trace.h
+++ b/arch/powerpc/include/asm/trace.h
@@ -137,7 +137,7 @@ TRACE_EVENT(rtas_input,
=20
 	TP_fast_assign(
 		__entry->nargs =3D be32_to_cpu(rtas_args->nargs);
-		__assign_str(name, name);
+		__assign_str(name);
 		be32_to_cpu_array(__get_dynamic_array(inputs), rtas_args->args, __entry-=
>nargs);
 	),
=20
@@ -162,7 +162,7 @@ TRACE_EVENT(rtas_output,
 	TP_fast_assign(
 		__entry->nr_other =3D be32_to_cpu(rtas_args->nret) - 1;
 		__entry->status =3D be32_to_cpu(rtas_args->rets[0]);
-		__assign_str(name, name);
+		__assign_str(name);
 		be32_to_cpu_array(__get_dynamic_array(other_outputs),
 				  &rtas_args->rets[1], __entry->nr_other);
 	),
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 9d0b02ef307e..e19fed438a67 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -1678,7 +1678,7 @@ TRACE_EVENT(kvm_nested_vmenter_failed,
 	),
=20
 	TP_fast_assign(
-		__assign_str(msg, msg);
+		__assign_str(msg);
 		__entry->err =3D err;
 	),
=20
diff --git a/drivers/base/regmap/trace.h b/drivers/base/regmap/trace.h
index 704e106e5dbd..bcc5a8b226a6 100644
--- a/drivers/base/regmap/trace.h
+++ b/drivers/base/regmap/trace.h
@@ -27,7 +27,7 @@ DECLARE_EVENT_CLASS(regmap_reg,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, regmap_name(map));
+		__assign_str(name);
 		__entry->reg =3D reg;
 		__entry->val =3D val;
 	),
@@ -74,7 +74,7 @@ DECLARE_EVENT_CLASS(regmap_bulk,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, regmap_name(map));
+		__assign_str(name);
 		__entry->reg =3D reg;
 		__entry->val_len =3D val_len;
 		memcpy(__get_dynamic_array(buf), val, val_len);
@@ -113,7 +113,7 @@ DECLARE_EVENT_CLASS(regmap_block,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, regmap_name(map));
+		__assign_str(name);
 		__entry->reg =3D reg;
 		__entry->count =3D count;
 	),
@@ -163,9 +163,9 @@ TRACE_EVENT(regcache_sync,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, regmap_name(map));
-		__assign_str(status, status);
-		__assign_str(type, type);
+		__assign_str(name);
+		__assign_str(status);
+		__assign_str(type);
 	),
=20
 	TP_printk("%s type=3D%s status=3D%s", __get_str(name),
@@ -184,7 +184,7 @@ DECLARE_EVENT_CLASS(regmap_bool,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, regmap_name(map));
+		__assign_str(name);
 		__entry->flag =3D flag;
 	),
=20
@@ -216,7 +216,7 @@ DECLARE_EVENT_CLASS(regmap_async,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, regmap_name(map));
+		__assign_str(name);
 	),
=20
 	TP_printk("%s", __get_str(name))
@@ -264,7 +264,7 @@ TRACE_EVENT(regcache_drop_region,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, regmap_name(map));
+		__assign_str(name);
 		__entry->from =3D from;
 		__entry->to =3D to;
 	),
diff --git a/drivers/base/trace.h b/drivers/base/trace.h
index 3192e18f877e..e52b6eae060d 100644
--- a/drivers/base/trace.h
+++ b/drivers/base/trace.h
@@ -28,7 +28,7 @@ DECLARE_EVENT_CLASS(devres,
 		__field(size_t, size)
 	),
 	TP_fast_assign(
-		__assign_str(devname, dev_name(dev));
+		__assign_str(devname);
 		__entry->op =3D op;
 		__entry->node =3D node;
 		__entry->name =3D name;
diff --git a/drivers/block/rnbd/rnbd-srv-trace.h b/drivers/block/rnbd/rnbd-=
srv-trace.h
index 8dedf73bdd28..89d0bcb17195 100644
--- a/drivers/block/rnbd/rnbd-srv-trace.h
+++ b/drivers/block/rnbd/rnbd-srv-trace.h
@@ -27,7 +27,7 @@ DECLARE_EVENT_CLASS(rnbd_srv_link_class,
=20
 	TP_fast_assign(
 		__entry->qdepth =3D srv->queue_depth;
-		__assign_str(sessname, srv->sessname);
+		__assign_str(sessname);
 	),
=20
 	TP_printk("sessname: %s qdepth: %d",
@@ -85,7 +85,7 @@ TRACE_EVENT(process_rdma,
 	),
=20
 	TP_fast_assign(
-		__assign_str(sessname, srv->sessname);
+		__assign_str(sessname);
 		__entry->dir =3D id->dir;
 		__entry->ver =3D srv->ver;
 		__entry->device_id =3D le32_to_cpu(msg->device_id);
@@ -130,7 +130,7 @@ TRACE_EVENT(process_msg_sess_info,
 		__entry->proto_ver =3D srv->ver;
 		__entry->clt_ver =3D msg->ver;
 		__entry->srv_ver =3D RNBD_PROTO_VER_MAJOR;
-		__assign_str(sessname, srv->sessname);
+		__assign_str(sessname);
 	),
=20
 	TP_printk("Session %s using proto-ver %d (clt-ver: %d, srv-ver: %d)",
@@ -165,8 +165,8 @@ TRACE_EVENT(process_msg_open,
=20
 	TP_fast_assign(
 		__entry->access_mode =3D msg->access_mode;
-		__assign_str(sessname, srv->sessname);
-		__assign_str(dev_name, msg->dev_name);
+		__assign_str(sessname);
+		__assign_str(dev_name);
 	),
=20
 	TP_printk("Open message received: session=3D'%s' path=3D'%s' access_mode=
=3D%s",
@@ -189,7 +189,7 @@ TRACE_EVENT(process_msg_close,
=20
 	TP_fast_assign(
 		__entry->device_id =3D le32_to_cpu(msg->device_id);
-		__assign_str(sessname, srv->sessname);
+		__assign_str(sessname);
 	),
=20
 	TP_printk("Close message received: session=3D'%s' device id=3D'%d'",
diff --git a/drivers/bus/mhi/host/trace.h b/drivers/bus/mhi/host/trace.h
index 368515dcb22d..95613c8ebe06 100644
--- a/drivers/bus/mhi/host/trace.h
+++ b/drivers/bus/mhi/host/trace.h
@@ -103,7 +103,7 @@ TRACE_EVENT(mhi_gen_tre,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, mhi_cntrl->mhi_dev->name);
+		__assign_str(name);
 		__entry->ch_num =3D mhi_chan->chan;
 		__entry->wp =3D mhi_tre;
 		__entry->tre_ptr =3D mhi_tre->ptr;
@@ -131,7 +131,7 @@ TRACE_EVENT(mhi_intvec_states,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, mhi_cntrl->mhi_dev->name);
+		__assign_str(name);
 		__entry->local_ee =3D mhi_cntrl->ee;
 		__entry->state =3D mhi_cntrl->dev_state;
 		__entry->dev_ee =3D dev_ee;
@@ -158,7 +158,7 @@ TRACE_EVENT(mhi_tryset_pm_state,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, mhi_cntrl->mhi_dev->name);
+		__assign_str(name);
 		if (pm_state)
 			pm_state =3D __fls(pm_state);
 		__entry->pm_state =3D pm_state;
@@ -184,7 +184,7 @@ DECLARE_EVENT_CLASS(mhi_process_event_ring,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, mhi_cntrl->mhi_dev->name);
+		__assign_str(name);
 		__entry->rp =3D rp;
 		__entry->ptr =3D rp->ptr;
 		__entry->dword0 =3D rp->dword[0];
@@ -226,7 +226,7 @@ DECLARE_EVENT_CLASS(mhi_update_channel_state,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, mhi_cntrl->mhi_dev->name);
+		__assign_str(name);
 		__entry->ch_num =3D mhi_chan->chan;
 		__entry->state =3D state;
 		__entry->reason =3D reason;
@@ -265,7 +265,7 @@ TRACE_EVENT(mhi_pm_st_transition,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, mhi_cntrl->mhi_dev->name);
+		__assign_str(name);
 		__entry->state =3D state;
 	),
=20
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 07a0394b1d99..ee5cd4eb2f16 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -60,8 +60,8 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
 	),
 	TP_fast_assign(
-		__assign_str(memdev, dev_name(&cxlmd->dev));
-		__assign_str(host, dev_name(cxlmd->dev.parent));
+		__assign_str(memdev);
+		__assign_str(host);
 		__entry->serial =3D cxlmd->cxlds->serial;
 		__entry->status =3D status;
 		__entry->first_error =3D fe;
@@ -106,8 +106,8 @@ TRACE_EVENT(cxl_aer_correctable_error,
 		__field(u32, status)
 	),
 	TP_fast_assign(
-		__assign_str(memdev, dev_name(&cxlmd->dev));
-		__assign_str(host, dev_name(cxlmd->dev.parent));
+		__assign_str(memdev);
+		__assign_str(host);
 		__entry->serial =3D cxlmd->cxlds->serial;
 		__entry->status =3D status;
 	),
@@ -142,8 +142,8 @@ TRACE_EVENT(cxl_overflow,
 	),
=20
 	TP_fast_assign(
-		__assign_str(memdev, dev_name(&cxlmd->dev));
-		__assign_str(host, dev_name(cxlmd->dev.parent));
+		__assign_str(memdev);
+		__assign_str(host);
 		__entry->serial =3D cxlmd->cxlds->serial;
 		__entry->log =3D log;
 		__entry->count =3D le16_to_cpu(payload->overflow_err_count);
@@ -200,8 +200,8 @@ TRACE_EVENT(cxl_overflow,
 	__field(u8, hdr_maint_op_class)
=20
 #define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)					\
-	__assign_str(memdev, dev_name(&(cxlmd)->dev));				\
-	__assign_str(host, dev_name((cxlmd)->dev.parent));			\
+	__assign_str(memdev);				\
+	__assign_str(host);			\
 	__entry->log =3D (l);							\
 	__entry->serial =3D (cxlmd)->cxlds->serial;				\
 	__entry->hdr_length =3D (hdr).length;					\
@@ -359,10 +359,10 @@ TRACE_EVENT(cxl_general_media,
 		__entry->validity_flags =3D get_unaligned_le16(&rec->validity_flags);
 		__entry->hpa =3D hpa;
 		if (cxlr) {
-			__assign_str(region_name, dev_name(&cxlr->dev));
+			__assign_str(region_name);
 			uuid_copy(&__entry->region_uuid, &cxlr->params.uuid);
 		} else {
-			__assign_str(region_name, "");
+			__assign_str(region_name);
 			uuid_copy(&__entry->region_uuid, &uuid_null);
 		}
 	),
@@ -462,10 +462,10 @@ TRACE_EVENT(cxl_dram,
 			CXL_EVENT_DER_CORRECTION_MASK_SIZE);
 		__entry->hpa =3D hpa;
 		if (cxlr) {
-			__assign_str(region_name, dev_name(&cxlr->dev));
+			__assign_str(region_name);
 			uuid_copy(&__entry->region_uuid, &cxlr->params.uuid);
 		} else {
-			__assign_str(region_name, "");
+			__assign_str(region_name);
 			uuid_copy(&__entry->region_uuid, &uuid_null);
 		}
 	),
@@ -692,8 +692,8 @@ TRACE_EVENT(cxl_poison,
 	    ),
=20
 	TP_fast_assign(
-		__assign_str(memdev, dev_name(&cxlmd->dev));
-		__assign_str(host, dev_name(cxlmd->dev.parent));
+		__assign_str(memdev);
+		__assign_str(host);
 		__entry->serial =3D cxlmd->cxlds->serial;
 		__entry->overflow_ts =3D cxl_poison_overflow(flags, overflow_ts);
 		__entry->dpa =3D cxl_poison_record_dpa(record);
@@ -702,12 +702,12 @@ TRACE_EVENT(cxl_poison,
 		__entry->trace_type =3D trace_type;
 		__entry->flags =3D flags;
 		if (cxlr) {
-			__assign_str(region, dev_name(&cxlr->dev));
+			__assign_str(region);
 			memcpy(__entry->uuid, &cxlr->params.uuid, 16);
 			__entry->hpa =3D cxl_trace_hpa(cxlr, cxlmd,
 						     __entry->dpa);
 		} else {
-			__assign_str(region, "");
+			__assign_str(region);
 			memset(__entry->uuid, 0, 16);
 			__entry->hpa =3D ULLONG_MAX;
 		}
diff --git a/drivers/dma-buf/sync_trace.h b/drivers/dma-buf/sync_trace.h
index 06e468a218ff..d71dcf954b8d 100644
--- a/drivers/dma-buf/sync_trace.h
+++ b/drivers/dma-buf/sync_trace.h
@@ -20,7 +20,7 @@ TRACE_EVENT(sync_timeline,
 	),
=20
 	TP_fast_assign(
-			__assign_str(name, timeline->name);
+			__assign_str(name);
 			__entry->value =3D timeline->value;
 	),
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_trace.h
index f539b1d00234..7aafeb763e5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -178,10 +178,10 @@ TRACE_EVENT(amdgpu_cs_ioctl,
=20
 	    TP_fast_assign(
 			   __entry->sched_job_id =3D job->base.id;
-			   __assign_str(timeline, AMDGPU_JOB_GET_TIMELINE_NAME(job));
+			   __assign_str(timeline);
 			   __entry->context =3D job->base.s_fence->finished.context;
 			   __entry->seqno =3D job->base.s_fence->finished.seqno;
-			   __assign_str(ring, to_amdgpu_ring(job->base.sched)->name);
+			   __assign_str(ring);
 			   __entry->num_ibs =3D job->num_ibs;
 			   ),
 	    TP_printk("sched_job=3D%llu, timeline=3D%s, context=3D%u, seqno=3D%u,=
 ring_name=3D%s, num_ibs=3D%u",
@@ -203,10 +203,10 @@ TRACE_EVENT(amdgpu_sched_run_job,
=20
 	    TP_fast_assign(
 			   __entry->sched_job_id =3D job->base.id;
-			   __assign_str(timeline, AMDGPU_JOB_GET_TIMELINE_NAME(job));
+			   __assign_str(timeline);
 			   __entry->context =3D job->base.s_fence->finished.context;
 			   __entry->seqno =3D job->base.s_fence->finished.seqno;
-			   __assign_str(ring, to_amdgpu_ring(job->base.sched)->name);
+			   __assign_str(ring);
 			   __entry->num_ibs =3D job->num_ibs;
 			   ),
 	    TP_printk("sched_job=3D%llu, timeline=3D%s, context=3D%u, seqno=3D%u,=
 ring_name=3D%s, num_ibs=3D%u",
@@ -231,7 +231,7 @@ TRACE_EVENT(amdgpu_vm_grab_id,
=20
 	    TP_fast_assign(
 			   __entry->pasid =3D vm->pasid;
-			   __assign_str(ring, ring->name);
+			   __assign_str(ring);
 			   __entry->vmid =3D job->vmid;
 			   __entry->vm_hub =3D ring->vm_hub,
 			   __entry->pd_addr =3D job->vm_pd_addr;
@@ -425,7 +425,7 @@ TRACE_EVENT(amdgpu_vm_flush,
 			     ),
=20
 	    TP_fast_assign(
-			   __assign_str(ring, ring->name);
+			   __assign_str(ring);
 			   __entry->vmid =3D vmid;
 			   __entry->vm_hub =3D ring->vm_hub;
 			   __entry->pd_addr =3D pd_addr;
@@ -526,7 +526,7 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
 			     ),
=20
 	    TP_fast_assign(
-			   __assign_str(ring, sched_job->base.sched->name);
+			   __assign_str(ring);
 			   __entry->id =3D sched_job->base.id;
 			   __entry->fence =3D fence;
 			   __entry->ctx =3D fence->context;
@@ -563,7 +563,7 @@ TRACE_EVENT(amdgpu_runpm_reference_dumps,
 			     ),
 	    TP_fast_assign(
 			   __entry->index =3D index;
-			   __assign_str(func, func);
+			   __assign_str(func);
 			   ),
 	    TP_printk("amdgpu runpm reference dump 0x%x: 0x%s\n",
 		      __entry->index,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
index 133af994a08c..4686d4b0cbad 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
@@ -87,7 +87,7 @@ TRACE_EVENT(amdgpu_dc_performance,
 			__entry->writes =3D write_count;
 			__entry->read_delta =3D read_count - *last_read;
 			__entry->write_delta =3D write_count - *last_write;
-			__assign_str(func, func);
+			__assign_str(func);
 			__entry->line =3D line;
 			*last_read =3D read_count;
 			*last_write =3D write_count;
diff --git a/drivers/gpu/drm/i915/display/intel_display_trace.h b/drivers/g=
pu/drm/i915/display/intel_display_trace.h
index 7862e7cefe02..49a5e6d9dc0d 100644
--- a/drivers/gpu/drm/i915/display/intel_display_trace.h
+++ b/drivers/gpu/drm/i915/display/intel_display_trace.h
@@ -34,7 +34,7 @@ TRACE_EVENT(intel_pipe_enable,
 	    TP_fast_assign(
 			   struct drm_i915_private *dev_priv =3D to_i915(crtc->base.dev);
 			   struct intel_crtc *it__;
-			   __assign_str(dev, __dev_name_kms(crtc));
+			   __assign_str(dev);
 			   for_each_intel_crtc(&dev_priv->drm, it__) {
 				   __entry->frame[it__->pipe] =3D intel_crtc_get_vblank_counter(it__);
 				   __entry->scanline[it__->pipe] =3D intel_get_crtc_scanline(it__);
@@ -63,7 +63,7 @@ TRACE_EVENT(intel_pipe_disable,
 	    TP_fast_assign(
 			   struct drm_i915_private *dev_priv =3D to_i915(crtc->base.dev);
 			   struct intel_crtc *it__;
-			   __assign_str(dev, __dev_name_kms(crtc));
+			   __assign_str(dev);
 			   for_each_intel_crtc(&dev_priv->drm, it__) {
 				   __entry->frame[it__->pipe] =3D intel_crtc_get_vblank_counter(it__);
 				   __entry->scanline[it__->pipe] =3D intel_get_crtc_scanline(it__);
@@ -91,7 +91,7 @@ TRACE_EVENT(intel_pipe_crc,
 			     ),
=20
 	    TP_fast_assign(
-			   __assign_str(dev, __dev_name_kms(crtc));
+			   __assign_str(dev);
 			   __entry->pipe =3D crtc->pipe;
 			   __entry->frame =3D intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline =3D intel_get_crtc_scanline(crtc);
@@ -119,7 +119,7 @@ TRACE_EVENT(intel_cpu_fifo_underrun,
=20
 	    TP_fast_assign(
 			    struct intel_crtc *crtc =3D intel_crtc_for_pipe(dev_priv, pipe);
-			   __assign_str(dev, __dev_name_kms(crtc));
+			   __assign_str(dev);
 			   __entry->pipe =3D pipe;
 			   __entry->frame =3D intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline =3D intel_get_crtc_scanline(crtc);
@@ -144,7 +144,7 @@ TRACE_EVENT(intel_pch_fifo_underrun,
 	    TP_fast_assign(
 			   enum pipe pipe =3D pch_transcoder;
 			   struct intel_crtc *crtc =3D intel_crtc_for_pipe(dev_priv, pipe);
-			   __assign_str(dev, __dev_name_i915(dev_priv));
+			   __assign_str(dev);
 			   __entry->pipe =3D pipe;
 			   __entry->frame =3D intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline =3D intel_get_crtc_scanline(crtc);
@@ -169,7 +169,7 @@ TRACE_EVENT(intel_memory_cxsr,
=20
 	    TP_fast_assign(
 			   struct intel_crtc *crtc;
-			   __assign_str(dev, __dev_name_i915(dev_priv));
+			   __assign_str(dev);
 			   for_each_intel_crtc(&dev_priv->drm, crtc) {
 				   __entry->frame[crtc->pipe] =3D intel_crtc_get_vblank_counter(crtc);
 				   __entry->scanline[crtc->pipe] =3D intel_get_crtc_scanline(crtc);
@@ -209,7 +209,7 @@ TRACE_EVENT(g4x_wm,
 			     ),
=20
 	    TP_fast_assign(
-			   __assign_str(dev, __dev_name_kms(crtc));
+			   __assign_str(dev);
 			   __entry->pipe =3D crtc->pipe;
 			   __entry->frame =3D intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline =3D intel_get_crtc_scanline(crtc);
@@ -256,7 +256,7 @@ TRACE_EVENT(vlv_wm,
 			     ),
=20
 	    TP_fast_assign(
-			   __assign_str(dev, __dev_name_kms(crtc));
+			   __assign_str(dev);
 			   __entry->pipe =3D crtc->pipe;
 			   __entry->frame =3D intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline =3D intel_get_crtc_scanline(crtc);
@@ -293,7 +293,7 @@ TRACE_EVENT(vlv_fifo_size,
 			     ),
=20
 	    TP_fast_assign(
-			   __assign_str(dev, __dev_name_kms(crtc));
+			   __assign_str(dev);
 			   __entry->pipe =3D crtc->pipe;
 			   __entry->frame =3D intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline =3D intel_get_crtc_scanline(crtc);
@@ -323,8 +323,8 @@ TRACE_EVENT(intel_plane_update_noarm,
 			     ),
=20
 	    TP_fast_assign(
-			   __assign_str(dev, __dev_name_kms(plane));
-			   __assign_str(name, plane->base.name);
+			   __assign_str(dev);
+			   __assign_str(name);
 			   __entry->pipe =3D crtc->pipe;
 			   __entry->frame =3D intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline =3D intel_get_crtc_scanline(crtc);
@@ -354,8 +354,8 @@ TRACE_EVENT(intel_plane_update_arm,
 			     ),
=20
 	    TP_fast_assign(
-			   __assign_str(dev, __dev_name_kms(plane));
-			   __assign_str(name, plane->base.name);
+			   __assign_str(dev);
+			   __assign_str(name);
 			   __entry->pipe =3D crtc->pipe;
 			   __entry->frame =3D intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline =3D intel_get_crtc_scanline(crtc);
@@ -383,8 +383,8 @@ TRACE_EVENT(intel_plane_disable_arm,
 			     ),
=20
 	    TP_fast_assign(
-			   __assign_str(dev, __dev_name_kms(plane));
-			   __assign_str(name, plane->base.name);
+			   __assign_str(dev);
+			   __assign_str(name);
 			   __entry->pipe =3D crtc->pipe;
 			   __entry->frame =3D intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline =3D intel_get_crtc_scanline(crtc);
@@ -410,8 +410,8 @@ TRACE_EVENT(intel_fbc_activate,
 	    TP_fast_assign(
 			   struct intel_crtc *crtc =3D intel_crtc_for_pipe(to_i915(plane->base.=
dev),
 									 plane->pipe);
-			   __assign_str(dev, __dev_name_kms(plane));
-			   __assign_str(name, plane->base.name);
+			   __assign_str(dev);
+			   __assign_str(name);
 			   __entry->pipe =3D crtc->pipe;
 			   __entry->frame =3D intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline =3D intel_get_crtc_scanline(crtc);
@@ -437,8 +437,8 @@ TRACE_EVENT(intel_fbc_deactivate,
 	    TP_fast_assign(
 			   struct intel_crtc *crtc =3D intel_crtc_for_pipe(to_i915(plane->base.=
dev),
 									 plane->pipe);
-			   __assign_str(dev, __dev_name_kms(plane));
-			   __assign_str(name, plane->base.name);
+			   __assign_str(dev);
+			   __assign_str(name);
 			   __entry->pipe =3D crtc->pipe;
 			   __entry->frame =3D intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline =3D intel_get_crtc_scanline(crtc);
@@ -464,8 +464,8 @@ TRACE_EVENT(intel_fbc_nuke,
 	    TP_fast_assign(
 			   struct intel_crtc *crtc =3D intel_crtc_for_pipe(to_i915(plane->base.=
dev),
 									 plane->pipe);
-			   __assign_str(dev, __dev_name_kms(plane));
-			   __assign_str(name, plane->base.name);
+			   __assign_str(dev);
+			   __assign_str(name);
 			   __entry->pipe =3D crtc->pipe;
 			   __entry->frame =3D intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline =3D intel_get_crtc_scanline(crtc);
@@ -488,7 +488,7 @@ TRACE_EVENT(intel_crtc_vblank_work_start,
 			     ),
=20
 	    TP_fast_assign(
-			   __assign_str(dev, __dev_name_kms(crtc));
+			   __assign_str(dev);
 			   __entry->pipe =3D crtc->pipe;
 			   __entry->frame =3D intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline =3D intel_get_crtc_scanline(crtc);
@@ -511,7 +511,7 @@ TRACE_EVENT(intel_crtc_vblank_work_end,
 			     ),
=20
 	    TP_fast_assign(
-			   __assign_str(dev, __dev_name_kms(crtc));
+			   __assign_str(dev);
 			   __entry->pipe =3D crtc->pipe;
 			   __entry->frame =3D intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline =3D intel_get_crtc_scanline(crtc);
@@ -536,7 +536,7 @@ TRACE_EVENT(intel_pipe_update_start,
 			     ),
=20
 	    TP_fast_assign(
-			   __assign_str(dev, __dev_name_kms(crtc));
+			   __assign_str(dev);
 			   __entry->pipe =3D crtc->pipe;
 			   __entry->frame =3D intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline =3D intel_get_crtc_scanline(crtc);
@@ -564,7 +564,7 @@ TRACE_EVENT(intel_pipe_update_vblank_evaded,
 			     ),
=20
 	    TP_fast_assign(
-			   __assign_str(dev, __dev_name_kms(crtc));
+			   __assign_str(dev);
 			   __entry->pipe =3D crtc->pipe;
 			   __entry->frame =3D crtc->debug.start_vbl_count;
 			   __entry->scanline =3D crtc->debug.scanline_start;
@@ -590,7 +590,7 @@ TRACE_EVENT(intel_pipe_update_end,
 			     ),
=20
 	    TP_fast_assign(
-			   __assign_str(dev, __dev_name_kms(crtc));
+			   __assign_str(dev);
 			   __entry->pipe =3D crtc->pipe;
 			   __entry->frame =3D frame;
 			   __entry->scanline =3D scanline_end;
@@ -613,7 +613,7 @@ TRACE_EVENT(intel_frontbuffer_invalidate,
 			     ),
=20
 	    TP_fast_assign(
-			   __assign_str(dev, __dev_name_i915(i915));
+			   __assign_str(dev);
 			   __entry->frontbuffer_bits =3D frontbuffer_bits;
 			   __entry->origin =3D origin;
 			   ),
@@ -634,7 +634,7 @@ TRACE_EVENT(intel_frontbuffer_flush,
 			     ),
=20
 	    TP_fast_assign(
-			   __assign_str(dev, __dev_name_i915(i915));
+			   __assign_str(dev);
 			   __entry->frontbuffer_bits =3D frontbuffer_bits;
 			   __entry->origin =3D origin;
 			   ),
diff --git a/drivers/gpu/drm/lima/lima_trace.h b/drivers/gpu/drm/lima/lima_=
trace.h
index 494b9790b1da..3a349d10304e 100644
--- a/drivers/gpu/drm/lima/lima_trace.h
+++ b/drivers/gpu/drm/lima/lima_trace.h
@@ -24,7 +24,7 @@ DECLARE_EVENT_CLASS(lima_task,
 		__entry->task_id =3D task->base.id;
 		__entry->context =3D task->base.s_fence->finished.context;
 		__entry->seqno =3D task->base.s_fence->finished.seqno;
-		__assign_str(pipe, task->base.sched->name);
+		__assign_str(pipe);
 		),
=20
 	TP_printk("task=3D%llu, context=3D%u seqno=3D%u pipe=3D%s",
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h b/drivers/gpu/drm/ms=
m/disp/dpu1/dpu_trace.h
index bd92fb2979aa..0fdd41162e4b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h
@@ -113,7 +113,7 @@ TRACE_EVENT(tracing_mark_write,
 	),
 	TP_fast_assign(
 			__entry->pid =3D pid;
-			__assign_str(trace_name, name);
+			__assign_str(trace_name);
 			__entry->trace_begin =3D trace_begin;
 	),
 	TP_printk("%s|%d|%s", __entry->trace_begin ? "B" : "E",
@@ -130,7 +130,7 @@ TRACE_EVENT(dpu_trace_counter,
 	),
 	TP_fast_assign(
 			__entry->pid =3D current->tgid;
-			__assign_str(counter_name, name);
+			__assign_str(counter_name);
 			__entry->value =3D value;
 	),
 	TP_printk("%d|%s|%d", __entry->pid,
@@ -379,7 +379,7 @@ TRACE_EVENT(dpu_enc_rc,
 		__entry->sw_event =3D sw_event;
 		__entry->idle_pc_supported =3D idle_pc_supported;
 		__entry->rc_state =3D rc_state;
-		__assign_str(stage_str, stage);
+		__assign_str(stage_str);
 	),
 	TP_printk("%s: id:%u, sw_event:%d, idle_pc_supported:%s, rc_state:%d",
 		  __get_str(stage_str), __entry->drm_id, __entry->sw_event,
@@ -401,7 +401,7 @@ TRACE_EVENT(dpu_enc_frame_done_cb_not_busy,
 	TP_fast_assign(
 		__entry->drm_id =3D drm_id;
 		__entry->event =3D event;
-		__assign_str(intf_mode_str, intf_mode);
+		__assign_str(intf_mode_str);
 		__entry->intf_idx =3D intf_idx;
 		__entry->wb_idx =3D wb_idx;
 	),
@@ -446,7 +446,7 @@ TRACE_EVENT(dpu_enc_trigger_flush,
 	),
 	TP_fast_assign(
 		__entry->drm_id =3D drm_id;
-		__assign_str(intf_mode_str, intf_mode);
+		__assign_str(intf_mode_str);
 		__entry->intf_idx =3D intf_idx;
 		__entry->wb_idx =3D wb_idx;
 		__entry->pending_kickoff_cnt =3D pending_kickoff_cnt;
@@ -946,7 +946,7 @@ TRACE_EVENT(dpu_core_perf_update_clk,
 		__field(	u64,			clk_rate	)
 	),
 	TP_fast_assign(
-		__assign_str(dev_name, dev->unique);
+		__assign_str(dev_name);
 		__entry->stop_req =3D stop_req;
 		__entry->clk_rate =3D clk_rate;
 	),
diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h b/drivers/gpu/=
drm/scheduler/gpu_scheduler_trace.h
index f8ed093b7356..c75302ca3427 100644
--- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
+++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
@@ -48,7 +48,7 @@ DECLARE_EVENT_CLASS(drm_sched_job,
 			   __entry->entity =3D entity;
 			   __entry->id =3D sched_job->id;
 			   __entry->fence =3D &sched_job->s_fence->finished;
-			   __assign_str(name, sched_job->sched->name);
+			   __assign_str(name);
 			   __entry->job_count =3D spsc_queue_count(&entity->job_queue);
 			   __entry->hw_job_count =3D atomic_read(
 				   &sched_job->sched->credit_count);
@@ -94,7 +94,7 @@ TRACE_EVENT(drm_sched_job_wait_dep,
 			     ),
=20
 	    TP_fast_assign(
-			   __assign_str(name, sched_job->sched->name);
+			   __assign_str(name);
 			   __entry->id =3D sched_job->id;
 			   __entry->fence =3D fence;
 			   __entry->ctx =3D fence->context;
diff --git a/drivers/gpu/drm/virtio/virtgpu_trace.h b/drivers/gpu/drm/virti=
o/virtgpu_trace.h
index 031bc77689d5..227bf0ae7ed5 100644
--- a/drivers/gpu/drm/virtio/virtgpu_trace.h
+++ b/drivers/gpu/drm/virtio/virtgpu_trace.h
@@ -25,7 +25,7 @@ DECLARE_EVENT_CLASS(virtio_gpu_cmd,
 	TP_fast_assign(
 		       __entry->dev =3D vq->vdev->index;
 		       __entry->vq =3D vq->index;
-		       __assign_str(name, vq->name);
+		       __assign_str(name);
 		       __entry->type =3D le32_to_cpu(hdr->type);
 		       __entry->flags =3D le32_to_cpu(hdr->flags);
 		       __entry->fence_id =3D le64_to_cpu(hdr->fence_id);
diff --git a/drivers/infiniband/core/cma_trace.h b/drivers/infiniband/core/=
cma_trace.h
index 47f3c6e4be89..dc622f3778be 100644
--- a/drivers/infiniband/core/cma_trace.h
+++ b/drivers/infiniband/core/cma_trace.h
@@ -84,7 +84,7 @@ TRACE_EVENT(cm_id_attach,
 		       sizeof(struct sockaddr_in6));
 		memcpy(__entry->dstaddr, &id_priv->id.route.addr.dst_addr,
 		       sizeof(struct sockaddr_in6));
-		__assign_str(devname, device->name);
+		__assign_str(devname);
 	),
=20
 	TP_printk("cm.id=3D%u src=3D%pISpc dst=3D%pISpc device=3D%s",
@@ -334,7 +334,7 @@ DECLARE_EVENT_CLASS(cma_client_class,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, device->name);
+		__assign_str(name);
 	),
=20
 	TP_printk("device name=3D%s",
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/=
hfi.h
index 4b3f1cb125fc..eb38f81aeeb1 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -2425,7 +2425,7 @@ static inline bool hfi1_need_drop(struct hfi1_devdata=
 *dd)
 int hfi1_tempsense_rd(struct hfi1_devdata *dd, struct hfi1_temp *temp);
=20
 #define DD_DEV_ENTRY(dd)       __string(dev, dev_name(&(dd)->pcidev->dev))
-#define DD_DEV_ASSIGN(dd)      __assign_str(dev, dev_name(&(dd)->pcidev->d=
ev))
+#define DD_DEV_ASSIGN(dd)      __assign_str(dev)
=20
 static inline void hfi1_update_ah_attr(struct ib_device *ibdev,
 				       struct rdma_ah_attr *attr)
diff --git a/drivers/infiniband/hw/hfi1/trace_dbg.h b/drivers/infiniband/hw=
/hfi1/trace_dbg.h
index 75599d5168db..58304b91380f 100644
--- a/drivers/infiniband/hw/hfi1/trace_dbg.h
+++ b/drivers/infiniband/hw/hfi1/trace_dbg.h
@@ -33,7 +33,7 @@ DECLARE_EVENT_CLASS(hfi1_trace_template,
 		    TP_STRUCT__entry(__string(function, function)
 				     __vstring(msg, vaf->fmt, vaf->va)
 				     ),
-		    TP_fast_assign(__assign_str(function, function);
+		    TP_fast_assign(__assign_str(function);
 				   __assign_vstr(msg, vaf->fmt, vaf->va);
 				   ),
 		    TP_printk("(%s) %s",
diff --git a/drivers/infiniband/hw/hfi1/trace_rx.h b/drivers/infiniband/hw/=
hfi1/trace_rx.h
index e6904aa80c00..8d5e12fe88a5 100644
--- a/drivers/infiniband/hw/hfi1/trace_rx.h
+++ b/drivers/infiniband/hw/hfi1/trace_rx.h
@@ -90,7 +90,7 @@ TRACE_EVENT(hfi1_mmu_invalidate,
 	    TP_fast_assign(
 			__entry->ctxt =3D ctxt;
 			__entry->subctxt =3D subctxt;
-			__assign_str(type, type);
+			__assign_str(type);
 			__entry->start =3D start;
 			__entry->end =3D end;
 	    ),
diff --git a/drivers/infiniband/hw/hfi1/trace_tid.h b/drivers/infiniband/hw=
/hfi1/trace_tid.h
index d129b8195959..e358f5b885fa 100644
--- a/drivers/infiniband/hw/hfi1/trace_tid.h
+++ b/drivers/infiniband/hw/hfi1/trace_tid.h
@@ -358,7 +358,7 @@ DECLARE_EVENT_CLASS(/* msg */
 	),
 	TP_fast_assign(/* assign */
 		__entry->qpn =3D qp ? qp->ibqp.qp_num : 0;
-		__assign_str(msg, msg);
+		__assign_str(msg);
 		__entry->more =3D more;
 	),
 	TP_printk(/* print */
@@ -651,7 +651,7 @@ DECLARE_EVENT_CLASS(/* tid_node */
 	TP_fast_assign(/* assign */
 		DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
 		__entry->qpn =3D qp->ibqp.qp_num;
-		__assign_str(msg, msg);
+		__assign_str(msg);
 		__entry->index =3D index;
 		__entry->base =3D base;
 		__entry->map =3D map;
diff --git a/drivers/infiniband/hw/hfi1/trace_tx.h b/drivers/infiniband/hw/=
hfi1/trace_tx.h
index c79856d4fdfb..c0ba6b0a2c4e 100644
--- a/drivers/infiniband/hw/hfi1/trace_tx.h
+++ b/drivers/infiniband/hw/hfi1/trace_tx.h
@@ -740,8 +740,8 @@ TRACE_EVENT(hfi1_sdma_state,
 		__string(newstate, nstate)
 	    ),
 	    TP_fast_assign(DD_DEV_ASSIGN(sde->dd);
-		__assign_str(curstate, cstate);
-		__assign_str(newstate, nstate);
+		__assign_str(curstate);
+		__assign_str(newstate);
 	    ),
 	    TP_printk("[%s] current state %s new state %s",
 		      __get_str(dev),
diff --git a/drivers/infiniband/sw/rdmavt/trace.h b/drivers/infiniband/sw/r=
dmavt/trace.h
index 4341965a5ea7..bdb6b9326b64 100644
--- a/drivers/infiniband/sw/rdmavt/trace.h
+++ b/drivers/infiniband/sw/rdmavt/trace.h
@@ -4,7 +4,7 @@
  */
=20
 #define RDI_DEV_ENTRY(rdi)   __string(dev, rvt_get_ibdev_name(rdi))
-#define RDI_DEV_ASSIGN(rdi)  __assign_str(dev, rvt_get_ibdev_name(rdi))
+#define RDI_DEV_ASSIGN(rdi)  __assign_str(dev)
=20
 #include "trace_rvt.h"
 #include "trace_qp.h"
diff --git a/drivers/infiniband/sw/rdmavt/trace_rvt.h b/drivers/infiniband/=
sw/rdmavt/trace_rvt.h
index df33c2ca9710..a00489e66ddf 100644
--- a/drivers/infiniband/sw/rdmavt/trace_rvt.h
+++ b/drivers/infiniband/sw/rdmavt/trace_rvt.h
@@ -24,7 +24,7 @@ TRACE_EVENT(rvt_dbg,
 	),
 	TP_fast_assign(
 		RDI_DEV_ASSIGN(rdi);
-		__assign_str(msg, msg);
+		__assign_str(msg);
 	),
 	TP_printk("[%s]: %s", __get_str(dev), __get_str(msg))
 );
diff --git a/drivers/interconnect/trace.h b/drivers/interconnect/trace.h
index 3d668ff566bf..206373546528 100644
--- a/drivers/interconnect/trace.h
+++ b/drivers/interconnect/trace.h
@@ -32,9 +32,9 @@ TRACE_EVENT(icc_set_bw,
 	),
=20
 	TP_fast_assign(
-		__assign_str(path_name, p->name);
-		__assign_str(dev, dev_name(p->reqs[i].dev));
-		__assign_str(node_name, n->name);
+		__assign_str(path_name);
+		__assign_str(dev);
+		__assign_str(node_name);
 		__entry->avg_bw =3D avg_bw;
 		__entry->peak_bw =3D peak_bw;
 		__entry->node_avg_bw =3D n->avg_bw;
@@ -64,8 +64,8 @@ TRACE_EVENT(icc_set_bw_end,
 	),
=20
 	TP_fast_assign(
-		__assign_str(path_name, p->name);
-		__assign_str(dev, dev_name(p->reqs[0].dev));
+		__assign_str(path_name);
+		__assign_str(dev);
 		__entry->ret =3D ret;
 	),
=20
diff --git a/drivers/iommu/intel/trace.h b/drivers/iommu/intel/trace.h
index 961ac1c1bc21..9defdae6ebae 100644
--- a/drivers/iommu/intel/trace.h
+++ b/drivers/iommu/intel/trace.h
@@ -32,7 +32,7 @@ TRACE_EVENT(qi_submit,
 	),
=20
 	TP_fast_assign(
-		__assign_str(iommu, iommu->name);
+		__assign_str(iommu);
 		__entry->qw0 =3D qw0;
 		__entry->qw1 =3D qw1;
 		__entry->qw2 =3D qw2;
@@ -79,8 +79,8 @@ TRACE_EVENT(prq_report,
 		__entry->dw2 =3D dw2;
 		__entry->dw3 =3D dw3;
 		__entry->seq =3D seq;
-		__assign_str(iommu, iommu->name);
-		__assign_str(dev, dev_name(dev));
+		__assign_str(iommu);
+		__assign_str(dev);
 	),
=20
 	TP_printk("%s/%s seq# %ld: %s",
@@ -102,8 +102,8 @@ DECLARE_EVENT_CLASS(cache_tag_log,
 		__field(u32, users)
 	),
 	TP_fast_assign(
-		__assign_str(iommu, tag->iommu->name);
-		__assign_str(dev, dev_name(tag->dev));
+		__assign_str(iommu);
+		__assign_str(dev);
 		__entry->type =3D tag->type;
 		__entry->domain_id =3D tag->domain_id;
 		__entry->pasid =3D tag->pasid;
@@ -152,8 +152,8 @@ DECLARE_EVENT_CLASS(cache_tag_flush,
 		__field(unsigned long, mask)
 	),
 	TP_fast_assign(
-		__assign_str(iommu, tag->iommu->name);
-		__assign_str(dev, dev_name(tag->dev));
+		__assign_str(iommu);
+		__assign_str(dev);
 		__entry->type =3D tag->type;
 		__entry->domain_id =3D tag->domain_id;
 		__entry->pasid =3D tag->pasid;
diff --git a/drivers/media/platform/nvidia/tegra-vde/trace.h b/drivers/medi=
a/platform/nvidia/tegra-vde/trace.h
index 7853ab095ca4..e8a75a7bd05d 100644
--- a/drivers/media/platform/nvidia/tegra-vde/trace.h
+++ b/drivers/media/platform/nvidia/tegra-vde/trace.h
@@ -20,7 +20,7 @@ DECLARE_EVENT_CLASS(register_access,
 		__field(u32, value)
 	),
 	TP_fast_assign(
-		__assign_str(hw_name, tegra_vde_reg_base_name(vde, base));
+		__assign_str(hw_name);
 		__entry->offset =3D offset;
 		__entry->value =3D value;
 	),
diff --git a/drivers/misc/mei/mei-trace.h b/drivers/misc/mei/mei-trace.h
index fe46ff2b9d69..5312edbf5190 100644
--- a/drivers/misc/mei/mei-trace.h
+++ b/drivers/misc/mei/mei-trace.h
@@ -26,7 +26,7 @@ TRACE_EVENT(mei_reg_read,
 		__field(u32, val)
 	),
 	TP_fast_assign(
-		__assign_str(dev, dev_name(dev));
+		__assign_str(dev);
 		__entry->reg  =3D reg;
 		__entry->offs =3D offs;
 		__entry->val =3D val;
@@ -45,7 +45,7 @@ TRACE_EVENT(mei_reg_write,
 		__field(u32, val)
 	),
 	TP_fast_assign(
-		__assign_str(dev, dev_name(dev));
+		__assign_str(dev);
 		__entry->reg =3D reg;
 		__entry->offs =3D offs;
 		__entry->val =3D val;
@@ -64,7 +64,7 @@ TRACE_EVENT(mei_pci_cfg_read,
 		__field(u32, val)
 	),
 	TP_fast_assign(
-		__assign_str(dev, dev_name(dev));
+		__assign_str(dev);
 		__entry->reg  =3D reg;
 		__entry->offs =3D offs;
 		__entry->val =3D val;
diff --git a/drivers/net/dsa/mv88e6xxx/trace.h b/drivers/net/dsa/mv88e6xxx/=
trace.h
index f59ca04768e7..5bd015b2b97a 100644
--- a/drivers/net/dsa/mv88e6xxx/trace.h
+++ b/drivers/net/dsa/mv88e6xxx/trace.h
@@ -28,7 +28,7 @@ DECLARE_EVENT_CLASS(mv88e6xxx_atu_violation,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, dev_name(dev));
+		__assign_str(name);
 		__entry->spid =3D spid;
 		__entry->portvec =3D portvec;
 		memcpy(__entry->addr, addr, ETH_ALEN);
@@ -68,7 +68,7 @@ DECLARE_EVENT_CLASS(mv88e6xxx_vtu_violation,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, dev_name(dev));
+		__assign_str(name);
 		__entry->spid =3D spid;
 		__entry->vid =3D vid;
 	),
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth_trace.h b/drivers=
/net/ethernet/freescale/dpaa/dpaa_eth_trace.h
index 889f89df9930..6f0e58a2a58a 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth_trace.h
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth_trace.h
@@ -57,7 +57,7 @@ DECLARE_EVENT_CLASS(dpaa_eth_fd,
 		__entry->fd_offset =3D qm_fd_get_offset(fd);
 		__entry->fd_length =3D qm_fd_get_length(fd);
 		__entry->fd_status =3D fd->status;
-		__assign_str(name, netdev->name);
+		__assign_str(name);
 	),
=20
 	/* This is what gets printed when the trace event is triggered */
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-trace.h b/drive=
rs/net/ethernet/freescale/dpaa2/dpaa2-eth-trace.h
index 9b43fadb9b11..956767e0869c 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-trace.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-trace.h
@@ -48,7 +48,7 @@ DECLARE_EVENT_CLASS(dpaa2_eth_fd,
 				   __entry->fd_addr =3D dpaa2_fd_get_addr(fd);
 				   __entry->fd_len =3D dpaa2_fd_get_len(fd);
 				   __entry->fd_offset =3D dpaa2_fd_get_offset(fd);
-				   __assign_str(name, netdev->name);
+				   __assign_str(name);
 		    ),
=20
 		    /* This is what gets printed when the trace event is
@@ -144,7 +144,7 @@ DECLARE_EVENT_CLASS(dpaa2_eth_buf,
 				   __entry->dma_addr =3D dma_addr;
 				   __entry->map_size =3D map_size;
 				   __entry->bpid =3D bpid;
-				   __assign_str(name, netdev->name);
+				   __assign_str(name);
 		    ),
=20
 		    /* This is what gets printed when the trace event is
diff --git a/drivers/net/ethernet/fungible/funeth/funeth_trace.h b/drivers/=
net/ethernet/fungible/funeth/funeth_trace.h
index 9e58dfec19d5..b9985900f30b 100644
--- a/drivers/net/ethernet/fungible/funeth/funeth_trace.h
+++ b/drivers/net/ethernet/fungible/funeth/funeth_trace.h
@@ -32,7 +32,7 @@ TRACE_EVENT(funeth_tx,
 		__entry->len =3D len;
 		__entry->sqe_idx =3D sqe_idx;
 		__entry->ngle =3D ngle;
-		__assign_str(devname, txq->netdev->name);
+		__assign_str(devname);
 	),
=20
 	TP_printk("%s: Txq %u, SQE idx %u, len %u, num GLEs %u",
@@ -62,7 +62,7 @@ TRACE_EVENT(funeth_tx_free,
 		__entry->sqe_idx =3D sqe_idx;
 		__entry->num_sqes =3D num_sqes;
 		__entry->hw_head =3D hw_head;
-		__assign_str(devname, txq->netdev->name);
+		__assign_str(devname);
 	),
=20
 	TP_printk("%s: Txq %u, SQE idx %u, SQEs %u, HW head %u",
@@ -97,7 +97,7 @@ TRACE_EVENT(funeth_rx,
 		__entry->len =3D pkt_len;
 		__entry->hash =3D hash;
 		__entry->cls_vec =3D cls_vec;
-		__assign_str(devname, rxq->netdev->name);
+		__assign_str(devname);
 	),
=20
 	TP_printk("%s: Rxq %u, CQ head %u, RQEs %u, len %u, hash %u, CV %#x",
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_trace.h b/drivers/net=
/ethernet/hisilicon/hns3/hns3_trace.h
index b8a1ecb4b8fb..3362b8d14d4f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_trace.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_trace.h
@@ -84,7 +84,7 @@ TRACE_EVENT(hns3_tx_desc,
 		__entry->desc_dma =3D ring->desc_dma_addr,
 		memcpy(__entry->desc, &ring->desc[cur_ntu],
 		       sizeof(struct hns3_desc));
-		__assign_str(devname, ring->tqp->handle->kinfo.netdev->name);
+		__assign_str(devname);
 	),
=20
 	TP_printk(
@@ -117,7 +117,7 @@ TRACE_EVENT(hns3_rx_desc,
 		__entry->buf_dma =3D ring->desc_cb[ring->next_to_clean].dma;
 		memcpy(__entry->desc, &ring->desc[ring->next_to_clean],
 		       sizeof(struct hns3_desc));
-		__assign_str(devname, ring->tqp->handle->kinfo.netdev->name);
+		__assign_str(devname);
 	),
=20
 	TP_printk(
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h b/dri=
vers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
index 7e47f0c21d88..7103cf04bffc 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
@@ -33,8 +33,8 @@ TRACE_EVENT(hclge_pf_mbx_get,
 		__entry->vfid =3D req->mbx_src_vfid;
 		__entry->code =3D req->msg.code;
 		__entry->subcode =3D req->msg.subcode;
-		__assign_str(pciname, pci_name(hdev->pdev));
-		__assign_str(devname, hdev->vport[0].nic.kinfo.netdev->name);
+		__assign_str(pciname);
+		__assign_str(devname);
 		memcpy(__entry->mbx_data, req,
 		       sizeof(struct hclge_mbx_vf_to_pf_cmd));
 	),
@@ -64,8 +64,8 @@ TRACE_EVENT(hclge_pf_mbx_send,
 	TP_fast_assign(
 		__entry->vfid =3D req->dest_vfid;
 		__entry->code =3D le16_to_cpu(req->msg.code);
-		__assign_str(pciname, pci_name(hdev->pdev));
-		__assign_str(devname, hdev->vport[0].nic.kinfo.netdev->name);
+		__assign_str(pciname);
+		__assign_str(devname);
 		memcpy(__entry->mbx_data, req,
 		       sizeof(struct hclge_mbx_pf_to_vf_cmd));
 	),
@@ -101,7 +101,7 @@ DECLARE_EVENT_CLASS(hclge_pf_cmd_template,
 			__entry->rsv =3D le16_to_cpu(desc->rsv);
 			__entry->index =3D index;
 			__entry->num =3D num;
-			__assign_str(pciname, pci_name(hw->cmq.csq.pdev));
+			__assign_str(pciname);
 			for (i =3D 0; i < HCLGE_DESC_DATA_LEN; i++)
 				__entry->data[i] =3D le32_to_cpu(desc->data[i]);),
=20
@@ -144,7 +144,7 @@ DECLARE_EVENT_CLASS(hclge_pf_special_cmd_template,
 		    TP_fast_assign(int i;
 			__entry->index =3D index;
 			__entry->num =3D num;
-			__assign_str(pciname, pci_name(hw->cmq.csq.pdev));
+			__assign_str(pciname);
 			for (i =3D 0; i < PF_DESC_LEN; i++)
 				__entry->data[i] =3D le32_to_cpu(data[i]);
 		),
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h b/d=
rivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
index e2e3a2602b6a..66b084309c91 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
@@ -30,8 +30,8 @@ TRACE_EVENT(hclge_vf_mbx_get,
 	TP_fast_assign(
 		__entry->vfid =3D req->dest_vfid;
 		__entry->code =3D le16_to_cpu(req->msg.code);
-		__assign_str(pciname, pci_name(hdev->pdev));
-		__assign_str(devname, hdev->nic.kinfo.netdev->name);
+		__assign_str(pciname);
+		__assign_str(devname);
 		memcpy(__entry->mbx_data, req,
 		       sizeof(struct hclge_mbx_pf_to_vf_cmd));
 	),
@@ -63,8 +63,8 @@ TRACE_EVENT(hclge_vf_mbx_send,
 		__entry->vfid =3D req->mbx_src_vfid;
 		__entry->code =3D req->msg.code;
 		__entry->subcode =3D req->msg.subcode;
-		__assign_str(pciname, pci_name(hdev->pdev));
-		__assign_str(devname, hdev->nic.kinfo.netdev->name);
+		__assign_str(pciname);
+		__assign_str(devname);
 		memcpy(__entry->mbx_data, req,
 		       sizeof(struct hclge_mbx_vf_to_pf_cmd));
 	),
@@ -101,7 +101,7 @@ DECLARE_EVENT_CLASS(hclge_vf_cmd_template,
 			__entry->rsv =3D le16_to_cpu(desc->rsv);
 			__entry->index =3D index;
 			__entry->num =3D num;
-			__assign_str(pciname, pci_name(hw->cmq.csq.pdev));
+			__assign_str(pciname);
 			for (i =3D 0; i < HCLGE_DESC_DATA_LEN; i++)
 				__entry->data[i] =3D le32_to_cpu(desc->data[i]);),
=20
diff --git a/drivers/net/ethernet/intel/i40e/i40e_trace.h b/drivers/net/eth=
ernet/intel/i40e/i40e_trace.h
index 33b4e30f5e00..759f3d1c4c8f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_trace.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_trace.h
@@ -89,8 +89,8 @@ TRACE_EVENT(i40e_napi_poll,
 		__entry->tx_clean_complete =3D tx_clean_complete;
 		__entry->irq_num =3D q->irq_num;
 		__entry->curr_cpu =3D get_cpu();
-		__assign_str(qname, q->name);
-		__assign_str(dev_name, napi->dev ? napi->dev->name : NO_DEV);
+		__assign_str(qname);
+		__assign_str(dev_name);
 		__assign_bitmask(irq_affinity, cpumask_bits(&q->affinity_mask),
 				 nr_cpumask_bits);
 	),
@@ -132,7 +132,7 @@ DECLARE_EVENT_CLASS(
 		__entry->ring =3D ring;
 		__entry->desc =3D desc;
 		__entry->buf =3D buf;
-		__assign_str(devname, ring->netdev->name);
+		__assign_str(devname);
 	),
=20
 	TP_printk(
@@ -177,7 +177,7 @@ DECLARE_EVENT_CLASS(
 		__entry->ring =3D ring;
 		__entry->desc =3D desc;
 		__entry->xdp =3D xdp;
-		__assign_str(devname, ring->netdev->name);
+		__assign_str(devname);
 	),
=20
 	TP_printk(
@@ -219,7 +219,7 @@ DECLARE_EVENT_CLASS(
 	TP_fast_assign(
 		__entry->skb =3D skb;
 		__entry->ring =3D ring;
-		__assign_str(devname, ring->netdev->name);
+		__assign_str(devname);
 	),
=20
 	TP_printk(
diff --git a/drivers/net/ethernet/intel/iavf/iavf_trace.h b/drivers/net/eth=
ernet/intel/iavf/iavf_trace.h
index 82fda6f5abf0..62212011c807 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_trace.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_trace.h
@@ -83,7 +83,7 @@ DECLARE_EVENT_CLASS(
 		__entry->ring =3D ring;
 		__entry->desc =3D desc;
 		__entry->buf =3D buf;
-		__assign_str(devname, ring->netdev->name);
+		__assign_str(devname);
 	),
=20
 	TP_printk(
@@ -128,7 +128,7 @@ DECLARE_EVENT_CLASS(
 		__entry->ring =3D ring;
 		__entry->desc =3D desc;
 		__entry->skb =3D skb;
-		__assign_str(devname, ring->netdev->name);
+		__assign_str(devname);
 	),
=20
 	TP_printk(
@@ -170,7 +170,7 @@ DECLARE_EVENT_CLASS(
 	TP_fast_assign(
 		__entry->skb =3D skb;
 		__entry->ring =3D ring;
-		__assign_str(devname, ring->netdev->name);
+		__assign_str(devname);
 	),
=20
 	TP_printk(
diff --git a/drivers/net/ethernet/intel/ice/ice_trace.h b/drivers/net/ether=
net/intel/ice/ice_trace.h
index b2f5c9fe0149..244cddd2a9ea 100644
--- a/drivers/net/ethernet/intel/ice/ice_trace.h
+++ b/drivers/net/ethernet/intel/ice/ice_trace.h
@@ -69,7 +69,7 @@ DECLARE_EVENT_CLASS(ice_rx_dim_template,
=20
 		    TP_fast_assign(__entry->q_vector =3D q_vector;
 				   __entry->dim =3D dim;
-				   __assign_str(devname, q_vector->rx.rx_ring->netdev->name);),
+				   __assign_str(devname);),
=20
 		    TP_printk("netdev: %s Rx-Q: %d dim-state: %d dim-profile: %d dim-tun=
e: %d dim-st-right: %d dim-st-left: %d dim-tired: %d",
 			      __get_str(devname),
@@ -96,7 +96,7 @@ DECLARE_EVENT_CLASS(ice_tx_dim_template,
=20
 		    TP_fast_assign(__entry->q_vector =3D q_vector;
 				   __entry->dim =3D dim;
-				   __assign_str(devname, q_vector->tx.tx_ring->netdev->name);),
+				   __assign_str(devname);),
=20
 		    TP_printk("netdev: %s Tx-Q: %d dim-state: %d dim-profile: %d dim-tun=
e: %d dim-st-right: %d dim-st-left: %d dim-tired: %d",
 			      __get_str(devname),
@@ -128,7 +128,7 @@ DECLARE_EVENT_CLASS(ice_tx_template,
 		    TP_fast_assign(__entry->ring =3D ring;
 				   __entry->desc =3D desc;
 				   __entry->buf =3D buf;
-				   __assign_str(devname, ring->netdev->name);),
+				   __assign_str(devname);),
=20
 		    TP_printk("netdev: %s ring: %pK desc: %pK buf %pK", __get_str(devnam=
e),
 			      __entry->ring, __entry->desc, __entry->buf)
@@ -156,7 +156,7 @@ DECLARE_EVENT_CLASS(ice_rx_template,
=20
 		    TP_fast_assign(__entry->ring =3D ring;
 				   __entry->desc =3D desc;
-				   __assign_str(devname, ring->netdev->name);),
+				   __assign_str(devname);),
=20
 		    TP_printk("netdev: %s ring: %pK desc: %pK", __get_str(devname),
 			      __entry->ring, __entry->desc)
@@ -180,7 +180,7 @@ DECLARE_EVENT_CLASS(ice_rx_indicate_template,
 		    TP_fast_assign(__entry->ring =3D ring;
 				   __entry->desc =3D desc;
 				   __entry->skb =3D skb;
-				   __assign_str(devname, ring->netdev->name);),
+				   __assign_str(devname);),
=20
 		    TP_printk("netdev: %s ring: %pK desc: %pK skb %pK", __get_str(devnam=
e),
 			      __entry->ring, __entry->desc, __entry->skb)
@@ -203,7 +203,7 @@ DECLARE_EVENT_CLASS(ice_xmit_template,
=20
 		    TP_fast_assign(__entry->ring =3D ring;
 				   __entry->skb =3D skb;
-				   __assign_str(devname, ring->netdev->name);),
+				   __assign_str(devname);),
=20
 		    TP_printk("netdev: %s skb: %pK ring: %pK", __get_str(devname),
 			      __entry->skb, __entry->ring)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h b/driver=
s/net/ethernet/marvell/octeontx2/af/rvu_trace.h
index 28984d0e848a..5704520f9b02 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
@@ -24,7 +24,7 @@ TRACE_EVENT(otx2_msg_alloc,
 			     __field(u16, id)
 			     __field(u64, size)
 	    ),
-	    TP_fast_assign(__assign_str(dev, pci_name(pdev));
+	    TP_fast_assign(__assign_str(dev);
 			   __entry->id =3D id;
 			   __entry->size =3D size;
 	    ),
@@ -39,7 +39,7 @@ TRACE_EVENT(otx2_msg_send,
 			     __field(u16, num_msgs)
 			     __field(u64, msg_size)
 	    ),
-	    TP_fast_assign(__assign_str(dev, pci_name(pdev));
+	    TP_fast_assign(__assign_str(dev);
 			   __entry->num_msgs =3D num_msgs;
 			   __entry->msg_size =3D msg_size;
 	    ),
@@ -55,7 +55,7 @@ TRACE_EVENT(otx2_msg_check,
 			     __field(u16, rspid)
 			     __field(int, rc)
 	    ),
-	    TP_fast_assign(__assign_str(dev, pci_name(pdev));
+	    TP_fast_assign(__assign_str(dev);
 			   __entry->reqid =3D reqid;
 			   __entry->rspid =3D rspid;
 			   __entry->rc =3D rc;
@@ -72,8 +72,8 @@ TRACE_EVENT(otx2_msg_interrupt,
 			     __string(str, msg)
 			     __field(u64, intr)
 	    ),
-	    TP_fast_assign(__assign_str(dev, pci_name(pdev));
-			   __assign_str(str, msg);
+	    TP_fast_assign(__assign_str(dev);
+			   __assign_str(str);
 			   __entry->intr =3D intr;
 	    ),
 	    TP_printk("[%s] mbox interrupt %s (0x%llx)\n", __get_str(dev),
@@ -87,7 +87,7 @@ TRACE_EVENT(otx2_msg_process,
 			     __field(u16, id)
 			     __field(int, err)
 	    ),
-	    TP_fast_assign(__assign_str(dev, pci_name(pdev));
+	    TP_fast_assign(__assign_str(dev);
 			   __entry->id =3D id;
 			   __entry->err =3D err;
 	    ),
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/cmd_tracepoint.h =
b/drivers/net/ethernet/mellanox/mlx5/core/diag/cmd_tracepoint.h
index 406ebe17405f..b4b3a43e56a0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/cmd_tracepoint.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/cmd_tracepoint.h
@@ -22,10 +22,10 @@ TRACE_EVENT(mlx5_cmd,
 			    __field(u32, syndrome)
 			    __field(int, err)
 			    ),
-	    TP_fast_assign(__assign_str(command_str, command_str);
+	    TP_fast_assign(__assign_str(command_str);
 			__entry->opcode =3D opcode;
 			__entry->op_mod =3D op_mod;
-			__assign_str(status_str, status_str);
+			__assign_str(status_str);
 			__entry->status =3D status;
 			__entry->syndrome =3D syndrome;
 			__entry->err =3D err;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/en_rep_tracepoint=
h b/drivers/net/ethernet/mellanox/mlx5/core/diag/en_rep_tracepoint.h
index f15718db5d0e..78e481b2c015 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/en_rep_tracepoint.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/en_rep_tracepoint.h
@@ -25,7 +25,7 @@ TRACE_EVENT(mlx5e_rep_neigh_update,
 			struct in6_addr *pin6;
 			__be32 *p32;
=20
-			__assign_str(devname, nhe->neigh_dev->name);
+			__assign_str(devname);
 			__entry->neigh_connected =3D neigh_connected;
 			memcpy(__entry->ha, ha, ETH_ALEN);
=20
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/en_tc_tracepoint.=
h b/drivers/net/ethernet/mellanox/mlx5/core/diag/en_tc_tracepoint.h
index ac52ef37f38a..4b1ca228012b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/en_tc_tracepoint.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/en_tc_tracepoint.h
@@ -86,7 +86,7 @@ TRACE_EVENT(mlx5e_tc_update_neigh_used_value,
 			struct in6_addr *pin6;
 			__be32 *p32;
=20
-			__assign_str(devname, nhe->neigh_dev->name);
+			__assign_str(devname);
 			__entry->neigh_used =3D neigh_used;
=20
 			p32 =3D (__be32 *)__entry->v4;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer_tracepo=
int.h b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer_tracepoint.h
index 3038be575923..50f8a7630f86 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer_tracepoint.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer_tracepoint.h
@@ -55,12 +55,11 @@ TRACE_EVENT(mlx5_fw,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev_name,
-			     dev_name(tracer->dev->device));
+		__assign_str(dev_name);
 		__entry->trace_timestamp =3D trace_timestamp;
 		__entry->lost =3D lost;
 		__entry->event_id =3D event_id;
-		__assign_str(msg, msg);
+		__assign_str(msg);
 	),
=20
 	TP_printk("%s [0x%llx] %d [0x%x] %s",
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoin=
t.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h
index 458baf0c6415..1ce332f21ebe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h
@@ -17,7 +17,7 @@ TRACE_EVENT(mlx5_esw_vport_qos_destroy,
 			     __field(unsigned short, vport_id)
 			     __field(unsigned int,   tsar_ix)
 			     ),
-	    TP_fast_assign(__assign_str(devname, dev_name(vport->dev->device));
+	    TP_fast_assign(__assign_str(devname);
 		    __entry->vport_id =3D vport->vport;
 		    __entry->tsar_ix =3D vport->qos.esw_tsar_ix;
 	    ),
@@ -36,7 +36,7 @@ DECLARE_EVENT_CLASS(mlx5_esw_vport_qos_template,
 				     __field(unsigned int, max_rate)
 				     __field(void *, group)
 				     ),
-		    TP_fast_assign(__assign_str(devname, dev_name(vport->dev->device));
+		    TP_fast_assign(__assign_str(devname);
 			    __entry->vport_id =3D vport->vport;
 			    __entry->tsar_ix =3D vport->qos.esw_tsar_ix;
 			    __entry->bw_share =3D bw_share;
@@ -68,7 +68,7 @@ DECLARE_EVENT_CLASS(mlx5_esw_group_qos_template,
 				     __field(const void *, group)
 				     __field(unsigned int, tsar_ix)
 				     ),
-		    TP_fast_assign(__assign_str(devname, dev_name(dev->device));
+		    TP_fast_assign(__assign_str(devname);
 			    __entry->group =3D group;
 			    __entry->tsar_ix =3D tsar_ix;
 		    ),
@@ -102,7 +102,7 @@ TRACE_EVENT(mlx5_esw_group_qos_config,
 			     __field(unsigned int, bw_share)
 			     __field(unsigned int, max_rate)
 			     ),
-	    TP_fast_assign(__assign_str(devname, dev_name(dev->device));
+	    TP_fast_assign(__assign_str(devname);
 		    __entry->group =3D group;
 		    __entry->tsar_ix =3D tsar_ix;
 		    __entry->bw_share =3D bw_share;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/diag/dev_tracep=
oint.h b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/diag/dev_tracepoint=
h
index 7f7c9af5deed..0537de86f981 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/diag/dev_tracepoint.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/diag/dev_tracepoint.h
@@ -22,7 +22,7 @@ DECLARE_EVENT_CLASS(mlx5_sf_dev_template,
 				     __field(u16, hw_fn_id)
 				     __field(u32, sfnum)
 		    ),
-		    TP_fast_assign(__assign_str(devname, dev_name(dev->device));
+		    TP_fast_assign(__assign_str(devname);
 				   __entry->sfdev =3D sfdev;
 				   __entry->aux_id =3D aux_id;
 				   __entry->hw_fn_id =3D sfdev->fn_id;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/diag/sf_tracepoint.=
h b/drivers/net/ethernet/mellanox/mlx5/core/sf/diag/sf_tracepoint.h
index 8bf1cd90930d..302ce00da5a9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/diag/sf_tracepoint.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/diag/sf_tracepoint.h
@@ -24,7 +24,7 @@ TRACE_EVENT(mlx5_sf_add,
 			     __field(u16, hw_fn_id)
 			     __field(u32, sfnum)
 			    ),
-	    TP_fast_assign(__assign_str(devname, dev_name(dev->device));
+	    TP_fast_assign(__assign_str(devname);
 		    __entry->port_index =3D port_index;
 		    __entry->controller =3D controller;
 		    __entry->hw_fn_id =3D hw_fn_id;
@@ -46,7 +46,7 @@ TRACE_EVENT(mlx5_sf_free,
 			     __field(u32, controller)
 			     __field(u16, hw_fn_id)
 			    ),
-	    TP_fast_assign(__assign_str(devname, dev_name(dev->device));
+	    TP_fast_assign(__assign_str(devname);
 		    __entry->port_index =3D port_index;
 		    __entry->controller =3D controller;
 		    __entry->hw_fn_id =3D hw_fn_id;
@@ -67,7 +67,7 @@ TRACE_EVENT(mlx5_sf_hwc_alloc,
 			     __field(u16, hw_fn_id)
 			     __field(u32, sfnum)
 			    ),
-	    TP_fast_assign(__assign_str(devname, dev_name(dev->device));
+	    TP_fast_assign(__assign_str(devname);
 		    __entry->controller =3D controller;
 		    __entry->hw_fn_id =3D hw_fn_id;
 		    __entry->sfnum =3D sfnum;
@@ -84,7 +84,7 @@ TRACE_EVENT(mlx5_sf_hwc_free,
 	    TP_STRUCT__entry(__string(devname, dev_name(dev->device))
 			     __field(u16, hw_fn_id)
 			    ),
-	    TP_fast_assign(__assign_str(devname, dev_name(dev->device));
+	    TP_fast_assign(__assign_str(devname);
 		    __entry->hw_fn_id =3D hw_fn_id;
 	    ),
 	    TP_printk("(%s) hw_id=3D0x%x\n", __get_str(devname), __entry->hw_fn_i=
d)
@@ -97,7 +97,7 @@ TRACE_EVENT(mlx5_sf_hwc_deferred_free,
 	    TP_STRUCT__entry(__string(devname, dev_name(dev->device))
 			     __field(u16, hw_fn_id)
 			    ),
-	    TP_fast_assign(__assign_str(devname, dev_name(dev->device));
+	    TP_fast_assign(__assign_str(devname);
 		    __entry->hw_fn_id =3D hw_fn_id;
 	    ),
 	    TP_printk("(%s) hw_id=3D0x%x\n", __get_str(devname), __entry->hw_fn_i=
d)
@@ -113,7 +113,7 @@ DECLARE_EVENT_CLASS(mlx5_sf_state_template,
 				     __field(unsigned int, port_index)
 				     __field(u32, controller)
 				     __field(u16, hw_fn_id)),
-		    TP_fast_assign(__assign_str(devname, dev_name(dev->device));
+		    TP_fast_assign(__assign_str(devname);
 				   __entry->port_index =3D port_index;
 				   __entry->controller =3D controller;
 				   __entry->hw_fn_id =3D hw_fn_id;
@@ -152,7 +152,7 @@ TRACE_EVENT(mlx5_sf_update_state,
 			     __field(u16, hw_fn_id)
 			     __field(u8, state)
 			    ),
-	    TP_fast_assign(__assign_str(devname, dev_name(dev->device));
+	    TP_fast_assign(__assign_str(devname);
 		    __entry->port_index =3D port_index;
 		    __entry->controller =3D controller;
 		    __entry->hw_fn_id =3D hw_fn_id;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/diag/vhca_tracepoin=
t.h b/drivers/net/ethernet/mellanox/mlx5/core/sf/diag/vhca_tracepoint.h
index fd814a190b8b..6352cb004a18 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/diag/vhca_tracepoint.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/diag/vhca_tracepoint.h
@@ -20,7 +20,7 @@ TRACE_EVENT(mlx5_sf_vhca_event,
 			     __field(u32, sfnum)
 			     __field(u8, vhca_state)
 			    ),
-	    TP_fast_assign(__assign_str(devname, dev_name(dev->device));
+	    TP_fast_assign(__assign_str(devname);
 		    __entry->hw_fn_id =3D event->function_id;
 		    __entry->sfnum =3D event->sw_function_id;
 		    __entry->vhca_state =3D event->new_vhca_state;
diff --git a/drivers/net/fjes/fjes_trace.h b/drivers/net/fjes/fjes_trace.h
index 6437ddbd7842..166ef015262b 100644
--- a/drivers/net/fjes/fjes_trace.h
+++ b/drivers/net/fjes/fjes_trace.h
@@ -85,7 +85,7 @@ TRACE_EVENT(fjes_hw_request_info_err,
 		__string(err, err)
 	),
 	TP_fast_assign(
-		__assign_str(err, err);
+		__assign_str(err);
 	),
 	TP_printk("%s", __get_str(err))
 );
@@ -145,7 +145,7 @@ TRACE_EVENT(fjes_hw_register_buff_addr_err,
 		__string(err, err)
 	),
 	TP_fast_assign(
-		__assign_str(err, err);
+		__assign_str(err);
 	),
 	TP_printk("%s", __get_str(err))
 );
@@ -189,7 +189,7 @@ TRACE_EVENT(fjes_hw_unregister_buff_addr_err,
 		__string(err, err)
 	),
 	TP_fast_assign(
-		__assign_str(err, err);
+		__assign_str(err);
 	),
 	TP_printk("%s", __get_str(err))
 );
@@ -232,7 +232,7 @@ TRACE_EVENT(fjes_hw_start_debug_err,
 		 __string(err, err)
 	),
 	TP_fast_assign(
-		__assign_str(err, err);
+		__assign_str(err);
 	),
 	TP_printk("%s", __get_str(err))
 );
@@ -258,7 +258,7 @@ TRACE_EVENT(fjes_hw_stop_debug_err,
 		 __string(err, err)
 	),
 	TP_fast_assign(
-		__assign_str(err, err);
+		__assign_str(err);
 	),
 	TP_printk("%s", __get_str(err))
 );
diff --git a/drivers/net/hyperv/netvsc_trace.h b/drivers/net/hyperv/netvsc_=
trace.h
index f7585563dea5..05e620cbdd29 100644
--- a/drivers/net/hyperv/netvsc_trace.h
+++ b/drivers/net/hyperv/netvsc_trace.h
@@ -51,7 +51,7 @@ DECLARE_EVENT_CLASS(rndis_msg_class,
 	       __field(	 u32,  msg_len	   )
        ),
        TP_fast_assign(
-	       __assign_str(name, ndev->name);
+	       __assign_str(name);
 	       __entry->queue	 =3D q;
 	       __entry->req_id	 =3D msg->msg.init_req.req_id;
 	       __entry->msg_type =3D msg->ndis_msg_type;
@@ -121,7 +121,7 @@ TRACE_EVENT(nvsp_send,
 		__field(  u32,	msg_type    )
 	),
 	TP_fast_assign(
-		__assign_str(name, ndev->name);
+		__assign_str(name);
 		__entry->msg_type =3D msg->hdr.msg_type;
 	),
 	TP_printk("dev=3D%s type=3D%s",
@@ -142,7 +142,7 @@ TRACE_EVENT(nvsp_send_pkt,
 		__field(  u32,	section_size  )
 	),
 	TP_fast_assign(
-		__assign_str(name, ndev->name);
+		__assign_str(name);
 		__entry->qid =3D chan->offermsg.offer.sub_channel_index;
 		__entry->channel_type =3D rpkt->channel_type;
 		__entry->section_index =3D rpkt->send_buf_section_index;
@@ -165,7 +165,7 @@ TRACE_EVENT(nvsp_recv,
 		__field(  u32,	msg_type    )
 	),
 	TP_fast_assign(
-		__assign_str(name, ndev->name);
+		__assign_str(name);
 		__entry->qid =3D chan->offermsg.offer.sub_channel_index;
 		__entry->msg_type =3D msg->hdr.msg_type;
 	),
diff --git a/drivers/net/wireless/ath/ath10k/trace.h b/drivers/net/wireless=
/ath/ath10k/trace.h
index 64e7a767d963..68b78ca17eaa 100644
--- a/drivers/net/wireless/ath/ath10k/trace.h
+++ b/drivers/net/wireless/ath/ath10k/trace.h
@@ -55,8 +55,8 @@ DECLARE_EVENT_CLASS(ath10k_log_event,
 		__vstring(msg, vaf->fmt, vaf->va)
 	),
 	TP_fast_assign(
-		__assign_str(device, dev_name(ar->dev));
-		__assign_str(driver, dev_driver_string(ar->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__assign_vstr(msg, vaf->fmt, vaf->va);
 	),
 	TP_printk(
@@ -92,8 +92,8 @@ TRACE_EVENT(ath10k_log_dbg,
 		__vstring(msg, vaf->fmt, vaf->va)
 	),
 	TP_fast_assign(
-		__assign_str(device, dev_name(ar->dev));
-		__assign_str(driver, dev_driver_string(ar->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->level =3D level;
 		__assign_vstr(msg, vaf->fmt, vaf->va);
 	),
@@ -121,10 +121,10 @@ TRACE_EVENT(ath10k_log_dbg_dump,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ar->dev));
-		__assign_str(driver, dev_driver_string(ar->dev));
-		__assign_str(msg, msg);
-		__assign_str(prefix, prefix);
+		__assign_str(device);
+		__assign_str(driver);
+		__assign_str(msg);
+		__assign_str(prefix);
 		__entry->buf_len =3D buf_len;
 		memcpy(__get_dynamic_array(buf), buf, buf_len);
 	),
@@ -152,8 +152,8 @@ TRACE_EVENT(ath10k_wmi_cmd,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ar->dev));
-		__assign_str(driver, dev_driver_string(ar->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->id =3D id;
 		__entry->buf_len =3D buf_len;
 		memcpy(__get_dynamic_array(buf), buf, buf_len);
@@ -182,8 +182,8 @@ TRACE_EVENT(ath10k_wmi_event,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ar->dev));
-		__assign_str(driver, dev_driver_string(ar->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->id =3D id;
 		__entry->buf_len =3D buf_len;
 		memcpy(__get_dynamic_array(buf), buf, buf_len);
@@ -211,8 +211,8 @@ TRACE_EVENT(ath10k_htt_stats,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ar->dev));
-		__assign_str(driver, dev_driver_string(ar->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->buf_len =3D buf_len;
 		memcpy(__get_dynamic_array(buf), buf, buf_len);
 	),
@@ -239,8 +239,8 @@ TRACE_EVENT(ath10k_wmi_dbglog,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ar->dev));
-		__assign_str(driver, dev_driver_string(ar->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->hw_type =3D ar->hw_rev;
 		__entry->buf_len =3D buf_len;
 		memcpy(__get_dynamic_array(buf), buf, buf_len);
@@ -269,8 +269,8 @@ TRACE_EVENT(ath10k_htt_pktlog,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ar->dev));
-		__assign_str(driver, dev_driver_string(ar->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->hw_type =3D ar->hw_rev;
 		__entry->buf_len =3D buf_len;
 		memcpy(__get_dynamic_array(pktlog), buf, buf_len);
@@ -301,8 +301,8 @@ TRACE_EVENT(ath10k_htt_tx,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ar->dev));
-		__assign_str(driver, dev_driver_string(ar->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->msdu_id =3D msdu_id;
 		__entry->msdu_len =3D msdu_len;
 		__entry->vdev_id =3D vdev_id;
@@ -332,8 +332,8 @@ TRACE_EVENT(ath10k_txrx_tx_unref,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ar->dev));
-		__assign_str(driver, dev_driver_string(ar->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->msdu_id =3D msdu_id;
 	),
=20
@@ -358,8 +358,8 @@ DECLARE_EVENT_CLASS(ath10k_hdr_event,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ar->dev));
-		__assign_str(driver, dev_driver_string(ar->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->len =3D ath10k_frm_hdr_len(data, len);
 		memcpy(__get_dynamic_array(data), data, __entry->len);
 	),
@@ -386,8 +386,8 @@ DECLARE_EVENT_CLASS(ath10k_payload_event,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ar->dev));
-		__assign_str(driver, dev_driver_string(ar->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->len =3D len - ath10k_frm_hdr_len(data, len);
 		memcpy(__get_dynamic_array(payload),
 		       data + ath10k_frm_hdr_len(data, len), __entry->len);
@@ -435,8 +435,8 @@ TRACE_EVENT(ath10k_htt_rx_desc,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ar->dev));
-		__assign_str(driver, dev_driver_string(ar->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->hw_type =3D ar->hw_rev;
 		__entry->len =3D len;
 		memcpy(__get_dynamic_array(rxdesc), data, len);
@@ -472,8 +472,8 @@ TRACE_EVENT(ath10k_wmi_diag_container,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ar->dev));
-		__assign_str(driver, dev_driver_string(ar->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->type =3D type;
 		__entry->timestamp =3D timestamp;
 		__entry->code =3D code;
@@ -505,8 +505,8 @@ TRACE_EVENT(ath10k_wmi_diag,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ar->dev));
-		__assign_str(driver, dev_driver_string(ar->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->len =3D len;
 		memcpy(__get_dynamic_array(data), data, len);
 	),
diff --git a/drivers/net/wireless/ath/ath11k/trace.h b/drivers/net/wireless=
/ath/ath11k/trace.h
index 235ab8ea715f..75246b0a82e3 100644
--- a/drivers/net/wireless/ath/ath11k/trace.h
+++ b/drivers/net/wireless/ath/ath11k/trace.h
@@ -48,8 +48,8 @@ TRACE_EVENT(ath11k_htt_pktlog,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ar->ab->dev));
-		__assign_str(driver, dev_driver_string(ar->ab->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->buf_len =3D buf_len;
 		__entry->pktlog_checksum =3D pktlog_checksum;
 		memcpy(__get_dynamic_array(pktlog), buf, buf_len);
@@ -77,8 +77,8 @@ TRACE_EVENT(ath11k_htt_ppdu_stats,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ar->ab->dev));
-		__assign_str(driver, dev_driver_string(ar->ab->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->len =3D len;
 		memcpy(__get_dynamic_array(ppdu), data, len);
 	),
@@ -105,8 +105,8 @@ TRACE_EVENT(ath11k_htt_rxdesc,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ar->ab->dev));
-		__assign_str(driver, dev_driver_string(ar->ab->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->len =3D len;
 		__entry->log_type =3D log_type;
 		memcpy(__get_dynamic_array(rxdesc), data, len);
@@ -130,8 +130,8 @@ DECLARE_EVENT_CLASS(ath11k_log_event,
 		__vstring(msg, vaf->fmt, vaf->va)
 	),
 	TP_fast_assign(
-		__assign_str(device, dev_name(ab->dev));
-		__assign_str(driver, dev_driver_string(ab->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__assign_vstr(msg, vaf->fmt, vaf->va);
 	),
 	TP_printk(
@@ -171,8 +171,8 @@ TRACE_EVENT(ath11k_wmi_cmd,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ab->dev));
-		__assign_str(driver, dev_driver_string(ab->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->id =3D id;
 		__entry->buf_len =3D buf_len;
 		memcpy(__get_dynamic_array(buf), buf, buf_len);
@@ -201,8 +201,8 @@ TRACE_EVENT(ath11k_wmi_event,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ab->dev));
-		__assign_str(driver, dev_driver_string(ab->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->id =3D id;
 		__entry->buf_len =3D buf_len;
 		memcpy(__get_dynamic_array(buf), buf, buf_len);
@@ -230,8 +230,8 @@ TRACE_EVENT(ath11k_log_dbg,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ab->dev));
-		__assign_str(driver, dev_driver_string(ab->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->level =3D level;
 		WARN_ON_ONCE(vsnprintf(__get_dynamic_array(msg),
 				       ATH11K_MSG_MAX, vaf->fmt,
@@ -262,10 +262,10 @@ TRACE_EVENT(ath11k_log_dbg_dump,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ab->dev));
-		__assign_str(driver, dev_driver_string(ab->dev));
-		__assign_str(msg, msg);
-		__assign_str(prefix, prefix);
+		__assign_str(device);
+		__assign_str(driver);
+		__assign_str(msg);
+		__assign_str(prefix);
 		__entry->buf_len =3D buf_len;
 		memcpy(__get_dynamic_array(buf), buf, buf_len);
 	),
@@ -292,8 +292,8 @@ TRACE_EVENT(ath11k_wmi_diag,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ab->dev));
-		__assign_str(driver, dev_driver_string(ab->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->len =3D len;
 		memcpy(__get_dynamic_array(data), data, len);
 	),
@@ -318,8 +318,8 @@ TRACE_EVENT(ath11k_ps_timekeeper,
 			 __field(u32, peer_ps_timestamp)
 	),
=20
-	TP_fast_assign(__assign_str(device, dev_name(ar->ab->dev));
-		       __assign_str(driver, dev_driver_string(ar->ab->dev));
+	TP_fast_assign(__assign_str(device);
+		       __assign_str(driver);
 		       memcpy(__get_dynamic_array(peer_addr), peer_addr,
 			      ETH_ALEN);
 		       __entry->peer_ps_state =3D peer_ps_state;
diff --git a/drivers/net/wireless/ath/ath12k/trace.h b/drivers/net/wireless=
/ath/ath12k/trace.h
index 240737e1542d..253c67accb0e 100644
--- a/drivers/net/wireless/ath/ath12k/trace.h
+++ b/drivers/net/wireless/ath/ath12k/trace.h
@@ -36,8 +36,8 @@ TRACE_EVENT(ath12k_htt_pktlog,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ar->ab->dev));
-		__assign_str(driver, dev_driver_string(ar->ab->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->buf_len =3D buf_len;
 		__entry->pktlog_checksum =3D pktlog_checksum;
 		memcpy(__get_dynamic_array(pktlog), buf, buf_len);
@@ -73,8 +73,8 @@ TRACE_EVENT(ath12k_htt_ppdu_stats,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ar->ab->dev));
-		__assign_str(driver, dev_driver_string(ar->ab->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->len =3D len;
 		__entry->info =3D ar->pdev->timestamp.info;
 		__entry->sync_tstmp_lo_us =3D ar->pdev->timestamp.sync_timestamp_hi_us;
@@ -117,8 +117,8 @@ TRACE_EVENT(ath12k_htt_rxdesc,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ar->ab->dev));
-		__assign_str(driver, dev_driver_string(ar->ab->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->len =3D len;
 		__entry->type =3D type;
 		__entry->info =3D ar->pdev->timestamp.info;
@@ -153,8 +153,8 @@ TRACE_EVENT(ath12k_wmi_diag,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(ab->dev));
-		__assign_str(driver, dev_driver_string(ab->dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->len =3D len;
 		memcpy(__get_dynamic_array(data), data, len);
 	),
diff --git a/drivers/net/wireless/ath/ath6kl/trace.h b/drivers/net/wireless=
/ath/ath6kl/trace.h
index 231a94769ddb..8577aa459c58 100644
--- a/drivers/net/wireless/ath/ath6kl/trace.h
+++ b/drivers/net/wireless/ath/ath6kl/trace.h
@@ -304,8 +304,8 @@ TRACE_EVENT(ath6kl_log_dbg_dump,
 	),
=20
 	TP_fast_assign(
-		__assign_str(msg, msg);
-		__assign_str(prefix, prefix);
+		__assign_str(msg);
+		__assign_str(prefix);
 		__entry->buf_len =3D buf_len;
 		memcpy(__get_dynamic_array(buf), buf, buf_len);
 	),
diff --git a/drivers/net/wireless/ath/trace.h b/drivers/net/wireless/ath/tr=
ace.h
index 9935cf475b6d..82aac0a4baff 100644
--- a/drivers/net/wireless/ath/trace.h
+++ b/drivers/net/wireless/ath/trace.h
@@ -44,8 +44,8 @@ TRACE_EVENT(ath_log,
 	    ),
=20
 	    TP_fast_assign(
-		    __assign_str(device, wiphy_name(wiphy));
-		    __assign_str(driver, KBUILD_MODNAME);
+		    __assign_str(device);
+		    __assign_str(driver);
 		    __assign_vstr(msg, vaf->fmt, vaf->va);
 	    ),
=20
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/tracepoint.h =
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/tracepoint.h
index 5d66e94c806d..96032322b165 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/tracepoint.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/tracepoint.h
@@ -41,7 +41,7 @@ TRACE_EVENT(brcmf_err,
 		__vstring(msg, vaf->fmt, vaf->va)
 	),
 	TP_fast_assign(
-		__assign_str(func, func);
+		__assign_str(func);
 		__assign_vstr(msg, vaf->fmt, vaf->va);
 	),
 	TP_printk("%s: %s", __get_str(func), __get_str(msg))
@@ -57,7 +57,7 @@ TRACE_EVENT(brcmf_dbg,
 	),
 	TP_fast_assign(
 		__entry->level =3D level;
-		__assign_str(func, func);
+		__assign_str(func);
 		__assign_vstr(msg, vaf->fmt, vaf->va);
 	),
 	TP_printk("%s: %s", __get_str(func), __get_str(msg))
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_b=
rcmsmac.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_br=
cmsmac.h
index a0da3248b942..53b3dba50737 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac=
h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac=
h
@@ -81,7 +81,7 @@ TRACE_EVENT(brcms_macintstatus,
 		__field(u32, mask)
 	),
 	TP_fast_assign(
-		__assign_str(dev, dev_name(dev));
+		__assign_str(dev);
 		__entry->in_isr =3D in_isr;
 		__entry->macintstatus =3D macintstatus;
 		__entry->mask =3D mask;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_b=
rcmsmac_msg.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trac=
e_brcmsmac_msg.h
index 42b0a91656c4..908ce3c864fe 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac=
_msg.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac=
_msg.h
@@ -71,7 +71,7 @@ TRACE_EVENT(brcms_dbg,
 	),
 	TP_fast_assign(
 		__entry->level =3D level;
-		__assign_str(func, func);
+		__assign_str(func);
 		__assign_vstr(msg, vaf->fmt, vaf->va);
 	),
 	TP_printk("%s: %s", __get_str(func), __get_str(msg))
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_b=
rcmsmac_tx.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace=
_brcmsmac_tx.h
index cf2cc070f1e5..24ac34fa0207 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac=
_tx.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac=
_tx.h
@@ -31,7 +31,7 @@ TRACE_EVENT(brcms_txdesc,
 		__dynamic_array(u8, txh, txh_len)
 	),
 	TP_fast_assign(
-		__assign_str(dev, dev_name(dev));
+		__assign_str(dev);
 		memcpy(__get_dynamic_array(txh), txh, txh_len);
 	),
 	TP_printk("[%s] txdesc", __get_str(dev))
@@ -54,7 +54,7 @@ TRACE_EVENT(brcms_txstatus,
 		__field(u16, ackphyrxsh)
 	),
 	TP_fast_assign(
-		__assign_str(dev, dev_name(dev));
+		__assign_str(dev);
 		__entry->framelen =3D framelen;
 		__entry->frameid =3D frameid;
 		__entry->status =3D status;
@@ -85,7 +85,7 @@ TRACE_EVENT(brcms_ampdu_session,
 		__field(u16, dma_len)
 	),
 	TP_fast_assign(
-		__assign_str(dev, dev_name(dev));
+		__assign_str(dev);
 		__entry->max_ampdu_len =3D max_ampdu_len;
 		__entry->max_ampdu_frames =3D max_ampdu_frames;
 		__entry->ampdu_len =3D ampdu_len;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h b/driver=
s/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h
index 1d6c292cf545..0db1fa5477af 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h
@@ -57,7 +57,7 @@ TRACE_EVENT(iwlwifi_dbg,
 	),
 	TP_fast_assign(
 		__entry->level =3D level;
-		__assign_str(function, function);
+		__assign_str(function);
 		__assign_vstr(msg, vaf->fmt, vaf->va);
 	),
 	TP_printk("%s", __get_str(msg))
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h b/drivers/ne=
t/wireless/intel/iwlwifi/iwl-devtrace.h
index c3e09f4fefeb..76166e1b10e5 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h
@@ -87,7 +87,7 @@ static inline void trace_ ## name(proto) {}
 #endif
=20
 #define DEV_ENTRY	__string(dev, dev_name(dev))
-#define DEV_ASSIGN	__assign_str(dev, dev_name(dev))
+#define DEV_ASSIGN	__assign_str(dev)
=20
 #include "iwl-devtrace-io.h"
 #include "iwl-devtrace-ucode.h"
diff --git a/drivers/soc/qcom/pmic_pdcharger_ulog.h b/drivers/soc/qcom/pmic=
_pdcharger_ulog.h
index 152e3a6b5480..1cfa58f0e34c 100644
--- a/drivers/soc/qcom/pmic_pdcharger_ulog.h
+++ b/drivers/soc/qcom/pmic_pdcharger_ulog.h
@@ -18,7 +18,7 @@ TRACE_EVENT(pmic_pdcharger_ulog_msg,
 		__string(msg, msg)
 	),
 	TP_fast_assign(
-		__assign_str(msg, msg);
+		__assign_str(msg);
 	),
 	TP_printk("%s", __get_str(msg))
 );
diff --git a/drivers/soc/qcom/trace-aoss.h b/drivers/soc/qcom/trace-aoss.h
index 554029b33b44..fb5b0470c40d 100644
--- a/drivers/soc/qcom/trace-aoss.h
+++ b/drivers/soc/qcom/trace-aoss.h
@@ -18,7 +18,7 @@ TRACE_EVENT(aoss_send,
 		__string(msg, msg)
 	),
 	TP_fast_assign(
-		__assign_str(msg, msg);
+		__assign_str(msg);
 	),
 	TP_printk("%s", __get_str(msg))
 );
@@ -31,7 +31,7 @@ TRACE_EVENT(aoss_send_done,
 		__field(int, ret)
 	),
 	TP_fast_assign(
-		__assign_str(msg, msg);
+		__assign_str(msg);
 		__entry->ret =3D ret;
 	),
 	TP_printk("%s: %d", __get_str(msg), __entry->ret)
diff --git a/drivers/soc/qcom/trace-rpmh.h b/drivers/soc/qcom/trace-rpmh.h
index be6b42ecc1f8..593ec1d4e010 100644
--- a/drivers/soc/qcom/trace-rpmh.h
+++ b/drivers/soc/qcom/trace-rpmh.h
@@ -26,7 +26,7 @@ TRACE_EVENT(rpmh_tx_done,
 	),
=20
 	TP_fast_assign(
-		       __assign_str(name, d->name);
+		       __assign_str(name);
 		       __entry->m =3D m;
 		       __entry->addr =3D r->cmds[0].addr;
 		       __entry->data =3D r->cmds[0].data;
@@ -55,7 +55,7 @@ TRACE_EVENT(rpmh_send_msg,
 	),
=20
 	TP_fast_assign(
-		       __assign_str(name, d->name);
+		       __assign_str(name);
 		       __entry->m =3D m;
 		       __entry->state =3D state;
 		       __entry->n =3D n;
diff --git a/drivers/thermal/thermal_trace.h b/drivers/thermal/thermal_trac=
e.h
index 88a962f560f2..df8f4edd6068 100644
--- a/drivers/thermal/thermal_trace.h
+++ b/drivers/thermal/thermal_trace.h
@@ -37,7 +37,7 @@ TRACE_EVENT(thermal_temperature,
 	),
=20
 	TP_fast_assign(
-		__assign_str(thermal_zone, tz->type);
+		__assign_str(thermal_zone);
 		__entry->id =3D tz->id;
 		__entry->temp_prev =3D tz->last_temperature;
 		__entry->temp =3D tz->temperature;
@@ -60,7 +60,7 @@ TRACE_EVENT(cdev_update,
 	),
=20
 	TP_fast_assign(
-		__assign_str(type, cdev->type);
+		__assign_str(type);
 		__entry->target =3D target;
 	),
=20
@@ -82,7 +82,7 @@ TRACE_EVENT(thermal_zone_trip,
 	),
=20
 	TP_fast_assign(
-		__assign_str(thermal_zone, tz->type);
+		__assign_str(thermal_zone);
 		__entry->id =3D tz->id;
 		__entry->trip =3D trip;
 		__entry->trip_type =3D trip_type;
@@ -156,7 +156,7 @@ TRACE_EVENT(thermal_power_devfreq_get_power,
 	),
=20
 	TP_fast_assign(
-		__assign_str(type, cdev->type);
+		__assign_str(type);
 		__entry->freq =3D freq;
 		__entry->busy_time =3D status->busy_time;
 		__entry->total_time =3D status->total_time;
@@ -184,7 +184,7 @@ TRACE_EVENT(thermal_power_devfreq_limit,
 	),
=20
 	TP_fast_assign(
-		__assign_str(type, cdev->type);
+		__assign_str(type);
 		__entry->freq =3D freq;
 		__entry->cdev_state =3D cdev_state;
 		__entry->power =3D power;
diff --git a/drivers/usb/cdns3/cdns3-trace.h b/drivers/usb/cdns3/cdns3-trac=
e.h
index 40db89e3333c..c4e542f1b9b7 100644
--- a/drivers/usb/cdns3/cdns3-trace.h
+++ b/drivers/usb/cdns3/cdns3-trace.h
@@ -33,7 +33,7 @@ TRACE_EVENT(cdns3_halt,
 		__field(u8, flush)
 	),
 	TP_fast_assign(
-		__assign_str(name, ep_priv->name);
+		__assign_str(name);
 		__entry->halt =3D halt;
 		__entry->flush =3D flush;
 	),
@@ -49,8 +49,8 @@ TRACE_EVENT(cdns3_wa1,
 		__string(msg, msg)
 	),
 	TP_fast_assign(
-		__assign_str(ep_name, ep_priv->name);
-		__assign_str(msg, msg);
+		__assign_str(ep_name);
+		__assign_str(msg);
 	),
 	TP_printk("WA1: %s %s", __get_str(ep_name), __get_str(msg))
 );
@@ -63,8 +63,8 @@ TRACE_EVENT(cdns3_wa2,
 		__string(msg, msg)
 	),
 	TP_fast_assign(
-		__assign_str(ep_name, ep_priv->name);
-		__assign_str(msg, msg);
+		__assign_str(ep_name);
+		__assign_str(msg);
 	),
 	TP_printk("WA2: %s %s", __get_str(ep_name), __get_str(msg))
 );
@@ -77,7 +77,7 @@ DECLARE_EVENT_CLASS(cdns3_log_doorbell,
 		__field(u32, ep_trbaddr)
 	),
 	TP_fast_assign(
-		__assign_str(name, ep_name);
+		__assign_str(name);
 		__entry->ep_trbaddr =3D ep_trbaddr;
 	),
 	TP_printk("%s, ep_trbaddr %08x", __get_str(name),
@@ -125,7 +125,7 @@ DECLARE_EVENT_CLASS(cdns3_log_epx_irq,
 		__field(u32, use_streams)
 	),
 	TP_fast_assign(
-		__assign_str(ep_name, priv_ep->name);
+		__assign_str(ep_name);
 		__entry->ep_sts =3D readl(&priv_dev->regs->ep_sts);
 		__entry->ep_traddr =3D readl(&priv_dev->regs->ep_traddr);
 		__entry->ep_last_sid =3D priv_ep->last_stream_id;
@@ -214,7 +214,7 @@ DECLARE_EVENT_CLASS(cdns3_log_request,
 		__field(unsigned int, stream_id)
 	),
 	TP_fast_assign(
-		__assign_str(name, req->priv_ep->name);
+		__assign_str(name);
 		__entry->req =3D req;
 		__entry->buf =3D req->request.buf;
 		__entry->actual =3D req->request.actual;
@@ -294,7 +294,7 @@ DECLARE_EVENT_CLASS(cdns3_stream_split_transfer_len,
 		__field(unsigned int, stream_id)
 	),
 	TP_fast_assign(
-		__assign_str(name, req->priv_ep->name);
+		__assign_str(name);
 		__entry->req =3D req;
 		__entry->actual =3D req->request.length;
 		__entry->length =3D req->request.actual;
@@ -329,7 +329,7 @@ DECLARE_EVENT_CLASS(cdns3_log_aligned_request,
 		__field(u32, aligned_buf_size)
 	),
 	TP_fast_assign(
-		__assign_str(name, priv_req->priv_ep->name);
+		__assign_str(name);
 		__entry->req =3D &priv_req->request;
 		__entry->buf =3D priv_req->request.buf;
 		__entry->dma =3D priv_req->request.dma;
@@ -364,7 +364,7 @@ DECLARE_EVENT_CLASS(cdns3_log_map_request,
 		__field(dma_addr_t, dma)
 	),
 	TP_fast_assign(
-		__assign_str(name, priv_req->priv_ep->name);
+		__assign_str(name);
 		__entry->req =3D &priv_req->request;
 		__entry->buf =3D priv_req->request.buf;
 		__entry->dma =3D priv_req->request.dma;
@@ -395,7 +395,7 @@ DECLARE_EVENT_CLASS(cdns3_log_trb,
 		__field(unsigned int, last_stream_id)
 	),
 	TP_fast_assign(
-		__assign_str(name, priv_ep->name);
+		__assign_str(name);
 		__entry->trb =3D trb;
 		__entry->buffer =3D le32_to_cpu(trb->buffer);
 		__entry->length =3D le32_to_cpu(trb->length);
@@ -467,7 +467,7 @@ DECLARE_EVENT_CLASS(cdns3_log_ep,
 		__field(u8, dequeue)
 	),
 	TP_fast_assign(
-		__assign_str(name, priv_ep->name);
+		__assign_str(name);
 		__entry->maxpacket =3D priv_ep->endpoint.maxpacket;
 		__entry->maxpacket_limit =3D priv_ep->endpoint.maxpacket_limit;
 		__entry->max_streams =3D priv_ep->endpoint.max_streams;
diff --git a/drivers/usb/cdns3/cdnsp-trace.h b/drivers/usb/cdns3/cdnsp-trac=
e.h
index 4b51011eb00b..f2bcf77a5d0a 100644
--- a/drivers/usb/cdns3/cdnsp-trace.h
+++ b/drivers/usb/cdns3/cdnsp-trace.h
@@ -48,7 +48,7 @@ DECLARE_EVENT_CLASS(cdnsp_log_ep,
 		__field(u8, drbls_count)
 	),
 	TP_fast_assign(
-		__assign_str(name, pep->name);
+		__assign_str(name);
 		__entry->state =3D pep->ep_state;
 		__entry->stream_id =3D stream_id;
 		__entry->enabled =3D pep->ep_state & EP_HAS_STREAMS;
@@ -138,7 +138,7 @@ DECLARE_EVENT_CLASS(cdnsp_log_simple,
 		__string(text, msg)
 	),
 	TP_fast_assign(
-		__assign_str(text, msg);
+		__assign_str(text);
 	),
 	TP_printk("%s", __get_str(text))
 );
@@ -303,7 +303,7 @@ DECLARE_EVENT_CLASS(cdnsp_log_bounce,
 		__field(unsigned int, unalign)
 	),
 	TP_fast_assign(
-		__assign_str(name, preq->pep->name);
+		__assign_str(name);
 		__entry->new_buf_len =3D new_buf_len;
 		__entry->offset =3D offset;
 		__entry->dma =3D dma;
@@ -470,7 +470,7 @@ DECLARE_EVENT_CLASS(cdnsp_log_request,
=20
 	),
 	TP_fast_assign(
-		__assign_str(name, req->pep->name);
+		__assign_str(name);
 		__entry->request =3D &req->request;
 		__entry->preq =3D req;
 		__entry->buf =3D req->request.buf;
@@ -674,7 +674,7 @@ DECLARE_EVENT_CLASS(cdnsp_log_td_info,
 		__field(dma_addr_t, trb_dma)
 	),
 	TP_fast_assign(
-		__assign_str(name, preq->pep->name);
+		__assign_str(name);
 		__entry->request =3D &preq->request;
 		__entry->preq =3D preq;
 		__entry->first_trb =3D preq->td.first_trb;
diff --git a/drivers/usb/chipidea/trace.h b/drivers/usb/chipidea/trace.h
index ca0e65b48f0a..1875419cd17f 100644
--- a/drivers/usb/chipidea/trace.h
+++ b/drivers/usb/chipidea/trace.h
@@ -31,7 +31,7 @@ TRACE_EVENT(ci_log,
 		__vstring(msg, vaf->fmt, vaf->va)
 	),
 	TP_fast_assign(
-		__assign_str(name, dev_name(ci->dev));
+		__assign_str(name);
 		__assign_vstr(msg, vaf->fmt, vaf->va);
 	),
 	TP_printk("%s: %s", __get_str(name), __get_str(msg))
@@ -51,7 +51,7 @@ DECLARE_EVENT_CLASS(ci_log_trb,
 		__field(u32, type)
 	),
 	TP_fast_assign(
-		__assign_str(name, hwep->name);
+		__assign_str(name);
 		__entry->req =3D &hwreq->req;
 		__entry->td =3D td;
 		__entry->dma =3D td->dma;
diff --git a/drivers/usb/dwc3/trace.h b/drivers/usb/dwc3/trace.h
index d2997d17cfbe..bdeb1aaf65d8 100644
--- a/drivers/usb/dwc3/trace.h
+++ b/drivers/usb/dwc3/trace.h
@@ -112,7 +112,7 @@ DECLARE_EVENT_CLASS(dwc3_log_request,
 		__field(int, no_interrupt)
 	),
 	TP_fast_assign(
-		__assign_str(name, req->dep->name);
+		__assign_str(name);
 		__entry->req =3D req;
 		__entry->actual =3D req->request.actual;
 		__entry->length =3D req->request.length;
@@ -193,7 +193,7 @@ DECLARE_EVENT_CLASS(dwc3_log_gadget_ep_cmd,
 		__field(int, cmd_status)
 	),
 	TP_fast_assign(
-		__assign_str(name, dep->name);
+		__assign_str(name);
 		__entry->cmd =3D cmd;
 		__entry->param0 =3D params->param0;
 		__entry->param1 =3D params->param1;
@@ -229,7 +229,7 @@ DECLARE_EVENT_CLASS(dwc3_log_trb,
 		__field(u32, dequeue)
 	),
 	TP_fast_assign(
-		__assign_str(name, dep->name);
+		__assign_str(name);
 		__entry->trb =3D trb;
 		__entry->bpl =3D trb->bpl;
 		__entry->bph =3D trb->bph;
@@ -301,7 +301,7 @@ DECLARE_EVENT_CLASS(dwc3_log_ep,
 		__field(u8, trb_dequeue)
 	),
 	TP_fast_assign(
-		__assign_str(name, dep->name);
+		__assign_str(name);
 		__entry->maxpacket =3D dep->endpoint.maxpacket;
 		__entry->maxpacket_limit =3D dep->endpoint.maxpacket_limit;
 		__entry->max_streams =3D dep->endpoint.max_streams;
diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-trace.h b/drivers/usb/gadge=
t/udc/cdns2/cdns2-trace.h
index 61f241634ea5..ade1752956b1 100644
--- a/drivers/usb/gadget/udc/cdns2/cdns2-trace.h
+++ b/drivers/usb/gadget/udc/cdns2/cdns2-trace.h
@@ -64,7 +64,7 @@ DECLARE_EVENT_CLASS(cdns2_log_simple,
 		__string(text, msg)
 	),
 	TP_fast_assign(
-		__assign_str(text, msg);
+		__assign_str(text);
 	),
 	TP_printk("%s", __get_str(text))
 );
@@ -103,7 +103,7 @@ TRACE_EVENT(cdns2_ep_halt,
 		__field(u8, flush)
 	),
 	TP_fast_assign(
-		__assign_str(name, ep_priv->name);
+		__assign_str(name);
 		__entry->halt =3D halt;
 		__entry->flush =3D flush;
 	),
@@ -119,8 +119,8 @@ TRACE_EVENT(cdns2_wa1,
 		__string(msg, msg)
 	),
 	TP_fast_assign(
-		__assign_str(ep_name, ep_priv->name);
-		__assign_str(msg, msg);
+		__assign_str(ep_name);
+		__assign_str(msg);
 	),
 	TP_printk("WA1: %s %s", __get_str(ep_name), __get_str(msg))
 );
@@ -134,7 +134,7 @@ DECLARE_EVENT_CLASS(cdns2_log_doorbell,
 		__field(u32, ep_trbaddr)
 	),
 	TP_fast_assign(
-		__assign_str(name, pep->name);
+		__assign_str(name);
 		__entry->ep_trbaddr =3D ep_trbaddr;
 	),
 	TP_printk("%s, ep_trbaddr %08x", __get_str(name),
@@ -196,7 +196,7 @@ DECLARE_EVENT_CLASS(cdns2_log_epx_irq,
 		__field(u32, ep_traddr)
 	),
 	TP_fast_assign(
-		__assign_str(ep_name, pep->name);
+		__assign_str(ep_name);
 		__entry->ep_sts =3D readl(&pdev->adma_regs->ep_sts);
 		__entry->ep_ists =3D readl(&pdev->adma_regs->ep_ists);
 		__entry->ep_traddr =3D readl(&pdev->adma_regs->ep_traddr);
@@ -288,7 +288,7 @@ DECLARE_EVENT_CLASS(cdns2_log_request,
 		__field(int, end_trb)
 	),
 	TP_fast_assign(
-		__assign_str(name, preq->pep->name);
+		__assign_str(name);
 		__entry->request =3D &preq->request;
 		__entry->preq =3D preq;
 		__entry->buf =3D preq->request.buf;
@@ -380,7 +380,7 @@ DECLARE_EVENT_CLASS(cdns2_log_map_request,
 		__field(dma_addr_t, dma)
 	),
 	TP_fast_assign(
-		__assign_str(name, priv_req->pep->name);
+		__assign_str(name);
 		__entry->req =3D &priv_req->request;
 		__entry->buf =3D priv_req->request.buf;
 		__entry->dma =3D priv_req->request.dma;
@@ -411,7 +411,7 @@ DECLARE_EVENT_CLASS(cdns2_log_trb,
 		__field(u32, type)
 	),
 	TP_fast_assign(
-		__assign_str(name, pep->name);
+		__assign_str(name);
 		__entry->trb =3D trb;
 		__entry->buffer =3D le32_to_cpu(trb->buffer);
 		__entry->length =3D le32_to_cpu(trb->length);
@@ -476,7 +476,7 @@ DECLARE_EVENT_CLASS(cdns2_log_ep,
 		__field(u8, dequeue)
 	),
 	TP_fast_assign(
-		__assign_str(name, pep->name);
+		__assign_str(name);
 		__entry->maxpacket =3D pep->endpoint.maxpacket;
 		__entry->maxpacket_limit =3D pep->endpoint.maxpacket_limit;
 		__entry->flags =3D pep->ep_state;
@@ -568,7 +568,7 @@ DECLARE_EVENT_CLASS(cdns2_log_epx_reg_config,
 		__field(u32, ep_cfg_reg)
 	),
 	TP_fast_assign(
-		__assign_str(ep_name, pep->name);
+		__assign_str(ep_name);
 		__entry->burst_size =3D pep->trb_burst_size;
 		__entry->maxpack_reg =3D pep->dir ? readw(&pdev->epx_regs->txmaxpack[pep=
->num - 1]) :
 						  readw(&pdev->epx_regs->rxmaxpack[pep->num - 1]);
diff --git a/drivers/usb/gadget/udc/trace.h b/drivers/usb/gadget/udc/trace.h
index a5ed26fbc2da..4e334298b0e8 100644
--- a/drivers/usb/gadget/udc/trace.h
+++ b/drivers/usb/gadget/udc/trace.h
@@ -157,7 +157,7 @@ DECLARE_EVENT_CLASS(udc_log_ep,
 		__field(int, ret)
 	),
 	TP_fast_assign(
-		__assign_str(name, ep->name);
+		__assign_str(name);
 		__entry->maxpacket =3D ep->maxpacket;
 		__entry->maxpacket_limit =3D ep->maxpacket_limit;
 		__entry->max_streams =3D ep->max_streams;
@@ -233,7 +233,7 @@ DECLARE_EVENT_CLASS(udc_log_req,
 		__field(struct usb_request *, req)
 	),
 	TP_fast_assign(
-		__assign_str(name, ep->name);
+		__assign_str(name);
 		__entry->length =3D req->length;
 		__entry->actual =3D req->actual;
 		__entry->num_sgs =3D req->num_sgs;
diff --git a/drivers/usb/mtu3/mtu3_trace.h b/drivers/usb/mtu3/mtu3_trace.h
index 03d2a9bac27e..89870175d635 100644
--- a/drivers/usb/mtu3/mtu3_trace.h
+++ b/drivers/usb/mtu3/mtu3_trace.h
@@ -26,7 +26,7 @@ TRACE_EVENT(mtu3_log,
 		__vstring(msg, vaf->fmt, vaf->va)
 	),
 	TP_fast_assign(
-		__assign_str(name, dev_name(dev));
+		__assign_str(name);
 		__assign_vstr(msg, vaf->fmt, vaf->va);
 	),
 	TP_printk("%s: %s", __get_str(name), __get_str(msg))
@@ -127,7 +127,7 @@ DECLARE_EVENT_CLASS(mtu3_log_request,
 		__field(int, no_interrupt)
 	),
 	TP_fast_assign(
-		__assign_str(name, mreq->mep->name);
+		__assign_str(name);
 		__entry->mreq =3D mreq;
 		__entry->gpd =3D mreq->gpd;
 		__entry->actual =3D mreq->request.actual;
@@ -182,7 +182,7 @@ DECLARE_EVENT_CLASS(mtu3_log_gpd,
 		__field(u32, dw3)
 	),
 	TP_fast_assign(
-		__assign_str(name, mep->name);
+		__assign_str(name);
 		__entry->gpd =3D gpd;
 		__entry->dw0 =3D le32_to_cpu(gpd->dw0_info);
 		__entry->dw1 =3D le32_to_cpu(gpd->next_gpd);
@@ -226,7 +226,7 @@ DECLARE_EVENT_CLASS(mtu3_log_ep,
 		__field(struct mtu3_gpd_ring *, gpd_ring)
 	),
 	TP_fast_assign(
-		__assign_str(name, mep->name);
+		__assign_str(name);
 		__entry->type =3D mep->type;
 		__entry->slot =3D mep->slot;
 		__entry->maxp =3D mep->ep.maxpacket;
diff --git a/drivers/usb/musb/musb_trace.h b/drivers/usb/musb/musb_trace.h
index f246b14394c4..726e6697d475 100644
--- a/drivers/usb/musb/musb_trace.h
+++ b/drivers/usb/musb/musb_trace.h
@@ -31,7 +31,7 @@ TRACE_EVENT(musb_log,
 		__vstring(msg, vaf->fmt, vaf->va)
 	),
 	TP_fast_assign(
-		__assign_str(name, dev_name(musb->controller));
+		__assign_str(name);
 		__assign_vstr(msg, vaf->fmt, vaf->va);
 	),
 	TP_printk("%s: %s", __get_str(name), __get_str(msg))
@@ -46,9 +46,9 @@ TRACE_EVENT(musb_state,
 		__string(desc, desc)
 	),
 	TP_fast_assign(
-		__assign_str(name, dev_name(musb->controller));
+		__assign_str(name);
 		__entry->devctl =3D devctl;
-		__assign_str(desc, desc);
+		__assign_str(desc);
 	),
 	TP_printk("%s: devctl: %02x %s", __get_str(name), __entry->devctl,
 		  __get_str(desc))
@@ -160,7 +160,7 @@ TRACE_EVENT(musb_isr,
 		__field(u16, int_rx)
 	),
 	TP_fast_assign(
-		__assign_str(name, dev_name(musb->controller));
+		__assign_str(name);
 		__entry->int_usb =3D musb->int_usb;
 		__entry->int_tx =3D musb->int_tx;
 		__entry->int_rx =3D musb->int_rx;
@@ -184,7 +184,7 @@ DECLARE_EVENT_CLASS(musb_urb,
 		__field(u32, actual_len)
 	),
 	TP_fast_assign(
-		__assign_str(name, dev_name(musb->controller));
+		__assign_str(name);
 		__entry->urb =3D urb;
 		__entry->pipe =3D urb->pipe;
 		__entry->status =3D urb->status;
@@ -325,7 +325,7 @@ DECLARE_EVENT_CLASS(musb_cppi41,
 	),
 	TP_fast_assign(
 		__entry->ch =3D ch;
-		__assign_str(name, dev_name(ch->hw_ep->musb->controller));
+		__assign_str(name);
 		__entry->hwep =3D ch->hw_ep->epnum;
 		__entry->port =3D ch->port_num;
 		__entry->is_tx =3D ch->is_tx;
diff --git a/fs/bcachefs/trace.h b/fs/bcachefs/trace.h
index 362e1fc7ef6a..84fcf26e306e 100644
--- a/fs/bcachefs/trace.h
+++ b/fs/bcachefs/trace.h
@@ -43,7 +43,7 @@ DECLARE_EVENT_CLASS(fs_str,
=20
 	TP_fast_assign(
 		__entry->dev		=3D c->dev;
-		__assign_str(str, str);
+		__assign_str(str);
 	),
=20
 	TP_printk("%d,%d\n%s", MAJOR(__entry->dev), MINOR(__entry->dev), __get_st=
r(str))
@@ -64,7 +64,7 @@ DECLARE_EVENT_CLASS(trans_str,
 		__entry->dev		=3D trans->c->dev;
 		strscpy(__entry->trans_fn, trans->fn, sizeof(__entry->trans_fn));
 		__entry->caller_ip		=3D caller_ip;
-		__assign_str(str, str);
+		__assign_str(str);
 	),
=20
 	TP_printk("%d,%d %s %pS %s",
@@ -85,7 +85,7 @@ DECLARE_EVENT_CLASS(trans_str_nocaller,
 	TP_fast_assign(
 		__entry->dev		=3D trans->c->dev;
 		strscpy(__entry->trans_fn, trans->fn, sizeof(__entry->trans_fn));
-		__assign_str(str, str);
+		__assign_str(str);
 	),
=20
 	TP_printk("%d,%d %s %s",
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 10985a4b8259..4de8780a7c48 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -47,7 +47,7 @@ DECLARE_EVENT_CLASS(nfs4_clientid_event,
=20
 		TP_fast_assign(
 			__entry->error =3D error < 0 ? -error : 0;
-			__assign_str(dstaddr, clp->cl_hostname);
+			__assign_str(dstaddr);
 		),
=20
 		TP_printk(
@@ -94,8 +94,8 @@ TRACE_EVENT(nfs4_trunked_exchange_id,
=20
 		TP_fast_assign(
 			__entry->error =3D error < 0 ? -error : 0;
-			__assign_str(main_addr, clp->cl_hostname);
-			__assign_str(trunk_addr, addr);
+			__assign_str(main_addr);
+			__assign_str(trunk_addr);
 		),
=20
 		TP_printk(
@@ -365,7 +365,7 @@ TRACE_EVENT(nfs4_state_mgr,
=20
 		TP_fast_assign(
 			__entry->state =3D clp->cl_state;
-			__assign_str(hostname, clp->cl_hostname);
+			__assign_str(hostname);
 		),
=20
 		TP_printk(
@@ -393,8 +393,8 @@ TRACE_EVENT(nfs4_state_mgr_failed,
 		TP_fast_assign(
 			__entry->error =3D status < 0 ? -status : 0;
 			__entry->state =3D clp->cl_state;
-			__assign_str(hostname, clp->cl_hostname);
-			__assign_str(section, section);
+			__assign_str(hostname);
+			__assign_str(section);
 		),
=20
 		TP_printk(
@@ -578,7 +578,7 @@ DECLARE_EVENT_CLASS(nfs4_open_event,
 				__entry->fhandle =3D 0;
 			}
 			__entry->dir =3D NFS_FILEID(d_inode(ctx->dentry->d_parent));
-			__assign_str(name, ctx->dentry->d_name.name);
+			__assign_str(name);
 		),
=20
 		TP_printk(
@@ -1072,7 +1072,7 @@ DECLARE_EVENT_CLASS(nfs4_lookup_event,
 			__entry->dev =3D dir->i_sb->s_dev;
 			__entry->dir =3D NFS_FILEID(dir);
 			__entry->error =3D -error;
-			__assign_str(name, name->name);
+			__assign_str(name);
 		),
=20
 		TP_printk(
@@ -1156,8 +1156,8 @@ TRACE_EVENT(nfs4_rename,
 			__entry->olddir =3D NFS_FILEID(olddir);
 			__entry->newdir =3D NFS_FILEID(newdir);
 			__entry->error =3D error < 0 ? -error : 0;
-			__assign_str(oldname, oldname->name);
-			__assign_str(newname, newname->name);
+			__assign_str(oldname);
+			__assign_str(newname);
 		),
=20
 		TP_printk(
@@ -1359,7 +1359,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_callback_event,
 				__entry->fileid =3D 0;
 				__entry->dev =3D 0;
 			}
-			__assign_str(dstaddr, clp ? clp->cl_hostname : "unknown");
+			__assign_str(dstaddr);
 		),
=20
 		TP_printk(
@@ -1416,7 +1416,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_stateid_callback_event,
 				__entry->fileid =3D 0;
 				__entry->dev =3D 0;
 			}
-			__assign_str(dstaddr, clp ? clp->cl_hostname : "unknown");
+			__assign_str(dstaddr);
 			__entry->stateid_seq =3D
 				be32_to_cpu(stateid->seqid);
 			__entry->stateid_hash =3D
@@ -1960,7 +1960,7 @@ DECLARE_EVENT_CLASS(nfs4_deviceid_event,
 		),
=20
 		TP_fast_assign(
-			__assign_str(dstaddr, clp->cl_hostname);
+			__assign_str(dstaddr);
 			memcpy(__entry->deviceid, deviceid->data,
 			       NFS4_DEVICEID4_SIZE);
 		),
@@ -1998,7 +1998,7 @@ DECLARE_EVENT_CLASS(nfs4_deviceid_status,
 		TP_fast_assign(
 			__entry->dev =3D server->s_dev;
 			__entry->status =3D status;
-			__assign_str(dstaddr, server->nfs_client->cl_hostname);
+			__assign_str(dstaddr);
 			memcpy(__entry->deviceid, deviceid->data,
 			       NFS4_DEVICEID4_SIZE);
 		),
@@ -2036,8 +2036,8 @@ TRACE_EVENT(fl_getdevinfo,
 		),
=20
 		TP_fast_assign(
-			__assign_str(mds_addr, server->nfs_client->cl_hostname);
-			__assign_str(ds_ips, ds_remotestr);
+			__assign_str(mds_addr);
+			__assign_str(ds_ips);
 			memcpy(__entry->deviceid, deviceid->data,
 			       NFS4_DEVICEID4_SIZE);
 		),
@@ -2083,9 +2083,7 @@ DECLARE_EVENT_CLASS(nfs4_flexfiles_io_event,
 				be32_to_cpu(hdr->args.stateid.seqid);
 			__entry->stateid_hash =3D
 				nfs_stateid_hash(&hdr->args.stateid);
-			__assign_str(dstaddr, hdr->ds_clp ?
-				rpc_peeraddr2str(hdr->ds_clp->cl_rpcclient,
-					RPC_DISPLAY_ADDR) : "unknown");
+			__assign_str(dstaddr);
 		),
=20
 		TP_printk(
@@ -2139,9 +2137,7 @@ TRACE_EVENT(ff_layout_commit_error,
 			__entry->dev =3D inode->i_sb->s_dev;
 			__entry->offset =3D data->args.offset;
 			__entry->count =3D data->args.count;
-			__assign_str(dstaddr, data->ds_clp ?
-				rpc_peeraddr2str(data->ds_clp->cl_rpcclient,
-					RPC_DISPLAY_ADDR) : "unknown");
+			__assign_str(dstaddr);
 		),
=20
 		TP_printk(
@@ -2579,7 +2575,7 @@ DECLARE_EVENT_CLASS(nfs4_xattr_event,
 			__entry->dev =3D inode->i_sb->s_dev;
 			__entry->fileid =3D NFS_FILEID(inode);
 			__entry->fhandle =3D nfs_fhandle_hash(NFS_FH(inode));
-			__assign_str(name, name);
+			__assign_str(name);
 		),
=20
 		TP_printk(
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index afedb449b54f..1e710654af11 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -409,7 +409,7 @@ DECLARE_EVENT_CLASS(nfs_lookup_event,
 			__entry->dir =3D NFS_FILEID(dir);
 			__entry->flags =3D flags;
 			__entry->fileid =3D d_is_negative(dentry) ? 0 : NFS_FILEID(d_inode(dent=
ry));
-			__assign_str(name, dentry->d_name.name);
+			__assign_str(name);
 		),
=20
 		TP_printk(
@@ -457,7 +457,7 @@ DECLARE_EVENT_CLASS(nfs_lookup_event_done,
 			__entry->error =3D error < 0 ? -error : 0;
 			__entry->flags =3D flags;
 			__entry->fileid =3D d_is_negative(dentry) ? 0 : NFS_FILEID(d_inode(dent=
ry));
-			__assign_str(name, dentry->d_name.name);
+			__assign_str(name);
 		),
=20
 		TP_printk(
@@ -512,7 +512,7 @@ TRACE_EVENT(nfs_atomic_open_enter,
 			__entry->dir =3D NFS_FILEID(dir);
 			__entry->flags =3D flags;
 			__entry->fmode =3D (__force unsigned long)ctx->mode;
-			__assign_str(name, ctx->dentry->d_name.name);
+			__assign_str(name);
 		),
=20
 		TP_printk(
@@ -551,7 +551,7 @@ TRACE_EVENT(nfs_atomic_open_exit,
 			__entry->dir =3D NFS_FILEID(dir);
 			__entry->flags =3D flags;
 			__entry->fmode =3D (__force unsigned long)ctx->mode;
-			__assign_str(name, ctx->dentry->d_name.name);
+			__assign_str(name);
 		),
=20
 		TP_printk(
@@ -587,7 +587,7 @@ TRACE_EVENT(nfs_create_enter,
 			__entry->dev =3D dir->i_sb->s_dev;
 			__entry->dir =3D NFS_FILEID(dir);
 			__entry->flags =3D flags;
-			__assign_str(name, dentry->d_name.name);
+			__assign_str(name);
 		),
=20
 		TP_printk(
@@ -623,7 +623,7 @@ TRACE_EVENT(nfs_create_exit,
 			__entry->dev =3D dir->i_sb->s_dev;
 			__entry->dir =3D NFS_FILEID(dir);
 			__entry->flags =3D flags;
-			__assign_str(name, dentry->d_name.name);
+			__assign_str(name);
 		),
=20
 		TP_printk(
@@ -654,7 +654,7 @@ DECLARE_EVENT_CLASS(nfs_directory_event,
 		TP_fast_assign(
 			__entry->dev =3D dir->i_sb->s_dev;
 			__entry->dir =3D NFS_FILEID(dir);
-			__assign_str(name, dentry->d_name.name);
+			__assign_str(name);
 		),
=20
 		TP_printk(
@@ -693,7 +693,7 @@ DECLARE_EVENT_CLASS(nfs_directory_event_done,
 			__entry->dev =3D dir->i_sb->s_dev;
 			__entry->dir =3D NFS_FILEID(dir);
 			__entry->error =3D error < 0 ? -error : 0;
-			__assign_str(name, dentry->d_name.name);
+			__assign_str(name);
 		),
=20
 		TP_printk(
@@ -747,7 +747,7 @@ TRACE_EVENT(nfs_link_enter,
 			__entry->dev =3D inode->i_sb->s_dev;
 			__entry->fileid =3D NFS_FILEID(inode);
 			__entry->dir =3D NFS_FILEID(dir);
-			__assign_str(name, dentry->d_name.name);
+			__assign_str(name);
 		),
=20
 		TP_printk(
@@ -783,7 +783,7 @@ TRACE_EVENT(nfs_link_exit,
 			__entry->fileid =3D NFS_FILEID(inode);
 			__entry->dir =3D NFS_FILEID(dir);
 			__entry->error =3D error < 0 ? -error : 0;
-			__assign_str(name, dentry->d_name.name);
+			__assign_str(name);
 		),
=20
 		TP_printk(
@@ -819,8 +819,8 @@ DECLARE_EVENT_CLASS(nfs_rename_event,
 			__entry->dev =3D old_dir->i_sb->s_dev;
 			__entry->old_dir =3D NFS_FILEID(old_dir);
 			__entry->new_dir =3D NFS_FILEID(new_dir);
-			__assign_str(old_name, old_dentry->d_name.name);
-			__assign_str(new_name, new_dentry->d_name.name);
+			__assign_str(old_name);
+			__assign_str(new_name);
 		),
=20
 		TP_printk(
@@ -868,8 +868,8 @@ DECLARE_EVENT_CLASS(nfs_rename_event_done,
 			__entry->error =3D -error;
 			__entry->old_dir =3D NFS_FILEID(old_dir);
 			__entry->new_dir =3D NFS_FILEID(new_dir);
-			__assign_str(old_name, old_dentry->d_name.name);
-			__assign_str(new_name, new_dentry->d_name.name);
+			__assign_str(old_name);
+			__assign_str(new_name);
 		),
=20
 		TP_printk(
@@ -1636,8 +1636,8 @@ TRACE_EVENT(nfs_mount_assign,
 	),
=20
 	TP_fast_assign(
-		__assign_str(option, option);
-		__assign_str(value, value);
+		__assign_str(option);
+		__assign_str(value);
 	),
=20
 	TP_printk("option %s=3D%s",
@@ -1657,7 +1657,7 @@ TRACE_EVENT(nfs_mount_option,
 	),
=20
 	TP_fast_assign(
-		__assign_str(option, param->key);
+		__assign_str(option);
 	),
=20
 	TP_printk("option %s", __get_str(option))
@@ -1675,7 +1675,7 @@ TRACE_EVENT(nfs_mount_path,
 	),
=20
 	TP_fast_assign(
-		__assign_str(path, path);
+		__assign_str(path);
 	),
=20
 	TP_printk("path=3D'%s'", __get_str(path))
@@ -1710,9 +1710,8 @@ DECLARE_EVENT_CLASS(nfs_xdr_event,
 			__entry->xid =3D be32_to_cpu(rqstp->rq_xid);
 			__entry->version =3D task->tk_client->cl_vers;
 			__entry->error =3D error;
-			__assign_str(program,
-				     task->tk_client->cl_program->name);
-			__assign_str(procedure, task->tk_msg.rpc_proc->p_name);
+			__assign_str(program);
+			__assign_str(procedure);
 		),
=20
 		TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index b5e48d504062..77bbd23aa150 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -104,7 +104,7 @@ TRACE_EVENT(nfsd_compound,
 	TP_fast_assign(
 		__entry->xid =3D be32_to_cpu(rqst->rq_xid);
 		__entry->opcnt =3D opcnt;
-		__assign_str(tag, tag);
+		__assign_str(tag);
 	),
 	TP_printk("xid=3D0x%08x opcnt=3D%u tag=3D%s",
 		__entry->xid, __entry->opcnt, __get_str(tag)
@@ -127,7 +127,7 @@ TRACE_EVENT(nfsd_compound_status,
 		__entry->args_opcnt =3D args_opcnt;
 		__entry->resp_opcnt =3D resp_opcnt;
 		__entry->status =3D be32_to_cpu(status);
-		__assign_str(name, name);
+		__assign_str(name);
 	),
 	TP_printk("op=3D%u/%u %s status=3D%d",
 		__entry->resp_opcnt, __entry->args_opcnt,
@@ -318,7 +318,7 @@ TRACE_EVENT(nfsd_exp_find_key,
 	TP_fast_assign(
 		__entry->fsidtype =3D key->ek_fsidtype;
 		memcpy(__entry->fsid, key->ek_fsid, 4*6);
-		__assign_str(auth_domain, key->ek_client->name);
+		__assign_str(auth_domain);
 		__entry->status =3D status;
 	),
 	TP_printk("fsid=3D%x::%s domain=3D%s status=3D%d",
@@ -342,8 +342,8 @@ TRACE_EVENT(nfsd_expkey_update,
 	TP_fast_assign(
 		__entry->fsidtype =3D key->ek_fsidtype;
 		memcpy(__entry->fsid, key->ek_fsid, 4*6);
-		__assign_str(auth_domain, key->ek_client->name);
-		__assign_str(path, exp_path);
+		__assign_str(auth_domain);
+		__assign_str(path);
 		__entry->cache =3D !test_bit(CACHE_NEGATIVE, &key->h.flags);
 	),
 	TP_printk("fsid=3D%x::%s domain=3D%s path=3D%s cache=3D%s",
@@ -365,8 +365,8 @@ TRACE_EVENT(nfsd_exp_get_by_name,
 		__field(int, status)
 	),
 	TP_fast_assign(
-		__assign_str(path, key->ex_path.dentry->d_name.name);
-		__assign_str(auth_domain, key->ex_client->name);
+		__assign_str(path);
+		__assign_str(auth_domain);
 		__entry->status =3D status;
 	),
 	TP_printk("path=3D%s domain=3D%s status=3D%d",
@@ -385,8 +385,8 @@ TRACE_EVENT(nfsd_export_update,
 		__field(bool, cache)
 	),
 	TP_fast_assign(
-		__assign_str(path, key->ex_path.dentry->d_name.name);
-		__assign_str(auth_domain, key->ex_client->name);
+		__assign_str(path);
+		__assign_str(auth_domain);
 		__entry->cache =3D !test_bit(CACHE_NEGATIVE, &key->h.flags);
 	),
 	TP_printk("path=3D%s domain=3D%s cache=3D%s",
@@ -485,7 +485,7 @@ TRACE_EVENT(nfsd_dirent,
 	TP_fast_assign(
 		__entry->fh_hash =3D fhp ? knfsd_fh_hash(&fhp->fh_handle) : 0;
 		__entry->ino =3D ino;
-		__assign_str(name, name);
+		__assign_str(name);
 	),
 	TP_printk("fh_hash=3D0x%08x ino=3D%llu name=3D%s",
 		__entry->fh_hash, __entry->ino, __get_str(name)
@@ -1000,7 +1000,7 @@ DECLARE_EVENT_CLASS(nfsd_clid_class,
 		__entry->flavor =3D clp->cl_cred.cr_flavor;
 		memcpy(__entry->verifier, (void *)&clp->cl_verifier,
 		       NFS4_VERIFIER_SIZE);
-		__assign_str(name, clp->cl_name.data);
+		__assign_str(name);
 	),
 	TP_printk("addr=3D%pISpc name=3D'%s' verifier=3D0x%s flavor=3D%s client=
=3D%08x:%08x",
 		__entry->addr, __get_str(name),
@@ -1519,7 +1519,7 @@ TRACE_EVENT(nfsd_cb_setup,
 	TP_fast_assign(
 		__entry->cl_boot =3D clp->cl_clientid.cl_boot;
 		__entry->cl_id =3D clp->cl_clientid.cl_id;
-		__assign_str(netid, netid);
+		__assign_str(netid);
 		__entry->authflavor =3D authflavor;
 		__assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
 				  clp->cl_cb_conn.cb_addrlen)
@@ -1864,7 +1864,7 @@ TRACE_EVENT(nfsd_ctl_unlock_ip,
 	),
 	TP_fast_assign(
 		__entry->netns_ino =3D net->ns.inum;
-		__assign_str(address, address);
+		__assign_str(address);
 	),
 	TP_printk("address=3D%s",
 		__get_str(address)
@@ -1883,7 +1883,7 @@ TRACE_EVENT(nfsd_ctl_unlock_fs,
 	),
 	TP_fast_assign(
 		__entry->netns_ino =3D net->ns.inum;
-		__assign_str(path, path);
+		__assign_str(path);
 	),
 	TP_printk("path=3D%s",
 		__get_str(path)
@@ -1907,8 +1907,8 @@ TRACE_EVENT(nfsd_ctl_filehandle,
 	TP_fast_assign(
 		__entry->netns_ino =3D net->ns.inum;
 		__entry->maxsize =3D maxsize;
-		__assign_str(domain, domain);
-		__assign_str(path, path);
+		__assign_str(domain);
+		__assign_str(path);
 	),
 	TP_printk("domain=3D%s path=3D%s maxsize=3D%d",
 		__get_str(domain), __get_str(path), __entry->maxsize
@@ -1968,7 +1968,7 @@ TRACE_EVENT(nfsd_ctl_version,
 	),
 	TP_fast_assign(
 		__entry->netns_ino =3D net->ns.inum;
-		__assign_str(mesg, mesg);
+		__assign_str(mesg);
 	),
 	TP_printk("%s",
 		__get_str(mesg)
@@ -2009,7 +2009,7 @@ TRACE_EVENT(nfsd_ctl_ports_addxprt,
 	TP_fast_assign(
 		__entry->netns_ino =3D net->ns.inum;
 		__entry->port =3D port;
-		__assign_str(transport, transport);
+		__assign_str(transport);
 	),
 	TP_printk("transport=3D%s port=3D%d",
 		__get_str(transport), __entry->port
@@ -2070,7 +2070,7 @@ TRACE_EVENT(nfsd_ctl_time,
 	TP_fast_assign(
 		__entry->netns_ino =3D net->ns.inum;
 		__entry->time =3D time;
-		__assign_str(name, name);
+		__assign_str(name);
 	),
 	TP_printk("file=3D%s time=3D%d",
 		__get_str(name), __entry->time
@@ -2089,7 +2089,7 @@ TRACE_EVENT(nfsd_ctl_recoverydir,
 	),
 	TP_fast_assign(
 		__entry->netns_ino =3D net->ns.inum;
-		__assign_str(recdir, recdir);
+		__assign_str(recdir);
 	),
 	TP_printk("recdir=3D%s",
 		__get_str(recdir)
diff --git a/fs/ocfs2/ocfs2_trace.h b/fs/ocfs2/ocfs2_trace.h
index 9898c11bdfa1..60e208b01c8d 100644
--- a/fs/ocfs2/ocfs2_trace.h
+++ b/fs/ocfs2/ocfs2_trace.h
@@ -82,7 +82,7 @@ DECLARE_EVENT_CLASS(ocfs2__string,
 		__string(name,name)
 	),
 	TP_fast_assign(
-		__assign_str(name, name);
+		__assign_str(name);
 	),
 	TP_printk("%s", __get_str(name))
 );
@@ -1289,7 +1289,7 @@ DECLARE_EVENT_CLASS(ocfs2__file_ops,
 		__entry->dentry =3D dentry;
 		__entry->ino =3D ino;
 		__entry->d_len =3D d_len;
-		__assign_str(d_name, d_name);
+		__assign_str(d_name);
 		__entry->para =3D para;
 	),
 	TP_printk("%p %p %p %llu %llu %.*s", __entry->inode, __entry->file,
@@ -1425,7 +1425,7 @@ TRACE_EVENT(ocfs2_setattr,
 		__entry->dentry =3D dentry;
 		__entry->ino =3D ino;
 		__entry->d_len =3D d_len;
-		__assign_str(d_name, d_name);
+		__assign_str(d_name);
 		__entry->ia_valid =3D ia_valid;
 		__entry->ia_mode =3D ia_mode;
 		__entry->ia_uid =3D ia_uid;
@@ -1683,7 +1683,7 @@ TRACE_EVENT(ocfs2_parse_options,
 	),
 	TP_fast_assign(
 		__entry->is_remount =3D is_remount;
-		__assign_str(options, options);
+		__assign_str(options);
 	),
 	TP_printk("%d %s", __entry->is_remount, __get_str(options))
 );
@@ -1718,8 +1718,8 @@ TRACE_EVENT(ocfs2_initialize_super,
 		__field(int, cluster_bits)
 	),
 	TP_fast_assign(
-		__assign_str(label, label);
-		__assign_str(uuid_str, uuid_str);
+		__assign_str(label);
+		__assign_str(uuid_str);
 		__entry->root_dir =3D root_dir;
 		__entry->system_dir =3D system_dir;
 		__entry->cluster_bits =3D cluster_bits;
@@ -1746,7 +1746,7 @@ TRACE_EVENT(ocfs2_init_xattr_set_ctxt,
 		__field(int, credits)
 	),
 	TP_fast_assign(
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->meta =3D meta;
 		__entry->clusters =3D clusters;
 		__entry->credits =3D credits;
@@ -1770,7 +1770,7 @@ DECLARE_EVENT_CLASS(ocfs2__xattr_find,
 	),
 	TP_fast_assign(
 		__entry->ino =3D ino;
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->name_index =3D name_index;
 		__entry->hash =3D hash;
 		__entry->location =3D location;
@@ -2019,7 +2019,7 @@ TRACE_EVENT(ocfs2_sync_dquot_helper,
 		__entry->dq_id =3D dq_id;
 		__entry->dq_type =3D dq_type;
 		__entry->type =3D type;
-		__assign_str(s_id, s_id);
+		__assign_str(s_id);
 	),
 	TP_printk("%u %u %lu %s", __entry->dq_id, __entry->dq_type,
 		  __entry->type, __get_str(s_id))
@@ -2060,7 +2060,7 @@ TRACE_EVENT(ocfs2_dx_dir_search,
 	TP_fast_assign(
 		__entry->ino =3D ino;
 		__entry->namelen =3D namelen;
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->major_hash =3D major_hash;
 		__entry->minor_hash =3D minor_hash;
 		__entry->blkno =3D blkno;
@@ -2088,7 +2088,7 @@ TRACE_EVENT(ocfs2_find_files_on_disk,
 	),
 	TP_fast_assign(
 		__entry->namelen =3D namelen;
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->blkno =3D blkno;
 		__entry->dir =3D dir;
 	),
@@ -2107,7 +2107,7 @@ TRACE_EVENT(ocfs2_check_dir_for_entry,
 	TP_fast_assign(
 		__entry->dir =3D dir;
 		__entry->namelen =3D namelen;
-		__assign_str(name, name);
+		__assign_str(name);
 	),
 	TP_printk("%llu %.*s", __entry->dir,
 		  __entry->namelen, __get_str(name))
@@ -2135,7 +2135,7 @@ TRACE_EVENT(ocfs2_dx_dir_index_root_block,
 		__entry->major_hash =3D major_hash;
 		__entry->minor_hash =3D minor_hash;
 		__entry->namelen =3D namelen;
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->num_used =3D num_used;
 	),
 	TP_printk("%llu %x %x %.*s %u", __entry->dir,
@@ -2171,7 +2171,7 @@ DECLARE_EVENT_CLASS(ocfs2__dentry_ops,
 		__entry->dir =3D dir;
 		__entry->dentry =3D dentry;
 		__entry->name_len =3D name_len;
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->dir_blkno =3D dir_blkno;
 		__entry->extra =3D extra;
 	),
@@ -2217,7 +2217,7 @@ TRACE_EVENT(ocfs2_mknod,
 		__entry->dir =3D dir;
 		__entry->dentry =3D dentry;
 		__entry->name_len =3D name_len;
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->dir_blkno =3D dir_blkno;
 		__entry->dev =3D dev;
 		__entry->mode =3D mode;
@@ -2241,9 +2241,9 @@ TRACE_EVENT(ocfs2_link,
 	TP_fast_assign(
 		__entry->ino =3D ino;
 		__entry->old_len =3D old_len;
-		__assign_str(old_name, old_name);
+		__assign_str(old_name);
 		__entry->name_len =3D name_len;
-		__assign_str(name, name);
+		__assign_str(name);
 	),
 	TP_printk("%llu %.*s %.*s", __entry->ino,
 		  __entry->old_len, __get_str(old_name),
@@ -2279,9 +2279,9 @@ TRACE_EVENT(ocfs2_rename,
 		__entry->new_dir =3D new_dir;
 		__entry->new_dentry =3D new_dentry;
 		__entry->old_len =3D old_len;
-		__assign_str(old_name, old_name);
+		__assign_str(old_name);
 		__entry->new_len =3D new_len;
-		__assign_str(new_name, new_name);
+		__assign_str(new_name);
 	),
 	TP_printk("%p %p %p %p %.*s %.*s",
 		  __entry->old_dir, __entry->old_dentry,
@@ -2301,7 +2301,7 @@ TRACE_EVENT(ocfs2_rename_target_exists,
 	),
 	TP_fast_assign(
 		__entry->new_len =3D new_len;
-		__assign_str(new_name, new_name);
+		__assign_str(new_name);
 	),
 	TP_printk("%.*s", __entry->new_len, __get_str(new_name))
 );
@@ -2344,7 +2344,7 @@ TRACE_EVENT(ocfs2_symlink_begin,
 		__entry->dentry =3D dentry;
 		__entry->symname =3D symname;
 		__entry->len =3D len;
-		__assign_str(name, name);
+		__assign_str(name);
 	),
 	TP_printk("%p %p %s %.*s", __entry->dir, __entry->dentry,
 		  __entry->symname, __entry->len, __get_str(name))
@@ -2360,7 +2360,7 @@ TRACE_EVENT(ocfs2_blkno_stringify,
 	),
 	TP_fast_assign(
 		__entry->blkno =3D blkno;
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->namelen =3D namelen;
 	),
 	TP_printk("%llu %s %d", __entry->blkno, __get_str(name),
@@ -2381,7 +2381,7 @@ TRACE_EVENT(ocfs2_orphan_del,
 	),
 	TP_fast_assign(
 		__entry->dir =3D dir;
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->namelen =3D namelen;
 	),
 	TP_printk("%llu %s %d", __entry->dir, __get_str(name),
@@ -2403,7 +2403,7 @@ TRACE_EVENT(ocfs2_dentry_revalidate,
 	TP_fast_assign(
 		__entry->dentry =3D dentry;
 		__entry->len =3D len;
-		__assign_str(name, name);
+		__assign_str(name);
 	),
 	TP_printk("%p %.*s", __entry->dentry, __entry->len, __get_str(name))
 );
@@ -2420,7 +2420,7 @@ TRACE_EVENT(ocfs2_dentry_revalidate_negative,
 	),
 	TP_fast_assign(
 		__entry->len =3D len;
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->pgen =3D pgen;
 		__entry->gen =3D gen;
 	),
@@ -2445,7 +2445,7 @@ TRACE_EVENT(ocfs2_find_local_alias,
 	),
 	TP_fast_assign(
 		__entry->len =3D len;
-		__assign_str(name, name);
+		__assign_str(name);
 	),
 	TP_printk("%.*s", __entry->len, __get_str(name))
 );
@@ -2462,7 +2462,7 @@ TRACE_EVENT(ocfs2_dentry_attach_lock,
 	),
 	TP_fast_assign(
 		__entry->len =3D len;
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->parent =3D parent;
 		__entry->fsdata =3D fsdata;
 	),
@@ -2480,7 +2480,7 @@ TRACE_EVENT(ocfs2_dentry_attach_lock_found,
 		__field(unsigned long long, ino)
 	),
 	TP_fast_assign(
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->parent =3D parent;
 		__entry->ino =3D ino;
 	),
@@ -2527,7 +2527,7 @@ TRACE_EVENT(ocfs2_get_parent,
 	TP_fast_assign(
 		__entry->child =3D child;
 		__entry->len =3D len;
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->ino =3D ino;
 	),
 	TP_printk("%p %.*s %llu", __entry->child, __entry->len,
@@ -2551,7 +2551,7 @@ TRACE_EVENT(ocfs2_encode_fh_begin,
 	TP_fast_assign(
 		__entry->dentry =3D dentry;
 		__entry->name_len =3D name_len;
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->fh =3D fh;
 		__entry->len =3D len;
 		__entry->connectable =3D connectable;
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index af97389e983e..36d47ce59631 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -518,7 +518,7 @@ DECLARE_EVENT_CLASS(smb3_inf_compound_enter_class,
 		__entry->xid =3D xid;
 		__entry->tid =3D tid;
 		__entry->sesid =3D sesid;
-		__assign_str(path, full_path);
+		__assign_str(path);
 	),
 	TP_printk("xid=3D%u sid=3D0x%llx tid=3D0x%x path=3D%s",
 		__entry->xid, __entry->sesid, __entry->tid,
@@ -762,7 +762,7 @@ DECLARE_EVENT_CLASS(smb3_exit_err_class,
 	),
 	TP_fast_assign(
 		__entry->xid =3D xid;
-		__assign_str(func_name, func_name);
+		__assign_str(func_name);
 		__entry->rc =3D rc;
 	),
 	TP_printk("\t%s: xid=3D%u rc=3D%d",
@@ -815,7 +815,7 @@ DECLARE_EVENT_CLASS(smb3_enter_exit_class,
 	),
 	TP_fast_assign(
 		__entry->xid =3D xid;
-		__assign_str(func_name, func_name);
+		__assign_str(func_name);
 	),
 	TP_printk("\t%s: xid=3D%u",
 		__get_str(func_name), __entry->xid)
@@ -852,7 +852,7 @@ DECLARE_EVENT_CLASS(smb3_tcon_class,
 		__entry->xid =3D xid;
 		__entry->tid =3D tid;
 		__entry->sesid =3D sesid;
-		__assign_str(name, unc_name);
+		__assign_str(name);
 		__entry->rc =3D rc;
 	),
 	TP_printk("xid=3D%u sid=3D0x%llx tid=3D0x%x unc_name=3D%s rc=3D%d",
@@ -896,7 +896,7 @@ DECLARE_EVENT_CLASS(smb3_open_enter_class,
 		__entry->xid =3D xid;
 		__entry->tid =3D tid;
 		__entry->sesid =3D sesid;
-		__assign_str(path, full_path);
+		__assign_str(path);
 		__entry->create_options =3D create_options;
 		__entry->desired_access =3D desired_access;
 	),
@@ -1098,7 +1098,7 @@ DECLARE_EVENT_CLASS(smb3_connect_class,
 		__entry->conn_id =3D conn_id;
 		pss =3D (struct sockaddr_storage *)__entry->dst_addr;
 		*pss =3D *dst_addr;
-		__assign_str(hostname, hostname);
+		__assign_str(hostname);
 	),
 	TP_printk("conn_id=3D0x%llx server=3D%s addr=3D%pISpsfc",
 		__entry->conn_id,
@@ -1134,7 +1134,7 @@ DECLARE_EVENT_CLASS(smb3_connect_err_class,
 		__entry->rc =3D rc;
 		pss =3D (struct sockaddr_storage *)__entry->dst_addr;
 		*pss =3D *dst_addr;
-		__assign_str(hostname, hostname);
+		__assign_str(hostname);
 	),
 	TP_printk("rc=3D%d conn_id=3D0x%llx server=3D%s addr=3D%pISpsfc",
 		__entry->rc,
@@ -1166,7 +1166,7 @@ DECLARE_EVENT_CLASS(smb3_reconnect_class,
 	TP_fast_assign(
 		__entry->currmid =3D currmid;
 		__entry->conn_id =3D conn_id;
-		__assign_str(hostname, hostname);
+		__assign_str(hostname);
 	),
 	TP_printk("conn_id=3D0x%llx server=3D%s current_mid=3D%llu",
 		__entry->conn_id,
@@ -1255,7 +1255,7 @@ DECLARE_EVENT_CLASS(smb3_credit_class,
 	TP_fast_assign(
 		__entry->currmid =3D currmid;
 		__entry->conn_id =3D conn_id;
-		__assign_str(hostname, hostname);
+		__assign_str(hostname);
 		__entry->credits =3D credits;
 		__entry->credits_to_add =3D credits_to_add;
 		__entry->in_flight =3D in_flight;
diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
index e27daa51cab6..92ef4cdc486e 100644
--- a/fs/xfs/scrub/trace.h
+++ b/fs/xfs/scrub/trace.h
@@ -561,7 +561,7 @@ TRACE_EVENT(xchk_btree_op_error,
=20
 		__entry->dev =3D sc->mp->m_super->s_dev;
 		__entry->type =3D sc->sm->sm_type;
-		__assign_str(name, cur->bc_ops->name);
+		__assign_str(name);
 		__entry->level =3D level;
 		__entry->agno =3D XFS_FSB_TO_AGNO(cur->bc_mp, fsbno);
 		__entry->bno =3D XFS_FSB_TO_AGBNO(cur->bc_mp, fsbno);
@@ -604,7 +604,7 @@ TRACE_EVENT(xchk_ifork_btree_op_error,
 		__entry->ino =3D sc->ip->i_ino;
 		__entry->whichfork =3D cur->bc_ino.whichfork;
 		__entry->type =3D sc->sm->sm_type;
-		__assign_str(name, cur->bc_ops->name);
+		__assign_str(name);
 		__entry->level =3D level;
 		__entry->ptr =3D cur->bc_levels[level].ptr;
 		__entry->agno =3D XFS_FSB_TO_AGNO(cur->bc_mp, fsbno);
@@ -644,7 +644,7 @@ TRACE_EVENT(xchk_btree_error,
 		xfs_fsblock_t fsbno =3D xchk_btree_cur_fsbno(cur, level);
 		__entry->dev =3D sc->mp->m_super->s_dev;
 		__entry->type =3D sc->sm->sm_type;
-		__assign_str(name, cur->bc_ops->name);
+		__assign_str(name);
 		__entry->level =3D level;
 		__entry->agno =3D XFS_FSB_TO_AGNO(cur->bc_mp, fsbno);
 		__entry->bno =3D XFS_FSB_TO_AGBNO(cur->bc_mp, fsbno);
@@ -684,7 +684,7 @@ TRACE_EVENT(xchk_ifork_btree_error,
 		__entry->ino =3D sc->ip->i_ino;
 		__entry->whichfork =3D cur->bc_ino.whichfork;
 		__entry->type =3D sc->sm->sm_type;
-		__assign_str(name, cur->bc_ops->name);
+		__assign_str(name);
 		__entry->level =3D level;
 		__entry->agno =3D XFS_FSB_TO_AGNO(cur->bc_mp, fsbno);
 		__entry->bno =3D XFS_FSB_TO_AGBNO(cur->bc_mp, fsbno);
@@ -723,7 +723,7 @@ DECLARE_EVENT_CLASS(xchk_sbtree_class,
=20
 		__entry->dev =3D sc->mp->m_super->s_dev;
 		__entry->type =3D sc->sm->sm_type;
-		__assign_str(name, cur->bc_ops->name);
+		__assign_str(name);
 		__entry->agno =3D XFS_FSB_TO_AGNO(cur->bc_mp, fsbno);
 		__entry->bno =3D XFS_FSB_TO_AGBNO(cur->bc_mp, fsbno);
 		__entry->level =3D level;
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 05cb59bd0b80..25ff6fe1eb6c 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -168,7 +168,7 @@ TRACE_EVENT(xlog_intent_recovery_failed,
 	),
 	TP_fast_assign(
 		__entry->dev =3D mp->m_super->s_dev;
-		__assign_str(name, ops->name);
+		__assign_str(name);
 		__entry->error =3D error;
 	),
 	TP_printk("dev %d:%d optype %s error %d",
@@ -1913,7 +1913,7 @@ TRACE_EVENT(xfs_alloc_cur_check,
 	),
 	TP_fast_assign(
 		__entry->dev =3D cur->bc_mp->m_super->s_dev;
-		__assign_str(name, cur->bc_ops->name);
+		__assign_str(name);
 		__entry->bno =3D bno;
 		__entry->len =3D len;
 		__entry->diff =3D diff;
@@ -2473,7 +2473,7 @@ DECLARE_EVENT_CLASS(xfs_btree_cur_class,
 	),
 	TP_fast_assign(
 		__entry->dev =3D cur->bc_mp->m_super->s_dev;
-		__assign_str(name, cur->bc_ops->name);
+		__assign_str(name);
 		__entry->level =3D level;
 		__entry->nlevels =3D cur->bc_nlevels;
 		__entry->ptr =3D cur->bc_levels[level].ptr;
@@ -2523,7 +2523,7 @@ TRACE_EVENT(xfs_btree_alloc_block,
 			__entry->ino =3D 0;
 			break;
 		}
-		__assign_str(name, cur->bc_ops->name);
+		__assign_str(name);
 		__entry->error =3D error;
 		if (!error && stat) {
 			if (cur->bc_ops->ptr_len =3D=3D XFS_BTREE_LONG_PTR_LEN) {
@@ -2567,7 +2567,7 @@ TRACE_EVENT(xfs_btree_free_block,
 			__entry->ino =3D cur->bc_ino.ip->i_ino;
 		else
 			__entry->ino =3D 0;
-		__assign_str(name, cur->bc_ops->name);
+		__assign_str(name);
 		__entry->agbno =3D xfs_daddr_to_agbno(cur->bc_mp,
 							xfs_buf_daddr(bp));
 	),
@@ -2643,7 +2643,7 @@ DECLARE_EVENT_CLASS(xfs_defer_pending_class,
 	),
 	TP_fast_assign(
 		__entry->dev =3D mp ? mp->m_super->s_dev : 0;
-		__assign_str(name, dfp->dfp_ops->name);
+		__assign_str(name);
 		__entry->intent =3D dfp->dfp_intent;
 		__entry->flags =3D dfp->dfp_flags;
 		__entry->committed =3D dfp->dfp_done !=3D NULL;
@@ -2732,7 +2732,7 @@ DECLARE_EVENT_CLASS(xfs_defer_pending_item_class,
 	),
 	TP_fast_assign(
 		__entry->dev =3D mp ? mp->m_super->s_dev : 0;
-		__assign_str(name, dfp->dfp_ops->name);
+		__assign_str(name);
 		__entry->intent =3D dfp->dfp_intent;
 		__entry->item =3D item;
 		__entry->committed =3D dfp->dfp_done !=3D NULL;
@@ -4244,7 +4244,7 @@ TRACE_EVENT(xfs_btree_commit_afakeroot,
 	),
 	TP_fast_assign(
 		__entry->dev =3D cur->bc_mp->m_super->s_dev;
-		__assign_str(name, cur->bc_ops->name);
+		__assign_str(name);
 		__entry->agno =3D cur->bc_ag.pag->pag_agno;
 		__entry->agbno =3D cur->bc_ag.afake->af_root;
 		__entry->levels =3D cur->bc_ag.afake->af_levels;
@@ -4273,7 +4273,7 @@ TRACE_EVENT(xfs_btree_commit_ifakeroot,
 	),
 	TP_fast_assign(
 		__entry->dev =3D cur->bc_mp->m_super->s_dev;
-		__assign_str(name, cur->bc_ops->name);
+		__assign_str(name);
 		__entry->agno =3D XFS_INO_TO_AGNO(cur->bc_mp,
 					cur->bc_ino.ip->i_ino);
 		__entry->agino =3D XFS_INO_TO_AGINO(cur->bc_mp,
@@ -4312,7 +4312,7 @@ TRACE_EVENT(xfs_btree_bload_level_geometry,
 	),
 	TP_fast_assign(
 		__entry->dev =3D cur->bc_mp->m_super->s_dev;
-		__assign_str(name, cur->bc_ops->name);
+		__assign_str(name);
 		__entry->level =3D level;
 		__entry->nlevels =3D cur->bc_nlevels;
 		__entry->nr_this_level =3D nr_this_level;
@@ -4350,7 +4350,7 @@ TRACE_EVENT(xfs_btree_bload_block,
 	),
 	TP_fast_assign(
 		__entry->dev =3D cur->bc_mp->m_super->s_dev;
-		__assign_str(name, cur->bc_ops->name);
+		__assign_str(name);
 		__entry->level =3D level;
 		__entry->block_idx =3D block_idx;
 		__entry->nr_blocks =3D nr_blocks;
@@ -4573,7 +4573,7 @@ TRACE_EVENT(xfs_force_shutdown,
 		__entry->dev =3D mp->m_super->s_dev;
 		__entry->ptag =3D ptag;
 		__entry->flags =3D flags;
-		__assign_str(fname, fname);
+		__assign_str(fname);
 		__entry->line_num =3D line_num;
 	),
 	TP_printk("dev %d:%d tag %s flags %s file %s line_num %d",
@@ -4755,7 +4755,7 @@ DECLARE_EVENT_CLASS(xfbtree_freesp_class,
 	),
 	TP_fast_assign(
 		__entry->xfino =3D file_inode(xfbt->target->bt_file)->i_ino;
-		__assign_str(btname, cur->bc_ops->name);
+		__assign_str(btname);
 		__entry->nlevels =3D cur->bc_nlevels;
 		__entry->fileoff =3D fileoff;
 	),
@@ -5122,7 +5122,7 @@ DECLARE_EVENT_CLASS(xfs_getparents_rec_class,
 		__entry->bufsize =3D ppi->gp_bufsize;
 		__entry->parent_ino =3D pptr->gpr_parent.ha_fid.fid_ino;
 		__entry->parent_gen =3D pptr->gpr_parent.ha_fid.fid_gen;
-		__assign_str(name, pptr->gpr_name);
+		__assign_str(name);
 	),
 	TP_printk("dev %d:%d ino 0x%llx firstu %u reclen %u bufsize %u parent_ino=
 0x%llx parent_gen 0x%x name '%s'",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index c011ea236e9b..7c47151d5c72 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -61,7 +61,7 @@ TRACE_EVENT(extlog_mem_event,
 		else
 			__entry->pa_mask_lsb =3D ~0;
 		__entry->fru_id =3D *fru_id;
-		__assign_str(fru_text, fru_text);
+		__assign_str(fru_text);
 		cper_mem_err_pack(mem, &__entry->data);
 	),
=20
@@ -131,8 +131,8 @@ TRACE_EVENT(mc_event,
=20
 	TP_fast_assign(
 		__entry->error_type		=3D err_type;
-		__assign_str(msg, error_msg);
-		__assign_str(label, label);
+		__assign_str(msg);
+		__assign_str(label);
 		__entry->error_count		=3D error_count;
 		__entry->mc_index		=3D mc_index;
 		__entry->top_layer		=3D top_layer;
@@ -141,7 +141,7 @@ TRACE_EVENT(mc_event,
 		__entry->address		=3D address;
 		__entry->grain_bits		=3D grain_bits;
 		__entry->syndrome		=3D syndrome;
-		__assign_str(driver_detail, driver_detail);
+		__assign_str(driver_detail);
 	),
=20
 	TP_printk("%d %s error%s:%s%s on %s (mc:%d location:%d:%d:%d address:0x%0=
8lx grain:%d syndrome:0x%08lx%s%s)",
@@ -239,7 +239,7 @@ TRACE_EVENT(non_standard_event,
 	TP_fast_assign(
 		memcpy(__entry->sec_type, sec_type, UUID_SIZE);
 		memcpy(__entry->fru_id, fru_id, UUID_SIZE);
-		__assign_str(fru_text, fru_text);
+		__assign_str(fru_text);
 		__entry->sev =3D sev;
 		__entry->len =3D len;
 		memcpy(__get_dynamic_array(buf), err, len);
@@ -313,7 +313,7 @@ TRACE_EVENT(aer_event,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev_name, dev_name);
+		__assign_str(dev_name);
 		__entry->status		=3D status;
 		__entry->severity	=3D severity;
 		__entry->tlp_header_valid =3D tlp_header_valid;
diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index 517015ef36a8..202fc3680c36 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -32,8 +32,8 @@ DECLARE_EVENT_CLASS(snd_soc_dapm,
 	),
=20
 	TP_fast_assign(
-		__assign_str(card_name, dapm->card->name);
-		__assign_str(comp_name, dapm->component ? dapm->component->name : "(none=
)");
+		__assign_str(card_name);
+		__assign_str(comp_name);
 		__entry->val =3D val;
 	),
=20
@@ -69,7 +69,7 @@ DECLARE_EVENT_CLASS(snd_soc_dapm_basic,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, card->name);
+		__assign_str(name);
 		__entry->event =3D event;
 	),
=20
@@ -104,7 +104,7 @@ DECLARE_EVENT_CLASS(snd_soc_dapm_widget,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, w->name);
+		__assign_str(name);
 		__entry->val =3D val;
 	),
=20
@@ -150,7 +150,7 @@ TRACE_EVENT(snd_soc_dapm_walk_done,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, card->name);
+		__assign_str(name);
 		__entry->power_checks =3D card->dapm_stats.power_checks;
 		__entry->path_checks =3D card->dapm_stats.path_checks;
 		__entry->neighbour_checks =3D card->dapm_stats.neighbour_checks;
@@ -179,9 +179,9 @@ TRACE_EVENT(snd_soc_dapm_path,
 	),
=20
 	TP_fast_assign(
-		__assign_str(wname, widget->name);
-		__assign_str(pname, path->name ? path->name : DAPM_DIRECT);
-		__assign_str(pnname, path->node[dir]->name);
+		__assign_str(wname);
+		__assign_str(pname);
+		__assign_str(pnname);
 		__entry->path_connect =3D path->connect;
 		__entry->path_node =3D (long)path->node[dir];
 		__entry->path_dir =3D dir;
@@ -226,7 +226,7 @@ TRACE_EVENT(snd_soc_jack_irq,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, name);
+		__assign_str(name);
 	),
=20
 	TP_printk("%s", __get_str(name))
@@ -245,7 +245,7 @@ TRACE_EVENT(snd_soc_jack_report,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, jack->jack->id);
+		__assign_str(name);
 		__entry->mask =3D mask;
 		__entry->val =3D val;
 	),
@@ -266,7 +266,7 @@ TRACE_EVENT(snd_soc_jack_notify,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, jack->jack->id);
+		__assign_str(name);
 		__entry->val =3D val;
 	),
=20
diff --git a/include/trace/events/avc.h b/include/trace/events/avc.h
index b55fda2e0773..fed0f141d5f6 100644
--- a/include/trace/events/avc.h
+++ b/include/trace/events/avc.h
@@ -36,9 +36,9 @@ TRACE_EVENT(selinux_audited,
 		__entry->denied		=3D sad->denied;
 		__entry->audited	=3D sad->audited;
 		__entry->result		=3D sad->result;
-		__assign_str(tcontext, tcontext);
-		__assign_str(scontext, scontext);
-		__assign_str(tclass, tclass);
+		__assign_str(tcontext);
+		__assign_str(scontext);
+		__assign_str(tclass);
 	),
=20
 	TP_printk("requested=3D0x%x denied=3D0x%x audited=3D0x%x result=3D%d scon=
text=3D%s tcontext=3D%s tclass=3D%s",
diff --git a/include/trace/events/bridge.h b/include/trace/events/bridge.h
index a6b3a4e409f0..3fe4725c83ff 100644
--- a/include/trace/events/bridge.h
+++ b/include/trace/events/bridge.h
@@ -25,7 +25,7 @@ TRACE_EVENT(br_fdb_add,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev, dev->name);
+		__assign_str(dev);
 		memcpy(__entry->addr, addr, ETH_ALEN);
 		__entry->vid =3D vid;
 		__entry->nlh_flags =3D nlh_flags;
@@ -54,8 +54,8 @@ TRACE_EVENT(br_fdb_external_learn_add,
 	),
=20
 	TP_fast_assign(
-		__assign_str(br_dev, br->dev->name);
-		__assign_str(dev, p ? p->dev->name : "null");
+		__assign_str(br_dev);
+		__assign_str(dev);
 		memcpy(__entry->addr, addr, ETH_ALEN);
 		__entry->vid =3D vid;
 	),
@@ -80,8 +80,8 @@ TRACE_EVENT(fdb_delete,
 	),
=20
 	TP_fast_assign(
-		__assign_str(br_dev, br->dev->name);
-		__assign_str(dev, f->dst ? f->dst->dev->name : "null");
+		__assign_str(br_dev);
+		__assign_str(dev);
 		memcpy(__entry->addr, f->key.addr.addr, ETH_ALEN);
 		__entry->vid =3D f->key.vlan_id;
 	),
@@ -108,8 +108,8 @@ TRACE_EVENT(br_fdb_update,
 	),
=20
 	TP_fast_assign(
-		__assign_str(br_dev, br->dev->name);
-		__assign_str(dev, source->dev->name);
+		__assign_str(br_dev);
+		__assign_str(dev);
 		memcpy(__entry->addr, addr, ETH_ALEN);
 		__entry->vid =3D vid;
 		__entry->flags =3D flags;
@@ -141,7 +141,7 @@ TRACE_EVENT(br_mdb_full,
 	TP_fast_assign(
 		struct in6_addr *in6;
=20
-		__assign_str(dev, dev->name);
+		__assign_str(dev);
 		__entry->vid =3D group->vid;
=20
 		if (!group->proto) {
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index d2d94d7c3fb5..fadf406b5260 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1140,7 +1140,7 @@ TRACE_EVENT(btrfs_space_reservation,
 	),
=20
 	TP_fast_assign_btrfs(fs_info,
-		__assign_str(type, type);
+		__assign_str(type);
 		__entry->val		=3D val;
 		__entry->bytes		=3D bytes;
 		__entry->reserve	=3D reserve;
@@ -1169,7 +1169,7 @@ TRACE_EVENT(btrfs_trigger_flush,
 		__entry->flags	=3D flags;
 		__entry->bytes	=3D bytes;
 		__entry->flush	=3D flush;
-		__assign_str(reason, reason);
+		__assign_str(reason);
 	),
=20
 	TP_printk_btrfs("%s: flush=3D%d(%s) flags=3D%llu(%s) bytes=3D%llu",
@@ -1622,7 +1622,7 @@ DECLARE_EVENT_CLASS(btrfs_workqueue,
=20
 	TP_fast_assign_btrfs(btrfs_workqueue_owner(wq),
 		__entry->wq		=3D wq;
-		__assign_str(name, name);
+		__assign_str(name);
 	),
=20
 	TP_printk_btrfs("name=3D%s wq=3D%p", __get_str(name),
diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index 0b95865a90f3..af2755bda6eb 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -23,7 +23,7 @@ DECLARE_EVENT_CLASS(cgroup_root,
 	TP_fast_assign(
 		__entry->root =3D root->hierarchy_id;
 		__entry->ss_mask =3D root->subsys_mask;
-		__assign_str(name, root->name);
+		__assign_str(name);
 	),
=20
 	TP_printk("root=3D%d ss_mask=3D%#x name=3D%s",
@@ -68,7 +68,7 @@ DECLARE_EVENT_CLASS(cgroup,
 		__entry->root =3D cgrp->root->hierarchy_id;
 		__entry->id =3D cgroup_id(cgrp);
 		__entry->level =3D cgrp->level;
-		__assign_str(path, path);
+		__assign_str(path);
 	),
=20
 	TP_printk("root=3D%d id=3D%llu level=3D%d path=3D%s",
@@ -137,9 +137,9 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
 		__entry->dst_root =3D dst_cgrp->root->hierarchy_id;
 		__entry->dst_id =3D cgroup_id(dst_cgrp);
 		__entry->dst_level =3D dst_cgrp->level;
-		__assign_str(dst_path, path);
+		__assign_str(dst_path);
 		__entry->pid =3D task->pid;
-		__assign_str(comm, task->comm);
+		__assign_str(comm);
 	),
=20
 	TP_printk("dst_root=3D%d dst_id=3D%llu dst_level=3D%d dst_path=3D%s pid=
=3D%d comm=3D%s",
@@ -181,7 +181,7 @@ DECLARE_EVENT_CLASS(cgroup_event,
 		__entry->root =3D cgrp->root->hierarchy_id;
 		__entry->id =3D cgroup_id(cgrp);
 		__entry->level =3D cgrp->level;
-		__assign_str(path, path);
+		__assign_str(path);
 		__entry->val =3D val;
 	),
=20
diff --git a/include/trace/events/clk.h b/include/trace/events/clk.h
index daed3c7a48c1..759f7371a6dc 100644
--- a/include/trace/events/clk.h
+++ b/include/trace/events/clk.h
@@ -23,7 +23,7 @@ DECLARE_EVENT_CLASS(clk,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, core->name);
+		__assign_str(name);
 	),
=20
 	TP_printk("%s", __get_str(name))
@@ -97,7 +97,7 @@ DECLARE_EVENT_CLASS(clk_rate,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, core->name);
+		__assign_str(name);
 		__entry->rate =3D rate;
 	),
=20
@@ -145,7 +145,7 @@ DECLARE_EVENT_CLASS(clk_rate_range,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, core->name);
+		__assign_str(name);
 		__entry->min =3D min;
 		__entry->max =3D max;
 	),
@@ -174,8 +174,8 @@ DECLARE_EVENT_CLASS(clk_parent,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, core->name);
-		__assign_str(pname, parent ? parent->name : "none");
+		__assign_str(name);
+		__assign_str(pname);
 	),
=20
 	TP_printk("%s %s", __get_str(name), __get_str(pname))
@@ -207,7 +207,7 @@ DECLARE_EVENT_CLASS(clk_phase,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, core->name);
+		__assign_str(name);
 		__entry->phase =3D phase;
 	),
=20
@@ -241,7 +241,7 @@ DECLARE_EVENT_CLASS(clk_duty_cycle,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, core->name);
+		__assign_str(name);
 		__entry->num =3D duty->num;
 		__entry->den =3D duty->den;
 	),
@@ -279,8 +279,8 @@ DECLARE_EVENT_CLASS(clk_rate_request,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, req->core ? req->core->name : "none");
-		__assign_str(pname, req->best_parent_hw ? clk_hw_get_name(req->best_pare=
nt_hw) : "none");
+		__assign_str(name);
+		__assign_str(pname);
 		__entry->min =3D req->min_rate;
 		__entry->max =3D req->max_rate;
 		__entry->prate =3D req->best_parent_rate;
diff --git a/include/trace/events/cma.h b/include/trace/events/cma.h
index 25103e67737c..383c09f583ac 100644
--- a/include/trace/events/cma.h
+++ b/include/trace/events/cma.h
@@ -23,7 +23,7 @@ TRACE_EVENT(cma_release,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->pfn =3D pfn;
 		__entry->page =3D page;
 		__entry->count =3D count;
@@ -49,7 +49,7 @@ TRACE_EVENT(cma_alloc_start,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->count =3D count;
 		__entry->align =3D align;
 	),
@@ -77,7 +77,7 @@ TRACE_EVENT(cma_alloc_finish,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->pfn =3D pfn;
 		__entry->page =3D page;
 		__entry->count =3D count;
@@ -110,7 +110,7 @@ TRACE_EVENT(cma_alloc_busy_retry,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->pfn =3D pfn;
 		__entry->page =3D page;
 		__entry->count =3D count;
diff --git a/include/trace/events/devfreq.h b/include/trace/events/devfreq.h
index 7627c620bbda..6cbc4d59fd96 100644
--- a/include/trace/events/devfreq.h
+++ b/include/trace/events/devfreq.h
@@ -23,7 +23,7 @@ TRACE_EVENT(devfreq_frequency,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev_name, dev_name(&devfreq->dev));
+		__assign_str(dev_name);
 		__entry->freq =3D freq;
 		__entry->prev_freq =3D prev_freq;
 		__entry->busy_time =3D devfreq->last_status.busy_time;
@@ -54,7 +54,7 @@ TRACE_EVENT(devfreq_monitor,
 		__entry->busy_time =3D devfreq->last_status.busy_time;
 		__entry->total_time =3D devfreq->last_status.total_time;
 		__entry->polling_ms =3D devfreq->profile->polling_ms;
-		__assign_str(dev_name, dev_name(&devfreq->dev));
+		__assign_str(dev_name);
 	),
=20
 	TP_printk("dev_name=3D%-30s freq=3D%-12lu polling_ms=3D%-3u load=3D%-2lu",
diff --git a/include/trace/events/devlink.h b/include/trace/events/devlink.h
index 77ff7cfc6049..f241e204fe6b 100644
--- a/include/trace/events/devlink.h
+++ b/include/trace/events/devlink.h
@@ -31,9 +31,9 @@ TRACE_EVENT(devlink_hwmsg,
 	),
=20
 	TP_fast_assign(
-		__assign_str(bus_name, devlink_to_dev(devlink)->bus->name);
-		__assign_str(dev_name, dev_name(devlink_to_dev(devlink)));
-		__assign_str(driver_name, devlink_to_dev(devlink)->driver->name);
+		__assign_str(bus_name);
+		__assign_str(dev_name);
+		__assign_str(driver_name);
 		__entry->incoming =3D incoming;
 		__entry->type =3D type;
 		memcpy(__get_dynamic_array(buf), buf, len);
@@ -63,11 +63,11 @@ TRACE_EVENT(devlink_hwerr,
 		),
=20
 	TP_fast_assign(
-		__assign_str(bus_name, devlink_to_dev(devlink)->bus->name);
-		__assign_str(dev_name, dev_name(devlink_to_dev(devlink)));
-		__assign_str(driver_name, devlink_to_dev(devlink)->driver->name);
+		__assign_str(bus_name);
+		__assign_str(dev_name);
+		__assign_str(driver_name);
 		__entry->err =3D err;
-		__assign_str(msg, msg);
+		__assign_str(msg);
 		),
=20
 	TP_printk("bus_name=3D%s dev_name=3D%s driver_name=3D%s err=3D%d %s",
@@ -93,11 +93,11 @@ TRACE_EVENT(devlink_health_report,
 	),
=20
 	TP_fast_assign(
-		__assign_str(bus_name, devlink_to_dev(devlink)->bus->name);
-		__assign_str(dev_name, dev_name(devlink_to_dev(devlink)));
-		__assign_str(driver_name, devlink_to_dev(devlink)->driver->name);
-		__assign_str(reporter_name, reporter_name);
-		__assign_str(msg, msg);
+		__assign_str(bus_name);
+		__assign_str(dev_name);
+		__assign_str(driver_name);
+		__assign_str(reporter_name);
+		__assign_str(msg);
 	),
=20
 	TP_printk("bus_name=3D%s dev_name=3D%s driver_name=3D%s reporter_name=3D%=
s: %s",
@@ -125,10 +125,10 @@ TRACE_EVENT(devlink_health_recover_aborted,
 	),
=20
 	TP_fast_assign(
-		__assign_str(bus_name, devlink_to_dev(devlink)->bus->name);
-		__assign_str(dev_name, dev_name(devlink_to_dev(devlink)));
-		__assign_str(driver_name, devlink_to_dev(devlink)->driver->name);
-		__assign_str(reporter_name, reporter_name);
+		__assign_str(bus_name);
+		__assign_str(dev_name);
+		__assign_str(driver_name);
+		__assign_str(reporter_name);
 		__entry->health_state =3D health_state;
 		__entry->time_since_last_recover =3D time_since_last_recover;
 	),
@@ -158,10 +158,10 @@ TRACE_EVENT(devlink_health_reporter_state_update,
 	),
=20
 	TP_fast_assign(
-		__assign_str(bus_name, devlink_to_dev(devlink)->bus->name);
-		__assign_str(dev_name, dev_name(devlink_to_dev(devlink)));
-		__assign_str(driver_name, devlink_to_dev(devlink)->driver->name);
-		__assign_str(reporter_name, reporter_name);
+		__assign_str(bus_name);
+		__assign_str(dev_name);
+		__assign_str(driver_name);
+		__assign_str(reporter_name);
 		__entry->new_state =3D new_state;
 	),
=20
@@ -192,11 +192,11 @@ TRACE_EVENT(devlink_trap_report,
 	TP_fast_assign(
 		struct net_device *input_dev =3D metadata->input_dev;
=20
-		__assign_str(bus_name, devlink_to_dev(devlink)->bus->name);
-		__assign_str(dev_name, dev_name(devlink_to_dev(devlink)));
-		__assign_str(driver_name, devlink_to_dev(devlink)->driver->name);
-		__assign_str(trap_name, metadata->trap_name);
-		__assign_str(trap_group_name, metadata->trap_group_name);
+		__assign_str(bus_name);
+		__assign_str(dev_name);
+		__assign_str(driver_name);
+		__assign_str(trap_name);
+		__assign_str(trap_group_name);
 		strscpy(__entry->input_dev_name, input_dev ? input_dev->name : "NULL", I=
FNAMSIZ);
 	),
=20
diff --git a/include/trace/events/dma_fence.h b/include/trace/events/dma_fe=
nce.h
index 3963e79ca7b4..a4de3df8500b 100644
--- a/include/trace/events/dma_fence.h
+++ b/include/trace/events/dma_fence.h
@@ -23,8 +23,8 @@ DECLARE_EVENT_CLASS(dma_fence,
 	),
=20
 	TP_fast_assign(
-		__assign_str(driver, fence->ops->get_driver_name(fence));
-		__assign_str(timeline, fence->ops->get_timeline_name(fence));
+		__assign_str(driver);
+		__assign_str(timeline);
 		__entry->context =3D fence->context;
 		__entry->seqno =3D fence->seqno;
 	),
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index e18684b02c3d..b9bbfd855f2a 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -47,7 +47,7 @@ TRACE_EVENT(erofs_lookup,
 	TP_fast_assign(
 		__entry->dev	=3D dir->i_sb->s_dev;
 		__entry->nid	=3D EROFS_I(dir)->nid;
-		__assign_str(name, dentry->d_name.name);
+		__assign_str(name);
 		__entry->flags	=3D flags;
 	),
=20
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 371ba28415f5..ed794b5fefbe 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -354,7 +354,7 @@ TRACE_EVENT(f2fs_unlink_enter,
 		__entry->ino	=3D dir->i_ino;
 		__entry->size	=3D dir->i_size;
 		__entry->blocks	=3D dir->i_blocks;
-		__assign_str(name, dentry->d_name.name);
+		__assign_str(name);
 	),
=20
 	TP_printk("dev =3D (%d,%d), dir ino =3D %lu, i_size =3D %lld, "
@@ -843,7 +843,7 @@ TRACE_EVENT(f2fs_lookup_start,
 	TP_fast_assign(
 		__entry->dev	=3D dir->i_sb->s_dev;
 		__entry->ino	=3D dir->i_ino;
-		__assign_str(name, dentry->d_name.name);
+		__assign_str(name);
 		__entry->flags	=3D flags;
 	),
=20
@@ -871,7 +871,7 @@ TRACE_EVENT(f2fs_lookup_end,
 	TP_fast_assign(
 		__entry->dev	=3D dir->i_sb->s_dev;
 		__entry->ino	=3D dir->i_ino;
-		__assign_str(name, dentry->d_name.name);
+		__assign_str(name);
 		__entry->cino	=3D ino;
 		__entry->err	=3D err;
 	),
@@ -903,9 +903,9 @@ TRACE_EVENT(f2fs_rename_start,
 	TP_fast_assign(
 		__entry->dev		=3D old_dir->i_sb->s_dev;
 		__entry->ino		=3D old_dir->i_ino;
-		__assign_str(old_name, old_dentry->d_name.name);
+		__assign_str(old_name);
 		__entry->new_pino	=3D new_dir->i_ino;
-		__assign_str(new_name, new_dentry->d_name.name);
+		__assign_str(new_name);
 		__entry->flags		=3D flags;
 	),
=20
@@ -937,8 +937,8 @@ TRACE_EVENT(f2fs_rename_end,
 	TP_fast_assign(
 		__entry->dev		=3D old_dentry->d_sb->s_dev;
 		__entry->ino		=3D old_dentry->d_inode->i_ino;
-		__assign_str(old_name, old_dentry->d_name.name);
-		__assign_str(new_name, new_dentry->d_name.name);
+		__assign_str(old_name);
+		__assign_str(new_name);
 		__entry->flags		=3D flags;
 		__entry->ret		=3D ret;
 	),
@@ -1557,7 +1557,7 @@ TRACE_EVENT(f2fs_write_checkpoint,
 	TP_fast_assign(
 		__entry->dev		=3D sb->s_dev;
 		__entry->reason		=3D reason;
-		__assign_str(dest_msg, msg);
+		__assign_str(dest_msg);
 	),
=20
 	TP_printk("dev =3D (%d,%d), checkpoint for %s, state =3D %s",
@@ -2333,12 +2333,12 @@ DECLARE_EVENT_CLASS(f2fs__rw_start,
 		 * because this screws up the tooling that parses
 		 * the traces.
 		 */
-		__assign_str(pathbuf, pathname);
+		__assign_str(pathbuf);
 		(void)strreplace(__get_str(pathbuf), ' ', '_');
 		__entry->offset =3D offset;
 		__entry->bytes =3D bytes;
 		__entry->i_size =3D i_size_read(inode);
-		__assign_str(cmdline, command);
+		__assign_str(cmdline);
 		(void)strreplace(__get_str(cmdline), ' ', '_');
 		__entry->pid =3D pid;
 		__entry->ino =3D inode->i_ino;
diff --git a/include/trace/events/habanalabs.h b/include/trace/events/haban=
alabs.h
index a78d21fa9f29..4a2bb2c896d1 100644
--- a/include/trace/events/habanalabs.h
+++ b/include/trace/events/habanalabs.h
@@ -27,7 +27,7 @@ DECLARE_EVENT_CLASS(habanalabs_mmu_template,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dname, dev_name(dev));
+		__assign_str(dname);
 		__entry->virt_addr =3D virt_addr;
 		__entry->phys_addr =3D phys_addr;
 		__entry->page_size =3D page_size;
@@ -64,7 +64,7 @@ DECLARE_EVENT_CLASS(habanalabs_dma_alloc_template,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dname, dev_name(dev));
+		__assign_str(dname);
 		__entry->cpu_addr =3D cpu_addr;
 		__entry->dma_addr =3D dma_addr;
 		__entry->size =3D size;
@@ -103,7 +103,7 @@ DECLARE_EVENT_CLASS(habanalabs_dma_map_template,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dname, dev_name(dev));
+		__assign_str(dname);
 		__entry->phys_addr =3D phys_addr;
 		__entry->dma_addr =3D dma_addr;
 		__entry->len =3D len;
@@ -141,7 +141,7 @@ DECLARE_EVENT_CLASS(habanalabs_comms_template,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dname, dev_name(dev));
+		__assign_str(dname);
 		__entry->op_str =3D op_str;
 	),
=20
@@ -178,7 +178,7 @@ DECLARE_EVENT_CLASS(habanalabs_reg_access_template,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dname, dev_name(dev));
+		__assign_str(dname);
 		__entry->addr =3D addr;
 		__entry->val =3D val;
 	),
diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge=
_memory.h
index ab576898a126..b5f5369b6300 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -191,7 +191,7 @@ TRACE_EVENT(mm_khugepaged_scan_file,
 	TP_fast_assign(
 		__entry->mm =3D mm;
 		__entry->pfn =3D folio ? folio_pfn(folio) : -1;
-		__assign_str(filename, file->f_path.dentry->d_iname);
+		__assign_str(filename);
 		__entry->present =3D present;
 		__entry->swap =3D swap;
 		__entry->result =3D result;
@@ -228,7 +228,7 @@ TRACE_EVENT(mm_khugepaged_collapse_file,
 		__entry->index =3D index;
 		__entry->addr =3D addr;
 		__entry->is_shmem =3D is_shmem;
-		__assign_str(filename, file->f_path.dentry->d_iname);
+		__assign_str(filename);
 		__entry->nr =3D nr;
 		__entry->result =3D result;
 	),
diff --git a/include/trace/events/hwmon.h b/include/trace/events/hwmon.h
index d7a1d0ffb679..d1ff560cd9b5 100644
--- a/include/trace/events/hwmon.h
+++ b/include/trace/events/hwmon.h
@@ -21,7 +21,7 @@ DECLARE_EVENT_CLASS(hwmon_attr_class,
=20
 	TP_fast_assign(
 		__entry->index =3D index;
-		__assign_str(attr_name, attr_name);
+		__assign_str(attr_name);
 		__entry->val =3D val;
 	),
=20
@@ -57,8 +57,8 @@ TRACE_EVENT(hwmon_attr_show_string,
=20
 	TP_fast_assign(
 		__entry->index =3D index;
-		__assign_str(attr_name, attr_name);
-		__assign_str(label, s);
+		__assign_str(attr_name);
+		__assign_str(label);
 	),
=20
 	TP_printk("index=3D%d, attr_name=3D%s, val=3D%s",
diff --git a/include/trace/events/initcall.h b/include/trace/events/initcal=
l.h
index eb903c3f195f..5282afdf3ddf 100644
--- a/include/trace/events/initcall.h
+++ b/include/trace/events/initcall.h
@@ -18,7 +18,7 @@ TRACE_EVENT(initcall_level,
 	),
=20
 	TP_fast_assign(
-		__assign_str(level, level);
+		__assign_str(level);
 	),
=20
 	TP_printk("level=3D%s", __get_str(level))
diff --git a/include/trace/events/intel_ish.h b/include/trace/events/intel_=
ish.h
index e6d7ff55ee8c..64b6612c41bc 100644
--- a/include/trace/events/intel_ish.h
+++ b/include/trace/events/intel_ish.h
@@ -18,7 +18,7 @@ TRACE_EVENT(ishtp_dump,
 	),
=20
 	TP_fast_assign(
-		__assign_str(message, message);
+		__assign_str(message);
 	),
=20
 	TP_printk("%s", __get_str(message))
diff --git a/include/trace/events/io_uring.h b/include/trace/events/io_urin=
g.h
index e948df7ce625..412c9c210a32 100644
--- a/include/trace/events/io_uring.h
+++ b/include/trace/events/io_uring.h
@@ -164,7 +164,7 @@ TRACE_EVENT(io_uring_queue_async_work,
 		__entry->work		=3D &req->work;
 		__entry->rw		=3D rw;
=20
-		__assign_str(op_str, io_uring_get_opcode(req->opcode));
+		__assign_str(op_str);
 	),
=20
 	TP_printk("ring %p, request %p, user_data 0x%llx, opcode %s, flags 0x%llx=
, %s queue, work %p",
@@ -202,7 +202,7 @@ TRACE_EVENT(io_uring_defer,
 		__entry->data	=3D req->cqe.user_data;
 		__entry->opcode	=3D req->opcode;
=20
-		__assign_str(op_str, io_uring_get_opcode(req->opcode));
+		__assign_str(op_str);
 	),
=20
 	TP_printk("ring %p, request %p, user_data 0x%llx, opcode %s",
@@ -303,7 +303,7 @@ TRACE_EVENT(io_uring_fail_link,
 		__entry->opcode		=3D req->opcode;
 		__entry->link		=3D link;
=20
-		__assign_str(op_str, io_uring_get_opcode(req->opcode));
+		__assign_str(op_str);
 	),
=20
 	TP_printk("ring %p, request %p, user_data 0x%llx, opcode %s, link %p",
@@ -392,7 +392,7 @@ TRACE_EVENT(io_uring_submit_req,
 		__entry->flags		=3D (__force unsigned long long) req->flags;
 		__entry->sq_thread	=3D req->ctx->flags & IORING_SETUP_SQPOLL;
=20
-		__assign_str(op_str, io_uring_get_opcode(req->opcode));
+		__assign_str(op_str);
 	),
=20
 	TP_printk("ring %p, req %p, user_data 0x%llx, opcode %s, flags 0x%llx, "
@@ -436,7 +436,7 @@ TRACE_EVENT(io_uring_poll_arm,
 		__entry->mask		=3D mask;
 		__entry->events		=3D events;
=20
-		__assign_str(op_str, io_uring_get_opcode(req->opcode));
+		__assign_str(op_str);
 	),
=20
 	TP_printk("ring %p, req %p, user_data 0x%llx, opcode %s, mask 0x%x, event=
s 0x%x",
@@ -475,7 +475,7 @@ TRACE_EVENT(io_uring_task_add,
 		__entry->opcode		=3D req->opcode;
 		__entry->mask		=3D mask;
=20
-		__assign_str(op_str, io_uring_get_opcode(req->opcode));
+		__assign_str(op_str);
 	),
=20
 	TP_printk("ring %p, req %p, user_data 0x%llx, opcode %s, mask %x",
@@ -538,7 +538,7 @@ TRACE_EVENT(io_uring_req_failed,
 		__entry->addr3		=3D sqe->addr3;
 		__entry->error		=3D error;
=20
-		__assign_str(op_str, io_uring_get_opcode(sqe->opcode));
+		__assign_str(op_str);
 	),
=20
 	TP_printk("ring %p, req %p, user_data 0x%llx, "
diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.h
index af8bfed528fc..e772b1bc60d6 100644
--- a/include/trace/events/iocost.h
+++ b/include/trace/events/iocost.h
@@ -34,8 +34,8 @@ DECLARE_EVENT_CLASS(iocost_iocg_state,
 	),
=20
 	TP_fast_assign(
-		__assign_str(devname, ioc_name(iocg->ioc));
-		__assign_str(cgroup, path);
+		__assign_str(devname);
+		__assign_str(cgroup);
 		__entry->now =3D now->now;
 		__entry->vnow =3D now->vnow;
 		__entry->vrate =3D iocg->ioc->vtime_base_rate;
@@ -93,8 +93,8 @@ DECLARE_EVENT_CLASS(iocg_inuse_update,
 	),
=20
 	TP_fast_assign(
-		__assign_str(devname, ioc_name(iocg->ioc));
-		__assign_str(cgroup, path);
+		__assign_str(devname);
+		__assign_str(cgroup);
 		__entry->now =3D now->now;
 		__entry->old_inuse =3D old_inuse;
 		__entry->new_inuse =3D new_inuse;
@@ -159,7 +159,7 @@ TRACE_EVENT(iocost_ioc_vrate_adj,
 	),
=20
 	TP_fast_assign(
-		__assign_str(devname, ioc_name(ioc));
+		__assign_str(devname);
 		__entry->old_vrate =3D ioc->vtime_base_rate;
 		__entry->new_vrate =3D new_vrate;
 		__entry->busy_level =3D ioc->busy_level;
@@ -200,8 +200,8 @@ TRACE_EVENT(iocost_iocg_forgive_debt,
 	),
=20
 	TP_fast_assign(
-		__assign_str(devname, ioc_name(iocg->ioc));
-		__assign_str(cgroup, path);
+		__assign_str(devname);
+		__assign_str(cgroup);
 		__entry->now =3D now->now;
 		__entry->vnow =3D now->vnow;
 		__entry->usage_pct =3D usage_pct;
diff --git a/include/trace/events/iommu.h b/include/trace/events/iommu.h
index 70743db1fb75..373007e567cb 100644
--- a/include/trace/events/iommu.h
+++ b/include/trace/events/iommu.h
@@ -28,7 +28,7 @@ DECLARE_EVENT_CLASS(iommu_group_event,
=20
 	TP_fast_assign(
 		__entry->gid =3D group_id;
-		__assign_str(device, dev_name(dev));
+		__assign_str(device);
 	),
=20
 	TP_printk("IOMMU: groupID=3D%d device=3D%s",
@@ -62,7 +62,7 @@ DECLARE_EVENT_CLASS(iommu_device_event,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(dev));
+		__assign_str(device);
 	),
=20
 	TP_printk("IOMMU: device=3D%s", __get_str(device)
@@ -138,8 +138,8 @@ DECLARE_EVENT_CLASS(iommu_error,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(dev));
-		__assign_str(driver, dev_driver_string(dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->iova =3D iova;
 		__entry->flags =3D flags;
 	),
diff --git a/include/trace/events/irq.h b/include/trace/events/irq.h
index a07b4607b663..837c1740d0d0 100644
--- a/include/trace/events/irq.h
+++ b/include/trace/events/irq.h
@@ -63,7 +63,7 @@ TRACE_EVENT(irq_handler_entry,
=20
 	TP_fast_assign(
 		__entry->irq =3D irq;
-		__assign_str(name, action->name);
+		__assign_str(name);
 	),
=20
 	TP_printk("irq=3D%d name=3D%s", __entry->irq, __get_str(name))
diff --git a/include/trace/events/iscsi.h b/include/trace/events/iscsi.h
index 8ff2a3ca5d75..990fd154f586 100644
--- a/include/trace/events/iscsi.h
+++ b/include/trace/events/iscsi.h
@@ -30,7 +30,7 @@ DECLARE_EVENT_CLASS(iscsi_log_msg,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dname, dev_name(dev));
+		__assign_str(dname);
 		__assign_vstr(msg, vaf->fmt, vaf->va);
 	),
=20
diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 6e62cc64cd92..8a829e0f6e55 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -126,7 +126,7 @@ TRACE_EVENT(kmem_cache_free,
 	TP_fast_assign(
 		__entry->call_site	=3D call_site;
 		__entry->ptr		=3D ptr;
-		__assign_str(name, s->name);
+		__assign_str(name);
 	),
=20
 	TP_printk("call_site=3D%pS ptr=3D%p name=3D%s",
diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index 9ebd081e057e..8e89baa3775f 100644
--- a/include/trace/events/lock.h
+++ b/include/trace/events/lock.h
@@ -37,7 +37,7 @@ TRACE_EVENT(lock_acquire,
=20
 	TP_fast_assign(
 		__entry->flags =3D (trylock ? 1 : 0) | (read ? 2 : 0);
-		__assign_str(name, lock->name);
+		__assign_str(name);
 		__entry->lockdep_addr =3D lock;
 	),
=20
@@ -59,7 +59,7 @@ DECLARE_EVENT_CLASS(lock,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, lock->name);
+		__assign_str(name);
 		__entry->lockdep_addr =3D lock;
 	),
=20
diff --git a/include/trace/events/mmap_lock.h b/include/trace/events/mmap_l=
ock.h
index 14db8044c1ff..f2827f98a44f 100644
--- a/include/trace/events/mmap_lock.h
+++ b/include/trace/events/mmap_lock.h
@@ -27,7 +27,7 @@ DECLARE_EVENT_CLASS(mmap_lock,
=20
 	TP_fast_assign(
 		__entry->mm =3D mm;
-		__assign_str(memcg_path, memcg_path);
+		__assign_str(memcg_path);
 		__entry->write =3D write;
 	),
=20
@@ -65,7 +65,7 @@ TRACE_EVENT_FN(mmap_lock_acquire_returned,
=20
 	TP_fast_assign(
 		__entry->mm =3D mm;
-		__assign_str(memcg_path, memcg_path);
+		__assign_str(memcg_path);
 		__entry->write =3D write;
 		__entry->success =3D success;
 	),
diff --git a/include/trace/events/mmc.h b/include/trace/events/mmc.h
index 7b706ff21335..f1c2e94f7f68 100644
--- a/include/trace/events/mmc.h
+++ b/include/trace/events/mmc.h
@@ -68,7 +68,7 @@ TRACE_EVENT(mmc_request_start,
 		__entry->need_retune =3D host->need_retune;
 		__entry->hold_retune =3D host->hold_retune;
 		__entry->retune_period =3D host->retune_period;
-		__assign_str(name, mmc_hostname(host));
+		__assign_str(name);
 		__entry->mrq =3D mrq;
 	),
=20
@@ -156,7 +156,7 @@ TRACE_EVENT(mmc_request_done,
 		__entry->need_retune =3D host->need_retune;
 		__entry->hold_retune =3D host->hold_retune;
 		__entry->retune_period =3D host->retune_period;
-		__assign_str(name, mmc_hostname(host));
+		__assign_str(name);
 		__entry->mrq =3D mrq;
 	),
=20
diff --git a/include/trace/events/module.h b/include/trace/events/module.h
index 097485c73c01..e5a006be9dc6 100644
--- a/include/trace/events/module.h
+++ b/include/trace/events/module.h
@@ -41,7 +41,7 @@ TRACE_EVENT(module_load,
=20
 	TP_fast_assign(
 		__entry->taints =3D mod->taints;
-		__assign_str(name, mod->name);
+		__assign_str(name);
 	),
=20
 	TP_printk("%s %s", __get_str(name), show_module_flags(__entry->taints))
@@ -58,7 +58,7 @@ TRACE_EVENT(module_free,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, mod->name);
+		__assign_str(name);
 	),
=20
 	TP_printk("%s", __get_str(name))
@@ -82,7 +82,7 @@ DECLARE_EVENT_CLASS(module_refcnt,
 	TP_fast_assign(
 		__entry->ip	=3D ip;
 		__entry->refcnt	=3D atomic_read(&mod->refcnt);
-		__assign_str(name, mod->name);
+		__assign_str(name);
 	),
=20
 	TP_printk("%s call_site=3D%ps refcnt=3D%d",
@@ -119,7 +119,7 @@ TRACE_EVENT(module_request,
 	TP_fast_assign(
 		__entry->ip	=3D ip;
 		__entry->wait	=3D wait;
-		__assign_str(name, name);
+		__assign_str(name);
 	),
=20
 	TP_printk("%s wait=3D%d call_site=3D%ps",
diff --git a/include/trace/events/napi.h b/include/trace/events/napi.h
index dc03cf8e0369..b567b9ffedc1 100644
--- a/include/trace/events/napi.h
+++ b/include/trace/events/napi.h
@@ -26,7 +26,7 @@ TRACE_EVENT(napi_poll,
=20
 	TP_fast_assign(
 		__entry->napi =3D napi;
-		__assign_str(dev_name, napi->dev ? napi->dev->name : NO_DEV);
+		__assign_str(dev_name);
 		__entry->work =3D work;
 		__entry->budget =3D budget;
 	),
diff --git a/include/trace/events/neigh.h b/include/trace/events/neigh.h
index 833143d0992e..12362c35dbc0 100644
--- a/include/trace/events/neigh.h
+++ b/include/trace/events/neigh.h
@@ -42,7 +42,7 @@ TRACE_EVENT(neigh_create,
 		__be32 *p32;
=20
 		__entry->family =3D tbl->family;
-		__assign_str(dev, (dev ? dev->name : "NULL"));
+		__assign_str(dev);
 		__entry->entries =3D atomic_read(&tbl->gc_entries);
 		__entry->created =3D n !=3D NULL;
 		__entry->gc_exempt =3D exempt_from_gc;
@@ -103,7 +103,7 @@ TRACE_EVENT(neigh_update,
 		__be32 *p32;
=20
 		__entry->family =3D n->tbl->family;
-		__assign_str(dev, (n->dev ? n->dev->name : "NULL"));
+		__assign_str(dev);
 		__entry->lladdr_len =3D lladdr_len;
 		memcpy(__entry->lladdr, n->ha, lladdr_len);
 		__entry->flags =3D n->flags;
@@ -180,7 +180,7 @@ DECLARE_EVENT_CLASS(neigh__update,
 		__be32 *p32;
=20
 		__entry->family =3D n->tbl->family;
-		__assign_str(dev, (n->dev ? n->dev->name : "NULL"));
+		__assign_str(dev);
 		__entry->lladdr_len =3D lladdr_len;
 		memcpy(__entry->lladdr, n->ha, lladdr_len);
 		__entry->flags =3D n->flags;
diff --git a/include/trace/events/net.h b/include/trace/events/net.h
index f667c76a3b02..d55162c12f90 100644
--- a/include/trace/events/net.h
+++ b/include/trace/events/net.h
@@ -38,7 +38,7 @@ TRACE_EVENT(net_dev_start_xmit,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, dev->name);
+		__assign_str(name);
 		__entry->queue_mapping =3D skb->queue_mapping;
 		__entry->skbaddr =3D skb;
 		__entry->vlan_tagged =3D skb_vlan_tag_present(skb);
@@ -89,7 +89,7 @@ TRACE_EVENT(net_dev_xmit,
 		__entry->skbaddr =3D skb;
 		__entry->len =3D skb_len;
 		__entry->rc =3D rc;
-		__assign_str(name, dev->name);
+		__assign_str(name);
 	),
=20
 	TP_printk("dev=3D%s skbaddr=3D%p len=3D%u rc=3D%d",
@@ -110,8 +110,8 @@ TRACE_EVENT(net_dev_xmit_timeout,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, dev->name);
-		__assign_str(driver, netdev_drivername(dev));
+		__assign_str(name);
+		__assign_str(driver);
 		__entry->queue_index =3D queue_index;
 	),
=20
@@ -134,7 +134,7 @@ DECLARE_EVENT_CLASS(net_dev_template,
 	TP_fast_assign(
 		__entry->skbaddr =3D skb;
 		__entry->len =3D skb->len;
-		__assign_str(name, skb->dev->name);
+		__assign_str(name);
 	),
=20
 	TP_printk("dev=3D%s skbaddr=3D%p len=3D%u",
@@ -191,7 +191,7 @@ DECLARE_EVENT_CLASS(net_dev_rx_verbose_template,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, skb->dev->name);
+		__assign_str(name);
 #ifdef CONFIG_NET_RX_BUSY_POLL
 		__entry->napi_id =3D skb->napi_id;
 #else
diff --git a/include/trace/events/netlink.h b/include/trace/events/netlink.h
index 3b7be3b386a4..f036b8a20505 100644
--- a/include/trace/events/netlink.h
+++ b/include/trace/events/netlink.h
@@ -17,7 +17,7 @@ TRACE_EVENT(netlink_extack,
 	),
=20
 	TP_fast_assign(
-		__assign_str(msg, msg);
+		__assign_str(msg);
 	),
=20
 	TP_printk("msg=3D%s", __get_str(msg))
diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index b799f3bcba82..a42be4c8563b 100644
--- a/include/trace/events/oom.h
+++ b/include/trace/events/oom.h
@@ -92,7 +92,7 @@ TRACE_EVENT(mark_victim,
=20
 	TP_fast_assign(
 		__entry->pid =3D task->pid;
-		__assign_str(comm, task->comm);
+		__assign_str(comm);
 		__entry->total_vm =3D PG_COUNT_TO_KB(task->mm->total_vm);
 		__entry->anon_rss =3D PG_COUNT_TO_KB(get_mm_counter(task->mm, MM_ANONPAG=
ES));
 		__entry->file_rss =3D PG_COUNT_TO_KB(get_mm_counter(task->mm, MM_FILEPAG=
ES));
diff --git a/include/trace/events/osnoise.h b/include/trace/events/osnoise.h
index 82f741ec0f57..a2379a4f0684 100644
--- a/include/trace/events/osnoise.h
+++ b/include/trace/events/osnoise.h
@@ -75,7 +75,7 @@ TRACE_EVENT(irq_noise,
 	),
=20
 	TP_fast_assign(
-		__assign_str(desc, desc);
+		__assign_str(desc);
 		__entry->vector =3D vector;
 		__entry->start =3D start;
 		__entry->duration =3D duration;
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 77f14f7a11d4..d2349b6b531a 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -76,7 +76,7 @@ TRACE_EVENT(powernv_throttle,
=20
 	TP_fast_assign(
 		__entry->chip_id =3D chip_id;
-		__assign_str(reason, reason);
+		__assign_str(reason);
 		__entry->pmax =3D pmax;
 	),
=20
@@ -210,11 +210,10 @@ TRACE_EVENT(device_pm_callback_start,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(dev));
-		__assign_str(driver, dev_driver_string(dev));
-		__assign_str(parent,
-			dev->parent ? dev_name(dev->parent) : "none");
-		__assign_str(pm_ops, pm_ops ? pm_ops : "none ");
+		__assign_str(device);
+		__assign_str(driver);
+		__assign_str(parent);
+		__assign_str(pm_ops);
 		__entry->event =3D event;
 	),
=20
@@ -236,8 +235,8 @@ TRACE_EVENT(device_pm_callback_end,
 	),
=20
 	TP_fast_assign(
-		__assign_str(device, dev_name(dev));
-		__assign_str(driver, dev_driver_string(dev));
+		__assign_str(device);
+		__assign_str(driver);
 		__entry->error =3D error;
 	),
=20
@@ -279,7 +278,7 @@ DECLARE_EVENT_CLASS(wakeup_source,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->state =3D state;
 	),
=20
@@ -318,7 +317,7 @@ DECLARE_EVENT_CLASS(clock,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->state =3D state;
 		__entry->cpu_id =3D cpu_id;
 	),
@@ -364,7 +363,7 @@ DECLARE_EVENT_CLASS(power_domain,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->state =3D state;
 		__entry->cpu_id =3D cpu_id;
 ),
@@ -486,7 +485,7 @@ DECLARE_EVENT_CLASS(dev_pm_qos_request,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->type =3D type;
 		__entry->new_value =3D new_value;
 	),
diff --git a/include/trace/events/pwc.h b/include/trace/events/pwc.h
index a2da764a3b41..0543702542d9 100644
--- a/include/trace/events/pwc.h
+++ b/include/trace/events/pwc.h
@@ -26,7 +26,7 @@ TRACE_EVENT(pwc_handler_enter,
 		__entry->urb__actual_length =3D urb->actual_length;
 		__entry->fbuf__filled =3D (pdev->fill_buf
 					 ? pdev->fill_buf->filled : 0);
-		__assign_str(name, pdev->v4l2_dev.name);
+		__assign_str(name);
 	),
 	TP_printk("dev=3D%s (fbuf=3D%p filled=3D%d) urb=3D%p (status=3D%d actual_=
length=3D%u)",
 		__get_str(name),
@@ -50,7 +50,7 @@ TRACE_EVENT(pwc_handler_exit,
 		__entry->urb =3D urb;
 		__entry->fbuf =3D pdev->fill_buf;
 		__entry->fbuf__filled =3D pdev->fill_buf->filled;
-		__assign_str(name, pdev->v4l2_dev.name);
+		__assign_str(name);
 	),
 	TP_printk(" dev=3D%s (fbuf=3D%p filled=3D%d) urb=3D%p",
 		__get_str(name),
diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
index 1f4258308b96..f1b5e816e7e5 100644
--- a/include/trace/events/qdisc.h
+++ b/include/trace/events/qdisc.h
@@ -88,8 +88,8 @@ TRACE_EVENT(qdisc_reset,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev, qdisc_dev(q)->name);
-		__assign_str(kind, q->ops->id);
+		__assign_str(dev);
+		__assign_str(kind);
 		__entry->parent =3D q->parent;
 		__entry->handle =3D q->handle;
 	),
@@ -113,8 +113,8 @@ TRACE_EVENT(qdisc_destroy,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev, qdisc_dev(q)->name);
-		__assign_str(kind, q->ops->id);
+		__assign_str(dev);
+		__assign_str(kind);
 		__entry->parent =3D q->parent;
 		__entry->handle =3D q->handle;
 	),
@@ -137,8 +137,8 @@ TRACE_EVENT(qdisc_create,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev, dev->name);
-		__assign_str(kind, ops->id);
+		__assign_str(dev);
+		__assign_str(kind);
 		__entry->parent =3D parent;
 	),
=20
diff --git a/include/trace/events/qla.h b/include/trace/events/qla.h
index e7fd55e7dc3d..8800c35525a1 100644
--- a/include/trace/events/qla.h
+++ b/include/trace/events/qla.h
@@ -25,7 +25,7 @@ DECLARE_EVENT_CLASS(qla_log_event,
 		__vstring(msg, vaf->fmt, vaf->va)
 	),
 	TP_fast_assign(
-		__assign_str(buf, buf);
+		__assign_str(buf);
 		__assign_vstr(msg, vaf->fmt, vaf->va);
 	),
=20
diff --git a/include/trace/events/qrtr.h b/include/trace/events/qrtr.h
index 441132c67133..14f822983741 100644
--- a/include/trace/events/qrtr.h
+++ b/include/trace/events/qrtr.h
@@ -102,7 +102,7 @@ TRACE_EVENT(qrtr_ns_message,
 	),
=20
 	TP_fast_assign(
-		__assign_str(ctrl_pkt_str, ctrl_pkt_str);
+		__assign_str(ctrl_pkt_str);
 		__entry->sq_node =3D sq_node;
 		__entry->sq_port =3D sq_port;
 	),
diff --git a/include/trace/events/regulator.h b/include/trace/events/regula=
tor.h
index 72b3ba93b0a5..c58481a5d955 100644
--- a/include/trace/events/regulator.h
+++ b/include/trace/events/regulator.h
@@ -23,7 +23,7 @@ DECLARE_EVENT_CLASS(regulator_basic,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, name);
+		__assign_str(name);
 	),
=20
 	TP_printk("name=3D%s", __get_str(name))
@@ -119,7 +119,7 @@ DECLARE_EVENT_CLASS(regulator_range,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->min  =3D min;
 		__entry->max  =3D max;
 	),
@@ -152,7 +152,7 @@ DECLARE_EVENT_CLASS(regulator_value,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->val  =3D val;
 	),
=20
diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index f50fcafc69de..7f0c1ceae726 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -154,7 +154,7 @@ DECLARE_EVENT_CLASS(rpcgss_ctx_class,
 	TP_fast_assign(
 		__entry->cred =3D gc;
 		__entry->service =3D gc->gc_service;
-		__assign_str(principal, gc->gc_principal);
+		__assign_str(principal);
 	),
=20
 	TP_printk("cred=3D%p service=3D%s principal=3D'%s'",
@@ -189,7 +189,7 @@ DECLARE_EVENT_CLASS(rpcgss_svc_gssapi_class,
 	TP_fast_assign(
 		__entry->xid =3D __be32_to_cpu(rqstp->rq_xid);
 		__entry->maj_stat =3D maj_stat;
-		__assign_str(addr, rqstp->rq_xprt->xpt_remotebuf);
+		__assign_str(addr);
 	),
=20
 	TP_printk("addr=3D%s xid=3D0x%08x maj_stat=3D%s",
@@ -225,7 +225,7 @@ TRACE_EVENT(rpcgss_svc_wrap_failed,
=20
 	TP_fast_assign(
 		__entry->xid =3D be32_to_cpu(rqstp->rq_xid);
-		__assign_str(addr, rqstp->rq_xprt->xpt_remotebuf);
+		__assign_str(addr);
 	),
=20
 	TP_printk("addr=3D%s xid=3D0x%08x", __get_str(addr), __entry->xid)
@@ -245,7 +245,7 @@ TRACE_EVENT(rpcgss_svc_unwrap_failed,
=20
 	TP_fast_assign(
 		__entry->xid =3D be32_to_cpu(rqstp->rq_xid);
-		__assign_str(addr, rqstp->rq_xprt->xpt_remotebuf);
+		__assign_str(addr);
 	),
=20
 	TP_printk("addr=3D%s xid=3D0x%08x", __get_str(addr), __entry->xid)
@@ -271,7 +271,7 @@ TRACE_EVENT(rpcgss_svc_seqno_bad,
 		__entry->expected =3D expected;
 		__entry->received =3D received;
 		__entry->xid =3D __be32_to_cpu(rqstp->rq_xid);
-		__assign_str(addr, rqstp->rq_xprt->xpt_remotebuf);
+		__assign_str(addr);
 	),
=20
 	TP_printk("addr=3D%s xid=3D0x%08x expected seqno %u, received seqno %u",
@@ -299,7 +299,7 @@ TRACE_EVENT(rpcgss_svc_accept_upcall,
 		__entry->minor_status =3D minor_status;
 		__entry->major_status =3D major_status;
 		__entry->xid =3D be32_to_cpu(rqstp->rq_xid);
-		__assign_str(addr, rqstp->rq_xprt->xpt_remotebuf);
+		__assign_str(addr);
 	),
=20
 	TP_printk("addr=3D%s xid=3D0x%08x major_status=3D%s (0x%08lx) minor_statu=
s=3D%u",
@@ -327,7 +327,7 @@ TRACE_EVENT(rpcgss_svc_authenticate,
 	TP_fast_assign(
 		__entry->xid =3D be32_to_cpu(rqstp->rq_xid);
 		__entry->seqno =3D gc->gc_seq;
-		__assign_str(addr, rqstp->rq_xprt->xpt_remotebuf);
+		__assign_str(addr);
 	),
=20
 	TP_printk("addr=3D%s xid=3D0x%08x seqno=3D%u", __get_str(addr),
@@ -563,7 +563,7 @@ TRACE_EVENT(rpcgss_upcall_msg,
 	),
=20
 	TP_fast_assign(
-		__assign_str(msg, buf);
+		__assign_str(msg);
 	),
=20
 	TP_printk("msg=3D'%s'", __get_str(msg))
@@ -618,7 +618,7 @@ TRACE_EVENT(rpcgss_context,
 		__entry->timeout =3D timeout;
 		__entry->window_size =3D window_size;
 		__entry->len =3D len;
-		__assign_str(acceptor, data);
+		__assign_str(acceptor);
 	),
=20
 	TP_printk("win_size=3D%u expiry=3D%lu now=3D%lu timeout=3D%u acceptor=3D%=
*s",
@@ -677,7 +677,7 @@ TRACE_EVENT(rpcgss_oid_to_mech,
 	),
=20
 	TP_fast_assign(
-		__assign_str(oid, oid);
+		__assign_str(oid);
 	),
=20
 	TP_printk("mech for oid %s was not found", __get_str(oid))
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 027ac3ab457d..14392652273a 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -304,8 +304,8 @@ DECLARE_EVENT_CLASS(xprtrdma_reply_class,
 		__entry->xid =3D be32_to_cpu(rep->rr_xid);
 		__entry->version =3D be32_to_cpu(rep->rr_vers);
 		__entry->proc =3D be32_to_cpu(rep->rr_proc);
-		__assign_str(addr, rpcrdma_addrstr(rep->rr_rxprt));
-		__assign_str(port, rpcrdma_portstr(rep->rr_rxprt));
+		__assign_str(addr);
+		__assign_str(port);
 	),
=20
 	TP_printk("peer=3D[%s]:%s xid=3D0x%08x version=3D%u proc=3D%u",
@@ -335,8 +335,8 @@ DECLARE_EVENT_CLASS(xprtrdma_rxprt,
 	),
=20
 	TP_fast_assign(
-		__assign_str(addr, rpcrdma_addrstr(r_xprt));
-		__assign_str(port, rpcrdma_portstr(r_xprt));
+		__assign_str(addr);
+		__assign_str(port);
 	),
=20
 	TP_printk("peer=3D[%s]:%s",
@@ -369,8 +369,8 @@ DECLARE_EVENT_CLASS(xprtrdma_connect_class,
 	TP_fast_assign(
 		__entry->rc =3D rc;
 		__entry->connect_status =3D r_xprt->rx_ep->re_connect_status;
-		__assign_str(addr, rpcrdma_addrstr(r_xprt));
-		__assign_str(port, rpcrdma_portstr(r_xprt));
+		__assign_str(addr);
+		__assign_str(port);
 	),
=20
 	TP_printk("peer=3D[%s]:%s rc=3D%d connection status=3D%d",
@@ -608,8 +608,8 @@ DECLARE_EVENT_CLASS(xprtrdma_callback_class,
=20
 	TP_fast_assign(
 		__entry->xid =3D be32_to_cpu(rqst->rq_xid);
-		__assign_str(addr, rpcrdma_addrstr(r_xprt));
-		__assign_str(port, rpcrdma_portstr(r_xprt));
+		__assign_str(addr);
+		__assign_str(port);
 	),
=20
 	TP_printk("peer=3D[%s]:%s xid=3D0x%08x",
@@ -687,8 +687,8 @@ TRACE_EVENT(xprtrdma_op_connect,
=20
 	TP_fast_assign(
 		__entry->delay =3D delay;
-		__assign_str(addr, rpcrdma_addrstr(r_xprt));
-		__assign_str(port, rpcrdma_portstr(r_xprt));
+		__assign_str(addr);
+		__assign_str(port);
 	),
=20
 	TP_printk("peer=3D[%s]:%s delay=3D%lu",
@@ -716,8 +716,8 @@ TRACE_EVENT(xprtrdma_op_set_cto,
 	TP_fast_assign(
 		__entry->connect =3D connect;
 		__entry->reconnect =3D reconnect;
-		__assign_str(addr, rpcrdma_addrstr(r_xprt));
-		__assign_str(port, rpcrdma_portstr(r_xprt));
+		__assign_str(addr);
+		__assign_str(port);
 	),
=20
 	TP_printk("peer=3D[%s]:%s connect=3D%lu reconnect=3D%lu",
@@ -746,8 +746,8 @@ TRACE_EVENT(xprtrdma_createmrs,
=20
 	TP_fast_assign(
 		__entry->count =3D count;
-		__assign_str(addr, rpcrdma_addrstr(r_xprt));
-		__assign_str(port, rpcrdma_portstr(r_xprt));
+		__assign_str(addr);
+		__assign_str(port);
 	),
=20
 	TP_printk("peer=3D[%s]:%s created %u MRs",
@@ -775,8 +775,8 @@ TRACE_EVENT(xprtrdma_nomrs_err,
=20
 		__entry->task_id =3D rqst->rq_task->tk_pid;
 		__entry->client_id =3D rqst->rq_task->tk_client->cl_clid;
-		__assign_str(addr, rpcrdma_addrstr(r_xprt));
-		__assign_str(port, rpcrdma_portstr(r_xprt));
+		__assign_str(addr);
+		__assign_str(port);
 	),
=20
 	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " peer=3D[%s]:%s",
@@ -1001,8 +1001,8 @@ TRACE_EVENT(xprtrdma_post_recvs,
 		__entry->cq_id =3D ep->re_attr.recv_cq->res.id;
 		__entry->count =3D count;
 		__entry->posted =3D ep->re_receive_count;
-		__assign_str(addr, rpcrdma_addrstr(r_xprt));
-		__assign_str(port, rpcrdma_portstr(r_xprt));
+		__assign_str(addr);
+		__assign_str(port);
 	),
=20
 	TP_printk("peer=3D[%s]:%s cq.id=3D%d %u new recvs, %d active",
@@ -1031,8 +1031,8 @@ TRACE_EVENT(xprtrdma_post_recvs_err,
=20
 		__entry->cq_id =3D ep->re_attr.recv_cq->res.id;
 		__entry->status =3D status;
-		__assign_str(addr, rpcrdma_addrstr(r_xprt));
-		__assign_str(port, rpcrdma_portstr(r_xprt));
+		__assign_str(addr);
+		__assign_str(port);
 	),
=20
 	TP_printk("peer=3D[%s]:%s cq.id=3D%d rc=3D%d",
@@ -1445,8 +1445,8 @@ TRACE_EVENT(xprtrdma_cb_setup,
=20
 	TP_fast_assign(
 		__entry->reqs =3D reqs;
-		__assign_str(addr, rpcrdma_addrstr(r_xprt));
-		__assign_str(port, rpcrdma_portstr(r_xprt));
+		__assign_str(addr);
+		__assign_str(port);
 	),
=20
 	TP_printk("peer=3D[%s]:%s %u reqs",
@@ -1476,7 +1476,7 @@ DECLARE_EVENT_CLASS(svcrdma_accept_class,
=20
 	TP_fast_assign(
 		__entry->status =3D status;
-		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
+		__assign_str(addr);
 	),
=20
 	TP_printk("addr=3D%s status=3D%ld",
@@ -1962,7 +1962,7 @@ TRACE_EVENT(svcrdma_send_err,
 	TP_fast_assign(
 		__entry->status =3D status;
 		__entry->xid =3D __be32_to_cpu(rqst->rq_xid);
-		__assign_str(addr, rqst->rq_xprt->xpt_remotebuf);
+		__assign_str(addr);
 	),
=20
 	TP_printk("addr=3D%s xid=3D0x%08x status=3D%d", __get_str(addr),
@@ -2025,7 +2025,7 @@ TRACE_EVENT(svcrdma_rq_post_err,
=20
 	TP_fast_assign(
 		__entry->status =3D status;
-		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
+		__assign_str(addr);
 	),
=20
 	TP_printk("addr=3D%s status=3D%d",
@@ -2138,7 +2138,7 @@ TRACE_EVENT(svcrdma_qp_error,
=20
 	TP_fast_assign(
 		__entry->event =3D event->event;
-		__assign_str(device, event->device->name);
+		__assign_str(device);
 		snprintf(__entry->addr, sizeof(__entry->addr) - 1,
 			 "%pISpc", sap);
 	),
diff --git a/include/trace/events/rpm.h b/include/trace/events/rpm.h
index bd120e23ce12..2b0b4b6ef862 100644
--- a/include/trace/events/rpm.h
+++ b/include/trace/events/rpm.h
@@ -33,7 +33,7 @@ DECLARE_EVENT_CLASS(rpm_internal,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, dev_name(dev));
+		__assign_str(name);
 		__entry->flags =3D flags;
 		__entry->usage_count =3D atomic_read(
 			&dev->power.usage_count);
@@ -92,7 +92,7 @@ TRACE_EVENT(rpm_return_int,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, dev_name(dev));
+		__assign_str(name);
 		__entry->ip =3D ip;
 		__entry->ret =3D ret;
 	),
@@ -135,7 +135,7 @@ TRACE_EVENT(rpm_status,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, dev_name(dev));
+		__assign_str(name);
 		__entry->status =3D status;
 	),
=20
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 68973f650c26..6df2b4685b08 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -411,7 +411,7 @@ TRACE_EVENT(sched_process_exec,
 	),
=20
 	TP_fast_assign(
-		__assign_str(filename, bprm->filename);
+		__assign_str(filename);
 		__entry->pid		=3D p->pid;
 		__entry->old_pid	=3D old_pid;
 	),
@@ -445,10 +445,10 @@ TRACE_EVENT(sched_prepare_exec,
 	),
=20
 	TP_fast_assign(
-		__assign_str(interp, bprm->interp);
-		__assign_str(filename, bprm->filename);
+		__assign_str(interp);
+		__assign_str(filename);
 		__entry->pid =3D task->pid;
-		__assign_str(comm, task->comm);
+		__assign_str(comm);
 	),
=20
 	TP_printk("interp=3D%s filename=3D%s pid=3D%d comm=3D%s",
diff --git a/include/trace/events/sof.h b/include/trace/events/sof.h
index cd8e6844cca2..3061423c0667 100644
--- a/include/trace/events/sof.h
+++ b/include/trace/events/sof.h
@@ -23,7 +23,7 @@ DECLARE_EVENT_CLASS(sof_widget_template,
 		__field(int, use_count)
 	),
 	TP_fast_assign(
-		__assign_str(name, swidget->widget->name);
+		__assign_str(name);
 		__entry->use_count =3D swidget->use_count;
 	),
 	TP_printk("name=3D%s use_count=3D%d", __get_str(name), __entry->use_count)
@@ -49,7 +49,7 @@ TRACE_EVENT(sof_ipc3_period_elapsed_position,
 		__field(u64, wallclock)
 	),
 	TP_fast_assign(
-		__assign_str(device_name, dev_name(sdev->dev));
+		__assign_str(device_name);
 		__entry->host_posn =3D posn->host_posn;
 		__entry->dai_posn =3D posn->dai_posn;
 		__entry->wallclock =3D posn->wallclock;
@@ -75,7 +75,7 @@ TRACE_EVENT(sof_pcm_pointer_position,
 		__field(unsigned long, dai_posn)
 	),
 	TP_fast_assign(
-		__assign_str(device_name, dev_name(sdev->dev));
+		__assign_str(device_name);
 		__entry->pcm_id =3D le32_to_cpu(spcm->pcm.pcm_id);
 		__entry->stream =3D substream->stream;
 		__entry->dma_posn =3D dma_posn;
@@ -93,7 +93,7 @@ TRACE_EVENT(sof_stream_position_ipc_rx,
 		__string(device_name, dev_name(dev))
 	),
 	TP_fast_assign(
-		__assign_str(device_name, dev_name(dev));
+		__assign_str(device_name);
 	),
 	TP_printk("device_name=3D%s", __get_str(device_name))
 );
@@ -107,8 +107,8 @@ TRACE_EVENT(sof_ipc4_fw_config,
 		__field(u32, value)
 	),
 	TP_fast_assign(
-		__assign_str(device_name, dev_name(sdev->dev));
-		__assign_str(key, key);
+		__assign_str(device_name);
+		__assign_str(key);
 		__entry->value =3D value;
 	),
 	TP_printk("device_name=3D%s key=3D%s value=3D%d",
diff --git a/include/trace/events/sof_intel.h b/include/trace/events/sof_in=
tel.h
index 4cac5fef99a2..9e579e57b15c 100644
--- a/include/trace/events/sof_intel.h
+++ b/include/trace/events/sof_intel.h
@@ -22,8 +22,8 @@ TRACE_EVENT(sof_intel_hda_irq,
 		__string(source, source)
 	),
 	TP_fast_assign(
-		__assign_str(device_name, dev_name(sdev->dev));
-		__assign_str(source, source);
+		__assign_str(device_name);
+		__assign_str(source);
 	),
 	TP_printk("device_name=3D%s source=3D%s",
 		  __get_str(device_name), __get_str(source))
@@ -38,7 +38,7 @@ DECLARE_EVENT_CLASS(sof_intel_ipc_firmware_template,
 		__field(u32, msg_ext)
 	),
 	TP_fast_assign(
-		__assign_str(device_name, dev_name(sdev->dev));
+		__assign_str(device_name);
 		__entry->msg =3D msg;
 		__entry->msg_ext =3D msg_ext;
 	),
@@ -64,7 +64,7 @@ TRACE_EVENT(sof_intel_D0I3C_updated,
 		__field(u8, reg)
 	),
 	TP_fast_assign(
-		__assign_str(device_name, dev_name(sdev->dev));
+		__assign_str(device_name);
 		__entry->reg =3D reg;
 	),
 	TP_printk("device_name=3D%s register=3D%#x",
@@ -79,7 +79,7 @@ TRACE_EVENT(sof_intel_hda_irq_ipc_check,
 		__field(u32, irq_status)
 	),
 	TP_fast_assign(
-		__assign_str(device_name, dev_name(sdev->dev));
+		__assign_str(device_name);
 		__entry->irq_status =3D irq_status;
 	),
 	TP_printk("device_name=3D%s irq_status=3D%#x",
@@ -100,7 +100,7 @@ TRACE_EVENT(sof_intel_hda_dsp_pcm,
 		__field(unsigned long, pos)
 	),
 	TP_fast_assign(
-		__assign_str(device_name, dev_name(sdev->dev));
+		__assign_str(device_name);
 		__entry->hstream_index =3D hstream->index;
 		__entry->substream =3D substream->stream;
 		__entry->pos =3D pos;
@@ -119,7 +119,7 @@ TRACE_EVENT(sof_intel_hda_dsp_stream_status,
 		__field(u32, status)
 	),
 	TP_fast_assign(
-		__assign_str(device_name, dev_name(dev));
+		__assign_str(device_name);
 		__entry->stream =3D s->index;
 		__entry->status =3D status;
 	),
@@ -135,7 +135,7 @@ TRACE_EVENT(sof_intel_hda_dsp_check_stream_irq,
 		__field(u32, status)
 	),
 	TP_fast_assign(
-		__assign_str(device_name, dev_name(sdev->dev));
+		__assign_str(device_name);
 		__entry->status =3D status;
 	),
 	TP_printk("device_name=3D%s status=3D%#x",
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index ac05ed06a071..5e8495216689 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -188,10 +188,10 @@ TRACE_EVENT(rpc_clnt_new,
 		__entry->client_id =3D clnt->cl_clid;
 		__entry->xprtsec =3D args->xprtsec.policy;
 		__entry->flags =3D args->flags;
-		__assign_str(program, clnt->cl_program->name);
-		__assign_str(server, xprt->servername);
-		__assign_str(addr, xprt->address_strings[RPC_DISPLAY_ADDR]);
-		__assign_str(port, xprt->address_strings[RPC_DISPLAY_PORT]);
+		__assign_str(program);
+		__assign_str(server);
+		__assign_str(addr);
+		__assign_str(port);
 	),
=20
 	TP_printk("client=3D" SUNRPC_TRACE_CLID_SPECIFIER " peer=3D[%s]:%s"
@@ -220,8 +220,8 @@ TRACE_EVENT(rpc_clnt_new_err,
=20
 	TP_fast_assign(
 		__entry->error =3D error;
-		__assign_str(program, program);
-		__assign_str(server, server);
+		__assign_str(program);
+		__assign_str(server);
 	),
=20
 	TP_printk("program=3D%s server=3D%s error=3D%d",
@@ -325,8 +325,8 @@ TRACE_EVENT(rpc_request,
 		__entry->client_id =3D task->tk_client->cl_clid;
 		__entry->version =3D task->tk_client->cl_vers;
 		__entry->async =3D RPC_IS_ASYNC(task);
-		__assign_str(progname, task->tk_client->cl_program->name);
-		__assign_str(procname, rpc_proc_name(task));
+		__assign_str(progname);
+		__assign_str(procname);
 	),
=20
 	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " %sv%d %s (%ssync)",
@@ -439,7 +439,7 @@ DECLARE_EVENT_CLASS(rpc_task_queued,
 		__entry->runstate =3D task->tk_runstate;
 		__entry->status =3D task->tk_status;
 		__entry->flags =3D task->tk_flags;
-		__assign_str(q_name, rpc_qname(q));
+		__assign_str(q_name);
 		),
=20
 	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
@@ -515,10 +515,10 @@ DECLARE_EVENT_CLASS(rpc_reply_event,
 		__entry->task_id =3D task->tk_pid;
 		__entry->client_id =3D task->tk_client->cl_clid;
 		__entry->xid =3D be32_to_cpu(task->tk_rqstp->rq_xid);
-		__assign_str(progname, task->tk_client->cl_program->name);
+		__assign_str(progname);
 		__entry->version =3D task->tk_client->cl_vers;
-		__assign_str(procname, rpc_proc_name(task));
-		__assign_str(servername, task->tk_xprt->servername);
+		__assign_str(procname);
+		__assign_str(servername);
 	),
=20
 	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
@@ -647,8 +647,8 @@ TRACE_EVENT(rpc_stats_latency,
 		__entry->task_id =3D task->tk_pid;
 		__entry->xid =3D be32_to_cpu(task->tk_rqstp->rq_xid);
 		__entry->version =3D task->tk_client->cl_vers;
-		__assign_str(progname, task->tk_client->cl_program->name);
-		__assign_str(procname, rpc_proc_name(task));
+		__assign_str(progname);
+		__assign_str(procname);
 		__entry->backlog =3D ktime_to_us(backlog);
 		__entry->rtt =3D ktime_to_us(rtt);
 		__entry->execute =3D ktime_to_us(execute);
@@ -697,16 +697,15 @@ TRACE_EVENT(rpc_xdr_overflow,
=20
 			__entry->task_id =3D task->tk_pid;
 			__entry->client_id =3D task->tk_client->cl_clid;
-			__assign_str(progname,
-				     task->tk_client->cl_program->name);
+			__assign_str(progname);
 			__entry->version =3D task->tk_client->cl_vers;
-			__assign_str(procedure, task->tk_msg.rpc_proc->p_name);
+			__assign_str(procedure);
 		} else {
 			__entry->task_id =3D -1;
 			__entry->client_id =3D -1;
-			__assign_str(progname, "unknown");
+			__assign_str(progname);
 			__entry->version =3D 0;
-			__assign_str(procedure, "unknown");
+			__assign_str(procedure);
 		}
 		__entry->requested =3D requested;
 		__entry->end =3D xdr->end;
@@ -763,10 +762,9 @@ TRACE_EVENT(rpc_xdr_alignment,
=20
 		__entry->task_id =3D task->tk_pid;
 		__entry->client_id =3D task->tk_client->cl_clid;
-		__assign_str(progname,
-			     task->tk_client->cl_program->name);
+		__assign_str(progname);
 		__entry->version =3D task->tk_client->cl_vers;
-		__assign_str(procedure, task->tk_msg.rpc_proc->p_name);
+		__assign_str(procedure);
=20
 		__entry->offset =3D offset;
 		__entry->copied =3D copied;
@@ -1018,8 +1016,8 @@ DECLARE_EVENT_CLASS(rpc_xprt_lifetime_class,
=20
 	TP_fast_assign(
 		__entry->state =3D xprt->state;
-		__assign_str(addr, xprt->address_strings[RPC_DISPLAY_ADDR]);
-		__assign_str(port, xprt->address_strings[RPC_DISPLAY_PORT]);
+		__assign_str(addr);
+		__assign_str(port);
 	),
=20
 	TP_printk("peer=3D[%s]:%s state=3D%s",
@@ -1061,8 +1059,8 @@ DECLARE_EVENT_CLASS(rpc_xprt_event,
 	TP_fast_assign(
 		__entry->xid =3D be32_to_cpu(xid);
 		__entry->status =3D status;
-		__assign_str(addr, xprt->address_strings[RPC_DISPLAY_ADDR]);
-		__assign_str(port, xprt->address_strings[RPC_DISPLAY_PORT]);
+		__assign_str(addr);
+		__assign_str(port);
 	),
=20
 	TP_printk("peer=3D[%s]:%s xid=3D0x%08x status=3D%d", __get_str(addr),
@@ -1140,10 +1138,9 @@ TRACE_EVENT(xprt_retransmit,
 		__entry->xid =3D be32_to_cpu(rqst->rq_xid);
 		__entry->ntrans =3D rqst->rq_ntrans;
 		__entry->timeout =3D task->tk_timeout;
-		__assign_str(progname,
-			     task->tk_client->cl_program->name);
+		__assign_str(progname);
 		__entry->version =3D task->tk_client->cl_vers;
-		__assign_str(procname, rpc_proc_name(task));
+		__assign_str(procname);
 	),
=20
 	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
@@ -1167,8 +1164,8 @@ TRACE_EVENT(xprt_ping,
=20
 	TP_fast_assign(
 		__entry->status =3D status;
-		__assign_str(addr, xprt->address_strings[RPC_DISPLAY_ADDR]);
-		__assign_str(port, xprt->address_strings[RPC_DISPLAY_PORT]);
+		__assign_str(addr);
+		__assign_str(port);
 	),
=20
 	TP_printk("peer=3D[%s]:%s status=3D%d",
@@ -1315,8 +1312,8 @@ TRACE_EVENT(xs_data_ready,
 	),
=20
 	TP_fast_assign(
-		__assign_str(addr, xprt->address_strings[RPC_DISPLAY_ADDR]);
-		__assign_str(port, xprt->address_strings[RPC_DISPLAY_PORT]);
+		__assign_str(addr);
+		__assign_str(port);
 	),
=20
 	TP_printk("peer=3D[%s]:%s", __get_str(addr), __get_str(port))
@@ -1339,10 +1336,8 @@ TRACE_EVENT(xs_stream_read_data,
 	TP_fast_assign(
 		__entry->err =3D err;
 		__entry->total =3D total;
-		__assign_str(addr, xprt ?
-			xprt->address_strings[RPC_DISPLAY_ADDR] : EVENT_NULL_STR);
-		__assign_str(port, xprt ?
-			xprt->address_strings[RPC_DISPLAY_PORT] : EVENT_NULL_STR);
+		__assign_str(addr);
+		__assign_str(port);
 	),
=20
 	TP_printk("peer=3D[%s]:%s err=3D%zd total=3D%zu", __get_str(addr),
@@ -1364,8 +1359,8 @@ TRACE_EVENT(xs_stream_read_request,
 	),
=20
 	TP_fast_assign(
-		__assign_str(addr, xs->xprt.address_strings[RPC_DISPLAY_ADDR]);
-		__assign_str(port, xs->xprt.address_strings[RPC_DISPLAY_PORT]);
+		__assign_str(addr);
+		__assign_str(port);
 		__entry->xid =3D be32_to_cpu(xs->recv.xid);
 		__entry->copied =3D xs->recv.copied;
 		__entry->reclen =3D xs->recv.len;
@@ -1403,7 +1398,7 @@ TRACE_EVENT(rpcb_getport,
 		__entry->version =3D clnt->cl_vers;
 		__entry->protocol =3D task->tk_xprt->prot;
 		__entry->bind_version =3D bind_version;
-		__assign_str(servername, task->tk_xprt->servername);
+		__assign_str(servername);
 	),
=20
 	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
@@ -1493,8 +1488,8 @@ TRACE_EVENT(rpcb_register,
 	TP_fast_assign(
 		__entry->program =3D program;
 		__entry->version =3D version;
-		__assign_str(addr, addr);
-		__assign_str(netid, netid);
+		__assign_str(addr);
+		__assign_str(netid);
 	),
=20
 	TP_printk("program=3D%u version=3D%u addr=3D%s netid=3D%s",
@@ -1521,7 +1516,7 @@ TRACE_EVENT(rpcb_unregister,
 	TP_fast_assign(
 		__entry->program =3D program;
 		__entry->version =3D version;
-		__assign_str(netid, netid);
+		__assign_str(netid);
 	),
=20
 	TP_printk("program=3D%u version=3D%u netid=3D%s",
@@ -1551,8 +1546,8 @@ DECLARE_EVENT_CLASS(rpc_tls_class,
 	TP_fast_assign(
 		__entry->requested_policy =3D clnt->cl_xprtsec.policy;
 		__entry->version =3D clnt->cl_vers;
-		__assign_str(servername, xprt->servername);
-		__assign_str(progname, clnt->cl_program->name)
+		__assign_str(servername);
+		__assign_str(progname);
 	),
=20
 	TP_printk("server=3D%s %sv%u requested_policy=3D%s",
@@ -1794,10 +1789,9 @@ TRACE_EVENT(svc_process,
 		__entry->xid =3D be32_to_cpu(rqst->rq_xid);
 		__entry->vers =3D rqst->rq_vers;
 		__entry->proc =3D rqst->rq_proc;
-		__assign_str(service, name);
-		__assign_str(procedure, svc_proc_name(rqst));
-		__assign_str(addr, rqst->rq_xprt ?
-			     rqst->rq_xprt->xpt_remotebuf : EVENT_NULL_STR);
+		__assign_str(service);
+		__assign_str(procedure);
+		__assign_str(addr);
 	),
=20
 	TP_printk("addr=3D%s xid=3D0x%08x service=3D%s vers=3D%u proc=3D%s",
@@ -1915,7 +1909,7 @@ TRACE_EVENT(svc_stats_latency,
=20
 		__entry->execute =3D ktime_to_us(ktime_sub(ktime_get(),
 							 rqst->rq_stime));
-		__assign_str(procedure, svc_proc_name(rqst));
+		__assign_str(procedure);
 	),
=20
 	TP_printk(SVC_RQST_ENDPOINT_FORMAT " proc=3D%s execute-us=3D%lu",
@@ -1980,8 +1974,8 @@ TRACE_EVENT(svc_xprt_create_err,
=20
 	TP_fast_assign(
 		__entry->error =3D PTR_ERR(xprt);
-		__assign_str(program, program);
-		__assign_str(protocol, protocol);
+		__assign_str(program);
+		__assign_str(protocol);
 		__assign_sockaddr(addr, sap, salen);
 	),
=20
@@ -2120,8 +2114,8 @@ TRACE_EVENT(svc_xprt_accept,
 	TP_fast_assign(
 		SVC_XPRT_ENDPOINT_ASSIGNMENTS(xprt);
=20
-		__assign_str(protocol, xprt->xpt_class->xcl_name);
-		__assign_str(service, service);
+		__assign_str(protocol);
+		__assign_str(service);
 	),
=20
 	TP_printk(SVC_XPRT_ENDPOINT_FORMAT " protocol=3D%s service=3D%s",
@@ -2260,7 +2254,7 @@ TRACE_EVENT(svcsock_marker,
 	TP_fast_assign(
 		__entry->length =3D be32_to_cpu(marker) & RPC_FRAGMENT_SIZE_MASK;
 		__entry->last =3D be32_to_cpu(marker) & RPC_LAST_STREAM_FRAGMENT;
-		__assign_str(addr, xprt->xpt_remotebuf);
+		__assign_str(addr);
 	),
=20
 	TP_printk("addr=3D%s length=3D%u%s", __get_str(addr),
@@ -2284,7 +2278,7 @@ DECLARE_EVENT_CLASS(svcsock_class,
 	TP_fast_assign(
 		__entry->result =3D result;
 		__entry->flags =3D xprt->xpt_flags;
-		__assign_str(addr, xprt->xpt_remotebuf);
+		__assign_str(addr);
 	),
=20
 	TP_printk("addr=3D%s result=3D%zd flags=3D%s", __get_str(addr),
@@ -2330,7 +2324,7 @@ TRACE_EVENT(svcsock_tcp_recv_short,
 		__entry->expected =3D expected;
 		__entry->received =3D received;
 		__entry->flags =3D xprt->xpt_flags;
-		__assign_str(addr, xprt->xpt_remotebuf);
+		__assign_str(addr);
 	),
=20
 	TP_printk("addr=3D%s flags=3D%s expected=3D%u received=3D%u",
@@ -2358,7 +2352,7 @@ TRACE_EVENT(svcsock_tcp_state,
 		__entry->socket_state =3D socket->state;
 		__entry->sock_state =3D socket->sk->sk_state;
 		__entry->flags =3D xprt->xpt_flags;
-		__assign_str(addr, xprt->xpt_remotebuf);
+		__assign_str(addr);
 	),
=20
 	TP_printk("addr=3D%s state=3D%s sk_state=3D%s flags=3D%s", __get_str(addr=
),
@@ -2385,7 +2379,7 @@ DECLARE_EVENT_CLASS(svcsock_accept_class,
=20
 	TP_fast_assign(
 		__entry->status =3D status;
-		__assign_str(service, service);
+		__assign_str(service);
 		__entry->netns_ino =3D xprt->xpt_net->ns.inum;
 	),
=20
@@ -2421,7 +2415,7 @@ DECLARE_EVENT_CLASS(cache_event,
=20
 	TP_fast_assign(
 		__entry->h =3D h;
-		__assign_str(name, cd->name);
+		__assign_str(name);
 	),
=20
 	TP_printk("cache=3D%s entry=3D%p", __get_str(name), __entry->h)
@@ -2466,7 +2460,7 @@ DECLARE_EVENT_CLASS(register_class,
 		__entry->protocol =3D protocol;
 		__entry->port =3D port;
 		__entry->error =3D error;
-		__assign_str(program, program);
+		__assign_str(program);
 	),
=20
 	TP_printk("program=3D%sv%u proto=3D%s port=3D%u family=3D%s error=3D%d",
@@ -2511,7 +2505,7 @@ TRACE_EVENT(svc_unregister,
 	TP_fast_assign(
 		__entry->version =3D version;
 		__entry->error =3D error;
-		__assign_str(program, program);
+		__assign_str(program);
 	),
=20
 	TP_printk("program=3D%sv%u error=3D%d",
diff --git a/include/trace/events/swiotlb.h b/include/trace/events/swiotlb.h
index da05c9ebd224..3b6ddb136e4e 100644
--- a/include/trace/events/swiotlb.h
+++ b/include/trace/events/swiotlb.h
@@ -20,7 +20,7 @@ TRACE_EVENT(swiotlb_bounced,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev_name, dev_name(dev));
+		__assign_str(dev_name);
 		__entry->dma_mask =3D (dev->dma_mask ? *dev->dma_mask : 0);
 		__entry->dev_addr =3D dev_addr;
 		__entry->size =3D size;
diff --git a/include/trace/events/target.h b/include/trace/events/target.h
index 67fad2677ed5..a13cbf2b3405 100644
--- a/include/trace/events/target.h
+++ b/include/trace/events/target.h
@@ -154,7 +154,7 @@ TRACE_EVENT(target_sequencer_start,
 		__entry->task_attribute	=3D cmd->sam_task_attr;
 		__entry->control	=3D scsi_command_control(cmd->t_task_cdb);
 		memcpy(__entry->cdb, cmd->t_task_cdb, TCM_MAX_COMMAND_SIZE);
-		__assign_str(initiator, cmd->se_sess->se_node_acl->initiatorname);
+		__assign_str(initiator);
 	),
=20
 	TP_printk("%s -> LUN %03u tag %#llx %s data_length %6u  CDB %s  (TA:%s C:=
%02x)",
@@ -198,7 +198,7 @@ TRACE_EVENT(target_cmd_complete,
 			min(18, ((u8 *) cmd->sense_buffer)[SPC_ADD_SENSE_LEN_OFFSET] + 8) : 0;
 		memcpy(__entry->cdb, cmd->t_task_cdb, TCM_MAX_COMMAND_SIZE);
 		memcpy(__entry->sense_data, cmd->sense_buffer, __entry->sense_length);
-		__assign_str(initiator, cmd->se_sess->se_node_acl->initiatorname);
+		__assign_str(initiator);
 	),
=20
 	TP_printk("%s <- LUN %03u tag %#llx status %s (sense len %d%s%s)  %s data=
_length %6u  CDB %s  (TA:%s C:%02x)",
diff --git a/include/trace/events/tegra_apb_dma.h b/include/trace/events/te=
gra_apb_dma.h
index 971cd02d2daf..6d9f5075baa3 100644
--- a/include/trace/events/tegra_apb_dma.h
+++ b/include/trace/events/tegra_apb_dma.h
@@ -16,7 +16,7 @@ TRACE_EVENT(tegra_dma_tx_status,
 		__field(__u32,	residue)
 	),
 	TP_fast_assign(
-		__assign_str(chan, dev_name(&dc->dev->device));
+		__assign_str(chan);
 		__entry->cookie =3D cookie;
 		__entry->residue =3D state ? state->residue : (u32)-1;
 	),
@@ -33,7 +33,7 @@ TRACE_EVENT(tegra_dma_complete_cb,
 		__field(void *,	ptr)
 		),
 	TP_fast_assign(
-		__assign_str(chan, dev_name(&dc->dev->device));
+		__assign_str(chan);
 		__entry->count =3D count;
 		__entry->ptr =3D ptr;
 		),
@@ -49,7 +49,7 @@ TRACE_EVENT(tegra_dma_isr,
 		__field(int,	irq)
 	),
 	TP_fast_assign(
-		__assign_str(chan, dev_name(&dc->dev->device));
+		__assign_str(chan);
 		__entry->irq =3D irq;
 	),
 	TP_printk("%s: irq %d\n",  __get_str(chan), __entry->irq)
diff --git a/include/trace/events/ufs.h b/include/trace/events/ufs.h
index b930669bd1f0..c4e209fbdfbb 100644
--- a/include/trace/events/ufs.h
+++ b/include/trace/events/ufs.h
@@ -92,7 +92,7 @@ TRACE_EVENT(ufshcd_clk_gating,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev_name, dev_name);
+		__assign_str(dev_name);
 		__entry->state =3D state;
 	),
=20
@@ -117,9 +117,9 @@ TRACE_EVENT(ufshcd_clk_scaling,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev_name, dev_name);
-		__assign_str(state, state);
-		__assign_str(clk, clk);
+		__assign_str(dev_name);
+		__assign_str(state);
+		__assign_str(clk);
 		__entry->prev_state =3D prev_state;
 		__entry->curr_state =3D curr_state;
 	),
@@ -141,8 +141,8 @@ TRACE_EVENT(ufshcd_auto_bkops_state,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev_name, dev_name);
-		__assign_str(state, state);
+		__assign_str(dev_name);
+		__assign_str(state);
 	),
=20
 	TP_printk("%s: auto bkops - %s",
@@ -163,8 +163,8 @@ DECLARE_EVENT_CLASS(ufshcd_profiling_template,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev_name, dev_name);
-		__assign_str(profile_info, profile_info);
+		__assign_str(dev_name);
+		__assign_str(profile_info);
 		__entry->time_us =3D time_us;
 		__entry->err =3D err;
 	),
@@ -206,7 +206,7 @@ DECLARE_EVENT_CLASS(ufshcd_template,
 	TP_fast_assign(
 		__entry->usecs =3D usecs;
 		__entry->err =3D err;
-		__assign_str(dev_name, dev_name);
+		__assign_str(dev_name);
 		__entry->dev_state =3D dev_state;
 		__entry->link_state =3D link_state;
 	),
@@ -326,7 +326,7 @@ TRACE_EVENT(ufshcd_uic_command,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev_name, dev_name);
+		__assign_str(dev_name);
 		__entry->str_t =3D str_t;
 		__entry->cmd =3D cmd;
 		__entry->arg1 =3D arg1;
@@ -356,7 +356,7 @@ TRACE_EVENT(ufshcd_upiu,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev_name, dev_name);
+		__assign_str(dev_name);
 		__entry->str_t =3D str_t;
 		memcpy(__entry->hdr, hdr, sizeof(__entry->hdr));
 		memcpy(__entry->tsf, tsf, sizeof(__entry->tsf));
@@ -384,7 +384,7 @@ TRACE_EVENT(ufshcd_exception_event,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev_name, dev_name);
+		__assign_str(dev_name);
 		__entry->status =3D status;
 	),
=20
diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqu=
eue.h
index 6ef5b7254070..b0de2bc9ed52 100644
--- a/include/trace/events/workqueue.h
+++ b/include/trace/events/workqueue.h
@@ -38,7 +38,7 @@ TRACE_EVENT(workqueue_queue_work,
 	TP_fast_assign(
 		__entry->work		=3D work;
 		__entry->function	=3D work->func;
-		__assign_str(workqueue, pwq->wq->name);
+		__assign_str(workqueue);
 		__entry->req_cpu	=3D req_cpu;
 		__entry->cpu		=3D pwq->pool->cpu;
 	),
diff --git a/include/trace/events/xdp.h b/include/trace/events/xdp.h
index 9adc2bdf2f94..a7e5452b5d21 100644
--- a/include/trace/events/xdp.h
+++ b/include/trace/events/xdp.h
@@ -416,7 +416,7 @@ TRACE_EVENT(bpf_xdp_link_attach_failed,
 	),
=20
 	TP_fast_assign(
-		__assign_str(msg, msg);
+		__assign_str(msg);
 	),
=20
 	TP_printk("errmsg=3D%s", __get_str(msg))
diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/s=
tages/stage6_event_callback.h
index 3690e677263f..1691676fd858 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -31,12 +31,10 @@
 #define __vstring(item, fmt, ap) __dynamic_array(char, item, -1)
=20
 #undef __assign_str
-#define __assign_str(dst, src)						\
+#define __assign_str(dst)						\
 	do {								\
 		char *__str__ =3D __get_str(dst);				\
 		int __len__ =3D __get_dynamic_array_len(dst) - 1;		\
-		WARN_ON_ONCE(!(void *)(src) !=3D !(void *)__data_offsets.dst##_ptr_); \
-		WARN_ON_ONCE((src) && strcmp((src), __data_offsets.dst##_ptr_)); \
 		memcpy(__str__, __data_offsets.dst##_ptr_ ? :		\
 		       EVENT_NULL_STR, __len__);			\
 		__str__[__len__] =3D '\0';				\
diff --git a/kernel/trace/bpf_trace.h b/kernel/trace/bpf_trace.h
index 9acbc11ac7bb..c4075b56becc 100644
--- a/kernel/trace/bpf_trace.h
+++ b/kernel/trace/bpf_trace.h
@@ -19,7 +19,7 @@ TRACE_EVENT(bpf_trace_printk,
 	),
=20
 	TP_fast_assign(
-		__assign_str(bpf_string, bpf_string);
+		__assign_str(bpf_string);
 	),
=20
 	TP_printk("%s", __get_str(bpf_string))
diff --git a/net/batman-adv/trace.h b/net/batman-adv/trace.h
index 5dd52bc5cabb..6b816cf1a953 100644
--- a/net/batman-adv/trace.h
+++ b/net/batman-adv/trace.h
@@ -40,8 +40,8 @@ TRACE_EVENT(batadv_dbg,
 	    ),
=20
 	    TP_fast_assign(
-		    __assign_str(device, bat_priv->soft_iface->name);
-		    __assign_str(driver, KBUILD_MODNAME);
+		    __assign_str(device);
+		    __assign_str(driver);
 		    __assign_vstr(msg, vaf->fmt, vaf->va);
 	    ),
=20
diff --git a/net/dsa/trace.h b/net/dsa/trace.h
index 567f29a39707..83f3e5f78491 100644
--- a/net/dsa/trace.h
+++ b/net/dsa/trace.h
@@ -39,8 +39,8 @@ DECLARE_EVENT_CLASS(dsa_port_addr_op_hw,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev, dev_name(dp->ds->dev));
-		__assign_str(kind, dsa_port_kind(dp));
+		__assign_str(dev);
+		__assign_str(kind);
 		__entry->port =3D dp->index;
 		ether_addr_copy(__entry->addr, addr);
 		__entry->vid =3D vid;
@@ -98,8 +98,8 @@ DECLARE_EVENT_CLASS(dsa_port_addr_op_refcount,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev, dev_name(dp->ds->dev));
-		__assign_str(kind, dsa_port_kind(dp));
+		__assign_str(dev);
+		__assign_str(kind);
 		__entry->port =3D dp->index;
 		ether_addr_copy(__entry->addr, addr);
 		__entry->vid =3D vid;
@@ -157,8 +157,8 @@ DECLARE_EVENT_CLASS(dsa_port_addr_del_not_found,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev, dev_name(dp->ds->dev));
-		__assign_str(kind, dsa_port_kind(dp));
+		__assign_str(dev);
+		__assign_str(kind);
 		__entry->port =3D dp->index;
 		ether_addr_copy(__entry->addr, addr);
 		__entry->vid =3D vid;
@@ -199,7 +199,7 @@ TRACE_EVENT(dsa_lag_fdb_add_hw,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev, lag_dev->name);
+		__assign_str(dev);
 		ether_addr_copy(__entry->addr, addr);
 		__entry->vid =3D vid;
 		dsa_db_print(db, __entry->db_buf);
@@ -227,7 +227,7 @@ TRACE_EVENT(dsa_lag_fdb_add_bump,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev, lag_dev->name);
+		__assign_str(dev);
 		ether_addr_copy(__entry->addr, addr);
 		__entry->vid =3D vid;
 		dsa_db_print(db, __entry->db_buf);
@@ -255,7 +255,7 @@ TRACE_EVENT(dsa_lag_fdb_del_hw,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev, lag_dev->name);
+		__assign_str(dev);
 		ether_addr_copy(__entry->addr, addr);
 		__entry->vid =3D vid;
 		dsa_db_print(db, __entry->db_buf);
@@ -283,7 +283,7 @@ TRACE_EVENT(dsa_lag_fdb_del_drop,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev, lag_dev->name);
+		__assign_str(dev);
 		ether_addr_copy(__entry->addr, addr);
 		__entry->vid =3D vid;
 		dsa_db_print(db, __entry->db_buf);
@@ -310,7 +310,7 @@ TRACE_EVENT(dsa_lag_fdb_del_not_found,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev, lag_dev->name);
+		__assign_str(dev);
 		ether_addr_copy(__entry->addr, addr);
 		__entry->vid =3D vid;
 		dsa_db_print(db, __entry->db_buf);
@@ -338,8 +338,8 @@ DECLARE_EVENT_CLASS(dsa_vlan_op_hw,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev, dev_name(dp->ds->dev));
-		__assign_str(kind, dsa_port_kind(dp));
+		__assign_str(dev);
+		__assign_str(kind);
 		__entry->port =3D dp->index;
 		__entry->vid =3D vlan->vid;
 		__entry->flags =3D vlan->flags;
@@ -383,8 +383,8 @@ DECLARE_EVENT_CLASS(dsa_vlan_op_refcount,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev, dev_name(dp->ds->dev));
-		__assign_str(kind, dsa_port_kind(dp));
+		__assign_str(dev);
+		__assign_str(kind);
 		__entry->port =3D dp->index;
 		__entry->vid =3D vlan->vid;
 		__entry->flags =3D vlan->flags;
@@ -426,8 +426,8 @@ TRACE_EVENT(dsa_vlan_del_not_found,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev, dev_name(dp->ds->dev));
-		__assign_str(kind, dsa_port_kind(dp));
+		__assign_str(dev);
+		__assign_str(kind);
 		__entry->port =3D dp->index;
 		__entry->vid =3D vlan->vid;
 	),
diff --git a/net/ieee802154/trace.h b/net/ieee802154/trace.h
index 62aa6465253a..591ce0a16fc0 100644
--- a/net/ieee802154/trace.h
+++ b/net/ieee802154/trace.h
@@ -75,7 +75,7 @@ TRACE_EVENT(802154_rdev_add_virtual_intf,
 	),
 	TP_fast_assign(
 		WPAN_PHY_ASSIGN;
-		__assign_str(vir_intf_name, name ? name : "<noname>");
+		__assign_str(vir_intf_name);
 		__entry->type =3D type;
 		__entry->extended_addr =3D extended_addr;
 	),
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 8e758b5074bd..b26aacfbc622 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -33,7 +33,7 @@
 			__string(vif_name, sdata->name)
 #define VIF_ASSIGN	__entry->vif_type =3D sdata->vif.type; __entry->sdata =
=3D sdata;	\
 			__entry->p2p =3D sdata->vif.p2p;					\
-			__assign_str(vif_name, sdata->name)
+			__assign_str(vif_name)
 #define VIF_PR_FMT	" vif:%s(%d%s)"
 #define VIF_PR_ARG	__get_str(vif_name), __entry->vif_type, __entry->p2p ? =
"/p2p" : ""
=20
diff --git a/net/openvswitch/openvswitch_trace.h b/net/openvswitch/openvswi=
tch_trace.h
index 3eb35d9eb700..74d75aaebef4 100644
--- a/net/openvswitch/openvswitch_trace.h
+++ b/net/openvswitch/openvswitch_trace.h
@@ -43,8 +43,8 @@ TRACE_EVENT(ovs_do_execute_action,
=20
 	TP_fast_assign(
 		__entry->dpaddr =3D dp;
-		__assign_str(dp_name, ovs_dp_name(dp));
-		__assign_str(dev_name, skb->dev->name);
+		__assign_str(dp_name);
+		__assign_str(dev_name);
 		__entry->skbaddr =3D skb;
 		__entry->len =3D skb->len;
 		__entry->data_len =3D skb->data_len;
@@ -113,8 +113,8 @@ TRACE_EVENT(ovs_dp_upcall,
=20
 	TP_fast_assign(
 		__entry->dpaddr =3D dp;
-		__assign_str(dp_name, ovs_dp_name(dp));
-		__assign_str(dev_name, skb->dev->name);
+		__assign_str(dp_name);
+		__assign_str(dev_name);
 		__entry->skbaddr =3D skb;
 		__entry->len =3D skb->len;
 		__entry->data_len =3D skb->data_len;
diff --git a/net/smc/smc_tracepoint.h b/net/smc/smc_tracepoint.h
index 9fc5e586d24a..a9a6e3c1113a 100644
--- a/net/smc/smc_tracepoint.h
+++ b/net/smc/smc_tracepoint.h
@@ -60,7 +60,7 @@ DECLARE_EVENT_CLASS(smc_msg_event,
 				   __entry->smc =3D smc;
 				   __entry->net_cookie =3D sock_net(sk)->net_cookie;
 				   __entry->len =3D len;
-				   __assign_str(name, smc->conn.lnk->ibname);
+				   __assign_str(name);
 		    ),
=20
 		    TP_printk("smc=3D%p net=3D%llu len=3D%zu dev=3D%s",
@@ -104,7 +104,7 @@ TRACE_EVENT(smcr_link_down,
 			   __entry->lgr =3D lgr;
 			   __entry->net_cookie =3D lgr->net->net_cookie;
 			   __entry->state =3D lnk->state;
-			   __assign_str(name, lnk->ibname);
+			   __assign_str(name);
 			   __entry->location =3D location;
 	    ),
=20
diff --git a/net/tipc/trace.h b/net/tipc/trace.h
index 04af83f0500c..865142ed0ab4 100644
--- a/net/tipc/trace.h
+++ b/net/tipc/trace.h
@@ -145,7 +145,7 @@ DECLARE_EVENT_CLASS(tipc_skb_class,
 	),
=20
 	TP_fast_assign(
-		__assign_str(header, header);
+		__assign_str(header);
 		tipc_skb_dump(skb, more, __get_str(buf));
 	),
=20
@@ -172,7 +172,7 @@ DECLARE_EVENT_CLASS(tipc_list_class,
 	),
=20
 	TP_fast_assign(
-		__assign_str(header, header);
+		__assign_str(header);
 		tipc_list_dump(list, more, __get_str(buf));
 	),
=20
@@ -200,7 +200,7 @@ DECLARE_EVENT_CLASS(tipc_sk_class,
 	),
=20
 	TP_fast_assign(
-		__assign_str(header, header);
+		__assign_str(header);
 		__entry->portid =3D tipc_sock_get_portid(sk);
 		tipc_sk_dump(sk, dqueues, __get_str(buf));
 		if (skb)
@@ -254,7 +254,7 @@ DECLARE_EVENT_CLASS(tipc_link_class,
 	),
=20
 	TP_fast_assign(
-		__assign_str(header, header);
+		__assign_str(header);
 		memcpy(__entry->name, tipc_link_name(l), TIPC_MAX_LINK_NAME);
 		tipc_link_dump(l, dqueues, __get_str(buf));
 	),
@@ -337,7 +337,7 @@ DECLARE_EVENT_CLASS(tipc_node_class,
 	),
=20
 	TP_fast_assign(
-		__assign_str(header, header);
+		__assign_str(header);
 		__entry->addr =3D tipc_node_get_addr(n);
 		tipc_node_dump(n, more, __get_str(buf));
 	),
@@ -374,7 +374,7 @@ DECLARE_EVENT_CLASS(tipc_fsm_class,
 	),
=20
 	TP_fast_assign(
-		__assign_str(name, name);
+		__assign_str(name);
 		__entry->os =3D os;
 		__entry->ns =3D ns;
 		__entry->evt =3D evt;
@@ -409,8 +409,8 @@ TRACE_EVENT(tipc_l2_device_event,
 	),
=20
 	TP_fast_assign(
-		__assign_str(dev_name, dev->name);
-		__assign_str(b_name, b->name);
+		__assign_str(dev_name);
+		__assign_str(b_name);
 		__entry->evt =3D evt;
 		__entry->b_up =3D test_bit(0, &b->up);
 		__entry->carrier =3D netif_carrier_ok(dev);
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 9bf987519811..87986170d1b1 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -372,7 +372,7 @@ TRACE_EVENT(rdev_add_virtual_intf,
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
-		__assign_str(vir_intf_name, name ? name : "<noname>");
+		__assign_str(vir_intf_name);
 		__entry->type =3D type;
 	),
 	TP_printk(WIPHY_PR_FMT ", virtual intf name: %s, type: %d",
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_eve=
nts/trace-events-sample.h
index 500981eca74d..55f9a3da92d5 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -136,10 +136,11 @@
  *
  *         To assign a string, use the helper macro __assign_str().
  *
- *         __assign_str(foo, bar);
+ *         __assign_str(foo);
  *
- *         In most cases, the __assign_str() macro will take the same
- *         parameters as the __string() macro had to declare the string.
+ *	   The __string() macro saves off the string that is passed into
+ *         the second parameter, and the __assign_str() will store than
+ *         saved string into the "foo" field.
  *
  *   __vstring: This is similar to __string() but instead of taking a
  *         dynamic length, it takes a variable list va_list 'va' variable.
@@ -177,7 +178,7 @@
  *         The length is saved via the __string_len() and is retrieved in
  *         __assign_str().
  *
- *         __assign_str(foo, bar);
+ *         __assign_str(foo);
  *
  *         Then len + 1 is allocated to the ring buffer, and a nul termina=
ting
  *         byte is added. This is similar to:
@@ -311,8 +312,8 @@ TRACE_EVENT(foo_bar,
 		__entry->bar	=3D bar;
 		memcpy(__get_dynamic_array(list), lst,
 		       __length_of(lst) * sizeof(int));
-		__assign_str(str, string);
-		__assign_str(lstr, foo);
+		__assign_str(str);
+		__assign_str(lstr);
 		__assign_vstr(vstr, fmt, va);
 		__assign_bitmask(cpus, cpumask_bits(mask), num_possible_cpus());
 		__assign_cpumask(cpum, cpumask_bits(mask));
@@ -418,7 +419,7 @@ TRACE_EVENT_CONDITION(foo_bar_with_cond,
 	),
=20
 	TP_fast_assign(
-		__assign_str(foo, foo);
+		__assign_str(foo);
 		__entry->bar	=3D bar;
 	),
=20
@@ -459,7 +460,7 @@ TRACE_EVENT_FN(foo_bar_with_fn,
 	),
=20
 	TP_fast_assign(
-		__assign_str(foo, foo);
+		__assign_str(foo);
 		__entry->bar	=3D bar;
 	),
=20
@@ -506,7 +507,7 @@ DECLARE_EVENT_CLASS(foo_template,
 	),
=20
 	TP_fast_assign(
-		__assign_str(foo, foo);
+		__assign_str(foo);
 		__entry->bar	=3D bar;
 	),
=20
diff --git a/sound/core/pcm_trace.h b/sound/core/pcm_trace.h
index 350b40b906ca..adb9b1f3bbfa 100644
--- a/sound/core/pcm_trace.h
+++ b/sound/core/pcm_trace.h
@@ -95,7 +95,7 @@ TRACE_EVENT(hw_ptr_error,
 		__entry->device =3D (substream)->pcm->device;
 		__entry->number =3D (substream)->number;
 		__entry->stream =3D (substream)->stream;
-		__assign_str(reason, why);
+		__assign_str(reason);
 	),
 	TP_printk("pcmC%dD%d%s/sub%d: ERROR: %s",
 		  __entry->card, __entry->device,
diff --git a/sound/hda/trace.h b/sound/hda/trace.h
index 2cc493434a8f..280c42f3eb75 100644
--- a/sound/hda/trace.h
+++ b/sound/hda/trace.h
@@ -24,7 +24,7 @@ TRACE_EVENT(hda_send_cmd,
 		__field(u32, cmd)
 	),
 	TP_fast_assign(
-		__assign_str(name, dev_name((bus)->dev));
+		__assign_str(name);
 		__entry->cmd =3D cmd;
 	),
 	TP_printk("[%s:%d] val=3D0x%08x", __get_str(name), __entry->cmd >> 28, __=
entry->cmd)
@@ -39,7 +39,7 @@ TRACE_EVENT(hda_get_response,
 		__field(u32, res)
 	),
 	TP_fast_assign(
-		__assign_str(name, dev_name((bus)->dev));
+		__assign_str(name);
 		__entry->addr =3D addr;
 		__entry->res =3D res;
 	),
@@ -55,7 +55,7 @@ TRACE_EVENT(hda_unsol_event,
 		__field(u32, res_ex)
 	),
 	TP_fast_assign(
-		__assign_str(name, dev_name((bus)->dev));
+		__assign_str(name);
 		__entry->res =3D res;
 		__entry->res_ex =3D res_ex;
 	),
diff --git a/sound/soc/intel/avs/trace.h b/sound/soc/intel/avs/trace.h
index 855b06bb14b0..c9eaa5a60ed3 100644
--- a/sound/soc/intel/avs/trace.h
+++ b/sound/soc/intel/avs/trace.h
@@ -24,7 +24,7 @@ TRACE_EVENT(avs_dsp_core_op,
 	TP_fast_assign(
 		__entry->reg =3D reg;
 		__entry->mask =3D mask;
-		__assign_str(op, op);
+		__assign_str(op);
 		__entry->flag =3D flag;
 	),
=20
@@ -135,7 +135,7 @@ TRACE_EVENT(avs_d0ix,
 	),
=20
 	TP_fast_assign(
-		__assign_str(op, op);
+		__assign_str(op);
 		__entry->proceed =3D proceed;
 		__entry->header =3D header;
 	),

