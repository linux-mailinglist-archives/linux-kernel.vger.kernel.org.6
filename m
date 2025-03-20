Return-Path: <linux-kernel+bounces-570533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2145A6B1C3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A498A62E0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAB522D7B3;
	Thu, 20 Mar 2025 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kve6RE+c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3EE22D78A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514207; cv=none; b=CNQNhbQfCfpQRDr7ED5LCbl85TgOEm68XcvrcZcq5vOT/I+XMUyAsk5JDgh7sXFP9wCcRISvt8feQtYHfVXwLTrho0XBYGZSHnbFp+cXLutjsbpQVCfLvfjJrlX7BhEGBVqt7lYAT2cubS60ka5nF0BkEyyyHKyAP8U7wJ3aAJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514207; c=relaxed/simple;
	bh=qD6P1XLuScC/GDGjJU+aH/i/e6IvzbV5XOIX9N5YGfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMoi7o0bv4F5adSKc8GNcL23CT8w+O3Q5PY59/ghFAAm8ZcvzBF4CWHUm8VtWPydUUYJwP4lINMVNzQc567oUptmSohkXufo92lRyZQgla+JNY/ovcYaRYukHmvSybCDDE0Q/PVCaqsXqfHb4ckHduhitsZOXgK4A0ohjXqNL0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kve6RE+c; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742514206; x=1774050206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qD6P1XLuScC/GDGjJU+aH/i/e6IvzbV5XOIX9N5YGfQ=;
  b=Kve6RE+c2mXSuH4je95pxNjV2a+Vg8RirHoGIWK12GSazcecsSBoGwxF
   XXD4LGheJ/vXhXYehSL01CwuPoB/L2o3wxZ5JRwIjgPaJ//XHGeFad8eH
   83jZizJkjuulD6dthdT7R7zgEegqZrYmEZ09WCbR9yUYchoMUT/qDvyRT
   D6aYSeiqt2h1Kc1CaaO77uOdhT+WScWva6tmbKNLrSAjc4i2EkBtb2JZj
   7ci7jqSiFX1qmP0iqejWiXs9U0psBWvLMLWusaFFQOYmBKRieoa4XrreA
   /eMSM8FO71B/bfouzhSdOV6r6c7NxzsvrL6Ui8c4ULy4KefTr8XG8kIDf
   g==;
X-CSE-ConnectionGUID: PU5rCOgoSl6WVr+rVIgJQA==
X-CSE-MsgGUID: RMqs61u+QNKfBI6vF8CqZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43502615"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43502615"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:43:26 -0700
X-CSE-ConnectionGUID: dQpHxLrzSoGXAR66ALJkFQ==
X-CSE-MsgGUID: 4IQi0SRERFKavnepo+EoMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="122963016"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.68])
  by orviesa009.jf.intel.com with ESMTP; 20 Mar 2025 16:43:25 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC v2 8/9] x86/fpu/apx: Enable APX state support
Date: Thu, 20 Mar 2025 16:42:59 -0700
Message-ID: <20250320234301.8342-9-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250320234301.8342-1-chang.seok.bae@intel.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <20250320234301.8342-1-chang.seok.bae@intel.com>
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
index 7f39fe7980c5..b308a76afbb7 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -32,7 +32,8 @@
 				      XFEATURE_MASK_PKRU | \
 				      XFEATURE_MASK_BNDREGS | \
 				      XFEATURE_MASK_BNDCSR | \
-				      XFEATURE_MASK_XTILE)
+				      XFEATURE_MASK_XTILE | \
+				      XFEATURE_MASK_APX)
 
 /*
  * Features which are restored when returning to user space.
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 0d68d5c4bc48..a5e3954dc834 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -371,7 +371,8 @@ static __init void os_xrstor_booting(struct xregs_state *xstate)
 	 XFEATURE_MASK_BNDCSR |			\
 	 XFEATURE_MASK_PASID |			\
 	 XFEATURE_MASK_CET_USER |		\
-	 XFEATURE_MASK_XTILE)
+	 XFEATURE_MASK_XTILE |			\
+	 XFEATURE_MASK_APX)
 
 /*
  * setup the xstate image representing the init state
-- 
2.45.2


