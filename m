Return-Path: <linux-kernel+bounces-235771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8488C91D971
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B683283AE3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE1C82899;
	Mon,  1 Jul 2024 07:52:33 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE72B6F073
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719820353; cv=none; b=BbQgqKim/OtyCra76K/noxW+gKoILngyE9ZdQ+hH5vj0BN0yrF9xXuZhOCgq5aZxFJo5VpHbws5ozoFaPo7uETKECVLW5Ynghko9+sGwpIp4vGxAIMugAMTcHqsHXHUZqzVwEp7VbajmQjTau9ZjhdaZnxbGJPLZcTfyL4Z/UAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719820353; c=relaxed/simple;
	bh=uYuviW0mbmzyDYYiyhfGUqzfieaPezKN9aobS9URRyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFGG7dy6WOH/i1PcZzmxQDGKYQbER3cuALeiaPGa91i/nzEE74vdfXqvYHMAgSSjQuiyIFryivbTcXXoHzAJpEMZIE8Q36nflfGvnFYbqAKtl+v+gM/HLMa3bTzKD/Qr0sNHNKUCU5Xlu5LJcpUDk92ySPR2hWKR1wG3Zo6m26s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4617pjuA064749;
	Mon, 1 Jul 2024 15:51:45 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WCJ5n0qV1z2KKCbl;
	Mon,  1 Jul 2024 15:46:53 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 1 Jul 2024 15:51:42 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <sunyibuaa@gmail.com>, <tj@kernel.org>, <jiangshanlai@gmail.com>,
        <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <ebiggers@google.com>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <kent.overstreet@linux.dev>,
        <niuzhiguo84@gmail.com>, <Hao_hao.Wang@unisoc.com>,
        <yunlongxing23@gmail.com>, <yi.sun@unisoc.com>
Subject: [PATCH v2 2/2] f2fs: set io priority for fsverity work
Date: Mon, 1 Jul 2024 15:51:38 +0800
Message-ID: <20240701075138.1144575-3-yi.sun@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701075138.1144575-1-yi.sun@unisoc.com>
References: <20240701075138.1144575-1-yi.sun@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 4617pjuA064749

The io priority of reading the original data of the verity-file
and reading hash blocks during verification should be consistent.

If the io priority is not set, when a high-task-priority process
reads the verity-file, the kworker's io priority may be too low,
resulting in delayed reading of hash blocks, which eventually
causes the high-task-priority process to response slowly.

Signed-off-by: Yi Sun <yi.sun@unisoc.com>
---
 fs/f2fs/data.c   | 17 ++++++++++-------
 fs/f2fs/f2fs.h   |  1 +
 fs/f2fs/verity.c |  5 +++++
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b9b0debc6b3d..7e8c56a3098b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -110,7 +110,7 @@ enum bio_post_read_step {
 struct bio_post_read_ctx {
 	struct bio *bio;
 	struct f2fs_sb_info *sbi;
-	struct work_struct work;
+	struct io_work iowork;
 	unsigned int enabled_steps;
 	/*
 	 * decompression_attempted keeps track of whether
@@ -168,10 +168,12 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 static void f2fs_verify_bio(struct work_struct *work)
 {
 	struct bio_post_read_ctx *ctx =
-		container_of(work, struct bio_post_read_ctx, work);
+		container_of(to_io_work(work), struct bio_post_read_ctx, iowork);
 	struct bio *bio = ctx->bio;
 	bool may_have_compressed_pages = (ctx->enabled_steps & STEP_DECOMPRESS);
 
+	may_adjust_io_work_task_ioprio(to_io_work(work));
+
 	/*
 	 * fsverity_verify_bio() may call readahead() again, and while verity
 	 * will be disabled for this, decryption and/or decompression may still
@@ -204,6 +206,7 @@ static void f2fs_verify_bio(struct work_struct *work)
 	}
 
 	f2fs_finish_read_bio(bio, true);
+	restore_io_work_task_ioprio(to_io_work(work));
 }
 
 /*
@@ -220,8 +223,8 @@ static void f2fs_verify_and_finish_bio(struct bio *bio, bool in_task)
 	struct bio_post_read_ctx *ctx = bio->bi_private;
 
 	if (ctx && (ctx->enabled_steps & STEP_VERITY)) {
-		INIT_WORK(&ctx->work, f2fs_verify_bio);
-		fsverity_enqueue_verify_work(&ctx->work);
+		INIT_IO_WORK(&ctx->iowork, f2fs_verify_bio);
+		f2fs_enqueue_verify_io_work(&ctx->iowork);
 	} else {
 		f2fs_finish_read_bio(bio, in_task);
 	}
@@ -270,7 +273,7 @@ static void f2fs_handle_step_decompress(struct bio_post_read_ctx *ctx,
 static void f2fs_post_read_work(struct work_struct *work)
 {
 	struct bio_post_read_ctx *ctx =
-		container_of(work, struct bio_post_read_ctx, work);
+		container_of(to_io_work(work), struct bio_post_read_ctx, iowork);
 	struct bio *bio = ctx->bio;
 
 	if ((ctx->enabled_steps & STEP_DECRYPT) && !fscrypt_decrypt_bio(bio)) {
@@ -313,8 +316,8 @@ static void f2fs_read_end_io(struct bio *bio)
 				!f2fs_low_mem_mode(sbi)) {
 			f2fs_handle_step_decompress(ctx, intask);
 		} else if (enabled_steps) {
-			INIT_WORK(&ctx->work, f2fs_post_read_work);
-			queue_work(ctx->sbi->post_read_wq, &ctx->work);
+			INIT_IO_WORK(&ctx->iowork, f2fs_post_read_work);
+			queue_io_work(ctx->sbi->post_read_wq, &ctx->iowork);
 			return;
 		}
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1974b6aff397..dc228c50ed30 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4234,6 +4234,7 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi);
 
 /* verity.c */
 extern const struct fsverity_operations f2fs_verityops;
+void f2fs_enqueue_verify_io_work(struct io_work *iowork);
 
 /*
  * crypto support
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index f7bb0c54502c..fba6aecba9b6 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -292,3 +292,8 @@ const struct fsverity_operations f2fs_verityops = {
 	.read_merkle_tree_page	= f2fs_read_merkle_tree_page,
 	.write_merkle_tree_block = f2fs_write_merkle_tree_block,
 };
+
+void f2fs_enqueue_verify_io_work(struct io_work *iowork)
+{
+	fsverity_enqueue_verify_work(&(iowork->work));
+}
-- 
2.25.1


