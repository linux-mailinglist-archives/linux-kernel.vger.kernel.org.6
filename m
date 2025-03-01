Return-Path: <linux-kernel+bounces-539754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 377B2A4A825
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3B2189C4D0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65229135A53;
	Sat,  1 Mar 2025 02:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PidTmRfc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4C9179BC
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 02:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740796560; cv=none; b=G3fyF8GPJDGH4o6d55irokF2J25G/2juKtxVBuAxASNJ4qLTT3Gwf7BL9z0sd/hjrE16esKTngR+e07fcc4l5M3EgOQvt/rMQTZkzW5jIjZXSGA/WTi2oEUFIKOSYreH5ekqQXzqw7MAkhBxdVS7nhxV5vWpdRDCcnw4IljFBkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740796560; c=relaxed/simple;
	bh=CQ+IcRYoRr0+g0t8Yj4bfF+X7kUz6gHhiAllHH9+SGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2K90GswbxDi69gWIQSY9i3uEBlvmvVDjpF78ts3nVfTBLi40LUYz2CwVCQio1UAFN4RcD2WLLtituqxD6l3asTIT7dVJwE8DxDykx1AUj40OCyqHd6bYjCyp4ovtyJXCG9Oe1zIdb5lIhCqeuPryHeXvul69dlraLxWbRAuvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PidTmRfc; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740796559; x=1772332559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CQ+IcRYoRr0+g0t8Yj4bfF+X7kUz6gHhiAllHH9+SGg=;
  b=PidTmRfcwkEf7H0ITazX7uzJ5SsWRjLMonYfVaDo9vAb/gYFr/xMwTLp
   fJH1rbGV9lWQNXPIJR3juRuGlqIe9OPdxhKoW9gPNflCq4cpCPvb+zCBj
   G6yh9DHK0lA52NKZDnBeCzGzZTAErKJ/Piuv98dOm1RJzeEbXEhMfqRe9
   uxBky05MD2wmNOcqlYU/0El3op6r4gCFIvINGcImsK18tIQo/8fjxMz7r
   /UfQZ8wuAvGVkeb/zkbhrjTt6/UbUvbbeSOtREYtLcgsOV38bq1WW1zcJ
   u03hDXVYr2Tw72BpsLZqK0OMCK6jISa+YFSE4xu+uWeywitT+v5eqtaiv
   Q==;
X-CSE-ConnectionGUID: 2Gma+uxRRr6Pe9o+sTRAdg==
X-CSE-MsgGUID: r2XD1BzcQG+lRmbe2uikzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41763582"
X-IronPort-AV: E=Sophos;i="6.13,324,1732608000"; 
   d="scan'208";a="41763582"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 18:35:59 -0800
X-CSE-ConnectionGUID: sgLjp767QeOnRsa5dUaytw==
X-CSE-MsgGUID: 8pAyXkpbSxmeXRM8nE/JRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154673257"
Received: from mderakhs-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.171])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 18:35:59 -0800
Date: Fri, 28 Feb 2025 18:35:58 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] x86/speculation: Add a conditional CS prefix to
 CALL_NOSPEC
Message-ID: <20250228-call-nospec-v3-2-96599fed0f33@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20250228-call-nospec-v3-0-96599fed0f33@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-call-nospec-v3-0-96599fed0f33@linux.intel.com>

Retpoline mitigation for spectre-v2 uses thunks for indirect branches. To
support this mitigation compilers add a CS prefix with
-mindirect-branch-cs-prefix. For an indirect branch in asm, this needs to
be added manually.

CS prefix is already being added to indirect branches in asm files, but not
in inline asm. Add CS prefix to CALL_NOSPEC for inline asm as well. There
is no JMP_NOSPEC for inline asm.

Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/nospec-branch.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 1e6b915ce956..aee26bb8230f 100644
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
@@ -420,12 +419,24 @@ static inline void call_depth_return_thunk(void) {}
 
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
 #ifdef CONFIG_MITIGATION_RETPOLINE
-#define CALL_NOSPEC	"call __x86_indirect_thunk_%V[thunk_target]\n"
+#define CALL_NOSPEC	__CS_PREFIX("%V[thunk_target]")	\
+			"call __x86_indirect_thunk_%V[thunk_target]\n"
 #else
 #define CALL_NOSPEC	"call *%[thunk_target]\n"
 #endif

-- 
2.34.1



