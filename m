Return-Path: <linux-kernel+bounces-205305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A663E8FFA88
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40F0DB23E67
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7397815250B;
	Fri,  7 Jun 2024 04:26:59 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACC4147C85
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734418; cv=none; b=EG4C0kpae0oh5l7XphsnrcJolrKwaBxgBjrZX63TNAGlHCvxbV4RfrXNEmEDrakjC70rQ+l1UKcejwJsMiLVEHpyZsB0vexT6HvssgjDvcMwnJU6NKKhxicmKf+l/cRTvZLQRWi80n7DZQEq+ZmYG2CptAqWX0wUEJiWfaBq9fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734418; c=relaxed/simple;
	bh=k1CcI5rFF64l7k3yfUm44s7TxiLl2FG2tTnAxLYCxBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvDIzUmsTAz7mH+13Arn6cVhTUSxdvJ0MunCj7JPGTTKSequFmhkAjeLVQvnuYgOg70S8EfKZBa93kSG6BSjJF8JHIjgEpZjOU+I5YleesQeTTg/c4yUo8of4WeY/LeY5y5X7ZprRVsdIm7/jOVU7bQN8hpPiclgS3DRxoNtybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VwSjT0fYWz1SB5M;
	Fri,  7 Jun 2024 12:22:53 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id D01771400D5;
	Fri,  7 Jun 2024 12:26:51 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:46 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 026/110] ubifs-utils: Add mutexlock implementations
Date: Fri, 7 Jun 2024 12:24:51 +0800
Message-ID: <20240607042615.2069840-27-chengzhihao1@huawei.com>
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

Add mutexlock implementations, because there are some mutexlocks
(eg. c->tnc_mutex, c->log_mutex) used in UBIFS linux kernel libs.
The mutexlock is implementated based on pthread mutex.

This is a preparation for replacing implementation of UBIFS utils with
linux kernel libs.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am  |  1 +
 ubifs-utils/common/mutex.h | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 ubifs-utils/common/mutex.h

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index 7849114e..9f33f0db 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -6,6 +6,7 @@ common_SOURCES = \
 	ubifs-utils/common/bitops.h \
 	ubifs-utils/common/bitops.c \
 	ubifs-utils/common/spinlock.h \
+	ubifs-utils/common/mutex.h \
 	ubifs-utils/common/kmem.h \
 	ubifs-utils/common/kmem.c \
 	ubifs-utils/common/defs.h \
diff --git a/ubifs-utils/common/mutex.h b/ubifs-utils/common/mutex.h
new file mode 100644
index 00000000..4bf018b0
--- /dev/null
+++ b/ubifs-utils/common/mutex.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_MUTEX_H_
+#define __LINUX_MUTEX_H_
+
+#include <pthread.h>
+
+struct mutex {
+	pthread_mutex_t lock;
+};
+
+#define mutex_init(x)		pthread_mutex_init(&(x)->lock, NULL)
+
+#define mutex_lock(x)		pthread_mutex_lock(&(x)->lock)
+#define mutex_lock_nested(x, c)	pthread_mutex_lock(&(x)->lock)
+#define mutex_unlock(x)		pthread_mutex_unlock(&(x)->lock)
+#define mutex_is_locked(x)	(pthread_mutex_trylock(&(x)->lock) == EBUSY)
+
+#endif
-- 
2.13.6


