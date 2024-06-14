Return-Path: <linux-kernel+bounces-215088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C16908E24
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A011C25257
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42FF1A38D7;
	Fri, 14 Jun 2024 15:02:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5651A2C1E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377341; cv=none; b=hNRK/nrAlVroBjAK9Q+UVBL/bsQRks4lfresouaUHJL+uwI32dW29NHIL3egldeyHP9xjITOEf2gqtgxaEkuB4o5nVUXeNGLW7Lx3OzTTP9ChMfJRo08srvHiHc26uSy+9ODg1awrmad4pM/ydrR/GWD1FBclTnKInP0BgRE4u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377341; c=relaxed/simple;
	bh=SaacYyUK4VA0ZIK3QWS+qg+UtFV1Fzhe6PY45KSG2z8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eXAwxDhSR76UbFqM/esmu4EfHsVciRYtt43vOoOP6b9EOmGvT4fdfGUSymPKtk3bGPNXAf3Pg51xo7Er998Id5RTAu86SWRpm4D8dFz8icoMagZ4iofV6sBqy2KJ3F5JTEt61Q/p/hYAj5gDShYsPQybX67uLAUkP7x5m7J9epo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF60B1A2D;
	Fri, 14 Jun 2024 08:02:43 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28FAF3F5A1;
	Fri, 14 Jun 2024 08:02:16 -0700 (PDT)
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
Subject: [PATCH v3 21/38] x86/resctrl: Move mbm_cfg_mask to struct rdt_resource
Date: Fri, 14 Jun 2024 15:00:16 +0000
Message-Id: <20240614150033.10454-22-james.morse@arm.com>
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

The mbm_cfg_mask field lists the bits that user-space can set when
configuring an event. This value is output via the last_cmd_status
file.

Once the filesystem parts of resctrl are moved to live in /fs/, the
struct rdt_hw_resource is inaccessible to the filesystem code. Because
this value is output to user-space, it has to be accessible to the
filesystem code.

Move it to struct rdt_resource.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
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
index 06e80356cdbb..85a5c6e83fad 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -374,8 +374,6 @@ struct msr_param {
  * @msr_update:		Function pointer to update QOS MSRs
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
  * @mbm_width:		Monitor width, to detect and correct for overflow.
- * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
- *			Monitoring Event Configuration (BMEC) is supported.
  * @cdp_enabled:	CDP state of this resource
  *
  * Members of this structure are either private to the architecture
@@ -389,7 +387,6 @@ struct rdt_hw_resource {
 	void			(*msr_update)(struct msr_param *m);
 	unsigned int		mon_scale;
 	unsigned int		mbm_width;
-	unsigned int		mbm_cfg_mask;
 	bool			cdp_enabled;
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 5906dccfb247..a09f5ed929d3 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1079,7 +1079,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 
 		/* Detect list of bandwidth sources that can be tracked */
 		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
-		hw_res->mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
+		r->mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
 	}
 
 	r->mon_capable = true;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 45c9b8b76cca..0446d30db4da 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1729,7 +1729,6 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 
 static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 {
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	char *dom_str = NULL, *id_str;
 	unsigned long dom_id, val;
 	struct rdt_domain *d;
@@ -1756,9 +1755,9 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
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
index 65f0a2d17e4b..b04744b00f6f 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -167,6 +167,8 @@ enum resctrl_schema_fmt {
  * @name:		Name to use in "schemata" file.
  * @schema_fmt:	Which format string and parser is used for this schema.
  * @evt_list:		List of monitoring events
+ * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
+ *			Monitoring Event Configuration (BMEC) is supported.
  * @cdp_capable:	Is the CDP feature available on this resource
  */
 struct rdt_resource {
@@ -181,6 +183,7 @@ struct rdt_resource {
 	char			*name;
 	enum resctrl_schema_fmt	schema_fmt;
 	struct list_head	evt_list;
+	unsigned int		mbm_cfg_mask;
 	bool			cdp_capable;
 };
 
-- 
2.39.2


