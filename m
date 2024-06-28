Return-Path: <linux-kernel+bounces-234623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0362D91C8B1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18F5284764
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D2313E02E;
	Fri, 28 Jun 2024 21:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtT1M58f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317FD132136
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611798; cv=none; b=Pt8A8qGtvM1qLBzHfMPEwq3xgLC4J9gH1VpCAdUKscRajEZet8ovN/P5fz++slZcBjpO8mPwJR7bS80nCJWqBeb3oKRabzoCgePjD91kC6F6msAvI59iEsW8zTG2HYCH4K1ZhvyjLlqajAsNNfkXxd5D6zTrF6m6z4Fo9NYK/0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611798; c=relaxed/simple;
	bh=pRMMuFAo+vgoaQPT6H9NbnUr8oF0p+OxKZvV5KwLCn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q991gOuGU54U30lPEjYZgWaYQci8ZbQ2yLEP8X1YKzigd9Xxvuxl9FN0zVllFWYMtBKlrb5LyBJTlZIJvP4tKSzN5LhMKzEQaEPHZorp+uM3b8wGQLUQHOkcltzP9etZ1wFSh99sVL75LSxwca5fE/t5ByjGYWPYo8c/7ZH9tyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gtT1M58f; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719611796; x=1751147796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pRMMuFAo+vgoaQPT6H9NbnUr8oF0p+OxKZvV5KwLCn4=;
  b=gtT1M58f9ePogEeXBnj+9VJip42MQuh4vFTZpO1sqRV5FVIcsleHsdNo
   ydJhCA2Av5ivvRiGFCWSGEYKeGX0JogC2OlDgWEjP8zgwpYIrmU4/Nhfq
   1AseGox5duZ03f9K9hb2h4nz0+JcQSpT/MeqDHyNN/imAPpzuXet2z5X+
   D12h/YNeVAfUDPThKyJX65fGBMKN+Zb8KSi1uyOLY9/AnV+WErnWU/Ud4
   XLwYMVZZEq/ChE7vC3Txbb3ItyAWQTfkgC2wMsbFIICAFlbB+ZtyJZkEV
   qvPqREn/Qy6W1pFce4NHuh22r0WmdodWYu2iCXT0ZxJreO3JG5Nob3oZB
   g==;
X-CSE-ConnectionGUID: 35G/+X/WQbeFdw7zQ21DJQ==
X-CSE-MsgGUID: ZE2R56NeRCClUVsdlHik/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16762601"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16762601"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:56:28 -0700
X-CSE-ConnectionGUID: Nl5alrlIQ4anpljGHFCnYQ==
X-CSE-MsgGUID: 5W6Q0IWCTFqajzybehs6fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="68065666"
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
Subject: [PATCH v23 11/19] x86/resctrl: Refactor mkdir_mondata_subdir() with a helper function
Date: Fri, 28 Jun 2024 14:56:11 -0700
Message-ID: <20240628215619.76401-12-tony.luck@intel.com>
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


