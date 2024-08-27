Return-Path: <linux-kernel+bounces-302606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0A69600D3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A451F22D97
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C740912C80F;
	Tue, 27 Aug 2024 05:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftlakTUv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAFD4C92
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735381; cv=none; b=TaL1iW2AbpVM1Nxi3OgkirHbF0PjyJQAwOBEQDHswt4ffJ0L2SWt1Mcr0NH/IZ6KVwfXxBICsvJQAeqTDxBifTjhKdOljpPqnrY3HGFy98Pji/VpVsd7qAzXUatO6W1E6btCVMyDjRJOEl77xFmk7BR9xmtI9EqAz2x66Ba+2dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735381; c=relaxed/simple;
	bh=CIvKikOPhEGLHf7EWowVUA0K+rreGMGnHAgAKNeRrJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OPlmq6bbSxlVK8ktKJKOTCJogK3ocAzN+z1iJEGLSuXHK3BY8GgfwhH9aYG81yX79MI99Pt8Fh72MGXjx7KmNGCaNquH/mj7FjtQ9KynmmxEC2S9kBgU7xeA8d58QjtgW+o30+xorBicPfo9mlKMgOJksQRmaGkx7w9vXWCs7pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftlakTUv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724735380; x=1756271380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=CIvKikOPhEGLHf7EWowVUA0K+rreGMGnHAgAKNeRrJk=;
  b=ftlakTUv6pCgL/5C/7tt5UiSB525t+Zc23bY8Ro1Z0xcGqAWrSfb3+ly
   3s7097R/2A1X7DXvhuk0m+RS07kNlBMtV9y5pkROlXvDwK7g1NgQfJHha
   EW5y69AJM0Hv6VrOz1uXc2PcIZcrXvbLw/C+To9Y1hRRdZaGnZdgoNlLC
   rU7HzL4w7r684faxwH+a43A9iqV6K7yBrECZzJ9QGzgoosTuf3bfQa5qX
   6T/tzgrbl38cYXSFC+DbKdl7fy6+nVwlHogOYv7o3uuN9ZHaQJM8Dp15x
   rZumqcV2GPP/TxgYI00zY1vuxSb0Xw921RRUJHbY/tVxlzrDi4vdiO9aS
   w==;
X-CSE-ConnectionGUID: jWyjv9BAQiaPFpbmdlDf5g==
X-CSE-MsgGUID: 5vCeqWLzTk+18wNsA/jL2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="13230470"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="13230470"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 22:09:38 -0700
X-CSE-ConnectionGUID: kZ2OVvyJRUahBDIhj4T2/Q==
X-CSE-MsgGUID: nuUhmEumSBK3LD55NUWluw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="62703855"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa009.jf.intel.com with ESMTP; 26 Aug 2024 22:09:37 -0700
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
Subject: [PATCH v5 1/4] cacheinfo: Check for null last-level cache info
Date: Mon, 26 Aug 2024 22:16:32 -0700
Message-Id: <20240827051635.9114-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com>
References: <20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com>
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

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
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


