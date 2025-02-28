Return-Path: <linux-kernel+bounces-539346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D045A4A359
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3433B3090
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BC6281365;
	Fri, 28 Feb 2025 20:00:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1E0275604
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772841; cv=none; b=cW15IC8ZSIgXC88Au0nCshQlU0Zcq+EF6/4CXa9GmU7R9OccqlNgKqcMPMRUeZRUFZdVYsueXy53jXVumed8xGRyk5ID2JlQTwmKNqxoehgFHDUZs7Hs91MbGU5sqLBv0+EW5TkgsLQ7wYr3ZqBPJD13bybUsSykC9NxOWaf9w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772841; c=relaxed/simple;
	bh=hpi51EbDcKWdUJ9G/K+WKkX0M43kxtNNudRRhDh2nk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qKqAIbFQtJGtD8PDCafMpB/XXE+GrdVCQcxHGlQJmNCQiLxMssy84qOlmrf7/mj4Irq4vcdtigyNPHXuEVx3KB+75RzM1IrJdqJmBnrXTJXODpIp2fkqXp1GEkMU0hb9I1aCw+uY25lfPwDcWWH1/rleN7CyRe0pE6nUgk18l6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6104E176C;
	Fri, 28 Feb 2025 12:00:54 -0800 (PST)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5E483F5A1;
	Fri, 28 Feb 2025 12:00:35 -0800 (PST)
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
Subject: [PATCH v7 11/49] x86/resctrl: Expose resctrl fs's init function to the rest of the kernel
Date: Fri, 28 Feb 2025 19:58:35 +0000
Message-Id: <20250228195913.24895-12-james.morse@arm.com>
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

rdtgroup_init() needs exposing to the rest of the kernel so that arch
code can call it once it lives in core code. As this is one of the few
functions exposed, rename it to have "resctrl" in the name. The same
goes for the exit call.

Rename x86's arch code init functions for RDT to have an arch
prefix to make it clear these are part of the architecture code.

Co-developed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since v5:
 * Tweaked the word 'export'

Changes since v4:
 * Changed the voice of some of the commit message.

Changes since v1:
 * Rename stale rdtgroup_init() to resctrl_init() in
   arch/x86/kernel/cpu/resctrl/monitor.c comments.

   No functional change.

 * [Commit message only] Minor rewording to avoid "impersonating code".

 * [Commit message only] Typo fix:
   s/to have the resctrl/to have resctrl/ in commit message.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 12 ++++++------
 arch/x86/kernel/cpu/resctrl/internal.h |  3 ---
 arch/x86/kernel/cpu/resctrl/monitor.c  |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  8 ++++----
 include/linux/resctrl.h                |  3 +++
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 5280a2819760..ce50a7d3230c 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -1063,7 +1063,7 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
 	}
 }
 
-static int __init resctrl_late_init(void)
+static int __init resctrl_arch_late_init(void)
 {
 	struct rdt_resource *r;
 	int state, ret;
@@ -1086,7 +1086,7 @@ static int __init resctrl_late_init(void)
 	if (state < 0)
 		return state;
 
-	ret = rdtgroup_init();
+	ret = resctrl_init();
 	if (ret) {
 		cpuhp_remove_state(state);
 		return ret;
@@ -1102,18 +1102,18 @@ static int __init resctrl_late_init(void)
 	return 0;
 }
 
-late_initcall(resctrl_late_init);
+late_initcall(resctrl_arch_late_init);
 
-static void __exit resctrl_exit(void)
+static void __exit resctrl_arch_exit(void)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 
 	cpuhp_remove_state(rdt_online);
 
-	rdtgroup_exit();
+	resctrl_exit();
 
 	if (r->mon_capable)
 		rdt_put_mon_l3_config();
 }
 
-__exitcall(resctrl_exit);
+__exitcall(resctrl_arch_exit);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f975cd6cfe61..8291f1b59981 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -328,9 +328,6 @@ extern struct list_head rdt_all_groups;
 
 extern int max_name_width;
 
-int __init rdtgroup_init(void);
-void __exit rdtgroup_exit(void);
-
 /**
  * struct rftype - describe each file in the resctrl file system
  * @name:	File name
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 58b5b21349a8..e8388d19a579 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1027,7 +1027,7 @@ static int dom_data_init(struct rdt_resource *r)
 	/*
 	 * RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID are special and
 	 * are always allocated. These are used for the rdtgroup_default
-	 * control group, which will be setup later in rdtgroup_init().
+	 * control group, which will be setup later in resctrl_init().
 	 */
 	idx = resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
 					   RESCTRL_RESERVED_RMID);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 62d9a50c7bba..b2dad689e780 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4235,14 +4235,14 @@ void resctrl_offline_cpu(unsigned int cpu)
 }
 
 /*
- * rdtgroup_init - rdtgroup initialization
+ * resctrl_init - resctrl filesystem initialization
  *
  * Setup resctrl file system including set up root, create mount point,
- * register rdtgroup filesystem, and initialize files under root directory.
+ * register resctrl filesystem, and initialize files under root directory.
  *
  * Return: 0 on success or -errno
  */
-int __init rdtgroup_init(void)
+int __init resctrl_init(void)
 {
 	int ret = 0;
 
@@ -4290,7 +4290,7 @@ int __init rdtgroup_init(void)
 	return ret;
 }
 
-void __exit rdtgroup_exit(void)
+void __exit resctrl_exit(void)
 {
 	debugfs_remove_recursive(debugfs_resctrl);
 	unregister_filesystem(&rdt_fs_type);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 31808b3ddecb..f1979e375da9 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -402,4 +402,7 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
+int __init resctrl_init(void);
+void __exit resctrl_exit(void);
+
 #endif /* _RESCTRL_H */
-- 
2.39.5


