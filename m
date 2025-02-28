Return-Path: <linux-kernel+bounces-539365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75728A4A371
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55521189FBBE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A977227934C;
	Fri, 28 Feb 2025 20:01:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D1027934E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772909; cv=none; b=YVr8ZnRVhsnYEH9BoTAsBur+GWKZtXQWttlTnA8loW0ekiGBpW2zOD7+NtjlC4Y3Avqy00CfnHxhmNGtoKSsPRdS6hQQkOCp0z+U3KQS8WCjvdbjhIUNsC0f9QjaCB/n6X6ydbkz1IYcJ11/DfJm5SwPhapx5lbH50UkMBYPE2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772909; c=relaxed/simple;
	bh=gb40rHn2GLeAIn8WIjEgtAJIQ9zBtz3bKAIrxQIhs9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=da4oAxMgwkToUCc4UIfDaWoEemO52nosmjRuDetppkK3DTdBeB/ikUBxwAxjlhJRTCZkH8ox1SJG3K/EG91sfhYD5XKLTQ02UTVstXurycn/y93KSYyqN0SW8Dh+Spk0XL1JiYYGguXTPyODddtrpppAl/WqSokR1LhYCfcsi6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F578150C;
	Fri, 28 Feb 2025 12:02:02 -0800 (PST)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35A143F5A1;
	Fri, 28 Feb 2025 12:01:44 -0800 (PST)
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
	fenghuay@nvidia.com
Subject: [PATCH v7 30/49] x86/resctrl: Move get_{mon,ctrl}_domain_from_cpu() to live with their callers
Date: Fri, 28 Feb 2025 19:58:54 +0000
Message-Id: <20250228195913.24895-31-james.morse@arm.com>
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

Each of get_{mon,ctrl}_domain_from_cpu() only has one caller.

Once the filesystem code is moved to /fs/, there is no equivalent to
core.c.

Move these functions to each live next to their caller. This allows
them to be made static and teh header file entries to be removed.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v6:
 * This patch replaces one that moved these to a header, any arch code
   will need its own way of finding the domain to online/offline from
   a cpu number.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 30 --------------------------
 arch/x86/kernel/cpu/resctrl/internal.h |  2 --
 arch/x86/kernel/cpu/resctrl/monitor.c  | 16 ++++++++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 ++++++++++++++
 4 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 70421d52eceb..b7ce578bffa5 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -349,36 +349,6 @@ static void cat_wrmsr(struct msr_param *m)
 		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
 }
 
-struct rdt_ctrl_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r)
-{
-	struct rdt_ctrl_domain *d;
-
-	lockdep_assert_cpus_held();
-
-	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
-		/* Find the domain that contains this CPU */
-		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
-			return d;
-	}
-
-	return NULL;
-}
-
-struct rdt_mon_domain *get_mon_domain_from_cpu(int cpu, struct rdt_resource *r)
-{
-	struct rdt_mon_domain *d;
-
-	lockdep_assert_cpus_held();
-
-	list_for_each_entry(d, &r->mon_domains, hdr.list) {
-		/* Find the domain that contains this CPU */
-		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
-			return d;
-	}
-
-	return NULL;
-}
-
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r)
 {
 	return resctrl_to_arch_res(r)->num_closid;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 0d13006e920b..c44c5b496355 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -475,8 +475,6 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_ctrl_domain
 				  unsigned long cbm);
 enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
 int rdtgroup_tasks_assigned(struct rdtgroup *r);
-struct rdt_ctrl_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r);
-struct rdt_mon_domain *get_mon_domain_from_cpu(int cpu, struct rdt_resource *r);
 int closids_supported(void);
 void closid_free(int closid);
 int alloc_rmid(u32 closid);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 83f90128d768..a93ed7d2a160 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -718,6 +718,22 @@ void mon_event_count(void *info)
 		rr->err = 0;
 }
 
+static struct rdt_ctrl_domain *get_ctrl_domain_from_cpu(int cpu,
+							struct rdt_resource *r)
+{
+	struct rdt_ctrl_domain *d;
+
+	lockdep_assert_cpus_held();
+
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
+		/* Find the domain that contains this CPU */
+		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
+			return d;
+	}
+
+	return NULL;
+}
+
 /*
  * Feedback loop for MBA software controller (mba_sc)
  *
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5fc60c9ce28f..c6274d40b217 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4257,6 +4257,22 @@ static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
 	}
 }
 
+static struct rdt_mon_domain *get_mon_domain_from_cpu(int cpu,
+						      struct rdt_resource *r)
+{
+	struct rdt_mon_domain *d;
+
+	lockdep_assert_cpus_held();
+
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
+		/* Find the domain that contains this CPU */
+		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
+			return d;
+	}
+
+	return NULL;
+}
+
 void resctrl_offline_cpu(unsigned int cpu)
 {
 	struct rdt_resource *l3 = resctrl_arch_get_resource(RDT_RESOURCE_L3);
-- 
2.39.5


