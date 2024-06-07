Return-Path: <linux-kernel+bounces-205361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BA98FFAC5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3982B2690E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC76215FA7E;
	Fri,  7 Jun 2024 04:27:50 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC09961FF6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734468; cv=none; b=Mg0RdLFi4VWZd4x+ZHGt2RzivDMWASKOn2jXsxAwuW1HjK677cSt/TTVtROdswHzC+0fCZEtWok/0Gced9nsRf0LTfI9skkpvtQg7HtqzhfnVBlNLoVdggnB/sxF4Hv19cWh+wD/mkASXhQZD7AsSa+8A2kCikQ09qi+jlqiTLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734468; c=relaxed/simple;
	bh=dF8ezjxrT0QcHwI/GBQO1w4zFWfcy18fGOKinTlEdoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dq3MstWJ6r6uiftsZJLS3LtxhPRIVOZOPX7q/HX9B+LbkzCj3Cvfe50R1uC72+EWkdhoNxNRj7RliCmnhByt7FAgq6H+NOaEJaa7718Afdjj++Vl3+91PNkPDP/HI6R3bAUbJJHnD9qqFZl+Vc5pbmv7v/E1Hk8EQsOIbvD4oJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VwSl93ZSXzPpnL;
	Fri,  7 Jun 2024 12:24:21 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id C49D2180AA6;
	Fri,  7 Jun 2024 12:27:40 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:25 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 080/110] fsck.ubifs: Recover isize
Date: Fri, 7 Jun 2024 12:25:45 +0800
Message-ID: <20240607042615.2069840-81-chengzhihao1@huawei.com>
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

This is the 5/18 step of fsck. Recover isize. There could be following
steps and possible errors:
 Step 1. Traverse size tree, lookup corresponding inode from TNC
  a. corrupted node searched from TNC: skip node for danger mode and
     normal mode with 'yes' answer, other modes will exit.
  b. corrupted index node read from TNC: danger mode with rebuild_fs and
     normal mode with 'yes' answer will turn to rebuild filesystem, other
     modes will exit.
 Step 2. update isize for inode. Keep <inum, isize> in size tree for check
 mode, update inode node in place for other modes.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/fsck.ubifs.c |  1 +
 ubifs-utils/fsck.ubifs/load_fs.c    | 79 +++++++++++++++++++++----------------
 ubifs-utils/libubifs/recovery.c     | 34 +++++++++++++---
 3 files changed, 75 insertions(+), 39 deletions(-)

diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.c b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
index 9d69a4fd..77013851 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.c
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
@@ -434,6 +434,7 @@ int main(int argc, char *argv[])
 	 * Step 2: Replay journal
 	 * Step 3: Handle orphan nodes
 	 * Step 4: Consolidate log
+	 * Step 5: Recover isize
 	 */
 	err = ubifs_load_filesystem(c);
 	if (err) {
diff --git a/ubifs-utils/fsck.ubifs/load_fs.c b/ubifs-utils/fsck.ubifs/load_fs.c
index 42b1afaa..58540543 100644
--- a/ubifs-utils/fsck.ubifs/load_fs.c
+++ b/ubifs-utils/fsck.ubifs/load_fs.c
@@ -17,6 +17,33 @@
 #include "misc.h"
 #include "fsck.ubifs.h"
 
+enum { HAS_DATA_CORRUPTED = 1, HAS_TNC_CORRUPTED = 2 };
+
+static void handle_error(const struct ubifs_info *c, int reason_set)
+{
+	bool handled = false;
+	unsigned int reason = get_failure_reason_callback(c);
+
+	clear_failure_reason_callback(c);
+	if ((reason_set & HAS_DATA_CORRUPTED) && (reason & FR_DATA_CORRUPTED)) {
+		handled = true;
+		reason &= ~FR_DATA_CORRUPTED;
+		if (fix_problem(c, LOG_CORRUPTED, NULL))
+			FSCK(c)->try_rebuild = true;
+	}
+	if ((reason_set & HAS_TNC_CORRUPTED) && (reason & FR_TNC_CORRUPTED)) {
+		ubifs_assert(c, !handled);
+		handled = true;
+		reason &= ~FR_TNC_CORRUPTED;
+		if (fix_problem(c, TNC_CORRUPTED, NULL))
+			FSCK(c)->try_rebuild = true;
+	}
+
+	ubifs_assert(c, reason == 0);
+	if (!handled)
+		exit_code |= FSCK_ERROR;
+}
+
 int ubifs_load_filesystem(struct ubifs_info *c)
 {
 	int err;
@@ -164,19 +191,7 @@ int ubifs_load_filesystem(struct ubifs_info *c)
 	log_out(c, "Replay journal");
 	err = ubifs_replay_journal(c);
 	if (err) {
-		unsigned int reason = get_failure_reason_callback(c);
-
-		clear_failure_reason_callback(c);
-		if (reason & FR_DATA_CORRUPTED) {
-			if (fix_problem(c, LOG_CORRUPTED, NULL))
-				FSCK(c)->try_rebuild = true;
-		} else if (reason & FR_TNC_CORRUPTED) {
-			if (fix_problem(c, TNC_CORRUPTED, NULL))
-				FSCK(c)->try_rebuild = true;
-		} else {
-			ubifs_assert(c, reason == 0);
-			exit_code |= FSCK_ERROR;
-		}
+		handle_error(c, HAS_DATA_CORRUPTED | HAS_TNC_CORRUPTED);
 		goto out_journal;
 	}
 
@@ -186,16 +201,7 @@ int ubifs_load_filesystem(struct ubifs_info *c)
 	log_out(c, "Handle orphan nodes");
 	err = ubifs_mount_orphans(c, c->need_recovery, c->ro_mount);
 	if (err) {
-		unsigned int reason = get_failure_reason_callback(c);
-
-		clear_failure_reason_callback(c);
-		if (reason & FR_TNC_CORRUPTED) {
-			if (fix_problem(c, TNC_CORRUPTED, NULL))
-				FSCK(c)->try_rebuild = true;
-		} else {
-			ubifs_assert(c, reason == 0);
-			exit_code |= FSCK_ERROR;
-		}
+		handle_error(c, HAS_TNC_CORRUPTED);
 		goto out_orphans;
 	}
 
@@ -210,19 +216,26 @@ int ubifs_load_filesystem(struct ubifs_info *c)
 			log_out(c, "Consolidate log");
 			err = ubifs_consolidate_log(c);
 			if (err) {
-				unsigned int reason = get_failure_reason_callback(c);
-
-				clear_failure_reason_callback(c);
-				if (reason & FR_DATA_CORRUPTED) {
-					if (fix_problem(c, LOG_CORRUPTED, NULL))
-						FSCK(c)->try_rebuild = true;
-				} else {
-					ubifs_assert(c, reason == 0);
-					exit_code |= FSCK_ERROR;
-				}
+				handle_error(c, HAS_DATA_CORRUPTED);
+				goto out_orphans;
+			}
+		}
+
+		if (c->need_recovery) {
+			log_out(c, "Recover isize");
+			err = ubifs_recover_size(c, true);
+			if (err) {
+				handle_error(c, HAS_TNC_CORRUPTED);
 				goto out_orphans;
 			}
 		}
+	} else if (c->need_recovery) {
+		log_out(c, "Recover isize");
+		err = ubifs_recover_size(c, false);
+		if (err) {
+			handle_error(c, HAS_TNC_CORRUPTED);
+			goto out_orphans;
+		}
 	}
 
 	c->mounting = 0;
diff --git a/ubifs-utils/libubifs/recovery.c b/ubifs-utils/libubifs/recovery.c
index 9115b17a..a5133a0f 100644
--- a/ubifs-utils/libubifs/recovery.c
+++ b/ubifs-utils/libubifs/recovery.c
@@ -1272,8 +1272,18 @@ static int fix_size_in_place(struct ubifs_info *c, struct size_entry *e)
 	/* Locate the inode node LEB number and offset */
 	ino_key_init(c, &key, e->inum);
 	err = ubifs_tnc_locate(c, &key, ino, &lnum, &offs);
-	if (err)
+	if (err) {
+		unsigned int reason = get_failure_reason_callback(c);
+
+		if (reason & FR_DATA_CORRUPTED) {
+			test_and_clear_failure_reason_callback(c, FR_DATA_CORRUPTED);
+			if (handle_failure_callback(c, FR_H_TNC_DATA_CORRUPTED, NULL)) {
+				/* Leave the inode to be deleted by subsequent steps */
+				return 0;
+			}
+		}
 		goto out;
+	}
 	/*
 	 * If the size recorded on the inode node is greater than the size that
 	 * was calculated from nodes in the journal then don't change the inode.
@@ -1320,10 +1330,10 @@ out:
  */
 static int inode_fix_size(struct ubifs_info *c, __unused struct size_entry *e)
 {
-	ubifs_assert(c, 0);
-
-	// To be implemented
-	return -EINVAL;
+	/* Don't remove entry, keep it in the size tree. */
+	/* Remove this assertion after supporting authentication. */
+	ubifs_assert(c, c->ro_mount);
+	return 0;
 }
 
 /**
@@ -1353,8 +1363,19 @@ int ubifs_recover_size(struct ubifs_info *c, bool in_place)
 
 			ino_key_init(c, &key, e->inum);
 			err = ubifs_tnc_lookup(c, &key, c->sbuf);
-			if (err && err != -ENOENT)
+			if (err && err != -ENOENT) {
+				unsigned int reason;
+
+				reason = get_failure_reason_callback(c);
+				if (reason & FR_DATA_CORRUPTED) {
+					test_and_clear_failure_reason_callback(c, FR_DATA_CORRUPTED);
+					if (handle_failure_callback(c, FR_H_TNC_DATA_CORRUPTED, NULL)) {
+						/* Leave the inode to be deleted by subsequent steps */
+						goto delete_entry;
+					}
+				}
 				return err;
+			}
 			if (err == -ENOENT) {
 				/* Remove data nodes that have no inode */
 				dbg_rcvry("removing ino %lu",
@@ -1390,6 +1411,7 @@ int ubifs_recover_size(struct ubifs_info *c, bool in_place)
 			}
 		}
 
+delete_entry:
 		rb_erase(&e->rb, &c->size_tree);
 		kfree(e);
 	}
-- 
2.13.6


