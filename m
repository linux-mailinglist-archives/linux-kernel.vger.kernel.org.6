Return-Path: <linux-kernel+bounces-312915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E4D969DA6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44F33B238B8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174031D0965;
	Tue,  3 Sep 2024 12:32:12 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EE41D0959;
	Tue,  3 Sep 2024 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366731; cv=none; b=MlYf7g228Arn1cUvjJKVcHiKK/eqP1q4SToeqwsjkGEPUyORGVG8BuCNhI8g8cEx/UGhlRK5gmCYG0M0SMZd8CD3MrKfrYJoWwNOxFYqUe6bEDVpEa3qDGD8t9FV/6cVKZUTctyEG2EbrE2IkEr4Yl8cUfIIhtn1cTd4Q8/gnhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366731; c=relaxed/simple;
	bh=wt0MsrlPeQPhAtDdj7Q1A5xQ3NmHHrGzu1igSPDkRqY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GtZTAfxFNxiakwol+72EvrNFvUzzlOJpk6Zz7Hpk0pdvAXd2jTiiQUs9rdnqEpNr0Tiy0lKyYoKo/6ljwQI3aNxzakDA4VPADUEA92GgFxVfq4sstna4u/gfnPWd4/i/hEzG4IEP0ZFvk93BtZ9xwibfCimEi/yDYeuO+qGc7As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee366d701c2796-abfa5;
	Tue, 03 Sep 2024 20:32:04 +0800 (CST)
X-RM-TRANSID:2ee366d701c2796-abfa5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea66d701c1cbf-e51bd;
	Tue, 03 Sep 2024 20:32:04 +0800 (CST)
X-RM-TRANSID:2eea66d701c1cbf-e51bd
From: tangbin <tangbin@cmss.chinamobile.com>
To: neal_liu@aspeedtech.com,
	gregkh@linuxfoundation.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: linux-aspeed@lists.ozlabs.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	tangbin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] usb: gadget: aspeed_udc: use the defined variable to simplify code
Date: Tue,  3 Sep 2024 20:31:52 +0800
Message-Id: <20240903123152.6980-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the defined variable 'dev' to make the code cleaner.

Signed-off-by: tangbin <tangbin@cmss.chinamobile.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index f4781e611..702d4806c 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -1479,7 +1479,7 @@ static int ast_udc_probe(struct platform_device *pdev)
 	struct ast_udc_dev *udc;
 	int rc;
 
-	udc = devm_kzalloc(&pdev->dev, sizeof(struct ast_udc_dev), GFP_KERNEL);
+	udc = devm_kzalloc(dev, sizeof(struct ast_udc_dev), GFP_KERNEL);
 	if (!udc)
 		return -ENOMEM;
 
@@ -1494,32 +1494,32 @@ static int ast_udc_probe(struct platform_device *pdev)
 
 	udc->reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(udc->reg)) {
-		dev_err(&pdev->dev, "Failed to map resources\n");
+		dev_err(dev, "Failed to map resources\n");
 		return PTR_ERR(udc->reg);
 	}
 
 	platform_set_drvdata(pdev, udc);
 
-	udc->clk = devm_clk_get(&pdev->dev, NULL);
+	udc->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(udc->clk)) {
 		rc = PTR_ERR(udc->clk);
 		goto err;
 	}
 	rc = clk_prepare_enable(udc->clk);
 	if (rc) {
-		dev_err(&pdev->dev, "Failed to enable clock (0x%x)\n", rc);
+		dev_err(dev, "Failed to enable clock (0x%x)\n", rc);
 		goto err;
 	}
 
 	/* Check if we need to limit the HW to USB1 */
-	max_speed = usb_get_maximum_speed(&pdev->dev);
+	max_speed = usb_get_maximum_speed(dev);
 	if (max_speed != USB_SPEED_UNKNOWN && max_speed < USB_SPEED_HIGH)
 		udc->force_usb1 = true;
 
 	/*
 	 * Allocate DMA buffers for all EPs in one chunk
 	 */
-	udc->ep0_buf = dma_alloc_coherent(&pdev->dev,
+	udc->ep0_buf = dma_alloc_coherent(dev,
 					  AST_UDC_EP_DMA_SIZE *
 					  AST_UDC_NUM_ENDPOINTS,
 					  &udc->ep0_buf_dma, GFP_KERNEL);
@@ -1534,7 +1534,7 @@ static int ast_udc_probe(struct platform_device *pdev)
 	 */
 	udc->desc_mode = AST_UDC_DESC_MODE;
 
-	dev_info(&pdev->dev, "DMA %s\n", udc->desc_mode ?
+	dev_info(dev, "DMA %s\n", udc->desc_mode ?
 		 "descriptor mode" : "single mode");
 
 	INIT_LIST_HEAD(&udc->gadget.ep_list);
@@ -1556,26 +1556,26 @@ static int ast_udc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	rc = devm_request_irq(&pdev->dev, udc->irq, ast_udc_isr, 0,
+	rc = devm_request_irq(dev, udc->irq, ast_udc_isr, 0,
 			      KBUILD_MODNAME, udc);
 	if (rc) {
-		dev_err(&pdev->dev, "Failed to request interrupt\n");
+		dev_err(dev, "Failed to request interrupt\n");
 		goto err;
 	}
 
-	rc = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
+	rc = usb_add_gadget_udc(dev, &udc->gadget);
 	if (rc) {
-		dev_err(&pdev->dev, "Failed to add gadget udc\n");
+		dev_err(dev, "Failed to add gadget udc\n");
 		goto err;
 	}
 
-	dev_info(&pdev->dev, "Initialized udc in USB%s mode\n",
+	dev_info(dev, "Initialized udc in USB%s mode\n",
 		 udc->force_usb1 ? "1" : "2");
 
 	return 0;
 
 err:
-	dev_err(&pdev->dev, "Failed to udc probe, rc:0x%x\n", rc);
+	dev_err(dev, "Failed to udc probe, rc:0x%x\n", rc);
 	ast_udc_remove(pdev);
 
 	return rc;
-- 
2.33.0




