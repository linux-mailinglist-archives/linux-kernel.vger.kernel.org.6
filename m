Return-Path: <linux-kernel+bounces-272910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5212946278
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D724F1C2230A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3754166F29;
	Fri,  2 Aug 2024 17:30:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1891A83A3
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619831; cv=none; b=HRfhO0ryzDLyNvEtbseacGDapSBctPePD9Vr8rybf5BW7i850tmIttkTc1nRY3jABaDT4fIYgnw4HA8yXaH5WS3zD7LAui3s2ewu4SorNFlI7SPecUySAJvI+cD3zUUWVtdjmPTokxh5Tthe+yveuwwsZS7xPMU7c6jrb/txbYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619831; c=relaxed/simple;
	bh=aZnypPCQxcMd9ESbyj4pqoR0h4+1HRwpumdil0mhnJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KpEdcpQXov2R6EGnNrzp5zBTqU6WRiIDZaMv8KFBMQd73iIbQXzGfwzWV8QFYB8fGnwcDd1vxJhk5CjSgN/aMnI+wiq6Vjgw0dxJGw6l9r3Kd/57mLxKJNnbHeQM25ycKftCfmVO3KoXVdYSJJ/DxOxaRwNz07ZykwDHoKTQDuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 407421007;
	Fri,  2 Aug 2024 10:30:55 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C4333F64C;
	Fri,  2 Aug 2024 10:30:24 -0700 (PDT)
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
	Dave Martin <Dave.Martin@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH v4 11/39] x86/resctrl: Export resctrl fs's init function
Date: Fri,  2 Aug 2024 17:28:25 +0000
Message-Id: <20240802172853.22529-12-james.morse@arm.com>
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

rdtgroup_init() needs exporting so that arch code can call it once
it lives in core code. As this is one of the few functions exported,
rename it to have "resctrl" in the name. The same goes for the exit
call.

x86's arch code init functions for RDT are renamed to have an arch
prefix to make it clear these are part of the architecture code.

Co-developed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
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
index 1628c848bfd0..19852ba2c826 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -1052,7 +1052,7 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
 	}
 }
 
-static int __init resctrl_late_init(void)
+static int __init resctrl_arch_late_init(void)
 {
 	struct rdt_resource *r;
 	int state, ret;
@@ -1075,7 +1075,7 @@ static int __init resctrl_late_init(void)
 	if (state < 0)
 		return state;
 
-	ret = rdtgroup_init();
+	ret = resctrl_init();
 	if (ret) {
 		cpuhp_remove_state(state);
 		return ret;
@@ -1091,18 +1091,18 @@ static int __init resctrl_late_init(void)
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
index ffcade365070..bb88be45b8c4 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -326,9 +326,6 @@ extern struct list_head rdt_all_groups;
 
 extern int max_name_width, max_data_width;
 
-int __init rdtgroup_init(void);
-void __exit rdtgroup_exit(void);
-
 /**
  * struct rftype - describe each file in the resctrl file system
  * @name:	File name
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 00d906a1f51c..9cdca9d2bbde 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1031,7 +1031,7 @@ static int dom_data_init(struct rdt_resource *r)
 	/*
 	 * RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID are special and
 	 * are always allocated. These are used for the rdtgroup_default
-	 * control group, which will be setup later in rdtgroup_init().
+	 * control group, which will be setup later in resctrl_init().
 	 */
 	idx = resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
 					   RESCTRL_RESERVED_RMID);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 8d2de597bdf6..adc86568f72b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4225,14 +4225,14 @@ void resctrl_offline_cpu(unsigned int cpu)
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
 
@@ -4280,7 +4280,7 @@ int __init rdtgroup_init(void)
 	return ret;
 }
 
-void __exit rdtgroup_exit(void)
+void __exit resctrl_exit(void)
 {
 	debugfs_remove_recursive(debugfs_resctrl);
 	unregister_filesystem(&rdt_fs_type);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 096621a8f69b..2271fa7eb6c4 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -407,4 +407,7 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
+int __init resctrl_init(void);
+void __exit resctrl_exit(void);
+
 #endif /* _RESCTRL_H */
-- 
2.39.2


