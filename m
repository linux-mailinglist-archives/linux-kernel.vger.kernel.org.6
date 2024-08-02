Return-Path: <linux-kernel+bounces-272915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3ED94627D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EE91F23C7C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A57215C14D;
	Fri,  2 Aug 2024 17:30:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B9E2101AE
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619853; cv=none; b=PM+5OFOej/hip5RQ4IV2MH9dexw+3Alm+QWLocMyXpzXTWoLzMqbZvVkMqzDXHl0GdcX6kyqnJCXRJFB0HwLP7w/ttmcJe+Sygn8VKMcmqE7Wxyy0w1Aab8c7JGDR26tsAJ7C9t9z1Hq6cvxd/cy3yCTq3ngPXZblH2E+LsMb0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619853; c=relaxed/simple;
	bh=EU+IThqm5A9wDJJP94UMD6FeTMl4jAm6qk4bvK/f9xY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ltubTtYJj/3ct+8q7REAQ3ai45hDXmmWlC5BeUmQshBxCkOhSiSbr62yl+kuZ5UWlYpwyHpRhLDhtjyJgQ7r274ofeyKM9nhaI1jirKaYzxeKGY+fvtAu3VH6VkoBtu8JjiXWp10J2mZqRvY3sxJClSrl5dyf1ii/Kg8ICEjCNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AC101655;
	Fri,  2 Aug 2024 10:31:17 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89FBA3F64C;
	Fri,  2 Aug 2024 10:30:48 -0700 (PDT)
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
	Dave Martin <dave.martin@arm.com>
Subject: [PATCH v4 16/39] x86/resctrl: Move monitor init work to a resctrl init call
Date: Fri,  2 Aug 2024 17:28:30 +0000
Message-Id: <20240802172853.22529-17-james.morse@arm.com>
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
---
Changes since v3:
 * Added a comment over resctrl_mon_resource_init().
 * Added a comment over domain_setup_mon_state() to warn of cpuhp ordering.
 * Added __init to resctrl_mon_resource_init().

Changes since v2:
 * Added error handling for the case sysfs files can't be created.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 36 +++++++++++++++++++++-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 22 +++++++++++++++-
 3 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 3fdeca6e3d21..8e52e81a044b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -586,6 +586,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
 		    cpumask_t *cpumask, int evtid, int first);
+int __init resctrl_mon_resource_init(void);
 void mbm_setup_overflow_handler(struct rdt_mon_domain *dom,
 				unsigned long delay_ms,
 				int exclude_cpu);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index afbda09aacf5..cecc96213c49 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1179,12 +1179,40 @@ static __init int snc_get_config(void)
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
 
@@ -1214,10 +1242,6 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	 */
 	resctrl_rmid_realloc_threshold = resctrl_arch_round_mon_val(threshold);
 
-	ret = dom_data_init(r);
-	if (ret)
-		return ret;
-
 	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
 		u32 eax, ebx, ecx, edx;
 
@@ -1235,8 +1259,6 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		}
 	}
 
-	l3_mon_evt_init(r);
-
 	r->mon_capable = true;
 
 	return 0;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 576f6b183980..f53d6ce390ac 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4097,6 +4097,19 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d
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
@@ -4247,9 +4260,15 @@ int __init resctrl_init(void)
 
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
@@ -4282,6 +4301,7 @@ int __init resctrl_init(void)
 
 cleanup_mountpoint:
 	sysfs_remove_mount_point(fs_kobj, "resctrl");
+	resctrl_mon_resource_exit();
 
 	return ret;
 }
-- 
2.39.2


