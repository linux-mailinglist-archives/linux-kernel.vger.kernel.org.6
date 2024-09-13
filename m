Return-Path: <linux-kernel+bounces-327769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD27977AEA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C451C24780
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22FA1D6C61;
	Fri, 13 Sep 2024 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIqcbdQN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9271D6C4E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726215976; cv=none; b=pFpgdzGvVGrwO2Ek6/HO5agP84ve7dvDdFbWH4wH8rFQ/R+PLi2bKbeom1DOU3YYWuVZyJ/DZDggV1C2H9BVLChpfJ2RgXc77KV0xBb5s0Px1wpJ6NX3e/w3//TydONTXjoZKwhFBWRVmb1wwG761JvLDSO0CD5zQUqQivAgybA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726215976; c=relaxed/simple;
	bh=34DMiNqCXssyBrnitnU+1cTTFyON1eU082vWM8USQn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fwxDsub2aizMdQRzOUBqvBYlHatw41kTGBbJcxj9AXCKT7lUV57WDU5S2sGqk7JSrp61Po5gMSan4Uo8pw2GoMXvxnp/9i0Eb9mHTL2lZN5e9OaFa0BJ808sCMLNwys/C2HJIV1Z9bYCmR+ZSnowFMmAJUTdFEL4KcVLDaGu/08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIqcbdQN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726215974; x=1757751974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=34DMiNqCXssyBrnitnU+1cTTFyON1eU082vWM8USQn8=;
  b=SIqcbdQNbpoLBNFmKgg1cBCuQ7H3loSV3go/69YVY2oFAwmLS1cIyiab
   Yc6lmVc71nEjj539zhS1Uns6v/hVfUfkqtW9lE5fQARvfufO/1/IWZKkr
   +R2FzndDRbdCxsfXHmm+fMBU4v6QH0YBQmE8ENSWj4uMoKxpbQ3tO+IYV
   fJQyAyg8KZMc+JPgR24f5weiOeEcvJSBlxkpuNCXS6P2uX78ZOevBcuNY
   hw3hLHCXNyAb8p216BrWldfap/6wUkMZ0g4cWBP6feLxsk9eKiIxPax+t
   CaZxnPbeJ+yPCIR9bAX4zfbp3w7HtUCj7RQ41Z/zV09H/1ygkPnC43OM8
   g==;
X-CSE-ConnectionGUID: 8VTxC5ElRYW+/NR1hzUoiw==
X-CSE-MsgGUID: kJNihpRlQgy389iUu3k35A==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24977570"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="24977570"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 01:26:13 -0700
X-CSE-ConnectionGUID: m3R6K8O3SYKiw2uceiW++Q==
X-CSE-MsgGUID: IkexIDuhQr+tqyI9xMz/8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="68485429"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa007.jf.intel.com with ESMTP; 13 Sep 2024 01:26:12 -0700
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
Subject: [PATCH v7 1/3] cacheinfo: Allocate memory during CPU hotplug if not done from the primary CPU
Date: Fri, 13 Sep 2024 01:31:53 -0700
Message-Id: <20240913083155.9783-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240913083155.9783-1-ricardo.neri-calderon@linux.intel.com>
References: <20240913083155.9783-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
adds functionality that architectures can use to optionally allocate and
build cacheinfo early during boot. Commit 6539cffa9495 ("cacheinfo: Add
arch specific early level initializer") lets secondary CPUs correct (and
reallocate memory) cacheinfo data if needed.

If the early build functionality is not used and cacheinfo does not need
correction, memory for cacheinfo is never allocated. x86 does not use the
early build functionality. Consequently, during the cacheinfo CPU hotplug
callback, last_level_cache_is_valid() attempts to dereference a NULL
pointer:

     BUG: kernel NULL pointer dereference, address: 0000000000000100
     #PF: supervisor read access in kernel mode
     #PF: error_code(0x0000) - not present page
     PGD 0 P4D 0
     Oops: 0000 [#1] PREEPMT SMP NOPTI
     CPU: 0 PID 19 Comm: cpuhp/0 Not tainted 6.4.0-rc2 #1
     RIP: 0010: last_level_cache_is_valid+0x95/0xe0a

Allocate memory for cacheinfo during the cacheinfo CPU hotplug callback if
not done earlier.

Moreover, before determining the validity of the last-level cache info,
ensure that it has been allocated. Simply checking for non-zero
cache_leaves() is not sufficient, as some architectures (e.g., Intel
processors) have non-zero cache_leaves() before allocation.

Dereferencing NULL cacheinfo can occur in update_per_cpu_data_slice_size().
This function iterates over all online CPUs. However, a CPU may have come
online recently, but its cacheinfo may not have been allocated yet.

While here, remove an unnecessary indentation in allocate_cache_info().

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Radu Rendec <rrendec@redhat.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Andreas Herrmann <aherrmann@suse.de>
Fixes: 6539cffa9495 ("cacheinfo: Add arch specific early level initializer")
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
Changes since v6:
 * Merged patches 1 and 2 of v6 into one. (Borislav)
 * Merged the history of patches 1 and 2 into this patch.
 * Kept the Reviewed-by and Tested-by tags from the two merged patches.
 * Fixed a formatting issue in allocate_cache_info(). (Borislav)

Changes since v5:
 * Fixed nonsensical subject (Nikolay).
 * Added Reviewed-by and Tested-by tags from Andreas. Thanks!
 * Added Reviewed-by tag from Nikolay. Thanks!

Changes since v4:
 * Combined checks for per_cpu_cacheinfo() and cache_leaves() in a single
   line. (Sudeep)
 * Added Reviewed-by tag from Sudeep. Thanks!

Changes since v3:
 * Added Reviewed-by tag from Radu and Sudeep. Thanks!

Changes since v2:
 * Introduced this patch.

Changes since v1:
 * N/A

---
The motivation for commit 5944ce092b97 was to prevent a BUG splat in
PREEMPT_RT kernels during memory allocation. This splat is not observed on
x86 because the memory allocation for cacheinfo happens in
detect_cache_attributes() from the cacheinfo CPU hotplug callback.

The dereference of a NULL cacheinfo is not observed today because
cache_leaves(cpu) is zero until after init_cache_level() is called
(during the CPU hotplug callback). A subsequent changeset will set
the number of cache leaves earlier and the NULL-pointer dereference
will be observed.
---
 drivers/base/cacheinfo.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 23b8cba4a2a3..5f35a76cba2a 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -58,7 +58,7 @@ bool last_level_cache_is_valid(unsigned int cpu)
 {
 	struct cacheinfo *llc;
 
-	if (!cache_leaves(cpu))
+	if (!cache_leaves(cpu) || !per_cpu_cacheinfo(cpu))
 		return false;
 
 	llc = per_cpu_cacheinfo_idx(cpu, cache_leaves(cpu) - 1);
@@ -481,8 +481,7 @@ int __weak populate_cache_leaves(unsigned int cpu)
 static inline
 int allocate_cache_info(int cpu)
 {
-	per_cpu_cacheinfo(cpu) = kcalloc(cache_leaves(cpu),
-					 sizeof(struct cacheinfo), GFP_ATOMIC);
+	per_cpu_cacheinfo(cpu) = kcalloc(cache_leaves(cpu), sizeof(struct cacheinfo), GFP_ATOMIC);
 	if (!per_cpu_cacheinfo(cpu)) {
 		cache_leaves(cpu) = 0;
 		return -ENOMEM;
@@ -554,7 +553,11 @@ static inline int init_level_allocate_ci(unsigned int cpu)
 	 */
 	ci_cacheinfo(cpu)->early_ci_levels = false;
 
-	if (cache_leaves(cpu) <= early_leaves)
+	/*
+	 * Some architectures (e.g., x86) do not use early initialization.
+	 * Allocate memory now in such case.
+	 */
+	if (cache_leaves(cpu) <= early_leaves && per_cpu_cacheinfo(cpu))
 		return 0;
 
 	kfree(per_cpu_cacheinfo(cpu));
-- 
2.34.1


