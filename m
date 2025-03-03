Return-Path: <linux-kernel+bounces-540922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CD5A4B675
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939CB16BA42
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828B21B21AD;
	Mon,  3 Mar 2025 03:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VM6JpyEl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C8F142900
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 03:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740972249; cv=none; b=W55X9vYmnqPRUiwCoGA8imXH8TW1axciPY5fLxrKmagQAk2RJQrjHF4CQgWxCquzfQRIJ1POzbG3CnvpzlB3/LcU1s1aa9jFvYUrmiTqVD8HCMFUFywHz69Eh02Byo74LJS/557pBQ9UmdOYvK2MBKkwBwxN5RVbzAUkhtl9KVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740972249; c=relaxed/simple;
	bh=RB8f6v1FChOFx3oTiK9roU5+20gBklSvWNyNHoGVju4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M92uJYqz9Ty/SqhQhIgAgWdwMgA4Un+/PmrZVjg6ztGF73if8159dHbQZzmKTMFnWT5QYVGauE32iey4PP9fqs0DWVv9OgQ3CDHjbtmk+SvEZ/sqQffEsw2d62XS8o/dcK5qVSBaxRwxjKqzSffC8NXzfRSCB5ly/+y5+b6EdtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VM6JpyEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40B9C4CED6;
	Mon,  3 Mar 2025 03:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740972248;
	bh=RB8f6v1FChOFx3oTiK9roU5+20gBklSvWNyNHoGVju4=;
	h=From:To:Cc:Subject:Date:From;
	b=VM6JpyElOBLl2jwsohZHzQmfDKiugxIRGBK2jUeETXUOwLFXwf41KVd/xGQC2NDGz
	 gkNhVKuuqY+LLysDXo7ojkX3LtwXbW7vAy0F/3zaIvvcgcImRyQGi9IbmZw6kBx6qc
	 l/M4enfHdXEuezwfslqXJ8EqhpI/N0d4ztqqLdpNtbP7YVbkeDZkY9ySfXoLrZieXq
	 P0Ub65CilqHwtVC9GAVa/mLCdEWZSbpjn0R7bKQasc/k46/546dNApBJJCSoS3ugQi
	 Q68TFUDuGp1S3NO7UWq/HWkda5X5Qx2f8GQSr4MIp+S4C3gSkA1cuEl0mYM/2qb1iU
	 406wkj5jA60mw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Jan Prusakowski <jprusakowski@google.com>
Subject: [PATCH] f2fs: fix potential deadloop in prepare_compress_overwrite()
Date: Mon,  3 Mar 2025 11:23:29 +0800
Message-ID: <20250303032329.1309786-1-chao@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jan Prusakowski reported a kernel hang issue as below:

When running xfstests on linux-next kernel (6.14.0-rc3, 6.12) I
encountered a problem in generic/475 test where fsstress process
gets blocked in __f2fs_write_data_pages() and the test hangs.
The options I used are:

MKFS_OPTIONS  -- -O compression -O extra_attr -O project_quota -O quota /dev/vdc
MOUNT_OPTIONS -- -o acl,user_xattr -o discard,compress_extension=* /dev/vdc /vdc

INFO: task kworker/u8:0:11 blocked for more than 122 seconds.
      Not tainted 6.14.0-rc3-xfstests-lockdep #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:0    state:D stack:0     pid:11    tgid:11    ppid:2      task_flags:0x4208160 flags:0x00004000
Workqueue: writeback wb_workfn (flush-253:0)
Call Trace:
 <TASK>
 __schedule+0x309/0x8e0
 schedule+0x3a/0x100
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock+0x59a/0xdb0
 __f2fs_write_data_pages+0x3ac/0x400
 do_writepages+0xe8/0x290
 __writeback_single_inode+0x5c/0x360
 writeback_sb_inodes+0x22f/0x570
 wb_writeback+0xb0/0x410
 wb_do_writeback+0x47/0x2f0
 wb_workfn+0x5a/0x1c0
 process_one_work+0x223/0x5b0
 worker_thread+0x1d5/0x3c0
 kthread+0xfd/0x230
 ret_from_fork+0x31/0x50
 ret_from_fork_asm+0x1a/0x30
 </TASK>

The root cause is: once generic/475 starts toload error table to dm
device, f2fs_prepare_compress_overwrite() will loop reading compressed
cluster pages due to IO error, meanwhile it has held .writepages lock,
it can block all other writeback tasks.

Let's fix this issue w/ below changes:
- add f2fs_handle_page_eio() in prepare_compress_overwrite() to
detect IO error.
- detect cp_error earler in f2fs_read_multi_pages().

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Reported-by: Jan Prusakowski <jprusakowski@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c |  1 +
 fs/f2fs/data.c     | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 985690d81a82..9b94810675c1 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1150,6 +1150,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 		f2fs_compress_ctx_add_page(cc, page_folio(page));
 
 		if (!PageUptodate(page)) {
+			f2fs_handle_page_eio(sbi, page_folio(page), DATA);
 release_and_retry:
 			f2fs_put_rpages(cc);
 			f2fs_unlock_rpages(cc, i + 1);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f1554a5a3d7a..09437dbd1b42 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2190,6 +2190,12 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	int i;
 	int ret = 0;
 
+	if (unlikely(f2fs_cp_error(sbi))) {
+		ret = -EIO;
+		from_dnode = false;
+		goto out_put_dnode;
+	}
+
 	f2fs_bug_on(sbi, f2fs_cluster_is_empty(cc));
 
 	last_block_in_file = F2FS_BYTES_TO_BLK(f2fs_readpage_limit(inode) +
@@ -2233,10 +2239,6 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	if (ret)
 		goto out;
 
-	if (unlikely(f2fs_cp_error(sbi))) {
-		ret = -EIO;
-		goto out_put_dnode;
-	}
 	f2fs_bug_on(sbi, dn.data_blkaddr != COMPRESS_ADDR);
 
 skip_reading_dnode:
-- 
2.48.1


