Return-Path: <linux-kernel+bounces-208753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B95EB9028CF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A791F211F0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11B31534E8;
	Mon, 10 Jun 2024 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fKkNuMA4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC9C15216C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718044549; cv=none; b=YidiMc2YM9zyVKKcTweyqD1UGN9LbKt0AX3/2P9iLwEvdglzB0J77vfaE+Urs+7Qe/jAB5VYY+Dx6OyoKvd8Odf9Cd8DXXWjEAujjYiYCeRFLONFl3D99RHMEWn8v7I2zRZUgfzYvlk6NREmuDWt+vOx70XiDJGwjxRbdLpVUa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718044549; c=relaxed/simple;
	bh=4oqidBc9DHvPZDAc4/HvrQudL3M7ozY8EMl1oGEhk+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnDd2ifBa342eUwMTmWDtuh9Qh5lKxyx0U4N5eiuBiwHCfRACuIrFuHzsV4ViuoaJLRefH3S0+AzeCEEWp0XHwU5Jt0Jjirs4y/dOrmxxdtOQAs+nUJVYcNlan6+3EBi8HLnRtehhXM9IQ/Z/X2cfLF+oOS9s6rberU5xclEJAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fKkNuMA4; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718044548; x=1749580548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4oqidBc9DHvPZDAc4/HvrQudL3M7ozY8EMl1oGEhk+o=;
  b=fKkNuMA4LRGwikDtsJLdv3w9OVi7RzvjejsqetryMfmYb/6sQEP5uQuB
   3Zjuwrhdc68IBvMGeYganOq/uwZKDXo8MmdSopRmHHB5e6Xkpetua9dP3
   8Tehb7YhItlcu8/hdbNPPViXUias2OK3Nn95mwsycOg63MF1QGttPWdRO
   DtwFge58nZBJT4rXdhR//B07WQ6+96/hl6PP5u0hV7JOaxRwFreaJhHsq
   7dLrlS48LfXdt/fS33yhbNr0hyGCVNM/w62shlKCVANHpMLGZtggIM717
   qQbjEx5/E4CZh5yCJiQTqTuIxKQS2HxHSdJ89AJUzeQ6jLmU4v2r9hw2W
   A==;
X-CSE-ConnectionGUID: qjpX44AmQa+7IxuHwhmuqQ==
X-CSE-MsgGUID: JIbIzAfBQr63VBCYA6yyCQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="12004837"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="12004837"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 11:35:38 -0700
X-CSE-ConnectionGUID: AcPYkZgkRiiE39yzdHP7gw==
X-CSE-MsgGUID: GqajRRP4QKCBjYU+QMFCUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43576578"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 11:35:38 -0700
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
Subject: [PATCH v20 10/18] x86/resctrl: Refactor mkdir_mondata_subdir() with a helper function
Date: Mon, 10 Jun 2024 11:35:20 -0700
Message-ID: <20240610183528.349198-11-tony.luck@intel.com>
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

In Sub-NUMA Cluster (SNC) mode Linux must create the monitor
files in the original "mon_L3_XX" directories and also in each
of the "mon_sub_L3_YY" directories.

Refactor mkdir_mondata_subdir() to move the creation of monitoring files
into a helper function to avoid the need to duplicate code later.

No functional change.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 45 ++++++++++++++++----------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 869dd1973b5d..66acbad1c585 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3021,14 +3021,37 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 	}
 }
 
+static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
+			     struct rdt_resource *r, struct rdtgroup *prgrp)
+{
+	union mon_data_bits priv;
+	struct mon_evt *mevt;
+	struct rmid_read rr;
+	int ret;
+
+	if (WARN_ON(list_empty(&r->evt_list)))
+		return -EPERM;
+
+	priv.u.rid = r->rid;
+	priv.u.domid = d->hdr.id;
+	list_for_each_entry(mevt, &r->evt_list, list) {
+		priv.u.evtid = mevt->evtid;
+		ret = mon_addfile(kn, mevt->name, priv.priv);
+		if (ret)
+			return ret;
+
+		if (is_mbm_event(mevt->evtid))
+			mon_event_read(&rr, r, d, prgrp, mevt->evtid, true);
+	}
+
+	return 0;
+}
+
 static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 				struct rdt_mon_domain *d,
 				struct rdt_resource *r, struct rdtgroup *prgrp)
 {
-	union mon_data_bits priv;
 	struct kernfs_node *kn;
-	struct mon_evt *mevt;
-	struct rmid_read rr;
 	char name[32];
 	int ret;
 
@@ -3042,22 +3065,10 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 	if (ret)
 		goto out_destroy;
 
-	if (WARN_ON(list_empty(&r->evt_list))) {
-		ret = -EPERM;
+	ret = mon_add_all_files(kn, d, r, prgrp);
+	if (ret)
 		goto out_destroy;
-	}
 
-	priv.u.rid = r->rid;
-	priv.u.domid = d->hdr.id;
-	list_for_each_entry(mevt, &r->evt_list, list) {
-		priv.u.evtid = mevt->evtid;
-		ret = mon_addfile(kn, mevt->name, priv.priv);
-		if (ret)
-			goto out_destroy;
-
-		if (is_mbm_event(mevt->evtid))
-			mon_event_read(&rr, r, d, prgrp, mevt->evtid, true);
-	}
 	kernfs_activate(kn);
 	return 0;
 
-- 
2.45.0


