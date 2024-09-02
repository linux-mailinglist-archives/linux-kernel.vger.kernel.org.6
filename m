Return-Path: <linux-kernel+bounces-310488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC21967DA9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12F51F21568
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 02:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C57282F7;
	Mon,  2 Sep 2024 02:04:25 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176AE125DB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 02:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725242664; cv=none; b=sxINRSVaTWqhB7fP30yQotA93MZgGFKXojCXnUPlVpK59HYibo8e6C/KYcZ/G/JJKfOHfro0BS/CtMkFuk4ARX3bODrt9hHsB4vTJwBGqzE094QpX9hqHc6+VuXgdNbVBmdQnW8Cbm+81VBdFuccQYHlzfnr82OvmEQA4GbU18o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725242664; c=relaxed/simple;
	bh=s1ZIY+hS+r6qSZJ1Wv1w9Y6bAoihDAKfl9VAz8z6DEc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O4oKgL55lmqPOUmvzNS3vNWBbsJwEMBZaOAPEDOAkAPo5rvHDAEZL+5d31JFeMoo5wN3y1RqqgcXTi4sqnrnbsX4bIm81Xkz5zoskBZYI2o8VNtBxqJKUQPqR0DCpoGLF+u3NLOqdfMX4VvN1damGdnuYpR8CSqzV/wUK2REqJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WxsPn16h1z69P9;
	Mon,  2 Sep 2024 09:59:25 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 1130718010A;
	Mon,  2 Sep 2024 10:04:20 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Sep
 2024 10:04:19 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <vincent.sunplus@gmail.com>, <srinivas.kandagatla@linaro.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] nvmem: sunplus-ocotp: Use devm_platform_ioremap_resource_byname() helper function
Date: Mon, 2 Sep 2024 09:50:51 +0800
Message-ID: <20240902015051.85093-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf500003.china.huawei.com (7.202.181.241)

platform_get_resource_byname() and devm_ioremap_resource() can be
replaced by devm_platform_ioremap_resource_byname(), which can
simplify the code logic a bit, No functional change here.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/nvmem/sunplus-ocotp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/sunplus-ocotp.c b/drivers/nvmem/sunplus-ocotp.c
index 38f5d9df39cd..30d55b111a64 100644
--- a/drivers/nvmem/sunplus-ocotp.c
+++ b/drivers/nvmem/sunplus-ocotp.c
@@ -159,7 +159,6 @@ static int sp_ocotp_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct nvmem_device *nvmem;
 	struct sp_ocotp_priv *otp;
-	struct resource *res;
 	int ret;
 
 	otp = devm_kzalloc(dev, sizeof(*otp), GFP_KERNEL);
@@ -168,13 +167,11 @@ static int sp_ocotp_probe(struct platform_device *pdev)
 
 	otp->dev = dev;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hb_gpio");
-	otp->base[HB_GPIO] = devm_ioremap_resource(dev, res);
+	otp->base[HB_GPIO] = devm_platform_ioremap_resource_byname(pdev, "hb_gpio");
 	if (IS_ERR(otp->base[HB_GPIO]))
 		return PTR_ERR(otp->base[HB_GPIO]);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otprx");
-	otp->base[OTPRX] = devm_ioremap_resource(dev, res);
+	otp->base[OTPRX] = devm_platform_ioremap_resource_byname(pdev, "otprx");
 	if (IS_ERR(otp->base[OTPRX]))
 		return PTR_ERR(otp->base[OTPRX]);
 
-- 
2.17.1


