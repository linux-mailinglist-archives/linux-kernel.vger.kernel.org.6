Return-Path: <linux-kernel+bounces-407517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3389C6E88
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2E91F22418
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2742203713;
	Wed, 13 Nov 2024 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9ICyg5I"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334032036EE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499060; cv=none; b=HJoWVNguQPJoqhXaqGjlUQWA4HmciVfpYWfXLkHEwOD/I8ausi9lU8IVgi1XnHLdYbnXgUAMBh334kDQOm6aI6UAwPWKxUnsedDtuqtuz5+Ti2/JYw3LcVysxGNnfAXqACnlJO7i2KNDekq1CkTCZtOFY1UyIFwpUjd37Q6ohlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499060; c=relaxed/simple;
	bh=JEDK7ta3K0FU0YQnUWYRWixX3/2EbunC/RZ35RWmBl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imhA4MeCL9vOcHKSPHSW0+eMCHfuDiOafm9JeQK7Ou3yDFx1qL96UsW5SVKoRLmGL5y96BC+ffoyjDWsSNBxcTrJ+yVGiRdBRkiuodaAoa198kdD5QkyPJwBUFLgpiHtAzkczGk1ttmz3/FWXIqe1ZJUA9hAWIin2d69c4kdxV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9ICyg5I; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731499058; x=1763035058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JEDK7ta3K0FU0YQnUWYRWixX3/2EbunC/RZ35RWmBl4=;
  b=h9ICyg5IRFW0/qUDaBJkvK/wFlLtEzNit4kk9PA/VQQ5xYDcljyTHxHd
   4jtOD4HsWRBTG1QCANmfU+ANREtXPxrxLb6Ee9Q9OjJ2wRtqYUo831E8h
   xYhm1h2f9l7cG1P3BzvOX+vSSoye/5spgVMMeUN5iNrf62daZvei+X9gu
   xdGF+lkIjVsn4G5jhmjOMBdYFn23YthdDqmGOxrETOVfEfQ+wstzwF1an
   BWaXaNs3UqBTfCDoy4umSq7ZWcxuBRPVqLZJ62WSX5vD1QfXaLbSwvYet
   r1JBqrviUw1BZWDVG8+OwZ6VWMnRwaAKC8VKd7Ej9wAehCAV9FpBba3oX
   A==;
X-CSE-ConnectionGUID: T5E5kW/7TS252ApYf0hU1Q==
X-CSE-MsgGUID: Y4jGBrLqTT6XnU/OPDqSeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31630766"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="31630766"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 03:57:38 -0800
X-CSE-ConnectionGUID: mY3H5QyLRD+6sE2eAPpI9Q==
X-CSE-MsgGUID: 6t5h6CUBQbiPf7v5TUb1vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="92323500"
Received: from daliomra-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.220.169])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 03:57:34 -0800
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
Subject: [PATCH v8 3/9] x86/virt/tdx: Use auto-generated code to read global metadata
Date: Thu, 14 Nov 2024 00:57:08 +1300
Message-ID: <daace74503d012cadd2e0b9c06ea39f60e0c2ad5.1731498635.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1731498635.git.kai.huang@intel.com>
References: <cover.1731498635.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Bonzini <pbonzini@redhat.com>

The TDX module provides a set of "Global Metadata Fields".  They report
things like TDX module version, supported features, and fields related
to create/run TDX guests and so on.

Currently the kernel only reads "TD Memory Region" (TDMR) related fields
for module initialization.  There are needs to read more global metadata
fields to address two issues in the current module initialization code:

 - "Convertible Memory Regions" (CMRs) to fix a potential module
   initialization failure on some large systems [1].
 - Supported features ("TDX_FEATURES0") to fail module initialization
   when the module doesn't support "not clobbering host RBP when exiting
   from TDX guest" feature [2].

Future changes to support KVM TDX and other features like TDX Connect
will need to read more.

The current global metadata reading code has limitations (e.g., it only
has a primitive helper to read metadata field with 16-bit element size,
while TDX supports 8/16/32/64 bits metadata element sizes).  It needs
tweaks in order to read more metadata fields.

But even with the tweaks, when new code is added to read a new field,
the reviewers will still need to review against the spec to make sure
the new code doesn't screw up things like using the wrong metadata
field ID (each metadata field is associated with a unique field ID,
which is a TDX-defined u64 constant) etc.

TDX documents all global metadata fields in a 'global_metadata.json'
file as part of TDX spec [3].  JSON format is machine readable.  Instead
of tweaking the metadata reading code, use a script to generate the code
so that:

  1) Using the generated C is simple.
  2) Adding a field is simple, e.g., the script just pulls the field ID
     out of the JSON for a given field thus no manual review is needed.

Specifically, to match the layout of the 'struct tdx_sys_info' and its
sub-structures, the script uses a table with each entry containing the
the name of the sub-structures (which reflects the "Class") and the
"Field Name" of all its fields, and auto-generate:

  1) The 'struct tdx_sys_info' and all 'struct tdx_sys_info_xx'
     sub-structures in 'tdx_global_metadata.h'

  2) The main function 'get_tdx_sys_info()' which reads all metadata to
     'struct tdx_sys_info' and the 'get_tdx_sys_info_xx()' functions
     which read 'struct tdx_sys_info_xx()' in 'tdx_global_metadata.c'.

Using the generated C is simple: 1) include "tdx_global_metadata.h" to
the local "tdx.h"; 2) explicitly include "tdx_global_metadata.c" to the
local "tdx.c" after the read_sys_metadata_field() primitive (which is a
wrapper of TDH.SYS.RD SEAMCALL to read global metadata).

Adding a field is also simple: 1) just add the new field to an existing
structure, or add it with a new structure; 2) re-run the script to
generate the new code; 3) update the existing tdx_global_metadata.{hc}
with the new ones.

For now, use the auto-generated code to read the TDMR related fields and
the aforesaid metadata fields: "TDX_FEATURES0" and CMRs.

Reading CMRs is more complicated than reading a simple field, since
there are two arrays containing the "CMR_BASE" and "CMR_SIZE" for each
CMR respectively.

TDX spec [3] section "Metadata Access Interface", sub-section "Arrays of
Metadata Fields" defines the way to read metadata fields in an array.
There's a "Base field ID" (say, X) for the array and the field ID for
entry array[i] is X + i.

For CMRs, the field "NUM_CMRS" reports the number of CMR entries that
can be read, and the code needs to use the value reported via "NUM_CMRS"
to loop despite the JSON file says the "Num Fields" of both "CMR_BASE"
and "CMR_SIZE" are 32.

The tdx_global_metadata.{hc} can be generated by running below:

 #python tdx_global_metadata.py global_metadata.json \
	tdx_global_metadata.h tdx_global_metadata.c

.. where the 'tdx_global_metadata.py' can be found in [4] and the
'global_metadata.json' can be fetched from [3].

Link: https://github.com/canonical/tdx/issues/135 [1]
Link: https://lore.kernel.org/fc0e8ab7-86d4-4428-be31-82e1ece6dd21@intel.com/ [2]
Link: https://cdrdv2.intel.com/v1/dl/getContent/795381 [3]
Link: https://lore.kernel.org/d5aed06ae4b46df5db97fdbac9c01843920a2f96.camel@intel.com/ [4]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Co-developed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 67 +++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.h | 32 ++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 arch/x86/virt/vmx/tdx/tdx_global_metadata.c
 create mode 100644 arch/x86/virt/vmx/tdx/tdx_global_metadata.h

diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
new file mode 100644
index 000000000000..42ad62762b14
--- /dev/null
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Automatically generated functions to read TDX global metadata.
+ *
+ * This file doesn't compile on its own as it lacks of inclusion
+ * of SEAMCALL wrapper primitive which reads global metadata.
+ * Include this file to other C file instead.
+ */
+
+static int get_tdx_sys_info_features(struct tdx_sys_info_features *sysinfo_features)
+{
+	int ret = 0;
+	u64 val;
+
+	if (!ret && !(ret = read_sys_metadata_field(0x0A00000300000008, &val)))
+		sysinfo_features->tdx_features0 = val;
+
+	return ret;
+}
+
+static int get_tdx_sys_info_tdmr(struct tdx_sys_info_tdmr *sysinfo_tdmr)
+{
+	int ret = 0;
+	u64 val;
+
+	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000008, &val)))
+		sysinfo_tdmr->max_tdmrs = val;
+	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000009, &val)))
+		sysinfo_tdmr->max_reserved_per_tdmr = val;
+	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000010, &val)))
+		sysinfo_tdmr->pamt_4k_entry_size = val;
+	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000011, &val)))
+		sysinfo_tdmr->pamt_2m_entry_size = val;
+	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000012, &val)))
+		sysinfo_tdmr->pamt_1g_entry_size = val;
+
+	return ret;
+}
+
+static int get_tdx_sys_info_cmr(struct tdx_sys_info_cmr *sysinfo_cmr)
+{
+	int ret = 0;
+	u64 val;
+	int i;
+
+	if (!ret && !(ret = read_sys_metadata_field(0x9000000100000000, &val)))
+		sysinfo_cmr->num_cmrs = val;
+	for (i = 0; i < sysinfo_cmr->num_cmrs; i++)
+		if (!ret && !(ret = read_sys_metadata_field(0x9000000300000080 + i, &val)))
+			sysinfo_cmr->cmr_base[i] = val;
+	for (i = 0; i < sysinfo_cmr->num_cmrs; i++)
+		if (!ret && !(ret = read_sys_metadata_field(0x9000000300000100 + i, &val)))
+			sysinfo_cmr->cmr_size[i] = val;
+
+	return ret;
+}
+
+static int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
+{
+	int ret = 0;
+
+	ret = ret ?: get_tdx_sys_info_features(&sysinfo->features);
+	ret = ret ?: get_tdx_sys_info_tdmr(&sysinfo->tdmr);
+	ret = ret ?: get_tdx_sys_info_cmr(&sysinfo->cmr);
+
+	return ret;
+}
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.h b/arch/x86/virt/vmx/tdx/tdx_global_metadata.h
new file mode 100644
index 000000000000..1fe4b513021f
--- /dev/null
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Automatically generated TDX global metadata structures. */
+#ifndef _X86_VIRT_TDX_AUTO_GENERATED_TDX_GLOBAL_METADATA_H
+#define _X86_VIRT_TDX_AUTO_GENERATED_TDX_GLOBAL_METADATA_H
+
+#include <linux/types.h>
+
+struct tdx_sys_info_features {
+	u64 tdx_features0;
+};
+
+struct tdx_sys_info_tdmr {
+	u16 max_tdmrs;
+	u16 max_reserved_per_tdmr;
+	u16 pamt_4k_entry_size;
+	u16 pamt_2m_entry_size;
+	u16 pamt_1g_entry_size;
+};
+
+struct tdx_sys_info_cmr {
+	u16 num_cmrs;
+	u64 cmr_base[32];
+	u64 cmr_size[32];
+};
+
+struct tdx_sys_info {
+	struct tdx_sys_info_features features;
+	struct tdx_sys_info_tdmr tdmr;
+	struct tdx_sys_info_cmr cmr;
+};
+
+#endif
-- 
2.46.2


