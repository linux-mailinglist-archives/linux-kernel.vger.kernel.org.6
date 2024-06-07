Return-Path: <linux-kernel+bounces-205332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1008FFAA5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C68E1F22EB3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63F115B0F9;
	Fri,  7 Jun 2024 04:27:31 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DAA155728
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734449; cv=none; b=QRt3Efrr8qdfbdrpgUIE+FuMdRWpA1b4sSLLj9BbQIbZch5LRMBExDt9GS0rApoZywEb3Xcwity1VF5uIVsjd5Nv0nMrwXV6bhCm4ZmxXd3cXMEfETLdXWVKhpZdB0rHCMkSmMznk3dlChLnQd2ZEoWvEqClKj91x/ObPr00k44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734449; c=relaxed/simple;
	bh=rxXvsXe4e6l7SgXcVxy20OPEtvYS7zT2R13h1D1xl5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tosb8IKCNSMALoayb5m+WCL1yV196BwmR0w1F7OHVAJNX/cMEqG5I9MZCi9beQMidDtl+xGLuuJY23un8ok59m9KFbusBWxFQYhLSsnHSKB77VWeE4rSzxdPH0u+WRVgMSIpYKHOCed0ago+9ieJ0BiUg93zlnMi1Jn4JQE3SCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSjP3X7JzmXhG;
	Fri,  7 Jun 2024 12:22:49 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D786180085;
	Fri,  7 Jun 2024 12:27:25 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:05 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 052/110] ubifs-utils: Adapt gc subsystem in libubifs
Date: Fri, 7 Jun 2024 12:25:17 +0800
Message-ID: <20240607042615.2069840-53-chengzhihao1@huawei.com>
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

Adapt gc subsystem(find.c, gc.c, scan.c) in libubifs, compared with
linux kernel implementations:
 1. Adapt print_hex_dump based on implementations in hexdump.c.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/libubifs/find.c |  9 ++++++++-
 ubifs-utils/libubifs/gc.c   | 10 +++++++---
 ubifs-utils/libubifs/scan.c |  7 ++++++-
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/ubifs-utils/libubifs/find.c b/ubifs-utils/libubifs/find.c
index 873e6e1c..ecf689c4 100644
--- a/ubifs-utils/libubifs/find.c
+++ b/ubifs-utils/libubifs/find.c
@@ -14,8 +14,15 @@
  * for fast access, falling back on scanning the LPT as a last resort.
  */
 
-#include <linux/sort.h>
+#include <sys/types.h>
+
+#include "linux_err.h"
+#include "bitops.h"
+#include "sort.h"
 #include "ubifs.h"
+#include "defs.h"
+#include "debug.h"
+#include "misc.h"
 
 /**
  * struct scan_data - data provided to scan callback functions
diff --git a/ubifs-utils/libubifs/gc.c b/ubifs-utils/libubifs/gc.c
index 3134d070..c3595358 100644
--- a/ubifs-utils/libubifs/gc.c
+++ b/ubifs-utils/libubifs/gc.c
@@ -41,10 +41,14 @@
  * good, and GC takes extra care when moving them.
  */
 
-#include <linux/slab.h>
-#include <linux/pagemap.h>
-#include <linux/list_sort.h>
+#include "linux_err.h"
+#include "bitops.h"
+#include "kmem.h"
 #include "ubifs.h"
+#include "defs.h"
+#include "debug.h"
+#include "key.h"
+#include "misc.h"
 
 /*
  * GC may need to move more than one LEB to make progress. The below constants
diff --git a/ubifs-utils/libubifs/scan.c b/ubifs-utils/libubifs/scan.c
index 84a9157d..74509fd0 100644
--- a/ubifs-utils/libubifs/scan.c
+++ b/ubifs-utils/libubifs/scan.c
@@ -15,7 +15,12 @@
  * debugging functions.
  */
 
+#include "linux_err.h"
+#include "kmem.h"
 #include "ubifs.h"
+#include "defs.h"
+#include "debug.h"
+#include "key.h"
 
 /**
  * scan_padding_bytes - scan for padding bytes.
@@ -232,7 +237,7 @@ void ubifs_scanned_corruption(const struct ubifs_info *c, int lnum, int offs,
 	if (len > 8192)
 		len = 8192;
 	ubifs_err(c, "first %d bytes from LEB %d:%d", len, lnum, offs);
-	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET, 32, 4, buf, len, 1);
+	print_hex_dump("", DUMP_PREFIX_OFFSET, 32, 4, buf, len, 1);
 }
 
 /**
-- 
2.13.6


