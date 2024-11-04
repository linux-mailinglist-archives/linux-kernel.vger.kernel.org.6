Return-Path: <linux-kernel+bounces-394066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E318E9BAA57
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 02:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972131F213A0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 01:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7D415C147;
	Mon,  4 Nov 2024 01:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uILrES3A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B67E6FD5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 01:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684208; cv=none; b=AossHHAE2QmYLjRgHWPIuA2yoT0MtBm38/rZmeQRALMeSrglFnA+WEM4LL6Motu4wKkCbsc0/t2prAKj7nr+KhBEzs+O3UMxahqIEa2klkSH7zjkIOb2T/pHApCduBNCQfw1TOhJWY5hkpwnOFKbZr60t2APziv9fmnQPX6F07A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684208; c=relaxed/simple;
	bh=kOryAQM4duw0dSZR9ghUXtvCm+rxu8rIgQehlsp/gC8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mGWL0w1w6OUNdr1b4TU0Axz1B/Avt0UMhI0X8dg9EoTxIP8f/bKjXQps7RwTbVVPLQcvVT18ZbtXNhQk58iAem7fyj+xz9xcq4J9C/B0wAB8unl0GBUrTT4ppRSW1VnSgbGmLnpX+sR49lE4Ixub+6bFzzqW4U6xpxaMJ7bSdwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uILrES3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3F4C4CECD;
	Mon,  4 Nov 2024 01:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730684208;
	bh=kOryAQM4duw0dSZR9ghUXtvCm+rxu8rIgQehlsp/gC8=;
	h=From:To:Cc:Subject:Date:From;
	b=uILrES3AeTFNzGrP0HbXzeqOAQnTjG8RSuGibrOCTfqPQdvBNStI13HOt38a7K8m8
	 cE3h+lKkIE6+V1julMJmaEr8Yv6i3Ea/aEDHqjr71SYezE4ZUUEmgnCmVuLuK3PdS6
	 tTSKd/i9n0S/dPJcTGppzTuFiQlyO3gDmWp1vTB4tjdF0Yr7lGPcqyJgUifBsa73Q3
	 mxQBchudFUnl/jiBMH44blwC1LIKSqIZkR1G8tMeJWQZHHGkDOXjJ0/0Ky2WZhl613
	 z9uRjXjEVDqsNbh/v/OmrKW8aSdtlX3v7698t2jdIKW87xcXTeXaWBDq0tWvd4EzJR
	 +P8XrtkaWR8Xw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	kernel test robot <oliver.sang@intel.com>,
	Cyril Hrubis <chrubis@suse.cz>
Subject: [PATCH v2] f2fs: fix to map blocks correctly for direct write
Date: Mon,  4 Nov 2024 09:35:51 +0800
Message-Id: <20241104013551.218037-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs_map_blocks() supports to map continuous holes or preallocated
address, we should avoid setting F2FS_MAP_MAPPED for these cases
only, otherwise, it may fail f2fs_iomap_begin(), and make direct
write fallbacking to use buffered IO and flush, result in performance
regression.

Fixes: 9f0f6bf42714 ("f2fs: support to map continuous holes or preallocated address")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202409122103.e45aa13b-oliver.sang@intel.com
Cc: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix wrong commit tile
- clean up code and comment suggested by Jaegeuk
 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 306b86b0595d..7d1bb9518a40 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1676,7 +1676,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		/* reserved delalloc block should be mapped for fiemap. */
 		if (blkaddr == NEW_ADDR)
 			map->m_flags |= F2FS_MAP_DELALLOC;
-		if (flag != F2FS_GET_BLOCK_DIO || !is_hole)
+		/* DIO READ and hole case, should not map the blocks. */
+		if (!(flag == F2FS_GET_BLOCK_DIO && is_hole && !map->m_may_create))
 			map->m_flags |= F2FS_MAP_MAPPED;
 
 		map->m_pblk = blkaddr;
-- 
2.40.1


