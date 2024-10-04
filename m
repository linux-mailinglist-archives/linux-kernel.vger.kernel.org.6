Return-Path: <linux-kernel+bounces-350877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B54990AA3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984271C22FAD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2C02178EC;
	Fri,  4 Oct 2024 18:06:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD89E1DD89F
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065166; cv=none; b=bZa9Yga766Gxo/RjE2HtYHPd7XKWyr15OxDKD1gXdQJtWRJatd1BdplQriPjE3O401c9YGVBp4lSeAKKZFrOwVp94keSC/PX2Oi22Z4L8CWJHXDRVTHqgZHjxS4zQOzGdQ9stEBeuh4o+SDIXkFNv5YKOVMgRpCJ+G48kgBS+u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065166; c=relaxed/simple;
	bh=2TnfSsqNMv2wP9QyoVjnwA0RPDsMSY2XB9EZzZSw9wc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Unv5Xxuit6L7ZLSdEBvv/4ub3En5fRxTDicW1wGb90MBrrN/WPHMD/uFU8/d67ib8DuHZhhSvo4QXgPrrNPBWtZH0a6Hv5BfWHUO1a04GcicQYXR2d66cojKaJ7tzBcBmKKR+jLC4oiWF17Y4pDCMXh+wNSxbOLzOBSioe6FAus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E08B4150C;
	Fri,  4 Oct 2024 11:06:33 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48ED13F58B;
	Fri,  4 Oct 2024 11:06:01 -0700 (PDT)
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
Subject: [PATCH v5 19/40] x86/resctrl: Add resctrl_arch_is_evt_configurable() to abstract BMEC
Date: Fri,  4 Oct 2024 18:03:26 +0000
Message-Id: <20241004180347.19985-20-james.morse@arm.com>
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

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
Changes since v4:
 * Moved all the __init changes to a later patch now that the exit gubbins
   comes first.
---
 arch/x86/kernel/cpu/resctrl/core.c    | 15 +++++++++++++++
 arch/x86/kernel/cpu/resctrl/monitor.c | 18 +++++++++---------
 include/linux/resctrl.h               |  2 ++
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 8db946ebc4ff..b5ad1ed2a4de 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -866,6 +866,21 @@ bool __init rdt_cpu_has(int flag)
 	return ret;
 }
 
+bool __init resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
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
index 68e05bd0eb94..ae8552ef98e6 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1205,6 +1205,15 @@ int __init resctrl_mon_resource_init(void)
 
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
 
@@ -1248,15 +1257,6 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
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
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index f75f0409ae09..224a14d9aa7a 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -313,6 +313,8 @@ struct rdt_domain_hdr *resctrl_arch_find_domain(struct list_head *domain_list,
 						int id);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
+bool __init resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
+
 /*
  * Update the ctrl_val and apply this config right now.
  * Must be called on one of the domain's CPUs.
-- 
2.39.2


