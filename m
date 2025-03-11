Return-Path: <linux-kernel+bounces-556740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBB6A5CE0F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245C2189FA11
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF47B264A83;
	Tue, 11 Mar 2025 18:40:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E58E264A74
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718448; cv=none; b=RFjWx0lo2WrO1A1AwMf+8mQEk/smWDX/f4mIpxjWdYqQy+iehfbxAhw4d1Ez5olbHBRSQyCb0ZD0yI8H2ffaLWJh54m1Cr4Pd4hZWaqwwRlwFDs2JFy964HzBBTXbnlwFyDnmLhspH83I5hG5Rir+PV6TAO9atjuPNPU2uwo4s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718448; c=relaxed/simple;
	bh=WIQme66ci33sDbcxxZgeKYMrkYE5Xa/hLcK+MnQWC1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lIbjv4muPQNz1lY2lwy7wRn/cdgC+rao5Mq/DWhwS0JwoSUcF51/49WEfyPTe2O33tHE7+pZ2w6Td4QrO9NOKLNmjqyAAc77F3XfAaI/YCPx5XiSJWEI+I9PpoAiXPprSj1qxqMOYRBGsfp5CFKJknX4A6U3Yo6BNq8tX6xCcZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D98191713;
	Tue, 11 Mar 2025 11:40:56 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 440D83F694;
	Tue, 11 Mar 2025 11:40:42 -0700 (PDT)
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
Subject: [PATCH v8:for-boris 10/30] x86/resctrl: Remove rdtgroup from update_cpu_closid_rmid()
Date: Tue, 11 Mar 2025 18:36:55 +0000
Message-Id: <20250311183715.16445-11-james.morse@arm.com>
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

update_cpu_closid_rmid() takes a struct rdtgroup as an argument, which
it uses to update the local CPUs default pqr values. This is a problem
once the resctrl parts move out to /fs/, as the arch code cannot
poke around inside struct rdtgroup.

Rename update_cpu_closid_rmid() as resctrl_arch_sync_cpus_defaults()
to be used as the target of an IPI, and pass the effective CLOSID
and RMID in a new struct.

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
 * To clarify the meanings of the new helper and struct:

   Rename resctrl_arch_sync_cpu_default() to
   resctrl_arch_sync_cpu_closid_rmid();

   Rename struct resctrl_cpu_sync to struct resctrl_cpu_defaults;

   Flesh out the comment block in <linux/resctrl.h>.

   No functional change.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 +++++++++++++----
 include/linux/resctrl.h                | 22 ++++++++++++++++++++++
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f706e5a288b1..62d9a50c7bba 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -355,13 +355,13 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
  * from update_closid_rmid() is protected against __switch_to() because
  * preemption is disabled.
  */
-static void update_cpu_closid_rmid(void *info)
+void resctrl_arch_sync_cpu_closid_rmid(void *info)
 {
-	struct rdtgroup *r = info;
+	struct resctrl_cpu_defaults *r = info;
 
 	if (r) {
 		this_cpu_write(pqr_state.default_closid, r->closid);
-		this_cpu_write(pqr_state.default_rmid, r->mon.rmid);
+		this_cpu_write(pqr_state.default_rmid, r->rmid);
 	}
 
 	/*
@@ -376,11 +376,20 @@ static void update_cpu_closid_rmid(void *info)
  * Update the PGR_ASSOC MSR on all cpus in @cpu_mask,
  *
  * Per task closids/rmids must have been set up before calling this function.
+ * @r may be NULL.
  */
 static void
 update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)
 {
-	on_each_cpu_mask(cpu_mask, update_cpu_closid_rmid, r, 1);
+	struct resctrl_cpu_defaults defaults, *p = NULL;
+
+	if (r) {
+		defaults.closid = r->closid;
+		defaults.rmid = r->mon.rmid;
+		p = &defaults;
+	}
+
+	on_each_cpu_mask(cpu_mask, resctrl_arch_sync_cpu_closid_rmid, p, 1);
 }
 
 static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index d16dc960f1fc..31808b3ddecb 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -266,6 +266,28 @@ struct resctrl_schema {
 	u32				num_closid;
 };
 
+struct resctrl_cpu_defaults {
+	u32 closid;
+	u32 rmid;
+};
+
+/**
+ * resctrl_arch_sync_cpu_closid_rmid() - Refresh this CPU's CLOSID and RMID.
+ *					 Call via IPI.
+ * @info:	If non-NULL, a pointer to a struct resctrl_cpu_defaults
+ *		specifying the new CLOSID and RMID for tasks in the default
+ *		resctrl ctrl and mon group when running on this CPU.  If NULL,
+ *		this CPU is not re-assigned to a different default group.
+ *
+ * Propagates reassignment of CPUs and/or tasks to different resctrl groups
+ * when requested by the resctrl core code.
+ *
+ * This function records the per-cpu defaults specified by @info (if any),
+ * and then reconfigures the CPU's hardware CLOSID and RMID for subsequent
+ * execution based on @current, in the same way as during a task switch.
+ */
+void resctrl_arch_sync_cpu_closid_rmid(void *info);
+
 /**
  * resctrl_get_default_ctrl() - Return the default control value for this
  *                              resource.
-- 
2.39.5


