Return-Path: <linux-kernel+bounces-510648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3C6A31FF6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263FC168B20
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAFC2046A9;
	Wed, 12 Feb 2025 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J81eFXJ7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1B420458B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739345276; cv=none; b=cIo7X9R8pDQrWCVwFjgM8scFu7rsFNQpHyKeQvatcKSEyqwsfy/gOyY3p2gmOcL2tsenbKon0vesCEQOlVneaO/MDT7eTr31Xqq4hYRKXfD4JuYG+hTikGFoLX9pwKFvTwNGFDyHe6c5sv3gIDTkeQMBg2miWWkMx3+JoEPbhIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739345276; c=relaxed/simple;
	bh=sdksGRP2vixl/lXNtlPoxYaFwobAYlGWEnGCtPc53N8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I/PEbn0xgwLqZK2rGXZP843HIo6pgbxT+MwqS2Hvnzn1Rt8+qApW4hZ9WHiLyMoxKShZC3Le4KYbEVBm14f5iW09qbfvkaN9MHrQglqAVQFjvqoaE78dZmuuMib0B3tJOxtrJAyf/7r0fi/lxGLUiaLqJzIc51pm2AvcqR8lloY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J81eFXJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBAAC4CEE8;
	Wed, 12 Feb 2025 07:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739345276;
	bh=sdksGRP2vixl/lXNtlPoxYaFwobAYlGWEnGCtPc53N8=;
	h=From:To:Cc:Subject:Date:From;
	b=J81eFXJ7lsepQan7xtGidQhqputQKJeEDGpWnvvU42NyDdYg4PvgnkGzHROx8+MjQ
	 jD1yfR36tUfyp7dlzCkYKtWZMlrHEn4yn8HDRwTSwyeK+vqREghJu8UWuxl66QNQmD
	 U0Rk6Q7Rj6nSWPpJIsiY26xHqkiGRRw17/YmwjsWm84BhCZxFqsZovZ+e5mCfw0X5k
	 Wq0eTlmZWttkSKgxCiyu9hQYcbNKm51+cddlCjUdaq0WbON8w5ew+AV+ZFHkmbgaJM
	 JQA6JJHggUATiDVA6UhRzKoOjmYm4x6H6Pjb2lBU1Re5IeZtAp3bIyavUD+HpwV/kw
	 ZJIt/5g0IwN3g==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Leo Stone <leocstone@gmail.com>,
	syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v4] f2fs: add check for deleted inode
Date: Wed, 12 Feb 2025 15:27:42 +0800
Message-ID: <20250212072742.977248-1-chao@kernel.org>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leo Stone <leocstone@gmail.com>

The syzbot reproducer mounts a f2fs image, then tries to unlink an
existing file. However, the unlinked file already has a link count of 0
when it is read for the first time in do_read_inode().

Add a check to sanity_check_inode() for i_nlink == 0.

[Chao Yu: rebase the code and fix orphan inode recovery issue]
Reported-by: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b01a36acd7007e273a83
Fixes: 39a53e0ce0df ("f2fs: add superblock and major in-memory structure")
Signed-off-by: Leo Stone <leocstone@gmail.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 4 ++++
 fs/f2fs/f2fs.h       | 1 +
 fs/f2fs/inode.c      | 6 ++++++
 3 files changed, 11 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index bd890738b94d..ada2c548645c 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -751,6 +751,8 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	if (is_sbi_flag_set(sbi, SBI_IS_WRITABLE))
 		f2fs_info(sbi, "orphan cleanup on readonly fs");
 
+	set_sbi_flag(sbi, SBI_ORPHAN_RECOVERY);
+
 	start_blk = __start_cp_addr(sbi) + 1 + __cp_payload(sbi);
 	orphan_blocks = __start_sum_addr(sbi) - 1 - __cp_payload(sbi);
 
@@ -778,9 +780,11 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 		}
 		f2fs_put_page(page, 1);
 	}
+
 	/* clear Orphan Flag */
 	clear_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG);
 out:
+	clear_sbi_flag(sbi, SBI_ORPHAN_RECOVERY);
 	set_sbi_flag(sbi, SBI_IS_RECOVERED);
 
 	return err;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 05879c6dc4d6..1c75081c0c14 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1322,6 +1322,7 @@ enum {
 	SBI_IS_CLOSE,				/* specify unmounting */
 	SBI_NEED_FSCK,				/* need fsck.f2fs to fix */
 	SBI_POR_DOING,				/* recovery is doing or not */
+	SBI_ORPHAN_RECOVERY,			/* orphan inodes recovery is doing */
 	SBI_NEED_SB_WRITE,			/* need to recover superblock */
 	SBI_NEED_CP,				/* need to checkpoint */
 	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index d6ad7810df69..02f1b69d03d8 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -386,6 +386,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		}
 	}
 
+	if (inode->i_nlink == 0 && !is_sbi_flag_set(sbi, SBI_ORPHAN_RECOVERY)) {
+		f2fs_warn(sbi, "%s: inode (ino=%lx) has a link count of 0",
+			  __func__, inode->i_ino);
+		return false;
+	}
+
 	return true;
 }
 
-- 
2.48.1.502.g6dc24dfdaf-goog


