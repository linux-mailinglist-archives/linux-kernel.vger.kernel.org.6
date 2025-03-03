Return-Path: <linux-kernel+bounces-542912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D33A4CF4D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC2A3ACB51
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F41241671;
	Mon,  3 Mar 2025 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8fRAQZz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEDE23F28D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044896; cv=none; b=Z7U/5Rdxhxg0oDMy+/qa2j60OadufF94fNKaFDBQQQI461z5SCiC88da0fo3AfYuEcvQOh7ut2YFN45rnfbcdYpEp+1moubTpIEeJY33x2gZo/V13ooz+tWmaqNRNx7sJSknxaj8jyzOiaruIS4/yqZD6V1mnwCXF0mqeJaOz0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044896; c=relaxed/simple;
	bh=4MoQg5m1EvWqC4eUPuuvU9SN1nimbFf5mvHqPzoqqSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTXsucN9qobpIf/nOhLp5KCgNaxBWSPF67rVO+W7YbZ9Gc7BYl/u53Ku4RswjjjGfrqtOsJEotNsQ8T4TefITul92GT0z1TOMDYHZRE/fVvyZPQnAZNy2ON//kp+JNsyZzQ6fxmtdOLkCnJdoQUy94AeXa/Nr9Ze5KLxoqTTaxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L8fRAQZz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741044895; x=1772580895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4MoQg5m1EvWqC4eUPuuvU9SN1nimbFf5mvHqPzoqqSs=;
  b=L8fRAQZzmdWeShR2ruzqxp/W/zkR24bMDE0ZjvP+yCC0+t2ZsGtHYQij
   DxFJ/5v1JiLNJNPZUQdHDAn2D23+thMQZgsmajEJlkrNBYfYqJsGmtSxy
   ae/vx9zVZ8C/kGAola5EeEhjhkTjSs8i2guMFI3CSQdRfId+rxHzXM/X3
   kSXhDRA3s2ro3pacmYMqcAQLbj1lv1Ee+63x9boDCogZzHQdDgeXdIURD
   1hZUy5yxF0T7JI2ep7tkvZj5MyBva6NNNaP7H/Qoqcf7j6xbCRXYv5pJx
   cc+Sx8ou6VymIy3QMVfnnwWfoponAZ6DbPKH76hS6HCA9CKm4E49ES4Yp
   w==;
X-CSE-ConnectionGUID: 6QBGma1GT62mb0O7jRmy3Q==
X-CSE-MsgGUID: AeYlrbuLQqW6fSNLvbkqyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41835976"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="41835976"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 15:34:47 -0800
X-CSE-ConnectionGUID: QNCp+lAXSwKixeh97KdsSw==
X-CSE-MsgGUID: I+AbBn3jRhKXI4y+W11s4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="117982302"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 15:33:53 -0800
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
Subject: [RFC PATCH 12/17] x86/resctrl: Add list of known events to RDT_RESOURCE_INTEL_PMT
Date: Mon,  3 Mar 2025 15:33:32 -0800
Message-ID: <20250303233340.333743-13-tony.luck@intel.com>
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

Core code uses this list to populate "mon_data" directories.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/intel_pmt.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/intel_pmt.c b/arch/x86/kernel/cpu/resctrl/intel_pmt.c
index 754748d858c6..05640e85d303 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_pmt.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_pmt.c
@@ -13,6 +13,7 @@
 
 #include <linux/cpu.h>
 #include <linux/cleanup.h>
+#include <linux/minmax.h>
 #include <linux/slab.h>
 #include "fake_intel_pmt_features.h"
 #include <linux/intel_vsec.h>
@@ -254,14 +255,35 @@ void rdt_get_intel_pmt_mount(void)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_INTEL_PMT].r_resctrl;
 	struct rdt_core_mon_domain *d, *tmp;
+	struct telem_entry **tentry;
 	static int do_one_time;
+	struct mon_evt *evt;
+	bool ret = false;
 
 	if (do_one_time)
 		return;
 
 	do_one_time = 1;
 
-	if (!get_events()) {
+	if (!get_events())
+		goto done;
+
+	for (tentry = telem_entry; *tentry; tentry++) {
+		if (!(*tentry)->active)
+			continue;
+		for (int i = 0; (*tentry)->evts[i].evt.name; i++) {
+			evt = &(*tentry)->evts[i].evt;
+			list_add_tail(&evt->list, &r->evt_list);
+			ret = true;
+		}
+		if (!r->num_rmid)
+			r->num_rmid = (*tentry)->num_rmids;
+		else
+			r->num_rmid = min(r->num_rmid, (*tentry)->num_rmids);
+	}
+done:
+	if (!ret) {
+		r->mon_capable = false;
 		list_for_each_entry_safe(d, tmp, &r->mon_domains, hdr.list)
 			kfree(d);
 		r->mon_capable = false;
-- 
2.48.1


