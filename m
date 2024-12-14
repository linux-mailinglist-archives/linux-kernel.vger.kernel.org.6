Return-Path: <linux-kernel+bounces-446081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D173F9F1F9F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 16:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB488167854
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 15:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE33194AEE;
	Sat, 14 Dec 2024 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9psPDzN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77B0199FA4
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734189399; cv=none; b=u87KwcT8mShbEgHGRUozyTxKPwyj5mlnRTBk9HYRPS2qXAQtgeadGrBu5eyljp816Evdxt06eruWaGBMU882rQAmKgzGxHG01zKSUE06v01ECMeyvkl+IDALc4pQe7/uLpf15OfD1u5X3CY2tuGVMd6Y/xBLoqGeh7vAvUlm5JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734189399; c=relaxed/simple;
	bh=/2pVLCoro9y1+4wg4uZt9uImZoxVNxSa4uu1CRnd658=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkZJwU5d3Xphux/wWaaeifOQKWcnJjrqU9Bzyq/ORhvFl9i4XvXhsNxZ0zRT+tOZQyJ2/YI0l+vEQWU+/tuqf4MJqumHUCXvuojy8TbzOdTvQPP3olP287nvmQf1f+5bijCxjjNaCa9MCfnHTgavggjGwyYkvArESgxdJupUWRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G9psPDzN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734189398; x=1765725398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/2pVLCoro9y1+4wg4uZt9uImZoxVNxSa4uu1CRnd658=;
  b=G9psPDzNt5l26Y/pF3S66Uc7QbeaOSvFz7ryLYHCR5HZPrny+ZiLzQaV
   3CMJeDjqXtTj1XWeMBJ/e8hS5RkuEKgl5uO8J7F8McAONa4AmlUuGyDmJ
   Sxta62cJXsWzAe1b7t1Hz+BBsE1/wG4w7ob/Nz+i+werqyH6ahH27d3Md
   m6Fz2H8vS7Kwdr30D0GEkizthlDdHQAZ0UdO7EzimJX64EYyy5//4YBRa
   nSayMldaqY18UzaB+WeTvAMjyRrssh1bPrcUCTYAToI9iH0d581xqnMd/
   HP0VOW88/um1C++vdyZVYmDm9BGauzVosroN/plJaF16qGEUdsdGlpkUy
   w==;
X-CSE-ConnectionGUID: oKeddqmmSnSAVhhFL2JAHQ==
X-CSE-MsgGUID: FLTNZU7GSC2W50qo7ESngw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45109898"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45109898"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 07:16:37 -0800
X-CSE-ConnectionGUID: qbyUObKITUu8u2/Wmua4JA==
X-CSE-MsgGUID: DoSNNkVkScaJc8lfVdKrJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120050172"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.223.200])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 07:16:25 -0800
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
Subject: [PATCH v9 3/6] x86/virt/tdx: Use auto-generated code to read global metadata
Date: Sun, 15 Dec 2024 04:15:44 +1300
Message-ID: <cbe3f12b1e5479399b53f4873f2ff783d9fc669b.1734188033.git.kai.huang@intel.com>
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

From: Paolo Bonzini <pbonzini@redhat.com>

The TDX module provides a set of "Global Metadata Fields".  They report
things like TDX module version, supported features, and fields related
to create/run TDX guests and so on.

Currently the kernel only reads "TD Memory Region" (TDMR) related fields
for module initialization.  There are needs to read more global metadata
fields for future use:

 - Supported features ("TDX_FEATURES0") to fail module initialization
   when the module doesn't support "not clobbering host RBP when exiting
   from TDX guest" feature [1].
 - KVM TDX baseline support and other features like TDX Connect will
   need to read more.

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
file as part of TDX spec [2].  JSON format is machine readable.  Instead
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
     sub-structures in 'tdx_global_metadata.h'.

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
the aforesaid metadata field "TDX_FEATURES0".

The tdx_global_metadata.{hc} can be generated by running below:

 #python tdx_global_metadata.py global_metadata.json \
	tdx_global_metadata.h tdx_global_metadata.c

.. where the 'global_metadata.json' can be fetched from [2] and the
'tdx_global_metadata.py' can be found from [3].

Link: https://lore.kernel.org/fc0e8ab7-86d4-4428-be31-82e1ece6dd21@intel.com/ [1]
Link: https://cdrdv2.intel.com/v1/dl/getContent/795381 [2]
Link: https://lore.kernel.org/762a50133300710771337398284567b299a86f67.camel@intel.com/ [3]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Co-developed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
v8 -> v9:
 - Remove CMR reading code and update changelog accordingly.

---
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 48 +++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.h | 25 +++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 arch/x86/virt/vmx/tdx/tdx_global_metadata.c
 create mode 100644 arch/x86/virt/vmx/tdx/tdx_global_metadata.h

diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
new file mode 100644
index 000000000000..8027a24d1c6e
--- /dev/null
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -0,0 +1,48 @@
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
+static int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
+{
+	int ret = 0;
+
+	ret = ret ?: get_tdx_sys_info_features(&sysinfo->features);
+	ret = ret ?: get_tdx_sys_info_tdmr(&sysinfo->tdmr);
+
+	return ret;
+}
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.h b/arch/x86/virt/vmx/tdx/tdx_global_metadata.h
new file mode 100644
index 000000000000..6dd3c9695f59
--- /dev/null
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.h
@@ -0,0 +1,25 @@
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
+struct tdx_sys_info {
+	struct tdx_sys_info_features features;
+	struct tdx_sys_info_tdmr tdmr;
+};
+
+#endif
-- 
2.47.1


