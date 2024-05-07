Return-Path: <linux-kernel+bounces-172122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C13C8BEDCF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C87A1F2154D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAA516F8FF;
	Tue,  7 May 2024 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cgEXDvCV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E17114B964
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715112164; cv=none; b=C8qvpKmwUREX+e2Qx6x4lrBzcJDeyovtPeIQnXYhXmgrDt0/8GJ3A/o5NC/K6JF8IFOhXh72xFu0EeLKj6R5Uo6Y1+lu9hhOKmypjFlFum4HugdIaEvK36tmYcX6qN/9BY7fem2aafHOqRTK61ZGGylLPrblHljjvttqKzN7gfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715112164; c=relaxed/simple;
	bh=d3kIVb3N3T3QMxmT6SHLpGgbVBfU5Yf262Tqt572UNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+KfMTDuxLwepvPH5dYkFkRigTWatNIaOzBKL4u5wh8CS/hXAzsju5YsiA0dDXWVsxnc6exIpnTTdeCQWMv/7bZzH0Kk4uiDd/5/7LV8fNvbUSP27F/or6Ta3YFPWcznElouspyl+pApUfANNY1skJcE5y1a/XoXsNj5A5+R46E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cgEXDvCV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715112163; x=1746648163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d3kIVb3N3T3QMxmT6SHLpGgbVBfU5Yf262Tqt572UNA=;
  b=cgEXDvCV6RlUQYs/PZQ2BVMligSoGz5xVLDYWyVaTVBXGfd0dpB+4aL7
   sOUPOyEKbLJYgQu0FGM/129RgCeixqjgMcteG0t0y1S8mscizbYLzfKup
   OqdfV2rs4M+ARfOAV+CBzUpfSgKu58gGFvkZCJ/pT+9NOhvXMarjK+krV
   eQYlJy81xcjR1eb1v2z0TBy5I1B41G+YuLE3+Q9FxYxzhYuNdV+81BfFt
   tBPVsYkS9082/VUYQijwkUR1wzpqKR7QyNiiXRCqPb/48mwAzvwk3TxtJ
   l8aYNEQ8tdbXTqINaEXFO8tn6wZdTJ2q0PwMXBFqynoBDsQX8i0bXnSz2
   A==;
X-CSE-ConnectionGUID: 1XXxJIdNSFerHlCoOdYXPQ==
X-CSE-MsgGUID: YWB+NPXWSoS796KUffOCYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11063696"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="11063696"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 13:02:41 -0700
X-CSE-ConnectionGUID: pbvQYyhCR3e1AFbn7AX55w==
X-CSE-MsgGUID: 9aGDmB9PQICAPz3YLVrkxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="29168276"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 07 May 2024 13:02:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8A2985E8; Tue, 07 May 2024 23:02:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/2] usercopy: Don't use "proxy" headers
Date: Tue,  7 May 2024 23:01:32 +0300
Message-ID: <20240507200236.527688-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240507200236.527688-1-andriy.shevchenko@linux.intel.com>
References: <20240507200236.527688-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/usercopy.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/usercopy.c b/lib/usercopy.c
index 4b62e6299cc8..499a7a7d54db 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -1,10 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/bitops.h>
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/fault-inject-usercopy.h>
 #include <linux/instrumented.h>
+#include <linux/kernel.h>
+#include <linux/nospec.h>
+#include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/wordpart.h>
-#include <linux/nospec.h>
 
 /* out-of-line parts */
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


