Return-Path: <linux-kernel+bounces-556745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C86A5CE14
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA487A54F1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8F9263C8B;
	Tue, 11 Mar 2025 18:41:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315E6265607
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718466; cv=none; b=Yb1qhvH7cxJVEujiMLy5IWjgSaa2pgDz7hjBuMrBjYVVsRfXlTOD+zzMFLCQxVXIO7sPKRRm2i6lQAUL18aWU6HFHlXLr17yQ1KGMuxjk7fMUqw8s7mDyQdnObKGwLX4dopfBeFei8vyzmrfDmxGazz4ZfIt4A0jc0JW5COO0j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718466; c=relaxed/simple;
	bh=WRvNjBYZAwW+LCLMPw/GAZCNoSYgLJpWTWgNCfzCwK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AurW3sLCrf8aHD7tLaz+ss2r8WR0gfg7RXrvwoDLvW9JRzuJ9GJjvaq7aw01q5PG9Ti8mmGIhkH4jjgFOZ80sKupZrwOsyYxOCr0FSfUvm+Xa5zsBt7RbYbwKPpdKUlDl6gK595DBi8lKRRTB12IqLwso+893gMyK8fxZ2xig14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F6BE1515;
	Tue, 11 Mar 2025 11:41:15 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 079253F694;
	Tue, 11 Mar 2025 11:41:00 -0700 (PDT)
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
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Babu Moger <babu.moger@amd.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v8:for-boris 15/30] x86/resctrl: Move monitor exit work to a resctrl exit call
Date: Tue, 11 Mar 2025 18:37:00 +0000
Message-Id: <20250311183715.16445-16-james.morse@arm.com>
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

rdt_put_mon_l3_config() is called via the architecture's
resctrl_arch_exit() call, and appears to free the rmid_ptrs[]
and closid_num_dirty_rmid[] arrays. In reality this code is marked
__exit, and is removed by the linker as resctrl can't be built
as a module.

To separate the filesystem and architecture parts of resctrl,
this free()ing work needs to be triggered by the filesystem,
as these structures belong to the filesystem code.

Rename rdt_put_mon_l3_config() resctrl_mon_resource_exit()
and call it from resctrl_exit(). The kfree() is currently
dependent on r->mon_capable.

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
Changes since v4:
 * Added __exit so it can be removed in the next patch.

Changes since v3:
 * Moved r->mon_capable check under the lock.
 * Dropped references to resctrl_mon_resource_init() from the commit message.
 * Fixed more resctrl typos,

Changes since v2:
 * Dropped __exit as needed in the next patch.

Change since v1:
 * [Commit message only] Typo fixes:
   s/restrl/resctrl/g
   s/resctl/resctrl/g

 * [Commit message only] Reword second paragraph to remove reference to
   the MPAM error interrupt, which provides background rationale for a
   later patch rather than for this patch, and so it is not really
   relevant here.
---
 arch/x86/kernel/cpu/resctrl/core.c     |  5 -----
 arch/x86/kernel/cpu/resctrl/internal.h |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 12 +++++++++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 ++
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 850cb8643c4a..a1577bdd3c90 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -1074,14 +1074,9 @@ late_initcall(resctrl_arch_late_init);
 
 static void __exit resctrl_arch_exit(void)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-
 	cpuhp_remove_state(rdt_online);
 
 	resctrl_exit();
-
-	if (r->mon_capable)
-		rdt_put_mon_l3_config();
 }
 
 __exitcall(resctrl_arch_exit);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 5f3713fb2eaf..73005ca2dda1 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -586,7 +586,7 @@ void closid_free(int closid);
 int alloc_rmid(u32 closid);
 void free_rmid(u32 closid, u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
-void __exit rdt_put_mon_l3_config(void);
+void __exit resctrl_mon_resource_exit(void);
 bool __init rdt_cpu_has(int flag);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index e8388d19a579..15e8c0190bfc 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1040,10 +1040,13 @@ static int dom_data_init(struct rdt_resource *r)
 	return err;
 }
 
-static void __exit dom_data_exit(void)
+static void __exit dom_data_exit(struct rdt_resource *r)
 {
 	mutex_lock(&rdtgroup_mutex);
 
+	if (!r->mon_capable)
+		goto out_unlock;
+
 	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
 		kfree(closid_num_dirty_rmid);
 		closid_num_dirty_rmid = NULL;
@@ -1052,6 +1055,7 @@ static void __exit dom_data_exit(void)
 	kfree(rmid_ptrs);
 	rmid_ptrs = NULL;
 
+out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
 }
 
@@ -1237,9 +1241,11 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	return 0;
 }
 
-void __exit rdt_put_mon_l3_config(void)
+void __exit resctrl_mon_resource_exit(void)
 {
-	dom_data_exit();
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
+
+	dom_data_exit(r);
 }
 
 void __init intel_rdt_mbm_apply_quirk(void)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 9eb57ebb36c6..42c48e79364d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4296,4 +4296,6 @@ void __exit resctrl_exit(void)
 	debugfs_remove_recursive(debugfs_resctrl);
 	unregister_filesystem(&rdt_fs_type);
 	sysfs_remove_mount_point(fs_kobj, "resctrl");
+
+	resctrl_mon_resource_exit();
 }
-- 
2.39.5


