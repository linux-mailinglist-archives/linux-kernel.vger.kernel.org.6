Return-Path: <linux-kernel+bounces-338297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3B798560D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB1F2B2254A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7E413D291;
	Wed, 25 Sep 2024 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Dk5MkyBL"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AD4136E01
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727255172; cv=none; b=fpM/jKYbXT1W/EYYOA7uE2Xa1/mvmRpmew+TcE89AJolo2Vwqt0Zxyl0fI9CASGTK/LtqX7otfo8mlM0BbsEZsLJUzqeajHf/GrptztRWXkzmS8hyov9s6BD6sl2PJSLuxjpnGs8idTJx99e+pqN9pNoWx+3kkUH8tGCTWYP54o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727255172; c=relaxed/simple;
	bh=CtYJKhN56Tkn2nTyWC//bspec045L3XtMKbo8OzVVIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G9Aqwa3zPRAT+VxScRbKm9wsf61AYmh2heC8q0m846ksrOogwRJAjbIIqMfN9QccUt3GzJye+QJwX6DAdB9+RBSn5uJTZgzdUejn0o4SgSFM+trK2M/51UjBu4MUdSPhoCumrLlNr4Gx/8Q7GigYrkMHNrm6edIuBtr4wHA+85M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Dk5MkyBL; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727255161; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=fa+kLf6gy5U/3Q/eBaW0VYx6czuibDXvJZbaeNqxg9M=;
	b=Dk5MkyBLXxm3AjWbOO9OuH7Kain7cz4Pm9S0au8FqPesIO2cXhBrBQI8hGhAnmB01bBQR12eetazUJ7x4diXsZH6pFciLtA+I3hTpK+8Y5+MwrfBbxGPWXYjTZ0x2wjYDAKtVranyoY6WU1wZUtKvZ/AFXp0cZzSfLR28u++cuQ=
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WFjCWdW_1727255160)
          by smtp.aliyun-inc.com;
          Wed, 25 Sep 2024 17:06:01 +0800
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Heming Zhao <heming.zhao@suse.com>
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+9709e73bae885b05314b@syzkaller.appspotmail.com
Subject: [PATCH] ocfs2: fix uninit-value in ocfs2_get_block()
Date: Wed, 25 Sep 2024 17:06:00 +0800
Message-Id: <20240925090600.3643376-1-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported an uninit-value BUG:

BUG: KMSAN: uninit-value in ocfs2_get_block+0xed2/0x2710 fs/ocfs2/aops.c:159
ocfs2_get_block+0xed2/0x2710 fs/ocfs2/aops.c:159
do_mpage_readpage+0xc45/0x2780 fs/mpage.c:225
mpage_readahead+0x43f/0x840 fs/mpage.c:374
ocfs2_readahead+0x269/0x320 fs/ocfs2/aops.c:381
read_pages+0x193/0x1110 mm/readahead.c:160
page_cache_ra_unbounded+0x901/0x9f0 mm/readahead.c:273
do_page_cache_ra mm/readahead.c:303 [inline]
force_page_cache_ra+0x3b1/0x4b0 mm/readahead.c:332
force_page_cache_readahead mm/internal.h:347 [inline]
generic_fadvise+0x6b0/0xa90 mm/fadvise.c:106
vfs_fadvise mm/fadvise.c:185 [inline]
ksys_fadvise64_64 mm/fadvise.c:199 [inline]
__do_sys_fadvise64 mm/fadvise.c:214 [inline]
__se_sys_fadvise64 mm/fadvise.c:212 [inline]
__x64_sys_fadvise64+0x1fb/0x3a0 mm/fadvise.c:212
x64_sys_call+0xe11/0x3ba0
arch/x86/include/generated/asm/syscalls_64.h:222
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f

This is because when ocfs2_extent_map_get_blocks() fails, p_blkno is
uninitialized. So the error log will trigger the above uninit-value
access.

The error log is out-of-date since get_blocks() was removed long time
ago. And the error code will be logged in ocfs2_extent_map_get_blocks()
once ocfs2_get_cluster() fails, so fix this by only logging inode and
block.

Link: https://syzkaller.appspot.com/bug?extid=9709e73bae885b05314b
Reported-by: syzbot+9709e73bae885b05314b@syzkaller.appspotmail.com
Tested-by: syzbot+9709e73bae885b05314b@syzkaller.appspotmail.com
Fixes: ccd979bdbce9 ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/ocfs2/aops.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 1fea43c33b6b..db72b3e924b3 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -156,9 +156,8 @@ int ocfs2_get_block(struct inode *inode, sector_t iblock,
 	err = ocfs2_extent_map_get_blocks(inode, iblock, &p_blkno, &count,
 					  &ext_flags);
 	if (err) {
-		mlog(ML_ERROR, "Error %d from get_blocks(0x%p, %llu, 1, "
-		     "%llu, NULL)\n", err, inode, (unsigned long long)iblock,
-		     (unsigned long long)p_blkno);
+		mlog(ML_ERROR, "get_blocks() failed, inode: 0x%p, "
+		     "block: %llu\n", inode, (unsigned long long)iblock);
 		goto bail;
 	}
 
-- 
2.39.3


