Return-Path: <linux-kernel+bounces-307252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC34A964ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761841F25F6C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4C61B3F27;
	Thu, 29 Aug 2024 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GkqbmM/h"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC181487F1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947202; cv=none; b=Hu3tbSGrx5I5d+bsa6IXp6yzEVzhzHqpZJxrwEvgBZUKl25+OIqnLXgk8KBLU1wJPbvBSfuc+Hh/vq+Ii+Xz3NKuSyrASKQKUHP1d+NZHdOpvB0gPx83kWh0lFVVTfyNo7edmVUwi69ae1gFQi5DBy6SX/Sccy0Sl2xeUlfvZZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947202; c=relaxed/simple;
	bh=ZVhy00hR+PCS3Oja2q7T0ClCf3oyBQZQu1h8s4wBumA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EU01A6VZqTwZPyVN6OEf2iP/1F2Ql6ufYtyCWNfS5UscYK4IvnukiLtmO8HE6yspsgeLvChgj6g3JQ7Fi3BhMIghMDklKdY4OjZ1FT9PlH+f75GafJMLFstYJ1JYR3/3mxkCtLXeyB9fFj+pU2fvyfU5gEUYzMJMIy2RuOGflvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GkqbmM/h; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724947202; x=1756483202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZVhy00hR+PCS3Oja2q7T0ClCf3oyBQZQu1h8s4wBumA=;
  b=GkqbmM/hwzgnmteF9FbKhF39TA1Hrca0DZ3IHMlLLR1vzAwjLjohhkh2
   pJaHhKSd33YHYTyBmRCpLzazcJuFjVh7owQia1gQzGpFYIjzSuhGS6Rtn
   f+Xx7MzWFBS35M01fWjOj1kUhwsmqyZAd7EBpC3fFZ7WLwPHk8tP2zOJ7
   qTpHrWusVYd7t34KLBA6FNMW6dtJ/4QlCIWJOzwTHTA2nqr5GsnohlE1U
   BikaoIqK44fjlyrYLjzXOafUCFo9DAZ+iI+/qwBukCdSYm9/NgstTjsO/
   zG57R7okYDGMcX7RK3LHpoUCtn0Jui/PxspVJRCSMox4OsE5b7nzD0TYM
   Q==;
X-CSE-ConnectionGUID: lWDHgmuvRuS/9iD1e2OneA==
X-CSE-MsgGUID: 7jU4q8e0RJGodkxK0hCoyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27313783"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="27313783"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 09:00:01 -0700
X-CSE-ConnectionGUID: TPDw9tJfSQ+wBECcZqVJLQ==
X-CSE-MsgGUID: V5v7svFgR5GHF5c6OuY6DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63455322"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 29 Aug 2024 08:59:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B4F35143; Thu, 29 Aug 2024 18:59:56 +0300 (EEST)
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
Subject: [PATCH v1 1/2] drm/i915/fence: Mark debug_fence_init_onstack() with __maybe_unused
Date: Thu, 29 Aug 2024 18:58:37 +0300
Message-ID: <20240829155950.1141978-2-andriy.shevchenko@linux.intel.com>
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

When debug_fence_init_onstack() unused, it
prevents kernel builds with `make W=1` and CONFIG_WERROR=y:

.../i915_sw_fence.c:97:20: error: unused function 'debug_fence_init_onstack' [-Werror,-Wunused-function]
   97 | static inline void debug_fence_init_onstack(struct i915_sw_fence *fence)
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~

Fix this by marking debug_fence_init_onstack() with __maybe_unused.

Fixes: 214707fc2ce0 ("drm/i915/selftests: Wrap a timer into a i915_sw_fence")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_sw_fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_sw_fence.c b/drivers/gpu/drm/i915/i915_sw_fence.c
index 8a9aad523eec..d4020ff3549a 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/i915_sw_fence.c
@@ -51,7 +51,7 @@ static inline void debug_fence_init(struct i915_sw_fence *fence)
 	debug_object_init(fence, &i915_sw_fence_debug_descr);
 }
 
-static inline void debug_fence_init_onstack(struct i915_sw_fence *fence)
+static inline __maybe_unused void debug_fence_init_onstack(struct i915_sw_fence *fence)
 {
 	debug_object_init_on_stack(fence, &i915_sw_fence_debug_descr);
 }
@@ -94,7 +94,7 @@ static inline void debug_fence_init(struct i915_sw_fence *fence)
 {
 }
 
-static inline void debug_fence_init_onstack(struct i915_sw_fence *fence)
+static inline __maybe_unused void debug_fence_init_onstack(struct i915_sw_fence *fence)
 {
 }
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


