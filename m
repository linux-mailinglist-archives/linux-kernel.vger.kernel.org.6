Return-Path: <linux-kernel+bounces-562677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4032DA630A3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 18:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A520D174B43
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 17:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D344E2054EF;
	Sat, 15 Mar 2025 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="XR+8w1xS"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7F1204697
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742059436; cv=none; b=UCLVuFhY7aEu7jAXSaRRk+HqKDc3GrHdNCtQ6prk8Kf/vmIn0gSnZOz3PkYKfw+9RINSYbhmv4epMuh3X1bHuSLYeefO2BhU9qiv3XTU4jM0HnfcwvIAgkqj41M5VwCVaUdz8j9DysQwzKeeQ8GeNXQlPOqW4E7wxKSsSQigV+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742059436; c=relaxed/simple;
	bh=+Xi783V5yc8Q0yTmbpRV6VJPJ52LNPvr+MMzKPRI0iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alaa38gbLsf1vOF/33X5aGqUPDKrgU3sEtWIGeDR9R9ulxzj6nAtP8uIxnXklhql1RgptFR0F3sCwnqWy6M5NxH1blYpv99yXXIpKHys3KIOLoIjdF//LKawpCp6H+Jp29CBCxJJwvVoTYLJ0rjUNNwYy9O15/7ZQCKpTSS75lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=XR+8w1xS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224100e9a5cso60212705ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 10:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1742059434; x=1742664234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fh1zT0Yh0Gu09Ze3QlJjUyNQbYt7kXIeCUqWyJ6HX1w=;
        b=XR+8w1xSZ52eEGgrsvjZlqmsHjiUdR0c/x4DVJ8n5ypBB/hcZ3XI387Lxzt5vdoZF2
         DK36pOavbUDmh4VUDlVvI4kNn+JZnYKKtcqUv9a3qVhbNydHKUDo8Gnjz5bOxu6mahVJ
         3W4j4s0eaXTpDAqdusMdiM1VQxwZ6eswUT2CFQvZDd3k/8DXftxPkKtE1ZyR24w8gr8A
         Mj8GFYc8gK7Gh2vQ95i9UASt0SYwDzBUD2cUzfiqh/aO35Zcb/AlXNQwj33MrbHEe2re
         NCI+jHZKBv8CgTETcTTiPSoNLLr3p/dxYtHJs1n3b/9wP8VhgSnHzJh3niEBqkqf2cY6
         0Mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742059434; x=1742664234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fh1zT0Yh0Gu09Ze3QlJjUyNQbYt7kXIeCUqWyJ6HX1w=;
        b=Fa4OKonTNTEzkOuz8aY104oG1SGitscj68120dX0uSrZwaHIg7a+NdUM0zHHX6zDdj
         S5q4r3n945y3AMRkCMHi5Ld6TrbvjPcmr30FvrEzt6tGSO/c7ks5S9nrxKVuD4JRhGjR
         7489RqH54a+1a1XBDZYCWgj0g5vTsTXam6PjLkdWnlcPP96XdTpmyVqNcIwK4ArxxsOh
         qqutMcd4/mmHVHdqegBqe7nz3pkUGzh93cK+bTHB+L8o+rPHlEKu6+WEeQqIAyYCFkKF
         cNz5csmHfIcgpro9HkNBkaJxLRHdMUDXr7z2oFivvBzupd8EXrXRF+cR6LnnvysjfI9W
         OOJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK4DC9k6j/JTF5AuI7N6m4s1Zbqgujxx+jF17E5r87INLfzLdLPc8ZF7AmF12Xmpt2VU/ty7le4gca3Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YycUIlTchDRUyr1lIF6aMCzL5bc5n4HJyYu6HtNRnIlLHIUl8b4
	zZGKlS7z1RsPvuCP/sBSxPPQdRr7vH8zRu0SAkeMZIMPi0wUxwu4OjCCappibJ8=
X-Gm-Gg: ASbGncuGzXSs0e62UQAGbmPoVG+MfkWorCljUJAn1cxcLcm6XK9BsDcJwK6fCKI9bty
	lyZMpgAQxKpbh9jS/lBQhFJjIKBCAKcUTGuIK32lOyj1ocVai6vPHopluLVVgfg8+us3bXDfjdw
	nKK20fgMSJDOUovUJQqooOSByarTz41FEditCN5IVyIbGT458Ddy9wDvcIQy6zjuXlgFqkCpwO0
	lyEXyxrczh+Wk/D/+DDs4PfiebDNdknoLKfljY/JF/gjBQINfZsXUngeuSf5f91lCHJt+5IFtRv
	MsS23nf7Dx3UvjP2KX3qUiTFUZLxiPO+z5PcTpP3dA==
X-Google-Smtp-Source: AGHT+IHVzljRXJY/9yHvuSK1uGGuyEVzklZ+ZTzun69UonS6hf3ZhgjvkDffUlPz2KkIuK8CrtWZQg==
X-Received: by 2002:a05:6a00:2d95:b0:736:4d44:8b77 with SMTP id d2e1a72fcca58-7372236edfbmr9792278b3a.8.1742059434023;
        Sat, 15 Mar 2025 10:23:54 -0700 (PDT)
Received: from sidong.. ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115512f0sm4673013b3a.49.2025.03.15.10.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 10:23:53 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v3 1/3] io-uring/cmd: add iou_vec field for io_uring_cmd
Date: Sat, 15 Mar 2025 17:23:17 +0000
Message-ID: <20250315172319.16770-2-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315172319.16770-1-sidong.yang@furiosa.ai>
References: <20250315172319.16770-1-sidong.yang@furiosa.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds iou_vec field for io_uring_cmd. Also it needs to be
cleanup for cache. It could be used in uring cmd api that imports
multiple fixed buffers.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 include/linux/io_uring/cmd.h |  1 +
 io_uring/io_uring.c          |  2 +-
 io_uring/opdef.c             |  1 +
 io_uring/uring_cmd.c         | 20 ++++++++++++++++++++
 io_uring/uring_cmd.h         |  3 +++
 5 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 598cacda4aa3..74b9f0aec229 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -22,6 +22,7 @@ struct io_uring_cmd {
 struct io_uring_cmd_data {
 	void			*op_data;
 	struct io_uring_sqe	sqes[2];
+	struct iou_vec		iou_vec;
 };
 
 static inline const void *io_uring_sqe_cmd(const struct io_uring_sqe *sqe)
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 5ff30a7092ed..55334fa53abf 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -289,7 +289,7 @@ static void io_free_alloc_caches(struct io_ring_ctx *ctx)
 	io_alloc_cache_free(&ctx->apoll_cache, kfree);
 	io_alloc_cache_free(&ctx->netmsg_cache, io_netmsg_cache_free);
 	io_alloc_cache_free(&ctx->rw_cache, io_rw_cache_free);
-	io_alloc_cache_free(&ctx->uring_cache, kfree);
+	io_alloc_cache_free(&ctx->uring_cache, io_cmd_cache_free);
 	io_alloc_cache_free(&ctx->msg_cache, kfree);
 	io_futex_cache_free(ctx);
 	io_rsrc_cache_free(ctx);
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index 7fd173197b1e..e275180c2077 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -755,6 +755,7 @@ const struct io_cold_def io_cold_defs[] = {
 	},
 	[IORING_OP_URING_CMD] = {
 		.name			= "URING_CMD",
+		.cleanup		= io_uring_cmd_cleanup,
 	},
 	[IORING_OP_SEND_ZC] = {
 		.name			= "SEND_ZC",
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index de39b602aa82..315c603cfdd4 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -28,6 +28,13 @@ static void io_req_uring_cleanup(struct io_kiocb *req, unsigned int issue_flags)
 
 	if (issue_flags & IO_URING_F_UNLOCKED)
 		return;
+
+	req->flags &= ~REQ_F_NEED_CLEANUP;
+
+	io_alloc_cache_vec_kasan(&cache->iou_vec);
+	if (cache->iou_vec.nr > IO_VEC_CACHE_SOFT_CAP)
+		io_vec_free(&cache->iou_vec);
+
 	if (io_alloc_cache_put(&req->ctx->uring_cache, cache)) {
 		ioucmd->sqe = NULL;
 		req->async_data = NULL;
@@ -35,6 +42,11 @@ static void io_req_uring_cleanup(struct io_kiocb *req, unsigned int issue_flags)
 	}
 }
 
+void io_uring_cmd_cleanup(struct io_kiocb *req)
+{
+	io_req_uring_cleanup(req, 0);
+}
+
 bool io_uring_try_cancel_uring_cmd(struct io_ring_ctx *ctx,
 				   struct io_uring_task *tctx, bool cancel_all)
 {
@@ -339,3 +351,11 @@ int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_sock);
 #endif
+
+void io_cmd_cache_free(const void *entry)
+{
+	struct io_uring_cmd_data *cache = (struct io_uring_cmd_data *)entry;
+
+	io_vec_free(&cache->iou_vec);
+	kfree(cache);
+}
diff --git a/io_uring/uring_cmd.h b/io_uring/uring_cmd.h
index f6837ee0955b..d2b9c1522e22 100644
--- a/io_uring/uring_cmd.h
+++ b/io_uring/uring_cmd.h
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/io_uring_types.h>
 
 int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags);
 int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+void io_uring_cmd_cleanup(struct io_kiocb *req);
 
 bool io_uring_try_cancel_uring_cmd(struct io_ring_ctx *ctx,
 				   struct io_uring_task *tctx, bool cancel_all);
+void io_cmd_cache_free(const void *entry);
-- 
2.43.0


