Return-Path: <linux-kernel+bounces-184228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 373548CA491
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1D2281F84
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3616F487B0;
	Mon, 20 May 2024 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bh+JK/xw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE389475
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245197; cv=none; b=ny1nu1R4I5NSFiweE+JPqWOmW1qsv4jo/KuB749EflYUHeQqlaUQeQ4KkWtEPTYMUoGBZreoYKuREqu4EuWnnZZqw+ueYcN6F3RgIaJaRU0SGV9l/llp+VQute+f+VsVSwsbS7ZpCDxgO+twvlzmge7qG6UzHZV+jH48OJxqcq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245197; c=relaxed/simple;
	bh=kIehCYoVRHdNFqIBmNYxgDHHhCKlxbzEjpk5eAB0vUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHnn0Yi8yxqu4HRkJQAIKWqfbh3QkhtYIfrgBw/GvdmUx/rO/cnlGH6SuXx4oh73UXOimK4hsf9oV6YKjso0kM5eay1Up6TcdbSIKvFDN+3ul/Hk2rS9M0Timi8qPGxWTpR3qn3rYeCfEorwc1VtKKNFDhY2YawmMGDiZWhiIeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bh+JK/xw; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245196; x=1747781196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kIehCYoVRHdNFqIBmNYxgDHHhCKlxbzEjpk5eAB0vUE=;
  b=bh+JK/xw3fJLQlk7cDEmaXIxGOvk8VrLdE//aLRy4lszdqvfwRyIecKk
   jUnM4Xx/iKmOK1sk74QxOVAkMLOVPfbssqcFxtdjGZbm6pZZdAzzcUCpU
   BClpfCF2vq85aiICeyiXPDqn1kj9OMWNemp+9h4+ZxX+cK3HvZDYhBIIt
   cNtkaleQg2FCixRxnYbyzB/bguwoskYwdurp/wwK8yfyQJ17OQm/KeiFu
   WW2Iz2JHmFwerbWow/mmXEZ5IDWczvj1tn7Og3rDyuHoN9ND7Tzpx89Mo
   IQh+VphtNoUhc3uacMZtnw/6DfVX13jGfbzbNX/a/SaBkY0YHERP6Ofi8
   g==;
X-CSE-ConnectionGUID: STPuWpKxR2u18Q/UTy+Mjg==
X-CSE-MsgGUID: x62QIYI8Q+uUlVhYPz1vrA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199506"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199506"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:35 -0700
X-CSE-ConnectionGUID: 7zCOw3olTjmXtHS6hd08jg==
X-CSE-MsgGUID: Uc5pQ15xRMCSMMfd0vta5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593382"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:35 -0700
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
	patches@lists.linux.dev
Subject: [PATCH v6 01/49] crypto: x86/aes-xts - Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:45:32 -0700
Message-ID: <20240520224620.9480-2-tony.luck@intel.com>
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
---
 arch/x86/crypto/aesni-intel_glue.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 5b25d2a58aeb..ef031655b2d3 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -1223,14 +1223,14 @@ DEFINE_XTS_ALG(vaes_avx10_512, "xts-aes-vaes-avx10_512", 800);
  * implementation with ymm registers (256-bit vectors) will be used instead.
  */
 static const struct x86_cpu_id zmm_exclusion_list[] = {
-	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_SKYLAKE_X },
-	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_ICELAKE_X },
-	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_ICELAKE_D },
-	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_ICELAKE },
-	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_ICELAKE_L },
-	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_ICELAKE_NNPI },
-	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_TIGERLAKE_L },
-	{ .vendor = X86_VENDOR_INTEL, .family = 6, .model = INTEL_FAM6_TIGERLAKE },
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,		0),
+	X86_MATCH_VFM(INTEL_ICELAKE_X,		0),
+	X86_MATCH_VFM(INTEL_ICELAKE_D,		0),
+	X86_MATCH_VFM(INTEL_ICELAKE,		0),
+	X86_MATCH_VFM(INTEL_ICELAKE_L,		0),
+	X86_MATCH_VFM(INTEL_ICELAKE_NNPI,	0),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L,	0),
+	X86_MATCH_VFM(INTEL_TIGERLAKE,		0),
 	/* Allow Rocket Lake and later, and Sapphire Rapids and later. */
 	/* Also allow AMD CPUs (starting with Zen 4, the first with AVX-512). */
 	{},
-- 
2.45.0


