Return-Path: <linux-kernel+bounces-309803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4890A967095
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 11:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18931F22BEB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 09:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2E217B515;
	Sat, 31 Aug 2024 09:50:16 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A3A155307;
	Sat, 31 Aug 2024 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725097816; cv=none; b=Y65yQMSDL/7jnpYKxIX9lyzlbWIfCcoE5EZMqEE9ymXKasv9B0RZKVFhdubkYA8gtlH/k2c9WkSIICtTd/0zTmQqplnk18wtZKzSabWZgy0vX91tbxrLR3oZcUlTfCVRX4GSbn4N8XcawhM1g6dav5grvoONNdmLSR1rTJavcXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725097816; c=relaxed/simple;
	bh=bJBWeK8lCimIQP+R9b6ITvG2CKaxaK8zk+Nm8rc3yHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tT0q6zR/OLKMOVexCYwgLUS9lePx7BD6PQ05jbjHcwUJXZGBm30xqxTOgn+GIVyo1iKz/6jXKSmunef/OKiRQAak93UNbm6YDY7tqax6BMmQaBjbrrjGpqNwtQGnAiHfYjFeIjJeCl5DX7EeXaxqEoEz3g7zXvy2Nhd09sLCU8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wwqxc4GHhz1j7vy;
	Sat, 31 Aug 2024 17:49:56 +0800 (CST)
Received: from kwepemd200024.china.huawei.com (unknown [7.221.188.85])
	by mail.maildlp.com (Postfix) with ESMTPS id 872B4180043;
	Sat, 31 Aug 2024 17:50:11 +0800 (CST)
Received: from localhost.huawei.com (10.90.30.45) by
 kwepemd200024.china.huawei.com (7.221.188.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 31 Aug 2024 17:50:10 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<fanghao11@huawei.com>, <liulongfang@huawei.com>, <shenyang39@huawei.com>,
	<songzhiqi1@huawei.com>, <qianweili@huawei.com>, <linwenkai6@hisilicon.com>,
	<taoqi10@huawei.com>, <wangzhou1@hisilicon.com>, <huangchenghai2@huawei.com>
Subject: [PATCH v2 1/3] crypto: hisilicon - fix missed error branch
Date: Sat, 31 Aug 2024 17:50:07 +0800
Message-ID: <20240831095009.446780-2-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240831095009.446780-1-huangchenghai2@huawei.com>
References: <20240831095009.446780-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200024.china.huawei.com (7.221.188.85)

From: Yang Shen <shenyang39@huawei.com>

If an error occurs in the process after the SGL is mapped
successfully, it need to unmap the SGL.

Otherwise, memory problems may occur.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 drivers/crypto/hisilicon/sgl.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
index 568acd0aee3f..c974f95cd126 100644
--- a/drivers/crypto/hisilicon/sgl.c
+++ b/drivers/crypto/hisilicon/sgl.c
@@ -225,7 +225,7 @@ hisi_acc_sg_buf_map_to_hw_sgl(struct device *dev,
 	dma_addr_t curr_sgl_dma = 0;
 	struct acc_hw_sge *curr_hw_sge;
 	struct scatterlist *sg;
-	int sg_n;
+	int sg_n, ret;
 
 	if (!dev || !sgl || !pool || !hw_sgl_dma || index >= pool->count)
 		return ERR_PTR(-EINVAL);
@@ -240,14 +240,15 @@ hisi_acc_sg_buf_map_to_hw_sgl(struct device *dev,
 
 	if (sg_n_mapped > pool->sge_nr) {
 		dev_err(dev, "the number of entries in input scatterlist is bigger than SGL pool setting.\n");
-		return ERR_PTR(-EINVAL);
+		ret = -EINVAL;
+		goto err_unmap;
 	}
 
 	curr_hw_sgl = acc_get_sgl(pool, index, &curr_sgl_dma);
 	if (IS_ERR(curr_hw_sgl)) {
 		dev_err(dev, "Get SGL error!\n");
-		dma_unmap_sg(dev, sgl, sg_n, DMA_BIDIRECTIONAL);
-		return ERR_PTR(-ENOMEM);
+		ret = -ENOMEM;
+		goto err_unmap;
 	}
 	curr_hw_sgl->entry_length_in_sgl = cpu_to_le16(pool->sge_nr);
 	curr_hw_sge = curr_hw_sgl->sge_entries;
@@ -262,6 +263,11 @@ hisi_acc_sg_buf_map_to_hw_sgl(struct device *dev,
 	*hw_sgl_dma = curr_sgl_dma;
 
 	return curr_hw_sgl;
+
+err_unmap:
+	dma_unmap_sg(dev, sgl, sg_n, DMA_BIDIRECTIONAL);
+
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(hisi_acc_sg_buf_map_to_hw_sgl);
 
-- 
2.33.0


