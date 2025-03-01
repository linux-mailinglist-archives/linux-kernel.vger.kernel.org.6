Return-Path: <linux-kernel+bounces-539617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D348CA4A68D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A73618914C9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E741DF25C;
	Fri, 28 Feb 2025 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ClO6Qt1+"
Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB701DED69
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740784477; cv=none; b=kHi64cupP5a9QdUUOD7sooJRx083+r5t3bC43LOcNtI3n5Y0pLj8VoVkpQec1dDaB9LTnzn/HSYVjT+8XN4DkDRMNg6+pU10x85FwkEApFx2ZBNzwBtCDZ6oCOQZ/WG9njkVij/a/4R+RWieoG8GO8fY3Fedf5q3pngyDZpGfik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740784477; c=relaxed/simple;
	bh=sXf5/A1zFytM8lFmj2gEeV5EMeYDWOAN3JXS2CuB0z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cu6Xh5F/S40vpKFZ69uR7mbGgQQJ/PdpbIiacgeq2zamjOhcQC8ju93aLHS9U1MEm/TOohQ42LkVxqU6TpI4U6IkHB4zx2pU5OlRtvJqEPNhD/oxJ1wlKDl7iyD0V4eSEEm+oO9GtfkGDQV3gTv8ntc4Y5IJirAwQVPU3zFjr4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ClO6Qt1+; arc=none smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-72726a5db1aso267058a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740784475; x=1741389275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=td3QLI6VMDUiQOrb4BUroNuidyjitBQIjpVlt7JOrWo=;
        b=ClO6Qt1+RSnuk4+Sh77B2GRSKqwrpoxIB8lU93xNfEioWZ5F7VpXnqSOA1RnwLK5x8
         JlWypEp/n5tX4nhY74Khnv2DxyBH1DmgIiY6aPDXSvwJBqHk3muIvTy32NgfqNfBk7tQ
         rDnf6RpgI63X3ZHy4m/AGDBXRXq10e+vxtVD5zk8olEHbzw344TyNLQsokqvWgZPTioK
         ISuFymSEMelPwuM5SkAVNBgkJl8NaBjN7eWvXb6etFi+okXdSqQMsYtRxK+NFp1TVvfb
         j1kNMlgh+sFOXOs61oAbhCkxXy+fiuD7ATt1vy9Z0G0ZL1xqz+dYopPJAAl5CzPqaw0o
         MAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740784475; x=1741389275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=td3QLI6VMDUiQOrb4BUroNuidyjitBQIjpVlt7JOrWo=;
        b=jjDjLUVoNlQY2wrakY6WJlfi/kxrcet9JnA7NqvMFsoJF05Rb88V8uus+DnuQKd1GT
         UcUqmH6/cn1x9yD+WytpUAg71S8b42NWCwmGbS22ehFu/b/UpHufE0NRNbqIo0dyIydS
         c/aWCbiuj8r3RMrGxU0nEhwHoQTmZa4O01Gk5JluEJkod0pMzUAs+uC9I5dAReAwS/97
         ljiu17K9LfJHJRvqsC0+Jc4KfP7XcHWR+uWTJju0Sj8KHaqD0l6fB4sPjhilYbLpb7bM
         3qpIDSN3uboZTir0VQNP3kcoC7N7d8PYJLa0OnM7kmKpB1MxnfqAt040twZdXRmnINgj
         jFjA==
X-Forwarded-Encrypted: i=1; AJvYcCU4DBeeeAhk3NYcZcYle5ceF7H7Sy5KpwIXayf77uA1hjo7mJZ9zrlofFuJ7GV2+DEIu2Qp6SRcYFgWZWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ZI7zUhW7/1xUlT6eg6KMMHTH0QL/0uHNJhJUC/Ty1LvwxDnu
	AmNqoyGOr9LlWj3ShyKQffow+grrQV8AWRrxwwZ/fJ7OZgjjxGsQKAXRsMpuCl0i/QX1DFdjsig
	0dMg3lUv573y+gY7x9UVHpYnuulrkUULbWuItos27/zCMa7vI
X-Gm-Gg: ASbGncttvJ2kmzbeCb/vtjgJQx0gHvdIIFnUsXCHMJzWbMXckCusWHXxCF7eI9IqOJm
	q/S0demRWSHjVS7L/nJ9b42QqTjB6D2Evj0LxEIgQ+vtZedCK1zbnPu+cay2sn2IR0f0DT2jBOX
	/QIJ6ggJ1prrK2uzzgXnrLyrC+yDhcdVhO8gZAjak3Dbnv4BluMAadykawevNY0N36FkrOwH2eK
	CaSTWKAqNTV4oncWTpCeP5Vl8vFTx4nQNzFGf1JkZ+/7Pp2dcgU6VP2vDCcTRNQiKKh9SVgVBMp
	JjxJxAj1kpM5u0xbUbGH4DF49H5l9r+w/Q==
X-Google-Smtp-Source: AGHT+IE1+WxOcP+PFDf9gVT8bBwaZ8BjfRRqOWZNPk/1wluXto7KDqsniux9pWhX0MxzxMrxHOiWccWukV59
X-Received: by 2002:a05:6871:3804:b0:297:270f:d79d with SMTP id 586e51a60fabf-2c1786717b0mr1131713fac.8.1740784474779;
        Fri, 28 Feb 2025 15:14:34 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2c15c4d775fsm235764fac.34.2025.02.28.15.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 15:14:34 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A9BF934028F;
	Fri, 28 Feb 2025 16:14:33 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 9E713E419D4; Fri, 28 Feb 2025 16:14:33 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH] io_uring/ublk: report error when unregister operation fails
Date: Fri, 28 Feb 2025 16:14:31 -0700
Message-ID: <20250228231432.642417-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Indicate to userspace applications if a UBLK_IO_UNREGISTER_IO_BUF
command specifies an invalid buffer index by returning an error code.
Return -EINVAL if no buffer is registered with the given index, and
-EBUSY if the registered buffer is not a kernel bvec.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c     |  3 +--
 include/linux/io_uring/cmd.h |  4 ++--
 io_uring/rsrc.c              | 18 ++++++++++++++----
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b5cf92baaf0f..512cbd456817 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1785,12 +1785,11 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 
 static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
 				  const struct ublksrv_io_cmd *ub_cmd,
 				  unsigned int issue_flags)
 {
-	io_buffer_unregister_bvec(cmd, ub_cmd->addr, issue_flags);
-	return 0;
+	return io_buffer_unregister_bvec(cmd, ub_cmd->addr, issue_flags);
 }
 
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index cf8d80d84734..05d7b6145731 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -127,9 +127,9 @@ static inline struct io_uring_cmd_data *io_uring_cmd_get_async_data(struct io_ur
 }
 
 int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
 			    void (*release)(void *), unsigned int index,
 			    unsigned int issue_flags);
-void io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int index,
-			       unsigned int issue_flags);
+int io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int index,
+			      unsigned int issue_flags);
 
 #endif /* _LINUX_IO_URING_CMD_H */
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 45bfb37bca1e..29c0c31092eb 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -975,30 +975,40 @@ int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
 	io_ring_submit_unlock(ctx, issue_flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(io_buffer_register_bvec);
 
-void io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int index,
-			       unsigned int issue_flags)
+int io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int index,
+			      unsigned int issue_flags)
 {
 	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
 	struct io_rsrc_data *data = &ctx->buf_table;
 	struct io_rsrc_node *node;
+	int ret = 0;
 
 	io_ring_submit_lock(ctx, issue_flags);
-	if (index >= data->nr)
+	if (index >= data->nr) {
+		ret = -EINVAL;
 		goto unlock;
+	}
 	index = array_index_nospec(index, data->nr);
 
 	node = data->nodes[index];
-	if (!node || !node->buf->is_kbuf)
+	if (!node) {
+		ret = -EINVAL;
 		goto unlock;
+	}
+	if (!node->buf->is_kbuf) {
+		ret = -EBUSY;
+		goto unlock;
+	}
 
 	io_put_rsrc_node(ctx, node);
 	data->nodes[index] = NULL;
 unlock:
 	io_ring_submit_unlock(ctx, issue_flags);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(io_buffer_unregister_bvec);
 
 static int io_import_fixed(int ddir, struct iov_iter *iter,
 			   struct io_mapped_ubuf *imu,
-- 
2.45.2


