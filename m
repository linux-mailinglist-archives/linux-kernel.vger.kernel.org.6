Return-Path: <linux-kernel+bounces-205355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 292468FFABF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436161C23D60
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9391649CC;
	Fri,  7 Jun 2024 04:27:48 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B5815EFD0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734465; cv=none; b=g1WM3EepVzHiUfPmmYEXVsfiBvxEIJhZNaYhIKS/Zer8eKD47/Dva15vwe+QOCZ6m6AMkqalF2Frkud8jsqx8HstVZ4QVjW6qHPxE4DdssD8M3u+0eGbY0KPcateexI6Dp9tikA0AWESZ6Ts9yGEwbMymvdtpXq4G8EsoHlQhLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734465; c=relaxed/simple;
	bh=8OleJrDcBeXqaNIZMLEb8CLuj7ZSFdqXDWOBspZSHtw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cAm9ezmlSgO4otM0qj7DBEiG/T8eQdc834r3kMvM2gwledOnCcQ6x/5jHw+Ig7d4iQtY15atLNNoRL5ZxAMrVYXZYTmm9NqHvTLsSAZZAIJlOxVVaZwSXlpcrcnPwl8IkoaMb/yAroNDMO1o0CUnHBYRl9QG3Axey422mbJTGFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSnM3vqzzdZh7;
	Fri,  7 Jun 2024 12:26:15 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 716FE180085;
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
Subject: [RFC PATCH mtd-utils 075/110] fsck.ubifs: rebuild_fs: Write master node
Date: Fri, 7 Jun 2024 12:25:40 +0800
Message-ID: <20240607042615.2069840-76-chengzhihao1@huawei.com>
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

This is the 12/12 step of rebuilding. Since all meta areas are ready,
master node can be updated. After this step, a consistent UBIFS image
can be mounted, and it should pass all tests from chk_fs, chk_general,
chk_index, chk_lprops and chk_orphans.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/rebuild_fs.c | 78 +++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/ubifs-utils/fsck.ubifs/rebuild_fs.c b/ubifs-utils/fsck.ubifs/rebuild_fs.c
index 9ea4c224..382687b3 100644
--- a/ubifs-utils/fsck.ubifs/rebuild_fs.c
+++ b/ubifs-utils/fsck.ubifs/rebuild_fs.c
@@ -1126,6 +1126,7 @@ static int record_file_used_lebs(struct ubifs_info *c,
 		 file->ino.is_xattr ? "xattr" :
 		 ubifs_get_type_name(ubifs_get_dent_type(file->ino.mode)),
 		 c->dev_name);
+	c->highest_inum = max_t(ino_t, c->highest_inum, file->inum);
 
 	err = parse_node_info(c, &file->ino.header, &file->ino.key,
 			      NULL, 0, idx_list, idx_cnt);
@@ -1345,6 +1346,75 @@ static int clean_log(struct ubifs_info *c)
 }
 
 /**
+ * write_master - write master nodes.
+ * @c: UBIFS file-system description object
+ *
+ * This function updates meta information into master node and writes master
+ * node into master area.
+ */
+static int write_master(struct ubifs_info *c)
+{
+	int err, lnum;
+	struct ubifs_mst_node *mst;
+
+	mst = kzalloc(c->mst_node_alsz, GFP_KERNEL);
+	if (!mst)
+		return -ENOMEM;
+
+	mst->ch.node_type = UBIFS_MST_NODE;
+	mst->log_lnum     = cpu_to_le32(UBIFS_LOG_LNUM);
+	mst->highest_inum = cpu_to_le64(c->highest_inum);
+	mst->cmt_no       = 0;
+	mst->root_lnum    = cpu_to_le32(c->zroot.lnum);
+	mst->root_offs    = cpu_to_le32(c->zroot.offs);
+	mst->root_len     = cpu_to_le32(c->zroot.len);
+	mst->gc_lnum      = cpu_to_le32(c->gc_lnum);
+	mst->ihead_lnum   = cpu_to_le32(c->ihead_lnum);
+	mst->ihead_offs   = cpu_to_le32(c->ihead_offs);
+	mst->index_size   = cpu_to_le64(c->calc_idx_sz);
+	mst->lpt_lnum     = cpu_to_le32(c->lpt_lnum);
+	mst->lpt_offs     = cpu_to_le32(c->lpt_offs);
+	mst->nhead_lnum   = cpu_to_le32(c->nhead_lnum);
+	mst->nhead_offs   = cpu_to_le32(c->nhead_offs);
+	mst->ltab_lnum    = cpu_to_le32(c->ltab_lnum);
+	mst->ltab_offs    = cpu_to_le32(c->ltab_offs);
+	mst->lsave_lnum   = cpu_to_le32(c->lsave_lnum);
+	mst->lsave_offs   = cpu_to_le32(c->lsave_offs);
+	mst->lscan_lnum   = cpu_to_le32(c->main_first);
+	mst->empty_lebs   = cpu_to_le32(c->lst.empty_lebs);
+	mst->idx_lebs     = cpu_to_le32(c->lst.idx_lebs);
+	mst->leb_cnt      = cpu_to_le32(c->leb_cnt);
+	mst->total_free   = cpu_to_le64(c->lst.total_free);
+	mst->total_dirty  = cpu_to_le64(c->lst.total_dirty);
+	mst->total_used   = cpu_to_le64(c->lst.total_used);
+	mst->total_dead   = cpu_to_le64(c->lst.total_dead);
+	mst->total_dark   = cpu_to_le64(c->lst.total_dark);
+	mst->flags	  |= cpu_to_le32(UBIFS_MST_NO_ORPHS);
+
+	lnum = UBIFS_MST_LNUM;
+	err = ubifs_leb_unmap(c, lnum);
+	if (err)
+		goto out;
+	err = ubifs_write_node_hmac(c, mst, UBIFS_MST_NODE_SZ, lnum, 0,
+				    offsetof(struct ubifs_mst_node, hmac));
+	if (err)
+		goto out;
+	lnum++;
+	err = ubifs_leb_unmap(c, lnum);
+	if (err)
+		goto out;
+	err = ubifs_write_node_hmac(c, mst, UBIFS_MST_NODE_SZ, lnum, 0,
+				    offsetof(struct ubifs_mst_node, hmac));
+	if (err)
+		goto out;
+
+out:
+	kfree(mst);
+
+	return err;
+}
+
+/**
  * ubifs_rebuild_filesystem - Rebuild filesystem.
  * @c: UBIFS file-system description object
  *
@@ -1429,6 +1499,14 @@ int ubifs_rebuild_filesystem(struct ubifs_info *c)
 		goto out;
 	}
 	err = ubifs_clear_orphans(c);
+	if (err) {
+		exit_code |= FSCK_ERROR;
+		goto out;
+	}
+
+	/* Step 12. Write master node. */
+	log_out(c, "Write master");
+	err = write_master(c);
 	if (err)
 		exit_code |= FSCK_ERROR;
 
-- 
2.13.6


