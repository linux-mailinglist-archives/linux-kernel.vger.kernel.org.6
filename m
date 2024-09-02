Return-Path: <linux-kernel+bounces-311187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796EE9685BF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8E21C2222B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10003140E3C;
	Mon,  2 Sep 2024 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pTV9IUXu"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB391D45FF
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275199; cv=none; b=S8t5c0Yb76EZxjz6MwXlMoSpYQMf71zHgwVyj3Lj98wS+wnXFjhYgrEkm23IuOS2UnrfvMSCO6KB3uEE3Ip1EPk1wDJ2gEegdo1qJigQfm/Ed9TPkIOnjauvts6XB1Lv/GVg6T0ahz6BAqfmdQXBxioY+dK9aJTJjZTC2PTlC6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275199; c=relaxed/simple;
	bh=/D19tGyMqi94IO07FaZ2mz3Apm/t5eXAuyucNfsvoxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QS1g7zbA7H8tqsvXTR+u7102o5RKYIpuhCBYOXQMnqEMEQjHMDNbfLkuTqOqflc7uBMx4SuWAjWCLvume6o5+H3x+MpvcQ1IMjI1oDYkol4D5hw8pf2xqQRGD9AVjUlFk6uDaDen8pz3ooUkkaHH3ZR6oQLF/QP1+zQSU0x9cRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pTV9IUXu; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725275195; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3lx/WieEaOEVggL0VOeyWGBi+pM61qJto+aBTEIGQYo=;
	b=pTV9IUXuTM/3BBpAVK/dFiFt8iwpzgvlH3jRYTVKovGzm4L+TtYIJ+CGdALVoRv+stWb123MohQkZhWfx9KQ7y2R5MICyAvVY6g5jnN2Qrv180rFe854pjWhOPl0v/eHwUnn4jIhSgwMztfc8vMK9ViLEVvh5wjArA2om8u+j7E=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WE7YYpT_1725275194)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 19:06:34 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: lihongbo22@huawei.com,
	linux-kernel@vger.kernel.org,
	Hongzhen Luo <hongzhen@linux.alibaba.com>
Subject: [PATCH RFC v4 1/4] erofs: move `struct erofs_anon_fs_type` to super.c
Date: Mon,  2 Sep 2024 19:06:17 +0800
Message-ID: <20240902110620.2202586-2-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240902110620.2202586-1-hongzhen@linux.alibaba.com>
References: <20240902110620.2202586-1-hongzhen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the `struct erofs_anon_fs_type` to the super.c and
expose it in preparation for the upcoming page cache share
feature.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v4: There are no changes compared to v3.
v3: https://lore.kernel.org/all/20240828111959.3677011-2-hongzhen@linux.alibaba.com/
v2: The patch set v2 does not move the `struct erofs_anon_fs_type` to super.c.
v1: https://lore.kernel.org/all/20240722065355.1396365-2-hongzhen@linux.alibaba.com/
---
 fs/erofs/fscache.c  | 13 -------------
 fs/erofs/internal.h |  2 ++
 fs/erofs/super.c    | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index fda16eedafb5..826b2893acb2 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2022, Alibaba Cloud
  * Copyright (C) 2022, Bytedance Inc. All rights reserved.
  */
-#include <linux/pseudo_fs.h>
 #include <linux/fscache.h>
 #include "internal.h"
 
@@ -13,18 +12,6 @@ static LIST_HEAD(erofs_domain_list);
 static LIST_HEAD(erofs_domain_cookies_list);
 static struct vfsmount *erofs_pseudo_mnt;
 
-static int erofs_anon_init_fs_context(struct fs_context *fc)
-{
-	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
-}
-
-static struct file_system_type erofs_anon_fs_type = {
-	.owner		= THIS_MODULE,
-	.name           = "pseudo_erofs",
-	.init_fs_context = erofs_anon_init_fs_context,
-	.kill_sb        = kill_anon_super,
-};
-
 struct erofs_fscache_io {
 	struct netfs_cache_resources cres;
 	struct iov_iter		iter;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 45dc15ebd870..3d6bb1b36378 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -387,6 +387,8 @@ extern const struct file_operations erofs_dir_fops;
 
 extern const struct iomap_ops z_erofs_iomap_report_ops;
 
+extern struct file_system_type erofs_anon_fs_type;
+
 /* flags for erofs_fscache_register_cookie() */
 #define EROFS_REG_COOKIE_SHARE		0x0001
 #define EROFS_REG_COOKIE_NEED_NOEXIST	0x0002
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 6cb5c8916174..afca576144ca 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -10,6 +10,7 @@
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/exportfs.h>
+#include <linux/pseudo_fs.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -834,6 +835,26 @@ static struct file_system_type erofs_fs_type = {
 };
 MODULE_ALIAS_FS("erofs");
 
+static const struct super_operations erofs_anon_sops = {
+	.statfs	= simple_statfs,
+};
+
+static int erofs_anon_init_fs_context(struct fs_context *fc)
+{
+	struct pseudo_fs_context *ctx = init_pseudo(fc, EROFS_SUPER_MAGIC);
+
+	if (ctx)
+		ctx->ops = &erofs_anon_sops;
+	return ctx ? 0 : -ENOMEM;
+}
+
+struct file_system_type erofs_anon_fs_type = {
+	.owner		= THIS_MODULE,
+	.name           = "pseudo_erofs",
+	.init_fs_context = erofs_anon_init_fs_context,
+	.kill_sb        = kill_anon_super,
+};
+
 static int __init erofs_module_init(void)
 {
 	int err;
-- 
2.43.5


