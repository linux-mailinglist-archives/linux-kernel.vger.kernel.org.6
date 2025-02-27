Return-Path: <linux-kernel+bounces-537099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32893A48810
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB6A16954B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8581F26B2DF;
	Thu, 27 Feb 2025 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCul949R"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F0126B966
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681908; cv=none; b=mgFJYzyjfRoPWIv06cQxkU3UF2cIhbWZxBLUr7kUn0LvRnewbIPv5o3EhsIA6PcQhA/9Deui2PUGc9to0Zx1rfbIj467+b4W7+vBvZlM3au6Sl4s3/ChWlf3rau2fpLbKWVIJGckpiL6rLs8MNIasAZAwoa+aMHg9wrBJys/3Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681908; c=relaxed/simple;
	bh=xeZi8+e1HOiLrt4irUuPbX2XdqRh/jCjNzv6den6hjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SFwm7LM9AnL08Pz291p3Ykn/IJgdZlsES+cVYPV8bfUXLjM/Tq929ecBu2Vi+Ft4SXxQO9PWd8/Gl2N3BpTCyUF3QSywzcFBFVv4TmtsaxSmRd8ZLX6ofXOjfLZSkUSeXZWjyrZAmFC+IyfdZwpVdyON8O9/CiEfWKorxjHLfog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DCul949R; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740681907; x=1772217907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xeZi8+e1HOiLrt4irUuPbX2XdqRh/jCjNzv6den6hjA=;
  b=DCul949RLoe+T5Gbw7oU834iAFlBzT4ikYAhVs7bGze9Ms9Cnj8tj6+8
   McjV1g7oUdWQ+sMRfXvwq27hjzBVhU3AvtZNY97KYuNhbZwOMILINITCp
   2FYLb4UvslOTcrMngyhmysT110nAr5YY8lFfSW9Y+5q8La4KJPrHlrXuf
   TkePphL+O0b1S3NQrUNwP/qdZ3E8T5miuY9wUAbXrZ0SW/xMTo8iy2rZb
   ATYAg7ORlJK+h120AwGOxtFc30Yvl68FlnG/3lv1f4QvyrB9ZrZVnJqBO
   pnBZ8uPw9xbAjCxGTTI6w1JrciRNrnfk3wjvcxJzTlpczHPiGGdAkdyWV
   Q==;
X-CSE-ConnectionGUID: YkWUJzCJRx+2RDS8RRezKQ==
X-CSE-MsgGUID: VtchJlpES0Ka+WE98gJR/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41720863"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41720863"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 10:45:06 -0800
X-CSE-ConnectionGUID: n9kNdMlYTwKoPL5QDHGP2Q==
X-CSE-MsgGUID: 0i7MoiuMRySCfb+c/giU/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117767380"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.246.154.132])
  by fmviesa009.fm.intel.com with ESMTP; 27 Feb 2025 10:45:06 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC v1 02/11] x86/fpu/xstate: Introduce xstate order table and accessor macro
Date: Thu, 27 Feb 2025 10:44:47 -0800
Message-ID: <20250227184502.10288-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250227184502.10288-1-chang.seok.bae@intel.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The kernel has largely assumed that higher xstate component numbers
correspond to later offsets in the buffer. However, this assumption does
not hold for the non-compacted format, where a newer state component may
have a lower offset.

When iterating over xstate components in offset order, using the feature
number as an index may be misleading. At the same time, the CPU exposes
each component’s size and offset based on its feature number, making it a
key for state information.

To provide flexibility in handling xstate ordering, add a mapping table:
feature order -> feature number. This new array stores feature numbers in
offset order, accompanied by an accessor macro.

The macro enables sequential traversal of xstate components based on
their actual buffer positions, given a feature bitmask. This will be
particularly useful for computing customized non-compacted format sizes
and sequentially accessing xstate offsets over non-compacted buffers.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
This lays the groundwork for handling APX, which has feature number 19
but appears immediately after FEATURE_YMM, occupying the space previously
reserved for the now-deprecated MPX state.
---
 arch/x86/kernel/fpu/xstate.c | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 6a41d1610d8b..cee9a1e454b7 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -91,6 +91,43 @@ static unsigned int xstate_flags[XFEATURE_MAX] __ro_after_init;
 #define XSTATE_FLAG_SUPERVISOR	BIT(0)
 #define XSTATE_FLAG_ALIGNED64	BIT(1)
 
+/*
+ * Ordering of xstate components in non-compacted format:  The xfeature
+ * number does not necessarily indicate its position in the XSAVE buffer.
+ * This array defines the traversal order of xstate features, included in
+ * XFEATURE_MASK_USER_SUPPORTED.
+ */
+static const enum xfeature xfeature_noncompact_order[] = {
+	XFEATURE_FP,
+	XFEATURE_SSE,
+	XFEATURE_YMM,
+	XFEATURE_BNDREGS,
+	XFEATURE_BNDCSR,
+	XFEATURE_OPMASK,
+	XFEATURE_ZMM_Hi256,
+	XFEATURE_Hi16_ZMM,
+	XFEATURE_PKRU,
+	XFEATURE_XTILE_CFG,
+	XFEATURE_XTILE_DATA,
+};
+
+static inline unsigned int next_xfeature_order(unsigned int i, u64 mask)
+{
+	for (; i < ARRAY_SIZE(xfeature_noncompact_order); i++) {
+		if (mask & BIT_ULL(xfeature_noncompact_order[i]))
+			break;
+	}
+
+	return i;
+}
+
+/* Iterate xstate features in non-compacted order */
+#define for_each_extended_xfeature_in_order(i, mask)		\
+	for (i = XFEATURE_YMM;					\
+	     i = next_xfeature_order(i, mask),			\
+	     i < ARRAY_SIZE(xfeature_noncompact_order);	\
+	     i++)
+
 /*
  * Return whether the system supports a given xfeature.
  *
-- 
2.45.2


