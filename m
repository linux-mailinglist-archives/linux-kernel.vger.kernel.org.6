Return-Path: <linux-kernel+bounces-433257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B63009E55A9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72CEB18836E7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD3D21885B;
	Thu,  5 Dec 2024 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLVsduKo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1713B218821
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733402432; cv=none; b=YCkBWkUdCple6ueBSlCt04491L089rajJBdFColumh4KchV7V+n5mcuQDOOAQYbjSlBFiZJmvp32lfRrIaUtCSYdfiIBNJwZb5p/gzdV61hs4jT66QJ37U1o/cpwLWRaNHJz+AfE3Q+ipRbeKQm3LPkMcB0x66I+ksLFeWJvmss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733402432; c=relaxed/simple;
	bh=5yLkt0RUeNhkU0iaF89JhfTvVz9A2WNLa9C6pt7CWGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nn7TqL40Gpi5dlZUkoFaZ/RrkxWycWqZ1Zb7ud/fC3QbaXiJm74AjrA65BHnE/43tTR5GL1PC55TH0zkngCsFWX2MefEVm0b3bYqwzGC3HJXD4TNIOyRSD4uc706aGhHBS9xhgUqiGRVufKKNpfRZ/Y3RfDTiaUwedu5iUR1G0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLVsduKo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733402429; x=1764938429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5yLkt0RUeNhkU0iaF89JhfTvVz9A2WNLa9C6pt7CWGk=;
  b=gLVsduKofEkVmbykj7uVLBd5ooXcjn5a3tphsQ+G306WmwWSHYcJR5mD
   UXFPZjFEkr0flApC7pAbnHFJMQ+0erfY4HCV+2H0AvrdKrH5+OyepXxii
   t000jadqQR9O6TF1K0ligLrUJvxosb4y9eVlHGZ22xHjLYEOnQNA2J4tp
   dhpLaST1e+HyaIfm8CYEuQYjvr3FltH1/t/m416c3Q3K1zIpg20eZ+FXI
   bCzO2yVa59lgRlVpANoOM+pl1R/42nydhmzTTV1li8a0o9F0sq/wey4dX
   lmT6a2f8Iao3UZFwNCsMHQVtUPFOb89eVgVzNMLv0UXiS1QCqpQkABvgw
   g==;
X-CSE-ConnectionGUID: 5DgOYbSRQD2gncvO6cEwQQ==
X-CSE-MsgGUID: 3qocdiA9Q36G+iUakmoyTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="37494849"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="37494849"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 04:40:28 -0800
X-CSE-ConnectionGUID: QbZ6NuukSFyXq3O7yS4hcg==
X-CSE-MsgGUID: G95DyFJdSMizXsyFhVS6Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="94523058"
Received: from lbogdanm-mobl3.ger.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.220.83])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 04:40:20 -0800
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
Subject: [PATCH v8 8.1/9] x86/virt/tdx: Reduce TDMR's reserved areas by using CMRs to find memory holes
Date: Fri,  6 Dec 2024 01:40:05 +1300
Message-ID: <20241205124005.92615-1-kai.huang@intel.com>
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

A TDX module initialization failure was reported on a Emerald Rapids
platform [*]:

  virt/tdx: initialization failed: TDMR [0x0, 0x80000000): reserved areas exhausted.
  virt/tdx: module initialization failed (-28)

As part of initializing the TDX module, the kernel informs the TDX
module of all "TDX-usable memory regions" using an array of TDX defined
structure "TD Memory Region" (TDMR).  Each TDMR must be in 1GB aligned
and in 1GB granularity, and all "non-TDX-usable memory holes" within a
given TDMR are marked as "reserved areas".  The TDX module reports a
maximum number of reserved areas that can be supported per TDMR (16).

The kernel builds the "TDX-usable memory regions" based on memblocks
(which reflects e820), and uses this list to find all "reserved areas"
for each TDMR.

It turns out that the kernel's view of memory holes is too fine grained
and sometimes exceeds the number of holes that the TDX module can track
per TDMR [1], resulting in the above failure.

Thankfully the module also lists memory that is potentially convertible
in a list of "Convertible Memory Regions" (CMRs).  That coarser grained
CMR list tends to track usable memory in the memory map even if it might
be reserved for host usage like 'ACPI data' [2].

Use that list to relax what the kernel considers unusable memory.  If it
falls in a CMR no need to instantiate a hole, and rely on the kernel to
keep what it considers 'reserved' out of the page allocator.

Currently, the kernel does not explicitly check all TDX-usable memory
regions (that come from memblock) to be truly TDX convertible (not
feasible w/o CMRs anyway) but depends on the TDH.SYS.CONFIG to fail if
there's any non-CMR memory region ended up as TDX-usable memory.

After changing to using CMRs to fill up reserved areas, unfortunately
the TDH.SYS.CONFIG will no longer be able to catch such non-CMR regions.
This is because any non-CMR region will always end up with reserved
area even if it is included in TDX-usable memory regions.

To still make sure of that, explicitly check all TDX-usable memory
regions are truly TDX convertible against CMRs when stashing them from
the memblocks.

Also print an error message if any region is non-CMR so the users can
easily know the reason of the failure.  This is nice to have anyway
because a clear message is better than having to decipher the error code
of the TDH.SYS.CONFIG.

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

v8 -> v8.1:
 - Add code to explicitly check TDX memory blocks against CMRs at early
   stage since TDH.SYS.CONFIG can no longer catch any non-CMR region in
   TDX memory blocks.

---
 arch/x86/virt/vmx/tdx/tdx.c | 85 +++++++++++++++++++++++++++++--------
 1 file changed, 67 insertions(+), 18 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 5e6d8021681d..687a0d520785 100644
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
@@ -234,6 +252,27 @@ static int build_tdx_memlist(struct list_head *tmb_list)
 		if (start_pfn >= end_pfn)
 			continue;
 
+		/*
+		 * Make sure the to-be-added memory region is truly TDX
+		 * convertible memory.
+		 *
+		 * Note:
+		 *
+		 * The to-be-added memory region here doesn't cross NUMA
+		 * nodes.  The check here assumes the memory region does
+		 * not cross any adjacent CMRs which are contiguous
+		 * (i.e., the end of the first CMR is the start of the
+		 * next) _AND_ are in the same NUMA node.  A sane BIOS
+		 * should never report memory regions and CMRs in such
+		 * way.
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
@@ -733,29 +772,28 @@ static int tdmr_add_rsvd_area(struct tdmr_info *tdmr, int *p_idx, u64 addr,
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
@@ -856,16 +894,16 @@ static int rsvd_area_cmp_func(const void *a, const void *b)
 
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
@@ -884,10 +922,10 @@ static int tdmr_populate_rsvd_areas(struct tdmr_info *tdmr,
 
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
@@ -896,7 +934,7 @@ static int tdmrs_populate_rsvd_areas_all(struct tdmr_info_list *tdmr_list,
 		int ret;
 
 		ret = tdmr_populate_rsvd_areas(tdmr_entry(tdmr_list, i),
-				tmb_list, tdmr_list, max_reserved_per_tdmr);
+				sysinfo_cmr, tdmr_list, max_reserved_per_tdmr);
 		if (ret)
 			return ret;
 	}
@@ -911,7 +949,8 @@ static int tdmrs_populate_rsvd_areas_all(struct tdmr_info_list *tdmr_list,
  */
 static int construct_tdmrs(struct list_head *tmb_list,
 			   struct tdmr_info_list *tdmr_list,
-			   struct tdx_sys_info_tdmr *sysinfo_tdmr)
+			   struct tdx_sys_info_tdmr *sysinfo_tdmr,
+			   struct tdx_sys_info_cmr *sysinfo_cmr)
 {
 	u16 pamt_entry_size[TDX_PS_NR] = {
 		sysinfo_tdmr->pamt_4k_entry_size,
@@ -928,7 +967,16 @@ static int construct_tdmrs(struct list_head *tmb_list,
 	if (ret)
 		return ret;
 
-	ret = tdmrs_populate_rsvd_areas_all(tdmr_list, tmb_list,
+	/*
+	 * Use CMRs instead of the TDX memory blocks to populate the
+	 * reserved areas to reduce consumption of reserved areas for
+	 * each TDMR.  On some large systems (e.g., a machine with 4 or
+	 * more sockets), the BIOS may report many usable memory regions
+	 * in the first 1GB in e820.  This may result in reserved areas
+	 * of the first TDMR being exhausted if TDX memory blocks are
+	 * used to fill up reserved areas.
+	 */
+	ret = tdmrs_populate_rsvd_areas_all(tdmr_list, sysinfo_cmr,
 			sysinfo_tdmr->max_reserved_per_tdmr);
 	if (ret)
 		tdmrs_free_pamt_all(tdmr_list);
@@ -1107,7 +1155,7 @@ static int init_tdx_module(void)
 	 */
 	get_online_mems();
 
-	ret = build_tdx_memlist(&tdx_memlist);
+	ret = build_tdx_memlist(&tdx_memlist, &sysinfo.cmr);
 	if (ret)
 		goto out_put_tdxmem;
 
@@ -1117,7 +1165,8 @@ static int init_tdx_module(void)
 		goto err_free_tdxmem;
 
 	/* Cover all TDX-usable memory regions in TDMRs */
-	ret = construct_tdmrs(&tdx_memlist, &tdx_tdmr_list, &sysinfo.tdmr);
+	ret = construct_tdmrs(&tdx_memlist, &tdx_tdmr_list, &sysinfo.tdmr,
+			&sysinfo.cmr);
 	if (ret)
 		goto err_free_tdmrs;
 
-- 
2.47.1


