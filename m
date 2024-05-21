Return-Path: <linux-kernel+bounces-184575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAC88CA902
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1C51F2241A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 07:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1249B5026E;
	Tue, 21 May 2024 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gpE5EzWy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4344F88A
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716276918; cv=none; b=b2WAmD/f2N1Gui+P8twQr4CXFODzEqfa2zRkhobbXtLfOypmokTfp3AWPtZ5mWL/rkwa0JXZbAnaR7H+5rQWFNf1iEgJ3Ebh3kkZPbUDFzzCdLNqvb3A7y2F8DRhvrGvw+SFXpNn1J7pAZF09bCg6nl3BC/KrGUwlHgQgtMxZPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716276918; c=relaxed/simple;
	bh=SmapWnD22BSkuuiCcoA8YWZC7F0yYy7UOwcrTcoz1PY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RwQlSRTwoRnM6Z3YRagwXAtd4Y1c6uijYSNbVcSqQboBJ3SpCdZ48RFDhV2GaqWaAlPJKTqEwGHW7TJr3Au11NvVMlS5sP+++4WvlLLiEGDsI4gVCL9Pm3IV+DFE+jVQLAxPCTwtT+7hPmdMTFeSdIRJZ6F2xx3HrlPPIHobHRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gpE5EzWy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716276917; x=1747812917;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SmapWnD22BSkuuiCcoA8YWZC7F0yYy7UOwcrTcoz1PY=;
  b=gpE5EzWy0Zx30PL5DGZS9O6pVqEz0cvETm360cehSkaPciHLhMtlXJFi
   Z64FAK0DzzWvttY587aBN9FkmnKm/6A3e1XbU3urDcQKDvbMNYJQ6ztv3
   bsjt+d9AXwxn6Ut1Qn/wMb0UiXCIwcgCyAnz5vfC7zTaTejqQq03wtRfr
   6fRnSvJxyxvzY3LFq6m7Yp2XfL5YUSk0ZR5ebx0sP/uzoKMJJV/rolJl3
   p31Ku0N2tiUNnD8QAlClqbzsS0jNj/x59JvsrrUL3JMiyXe+5z6H3ifd4
   SPw9wEB61Twzb9g5CPRJMyMt1jlQ3aN72Y5zz3ElGZ9b+bl1dybtCpkny
   w==;
X-CSE-ConnectionGUID: kJ0Q8QxaQ/61kt5+3Uv4Zw==
X-CSE-MsgGUID: E+SLbkWySFqb28gIONfagA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12297150"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="12297150"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 00:35:16 -0700
X-CSE-ConnectionGUID: rap6sGGaQ++LMZCDQqhltg==
X-CSE-MsgGUID: PQvzxl7SSSaEubBwD6FX0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="32854892"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 21 May 2024 00:35:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B2004179; Tue, 21 May 2024 10:35:12 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	cho@microsoft.com,
	decui@microsoft.com,
	John.Starks@microsoft.com
Subject: [PATCH] x86/tdx: Generate SIGBUS on userspace MMIO
Date: Tue, 21 May 2024 10:35:05 +0300
Message-ID: <20240521073505.2190633-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently attempt to do MMIO from userspace in TDX guest leads to
warning about unexpect #VE and SIGSEGV being delivered to the process.

Enlightened userspace might choose to deal with MMIO on their own if
kernel doesn't emulate it.

Handle EPT_VIOLATION exit reason for userspace and deliver SIGBUS
instead of SIGSEV. SIGBUS is more appropriate for MMIO situation.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index c1cb90369915..d2aa93cebf5a 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -7,6 +7,7 @@
 #include <linux/cpufeature.h>
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/sched/signal.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -630,6 +631,11 @@ void tdx_get_ve_info(struct ve_info *ve)
 	ve->instr_info  = upper_32_bits(args.r10);
 }
 
+static inline bool is_private_gpa(u64 gpa)
+{
+	return gpa == cc_mkenc(gpa);
+}
+
 /*
  * Handle the user initiated #VE.
  *
@@ -641,17 +647,20 @@ static int virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
 	switch (ve->exit_reason) {
 	case EXIT_REASON_CPUID:
 		return handle_cpuid(regs, ve);
+	case EXIT_REASON_EPT_VIOLATION:
+		if (is_private_gpa(ve->gpa))
+			panic("Unexpected EPT-violation on private memory.");
+
+		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)ve->gla);
+
+		/* Return 0 to avoid incrementing RIP */
+		return 0;
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return -EIO;
 	}
 }
 
-static inline bool is_private_gpa(u64 gpa)
-{
-	return gpa == cc_mkenc(gpa);
-}
-
 /*
  * Handle the kernel #VE.
  *
-- 
2.43.0


