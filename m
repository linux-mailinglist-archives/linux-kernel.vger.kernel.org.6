Return-Path: <linux-kernel+bounces-564295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8193FA65217
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E87C47A774F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567D72451F1;
	Mon, 17 Mar 2025 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="KdwR8lkn"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB67245022
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219886; cv=none; b=SYjN2eofuWKMGx27BU47BysiDE9OrK+riAYPiRz4AQUyfFsv4mWCqwjARBYvNungvS8+BP8qYtSMiU2MiP4V5SGcdENbF7w23es+74KVQ4Enzc2j7hGRvAgV4seKrd7sdFdOdkd1P4lFSqiIQEh220V3UGjPAqE4getuh6QLHKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219886; c=relaxed/simple;
	bh=jjy/ipAsVAjM570PsPj8EFg1BR0qzO1tolMoinZ9Ul8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyKK5i9pcHU8Ow3SzA2pqtM0TnVhBsxGaruYp+fRNqNTNA71BBg7/UHycVrRXG6Y2dmGUnM/7UGxmrf9YFRIhGOglLfgJuhEUVk5S9pbOoqy5MuofGrpiTt+0r9AlCke4xOuBu5n7Gqntbt6+Jp6S+ycqHhM/nW50Jj0A4uTBTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=KdwR8lkn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223a7065ff8so38804625ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742219884; x=1742824684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gA/GFNSLx9g8BrxtQW6nnUtMwtq8vRTEsCNTXthdg1I=;
        b=KdwR8lknBkk0y3/Ue2UtywXBWCCkbDYoO67uQcXxecd3q21/h9QkEYEg9KfeDXWOtq
         ciw+CRCLmFDHrCIbze5ahmRiF3m2Y4r4LPmOzGFcLSAu39To5DnwxLI2erwKqL2ve8sG
         IJqxdQC7mKZ3NJf4q/+Hbv+3v+TjybPDrB2+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742219884; x=1742824684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gA/GFNSLx9g8BrxtQW6nnUtMwtq8vRTEsCNTXthdg1I=;
        b=H3XfeW129eLMwMVSt1Ltr41hzl+6sGf1Pzp7/hWqUC0bK8sNz8oEZjY+yhddeQGwz0
         TVLI2OLuQjZpFiAJlXRx0OeQgv1YTJu5fp3fOANvteyXKM5cg9pcMG3+PVXcdIEhojkX
         D8t3Hz3YLIJJiDP8UoU980Zo3Q9pxbRuTt+IJGxTTF0w9Pm6/bI40l5xixPiuQDnaJlf
         OvrPubGLpm2lRuuWLeVTe4JD8AKP7UVRwOgB8xtjdW1z5fUucHOh/m4Sgv7X9qriB7vZ
         9QC0YmD34bmuM2dHlE1jG54wz+/2gBPapcK9J9zWNu0f/UHnOTVsVtMAZXhZnt8o6SEs
         Fjhg==
X-Forwarded-Encrypted: i=1; AJvYcCVLHubLjuC5/I6N2J/cFS3Y2/24wtaq/IsNGACfVSfOyfcLfjVagg4mcq7265mabva9zJUqaj+CT2PHTGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyInwesaLXO5eH7xcWmEpss61Bzcv+aoGznl+jTsLU7XMMZ+REo
	RCs+MM9cbNOKItqsSBQsOYNQJ49oEfbzs1vqbJ5i86EfHXSPIXJ6wQCtkeAWN5U=
X-Gm-Gg: ASbGnctLGpdUSnTYokhVs0xLg1G63PqI+2OnPisstGpcCjIdRJh/dcvvojB/bYQKxcA
	k//AxDqmcI6ln489Fqur+rwfPOa2TlKw72YgvM8k3XvEbSqbs+cWljU63QL95FDVi5Fu6e35k8R
	i+0x7P+4EjyWKwYEXqbOW9QB9V6CoOYsvG+/x/VjzzHOpEOi3yJWA2fkuWNGc+rn07OEUrr5EfT
	23ea5r5CdnAVTBNGicPGpxWjswEm0ozpT1Ay/Gym5dr3DTHPVypjOA2S5Oq2TyCn93bLlikxTLr
	Pf9kEZlA/I2MBLq8PB2kP8Jnh7Ghl3tbY46WB4wP/tcNJDTCAudK43ZXP2tLn6h2TPWX1A383d0
	7Z2caOa6ErYD5L9s=
X-Google-Smtp-Source: AGHT+IFR7AcxAe0GTSDHpA3O1seZLZqT6TdAlslNuPZsXOgxqL8PZ6/n5ArYVp7pqIiRkt7+bkJSOQ==
X-Received: by 2002:a17:90b:4d04:b0:2fe:baa3:b8bc with SMTP id 98e67ed59e1d1-30151d3fbb4mr12872664a91.23.1742219884680;
        Mon, 17 Mar 2025 06:58:04 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153b99508sm5993742a91.39.2025.03.17.06.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 06:58:04 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v4 4/5] btrfs: ioctl: introduce btrfs_uring_import_iovec()
Date: Mon, 17 Mar 2025 13:57:41 +0000
Message-ID: <20250317135742.4331-5-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317135742.4331-1-sidong.yang@furiosa.ai>
References: <20250317135742.4331-1-sidong.yang@furiosa.ai>
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
 fs/btrfs/ioctl.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6c18bad53cd3..a7b52fd99059 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4802,6 +4802,28 @@ struct btrfs_uring_encoded_data {
 	struct iov_iter iter;
 };
 
+static int btrfs_uring_import_iovec(struct io_uring_cmd *cmd,
+				    unsigned int issue_flags, int rw)
+{
+	struct btrfs_uring_encoded_data *data =
+		io_uring_cmd_get_async_data(cmd)->op_data;
+	int ret;
+
+	if (cmd && (cmd->flags & IORING_URING_CMD_FIXED)) {
+		data->iov = NULL;
+		ret = io_uring_cmd_import_fixed_vec(cmd, data->args.iov,
+						    data->args.iovcnt,
+						    ITER_DEST, issue_flags,
+						    &data->iter);
+	} else {
+		data->iov = data->iovstack;
+		ret = import_iovec(rw, data->args.iov, data->args.iovcnt,
+				   ARRAY_SIZE(data->iovstack), &data->iov,
+				   &data->iter);
+	}
+	return ret;
+}
+
 static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
 	size_t copy_end_kernel = offsetofend(struct btrfs_ioctl_encoded_io_args, flags);
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


