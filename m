Return-Path: <linux-kernel+bounces-556752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34941A5CE1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5733BC447
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ABC265CDE;
	Tue, 11 Mar 2025 18:41:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013AE265CD8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718496; cv=none; b=pX0oDcuP1baFUVWprpY2ORmhOh0cHW+bUCl3LAsPT857h3CFoEyHCNecSX9QtG55zGEJ9M5dqAXQI0t2RCB+eX0o6t+TDhz0CexVXfmS4uYglzXCIFY8UEqpZFBdNpFq1ZxvBHBv7fDS7TxdnY+8ZO3jql2uAoTVProcJ8SffVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718496; c=relaxed/simple;
	bh=xuFwp+wVlNvvX6pMWaic4seoqFILwx8Tixryh/4/j98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QT0SnkMqmYzwoSnipHdNIgwWPc8wY4iN/8I0exqtRwqN+36QO31kIFVfQAl8mlNZWoPbPL30coKLN2lX9/O4SH9ha+pN32cZVr/3e+iy815GxB4RIJm7DJNV/nzCJVukf0QeuiNjbTU8OADkHloji+G+Ncnx+pSZAXm0RLmVjxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EE2C1688;
	Tue, 11 Mar 2025 11:41:41 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 271053F694;
	Tue, 11 Mar 2025 11:41:27 -0700 (PDT)
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
	Babu Moger <babu.moger@amd.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v8:for-boris 22/30] x86/resctrl: Move mbm_cfg_mask to struct rdt_resource
Date: Tue, 11 Mar 2025 18:37:07 +0000
Message-Id: <20250311183715.16445-23-james.morse@arm.com>
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

The mbm_cfg_mask field lists the bits that user-space can set when
configuring an event. This value is output via the last_cmd_status
file.

Once the filesystem parts of resctrl are moved to live in /fs/, the
struct rdt_hw_resource is inaccessible to the filesystem code. Because
this value is output to user-space, it has to be accessible to the
filesystem code.

Move it to struct rdt_resource.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
---
Changes since v5:
 * Rephrased a comment to remove one vendors marketing name for the feature.

Change since v1:
 * Reword comments to avoid being overly arch-specific.
---
 arch/x86/kernel/cpu/resctrl/internal.h | 3 ---
 arch/x86/kernel/cpu/resctrl/monitor.c  | 2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 5 ++---
 include/linux/resctrl.h                | 3 +++
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 4a5996d1e060..725f223ea07b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -417,8 +417,6 @@ struct msr_param {
  * @msr_update:		Function pointer to update QOS MSRs
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
  * @mbm_width:		Monitor width, to detect and correct for overflow.
- * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
- *			Monitoring Event Configuration (BMEC) is supported.
  * @cdp_enabled:	CDP state of this resource
  *
  * Members of this structure are either private to the architecture
@@ -432,7 +430,6 @@ struct rdt_hw_resource {
 	void			(*msr_update)(struct msr_param *m);
 	unsigned int		mon_scale;
 	unsigned int		mbm_width;
-	unsigned int		mbm_cfg_mask;
 	bool			cdp_enabled;
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 306b06ba32db..83f90128d768 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1260,7 +1260,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 
 		/* Detect list of bandwidth sources that can be tracked */
 		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
-		hw_res->mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
+		r->mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
 	}
 
 	r->mon_capable = true;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e7d1d8b6983d..a388ef66ef4c 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1731,7 +1731,6 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 
 static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 {
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	char *dom_str = NULL, *id_str;
 	unsigned long dom_id, val;
 	struct rdt_mon_domain *d;
@@ -1758,9 +1757,9 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 	}
 
 	/* Value from user cannot be more than the supported set of events */
-	if ((val & hw_res->mbm_cfg_mask) != val) {
+	if ((val & r->mbm_cfg_mask) != val) {
 		rdt_last_cmd_printf("Invalid event configuration: max valid mask is 0x%02x\n",
-				    hw_res->mbm_cfg_mask);
+				    r->mbm_cfg_mask);
 		return -EINVAL;
 	}
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 90b6563cf532..914df24ffe48 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -217,6 +217,8 @@ enum resctrl_schema_fmt {
  * @name:		Name to use in "schemata" file.
  * @schema_fmt:		Which format string and parser is used for this schema.
  * @evt_list:		List of monitoring events
+ * @mbm_cfg_mask:	Bandwidth sources that can be tracked when bandwidth
+ *			monitoring events can be configured.
  * @cdp_capable:	Is the CDP feature available on this resource
  */
 struct rdt_resource {
@@ -233,6 +235,7 @@ struct rdt_resource {
 	char			*name;
 	enum resctrl_schema_fmt	schema_fmt;
 	struct list_head	evt_list;
+	unsigned int		mbm_cfg_mask;
 	bool			cdp_capable;
 };
 
-- 
2.39.5


