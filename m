Return-Path: <linux-kernel+bounces-556759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A681EA5CE23
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A708C7AB381
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D71266B5B;
	Tue, 11 Mar 2025 18:41:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D23264A67
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718518; cv=none; b=uZ5ilf/DkYXuk3VIjDwkuXTMGKNPebUcpbULPC4Ktp80CI6zmA4GXDqufI+hwgJjNPWJQh5OYORa7G0MrcD488h4/wr2+NIoYesu6kBLGSd1AByNUn8ffXnCGHBXVW4q5ShH+tb9CiqtO3YXvq6a6ecj2uOFU3XeGQpd4HEI+nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718518; c=relaxed/simple;
	bh=V3ADyWurwLqs9Gx2RToM+kdldoyovN0x21VsziBo4OE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NLz9sgR3qEPbX1uB+BvkqQEYuRaPawjBQ8akSPPIiJrTHbccVKFYqrOwrSAEsWAqsf2PXJfdRSuY0YYFrjqF3OvpYHX/Qay2qMVUeb+5eBS3Es98EOZT1sNjNgYpCWMfQxRLaTCbLXx7n2OyL4SjL8GmMFu1Xd9s+qGuwoCnkbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B7ED1713;
	Tue, 11 Mar 2025 11:42:07 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAE0E3F694;
	Tue, 11 Mar 2025 11:41:52 -0700 (PDT)
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
	Babu Moger <babu.moger@amd.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v8:for-boris 29/30] x86/resctrl: Move get_config_index() to a header
Date: Tue, 11 Mar 2025 18:37:14 +0000
Message-Id: <20250311183715.16445-30-james.morse@arm.com>
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

get_config_index() is used by the architecture specific code to map a
CLOSID+type pair to an index in the configuration arrays.

MPAM needs to do this too to preserve the ABI to user-space, there is
no reason to do it differently.

Move the helper to a header file to allow all architectures that either
use or emulate CDP to use the same pattern of CLOSID values. Moving
this to a header file means it must be marked inline, which matches
the existing compiler choice for this static function.

Co-developed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since v6:
 * Expanded the last paragraph of the commit message.

Changes since v1:
 * Reindent resctrl_get_config_index() as per coding-style.rst rules.
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 19 +++----------------
 include/linux/resctrl.h                   | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 1ecc93282b7d..0a0ac5f6112e 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -287,25 +287,12 @@ static int parse_line(char *line, struct resctrl_schema *s,
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
 int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
 {
 	struct rdt_hw_ctrl_domain *hw_dom = resctrl_to_arch_ctrl_dom(d);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	u32 idx = get_config_index(closid, t);
+	u32 idx = resctrl_get_config_index(closid, t);
 	struct msr_param msr_param;
 
 	if (!cpumask_test_cpu(smp_processor_id(), &d->hdr.cpu_mask))
@@ -342,7 +329,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 			if (!cfg->have_new_ctrl)
 				continue;
 
-			idx = get_config_index(closid, t);
+			idx = resctrl_get_config_index(closid, t);
 			if (cfg->new_ctrl == hw_dom->ctrl_val[idx])
 				continue;
 			hw_dom->ctrl_val[idx] = cfg->new_ctrl;
@@ -462,7 +449,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 			    u32 closid, enum resctrl_conf_type type)
 {
 	struct rdt_hw_ctrl_domain *hw_dom = resctrl_to_arch_ctrl_dom(d);
-	u32 idx = get_config_index(closid, type);
+	u32 idx = resctrl_get_config_index(closid, type);
 
 	return hw_dom->ctrl_val[idx];
 }
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 226cc5c0d765..880351ca3dfc 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -384,6 +384,21 @@ void resctrl_arch_mon_event_config_write(void *config_info);
  */
 void resctrl_arch_mon_event_config_read(void *config_info);
 
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
2.39.5


