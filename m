Return-Path: <linux-kernel+bounces-350893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06989990AB7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CABFB24F5D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E9721F43E;
	Fri,  4 Oct 2024 18:06:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B7121F420
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065213; cv=none; b=XkmO6vwD/zZXmCl8mgvjoAsLEqXE9DAIwqbbuKMeNZnyUaS6nHLWiHgsk9Rfj/5+Qgl7mQCoUtE5rLqbwq0f1QfYmpl8JKVE6MpBjUh0p32bxqntvwYyfMWNsXmEKDce1nvUFqkxQnaXWahXbnvAD+6WfiIPdpIcerOD3VWQW4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065213; c=relaxed/simple;
	bh=ehBiFdKhWJSf+I4CqeQYVZ8F3b51dg6e2+5mO1atCpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rX2Cb+0Cl/t+utvkgKu2Ttal7vTQ4pXjwyEffh6dFVQIaXttHc6thoWI4absOfG4nWctS7Zax3u3xtGndTYBoVAOZsCuuvp2XpsAPQj2JLEcWJGz5SClRMKB9rLWzgOnTOU8xEdNNRDwoX94qFrUq3nVRVaickS5NfkDkbHHYAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2E6E150C;
	Fri,  4 Oct 2024 11:07:20 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CC3F3F58B;
	Fri,  4 Oct 2024 11:06:48 -0700 (PDT)
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
Subject: [PATCH v5 33/40] x86/resctrl: Drop __init/__exit on assorted symbols
Date: Fri,  4 Oct 2024 18:03:40 +0000
Message-Id: <20241004180347.19985-34-james.morse@arm.com>
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

Because ARM's MPAM controls are probed using MMIO, resctrl can't be
initialised until enough CPUs are online to have determined the
system-wide supported num_closid. Arm64 also supports 'late onlined
secondaries', where only a subset of CPUs are online during boot.

These two combine to mean the MPAM driver may not be able to initialise
resctrl until user-space has brought 'enough' CPUs online.

To allow MPAM to initialise resctrl after __init text has been free'd,
remove all the __init markings from resctrl.

The existing __exit markings cause these functions to be removed by the
linker as it has never been possible to build resctrl as a module. MPAM
has an error interrupt which causes the driver to reset and disable
itself. Remove the __exit markings to allow the MPAM driver to tear down
resctrl when an error occurs.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
Changes since v4:
 * Earlier __init marker removal migrated here.
---
 arch/x86/kernel/cpu/resctrl/core.c     |  6 +++---
 arch/x86/kernel/cpu/resctrl/internal.h |  6 +++---
 arch/x86/kernel/cpu/resctrl/monitor.c  |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 +++++-----
 include/linux/resctrl.h                |  6 +++---
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index f484726a2588..f713ac628444 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -775,7 +775,7 @@ struct rdt_options {
 	bool	force_off, force_on;
 };
 
-static struct rdt_options rdt_options[]  __initdata = {
+static struct rdt_options rdt_options[]  __ro_after_init = {
 	RDT_OPT(RDT_FLAG_CMT,	    "cmt",	X86_FEATURE_CQM_OCCUP_LLC),
 	RDT_OPT(RDT_FLAG_MBM_TOTAL, "mbmtotal", X86_FEATURE_CQM_MBM_TOTAL),
 	RDT_OPT(RDT_FLAG_MBM_LOCAL, "mbmlocal", X86_FEATURE_CQM_MBM_LOCAL),
@@ -815,7 +815,7 @@ static int __init set_rdt_options(char *str)
 }
 __setup("rdt", set_rdt_options);
 
-bool __init rdt_cpu_has(int flag)
+bool rdt_cpu_has(int flag)
 {
 	bool ret = boot_cpu_has(flag);
 	struct rdt_options *o;
@@ -835,7 +835,7 @@ bool __init rdt_cpu_has(int flag)
 	return ret;
 }
 
-bool __init resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
+bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
 {
 	if (!rdt_cpu_has(X86_FEATURE_BMEC))
 		return false;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index e939a0a28a49..4b7e370e71ac 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -474,13 +474,13 @@ int alloc_rmid(u32 closid);
 void free_rmid(u32 closid, u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
 void resctrl_mon_resource_exit(void);
-bool __init rdt_cpu_has(int flag);
+bool rdt_cpu_has(int flag);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
 		    cpumask_t *cpumask, int evtid, int first);
-int __init resctrl_mon_resource_init(void);
+int resctrl_mon_resource_init(void);
 void mbm_setup_overflow_handler(struct rdt_mon_domain *dom,
 				unsigned long delay_ms,
 				int exclude_cpu);
@@ -493,7 +493,7 @@ void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_mon_domain *d);
 void __check_limbo(struct rdt_mon_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
-void __init mbm_config_rftype_init(const char *config);
+void mbm_config_rftype_init(const char *config);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 39c450624ed0..1fd47f8a0e18 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1191,7 +1191,7 @@ static __init int snc_get_config(void)
  *
  * Returns 0 for success, or -ENOMEM.
  */
-int __init resctrl_mon_resource_init(void)
+int resctrl_mon_resource_init(void)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	int ret;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index bb5aadaf99b6..e45a8a6b5ff7 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2048,7 +2048,7 @@ static struct rftype *rdtgroup_get_rftype_by_name(const char *name)
 	return NULL;
 }
 
-static void __init thread_throttle_mode_init(void)
+static void thread_throttle_mode_init(void)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
 	struct rftype *rft;
@@ -2064,7 +2064,7 @@ static void __init thread_throttle_mode_init(void)
 	rft->fflags = RFTYPE_CTRL_INFO | RFTYPE_RES_MB;
 }
 
-void __init mbm_config_rftype_init(const char *config)
+void mbm_config_rftype_init(const char *config)
 {
 	struct rftype *rft;
 
@@ -4044,7 +4044,7 @@ static void rdtgroup_destroy_root(void)
 	rdtgroup_default.kn = NULL;
 }
 
-static void __init rdtgroup_setup_default(void)
+static void rdtgroup_setup_default(void)
 {
 	mutex_lock(&rdtgroup_mutex);
 
@@ -4260,7 +4260,7 @@ void resctrl_offline_cpu(unsigned int cpu)
  *
  * Return: 0 on success or -errno
  */
-int __init resctrl_init(void)
+int resctrl_init(void)
 {
 	int ret = 0;
 
@@ -4317,7 +4317,7 @@ int __init resctrl_init(void)
 	return ret;
 }
 
-void __exit resctrl_exit(void)
+void resctrl_exit(void)
 {
 	rdtgroup_destroy_root();
 	debugfs_remove_recursive(debugfs_resctrl);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 7af6c40764ed..39303a0a398a 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -374,7 +374,7 @@ struct rdt_domain_hdr *resctrl_arch_find_domain(struct list_head *domain_list,
 						int id);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
-bool __init resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
+bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
 
 /**
  * resctrl_arch_mon_event_config_write() - Write the config for a counter.
@@ -537,7 +537,7 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
-int __init resctrl_init(void);
-void __exit resctrl_exit(void);
+int resctrl_init(void);
+void resctrl_exit(void);
 
 #endif /* _RESCTRL_H */
-- 
2.39.2


