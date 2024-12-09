Return-Path: <linux-kernel+bounces-436856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 758469E8BB5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314E4281796
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 06:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A85214811;
	Mon,  9 Dec 2024 06:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2tNqYIA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D9D1D555
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 06:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733727033; cv=none; b=hPRyTmdSm81Eb6Pxbn/ZfkWAq/tzuMjt5G6Ib5do0oL1oRMu8+PUK7zID7C7oK18C1Pi54fEzncgtXRFquEm4ScaZNdAB8RrAGHrAYrsGAROWzQ9uCxtZmn1hUl8qAg/r0sVmlT0oVwS15C4AaMUJxfpKmORJ/1h45fJIeD2hGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733727033; c=relaxed/simple;
	bh=JcT3M6OwkyDnIyY3X5bFFx3N1gpJEfFcmUCrIOl3qG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D34fH+cxn1Am8qAk7yrVo8OrETpPgcI7uz121ot9umPUR7ERS7rU1uIhjkor0zk8PBVPi2JKMUMK1HYgAb+JM4pOhxbY71zNvwP0ZJT7uIxta7rHXMN0VUg6w6U1X0lYTFDFXGXJcrTaPbc/KoIkiytaOa7ggtPy9APr2QualB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2tNqYIA; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733727031; x=1765263031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JcT3M6OwkyDnIyY3X5bFFx3N1gpJEfFcmUCrIOl3qG8=;
  b=X2tNqYIAiFncpswruezFO53tN9XWuy3Af9aAhFw9ajTj4hPiHXQlXM3F
   VEslqRuqoUNDKeIX47/YtwxFveqiWg/XYbWxkbtx0Nt5X+TV3F863GiIK
   ROlBmznLTwbpFQeR+FE01O4StG0Z3zPVr06D0liY0saETWDiluXYpQL7A
   zSPRPnKJ32L5niVAzNrUqNTPRzL8yp7/pTO6Xph0b1VJ7AZIw7cs+ACOa
   tImLuoAAVg4gb9+63TLqb6smIilkBDo4Zk+jkXToH/yDm6LOCe7v9ZeH7
   yfvrIi0irTd3E8ooeMdeqfebRblWpu2T+hYsoE3lyhyx5CQ0WOsXNz4DK
   g==;
X-CSE-ConnectionGUID: Ptcpbv+hQtG6A1gi6wv6RQ==
X-CSE-MsgGUID: WMqR88PbRQa3nHFRsniDsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="56490562"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="56490562"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 22:50:30 -0800
X-CSE-ConnectionGUID: VQthq7xdQGirC1P1fKDkEg==
X-CSE-MsgGUID: WLaRjbfBS/yHOs9ME999JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="95181231"
Received: from hcaldwel-desk1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.221.132])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 22:50:25 -0800
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
Subject: [PATCH v8 8.2/9] x86/virt/tdx: Reduce TDMR's reserved areas by using CMRs to find memory holes
Date: Mon,  9 Dec 2024 19:50:16 +1300
Message-ID: <20241209065016.242359-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <23bb421e9bf5443a823e163fb2d899760d9f14a3.1731498635.git.kai.huang@intel.com>
References: <23bb421e9bf5443a823e163fb2d899760d9f14a3.1731498635.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A TDX module initialization failure was reported on an Emerald Rapids
platform [*]:

  virt/tdx: initialization failed: TDMR [0x0, 0x80000000): reserved areas exhausted.
  virt/tdx: module initialization failed (-28)

The kernel informs the TDX module of "TDX-usable memory regions" via the
structure "TD Memory Region" (TDMR).  Each TDMR contains a limited
number of "reserved areas" to inform the TDX module of the regions that
cannot be used by TDX.

The kernel builds the list of "TDX-usable memory regions" from memblock
(which reflects e820) and marks all memory holes as "reserved areas" in
TDMRs.  It turns out on some large systems the holes in memblock can be
too fine-grained [1] and exceed the number of reserved areas that the
module can track per TDMR, resulting in the failure mentioned above.

The TDX module also reports TDX-capable memory as "Convertible Memory
Regions" (CMRs).  CMRs tend to be coarser-grained [2] than the e820.
Use CMRs to find memory holes when populating reserved areas to reduce
their consumption.

Note the kernel does not prevent non-CMR memory from being added to
"TDX-usable memory regions" but depends on the TDX module to catch in
the TDH.SYS.CONFIG.  After switching to using CMRs to populate reserved
areas this will no longer work.  To ensure no non-CMR memory is included
in the TDMRs, verify that the memory region is truly TDX convertible
before adding it as a TDX-usable memory region at early stage.

[1] BIOS-E820 table of the problematic platform:

  BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
  BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reserved
  BIOS-e820: [mem 0x0000000000100000-0x000000005d168fff] usable
  BIOS-e820: [mem 0x000000005d169000-0x000000005d22afff] ACPI data
  BIOS-e820: [mem 0x000000005d22b000-0x000000005d3cefff] usable
  BIOS-e820: [mem 0x000000005d3cf000-0x000000005d469fff] reserved
  BIOS-e820: [mem 0x000000005d46a000-0x000000005e5b2fff] usable
  BIOS-e820: [mem 0x000000005e5b3000-0x000000005e5c2fff] reserved
  BIOS-e820: [mem 0x000000005e5c3000-0x000000005e5d2fff] usable
  BIOS-e820: [mem 0x000000005e5d3000-0x000000005e5e4fff] reserved
  BIOS-e820: [mem 0x000000005e5e5000-0x000000005eb57fff] usable
  BIOS-e820: [mem 0x000000005eb58000-0x0000000061357fff] ACPI NVS
  BIOS-e820: [mem 0x0000000061358000-0x000000006172afff] usable
  BIOS-e820: [mem 0x000000006172b000-0x0000000061794fff] ACPI data
  BIOS-e820: [mem 0x0000000061795000-0x00000000617fefff] usable
  BIOS-e820: [mem 0x00000000617ff000-0x0000000061912fff] ACPI data
  BIOS-e820: [mem 0x0000000061913000-0x0000000061998fff] usable
  BIOS-e820: [mem 0x0000000061999000-0x00000000619dffff] ACPI data
  BIOS-e820: [mem 0x00000000619e0000-0x00000000619e1fff] usable
  BIOS-e820: [mem 0x00000000619e2000-0x00000000619e9fff] reserved
  BIOS-e820: [mem 0x00000000619ea000-0x0000000061a26fff] usable
  BIOS-e820: [mem 0x0000000061a27000-0x0000000061baefff] ACPI data
  BIOS-e820: [mem 0x0000000061baf000-0x00000000623c2fff] usable
  BIOS-e820: [mem 0x00000000623c3000-0x0000000062471fff] reserved
  BIOS-e820: [mem 0x0000000062472000-0x0000000062823fff] usable
  BIOS-e820: [mem 0x0000000062824000-0x0000000063a24fff] reserved
  BIOS-e820: [mem 0x0000000063a25000-0x0000000063d57fff] usable
  BIOS-e820: [mem 0x0000000063d58000-0x0000000064157fff] reserved
  BIOS-e820: [mem 0x0000000064158000-0x0000000064158fff] usable
  BIOS-e820: [mem 0x0000000064159000-0x0000000064194fff] reserved
  BIOS-e820: [mem 0x0000000064195000-0x000000006e9cefff] usable
  BIOS-e820: [mem 0x000000006e9cf000-0x000000006eccefff] reserved
  BIOS-e820: [mem 0x000000006eccf000-0x000000006f6fefff] ACPI NVS
  BIOS-e820: [mem 0x000000006f6ff000-0x000000006f7fefff] ACPI data
  BIOS-e820: [mem 0x000000006f7ff000-0x000000006f7fffff] usable
  BIOS-e820: [mem 0x000000006f800000-0x000000008fffffff] reserved
  ......

[2] Convertible Memory Regions of the problematic platform:

  virt/tdx: CMR: [0x100000, 0x6f800000)
  virt/tdx: CMR: [0x100000000, 0x107a000000)
  virt/tdx: CMR: [0x1080000000, 0x207c000000)
  virt/tdx: CMR: [0x2080000000, 0x307c000000)
  virt/tdx: CMR: [0x3080000000, 0x407c000000)

Link: https://github.com/canonical/tdx/issues/135 [*]
Fixes: dde3b60d572c ("x86/virt/tdx: Designate reserved areas for all TDMRs")
Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---

v8.1 -> v8.2:
 - Trim down the changelog and comments. (Dave)

---
 arch/x86/virt/vmx/tdx/tdx.c | 74 ++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 18 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 5e6d8021681d..5c6a743de333 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -176,6 +176,23 @@ int tdx_cpu_enable(void)
 }
 EXPORT_SYMBOL_GPL(tdx_cpu_enable);
 
+/* Check whether a given memory region is a sub-region of any CMR. */
+static bool is_cmr_sub_region(unsigned long start_pfn, unsigned long end_pfn,
+			      struct tdx_sys_info_cmr *sysinfo_cmr)
+{
+	int i;
+
+	for (i = 0; i < sysinfo_cmr->num_cmrs; i++) {
+		u64 cmr_base_pfn = sysinfo_cmr->cmr_base[i] >> PAGE_SHIFT;
+		u64 cmr_npages = sysinfo_cmr->cmr_size[i] >> PAGE_SHIFT;
+
+		if (start_pfn >= cmr_base_pfn &&
+				end_pfn <= (cmr_base_pfn + cmr_npages))
+			return true;
+	}
+
+	return false;
+}
 /*
  * Add a memory region as a TDX memory block.  The caller must make sure
  * all memory regions are added in address ascending order and don't
@@ -218,7 +235,8 @@ static void free_tdx_memlist(struct list_head *tmb_list)
  * ranges off in a secondary structure because memblock is modified
  * in memory hotplug while TDX memory regions are fixed.
  */
-static int build_tdx_memlist(struct list_head *tmb_list)
+static int build_tdx_memlist(struct list_head *tmb_list,
+			     struct tdx_sys_info_cmr *sysinfo_cmr)
 {
 	unsigned long start_pfn, end_pfn;
 	int i, nid, ret;
@@ -234,6 +252,18 @@ static int build_tdx_memlist(struct list_head *tmb_list)
 		if (start_pfn >= end_pfn)
 			continue;
 
+		/*
+		 * Make sure the to-be-added memory region is truly TDX
+		 * convertible.  This ensures no non-TDX convertible
+		 * memory can end up to page allocator.
+		 */
+		if (!is_cmr_sub_region(start_pfn, end_pfn, sysinfo_cmr)) {
+			pr_err("memory region [0x%lx, 0x%lx) is not TDX convertible memory.\n",
+					PHYS_PFN(start_pfn), PHYS_PFN(end_pfn));
+			ret = -EINVAL;
+			goto err;
+		}
+
 		/*
 		 * Add the memory regions as TDX memory.  The regions in
 		 * memblock has already guaranteed they are in address
@@ -733,29 +763,28 @@ static int tdmr_add_rsvd_area(struct tdmr_info *tdmr, int *p_idx, u64 addr,
 }
 
 /*
- * Go through @tmb_list to find holes between memory areas.  If any of
+ * Go through all CMRs in @sysinfo_cmr to find memory holes.  If any of
  * those holes fall within @tdmr, set up a TDMR reserved area to cover
  * the hole.
  */
-static int tdmr_populate_rsvd_holes(struct list_head *tmb_list,
+static int tdmr_populate_rsvd_holes(struct tdx_sys_info_cmr *sysinfo_cmr,
 				    struct tdmr_info *tdmr,
 				    int *rsvd_idx,
 				    u16 max_reserved_per_tdmr)
 {
-	struct tdx_memblock *tmb;
 	u64 prev_end;
-	int ret;
+	int i, ret;
 
 	/*
 	 * Start looking for reserved blocks at the
 	 * beginning of the TDMR.
 	 */
 	prev_end = tdmr->base;
-	list_for_each_entry(tmb, tmb_list, list) {
+	for (i = 0; i < sysinfo_cmr->num_cmrs; i++) {
 		u64 start, end;
 
-		start = PFN_PHYS(tmb->start_pfn);
-		end   = PFN_PHYS(tmb->end_pfn);
+		start = sysinfo_cmr->cmr_base[i];
+		end   = start + sysinfo_cmr->cmr_size[i];
 
 		/* Break if this region is after the TDMR */
 		if (start >= tdmr_end(tdmr))
@@ -856,16 +885,16 @@ static int rsvd_area_cmp_func(const void *a, const void *b)
 
 /*
  * Populate reserved areas for the given @tdmr, including memory holes
- * (via @tmb_list) and PAMTs (via @tdmr_list).
+ * (via @sysinfo_cmr) and PAMTs (via @tdmr_list).
  */
 static int tdmr_populate_rsvd_areas(struct tdmr_info *tdmr,
-				    struct list_head *tmb_list,
+				    struct tdx_sys_info_cmr *sysinfo_cmr,
 				    struct tdmr_info_list *tdmr_list,
 				    u16 max_reserved_per_tdmr)
 {
 	int ret, rsvd_idx = 0;
 
-	ret = tdmr_populate_rsvd_holes(tmb_list, tdmr, &rsvd_idx,
+	ret = tdmr_populate_rsvd_holes(sysinfo_cmr, tdmr, &rsvd_idx,
 			max_reserved_per_tdmr);
 	if (ret)
 		return ret;
@@ -884,10 +913,10 @@ static int tdmr_populate_rsvd_areas(struct tdmr_info *tdmr,
 
 /*
  * Populate reserved areas for all TDMRs in @tdmr_list, including memory
- * holes (via @tmb_list) and PAMTs.
+ * holes (via @sysinfo_cmr) and PAMTs.
  */
 static int tdmrs_populate_rsvd_areas_all(struct tdmr_info_list *tdmr_list,
-					 struct list_head *tmb_list,
+					 struct tdx_sys_info_cmr *sysinfo_cmr,
 					 u16 max_reserved_per_tdmr)
 {
 	int i;
@@ -896,7 +925,7 @@ static int tdmrs_populate_rsvd_areas_all(struct tdmr_info_list *tdmr_list,
 		int ret;
 
 		ret = tdmr_populate_rsvd_areas(tdmr_entry(tdmr_list, i),
-				tmb_list, tdmr_list, max_reserved_per_tdmr);
+				sysinfo_cmr, tdmr_list, max_reserved_per_tdmr);
 		if (ret)
 			return ret;
 	}
@@ -911,7 +940,8 @@ static int tdmrs_populate_rsvd_areas_all(struct tdmr_info_list *tdmr_list,
  */
 static int construct_tdmrs(struct list_head *tmb_list,
 			   struct tdmr_info_list *tdmr_list,
-			   struct tdx_sys_info_tdmr *sysinfo_tdmr)
+			   struct tdx_sys_info_tdmr *sysinfo_tdmr,
+			   struct tdx_sys_info_cmr *sysinfo_cmr)
 {
 	u16 pamt_entry_size[TDX_PS_NR] = {
 		sysinfo_tdmr->pamt_4k_entry_size,
@@ -928,7 +958,14 @@ static int construct_tdmrs(struct list_head *tmb_list,
 	if (ret)
 		return ret;
 
-	ret = tdmrs_populate_rsvd_areas_all(tdmr_list, tmb_list,
+	/*
+	 * On some large systems, the TDX memory blocks (which reflects
+	 * e820) in the first 1GB can be too fine-grained.  Using them
+	 * to populate reserved areas may result in reserved areas being
+	 * exhausted.  CMRs are coarser-grained than e820.  Use CMRs to
+	 * populate reserved areas to reduce their consumption.
+	 */
+	ret = tdmrs_populate_rsvd_areas_all(tdmr_list, sysinfo_cmr,
 			sysinfo_tdmr->max_reserved_per_tdmr);
 	if (ret)
 		tdmrs_free_pamt_all(tdmr_list);
@@ -1107,7 +1144,7 @@ static int init_tdx_module(void)
 	 */
 	get_online_mems();
 
-	ret = build_tdx_memlist(&tdx_memlist);
+	ret = build_tdx_memlist(&tdx_memlist, &sysinfo.cmr);
 	if (ret)
 		goto out_put_tdxmem;
 
@@ -1117,7 +1154,8 @@ static int init_tdx_module(void)
 		goto err_free_tdxmem;
 
 	/* Cover all TDX-usable memory regions in TDMRs */
-	ret = construct_tdmrs(&tdx_memlist, &tdx_tdmr_list, &sysinfo.tdmr);
+	ret = construct_tdmrs(&tdx_memlist, &tdx_tdmr_list, &sysinfo.tdmr,
+			&sysinfo.cmr);
 	if (ret)
 		goto err_free_tdmrs;
 
-- 
2.47.1


