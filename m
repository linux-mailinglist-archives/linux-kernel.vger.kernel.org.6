Return-Path: <linux-kernel+bounces-407516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E189C6E87
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070112830B7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F3C202F8B;
	Wed, 13 Nov 2024 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="alZjGlDg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83428202659
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499056; cv=none; b=LY2JbeZ/p3hB93Vj8iEStOppVE2OtpmEsYXiEns+L4HA9mQG2BM+jsfNZL/DvDP7TWquD0GjKqn0XxiMsAbK5P6Ypt2FuFruu/ZiOwmZs0VKgS5AlGDJgojAa0VM6SjqRjvjotYz3Gd85iJP13trXJSiBDqu9N1FdiO49Oh558o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499056; c=relaxed/simple;
	bh=bDI/Mlfp4A+YXhAbwzD+LC8MAivKbez1Ycq4FLs6i/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M63Jrukc8saeGaoD4eQTaroW03OFV5TWG1nWu2qLlv7Nu9nOJ6D76wXFKzyFNo08eK/QgZsTixS91MTYKtgsNhqQrv+IdCSgiCkGR1iATbd5WewWYMRKaXIy32Km2ScCr0fTQeJu6IEjR/JpPovydsKuXW8i6GJObPKh4FlAgak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=alZjGlDg; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731499055; x=1763035055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bDI/Mlfp4A+YXhAbwzD+LC8MAivKbez1Ycq4FLs6i/0=;
  b=alZjGlDgRJZjFfHoDf+pwIx05DLog/JMWfu2EH5AJFMxmWsL0qsVJekx
   /bdc/h+fym+r+BMt2ekgnoAg4Oy+vwCc+qo97ZZENUDWEcmTajSa2rr/2
   s5K3clbR7A9FfkjE629HRV9OV1MjzWlc9TrA23D9e8Fbg8wSTFsS+ixfb
   XCStAWnDVtmth56jGrNKQZ5vOhFcSrjMqBVbbD1NMw/QqtZtKthZY99a0
   ZCwjsjRubp+YdreTHqG9F1t2/a4BDUHI3OEP4kZkdPnUR9mIuyDWASeuz
   LHuRjGf11PChPJ2QyweoMgQ+ykq4svmVP0MnJi8huw6TyK6/dJeoBqN/C
   g==;
X-CSE-ConnectionGUID: BRhHZW1hTiaanovjcJpOqA==
X-CSE-MsgGUID: iDe8UWGTSWiIDvLrvkuV0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31630739"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="31630739"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 03:57:34 -0800
X-CSE-ConnectionGUID: TB6CkIVmSUCUgVhZUkXRlQ==
X-CSE-MsgGUID: mrNkqL4pR3m5Oc9zfe7upg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="92323484"
Received: from daliomra-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.220.169])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 03:57:31 -0800
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
Subject: [PATCH v8 2/9] x86/virt/tdx: Start to track all global metadata in one structure
Date: Thu, 14 Nov 2024 00:57:07 +1300
Message-ID: <2b84402558c9f9b5f2ba7476343247879180d36f.1731498635.git.kai.huang@intel.com>
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

The TDX module provides a set of "Global Metadata Fields".  They report
things like TDX module version, supported features, and fields related
to create/run TDX guests and so on.

Currently the kernel only reads "TD Memory Region" (TDMR) related fields
for module initialization.  There are both immediate needs to read more
metadata fields for module initialization and near-future needs for
other kernel components like KVM to run TDX guests.

To meet all those requirements, the idea is the TDX host core-kernel to
to provide a centralized, canonical, and read-only structure for the
global metadata that comes out from the TDX module for all kernel
components to use.

As the first step, introduce a new 'struct tdx_sys_info' to track all
global metadata fields.

TDX categories global metadata fields into different "Classes".  E.g.,
the TDMR related fields are under class "TDMR Info".  Instead of making
'struct tdx_sys_info' a plain structure to contain all metadata fields,
organize them in smaller structures based on the "Class".

This allows those metadata fields to be used in finer granularity thus
makes the code more clear.  E.g., the construct_tdmr() can just take the
structure which contains "TDMR Info" metadata fields.

Add a new function get_tdx_sys_info() as the placeholder to read all
metadata fields, and call it at the beginning of init_tdx_module().  For
now it only calls get_tdx_sys_info_tdmr() to read TDMR related fields.

Note there is a functional change: get_tdx_sys_info_tdmr() is moved from
after build_tdx_memlist() to before it, but it is fine to do so.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
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
2.46.2


