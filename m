Return-Path: <linux-kernel+bounces-284152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397D594FD9B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2952D1C229A6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EB639AFD;
	Tue, 13 Aug 2024 06:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pDMEtOUo"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A502262B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723529477; cv=none; b=S9qeXFOYMx1Q7Oc8HRHG+dH1EtZaugSH0/wYp7QaEKV5/xmTgs1Pt1+UT8EfwYgf6XGB/AbuMW9yMCbL0bL+QTG4R6T0UFtLgtTNHJEp+8f914etN/wKMFKdDgu/avi+5S7kc9FWvuSSz7ACc9cyPvGif7l/pVmKZoVykRKRnuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723529477; c=relaxed/simple;
	bh=lBVLoqgNAssN/IwMKQ9EYLM7KfsQtZeh1JuJffNA1pc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=prJcOiP0LRSc7ezTvhh0GBHWvjtaJlMI9SGpz3PvsrRNVW40yo7jl/5Q+2e0vwjtkzGllOArbCLreKmUFno5r4/j0YJacDmJowWUJ3dz6Z72mlR3yrSikyo+Jks4/u6A6peSF+XpM7xMmxPkhm0FoXL2Y5xniAFxR1dn0VwayXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pDMEtOUo; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240813061106epoutp04e152dc4944f4b3a6ba30a2117bc9e3aa~rNOsI0ngQ0100001000epoutp04B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:11:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240813061106epoutp04e152dc4944f4b3a6ba30a2117bc9e3aa~rNOsI0ngQ0100001000epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723529466;
	bh=PSII6jiuWuTqa/oiiYbWbiZhLnzDYPHabCNSAEb6KOQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=pDMEtOUovXRXHe9le0uWqdKPzQGRYu61SL0Lm81LU9bGaOp4hfHIElhLIK35MukHI
	 9eNOlz1JyiuXwtav0OXdk2fXqc54sNtDGtzdXJ4g+dxM4aJfGcIm8BFALgAE+Jqg3d
	 G8V6MMplal2SaZllXD0UL2MMdYdip+EVFGSwZHEg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240813061106epcas1p42a099dba86c709ac2abf89506a7a9440~rNOrtBTJI0522305223epcas1p4e;
	Tue, 13 Aug 2024 06:11:06 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.240]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WjgxP6Nqlz4x9Q3; Tue, 13 Aug
	2024 06:11:05 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	0C.F3.10258.9F8FAB66; Tue, 13 Aug 2024 15:11:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240813061105epcas1p4898159104ce2ee12ef6c203c4ab828ff~rNOrJVCol0185601856epcas1p4p;
	Tue, 13 Aug 2024 06:11:05 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240813061105epsmtrp1c048547272bddd05c5b2e0636b773bbe~rNOrIHE4H2070920709epsmtrp1U;
	Tue, 13 Aug 2024 06:11:05 +0000 (GMT)
X-AuditID: b6c32a38-22f19a8000002812-05-66baf8f90b70
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	69.66.08456.9F8FAB66; Tue, 13 Aug 2024 15:11:05 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.41]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240813061105epsmtip2f6fb4acd5cf04c2e7e03e2f63f6465c0~rNOq9NolR2910229102epsmtip2S;
	Tue, 13 Aug 2024 06:11:05 +0000 (GMT)
From: Yeongjin Gil <youngjin.gil@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Yeongjin Gil <youngjin.gil@samsung.com>, Sungjong Seo
	<sj1557.seo@samsung.com>, Sunmin Jeong <s_min.jeong@samsung.com>, Jaewook
	Kim <jw5454.kim@samsung.com>
Subject: [PATCH] f2fs: compress: don't redirty sparse cluster during
 {,de}compress
Date: Tue, 13 Aug 2024 15:11:04 +0900
Message-Id: <20240813061104.1052-1-youngjin.gil@samsung.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmnu7PH7vSDOat1bU4PfUsk8WT9bOY
	LVZe+c1icWmRu8XlXXPYLBa0Anlb/h1htZix/ym7A4fHplWdbB67F3xm8ujbsorR4/MmuQCW
	qAZGm8Si5IzMslSF1Lzk/JTMvHRbpdAQN10LJYWM/OISW6VoQ0MjPUMDcz0jIyM9U6NYKyNT
	JYW8xNxUW6UKXaheJYWi5AKg2tzKYqABOal6UHG94tS8FIes/FKQ0/WKE3OLS/PS9ZLzc5UU
	yhJzSoFGKOknfGPM2HJ3GXvBevuK/8fXMjUwzjfpYuTkkBAwkWjZuoeli5GLQ0hgB6NE58+L
	jBDOJ0aJVWdXQWW+MUpMfHGCvYuRA6xlWV82RHwvo8T7TR/Y4Tr6rh9hB5nLJqArMfXlU1YQ
	W0RAXeLUpKVgk5gF3jBKfPxxGaxIWCBE4nNbCyPIVBYBVYlt7d4gYV4BG4kzj7vYIe6Tl7jZ
	tZ8ZIi4ocXLmExYQmxko3rx1NjPITAmBU+wSvR2PmCEaXCReTVnCCmELS7w6vgVqkJTEy/42
	doiGVYwSb1o/MUE42xklpj/uYYOospdobm1mA7mIWUBTYv0ufYhtfBLvvvZADRWUOH2tmxkS
	FLwSHW1CEGE1iSuTfkGVyEj0PZgFtddD4ufiQ2DThQRiJWYtX8oygVF+FpJ/ZiH5ZxbC4gWM
	zKsYxVILinPTU4sNC0yQY3YTIziFalnsYJz79oPeIUYmDsZDjBIczEoivIEmu9KEeFMSK6tS
	i/Lji0pzUosPMSYDA3gis5Rocj4wieeVxBuamVlaWBqZGBqbGRoSFjaxNDAxMzKxMLY0NlMS
	5z1zpSxVSCA9sSQ1OzW1ILUIZgsTB6dUA5OXuZDdvPI5y3SDvG+ek/+add5JZHnPR/NYieCY
	7q7Y6/z71A7wP9npuFVe9pvWu+1ppqdtz1W/mFrUNz3Y9ZQ540Xr9yxruW5OvJec0vRxpoY4
	d8Eag56/FXMV22xPXJyz9YxrY0NuyfF6x12tAiGMH2PW7D/fePJPnPomdtmHCz5tfFx6YrXB
	lPvPTy28auF4t9TqeCn3calPwo9K3Baos3znOlLAsXePptc//+NJUrf8t249EBNg29Otzbx7
	zin1nTpW/r8t2a68e/cqcqVz0oHW47uubNParlCzcvXfEtZuv98fiy1WTTz21ER61erEfyuL
	mw4sE7LlnXlst1KwifjRx3HcmVunH5OcUXZHiaU4I9FQi7moOBEAj1vpkVgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSvO7PH7vSDGa/FLY4PfUsk8WT9bOY
	LVZe+c1icWmRu8XlXXPYLBa0Anlb/h1htZix/ym7A4fHplWdbB67F3xm8ujbsorR4/MmuQCW
	KC6blNSczLLUIn27BK6MLXeXsRest6/4f3wtUwPjfJMuRg4OCQETiWV92V2MXBxCArsZJX5d
	/cLUxcgJFJeR+DPxPRtEjbDE4cPFIGEhgQ+MEm0HC0FsNgFdiakvn7KC2CICmhJHOmeyg9jM
	IDW/J3iC2MICQRIzJ9xkBhnDIqAqsa3dGyTMK2AjceZxFzvEJnmJm137mSHighInZz5hgRgj
	L9G8dTbzBEa+WUhSs5CkFjAyrWKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECA5OLa0d
	jHtWfdA7xMjEwXiIUYKDWUmEN9BkV5oQb0piZVVqUX58UWlOavEhRmkOFiVx3m+ve1OEBNIT
	S1KzU1MLUotgskwcnFINTLuFLteGcbEZplm/2fWuTL/YXskm9GtBycq/R42fORc7iB/IdY60
	Dpf3iP2w55FZMxcPc+PXyoyQ9CniJz4/Kl5vnJnDtjuv32YCq4yzdaMA29/fB5t0Z75UdC75
	E+NS8lHGWGSn4+rDDrtmaD34tGFBnPQ5Cf/AC0pHns+6zLfgqmLwulcvOK7+b7Ze060+69gk
	nY5D27lf3jO76Kf2+EfexcjswLLjqRvjt4saHnURV+04FPy6UtN7yuTggLipn2Ie6Nd0/ngb
	13JbmHkth9fK54c02CZJZ4lw3nIx3H/K+N2m4P2pC6Lqu1d4TH/jxHM/vLw6Ti/Qe6uL8ad/
	k2K//7qfUbbrcPWVBw45SizFGYmGWsxFxYkA2HKDgb0CAAA=
X-CMS-MailID: 20240813061105epcas1p4898159104ce2ee12ef6c203c4ab828ff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240813061105epcas1p4898159104ce2ee12ef6c203c4ab828ff
References: <CGME20240813061105epcas1p4898159104ce2ee12ef6c203c4ab828ff@epcas1p4.samsung.com>

In f2fs_do_write_data_page, when the data block is NULL_ADDR, it skips
writepage considering that it has been already truncated.
This results in an infinite loop as the PAGECACHE_TAG_TOWRITE tag is not
cleared during the writeback process for a compressed file including
NULL_ADDR in compress_mode=user.

This is the reproduction process:

1. dd if=/dev/zero bs=4096 count=1024 seek=1024 of=testfile
2. f2fs_io compress testfile
3. dd if=/dev/zero bs=4096 count=1 conv=notrunc of=testfile
4. f2fs_io decompress testfile

To prevent the problem, let's check whether the cluster is fully
allocated before redirty its pages.

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
Tested-by: Jaewook Kim <jw5454.kim@samsung.com>
Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
---
 fs/f2fs/compress.c | 34 ++++++++++++++++++++++++++--------
 fs/f2fs/f2fs.h     | 12 ++++++++++++
 fs/f2fs/file.c     | 39 +++++++++++++++++++++------------------
 3 files changed, 59 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 990b93689b46..09b91d725807 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -945,7 +945,7 @@ static int __f2fs_get_cluster_blocks(struct inode *inode,
 	unsigned int cluster_size = F2FS_I(inode)->i_cluster_size;
 	int count, i;
 
-	for (i = 1, count = 1; i < cluster_size; i++) {
+	for (i = 0, count = 0; i < cluster_size; i++) {
 		block_t blkaddr = data_blkaddr(dn->inode, dn->node_page,
 							dn->ofs_in_node + i);
 
@@ -956,8 +956,8 @@ static int __f2fs_get_cluster_blocks(struct inode *inode,
 	return count;
 }
 
-static int __f2fs_cluster_blocks(struct inode *inode,
-				unsigned int cluster_idx, bool compr_blks)
+static int __f2fs_cluster_blocks(struct inode *inode, unsigned int cluster_idx,
+				enum cluster_check_type type)
 {
 	struct dnode_of_data dn;
 	unsigned int start_idx = cluster_idx <<
@@ -978,10 +978,12 @@ static int __f2fs_cluster_blocks(struct inode *inode,
 	}
 
 	if (dn.data_blkaddr == COMPRESS_ADDR) {
-		if (compr_blks)
-			ret = __f2fs_get_cluster_blocks(inode, &dn);
-		else
+		if (type == COMPR_BLKS)
+			ret = 1 + __f2fs_get_cluster_blocks(inode, &dn);
+		else if (type == COMPR_CLUSTER)
 			ret = 1;
+	} else if (type == DECOMPR_BLKS) {
+		ret = __f2fs_get_cluster_blocks(inode, &dn);
 	}
 fail:
 	f2fs_put_dnode(&dn);
@@ -991,7 +993,14 @@ static int __f2fs_cluster_blocks(struct inode *inode,
 /* return # of compressed blocks in compressed cluster */
 static int f2fs_compressed_blocks(struct compress_ctx *cc)
 {
-	return __f2fs_cluster_blocks(cc->inode, cc->cluster_idx, true);
+	return __f2fs_cluster_blocks(cc->inode, cc->cluster_idx, COMPR_BLKS);
+}
+
+/* return # of raw blocks in non-compressed cluster */
+static int f2fs_decompressed_blocks(struct inode *inode,
+				unsigned int cluster_idx)
+{
+	return __f2fs_cluster_blocks(inode, cluster_idx, DECOMPR_BLKS);
 }
 
 /* return whether cluster is compressed one or not */
@@ -999,7 +1008,16 @@ int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index)
 {
 	return __f2fs_cluster_blocks(inode,
 		index >> F2FS_I(inode)->i_log_cluster_size,
-		false);
+		COMPR_CLUSTER);
+}
+
+/* return whether the cluster is filled with raw blocks */
+bool f2fs_is_non_sparse_cluster(struct inode *inode, pgoff_t index)
+{
+	unsigned int cluster_idx = index >> F2FS_I(inode)->i_log_cluster_size;
+
+	return f2fs_decompressed_blocks(inode, cluster_idx) ==
+		F2FS_I(inode)->i_cluster_size;
 }
 
 static bool cluster_may_compress(struct compress_ctx *cc)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 51fd5063a69c..6f26c8cb8857 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4302,6 +4302,11 @@ static inline bool f2fs_meta_inode_gc_required(struct inode *inode)
  * compress.c
  */
 #ifdef CONFIG_F2FS_FS_COMPRESSION
+enum cluster_check_type {
+	COMPR_CLUSTER,
+	COMPR_BLKS,
+	DECOMPR_BLKS
+};
 bool f2fs_is_compressed_page(struct page *page);
 struct page *f2fs_compress_control_page(struct page *page);
 int f2fs_prepare_compress_overwrite(struct inode *inode,
@@ -4328,6 +4333,7 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
 						struct writeback_control *wbc,
 						enum iostat_type io_type);
 int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index);
+bool f2fs_is_non_sparse_cluster(struct inode *inode, pgoff_t index);
 void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
 				pgoff_t fofs, block_t blkaddr,
 				unsigned int llen, unsigned int c_len);
@@ -4414,6 +4420,12 @@ static inline bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi,
 static inline void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi,
 							nid_t ino) { }
 #define inc_compr_inode_stat(inode)		do { } while (0)
+static inline int f2fs_is_compressed_cluster(
+				struct inode *inode,
+				pgoff_t index) { return 0; }
+static inline bool f2fs_is_non_sparse_cluster(
+				struct inode *inode,
+				pgoff_t index) { return false; }
 static inline void f2fs_update_read_extent_tree_range_compressed(
 				struct inode *inode,
 				pgoff_t fofs, block_t blkaddr,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 270c32e3385f..fba8b5f216f9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4220,9 +4220,8 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	pgoff_t page_idx = 0, last_idx;
-	int cluster_size = fi->i_cluster_size;
-	int count, ret;
+	pgoff_t page_idx = 0, last_idx, cluster_idx;
+	int ret;
 
 	if (!f2fs_sb_has_compression(sbi) ||
 			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER)
@@ -4257,10 +4256,15 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 		goto out;
 
 	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	last_idx >>= fi->i_log_cluster_size;
+
+	for (cluster_idx = 0; cluster_idx < last_idx; cluster_idx++) {
+		page_idx = cluster_idx << fi->i_log_cluster_size;
+
+		if (!f2fs_is_compressed_cluster(inode, page_idx))
+			continue;
 
-	count = last_idx - page_idx;
-	while (count && count >= cluster_size) {
-		ret = redirty_blocks(inode, page_idx, cluster_size);
+		ret = redirty_blocks(inode, page_idx, fi->i_cluster_size);
 		if (ret < 0)
 			break;
 
@@ -4270,9 +4274,6 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 				break;
 		}
 
-		count -= cluster_size;
-		page_idx += cluster_size;
-
 		cond_resched();
 		if (fatal_signal_pending(current)) {
 			ret = -EINTR;
@@ -4299,9 +4300,9 @@ static int f2fs_ioc_compress_file(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	pgoff_t page_idx = 0, last_idx;
-	int cluster_size = F2FS_I(inode)->i_cluster_size;
-	int count, ret;
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	pgoff_t page_idx = 0, last_idx, cluster_idx;
+	int ret;
 
 	if (!f2fs_sb_has_compression(sbi) ||
 			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER)
@@ -4335,10 +4336,15 @@ static int f2fs_ioc_compress_file(struct file *filp)
 	set_inode_flag(inode, FI_ENABLE_COMPRESS);
 
 	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	last_idx >>= fi->i_log_cluster_size;
 
-	count = last_idx - page_idx;
-	while (count && count >= cluster_size) {
-		ret = redirty_blocks(inode, page_idx, cluster_size);
+	for (cluster_idx = 0; cluster_idx < last_idx; cluster_idx++) {
+		page_idx = cluster_idx << fi->i_log_cluster_size;
+
+		if (!f2fs_is_non_sparse_cluster(inode, page_idx))
+			continue;
+
+		ret = redirty_blocks(inode, page_idx, fi->i_cluster_size);
 		if (ret < 0)
 			break;
 
@@ -4348,9 +4354,6 @@ static int f2fs_ioc_compress_file(struct file *filp)
 				break;
 		}
 
-		count -= cluster_size;
-		page_idx += cluster_size;
-
 		cond_resched();
 		if (fatal_signal_pending(current)) {
 			ret = -EINTR;
-- 
2.40.1


