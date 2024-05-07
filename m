Return-Path: <linux-kernel+bounces-172120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C69A8BEDCC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9E0281B2D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C9E14B96D;
	Tue,  7 May 2024 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkJ6L5z1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF3314B951
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715112163; cv=none; b=mVsfYkp3nGA5HCh+1pI9W4WjxI1FcbCbY8uuFCwhZ3T3YTKU/nQT6PyYjCAkfY7MCAJ4/6pip7Wer/Z4BIBZsTt2A7c6McbUbYpm55IvVxgbuZjz8KQ7ee1p3//iKG+E5jUUmkwNt2/QVQmclXMdpaijOwC7+hYmQF86LJC9vFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715112163; c=relaxed/simple;
	bh=rstZsC4tr4kAVi9rKuNsg0sqQb+KdmStQAo2N0cQNL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dv/IT7TNXhWRsn12x3e07tKKe3TfQy2LA6o2YCZdHC3woxB5o1FdniX1h4AX+RVTU4hBiLBib3KQmjKXmxE4T5Jh6QJDkycjrcttkZFz3qEW+4NmuuwlIZTTA58TwGkXzUrzvBmQb2IoK2OjZcxGKjYE4zWVQ0MzGtKtwWjp4Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkJ6L5z1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715112161; x=1746648161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rstZsC4tr4kAVi9rKuNsg0sqQb+KdmStQAo2N0cQNL0=;
  b=jkJ6L5z1HNAfukuXDK92ktleL/xYvZy5egiGEJouy+xHwAjHBSrt6W7I
   I8NBFONGiiWmhm4H5+uNcKqSE/wY4ntya2cgRXqC5pAd/jE33vJzxbvbP
   hRvmBPqtz7ES7F24KvzlFs9EJSwo5kw/aeuQDq35HbD9/h0zdY2+8y8s6
   DNlQFkz1E1saIt+qjdMVVj4OY6wzxBc7OYIFX3Gf5ll83y9+mK6UwYH2a
   Ghaz6r2cSMRfjnH0b2+tsCVBzdd4r+Mawvh9RyOlw+peVXukz+h8YpHCu
   4wrdfBXJ0fE+Rn21TkgqRYyMs03ath4w3p39zX6fzBOrv5ed8Bktzkik5
   Q==;
X-CSE-ConnectionGUID: TZfzy3CRSW6cXyRoGrz9Bw==
X-CSE-MsgGUID: gcVX+gn1TmmnwMc5vXDVag==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11063692"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="11063692"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 13:02:41 -0700
X-CSE-ConnectionGUID: vheEd5gkSOi78xYXy0kbfw==
X-CSE-MsgGUID: +/dvpArbT3CveaVezFu47w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="29168275"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 07 May 2024 13:02:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7AA94E7; Tue, 07 May 2024 23:02:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/2] bitops: Move aligned_byte_mask() to wordpart.h
Date: Tue,  7 May 2024 23:01:31 +0300
Message-ID: <20240507200236.527688-2-andriy.shevchenko@linux.intel.com>
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

The bitops.h is for bit related operations. The aligned_byte_mask()
is about byte (or part of the machine word) operations, for which
we have a separate header, move the mentioned macro to wordpart.h
to consolidate similar operations.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/bitops.h   | 7 -------
 include/linux/wordpart.h | 7 +++++++
 lib/usercopy.c           | 1 +
 3 files changed, 8 insertions(+), 7 deletions(-)

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
diff --git a/lib/usercopy.c b/lib/usercopy.c
index d29fe29c6849..4b62e6299cc8 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -3,6 +3,7 @@
 #include <linux/fault-inject-usercopy.h>
 #include <linux/instrumented.h>
 #include <linux/uaccess.h>
+#include <linux/wordpart.h>
 #include <linux/nospec.h>
 
 /* out-of-line parts */
-- 
2.43.0.rc1.1336.g36b5255a03ac


