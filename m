Return-Path: <linux-kernel+bounces-327770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 568DF977AEB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D781C245F9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FC21D6C66;
	Fri, 13 Sep 2024 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jK9e4af6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F091D67B4
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726215976; cv=none; b=KC6UE722ZYKxaAAr3jkgu2iPQFECFzJXoZo0bChsbXoebMPXhZo8i2Ta4bzeC8dlfX+N5XV1TTQDVTk/SsG+d3TLpNTjc/NRYPaNGuFksZdIZ8+/dssQDKy7Pev852S1n+FlTMFXXDLUdSZxlJRWytCqXFKr5Trld6WuDWPEqso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726215976; c=relaxed/simple;
	bh=PcJl2+cEF+bRzQuqeAjuEPnGZ6EOblSbeWsQbeMWdEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uG9InoelVINFSafU8SuTV4IPw40hqmEbZWvM/sVp09y7XP/PUxEIm+C0e5lKDqQqSLVxWYm6v2aV/RQfSleenchXpoKt4lGz02+AjVtXQrY4Y9w2UB84x1EYqhHpr0fq7ygwAcdb2lqTlASVKdttBEjHb6kIFHI1DUzBB06CglU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jK9e4af6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726215975; x=1757751975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=PcJl2+cEF+bRzQuqeAjuEPnGZ6EOblSbeWsQbeMWdEI=;
  b=jK9e4af6TxKbHGSf10z+STm3dA/IITDTWoBbZ+QYY1MlUE7PYM1iTo8T
   6RskEVEVVDfon8aiY3fbRJaqFShQRxTbkWbVvSAe1ZZIC/b3NIzu/jC/3
   nyLvoeadyCYKITc77jmB7svL31lw+kguIAh63QtugLcYkDf+365c58Ma2
   QII435SWe9G3RB8Ait0DYcNmIlkAx4KVeDSDqr05H8ClqkgT9K2W/NtQb
   njs2r/5I6vQAr2EmRjbk77W3G9U8uaJhBAGiiJKtj1G6Xuo8XP8ckOoMl
   YhbRTsM5jCMIUM49kKggaNK7lw4B9jTRCPOXxRTDmGZmdEjLnwGzdWeBB
   w==;
X-CSE-ConnectionGUID: 1um7ID9nQSaNkG3w+VVmDA==
X-CSE-MsgGUID: GBeChEkAR1m1/hyaYEDgQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24977577"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="24977577"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 01:26:13 -0700
X-CSE-ConnectionGUID: Q+eoR1T9QpuzLoxhH++z5g==
X-CSE-MsgGUID: 5qz4hpHkQvC2PUWaTB8gLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="68485435"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa007.jf.intel.com with ESMTP; 13 Sep 2024 01:26:13 -0700
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
Subject: [PATCH v7 2/3] x86/cacheinfo: Delete global num_cache_leaves
Date: Fri, 13 Sep 2024 01:31:54 -0700
Message-Id: <20240913083155.9783-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240913083155.9783-1-ricardo.neri-calderon@linux.intel.com>
References: <20240913083155.9783-1-ricardo.neri-calderon@linux.intel.com>
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

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
Reviewed-by: Len Brown <len.brown@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Tested-by: Andreas Herrmann <aherrmann@suse.de>
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
Changes since v5:
 * Reordered the arguments of set_num_cache_leaves() for readability.
   (Nikolay)
 * Added Reviewed-by tag from Nikolay and Andreas. Thanks!
 * Added Tested-by tag from Andreas. Thanks!

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
index 392d09c936d6..182cacd772b8 100644
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
+set_num_cache_leaves(unsigned int cpu, unsigned int nr_leaves)
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
+		set_num_cache_leaves(cpu, find_num_cache_leaves(c));
 	} else if (c->extended_cpuid_level >= 0x80000006) {
 		if (cpuid_edx(0x80000006) & 0xf000)
-			num_cache_leaves = 4;
+			set_num_cache_leaves(cpu, 4);
 		else
-			num_cache_leaves = 3;
+			set_num_cache_leaves(cpu, 3);
 	}
 }
 
 void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
 {
-	num_cache_leaves = find_num_cache_leaves(c);
+	set_num_cache_leaves(c->cpu_index, find_num_cache_leaves(c));
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
+			set_num_cache_leaves(c->cpu_index,
+					     find_num_cache_leaves(c));
 
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


