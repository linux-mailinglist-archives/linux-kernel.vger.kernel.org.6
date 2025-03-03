Return-Path: <linux-kernel+bounces-542902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D556A4CF43
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5F043AC897
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB26238D5F;
	Mon,  3 Mar 2025 23:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hkjEdsKT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C2F1F461C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044889; cv=none; b=j09fHPOb8kRNBjEcRL7rzKlPirMrWzuzq/c5B/U3xR0f7noTm4S4RHUcHT5tcS+o27BSXPNXzuvwtdMAzmILaOUXXF+prX1/tWXGze2Nh0zwwyb/wEVs7y2dAA0UmNbLFBe+/ziSNEcSqWedietAgyncYp6a6d4YYTaogGN3meA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044889; c=relaxed/simple;
	bh=sor4EW25FS9wp5jwJSTmp9DXQtXHknVfBI/RoNrUi6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSKwMoA9yRrwg/eE2R/BRSUfS1/EDdJlgRFJqwXO4jIEKzoQ++yiwXSdZQ8Fwg29sVOOefab2Jkj8IlPxbzs1bFHtMsKeo6tC+FD2aLExGYpMGmBlbWOXrMA6K/6nmZqeEQObWJ+ne8ZHscTxGT7Q0m/WhnBn6q92BOzFJ5SDDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hkjEdsKT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741044888; x=1772580888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sor4EW25FS9wp5jwJSTmp9DXQtXHknVfBI/RoNrUi6k=;
  b=hkjEdsKTNUqVnrT4j95Xkv0cFmA/9m9bfIJaVKUDOfpekqeRZKs0bCvd
   3Bg2CKlx/lOk0L1eJssEXvr0yf0/KWIF0xjPlju0Bkz41Zirs3fDKtA/h
   TTvIcnTKaQKBpsKCo7UYDXApg5gdqSPrlcMbA/C8Yoth+3hYlqoPF74uT
   rad/0TITyEWBkB0A4ETjvsPW1Z4HlYwbjP6bbnuDkouDKAk2We4C7Z4sS
   xuE/ve6KUHtFCKy6GWBP7Me0yA2c2VlDQOClqVGQLrzx0SKkg5iz3ONft
   nC0G9SrOKtOrIRnrJwpFahaPhQ/waYTpAJKblnHDjAoW5vBFn1VL3V+Hw
   g==;
X-CSE-ConnectionGUID: +LHeDd4nSQeehXgBHMg18g==
X-CSE-MsgGUID: iVt2/UX1R9mJnKZilLmQJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41835900"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="41835900"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 15:34:46 -0800
X-CSE-ConnectionGUID: gfCHovs2R6Km4yr+cxM2PQ==
X-CSE-MsgGUID: YbMaoyVeQsybGUVJxjFzuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="117982279"
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
Subject: [RFC PATCH 02/17] x86/resctrl: Move L3 initialization out of domain_add_cpu_mon()
Date: Mon,  3 Mar 2025 15:33:22 -0800
Message-ID: <20250303233340.333743-3-tony.luck@intel.com>
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

To prepare for additional types of monitoring domains, move all the
L3 specific initialization into a helper function.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/core.c | 52 +++++++++++++++++-------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 3d1735ed8d1f..dd694958df5a 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -583,33 +583,12 @@ static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
 	}
 }
 
-static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
+static void setup_l3_mon_domain(int cpu, int id, struct rdt_resource *r, struct list_head *add_pos)
 {
-	int id = get_domain_id_from_scope(cpu, r->mon_scope);
-	struct list_head *add_pos = NULL;
 	struct rdt_hw_mon_domain *hw_dom;
-	struct rdt_domain_hdr *hdr;
 	struct rdt_mon_domain *d;
 	int err;
 
-	lockdep_assert_held(&domain_list_lock);
-
-	if (id < 0) {
-		pr_warn_once("Can't find monitor domain id for CPU:%d scope:%d for resource %s\n",
-			     cpu, r->mon_scope, r->name);
-		return;
-	}
-
-	hdr = rdt_find_domain(&r->mon_domains, id, &add_pos);
-	if (hdr) {
-		if (WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN))
-			return;
-		d = container_of(hdr, struct rdt_mon_domain, hdr);
-
-		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
-		return;
-	}
-
 	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
 	if (!hw_dom)
 		return;
@@ -642,6 +621,35 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	}
 }
 
+static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
+{
+	int id = get_domain_id_from_scope(cpu, r->mon_scope);
+	struct list_head *add_pos = NULL;
+	struct rdt_domain_hdr *hdr;
+
+	lockdep_assert_held(&domain_list_lock);
+
+	if (id < 0) {
+		pr_warn_once("Can't find monitor domain id for CPU:%d scope:%d for resource %s\n",
+			     cpu, r->mon_scope, r->name);
+		return;
+	}
+
+	hdr = rdt_find_domain(&r->mon_domains, id, &add_pos);
+	if (hdr) {
+		cpumask_set_cpu(cpu, &hdr->cpu_mask);
+		return;
+	}
+
+	switch (r->rid) {
+	case RDT_RESOURCE_L3:
+		setup_l3_mon_domain(cpu, id, r, add_pos);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+}
+
 static void domain_add_cpu(int cpu, struct rdt_resource *r)
 {
 	if (r->alloc_capable)
-- 
2.48.1


