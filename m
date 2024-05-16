Return-Path: <linux-kernel+bounces-180436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA90B8C6E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB9B1C21647
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F004616D4C2;
	Wed, 15 May 2024 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T//wJ9VO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C63415E1FB
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 22:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715811824; cv=none; b=glHP9Z9NA4zO3GaYWQ+V+ya8Yx8wxthkHqHUSwk766881H2FktBhm6Ijb+SMdZ81g//KLvajX9Wmhg9JM+g8X/2SgU/l6eqy3MjDGr9A8ca169Yh9YAWJ31/9NXCtnlzGWGvF4Ti/EdxXW7bMnq+w+Ih6L4POPGlQoAeAT7sHyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715811824; c=relaxed/simple;
	bh=CxlBAzC3oiMt0w8Uxso1tlSURq0X7jXxxDfSzggd0ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYNuiCdaLXB03u0YcBs6tsHqLevFapeEk89uYje5EBPPdDYeDsQHsLXjM3lE4TJtzst1cq8HebbQ/f/+OlYSWlO9uYHba+7FB6PQN86JBcUUrobIssjBPsGbISpQAnGoABnSIzmr91yl5Qw9mXK8PxG6rKk9dTKOFdLleqd4cIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T//wJ9VO; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715811823; x=1747347823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CxlBAzC3oiMt0w8Uxso1tlSURq0X7jXxxDfSzggd0ys=;
  b=T//wJ9VOwWfPzVbrcR/z9fKLtR2MOxSaolAgN/KXvGrjIVSPlCulhvMS
   SazcGG0J9jZ1WsAnrBWVMLVgPO9/NovaUPRBc2ra1jb5AtmTgQpkZdRhn
   iCHGEk+Gl5Lbpi32P/7+RrpUlkHlanUyTU7BATnBHsWolZSEGSVDZU8eK
   uZRZu8yBhegPl46KWTqs2t1h+5XDsJJxAhnjRpF0UfHLFP2KTI1FqSIrG
   NMhuqXUtPmpZukODnC6COeoX42VQDqEt+Z0XKrYqYe/UYptZpm8u4xMjD
   r1SlRB6HquOS3siyHGtydBoK/nMXZe10QZm1uTfoEh+MwbnqCjUBjjK9E
   A==;
X-CSE-ConnectionGUID: ed7kdwP4Q0+zR3nup8lebg==
X-CSE-MsgGUID: gJYoPoEQS9+S4hzkwW+YCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15671692"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="15671692"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 15:23:36 -0700
X-CSE-ConnectionGUID: jHmzwz3ASDG2wl1IzM9zuA==
X-CSE-MsgGUID: Av5e/HR1SBa1u6gXbppfsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="35989183"
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
Subject: [PATCH v18 12/17] x86/resctrl: Create Sub-NUMA (SNC) monitor files
Date: Wed, 15 May 2024 15:23:20 -0700
Message-ID: <20240515222326.74166-13-tony.luck@intel.com>
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

When SNC mode is enabled, create subdirectories and file to monitor
at the SNC node granularity. Monitor files at the L3 granularity are
tagged with a "sum" attribute to indicate that all SNC nodes sharing
an L3 cache should be read and summed to provide the result to the
user.

Note that the "domid" field for files that must sum across SNC domains
has the L3 cache instance id, while non-summing files use the domain id.

Also the "sum" files do not need to make a call to mon_event_read() to
initialize the MBM counters. This will be handled by initializing the
individual SNC nodes that share the L3.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 53 ++++++++++++++++++--------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7a6c40aefdcc..f0f468babdea 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3026,7 +3026,8 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 }
 
 static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
-			     struct rdt_resource *r, struct rdtgroup *prgrp)
+			     struct rdt_resource *r, struct rdtgroup *prgrp,
+			     bool do_sum)
 {
 	union mon_data_bits priv;
 	struct mon_evt *mevt;
@@ -3037,15 +3038,18 @@ static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
 		return -EPERM;
 
 	priv.u.rid = r->rid;
-	priv.u.domid = d->hdr.id;
+	priv.u.domid = do_sum ? d->display_id : d->hdr.id;
+	priv.u.sum = do_sum;
 	list_for_each_entry(mevt, &r->evt_list, list) {
 		priv.u.evtid = mevt->evtid;
 		ret = mon_addfile(kn, mevt->name, priv.priv);
 		if (ret)
 			return ret;
 
-		if (is_mbm_event(mevt->evtid))
+		if (!do_sum && is_mbm_event(mevt->evtid)) {
+			rr.sumdomains = 0;
 			mon_event_read(&rr, r, d, prgrp, mevt->evtid, true);
+		}
 	}
 
 	return 0;
@@ -3055,23 +3059,42 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 				struct rdt_mon_domain *d,
 				struct rdt_resource *r, struct rdtgroup *prgrp)
 {
-	struct kernfs_node *kn;
+	struct kernfs_node *kn, *ckn;
 	char name[32];
+	bool do_sum;
 	int ret;
 
-	sprintf(name, "mon_%s_%02d", r->name, d->hdr.id);
-	/* create the directory */
-	kn = kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
-	if (IS_ERR(kn))
-		return PTR_ERR(kn);
+	do_sum = r->mon_scope != r->mon_display_scope;
+	sprintf(name, "mon_%s_%02d", r->name, d->display_id);
+	kn = kernfs_find_and_get_ns(parent_kn, name, NULL);
+	if (!kn) {
+		/* create the directory */
+		kn = kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
+		if (IS_ERR(kn))
+			return PTR_ERR(kn);
 
-	ret = rdtgroup_kn_set_ugid(kn);
-	if (ret)
-		goto out_destroy;
+		ret = rdtgroup_kn_set_ugid(kn);
+		if (ret)
+			goto out_destroy;
+		ret = mon_add_all_files(kn, d, r, prgrp, do_sum);
+		if (ret)
+			goto out_destroy;
+	}
 
-	ret = mon_add_all_files(kn, d, r, prgrp);
-	if (ret)
-		goto out_destroy;
+	if (do_sum) {
+		sprintf(name, "mon_sub_%s_%02d", r->name, d->hdr.id);
+		ckn = kernfs_create_dir(kn, name, parent_kn->mode, prgrp);
+		if (IS_ERR(ckn))
+			goto out_destroy;
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
2.44.0


