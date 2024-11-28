Return-Path: <linux-kernel+bounces-424065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B539DB033
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B5F281FE1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0EE17C8D;
	Thu, 28 Nov 2024 00:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TM8rP/n+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B848825
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732752965; cv=none; b=oLDSo8WzcAkPRHiBoFNRu0ohtQSwWPqExzEAuBBttxi/6JC7x498lYN9rb8JmapwDfkF1vS7wAKv/5QSNzSPeRudDhzgPulIj98L03aUL9YKABoD+GmiZAPUKm3jZ+HzWHgha/cDCDJiNN3HHG5WdfvB+rFCiKP+sLmOt4NDKqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732752965; c=relaxed/simple;
	bh=hQ0HlZAq9Tfv1Q5WYZ8FA3c9XcNnrLCaZhXVOK8p6DY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pjuLfxc7/cMUn7WoKkQLjPxtQE8mrQL7jaYfP2bdpcUG6xUNALtOmeSkmg+Ylp8EUTp1829MCT+uv6XpYteiAinGH/6SbjFDtafWctxRRLO59abR8H1fIIMKz9wjhr39jJc+TEKilQ9EyPWaO1Hfqs6f71B8kyxUJZmpZi5DLJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TM8rP/n+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732752962; x=1764288962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=hQ0HlZAq9Tfv1Q5WYZ8FA3c9XcNnrLCaZhXVOK8p6DY=;
  b=TM8rP/n+TS2G88plNLy2bCzZA9S+B/EXwje44d+jByCtcR51flMkZ6EZ
   84rjn+s+sNUNH7zuFBFhR3UfWCmDMpQakJZbWi3XvOjKzZd1sY7Bk3WSd
   aV7B/w51fuEpAEXeFzvQZp/CGgxOBfp3KfdHmFQSsPuDg9jvPIcLSzZtm
   7d0T9TjXNOXWx0ENSwzfjGfus28wpWXRoXyCtirrl1PVI47wmjAUw6/Ri
   U6icpUWm5ZFJAoerPIlAtBbqdF8q0N9uun1rW8l28U7CLJiRyeBIaaQ0y
   A6+PeuvTnVn0tJaa5WYMAhqw+Q24UycEegyBhFal846y756pqQjv4OEFu
   A==;
X-CSE-ConnectionGUID: xO7l2kU9TBe2h9G8u6n1Tw==
X-CSE-MsgGUID: Dr2/UZ15Th6BADXLCXi48Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="43464079"
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="43464079"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 16:16:00 -0800
X-CSE-ConnectionGUID: vCctnbSUQ4GBJyl1ZI084g==
X-CSE-MsgGUID: vM8yRuP+SsKrJIRr4iYCkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="96173989"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa003.fm.intel.com with ESMTP; 27 Nov 2024 16:15:59 -0800
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
Subject: [PATCH v8 2/2] x86/cacheinfo: Delete global num_cache_leaves
Date: Wed, 27 Nov 2024 16:22:47 -0800
Message-Id: <20241128002247.26726-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
References: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
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

init_cache_level() no longer needs to set num_leaves. Also, it never had to
set num_levels as it is unnecessary in x86. Keep checking for zero cache
leaves. Such condition indicates a bug.

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
Changes since v7:
 * Removed an ugly linebreak. (Boris)
 * Folded patch 3/3 into 2/3 as both patches deal with init_cache_level().
   (Boris)
 * Removed the [set,get]_num_cache_leaves() wrappers. Instead, use the
   existing get_cpu_cacheinfo(). (Boris)
 * Future-proof init_cache_level() for cases in which cpu_cacheinfo::
   num_leaves is still zero afer cache info initialization.

Changes since v6:
 * None

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
 arch/x86/kernel/cpu/cacheinfo.c | 41 +++++++++++++++------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 392d09c936d6..95e38ab98a72 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -178,8 +178,6 @@ struct _cpuid4_info_regs {
 	struct amd_northbridge *nb;
 };
 
-static unsigned short num_cache_leaves;
-
 /* AMD doesn't have CPUID4. Emulate it here to report the same
    information to the user.  This makes some assumptions about the machine:
    L2 not shared, no SMT etc. that is currently true on AMD CPUs.
@@ -718,19 +716,21 @@ void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c)
 void init_amd_cacheinfo(struct cpuinfo_x86 *c)
 {
 
+	unsigned int cpu = c->cpu_index;
+
 	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
-		num_cache_leaves = find_num_cache_leaves(c);
+		get_cpu_cacheinfo(cpu)->num_leaves = find_num_cache_leaves(c);
 	} else if (c->extended_cpuid_level >= 0x80000006) {
 		if (cpuid_edx(0x80000006) & 0xf000)
-			num_cache_leaves = 4;
+			get_cpu_cacheinfo(cpu)->num_leaves = 4;
 		else
-			num_cache_leaves = 3;
+			get_cpu_cacheinfo(cpu)->num_leaves = 3;
 	}
 }
 
 void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
 {
-	num_cache_leaves = find_num_cache_leaves(c);
+	get_cpu_cacheinfo(c->cpu_index)->num_leaves = find_num_cache_leaves(c);
 }
 
 void init_intel_cacheinfo(struct cpuinfo_x86 *c)
@@ -742,19 +742,18 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
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
+		if (!get_cpu_cacheinfo(c->cpu_index)->num_leaves)
+			get_cpu_cacheinfo(c->cpu_index)->num_leaves = find_num_cache_leaves(c);
 
 		/*
 		 * Whenever possible use cpuid(4), deterministic cache
 		 * parameters cpuid leaf to find the cache details
 		 */
-		for (i = 0; i < num_cache_leaves; i++) {
+		for (i = 0; i < get_cpu_cacheinfo(c->cpu_index)->num_leaves; i++) {
 			struct _cpuid4_info_regs this_leaf = {};
 			int retval;
 
@@ -790,14 +789,14 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 	 * Don't use cpuid2 if cpuid4 is supported. For P4, we use cpuid2 for
 	 * trace cache
 	 */
-	if ((num_cache_leaves == 0 || c->x86 == 15) && c->cpuid_level > 1) {
+	if ((!get_cpu_cacheinfo(c->cpu_index)->num_leaves || c->x86 == 15) && c->cpuid_level > 1) {
 		/* supports eax=2  call */
 		int j, n;
 		unsigned int regs[4];
 		unsigned char *dp = (unsigned char *)regs;
 		int only_trace = 0;
 
-		if (num_cache_leaves != 0 && c->x86 == 15)
+		if (get_cpu_cacheinfo(c->cpu_index)->num_leaves && c->x86 == 15)
 			only_trace = 1;
 
 		/* Number of times to iterate */
@@ -991,14 +990,10 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 
 int init_cache_level(unsigned int cpu)
 {
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-
-	if (!num_cache_leaves)
+	/* There should be at least one leaf. */
+	if (!get_cpu_cacheinfo(cpu)->num_leaves)
 		return -ENOENT;
-	if (!this_cpu_ci)
-		return -EINVAL;
-	this_cpu_ci->num_levels = 3;
-	this_cpu_ci->num_leaves = num_cache_leaves;
+
 	return 0;
 }
 
-- 
2.34.1


