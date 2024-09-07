Return-Path: <linux-kernel+bounces-319628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227B496FFE4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 05:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDBF81F230A2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 03:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12E73BBE3;
	Sat,  7 Sep 2024 03:56:11 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5C0139E;
	Sat,  7 Sep 2024 03:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725681371; cv=none; b=Vvuog8s3fwfcjJP6YcbVGpOugzom7dlj1P6oXy5tKzOcYldMdcCOWiwQz6wunwxiyycy/SnOoQPZQScjNFAJLgZCsq9oyRFH4A5E+LOsXoc5g40Pq1v9M0KrZjBpXSFuG4Rr/ijHiG/hYehSTpTm3jGyerA5L5sRT2Dg3Y3xhSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725681371; c=relaxed/simple;
	bh=bQftjdaMlhA6qFZr+FJArS4m+j3VfgzZxczTorDBJ6g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=smgfSDSRbBSWSz3ta7wN9rpCFbCKhLxR/Pu6LlJMzD1utOuiAJT39Yg8aaErTzCC4nMx8dqMIerg4H5tams+bIlbUIavMjRbrswAFPxShd4G6ONgmXqcRHHYCgIm/5aiXCKQJXOencNF6vFKoNbSX8tSyGXq1N05UFRV5xMp5qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X0zm41q5Gz69Wk;
	Sat,  7 Sep 2024 11:56:04 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (unknown [7.193.23.20])
	by mail.maildlp.com (Postfix) with ESMTPS id B83801400DD;
	Sat,  7 Sep 2024 11:56:05 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemm600016.china.huawei.com
 (7.193.23.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 7 Sep
 2024 11:56:04 +0800
From: Lin Ruifeng <linruifeng4@huawei.com>
To: <b-liu@ti.com>, <gregkh@linuxfoundation.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH -next] usb: musb: mediatek: Simplify code with dev_err_probe()
Date: Sat, 7 Sep 2024 11:42:26 +0800
Message-ID: <20240907034226.120159-1-linruifeng4@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600016.china.huawei.com (7.193.23.20)

The combination of dev_err() and the returned error code could be
replaced by dev_err_probe() in driver's probe function. Let's,
converting to dev_err_probe() to make code more simple.

Signed-off-by: Lin Ruifeng <linruifeng4@huawei.com>
---
 drivers/usb/musb/mediatek.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/musb/mediatek.c b/drivers/usb/musb/mediatek.c
index 0a35aab3ab81..393b909de238 100644
--- a/drivers/usb/musb/mediatek.c
+++ b/drivers/usb/musb/mediatek.c
@@ -416,10 +416,9 @@ static int mtk_musb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = of_platform_populate(np, NULL, NULL, dev);
-	if (ret) {
-		dev_err(dev, "failed to create child devices at %p\n", np);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				"failed to create child devices at %p\n", np);
 
 	ret = mtk_musb_clks_get(glue);
 	if (ret)
@@ -448,23 +447,19 @@ static int mtk_musb_probe(struct platform_device *pdev)
 		glue->role = USB_ROLE_NONE;
 		break;
 	default:
-		dev_err(&pdev->dev, "Error 'dr_mode' property\n");
-		return -EINVAL;
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				"failed to create child devices at %p\n", np);
 	}
 
 	glue->phy = devm_of_phy_get_by_index(dev, np, 0);
-	if (IS_ERR(glue->phy)) {
-		dev_err(dev, "fail to getting phy %ld\n",
-			PTR_ERR(glue->phy));
-		return PTR_ERR(glue->phy);
-	}
+	if (IS_ERR(glue->phy))
+		return dev_err_probe(dev, PTR_ERR(glue->phy),
+				"fail to getting phy\n");
 
 	glue->usb_phy = usb_phy_generic_register();
-	if (IS_ERR(glue->usb_phy)) {
-		dev_err(dev, "fail to registering usb-phy %ld\n",
-			PTR_ERR(glue->usb_phy));
-		return PTR_ERR(glue->usb_phy);
-	}
+	if (IS_ERR(glue->usb_phy))
+		return dev_err_probe(dev, PTR_ERR(glue->usb_phy),
+				"fail to registering usb-phy\n");
 
 	glue->xceiv = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
 	if (IS_ERR(glue->xceiv)) {
-- 
2.17.1


