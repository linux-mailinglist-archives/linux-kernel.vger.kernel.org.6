Return-Path: <linux-kernel+bounces-205302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F4D8FFA83
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1931C23A0B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E86314D718;
	Fri,  7 Jun 2024 04:26:57 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F87913E40C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734416; cv=none; b=f8NWtpaPgPVfGArfs+u582rCHSzPDYhKRuIlQG8W2EJY4jqvjqrvvAxrAe7o0Z4qKwH1o+bkyUYh9iK5rxLoYIQciunKcjfXJT95rmahR8LD9IQA3U0zBacc8PEbXKtS06WAGvRE4nITKnHv3fxMb18GVLKh7quST8B6kmHq9VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734416; c=relaxed/simple;
	bh=iLPdc6e3+GxI2wHjO3ieu8gaZnEFNqjX6eO5XMTguOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iA35Gmn0VptjW0SIpI/EmmJOSGEU+Jhi4Lm0OsqcEnReUfR+dr21wT3nBnnmHIbCCjNZb/XsO4iZBy8ngOZCl2hhjeK5R4mO+m2DmoMVPsUKmSlL99xIDU2IGCGlXfhM0nAvwh38854EUCgu4W9glkV7S4eF5zx2VwM8AG9itwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwShl5WxzzmYRx;
	Fri,  7 Jun 2024 12:22:15 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 978D51400D5;
	Fri,  7 Jun 2024 12:26:51 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:42 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 022/110] ubifs-utils: Add linux kernel memory allocation implementations
Date: Fri, 7 Jun 2024 12:24:47 +0800
Message-ID: <20240607042615.2069840-23-chengzhihao1@huawei.com>
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

Add linux kernel memory allocation implementations, because there are many
memory allocations(eg. kmalloc, kzalloc) used in UBIFS linux kernel libs.

This is a preparation for replacing implementation of UBIFS utils with
linux kernel libs.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am |  2 ++
 ubifs-utils/common/kmem.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++
 ubifs-utils/common/kmem.h | 56 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 ubifs-utils/common/kmem.c
 create mode 100644 ubifs-utils/common/kmem.h

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index 69192ffd..13171b74 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -2,6 +2,8 @@ common_SOURCES = \
 	ubifs-utils/common/compiler_attributes.h \
 	ubifs-utils/common/linux_types.h \
 	ubifs-utils/common/linux_err.h \
+	ubifs-utils/common/kmem.h \
+	ubifs-utils/common/kmem.c \
 	ubifs-utils/common/defs.h \
 	ubifs-utils/common/crc16.h \
 	ubifs-utils/common/crc16.c \
diff --git a/ubifs-utils/common/kmem.c b/ubifs-utils/common/kmem.c
new file mode 100644
index 00000000..e926a137
--- /dev/null
+++ b/ubifs-utils/common/kmem.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Simple memory interface
+ */
+
+#include "compiler_attributes.h"
+#include "linux_types.h"
+#include "kmem.h"
+#include "defs.h"
+
+static void *kmem_alloc(size_t size)
+{
+	void *ptr = malloc(size);
+
+	if (ptr == NULL)
+		sys_errmsg("malloc failed (%d bytes)", (int)size);
+	return ptr;
+}
+
+static void *kmem_zalloc(size_t size)
+{
+	void *ptr = kmem_alloc(size);
+
+	if (!ptr)
+		return ptr;
+
+	memset(ptr, 0, size);
+	return ptr;
+}
+
+void *kmalloc(size_t size, gfp_t flags)
+{
+	if (flags & __GFP_ZERO)
+		return kmem_zalloc(size);
+	return kmem_alloc(size);
+}
+
+void *krealloc(void *ptr, size_t new_size, __unused gfp_t flags)
+{
+	ptr = realloc(ptr, new_size);
+	if (ptr == NULL)
+		sys_errmsg("realloc failed (%d bytes)", (int)new_size);
+	return ptr;
+}
+
+void *kmalloc_array(size_t n, size_t size, gfp_t flags)
+{
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(n, size, &bytes)))
+		return NULL;
+	return kmalloc(bytes, flags);
+}
+
+void *kmemdup(const void *src, size_t len, gfp_t gfp)
+{
+	void *p;
+
+	p = kmalloc(len, gfp);
+	if (p)
+		memcpy(p, src, len);
+
+	return p;
+}
diff --git a/ubifs-utils/common/kmem.h b/ubifs-utils/common/kmem.h
new file mode 100644
index 00000000..9fe2a364
--- /dev/null
+++ b/ubifs-utils/common/kmem.h
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2008 Silicon Graphics, Inc.
+ * All Rights Reserved.
+ */
+#ifndef __KMEM_H__
+#define __KMEM_H__
+
+#include <stdlib.h>
+
+typedef unsigned int gfp_t;
+
+#define GFP_KERNEL	0
+#define GFP_NOFS	0
+#define __GFP_NOWARN	0
+#define __GFP_ZERO	1
+
+#define vmalloc(size)	malloc(size)
+#define vfree(ptr)	free(ptr)
+
+extern void	*kmalloc(size_t, gfp_t);
+extern void	*krealloc(void *, size_t, __attribute__((unused)) gfp_t);
+extern void	*kmalloc_array(size_t, size_t, gfp_t);
+extern void	*kmemdup(const void *src, size_t len, gfp_t gfp);
+
+static inline void kfree(const void *ptr)
+{
+	free((void *)ptr);
+}
+
+static inline void kvfree(const void *ptr)
+{
+	kfree(ptr);
+}
+
+static inline void *kvmalloc(size_t size, gfp_t flags)
+{
+	return kmalloc(size, flags);
+}
+
+static inline void *kzalloc(size_t size, gfp_t flags)
+{
+	return kmalloc(size, flags | __GFP_ZERO);
+}
+
+static inline void *__vmalloc(unsigned long size, gfp_t gfp_mask)
+{
+	return kmalloc(size, gfp_mask);
+}
+
+static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
+{
+	return kmalloc_array(n, size, flags | __GFP_ZERO);
+}
+
+#endif
-- 
2.13.6


