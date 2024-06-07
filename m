Return-Path: <linux-kernel+bounces-205315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0F68FFA93
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054B71F25EF4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C2C155CAD;
	Fri,  7 Jun 2024 04:27:17 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2567639FD6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734435; cv=none; b=nglgCSqusH1Q39NYI8JtfhK7j86LoAmRH0W+Oo0eX7j/TfnJRrvgg9DeVAHMYSez0F7A/uV1SdNExFq4LSXb3YfxlKkwH88BBoiXBe7QRvp3uNWjbL3O7lvBivKGc2maEe3QmENe82UXZamXX6IzX5B2UrFsjJe2+fNFEYfGF2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734435; c=relaxed/simple;
	bh=EexZOudKmjxHPrchF1JKBAK5spR+m1Xo8j7Tmivy8ho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6gy0EPexKMAQYu6aqW7SaOS9t9UrbajEqf/zeoHI56oNdE8SiWo2oAjyVkvkTRMmIM8A0+RFGTfgLuwkSIOq7zpp737u21PmoJLw6PH2nrHqm/Zm+t5CW0fMFFxO8LIh35vBleFRWnAW84aFpCfUbnriO03TGk3saj8l4g3ta4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSj74rZLzmYTP;
	Fri,  7 Jun 2024 12:22:35 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 7CCB018007E;
	Fri,  7 Jun 2024 12:27:11 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:00 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 045/110] ubifs-utils: Adapt budget.c in libubifs
Date: Fri, 7 Jun 2024 12:25:10 +0800
Message-ID: <20240607042615.2069840-46-chengzhihao1@huawei.com>
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

Adapt budget.c in libubifs, compared with linux kernel implementations:
 1. Remove writeback related functions, there are no dirty pages/inodes
    for UBIFS in userspace process.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/libubifs/budget.c | 133 +++---------------------------------------
 1 file changed, 7 insertions(+), 126 deletions(-)

diff --git a/ubifs-utils/libubifs/budget.c b/ubifs-utils/libubifs/budget.c
index d76eb7b3..5550c9af 100644
--- a/ubifs-utils/libubifs/budget.c
+++ b/ubifs-utils/libubifs/budget.c
@@ -18,9 +18,11 @@
  * approximations are used.
  */
 
+#include "bitops.h"
 #include "ubifs.h"
-#include <linux/writeback.h>
-#include <linux/math64.h>
+#include "defs.h"
+#include "debug.h"
+#include "misc.h"
 
 /*
  * When pessimistic budget calculations say that there is no enough space,
@@ -30,31 +32,6 @@
  */
 #define MAX_MKSPC_RETRIES 3
 
-/*
- * The below constant defines amount of dirty pages which should be written
- * back at when trying to shrink the liability.
- */
-#define NR_TO_WRITE 16
-
-/**
- * shrink_liability - write-back some dirty pages/inodes.
- * @c: UBIFS file-system description object
- * @nr_to_write: how many dirty pages to write-back
- *
- * This function shrinks UBIFS liability by means of writing back some amount
- * of dirty inodes and their pages.
- *
- * Note, this function synchronizes even VFS inodes which are locked
- * (@i_mutex) by the caller of the budgeting function, because write-back does
- * not touch @i_mutex.
- */
-static void shrink_liability(struct ubifs_info *c, int nr_to_write)
-{
-	down_read(&c->vfs_sb->s_umount);
-	writeback_inodes_sb_nr(c->vfs_sb, nr_to_write, WB_REASON_FS_FREE_SPACE);
-	up_read(&c->vfs_sb->s_umount);
-}
-
 /**
  * run_gc - run garbage collector.
  * @c: UBIFS file-system description object
@@ -80,23 +57,6 @@ static int run_gc(struct ubifs_info *c)
 }
 
 /**
- * get_liability - calculate current liability.
- * @c: UBIFS file-system description object
- *
- * This function calculates and returns current UBIFS liability, i.e. the
- * amount of bytes UBIFS has "promised" to write to the media.
- */
-static long long get_liability(struct ubifs_info *c)
-{
-	long long liab;
-
-	spin_lock(&c->space_lock);
-	liab = c->bi.idx_growth + c->bi.data_growth + c->bi.dd_growth;
-	spin_unlock(&c->space_lock);
-	return liab;
-}
-
-/**
  * make_free_space - make more free space on the file-system.
  * @c: UBIFS file-system description object
  *
@@ -117,24 +77,8 @@ static long long get_liability(struct ubifs_info *c)
 static int make_free_space(struct ubifs_info *c)
 {
 	int err, retries = 0;
-	long long liab1, liab2;
 
 	do {
-		liab1 = get_liability(c);
-		/*
-		 * We probably have some dirty pages or inodes (liability), try
-		 * to write them back.
-		 */
-		dbg_budg("liability %lld, run write-back", liab1);
-		shrink_liability(c, NR_TO_WRITE);
-
-		liab2 = get_liability(c);
-		if (liab2 < liab1)
-			return -EAGAIN;
-
-		dbg_budg("new liability %lld (not shrunk)", liab2);
-
-		/* Liability did not shrink again, try GC */
 		dbg_budg("Run GC");
 		err = run_gc(c);
 		if (!err)
@@ -254,12 +198,10 @@ long long ubifs_calc_available(const struct ubifs_info *c, int min_idx_lebs)
  * This function checks whether current user is allowed to use reserved pool.
  * Returns %1  current user is allowed to use reserved pool and %0 otherwise.
  */
-static int can_use_rp(struct ubifs_info *c)
+static int can_use_rp(__unused struct ubifs_info *c)
 {
-	if (uid_eq(current_fsuid(), c->rp_uid) || capable(CAP_SYS_RESOURCE) ||
-	    (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)))
-		return 1;
-	return 0;
+	/* Fsck can always use reserved pool. */
+	return c->program_type == FSCK_PROGRAM_TYPE;
 }
 
 /**
@@ -556,49 +498,6 @@ void ubifs_release_budget(struct ubifs_info *c, struct ubifs_budget_req *req)
 }
 
 /**
- * ubifs_convert_page_budget - convert budget of a new page.
- * @c: UBIFS file-system description object
- *
- * This function converts budget which was allocated for a new page of data to
- * the budget of changing an existing page of data. The latter is smaller than
- * the former, so this function only does simple re-calculation and does not
- * involve any write-back.
- */
-void ubifs_convert_page_budget(struct ubifs_info *c)
-{
-	spin_lock(&c->space_lock);
-	/* Release the index growth reservation */
-	c->bi.idx_growth -= c->max_idx_node_sz << UBIFS_BLOCKS_PER_PAGE_SHIFT;
-	/* Release the data growth reservation */
-	c->bi.data_growth -= c->bi.page_budget;
-	/* Increase the dirty data growth reservation instead */
-	c->bi.dd_growth += c->bi.page_budget;
-	/* And re-calculate the indexing space reservation */
-	c->bi.min_idx_lebs = ubifs_calc_min_idx_lebs(c);
-	spin_unlock(&c->space_lock);
-}
-
-/**
- * ubifs_release_dirty_inode_budget - release dirty inode budget.
- * @c: UBIFS file-system description object
- * @ui: UBIFS inode to release the budget for
- *
- * This function releases budget corresponding to a dirty inode. It is usually
- * called when after the inode has been written to the media and marked as
- * clean. It also causes the "no space" flags to be cleared.
- */
-void ubifs_release_dirty_inode_budget(struct ubifs_info *c,
-				      struct ubifs_inode *ui)
-{
-	struct ubifs_budget_req req;
-
-	memset(&req, 0, sizeof(struct ubifs_budget_req));
-	/* The "no space" flags will be cleared because dd_growth is > 0 */
-	req.dd_growth = c->bi.inode_budget + ALIGN(ui->data_len, 8);
-	ubifs_release_budget(c, &req);
-}
-
-/**
  * ubifs_reported_space - calculate reported free space.
  * @c: the UBIFS file-system description object
  * @free: amount of free space
@@ -694,21 +593,3 @@ long long ubifs_get_free_space_nolock(struct ubifs_info *c)
 		free = 0;
 	return free;
 }
-
-/**
- * ubifs_get_free_space - return amount of free space.
- * @c: UBIFS file-system description object
- *
- * This function calculates and returns amount of free space to report to
- * user-space.
- */
-long long ubifs_get_free_space(struct ubifs_info *c)
-{
-	long long free;
-
-	spin_lock(&c->space_lock);
-	free = ubifs_get_free_space_nolock(c);
-	spin_unlock(&c->space_lock);
-
-	return free;
-}
-- 
2.13.6


