Return-Path: <linux-kernel+bounces-205369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CC58FFACF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9967F1F21A68
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1D5169AEE;
	Fri,  7 Jun 2024 04:27:55 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A47215F417
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734470; cv=none; b=HcLdFTF30CBGIZCIZIbzu++rRTQCZUv8CUR2+G60A2yRdQngdBE9ccls3MMhUlmlBshN9vAFKODM/6z9q4GpxmIQRnk8KbD3YuAoTLP/bryYGqd+0t0ofSeamllH0agSpinaaBPwog0Mbe4ZwB2n8kSzHIDHfL3FOPLFOBFqtRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734470; c=relaxed/simple;
	bh=WUPkSwQWfo+RydasXwp/GJOEpzZF7NGREfJXigaFHjM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUFMyo9t2IGo33Auk37dP31OZLYeddOeQYsPmwtkl7wixTfOWVpC0eHwTcREpUxXPMEv6wrWwUCtt5qiz+hTByJKIMZGkY4yM2TAHuebMlJWZANLIRZXxxqzerZIOgrOLQthsxneOw/0tpAHMyKs5ZhyQbCIp8gV55tbJDBKphA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VwSkQ2HNYz1SB5B;
	Fri,  7 Jun 2024 12:23:42 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 125F0180AA6;
	Fri,  7 Jun 2024 12:27:41 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:28 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 084/110] fsck.ubifs: Update files' size for check mode
Date: Fri, 7 Jun 2024 12:25:49 +0800
Message-ID: <20240607042615.2069840-85-chengzhihao1@huawei.com>
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

This is the 7/18 step of fsck. Update files' size according to size
tree for check mode, now all files are updated after replaying journal.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/check_files.c | 45 ++++++++++++++++++++++++++++++++++++
 ubifs-utils/fsck.ubifs/fsck.ubifs.c  |  3 +++
 ubifs-utils/fsck.ubifs/fsck.ubifs.h  |  1 +
 ubifs-utils/libubifs/recovery.c      | 16 -------------
 ubifs-utils/libubifs/ubifs.h         | 16 +++++++++++++
 5 files changed, 65 insertions(+), 16 deletions(-)

diff --git a/ubifs-utils/fsck.ubifs/check_files.c b/ubifs-utils/fsck.ubifs/check_files.c
index 29848c4e..0fd6b32a 100644
--- a/ubifs-utils/fsck.ubifs/check_files.c
+++ b/ubifs-utils/fsck.ubifs/check_files.c
@@ -309,3 +309,48 @@ out:
 	}
 	return err;
 }
+
+/**
+ * update_files_size - Update files' size.
+ * @c: UBIFS file-system description object
+ *
+ * This function updates files' size according to @c->size_tree for check mode.
+ */
+void update_files_size(struct ubifs_info *c)
+{
+	struct rb_node *this;
+
+	if (FSCK(c)->mode != CHECK_MODE) {
+		/* Other modes(rw) have updated inode size in place. */
+		dbg_fsck("skip updating files' size%s, in %s",
+			 mode_name(c), c->dev_name);
+		return;
+	}
+
+	log_out(c, "Update files' size");
+
+	this = rb_first(&c->size_tree);
+	while (this) {
+		struct size_entry *e;
+
+		e = rb_entry(this, struct size_entry, rb);
+		this = rb_next(this);
+
+		if (e->exists && e->i_size < e->d_size) {
+			struct scanned_file *file;
+
+			file = lookup_file(&FSCK(c)->scanned_files, e->inum);
+			if (file && file->ino.header.exist &&
+			    file->ino.size < e->d_size) {
+				dbg_fsck("update file(%lu) size %llu->%llu, in %s",
+					 e->inum, file->ino.size,
+					 (unsigned long long)e->d_size,
+					 c->dev_name);
+				file->ino.size = e->d_size;
+			}
+		}
+
+		rb_erase(&e->rb, &c->size_tree);
+		kfree(e);
+	}
+}
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.c b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
index 1486ab4d..79b0babc 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.c
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
@@ -443,6 +443,8 @@ static int do_fsck(void)
 		return err;
 	}
 
+	update_files_size(c);
+
 	kfree(FSCK(c)->used_lebs);
 	destroy_file_tree(c, &FSCK(c)->scanned_files);
 	return err;
@@ -481,6 +483,7 @@ int main(int argc, char *argv[])
 
 	/*
 	 * Step 6: Traverse tnc and construct files
+	 * Step 7: Update files' size
 	 */
 	err = do_fsck();
 	if (err && FSCK(c)->try_rebuild) {
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index 0d4a0d63..6c93eb6b 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -298,5 +298,6 @@ int ubifs_rebuild_filesystem(struct ubifs_info *c);
 
 /* check_files.c */
 int traverse_tnc_and_construct_files(struct ubifs_info *c);
+void update_files_size(struct ubifs_info *c);
 
 #endif
diff --git a/ubifs-utils/libubifs/recovery.c b/ubifs-utils/libubifs/recovery.c
index a5133a0f..905e1645 100644
--- a/ubifs-utils/libubifs/recovery.c
+++ b/ubifs-utils/libubifs/recovery.c
@@ -1082,22 +1082,6 @@ int ubifs_rcvry_gc_commit(struct ubifs_info *c)
 }
 
 /**
- * struct size_entry - inode size information for recovery.
- * @rb: link in the RB-tree of sizes
- * @inum: inode number
- * @i_size: size on inode
- * @d_size: maximum size based on data nodes
- * @exists: indicates whether the inode exists
- */
-struct size_entry {
-	struct rb_node rb;
-	ino_t inum;
-	loff_t i_size;
-	loff_t d_size;
-	int exists;
-};
-
-/**
  * add_ino - add an entry to the size tree.
  * @c: UBIFS file-system description object
  * @inum: inode number
diff --git a/ubifs-utils/libubifs/ubifs.h b/ubifs-utils/libubifs/ubifs.h
index 03150cdb..72497cd9 100644
--- a/ubifs-utils/libubifs/ubifs.h
+++ b/ubifs-utils/libubifs/ubifs.h
@@ -1297,6 +1297,22 @@ static inline int ubifs_authenticated(const struct ubifs_info *c)
 	return c->authenticated;
 }
 
+/**
+ * struct size_entry - inode size information for recovery.
+ * @rb: link in the RB-tree of sizes
+ * @inum: inode number
+ * @i_size: size on inode
+ * @d_size: maximum size based on data nodes
+ * @exists: indicates whether the inode exists
+ */
+struct size_entry {
+	struct rb_node rb;
+	ino_t inum;
+	loff_t i_size;
+	loff_t d_size;
+	int exists;
+};
+
 #ifdef WITH_CRYPTO
 int ubifs_init_authentication(struct ubifs_info *c);
 int ubifs_shash_init(const struct ubifs_info *c, struct shash_desc *desc);
-- 
2.13.6


