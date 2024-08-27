Return-Path: <linux-kernel+bounces-302608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3617D9600D6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD561C22387
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8155B145B0C;
	Tue, 27 Aug 2024 05:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ce8jNOq+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF7856458
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735382; cv=none; b=NW11o1xlxsmJPVV+vT4220YeYNwPitbOpprJqwROmVL+IRoBZGOPSTMI/iS6SP+Xl2bl36h2cjzDK/QTQxM7E6zVxkzRmcWG8X40Z707RdsI8zqLll0FWGTGPXKqlXz7/p1CKvJl2IG7D1dPrm1aP2NUuavhovyT5mm/eo6/7VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735382; c=relaxed/simple;
	bh=8m7BRzUErIAfRzt2aUpEvMJTMH5Swkur4vUpuj50EOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=p/5rz4R7rMhuGhT7u2+DuMmg3E/gPby/wHqVL1owosLIZcmtLrW7oHnb3a/JQRkJaPMh5ovv6o//tX+7fyf2ihuePYs3qYdnuBMihxaqVFfwsLsYGLOWtq+zO/cK+I58Ol+cuY7YwuAoKPojTO8klu9ftrmBe7FhFtwhkh49pEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ce8jNOq+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724735381; x=1756271381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=8m7BRzUErIAfRzt2aUpEvMJTMH5Swkur4vUpuj50EOw=;
  b=Ce8jNOq+6zQPybsYemdAqOFusutuph988IOdrnN6/VNtHBaptsaujcw+
   tlfZTgC9Q50ZoDAqXtterFiDL0ga5fqGfwnBt/5ai+mrcKZiVqh5UIfmK
   sYIrpMjxP+iiz1V7J3J0SIzLkaeUTZJZ47/+FqW/8JP6rsQA094IYC85L
   geH21Ew72kX2fPgQEon5DrvylQhUocd+SC4Do+hd++YTHhhzen2fHPIxZ
   izRW4zkjilfZlJrw93jBfuzyXxR6GyDpqUjPAjSZRMbE52djWZ4tQ9R7J
   P2IWwcw7eLy7NSzj6/z9pywHaUxQ/ch+at1iooYaiQ9S4FuA8ZTsx1bNL
   w==;
X-CSE-ConnectionGUID: mr7xkTjPRfC6nMiM1hCsBA==
X-CSE-MsgGUID: 4bQmao+RQ5iZHlLr9vVwOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="13230482"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="13230482"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 22:09:39 -0700
X-CSE-ConnectionGUID: T/tEQ8O7QzWPUhkyZHcw8w==
X-CSE-MsgGUID: iQnm5bk0R+m2IHOWeG5LVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="62703862"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa009.jf.intel.com with ESMTP; 26 Aug 2024 22:09:38 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: x86@kernel.org
Cc: Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>,
	Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] x86/cacheinfo: Delete global num_cache_leaves
Date: Mon, 26 Aug 2024 22:16:34 -0700
Message-Id: <20240827051635.9114-4-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com>
References: <20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Linux remembers cpu_cachinfo::num_leaves per CPU, but x86 initializes all
CPUs from the same global "num_cache_leaves".

This is erroneous on systems such as Meteor Lake, where each CPU has a
distinct num_leaves value. Delete the global "num_cache_leaves" and
initialize num_leaves on each CPU.

Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Cc: Andreas Herrmann <aherrmann@suse.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>
Cc: Radu Rendec <rrendec@redhat.com>
Cc: Pierre Gondois <Pierre.Gondois@arm.com>
Cc: Pu Wen <puwen@hygon.cn>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Will Deacon <will@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org # 6.3+
---
After this change, all CPUs will traverse CPUID leaf 0x4 when booted for
the first time. On systems with symmetric cache topologies this is
useless work.

Creating a list of processor models that have asymmetric cache topologies
was considered. The burden of maintaining such list would outweigh the
performance benefit of skipping this extra step.
---
Changes since v4:
 * None

Changes since v3:
 * Rebased on v6.7-rc5.

Changes since v2:
 * None

Changes since v1:
 * Do not make num_cache_leaves a per-CPU variable. Instead, reuse the
   existing per-CPU ci_cpu_cacheinfo variable. (Dave Hansen)
---
 arch/x86/kernel/cpu/cacheinfo.c | 44 +++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 392d09c936d6..b5e216677a46 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -178,7 +178,16 @@ struct _cpuid4_info_regs {
 	struct amd_northbridge *nb;
 };
 
-static unsigned short num_cache_leaves;
+static inline unsigned int get_num_cache_leaves(unsigned int cpu)
+{
+	return get_cpu_cacheinfo(cpu)->num_leaves;
+}
+
+static inline void
+set_num_cache_leaves(unsigned int nr_leaves, unsigned int cpu)
+{
+	get_cpu_cacheinfo(cpu)->num_leaves = nr_leaves;
+}
 
 /* AMD doesn't have CPUID4. Emulate it here to report the same
    information to the user.  This makes some assumptions about the machine:
@@ -718,19 +727,21 @@ void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c)
 void init_amd_cacheinfo(struct cpuinfo_x86 *c)
 {
 
+	unsigned int cpu = c->cpu_index;
+
 	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
-		num_cache_leaves = find_num_cache_leaves(c);
+		set_num_cache_leaves(find_num_cache_leaves(c), cpu);
 	} else if (c->extended_cpuid_level >= 0x80000006) {
 		if (cpuid_edx(0x80000006) & 0xf000)
-			num_cache_leaves = 4;
+			set_num_cache_leaves(4, cpu);
 		else
-			num_cache_leaves = 3;
+			set_num_cache_leaves(3, cpu);
 	}
 }
 
 void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
 {
-	num_cache_leaves = find_num_cache_leaves(c);
+	set_num_cache_leaves(find_num_cache_leaves(c), c->cpu_index);
 }
 
 void init_intel_cacheinfo(struct cpuinfo_x86 *c)
@@ -742,19 +753,19 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 	unsigned int l2_id = 0, l3_id = 0, num_threads_sharing, index_msb;
 
 	if (c->cpuid_level > 3) {
-		static int is_initialized;
-
-		if (is_initialized == 0) {
-			/* Init num_cache_leaves from boot CPU */
-			num_cache_leaves = find_num_cache_leaves(c);
-			is_initialized++;
-		}
+		/*
+		 * There should be at least one leaf. A non-zero value means
+		 * that the number of leaves has been initialized.
+		 */
+		if (!get_num_cache_leaves(c->cpu_index))
+			set_num_cache_leaves(find_num_cache_leaves(c),
+					     c->cpu_index);
 
 		/*
 		 * Whenever possible use cpuid(4), deterministic cache
 		 * parameters cpuid leaf to find the cache details
 		 */
-		for (i = 0; i < num_cache_leaves; i++) {
+		for (i = 0; i < get_num_cache_leaves(c->cpu_index); i++) {
 			struct _cpuid4_info_regs this_leaf = {};
 			int retval;
 
@@ -790,14 +801,14 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 	 * Don't use cpuid2 if cpuid4 is supported. For P4, we use cpuid2 for
 	 * trace cache
 	 */
-	if ((num_cache_leaves == 0 || c->x86 == 15) && c->cpuid_level > 1) {
+	if ((!get_num_cache_leaves(c->cpu_index) || c->x86 == 15) && c->cpuid_level > 1) {
 		/* supports eax=2  call */
 		int j, n;
 		unsigned int regs[4];
 		unsigned char *dp = (unsigned char *)regs;
 		int only_trace = 0;
 
-		if (num_cache_leaves != 0 && c->x86 == 15)
+		if (get_num_cache_leaves(c->cpu_index) && c->x86 == 15)
 			only_trace = 1;
 
 		/* Number of times to iterate */
@@ -993,12 +1004,9 @@ int init_cache_level(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 
-	if (!num_cache_leaves)
-		return -ENOENT;
 	if (!this_cpu_ci)
 		return -EINVAL;
 	this_cpu_ci->num_levels = 3;
-	this_cpu_ci->num_leaves = num_cache_leaves;
 	return 0;
 }
 
-- 
2.34.1


