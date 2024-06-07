Return-Path: <linux-kernel+bounces-205365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A258FFACC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00DE1F2608D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CF6168C22;
	Fri,  7 Jun 2024 04:27:53 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4DB15EFD6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734469; cv=none; b=ZFGuj07ATCwlvEjWL5M5ulOwL9gi/qcdZR+K/6rG3ugAtmb40zPOQysjw+MLhtSjJbxJ4KALOAw/u2FN80RZ25h1MKo7YXFU6GM/u9hU6xNrG2Ma1dETEKb81o5g4GKewb6QDOVEGpZ1E663eBJxpSIo3i+YBhEuRNCXe1QWpxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734469; c=relaxed/simple;
	bh=z9c0h0u/touDvR76h8aKCFCkCAy1oiSuxOkNqAj+ZbY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYVGZGIe9PPQTKbL1zrrtNBqHs7KKjv29zq3zVLvVLDOy8AA+vGYgfUucCktVUjGezEb6Z09IYp258NwQj+vNH7jnPSpB5+ej+Yop6fLa729zc+VHgUpfxmQ+5owjhx4am8Z6uEwKdmW3I+mN1dPLg3TnGYY4lex+kUZQP+0sJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VwSkP63x0z1SB2c;
	Fri,  7 Jun 2024 12:23:41 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 91957180085;
	Fri,  7 Jun 2024 12:27:40 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:23 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 077/110] fsck.ubifs: Replay journal
Date: Fri, 7 Jun 2024 12:25:42 +0800
Message-ID: <20240607042615.2069840-78-chengzhihao1@huawei.com>
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

This is the 2/18 step of fsck. Replay journal, update TNC & LPT.
There could be following steps and possible errors:
 Step 1. scan log LEB, get all bud LEBs
  a. corrupted scanning data in log area: danger mode with rebuild_fs and
     normal mode with 'yes' answer will turn to rebuild filesystem, other
     modes will exit.
 Step 2. scan bud LEBs, get all nodes
  a. corrupted scanning data in bud LEB: danger mode and normal mode with
     'yes' answer will drop bud LEB and set %FR_LPT_INCORRECT for lpt
     status, other modes will exit.
 Step 3. apply nodes, record latest isize into size_tree
 Step 4. apply nodes, update TNC & LPT
  a. corrupted data searched from TNC: skip node and set %FR_LPT_INCORRECT
     lpt status for danger mode and normal mode with 'yes' answer, other
     modes will exit.
  b. corrupted index node read from TNC: danger mode with rebuild_fs and
     normal mode with 'yes' answer will turn to rebuild filesystem, other
     modes will exit.
  c. corrupted lpt: Set %FR_LPT_CORRUPTED for lpt status. Ignore the
     error.
  d. incorrect lpt: Set %FR_LPT_INCORRECT for lpt status. Ignore the
     error.
  e. If lpt status is not empty, skip updating lpt.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/fsck.ubifs.c | 11 +++++---
 ubifs-utils/fsck.ubifs/fsck.ubifs.h |  5 ++--
 ubifs-utils/fsck.ubifs/load_fs.c    | 29 ++++++++++++++++++--
 ubifs-utils/fsck.ubifs/problem.c    | 39 ++++++++++++++++++++++-----
 ubifs-utils/libubifs/lprops.c       | 21 +++++++++++++++
 ubifs-utils/libubifs/replay.c       | 54 ++++++++++++++++++++++++++++++++-----
 ubifs-utils/libubifs/tnc.c          | 13 +++++++++
 ubifs-utils/libubifs/ubifs.h        | 11 +++++---
 8 files changed, 160 insertions(+), 23 deletions(-)

diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.c b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
index 34641c89..3e7e7093 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.c
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
@@ -325,13 +325,17 @@ static bool fsck_can_ignore_failure(const struct ubifs_info *c,
 	return false;
 }
 
-static const unsigned int reason_mapping_table[] = {};
+static const unsigned int reason_mapping_table[] = {
+	BUD_CORRUPTED,		/* FR_H_BUD_CORRUPTED */
+	TNC_DATA_CORRUPTED,	/* FR_H_TNC_DATA_CORRUPTED */
+};
 
-static bool fsck_handle_failure(const struct ubifs_info *c, unsigned int reason)
+static bool fsck_handle_failure(const struct ubifs_info *c, unsigned int reason,
+				void *priv)
 {
 	ubifs_assert(c, FSCK(c)->mode != REBUILD_MODE);
 
-	return fix_problem(c, reason_mapping_table[reason]);
+	return fix_problem(c, reason_mapping_table[reason], priv);
 }
 
 static void signal_cancel(int sig)
@@ -426,6 +430,7 @@ int main(int argc, char *argv[])
 	/*
 	 * Init: Read superblock
 	 * Step 1: Read master & init lpt
+	 * Step 2: Replay journal
 	 */
 	err = ubifs_load_filesystem(c);
 	if (err) {
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index cbe432c4..917f124e 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -37,7 +37,8 @@ enum { NORMAL_MODE = 0, SAFE_MODE, DANGER_MODE0,
        DANGER_MODE1, REBUILD_MODE, CHECK_MODE };
 
 /* Types of inconsistent problems */
-enum { SB_CORRUPTED = 0, MST_CORRUPTED };
+enum { SB_CORRUPTED = 0, MST_CORRUPTED, LOG_CORRUPTED, BUD_CORRUPTED,
+       TNC_CORRUPTED, TNC_DATA_CORRUPTED };
 
 struct scanned_file;
 
@@ -260,7 +261,7 @@ static inline const char *mode_name(const struct ubifs_info *c)
 extern int exit_code;
 
 /* problem.c */
-bool fix_problem(const struct ubifs_info *c, int problem_type);
+bool fix_problem(const struct ubifs_info *c, int problem_type, const void *priv);
 
 /* load_fs.c */
 int ubifs_load_filesystem(struct ubifs_info *c);
diff --git a/ubifs-utils/fsck.ubifs/load_fs.c b/ubifs-utils/fsck.ubifs/load_fs.c
index 036e307c..f45c4117 100644
--- a/ubifs-utils/fsck.ubifs/load_fs.c
+++ b/ubifs-utils/fsck.ubifs/load_fs.c
@@ -72,7 +72,7 @@ int ubifs_load_filesystem(struct ubifs_info *c)
 	err = ubifs_read_superblock(c);
 	if (err) {
 		if (test_and_clear_failure_reason_callback(c, FR_DATA_CORRUPTED))
-			fix_problem(c, SB_CORRUPTED);
+			fix_problem(c, SB_CORRUPTED, NULL);
 		exit_code |= FSCK_ERROR;
 		goto out_mounting;
 	}
@@ -103,7 +103,7 @@ int ubifs_load_filesystem(struct ubifs_info *c)
 	err = ubifs_read_master(c);
 	if (err) {
 		if (test_and_clear_failure_reason_callback(c, FR_DATA_CORRUPTED)) {
-			if (fix_problem(c, MST_CORRUPTED))
+			if (fix_problem(c, MST_CORRUPTED, NULL))
 				FSCK(c)->try_rebuild = true;
 		} else
 			exit_code |= FSCK_ERROR;
@@ -161,10 +161,34 @@ int ubifs_load_filesystem(struct ubifs_info *c)
 		c->superblock_need_write = 0;
 	}
 
+	log_out(c, "Replay journal");
+	err = ubifs_replay_journal(c);
+	if (err) {
+		unsigned int reason = get_failure_reason_callback(c);
+
+		clear_failure_reason_callback(c);
+		if (reason & FR_DATA_CORRUPTED) {
+			if (fix_problem(c, LOG_CORRUPTED, NULL))
+				FSCK(c)->try_rebuild = true;
+		} else if (reason & FR_TNC_CORRUPTED) {
+			if (fix_problem(c, TNC_CORRUPTED, NULL))
+				FSCK(c)->try_rebuild = true;
+		} else {
+			ubifs_assert(c, reason == 0);
+			exit_code |= FSCK_ERROR;
+		}
+		goto out_journal;
+	}
+
+	/* Calculate 'min_idx_lebs' after journal replay */
+	c->bi.min_idx_lebs = ubifs_calc_min_idx_lebs(c);
+
 	c->mounting = 0;
 
 	return 0;
 
+out_journal:
+	destroy_journal(c);
 out_lpt:
 	ubifs_lpt_free(c, 0);
 out_master:
@@ -188,6 +212,7 @@ out_free:
 
 void ubifs_destroy_filesystem(struct ubifs_info *c)
 {
+	destroy_journal(c);
 	free_wbufs(c);
 	ubifs_lpt_free(c, 0);
 
diff --git a/ubifs-utils/fsck.ubifs/problem.c b/ubifs-utils/fsck.ubifs/problem.c
index 1af66632..9df2c2ae 100644
--- a/ubifs-utils/fsck.ubifs/problem.c
+++ b/ubifs-utils/fsck.ubifs/problem.c
@@ -37,12 +37,39 @@ struct fsck_problem {
 static const struct fsck_problem problem_table[] = {
 	{0, "Corrupted superblock"},	// SB_CORRUPTED
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA | PROBLEM_NEED_REBUILD, "Corrupted master node"},	// MST_CORRUPTED
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA | PROBLEM_NEED_REBUILD, "Corrupted log area"},	// LOG_CORRUPTED
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Corrupted bud LEB"},	// BUD_CORRUPTED
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA | PROBLEM_NEED_REBUILD, "Corrupted index node"},	// TNC_CORRUPTED
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Corrupted data searched from TNC"},	// TNC_DATA_CORRUPTED
 };
 
+static const char *get_question(const struct fsck_problem *problem,
+				int problem_type)
+{
+	if (problem->flags & PROBLEM_NEED_REBUILD)
+		return "Rebuild filesystem?";
+
+	switch (problem_type) {
+	case BUD_CORRUPTED:
+		return "Drop bud?";
+	case TNC_DATA_CORRUPTED:
+		return "Drop it?";
+	}
+
+	return "Fix it?";
+}
+
 static void print_problem(const struct ubifs_info *c,
-			  const struct fsck_problem *problem)
+			  const struct fsck_problem *problem, int problem_type,
+			  const void *priv)
 {
-	log_out(c, "problem: %s", problem->desc);
+	if (problem_type == BUD_CORRUPTED) {
+		const struct ubifs_bud *bud = (const struct ubifs_bud *)priv;
+
+		log_out(c, "problem: %s %d:%d %s", problem->desc, bud->lnum,
+			bud->start, dbg_jhead(bud->jhead));
+	} else
+		log_out(c, "problem: %s", problem->desc);
 }
 
 static void fatal_error(const struct ubifs_info *c,
@@ -59,17 +86,17 @@ static void fatal_error(const struct ubifs_info *c,
  * fix_problem - whether fixing the inconsistent problem
  * @c: UBIFS file-system description object
  * @problem_type: the type of inconsistent problem
+ * @priv: private data for problem instance
  *
  * This function decides to fix/skip the inconsistent problem or abort the
  * program according to @problem_type, returns %true if the problem should
  * be fixed, returns %false if the problem will be skipped.
  */
-bool fix_problem(const struct ubifs_info *c, int problem_type)
+bool fix_problem(const struct ubifs_info *c, int problem_type, const void *priv)
 {
 	bool ans, ask = true, def_y = true;
 	const struct fsck_problem *problem = &problem_table[problem_type];
-	const char *question = (problem->flags & PROBLEM_NEED_REBUILD) ?
-				"Rebuild filesystem?" : "Fix it?";
+	const char *question = get_question(problem, problem_type);
 
 	ubifs_assert(c, FSCK(c)->mode != REBUILD_MODE);
 
@@ -88,7 +115,7 @@ bool fix_problem(const struct ubifs_info *c, int problem_type)
 	    (FSCK(c)->mode == DANGER_MODE0 || FSCK(c)->mode == DANGER_MODE1))
 		ask = false;
 
-	print_problem(c, problem);
+	print_problem(c, problem, problem_type, priv);
 	ans = def_y;
 	if (FSCK(c)->mode == NORMAL_MODE) {
 		printf("%s[%d] (%s%s)", c->program_name, getpid(),
diff --git a/ubifs-utils/libubifs/lprops.c b/ubifs-utils/libubifs/lprops.c
index 84cdb353..a7a23053 100644
--- a/ubifs-utils/libubifs/lprops.c
+++ b/ubifs-utils/libubifs/lprops.c
@@ -656,14 +656,24 @@ int ubifs_change_one_lp(struct ubifs_info *c, int lnum, int free, int dirty,
 	int err = 0, flags;
 	const struct ubifs_lprops *lp;
 
+	if (!test_lpt_valid_callback(c, lnum, LPROPS_NC, LPROPS_NC, LPROPS_NC,
+				     LPROPS_NC))
+		return 0;
+
 	ubifs_get_lprops(c);
 
 	lp = ubifs_lpt_lookup_dirty(c, lnum);
 	if (IS_ERR(lp)) {
 		err = PTR_ERR(lp);
+		if (test_and_clear_failure_reason_callback(c, FR_LPT_CORRUPTED) &&
+		    can_ignore_failure_callback(c, FR_LPT_CORRUPTED))
+			err = 0;
 		goto out;
 	}
 
+	if (!test_lpt_valid_callback(c, lnum, lp->free, lp->dirty, free, dirty))
+		goto out;
+
 	flags = (lp->flags | flags_set) & ~flags_clean;
 	lp = ubifs_change_lp(c, lp, free, dirty, flags, idx_gc_cnt);
 	if (IS_ERR(lp))
@@ -695,14 +705,25 @@ int ubifs_update_one_lp(struct ubifs_info *c, int lnum, int free, int dirty,
 	int err = 0, flags;
 	const struct ubifs_lprops *lp;
 
+	if (!test_lpt_valid_callback(c, lnum, LPROPS_NC, LPROPS_NC, LPROPS_NC,
+				     LPROPS_NC))
+		return 0;
+
 	ubifs_get_lprops(c);
 
 	lp = ubifs_lpt_lookup_dirty(c, lnum);
 	if (IS_ERR(lp)) {
 		err = PTR_ERR(lp);
+		if (test_and_clear_failure_reason_callback(c, FR_LPT_CORRUPTED) &&
+		    can_ignore_failure_callback(c, FR_LPT_CORRUPTED))
+			err = 0;
 		goto out;
 	}
 
+	if (!test_lpt_valid_callback(c, lnum, lp->free, lp->dirty, free,
+				     lp->dirty + dirty))
+		goto out;
+
 	flags = (lp->flags | flags_set) & ~flags_clean;
 	lp = ubifs_change_lp(c, lp, free, lp->dirty + dirty, flags, 0);
 	if (IS_ERR(lp))
diff --git a/ubifs-utils/libubifs/replay.c b/ubifs-utils/libubifs/replay.c
index 0ed12e3a..0895f069 100644
--- a/ubifs-utils/libubifs/replay.c
+++ b/ubifs-utils/libubifs/replay.c
@@ -94,11 +94,18 @@ static int set_bud_lprops(struct ubifs_info *c, struct bud_entry *b)
 	const struct ubifs_lprops *lp;
 	int err = 0, dirty;
 
+	if (!test_lpt_valid_callback(c, b->bud->lnum, LPROPS_NC, LPROPS_NC,
+				     LPROPS_NC, LPROPS_NC))
+		return 0;
+
 	ubifs_get_lprops(c);
 
 	lp = ubifs_lpt_lookup_dirty(c, b->bud->lnum);
 	if (IS_ERR(lp)) {
 		err = PTR_ERR(lp);
+		if (test_and_clear_failure_reason_callback(c, FR_LPT_CORRUPTED) &&
+		    can_ignore_failure_callback(c, FR_LPT_CORRUPTED))
+			err = 0;
 		goto out;
 	}
 
@@ -140,6 +147,10 @@ static int set_bud_lprops(struct ubifs_info *c, struct bud_entry *b)
 				b->bud->lnum, lp->free, lp->dirty, b->free,
 				b->dirty);
 	}
+	if (!test_lpt_valid_callback(c, b->bud->lnum, lp->free, lp->dirty,
+				     b->free, dirty + b->dirty))
+		goto out;
+
 	lp = ubifs_change_lp(c, lp, b->free, dirty + b->dirty,
 			     lp->flags | LPROPS_TAKEN, 0);
 	if (IS_ERR(lp)) {
@@ -766,6 +777,7 @@ out:
 	return err;
 
 out_dump:
+	set_failure_reason_callback(c, FR_DATA_CORRUPTED);
 	ubifs_err(c, "bad node is at LEB %d:%d", lnum, snod->offs);
 	ubifs_dump_node(c, snod->node, c->leb_size - snod->offs);
 	ubifs_scan_destroy(sleb);
@@ -781,14 +793,24 @@ out_dump:
  */
 static int replay_buds(struct ubifs_info *c)
 {
-	struct bud_entry *b;
+	struct bud_entry *b, *tmp_b;
 	int err;
 	unsigned long long prev_sqnum = 0;
 
-	list_for_each_entry(b, &c->replay_buds, list) {
+	list_for_each_entry_safe(b, tmp_b, &c->replay_buds, list) {
 		err = replay_bud(c, b);
-		if (err)
+		if (err) {
+			if (test_and_clear_failure_reason_callback(c, FR_DATA_CORRUPTED) &&
+			    handle_failure_callback(c, FR_H_BUD_CORRUPTED, b->bud)) {
+				/* Set %FR_LPT_INCORRECT for lpt status. */
+				set_lpt_invalid_callback(c, FR_LPT_INCORRECT);
+				/* Skip replaying the bud LEB. */
+				list_del(&b->list);
+				kfree(b);
+				continue;
+			}
 			return err;
+		}
 
 		ubifs_assert(c, b->sqnum > prev_sqnum);
 		prev_sqnum = b->sqnum;
@@ -1062,6 +1084,7 @@ out:
 	return err;
 
 out_dump:
+	set_failure_reason_callback(c, FR_DATA_CORRUPTED);
 	ubifs_err(c, "log error detected while replaying the log at LEB %d:%d",
 		  lnum, offs + snod->offs);
 	ubifs_dump_node(c, snod->node, c->leb_size - snod->offs);
@@ -1086,11 +1109,20 @@ static int take_ihead(struct ubifs_info *c)
 	lp = ubifs_lpt_lookup_dirty(c, c->ihead_lnum);
 	if (IS_ERR(lp)) {
 		err = PTR_ERR(lp);
+		if (test_and_clear_failure_reason_callback(c, FR_LPT_CORRUPTED) &&
+		    can_ignore_failure_callback(c, FR_LPT_CORRUPTED))
+			err = 0;
 		goto out;
 	}
 
 	free = lp->free;
 
+	if (!test_lpt_valid_callback(c, c->ihead_lnum, LPROPS_NC, LPROPS_NC,
+				     LPROPS_NC, LPROPS_NC)) {
+		err = free;
+		goto out;
+	}
+
 	lp = ubifs_change_lp(c, lp, LPROPS_NC, LPROPS_NC,
 			     lp->flags | LPROPS_TAKEN, 0);
 	if (IS_ERR(lp)) {
@@ -1123,10 +1155,17 @@ int ubifs_replay_journal(struct ubifs_info *c)
 	if (free < 0)
 		return free; /* Error code */
 
-	if (c->ihead_offs != c->leb_size - free) {
-		ubifs_err(c, "bad index head LEB %d:%d", c->ihead_lnum,
-			  c->ihead_offs);
-		return -EINVAL;
+	if (c->program_type != FSCK_PROGRAM_TYPE) {
+		/*
+		 * Skip index head checking for fsck, it is hard to check it
+		 * caused by possible corrupted/incorrect lpt, tnc updating
+		 * will report error code if index tree is really corrupted.
+		 */
+		if (c->ihead_offs != c->leb_size - free) {
+			ubifs_err(c, "bad index head LEB %d:%d", c->ihead_lnum,
+				  c->ihead_offs);
+			return -EINVAL;
+		}
 	}
 
 	dbg_mnt("start replaying the journal");
@@ -1147,6 +1186,7 @@ int ubifs_replay_journal(struct ubifs_info *c)
 			 * something went wrong and we cannot proceed mounting
 			 * the file-system.
 			 */
+			set_failure_reason_callback(c, FR_DATA_CORRUPTED);
 			ubifs_err(c, "no UBIFS nodes found at the log head LEB %d:%d, possibly corrupted",
 				  lnum, 0);
 			err = -EINVAL;
diff --git a/ubifs-utils/libubifs/tnc.c b/ubifs-utils/libubifs/tnc.c
index 12c56e0a..cd1013d5 100644
--- a/ubifs-utils/libubifs/tnc.c
+++ b/ubifs-utils/libubifs/tnc.c
@@ -2402,9 +2402,22 @@ int ubifs_tnc_remove_ino(struct ubifs_info *c, ino_t inum)
 
 		xent = ubifs_tnc_next_ent(c, &key1, &nm);
 		if (IS_ERR(xent)) {
+			unsigned int reason;
+
 			err = PTR_ERR(xent);
 			if (err == -ENOENT)
 				break;
+
+			reason = get_failure_reason_callback(c);
+			if (reason & FR_DATA_CORRUPTED) {
+				test_and_clear_failure_reason_callback(c, FR_DATA_CORRUPTED);
+				if (handle_failure_callback(c, FR_H_TNC_DATA_CORRUPTED, NULL)) {
+					/* Set %FR_LPT_INCORRECT for lpt status. */
+					set_lpt_invalid_callback(c, FR_LPT_INCORRECT);
+					/* Leave xattrs to be deleted by subsequent steps */
+					break;
+				}
+			}
 			kfree(pxent);
 			return err;
 		}
diff --git a/ubifs-utils/libubifs/ubifs.h b/ubifs-utils/libubifs/ubifs.h
index 6f965555..ae812ff8 100644
--- a/ubifs-utils/libubifs/ubifs.h
+++ b/ubifs-utils/libubifs/ubifs.h
@@ -1286,7 +1286,7 @@ struct ubifs_info {
 	bool (*can_ignore_failure_cb)(const struct ubifs_info *c,
 				      unsigned int reason);
 	bool (*handle_failure_cb)(const struct ubifs_info *c,
-				  unsigned int reason);
+				  unsigned int reason, void *priv);
 };
 
 extern atomic_long_t ubifs_clean_zn_cnt;
@@ -1542,6 +1542,11 @@ enum {
 	FR_LPT_CORRUPTED = 4,	/* LPT is corrupted */
 	FR_LPT_INCORRECT = 8	/* Space statistics are wrong */
 };
+/* Partial failure reasons in common libs, which are handled by fsck. */
+enum {
+	FR_H_BUD_CORRUPTED = 0,		/* Bud LEB is corrupted */
+	FR_H_TNC_DATA_CORRUPTED,	/* Data searched from TNC is corrupted */
+};
 /* Callback functions for failure(which can be handled by fsck) happens. */
 static inline void set_failure_reason_callback(const struct ubifs_info *c,
 					       unsigned int reason)
@@ -1596,10 +1601,10 @@ static inline bool can_ignore_failure_callback(const struct ubifs_info *c,
 	return false;
 }
 static inline bool handle_failure_callback(const struct ubifs_info *c,
-					   unsigned int reason)
+					   unsigned int reason, void *priv)
 {
 	if (c->handle_failure_cb)
-		return c->handle_failure_cb(c, reason);
+		return c->handle_failure_cb(c, reason, priv);
 
 	return false;
 }
-- 
2.13.6


