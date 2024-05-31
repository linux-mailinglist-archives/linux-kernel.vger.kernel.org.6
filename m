Return-Path: <linux-kernel+bounces-196189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 402C28D58A4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 04:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB251C230FD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 02:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A5378C89;
	Fri, 31 May 2024 02:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BuCbUCZy"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB7D1F16B
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 02:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717122700; cv=none; b=k0+D31BgV4pDq2kQJrzQSz9puthasJXemZd8mwPBvaUirAtgcMC6rPs/WlbVQOxDFAdn0Wo2lfYFgDsDLvXbMgPh3ydXrp76gANZRY/sg/+K/GCUFz7GQYrag+8tE6RpiohWfUPpOHqlsjM8hC5gSlUW60xGkQbQrnqyk5DjIWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717122700; c=relaxed/simple;
	bh=00ju4f/3GHc0EOMMkg7vmxo/6msUeyLgsUBjUiefSlU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QnB1mSklGV5PMEe0kQtGfEk7zcDhJBtgeK0gvKLSZnxAu630FhWrxqN3J8bS0Z1uE9IWKh48NzOSiF/59hed84x2pDuTY32cpVSTGJbdCIrXm7S7WHVul/VpS8EmF5Jwxth5mvmerZ/Xj2UPy6YYKkGxONLQixCQpBLg+X+flQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BuCbUCZy; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: kent.overstreet@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717122694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9DtHHW/1JNGGMpmrvNWctFteiGBA2L9suuHhbLIp850=;
	b=BuCbUCZyu9TzxKDUftypGJ8NhpNeLrZOuCiT9fscxqrfJexOohJvvm9Z1q/j8F2wed4uzx
	CKfIHVpoyCAcaKz1v4Kdv6AnwlMroeEuZcv9iYI5pxXN8dMfEhsK2/LbWgagFdo5VV2OhG
	Xft1e0+8HmmWqrCM96Bw11msIKz2SEE=
X-Envelope-To: bfoster@redhat.com
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: tangyouling@kylinos.cn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Brian Foster <bfoster@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] bcachefs: track writeback errors using the generic tracking infrastructure
Date: Fri, 31 May 2024 10:31:15 +0800
Message-Id: <20240531023115.11940-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

We already using mapping_set_error() in bch2_writepage_io_done(), so all
we need to do is to use file_check_and_advance_wb_err() when handling
fsync() requests in bch2_fsync().

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/bcachefs/fs-io.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/bcachefs/fs-io.c b/fs/bcachefs/fs-io.c
index ef20b64033e0..f5b266e51261 100644
--- a/fs/bcachefs/fs-io.c
+++ b/fs/bcachefs/fs-io.c
@@ -192,7 +192,7 @@ int bch2_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	struct bch_inode_info *inode = file_bch_inode(file);
 	struct bch_fs *c = inode->v.i_sb->s_fs_info;
-	int ret;
+	int ret, err;
 
 	ret = file_write_and_wait_range(file, start, end);
 	if (ret)
@@ -205,6 +205,11 @@ int bch2_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	ret = bch2_err_class(ret);
 	if (ret == -EROFS)
 		ret = -EIO;
+
+	err = file_check_and_advance_wb_err(file);
+	if (!ret)
+		ret = err;
+
 	return ret;
 }
 
-- 
2.34.1


