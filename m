Return-Path: <linux-kernel+bounces-205345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1C18FFAB2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F120283092
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D531215E5CC;
	Fri,  7 Jun 2024 04:27:39 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7718515AD9E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734453; cv=none; b=a4xTuyCqxnIB0VVnoVLImm/Ov75/w5MRXhwBYTVDkp7hpEH0PUcBNcjY35W9Jqvay/Je54b6d1KDKgCZYLDZn2giySXvK8h19wpmsUa5RNW1vZoa2jdBkYKuKrZh5MvLDThbro8ZflQ6j4fIfktKAarM+OmImQVF/ahTDfHk4QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734453; c=relaxed/simple;
	bh=tAep6cZ9B7jf2fRQtljS23Y62ZZsIe0HmkTxmZjQmb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4rHxllXYWW8SLq/VdfHDB+UWcfoCMlMqF7wdUSgvVCvbkjF9pAY0MIxYBlEoEY1bDhJ0vkPQcU+YphD6tETTxfGAJXHm5bwfOvi+//ZhMiCKS15lsNPXl1gR/YDbR7rwRy++WLSA8bOhChXIBQTy9xybakKf2FPAMUsPwmsxVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwSk75mGszsTSq;
	Fri,  7 Jun 2024 12:23:27 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 74106180AA6;
	Fri,  7 Jun 2024 12:27:26 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:17 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 069/110] fsck.ubifs: rebuild_fs: Record used LEBs
Date: Fri, 7 Jun 2024 12:25:34 +0800
Message-ID: <20240607042615.2069840-70-chengzhihao1@huawei.com>
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

This is the 7/12 step of rebuilding. Record used LEBs which may hold
useful nodes, then left unused LEBs could be taken for storing new index
tree. Notice, LEB that contains effective nodes on deleted trees in step
1 is regarded as used.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/fsck.ubifs.h |   2 +
 ubifs-utils/fsck.ubifs/rebuild_fs.c | 115 +++++++++++++++++++++++++++++++++++-
 2 files changed, 114 insertions(+), 3 deletions(-)

diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index 124c8f12..0b065935 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -180,9 +180,11 @@ struct scanned_file {
 
 /**
  * ubifs_rebuild_info - UBIFS rebuilding information.
+ * @used_lebs: a bitmap used for recording used lebs
  * @scanned_files: tree of all scanned files
  */
 struct ubifs_rebuild_info {
+	unsigned long *used_lebs;
 	struct rb_root scanned_files;
 };
 
diff --git a/ubifs-utils/fsck.ubifs/rebuild_fs.c b/ubifs-utils/fsck.ubifs/rebuild_fs.c
index ecf6b0c6..f5412f08 100644
--- a/ubifs-utils/fsck.ubifs/rebuild_fs.c
+++ b/ubifs-utils/fsck.ubifs/rebuild_fs.c
@@ -48,19 +48,29 @@ static int init_rebuild_info(struct ubifs_info *c)
 	if (!FSCK(c)->rebuild) {
 		err = -ENOMEM;
 		log_err(c, errno, "can not allocate rebuild info");
-		goto out;
+		goto free_sbuf;
 	}
 	FSCK(c)->rebuild->scanned_files = RB_ROOT;
+	FSCK(c)->rebuild->used_lebs = kcalloc(BITS_TO_LONGS(c->main_lebs),
+					      sizeof(unsigned long), GFP_KERNEL);
+	if (!FSCK(c)->rebuild->used_lebs) {
+		err = -ENOMEM;
+		log_err(c, errno, "can not allocate bitmap of used lebs");
+		goto free_rebuild;
+	}
 
 	return 0;
 
-out:
+free_rebuild:
+	kfree(FSCK(c)->rebuild);
+free_sbuf:
 	vfree(c->sbuf);
 	return err;
 }
 
 static void destroy_rebuild_info(struct ubifs_info *c)
 {
+	kfree(FSCK(c)->rebuild->used_lebs);
 	kfree(FSCK(c)->rebuild);
 	vfree(c->sbuf);
 }
@@ -451,6 +461,9 @@ static void remove_del_nodes(struct ubifs_info *c, struct scanned_info *si)
 
 		valid_ino_node = lookup_valid_ino_node(c, si, del_ino_node);
 		if (valid_ino_node) {
+			int lnum = del_ino_node->header.lnum;
+
+			set_bit(lnum - c->main_first, FSCK(c)->rebuild->used_lebs);
 			rb_erase(&valid_ino_node->rb, &si->valid_inos);
 			kfree(valid_ino_node);
 		}
@@ -466,6 +479,9 @@ static void remove_del_nodes(struct ubifs_info *c, struct scanned_info *si)
 
 		valid_dent_node = lookup_valid_dent_node(c, si, del_dent_node);
 		if (valid_dent_node) {
+			int lnum = del_dent_node->header.lnum;
+
+			set_bit(lnum - c->main_first, FSCK(c)->rebuild->used_lebs);
 			rb_erase(&valid_dent_node->rb, &si->valid_dents);
 			kfree(valid_dent_node);
 		}
@@ -627,6 +643,93 @@ static void extract_dentry_tree(struct ubifs_info *c)
 	}
 }
 
+static const char *get_file_name(struct ubifs_info *c, struct scanned_file *file)
+{
+	static char name[UBIFS_MAX_NLEN + 1];
+	struct rb_node *node;
+	struct scanned_dent_node *dent_node;
+
+	node = rb_first(&file->dent_nodes);
+	if (!node) {
+		ubifs_assert(c, file->inum == UBIFS_ROOT_INO);
+		return "/";
+	}
+
+	if (c->encrypted && !file->ino.is_xattr)
+		/* Encrypted file name. */
+		return "<encrypted>";
+
+	/* Get name from any one dentry. */
+	dent_node = rb_entry(node, struct scanned_dent_node, rb);
+	memcpy(name, dent_node->name, dent_node->nlen);
+	/* @dent->name could be non '\0' terminated. */
+	name[dent_node->nlen] = '\0';
+	return name;
+}
+
+static void record_file_used_lebs(struct ubifs_info *c,
+				  struct scanned_file *file)
+{
+	int lnum;
+	struct rb_node *node;
+	struct scanned_file *xattr_file;
+	struct scanned_dent_node *dent_node;
+	struct scanned_data_node *data_node;
+
+	dbg_fsck("recovered file(inum:%lu name:%s type:%s), in %s",
+		 file->inum, get_file_name(c, file),
+		 file->ino.is_xattr ? "xattr" :
+		 ubifs_get_type_name(ubifs_get_dent_type(file->ino.mode)),
+		 c->dev_name);
+
+	lnum = file->ino.header.lnum;
+	set_bit(lnum - c->main_first, FSCK(c)->rebuild->used_lebs);
+
+	if (file->trun.header.exist) {
+		lnum = file->trun.header.lnum;
+		set_bit(lnum - c->main_first, FSCK(c)->rebuild->used_lebs);
+	}
+
+	for (node = rb_first(&file->data_nodes); node; node = rb_next(node)) {
+		data_node = rb_entry(node, struct scanned_data_node, rb);
+
+		lnum = data_node->header.lnum;
+		set_bit(lnum - c->main_first, FSCK(c)->rebuild->used_lebs);
+	}
+
+	for (node = rb_first(&file->dent_nodes); node; node = rb_next(node)) {
+		dent_node = rb_entry(node, struct scanned_dent_node, rb);
+
+		lnum = dent_node->header.lnum;
+		set_bit(lnum - c->main_first, FSCK(c)->rebuild->used_lebs);
+	}
+
+	for (node = rb_first(&file->xattr_files); node; node = rb_next(node)) {
+		xattr_file = rb_entry(node, struct scanned_file, rb);
+
+		record_file_used_lebs(c, xattr_file);
+	}
+}
+
+/**
+ * record_used_lebs - record used LEBs.
+ * @c: UBIFS file-system description object
+ *
+ * This function records all used LEBs which may hold useful nodes, then left
+ * unused LEBs could be taken for storing new index tree.
+ */
+static void record_used_lebs(struct ubifs_info *c)
+{
+	struct scanned_file *file;
+	struct rb_root *tree = &FSCK(c)->rebuild->scanned_files;
+
+	for (node = rb_first(tree); node; node = rb_next(node)) {
+		file = rb_entry(node, struct scanned_file, rb);
+
+		record_file_used_lebs(c, file);
+	}
+}
+
 /**
  * ubifs_rebuild_filesystem - Rebuild filesystem.
  * @c: UBIFS file-system description object
@@ -680,8 +783,14 @@ int ubifs_rebuild_filesystem(struct ubifs_info *c)
 	/* Step 6: Check & correct files' information. */
 	log_out(c, "Check & correct file information");
 	err = check_and_correct_files(c);
-	if (err)
+	if (err) {
 		exit_code |= FSCK_ERROR;
+		goto out;
+	}
+
+	/* Step 7: Record used LEBs. */
+	log_out(c, "Record used LEBs");
+	record_used_lebs(c);
 
 out:
 	destroy_scanned_info(c, &si);
-- 
2.13.6


