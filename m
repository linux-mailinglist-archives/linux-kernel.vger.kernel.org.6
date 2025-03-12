Return-Path: <linux-kernel+bounces-557869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4F1A5DEE2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44EE17B62A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD812512E7;
	Wed, 12 Mar 2025 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="bB3zlehi"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845DA2505C5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789450; cv=none; b=Xyqm+712zcPAnri7j0NFnldIcCMy9m6V/VIOr0g1EDjRtPHQPxYsRg7qJp5Ai6brPSJyLBagJ/H9TGuhej+8IcuIsv7QFVYlqZ/lN71N/569WssxH3qXzlp8fUjeEBzv+mOHTr/7EbPhnd27cTJCZxxrSWBykYEE7TnXfee3tPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789450; c=relaxed/simple;
	bh=ga2LSmT61md5n2p7rdCucn4O99aWE/jCY95aOOLVTH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7XOokQzSoDJkpwE97oEtpP7E0ZTiyI17KoSmISt84wdbgcsg2JF1+LI3vKrJqbEPN3DQL2vRnmPQ9ePo7RMoi/yoiVNS+rgf4R3utGhagoY6Sz0fuRkbSApzSB+PAe1vn5kXthGJRKOojo8WXo3im9XvKJjxgBGz7kKkatt86w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=bB3zlehi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22403cbb47fso131587205ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741789448; x=1742394248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sf5Mim88v1zsUv2CF9zajfgiTTZumS4UoXrfg/qlMyE=;
        b=bB3zlehiZTFURQmVJcfQacyW7bM61oTMRio0061Ul84NaT+OpR0HreJbtIBbn5l5G1
         Awfru6ADxBPtzGeali+x/cD0Xgan7BJb/beK3eyfzmmMY7SnLnjMqckW5OrPpXUW1L/r
         92z5LkcWZjJ/brlJITek8PoT4axxVyFJ8BqfrUJABI3Z1BJd59zduodfxqJf/ZQ1Awlu
         2P5vChH/QxlRz92kfsEs9r7L/iu0RJiIilyO/s5SHtU5JIQD8iIDegSc/nG1+nWYIDY+
         9pS2wFqWSu0kRzjthDvr9C5GFjUdhiwV79/JeyfRYiZMatRalXqfxx1cQa5OHrVvvMCS
         8B2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741789448; x=1742394248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sf5Mim88v1zsUv2CF9zajfgiTTZumS4UoXrfg/qlMyE=;
        b=dVKxiQETabfkVu7IffRN9BYaOHFxLItH0djqncxv2peeaAEmZzIzKUhLtFQlIP3cpm
         IZoAFlB+yEqs5dI3RZ+2bmbUPVvDno87Byan/+Fm0X2dyuiSP/WnjwPo9BQsHaOFK5Io
         5K1HUxt8b62G6qCs6zKDuiW/qpPxRobVPHyWd4L89yxkgHitoB/FR0TEYtvinXnrS/E5
         ZZ6oV4X698/jecptiszQecdmEOeENKaerltQX6krrT9tW0pa7OcBDOfRsNSPgFeL219K
         Uva3z3RlyE5CRIyrOvhcmyzNT0Tf4TXkWCgWx50ASG3afFyD11LOQEtAVJUlRrhi3z2V
         nKXw==
X-Forwarded-Encrypted: i=1; AJvYcCV7czYnPtQk4qYbc6Co98aGtjm+HpbupBE9I1MJZmwExFjtvDjbsLm0N8uyMzoT+XVHeTTc7mWZPjzbyVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzghVm0t0Ynqy+fNY0G0HqINITGeLhRjFXqlp7+FCTk+lMfbzWM
	4l8yzvz2I+P9Xt5H1FmPv8vPsGnUDBXOeToajaUWCnBUFZWvd7JALiNggNxkAVE=
X-Gm-Gg: ASbGncs0pczeCpvtfo165jicPuxXS3zMRDxb/HsiBKsWfNzsqBN+509em6nn00OFIbu
	3ZoAmpmAJnLmok6yJggviSxlGD4Y+T5V3L+e2ojzYRm2mJE09kRwqU3N2uOb9JkyDGr0I7vetq3
	v78ZvUubsfEeXhFIrdY3r22uhCETHAlY0Bk+IFNSUm0YsNLIoMlxgcMk1Xnw5abFtbhCLGl6bOR
	6Tgj5NPB6dThw3l2hHNv1KKxhvSVIMpJWq/vb+wgw17QMOILt/in+FVIhrJVaRC3IyPYvmFSBD3
	B+AVKcVf6q1t8H1sO9WHIVUbWUSV2+9qM0+OcQFvzaiXKZUDe5RKeT0Nc16pmel4dhb4Pqxqrg3
	7gNOi
X-Google-Smtp-Source: AGHT+IEB7zRsn2sn891Qv++mKti8pmW2qB36bnhHeSKSGpIvhV7qeTB7jRROPtq3qpgTC2s59IzhKQ==
X-Received: by 2002:a05:6a00:1401:b0:736:34a2:8a23 with SMTP id d2e1a72fcca58-736aaabee7amr27951202b3a.15.1741789447564;
        Wed, 12 Mar 2025 07:24:07 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736cc972eabsm7413860b3a.144.2025.03.12.07.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 07:24:07 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v2 2/2] btrfs: ioctl: use registered buffer for IORING_URING_CMD_FIXED
Date: Wed, 12 Mar 2025 14:23:26 +0000
Message-ID: <20250312142326.11660-3-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312142326.11660-1-sidong.yang@furiosa.ai>
References: <20250312142326.11660-1-sidong.yang@furiosa.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch supports IORING_URING_CMD_FIXED flags in io-uring cmd. It
means that user provided buf_index in sqe that is registered before
submitting requests. In this patch, btrfs_uring_encoded_read() makes
iov_iter bvec type by checking the io-uring cmd flag. And there is
additional bvec field in btrfs_uring_priv for remaining bvec
lifecycle.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 fs/btrfs/ioctl.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6c18bad53cd3..7ac5a387ae5d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2007 Oracle.  All rights reserved.
  */
 
+#include "linux/bvec.h"
 #include <linux/kernel.h>
 #include <linux/bio.h>
 #include <linux/file.h>
@@ -4644,6 +4645,7 @@ struct btrfs_uring_priv {
 	unsigned long nr_pages;
 	struct kiocb iocb;
 	struct iovec *iov;
+	struct bio_vec *bvec;
 	struct iov_iter iter;
 	struct extent_state *cached_state;
 	u64 count;
@@ -4711,6 +4713,7 @@ static void btrfs_uring_read_finished(struct io_uring_cmd *cmd, unsigned int iss
 
 	kfree(priv->pages);
 	kfree(priv->iov);
+	kfree(priv->bvec);
 	kfree(priv);
 }
 
@@ -4730,7 +4733,8 @@ static int btrfs_uring_read_extent(struct kiocb *iocb, struct iov_iter *iter,
 				   struct extent_state *cached_state,
 				   u64 disk_bytenr, u64 disk_io_size,
 				   size_t count, bool compressed,
-				   struct iovec *iov, struct io_uring_cmd *cmd)
+				   struct iovec *iov, struct io_uring_cmd *cmd,
+				   struct bio_vec *bvec)
 {
 	struct btrfs_inode *inode = BTRFS_I(file_inode(iocb->ki_filp));
 	struct extent_io_tree *io_tree = &inode->io_tree;
@@ -4767,6 +4771,7 @@ static int btrfs_uring_read_extent(struct kiocb *iocb, struct iov_iter *iter,
 	priv->start = start;
 	priv->lockend = lockend;
 	priv->err = 0;
+	priv->bvec = bvec;
 
 	ret = btrfs_encoded_read_regular_fill_pages(inode, disk_bytenr,
 						    disk_io_size, pages, priv);
@@ -4818,6 +4823,7 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 	u64 start, lockend;
 	void __user *sqe_addr;
 	struct btrfs_uring_encoded_data *data = io_uring_cmd_get_async_data(cmd)->op_data;
+	struct bio_vec *bvec = NULL;
 
 	if (!capable(CAP_SYS_ADMIN)) {
 		ret = -EPERM;
@@ -4875,9 +4881,19 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 		}
 
 		data->iov = data->iovstack;
-		ret = import_iovec(ITER_DEST, data->args.iov, data->args.iovcnt,
-				   ARRAY_SIZE(data->iovstack), &data->iov,
-				   &data->iter);
+
+		if (cmd && (cmd->flags & IORING_URING_CMD_FIXED)) {
+			ret = io_uring_cmd_import_fixed_vec(
+				cmd, data->args.iov, data->args.iovcnt,
+				ITER_DEST, issue_flags, &data->iter, &bvec);
+			data->iov = NULL;
+		} else {
+			ret = import_iovec(ITER_DEST, data->args.iov,
+					   data->args.iovcnt,
+					   ARRAY_SIZE(data->iovstack),
+					   &data->iov, &data->iter);
+		}
+
 		if (ret < 0)
 			goto out_acct;
 
@@ -4929,13 +4945,14 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 		ret = btrfs_uring_read_extent(&kiocb, &data->iter, start, lockend,
 					      cached_state, disk_bytenr, disk_io_size,
 					      count, data->args.compression,
-					      data->iov, cmd);
+					      data->iov, cmd, bvec);
 
 		goto out_acct;
 	}
 
 out_free:
 	kfree(data->iov);
+	kfree(bvec);
 
 out_acct:
 	if (ret > 0)
-- 
2.43.0


