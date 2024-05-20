Return-Path: <linux-kernel+bounces-184271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A63C58CA4BC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7D41F21592
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2818C139585;
	Mon, 20 May 2024 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dbCfTi5x"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965F913D2AB
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245219; cv=none; b=m9apcgZ/s86Tf/ktlEiJ93BvdQVO47ShDtVuEpq3iHsMW3+HzgoSulKd2mScqqwCGt87S0HfGwjHAgqsv0e+RLljiGAGCyaZFQAeE45Ywa7k21dR59cTdU2k/104OH3cICDkearjbXAyqXKEJwQZArUwSKqv6VFMDdsQWHEcEYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245219; c=relaxed/simple;
	bh=+cW1FKmICz5yWt4FR2pNW4rOWKXVwnN1+017ENhmnxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=namvlSoMoHedZplNZ7V0mL7x+hvrc+XRhUOouWtqSAYdX6lAzZ7ooCNYa/e7Siwl+heOfpA0aS5/6kwb9Xa+5UO6/QFCMGV0e5vFGEvcokOVPc4dPwoUs7JOEjrFtXAGhBpSaNB+wod03QnywGL5L0/GkXsc7WnPKxw+q7rKkoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dbCfTi5x; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245218; x=1747781218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+cW1FKmICz5yWt4FR2pNW4rOWKXVwnN1+017ENhmnxI=;
  b=dbCfTi5x+aRoCRtxhzly2CBM2JMkViLSdiGbBR+mn7jcslAgqep7y3dB
   zZ+FmzrYJ40JJsVFDwMO+pzBcSjK3Sx0331hW1fyNWVoSKOuYwSo77PwR
   VSFT/t1hdZ3/Bx5WubhG6u/xj5dQ5OYX6YlCh+xQP3nlJtuZ6j8RyxWBY
   XzGw+ApBTH272MxE+GHF/5wFdBUyACLOp7zjiHyv9uJplWfzwUcaU7AA+
   0/iOxi9XZ7X50iXuxB2CtarOkKn90LaN7jiDkJco1v2NibvCuDavYRCJx
   7dg/nZQJohuMtSjG1t+QZrI4etNnJNjTCl+ypny7BOPXaqm+aT75/5x8Y
   g==;
X-CSE-ConnectionGUID: +EHjy9oXR5KQxNFy2HuPrA==
X-CSE-MsgGUID: fuyEmqOaSxCsTea6rhp5qg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12200001"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12200001"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:40 -0700
X-CSE-ConnectionGUID: mLst+c4SQ5mFAbBPlmyApw==
X-CSE-MsgGUID: y4s9iRi+REWfU/kmzxpuKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593522"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:40 -0700
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
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v6 45/49] powercap: intel_rapl: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:46:16 -0700
Message-ID: <20240520224620.9480-46-tony.luck@intel.com>
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
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 120 +++++++++++++--------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index aac0744011a3..3cffa6c79538 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1222,66 +1222,66 @@ static const struct rapl_defaults rapl_defaults_amd = {
 };
 
 static const struct x86_cpu_id rapl_ids[] __initconst = {
-	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&rapl_defaults_core),
-
-	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,		&rapl_defaults_core),
-
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,		&rapl_defaults_hsw_server),
-
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,		&rapl_defaults_hsw_server),
-
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&rapl_defaults_hsw_server),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&rapl_defaults_hsw_server),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&rapl_defaults_hsw_server),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
-	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&rapl_defaults_spr_server),
-	X86_MATCH_INTEL_FAM6_MODEL(LUNARLAKE_M,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE_H,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,		&rapl_defaults_core),
-
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&rapl_defaults_byt),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	&rapl_defaults_cht),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID,	&rapl_defaults_tng),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT_MID,	&rapl_defaults_ann),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&rapl_defaults_core),
-
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&rapl_defaults_hsw_server),
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE_X,	&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_IVYBRIDGE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_IVYBRIDGE_X,	&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_HASWELL,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_HASWELL_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_HASWELL_G,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_HASWELL_X,		&rapl_defaults_hsw_server),
+
+	X86_MATCH_VFM(INTEL_BROADWELL,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BROADWELL_G,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BROADWELL_D,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,	&rapl_defaults_hsw_server),
+
+	X86_MATCH_VFM(INTEL_SKYLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SKYLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,		&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_KABYLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_CANNONLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE_NNPI,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE_X,		&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_ICELAKE_D,		&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_COMETLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_COMETLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_TIGERLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ROCKETLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ALDERLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,        &rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_METEORLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&rapl_defaults_spr_server),
+	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ARROWLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_LAKEFIELD,		&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,	&rapl_defaults_byt),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	&rapl_defaults_cht),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, &rapl_defaults_tng),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT_MID,	&rapl_defaults_ann),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,	&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNL,	&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNM,	&rapl_defaults_hsw_server),
 
 	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd),
 	X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_amd),
-- 
2.45.0


