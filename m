Return-Path: <linux-kernel+bounces-248544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432AB92DEB7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA3328113E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D4FE572;
	Thu, 11 Jul 2024 03:06:32 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1574DDA5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 03:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720667191; cv=none; b=aTaYeKxY5T7RKjDT8ipu3LjvLoKNYGnMtNThxcKKO7zrptGWJrCtrfZrbop5xojwSTMEAIGP+wHmPwzJvc/Sxxb1I8KW9ZsMVf9T/YB1XWjwdaYK1J+93tD4s+FA8OJBowCFn7NVufg7ppeFLi6liZwawEmDeCS1ELUXXvqsl2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720667191; c=relaxed/simple;
	bh=ys7dqiSsvOVoRvdqZF368aThiGUEj6VRkSTul1V1LmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqTeCUlIKoXOoxX7G6nkEZzEoYMK2jcy07SIELbO7dOkUWy26f7j50HFvKUZZASD5hM9QhMiHeR0/iN24HKLhRYHsvr1zUm79+qdF0hcOrQJKZpr5wbIknSFrw+bJJE1m2kACxedIxCY26eIbaobPOzpHfhfrD8xduXF9EXkYU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WKKJ626rNz1T67t;
	Thu, 11 Jul 2024 11:01:42 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id B88AF140390;
	Thu, 11 Jul 2024 11:06:25 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemd200001.china.huawei.com
 (7.185.36.224) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 11 Jul
 2024 11:06:25 +0800
From: Wang Zhaolong <wangzhaolong1@huawei.com>
To: <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<wangzhaolong1@huawei.com>, <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>
Subject: [RFC 1/1] ubifs: avoid deadlock when deleting an inode with xattr
Date: Thu, 11 Jul 2024 11:06:24 +0800
Message-ID: <20240711030624.266440-2-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20240711030624.266440-1-wangzhaolong1@huawei.com>
References: <20240711030624.266440-1-wangzhaolong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd200001.china.huawei.com (7.185.36.224)

When an inode with extended attributes is deleted, UBIFS needs to delete
the xattr inode as well. Currently, it uses ubifs_iget() to get the xattr
inode, which may block if the inode is under deletion. This can lead to
deadlocks if the inode deletion is waiting for the completion of the xattr
inode deletion.

To avoid this deadlock, this patch makes the following changes:

1. Replace ubifs_iget() with find_inode_nowait() when getting the xattr inode
   in ubifs_jnl_write_inode(). find_inode_nowait() will not block if the inode
   is under deletion.

2. If find_inode_nowait() finds the inode in cache, clear the nlink and pack
   the inode immediately to avoid losing inode info.

3. If find_inode_nowait() cannot find the inode in cache (returns NULL), read
   the inode directly from the media using ubifs_tnc_lookup(), clear the nlink,
   prepare the inode and pack it.

4. Add a new function ubifs_match_ino() to be used as the match callback for
   find_inode_nowait().

5. Replace ilookup() with find_inode_nowait() in ubifs_evict_xattr_inode() to
   avoid subsequent blocking during inode eviction.

With the above changes, the xattr inode deletion will not block waiting for
the host inode deletion, thus avoiding the deadlock.

Signed-off-by: Wang Zhaolong <wangzhaolong1@huawei.com>
---
 fs/ubifs/journal.c | 42 ++++++++++++++++++++++++++++++++++--------
 fs/ubifs/super.c   | 15 +++++++++++++++
 fs/ubifs/ubifs.h   |  1 +
 fs/ubifs/xattr.c   | 12 +++++++-----
 4 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 74aee92433d7..7aba91d31a15 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -1007,6 +1007,8 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
 		struct fscrypt_name nm = {0};
 		struct inode *xino;
 		struct ubifs_dent_node *xent, *pxent = NULL;
+		struct ubifs_ino_node *xino_node;
+		union ubifs_key xkey;
 
 		if (ui->xattr_cnt > ubifs_xattr_max_cnt(c)) {
 			err = -EPERM;
@@ -1029,22 +1031,46 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
 			fname_name(&nm) = xent->name;
 			fname_len(&nm) = le16_to_cpu(xent->nlen);
 
-			xino = ubifs_iget(c->vfs_sb, le64_to_cpu(xent->inum));
+			xino = find_inode_nowait(c->vfs_sb, le64_to_cpu(xent->inum),
+					ubifs_match_ino, NULL);
 			if (IS_ERR(xino)) {
 				err = PTR_ERR(xino);
 				ubifs_err(c, "dead directory entry '%s', error %d",
 					  xent->name, err);
-				ubifs_ro_mode(c, err);
 				kfree(pxent);
 				kfree(xent);
 				goto out_release;
+			} else if (xino) {
+				/* Found xattr inode in cache, pack it in order not to lose node info */
+				ubifs_assert(c, ubifs_inode(xino)->xattr);
+				clear_nlink(xino);
+				pack_inode(c, ino, xino, 0);
+				ino = (void *)ino + UBIFS_INO_NODE_SZ;
+				iput(xino);
+			} else {
+				/* Can't grab inode in cache, read it directly from the media */
+				xino_node = kmalloc(UBIFS_MAX_INO_NODE_SZ, GFP_NOFS);
+				if (!ino) {
+					err = -ENOMEM;
+					kfree(pxent);
+					kfree(xent);
+					goto out_release;
+				}
+				ino_key_init(c, &xkey, le64_to_cpu(xent->inum));
+				err = ubifs_tnc_lookup(c, &xkey, xino_node);
+				if (err) {
+					kfree(xino_node);
+					kfree(pxent);
+					kfree(xent);
+					goto out_release;
+				}
+
+				xino_node->nlink = cpu_to_le32(0);
+				ubifs_prep_grp_node(c, xino_node, UBIFS_INO_NODE_SZ, 0);
+				memcpy(ino, xino_node, UBIFS_INO_NODE_SZ);
+				ino = (void *)ino + UBIFS_INO_NODE_SZ;
+				kfree(xino_node);
 			}
-			ubifs_assert(c, ubifs_inode(xino)->xattr);
-
-			clear_nlink(xino);
-			pack_inode(c, ino, xino, 0);
-			ino = (void *)ino + UBIFS_INO_NODE_SZ;
-			iput(xino);
 
 			kfree(pxent);
 			pxent = xent;
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 291583005dd1..1de523fb6ee6 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -100,6 +100,21 @@ static int validate_inode(struct ubifs_info *c, const struct inode *inode)
 	return err;
 }
 
+int ubifs_match_ino(struct inode *inode, unsigned long ino, void *data)
+{
+	if (inode->i_ino != ino)
+		return 0;
+
+	inode = igrab(inode);
+	if (!inode)
+		return -1;
+
+	if (inode->i_state & I_NEW)
+		return -1;
+
+	return 1;
+}
+
 struct inode *ubifs_iget(struct super_block *sb, unsigned long inum)
 {
 	int err;
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 1f3ea879d93a..d75bf5878515 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -2077,6 +2077,7 @@ static inline int ubifs_init_security(struct inode *dentry,
 
 /* super.c */
 struct inode *ubifs_iget(struct super_block *sb, unsigned long inum);
+int ubifs_match_ino(struct inode *inode, unsigned long ino, void *data);
 
 /* recovery.c */
 int ubifs_recover_master_node(struct ubifs_info *c);
diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index 0847db521984..e3d001e69fdf 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -585,11 +585,13 @@ void ubifs_evict_xattr_inode(struct ubifs_info *c, ino_t xattr_inum)
 {
 	struct inode *inode;
 
-	inode = ilookup(c->vfs_sb, xattr_inum);
-	if (inode) {
-		clear_nlink(inode);
-		iput(inode);
-	}
+	inode = find_inode_nowait(c->vfs_sb, xattr_inum,
+			ubifs_match_ino, NULL);
+	if (IS_ERR_OR_NULL(inode))
+		return;
+
+	clear_nlink(inode);
+	iput(inode);
 }
 
 static int ubifs_xattr_remove(struct inode *host, const char *name)
-- 
2.34.3


