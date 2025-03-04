Return-Path: <linux-kernel+bounces-544412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820BBA4E112
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B9F3BC285
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D10520AF94;
	Tue,  4 Mar 2025 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="caUtKXC2"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF5B205ABE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098332; cv=none; b=b+HvRnmTSRgzyS/3++0Ib+V7VURnkC7ZSiCqW06/1mOaDutzIrGyCUViaph0XoPFetDYecV1+Q1yIQvbPhxxFTDHtnepTvsdyIWz1NWYxYqfYi00P4jM9NnZJQx/yDnLPkam5bcSmYQJcklnesCsLmKX6DKmE0yBrpPmdBOouwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098332; c=relaxed/simple;
	bh=uOBnjqVHku8KLjSmIJeN7+CSJV8wIxJlGQYxylA1bhI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l1WxGOKIW2ButvRMWaoSlAxhSUaZXGzp/V7XI1Qj2FCXKbN8iUh+r9+IHZmO2bEmTg9ECLF6zgDO0NZH361049GKuc2i/Nlrfq3RWjoN/uib1KI6YwosNSw7tgbmhG+wyob0wGlNMDcdcK6mrA4pVFL9E/iJABABNp6amn+Ruo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=caUtKXC2; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=aKGTU
	/dlsOYSmJzvx1y1f0+yqOr7O0TlNGte0WRVQTg=; b=caUtKXC2e2ZvYUUboeHae
	GGalq0s9Fs1NjDxZMkxPplA9J4uhkwNdLIrGJRwGcHMEWdqLfKILq2HW+V3Jn/jQ
	dci81FlAJ14YAFq9lqrEPnT8nAKdAkjXL/KoG8lkO//qkdOdxZWI5ZSjHT16I3wU
	9DIZaPqXY5EnYsXghDOk6E=
Received: from zhuxin.hobot.cc (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDXvwA2DcdnOmUHQQ--.34665S2;
	Tue, 04 Mar 2025 22:25:00 +0800 (CST)
From: Zxyan Zhu <zxyan20@163.com>
To: broonie@kernel.org
Cc: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan20@163.com>
Subject: [PATCH v2] regmap: debugfs: Fix name collision without atomic operations
Date: Tue,  4 Mar 2025 22:24:52 +0800
Message-Id: <20250304142452.3521828-1-zxyan20@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXvwA2DcdnOmUHQQ--.34665S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1UZFyfJF15AryfWw17Wrg_yoW8Cw47pa
	1DGF1Fkws7Jr4rGrWYka18CFySk3929a43A3yru3WF9wnagr43WFsYqFW5tryDWryUXw1U
	XF45A34UCr1jy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piYhF7UUUUU=
X-CM-SenderInfo: p201t0isq6il2tof0z/1tbioAUGXmfG+lFLCgADs1

The `dummy_index` global variable caused debugfs file name conflicts
during re-entry, leading to creation failures. Use atomic operations
to ensure safe and unique debugfs `dummy%d` naming.

Changes since v1:
- Replaced atomic_read + atomic_inc with atomic_inc_return.
- Added atomic_dec in the error path to maintain index consistency.
- Updated the commit message to clarify the fix.

Signed-off-by: Zxyan Zhu <zxyan20@163.com>
---
 drivers/base/regmap/regmap-debugfs.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index fb84cda92a75..60c8d9a673b8 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -20,7 +20,7 @@ struct regmap_debugfs_node {
 	struct list_head link;
 };
 
-static unsigned int dummy_index;
+static atomic_t dummy_index = ATOMIC_INIT(0);
 static struct dentry *regmap_debugfs_root;
 static LIST_HEAD(regmap_debugfs_early_list);
 static DEFINE_MUTEX(regmap_debugfs_early_lock);
@@ -549,6 +549,7 @@ void regmap_debugfs_init(struct regmap *map)
 	struct regmap_range_node *range_node;
 	const char *devname = "dummy";
 	const char *name = map->name;
+	int index;
 
 	/*
 	 * Userspace can initiate reads from the hardware over debugfs.
@@ -595,12 +596,13 @@ void regmap_debugfs_init(struct regmap *map)
 
 	if (!strcmp(name, "dummy")) {
 		kfree(map->debugfs_name);
-		map->debugfs_name = kasprintf(GFP_KERNEL, "dummy%d",
-						dummy_index);
-		if (!map->debugfs_name)
+		index = atomic_inc_return(&dummy_index);
+		map->debugfs_name = kasprintf(GFP_KERNEL, "dummy%d", index);
+		if (!map->debugfs_name) {
+			atomic_dec(&dummy_index);
 			return;
+		}
 		name = map->debugfs_name;
-		dummy_index++;
 	}
 
 	map->debugfs = debugfs_create_dir(name, regmap_debugfs_root);
-- 
2.34.1


