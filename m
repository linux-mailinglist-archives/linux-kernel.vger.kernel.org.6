Return-Path: <linux-kernel+bounces-435546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF62A9E7923
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E79918885E2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C6D215192;
	Fri,  6 Dec 2024 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R35RYQoT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2AB2135CD
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513920; cv=none; b=qjK4vQkC9TyMhWfzcHAkf0FIhL/tR4Vb/w0HkwES5OYB5HU5k2T0NEyJ+G7y9KoxbvBazGyCv7FtR09Go81eXixAxJDqlY69Cet7P/2LKaxSE2FzYGUFU+v/UCeSuxakal4Crj7h4KrN4elqA8E+w8bMjk8xtUYL8ClSqbyze3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513920; c=relaxed/simple;
	bh=1W18IIfiPQcuVMS9i5YvkgbwEZx8qv0Tbp4ZVof+iOU=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=Ed0UIi7kN7BURyovQOTOuX7X6evi5B005ZN54dqJsBMXJ3oTAdPBdHzZUTYVtbK69duGpWH3nNWyIg9FMGr2d329gcSeNvIOhNp0Y3JjR07VPW7VOsZma9u5OSoDZ1nHDiMjIyeZ+ryMlEsHEZP+VMu32M2jUImaoNuaa+lQpeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R35RYQoT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733513918; x=1765049918;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=1W18IIfiPQcuVMS9i5YvkgbwEZx8qv0Tbp4ZVof+iOU=;
  b=R35RYQoT2LVhjxEsG6o8/+xtlD7VO/TQZQPAj3ZDACfCdWxdkSv+FYN7
   dP9lZMkFvuZ3fucKsf6eSMW4JzOdUr58/zikz+0mo+Is/1JgblgUFEpT0
   ivUbx0SSNCyNWXMq6vXCznoe0iBg5UOL5kP7FuWJDuamNpsq/9U3wn/+j
   jTDi3wTU30567dT2qpdcDvn6EVTQCNbLPNasrgarhe3nFla8iy11bKl0V
   Ghag54hQfs3WDU8VbGXJ3H1gCaxNarJMMFri5xTL61T1OmbdKVLv7q0wU
   bR7v3XcoXjonS7z0rfpzF4MkmjVvySyjKmMUOkYae79qV+aiAFh7euqy1
   w==;
X-CSE-ConnectionGUID: pu0WhWQVQ4untXxqaGhDcw==
X-CSE-MsgGUID: u95Dg95fTgOS487zKsTIHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="34027913"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="34027913"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 11:38:38 -0800
X-CSE-ConnectionGUID: YEesrAm3Ti2Fqol5sWgfag==
X-CSE-MsgGUID: 9ZwYC+M9Sj2HEEe6BMfKiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="94979054"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa009.fm.intel.com with ESMTP; 06 Dec 2024 11:38:38 -0800
Subject: [PATCH 5/5] x86/cpu: Remove 'x86_cpu_desc' infrastructure
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,kan.liang@linux.intel.com,mingo@kernel.org,peterz@infradead.org,tony.luck@intel.com,pawan.kumar.gupta@linux.intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 06 Dec 2024 11:38:37 -0800
References: <20241206193829.89E12D0B@davehans-spike.ostc.intel.com>
In-Reply-To: <20241206193829.89E12D0B@davehans-spike.ostc.intel.com>
Message-Id: <20241206193837.B3001666@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

All the users of 'x86_cpu_desc' are gone.  Zap it from the tree.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/cpu_device_id.h |   35 ---------------------------------
 b/arch/x86/kernel/cpu/match.c          |   31 -----------------------------
 2 files changed, 66 deletions(-)

diff -puN arch/x86/include/asm/cpu_device_id.h~zap-x86_cpu_desc-3 arch/x86/include/asm/cpu_device_id.h
--- a/arch/x86/include/asm/cpu_device_id.h~zap-x86_cpu_desc-3	2024-12-06 11:33:17.751210312 -0800
+++ b/arch/x86/include/asm/cpu_device_id.h	2024-12-06 11:33:17.755210470 -0800
@@ -243,42 +243,7 @@
 		VFM_MODEL(vfm),				\
 		X86_STEPPING_ANY, feature, data)
 
-/*
- * Match specific microcode revisions.
- *
- * vendor/family/model/stepping must be all set.
- *
- * Only checks against the boot CPU.  When mixed-stepping configs are
- * valid for a CPU model, add a quirk for every valid stepping and
- * do the fine-tuning in the quirk handler.
- */
-
-struct x86_cpu_desc {
-	u8	x86_family;
-	u8	x86_vendor;
-	u8	x86_model;
-	u8	x86_stepping;
-	u32	x86_microcode_rev;
-};
-
-#define INTEL_CPU_DESC(vfm, stepping, revision) {		\
-	.x86_family		= VFM_FAMILY(vfm),		\
-	.x86_vendor		= VFM_VENDOR(vfm),		\
-	.x86_model		= VFM_MODEL(vfm),		\
-	.x86_stepping		= (stepping),			\
-	.x86_microcode_rev	= (revision),			\
-}
-
-#define AMD_CPU_DESC(fam, model, stepping, revision) {		\
-	.x86_family		= (fam),			\
-	.x86_vendor		= X86_VENDOR_AMD,		\
-	.x86_model		= (model),			\
-	.x86_stepping		= (stepping),			\
-	.x86_microcode_rev	= (revision),			\
-}
-
 extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
-extern bool x86_cpu_has_min_microcode_rev(const struct x86_cpu_desc *table);
 extern bool x86_match_min_microcode_rev(const struct x86_cpu_id *table);
 
 #endif /* _ASM_X86_CPU_DEVICE_ID */
diff -puN arch/x86/kernel/cpu/match.c~zap-x86_cpu_desc-3 arch/x86/kernel/cpu/match.c
--- a/arch/x86/kernel/cpu/match.c~zap-x86_cpu_desc-3	2024-12-06 11:33:17.755210470 -0800
+++ b/arch/x86/kernel/cpu/match.c	2024-12-06 11:33:17.755210470 -0800
@@ -56,37 +56,6 @@ const struct x86_cpu_id *x86_match_cpu(c
 }
 EXPORT_SYMBOL(x86_match_cpu);
 
-static const struct x86_cpu_desc *
-x86_match_cpu_with_stepping(const struct x86_cpu_desc *match)
-{
-	struct cpuinfo_x86 *c = &boot_cpu_data;
-	const struct x86_cpu_desc *m;
-
-	for (m = match; m->x86_family | m->x86_model; m++) {
-		if (c->x86_vendor != m->x86_vendor)
-			continue;
-		if (c->x86 != m->x86_family)
-			continue;
-		if (c->x86_model != m->x86_model)
-			continue;
-		if (c->x86_stepping != m->x86_stepping)
-			continue;
-		return m;
-	}
-	return NULL;
-}
-
-bool x86_cpu_has_min_microcode_rev(const struct x86_cpu_desc *table)
-{
-	const struct x86_cpu_desc *res = x86_match_cpu_with_stepping(table);
-
-	if (!res || res->x86_microcode_rev > boot_cpu_data.microcode)
-		return false;
-
-	return true;
-}
-EXPORT_SYMBOL_GPL(x86_cpu_has_min_microcode_rev);
-
 bool x86_match_min_microcode_rev(const struct x86_cpu_id *table)
 {
 	const struct x86_cpu_id *res = x86_match_cpu(table);
_

