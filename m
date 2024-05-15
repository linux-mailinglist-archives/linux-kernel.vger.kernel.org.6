Return-Path: <linux-kernel+bounces-180437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 051DF8C6E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7F11F238E9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47B316F0FD;
	Wed, 15 May 2024 22:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="feFLF2Fa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735FB15D5A9
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 22:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715811825; cv=none; b=W3idwu9W8w26N+N8qWKFCbIgOdk6nyuJq76CurH4lJpHdkWtDtA6Qw/vRbeIyiDpBF7RkGN+dWCm67r7tJn6KR0cp+P9j8tdRtHzEXJnCo1HmqDxS5YjBnQYAO3RMDmBajkH2f0m6lIbQqsn9P8lvM794qYf/vNQVUvPlR8JOBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715811825; c=relaxed/simple;
	bh=czKlljQin5GaFm+0xyDc9Vi3UAAxcA5z/t7zvNVeNeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ef8LcVu0IATmmjYuxel046UIyrCywIFoUaAMtiPFiJDmR/XgMVlzn7yI3M2YWeYBLWp2axnDPLxKTx2qZD3Oi4SLkLinfCX2S59IxJe7Sv1UEz2sTPO0uT+WeMjp8E4I3W235JN4Qv0NWj/9wtIqNGoEu9gzX0c22MiiRBGVBS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=feFLF2Fa; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715811823; x=1747347823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=czKlljQin5GaFm+0xyDc9Vi3UAAxcA5z/t7zvNVeNeg=;
  b=feFLF2FaNGyoqWSsUehC/d5IQbkASeyrNiV8yZBDJuLOMbZf39e03k3W
   a4HisqVpoIYbvZVzA4YmBxvpGKGRANEnZYnX00M4SYJrP7xTt2lygVBHq
   7Gjwfstn4SexvCFzLB9f0W1NgU+oCIsAKcJE5N1toKbVb6OYpMXI629YN
   64xqYpJ+ovcC5uu2k6MYsLN3eIUYXnseH2CtL5Az9k3eGb1jj82pU6vzl
   vWgmqtrsgA6Oq4IBmluiwz3hEWusH67JZ8rSkbzArmEmg2lhqfSMFLk3Y
   wkrQ788SrGHtN71BUte6uWt/mugXKdbw1GILR50QdMPm1+OxuDBQkBul2
   A==;
X-CSE-ConnectionGUID: rucaQbfzTcCKwQtcKA6Smg==
X-CSE-MsgGUID: IzF8R/H6RsG/PTvyYqwyZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15671703"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="15671703"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 15:23:36 -0700
X-CSE-ConnectionGUID: wQcXbIbCQlu9THH8nuwuIw==
X-CSE-MsgGUID: tzW/IxadRhSXp+MSTRFJcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="35989187"
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
Subject: [PATCH v18 13/17] x86/resctrl: Handle removing directories in Sub-NUMA (SNC) mode
Date: Wed, 15 May 2024 15:23:21 -0700
Message-ID: <20240515222326.74166-14-tony.luck@intel.com>
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

In SNC mode there are multiple subdirectories in each L3 level monitor
directory (one for each SNC node). If all the CPUs in an SNC node are
taken offline, then just that SNC node directory must be removed. In
non-SNC mode, or when the last SNC node directory is removed, also
remove the L3 monitor directory.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 43 +++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f0f468babdea..cac32ddd3afd 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3011,17 +3011,46 @@ static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
  * and monitor groups with given domain id.
  */
 static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-					   unsigned int dom_id)
+					   struct rdt_mon_domain *d)
 {
 	struct rdtgroup *prgrp, *crgrp;
+	struct rdt_mon_domain *dom;
+	bool remove_all = true;
+	struct kernfs_node *kn;
+	char subname[32];
 	char name[32];
 
+	sprintf(name, "mon_%s_%02d", r->name, d->display_id);
+	if (r->mon_scope != r->mon_display_scope) {
+		int count = 0;
+
+		list_for_each_entry(dom, &r->mon_domains, hdr.list)
+			if (d->display_id == dom->display_id)
+				count++;
+		if (count > 1) {
+			remove_all = false;
+			sprintf(subname, "mon_sub_%s_%02d", r->name, d->hdr.id);
+		}
+	}
+
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
-		sprintf(name, "mon_%s_%02d", r->name, dom_id);
-		kernfs_remove_by_name(prgrp->mon.mon_data_kn, name);
+		if (remove_all) {
+			kernfs_remove_by_name(prgrp->mon.mon_data_kn, name);
+		} else {
+			kn = kernfs_find_and_get_ns(prgrp->mon.mon_data_kn, name, NULL);
+			if (kn)
+				kernfs_remove_by_name(kn, subname);
+		}
 
-		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
-			kernfs_remove_by_name(crgrp->mon.mon_data_kn, name);
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list) {
+			if (remove_all) {
+				kernfs_remove_by_name(crgrp->mon.mon_data_kn, name);
+			} else {
+				kn = kernfs_find_and_get_ns(prgrp->mon.mon_data_kn, name, NULL);
+				if (kn)
+					kernfs_remove_by_name(kn, subname);
+			}
+		}
 	}
 }
 
@@ -3111,8 +3140,8 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 static void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 					   struct rdt_mon_domain *d)
 {
-	struct kernfs_node *parent_kn;
 	struct rdtgroup *prgrp, *crgrp;
+	struct kernfs_node *parent_kn;
 	struct list_head *head;
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
@@ -3984,7 +4013,7 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d
 	 * per domain monitor data directories.
 	 */
 	if (resctrl_mounted && resctrl_arch_mon_capable())
-		rmdir_mondata_subdir_allrdtgrp(r, d->hdr.id);
+		rmdir_mondata_subdir_allrdtgrp(r, d);
 
 	if (is_mbm_enabled())
 		cancel_delayed_work(&d->mbm_over);
-- 
2.44.0


