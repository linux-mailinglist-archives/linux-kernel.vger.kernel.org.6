Return-Path: <linux-kernel+bounces-234630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE8A91C8C4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB4C28278C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D0B1CE095;
	Fri, 28 Jun 2024 21:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bhxSTZ4z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F33419CCEE
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611802; cv=none; b=U9KOI1XkKMByj9qwU6q9fIN+KTba2ykJAGeIY5e1Csa9kUvLmqeVYh42MDFexZiFwWMlb3zy+KaPZQ96c4ePBr0zZk/CMoxTFXW7jyM8IyctVNJoVbPPWcbNdDU8fD8jeP8B+lhXkajI3xPC1Zk6Tobz/332EQCDFwceBDg2krA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611802; c=relaxed/simple;
	bh=QyDHWOy1sSaunKLVu4tBjbfGSBLpsHu64tRbyDPgVm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZuWu3WB3lJ8gS6cZz0KG+seVbG/hvlcS2348BB3nP15t5nP892RjpO7bhLH3gwmtJrvQ2KYxPZqff2iusnFGg1mwGmvn+pPwaDZX3QYqnQ6tuex9yX6OGg04mo9U+H2kAQ9GXDtPnMhUrGoRZBR1nZKy9xydTPmJkp7oNtdO7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bhxSTZ4z; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719611801; x=1751147801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QyDHWOy1sSaunKLVu4tBjbfGSBLpsHu64tRbyDPgVm0=;
  b=bhxSTZ4zG9FWjNMKoE2ShfxSKr29AcejLG+20WvQR1Raxn3PE4w1765Z
   4+Ds83rxOr9tMQDkDpdnDeByzKnuMqrrrNRCv1hmrIhFu9kS3JoSwjqUq
   NhnPeX1Tj15yTxk0cjF2WU8DAL2Vp6BriHK+mdFpAC47JBAghqObuzdWW
   Ooq8cniV0V8ZBpPRMpAqYm+jFM9oQbQIPtxZLW8UPWkojtrIptSnDIE0U
   Ql8L9CZw7ixUPH6C+u0L54PIYbioRSOlXDOg4CgWEaMjILkrQ0zvITjRX
   i7/Mq3PUGNd9WTP0+PfpgiVnkQ13TltHy7oDp9BSsVvJirE+mRywcYOOA
   g==;
X-CSE-ConnectionGUID: j2REQj79Q9uOgGocBysp7g==
X-CSE-MsgGUID: RPXMTuUaSYqxBqkdP34txQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16762614"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16762614"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:56:28 -0700
X-CSE-ConnectionGUID: XQsGcYONTjy06IfSTT68Dw==
X-CSE-MsgGUID: SZxMM9bySyio/9i37oLp1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="68065675"
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
Subject: [PATCH v23 14/19] x86/resctrl: Handle removing directories in Sub-NUMA Cluster (SNC) mode
Date: Fri, 28 Jun 2024 14:56:14 -0700
Message-ID: <20240628215619.76401-15-tony.luck@intel.com>
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

In SNC mode there are multiple subdirectories in each L3 level monitor
directory (one for each SNC node). If all the CPUs in an SNC node are
taken offline, just remove the SNC directory for that node. In
non-SNC mode, or when the last SNC node directory is removed,
remove the L3 monitor directory.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 40 +++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 8502385e389f..67a8188c6d8f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3008,20 +3008,46 @@ static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
 
 /*
  * Remove all subdirectories of mon_data of ctrl_mon groups
- * and monitor groups with given domain id.
+ * and monitor groups for the given domain.
+ * Remove files and directories containing "sum" of domain data
+ * when last domain being summed is removed.
  */
 static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-					   unsigned int dom_id)
+					   struct rdt_mon_domain *d)
 {
 	struct rdtgroup *prgrp, *crgrp;
+	struct kernfs_node *kn;
+	char subname[32];
+	bool snc_mode;
 	char name[32];
 
+	snc_mode = r->mon_scope == RESCTRL_L3_NODE;
+	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci->id : d->hdr.id);
+	if (snc_mode)
+		sprintf(subname, "mon_sub_%s_%02d", r->name, d->hdr.id);
+
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
-		sprintf(name, "mon_%s_%02d", r->name, dom_id);
-		kernfs_remove_by_name(prgrp->mon.mon_data_kn, name);
+		kn = kernfs_find_and_get(prgrp->mon.mon_data_kn, name);
+		if (!kn)
+			continue;
+		kernfs_put(kn);
+
+		if (kn->dir.subdirs <= 1)
+			kernfs_remove(kn);
+		else
+			kernfs_remove_by_name(kn, subname);
 
-		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
-			kernfs_remove_by_name(crgrp->mon.mon_data_kn, name);
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list) {
+			kn = kernfs_find_and_get(crgrp->mon.mon_data_kn, name);
+			if (!kn)
+				continue;
+			kernfs_put(kn);
+
+			if (kn->dir.subdirs <= 1)
+				kernfs_remove(kn);
+			else
+				kernfs_remove_by_name(kn, subname);
+		}
 	}
 }
 
@@ -3991,7 +4017,7 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d
 	 * per domain monitor data directories.
 	 */
 	if (resctrl_mounted && resctrl_arch_mon_capable())
-		rmdir_mondata_subdir_allrdtgrp(r, d->hdr.id);
+		rmdir_mondata_subdir_allrdtgrp(r, d);
 
 	if (is_mbm_enabled())
 		cancel_delayed_work(&d->mbm_over);
-- 
2.45.2


