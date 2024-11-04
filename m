Return-Path: <linux-kernel+bounces-394100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3109BAA8E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 02:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710901F22CAC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 01:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EC47E0E8;
	Mon,  4 Nov 2024 01:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/tgXmR6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487693214
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 01:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730685022; cv=none; b=bUgBH0RuXTuBtBkoynvxvEw5E0gPKpPKS2Z0nx/VX/vXWp+u6srwXG4iwqkQ+FkShE7dPImOBGyzHcM1+idu8We5nBmrRlzHuWdon1XAK+VNFkxe534pXY745O/GeASskhFFWkoRq4+4+zn7H50VuuThGVlElowkxk5y5NPHNEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730685022; c=relaxed/simple;
	bh=aCDNknjyJPTTxvZz05v36HJhR5zaHHfhMWUotDphryc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ELjQv5WpH89wtWMWNpw+4JZxiSmRqRYtRiQb2ZB/Ydf7kcSKHkyKv1rI+mtWScaNw5ou6uBI9qmw6j1BTES2k08vKmS1cOEUfPeLLJu3NQH4CmPBB0dkj2ibwEeCPl3esdmdYd1lIXiDMAeJ54W8WZmm5hu61fbEPU+jOw+GVp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/tgXmR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89ADBC4CECD;
	Mon,  4 Nov 2024 01:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730685021;
	bh=aCDNknjyJPTTxvZz05v36HJhR5zaHHfhMWUotDphryc=;
	h=From:To:Cc:Subject:Date:From;
	b=c/tgXmR6T7sY67fw9a23TGe6EgJ5sQRswFUwGwmLbgPATVjWtcEDRUKb/1lffQ7KW
	 4bMm23COrmROoDrqOxMV1vOH573pvScsy29hjc0uCSPHZxI4D91Qwt1tFxU9/L454H
	 jYf8ncOFd5ly+jIK4eBWhPRfTohjqLbyMCfV9DSt52AZKXDfn5Og4huy0Rj/I7evL+
	 IwePHdOiCIlnYXqMDG9c7ATZpjFGTbtXiTWT2wojGcBOn3aVcGzc0Bw8loeH6MmI5p
	 ImkYKtQWaDhzCJtl3J3/JDmiQ0SQ+BurnKfV+vJxKNPPtGic/AXOrVoJ3cEZM9UKpg
	 7O9Z24XtOa8Ig==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Jinsu Lee <jinsu1.lee@samsung.com>
Subject: [PATCH] f2fs: fix to avoid forcing direct write to use buffered IO on inline_data inode
Date: Mon,  4 Nov 2024 09:50:16 +0800
Message-Id: <20241104015016.228963-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jinsu Lee reported a performance regression issue, after commit
5c8764f8679e ("f2fs: fix to force buffered IO on inline_data
inode"), we forced direct write to use buffered IO on inline_data
inode, it will cause performace regression due to memory copy
and data flush.

It's fine to not force direct write to use buffered IO, as it
can convert inline inode before committing direct write IO.

Fixes: 5c8764f8679e ("f2fs: fix to force buffered IO on inline_data inode")
Reported-by: Jinsu Lee <jinsu1.lee@samsung.com>
Closes: https://lore.kernel.org/linux-f2fs-devel/af03dd2c-e361-4f80-b2fd-39440766cf6e@kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0e7a0195eca8..377a10b81bf3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -883,7 +883,11 @@ static bool f2fs_force_buffered_io(struct inode *inode, int rw)
 		return true;
 	if (f2fs_compressed_file(inode))
 		return true;
-	if (f2fs_has_inline_data(inode))
+	/*
+	 * only force direct read to use buffered IO, for direct write,
+	 * it expects inline data conversion before committing IO.
+	 */
+	if (f2fs_has_inline_data(inode) && rw == READ)
 		return true;
 
 	/* disallow direct IO if any of devices has unaligned blksize */
-- 
2.40.1


