Return-Path: <linux-kernel+bounces-537626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2683FA48E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B951891929
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6308482F2;
	Fri, 28 Feb 2025 02:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exAF7g0x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F19125B2
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740708456; cv=none; b=QKHHxW4tyQ62UnwVVUrRc/u3YGSte3nphP9QMylyRhfVcUi/0Icb6vpv31ca/0+cXEFBEQ5LHIGfd1wJSdaf36Gw02ngqf84QoDt+9KRrNolMfJm9q6Q4oMlHkJJG5P8QfX/QMsvGcGA+RjsEjpaQ24zz2EbPKoTATVrrpkX9a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740708456; c=relaxed/simple;
	bh=FDgvtZB2M1mr4d9hMNDvxDNWzzZYeZLVpt/cbsyvj8M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WuznveYdAQBBV3UeFhal/L4KarHkqyK8yI+dmxijWApgeiA3CT7NHYjFT20FHM9dE8pV3I6d7qRGmClSY9GBkDXZ/JPVCjv6NXT2qcb7kU7seh3YhmOULxcUhvGjoNwTpQUlE76ax71kb6SKVNEMFETXHJ9i8LlPmc2rmeDuh9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exAF7g0x; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740708455; x=1772244455;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FDgvtZB2M1mr4d9hMNDvxDNWzzZYeZLVpt/cbsyvj8M=;
  b=exAF7g0xJjmEwkUomcRwzcQQFihYQqQccG+qsO5CvWSXCqPWHWKLrh5t
   1U40QQGogZZvIhLT3QSkz39V8KtNEMvR5+jXbd1qmIAPp2ACWVxRp9EEt
   /Zrth5df546KlVJe3vEelwykKJVcgq4Z4FPqlYjMtUWH8UvHbPXfL0y0w
   JG/F+36eArP7DAYtMxjKFtCoPZWvXVJbXUffvwQ3gxfI59T8ALipF36kc
   Hw891mzMprYXDrCRSVj5vNJvcAUAzMvj/npLF/CaXbejzNj4lqHVuAWUq
   Y6Se56f5tVH3rm6UE8kuP1zXRFgf3VH5SuJIREg9MuD8cC3kry0LRkKKx
   A==;
X-CSE-ConnectionGUID: j4hXvAMzS9Cyc1KbdwFALw==
X-CSE-MsgGUID: mkDnH7rXSuCnUHl6OKyJIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41755930"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="41755930"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 18:07:35 -0800
X-CSE-ConnectionGUID: f4ueGVtySYaboTEPQk8TxQ==
X-CSE-MsgGUID: pRTHOEu7RmK8WxNxcRc51g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122431943"
Received: from jgarnacx-mobl1.amr.corp.intel.com (HELO desk) ([10.125.145.170])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 18:07:34 -0800
Date: Thu, 27 Feb 2025 18:07:33 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/speculation: Simplify and make CALL_NOSPEC consistent
Message-ID: <20250227-call-nospec-v2-1-895a30dceaac@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAIIUwWcC/23MQQ7CIBCF4as0s5aGErDVlfcwXSBM7SQIDVRS0
 3B3sWuX/0vet0PCSJjg2uwQMVOi4GuIUwNm1v6JjGxtEFwoLsSZGe0c8yEtaNjjIgc+TNyaXkF
 9LBEn2g7tPtaeKa0hfg48d7/1v5M71jFpLXKplel1f3Pk31tLfkXXmvCCsZTyBVaIxYKsAAAA
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

Also add the missing __CS_PREFIX to the CALL_NOSPEC macro to make it
compatible with -mindirect-branch-cs-prefix.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
v2:
- Fixed the inconsistency in the use of "\" in __CS_PREFIX. (Andrew)
- Fixed the comment to reflect that __CS_PREFIX only emits the prefix and
  not the JMP/CALL. (Andrew)

v1: https://lore.kernel.org/r/20250226-call-nospec-v1-1-4dde04a5c7a7@linux.intel.com
---
 arch/x86/include/asm/nospec-branch.h | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 7e8bf78c03d5..aee26bb8230f 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -198,9 +198,8 @@
 .endm
 
 /*
- * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
- * to the retpoline thunk with a CS prefix when the register requires
- * a RAX prefix byte to encode. Also see apply_retpolines().
+ * Emits a conditional CS prefix that is compatible with
+ * -mindirect-branch-cs-prefix.
  */
 .macro __CS_PREFIX reg:req
 	.irp rs,r8,r9,r10,r11,r12,r13,r14,r15
@@ -420,20 +419,27 @@ static inline void call_depth_return_thunk(void) {}
 
 #ifdef CONFIG_X86_64
 
+/*
+ * Emits a conditional CS prefix that is compatible with
+ * -mindirect-branch-cs-prefix.
+ */
+#define __CS_PREFIX(reg)				\
+	".irp rs,r8,r9,r10,r11,r12,r13,r14,r15\n"	\
+	".ifc \\rs," reg "\n"				\
+	".byte 0x2e\n"					\
+	".endif\n"					\
+	".endr\n"
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
+#define CALL_NOSPEC	__CS_PREFIX("%V[thunk_target]")	\
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
Pawan


