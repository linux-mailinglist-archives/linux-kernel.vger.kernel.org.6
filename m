Return-Path: <linux-kernel+bounces-211049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E330904C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262501F2413E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77928770EA;
	Wed, 12 Jun 2024 07:18:43 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6711F17C9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176723; cv=none; b=hvIcT57iCR+8jc6SIGXx1l7IdUBDK5M/85TJsC8ZxqwIugCZrzQkC4Ytu8GkcAJDwNVFU5rnmwVWp3vXDaawIUkrkRM8TCJEhDkfdxNwYHHGCPqEMNYdLJxER2iOuQVWL8x11cN/U9X4f9aCBU2gY9TqN+sMWg7IdkPzS7khdYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176723; c=relaxed/simple;
	bh=sXTevao1JDX3evXL7fIAL2QA3pH9M9EPA9JGPsK2sSc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xgt+85x6HCSackziIxzRv8wtvlHi3d75PVO6+mA4fiHL44Te62ulDGUxgtlXR0xR3nkPl6LfM4P1gYKPahci1aj1lOSxdd6WmBXtycruV7BUCYu4VJ9AEdINMWyrba8jE1LcILl0fxmGaPecmYo7syxZpvl03Xm/uk8d5pitg5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 45C7HtJC015511;
	Wed, 12 Jun 2024 15:17:55 +0800 (+08)
	(envelope-from Xiuhong.Wang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VzcGF48Lcz2QkWK3;
	Wed, 12 Jun 2024 15:13:41 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 12 Jun 2024 15:17:53 +0800
From: Xiuhong Wang <xiuhong.wang@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC: <niuzhiguo84@gmail.com>, <ke.wang@unisoc.com>, <xiuhong.wang.cn@gmail.com>
Subject: [PATCH 1/1] f2fs-tools: use atoll replace atoi to avoid data truncate
Date: Wed, 12 Jun 2024 15:17:49 +0800
Message-ID: <20240612071749.348843-1-xiuhong.wang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 45C7HtJC015511

If input exceeds int range, data will be truncated, such as lseek:
unisoc:/data # ./f2fs_io lseek set 3221225000 file
returned offset=2147483647
The offset is truncated.

After patch:
unisoc:/data # ./f2fs_io lseek set 3221225000 file
returned offset=3221225000

Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 tools/f2fs_io/f2fs_io.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index a7b593a..8c9d433 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -539,7 +539,7 @@ static void do_fallocate(int argc, char **argv, const struct cmd_desc *cmd)
 	if (!strcmp(argv[0], "1"))
 		mode |= FALLOC_FL_KEEP_SIZE;
 
-	offset = atoi(argv[1]);
+	offset = atoll(argv[1]);
 	length = atoll(argv[2]);
 
 	fd = xopen(argv[3], O_RDWR, 0);
@@ -957,7 +957,7 @@ static void do_randread(int argc, char **argv, const struct cmd_desc *cmd)
 
 #define fiemap_desc "get block address in file"
 #define fiemap_help					\
-"f2fs_io fiemap [offset in 4kb] [count] [file_path]\n\n"\
+"f2fs_io fiemap [offset in 4kb] [count in 4kb] [file_path]\n\n"\
 
 #if defined(HAVE_LINUX_FIEMAP_H) && defined(HAVE_LINUX_FS_H)
 static void do_fiemap(int argc, char **argv, const struct cmd_desc *cmd)
@@ -1546,9 +1546,9 @@ static void do_move_range(int argc, char **argv, const struct cmd_desc *cmd)
 
 	fd = xopen(argv[1], O_RDWR, 0);
 	range.dst_fd = xopen(argv[2], O_RDWR | O_CREAT, 0644);
-	range.pos_in = atoi(argv[3]);
-	range.pos_out = atoi(argv[4]);
-	range.len = atoi(argv[5]);
+	range.pos_in = atoll(argv[3]);
+	range.pos_out = atoll(argv[4]);
+	range.len = atoll(argv[5]);
 
 	ret = ioctl(fd, F2FS_IOC_MOVE_RANGE, &range);
 	if (ret < 0)
@@ -1726,7 +1726,7 @@ static void do_lseek(int argc, char **argv, const struct cmd_desc *cmd)
 		exit(1);
 	}
 
-	offset = atoi(argv[2]);
+	offset = atoll(argv[2]);
 
 	if (!strcmp(argv[1], "set"))
 		whence = SEEK_SET;
@@ -1746,7 +1746,7 @@ static void do_lseek(int argc, char **argv, const struct cmd_desc *cmd)
 	ret = lseek(fd, offset, whence);
 	if (ret < 0)
 		die_errno("lseek failed");
-	printf("returned offset=%ld\n", ret);
+	printf("returned offset=%lld\n", (long long)ret);
 	exit(0);
 }
 
-- 
2.25.1


