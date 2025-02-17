Return-Path: <linux-kernel+bounces-510382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DCBA31BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D5E188A535
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BD01D63F0;
	Wed, 12 Feb 2025 02:27:26 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C64178F4E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739327245; cv=none; b=SOjh3bYem6/hY8NARby4+WGTLjVgkPpCKpeAPbc69bwDyb5KnqCXQK3WZ1i53/IdiA+5kW6K8GsZ90Yn4f5DozmED783hkAGerWH4tvIV479vQPqqXBRAwbWmxRS07FuIyetfvcmlGcUKwU0KK+Xc0Tz6P9o/OYRVNzuewuBCSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739327245; c=relaxed/simple;
	bh=MdRCEg6Fuemfg5Akb+vfO7hrp+M2Te7SlW01VaqvV0o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqyrbAcj14lzqWad6o5+n3WTi4xbpm5DRjDZzQbJJtC9BXMWwmfWV093kVx1hPv+ylAnLO4cSWALhk4ja7mNfCp8/cU12c6/xWnq5AYPfcayDPnAK/opvqFpk9CUFnmUtV/Bs1sIlqSPHVmfkvADfeEZdnSC5tXiXb52Jb/Er9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Yt2DR0dPhz1ltZq;
	Wed, 12 Feb 2025 10:23:35 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 52BF5140383;
	Wed, 12 Feb 2025 10:27:20 +0800 (CST)
Received: from localhost.huawei.com (10.90.30.45) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Feb 2025 10:27:19 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <baohua@kernel.org>, <chenxiang66@hisilicon.com>
CC: <yangyicong@huawei.com>, <hch@lst.de>, <iommu@lists.linux.dev>,
	<jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
	<fanghao11@huawei.com>, <linux-kernel@vger.kernel.org>,
	<xiaqinxin@huawei.com>
Subject: [PATCH 1/3] dma mapping benchmark: modify the framework to adapt to more map modes
Date: Wed, 12 Feb 2025 10:27:16 +0800
Message-ID: <20250212022718.1995504-2-xiaqinxin@huawei.com>
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

In this patch map_benchmark abstract in four interface: prepare, unprepare,
do_map, do_unmap. When there's a new mode to add, need four steps:
1) Add the mode in map_benchmark.h

2) Defines the mode param, like struct dma_xxx_map_param, and this object
   will be return in prepare and as input parameter in other ops;

3) Defines the ops functions:prepare, unprepare, do_map, do_unmap.

4) Add the new mode in dma_map_benchmark_ops.

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 include/linux/map_benchmark.h |   6 ++
 kernel/dma/map_benchmark.c    | 122 +++++++++++++++++++++++++++-------
 2 files changed, 105 insertions(+), 23 deletions(-)

diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.h
index 62674c83bde4..054db02a03a7 100644
--- a/include/linux/map_benchmark.h
+++ b/include/linux/map_benchmark.h
@@ -15,6 +15,11 @@
 #define DMA_MAP_TO_DEVICE       1
 #define DMA_MAP_FROM_DEVICE     2
 
+enum {
+	DMA_MAP_SINGLE_MODE,
+	DMA_MAP_MODE_MAX
+};
+
 struct map_benchmark {
 	__u64 avg_map_100ns; /* average map latency in 100ns */
 	__u64 map_stddev; /* standard deviation of map latency */
@@ -27,5 +32,6 @@ struct map_benchmark {
 	__u32 dma_dir; /* DMA data direction */
 	__u32 dma_trans_ns; /* time for DMA transmission in ns */
 	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
+	__u8  map_mode; /* the mode of dma map */
 };
 #endif /* _KERNEL_DMA_BENCHMARK_H */
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index cc19a3efea89..d8ec0ce058d8 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -5,6 +5,7 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -31,17 +32,98 @@ struct map_benchmark_data {
 	atomic64_t loops;
 };
 
+struct map_benchmark_ops {
+	void *(*prepare)(struct map_benchmark_data *map);
+	void (*unprepare)(void *arg);
+	int (*do_map)(void *arg);
+	int (*do_unmap)(void *arg);
+};
+
+struct dma_single_map_param {
+	struct device *dev;
+	dma_addr_t addr;
+	void *xbuf;
+	u32 npages;
+	u32 dma_dir;
+};
+
+static void *dma_single_map_benchmark_prepare(struct map_benchmark_data *map)
+{
+	struct dma_single_map_param *mparam __free(kfree) = kzalloc(sizeof(*mparam),
+								    GFP_KERNEL);
+	if (!mparam)
+		return NULL;
+
+	mparam->npages = map->bparam.granule;
+	mparam->dma_dir = map->bparam.dma_dir;
+	mparam->dev = map->dev;
+	mparam->xbuf = alloc_pages_exact(mparam->npages * PAGE_SIZE, GFP_KERNEL);
+	if (!mparam->xbuf)
+		return NULL;
+
+	/*
+	 * for a non-coherent device, if we don't stain them in the
+	 * cache, this will give an underestimate of the real-world
+	 * overhead of BIDIRECTIONAL or TO_DEVICE mappings;
+	 * 66 means evertything goes well! 66 is lucky.
+	 */
+	if (mparam->dma_dir != DMA_FROM_DEVICE)
+		memset(mparam->xbuf, 0x66, mparam->npages * PAGE_SIZE);
+
+	return_ptr(mparam);
+}
+
+static void dma_single_map_benchmark_unprepare(void *arg)
+{
+	struct dma_single_map_param *mparam = arg;
+
+	free_pages_exact(mparam->xbuf, mparam->npages * PAGE_SIZE);
+	kfree(mparam);
+}
+
+static int dma_single_map_benchmark_do_map(void *arg)
+{
+	struct dma_single_map_param *mparam = arg;
+
+	mparam->addr = dma_map_single(mparam->dev, mparam->xbuf,
+				      mparam->npages * PAGE_SIZE, mparam->dma_dir);
+	if (unlikely(dma_mapping_error(mparam->dev, mparam->addr))) {
+		pr_err("dma_map_single failed on %s\n", dev_name(mparam->dev));
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int dma_single_map_benchmark_do_unmap(void *arg)
+{
+	struct dma_single_map_param *mparam = arg;
+
+	dma_unmap_single(mparam->dev, mparam->addr,
+			 mparam->npages * PAGE_SIZE, mparam->dma_dir);
+	return 0;
+}
+
+static struct map_benchmark_ops dma_single_map_benchmark_ops = {
+	.prepare = dma_single_map_benchmark_prepare,
+	.unprepare = dma_single_map_benchmark_unprepare,
+	.do_map = dma_single_map_benchmark_do_map,
+	.do_unmap = dma_single_map_benchmark_do_unmap,
+};
+
+static struct map_benchmark_ops *dma_map_benchmark_ops[DMA_MAP_MODE_MAX] = {
+	[DMA_MAP_SINGLE_MODE] = &dma_single_map_benchmark_ops,
+};
+
 static int map_benchmark_thread(void *data)
 {
-	void *buf;
-	dma_addr_t dma_addr;
 	struct map_benchmark_data *map = data;
-	int npages = map->bparam.granule;
-	u64 size = npages * PAGE_SIZE;
+	__u8 map_mode = map->bparam.map_mode;
 	int ret = 0;
 
-	buf = alloc_pages_exact(size, GFP_KERNEL);
-	if (!buf)
+	void *arg = dma_map_benchmark_ops[map_mode]->prepare(map);
+
+	if (!arg)
 		return -ENOMEM;
 
 	while (!kthread_should_stop())  {
@@ -49,23 +131,10 @@ static int map_benchmark_thread(void *data)
 		ktime_t map_stime, map_etime, unmap_stime, unmap_etime;
 		ktime_t map_delta, unmap_delta;
 
-		/*
-		 * for a non-coherent device, if we don't stain them in the
-		 * cache, this will give an underestimate of the real-world
-		 * overhead of BIDIRECTIONAL or TO_DEVICE mappings;
-		 * 66 means evertything goes well! 66 is lucky.
-		 */
-		if (map->dir != DMA_FROM_DEVICE)
-			memset(buf, 0x66, size);
-
 		map_stime = ktime_get();
-		dma_addr = dma_map_single(map->dev, buf, size, map->dir);
-		if (unlikely(dma_mapping_error(map->dev, dma_addr))) {
-			pr_err("dma_map_single failed on %s\n",
-				dev_name(map->dev));
-			ret = -ENOMEM;
+		ret = dma_map_benchmark_ops[map_mode]->do_map(arg);
+		if (ret)
 			goto out;
-		}
 		map_etime = ktime_get();
 		map_delta = ktime_sub(map_etime, map_stime);
 
@@ -73,7 +142,9 @@ static int map_benchmark_thread(void *data)
 		ndelay(map->bparam.dma_trans_ns);
 
 		unmap_stime = ktime_get();
-		dma_unmap_single(map->dev, dma_addr, size, map->dir);
+		ret = dma_map_benchmark_ops[map_mode]->do_unmap(arg);
+		if (ret)
+			goto out;
 		unmap_etime = ktime_get();
 		unmap_delta = ktime_sub(unmap_etime, unmap_stime);
 
@@ -108,7 +179,7 @@ static int map_benchmark_thread(void *data)
 	}
 
 out:
-	free_pages_exact(buf, size);
+	dma_map_benchmark_ops[map_mode]->unprepare(arg);
 	return ret;
 }
 
@@ -209,6 +280,11 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
 
 	switch (cmd) {
 	case DMA_MAP_BENCHMARK:
+		if (map->bparam.map_mode >= DMA_MAP_MODE_MAX) {
+			pr_err("invalid map mode\n");
+			return -EINVAL;
+		}
+
 		if (map->bparam.threads == 0 ||
 		    map->bparam.threads > DMA_MAP_MAX_THREADS) {
 			pr_err("invalid thread number\n");
-- 
2.33.0


