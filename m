Return-Path: <linux-kernel+bounces-193167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99098D27E9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170C61C24537
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7C113E8B6;
	Tue, 28 May 2024 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qr9lBkuf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E1D13FD83
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716934826; cv=none; b=B9POSVTWFsniohSHuPz9xJ5W6ukhxlE9Pmfg6dJHY7fuXTYFILKxVx5OwqrxxkhPazNBGPQnQz4u1epp9f59TaiiAq3OoIdlpDeob7U1LD2cagP/PcnwDBnMS5ijpzz1beni5PdQEaWQyBwC5IYVWvds1Ff8bODOxEipKH48NtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716934826; c=relaxed/simple;
	bh=twBCzOXf9mz4/ADeVLkUTL4eEWTYmC/srg32N+Mi/+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drF04jxbWcLYL8CLx9CIwl8J26CEGw4t3qn1qF8O1wga1qQSYq/bTugTUf9FBLvIfNwmDP5eOqBmfPOeYjfxQwhSP83h4Alrh/AnQHVU05e8GlC6CGNC05izx2R7gQNkAAqPG3ml6Lv+YWYyxYU1tLSBkv09t+MLEKguqxs0KnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qr9lBkuf; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716934825; x=1748470825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=twBCzOXf9mz4/ADeVLkUTL4eEWTYmC/srg32N+Mi/+A=;
  b=Qr9lBkufPcoIwddbpocr3swglHCnOp/n+NxVnvkUdQ9u+RdVcdLuFIcO
   KQpzyfKzcKNai9H09/axhVbhyOg05jTDHP40lO4CXSS6Eene5piXVrunt
   D74D86Cw0CfM6XDxpsfcldA/bj3MGNeJrqvfPI3iOv3XbX78AW1hCoJHq
   VOxyGK8Fyt2jalVEPxUrjwdrfPrA8d+4le/y/FAkfxLhzz+SqPOr7Mkar
   0x7hBpEtMxCd4SUQiiBCqqbyKFwKQgPKQKyyKuP2779a43YxKw2NFSXci
   I5FdeGRq4h0zeVJz8cqUj76hPIoew+Tc7KRv9l0hj1QEwGpQS0HWM5EBQ
   A==;
X-CSE-ConnectionGUID: opESN+DrQI2Uv06g7efjmw==
X-CSE-MsgGUID: mRbdDeECSSSMMoBHOymxlg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="30812219"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="30812219"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:20:18 -0700
X-CSE-ConnectionGUID: ybok1rAHS0WMcX8u4O7WHg==
X-CSE-MsgGUID: UOIvO2aoRUKDzWT3NECVLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="40090747"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:20:18 -0700
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
Subject: [PATCH v19 12/20] x86/resctrl: Create Sub-NUMA Cluster (SNC) monitor files
Date: Tue, 28 May 2024 15:19:57 -0700
Message-ID: <20240528222006.58283-13-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240528222006.58283-1-tony.luck@intel.com>
References: <20240528222006.58283-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When SNC mode is enabled, create subdirectories and files to monitor
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
index dd386ad9458a..6a5c35a176d5 100644
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
+	priv.u.domid = do_sum ? d->ci->id : d->hdr.id;
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
+	bool snc_mode;
 	int ret;
 
-	sprintf(name, "mon_%s_%02d", r->name, d->hdr.id);
-	/* create the directory */
-	kn = kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
-	if (IS_ERR(kn))
-		return PTR_ERR(kn);
+	snc_mode = r->mon_scope != RESCTRL_L3_CACHE;
+	sprintf(name, "mon_%s_%02d", r->name, d->ci->id);
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
+		ret = mon_add_all_files(kn, d, r, prgrp, snc_mode);
+		if (ret)
+			goto out_destroy;
+	}
 
-	ret = mon_add_all_files(kn, d, r, prgrp);
-	if (ret)
-		goto out_destroy;
+	if (snc_mode) {
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
2.45.0


