Return-Path: <linux-kernel+bounces-205324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8E18FFA95
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4895528B04B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6088C3FB87;
	Fri,  7 Jun 2024 04:27:19 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63FE15572D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734438; cv=none; b=KEARw7khrMMW4UkyMRV/hvRlAnzz0Tmnh6BCawK9rOutSWmKQvee6aQPcS/kjnGZBTlOsVPlBgM4mrlkJ3aiK0s3HHqdzdKc8io4F+Q2BC/l5sTRDzLQ0gMbpQK1M2D10BPHX0fxm51e4TR0AwMxcJ0nTAXWhzhykxBSwirjgUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734438; c=relaxed/simple;
	bh=3k/FtmMBThWbOQaguUUbP6lJu4CIzMPXSKUyfV1EeV8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gX8CE38H/pWY/QP+4Y2M8OUUIgJDOGCBJ75ceH+dcOgauwSR525b0p2DCaMhOGl+KtJJu/KLkCDey4E0gaToqytnXaEpBtM8lhNPnL1vvusUmTLxagI5mlFrHNGloI+t41h9bBX35f1NsPUNDbwskBVYdBB7SZzFmKBP+tdTsY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VwSjs0zV8z1SB5N;
	Fri,  7 Jun 2024 12:23:13 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id D6D50180085;
	Fri,  7 Jun 2024 12:27:11 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:03 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 050/110] ubifs-utils: Adapt misc.h in libubifs
Date: Fri, 7 Jun 2024 12:25:15 +0800
Message-ID: <20240607042615.2069840-51-chengzhihao1@huawei.com>
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

Adapt misc.h in libubifs, compared with linux kernel implementations:
 1. Remove some functions(eg. ubifs_compr_name, ubifs_wake_up_bgt) which
    won't be used in fsck/mkfs.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/libubifs/misc.h | 75 +--------------------------------------------
 1 file changed, 1 insertion(+), 74 deletions(-)

diff --git a/ubifs-utils/libubifs/misc.h b/ubifs-utils/libubifs/misc.h
index 615878e8..4b718068 100644
--- a/ubifs-utils/libubifs/misc.h
+++ b/ubifs-utils/libubifs/misc.h
@@ -50,18 +50,6 @@ static inline int ubifs_zn_cow(const struct ubifs_znode *znode)
 }
 
 /**
- * ubifs_wake_up_bgt - wake up background thread.
- * @c: UBIFS file-system description object
- */
-static inline void ubifs_wake_up_bgt(struct ubifs_info *c)
-{
-	if (c->bgt && !c->need_bgt) {
-		c->need_bgt = 1;
-		wake_up_process(c->bgt);
-	}
-}
-
-/**
  * ubifs_tnc_find_child - find next child in znode.
  * @znode: znode to search at
  * @start: the zbranch index to start at
@@ -82,42 +70,6 @@ ubifs_tnc_find_child(struct ubifs_znode *znode, int start)
 }
 
 /**
- * ubifs_inode - get UBIFS inode information by VFS 'struct inode' object.
- * @inode: the VFS 'struct inode' pointer
- */
-static inline struct ubifs_inode *ubifs_inode(const struct inode *inode)
-{
-	return container_of(inode, struct ubifs_inode, vfs_inode);
-}
-
-/**
- * ubifs_compr_present - check if compressor was compiled in.
- * @compr_type: compressor type to check
- * @c: the UBIFS file-system description object
- *
- * This function returns %1 of compressor of type @compr_type is present, and
- * %0 if not.
- */
-static inline int ubifs_compr_present(struct ubifs_info *c, int compr_type)
-{
-	ubifs_assert(c, compr_type >= 0 && compr_type < UBIFS_COMPR_TYPES_CNT);
-	return !!ubifs_compressors[compr_type]->capi_name;
-}
-
-/**
- * ubifs_compr_name - get compressor name string by its type.
- * @compr_type: compressor type
- * @c: the UBIFS file-system description object
- *
- * This function returns compressor type string.
- */
-static inline const char *ubifs_compr_name(struct ubifs_info *c, int compr_type)
-{
-	ubifs_assert(c, compr_type >= 0 && compr_type < UBIFS_COMPR_TYPES_CNT);
-	return ubifs_compressors[compr_type]->name;
-}
-
-/**
  * ubifs_wbuf_sync - synchronize write-buffer.
  * @wbuf: write-buffer to synchronize
  *
@@ -135,21 +87,6 @@ static inline int ubifs_wbuf_sync(struct ubifs_wbuf *wbuf)
 }
 
 /**
- * ubifs_encode_dev - encode device node IDs.
- * @dev: UBIFS device node information
- * @rdev: device IDs to encode
- *
- * This is a helper function which encodes major/minor numbers of a device node
- * into UBIFS device node description. We use standard Linux "new" and "huge"
- * encodings.
- */
-static inline int ubifs_encode_dev(union ubifs_dev_desc *dev, dev_t rdev)
-{
-	dev->new = cpu_to_le32(new_encode_dev(rdev));
-	return sizeof(dev->new);
-}
-
-/**
  * ubifs_add_dirt - add dirty space to LEB properties.
  * @c: the UBIFS file-system description object
  * @lnum: LEB to add dirty space for
@@ -209,7 +146,7 @@ struct ubifs_branch *ubifs_idx_branch(const struct ubifs_info *c,
  * @c: the UBIFS file-system description object
  * @idx: index node
  */
-static inline void *ubifs_idx_key(const struct ubifs_info *c,
+static inline void *ubifs_idx_key(__unused const struct ubifs_info *c,
 				  const struct ubifs_idx_node *idx)
 {
 	return (void *)((struct ubifs_branch *)idx->branches)->key;
@@ -276,14 +213,4 @@ static inline int ubifs_next_log_lnum(const struct ubifs_info *c, int lnum)
 	return lnum;
 }
 
-static inline int ubifs_xattr_max_cnt(struct ubifs_info *c)
-{
-	int max_xattrs = (c->leb_size / 2) / UBIFS_INO_NODE_SZ;
-
-	ubifs_assert(c, max_xattrs < c->max_orphans);
-	return max_xattrs;
-}
-
-const char *ubifs_assert_action_name(struct ubifs_info *c);
-
 #endif /* __UBIFS_MISC_H__ */
-- 
2.13.6


