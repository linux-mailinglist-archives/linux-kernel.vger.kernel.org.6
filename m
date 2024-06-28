Return-Path: <linux-kernel+bounces-233328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE9A91B582
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B90CB21D99
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA611CFAF;
	Fri, 28 Jun 2024 03:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KpCF54BF"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351A92032D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719545724; cv=none; b=YzcR/+1ASFSOY3a5LV4IFA5v2drDxWo7woWNnUoRoDcCcCI8wW90b1BGlVeEGq77eSZ1Vmot01KiWBJ8yL+hBVA/Af8+R/0N/dMCF1AbrAuFKpmpYeCkGxrDozeahlgc6WE2MWZA05dEL/ss+CVMqh3bq2sIYh5xX6r7hTVA7MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719545724; c=relaxed/simple;
	bh=REUx32kKeMtCto0Mt3ND8IG9iuZqZCs/a/m3ZE+QVRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S7jHRcwX4EZceExrnNGGuA6Nsc6laZX5Pcbz6XSIXXEZ7gpd3LqSesCkS4AMzj2vRt//rz1ioB4KOm+9zxgOp651h8IcOgvCSZtjgdqWrWVH5RO6JaJSd3O5YPROfi2lIjsTf4/PCdiM2DbNHI8OAxsqy8k9Hg60DQOLp907Uk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KpCF54BF; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719545714; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=1w+8Hz62/OAiOuIAShxlhOWk3yei/75Rw/aW5MatOU4=;
	b=KpCF54BFZL+JGfyxfFx7RiFfmu+gYKGFxmkgdmN6yit5DXri+t93u48W+PogbfAuYGBOmmcev8x3dMzIic6RVb2knrk9s/g/JeWeFR6tcAdvhYCHOP3UnjLhgMSGp57E8ghJDJDNC3zcTKtiJFPbFvpiPst57/OGYxV5D3bPVM0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W9OqxVW_1719545710;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W9OqxVW_1719545710)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 11:35:13 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	nao.horiguchi@gmail.com,
	linmiaohe@huawei.com,
	tianruidong@alibaba.linux.com,
	xueshuai@linux.alibaba.com,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH] mm/hwpoison: avoid speculation access after soft/hard offline
Date: Fri, 28 Jun 2024 11:35:09 +0800
Message-Id: <20240628033509.27612-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page that offlined can report CE/UE event due to speculation access.
Delete kernel 1:1 linner mapping after soft/hard offline to avoid it.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/base/memory.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 67858eeb92ed..502ee1107ac6 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -22,6 +22,7 @@
 #include <linux/stat.h>
 #include <linux/slab.h>
 #include <linux/xarray.h>
+#include <linux/set_memory.h>
 
 #include <linux/atomic.h>
 #include <linux/uaccess.h>
@@ -600,6 +601,8 @@ static ssize_t soft_offline_page_store(struct device *dev,
 		return -EINVAL;
 	pfn >>= PAGE_SHIFT;
 	ret = soft_offline_page(pfn, 0);
+	if (!ret)
+		set_mce_nospec(pfn);
 	return ret == 0 ? count : ret;
 }
 
@@ -616,6 +619,8 @@ static ssize_t hard_offline_page_store(struct device *dev,
 		return -EINVAL;
 	pfn >>= PAGE_SHIFT;
 	ret = memory_failure(pfn, MF_SW_SIMULATED);
+	if (!ret)
+		set_mce_nospec(pfn);
 	if (ret == -EOPNOTSUPP)
 		ret = 0;
 	return ret ? ret : count;
-- 
2.39.3


