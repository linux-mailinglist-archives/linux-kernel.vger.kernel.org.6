Return-Path: <linux-kernel+bounces-553901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFE5A5906A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3E43AD76D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB222686F;
	Mon, 10 Mar 2025 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TddCjJi+"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093FF225779
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600521; cv=none; b=HU1KWRRh3yywUZhWTv01Rb4B5rq8Z4/1l7yZFzz9ze86tmubFthhaaFmDYCUCp7JtmsIX49Rq9mVxQqko+bX39zZX9qgIfTSFPJQ6bfWp94PHySXta5B4eUR/uoWinTNKgGrOQHx0rjHJqTOmkGocOxHltAB3CuCyy9ncX1QGec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600521; c=relaxed/simple;
	bh=73+Jv7sZsXwu/uS0m4ZO/BsjxwhbO5akcYKKAQvI3UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhjZb+R53vmRW6B3t4jG3JQDs27XkTCAhL7vJF/ubJQhJoJ1ZQBBV/nb0MaYKfHtwX0JpJELgHmJk7+mkF3TH2jZNfwcJVfyy3XkGEeDB0AV+Ijk97zY+4JBU5sh95FjHOCRd7Uq9EYlhmSTQbDG08q9ZerE2eQdhZHDbOnHV7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TddCjJi+; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741600509; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=inQ7L5nN0a/HpCYRCvZiBbdUFWIni4CRkXK2nXN8wCY=;
	b=TddCjJi+gZCv4yRktRir9mMKCbAQAzBtLVcGWOw/YSHHX4hsFTxjNIrW0eKPhamMOy8S5lnvul2SivggokVcIaYQ208jN2h3QD6iMOtO2VpHal7TKRgyCeQDFqyylyTNYKZHeCks+0mp7dIo+1R70nahgQ+OOUoGLxhAeK3UUWM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WR1F3zQ_1741600508 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 17:55:09 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 05/10] erofs: support dot-omitted directories
Date: Mon, 10 Mar 2025 17:54:55 +0800
Message-ID: <20250310095459.2620647-6-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
References: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no need to record "." dirents in the directory data (while
they could be used for sanity checks, they aren't very useful.)
Omitting "." dirents also improves directory data deduplication.

Use a per-inode (instead of per-sb) flag to indicate if the "." dirent
is omitted or not, ensuring compatibility with incremental builds.  It
also reuses EROFS_I_NLINK_1_BIT, as it has very limited use cases for
directories with `nlink = 1`.

Emit the "." entry as the last virtual dirent in the directory because
it is _much_ less frequently used than the ".." dirent.  It also keeps
`f_pos` meaningful, as it strictly follows the directory data when it's
less than i_size.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/dir.c      | 5 +++++
 fs/erofs/erofs_fs.h | 1 +
 fs/erofs/inode.c    | 4 +++-
 fs/erofs/internal.h | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index fa3c2d380cc9..2fae209d0274 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -90,6 +90,11 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 		ofs = 0;
 	}
 	erofs_put_metabuf(&buf);
+	if (EROFS_I(dir)->dot_omitted && ctx->pos == dir->i_size) {
+		if (!dir_emit_dot(f, ctx))
+			return 0;
+		++ctx->pos;
+	}
 	return err < 0 ? err : 0;
 }
 
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 8330ca3b18d3..791124b3f57c 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -116,6 +116,7 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 #define EROFS_I_VERSION_BIT	0
 #define EROFS_I_DATALAYOUT_BIT	1
 #define EROFS_I_NLINK_1_BIT	4	/* non-directory compact inodes only */
+#define EROFS_I_DOT_OMITTED_BIT	4	/* (directories) omit the `.` dirent */
 #define EROFS_I_ALL		((1 << (EROFS_I_NLINK_1_BIT + 1)) - 1)
 
 /* indicate chunk blkbits, thus 'chunksize = blocksize << chunk blkbits' */
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 20d58228dfc9..3a5bb73a9397 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -137,8 +137,10 @@ static int erofs_read_inode(struct inode *inode)
 		goto err_out;
 	}
 	switch (inode->i_mode & S_IFMT) {
-	case S_IFREG:
 	case S_IFDIR:
+		vi->dot_omitted = (ifmt >> EROFS_I_DOT_OMITTED_BIT) & 1;
+		fallthrough;
+	case S_IFREG:
 	case S_IFLNK:
 		vi->startblk = le32_to_cpu(copied.i_u.startblk_lo) |
 			((u64)le16_to_cpu(copied.i_nb.startblk_hi) << 32);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 07515a6f2534..91d0b400459c 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -245,6 +245,7 @@ struct erofs_inode {
 
 	unsigned char datalayout;
 	unsigned char inode_isize;
+	bool dot_omitted;
 	unsigned int xattr_isize;
 
 	unsigned int xattr_name_filter;
-- 
2.43.5


