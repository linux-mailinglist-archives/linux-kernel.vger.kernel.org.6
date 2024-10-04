Return-Path: <linux-kernel+bounces-350873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16233990A9E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B489A28644E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834F81DD88D;
	Fri,  4 Oct 2024 18:05:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816A91E3DEA
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065153; cv=none; b=sacFhEu+aPm1DopjB3dNxVUg9Cc4w+6W4+wsFTExxv5iMEMzoS4WVQDHsJAhjfb5H4DjyK/ya5U0SrqO4bFZ1mU4N9hbmJB3ixPCcVPCVLvsy0Q2VN4Mtg1idX1FJMRiMBCCkMRfFy064b1x4t3ELhw2fX+qAGaB7tpYgFHoC5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065153; c=relaxed/simple;
	bh=rL4JEuLgmAvlxlz7+HxscXdZzRh/zOFipn4bFye9Onw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YC3fq1zlkTdivYFHTbv8i8nGqwaTDmFs2o16zHNwOo7jwBOAG+YnO/LtVHm5azIRN5XPBkit2DSf11OV74hG8AYLcEGV0QQKNNu8h3Wbqa4UN+s3/Add9o2fjvYLdJQATpqOW5VrQWlFYxx0kqIj8m8nlT/MlhmS/w2kOxXLz2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9871D1063;
	Fri,  4 Oct 2024 11:06:20 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 003EA3F58B;
	Fri,  4 Oct 2024 11:05:47 -0700 (PDT)
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
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH v5 15/40] x86/resctrl: Move monitor exit work to a resctrl exit call
Date: Fri,  4 Oct 2024 18:03:22 +0000
Message-Id: <20241004180347.19985-16-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241004180347.19985-1-james.morse@arm.com>
References: <20241004180347.19985-1-james.morse@arm.com>
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
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
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
index fceb56697a4a..830607986c06 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -1105,14 +1105,9 @@ late_initcall(resctrl_arch_late_init);
 
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
index 35761fe8dbc1..84a5bc840a98 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -579,7 +579,7 @@ void closid_free(int closid);
 int alloc_rmid(u32 closid);
 void free_rmid(u32 closid, u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
-void __exit rdt_put_mon_l3_config(void);
+void __exit resctrl_mon_resource_exit(void);
 bool __init rdt_cpu_has(int flag);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 9cdca9d2bbde..d6e178be34ad 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1044,10 +1044,13 @@ static int dom_data_init(struct rdt_resource *r)
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
@@ -1056,6 +1059,7 @@ static void __exit dom_data_exit(void)
 	kfree(rmid_ptrs);
 	rmid_ptrs = NULL;
 
+out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
 }
 
@@ -1238,9 +1242,11 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
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
index a15198f90b29..6d5fe973cb92 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4283,4 +4283,6 @@ void __exit resctrl_exit(void)
 	debugfs_remove_recursive(debugfs_resctrl);
 	unregister_filesystem(&rdt_fs_type);
 	sysfs_remove_mount_point(fs_kobj, "resctrl");
+
+	resctrl_mon_resource_exit();
 }
-- 
2.39.2


