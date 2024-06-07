Return-Path: <linux-kernel+bounces-205364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0ED8FFACB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A11282D00
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBB1168C0C;
	Fri,  7 Jun 2024 04:27:52 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD2115FA78
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734468; cv=none; b=X3NTLIQroFxAOdG9oa86h97csrQPhNFHTO8LDTne6Tft+eUTLllUplGUaths8gmfy9A4Y8LSsbJxE9CZ4WdxGF+tiOCFddYmohkitzUI2Jxa4x6WKLHjyYT5NmRjalAkpwEfYexvKzS6SiZPRgeapXCHKn2A9YCJycURv8T8zco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734468; c=relaxed/simple;
	bh=y8ElvKpX/zdh0qFJL1BVe/8KgSgB0DT3jAdj/gBG5Lc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhQygUqCP6Dq+s9j6IjnfB9ToZbwQv4WquSqcTlZbP2ZmJA0XCCPhFYGSkj2EyvHHH9Mg89af9UIGFLBxLnz0OiIq6jle/1OORP9tlhrRPnq39lqNOJ2tRBfplRGne6K0BfoU81YB6J+rzw3EcQuICYzyVuRCSCT/xbT8g/SRWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwSkQ4KjXzsTSr;
	Fri,  7 Jun 2024 12:23:42 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 43225180085;
	Fri,  7 Jun 2024 12:27:41 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:31 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 087/110] fsck.ubifs: Check and correct files' information
Date: Fri, 7 Jun 2024 12:25:52 +0800
Message-ID: <20240607042615.2069840-88-chengzhihao1@huawei.com>
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

From: Xiang Yang <xiangyang3@huawei.com>

This is the 10/18 step of fsck. Check and handle inconsistent files, the
checking rule is same as rebuild mode which has been implemented in
check_and_correct_files, but the methods of handling are different:
 1. Correct the file information for safe mode, danger mode and normal
    mode with 'yes' answer, other modes will exit.

Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/extract_files.c | 76 ++++++++++++++++++++++------------
 ubifs-utils/fsck.ubifs/fsck.ubifs.c    |  8 ++++
 ubifs-utils/fsck.ubifs/fsck.ubifs.h    |  2 +-
 ubifs-utils/fsck.ubifs/problem.c       | 16 +++++++
 4 files changed, 74 insertions(+), 28 deletions(-)

diff --git a/ubifs-utils/fsck.ubifs/extract_files.c b/ubifs-utils/fsck.ubifs/extract_files.c
index b24445be..c83d3774 100644
--- a/ubifs-utils/fsck.ubifs/extract_files.c
+++ b/ubifs-utils/fsck.ubifs/extract_files.c
@@ -1292,8 +1292,8 @@ reachable:
  * data nodes and truncation node. The calculated informaion will be used
  * to correct inode node.
  */
-static void calculate_file_info(struct ubifs_info *c, struct scanned_file *file,
-				struct rb_root *file_tree)
+static int calculate_file_info(struct ubifs_info *c, struct scanned_file *file,
+			       struct rb_root *file_tree)
 {
 	int nlink = 0;
 	bool corrupted_truncation = false;
@@ -1306,15 +1306,24 @@ static void calculate_file_info(struct ubifs_info *c, struct scanned_file *file,
 
 	for (node = rb_first(&file->xattr_files); node; node = rb_next(node)) {
 		xattr_file = rb_entry(node, struct scanned_file, rb);
+		dent_node = rb_entry(rb_first(&xattr_file->dent_nodes),
+				     struct scanned_dent_node, rb);
 
+		ubifs_assert(c, xattr_file->ino.is_xattr);
 		ubifs_assert(c, !rb_first(&xattr_file->xattr_files));
-		calculate_file_info(c, xattr_file, file_tree);
+		xattr_file->calc_nlink = 1;
+		xattr_file->calc_size = xattr_file->ino.size;
+
+		file->calc_xcnt += 1;
+		file->calc_xsz += CALC_DENT_SIZE(dent_node->nlen);
+		file->calc_xsz += CALC_XATTR_BYTES(xattr_file->ino.size);
+		file->calc_xnms += dent_node->nlen;
 	}
 
 	if (file->inum == UBIFS_ROOT_INO) {
 		file->calc_nlink += 2;
 		file->calc_size += UBIFS_INO_NODE_SZ;
-		return;
+		return 0;
 	}
 
 	if (S_ISDIR(file->ino.mode)) {
@@ -1326,29 +1335,11 @@ static void calculate_file_info(struct ubifs_info *c, struct scanned_file *file,
 		parent_file = lookup_file(file_tree, key_inum(c, &dent_node->key));
 		if (!parent_file) {
 			ubifs_assert(c, 0);
-			return;
+			return 0;
 		}
 		parent_file->calc_nlink += 1;
 		parent_file->calc_size += CALC_DENT_SIZE(dent_node->nlen);
-		return;
-	}
-
-	if (file->ino.is_xattr) {
-		file->calc_nlink = 1;
-		file->calc_size = file->ino.size;
-
-		dent_node = rb_entry(rb_first(&file->dent_nodes),
-				     struct scanned_dent_node, rb);
-		parent_file = lookup_file(file_tree, key_inum(c, &dent_node->key));
-		if (!parent_file) {
-			ubifs_assert(c, 0);
-			return;
-		}
-		parent_file->calc_xcnt += 1;
-		parent_file->calc_xsz += CALC_DENT_SIZE(dent_node->nlen);
-		parent_file->calc_xsz += CALC_XATTR_BYTES(file->ino.size);
-		parent_file->calc_xnms += dent_node->nlen;
-		return;
+		return 0;
 	}
 
 	for (node = rb_first(&file->dent_nodes); node; node = rb_next(node)) {
@@ -1359,7 +1350,7 @@ static void calculate_file_info(struct ubifs_info *c, struct scanned_file *file,
 		parent_file = lookup_file(file_tree, key_inum(c, &dent_node->key));
 		if (!parent_file) {
 			ubifs_assert(c, 0);
-			return;
+			return 0;
 		}
 		parent_file->calc_size += CALC_DENT_SIZE(dent_node->nlen);
 	}
@@ -1368,7 +1359,7 @@ static void calculate_file_info(struct ubifs_info *c, struct scanned_file *file,
 	if (!S_ISREG(file->ino.mode)) {
 		/* No need to verify i_size for symlink/sock/block/char/fifo. */
 		file->calc_size = file->ino.size;
-		return;
+		return 0;
 	}
 
 	/*
@@ -1452,10 +1443,22 @@ drop_data:
 		data_node = list_entry(drop_list.next, struct scanned_data_node,
 				       list);
 
+		if (FSCK(c)->mode != REBUILD_MODE) {
+			/*
+			 * Don't ask, inconsistent file correcting will be
+			 * asked in function correct_file_info().
+			 */
+			int err = delete_node(c, &data_node->key,
+				data_node->header.lnum, data_node->header.offs);
+			if (err)
+				return err;
+		}
 		list_del(&data_node->list);
 		rb_erase(&data_node->rb, &file->data_nodes);
 		kfree(data_node);
 	}
+
+	return 0;
 }
 
 /**
@@ -1490,6 +1493,7 @@ static int correct_file_info(struct ubifs_info *c, struct scanned_file *file)
 	    file->calc_size == file->ino.size)
 		return 0;
 
+	handle_invalid_file(c, FILE_IS_INCONSISTENT, file, NULL);
 	lnum = file->ino.header.lnum;
 	dbg_fsck("correct file(inum:%lu type:%s), nlink %u->%u, xattr cnt %u->%u, xattr size %u->%u, xattr names %u->%u, size %llu->%llu, at %d:%d, in %s",
 		 file->inum, file->ino.is_xattr ? "xattr" :
@@ -1537,7 +1541,9 @@ int check_and_correct_files(struct ubifs_info *c)
 	for (node = rb_first(tree); node; node = rb_next(node)) {
 		file = rb_entry(node, struct scanned_file, rb);
 
-		calculate_file_info(c, file, tree);
+		err = calculate_file_info(c, file, tree);
+		if (err)
+			return err;
 	}
 
 	for (node = rb_first(tree); node; node = rb_next(node)) {
@@ -1548,5 +1554,21 @@ int check_and_correct_files(struct ubifs_info *c)
 			return err;
 	}
 
+	if (list_empty(&FSCK(c)->disconnected_files))
+		return 0;
+
+	ubifs_assert(c, FSCK(c)->mode != REBUILD_MODE);
+	list_for_each_entry(file, &FSCK(c)->disconnected_files, list) {
+		err = calculate_file_info(c, file, tree);
+		if (err)
+			return err;
+
+		/* Reset disconnected file's nlink as one. */
+		file->calc_nlink = 1;
+		err = correct_file_info(c, file);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.c b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
index fd4890a0..85a5baf0 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.c
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
@@ -460,6 +460,13 @@ static int do_fsck(void)
 		goto free_disconnected_files;
 	}
 
+	log_out(c, "Check and correct files");
+	err = check_and_correct_files(c);
+	if (err) {
+		exit_code |= FSCK_ERROR;
+		goto free_disconnected_files;
+	}
+
 free_disconnected_files:
 	destroy_file_list(c, &FSCK(c)->disconnected_files);
 free_used_lebs:
@@ -504,6 +511,7 @@ int main(int argc, char *argv[])
 	 * Step 7: Update files' size
 	 * Step 8: Check and handle invalid files
 	 * Step 9: Check and handle unreachable files
+	 * Step 10: Check and correct files
 	 */
 	err = do_fsck();
 	if (err && FSCK(c)->try_rebuild) {
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index ba4771a3..d1423c01 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -43,7 +43,7 @@ enum { SB_CORRUPTED = 0, MST_CORRUPTED, LOG_CORRUPTED, BUD_CORRUPTED,
        FILE_HAS_0_NLINK_INODE, FILE_HAS_INCONSIST_TYPE, FILE_HAS_TOO_MANY_DENT,
        FILE_SHOULDNT_HAVE_DATA, FILE_HAS_NO_DENT, XATTR_HAS_NO_HOST,
        XATTR_HAS_WRONG_HOST, FILE_HAS_NO_ENCRYPT, FILE_IS_DISCONNECTED,
-       FILE_ROOT_HAS_DENT, DENTRY_IS_UNREACHABLE };
+       FILE_ROOT_HAS_DENT, DENTRY_IS_UNREACHABLE, FILE_IS_INCONSISTENT };
 
 enum { HAS_DATA_CORRUPTED = 1, HAS_TNC_CORRUPTED = 2 };
 
diff --git a/ubifs-utils/fsck.ubifs/problem.c b/ubifs-utils/fsck.ubifs/problem.c
index 0395a34f..e8f08606 100644
--- a/ubifs-utils/fsck.ubifs/problem.c
+++ b/ubifs-utils/fsck.ubifs/problem.c
@@ -59,6 +59,7 @@ static const struct fsck_problem problem_table[] = {
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX, "File is disconnected(regular file without dentries)"},	// FILE_IS_DISCONNECTED
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Root dir should not have a dentry"},	// FILE_ROOT_HAS_DENT
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Dentry is unreachable"},	// DENTRY_IS_UNREACHABLE
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX, "File is inconsistent"},	// FILE_IS_INCONSISTENT
 };
 
 static const char *get_question(const struct fsck_problem *problem,
@@ -212,6 +213,21 @@ static void print_problem(const struct ubifs_info *c,
 			key_type(c, &dent_node->key) == UBIFS_XENT_KEY ? "(xattr)" : "");
 		break;
 	}
+	case FILE_IS_INCONSISTENT:
+	{
+		const struct invalid_file_problem *ifp = (const struct invalid_file_problem *)priv;
+		const struct scanned_file *file = ifp->file;
+
+		log_out(c, "problem: %s, ino %lu type %s, nlink %u xcnt %u xsz %u xnms %u size %llu, "
+			"should be nlink %u xcnt %u xsz %u xnms %u size %llu",
+			problem->desc, file->inum,
+			file->ino.is_xattr ? "xattr" : ubifs_get_type_name(ubifs_get_dent_type(file->ino.mode)),
+			file->ino.nlink, file->ino.xcnt, file->ino.xsz,
+			file->ino.xnms, file->ino.size,
+			file->calc_nlink, file->calc_xcnt, file->calc_xsz,
+			file->calc_xnms, file->calc_size);
+		break;
+	}
 	default:
 		log_out(c, "problem: %s", problem->desc);
 		break;
-- 
2.13.6


