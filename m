Return-Path: <linux-kernel+bounces-539753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D49BA4A823
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47C527A8A55
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855EB8615A;
	Sat,  1 Mar 2025 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qys1JihI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D8220326
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 02:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740796546; cv=none; b=XHL42FLyTxAI20fb9Zlav74CjdOlu27j7UBK38m3yt+7Kt8GhB1tnztHVB1SrlDS5y+Ro6RaWYhAIjr6YJQtSZT1+9lKlvQ3l4/RadotM8HSzlFFqCi0ZF4NsPcDT7oO7WjKwzhq6nx9w3wBEIRkpTI8HBBv9Qcrc85gWKzT+jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740796546; c=relaxed/simple;
	bh=Tyt6+uRavoW7j1t6zV+KU/R0u+16ApbRZSwsE6YjELY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIo+9jhw6DFORGxafxq5C8EllP5AKm5Ic53pgUSCvA7BU/01RZscncLKZPrKkobC242Crxd54psZ1GUxhhgJQLs41xbvFV2rWlgCtWaLdIxGLsU+DNOVY3kltfzaSlhWACQALiYxbVRc/osh+0xX5MZXOITUqUoGWfD0N5YqQcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qys1JihI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740796544; x=1772332544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tyt6+uRavoW7j1t6zV+KU/R0u+16ApbRZSwsE6YjELY=;
  b=Qys1JihIkw8Zn8c1PhhAzL7mTU96Cs38SC35pri+LxFkduDXwUZz+0ml
   xelHVpkMg+xsyCQMl/lsAk1Y805bSwRXDNy6rajRmkfZEDxV9AlCc6lrJ
   sQj/Y0DQp39F2gGd9aj0KW48tWBKIK6VgKeulcuBsXurMT/PFKiHrVKoS
   PeGsZFasV8MUulWXeX8r2VwCIub8Plc8Fc+0jMi9tUeX1GRLFtHQ4/R2B
   KetagALy98idz/3jLvtuzYLNSxY8D3YgBL4Ehplg/zjK9cykWXoZeYCmP
   JgiDA0DNz4IB5f25WND/DfjU0L8eFyxi5cqE/eHDGeTKoQVuv4U+ob4lC
   Q==;
X-CSE-ConnectionGUID: h3/Fke88S+qUMXBmHB4tvA==
X-CSE-MsgGUID: TYr0YFOjT9WW9ho/6SClbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41856640"
X-IronPort-AV: E=Sophos;i="6.13,324,1732608000"; 
   d="scan'208";a="41856640"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 18:35:43 -0800
X-CSE-ConnectionGUID: OAQQ7sqXQ2moyjHFVld/5A==
X-CSE-MsgGUID: +nBL7u3NTHuTkurwTrQvVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118400682"
Received: from mderakhs-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.171])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 18:35:44 -0800
Date: Fri, 28 Feb 2025 18:35:43 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] x86/speculation: Simplify and make CALL_NOSPEC
 consistent
Message-ID: <20250228-call-nospec-v3-1-96599fed0f33@linux.intel.com>
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

CALL_NOSPEC macro is used to generate Spectre-v2 mitigation friendly
indirect branches. At compile time the macro defaults to indirect branch,
and at runtime those can be patched to thunk based mitigations.

This approach is opposite of what is done for the rest of the kernel, where
the compile time default is to replace indirect calls with retpoline thunk
calls.

Make CALL_NOSPEC consistent with the rest of the kernel, default to
retpoline thunk at compile time when CONFIG_MITIGATION_RETPOLINE is
enabled.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/nospec-branch.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 7e8bf78c03d5..1e6b915ce956 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -424,16 +424,11 @@ static inline void call_depth_return_thunk(void) {}
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
+#define CALL_NOSPEC	"call __x86_indirect_thunk_%V[thunk_target]\n"
+#else
+#define CALL_NOSPEC	"call *%[thunk_target]\n"
+#endif
 
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
 

-- 
2.34.1



