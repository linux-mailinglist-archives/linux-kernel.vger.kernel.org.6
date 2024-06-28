Return-Path: <linux-kernel+bounces-234626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0295391C8B5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260FF1C2330F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219081A38D8;
	Fri, 28 Jun 2024 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLmb8Ydf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC7513C676
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611800; cv=none; b=eRumBS1/kzNu+On3awAzhZjmWUghzPF2xaO7P8cBPOa5+sBfC14gn6167Y4Oh60Sd2BCND9CvbMwplXENUV8HJyehg6aJ3aTj+U2g5c4n/MiWDZqSsZqgQj+6zZb8tXTV7gKs5sxnzp9MdDRavOF2jo9P3ycqoiqvBABtk8yH00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611800; c=relaxed/simple;
	bh=7gwzf/trQEcQpsp3Q62b5pMAB6BI8DFeIhWQ/vV4hOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FiPvXQfiHQ0H+CTgHLH3ncIYgGGTa6KOq89V1Zop6YOL4T4Eec+5IqDDB+VONggUQZO+vKsQeRNGn+V3NKkB6R1Niam0qEjL4lMpa2Rbef+9W9+D/6sqWhZsowLRvj9RuktFtmxM6TAQGJHQk2Upw/OMpiM5e/env9xzyg33TjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLmb8Ydf; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719611798; x=1751147798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7gwzf/trQEcQpsp3Q62b5pMAB6BI8DFeIhWQ/vV4hOM=;
  b=DLmb8YdfXbnVQhDFD7KgxCJr9Wgfdz/QDd9bH44x0rywuMaZ1BHIj14O
   PfkHkDn1ZHO6g3qYzjbhxAhXVm7/jU6uXP2ZvI+vWPZybb4oBKx9SLJXp
   wc6aXtZ8iTiXLFnigRKwI4y6lOH6ektdb9Cy8cOo95FvMES+3vjcfWIKF
   nBwAX2bjF2H7J4e8cNNdSFECgPWV7BPdjoLWQ7mCi5v1/UZ09rvVSm9wh
   IZq3IgYJO08PQ4d7KQRVH8BmjNDxwNC0uINyIkeWHxavYAZzCK3u4XkEz
   jPoVaeu9ywMefQ3J73TE0RimWYmx4ZtV2rjuZ/eWFUHmbqacQwVcsRu5p
   Q==;
X-CSE-ConnectionGUID: hNUSp6v+SyqrFB0SvkJ/lw==
X-CSE-MsgGUID: HWVplntUQYGKomyzdtsatw==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16762615"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16762615"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:56:28 -0700
X-CSE-ConnectionGUID: QWV9m6F7T/6zO3o57zoSuQ==
X-CSE-MsgGUID: Yy/X5S/ZSg6ntkxze2J4xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="68065672"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:56:27 -0700
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
Subject: [PATCH v23 13/19] x86/resctrl: Create Sub-NUMA Cluster (SNC) monitor files
Date: Fri, 28 Jun 2024 14:56:13 -0700
Message-ID: <20240628215619.76401-14-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628215619.76401-1-tony.luck@intel.com>
References: <20240628215619.76401-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When SNC mode is enabled, create subdirectories and files to monitor
at the SNC node granularity. Legacy behavior is preserved by tagging
the monitor files at the L3 granularity with the "sum" attribute.
When the user reads these files the kernel will read monitor data
from all SNC nodes that share the same L3 cache instance and return
the aggregated value to the user.

Note that the "domid" field for files that must sum across SNC domains
has the L3 cache instance id, while non-summing files use the domain id.

The "sum" files do not need to make a call to mon_event_read() to
initialize the MBM counters. This will be handled by initializing the
individual SNC nodes that share the L3.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 62 +++++++++++++++++++-------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 9c38ddcfe150..8502385e389f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3026,7 +3026,8 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 }
 
 static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
-			     struct rdt_resource *r, struct rdtgroup *prgrp)
+			     struct rdt_resource *r, struct rdtgroup *prgrp,
+			     bool do_sum)
 {
 	struct rmid_read rr = {0};
 	union mon_data_bits priv;
@@ -3037,14 +3038,15 @@ static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
 		return -EPERM;
 
 	priv.u.rid = r->rid;
-	priv.u.domid = d->hdr.id;
+	priv.u.domid = do_sum ? d->ci->id : d->hdr.id;
+	priv.u.sum = do_sum;
 	list_for_each_entry(mevt, &r->evt_list, list) {
 		priv.u.evtid = mevt->evtid;
 		ret = mon_addfile(kn, mevt->name, priv.priv);
 		if (ret)
 			return ret;
 
-		if (is_mbm_event(mevt->evtid))
+		if (!do_sum && is_mbm_event(mevt->evtid))
 			mon_event_read(&rr, r, d, prgrp, mevt->evtid, true);
 	}
 
@@ -3055,23 +3057,51 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 				struct rdt_mon_domain *d,
 				struct rdt_resource *r, struct rdtgroup *prgrp)
 {
-	struct kernfs_node *kn;
+	struct kernfs_node *kn, *ckn;
 	char name[32];
-	int ret;
+	bool snc_mode;
+	int ret = 0;
 
-	sprintf(name, "mon_%s_%02d", r->name, d->hdr.id);
-	/* create the directory */
-	kn = kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
-	if (IS_ERR(kn))
-		return PTR_ERR(kn);
+	lockdep_assert_held(&rdtgroup_mutex);
 
-	ret = rdtgroup_kn_set_ugid(kn);
-	if (ret)
-		goto out_destroy;
+	snc_mode = r->mon_scope == RESCTRL_L3_NODE;
+	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci->id : d->hdr.id);
+	kn = kernfs_find_and_get(parent_kn, name);
+	if (kn) {
+		/*
+		 * rdtgroup_mutex will prevent this directory from being
+		 * removed. No need to keep this hold.
+		 */
+		kernfs_put(kn);
+	} else {
+		kn = kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
+		if (IS_ERR(kn))
+			return PTR_ERR(kn);
 
-	ret = mon_add_all_files(kn, d, r, prgrp);
-	if (ret)
-		goto out_destroy;
+		ret = rdtgroup_kn_set_ugid(kn);
+		if (ret)
+			goto out_destroy;
+		ret = mon_add_all_files(kn, d, r, prgrp, snc_mode);
+		if (ret)
+			goto out_destroy;
+	}
+
+	if (snc_mode) {
+		sprintf(name, "mon_sub_%s_%02d", r->name, d->hdr.id);
+		ckn = kernfs_create_dir(kn, name, parent_kn->mode, prgrp);
+		if (IS_ERR(ckn)) {
+			ret = -EINVAL;
+			goto out_destroy;
+		}
+
+		ret = rdtgroup_kn_set_ugid(ckn);
+		if (ret)
+			goto out_destroy;
+
+		ret = mon_add_all_files(ckn, d, r, prgrp, false);
+		if (ret)
+			goto out_destroy;
+	}
 
 	kernfs_activate(kn);
 	return 0;
-- 
2.45.2


