Return-Path: <linux-kernel+bounces-440613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112709EC1B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF5E163111
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12FE1442F2;
	Wed, 11 Dec 2024 01:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SN52z7Dj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6D378F45
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733881504; cv=none; b=AhbrqgeDpze7SuyLgJBCSf9V1mqCWFQAgUTqe2Iu59RQB4lFmpKC7Hrg9GPi+wJNDTtRmT+taIt0smPoW0S4t0XJ3wnAS6t/DBFNl1zSFFZKI/b5ZuGLOR0AGirksgumRCr7OuTny/54IgF6J9GCVhIQcun49UduMqtlyKSyFBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733881504; c=relaxed/simple;
	bh=dnfRWuklmHMwBxHmrVWAJ1lCKXUq+MqgzFsO4Z69n7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dAPTsxCKme3IBQJ1cV90ZaLseMdRoburjqSRMrPiCtPxbnnL80iMWmMIiSoiPVKygsM1R7IN+5h5pX9L0JLoXMXQInLlkmrj52+uFWFZzRuNljd+/UTFbhncmrcltCj7CcxxUs33BxkaxzqpfwV/6bis0WclXF3wQ8BLrqf19j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SN52z7Dj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733881503; x=1765417503;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dnfRWuklmHMwBxHmrVWAJ1lCKXUq+MqgzFsO4Z69n7U=;
  b=SN52z7DjlIym/L+KojnCtWjQVobuyAjvtYy9C1eMci0caA+V9jlnJzH0
   8HB61kSCIcWxROXWc/p7GueFkRdMe3ikSdiOkCBd1MDcxJN6chYg1PvAJ
   lwn+q7u3OYjIns9nL1FQDOxIgsEfkAmdfqoCreUSSEEh51oXHyGiOVGL+
   8o6wEybFqZxyWZi9zmcI8yr2/RM42yeR5KlFch9XXprZqbMQpLanON2dF
   2Ka4Cb86mm6P5KLhYpeQ2VNtfMSW0czTPytpo/TFlLkLhLSZbqYCeeRsW
   9cI7EdzF40hiW9a8kW2WliwdCg1EhAstvgvJljt3+iaIyGqDKe4xTojlo
   w==;
X-CSE-ConnectionGUID: 1e5jcNbbR/eobtdr4co/8w==
X-CSE-MsgGUID: 1BO8JCzuRzi4cDES691YhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="38030722"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="38030722"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 17:45:02 -0800
X-CSE-ConnectionGUID: y6ilG+E3Tl+y60/RH4Lfwg==
X-CSE-MsgGUID: ZmzutGg3Rk+a1u+0PS3HrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96081217"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.134.127])
  by fmviesa009.fm.intel.com with ESMTP; 10 Dec 2024 17:45:02 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH] x86/fpu: Refine magic number check during signal return
Date: Tue, 10 Dec 2024 17:45:00 -0800
Message-ID: <20241211014500.3738-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before restoring xstate from the user space buffer, the kernel performs
sanity checks on these magic numbers: magic1 in the software reserved
area, and magic2 at the end of XSAVE region.

The position of magic2 is calculated based on the xstate size derived
from the user space buffer. But, the in-kernel record is directly
available and reliable for this purpose.

This reliance on user space data is also inconsistent with the recent
fix in commit d877550eaf2d ("x86/fpu: Stop relying on userspace for info
to fault in xsave buffer").

Simply use fpstate->user_size, and then get rid of unnecessary
size-evaluation code.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kernel/fpu/signal.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 8f62e0666dea..6c69cb28b298 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -27,19 +27,14 @@
 static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
 					    struct _fpx_sw_bytes *fx_sw)
 {
-	int min_xstate_size = sizeof(struct fxregs_state) +
-			      sizeof(struct xstate_header);
 	void __user *fpstate = fxbuf;
 	unsigned int magic2;
 
 	if (__copy_from_user(fx_sw, &fxbuf->sw_reserved[0], sizeof(*fx_sw)))
 		return false;
 
-	/* Check for the first magic field and other error scenarios. */
-	if (fx_sw->magic1 != FP_XSTATE_MAGIC1 ||
-	    fx_sw->xstate_size < min_xstate_size ||
-	    fx_sw->xstate_size > current->thread.fpu.fpstate->user_size ||
-	    fx_sw->xstate_size > fx_sw->extended_size)
+	/* Check for the first magic field */
+	if (fx_sw->magic1 != FP_XSTATE_MAGIC1)
 		goto setfx;
 
 	/*
@@ -48,7 +43,7 @@ static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
 	 * fpstate layout with out copying the extended state information
 	 * in the memory layout.
 	 */
-	if (__get_user(magic2, (__u32 __user *)(fpstate + fx_sw->xstate_size)))
+	if (__get_user(magic2, (__u32 __user *)(fpstate + current->thread.fpu.fpstate->user_size)))
 		return false;
 
 	if (likely(magic2 == FP_XSTATE_MAGIC2))
-- 
2.45.2


