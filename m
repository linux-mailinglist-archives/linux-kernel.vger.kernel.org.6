Return-Path: <linux-kernel+bounces-331730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEC997B096
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B381F230B3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFBC16F839;
	Tue, 17 Sep 2024 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h7nUeSKl"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B01E15AAD6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726578500; cv=none; b=C57mf7LR0JpZ6ecvEBWNXmpYe10689BO92MjaBgs56s7cuFO+lPCfpr03S3NAn1jEG7CmzrJAVpLAvE97U7wEt2RA68NtI1W5kHtw+eGXU/xt5dZsSgtinhdkI5m+qbh19Itrc2X7SO5yVWY/QwsJvfPe+yZ/E1jkFMnelVwfGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726578500; c=relaxed/simple;
	bh=H8l2q4aM0VOrvkGAFp7aa/J77rWuiCWjSmFzPH8oD4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DE5F2F6hjThRFWNRq6JJ+Sfg4c5HQFN9POvxb6dqN8nv62jgoWN0ofopKeZPKPZIMpI8/AmYp/A9Lpo88BmjYHPzJWD1Kb8jjD2oyO3Ame/GzIZvAIF7/2IpiINZrUFlWaA+ywSsllaRlGdvuszlAT1mYMfmrNeANVBKlMIszN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h7nUeSKl; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726578488; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hlDVpKGZvqffbAlVD5qaDM5mbqYPYdsGsfyPEohCPpQ=;
	b=h7nUeSKl8redjirarXyimo8Fjqhw70TGH9zScAY8HZALe9QkNu+knfjjOwcmkT6v64yGLaeqG8GhQoC5khZg/jSgP8QI1Jc7jwfXxsCltj7Z45EA2n6qi2O0tgF9uu4eR64eshZrM6UMVab8NTl81KFFSs2h9cOZcbnETK74/to=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFAtkZY_1726578487)
          by smtp.aliyun-inc.com;
          Tue, 17 Sep 2024 21:08:08 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com
Subject: [PATCH v2] erofs: ensure regular inodes for file-backed mounts
Date: Tue, 17 Sep 2024 21:08:03 +0800
Message-ID: <20240917130803.32418-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <00000000000011bdde0622498ee3@google.com>
References: <00000000000011bdde0622498ee3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only regular inodes are allowed for file-backed mounts, not directories
(as seen in the original syzbot case) or special inodes.

Also ensure that .read_folio() is implemented on the underlying fs
for the primary device.

Fixes: fb176750266a ("erofs: add file-backed mount support")
Reported-by: syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/00000000000011bdde0622498ee3@google.com
Tested-by: syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
change since v1:
 - need to handle multi-device/blob cases too.

 fs/erofs/super.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 666873f745da..320d586c3896 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -191,10 +191,14 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		if (IS_ERR(file))
 			return PTR_ERR(file);
 
-		dif->file = file;
-		if (!erofs_is_fileio_mode(sbi))
+		if (!erofs_is_fileio_mode(sbi)) {
 			dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),
 					&dif->dax_part_off, NULL, NULL);
+		} else if (!S_ISREG(file_inode(file)->i_mode)) {
+			fput(file);
+			return -EINVAL;
+		}
+		dif->file = file;
 	}
 
 	dif->blocks = le32_to_cpu(dis->blocks);
@@ -714,7 +718,10 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 		if (IS_ERR(sbi->fdev))
 			return PTR_ERR(sbi->fdev);
 
-		return get_tree_nodev(fc, erofs_fc_fill_super);
+		if (S_ISREG(file_inode(sbi->fdev)->i_mode) &&
+		    sbi->fdev->f_mapping->a_ops->read_folio)
+			return get_tree_nodev(fc, erofs_fc_fill_super);
+		fput(sbi->fdev);
 	}
 #endif
 	return ret;
-- 
2.43.5


