Return-Path: <linux-kernel+bounces-388477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A981D9B6032
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67879283CED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E5A1E47D0;
	Wed, 30 Oct 2024 10:32:27 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB77F1E32D8
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730284347; cv=none; b=S5W6d3K/1gnHkmTop7MX4QWuMQ5lrdThnvQdxqiHe8yIRFy5kpIJjLb+TNTof++XxB5++uvae+Dr4/g35gTu/8GNFC5ZK3YhlxAo/i/dyzzSXDlfgx6jsd8eyaO4NUcd3uuQXt72VKE8pdB1Kic0Q+G7JUs7ON3m7d2HpzvZKKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730284347; c=relaxed/simple;
	bh=ByIW6xN2k1vSc+IxsAB9AEtTFIFXUpVw+1AjsVkisBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubl9XTH04T8NRUpaMlUGrreudIlYtAX0AJ+p8eKw69M76t95wa1BcH8734KYDwMj63i5CqDsmUgQeD11HAdpaGWWi8sJreWwdh98mqDsN004/Fzwe7waTCSHhuOf03QnUOP1uPOcnRS/li+Zw4EJBsuS3Gncbh1cWiw+XmyJGc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 49UAViG8026981;
	Wed, 30 Oct 2024 18:31:44 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Xdk1R4B4cz2KSK4X;
	Wed, 30 Oct 2024 18:31:07 +0800 (CST)
Received: from tj10379pcu1.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 30 Oct 2024 18:31:43 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <chao@kernel.org>, <jaegeuk@kernel.org>
CC: <yi.sun@unisoc.com>, <sunyibuaa@gmail.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <niuzhiguo84@gmail.com>,
        <hao_hao.wang@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH v2 5/5] f2fs: Optimize f2fs_truncate_data_blocks_range()
Date: Wed, 30 Oct 2024 18:31:36 +0800
Message-ID: <20241030103136.2874140-6-yi.sun@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030103136.2874140-1-yi.sun@unisoc.com>
References: <20241030103136.2874140-1-yi.sun@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 49UAViG8026981

Function f2fs_invalidate_blocks() can process continuous
blocks at a time, so f2fs_truncate_data_blocks_range() is
optimized to use the new functionality of
f2fs_invalidate_blocks().

Signed-off-by: Yi Sun <yi.sun@unisoc.com>
---
 fs/f2fs/file.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 13594bb502d1..3dbabe6be8e6 100644
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
+	 * When the current block and @blkaddr_end can be processed
+	 * together, update the value of @blkaddr_end.
+	 * When it is detected that current block is not continues with
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
+	/* Process the last block separately? */
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


