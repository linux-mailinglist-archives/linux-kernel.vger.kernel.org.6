Return-Path: <linux-kernel+bounces-180438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 863708C6E9D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBDC283EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275C016F837;
	Wed, 15 May 2024 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JlBv3p3/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CAD15B975
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715811826; cv=none; b=R9p9Gf3uPK80V/gjF7po/PXUyht0EP//0VqFSZi7JpCGuhx3Cods8oNtFSAq2AJcsMcYywh3Wd00jumWGuswQrRcLrAuQx1pCRIKCG953fVDP0AIj/bhR05XT560PxGbpHqQ4KqWQYDO0dZaZpxzugYZi4xLZ3RyYy0rDMJ7rHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715811826; c=relaxed/simple;
	bh=VXHnQvItZ/RdHSdn38gsckqu0vkscAlaujUvcyMHWRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVhltW8L3yoZ5f7/nswh3jdrdQyNbwRfPTe35SYaNpyg5hbZxjV5/HgdDd126DxxlOHNJrRfxmBr/+iQx7HJlc4eSEGCWoP75UO7o3+wX72IYVCHYZ2vSfBRDFkJlMESOJI7k4KPYJs1G/23s1Nc+SKiyWdolTUdTnU6D+WbH0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JlBv3p3/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715811824; x=1747347824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VXHnQvItZ/RdHSdn38gsckqu0vkscAlaujUvcyMHWRs=;
  b=JlBv3p3/zCxh52S3q7/Xr4fFTgHaHr3oYeJwkUsECjTta089FCZvqDCB
   hyQvy7UMGV/LAkeiAAZoptwHzBbuIKqvVr50n7P//y2mWi2RRP+EhNm0v
   ACLasQcghaVRD0px5iDIv8/IrwJ79CyU2emWQAdvtK7vinPnf+6FWVqTz
   8wtzBft6mSRlkMzkgdjR3lSmYaaw9Db7dJHmAkJZ9+5hNt7fekILszCYl
   Ib6TqVOVpqdIAyqS1V3f60VtsyCQgqNzldbmyUK805Xj+gZ0i9Qm1qWSp
   JIqcqnqgKDuV7wjUBCUr3DaMKa/z0K1VLjE9bNTqPq4qT5ZcD6Vkrb89c
   w==;
X-CSE-ConnectionGUID: 8rDzDjd9QE2o1LZN+UzZUQ==
X-CSE-MsgGUID: ciifA3NBQkqIG5AJ4zqH6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15671716"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="15671716"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 15:23:36 -0700
X-CSE-ConnectionGUID: NuJLDK7/TG6ToQ7Us0EEWQ==
X-CSE-MsgGUID: 8qyqqnGYS7SbJlC2Gfs+1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="35989190"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 15:23:36 -0700
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
Subject: [PATCH v18 14/17] x86/resctrl: Sum monitor data acrss Sub-NUMA (SNC) nodes when needed
Date: Wed, 15 May 2024 15:23:22 -0700
Message-ID: <20240515222326.74166-15-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240515222326.74166-1-tony.luck@intel.com>
References: <20240515222326.74166-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the sumdomains fields is set in the rmid_read structure, walk
the list of domains in this resource to find all that share an L3
cache id (rr->display_id).

Adjust the RMID value based on which SNC domain is being accessed.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 20 +++++++++++---
 arch/x86/kernel/cpu/resctrl/monitor.c     | 33 ++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 3b9383612c35..7ab788d47ad3 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -575,15 +575,27 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	resid = md.u.rid;
 	domid = md.u.domid;
 	evtid = md.u.evtid;
-
+	rr.sumdomains = md.u.sum;
 	r = &rdt_resources_all[resid].r_resctrl;
-	hdr = rdt_find_domain(&r->mon_domains, domid, NULL);
-	if (!hdr || WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN)) {
+
+	if (rr.sumdomains) {
+		rr.display_id = domid;
+		list_for_each_entry(d, &r->mon_domains, hdr.list) {
+			if (d->display_id == domid)
+				goto got_domain;
+		}
 		ret = -ENOENT;
 		goto out;
+	} else {
+		hdr = rdt_find_domain(&r->mon_domains, domid, NULL);
+		if (!hdr || WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN)) {
+			ret = -ENOENT;
+			goto out;
+		}
+		d = container_of(hdr, struct rdt_mon_domain, hdr);
 	}
-	d = container_of(hdr, struct rdt_mon_domain, hdr);
 
+got_domain:
 	mon_event_read(&rr, r, d, rdtgrp, evtid, false);
 
 	if (rr.err == -EIO)
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 0f66825a1ac9..668d2fdf58cd 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -546,7 +546,7 @@ static struct mbm_state *get_mbm_state(struct rdt_mon_domain *d, u32 closid,
 	}
 }
 
-static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
+static int ___mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 {
 	struct mbm_state *m;
 	u64 tval = 0;
@@ -569,6 +569,37 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 	return 0;
 }
 
+static u32 get_node_rmid(struct rdt_resource *r, struct rdt_mon_domain *d, u32 rmid)
+{
+	int cpu = cpumask_any(&d->hdr.cpu_mask);
+
+	return rmid + (cpu_to_node(cpu) % snc_nodes_per_l3_cache) * r->num_rmid;
+}
+
+static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
+{
+	struct rdt_mon_domain *d;
+	u32 node_rmid;
+	int ret = 0;
+
+	if (!rr->sumdomains) {
+		node_rmid = get_node_rmid(rr->r, rr->d, rmid);
+		return ___mon_event_count(closid, node_rmid, rr);
+	}
+
+	list_for_each_entry(d, &rr->r->mon_domains, hdr.list) {
+		if (d->display_id != rr->display_id)
+			continue;
+		rr->d = d;
+		node_rmid = get_node_rmid(rr->r, d, rmid);
+		ret = ___mon_event_count(closid, node_rmid, rr);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 /*
  * mbm_bw_count() - Update bw count from values previously read by
  *		    __mon_event_count().
-- 
2.44.0


