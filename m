Return-Path: <linux-kernel+bounces-394188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA399BAB96
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3F7281AC2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D497186287;
	Mon,  4 Nov 2024 03:46:34 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828C718C012
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 03:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730691994; cv=none; b=MeDGMMAQmqP58IRKuhzRbaFguFz10MDy4YeRp2Tqekl0c+5m/qMAEa+2OZowzmk8YDUffy1kkI7QxcuZu14l3/AqkDPLeguMWG2l2eV30qPy3785eDDEb3jL1brDKbWWUdgQOAiIfpd8jgtlNx13hgCRpqfywy9np++Z0aabnkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730691994; c=relaxed/simple;
	bh=cWGXzL0NXb/DNdzjiGCXPzYB5RtK7fS2NaQOtetd3JM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bcEsb8UqYhcAbD8OWRJc0q8jNUWMC5AUyNnYlC03XXnspzuZUhSbLOuBx2oqYvAIHIUyfDzZj3KPqqod+rlaE6jId6y3BLZ80k+49LC3xA9wOKfMHIQC8c430PY+l+14Hk/rypHkjJ3sYb5vzzdFyTicsoyNFKWgo8uJyTVAv6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4A43jrfH085790;
	Mon, 4 Nov 2024 11:45:53 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Xhcmf5HtDz2KgRlB;
	Mon,  4 Nov 2024 11:45:06 +0800 (CST)
Received: from tj10379pcu1.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 4 Nov 2024 11:45:51 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <chao@kernel.org>, <jaegeuk@kernel.org>
CC: <yi.sun@unisoc.com>, <sunyibuaa@gmail.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <niuzhiguo84@gmail.com>,
        <Hao_hao.Wang@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH v3 5/5] f2fs: Optimize f2fs_truncate_data_blocks_range()
Date: Mon, 4 Nov 2024 11:45:45 +0800
Message-ID: <20241104034545.497907-6-yi.sun@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241104034545.497907-1-yi.sun@unisoc.com>
References: <20241104034545.497907-1-yi.sun@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 4A43jrfH085790

Function f2fs_invalidate_blocks() can process continuous
blocks at a time, so f2fs_truncate_data_blocks_range() is
optimized to use the new functionality of
f2fs_invalidate_blocks().

Signed-off-by: Yi Sun <yi.sun@unisoc.com>
---
 fs/f2fs/file.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9366e7fc7c39..d20cc5f36d4c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -612,6 +612,15 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	return finish_preallocate_blocks(inode);
 }
 
+static bool check_curr_block_is_consecutive(struct f2fs_sb_info *sbi,
+					block_t curr, block_t end)
+{
+	if (curr - end == 1 || curr == end)
+		return true;
+	else
+		return false;
+}
+
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
@@ -621,8 +630,27 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 	int cluster_index = 0, valid_blocks = 0;
 	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
 	bool released = !atomic_read(&F2FS_I(dn->inode)->i_compr_blocks);
+	/*
+	 * Temporary record location.
+	 * When the current  @blkaddr and @blkaddr_end can be processed
+	 * together, update the value of @blkaddr_end.
+	 * When it is detected that current @blkaddr is not continues with
+	 * @blkaddr_end, it is necessary to process continues blocks
+	 * range [blkaddr_start, blkaddr_end].
+	 */
+	block_t blkaddr_start, blkaddr_end;
+	/*.
+	 * To avoid processing various invalid data blocks.
+	 * Because @blkaddr_start and @blkaddr_end may be assigned
+	 * NULL_ADDR or invalid data blocks, @last_valid is used to
+	 * record this situation.
+	 */
+	bool last_valid = false;
+	/* Process the last @blkaddr separately? */
+	bool last_one = true;
 
 	addr = get_dnode_addr(dn->inode, dn->node_page) + ofs;
+	blkaddr_start = blkaddr_end = le32_to_cpu(*addr);
 
 	/* Assumption: truncation starts with cluster */
 	for (; count > 0; count--, addr++, dn->ofs_in_node++, cluster_index++) {
@@ -638,24 +666,60 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 		}
 
 		if (blkaddr == NULL_ADDR)
-			continue;
+			goto next;
 
 		f2fs_set_data_blkaddr(dn, NULL_ADDR);
 
 		if (__is_valid_data_blkaddr(blkaddr)) {
 			if (time_to_inject(sbi, FAULT_BLKADDR_CONSISTENCE))
-				continue;
+				goto next;
 			if (!f2fs_is_valid_blkaddr_raw(sbi, blkaddr,
 						DATA_GENERIC_ENHANCE))
-				continue;
+				goto next;
 			if (compressed_cluster)
 				valid_blocks++;
 		}
 
-		f2fs_invalidate_blocks(sbi, blkaddr, 1);
+
+		if (check_curr_block_is_consecutive(sbi, blkaddr, blkaddr_end)) {
+			/*
+			 * The current block @blkaddr is continuous with
+			 * @blkaddr_end, so @blkaddr_end is updated.
+			 * And the f2fs_invalidate_blocks() is skipped
+			 * until @blkaddr that cannot be processed
+			 * together is encountered.
+			 */
+			blkaddr_end = blkaddr;
+			if (count == 1)
+				last_one = false;
+			else
+				goto skip_invalid;
+		}
+
+		f2fs_invalidate_blocks(sbi, blkaddr_start,
+					blkaddr_end - blkaddr_start + 1);
+		blkaddr_start = blkaddr_end = blkaddr;
+
+		if (count == 1 && last_one)
+			f2fs_invalidate_blocks(sbi, blkaddr, 1);
+
+skip_invalid:
+		last_valid = true;
 
 		if (!released || blkaddr != COMPRESS_ADDR)
 			nr_free++;
+
+		continue;
+
+next:
+		/* If consecutive blocks have been recorded, we need to process them. */
+		if (last_valid == true)
+			f2fs_invalidate_blocks(sbi, blkaddr_start,
+					blkaddr_end - blkaddr_start + 1);
+
+		blkaddr_start = blkaddr_end = le32_to_cpu(*(addr + 1));
+		last_valid = false;
+
 	}
 
 	if (compressed_cluster)
-- 
2.25.1


