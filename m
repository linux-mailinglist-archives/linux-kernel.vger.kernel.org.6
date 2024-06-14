Return-Path: <linux-kernel+bounces-215092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAD9908E28
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7061C2507E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B441ABCDA;
	Fri, 14 Jun 2024 15:02:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A16D1ABCBE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377354; cv=none; b=l6THeMJ/DMSKzYUqMOGhWRzv74aoOLMJv1hZrE1DHt6QCnDswRvg2nQfejBqTqSr+qGWL7S8j3nc0T0agu3x5h1xINbDUxQkrLP8SIDSspDqGGNTXfzNDdkO7FFym9oi6otATWwOjNjoi34WrQ+smKhJAp+hYog5rXxi0e7QYXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377354; c=relaxed/simple;
	bh=BVE/glCtp14JRlgpWyszjU0g9E9PIcy0fPzQ+SzVwQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DE9MZygenFj5kwNVebKkiFR+Wqmm77DUbe88tgDIe4KflwZ297IhtREd3464i9v4uCH4RVbFO6TrRK5Xq3V1iAQvY0Bx8EBunWP+ut5/SgbNxHeSi1ZdQ/RhztwZrlHMDIqcvzmloO8kbvaLo6m/n4fU396N5C0NgOsAMOaQ8ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30D5C1BA8;
	Fri, 14 Jun 2024 08:02:57 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E0953F5A1;
	Fri, 14 Jun 2024 08:02:29 -0700 (PDT)
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
Subject: [PATCH v3 25/38] x86/resctrl: Make resctrl_arch_pseudo_lock_fn() take a plr
Date: Fri, 14 Jun 2024 15:00:20 +0000
Message-Id: <20240614150033.10454-26-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240614150033.10454-1-james.morse@arm.com>
References: <20240614150033.10454-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

resctrl_arch_pseudo_lock_fn() has architecture specific behaviour,
and takes a struct rdtgroup as an argument.

After the filesystem code moves to /fs/, the definition of struct
rdtgroup will not be available to the architecture code.

The only reason resctrl_arch_pseudo_lock_fn() wants the rdtgroup is
for the CLOSID. Embed that in the pseudo_lock_region as a closid,
and move the definition of struct pseudo_lock_region to resctrl.h.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
Change since v1:
 * [Commit message only] Typo fix:
   s/hw_closid/closid/g
---
 arch/x86/include/asm/resctrl.h            |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h    | 37 ---------------------
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 13 ++++----
 include/linux/resctrl.h                   | 39 +++++++++++++++++++++++
 4 files changed, 47 insertions(+), 44 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index a88af68f9fe2..9940398e367e 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -212,7 +212,7 @@ static inline void resctrl_arch_mon_ctx_free(struct rdt_resource *r, int evtid,
 					     void *ctx) { };
 
 u64 resctrl_arch_get_prefetch_disable_bits(void);
-int resctrl_arch_pseudo_lock_fn(void *_rdtgrp);
+int resctrl_arch_pseudo_lock_fn(void *_plr);
 int resctrl_arch_measure_cycles_lat_fn(void *_plr);
 int resctrl_arch_measure_l2_residency(void *_plr);
 int resctrl_arch_measure_l3_residency(void *_plr);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 1c2132e67df3..38d3aab9b684 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -183,43 +183,6 @@ struct mongroup {
 	u32			rmid;
 };
 
-/**
- * struct pseudo_lock_region - pseudo-lock region information
- * @s:			Resctrl schema for the resource to which this
- *			pseudo-locked region belongs
- * @d:			RDT domain to which this pseudo-locked region
- *			belongs
- * @cbm:		bitmask of the pseudo-locked region
- * @lock_thread_wq:	waitqueue used to wait on the pseudo-locking thread
- *			completion
- * @thread_done:	variable used by waitqueue to test if pseudo-locking
- *			thread completed
- * @cpu:		core associated with the cache on which the setup code
- *			will be run
- * @line_size:		size of the cache lines
- * @size:		size of pseudo-locked region in bytes
- * @kmem:		the kernel memory associated with pseudo-locked region
- * @minor:		minor number of character device associated with this
- *			region
- * @debugfs_dir:	pointer to this region's directory in the debugfs
- *			filesystem
- * @pm_reqs:		Power management QoS requests related to this region
- */
-struct pseudo_lock_region {
-	struct resctrl_schema	*s;
-	struct rdt_domain	*d;
-	u32			cbm;
-	wait_queue_head_t	lock_thread_wq;
-	int			thread_done;
-	int			cpu;
-	unsigned int		line_size;
-	unsigned int		size;
-	void			*kmem;
-	unsigned int		minor;
-	struct dentry		*debugfs_dir;
-	struct list_head	pm_reqs;
-};
-
 /**
  * struct rdtgroup - store rdtgroup's data in resctrl file system.
  * @kn:				kernfs node
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index cfd40ffe9b72..c096fa106b80 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -416,7 +416,7 @@ static void pseudo_lock_free(struct rdtgroup *rdtgrp)
 
 /**
  * resctrl_arch_pseudo_lock_fn - Load kernel memory into cache
- * @_rdtgrp: resource group to which pseudo-lock region belongs
+ * @_plr: the pseudo-lock region descriptor
  *
  * This is the core pseudo-locking flow.
  *
@@ -433,10 +433,9 @@ static void pseudo_lock_free(struct rdtgroup *rdtgrp)
  *
  * Return: 0. Waiter on waitqueue will be woken on completion.
  */
-int resctrl_arch_pseudo_lock_fn(void *_rdtgrp)
+int resctrl_arch_pseudo_lock_fn(void *_plr)
 {
-	struct rdtgroup *rdtgrp = _rdtgrp;
-	struct pseudo_lock_region *plr = rdtgrp->plr;
+	struct pseudo_lock_region *plr = _plr;
 	u32 rmid_p, closid_p;
 	unsigned long i;
 	u64 saved_msr;
@@ -496,7 +495,8 @@ int resctrl_arch_pseudo_lock_fn(void *_rdtgrp)
 	 * pseudo-locked followed by reading of kernel memory to load it
 	 * into the cache.
 	 */
-	__wrmsr(MSR_IA32_PQR_ASSOC, rmid_p, rdtgrp->closid);
+	__wrmsr(MSR_IA32_PQR_ASSOC, rmid_p, plr->closid);
+
 	/*
 	 * Cache was flushed earlier. Now access kernel memory to read it
 	 * into cache region associated with just activated plr->closid.
@@ -1327,7 +1327,8 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 
 	plr->thread_done = 0;
 
-	thread = kthread_create_on_node(resctrl_arch_pseudo_lock_fn, rdtgrp,
+	plr->closid = rdtgrp->closid;
+	thread = kthread_create_on_node(resctrl_arch_pseudo_lock_fn, plr,
 					cpu_to_node(plr->cpu),
 					"pseudo_lock/%u", plr->cpu);
 	if (IS_ERR(thread)) {
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index b04744b00f6f..0359746d45f5 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -39,6 +39,45 @@ enum resctrl_conf_type {
 
 #define CDP_NUM_TYPES	(CDP_DATA + 1)
 
+/*
+ * struct pseudo_lock_region - pseudo-lock region information
+ * @s:			Resctrl schema for the resource to which this
+ *			pseudo-locked region belongs
+ * @closid:		The closid that this pseudo-locked region uses
+ * @d:			RDT domain to which this pseudo-locked region
+ *			belongs
+ * @cbm:		bitmask of the pseudo-locked region
+ * @lock_thread_wq:	waitqueue used to wait on the pseudo-locking thread
+ *			completion
+ * @thread_done:	variable used by waitqueue to test if pseudo-locking
+ *			thread completed
+ * @cpu:		core associated with the cache on which the setup code
+ *			will be run
+ * @line_size:		size of the cache lines
+ * @size:		size of pseudo-locked region in bytes
+ * @kmem:		the kernel memory associated with pseudo-locked region
+ * @minor:		minor number of character device associated with this
+ *			region
+ * @debugfs_dir:	pointer to this region's directory in the debugfs
+ *			filesystem
+ * @pm_reqs:		Power management QoS requests related to this region
+ */
+struct pseudo_lock_region {
+	struct resctrl_schema	*s;
+	u32			closid;
+	struct rdt_domain	*d;
+	u32			cbm;
+	wait_queue_head_t	lock_thread_wq;
+	int			thread_done;
+	int			cpu;
+	unsigned int		line_size;
+	unsigned int		size;
+	void			*kmem;
+	unsigned int		minor;
+	struct dentry		*debugfs_dir;
+	struct list_head	pm_reqs;
+};
+
 /**
  * struct resctrl_staged_config - parsed configuration to be applied
  * @new_ctrl:		new ctrl value to be loaded
-- 
2.39.2


