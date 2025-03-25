Return-Path: <linux-kernel+bounces-574893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BDDA6EB36
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 738977A440E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345E4253B6A;
	Tue, 25 Mar 2025 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyEVArTW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923121A5BA6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890406; cv=none; b=ubbS4D4fDJKm5uGSOVZhtAU90w449so2t9k3GhHNKhVXK9wfOxCTiYE9c+pqA2s+4boKaRs1yymia6t1iPHPc9/Q3TivjboP1qRUJdMcyuOAPryOPJF1vPWbliwcNhsKUP9MtqE2S8r3qRVy007Z2bBdbIhbMjpncFiUEREv7z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890406; c=relaxed/simple;
	bh=LtRdniLcPqa7ao3nLrAh74t9DlpseprTi8ntyDAeLik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dcV3FbP5kc33cgn74gXTKQrrLBH9MCmgYxnkiUc7BBcQlzzboOGniB5AXgZAj9nGDLL2KqHFEsc/vwpmWQ7SqHbvjsB+/KhilE36ih2SH8MAgzUY7LnLzqKZN2Twy/Al8gnJacCygEDJ02unGiYkhkljumnPJUE2k7lBPXhiabE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyEVArTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B29AC4CEE8;
	Tue, 25 Mar 2025 08:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742890406;
	bh=LtRdniLcPqa7ao3nLrAh74t9DlpseprTi8ntyDAeLik=;
	h=From:To:Cc:Subject:Date:From;
	b=MyEVArTWZinYlc0UyKhExD7y6Zsq8cAsvxIG1OUzHrmWdb5qzOErLKCig3Ry+zNDO
	 yhdqtSPQxB2x7YwGCI3sOYVbrAGUsweAt4Sk8IY867ibaDUatPNFzkApDxnBv9qIJQ
	 ky/O85t3knHqdBB+Lq4rNf+n2sFmFFwwJHG5S0uLjJi1jKAbL+6jLFgfSVnVd46KmC
	 tVKuOrrrOpMe3n5JkJaHZw0yj7ukc5dBqmzKjCLQ7hWqTgGcwX468a+WxsHCM5Rwue
	 KHmXaKQXfFXXU5XQh0gkzD9KF/qrIrgXGktvb9P+n4JiMlk3kxM3ZeXIpN/kDRwngX
	 cUSw9Ua2YAweA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: add a fast path in finish_preallocate_blocks()
Date: Tue, 25 Mar 2025 16:13:21 +0800
Message-ID: <20250325081321.3296714-1-chao@kernel.org>
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
v2:
- get rid of read lock during querying FI_OPENED_FILE once we held
inode lock.
 fs/f2fs/file.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index abbcbb5865a3..a71946976761 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -554,19 +554,21 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 
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
+	if (is_inode_flag_set(inode, FI_OPENED_FILE))
+		goto out_unlock;
+
+	if (!file_should_truncate(inode))
+		goto out_update;
 
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
@@ -576,16 +578,17 @@ static int finish_preallocate_blocks(struct inode *inode)
 
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


