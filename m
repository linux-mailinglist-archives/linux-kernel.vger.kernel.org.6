Return-Path: <linux-kernel+bounces-204712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11808FF2B5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2121C21C06
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72A4198E7F;
	Thu,  6 Jun 2024 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ni9S9YAa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AC6198A19
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692059; cv=none; b=Mrz3uxFZdC153qfV556jVXLl39wc+1JH7RABY8Fhp37O9Xc8tZ/zujqK6247aOFSt/wufjTmSbxLm0GEXMHqyNiIc4U4lWi6jjnjkbCOJ43+4w5Bwz6qSPWIu5EdgnURFoOEm0sXW8tPFXV6WOZ522YiQPzsFxx7I0FwR4kqoPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692059; c=relaxed/simple;
	bh=6rrX6toUJNh2iWuLJcY/kYBZd3jveCiUOS6TDW2IT/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFl4NhI57g+aTJpao1jpZG6zG7MdS7rzYsswKeUosgnJ5fCmfMiWKaSdPnnb8UFZUUO0oOeXixSqgx8Z2/tF7R+UP9aLsZBkfBLZJV+4VO/f+Mu+b130Ua7RPQiW5z1OSI0YRZkoxiQ6UUBtOD/PoAmpQWIwKT8EBgYfcz28RPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ni9S9YAa; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717692058; x=1749228058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6rrX6toUJNh2iWuLJcY/kYBZd3jveCiUOS6TDW2IT/U=;
  b=ni9S9YAaJA0tuYuSja98ljGhBZ0j1z7Gr0wZNhH23pW2AquWP+jizpAb
   Up5/OU7Y/V+7qpsi0aKH4OTe2+TF826i4vnVVmTumX7zJm7gLTUyDy8cC
   zoe75p6EtN3AGj8YfoDI3lmL18Dhxup8B3xiQ30SgIHbJlkzV8QJ1Z+lB
   5Vk6MIHUGwHkJS7ynFCsTgxlQE3HkqFnxDMRD6ZLI4YXxT7IV0EpA/qQC
   cDGx0JBHS+aC+/N7XfoepfSbJ4xP+2ypDNnSy7xi0sohXIhT/rw33RImT
   Eltw9Lkg07vGNmjpRTsPlKBAXnmmlEnyBy7c/2ce3LIJKvzRJHvTdFXB2
   Q==;
X-CSE-ConnectionGUID: H2S4/rGvSF2Oy2YKY9nsJw==
X-CSE-MsgGUID: 05z0zkkNTiaZG7MDco+tRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14214916"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14214916"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 09:40:55 -0700
X-CSE-ConnectionGUID: NM4/4XLLQZGPgwO9mU2GDA==
X-CSE-MsgGUID: XLhw5Y4XRjK/DziMCoFu9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38033091"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 09:40:54 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 1/2] cacheinfo: Add function to get cacheinfo for a given (cpu, cachelevel)
Date: Thu,  6 Jun 2024 09:40:46 -0700
Message-ID: <20240606164047.318378-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240606164047.318378-1-tony.luck@intel.com>
References: <20240606164047.318378-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resctrl code open codes a search for information about a given cache
level in a couple of places (and more are on the way).

Provide a new inline function get_cpu_cacheinfo_level() in
<linux/cacheinfo.h> to do the search and return a pointer to
the cacheinfo structure.

Add lockdep_assert_cpus_held() to enforce the comment that cpuhp
lock must be held.

Simplify the existing get_cpu_cacheinfo_id() by using this new
function to do the search.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 include/linux/cacheinfo.h | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 2cb15fe4fe12..530a16980aea 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -3,6 +3,7 @@
 #define _LINUX_CACHEINFO_H
 
 #include <linux/bitops.h>
+#include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/smp.h>
 
@@ -113,23 +114,37 @@ int acpi_get_cache_info(unsigned int cpu,
 const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
 
 /*
- * Get the id of the cache associated with @cpu at level @level.
+ * Get the cacheinfo structure for the cache associated with @cpu at
+ * level @level.
  * cpuhp lock must be held.
  */
-static inline int get_cpu_cacheinfo_id(int cpu, int level)
+static inline struct cacheinfo *get_cpu_cacheinfo_level(int cpu, int level)
 {
 	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
 	int i;
 
+	lockdep_assert_cpus_held();
+
 	for (i = 0; i < ci->num_leaves; i++) {
 		if (ci->info_list[i].level == level) {
 			if (ci->info_list[i].attributes & CACHE_ID)
-				return ci->info_list[i].id;
-			return -1;
+				return &ci->info_list[i];
+			return NULL;
 		}
 	}
 
-	return -1;
+	return NULL;
+}
+
+/*
+ * Get the id of the cache associated with @cpu at level @level.
+ * cpuhp lock must be held.
+ */
+static inline int get_cpu_cacheinfo_id(int cpu, int level)
+{
+	struct cacheinfo *ci = get_cpu_cacheinfo_level(cpu, level);
+
+	return ci ? ci->id : -1;
 }
 
 #ifdef CONFIG_ARM64
-- 
2.45.0


