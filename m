Return-Path: <linux-kernel+bounces-271171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 457D7944A55
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0473E28220F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9947E189BA1;
	Thu,  1 Aug 2024 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YteqkSxb"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B662189B93
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722511595; cv=none; b=ntiaHeAztpYgGz7JnVFxLxJ6MIItY4yurQ/fQ8yz0ZE7PV85gS1ABz3BRfBx7nU4K743RBVhHj8r7hLUeJKP0W4KjFUBB6J9iPw1Ou5f2hbCf+TEZo76ETqlZDcKeOTwvPwbdtVtQCaJ9E8z6jHumY0enZ9sJFZudhf6il1MJjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722511595; c=relaxed/simple;
	bh=q3depUJyDyLLTBsluK9v6x0TPDb54LzGl90CAeSSWV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t4Zj5llFdlsDLXXB09NTc305l9xMDB4mlNOoHhu15pjypEkibv5X/63a6pWwdKLfVKimE6E5XoAIZB29s9KMXB5XQ1NCOik+o2YY28QGGcLGEapuaKulQmBYbasU92JTCU/v/Z2VfOXvFPDqsxOhPzdseiaIpBnGzOMI0FHcnU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YteqkSxb; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722511585; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/EEI8ar1ScTAY63kmSBLsbJ6p7nSUzyzhCYxRBlhE1c=;
	b=YteqkSxbKM9iEFqABSSi7EUP/OBvqO/zpka6b53LdAPbDMrGzhifpAZc0R/zFqsfIRRaEXJI24OwGLZ7+W8sHruPfK1dmvKsC1cwPgEmwxeAvCPNLh7sJ06rxB6YB9BR78AKauY9MnfU/AZ2IYv5I9oeCWCh47Gc7ZLA7ZYma78=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032019045;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0WBt-2UW_1722511583;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WBt-2UW_1722511583)
          by smtp.aliyun-inc.com;
          Thu, 01 Aug 2024 19:26:24 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	Hongzhen Luo <hongzhen@linux.alibaba.com>
Subject: [PATCH] erofs: simplify readdir operation
Date: Thu,  1 Aug 2024 19:26:22 +0800
Message-ID: <20240801112622.2164029-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 - Use i_size instead of i_size_read() due to immutable fses;

 - Get rid of an unneeded goto since erofs_fill_dentries() also works;

 - Remove unnecessary lines.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/dir.c      | 35 ++++++++++++-----------------------
 fs/erofs/internal.h |  2 +-
 2 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index 2193a6710c8f..c3b90abdee37 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -8,19 +8,15 @@
 
 static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 			       void *dentry_blk, struct erofs_dirent *de,
-			       unsigned int nameoff, unsigned int maxsize)
+			       unsigned int nameoff0, unsigned int maxsize)
 {
-	const struct erofs_dirent *end = dentry_blk + nameoff;
+	const struct erofs_dirent *end = dentry_blk + nameoff0;
 
 	while (de < end) {
-		const char *de_name;
+		unsigned char d_type = fs_ftype_to_dtype(de->file_type);
+		unsigned int nameoff = le16_to_cpu(de->nameoff);
+		const char *de_name = (char *)dentry_blk + nameoff;
 		unsigned int de_namelen;
-		unsigned char d_type;
-
-		d_type = fs_ftype_to_dtype(de->file_type);
-
-		nameoff = le16_to_cpu(de->nameoff);
-		de_name = (char *)dentry_blk + nameoff;
 
 		/* the last dirent in the block? */
 		if (de + 1 >= end)
@@ -52,21 +48,20 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct super_block *sb = dir->i_sb;
 	unsigned long bsz = sb->s_blocksize;
-	const size_t dirsize = i_size_read(dir);
-	unsigned int i = erofs_blknr(sb, ctx->pos);
 	unsigned int ofs = erofs_blkoff(sb, ctx->pos);
 	int err = 0;
 	bool initial = true;
 
 	buf.mapping = dir->i_mapping;
-	while (ctx->pos < dirsize) {
+	while (ctx->pos < dir->i_size) {
+		erofs_off_t dbstart = ctx->pos - ofs;
 		struct erofs_dirent *de;
 		unsigned int nameoff, maxsize;
 
-		de = erofs_bread(&buf, erofs_pos(sb, i), EROFS_KMAP);
+		de = erofs_bread(&buf, dbstart, EROFS_KMAP);
 		if (IS_ERR(de)) {
 			erofs_err(sb, "fail to readdir of logical block %u of nid %llu",
-				  i, EROFS_I(dir)->nid);
+				  erofs_blknr(sb, dbstart), EROFS_I(dir)->nid);
 			err = PTR_ERR(de);
 			break;
 		}
@@ -79,25 +74,19 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 			break;
 		}
 
-		maxsize = min_t(unsigned int, dirsize - ctx->pos + ofs, bsz);
-
+		maxsize = min_t(unsigned int, dir->i_size - dbstart, bsz);
 		/* search dirents at the arbitrary position */
 		if (initial) {
 			initial = false;
-
 			ofs = roundup(ofs, sizeof(struct erofs_dirent));
-			ctx->pos = erofs_pos(sb, i) + ofs;
-			if (ofs >= nameoff)
-				goto skip_this;
+			ctx->pos = dbstart + ofs;
 		}
 
 		err = erofs_fill_dentries(dir, ctx, de, (void *)de + ofs,
 					  nameoff, maxsize);
 		if (err)
 			break;
-skip_this:
-		ctx->pos = erofs_pos(sb, i) + maxsize;
-		++i;
+		ctx->pos = dbstart + maxsize;
 		ofs = 0;
 	}
 	erofs_put_metabuf(&buf);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 736607675396..45dc15ebd870 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -220,7 +220,7 @@ struct erofs_buf {
 };
 #define __EROFS_BUF_INITIALIZER	((struct erofs_buf){ .page = NULL })
 
-#define erofs_blknr(sb, addr)	((addr) >> (sb)->s_blocksize_bits)
+#define erofs_blknr(sb, addr)	((erofs_blk_t)((addr) >> (sb)->s_blocksize_bits))
 #define erofs_blkoff(sb, addr)	((addr) & ((sb)->s_blocksize - 1))
 #define erofs_pos(sb, blk)	((erofs_off_t)(blk) << (sb)->s_blocksize_bits)
 #define erofs_iblks(i)	(round_up((i)->i_size, i_blocksize(i)) >> (i)->i_blkbits)
-- 
2.43.5


