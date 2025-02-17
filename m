Return-Path: <linux-kernel+bounces-510381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346F2A31BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6D3D1672B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755441D516C;
	Wed, 12 Feb 2025 02:27:25 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB96F1BEF81
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739327245; cv=none; b=nAG/+p1UxPTiHr4WxWBLIl2b/HYJn/3pMl3G1ZxOU2rbim+hArA0z95xEL0kxn80liAZ7HvNOVfeWQ0Y8vTyZnoKkJ1yYxHzB5cVXr1QwFxQ4XvcdwDjayWTTQIACsYUxCwM3XahUM1Ur+AqzPWiXOElCSw1EqjPzWG4pIy+NpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739327245; c=relaxed/simple;
	bh=JuPHjZ0Y7aWs+k2bM/BIpl26UhvRA7ZGyZ2edVyFPcs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QW0JZIJpkuW0QvruvZbcoz2qCLEcza8J3Zv+eUybEMC94cIz3oS+bnKnzigW1jh3M78sVr21ZEkobkeOb9y2qRLkLjwe0X6GGDoUlzO/b5u/w/nMWzp5nzVtsdgWAbTU7n5EJ8Lc/CgmNXncKib13KAXWpywlzGQLiSisGaS9Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Yt2KK1hCVz20qJ4;
	Wed, 12 Feb 2025 10:27:49 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id D32111402D0;
	Wed, 12 Feb 2025 10:27:19 +0800 (CST)
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
Subject: [PATCH 0/3] dma mapping benchmark: add support for dma_map_sg
Date: Wed, 12 Feb 2025 10:27:15 +0800
Message-ID: <20250212022718.1995504-1-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
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

Modify the framework to adapt to more map modes, add benchmark
support for dma_map_sg, and add support sg map mode in ioctl.

The result:
[root@localhost]# ./dma_map_benchmark -m 1 -g 8 -t 8 -s 30 -d 2
dma mapping mode: DMA_MAP_SG_MODE
dma mapping benchmark: threads:8 seconds:30 node:-1 dir:FROM_DEVICE granule/sg_nents: 8
average map latency(us):1.4 standard deviation:0.3
average unmap latency(us):1.3 standard deviation:0.3
[root@localhost]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
dma mapping mode: DMA_MAP_SINGLE_MODE
dma mapping benchmark: threads:8 seconds:30 node:-1 dir:FROM_DEVICE granule/sg_nents: 8
average map latency(us):1.0 standard deviation:0.3
average unmap latency(us):1.3 standard deviation:0.5

---
Qinxin Xia (3):
  dma-mapping: benchmark: modify the framework to adapt to more map
    modes
  dma-mapping: benchmark: add support for dma_map_sg
  dma-mapping benchmark:add support for dma_map_sg

 include/linux/map_benchmark.h                 |   7 +
 kernel/dma/map_benchmark.c                    | 224 ++++++++++++++++--
 .../testing/selftests/dma/dma_map_benchmark.c |  16 +-
 3 files changed, 222 insertions(+), 25 deletions(-)

--
2.33.0


