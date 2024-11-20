Return-Path: <linux-kernel+bounces-416304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6EF9D42FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1CF1F21EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9DF1C761F;
	Wed, 20 Nov 2024 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggkAmiP9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F331C4622
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732134256; cv=none; b=pjgmWd/xC2yveBWnFVZMzRH3yLuThYGOrnOTk4DiXVz1VohDy1l81j0RWEWhmEMQbAKrHlgd9Lqx/uyZmd/CX90wUiHUT6HvOkvKw/Dcjtu5lOCSSqFha4jVTnuUwo+iD2ovXqYKNcQ1KSuRyierAz5/OTMsxDcjA+MpQN7V7UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732134256; c=relaxed/simple;
	bh=Q2IbSZiOEojJfhzTe2spo/usBI2+YFImLOhMxgTYU6I=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=YRgvbjI+YqFVSyXk1m0BCDvS8JJJTFl/2z7F4kZImDzS1juBz8oVEjv2GTNaEAsjQVvKfCgb+QaTjk7FraLmtPHdm+8hf+LMsKqOOw4VrR4tjGbiV4YaegtwWjM/o7TFc1r2Mw3V/gFxfGbmsBU54jgMztbPy6CMp0/BQQHBzUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggkAmiP9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732134255; x=1763670255;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=Q2IbSZiOEojJfhzTe2spo/usBI2+YFImLOhMxgTYU6I=;
  b=ggkAmiP9RvXFCqkgwtNb8SGzqaPTse7AwmHEnP/rdxA2XhpdnDNk7gXC
   M/HM3siT04VODpNOEDUwksM8g/nJoA4EmMwgXIHd0htRlUtj9iTbiL2Z2
   3AOdiZCf4rW2k7EsLDJMI5kLxQ5KKzLaThlgNabEgFQEUAzxJrrdLn2Hh
   p5BnaSKKVjDlvbrF0VkijUvGAlBMqPhCvdDbvOoiTVd6WJEk1QAXsL3a+
   bfGcY6ro9lK9EtjktnRne1POqhVBqF6tdQm61YIY+PjRy4tL7ThPRH8QN
   +DDIerVg2MfU0wzZcLvaN34OgcQKaImxwmC+oOGBfhQoLc5zH9yC3e05Q
   g==;
X-CSE-ConnectionGUID: NSIKlApcRmawXWy+a/8cBw==
X-CSE-MsgGUID: lsQ/CvSVSBuVNXAXXCJobw==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="42855784"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="42855784"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 12:24:15 -0800
X-CSE-ConnectionGUID: nVty1wqsS8yDwIeE40oo3A==
X-CSE-MsgGUID: rmhXIEKVTCqDK+vJ8rdJVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="90407616"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa010.fm.intel.com with ESMTP; 20 Nov 2024 12:24:16 -0800
Subject: [RFC][PATCH 4/4] x86/cpu: Remove 'x86_cpu_desc' infrastructure
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,kan.liang@linux.intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 20 Nov 2024 12:24:14 -0800
References: <20241120202408.0A7215EF@davehans-spike.ostc.intel.com>
In-Reply-To: <20241120202408.0A7215EF@davehans-spike.ostc.intel.com>
Message-Id: <20241120202414.071D4237@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

All the users of 'x86_cpu_desc' are gone.  Zap it from the tree.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/cpu_device_id.h |   36 ---------------------------------
 b/arch/x86/kernel/cpu/match.c          |   31 ----------------------------
 2 files changed, 67 deletions(-)

diff -puN arch/x86/include/asm/cpu_device_id.h~zap-x86_cpu_desc-3 arch/x86/include/asm/cpu_device_id.h
--- a/arch/x86/include/asm/cpu_device_id.h~zap-x86_cpu_desc-3	2024-11-20 12:22:06.484439538 -0800
+++ b/arch/x86/include/asm/cpu_device_id.h	2024-11-20 12:22:06.488439691 -0800
@@ -260,42 +260,6 @@
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
-extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
-extern bool x86_cpu_has_min_microcode_rev(const struct x86_cpu_desc *table);
 extern bool x86_match_min_microcode_rev(const struct x86_cpu_id *table);
 
 #endif /* _ASM_X86_CPU_DEVICE_ID */
diff -puN arch/x86/kernel/cpu/match.c~zap-x86_cpu_desc-3 arch/x86/kernel/cpu/match.c
--- a/arch/x86/kernel/cpu/match.c~zap-x86_cpu_desc-3	2024-11-20 12:22:06.484439538 -0800
+++ b/arch/x86/kernel/cpu/match.c	2024-11-20 12:22:06.488439691 -0800
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

