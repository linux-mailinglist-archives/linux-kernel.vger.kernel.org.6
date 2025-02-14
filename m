Return-Path: <linux-kernel+bounces-514168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130ADA3537B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D831890181
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 01:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18347757F3;
	Fri, 14 Feb 2025 01:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="miaJoQLn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76D32AEE9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739495173; cv=none; b=ChcLxzsxoAd3QS5uHzYAsaC3agOo379iEL2s9os3C+d00d4GqoYyAgpD8nCqJC9CkC9u/LunLIwOBuA/FmfgX7tPxyFpXHQlTJuWokBXecfLOLRNaNlZGD3NcEoTTlHsk9C6rF9Qk52TvhmI28SQviOJFcM4aJuyMgo0v+s5fRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739495173; c=relaxed/simple;
	bh=B5Gpc6RyYyDt4dpHSTDCQR3ZXs1PU/d6aCFpCUVGGQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2DHN4INnyihbu7KumYSoEsAfZPeDfaba6wUNxyyjJedCleLwKgWrwegdseHkg7mxlLuYRDZGQGF74CLiXQa3SgHOdB9ifFMtMUvn+Q6pUjfLovIk8/6SlZcE7RC5VNRGuA7YGyGZZcU7RZBD1FyhYlPRCNXuuXyuQBrookZoFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=miaJoQLn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739495172; x=1771031172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B5Gpc6RyYyDt4dpHSTDCQR3ZXs1PU/d6aCFpCUVGGQE=;
  b=miaJoQLnCAHR2YIymn89LNAV7TXscw5rH2FQqVZAlAzLt4b3H972cP06
   gFD2r0M4KkdB9fzB16UWqel6ErSnWBeoLxfja1dX14O/v2AEUvDJR+/0o
   5GlCKGI+GiUagO26Y64rmwSj/NUVUbBqb4RMGK/hi6E4Q/nYehaP6DRtm
   4xXwis+55QgNauES1DFbxPID7Pg3XujIrmFpkuG37Z93veWqF/P6t8Lrr
   cUo27WG87/XHyL/kjNN2SDylKGFnzBc8hHYlYqIHJSryJ+xs2PnFCGxV/
   rVhjuKwMPZRdTY9NCQkoSPwaPVngqaLPM2w/4dEHmlXgK7nrV3igo5vEN
   w==;
X-CSE-ConnectionGUID: dYhNWleoTbirboeSeY8pDg==
X-CSE-MsgGUID: Pli6+5q9Qxua1AWuUB705A==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="50442879"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="50442879"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 17:06:11 -0800
X-CSE-ConnectionGUID: 4aEBIkj4QYa01zgS6z+NTw==
X-CSE-MsgGUID: n7+6oBP9R9SFAPkI60Pigg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="118402588"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.246.154.132])
  by fmviesa004.fm.intel.com with ESMTP; 13 Feb 2025 17:06:10 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	aruna.ramakrishna@oracle.com,
	TonyWWang-oc@zhaoxin.com,
	chang.seok.bae@intel.com
Subject: [PATCH 2/2] x86/pkeys: Simplify PKRU update in signal frame
Date: Thu, 13 Feb 2025 17:06:07 -0800
Message-ID: <20250214010607.7067-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250214010607.7067-1-chang.seok.bae@intel.com>
References: <20250214010607.7067-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ae6012d72fa6 ("x86/pkeys: Ensure updated PKRU value is XRSTOR'd")
modified the signal delivery logic to always set the PKRU bit in
xregs_state->header->xfeatures.

The change currently derives the bitmask value using XGETBV(1), rather
than reading the already written value directly from the buffer. Thus,
this approach induces an unnecessary dependency on XGETBV1 for the PKRU
feature.

Eliminate the dependency by using the established helper function.
Subsequently, remove the unused mask argument from
update_pkru_in_sigframe().

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/fpu/xstate.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 27e20236bbbb..f3fc3369a135 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -84,18 +84,15 @@ static inline int set_xfeature_in_sigframe(struct xregs_state __user *xbuf, u64
 /*
  * Update the value of PKRU register that was already pushed onto the signal frame.
  */
-static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u64 mask, u32 pkru)
+static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u32 pkru)
 {
-	u64 xstate_bv;
 	int err;
 
 	if (unlikely(!cpu_feature_enabled(X86_FEATURE_OSPKE)))
 		return 0;
 
 	/* Mark PKRU as in-use so that it is restored correctly. */
-	xstate_bv = (mask & xfeatures_in_use()) | XFEATURE_MASK_PKRU;
-
-	err =  __put_user(xstate_bv, &buf->header.xfeatures);
+	err = set_xfeature_in_sigframe(buf, XFEATURE_MASK_PKRU);
 	if (err)
 		return err;
 
@@ -316,7 +313,7 @@ static inline int xsave_to_user_sigframe(struct xregs_state __user *buf, u32 pkr
 	clac();
 
 	if (!err)
-		err = update_pkru_in_sigframe(buf, mask, pkru);
+		err = update_pkru_in_sigframe(buf, pkru);
 
 	return err;
 }
-- 
2.45.2


