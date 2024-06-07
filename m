Return-Path: <linux-kernel+bounces-205294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 252B68FFA7E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC841F259AD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932C61422AD;
	Fri,  7 Jun 2024 04:26:55 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D56613E058
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734414; cv=none; b=rpgTU0VBHycD9FXOIUjhBpXPotj4HoKAteap+MrpOMMdn4qMLMV19MhadEo947FZ0/N7ItY3kd+f0RU0YnbNbe/2gi7j+MP6iSxPJ91ebERvxZn8rOJOs9wDOHU65RvD3CkS3zzbC+uwue6rlCu7TVZv2JI39DMjgSdC9POBXDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734414; c=relaxed/simple;
	bh=8hIjvVvQNjF9QjI64CiIWaNzZxfiJszYLe/WCnOyXfg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVhtUp2yJKwaP5S+nUt9kgIv2v8C0NFajC3hAafUTXg4BNKA/LqhXw2Ws3o4XGJiQ0rPNf1SPVfsAQcPPLMXoWD88BSr7UJpkLhEowhyGFne+XoIiU2VYDfPPSOV3wYboWLnzbworbjG84Yn3w1j8ITfuLZNuAceu/cK8fzje78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VwSjR5rc6z1SB5L;
	Fri,  7 Jun 2024 12:22:51 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C2CD14038F;
	Fri,  7 Jun 2024 12:26:50 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:37 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 015/110] ubifs-utils: Extract UBI opening/closing/volume_check_empty functions into a new source file
Date: Fri, 7 Jun 2024 12:24:40 +0800
Message-ID: <20240607042615.2069840-16-chengzhihao1@huawei.com>
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

Move UBI opening/closing/volume_check_empty functions into common/super.c.
These functions will be used in fsck.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am           |   1 +
 ubifs-utils/common/super.c          | 123 ++++++++++++++++++++++++++++++++++++
 ubifs-utils/mkfs.ubifs/mkfs.ubifs.c | 114 ---------------------------------
 3 files changed, 124 insertions(+), 114 deletions(-)
 create mode 100644 ubifs-utils/common/super.c

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index 8af65be7..90cc7005 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -15,6 +15,7 @@ common_SOURCES = \
 	ubifs-utils/common/key.h \
 	ubifs-utils/common/lpt.h \
 	ubifs-utils/common/lpt.c \
+	ubifs-utils/common/super.c \
 	ubifs-utils/common/sign.h \
 	include/mtd/ubifs-media.h
 
diff --git a/ubifs-utils/common/super.c b/ubifs-utils/common/super.c
new file mode 100644
index 00000000..eee0197d
--- /dev/null
+++ b/ubifs-utils/common/super.c
@@ -0,0 +1,123 @@
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+
+#include "defs.h"
+
+/**
+ * open_ubi - open the libubi.
+ * @c: the UBIFS file-system description object
+ * @node: name of the UBI volume character device to fetch information about
+ *
+ * This function opens libubi, and initialize device & volume information
+ * according to @node. Returns %0 in case of success and %-1 in case of failure.
+ */
+int open_ubi(struct ubifs_info *c, const char *node)
+{
+	struct stat st;
+
+	if (stat(node, &st) || !S_ISCHR(st.st_mode))
+		return -1;
+
+	c->libubi = libubi_open();
+	if (!c->libubi)
+		return -1;
+	if (ubi_get_vol_info(c->libubi, node, &c->vi))
+		goto out_err;
+	if (ubi_get_dev_info1(c->libubi, c->vi.dev_num, &c->di))
+		goto out_err;
+
+	return 0;
+
+out_err:
+	close_ubi(c);
+	return -1;
+}
+
+void close_ubi(struct ubifs_info *c)
+{
+	if (c->libubi) {
+		libubi_close(c->libubi);
+		c->libubi = NULL;
+	}
+}
+
+/**
+ * open_target - open the output target.
+ * @c: the UBIFS file-system description object
+ *
+ * Open the output target. The target can be an UBI volume
+ * or a file.
+ *
+ * Returns %0 in case of success and %-1 in case of failure.
+ */
+int open_target(struct ubifs_info *c)
+{
+	if (c->libubi) {
+		c->dev_fd = open(c->dev_name, O_RDWR | O_EXCL);
+
+		if (c->dev_fd == -1)
+			return sys_errmsg("cannot open the UBI volume '%s'",
+					   c->dev_name);
+		if (ubi_set_property(c->dev_fd, UBI_VOL_PROP_DIRECT_WRITE, 1)) {
+			close(c->dev_fd);
+			return sys_errmsg("ubi_set_property(set direct_write) failed");
+		}
+	} else {
+		c->dev_fd = open(c->dev_name, O_CREAT | O_RDWR | O_TRUNC,
+			      S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH);
+		if (c->dev_fd == -1)
+			return sys_errmsg("cannot create output file '%s'",
+					   c->dev_name);
+	}
+	return 0;
+}
+
+
+/**
+ * close_target - close the output target.
+ * @c: the UBIFS file-system description object
+ *
+ * Close the output target. If the target was an UBI
+ * volume, also close libubi.
+ *
+ * Returns %0 in case of success and %-1 in case of failure.
+ */
+int close_target(struct ubifs_info *c)
+{
+	if (c->dev_fd >= 0) {
+		if (c->libubi && ubi_set_property(c->dev_fd, UBI_VOL_PROP_DIRECT_WRITE, 0))
+			return sys_errmsg("ubi_set_property(clear direct_write) failed");
+		if (close(c->dev_fd) == -1)
+			return sys_errmsg("cannot close the target '%s'", c->dev_name);
+	}
+	return 0;
+}
+
+/**
+ * check_volume_empty - check if the UBI volume is empty.
+ * @c: the UBIFS file-system description object
+ *
+ * This function checks if the UBI volume is empty by looking if its LEBs are
+ * mapped or not.
+ *
+ * Returns %0 in case of success, %1 is the volume is not empty,
+ * and a negative error code in case of failure.
+ */
+int check_volume_empty(struct ubifs_info *c)
+{
+	int lnum, err;
+
+	for (lnum = 0; lnum < c->vi.rsvd_lebs; lnum++) {
+		err = ubi_is_mapped(c->dev_fd, lnum);
+		if (err < 0)
+			return err;
+		if (err == 1)
+			return 1;
+	}
+	return 0;
+}
diff --git a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
index 8bff44b2..2181595e 100644
--- a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
+++ b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
@@ -518,44 +518,6 @@ static long long get_bytes(const char *str)
 	return bytes;
 }
 
-void close_ubi(struct ubifs_info *c)
-{
-	if (c->libubi) {
-		libubi_close(c->libubi);
-		c->libubi = NULL;
-	}
-}
-
-/**
- * open_ubi - open the libubi.
- * @c: the UBIFS file-system description object
- * @node: name of the UBI volume character device to fetch information about
- *
- * This function opens libubi, and initialize device & volume information
- * according to @node. Returns %0 in case of success and %-1 in case of failure.
- */
-int open_ubi(struct ubifs_info *c, const char *node)
-{
-	struct stat st;
-
-	if (stat(node, &st) || !S_ISCHR(st.st_mode))
-		return -1;
-
-	c->libubi = libubi_open();
-	if (!c->libubi)
-		return -1;
-	if (ubi_get_vol_info(c->libubi, node, &c->vi))
-		goto out_err;
-	if (ubi_get_dev_info1(c->libubi, c->vi.dev_num, &c->di))
-		goto out_err;
-
-	return 0;
-
-out_err:
-	close_ubi(c);
-	return -1;
-}
-
 static void select_default_compr(void)
 {
 	if (c->encrypted) {
@@ -2821,82 +2783,6 @@ static int write_orphan_area(void)
 }
 
 /**
- * check_volume_empty - check if the UBI volume is empty.
- * @c: the UBIFS file-system description object
- *
- * This function checks if the UBI volume is empty by looking if its LEBs are
- * mapped or not.
- *
- * Returns %0 in case of success, %1 is the volume is not empty,
- * and a negative error code in case of failure.
- */
-int check_volume_empty(struct ubifs_info *c)
-{
-	int lnum, err;
-
-	for (lnum = 0; lnum < c->vi.rsvd_lebs; lnum++) {
-		err = ubi_is_mapped(c->dev_fd, lnum);
-		if (err < 0)
-			return err;
-		if (err == 1)
-			return 1;
-	}
-	return 0;
-}
-
-/**
- * open_target - open the output target.
- * @c: the UBIFS file-system description object
- *
- * Open the output target. The target can be an UBI volume
- * or a file.
- *
- * Returns %0 in case of success and %-1 in case of failure.
- */
-int open_target(struct ubifs_info *c)
-{
-	if (c->libubi) {
-		c->dev_fd = open(c->dev_name, O_RDWR | O_EXCL);
-
-		if (c->dev_fd == -1)
-			return sys_errmsg("cannot open the UBI volume '%s'",
-					   c->dev_name);
-		if (ubi_set_property(c->dev_fd, UBI_VOL_PROP_DIRECT_WRITE, 1)) {
-			close(c->dev_fd);
-			return sys_errmsg("ubi_set_property(set direct_write) failed");
-		}
-	} else {
-		c->dev_fd = open(c->dev_name, O_CREAT | O_RDWR | O_TRUNC,
-			      S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH);
-		if (c->dev_fd == -1)
-			return sys_errmsg("cannot create output file '%s'",
-					   c->dev_name);
-	}
-	return 0;
-}
-
-
-/**
- * close_target - close the output target.
- * @c: the UBIFS file-system description object
- *
- * Close the output target. If the target was an UBI
- * volume, also close libubi.
- *
- * Returns %0 in case of success and %-1 in case of failure.
- */
-int close_target(struct ubifs_info *c)
-{
-	if (c->dev_fd >= 0) {
-		if (c->libubi && ubi_set_property(c->dev_fd, UBI_VOL_PROP_DIRECT_WRITE, 0))
-			return sys_errmsg("ubi_set_property(clear direct_write) failed");
-		if (close(c->dev_fd) == -1)
-			return sys_errmsg("cannot close the target '%s'", c->dev_name);
-	}
-	return 0;
-}
-
-/**
  * init - initialize things.
  */
 static int init(void)
-- 
2.13.6


