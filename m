Return-Path: <linux-kernel+bounces-573527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A21A6D8B0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED1A3A7EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8854325DD0C;
	Mon, 24 Mar 2025 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cEWe9AeB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECA61C8605
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813563; cv=none; b=kHoZeVYs6K8lWxf6ruMFeijzbAYV+1gbaBPTtiPPSvFMC71uqzXHCbUIWWUlnvXwpOP2tNwfHv2+ezImQQeyk7Enfw1rZqV0M4vUp+v2ftImER5IY6JXfAb0Hrvukqwn0+W87i7OI/wRC3qtV9RB88PJC3SUHOUCDFhfDFjPl7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813563; c=relaxed/simple;
	bh=hzFZA5BJlWQnnmeaDLMalig5ESOluROqMB42yzZqNj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFCfTp72rM9pdO4887mPTXEKl1a2+IpHXWl9axkEHzfZGauDqOlAjiSJZErfc3ZklfPKFZi/viNTS9a00cdjwTQXQLpU6ZF135KHk0lWXleQgH5vReyamGbX5ROg/Dz9FDcl/NUVa/q/jT9jnLtlTsy18wBxITscN3e9jkgdOj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cEWe9AeB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742813563; x=1774349563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hzFZA5BJlWQnnmeaDLMalig5ESOluROqMB42yzZqNj0=;
  b=cEWe9AeBJ5fcwk6wyAwYWA4nd/f1OwDYxQSNZo11z1GqKDeEg8T/yTLx
   p166HfGgg+xxb2mdSfFSBe3txIDrZbbpRbqe+zEzV85sXnf4eTTtk6kpI
   PqtLuEyBif2E56rltabSIE3RMgDacTns0u7dXgRCECS5StxPkuxRgsbIM
   +peWRpjCQqa3Xck0unMPvLkVuuzMPHDcqStYma/xKjebLji7TlTNwsH0p
   DvtuHNVnCRB9rp8T+qNeV7PQJrSJ2vigPYTv5bOUFD0PutGa3vjHlfof2
   Wp5yMQLT6aRzRWv5g7OYNSGvv1R/PQWZNEky38d/K+nsuKc/0tX17YSDV
   w==;
X-CSE-ConnectionGUID: QNaQPRteTLSa5jU5H4ZYXw==
X-CSE-MsgGUID: +EgHwPyCR8C0UyPg6yZxnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="46756886"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="46756886"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 03:52:40 -0700
X-CSE-ConnectionGUID: y8/1LUGTSwqc/NOimrX/uA==
X-CSE-MsgGUID: XM6VwjHJSkSFxjhnp4cDxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="154916398"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 24 Mar 2025 03:52:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 659C9159; Mon, 24 Mar 2025 12:52:37 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alexandru Ardelean <aardelean@baylibre.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 2/2] kernel.h: Move PTR_IF() and u64_to_user_ptr() to util_macros.h
Date: Mon, 24 Mar 2025 12:50:25 +0200
Message-ID: <20250324105228.775784-3-andriy.shevchenko@linux.intel.com>
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

While the natural choice of PTR_IF() is kconfig.h, the latter is
too broad to include C code and actually the macro was moved out
from there in the past. But kernel.h is neither a good choice for
that. Move it to util_macros.h. Do the same for u64_to_user_ptr().

While moving, add necessary documentation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/kernel.h      | 10 +-----
 include/linux/util_macros.h | 66 +++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 01bb0fac3667..1cce1f6410a9 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -33,6 +33,7 @@
 #include <linux/sprintf.h>
 #include <linux/static_call_types.h>
 #include <linux/instruction_pointer.h>
+#include <linux/util_macros.h>
 #include <linux/wordpart.h>
 
 #include <asm/byteorder.h>
@@ -41,15 +42,6 @@
 
 #define STACK_MAGIC	0xdeadbeef
 
-#define PTR_IF(cond, ptr)	((cond) ? (ptr) : NULL)
-
-#define u64_to_user_ptr(x) (		\
-{					\
-	typecheck(u64, (x));		\
-	(void __user *)(uintptr_t)(x);	\
-}					\
-)
-
 struct completion;
 struct user;
 
diff --git a/include/linux/util_macros.h b/include/linux/util_macros.h
index 3b570b765b75..7b64fb597f85 100644
--- a/include/linux/util_macros.h
+++ b/include/linux/util_macros.h
@@ -79,6 +79,72 @@
 	(__fc_i);							\
 })
 
+/**
+ * PTR_IF - evaluate to @ptr if @cond is true, or to NULL otherwise.
+ * @cond: A conditional, usually in a form of IS_ENABLED(CONFIG_FOO)
+ * @ptr: A pointer to assign if @cond is true.
+ *
+ * PTR_IF(IS_ENABLED(CONFIG_FOO), ptr) evaluates to @ptr if CONFIG_FOO is set
+ * to 'y' or 'm', or to NULL otherwise. The (ptr) argument must be a pointer.
+ *
+ * The macro can be very useful to help compiler dropping dead code.
+ *
+ * For instance, consider the following::
+ *
+ *     #ifdef CONFIG_FOO_SUSPEND
+ *     static int foo_suspend(struct device *dev)
+ *     {
+ *        ...
+ *     }
+ *     #endif
+ *
+ *     static struct pm_ops foo_ops = {
+ *     #ifdef CONFIG_FOO_SUSPEND
+ *         .suspend = foo_suspend,
+ *     #endif
+ *     };
+ *
+ * While this works, the foo_suspend() macro is compiled conditionally,
+ * only when CONFIG_FOO_SUSPEND is set. This is problematic, as there could
+ * be a build bug in this function, we wouldn't have a way to know unless
+ * the configuration option is set.
+ *
+ * An alternative is to declare foo_suspend() always, but mark it
+ * as __maybe_unused. This works, but the __maybe_unused attribute
+ * is required to instruct the compiler that the function may not
+ * be referenced anywhere, and is safe to remove without making
+ * a fuss about it. This makes the programmer responsible for tagging
+ * the functions that can be garbage-collected.
+ *
+ * With the macro it is possible to write the following:
+ *
+ *     static int foo_suspend(struct device *dev)
+ *     {
+ *        ...
+ *     }
+ *
+ *     static struct pm_ops foo_ops = {
+ *         .suspend = PTR_IF(IS_ENABLED(CONFIG_FOO_SUSPEND), foo_suspend),
+ *     };
+ *
+ * The foo_suspend() function will now be automatically dropped by the
+ * compiler, and it does not require any specific attribute.
+ */
+#define PTR_IF(cond, ptr)	((cond) ? (ptr) : NULL)
+
+/**
+ * to_user_ptr - cast a pointer passed as u64 from user space to void __user *
+ * @x: The u64 value from user space, usually via IOCTL
+ *
+ * to_user_ptr() simply casts a pointer passed as u64 from user space to void
+ * __user * correctly. Using this lets us get rid of all the tiresome casts.
+ */
+#define u64_to_user_ptr(x)		\
+({					\
+	typecheck(u64, (x));		\
+	(void __user *)(uintptr_t)(x);	\
+})
+
 /**
  * is_insidevar - check if the @ptr points inside the @var memory range.
  * @ptr:	the pointer to a memory address.
-- 
2.47.2


