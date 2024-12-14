Return-Path: <linux-kernel+bounces-446083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335559F1FA1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 16:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA8EA7A06C7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 15:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C621A0BEE;
	Sat, 14 Dec 2024 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Boewuzqc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A803D1A3034
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734189416; cv=none; b=OxI2qzbyt+Q0V9NdE7e/5VM4zQ1siYeOSOwE8IaJfYgGRx+IBRY7pQoxZj5xrqc0sWo1L/PIvB0AJSljYzPLsfUuh0ItP0/F26IlUrTJtSnu9r770W44omVireuSLVfYv1bqRFxKt/EkBQSVimHodKqN6xsBDBwLN05MOgWpQ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734189416; c=relaxed/simple;
	bh=WeF04S8Gk0z2Y2rgXyEQT2J2OCs20Gh9h2IGzFi0np0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/0mlDesfTjqneAzx/1qvUYCZjcE8GzuyWXSxkl9F4jXC3MuCLcSd+l8/+FWGwZj5vuGlSE6gJapKIjupBdYJMBYUu9/wXVeAOcRpOupJ6zvMnY4TYRu+ud4ylnu8y9p507NRqGTaGCpE8bjOEwKADT/MXQZvZzGEI5Ds4Nn52Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Boewuzqc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734189415; x=1765725415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WeF04S8Gk0z2Y2rgXyEQT2J2OCs20Gh9h2IGzFi0np0=;
  b=BoewuzqcBG2BikTYVmXuUGYebNcpXC6fGHg/lLuIp0llz0Em4EIAfP+B
   DinixHHWxJYKgIZgXDHoYPbkgWJOZVa/YlBEAoOSHQKvwx1VlwQGfiLhi
   rCiaHeHkbkHl2o/Qj5lvQogETAEGzt1ghTN3IQLpFVvPQRx88cvXhYeSo
   c9EBm5dZeYtRlCbx5YFN52t+oJ+T6gMOb+el+keZrzsqVP5d8pi+gm9er
   D/zmAxukdeziyyP6YSicZ9YU1acRdbQ7POADlqUOB1sAle7j3Xbw9/hmU
   lTnBhbBjiSJwvVJOsp+/CLhotJPgqrrgk9z7+PBDR9g0ZvEpy8oSBfLQ4
   w==;
X-CSE-ConnectionGUID: Kk/P9r/aR/Cw8S/L3Ukdnw==
X-CSE-MsgGUID: p2kjaVtQTq2hVVq94KzcXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45109925"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45109925"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 07:16:54 -0800
X-CSE-ConnectionGUID: h1Wlp24NSsmw4ibPfUWdBA==
X-CSE-MsgGUID: lTHkvCq6QvGkdi7XbPPp8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120050203"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.223.200])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 07:16:46 -0800
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
Subject: [PATCH v9 5/6] x86/virt/tdx: Switch to use auto-generated global metadata reading code
Date: Sun, 15 Dec 2024 04:15:46 +1300
Message-ID: <fc025d1e13b92900323f47cfe9aac3157bf08ee7.1734188033.git.kai.huang@intel.com>
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

Continue the process to have a centralized solution for TDX global
metadata reading.  Now that the new autogenerated solution is ready for
use, switch to it and remove the old one.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
v8 -> v9:
 - Improve changelog suggested by Rick.

---
 arch/x86/virt/vmx/tdx/tdx.c | 61 +------------------------------------
 arch/x86/virt/vmx/tdx/tdx.h | 45 +--------------------------
 2 files changed, 2 insertions(+), 104 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 28537a6c47fc..43ec56db5084 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -270,66 +270,7 @@ static int read_sys_metadata_field(u64 field_id, u64 *data)
 	return 0;
 }
 
-static int read_sys_metadata_field16(u64 field_id,
-				     int offset,
-				     struct tdx_sys_info_tdmr *ts)
-{
-	u16 *ts_member = ((void *)ts) + offset;
-	u64 tmp;
-	int ret;
-
-	if (WARN_ON_ONCE(MD_FIELD_ID_ELE_SIZE_CODE(field_id) !=
-			MD_FIELD_ID_ELE_SIZE_16BIT))
-		return -EINVAL;
-
-	ret = read_sys_metadata_field(field_id, &tmp);
-	if (ret)
-		return ret;
-
-	*ts_member = tmp;
-
-	return 0;
-}
-
-struct field_mapping {
-	u64 field_id;
-	int offset;
-};
-
-#define TD_SYSINFO_MAP(_field_id, _offset) \
-	{ .field_id = MD_FIELD_ID_##_field_id,	   \
-	  .offset   = offsetof(struct tdx_sys_info_tdmr, _offset) }
-
-/* Map TD_SYSINFO fields into 'struct tdx_sys_info_tdmr': */
-static const struct field_mapping fields[] = {
-	TD_SYSINFO_MAP(MAX_TDMRS,	      max_tdmrs),
-	TD_SYSINFO_MAP(MAX_RESERVED_PER_TDMR, max_reserved_per_tdmr),
-	TD_SYSINFO_MAP(PAMT_4K_ENTRY_SIZE,    pamt_4k_entry_size),
-	TD_SYSINFO_MAP(PAMT_2M_ENTRY_SIZE,    pamt_2m_entry_size),
-	TD_SYSINFO_MAP(PAMT_1G_ENTRY_SIZE,    pamt_1g_entry_size),
-};
-
-static int get_tdx_sys_info_tdmr(struct tdx_sys_info_tdmr *sysinfo_tdmr)
-{
-	int ret;
-	int i;
-
-	/* Populate 'sysinfo_tdmr' fields using the mapping structure above: */
-	for (i = 0; i < ARRAY_SIZE(fields); i++) {
-		ret = read_sys_metadata_field16(fields[i].field_id,
-						fields[i].offset,
-						sysinfo_tdmr);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
-{
-	return get_tdx_sys_info_tdmr(&sysinfo->tdmr);
-}
+#include "tdx_global_metadata.c"
 
 /* Calculate the actual TDMR size */
 static int tdmr_size_single(u16 max_reserved_per_tdmr)
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index ec879d54eb5c..641beec86e73 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -2,7 +2,7 @@
 #ifndef _X86_VIRT_TDX_H
 #define _X86_VIRT_TDX_H
 
-#include <linux/bits.h>
+#include "tdx_global_metadata.h"
 
 /*
  * This file contains both macros and data structures defined by the TDX
@@ -26,35 +26,6 @@
 #define	PT_NDA		0x0
 #define	PT_RSVD		0x1
 
-/*
- * Global scope metadata field ID.
- *
- * See Table "Global Scope Metadata", TDX module 1.5 ABI spec.
- */
-#define MD_FIELD_ID_MAX_TDMRS			0x9100000100000008ULL
-#define MD_FIELD_ID_MAX_RESERVED_PER_TDMR	0x9100000100000009ULL
-#define MD_FIELD_ID_PAMT_4K_ENTRY_SIZE		0x9100000100000010ULL
-#define MD_FIELD_ID_PAMT_2M_ENTRY_SIZE		0x9100000100000011ULL
-#define MD_FIELD_ID_PAMT_1G_ENTRY_SIZE		0x9100000100000012ULL
-
-/*
- * Sub-field definition of metadata field ID.
- *
- * See Table "MD_FIELD_ID (Metadata Field Identifier / Sequence Header)
- * Definition", TDX module 1.5 ABI spec.
- *
- *  - Bit 33:32: ELEMENT_SIZE_CODE -- size of a single element of metadata
- *
- *	0: 8 bits
- *	1: 16 bits
- *	2: 32 bits
- *	3: 64 bits
- */
-#define MD_FIELD_ID_ELE_SIZE_CODE(_field_id)	\
-		(((_field_id) & GENMASK_ULL(33, 32)) >> 32)
-
-#define MD_FIELD_ID_ELE_SIZE_16BIT	1
-
 struct tdmr_reserved_area {
 	u64 offset;
 	u64 size;
@@ -80,20 +51,6 @@ struct tdmr_info {
 	DECLARE_FLEX_ARRAY(struct tdmr_reserved_area, reserved_areas);
 } __packed __aligned(TDMR_INFO_ALIGNMENT);
 
-/* Class "TDMR info" */
-struct tdx_sys_info_tdmr {
-	u16 max_tdmrs;
-	u16 max_reserved_per_tdmr;
-	u16 pamt_4k_entry_size;
-	u16 pamt_2m_entry_size;
-	u16 pamt_1g_entry_size;
-};
-
-/* Kernel used global metadata fields */
-struct tdx_sys_info {
-	struct tdx_sys_info_tdmr tdmr;
-};
-
 /*
  * Do not put any hardware-defined TDX structure representations below
  * this comment!
-- 
2.47.1


