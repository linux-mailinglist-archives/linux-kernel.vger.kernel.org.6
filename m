Return-Path: <linux-kernel+bounces-208756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A65109028D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3871E284FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9448154BEB;
	Mon, 10 Jun 2024 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVOXr8m+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B397915279B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718044551; cv=none; b=Ri4edt+i4A2HopKdmC7P1eBe0efnuRWdkZ3FgB/J0IzFWnnJTvdPhoV3SK0pgBLn72/o4Fe1qVJK8guoi6dCWJ+rvpd9d0seTd/jtxPQYu1SeJm2ZidhuvgBltWfzxk60gWt7eWszqLYrBJJprGy4PZqryqFpezP8sEExwlrDM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718044551; c=relaxed/simple;
	bh=QZ9rPqge4hOJ1gyfwwcwTgWV+5+F/cF2I5sFjpHiY0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPoGu/W+fLcYd8+uPrAc8tkNe/BNoE8vWyB8SDPgYIjFqB/n0wgDP75zewIRadE/ym1+cyNzYO2TzzlsTv1+PfqwkldEXkwRsYR8s+/S0tI4aVPAsOZIr0or84yaJDxQ+SUsVKdMedu8QYF8w6b15u6TAFTMgejFDH82U++wiPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVOXr8m+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718044550; x=1749580550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QZ9rPqge4hOJ1gyfwwcwTgWV+5+F/cF2I5sFjpHiY0Y=;
  b=XVOXr8m+ZqaTmUTXKA2HThNWTjROuq219P1Q/ew1NYe8ZbAuZw2JXRPh
   dpO8abpHIzvHZXRDt0TXAARMrSasD1LI0RoB0zuMdrUZLy++DyNxnFGxK
   iQecOmbRrhBBax8p+vPXDrl3/4YRrdHMm1Gon3CHr8JzhVARXGaH7gYvE
   vrNrkTofudg6CCQdjOIDcyBZyPWR7WE75mPEc8mZCczwZ4kp2uId2dYp1
   kNzQFaZs4ZOeor0IkIMVAHU/p07k24bcdbYAupRFflxfwWcHEwc6oHCLL
   xOzkWd8nZ7qmOLvwdx1dF59xEzmy0MKk3bQI05sw/RnH8Plv8yJckzDG9
   A==;
X-CSE-ConnectionGUID: 6i/THa2KRneXXB8f3tm83g==
X-CSE-MsgGUID: bcsiYbfgTAuaQb5LobNORw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="12004872"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="12004872"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 11:35:38 -0700
X-CSE-ConnectionGUID: GjLDaN1uT9SaG8oTEDSVaw==
X-CSE-MsgGUID: 0dZ+4QkWSICYj5Gg/xSO1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43576597"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 11:35:39 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v20 15/18] x86/resctrl: Make __mon_event_count() handle sum domains
Date: Mon, 10 Jun 2024 11:35:25 -0700
Message-ID: <20240610183528.349198-16-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240610183528.349198-1-tony.luck@intel.com>
References: <20240610183528.349198-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Legacy resctrl monitor files must provide the sum of event values across
all Sub-NUMA Cluster (SNC) domains that share an L3 cache instance.

There are now two cases:
1) A specific domain is provided in struct rmid_read
   This is either a non-SNC system, or the request is to read data
   from just one SNC node.
2) Domain pointer is NULL. In this case the cacheinfo field in struct
   rmid_read indicates that all SNC nodes that share that L3 cache
   instance should have the event read and return the sum of all
   values.

Update the CPU sanity check. The existing check that an event is read
from a CPU in the requested domain still applies when reading a single
domain. But when summing across domains a more relaxed check that the
current CPU is in the scope of the L3 cache instance is appropriate
since the MSRs to read events are scoped at L3 cache level.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 40 +++++++++++++++++++++------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f2fd35d294f2..c4d9a8df8d2d 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -324,9 +324,6 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 
 	resctrl_arch_rmid_read_context_check();
 
-	if (!cpumask_test_cpu(smp_processor_id(), &d->hdr.cpu_mask))
-		return -EINVAL;
-
 	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
 	ret = __rmid_read_phys(prmid, eventid, &msr_val);
 	if (ret)
@@ -592,6 +589,8 @@ static struct mbm_state *get_mbm_state(struct rdt_mon_domain *d, u32 closid,
 
 static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 {
+	int cpu = smp_processor_id();
+	struct rdt_mon_domain *d;
 	struct mbm_state *m;
 	u64 tval = 0;
 
@@ -603,12 +602,37 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 		return 0;
 	}
 
-	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid, rr->evtid,
-					 &tval, rr->arch_mon_ctx);
-	if (rr->err)
-		return rr->err;
+	if (rr->d) {
+		/* Reading a single domain, must be on a CPU in that domain */
+		if (!cpumask_test_cpu(cpu, &rr->d->hdr.cpu_mask))
+			return -EINVAL;
+		rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
+						 rr->evtid, &tval, rr->arch_mon_ctx);
+		if (rr->err)
+			return rr->err;
+
+		rr->val += tval;
+
+		return 0;
+	}
 
-	rr->val += tval;
+	/* Summing domains that share a cache, must be on a CPU for that cache */
+	if (!cpumask_test_cpu(cpu, &rr->ci->shared_cpu_map))
+		return -EINVAL;
+
+	/*
+	 * Legacy files must report the sum of an event across all
+	 * domains that share the same L3 cache instance.
+	 */
+	list_for_each_entry(d, &rr->r->mon_domains, hdr.list) {
+		if (d->ci->id != rr->ci->id)
+			continue;
+		rr->err = resctrl_arch_rmid_read(rr->r, d, closid, rmid,
+						 rr->evtid, &tval, rr->arch_mon_ctx);
+		if (rr->err)
+			return rr->err;
+		rr->val += tval;
+	}
 
 	return 0;
 }
-- 
2.45.0


