Return-Path: <linux-kernel+bounces-169782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B96E88BCD95
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4974A2850B3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D8B143C5C;
	Mon,  6 May 2024 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E3hHVnNO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FDC143896
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714997761; cv=none; b=XbE4257pTvrV0cMCTQjSxGywDcNZTEs5HtNquaUu79Epunw6KtaPETtTlzgDMrUPLoFP2dKCAToKRqSMrjEAiEMWUvcvYtUuoovfM9Re/IxX8eJL924E0CrkQ2vejPqcm0EAM7TP79L6lmQ5GMSthFDcOm8/2fvqdLyBUMz6M6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714997761; c=relaxed/simple;
	bh=9oUZ3YbVKWgyrNdYFYkzttpGYTGgf33f/fi108YIgTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EwYSbV8XVIol+IOUG16UmnP6d7W+R2ksDeysDwC1oZ3GbF4vWVBfQPvTGu4QiT650Xwg2wMjt+YGhBSCWrSxwjN36LXrUTscEKU/d0A1kXKzWfqhJMuBlwuoTROw/u4CF8IDrB9aWH+37Fp8uGN96Wgr9JgMDF4VYqv7/YHIPoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E3hHVnNO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714997759; x=1746533759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9oUZ3YbVKWgyrNdYFYkzttpGYTGgf33f/fi108YIgTc=;
  b=E3hHVnNOP1b3NbIuUfe5GyMn2bK2yGEGvXXBqKRFAK8fNfxfkyjFM8w+
   W4PcC4gSgXTs8sTbRYVS69aazZB+uYnpIXnsBucJHnMuX4igzlh8pVEBh
   Ov5iLy73dPQh+qwyb9uC274aQyrpH3ZzyxalfpfNBhz6jRntER8E+AbRk
   gaho2RLsGU2sD1XHq8NexXyzZAij8sY2K/8jMbMxTBeWHCeNVES88qJ/K
   pLHMyqhT+qowjGiA4Y9Zhbu1PiKTCx2XN5QMo/CFRmHlhn7IAYUaSQcsy
   hvkW5CDtx/d0JMaAHCaCIrp5Wz0XgaEVjz7M1LPBS2fceSTQCWwRT5R2A
   A==;
X-CSE-ConnectionGUID: 4mHHkDfZQZWoSvifrzxalA==
X-CSE-MsgGUID: 3dYsPVMFRCaB2Nj2H5BRcw==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="14544136"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="14544136"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 05:15:58 -0700
X-CSE-ConnectionGUID: QM3xDSqWSwqxbqi5Q/3QLA==
X-CSE-MsgGUID: XtlBxlu2Sfi+nNmPODLuAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="32951425"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 06 May 2024 05:15:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 01F573DC; Mon, 06 May 2024 15:15:54 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHv3 3/4] x86/tdx: Handle PENDING_EPT_VIOLATION_V2
Date: Mon,  6 May 2024 15:15:52 +0300
Message-ID: <20240506121553.3824346-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240506121553.3824346-1-kirill.shutemov@linux.intel.com>
References: <20240506121553.3824346-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A "SEPT #VE" occurs when a TDX guest touches memory that is not properly
mapped into the "secure EPT".  This can be the result of hypervisor
attacks or bugs, *OR* guest bugs.  Most notably, buggy guests might
touch unaccepted memory for lots of different memory safety bugs like
buffer overflows.

TDX guests do not want to continue in the face of hypervisor attacks or
hypervisor bugs.  They want to terminate as fast and safely as possible.
This is done by checking SEPT_VE_DISABLE attribute. The attribute
controlled by VMM on TD creation and the guest only consumes it.

Newer TDX module versions have PENDING_EPT_VIOLATION_V2 feature that
allows TD to control whether access to memory that is not properly
mapped into the "secure EPT" causes #VE.

Try to disable #VE on SEPT violation, if PENDING_EPT_VIOLATION_V2 is
supported.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c           | 102 ++++++++++++++++++++++++++++--
 arch/x86/include/asm/shared/tdx.h |  18 +++++-
 2 files changed, 114 insertions(+), 6 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 964149d3be5e..6124d86e0b1d 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -77,6 +77,20 @@ static inline void tdcall(u64 fn, struct tdx_module_args *args)
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
+/* Read TD-scoped metadata */
+static inline u64 tdg_vm_rd(u64 field, u64 *value)
+{
+	struct tdx_module_args args = {
+		.rdx = field,
+	};
+	u64 ret;
+
+	ret = __tdcall_ret(TDG_VM_RD, &args);
+	*value = args.r8;
+
+	return ret;
+}
+
 /* Write TD-scoped metadata */
 static inline u64 tdg_vm_wr(u64 field, u64 value, u64 mask)
 {
@@ -89,6 +103,20 @@ static inline u64 tdg_vm_wr(u64 field, u64 value, u64 mask)
 	return __tdcall(TDG_VM_WR, &args);
 }
 
+/* Read system-wide TDX metadata */
+static inline u64 tdg_sys_rd(u64 field, u64 *value)
+{
+	struct tdx_module_args args = {
+		.rdx = field,
+	};
+	u64 ret;
+
+	ret = __tdcall_ret(TDG_SYS_RD, &args);
+	*value = args.r8;
+
+	return ret;
+}
+
 /**
  * tdx_mcall_get_report0() - Wrapper to get TDREPORT0 (a.k.a. TDREPORT
  *                           subtype 0) using TDG.MR.REPORT TDCALL.
@@ -179,11 +207,54 @@ static void __noreturn tdx_panic(const char *msg)
 		__tdx_hypercall(&args);
 }
 
+/*
+ * PENDING_EPT_VIOLATION_V2 feature allows TDX guest to control if it wants to
+ * receive SEPT violation #VEs.
+ *
+ * Check if the feature is available and disable SEPT #VE if possible.
+ */
+static int try_to_disable_sept_ve(u64 features0, u64 td_attr)
+{
+	u64 config, controls;
+
+	/* Does the TDX module support flexible SEPT #VE */
+	if (!(features0 & TDX_FEATURES0_PENDING_EPT_VIOLATION_V2))
+		return -EOPNOTSUPP;
+
+	/* Read TD config flags */
+	if (tdg_vm_rd(TDCS_CONFIG_FLAGS, &config))
+		return -EIO;
+
+	/* Is this TD allowed to disable SEPT #VE */
+	if (!(config & TDCS_CONFIG_FLEXIBLE_PENDING_VE))
+		return -EOPNOTSUPP;
+
+	if (tdg_vm_rd(TDCS_TD_CTLS, &controls))
+		return -EIO;
+
+	/* Check if SEPT #VE has been disabled before us */
+	if (controls & TD_CTLS_PENDING_VE_DISABLE)
+		return 0;
+
+	/* Keep #VE's enabled for splats in debugging environments */
+	if (td_attr & ATTR_DEBUG)
+		return -EOPNOTSUPP;
+
+	/* Try to disable */
+	if (tdg_vm_wr(TDCS_TD_CTLS, TD_CTLS_PENDING_VE_DISABLE,
+		      TD_CTLS_PENDING_VE_DISABLE)) {
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static void tdx_setup(u64 *cc_mask)
 {
 	struct tdx_module_args args = {};
 	unsigned int gpa_width;
-	u64 td_attr;
+	u64 features0, td_attr;
+	bool sept_ve_disabled;
 
 	/*
 	 * TDINFO TDX module call is used to get the TD execution environment
@@ -204,19 +275,40 @@ static void tdx_setup(u64 *cc_mask)
 	gpa_width = args.rcx & GENMASK(5, 0);
 	*cc_mask = BIT_ULL(gpa_width - 1);
 
+	td_attr = args.rdx;
+
 	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
 	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
 
+	if (tdg_sys_rd(TDX_FEATURES0, &features0)) {
+		/*
+		 * TDX 1.0 does not have the field. No optional features are
+		 * supported.
+		 */
+		features0 = 0;
+	}
+
 	/*
 	 * The kernel can not handle #VE's when accessing normal kernel
 	 * memory.  Ensure that no #VE will be delivered for accesses to
 	 * TD-private memory.  Only VMM-shared memory (MMIO) will #VE.
+	 *
+	 * Try to disable SEPT #VE if possible.
 	 */
-	td_attr = args.rdx;
-	if (!(td_attr & ATTR_SEPT_VE_DISABLE)) {
-		const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
+	if (!try_to_disable_sept_ve(features0, td_attr)) {
+		sept_ve_disabled = true;
+	} else {
+		/*
+		 * If SEPT #VE cannot be disabled from guest side, check
+		 * TD attribute if the #VE going to be delivered.
+		 */
+		sept_ve_disabled = td_attr & ATTR_SEPT_VE_DISABLE;
+	}
 
-		/* Relax SEPT_VE_DISABLE check for debug TD. */
+	if (!sept_ve_disabled) {
+		const char *msg = "TD misconfiguration: SEPT #VE has to be disabled";
+
+		/* Relax SEPT #VE disable check for debug TD. */
 		if (td_attr & ATTR_DEBUG)
 			pr_warn("%s\n", msg);
 		else
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index fdfd41511b02..282497d2964b 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -16,11 +16,27 @@
 #define TDG_VP_VEINFO_GET		3
 #define TDG_MR_REPORT			4
 #define TDG_MEM_PAGE_ACCEPT		6
+#define TDG_VM_RD			7
 #define TDG_VM_WR			8
+#define TDG_SYS_RD			11
 
-/* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
+/* TDX Global Metadata. To be used by TDG.SYS.RD */
+#define TDX_FEATURES0			0x0A00000300000008
+
+/* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */
+#define TDCS_CONFIG_FLAGS		0x1110000300000016
+#define TDCS_TD_CTLS			0x1110000300000017
 #define TDCS_NOTIFY_ENABLES		0x9100000000000010
 
+/* TDX_FEATURES0 bits */
+#define TDX_FEATURES0_PENDING_EPT_VIOLATION_V2	BIT_ULL(16)
+
+/* TDCS_CONFIG_FLAGS bits */
+#define TDCS_CONFIG_FLEXIBLE_PENDING_VE	BIT_ULL(1)
+
+/* TDCS_TD_CTLS bits */
+#define TD_CTLS_PENDING_VE_DISABLE	BIT_ULL(0)
+
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
 #define TDVMCALL_GET_QUOTE		0x10002
-- 
2.43.0


