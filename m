Return-Path: <linux-kernel+bounces-197457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC7B8D6AE5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 22:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744F21F293DB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EA71836EC;
	Fri, 31 May 2024 20:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gu59g7Wi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E413217FACA;
	Fri, 31 May 2024 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717187837; cv=none; b=ccVWDhSOsrkkL2PmOyueFSKoS63iHbc4KsBIedSCo2gpG0/lGavbpcP8Df1B/xnI0uVeowXCQSJj7359HZi4ovlHMkKIYJN5JLkGLllPGrAO9MC4aOE3EnXls1WOgV/mlSqyAmXD/qSkqlCaQZun6Ht5xABi+wNsVr6Fjhj6M50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717187837; c=relaxed/simple;
	bh=yaJboBMEPLKvR1jTeG+KSsAACemlTofNhMPhw7StcCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPrWIXNExnX16hdKOkaVYqMeJ9c1Zgi9TnfmjMGt8MV727ZeHlK43cWZRPLgjeZFMy/Wt8xbZXqsuryLosoZFLrnGk7ErHp5o0U6pT4TruSsX7aGnLmHZ6pzovN38/tmM4DI0yn4Qb1NcxwAE5Hllx1LRQnzARKtzC6oc6Lyvlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gu59g7Wi; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717187836; x=1748723836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yaJboBMEPLKvR1jTeG+KSsAACemlTofNhMPhw7StcCg=;
  b=Gu59g7Wiw9JuAvaQ8xn4ouRAiDw+4Nw/sIebxNY1HSLmZHIUa/kFpFfD
   dysf4hXyIkyhtY+bAKcoq75jTS9iSLA9NOtsw1CXRc6PlJ+kA0tjpFGUq
   NDTMys8Eadg+oGn8sAswIX2bgQHa+K9aLWAEkgphcZ87AkMPwhnXigqk/
   g4VgkocAsw238jRU2ykl7tNX5cBFUgG9HS7AASBSSTmrr7xn9TXqji/mD
   lKRbWpjSZmDDA7ZgqqzBYV/yNBfTQxc5/TR42VFL2rxjDdhwRnulsuNOj
   Q1vPeKMSxf8F+CoCDti7W6BIRGd5I9gaytSxwRQPlndxxrevo+n3eZOjZ
   w==;
X-CSE-ConnectionGUID: 9vqynYZRSGulGB4DcBzBCQ==
X-CSE-MsgGUID: Br1YLyOEQUytZYuw/jr1gQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13871845"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13871845"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 13:37:12 -0700
X-CSE-ConnectionGUID: IDdgpq3nQDahYbqebn4ILA==
X-CSE-MsgGUID: IA8i6JIZRVWuc17wmtug/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="36355390"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 13:37:13 -0700
From: Tony Luck <tony.luck@intel.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Cc: platform-driver-x86@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 07/11] platform/x86: intel-uncore-freq: Switch to new Intel CPU model defines
Date: Fri, 31 May 2024 13:37:03 -0700
Message-ID: <20240531203706.233365-8-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240531203706.233365-1-tony.luck@intel.com>
References: <20240531203706.233365-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 .../intel/uncore-frequency/uncore-frequency.c | 56 +++++++++----------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
index b89c0dda9e5d..b80feaf5828f 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -197,34 +197,34 @@ static struct notifier_block uncore_pm_nb = {
 };
 
 static const struct x86_cpu_id intel_uncore_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE_H, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(LUNARLAKE_M, NULL),
+	X86_MATCH_VFM(INTEL_BROADWELL_G,	NULL),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,	NULL),
+	X86_MATCH_VFM(INTEL_BROADWELL_D,	NULL),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,	NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE_X,	NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE_D,	NULL),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, NULL),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X, NULL),
+	X86_MATCH_VFM(INTEL_KABYLAKE, NULL),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_COMETLAKE, NULL),
+	X86_MATCH_VFM(INTEL_COMETLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_CANNONLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE, NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ROCKETLAKE, NULL),
+	X86_MATCH_VFM(INTEL_TIGERLAKE, NULL),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ALDERLAKE, NULL),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S, NULL),
+	X86_MATCH_VFM(INTEL_METEORLAKE, NULL),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ARROWLAKE, NULL),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_H, NULL),
+	X86_MATCH_VFM(INTEL_LUNARLAKE_M, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_uncore_cpu_ids);
-- 
2.45.0


