Return-Path: <linux-kernel+bounces-539351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218ABA4A35F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F99A189B980
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8479E2777E0;
	Fri, 28 Feb 2025 20:00:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC321F873D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772859; cv=none; b=Cp0Q0QRUc7SWtMqlOsQDNUDy4u80nKtNLwnIc7ZNg+EJpGy6+OgWzJYxWYMz5fUUtWYhbB8U1Ry7PYTUx4M6fKcGJPL6tIeKsl6iZPpK+u7MIK1Rg1lSawTARU5c3eOuG+e/IoYX1gj0AeQuJW/sQdsHi36Nd8ABBj8bLyaA/3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772859; c=relaxed/simple;
	bh=v8Ethm0JXoT3WhDoJTi3gML3zvy2vPSCbt+Q+z904Rg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gZBPb2KvCIpcq83u0YPg9eOphjM3R524GBa/IHJuuwgCnL2qxu9tVWDEBEHGSLt0wxW5XPHKIggukRox+7sQVkJr+YeCHb9mNJWJnHQDOLNam6R1mEBuuMYHLPBDkAW7xIEImGJssHs6Tf5ko54JOzKuGCisaeWik6oE+/rRYnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2691D176C;
	Fri, 28 Feb 2025 12:01:12 -0800 (PST)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA1A13F5A1;
	Fri, 28 Feb 2025 12:00:53 -0800 (PST)
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
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v7 16/49] x86/resctrl: Move monitor init work to a resctrl init call
Date: Fri, 28 Feb 2025 19:58:40 +0000
Message-Id: <20250228195913.24895-17-james.morse@arm.com>
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

rdt_get_mon_l3_config() is called from the architecture's
resctrl_arch_late_init(), and initialises both architecture specific
fields, such as hw_res->mon_scale and resctrl filesystem fields
by calling dom_data_init().

To separate the filesystem and architecture parts of resctrl, this
function needs splitting up.

Add resctrl_mon_resource_init() to do the filesystem specific work,
and call it from resctrl_init(). This runs later, but is still before
the filesystem is mounted and the rmid_ptrs[] array can be used.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since v4:
 * Removed __exit markers

Changes since v3:
 * Added a comment over resctrl_mon_resource_init().
 * Added a comment over domain_setup_mon_state() to warn of cpuhp ordering.
 * Added __init to resctrl_mon_resource_init().

Changes since v2:
 * Added error handling for the case sysfs files can't be created.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  3 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 40 ++++++++++++++++++++------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 22 +++++++++++++-
 3 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 73005ca2dda1..70fbb902e85e 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -586,13 +586,14 @@ void closid_free(int closid);
 int alloc_rmid(u32 closid);
 void free_rmid(u32 closid, u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
-void __exit resctrl_mon_resource_exit(void);
+void resctrl_mon_resource_exit(void);
 bool __init rdt_cpu_has(int flag);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
 		    cpumask_t *cpumask, int evtid, int first);
+int __init resctrl_mon_resource_init(void);
 void mbm_setup_overflow_handler(struct rdt_mon_domain *dom,
 				unsigned long delay_ms,
 				int exclude_cpu);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 15e8c0190bfc..1730ba814834 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1040,7 +1040,7 @@ static int dom_data_init(struct rdt_resource *r)
 	return err;
 }
 
-static void __exit dom_data_exit(struct rdt_resource *r)
+static void dom_data_exit(struct rdt_resource *r)
 {
 	mutex_lock(&rdtgroup_mutex);
 
@@ -1176,12 +1176,40 @@ static __init int snc_get_config(void)
 	return ret;
 }
 
+/**
+ * resctrl_mon_resource_init() - Initialise global monitoring structures.
+ *
+ * Allocate and initialise global monitor resources that do not belong to a
+ * specific domain. i.e. the rmid_ptrs[] used for the limbo and free lists.
+ * Called once during boot after the struct rdt_resource's have been configured
+ * but before the filesystem is mounted.
+ * Resctrl's cpuhp callbacks may be called before this point to bring a domain
+ * online.
+ *
+ * Returns 0 for success, or -ENOMEM.
+ */
+int __init resctrl_mon_resource_init(void)
+{
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
+	int ret;
+
+	if (!r->mon_capable)
+		return 0;
+
+	ret = dom_data_init(r);
+	if (ret)
+		return ret;
+
+	l3_mon_evt_init(r);
+
+	return 0;
+}
+
 int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 {
 	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	unsigned int threshold;
-	int ret;
 
 	snc_nodes_per_l3_cache = snc_get_config();
 
@@ -1211,10 +1239,6 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	 */
 	resctrl_rmid_realloc_threshold = resctrl_arch_round_mon_val(threshold);
 
-	ret = dom_data_init(r);
-	if (ret)
-		return ret;
-
 	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
 		u32 eax, ebx, ecx, edx;
 
@@ -1234,14 +1258,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		}
 	}
 
-	l3_mon_evt_init(r);
-
 	r->mon_capable = true;
 
 	return 0;
 }
 
-void __exit resctrl_mon_resource_exit(void)
+void resctrl_mon_resource_exit(void)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 42c48e79364d..badac3f5da72 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4102,6 +4102,19 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d
 	mutex_unlock(&rdtgroup_mutex);
 }
 
+/**
+ * domain_setup_mon_state() -  Initialise domain monitoring structures.
+ * @r:	The resource for the newly online domain.
+ * @d:	The newly online domain.
+ *
+ * Allocate monitor resources that belong to this domain.
+ * Called when the first CPU of a domain comes online, regardless of whether
+ * the filesystem is mounted.
+ * During boot this may be called before global allocations have been made by
+ * resctrl_mon_resource_init().
+ *
+ * Returns 0 for success, or -ENOMEM.
+ */
 static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mon_domain *d)
 {
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
@@ -4252,9 +4265,15 @@ int __init resctrl_init(void)
 
 	rdtgroup_setup_default();
 
+	ret = resctrl_mon_resource_init();
+	if (ret)
+		return ret;
+
 	ret = sysfs_create_mount_point(fs_kobj, "resctrl");
-	if (ret)
+	if (ret) {
+		resctrl_mon_resource_exit();
 		return ret;
+	}
 
 	ret = register_filesystem(&rdt_fs_type);
 	if (ret)
@@ -4287,6 +4306,7 @@ int __init resctrl_init(void)
 
 cleanup_mountpoint:
 	sysfs_remove_mount_point(fs_kobj, "resctrl");
+	resctrl_mon_resource_exit();
 
 	return ret;
 }
-- 
2.39.5


