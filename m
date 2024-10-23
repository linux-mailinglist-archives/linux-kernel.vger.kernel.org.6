Return-Path: <linux-kernel+bounces-377783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293619AC6B9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85BF1F21556
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEC3194136;
	Wed, 23 Oct 2024 09:35:12 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724761714B9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676111; cv=none; b=OYaZFLFDcYti4ZgJoljLM44bQz+nCbCAFWGkNv1I/oq4PpTewAk3ni5pDAccs1yII7vNlOGpU+KcXZ4q5iiwKnwI0R2Mhha+GCClK5WVUx05lMzu6MFQrHsYRntSmkmCD/jXEmm9io+9sIMrnBPeI36haBSSgqyA8HeTe7Bzqqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676111; c=relaxed/simple;
	bh=JQend7FpU+EeOaZmjceERbLGT60A7PUPSr5UnbKk1h0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EhBGH1qCUs5pqYPaRfNDr79tAI6TqKB+dg7TX9FW5aKFAAMOG9LUNHwWuVCilNuYVNa/+EGVdXji1OX4SeZB7US5cUoGLhS1o44aYWgerUrY7S4FsgyvT175YORm7ZeO/VXJ7FHvj5kSJyjbq097htlHq4RTvwY5R+ViOrqwey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XYP3h6y1Yz10Nvh;
	Wed, 23 Oct 2024 17:33:04 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id D28BE14039F;
	Wed, 23 Oct 2024 17:35:06 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 23 Oct
 2024 17:35:06 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <chao@kernel.org>, <jaegeuk@kernel.org>
CC: <bobo.shaobowang@huawei.com>, <linux-f2fs-devel@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] f2fs: Fix not used variable 'index'
Date: Wed, 23 Oct 2024 17:48:50 +0800
Message-ID: <20241023094850.1680709-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100008.china.huawei.com (7.202.181.222)

Fix the following compilation warning:
fs/f2fs/data.c:2391:10: warning: variable ‘index’ set but not used
[-Wunused-but-set-variable]
 2391 |  pgoff_t index;

Only define and set the variable index when the CONFIG_F2FS_FS_COMPRESSION
is enabled.

Fixes: db92e6c729d8 ("f2fs: convert f2fs_mpage_readpages() to use folio")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 94f7b084f601..9202082a3902 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2385,10 +2385,10 @@ static int f2fs_mpage_readpages(struct inode *inode,
 		.nr_cpages = 0,
 	};
 	pgoff_t nc_cluster_idx = NULL_CLUSTER;
+	pgoff_t index;
 #endif
 	unsigned nr_pages = rac ? readahead_count(rac) : 1;
 	unsigned max_nr_pages = nr_pages;
-	pgoff_t index;
 	int ret = 0;
 
 	map.m_pblk = 0;
@@ -2406,9 +2406,9 @@ static int f2fs_mpage_readpages(struct inode *inode,
 			prefetchw(&folio->flags);
 		}
 
+#ifdef CONFIG_F2FS_FS_COMPRESSION
 		index = folio_index(folio);
 
-#ifdef CONFIG_F2FS_FS_COMPRESSION
 		if (!f2fs_compressed_file(inode))
 			goto read_single_page;
 
-- 
2.25.1


