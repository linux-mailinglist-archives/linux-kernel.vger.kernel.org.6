Return-Path: <linux-kernel+bounces-390339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE90D9B788C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735521F22751
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382281991AB;
	Thu, 31 Oct 2024 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRjiE2Zv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960EB1990DE
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730370128; cv=none; b=f6f4ba7ehHyzgPeJ7q5GONP0vYkHqWWZ/M9sN3tfV192Cfd+fRn8ywzHNvYO5cFrJkhTv7B7W9wVAshRFt/k3TI0ntohHs4K00U4opXAmT9Ofr1NQEAQG0CUctFQbXeRHWpvLw9t2MuGSoOlbmQE0Ii3Zp1inOyxY/0wzVtjrsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730370128; c=relaxed/simple;
	bh=atsobAgsQWm0gfnvx5sgtWzsfSlYFgDXXPQwPH8yk+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DosTGQcKZ/auJU2z2Z+Bre1TE5cYRygdGRQV+hH4DIhqnha3wkq3BHzOhFdTgOqEgMv7fK2NTdzBsfzlZ7Tgqh/xqgPhU+4xvVhmreuRLJuyGpBDIa1I7pyxN5p79iRI11H96eanNa75SDPTaIt05qfERRxgSmdk8avo28FCj1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRjiE2Zv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914AAC4CEC3;
	Thu, 31 Oct 2024 10:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730370128;
	bh=atsobAgsQWm0gfnvx5sgtWzsfSlYFgDXXPQwPH8yk+Y=;
	h=From:To:Cc:Subject:Date:From;
	b=gRjiE2Zv6K9mIqVk9q+GdWt/ROugF/OwrG5lQ/nv/sDCE2ym8wB1AJ9Ack4T/ZWYH
	 b2OxvXNIXTmOqsDJgUixOHHOhJo8shjwFknIFUZL/fhx917RW4qf5snZhZG4bPFR7k
	 USi0uHznV7jJKUcNk3KQPjJvHAf+Fam9RX47mIiAQIIblImxgP1LrpmeKyZFr5OMhO
	 6VowpHORBmg/zQGQFkuIzqnyl7YSltegWMVjCNXk1AMk87SJfqZVmcPxhcXhBrrDSA
	 2iBrLewg7PoBA8oz9K8X+6v7/lQY2TARdgBVHmduX3yY5gCe6gFQVG0jRiVuQbyd/g
	 SUuR/qeL7DIzw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	kernel test robot <oliver.sang@intel.com>,
	Cyril Hrubis <chrubis@suse.cz>
Subject: [PATCH] f2fs: fix to map blocks correctly for direct read
Date: Thu, 31 Oct 2024 18:22:00 +0800
Message-Id: <20241031102200.440407-1-chao@kernel.org>
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
 fs/f2fs/data.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 306b86b0595d..38b85160c6bd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1676,7 +1676,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		/* reserved delalloc block should be mapped for fiemap. */
 		if (blkaddr == NEW_ADDR)
 			map->m_flags |= F2FS_MAP_DELALLOC;
-		if (flag != F2FS_GET_BLOCK_DIO || !is_hole)
+		/*
+		 * f2fs_map_blocks() supports to map continuous holes or
+		 * preallocated address, don't set F2FS_MAP_MAPPED for these
+		 * cases only.
+		 */
+		if (flag != F2FS_GET_BLOCK_DIO || map->m_may_create || !is_hole)
 			map->m_flags |= F2FS_MAP_MAPPED;
 
 		map->m_pblk = blkaddr;
-- 
2.40.1


