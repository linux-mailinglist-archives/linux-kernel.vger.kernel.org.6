Return-Path: <linux-kernel+bounces-205295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DEB8FFA7D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD89C1F25A00
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89081142E7B;
	Fri,  7 Jun 2024 04:26:55 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E25213E404
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734415; cv=none; b=liu0f7ll+cPohqMbkV4wz1v0l+Z7tjO958/Ga9MYJxOQne1nTKjpFgyItmAlVDYk3PF0Ci+aLVHqv8AYRurJba7REvDFEMEN9eNfYEWnliJLhn7pamtVMcSpZn1dqr/slIxZRotBMFffDgWYd3uxOO08ShK8Rt8VH667/p7EkDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734415; c=relaxed/simple;
	bh=OKmuBF0VbvlKz+oYSAG7fYgQrHIxc5bI02YSPW78JB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViFZaZiCs/RzE0RPTJ/NmIEFLanfjK1HxhGV2WySIZyTeYu2ysxREqXjbfxG6JD325ehZEl+nftS/MxesScnJBQbqIV+S4eWSDO4spWsNw2AsVyrc2ViI6VOkoxukRZgRe5UGyfuYAooSFCy/6MQKNjiWwAIfFeuiAHpfwNZKIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwShl51G9zmYS9;
	Fri,  7 Jun 2024 12:22:15 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 898A31404F0;
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
Subject: [RFC PATCH mtd-utils 021/110] ubifs-utils: Add linux kernel error conversion definitions
Date: Fri, 7 Jun 2024 12:24:46 +0800
Message-ID: <20240607042615.2069840-22-chengzhihao1@huawei.com>
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

Add linux kernel error conversion definitions, because there are
many error type conversions(eg. PTR_ERR, ERR_PTR) used in UBIFS
linux kernel libs.

This is a preparation for replacing implementation of UBIFS utils with
linux kernel libs.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am      |  1 +
 ubifs-utils/common/linux_err.h | 62 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)
 create mode 100644 ubifs-utils/common/linux_err.h

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index 0f9c0fa6..69192ffd 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -1,6 +1,7 @@
 common_SOURCES = \
 	ubifs-utils/common/compiler_attributes.h \
 	ubifs-utils/common/linux_types.h \
+	ubifs-utils/common/linux_err.h \
 	ubifs-utils/common/defs.h \
 	ubifs-utils/common/crc16.h \
 	ubifs-utils/common/crc16.c \
diff --git a/ubifs-utils/common/linux_err.h b/ubifs-utils/common/linux_err.h
new file mode 100644
index 00000000..5c6ddc3f
--- /dev/null
+++ b/ubifs-utils/common/linux_err.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_ERR_H
+#define _LINUX_ERR_H
+
+/* Adapted from include/linux/err.h */
+
+#include <stdbool.h>
+
+/*
+ * Kernel pointers have redundant information, so we can use a
+ * scheme where we can return either an error code or a normal
+ * pointer with the same return value.
+ *
+ * This should be a per-architecture thing, to allow different
+ * error and pointer decisions.
+ */
+#define MAX_ERRNO	4095
+
+#define IS_ERR_VALUE(x) ((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
+
+static inline void * ERR_PTR(long error)
+{
+	return (void *) error;
+}
+
+static inline long PTR_ERR(const void *ptr)
+{
+	return (long) ptr;
+}
+
+static inline bool IS_ERR(const void *ptr)
+{
+	return IS_ERR_VALUE((unsigned long)ptr);
+}
+
+static inline bool IS_ERR_OR_NULL(const void *ptr)
+{
+	return !ptr || IS_ERR_VALUE((unsigned long)ptr);
+}
+
+/**
+ * ERR_CAST - Explicitly cast an error-valued pointer to another pointer type
+ * @ptr: The pointer to cast.
+ *
+ * Explicitly cast an error-valued pointer to another pointer type in such a
+ * way as to make it clear that's what's going on.
+ */
+static inline void * ERR_CAST(const void *ptr)
+{
+	/* cast away the const */
+	return (void *) ptr;
+}
+
+static inline int PTR_ERR_OR_ZERO(const void *ptr)
+{
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
+	else
+		return 0;
+}
+
+#endif /* _LINUX_ERR_H */
-- 
2.13.6


