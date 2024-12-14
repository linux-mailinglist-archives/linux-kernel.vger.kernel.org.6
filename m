Return-Path: <linux-kernel+bounces-446084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4E99F1FA2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 16:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E75216742E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 15:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17951A8F78;
	Sat, 14 Dec 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GY/CHKNd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40C51A8F75
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734189424; cv=none; b=hl17+Yv4aw6iQOOnTmBSbPASHIJ/SdahDflJpKT+UWhSqRcQdb7tFviH+0rjvDzSPqd2lrYoMWY2r3iQIsWTmGDLpGIajEzbgPGhwyq49OIEoZ6ydenRGpnMWbjKaIq+GS/gfHXlPgD1klKCob0k27gcfvtDZ/FPml6SCktiK5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734189424; c=relaxed/simple;
	bh=JxMZELjVGKGPt6XOV2bTuB1nEjDz6560szhLElfrufc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=noRAQ41PRETKAhDzF9Q3QeJ/vbKhBT1cR0IDZbmYF+BFKmmvy/2o0b/zccG0nJKbdWnWM2xA9KkDZrsidel8/s5DiJ0i3/GIjxprCEwj0ZHAy8Xn85YFd0PAcbWR8b4uZ90yLndFPmWvDzURcFfPQczqbvjvVI1jjfO44JJyU3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GY/CHKNd; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734189423; x=1765725423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JxMZELjVGKGPt6XOV2bTuB1nEjDz6560szhLElfrufc=;
  b=GY/CHKNdoFlsG+zs+QPXFhqyC66zSBRPU+ovIPFuWy0QUMB8cGZHVxpK
   XUFhcRMUUcXZbPBiHgMCiNS5ywUKsHXHsvvF+Zc8DTqp8wRvk1XlmT2VH
   BU8xs+XmOOm2TBOb2kaqTovumuhGpJCfStSaKpwdqkFljO5zpOh0ii3/+
   uHC6hj7jOPOgNd5eMj+yRJWWW70N0K3psWPDV0uKGPPkIhb8Ao4UqpgPQ
   6OdWUJFFeapuEguHXXVGUlrbWHMH+yWW6vdAp1YtJkXpnWs5OhhkoNf78
   Z1i7Y67j56EpmruBSEPMVST8pRXwJsji/+jA/WwQvcgJBuZBDNbiNthdD
   A==;
X-CSE-ConnectionGUID: JWzYpJ2VS2CZ1Cpdr9b6eA==
X-CSE-MsgGUID: 2dIlWEGhTQyjtxGAa0wavg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45109944"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45109944"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 07:17:02 -0800
X-CSE-ConnectionGUID: OpPYWUKgQKCntZovrZyk7g==
X-CSE-MsgGUID: DO6Oq3FaTbq2UxiApXR2Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120050216"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.223.200])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 07:16:54 -0800
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@intel.com,
	kirill.shutemov@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	peterz@infradead.org,
	mingo@redhat.com,
	hpa@zytor.com,
	dan.j.williams@intel.com,
	seanjc@google.com,
	pbonzini@redhat.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	rick.p.edgecombe@intel.com,
	isaku.yamahata@intel.com,
	adrian.hunter@intel.com,
	nik.borisov@suse.com,
	kai.huang@intel.com
Subject: [PATCH v9 6/6] x86/virt/tdx: Require the module to assert it has the NO_RBP_MOD mitigation
Date: Sun, 15 Dec 2024 04:15:47 +1300
Message-ID: <76ae5025502c84d799e3a56a6fc4f69a82da8f93.1734188033.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734188033.git.kai.huang@intel.com>
References: <cover.1734188033.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Old TDX modules can clobber RBP in the TDH.VP.ENTER SEAMCALL.  However
RBP is used as frame pointer in the x86_64 calling convention, and
clobbering RBP could result in bad things like being unable to unwind
the stack if any non-maskable exceptions (NMI, #MC etc) happens in that
gap.

A new "NO_RBP_MOD" feature was introduced to more recent TDX modules to
not clobber RBP.  KVM will need to use the TDH.VP.ENTER SEAMCALL to run
TDX guests.  It won't be safe to run TDX guests w/o this feature.  To
prevent it, just don't initialize the TDX module if this feature is not
supported [1].

Note the bit definitions of TDX_FEATURES0 are not auto-generated in
tdx_global_metadata.h.  Manually define a macro for it in "tdx.h".

Link: https://lore.kernel.org/fc0e8ab7-86d4-4428-be31-82e1ece6dd21@intel.com/ [1]
Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
v8 -> v9:
 - Minor changelog improvement suggested by Rick and Reniette.
 - Rebase due to the removal of CMR reading code.

Note:

This doesn't need to be included to stable kernels because TDH.VP.ENTER
won't be used until KVM is able to support TDX.

---
 arch/x86/virt/vmx/tdx/tdx.c | 17 +++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 43ec56db5084..7fdb37387886 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -272,6 +272,18 @@ static int read_sys_metadata_field(u64 field_id, u64 *data)
 
 #include "tdx_global_metadata.c"
 
+static int check_features(struct tdx_sys_info *sysinfo)
+{
+	u64 tdx_features0 = sysinfo->features.tdx_features0;
+
+	if (!(tdx_features0 & TDX_FEATURES0_NO_RBP_MOD)) {
+		pr_err("frame pointer (RBP) clobber bug present, upgrade TDX module\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* Calculate the actual TDMR size */
 static int tdmr_size_single(u16 max_reserved_per_tdmr)
 {
@@ -1055,6 +1067,11 @@ static int init_tdx_module(void)
 	if (ret)
 		return ret;
 
+	/* Check whether the kernel can support this module */
+	ret = check_features(&sysinfo);
+	if (ret)
+		return ret;
+
 	/*
 	 * To keep things simple, assume that all TDX-protected memory
 	 * will come from the page allocator.  Make sure all pages in the
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 641beec86e73..4e3d533cdd61 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -2,6 +2,7 @@
 #ifndef _X86_VIRT_TDX_H
 #define _X86_VIRT_TDX_H
 
+#include <linux/bits.h>
 #include "tdx_global_metadata.h"
 
 /*
@@ -51,6 +52,9 @@ struct tdmr_info {
 	DECLARE_FLEX_ARRAY(struct tdmr_reserved_area, reserved_areas);
 } __packed __aligned(TDMR_INFO_ALIGNMENT);
 
+/* Bit definitions of TDX_FEATURES0 metadata field */
+#define TDX_FEATURES0_NO_RBP_MOD	BIT(18)
+
 /*
  * Do not put any hardware-defined TDX structure representations below
  * this comment!
-- 
2.47.1


