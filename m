Return-Path: <linux-kernel+bounces-212966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6B4906907
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D115B279E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F0413F442;
	Thu, 13 Jun 2024 09:37:00 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6834F13CABC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271420; cv=none; b=H9se83X+uYYDF/rL39wBopaHksQlFlG8/DjvshR5jFygRxj18312/mn2kv4T2aFVt05d0lPhvyeQxdUTCjWXBPfbuotsWxJ5ygxyd+Fje7npB8I9iX71CpM5geK7pQGAcSHsv4l2IcCE7IfVXMjWGQKThP41qizwvBjYnx4zqyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271420; c=relaxed/simple;
	bh=UK3WzRpVVhjaYnEumT7PaqistOVUQ3IJ6RyLMIuezXA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O31d8mmOCdsXZJvWJfjff7g/d+S9j2afk6ftfC4JD/JoYdSnJaebYUMotCT0gFDfUDRjbrabAZ8tN0RLbIa4mup/BnZuvLls32MjdP4joAME0nmCh9sEe7HjTY9NXNBdNtyANE3vRKmYsPi5cNOj3Mrg9a8AmKIhi6uAt8tdNwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 45D9ZqpC082721;
	Thu, 13 Jun 2024 17:35:52 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4W0HGw1xS0z2S2vmG;
	Thu, 13 Jun 2024 17:31:36 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 13 Jun 2024 17:35:50 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <Hao_hao.Wang@unisoc.com>
Subject: [PATCH] f2fs: fix to use mnt_{want,drop}_write_file replace file_{start,end}_wrtie
Date: Thu, 13 Jun 2024 17:35:33 +0800
Message-ID: <1718271333-32179-1-git-send-email-zhiguo.niu@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 45D9ZqpC082721

mnt_{want,drop}_write_file is more suitable than
file_{start,end}_wrtie and also is consistent with
other ioctl operations.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/file.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c50213d..e4a7cff 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3935,7 +3935,9 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 			 IS_ENCRYPTED(inode) && f2fs_is_multi_device(sbi)))
 		return -EOPNOTSUPP;
 
-	file_start_write(filp);
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
 	inode_lock(inode);
 
 	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode) ||
@@ -4061,7 +4063,7 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 err:
 	inode_unlock(inode);
-	file_end_write(filp);
+	mnt_drop_write_file(filp);
 
 	return ret;
 }
@@ -4115,7 +4117,9 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 		option.algorithm >= COMPRESS_MAX)
 		return -EINVAL;
 
-	file_start_write(filp);
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
 	inode_lock(inode);
 
 	f2fs_down_write(&F2FS_I(inode)->i_sem);
@@ -4154,7 +4158,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 out:
 	f2fs_up_write(&F2FS_I(inode)->i_sem);
 	inode_unlock(inode);
-	file_end_write(filp);
+	mnt_drop_write_file(filp);
 
 	return ret;
 }
@@ -4211,7 +4215,9 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 
 	f2fs_balance_fs(sbi, true);
 
-	file_start_write(filp);
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
 	inode_lock(inode);
 
 	if (!f2fs_is_compress_backend_ready(inode)) {
@@ -4266,7 +4272,7 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 	f2fs_update_time(sbi, REQ_TIME);
 out:
 	inode_unlock(inode);
-	file_end_write(filp);
+	mnt_drop_write_file(filp);
 
 	return ret;
 }
@@ -4288,7 +4294,9 @@ static int f2fs_ioc_compress_file(struct file *filp)
 
 	f2fs_balance_fs(sbi, true);
 
-	file_start_write(filp);
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
 	inode_lock(inode);
 
 	if (!f2fs_is_compress_backend_ready(inode)) {
@@ -4344,7 +4352,7 @@ static int f2fs_ioc_compress_file(struct file *filp)
 	f2fs_update_time(sbi, REQ_TIME);
 out:
 	inode_unlock(inode);
-	file_end_write(filp);
+	mnt_drop_write_file(filp);
 
 	return ret;
 }
-- 
1.9.1


