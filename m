Return-Path: <linux-kernel+bounces-556739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B24A5CE0D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239E617D0F9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0802641C0;
	Tue, 11 Mar 2025 18:40:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA65826461F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718445; cv=none; b=YLZsyKwvbfCezs9zpujoJctNhPr+z5zMvEBl/sjZatJxextOHGb5XbqlqOdfrYeG0awWXvkCJEuPvD49cDSFm68H5D3nZz0ihsmCYoNz+osEx7nAV5uzWA6En3Km8XsDsQO9oUwFkKUN5EUH15XLbf2x1vqxEQVdNUkKisV2Dak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718445; c=relaxed/simple;
	bh=Jh41fY980JaH64LJxqAWQCuuK+qdnu0szatxbJBEOJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B7HGAae+3iqDqygbadf9LZTdMIrnH0uYjzOxYiDNxjHVMh+FxIU/FKo87j8lR4eWQD0//imn92nM9jt8jjPhosfxDNTrZWz5IjSQSjhEBQw8tred1PzLM0iETXRyNdY9j21GUeGstx1/05gSyQYvZpW6biNk210K/eom/4xAS90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D6381515;
	Tue, 11 Mar 2025 11:40:53 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69E593F694;
	Tue, 11 Mar 2025 11:40:38 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	fenghuay@nvidia.com,
	Dave Martin <Dave.Martin@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Babu Moger <babu.moger@amd.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v8:for-boris 09/30] x86/resctrl: Add helper for setting CPU default properties
Date: Tue, 11 Mar 2025 18:36:54 +0000
Message-Id: <20250311183715.16445-10-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250311183715.16445-1-james.morse@arm.com>
References: <20250311183715.16445-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rdtgroup_rmdir_ctrl() and rdtgroup_rmdir_mon() set the per-CPU
pqr_state for CPUs that were part of the rmdir()'d group.

Another architecture might not have a 'pqr_state', its hardware may
need the values in a different format. MPAM's equivalent of RMID values
are not unique, and always need the CLOSID to be provided too.

There is only one caller that modifies a single value,
(rdtgroup_rmdir_mon()). MPAM always needs both CLOSID and RMID
for the hardware value as these are written to the same system
register.

As rdtgroup_rmdir_mon() has the CLOSID on hand, only provide a
helper to set both values. These values are read by
__resctrl_sched_in(), but may be written by a different CPU without
any locking, add READ/WRTE_ONCE() to avoid torn values.

Co-developed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
---
Changes since v1:
 * In rdtgroup_rmdir_mon(), (re)set CPU default closid based on the
   parent control group, to avoid the appearance of referencing
   something that we're in the process of destroying (even if it
   doesn't make a difference because the victim mon group necessarily
   has the same closid as the parent control group).

   Update comment to match.

   No (intentional) functional change.
---
 arch/x86/include/asm/resctrl.h         | 14 +++++++++++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 20 ++++++++++++++------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 8b1b6ce1e51b..6908cd0e6e40 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -4,8 +4,9 @@
 
 #ifdef CONFIG_X86_CPU_RESCTRL
 
-#include <linux/sched.h>
 #include <linux/jump_label.h>
+#include <linux/percpu.h>
+#include <linux/sched.h>
 
 /*
  * This value can never be a valid CLOSID, and is used when mapping a
@@ -96,8 +97,8 @@ static inline void resctrl_arch_disable_mon(void)
 static inline void __resctrl_sched_in(struct task_struct *tsk)
 {
 	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
-	u32 closid = state->default_closid;
-	u32 rmid = state->default_rmid;
+	u32 closid = READ_ONCE(state->default_closid);
+	u32 rmid = READ_ONCE(state->default_rmid);
 	u32 tmp;
 
 	/*
@@ -132,6 +133,13 @@ static inline unsigned int resctrl_arch_round_mon_val(unsigned int val)
 	return val * scale;
 }
 
+static inline void resctrl_arch_set_cpu_default_closid_rmid(int cpu, u32 closid,
+							    u32 rmid)
+{
+	WRITE_ONCE(per_cpu(pqr_state.default_closid, cpu), closid);
+	WRITE_ONCE(per_cpu(pqr_state.default_rmid, cpu), rmid);
+}
+
 static inline void resctrl_arch_set_closid_rmid(struct task_struct *tsk,
 						u32 closid, u32 rmid)
 {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index cd8f65c12124..f706e5a288b1 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3731,14 +3731,21 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
 static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 {
 	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
+	u32 closid, rmid;
 	int cpu;
 
 	/* Give any tasks back to the parent group */
 	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
 
-	/* Update per cpu rmid of the moved CPUs first */
+	/*
+	 * Update per cpu closid/rmid of the moved CPUs first.
+	 * Note: the closid will not change, but the arch code still needs it.
+	 */
+	closid = prdtgrp->closid;
+	rmid = prdtgrp->mon.rmid;
 	for_each_cpu(cpu, &rdtgrp->cpu_mask)
-		per_cpu(pqr_state.default_rmid, cpu) = prdtgrp->mon.rmid;
+		resctrl_arch_set_cpu_default_closid_rmid(cpu, closid, rmid);
+
 	/*
 	 * Update the MSR on moved CPUs and CPUs which have moved
 	 * task running on them.
@@ -3771,6 +3778,7 @@ static int rdtgroup_ctrl_remove(struct rdtgroup *rdtgrp)
 
 static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 {
+	u32 closid, rmid;
 	int cpu;
 
 	/* Give any tasks back to the default group */
@@ -3781,10 +3789,10 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 		   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
 
 	/* Update per cpu closid and rmid of the moved CPUs first */
-	for_each_cpu(cpu, &rdtgrp->cpu_mask) {
-		per_cpu(pqr_state.default_closid, cpu) = rdtgroup_default.closid;
-		per_cpu(pqr_state.default_rmid, cpu) = rdtgroup_default.mon.rmid;
-	}
+	closid = rdtgroup_default.closid;
+	rmid = rdtgroup_default.mon.rmid;
+	for_each_cpu(cpu, &rdtgrp->cpu_mask)
+		resctrl_arch_set_cpu_default_closid_rmid(cpu, closid, rmid);
 
 	/*
 	 * Update the MSR on moved CPUs and CPUs which have moved
-- 
2.39.5


