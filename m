Return-Path: <linux-kernel+bounces-232971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BC691B09F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD36A2829E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811401A2FA9;
	Thu, 27 Jun 2024 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OUCWGD2b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716D91A0B02
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520757; cv=none; b=h+ei1oPkaFoUG+uDfGXumcGm/Ue78aI5pwVOctQlrrbDd40mMwrd8DW/+HMCSSV3b8ZBmTGgtg06nRoSJAhS7it2ahESS7faBpVtj5j5b2Xlx+GyxdgV3ysHiYfaB1uQBGPvahAnmvFLnlPFcl4RM0Q02YFvuHSmIxyDooLItC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520757; c=relaxed/simple;
	bh=pRMMuFAo+vgoaQPT6H9NbnUr8oF0p+OxKZvV5KwLCn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ah8K108ANxTo9p1F6j+b3EzxeYq8YCo6E7OBXiYbUczZ1fmFUdR2X6Z9qzKwdUdBfoHuv+Bzhosr60THHWU0eLL8ux/HjpWjPhhw0VAd5I1nGTYhkGWJ0AVWIWjKxek7w8yKUJD2ErBWIJM7M2iRl8rm2bLe9qQddrWhBhp5e1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OUCWGD2b; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719520756; x=1751056756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pRMMuFAo+vgoaQPT6H9NbnUr8oF0p+OxKZvV5KwLCn4=;
  b=OUCWGD2bn+ycoAV6CxxAS7J79XwK32hv3XkrUdS64uCArIExdrLMwOhC
   KUuu1u3ko+xpWHvQ0f1CK/bWmt8FZX3fUUvmc2DECzLkQrCU1hDK8AwuY
   rd7lAOZJnyjhEBLP/o68JQ8x5MlNexJG6EGDBEL/OR8Eh+TiNzHtsL39K
   xyZIPBk3fjiejgCTE4vfdAUjxOM+cXNaAJniFfxAcbEj3ukHh66yGGuQ8
   ifqLy8iUL/c6ps29xEJvo6lkS57woxeOJq6oAHA7q453XfvYelo4tycpM
   yFjjrBC5WTVei6uWZ7dv0jwkdXfsOh8kTul9uMl8TeMArm/zHGXksvPhK
   g==;
X-CSE-ConnectionGUID: CwfQRSTERoCDiOFJSe2FGA==
X-CSE-MsgGUID: hzKi0keIRziRg1oiMAx/8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16809807"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="16809807"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:39:09 -0700
X-CSE-ConnectionGUID: waKzOfwBTjWeglPIaQTWBw==
X-CSE-MsgGUID: caARh1HyT1aqIu2h1Za/ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="82052906"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:39:09 -0700
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
Subject: [PATCH v22 10/18] x86/resctrl: Refactor mkdir_mondata_subdir() with a helper function
Date: Thu, 27 Jun 2024 13:38:48 -0700
Message-ID: <20240627203856.66628-11-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627203856.66628-1-tony.luck@intel.com>
References: <20240627203856.66628-1-tony.luck@intel.com>
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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 45 ++++++++++++++++----------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d0443589cd86..9c38ddcfe150 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3025,14 +3025,37 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 	}
 }
 
+static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
+			     struct rdt_resource *r, struct rdtgroup *prgrp)
+{
+	struct rmid_read rr = {0};
+	union mon_data_bits priv;
+	struct mon_evt *mevt;
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
-	struct rmid_read rr = {0};
-	union mon_data_bits priv;
 	struct kernfs_node *kn;
-	struct mon_evt *mevt;
 	char name[32];
 	int ret;
 
@@ -3046,22 +3069,10 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
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
2.45.2


