Return-Path: <linux-kernel+bounces-439148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C849EAB6F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE804286AC7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03374231C8C;
	Tue, 10 Dec 2024 09:09:06 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F40231C82
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821745; cv=none; b=ek9temIq8d2hWNNWfrGElhEOwHOkEJUHf3CN9QFs9HSGgY8u5T9Z8SYNLe594p+mBbEPXSNdK3iLNwr6Rm3YLT0vYOizBaS7OBc1XfrXRj4p65gzQSCg6pdkk11MBSQmpwPmvpcHfJOHrxoLihfWus0gVodXgU3H9lbA0dtIPvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821745; c=relaxed/simple;
	bh=arKsm+/xJc5+JDa98EK8Ykqs9SCzqX4iy8pPx1yHN9w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rnrQyV1orZZOMcRl1dRrRJS5Ty81Xm8ByBD1BsprdWDY9Au4uGHVt3hsNXJ8RfhzxYYzLU8qCRefNK1bAnK576IIqvhlFt2nQC/FtWzxvw1sYmRoz3Ocvovp+rgWg4Gexer1XLsxV8Xa/mpWrIzk75GEG9QTf175xNJ9dxLLA2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Y6tBs6vkWz1T6v0;
	Tue, 10 Dec 2024 17:06:29 +0800 (CST)
Received: from kwepemd200025.china.huawei.com (unknown [7.221.188.181])
	by mail.maildlp.com (Postfix) with ESMTPS id F0A94140259;
	Tue, 10 Dec 2024 17:08:54 +0800 (CST)
Received: from Linux-SUSE12SP5.huawei.com (10.67.136.247) by
 kwepemd200025.china.huawei.com (7.221.188.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Dec 2024 17:08:54 +0800
From: pangliyuan <pangliyuan1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <phillip@squashfs.org.uk>
CC: <wangfangpeng1@huawei.com>
Subject: [PATCH] Squashfs: Dont allocate fragment caches more than fragments
Date: Tue, 10 Dec 2024 17:08:42 +0800
Message-ID: <20241210090842.160853-1-pangliyuan1@huawei.com>
X-Mailer: git-send-email 2.12.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200025.china.huawei.com (7.221.188.181)

Sometimes the actual number of fragments in image is between
0 and SQUASHFS_CACHED_FRAGMENTS, which cause additional
fragment caches to be allocated.

Sets the number of fragment caches to the minimum of fragments
and SQUASHFS_CACHED_FRAGMENTS.

Signed-off-by: pangliyuan <pangliyuan1@huawei.com>
---
 fs/squashfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 22e812808e5c..269c6d61bc29 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -405,7 +405,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto check_directory_table;
 
 	msblk->fragment_cache = squashfs_cache_init("fragment",
-		SQUASHFS_CACHED_FRAGMENTS, msblk->block_size);
+		min(SQUASHFS_CACHED_FRAGMENTS, fragments), msblk->block_size);
 	if (msblk->fragment_cache == NULL) {
 		err = -ENOMEM;
 		goto failed_mount;
-- 
2.37.7


