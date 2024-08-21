Return-Path: <linux-kernel+bounces-295648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD20B959F96
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63DA71F24102
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0C41B1D6B;
	Wed, 21 Aug 2024 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="LrLPFR5y"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1918418C348
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250018; cv=none; b=ghb+Io4T9bIsxX74mZrFTgLKe33ZO84grpL7oZ/+EfSMn7sM3eGARlBh2guWtYctkW1SclgW9d2Vw2443WhjLimU8bVkVhOzrnjsIuCbDmQGQVlQ3jbR73qlduEDX7wSrXeBn+tYQTZeY3BMn+OmBN+79/WjQL3z5aZykMvQjck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250018; c=relaxed/simple;
	bh=CxPKgSGx6WVZyXbXmlDpgI4pCqLO/ikBL3E9su18Ey8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MkJ8WU8Zh3DS49wTofPRWayaQ4sUqWxuh/G36WjHx7Hwb7XBCnLzVZiogbMuzX8S6RwMN/nH3txn6pxpqOe4Y/DOCXR557ydLjxzQwVgcfGDhpaPlm53We2vtWFweGioJuXUDmT1NCuIPyXlAo0avzl8iQ6erbn24BRlByuGQSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=LrLPFR5y; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 813651483E12;
	Wed, 21 Aug 2024 16:20:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724250013; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=rH2IExas7+ysZJfgLcAkGVcyYLA/ZokR5nDbTwdEm4M=;
	b=LrLPFR5yv9whUHwBmYMOdVDdysHaNknn/HtPgv/G24fqLMzQCDGurnNyqfC2PRzkkxQtGr
	LAHkBnx4X/nUah3nIeJWY+9321E+kxiCe/lro/OTr7XRtWH/IofFn6M4iAZFre4li2yA/z
	mBs+UUTwkQTs4TS1nOpczpstpZMQwesp1MauyevjVbTlNirw+DOtjzVCsgTxZBJcimGpxN
	+L4p66fQNPcF2u0KiB2y7WRNIiQxrnZ4qwPmf1cx71zFAcWM9KyTIuBdNrlVY+WxbLfFC7
	jVILzdjy2ncaIShBHB46mTJAKdIc9ufx2TpFzqeILGOAMxuESRty3Ut+k9imtQ==
From: Alexander Dahl <ada@thorsis.com>
To: linux-mtd@lists.infradead.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kees Cook <kees@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] mtd: nand: raw: atmel: Add message on DMA usage
Date: Wed, 21 Aug 2024 16:20:05 +0200
Message-Id: <20240821142006.645306-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Like for other atmel drivers (serial, crypto, mmc, …), too.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    v1 -> v2:
    - make info message conditional (thanks Miquel)

 drivers/mtd/nand/raw/atmel/nand-controller.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index dc75d50d52e8..f9ccfd02e804 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -2049,7 +2049,10 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
 		dma_cap_set(DMA_MEMCPY, mask);
 
 		nc->dmac = dma_request_channel(mask, NULL, NULL);
-		if (!nc->dmac)
+		if (nc->dmac)
+			dev_info(nc->dev, "using %s for DMA transfers\n",
+				 dma_chan_name(nc->dmac));
+		else
 			dev_err(nc->dev, "Failed to request DMA channel\n");
 	}
 

base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
-- 
2.39.2


