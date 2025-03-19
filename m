Return-Path: <linux-kernel+bounces-567351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E569A684F1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716A019C5182
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1032512C4;
	Wed, 19 Mar 2025 06:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="cm+X6FzY"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D77A250BE5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364817; cv=none; b=ox6FTUGlB/304P/1rln4yAIGcC8+9GneakaCqlfR0eBJXfmlurr7NOuM9b/Vb4W72fswIZpzg53vqOt8KyqTMMuUWKZObjmUhX6OhJeH3P4XL+OCQP0bVqkCCRS6A+dbij6Z1XgV4lX3PYPPX0/MqHuz67os/AoRyU4we+p0o2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364817; c=relaxed/simple;
	bh=eyjj1uHvjzoEdaKMraFRmuVcUzgVgA4sRhGNzePsgog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TY0/ZaBYXxYeU9blqHcFI90oMG4A6YvPsYpxBV4aBRaBK1lccgBwSVbbbVFiXiwIWhPEhYgT7S89VFVqMR3B1Fby/k0zi0iO0z8xxWOllbbdCNsPFSXyAxQhFGVqAQ5sllrFe6txsJlsaMdHbFdIJHwAw6SDLNlNroeXM40X+yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=cm+X6FzY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-225fbdfc17dso61135555ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 23:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742364815; x=1742969615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ae4PagFT38IepvXpzRbslA5V5XToKvo9V6NCx8IDEps=;
        b=cm+X6FzYD6gd65QlfG6VCTMkgJ4vWA1Z3zUvNtRUcOru8BnVt4wYYoxI9X/10J4NW7
         IbwwOXJpt5Bob+1aWQFnfPImETJTDUJFwxOEKisDdCxBuz151KnSwXJAJxru1FGDkop5
         Ik2l98iMPOzB2VPZmaDzqeoEQK7FSHI2ENKHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742364815; x=1742969615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ae4PagFT38IepvXpzRbslA5V5XToKvo9V6NCx8IDEps=;
        b=RPjq5I3p0ciOGKPuF3S2PlT2MmT1prcVvflhZwr19q/AQnALUMaHj3JJGwgIlD4/q6
         KCldl2fHryfKO/91nYQz9h4N+qtB5WJ0tqM5WSNP1/3gCd9ic8Yt/k1Sg6fxAEid2Zcw
         nPkdPHt9Ke0TIkfHce5HhRG5Nsi4/B/64WFk5/qanbP0KPlVaFsUXqFAElTi42JUIE26
         d4SwtC40SreKWwDeG/T8eqMA2C+v15dcnxTXf4ddx7JPXWvLUtn6QdGFVTjq1lPvkKwT
         YZpdjhE4j8WY3XrfpLtavbmxboCkW0V4tnQyo5IcEzMdUtcrJ2bjHdqSZuWiTyVIXKjd
         8QbA==
X-Forwarded-Encrypted: i=1; AJvYcCUncWCCxr2WVa2IDG6c1qSmrD+McYX78aamoSqxqVsq3WzfYqr+YAOclQzWa6PUALLQVz9TLhppK3LbJOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGa3yRsL7mkeLLSSy338Gk/K3ulvY0RkYYpD0sfucEItA5K5lR
	ljiWnMPLO5eeAE3i/KqucbkY8jsqQ6JUP36LwvdyqoRQQJ8CUPKXjDsV70mUSeA=
X-Gm-Gg: ASbGncsli6HhcpQhStYOgyV+IyiR6rDMGRfbLHCRk+6bXqX8drjOVD+C62D07KWou/h
	ahlmnpsx0MmbTwThlT9WXncWRzDkcLqbGjeRCA4ab5oEoRaLARVXFuS4qR/Rjrin99FKmZlbcdz
	IAq/mInKLIVGc8FfuULi9HgTwoFyhKJK4OagtNVtVrstQ0NQpPhiUY8MitvGEMTmRvjy08aqKUW
	cs73UDtG8ULdHyEsmkz3ixn1b44AQdsifFOhAXgtYS7W4JMXovz4FxBiRicO0rnZQHtUxUCViEJ
	7CZB5HG4pY5p/MqDjUibuDm08TsWDLYTExeJtHSIUl3cdAOWzqSWd7EexoiZ5rCQvcu/KXfzQ/o
	DwMg7
X-Google-Smtp-Source: AGHT+IHce4wHjB8TrjarMeRb5jF9Qk1EWj8yU9d+p762t9eiTgkZ3MdU6c4esyFK68gM71Y2X9wSlA==
X-Received: by 2002:a17:902:e5c6:b0:223:5e6a:57ab with SMTP id d9443c01a7336-22649a7c112mr19578105ad.39.1742364815445;
        Tue, 18 Mar 2025 23:13:35 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf589b07sm645103a91.11.2025.03.18.23.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 23:13:35 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v5 5/5] btrfs: ioctl: introduce btrfs_uring_import_iovec()
Date: Wed, 19 Mar 2025 06:12:51 +0000
Message-ID: <20250319061251.21452-6-sidong.yang@furiosa.ai>
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

This patch introduces btrfs_uring_import_iovec(). In encoded read/write
with uring cmd, it uses import_iovec without supporting fixed buffer.
btrfs_using_import_iovec() could use fixed buffer if cmd flags has
IORING_URING_CMD_FIXED.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 fs/btrfs/ioctl.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6c18bad53cd3..e5b4af41ca6b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4802,7 +4802,29 @@ struct btrfs_uring_encoded_data {
 	struct iov_iter iter;
 };
 
-static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue_flags)
+static int btrfs_uring_import_iovec(struct io_uring_cmd *cmd,
+				    unsigned int issue_flags, int rw)
+{
+	struct btrfs_uring_encoded_data *data =
+		io_uring_cmd_get_async_data(cmd)->op_data;
+	int ret;
+
+	if (cmd->flags & IORING_URING_CMD_FIXED) {
+		data->iov = NULL;
+		ret = io_uring_cmd_import_fixed_vec(cmd, data->args.iov,
+						    data->args.iovcnt, rw,
+						    &data->iter, issue_flags);
+	} else {
+		data->iov = data->iovstack;
+		ret = import_iovec(rw, data->args.iov, data->args.iovcnt,
+				   ARRAY_SIZE(data->iovstack), &data->iov,
+				   &data->iter);
+	}
+	return ret;
+}
+
+static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd,
+				    unsigned int issue_flags)
 {
 	size_t copy_end_kernel = offsetofend(struct btrfs_ioctl_encoded_io_args, flags);
 	size_t copy_end;
@@ -4874,10 +4896,7 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 			goto out_acct;
 		}
 
-		data->iov = data->iovstack;
-		ret = import_iovec(ITER_DEST, data->args.iov, data->args.iovcnt,
-				   ARRAY_SIZE(data->iovstack), &data->iov,
-				   &data->iter);
+		ret = btrfs_uring_import_iovec(cmd, issue_flags, ITER_DEST);
 		if (ret < 0)
 			goto out_acct;
 
@@ -5022,10 +5041,7 @@ static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issu
 		if (data->args.len > data->args.unencoded_len - data->args.unencoded_offset)
 			goto out_acct;
 
-		data->iov = data->iovstack;
-		ret = import_iovec(ITER_SOURCE, data->args.iov, data->args.iovcnt,
-				   ARRAY_SIZE(data->iovstack), &data->iov,
-				   &data->iter);
+		ret = btrfs_uring_import_iovec(cmd, issue_flags, ITER_SOURCE);
 		if (ret < 0)
 			goto out_acct;
 
-- 
2.43.0


