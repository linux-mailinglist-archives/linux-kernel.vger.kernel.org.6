Return-Path: <linux-kernel+bounces-516920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CDBA379B8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 03:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109613AB65E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 02:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8E9149C50;
	Mon, 17 Feb 2025 02:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="e7h0Q7f1"
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E41D137C35
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739759125; cv=none; b=RQhn3T5XlvL10MCgyKdcz5ERmzxTkQ1GRXr4hErzHhyAjpHF7wZc5HsK1Mz2GADIcf806rryhPUvyAZJApugYZhzVNO9T9fWBenXjcHtTyYIix+KqntljVhFtbTtRmr6Vf4fDYVuB6goNwDfSr4e9u58jOL+2faFDGsAA8ZRR2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739759125; c=relaxed/simple;
	bh=EDF1mLpZnKixZ2LaEVHcTAJuNofPtT8jfotSQ6uez98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PC/whBzzO2Iz3m5tQdP+hByDKNMH55EQyiYaUDDXuTsQ4Seec9e63R85Sn9yWaZV9pFCgGLSQdDrtYVprb/e7OjD/9XrgA5lyi9F2n1q59UAzjsmb6okjihOt32ZqUdmqvMBSbjGS3hXLnyKZVM8piu5rr0V6lbdRbFyGJA6ke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=e7h0Q7f1; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2166db59927so8189665ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 18:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739759122; x=1740363922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cV8KF8qaFzs62qdnYTcs/QJIwRQD1ECME1HlHCY19cA=;
        b=e7h0Q7f1g5VvA4OZprcSvOrnzetQlkAUwFDNVKyh0MyKMKKaPDv37oE5EUxOJpbyuq
         laMQV/KAXM4gkMAkhyJeaJCYwqmDhZjqYB3yypGodkwHMM53+RlqEOvKgq0aDhByxUib
         5DRNz2GP3VV1hhmlne1Ec11fkpz83j2l3FuFOg07k4PKo4gnmFqmp5D1lFA3td4PDEoV
         rTZbxo/fn5fwyWVy6FUwXmgVhWRZSZWyrTfS9QE2jQ+TxFugesUJEawGEiCHPbobrgjy
         snpC5sngu0aSVRhmS9O8V/ACmRN1sXiXK8CevPDS5YLHhhdbDmOzRC7J7XpB4pOYoC3u
         T5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739759122; x=1740363922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cV8KF8qaFzs62qdnYTcs/QJIwRQD1ECME1HlHCY19cA=;
        b=TraLuhoJ+i9L40iQ7xH8wcHRS/weRwZL39Jdh/WX4GJ6FY7mMmd5NtM6qNevXrC0rH
         P5USuAsRAVdb8yTZ7IXCnZj/5waQbyTSLCbH2qDGmKhuG9JCEB/5e9Gcs25n/nmq0e/A
         GiOKTwzh/dvHhzyLRXaMjzJ61cm4EKSzDdz7cWvRtcFrb8ouWQw3kpZ9P19FtzMhWLzE
         yEdPD/oA+06dXejm7CaRaJaDdUJ8ZCSOD32Nwyn/WcM7Q6dgSgy2CfEq5hbh6uL+ufpZ
         POuSMO5FeyGNeCRkmBlLZ8YemY1Bqy6e09M6IeAT51ilEHJvITsnWal51ez8KR7hwTU5
         PljQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxSL4Cdis1SQ9nO1HST8HheCu68HZh1OKb2kgCidBhZr4ZjRw+GcCKfD8FY1xxPNziS9mvqwSF/p6W0vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf/hTKc4NLXEW9Ni1O/rgiYL3euhuUr1oGlfM5YBoBqJ/bw5gM
	iu3acCqEDDpK+vPldNrOdPK+nxorAbHcDjI8+zgOyS5BJeOreGYPY8Ip2UQ/5xV0CEr6bStRCeH
	e2nzwowbUtge2s1bYFIJkTpfX0MEsdTXe
X-Gm-Gg: ASbGncsPmcU/N9xVqaTlz6KcQ8LYtr+b6DfIAgLE0c2+alqwqml5mHqq5ebz8gxsbLF
	HcWfzrqrgyh6sZwD9BDaeqW0IDEdTMCIJ2YyB4v+IHJw7sxqNF8UkJ2gegutJM5T5csA9aUtSa+
	zQTxCggz9U25Br/t6VCwfCPimqUCrqIhwxyCYr+rhF2OR4Nq2Cfi3W10cHreBYH7k5xi3q75F9U
	7YOASv/rSqte6qA2y/WhoNctTBfh92Re1uCu+nFAZskM2aEAlwW+KYBQbSkZEl46hUisBf4DdcV
	pkJUbyC+qezZawQgCagxEgmiE2RpU4jeFjVEEA==
X-Google-Smtp-Source: AGHT+IEKCMCkhM5WhrnH6WOewUNqSORHwM23M/WC83Uv0LnJ5Eb5pS9rtACXinquevKSIuMWt2BJXgadL+B6
X-Received: by 2002:a05:6a21:33a9:b0:1d9:ddf:b092 with SMTP id adf61e73a8af0-1ee8cc0675dmr5691268637.11.1739759122476;
        Sun, 16 Feb 2025 18:25:22 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-73264f6195fsm311855b3a.4.2025.02.16.18.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 18:25:22 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E38C2340357;
	Sun, 16 Feb 2025 19:25:21 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E1895E4155E; Sun, 16 Feb 2025 19:25:21 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] io_uring: pass struct io_tw_state by value
Date: Sun, 16 Feb 2025 19:25:05 -0700
Message-ID: <20250217022511.1150145-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250217022511.1150145-1-csander@purestorage.com>
References: <20250217022511.1150145-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

8e5b3b89ecaf ("io_uring: remove struct io_tw_state::locked") removed the
only field of io_tw_state but kept it as a task work callback argument
to "forc[e] users not to invoke them carelessly out of a wrong context".
Passing the struct io_tw_state * argument adds a few instructions to all
callers that can't inline the functions and see the argument is unused.

So pass struct io_tw_state by value instead. Since it's a 0-sized value,
it can be passed without any instructions needed to initialize it.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/io_uring_types.h |  2 +-
 io_uring/io_uring.c            | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index ea4694ee9d19..123e69368730 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -442,11 +442,11 @@ struct io_ring_ctx {
  * ONLY core io_uring.c should instantiate this struct.
  */
 struct io_tw_state {
 };
 /* Alias to use in code that doesn't instantiate struct io_tw_state */
-typedef struct io_tw_state *io_tw_token_t;
+typedef struct io_tw_state io_tw_token_t;
 
 enum {
 	REQ_F_FIXED_FILE_BIT	= IOSQE_FIXED_FILE_BIT,
 	REQ_F_IO_DRAIN_BIT	= IOSQE_IO_DRAIN_BIT,
 	REQ_F_LINK_BIT		= IOSQE_IO_LINK_BIT,
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index b44ff8871725..b688953d1de8 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -253,11 +253,11 @@ static __cold void io_fallback_req_func(struct work_struct *work)
 	struct io_tw_state ts = {};
 
 	percpu_ref_get(&ctx->refs);
 	mutex_lock(&ctx->uring_lock);
 	llist_for_each_entry_safe(req, tmp, node, io_task_work.node)
-		req->io_task_work.func(req, &ts);
+		req->io_task_work.func(req, ts);
 	io_submit_flush_completions(ctx);
 	mutex_unlock(&ctx->uring_lock);
 	percpu_ref_put(&ctx->refs);
 }
 
@@ -1050,28 +1050,28 @@ struct llist_node *io_handle_tw_list(struct llist_node *node,
 		struct llist_node *next = node->next;
 		struct io_kiocb *req = container_of(node, struct io_kiocb,
 						    io_task_work.node);
 
 		if (req->ctx != ctx) {
-			ctx_flush_and_put(ctx, &ts);
+			ctx_flush_and_put(ctx, ts);
 			ctx = req->ctx;
 			mutex_lock(&ctx->uring_lock);
 			percpu_ref_get(&ctx->refs);
 		}
 		INDIRECT_CALL_2(req->io_task_work.func,
 				io_poll_task_func, io_req_rw_complete,
-				req, &ts);
+				req, ts);
 		node = next;
 		(*count)++;
 		if (unlikely(need_resched())) {
-			ctx_flush_and_put(ctx, &ts);
+			ctx_flush_and_put(ctx, ts);
 			ctx = NULL;
 			cond_resched();
 		}
 	} while (node && *count < max_entries);
 
-	ctx_flush_and_put(ctx, &ts);
+	ctx_flush_and_put(ctx, ts);
 	return node;
 }
 
 static __cold void __io_fallback_tw(struct llist_node *node, bool sync)
 {
@@ -1339,22 +1339,22 @@ static inline int io_run_local_work_locked(struct io_ring_ctx *ctx,
 {
 	struct io_tw_state ts = {};
 
 	if (!io_local_work_pending(ctx))
 		return 0;
-	return __io_run_local_work(ctx, &ts, min_events,
+	return __io_run_local_work(ctx, ts, min_events,
 					max(IO_LOCAL_TW_DEFAULT_MAX, min_events));
 }
 
 static int io_run_local_work(struct io_ring_ctx *ctx, int min_events,
 			     int max_events)
 {
 	struct io_tw_state ts = {};
 	int ret;
 
 	mutex_lock(&ctx->uring_lock);
-	ret = __io_run_local_work(ctx, &ts, min_events, max_events);
+	ret = __io_run_local_work(ctx, ts, min_events, max_events);
 	mutex_unlock(&ctx->uring_lock);
 	return ret;
 }
 
 static void io_req_task_cancel(struct io_kiocb *req, io_tw_token_t tw)
-- 
2.45.2


