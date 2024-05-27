Return-Path: <linux-kernel+bounces-191210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D638D080E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28172A9009
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558CE15A84E;
	Mon, 27 May 2024 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pWSJrdzm"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD1A155CBA
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826499; cv=none; b=g7TvH1NmWC/6bvflgY4gyiwF0zLh65fc/9tII2+6ee8fxKy/6y+JvoVtNENEGPP5BLu+lcmIWHNeBpDDRVOoZ4BNXfCFEHLRkG8qKRU2FdCpxqzl3FQ9cSa7TunaWA8E+vHyGjggtbqoH4XQyF4h8IaPmkYyS1pZwIXOguOJzXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826499; c=relaxed/simple;
	bh=mDqPw03z1INldEN1n/0pBYaeYCz5BWHtTiuNavY06ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fRptGcmyULYko+qnVSu1f4syrPZk96QvuDM2uNJphqB2wJH+azSlJ43u443LPJqJoDucP/rp2fTXJ3EjazNtPWh5EkhAizldfZI0Hub1p/uO/I2CJbKkC1uAcW9PvHKe64j8ZNE1ghz5TZkYYZQu5Myl4Sm+NrUkNcs91SDjZNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pWSJrdzm; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tytso@mit.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716826496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iolobSHI8WMmsdMwomRdpBAacDRAgxWFZ/JZJ8XKCOs=;
	b=pWSJrdzmTsL+rcs0OUzCeWZ9lDoZxaF7xvuPYH5vBSih5bVVfElbMocVISYIk9PY36sjy/
	0YsTfYx7HxkUL5GavaZ61Vz7zXsPgXK5vq/YSZNddF7oAGCN+ror3P+WflOIgm7XykqR6S
	2n1rE8PmZjnwaJRVXUy1MA9D1HqKoIs=
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: adilger@dilger.ca
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: luis.henriques@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH] ext4: use ext4_update_inode_fsync_trans() helper in inode creation
Date: Mon, 27 May 2024 17:14:47 +0100
Message-ID: <20240527161447.21434-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Call helper function ext4_update_inode_fsync_trans() instead of open
coding it in __ext4_new_inode().  This helper checks both that the handle
is valid *and* that it hasn't been aborted due to some fatal error in the
journalling layer, using is_handle_aborted().

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 fs/ext4/ialloc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index e9bbb1da2d0a..9dfd768ed9f8 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1336,10 +1336,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		}
 	}
 
-	if (ext4_handle_valid(handle)) {
-		ei->i_sync_tid = handle->h_transaction->t_tid;
-		ei->i_datasync_tid = handle->h_transaction->t_tid;
-	}
+	ext4_update_inode_fsync_trans(handle, inode, 1);
 
 	err = ext4_mark_inode_dirty(handle, inode);
 	if (err) {

