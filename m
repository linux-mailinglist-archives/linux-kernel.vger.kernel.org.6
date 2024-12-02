Return-Path: <linux-kernel+bounces-427012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABB19DFB2A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CED53B2389A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B071F942D;
	Mon,  2 Dec 2024 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TxQjwCgk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A071F941A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 07:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733124283; cv=none; b=B0j0IPkFnlU6e3lg1J/UoRS0dEwa07trY3WYnYtMW8XutW+l59im2j/2ECzQ1B6J3+O362vdRqtdoVFEmBYpqNSyyPDHp9beJhp/jpgDdadqe+bgBMOITIthT/gjwsF/hT4CXFLicZidwj2ChAoDDzfbGcxzWdj2nd9H1Im/a0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733124283; c=relaxed/simple;
	bh=WNsnVTeO+G4lXLPD4Un825Y8fgiU0qDw53pS6I/TXOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JNvj4Cz91Tuc3/XkzqXP7XkxE171Ag4iATb9hOCfqRHz2yvPMAoGPdw+tJTkYyD2dvenL8fqBTvwUm9s4WleWCq4oFLUbU2OSXXkrCYXdpo22s4KVpTOT8jR1vgBtZQ5sqCAwKxaX2nGzOSEEosy5vob61TJVzeLrZLHyxcX7lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TxQjwCgk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733124281; x=1764660281;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WNsnVTeO+G4lXLPD4Un825Y8fgiU0qDw53pS6I/TXOU=;
  b=TxQjwCgkW40U7pPeerVlf6Cl2VTyrsMBlblQcyrBkc/oKOXD0/gD34rL
   O3xwe2mmMRcl65GaKGk96UxVTJwCqGXdW97Sv+lewYQdH4lU026Xa6y/p
   kMw1TiHC9IxXGlQaPzXlDgKUcCNkErpZfSmXMy1Y92vR4NgSOmMcmsFh+
   ESgaMqsAncvRfq65/JxklPsrIAHC/nsP92tw46ENiryN2+r9RoJJsbYeW
   6jXokXX74JXndVuMYuMUdy3SJiMnfdz59koG9wII3XIk1sH9oSAqjY/0D
   1b5tHVIID5lmtaV6hagamh4VuTCjFI9S06slDQcech89haABiOCYHEXCl
   g==;
X-CSE-ConnectionGUID: kpzmtNRXTWKQ+QZjgow9YQ==
X-CSE-MsgGUID: Hv2xH8xKToiuFGo9SyqIqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11273"; a="43951425"
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="43951425"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2024 23:24:41 -0800
X-CSE-ConnectionGUID: hjNPTh4dSuO/f8FvHlGYcg==
X-CSE-MsgGUID: 73t5UvjtQGeJCtabyVXNJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="97982102"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 01 Dec 2024 23:24:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5031B3B2; Mon, 02 Dec 2024 09:24:37 +0200 (EET)
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
Subject: [PATCH] x86/tdx: Enable #VE reduction feature
Date: Mon,  2 Dec 2024 09:24:31 +0200
Message-ID: <20241202072431.447380-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Originally, #VE was defined as the TDX behavior in order to support
paravirtualization of x86 features that can’t be virtualized by the TDX
module. The intention is that if guest software wishes to use such a
feature, it implements some logic to support this. This logic resides in
the #VE exception handler it may work in cooperation with the host VMM.

Theoretically, the guest TD’s #VE handler was supposed to act as a "TDX
enlightenment agent" inside the TD. However, in practice, the #VE
handler is simplistic:

  - #VE on CPUID is handled by returning all-0 to the code which
    executed CPUID. In many cases, an all-0 value is not the correct
    value, and may cause improper operation.

  - #VE on RDMSR is handled by requesting the MSR value from the host
    VMM. This is prone to security issues since the host VMM is
    untrusted. It may also be functionally incorrect in case the
    expected operation is to paravirtualize some CPU functionality.

Newer TDX module provides REDUCE_VE feature. When enabled, it
drastically cuts cases when guests receives #VE on MSR and CPUID
accesses. Behaviour of a specific MSR or CPUID leaf/sub-leaf is defined
in the TDX spec.

Enable REDUCE_VE. It brings TDX guest behaviour less odd, bring it
closer to an architectural.

Note that enabling of the feature doesn't eliminate need in #VE handler
for CPUID and MSR accesses. Some MSRs still generate #VE (notably
APIC-related) and kernel needs CPUID #VE handler to ask VMM for leafs in
hypervisor range.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c           | 14 +++++++++++++-
 arch/x86/include/asm/shared/tdx.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 0d9b090b4880..7285502f3048 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -274,6 +274,11 @@ static void enable_cpu_topology_enumeration(void)
 	tdg_vm_wr(TDCS_TD_CTLS, TD_CTLS_ENUM_TOPOLOGY, TD_CTLS_ENUM_TOPOLOGY);
 }
 
+static bool enable_reduce_ve(void)
+{
+	return !tdg_vm_wr(TDCS_TD_CTLS, TD_CTLS_REDUCE_VE, TD_CTLS_REDUCE_VE);
+}
+
 static void tdx_setup(u64 *cc_mask)
 {
 	struct tdx_module_args args = {};
@@ -305,7 +310,14 @@ static void tdx_setup(u64 *cc_mask)
 	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
 
 	disable_sept_ve(td_attr);
-	enable_cpu_topology_enumeration();
+
+	/*
+	 * Enabling REDUCE_VE includes ENUM_TOPOLOGY.
+	 *
+	 * Try to enable REDUCE_VE. If it fails, try to enable ENUM_TOPOLOGY.
+	 */
+	if (!enable_reduce_ve())
+		enable_cpu_topology_enumeration();
 }
 
 /*
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 89f7fcade8ae..a878c7e8347b 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -31,6 +31,7 @@
 /* TDCS_TD_CTLS bits */
 #define TD_CTLS_PENDING_VE_DISABLE	BIT_ULL(0)
 #define TD_CTLS_ENUM_TOPOLOGY		BIT_ULL(1)
+#define TD_CTLS_REDUCE_VE		BIT_ULL(3)
 
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
-- 
2.45.2


