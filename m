Return-Path: <linux-kernel+bounces-542906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7217CA4CF47
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4441897912
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FAB23E334;
	Mon,  3 Mar 2025 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQzgMMu3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E09523A9AE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044892; cv=none; b=FzMcRtfx7CtKMUEgoJsp9KawBaVs+xmdmsLq6AJ8LRPtlTYTUE0mVavg3QCcO5GkwRbXzdGwRpcCyk/H77FlZ/a+Nk1P/fzLKsTkB8HFt2WnKngEDQyDeVRQES9BR+qKqp7GO3wAG8seELP3Ub1F9hSAkuyIxN2HKd8G6G6iZfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044892; c=relaxed/simple;
	bh=Xd4Ki/l/cqge/KMu95v5zAbtFqWbm44juh3x7Vp4MXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRJCcr/7Jfq/XiPHFgiiWFjz67t/b8JvIvGQQ5Eob3KBTX1RUaOotsOK16oyLHS5XJJogiQaLlZvQVAdA/j9W66k+HFypyUX4P+0kSlyxZY3ggvmDY6Fodf+4TtSoc8RsPSgRcjF3Q0kpa8hTpsh1p00UZ1RxvHaIAVsmuPiJ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQzgMMu3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741044890; x=1772580890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xd4Ki/l/cqge/KMu95v5zAbtFqWbm44juh3x7Vp4MXQ=;
  b=cQzgMMu3O95oTKQWGQq0mcxiMjfZd/weteuqp//OBQKE8mqLHBGQzIzE
   QyUYGv4VIGRiQEfIh07KmLlLHcr92/AFuwaqo+Ge5JWUJdeDGdyPSet0h
   PgBAj773Yj1WuIyi8Jk0JS4/ft+EQrDsHDbrlKCI6xEHKnBG4z9tBZ5XK
   nVcSt4HIHDsRjIz85hWyvAZVZUTx+k3+Y0Kw7dr+wG25CJwK1ue/0p84M
   0PKFjSNcNqB2BlfKQrTgZdZBtGyxfthpq/eSzJR1+6cURfJJrx9wy2Ou8
   wrxOZu/UTS2IzAO+HLNTbJvxZ9/AvB2Jj3Tq4wb9RMQ/HS04iUYpHLz2h
   A==;
X-CSE-ConnectionGUID: SrR1UuqMSSu+ZXm+FisJPA==
X-CSE-MsgGUID: Gh9rzAcOTTaO6EPWHMm9BA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41835928"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="41835928"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 15:34:46 -0800
X-CSE-ConnectionGUID: AsXfyWSMTdSHhLffKlXvQQ==
X-CSE-MsgGUID: A8HZV8X0Qfihps4oRii//w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="117982288"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 15:33:51 -0800
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [RFC PATCH 05/17] x86/resctrl: Change generic monitor functions to use struct rdt_domain_hdr
Date: Mon,  3 Mar 2025 15:33:25 -0800
Message-ID: <20250303233340.333743-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303233340.333743-1-tony.luck@intel.com>
References: <20250303233340.333743-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Functions that don't need the internal details of the rdt_mon_domain
can operate on just the rdt_domain_hdr.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                |  2 +-
 arch/x86/kernel/cpu/resctrl/core.c     |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 60 +++++++++++++++++---------
 3 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index d94abba1c716..a89f0a7e2724 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -261,7 +261,7 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
 int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_domain *d);
-int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d);
+int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain_hdr *hdr);
 void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_domain *d);
 void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d);
 void resctrl_online_cpu(unsigned int cpu);
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 4974cbb842c1..7eddc07d35ee 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -613,7 +613,7 @@ static void setup_l3_mon_domain(int cpu, int id, struct rdt_resource *r, struct
 
 	list_add_tail_rcu(&d->hdr.list, add_pos);
 
-	err = resctrl_online_mon_domain(r, d);
+	err = resctrl_online_mon_domain(r, &d->hdr);
 	if (err) {
 		list_del_rcu(&d->hdr.list);
 		synchronize_rcu();
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6419e04d8a7b..d2f3718f16af 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3039,7 +3039,7 @@ static void mon_rmdir_one_subdir(struct kernfs_node *pkn, char *name, char *subn
  * when last domain being summed is removed.
  */
 static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-					   struct rdt_mon_domain *d)
+					   struct rdt_domain_hdr *hdr)
 {
 	struct rdtgroup *prgrp, *crgrp;
 	char subname[32];
@@ -3047,9 +3047,15 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 	char name[32];
 
 	snc_mode = r->mon_scope == RESCTRL_L3_NODE;
-	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci->id : d->hdr.id);
-	if (snc_mode)
-		sprintf(subname, "mon_sub_%s_%02d", r->name, d->hdr.id);
+	if (snc_mode) {
+		struct rdt_mon_domain *d;
+
+		d = container_of(hdr, struct rdt_mon_domain, hdr);
+		sprintf(name, "mon_%s_%02d", r->name, d->ci->id);
+		sprintf(subname, "mon_sub_%s_%02d", r->name, hdr->id);
+	} else {
+		sprintf(name, "mon_%s_%02d", r->name, hdr->id);
+	}
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
 		mon_rmdir_one_subdir(prgrp->mon.mon_data_kn, name, subname);
@@ -3059,10 +3065,11 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 	}
 }
 
-static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
+static int mon_add_all_files(struct kernfs_node *kn, struct rdt_domain_hdr *hdr,
 			     struct rdt_resource *r, struct rdtgroup *prgrp,
 			     bool do_sum)
 {
+	struct rdt_mon_domain *d;
 	struct rmid_read rr = {0};
 	union mon_data_bits priv;
 	struct mon_evt *mevt;
@@ -3071,8 +3078,13 @@ static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
 	if (WARN_ON(list_empty(&r->evt_list)))
 		return -EPERM;
 
+	if (r->rid == RDT_RESOURCE_L3) {
+		d = container_of(hdr, struct rdt_mon_domain, hdr);
+		priv.u.domid = do_sum ? d->ci->id : hdr->id;
+	} else {
+		priv.u.domid = hdr->id;
+	}
 	priv.u.rid = r->rid;
-	priv.u.domid = do_sum ? d->ci->id : d->hdr.id;
 	priv.u.sum = do_sum;
 	list_for_each_entry(mevt, &r->evt_list, list) {
 		priv.u.evtid = mevt->evtid;
@@ -3080,7 +3092,7 @@ static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
 		if (ret)
 			return ret;
 
-		if (!do_sum && is_mbm_event(mevt->evtid))
+		if (r->rid == RDT_RESOURCE_L3 && !do_sum && is_mbm_event(mevt->evtid))
 			mon_event_read(&rr, r, d, prgrp, &d->hdr.cpu_mask, mevt->evtid, true);
 	}
 
@@ -3088,10 +3100,11 @@ static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
 }
 
 static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
-				struct rdt_mon_domain *d,
+				struct rdt_domain_hdr *hdr,
 				struct rdt_resource *r, struct rdtgroup *prgrp)
 {
 	struct kernfs_node *kn, *ckn;
+	struct rdt_mon_domain *d;
 	char name[32];
 	bool snc_mode;
 	int ret = 0;
@@ -3099,7 +3112,12 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 	lockdep_assert_held(&rdtgroup_mutex);
 
 	snc_mode = r->mon_scope == RESCTRL_L3_NODE;
-	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci->id : d->hdr.id);
+	if (snc_mode) {
+		d = container_of(hdr, struct rdt_mon_domain, hdr);
+		sprintf(name, "mon_%s_%02d", r->name, d->ci->id);
+	} else {
+		sprintf(name, "mon_%s_%02d", r->name, hdr->id);
+	}
 	kn = kernfs_find_and_get(parent_kn, name);
 	if (kn) {
 		/*
@@ -3115,7 +3133,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 		ret = rdtgroup_kn_set_ugid(kn);
 		if (ret)
 			goto out_destroy;
-		ret = mon_add_all_files(kn, d, r, prgrp, snc_mode);
+		ret = mon_add_all_files(kn, hdr, r, prgrp, snc_mode);
 		if (ret)
 			goto out_destroy;
 	}
@@ -3132,7 +3150,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 		if (ret)
 			goto out_destroy;
 
-		ret = mon_add_all_files(ckn, d, r, prgrp, false);
+		ret = mon_add_all_files(ckn, hdr, r, prgrp, false);
 		if (ret)
 			goto out_destroy;
 	}
@@ -3150,7 +3168,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
  * and "monitor" groups with given domain id.
  */
 static void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-					   struct rdt_mon_domain *d)
+					   struct rdt_domain_hdr *hdr)
 {
 	struct kernfs_node *parent_kn;
 	struct rdtgroup *prgrp, *crgrp;
@@ -3158,12 +3176,12 @@ static void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
 		parent_kn = prgrp->mon.mon_data_kn;
-		mkdir_mondata_subdir(parent_kn, d, r, prgrp);
+		mkdir_mondata_subdir(parent_kn, hdr, r, prgrp);
 
 		head = &prgrp->mon.crdtgrp_list;
 		list_for_each_entry(crgrp, head, mon.crdtgrp_list) {
 			parent_kn = crgrp->mon.mon_data_kn;
-			mkdir_mondata_subdir(parent_kn, d, r, crgrp);
+			mkdir_mondata_subdir(parent_kn, hdr, r, crgrp);
 		}
 	}
 }
@@ -3172,14 +3190,14 @@ static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
 				       struct rdt_resource *r,
 				       struct rdtgroup *prgrp)
 {
-	struct rdt_mon_domain *dom;
+	struct rdt_domain_hdr *hdr;
 	int ret;
 
 	/* Walking r->domains, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
 
-	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
-		ret = mkdir_mondata_subdir(parent_kn, dom, r, prgrp);
+	list_for_each_entry(hdr, &r->mon_domains, list) {
+		ret = mkdir_mondata_subdir(parent_kn, hdr, r, prgrp);
 		if (ret)
 			return ret;
 	}
@@ -4027,7 +4045,7 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d
 	 * per domain monitor data directories.
 	 */
 	if (resctrl_mounted && resctrl_arch_mon_capable())
-		rmdir_mondata_subdir_allrdtgrp(r, d);
+		rmdir_mondata_subdir_allrdtgrp(r, &d->hdr);
 
 	if (is_mbm_enabled())
 		cancel_delayed_work(&d->mbm_over);
@@ -4096,10 +4114,12 @@ int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_domain *d
 	return err;
 }
 
-int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d)
+int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain_hdr *hdr)
 {
+	struct rdt_mon_domain *d;
 	int err;
 
+	d = container_of(hdr, struct rdt_mon_domain, hdr);
 	mutex_lock(&rdtgroup_mutex);
 
 	err = domain_setup_mon_state(r, d);
@@ -4122,7 +4142,7 @@ int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d)
 	 * If resctrl is mounted, add per domain monitor data directories.
 	 */
 	if (resctrl_mounted && resctrl_arch_mon_capable())
-		mkdir_mondata_subdir_allrdtgrp(r, d);
+		mkdir_mondata_subdir_allrdtgrp(r, hdr);
 
 out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
-- 
2.48.1


