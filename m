Return-Path: <linux-kernel+bounces-280915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7B294D0DB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6907F2852F9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8904A1953AD;
	Fri,  9 Aug 2024 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODEQLotP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6080B194AEE
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723208971; cv=none; b=qiVM2qGshsqZKM61aVbzk+ZQLgJEBuRwLH0o1wwOLgzGN+YS0oUnKOBVvq/CvwVjS6OgarU+2xtML2TeczD4diZlaRzQ7vIN/fqkpoumY72Rq3kQhrO32GZRzubXrBRZsMaWOLGj9a2Ona0hQfrA6rr2BwZUL6CMceEYBIPiISI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723208971; c=relaxed/simple;
	bh=1k07vV7KQj8ThVBwSvxTgnF1hHNqQwmPgYo9YN/leIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqE09y7OEBIrEKPXWixNQuLJJvY8QNCGEDyGJMkIIdbrFCWlWm6uMDy40ffRhbIhZrA/3zN6INbvrXw1pQwaWjyrVTXAG5PkSLAjlKN4fDIIo0pW25Q28boaebVUvnB6qWUUBp8RHvXJU7fZoqgr4RQjzX36Wz2J0w042/cn3kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ODEQLotP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723208970; x=1754744970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1k07vV7KQj8ThVBwSvxTgnF1hHNqQwmPgYo9YN/leIQ=;
  b=ODEQLotPO7xoYvVpIRVteXR1f64MoubeE/PSr3St926kmb7uPRSXW4Lt
   /fPpVts0KHDUoRvGYYAZLOpwjHh3vM/yTLYeWPUyMbBVabNFAtRQsycDf
   zFjlv/PHHJaXNPz5GnVkeIZiN/Tkr93m/Ygujj6gsHqJYwE9yhRufqIlk
   TWavp5YWanTImS5NPfRuyw4TPHt9CqoQwhWofwOUiJOnQ3ALiNWi6vw7Z
   h7Czqh9SDVVdu1UyAE3e+Pq0cN4TXTT+Gn9Bjv+wIGTr22vd2cLy/i1uS
   DyZ9BIYlAiOrSutUMrNLYRm12PEo+yXNKcI/apmg5q8oDlP3A+lK8y3yf
   Q==;
X-CSE-ConnectionGUID: /65bBK1aSQuAgxsCyRRfSA==
X-CSE-MsgGUID: Zqis8UQUTo+uBDi4VHbX3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="46788167"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="46788167"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 06:09:28 -0700
X-CSE-ConnectionGUID: Z1jgRXOfQpuIo18Klt7I/A==
X-CSE-MsgGUID: EePILd/eQZCPK7XWD5Rk8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57651639"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 09 Aug 2024 06:09:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 35F44A14; Fri, 09 Aug 2024 16:09:25 +0300 (EEST)
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
Subject: [PATCHv5, REBASED 4/4] x86/tdx: Enable CPU topology enumeration
Date: Fri,  9 Aug 2024 16:09:23 +0300
Message-ID: <20240809130923.3893765-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809130923.3893765-1-kirill.shutemov@linux.intel.com>
References: <20240809130923.3893765-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TDX 1.0 defines baseline behaviour of TDX guest platform. In TDX 1.0
generates a #VE when accessing topology-related CPUID leafs (0xB and
0x1F) and the X2APIC_APICID MSR. The kernel returns all zeros on CPUID
topology. In practice, this means that the kernel can only boot with a
plain topology. Any complications will cause problems.

The ENUM_TOPOLOGY feature allows the VMM to provide topology
information to the guest. Enabling the feature eliminates
topology-related #VEs: the TDX module virtualizes accesses to
the CPUID leafs and the MSR.

Enable ENUM_TOPOLOGY if it is available.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c           | 27 +++++++++++++++++++++++++++
 arch/x86/include/asm/shared/tdx.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index ba3103877b21..f6e48119d6fd 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -249,6 +249,32 @@ static void disable_sept_ve(u64 td_attr)
 	return;
 }
 
+/*
+ * TDX 1.0 generates a #VE when accessing topology-related CPUID leafs (0xB and
+ * 0x1F) and the X2APIC_APICID MSR. The kernel returns all zeros on CPUID #VEs.
+ * In practice, this means that the kernel can only boot with a plain topology.
+ * Any complications will cause problems.
+ *
+ * The ENUM_TOPOLOGY feature allows the VMM to provide topology information.
+ * Enabling the feature  eliminates topology-related #VEs: the TDX module
+ * virtualizes accesses to the CPUID leafs and the MSR.
+ *
+ * Enable ENUM_TOPOLOGY if it is available.
+ */
+static void enable_cpu_topology_enumeration(void)
+{
+	u64 configured;
+
+	/* Has the VMM provided a valid topology configuration? */
+	tdg_vm_rd(TDCS_TOPOLOGY_ENUM_CONFIGURED, &configured);
+	if (!configured) {
+		pr_err("VMM did not configure X2APIC_IDs properly\n");
+		return;
+	}
+
+	tdg_vm_wr(TDCS_TD_CTLS, TD_CTLS_ENUM_TOPOLOGY, TD_CTLS_ENUM_TOPOLOGY);
+}
+
 static void tdx_setup(u64 *cc_mask)
 {
 	struct tdx_module_args args = {};
@@ -280,6 +306,7 @@ static void tdx_setup(u64 *cc_mask)
 	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
 
 	disable_sept_ve(td_attr);
+	enable_cpu_topology_enumeration();
 }
 
 /*
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index fecb2a6e864b..89f7fcade8ae 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -23,12 +23,14 @@
 #define TDCS_CONFIG_FLAGS		0x1110000300000016
 #define TDCS_TD_CTLS			0x1110000300000017
 #define TDCS_NOTIFY_ENABLES		0x9100000000000010
+#define TDCS_TOPOLOGY_ENUM_CONFIGURED	0x9100000000000019
 
 /* TDCS_CONFIG_FLAGS bits */
 #define TDCS_CONFIG_FLEXIBLE_PENDING_VE	BIT_ULL(1)
 
 /* TDCS_TD_CTLS bits */
 #define TD_CTLS_PENDING_VE_DISABLE	BIT_ULL(0)
+#define TD_CTLS_ENUM_TOPOLOGY		BIT_ULL(1)
 
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
-- 
2.43.0


