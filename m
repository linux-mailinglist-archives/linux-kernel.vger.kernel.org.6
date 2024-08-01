Return-Path: <linux-kernel+bounces-271191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC6C944A9D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C78428351D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF791190045;
	Thu,  1 Aug 2024 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hboAC3ta"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC3A15885A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722512998; cv=none; b=WoZWVYJXdWYs6bgKt7QXiS+phtccceFhjvFE++gFlom1gSP4bx+lMGE0NiLzes8yUEnMdLq02bMad0hA8M/a24Ed/Mb3IyN5+TY7BHS1EUn7NEBwss1m2l73nYv50KpBFQH7YqgeOulf84kmxWt7PVDp0OAvF3b+zGltMhJDmX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722512998; c=relaxed/simple;
	bh=aAIT52XSSjAOqURHRP9eHbqaeYfK4U5XC6RYCb3AAeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VaiVip245COUBA7bObAynnCn2y4q+2/6OOIyB3CkeUl64XEqPWkZWp5WKqZO7ovbjwSMtRjIBVc3uxVLt3M3SU++PRx25Lh3rRmcgvElEpYQ/2aZzHbWHg8u/jE4Z6ppFDAxKMZVEyRJ/SrH3/eZN6id6vCj5Ft9gGD36IJp9Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hboAC3ta; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722512988; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9F8GmYp/RGw8uK6DMS1OG48p0p7T1vaOlFIRzG6bjSI=;
	b=hboAC3taH8JstN4co3OMm/+k3ci+JrbCMCNZmgJMs+sh08KWeBjXoTYDtnBbCsKBRFMbVvD8KPdTkE416pCSoKNh6Bmxq9X1AJJMT61YBlNcBKeiXUqmzUAwKhAhxkoa2+YNtSibRnD+7Q/CCGmFVJ/LpaOZfA17Dang/GgRJ/U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0WBt3qv7_1722512671;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WBt3qv7_1722512671)
          by smtp.aliyun-inc.com;
          Thu, 01 Aug 2024 19:44:31 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	Hongzhen Luo <hongzhen@linux.alibaba.com>
Subject: [PATCH] erofs: simplify readdir operation
Date: Thu,  1 Aug 2024 19:44:30 +0800
Message-ID: <20240801114430.2182356-1-hongzhen@linux.alibaba.com>
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
v3: Add change log.
v2: https://lore.kernel.org/all/20240801112622.2164029-1-hongzhen@linux.alibaba.com/
    - Fix the broken patch v1
v1: https://lore.kernel.org/all/20cbea9c-3b3f-40f7-be01-bd9de52e3134@linux.alibaba.com/
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


