Return-Path: <linux-kernel+bounces-415279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E479D33D6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99879B20F56
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 06:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B80A15990C;
	Wed, 20 Nov 2024 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbJPWde6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FF2147C79
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732085935; cv=none; b=c4DsSLJ6G0j1kIi3b+98F/bQu3kpi7X9eh1FBOZzM8PfB+t6Ln1BA6V5Iy5OI8Jm2dSglCYlLADleBlaM+1D8/EnLhHW7uS2dWBzps6SEdWrcUBXFSs+Pzc5PKCteSDg+ArSbQTt53YahZD8DN3wd1XM3S/bo0YMBm+vvni5XZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732085935; c=relaxed/simple;
	bh=LiRywwvZ492JbxN5S4AePvfgAabtzpdorm4CPQMEHgw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bcHMC57HY6LqBj8i3cXm0i08+9NtOXfoPy+YNUNHTODXkfnR6PkS0ghD+kBBhVKQcjOPulzA8CveSDbvKS/t1QGSfIhz2rx9DMvxichGgdywJTlFK0Qngmq74BO29k0nKc59A6lzAlgrPj7/I45cNkbmhGs0R9L/AXkcHfIFpU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbJPWde6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F82BC4CECD;
	Wed, 20 Nov 2024 06:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732085935;
	bh=LiRywwvZ492JbxN5S4AePvfgAabtzpdorm4CPQMEHgw=;
	h=From:To:Cc:Subject:Date:From;
	b=lbJPWde65JhSqIPLmqicGq806xjhC1htnXJHo5WhnA/oGC8tkdAlBP2Pm8JbfR/BX
	 4CPGImrm6bnCH6rT0kmTX+iu/oakcYzWjmoBlGpTx+r23uVPbxB35JCe8dnXc3jLgp
	 5xSYdA05O8qasCh6/cBrc1W6onffrd9QS5qqYEFjrDbTrfWbbdFUduHZ6IPL/TZvdh
	 TdUj2cvcRVt+Ai8bBRt1uy+LLM2fHs2Upe5FuBZ2h3BPtRryCWyoZZGeuaPpBOd9It
	 nL6trIlvXO9WdXUGs5xNigD/gpMznciC6GufOYoZGymKXC4FVTF0SeYP0L4Zu3xWYi
	 0/g0vLMPmyT1Q==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: print message if fscorrupted was found in f2fs_new_node_page()
Date: Wed, 20 Nov 2024 14:58:50 +0800
Message-Id: <20241120065850.1345670-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If fs corruption occurs in f2fs_new_node_page(), let's print
more information about corrupted metadata into kernel log.

Meanwhile, it updates to record ERROR_INCONSISTENT_NAT instead
of ERROR_INVALID_BLKADDR if blkaddr in nat entry is not
NULL_ADDR which means nat bitmap and nat entry is inconsistent.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 7d904f2bd5b6..0b900a7a48e5 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1338,7 +1338,12 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 		err = -EFSCORRUPTED;
 		dec_valid_node_count(sbi, dn->inode, !ofs);
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
+		f2fs_warn_ratelimited(sbi,
+			"f2fs_new_node_page: inconsistent nat entry, "
+			"ino:%u, nid:%u, blkaddr:%u, ver:%u, flag:%u",
+			new_ni.ino, new_ni.nid, new_ni.blk_addr,
+			new_ni.version, new_ni.flag);
+		f2fs_handle_error(sbi, ERROR_INCONSISTENT_NAT);
 		goto fail;
 	}
 #endif
-- 
2.40.1


