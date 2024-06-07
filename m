Return-Path: <linux-kernel+bounces-206675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1630900C94
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5C01F22481
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D34014D717;
	Fri,  7 Jun 2024 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XaqZYecR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4197B6A33F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717789486; cv=none; b=K0+zpuHVSco8Bk1bp18r+8GAPR1uRF45BRiRVupcSZNJGRPhGd4ZnWjkGams0M0qUDGILZoMwEEGJ2fbwxe80F+zn7ofQjpB3Of+nTyT6SxzDKqx0yIAPqYSo32CA+615akP8ze0nIarvMBkLpGJfaGrWZnYeqvMR5wqRQ1LeEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717789486; c=relaxed/simple;
	bh=gQZmMdf7XESXI/62zavW8FJtnA06YyVAKvYkn83aBA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nYMf0OUyxprOfha7F1p6/tihUsaQ0TWx4YYurEdR7G8sqNyZbsaDNFcV4SCFcdbDDz5AXF0ouYkmhqEwEPaqmJC/SAV7rxiDLiSuk0+bIeU0ognF9Nvz5Da0dIubhrWvYSpTORRYOge5uwvAxzAegpAgkBclw5PrEhjM7CikspI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XaqZYecR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717789486; x=1749325486;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gQZmMdf7XESXI/62zavW8FJtnA06YyVAKvYkn83aBA0=;
  b=XaqZYecRXN2XBgBAOFO6YEZ2G6b58GOvBO1sG1enBhpqYSYxo4TLs0Kr
   pdxgnIoaQ6mhltNhBicXqMn8Ae7vOoKJtFQq5Fkq649F/nI+1h0c4Unv+
   nDKKzxtZo+B+6K++nl9DrLuu6X6Jf4g/cmzzgYXdU2xOIPEv+eeEkcMel
   oRc58/STyb98u0XtgF/L36Y5BAJau/VnojggkbppX4cLroGTbTiCz4JVz
   CAqjryZDJSi2DTz7UrkQjviylTCXFabWnfMFH5ZatSzf8hGcEhLvsZ/3r
   m9B8+ivm3tSByi4RfBrzJHEO1IxZT+si0597i4t5N9+gQwYy4emmsKrVg
   w==;
X-CSE-ConnectionGUID: MDC66HpITCaT/2psrgTKYg==
X-CSE-MsgGUID: 3TH8VR+4RbOx4O36/o03Hw==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="18354695"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="18354695"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 12:44:45 -0700
X-CSE-ConnectionGUID: X/wxrRd5QrySQVXisIaFBQ==
X-CSE-MsgGUID: 5v29KSBTSguuG7rsH1TPnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="43355774"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 12:44:44 -0700
From: Andi Kleen <ak@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v4] x86/mtrr: Check if fixed MTRRs exist before saving them
Date: Fri,  7 Jun 2024 12:44:37 -0700
Message-ID: <20240607194437.52939-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MTRRs have a obsolete fixed variant for fine grained
caching control of the 640K-1MB region. This fixed variant has a
separate capability bit in the MTRR capability MSR. Most of the MTRR code
checks this capability bit before trying to access the fixed MTRR MSRs,
except in one place. This patch fixes this place to also
check the capability.

Otherwise there will be a WARN_ON due to the #GP when the respective MSRs
are accessed to save them.

Fixes: 2b1f6278d77c ("[PATCH] x86: Save the MTRRs of the BSP before booting an AP")
Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2: Add Fixes tag and expand description.
v3: Expand description
v4: Expand description
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 767bf1c71aad..2a2fc14955cd 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -609,7 +609,7 @@ void mtrr_save_state(void)
 {
 	int first_cpu;
 
-	if (!mtrr_enabled())
+	if (!mtrr_enabled() || !mtrr_state.have_fixed)
 		return;
 
 	first_cpu = cpumask_first(cpu_online_mask);
-- 
2.45.1


