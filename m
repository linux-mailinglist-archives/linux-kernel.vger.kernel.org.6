Return-Path: <linux-kernel+bounces-556747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C77A5CE17
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68000164B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0A4265622;
	Tue, 11 Mar 2025 18:41:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA6E2641FE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718474; cv=none; b=aGbo8ImfVojgYROGmy9QPhV+pKAigeYEPoe4JOYoZfbPskpAK2WmfzoSqhI7k/o2Hs46QwrekE/lFHGvW35sVZ2jD75aW+hUDSd79NT1J1RmECfAosvAS7lNgoFmk4N/RBVIZr5QCeA4ockH3otVAi2LwrPn3xKD41Wursvh5sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718474; c=relaxed/simple;
	bh=9EDGNR8q/Byw6s/pdROjytw0PMfwTkAveK7IuHkf4XA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tVa/Rds7FZMc9POShYjngOegGG7RJHT/MSxnymlq/8Eag9Xj8JX/Ar/KsrLPCOkvM3D5aqRRmnwr+XQQMrlHXb6CSd1AK7pwsBA42BkVN3ZmlBMB7ZqokKk02uDzDxZviRrKmCmbVeGg1gRmSwX7Qf9jvJXM4WU6SCYQhEU/OiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8F2B1515;
	Tue, 11 Mar 2025 11:41:22 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 713D23F694;
	Tue, 11 Mar 2025 11:41:08 -0700 (PDT)
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
Subject: [PATCH v8:for-boris 17/30] x86/resctrl: Rewrite and move the for_each_*_rdt_resource() walkers
Date: Tue, 11 Mar 2025 18:37:02 +0000
Message-Id: <20250311183715.16445-18-james.morse@arm.com>
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

The for_each_*_rdt_resource() helpers walk the architecture's array
of structures, using the resctrl visible part as an iterator. These
became over-complex when the structures were split into a
filesystem and architecture-specific struct. This approach avoided
the need to touch every call site, and was done before there was a
helper to retrieve a resource by rid.

Once the filesystem parts of resctrl are moved to /fs/, both the
architecture's resource array, and the definition of those structures
is no longer accessible. To support resctrl, each architecture would
have to provide equally complex macros.

Rewrite the macro to make use of resctrl_arch_get_resource(), and
move these to include/linux/resctrl.h so existing x86 arch code continues
to use them.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
---
Changes since v5:
 * Fixed an off by one in for_each_rdt_resource().
 * Added header file path to commit message.

Changes since v3:
 * Restructure the existing macros instead of open-coding the for loop.

Changes since v1:
 * [Whitespace only] Fix bogus whitespace introduced in
   rdtgroup_create_info_dir().

 * [Commit message only] Typo fix:
   s/architectures/architecture's/g
---
 arch/x86/kernel/cpu/resctrl/internal.h | 29 --------------------------
 include/linux/resctrl.h                | 18 ++++++++++++++++
 2 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 70fbb902e85e..82dbc1606663 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -475,14 +475,6 @@ extern struct rdtgroup rdtgroup_default;
 extern struct dentry *debugfs_resctrl;
 extern enum resctrl_event_id mba_mbps_default_event;
 
-static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
-{
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(res);
-
-	hw_res++;
-	return &hw_res->r_resctrl;
-}
-
 static inline bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
 {
 	return rdt_resources_all[l].cdp_enabled;
@@ -492,27 +484,6 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
 
 void arch_mon_domain_online(struct rdt_resource *r, struct rdt_mon_domain *d);
 
-/*
- * To return the common struct rdt_resource, which is contained in struct
- * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
- */
-#define for_each_rdt_resource(r)					      \
-	for (r = &rdt_resources_all[0].r_resctrl;			      \
-	     r <= &rdt_resources_all[RDT_NUM_RESOURCES - 1].r_resctrl;	      \
-	     r = resctrl_inc(r))
-
-#define for_each_capable_rdt_resource(r)				      \
-	for_each_rdt_resource(r)					      \
-		if (r->alloc_capable || r->mon_capable)
-
-#define for_each_alloc_capable_rdt_resource(r)				      \
-	for_each_rdt_resource(r)					      \
-		if (r->alloc_capable)
-
-#define for_each_mon_capable_rdt_resource(r)				      \
-	for_each_rdt_resource(r)					      \
-		if (r->mon_capable)
-
 /* CPUID.(EAX=10H, ECX=ResID=1).EAX */
 union cpuid_0x10_1_eax {
 	struct {
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 487b9657a7b5..a392480dc4b6 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -26,6 +26,24 @@ int proc_resctrl_show(struct seq_file *m,
 /* max value for struct rdt_domain's mbps_val */
 #define MBA_MAX_MBPS   U32_MAX
 
+/* Walk all possible resources, with variants for only controls or monitors. */
+#define for_each_rdt_resource(_r)						\
+	for ((_r) = resctrl_arch_get_resource(0);				\
+	     (_r) && (_r)->rid < RDT_NUM_RESOURCES;				\
+	     (_r) = resctrl_arch_get_resource((_r)->rid + 1))
+
+#define for_each_capable_rdt_resource(r)				      \
+	for_each_rdt_resource((r))					      \
+		if ((r)->alloc_capable || (r)->mon_capable)
+
+#define for_each_alloc_capable_rdt_resource(r)				      \
+	for_each_rdt_resource((r))					      \
+		if ((r)->alloc_capable)
+
+#define for_each_mon_capable_rdt_resource(r)				      \
+	for_each_rdt_resource((r))					      \
+		if ((r)->mon_capable)
+
 /**
  * enum resctrl_conf_type - The type of configuration.
  * @CDP_NONE:	No prioritisation, both code and data are controlled or monitored.
-- 
2.39.5


