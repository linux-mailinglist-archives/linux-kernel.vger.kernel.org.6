Return-Path: <linux-kernel+bounces-169701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E12F78BCC51
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7501F221E2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867FB1339A2;
	Mon,  6 May 2024 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jjo+1PnM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE014436A
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992467; cv=none; b=YiwDd4ncmzV1CmOWn9LqQO08MXX3n2TTwRkRJscKxCux8u9vnsSy4pZtdn5INYtxWfrUB4G3Ob/yhDFEMAvQbRGnCs1L1oegUApIPqyB+QIBfQYws72vmZMwBp0sglVLkBxAsX/mgtqUiMmwr5sABMpVfVBPfgHcsWC3YYwoAS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992467; c=relaxed/simple;
	bh=YSOHtXih+YcRDLnOvTaIOUa3RK2klhJIDmHmJq0mX3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=liHXbRG66hkBIh4JG5AC1Okg/Z33azRUW2tDY7V8VUt9bprHX6NqHzDqtRlVF7giTGBGwWZcm3xeRga3yH2CtgIlhFUJm9FZRoNCK3UjpvkHL7IMiZdwwRN95+E2Mkq0QP3lLBlDbzuMsuzztXliD3ibvqcLkDgXalLTCy0IgiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jjo+1PnM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08492C116B1;
	Mon,  6 May 2024 10:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714992467;
	bh=YSOHtXih+YcRDLnOvTaIOUa3RK2klhJIDmHmJq0mX3k=;
	h=From:To:Cc:Subject:Date:From;
	b=Jjo+1PnMqGeDq/5Ak6ychi0RCKK3amUWydv05kqIw3yi2W4LbhtTF0BO9bmZCAMKJ
	 H2nsAdv53OlGfqSJ7f+SutiegwE3dW+nS4Psv0wjzekblfGTNtAXoiti8BQMOzvlxG
	 XtcKPyclF8R/d6nWyZ3DDPZWwxvHNXrZXP+z20y9Wk+sm24RB8MUYrn9za7iFW8C9o
	 iZDmm94kGbWgWB5eRQ6gVWmlWzby4Ka9S5Oj9VasrjjS4jficzzh9Glhp16tGeq/TZ
	 j5UbFY3FISNTh+glt9EVtF/w4WnS8Gw93PL9khJp/W07XtNCiTKyahCynEVG9J8Oke
	 F2IJz8JPpwW5Q==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: use f2fs_{err,info}_ratelimited() for cleanup
Date: Mon,  6 May 2024 18:47:42 +0800
Message-Id: <20240506104742.778789-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b1c9d3f833ba ("f2fs: support printk_ratelimited() in f2fs_printk()")
missed some cases, cover all remains for cleanup.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c | 54 +++++++++++++++++++++-------------------------
 fs/f2fs/segment.c  |  5 ++---
 2 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 8892c8262141..3c70a9697063 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -198,8 +198,8 @@ static int lzo_compress_pages(struct compress_ctx *cc)
 	ret = lzo1x_1_compress(cc->rbuf, cc->rlen, cc->cbuf->cdata,
 					&cc->clen, cc->private);
 	if (ret != LZO_E_OK) {
-		printk_ratelimited("%sF2FS-fs (%s): lzo compress failed, ret:%d\n",
-				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id, ret);
+		f2fs_err_ratelimited(F2FS_I_SB(cc->inode),
+				"lzo compress failed, ret:%d", ret);
 		return -EIO;
 	}
 	return 0;
@@ -212,17 +212,15 @@ static int lzo_decompress_pages(struct decompress_io_ctx *dic)
 	ret = lzo1x_decompress_safe(dic->cbuf->cdata, dic->clen,
 						dic->rbuf, &dic->rlen);
 	if (ret != LZO_E_OK) {
-		printk_ratelimited("%sF2FS-fs (%s): lzo decompress failed, ret:%d\n",
-				KERN_ERR, F2FS_I_SB(dic->inode)->sb->s_id, ret);
+		f2fs_err_ratelimited(F2FS_I_SB(dic->inode),
+				"lzo decompress failed, ret:%d", ret);
 		return -EIO;
 	}
 
 	if (dic->rlen != PAGE_SIZE << dic->log_cluster_size) {
-		printk_ratelimited("%sF2FS-fs (%s): lzo invalid rlen:%zu, "
-					"expected:%lu\n", KERN_ERR,
-					F2FS_I_SB(dic->inode)->sb->s_id,
-					dic->rlen,
-					PAGE_SIZE << dic->log_cluster_size);
+		f2fs_err_ratelimited(F2FS_I_SB(dic->inode),
+				"lzo invalid rlen:%zu, expected:%lu",
+				dic->rlen, PAGE_SIZE << dic->log_cluster_size);
 		return -EIO;
 	}
 	return 0;
@@ -294,16 +292,15 @@ static int lz4_decompress_pages(struct decompress_io_ctx *dic)
 	ret = LZ4_decompress_safe(dic->cbuf->cdata, dic->rbuf,
 						dic->clen, dic->rlen);
 	if (ret < 0) {
-		printk_ratelimited("%sF2FS-fs (%s): lz4 decompress failed, ret:%d\n",
-				KERN_ERR, F2FS_I_SB(dic->inode)->sb->s_id, ret);
+		f2fs_err_ratelimited(F2FS_I_SB(dic->inode),
+				"lz4 decompress failed, ret:%d", ret);
 		return -EIO;
 	}
 
 	if (ret != PAGE_SIZE << dic->log_cluster_size) {
-		printk_ratelimited("%sF2FS-fs (%s): lz4 invalid ret:%d, "
-					"expected:%lu\n", KERN_ERR,
-					F2FS_I_SB(dic->inode)->sb->s_id, ret,
-					PAGE_SIZE << dic->log_cluster_size);
+		f2fs_err_ratelimited(F2FS_I_SB(dic->inode),
+				"lz4 invalid ret:%d, expected:%lu",
+				ret, PAGE_SIZE << dic->log_cluster_size);
 		return -EIO;
 	}
 	return 0;
@@ -350,9 +347,8 @@ static int zstd_init_compress_ctx(struct compress_ctx *cc)
 
 	stream = zstd_init_cstream(&params, 0, workspace, workspace_size);
 	if (!stream) {
-		printk_ratelimited("%sF2FS-fs (%s): %s zstd_init_cstream failed\n",
-				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id,
-				__func__);
+		f2fs_err_ratelimited(F2FS_I_SB(cc->inode),
+				"%s zstd_init_cstream failed", __func__);
 		kvfree(workspace);
 		return -EIO;
 	}
@@ -390,16 +386,16 @@ static int zstd_compress_pages(struct compress_ctx *cc)
 
 	ret = zstd_compress_stream(stream, &outbuf, &inbuf);
 	if (zstd_is_error(ret)) {
-		printk_ratelimited("%sF2FS-fs (%s): %s zstd_compress_stream failed, ret: %d\n",
-				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id,
+		f2fs_err_ratelimited(F2FS_I_SB(cc->inode),
+				"%s zstd_compress_stream failed, ret: %d",
 				__func__, zstd_get_error_code(ret));
 		return -EIO;
 	}
 
 	ret = zstd_end_stream(stream, &outbuf);
 	if (zstd_is_error(ret)) {
-		printk_ratelimited("%sF2FS-fs (%s): %s zstd_end_stream returned %d\n",
-				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id,
+		f2fs_err_ratelimited(F2FS_I_SB(cc->inode),
+				"%s zstd_end_stream returned %d",
 				__func__, zstd_get_error_code(ret));
 		return -EIO;
 	}
@@ -432,9 +428,8 @@ static int zstd_init_decompress_ctx(struct decompress_io_ctx *dic)
 
 	stream = zstd_init_dstream(max_window_size, workspace, workspace_size);
 	if (!stream) {
-		printk_ratelimited("%sF2FS-fs (%s): %s zstd_init_dstream failed\n",
-				KERN_ERR, F2FS_I_SB(dic->inode)->sb->s_id,
-				__func__);
+		f2fs_err_ratelimited(F2FS_I_SB(dic->inode),
+				"%s zstd_init_dstream failed", __func__);
 		kvfree(workspace);
 		return -EIO;
 	}
@@ -469,16 +464,15 @@ static int zstd_decompress_pages(struct decompress_io_ctx *dic)
 
 	ret = zstd_decompress_stream(stream, &outbuf, &inbuf);
 	if (zstd_is_error(ret)) {
-		printk_ratelimited("%sF2FS-fs (%s): %s zstd_decompress_stream failed, ret: %d\n",
-				KERN_ERR, F2FS_I_SB(dic->inode)->sb->s_id,
+		f2fs_err_ratelimited(F2FS_I_SB(dic->inode),
+				"%s zstd_decompress_stream failed, ret: %d",
 				__func__, zstd_get_error_code(ret));
 		return -EIO;
 	}
 
 	if (dic->rlen != outbuf.pos) {
-		printk_ratelimited("%sF2FS-fs (%s): %s ZSTD invalid rlen:%zu, "
-				"expected:%lu\n", KERN_ERR,
-				F2FS_I_SB(dic->inode)->sb->s_id,
+		f2fs_err_ratelimited(F2FS_I_SB(dic->inode),
+				"%s ZSTD invalid rlen:%zu, expected:%lu",
 				__func__, dic->rlen,
 				PAGE_SIZE << dic->log_cluster_size);
 		return -EIO;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4fd76e867e0a..2f85fd40f9eb 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1109,9 +1109,8 @@ static void __remove_discard_cmd(struct f2fs_sb_info *sbi,
 		dc->error = 0;
 
 	if (dc->error)
-		printk_ratelimited(
-			"%sF2FS-fs (%s): Issue discard(%u, %u, %u) failed, ret: %d",
-			KERN_INFO, sbi->sb->s_id,
+		f2fs_info_ratelimited(sbi,
+			"Issue discard(%u, %u, %u) failed, ret: %d",
 			dc->di.lstart, dc->di.start, dc->di.len, dc->error);
 	__detach_discard_cmd(dcc, dc);
 }
-- 
2.40.1


