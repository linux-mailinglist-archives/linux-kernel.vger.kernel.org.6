Return-Path: <linux-kernel+bounces-514167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD2DA3537A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16EB16C749
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 01:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49855D8F0;
	Fri, 14 Feb 2025 01:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+vpvPHP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08EF288DA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739495173; cv=none; b=qgAxg9OvPbwHeXwuP9IsAxvNrFMc6gKH1z36YvhlPRchZ+2BF/Qhs5XaSodb6knezRZpv27pNeuK36Jv8Ya+40HbBjXeKnMH8KSWSf8cIzmfLJKyBfwesMg0uSRhze2JQLl1S5fe/OshNPhg0WbXhqaSkMO7HxmVTeB2LopsTzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739495173; c=relaxed/simple;
	bh=0i0GMAsCubBdH+YuhDk9QE44ViClRvmeQt0QTCO8ksY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D28+o+TH1rm0fUXTuuewrp8obusTpRaRhcatoe6HtrHP5PAsjnJYN1+u6DKxndycqEg+S2Mj9ZD0CC1hs6wpsgo/Idp0wC/x3aA6LmJxePwRBnEn9WeTFJgJdWYZLPQeKujz7YuiZnjnjYK2b58IDoGCoEN1Z0CotsPs+n4hU3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M+vpvPHP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739495172; x=1771031172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0i0GMAsCubBdH+YuhDk9QE44ViClRvmeQt0QTCO8ksY=;
  b=M+vpvPHP4Gs7dmR2RRIs5Yilb5CBPWNC7zJ9BrkROwBghdSzcKW7hFN2
   fEo1wcvkWv52E36glolvQZS/rXMJlCrgazKzuu71RVMe+6BlpkBpWRZdU
   W66MYNOLfQ9filelsAKdSFZsPdC0Xf7qu6H9Hi8+BLAdUJxMQqFXbbVmb
   h0+8cyd0mz3WLUCJm9LhuxqClAlwb+NhDrfnQZ43CXl/0H+NoiukxGy+I
   ddcw+UxkHoLUndbx6OGZ/fjsmLC+OcSvWkcdoNDLBpkfqXaZwFkkpeH1u
   RmRfinOFnKpW0t7uIwG8Pmw8vAGl8vs6vaAe1WAohCvraJOdQTLPoSqCE
   g==;
X-CSE-ConnectionGUID: D6JvPbVnSZOzv+u6PibS7Q==
X-CSE-MsgGUID: dk2KMr0RR8q7qmABfQpwhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="50442869"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="50442869"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 17:06:10 -0800
X-CSE-ConnectionGUID: KIUsbOxxS4ece7jhN18C2Q==
X-CSE-MsgGUID: 1vk4HIIfTAuYvzZxbnvIeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="118402584"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.246.154.132])
  by fmviesa004.fm.intel.com with ESMTP; 13 Feb 2025 17:06:09 -0800
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
Subject: [PATCH 1/2] x86/fpu: Refactor xfeature bitmask update code for sigframe XSAVE
Date: Thu, 13 Feb 2025 17:06:06 -0800
Message-ID: <20250214010607.7067-2-chang.seok.bae@intel.com>
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

Currently, saving register states in the signal frame, the legacy feature
bits are always set in xregs_state->header->xfeatures. This code sequence
can be generalized for reuse in similar cases.

Refactor the logic to ensure a consistent approach across similar usages.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kernel/fpu/signal.c | 11 +----------
 arch/x86/kernel/fpu/xstate.h | 12 ++++++++++++
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 8f62e0666dea..8abe60919e2f 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -119,7 +119,6 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
 {
 	struct xregs_state __user *x = buf;
 	struct _fpx_sw_bytes sw_bytes = {};
-	u32 xfeatures;
 	int err;
 
 	/* Setup the bytes not touched by the [f]xsave and reserved for SW. */
@@ -132,12 +131,6 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
 	err |= __put_user(FP_XSTATE_MAGIC2,
 			  (__u32 __user *)(buf + fpstate->user_size));
 
-	/*
-	 * Read the xfeatures which we copied (directly from the cpu or
-	 * from the state in task struct) to the user buffers.
-	 */
-	err |= __get_user(xfeatures, (__u32 __user *)&x->header.xfeatures);
-
 	/*
 	 * For legacy compatible, we always set FP/SSE bits in the bit
 	 * vector while saving the state to the user context. This will
@@ -149,9 +142,7 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
 	 * header as well as change any contents in the memory layout.
 	 * xrestore as part of sigreturn will capture all the changes.
 	 */
-	xfeatures |= XFEATURE_MASK_FPSSE;
-
-	err |= __put_user(xfeatures, (__u32 __user *)&x->header.xfeatures);
+	err |= set_xfeature_in_sigframe(x, XFEATURE_MASK_FPSSE);
 
 	return !err;
 }
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index aa16f1a1bbcf..27e20236bbbb 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -69,6 +69,18 @@ static inline u64 xfeatures_mask_independent(void)
 	return fpu_kernel_cfg.independent_features;
 }
 
+static inline int set_xfeature_in_sigframe(struct xregs_state __user *xbuf, u64 mask)
+{
+	u64 xfeatures;
+	int err;
+
+	/* Read the xfeatures value already saved in the user buffer */
+	err  = __get_user(xfeatures, &xbuf->header.xfeatures);
+	xfeatures |= mask;
+	err |= __put_user(xfeatures, &xbuf->header.xfeatures);
+	return err;
+}
+
 /*
  * Update the value of PKRU register that was already pushed onto the signal frame.
  */
-- 
2.45.2


