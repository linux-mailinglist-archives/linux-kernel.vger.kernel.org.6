Return-Path: <linux-kernel+bounces-336467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A55D983B39
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 04:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24764B22657
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 02:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECD5C8CE;
	Tue, 24 Sep 2024 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihbJo+xW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696381B85D6
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727145023; cv=none; b=OJE7SSvwuPF1ReDtKxIkql+R4aUju3c2nYe3IzMYQ8hmjvPHJ2Um+PRYSZlpVUxrIhDCUl3Zt4vNNKeKgvEAVreLpC4APHWxlV4V1BaAEM+u6kSOZanHEm6pFcv7z7dGxpO/JmMxzMxfXbnVDZo5h3MkPSQVg0Q5VU64EZU4Mms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727145023; c=relaxed/simple;
	bh=POOjzR/GH7RIhN+TXA7+6FxROIv97eheQZRVGR8Nwds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KlNl/g1WKSxEHPjYojeeAXm//jqJUN82oJS2NZMztHz/a82AoFTFW/E1GRuZ0TM8U0jUnE80c9ldmj7eJyagsz5FAZosL6DbtLDzsMZKOb5jzO7JoRZEXgWFXWTaSi8NUbUroyq73/bVvBg8Gs+nGcOv93mw3ql8VVwmX0xkIo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihbJo+xW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BE7C4CEC4;
	Tue, 24 Sep 2024 02:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727145023;
	bh=POOjzR/GH7RIhN+TXA7+6FxROIv97eheQZRVGR8Nwds=;
	h=From:To:Cc:Subject:Date:From;
	b=ihbJo+xWikBzYJHM79iaJyfx8i9PEVWxFSwekgs9/9e4w47CueoIe1ynjnpHKmTG9
	 dfUC9zFL2l8YL/wbrrYMClt9lrhABnKLJx5QX0K+nlBNjJ4bN4PZ3GZ+izk9rHPifV
	 2kvenovbI+rQy/8P/QqBFRqAZdoLRdQ3KFKkZ77eG6atTPEaoxI07/0dShnj+7BaUz
	 jfaq8j6kmlmE0GSJWRLQc+vz6TBvfj2xIPMC+th7k2xiQcCI2eepNts/5BBMVYvLdv
	 mQV1w6JGZivWm5WKetq466nh+Dxm9h0R0kZZGFeGv5QKekAFoxlCK0si+WOzO0wp/o
	 xADev03UJEMgw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: device alias: add sanity check for device alias inode
Date: Tue, 24 Sep 2024 10:30:07 +0800
Message-Id: <20240924023007.2471817-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do sanity check for extent info of device alias inode, in order to
avoid unexpected error caused by fuzz test.

Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---

To Daeho and Jaegeuk,

Merge this into initial patch or merge it separately is both fine
to me.

 fs/f2fs/extent_cache.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 0c8a705faa8b..5bf9e4c2b49c 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -24,6 +24,7 @@ bool sanity_check_extent_cache(struct inode *inode, struct page *ipage)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_extent *i_ext = &F2FS_INODE(ipage)->i_ext;
 	struct extent_info ei;
+	int devi;
 
 	get_read_extent_info(&ei, i_ext);
 
@@ -38,7 +39,36 @@ bool sanity_check_extent_cache(struct inode *inode, struct page *ipage)
 			  ei.blk, ei.fofs, ei.len);
 		return false;
 	}
-	return true;
+
+	if (!IS_DEVICE_ALIASING(inode))
+		return true;
+
+	for (devi = 0; devi < sbi->s_ndevs; devi++) {
+		if (FDEV(devi).start_blk != ei.blk ||
+			FDEV(devi).end_blk != ei.blk + ei.len)
+			continue;
+
+		if (devi == 0) {
+			f2fs_warn(sbi,
+				"%s: inode (ino=%lx) is an alias of meta device",
+				__func__, inode->i_ino);
+			return false;
+		}
+
+		if (bdev_is_zoned(FDEV(devi).bdev)) {
+			f2fs_warn(sbi,
+				"%s: device alias inode (ino=%lx)'s extent info "
+				"[%u, %u, %u] maps to zoned block device",
+				__func__, inode->i_ino, ei.blk, ei.fofs, ei.len);
+			return false;
+		}
+		return true;
+	}
+
+	f2fs_warn(sbi, "%s: device alias inode (ino=%lx)'s extent info "
+			"[%u, %u, %u] is inconsistent w/ any devices",
+			__func__, inode->i_ino, ei.blk, ei.fofs, ei.len);
+	return false;
 }
 
 static void __set_extent_info(struct extent_info *ei,
-- 
2.40.1


