Return-Path: <linux-kernel+bounces-573528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A44A6D8B1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107E63A9219
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148F425DD1D;
	Mon, 24 Mar 2025 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hWdhEUe0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08A925DCF1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813564; cv=none; b=EtlrvRbc8Cd3gjhrNT1ZQU1MaPJiJtSCYWAgp7GJV2O/GHf50cMIObZmimIfm9w4eUfmfhjyRGVopjtFNQgiDMgdv+vZLH2BsGeMsc8QUI3fVVHUvv+wychWQMkaqF0t0riE2tz8kcAgo2ZV1EiT/rHnFt1MItafexSJzcqWcEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813564; c=relaxed/simple;
	bh=sZGc4JwXs7iJ8D/IHSbBoRpDBKmUfLLakBeMsg3vn3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlG1RoETwonK0oSD5Bjdj6y6v4qRq4jSRKPkSLI4gow9n86NejHh56q9zxT7Arhy1wTkty+r8FADfAs+U7UlwzfRmlE/121z5nlyQ6U+2LF+S8xki+vV0cj7bofcsz7i5PmJg054yJ+MjK2NePcb+J/f8Hlk5NXtlFBaBEiTsPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hWdhEUe0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742813563; x=1774349563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sZGc4JwXs7iJ8D/IHSbBoRpDBKmUfLLakBeMsg3vn3s=;
  b=hWdhEUe0hP5EnnnCOaQKVI0EZwlx2FcpMFXRO6as79rKoskOX9zMtzIw
   tVIYRyZUzZNNVDdvR6Bah505a4rtG9UdfoSuUTPKYkFuGkDo0b0LltO6l
   Wou8U3VlvkbEAPPvJaO4clqtNYe1Iu7h0lNfmLTiwAbIHECjmsVOu3R+t
   uWQEeFmAeoqg7WeklCbr0uTHgKTUbYH6gr60Q9ZOOk3YY2p5aInzVPlhZ
   zn34OmRTcbaF8dHto2sbghCqBO3gYvSsCrT/OPms+VhWX9zOGQplbG8b6
   IJj1u8PnZtoHXN5HhsdPz9jIlr6ds7JKxbDLy188WhDz1MPeIwXp8+LaQ
   w==;
X-CSE-ConnectionGUID: O8EX/k++R66qEpHxriS92Q==
X-CSE-MsgGUID: an5Cd26/Q7S9bCMLB6ZeYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="46756889"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="46756889"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 03:52:40 -0700
X-CSE-ConnectionGUID: W2ZE+m8aRG+4D0GYhxJ6tw==
X-CSE-MsgGUID: 5aNeg8vqSb2B3TarIyTGUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="154916399"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 24 Mar 2025 03:52:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 52014CC; Mon, 24 Mar 2025 12:52:37 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alexandru Ardelean <aardelean@baylibre.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v1 1/2] kernel.h: Move READ/WRITE definitions to <linux/types.h>
Date: Mon, 24 Mar 2025 12:50:24 +0200
Message-ID: <20250324105228.775784-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250324105228.775784-1-andriy.shevchenko@linux.intel.com>
References: <20250324105228.775784-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ingo Molnar <mingo@kernel.org>

Headers shouldn't be forced to include <linux/kernel.h> just to
gain these simple constants.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/kernel.h | 4 ----
 include/linux/types.h  | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index be2e8c0a187e..01bb0fac3667 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -41,10 +41,6 @@
 
 #define STACK_MAGIC	0xdeadbeef
 
-/* generic data direction definitions */
-#define READ			0
-#define WRITE			1
-
 #define PTR_IF(cond, ptr)	((cond) ? (ptr) : NULL)
 
 #define u64_to_user_ptr(x) (		\
diff --git a/include/linux/types.h b/include/linux/types.h
index 49b79c8bb1a9..6dfdb8e8e4c3 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -136,6 +136,10 @@ typedef s64	ktime_t;
 typedef u64 sector_t;
 typedef u64 blkcnt_t;
 
+/* generic data direction definitions */
+#define READ			0
+#define WRITE			1
+
 /*
  * The type of an index into the pagecache.
  */
-- 
2.47.2


