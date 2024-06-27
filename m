Return-Path: <linux-kernel+bounces-232529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EF791AA68
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A581C2177D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CFE19923E;
	Thu, 27 Jun 2024 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="lYsxCrW4"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5188B195FEC
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500684; cv=none; b=kBjuBrWSAJo+GTa9xl6Gf/6jM0fEDbNwRoTb71swVZhE6X+fQFCL5ShnQdqnid5XWnbs55rMk3kInDE09S84G37Gq137oSwRuF2frfuJUP6nwWA0KNuZO4h6Ywqi+KvxfKg7p92RSJOmYRV1V0UthPMgzzG/pC3rp2XLtXvzrjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500684; c=relaxed/simple;
	bh=p5CJPkIQTWB8uzvXru7xjOtLt2s3gbP3ldoTOznVVpY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I+CHUX/pyAwnk0WB1je+VMi+vvWZLZmtuKq3IVdEICpASmQmYgJDxeOHfMyjwZ9dgzVcUyz1KokcuJLgbJIKEVE7M6wx0kcg61iis7Lrt+lCju5+gycY+L8juY2ZiwLHNybATcSEJkwqhc1QnngZNHBvjxNqBNmSt1NWsfZ998I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=lYsxCrW4; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57d26a4ee65so1666107a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1719500681; x=1720105481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kKU0V25b+NdpL5Nxb/CadexmGEKpxevd8xM2vqH8ko=;
        b=lYsxCrW43swsIQ6jMsxXCbVFBtpURKrde5fmyTJaugN/IeZesSHFFW9AeFq/iq/U1C
         OkxtGv2Dtn2sJ/BcNbyQkoyC+jO3A0KJJZRV8bYxAdjBt75POtBKPeiCjT1AMxgHsbwh
         L713vU0f9U+qAOeApLcw5YmSO+w1CYaJoLeNRimKv92ht34/pOHsP8hXIEgLnHhS3KdW
         ASIXYgwGCpd7RQW9e7v+l2356VO4iaGo/9+wMr1VBq8acVD5wariSNj9mYjAQK4Me5qz
         xhI3O7SHGZ7hbdihL7IRnekqAodnf2fwa2jteHBSn2wFkYhagaj1xasnq+I9rxiiVRGL
         ayhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719500681; x=1720105481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kKU0V25b+NdpL5Nxb/CadexmGEKpxevd8xM2vqH8ko=;
        b=KeZyNHLbNIOlOqyI7qll2/aBoMcy9Ffw4WK09CDhJPoAtBrfZRfa9s2oA/EhzjzxIA
         wXPsGRrAFLDAvqKEulBgjJLxhbGcFtaFYVPfnEUcqOfP/RGgdbpZwOdgqsOUMSH2v2JF
         ZziCqfNNIqMNAZRBFP/g9+z1uhPvmfIUJEEnP3FScHSN3Q9k+CBjbYINWGhof+OD412X
         JuCtAju+1cA4+NKZiSUe+YqUg3L3jGbVoIiFwsnQnEqVMZQpUeBuDrnSQxF6JuJSAdhW
         v7mNmb6vWdwXBqfTxzSw0kEK/cO+8hhupp+JJO/JkzkA1dmJkk7jc9529soNVN4cGg2d
         YWbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkiDAuhTOxKH8DjdeqfM2/v8IoO/2lIB5V+vUt2Q/3S7qt7QPfsbUhrbiKqKjPf5dpUnAX8XMvIi0C4uPd53E2Y5qRCWkc3qwrjKZv
X-Gm-Message-State: AOJu0YwbyNkqV8ftlbaSjOyI0MMb+dppLwQcggbHCPdfImkotOq7RLob
	WoY3hXxM2Jn7ZqVAbwzsNfTVpOEbgeKIIdwd5kZmIzDpmCynXtrNWpUHx0OGmEM=
X-Google-Smtp-Source: AGHT+IEDRv7diooeJV6LJXwf0EjCsVi9YKqxuCA0IYC1Rui0S1k3Zcq9kDuWbuWeuGO8t2Iv/ci0ng==
X-Received: by 2002:a17:906:d509:b0:a6f:5192:6f4d with SMTP id a640c23a62f3a-a7242c4dfd3mr693613366b.8.1719500679193;
        Thu, 27 Jun 2024 08:04:39 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d7ca289sm67189066b.222.2024.06.27.08.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:04:38 -0700 (PDT)
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
	Michael Ellerman <mpe@ellerman.id.au>,
	Chancel Liu <chancel.liu@nxp.com>,
	Corentin Labbe <clabbe@baylibre.com>,
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
Subject: [Patch v5 10/12] mtd: rawnand: lpx32xx: Request DMA channels using DT entries
Date: Thu, 27 Jun 2024 17:00:28 +0200
Message-Id: <20240627150046.258795-11-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627150046.258795-1-piotr.wojtaszczyk@timesys.com>
References: <20240627150046.258795-1-piotr.wojtaszczyk@timesys.com>
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
Changes for v5:
- Added fallback dma channel request for backward compatibility with DMA with
  platform data instead DT

Changes for v4:
- This patch is new in v4

 drivers/mtd/nand/raw/lpc32xx_mlc.c | 26 +++++++++++++++-----------
 drivers/mtd/nand/raw/lpc32xx_slc.c | 26 +++++++++++++++-----------
 2 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index 677fcb03f9be..92cebe871bb4 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -574,18 +574,22 @@ static int lpc32xx_dma_setup(struct lpc32xx_nand_host *host)
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
-		dev_err(mtd->dev.parent, "Failed to request DMA channel\n");
-		return -EBUSY;
+		/* fallback to request using platform data */
+		if (!host->pdata || !host->pdata->dma_filter) {
+			dev_err(mtd->dev.parent, "no DMA platform data\n");
+			return -ENOENT;
+		}
+
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+		host->dma_chan = dma_request_channel(mask, host->pdata->dma_filter, "nand-mlc");
+
+		if (!host->dma_chan) {
+			dev_err(mtd->dev.parent, "Failed to request DMA channel\n");
+			return -EBUSY;
+		}
 	}
 
 	/*
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 1c5fa855b9f2..3b7e3d259785 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -721,18 +721,22 @@ static int lpc32xx_nand_dma_setup(struct lpc32xx_nand_host *host)
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
-		dev_err(mtd->dev.parent, "Failed to request DMA channel\n");
-		return -EBUSY;
+		/* fallback to request using platform data */
+		if (!host->pdata || !host->pdata->dma_filter) {
+			dev_err(mtd->dev.parent, "no DMA platform data\n");
+			return -ENOENT;
+		}
+
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+		host->dma_chan = dma_request_channel(mask, host->pdata->dma_filter, "nand-slc");
+
+		if (!host->dma_chan) {
+			dev_err(mtd->dev.parent, "Failed to request DMA channel\n");
+			return -EBUSY;
+		}
 	}
 
 	return 0;
-- 
2.25.1


