Return-Path: <linux-kernel+bounces-407523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D239C6E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD0E1F235CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDD9205155;
	Wed, 13 Nov 2024 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nySYWXm4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9318204953
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499080; cv=none; b=FU7JiRj+kRzpJRVuFegqe4uYGp2doUPVZ3BLKsjfRxQqBUbbKI/mpIfaml6mENCpWXrx+VUDx+5rCKnTUhjxdyLSbywbjEFIWjq5B3+EfwjOKA9uF8SmtTuDPrOYv0rIasyuLRp2u2beXPJOBko79FG/xIXWsZ0/Z8tfmr4zzTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499080; c=relaxed/simple;
	bh=XkGRTafeawWJeIQvgFciW4ufZuMVbVNQZ5jP4HOXoTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXkz3UsNx7Kb8VF8uG9mYNMerh5kdak+X+BtJV+KyZ7QeOUYW27p22VqjW99ndg18EQWIIA37OsFAutuMsSeQmoaS59B4s8FRjB0Y/aiddOQkQP1YovABeK/aoXfvAgqHyricvhbzMDLUbboD+0lqcWVQcuSGtDUaunANSNsr4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nySYWXm4; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731499079; x=1763035079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XkGRTafeawWJeIQvgFciW4ufZuMVbVNQZ5jP4HOXoTk=;
  b=nySYWXm4qe0i6ngOb9zXn9O6vki0FgmqDEi/0HWCNtp5g+ykziVrmIkz
   PlyWgZD9bHYrNMu1BMWLzC7LN7VKH7L4D0deqsmE6sVhOroveiVdAMLeD
   8wmI4yvCx0vBL5gI0UmLxs2HfWh7J4Q+cDRhYoW13MRyg3E11cAuKVo07
   TjRFq1VbatBWJ2PTESyHoiOUAfW/8nMhSId+mdKGbWO3Q2CLfmWgXUPCC
   XB2Vi6A8d7sf4Ecu+F8N29Bh5ytIMyYkEETbkr3XrEhUvnK7SSIOnFdlW
   0kTD70nZ/SSQxoFHueH58NihBBYPmfhtuCNWnXrl5kjHpTQKgzvjlyHEU
   Q==;
X-CSE-ConnectionGUID: Xb+agPzbSAiR4S4yz3esjQ==
X-CSE-MsgGUID: qfqY7UmJTV6Umym3KRlPLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31630875"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="31630875"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 03:57:58 -0800
X-CSE-ConnectionGUID: 0bPNZN7pS5CbmOLc9TjOnQ==
X-CSE-MsgGUID: fgBBr3lMRFawpzFQSWciSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="92323583"
Received: from daliomra-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.220.169])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 03:57:55 -0800
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
Subject: [PATCH v8 9/9] x86/virt/tdx: Require the module to assert it has the NO_RBP_MOD mitigation
Date: Thu, 14 Nov 2024 00:57:14 +1300
Message-ID: <2ce15d25ae52411f15742a4b13a8b68a1f5484cd.1731498635.git.kai.huang@intel.com>
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

Old TDX modules can clobber RBP in the TDH.VP.ENTER SEAMCALL.  However
RBP is used as frame pointer in the x86_64 calling convention, and
clobbering RBP could result in bad things like being unable to unwind
the stack if any non-maskable exceptions (NMI, #MC etc) happens in that
gap.

A new "NO_RBP_MOD" feature was introduced to more recent TDX modules to
not clobber RBP.  This feature is reported in the TDX_FEATURES0 global
metadata field via bit 18.

Don't initialize the TDX module if this feature is not supported [1].

Note the bit definitions of TDX_FEATURES0 are not auto-generated in
tdx_global_metadata.h.  Manually define a macro for it in "tdx.h".

Link: https://lore.kernel.org/fc0e8ab7-86d4-4428-be31-82e1ece6dd21@intel.com/ [1]
Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 17 +++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index b14089f784bf..e4a7e0e17812 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -312,6 +312,18 @@ static int init_tdx_sys_info(struct tdx_sys_info *sysinfo)
 	return 0;
 }
 
+static int check_features(struct tdx_sys_info *sysinfo)
+{
+	u64 tdx_features0 = sysinfo->features.tdx_features0;
+
+	if (!(tdx_features0 & TDX_FEATURES0_NO_RBP_MOD)) {
+		pr_err("frame pointer (RBP) clobber bug present, upgrade TDX module\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* Calculate the actual TDMR size */
 static int tdmr_size_single(u16 max_reserved_per_tdmr)
 {
@@ -1095,6 +1107,11 @@ static int init_tdx_module(void)
 	if (ret)
 		return ret;
 
+	/* Check whether the kernel can support this module */
+	ret = check_features(&sysinfo);
+	if (ret)
+		return ret;
+
 	/*
 	 * To keep things simple, assume that all TDX-protected memory
 	 * will come from the page allocator.  Make sure all pages in the
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 0128b963b723..c8be00f6b15a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/compiler_attributes.h>
 #include <linux/stddef.h>
+#include <linux/bits.h>
 #include "tdx_global_metadata.h"
 
 /*
@@ -54,6 +55,9 @@ struct tdmr_info {
 	DECLARE_FLEX_ARRAY(struct tdmr_reserved_area, reserved_areas);
 } __packed __aligned(TDMR_INFO_ALIGNMENT);
 
+/* Bit definitions of TDX_FEATURES0 metadata field */
+#define TDX_FEATURES0_NO_RBP_MOD	BIT(18)
+
 /*
  * Do not put any hardware-defined TDX structure representations below
  * this comment!
-- 
2.46.2


