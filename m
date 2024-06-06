Return-Path: <linux-kernel+bounces-204068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 196A78FE395
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4B7286076
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C281802DA;
	Thu,  6 Jun 2024 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sp+/mZ1D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4472317F4E7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667697; cv=none; b=PoASQ7GXomRJeNsMS8aIWbWP2qgY0joUUw3jwh8gKvc8t4rmfMKw7WfgVvbc1cJApS2rRBlpDYQhlOdJHxBYVO1l4kwq4gQi/RViEcDdfFJkFsEJQlTbVtUXn79M26bPq4SnihNCWjWoYrWuVYUPavBReyJGDEQaJbsK8dade7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667697; c=relaxed/simple;
	bh=GNpmoUqNJ5Xzdvywh8sIQ3KCs7bJubcVgL87Sik46R0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f4Lczg4aHJ/kBtovvNC8b7fXWzmJ7iNGtr9dhu8jDpUNvIURZMnmqOGl1mP2xNCii+NH5utMO0tsAr/cXEXMKdZwNFhZLMRHiU13vXV4m7fyoSS2fpVb3ohyZisV88wZhipAdIk5RI4ucy90MuSe9RpwURq6ftfFNwuOfzx3zpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sp+/mZ1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FA1C4AF0B;
	Thu,  6 Jun 2024 09:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717667696;
	bh=GNpmoUqNJ5Xzdvywh8sIQ3KCs7bJubcVgL87Sik46R0=;
	h=From:To:Cc:Subject:Date:From;
	b=Sp+/mZ1DDMC7/qtA4SInsKKdOF3SmxZP1uldo8Ec63DG2w07Fxk2pFOaQCbhk0KKm
	 XWRCh+ws2PXyLc7b2rEF2PXtUGGlFVrT1WXM/dFbEWItPhOfQyduE/V/t0dafCl5kF
	 Z4jgd3jn/jxADd5y+Mva+Mv3jKBjG9Y+tID+l2skQC88THT/eUX6rpU5KSjnGgHIse
	 Od2kJXhMEOfLyfKlkaNzzpjwwJDTQR3ghPcaGO5jAhhFY4xgImxKaU4fcIemrDuXoA
	 UW8UzbgBPM/QAOer/RjAMe4jzgoHtM+yS+CZpJiFA3BydGoYv4BHpPb60y4BD+Wxxy
	 p1zMGEA7tSZbA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Yunlei He <heyunlei@oppo.com>
Subject: [PATCH] f2fs: fix to update user block counts in block_operations()
Date: Thu,  6 Jun 2024 17:54:51 +0800
Message-Id: <20240606095451.4088735-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 59c9081bc86e ("f2fs: allow write page cache when writting cp")
allows write() to write data to page cache during checkpoint, so block
count fields like .total_valid_block_count, .alloc_valid_block_count
and .rf_node_block_count may encounter race condition as below:

CP				Thread A
- write_checkpoint
 - block_operations
  - f2fs_down_write(&sbi->node_change)
  - __prepare_cp_block
  : ckpt->valid_block_count = .total_valid_block_count
  - f2fs_up_write(&sbi->node_change)
				- write
				 - f2fs_preallocate_blocks
				  - f2fs_map_blocks(,F2FS_GET_BLOCK_PRE_AIO)
				   - f2fs_map_lock
				    - f2fs_down_read(&sbi->node_change)
				   - f2fs_reserve_new_blocks
				    - inc_valid_block_count
				    : percpu_counter_add(&sbi->alloc_valid_block_count, count)
				    : sbi->total_valid_block_count += count
				    - f2fs_up_read(&sbi->node_change)
 - do_checkpoint
 : sbi->last_valid_block_count = sbi->total_valid_block_count
 : percpu_counter_set(&sbi->alloc_valid_block_count, 0)
 : percpu_counter_set(&sbi->rf_node_block_count, 0)
				- fsync
				 - need_do_checkpoint
				  - f2fs_space_for_roll_forward
				  : alloc_valid_block_count was reset to zero,
				    so, it may missed last data during checkpoint

Let's change to update .total_valid_block_count, .alloc_valid_block_count
and .rf_node_block_count in block_operations(), then their access can be
protected by .node_change and .cp_rwsem lock, so that it can avoid above
race condition.

Fixes: 59c9081bc86e ("f2fs: allow write page cache when writting cp")
Cc: Yunlei He <heyunlei@oppo.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 66eaad591b60..010bbd5af211 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1298,6 +1298,12 @@ static int block_operations(struct f2fs_sb_info *sbi)
 	 * dirty node blocks and some checkpoint values by block allocation.
 	 */
 	__prepare_cp_block(sbi);
+
+	/* update user_block_counts */
+	sbi->last_valid_block_count = sbi->total_valid_block_count;
+	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
+	percpu_counter_set(&sbi->rf_node_block_count, 0);
+
 	f2fs_up_write(&sbi->node_change);
 	return err;
 }
@@ -1575,11 +1581,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		start_blk += NR_CURSEG_NODE_TYPE;
 	}
 
-	/* update user_block_counts */
-	sbi->last_valid_block_count = sbi->total_valid_block_count;
-	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
-	percpu_counter_set(&sbi->rf_node_block_count, 0);
-
 	/* Here, we have one bio having CP pack except cp pack 2 page */
 	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
 	/* Wait for all dirty meta pages to be submitted for IO */
-- 
2.40.1


