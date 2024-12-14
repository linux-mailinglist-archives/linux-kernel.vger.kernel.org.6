Return-Path: <linux-kernel+bounces-446079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2B79F1F9A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 16:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8DEB1886509
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 15:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBC419645D;
	Sat, 14 Dec 2024 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANxmIyVp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1F1195FE3
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734189386; cv=none; b=gvRMGwfjcZmXaUiHGL4zDj0I4BeUMQ7xOuhlrRVjNl+IBpP1hltnbjcVvHNyXDi2gWvlRslA+TKt0etmeAS3GuxP47lc1P8yzHrijh4a3cJoN53t7ZPx7yEuHepGP2PZS9IxEquQ0sXxhSX+e4clr2jwdPM14Wg8yyiy1OOsxyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734189386; c=relaxed/simple;
	bh=qUFQTlxQxW1bCwelnRCVS/v3khy7lbqTGgx60XC0Bo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJfvAiQy7F546HPZD25ySEZaWFJerTjg5Ix4xv1fHR5DBMTRLIYODKMnC5JhAf2RmGXu7nmYqezKh6a2YThSZIQ+T5SASePFpvzIGqSzkuXUQJZd1CqztdYufZQuPcWCKnkn6ikIEno8o1qD30/IRxy7T0gberQS5SKpHdNbOYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ANxmIyVp; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734189385; x=1765725385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qUFQTlxQxW1bCwelnRCVS/v3khy7lbqTGgx60XC0Bo8=;
  b=ANxmIyVpvzCeoXdtaU5lHOs7To0Jm2I1aohzZwAJ1Ik6ynIJFVC0fBcn
   HqV8o2BPmKZXx/gebhhe/RN9bQppMS4SnhQoK/vdWc8cI8qoFYv04DgvJ
   /td8ihxQnlGdJrRb23RA+Fm+7A1h1j+AnQ+RbvSj0gP/e3+CXPrHdRxga
   xHQ+6669HLykqgo0kGuonkT54Z9YOcr7+TATabEYlFsUSTcGbF7YA+EpG
   MFCaAZnbGXEmn0/jMmKrNxxFoDtqOuyVfL3xg7EcJwLCmfojySyM3MHyH
   rb2kig0tmcT5F7WyVTXGW3pRfna2wpd5TUgQc6rBfpPRZbErAQI+Xg/FZ
   Q==;
X-CSE-ConnectionGUID: Kwx/m2VARKGDfaIhI3oRMg==
X-CSE-MsgGUID: D1JtAsVoQDapbMbRuKgAnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45109888"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45109888"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 07:16:25 -0800
X-CSE-ConnectionGUID: a5INe2RuTKO+oI9RinO4Vg==
X-CSE-MsgGUID: Zr9TDpOvQyOQuCN1a1uXNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120050151"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.223.200])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 07:16:17 -0800
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
Subject: [PATCH v9 2/6] x86/virt/tdx: Start to track all global metadata in one structure
Date: Sun, 15 Dec 2024 04:15:43 +1300
Message-ID: <bfacb4e90527cf79d4be0d1753e6f318eea21118.1734188033.git.kai.huang@intel.com>
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

Today the kernel only reads "TD Memory Region" (TDMR) related fields for
module initialization.  KVM will need to read additional metadata fields
to run TDX guests.  Move towards having the TDX host core-kernel provide
a centralized, canonical, and immutable structure for the global
metadata that comes out from the TDX module for all kernel components to
use.

As the first step, introduce a new 'struct tdx_sys_info' to track all
global metadata fields.

TDX categorizes global metadata fields into different "Classes".  E.g.,
the TDMR related fields are under class "TDMR Info".  Instead of making
'struct tdx_sys_info' a plain structure to contain all metadata fields,
organize them in smaller structures based on the "Class".

This allows those metadata fields to be used in finer granularity thus
makes the code clearer.  E.g., construct_tdmrs() can just take the
structure which contains "TDMR Info" metadata fields.

Add get_tdx_sys_info() as the placeholder to read all metadata fields.
Have it only call get_tdx_sys_info_tdmr() to read TDMR related fields
for now.

Place get_tdx_sys_info() as the first step of init_tdx_module() to
enable early prerequisite checks on the metadata to support early module
initialization abort.  This results in moving get_tdx_sys_info_tdmr() to
be before build_tdx_memlist(), but this is fine because there are no
dependencies between these two functions.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
v8 -> v9:
 - Minor changelog improvement suggested by Rick and Reniette.

---
 arch/x86/virt/vmx/tdx/tdx.c | 19 ++++++++++++-------
 arch/x86/virt/vmx/tdx/tdx.h | 19 ++++++++++++-------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index e979bf442929..7a2f979092e7 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -326,6 +326,11 @@ static int get_tdx_sys_info_tdmr(struct tdx_sys_info_tdmr *sysinfo_tdmr)
 	return 0;
 }
 
+static int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
+{
+	return get_tdx_sys_info_tdmr(&sysinfo->tdmr);
+}
+
 /* Calculate the actual TDMR size */
 static int tdmr_size_single(u16 max_reserved_per_tdmr)
 {
@@ -1098,9 +1103,13 @@ static int init_tdmrs(struct tdmr_info_list *tdmr_list)
 
 static int init_tdx_module(void)
 {
-	struct tdx_sys_info_tdmr sysinfo_tdmr;
+	struct tdx_sys_info sysinfo;
 	int ret;
 
+	ret = get_tdx_sys_info(&sysinfo);
+	if (ret)
+		return ret;
+
 	/*
 	 * To keep things simple, assume that all TDX-protected memory
 	 * will come from the page allocator.  Make sure all pages in the
@@ -1117,17 +1126,13 @@ static int init_tdx_module(void)
 	if (ret)
 		goto out_put_tdxmem;
 
-	ret = get_tdx_sys_info_tdmr(&sysinfo_tdmr);
-	if (ret)
-		goto err_free_tdxmem;
-
 	/* Allocate enough space for constructing TDMRs */
-	ret = alloc_tdmr_list(&tdx_tdmr_list, &sysinfo_tdmr);
+	ret = alloc_tdmr_list(&tdx_tdmr_list, &sysinfo.tdmr);
 	if (ret)
 		goto err_free_tdxmem;
 
 	/* Cover all TDX-usable memory regions in TDMRs */
-	ret = construct_tdmrs(&tdx_memlist, &tdx_tdmr_list, &sysinfo_tdmr);
+	ret = construct_tdmrs(&tdx_memlist, &tdx_tdmr_list, &sysinfo.tdmr);
 	if (ret)
 		goto err_free_tdmrs;
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 148f9b4d1140..2600ec3752f5 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -80,6 +80,18 @@ struct tdmr_info {
 	DECLARE_FLEX_ARRAY(struct tdmr_reserved_area, reserved_areas);
 } __packed __aligned(TDMR_INFO_ALIGNMENT);
 
+/* Class "TDMR info" */
+struct tdx_sys_info_tdmr {
+	u16 max_tdmrs;
+	u16 max_reserved_per_tdmr;
+	u16 pamt_entry_size[TDX_PS_NR];
+};
+
+/* Kernel used global metadata fields */
+struct tdx_sys_info {
+	struct tdx_sys_info_tdmr tdmr;
+};
+
 /*
  * Do not put any hardware-defined TDX structure representations below
  * this comment!
@@ -99,13 +111,6 @@ struct tdx_memblock {
 	int nid;
 };
 
-/* "TDMR info" part of "Global Scope Metadata" for constructing TDMRs */
-struct tdx_sys_info_tdmr {
-	u16 max_tdmrs;
-	u16 max_reserved_per_tdmr;
-	u16 pamt_entry_size[TDX_PS_NR];
-};
-
 /* Warn if kernel has less than TDMR_NR_WARN TDMRs after allocation */
 #define TDMR_NR_WARN 4
 
-- 
2.47.1


