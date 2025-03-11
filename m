Return-Path: <linux-kernel+bounces-556754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A51C1A5CE1D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE24017E34A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AFB266566;
	Tue, 11 Mar 2025 18:41:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DBC266565
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718500; cv=none; b=DbkpX761iujhgtMSOz1ZZ4VS93Cnp+7f8wQaBdl+7jjwYXqSqNNEnPOz5FH/qscFzLgsL6l1OWb7lp3/Ejc+/y1pBeLQPfiNCo67A9QofrhgwPNDwVkGzRw55ITF2DC6mJJ+ZFMBYHRLQ3ikuXJtvlHoI+ePSb1IZNBtnRC3idg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718500; c=relaxed/simple;
	bh=mssoB0ImMUQKadmQ5O3JX8EwHj5EcFbn72hByUTsbQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s7ExqxCfPSUrwslIlN3K4+AfwLXnIQWTLxbzzEcn/6f2pOYtj76zGNvAFPPpZYgw6N5Zln4yGixWH7/VReAKYM1Gg7P+vjZZDgwLbsWURibgujx1ke+rAdyvDt9eO4rwjfPXOOL02DPPkKwvuZILPRNJSUDUCHV0Qp7qC6MhUW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12F881713;
	Tue, 11 Mar 2025 11:41:49 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FF713F694;
	Tue, 11 Mar 2025 11:41:34 -0700 (PDT)
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
Subject: [PATCH v8:for-boris 24/30] x86/resctrl: Allow an architecture to disable pseudo lock
Date: Tue, 11 Mar 2025 18:37:09 +0000
Message-Id: <20250311183715.16445-25-james.morse@arm.com>
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

Pseudo-lock relies on knowledge of the micro-architecture to disable
prefetchers etc.

On arm64 these controls are typically secure only, meaning linux can't
access them. Arm's cache-lockdown feature works in a very different
way. Resctrl's pseudo-lock isn't going to be used on arm64 platforms.

Add a Kconfig symbol that can be selected by the architecture. This
enables or disables building of the pseudo_lock.c file, and replaces
the functions with stubs. An additional IS_ENABLED() check is needed
in rdtgroup_mode_write() so that attempting to enable pseudo-lock
reports an "Unknown or unsupported mode" to user-space via the
last_cmd_status file.

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
 * "last_cmd file" -> "last_cmd_status file"

Changes since v2:
 * Clarified the commit message as to where the error string is printed.

Changes since v1:
 * [Commit message only] Typo fix:
   s/psuedo/pseudo/g
---
 arch/x86/Kconfig                       |  7 ++++
 arch/x86/kernel/cpu/resctrl/Makefile   |  5 +--
 arch/x86/kernel/cpu/resctrl/internal.h | 49 +++++++++++++++++++++-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  3 +-
 4 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be2c311f5118..1a89574a58f7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -505,6 +505,7 @@ config X86_CPU_RESCTRL
 	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select KERNFS
 	select PROC_CPU_RESCTRL		if PROC_FS
+	select RESCTRL_FS_PSEUDO_LOCK
 	help
 	  Enable x86 CPU resource control support.
 
@@ -521,6 +522,12 @@ config X86_CPU_RESCTRL
 
 	  Say N if unsure.
 
+config RESCTRL_FS_PSEUDO_LOCK
+	bool
+	help
+	  Software mechanism to pin data in a cache portion using
+	  micro-architecture specific knowledge.
+
 config X86_FRED
 	bool "Flexible Return and Event Delivery"
 	depends on X86_64
diff --git a/arch/x86/kernel/cpu/resctrl/Makefile b/arch/x86/kernel/cpu/resctrl/Makefile
index 4a06c37b9cf1..0c13b0befd8a 100644
--- a/arch/x86/kernel/cpu/resctrl/Makefile
+++ b/arch/x86/kernel/cpu/resctrl/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_X86_CPU_RESCTRL)	+= core.o rdtgroup.o monitor.o
-obj-$(CONFIG_X86_CPU_RESCTRL)	+= ctrlmondata.o pseudo_lock.o
+obj-$(CONFIG_X86_CPU_RESCTRL)		+= core.o rdtgroup.o monitor.o
+obj-$(CONFIG_X86_CPU_RESCTRL)		+= ctrlmondata.o
+obj-$(CONFIG_RESCTRL_FS_PSEUDO_LOCK)	+= pseudo_lock.o
 CFLAGS_pseudo_lock.o = -I$(src)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 725f223ea07b..8d35bb423aad 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -512,14 +512,6 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_ctrl_domain
 				  unsigned long cbm);
 enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
 int rdtgroup_tasks_assigned(struct rdtgroup *r);
-int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
-int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp);
-bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_ctrl_domain *d, unsigned long cbm);
-bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_ctrl_domain *d);
-int rdt_pseudo_lock_init(void);
-void rdt_pseudo_lock_release(void);
-int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
-void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
 struct rdt_ctrl_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r);
 struct rdt_mon_domain *get_mon_domain_from_cpu(int cpu, struct rdt_resource *r);
 int closids_supported(void);
@@ -551,4 +543,45 @@ void resctrl_file_fflags_init(const char *config, unsigned long fflags);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
+
+#ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
+int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
+int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp);
+bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_ctrl_domain *d, unsigned long cbm);
+bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_ctrl_domain *d);
+int rdt_pseudo_lock_init(void);
+void rdt_pseudo_lock_release(void);
+int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
+void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
+#else
+static inline int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_ctrl_domain *d, unsigned long cbm)
+{
+	return false;
+}
+
+static inline bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_ctrl_domain *d)
+{
+	return false;
+}
+
+static inline int rdt_pseudo_lock_init(void) { return 0; }
+static inline void rdt_pseudo_lock_release(void) { }
+static inline int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp) { }
+#endif /* CONFIG_RESCTRL_FS_PSEUDO_LOCK */
+
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index a388ef66ef4c..e59271515a46 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1453,7 +1453,8 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 				goto out;
 		}
 		rdtgrp->mode = RDT_MODE_EXCLUSIVE;
-	} else if (!strcmp(buf, "pseudo-locksetup")) {
+	} else if (IS_ENABLED(CONFIG_RESCTRL_FS_PSEUDO_LOCK) &&
+		   !strcmp(buf, "pseudo-locksetup")) {
 		ret = rdtgroup_locksetup_enter(rdtgrp);
 		if (ret)
 			goto out;
-- 
2.39.5


