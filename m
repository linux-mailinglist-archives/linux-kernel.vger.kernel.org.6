Return-Path: <linux-kernel+bounces-169683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7322A8BCC2B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35FC1C214EC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F047B14262C;
	Mon,  6 May 2024 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boV2IkvT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4532C762EF
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992131; cv=none; b=jRsk0A5bXFZIYBt1zpcF5njt33En4lU0CjwDY3K4qmaqrVC5HBzcQ/xLpIBJ8yqHBag7aKOZq/sdKRF+/7/Ro1X+KoPn/YGWwIllrkgJ0/d+hB8BM4zMvBSVTQOQtx0sd+YRS742HYcLoWWVvO/OOP1thmQNVj6QfEtRhR3LjwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992131; c=relaxed/simple;
	bh=v82z/f0v3qlNA/pUTvtaHNQodyv569B9p8AX3nujvZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P9uWTc/9hbUhAM/YroqsnPD6Iqo1fNGZZy6TYfIAFkRIe49OviaHi+InhTb/CNFrPq6jwJIGKwZgzCh1ZjRuA+UW1gLLW4e/HbeUxb5NEMFvO3sEzMDzYHExnW1K14UDO9nIkOv5MssgsjA18Fdl/8K73PPpOxZCpkhJ9IpUCWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boV2IkvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3AEC4AF63;
	Mon,  6 May 2024 10:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714992130;
	bh=v82z/f0v3qlNA/pUTvtaHNQodyv569B9p8AX3nujvZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=boV2IkvTKAOy7YPAYJ/6WZNNps3mLpo5SdXeM5EZN8FpPP/Pn2RRUM9tUTbEATUXm
	 dbAD+zMropII+XZY7MDHJKFVUtIJFrKCKE5AgpkikNdBWiIZROAqGbLw2nlZk1XQNs
	 EuM/c+V/LZ9XIc11EEdYIzN/vVH7mB+bOqVgqbnKLvGlAx96IwZ3CB6FZHT8S+Hiuj
	 7w0t7yz40dvcdJpECFuvBYgbEKu80LrGLP5nGwJYyX6a+gEUXNfeaZYfOY7n3Y00BN
	 sHwWbLWKzCU4zKlgQkyLaXjIz0kmbQ/5BMnCCGASy8bm5n86zB4xDZ8sCCda3MmIdl
	 gPh/QD7CnAD2A==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/5] f2fs: compress: fix error path of inc_valid_block_count()
Date: Mon,  6 May 2024 18:41:37 +0800
Message-Id: <20240506104140.776986-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240506104140.776986-1-chao@kernel.org>
References: <20240506104140.776986-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If inc_valid_block_count() can not allocate all requested blocks,
it needs to release block count in .total_valid_block_count and
resevation blocks in inode.

Fixes: 54607494875e ("f2fs: compress: fix to avoid inconsistence bewteen i_blocks and dnode")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c876813b5532..95a40d4f778f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2309,7 +2309,7 @@ static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
 static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 				 struct inode *inode, blkcnt_t *count, bool partial)
 {
-	blkcnt_t diff = 0, release = 0;
+	long long diff = 0, release = 0;
 	block_t avail_user_block_count;
 	int ret;
 
@@ -2329,26 +2329,27 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 	percpu_counter_add(&sbi->alloc_valid_block_count, (*count));
 
 	spin_lock(&sbi->stat_lock);
-	sbi->total_valid_block_count += (block_t)(*count);
-	avail_user_block_count = get_available_block_count(sbi, inode, true);
 
-	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
+	avail_user_block_count = get_available_block_count(sbi, inode, true);
+	diff = (long long)sbi->total_valid_block_count + *count -
+						avail_user_block_count;
+	if (unlikely(diff > 0)) {
 		if (!partial) {
 			spin_unlock(&sbi->stat_lock);
+			release = *count;
 			goto enospc;
 		}
-
-		diff = sbi->total_valid_block_count - avail_user_block_count;
 		if (diff > *count)
 			diff = *count;
 		*count -= diff;
 		release = diff;
-		sbi->total_valid_block_count -= diff;
 		if (!*count) {
 			spin_unlock(&sbi->stat_lock);
 			goto enospc;
 		}
 	}
+	sbi->total_valid_block_count += (block_t)(*count);
+
 	spin_unlock(&sbi->stat_lock);
 
 	if (unlikely(release)) {
-- 
2.40.1


