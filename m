Return-Path: <linux-kernel+bounces-510380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B83A31BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E62A17A3BB8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6E81D5146;
	Wed, 12 Feb 2025 02:27:25 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BABC1C5490
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739327244; cv=none; b=JIXemmHB+CCUePcV8365Ir2Y4umwvLtLanYY/Nn2tTn0Z/19yczg8toegut7GdgTpkYNREqP1+vDlhssxidjLVAogCQbRU9fGVj95jy8Sh0rSRMxZTVbKA8o7fRVLAj8LigozFbP4qhC33fNyaSEw+Ve8L+70rkzGpSEx6ltkU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739327244; c=relaxed/simple;
	bh=yXGqKcJon/u8mbx1iNo+l7Z19hSzslXlgUOdkIET56U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zqtzz712kXLklCpIhkWV13jz9XOGhJWHwWkGj6G9UneMTqwlu4AGL22V4cvEwHXJrupT617baU+0cmmBNXUlsYDteusFS6A/2o23pBePI5eluTOfoIOtkHUxffQVoAbUmwZSbmIsKD67W4dgS2v4b1D98fkH9j9mpSabGsIjedg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Yt2DQ5XNvz1V6b9;
	Wed, 12 Feb 2025 10:23:34 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id C02C41A016C;
	Wed, 12 Feb 2025 10:27:20 +0800 (CST)
Received: from localhost.huawei.com (10.90.30.45) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Feb 2025 10:27:20 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <baohua@kernel.org>, <chenxiang66@hisilicon.com>
CC: <yangyicong@huawei.com>, <hch@lst.de>, <iommu@lists.linux.dev>,
	<jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
	<fanghao11@huawei.com>, <linux-kernel@vger.kernel.org>,
	<xiaqinxin@huawei.com>
Subject: [PATCH 2/3]  dma-mapping: benchmark: add support for dma_map_sg
Date: Wed, 12 Feb 2025 10:27:17 +0800
Message-ID: <20250212022718.1995504-3-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250212022718.1995504-1-xiaqinxin@huawei.com>
References: <20250212022718.1995504-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemj200003.china.huawei.com (7.202.194.15)

Support for dma scatter-gather mapping and is intended for testing
mapping performance. It achieves by introducing the dma_sg_map_param
structure and related functions, which enable the implementation of
scatter-gather mapping preparation, mapping, and unmapping operations.
Additionally, the dma_map_benchmark_ops array is updated to include
operations for scatter-gather mapping. This commit aims to provide
a wider range of mapping performance test  to cater to different scenarios.

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 include/linux/map_benchmark.h |   1 +
 kernel/dma/map_benchmark.c    | 102 ++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.h
index 054db02a03a7..a9c1a104ba4f 100644
--- a/include/linux/map_benchmark.h
+++ b/include/linux/map_benchmark.h
@@ -17,6 +17,7 @@
 
 enum {
 	DMA_MAP_SINGLE_MODE,
+	DMA_MAP_SG_MODE,
 	DMA_MAP_MODE_MAX
 };
 
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index d8ec0ce058d8..b5828eeb3db7 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/timekeeping.h>
 
@@ -111,8 +112,109 @@ static struct map_benchmark_ops dma_single_map_benchmark_ops = {
 	.do_unmap = dma_single_map_benchmark_do_unmap,
 };
 
+struct dma_sg_map_param {
+	struct sg_table sgt;
+	struct device *dev;
+	void **buf;
+	u32 npages;
+	u32 dma_dir;
+};
+
+static void *dma_sg_map_benchmark_prepare(struct map_benchmark_data *map)
+{
+	struct scatterlist *sg;
+	int i = 0;
+
+	struct dma_sg_map_param *mparam __free(kfree) = kzalloc(sizeof(*mparam), GFP_KERNEL);
+	if (!mparam)
+		return NULL;
+
+	mparam->npages = map->bparam.granule;
+	mparam->dma_dir = map->bparam.dma_dir;
+	mparam->dev = map->dev;
+	mparam->buf = kmalloc_array(mparam->npages, sizeof(*mparam->buf),
+				    GFP_KERNEL);
+	if (!mparam->buf)
+		goto err1;
+
+	if (sg_alloc_table(&mparam->sgt, mparam->npages, GFP_KERNEL))
+		goto err2;
+
+	for_each_sgtable_sg(&mparam->sgt, sg, i) {
+		mparam->buf[i] = (void *)__get_free_page(GFP_KERNEL);
+		if (!mparam->buf[i])
+			goto err3;
+
+		if (mparam->dma_dir != DMA_FROM_DEVICE)
+			memset(mparam->buf[i], 0x66, PAGE_SIZE);
+
+		sg_set_buf(sg, mparam->buf[i], PAGE_SIZE);
+	}
+
+	return_ptr(mparam);
+
+err3:
+	while (i-- > 0)
+		free_page((unsigned long)mparam->buf[i]);
+
+	pr_err("dma_map_sg failed get free page on %s\n", dev_name(mparam->dev));
+	sg_free_table(&mparam->sgt);
+err2:
+	pr_err("dma_map_sg failed alloc sg table on %s\n", dev_name(mparam->dev));
+	kfree(mparam->buf);
+err1:
+	pr_err("dma_map_sg failed alloc mparam buf on %s\n", dev_name(mparam->dev));
+	return NULL;
+}
+
+static void dma_sg_map_benchmark_unprepare(void *arg)
+{
+	struct dma_sg_map_param *mparam = arg;
+	int i;
+
+	for (i = 0; i < mparam->npages; i++)
+		free_page((unsigned long)mparam->buf[i]);
+
+	sg_free_table(&mparam->sgt);
+
+	kfree(mparam->buf);
+	kfree(mparam);
+}
+
+static int dma_sg_map_benchmark_do_map(void *arg)
+{
+	struct dma_sg_map_param *mparam = arg;
+
+	int sg_mapped = dma_map_sg(mparam->dev, mparam->sgt.sgl,
+				   mparam->npages, mparam->dma_dir);
+	if (!sg_mapped) {
+		pr_err("dma_map_sg failed on %s\n", dev_name(mparam->dev));
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int dma_sg_map_benchmark_do_unmap(void *arg)
+{
+	struct dma_sg_map_param *mparam = arg;
+
+	dma_unmap_sg(mparam->dev, mparam->sgt.sgl, mparam->npages,
+		     mparam->dma_dir);
+
+	return 0;
+}
+
+static struct map_benchmark_ops dma_sg_map_benchmark_ops = {
+	.prepare = dma_sg_map_benchmark_prepare,
+	.unprepare = dma_sg_map_benchmark_unprepare,
+	.do_map = dma_sg_map_benchmark_do_map,
+	.do_unmap = dma_sg_map_benchmark_do_unmap,
+};
+
 static struct map_benchmark_ops *dma_map_benchmark_ops[DMA_MAP_MODE_MAX] = {
 	[DMA_MAP_SINGLE_MODE] = &dma_single_map_benchmark_ops,
+	[DMA_MAP_SG_MODE] = &dma_sg_map_benchmark_ops,
 };
 
 static int map_benchmark_thread(void *data)
-- 
2.33.0


