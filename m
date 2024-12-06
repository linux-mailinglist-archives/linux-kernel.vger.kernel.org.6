Return-Path: <linux-kernel+bounces-435583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A11349E79C5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D4716C16F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557EF2135C7;
	Fri,  6 Dec 2024 20:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cg+Yzfpi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0E6207658
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515478; cv=none; b=MjVEP5eI8SEWg91THhRtybFvu6Lv12LQbp1lVyv/w8FjG3qkwCeycNsPfW7JAe99+EhpD4lldhEqulVogeg9KEstgp16+qBiepjiVy9xX+sqC1ODSWYB0GCZFkytcck+8gDbmc9zU2tV44GIpKoB+hUohLLBQ/PNHF9zgsaaXzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515478; c=relaxed/simple;
	bh=vIG7g6S+y3x8IVVR0Rwd2ra4ixtI7rPHq7MMT+V5aUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mez6L0kDQ/EDaUdrTzgckbPWToB2zZdSBl+tsxd/PW9cJrCHXjhEBy9Z7x19NDS+eiIOnJh6HQ739RIEAN1y37Zw7sT5joiUuZNuMNDhSvad7P1xJjfpuJN06kebJrV/F3H09OywJuX3+9tR23vJkwpLgSXOvxzlay2pxurAoxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cg+Yzfpi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733515475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fMjHOTJ3IG23u1irgURN19CYjdI/G0om6iCqk5PM28U=;
	b=Cg+YzfpiZJLHpEmcnw++E5DLu8Ktbvp36/nbc3MTzYxQifLOpHuLtUyey1Yynu0zhjpQvN
	/+9vEIR8sZ91hnwVM8xZhXUaQDs8vwTJ7WwIMXczNafWF7kkPC3yLGA4vYZLbUhzkM4RbA
	YZnOhCFJtadz6hwPoQQ2V7t8uJNvZmI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-1vTmg-9QMxmwN6z4g9Tb3w-1; Fri, 06 Dec 2024 15:04:34 -0500
X-MC-Unique: 1vTmg-9QMxmwN6z4g9Tb3w-1
X-Mimecast-MFC-AGG-ID: 1vTmg-9QMxmwN6z4g9Tb3w
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa62da5ef1fso284041666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 12:04:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733515473; x=1734120273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMjHOTJ3IG23u1irgURN19CYjdI/G0om6iCqk5PM28U=;
        b=LvGrYTawL+lWCCXhG8STshreOASie+iDtMnZXm9ubPUBEuAM5n3XJnFGjl4cBTl6yn
         mCQvpr9DWtTZaXOmfuPCoLP9u8xvbzQPdp7InBBSsOcwIfDbF1WmkcK7pn7ZkdkAh/v2
         Wva0kuN+wO9Yy87e9c9/1pXQd95L5r9ph0VF6QTV0B2qM6kl6OonE3w7IqxxeuGZUifI
         vxNPxL0UkLq92DLEgOwUtko4SXP3X2kJ8o+Jx6LSLIovVfib0YlCiE42VtUDrSl2zFgG
         9CaP/kFqXxlPIev/KXGSXfbG0dOc6jL/9nRw0OrDMBCGFRAkzuZmbqio2t+vU2k/Ee1q
         Hm9w==
X-Forwarded-Encrypted: i=1; AJvYcCUHEdMKfzx5bF9bjSGAl100MNRzArFlc2eorYO5Q+/BnwgXlcB8W6k+2h0Rr80I6Nr+4oCYMk1fWvCF2DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMraH3/9BiCI2246mMNlEaxskf+LY9NriqQ4rlkHZ5r9yoZmUk
	RpOoaXZfHVUAjYPzd7ncR4aoDjFSMN7pLiHIjSEsqkBVq+DP2LTr7FRX4n/9s5z1aveLv5LM5Hp
	EdBvYydES1ZH4Fo3+S3SQIRgWfacXV/GHyqerbDImD40knOaaku+lZLVHmOVrZA==
X-Gm-Gg: ASbGncuFiujstvu2i0HVqOLKsk1P1kxdNxVXMi7YxqBwuDJo/SCQ2gCu66TqNikjYqQ
	uxeFCW3X23rTpvZxBuHKa7s1HJnTSvBO8bg+hRCfGBY/a1RiNVBnIIYbiwbDwwv2P3QT9wK3y0l
	Jn9+wZvwV6LHfZOZGI9gbJC018oR+cEXKavXPrIBAR3rvs4FyFSUo20ne54bu4Bh9dB25VsYreF
	+E30xzNG3SLPhE7JDScnJmNnAEK9Lxh0mR5akgoqWz/X6bjgeicPq2Ppnqa31sAjqOve7wCDlxn
	KCnAJZS6Qb1DA3hG1giWtjSMbmb6VNxINIhrtsG+8OTiuX4e
X-Received: by 2002:a17:906:c10b:b0:aa5:3fe7:4475 with SMTP id a640c23a62f3a-aa6203311dfmr900970266b.11.1733515473386;
        Fri, 06 Dec 2024 12:04:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+BQutmvcA0nsCT88Amhm9QkyS+wJzkpWUQDFYNpirUHnJMDP0FLESOGwII887k38IbqsJUg==
X-Received: by 2002:a17:906:c10b:b0:aa5:3fe7:4475 with SMTP id a640c23a62f3a-aa6203311dfmr900967666b.11.1733515472947;
        Fri, 06 Dec 2024 12:04:32 -0800 (PST)
Received: from eisenberg.fritz.box (200116b82da23a00e80f0db59251468d.dip.versatel-1u1.de. [2001:16b8:2da2:3a00:e80f:db5:9251:468d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e9706csm281725266b.71.2024.12.06.12.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 12:04:32 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
	Liu Haijun <haijun.liu@mediatek.com>,
	M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] net: wwan: t7xx: Replace deprecated PCI functions
Date: Fri,  6 Dec 2024 20:57:13 +0100
Message-ID: <20241206195712.182282-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
PCI subsystem.

Replace them with pcim_iomap_region().

Additionally, pass the actual driver name to that function to improve
debug output.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/net/wwan/t7xx/t7xx_pci.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 8381b0dc7acb..02f2ec7cf4ce 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -43,6 +43,8 @@
 #include "t7xx_state_monitor.h"
 #include "t7xx_port_proxy.h"
 
+#define DRIVER_NAME "mtk_t7xx"
+
 #define T7XX_PCI_IREG_BASE		0
 #define T7XX_PCI_EREG_BASE		2
 
@@ -833,6 +835,7 @@ static void t7xx_pci_infracfg_ao_calc(struct t7xx_pci_dev *t7xx_dev)
 static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct t7xx_pci_dev *t7xx_dev;
+	void __iomem *iomem;
 	int ret;
 
 	t7xx_dev = devm_kzalloc(&pdev->dev, sizeof(*t7xx_dev), GFP_KERNEL);
@@ -848,12 +851,21 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	pci_set_master(pdev);
 
-	ret = pcim_iomap_regions(pdev, BIT(T7XX_PCI_IREG_BASE) | BIT(T7XX_PCI_EREG_BASE),
-				 pci_name(pdev));
+	iomem = pcim_iomap_region(pdev, T7XX_PCI_IREG_BASE, DRIVER_NAME);
+	ret = PTR_ERR_OR_ZERO(iomem);
 	if (ret) {
-		dev_err(&pdev->dev, "Could not request BARs: %d\n", ret);
+		dev_err(&pdev->dev, "Could not request IREG BAR: %d\n", ret);
 		return -ENOMEM;
 	}
+	IREG_BASE(t7xx_dev) = iomem;
+
+	iomem = pcim_iomap_region(pdev, T7XX_PCI_EREG_BASE, DRIVER_NAME);
+	ret = PTR_ERR_OR_ZERO(iomem);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not request EREG BAR: %d\n", ret);
+		return -ENOMEM;
+	}
+	t7xx_dev->base_addr.pcie_ext_reg_base = iomem;
 
 	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
 	if (ret) {
@@ -867,9 +879,6 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
-	IREG_BASE(t7xx_dev) = pcim_iomap_table(pdev)[T7XX_PCI_IREG_BASE];
-	t7xx_dev->base_addr.pcie_ext_reg_base = pcim_iomap_table(pdev)[T7XX_PCI_EREG_BASE];
-
 	ret = t7xx_pci_pm_init(t7xx_dev);
 	if (ret)
 		return ret;
@@ -937,7 +946,7 @@ static const struct pci_device_id t7xx_pci_table[] = {
 MODULE_DEVICE_TABLE(pci, t7xx_pci_table);
 
 static struct pci_driver t7xx_pci_driver = {
-	.name = "mtk_t7xx",
+	.name = DRIVER_NAME,
 	.id_table = t7xx_pci_table,
 	.probe = t7xx_pci_probe,
 	.remove = t7xx_pci_remove,
-- 
2.47.0


