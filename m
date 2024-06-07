Return-Path: <linux-kernel+bounces-205289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 664688FFA77
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0304CB22DFF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F60E137932;
	Fri,  7 Jun 2024 04:26:42 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3DE61FFC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734401; cv=none; b=Rl0HqxyQz2+N6/68bpotKfAOfcudzP3AHcNjvshBlK6CVhItv4nCIsxRAQkYxwlJFEkO6vmr9um6Tz1G+ouARiuEg709bjrqRksFTXo3jqHuCa/+uaW/T93cBWvUMhBUZYwImiMf5GcfJuLU5FmUS3ygwIO0k1hUis+cTG7anEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734401; c=relaxed/simple;
	bh=/jvOs1AG1WNw7x7fdX0WtGgfUb52sPHx9xijjWoakNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DnVjfFgqDDSUQIpsINz1gGXtuRpdcFi3/hUqCusZrxHK6ksUIOQTWDV5M7vo7fUPJjl8R7NbQyUvTXadobXAWr5Uk2aM+iRqSa5uuFEBL7dpCaxOxvq1quZXMjCHlpmGQgS+pu61p3bRNbVQOjxxqsUVUQ0zGUQ+2y4sZl4KG4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VwSj54Jh5z1S8tw;
	Fri,  7 Jun 2024 12:22:33 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 56FD518007E;
	Fri,  7 Jun 2024 12:26:32 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:31 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 007/110] ubifs-utils: Move 'debug_level' into ubifs_info structure
Date: Fri, 7 Jun 2024 12:24:32 +0800
Message-ID: <20240607042615.2069840-8-chengzhihao1@huawei.com>
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

Embed new member 'debug_level' into 'ubifs_info' structure, then global
variable 'debug_level' can be removed from mkfs.ubifs.c. Next patches
will import UBIFS libs from linux kernel, which could print messages
with different levels, then 'debug_level' can be used to control which
level messages should be printed.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/common/defs.h                | 6 +++---
 ubifs-utils/common/hashtable/hashtable.c | 1 +
 ubifs-utils/common/ubifs.h               | 3 +++
 ubifs-utils/mkfs.ubifs/mkfs.ubifs.c      | 6 ++----
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/ubifs-utils/common/defs.h b/ubifs-utils/common/defs.h
index 56336b6a..cafc94af 100644
--- a/ubifs-utils/common/defs.h
+++ b/ubifs-utils/common/defs.h
@@ -12,6 +12,8 @@
 #include <byteswap.h>
 #include <errno.h>
 
+#include "ubifs.h"
+
 /* common.h requires the PROGRAM_NAME macro */
 extern struct ubifs_info info_;
 #define PROGRAM_NAME (info_.program_name)
@@ -21,9 +23,7 @@ extern struct ubifs_info info_;
 
 enum { MKFS_PROGRAM_TYPE = 0 };
 
-extern int debug_level;
-
-#define dbg_msg(lvl, fmt, ...) do {if (debug_level >= lvl)                \
+#define dbg_msg(lvl, fmt, ...) do {if (info_.debug_level >= lvl)	\
 	printf("%s: %s: " fmt "\n", PROGRAM_NAME, __FUNCTION__, ##__VA_ARGS__); \
 } while(0)
 
diff --git a/ubifs-utils/common/hashtable/hashtable.c b/ubifs-utils/common/hashtable/hashtable.c
index a3bae166..af7fed97 100644
--- a/ubifs-utils/common/hashtable/hashtable.c
+++ b/ubifs-utils/common/hashtable/hashtable.c
@@ -6,6 +6,7 @@
 #include <math.h>
 
 #include "ubifs.h"
+#include "defs.h"
 #include "hashtable.h"
 #include "hashtable_private.h"
 
diff --git a/ubifs-utils/common/ubifs.h b/ubifs-utils/common/ubifs.h
index 2b0ffe56..58aaba9b 100644
--- a/ubifs-utils/common/ubifs.h
+++ b/ubifs-utils/common/ubifs.h
@@ -273,6 +273,8 @@ struct ubifs_znode
  * @highest_inum: highest used inode number
  * @max_sqnum: current global sequence number
  *
+ * @debug_level: level of debug messages, 0 - none, 1 - statistics,
+ *		 2 - files, 3 - more details
  * @program_type: used to identify the type of current program
  * @program_name: program name
  *
@@ -363,6 +365,7 @@ struct ubifs_info
 	ino_t highest_inum;
 	unsigned long long max_sqnum;
 
+	int debug_level;
 	int program_type;
 	const char *program_name;
 
diff --git a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
index 0bcaa5e4..51852861 100644
--- a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
+++ b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
@@ -138,8 +138,6 @@ struct ubifs_info info_;
 static struct ubifs_info *c = &info_;
 static libubi_t ubi;
 
-/* Debug levels are: 0 (none), 1 (statistics), 2 (files) ,3 (more details) */
-int debug_level;
 int verbose;
 int yes;
 
@@ -657,9 +655,9 @@ static int get_options(int argc, char**argv)
 			common_print_version();
 			exit(EXIT_SUCCESS);
 		case 'g':
-			debug_level = strtol(optarg, &endp, 0);
+			c->debug_level = strtol(optarg, &endp, 0);
 			if (*endp != '\0' || endp == optarg ||
-			    debug_level < 0 || debug_level > 3)
+			    c->debug_level < 0 || c->debug_level > 3)
 				return errmsg("bad debugging level '%s'",
 					       optarg);
 			break;
-- 
2.13.6


