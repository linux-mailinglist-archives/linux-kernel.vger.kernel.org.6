Return-Path: <linux-kernel+bounces-537103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D8EA48815
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132C8169D82
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE8826E63C;
	Thu, 27 Feb 2025 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHaxI1wy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB9E26BD9C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681912; cv=none; b=GJH4JreX+WXKd+daJATZWgs/6rdk6DLE05CS1T+rpXIvXeMMAs3fa6rXdMFzyJLJ+BZwJ3JnSC5aFuRukqB83DGbs0KRmnfn/3iWZlGc3K6qL5dzc65tH7wZDE1LwP4kWRYJ+7JQlj5YM/womnAMjSr9LklNdPMOOakffi+ojAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681912; c=relaxed/simple;
	bh=V+c4s8pEeyQ6bzT+mGDkAOcPHrdzwdLVX510GsXvz8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TL5jR+lrvhNQMq+FvQbZqsgIkWHPpNaO792BkUGe9UmWWoyqu+7mlV1n/SqhNqxb5cfUgr1MqBzxJf0fFXDlGpddeP0eE0iS+VxB8EWnWKC7BlKVa4oelAi+CjYTno9CMLVA+YnQleZ0lknrnQgY27nJmsvYZsxIWn+lLXsoBfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHaxI1wy; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740681911; x=1772217911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V+c4s8pEeyQ6bzT+mGDkAOcPHrdzwdLVX510GsXvz8s=;
  b=XHaxI1wy2wSurt96Ps0fuGVrUrjnUAW3jaPXMauvEtP455LgUoPtZuob
   W+wpNS2ljJGJ2902kgl54C6E0g9Z0RygFSZz/iWOoY2t/LKGNzWn5VP45
   +ClAfRiBorSb+siLgPGEsjjuJJ3MdHOcJY5K0KfRN85GWnYffPFuNmHeh
   xqE1kZlLxtt1xVA3BZxMSysu75NcfrJbPlF9+UPOEv2RqC1xanVr1jYbJ
   CvZy2kSYab0DBmKn4YgbS7apFWBWOAri8dBH0+gMBFtBC5A9Q5y/eZUsF
   l+dMFCKKNWB2yf6pz3RksF9iWxbApgJUUetupyXrMXKDD5vqBxJAX0Xeq
   g==;
X-CSE-ConnectionGUID: l2BRdTR9Rm6tNxIATw54rg==
X-CSE-MsgGUID: qaCpxfhvRMW4+8Kj5g8fmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41720890"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41720890"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 10:45:10 -0800
X-CSE-ConnectionGUID: O1saL3dxRPShIsB4o2Eljw==
X-CSE-MsgGUID: eBVRfu6mTf2Fswuj/H41Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117767409"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.246.154.132])
  by fmviesa009.fm.intel.com with ESMTP; 27 Feb 2025 10:45:09 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC v1 06/11] x86/fpu/mpx: Remove MPX xstate component support
Date: Thu, 27 Feb 2025 10:44:51 -0800
Message-ID: <20250227184502.10288-7-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250227184502.10288-1-chang.seok.bae@intel.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new xstate component is set to occupy the position previously used by
MPX in the non-compacted format, then creating a fundamental conflict
between the two.

Currently, xfeature_noncompact_order[] includes MPX, but the introduction
of the new feature would cause a direct conflict there unless MPX is
removed. Fortunately, MPX support has already been deprecated and
effectively removed by commit:

    45fc24e89b7c ("x86/mpx: remove MPX from arch/x86")

Explicitly disable the deprecated feature to reserve a space for the new
xstate.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
Several code references to this feature macro remain, primarily on the
KVM side. While they are likely to become obsolete after this patch,
their cleanup has been deferred at this review stage: This can be
addressed in a follow-up patch or included as an optional part of APX
enablement, I suppose.
---
 arch/x86/include/asm/fpu/xstate.h | 2 --
 arch/x86/kernel/fpu/xstate.c      | 8 --------
 2 files changed, 10 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 7f39fe7980c5..e87d36a31ab1 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -30,8 +30,6 @@
 				      XFEATURE_MASK_ZMM_Hi256 | \
 				      XFEATURE_MASK_Hi16_ZMM	 | \
 				      XFEATURE_MASK_PKRU | \
-				      XFEATURE_MASK_BNDREGS | \
-				      XFEATURE_MASK_BNDCSR | \
 				      XFEATURE_MASK_XTILE)
 
 /*
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index d04221d0fa0a..16f45fff8811 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -69,8 +69,6 @@ static unsigned short xsave_cpuid_features[] __initdata = {
 	[XFEATURE_FP]				= X86_FEATURE_FPU,
 	[XFEATURE_SSE]				= X86_FEATURE_XMM,
 	[XFEATURE_YMM]				= X86_FEATURE_AVX,
-	[XFEATURE_BNDREGS]			= X86_FEATURE_MPX,
-	[XFEATURE_BNDCSR]			= X86_FEATURE_MPX,
 	[XFEATURE_OPMASK]			= X86_FEATURE_AVX512F,
 	[XFEATURE_ZMM_Hi256]			= X86_FEATURE_AVX512F,
 	[XFEATURE_Hi16_ZMM]			= X86_FEATURE_AVX512F,
@@ -101,8 +99,6 @@ static const enum xfeature xfeature_noncompact_order[] = {
 	XFEATURE_FP,
 	XFEATURE_SSE,
 	XFEATURE_YMM,
-	XFEATURE_BNDREGS,
-	XFEATURE_BNDCSR,
 	XFEATURE_OPMASK,
 	XFEATURE_ZMM_Hi256,
 	XFEATURE_Hi16_ZMM,
@@ -360,8 +356,6 @@ static __init void os_xrstor_booting(struct xregs_state *xstate)
 	 XFEATURE_MASK_ZMM_Hi256 |		\
 	 XFEATURE_MASK_Hi16_ZMM	 |		\
 	 XFEATURE_MASK_PKRU |			\
-	 XFEATURE_MASK_BNDREGS |		\
-	 XFEATURE_MASK_BNDCSR |			\
 	 XFEATURE_MASK_PASID |			\
 	 XFEATURE_MASK_CET_USER |		\
 	 XFEATURE_MASK_XTILE)
@@ -555,8 +549,6 @@ static bool __init check_xstate_against_struct(int nr)
 	 */
 	switch (nr) {
 	case XFEATURE_YMM:	  return XCHECK_SZ(sz, nr, struct ymmh_struct);
-	case XFEATURE_BNDREGS:	  return XCHECK_SZ(sz, nr, struct mpx_bndreg_state);
-	case XFEATURE_BNDCSR:	  return XCHECK_SZ(sz, nr, struct mpx_bndcsr_state);
 	case XFEATURE_OPMASK:	  return XCHECK_SZ(sz, nr, struct avx_512_opmask_state);
 	case XFEATURE_ZMM_Hi256:  return XCHECK_SZ(sz, nr, struct avx_512_zmm_uppers_state);
 	case XFEATURE_Hi16_ZMM:	  return XCHECK_SZ(sz, nr, struct avx_512_hi16_state);
-- 
2.45.2


