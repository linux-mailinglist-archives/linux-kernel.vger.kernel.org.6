Return-Path: <linux-kernel+bounces-397814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4477D9BE0F5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12D11F218B4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B9E1D435F;
	Wed,  6 Nov 2024 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JEGbDi7b"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8BA1D31BE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730881766; cv=none; b=IGs2M241ifXVhGhq5xOzgyLgk/nCmss1kHinLhwrA9OVUur5OQQeSKlj+oJ9gZLXJqvZSTgk05glvmd/LcLr//MAEdJm+5YqtCxpe6rgHTJDo9XYW+MQtvGRzz/XMzEzyVagXOT1gNEExR+JPl3uOvXKIELwd3Lr9Zfqzw5gCRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730881766; c=relaxed/simple;
	bh=dFAyRipysVrCgOj8DXzwHoyujxvKsoICM3nwPjVcmqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qejJUl5XBN5IphdO7aabBv/bkxg0obPHHf1yAKOgPSUs/nhOrlxs7nvlV/I9yiZZGsLLSjyznt717WBthmym5hzc+b0scdSlefqfU7yFO+9XZ3Bg8UaiOwVuG+hk9u2RUFVutA8BqzW+Fn4A8nZlGQt1dh1DJdic5Ihp/13w6+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JEGbDi7b; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730881759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J0MmFoNY0AUSMi5mGDKglkbROXPa2f8IVFEWY6n5zbw=;
	b=JEGbDi7bsOHGQcm+XGK35sJWvbTdtJYeyf7ctyYqm9NdQPkTlFhewTGQbi7VzFTPvXbLV0
	FsRCdes73e70GrOyLMUSGU3+PVfoTBs5nnmMlRsnoErKIUOg4DFF3T9Q2USqOjwOyIf04q
	S9cL1p3i2sksZbidWKZsUNZFXDf+nrM=
From: Hao Ge <hao.ge@linux.dev>
To: jack@suse.cz,
	sandeen@redhat.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] isofs: avoid memory leak in iocharset
Date: Wed,  6 Nov 2024 16:28:41 +0800
Message-Id: <20241106082841.51773-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

A memleak was found as below:

unreferenced object 0xffff0000d10164d8 (size 8):
  comm "pool-udisksd", pid 108217, jiffies 4295408555
  hex dump (first 8 bytes):
    75 74 66 38 00 cc cc cc                          utf8....
  backtrace (crc de430d31):
    [<ffff800081046e6c>] kmemleak_alloc+0xb8/0xc8
    [<ffff8000803e6c3c>] __kmalloc_node_track_caller_noprof+0x380/0x474
    [<ffff800080363b74>] kstrdup+0x70/0xfc
    [<ffff80007bb3c6a4>] isofs_parse_param+0x228/0x2c0 [isofs]
    [<ffff8000804d7f68>] vfs_parse_fs_param+0xf4/0x164
    [<ffff8000804d8064>] vfs_parse_fs_string+0x8c/0xd4
    [<ffff8000804d815c>] vfs_parse_monolithic_sep+0xb0/0xfc
    [<ffff8000804d81d8>] generic_parse_monolithic+0x30/0x3c
    [<ffff8000804d8bfc>] parse_monolithic_mount_data+0x40/0x4c
    [<ffff8000804b6a64>] path_mount+0x6c4/0x9ec
    [<ffff8000804b6e38>] do_mount+0xac/0xc4
    [<ffff8000804b7494>] __arm64_sys_mount+0x16c/0x2b0
    [<ffff80008002b8dc>] invoke_syscall+0x7c/0x104
    [<ffff80008002ba44>] el0_svc_common.constprop.1+0xe0/0x104
    [<ffff80008002ba94>] do_el0_svc+0x2c/0x38
    [<ffff800081041108>] el0_svc+0x3c/0x1b8

The opt->iocharset is freed inside the isofs_fill_super function,
But there may be situations where it's not possible to
enter this function.

For example, in the get_tree_bdev_flags function,when
encountering the situation where "Can't mount, would change RO state,"
In such a case, isofs_fill_super will not have the opportunity
to be called,which means that opt->iocharset will not have the chance
to be freed,ultimately leading to a memory leak.

Let's move the memory freeing of opt->iocharset into
isofs_free_fc function.

Fixes: 1b17a46c9243 ("isofs: convert isofs to use the new mount API")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 fs/isofs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index f50311a6b429..47038e660812 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -948,8 +948,6 @@ static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
 		goto out_no_inode;
 	}
 
-	kfree(opt->iocharset);
-
 	return 0;
 
 	/*
@@ -987,7 +985,6 @@ static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
 	brelse(bh);
 	brelse(pri_bh);
 out_freesbi:
-	kfree(opt->iocharset);
 	kfree(sbi);
 	s->s_fs_info = NULL;
 	return error;
@@ -1528,7 +1525,10 @@ static int isofs_get_tree(struct fs_context *fc)
 
 static void isofs_free_fc(struct fs_context *fc)
 {
-	kfree(fc->fs_private);
+	struct isofs_options *opt = fc->fs_private;
+
+	kfree(opt->iocharset);
+	kfree(opt);
 }
 
 static const struct fs_context_operations isofs_context_ops = {
-- 
2.25.1


