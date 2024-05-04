Return-Path: <linux-kernel+bounces-168620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C39048BBAE9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 13:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52653282441
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 11:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F1622611;
	Sat,  4 May 2024 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="UM7bt6y7"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BB41CA92
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714823317; cv=none; b=fXRs+2Sp/XmjMl+zhRzehFydUyclKyD0AMkYGniZiUZtIUc1FvGewxPKfrQlr65CEio0uxXBwWNunrj7ewbp38kEZPqT+ezrA2HS47aeFvIxJ5jPSlx5u9X5PvfWAUmOhLzZuai0zD7GhbXVPcBvyilTF/K3nh9yQ5pKQLpDNaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714823317; c=relaxed/simple;
	bh=ay0zDLWkAM5SYW7rwZ+Fv5dRHspwnhKlbbetXkIoI2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcyrL7APdMIMcGjpC3Hkv1XDFyetX1M0TVe5kjiSSGw1ZLA9lgFmy36nj9WGTEPhV6CZ5LCBNmEFkXI6Dpqq95dtLNrzFa6glTWoO53iNFgKKsUdW/LKGWXxlYz7hFym2kWonEQgkhIBZY+AkoysxK1bqnGf1aEV9tyKrPBtzEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=UM7bt6y7; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.localdomain (unknown [5.228.116.47])
	by mail.ispras.ru (Postfix) with ESMTPSA id 2F1264078517;
	Sat,  4 May 2024 11:48:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2F1264078517
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1714823312;
	bh=/uIIVEFe8eesxRelQeBiidx05umI8tLYckMVbIe9Bf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UM7bt6y7JQ8GsazyiVpAh4KGpiuvHBD24Oj+UHlqDMdGpPfA0VJh9xyH/a7Ic71Pm
	 mNicUdCmKQryFDFuHgrd2aEQTx3zU58NcVqdsgHqFYVafGrAz5Z1sUi/JqxWhHZEmq
	 pGfySbh+QsCIk295vp5i3Q46f1r1gaLgWy/pPvCI=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Xiang Chen <chenxiang66@hisilicon.com>,
	Barry Song <21cnbao@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH v2 1/4] dma-mapping: benchmark: fix up kthread-related error handling
Date: Sat,  4 May 2024 14:47:01 +0300
Message-ID: <20240504114713.567164-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240504114713.567164-1-pchelkin@ispras.ru>
References: <20240504114713.567164-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kthread creation failure is invalidly handled inside do_map_benchmark().
The put_task_struct() calls on the error path are supposed to balance the
get_task_struct() calls which only happen after all the kthreads are
successfully created. Rollback using kthread_stop() for already created
kthreads in case of such failure.

In normal situation call kthread_stop_put() to gracefully stop kthreads
and put their task refcounts. This should be done for all started
kthreads.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 65789daa8087 ("dma-mapping: add benchmark support for streaming DMA APIs")
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 kernel/dma/map_benchmark.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 02205ab53b7e..2478957cf9f8 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -118,6 +118,8 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 		if (IS_ERR(tsk[i])) {
 			pr_err("create dma_map thread failed\n");
 			ret = PTR_ERR(tsk[i]);
+			while (--i >= 0)
+				kthread_stop(tsk[i]);
 			goto out;
 		}
 
@@ -139,13 +141,17 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 
 	msleep_interruptible(map->bparam.seconds * 1000);
 
-	/* wait for the completion of benchmark threads */
+	/* wait for the completion of all started benchmark threads */
 	for (i = 0; i < threads; i++) {
-		ret = kthread_stop(tsk[i]);
-		if (ret)
-			goto out;
+		int kthread_ret = kthread_stop_put(tsk[i]);
+
+		if (kthread_ret)
+			ret = kthread_ret;
 	}
 
+	if (ret)
+		goto out;
+
 	loops = atomic64_read(&map->loops);
 	if (likely(loops > 0)) {
 		u64 map_variance, unmap_variance;
@@ -170,8 +176,6 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 	}
 
 out:
-	for (i = 0; i < threads; i++)
-		put_task_struct(tsk[i]);
 	put_device(map->dev);
 	kfree(tsk);
 	return ret;
-- 
2.45.0


