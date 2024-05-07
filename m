Return-Path: <linux-kernel+bounces-171493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C658BE510
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1051C24378
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11C615F41D;
	Tue,  7 May 2024 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLZB+row"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7495615F413
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090523; cv=none; b=FjW8XRfHyfteXyvtbGPjiq5SoBjw51wVdcehiilti86Vsv/lR4UrtjApkmLVSkxgjgAAWA6Fzl/+kRzt3OgF4Imj3i9G3nbE4G4zMkZXGkEb19pI6LUfEJp0osJmPvTtny5f5rIVC90fWnjfsgD9oCigghbtMzr0DrYxdK25TSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090523; c=relaxed/simple;
	bh=tU4rFjR0Tip9qQJLv1vWcuUEA6NJVPVm58JHiTqAvdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R5xYd7kRDOhh2hji2eUfnCCFZ+rktEaCVdIrBwNuRUv9ycoNzlwMfWErg9/FOQ0fadRTGBZ+d23G+bHyZH+BiFUCUo4xv7XYwJcM/gycqjKvjrzJCZzF6Ffy18SyhapwTBzzP3EEZ8j5Ry3C39EIJZVtzO3Vd4oCTVY8CP3abpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLZB+row; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715090522; x=1746626522;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tU4rFjR0Tip9qQJLv1vWcuUEA6NJVPVm58JHiTqAvdo=;
  b=nLZB+roweQ0KYSvOck4Y/fJrWFM4rSPp0SOY/dK7iJENzGcoK5uKOiXR
   RCHBe9cPDKRGvMAuh7EPxRcLp1CPeEsiNE3VdCFauKnYQnT8o7llf5q1K
   8U1P4atgCWKDnMjJoyINYw4tjoAfy6tq3rh7J5YvxwFTzQ4BgVQP4m6U/
   tcxObzP9Sa60EirKB9SVJBq63qY7jcT04Ladi8VseAZlHz4UisH0kXEaJ
   hjbn3muwtCHfowxHzdfq1h9p+0Uxx5q/dtGImHMgIv5VQCFDOQIpQyfO7
   sLAknF6b4LglD6uFNlWTJIuDfnQaVHRzV1p4SsoBdQkBUYl4Mc6UERDp4
   Q==;
X-CSE-ConnectionGUID: kAoikgY6QoarJJCrnUeAcw==
X-CSE-MsgGUID: g74V+yOrTq+Ogvlx5rkAvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10820885"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="10820885"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 07:02:01 -0700
X-CSE-ConnectionGUID: 8G1NcQkqQ4qBbjkNAz6ksw==
X-CSE-MsgGUID: BceaiNxXRcO7p58B9fGh9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="33096714"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 07 May 2024 07:01:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4000C178; Tue, 07 May 2024 17:01:58 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v1 1/1] bitops: Move aligned_byte_mask() to wordpart.h
Date: Tue,  7 May 2024 17:01:54 +0300
Message-ID: <20240507140155.197304-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bitops.h is for bit related operations. The aligned_byte_mask()
is about byte (or part of the machine word) operations, for which
we have a separate header, move the mentioned macro to wordpart.h
to consolidate similar operations.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/bitops.h   | 7 -------
 include/linux/wordpart.h | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 0b561ee6b4a4..ec45284c03f5 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -8,13 +8,6 @@
 
 #include <uapi/linux/kernel.h>
 
-/* Set bits in the first 'n' bytes when loaded from memory */
-#ifdef __LITTLE_ENDIAN
-#  define aligned_byte_mask(n) ((1UL << 8*(n))-1)
-#else
-#  define aligned_byte_mask(n) (~0xffUL << (BITS_PER_LONG - 8 - 8*(n)))
-#endif
-
 #define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
 #define BITS_TO_U64(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
diff --git a/include/linux/wordpart.h b/include/linux/wordpart.h
index f6f8f83b15b0..4ca1ba66d2f0 100644
--- a/include/linux/wordpart.h
+++ b/include/linux/wordpart.h
@@ -39,4 +39,11 @@
  */
 #define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
 
+/* Set bits in the first 'n' bytes when loaded from memory */
+#ifdef __LITTLE_ENDIAN
+#  define aligned_byte_mask(n) ((1UL << 8*(n))-1)
+#else
+#  define aligned_byte_mask(n) (~0xffUL << (BITS_PER_LONG - 8 - 8*(n)))
+#endif
+
 #endif // _LINUX_WORDPART_H
-- 
2.43.0.rc1.1336.g36b5255a03ac


