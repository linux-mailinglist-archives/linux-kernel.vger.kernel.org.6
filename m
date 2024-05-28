Return-Path: <linux-kernel+bounces-192081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413CE8D1824
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2AFEB26547
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849A316130D;
	Tue, 28 May 2024 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBu/xc6q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A0717E8F4
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890969; cv=none; b=s0pGxcH8z+Mm2KKWoGdbJTIXpvrBQvh7Pm9XBk39bK9NtKJQoRLDnClO+kU/Hu05VDERHX5/xYVOBmgC9xWgJAJcaliiS1cxIXJXyRCwgG2aKJIK0aYA0IdEWcetXo5Br6Z6gxEStgPP7oyWhyWgQpSylrjmc3uKNwroo+EblTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890969; c=relaxed/simple;
	bh=h19i4uIK303A17Pev7/cmdkTNSROBXXQUVH+EFLdd48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KXXLIx8ujNdFgZGNZ1LIqnmIyZfMfj10JNHE0X2an9cgVFxY3RAJgdAjgd+FaCPoWeMH4iuLyFP8Zjl6LKiQqtgB/430wZxrtG7FzyelaNbumm8efkIZlG9GvZrHEV92Jw/iscnTqroynedD0vGezicSHr09hWf8C5Xkjgxr3qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBu/xc6q; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716890968; x=1748426968;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h19i4uIK303A17Pev7/cmdkTNSROBXXQUVH+EFLdd48=;
  b=DBu/xc6q+ZZQ3L9ASYupEnb+2oWaDp+GaimoFzzvsST7GA9Uv0gvGipv
   eq6DkdQV8eBO3RB7VcgdsTKL4CVqmHmvIvIxOZ6ITDRErKHoKhUmitOiV
   4t6Z/vzkbxcqZhzRGdvQNnGvDp9T9/AD4D56pO273J5YSTQGUl2iKEGmI
   fwHRUtrJKcPDuaR308JKEn3rvLPGCq3kvbDK9TpTMcN8gVBov1dXgTDOO
   8K8LP0bxpe9PtUsT5W1JSoiu+xuFkYCGAlphvuOE/U87TV4UeLuhAb4AA
   eJ5eHU4C0AUf/Fue+lcF6xmXL/pd2egib7rXICyEv7G4KDHuspiOP8ona
   A==;
X-CSE-ConnectionGUID: 9Mtl2wgdSQ2pdmATe+MSCQ==
X-CSE-MsgGUID: XdY9jzYWQFK5MGiSEr4GuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24640899"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="24640899"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 03:09:28 -0700
X-CSE-ConnectionGUID: 2zXrjGVjSJ6A/yX5CpFd2A==
X-CSE-MsgGUID: JW4ElxonTZCoBCCJj27NQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="39426484"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 28 May 2024 03:09:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 2E72417E; Tue, 28 May 2024 13:09:24 +0300 (EEST)
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
Date: Tue, 28 May 2024 13:09:19 +0300
Message-ID: <20240528100919.520881-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, attempting to perform MMIO from userspace in a TDX guest
leads to a warning about an unexpected #VE and SIGSEGV being delivered
to the process.

Enlightened userspace may choose to handle MMIO on their own if the
kernel does not emulate it.

Handle the EPT_VIOLATION exit reason for userspace and deliver SIGBUS
instead of SIGSEGV. SIGBUS is more appropriate for the MMIO situation.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

v2:
  - Rebased;
  - Fix grammar;
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


