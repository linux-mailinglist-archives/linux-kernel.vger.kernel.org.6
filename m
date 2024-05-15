Return-Path: <linux-kernel+bounces-179916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C3A8C6764
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E4C1C2101E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 13:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737868595B;
	Wed, 15 May 2024 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="j3qSWeB1"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9B985C4E
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715779798; cv=none; b=WlKSlxCcwzq6b6ao9XqO/c5RaVUeCloZok5Kt+GIVMQ+GRCpFecUGdyKF8EYX2FXcl6YnWUE5t/FMa1uejHCkEqYg5nspA53ngVa2a5eHONADGWsvF/6MQQjtDBZ+EJkpgFvph3s5CZ2843fHMoGgaktymqB/x+WhdHbRxNhxBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715779798; c=relaxed/simple;
	bh=gz0ggfN6+8zfLHC6A1tTQMN9AyVLIKPJ0bhOy7smPrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c4k7us4fA1LtbZAesNLlohNaXWnB9NcgnrbrFnLyXZr/i3VI/VJHuAGldjDUZdX2YdMDlw0lcMSbp4mqz2kYfCERzkmhUUrp6Wi0fYWvozWfkcwMGMRaeLQ40D5M7LcKaP8T1/4bewY6CBHnErCSnstcmdChCtWgZC5Y9nuWelQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=j3qSWeB1; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715779789; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=51HpooU0DkeKvMgR87mxZX64g8YR7tYzfAIqWRzGG0o=;
	b=j3qSWeB1b7PgB787B5JiLrjNs3fM1W7ImvnYRJu4tgjdUx8vuwhgdmct/HXES6CHibs4ZV2q3RLRYuKM3qOs/fhj623Xj4FTJKPgnILZA52HGt/gWtCcz2GDMFYnrJ7+Q0t1c0aOdTMxTSsuKLPRI6hsAc8zg1GnL5q1gglvJKQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W6YDIFU_1715779785;
Received: from j66c13357.sqa.eu95.tbsite.net(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0W6YDIFU_1715779785)
          by smtp.aliyun-inc.com;
          Wed, 15 May 2024 21:29:48 +0800
From: Ferry Meng <mengferry@linux.alibaba.com>
To: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	ocfs2-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Ferry Meng <mengferry@linux.alibaba.com>
Subject: [PATCH 1/2] ocfs2: add bounds checking to ocfs2_xattr_find_entry()
Date: Wed, 15 May 2024 21:29:33 +0800
Message-Id: <20240515132934.69511-2-mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240515132934.69511-1-mengferry@linux.alibaba.com>
References: <20240515132934.69511-1-mengferry@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just add redundant (perhaps paranoia) checks to make sure it doesn't
stray beyond valid meory region of ocfs2 xattr entry array during a
single match.

Maybe this patch can prevent some crash caused by crafted poison images.

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
---
 fs/ocfs2/xattr.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 3b81213ed7b8..37be4a286faf 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -1062,8 +1062,8 @@ ssize_t ocfs2_listxattr(struct dentry *dentry,
 	return i_ret + b_ret;
 }
 
-static int ocfs2_xattr_find_entry(int name_index,
-				  const char *name,
+static int ocfs2_xattr_find_entry(struct inode *inode, void *end,
+				  int name_index, const char *name,
 				  struct ocfs2_xattr_search *xs)
 {
 	struct ocfs2_xattr_entry *entry;
@@ -1076,6 +1076,10 @@ static int ocfs2_xattr_find_entry(int name_index,
 	name_len = strlen(name);
 	entry = xs->here;
 	for (i = 0; i < le16_to_cpu(xs->header->xh_count); i++) {
+		if ((void *)entry >= end) {
+			ocfs2_error(inode->i_sb, "corrupted xattr entries");
+			return -EFSCORRUPTED;
+		}
 		cmp = name_index - ocfs2_xattr_get_type(entry);
 		if (!cmp)
 			cmp = name_len - entry->xe_name_len;
@@ -1166,7 +1170,7 @@ static int ocfs2_xattr_ibody_get(struct inode *inode,
 	xs->base = (void *)xs->header;
 	xs->here = xs->header->xh_entries;
 
-	ret = ocfs2_xattr_find_entry(name_index, name, xs);
+	ret = ocfs2_xattr_find_entry(inode, xs->end, name_index, name, xs);
 	if (ret)
 		return ret;
 	size = le64_to_cpu(xs->here->xe_value_size);
@@ -2698,7 +2702,7 @@ static int ocfs2_xattr_ibody_find(struct inode *inode,
 
 	/* Find the named attribute. */
 	if (oi->ip_dyn_features & OCFS2_INLINE_XATTR_FL) {
-		ret = ocfs2_xattr_find_entry(name_index, name, xs);
+		ret = ocfs2_xattr_find_entry(inode, xs->end, name_index, name, xs);
 		if (ret && ret != -ENODATA)
 			return ret;
 		xs->not_found = ret;
@@ -2833,7 +2837,7 @@ static int ocfs2_xattr_block_find(struct inode *inode,
 		xs->end = (void *)(blk_bh->b_data) + blk_bh->b_size;
 		xs->here = xs->header->xh_entries;
 
-		ret = ocfs2_xattr_find_entry(name_index, name, xs);
+		ret = ocfs2_xattr_find_entry(inode, xs->end, name_index, name, xs);
 	} else
 		ret = ocfs2_xattr_index_block_find(inode, blk_bh,
 						   name_index,
-- 
2.32.0.3.g01195cf9f


