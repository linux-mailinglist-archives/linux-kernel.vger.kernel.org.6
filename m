Return-Path: <linux-kernel+bounces-350899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D936990ABD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FAE6B25442
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E8C2216BA;
	Fri,  4 Oct 2024 18:07:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7C622169A
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065233; cv=none; b=tBwxSz/fUAl+cS2hpuyfzC/4QaWXodRj/EWY3E+GOhV8DfbbrSJgghSkgy60XGanx0qAGZY5mS5vsax1PyJTTzV4ZqwNIdH80zx78uv7gYsUr3vB1TtaQBJ2622rcH9eS1inriX3xvgSUPnRUwIlSaDlwAUfj1htpgg6uPQleCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065233; c=relaxed/simple;
	bh=keffTLbPy6CIm228e9K0Pai78e+9amj/h040QSFRGr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PU/fxFCUF0Y51eHs5h05KR13MSsOm093/UhcKA9IzWZnM/uogmt/9P96rcM3KYvSY+IF3cMJJBhJXMb8IUf6YLHNnQ/anBUNveYXmTGHtIB4bkWBZsu78exNDsJyYEZ7EebNZ/4j09MTs/WpsMHmB2jB39UJmTbp8Rb3wAuJNwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4D7E150C;
	Fri,  4 Oct 2024 11:07:40 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 226883F58B;
	Fri,  4 Oct 2024 11:07:08 -0700 (PDT)
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
Subject: [PATCH v5 39/40] x86/resctrl: Move the filesystem bits to headers visible to fs/resctrl
Date: Fri,  4 Oct 2024 18:03:46 +0000
Message-Id: <20241004180347.19985-40-james.morse@arm.com>
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
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
Changes since v3:
 * Changed the number of hyphens at the end of the commit message.

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
index 22e508c10059..332b0617d728 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -212,6 +212,9 @@ int resctrl_arch_measure_l2_residency(void *_plr);
 int resctrl_arch_measure_l3_residency(void *_plr);
 void resctrl_cpu_detect(struct cpuinfo_x86 *c);
 
+bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l);
+int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
+
 #else
 
 static inline void resctrl_arch_sched_in(struct task_struct *tsk) {}
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index ec7d244d8511..816d9af6b36b 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -289,6 +289,11 @@ static void rdt_get_cdp_l2_config(void)
 	rdt_get_cdp_config(RDT_RESOURCE_L2);
 }
 
+bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
+{
+	return rdt_resources_all[l].cdp_enabled;
+}
+
 static void mba_wrmsr_amd(struct msr_param *m)
 {
 	struct rdt_hw_ctrl_domain *hw_dom = resctrl_to_arch_ctrl_dom(m->dom);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 973fddf7e9a3..d1de46a62416 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -17,8 +17,6 @@
 #define CQM_LIMBOCHECK_INTERVAL	1000
 
 #define MBM_CNTR_WIDTH_BASE		24
-#define MBM_OVERFLOW_INTERVAL		1000
-#define MAX_MBA_BW			100u
 #define MBA_IS_LINEAR			0x4
 #define MBM_CNTR_WIDTH_OFFSET_AMD	20
 
@@ -404,13 +402,6 @@ extern struct rdt_hw_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
 extern struct dentry *debugfs_resctrl;
 
-static inline bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
-{
-	return rdt_resources_all[l].cdp_enabled;
-}
-
-int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
-
 void arch_mon_domain_online(struct rdt_resource *r, struct rdt_mon_domain *d);
 
 /* CPUID.(EAX=10H, ECX=ResID=1).EAX */
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


