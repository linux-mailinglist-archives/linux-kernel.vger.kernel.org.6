Return-Path: <linux-kernel+bounces-557772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA26A5DD7C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFE967AC4EC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20129243956;
	Wed, 12 Mar 2025 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="0awkaYd9"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39F324A043
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784985; cv=none; b=YrXTUFH11NINnn0+TyRaMIjahRvOnOnoobimmU2Gxp4m9jdNn+ozk4wu+fJo4/T8RWXLjGGp9fiWYWLZtgu1WlH2DpMs5pM220E2rRP5lRctD1SJuxxNihh0n3ZXRXn1j4xQLByx2Y7j9PewHxfFiuZOe9PZ35L0hnRYE+aPKeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784985; c=relaxed/simple;
	bh=ga2LSmT61md5n2p7rdCucn4O99aWE/jCY95aOOLVTH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGtfojqux31zbvKaDrUMJ01J2Vu/Fcxm+m0aDw0I2MNx8U4i8sG3K5/548mOgNA9BCBGhKqIiM08714V5j3Tg5xzcH8GkPL2HkC28TOSH84QAt0aY4VC4RwyUPH0a3CFLFUwAHePGHvhcva1ayyyKK4gBmQaqHDI4zW3ZTjiU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=0awkaYd9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22337bc9ac3so126921825ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741784983; x=1742389783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sf5Mim88v1zsUv2CF9zajfgiTTZumS4UoXrfg/qlMyE=;
        b=0awkaYd9We31IKpPedZDh3uvKNmfLqn9OtPI56bX2wSvlrJjNNEEkBqJ6EMF1bOdJu
         81ukfkIqH7bM5vRz/c7MeCLDiYJdDotmswVhUcZnF/Zyr7rnaj3NF0tnrbBVJJKFJqRk
         70P+fNaZNNZfrMl6arvVrn49RFaDB/1zmdl94VdKWhhCuBcFlBatDjWz9+VqaQqbi0BM
         WZuX72wNZ74DnD1eruYlAWmZgjvW+T6Sd+aC9Sj8eM6HOCZzeezgoGH/nFOQO+OlHAcX
         htWQG2U6cbNI/370ofEH7CyeAkZh4C+ZJOQtmkx9rsGvTPLfAYbGA3pdVDsiGtWjAA5s
         +l1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741784983; x=1742389783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sf5Mim88v1zsUv2CF9zajfgiTTZumS4UoXrfg/qlMyE=;
        b=gpYmaNr6Krcxxo88/eNXlgEWDqCM5N2KXRlrs6k/77A7Lg0AEguFAGwb5rXVp2c3gN
         or9DWKRpSY5Ba1L7ItK/Pu721NBGU/HOhny5MdW3GQZTDAsGdBmeMkOcoWs35iJTltXH
         qlcrmFVI4y9cTmAceh2gH5AIGhJliqDWj8CNpLTDwbfWm5+XEF5P5/ZfdhVp3NaMhicv
         lOJ6Emlh5RnFSu7LYgXzydkGpp4G6eaZkj3aSh3j8rgNZjD1eyrurL/rYFFKdX97aCfV
         Sbj/h/2VGdNgarTTk+Y0TSW4R/SJbNm8nq5hCHqgww5KDwnW9sd7Ub52dsRAlZdFaPue
         pquw==
X-Forwarded-Encrypted: i=1; AJvYcCWU9Cx2ksruv3q/oviFVNZ479bbZOXRlHzejqU9CqFa2ER++HK72PwextjBVEiBZVnxTZznLCzL2WzHptU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLd5mZ7O7WYAt2OdPU2g2FWRrMq9FzicBrypsSy8Mb0qGp5KEU
	ZV5H5FoFvxOnMqpDgXtochk4yasKJsqdeKDWZKvtIVJx3OJXOIi2NndFsPmk+zgOSZfIAdiIO+b
	1
X-Gm-Gg: ASbGncs4OVVfJQ9u5lC045cCy2QnYT4JhI+xjoAoBmtJPD0uDUNN+OvgEO9v2XLVCzv
	rbqKwZ9+HQfnRK97GBEK4MXI3fAHPX6jiCE976S0Hmh162WortN/G7oNsdwX/qdcrHOUPk8LlZW
	d2poQm4/ATrpM8taAf51m9frJTNA+xh0NWeCDbpNZnnOUKYtFwCD/xDZh7eoQU1VkQwy7Ynnsg8
	DHUSZIUveV/kFg1r/duXRX1f0V3ZXSaTl+0wxsgdgHbTvaj8GTC/B/uuUuMBCfF522RzlVB3gX5
	xnXVqljC15Kggo94PrVA8wpHZEvfxyzRjyPmZ7Y92HYoAuA84Wk1oitOyG1VOmRDBCDDXMFu7Md
	5AHpw
X-Google-Smtp-Source: AGHT+IHINSsNMXDf/ujoGNsvP22wMUl9hboDvbpyzHad1RW7/6Vo+ySwFx65tyhXFD9eKYlgsO5pNA==
X-Received: by 2002:a05:6a20:b68a:b0:1f5:619a:7f4c with SMTP id adf61e73a8af0-1f58cbb5ebbmr11897051637.29.1741784983366;
        Wed, 12 Mar 2025 06:09:43 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af5053a85c2sm9432299a12.10.2025.03.12.06.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:09:43 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Sidong Yang <sidong.yang@furiosa.ai>,
	linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [RFC PATCH v2 2/2] btrfs: ioctl: use registered buffer for IORING_URING_CMD_FIXED
Date: Wed, 12 Mar 2025 13:09:22 +0000
Message-ID: <20250312130924.11402-3-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312130924.11402-1-sidong.yang@furiosa.ai>
References: <20250312130924.11402-1-sidong.yang@furiosa.ai>
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


