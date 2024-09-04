Return-Path: <linux-kernel+bounces-314953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBAA96BB6D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40E3CB255D2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89001D47AA;
	Wed,  4 Sep 2024 12:00:26 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9186E1D094E;
	Wed,  4 Sep 2024 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451226; cv=none; b=iG7W97sayLQuTAAYm8+k7auAg0OrtjSgjYKgs3vtsTa7URB0vJWYDJaxJIpeft8dFWxNRNaH30hm/n7yAAJ7CbknBH1tdM5ZbRw6SZYu+cAXmWXepYgE5E+73RpO/JQ7MkKyrKsCk1JLBBepRGcugzAOKZ0DEgHBBNaSmn+hk0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451226; c=relaxed/simple;
	bh=+LKAWV+yd6HYMK8m16dXiMcOrMNreTXUOH3UUbaBXts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dp2wUH2c8QDC+/nsZp/lEnak5xXz8IosNxCclrmiurq/BjRwzNSyhGcClky7oF7JDxA2Rqt0HFIBzwSpTC1DpPBkyZyjpoHrg42xluYyMDbMRrWYZVYLQv4of3l4GNCY3fSjtbN1Arpxh1J8BZ/RgONyNzbFq3k6oyvxTz6rjv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee866d84bd1190-211c4;
	Wed, 04 Sep 2024 20:00:18 +0800 (CST)
X-RM-TRANSID:2ee866d84bd1190-211c4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee966d84bd1b7d-29021;
	Wed, 04 Sep 2024 20:00:18 +0800 (CST)
X-RM-TRANSID:2ee966d84bd1b7d-29021
From: Liu Jing <liujing@cmss.chinamobile.com>
To: patrice.chotard@foss.st.com
Cc: andersson@kernel.org,
	mathieu.poirier@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] remoteproc:remove redundant dev_err message
Date: Wed,  4 Sep 2024 10:09:49 +0800
Message-Id: <20240904020949.11193-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_ioremap_resource already contains error message, so remove
the redundant dev_err message

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
diff --git a/drivers/remoteproc/st_slim_rproc.c b/drivers/remoteproc/st_slim_rproc.c
index d17719384c16..a6e50f51c794 100644
--- a/drivers/remoteproc/st_slim_rproc.c
+++ b/drivers/remoteproc/st_slim_rproc.c
@@ -251,7 +251,6 @@ struct st_slim_rproc *st_slim_rproc_alloc(struct platform_device *pdev,
 
 		slim_rproc->mem[i].cpu_addr = devm_ioremap_resource(dev, res);
 		if (IS_ERR(slim_rproc->mem[i].cpu_addr)) {
-			dev_err(&pdev->dev, "devm_ioremap_resource failed\n");
 			err = PTR_ERR(slim_rproc->mem[i].cpu_addr);
 			goto err;
 		}
@@ -262,7 +261,6 @@ struct st_slim_rproc *st_slim_rproc_alloc(struct platform_device *pdev,
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "slimcore");
 	slim_rproc->slimcore = devm_ioremap_resource(dev, res);
 	if (IS_ERR(slim_rproc->slimcore)) {
-		dev_err(&pdev->dev, "failed to ioremap slimcore IO\n");
 		err = PTR_ERR(slim_rproc->slimcore);
 		goto err;
 	}
@@ -270,7 +268,6 @@ struct st_slim_rproc *st_slim_rproc_alloc(struct platform_device *pdev,
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "peripherals");
 	slim_rproc->peri = devm_ioremap_resource(dev, res);
 	if (IS_ERR(slim_rproc->peri)) {
-		dev_err(&pdev->dev, "failed to ioremap peripherals IO\n");
 		err = PTR_ERR(slim_rproc->peri);
 		goto err;
 	}
-- 
2.33.0




