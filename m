Return-Path: <linux-kernel+bounces-572084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A1BA6C655
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39991B61C31
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710792356D8;
	Fri, 21 Mar 2025 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YyTB7apR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131D52343C9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 23:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742598988; cv=none; b=evINGEs9kD9cCVOvufYnHUZFluBECEuzA7+tv6UL6bu2UcOYO5oWdno7Qu071g9CyuuFSIM6HkRGMpWSbsYnUtI/AvVeaimNq2XP28fjLgi+BYtCZJTb9cFCdqxgGSlKxhTTCp4xO++mtRpbq9U0X6WqlCooHCFNCkvu5qXMnUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742598988; c=relaxed/simple;
	bh=1AOS5NOV/X2OFLA9OJSrKtuSZLspIDShcAFxfbEWq0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SV8V6HW47m98fT93h7JHphy7mxrg6LD8HjJdizhlX2IYNGI1AcjxtsNeWSKxqJvltNfIQQKBjnTS07Fm8DqoqnT21QKr/DHRT+QCQWYJQYeleEPXiRDJkI9w+SFrQXcU3ZEmct18Y4LW3o2duRkwh8reVREvB68ISKkA8i4F5HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YyTB7apR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742598987; x=1774134987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1AOS5NOV/X2OFLA9OJSrKtuSZLspIDShcAFxfbEWq0E=;
  b=YyTB7apRtzmljvUuUXT2SouaZ87P/crpSFZfcq5HMUGUWw6UM5QU5iMX
   C+H9uJCRUI8U+XNCRJviDys+7YC99/DtVuugdVZZsZbHtCHo7RyY2Ajnk
   gYW3TgmA2PI7mKv/5QepEzbrYnwQ5f1NohFr2hw4aziMCrYpH+awNwsI9
   nAtQz+fP5Y0VdFZV80ja0F41ave7NZDkx3z7a9mcHBx4a3oYUH5uI/zeV
   G7Z8kfLp8iPuU2dWRvgaDK4P71MznV6YuwWrr0u9qZU8e8fUWGr6Zz/Px
   r6nTD65yF/fHp0pKFvSF/q2rQx2uG+ZSmrZaBAgz41oQxcsledPxlhNvT
   A==;
X-CSE-ConnectionGUID: PEI064erQS6N+qo1RMMq5Q==
X-CSE-MsgGUID: bMConS2UREaVJyWNdudIWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43604619"
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="43604619"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 16:16:23 -0700
X-CSE-ConnectionGUID: 1BZc1KJHQNKJiCDrwZSnGw==
X-CSE-MsgGUID: fQ8gWGcQQeCHK72VLxeifQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="128354321"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 16:16:23 -0700
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
Subject: [PATCH v2 11/16] x86/resctrl: Link known events onto RDT_RESOURCE_INTEL_AET.evt_list
Date: Fri, 21 Mar 2025 16:16:01 -0700
Message-ID: <20250321231609.57418-12-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321231609.57418-1-tony.luck@intel.com>
References: <20250321231609.57418-1-tony.luck@intel.com>
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
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/resctrl/intel_aet.c
index e2d8eab997fc..9ac912742ef1 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -13,6 +13,7 @@
 
 #include <linux/cpu.h>
 #include <linux/cleanup.h>
+#include <linux/minmax.h>
 #include <linux/slab.h>
 #include "fake_intel_aet_features.h"
 #include <linux/intel_vsec.h>
@@ -308,14 +309,34 @@ void rdt_get_intel_aet_mount(void)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_INTEL_AET].r_resctrl;
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
 		list_for_each_entry_safe(d, tmp, &r->mon_domains, hdr.list)
 			kfree(d);
 		r->mon_capable = false;
-- 
2.48.1


