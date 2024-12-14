Return-Path: <linux-kernel+bounces-446078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB5F9F1F99
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 16:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA2857A06E5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 15:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D699199EA2;
	Sat, 14 Dec 2024 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqd1S7z2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A4A18AE2
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734189379; cv=none; b=Hiimqv1sRWUhzlSYxtR8L6+/9R3+5e76kRGAppMy59pjC1jbRgPQfkx188Js21MVYZNsDQxlxqT1aZ6GMHcR1vpAVikVqjB9cTvGZnVU0XJw1ciDYi0nzZVjhCVma/A4QmJHfewVcc3wUVFLeoqQssMnFTRcIj9XtgCKAz+qvQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734189379; c=relaxed/simple;
	bh=owQmkqaLRIE9GeiR0sm2qoSY/RWQT987XFzzAtkcayY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2YNF/TMeOdM42wwlemfuI8zZS8iA7BHEyAa26m89ZdXGUQhXcqoobgyxBAQOnC1xdUUjqc5idgpXqX/I/AyLXAh3AQmgMlwGi/ywjt6pEnidrO/7asMi4l7PruzsKedx/hSjTTiuh0Y9lHWLxXC64F6KjOD4qZqzWM5e/QanN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fqd1S7z2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734189378; x=1765725378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=owQmkqaLRIE9GeiR0sm2qoSY/RWQT987XFzzAtkcayY=;
  b=fqd1S7z2FVKauwVujV4cJICSpMzT4roAHyqkGzWThPBJKbofwxtA97Yz
   ryMIgud5OSaVCeT4ZgABmI4SWmHjYu3LtuveMVRgeourClu96XImmQycm
   EoGYkkRgpIM5vwee2VgOWUUCvVUUG6U7ApkitdOJkHslBIP+Of5uqG07+
   UTKG0ye8pGsNtoxzCsWJeDCpIKdnX6kB+4LK6XVuC2mzSepxHp950E8Ql
   BSJXckAAnl8yNL9Mk1SsEok7FZue9rMXbkKGambvQ8NndPvrc1wDEF0KA
   ufmcVCi9Q9SVkc4+sTTzlA34YpqbCDH9otIZgve3QqMN5fZzsRgOC0lQn
   g==;
X-CSE-ConnectionGUID: OViyRm4wRUKLmpKgRLxSzQ==
X-CSE-MsgGUID: /Pylb+RmQ9yfeVcRFeIKfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45109877"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45109877"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 07:16:17 -0800
X-CSE-ConnectionGUID: KxRuVakLSOqJJh9GWhditw==
X-CSE-MsgGUID: AxjnC7kATRG3GzjHWeAx6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120050132"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.223.200])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 07:16:10 -0800
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
Subject: [PATCH v9 1/6] x86/virt/tdx: Rename 'struct tdx_tdmr_sysinfo' to reflect the spec better
Date: Sun, 15 Dec 2024 04:15:42 +1300
Message-ID: <de165d09e0b571cfeb119a368f4be6e2888ebb93.1734188033.git.kai.huang@intel.com>
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

The TDX module provides a set of "Global Metadata Fields".  They report
things like TDX module version, supported features, and fields related
to create/run TDX guests and so on.

TDX organizes those metadata fields by "Classes" based on the meaning of
those fields.  E.g., for now the kernel only reads "TD Memory Region"
(TDMR) related fields for module initialization.  Those fields are
defined under class "TDMR Info".

Today the kernel reads some of the global metadata to initialize the TDX
module.  KVM will need to read additional metadata fields to run TDX
guests.  Move towards having the TDX host core-kernel provide a
centralized, canonical, and immutable structure for the global metadata
that comes out from the TDX module for all kernel components to use.

More specifically, prepare the code to end up with an organization like:

       struct tdx_sys_info {
	       struct tdx_sys_info_classA a;
	       struct tdx_sys_info_classB b;
	       ...
       };

Currently the kernel organizes all fields under "TDMR Info" class in
'struct tdx_tdmr_sysinfo'.  Prepare for the above by renaming the
structure to 'struct tdx_sys_info_tdmr' to follow the class name better.

No functional change intended.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
v8 -> v9:
 - Minor changelog improvement suggested by Rick and Reniette.

---
 arch/x86/virt/vmx/tdx/tdx.c | 36 ++++++++++++++++++------------------
 arch/x86/virt/vmx/tdx/tdx.h |  2 +-
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 4e2b2e2ac9f9..e979bf442929 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -272,7 +272,7 @@ static int read_sys_metadata_field(u64 field_id, u64 *data)
 
 static int read_sys_metadata_field16(u64 field_id,
 				     int offset,
-				     struct tdx_tdmr_sysinfo *ts)
+				     struct tdx_sys_info_tdmr *ts)
 {
 	u16 *ts_member = ((void *)ts) + offset;
 	u64 tmp;
@@ -298,9 +298,9 @@ struct field_mapping {
 
 #define TD_SYSINFO_MAP(_field_id, _offset) \
 	{ .field_id = MD_FIELD_ID_##_field_id,	   \
-	  .offset   = offsetof(struct tdx_tdmr_sysinfo, _offset) }
+	  .offset   = offsetof(struct tdx_sys_info_tdmr, _offset) }
 
-/* Map TD_SYSINFO fields into 'struct tdx_tdmr_sysinfo': */
+/* Map TD_SYSINFO fields into 'struct tdx_sys_info_tdmr': */
 static const struct field_mapping fields[] = {
 	TD_SYSINFO_MAP(MAX_TDMRS,	      max_tdmrs),
 	TD_SYSINFO_MAP(MAX_RESERVED_PER_TDMR, max_reserved_per_tdmr),
@@ -309,16 +309,16 @@ static const struct field_mapping fields[] = {
 	TD_SYSINFO_MAP(PAMT_1G_ENTRY_SIZE,    pamt_entry_size[TDX_PS_1G]),
 };
 
-static int get_tdx_tdmr_sysinfo(struct tdx_tdmr_sysinfo *tdmr_sysinfo)
+static int get_tdx_sys_info_tdmr(struct tdx_sys_info_tdmr *sysinfo_tdmr)
 {
 	int ret;
 	int i;
 
-	/* Populate 'tdmr_sysinfo' fields using the mapping structure above: */
+	/* Populate 'sysinfo_tdmr' fields using the mapping structure above: */
 	for (i = 0; i < ARRAY_SIZE(fields); i++) {
 		ret = read_sys_metadata_field16(fields[i].field_id,
 						fields[i].offset,
-						tdmr_sysinfo);
+						sysinfo_tdmr);
 		if (ret)
 			return ret;
 	}
@@ -342,13 +342,13 @@ static int tdmr_size_single(u16 max_reserved_per_tdmr)
 }
 
 static int alloc_tdmr_list(struct tdmr_info_list *tdmr_list,
-			   struct tdx_tdmr_sysinfo *tdmr_sysinfo)
+			   struct tdx_sys_info_tdmr *sysinfo_tdmr)
 {
 	size_t tdmr_sz, tdmr_array_sz;
 	void *tdmr_array;
 
-	tdmr_sz = tdmr_size_single(tdmr_sysinfo->max_reserved_per_tdmr);
-	tdmr_array_sz = tdmr_sz * tdmr_sysinfo->max_tdmrs;
+	tdmr_sz = tdmr_size_single(sysinfo_tdmr->max_reserved_per_tdmr);
+	tdmr_array_sz = tdmr_sz * sysinfo_tdmr->max_tdmrs;
 
 	/*
 	 * To keep things simple, allocate all TDMRs together.
@@ -367,7 +367,7 @@ static int alloc_tdmr_list(struct tdmr_info_list *tdmr_list,
 	 * at a given index in the TDMR list.
 	 */
 	tdmr_list->tdmr_sz = tdmr_sz;
-	tdmr_list->max_tdmrs = tdmr_sysinfo->max_tdmrs;
+	tdmr_list->max_tdmrs = sysinfo_tdmr->max_tdmrs;
 	tdmr_list->nr_consumed_tdmrs = 0;
 
 	return 0;
@@ -921,11 +921,11 @@ static int tdmrs_populate_rsvd_areas_all(struct tdmr_info_list *tdmr_list,
 /*
  * Construct a list of TDMRs on the preallocated space in @tdmr_list
  * to cover all TDX memory regions in @tmb_list based on the TDX module
- * TDMR global information in @tdmr_sysinfo.
+ * TDMR global information in @sysinfo_tdmr.
  */
 static int construct_tdmrs(struct list_head *tmb_list,
 			   struct tdmr_info_list *tdmr_list,
-			   struct tdx_tdmr_sysinfo *tdmr_sysinfo)
+			   struct tdx_sys_info_tdmr *sysinfo_tdmr)
 {
 	int ret;
 
@@ -934,12 +934,12 @@ static int construct_tdmrs(struct list_head *tmb_list,
 		return ret;
 
 	ret = tdmrs_set_up_pamt_all(tdmr_list, tmb_list,
-			tdmr_sysinfo->pamt_entry_size);
+			sysinfo_tdmr->pamt_entry_size);
 	if (ret)
 		return ret;
 
 	ret = tdmrs_populate_rsvd_areas_all(tdmr_list, tmb_list,
-			tdmr_sysinfo->max_reserved_per_tdmr);
+			sysinfo_tdmr->max_reserved_per_tdmr);
 	if (ret)
 		tdmrs_free_pamt_all(tdmr_list);
 
@@ -1098,7 +1098,7 @@ static int init_tdmrs(struct tdmr_info_list *tdmr_list)
 
 static int init_tdx_module(void)
 {
-	struct tdx_tdmr_sysinfo tdmr_sysinfo;
+	struct tdx_sys_info_tdmr sysinfo_tdmr;
 	int ret;
 
 	/*
@@ -1117,17 +1117,17 @@ static int init_tdx_module(void)
 	if (ret)
 		goto out_put_tdxmem;
 
-	ret = get_tdx_tdmr_sysinfo(&tdmr_sysinfo);
+	ret = get_tdx_sys_info_tdmr(&sysinfo_tdmr);
 	if (ret)
 		goto err_free_tdxmem;
 
 	/* Allocate enough space for constructing TDMRs */
-	ret = alloc_tdmr_list(&tdx_tdmr_list, &tdmr_sysinfo);
+	ret = alloc_tdmr_list(&tdx_tdmr_list, &sysinfo_tdmr);
 	if (ret)
 		goto err_free_tdxmem;
 
 	/* Cover all TDX-usable memory regions in TDMRs */
-	ret = construct_tdmrs(&tdx_memlist, &tdx_tdmr_list, &tdmr_sysinfo);
+	ret = construct_tdmrs(&tdx_memlist, &tdx_tdmr_list, &sysinfo_tdmr);
 	if (ret)
 		goto err_free_tdmrs;
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index b701f69485d3..148f9b4d1140 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -100,7 +100,7 @@ struct tdx_memblock {
 };
 
 /* "TDMR info" part of "Global Scope Metadata" for constructing TDMRs */
-struct tdx_tdmr_sysinfo {
+struct tdx_sys_info_tdmr {
 	u16 max_tdmrs;
 	u16 max_reserved_per_tdmr;
 	u16 pamt_entry_size[TDX_PS_NR];
-- 
2.47.1


