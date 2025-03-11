Return-Path: <linux-kernel+bounces-556719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5EDA5CDE9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA6A3A2F37
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447A6263C66;
	Tue, 11 Mar 2025 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjKq4kU7"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B9425FA2F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717781; cv=none; b=Fva2unaR9+NBfL+nqNpE1kF+fNs1wtISG1IlmKtOrwwEff2QLm0KJ0gi+kctulQvWeV/5+wv3HHJOX9KyAGwKWqQAzx0OkCoDc5Q3uH2XOIIk7JmtpqCTFL+yMIPWesDM3BopwJiE5YqrBRLxDy7Q4Hwe6JQK1285fxqrmiibjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717781; c=relaxed/simple;
	bh=zgSKxBt+rElVEw68ebE3jI9WCobyYWxY8zdElXJF0tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p5OK/1evoxp4e6NyEWYOm4fVPxQYPkigqjhL9R+cfGanePe7YeQ8/gEAog+9wXTLfSNBDSWVyMNW3VO2dtifnMZfMK8dGRyynZWCoIB820cu61RbLCOIssHXpuRMXm/sHGVLpDgdyLGBTxHYLtQv5pjEcj/OVA527F4DKS17Les=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjKq4kU7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224191d92e4so103403915ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741717779; x=1742322579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WRTQ4j61hoHCf9EekEGmcFt4dM7Z3jMdsNpn83Wx2KQ=;
        b=CjKq4kU79caMQmKSzEX3W+x9iT6SzKgj9OpMy1Og3ZlHX+28BJ6Rxp9EoU8I71qoZY
         3/RXlzZ1jXt/bFeQlfeLJbI5quQuAo1V/1w0evX0s0fNNQn0hlqLYkFwJ7LscZGNDIUn
         jIXVrBBUc8wMH68brlEb5NMpJELOHj96i3zf1yde2Sw7DYwP0m6RrgS7i9+enayThYG3
         kP5/cRU05owP6GvLKt/rxYrTw9lsLiYarekyZfqjhYb07Voy7oKMGu4R3S+T4sOzLveK
         1N3PnBv6wyEKATrkoAydl6pFN6ih41+/b7PoAtlxKnPc+QPtRPSmYhu7qELIv8U7MVfu
         TzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741717779; x=1742322579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WRTQ4j61hoHCf9EekEGmcFt4dM7Z3jMdsNpn83Wx2KQ=;
        b=l3AOyOZ6KVGF/8ksJDduUiiOHHAr9UiCo189y8iXP0uys9NG0qToWhNfE5yBEQXozS
         xYUpmzec9HeWj0TE4z0pQVLT1w8BNKCsWD7H1gnwMCeWHHBUlnrBuKS2NZg2tQ+o7a1E
         8SsHvEWhYEKghAhdCdqu46tyiHfSTRgYh8nQVx4B93BCPD6MfRRr+uvbfnAwJ28G8WQQ
         tl7M3JJbgAxJVdzJhdWlWK6iSX/cepoq4WeiobYmdDRHMQ4wrj5f7mpQMKTBUslcG9Z/
         UcEo+GscNKj2ImnjGKH3nNwZlT85tOVDGvrP8Ih6vWcXhP4mebTtDSF46kT+3/olJ9y9
         fF4A==
X-Gm-Message-State: AOJu0YyE8/MMsnlYIjtovDj/nMmW0vnc+aybwNEf4+835Cjk2mQ40IBJ
	RaCwE/rbXwW+1aP4CP22Jc3hYC8mJbergllxdVNHyFXk6CBnlH07a8qdOg==
X-Gm-Gg: ASbGncv2Wx7x0JdazSWS1TENTUhWg9nefzFmJPg4xbmG6kMDK2Gb15o6fThdJT7F/1O
	g+2nqElUicDB0WVglVYs81j9KOTuY4A0E2PcQ5D6B9UwIR8+s5/lxEsvjU7IDM3e9vQJpNS4XGP
	GpcJvhAjsbS4BfoRLEB95QjmnGFXj2xs83sShh8c221kDPEpJhpEmRyHSY+TPmGdydjlfRKn7A6
	tjnEEKzV/zxeJblX7dj40NFPpqjGySvuDaOSorbnKwK7ek2lIiv7iiw3/6fvIP+WlRCuF+Zl9ai
	aeeb/3oUh1+pZ3dXdgSUIlcCsbc7DOASlPjBVkz0xawu+Wke9BBA5xNth9EhTbHGvl3IrNjOw2I
	Jr7WFBoslAIkyQQEo9MQg+7BOmL5MiJ+o77OP
X-Google-Smtp-Source: AGHT+IFQGJTTdvG6pVR1MHG6bR1ijM1daouvVEyrnHZC4BKr1lZ7plVYB99CvzkloxCXHvl3HNoOxw==
X-Received: by 2002:a05:6a00:1703:b0:736:a682:deb8 with SMTP id d2e1a72fcca58-736aa9e54edmr31970782b3a.8.1741717778978;
        Tue, 11 Mar 2025 11:29:38 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:76e1:9160:984c:6886])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736c05cb6e3sm6949933b3a.45.2025.03.11.11.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 11:29:38 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: add carve_out sysfs node
Date: Tue, 11 Mar 2025 11:29:31 -0700
Message-ID: <20250311182931.1043290-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

For several zoned storage devices, vendors will provide extra space
which was used for device level GC than specs and F2FS can use this
space for filesystem level GC. To do that, we can reserve the space
using reserved_blocks. However, it is not enough, since this extra
space should not be shown to users. So, with this new sysfs node,
we can hide the space by substracting reserved_blocks from total
bytes.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 10 ++++++++++
 fs/f2fs/f2fs.h                          |  3 +++
 fs/f2fs/super.c                         |  3 ++-
 fs/f2fs/sysfs.c                         |  2 ++
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 3e1630c70d8a..6e327fdc6ef4 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -828,3 +828,13 @@ Date:		November 2024
 Contact:	"Chao Yu" <chao@kernel.org>
 Description:	It controls max read extent count for per-inode, the value of threshold
 		is 10240 by default.
+
+What:		/sys/fs/f2fs/<disk>/carve_out
+Date:		March 2025
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	For several zoned storage devices, vendors will provide extra space which
+		was used for device level GC than specs and F2FS can use this space for
+		filesystem level GC. To do that, we can reserve the space using
+		reserved_blocks. However, it is not enough, since this extra space should
+		not be shown to users. So, with this new sysfs node, we can hide the space
+		by substracting reserved_blocks from total bytes.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1afa7be16e7d..5718996c42a8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1800,6 +1800,9 @@ struct f2fs_sb_info {
 	u64 committed_atomic_block;
 	u64 revoked_atomic_block;
 
+	/* carve out reserved_blocks from total blocks */
+	bool carve_out;
+
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	struct kmem_cache *page_array_slab;	/* page array entry */
 	unsigned int page_array_slab_size;	/* default page array slab size */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 19b67828ae32..42651ec824f9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1836,7 +1836,8 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_blocks = total_count - start_count;
 
 	spin_lock(&sbi->stat_lock);
-
+	if (sbi->carve_out)
+		buf->f_blocks -= sbi->current_reserved_blocks;
 	user_block_count = sbi->user_block_count;
 	total_valid_node_count = valid_node_count(sbi);
 	avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index d15c68b28952..a50f5cfe9fa9 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1065,6 +1065,7 @@ F2FS_SBI_GENERAL_RW_ATTR(max_read_extent_count);
 F2FS_SBI_GENERAL_RO_ATTR(unusable_blocks_per_sec);
 F2FS_SBI_GENERAL_RW_ATTR(blkzone_alloc_policy);
 #endif
+F2FS_SBI_GENERAL_RW_ATTR(carve_out);
 
 /* STAT_INFO ATTR */
 #ifdef CONFIG_F2FS_STAT_FS
@@ -1252,6 +1253,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(warm_data_age_threshold),
 	ATTR_LIST(last_age_weight),
 	ATTR_LIST(max_read_extent_count),
+	ATTR_LIST(carve_out),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


