Return-Path: <linux-kernel+bounces-205376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AAE8FFAD7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C228288E22
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3187913C694;
	Fri,  7 Jun 2024 04:28:23 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE67213AD1D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734502; cv=none; b=l2wBodlkmjTR1mH6e7GZrQc2FLlgDiVVjPjjPfMlORoiyj3f3LMfmL+0cngpu46DzgjMIiGJviKNDLdlueWy54poQfsQqamx/P7Uaey3UHI6jDzFKW/sDeFTqD7Zs05jQrfPle143IVaXdHeBMC8qcF2+mKKvzJV2A5mig2Gn+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734502; c=relaxed/simple;
	bh=akszk7IAlNGM0E0vI3zO+6MM22KjVVnJHRZ3TTzrh/8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJaZfI2qIn0Ql2jRZHHtvltCFNl8wlB7vITuzRXv2Ijfr+Nq7KpwmEkfMG7WLwqeztuwABJ8k0vHtmk3sVSb8RMWYvxK7IgmcsxplJvlFXVBho1SMv5Hi3U9CgkjBXs4KmvDCCWAkGNfv0ra2iN/gmu5iRaBvIbaWUQ5NfBivR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSkR1N7yzmXv6;
	Fri,  7 Jun 2024 12:23:43 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B421140416;
	Fri,  7 Jun 2024 12:28:04 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:36 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 094/110] fsck.ubifs: Check and create the root dir
Date: Fri, 7 Jun 2024 12:25:59 +0800
Message-ID: <20240607042615.2069840-95-chengzhihao1@huawei.com>
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

This is the 15/18 step of fsck. Check whether the root dir is existed,
create a new one if it is not found. This step makes sure that filesystem
can be mounted successful.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/check_files.c | 29 +++++++++++++++++++++++++++++
 ubifs-utils/fsck.ubifs/fsck.ubifs.c  |  8 ++++++++
 ubifs-utils/fsck.ubifs/fsck.ubifs.h  |  4 +++-
 ubifs-utils/fsck.ubifs/problem.c     |  3 +++
 4 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/ubifs-utils/fsck.ubifs/check_files.c b/ubifs-utils/fsck.ubifs/check_files.c
index 4190bf91..d52a5660 100644
--- a/ubifs-utils/fsck.ubifs/check_files.c
+++ b/ubifs-utils/fsck.ubifs/check_files.c
@@ -524,3 +524,32 @@ bool tnc_is_empty(struct ubifs_info *c)
 	 */
 	return c->zroot.znode->child_cnt == 0;
 }
+
+/**
+ * check_and_create_root - Check and create root dir.
+ * @c: UBIFS file-system description object
+ *
+ * This function checks whether the root dir is existed, create a new root
+ * dir if it doesn't exist. Returns zero in case of success, a negative error
+ * code in case of failure.
+ */
+int check_and_create_root(struct ubifs_info *c)
+{
+	int err;
+	struct ubifs_inode *ui = ubifs_lookup_by_inum(c, UBIFS_ROOT_INO);
+
+	if (!IS_ERR(ui)) {
+		/* The root dir is found. */
+		dbg_fsck("root dir is found, in %s", c->dev_name);
+		kfree(ui);
+		return 0;
+	}
+
+	err = PTR_ERR(ui);
+	if (err != -ENOENT)
+		return err;
+
+	fix_problem(c, ROOT_DIR_NOT_FOUND, NULL);
+	dbg_fsck("root dir is lost, create a new one, in %s", c->dev_name);
+	return ubifs_create_root(c);
+}
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.c b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
index d3525e30..584965fc 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.c
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
@@ -519,6 +519,13 @@ static int do_fsck(void)
 
 	log_out(c, "Check and correct the index size");
 	err = check_and_correct_index_size(c);
+	if (err) {
+		exit_code |= FSCK_ERROR;
+		goto free_disconnected_files_2;
+	}
+
+	log_out(c, "Check and create root dir");
+	err = check_and_create_root(c);
 	if (err)
 		exit_code |= FSCK_ERROR;
 
@@ -575,6 +582,7 @@ int main(int argc, char *argv[])
 	 * Step 12: Check and correct the space statistics
 	 * Step 13: Commit problem fixing modifications
 	 * Step 14: Check and correct the index size
+	 * Step 15: Check and create root dir
 	 */
 	err = do_fsck();
 	if (err && FSCK(c)->try_rebuild) {
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index 2d17b205..5c305ba0 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -45,7 +45,8 @@ enum { SB_CORRUPTED = 0, MST_CORRUPTED, LOG_CORRUPTED, BUD_CORRUPTED,
        XATTR_HAS_WRONG_HOST, FILE_HAS_NO_ENCRYPT, FILE_IS_DISCONNECTED,
        FILE_ROOT_HAS_DENT, DENTRY_IS_UNREACHABLE, FILE_IS_INCONSISTENT,
        EMPTY_TNC, LPT_CORRUPTED, NNODE_INCORRECT, PNODE_INCORRECT,
-       LP_INCORRECT, SPACE_STAT_INCORRECT, LTAB_INCORRECT, INCORRECT_IDX_SZ };
+       LP_INCORRECT, SPACE_STAT_INCORRECT, LTAB_INCORRECT, INCORRECT_IDX_SZ,
+       ROOT_DIR_NOT_FOUND };
 
 enum { HAS_DATA_CORRUPTED = 1, HAS_TNC_CORRUPTED = 2 };
 
@@ -374,6 +375,7 @@ void update_files_size(struct ubifs_info *c);
 int handle_invalid_files(struct ubifs_info *c);
 int handle_dentry_tree(struct ubifs_info *c);
 bool tnc_is_empty(struct ubifs_info *c);
+int check_and_create_root(struct ubifs_info *c);
 
 /* check_space.c */
 int get_free_leb(struct ubifs_info *c);
diff --git a/ubifs-utils/fsck.ubifs/problem.c b/ubifs-utils/fsck.ubifs/problem.c
index 32182c91..8e7e1e15 100644
--- a/ubifs-utils/fsck.ubifs/problem.c
+++ b/ubifs-utils/fsck.ubifs/problem.c
@@ -68,6 +68,7 @@ static const struct fsck_problem problem_table[] = {
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX, "Incorrect space statistics"},	// SPACE_STAT_INCORRECT
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX, "Inconsistent properties for lprops table"},	// LTAB_INCORRECT
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX, "Incorrect index size"},	// INCORRECT_IDX_SZ
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX, "Root dir is lost"},	// ROOT_DIR_NOT_FOUND
 };
 
 static const char *get_question(const struct fsck_problem *problem,
@@ -105,6 +106,8 @@ static const char *get_question(const struct fsck_problem *problem,
 		return "Put it into disconnected list?";
 	case LPT_CORRUPTED:
 		return "Rebuild LPT?";
+	case ROOT_DIR_NOT_FOUND:
+		return "Create a new one?";
 	}
 
 	return "Fix it?";
-- 
2.13.6


