Return-Path: <linux-kernel+bounces-272909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A14946277
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14BEA2813C2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A481A83AC;
	Fri,  2 Aug 2024 17:30:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB081A83A3
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619826; cv=none; b=Dxr9jfJP+/pW0ABa1FKII1pE4ucntXvA2w5PXv7dl64wrEWEAMh1yesHw37v8L2ya7bZJAZWL8Ggu9G6hHPp9zWZN0VNepO0rEC2JNGwg9hAkBRFfltaks2p2kAR4Xn8M45YbQv/fwg1x3WTpJfSKpzkmwKPIpqAAF4525jQejs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619826; c=relaxed/simple;
	bh=wIVHRPqx5xcey0OLzsNBGN1WgD5Cw5C4mr98PRSg5nw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IfgCvaz7lnbXMhvSmfwsIZHR6DATguM+gF8HMqW4fwwMOkOWpTsnjQUpXdTcQwQJRDyHTwhZ1M/5olrzYAbeAjq7ZuzUqCo8Es1ehAqzaTQKwUWKLNLWTql5h3LafA3u0FYl3akGZtR8rp2QxyXS4heSW0faXoMNyhyLdEr7h5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51C371042;
	Fri,  2 Aug 2024 10:30:50 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED61C3F64C;
	Fri,  2 Aug 2024 10:30:20 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
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
	Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v4 10/39] x86/resctrl: Remove rdtgroup from update_cpu_closid_rmid()
Date: Fri,  2 Aug 2024 17:28:24 +0000
Message-Id: <20240802172853.22529-11-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240802172853.22529-1-james.morse@arm.com>
References: <20240802172853.22529-1-james.morse@arm.com>
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
index 520227455f76..8d2de597bdf6 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -346,13 +346,13 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
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
@@ -367,11 +367,20 @@ static void update_cpu_closid_rmid(void *info)
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
index 0eb9854bf94f..096621a8f69b 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -270,6 +270,28 @@ struct resctrl_schema {
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
2.39.2


