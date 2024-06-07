Return-Path: <linux-kernel+bounces-205357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 498438FFAC2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADFB1F22E21
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230411667E7;
	Fri,  7 Jun 2024 04:27:49 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFBA15EFDE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734466; cv=none; b=toluA5bZcoGWC4EzfcP5QcUgmar8Bh2ycQYgucV6r8485sGNl2K0w+VXNE53FdjP7/2yRtBz6gb41Mf529zGDgyenm163fVjG6AsqMr1h6zF9OdXSiRj37rFpECTEt9JOwNhO+jnacDdvomKh98MUl1BDfiBbtRQxezYBgvkwVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734466; c=relaxed/simple;
	bh=eWhcPpzIWjRYEJ/W7k3bB5TYm+H+uSAHmu25nRQKclw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t96VPwRTbzdLDclhcJwwNsVplmizBeIufE2YBpzv6vS8QrUZpaY1ircTsyghsN00cnEaCy2+WB7QK2/OE12j7im7XgdCkESs/gfR8rKpzzwo3F80ggui4mmHm75+Qm7LESCjVZxz1EuRYQjLVzQnrHhmytsf6sGmbpqJ6HncGzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwSkP4MKNzwRq8;
	Fri,  7 Jun 2024 12:23:41 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 81D11180AA6;
	Fri,  7 Jun 2024 12:27:40 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:22 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 076/110] fsck.ubifs: Read master node & init lpt
Date: Fri, 7 Jun 2024 12:25:41 +0800
Message-ID: <20240607042615.2069840-77-chengzhihao1@huawei.com>
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

This is the 1/18 step of fsck. Read and check master node, init lpt.
There could be following errors:
 1. corrupted scanning data in master area or invalid master node:
    danger mode with rebuild_fs and normal mode with 'yes' answer will
    turn to rebuild filesystem, other modes will exit.
 2. incorrect space statistics in master node: Set %FR_LPT_INCORRECT for
    for lpt status. Ignore the error.
 3. corrupted lpt: Set %FR_LPT_CORRUPTED for lpt status. Ignore the error.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/fsck.ubifs.c |  5 ++-
 ubifs-utils/fsck.ubifs/fsck.ubifs.h |  2 +-
 ubifs-utils/fsck.ubifs/load_fs.c    | 78 +++++++++++++++++++++++++++++++++++++
 ubifs-utils/fsck.ubifs/problem.c    |  1 +
 ubifs-utils/libubifs/lpt.c          | 18 +++++++--
 ubifs-utils/libubifs/master.c       |  7 +++-
 6 files changed, 104 insertions(+), 7 deletions(-)

diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.c b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
index 683d7c27..34641c89 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.c
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
@@ -423,7 +423,10 @@ int main(int argc, char *argv[])
 		goto out_destroy_fsck;
 	}
 
-	/* Init: Read superblock */
+	/*
+	 * Init: Read superblock
+	 * Step 1: Read master & init lpt
+	 */
 	err = ubifs_load_filesystem(c);
 	if (err) {
 		if (FSCK(c)->try_rebuild)
diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.h b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
index 1d97aed3..cbe432c4 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.h
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.h
@@ -37,7 +37,7 @@ enum { NORMAL_MODE = 0, SAFE_MODE, DANGER_MODE0,
        DANGER_MODE1, REBUILD_MODE, CHECK_MODE };
 
 /* Types of inconsistent problems */
-enum { SB_CORRUPTED = 0 };
+enum { SB_CORRUPTED = 0, MST_CORRUPTED };
 
 struct scanned_file;
 
diff --git a/ubifs-utils/fsck.ubifs/load_fs.c b/ubifs-utils/fsck.ubifs/load_fs.c
index 4a06b4c2..036e307c 100644
--- a/ubifs-utils/fsck.ubifs/load_fs.c
+++ b/ubifs-utils/fsck.ubifs/load_fs.c
@@ -99,10 +99,81 @@ int ubifs_load_filesystem(struct ubifs_info *c)
 		goto out_mounting;
 	}
 
+	log_out(c, "Read master & init lpt");
+	err = ubifs_read_master(c);
+	if (err) {
+		if (test_and_clear_failure_reason_callback(c, FR_DATA_CORRUPTED)) {
+			if (fix_problem(c, MST_CORRUPTED))
+				FSCK(c)->try_rebuild = true;
+		} else
+			exit_code |= FSCK_ERROR;
+		goto out_master;
+	}
+
+	init_constants_master(c);
+
+	if ((c->mst_node->flags & cpu_to_le32(UBIFS_MST_DIRTY)) != 0) {
+		ubifs_msg(c, "recovery needed");
+		c->need_recovery = 1;
+	}
+
+	if (c->need_recovery && !c->ro_mount) {
+		err = ubifs_recover_inl_heads(c, c->sbuf);
+		if (err) {
+			exit_code |= FSCK_ERROR;
+			goto out_master;
+		}
+	}
+
+	err = ubifs_lpt_init(c, 1, !c->ro_mount);
+	if (err) {
+		exit_code |= FSCK_ERROR;
+		goto out_master;
+	}
+
+	if (!c->ro_mount && c->space_fixup) {
+		err = ubifs_fixup_free_space(c);
+		if (err) {
+			exit_code |= FSCK_ERROR;
+			goto out_lpt;
+		}
+	}
+
+	if (!c->ro_mount && !c->need_recovery) {
+		/*
+		 * Set the "dirty" flag so that if we reboot uncleanly we
+		 * will notice this immediately on the next mount.
+		 */
+		c->mst_node->flags |= cpu_to_le32(UBIFS_MST_DIRTY);
+		err = ubifs_write_master(c);
+		if (err) {
+			exit_code |= FSCK_ERROR;
+			goto out_lpt;
+		}
+	}
+
+	if (!c->ro_mount && c->superblock_need_write) {
+		err = ubifs_write_sb_node(c, c->sup_node);
+		if (err) {
+			exit_code |= FSCK_ERROR;
+			goto out_lpt;
+		}
+		c->superblock_need_write = 0;
+	}
+
 	c->mounting = 0;
 
 	return 0;
 
+out_lpt:
+	ubifs_lpt_free(c, 0);
+out_master:
+	c->max_sqnum = 0;
+	c->highest_inum = 0;
+	c->calc_idx_sz = 0;
+	kfree(c->mst_node);
+	kfree(c->rcvrd_mst_node);
+	free_wbufs(c);
 out_mounting:
 	c->mounting = 0;
 out_free:
@@ -118,8 +189,15 @@ out_free:
 void ubifs_destroy_filesystem(struct ubifs_info *c)
 {
 	free_wbufs(c);
+	ubifs_lpt_free(c, 0);
+
+	c->max_sqnum = 0;
+	c->highest_inum = 0;
+	c->calc_idx_sz = 0;
 
 	kfree(c->cbuf);
+	kfree(c->rcvrd_mst_node);
+	kfree(c->mst_node);
 	kfree(c->ileb_buf);
 	kfree(c->sbuf);
 	kfree(c->bottom_up_buf);
diff --git a/ubifs-utils/fsck.ubifs/problem.c b/ubifs-utils/fsck.ubifs/problem.c
index acb9e45e..1af66632 100644
--- a/ubifs-utils/fsck.ubifs/problem.c
+++ b/ubifs-utils/fsck.ubifs/problem.c
@@ -36,6 +36,7 @@ struct fsck_problem {
 
 static const struct fsck_problem problem_table[] = {
 	{0, "Corrupted superblock"},	// SB_CORRUPTED
+	{PROBLEM_FIXABLE | PROBLEM_MUST_FIX | PROBLEM_DROP_DATA | PROBLEM_NEED_REBUILD, "Corrupted master node"},	// MST_CORRUPTED
 };
 
 static void print_problem(const struct ubifs_info *c,
diff --git a/ubifs-utils/libubifs/lpt.c b/ubifs-utils/libubifs/lpt.c
index c0df7c7d..b07f1f77 100644
--- a/ubifs-utils/libubifs/lpt.c
+++ b/ubifs-utils/libubifs/lpt.c
@@ -1883,8 +1883,13 @@ static int lpt_init_rd(struct ubifs_info *c)
 	c->dirty_idx.max_cnt = LPT_HEAP_SZ;
 
 	err = read_ltab(c);
-	if (err)
-		return err;
+	if (err) {
+		if (test_and_clear_failure_reason_callback(c, FR_LPT_CORRUPTED) &&
+		    can_ignore_failure_callback(c, FR_LPT_CORRUPTED))
+			err = 0;
+		else
+			return err;
+	}
 
 	err = lpt_check_hash(c);
 	if (err)
@@ -1938,8 +1943,13 @@ static int lpt_init_wr(struct ubifs_info *c)
 		if (!c->lsave)
 			return -ENOMEM;
 		err = read_lsave(c);
-		if (err)
-			return err;
+		if (err) {
+			if (test_and_clear_failure_reason_callback(c, FR_LPT_CORRUPTED) &&
+			    can_ignore_failure_callback(c, FR_LPT_CORRUPTED))
+				err = 0;
+			else
+				return err;
+		}
 	}
 
 	for (i = 0; i < c->lpt_lebs; i++)
diff --git a/ubifs-utils/libubifs/master.c b/ubifs-utils/libubifs/master.c
index 61ff4cec..54d2a789 100644
--- a/ubifs-utils/libubifs/master.c
+++ b/ubifs-utils/libubifs/master.c
@@ -323,7 +323,12 @@ out:
 	set_failure_reason_callback(c, reason);
 	ubifs_err(c, "bad master node at offset %d error %d", c->mst_offs, err);
 	ubifs_dump_node(c, c->mst_node, c->mst_node_alsz);
-	return -EINVAL;
+	err = -EINVAL;
+	if (can_ignore_failure_callback(c, reason)) {
+		clear_failure_reason_callback(c);
+		err = 0;
+	}
+	return err;
 }
 
 /**
-- 
2.13.6


