Return-Path: <linux-kernel+bounces-234616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB33C91C8AA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1981C22788
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA89824BB;
	Fri, 28 Jun 2024 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUVEV8aZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442588172A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611792; cv=none; b=AIBY84h4uvEIrz++s1oqNNTNOePZWNS2Aj6NOipWDP6L0rXhtc1/XojweK1naY+OBt0pemS10mP+WjZmM9yWzfRMCBu1KXyigd2AoPWvX9JFcI1yPdD0lNB4xHvK4CRUPT00uBnw9uauEaEOKKUBsDPK8q7iSFfYnoQYALHxq2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611792; c=relaxed/simple;
	bh=UvIfSDsXNSkpE8HdTCsK3woWdj4Uetp4PIewuXeA0AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZRKEP2Qb8AvwBOSC46mJybHp31ZlNxX22WaAXZTt5G/51sHa3Wn8rpwGo/h5ild2n9GKmILc8vcCTYqZirWh3uI78QTEeRZyDe9gvjxiW5YhaG8zuGlCMaSDIHfprX+HZ5kRVFHs3iMZfQyyqJBgMOTm37Kl2ef6g6dBHt0C7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUVEV8aZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719611791; x=1751147791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UvIfSDsXNSkpE8HdTCsK3woWdj4Uetp4PIewuXeA0AQ=;
  b=kUVEV8aZPQ6eEj4lYZOHDmHV5GjApg4tJfKwODSMShjOONqCYR8ObEVJ
   Kfd0KpchRNcILlLiBAHDAMr1F8U9YM8+ZN4MS7zFgvyafmoFpxG5huY3v
   /RDzrPH3wX63bL+0krvpGkquFQuxg0uEVMSF1H9P/SyywTOB7AmsmIBXX
   t8hTHyXiGloAYCRY7fpSxAyY6R8bwajAUYOPR8cWd5i/fOLw7daJ1aRzd
   CF507NKBvxC0kdovqaUK20LmNnJUWyUXonXoFXwze6oZ6LykdSYBohRXn
   Olc3GlCr9nho9lyUBtirSLZyS3I8WQ4rS1IKVY1wSvpV71Hjp8F8/CE8x
   Q==;
X-CSE-ConnectionGUID: xe4yJi7ZS3Gu6juW1rdDtQ==
X-CSE-MsgGUID: xeM4grvRSSW1symlY+fKeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16762572"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16762572"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:56:27 -0700
X-CSE-ConnectionGUID: cgduWIhdTsOVkAwsQjrhRw==
X-CSE-MsgGUID: saQPrqvxSHqNARJQh718lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="68065654"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:56:27 -0700
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
Subject: [PATCH v23 07/19] x86/resctrl: Block use of mba_MBps mount option on Sub-NUMA Cluster (SNC) systems
Date: Fri, 28 Jun 2024 14:56:07 -0700
Message-ID: <20240628215619.76401-8-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628215619.76401-1-tony.luck@intel.com>
References: <20240628215619.76401-1-tony.luck@intel.com>
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


