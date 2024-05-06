Return-Path: <linux-kernel+bounces-169682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1BD8BCC2A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A2B281B6A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34357580D;
	Mon,  6 May 2024 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncvf9WVq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3874C1DFE1
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992130; cv=none; b=aEZ0nsmia+ur80ZVIheJhIuAyVPKtqWmJ4Znm8dpZMKOnLJTLtAjv65Q60G4V/JQS7jYZfQSE+fRxvp7hkpGPPJhdmRCTVTMiSxNoCpszb35hVQMPGqYS0UhHDh/o+sCySaMj5FctjT7ynsulIdFvbJUvCIc+MjU5psVPamdQSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992130; c=relaxed/simple;
	bh=fkODJ+9Ux00FgOPM9w3UQmabvHvLSKggWB9GdOxfzKk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S8zjGO76NfhTliIs+jYMFplcq/VGkv9rcvuLDAam3BfGd8P2nLUHsHsC1sBbJnjJPE5TwozbV4Qrhy7nRmw+ky7jE3pM2HO8GgZSv0H+jT2Oj3VOAjBLnQ4AUe2xNUFDm0A/sRXTWO9gR9SUEyvumP1h1Q0xE5y9wD89RyZ5XeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncvf9WVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF85EC116B1;
	Mon,  6 May 2024 10:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714992129;
	bh=fkODJ+9Ux00FgOPM9w3UQmabvHvLSKggWB9GdOxfzKk=;
	h=From:To:Cc:Subject:Date:From;
	b=ncvf9WVqkkcqtIcg46MwqNiCi2mTYjzBclGhpKSJpuN1kgt90iLNu0JVJoTHyCRjC
	 pVuH+q36+RUxxrR9PI/IMd+/ntWcs3/p/OPiskVtsUhiOH1UOSY+NaUeY98Biv0VRz
	 Z+bH409TGYJ/Ak8ynRSQJgqIoIYjsEXzg+1err/x0XFL2KWxo0INqvgJwZiQHucwb2
	 BJNCww7myP9r9hGtJiO3253gFFHkQWGTFwknvSMv6ioobjmMK6WeYk2l7j0LebMPzl
	 VbudVcZpHgA7GzKrj4Z7r83PszR5vJLTejovZrwDohWUe/ZNSmJ1Dej1GvqEAKyJQI
	 CnWm0EZAHh9Bg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/5] f2fs: compress: fix to update i_compr_blocks correctly
Date: Mon,  6 May 2024 18:41:36 +0800
Message-Id: <20240506104140.776986-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, we account reserved blocks and compressed blocks into
@compr_blocks, then, f2fs_i_compr_blocks_update(,compr_blocks) will
update i_compr_blocks incorrectly, fix it.

Meanwhile, for the case all blocks in cluster were reserved, fix to
update dn->ofs_in_node correctly.

Fixes: eb8fbaa53374 ("f2fs: compress: fix to check unreleased compressed cluster")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1761ad125f97..6c84485687d3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3641,7 +3641,8 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count,
 
 	while (count) {
 		int compr_blocks = 0;
-		blkcnt_t reserved;
+		blkcnt_t reserved = 0;
+		blkcnt_t to_reserved;
 		int ret;
 
 		for (i = 0; i < cluster_size; i++) {
@@ -3661,20 +3662,26 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count,
 			 * fails in release_compress_blocks(), so NEW_ADDR
 			 * is a possible case.
 			 */
-			if (blkaddr == NEW_ADDR ||
-				__is_valid_data_blkaddr(blkaddr)) {
+			if (blkaddr == NEW_ADDR) {
+				reserved++;
+				continue;
+			}
+			if (__is_valid_data_blkaddr(blkaddr)) {
 				compr_blocks++;
 				continue;
 			}
 		}
 
-		reserved = cluster_size - compr_blocks;
+		to_reserved = cluster_size - compr_blocks - reserved;
 
 		/* for the case all blocks in cluster were reserved */
-		if (reserved == 1)
+		if (to_reserved == 1) {
+			dn->ofs_in_node += cluster_size;
 			goto next;
+		}
 
-		ret = inc_valid_block_count(sbi, dn->inode, &reserved, false);
+		ret = inc_valid_block_count(sbi, dn->inode,
+						&to_reserved, false);
 		if (unlikely(ret))
 			return ret;
 
@@ -3685,7 +3692,7 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count,
 
 		f2fs_i_compr_blocks_update(dn->inode, compr_blocks, true);
 
-		*reserved_blocks += reserved;
+		*reserved_blocks += to_reserved;
 next:
 		count -= cluster_size;
 	}
-- 
2.40.1


