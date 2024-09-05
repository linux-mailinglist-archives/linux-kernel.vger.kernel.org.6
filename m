Return-Path: <linux-kernel+bounces-316379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0EA96CEC4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5E1285594
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44301898F4;
	Thu,  5 Sep 2024 05:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JVr7T69J"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8376914F9CF
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 05:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725515693; cv=none; b=ZZCgxqMGjyh3h4JgHCHg3f5NnZUshyppzV2Ok0bjUcQYgVYRsviFlMuL9VpfLbcvCDdR8fyzibgbrHYKRW17Qt/Md5cERcmoPiKNzlA4ZF+FNOT3+3hFjJF6soIh9FIYuE3EOkUFuV4wGUW7IVaveNPjC3wKfH2jX9MrkthOh60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725515693; c=relaxed/simple;
	bh=2Caot2V+L7brz3WAyt6qJA6b1XHoSY4/uaIi8Q1qaDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jAw678JL4cqPEwmPVABhgd6pKmAC0pkD44q0fXzkF3+Z2nTYv4a4tRZX83hbv55lsfwmaXWeTP/k0PnAnOYhZwmfBO7fayMDWfM0em9PtskHC4b9uwrPD6Pqf1CxnV2n9nirgsUqgsnm0pW11vQIVTPimMIFEMlFgb6Hax2BMog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JVr7T69J; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725515691; x=1757051691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=2Caot2V+L7brz3WAyt6qJA6b1XHoSY4/uaIi8Q1qaDA=;
  b=JVr7T69JhtM1L2n0siqC0reZNIU8T9p6UNJb4p0sz2jrY+hbjo0seTWV
   gBzfyKvrpXxDvlezjc+HjxFMzaemxAazNKNG6t6CFhokf5fjgQQR2NHlD
   Mn8mS8V35naoAj2c6J76Ublv6oEhuDwAuqmjMhRDdhs8cZQIU3hGPvz3N
   vHqFVCWPoZpEov/cznsxbNrBUOfOlbbUsYzN8fjGqzLRXSF7GrL5DpAW4
   pb8VVwCqlF2itwoke8rZEpg1kcVMUoiHRn4HmnTmxx5CCOvDk6XaThmSm
   fLbB/6cLlNnM6QlChz1OhIzVXqhvtOpf1V6g+wgTC2wrlzCYnTYDES9lk
   A==;
X-CSE-ConnectionGUID: bc/5YEBcS4umaYLrYLiErQ==
X-CSE-MsgGUID: uF/eM4EvSDiWjqF8inURJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="35567190"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="35567190"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 22:54:49 -0700
X-CSE-ConnectionGUID: Kh6A0Cq8QYeDpPnut8kWhA==
X-CSE-MsgGUID: MBn4P9tVQBWCoJu6kN+jdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="70421555"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa004.jf.intel.com with ESMTP; 04 Sep 2024 22:54:49 -0700
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
Subject: [PATCH v6 1/4] cacheinfo: Check for null last-level cache info
Date: Wed,  4 Sep 2024 23:00:33 -0700
Message-Id: <20240905060036.5655-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240905060036.5655-1-ricardo.neri-calderon@linux.intel.com>
References: <20240905060036.5655-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Before determining the validity of the last-level cache info, ensure that
it has been allocated. Simply checking for non-zero cache_leaves() is not
sufficient, as some architectures (e.g., Intel processors) have non-zero
cache_leaves() before allocation.

Dereferencing NULL cacheinfo can occur in update_per_cpu_data_slice_size().
This function iterates over all online CPUs. However, a CPU may have come
online recently, but its cacheinfo may not have been allocated yet.

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
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
Changes since v5:
 * Added Reviewed-by and Tested-by tags from Andreas. Thanks!

Changes since v4:
 * Combined checks for per_cpu_cacheinfo() and cache_leaves() in a single
   line. (Sudeep)
 * Added Reviewed-by tag from Sudeep. Thanks!

Changes since v3:
 * Introduced this patch.

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
The dereference of a NULL cacheinfo is not observed today because
cache_leaves(cpu) is zero until after init_cache_level() is called
(during the CPU hotplug callback). A subsequent changeset will set
the number of cache leaves earlier and the NULL-pointer dereference
will be observed.
---
 drivers/base/cacheinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 23b8cba4a2a3..77f2e0f91589 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -58,7 +58,7 @@ bool last_level_cache_is_valid(unsigned int cpu)
 {
 	struct cacheinfo *llc;
 
-	if (!cache_leaves(cpu))
+	if (!cache_leaves(cpu) || !per_cpu_cacheinfo(cpu))
 		return false;
 
 	llc = per_cpu_cacheinfo_idx(cpu, cache_leaves(cpu) - 1);
-- 
2.34.1


