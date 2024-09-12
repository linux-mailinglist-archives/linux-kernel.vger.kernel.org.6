Return-Path: <linux-kernel+bounces-326122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0E3976327
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4352811A2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B602C194C75;
	Thu, 12 Sep 2024 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oYPi3yEW"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28911186E58
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126927; cv=none; b=QVB37R+KTM6mIOcCPfYqDBpviayBUj0wnz7zJ1fAdp45GLrz+g7+P1GRU5xvpkalywzYrX2PFpspqprDPAIhYRkvQ0mfQzrGT2MZHk6aK+Xofk/1VUxAwyBlLH4TuXRj2Fx7Imf11d6zI33WPlNj5LN/UN1GLBH7KrMQCvjpE/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126927; c=relaxed/simple;
	bh=GacUQPvdrMKq+g2ClNt84vpiiMzQHenj3R48vgJKUsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UxzSqKhykMhrKeiAeyxq84wvbtQsMcccjsLc1h1qlQw0WONipzG7r7/2CIos7rBbFxq4MALHWMxewndqO6JY2AFJ6AAUQMxqgxeygKintgCRa8FNztIL99UqJgoiSWSTeg/7IMa9X/Xmi9vDZiudMZtb2HrFSGIuNeBgSdYYK+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oYPi3yEW; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726126921; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=U3zpUFdb+C2ZY/A+Fe1YciE/MRfJO397mZ/cfuh02Kk=;
	b=oYPi3yEWIJEOp1klxHNTKgy6ScC1Ja/l+SfPBqqil9dJu+28mirX8US6TtUAMozq+AbwsrXiwQIQrM5Yoe6CHlQcCn5WhDIuGjLOkl42z8vxw+ItA+6D4c0/7tZ+UpgQ0w+UZDPZCW4KMchyzB6DBSlt5zB/M4qlTtTikHAb/o4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEqd5Ck_1726126917)
          by smtp.aliyun-inc.com;
          Thu, 12 Sep 2024 15:42:01 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: restrict pcluster size limitations
Date: Thu, 12 Sep 2024 15:41:56 +0800
Message-ID: <20240912074156.2925394-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Error out if {en,de}encoded size of a pcluster is unsupported:
  Maximum supported encoded size (of a pcluster):  1 MiB
  Maximum supported decoded size (of a pcluster): 12 MiB

Users can still choose to use supported large configurations (e.g.,
for archival purposes), but there may be performance penalties in
low-memory scenarios compared to smaller pclusters.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h |  5 ++++-
 fs/erofs/zmap.c     | 42 ++++++++++++++++++++----------------------
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 6c0c270c42e1..c8f2ae845bd2 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -288,9 +288,12 @@ struct erofs_dirent {
 
 #define EROFS_NAME_LEN      255
 
-/* maximum supported size of a physical compression cluster */
+/* maximum supported encoded size of a physical compressed cluster */
 #define Z_EROFS_PCLUSTER_MAX_SIZE	(1024 * 1024)
 
+/* maximum supported decoded size of a physical compressed cluster */
+#define Z_EROFS_PCLUSTER_MAX_DSIZE	(12 * 1024 * 1024)
+
 /* available compression algorithm types (for h_algorithmtype) */
 enum {
 	Z_EROFS_COMPRESSION_LZ4		= 0,
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 403af6e31d5b..e980e29873a5 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -687,32 +687,30 @@ int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 	int err = 0;
 
 	trace_erofs_map_blocks_enter(inode, map, flags);
-
-	/* when trying to read beyond EOF, leave it unmapped */
-	if (map->m_la >= inode->i_size) {
+	if (map->m_la >= inode->i_size) {	/* post-EOF unmapped extent */
 		map->m_llen = map->m_la + 1 - inode->i_size;
 		map->m_la = inode->i_size;
 		map->m_flags = 0;
-		goto out;
-	}
-
-	err = z_erofs_fill_inode_lazy(inode);
-	if (err)
-		goto out;
-
-	if ((vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER) &&
-	    !vi->z_tailextent_headlcn) {
-		map->m_la = 0;
-		map->m_llen = inode->i_size;
-		map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_FULL_MAPPED |
-				EROFS_MAP_FRAGMENT;
-		goto out;
+	} else {
+		err = z_erofs_fill_inode_lazy(inode);
+		if (!err) {
+			if ((vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER) &&
+			    !vi->z_tailextent_headlcn) {
+				map->m_la = 0;
+				map->m_llen = inode->i_size;
+				map->m_flags = EROFS_MAP_MAPPED |
+					EROFS_MAP_FULL_MAPPED | EROFS_MAP_FRAGMENT;
+			} else {
+				err = z_erofs_do_map_blocks(inode, map, flags);
+			}
+		}
+		if (!err && (map->m_flags & EROFS_MAP_ENCODED) &&
+		    unlikely(map->m_plen > Z_EROFS_PCLUSTER_MAX_SIZE ||
+			     map->m_llen > Z_EROFS_PCLUSTER_MAX_DSIZE))
+			err = -EOPNOTSUPP;
+		if (err)
+			map->m_llen = 0;
 	}
-
-	err = z_erofs_do_map_blocks(inode, map, flags);
-out:
-	if (err)
-		map->m_llen = 0;
 	trace_erofs_map_blocks_exit(inode, map, flags, err);
 	return err;
 }
-- 
2.43.5


