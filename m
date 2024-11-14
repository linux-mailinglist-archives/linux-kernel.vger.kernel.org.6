Return-Path: <linux-kernel+bounces-408473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5A29C7F3B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B53DB2279F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4712B9B9;
	Thu, 14 Nov 2024 00:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gwl+VmjV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FC911CA9;
	Thu, 14 Nov 2024 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731543444; cv=none; b=OSNA8H3TUhN1ny0UVnBRpbUr5gw/EjHnI8iz4A2FHTRNS8Wwsczfe3PdgL789x4j6T3vxg6Kdoa52p0rqK1tGmpuNBOpdDB9JiqYevi7Dp7VUYgTw65zRsJjSWOFHL4n2RUjOZ/8TfFUEMDj/LJUjlEO1WIfVrjujy/GdEni/rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731543444; c=relaxed/simple;
	bh=ZkSSM2q5MnFvLgg48mZuk8LBjeJj2H/nYXDhejRCDUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gY06mw9SGMlPK4eadEamxMd7KyhQPPDAjPb3zSZeBq34I0lYc5QSnSnfKr4ejBEcV9lGXKEPXOnSNwJoa/PDZmK2Bu/JamFCXuZ3kATGadW7dw/14bToLU4p4UTXCIyEhxkAl0N95nOIm6c0gCmEBgE49IrchHwux5ej4gGuefE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gwl+VmjV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731543443; x=1763079443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZkSSM2q5MnFvLgg48mZuk8LBjeJj2H/nYXDhejRCDUU=;
  b=Gwl+VmjVvKMXyD9Kk0O+r5c0rLmzoYEbY2tNiXyudTjqyWs83pJOR/Jo
   MssNk2Xr8g1BynAI79fy/2HDOO8JOuDJN79VZsaa7hYU+5AlxuWlwO/+p
   +SBv4Y/hpd/Y0tuF1HdqGkJhnbjj4r7FfH243wOrfdjL7w7uBalShJQuW
   jFkRM6J0+DEFkhjaiRO+ujGrlYTlW99ptGg4ZIpvoQaaH0WHHNZYXuivm
   gs29eI9KIaM0phGJlEGovdvPvBMUjumNCBJV/oXF9qOWKFTEa8McbeGXP
   +rZYQK51p+vBlDnKRbVn4+37TPlRRn7WHHQ7YuWiKEXYrfMlGU31lTD/v
   w==;
X-CSE-ConnectionGUID: LfqOu5SpSXquO7y2FFZ/Gw==
X-CSE-MsgGUID: mSi8mPdoSnKHMtLl+WAWHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="30869503"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="30869503"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 16:17:18 -0800
X-CSE-ConnectionGUID: NCDS9fs3TSWPUjm/p/Xn3w==
X-CSE-MsgGUID: LppNAjtBRamNw5SHSe9vWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="92081163"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 16:17:18 -0800
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
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
Subject: [PATCH v9 5/9] x86/resctrl: Relax checks for mba_MBps mount option
Date: Wed, 13 Nov 2024 16:17:07 -0800
Message-ID: <20241114001712.80315-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114001712.80315-1-tony.luck@intel.com>
References: <20241114001712.80315-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This option may be used with any memory bandwidth monitoring event.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index a8022bddf9f7..3a89516e6f56 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2334,7 +2334,7 @@ static bool supports_mba_mbps(void)
 	struct rdt_resource *rmbm = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
 
-	return (is_mbm_local_enabled() &&
+	return (is_mbm_enabled() &&
 		r->alloc_capable && is_mba_linear() &&
 		r->ctrl_scope == rmbm->mon_scope);
 }
@@ -2759,7 +2759,7 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ctx->enable_cdpl2 = true;
 		return 0;
 	case Opt_mba_mbps:
-		msg = "mba_MBps requires local MBM and linear scale MBA at L3 scope";
+		msg = "mba_MBps requires MBM and linear scale MBA at L3 scope";
 		if (!supports_mba_mbps())
 			return invalfc(fc, msg);
 		ctx->enable_mba_mbps = true;
-- 
2.47.0


