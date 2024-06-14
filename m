Return-Path: <linux-kernel+bounces-215105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE9B908E36
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29871C20E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DC61AED4A;
	Fri, 14 Jun 2024 15:03:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA50181B84
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377395; cv=none; b=l8kpFlUYAoMzNgRI0FB8YG349DGhbafSoTH5l8aNhKBKka9mFBBBX0YCsqeuP2mlcoM+epG5IV2b5Ieud+BAW+joKEeCA24zA7u4gXTaQSpeg4gmQB/Pv0c5PL9H1Ojt4sowZ50NTVoRolYFSmxxrBYHShS2LR58sHRxnrn+uwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377395; c=relaxed/simple;
	bh=vvq7PgOlZmsbGlHC21TeGpD/uH1GRSIrOX5XJ1/VWcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r1XWRp6AeucAFFqRVDnKGZEnajUs43BCIeszu2fMs8dIqJFXBDDGjMeQ4jMZqgnHK+Hm2/4S5DjSczyyVYhi8WIZO9QSrZPGyY4/2+/ALXdmPTOsbU58RH+o4gmvX+BlYlxShnEkCzsLgRiG20O/nLhcesM+jrQvbBy9nK2N4vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D49B1C25;
	Fri, 14 Jun 2024 08:03:37 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 703DA3F5A1;
	Fri, 14 Jun 2024 08:03:09 -0700 (PDT)
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
Subject: [PATCH v3 37/38] x86/resctrl: Move the filesystem bits to headers visible to fs/resctrl
Date: Fri, 14 Jun 2024 15:00:32 +0000
Message-Id: <20240614150033.10454-38-james.morse@arm.com>
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

Once the filesystem parts of resctrl move to fs/resctrl, it cannot rely
on definitions in x86's internal.h.

Move definitions in internal.h that need to be shared between the
filesystem and architecture code to header files that fs/resctrl can
include.

Doing this separately means the filesystem code only moves between files
of the same name, instead of having these changes mixed in too.

Co-developed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
----
Changes since v2:
 * Dropped the rfflags and some other defines from being moved.

Changes since v1:
 * Revert apparently unintentional duplication of a couple of variable
   declarations in <linux/resctrl.h>.

   No functional change.
---
 arch/x86/include/asm/resctrl.h         | 3 +++
 arch/x86/kernel/cpu/resctrl/core.c     | 5 +++++
 arch/x86/kernel/cpu/resctrl/internal.h | 9 ---------
 include/linux/resctrl_types.h          | 3 +++
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 491342f56811..746431c66fc4 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -218,6 +218,9 @@ int resctrl_arch_measure_l2_residency(void *_plr);
 int resctrl_arch_measure_l3_residency(void *_plr);
 void resctrl_cpu_detect(struct cpuinfo_x86 *c);
 
+bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l);
+int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
+
 #else
 
 static inline void resctrl_arch_sched_in(struct task_struct *tsk) {}
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index cb8119d58c30..b8e4a7a2ebb8 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -283,6 +283,11 @@ static void rdt_get_cdp_l2_config(void)
 	rdt_get_cdp_config(RDT_RESOURCE_L2);
 }
 
+bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
+{
+	return rdt_resources_all[l].cdp_enabled;
+}
+
 static void mba_wrmsr_amd(struct msr_param *m)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(m->res);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 6f6785a31efe..40704445ac38 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -17,8 +17,6 @@
 #define CQM_LIMBOCHECK_INTERVAL	1000
 
 #define MBM_CNTR_WIDTH_BASE		24
-#define MBM_OVERFLOW_INTERVAL		1000
-#define MAX_MBA_BW			100u
 #define MBA_IS_LINEAR			0x4
 #define MBM_CNTR_WIDTH_OFFSET_AMD	20
 
@@ -371,13 +369,6 @@ static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
 	return &hw_res->r_resctrl;
 }
 
-static inline bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
-{
-	return rdt_resources_all[l].cdp_enabled;
-}
-
-int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
-
 /*
  * To return the common struct rdt_resource, which is contained in struct
  * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index 70226f5ab3e3..b84a6e0834a7 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -7,6 +7,9 @@
 #ifndef __LINUX_RESCTRL_TYPES_H
 #define __LINUX_RESCTRL_TYPES_H
 
+#define MAX_MBA_BW			100u
+#define MBM_OVERFLOW_INTERVAL		1000
+
 /* Reads to Local DRAM Memory */
 #define READS_TO_LOCAL_MEM		BIT(0)
 
-- 
2.39.2


