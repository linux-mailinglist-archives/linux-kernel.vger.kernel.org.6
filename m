Return-Path: <linux-kernel+bounces-544137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A726BA4DDC7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5293167C87
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911C1202984;
	Tue,  4 Mar 2025 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dK9k1H5v"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5891FF7B3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741091015; cv=none; b=tew+jxoOwgyvExnLxiFvb7XKCV8V0ag1o5Y20sGOY0YsORvmHwSh4o12mz0QdVsXQTECZS1fMqrD7dTQzjaLjKVj8Oph6GqVUJ9vNt7V1nk9nSWYAIZYPovTPdVXEDV/xAXS/uHFT8T8koqevwp582a8j/TUSdqPItYZAYBBYOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741091015; c=relaxed/simple;
	bh=frDtmP/hC81btrl3w85t3YHdB5mEcrLb6ZDC6l4z81g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F8xixTYPmTr8i5zuf4Yj6DAiPlzRtH7pQFd5DaQ6p85kq/o58dwGWwqkYyaMTiz2tFtJDIWfGw080cSDYZWj3DxWQUdTOMPDOBLai6dIoTY0kSI5WsRP32l4K7RC9hAsqJ+/DW+PbKad8ERhHNGl6ohR5V8YlOUVvVASgIWzHx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dK9k1H5v; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ADKsc
	ftrjVy9nyTMtam3wp4e2jrb1IzFx+TtrZ0E7pM=; b=dK9k1H5v3NUsCDoacXnvN
	hYBhgP7H9TfJVt1GzYs0CH3VOV6xpNqVFi/P7Ls5WqdLukEjXdlZkARUAAXSHfON
	kUSXdq7ruiTpsG43U/SjvaR2LTOZAjNj/gwguQN+a7s+xhtiugo8BrvLCHDLIMtn
	8s11qGiEUHhfZl/hrM+8xI=
Received: from zhuxin.hobot.cc (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAnTqaA8MZn5+LlPQ--.25259S2;
	Tue, 04 Mar 2025 20:22:32 +0800 (CST)
From: Zxyan Zhu <zxyan20@163.com>
To: broonie@kernel.org
Cc: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan20@163.com>
Subject: [PATCH] regmap: debugfs: Fix name collision without atomic operations
Date: Tue,  4 Mar 2025 20:22:21 +0800
Message-Id: <20250304122221.3317232-1-zxyan20@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnTqaA8MZn5+LlPQ--.25259S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWxXryfCF4fGr1kAF1fZwb_yoW8Jw1rpa
	n8GF1Fkwn7Ar4rJryaka18AFySk392qasxA3y8uw1F9rnaqr43XFsaqFW5trWkWry8X3Wj
	qF45A34UCr4UK3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piYFAdUUUUU=
X-CM-SenderInfo: p201t0isq6il2tof0z/xtbBhhYGXmfG7lAuhAAAs9

A global variable caused debugfs name conflicts during re-entry,
leading to creation failures. Use atomic operations to ensure safe
and unique naming.

Signed-off-by: Zxyan Zhu <zxyan20@163.com>
---
 drivers/base/regmap/regmap-debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index fb84cda92a75..914fc032861d 100644
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
@@ -596,11 +596,11 @@ void regmap_debugfs_init(struct regmap *map)
 	if (!strcmp(name, "dummy")) {
 		kfree(map->debugfs_name);
 		map->debugfs_name = kasprintf(GFP_KERNEL, "dummy%d",
-						dummy_index);
+						atomic_read(&dummy_index));
 		if (!map->debugfs_name)
 			return;
 		name = map->debugfs_name;
-		dummy_index++;
+		atomic_inc(&dummy_index);
 	}
 
 	map->debugfs = debugfs_create_dir(name, regmap_debugfs_root);
-- 
2.34.1


