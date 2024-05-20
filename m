Return-Path: <linux-kernel+bounces-184248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E148CA4A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB30281ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48578136E2D;
	Mon, 20 May 2024 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Un9Hr590"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1042D13B2A5
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245208; cv=none; b=nTyVXNKeGfM678i7nbH4x8LeeLDPLDXOSbcO1V6J6ARGa15ATA+rUOSK0xLZy0SmMXUTmm8SeqgSdFfv4WItCfgt0OXjPSHHRO/Kqd6LjOE5jwKd9+wCLoSmj92Iq6MHWKw8HowGceW+TrmKA7IFkV1FTMtFL26Uul12y19rx+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245208; c=relaxed/simple;
	bh=32OovBnI96Pt8u6y2/ExOjFMxT/hkeFmHDurbkDaicI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIlovYJxvHOUSaJBSfls9dUKrW1J4JbzQy3GbrameGshjxEFNRaeoRjVutncG4Nky6Z9njP3f0Eb0DH2DHw8z0dxy2TTBWcmZUUekXWzx33U+t++CA65tcwEMzfVmklUUHBkU7g8QLyAVO/cOTb02s8Hn/7GKCuPgvlncAXbWrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Un9Hr590; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245206; x=1747781206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=32OovBnI96Pt8u6y2/ExOjFMxT/hkeFmHDurbkDaicI=;
  b=Un9Hr590o3gGq1vVei35p7QT2Yam0/aNZjR6AFw7PlvrY/XGaC3fOCjF
   VlWsW4ofTIrSQDMhvFPtTQNH58C8JuJvnRGDgTSzIGFqVXJ4R5zOzpDzk
   6rh5dkGpi/TFJcyyNFbQMEmA0my91eQVljFCfm4RH5p1kF69ojfHMHjqh
   BSKyk7fVkUSP771v9CULxf2xPKjxjigB7RnSb+3tE5RmUmWkBSyKxhphU
   8oGw1S1jarQ8NZYEHQSxb+33jcR/Mty32Gsbmv9E5LdUn+O1U32QL+d/X
   aDcsIiGuByOeGDni7e9UKT3kWDXCahz/be5av9hfhAOvsamytXC052rOB
   w==;
X-CSE-ConnectionGUID: j/KaexiDQ3yhxFJX/C2FWA==
X-CSE-MsgGUID: 4qRttgz0TsyY37YCi54ygA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199712"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199712"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:37 -0700
X-CSE-ConnectionGUID: /gZXDJriTOiKIdQcRhTJyw==
X-CSE-MsgGUID: 9XGSISLaS2Ku671oT+x9SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593439"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:37 -0700
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
Subject: [PATCH v6 19/49] platform/x86: intel_ips: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:45:50 -0700
Message-ID: <20240520224620.9480-20-tony.luck@intel.com>
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
 drivers/platform/x86/intel_ips.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
index ba38649cc142..d95f686e0515 100644
--- a/drivers/platform/x86/intel_ips.c
+++ b/drivers/platform/x86/intel_ips.c
@@ -62,6 +62,7 @@
 #include <drm/i915_drm.h>
 #include <asm/msr.h>
 #include <asm/processor.h>
+#include <asm/cpu_device_id.h>
 #include "intel_ips.h"
 
 #include <linux/io-64-nonatomic-lo-hi.h>
@@ -1284,7 +1285,7 @@ static struct ips_mcp_limits *ips_detect_cpu(struct ips_driver *ips)
 	struct ips_mcp_limits *limits = NULL;
 	u16 tdp;
 
-	if (!(boot_cpu_data.x86 == 6 && boot_cpu_data.x86_model == 37)) {
+	if (!(boot_cpu_data.x86_vfm == INTEL_WESTMERE)) {
 		dev_info(ips->dev, "Non-IPS CPU detected.\n");
 		return NULL;
 	}
-- 
2.45.0


