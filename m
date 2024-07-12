Return-Path: <linux-kernel+bounces-250307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF4492F64D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58EFA282209
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B555E13DDDD;
	Fri, 12 Jul 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ki261NVV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056E713DDA3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720769663; cv=none; b=tzRD8oCfLMUjHO7IDD2QoQPhYvjFO+R7xo8NhRmil5g+Z9MHULUUs2O79FGJGq+BoQk1lOhyeODhzey78FssDBdDv3iRNpyztA58tlUJK0nLeXm+cBQbrBVxnWGHIO8elaRBfypxmAYa0ZN5ZnhNJl+JjYsUJjgmUkG0BVpjES0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720769663; c=relaxed/simple;
	bh=pQDRxA/hn4GoB35hMTWuxnTZbA6PilRZeqm+y7oKfkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iGtDn7M29lCa98alE/Ywwk8hxT0x1dOEZyD8bVRHEtbn2WuvQbh0xD1hQuirHYN23ATumDW5XHTTdRf3oixnT/Mn27vEFAyoxuuJxNJ+DSlUlD1zjgMvrjmtprB/Rva1foldET+65UcXC1vbBrF0I5PjQBD2BTsV2/cqqk5KLcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ki261NVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C45FC3277B;
	Fri, 12 Jul 2024 07:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720769662;
	bh=pQDRxA/hn4GoB35hMTWuxnTZbA6PilRZeqm+y7oKfkY=;
	h=From:To:Cc:Subject:Date:From;
	b=ki261NVVkOo6/fkukqcGMmIUAvLrT3KwM+lh0WXotJcJ5QfGsr3G3lSOeE5KO1IYw
	 zSsM2REhgYqHv/J7N4uVVQC/bmoxwvm6kH/VxhSU7QcS6DxSeKQz4SAqeIWSee6vuW
	 qUUmLEfGhSJe8V86Q4nzBEKlQ+NnudwBSGeFeoPtHGpEdwUSi4f46vxEQpA2GSI0cm
	 KWVIalevvudV0mnJmM/oh7weYngkOz8W5nlHmfz3WLtIrr35a5udQrmMWz+oBCDPRc
	 E7N99QseG1xfjGxCDwcoELIByug2rgrQzlOKn3jRZ81WbQVcJWZn59jycBMpYvr/W/
	 4SKPmX3EjxE5Q==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: don't traverse directory blocks after EOF
Date: Fri, 12 Jul 2024 15:34:15 +0800
Message-Id: <20240712073415.227226-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All directory blocks are within the scope of i_size, so let's limit
the end_block to just check valid dirent blocks.

Meanwhile, it uses dir_blocks() instead of variable for cleanup in
__f2fs_find_entry().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/dir.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 02c9355176d3..d4591c215f07 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -305,18 +305,21 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 	int s = GET_DENTRY_SLOTS(fname->disk_name.len);
 	unsigned int nbucket, nblock;
 	unsigned int bidx, end_block;
+	unsigned long last_block;
 	struct page *dentry_page;
 	struct f2fs_dir_entry *de = NULL;
 	pgoff_t next_pgofs;
 	bool room = false;
 	int max_slots;
 
+	last_block = dir_blocks(dir);
 	nbucket = dir_buckets(level, F2FS_I(dir)->i_dir_level);
 	nblock = bucket_blocks(level);
 
 	bidx = dir_block_index(level, F2FS_I(dir)->i_dir_level,
 			       le32_to_cpu(fname->hash) % nbucket);
 	end_block = bidx + nblock;
+	end_block = min_t(unsigned int, end_block, last_block);
 
 	while (bidx < end_block) {
 		/* no need to allocate new dentry pages to all the indices */
@@ -361,7 +364,6 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 					 const struct f2fs_filename *fname,
 					 struct page **res_page)
 {
-	unsigned long npages = dir_blocks(dir);
 	struct f2fs_dir_entry *de = NULL;
 	unsigned int max_depth;
 	unsigned int level;
@@ -373,7 +375,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 		goto out;
 	}
 
-	if (npages == 0)
+	if (dir_blocks(dir) == 0)
 		goto out;
 
 	max_depth = F2FS_I(dir)->i_current_depth;
-- 
2.40.1


