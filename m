Return-Path: <linux-kernel+bounces-424064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706F79DB032
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9CD2B21D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02902E57D;
	Thu, 28 Nov 2024 00:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B13rcVRq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758E84A1C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732752963; cv=none; b=T8yL6NE4SIEyy5MdqckxgnEtfabEcujuRJiHWHByFHiPB/am8Uv0OrbRICZSdP5BumEBqB22T0BgMFcI9Db/GqjAPQhGCp4aV1cy6wgEh/7VotFbOBOEQSZNu6F7jw3aJ2JS5dJNcGBuaP4bqqUqmroi86EhrFH80pwt6ep2Cjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732752963; c=relaxed/simple;
	bh=Mvf+3wNSV9bVer6v/tOurjmGhpoM7e0FZevsj3HIyoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XAlceFlAv1j4CgWe3rrxLfzpXWMPRFIWWGVpkahwbW8AA1D5cXaCmnI9kPE6Vus3wij2ruqqDYiNMs1yO8xVIKxj4FjHE5HKCie0uQ/ICjRk+Oa8uK9OOk+CCyeJW4N81xAkhcCnPX9HNgX3DqouDnBp1geU89nBS4Pq0T/orEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B13rcVRq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732752962; x=1764288962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Mvf+3wNSV9bVer6v/tOurjmGhpoM7e0FZevsj3HIyoo=;
  b=B13rcVRqBSLOcutMPhN0U2MXDnzb1jnVs9G7mZBxcfZJTkcN6up3qpfJ
   oCHOknpZoXwCC53HwS7fkjdBTXa1bQ4SNLQajulfpoZh92IxUjIPY7kr5
   zVZSQ4StThda3y3r/KdnSyn/0KYsh6tKvcU6kj7kUuN9e8B9jlaUQX5hW
   wCFL4uonRKDl22s9vlriaz0s3zXc6Z+rPN/6ALsnoDu5G1c293YjqD8tx
   YpUTLlsAadyfIhoSnt8/2NxjLJ6r6IjQVDt/cFLhwdZzoWGaGtkAOXxT/
   mj+So8foM5HE0LVSMsTAK1WT1A/2lwret3DrUB6PmdRr48cRdvwywR5px
   A==;
X-CSE-ConnectionGUID: mY75CzZBSi+Zz8plzO5POA==
X-CSE-MsgGUID: 5hyMdH64RGWmzvizKtcLUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="43464073"
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="43464073"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 16:15:59 -0800
X-CSE-ConnectionGUID: dvLttEFRR0eD9k4NCjLVsg==
X-CSE-MsgGUID: vBuXokJoR7uiv+YZioGbPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="96173986"
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
Subject: [PATCH v8 1/2] cacheinfo: Allocate memory during CPU hotplug if not done from the primary CPU
Date: Wed, 27 Nov 2024 16:22:46 -0800
Message-Id: <20241128002247.26726-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
References: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
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
Change since v7:
 * None

Changes since v6:
 * Merged patches 1 and 2 of v6 into one. (Borislav)
 * Merged the history of patches 1 and 2ino this patch.
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
index 7a7609298e18..a1afc478e0e8 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -58,7 +58,7 @@ bool last_level_cache_is_valid(unsigned int cpu)
 {
 	struct cacheinfo *llc;
 
-	if (!cache_leaves(cpu))
+	if (!cache_leaves(cpu) || !per_cpu_cacheinfo(cpu))
 		return false;
 
 	llc = per_cpu_cacheinfo_idx(cpu, cache_leaves(cpu) - 1);
@@ -466,8 +466,7 @@ int __weak populate_cache_leaves(unsigned int cpu)
 static inline
 int allocate_cache_info(int cpu)
 {
-	per_cpu_cacheinfo(cpu) = kcalloc(cache_leaves(cpu),
-					 sizeof(struct cacheinfo), GFP_ATOMIC);
+	per_cpu_cacheinfo(cpu) = kcalloc(cache_leaves(cpu), sizeof(struct cacheinfo), GFP_ATOMIC);
 	if (!per_cpu_cacheinfo(cpu)) {
 		cache_leaves(cpu) = 0;
 		return -ENOMEM;
@@ -539,7 +538,11 @@ static inline int init_level_allocate_ci(unsigned int cpu)
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


