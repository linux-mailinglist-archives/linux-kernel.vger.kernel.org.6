Return-Path: <linux-kernel+bounces-223259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2F391104B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CFEF1C24100
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F5F1BBBFD;
	Thu, 20 Jun 2024 18:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="O0Uira2h"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7A01B47D5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 18:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906432; cv=none; b=C+PPJvolhxwQcbr7RelV9ACv9qdOI+D9cyl2KBT/gZg4uMBgOn59mbnkKmOJxhLai3Fc2uFwfptFHeD+zv6H4mSbQCxMas65u6f7UCPJJY4d/sx819jMJQEfrHiXiIWlHNljPON12tNZO5/EXIiPWsbK+4AVRTo9jpiLXwpFtuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906432; c=relaxed/simple;
	bh=6sE8+DXCGSp6H4fp7z/fe9qbBtCAiv4r4DBp6uCAyRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=szwTi0RLkWpdbi3XEzhcajMGldeCu3S28kjyq0kbvxbp+QR0hIDLLmS1tRoGKmX9CM1eeRR9NVeHNUPc2Upsf7pG+wIqDgdOSaSD9kQbLOm9GOjzrVGqWTFVk/ZXv1KE1NaoY5W4UgeL2XAHNxrLPHzepmyCMxIaszHDu9jQY4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=O0Uira2h; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52c85a7f834so1550382e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1718906428; x=1719511228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVPBRJfKHWyc96AOmdAfEJ3BssO+zu7Jq4tEfUKaFJs=;
        b=O0Uira2h/0BWoXwR/9PQl1ZPb3GhlNsGDHduq7IPiesCpqVtxGL62huQi3qKTwatE+
         DK9xn6j4nST56aLrM083hG6trthFx53Omyy/RODp4FJlsEnPcxfE4NGXJ4C1fy8mt99x
         M4GPKy9rkwKxyRGWuEKbtp/m1pKQdU14MD0GIS/ifHJGWw/cbtrgu+E5FKkB+ka0KazI
         bcwuQDIg8ipxRXhCA0+pojtR3XXrsEtuhQ3lgqnzCIxVqB3iuBk2lmuOkCgNcvogsa/e
         GpMMc9mWEvx1FQNHI66INd0jn72aQb/0aml/muX/vHBXMglBCrgJjpOCLR/oq7xp1sLu
         clvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906428; x=1719511228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVPBRJfKHWyc96AOmdAfEJ3BssO+zu7Jq4tEfUKaFJs=;
        b=ihQl+AoyQdSHE9Iw49Dna5tstBdUx9WQsID8JFjN79864SoazEeR5g23mkozu3ZwmG
         ooV0Xex8St7UX0IjuZd59LkiGeOIZAg8wd1BlzquX9FtK2k3QkJ0vKehHtKQckacdJQS
         S9XhXTELssMSD4t6bSE5o+0GFXc5muT8Z8nwNCiczFOwhRMSwx4ia9FARjEyJbuqsAM9
         uVP76xfS6/MdGljLqbwPYA49ABmTqr76VUvhRsJHMxwRFLoyYi49e34kGEoq9HpW80M9
         pJaxYcLbg2VsPbXHGVqiu4Pyxkei2LZVmAbB7aNXzCOpJwM3Vw6i5eebyPDmNCg8RYcV
         cOfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIpz930ybMJGLaWKA4XWxAV9MwAJCjNVYvctx/j/TykQXbJ7FKdxJXy8QvG//Eg4tn31KitGqYcRRYvX84BFsLXUf5PupPW55l4UBj
X-Gm-Message-State: AOJu0YwVsWdT61tYEIP0ywBeqS6H2yM7SdS/ytfzUC26Zll11FPVFeTI
	ejTxehxqbP4ui8JKNZfPfyhouNJ1byiqhsO/qGNcayitm0tWV/9GNMNGYdr6jk8=
X-Google-Smtp-Source: AGHT+IFVaUnSlA61/1PdUe+3ctCyCQUmvx5dNR8/UMkHsGGn+PNCWFlaBmoRzTkawVAPhFlr29t8ZQ==
X-Received: by 2002:ac2:4466:0:b0:52b:f2ab:1303 with SMTP id 2adb3069b0e04-52ccaa5bd8dmr3307793e87.28.1718906428467;
        Thu, 20 Jun 2024 11:00:28 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f42e80sm781370766b.186.2024.06.20.11.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 11:00:28 -0700 (PDT)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"J.M.B. Downing" <jonathan.downing@nautel.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Yangtao Li <frank.li@vivo.com>,
	Li Zetao <lizetao1@huawei.com>,
	Chancel Liu <chancel.liu@nxp.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: Markus Elfring <Markus.Elfring@web.de>
Subject: [Patch v4 08/10] mtd: rawnand: lpx32xx: Request DMA channels using DT entries
Date: Thu, 20 Jun 2024 19:56:39 +0200
Message-Id: <20240620175657.358273-9-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620175657.358273-1-piotr.wojtaszczyk@timesys.com>
References: <20240620175657.358273-1-piotr.wojtaszczyk@timesys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move away from pl08x platform data towards device tree.

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---
Changes for v4:
- This patch is new in v4

 drivers/mtd/nand/raw/lpc32xx_mlc.c | 10 +---------
 drivers/mtd/nand/raw/lpc32xx_slc.c | 10 +---------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index 677fcb03f9be..e504e3c5af11 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -574,15 +574,7 @@ static int lpc32xx_dma_setup(struct lpc32xx_nand_host *host)
 	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 	dma_cap_mask_t mask;
 
-	if (!host->pdata || !host->pdata->dma_filter) {
-		dev_err(mtd->dev.parent, "no DMA platform data\n");
-		return -ENOENT;
-	}
-
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	host->dma_chan = dma_request_channel(mask, host->pdata->dma_filter,
-					     "nand-mlc");
+	host->dma_chan = dma_request_chan(mtd->dev.parent, "rx-tx");
 	if (!host->dma_chan) {
 		dev_err(mtd->dev.parent, "Failed to request DMA channel\n");
 		return -EBUSY;
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 1c5fa855b9f2..f83a31411bde 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -721,15 +721,7 @@ static int lpc32xx_nand_dma_setup(struct lpc32xx_nand_host *host)
 	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 	dma_cap_mask_t mask;
 
-	if (!host->pdata || !host->pdata->dma_filter) {
-		dev_err(mtd->dev.parent, "no DMA platform data\n");
-		return -ENOENT;
-	}
-
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	host->dma_chan = dma_request_channel(mask, host->pdata->dma_filter,
-					     "nand-slc");
+	host->dma_chan = dma_request_chan(mtd->dev.parent, "rx-tx");
 	if (!host->dma_chan) {
 		dev_err(mtd->dev.parent, "Failed to request DMA channel\n");
 		return -EBUSY;
-- 
2.25.1


