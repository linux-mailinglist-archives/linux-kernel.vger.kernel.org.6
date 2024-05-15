Return-Path: <linux-kernel+bounces-180439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545748C6E9E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6DF1F238C4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685A416F902;
	Wed, 15 May 2024 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AVfpRoSg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEF515F3F6
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715811826; cv=none; b=BF/Al9NhJfqKNp6UT/OSAe+/y4yh+VqfO86XZsjz/jkeQbeMQ06J2G2c9qsTyVLJXMgQYsshRDlbC/V5iIDO25iXlVqvWRnPS9AtNHvABek9zLOmVwb2M8VO+SH6Cb8rd/WbSQs15ya4IW6GtjdDIxFMhy/W58NAuwxz/0+0BVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715811826; c=relaxed/simple;
	bh=xZjqBCuTBBldbea6pHTW+ptVpegP77hRi5Pdpchcfvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhGdMQDZvbqf2ZMsSQ/LJK4/Y/I+HMlSWu4qV+/uymAOU7YqrFhQITnkGmksVBx83y/kIOBJiksue281121Ye6LlQjiPvfol5GpyIkBfHvUJNBbPMP8cTaanEn6APJa0PmyH5q2tr9/jAW/ssdYrxN2xWmm9Iu1C57vrpNbgk0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AVfpRoSg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715811824; x=1747347824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xZjqBCuTBBldbea6pHTW+ptVpegP77hRi5Pdpchcfvs=;
  b=AVfpRoSgMLT8d6WrTovlHXu3XflzhYYgAoYqbd/CjUXEP1tQANaDWDdh
   EOI9I6s1OhW8flobcc/q9PM2pqSbfnja6LJEXtt82PwBpDcCzJCOHq1ym
   iSC6dBpdgOhNGKmh5P1mzSw7PaWCX4KMyEvNZ6mhr+JomEOh++PzilTUX
   nIThm3LWCJS1cH5DI+RIDgJbh7nOmqrXATsX4VD8C8zwb2EoNgl6UU7XO
   He56QY0TAt0hLMP7497aaYTn3c3vkh5GTO9+J1lVqVRmLnsk0Sy+Kw1QK
   tbSbRn72MXnTa7S4umn0cJw2ZBW+xraFsPOQ1yhjVIEi6EKzkbshW8xV3
   g==;
X-CSE-ConnectionGUID: 1ea8WIsjTly1ZitNMJPLug==
X-CSE-MsgGUID: 6rlaIDJuQr22NbpoirlZqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15671728"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="15671728"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 15:23:37 -0700
X-CSE-ConnectionGUID: lBBOznPzRu2o2+Nwf8Hq/Q==
X-CSE-MsgGUID: XKlPT9SwSiurhNppnPBdgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="35989193"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 15:23:37 -0700
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
Subject: [PATCH v18 15/17] x86/resctrl: Fix RMID reading sanity check for Sub-NUMA (SNC) mode
Date: Wed, 15 May 2024 15:23:23 -0700
Message-ID: <20240515222326.74166-16-tony.luck@intel.com>
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

The sanity check that RMIDs are being read from a CPU listed in the
the cpu_mask for the domain is incorrect when summing across multiple
SNC domains. It is safe to read the RMID from any CPU that shares the
same L3 cache instance.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 668d2fdf58cd..e4b92c7af71d 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -15,6 +15,7 @@
  * Software Developer Manual June 2016, volume 3, section 17.17.
  */
 
+#include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
@@ -281,8 +282,18 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 
 	resctrl_arch_rmid_read_context_check();
 
-	if (!cpumask_test_cpu(smp_processor_id(), &d->hdr.cpu_mask))
-		return -EINVAL;
+	if (r->mon_scope == r->mon_display_scope) {
+		if (!cpumask_test_cpu(smp_processor_id(), &d->hdr.cpu_mask))
+			return -EINVAL;
+	} else {
+		/*
+		 * SNC: OK to read events on any CPU sharing same L3
+		 * cache instance.
+		 */
+		if (d->display_id != get_cpu_cacheinfo_id(smp_processor_id(),
+							  r->mon_display_scope))
+			return -EINVAL;
+	}
 
 	ret = __rmid_read(rmid, eventid, &msr_val);
 	if (ret)
-- 
2.44.0


