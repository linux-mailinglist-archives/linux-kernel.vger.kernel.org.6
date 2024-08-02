Return-Path: <linux-kernel+bounces-272927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F146946289
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3221A1C21902
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EDC18BB75;
	Fri,  2 Aug 2024 17:31:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BFC18BB6C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619895; cv=none; b=PCemJS7Lf40QKOvUERR0ZfJaIkhjUo8aBLodsjWyaDP7vfUbnsGOXt0paCkoD9s/5s8KUYR0lnfI/SfDMv6RzNsEXmORF9t1Hb2mPqRUEz7DS0PXA1v3pxfPoGtdE0q8E9t0pm0J8JKuYHJ1OQSkuccshGkiNyGS4sPe/iKsS9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619895; c=relaxed/simple;
	bh=tcKcEoAVrA/xuXtROn6Ra0FE85B0PgJSjMabaNg+Yss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PVVEMbkrrJU7wGGE8P9WjMYNp88IYtDJUBBxA3q3YBjyOuytsWJwVeALDmOikZ8w9HM24Z+Y8RQms9hpwj5erRXofBghWVUSvNetS90r8vXoLLceWEwN5JV62OE5LvsMTnJmvYJutbEYvCT7SgFLiOI/4Egnvjj+vXbNuzkIQSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DAE11042;
	Fri,  2 Aug 2024 10:31:59 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 632CF3F64C;
	Fri,  2 Aug 2024 10:31:30 -0700 (PDT)
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
Subject: [PATCH v4 28/39] x86/resctrl: Claim get_{mon,ctrl}_domain_from_cpu() helpers for resctrl
Date: Fri,  2 Aug 2024 17:28:42 +0000
Message-Id: <20240802172853.22529-29-james.morse@arm.com>
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

get_{mon,ctrl}_domain_from_cpu() are handy helpers that both the arch
code and resctrl need to use. Rename them to have a resctrl_ prefix
and move them to a header file.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
---
 arch/x86/kernel/cpu/resctrl/core.c     | 30 ---------------------
 arch/x86/kernel/cpu/resctrl/internal.h |  2 --
 arch/x86/kernel/cpu/resctrl/monitor.c  |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 +-
 include/linux/resctrl.h                | 37 ++++++++++++++++++++++++++
 5 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b36d8e8afc1a..1e2ea470ea45 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -345,36 +345,6 @@ static void cat_wrmsr(struct msr_param *m)
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
index 66ff26a121ed..f5801048404d 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -468,8 +468,6 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_ctrl_domain
 				  unsigned long cbm);
 enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
 int rdtgroup_tasks_assigned(struct rdtgroup *r);
-struct rdt_ctrl_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r);
-struct rdt_mon_domain *get_mon_domain_from_cpu(int cpu, struct rdt_resource *r);
 int closids_supported(void);
 void closid_free(int closid);
 int alloc_rmid(u32 closid);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 175fd7dbf34f..39c450624ed0 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -767,7 +767,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
 	idx = resctrl_arch_rmid_idx_encode(closid, rmid);
 	pmbm_data = &dom_mbm->mbm_local[idx];
 
-	dom_mba = get_ctrl_domain_from_cpu(smp_processor_id(), r_mba);
+	dom_mba = resctrl_get_ctrl_domain_from_cpu(smp_processor_id(), r_mba);
 	if (!dom_mba) {
 		pr_warn_once("Failure to get domain for MBA update\n");
 		return;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b35f9659e536..db2d3c7036b2 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4243,7 +4243,7 @@ void resctrl_offline_cpu(unsigned int cpu)
 	if (!l3->mon_capable)
 		goto out_unlock;
 
-	d = get_mon_domain_from_cpu(cpu, l3);
+	d = resctrl_get_mon_domain_from_cpu(cpu, l3);
 	if (d) {
 		if (resctrl_is_mbm_enabled() && cpu == d->mbm_work_cpu) {
 			cancel_delayed_work(&d->mbm_over);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index f99bd2996cba..31a28151193d 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -3,6 +3,7 @@
 #define _RESCTRL_H
 
 #include <linux/cacheinfo.h>
+#include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/pid.h>
@@ -401,6 +402,42 @@ static inline u32 resctrl_get_config_index(u32 closid,
 	}
 }
 
+/*
+ * Caller must hold the cpuhp read lock to prevent the struct rdt_domain being
+ * freed.
+ */
+static inline struct rdt_ctrl_domain *
+resctrl_get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r)
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
+static inline struct rdt_mon_domain *
+resctrl_get_mon_domain_from_cpu(int cpu, struct rdt_resource *r)
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
 /*
  * Update the ctrl_val and apply this config right now.
  * Must be called on one of the domain's CPUs.
-- 
2.39.2


