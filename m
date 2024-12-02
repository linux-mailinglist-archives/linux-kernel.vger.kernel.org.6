Return-Path: <linux-kernel+bounces-427013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 892459DFB2B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F34A165A54
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4781F9428;
	Mon,  2 Dec 2024 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MvXrFAkF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E011F9418
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733124307; cv=none; b=dz5Dz5y2y3EF16Aa5QYVb7Lj95P1GwWG0SlrkV7LQYgMnAfRBrraUri5xVGI+q+2F6FAjLY/iMsg1acocB1Bt2MsF40Z+FE7KHv0GWhvqC8PTo+jOtUGtOAfwRVf40Ll4ugIV1S6xoQIOzyfAnfl2mAQAtYuo4adv2HWi0PGf4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733124307; c=relaxed/simple;
	bh=DqsmqPg8dBvlE6bMlkwORFBkjxaO18C1BcYwkC6kODc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N5NND5C3RjVhKDPRyRtwRjr54otQPRyh0aFj4n7nbNBSAHVUBWuf4blUlO34bfsp6psKlc1PguvvOE2uK3Ngl1IZdtTF5KJx9Hy9viL5Ym9mRFjdhQ4EafSEpq4RoaYslGDaa0g64S5r0WVrtXoa2DAsF7eLEGng/54mtb2Qytg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MvXrFAkF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733124306; x=1764660306;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DqsmqPg8dBvlE6bMlkwORFBkjxaO18C1BcYwkC6kODc=;
  b=MvXrFAkFjfzl7yYEPwomEyQgAPa90NMbYOpPkW4EojUyFeIthhWLXE2L
   9e3cDcci9BTgR8HrEG+xuFNhH67quLjlnQuvbhQCEXNrnY03hIeHNe4tF
   pKSlwTFL4Jp+gGQlb2YQpmiheAdokRIX+wBcTKcouHmTOnaszPL2wq1OD
   Ktymmica2Ia4G6VQg6pVGDdia0PrNCATCjZQtsCpFPz5ltEMTmBLSOI+l
   vr/CCmO1Ko/9EF8fSuYW1f/+49WttCnOZ9bN/EnXHyan53pn5UYTsH2I+
   qVJ5Z+UNaIGyCN4dcXxzfIL1kd5LHF2Y+mnPdMZaPhmCb+U5hjgjOGHLP
   Q==;
X-CSE-ConnectionGUID: QBUSrtM7TjeOYWH63dEoSg==
X-CSE-MsgGUID: V/iQ/uGQRpez/KPRf0OUnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11273"; a="43951440"
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="43951440"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2024 23:25:06 -0800
X-CSE-ConnectionGUID: MxRj7px1SdanuphA1phbnA==
X-CSE-MsgGUID: Lv34/NItSFakq5AHBheaJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="93506718"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 01 Dec 2024 23:25:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 6458D3B2; Mon, 02 Dec 2024 09:25:01 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86/tdx: Dump attributes and TD_CTLS on boot
Date: Mon,  2 Dec 2024 09:24:58 +0200
Message-ID: <20241202072458.447455-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dump TD configuration on boot. Attributes and TD_CTLS define TD
behavior. This information is useful for tracking down bugs.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/Makefile        |  2 +-
 arch/x86/coco/tdx/debug.c         | 69 +++++++++++++++++++++++++++++++
 arch/x86/coco/tdx/tdx.c           | 27 ++++++++----
 arch/x86/include/asm/shared/tdx.h | 39 +++++++++++++++--
 arch/x86/include/asm/tdx.h        |  3 ++
 5 files changed, 128 insertions(+), 12 deletions(-)
 create mode 100644 arch/x86/coco/tdx/debug.c

diff --git a/arch/x86/coco/tdx/Makefile b/arch/x86/coco/tdx/Makefile
index 2c7dcbf1458b..b3c47d3700e2 100644
--- a/arch/x86/coco/tdx/Makefile
+++ b/arch/x86/coco/tdx/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y += tdx.o tdx-shared.o tdcall.o
+obj-y += debug.o tdcall.o tdx.o tdx-shared.o
diff --git a/arch/x86/coco/tdx/debug.c b/arch/x86/coco/tdx/debug.c
new file mode 100644
index 000000000000..cef847c8bb67
--- /dev/null
+++ b/arch/x86/coco/tdx/debug.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#undef pr_fmt
+#define pr_fmt(fmt)     "tdx: " fmt
+
+#include <linux/array_size.h>
+#include <linux/printk.h>
+#include <asm/tdx.h>
+
+#define DEF_TDX_ATTR_NAME(_name) [TDX_ATTR_##_name##_BIT] = __stringify(_name)
+
+static __initdata const char *tdx_attributes[] = {
+	DEF_TDX_ATTR_NAME(DEBUG),
+	DEF_TDX_ATTR_NAME(HGS_PLUS_PROF),
+	DEF_TDX_ATTR_NAME(PERF_PROF),
+	DEF_TDX_ATTR_NAME(PMT_PROF),
+	DEF_TDX_ATTR_NAME(ICSSD),
+	DEF_TDX_ATTR_NAME(LASS),
+	DEF_TDX_ATTR_NAME(SEPT_VE_DISABLE),
+	DEF_TDX_ATTR_NAME(MIGRTABLE),
+	DEF_TDX_ATTR_NAME(PKS),
+	DEF_TDX_ATTR_NAME(KL),
+	DEF_TDX_ATTR_NAME(TPA),
+	DEF_TDX_ATTR_NAME(PERFMON),
+};
+
+#define DEF_TD_CTLS_NAME(_name) [TD_CTLS_##_name##_BIT] = __stringify(_name)
+
+static __initdata const char *tdcs_td_ctls[] = {
+	DEF_TD_CTLS_NAME(PENDING_VE_DISABLE),
+	DEF_TD_CTLS_NAME(ENUM_TOPOLOGY),
+	DEF_TD_CTLS_NAME(VIRT_CPUID2),
+	DEF_TD_CTLS_NAME(REDUCE_VE),
+	DEF_TD_CTLS_NAME(LOCK),
+};
+
+void __init tdx_dump_attributes(u64 td_attr)
+{
+	pr_info("Attributes:");
+
+	for (int i = 0; i < ARRAY_SIZE(tdx_attributes); i++) {
+		if (!tdx_attributes[i])
+			continue;
+		if (td_attr & BIT(i))
+			pr_cont(" %s", tdx_attributes[i]);
+		td_attr &= ~BIT(i);
+	}
+
+	if (td_attr)
+		pr_cont(" unknown:%#llx", td_attr);
+	pr_cont("\n");
+
+}
+
+void __init tdx_dump_td_ctls(u64 td_ctls)
+{
+	pr_info("TD_CTLS:");
+
+	for (int i = 0; i < ARRAY_SIZE(tdcs_td_ctls); i++) {
+		if (!tdcs_td_ctls[i])
+			continue;
+		if (td_ctls & BIT(i))
+			pr_cont(" %s", tdcs_td_ctls[i]);
+		td_ctls &= ~BIT(i);
+	}
+	if (td_ctls)
+		pr_cont(" unknown:%#llx", td_ctls);
+	pr_cont("\n");
+}
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 7285502f3048..d6868e90853d 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -32,9 +32,6 @@
 #define VE_GET_PORT_NUM(e)	((e) >> 16)
 #define VE_IS_IO_STRING(e)	((e) & BIT(4))
 
-#define ATTR_DEBUG		BIT(0)
-#define ATTR_SEPT_VE_DISABLE	BIT(28)
-
 /* TDX Module call error codes */
 #define TDCALL_RETURN_CODE(a)	((a) >> 32)
 #define TDCALL_INVALID_OPERAND	0xc0000100
@@ -200,14 +197,14 @@ static void __noreturn tdx_panic(const char *msg)
  *
  * TDX 1.0 does not allow the guest to disable SEPT #VE on its own. The VMM
  * controls if the guest will receive such #VE with TD attribute
- * ATTR_SEPT_VE_DISABLE.
+ * TDX_ATTR_SEPT_VE_DISABLE.
  *
  * Newer TDX modules allow the guest to control if it wants to receive SEPT
  * violation #VEs.
  *
  * Check if the feature is available and disable SEPT #VE if possible.
  *
- * If the TD is allowed to disable/enable SEPT #VEs, the ATTR_SEPT_VE_DISABLE
+ * If the TD is allowed to disable/enable SEPT #VEs, the TDX_ATTR_SEPT_VE_DISABLE
  * attribute is no longer reliable. It reflects the initial state of the
  * control for the TD, but it will not be updated if someone (e.g. bootloader)
  * changes it before the kernel starts. Kernel must check TDCS_TD_CTLS bit to
@@ -216,14 +213,14 @@ static void __noreturn tdx_panic(const char *msg)
 static void disable_sept_ve(u64 td_attr)
 {
 	const char *msg = "TD misconfiguration: SEPT #VE has to be disabled";
-	bool debug = td_attr & ATTR_DEBUG;
+	bool debug = td_attr & TDX_ATTR_DEBUG;
 	u64 config, controls;
 
 	/* Is this TD allowed to disable SEPT #VE */
 	tdg_vm_rd(TDCS_CONFIG_FLAGS, &config);
 	if (!(config & TDCS_CONFIG_FLEXIBLE_PENDING_VE)) {
 		/* No SEPT #VE controls for the guest: check the attribute */
-		if (td_attr & ATTR_SEPT_VE_DISABLE)
+		if (td_attr & TDX_ATTR_SEPT_VE_DISABLE)
 			return;
 
 		/* Relax SEPT_VE_DISABLE check for debug TD for backtraces */
@@ -1037,6 +1034,20 @@ static void tdx_kexec_finish(void)
 	}
 }
 
+static __init void tdx_announce(void)
+{
+	struct tdx_module_args args = {};
+	u64 controls;
+
+	pr_info("Guest detected\n");
+
+	tdcall(TDG_VP_INFO, &args);
+	tdx_dump_attributes(args.rdx);
+
+	tdg_vm_rd(TDCS_TD_CTLS, &controls);
+	tdx_dump_td_ctls(controls);
+}
+
 void __init tdx_early_init(void)
 {
 	u64 cc_mask;
@@ -1106,5 +1117,5 @@ void __init tdx_early_init(void)
 	 */
 	x86_cpuinit.parallel_bringup = false;
 
-	pr_info("Guest detected\n");
+	tdx_announce();
 }
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index a878c7e8347b..fcbbef484a78 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -19,6 +19,32 @@
 #define TDG_VM_RD			7
 #define TDG_VM_WR			8
 
+/* TDX attributes */
+#define TDX_ATTR_DEBUG_BIT		0
+#define TDX_ATTR_DEBUG			BIT_ULL(TDX_ATTR_DEBUG_BIT)
+#define TDX_ATTR_HGS_PLUS_PROF_BIT	4
+#define TDX_ATTR_HGS_PLUS_PROF		BIT_ULL(TDX_ATTR_HGS_PLUS_PROF_BIT)
+#define TDX_ATTR_PERF_PROF_BIT		5
+#define TDX_ATTR_PERF_PROF		BIT_ULL(TDX_ATTR_PERF_PROF_BIT)
+#define TDX_ATTR_PMT_PROF_BIT		6
+#define TDX_ATTR_PMT_PROF		BIT_ULL(TDX_ATTR_PMT_PROF_BIT)
+#define TDX_ATTR_ICSSD_BIT		16
+#define TDX_ATTR_ICSSD			BIT_ULL(TDX_ATTR_ICSSD_BIT)
+#define TDX_ATTR_LASS_BIT		27
+#define TDX_ATTR_LASS			BIT_ULL(TDX_ATTR_LASS_BIT)
+#define TDX_ATTR_SEPT_VE_DISABLE_BIT	28
+#define TDX_ATTR_SEPT_VE_DISABLE	BIT_ULL(TDX_ATTR_SEPT_VE_DISABLE_BIT)
+#define TDX_ATTR_MIGRTABLE_BIT		29
+#define TDX_ATTR_MIGRTABLE		BIT_ULL(TDX_ATTR_MIGRTABLE_BIT)
+#define TDX_ATTR_PKS_BIT		30
+#define TDX_ATTR_PKS			BIT_ULL(TDX_ATTR_PKS_BIT)
+#define TDX_ATTR_KL_BIT			31
+#define TDX_ATTR_KL			BIT_ULL(TDX_ATTR_KL_BIT)
+#define TDX_ATTR_TPA_BIT		62
+#define TDX_ATTR_TPA			BIT_ULL(TDX_ATTR_TPA_BIT)
+#define TDX_ATTR_PERFMON_BIT		63
+#define TDX_ATTR_PERFMON		BIT_ULL(TDX_ATTR_PERFMON_BIT)
+
 /* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */
 #define TDCS_CONFIG_FLAGS		0x1110000300000016
 #define TDCS_TD_CTLS			0x1110000300000017
@@ -29,9 +55,16 @@
 #define TDCS_CONFIG_FLEXIBLE_PENDING_VE	BIT_ULL(1)
 
 /* TDCS_TD_CTLS bits */
-#define TD_CTLS_PENDING_VE_DISABLE	BIT_ULL(0)
-#define TD_CTLS_ENUM_TOPOLOGY		BIT_ULL(1)
-#define TD_CTLS_REDUCE_VE		BIT_ULL(3)
+#define TD_CTLS_PENDING_VE_DISABLE_BIT	0
+#define TD_CTLS_PENDING_VE_DISABLE	BIT_ULL(TD_CTLS_PENDING_VE_DISABLE_BIT)
+#define TD_CTLS_ENUM_TOPOLOGY_BIT	1
+#define TD_CTLS_ENUM_TOPOLOGY		BIT_ULL(TD_CTLS_ENUM_TOPOLOGY_BIT)
+#define TD_CTLS_VIRT_CPUID2_BIT		2
+#define TD_CTLS_VIRT_CPUID2		BIT_ULL(TD_CTLS_VIRT_CPUID2_BIT)
+#define TD_CTLS_REDUCE_VE_BIT		3
+#define TD_CTLS_REDUCE_VE		BIT_ULL(TD_CTLS_REDUCE_VE_BIT)
+#define TD_CTLS_LOCK_BIT		63
+#define TD_CTLS_LOCK			BIT_ULL(TD_CTLS_LOCK_BIT)
 
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index eba178996d84..b4b16dafd55e 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -66,6 +66,9 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport);
 
 u64 tdx_hcall_get_quote(u8 *buf, size_t size);
 
+void __init tdx_dump_attributes(u64 td_attr);
+void __init tdx_dump_td_ctls(u64 td_ctls);
+
 #else
 
 static inline void tdx_early_init(void) { };
-- 
2.45.2


