Return-Path: <linux-kernel+bounces-175720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91758C2409
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C86628A9E9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C5F170884;
	Fri, 10 May 2024 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xv87/W2m"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C26B16F0E5
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341979; cv=none; b=om1cgrshkLCslgrfAuEFGjypSqEbjemO0ujOZJ9wrbu9bOnT9Q2G4eHCkhPaVFT2Umzgq8lx9aqe2IAojeWbqsIOLCMJTi/KMLVyUrE8A3iZeUez2FNRFvKArOiDJsX4V4Oej+9506OYspRCHArJ9LjdYPJdA78qW5a/17WeWHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341979; c=relaxed/simple;
	bh=XT/MGGf6FqoaFBbWz/kB4SnUy6ZwYybEOphKp8bB/sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XZcx+aft2bZyh2uXLxCCMwWeVfrOBYzHNqKnJ4GwATBZR8PYXJrdrHhQ84PGhPzIkg7CEBkgeaMY2up3MRqmLkZHMWnuP+oHwpvZKURausbveuduu7f/G0wZl7tY+TC5CDFvb/rd5oEAEqBwbnVnawVxxZIjZ2TEiXwhUnTArjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xv87/W2m; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715341976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Sn5xOAgv1svZ21tOX1itCUqNjVaJTe3E3Ka7POAje4c=;
	b=xv87/W2mVBIZxUvRcC43sR2bcohwTQIjuNvnLpv6icr6FDrxnP32YVaIitfZxYPFlxqr81
	sN2GuV6bXniKaXL5vsqjbbYlK6iIhhnFfiGvAT9Gn31cFtl2lNHU7pabZLes5mPvuH16sl
	ozV01DWLApGkG3sG+vha3K5ZDWW67IU=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH] ext4: fix infinite loop when replaying fast_commit
Date: Fri, 10 May 2024 12:52:52 +0100
Message-ID: <20240510115252.11850-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When doing fast_commit replay an infinite loop may occur due to an
uninitialized extent_status struct.  ext4_ext_determine_insert_hole() does
not detect the replay and calls ext4_es_find_extent_range(), which will
return immediately without initializing the 'es' variable.

Because 'es' contains garbage, an integer overflow may happen causing an
infinite loop in this function, easily reproducible using fstest generic/039.

This commit fixes this issue by detecting the replay in function
ext4_ext_determine_insert_hole().  It also adds initialization code to the
error path in function ext4_es_find_extent_range().

Thanks to Zhang Yi, for figuring out the real problem!

Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
Hi!

Two comments:
1) The change in ext4_ext_map_blocks() could probably use the min_not_zero
   macro instead.  I decided not to do so simply because I wasn't sure if
   that would be safe, but I'm fine changing that if you think it is.

2) I thought about returning 'EXT_MAX_BLOCKS' instead of '0' in
   ext4_lblk_t ext4_ext_determine_insert_hole(), which would then avoid
   the extra change to ext4_ext_map_blocks().  '0' sounds like the right
   value to return, but I'm also OK using 'EXT_MAX_BLOCKS' instead.

And again thanks to Zhang Yi for pointing me the *real* problem!

 fs/ext4/extents.c        | 6 +++++-
 fs/ext4/extents_status.c | 5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e57054bdc5fd..b5bfcb6c18a0 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4052,6 +4052,9 @@ static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
 	ext4_lblk_t hole_start, len;
 	struct extent_status es;
 
+	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
+		return 0;
+
 	hole_start = lblk;
 	len = ext4_ext_find_hole(inode, path, &hole_start);
 again:
@@ -4226,7 +4229,8 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		len = ext4_ext_determine_insert_hole(inode, path, map->m_lblk);
 
 		map->m_pblk = 0;
-		map->m_len = min_t(unsigned int, map->m_len, len);
+		if (len > 0)
+			map->m_len = min_t(unsigned int, map->m_len, len);
 		goto out;
 	}
 
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 4a00e2f019d9..acb9616ca119 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -310,8 +310,11 @@ void ext4_es_find_extent_range(struct inode *inode,
 			       ext4_lblk_t lblk, ext4_lblk_t end,
 			       struct extent_status *es)
 {
-	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
+	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) {
+		/* Initialize extent to zero */
+		es->es_lblk = es->es_len = es->es_pblk = 0;
 		return;
+	}
 
 	trace_ext4_es_find_extent_range_enter(inode, lblk);
 

