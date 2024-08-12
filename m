Return-Path: <linux-kernel+bounces-283258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9C294EF3B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA862283A24
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE4217D8A9;
	Mon, 12 Aug 2024 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2Nhj3jY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5693E33C5
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471974; cv=none; b=ILSwWoRyu1EY/McyGLyI6dqBwclN1XjmuGT5Pxh1Qzu218y4WmY+aYmRCAMZjq+aQXy0fM55oAOQYB8Bz6giHLrbjdYFwGu1hjF2TPJDrwSQ2ckEd3c3AQg7k2vpainCQXfrFZOuY/RIozZMXk3B7WsFvqYJDSXeEBlNHYa4cig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471974; c=relaxed/simple;
	bh=7gSDC/cYVMwFkYxC7WG5mpNOT6P1rABfpHlISArbjQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p+Vb7Jti6mikmGkHHH72aUN0LKRmfyrzGCF/Sopqzm6Aes4TPXdGCwbJwtimc3RzDvlDyNWXaD1eIzOArUizj5XEQuRhCbrllKCaJI/txMpi7ZQ/NAoP2BwyLy39Vq20H751itZbVIzHCkAJm/N7gPbU8zcrmVxfuh08coDwEvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2Nhj3jY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1EBC32782;
	Mon, 12 Aug 2024 14:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723471973;
	bh=7gSDC/cYVMwFkYxC7WG5mpNOT6P1rABfpHlISArbjQQ=;
	h=From:To:Cc:Subject:Date:From;
	b=h2Nhj3jY4l1WBltCi6rXWlfN2AIuo1Nr+RsYBAU/6mTIoTTDAUZwWcpy7HF0Cw0tR
	 PGcw/vZHLFAzLjHoaxfVCzGDfUiG+min1ofn4ehWim4NZ1UmvC+zKdGJVZ+1jAHien
	 rZwdXE1IENLkJp3fw365NkcU9WxhNnsfKrImxH83n3G1o4JFZTY4JeRokq/yOWZRJN
	 8355OUaAkmCkvfDBnzU5nq7zMCcZLEhZQg1iAaJ/Y/hRksYx+ox+V0A0qe3ckv/ju2
	 JmFqtOYEKqnuZx0riNenL0VjxCjNaz702q1p7pKvrTrxOM7OYmrRlgTXnTYCDns05R
	 IuxqzAx56LAaw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to wait page writeback before setting gcing flag
Date: Mon, 12 Aug 2024 22:12:42 +0800
Message-Id: <20240812141242.4159033-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Soft IRQ				Thread
- f2fs_write_end_io
					- f2fs_defragment_range
					 - set_page_private_gcing
 - type = WB_DATA_TYPE(page, false);
 : assign type w/ F2FS_WB_CP_DATA
 due to page_private_gcing() is true
  - dec_page_count() w/ wrong type
  - end_page_writeback()

Value of F2FS_WB_CP_DATA reference count may become negative under above
race condition, the root cause is we missed to wait page writeback before
setting gcing page private flag, let's fix it.

Fixes: 2d1fe8a86bf5 ("f2fs: fix to tag gcing flag on page during file defragment")
Fixes: 4961acdd65c9 ("f2fs: fix to tag gcing flag on page during block migration")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index eaa39c50f782..56e27e305600 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2817,6 +2817,8 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 				goto clear_out;
 			}
 
+			f2fs_wait_on_page_writeback(page, DATA, true, true);
+
 			set_page_dirty(page);
 			set_page_private_gcing(page);
 			f2fs_put_page(page, 1);
@@ -4217,6 +4219,8 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 		/* It will never fail, when page has pinned above */
 		f2fs_bug_on(F2FS_I_SB(inode), !page);
 
+		f2fs_wait_on_page_writeback(page, DATA, true, true);
+
 		set_page_dirty(page);
 		set_page_private_gcing(page);
 		f2fs_put_page(page, 1);
-- 
2.40.1


