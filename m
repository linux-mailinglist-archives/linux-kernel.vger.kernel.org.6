Return-Path: <linux-kernel+bounces-573566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EFEA6D929
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6AE16D26E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075B325DB03;
	Mon, 24 Mar 2025 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4UfHK+O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AF51E633C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742815977; cv=none; b=QIFGPcbXjY84oP9WaLO3a8qYUjdRib5h0+eDKVPPsSFGwOIR741vUzaaDiaf7lK2myzBPer9njpI2g1dqvsOSVnJlBKXOyytbFyRjv+diubkL7Q2TMOkWfUzLZTYBKzcc40sywk/zHOkKQiqQDhyDm4IVN4xXlcJrWiUtGZCeRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742815977; c=relaxed/simple;
	bh=5Yn65Sps6cRl4jPJWN59bRCzqlR4K0otJY2F4LcuGwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dSxwGkEPA9Hk5y1kYPV+90QvXB3TxG9z3BUAoFEV+CSmioflZhp/R7G08J5X70bePtKJ65FjyKk8eJ4UZNZ2Y3Y5187h+dK1u9h1/Sx0qttiC3nEnf8FDeGKeyLjSD8mbO/nsrzhlI8h6e0V6WLbFJKko4CQTwqVb2g0n7PA6ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4UfHK+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA609C4CEDD;
	Mon, 24 Mar 2025 11:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742815976;
	bh=5Yn65Sps6cRl4jPJWN59bRCzqlR4K0otJY2F4LcuGwA=;
	h=From:To:Cc:Subject:Date:From;
	b=e4UfHK+OL8Q31jb9UOaEEVElbrxhRKASLh4wB1HYs2ZsANBQ39vGcP37D3Yl+XK0a
	 aPUtIeO0y4OFyjyCFPf1JM40sA0FbNAoLjvmrw/RV4TBfZGidEBh5R52UU//R+wfyO
	 wpwZGTm2p53ZBS63iBHxO8DdX4Psa2UsARRx/tuQQX+TkwaurMbojdkEnG/7WI++Oc
	 5azHQxhw8GWC8PAWm2lcyOWJU3u5BVBXGZmj/axKgTHoEPffVOa6NNbEkBiFpFc0TX
	 xEDeqCYDKRdd4sSPAHDH8PjxL0jmrFS3q23fuGXSmSWqnyDVqO07bOA8P0VrNd69vk
	 9u4vh2ZSC3V3w==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: add a fast path in finish_preallocate_blocks()
Date: Mon, 24 Mar 2025 19:32:49 +0800
Message-ID: <20250324113249.3084413-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch uses i_sem to protect access/update on f2fs_inode_info.flag
in finish_preallocate_blocks(), it avoids grabbing inode_lock() in
each open().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index abbcbb5865a3..bb6ba3269de0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -554,19 +554,24 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 static int finish_preallocate_blocks(struct inode *inode)
 {
-	int ret;
+	int ret = 0;
+	bool opened;
 
-	inode_lock(inode);
-	if (is_inode_flag_set(inode, FI_OPENED_FILE)) {
-		inode_unlock(inode);
+	f2fs_down_read(&F2FS_I(inode)->i_sem);
+	opened = is_inode_flag_set(inode, FI_OPENED_FILE);
+	f2fs_up_read(&F2FS_I(inode)->i_sem);
+	if (opened)
 		return 0;
-	}
 
-	if (!file_should_truncate(inode)) {
-		set_inode_flag(inode, FI_OPENED_FILE);
-		inode_unlock(inode);
-		return 0;
-	}
+	inode_lock(inode);
+	f2fs_down_read(&F2FS_I(inode)->i_sem);
+	opened = is_inode_flag_set(inode, FI_OPENED_FILE);
+	f2fs_up_read(&F2FS_I(inode)->i_sem);
+	if (opened)
+		goto out_unlock;
+
+	if (!file_should_truncate(inode))
+		goto out_update;
 
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
@@ -576,16 +581,17 @@ static int finish_preallocate_blocks(struct inode *inode)
 
 	filemap_invalidate_unlock(inode->i_mapping);
 	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-
-	if (!ret)
-		set_inode_flag(inode, FI_OPENED_FILE);
-
-	inode_unlock(inode);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	file_dont_truncate(inode);
-	return 0;
+out_update:
+	f2fs_down_write(&F2FS_I(inode)->i_sem);
+	set_inode_flag(inode, FI_OPENED_FILE);
+	f2fs_up_write(&F2FS_I(inode)->i_sem);
+out_unlock:
+	inode_unlock(inode);
+	return ret;
 }
 
 static int f2fs_file_open(struct inode *inode, struct file *filp)
-- 
2.48.1


