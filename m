Return-Path: <linux-kernel+bounces-545493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B405A4EDC9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10DE3A5F72
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610B125D552;
	Tue,  4 Mar 2025 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="F1vOBcGN"
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBC424EAB4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117728; cv=none; b=BNO7jVvK5ZFMfmqtN0Eka1+qONNjvm4NsY8mLZS4T/vdT0ZOvAdUsdRnbMD3/F1VBsm1i/4awJ2khN8ZjlQO7vBRb/ZSUDm9AdLTU9RsqhJdyPi5S67x1DiHa2OVccEvs9ODyjD/cIn03LdjxehE0u/ybFOokeaMRAC0z6vG9gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117728; c=relaxed/simple;
	bh=U7RK7zT79MVlCj/w2IYbO/iMQiwCr9vkz1Pab+1t88E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eRk8SDIzG5ZzCjirTBQHRmDYULFQBIf/1mPfxVIHCM6T4rexSRp0F/R8JCWW8PSeL/s+ItTMqKQGlKds5DIDZEGylg+C2F5rDJssEYMObPVdea/RNTntHGAhf2zkD6KmimOLivAxEX1K9Ud3LyayH9e03c1ySsuZCnrJDmt3Frc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=F1vOBcGN; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-3d285c2a242so1519595ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 11:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1741117725; x=1741722525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Io/XTa/jSTok/cOQAf7shKW/Y71+MJlJ2IZz8P0siY=;
        b=F1vOBcGNs2z47wDLEGyRAGk8v+MXZuqexHFXxPIk4bb1FuIOIGZulllU1mqTpJQzO5
         AmPi8gloIExMcbtpxFbXMfPKcIXAaZ87FDpbi9XxR8FBLw6XUdCKyAtpouSnhledCvJR
         nEE2uuBLpUYsUuyzWFkVAt/OENRjuvW7M4D7yZVUe2XRMWEP5NmiDrC0CFf105QtlZC/
         QwNormDSLoSOVTeEFqYfywEdpya0FyUH6Fl/LFlb+l3RF5f3Kfo5cA7n8WQNqsbaHDkb
         Z+8CMCFBnY5VUBxwXmqq82lz+qsF9+4XXukYrID5DlqXuQIZl7kgUnHDeA+Z7kpCaMOX
         Grdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741117725; x=1741722525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Io/XTa/jSTok/cOQAf7shKW/Y71+MJlJ2IZz8P0siY=;
        b=sHG5Q9uSXt0NKV7Bxdnzw/Fy2mnPpxyDcYJQh/G8PKO3woSLinLW9AhyPzRGrdfrTL
         Vq8oRCTkKMeX6oVjT1TA3alJSh6kCxdAeDkFmNIn07b63A66YiO/GgXw+IUQotxtA8eY
         Yye9iAUoZYKrTsrkXcFfVBGeJZITwj4DRH/EiP8GhWu5giiaaC41rrwKu9ADvB9dJuew
         CWH2SkXAy2EP9CK3GVO8tjIqqJ90CKEc8U+ZyohhKywm5q6aT2WPJVd796M4tWqE+A5z
         sRqIUKonBxUCTrk3l39gSjdeI4QQUjc+n99/7L4VWWGtE071Wh0Lmung/2uls/DcTHJD
         xS7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYEFIRvDE4EoX+g4EFi+Lv53/G8IHJ1lbjFmQ2+V4azQ9OQuI+1h2ByIiw8iCOQdwU+cl1a17EJrdnFVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFsQ03r+g+IxIxavUD9krXSSNimlp5NJKhtvRcAzZRdZBkjUIJ
	GDYwh0nrtLm4iSAg69/rkq5vB9SLuLpNgh0l5+LrnLZYDIXFenWWbkr12VyH46P1OKC8qQ+5UOY
	rifrmA3UNijpwBeReDDgxeE4cK3a41bavI7HoIgu1Nk/oci02
X-Gm-Gg: ASbGnctmHt9/ejTbEggBsTtzVSGwgCN0YGawb/ypmlG3HfvUXW9bVai32vk1On6LaAO
	nkwS5z346Lk0NJcsL5uc5XVHiSuhnzfMcTGolc91T7rOmV08hiClpiBPHi6YB6NHc3W9mFpgmbT
	hgbPnEOBJQAlHPjxd4NHBd26iuNxwSXgabeezK1cna8JX3/dCxZHte6Rv13NAQePNDauIqSVlMI
	XcQAAJ9Rs+KLhCMCcbdiM5cBOvnW8MoaRIX17sh/sxzoCJcn5uP67oHWogcSWNfJUYlTilo6nFh
	shtqz6SZ8Ntv+yqJhzKJGHRV45rBrfafKA==
X-Google-Smtp-Source: AGHT+IFKuz4LulLuhFyx2WplI30Kx5BbBsbJ5lWU9pZ5K4JINKqZTrTqblw0OAPyvNHbkeASBfFYGZsS5pnj
X-Received: by 2002:a05:6e02:1c8e:b0:3d3:dcd5:cde5 with SMTP id e9e14a558f8ab-3d42b96eaaemr1812915ab.4.1741117725615;
        Tue, 04 Mar 2025 11:48:45 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d3f6081093sm4142685ab.54.2025.03.04.11.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 11:48:45 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 81F5E34039C;
	Tue,  4 Mar 2025 12:48:44 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 787BAE41B75; Tue,  4 Mar 2025 12:48:14 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring: introduce io_cache_free() helper
Date: Tue,  4 Mar 2025 12:48:12 -0700
Message-ID: <20250304194814.2346705-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper function io_cache_free() that returns an allocation to a
io_alloc_cache, falling back on kfree() if the io_alloc_cache is full.
This is the inverse of io_cache_alloc(), which takes an allocation from
an io_alloc_cache and falls back on kmalloc() if the cache is empty.

Convert 4 callers to use the helper.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Suggested-by: Li Zetao <lizetao1@huawei.com>
---
 io_uring/alloc_cache.h |  6 ++++++
 io_uring/futex.c       |  4 +---
 io_uring/io_uring.c    |  3 +--
 io_uring/rsrc.c        | 15 +++++----------
 4 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/io_uring/alloc_cache.h b/io_uring/alloc_cache.h
index 0dd17d8ba93a..7f68eff2e7f3 100644
--- a/io_uring/alloc_cache.h
+++ b/io_uring/alloc_cache.h
@@ -66,6 +66,12 @@ static inline void *io_cache_alloc(struct io_alloc_cache *cache, gfp_t gfp)
 	if (obj)
 		return obj;
 	return io_cache_alloc_new(cache, gfp);
 }
 
+static inline void io_cache_free(struct io_alloc_cache *cache, void *obj)
+{
+	if (!io_alloc_cache_put(cache, obj))
+		kfree(obj);
+}
+
 #endif
diff --git a/io_uring/futex.c b/io_uring/futex.c
index b7581766406c..0ea4820cd8ff 100644
--- a/io_uring/futex.c
+++ b/io_uring/futex.c
@@ -51,16 +51,14 @@ static void __io_futex_complete(struct io_kiocb *req, io_tw_token_t tw)
 	io_req_task_complete(req, tw);
 }
 
 static void io_futex_complete(struct io_kiocb *req, io_tw_token_t tw)
 {
-	struct io_futex_data *ifd = req->async_data;
 	struct io_ring_ctx *ctx = req->ctx;
 
 	io_tw_lock(ctx, tw);
-	if (!io_alloc_cache_put(&ctx->futex_cache, ifd))
-		kfree(ifd);
+	io_cache_free(&ctx->futex_cache, req->async_data);
 	__io_futex_complete(req, tw);
 }
 
 static void io_futexv_complete(struct io_kiocb *req, io_tw_token_t tw)
 {
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ccc343f61a57..58003fa6b327 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1420,12 +1420,11 @@ static void io_free_batch_list(struct io_ring_ctx *ctx,
 			if ((req->flags & REQ_F_POLLED) && req->apoll) {
 				struct async_poll *apoll = req->apoll;
 
 				if (apoll->double_poll)
 					kfree(apoll->double_poll);
-				if (!io_alloc_cache_put(&ctx->apoll_cache, apoll))
-					kfree(apoll);
+				io_cache_free(&ctx->apoll_cache, apoll);
 				req->flags &= ~REQ_F_POLLED;
 			}
 			if (req->flags & IO_REQ_LINK_FLAGS)
 				io_queue_next(req);
 			if (unlikely(req->flags & IO_REQ_CLEAN_FLAGS))
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 3fb1bd616eef..5dd1e0827559 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -122,12 +122,13 @@ static struct io_mapped_ubuf *io_alloc_imu(struct io_ring_ctx *ctx,
 			GFP_KERNEL);
 }
 
 static void io_free_imu(struct io_ring_ctx *ctx, struct io_mapped_ubuf *imu)
 {
-	if (imu->nr_bvecs > IO_CACHED_BVECS_SEGS ||
-	    !io_alloc_cache_put(&ctx->imu_cache, imu))
+	if (imu->nr_bvecs <= IO_CACHED_BVECS_SEGS)
+		io_cache_free(&ctx->imu_cache, imu);
+	else
 		kvfree(imu);
 }
 
 static void io_buffer_unmap(struct io_ring_ctx *ctx, struct io_mapped_ubuf *imu)
 {
@@ -485,16 +486,10 @@ int io_files_update(struct io_kiocb *req, unsigned int issue_flags)
 		req_set_fail(req);
 	io_req_set_res(req, ret, 0);
 	return IOU_OK;
 }
 
-static void io_free_node(struct io_ring_ctx *ctx, struct io_rsrc_node *node)
-{
-	if (!io_alloc_cache_put(&ctx->node_cache, node))
-		kfree(node);
-}
-
 void io_free_rsrc_node(struct io_ring_ctx *ctx, struct io_rsrc_node *node)
 {
 	if (node->tag)
 		io_post_aux_cqe(ctx, node->tag, 0, 0);
 
@@ -508,11 +503,11 @@ void io_free_rsrc_node(struct io_ring_ctx *ctx, struct io_rsrc_node *node)
 	default:
 		WARN_ON_ONCE(1);
 		break;
 	}
 
-	io_free_node(ctx, node);
+	io_cache_free(&ctx->node_cache, node);
 }
 
 int io_sqe_files_unregister(struct io_ring_ctx *ctx)
 {
 	if (!ctx->file_table.data.nr)
@@ -833,11 +828,11 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	}
 done:
 	if (ret) {
 		if (imu)
 			io_free_imu(ctx, imu);
-		io_free_node(ctx, node);
+		io_cache_free(&ctx->node_cache, node);
 		node = ERR_PTR(ret);
 	}
 	kvfree(pages);
 	return node;
 }
-- 
2.45.2


