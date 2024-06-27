Return-Path: <linux-kernel+bounces-232968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317E791B09B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5EC4282105
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C4F1A2542;
	Thu, 27 Jun 2024 20:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MM0b9fXl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8456D1A0723
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520755; cv=none; b=Tn5PI3nDoLdMNrj1HzPsYMsOBD86Nsn9IpFZ7pWJk3HgeN/GlcW6Iq8X+8+A/0xpeNcCbZaEkkFeeA/sGPOSzIdAEj73VM5WkLKOAMmWQ6wuPC2loRrByR9X0LA8yapRye3anB2MQSLpoKSPbGItuAhuY4Bsn+nT5sqFHZwXDKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520755; c=relaxed/simple;
	bh=UvIfSDsXNSkpE8HdTCsK3woWdj4Uetp4PIewuXeA0AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jY2xEM6kfOJ3ykKPdaK89TRzKFPkt5UqyYyQ0E/8zgQIzddgcG2p5MEYPAAlVsAU5B+CKsubMmmqXXdtJx9dz4M+40opRMrBoNnb1dKOeu5NHw7zK3BLJpvT5Zf0/dH6y1CClX6ECWur6pIZuazPX/vLoPyppZZFC5XiwuEeSiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MM0b9fXl; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719520754; x=1751056754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UvIfSDsXNSkpE8HdTCsK3woWdj4Uetp4PIewuXeA0AQ=;
  b=MM0b9fXl4Wyy03UJ9tApXZ/4vdH8t/IxC8cBz2c4nRE8LYTKw6eYo6B5
   W3qEmmzGaAhVT2korvoxT//775lqFpWx0RuTIlwdO9+x0aRD+1CKyDzxI
   EyCp9wm4GnhHtZ4yVIN33tcvBgTpZE6oMMtojElzL1oS2xQU/fs0+iHHS
   Iq1PFkDOoJ6Gs1Gwfsp4LhDLeAlds5twOyJ0CwCERaWpMEVC7olY+WfCX
   5dAdoPuuO9A6dgkvOAW5xwb/O8OIiayqLBszgdHrbY/fOFkoucWL8jczb
   STWqmA5RjJwU1yB8OjeJTpL0uFWQfnOro5M/7YfZ7QZO6ytksRK4R9lzQ
   g==;
X-CSE-ConnectionGUID: IWBcReTtRRuc7UNAxX5lNQ==
X-CSE-MsgGUID: ViGsxMLPQLyFv72kAcNKJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16809784"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="16809784"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:39:09 -0700
X-CSE-ConnectionGUID: 76ui0RJpR62Z8Ju+ASi7UQ==
X-CSE-MsgGUID: iELuY1vsTc+35ynjI3UCbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="82052897"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:39:08 -0700
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
Subject: [PATCH v22 07/18] x86/resctrl: Block use of mba_MBps mount option on Sub-NUMA Cluster (SNC) systems
Date: Thu, 27 Jun 2024 13:38:45 -0700
Message-ID: <20240627203856.66628-8-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627203856.66628-1-tony.luck@intel.com>
References: <20240627203856.66628-1-tony.luck@intel.com>
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

Improve user diagnostics by adding invalfc() message when mba_MBps
is not supported.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index eb3bbfa96d5a..d3b0fa958266 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2335,14 +2335,18 @@ static void mba_sc_domain_destroy(struct rdt_resource *r,
 
 /*
  * MBA software controller is supported only if
- * MBM is supported and MBA is in linear scale.
+ * MBM is supported and MBA is in linear scale,
+ * and the MBM monitor scope is the same as MBA
+ * control scope.
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
@@ -2750,6 +2754,7 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
 	struct fs_parse_result result;
+	const char *msg;
 	int opt;
 
 	opt = fs_parse(fc, rdt_fs_parameters, param, &result);
@@ -2764,8 +2769,9 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ctx->enable_cdpl2 = true;
 		return 0;
 	case Opt_mba_mbps:
+		msg = "mba_MBps requires local MBM and linear scale MBA at L3 scope";
 		if (!supports_mba_mbps())
-			return -EINVAL;
+			return invalfc(fc, msg);
 		ctx->enable_mba_mbps = true;
 		return 0;
 	case Opt_debug:
-- 
2.45.2


