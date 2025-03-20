Return-Path: <linux-kernel+bounces-570527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BD7A6B1BE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 235097ADFC3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C4422B8C3;
	Thu, 20 Mar 2025 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gEOjxjxl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74EA22B598
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514192; cv=none; b=qT6EcW8slzWMECCq0axUCVG43krQC79g1uxzXSOvxwjvjHdSOa+Isj5/8CwrzuWSZsWtaK2NMxUGNkNmVY3kdb+SSRLNzBHmsT3jSADlWaSdmCUuINvIJGIpon50zPrwWlwqeWKowRzx0AMA/02YIFJXsd/DwTv6ShPVWA8afxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514192; c=relaxed/simple;
	bh=xkbyojQodbOAEhETLU1zQWNpvzsyZ8UW18+79jCNagE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EG6qyWIO63M9h6YqyrH+SKGatU2XR9eoG+uwDi++F1PWn8CJNwhwpKSMO3+V2dCqf9CD7ax8Zx5eJxodZetK1AzGd/V6ctPOI/ZGuZlNue60RTAIRPX45UgLhnt4vROYp7ihCSFKRqgQST9bsEbfUM4rr3WvtyTy1dzkSQ8iOr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gEOjxjxl; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742514190; x=1774050190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xkbyojQodbOAEhETLU1zQWNpvzsyZ8UW18+79jCNagE=;
  b=gEOjxjxl0QdRUfptJd4SRA1TlvD+yUNDlpY7EHykRpUEexnRTTdgrNkz
   z+IDvJMffn75AGmZNdfDEYgzoPDObNDMroxaYaAXzqNbWf2E7Pem7aIGy
   YJzt1NxbtI0DYjc55NNqgjw+y425uIc92QcOviO0V4ZXmqlSfkBICi6E+
   EjCj4P17NyQHhs8LRmNBQ5PzhLRrSgmTQVplHTgZf90v/6fWvLhWq/9bi
   oOv1euFIoedTLsZvhYqox/LNyFP5Rz723HPN+fJ7PV4sOhitMHBJHi8+v
   HIi47WWSAGd2o1hxXTflF3gtD9j/gi9MUht/xaNQXF0MNZvklcGLYMtvA
   Q==;
X-CSE-ConnectionGUID: 2Wr2/YabSxeTb0ZzGnSaSQ==
X-CSE-MsgGUID: OOBV3DU2Qw6nzZM2KmWPtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43502583"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43502583"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:43:10 -0700
X-CSE-ConnectionGUID: NtbQglzHSuWh3zuFsxOgYw==
X-CSE-MsgGUID: BVQRnDeoQVuDAoWxQKNHzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="122962938"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.68])
  by orviesa009.jf.intel.com with ESMTP; 20 Mar 2025 16:43:10 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC v2 2/9] x86/fpu/xstate: Introduce xfeature order table and accessor macro
Date: Thu, 20 Mar 2025 16:42:53 -0700
Message-ID: <20250320234301.8342-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250320234301.8342-1-chang.seok.bae@intel.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <20250320234301.8342-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The kernel has largely assumed that higher xstate component numbers
correspond to later offsets in the buffer. However, this assumption no
longer holds for the non-compacted format, where a newer state component
may have a lower offset.

When iterating over xstate components in offset order, using the feature
number as an index may be misleading. At the same time, the CPU exposes
each component’s size and offset based on its feature number, making it a
key for state information.

To provide flexibility in handling xstate ordering, introduce a mapping
table: feature order -> feature number.  The table is dynamically
populated based on the CPU-exposed features and is sorted in offset order
at boot time.

Additionally, add an accessor macro to facilitate sequential traversal of
xstate components based on their actual buffer positions, given a feature
bitmask. This accessor macro will be particularly useful for computing
custom non-compacted format sizes and iterating over xstate offsets in
non-compacted buffers.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/all/7fa02be2-0884-4702-ae73-a3620938161b@intel.com
---
RFC-V1 -> RFC-V2: Populate the order table dynamically (Dave).

This introduction lays the groundwork for handling APX, which is assigned
feature number 19 but appears immediately after FEATURE_YMM in
APX-enabled systems. Older CPUs, such as Skylake systems, previously used
this region for MPX.

Later in this series, APX and MPX will be explicitly marked as mutually
exclusive to prevent conflicts. Since the xfeature order table is
dynamically populated at boot, it will reflect the correct feature set
for each system configuration.
---
 arch/x86/kernel/fpu/xstate.c | 58 +++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 542c6981180d..1e22103a8e17 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -14,6 +14,7 @@
 #include <linux/proc_fs.h>
 #include <linux/vmalloc.h>
 #include <linux/coredump.h>
+#include <linux/sort.h>
 
 #include <asm/fpu/api.h>
 #include <asm/fpu/regset.h>
@@ -88,6 +89,31 @@ static unsigned int xstate_sizes[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_flags[XFEATURE_MAX] __ro_after_init;
 
+/*
+ * Ordering of xstate components in uncompacted format:  The xfeature
+ * number does not necessarily indicate its position in the XSAVE buffer.
+ * This array defines the traversal order of xstate features.
+ */
+static unsigned int xfeature_uncompact_order[XFEATURE_MAX] __ro_after_init =
+	{ [ 0 ... XFEATURE_MAX - 1] = -1};
+
+static inline unsigned int next_xfeature_order(unsigned int i, u64 mask)
+{
+	for (; xfeature_uncompact_order[i] != -1; i++) {
+		if (mask & BIT_ULL(xfeature_uncompact_order[i]))
+			break;
+	}
+
+	return i;
+}
+
+/* Iterate xstate features in uncompacted order: */
+#define for_each_extended_xfeature_in_order(i, mask)	\
+	for (i = 0;					\
+	     i = next_xfeature_order(i, mask),		\
+	     xfeature_uncompact_order[i] != -1;		\
+	     i++)
+
 #define XSTATE_FLAG_SUPERVISOR	BIT(0)
 #define XSTATE_FLAG_ALIGNED64	BIT(1)
 
@@ -209,13 +235,20 @@ static bool xfeature_enabled(enum xfeature xfeature)
 	return fpu_kernel_cfg.max_features & BIT_ULL(xfeature);
 }
 
+static int compare_xstate_offsets(const void *xfeature1, const void *xfeature2)
+{
+	return  xstate_offsets[*(unsigned int *)xfeature1] -
+		xstate_offsets[*(unsigned int *)xfeature2];
+}
+
 /*
  * Record the offsets and sizes of various xstates contained
- * in the XSAVE state memory layout.
+ * in the XSAVE state memory layout. Also, create an ordered
+ * list of xfeatures for handling out-of-order offsets.
  */
 static void __init setup_xstate_cache(void)
 {
-	u32 eax, ebx, ecx, edx, i;
+	u32 eax, ebx, ecx, edx, xfeature, i = 0;
 	/*
 	 * The FP xstates and SSE xstates are legacy states. They are always
 	 * in the fixed offsets in the xsave area in either compacted form
@@ -229,21 +262,30 @@ static void __init setup_xstate_cache(void)
 	xstate_sizes[XFEATURE_SSE]	= sizeof_field(struct fxregs_state,
 						       xmm_space);
 
-	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
-		cpuid_count(CPUID_LEAF_XSTATE, i, &eax, &ebx, &ecx, &edx);
+	for_each_extended_xfeature(xfeature, fpu_kernel_cfg.max_features) {
+		cpuid_count(CPUID_LEAF_XSTATE, xfeature, &eax, &ebx, &ecx, &edx);
 
-		xstate_sizes[i] = eax;
-		xstate_flags[i] = ecx;
+		xstate_sizes[xfeature] = eax;
+		xstate_flags[xfeature] = ecx;
 
 		/*
 		 * If an xfeature is supervisor state, the offset in EBX is
 		 * invalid, leave it to -1.
 		 */
-		if (xfeature_is_supervisor(i))
+		if (xfeature_is_supervisor(xfeature))
 			continue;
 
-		xstate_offsets[i] = ebx;
+		xstate_offsets[xfeature] = ebx;
+
+		/* Populate the list of xfeatures before sorting */
+		xfeature_uncompact_order[i++] = xfeature;
 	}
+
+	/*
+	 * Sort xfeatures by their offsets to support out-of-order
+	 * offsets in the uncompacted format.
+	 */
+	sort(xfeature_uncompact_order, i, sizeof(unsigned int), compare_xstate_offsets, NULL);
 }
 
 /*
-- 
2.45.2


