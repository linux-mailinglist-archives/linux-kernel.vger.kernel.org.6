Return-Path: <linux-kernel+bounces-365175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C273D99DE96
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48CD5B226B3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F2A189F43;
	Tue, 15 Oct 2024 06:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NgpladGM"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C2317335E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728974420; cv=none; b=LvzNtd6gAV0sj6ervhj04RaP1Zrwqr2u5/6qEWOsG/OQCLV5+e58jje7WutdHIuDnw4xiYtXOypiAOYlbTBSZQUSUZ0E3EnECTW8915tYp6TcQO6CN8tCamz2g1WDCOBMPxWx/mOjisqbjvdY8Nx3wk0RtBfKILHEKmzhPD3y/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728974420; c=relaxed/simple;
	bh=IbafRwKT7uKP7vEuY5wVXmT1oOX2ANNfTsgobIEtUDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EFB9DW2XW2VwnUrqr12ZgSqML3yYB5k5avmyskWAGq6hw/9OMHscN11wiqV2/RThFHRfYtID2igePVHAUbr22x78P9FH4RzGtHolGxg0mOEI5lcYUZzzNI8JKY6aXyz0TPWbNGZS4lAyKqUjISU+ciyOQs4v/wqZPE3Sj5xqe0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NgpladGM; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728974409; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yt+/eMQI2XRlFy5hEDqAggoK8kdAzzr6SJ9l3ypys2Q=;
	b=NgpladGMEWoapzGRCPtOqgk8OzHsSdfgmervruZBgdmChJCdx2zsq2Eov8O2voqv4fK41Vtx10POiJR0ivEoRFM9Q+gv94+jbD0FuZ5kmlY4dWg2PaZzHzeTL1Ywp14+YH7o3YbnsKehlBe61Wqpk+qnfrJHq8bo7+bYfliSAf4=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WHCJkYo_1728974408 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 14:40:09 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	Hongzhen Luo <hongzhen@linux.alibaba.com>
Subject: [PATCH v2] erofs: fix blksize < PAGE_SIZE in fileio mode
Date: Tue, 15 Oct 2024 14:40:07 +0800
Message-ID: <20241015064007.3449582-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fileio mode, when blcksize is not equal to PAGE_SIZE,
erofs will attempt to set the block size of sb->s_bdev,
which will trigger a panic. This patch fixes this.

Fixes: fb176750266a ("erofs: add file-backed mount support")

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v2: Add support for blocksize < PAGE_SIZE in file-backed mount mode.
v1: https://lore.kernel.org/linux-erofs/20241015033601.3206952-1-hongzhen@linux.alibaba.com/
---
 fs/erofs/super.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 320d586c3896..abe2d85512dd 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -631,9 +631,15 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 			errorfc(fc, "unsupported blksize for fscache mode");
 			return -EINVAL;
 		}
-		if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
-			errorfc(fc, "failed to set erofs blksize");
-			return -EINVAL;
+
+		if (erofs_is_fileio_mode(sbi)) {
+			sb->s_blocksize = (1 << sbi->blkszbits);
+			sb->s_blocksize_bits = sbi->blkszbits;
+		} else {
+			if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
+				errorfc(fc, "failed to set erofs blksize");
+				return -EINVAL;
+			}
 		}
 	}
 
-- 
2.43.5


