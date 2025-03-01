Return-Path: <linux-kernel+bounces-540015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77328A4AC6C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 15:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4B916E73C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 14:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6522A1E571B;
	Sat,  1 Mar 2025 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xT9hvynK"
Received: from out199-2.us.a.mail.aliyun.com (out199-2.us.a.mail.aliyun.com [47.90.199.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8408A1E3DF7
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740840629; cv=none; b=Djsfjzu0TG9i4g8z1Jpg+amUhYQVEKgvhLGvbkGZHjaxHfXKVw06LzRa3qMFZnQ7WIGzA43L4U/SN8G7KSOAf4r7bZ5CuVVAQV/p9adNoYkL/TRiwf9OjDvD29leDiOVZc9BF1Irw+fazH+znTYMouaY4BikP4DIEIrUF0yFICw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740840629; c=relaxed/simple;
	bh=0RM1j+DywwWJ8i4SROytSoMfisLkjp04QQv7+pnWFiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDI6u+HmMnkz9hPuGASTVbc5TBlYy3uSNm9XkJz5wUeIpGV1Jk0YapT2WboRzop+0UO3mVlpSNuVkd/PVFg9ADI0ScrSR7ZK2VgDCHHFxSH96DzgDs7K/5ZHyKaPyrSwLaHA5UdZ1r8Yc8W7L2T24W39ii9hiY3usWROM+GO/i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xT9hvynK; arc=none smtp.client-ip=47.90.199.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740840614; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=F1wkNOLPVE+3E35nVrJ+MFirrarMWBSrgK7jQArB6mY=;
	b=xT9hvynKLSIsKcoOYrulVRINGDu9/ZImQWvPdXynbcE+v8FIueAkRgD/q938RVQChgiwDP0LuSaNZIAtqlgBOC+Qnk3/C48qNkC2uLBgOs/5RcuL4ISeVB1JDIRNB9XEtl855ef+THfgH2QtYozslDj+U1gSmG24o+0AyK5q1vw=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WQSfpXs_1740840613 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 01 Mar 2025 22:50:13 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	Hongzhen Luo <hongzhen@linux.alibaba.com>
Subject: [RFC PATCH v6 1/7] erofs: move `struct erofs_anon_fs_type` to super.c
Date: Sat,  1 Mar 2025 22:49:38 +0800
Message-ID: <20250301145002.2420830-2-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
References: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
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
 fs/erofs/fscache.c  | 13 -------------
 fs/erofs/internal.h |  2 ++
 fs/erofs/super.c    | 13 +++++++++++++
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index ce3d8737df85..ae7bd9ebff38 100644
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
index 686d835eb533..47004eb89838 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -379,6 +379,8 @@ extern const struct file_operations erofs_dir_fops;
 
 extern const struct iomap_ops z_erofs_iomap_report_ops;
 
+extern struct file_system_type erofs_anon_fs_type;
+
 /* flags for erofs_fscache_register_cookie() */
 #define EROFS_REG_COOKIE_SHARE		0x0001
 #define EROFS_REG_COOKIE_NEED_NOEXIST	0x0002
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 827b62665649..eb052a770088 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -11,6 +11,7 @@
 #include <linux/fs_parser.h>
 #include <linux/exportfs.h>
 #include <linux/backing-dev.h>
+#include <linux/pseudo_fs.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -850,6 +851,18 @@ static struct file_system_type erofs_fs_type = {
 };
 MODULE_ALIAS_FS("erofs");
 
+static int erofs_anon_init_fs_context(struct fs_context *fc)
+{
+	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
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


