Return-Path: <linux-kernel+bounces-205362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918128FFACA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D217282EF1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92356167D8B;
	Fri,  7 Jun 2024 04:27:51 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B91B15FA63
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734468; cv=none; b=j4HYaYwyts19j09dLJ5UQi7zmKFdI5Vuf2/7MHclpAhYNoWatn/kj4yJQPR+o6o47eydOBUmAKhgW1a3DKvh6Is2KANmUAbmtAHy8zJfw79v7sTJYnJnxqeu8nGW8xdXwBDnIVyhZ8lD/mik0W8vPXzfiXZpY7IDTzZ7gaIScsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734468; c=relaxed/simple;
	bh=dj8XqzCHDgNg+co4aF0kpWYxaXrhkatAyNgzBwesT1w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bsp+EgO+VW7t61fZRpVj8QswOwgdARx5M0sGZFk215m8X/L+uAUiX06Tj2THk0GTrwDb+0mlFyb3OL+2vEHfytTRMDXx70CPU2KFOUi7wZCLFDgZMm/5Tkw3HMMTS3+jrj90KOLNERXeHEgg0wFs44USWooiteRHeWm6Rm5wRfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSjj2g3QzmXv6;
	Fri,  7 Jun 2024 12:23:05 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 32D4E180AA6;
	Fri,  7 Jun 2024 12:27:41 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:30 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 086/110] fsck.ubifs: Check and handle unreachable files
Date: Fri, 7 Jun 2024 12:25:51 +0800
Message-ID: <20240607042615.2069840-87-chengzhihao1@huawei.com>
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

This is the 9/18 step of fsck. Check and handle unreachable files, the
checking rule is same as rebuild mode which has been implemented in
file_is_reachable, but the methods of handling are different:
1. Move unreachable regular file into disconnected list, let subsequent
   steps to handle them with lost+found.
2. Delete unreachable non-regular file.
3. Delete unreachable directory entries.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/check_files.c   | 57 ++++++++++++++++++++++++++++++++++
 ubifs-utils/fsck.ubifs/extract_files.c | 13 ++++++++
 ubifs-utils/fsck.ubifs/fsck.ubifs.c    |  9 ++++++
 ubifs-utils/fsck.ubifs/fsck.ubifs.h    |  3 +-
 ubifs-utils/fsck.ubifs/problem.c       | 14 +++++++++
 5 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/ubifs-utils/fsck.ubifs/check_files.c b/ubifs-utils/fsck.ubifs/check_files.c
index c5c606e1..2be96193 100644
--- a/ubifs-utils/fsck.ubifs/check_files.c
+++ b/ubifs-utils/fsck.ubifs/check_files.c
@@ -7,6 +7,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <sys/stat.h>
 
 #include "linux_err.h"
 #include "bitops.h"
@@ -442,3 +443,59 @@ int handle_invalid_files(struct ubifs_info *c)
 
 	return 0;
 }
+
+/**
+ * handle_dentry_tree - Handle unreachable dentries and files.
+ * @c: UBIFS file-system description object
+ *
+ * This function iterates all directory entries and remove those unreachable
+ * ones. If file has no directory entries, it becomes unreachable:
+ * 1. If the unreachable file has non-regular type, delete it;
+ * 2. If the unreachable file has regular type, move it into the
+ *    @FSCK(c)->disconnected_files.
+ * 'Unreachable' means that a directory entry can not be searched from '/'.
+ *
+ * Returns zero in case of success, a negative error code in case of failure.
+ */
+int handle_dentry_tree(struct ubifs_info *c)
+{
+	struct rb_node *node;
+	struct scanned_file *file;
+	struct rb_root *tree = &FSCK(c)->scanned_files;
+	LIST_HEAD(unreachable);
+
+	for (node = rb_first(tree); node; node = rb_next(node)) {
+		file = rb_entry(node, struct scanned_file, rb);
+
+		/*
+		 * Since all xattr files are already attached to corresponding
+		 * host file, there are only non-xattr files in the file tree.
+		 */
+		ubifs_assert(c, !file->ino.is_xattr);
+		if (!file_is_reachable(c, file, tree))
+			list_add(&file->list, &unreachable);
+	}
+
+	while (!list_empty(&unreachable)) {
+		file = list_entry(unreachable.next, struct scanned_file, list);
+
+		list_del(&file->list);
+		if (S_ISREG(file->ino.mode)) {
+			/*
+			 * Move regular type unreachable file into the
+			 * @FSCK(c)->disconnected_files.
+			 */
+			list_add(&file->list, &FSCK(c)->disconnected_files);
+			rb_erase(&file->rb, tree);
+		} else {
+			/* Delete non-regular type unreachable file. */
+			int err = delete_file(c, file);
+			if (err)
+				return err;
+			rb_erase(&file->rb, tree);
+			kfree(file);
+		}
+	}
+
+	return 0;
+}
diff --git a/ubifs-utils/fsck.ubifs/extract_files.c b/ubifs-utils/fsck.ubifs/extract_files.c
index 51b83b82..b24445be 100644
--- a/ubifs-utils/fsck.ubifs/extract_files.c
+++ b/ubifs-utils/fsck.ubifs/extract_files.c
@@ -1247,6 +1247,15 @@ retry:
 			dent_node = list_entry(path_list.next,
 					       struct scanned_dent_node, list);
 
+			handle_invalid_file(c, DENTRY_IS_UNREACHABLE,
+					    dent_node->file, dent_node);
+			if (FSCK(c)->mode != REBUILD_MODE) {
+				int err = delete_node(c, &dent_node->key,
+						      dent_node->header.lnum,
+						      dent_node->header.offs);
+				if (err)
+					return err;
+			}
 			dbg_fsck("remove unreachable dentry %s, in %s",
 				 c->encrypted && !file->ino.is_xattr ?
 				 "<encrypted>" : dent_node->name, c->dev_name);
@@ -1260,6 +1269,10 @@ retry:
 	}
 
 	if (!rb_first(&file->dent_nodes)) {
+		if (S_ISREG(file->ino.mode))
+			handle_invalid_file(c, FILE_IS_DISCONNECTED, file, NULL);
+		else
+			handle_invalid_file(c, FILE_HAS_NO_DENT, file, NULL);
 		dbg_fsck("file %lu is unreachable, in %s", file->inum, c->dev_name);
 		return false;
 	}
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.c b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
index 4b1b35b0..fd4890a0 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.c
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
@@ -453,6 +453,14 @@ static int do_fsck(void)
 		goto free_used_lebs;
 	}
 
+	log_out(c, "Check and handle unreachable files");
+	err = handle_dentry_tree(c);
+	if (err) {
+		exit_code |= FSCK_ERROR;
+		goto free_disconnected_files;
+	}
+
+free_disconnected_files:
 	destroy_file_list(c, &FSCK(c)->disconnected_files);
 free_used_lebs:
 	kfree(FSCK(c)->used_lebs);
@@ -495,6 +503,7 @@ int main(int argc, char *argv[])
 	 * Step 6: Traverse tnc and construct files
 	 * Step 7: Update files' size
 	 * Step 8: Check and handle invalid files
+	 * Step 9: Check and handle unreachable files
 	 */
 	err = do_fsck();
 	if (err && FSCK(c)->try_rebuild) {
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index 34d300b2..ba4771a3 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -43,7 +43,7 @@ enum { SB_CORRUPTED = 0, MST_CORRUPTED, LOG_CORRUPTED, BUD_CORRUPTED,
        FILE_HAS_0_NLINK_INODE, FILE_HAS_INCONSIST_TYPE, FILE_HAS_TOO_MANY_DENT,
        FILE_SHOULDNT_HAVE_DATA, FILE_HAS_NO_DENT, XATTR_HAS_NO_HOST,
        XATTR_HAS_WRONG_HOST, FILE_HAS_NO_ENCRYPT, FILE_IS_DISCONNECTED,
-       FILE_ROOT_HAS_DENT };
+       FILE_ROOT_HAS_DENT, DENTRY_IS_UNREACHABLE };
 
 enum { HAS_DATA_CORRUPTED = 1, HAS_TNC_CORRUPTED = 2 };
 
@@ -318,5 +318,6 @@ int ubifs_rebuild_filesystem(struct ubifs_info *c);
 int traverse_tnc_and_construct_files(struct ubifs_info *c);
 void update_files_size(struct ubifs_info *c);
 int handle_invalid_files(struct ubifs_info *c);
+int handle_dentry_tree(struct ubifs_info *c);
 
 #endif
diff --git a/ubifs-utils/fsck.ubifs/problem.c b/ubifs-utils/fsck.ubifs/problem.c
index 9222cba4..0395a34f 100644
--- a/ubifs-utils/fsck.ubifs/problem.c
+++ b/ubifs-utils/fsck.ubifs/problem.c
@@ -58,6 +58,7 @@ static const struct fsck_problem problem_table[] = {
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Encrypted file has no encryption information"},	// FILE_HAS_NO_ENCRYPT
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX, "File is disconnected(regular file without dentries)"},	// FILE_IS_DISCONNECTED
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Root dir should not have a dentry"},	// FILE_ROOT_HAS_DENT
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Dentry is unreachable"},	// DENTRY_IS_UNREACHABLE
 };
 
 static const char *get_question(const struct fsck_problem *problem,
@@ -84,6 +85,7 @@ static const char *get_question(const struct fsck_problem *problem,
 	case XATTR_HAS_WRONG_HOST:
 	case FILE_HAS_NO_ENCRYPT:
 	case FILE_ROOT_HAS_DENT:
+	case DENTRY_IS_UNREACHABLE:
 		return "Delete it?";
 	case FILE_HAS_INCONSIST_TYPE:
 	case FILE_HAS_TOO_MANY_DENT:
@@ -198,6 +200,18 @@ static void print_problem(const struct ubifs_info *c,
 			host->ino.is_xattr ? "(xattr)" : "");
 		break;
 	}
+	case DENTRY_IS_UNREACHABLE:
+	{
+		const struct invalid_file_problem *ifp = (const struct invalid_file_problem *)priv;
+		const struct scanned_dent_node *dent_node = (const struct scanned_dent_node *)ifp->priv;
+
+		log_out(c, "problem: %s, ino %lu, unreachable dentry %s, type %s%s",
+			problem->desc, ifp->file->inum,
+			c->encrypted && !ifp->file->ino.is_xattr ? "<encrypted>" : dent_node->name,
+			ubifs_get_type_name(dent_node->type),
+			key_type(c, &dent_node->key) == UBIFS_XENT_KEY ? "(xattr)" : "");
+		break;
+	}
 	default:
 		log_out(c, "problem: %s", problem->desc);
 		break;
-- 
2.13.6


