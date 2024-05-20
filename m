Return-Path: <linux-kernel+bounces-184259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D256D8CA4B0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55AE7B219DC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FC413C91F;
	Mon, 20 May 2024 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIuNz72K"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BEC13C801
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245213; cv=none; b=HCaLQmmFdsT9fKM5UPNd7bQTjJ0juGwoVBRFASWLl7W/M1gYQjCr2d6RhPFDcoQErbpZuUbyqPpgD+OnA2sb6jNXDCFf6TsTouNPaqr4+C7LKy6IWwjcLZkAKGa4M0j5Yjf3ETyOLHYI7fCS3yaKKEVs7fG+1b5Cta7hm85y2JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245213; c=relaxed/simple;
	bh=dSW16Z5owqXk0diJ8oqVw/YYkOHbNprsGlWIpUTivak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dpu8Orq/FkiXXwisSimNJfkCARnJnaduh9cOCqdS45GdlsDWLrY7Py2S84Dp/cMe+6VBBTHr58QlHsBAjwYTCpZB8jGMFbysXbmUBl+DUc68bxRnaQ/oVsZAJuiaGm1Q+TmB7WfEE6NOsZ3cR4NGRgAiXfD8GYsUN7egb8JQ+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIuNz72K; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245211; x=1747781211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dSW16Z5owqXk0diJ8oqVw/YYkOHbNprsGlWIpUTivak=;
  b=GIuNz72K2RcCm7Kc6Au2PBfql2nGe4o8nO98kKOfXBNlSq1prHQypbit
   pXQ7c/nqQiS9mMx/zfNQPi/OxKvYRnmwaCUr1sZowoTPZ0hwoimAnaiuh
   5arzch3P+bAYlsAarwExufc66bQzuwXK5+KFMJVW2x6N0DsmokCvHb/UY
   1tKDMhHhsCZWAH5NwfJ9gzlgz73GnKucJkta6Hl8Y9Hx26T6eyN/T03bs
   RFamzH5dPr/7UAuiHFiCWYPE6UoMH9LCKi7aQZQEkpoWzkbgEWj2CQsWR
   hxo6VC1BIJF44RADAMuSyX2aRTpWJijXNeGxKWJxBAVvqfDDP0ocppMll
   A==;
X-CSE-ConnectionGUID: pOLs1EyFRBumNLNNMWLbrg==
X-CSE-MsgGUID: 5TBdsGz9SxaPL1hXgHDf1A==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199836"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199836"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:39 -0700
X-CSE-ConnectionGUID: 10UPfhpOSu27kDmEtACdaw==
X-CSE-MsgGUID: 15/3bRvIQzO/o2blYupKog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593473"
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
	patches@lists.linux.dev
Subject: [PATCH v6 30/49] x86/virt/tdx: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:46:01 -0700
Message-ID: <20240520224620.9480-31-tony.luck@intel.com>
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
 arch/x86/virt/vmx/tdx/tdx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 49a1c6890b55..4e2b2e2ac9f9 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -33,7 +33,7 @@
 #include <asm/msr.h>
 #include <asm/cpufeature.h>
 #include <asm/tdx.h>
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/processor.h>
 #include <asm/mce.h>
 #include "tdx.h"
@@ -1426,9 +1426,9 @@ static void __init check_tdx_erratum(void)
 	 * private memory poisons that memory, and a subsequent read of
 	 * that memory triggers #MC.
 	 */
-	switch (boot_cpu_data.x86_model) {
-	case INTEL_FAM6_SAPPHIRERAPIDS_X:
-	case INTEL_FAM6_EMERALDRAPIDS_X:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_SAPPHIRERAPIDS_X:
+	case INTEL_EMERALDRAPIDS_X:
 		setup_force_cpu_bug(X86_BUG_TDX_PW_MCE);
 	}
 }
-- 
2.45.0


