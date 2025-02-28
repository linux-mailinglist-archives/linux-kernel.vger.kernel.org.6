Return-Path: <linux-kernel+bounces-539345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 282EAA4A357
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E773B1577
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C7E281351;
	Fri, 28 Feb 2025 20:00:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FF0230BDB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772837; cv=none; b=P7FtP7DxHEOoNyN3a7aprMVZ8sgUNeT/T4Iz4Op2SKFBNJVkIVhNz40TTX9Pn4JQKF2eNzUz0aTlLKxGmA8yaXR5nwkyotKV58BcG9h67knwtWZK/Eln3tP2rPbpfE+YEaV9YiWGC65gpn7/l6GA9ex+9t7GsrssPFF+AXP0L/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772837; c=relaxed/simple;
	bh=v/LLx5tO2Nafvv2aG7ivRFSxF50EmPhnCxaiGCQnEW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IEgEo7wd59/8trVpf4Z5XglBEStXMECVXOOZimPnhSQ2cIKNSv5ZkXbCrXR1AQkFCF+fbaiRuDt9Pv9kZ7/1X2tRl0eDqgbwier4qu3TiH6JRp0hB8jEYLw3ghZJZ0fHb7TLJgSTHAyTEKzgEp19kewm+WpDILdt6rquDS2BoXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E5DE150C;
	Fri, 28 Feb 2025 12:00:50 -0800 (PST)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1398E3F5A1;
	Fri, 28 Feb 2025 12:00:31 -0800 (PST)
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
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v7 10/49] x86/resctrl: Remove rdtgroup from update_cpu_closid_rmid()
Date: Fri, 28 Feb 2025 19:58:34 +0000
Message-Id: <20250228195913.24895-11-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250228195913.24895-1-james.morse@arm.com>
References: <20250228195913.24895-1-james.morse@arm.com>
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
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
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


