Return-Path: <linux-kernel+bounces-539354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B74A4A361
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD0A3BFD83
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF7927604E;
	Fri, 28 Feb 2025 20:01:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7E8279550
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772870; cv=none; b=XKtW9WY/vy0ndPnj6t5zwIwSnp19L/AZZD9wSVBLgPpUeAp+UqEwr1ZK4TFuTCA/6iAeZsyeTaTR3kGZtO7in0w33JlwcrCRNp2pTjZb9eoIX9IVJqbYT4vq+fqB9ERsOOD2klI+vQU1SDYSg9uEIifNoaTYOFp99XD0k2p5Gkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772870; c=relaxed/simple;
	bh=fWQKePy6gqsOeBLnZiRxcmsrVFzzMJNaPNsF2QyG6mw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jL5LmdbitxeCWyQ/apwPE4CNYzBMuAehtXT9sH/UyYePGUW+g0Onf5QfXmJpxsvOzE2itft2ZHkf5gdxMIDHZVCBWDCswMqWV+pKUSfvaEYSifPXVoHvIdKcixnIdFxEwNQ888r53t0f0KdOWAzx9kCphgy4FJJnfpViqYJR1Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BFE61A25;
	Fri, 28 Feb 2025 12:01:23 -0800 (PST)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B38983F5A1;
	Fri, 28 Feb 2025 12:01:04 -0800 (PST)
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
Subject: [PATCH v7 19/49] x86/resctrl: Add resctrl_arch_is_evt_configurable() to abstract BMEC
Date: Fri, 28 Feb 2025 19:58:43 +0000
Message-Id: <20250228195913.24895-20-james.morse@arm.com>
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

When BMEC is supported the resctrl event can be configured in a number
of ways. This depends on architecture support. rdt_get_mon_l3_config()
modifies the struct mon_evt and calls mbm_config_rftype_init() to create
the files that allow the configuration.

Splitting this into separate architecture and filesystem parts would
require the struct mon_evt and mbm_config_rftype_init() to be exposed.

Instead, add resctrl_arch_is_evt_configurable(), and use this from
resctrl_mon_resource_init() to initialise struct mon_evt and call
resctrl_file_fflags_init()
resctrl_arch_is_evt_configurable() calls rdt_cpu_has() so it doesn't
obviously benefit from being inlined. Putting it in core.c will allow
rdt_cpu_has() to eventually become static.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
Changes since v6:
 * Fixed stale function name in the commit message.
 * Moved __init around in the function prototypes.

Changes since v4:
 * Moved all the __init changes to a later patch now that the exit gubbins
   comes first.
---
 arch/x86/kernel/cpu/resctrl/core.c    | 15 +++++++++++++++
 arch/x86/kernel/cpu/resctrl/monitor.c | 22 +++++++++++-----------
 include/linux/resctrl.h               |  2 ++
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 5464dc1611e9..943e4c56077b 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -832,6 +832,21 @@ bool __init rdt_cpu_has(int flag)
 	return ret;
 }
 
+__init bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
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
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index d883ed56ec90..27d983121b0a 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1202,6 +1202,17 @@ int __init resctrl_mon_resource_init(void)
 
 	l3_mon_evt_init(r);
 
+	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_TOTAL_EVENT_ID)) {
+		mbm_total_event.configurable = true;
+		resctrl_file_fflags_init("mbm_total_bytes_config",
+					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
+	}
+	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_LOCAL_EVENT_ID)) {
+		mbm_local_event.configurable = true;
+		resctrl_file_fflags_init("mbm_local_bytes_config",
+					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
+	}
+
 	return 0;
 }
 
@@ -1245,17 +1256,6 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		/* Detect list of bandwidth sources that can be tracked */
 		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
 		hw_res->mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
-
-		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
-			mbm_total_event.configurable = true;
-			resctrl_file_fflags_init("mbm_total_bytes_config",
-						 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
-		}
-		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
-			mbm_local_event.configurable = true;
-			resctrl_file_fflags_init("mbm_local_bytes_config",
-						 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
-		}
 	}
 
 	r->mon_capable = true;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index a392480dc4b6..cc76f308e6f3 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -309,6 +309,8 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 u32 resctrl_arch_system_num_rmid_idx(void);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
+__init bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
+
 /*
  * Update the ctrl_val and apply this config right now.
  * Must be called on one of the domain's CPUs.
-- 
2.39.5


