Return-Path: <linux-kernel+bounces-389993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5E29B7445
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6481285C30
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 06:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6C2143759;
	Thu, 31 Oct 2024 06:01:01 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F9513D882
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 06:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730354461; cv=none; b=q4qTuw7Yjc6VCMMFjwzD7ny/84YgHTgRbmg6+skRP3jFRu6ODxE2swSWYLD7J6etyp1FcqUkJG+PRdFQ8uJ07Tg9w+BshoCkVVtdR1wMXWEnn8BShBKpRXkee9jcGiLYpSNERr7VV+NzIO+JBREiI1g65iepqM0dSsZUttRxH+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730354461; c=relaxed/simple;
	bh=7RTVawJgb3CmjzRjAHER2hH4h9tyVYMX9jQb5nqzFb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZgGmtkimm/Mm2udc4lxuQYnDX+prEez8lgNGV356SkbwsRsKsvkk/+kZXRRTbSwM8vWqRR0TQBAWfGsSRt9usMJ1iXBv1wMbZNSysGVwG7lJa1Hbj5LXydOfO5cJ1y1t4p2kFcF0neRKmBEJtwhTGmNp7/C6HYMgEcBv6A/Plw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 49V60FJl088526;
	Thu, 31 Oct 2024 14:00:15 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XfCxh4Zv5z2K4gjP;
	Thu, 31 Oct 2024 13:59:36 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 31 Oct 2024 14:00:13 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <Hao_hao.Wang@unisoc.com>
Subject: [PATCH 2/2] f2fs: fix to adjust appropriate length for fiemap
Date: Thu, 31 Oct 2024 13:59:53 +0800
Message-ID: <1730354393-19672-2-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1730354393-19672-1-git-send-email-zhiguo.niu@unisoc.com>
References: <1730354393-19672-1-git-send-email-zhiguo.niu@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 49V60FJl088526

If user give a file size as "length" parameter for fiemap
operations, but this size is non-block size aligned,
it will show 2 segments fiemap results even this whole file
is contiguous on disk, such as the following results, please
note that this f2fs_io has been modified for testing.

 ./f2fs_io fiemap 0 19304 ylog/analyzer.py
Fiemap: offset = 0 len = 19304
        logical addr.    physical addr.   length           flags
0       0000000000000000 0000000020baa000 0000000000004000 00001000
1       0000000000004000 0000000020bae000 0000000000001000 00001001

after this patch:
 ./f2fs_io fiemap 0 19304 ylog/analyzer.py
Fiemap: offset = 0 len = 19304
	logical addr.    physical addr.   length           flags
0	0000000000000000 00000000315f3000 0000000000005000 00001000

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
f2fs_io has been modified for testing, the length for fiemap is
real file size, not block number
---
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 90fa8ab..8c9bb42 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1966,8 +1966,8 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			goto out;
 	}
 
-	if (bytes_to_blks(inode, len) == 0)
-		len = blks_to_bytes(inode, 1);
+	if (len & (blks_to_bytes(inode, 1) - 1))
+		len = round_up(len, blks_to_bytes(inode, 1));
 
 	start_blk = bytes_to_blks(inode, start);
 	last_blk = bytes_to_blks(inode, start + len - 1);
-- 
1.9.1


