Return-Path: <linux-kernel+bounces-319697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA1B9700E3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 10:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF30B285729
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 08:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A6814C59C;
	Sat,  7 Sep 2024 08:27:38 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FAD1B85DC;
	Sat,  7 Sep 2024 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697657; cv=none; b=L0c6iKtiqSb6j9z9eYUn9Pkl+8zSlsAmGGBH95RnehFcGnbe9f4YyQZr56CGQufcc0QWKqt+rJi+CxjHRTwJyJLVeV3x2WhCC70flpiFk8jHqKEDzyYwH7dEvi9eZOv60UZS8s656zV4GKCQWLOUHirvOPG5SlDK2BO7DCOphtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697657; c=relaxed/simple;
	bh=dIv+OdKCrxghhMjsgV2OpaXd/FEP/Yx0K83Aj/eLBJk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZhmI+BqqORqq35pq9c8RhgZ34rd9GTMx3/BmCN9+mCUE5POpgaYW6ZocUkuwNEvJu7WweFsHPe9u0sq2KsbvAcnXK+ufnyg2Dj40OVg1hbXqD8RR1utQcILXoVh7yK5DpSgidEpnXAdN4abbOg4ds6TF5cFsfYAI6keQDVpPv/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X15mV1CKCzyRYD;
	Sat,  7 Sep 2024 16:26:50 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (unknown [7.193.23.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 63BD61800F2;
	Sat,  7 Sep 2024 16:27:31 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemm600016.china.huawei.com
 (7.193.23.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 7 Sep
 2024 16:27:30 +0800
From: Lin Ruifeng <linruifeng4@huawei.com>
To: <b-liu@ti.com>, <gregkh@linuxfoundation.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH -next v2] usb: musb: mediatek: Simplify code with dev_err_probe()
Date: Sat, 7 Sep 2024 16:13:51 +0800
Message-ID: <20240907081351.19879-1-linruifeng4@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600016.china.huawei.com (7.193.23.20)

The combination of dev_err() and the returned error code could be
replaced by dev_err_probe() in driver's probe function. Let's,
converting to dev_err_probe() to make code more simple.

Signed-off-by: Lin Ruifeng <linruifeng4@huawei.com>
---
v2:
- The wrong message is modified.
 drivers/usb/musb/mediatek.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/musb/mediatek.c b/drivers/usb/musb/mediatek.c
index 0a35aab3ab81..63c86c046b98 100644
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
+				"Error 'dr_mode' property\n");
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


