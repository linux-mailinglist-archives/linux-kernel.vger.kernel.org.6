Return-Path: <linux-kernel+bounces-567347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D2DA684DA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1837177355
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF0724EF99;
	Wed, 19 Mar 2025 06:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="fEboSbYv"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE32B24EF6A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364807; cv=none; b=EL7vPUDZy0ocIrbMWLJQNAdrB+GPXYDSO78RlVq2YCVzjdXu4Sgfz6HJ6+lwwV4YmCEhoZ5WssbbA2Qn5VEg4EzHHmzKR0MO7RQStcsaxoT0FqRKQd7z2shcf6TuLBGWDddHZ76RdxjtLC8gde6cqtRw7DwTmuE0g/NrIDInvew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364807; c=relaxed/simple;
	bh=JVp+R6surQiovwaIKFttfDz3Q9gl45zG0j+0tsq2SxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQDgJOpteO3W7pbBknLFQgie5qLOf6097f9LuwS1Vzpzo8eMhWbXCEc1EG2MC/uFsJVDdm92lNWHDneCRzLWrtCBRyQ/dhH+0TFVVAN/GkKzMZA93/+/PRa2p3EuwJUhRnNut+nRhXMhJmwU+7uCmmWqa45EsHOYMVcDxPwSPh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=fEboSbYv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2264aefc45dso8115575ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 23:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742364805; x=1742969605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyIfb3cMQmkLjGyXRr92VgXsWIyWeZB1/LvhfHHV0+U=;
        b=fEboSbYvK3DqpXzh6LNl3Lxfd6ZPFxFSe17ToWPrgX8+nNgqy4FRILf7NCFrWjRuaF
         nvbdJH4r5f9Xf2ezMeBZaJBkMhRiVYMx9zqJLn4pBcub9vPTQYsI7OCSOiSDgG9N6Ots
         IXX50nN41iOGJoZF0Z9VAMTqN9TFs1wCjqA9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742364805; x=1742969605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyIfb3cMQmkLjGyXRr92VgXsWIyWeZB1/LvhfHHV0+U=;
        b=A7eY4D4u9n80Tu7KISCTjRdNlcsbXnSViE0t9OUGB9/vqsmO19a6VSAw7Q7ORP/IuE
         +dUlJpNKHWpB9dZl3aFEqO3y5eat+euPSKE+m8ABVDChh5L7p2hY8qGJjvn5hi8Gkcwi
         HdbblVtmQyv+tbMRUVLQe6K3oLiQR+EHKucusRdnaTgUI+9Q+TggelHv4A/+y/KL/yv0
         ib45XMUp3byZiNM7eREDXpsmBg8b/vvAAumw2Spf1iQaZZAckW+/i7YxsSgAGhhCaCnw
         0NUr/hWP0v3pLuI4/aWHOyqEGYxw96c97ZQ5OqJidxyA7rVOjlfRiVs71ytX3d+4CV0I
         FzYw==
X-Forwarded-Encrypted: i=1; AJvYcCWAySJYEooVobwsA5Fnp/33CLEyVenZjao0fJBLloQsff2kpVNZJGpoK2eHj9Y/CR5hn0zeV+yNM4gYOv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpjNSAm61u9uYMWcPVKsds1CW51d9mF4ID8se7jn20nD/UsorS
	/Va0lJ8S5Xv2pro8d/+PgPvj0lowAVIzY0QpfJ2ypjlKG/O0WrJi5z94QhlWXCA=
X-Gm-Gg: ASbGncu7Mqqd51X8C92kEt1vwKxYgsERre9rtYrkewYsBgssvXeUi79q3V96nQ8cWsA
	yfG5UMFZ1WYdEjA/ciFSKsMXoCJa1DnnLE7sQM+ed5N1tTXg9Lzx5qR/GAmBm4TPxtCuaGpTKdf
	6aEiKjcCMsMhWPMw8aj1fU7SCWml8z3IeyZAArJVj0mJR1E9v6oeG4NOYZNEaCkXu4ECHHzXy0Q
	IaV3CGV9Z1wN46npu3GmFj1QaABxIkzmI15rZhifGYcHK4NGwImEFwKCwPg0yzxU7jL2MuzOJk+
	GM3tSfOeFQLyz/rGqNrYXjAKGdyWL4PW355cR1qxm+ngjRev2+X5ZUnU15+rAg4oxbeFaCavtBo
	sorof
X-Google-Smtp-Source: AGHT+IEma3OybcJ79OOz94lGu709GfcmPOvj0c+kXippDXOfifH1HLUbalNH0Kn2IST8s5E/XF5rbQ==
X-Received: by 2002:a17:902:f60d:b0:220:f449:7419 with SMTP id d9443c01a7336-2264982b1cemr26338635ad.7.1742364805268;
        Tue, 18 Mar 2025 23:13:25 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf589b07sm645103a91.11.2025.03.18.23.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 23:13:24 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [RFC PATCH v5 1/5] io_uring: rename the data cmd cache
Date: Wed, 19 Mar 2025 06:12:47 +0000
Message-ID: <20250319061251.21452-2-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319061251.21452-1-sidong.yang@furiosa.ai>
References: <20250319061251.21452-1-sidong.yang@furiosa.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

Pick a more descriptive name for the cmd async data cache.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/io_uring_types.h | 2 +-
 io_uring/io_uring.c            | 4 ++--
 io_uring/uring_cmd.c           | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 0e87e292bfb5..c17d2eedf478 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -318,7 +318,7 @@ struct io_ring_ctx {
 		struct io_alloc_cache	apoll_cache;
 		struct io_alloc_cache	netmsg_cache;
 		struct io_alloc_cache	rw_cache;
-		struct io_alloc_cache	uring_cache;
+		struct io_alloc_cache	cmd_cache;
 
 		/*
 		 * Any cancelable uring_cmd is added to this list in
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 5ff30a7092ed..7f26ad334e30 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -289,7 +289,7 @@ static void io_free_alloc_caches(struct io_ring_ctx *ctx)
 	io_alloc_cache_free(&ctx->apoll_cache, kfree);
 	io_alloc_cache_free(&ctx->netmsg_cache, io_netmsg_cache_free);
 	io_alloc_cache_free(&ctx->rw_cache, io_rw_cache_free);
-	io_alloc_cache_free(&ctx->uring_cache, kfree);
+	io_alloc_cache_free(&ctx->cmd_cache, kfree);
 	io_alloc_cache_free(&ctx->msg_cache, kfree);
 	io_futex_cache_free(ctx);
 	io_rsrc_cache_free(ctx);
@@ -334,7 +334,7 @@ static __cold struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	ret |= io_alloc_cache_init(&ctx->rw_cache, IO_ALLOC_CACHE_MAX,
 			    sizeof(struct io_async_rw),
 			    offsetof(struct io_async_rw, clear));
-	ret |= io_alloc_cache_init(&ctx->uring_cache, IO_ALLOC_CACHE_MAX,
+	ret |= io_alloc_cache_init(&ctx->cmd_cache, IO_ALLOC_CACHE_MAX,
 			    sizeof(struct io_uring_cmd_data), 0);
 	spin_lock_init(&ctx->msg_lock);
 	ret |= io_alloc_cache_init(&ctx->msg_cache, IO_ALLOC_CACHE_MAX,
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index de39b602aa82..792bd54851b1 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -28,7 +28,7 @@ static void io_req_uring_cleanup(struct io_kiocb *req, unsigned int issue_flags)
 
 	if (issue_flags & IO_URING_F_UNLOCKED)
 		return;
-	if (io_alloc_cache_put(&req->ctx->uring_cache, cache)) {
+	if (io_alloc_cache_put(&req->ctx->cmd_cache, cache)) {
 		ioucmd->sqe = NULL;
 		req->async_data = NULL;
 		req->flags &= ~REQ_F_ASYNC_DATA;
@@ -171,7 +171,7 @@ static int io_uring_cmd_prep_setup(struct io_kiocb *req,
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
 	struct io_uring_cmd_data *cache;
 
-	cache = io_uring_alloc_async_data(&req->ctx->uring_cache, req);
+	cache = io_uring_alloc_async_data(&req->ctx->cmd_cache, req);
 	if (!cache)
 		return -ENOMEM;
 	cache->op_data = NULL;
-- 
2.43.0


