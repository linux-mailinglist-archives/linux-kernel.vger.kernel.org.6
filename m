Return-Path: <linux-kernel+bounces-556753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 776F1A5CE22
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E968E3BC61D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0CB2661A7;
	Tue, 11 Mar 2025 18:41:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D6A263F42
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718496; cv=none; b=X9vkrR1k+bhR+zL4/c66czunXO4d8QKHtyPrOK8eN1/rIeCt1y0yGTLxjJX/0eeWpihAxnGMjf2xFK+wKneayHFIdKmR/yz4HbQwosyppr6KjpElkIiV9FHmqWa13LlCB+fODAbYAelfrp1aApHoo0jFmfq3IRCVZpz0WGDYdkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718496; c=relaxed/simple;
	bh=5fxu9KRrP17JgsoMLbOFGuAdmB2ILif9aNVpfILl/xo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rzDV1/3JJJMrA2AYJ6ujISSJVNfXXY0ijoTYyULseSqYAwexEGzdrDwoTVzlZfDHvvpnvyUzJJ7jhWeBnrJ99+QPpUF2fma6fJz9+GATyYqWfXQaONtyVxk/IGLxSZslieD9jI5I3I32LJyDYEEn9AGWtFmtPMZal5VKltEWljQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58A8F1515;
	Tue, 11 Mar 2025 11:41:45 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D58813F694;
	Tue, 11 Mar 2025 11:41:30 -0700 (PDT)
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
Subject: [PATCH v8:for-boris 23/30] x86/resctrl: Add resctrl_arch_ prefix to pseudo lock functions
Date: Tue, 11 Mar 2025 18:37:08 +0000
Message-Id: <20250311183715.16445-24-james.morse@arm.com>
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

resctrl's pseudo lock has some copy-to-cache and measurement
functions that are micro-architecture specific.

For example, pseudo_lock_fn() is not at all portable.

Label these 'resctrl_arch_' so they stay under /arch/x86.
To expose these functions to the filesystem code they need an entry
in a header file, and can't be marked static.

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
---
Changes since v6:
 * Removed a space.

Changes since v5:
 * Expanded commit message.
---
 arch/x86/include/asm/resctrl.h            |  5 ++++
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 36 ++++++++++++-----------
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 6d4c7ea2c9e3..86407dbde583 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -203,6 +203,11 @@ static inline void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r, int evtid
 static inline void resctrl_arch_mon_ctx_free(struct rdt_resource *r, int evtid,
 					     void *ctx) { };
 
+u64 resctrl_arch_get_prefetch_disable_bits(void);
+int resctrl_arch_pseudo_lock_fn(void *_rdtgrp);
+int resctrl_arch_measure_cycles_lat_fn(void *_plr);
+int resctrl_arch_measure_l2_residency(void *_plr);
+int resctrl_arch_measure_l3_residency(void *_plr);
 void resctrl_cpu_detect(struct cpuinfo_x86 *c);
 
 #else
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 42cc162f7fc9..1f42c1190d26 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -61,7 +61,8 @@ static const struct class pseudo_lock_class = {
 };
 
 /**
- * get_prefetch_disable_bits - prefetch disable bits of supported platforms
+ * resctrl_arch_get_prefetch_disable_bits - prefetch disable bits of supported
+ *                                          platforms
  * @void: It takes no parameters.
  *
  * Capture the list of platforms that have been validated to support
@@ -75,13 +76,13 @@ static const struct class pseudo_lock_class = {
  * in the SDM.
  *
  * When adding a platform here also add support for its cache events to
- * measure_cycles_perf_fn()
+ * resctrl_arch_measure_l*_residency()
  *
  * Return:
  * If platform is supported, the bits to disable hardware prefetchers, 0
  * if platform is not supported.
  */
-static u64 get_prefetch_disable_bits(void)
+u64 resctrl_arch_get_prefetch_disable_bits(void)
 {
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL ||
 	    boot_cpu_data.x86 != 6)
@@ -408,7 +409,7 @@ static void pseudo_lock_free(struct rdtgroup *rdtgrp)
 }
 
 /**
- * pseudo_lock_fn - Load kernel memory into cache
+ * resctrl_arch_pseudo_lock_fn - Load kernel memory into cache
  * @_rdtgrp: resource group to which pseudo-lock region belongs
  *
  * This is the core pseudo-locking flow.
@@ -426,7 +427,7 @@ static void pseudo_lock_free(struct rdtgroup *rdtgrp)
  *
  * Return: 0. Waiter on waitqueue will be woken on completion.
  */
-static int pseudo_lock_fn(void *_rdtgrp)
+int resctrl_arch_pseudo_lock_fn(void *_rdtgrp)
 {
 	struct rdtgroup *rdtgrp = _rdtgrp;
 	struct pseudo_lock_region *plr = rdtgrp->plr;
@@ -712,7 +713,7 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
 	 * Not knowing the bits to disable prefetching implies that this
 	 * platform does not support Cache Pseudo-Locking.
 	 */
-	prefetch_disable_bits = get_prefetch_disable_bits();
+	prefetch_disable_bits = resctrl_arch_get_prefetch_disable_bits();
 	if (prefetch_disable_bits == 0) {
 		rdt_last_cmd_puts("Pseudo-locking not supported\n");
 		return -EINVAL;
@@ -872,7 +873,8 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_ctrl_domain *d)
 }
 
 /**
- * measure_cycles_lat_fn - Measure cycle latency to read pseudo-locked memory
+ * resctrl_arch_measure_cycles_lat_fn - Measure cycle latency to read
+ *                                      pseudo-locked memory
  * @_plr: pseudo-lock region to measure
  *
  * There is no deterministic way to test if a memory region is cached. One
@@ -885,7 +887,7 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_ctrl_domain *d)
  *
  * Return: 0. Waiter on waitqueue will be woken on completion.
  */
-static int measure_cycles_lat_fn(void *_plr)
+int resctrl_arch_measure_cycles_lat_fn(void *_plr)
 {
 	struct pseudo_lock_region *plr = _plr;
 	u32 saved_low, saved_high;
@@ -1069,7 +1071,7 @@ static int measure_residency_fn(struct perf_event_attr *miss_attr,
 	return 0;
 }
 
-static int measure_l2_residency(void *_plr)
+int resctrl_arch_measure_l2_residency(void *_plr)
 {
 	struct pseudo_lock_region *plr = _plr;
 	struct residency_counts counts = {0};
@@ -1107,7 +1109,7 @@ static int measure_l2_residency(void *_plr)
 	return 0;
 }
 
-static int measure_l3_residency(void *_plr)
+int resctrl_arch_measure_l3_residency(void *_plr)
 {
 	struct pseudo_lock_region *plr = _plr;
 	struct residency_counts counts = {0};
@@ -1205,14 +1207,14 @@ static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
 	plr->cpu = cpu;
 
 	if (sel == 1)
-		thread = kthread_run_on_cpu(measure_cycles_lat_fn, plr,
-					    cpu, "pseudo_lock_measure/%u");
+		thread = kthread_run_on_cpu(resctrl_arch_measure_cycles_lat_fn,
+					    plr, cpu, "pseudo_lock_measure/%u");
 	else if (sel == 2)
-		thread = kthread_run_on_cpu(measure_l2_residency, plr,
-					    cpu, "pseudo_lock_measure/%u");
+		thread = kthread_run_on_cpu(resctrl_arch_measure_l2_residency,
+					    plr, cpu, "pseudo_lock_measure/%u");
 	else if (sel == 3)
-		thread = kthread_run_on_cpu(measure_l3_residency, plr,
-					    cpu, "pseudo_lock_measure/%u");
+		thread = kthread_run_on_cpu(resctrl_arch_measure_l3_residency,
+					    plr, cpu, "pseudo_lock_measure/%u");
 	else
 		goto out;
 
@@ -1307,7 +1309,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 
 	plr->thread_done = 0;
 
-	thread = kthread_run_on_cpu(pseudo_lock_fn, rdtgrp,
+	thread = kthread_run_on_cpu(resctrl_arch_pseudo_lock_fn, rdtgrp,
 				    plr->cpu, "pseudo_lock/%u");
 	if (IS_ERR(thread)) {
 		ret = PTR_ERR(thread);
-- 
2.39.5


