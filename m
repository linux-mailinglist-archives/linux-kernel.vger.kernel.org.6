Return-Path: <linux-kernel+bounces-205356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A457C8FFAC3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301A71F25555
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90361667E2;
	Fri,  7 Jun 2024 04:27:49 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708DF15F308
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734465; cv=none; b=m2Q3PcuoVeD67L3RBShbtpbgvfJh7itmaAYdtb2zyY1u/9S8PoZeKuranyToOLAuGfRSb87uT1Dg83R1X7Uw3FDOXU3N/3DXbnpnNWPTBec80Wo5Bg9DG69vNmkWNXESvJqcKZach7kMKEo/Rp0WOM5W5dRcwagpWYWHThfvJNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734465; c=relaxed/simple;
	bh=ZylI2W75z46xBXvWS37ASBh9lNvpSyO4s0vJ61E23NM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQPf7Qf5f210sWfCKDi5yvOV8SoUuUAY65wu2X2V/wNB1wJaEZqzppB/VxWo75keHMbpe7e8XI31F7zAjsrM5rFtkvwnoBsLZ+JUoz+U4VvF/pCJjHwoNju+4OxXj/AJKCGhr/mDEU5I61UF8jDmbXirz1xphJ6+rTNFy6xa9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwSkP5KnKzwRtf;
	Fri,  7 Jun 2024 12:23:41 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id A2F06180AA6;
	Fri,  7 Jun 2024 12:27:40 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:24 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 078/110] fsck.ubifs: Handle orphan nodes
Date: Fri, 7 Jun 2024 12:25:43 +0800
Message-ID: <20240607042615.2069840-79-chengzhihao1@huawei.com>
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

This is the 3/18 step of fsck. Handle orphan nodes, update TNC & LPT.
There could be following steps and possible errors:
 Step 1. scan orphan LEB, get all orphan nodes
  a. corrupted scanning data in orphan area: danger mode and normal mode
     with 'yes' answer will drop orphan LEB, other modes will exit.
 Step 2. parse orphan node, find the original inode for each inum
  a. corrupted node searched from TNC: skip node for danger mode and
     normal mode with 'yes' answer, other modes will exit.
  b. corrupted index node read from TNC: danger mode with rebuild_fs and
     normal mode with 'yes' answer will turn to rebuild filesystem, other
     modes will exit.
 Step 4. remove inode for each inum, update TNC & LPT
  a. corrupted index node read from TNC: danger mode with rebuild_fs and
     normal mode with 'yes' answer will turn to rebuild filesystem, other
     modes will exit.
  b. corrupted lpt: Set %FR_LPT_CORRUPTED for lpt status. Ignore the
     error.
  c. incorrect lpt: Set %FR_LPT_INCORRECT for lpt status. Ignore the
     error.
  d. If lpt status is not empty, skip updating lpt.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/fsck.ubifs.c |  2 ++
 ubifs-utils/fsck.ubifs/fsck.ubifs.h |  2 +-
 ubifs-utils/fsck.ubifs/load_fs.c    | 19 +++++++++++++++++
 ubifs-utils/fsck.ubifs/problem.c    | 20 ++++++++++++++++--
 ubifs-utils/libubifs/orphan.c       | 42 ++++++++++++++++++++++++++++++++++---
 ubifs-utils/libubifs/ubifs.h        |  1 +
 6 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.c b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
index 3e7e7093..4d5296d7 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.c
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
@@ -328,6 +328,7 @@ static bool fsck_can_ignore_failure(const struct ubifs_info *c,
 static const unsigned int reason_mapping_table[] = {
 	BUD_CORRUPTED,		/* FR_H_BUD_CORRUPTED */
 	TNC_DATA_CORRUPTED,	/* FR_H_TNC_DATA_CORRUPTED */
+	ORPHAN_CORRUPTED,	/* FR_H_ORPHAN_CORRUPTED */
 };
 
 static bool fsck_handle_failure(const struct ubifs_info *c, unsigned int reason,
@@ -431,6 +432,7 @@ int main(int argc, char *argv[])
 	 * Init: Read superblock
 	 * Step 1: Read master & init lpt
 	 * Step 2: Replay journal
+	 * Step 3: Handle orphan nodes
 	 */
 	err = ubifs_load_filesystem(c);
 	if (err) {
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index 917f124e..b98c3f7d 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -38,7 +38,7 @@ enum { NORMAL_MODE = 0, SAFE_MODE, DANGER_MODE0,
 
 /* Types of inconsistent problems */
 enum { SB_CORRUPTED = 0, MST_CORRUPTED, LOG_CORRUPTED, BUD_CORRUPTED,
-       TNC_CORRUPTED, TNC_DATA_CORRUPTED };
+       TNC_CORRUPTED, TNC_DATA_CORRUPTED, ORPHAN_CORRUPTED };
 
 struct scanned_file;
 
diff --git a/ubifs-utils/fsck.ubifs/load_fs.c b/ubifs-utils/fsck.ubifs/load_fs.c
index f45c4117..f376383c 100644
--- a/ubifs-utils/fsck.ubifs/load_fs.c
+++ b/ubifs-utils/fsck.ubifs/load_fs.c
@@ -183,10 +183,28 @@ int ubifs_load_filesystem(struct ubifs_info *c)
 	/* Calculate 'min_idx_lebs' after journal replay */
 	c->bi.min_idx_lebs = ubifs_calc_min_idx_lebs(c);
 
+	log_out(c, "Handle orphan nodes");
+	err = ubifs_mount_orphans(c, c->need_recovery, c->ro_mount);
+	if (err) {
+		unsigned int reason = get_failure_reason_callback(c);
+
+		clear_failure_reason_callback(c);
+		if (reason & FR_TNC_CORRUPTED) {
+			if (fix_problem(c, TNC_CORRUPTED, NULL))
+				FSCK(c)->try_rebuild = true;
+		} else {
+			ubifs_assert(c, reason == 0);
+			exit_code |= FSCK_ERROR;
+		}
+		goto out_orphans;
+	}
+
 	c->mounting = 0;
 
 	return 0;
 
+out_orphans:
+	free_orphans(c);
 out_journal:
 	destroy_journal(c);
 out_lpt:
@@ -214,6 +232,7 @@ void ubifs_destroy_filesystem(struct ubifs_info *c)
 {
 	destroy_journal(c);
 	free_wbufs(c);
+	free_orphans(c);
 	ubifs_lpt_free(c, 0);
 
 	c->max_sqnum = 0;
diff --git a/ubifs-utils/fsck.ubifs/problem.c b/ubifs-utils/fsck.ubifs/problem.c
index 9df2c2ae..9c8730a5 100644
--- a/ubifs-utils/fsck.ubifs/problem.c
+++ b/ubifs-utils/fsck.ubifs/problem.c
@@ -41,6 +41,7 @@ static const struct fsck_problem problem_table[] = {
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Corrupted bud LEB"},	// BUD_CORRUPTED
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA | PROBLEM_NEED_REBUILD, "Corrupted index node"},	// TNC_CORRUPTED
 	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Corrupted data searched from TNC"},	// TNC_DATA_CORRUPTED
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA, "Corrupted orphan LEB"},	// ORPHAN_CORRUPTED
 };
 
 static const char *get_question(const struct fsck_problem *problem,
@@ -54,6 +55,8 @@ static const char *get_question(const struct fsck_problem *problem,
 		return "Drop bud?";
 	case TNC_DATA_CORRUPTED:
 		return "Drop it?";
+	case ORPHAN_CORRUPTED:
+		return "Drop orphans on the LEB?";
 	}
 
 	return "Fix it?";
@@ -63,13 +66,26 @@ static void print_problem(const struct ubifs_info *c,
 			  const struct fsck_problem *problem, int problem_type,
 			  const void *priv)
 {
-	if (problem_type == BUD_CORRUPTED) {
+	switch (problem_type) {
+	case BUD_CORRUPTED:
+	{
 		const struct ubifs_bud *bud = (const struct ubifs_bud *)priv;
 
 		log_out(c, "problem: %s %d:%d %s", problem->desc, bud->lnum,
 			bud->start, dbg_jhead(bud->jhead));
-	} else
+		break;
+	}
+	case ORPHAN_CORRUPTED:
+	{
+		const int *lnum = (const int *)priv;
+
+		log_out(c, "problem: %s %d", problem->desc, *lnum);
+		break;
+	}
+	default:
 		log_out(c, "problem: %s", problem->desc);
+		break;
+	}
 }
 
 static void fatal_error(const struct ubifs_info *c,
diff --git a/ubifs-utils/libubifs/orphan.c b/ubifs-utils/libubifs/orphan.c
index 26668cbd..baa4db78 100644
--- a/ubifs-utils/libubifs/orphan.c
+++ b/ubifs-utils/libubifs/orphan.c
@@ -423,6 +423,7 @@ static int do_kill_orphans(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 			ubifs_dump_node(c, snod->node,
 					c->leb_size - snod->offs);
 			err = -EINVAL;
+			set_failure_reason_callback(c, FR_DATA_CORRUPTED);
 			goto out_free;
 		}
 
@@ -452,6 +453,7 @@ static int do_kill_orphans(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 				ubifs_dump_node(c, snod->node,
 						c->leb_size - snod->offs);
 				err = -EINVAL;
+				set_failure_reason_callback(c, FR_DATA_CORRUPTED);
 				goto out_free;
 			}
 			dbg_rcvry("out of date LEB %d", sleb->lnum);
@@ -471,8 +473,19 @@ static int do_kill_orphans(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 
 			ino_key_init(c, &key, inum);
 			err = ubifs_tnc_lookup(c, &key, ino);
-			if (err && err != -ENOENT)
+			if (err && err != -ENOENT) {
+				unsigned int reason;
+
+				reason = get_failure_reason_callback(c);
+				if (reason & FR_DATA_CORRUPTED) {
+					test_and_clear_failure_reason_callback(c, FR_DATA_CORRUPTED);
+					if (handle_failure_callback(c, FR_H_TNC_DATA_CORRUPTED, NULL)) {
+						/* Leave the inode to be deleted by subsequent steps */
+						continue;
+					}
+				}
 				goto out_free;
+			}
 
 			/*
 			 * Check whether an inode can really get deleted.
@@ -483,8 +496,11 @@ static int do_kill_orphans(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 					  (unsigned long)inum);
 
 				err = ubifs_tnc_remove_ino(c, inum);
-				if (err)
+				if (err) {
+					if (c->program_type == FSCK_PROGRAM_TYPE)
+						goto out_free;
 					goto out_ro;
+				}
 			}
 		}
 
@@ -553,13 +569,33 @@ static int kill_orphans(struct ubifs_info *c)
 							 c->sbuf, -1);
 			}
 			if (IS_ERR(sleb)) {
+				if (test_and_clear_failure_reason_callback(c, FR_DATA_CORRUPTED) &&
+				    handle_failure_callback(c, FR_H_ORPHAN_CORRUPTED, &lnum)) {
+					/* Skip the orphan LEB. */
+					continue;
+				}
 				err = PTR_ERR(sleb);
 				break;
 			}
 		}
 		err = do_kill_orphans(c, sleb, &last_cmt_no, &outofdate,
 				      &last_flagged);
-		if (err || outofdate) {
+		if (err) {
+			unsigned int reason = get_failure_reason_callback(c);
+
+			if (reason & FR_DATA_CORRUPTED) {
+				test_and_clear_failure_reason_callback(c, FR_DATA_CORRUPTED);
+				if (handle_failure_callback(c, FR_H_ORPHAN_CORRUPTED, &lnum)) {
+					err = 0;
+					/* Skip the orphan LEB. */
+					ubifs_scan_destroy(sleb);
+					continue;
+				}
+			}
+			ubifs_scan_destroy(sleb);
+			break;
+		}
+		if (outofdate) {
 			ubifs_scan_destroy(sleb);
 			break;
 		}
diff --git a/ubifs-utils/libubifs/ubifs.h b/ubifs-utils/libubifs/ubifs.h
index ae812ff8..8a506a8b 100644
--- a/ubifs-utils/libubifs/ubifs.h
+++ b/ubifs-utils/libubifs/ubifs.h
@@ -1546,6 +1546,7 @@ enum {
 enum {
 	FR_H_BUD_CORRUPTED = 0,		/* Bud LEB is corrupted */
 	FR_H_TNC_DATA_CORRUPTED,	/* Data searched from TNC is corrupted */
+	FR_H_ORPHAN_CORRUPTED,		/* Orphan LEB is corrupted */
 };
 /* Callback functions for failure(which can be handled by fsck) happens. */
 static inline void set_failure_reason_callback(const struct ubifs_info *c,
-- 
2.13.6


