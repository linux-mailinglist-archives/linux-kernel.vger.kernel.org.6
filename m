Return-Path: <linux-kernel+bounces-175263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758198C1D26
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29CB61F2188F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06449149DE9;
	Fri, 10 May 2024 03:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxJXsYrJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D097149C7B
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 03:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715312620; cv=none; b=rI/zJbEwIgHmipAgUmcQMT5HyC7/v+SH12qRnKf8reYH+39JvNvRpnnZ3ZMq/YP4I9//AJkRHm8ukVGtHpbc8HrjPBEy4xBymb/yl/teNtOCbSe6n4Z78gmKUFXJT5/i2xB0/sOlMFvXfPPAwO86xLZ8vImdhJRw3rLCECneH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715312620; c=relaxed/simple;
	bh=26S/wLyNbf+8N1bKoCdjjtV3ExKiUVLPx3+HHDN4lT8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s5HgDOD5F7R3ijpSquQA4xMwJmP/MJmyII+0BO8EdAUVzul1C60Dbzp1STlLWDhy6poMY1lLC1jBJj3ZCWTpc2NRb752QSrWyqnjykPXPjZTpB8Va+/06kvlU8ykCX5G6B+LGz7rvayxyhS+xNfNwXSPgNdkl+igORyFtRt4Hv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxJXsYrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF0FC113CC;
	Fri, 10 May 2024 03:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715312619;
	bh=26S/wLyNbf+8N1bKoCdjjtV3ExKiUVLPx3+HHDN4lT8=;
	h=From:To:Cc:Subject:Date:From;
	b=jxJXsYrJxzgp0rFoAf14zhFKuKl2CFtJl3j9DPQXefWPbOSBvDcGuHss8iBTy8dhk
	 sDh1YsjLgJXNupOHbCJ841Tc4aCdtxnBiDTkodDU+3Jw/nINTVKleRRGSEPE8MhVj2
	 w7zgQmr1g6V/V+rfiyZzDIzSAszwMZmbfSr1lW7xbdmLb9uZjlsfYWLDUo8egchsvz
	 RTPQwe2UzT6BrFbUqp5A1CBNF8hSHE72W+TqpN3gIssHlNtVopnMOPnixQ+mp2v947
	 nll9uYIeX4dNLmWpxnCxfWjZybdaJl+Z7WRigUMk7RSseuMFQc/Crx528LacIu11es
	 WgaHvGh6XsDEg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 2/3] f2fs: fix to add missing iput() in gc_data_segment()
Date: Fri, 10 May 2024 11:43:33 +0800
Message-Id: <20240510034333.358653-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During gc_data_segment(), if inode state is abnormal, it missed to call
iput(), fix it.

Fixes: b73e52824c89 ("f2fs: reposition unlock_new_inode to prevent accessing invalid inode")
Fixes: 9056d6489f5a ("f2fs: fix to do sanity check on inode type during garbage collection")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix wrong fixes tag line.
 fs/f2fs/gc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ac4cbbe50c2f..6066c6eecf41 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1554,10 +1554,15 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			int err;
 
 			inode = f2fs_iget(sb, dni.ino);
-			if (IS_ERR(inode) || is_bad_inode(inode) ||
-					special_file(inode->i_mode))
+			if (IS_ERR(inode))
 				continue;
 
+			if (is_bad_inode(inode) ||
+					special_file(inode->i_mode)) {
+				iput(inode);
+				continue;
+			}
+
 			err = f2fs_gc_pinned_control(inode, gc_type, segno);
 			if (err == -EAGAIN) {
 				iput(inode);
-- 
2.40.1


