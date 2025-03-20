Return-Path: <linux-kernel+bounces-570161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A52A6ACF1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487DB1887046
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6EF22687A;
	Thu, 20 Mar 2025 18:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TnrNuAgf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A5A22577D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742494399; cv=none; b=XHTXD5w1rqyqZpPIqeZqoLMtVV2PJ7AM6Jqs6U/wM4wYNzrR3p+JycizvPOVo4PbwKgqo4aPDKLTDv+mxYfafgiLoNz5SYkEbAcsoOsD/4EdfmhhFnAGfP8vrC65lwU+Chdj1/atuR+Kn/CFHBzZmffYMwCBuvkBUgUWZMfGI+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742494399; c=relaxed/simple;
	bh=TKac0OVyHm5g+XYFmscFLiEoBpTxNy7X9/P/BcrBgfY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qh5vK/kSSLkVT8y+hU/iduiC93oDh6d58TYCuB93KxX6bcv5wn8u720mFFDqqxGo0FpmK2Abz2bDQKBzHG70hZX2IZVrcQsRVM2JSibNRJP6x5qIx0tTbSKPPzANd7+DDljLmCmv/bZRcXMVnIDbxe+N9RX9LmlqwrQxYvlW9VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TnrNuAgf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742494398; x=1774030398;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TKac0OVyHm5g+XYFmscFLiEoBpTxNy7X9/P/BcrBgfY=;
  b=TnrNuAgfV2iZMbtZ3xVESq8wUpreEoZzsOltVQou9DbY5pA6svM2xwLi
   X9rk82q9E1R4ucXIUqf9FJEJ3dOy6pkwDqsaOD9E228dJxT0myJ3P6rrp
   nSaHZFNYGTCl93M0nlr0XA2ITw8FD3Vnw7IsYeBUValNFjCOL9Rk5KNtC
   6lQX7KKnQwZApBnu4zcxzrDMKrlXLcULQcVsjRsQFJwkOMa1pgKRtZQ1g
   fQ6BFAQidTX4RcUPoR1797p8D/fmZNLX+BkZQmyLcwl0P49t24YF5cJaZ
   0TZL4hJrY57CerQgoXTKeZQ83l7MlVaBRYnulh/KGMbgDwJJNt/bHiZ6W
   A==;
X-CSE-ConnectionGUID: SUzFPvVDTkq14U5UTjE4FA==
X-CSE-MsgGUID: L9XwEAd5SgKfAiTOgFfDyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="66209459"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="66209459"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 11:13:16 -0700
X-CSE-ConnectionGUID: t5UJCHuZQ7+39ooGIf3NMQ==
X-CSE-MsgGUID: 0dd+PTiyRRqxoI2lxVE+dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="123345803"
Received: from unknown (HELO desk) ([10.125.145.193])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 11:13:16 -0700
Date: Thu, 20 Mar 2025 11:13:15 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [PATCH] x86/speculation: Remove the extra ifdef around CALL_NOSPEC
Message-ID: <20250320-call-nospec-extra-ifdef-v1-1-d9b084d24820@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAE5a3GcC/x3MQQqFIBRG4a3EHXfBzIraSjQw+60LYaGPRxDtP
 Wn4Dc65KSEKEg3FTRF/SXKEjKosyG02rGBZskkr3ahaK3Z23zkc6YRjXL9oWfwCz62ZTW80uqb
 vKNdnhJfrO4/T87y/XRMwaQAAAA==
X-Change-ID: 20250320-call-nospec-extra-ifdef-64b4942e7597
X-Mailer: b4 0.14.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit 010c4a461c1d ("x86/speculation: Simplify and make CALL_NOSPEC
consistent") added an ifdef CONFIG_MITIGATION_RETPOLINE around the
CALL_NOSPEC definition. This is not required as this code is already under
a larger ifdef.

Remove the extra ifdef, no functional change.

vmlinux size remains same before and after this change.

CONFIG_MITIGATION_RETPOLINE=y:
    text	   data	    bss	    dec		hex	filename
25434752	7342290	2301212	35078254	217406e	vmlinux.before
25434752	7342290	2301212	35078254	217406e	vmlinux.after

 # CONFIG_MITIGATION_RETPOLINE is not set:
    text	   data	    bss	    dec		hex	filename
22943094	6214994	1550152	30708240	1d49210	vmlinux.before
22943094	6214994	1550152	30708240	1d49210	vmlinux.after

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/nospec-branch.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index aee26bb8230f861dda7a4a568159d4cf77df45f6..c4816719150dce9f5ecc676cdcf38356fc96d166 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -434,12 +434,8 @@ static inline void call_depth_return_thunk(void) {}
  * Inline asm uses the %V modifier which is only in newer GCC
  * which is ensured when CONFIG_MITIGATION_RETPOLINE is defined.
  */
-#ifdef CONFIG_MITIGATION_RETPOLINE
 #define CALL_NOSPEC	__CS_PREFIX("%V[thunk_target]")	\
 			"call __x86_indirect_thunk_%V[thunk_target]\n"
-#else
-#define CALL_NOSPEC	"call *%[thunk_target]\n"
-#endif
 
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
 

---
base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
change-id: 20250320-call-nospec-extra-ifdef-64b4942e7597

Best regards,
-- 
Thanks,
Pawan



