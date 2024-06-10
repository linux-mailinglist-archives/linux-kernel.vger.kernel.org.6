Return-Path: <linux-kernel+bounces-208752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294BD9028CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB16FB22BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461E014EC73;
	Mon, 10 Jun 2024 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cb3fPNWW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876BE1514F8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718044549; cv=none; b=B7hceZVLNWYQU35kkOJaCTMbveMxAQm8q4xsjPRC0BYaPPGpInyvZJz9vSjmuVpNynzECvKq4zBApvaIBAqeyEARl6qsfO03k0ticuwsw+x6f9ZUgUuXCDFDiIXC9hGaHzhVDiuYTAeYJ+CP14FgaURVgWKsmux3MZa3bCt1uCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718044549; c=relaxed/simple;
	bh=6YeS89kWmUZc3iuyIsBWqSSCqJoUH3fqSuDZttW8mlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGWY4D3SEDLp17bgS7aAcSHAuSZF1g2i7g3I3qxMBkFDb4y82ghP+I9JoEZbXUM6ZlRq0+vbTApK/xWiSoRcbAInwCcw5MzKv8EA/Rzt9Mu0/b1W4BcsE8j6L06lX5gnS4PGJfE+h7M0xMWSI7vT/eiJN4hRXrJbtxO9SuroNig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cb3fPNWW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718044547; x=1749580547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6YeS89kWmUZc3iuyIsBWqSSCqJoUH3fqSuDZttW8mlk=;
  b=cb3fPNWW9P/5yqsqGUELlpkTl64Bvao1k8Zu27S4RHRlmbvsU+KyXTL8
   w5Kv1G6FekoRfvBgSzoXBuA6X0E3Ocqds97Bwhi65jC9/lTfVS2c0Y+QK
   NvCenDruyK6Gm4ubMyXSZeEfiJlOqB7kFuQO801HGR4oFXgfcoIS9Lg2W
   uXvWI9Qqejn733PEi2PmJOo8t9mTIniPgFZQD+YgBGn0zi+SEuQbfEFBz
   yDTSbfMXNYjwhai2NyxIKrRb2i53ZJ0NQa9npUoSYkjv/cd/tQHgV/2P1
   NfbZBCuDNjaxseBWQhmzqumUfRMix/n7gfbOKy3VgIlY/HrTpV/qeDjbd
   g==;
X-CSE-ConnectionGUID: UT++/NtBRc2LW36+1/zkTw==
X-CSE-MsgGUID: HKmu1qKkTlWGCTuhwnS0cA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="12004820"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="12004820"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 11:35:38 -0700
X-CSE-ConnectionGUID: 7FEW1etJRxacCajYujSUPQ==
X-CSE-MsgGUID: 8WaP+3JfRVGOsa6rWdd49w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43576569"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 11:35:38 -0700
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
Subject: [PATCH v20 07/18] x86/resctrl: Block use of mba_MBps mount option on Sub-NUMA Cluster (SNC) systems
Date: Mon, 10 Jun 2024 11:35:17 -0700
Message-ID: <20240610183528.349198-8-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240610183528.349198-1-tony.luck@intel.com>
References: <20240610183528.349198-1-tony.luck@intel.com>
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
index eb3bbfa96d5a..a0a43dbe011b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2339,10 +2339,12 @@ static void mba_sc_domain_destroy(struct rdt_resource *r,
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


