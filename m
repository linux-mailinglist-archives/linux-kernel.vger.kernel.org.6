Return-Path: <linux-kernel+bounces-416475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963F89D459E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08776B2333B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 01:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E1E13B787;
	Thu, 21 Nov 2024 01:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8Ku1wgc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0727139D1E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 01:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732154280; cv=none; b=TFOoV8xpR3+UCK4eOyuE8cRIxbnHnVaEqGhKdEv6DEOaxZtqyyqcjsG8mVytRHeJdBR/KC1yu30ojOIApUdFTU5/574Nh25q/K9h7M7L+Y7s+pipqXXBWTqH+GzgdjYniOxZg1w+Zy4y6J0zRjxey1TV/jBBJF0RSdKHQNoOQsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732154280; c=relaxed/simple;
	bh=Sx8HEO+F+EE6bWdYBSu5S5n0Pvr1b4pffYsz5svaACs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LHBo3obvijo0K4SLTrJV6KFHAgD3N3g4LsiT/p4XTWnUDPSe0SxtnuJkCqlrulZqDKHCdrly8i2BGvP5kXTtwlfuKMjc9gTXuWngbhF9mei/bC13KO2CSBjXmKzGPKaDyFZwXgCYDgeWvTuxYS0yDyU5mTV1N2lNO767/zZ81QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8Ku1wgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C781AC4CED6;
	Thu, 21 Nov 2024 01:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732154279;
	bh=Sx8HEO+F+EE6bWdYBSu5S5n0Pvr1b4pffYsz5svaACs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e8Ku1wgcT6hpCeDBJs72fO3Rq3N0QeVcmXf1zjqe6gD7EoykpJcvwSqiMQEky7o9l
	 o1tIc2Pg/S7OVKHk3f0/hzobf36u8/IlpFk4CezA+jE9M3RiRR1djXehWtfbsJvXmR
	 zrWF2MatPoszQXOa8Yjx5l0VT1rGg20KqPJSSy7HNu+pEK+nsSwcUrmaexEXa+CONG
	 QhEX/pI2MasRv4C+/FVaixU3bEU5BrWZ5GaV9h//ZZnLKCFA7KwdQsqrRqFns3vX62
	 XE0ZMEjZ6j5q82/9is006E7YKz039q7dt6Ba3i2AxhCS6eCVW/S5YQMqWEvg7JVSK2
	 /Mhua2oU83b/g==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Xiuhong Wang <xiuhong.wang@unisoc.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: [PATCH 2/2] f2fs: add a sysfs node to limit max read extent count per-inode
Date: Thu, 21 Nov 2024 09:57:51 +0800
Message-Id: <20241121015751.2300234-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241121015751.2300234-1-chao@kernel.org>
References: <20241121015751.2300234-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Quoted:
"at this time, there are still 1086911 extent nodes in this zombie
extent tree that need to be cleaned up.

crash_arm64_sprd_v8.0.3++> extent_tree.node_cnt ffffff80896cc500
  node_cnt = {
    counter = 1086911
  },
"

As reported by Xiuhong, there will be a huge number of extent nodes
in extent tree, it may potentially cause:
- slab memory fragments
- extreme long time shrink on extent tree
- low mapping efficiency

Let's add a sysfs node to limit max read extent count for each inode,
by default, value of this threshold is 10240, it can be updated
according to user's requirement.

Reported-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
Closes: https://lore.kernel.org/linux-f2fs-devel/20241112110627.1314632-1-xiuhong.wang@unisoc.com/
Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
 fs/f2fs/extent_cache.c                  | 5 ++++-
 fs/f2fs/f2fs.h                          | 4 ++++
 fs/f2fs/sysfs.c                         | 7 +++++++
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 513296bb6f29..3e1630c70d8a 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -822,3 +822,9 @@ Description:	It controls the valid block ratio threshold not to trigger excessiv
 		for zoned deivces. The initial value of it is 95(%). F2FS will stop the
 		background GC thread from intiating GC for sections having valid blocks
 		exceeding the ratio.
+
+What:		/sys/fs/f2fs/<disk>/max_read_extent_count
+Date:		November 2024
+Contact:	"Chao Yu" <chao@kernel.org>
+Description:	It controls max read extent count for per-inode, the value of threshold
+		is 10240 by default.
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index b7a6817b44b0..347b3b647834 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -717,7 +717,9 @@ static void __update_extent_tree_range(struct inode *inode,
 		}
 
 		if (end < org_end && (type != EX_READ ||
-				org_end - end >= F2FS_MIN_EXTENT_LEN)) {
+			(org_end - end >= F2FS_MIN_EXTENT_LEN &&
+			atomic_read(&et->node_cnt) <
+					sbi->max_read_extent_count))) {
 			if (parts) {
 				__set_extent_info(&ei,
 					end, org_end - end,
@@ -1212,6 +1214,7 @@ void f2fs_init_extent_cache_info(struct f2fs_sb_info *sbi)
 	sbi->hot_data_age_threshold = DEF_HOT_DATA_AGE_THRESHOLD;
 	sbi->warm_data_age_threshold = DEF_WARM_DATA_AGE_THRESHOLD;
 	sbi->last_age_weight = LAST_AGE_WEIGHT;
+	sbi->max_read_extent_count = DEF_MAX_READ_EXTENT_COUNT;
 }
 
 int __init f2fs_create_extent_cache(void)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b65b023a588a..6f2cbf4c5740 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -635,6 +635,9 @@ enum {
 #define DEF_HOT_DATA_AGE_THRESHOLD	262144
 #define DEF_WARM_DATA_AGE_THRESHOLD	2621440
 
+/* default max read extent count per inode */
+#define DEF_MAX_READ_EXTENT_COUNT	10240
+
 /* extent cache type */
 enum extent_type {
 	EX_READ,
@@ -1619,6 +1622,7 @@ struct f2fs_sb_info {
 	/* for extent tree cache */
 	struct extent_tree_info extent_tree[NR_EXTENT_CACHES];
 	atomic64_t allocated_data_blocks;	/* for block age extent_cache */
+	unsigned int max_read_extent_count;	/* max read extent count per inode */
 
 	/* The threshold used for hot and warm data seperation*/
 	unsigned int hot_data_age_threshold;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index bdbf24db667b..d1356c656cac 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -787,6 +787,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "max_read_extent_count")) {
+		if (t > UINT_MAX)
+			return -EINVAL;
+		*ui = (unsigned int)t;
+		return count;
+	}
+
 	if (!strcmp(a->attr.name, "ipu_policy")) {
 		if (t >= BIT(F2FS_IPU_MAX))
 			return -EINVAL;
-- 
2.40.1


