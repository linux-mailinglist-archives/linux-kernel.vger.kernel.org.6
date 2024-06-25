Return-Path: <linux-kernel+bounces-228204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79124915C4B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359B1285F55
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525B249657;
	Tue, 25 Jun 2024 02:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWV/9sMW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5344962F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719282770; cv=none; b=HGJeOYORznyoL5YfkEMHfOk5K+5eq3L+XKHpQjZCxBxiSUrEA6RYQYvuchmfHUdXsnTm3fqldaTKO5vuNGcdPgEBZaf0tPzBoYPkEmbsSSF7vL2Lyl+dYCnXyZKm435uLwlePs1mKLQ09y8Iuk8Qk+0svYx8Eengzmm6xLJRYcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719282770; c=relaxed/simple;
	bh=iQ7FxTqeAItqesS1ZPu7HixwlemAIsTeA636rrAw/M0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JlAHvLps0DHPKUP8PiinbdXlNcX1p90VOUL+n3Z1MvR5iGzXFS2JZddsiHcNWR9lLhsKUaBnGctywEkAIpCKgfmT/9TgZFjiJiiyoTunieMMKGH0uWW/pC3guphcqJkeWrtQzfajPy9tjWj+cz2EwuU336++dQFqXJ0ltD5FKLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWV/9sMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE756C2BBFC;
	Tue, 25 Jun 2024 02:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719282770;
	bh=iQ7FxTqeAItqesS1ZPu7HixwlemAIsTeA636rrAw/M0=;
	h=From:To:Cc:Subject:Date:From;
	b=PWV/9sMWLhwLnS+jlFkGQisXJnGE+d/HvLkZEZ489vFobTvseXqnuxnMYMx7OcKek
	 QikUbmXHKTNGYVwk+MT4Ef18PHKwoLGneaFD3mQrtN4DvLsC4z1mzgFX5h3oT85zxL
	 SR4EpU+IJ6G0ykXBku4ks6rDY/51IZpuunh7srXaNzNZNDi3vvJhmr3nC9Tyzt1j6M
	 OpBc2cIl5pLvav8QU/hcYb6DVdmZ/i8Hh3HE+O7Xc8wZ/i50nO/xlOinhXzdpTjG7T
	 k17796UsjEIn4qvp5HcJD5seh556pZoQ7N4G8kGIE6wyfvpPCmY+MeQpjizMJ+8McS
	 iI/upPHC2dzHw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Yunlei He <heyunlei@oppo.com>
Subject: [PATCH v2] f2fs: fix to update user block counts in block_operations()
Date: Tue, 25 Jun 2024 10:32:39 +0800
Message-Id: <20240625023239.3534605-1-chao@kernel.org>
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
v2:
- update user_block_counts in __prepare_cp_block() suggested by Jaegeuk.
 fs/f2fs/checkpoint.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 7cfe4e01dd7e..bdd96329dddd 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1186,6 +1186,11 @@ static void __prepare_cp_block(struct f2fs_sb_info *sbi)
 	ckpt->valid_node_count = cpu_to_le32(valid_node_count(sbi));
 	ckpt->valid_inode_count = cpu_to_le32(valid_inode_count(sbi));
 	ckpt->next_free_nid = cpu_to_le32(last_nid);
+
+	/* update user_block_counts */
+	sbi->last_valid_block_count = sbi->total_valid_block_count;
+	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
+	percpu_counter_set(&sbi->rf_node_block_count, 0);
 }
 
 static bool __need_flush_quota(struct f2fs_sb_info *sbi)
@@ -1575,11 +1580,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
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


