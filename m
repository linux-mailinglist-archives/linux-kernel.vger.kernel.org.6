Return-Path: <linux-kernel+bounces-205309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77A08FFA8B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F19CB23659
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB45153BC2;
	Fri,  7 Jun 2024 04:27:00 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA2114D2BF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734419; cv=none; b=J33THrkvl0EKJYbAcqjMKZlrL85znAH8fYRnM44F9UA0a04WQxxs1Syn1z2fwFjQcAM8+53uWWgQ0DVOaB0Ofp53xqMa5w/tMZEcRliebrDbnj8vdl/RTuITBg2060Xzd4voVimkQn/xpHkAjkYFsf0rO2vGzrH/4GkR0luKYRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734419; c=relaxed/simple;
	bh=7VGYZQAFbnQuW8kB3hWIlpOvu4pLHWIi6PlbOkdfPTY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0AkAG6QNIEV0KQFucaodcG5sFeDEo/JV97p7E1rE1JcMUnOnmYxuodqsFwI3yHgq4OgEn+UUKPDs2ELCPhl3cG5R1UQ+INjxuxAjzdRl0Mxh3HuGNkYSMTS/26fB13R+9/dkEsFD1w6/l6RnVp1TEpEej9gumSHtL+BF/N0IFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwShm0VlHzmYTL;
	Fri,  7 Jun 2024 12:22:16 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id DE10A14038F;
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
Subject: [RFC PATCH mtd-utils 027/110] ubifs-utils: Add rwsem implementations
Date: Fri, 7 Jun 2024 12:24:52 +0800
Message-ID: <20240607042615.2069840-28-chengzhihao1@huawei.com>
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

Add rwsem implementations, because there are some rwsems
(eg. c->commit_sem) used in UBIFS linux kernel libs.
The rwsem is implementated based on pthread mutex.

This is a preparation for replacing implementation of UBIFS utils with
linux kernel libs.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am  |  1 +
 ubifs-utils/common/rwsem.h | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 ubifs-utils/common/rwsem.h

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index 9f33f0db..ece8a6e9 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -7,6 +7,7 @@ common_SOURCES = \
 	ubifs-utils/common/bitops.c \
 	ubifs-utils/common/spinlock.h \
 	ubifs-utils/common/mutex.h \
+	ubifs-utils/common/rwsem.h \
 	ubifs-utils/common/kmem.h \
 	ubifs-utils/common/kmem.c \
 	ubifs-utils/common/defs.h \
diff --git a/ubifs-utils/common/rwsem.h b/ubifs-utils/common/rwsem.h
new file mode 100644
index 00000000..3761724b
--- /dev/null
+++ b/ubifs-utils/common/rwsem.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_RWSEM_H_
+#define __LINUX_RWSEM_H_
+
+#include <pthread.h>
+
+struct rw_semaphore {
+	pthread_mutex_t lock;
+};
+
+#define init_rwsem(x)			pthread_mutex_init(&(x)->lock, NULL)
+
+#define down_read(x)			pthread_mutex_lock(&(x)->lock)
+#define down_write(x)			pthread_mutex_lock(&(x)->lock)
+#define up_read(x)			pthread_mutex_unlock(&(x)->lock)
+#define up_write(x)			pthread_mutex_unlock(&(x)->lock)
+#define down_write_trylock(x)		(pthread_mutex_trylock(&(x)->lock) == 0)
+
+#endif
-- 
2.13.6


