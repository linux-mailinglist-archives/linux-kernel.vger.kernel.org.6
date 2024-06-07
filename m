Return-Path: <linux-kernel+bounces-205308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A948FFA89
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8827D1C23ADF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E651815357D;
	Fri,  7 Jun 2024 04:26:59 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0AA144307
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734419; cv=none; b=h6n3kR7bBa7mbD9ZWTSVese6l85P8Qat7vR80SpP+A/5N6aWfwCZGRgbvn/lrPTYSASXcs0H8OIlhTkEKPr51iA3F2dTYCs9IgfSgh/IcgZoMmQ+I8+boIT6tGl4FWG8jL90oQvvw44g4Y2Us9LnwN3HkicUP/H1QGzGScH4RFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734419; c=relaxed/simple;
	bh=Zc6EOgTnbsWVpInWfKdXHRjy5bUAvZLsvm52pPL054Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkmKLT4p6xUqI3GhzFay0vrnyuax5fa8vWYXiUVgIOHB8yZlGjnWLhknKOMIsHwg8t7oI0IlBgTYgnGg07aZqTfj+lVxZ4zIjMhLOT3FGJdAUnTWVsqAnmq/NECGV32Qqvto2fC+JXmnraN3NbC0mKKuiPb83D5xoHhWB0yDDEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwShl6mSbzmYTF;
	Fri,  7 Jun 2024 12:22:15 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id C1F0B14038F;
	Fri,  7 Jun 2024 12:26:51 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:45 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 025/110] ubifs-utils: Add spinlock implementations
Date: Fri, 7 Jun 2024 12:24:50 +0800
Message-ID: <20240607042615.2069840-26-chengzhihao1@huawei.com>
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

Add spinlock implementations, because there are some spinlocks
(eg. c->cnt_lock, c->buds_lock) used in UBIFS linux kernel libs.
The spinlock is implementated based on pthread mutex.

This is a preparation for replacing implementation of UBIFS utils with
linux kernel libs.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am     |  3 ++-
 ubifs-utils/common/spinlock.h | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 ubifs-utils/common/spinlock.h

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index 9e075071..7849114e 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -5,6 +5,7 @@ common_SOURCES = \
 	ubifs-utils/common/atomic.h \
 	ubifs-utils/common/bitops.h \
 	ubifs-utils/common/bitops.c \
+	ubifs-utils/common/spinlock.h \
 	ubifs-utils/common/kmem.h \
 	ubifs-utils/common/kmem.c \
 	ubifs-utils/common/defs.h \
@@ -39,7 +40,7 @@ mkfs_ubifs_SOURCES = \
 	$(common_SOURCES) \
 	ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
 
-mkfs_ubifs_LDADD = libmtd.a libubi.a $(ZLIB_LIBS) $(LZO_LIBS) $(ZSTD_LIBS) $(UUID_LIBS) $(LIBSELINUX_LIBS) $(OPENSSL_LIBS) -lm
+mkfs_ubifs_LDADD = libmtd.a libubi.a $(ZLIB_LIBS) $(LZO_LIBS) $(ZSTD_LIBS) $(UUID_LIBS) $(LIBSELINUX_LIBS) $(OPENSSL_LIBS) -lm -lpthread
 mkfs_ubifs_CPPFLAGS = $(AM_CPPFLAGS) $(ZLIB_CFLAGS) $(LZO_CFLAGS) $(ZSTD_CFLAGS) $(UUID_CFLAGS) $(LIBSELINUX_CFLAGS) \
 	-I$(top_srcdir)/ubi-utils/include -I$(top_srcdir)/ubifs-utils/common
 
diff --git a/ubifs-utils/common/spinlock.h b/ubifs-utils/common/spinlock.h
new file mode 100644
index 00000000..b9ed3938
--- /dev/null
+++ b/ubifs-utils/common/spinlock.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_SPINLOCK_H_
+#define __LINUX_SPINLOCK_H_
+
+#include <pthread.h>
+
+#define spinlock_t		pthread_mutex_t
+#define DEFINE_SPINLOCK(x)	pthread_mutex_t x = PTHREAD_MUTEX_INITIALIZER
+#define spin_lock_init(x)	pthread_mutex_init(x, NULL)
+
+#define spin_lock(x)		pthread_mutex_lock(x)
+#define spin_unlock(x)		pthread_mutex_unlock(x)
+
+#endif
-- 
2.13.6


