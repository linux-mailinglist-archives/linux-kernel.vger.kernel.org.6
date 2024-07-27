Return-Path: <linux-kernel+bounces-264027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC1693DE0C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98DCF1F2245F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 09:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACB758AD0;
	Sat, 27 Jul 2024 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4sOGJdA"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA8F44C94
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722071174; cv=none; b=mIpWOfC7TMekGmxLIURKOmhfVrxpIOspVAXesmzpSidF/r2+9kHgXUn67zIkWmOdWGuR6qhXyXHjPxVmml3OJ2CCZOgdLEjNVaxHJMM/ri0NUEpffJmB8NAqkKEGGSH2H6jO2Z4RyVkish2TBKIW1mOF9OM05ywa+vfimSdw9Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722071174; c=relaxed/simple;
	bh=w5cZrFI9Yutg/sZ9EKgpKy/wPnaZGOsNX8b3Qo9cEek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GVU928ypGIEGeZFQ2LBUFe2hcyGOSqx0OLc9rDZeqEF6mzl1VBAhXtKulC/dyAmkad054wCB7acykvgixrGfRqEpowdsVQKwMvVB0xhL2cQgVD00YDZsIji319/rcI2npFMoTIYwtRcmMh5Yxgt3oC8M8xKGfaRP/hXYwYutx+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y4sOGJdA; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3737dc4a669so10604095ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 02:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722071171; x=1722675971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DDq5ocjaHKIoj4uSnGH3wUSyzEmvqPLoYIJb1YiFvGk=;
        b=Y4sOGJdApzCgCs+inC+JqZyBH92OF08GSUFV2cYld5jRZWtzj3A3McjDxlOdFyUUN5
         9mZye6G4s/RGo3XLUku79xbubZmkciWmXyEtekdc7DdlGcM9i883IFlLnQ0zNsMgx6V9
         jWXNGfx1y1cMZJnZipZTfWuYFiZ19DZ0JJm/3KL1P3saWyyPBCrSJkatiUVQghBHdpJb
         vLbqiwADBzyAc6o/C4YeM40Bph8rquiuFD/6AVMzKv7e5nSXzn7ZqOWt6j+8fs4U0tpq
         07D+IWm62QFIWlTUn6UlaNjNYDVclGPlrE7HXSRXgXvYLV1CO1c6tTB4CmAtVYlWvOjL
         Dbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722071171; x=1722675971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDq5ocjaHKIoj4uSnGH3wUSyzEmvqPLoYIJb1YiFvGk=;
        b=vPSIoj9t4rqYa9cAbt4V/vgYfUiPfml+5ycvym9v0MD5Uydonlc6TX9L0Q7tTj576P
         i2ymN2tmLW4RS3tYrGykir1jRMKb68UwIHCBpZ36CLizi/WryTbnSdFlcp5pHToqVYKm
         pY6LA0FJ4h1pvNr86yRnh7Yjtrk1JinVXi6mQ/FBkHzQjOD3Kg/JxuJBu5xVFP5Oo1qD
         RmtnCXz5Qspye+1mbDwKXHLdjzxfmA8/2xshs4v6bOXsyaNlVS/O5lSoB0v4soDlaC9G
         fpZsgsOUcIqTCUJEzB59uDzlDBWTkGQ38+7Gi2gSg6D/VNG14bg9sBsVik2DK24oWzF5
         dbxA==
X-Forwarded-Encrypted: i=1; AJvYcCVwfPeHt3aCdTIfRq47vERjwYuRwyZc1UNTY21RLYDbWZiPTercwOQzY2Xejc0vsDqFqHwvMGdvHH9cXnKZSl9ELuyro2gu4zDnxESe
X-Gm-Message-State: AOJu0YwLUM+YV/w2eDLET3K2OBm5PrKibz34/Hldu6Zvy/KV6jrIZJPi
	ZOLtn6RHJd+2QeDO4THFInRS1+lBSg2P/xZhqwmgYItX9xF9DHnxIzlH0gTmrQ==
X-Google-Smtp-Source: AGHT+IEjSd7a4n6+cb1jZ2TKPL1G+oJtxyUtQYDKIQ0gsJo9nJmeipEN0kjj6m73mgR0wHkSdD4Eog==
X-Received: by 2002:a05:6e02:1a6d:b0:39a:ea20:bf7f with SMTP id e9e14a558f8ab-39aec419d4cmr24055785ab.25.1722071170827;
        Sat, 27 Jul 2024 02:06:10 -0700 (PDT)
Received: from localhost.localdomain ([120.56.198.67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f9fbd4b0sm3449717a12.72.2024.07.27.02.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 02:06:10 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org,
	kw@linux.com
Cc: robh@kernel.org,
	bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] PCI: qcom-ep: Do not enable resources during probe()
Date: Sat, 27 Jul 2024 14:36:04 +0530
Message-Id: <20240727090604.24646-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting from commit 869bc5253406 ("PCI: dwc: ep: Fix DBI access failure
for drivers requiring refclk from host"), all the hardware register access
(like DBI) were moved to dw_pcie_ep_init_registers() which gets called only
in qcom_pcie_perst_deassert() i.e., only after the endpoint received refclk
from host.

So there is no need to enable the endpoint resources (like clk, regulators,
PHY) during probe(). Hence, remove the call to qcom_pcie_enable_resources()
helper from probe(). This was added earlier because dw_pcie_ep_init() was
doing DBI access, which is not done now.

While at it, let's also call dw_pcie_ep_deinit() in err path to deinit the
EP controller in the case of failure.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 236229f66c80..2319ff2ae9f6 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -846,21 +846,15 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = qcom_pcie_enable_resources(pcie_ep);
-	if (ret) {
-		dev_err(dev, "Failed to enable resources: %d\n", ret);
-		return ret;
-	}
-
 	ret = dw_pcie_ep_init(&pcie_ep->pci.ep);
 	if (ret) {
 		dev_err(dev, "Failed to initialize endpoint: %d\n", ret);
-		goto err_disable_resources;
+		return ret;
 	}
 
 	ret = qcom_pcie_ep_enable_irq_resources(pdev, pcie_ep);
 	if (ret)
-		goto err_disable_resources;
+		goto err_ep_deinit;
 
 	name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
 	if (!name) {
@@ -877,8 +871,8 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 	disable_irq(pcie_ep->global_irq);
 	disable_irq(pcie_ep->perst_irq);
 
-err_disable_resources:
-	qcom_pcie_disable_resources(pcie_ep);
+err_ep_deinit:
+	dw_pcie_ep_deinit(&pcie_ep->pci.ep);
 
 	return ret;
 }
-- 
2.25.1


