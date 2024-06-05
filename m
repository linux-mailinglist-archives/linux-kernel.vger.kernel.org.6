Return-Path: <linux-kernel+bounces-202896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3FB8FD299
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2757D1F21749
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173A518F2CD;
	Wed,  5 Jun 2024 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BX4qZwQW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52D8155C9E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604081; cv=none; b=GDyPt8c/8G7EXYknm+bsnKD926d82zqUS5/i/4Sgf6WDcD+TvgdflAENakkjURg8nTdrzQ9Esbg6MGgFX9VrIedD00LLyUyK+r8bEDdlEC/X7kre5lAUh6g7JX+25eYy67VkrTVZSRwakRqsgtNtNSdmYP2FWuvfUD/p7Yw0zn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604081; c=relaxed/simple;
	bh=/HprfpwiUePty9wSFJRY3CNQ9aV3syZxAQmyCvvz/FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRNXw5v9rCJQ164SGctLS1af5HirAIBHMkMhtjXoNXyZ2EYhw/8nt6vIjQCU4EG8ExZp7Z9R81HzvZu8bwsMR4kp+yUDZ8rZvW+14DpawH17Dy8DemXNpre+/a0X4oOu06wE886uXtWgIxLozscb/qmf3qO9FVjXCMVDy+RxtlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BX4qZwQW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717604080; x=1749140080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/HprfpwiUePty9wSFJRY3CNQ9aV3syZxAQmyCvvz/FY=;
  b=BX4qZwQW7CPPqT+95vvBn4s/nIlSHFrXO4D31Lto3dqcsyGSWhfs1gyX
   oy7B+4s0h5UFyf432Fhis1CuavSzV98dJux+J1q0XbgVCiJwbKW64MSQ0
   nBfXhDhH786IvV1GbyO+BPW9uEBc7Go0wHSmTJ7RyJ3/jNwRkZbsPzmrC
   Eb0IlhOVcSL2ItYFwUdGi2p2FVwMHtcdrvRTXRn46Wc80rjGr4zA8goA2
   ugCYmsgBllMV0Rh+/AfT89uuUjvi5ESHRaDpnJkhUDyyZPq/PA+oxZy7F
   tovlGsZoNZ9AY4FP4YuJVSFbpJu0FXqPcQFtUsk8k46ngGLpAzEdQBTQj
   w==;
X-CSE-ConnectionGUID: TwMC6Mv7R/OI2hl5xTXXGg==
X-CSE-MsgGUID: 2AvaSLfhSNmOrMcxgxMlZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="31772298"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="31772298"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 09:14:37 -0700
X-CSE-ConnectionGUID: Fnvn3mh+TyCMfVK9Cxg1kA==
X-CSE-MsgGUID: ankv2ZDmTkSaV5CBK2+oWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="42581902"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 09:14:37 -0700
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
Subject: [PATCH v2 2/3] x86/resctrl: Replace open code cacheinfo search in pseudo_lock_region_init()
Date: Wed,  5 Jun 2024 09:14:26 -0700
Message-ID: <20240605161427.312994-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240605161427.312994-1-tony.luck@intel.com>
References: <20240605161427.312994-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use get_cpu_cacheinfo_level() instead of open coded search.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index aacf236dfe3b..1bbfd3c1e300 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -292,9 +292,8 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
  */
 static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 {
-	struct cpu_cacheinfo *ci;
+	struct cacheinfo *ci;
 	int ret;
-	int i;
 
 	/* Pick the first cpu we find that is associated with the cache. */
 	plr->cpu = cpumask_first(&plr->d->cpu_mask);
@@ -306,15 +305,11 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 		goto out_region;
 	}
 
-	ci = get_cpu_cacheinfo(plr->cpu);
-
-	plr->size = rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
-
-	for (i = 0; i < ci->num_leaves; i++) {
-		if (ci->info_list[i].level == plr->s->res->cache_level) {
-			plr->line_size = ci->info_list[i].coherency_line_size;
-			return 0;
-		}
+	ci = get_cpu_cacheinfo_level(plr->cpu, plr->s->res->cache_level);
+	if (ci) {
+		plr->line_size = ci->coherency_line_size;
+		plr->size = rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
+		return 0;
 	}
 
 	ret = -1;
-- 
2.45.0


