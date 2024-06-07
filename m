Return-Path: <linux-kernel+bounces-205367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C23A8FFACD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AEE028274D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D3C169362;
	Fri,  7 Jun 2024 04:27:54 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6027615FA7C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734469; cv=none; b=UP9hnyt7ZPHMpGNEK8Nmnpid8PQfA8/ynYbpqvoVxfQgZ8nMg8YEc2hP8vVQrfoAFHGZ7IWhNdGLZKEWEZ3/AIA9tI7aXehmjix+uU/S6RCbAOW5zt74IXyUlU8K3QnDZLuJ68RSR7QZiJB4TnNhEw5vw16zb/QgZ4L7wp2pFUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734469; c=relaxed/simple;
	bh=pgbABVWF9xDAqtZA0iE6JiCXvGuG5g1u6NgPehQaAlE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPFsoZK5Zx6aLmd5zm+T8loSD3BRpC21DASH2huVD9dfF69TxtTkpV6itVS/5+dnS7Kli5KXlVP/8sCBg62tlmQpj45PHFfKpgxhpSgfWGGdm5Hib4Ne7DhVF7a1bDn6srAonfP1evjyk1vPzvjINLqe7EjWPDs8f4AoSyh2coc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSjj5X5YzmY54;
	Fri,  7 Jun 2024 12:23:05 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 9614A180AA6;
	Fri,  7 Jun 2024 12:27:41 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:34 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 092/110] fsck.ubifs: Check and correct the index size
Date: Fri, 7 Jun 2024 12:25:57 +0800
Message-ID: <20240607042615.2069840-93-chengzhihao1@huawei.com>
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

This is the 14/18 step of fsck. Check and correct the index size by
traversing TNC just like dbg_check_idx_size does. This step should
be executed after first committing, because 'c->calc_idx_sz' can be
changed in 'ubifs_tnc_start_commit' and the initial value of
'c->calc_idx_sz' read from disk is untrusted.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/check_space.c | 28 ++++++++++++++++++++++++++++
 ubifs-utils/fsck.ubifs/fsck.ubifs.c  |  8 ++++++++
 ubifs-utils/fsck.ubifs/fsck.ubifs.h  |  3 ++-
 ubifs-utils/fsck.ubifs/problem.c     |  9 +++++++++
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/ubifs-utils/fsck.ubifs/check_space.c b/ubifs-utils/fsck.ubifs/check_space.c
index cf4b8d3f..a22e5ae1 100644
--- a/ubifs-utils/fsck.ubifs/check_space.c
+++ b/ubifs-utils/fsck.ubifs/check_space.c
@@ -656,3 +656,31 @@ rebuild:
 
 	return err;
 }
+
+/**
+ * check_and_correct_index_size - check & correct the index size.
+ * @c: UBIFS file-system description object
+ *
+ * This function checks and corrects the index size by traversing TNC: Returns
+ * zero in case of success, a negative error code in case of failure.
+ */
+int check_and_correct_index_size(struct ubifs_info *c)
+{
+	int err;
+	unsigned long long index_size = 0;
+
+	ubifs_assert(c, c->bi.old_idx_sz == c->calc_idx_sz);
+	err = dbg_walk_index(c, NULL, add_size, &index_size);
+	if (err) {
+		/* All TNC nodes must be accessible. */
+		ubifs_assert(c, !get_failure_reason_callback(c));
+		return err;
+	}
+
+	dbg_fsck("total index size %llu, in %s", index_size, c->dev_name);
+	if (index_size != c->calc_idx_sz &&
+	    fix_problem(c, INCORRECT_IDX_SZ, &index_size))
+		c->bi.old_idx_sz = c->calc_idx_sz = index_size;
+
+	return 0;
+}
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.c b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
index 66b9c578..d3525e30 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.c
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
@@ -512,6 +512,13 @@ static int do_fsck(void)
 	}
 
 	err = commit_fix_modifications(c);
+	if (err) {
+		exit_code |= FSCK_ERROR;
+		goto free_disconnected_files_2;
+	}
+
+	log_out(c, "Check and correct the index size");
+	err = check_and_correct_index_size(c);
 	if (err)
 		exit_code |= FSCK_ERROR;
 
@@ -567,6 +574,7 @@ int main(int argc, char *argv[])
 	 * Step 11: Check whether the TNC is empty
 	 * Step 12: Check and correct the space statistics
 	 * Step 13: Commit problem fixing modifications
+	 * Step 14: Check and correct the index size
 	 */
 	err = do_fsck();
 	if (err && FSCK(c)->try_rebuild) {
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index cc8b71f5..2d17b205 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -45,7 +45,7 @@ enum { SB_CORRUPTED = 0, MST_CORRUPTED, LOG_CORRUPTED, BUD_CORRUPTED,
        XATTR_HAS_WRONG_HOST, FILE_HAS_NO_ENCRYPT, FILE_IS_DISCONNECTED,
        FILE_ROOT_HAS_DENT, DENTRY_IS_UNREACHABLE, FILE_IS_INCONSISTENT,
        EMPTY_TNC, LPT_CORRUPTED, NNODE_INCORRECT, PNODE_INCORRECT,
-       LP_INCORRECT, SPACE_STAT_INCORRECT, LTAB_INCORRECT };
+       LP_INCORRECT, SPACE_STAT_INCORRECT, LTAB_INCORRECT, INCORRECT_IDX_SZ };
 
 enum { HAS_DATA_CORRUPTED = 1, HAS_TNC_CORRUPTED = 2 };
 
@@ -380,5 +380,6 @@ int get_free_leb(struct ubifs_info *c);
 int build_lpt(struct ubifs_info *c, calculate_lp_callback calculate_lp_cb,
 	      bool free_ltab);
 int check_and_correct_space(struct ubifs_info *c);
+int check_and_correct_index_size(struct ubifs_info *c);
 
 #endif
diff --git a/ubifs-utils/fsck.ubifs/problem.c b/ubifs-utils/fsck.ubifs/problem.c
index f987e480..32182c91 100644
--- a/ubifs-utils/fsck.ubifs/problem.c
+++ b/ubifs-utils/fsck.ubifs/problem.c
@@ -67,6 +67,7 @@ static const struct fsck_problem problem_table[] = {
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX, "Inconsistent properties for LEB"},	// LP_INCORRECT
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX, "Incorrect space statistics"},	// SPACE_STAT_INCORRECT
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX, "Inconsistent properties for lprops table"},	// LTAB_INCORRECT
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX, "Incorrect index size"},	// INCORRECT_IDX_SZ
 };
 
 static const char *get_question(const struct fsck_problem *problem,
@@ -280,6 +281,14 @@ static void print_problem(const struct ubifs_info *c,
 			ssp->calc_lst->total_dead, ssp->calc_lst->total_dark);
 		break;
 	}
+	case INCORRECT_IDX_SZ:
+	{
+		const unsigned long long *calc_sz = (const unsigned long long *)priv;
+
+		log_out(c, "problem: %s, index size is %llu, should be %llu",
+			problem->desc, c->calc_idx_sz, *calc_sz);
+		break;
+	}
 	default:
 		log_out(c, "problem: %s", problem->desc);
 		break;
-- 
2.13.6


