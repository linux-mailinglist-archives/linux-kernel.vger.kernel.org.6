Return-Path: <linux-kernel+bounces-537107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0F4A48819
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231533A9167
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E66020E32A;
	Thu, 27 Feb 2025 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fe9ygmWv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D81026E96C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681916; cv=none; b=VH7/ExUeIdeQd8s8oqIlo4+E3Fw8TBSL8NQGGrM3fFM5uXAPXspYxwbfRxNN95OmAQlXpJ5HlU7KqWqOv2r6Ae/gS30R3AsNtczGxCsGkRbXIMJJpbQODJoZLZESWaUYpm9UxkZjXGaV6EiCJaomjG3GfgiU3iHBpBHSYZyoDuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681916; c=relaxed/simple;
	bh=EIA3pWCo7/nkJxTTlXr2tqOT4q6Di7DZB2KnMNenfYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRMV62JgfgvXGLabh+jYvn7XNddAlWzk6UcqOKzHRRrH8MQ7e06fvPBSIvFMbiDZ5TFLb30VtH3LiAqW/vMA0JIc21sZqueTE22Fa6bjT2jTIXJlSCJP4LJFuAZcu/EU5tyOYYp6D3VRA/r6LSSIiWQoiI8OtjIVX9w8F5ic18E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fe9ygmWv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740681915; x=1772217915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EIA3pWCo7/nkJxTTlXr2tqOT4q6Di7DZB2KnMNenfYQ=;
  b=Fe9ygmWvqbe1IGP7pEEYjY2ORWSCLQJZf1OTWpnFelX5PdaOqJ3m9THZ
   qghpqZ5VZtgN55lZt1oH7TJVzlOEY+EUJHov92MTKBtkRtxqZsNTnyB94
   /4jFKpZmVXCsYocXBzYXPkzcv/1rCsG6jrFjVRJu9qv/I0s99vfQsvwim
   cbM4etbZvObuHjkHUfzFLuN0YTZJryM9ld0Fmmi/Bd7lK0VKq6TVo5gNk
   2qrX6Mt9ClRC1XeLZgiIv7+uK0jRetUA3fSmiklMcZOjQ6LX2ZEwUGe5X
   wMM0FbCTF9OhiDqZQB473a7/WKnFe2jW3gN/TgBWn+d3siehdTwmX4HrT
   Q==;
X-CSE-ConnectionGUID: xnVhKQP0ThCwys0OygSfcw==
X-CSE-MsgGUID: vj0aJN4LT0+is3jMfxxkaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41720920"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41720920"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 10:45:15 -0800
X-CSE-ConnectionGUID: D3MW4hf7Rm6VpVDC+UEIBA==
X-CSE-MsgGUID: Oc8TRvsNQjCALQ1CxkV3JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117767444"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.246.154.132])
  by fmviesa009.fm.intel.com with ESMTP; 27 Feb 2025 10:45:14 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC v1 10/11] x86/fpu/apx: Enable APX state support
Date: Thu, 27 Feb 2025 10:44:55 -0800
Message-ID: <20250227184502.10288-11-chang.seok.bae@intel.com>
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

With securing APX against conflicting MPX, it is now ready to be enabled.
Include APX in the enabled xfeature set.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/include/asm/fpu/xstate.h | 3 ++-
 arch/x86/kernel/fpu/xstate.c      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index e87d36a31ab1..6e3cba7b0068 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -30,7 +30,8 @@
 				      XFEATURE_MASK_ZMM_Hi256 | \
 				      XFEATURE_MASK_Hi16_ZMM	 | \
 				      XFEATURE_MASK_PKRU | \
-				      XFEATURE_MASK_XTILE)
+				      XFEATURE_MASK_XTILE | \
+				      XFEATURE_MASK_APX)
 
 /*
  * Features which are restored when returning to user space.
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 0f731e11c414..d42abad5a0d4 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -361,7 +361,8 @@ static __init void os_xrstor_booting(struct xregs_state *xstate)
 	 XFEATURE_MASK_PKRU |			\
 	 XFEATURE_MASK_PASID |			\
 	 XFEATURE_MASK_CET_USER |		\
-	 XFEATURE_MASK_XTILE)
+	 XFEATURE_MASK_XTILE |			\
+	 XFEATURE_MASK_APX)
 
 /*
  * setup the xstate image representing the init state
-- 
2.45.2


