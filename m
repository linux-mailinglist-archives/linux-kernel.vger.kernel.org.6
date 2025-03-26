Return-Path: <linux-kernel+bounces-577313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDD8A71B55
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85413179876
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F391F8908;
	Wed, 26 Mar 2025 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="T8VWEhwI"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552281F7910
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743004735; cv=none; b=ZE8K7xRHvI20hGmARaDafyQ3EK6WafG6bgBPH5Qdo+ix9pRfH+r2AhlYgC6axrKylKyD9EI/nOsne36XUjDydJwPQA9khDKInxiN87bPyMtQEfcvrNPuYXK1GEBkG2maq5sus3N31bW3+xRUmm3zoo2Pa4UgeGN/Q4IwszAgWjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743004735; c=relaxed/simple;
	bh=Ko35wHuYTUsyD9pNDD6CddW86SuHmvVF/p8rHOgc5Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=osrdr3iN1K8uGvLKpvPEUMZxy+uGz3VslWZeexuvv81BwG2ZBZzI9oodziWXEcEkLuYlNn9+srj6/HS+aEleShSWp0Q0iuOTxV3rAR76t4rYuHwwMwwZG/W6+YCWR96hNBj4lE3+rlNuEJZXRjy2BewvVaka4aVf8hF9vJC0RS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=T8VWEhwI; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff187f027fso2696080a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1743004733; x=1743609533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vaZQ+2MJDMVjz/9PaIWP0hky9ATIPKX3HyuJU/jmspM=;
        b=T8VWEhwIWdprG7TzGEYgjk8BP/tosxJmDPwv1apaqgnHfMtYfvrE9EfeKFk/WJGTiP
         T4knKjFqT11kDt1yCPC0XVRr2Kdte1to2oNh4c6QneRLhxyYh/RXmCf4oNPIAuAx2xXa
         90KmDNoJ+JQunZJbAulL5f7e+W61mYfNEIJEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743004733; x=1743609533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vaZQ+2MJDMVjz/9PaIWP0hky9ATIPKX3HyuJU/jmspM=;
        b=cxq/OQiYx8Fxxl3RGzoKtatSLS6AXGt+JTzW69gal9Y3Zgj/Z+s5vG8u164HVBttZ5
         iGsTVjW7IpbzdHI60nmCdJw6u5vArTObcyKWru66ozu18HDifv3g/UJ0M2FLKauSdDq/
         lF+TghrqQzEGmpIJKu8XTq6gltJzkLjQpwNspnfiBLtIyLKcKqhFQl2nJNdIHJFYPF0k
         IXi1xuDhFkwHkcYjieb4jzbvhm1ulVyX6YP1fIWRB/6dBmqs1tFGrUqlgWZpIk+ybK6n
         BzcomD2U2aH+XqqX42vrMRaI/BGzQhtDlqGHJkzYTCcsZHPcSoUTbY02tnl3Tdn2v321
         f5gw==
X-Forwarded-Encrypted: i=1; AJvYcCUAilK8vtUJKU4ifuhUTp6c7HDIKAZzvYu20R4IOv4DvF0AztTRrK7u/8qHrIFXjX0ymv/PS3gepCCDSvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWGUqH5mIXZ23HHKywrQs5NMvVTcbixxU9vexbczM6jhPVlW0C
	6QFFMae4W3KK1DJeUQkaVXo8eDxNpGARRq9lXgsOWaP36w75WGd8VBZjHScCntU=
X-Gm-Gg: ASbGnctHxbG/O+gC1Ut2PeH1NLJoJyG4BoFTCQ1RNGWCJrHi3T13g7+NFUc/YHmRVA4
	90le49c/KJT3PgOb/AK5yjx6OvU5d59cgmFGfKzvgDzoa6hdZPynR85C74ZOKg5hBqmj7suUSRL
	mS74RNsl6srUMsm80KiNpvEJA+jq4VDxIPnBKaTJKtCTy3Y876GpxzZs1iGJ3yr/edxP3lcH6F3
	u2P023eexS4TrLeXBakZ6NiE7FIjNJhgxLlM1UJ+bEth4FMfDv44oV+rlQN/4tYoFSapBZApZpP
	qjXyzZaG9Q/4VShI26ZyjqisXJrT3ZsQVIDUzuTJAeUsT/LhwtptKeiSNxeIx9VQH5TOL9AGhVt
	xN561
X-Google-Smtp-Source: AGHT+IHFgZ5MnxSjZ1MnHHSC8h28hT1dJVRZQpLzJ1vDyTU635J4PM5CGpBG8FJ9Nnh2HGTU+QyICw==
X-Received: by 2002:a17:90b:3e8d:b0:2fc:aaf:74d3 with SMTP id 98e67ed59e1d1-303788c3949mr5434698a91.4.1743004733212;
        Wed, 26 Mar 2025 08:58:53 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fab1d1sm12423939b3a.32.2025.03.26.08.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 08:58:52 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [PATCH 6.14] btrfs: ioctl: error on fixed buffer flag for io-uring cmd
Date: Wed, 26 Mar 2025 15:57:36 +0000
Message-ID: <20250326155736.611445-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the io-uring fixed buffer cmd flag is silently dismissed,
even though it does not work. This patch returns an error when the flag
is set, making it clear that operation is not supported.

Fixes: 34310c442e17 ("btrfs: add io_uring command for encoded reads (ENCODED_READ ioctl)")
Cc: stable@vger.kernel.org
Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 fs/btrfs/ioctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6c18bad53cd3..62bb9e11e8d6 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4823,6 +4823,12 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 		ret = -EPERM;
 		goto out_acct;
 	}
+
+	if (cmd->flags & IORING_URING_CMD_FIXED) {
+		ret = -EOPNOTSUPP;
+		goto out_acct;
+	}
+
 	file = cmd->file;
 	inode = BTRFS_I(file->f_inode);
 	fs_info = inode->root->fs_info;
@@ -4959,6 +4965,11 @@ static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issu
 		goto out_acct;
 	}
 
+	if (cmd->flags & IORING_URING_CMD_FIXED) {
+		ret = -EOPNOTSUPP;
+		goto out_acct;
+	}
+
 	file = cmd->file;
 	sqe_addr = u64_to_user_ptr(READ_ONCE(cmd->sqe->addr));
 
-- 
2.43.0


