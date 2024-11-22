Return-Path: <linux-kernel+bounces-417837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E13849D5996
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 07:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817B91F2138B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 06:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D401714B9;
	Fri, 22 Nov 2024 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQDuyh97"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE1A16F287
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732258223; cv=none; b=KomWzpTGQ516RdKdJwwHsrXXyP2nyi6kgRkK4D0nnvpEHfjNP70g3TB4BcCmRW83rth+UDF1g6t2mHlj+j7pYFbX0jPKOPQXc+TycMekBGG1Oy/0JN6nY9mM2rl27iYvfigpJDiXm4t07B1gxaX+WbbYkfwxYYvy5npBIiBu/dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732258223; c=relaxed/simple;
	bh=E/FXXn+DjDrsmgA7YZCC3j5iYUT9BJN7tfBff5UtGco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Du/t8U3x1XNqaGIYUYWopXBHA+eChdEIusncYpnRI30XOaSCQQAUOYZeMRV/UDScdcXebTfKprsZNJF7/dqzBQ2Kwu0fuu6tjC+iLL/LI+Zkjn64ql0fl/06/+YWOXmCTzkZDS7mESMLNK7VboGrroe4vLNSHJ6OwOUGZZTWVXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQDuyh97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38075C4CED1;
	Fri, 22 Nov 2024 06:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732258222;
	bh=E/FXXn+DjDrsmgA7YZCC3j5iYUT9BJN7tfBff5UtGco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WQDuyh97OPLM4Y73U4u+zxVEgO9bkPlM7PzmDR5kHvZstQ5j0fE5G/FakYlIY+kzT
	 TDh1UEgYduuGCkyrr37Rr1tn7dVRsblMxYPlSHr70TRf+uke4uXwKTThFMWk0qVyGn
	 dnL9fH9b11tUdkOlEDOCPeng4fLuUOGJPd6wASI0CEyHYcPaXWQu32XnK2nnaqQqz9
	 MOIA5WBMUScFJclelYPSkwANSKHDtQ/iDhySrJ9Vn05/lpj24+OosFZMAYQ1iryR2f
	 9wn8/ZGTJU22PLj0saw2spQ0EuS/3WtEU2Xt2n299Ifa2OXSnMy2DHwIi4QMbGByWl
	 GBcUHg/iYgbcg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Xiuhong Wang <xiuhong.wang@unisoc.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: [PATCH v2 2/2] f2fs: add a sysfs node to limit max read extent count per-inode
Date: Fri, 22 Nov 2024 14:50:05 +0800
Message-Id: <20241122065005.3772987-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241122065005.3772987-1-chao@kernel.org>
References: <20241122065005.3772987-1-chao@kernel.org>
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
v2:
- fix to add missing max_read_extent_count sysfs entry declaration
 Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
 fs/f2fs/extent_cache.c                  |  5 ++++-
 fs/f2fs/f2fs.h                          |  4 ++++
 fs/f2fs/sysfs.c                         | 10 ++++++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

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
index bdbf24db667b..6b99dc49f776 100644
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
@@ -1052,6 +1059,8 @@ F2FS_SBI_GENERAL_RW_ATTR(revoked_atomic_block);
 F2FS_SBI_GENERAL_RW_ATTR(hot_data_age_threshold);
 F2FS_SBI_GENERAL_RW_ATTR(warm_data_age_threshold);
 F2FS_SBI_GENERAL_RW_ATTR(last_age_weight);
+/* read extent cache */
+F2FS_SBI_GENERAL_RW_ATTR(max_read_extent_count);
 #ifdef CONFIG_BLK_DEV_ZONED
 F2FS_SBI_GENERAL_RO_ATTR(unusable_blocks_per_sec);
 F2FS_SBI_GENERAL_RW_ATTR(blkzone_alloc_policy);
@@ -1242,6 +1251,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(hot_data_age_threshold),
 	ATTR_LIST(warm_data_age_threshold),
 	ATTR_LIST(last_age_weight),
+	ATTR_LIST(max_read_extent_count),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
-- 
2.40.1


