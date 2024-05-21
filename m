Return-Path: <linux-kernel+bounces-184521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE5B8CA7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1623D282379
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 06:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B9B4597A;
	Tue, 21 May 2024 06:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNrqp1/q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D9014286
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716272605; cv=none; b=n6yNFPBuAyREwt8VCP4VMaiawHMVjSLZDuOH3iCYuBr4fAanMpMuEwjbqtJGvpV5CPyRO0lGGZk6kDLdfbbgR5BT4v09j/19aHc/r+/dVlIhmkthGjnDIkrizIBa2og95yRUe1WH3yIuBSoF1bNNEGYmHnSEy+vXp7vX6YKS9o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716272605; c=relaxed/simple;
	bh=odx4SQSvXrGL/qq166LumzG7isir+IkfTpnUohZn0So=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GkuGd5PNDJVBqOpuN65frIII/UocVBrudfCry2Fak1ipTUKmTB+QxGPxBSV8rAhjNj5qXtYHBzIzuzFN06m/4iqbEXpBwAhsyYJNgPv/x8NrbbvzlESPj5nrB8T6qizoKy6IW0JWyKbxaGvMJJ+OpuZOcH+tpdcsnoUqomTTSYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNrqp1/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8000C2BD11;
	Tue, 21 May 2024 06:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716272604;
	bh=odx4SQSvXrGL/qq166LumzG7isir+IkfTpnUohZn0So=;
	h=From:To:Cc:Subject:Date:From;
	b=qNrqp1/qHfT7ahY/xryTTZIg3E0pD7/U7AiJGmU7jbniebzOK57fSeKbEOwIZd//2
	 Afe9+vMvEFlGwaWKjVTFCodVsoKR/S9pRlCBX95Mp8Ul/lvAWwHi+enD4s3CTWcABb
	 2OOYuOCggiYljTipsT34rTAK3nfLmSFqQ87XlnVyCDejtlD8Nd6movo33n/EfHr7Ke
	 76TGAiVuntnCxMEkE735iSMou7f0ts/Cqy0T479F7enqDrVrXut51o4bd98ptI3QvJ
	 plEeDGA4ntqRvbc7GCojMSHV5WUUT7RsAejewPF8pn6NjUkz47KTC5Mkrj6ow0w24n
	 4sO2JBs/pU2Ug==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com
Subject: [PATCH 1/2] f2fs: fix to do sanity check on F2FS_INLINE_DATA flag in inode during GC
Date: Tue, 21 May 2024 14:23:17 +0800
Message-Id: <20240521062318.976239-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports a f2fs bug as below:

------------[ cut here ]------------
kernel BUG at fs/f2fs/inline.c:258!
CPU: 1 PID: 34 Comm: kworker/u8:2 Not tainted 6.9.0-rc6-syzkaller-00012-g9e4bc4bcae01 #0
RIP: 0010:f2fs_write_inline_data+0x781/0x790 fs/f2fs/inline.c:258
Call Trace:
 f2fs_write_single_data_page+0xb65/0x1d60 fs/f2fs/data.c:2834
 f2fs_write_cache_pages fs/f2fs/data.c:3133 [inline]
 __f2fs_write_data_pages fs/f2fs/data.c:3288 [inline]
 f2fs_write_data_pages+0x1efe/0x3a90 fs/f2fs/data.c:3315
 do_writepages+0x35b/0x870 mm/page-writeback.c:2612
 __writeback_single_inode+0x165/0x10b0 fs/fs-writeback.c:1650
 writeback_sb_inodes+0x905/0x1260 fs/fs-writeback.c:1941
 wb_writeback+0x457/0xce0 fs/fs-writeback.c:2117
 wb_do_writeback fs/fs-writeback.c:2264 [inline]
 wb_workfn+0x410/0x1090 fs/fs-writeback.c:2304
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa12/0x17c0 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f2/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The root cause is: inline_data inode can be fuzzed, so that there may
be valid blkaddr in its direct node, once f2fs triggers background GC
to migrate the block, it will hit f2fs_bug_on() during dirty page
writeback.

Let's add sanity check on F2FS_INLINE_DATA flag in inode during GC,
so that, it can forbid migrating inline_data inode's data block for
fixing.

Reported-by: syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/000000000000d103ce06174d7ec3@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/gc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6066c6eecf41..20e2f989013b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1563,6 +1563,16 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 				continue;
 			}
 
+			if (f2fs_has_inline_data(inode)) {
+				iput(inode);
+				set_sbi_flag(sbi, SBI_NEED_FSCK);
+				f2fs_err_ratelimited(sbi,
+					"inode %lx has both inline_data flag and "
+					"data block, nid=%u, ofs_in_node=%u",
+					inode->i_ino, dni.nid, ofs_in_node);
+				continue;
+			}
+
 			err = f2fs_gc_pinned_control(inode, gc_type, segno);
 			if (err == -EAGAIN) {
 				iput(inode);
-- 
2.40.1


