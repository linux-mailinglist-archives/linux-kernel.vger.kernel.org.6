Return-Path: <linux-kernel+bounces-272920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BB5946282
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFA61C22D73
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A213DABF2;
	Fri,  2 Aug 2024 17:31:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A813DABE6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619872; cv=none; b=FK1hReXofAiWvX/lhsymbHk/s1U/pTDO0Kfoye3cRXeHh+iAeSRbmgPKXN4RdOMPkID+F32g8sX6EO8/rf1y3dufsH4OxPFSdHTw2U+RrmQCgSxnJSgz0+4I9OuDPCR0ZR36pXnUD/Lo1ziYcQKQ9o5+N6HPVmkuevyv95RxPFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619872; c=relaxed/simple;
	bh=T9WEkxWr7n6Vk6wIvEegSZ7gxF/Yg38gqCHxEup3N64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CgHgaNwbcs3NZWkbm9bH2GJ37tVTjxnVlTFUFV0ChvlIQbkhbAOmdfRgZjGBcNK4ZuXpHqOXgglqHZYhsl7/wgaWVVDjOGQYQM5HN5hTHlsqlQcemDA2Ghr+SAgb5LYlLrbaCGVBc6kBRz892Lp4IPrXX1Fc7eHwXy+CC1RZv8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6416C1007;
	Fri,  2 Aug 2024 10:31:36 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA70A3F64C;
	Fri,  2 Aug 2024 10:31:07 -0700 (PDT)
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
Subject: [PATCH v4 21/39] x86/resctrl: Move mbm_cfg_mask to struct rdt_resource
Date: Fri,  2 Aug 2024 17:28:35 +0000
Message-Id: <20240802172853.22529-22-james.morse@arm.com>
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
---
Change since v1:
 * Reword comments to avoid being overly arch-specific.
---
 arch/x86/kernel/cpu/resctrl/internal.h | 3 ---
 arch/x86/kernel/cpu/resctrl/monitor.c  | 2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 5 ++---
 include/linux/resctrl.h                | 3 +++
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 72c8fc2a5d44..87cf2d854205 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -415,8 +415,6 @@ struct msr_param {
  * @msr_update:		Function pointer to update QOS MSRs
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
  * @mbm_width:		Monitor width, to detect and correct for overflow.
- * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
- *			Monitoring Event Configuration (BMEC) is supported.
  * @cdp_enabled:	CDP state of this resource
  *
  * Members of this structure are either private to the architecture
@@ -430,7 +428,6 @@ struct rdt_hw_resource {
 	void			(*msr_update)(struct msr_param *m);
 	unsigned int		mon_scale;
 	unsigned int		mbm_width;
-	unsigned int		mbm_cfg_mask;
 	bool			cdp_enabled;
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index ae8552ef98e6..175fd7dbf34f 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1256,7 +1256,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 
 		/* Detect list of bandwidth sources that can be tracked */
 		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
-		hw_res->mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
+		r->mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
 	}
 
 	r->mon_capable = true;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 26905d76dec1..714cc54006e6 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1722,7 +1722,6 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 
 static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 {
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	char *dom_str = NULL, *id_str;
 	unsigned long dom_id, val;
 	struct rdt_mon_domain *d;
@@ -1749,9 +1748,9 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
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
index ab7d6f5e99a8..ef82420ef385 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -219,6 +219,8 @@ enum resctrl_schema_fmt {
  * @name:		Name to use in "schemata" file.
  * @schema_fmt:	Which format string and parser is used for this schema.
  * @evt_list:		List of monitoring events
+ * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
+ *			Monitoring Event Configuration (BMEC) is supported.
  * @cdp_capable:	Is the CDP feature available on this resource
  */
 struct rdt_resource {
@@ -235,6 +237,7 @@ struct rdt_resource {
 	char			*name;
 	enum resctrl_schema_fmt	schema_fmt;
 	struct list_head	evt_list;
+	unsigned int		mbm_cfg_mask;
 	bool			cdp_capable;
 };
 
-- 
2.39.2


