Return-Path: <linux-kernel+bounces-365219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6D599DF1D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF8F1F23B83
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA59818B478;
	Tue, 15 Oct 2024 07:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sdyg/g0j"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2C3137930
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728976100; cv=none; b=iovTP9ATOjjeQ1+k59KZbYZUCnO4uflzszPOAQP+ynRkPBY7dHioOHeLcYdNsBx2F9Akqgw9bjESmOa3VGIveMPcJW0ogQwgmIU9dHvMzNdvvLXTJdv4pzofjK1a6W2Nz6+2e2DFuLWxWcote+e38jgCW/Fs1kioSFbCSTGU318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728976100; c=relaxed/simple;
	bh=JZe9/XrMpFaNoSVFNPsUO26nNc6OXny+uNP6tz4qzhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eCyN52abFjd0tSCJq6Ac1Nt1tpVy2gvW48SEjrY8kbAqRSkyhMAYTXHZj/dW1/fHea+XUH7q0vQZJK51qlUGYXvgFS3ArVF0urfX4hYhewOU9RXcsRFgBF+8P2fA9llzfiRgL5qMyeqnRe4BIPSkvXNMfDxh3o7FFtXE9v2nCYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sdyg/g0j; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728976090; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6gFoeTlFavv7EAeAASqltytkDM8bjC0/MUctFJ6l394=;
	b=sdyg/g0jBiqlZjoaW9+SpJb3qZOzBBDxYn0jv994eTvBF053a21KYO3DsRlyvoQmMTKyHM9Oir1Gijy78LeVD+wr/bzsOmWadWrMjNnG6N3NxJpw0VTWSFvK+7m6YrMyzHieAINH68nEcUtg6QyI0AYaXx7agNuvkW0X012X0mg=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WHCbt5k_1728976088 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 15:08:09 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	Hongzhen Luo <hongzhen@linux.alibaba.com>
Subject: [PATCH v3] erofs: fix blksize < PAGE_SIZE for file-backed mounts
Date: Tue, 15 Oct 2024 15:07:50 +0800
Message-ID: <20241015070750.3489603-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust sb->s_blocksize{,_bits} directly for file-backed
mounts when the fs block size is smaller than PAGE_SIZE.

Previously, EROFS used sb_set_blocksize(), which caused
a panic if bdev-backed mounts is not used.

Fixes: fb176750266a ("erofs: add file-backed mount support")
Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v3: Fix trivial typos.
v2: https://lore.kernel.org/linux-erofs/20241015064007.3449582-1-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/linux-erofs/20241015033601.3206952-1-hongzhen@linux.alibaba.com/
---
 fs/erofs/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 320d586c3896..ca45dfb17d7c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -631,7 +631,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 			errorfc(fc, "unsupported blksize for fscache mode");
 			return -EINVAL;
 		}
-		if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
+
+		if (erofs_is_fileio_mode(sbi)) {
+			sb->s_blocksize = (1 << sbi->blkszbits);
+			sb->s_blocksize_bits = sbi->blkszbits;
+		} else if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
 			errorfc(fc, "failed to set erofs blksize");
 			return -EINVAL;
 		}
-- 
2.43.5


