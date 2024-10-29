Return-Path: <linux-kernel+bounces-387406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A7D9B50D5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66397284314
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5D62076A9;
	Tue, 29 Oct 2024 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1romaM9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C69220495C;
	Tue, 29 Oct 2024 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222923; cv=none; b=em3KHfOpM+8pjHKdAMkmIcEwzNkSwqWiovGtP0xTXKmmniGsGUl15ixDSV6yY0Bs1+o5tRELi79N7IWEbneP0T1f9Aypt9usSC1iY6Kfw/bl0jHB/CBJuQ31WZmW46ckv/UgV6mdsMEXoPXkji03cuy7t5Z2YwLJIuVrUp81cwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222923; c=relaxed/simple;
	bh=NGkaoI9qAkY3/PRKqgR7Ojby6kj9rG3/xXGUsvQqhio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvDzgWrvuDjkJ3EZtLonLcyzJNgxj27EnsZxzXSZwbJyiAYPnzxQVzKW5JiNHToROykLKgY1YdWpni2kqVVqO+ID6onORKtal/cFf0zqWerqMfr5sJG4vn9GoxhfB+aC+t8XC+ksHrkL/XKt0GHOoA/S1QGlUhjJO05nCgOjRrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1romaM9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730222921; x=1761758921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NGkaoI9qAkY3/PRKqgR7Ojby6kj9rG3/xXGUsvQqhio=;
  b=m1romaM9VR1JvOyN1ZP83rnI2nMxaiV4qIsvVUasgDjJ4QCIoaMbrUGy
   nm0ugDZIlsa5RfNH9A9cLRGqGUuXOpNjkbzOa88v2SjMZMUk+DfXjd+H0
   rO4bpdt8aNo6CD5sSBlf4qk1mPKZsuIuWQd24wokIE6FeyP53pPheZFkv
   cZfAHhJQI4ct+hWihdqfHZ6GpsiU2UvnQqbc7hB3Q3f3g2E4mGh2QntZs
   f5fj++Dyo2iRZ3kKUXAtZuCrExJ5fGwrva3OGU5QZ0lV/Xluha9TwiCq4
   K9HHTM7/rhWCEKyjf0Cv7PWwpdG0cJWBU3l04cpXGS8XPsYaQbcOeR0at
   Q==;
X-CSE-ConnectionGUID: K+Tc8AmlQqC51XBabV8cJA==
X-CSE-MsgGUID: HJ+kQkv4R06zU1OTi6GFxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="17515665"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="17515665"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 10:28:39 -0700
X-CSE-ConnectionGUID: GJb4gQBgTwG6xoFu2WNHNw==
X-CSE-MsgGUID: fgEfaAj1QIOkcjsRKRWMbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81585600"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 10:28:39 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	x86@kernel.org
Cc: James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v8 2/7] x86/resctrl: Compute memory bandwidth for all supported events
Date: Tue, 29 Oct 2024 10:28:27 -0700
Message-ID: <20241029172832.93963-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029172832.93963-1-tony.luck@intel.com>
References: <20241029172832.93963-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Computing the bandwidth for an event is cheap, and only done once
per second. Doing so simplifies switching between events and allows
choosing different events per ctrl_mon group.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 38 ++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 851b561850e0..3ef339e405c2 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -663,9 +663,12 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
  */
 static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
 {
-	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
-	struct mbm_state *m = &rr->d->mbm_local[idx];
 	u64 cur_bw, bytes, cur_bytes;
+	struct mbm_state *m;
+
+	m = get_mbm_state(rr->d, closid, rmid, rr->evtid);
+	if (WARN_ON_ONCE(!m))
+		return;
 
 	cur_bytes = rr->val;
 	bytes = cur_bytes - m->prev_bw_bytes;
@@ -752,20 +755,31 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
 	u32 closid, rmid, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
 	struct rdt_ctrl_domain *dom_mba;
+	enum resctrl_event_id evt_id;
 	struct rdt_resource *r_mba;
-	u32 cur_bw, user_bw, idx;
 	struct list_head *head;
 	struct rdtgroup *entry;
+	u32 cur_bw, user_bw;
 
-	if (!is_mbm_local_enabled())
+	if (!is_mbm_enabled())
 		return;
 
 	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
+	evt_id = rgrp->mba_mbps_event;
+
+	if (WARN_ON_ONCE(!is_mbm_event(evt_id)))
+		return;
+	if (WARN_ON_ONCE(evt_id == QOS_L3_MBM_LOCAL_EVENT_ID && !is_mbm_local_enabled()))
+		return;
+	if (WARN_ON_ONCE(evt_id == QOS_L3_MBM_TOTAL_EVENT_ID && !is_mbm_total_enabled()))
+		return;
+
 
 	closid = rgrp->closid;
 	rmid = rgrp->mon.rmid;
-	idx = resctrl_arch_rmid_idx_encode(closid, rmid);
-	pmbm_data = &dom_mbm->mbm_local[idx];
+	pmbm_data = get_mbm_state(dom_mbm, closid, rmid, evt_id);
+	if (WARN_ON_ONCE(!pmbm_data))
+		return;
 
 	dom_mba = get_ctrl_domain_from_cpu(smp_processor_id(), r_mba);
 	if (!dom_mba) {
@@ -784,7 +798,9 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
 	 */
 	head = &rgrp->mon.crdtgrp_list;
 	list_for_each_entry(entry, head, mon.crdtgrp_list) {
-		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
+		cmbm_data = get_mbm_state(dom_mbm, entry->closid, entry->mon.rmid, evt_id);
+		if (WARN_ON_ONCE(!cmbm_data))
+			return;
 		cur_bw += cmbm_data->prev_bw;
 	}
 
@@ -837,6 +853,14 @@ static void mbm_update(struct rdt_resource *r, struct rdt_mon_domain *d,
 
 		__mon_event_count(closid, rmid, &rr);
 
+		/*
+		 * Call the MBA software controller only for the
+		 * control groups and when user has enabled
+		 * the software controller explicitly.
+		 */
+		if (is_mba_sc(NULL))
+			mbm_bw_count(closid, rmid, &rr);
+
 		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
 	}
 	if (is_mbm_local_enabled()) {
-- 
2.47.0


