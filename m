Return-Path: <linux-kernel+bounces-572076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD814A6C64C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517013B8B96
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB75D23237A;
	Fri, 21 Mar 2025 23:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwGh4y5C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C881EF0AD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 23:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742598983; cv=none; b=T+7AKXrrRz44WwMlBe9/F3jecjScda9dvGZG/3N/XDltkeRLWbDlwRjS0FdL2bc/ry8VfMU3zl/aj15T5/4qQpyXZfp2iMW076wKVVh2aeZUvjBlbCcFW/vBQUtjRvVW4TRyvUFdy1Db9uw355Qhu7vcd8klxJOY5uX0DESNDkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742598983; c=relaxed/simple;
	bh=YCXtwg87wrCU4Z3jRnxVIPQ1BGoTPXu4jvx/PIVRynY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBa3YR107cOzQQy5ho7MC9dp7pzQQsIsXR5uYqJ2Ds8CFFqQ8r2y1Pb5GENRjKCFbkGUKwVjcpm+/D/pydklkBp3VdMUxJv05zmYCVFl9l54i9bxvlSLmCXTtGOZskZyKegl4uZFMbQxxaadC04827dKGbfU9UennYsYJSoYDM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZwGh4y5C; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742598982; x=1774134982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YCXtwg87wrCU4Z3jRnxVIPQ1BGoTPXu4jvx/PIVRynY=;
  b=ZwGh4y5C1ZubiNLxfS8rbi9FGf/21kkeuHVDg6B2nT9wXGAgc/W9FMC9
   P0LtQ8IqWZBkZ1Ea8JaWYMtcjw8fAiHi1YSZqVkAqyooQMbRUzUZJgL43
   xTSDUWjRUNDpt+Dqv+uDaJvzqELOya9NnZ7seJOmNL+LrE/CLnDAf04kG
   HD6DesibXNBXnNc/Fn2HVYaZii/8eHdzEwXidAYIpHzoP6VDTcgGWsF+W
   xhkch8HNIj3/+LjJPjnDTnF97slF11GuVefzEIERE11D1WjMCDMNPEKe6
   fQOugUcG0Q0L/Tc6IwhTOAjjTee+fsmATiWGMt/StPwxfgzg9uB7izhM0
   A==;
X-CSE-ConnectionGUID: CK9A/YZNSuSirWSC78UuEA==
X-CSE-MsgGUID: oKCBwwBIR9uprkkDIx/38w==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43604560"
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="43604560"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 16:16:20 -0700
X-CSE-ConnectionGUID: 3iblysPaRZG09d87E0qmzg==
X-CSE-MsgGUID: p5MJigCbS2e4I2kH1VG6eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="128354295"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 16:16:20 -0700
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
Subject: [PATCH v2 03/16] x86/resctrl: Refactor domain_remove_cpu_mon() ready for new domain types
Date: Fri, 21 Mar 2025 16:15:53 -0700
Message-ID: <20250321231609.57418-4-tony.luck@intel.com>
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

Different types of domains require different actions when the last
CPU in the domain is removed.

Refactor to make it easy to add new actions for new types of domains.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 4205aeb4f979..3c343d0d18fb 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -635,20 +635,21 @@ static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	if (WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN))
+	cpumask_clear_cpu(cpu, &hdr->cpu_mask);
+	if (!cpumask_empty(&hdr->cpu_mask))
 		return;
 
 	d = container_of(hdr, struct rdt_mon_domain, hdr);
-	hw_dom = resctrl_to_arch_mon_dom(d);
 
-	cpumask_clear_cpu(cpu, &d->hdr.cpu_mask);
-	if (cpumask_empty(&d->hdr.cpu_mask)) {
+	switch (r->rid) {
+	case RDT_RESOURCE_L3:
+		hw_dom = resctrl_to_arch_mon_dom(d);
+
 		resctrl_offline_mon_domain(r, d);
-		list_del_rcu(&d->hdr.list);
+		list_del_rcu(&hdr->list);
 		synchronize_rcu();
 		mon_domain_free(hw_dom);
-
-		return;
+		break;
 	}
 }
 
-- 
2.48.1


