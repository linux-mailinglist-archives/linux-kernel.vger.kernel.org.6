Return-Path: <linux-kernel+bounces-567348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91522A684DD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3C81898D9E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990C72505A7;
	Wed, 19 Mar 2025 06:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="J9ry71SE"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C9024FBE7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364810; cv=none; b=OOHYUuTXmHVNJPNNn9lSTK21CbUoAIiwTLDXOfVuIvHMNf3dht6Te4Kg9M0VgEw1WQr2kaBjaB2Y3rAEyJSAR/OaboFNyuDWyRbqtWAjNRaIWwDSwQVsP0h5Ps6UFx0kYdXW6rGgxRi/5TO+cwDz+2tE2b2Nb8pSu7wqRX6I86Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364810; c=relaxed/simple;
	bh=0IdlGsxiHlOpfB3LWKjSS9hQhoWmXtFYaCxPr3UzbE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVLkD0WOfAh1GhxQmR6r15GOOVolQClnV86LDVJZUkjRdIcH9IcfquxsO+fDMhVd3X1xL8Ok89UfANKzl1qIyoCzZXEXLc/B8i/+QV8joFJzqFkieFmoPt2NmOFG0ZpF+nzLfH+52OZhxaOMbBXEscLYTSjG6D2dg4puN//2ilk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=J9ry71SE; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff6ae7667dso8259955a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 23:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742364808; x=1742969608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AbNriybkAMg6arWdOZVqfylWfhbFH3phG3S4HFDKww=;
        b=J9ry71SEuiDmw14IQk1Pmk3yFRI/2xqN08SBlv2P7vavGHbPvfsCoQ3mppUNWoEU98
         uJcVAvo6tWr7O3f5pvtIX0tprFetwrArPBbROR/OosdWgNpgS1Yv4bXvhHM4KJ5+UWl7
         dDV5SF4cK/u3Mumby9/dlmrz96fN+5c7t6hqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742364808; x=1742969608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AbNriybkAMg6arWdOZVqfylWfhbFH3phG3S4HFDKww=;
        b=rr1e91vjzd2hu9Vf9wmUxwuomVYVeqN7cVg/tjZwhLK6JvJZZYzhq+8SfrM49tZ75p
         Uk/tDalmUy+Qg2eTgr/EFuTxIC5KLd73wf8L460XAcaxyNw2qOPcQkyS8UB1y2BQRkzD
         w3bQM3ubq29tM6CwqJonSlvbACI1+hzYkAi0MLXhzgIq+hUCDayhVOcSWddK5cpozcQn
         1pjVAL5tNcZloSAvnhzwu261yPMri42lP33hnF6TU1SvC0abXpCJGOa5pjWlDfbiErSv
         lbBVe3lJfTtQJ1KDzK2X5gu+XFG96rtESDUjGuTeAHDLIMq5flV3iWyeK7+Qyd+3c8Qt
         m7vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzsHu2auNj17XoJ15AIxH9OoUBje0UiPsrJPIsmsDFaCqWrcyKbmTdkFP3aSgbUHJcdw32PZ5LEPbxlko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6PXcXAPwqJezQqajzGhQJ7nhnSUlhxRXtziMVkDo2r0HMlnfz
	M/6l9obPxk8HCrPYfeCSbndn6gbS/SKJOZaCS9fmT29xJAgsABbxjYQMH5qTkHE=
X-Gm-Gg: ASbGnctOI2HkmHgqsFyKaEFSCtgovnNF/ztPRG/Bo0rIAL3aJQqJX3lrskvFC/oSb5G
	Zj3fps8QUVil3olNc17IESFSLo94ean7Sx1jkH+SdLV6PkW1n8oqPZEvvjvXVnW1mUGInbW8Nox
	SujN0h23OADsG9C04ug8xflxo9dTG/pPHuO2ppDBw9xHtKa8B8j897YJM4lYUlFEEdG0DLVMrMi
	VEVzK1A9MLDYLaXpTKaK02IkR8beOeO7ztLK8o3hxiZxhwgLMBkEeOdtWY/qmrTIPE7ImRKZKsz
	LeowLI6VTmpjF0f3Q/1aWfuDqm9YpWIrNo8b+GzHjNe09j+NzLt0gfDllbuepQpUfqRr2n5/rBb
	LaKDN
X-Google-Smtp-Source: AGHT+IGXSqzU8y1cmSTygGM2aLfIYSj2l7hrJ3dPPrIwTZ/TmZGV+LoRrdcJncNf2fekVNIFT5waog==
X-Received: by 2002:a17:90b:390e:b0:2fe:b8ba:62de with SMTP id 98e67ed59e1d1-301be1f8ecdmr2258008a91.25.1742364807891;
        Tue, 18 Mar 2025 23:13:27 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf589b07sm645103a91.11.2025.03.18.23.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 23:13:27 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [RFC PATCH v5 2/5] io_uring/cmd: don't expose entire cmd async data
Date: Wed, 19 Mar 2025 06:12:48 +0000
Message-ID: <20250319061251.21452-3-sidong.yang@furiosa.ai>
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

io_uring needs private bits in cmd's ->async_data, and they should never
be exposed to drivers as it'd certainly be abused. Leave struct
io_uring_cmd_data for the drivers but wrap it into a structure. It's a
prep patch and doesn't do anything useful yet.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/io_uring.c  |  2 +-
 io_uring/opdef.c     |  2 +-
 io_uring/uring_cmd.c | 18 +++++++++++-------
 io_uring/uring_cmd.h |  6 ++++++
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 7f26ad334e30..5eb9be063a7c 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -335,7 +335,7 @@ static __cold struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 			    sizeof(struct io_async_rw),
 			    offsetof(struct io_async_rw, clear));
 	ret |= io_alloc_cache_init(&ctx->cmd_cache, IO_ALLOC_CACHE_MAX,
-			    sizeof(struct io_uring_cmd_data), 0);
+			    sizeof(struct io_async_cmd), 0);
 	spin_lock_init(&ctx->msg_lock);
 	ret |= io_alloc_cache_init(&ctx->msg_cache, IO_ALLOC_CACHE_MAX,
 			    sizeof(struct io_kiocb), 0);
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index 7fd173197b1e..e4aa61a414fb 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -416,7 +416,7 @@ const struct io_issue_def io_issue_defs[] = {
 		.plug			= 1,
 		.iopoll			= 1,
 		.iopoll_queue		= 1,
-		.async_size		= sizeof(struct io_uring_cmd_data),
+		.async_size		= sizeof(struct io_async_cmd),
 		.prep			= io_uring_cmd_prep,
 		.issue			= io_uring_cmd,
 	},
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 792bd54851b1..7c126ee497ea 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -19,7 +19,8 @@
 static void io_req_uring_cleanup(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
-	struct io_uring_cmd_data *cache = req->async_data;
+	struct io_async_cmd *ac = req->async_data;
+	struct io_uring_cmd_data *cache = &ac->data;
 
 	if (cache->op_data) {
 		kfree(cache->op_data);
@@ -169,12 +170,15 @@ static int io_uring_cmd_prep_setup(struct io_kiocb *req,
 				   const struct io_uring_sqe *sqe)
 {
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
-	struct io_uring_cmd_data *cache;
+	struct io_async_cmd *ac;
 
-	cache = io_uring_alloc_async_data(&req->ctx->cmd_cache, req);
-	if (!cache)
+	/* see io_uring_cmd_get_async_data() */
+	BUILD_BUG_ON(offsetof(struct io_async_cmd, data) != 0);
+
+	ac = io_uring_alloc_async_data(&req->ctx->cmd_cache, req);
+	if (!ac)
 		return -ENOMEM;
-	cache->op_data = NULL;
+	ac->data.op_data = NULL;
 
 	/*
 	 * Unconditionally cache the SQE for now - this is only needed for
@@ -183,8 +187,8 @@ static int io_uring_cmd_prep_setup(struct io_kiocb *req,
 	 * that it doesn't read in per-op data, play it safe and ensure that
 	 * any SQE data is stable beyond prep. This can later get relaxed.
 	 */
-	memcpy(cache->sqes, sqe, uring_sqe_size(req->ctx));
-	ioucmd->sqe = cache->sqes;
+	memcpy(ac->data.sqes, sqe, uring_sqe_size(req->ctx));
+	ioucmd->sqe = ac->data.sqes;
 	return 0;
 }
 
diff --git a/io_uring/uring_cmd.h b/io_uring/uring_cmd.h
index f6837ee0955b..2ec3a8785534 100644
--- a/io_uring/uring_cmd.h
+++ b/io_uring/uring_cmd.h
@@ -1,5 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/io_uring/cmd.h>
+
+struct io_async_cmd {
+	struct io_uring_cmd_data	data;
+};
+
 int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags);
 int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 
-- 
2.43.0


