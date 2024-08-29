Return-Path: <linux-kernel+bounces-307254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BC5964AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3AD21F2630A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60E11B5302;
	Thu, 29 Aug 2024 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZPXYftB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64EE1B3F08
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947204; cv=none; b=mKjig4W4c80JKfEKF5dKQD82BcJzvoijQwxCPNsl7kbs2lKGB937pJyq8c8XoyqFbXLZzO8nA0vsKwwMpOHtNZbRBvjrW0aVZOK7dVgup/NJDu70UatrCmM4zabsyqnBamZydRBz6Ysl2ZndmbBOxlVjLgdTD4uAuiDXAD+epG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947204; c=relaxed/simple;
	bh=kIbeBcvklRZnAUyEaogr4BsfGsKIwHXOjt9dIl1120s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u83cv/Tqw/piPJXIaKId/YZZgFg+O2d7TzztOAmAwRjF03naYN2bthuEYcsHMSAc7ZnYhgQUhPcV1TXm7zVlq7rsD7AD84Vzt3Ple2CqLTYNgUlvxYTNPyrSS1M7hdkw/UqbvoiFXAv4U9MJAHTEtW3QJZKbifP11B5CH5CnMqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZPXYftB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724947203; x=1756483203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kIbeBcvklRZnAUyEaogr4BsfGsKIwHXOjt9dIl1120s=;
  b=WZPXYftB6bom/OthIisRPGfZKc4Zjy4vhQ47M8CizxaD12SdHj+nKGGN
   S6I3INAiLfvgC1lvIKmye1ZFunzophwL5esFUNWl8mUJIOzad9XLuYbgz
   Amjl0vcWq4KxKwRi7Q9EGFtOWoyDE603vy5zKOTJzY7XlONZQD9+/J04+
   bLFgd25tzR/NgpJUsJyI2pmAB2UC/We9IGRNzrZAI4veygZdoemAG3i1w
   0zIB13wcWQr3WqSK0auh8vfz/DZc02s9CDaXZKry7oTPskLLJFRi33zCG
   DNKiDwvnexGK4x26jBo8CSeAWN0CLR5t/rlB/v4MsiMSlG4/eQNT4WnqF
   Q==;
X-CSE-ConnectionGUID: 1N9WWxXEQ+OMLnKYG1nYDw==
X-CSE-MsgGUID: 6AVRqjSrRSmGIsfsWys/TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27313786"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="27313786"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 09:00:01 -0700
X-CSE-ConnectionGUID: U1FTIqQYQ8ujxx5ZZCRvEA==
X-CSE-MsgGUID: YliLZ7OsQvaylZ8R7B+OmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63455324"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 29 Aug 2024 08:59:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C22D8956; Thu, 29 Aug 2024 18:59:56 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v1 2/2] drm/i915/fence: Mark debug_fence_free() with __maybe_unused
Date: Thu, 29 Aug 2024 18:58:38 +0300
Message-ID: <20240829155950.1141978-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240829155950.1141978-1-andriy.shevchenko@linux.intel.com>
References: <20240829155950.1141978-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When debug_fence_free() unused, it
prevents kernel builds with `make W=1` and CONFIG_WERROR=y:

.../i915_sw_fence.c:118:20: error: unused function 'debug_fence_free' [-Werror,-Wunused-function]
  118 | static inline void debug_fence_free(struct i915_sw_fence *fence)
      |                    ^~~~~~~~~~~~~~~~

Fix this by marking debug_fence_free() with __maybe_unused.

Fixes: fc1584059d6c ("drm/i915: Integrate i915_sw_fence with debugobjects")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_sw_fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_sw_fence.c b/drivers/gpu/drm/i915/i915_sw_fence.c
index d4020ff3549a..1d4cc91c0e40 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/i915_sw_fence.c
@@ -77,7 +77,7 @@ static inline void debug_fence_destroy(struct i915_sw_fence *fence)
 	debug_object_destroy(fence, &i915_sw_fence_debug_descr);
 }
 
-static inline void debug_fence_free(struct i915_sw_fence *fence)
+static inline __maybe_unused void debug_fence_free(struct i915_sw_fence *fence)
 {
 	debug_object_free(fence, &i915_sw_fence_debug_descr);
 	smp_wmb(); /* flush the change in state before reallocation */
@@ -115,7 +115,7 @@ static inline void debug_fence_destroy(struct i915_sw_fence *fence)
 {
 }
 
-static inline void debug_fence_free(struct i915_sw_fence *fence)
+static inline __maybe_unused void debug_fence_free(struct i915_sw_fence *fence)
 {
 }
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


