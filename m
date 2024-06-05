Return-Path: <linux-kernel+bounces-202897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9EA8FD29A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14BA1F230B3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515B7191499;
	Wed,  5 Jun 2024 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LiyqIBvQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27250188CAE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604082; cv=none; b=lAo3hFbTLRTPP/USxVyGsvxqgU+qQbHZ86+GRzfahmTmzi+ELmkRxxeb9RacnDbJTFY23YyswuHmNxPXcGNAyRU/LQpgCuVUkUpSlRiHrnokUyXkLorqNruN2g7jGC1sGbalXNMThtsaIBTpM1TqFBtVHbRHvrtWjqnynJv5wjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604082; c=relaxed/simple;
	bh=mtXhJIqFcxEurjVvwCm6Vo/pYjEoRRPxXTYeDGZw23k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgKKEPg5c0LuiD4LO6CchFr1fE9tunOHay9HgMzzLNrK8j4ukEmdW95jVYPyKDvABPO7Vmtwqc/h5miOJACfE12TeobTmUvh6HDpGDx0eUSKEbEcWqHpVgdX/ouCErRXLJjMyMfuXOkNVIXo3ohuDE4IP0r8BRP+qQVxL8C0gzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LiyqIBvQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717604081; x=1749140081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mtXhJIqFcxEurjVvwCm6Vo/pYjEoRRPxXTYeDGZw23k=;
  b=LiyqIBvQkX4JvoGSHg99JRD5qJDQ8uwtxfnL/lmnA+oDz63O0aYNMmqE
   4jlUpiYvTHn9yoCcsZ9hEBFezg1jrB20uVB2uVvnNwiggrbOBD4bGfkmD
   B0SV/6Fjy5FXlbWKrhIAVzIDOLRUN3Y6WIpsG0vM5N/Lao/3PQ48tf+G/
   K1IigpDR2RPgADF5JqCcvXkgCFCbjTUkHIHZ6aVgocQsZOTtWfnviB/V6
   3owGh+EtWz6Iy11onmWfT3QDw46RPhmC1sGYxuiP1ktcrpbakovTfchyB
   49YUxHEwnS4Pr+TDHGYzwMJ6o11NxyAK7hZ3tg1iXDvVUHYVJ2ua4tFRa
   A==;
X-CSE-ConnectionGUID: kcvSYQfgSGGVB6IndcXSDw==
X-CSE-MsgGUID: wYLpIuQ7QWSVf738/Ti/5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="31772306"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="31772306"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 09:14:37 -0700
X-CSE-ConnectionGUID: rT5y1NMdTs2EDzChbX7i+Q==
X-CSE-MsgGUID: H0F+atmnTIOAf2GYbyjy8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="42581905"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 09:14:37 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 3/3] x86/resctrl: Replace open code cacheinfo search in rdtgroup_cbm_to_size()
Date: Wed,  5 Jun 2024 09:14:27 -0700
Message-ID: <20240605161427.312994-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240605161427.312994-1-tony.luck@intel.com>
References: <20240605161427.312994-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use get_cpu_cacheinfo_level() instead of open coded search.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 02f213f1c51c..cb68a121dabb 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1450,18 +1450,14 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 				  struct rdt_domain *d, unsigned long cbm)
 {
-	struct cpu_cacheinfo *ci;
 	unsigned int size = 0;
-	int num_b, i;
+	struct cacheinfo *ci;
+	int num_b;
 
 	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
-	ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
-	for (i = 0; i < ci->num_leaves; i++) {
-		if (ci->info_list[i].level == r->cache_level) {
-			size = ci->info_list[i].size / r->cache.cbm_len * num_b;
-			break;
-		}
-	}
+	ci = get_cpu_cacheinfo_level(cpumask_any(&d->cpu_mask), r->cache_level);
+	if (ci)
+		size = ci->size / r->cache.cbm_len * num_b;
 
 	return size;
 }
-- 
2.45.0


