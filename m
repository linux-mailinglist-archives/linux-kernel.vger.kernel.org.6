Return-Path: <linux-kernel+bounces-445380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9279F1542
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA1C161F54
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214511EF093;
	Fri, 13 Dec 2024 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cimEjllX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BF61EE001
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115895; cv=none; b=Xa2HjBMO3eLXpsmkYrT+VnkoTmGqU7ayfRTuK2qJHittdyiov7Lbbs+XyPDG33KRexc2UVqhR82Z9uqmEYypbcGaLwYEUHOFu6+DZ9BPaWsQxAa0MaI9O9tevseySEmevXHi6zPzYk3iTlbfPhtJ6Hl3HoKRNfRZvQ0xJGOvKHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115895; c=relaxed/simple;
	bh=6NiXiMiqKzLZCp5/RK7VRCAgJU7O4WOXVjXBtqT1m4A=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=L/JZgH2ULwqCbqLjWgPKjfAidKIA18c+yeo4/IbFeMWoh8sAcB8QoUOrUUeY4iWHHO3zG9JdmuDEuhJKCO+kIflNHTKXfhrmLpypfQQ3McK0a3lpe/Upzh/MsRu77FTlxNDIiIjZWg5p5SDiAU+k+lus6jI4cJHCfvjF75SpwIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cimEjllX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734115894; x=1765651894;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=6NiXiMiqKzLZCp5/RK7VRCAgJU7O4WOXVjXBtqT1m4A=;
  b=cimEjllXxV2xNXOFkWtA1JCr9mCZ7gUjfw5S3yU4yCny1zYBoVM0A0aG
   D9fHt52eI4NzrPWm8fMB3fYUKn3t+PAOnF2nTJiTfFmUMvdpZiu6960eK
   wLjofDBHj7lv9Cjl7bPCCEskdE9K8DtzAknvwVqXYOD7/4htQLbttTBR/
   VPsMVuNdWJG8DubWyh2/6/5X3j4cs+np94TWz/kXgsPf+cJJxXIInIkWn
   +DxEn0gb3de/WttthDniLxOdKWm+3jTk48hZMuPRDMWWBuBjBNJF3UYWk
   Y7PfxEGx/8rbS55AxCrp9k1f/tP5mVHEG7w7/ciZar6QJAol1sVSepvKR
   Q==;
X-CSE-ConnectionGUID: JJ39vnJrSEuMSUvdlISdYA==
X-CSE-MsgGUID: tTpRLs44QfSWPkZ/GfUSfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="34487462"
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="34487462"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 10:51:34 -0800
X-CSE-ConnectionGUID: Rul+/3v6TJCyD5xZGu8V0A==
X-CSE-MsgGUID: Vwm04AIdQKeniLEHY0ANFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96478772"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa010.jf.intel.com with ESMTP; 13 Dec 2024 10:51:34 -0800
Subject: [v2][PATCH 5/5] x86/cpu: Remove 'x86_cpu_desc' infrastructure
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,kan.liang@linux.intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 13 Dec 2024 10:51:33 -0800
References: <20241213185127.F38B6EE9@davehans-spike.ostc.intel.com>
In-Reply-To: <20241213185127.F38B6EE9@davehans-spike.ostc.intel.com>
Message-Id: <20241213185133.AF0BF2BC@davehans-spike.ostc.intel.com>
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
--- a/arch/x86/include/asm/cpu_device_id.h~zap-x86_cpu_desc-3	2024-12-13 10:48:03.174376959 -0800
+++ b/arch/x86/include/asm/cpu_device_id.h	2024-12-13 10:48:03.178377120 -0800
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
--- a/arch/x86/kernel/cpu/match.c~zap-x86_cpu_desc-3	2024-12-13 10:48:03.174376959 -0800
+++ b/arch/x86/kernel/cpu/match.c	2024-12-13 10:48:03.178377120 -0800
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

