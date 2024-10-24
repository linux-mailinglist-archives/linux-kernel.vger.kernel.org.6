Return-Path: <linux-kernel+bounces-380017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E309AE765
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15CA81C2106F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81041E32DA;
	Thu, 24 Oct 2024 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOWWJKvu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1C71E32C4
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778694; cv=none; b=UQJEVUUY1nkeYClFdV49hqWlHXFr1VYeOz+BhW0m6Fp81eEifgcqvG3cHBH5WQ9SHWGq5PHy/hs4yO/6w/AHV4j5qtNUoK5XNK7ox6r/aH1gUbu2AvcSH6fBawVMpy0eTiK3LYMduwfgbMnR8qRKkVUJfXNm0p3M4mnG3iONAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778694; c=relaxed/simple;
	bh=bPfOkhab+RdZJQo4Bgv6xEBR2RHMOFXjrb4S0KcA874=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPQ/rPVwN9hScQo13y6SEtoiQdAYVjwY930CfkZVaIfmgnqGCwWtRhVRQj55UA2ugzymf9ieQjONEzdQlcKJWECp5gloWv/Oi0Smf0s4w0VWHT4IoUx67lmZS/I1bs+Kfqv2cC19OWJlhGSZ5PG0AqikvbKP9wgDNfBaOyCOTO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOWWJKvu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729778691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hQSm1B/bBPEQI6fCzkx9lfLG7DkGTIpXzv4hP+8MIq4=;
	b=SOWWJKvuoeGFk+QzIiH782ZuqzlTASGGzGYgJ+60uzzKJFrTp8bjSG6eKgva/4/RKI3t3L
	QbX9jGSaUIQ7/KnIiEKO0YGJeaTZ5qUZC0sqk6rkHmb/IjbwlemAr3Koyuu8WXjtOpqVId
	8ywG44NdLByYnltZMTACVEMD4eKjU08=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-TFTfJAbyOouTY5VK3dar0w-1; Thu, 24 Oct 2024 10:04:48 -0400
X-MC-Unique: TFTfJAbyOouTY5VK3dar0w-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-539fb5677c9so805194e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729778687; x=1730383487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQSm1B/bBPEQI6fCzkx9lfLG7DkGTIpXzv4hP+8MIq4=;
        b=rMPx1/06QuMior5+U8Iy8Wh4Rvu1mMCWC2DK+IQLN/yFuAK7xnzb4acykLPeRh5IAl
         UUvfXwCGad+5dHCRT9PqRdN1Znnwc0hVabjN1LsrtGBvIyYDH4jmbyzG6d9Bz2+CJlDr
         Rp8mQtdJpIrKsQoZ5Uw5y1qvD4UN2k+jNmMsZ0onYd6w2E2YrOQTEF9g1bjhFHuvEIof
         +/ryGLbVcvW+OlAhum0QxiCsAEdDMq6zcnubslUwug/gtz6hedEPwcBW2LhbN6hO16BV
         3xOz+Uo8fNvzS0NNROS6MACUlBGl/os4Dy0spuPBjxPjVPNUEByd8f87RoX5fR9awZaN
         YadA==
X-Forwarded-Encrypted: i=1; AJvYcCVI9lW/gvZvGvOsDRgIlHrMFJJWk9+IKtFq90STjd5M+S0nx1UN/dFudrG9KtxTKDNAk7hUfk4ica/DzEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyticTNqSgStV5VJw2lU2TAwEqA2nJAAUsZkoV0GupPtBKNE/V3
	u2XMdv98pCQYfBLw26d0KR29GW/97igdbYf43Stm81qXmF6BFhRgCSK5gSc8+n9bdS9xKJpjnTA
	cylo2jK7eAz1jAw29QG/OzNKL3YDS2X8h7zb6QcIBXdnqhtmwfYFuhkgq76KW+GpaI7wGrQ==
X-Received: by 2002:a05:6512:114b:b0:539:f9b9:e6d2 with SMTP id 2adb3069b0e04-53b23e33c6amr1060383e87.35.1729778686858;
        Thu, 24 Oct 2024 07:04:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK+Aa3uTsskL25IZrDrkMj9fVpwcg2FaoD/X/Iae1N1I2ol9nC/eMbTbhx8ycQe9G8SPKiMA==
X-Received: by 2002:a05:6512:114b:b0:539:f9b9:e6d2 with SMTP id 2adb3069b0e04-53b23e33c6amr1060343e87.35.1729778686258;
        Thu, 24 Oct 2024 07:04:46 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bde267sm46655925e9.13.2024.10.24.07.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 07:04:45 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Mark Brown <broonie@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] spi: Replace deprecated PCI functions
Date: Thu, 24 Oct 2024 16:04:27 +0200
Message-ID: <20241024140426.157444-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() and pcim_request_regions() have been deprecated in
commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()").

Replace these functions with pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/spi/spi-dw-pci.c       | 9 ++++-----
 drivers/spi/spi-loongson-pci.c | 5 ++---
 drivers/spi/spi-pxa2xx-pci.c   | 8 +++-----
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 7c8279d13f31..6b8cc26e06f8 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -98,15 +98,14 @@ static int dw_spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *en
 	dws->paddr = pci_resource_start(pdev, pci_bar);
 	pci_set_master(pdev);
 
-	ret = pcim_iomap_regions(pdev, 1 << pci_bar, pci_name(pdev));
-	if (ret)
-		return ret;
-
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (ret < 0)
 		return ret;
 
-	dws->regs = pcim_iomap_table(pdev)[pci_bar];
+	dws->regs = pcim_iomap_region(pdev, pci_bar, pci_name(pdev));
+	if (IS_ERR(dws->regs))
+		return PTR_ERR(dws->regs);
+
 	dws->irq = pci_irq_vector(pdev, 0);
 
 	/*
diff --git a/drivers/spi/spi-loongson-pci.c b/drivers/spi/spi-loongson-pci.c
index 134cda0c13a5..892cf1eba1cf 100644
--- a/drivers/spi/spi-loongson-pci.c
+++ b/drivers/spi/spi-loongson-pci.c
@@ -19,12 +19,11 @@ static int loongson_spi_pci_register(struct pci_dev *pdev,
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "cannot enable pci device\n");
 
-	ret = pcim_iomap_regions(pdev, BIT(pci_bar), pci_name(pdev));
+	reg_base = pcim_iomap_region(pdev, pci_bar, pci_name(pdev));
+	ret = PTR_ERR_OR_ZERO(reg_base);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to request and remap memory\n");
 
-	reg_base = pcim_iomap_table(pdev)[pci_bar];
-
 	ret = loongson_spi_init_controller(dev, reg_base);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to initialize controller\n");
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index cc8dcf782399..e51c1b492283 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -273,10 +273,6 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	if (ret)
 		return ret;
 
-	ret = pcim_iomap_regions(dev, 1 << 0, "PXA2xx SPI");
-	if (ret)
-		return ret;
-
 	pdata = devm_kzalloc(&dev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
@@ -284,7 +280,9 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	ssp = &pdata->ssp;
 	ssp->dev = &dev->dev;
 	ssp->phys_base = pci_resource_start(dev, 0);
-	ssp->mmio_base = pcim_iomap_table(dev)[0];
+	ssp->mmio_base = pcim_iomap_region(dev, 0, "PXA2xx SPI");
+	if (IS_ERR(ssp->mmio_base))
+		return PTR_ERR(ssp->mmio_base);
 
 	info = (struct pxa_spi_info *)ent->driver_data;
 	ret = info->setup(dev, pdata);
-- 
2.47.0


