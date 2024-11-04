Return-Path: <linux-kernel+bounces-394110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6F09BAAAA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 02:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002D3282200
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 01:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A102615B130;
	Mon,  4 Nov 2024 01:57:34 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA06757EB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 01:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730685454; cv=none; b=i22MvvfXsl4HSTPqFp2JVXd2nSk4x/ON7kqhuPZuXjau1bid1fkR7qZWqTM1hIlrsUvF3u6lFj3/qBiLDETsN95Fnnn8FdaYXk5NdZqcjjstejZgfHbpV+yrEYtyBuha2gOUo4ocZuwVILuluX/wVnvP55aAzOS7EesOfhZBh1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730685454; c=relaxed/simple;
	bh=+XFBgz4KEnBUcYoPWF7lXQhssQ9mmugfSRaNNaUjyrg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hZu2nIqYbBC9tZsStHIFr2O6a0wnpEjHu2cp6OobU42adSUIwz2qDrGHJpVVwW56mO7N5oSTmYwelHzHMsvg0D19HkWgkjsN4co4osmzurNMdk1HcfOhrbMLvkzOw735+PUaRKilIR/6CoRksKxQAnYMBLU3NXM7urxpZfl77BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4A41uebh050500;
	Mon, 4 Nov 2024 09:56:40 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XhZLc4QLHz2KKmRb;
	Mon,  4 Nov 2024 09:55:52 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 4 Nov 2024 09:56:37 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <Hao_hao.Wang@unisoc.com>
Subject: [PATCH V2] f2fs: fix to adjust appropriate length for fiemap
Date: Mon, 4 Nov 2024 09:56:12 +0800
Message-ID: <1730685372-2995-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 4A41uebh050500

If user give a file size as "length" parameter for fiemap
operations, but if this size is non-block size aligned,
it will show 2 segments fiemap results even this whole file
is contiguous on disk, such as the following results:

 ./f2fs_io fiemap 0 19034 ylog/analyzer.py
Fiemap: offset = 0 len = 19034
        logical addr.    physical addr.   length           flags
0       0000000000000000 0000000020baa000 0000000000004000 00001000
1       0000000000004000 0000000020bae000 0000000000001000 00001001

after this patch:
./f2fs_io fiemap 0 19034 ylog/analyzer.py
Fiemap: offset = 0 len = 19034
    logical addr.    physical addr.   length           flags
0    0000000000000000 00000000315f3000 0000000000005000 00001001

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
V2: correct commit msg according to Chao's questions
f2fs_io has been modified for testing, the length for fiemap is
real file size, not block number
---
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 306b86b0..9fc229d 100644
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


