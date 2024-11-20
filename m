Return-Path: <linux-kernel+bounces-416302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2059D42FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9BE284260
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB9F1C331A;
	Wed, 20 Nov 2024 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2FmZ+AM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AF71BD4F8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732134254; cv=none; b=IefZ4mTjOVWYS6QvRmr/YzjSFpFXLEFoWyoyhZ2DX0yqHYX+MGQOAOXZzGce3TjrktlKEqAmTb0UrwEGtE5tUptqmIFFWEOG7VvO4LUclWfbluTjBmjd/MDTNcYV9NNrp30Zf7MzLBTJqfiIksvWh0e50SY+pj0XoFumrSlmuLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732134254; c=relaxed/simple;
	bh=sW/QHVxqfK/BkIdaw59NlwGzEWLE2RKLL8E53H7XBJg=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=PUcc6DVlIL9P9ItwKueHpnwSdI9hjcj/XVnDnuhyUsaTPeUOVhTSiaMjEgtSEkZcPLLkILo/xYHZPeXAxg2gcPHh21QEha4jQf3dQk4FvNQL3XRXVaLwcz8UUTziHNxe6DLScxqL7WJYK+3/29nRLvSRf8ZtN7CxnYyY38iJPks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2FmZ+AM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732134252; x=1763670252;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=sW/QHVxqfK/BkIdaw59NlwGzEWLE2RKLL8E53H7XBJg=;
  b=G2FmZ+AMnkqVrrkW7OUzI1nWTsgugmlAn8Zuxr3s78c+TM5dYxzH0RCM
   ovdg1M9yTVz2P3FI5NDPNSvrtRqUCcR9LYh3TbwwOzdpTNEiVDMvNOlcu
   3/vvBC1bg7PJ8mgkLwoJSw0kFXfc/w+c/wZzHQsgpenwZekH3zvrDYgBM
   Unl0ghdlkexOIzt0omRD/2JLdCJeU5WZDYpHzBR74+2a8nib3vwVlpaa6
   3725OpNC2uRxnsYJ1Zy5XXxgI1vo5Z+FhdW/Jmm1wE02VWsIvZjtFfXGE
   f83h/2UrG7+CHFuwEmGqS3ggk7u/3km5GCf5DVzdjHvxOv4bTo1cLU6oi
   A==;
X-CSE-ConnectionGUID: rUQ+tdjYTJKW2PQXSluRzg==
X-CSE-MsgGUID: 213uoitOQAGsB5uuaK5nag==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="42855769"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="42855769"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 12:24:12 -0800
X-CSE-ConnectionGUID: 5D3ruk/BTrG0pSz7FJj3Eg==
X-CSE-MsgGUID: rsCS25taT/CyULP5wuWU6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="90407610"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa010.fm.intel.com with ESMTP; 20 Nov 2024 12:24:13 -0800
Subject: [RFC][PATCH 2/4] x86/cpu: Replace 'x86_cpu_desc' use with 'x86_cpu_id'
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,kan.liang@linux.intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 20 Nov 2024 12:24:11 -0800
References: <20241120202408.0A7215EF@davehans-spike.ostc.intel.com>
In-Reply-To: <20241120202408.0A7215EF@davehans-spike.ostc.intel.com>
Message-Id: <20241120202411.2E4C9595@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The 'x86_cpu_desc' and 'x86_cpu_id' structures are very similar.
Reduce duplicate infrastructure by moving the few users of
'x86_cpu_id' to the much more common variant.

The existing X86_MATCH_VFM_STEPPINGS() helper matches ranges of
steppings. Introduce a new helper to match a single stepping to make
the macro use a bit less verbose.

I'm a _bit_ nervous about this because

	X86_MATCH_VFM_STEPPING(INTEL_SANDYBRIDGE_X,  7, 0x0000070c),
and
	X86_MATCH_VFM_STEPPINGS(INTEL_SANDYBRIDGE_X, 7, 0x0000070c),

look very similar but the second one is buggy. Any suggestions for
making this more foolproof would be appreciated.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/events/intel/core.c         |   72 ++++++++++++++++-----------------
 b/arch/x86/include/asm/cpu_device_id.h |   18 ++++++++
 2 files changed, 54 insertions(+), 36 deletions(-)

diff -puN arch/x86/events/intel/core.c~zap-x86_cpu_desc arch/x86/events/intel/core.c
--- a/arch/x86/events/intel/core.c~zap-x86_cpu_desc	2024-11-20 12:22:05.468400705 -0800
+++ b/arch/x86/events/intel/core.c	2024-11-20 12:22:05.472400858 -0800
@@ -5340,42 +5340,42 @@ static __init void intel_clovertown_quir
 	x86_pmu.pebs_constraints = NULL;
 }
 
-static const struct x86_cpu_desc isolation_ucodes[] = {
-	INTEL_CPU_DESC(INTEL_HASWELL,		 3, 0x0000001f),
-	INTEL_CPU_DESC(INTEL_HASWELL_L,		 1, 0x0000001e),
-	INTEL_CPU_DESC(INTEL_HASWELL_G,		 1, 0x00000015),
-	INTEL_CPU_DESC(INTEL_HASWELL_X,		 2, 0x00000037),
-	INTEL_CPU_DESC(INTEL_HASWELL_X,		 4, 0x0000000a),
-	INTEL_CPU_DESC(INTEL_BROADWELL,		 4, 0x00000023),
-	INTEL_CPU_DESC(INTEL_BROADWELL_G,	 1, 0x00000014),
-	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 2, 0x00000010),
-	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 3, 0x07000009),
-	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 4, 0x0f000009),
-	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 5, 0x0e000002),
-	INTEL_CPU_DESC(INTEL_BROADWELL_X,	 1, 0x0b000014),
-	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 3, 0x00000021),
-	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 4, 0x00000000),
-	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 5, 0x00000000),
-	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 6, 0x00000000),
-	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 7, 0x00000000),
-	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		11, 0x00000000),
-	INTEL_CPU_DESC(INTEL_SKYLAKE_L,		 3, 0x0000007c),
-	INTEL_CPU_DESC(INTEL_SKYLAKE,		 3, 0x0000007c),
-	INTEL_CPU_DESC(INTEL_KABYLAKE,		 9, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	 9, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	10, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	11, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	12, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE,		10, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE,		11, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE,		12, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE,		13, 0x0000004e),
+static const struct x86_cpu_id isolation_ucodes[] = {
+	X86_MATCH_VFM_STEPPING(INTEL_HASWELL,		 3, 0x0000001f),
+	X86_MATCH_VFM_STEPPING(INTEL_HASWELL_L,		 1, 0x0000001e),
+	X86_MATCH_VFM_STEPPING(INTEL_HASWELL_G,		 1, 0x00000015),
+	X86_MATCH_VFM_STEPPING(INTEL_HASWELL_X,		 2, 0x00000037),
+	X86_MATCH_VFM_STEPPING(INTEL_HASWELL_X,		 4, 0x0000000a),
+	X86_MATCH_VFM_STEPPING(INTEL_BROADWELL,		 4, 0x00000023),
+	X86_MATCH_VFM_STEPPING(INTEL_BROADWELL_G,	 1, 0x00000014),
+	X86_MATCH_VFM_STEPPING(INTEL_BROADWELL_D,	 2, 0x00000010),
+	X86_MATCH_VFM_STEPPING(INTEL_BROADWELL_D,	 3, 0x07000009),
+	X86_MATCH_VFM_STEPPING(INTEL_BROADWELL_D,	 4, 0x0f000009),
+	X86_MATCH_VFM_STEPPING(INTEL_BROADWELL_D,	 5, 0x0e000002),
+	X86_MATCH_VFM_STEPPING(INTEL_BROADWELL_X,	 1, 0x0b000014),
+	X86_MATCH_VFM_STEPPING(INTEL_SKYLAKE_X,		 3, 0x00000021),
+	X86_MATCH_VFM_STEPPING(INTEL_SKYLAKE_X,		 4, 0x00000000),
+	X86_MATCH_VFM_STEPPING(INTEL_SKYLAKE_X,		 5, 0x00000000),
+	X86_MATCH_VFM_STEPPING(INTEL_SKYLAKE_X,		 6, 0x00000000),
+	X86_MATCH_VFM_STEPPING(INTEL_SKYLAKE_X,		 7, 0x00000000),
+	X86_MATCH_VFM_STEPPING(INTEL_SKYLAKE_X,		11, 0x00000000),
+	X86_MATCH_VFM_STEPPING(INTEL_SKYLAKE_L,		 3, 0x0000007c),
+	X86_MATCH_VFM_STEPPING(INTEL_SKYLAKE,		 3, 0x0000007c),
+	X86_MATCH_VFM_STEPPING(INTEL_KABYLAKE,		 9, 0x0000004e),
+	X86_MATCH_VFM_STEPPING(INTEL_KABYLAKE_L,	 9, 0x0000004e),
+	X86_MATCH_VFM_STEPPING(INTEL_KABYLAKE_L,	10, 0x0000004e),
+	X86_MATCH_VFM_STEPPING(INTEL_KABYLAKE_L,	11, 0x0000004e),
+	X86_MATCH_VFM_STEPPING(INTEL_KABYLAKE_L,	12, 0x0000004e),
+	X86_MATCH_VFM_STEPPING(INTEL_KABYLAKE,		10, 0x0000004e),
+	X86_MATCH_VFM_STEPPING(INTEL_KABYLAKE,		11, 0x0000004e),
+	X86_MATCH_VFM_STEPPING(INTEL_KABYLAKE,		12, 0x0000004e),
+	X86_MATCH_VFM_STEPPING(INTEL_KABYLAKE,		13, 0x0000004e),
 	{}
 };
 
 static void intel_check_pebs_isolation(void)
 {
-	x86_pmu.pebs_no_isolation = !x86_cpu_has_min_microcode_rev(isolation_ucodes);
+	x86_pmu.pebs_no_isolation = !x86_match_min_microcode_rev(isolation_ucodes);
 }
 
 static __init void intel_pebs_isolation_quirk(void)
@@ -5385,16 +5385,16 @@ static __init void intel_pebs_isolation_
 	intel_check_pebs_isolation();
 }
 
-static const struct x86_cpu_desc pebs_ucodes[] = {
-	INTEL_CPU_DESC(INTEL_SANDYBRIDGE,	7, 0x00000028),
-	INTEL_CPU_DESC(INTEL_SANDYBRIDGE_X,	6, 0x00000618),
-	INTEL_CPU_DESC(INTEL_SANDYBRIDGE_X,	7, 0x0000070c),
+static const struct x86_cpu_id pebs_ucodes[] = {
+	X86_MATCH_VFM_STEPPING(INTEL_SANDYBRIDGE,	7, 0x00000028),
+	X86_MATCH_VFM_STEPPING(INTEL_SANDYBRIDGE_X,	6, 0x00000618),
+	X86_MATCH_VFM_STEPPING(INTEL_SANDYBRIDGE_X,	7, 0x0000070c),
 	{}
 };
 
 static bool intel_snb_pebs_broken(void)
 {
-	return !x86_cpu_has_min_microcode_rev(pebs_ucodes);
+	return !x86_match_min_microcode_rev(pebs_ucodes);
 }
 
 static void intel_snb_check_microcode(void)
diff -puN arch/x86/include/asm/cpu_device_id.h~zap-x86_cpu_desc arch/x86/include/asm/cpu_device_id.h
--- a/arch/x86/include/asm/cpu_device_id.h~zap-x86_cpu_desc	2024-11-20 12:22:05.468400705 -0800
+++ b/arch/x86/include/asm/cpu_device_id.h	2024-11-20 12:22:05.472400858 -0800
@@ -226,6 +226,24 @@
 		steppings, X86_FEATURE_ANY, data)
 
 /**
+ * X86_MATCH_VFM_STEPPING - Match encoded vendor/family/model/stepping
+ * @vfm:	Encoded 8-bits each for vendor, family, model
+ * @stepping:	A single integer stepping
+ * @data:	Driver specific data or NULL. The internal storage
+ *		format is unsigned long. The supplied value, pointer
+ *		etc. is cast to unsigned long internally.
+ *
+ * feature is set to wildcard
+ */
+#define X86_MATCH_VFM_STEPPING(vfm, stepping, data)	\
+	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(	\
+		VFM_VENDOR(vfm),			\
+		VFM_FAMILY(vfm),			\
+		VFM_MODEL(vfm),				\
+		X86_STEPPINGS(stepping, stepping), 	\
+		X86_FEATURE_ANY, data)
+
+/**
  * X86_MATCH_VFM_FEATURE - Match encoded vendor/family/model/feature
  * @vfm:	Encoded 8-bits each for vendor, family, model
  * @feature:	A X86_FEATURE bit
_

