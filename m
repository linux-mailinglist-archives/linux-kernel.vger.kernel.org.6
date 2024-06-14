Return-Path: <linux-kernel+bounces-215094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2A9908E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440561F254A1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFC91AC246;
	Fri, 14 Jun 2024 15:02:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55FC1AC22D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377361; cv=none; b=sEXWwVvjTEXRRsXVwTs9devvEOdQeXS/fSpcjq/Uxu7vxewS1n21CZ7BM9dR6IKp+WFHoyZbquttzY09h3iD/9Fl8rMyxaF3Glu5qypMxPmO2K/EkMT+BQnUdUwB+Ie7TNlz4oMp4pH9Q4N6RzlWE9S/Pzb4pmV8ocjho+atFd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377361; c=relaxed/simple;
	bh=22tF9u9zn9sPAGrVeRI8EEeXemVt5Q9eKCLU8INeeVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uke7mydte/ZskgRNpvcwnO8R5bEakKBwXxCudoLXX1oUrs0ZgmUDxfJQLGbE7pBMtbbHQ3boFpP2Se1g4vm2RFI4FS67hw+esjG7BlTCLLYNVD2LE2+ocoA5XFcIx/ZvCcIhFnFJdU6Ntw4nYZuEqIgFpuWZrdX9HubOXuRQAEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDE5F1BB2;
	Fri, 14 Jun 2024 08:03:03 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D2A43F5A1;
	Fri, 14 Jun 2024 08:02:36 -0700 (PDT)
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
Subject: [PATCH v3 27/38] x86/resctrl: Move get_config_index() to a header
Date: Fri, 14 Jun 2024 15:00:22 +0000
Message-Id: <20240614150033.10454-28-james.morse@arm.com>
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

get_config_index() is used by the architecture specific code to map a
CLOSID+type pair to an index in the configuration arrays.

MPAM needs to do this too to preserve the ABI to user-space, there is
no reason to do it differently.

Move the helper to a header file.

Co-developed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
Changes since v1:
 * Reindent resctrl_get_config_index() as per coding-style.rst rules.

 * Remove redundant parentheses from arithmetic in
   resctrl_get_config_index(), so as to match the original source
   version of this moved code.

   No functional change.
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 19 +++----------------
 include/linux/resctrl.h                   | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 2100560dda6a..130583035d27 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -283,25 +283,12 @@ static int parse_line(char *line, struct resctrl_schema *s,
 	return -EINVAL;
 }
 
-static u32 get_config_index(u32 closid, enum resctrl_conf_type type)
-{
-	switch (type) {
-	default:
-	case CDP_NONE:
-		return closid;
-	case CDP_CODE:
-		return closid * 2 + 1;
-	case CDP_DATA:
-		return closid * 2;
-	}
-}
-
 int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
-	u32 idx = get_config_index(closid, t);
+	u32 idx = resctrl_get_config_index(closid, t);
 	struct msr_param msr_param;
 
 	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
@@ -338,7 +325,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 			if (!cfg->have_new_ctrl)
 				continue;
 
-			idx = get_config_index(closid, t);
+			idx = resctrl_get_config_index(closid, t);
 			if (cfg->new_ctrl == hw_dom->ctrl_val[idx])
 				continue;
 			hw_dom->ctrl_val[idx] = cfg->new_ctrl;
@@ -458,7 +445,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type)
 {
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
-	u32 idx = get_config_index(closid, type);
+	u32 idx = resctrl_get_config_index(closid, type);
 
 	return hw_dom->ctrl_val[idx];
 }
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 0359746d45f5..e07d719ace33 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -315,6 +315,21 @@ bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
 void resctrl_arch_mon_event_config_write(void *info);
 void resctrl_arch_mon_event_config_read(void *info);
 
+/* For use by arch code to remap resctrl's smaller CDP CLOSID range */
+static inline u32 resctrl_get_config_index(u32 closid,
+					   enum resctrl_conf_type type)
+{
+	switch (type) {
+	default:
+	case CDP_NONE:
+		return closid;
+	case CDP_CODE:
+		return closid * 2 + 1;
+	case CDP_DATA:
+		return closid * 2;
+	}
+}
+
 /*
  * Update the ctrl_val and apply this config right now.
  * Must be called on one of the domain's CPUs.
-- 
2.39.2


