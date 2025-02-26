Return-Path: <linux-kernel+bounces-534941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1C0A46CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 554247A7B38
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69350257436;
	Wed, 26 Feb 2025 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LS1DfNh4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6EF14A627
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603805; cv=none; b=RM6i23w2hT6AQ7upM7iB/4UKgr0ohRARVz6GcfV0yCvuvbT22XxKp3cbIxRBJ8JPzLaGYSWuhdVIu3cZ1TxkZokthfpvn+qnyIjmzIbMBJGnTjwgbZD2GhdB4aemstBq6rjIUne0XU8XsV7D37PLWDx1f3vddMc6XQvVscRPKJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603805; c=relaxed/simple;
	bh=GG6eP8hGlCnaTCIECJ67ViXN53rEFv/96LvtDYb5/xk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GROjCe1ZCdbp3c+fQCLLNcbiFcEVUXw3LBK2PfCMVPNSSeTeiqASM2Cm9F9PRBd2jQjKLnec1Mq/EcKpFaNTO5B9H5fyAjHvJktvHhLM/iPGDyILgi0G8gsRz1GhYFrTDeMUj/Y0vsoGU8lfMnLwyP7FgaM1MKUIzlGUn/iCDeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LS1DfNh4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740603804; x=1772139804;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GG6eP8hGlCnaTCIECJ67ViXN53rEFv/96LvtDYb5/xk=;
  b=LS1DfNh4M36i9zcAelGOWIOqw+1Wt9zejfcLCmVl1GJJyAiHC4VmadLd
   7N9UfCh1s8SU1sbp2ST/jhH4q6zUyBzUeLSLlIkv9nlZ3tL/G9uAkTlNf
   wM1WnWlY/+7JAAvevyvrB72ja9NY6Vetp2u5gWHNq5AoXNXoATgE+dC7p
   iLeUUTbs2STOW0pGhCgUxuizDFT6Abr7hM6w9IDKjlV08mtX1Sf/ql8Da
   MCkkz7oynI4F0mXTj2PeSL0agzwJfQZYTpNDsoHuOFtK/xQ9G04Izh8BY
   6/ESUbCs30V3L12yuapdWqOIKt76YP0q+aX40T1KosBdzg9pCusxhUHw/
   w==;
X-CSE-ConnectionGUID: n51TYrQBQ6K+ihZN8MLgnA==
X-CSE-MsgGUID: ycIMKQLqT2OrM7ALcd9fkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="51679815"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="51679815"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 13:03:23 -0800
X-CSE-ConnectionGUID: Trre83WvR+ajWd8kA2F6oQ==
X-CSE-MsgGUID: d0stJ1BoSVGNtxPb2oCrxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="117302105"
Received: from unknown (HELO desk) ([10.125.145.169])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 13:03:22 -0800
Date: Wed, 26 Feb 2025 13:03:22 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] x86/speculation: Simplify and make CALL_NOSPEC consistent
Message-ID: <20250226-call-nospec-v1-1-4dde04a5c7a7@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAAGBv2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMz3eTEnBzdvPzigtRk3SRLEwsDizSDlGRzUyWgjoKi1LTMCrBp0bG
 1tQALnqd2XQAAAA==
X-Mailer: b4 0.14.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

CALL_NOSPEC macro is used to generate Spectre-v2 mitigation friendly
indirect branches. At compile time the macro defaults to indirect branch,
and at runtime those can be patched to thunk based mitigations.

This approach is opposite of what is done for the rest of the kernel, where
the compile time default is to replace indirect calls with retpoline thunk
calls.

Make CALL_NOSPEC consistent with the rest of the kernel, default to
retpoline thunk at compile time when CONFIG_MITIGATION_RETPOLINE is
enabled.

Also add the missing __CS_PREFIX to the CALL_NOSPEC macro.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/nospec-branch.h | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 7e8bf78c03d5..f12f83e7deb6 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -200,7 +200,7 @@
 /*
  * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
  * to the retpoline thunk with a CS prefix when the register requires
- * a RAX prefix byte to encode. Also see apply_retpolines().
+ * a REX prefix byte to encode. Also see apply_retpolines().
  */
 .macro __CS_PREFIX reg:req
 	.irp rs,r8,r9,r10,r11,r12,r13,r14,r15
@@ -420,20 +420,28 @@ static inline void call_depth_return_thunk(void) {}
 
 #ifdef CONFIG_X86_64
 
+/*
+ * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
+ * to the retpoline thunk with a CS prefix when the register requires
+ * a REX prefix byte to encode. Also see apply_retpolines().
+ */
+#define __CS_PREFIX(reg)				\
+	.irp rs,r8,r9,r10,r11,r12,r13,r14,r15;		\
+	.ifc \\rs, \reg;				\
+	.byte 0x2e;					\
+	.endif;						\
+	.endr;
+
 /*
  * Inline asm uses the %V modifier which is only in newer GCC
  * which is ensured when CONFIG_MITIGATION_RETPOLINE is defined.
  */
-# define CALL_NOSPEC						\
-	ALTERNATIVE_2(						\
-	ANNOTATE_RETPOLINE_SAFE					\
-	"call *%[thunk_target]\n",				\
-	"call __x86_indirect_thunk_%V[thunk_target]\n",		\
-	X86_FEATURE_RETPOLINE,					\
-	"lfence;\n"						\
-	ANNOTATE_RETPOLINE_SAFE					\
-	"call *%[thunk_target]\n",				\
-	X86_FEATURE_RETPOLINE_LFENCE)
+#ifdef CONFIG_MITIGATION_RETPOLINE
+#define CALL_NOSPEC	__stringify(__CS_PREFIX(%V[thunk_target]))	\
+			"call __x86_indirect_thunk_%V[thunk_target]\n"
+#else
+#define CALL_NOSPEC	"call *%[thunk_target]\n"
+#endif
 
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
 

---
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250226-call-nospec-b94808f0dc75

Best regards,
-- 
Thanks,
Pawan



