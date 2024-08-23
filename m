Return-Path: <linux-kernel+bounces-298190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C37195C3A9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 05:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5A21C21BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 03:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA6F3BBF4;
	Fri, 23 Aug 2024 03:21:00 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AE52B9C7
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724383259; cv=none; b=ezyt0yvcfUcFP8SL3BsEN7cuNzpWygcJPu1/vq3CmY7jTZO1K+GtBw3VruSkWFmSR4ruktXX1c5dkgkpybfS4NwxI63EAouxw2WKhMKbnNvNA4ZYvctfEX9w8+RTxY1jn0Y2KPv3rVzlwJi2OGjg0mEfQ/VC5O9Dq1YSdmSecS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724383259; c=relaxed/simple;
	bh=nKK0ZvEpoDzcu6+4vPnSk9ACS0+59PIcgHoRJKyLozo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCVqMzfjYRAHduEadaKKRvl3vGFPspSN0k1LI2nbmcMbAJ4pw54IYRa6/9zrFc15K/+fwvW11tZDgE+dWEXo26LnBCR/4i8GozeFt3k9ZtggYuDnfvIPI7UQqQTVOvY/aeHvgKGZ6HHuaGb8mZ5cplW5OvIyEyuUlel6MfPUl48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WqlZz0tQYzQp7G;
	Fri, 23 Aug 2024 11:16:11 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 11DE4180106;
	Fri, 23 Aug 2024 11:20:55 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 11:20:54 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <xuwei5@hisilicon.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>,
	<Jonathan.Cameron@Huawei.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2 3/6] soc: hisilicon: kunpeng_hccs: Add the check for base address and size of shared memory
Date: Fri, 23 Aug 2024 11:10:56 +0800
Message-ID: <20240823031059.32579-4-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20240823031059.32579-1-lihuisong@huawei.com>
References: <20240718071134.31155-1-lihuisong@huawei.com>
 <20240823031059.32579-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600004.china.huawei.com (7.193.23.242)

If the shmem_base_addr from PCCT is zero, hccs_register_pcc_channel will
return success. And then driver will access to illegal address when send
PCC command. In addition, the size of shared memory used for communication
between driver and platform is fixed, namely 64 Bytes which is
unchangeable. So add the verification for them.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/soc/hisilicon/kunpeng_hccs.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index 6e88f597f267..6055e5091cbd 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -170,15 +170,21 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
 		goto err_mbx_channel_free;
 	}
 
-	if (pcc_chan->shmem_base_addr) {
-		cl_info->pcc_comm_addr = ioremap(pcc_chan->shmem_base_addr,
-						 pcc_chan->shmem_size);
-		if (!cl_info->pcc_comm_addr) {
-			dev_err(dev, "Failed to ioremap PCC communication region for channel-%u.\n",
-				hdev->chan_id);
-			rc = -ENOMEM;
-			goto err_mbx_channel_free;
-		}
+	if (!pcc_chan->shmem_base_addr ||
+	    pcc_chan->shmem_size != HCCS_PCC_SHARE_MEM_BYTES) {
+		dev_err(dev, "The base address or size (%llu) of PCC communication region is invalid.\n",
+			pcc_chan->shmem_size);
+		rc = -EINVAL;
+		goto err_mbx_channel_free;
+	}
+
+	cl_info->pcc_comm_addr = ioremap(pcc_chan->shmem_base_addr,
+					 pcc_chan->shmem_size);
+	if (!cl_info->pcc_comm_addr) {
+		dev_err(dev, "Failed to ioremap PCC communication region for channel-%u.\n",
+			hdev->chan_id);
+		rc = -ENOMEM;
+		goto err_mbx_channel_free;
 	}
 
 	return 0;
-- 
2.22.0


