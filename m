Return-Path: <linux-kernel+bounces-205310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B6F8FFA8E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211971C238C7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7AB1553A1;
	Fri,  7 Jun 2024 04:27:07 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D142249EB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734427; cv=none; b=cTpYLTHicC5oMwH0pLI+ZUh+a+35WY8CSy0N3fBbFywrc+DKinvKhrKuSRY3/Lnq2IdNE95tCJ8at3hvV2s5DGtAd/+Vqd50tYfSzUjl3G79JhIdNH29upRlsaeoZP6avQZ8Tt1/BFc/UrmxNKj30AA45uffS8f8Rg1E638qEQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734427; c=relaxed/simple;
	bh=vxv9ZTCKBH0Kde9S4B2p/FaYMTHVm1da3JAmUyZwRKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZXQC3fxvzmcGQX7aibU3OyAQUUg1QhPc7CNtlUSWbk8yyrxV8OveSneiyVtuPo7q0+PJjuOegomGFNTCYubIwQ8INC4mjg3v5XLk9Du+zN2qJnzOiTrmWxtDnjacQUmL83I9YMNUGavwSUwA+EFArnmpfTlyVo/A+tyJ5Uf+pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwShz6dzKzmXv6;
	Fri,  7 Jun 2024 12:22:27 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id BF71A140203;
	Fri,  7 Jun 2024 12:26:48 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:32 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 009/110] mkfs.ubifs: Fix incorrect dir size calculation in encryption scenario
Date: Fri, 7 Jun 2024 12:24:34 +0800
Message-ID: <20240607042615.2069840-10-chengzhihao1@huawei.com>
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

The size of directory should be the total length of encrypted entry name,
otherwise it could trigger errors while checking filesystem:
 dbg_check_filesystem [ubifs]: directory inode 89 size is 352, but
 calculated size is 400

Fixes: 4c55918dd747d ("Implement filename encryption")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/mkfs.ubifs/mkfs.ubifs.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
index 8bf073ce..25c49967 100644
--- a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
+++ b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
@@ -1723,15 +1723,17 @@ static void set_dent_cookie(struct ubifs_dent_node *dent)
  * @name: directory entry name
  * @inum: target inode number of the directory entry
  * @type: type of the target inode
+ * @kname_len: the length of name stored in the directory entry node is
+ *	       returned here
  */
 static int add_dent_node(ino_t dir_inum, const char *name, ino_t inum,
-			 unsigned char type, struct fscrypt_context *fctx)
+			 unsigned char type, struct fscrypt_context *fctx,
+			 int *kname_len)
 {
 	struct ubifs_dent_node *dent = node_buf;
 	union ubifs_key key;
 	struct qstr dname;
 	char *kname;
-	int kname_len;
 	int len;
 
 	dbg_msg(3, "%s ino %lu type %u dir ino %lu", name, (unsigned long)inum,
@@ -1749,7 +1751,7 @@ static int add_dent_node(ino_t dir_inum, const char *name, ino_t inum,
 	set_dent_cookie(dent);
 
 	if (!fctx) {
-		kname_len = dname.len;
+		*kname_len = dname.len;
 		kname = strdup(name);
 		if (!kname)
 			return errmsg("cannot allocate memory");
@@ -1765,18 +1767,18 @@ static int add_dent_node(ino_t dir_inum, const char *name, ino_t inum,
 		if (ret < 0)
 			return ret;
 
-		kname_len = ret;
+		*kname_len = ret;
 	}
 
-	dent_key_init(c, &key, dir_inum, kname, kname_len);
-	dent->nlen = cpu_to_le16(kname_len);
-	memcpy(dent->name, kname, kname_len);
-	dent->name[kname_len] = '\0';
-	len = UBIFS_DENT_NODE_SZ + kname_len + 1;
+	dent_key_init(c, &key, dir_inum, kname, *kname_len);
+	dent->nlen = cpu_to_le16(*kname_len);
+	memcpy(dent->name, kname, *kname_len);
+	dent->name[*kname_len] = '\0';
+	len = UBIFS_DENT_NODE_SZ + *kname_len + 1;
 
 	key_write(&key, dent->key);
 
-	return add_node(&key, kname, kname_len, dent, len);
+	return add_node(&key, kname, *kname_len, dent, len);
 }
 
 /**
@@ -2026,7 +2028,7 @@ static int add_directory(const char *dir_name, ino_t dir_inum, struct stat *st,
 {
 	struct dirent *entry;
 	DIR *dir = NULL;
-	int err = 0;
+	int kname_len, err = 0;
 	loff_t size = UBIFS_INO_NODE_SZ;
 	char *name = NULL;
 	unsigned int nlink = 2;
@@ -2139,13 +2141,13 @@ static int add_directory(const char *dir_name, ino_t dir_inum, struct stat *st,
 			goto out_free;
 		}
 
-		err = add_dent_node(dir_inum, entry->d_name, inum, type, fctx);
+		err = add_dent_node(dir_inum, entry->d_name, inum, type, fctx,
+				    &kname_len);
 		if (err) {
 			free_fscrypt_context(new_fctx);
 			goto out_free;
 		}
-		size += ALIGN(UBIFS_DENT_NODE_SZ + strlen(entry->d_name) + 1,
-			      8);
+		size += ALIGN(UBIFS_DENT_NODE_SZ + kname_len + 1, 8);
 
 		if (new_fctx)
 			free_fscrypt_context(new_fctx);
@@ -2210,13 +2212,14 @@ static int add_directory(const char *dir_name, ino_t dir_inum, struct stat *st,
 			goto out_free;
 		}
 
-		err = add_dent_node(dir_inum, nh_elt->name, inum, type, fctx);
+		err = add_dent_node(dir_inum, nh_elt->name, inum, type, fctx,
+				    &kname_len);
 		if (err) {
 			free_fscrypt_context(new_fctx);
 			goto out_free;
 		}
 
-		size += ALIGN(UBIFS_DENT_NODE_SZ + strlen(nh_elt->name) + 1, 8);
+		size += ALIGN(UBIFS_DENT_NODE_SZ + kname_len + 1, 8);
 
 		nh_elt = next_name_htbl_element(ph_elt, &itr);
 		if (new_fctx)
-- 
2.13.6


