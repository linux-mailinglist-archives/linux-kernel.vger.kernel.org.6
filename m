Return-Path: <linux-kernel+bounces-386668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489499B46A8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7BD1F23F36
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7468204F71;
	Tue, 29 Oct 2024 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lM7UPgnP"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F68204940
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730197368; cv=none; b=ttlhs9P9/cHPEFoQrjKwYX+IwlIldZEh3nvkMFL61r+i5Wz67Igo0ujSt3uF16P/40+o+/dWVux6o7zL6oh2SBfohZ2BDILYM3H/w3XsdEfnWG9kU3ofj/0/HJARQm+b7Fg1vWYnUsMLd/8edLKL4BkwGg1kfayqzcx0kwCovLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730197368; c=relaxed/simple;
	bh=LZjSpjIkQ/UIhxxD/94ZpTpj5VLNNB8ZWHzr8wWRiEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYclt1NEBJ0x7z5OCwbVOrh2uzlHYjhCyiQ/B0u55xBRY848WzpdE0QofSANHlWQckWtJ2Miobme0BKRjsmW++DW/uUfWyN8r1W/6aOYOhWgW5l25aX0NiSal0Z709ZqYMpVlrWStUSl5VNrrMJBQTi1SZvYp2Wh+fgEMYaPLRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lM7UPgnP; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so45143051fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730197364; x=1730802164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gevxWDiw1Joa8obRCekHXlX/q8pa3Bd8D6cgQBHwmVE=;
        b=lM7UPgnPnJFAyDN07DEjbtKs6tkr0eJkya3uCIIvD1Jv6HcQ8iUdqnlrFOLgVsicn5
         7EJjs5lZEIbjAuDfzbKgNfJhVktBWH5IInKNMO5OgVnr7JHlDcCps7PP7vU8CSiCyZ6g
         y4gCWKV20SnVbnMYyljeqc4tf/TN6p3J/0SlL0xaGbXouqC8HIW2m1owDqb6cckFHVaU
         90NA4ulOtCpkfepn0mYpry2Op/8WSErBF/qzIo3hwXsBVIVpxZTl833yRA+A/hZmu/6W
         +6QyJnuK2kDvh4xht9+QTavWlmNYjg5Kvv59DvnUlNL3Znon5lM9lVy8zgfMMADUMm66
         wYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730197364; x=1730802164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gevxWDiw1Joa8obRCekHXlX/q8pa3Bd8D6cgQBHwmVE=;
        b=wrY6tmp9xphAl778/AZqa2xAXfJlKRIzQpQihhSLtRuqY+RnowfA7+/hbYZ1jYYDC6
         0RV2E9ePui7f2CxyjPt5TyJzZ+gddrlcadK5PjAyHPgziZO7q2Rj0acCZwtpSpb5HqGG
         ZCNZYN18op87OJ1llHF4Cx5ON4Vc120PSOt04hCawfj+C+omvZYXKrZgl9tnwvvpuDlY
         4iF1fIwhh7pNAYTNJKdp298LNZ8eDV+L/o3nhDUa3ZMH+qQVSwmzEnvqWC8ZjZHsD5kW
         r6qRuc4LYOzOxr0nfwIbu8MMfmdgvgXv4LZ9oafxdas+pRWEhVKO94H33z3FmOOBEYMG
         nNOg==
X-Forwarded-Encrypted: i=1; AJvYcCXNdOvTFTd9k3/siagmkkDXnEP8Uby0YJxvDTR3RxkWK4lteG0saEBn5BhaeCPrKohvM6MRh9ICWenEJsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUoU3fwv4mj65xo8BylnNq+980oM8UcbQMgNnMKnFm/WNrmiJ3
	ccGBWitpqSeDvZG7LkecJz5CkJ0428HvxG3oSnWq0zhPbpQo+m7yah24r59joao=
X-Google-Smtp-Source: AGHT+IFpXeHjBYJ4bh6c/28VpHHP35QvCnNGUuPqWzvC/md0zxhyDDRH72iKNBCLUTiNRx10pm7VKw==
X-Received: by 2002:a05:651c:551:b0:2fa:e658:27a1 with SMTP id 38308e7fff4ca-2fcbdf68ff0mr50076231fa.5.1730197363921;
        Tue, 29 Oct 2024 03:22:43 -0700 (PDT)
Received: from tudordana.roam.corp.google.com ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b47a86sm12084498f8f.53.2024.10.29.03.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:22:43 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: peng.fan@oss.nxp.com,
	m.felsch@pengutronix.de
Cc: pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [RESEND PATCH v4 2/2] mtd: spi-nor: support vcc-supply regulator
Date: Tue, 29 Oct 2024 10:22:38 +0000
Message-ID: <20241029102238.44673-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241029102238.44673-1-tudor.ambarus@linaro.org>
References: <20241029102238.44673-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Fan <peng.fan@nxp.com>

SPI NOR flashes needs power supply to work properly. The power supply
maybe software controllable per board design. So add the support
for an vcc-supply regulator.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
[ta: move devm_regulator_get_enable() to spi_nor_probe(). Add local dev
variable to avoid dereferences.]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
v4:
- move devm_regulator_get_enable() to spi_nor_probe().
- add local dev variable to avoid dereferences.

 drivers/mtd/spi-nor/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index b6f374ded390..29441f2bab5d 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -17,6 +17,7 @@
 #include <linux/mtd/spi-nor.h>
 #include <linux/mutex.h>
 #include <linux/of_platform.h>
+#include <linux/regulator/consumer.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -3576,7 +3577,8 @@ static int spi_nor_create_write_dirmap(struct spi_nor *nor)
 static int spi_nor_probe(struct spi_mem *spimem)
 {
 	struct spi_device *spi = spimem->spi;
-	struct flash_platform_data *data = dev_get_platdata(&spi->dev);
+	struct device *dev = &spi->dev;
+	struct flash_platform_data *data = dev_get_platdata(dev);
 	struct spi_nor *nor;
 	/*
 	 * Enable all caps by default. The core will mask them after
@@ -3586,12 +3588,16 @@ static int spi_nor_probe(struct spi_mem *spimem)
 	char *flash_name;
 	int ret;
 
-	nor = devm_kzalloc(&spi->dev, sizeof(*nor), GFP_KERNEL);
+	ret = devm_regulator_get_enable(dev, "vcc");
+	if (ret)
+		return ret;
+
+	nor = devm_kzalloc(dev, sizeof(*nor), GFP_KERNEL);
 	if (!nor)
 		return -ENOMEM;
 
 	nor->spimem = spimem;
-	nor->dev = &spi->dev;
+	nor->dev = dev;
 	spi_nor_set_flash_node(nor, spi->dev.of_node);
 
 	spi_mem_set_drvdata(spimem, nor);
-- 
2.47.0.163.g1226f6d8fa-goog


