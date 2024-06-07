Return-Path: <linux-kernel+bounces-205378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4148FFADF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AAF128957E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4237813AD06;
	Fri,  7 Jun 2024 04:28:53 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3361BC4B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734532; cv=none; b=glxZ0UiYhXSaJAOt9ajPKZuJkmPCs9TKy4j7XKhny53EQ5+Nm9/9WkDQBh0aruRJ49flcBnt9PSwdOGkEu4ym4faeAy0VFolrHn7MvFSrNyRx7hXa3hyBpcJk8M0mslWmMe9XZVlI6OYvzIbv1n/r3o+JXtXR0T+ve3yp9OpE6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734532; c=relaxed/simple;
	bh=0Ywb7q9Mt90dxHArIZJAbIj4xd1RI/v2tiGodcavOG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbJevDWh5JW/akKDeA4FRsKHlyT8PZiCdhSoLQti5I/sOZGeLfl5po7Xk8T9/O8hFxdWJE2Yrn9LSmwGxDzI+3c3ZNOxjjh5UnINtwaYpW2GsTBMgY6jeLwLMzpDudNkbXaSR4l0buGs5Y0zRT0UBn264ij1Gv3COQBqMVver5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwSlk1VznzwS3S;
	Fri,  7 Jun 2024 12:24:50 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 24444140413;
	Fri,  7 Jun 2024 12:28:34 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:37 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 096/110] fsck.ubifs: Handle disconnected files
Date: Fri, 7 Jun 2024 12:26:01 +0800
Message-ID: <20240607042615.2069840-97-chengzhihao1@huawei.com>
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

This is the 17/18 step of fsck. Recover disconnected files into
lost+found. If there is no free space left to recover the disconnected
files, fsck may delete the files to make filesystem be consistent.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/fsck.ubifs.c          |   8 ++
 ubifs-utils/fsck.ubifs/fsck.ubifs.h          |   3 +-
 ubifs-utils/fsck.ubifs/handle_disconnected.c | 107 +++++++++++++++++++++++++++
 ubifs-utils/fsck.ubifs/problem.c             |  10 +++
 4 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.c b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
index 0910676c..831a13db 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.c
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
@@ -541,6 +541,13 @@ static int do_fsck(void)
 		goto free_disconnected_files_2;
 	}
 
+	log_out(c, "Handle disconnected files");
+	err = handle_disonnected_files(c);
+	if (err) {
+		exit_code |= FSCK_ERROR;
+		goto free_disconnected_files_2;
+	}
+
 free_disconnected_files_2:
 	destroy_file_list(c, &FSCK(c)->disconnected_files);
 	return err;
@@ -596,6 +603,7 @@ int main(int argc, char *argv[])
 	 * Step 14: Check and correct the index size
 	 * Step 15: Check and create root dir
 	 * Step 16: Check and create lost+found
+	 * Step 17: Handle disconnected files
 	 */
 	err = do_fsck();
 	if (err && FSCK(c)->try_rebuild) {
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index dc24e83c..84159430 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -46,7 +46,7 @@ enum { SB_CORRUPTED = 0, MST_CORRUPTED, LOG_CORRUPTED, BUD_CORRUPTED,
        FILE_ROOT_HAS_DENT, DENTRY_IS_UNREACHABLE, FILE_IS_INCONSISTENT,
        EMPTY_TNC, LPT_CORRUPTED, NNODE_INCORRECT, PNODE_INCORRECT,
        LP_INCORRECT, SPACE_STAT_INCORRECT, LTAB_INCORRECT, INCORRECT_IDX_SZ,
-       ROOT_DIR_NOT_FOUND };
+       ROOT_DIR_NOT_FOUND, DISCONNECTED_FILE_CANNOT_BE_RECOVERED };
 
 enum { HAS_DATA_CORRUPTED = 1, HAS_TNC_CORRUPTED = 2 };
 
@@ -388,5 +388,6 @@ int check_and_correct_index_size(struct ubifs_info *c);
 
 /* handle_disconnected.c */
 int check_and_create_lost_found(struct ubifs_info *c);
+int handle_disonnected_files(struct ubifs_info *c);
 
 #endif
diff --git a/ubifs-utils/fsck.ubifs/handle_disconnected.c b/ubifs-utils/fsck.ubifs/handle_disconnected.c
index b9a380f9..5ca00c0c 100644
--- a/ubifs-utils/fsck.ubifs/handle_disconnected.c
+++ b/ubifs-utils/fsck.ubifs/handle_disconnected.c
@@ -19,6 +19,7 @@
 #include "fsck.ubifs.h"
 
 #define LOST_FOUND_DIR_NAME "lost+found"
+#define MAX_REPEAT_NAME_RETRY_TIMES 10000000
 
 /**
  * check_and_create_lost_found - Check and create the lost+found directory.
@@ -87,3 +88,109 @@ free_root:
 	kfree(root_ui);
 	return err;
 }
+
+static int handle_disonnected_file(struct ubifs_info *c,
+				   struct scanned_file *file)
+{
+	int err = 0;
+
+	if (FSCK(c)->lost_and_found) {
+		unsigned int index = 0;
+		char file_name[UBIFS_MAX_NLEN + 1];
+		struct fscrypt_name nm;
+		struct ubifs_inode *ui = NULL, *lost_found_ui = NULL;
+
+		lost_found_ui = ubifs_lookup_by_inum(c, FSCK(c)->lost_and_found);
+		if (IS_ERR(lost_found_ui)) {
+			err = PTR_ERR(lost_found_ui);
+			ubifs_assert(c, err != -ENOENT);
+			return err;
+		}
+		ui = ubifs_lookup_by_inum(c, file->inum);
+		if (IS_ERR(ui)) {
+			err = PTR_ERR(ui);
+			ubifs_assert(c, err != -ENOENT);
+			goto free_lost_found_ui;
+		}
+
+		while (index < MAX_REPEAT_NAME_RETRY_TIMES) {
+			struct ubifs_inode *target_ui;
+
+			err = snprintf(file_name, sizeof(file_name),
+				       "INO_%lu_%u", file->inum, index);
+			if (err < 0)
+				goto free_ui;
+			fname_name(&nm) = file_name;
+			fname_len(&nm) = strlen(file_name);
+			target_ui = ubifs_lookup(c, lost_found_ui, &nm);
+			if (IS_ERR(target_ui)) {
+				err = PTR_ERR(target_ui);
+				if (err == -ENOENT)
+					break;
+				goto free_ui;
+			}
+			kfree(target_ui);
+			index++;
+		}
+
+		if (err != -ENOENT) {
+			err = 0;
+			kfree(ui);
+			kfree(lost_found_ui);
+			log_out(c, "Too many duplicated names(%u) in lost+found for inum %lu",
+				index, file->inum);
+			goto delete_file;
+		}
+
+		/* Try to recover disconnected file into lost+found. */
+		err = ubifs_link_recovery(c, lost_found_ui, ui, &nm);
+		if (err && err == -ENOSPC) {
+			err = 0;
+			log_out(c, "No free space to recover disconnected file");
+			goto delete_file;
+		}
+		dbg_fsck("recover disconnected file %lu, in %s",
+			 file->inum, c->dev_name);
+
+free_ui:
+		kfree(ui);
+free_lost_found_ui:
+		kfree(lost_found_ui);
+		return err;
+	} else
+		log_out(c, "No valid lost+found");
+
+delete_file:
+	if (fix_problem(c, DISCONNECTED_FILE_CANNOT_BE_RECOVERED, file))
+		err = delete_file(c, file);
+	return err;
+}
+
+/**
+ * handle_disonnected_files - Handle disconnected files.
+ * @c: UBIFS file-system description object
+ *
+ * This function tries to recover disonnected files into lost+found directory.
+ * If there is no free space left to recover the disconnected files, fsck may
+ * delete the files to make filesystem be consistent. Returns zero in case of
+ * success, a negative error code in case of failure.
+ */
+int handle_disonnected_files(struct ubifs_info *c)
+{
+	int err, ret = 0;
+	struct scanned_file *file;
+
+	while (!list_empty(&FSCK(c)->disconnected_files)) {
+		file = list_entry(FSCK(c)->disconnected_files.next,
+				  struct scanned_file, list);
+
+		list_del(&file->list);
+		err = handle_disonnected_file(c, file);
+		if (err)
+			ret = ret ? ret : err;
+		destroy_file_content(c, file);
+		kfree(file);
+	}
+
+	return ret;
+}
diff --git a/ubifs-utils/fsck.ubifs/problem.c b/ubifs-utils/fsck.ubifs/problem.c
index 8e7e1e15..916c9762 100644
--- a/ubifs-utils/fsck.ubifs/problem.c
+++ b/ubifs-utils/fsck.ubifs/problem.c
@@ -69,6 +69,7 @@ static const struct fsck_problem problem_table[] = {
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX, "Inconsistent properties for lprops table"},	// LTAB_INCORRECT
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX, "Incorrect index size"},	// INCORRECT_IDX_SZ
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX, "Root dir is lost"},	// ROOT_DIR_NOT_FOUND
+	{PROBLEM_FIXABLE | PROBLEM_DROP_DATA, "Disconnected file cannot be recovered"},	// DISCONNECTED_FILE_CANNOT_BE_RECOVERED
 };
 
 static const char *get_question(const struct fsck_problem *problem,
@@ -96,6 +97,7 @@ static const char *get_question(const struct fsck_problem *problem,
 	case FILE_HAS_NO_ENCRYPT:
 	case FILE_ROOT_HAS_DENT:
 	case DENTRY_IS_UNREACHABLE:
+	case DISCONNECTED_FILE_CANNOT_BE_RECOVERED:
 		return "Delete it?";
 	case FILE_HAS_INCONSIST_TYPE:
 	case FILE_HAS_TOO_MANY_DENT:
@@ -292,6 +294,14 @@ static void print_problem(const struct ubifs_info *c,
 			problem->desc, c->calc_idx_sz, *calc_sz);
 		break;
 	}
+	case DISCONNECTED_FILE_CANNOT_BE_RECOVERED:
+	{
+		const struct scanned_file *file = (const struct scanned_file *)priv;
+
+		log_out(c, "problem: %s, ino %lu, size %llu", problem->desc,
+			file->inum, file->ino.size);
+		break;
+	}
 	default:
 		log_out(c, "problem: %s", problem->desc);
 		break;
-- 
2.13.6


