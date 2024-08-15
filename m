Return-Path: <linux-kernel+bounces-287737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C35F952C0C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49BE01C236B1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84441C0DE4;
	Thu, 15 Aug 2024 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P78h8Hkh"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6322E177980
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713803; cv=none; b=n3yFQbebAjgFL/l+qkIWmS0/Fe0Gpf8kTVOKFoqM1klDe7NoqJDuzvsLi2A5y9+A3Nhc1yjwuijXX5IGMKC07m39RH/R7Jh6ScjhYL9IVim4S2AKrhpU2P88Av4+lF41Eb+AFop03jx/Oqj2zoxpNyoOaz1yMhBx2WifPsjnEns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713803; c=relaxed/simple;
	bh=+sObloC1z4b6bN8s4V7hq+Jx047COGCJ+YOBic+8diQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GApF+UchlWlfHI0Zcf2X9p6mYFXAMaK9GmzX8LtlWANBsd10eKt5KKnth0oebjwCoEbeB/5EJ7kYuAOHz8tXVF9J9MihGJEd7Y98N8OFib1KFrU3nek56DVIu749YO9yUsyxqeRdDo1MWCcaIh2jSJqWbnaP3/C06xjG4ZINr8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P78h8Hkh; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=BVHEp
	73aP48z9WssczRaaj5+TNK0ShKng5OvN16omb4=; b=P78h8HkhRYi1+DrXZ9DOz
	sJtvtl0YThnQekZwJkZfbIyWTCeCPnErvJ+s4qeymJUvJdcnAvQPFYVePo5/Jr33
	kIMq44fyVYvP6CKbRIdXa8w6eha6V8TUq2r0z8D6B77OD4YP6Z2xdns//HlPtgB0
	O3JU4ceCsdF6h58x2QFxfw=
Received: from localhost.localdomain (unknown [111.48.69.246])
	by gzga-smtp-mta-g3-1 (Coremail) with SMTP id _____wD3v8_FyL1mrKteCQ--.26237S2;
	Thu, 15 Aug 2024 17:22:14 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	starzhangzsd@gmail.com,
	Chi Zhiling <chizhiling@kylinos.cn>,
	Shida Zhang <zhangshida@kylinos.cn>
Subject: [PATCH] ocfs2: fix unexpected zeroing of virtual disk
Date: Thu, 15 Aug 2024 17:21:41 +0800
Message-Id: <20240815092141.1223238-1-chizhiling@163.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v8_FyL1mrKteCQ--.26237S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryrAF1rJr1kurWfJF1kZrb_yoW8KFW3pr
	WUJw1UGr48Jr1UZr1Utr13Jr1UJr1DA3WUJr15Jr4xJwn8JF10yw1UJF1UJFWUJ34DJr4U
	Xr48JryUt345JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYdgAUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/1tbiTws8nWXAnaMwBAAAsK

From: Chi Zhiling <chizhiling@kylinos.cn>

In a guest virtual machine, we found that there is unexpected data
zeroing problem detected occassionly:

XFS (vdb): Mounting V5 Filesystem
XFS (vdb): Ending clean mount
XFS (vdb): Metadata CRC error detected at xfs_refcountbt_read_verify+0x2c/0xf0, xfs_refcountbt block 0x200028
XFS (vdb): Unmount and run xfs_repair
XFS (vdb): First 128 bytes of corrupted metadata buffer:
00000000e0cd2f5e: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00000000cafd57f5: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00000000d0298d7d: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00000000f0698484: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00000000adb789a7: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
000000005292b878: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00000000885b4700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00000000fd4b4df7: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
XFS (vdb): metadata I/O error in "xfs_trans_read_buf_map" at daddr 0x200028 len 8 error 74
XFS (vdb): Error -117 recovering leftover CoW allocations.
XFS (vdb): xfs_do_force_shutdown(0x8) called from line 994 of file fs/xfs/xfs_mount.c.  Return address = 000000003a53523a
XFS (vdb): Corruption of in-memory data detected.  Shutting down filesystem
XFS (vdb): Please umount the filesystem and rectify the problem(s)

It turns out that the root cause is from the physical host machine.
More specifically, it is caused by the ocfs2.

when the page_size is 64k, the block should advance by 16 each time
instead of 1.
This will lead to a wrong mapping from the page to the disk, which
will zero some adjacent part of the disk.

Suggested-by: Shida Zhang <zhangshida@kylinos.cn>
Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/ocfs2/aops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index d6c985cc6353..1fea43c33b6b 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -1187,7 +1187,7 @@ static int ocfs2_write_cluster(struct address_space *mapping,
 
 		/* This is the direct io target page. */
 		if (wc->w_pages[i] == NULL) {
-			p_blkno++;
+			p_blkno += (1 << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits));
 			continue;
 		}
 
-- 
2.27.0


