Return-Path: <linux-kernel+bounces-245544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3642F92B42F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F9F7B21A47
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CDA15574E;
	Tue,  9 Jul 2024 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QXsmSVAQ"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D807153804
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518076; cv=none; b=XgRlojls4P/Xr6EDxqBvKHsCrPSiDW88hYEQy6WtwPHyVGuij8LMhl9+D6pyP7LOg7rjDcZceckP4QpavrNmQyin5RSDOvvyddOlhqZ2VI80zQVPHWhe0RFyyPXg9wJ8TqRLsIiyS3Lp6gW3s205GCYBWMAxV/Omf8T/fIRk3eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518076; c=relaxed/simple;
	bh=lkHnsAVMD2n6+cLov0SG3/FJWwUUYKnrp0+zBX9YiKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kqc0WUbIffeQJAewilLohr5m6FYv7Ye/vB4Cv/jdBpony94M65NlF8nckNyXpIhNFveC9N2fFT/ZKmTl1rSbna8iJedwZWHjj4hjATA/KFmrXauB1CnWNKtkP1DjkaXrhvDd4+GA8iQm9J7QGWopphKQIrw3vyRKiGCymNMJTas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QXsmSVAQ; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720518071; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mnfODdi6xR1Qy20b5GA/C0RKjSjBbS/0pCoFXuPsCN4=;
	b=QXsmSVAQ5X8mrrSwc9xe1UP10hsY1ndfPpI0kuDkch2P8f2oKhG4EsKa3jX/odnzpYrlq/syJy8n+VvbeSYP5J9Z8DYCyRPfv0nL3qswZHfyG0LjmdLRpsIg8ZS2Mp8F4goI2G0eHEIGMob5dVcpyV85RIXQRVQS3sRj2ovygn0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0WABZZmR_1720518067;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WABZZmR_1720518067)
          by smtp.aliyun-inc.com;
          Tue, 09 Jul 2024 17:41:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/3] erofs: move each decompressor to its own source file
Date: Tue,  9 Jul 2024 17:41:04 +0800
Message-ID: <20240709094106.3018109-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thus *_config() function declarations can be avoided.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/compress.h             | 20 +++++-------------
 fs/erofs/decompressor.c         | 36 ++++++++++-----------------------
 fs/erofs/decompressor_deflate.c | 12 ++++++++---
 fs/erofs/decompressor_lzma.c    | 12 ++++++++---
 fs/erofs/decompressor_zstd.c    | 12 ++++++++---
 fs/erofs/zdata.c                |  2 +-
 6 files changed, 44 insertions(+), 50 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 19d53c30c8af..c68d5739932f 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -81,21 +81,11 @@ static inline bool z_erofs_put_shortlivedpage(struct page **pagepool,
 	return true;
 }
 
+extern const struct z_erofs_decompressor z_erofs_lzma_decomp;
+extern const struct z_erofs_decompressor z_erofs_deflate_decomp;
+extern const struct z_erofs_decompressor z_erofs_zstd_decomp;
+extern const struct z_erofs_decompressor *z_erofs_decomp[];
+
 int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
 			 unsigned int padbufsize);
-extern const struct z_erofs_decompressor erofs_decompressors[];
-
-/* prototypes for specific algorithms */
-int z_erofs_load_lzma_config(struct super_block *sb,
-			struct erofs_super_block *dsb, void *data, int size);
-int z_erofs_load_deflate_config(struct super_block *sb,
-			struct erofs_super_block *dsb, void *data, int size);
-int z_erofs_load_zstd_config(struct super_block *sb,
-			struct erofs_super_block *dsb, void *data, int size);
-int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
-			    struct page **pagepool);
-int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
-			       struct page **pagepool);
-int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
-			    struct page **pgpl);
 #endif
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 9d85b6c11c6b..de50a9de4e8a 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -371,40 +371,28 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 	return 0;
 }
 
-const struct z_erofs_decompressor erofs_decompressors[] = {
-	[Z_EROFS_COMPRESSION_SHIFTED] = {
+const struct z_erofs_decompressor *z_erofs_decomp[] = {
+	[Z_EROFS_COMPRESSION_SHIFTED] = &(const struct z_erofs_decompressor) {
 		.decompress = z_erofs_transform_plain,
 		.name = "shifted"
 	},
-	[Z_EROFS_COMPRESSION_INTERLACED] = {
+	[Z_EROFS_COMPRESSION_INTERLACED] = &(const struct z_erofs_decompressor) {
 		.decompress = z_erofs_transform_plain,
 		.name = "interlaced"
 	},
-	[Z_EROFS_COMPRESSION_LZ4] = {
+	[Z_EROFS_COMPRESSION_LZ4] = &(const struct z_erofs_decompressor) {
 		.config = z_erofs_load_lz4_config,
 		.decompress = z_erofs_lz4_decompress,
 		.name = "lz4"
 	},
 #ifdef CONFIG_EROFS_FS_ZIP_LZMA
-	[Z_EROFS_COMPRESSION_LZMA] = {
-		.config = z_erofs_load_lzma_config,
-		.decompress = z_erofs_lzma_decompress,
-		.name = "lzma"
-	},
+	[Z_EROFS_COMPRESSION_LZMA] = &z_erofs_lzma_decomp,
 #endif
 #ifdef CONFIG_EROFS_FS_ZIP_DEFLATE
-	[Z_EROFS_COMPRESSION_DEFLATE] = {
-		.config = z_erofs_load_deflate_config,
-		.decompress = z_erofs_deflate_decompress,
-		.name = "deflate"
-	},
+	[Z_EROFS_COMPRESSION_DEFLATE] = &z_erofs_deflate_decomp,
 #endif
 #ifdef CONFIG_EROFS_FS_ZIP_ZSTD
-	[Z_EROFS_COMPRESSION_ZSTD] = {
-		.config = z_erofs_load_zstd_config,
-		.decompress = z_erofs_zstd_decompress,
-		.name = "zstd"
-	},
+	[Z_EROFS_COMPRESSION_ZSTD] = &z_erofs_zstd_decomp,
 #endif
 };
 
@@ -432,6 +420,7 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
 	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
 	alg = 0;
 	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
+		const struct z_erofs_decompressor *dec = z_erofs_decomp[alg];
 		void *data;
 
 		if (!(algs & 1))
@@ -443,16 +432,13 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
 			break;
 		}
 
-		if (alg >= ARRAY_SIZE(erofs_decompressors) ||
-		    !erofs_decompressors[alg].config) {
+		if (alg < Z_EROFS_COMPRESSION_MAX && dec && dec->config) {
+			ret = dec->config(sb, dsb, data, size);
+		} else {
 			erofs_err(sb, "algorithm %d isn't enabled on this kernel",
 				  alg);
 			ret = -EOPNOTSUPP;
-		} else {
-			ret = erofs_decompressors[alg].config(sb,
-					dsb, data, size);
 		}
-
 		kfree(data);
 		if (ret)
 			break;
diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index 3a3461561a3c..1c0ed77dcdb2 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -49,7 +49,7 @@ int __init z_erofs_deflate_init(void)
 	return 0;
 }
 
-int z_erofs_load_deflate_config(struct super_block *sb,
+static int z_erofs_load_deflate_config(struct super_block *sb,
 			struct erofs_super_block *dsb, void *data, int size)
 {
 	struct z_erofs_deflate_cfgs *dfl = data;
@@ -97,8 +97,8 @@ int z_erofs_load_deflate_config(struct super_block *sb,
 	return -ENOMEM;
 }
 
-int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
-			       struct page **pgpl)
+static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
+				      struct page **pgpl)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -252,3 +252,9 @@ int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 	wake_up(&z_erofs_deflate_wq);
 	return err;
 }
+
+const struct z_erofs_decompressor z_erofs_deflate_decomp = {
+	.config = z_erofs_load_deflate_config,
+	.decompress = z_erofs_deflate_decompress,
+	.name = "deflate",
+};
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 4b28dc130c9f..9cab3a2f7558 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -70,7 +70,7 @@ int __init z_erofs_lzma_init(void)
 	return 0;
 }
 
-int z_erofs_load_lzma_config(struct super_block *sb,
+static int z_erofs_load_lzma_config(struct super_block *sb,
 			struct erofs_super_block *dsb, void *data, int size)
 {
 	static DEFINE_MUTEX(lzma_resize_mutex);
@@ -147,8 +147,8 @@ int z_erofs_load_lzma_config(struct super_block *sb,
 	return err;
 }
 
-int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
-			    struct page **pgpl)
+static int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
+				   struct page **pgpl)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -293,3 +293,9 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 	wake_up(&z_erofs_lzma_wq);
 	return err;
 }
+
+const struct z_erofs_decompressor z_erofs_lzma_decomp = {
+	.config = z_erofs_load_lzma_config,
+	.decompress = z_erofs_lzma_decompress,
+	.name = "lzma"
+};
diff --git a/fs/erofs/decompressor_zstd.c b/fs/erofs/decompressor_zstd.c
index 63a23cac3af4..e8f931d41e60 100644
--- a/fs/erofs/decompressor_zstd.c
+++ b/fs/erofs/decompressor_zstd.c
@@ -72,7 +72,7 @@ int __init z_erofs_zstd_init(void)
 	return 0;
 }
 
-int z_erofs_load_zstd_config(struct super_block *sb,
+static int z_erofs_load_zstd_config(struct super_block *sb,
 			struct erofs_super_block *dsb, void *data, int size)
 {
 	static DEFINE_MUTEX(zstd_resize_mutex);
@@ -135,8 +135,8 @@ int z_erofs_load_zstd_config(struct super_block *sb,
 	return strm ? -ENOMEM : 0;
 }
 
-int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
-			    struct page **pgpl)
+static int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
+				   struct page **pgpl)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -277,3 +277,9 @@ int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 	wake_up(&z_erofs_zstd_wq);
 	return err;
 }
+
+const struct z_erofs_decompressor z_erofs_zstd_decomp = {
+	.config = z_erofs_load_zstd_config,
+	.decompress = z_erofs_zstd_decompress,
+	.name = "zstd",
+};
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index d6fe002a4a71..40ad9c80433e 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1221,7 +1221,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
 	const struct z_erofs_decompressor *decomp =
-				&erofs_decompressors[pcl->algorithmformat];
+				z_erofs_decomp[pcl->algorithmformat];
 	int i, err2;
 	struct page *page;
 	bool overlapped;
-- 
2.43.5


