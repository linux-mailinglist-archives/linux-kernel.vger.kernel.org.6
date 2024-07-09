Return-Path: <linux-kernel+bounces-245545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FC892B430
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3743C1C217D7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AF415534D;
	Tue,  9 Jul 2024 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Zk/I2ato"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CFD15539D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518077; cv=none; b=nPLy3Qvf2ExEzlcJu3Qzr33AzYcmyt6oZagnulxMC5ALpyQW/+sB4gvUPva32A9MEVrb71oKJ9ldUfZ3LxqjiLyWIEmrobcu6xT6ticqQgMnpsExus8NT8Xcve5SjNTa2tj66WVVg4g2uS3RwdxMP0enc6tUGcCDBESDQ713hkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518077; c=relaxed/simple;
	bh=x55W9F0+WuORKEg6GNCMKasXP0XPSIixRFgeKcoH914=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSpZNAebBy+uMMvyZxsoj61jPtCr87X/W1fB38EDTqZTh7VqoZLC91jD0nne/LaUyuDZL3ufvxjZOBrDB10wfYIpBY2oKfkpC2ruIxQtcl5ueHDrjoIr1HLX6OJjNwudw/pWcZWVNtMNirWxw3hArHdXsoXrReG833PyJ9yz6gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Zk/I2ato; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720518073; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+fymTFP/EAlJjk3kKHD5EP0iLMVhuHOfslFtl2RNPDU=;
	b=Zk/I2atomVcoJxBm2irmtfeg5q8juSTQwL+hz14TMprgqFX9covr1f9qIvXN9+iJnobTct+3IkbuATo8+uGLkCm65gGlDrezD+xG9h/RP5xLO5cJhlem09h1pnvbsCyUM4VkXVeNFaGFFPbuPPELNj9HNFG0Pp3sdGDdwERmdV8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0WABZZoj_1720518071;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WABZZoj_1720518071)
          by smtp.aliyun-inc.com;
          Tue, 09 Jul 2024 17:41:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/3] erofs: refine z_erofs_{init,exit}_subsystem()
Date: Tue,  9 Jul 2024 17:41:05 +0800
Message-ID: <20240709094106.3018109-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240709094106.3018109-1-hsiangkao@linux.alibaba.com>
References: <20240709094106.3018109-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce z_erofs_{init,exit}_decompressor() to unexport
z_erofs_{deflate,lzma,zstd}_{init,exit}().

Besides, call them in z_erofs_{init,exit}_subsystem()
for simplicity.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/compress.h             |  4 ++++
 fs/erofs/decompressor.c         | 28 +++++++++++++++++++++++++++
 fs/erofs/decompressor_deflate.c |  6 ++++--
 fs/erofs/decompressor_lzma.c    |  6 ++++--
 fs/erofs/decompressor_zstd.c    |  6 ++++--
 fs/erofs/internal.h             | 34 ++++-----------------------------
 fs/erofs/super.c                | 34 +++------------------------------
 fs/erofs/zdata.c                | 29 +++++++++++++++++-----------
 8 files changed, 69 insertions(+), 78 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index c68d5739932f..601f533c9649 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -24,6 +24,8 @@ struct z_erofs_decompressor {
 		      void *data, int size);
 	int (*decompress)(struct z_erofs_decompress_req *rq,
 			  struct page **pagepool);
+	int (*init)(void);
+	void (*exit)(void);
 	char *name;
 };
 
@@ -88,4 +90,6 @@ extern const struct z_erofs_decompressor *z_erofs_decomp[];
 
 int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
 			 unsigned int padbufsize);
+int __init z_erofs_init_decompressor(void);
+void z_erofs_exit_decompressor(void);
 #endif
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index de50a9de4e8a..b22fce114061 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2019 HUAWEI, Inc.
  *             https://www.huawei.com/
+ * Copyright (C) 2024 Alibaba Cloud
  */
 #include "compress.h"
 #include <linux/lz4.h>
@@ -383,6 +384,8 @@ const struct z_erofs_decompressor *z_erofs_decomp[] = {
 	[Z_EROFS_COMPRESSION_LZ4] = &(const struct z_erofs_decompressor) {
 		.config = z_erofs_load_lz4_config,
 		.decompress = z_erofs_lz4_decompress,
+		.init = z_erofs_gbuf_init,
+		.exit = z_erofs_gbuf_exit,
 		.name = "lz4"
 	},
 #ifdef CONFIG_EROFS_FS_ZIP_LZMA
@@ -446,3 +449,28 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
 	erofs_put_metabuf(&buf);
 	return ret;
 }
+
+int __init z_erofs_init_decompressor(void)
+{
+	int i, err;
+
+	for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
+		err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
+		if (err) {
+			while (--i)
+				if (z_erofs_decomp[i])
+					z_erofs_decomp[i]->exit();
+			return err;
+		}
+	}
+	return 0;
+}
+
+void z_erofs_exit_decompressor(void)
+{
+	int i;
+
+	for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i)
+		if (z_erofs_decomp[i])
+			z_erofs_decomp[i]->exit();
+}
diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index 1c0ed77dcdb2..79232ef15654 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -15,7 +15,7 @@ static DECLARE_WAIT_QUEUE_HEAD(z_erofs_deflate_wq);
 
 module_param_named(deflate_streams, z_erofs_deflate_nstrms, uint, 0444);
 
-void z_erofs_deflate_exit(void)
+static void z_erofs_deflate_exit(void)
 {
 	/* there should be no running fs instance */
 	while (z_erofs_deflate_avail_strms) {
@@ -41,7 +41,7 @@ void z_erofs_deflate_exit(void)
 	}
 }
 
-int __init z_erofs_deflate_init(void)
+static int __init z_erofs_deflate_init(void)
 {
 	/* by default, use # of possible CPUs instead */
 	if (!z_erofs_deflate_nstrms)
@@ -256,5 +256,7 @@ static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 const struct z_erofs_decompressor z_erofs_deflate_decomp = {
 	.config = z_erofs_load_deflate_config,
 	.decompress = z_erofs_deflate_decompress,
+	.init = z_erofs_deflate_init,
+	.exit = z_erofs_deflate_exit,
 	.name = "deflate",
 };
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 9cab3a2f7558..80e735dc8406 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -18,7 +18,7 @@ static DECLARE_WAIT_QUEUE_HEAD(z_erofs_lzma_wq);
 
 module_param_named(lzma_streams, z_erofs_lzma_nstrms, uint, 0444);
 
-void z_erofs_lzma_exit(void)
+static void z_erofs_lzma_exit(void)
 {
 	/* there should be no running fs instance */
 	while (z_erofs_lzma_avail_strms) {
@@ -46,7 +46,7 @@ void z_erofs_lzma_exit(void)
 	}
 }
 
-int __init z_erofs_lzma_init(void)
+static int __init z_erofs_lzma_init(void)
 {
 	unsigned int i;
 
@@ -297,5 +297,7 @@ static int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 const struct z_erofs_decompressor z_erofs_lzma_decomp = {
 	.config = z_erofs_load_lzma_config,
 	.decompress = z_erofs_lzma_decompress,
+	.init = z_erofs_lzma_init,
+	.exit = z_erofs_lzma_exit,
 	.name = "lzma"
 };
diff --git a/fs/erofs/decompressor_zstd.c b/fs/erofs/decompressor_zstd.c
index e8f931d41e60..49415bc40d7c 100644
--- a/fs/erofs/decompressor_zstd.c
+++ b/fs/erofs/decompressor_zstd.c
@@ -34,7 +34,7 @@ static struct z_erofs_zstd *z_erofs_isolate_strms(bool all)
 	return strm;
 }
 
-void z_erofs_zstd_exit(void)
+static void z_erofs_zstd_exit(void)
 {
 	while (z_erofs_zstd_avail_strms) {
 		struct z_erofs_zstd *strm, *n;
@@ -49,7 +49,7 @@ void z_erofs_zstd_exit(void)
 	}
 }
 
-int __init z_erofs_zstd_init(void)
+static int __init z_erofs_zstd_init(void)
 {
 	/* by default, use # of possible CPUs instead */
 	if (!z_erofs_zstd_nstrms)
@@ -281,5 +281,7 @@ static int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 const struct z_erofs_decompressor z_erofs_zstd_decomp = {
 	.config = z_erofs_load_zstd_config,
 	.decompress = z_erofs_zstd_decompress,
+	.init = z_erofs_zstd_init,
+	.exit = z_erofs_zstd_exit,
 	.name = "zstd",
 };
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 0c1b44ac9524..a094f83098b0 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -458,8 +458,8 @@ void erofs_shrinker_register(struct super_block *sb);
 void erofs_shrinker_unregister(struct super_block *sb);
 int __init erofs_init_shrinker(void);
 void erofs_exit_shrinker(void);
-int __init z_erofs_init_zip_subsystem(void);
-void z_erofs_exit_zip_subsystem(void);
+int __init z_erofs_init_subsystem(void);
+void z_erofs_exit_subsystem(void);
 int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
 					struct erofs_workgroup *egrp);
 int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
@@ -476,37 +476,11 @@ static inline void erofs_shrinker_register(struct super_block *sb) {}
 static inline void erofs_shrinker_unregister(struct super_block *sb) {}
 static inline int erofs_init_shrinker(void) { return 0; }
 static inline void erofs_exit_shrinker(void) {}
-static inline int z_erofs_init_zip_subsystem(void) { return 0; }
-static inline void z_erofs_exit_zip_subsystem(void) {}
-static inline int z_erofs_gbuf_init(void) { return 0; }
-static inline void z_erofs_gbuf_exit(void) {}
+static inline int z_erofs_init_subsystem(void) { return 0; }
+static inline void z_erofs_exit_subsystem(void) {}
 static inline int erofs_init_managed_cache(struct super_block *sb) { return 0; }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
-#ifdef CONFIG_EROFS_FS_ZIP_LZMA
-int __init z_erofs_lzma_init(void);
-void z_erofs_lzma_exit(void);
-#else
-static inline int z_erofs_lzma_init(void) { return 0; }
-static inline int z_erofs_lzma_exit(void) { return 0; }
-#endif	/* !CONFIG_EROFS_FS_ZIP_LZMA */
-
-#ifdef CONFIG_EROFS_FS_ZIP_DEFLATE
-int __init z_erofs_deflate_init(void);
-void z_erofs_deflate_exit(void);
-#else
-static inline int z_erofs_deflate_init(void) { return 0; }
-static inline int z_erofs_deflate_exit(void) { return 0; }
-#endif	/* !CONFIG_EROFS_FS_ZIP_DEFLATE */
-
-#ifdef CONFIG_EROFS_FS_ZIP_ZSTD
-int __init z_erofs_zstd_init(void);
-void z_erofs_zstd_exit(void);
-#else
-static inline int z_erofs_zstd_init(void) { return 0; }
-static inline int z_erofs_zstd_exit(void) { return 0; }
-#endif	/* !CONFIG_EROFS_FS_ZIP_ZSTD */
-
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 int erofs_fscache_register_fs(struct super_block *sb);
 void erofs_fscache_unregister_fs(struct super_block *sb);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index c93bd24d2771..c5673caa8943 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -849,23 +849,7 @@ static int __init erofs_module_init(void)
 	if (err)
 		goto shrinker_err;
 
-	err = z_erofs_lzma_init();
-	if (err)
-		goto lzma_err;
-
-	err = z_erofs_deflate_init();
-	if (err)
-		goto deflate_err;
-
-	err = z_erofs_zstd_init();
-	if (err)
-		goto zstd_err;
-
-	err = z_erofs_gbuf_init();
-	if (err)
-		goto gbuf_err;
-
-	err = z_erofs_init_zip_subsystem();
+	err = z_erofs_init_subsystem();
 	if (err)
 		goto zip_err;
 
@@ -882,16 +866,8 @@ static int __init erofs_module_init(void)
 fs_err:
 	erofs_exit_sysfs();
 sysfs_err:
-	z_erofs_exit_zip_subsystem();
+	z_erofs_exit_subsystem();
 zip_err:
-	z_erofs_gbuf_exit();
-gbuf_err:
-	z_erofs_zstd_exit();
-zstd_err:
-	z_erofs_deflate_exit();
-deflate_err:
-	z_erofs_lzma_exit();
-lzma_err:
 	erofs_exit_shrinker();
 shrinker_err:
 	kmem_cache_destroy(erofs_inode_cachep);
@@ -906,13 +882,9 @@ static void __exit erofs_module_exit(void)
 	rcu_barrier();
 
 	erofs_exit_sysfs();
-	z_erofs_exit_zip_subsystem();
-	z_erofs_zstd_exit();
-	z_erofs_deflate_exit();
-	z_erofs_lzma_exit();
+	z_erofs_exit_subsystem();
 	erofs_exit_shrinker();
 	kmem_cache_destroy(erofs_inode_cachep);
-	z_erofs_gbuf_exit();
 }
 
 static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 40ad9c80433e..b6f7f1fbbfd9 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -449,44 +449,51 @@ static inline int erofs_cpu_hotplug_init(void) { return 0; }
 static inline void erofs_cpu_hotplug_destroy(void) {}
 #endif
 
-void z_erofs_exit_zip_subsystem(void)
+void z_erofs_exit_subsystem(void)
 {
 	erofs_cpu_hotplug_destroy();
 	erofs_destroy_percpu_workers();
 	destroy_workqueue(z_erofs_workqueue);
 	z_erofs_destroy_pcluster_pool();
+	z_erofs_exit_decompressor();
 }
 
-int __init z_erofs_init_zip_subsystem(void)
+int __init z_erofs_init_subsystem(void)
 {
-	int err = z_erofs_create_pcluster_pool();
+	int err = z_erofs_init_decompressor();
 
 	if (err)
-		goto out_error_pcluster_pool;
+		goto err_decompressor;
+
+	err = z_erofs_create_pcluster_pool();
+	if (err)
+		goto err_pcluster_pool;
 
 	z_erofs_workqueue = alloc_workqueue("erofs_worker",
 			WQ_UNBOUND | WQ_HIGHPRI, num_possible_cpus());
 	if (!z_erofs_workqueue) {
 		err = -ENOMEM;
-		goto out_error_workqueue_init;
+		goto err_workqueue_init;
 	}
 
 	err = erofs_init_percpu_workers();
 	if (err)
-		goto out_error_pcpu_worker;
+		goto err_pcpu_worker;
 
 	err = erofs_cpu_hotplug_init();
 	if (err < 0)
-		goto out_error_cpuhp_init;
+		goto err_cpuhp_init;
 	return err;
 
-out_error_cpuhp_init:
+err_cpuhp_init:
 	erofs_destroy_percpu_workers();
-out_error_pcpu_worker:
+err_pcpu_worker:
 	destroy_workqueue(z_erofs_workqueue);
-out_error_workqueue_init:
+err_workqueue_init:
 	z_erofs_destroy_pcluster_pool();
-out_error_pcluster_pool:
+err_pcluster_pool:
+	z_erofs_exit_decompressor();
+err_decompressor:
 	return err;
 }
 
-- 
2.43.5


