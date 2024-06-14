Return-Path: <linux-kernel+bounces-215086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A59908E22
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F4F1C259AC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217E01A38D4;
	Fri, 14 Jun 2024 15:02:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1848E1A2FAF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377334; cv=none; b=dxhSIhQwsF0S1yqnacK2Uig/UiKgW+iNvsGfR46y9LscKNWpcbpgIOh9dZTMEroQnNavA+XVYwiOJC5oFcNSxCjKPpeRTbZcH91epwpNwCx/w5ZBJimv8bn9VurfIoSLHmqVxB+XJ+SDlyW9hu2WZGdy1kb6pqLYwMw00DIo1pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377334; c=relaxed/simple;
	bh=QU9DU+yJhBKugsQjBf99MRrnlXKzYxQCfGRO7LV8/jY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vEZ1LTBAlBXyzLLXpzIvfDPv5+fCD0bUNExG8/4+94ek9Zv60nGdtEUsfhD4wjbAl+TGNmmesLnF094rfxvcdyYbnVSfcv5bDfEPgqSpTYKtTQPaB/QBues0dIFpnd1SyJjKsAYRNky7YF4Wo6jgdUCYOw3d83dHQ6l1atj++eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EB681A00;
	Fri, 14 Jun 2024 08:02:37 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C86C3F5A1;
	Fri, 14 Jun 2024 08:02:09 -0700 (PDT)
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
Subject: [PATCH v3 19/38] x86/resctrl: Add resctrl_arch_is_evt_configurable() to abstract BMEC
Date: Fri, 14 Jun 2024 15:00:14 +0000
Message-Id: <20240614150033.10454-20-james.morse@arm.com>
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

When BMEC is supported the resctrl event can be configured in a number
of ways. This depends on architecture support. rdt_get_mon_l3_config()
modifies the struct mon_evt and calls mbm_config_rftype_init() to create
the files that allow the configuration.

Splitting this into separate architecture and filesystem parts would
require the struct mon_evt and mbm_config_rftype_init() to be exposed.

Instead, add resctrl_arch_is_evt_configurable(), and use this from
resctrl_mon_resource_init() to initialise struct mon_evt and call
mbm_config_rftype_init().
resctrl_arch_is_evt_configurable() calls rdt_cpu_has() so it doesn't
obviously benefit from being inlined. Putting it in core.c will allow
rdt_cpu_has() to eventually become static.

resctrl_arch_is_evt_configurable() uses rdt_cpu_has() from
resctrl_mon_resource_init(), which isn't marked __init. In addition,
MPAM needs to initialise resctrl late. Drop the __init on the relevant
functions.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 19 +++++++++++++++++--
 arch/x86/kernel/cpu/resctrl/internal.h |  4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c  | 18 +++++++++---------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 +-
 include/linux/resctrl.h                |  2 ++
 5 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 06521c124795..252201eefdd0 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -651,7 +651,7 @@ struct rdt_options {
 	bool	force_off, force_on;
 };
 
-static struct rdt_options rdt_options[]  __initdata = {
+static struct rdt_options rdt_options[]  __ro_after_init = {
 	RDT_OPT(RDT_FLAG_CMT,	    "cmt",	X86_FEATURE_CQM_OCCUP_LLC),
 	RDT_OPT(RDT_FLAG_MBM_TOTAL, "mbmtotal", X86_FEATURE_CQM_MBM_TOTAL),
 	RDT_OPT(RDT_FLAG_MBM_LOCAL, "mbmlocal", X86_FEATURE_CQM_MBM_LOCAL),
@@ -691,7 +691,7 @@ static int __init set_rdt_options(char *str)
 }
 __setup("rdt", set_rdt_options);
 
-bool __init rdt_cpu_has(int flag)
+bool rdt_cpu_has(int flag)
 {
 	bool ret = boot_cpu_has(flag);
 	struct rdt_options *o;
@@ -711,6 +711,21 @@ bool __init rdt_cpu_has(int flag)
 	return ret;
 }
 
+bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
+{
+	if (!rdt_cpu_has(X86_FEATURE_BMEC))
+		return false;
+
+	switch (evt) {
+	case QOS_L3_MBM_TOTAL_EVENT_ID:
+		return rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL);
+	case QOS_L3_MBM_LOCAL_EVENT_ID:
+		return rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL);
+	default:
+		return false;
+	}
+}
+
 static __init bool get_mem_config(void)
 {
 	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_MBA];
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f4f48542447f..06e80356cdbb 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -509,7 +509,7 @@ int alloc_rmid(u32 closid);
 void free_rmid(u32 closid, u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
 void resctrl_mon_resource_exit(void);
-bool __init rdt_cpu_has(int flag);
+bool rdt_cpu_has(int flag);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
@@ -529,7 +529,7 @@ bool has_busy_rmid(struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init thread_throttle_mode_init(void);
-void __init mbm_config_rftype_init(const char *config);
+void mbm_config_rftype_init(const char *config);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 66bd869f02a9..5906dccfb247 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1030,6 +1030,15 @@ int resctrl_mon_resource_init(void)
 
 	l3_mon_evt_init(r);
 
+	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_TOTAL_EVENT_ID)) {
+		mbm_total_event.configurable = true;
+		mbm_config_rftype_init("mbm_total_bytes_config");
+	}
+	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_LOCAL_EVENT_ID)) {
+		mbm_local_event.configurable = true;
+		mbm_config_rftype_init("mbm_local_bytes_config");
+	}
+
 	return 0;
 }
 
@@ -1071,15 +1080,6 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		/* Detect list of bandwidth sources that can be tracked */
 		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
 		hw_res->mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
-
-		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
-			mbm_total_event.configurable = true;
-			mbm_config_rftype_init("mbm_total_bytes_config");
-		}
-		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
-			mbm_local_event.configurable = true;
-			mbm_config_rftype_init("mbm_local_bytes_config");
-		}
 	}
 
 	r->mon_capable = true;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 8c4ec7df12d3..da71f1d80be4 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2066,7 +2066,7 @@ void __init thread_throttle_mode_init(void)
 	rft->fflags = RFTYPE_CTRL_INFO | RFTYPE_RES_MB;
 }
 
-void __init mbm_config_rftype_init(const char *config)
+void mbm_config_rftype_init(const char *config)
 {
 	struct rftype *rft;
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 02b745f9c4c4..fbae9a907544 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -262,6 +262,8 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 struct rdt_domain *resctrl_arch_find_domain(struct rdt_resource *r, int id);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
+bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
+
 /*
  * Update the ctrl_val and apply this config right now.
  * Must be called on one of the domain's CPUs.
-- 
2.39.2


