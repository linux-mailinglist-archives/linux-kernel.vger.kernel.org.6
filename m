Return-Path: <linux-kernel+bounces-184253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0B58CA4AA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81E54B21680
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3E313C813;
	Mon, 20 May 2024 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1Vu3iAQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590C013BAD5
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245210; cv=none; b=oACMQwThoGLJl6JwfWTkQ/VGuYVmkFA4HWU9EQpjjowBCBdzFYFGlpv/p38LcNsfhCCQ37skD7gWe6a6zbRHCxqd3eb5sEUugdlA/hVOIkcrsy6Mphj1d0pp4Yue3y2zkpSbfP+jgUJ4H2APEHC3jpC99DY57SYNnidXVz7Aqa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245210; c=relaxed/simple;
	bh=OLHlnCNuMj+sFu5JTH/uGMhauld2ZygckWPVZ85rjKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgNlmBKK8nriLocSVZwgDVXTmF5g1cxhTTBueP6NbqiTQT7MwIS6FuhGR6E2feoRjtxqH1qeI+w4Od3Hafvhor7CorjHC5oCS3Z+ZFYteirDxSsiexZxdBvXlr+wrfkAX6QGGS2yPNrWvKDP/eXEvxEZyD0byXGFBJSAjOrtGH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j1Vu3iAQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245208; x=1747781208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OLHlnCNuMj+sFu5JTH/uGMhauld2ZygckWPVZ85rjKM=;
  b=j1Vu3iAQc8RWSm0TQyLtbcjnoIBIZShOD+9qPkKG3uU5NZv06DmgjS55
   TtWfg6DfcMYJOR9QHEuwfz0q7EzF70bqlFklErCT7C8qZRoYgLQJE5Hk+
   +yuEeaHKwr2iqJh6X9AlEEsqFPdcoDqY2H/a8y8w1Cw3Yo4gxUukY4cpN
   3ENkYPo7CYTXuC6/vYlwk91S/YQhggBBEA/jewIDVKGSBlOKEebSgl+hV
   j2C2EKWUL4quT3nP+l8dDMhwScowVq73cuhHIzb9TJKmQmPgqHxpnaG+M
   4ZW7scu6fSb5xWPInSuWvTQ8QkLPBfc6vKEZDrgYiuhUCfbHHEiriuga4
   w==;
X-CSE-ConnectionGUID: yI3nvE3IRWCNJfUTu3JCMg==
X-CSE-MsgGUID: vLhvG3TFQGKlhMnS/zSqyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199778"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199778"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:38 -0700
X-CSE-ConnectionGUID: TMjeR8kWS9uE0deKSyx3fQ==
X-CSE-MsgGUID: iL7FbAFeQcqzh84XLr4/ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593457"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:38 -0700
From: Tony Luck <tony.luck@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Tony Luck <tony.luck@intel.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Thomas Renninger <trenn@suse.de>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v6 25/49] platform/x86/intel/pmc: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:45:56 -0700
Message-ID: <20240520224620.9480-26-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240520224620.9480-1-tony.luck@intel.com>
References: <20240520224620.9480-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel/pmc/core.c | 46 +++++++++++++--------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 2ad2f8753e5d..65eb09c7af6a 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1293,29 +1293,29 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 }
 
 static const struct x86_cpu_id intel_pmc_core_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		spt_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		spt_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		spt_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		spt_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	cnp_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		icl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,	icl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		cnp_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		cnp_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		tgl_l_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		tgl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	tgl_l_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	icl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		tgl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		tgl_l_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	tgl_l_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		adl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        tgl_l_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		adl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	adl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	mtl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE,		arl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(LUNARLAKE_M,         lnl_core_init),
+	X86_MATCH_VFM(INTEL_SKYLAKE_L,		spt_core_init),
+	X86_MATCH_VFM(INTEL_SKYLAKE,		spt_core_init),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L,		spt_core_init),
+	X86_MATCH_VFM(INTEL_KABYLAKE,		spt_core_init),
+	X86_MATCH_VFM(INTEL_CANNONLAKE_L,	cnp_core_init),
+	X86_MATCH_VFM(INTEL_ICELAKE_L,		icl_core_init),
+	X86_MATCH_VFM(INTEL_ICELAKE_NNPI,	icl_core_init),
+	X86_MATCH_VFM(INTEL_COMETLAKE,		cnp_core_init),
+	X86_MATCH_VFM(INTEL_COMETLAKE_L,	cnp_core_init),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L,	tgl_l_core_init),
+	X86_MATCH_VFM(INTEL_TIGERLAKE,		tgl_core_init),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT,	tgl_l_core_init),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,	icl_core_init),
+	X86_MATCH_VFM(INTEL_ROCKETLAKE,		tgl_core_init),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,	tgl_l_core_init),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	tgl_l_core_init),
+	X86_MATCH_VFM(INTEL_ALDERLAKE,		adl_core_init),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,	tgl_l_core_init),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE,		adl_core_init),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	adl_core_init),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L,	mtl_core_init),
+	X86_MATCH_VFM(INTEL_ARROWLAKE,		arl_core_init),
+	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	lnl_core_init),
 	{}
 };
 
-- 
2.45.0


