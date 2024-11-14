Return-Path: <linux-kernel+bounces-409042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4C29C86D8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04757B29811
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B131EE021;
	Thu, 14 Nov 2024 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KpRusZw8"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1928B1F8193
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578313; cv=none; b=KXu1iz5OrKmacjvujrXwNNGQW4qdHwdGb2R1bKMl21uLjjJdv8LTy/9LT2sLQF70CPU/ojbRPKDXB3YLMc46CiSwBq4xrD/NQ866/RwO+/t7LEN9U4znOTcMCjV0LDbRnV5LlwBy6LuVnL2lQfP85BCijICLLFIi0ydfW9sTGp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578313; c=relaxed/simple;
	bh=xFitK+p3VEWF5h7d9YeEunnQOnLNuf2k+qR26kBJZUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b0YyVo4yoCPdWNPuKoD6giNAq3BmNvO/vZM6ozNUv9Em+wS3jvCXP7wDd3FYl4FATXD+hFAiKqDMe/Rp8p27UEinyQFzgCe7NAaACMOycscMqviaWCX3f/1xI5FoM+5VyNJYouANDgms5XMQ8EWWmhB20dq++wYG9EKTPAYtSxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KpRusZw8; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731578303; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Cfoxrf7A2stl6riO4W8iN9G+2yj/ESltvt7CchpB2oM=;
	b=KpRusZw8CNYkxqww6yqQJ7Jmm4t9MTidpYjcp1EXia4Limn0gBd2Lyfe9DR+Omw+YK/+JS3zj2MGSP3JC0G0cj+ntuzsGmEYF9UtsGpUFoDfmSS9LSXO3Tr4Td8cAurRD1/G+XQ1r2CQ0wJU3YKfZHnY9fA8xIAnbGSsPuV5fQY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJONkQz_1731578295 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 17:58:23 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: get rid of `buf->kmap_type`
Date: Thu, 14 Nov 2024 17:58:13 +0800
Message-ID: <20241114095813.839866-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 927e5010ff5b ("erofs: use kmap_local_page() only for
erofs_bread()"), `buf->kmap_type` actually has no use at all.

Let's get rid of `buf->kmap_type` now.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c     | 18 +++++-------------
 fs/erofs/internal.h |  1 -
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index f741c3847ff2..d53979174aff 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -10,10 +10,10 @@
 
 void erofs_unmap_metabuf(struct erofs_buf *buf)
 {
-	if (buf->kmap_type == EROFS_KMAP)
-		kunmap_local(buf->base);
+	if (!buf->base)
+		return;
+	kunmap_local(buf->base);
 	buf->base = NULL;
-	buf->kmap_type = EROFS_NO_KMAP;
 }
 
 void erofs_put_metabuf(struct erofs_buf *buf)
@@ -45,15 +45,8 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
 			return folio;
 	}
 	buf->page = folio_file_page(folio, index);
-
-	if (buf->kmap_type == EROFS_NO_KMAP) {
-		if (type == EROFS_KMAP)
-			buf->base = kmap_local_page(buf->page);
-		buf->kmap_type = type;
-	} else if (buf->kmap_type != type) {
-		DBG_BUGON(1);
-		return ERR_PTR(-EFAULT);
-	}
+	if (!buf->base && type == EROFS_KMAP)
+		buf->base = kmap_local_page(buf->page);
 	if (type == EROFS_NO_KMAP)
 		return NULL;
 	return buf->base + (offset & ~PAGE_MASK);
@@ -352,7 +345,6 @@ static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		struct erofs_buf buf = {
 			.page = kmap_to_page(ptr),
 			.base = ptr,
-			.kmap_type = EROFS_KMAP,
 		};
 
 		DBG_BUGON(iomap->type != IOMAP_INLINE);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 9844ee8a07e5..01bbbd32b6b9 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -212,7 +212,6 @@ struct erofs_buf {
 	struct file *file;
 	struct page *page;
 	void *base;
-	enum erofs_kmap_type kmap_type;
 };
 #define __EROFS_BUF_INITIALIZER	((struct erofs_buf){ .page = NULL })
 
-- 
2.43.5


