Return-Path: <linux-kernel+bounces-216801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ABB90A6ED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C35D7B27415
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6776188CDB;
	Mon, 17 Jun 2024 07:12:09 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4264469D31
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608329; cv=none; b=mYC9Px8+YKUkTEUeV618o6lUaTtUvZqVnCEiYTbc7wlA3hImaTyyjW+Lhyf/+jO+Rqgckkybg/9Gmtvo9zqQzBA8rhECnQPuKxm+ohFkKo2PGF2y6MJxcg8zRtfZZeuwoj7I8kSMipuRyV+CHGokMZH4V9/BrmnpYKfgHDfyzQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608329; c=relaxed/simple;
	bh=IxAjpXHCQfUqANmOrN/l8pHct/oBNLBV43/EMpCyoEw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ApX/YC5DV7NTDByx4UZ6i21DDEh4u0PVnF4nn8yui6vDbU/JPKSJxw6ZJlw/zRYRNB3ydnDr4jvtGEBSMzbnjbzcaZAGYrUmVZ6kzgfS1O32+x+n4bnn002nbHIBloeZTv4UShttpAp5O73WL56T9RsDnRDK0YVErsBl2gi5naI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 45H7BJWB088492;
	Mon, 17 Jun 2024 15:11:19 +0800 (+08)
	(envelope-from Xiuhong.Wang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4W2gt66fsrz2Rm6ZP;
	Mon, 17 Jun 2024 15:06:54 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 17 Jun 2024 15:11:17 +0800
From: Xiuhong Wang <xiuhong.wang@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC: <niuzhiguo84@gmail.com>, <ke.wang@unisoc.com>, <xiuhong.wang.cn@gmail.com>,
        <hao_hao.wang@unisoc.com>
Subject: [PATCH] f2fs-tools: fix do_set_verity ioctl fail issue
Date: Mon, 17 Jun 2024 15:11:14 +0800
Message-ID: <20240617071114.150721-1-xiuhong.wang@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 45H7BJWB088492

When using the f2fs_io tool to set_verity, it will fail as follows:
unisc:/data # ./f2fs_io set_verity file
FS_IOC_ENABLE_VERITY: Inappropriate ioctl for device
this is because commit: 95ae251fe828 ("f2fs: add fs-verity support"),
the passed parameters do not match the latest kernel version.

After patch:
unisoc:/data # ./f2fs_io set_verity file
Set fsverity bit to file
unisoc:/data # ./f2fs_io getflags file
get a flag on file ret=0, flags=verity

Fixes: 95ae251fe828 ("f2fs: add fs-verity support")
Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 include/android_config.h |  1 +
 tools/f2fs_io/f2fs_io.c  |  9 ++++++---
 tools/f2fs_io/f2fs_io.h  | 20 ++++++++++++++++++--
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/android_config.h b/include/android_config.h
index 05b686e..9c8b163 100644
--- a/include/android_config.h
+++ b/include/android_config.h
@@ -13,6 +13,7 @@
 #define HAVE_LINUX_XATTR_H 1
 #define HAVE_LINUX_FS_H 1
 #define HAVE_LINUX_FIEMAP_H 1
+#define HAVE_LINUX_VERITY_H 1
 #define HAVE_MNTENT_H 1
 #define HAVE_STDLIB_H 1
 #define HAVE_STRING_H 1
diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index a7b593a..2447490 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -182,16 +182,19 @@ static void do_fsync(int argc, char **argv, const struct cmd_desc *cmd)
 static void do_set_verity(int argc, char **argv, const struct cmd_desc *cmd)
 {
 	int ret, fd;
+	struct fsverity_enable_arg args = {.version = 1};
+
+	args.hash_algorithm = FS_VERITY_HASH_ALG_SHA256;
+	args.block_size = 4096;
 
 	if (argc != 2) {
 		fputs("Excess arguments\n\n", stderr);
 		fputs(cmd->cmd_help, stderr);
 		exit(1);
 	}
+	fd = open(argv[1], O_RDONLY);
 
-	fd = open(argv[1], O_RDWR);
-
-	ret = ioctl(fd, FS_IOC_ENABLE_VERITY);
+	ret = ioctl(fd, FS_IOC_ENABLE_VERITY, &args);
 	if (ret < 0) {
 		perror("FS_IOC_ENABLE_VERITY");
 		exit(1);
diff --git a/tools/f2fs_io/f2fs_io.h b/tools/f2fs_io/f2fs_io.h
index b5c82f5..e55db5f 100644
--- a/tools/f2fs_io/f2fs_io.h
+++ b/tools/f2fs_io/f2fs_io.h
@@ -16,6 +16,9 @@
 #ifdef HAVE_LINUX_FS_H
 #include <linux/fs.h>
 #endif
+#ifdef HAVE_LINUX_VERITY_H
+#include <linux/fsverity.h>
+#endif
 
 #include <sys/types.h>
 
@@ -136,8 +139,21 @@ struct fscrypt_get_policy_ex_arg {
 #define F2FS_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
 #define F2FS_IOC_GET_ENCRYPTION_PWSALT	FS_IOC_GET_ENCRYPTION_PWSALT
 
-#define FS_IOC_ENABLE_VERITY		_IO('f', 133)
-
+#ifndef FS_IOC_ENABLE_VERITY
+#define FS_IOC_ENABLE_VERITY    _IOW('f', 133, struct fsverity_enable_arg)
+#define FS_VERITY_HASH_ALG_SHA256       1
+struct fsverity_enable_arg {
+	__u32 version;
+	__u32 hash_algorithm;
+	__u32 block_size;
+	__u32 salt_size;
+	__u64 salt_ptr;
+	__u32 sig_size;
+	__u32 __reserved1;
+	__u64 sig_ptr;
+	__u64 __reserved2[11];
+};
+#endif
 /*
  * Inode flags
  */
-- 
2.25.1


