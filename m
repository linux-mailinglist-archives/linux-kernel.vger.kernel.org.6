Return-Path: <linux-kernel+bounces-205307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B408FFA8A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5EE6B23F40
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C818115350F;
	Fri,  7 Jun 2024 04:26:59 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376911474AB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734418; cv=none; b=ZfEoOZ4geYAe4Mre8gIJ6m/BVSajDMgG3us6bagY4tG8PRdosq36zRMXY4YorMzCpF0ZsDt8B9asD2LH+fkh++qcuXDCLpSygCpRcXdCWXAbRKPfxaHRINMFzG2fB3U7WU14nkzHtxTpACandrnLbtIhK3zDq255UumtecIyVqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734418; c=relaxed/simple;
	bh=09EzdDOOAgWsnSrDhEW4hwc1l7udXVAzNUQsqHxN+K4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eu9vytoW129kkDID2tiPyZ6NXWMN83SR4JzetU5syzPDUJ2amf9wwshvizoUvobWWw28Bkmj5SfqmvgGFgRbimwoIaltMFeBJZcB5DLV40qzVdu+nVfIn+NNZxy1AsOSOn5nyGtIYhocVryag0r28RYCCo0FXYApykP0eKZt9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwShl5wbgzmYTR;
	Fri,  7 Jun 2024 12:22:15 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id A5ABF14038F;
	Fri,  7 Jun 2024 12:26:51 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:43 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 023/110] ubifs-utils: Add atomic implementations
Date: Fri, 7 Jun 2024 12:24:48 +0800
Message-ID: <20240607042615.2069840-24-chengzhihao1@huawei.com>
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

Add atomic implementations, because there are some atomic operations
(eg. atomic_long_xxx) used in UBIFS linux kernel libs.

This is a preparation for replacing implementation of UBIFS utils with
linux kernel libs.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am   |   1 +
 ubifs-utils/common/atomic.h | 133 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 ubifs-utils/common/atomic.h

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index 13171b74..58162579 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -2,6 +2,7 @@ common_SOURCES = \
 	ubifs-utils/common/compiler_attributes.h \
 	ubifs-utils/common/linux_types.h \
 	ubifs-utils/common/linux_err.h \
+	ubifs-utils/common/atomic.h \
 	ubifs-utils/common/kmem.h \
 	ubifs-utils/common/kmem.c \
 	ubifs-utils/common/defs.h \
diff --git a/ubifs-utils/common/atomic.h b/ubifs-utils/common/atomic.h
new file mode 100644
index 00000000..f287d435
--- /dev/null
+++ b/ubifs-utils/common/atomic.h
@@ -0,0 +1,133 @@
+//Source: http://golubenco.org/atomic-operations.html
+#ifndef __ATOMIC_H__
+#define __ATOMIC_H__
+
+/* Check GCC version, just to be safe */
+#if !defined(__GNUC__) || (__GNUC__ < 4) || (__GNUC_MINOR__ < 1)
+# error atomic.h works only with GCC newer than version 4.1
+#endif /* GNUC >= 4.1 */
+
+/**
+ * Atomic type.
+ */
+typedef struct {
+	volatile long counter;
+} atomic_long_t;
+
+#define ATOMIC_INIT(i)  { (i) }
+
+/**
+ * Read atomic variable
+ * @param v pointer of type atomic_long_t
+ *
+ * Atomically reads the value of @v.
+ */
+#define atomic_long_read(v) ((v)->counter)
+
+/**
+ * Set atomic variable
+ * @param v pointer of type atomic_long_t
+ * @param i required value
+ */
+#define atomic_long_set(v,i) (((v)->counter) = (i))
+
+/**
+ * Add to the atomic variable
+ * @param i integer value to add
+ * @param v pointer of type atomic_long_t
+ */
+static inline void atomic_long_add( int i, atomic_long_t *v )
+{
+	(void)__sync_add_and_fetch(&v->counter, i);
+}
+
+/**
+ * Subtract the atomic variable
+ * @param i integer value to subtract
+ * @param v pointer of type atomic_long_t
+ *
+ * Atomically subtracts @i from @v.
+ */
+static inline void atomic_long_sub( int i, atomic_long_t *v )
+{
+	(void)__sync_sub_and_fetch(&v->counter, i);
+}
+
+/**
+ * Subtract value from variable and test result
+ * @param i integer value to subtract
+ * @param v pointer of type atomic_long_t
+ *
+ * Atomically subtracts @i from @v and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+static inline int atomic_long_sub_and_test( int i, atomic_long_t *v )
+{
+	return !(__sync_sub_and_fetch(&v->counter, i));
+}
+
+/**
+ * Increment atomic variable
+ * @param v pointer of type atomic_long_t
+ *
+ * Atomically increments @v by 1.
+ */
+static inline void atomic_long_inc( atomic_long_t *v )
+{
+	(void)__sync_fetch_and_add(&v->counter, 1);
+}
+
+/**
+ * @brief decrement atomic variable
+ * @param v: pointer of type atomic_long_t
+ *
+ * Atomically decrements @v by 1.  Note that the guaranteed
+ * useful range of an atomic_long_t is only 24 bits.
+ */
+static inline void atomic_long_dec( atomic_long_t *v )
+{
+	(void)__sync_fetch_and_sub(&v->counter, 1);
+}
+
+/**
+ * @brief Decrement and test
+ * @param v pointer of type atomic_long_t
+ *
+ * Atomically decrements @v by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */
+static inline int atomic_long_dec_and_test( atomic_long_t *v )
+{
+	return !(__sync_sub_and_fetch(&v->counter, 1));
+}
+
+/**
+ * @brief Increment and test
+ * @param v pointer of type atomic_long_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+static inline int atomic_long_inc_and_test( atomic_long_t *v )
+{
+	return !(__sync_add_and_fetch(&v->counter, 1));
+}
+
+/**
+ * @brief add and test if negative
+ * @param v pointer of type atomic_long_t
+ * @param i integer value to add
+ *
+ * Atomically adds @i to @v and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */
+static inline int atomic_long_add_negative( int i, atomic_long_t *v )
+{
+	return (__sync_add_and_fetch(&v->counter, i) < 0);
+}
+
+#endif
-- 
2.13.6


