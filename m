Return-Path: <linux-kernel+bounces-317605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5614696E0F2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28561F242CD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A127195F3A;
	Thu,  5 Sep 2024 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W5LSHwMM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D89522F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725556562; cv=none; b=XC7REKTXdpCXeeEp1hFBCa8zuXiBTbR8izzzZztky3Uwd3SGZBGubn4Lf/RbViqUwMu5sFa/XDdcbSEBht9auBwXH/IdxL4diHun1eIhU32wgOF4zynsNbhy4ZO/JgjOpPDOhtF5ZacEwgZJBOfCAWHhESXEnQxt1oZ7KSP4V94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725556562; c=relaxed/simple;
	bh=HprEm+25bMv9ipc0ur/k025rHi0KLLQza4pA0qsXpJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CHdleN2oIWEFdtIA60k/QHZlZs4YXrkINm7m/m4jHALfdImRcHNxSdYJo90/FRGV7ekATjmpdxotW3Y7TMcSKVSyEwBKWsuJtI3LdAovVuErG9Hs2vkTMuHUTIYDwQPTuTufylnjUR0m70Il3Wbo3cjg7Ga9CHATKWC5u6X2mls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W5LSHwMM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725556562; x=1757092562;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HprEm+25bMv9ipc0ur/k025rHi0KLLQza4pA0qsXpJo=;
  b=W5LSHwMM+TczkJZd0gPFWfniVFffWE5/jT51OMpREVSzaRJVt6/zzOaQ
   OOrng+eyY2QSjH6Txy0zzIm8l2Ths8vM+uswPKyyvmjmLwo16Nk7VPHVt
   Wjmyqytqd4xINT8EKe+hThhczoVzkyK8+JSe4yQyRfi3Geo7gnUgqC0/P
   nI9R6kmdYLjRGLnfZDoS8M3Th11Z4WtWlrSNOgMPmdCIEmOTqYv6Ho7nH
   xT8fYT0hFlg3eSp8l00rmfNHrKyoxCFBk8q8uD+w5iRBS41sgWigSvNuT
   jXIh1qNWftTbe0wExnEtO1FemoqiMK45nvtx7gLW/zrU0SthJmfuMUX6H
   A==;
X-CSE-ConnectionGUID: 5HdP8Xa2Sq2PIVQ25t3qnw==
X-CSE-MsgGUID: A+eoBGe0TV2mhY4azK1AMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="46820338"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="46820338"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 10:16:01 -0700
X-CSE-ConnectionGUID: jG0AhIh3TROoGs10VT+HdA==
X-CSE-MsgGUID: NJo70IV1TDe5tF7dhehhQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70260947"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 05 Sep 2024 10:15:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8BE3531E; Thu, 05 Sep 2024 20:15:57 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mm/page_alloc: Mark has_unaccepted_memory() with __maybe_unused
Date: Thu,  5 Sep 2024 20:15:53 +0300
Message-ID: <20240905171553.275054-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When has_unaccepted_memory() is unused, it prevents kernel builds
with clang, `make W=1` and CONFIG_WERROR=y:

mm/page_alloc.c:7036:20: error: unused function 'has_unaccepted_memory' [-Werror,-Wunused-function]
 7036 | static inline bool has_unaccepted_memory(void)
      |                    ^~~~~~~~~~~~~~~~~~~~~

Fix this by marking it with __maybe_unused (all cases for the sake of
symmetry).

See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build").

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c565de8f48e9..3b47f1b17ae5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6990,7 +6990,7 @@ static bool cond_accept_memory(struct zone *zone, unsigned int order)
 	return ret;
 }
 
-static inline bool has_unaccepted_memory(void)
+static inline __maybe_unused bool has_unaccepted_memory(void)
 {
 	return static_branch_unlikely(&zones_with_unaccepted_pages);
 }
@@ -7033,7 +7033,7 @@ static bool cond_accept_memory(struct zone *zone, unsigned int order)
 	return false;
 }
 
-static inline bool has_unaccepted_memory(void)
+static inline __maybe_unused bool has_unaccepted_memory(void)
 {
 	return false;
 }
-- 
2.43.0.rc1.1336.g36b5255a03ac


