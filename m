Return-Path: <linux-kernel+bounces-205298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 328308FFA81
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84908B238E2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9297B14A4C3;
	Fri,  7 Jun 2024 04:26:56 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C29613E3E3
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734415; cv=none; b=R3XJ8WMHuKfFt0oXZdpuXWikni64XikccCA3ay+8C5RfoXH9chkWZEhgaCf4gJilKTYJeHatRiCtncqm9ujUVBxzHz65Wc8vHrB5nOokRCLhnlaj9x0fxDsBBYOYH6P7cGIGznHieEfz6UFMiPUxTLSAnp0hUfwmJMy1MG4fpNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734415; c=relaxed/simple;
	bh=TqR0Drlt5bHLRRFJYfCIYnEYr7vATcOxetFpCZp2R/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUvE42e/Rl+LdDOk5eyw6xIlEJErpHrnNGg0+4xeN8CIl3PHozXSJk5/ukQIVdz7M9PWToqO+22cSEftRIWXESkVz4hrJOfI5WqzTQgXbvO24LHQ8VR8FKTl5XMQnBvU9cd0pgqwUkkDM7r176u3Oof0EvxgGmV1KhGJ/kMUVus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VwSjS5PxQz1SB5K;
	Fri,  7 Jun 2024 12:22:52 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CDE714041A;
	Fri,  7 Jun 2024 12:26:51 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:40 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 019/110] ubifs-utils: Add compiler attributes implementations
Date: Fri, 7 Jun 2024 12:24:44 +0800
Message-ID: <20240607042615.2069840-20-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607042615.2069840-1-chengzhihao1@huawei.com>
References: <20240607042615.2069840-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

Add compiler attributes implementations, such as __packed, __unused,
__const, etc., which could be used in linux kernel libs. Besides, change
some existing attributes into linux kernel style.

This is a preparation for replacing implementation of UBIFS utils with
linux kernel libs.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am                |  1 +
 ubifs-utils/common/compiler_attributes.h | 79 ++++++++++++++++++++++++++++++++
 ubifs-utils/common/fscrypt.h             |  6 ++-
 ubifs-utils/common/sign.c                |  4 +-
 4 files changed, 86 insertions(+), 4 deletions(-)
 create mode 100644 ubifs-utils/common/compiler_attributes.h

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index 90cc7005..d58570fe 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -1,4 +1,5 @@
 common_SOURCES = \
+	ubifs-utils/common/compiler_attributes.h \
 	ubifs-utils/common/defs.h \
 	ubifs-utils/common/crc16.h \
 	ubifs-utils/common/crc16.c \
diff --git a/ubifs-utils/common/compiler_attributes.h b/ubifs-utils/common/compiler_attributes.h
new file mode 100644
index 00000000..bb65d3a9
--- /dev/null
+++ b/ubifs-utils/common/compiler_attributes.h
@@ -0,0 +1,79 @@
+#ifndef __COMPILER_ATTRIBUTES_H__
+#define __COMPILER_ATTRIBUTES_H__
+
+#if __has_attribute(__fallthrough__)
+#define fallthrough	__attribute__((__fallthrough__))
+#else
+#define fallthrough     do {} while (0)
+#endif
+
+#define __packed	__attribute__((__packed__))
+#define __unused	__attribute__((__unused__))
+#define __const		__attribute__((__const__))
+#define __must_check    __attribute__((__warn_unused_result__))
+#ifndef __force
+#define __force
+#endif
+
+/*
+ * Optional: only supported since clang >= 14.0
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-error-function-attribute
+ */
+#if __has_attribute(__error__)
+# define __compiletime_error(msg)       __attribute__((__error__(msg)))
+#else
+# define __compiletime_error(msg)
+#endif
+
+#ifndef __compiletime_error
+# define __compiletime_error(message)
+#endif
+
+#ifdef __OPTIMIZE__
+# define __compiletime_assert(condition, msg, prefix, suffix)		\
+	do {								\
+		extern void prefix ## suffix(void) __compiletime_error(msg); \
+		if (!(condition))					\
+			prefix ## suffix();				\
+	} while (0)
+#else
+# define __compiletime_assert(condition, msg, prefix, suffix) do { } while (0)
+#endif
+
+#define _compiletime_assert(condition, msg, prefix, suffix) \
+	__compiletime_assert(condition, msg, prefix, suffix)
+
+/**
+ * compiletime_assert - break build and emit msg if condition is false
+ * @condition: a compile-time constant condition to check
+ * @msg:       a message to emit if condition is false
+ *
+ * In tradition of POSIX assert, this macro will break the build if the
+ * supplied condition is *false*, emitting the supplied error message if the
+ * compiler has support to do so.
+ */
+#define compiletime_assert(condition, msg) \
+	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
+
+/**
+ * BUILD_BUG_ON_MSG - break compile if a condition is true & emit supplied
+ *		      error message.
+ * @condition: the condition which the compiler should know is false.
+ *
+ * See BUILD_BUG_ON for description.
+ */
+#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
+
+/**
+ * BUILD_BUG_ON - break compile if a condition is true.
+ * @condition: the condition which the compiler should know is false.
+ *
+ * If you have some code which relies on certain constants being equal, or
+ * some other compile-time-evaluated condition, you should use BUILD_BUG_ON to
+ * detect if someone changes it.
+ */
+#define BUILD_BUG_ON(condition) \
+	BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
+
+#endif
diff --git a/ubifs-utils/common/fscrypt.h b/ubifs-utils/common/fscrypt.h
index 908a5041..b8a599de 100644
--- a/ubifs-utils/common/fscrypt.h
+++ b/ubifs-utils/common/fscrypt.h
@@ -25,6 +25,8 @@
 #include <openssl/rand.h>
 #endif
 #include <assert.h>
+
+#include "compiler_attributes.h"
 #include "ubifs.h"
 #include "crypto.h"
 
@@ -79,7 +81,7 @@ struct fscrypt_context {
 	__u8 flags;
 	__u8 master_key_descriptor[FS_KEY_DESCRIPTOR_SIZE];
 	__u8 nonce[FS_KEY_DERIVATION_NONCE_SIZE];
-} __attribute__((packed));
+} __packed;
 
 /**
  * For encrypted symlinks, the ciphertext length is stored at the beginning
@@ -88,7 +90,7 @@ struct fscrypt_context {
 struct fscrypt_symlink_data {
 	__le16 len;
 	char encrypted_path[1];
-} __attribute__((packed));
+} __packed;
 
 
 #ifndef FS_MAX_KEY_SIZE
diff --git a/ubifs-utils/common/sign.c b/ubifs-utils/common/sign.c
index 9c53e671..7530503a 100644
--- a/ubifs-utils/common/sign.c
+++ b/ubifs-utils/common/sign.c
@@ -28,6 +28,7 @@
 #include <openssl/conf.h>
 #include <err.h>
 
+#include "compiler_attributes.h"
 #include "sign.h"
 #include "defs.h"
 #include "ubifs.h"
@@ -116,8 +117,7 @@ static void drain_openssl_errors(void)
 
 static const char *key_pass;
 
-static int pem_pw_cb(char *buf, int len, __attribute__((unused)) int w,
-		     __attribute__((unused)) void *v)
+static int pem_pw_cb(char *buf, int len, __unused int w, __unused void *v)
 {
 	int pwlen;
 
-- 
2.13.6


