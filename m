Return-Path: <linux-kernel+bounces-193162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B8E8D27E4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB632853D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC8213FD96;
	Tue, 28 May 2024 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6gtNYeL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4406413E8B6
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716934823; cv=none; b=f+0yEJi1S4j2DTjYACoOsbA3MiTDAqVD66xwjPB2apMEEPsq5hvWSp3qsw3nWFWPyN2PxRD4Wq5HF3c1+TeLt9cDvUwjRRgCkm+tsp19D1Q2li8nwE4PVO5+5PQx1FNWW5e8h+Urm/PLpF8EkWT1DvqtPqNJChA2U1ZGt74I534=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716934823; c=relaxed/simple;
	bh=Z98ziZarYICAVphRTOHb1SbLcVID2nk5s6aKEDY0vks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+vsGwd97dYOl8O7x3/rupWsyt9WiliGCH6nGPbxpWEQMxqUTZ6N8WM0PzWy+EX7buDuf3bT2e7TFT8sk6gInZDA6Z9Wr408PEeeMxTW40nBAYO3JjCcAiBd4Bzv0X2EjtflZ1wyARRFbSs80XdvIAJqPcs3FXwQqpYzNAlcFTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6gtNYeL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716934822; x=1748470822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z98ziZarYICAVphRTOHb1SbLcVID2nk5s6aKEDY0vks=;
  b=e6gtNYeLSATN+zOAcgH1ioDJgqUgMx0MWgjAQJ73+r1BnHnuVVPQ5wiJ
   wbyuz6txvRJLAb+BsrJF90SgogBQVzAKgD49udpIaQERSbjv5rSkneDM/
   iMkXJGc4rgDhQT2A4q6ArMWqKBLHlG9jIAcR4oQetSjGkX014eCJFYjr1
   pabZxmuk3RLbY3UoapZJX5ocf+NXHztYz+ud0KhmuVzTPeFHz2YiWi6+V
   FGr06mY4z6T6qsgJP9IuKyUcTmIn20vcO7iwxOzoCR0yEkC3Odg33NRBK
   /V2meoJcDtPxAyY57nRPdVulBUORqsX6ymElZC+iNvon/tf9nXtq1BZnY
   w==;
X-CSE-ConnectionGUID: zTuZ0iAlTmyW4NXVgMPnrA==
X-CSE-MsgGUID: Syz37zY0Q362/bjK1Sd/OA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="30812182"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="30812182"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:20:17 -0700
X-CSE-ConnectionGUID: ZDVryoqgQO27/6KJWYLq+w==
X-CSE-MsgGUID: TSd0MCchTYKKPyPS5fNjlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="40090731"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:20:16 -0700
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
Subject: [PATCH v19 07/20] x86/resctrl: Block use of mba_MBps mount option on Sub-NUMA Cluster (SNC) systems
Date: Tue, 28 May 2024 15:19:52 -0700
Message-ID: <20240528222006.58283-8-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240528222006.58283-1-tony.luck@intel.com>
References: <20240528222006.58283-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When SNC is enabled there is a mismatch between the MBA control function
which operates at L3 cache scope and the MBM monitor functions which
measure memory bandwidth on each SNC node.

Block use of the mba_MBps when scopes for MBA/MBM do not match.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index cc31ede1a1e7..1cc4794d5a2e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2343,10 +2343,12 @@ static void mba_sc_domain_destroy(struct rdt_resource *r,
  */
 static bool supports_mba_mbps(void)
 {
+	struct rdt_resource *rmbm = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
 
 	return (is_mbm_local_enabled() &&
-		r->alloc_capable && is_mba_linear());
+		r->alloc_capable && is_mba_linear() &&
+		r->ctrl_scope == rmbm->mon_scope);
 }
 
 /*
-- 
2.45.0


