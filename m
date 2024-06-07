Return-Path: <linux-kernel+bounces-205293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DED018FFA7C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D081F25680
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CE11411D7;
	Fri,  7 Jun 2024 04:26:55 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6047713DDCD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734414; cv=none; b=P4rdHq/0X+ZPsfXP9XVtVyOACu678+FUW+69PJKuk5O3SSTcqQdO/dlfLqZk/i+fNlncsXo0UJxjhuvQzAaFSuAd+t1h2lzh1LX36A18jjiJImxeeOJc58DmTmuRPjK+r4A3rjYX1Ez2qawhfkOUlVwamwC/OI11Ti+aAU65Ok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734414; c=relaxed/simple;
	bh=n5ws3COHP9Bp2UbM2C2OGutGZ9RZTZsvF1t5cqyrdBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m8K6M91X5rqx1iDOWQw5BQAyvNsLC0YUVhlU8wdPpsx0PQymnN+cLDnn54Yz332yf7TaFdXvnG8nR8ruDHft98ug7s/bPAgE7H8Q5+ds/8PvQQrpvZSMyxpZcLzJrJ8YYEb4jyJ+16+7fKAYsUhXoKBIHzk1RE9NJd+WRncMLvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwSjR5Xv0zsTRt;
	Fri,  7 Jun 2024 12:22:51 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 6FD1414038F;
	Fri,  7 Jun 2024 12:26:50 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:35 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 013/110] ubifs-utils: Add 'dev_name' into 'ubifs_info' structure
Date: Fri, 7 Jun 2024 12:24:38 +0800
Message-ID: <20240607042615.2069840-14-chengzhihao1@huawei.com>
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

Embed new member 'dev_name' into 'ubifs_info' structure, then global
variable 'output' can be removed from mkfs.ubifs.c. Next patches will
import UBIFS libs from linux kernel, which could print messages that
contain device information, so this patch can distinguish different
devices according to messages.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/common/ubifs.h          |  2 ++
 ubifs-utils/mkfs.ubifs/mkfs.ubifs.c | 29 ++++++++++++++---------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/ubifs-utils/common/ubifs.h b/ubifs-utils/common/ubifs.h
index 58aaba9b..502a39ae 100644
--- a/ubifs-utils/common/ubifs.h
+++ b/ubifs-utils/common/ubifs.h
@@ -277,6 +277,7 @@ struct ubifs_znode
  *		 2 - files, 3 - more details
  * @program_type: used to identify the type of current program
  * @program_name: program name
+ * @dev_name: device name
  *
  * @jhead_cnt: count of journal heads
  * @max_bud_bytes: maximum number of bytes allowed in buds
@@ -368,6 +369,7 @@ struct ubifs_info
 	int debug_level;
 	int program_type;
 	const char *program_name;
+	char *dev_name;
 
 	int jhead_cnt;
 	long long max_bud_bytes;
diff --git a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
index f66c6a46..1cafbf3e 100644
--- a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
+++ b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
@@ -145,7 +145,6 @@ static char *root;
 static int root_len;
 static struct fscrypt_context *root_fctx;
 static struct stat root_st;
-static char *output;
 static int out_fd;
 static int out_ubi;
 static int squash_owner;
@@ -407,10 +406,10 @@ static int validate_options(void)
 {
 	int tmp;
 
-	if (!output)
+	if (!c->dev_name)
 		return errmsg("no output file or UBI volume specified");
 	if (root) {
-		tmp = is_contained(output, root);
+		tmp = is_contained(c->dev_name, root);
 		if (tmp < 0)
 			return errmsg("failed to perform output file root check");
 		else if (tmp)
@@ -641,7 +640,7 @@ static int get_options(int argc, char**argv)
 				return errmsg("bad maximum LEB count");
 			break;
 		case 'o':
-			output = xstrdup(optarg);
+			c->dev_name = xstrdup(optarg);
 			break;
 		case 'D':
 			tbl_file = optarg;
@@ -835,13 +834,13 @@ static int get_options(int argc, char**argv)
 		}
 	}
 
-	if (optind != argc && !output)
-		output = xstrdup(argv[optind]);
+	if (optind != argc && !c->dev_name)
+		c->dev_name = xstrdup(argv[optind]);
 
-	if (!output)
+	if (!c->dev_name)
 		return errmsg("not output device or file specified");
 
-	out_ubi = !open_ubi(output);
+	out_ubi = !open_ubi(c->dev_name);
 
 	if (out_ubi) {
 		c->min_io_size = c->di.min_io_size;
@@ -921,7 +920,7 @@ static int get_options(int argc, char**argv)
 		printf("\tmin_io_size:  %d\n", c->min_io_size);
 		printf("\tleb_size:     %d\n", c->leb_size);
 		printf("\tmax_leb_cnt:  %d\n", c->max_leb_cnt);
-		printf("\toutput:       %s\n", output);
+		printf("\toutput:       %s\n", c->dev_name);
 		printf("\tjrn_size:     %llu\n", c->max_bud_bytes);
 		printf("\treserved:     %llu\n", c->rp_size);
 		switch (c->default_compr) {
@@ -2855,11 +2854,11 @@ static int check_volume_empty(void)
 static int open_target(void)
 {
 	if (out_ubi) {
-		out_fd = open(output, O_RDWR | O_EXCL);
+		out_fd = open(c->dev_name, O_RDWR | O_EXCL);
 
 		if (out_fd == -1)
 			return sys_errmsg("cannot open the UBI volume '%s'",
-					   output);
+					   c->dev_name);
 		if (ubi_set_property(out_fd, UBI_VOL_PROP_DIRECT_WRITE, 1)) {
 			close(out_fd);
 			return sys_errmsg("ubi_set_property(set direct_write) failed");
@@ -2872,11 +2871,11 @@ static int open_target(void)
 			}
 		}
 	} else {
-		out_fd = open(output, O_CREAT | O_RDWR | O_TRUNC,
+		out_fd = open(c->dev_name, O_CREAT | O_RDWR | O_TRUNC,
 			      S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH);
 		if (out_fd == -1)
 			return sys_errmsg("cannot create output file '%s'",
-					   output);
+					   c->dev_name);
 	}
 	return 0;
 }
@@ -2896,7 +2895,7 @@ static int close_target(void)
 		if (ubi && ubi_set_property(out_fd, UBI_VOL_PROP_DIRECT_WRITE, 0))
 			return sys_errmsg("ubi_set_property(clear direct_write) failed");
 		if (close(out_fd) == -1)
-			return sys_errmsg("cannot close the target '%s'", output);
+			return sys_errmsg("cannot close the target '%s'", c->dev_name);
 	}
 	return 0;
 }
@@ -3094,7 +3093,7 @@ int main(int argc, char *argv[])
 		printf("Success!\n");
 
 out:
-	free(output);
+	free(c->dev_name);
 	close_ubi();
 	crypto_cleanup();
 	return err;
-- 
2.13.6


