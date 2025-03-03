Return-Path: <linux-kernel+bounces-542905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1169A4CF46
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83941724D8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D0623C8D3;
	Mon,  3 Mar 2025 23:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkK/Bk1c"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B46323719E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 23:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044891; cv=none; b=qsBaZ/JeNLa65fy48dVaT/SAqQOelcrCBQ/6z/671swWW3MILcdBMSzU76PrhKGyZhsrHY1TUOGmnUrRvGQZPKe8v0LcqMrxE6OTl2dvWTR91Yqv9cGvfneQBMfLGCkCvUMhdElonEUL5uqOlBbneRt986hwwqF7HTWFEkFK7a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044891; c=relaxed/simple;
	bh=yy0dlVhKmEuufnCmp400TE9M9AV853wWbPKFkEusswM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kx4PgHgr6QRl/OXKjOMWr5d9FGZGQRkofhKMJXfafJ4v42WxGP5oVm8obWjlACxrMi8OWb4a1dRxvicjot+bIqYAWrpnwgOtmLap5ZqiHIVzf18Y/yg+oquQ+7/JDD6Up9ua/8IFqZYIaCiRNOkqe/jLC7NRz/0le/DSJGfaIgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkK/Bk1c; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741044889; x=1772580889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yy0dlVhKmEuufnCmp400TE9M9AV853wWbPKFkEusswM=;
  b=IkK/Bk1cGfXdzvpcec1dJid8a9AEpiaQlpQ/weXE94ZHPT8iESUJ7K1N
   aBe2vPZCqchyPUFpGspR2COqjIS2D0GuWI+APhuI8E2upuyC2DmiIMsCi
   MH6HR7+PQPIjXIkzp4LHMw6o7KYgYQknvn1hOsNJzKCuh2psVwVwBMaGJ
   Tp7J9cbDcdpIzC3jSDX+A+gn34BpV64BjGMbXsWiMBpfR2Q8NjkpBSglR
   8USszJup4skOhWXjJ5+Hx73R4WGwRxUdgdX9jM90jN8B5iQ21HCqWO2VF
   QkqhU0hvsL1UuuUcTpcG/H6cT9bBfGd002FXJNozrA7IJ/ygjoXGbMTQN
   Q==;
X-CSE-ConnectionGUID: 7/SXYnMoSCaAkU91a1plpQ==
X-CSE-MsgGUID: 3Nn4IBLmSYuhaVSUYPHtyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41835922"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="41835922"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 15:34:46 -0800
X-CSE-ConnectionGUID: ZsKdpOW4SA6xeb013sQObw==
X-CSE-MsgGUID: vynoUKVTS3iMt5Uohz5NGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="117982286"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 15:33:50 -0800
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
Subject: [RFC PATCH 04/17] x86/resctrl: Split L3 specific code out of rdtgroup_mondata_show()
Date: Mon,  3 Mar 2025 15:33:24 -0800
Message-ID: <20250303233340.333743-5-tony.luck@intel.com>
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

New monitor resources require different operations to read counters.

Move the L3 specific code to a helper function.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 79 +++++++++++++----------
 1 file changed, 46 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 536351159cc2..515a9bec05cd 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -627,31 +627,14 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 	resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
 }
 
-int rdtgroup_mondata_show(struct seq_file *m, void *arg)
+static int rdtgroup_l3_data_show(struct seq_file *m, struct rdt_resource *r,
+				 int domid, struct rdtgroup *rdtgrp, u32 evtid,
+				 bool sum, struct rmid_read *rr)
 {
-	struct kernfs_open_file *of = m->private;
 	struct rdt_domain_hdr *hdr;
-	struct rmid_read rr = {0};
 	struct rdt_mon_domain *d;
-	u32 resid, evtid, domid;
-	struct rdtgroup *rdtgrp;
-	struct rdt_resource *r;
-	union mon_data_bits md;
-	int ret = 0;
-
-	rdtgrp = rdtgroup_kn_lock_live(of->kn);
-	if (!rdtgrp) {
-		ret = -ENOENT;
-		goto out;
-	}
 
-	md.priv = of->kn->priv;
-	resid = md.u.rid;
-	domid = md.u.domid;
-	evtid = md.u.evtid;
-	r = &rdt_resources_all[resid].r_resctrl;
-
-	if (md.u.sum) {
+	if (sum) {
 		/*
 		 * This file requires summing across all domains that share
 		 * the L3 cache id that was provided in the "domid" field of the
@@ -660,37 +643,67 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		 */
 		list_for_each_entry(d, &r->mon_domains, hdr.list) {
 			if (d->ci->id == domid) {
-				rr.ci = d->ci;
-				mon_event_read(&rr, r, NULL, rdtgrp,
+				rr->ci = d->ci;
+				mon_event_read(rr, r, NULL, rdtgrp,
 					       &d->ci->shared_cpu_map, evtid, false);
 				goto checkresult;
 			}
 		}
-		ret = -ENOENT;
-		goto out;
+		return -ENOENT;
 	} else {
 		/*
 		 * This file provides data from a single domain. Search
 		 * the resource to find the domain with "domid".
 		 */
 		hdr = rdt_find_domain(&r->mon_domains, domid, NULL);
-		if (!hdr || WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN)) {
-			ret = -ENOENT;
-			goto out;
-		}
+		if (!hdr || WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN))
+			return -ENOENT;
 		d = container_of(hdr, struct rdt_mon_domain, hdr);
-		mon_event_read(&rr, r, d, rdtgrp, &d->hdr.cpu_mask, evtid, false);
+		mon_event_read(rr, r, d, rdtgrp, &d->hdr.cpu_mask, evtid, false);
 	}
 
 checkresult:
 
-	if (rr.err == -EIO)
+	if (rr->err == -EIO)
 		seq_puts(m, "Error\n");
-	else if (rr.err == -EINVAL)
+	else if (rr->err == -EINVAL)
 		seq_puts(m, "Unavailable\n");
 	else
-		seq_printf(m, "%llu\n", rr.val);
+		seq_printf(m, "%llu\n", rr->val);
 
+	return 0;
+}
+
+int rdtgroup_mondata_show(struct seq_file *m, void *arg)
+{
+	struct kernfs_open_file *of = m->private;
+	struct rmid_read rr = {0};
+	u32 resid, evtid, domid;
+	struct rdtgroup *rdtgrp;
+	struct rdt_resource *r;
+	union mon_data_bits md;
+	int ret = 0;
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	md.priv = of->kn->priv;
+	resid = md.u.rid;
+	domid = md.u.domid;
+	evtid = md.u.evtid;
+	r = &rdt_resources_all[resid].r_resctrl;
+
+	switch (r->rid) {
+	case RDT_RESOURCE_L3:
+		ret = rdtgroup_l3_data_show(m, r, domid, rdtgrp, evtid, md.u.sum, &rr);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
 out:
 	rdtgroup_kn_unlock(of->kn);
 	return ret;
-- 
2.48.1


